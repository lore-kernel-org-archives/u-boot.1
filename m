Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44322CEDD86
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70B8F83E21;
	Tue, 18 Nov 2025 14:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R9h+uK/9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13C8283CF3; Tue, 18 Nov 2025 11:42:30 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1194C83C96
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b728a43e410so863064466b.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763462547; x=1764067347;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2wcyADOjb3BHO+ZX7nOd98URXE6E6aYuGJsajX+pYtI=;
 b=R9h+uK/9Yd5/rVB9KILQAXs1qDm4eE0DlXsCmsVC/arJp383qs7+W+lXyBpZt2bES8
 6+7fURogRnSkRhKPbASFfst9hrOLcz0wVfy/Vytod5qowSoGbpT9MGOAk5nJJqaR8hTR
 upUfqGZXmFAOFAcH4uQQ9fBGk5hFq6DCp3AUMgovpP0ll5YhMPtHm506XfX/YaTsay6u
 p3CRyJccszs1Gb7D1sqMeMGae3hqioKd+k0pdescD8ALqrCsjeKupti+gFBxC1DqeB1I
 ldYc93C8eo3KJeMFXhxnETZw8/C8Gyxd2+hKZrNtVsUfzYZGnXVteW05oZCtORlM4V3U
 9PCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763462547; x=1764067347;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2wcyADOjb3BHO+ZX7nOd98URXE6E6aYuGJsajX+pYtI=;
 b=IvK00fRwbARf0WN3tCgDN+lfudlxC1ghaNqHyMjQjavFUjIJyG6GGRx28SIw10I8OQ
 pzU7Vhq+inJv1LDBYL/kkzbL/PXF5BzLuq4+4JOyLn5hEfhlx7FDswdcrPH2j2DDJVCi
 d9/jvGqfE3nH2hRQfNqGOVp7F1knpY/dlJZf5FHRluztUdvECphPiFgiMYCx5Q5Zh9Lh
 Rvb7J+qfRM6TggbmRTbQmXSmy1jSXqGDuG+tUvCffAO3gJFx37z0XKseJTZfewSCNGVx
 lerXARv2F7tiRqqVQp/9SfJQcjyluoHv2w0OD5PDvwlbKO6b5e+YZCEav40CwsueKnAI
 0dCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRWtH0bi0izfj/V2T6oHbSHDlG8MpeV+/fm3uHkLMtwu7X+b6/IVQ4NdFhqVmq/O8j7neOsls=@lists.denx.de
X-Gm-Message-State: AOJu0Ywy9j1icX0RPo7AWFyFm4Xxs5ZMgA6U5VQVuDRs7qFuJdkQqxmZ
 tVBEmwuAm58oZ/67GKwIXRaU6iT7FGdQpc4wZyZmShU89vGqcsqifijM30UiuB/cHQk=
X-Gm-Gg: ASbGncvMdZ68PR8XJy9yrwUBMtkpqpwzGifTNFvqRdKZjxt7LpG+EqYJRLk2HsHj7sU
 wLp/OrKiKZJTqPRtPx0LIwyXKz/3GuZTD9hamoYMsF4KryR7OqxsLI3X7EWhgOYmpyj2M8mmvoz
 DcwsUDDu67vG5njH1kMWtck8WrA0wtmtIAm4r1AGl0Z25ZLsa/jCGjPKQrP0l+pMSHIOTRuPnaz
 NVMY6iQRYuOyAqH4k9e44u2T2xG7zusLPJUJsPjZFFcmgohVFzQGtahTYzF1H6XQXUTIRRkmUsR
 YMnTgwvcrdAZQkXzBocT5JlYeinUwYA0Vmxl0VKdDaabl2Ngsef/tP7hbcAMTbhSFKf4hW0RdIZ
 83UIL7ge6MD+Mcq/KwRpz/6bZPLkvAB2zF0j5SZmrLX00vDWWEm02IiAc0cnjLRlZsoYxxhj09m
 UypHAUo74=
X-Google-Smtp-Source: AGHT+IFbkcsFFCcSaXQs0mI/gCXHC5NvqQQAtuoY7EKRUYj3X6I+1HvEzBubbF3770I2e/ghB2soMQ==
X-Received: by 2002:a17:907:6d1b:b0:b73:398c:c595 with SMTP id
 a640c23a62f3a-b73678add5amr1720806466b.19.1763462547484; 
 Tue, 18 Nov 2025 02:42:27 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b734fad4635sm1324419266b.26.2025.11.18.02.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:42:26 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 18 Nov 2025 11:40:31 +0100
Subject: [PATCH 11/15] am33xx: Fix comment about config symbols
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-am33-evm-oftree-v2026-01-v1-11-91ce13c661e2@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Liya Huang <1425075683@qq.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=msp@baylibre.com;
 h=from:subject:message-id; bh=WqMqHXlFwpIfNU/eINkXrasqXPiaUfz85EYwFgKNdeY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwZ3wwRxtC7j7hjjzIqPnm48p+rzIMdHtkatzLu6HjW3
 0iK3ifZUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABN5x8/IcMth74RP7y4yZ365
 dMMwtvejvtKKI2+Lb5WVe68Ta/VuYmRkOJz/x1PtnEDGLf4NTfO3pK41WDk95av7Up4/czmfnsy
 xYgQA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 18 Nov 2025 14:14:53 +0100
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

Fix #else and #endif comments to match actual #if condition. Comments
incorrectly referenced CONFIG_USB_MUSB_* instead of CONFIG_AM335X_USB*
and CONFIG_XPL_BUILD.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-omap2/am33xx/board.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 4e9ad8935e3b5020c4ed1d022ae4846a2dc9486f..d7db260513308257f142ea70d5d5c643afc920c9 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -259,7 +259,7 @@ int arch_misc_init(void)
 {
 	return 0;
 }
-#else	/* CONFIG_USB_MUSB_* && CONFIG_AM335X_USB* && !CONFIG_DM_USB */
+#else /* CONFIG_AM335X_USB* && CONFIG_XPL_BUILD */
 
 int arch_misc_init(void)
 {
@@ -277,7 +277,7 @@ int arch_misc_init(void)
 	return 0;
 }
 
-#endif /* CONFIG_USB_MUSB_* && CONFIG_AM335X_USB* && !CONFIG_DM_USB */
+#endif /* CONFIG_AM335X_USB* && CONFIG_XPL_BUILD */
 
 #if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT)
 

-- 
2.51.0

