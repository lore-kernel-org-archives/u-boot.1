Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A48C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 20:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 269FA83192;
	Thu, 22 May 2025 22:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="omqx3UAj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 747AF83164; Thu, 22 May 2025 22:40:00 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80967831AC
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 22:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-442fda876a6so61223825e9.0
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 13:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747946398; x=1748551198; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EG1Afk8ASZD+2R4axfnpOPh/hqmFMZB1dxHwCt9VZyQ=;
 b=omqx3UAjjXjZdMriEr9+JiCgHPwL4ccVfohjSM3ITuX1yTMFmQbekolizM2F5txLFw
 iTd8KJf92zop6bFP2F8V7eN78XUGcqh5OG/ahzbgwjnNFR5tMK9CiUN7TSjJlssYUgOn
 9zECkQ7nxSzOYGSEpRTTaZ2q84Y10hsUtLwz5Y810iIWdM5JgU7nFtTx4gE/ughmWx0Y
 BDfCojLy15IbCy3cwUzVN+Hb9LjOrCpbdiaKWwpUE/8+rcr2ROtoTXPzDBhJSkPSFiym
 8ZxsZZINEwTruUC81z/U5FlkcZAfMwUJ1llUVJ4uYe1mwIrfQsaLsAQVuy/kxYP6nxD1
 E7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747946398; x=1748551198;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EG1Afk8ASZD+2R4axfnpOPh/hqmFMZB1dxHwCt9VZyQ=;
 b=aoPVS+zJaaHi/GhUhUHioD1P2aEi9AGB00ojudUteMmz/NGPiEwYaC3VaSFzLFGpGu
 To39Ytx3L+siecn6EKRoC3ePSaO8SviAI4MmmfezpaDHckugyBq5Tetsb7ahMUJI/u6T
 qLDVZAbdbRCbckmXGl4zxHRH02Qm/2XKKHfvE6BDhKJLQZs6dazIA2hJoyfmf4LR9dtn
 SP7ckQ5gx/bhl6sT6opv9uSB6cAO7zs0VLa3lua5GJyXUgCbB70sMwXnjcmhepFWXYrp
 dmmMmqXT5uFhCpgBN1yATgEPkFMRy82W9hqTGktbR2sJiQ4zYHA+vn9FxN7neKC+LCKf
 AzkA==
X-Gm-Message-State: AOJu0Yx1nBqUjwNSQJz7+9WFZRf4uNguphui3++wbnJIhrPeHHUfmph2
 XuAy0YhelLZm4mc5ZiCsh7y+Kn9EeezVMBwHd6APiTi5EjhswU9FDEHqe+REEhmoo8M=
X-Gm-Gg: ASbGnctXA0k0Z6WWuiYB58RF2NQbJ6MIuS6hH8Mms6bkCTRewRp/zHZvI+hK8DGTYbF
 MWVFPICPZ9x2u7yJn0oLudcyQixydSst6Vs1lGsZ9w1y6mUc3PHxCnvvQXdBHtX3FvKI9DxtKs8
 q5brMAO92ZonFBF82Xy+EpYqR/3/f9gEM3vkJMVgQldHVoccd8vb7Pc85YMIJg/38NtrTW18LQx
 QBrgY9rqIVh3rbXxzxO+ANbafoDJ0YxWKIVkYqNN4QfwXnXJ7OnyoHeul6SMUiqINHhE63aXrtg
 6F8rtiUAMhdeWgLBtRjelGdXZP0Ja3rQ0Dxxv2OYhe7saop4Q3JGBrVHnUvFWCRuvzdV2VsLJLl
 OuWn0jf05GTnoazXRgQ==
X-Google-Smtp-Source: AGHT+IFFBqwKLmgNLdCC1wUyarNdTh2n0r+q4/TlH2otw2r0snXlREPqXA+sHa1MRJhzv+sdw1fxnQ==
X-Received: by 2002:a05:600c:64c6:b0:43d:878c:7c40 with SMTP id
 5b1f17b1804b1-44b6d1d44aemr4237745e9.10.1747946397920; 
 Thu, 22 May 2025 13:39:57 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863A39.versanet.de. [94.134.58.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f05581sm117304575e9.13.2025.05.22.13.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 13:39:57 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 22 May 2025 22:39:42 +0200
Subject: [PATCH 4/5] configs: qualcomm: use mkmbn and stop creating ELF files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-b4-qcom-tooling-improvements-v1-4-8141b8955cfb@linaro.org>
References: <20250522-b4-qcom-tooling-improvements-v1-0-8141b8955cfb@linaro.org>
In-Reply-To: <20250522-b4-qcom-tooling-improvements-v1-0-8141b8955cfb@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2336;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=XRIzuC+RSDKreOaduDI0IMUTCC1zqMUF1Bfsr9gVX0k=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoL4uWPD0Z3pJdJbUiJBz90gnEimgscNfIPcQZm
 FfPd2AcVmyJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaC+LlgAKCRAFgzErGV9k
 tvDOEACGnb/yz++WlYBP+dwCuvQzBaiSVS/+cF+uUYj9Gohth5FHUPzJnvGuzdOoZrDktJ9tHOY
 ds/QCsl8sJl5Cy+p+jFCvI66Ah16AXOQZ/WL947fHvMWzUECBKLjJgOMOXnT+7Rd35K9jEtx7eA
 RcAWmuE/wnzmR0detmt7pVfInPJpbOQAzRf6H4hGZ9Mx3zw6SucR1/ttRzZcYPFwdJqlYBo9/k8
 i+gJYAEOlwwSBvj3sRdkxBU9qApqOeUD5No6cYT0cCTXMYBFVc+s0bBeXnCZFz9/FJy/7rMch2r
 2abiMcJ8HiDna6gaYlyOVQIzyYvtU80GllVOp14m3uhdjvC6gpgkQQbQeB3RxdhAAWHGeGX9ML6
 Lqb1ind0klFa/ua2kaWCooAwFrAI4EnRZ/KTtmwT9eVG3Q3FVj96jcWTYvUwdG66PkYVwCJtDuR
 irWpIDTX9qUJKiFqMeOCaVgRM/FcKKdvGAdOHFUxwWmUOMYVo1MzIOoTH30rsO4ABZCY952Vaw1
 1a2yGF9L75GnduYLndEm+6utot5hP4sPoX6JcaOHoU2+Hbxi05iZzOXTFR+8PUyPAGFmIvesad9
 0bDUBPmGbqoaQLDnsEs5Nz3ad459chPdxD/7uFStJdv1PAHOWcExyXrCeNvsesVSk2WslVOIa4W
 /G1rv99rgFDGTkg==
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

Remove qcs9100_defconfig since it is now identical to qcom_defconfig.
Additionally remove the load address and REMAKE_ELF from other Qualcomm
defconfigs.

For these platforms you should explicitly build the u-boot.mbn target
which will have the correct load address and Qualcomm MBN signatures.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 configs/qcm6490_defconfig          |  4 ----
 configs/qcom_ipq9574_mmc_defconfig |  1 -
 configs/qcs9100_defconfig          | 12 ------------
 3 files changed, 17 deletions(-)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 22afa7be1a944e5e0d712ef8aed21ea2b7fa2fa1..b9d0ca113a798582a83cccd3aa19c2a94b771b64 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -7,12 +7,8 @@
 
 # Otherwise buildman thinks this isn't an ARM platform
 CONFIG_ARM=y
 
-# Address where U-Boot will be loaded
-CONFIG_TEXT_BASE=0x9fc00000
-CONFIG_REMAKE_ELF=y
-
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
 
 # Enable capsule updates
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
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
deleted file mode 100644
index 4ceeba63ec12cebbc2124eb256a255450500152f..0000000000000000000000000000000000000000
--- a/configs/qcs9100_defconfig
+++ /dev/null
@@ -1,12 +0,0 @@
-# Configuration for building U-Boot to be flashed
-# to the uefi partition of QCS9100 based dev boards with
-# the "Linux Embedded" partition layout (which have
-# a dedicated "uefi" partition for edk2/U-Boot)
-
-#include "qcom_defconfig"
-
-# Address where U-Boot will be loaded
-CONFIG_TEXT_BASE=0xaf000000
-CONFIG_REMAKE_ELF=y
-
-CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"

-- 
2.49.0

