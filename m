Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BC0C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 14:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B81282CF5;
	Thu, 12 Jun 2025 16:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mLl53N08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07FBB82CE7; Thu, 12 Jun 2025 16:16:53 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DAE9828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 16:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a54836cb7fso659669f8f.2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749737810; x=1750342610; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lbHeCFvnjXCyqU0k59eafUjMnLbKDn2DUrtddM88OX0=;
 b=mLl53N08nMjg3vyCoEMq6+u5bUXtChP50l0neFxGN08p/E4+n2kNZ3FSeemFvphxJH
 mo0eZjsKlbxzBdzh205g9d0VdcsMLGi6ACHlDbtUPR5pmByB+IeUsPLTl3gwHbVAW1E/
 4xnXYzD1MLuLUIcpFQmvCIvyrP1aDtFpB9S5PXIiIYAbsvYBcglZ2yh3PFo98A9RP9Ol
 5ikfMRgR2W3mjm/YgAoqi8yFnCB/oGlS/Fyd5G/Sx6HV+WCUsQnSxS5VN/6Mlc2L/Z4v
 xUin5hAlLdyd9GxpppnRp4pIzLcO4qNhYjisNteJARCzsJ1GjrujECmsDBKHL+SoGB/t
 gUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749737810; x=1750342610;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lbHeCFvnjXCyqU0k59eafUjMnLbKDn2DUrtddM88OX0=;
 b=UD/w6sjqH0dosCag9YpLnknQL1BQiNDWmP289Ax/FuzIkFQvCtxiBW7MXpdso5SGri
 7wPJYwXY8K6yq5K0IMuIh3fy+iAfELsSKG6w6PStGcaAqYI7lrHvGvi3iu19FHULM28H
 bOjo99FlJJG3jEU45zotQlnT44N2/KXcPYid62OICaKn/rnJwa67+gPFPj2IHRuMx453
 uTh4iYPvt2Ch+Kb6l0r92Hfuoer4ROZ5uRon5aCveT6GXOfHbV+AFC7LFAnJWfSSDvu6
 LzoBIxDt2fHDqa+3Rq2i1SMKf01WhF+xfu3t0ZzzQcVUsPunklaUveRGTJD174MlN8Vr
 fVMg==
X-Gm-Message-State: AOJu0Yz6Ee0EUmmwnJDZPD0knywx9nrQXQz+aJDzHkpvA5GIRS/gjLhc
 C0Ip89qHknLFLnBonUnOrxNL0fQ7ppp37e1kkSGaCkVdH1lYyAWkKSJhKQ2miCTy/g5/CoJb/Ef
 sn1dW
X-Gm-Gg: ASbGnctO+6pqmkuDKVoYmFbMSuvazSiTsPrI2pGJREdVUf+7uoqLlbQ7Z/Xsje9CWgp
 ictknb00iMvTuLkRbDfoAsH8/GI4xx8WJ3i8Iw00VWuQcvLHlJ7mqIjVI5b+YJyEqAMq19vEOGi
 hS167t/K7Z9BuBAmBLQk1m7pnlGr5B6pp6wLQM2IJ4CVqF1ZMuxdx58E4QZCNTlgwrPXXu6sRrt
 kxJwGbV30b/d6JP8qLmVyLSk04b7yfLwUZIo3Z3gK6DXdp1G/H9cpkFt0S/jPkDsetHsjoR0p2J
 LlZa3BdNi0Xxr0UVrBbggArDNuKjI7Z+2F3XkydtC+0o/GrHoC4R8XpF5swPNV/BNnHSWuBs
X-Google-Smtp-Source: AGHT+IE3quomcxU0rnGddSW47mXRxFtgMkPOSqJVO8ihKPkZDT6ucqcxcp0wFePPYWxC8LCDkJvXow==
X-Received: by 2002:a5d:5f85:0:b0:3a3:7bad:29cb with SMTP id
 ffacd0b85a97d-3a5587fdf77mr6975284f8f.52.1749737809881; 
 Thu, 12 Jun 2025 07:16:49 -0700 (PDT)
Received: from toyger.local ([2a01:170:117e:fc:1405:203b:89a3:c77a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561b510dfsm2044006f8f.82.2025.06.12.07.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 07:16:49 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 12 Jun 2025 16:16:42 +0200
Subject: [PATCH v3 6/7] qualcomm: use mkmbn via binman and stop creating
 ELF files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-b4-qcom-tooling-improvements-v3-6-76f34cf216e2@linaro.org>
References: <20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org>
In-Reply-To: <20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3732;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=tSbKOdrNxp7Wj+8ziwEvN1ykCw/AMOGG47jQp36guIY=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoSuFHVP614hsi9Hms8h8cq8g46sIjDKU6bRSL9
 R2+B2pMv/KJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaErhRwAKCRAFgzErGV9k
 tknsD/46O1vtwrfwGiPEDMgmZKRel1LxsorS+gTqF14Vxs3lUAijoKqaRJQ9PhWJ/cZFUc1xXCD
 6Cbn0Qon8DytfcgfIbwDJ37YKcZLeJhAX6NDVjliYwCzouc2MJXw6rlSPjtLka0aZGT7rFpU9AF
 lHmcZ+HqyeogrHcpGZ65MdDlB/W82TcLP7oQkIogdG/SH3JpyhTU40J1OKiHQn/VUCCXvT+/P/q
 g8gk/V75/z3JyHH2H1QRq+Fd2ocrx0Y502UU1NS/lBI2kubIvtAc3YS1laW94TLxVpHP+m3hZNx
 LYaR9lQi3N/bOCrISjMKgY0OOESJ5hlGMvJS9uW+UMWkLkKPb62Eap8ex/3rfyWW3JtBhC7jKuV
 /Do1ChbiSz8tCtsQE1MSg/MPP1s/cK/Gl4RfBKlGZ1Hbx3XIWYty1qS5Kx8HYcTYSNCWFbNGXbE
 +VVG5X5ohdewBhY92AUsriKzXQiTeuhUeRBnUm/dmOlFTocvXYeY2F7i/7Ok37545dzup5wXidF
 dbTJj9GjFYg4GdUx9B2ivgtIr3lK6gFMMj/xrnHKWkoC24Z45OJMRiBBB2+Yq3rPukDiIMlutNL
 rA+eEVV8+PXwOM7UUJBJgaYgW93/52GSifpOIDPrQcrlEWhJRWNj9QDD7WA9qG+lCMM1X7hbhVH
 O6/2bFWb1/aD5LQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Remove the load address and REMAKE_ELF from Qualcomm defconfigs. This
information is now encoded in a table in mkmbn.py.

Add a new qcom-binman.dts file to configure binman to build a u-boot.mbn
file.

mkmbn.py is now run by binman during the build process and will emit an
MBN file for supported boards with the appropriate signatures.

This removes the need for additional processing of the image in most
cases.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/Kconfig                   |  1 +
 arch/arm/dts/qcom-binman.dts       | 16 ++++++++++++++++
 configs/qcm6490_defconfig          |  4 ----
 configs/qcom_defconfig             |  2 ++
 configs/qcom_ipq9574_mmc_defconfig |  1 -
 configs/qcs9100_defconfig          |  4 ----
 6 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 579c8acfcb466122c4fe66950ec7ca24c355b43a..12f354b86b6c740a8ae4c59a1a48b0be6595acfb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1107,8 +1107,9 @@ config ARCH_RENESAS
 
 config ARCH_SNAPDRAGON
 	bool "Qualcomm Snapdragon SoCs"
 	select ARM64
+	select BINMAN
 	select DM
 	select DM_GPIO
 	select DM_SERIAL
 	select DM_RESET
diff --git a/arch/arm/dts/qcom-binman.dts b/arch/arm/dts/qcom-binman.dts
new file mode 100644
index 0000000000000000000000000000000000000000..da5d4a23d2fa960c5de6e1eec6dd982018fdd804
--- /dev/null
+++ b/arch/arm/dts/qcom-binman.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2025, Linaro Ltd.
+ *
+ * Casey Connolly <casey.connolly@linaro.org>
+ */
+
+/* Configure binman to build a u-boot.mbn */
+/dts-v1/;
+/{
+	binman {
+		u-boot-mbn {
+
+		};
+	};
+};
diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 54eb5dedaecb7a82c26a4bd7f5d1807ca6d4201c..63daa74a451aec5178cb9c1e58907ab9c9985d90 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -7,9 +7,5 @@
 
 # Otherwise buildman thinks this isn't an ARM platform
 CONFIG_ARM=y
 
-# Address where U-Boot will be loaded
-CONFIG_TEXT_BASE=0x9fc00000
-CONFIG_REMAKE_ELF=y
-
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 6258d5dd5aad0367cd92f52b6a1f84367b7921ea..2afb930e103cac5801bea05f531f98ed046113a0 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -152,4 +152,6 @@ CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_NO_FB_CLEAR=y
 CONFIG_VIDEO_SIMPLE=y
 CONFIG_WDT_QCOM=y
 CONFIG_WDT=y
+# CONFIG_BINMAN_FDT is not set
+CONFIG_BINMAN_DTB="./arch/arm/dts/qcom-binman.dtb"
diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
index 8d7d3d92c73a30b246acc2eae6da1d7b04892691..00abc8430596dadd574d5d2b7353ecfdef01e2b4 100644
--- a/configs/qcom_ipq9574_mmc_defconfig
+++ b/configs/qcom_ipq9574_mmc_defconfig
@@ -11,9 +11,8 @@ CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9574-rdp433"
 CONFIG_SYS_LOAD_ADDR=0x50000000
 CONFIG_DEBUG_UART_BASE=0x78b1000
 CONFIG_DEBUG_UART_CLOCK=1843200
 CONFIG_DEBUG_UART=y
-CONFIG_REMAKE_ELF=y
 # CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 # CONFIG_BOOTSTD is not set
diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
index 4ceeba63ec12cebbc2124eb256a255450500152f..09e2c51d6d216f1f5c92c66b2eb30f38476d5792 100644
--- a/configs/qcs9100_defconfig
+++ b/configs/qcs9100_defconfig
@@ -4,9 +4,5 @@
 # a dedicated "uefi" partition for edk2/U-Boot)
 
 #include "qcom_defconfig"
 
-# Address where U-Boot will be loaded
-CONFIG_TEXT_BASE=0xaf000000
-CONFIG_REMAKE_ELF=y
-
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"

-- 
2.49.0

