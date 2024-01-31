Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B51FC47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 15:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30F3C87DD0;
	Wed, 31 Jan 2024 16:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nRZ2HB3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A946887DAE; Wed, 31 Jan 2024 16:17:17 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 433AF8751F
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 16:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33af40493f4so1853736f8f.3
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706714231; x=1707319031; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=REfHkSKj/W8rWrQvPlPGQDRdKeMQECUIWxqRSMchf6U=;
 b=nRZ2HB3jn0OxWNVTL4QE99JJP74P5jqf1C1gGCV8J1EyxL/Oj3EGMwfFfgWZnKh820
 sWOSDNyxWRMVLanhNrBdAWrbgf28v1jAepjmYz6ah0wy4qsxf4szfNOxT8yndmoe9Zsj
 kvELHOP0CaulNxHITg3rXlhEvKZN9znQKOcDiWxyikUT/wkB4a7WpBv1IV4fgvdgKo1L
 3pk3bbp0MDPt/L6H3U1D6zbYUX/ky0Mcyc/b4qF/uMMCx10IN+Y9DKZdnwfMa92GUU4w
 6sZjpqEt+gs7OxcZL2hTfFICH/ZMpQwq4cGXntq4AGFzOenFZY0BEPJNKyOQEbAkW/ug
 /3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706714231; x=1707319031;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REfHkSKj/W8rWrQvPlPGQDRdKeMQECUIWxqRSMchf6U=;
 b=TY+XAqKSlIaJIgf8ydRoR9eqGsARVIMFEMhsTWCj5X7On4YYVUDx8XwHwWhX4xXqtT
 rT1utJFRHzn1Ek2DJMdApGiVcIJWQ4FABMF4IpxhLeu5ZzzoygGbItWGJ2TBLHBZglJ7
 RVdhRtkkCLDM8JlswyjpCr4axBEB/7laxhjLgZlb8IXj8tV8fNypiUxIWWhyags6Y+MD
 D9vOvCK0X+JMM/0A/isNw06t/+Ck8C1chJPx7UbcKiuZnCbIoM4XUBi1OhEzzOICqhg6
 GWY5Df2z9Bxk7Kbf0IT6yvmTzwVmimvNPlN6WowRWLRnKVTPoHJMN0l428oPpWLrvxW7
 W1+w==
X-Gm-Message-State: AOJu0YwtaO2Zr4vHaXHKynUR7R2pUcG/Uu8iSNM+RqdCW15VWQTl+Cl2
 q6Els99Dk7lu2hcU3cm0ZrEw/VNgIU84ubo71D0m4ksO0dbxRFW9rSjRHB+urWBZwiTkfLyb2Tv
 D
X-Google-Smtp-Source: AGHT+IHeKRb/49AjF37teY8h17pa8ZsnXPwmFA/tXoCEoyrqtp8Yam8Qgu5PTpeP9T7LkX082HEX6A==
X-Received: by 2002:adf:fd48:0:b0:33a:e50d:d635 with SMTP id
 h8-20020adffd48000000b0033ae50dd635mr1239535wrs.54.1706714231642; 
 Wed, 31 Jan 2024 07:17:11 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 en6-20020a056000420600b0033ae5b637d4sm11109031wrb.35.2024.01.31.07.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 07:17:11 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 31 Jan 2024 15:17:03 +0000
Subject: [PATCH 11/13] qcom_defconfig: regenerate with savedefconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-b4-qcom-livetree-v1-11-4071c0787db0@linaro.org>
References: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
In-Reply-To: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=H1z1D8CTBPvjgv97Sqt5ciDaCpGuIEyPMmWv7Zp5VHA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRdKTkcaWsT5Gu0kt99YT5WEOWy4JPJj4ctYUyOzvdF5
 WUudk/vKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABPRncbIsG0F407P2TlvNCLm
 3pXpvKMnHtKXaRCqFWO24N2B78YHnzD8FdiTsaG44WrIkp2OrZ3aZ0OPHCxTOWGfUr+ifCFH+/F
 FSQA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Prepare to enable some additional features.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 3c6bdc2071b2..659775852c07 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -12,13 +12,13 @@ CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOOTMETH_SCRIPT is not set
 CONFIG_BOOTDELAY=1
 CONFIG_USE_PREBOOT=y
+CONFIG_SYS_CBSIZE=512
 CONFIG_LOG_MAX_LEVEL=9
 CONFIG_LOG_DEFAULT_LEVEL=4
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=64
-CONFIG_SYS_CBSIZE=512
 CONFIG_CMD_BOOTMENU=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPIO=y
@@ -33,6 +33,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_LOG=y
 CONFIG_EFI_PARTITION=y
 # CONFIG_NET is not set
+CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_SDM845=y
@@ -40,7 +41,6 @@ CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_DM_KEYBOARD=y
 CONFIG_BUTTON_KEYBOARD=y
-CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_MSM=y
 CONFIG_PHY=y
@@ -50,7 +50,6 @@ CONFIG_PINCTRL_QCOM_SDM845=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_SCSI=y
-CONFIG_DM_SCSI=y
 CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SPMI_MSM=y

-- 
2.43.0

