Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33E8E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 05:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D613806F8;
	Tue, 14 Jan 2025 06:36:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="bRBZrYul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 016888061B; Tue, 14 Jan 2025 05:54:41 +0100 (CET)
Received: from mail-qv1-xf64.google.com (mail-qv1-xf64.google.com
 [IPv6:2607:f8b0:4864:20::f64])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C35E58060C
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 05:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-qv1-xf64.google.com with SMTP id
 6a1803df08f44-6dd481f6d3aso8100616d6.2
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 20:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1736830477; x=1737435277; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NuRB7N3koWQP54nFCYAWAKJv8rbs3Pt8EU+77N+kL3k=;
 b=bRBZrYulmfTQ5Tw4HXUx3GCNYrqaF1580NNQjg20QPTcJPXCkyuuCJX/83M827G0EJ
 NkMu/MuYSmgP25SdLSZRZY4ocUWYdQQv1WXsan9zM1IZTqH2iE07bZs2JiDvosqCdu9D
 60QaNvG9wBCZJcqX5/u5cAGOhz8pHtG1cToTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736830477; x=1737435277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NuRB7N3koWQP54nFCYAWAKJv8rbs3Pt8EU+77N+kL3k=;
 b=kalEjcQrX09qhkMNbvpyNumhMK0xoLVGm+C76Y/HXRz4LY31aRs9vzYrHhYQsri7qV
 Iodkzdrvn8c1+gQPX/rtisBJaZ69naXr00pVyEL21+lWNGObyBFfHha8+s0VxcDLvBUn
 q/WYXKSHtFUnNxfpzNo6TuDATXScaXxcZBl1fNcF6LgH+0PliOoIkY32jxrfLXe/9A5k
 CFrT2TmfYdnxV9AweK/LC323EnHNIuOaeyTAnMfSXXu2bWJbCryZKSfC6lMR0uBzpeTC
 EQHfiEPp+KznBg8vEf6i4RbMWEzJmu7myeyHHjGiHVAoBS5Zcx3dWaf+5guoNTfjccwu
 jiRw==
X-Gm-Message-State: AOJu0YztS6SBA5/GDtcUzZEoernT8OZqx8Lh9iaVX+BeGfJadizwAxRf
 n31t++mUuqL2EAqH7jjwtjJ8WHZgjPu2pnam447yByIwx/5IITgjpc3E+1wfBaCKHOj+Y0ueTLD
 Jqf7h9nfIqItVPs95z2swGAgT8tLBsC39PbV+h5//mgZNHK/CLsugPor9FS+35OQ4rF9LeZF52A
 jwcGMKEBlsuUsOwTvoJcL+8AFJ9hWDEFpZuFMrM545o5s0UjrINdUMn2Sl9kcHXcHm2jQb
X-Gm-Gg: ASbGncsEiRI77hiS8NgsynP5UXH0vRs0JqGmiHjP3Bo+IkoSuJWNaC/fE1IVGOYDnOt
 MfK9HlRaX6KzU67lGeG/l4ghN0J7yvlLz/lMCiLiqYRiAXtC8WcqHdoTV8Tf0JwwKO7TpPThK1/
 RSqbNCH5/94CJwDCujq8mBFlOczokifLwdRfyRdNIjzF2u6At40HuwC0SaKYvqNdHrT2GHWZC1o
 csljuHM9yDjuOqoIExeZbEfk/eSL8FaJBJTDQNGczZi6Qvh/2b18zd9nB68GikOmSF2+y6zqfdm
 oJQcFGOtJv3R/JiVLYTS/nRPWnBs1UY=
X-Google-Smtp-Source: AGHT+IGBLm+fWV5O2IPam1F03NapzuDCWufAUEL2t+64k+3CE5ApfZa1EtkC0GupjdnB9Mu0RqOteubxkkKu
X-Received: by 2002:a05:6214:320b:b0:6d8:967a:1a60 with SMTP id
 6a1803df08f44-6df9b1d20eemr141340196d6.2.1736830477698; 
 Mon, 13 Jan 2025 20:54:37 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 d75a77b69052e-46c8731f2d6sm2613821cf.3.2025.01.13.20.54.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Jan 2025 20:54:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, dregan@mail.com, dregan@broadcom.com
Subject: [PATCH v2 3/3] arm: dts: Enable basic nand functionality for bcmbca
 devices
Date: Mon, 13 Jan 2025 20:54:25 -0800
Message-Id: <20250114045425.148801-4-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250114045425.148801-1-dregan@broadcom.com>
References: <20250114045425.148801-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Jan 2025 06:35:58 +0100
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

Enable rudimentary nand read/write capability.

Changes in v2:
- New patch in series added enabling of nand functionality

Signed-off-by: david regan <dregan@broadcom.com>
Reviewed-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Anand Gore <anand.gore@broadcom.com>
---
 configs/bcm94908_defconfig  | 8 ++++++++
 configs/bcm963138_defconfig | 8 ++++++++
 configs/bcm963148_defconfig | 8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/configs/bcm94908_defconfig b/configs/bcm94908_defconfig
index 0b6db9aa52e9..e651212d6853 100644
--- a/configs/bcm94908_defconfig
+++ b/configs/bcm94908_defconfig
@@ -16,7 +16,15 @@ CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_NAND=y
 CONFIG_CMD_CACHE=y
+CONFIG_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_EMBED=y
+CONFIG_DM=y
 CONFIG_CLK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_BRCMNAND=y
+CONFIG_NAND_BRCMNAND_BCMBCA=y
diff --git a/configs/bcm963138_defconfig b/configs/bcm963138_defconfig
index 9459a232560d..f1f83dc2f1be 100644
--- a/configs/bcm963138_defconfig
+++ b/configs/bcm963138_defconfig
@@ -16,7 +16,15 @@ CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_NAND=y
 CONFIG_CMD_CACHE=y
+CONFIG_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_EMBED=y
+CONFIG_DM=y
 CONFIG_CLK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_BRCMNAND=y
+CONFIG_NAND_BRCMNAND_BCMBCA=y
diff --git a/configs/bcm963148_defconfig b/configs/bcm963148_defconfig
index d6fbc34927cb..579fdd5d22c3 100644
--- a/configs/bcm963148_defconfig
+++ b/configs/bcm963148_defconfig
@@ -17,7 +17,15 @@ CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_NAND=y
 CONFIG_CMD_CACHE=y
+CONFIG_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_EMBED=y
+CONFIG_DM=y
 CONFIG_CLK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_BRCMNAND=y
+CONFIG_NAND_BRCMNAND_BCMBCA=y
-- 
2.37.3

