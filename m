Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0877DC5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 16:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3708682AB2;
	Mon,  2 Jun 2025 18:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZUcszn7m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 177F282AAA; Mon,  2 Jun 2025 18:11:11 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C3A81F32
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 18:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-450d37d4699so21020065e9.0
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748880668; x=1749485468; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EG1Afk8ASZD+2R4axfnpOPh/hqmFMZB1dxHwCt9VZyQ=;
 b=ZUcszn7mQNMS312MLRdMTw1ZCGtOs+0Wzfog5bP7VpC7rGxhaSrLs3vN3A04cJLUIs
 EI+PSGQaZmsTMx4i+5CfknhYHJXbRGbFQZ8hLMooBcSCMYsl3N5sxiMpTN6zwweaKUPT
 JUbQ3/4L0qKX0THJe0xBYJAhGJwAi1YcCQ4TkA2m6o3p4EAt83W3FdTwCt5zm5kWUbHc
 jNPgfTPW+jvRj3MkMWcjLVOjssqroaTWmVL/0WND6ZChUqehVMZjUCwOaJ42gLXHr1Yr
 bl/kNLXOC5s4Lvi4uv6ZX4xWZxUlbryJc8q2WFaIDa3ZNewJdwBZ/svGUjPANDJ4swd7
 yR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748880668; x=1749485468;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EG1Afk8ASZD+2R4axfnpOPh/hqmFMZB1dxHwCt9VZyQ=;
 b=jkQR5OLxOy8W8nirHcXnhTGQiZ0KYKSp0c5SrefMZSujNWm3dco2JXfrTsqzYirPkb
 2pKloOnq8fHBhusDrAWUeJyqoadLrMVCH+P7N1221Ces+zmavY0b79340WvLTiizj7jM
 L1b30+AI2iKzIfvxEEx+5LzDOYJ3ygyhAm6utsiM+re8/K68+sIH0TDe9+jzdmYr2dXa
 ozPG8gZrK+k6J7RrHl7XTMTpifzPZPv2Xb67tqmopKkG/SwjEwAff5pOIuNuwx1lBd+K
 VAwLDYA3cPLy6TVzWD0efGS3UJxoFuwmufHERtoGDLFYZH02ypatwpMx4lE5rRVUOUC6
 ciHQ==
X-Gm-Message-State: AOJu0Ywt5AIPKhWqBcWF1RmPgqiSYS6alV3QXA0IfEjz5OrSAZyZRRlk
 E+PnjOb4CAFADZqnKyKslAvYmOyVEgXaD9e8+o9C2PIs+R7Kn4e5V0byT+4L5t9xqK4=
X-Gm-Gg: ASbGnctvN8Zc/VrgHNIsNObdoIDYtfYKDrfUdkTy/FGkpfjKxpg6EDpZ3UWg/QjDUEK
 kAJ6CNgC6R5axMigtLTiL3jioovhbVhRsW65HP5z4gADjMovXZvN8bf9E6Gk/DTVf+i0wIyFLBN
 P0K65hnJnLGiRr9CkDd3eT/T+Nox/mn/yB0Fs/v36u39T68ufKSbSBVa+QhoURxJGoj8ON6SlCp
 5p+v+QGFAfU2taJ6eQSj6KlI8SlhwENghibCSKOLfFQbJegqV6lIm3fTQHaxNzkI3G+MoyI3Vb9
 otuDSbpMxJeh2GezHtnRIQGr0euPgNl8suFt6DtE8yyY7pgKFH/sscMtijr5NSXnwkoke7eCuj1
 5T5pHSfzf8Msu
X-Google-Smtp-Source: AGHT+IFJ6u+1r8Jf0BifHrn+EPYzflNe8PYG2nitPh30+l0o89yPSDZExecl7QsAE+0PIVsBYkACzw==
X-Received: by 2002:a05:6000:1447:b0:3a4:f722:f00b with SMTP id
 ffacd0b85a97d-3a4f7a02565mr11190356f8f.11.1748880668404; 
 Mon, 02 Jun 2025 09:11:08 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a01:170:117e:fc:3688:a9e2:523f:a049])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b962sm15212138f8f.7.2025.06.02.09.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 09:11:07 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 02 Jun 2025 18:10:57 +0200
Subject: [PATCH v2 6/7] configs: qualcomm: use mkmbn and stop creating ELF
 files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-b4-qcom-tooling-improvements-v2-6-c7d19c0d4a8b@linaro.org>
References: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
In-Reply-To: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
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
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoPc0SX8xvPp9l5pFoTiIPU/CSTmqxxhiZRcTf1
 g1FhPrjisaJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaD3NEgAKCRAFgzErGV9k
 trbDD/9Wh05QNhkN4hcI9ajOtRyBh5rEc9m0kQYvBd0pP/AvYfzIOY7SJmVvbsUFT+kSr4CctKe
 nvkwo/ilVXTrJIWrp0qWUzHDkhiWnHRdJseqywvZ+NjbdCDTifPWrnKZbzciY+N3YRoZ7oa9iUQ
 sqqvsxt62rn5ZaDaZU3KHnpRTYboBz1YFCWJm7ngJJP8opZSu7OJI4b8zrtg5bjDKzwynDxmJ72
 mga4qV1bD7d0RS9L+yf0DSTtiGaFMmoe4oXgpgr2N/TiKBsCWXvq/LD1sD9qO73stD431uSI8XF
 O97JisrZPBlX39UzHJuz1JdA2Z0O99QEsrsgReremzlhhJ3l1/tt8PnnXdcqPMAj6BXI0VYsiDM
 3tPRBIGsv/VOtBti+OpqnZ1g2CWlJC14IL46w0wD92jXQd475C1QuIH3Ps874Pb/aw0ub9H70P4
 5nBv93LXyKN2iAdntZlE3oMVAJ0Qi2JbLVgQiO/28Mo5OK1X/kyMM2vjYxaTcpT8BqPfF9/LMpp
 Cl6/Ts+gZd8VSgPwuZuQN0MIri+7Do0vStQsBUS5r1rGglSzM6QWbirKemBBXFj8xk6rqs73iQB
 Oz6MFP2jlDHZrVQA1dJ92egBGaY6QBZH5EaXu++PYWnsu38+BIYxf/5PtX0hVWEPISlrp0JqjLT
 2vDX03JF2yTxwgA==
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

