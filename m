Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E25AC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA2B88CB6;
	Wed,  1 May 2024 04:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C7Rghtk9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40CDA88CB2; Wed,  1 May 2024 04:45:54 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D233188CC0
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7f1aa0b69ebso344883241.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531550; x=1715136350; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTyaq1smI+ntdzy07oTQeebIp5my/kl5OICEZPA+PfE=;
 b=C7Rghtk9BT6YOB6QeeK55Upe4baSjv/C1Ia8bkdFtX5G6F9qRtLbCFbSEKKeY+0wVA
 UCckvrSwQFxEV6LDgEYle3hFTGY2CJV5t3UgstV5DdqlX7qSXEoKxRWUZ7K/dXNL+FPx
 sWWGu14THR/kg++ixARK394BVHPHIJZnOHa90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531550; x=1715136350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BTyaq1smI+ntdzy07oTQeebIp5my/kl5OICEZPA+PfE=;
 b=iv0HxhM2RP3WwTJe6xaq04oFJutF5ARBATWO5EETS/ED9v16T633OyCSGBOwhQ3455
 I3CJJhu+ZYfATZDsyUMTP0eWKyt7ksFKtMh6hg0G2XkLuLGNbsOIBMs/GgAS6KSV27od
 WqEXzamymNGowCgYvdTUX1ofpL0bRZYqo6ODfLP2+6TgwWK6JumhgbJn29comq/Lmx83
 bre4NnDHnwlK5ruOPY4OGdaPL/T6iTpCgqrhV+Xmq59HVCvxUZxizVDGu8+kwe3jcHuH
 qqzWEaV3wkm3qSupAMRlrzpktEwDOVCRRLXTM2ANz3ixvSvJelk3CF4HWcJz+rGS2jnh
 QSQw==
X-Gm-Message-State: AOJu0YwdjTdxccWJnJ/TyIGvWYT9V9qXHQd2JJPuCKMD8wf9URFDdciG
 xug+/5ZX9xR3CBbt/gQRMO/wxUMC9Jw3TmaeJrx88T+xegymnIzrzfkFBzqZq8CN4OBTymnSxtG
 qpL+W255y
X-Google-Smtp-Source: AGHT+IH68A+Yk08WaZNlBj7Q40LH6lf35BjRRw7HspUP8lT3cf0i398Vz+0FJt6R5x9MA32iri5kGA==
X-Received: by 2002:a05:6102:745:b0:47c:4e97:4f72 with SMTP id
 v5-20020a056102074500b0047c4e974f72mr1650918vsg.23.1714531550475; 
 Tue, 30 Apr 2024 19:45:50 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Wei Fu <wefu@redhat.com>,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH 133/149] board: thead: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:43:00 -0600
Message-Id: <20240501024316.1767971-133-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Wei Fu <wefu@redhat.com>
Cc: Yixun Lan <dlan@gentoo.org>
---
 board/thead/th1520_lpi4a/board.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/thead/th1520_lpi4a/board.c b/board/thead/th1520_lpi4a/board.c
index 16c3e456b3e5..bb83e7561f4e 100644
--- a/board/thead/th1520_lpi4a/board.c
+++ b/board/thead/th1520_lpi4a/board.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <cpu_func.h>
 
 int board_init(void)
-- 
2.34.1

