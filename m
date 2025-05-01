Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1CFC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 16:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1696C81E72;
	Thu,  1 May 2025 18:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZBwPipPh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C9418210D; Thu,  1 May 2025 18:47:29 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEC6781F0B
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 18:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2c759bf1b2eso798502fac.1
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 09:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746118045; x=1746722845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K1gpp2yXg6j+WOU0C+J3ZrvDY5GCdQ9OjEowbZpZoIw=;
 b=ZBwPipPhzmt1EUQdqr/olSFwcMnIUXXmaTc5U53LGdI6N0zBO3musTfNRQKmoJ5sbH
 V9MUVLPVDP2Ja6fWUdH25BcIC/3o/gxFegv6UkKCI2KiF2TmkOxmmnDRKLmBf9DiyQLB
 dOG3IJRiHBLGblHS8ALYcj49Uarqn65zDr7yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746118045; x=1746722845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K1gpp2yXg6j+WOU0C+J3ZrvDY5GCdQ9OjEowbZpZoIw=;
 b=mDXjdbjaHkl6liVOWfcF9eePe9RSoBPbndOwks0GtZ8et0S1/WAVrVWPda76JjIMbh
 hgd3eu4SVI1jHzeRQcMRwUPNtx/Nt/0N3wWw47YDDuGZmMBUfGZdu+swSZoitUtzQ21Y
 /CLPOgL277VWZ2+PrwNHUCPvemOOVmuVBQKOEFnr6ZhIPbXlh9oEjhqp250gXJB+RP0C
 HOi/+7RBD7QpP5oaTtQ9sUDaoD8dnxpxXxm75kqQrJKUn3ZH1xAwJBJiFHkTi+Qh7G3U
 8ryYkDkEyxJn8kpBZAgFXXH2foUa5QAxtr+rnCRBQCplZg041UsZWf6XpQud45+tGgu/
 +YvA==
X-Gm-Message-State: AOJu0YyLQ01oCMA3pkPqPQzWnFZOqvFaHZxY36SoCuc9fixfAPEroxkN
 h3t0669Wg4OCg51fVIn6FEQKQz6TEqlK1f9HTk4ANkiBIZLTosptLxMq+2VD6lcs5XT/NKIL3Rb
 n
X-Gm-Gg: ASbGnctXe23t13IAr6+5q0Ibpn6Xy0MfSh4KiVlu4B3cDGZHhpNqGLXTSi6lDp3AwoS
 6cwFnWVR2i9wsul2g5YjinIyahdy08S30sWBtoSftUbUiOYt1rC2S9tgLMIDNWePT/lUtJftLK5
 RiKsBa6LrPfoKoYPCZLN+DDHXGSP8ow7Zm0AmA9sQdIQ45yLxATFTPQ/Kud6sVqgjlMDQap8VsS
 gnZR2BtDOHpKBR4PUkd2IS9XHS4Wrv5jBnn+V+XgHh/s1BI2DYJ80PqwnpRpCearITCd4dQ1VvM
 HDgfAnvX2130FsuNur056Z4YMSPuMaCYXz7qSza1p5eEYaQf0HhXIuY/7aQKJcKnM8BJAcTuZvv
 mv3AD
X-Google-Smtp-Source: AGHT+IFFCanZCubUM1XyhlDpkQNPfBDh/LKJ3rM6cBPFzRz/Taw81dUh2FrrTjF/NPvTEsz2cWHTOQ==
X-Received: by 2002:a05:6871:2886:b0:2c1:a810:d697 with SMTP id
 586e51a60fabf-2da93187e92mr1998782fac.15.1746118045568; 
 Thu, 01 May 2025 09:47:25 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa1207425sm193656fac.39.2025.05.01.09.47.24
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 09:47:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/4] fat.c: Add missing include
Date: Thu,  1 May 2025 10:47:20 -0600
Message-ID: <20250501164721.1494370-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501164721.1494370-1-trini@konsulko.com>
References: <20250501164721.1494370-1-trini@konsulko.com>
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

This file references rtc functions and implicitly includes <rtc.h>
today. Add this explicitly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 fs/fat/fat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index e2570e816768..89f2acbba1ef 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -21,6 +21,7 @@
 #include <part.h>
 #include <malloc.h>
 #include <memalign.h>
+#include <rtc.h>
 #include <asm/cache.h>
 #include <linux/compiler.h>
 #include <linux/ctype.h>
-- 
2.43.0

