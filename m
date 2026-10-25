Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31900606A31B
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OQ/DzlOj;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HpPHBebD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82F1980DB3;
	Sun, 25 Oct 2026 19:31:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6XjNhJvdSNxO; Sun, 25 Oct 2026 19:31:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 18C8780DA7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792956680;
	b=gk7eECJGmsgj+rh3J5t0favPUYkGHz/M4lr0XDvO2AsXPWfkFqDgjCU+DJsgg+FmpJuG
	 aBjoqwMIuVlqkd6pAW7hPc7B2arONharsTaytnxglmRCqMrRd3tiLfkBASQDk5n9Dhnqg
	 htCfuXRjlQ0k9BMmTKg1kvnXqoFpnAsV4ecuY++YNql6REMUgc3giqhFz21Uo6wPL0Ise
	 NSoD9qH4ZcqCb/R+iWdcPK9AHF3W2vBTec2GOvLPtv2dgZwAXcUEgNTRRvg3tV8MDc8Cw
	 1HEErF2vAidCtpF2ZEmNpJmsIVU64CJkeqyZ5UIujKfsl088Fay12eGeKYFMkqchyBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792956680;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=O1gpL8372RFxXQGINcqxnJHbr7Iz1fv72gES+Ch3S20=;
	b=gzQ9OTwUQUBnSrgUG7HXqww6BXO9MEJjYkqvbIgwHG6KZLMieXlHfLwUVj01rweD9WJ0
	 E7QYStiWzRJsW3czCPz+aJ+IOJBWeWKQ/qeoI5WT1oEhgRvnjtM/jAYSfMrpXDodvgP0c
	 2TzLgdMGrsjol1jC1GOH7KLd8cmiYxofzefEcdWwJ4YDy1rMjRAtmQAahsnSPnpLqiRkH
	 hGPduK2KD5ihyWzbHNMVg+zB2YMOLy4wG1Ztv1VXINzjZyvMI5zMfZEyhZtFawX0NT/MU
	 Ti61xM6EkW/n1ex7gEuJZ783uQfyUdIbExIx2XozmSgrsIKi/miQgqxY1YeoS/NQsnw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792956680;
	bh=O1gpL8372RFxXQGINcqxnJHbr7Iz1fv72gES+Ch3S20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OQ/DzlOj7BTeIOGB/JnZ1FljlGMhn3VvNjccopKQQQqSvELyvnHeWPu339kgiINY5
	 4BWrKWEyW+LoU0mlL45ryThFRYCP4GkJRCttCtWDyTMv0rhdKQN3EqInnvT9NWak9S
	 YIQaeYqlnoLAWN5KY8tbIqOLGxUxuM2VBIkEnXFqAxlzUO6mZAB2kFplNdkNVI+6JD
	 JlGJ6XoGXPukLRIGcIiK4bHmF8GUeXqyiXNAXYOANO5SVseL+I/1/+nGqFx69nUA8g
	 1KHsJpGI65S2yhFkKSnzfLAjUkvt97k0DF4UB4DoxuEDOYkorbScv+w2ARisHJMd52
	 BIEcwZ0vaIyAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18C8780DA7;
	Sun, 25 Oct 2026 19:31:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A032C3D9
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 19:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9156360601
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 19:31:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eqKCRQ8Apqou for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 19:31:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9FDEA60600
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792956672;
 b=UjBbwpynndfIeUUVZ3ve7U0WQFdELL1nzZMpHWsCMwmCmkRfj6qxprYDqsc/pLLiM2w1
 fkRnLiFHLyQrDO8AwtNTrn5Q9KvT2GJBfae5WJtSG+7WP5G18ZnbE/Q8C4Wy4eQx3x4MX
 r/V5hcoJWYctHoiVbf91CLxugUdOSF4V1EJrP9dGMQrk3q7iHFqOmIjbuGp/1ErV7FXBV
 KFZ/cpMXKcBEoVGTZ8wEwTaFc0SNVny8r8W2dSIT+tHxZ5Zg5EysTihIgbHS3LWVu0uEQ
 cKIitGS0a1mDu0Ib98CrgaUsmPh8nKUvTDmOPzdkSPSN3NmlB3j372h799yk0B1KzWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792956672;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=O1gpL8372RFxXQGINcqxnJHbr7Iz1fv72gES+Ch3S20=;
 b=shU+EFc1qZMVyuYLliFNZCPWmi9ElReWMLZWq3Lnaw9L3b0h8iPtm4z8ox4ZiwPQnuwU
 H3hqzVzmQD1eeaoU6KYMHVHFXvR6pRuxospAhta6/2DdHh6S1cAnecAA/9unAuH6hRDHn
 3MFwmnCgCIOtwVv+muRK0envVocVFwoimW/RUCK1Wy8gPETpPgoGkNXErb0aq27bMc36m
 h2GPwXxD/qF0gvtH2wxtGiEbKYaMP82FjnPgVqAh8q9Al111p0V1uiwCjPJzK0h3xU7fe
 zA/A3U3tKIK243nWrIkg+0mcT2isvMLHDeZH1y/gFaUiWv6RzngdKa+tB6IRYWuGnHw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HpPHBebD; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HpPHBebD
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9FDEA60600
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 19:31:11 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1999003f8f.1
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 12:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792956669; x=1793561469;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=O1gpL8372RFxXQGINcqxnJHbr7Iz1fv72gES+Ch3S20=;
 b=HpPHBebDrXrHVK6w64hMvHfU4of0EmlzYxXue/EYg2/p0zm3bg+0kch620Ql/fXCKD
 yAHjBP37zcZCNjVg64uk1I9fyt8BZGlYrU/pTpunISDvOENiRoa2bmBAV7fDBO8lO5Mq
 YNQUKFMPfACfG7yVdJNVB9DyVe268rqBNWVakiAUqp+XHoJPLJah3b+THRHhy8VTDokZ
 pBQTOZZjNw37ogkFrg1hUhumdz2w7xL+pl4HLbWlx9kNReZEfvRuUTubsVvBv/oq12oM
 D5/b8he5QpmOri8pM1+rMZBs3nvVHR6tAjyr4Mj1199qJSUn9p5SYVphFU2rZCtn5/xE
 4cHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792956669; x=1793561469;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O1gpL8372RFxXQGINcqxnJHbr7Iz1fv72gES+Ch3S20=;
 b=nv6aghdA6QwAoiRtHSN8AXrdSPFpD/6nwRPKodKqxR/ryb5HUJ8aMZnlPR15w0lBX6
 Ki3bUEF2rJa/kUO01wIwalukeHjC7UaL8X8rm4u9eZmPPJ4e7Jv9cmbXnikp+5/5cENf
 tpVq9b1DwiBmlT3DEwPtx4up7gWH6Gi9G8QDAkfZ+o5OJgotipjBv4sExm9gOQncIYGe
 wa2Wz7BR3QT8XX72l2ajdfsc+4kil0w5ukCVPwPxVhmZDziAbE3bkSODMBfvgPawhNIV
 UvzhkMa0NEI663Vi6Dl41mpF6SG0Zn/M0owTYDt0+ZBXOpZZKaWFi4DuQ52oIflKgxM0
 vGKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJmjsQBjeZsqyTZkykB8Y/Z0wt9OYAN10ttDnaMd40yJe8OSmMp/VeCp1pi83T2EemibO6UNA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYImqFDDtjme+H3ippcPrY9mUQZ5yBGIku0PVXebVLQx8q90MHMg
 pM80fomrwbI8oJiLPyUT/pZZAGps4GCcG8y8aTKW2BjsrCxd3Mk3vtvhp1EVkQ==
X-Gm-Gg: AYBFou0xRWVp2+xP7MNIktLSF3UtyJR1Uc+qZF1wF/i/eJs9pGaY7nYs+4s6ly/avOW
 jHT5io/uIF/GcOIpnqJW+zerVwC3zm0AEluIOX/zJ/fp67BrwB4/vlLJhP3tCeGKxJOPieehXwR
 1MBUVXJ5uaQJZOmBRjX8eCRJXeOCRzdnesljscnYKV69wPCtz9XoopMKzSCp+pSBmpQOMQvRj3j
 2bfAbtFOm8WOnNR5wvxs93U1DtUmym2bbCe4zV6+WULfXqAuF/VQiF72EkgvG6KG84xggWo+kpW
 X15mJsA8edaZ0sX8BJr3danZjQVRbKXJFod3jg1371BYpXCuPuYnTg6VmFiX1+xkCbDCHMaIV8b
 zOt1kLLaS03qWJBrx3Z1v5oNv6jH41VmHL1i48bSdDZbePwcm121t/GBGTtYMCAKJwe36pkqUh5
 4T+3mOIC1SQxj6OByM2jtBmH/T25SL3AtH7Dph02KTDYMzlgNQnlYsOA66X/pPRZFFrBPH8+wf/
 9VyqU1ycFWHbeW8DKGnFqvPGjkLCz/LKV/i30I4+XoV+p2tmSNtVcx2Uxs67SXfjwGZoRP4cuhx
 nPTKfjlTVr/S
X-Received: by 2002:a05:600c:a483:b0:4a3:d327:6ed with SMTP id
 5b1f17b1804b1-4a3d3270862mr45453645e9.17.1792956669259; 
 Sun, 25 Oct 2026 12:31:09 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.254.197]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0aa0bcsm176549365e9.4.2026.10.25.12.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 12:31:09 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 25 Oct 2026 20:30:51 +0100
Subject: [PATCH v2 4/4] ram: rockchip: add config option for tinier debug
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-ddr-multi-v2-4-b82ff9c860ba@gmail.com>
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
In-Reply-To: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Selecting the RAM_ROCKCHIP_DEBUG_TINY new configuration option, the
debugging code prints only the SDRAM type, frequency and size, limiting
the required space. In this way, the debugging code can coexist with
support for multiple SDRAM types without exceeding the output size
limit, such as in the case of the PX30 SoC TPL.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 drivers/ram/rockchip/Kconfig        | 11 ++++++++
 drivers/ram/rockchip/sdram_common.c | 54 ++++++++++++++++++-------------------
 drivers/ram/rockchip/sdram_px30.c   |  4 ++-
 3 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
index f51ae6a4542..98770659cd2 100644
--- a/drivers/ram/rockchip/Kconfig
+++ b/drivers/ram/rockchip/Kconfig
@@ -24,6 +24,17 @@ config RAM_ROCKCHIP_DEBUG
 	  This is an option for developers to understand the ram drivers
 	  initialization, configurations and etc.
 
+config RAM_ROCKCHIP_DEBUG_TINY
+	bool "Rockchip ram drivers tiny debugging"
+	depends on RAM_ROCKCHIP_DEBUG
+	help
+	  Limit ram driver debugging info to sdram type, frequency and size.
+
+	  Help to keep basic debugging information while minimizing consequences
+	  to ram driver footprint. This can be useful when configuring the ram
+	  driver to support multiple sdram types in a very constrained context,
+	  such as TPL for PX30 SoC.
+
 config RAM_ROCKCHIP_DDR3
 	bool "DDR3 support for Rockchip SoCs"
 	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
diff --git a/drivers/ram/rockchip/sdram_common.c b/drivers/ram/rockchip/sdram_common.c
index b46de5d9044..519bbdb4e60 100644
--- a/drivers/ram/rockchip/sdram_common.c
+++ b/drivers/ram/rockchip/sdram_common.c
@@ -44,36 +44,36 @@ void sdram_print_ddr_info(struct sdram_cap_info *cap_info,
 	printdec(base->ddr_freq);
 	printascii("MHz\n");
 
-	printascii("BW=");
-	printdec(8 << cap_info->bw);
-	printascii(" Col=");
-	printdec(cap_info->col);
-	printascii(" Bk=");
-	printdec(0x1 << cap_info->bk);
-	if (base->dramtype == DDR4) {
-		printascii(" BG=");
-		printdec(1 << ((cap_info->dbw == 0) ? 2 : 1));
-	}
-	printascii(" CS0 Row=");
-	printdec(cap_info->cs0_row);
-	if (cap_info->cs0_high16bit_row !=
-		cap_info->cs0_row) {
-		printascii("/");
-		printdec(cap_info->cs0_high16bit_row);
-	}
-	if (cap_info->rank > 1) {
-		printascii(" CS1 Row=");
-		printdec(cap_info->cs1_row);
-		if (cap_info->cs1_high16bit_row !=
-			cap_info->cs1_row) {
+	if (!IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG_TINY)) {
+		printascii("BW=");
+		printdec(8 << cap_info->bw);
+		printascii(" Col=");
+		printdec(cap_info->col);
+		printascii(" Bk=");
+		printdec(0x1 << cap_info->bk);
+		if (base->dramtype == DDR4) {
+			printascii(" BG=");
+			printdec(1 << ((cap_info->dbw == 0) ? 2 : 1));
+		}
+		printascii(" CS0 Row=");
+		printdec(cap_info->cs0_row);
+		if (cap_info->cs0_high16bit_row != cap_info->cs0_row) {
 			printascii("/");
-			printdec(cap_info->cs1_high16bit_row);
+			printdec(cap_info->cs0_high16bit_row);
+		}
+		if (cap_info->rank > 1) {
+			printascii(" CS1 Row=");
+			printdec(cap_info->cs1_row);
+			if (cap_info->cs1_high16bit_row != cap_info->cs1_row) {
+				printascii("/");
+				printdec(cap_info->cs1_high16bit_row);
+			}
 		}
+		printascii(" CS=");
+		printdec(cap_info->rank);
+		printascii(" Die BW=");
+		printdec(8 << cap_info->dbw);
 	}
-	printascii(" CS=");
-	printdec(cap_info->rank);
-	printascii(" Die BW=");
-	printdec(8 << cap_info->dbw);
 
 	printascii(" Size=");
 	printdec(cap >> 20);
diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
index 7f51b9c4f8f..2b25a0124ed 100644
--- a/drivers/ram/rockchip/sdram_px30.c
+++ b/drivers/ram/rockchip/sdram_px30.c
@@ -715,7 +715,9 @@ int sdram_init(void)
 
 	sdram_print_ddr_info(&sdram_params->ch.cap_info, &sdram_params->base, 0);
 
-	printascii("out\n");
+	if (!IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG_TINY))
+		printascii("out\n");
+
 	return ret;
 error:
 	return (-1);

-- 
2.34.1

