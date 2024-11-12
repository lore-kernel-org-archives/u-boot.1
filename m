Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09BCD42B82
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32E658944E;
	Tue, 12 Nov 2024 14:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IJhUuPEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 661C089467; Tue, 12 Nov 2024 14:59:57 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56B24893C2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:59:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-83abcfb9f39so182087939f.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419993; x=1732024793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=STmcO1gZJFutGe2YJZIPJCm36EQx4SCrHr3aV+Cmcag=;
 b=IJhUuPEZKGk8sa93us/6SCIBHgBUcql/n/bC2E6zRpXRtYNVoxqRpGT9bIiiMVD4fT
 S8v8AHSSfN1yLky4b9ITLgzzjJsFMrD9ctDYx7sA7S8FEvjaz3IZEWPRYJSP1KwFXfbq
 fUvJUgDdgbYvFhT/GcYS+3iIbUciBySnITg/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419993; x=1732024793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=STmcO1gZJFutGe2YJZIPJCm36EQx4SCrHr3aV+Cmcag=;
 b=MD/Si0QrsC5f9v7KvKyMIj7m/UBnGgBTk2E++BwLGFumS6IBNTZPrkE5pn2unD4VRp
 3a4V8gd2l3HrdW4uIdELCjqPMrpvVhprBcqs+pHJvn+C0STL0qaAK2vNszffCbTtW+Qn
 pU2LYB9GM+lRd0kze6lLoi811rQZHA+1IbXsOBzpBSsuLoqnDtHybm35LnWUohZXEYlC
 RbJiGAY+wquWVx1KHuNCCuiqRxDBHAm9BeO5JdGRi526BaIO0s9l9yRo/1Hp9T+Tac3g
 GGGPX9+mrLqAYYQaMGOckZL6ht4y/UGDJy9qiC8RsrbGP55wR1m7pFo2bB3oX3kC4W9W
 BGsA==
X-Gm-Message-State: AOJu0YwYxNMEiBLUfIYE50iKtDFfnc8fP9iiTWVt313AziY/H+T5/Qoi
 zN/XYUR44HA1F3G1/1OtKieeeMZ65Km37PZzXCvJ3OdfaEK6AwaOyj+TXQC+C0KrB8QSnt3rNN4
 =
X-Google-Smtp-Source: AGHT+IGPp6gdeDLM9gZfcnTRcPTMjgk9c5ZXYHRCJLSjPl3g2AbOzcenTrWrkHY2YDARvo3sfTS5kw==
X-Received: by 2002:a05:6602:15cc:b0:82a:a4e7:5539 with SMTP id
 ca18e2360f4ac-83e03403c6fmr1493950639f.2.1731419993524; 
 Tue, 12 Nov 2024 05:59:53 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/18] x86: spl: Drop duplicate CPU init
Date: Tue, 12 Nov 2024 06:59:05 -0700
Message-Id: <20241112135911.630586-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112135911.630586-1-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

x86_cpu_init_f() is called by arch_cpu_init() a few lines below this
code. Drop the duplicate call.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/spl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index f761fbc8bc3..2586a81093b 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -84,8 +84,6 @@ static int x86_spl_init(void)
 	log_debug("x86 spl starting\n");
 	if (IS_ENABLED(TPL))
 		ret = x86_cpu_reinit_f();
-	else
-		ret = x86_cpu_init_f();
 	ret = spl_init();
 	if (ret) {
 		log_debug("spl_init() failed (err=%d)\n", ret);
-- 
2.34.1

