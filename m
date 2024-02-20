Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E9CC5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CAA687D72;
	Tue, 20 Feb 2024 14:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DoKNtaow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11B7687D72; Tue, 20 Feb 2024 14:42:38 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE4187D5D
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d94323d547so38742995ad.3
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708436550; x=1709041350; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZqcJ3CkWeWExBzgQjX/PeUAcATPcnjxo86ynHqQYSM=;
 b=DoKNtaowKF0qpyUvWE75QKK9RvS7jRFYBsQbnJSh0TvO2qHMK9cd1kvJprhuDLoDGL
 l/ltZ9DazKiFgEkuS6VkYVs8jSTCaM2TrDQxWqnm7buMxiPiwdMyvHfP56htFzYbqKTn
 tQIZwzzLtgjIKUmbake9gFa6XAvpEL0e440LV4jujsqhcCksOooz3FSCxq+SFNC1UJI1
 SAKG2qPYPqH265+4nOolxDpwcLkCXMfMbfbkVXfDXIkA1hF/+Ay+x0N3D3i1WHQLynOM
 L5HUESv9+WmVljvyh/uspwCj8dFkhaTsrdn5HAhlVAVtxRWYdr9O0zvYrV6A/o2hjge2
 6f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708436550; x=1709041350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LZqcJ3CkWeWExBzgQjX/PeUAcATPcnjxo86ynHqQYSM=;
 b=CTUW/QXw/ISArbmWJDlQwN0TVc9ELx0yyxihza/Lwu9bJqapJu0atiKZyWxLBt5BS/
 cpgna3gnlz8WsX5etaapOX+Yso3x7ohMvBiuA8AG9TJV5TE6RY3KQyBGpoz0BHCGlS7J
 AsroTyPOgIC3mQMEjq67wOu4r6XFIVsEW93st3fFezIdOAkQkD5pqUzUUQojSjOulkFR
 Wq2DG/H6f1yQdWMtDN4nnGBiIyp6Ssq0P6vXbdF00lvih6lVpW/EaDlQBJOgbRfbWa4v
 l8I/4pMIRtyps/4btsArF2falP80TYRW5UkNV68W1uPwkMSQjzAcyXmyZfG73AZZrJ17
 U0cw==
X-Gm-Message-State: AOJu0Yy4X0FFhbp4omhpd9sqz94B8Jh1LsRiZA6f7gXnB0c/0Sujcew7
 7dlxZWkM6WMyqILjZ1Ej0r3Db0zgKef64fd2PcJvPGCBkfop5We4Fb7BSPdus5GiQZv9Fiy32Ie
 i
X-Google-Smtp-Source: AGHT+IGzF1uqinFvP3ybwawHi28ZW9kVHO5zatLoY7IK87C54oBMTdGwapjYEaMgE4xAYQdyvDiiYA==
X-Received: by 2002:a62:cd82:0:b0:6e4:3ea4:a7e1 with SMTP id
 o124-20020a62cd82000000b006e43ea4a7e1mr4316022pfg.27.1708434710023; 
 Tue, 20 Feb 2024 05:11:50 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.148]) by smtp.gmail.com with ESMTPSA id
 y12-20020aa79e0c000000b006e3e72a4f87sm5195902pfq.0.2024.02.20.05.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 05:11:49 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, marex@denx.de, ilias.apalodimas@linaro.org,
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
Date: Tue, 20 Feb 2024 18:40:56 +0530
Message-Id: <20240220131056.2962331-8-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220131056.2962331-1-sumit.garg@linaro.org>
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
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

Also, enable reset driver which is a prerequisite for PCIe support.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 configs/verdin-imx8mp_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index 22b8a334dfa..d8bd644322b 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -185,3 +185,12 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
 CONFIG_IMX_WATCHDOG=y
 CONFIG_HEXDUMP=y
+CONFIG_DM_RESET=y
+CONFIG_RESET_IMX=y
+CONFIG_PCI=y
+CONFIG_PCIE_DW_IMX8=y
+CONFIG_PHY_IMX8M_PCIE=y
+CONFIG_CMD_PCI=y
+CONFIG_NVME=y
+CONFIG_NVME_PCI=y
+CONFIG_CMD_NVME=y
-- 
2.34.1

