Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9D4C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 15:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9843A87DDB;
	Wed, 31 Jan 2024 16:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q8NidTz2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9527587D6B; Wed, 31 Jan 2024 16:17:19 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7523887D8E
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 16:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51120e2864fso1722250e87.1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706714233; x=1707319033; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hJTsHECS24vGCObVThDn1gZyJSGsUl9Dz7bFF4jZ1Kg=;
 b=q8NidTz2O9LQ2n86jPqissOkDo8rzrvlISRDoaSjDk0KtzdY1ZjC35hFI+qMFSC45u
 MBxlSoFsFkWIELewK9z1jqhxbh+iTrJX1nwhUXtteWqBihGBPax9U0/sELNLAYcsrQGz
 /4z6x9DTCDHI0VL/pWdYjY/SMog6ZeVgWBkp/TivOTf3B2rgXbFVTWsz3JYcROhC4lEW
 g5zA/JbGEAHPhbA6VEohEmyXvhrhkDALqGx8ZQ6LpWWHhFvriL0ubnqngCV6N3tSD0wG
 fiZ7DX1GpQiGSoZ8qSVldGlPMwAvFseAcPHKTLChf3UtCQGfTUurtyNksQxTvTpIlRId
 BNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706714233; x=1707319033;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJTsHECS24vGCObVThDn1gZyJSGsUl9Dz7bFF4jZ1Kg=;
 b=N7Eu4+66AnM+CTx9NS4/HkDZytR8B1O1M46U2QUhHzLvr5F6jVOunJ4P1YuEpQ/rxx
 S0ftOkuB6ad0vXseyvX2HQJ9UWmCZrMpKX+xc2gECLUGY8RMfgD9/MmzvoxSxu0YOW62
 zib1Mp7Uw6jSIoaKNbrQMY5hSE7iuAeDt5IdFfu2UhKXSaNKXtiMBAvpIkAZF5XDpec3
 2dlT4P0XpEkb3VpaeYnJOaUHUJKhsLJ/2fW8gTrSwGbZil0sIbMU6WTDfT/4qdnuSo9r
 mU/9Yp5gdX9rX53RsGFeo9deCRARIhSmlNi87GVMXD3TWEDlh3LIlSJKPmCYhHSL18MB
 n15A==
X-Gm-Message-State: AOJu0YyX/NwROWC07qQUl7ivZiy7QqBDHF498FasLuKPzbUa435UTaIl
 BMqcRxhGsX/SedmONR4hzBPXJF0BO6yT/NthZeE7Czft/gHYETa/lgA8WLKrV7p1+hL9uM2smTc
 z
X-Google-Smtp-Source: AGHT+IEvlKV7OI6IYmwUHii7IN/Xfp4QODZ7Kdbyc5jZSoFtRWqFP7DOFG+rf/n2Q4Et16uUp8OOlw==
X-Received: by 2002:a05:6512:1251:b0:510:280a:baf2 with SMTP id
 fb17-20020a056512125100b00510280abaf2mr1722138lfb.12.1706714233467; 
 Wed, 31 Jan 2024 07:17:13 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 en6-20020a056000420600b0033ae5b637d4sm11109031wrb.35.2024.01.31.07.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 07:17:12 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 31 Jan 2024 15:17:05 +0000
Subject: [PATCH 13/13] qcom_defconfig: enable USB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-b4-qcom-livetree-v1-13-4071c0787db0@linaro.org>
References: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
In-Reply-To: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=SM8R83lPmNm2vkoJLzCW97VuijG2vHV1ie7IOHBvDcY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRdKTnPKrM03XNUtMoKjc5+6ixMSp/4b/1Bj/evarYuM
 Yi2frmmo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAExE/xPDP3UxcyWvoxNPvlAr
 PeafkcihyR3iIfnwxpzprGuClTf/cmP4Z6T5wK88KeVpiGbZtTnr782KW6HaVSiSVHjRsv7+wY0
 f7QA=
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

Enable support for the DWC3 USB controller and required dependencies for
Qualcomm boards, specifically the DB845c:
* IOMMU / SMMU
* USB high-speed PHYs
* Mass storage and ACM gadgets

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 3935fe2ef59f..dedd5f20b719 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -13,6 +13,7 @@ CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTDELAY=1
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CBSIZE=512
+# CONFIG_SYS_DEVICE_NULLDEV is not set
 CONFIG_LOG_MAX_LEVEL=9
 CONFIG_LOG_DEFAULT_LEVEL=4
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -26,6 +27,8 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_UMS_ABORT_KEYED=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_FAT=y
@@ -35,6 +38,7 @@ CONFIG_EFI_PARTITION=y
 CONFIG_OF_LIVE=y
 # CONFIG_NET is not set
 # CONFIG_OFNODE_MULTI_TREE is not set
+CONFIG_DM_WARN=y
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_QCS404=y
@@ -43,14 +47,21 @@ CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_DM_KEYBOARD=y
 CONFIG_BUTTON_KEYBOARD=y
+CONFIG_IOMMU=y
+CONFIG_QCOM_HYP_SMMU=y
+CONFIG_MISC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_MSM=y
 CONFIG_PHY=y
+CONFIG_PHY_QCOM_QUSB2=y
+CONFIG_PHY_QCOM_USB_HS_7NM=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_QCOM_QCS404=y
 CONFIG_PINCTRL_QCOM_SDM845=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SCSI=y
 CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
@@ -61,7 +72,11 @@ CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_STORAGE=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ACM=y
 CONFIG_UFS=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_FONT_8X16 is not set

-- 
2.43.0

