Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C71C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7830E88064;
	Fri, 15 Mar 2024 16:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Svn5zNVM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFD8B88058; Fri, 15 Mar 2024 16:10:51 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 582C887FEE
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33e285a33bdso1317666f8f.2
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515442; x=1711120242; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UcNVMhc5pd57BJAWg7CEaXltJXrT2vPxwLAptj91np4=;
 b=Svn5zNVM4+0CyeE42+ugUDOK+Z0iZy0ayIY3JMON+rfFUEwfxaKGMRVqEtOO6Zx+aT
 /ABtlBb1SHkQHI1xvrUBI9NBGwK/OI178F8WinEpT2V/cNgrTQuMcrR1Z7TEnRLGSQa/
 BIzU+ydzZ1h0G/02d7YDAofzWbuN0hkdOORfE+faqFykJ6bvBD496kXUde0DXa2pDR/5
 DCEejd7DlcXMbCuDVLFOBQQ6GIOjOubaYkoARrZmNtr2u0jRkUZbUYiSoS6L+rSaqUL1
 1VZjdbYfEYs4+j0Dv3i91uf0vXDvGIk5mzpoPoIUJMz8jPecHtMuJ6p1eo1QibKkQl3B
 DCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515442; x=1711120242;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UcNVMhc5pd57BJAWg7CEaXltJXrT2vPxwLAptj91np4=;
 b=XnAvurIYLQTBw3zCuMPM0nPRgbbtMt+yCx8KOUACY/5mWJTN+uFzgLuMFsz9YEtUrU
 UmFYgByHut/SI+VWwdGKxMqDE2wgx6xtKvAJSC/U+yWGjCP10DLjjXugSYhfd7tazfkT
 OXDHtEka54ly4CkxYPbwG/nsk66vlreOqfPP8+XfR5dl00HFMBIZ5qHzacOSwVbi81cG
 B6Frjo0MpqxPVtpf2Ze5/WneR5lBAoCjJ3nFicOilKOJbpqroSX1mm95EMxT87PVqrhJ
 zK3DdDVk352sjmsNcZ82erXUymlZzmdXfqSp5E/rgSRwBWYhn256Ox5oGDHftDH7S9eU
 tbyg==
X-Gm-Message-State: AOJu0YwyXHZG4NfENgLRT/BkQ59Z0PDyoFk8GQzCRvWv9ysVg34kaPln
 zO+IKwkxf6kzw23ZHKK4PRGOnfbjdg/r3yuBFan/22zNOxe9eL5PiNpYMtXOMuHS9rKh3KHHOu9
 h
X-Google-Smtp-Source: AGHT+IFWO//ccbRrkHiiMRHWZ/kUakV4bS+wJSzjAhgEbOWY1c2Vc3YJn+gIE3FSqAydPAHKEsbJHg==
X-Received: by 2002:adf:a2d6:0:b0:33e:7a85:7244 with SMTP id
 t22-20020adfa2d6000000b0033e7a857244mr3585099wra.35.1710515442738; 
 Fri, 15 Mar 2024 08:10:42 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d4006000000b0033e699fc6b4sm3398141wrp.69.2024.03.15.08.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:10:42 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 15 Mar 2024 15:10:23 +0000
Subject: [PATCH v2 14/14] qcom_defconfig: enable USB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-qcom-livetree-v2-14-ab635774b2dc@linaro.org>
References: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
In-Reply-To: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2128;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=wl9BzprwKPg29hyT0yDv2ltLCWGR/3EDXgkc/6tNd8M=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvKU8c/M6u5Nny9t2Oy7MZRa/+uGXrmFXYvcpYLrNdI
 PHA43fnOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBE1iQyMqxkfL9g5jQZ96Ls
 /oDf/9JPm4TGX2RwrH5tXmeeeG9WTizD/6CcnHVlldXb4hdUOZ76mSwq1vCHwSHkzsSHr85ujp+
 5ThgA
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
 configs/qcom_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index eebd0d74bd51..3979c19052db 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -12,8 +12,9 @@ CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTDELAY=1
 CONFIG_USE_PREBOOT=y
 CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
 CONFIG_SYS_CBSIZE=512
+# CONFIG_SYS_DEVICE_NULLDEV is not set
 CONFIG_LOG_MAX_LEVEL=9
 CONFIG_LOG_DEFAULT_LEVEL=4
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
@@ -22,14 +23,17 @@ CONFIG_CMD_CLK=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_UMS_ABORT_KEYED=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
 # CONFIG_NET is not set
 # CONFIG_OFNODE_MULTI_TREE is not set
+CONFIG_DM_WARN=y
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_SDM845=y
@@ -37,17 +41,24 @@ CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_DM_KEYBOARD=y
 CONFIG_BUTTON_KEYBOARD=y
 CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_IOMMU=y
+CONFIG_QCOM_HYP_SMMU=y
+CONFIG_MISC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
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
 CONFIG_SPMI_MSM=y
@@ -56,8 +67,9 @@ CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_UFS=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_FONT_8X16 is not set
 CONFIG_VIDEO_FONT_16X32=y

-- 
2.44.0

