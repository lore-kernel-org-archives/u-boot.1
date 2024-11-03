Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B6FE67816
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A4D2892EF;
	Sun,  3 Nov 2024 01:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P+pd7T1s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD91A892EF; Sun,  3 Nov 2024 01:37:07 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92A8B892FD
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20c8b557f91so31880325ad.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594223; x=1731199023; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIXCGkn24D5NedgufXfJ/+lgpVoclNjfjstmsmoRbh8=;
 b=P+pd7T1szVRUkHIRHvlWCZLuOakufGW1MvlCJ4bIbNjhGue/5z5ebr8Oo4A2opGSQM
 bIFN4AjuOXMNJ/Zpb/IdKu8P5utDl6Cu/snz1XAwPwYqfGj+ESgPf9ecw7WTE/dlpjVI
 LXXY7bIiuqJquOaSLrRmu6WivI6XWb0ovLrSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594223; x=1731199023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIXCGkn24D5NedgufXfJ/+lgpVoclNjfjstmsmoRbh8=;
 b=YSrZ4C+SyneoOQj1E1TckmzyXe+xOubz8BJPsBenyp+KV0Da+4mwhUm6oEtzaZXRWL
 dzp7dpbHrOSsaq6dq7pY/icC05YTFwKzes8HdLGFhMzJkRzcWmfazYDBJKxfsLj8uj8D
 2RniwcBglXhkgE1IoNggLTwh9HWfOEC3YtdPSte6fSGlEX8PhD7WmmQinCEMqFfVJ/dj
 SiFwUoOGesrWJqbNa9Jgq0TKYoF2Cx8pvtwGPWkopHIbWCAUFqUv3pI70j1D2lDuK5f2
 +tT8MVd0PQbxa+HBTyZ97NpGRvFoNWO3Zr/TP15jVlvJ5JCUXWgnfgB2aL6sg+/kN3o5
 XKSg==
X-Gm-Message-State: AOJu0YyNtAhrRuS6gEoXPhaN7HdBmcVkIg799pinw7I1tgH9C6Q5Bme7
 qKoCYNxBitTtHb/dXUYKEDfi7G36++50KOggZwLshvBw0KWm0DqsNQjANnt0M4g3DP6fH7aRLdD
 Unw==
X-Google-Smtp-Source: AGHT+IHvmv70uFdZvfzeynXi6syQofj2SZViRvQYVJLI/YQ6kC57lsB93DLemnaUqllExKvBIUZ3UA==
X-Received: by 2002:a17:902:c94c:b0:20c:d93c:440 with SMTP id
 d9443c01a7336-210c6c1f28emr366510785ad.35.1730594223455; 
 Sat, 02 Nov 2024 17:37:03 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:37:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alison Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 15/25] m68k: Drop unused status_led.h header file
Date: Sat,  2 Nov 2024 18:33:07 -0600
Message-ID: <20241103003322.626036-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103003322.626036-1-sjg@chromium.org>
References: <20241103003322.626036-1-sjg@chromium.org>
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

This header file is not used, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/m68k/lib/bootm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
index 3dcff8076e3..1fa112f8dbf 100644
--- a/arch/m68k/lib/bootm.c
+++ b/arch/m68k/lib/bootm.c
@@ -15,9 +15,6 @@
 #include <bzlib.h>
 #include <watchdog.h>
 #include <asm/byteorder.h>
-#ifdef CONFIG_SHOW_BOOT_PROGRESS
-# include <status_led.h>
-#endif
 
 DECLARE_GLOBAL_DATA_PTR;
 
-- 
2.43.0

