Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6158C25B76
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 12:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30849882F9;
	Mon,  3 Jun 2024 14:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="CdNQeNo4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15CF8882DA; Mon,  3 Jun 2024 14:06:59 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 912138813A
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 14:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52b9dda4906so610990e87.2
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 05:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1717416416; x=1718021216; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1Soy2d/3hphxGQAz8Xp8H/f7WWC3gik/bAVj762IL4=;
 b=CdNQeNo4aTxF3T+4d4hrppXFwS1y/LBfOWrY1o2n3g+dveydtOuS/df1tSJK9Cfkcf
 LuYSoD5Zs3qubP0cKkruz73ph/+qoLdWi/J3kBI5/Bmb4zySPrNIXXa8QYnilPp197Mh
 Y17xgnuajRgFgfcbULU6rHhpHqYpwfS98IJ18lzHIi22Xtc90z8SvuqimCpyq57MCmG7
 pV9dfA196gFoWIDMMj6KVwpRV+0RMhnUrtCakLfwLXGHTjrArNY9C8tonmcs7vD9c24V
 oxvxYE82zhVP2XHSKMY8TZxWwUxR/O/fPcZJUirAxSggSuLMOFdHObxqxoXUb7B2aJQs
 lCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717416416; x=1718021216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1Soy2d/3hphxGQAz8Xp8H/f7WWC3gik/bAVj762IL4=;
 b=cqPYqjG6xNtF5U6HocFlxwQCOTm4MzAIUUGvpyQd7wqDPkV5kWtViz+m6iK6p3g/Ww
 yM/cyU1etq2Y8w7L2jRdNFg2y9UlgGSmaD+85WCBhGBXxpVLWtQj5delpvxYtEaB897O
 PXppgxjCHLXQoHfwUVenepmxShiHjJaBEFeIckDRE1XbRX2FdXCw0UTali1IXtKHcI/n
 PGZ9bGHPkmGLk2zRTVDlZaZL234Q7+lrleXClD6PfEcWHh/k8O66UQuD2n6x9XgkxPDk
 T6wNbawBCof23W+AsRvkT3PHOXEgYD7M5GID54fD9urp/80G2vMCL6wwYJONt0f3sQ3M
 8ZPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1OL+akRMuhmWfYgOda89vfZZbOYNmBXxU07ZBgY7Jmtg6aUhb6jumA7azjfvhNw31P9bWYBzzWhQrANkaGoXB753g3A==
X-Gm-Message-State: AOJu0Yy/GEfHP66DXiq7RD57UcyqPx2YHxmqcX1tYuMFn6wC7JPLQO6n
 3nMjNMOkL9A3x3aLUMQc3sD6uI0ZF/0MX+YWdSC2PRgyHprcCA+jIt7KtrKKf9k=
X-Google-Smtp-Source: AGHT+IFVecXLj+nVahu+8CKbkLNGTxGt13WuRXHxj8SL/KNDI8a3B/zSpjLDvAiso7i44qjVeeB02Q==
X-Received: by 2002:a05:6512:3129:b0:52b:2c64:1db0 with SMTP id
 2adb3069b0e04-52b89597915mr7080164e87.40.1717416415266; 
 Mon, 03 Jun 2024 05:06:55 -0700 (PDT)
Received: from fedora.. (cpe-188-129-45-221.dynamic.amis.hr. [188.129.45.221])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57a5cbece23sm2380391a12.61.2024.06.03.05.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 05:06:54 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, lukma@denx.de, seanga2@gmail.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 2/5] dt-bindings: clock: qcom: ipq4019: drop downstream file
Date: Mon,  3 Jun 2024 14:06:13 +0200
Message-ID: <20240603120651.154670-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603120651.154670-1-robert.marko@sartura.hr>
References: <20240603120651.154670-1-robert.marko@sartura.hr>
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

IPQ4019 clock dt-bindings are available in Linux upstream, and we can just
use those instead of carrying a downstream file that matches the upstream one
anyway.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
---
Changes in v2:
* Drop the downstream dt-bindings header as it matches the upstream Linux one

 include/dt-bindings/clock/qcom,gcc-ipq4019.h | 169 -------------------
 1 file changed, 169 deletions(-)
 delete mode 100644 include/dt-bindings/clock/qcom,gcc-ipq4019.h

diff --git a/include/dt-bindings/clock/qcom,gcc-ipq4019.h b/include/dt-bindings/clock/qcom,gcc-ipq4019.h
deleted file mode 100644
index 7e8a7be6dc..0000000000
--- a/include/dt-bindings/clock/qcom,gcc-ipq4019.h
+++ /dev/null
@@ -1,169 +0,0 @@
-/* Copyright (c) 2015 The Linux Foundation. All rights reserved.
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- *
- */
-#ifndef __QCOM_CLK_IPQ4019_H__
-#define __QCOM_CLK_IPQ4019_H__
-
-#define GCC_DUMMY_CLK					0
-#define AUDIO_CLK_SRC					1
-#define BLSP1_QUP1_I2C_APPS_CLK_SRC			2
-#define BLSP1_QUP1_SPI_APPS_CLK_SRC			3
-#define BLSP1_QUP2_I2C_APPS_CLK_SRC			4
-#define BLSP1_QUP2_SPI_APPS_CLK_SRC			5
-#define BLSP1_UART1_APPS_CLK_SRC			6
-#define BLSP1_UART2_APPS_CLK_SRC			7
-#define GCC_USB3_MOCK_UTMI_CLK_SRC			8
-#define GCC_APPS_CLK_SRC				9
-#define GCC_APPS_AHB_CLK_SRC				10
-#define GP1_CLK_SRC					11
-#define GP2_CLK_SRC					12
-#define GP3_CLK_SRC					13
-#define SDCC1_APPS_CLK_SRC				14
-#define FEPHY_125M_DLY_CLK_SRC				15
-#define WCSS2G_CLK_SRC					16
-#define WCSS5G_CLK_SRC					17
-#define GCC_APSS_AHB_CLK				18
-#define GCC_AUDIO_AHB_CLK				19
-#define GCC_AUDIO_PWM_CLK				20
-#define GCC_BLSP1_AHB_CLK				21
-#define GCC_BLSP1_QUP1_I2C_APPS_CLK			22
-#define GCC_BLSP1_QUP1_SPI_APPS_CLK			23
-#define GCC_BLSP1_QUP2_I2C_APPS_CLK			24
-#define GCC_BLSP1_QUP2_SPI_APPS_CLK			25
-#define GCC_BLSP1_UART1_APPS_CLK			26
-#define GCC_BLSP1_UART2_APPS_CLK			27
-#define GCC_DCD_XO_CLK					28
-#define GCC_GP1_CLK					29
-#define GCC_GP2_CLK					30
-#define GCC_GP3_CLK					31
-#define GCC_BOOT_ROM_AHB_CLK				32
-#define GCC_CRYPTO_AHB_CLK				33
-#define GCC_CRYPTO_AXI_CLK				34
-#define GCC_CRYPTO_CLK					35
-#define GCC_ESS_CLK					36
-#define GCC_IMEM_AXI_CLK				37
-#define GCC_IMEM_CFG_AHB_CLK				38
-#define GCC_PCIE_AHB_CLK				39
-#define GCC_PCIE_AXI_M_CLK				40
-#define GCC_PCIE_AXI_S_CLK				41
-#define GCC_PCNOC_AHB_CLK				42
-#define GCC_PRNG_AHB_CLK				43
-#define GCC_QPIC_AHB_CLK				44
-#define GCC_QPIC_CLK					45
-#define GCC_SDCC1_AHB_CLK				46
-#define GCC_SDCC1_APPS_CLK				47
-#define GCC_SNOC_PCNOC_AHB_CLK				48
-#define GCC_SYS_NOC_125M_CLK				49
-#define GCC_SYS_NOC_AXI_CLK				50
-#define GCC_TCSR_AHB_CLK				51
-#define GCC_TLMM_AHB_CLK				52
-#define GCC_USB2_MASTER_CLK				53
-#define GCC_USB2_SLEEP_CLK				54
-#define GCC_USB2_MOCK_UTMI_CLK				55
-#define GCC_USB3_MASTER_CLK				56
-#define GCC_USB3_SLEEP_CLK				57
-#define GCC_USB3_MOCK_UTMI_CLK				58
-#define GCC_WCSS2G_CLK					59
-#define GCC_WCSS2G_REF_CLK				60
-#define GCC_WCSS2G_RTC_CLK				61
-#define GCC_WCSS5G_CLK					62
-#define GCC_WCSS5G_REF_CLK				63
-#define GCC_WCSS5G_RTC_CLK				64
-#define GCC_APSS_DDRPLL_VCO				65
-#define GCC_SDCC_PLLDIV_CLK				66
-#define GCC_FEPLL_VCO					67
-#define GCC_FEPLL125_CLK				68
-#define GCC_FEPLL125DLY_CLK				69
-#define GCC_FEPLL200_CLK				70
-#define GCC_FEPLL500_CLK				71
-#define GCC_FEPLL_WCSS2G_CLK				72
-#define GCC_FEPLL_WCSS5G_CLK				73
-#define GCC_APSS_CPU_PLLDIV_CLK				74
-#define GCC_PCNOC_AHB_CLK_SRC				75
-
-#define WIFI0_CPU_INIT_RESET				0
-#define WIFI0_RADIO_SRIF_RESET				1
-#define WIFI0_RADIO_WARM_RESET				2
-#define WIFI0_RADIO_COLD_RESET				3
-#define WIFI0_CORE_WARM_RESET				4
-#define WIFI0_CORE_COLD_RESET				5
-#define WIFI1_CPU_INIT_RESET				6
-#define WIFI1_RADIO_SRIF_RESET				7
-#define WIFI1_RADIO_WARM_RESET				8
-#define WIFI1_RADIO_COLD_RESET				9
-#define WIFI1_CORE_WARM_RESET				10
-#define WIFI1_CORE_COLD_RESET				11
-#define USB3_UNIPHY_PHY_ARES				12
-#define USB3_HSPHY_POR_ARES				13
-#define USB3_HSPHY_S_ARES				14
-#define USB2_HSPHY_POR_ARES				15
-#define USB2_HSPHY_S_ARES				16
-#define PCIE_PHY_AHB_ARES				17
-#define PCIE_AHB_ARES					18
-#define PCIE_PWR_ARES					19
-#define PCIE_PIPE_STICKY_ARES				20
-#define PCIE_AXI_M_STICKY_ARES				21
-#define PCIE_PHY_ARES					22
-#define PCIE_PARF_XPU_ARES				23
-#define PCIE_AXI_S_XPU_ARES				24
-#define PCIE_AXI_M_VMIDMT_ARES				25
-#define PCIE_PIPE_ARES					26
-#define PCIE_AXI_S_ARES					27
-#define PCIE_AXI_M_ARES					28
-#define ESS_RESET					29
-#define GCC_BLSP1_BCR					30
-#define GCC_BLSP1_QUP1_BCR				31
-#define GCC_BLSP1_UART1_BCR				32
-#define GCC_BLSP1_QUP2_BCR				33
-#define GCC_BLSP1_UART2_BCR				34
-#define GCC_BIMC_BCR					35
-#define GCC_TLMM_BCR					36
-#define GCC_IMEM_BCR					37
-#define GCC_ESS_BCR					38
-#define GCC_PRNG_BCR					39
-#define GCC_BOOT_ROM_BCR				40
-#define GCC_CRYPTO_BCR					41
-#define GCC_SDCC1_BCR					42
-#define GCC_SEC_CTRL_BCR				43
-#define GCC_AUDIO_BCR					44
-#define GCC_QPIC_BCR					45
-#define GCC_PCIE_BCR					46
-#define GCC_USB2_BCR					47
-#define GCC_USB2_PHY_BCR				48
-#define GCC_USB3_BCR					49
-#define GCC_USB3_PHY_BCR				50
-#define GCC_SYSTEM_NOC_BCR				51
-#define GCC_PCNOC_BCR					52
-#define GCC_DCD_BCR					53
-#define GCC_SNOC_BUS_TIMEOUT0_BCR			54
-#define GCC_SNOC_BUS_TIMEOUT1_BCR			55
-#define GCC_SNOC_BUS_TIMEOUT2_BCR			56
-#define GCC_SNOC_BUS_TIMEOUT3_BCR			57
-#define GCC_PCNOC_BUS_TIMEOUT0_BCR			58
-#define GCC_PCNOC_BUS_TIMEOUT1_BCR			59
-#define GCC_PCNOC_BUS_TIMEOUT2_BCR			60
-#define GCC_PCNOC_BUS_TIMEOUT3_BCR			61
-#define GCC_PCNOC_BUS_TIMEOUT4_BCR			62
-#define GCC_PCNOC_BUS_TIMEOUT5_BCR			63
-#define GCC_PCNOC_BUS_TIMEOUT6_BCR			64
-#define GCC_PCNOC_BUS_TIMEOUT7_BCR			65
-#define GCC_PCNOC_BUS_TIMEOUT8_BCR			66
-#define GCC_PCNOC_BUS_TIMEOUT9_BCR			67
-#define GCC_TCSR_BCR					68
-#define GCC_QDSS_BCR					69
-#define GCC_MPM_BCR					70
-#define GCC_SPDM_BCR					71
-
-#endif
-- 
2.45.1

