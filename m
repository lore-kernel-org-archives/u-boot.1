Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21A8C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 20:40:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C442F8319C;
	Thu, 22 May 2025 22:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mBh4VgH3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A5BA831BF; Thu, 22 May 2025 22:39:59 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A54B8319A
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 22:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso59551325e9.3
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 13:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747946396; x=1748551196; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CIvraxDESJYPfl/cBWPKkUEIkEHq063mcgz79rXVZrM=;
 b=mBh4VgH36n2fEYmB3J3pPLOivJUbGAuvJ3rA/eGEip2p89R7IuK1g/N8WCLaKpt+eJ
 +kmZmsqWn0yARjBnph0evTIKOiPhxZ6w5pypVJ7R9oMmH6Qv+9cxeY97qTrNStQKgLqh
 bRqVkhOmidcl05MQN/rIvo9pmrs7IguidNi6HdCSEQs2Jjb161YbFN0LI5s23tMnyFig
 42o95WjIGL4C9gAV4g5aAp2ai5r6qW8EzbqY77SO9B5l/6DO8vlxGi4kVDFzTdhwbZNs
 Ina2FM+Mvf08TpXOSr8EuVd6GKDwEO8R29bhyo1H9BEzguR0Lw0wADjH6LXIKwfBUe/o
 RdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747946396; x=1748551196;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CIvraxDESJYPfl/cBWPKkUEIkEHq063mcgz79rXVZrM=;
 b=tKpks1+cSVwwNkO/SZMp1l1b8N/sY4aaJtW5eFuPTjUyfJUTknQNjGdWEKRsJaiO92
 dg4QHAKxFu/pYGNhkmtcAFKyiDqwTiJHowGQKPVv8YDdgGl7HgxsWKGmmqZqKV/kkLzZ
 fRMn8T81ktVPi5Fry3FfoI0Yp+tz0FrvBIDZp0dRWgcD8ner229P8fn6/6rj0I5rLFnO
 SvhZ5OmAIHb1DeKkryHM5UCORGK2Sq5HulhZH0gZIQZLI/LputA+kfLnnyVjOm/dfiFM
 Dl8BQd6g/fqnhJzNaTZs9UN9zJwt397FlXH05qQ0OGgyYlcDY9mZahBe2nALGIDMFv+q
 870Q==
X-Gm-Message-State: AOJu0Yxol9a1NE1kdj26osHikIwau7oR0LcxM2lWp3UPja9OW0yMgZBW
 hp87hsNKrSVeo0unJORrCbeGUSobAwgY9ZrT8bt6SXw9eoEXiZgqwOWmTlq3ZENTD4s=
X-Gm-Gg: ASbGncvsmbOmv0hc2uctSemvLEA4MjjOgyR5MqvR3F6/JFQLeQNaRPxAJDWBGAuQGaU
 uCNt1C2l+27/Wd70qXFOr9HhxAAN+HvGWEMie+K3OPz27y7spLjd4WSMGrzrIeAKw7wSeMwE7/A
 WQg1nhp4BmPn4oOp/MRDhGxSTsQIyCA9nu/k8hrr4Uf+vSAQzniyaIowX94UrlIDAL9gs8DbaZb
 eMjhXlzU2p03NDl3IfJQLesQ5r2BZ+nPQX3hcH7fWjuuvi39b3/XKY6GLEk7MOYfPvaMbhBbXgT
 +P8cVrBKlVnTIlpCGAM+7zu6xK7/4skFRoLHIlZ/j4PummFp911xDFg6EhupDBHlFAqJDOTCpGk
 nIjZTmDLYVpJWFnsSAw==
X-Google-Smtp-Source: AGHT+IGdPF5GZqaDfPNHaupZyb/QCIJxeYulAyQ6MhQ+Bf8r40+CEMwxm0bOdV3SA4Q6He6UP0l/lg==
X-Received: by 2002:a05:6000:420f:b0:3a3:62af:7c39 with SMTP id
 ffacd0b85a97d-3a362af7e45mr21837951f8f.31.1747946396477; 
 Thu, 22 May 2025 13:39:56 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863A39.versanet.de. [94.134.58.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f05581sm117304575e9.13.2025.05.22.13.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 13:39:55 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 22 May 2025 22:39:41 +0200
Subject: [PATCH 3/5] configs: qualcomm: use fragments for debug UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-b4-qcom-tooling-improvements-v1-3-8141b8955cfb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2552;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=SWqKxUIKWnCnowlynSX21OjBq2T3z//usaZR/9DmWy0=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoL4uW2SzCGahHww4syg1QC/VVq+fu9Wp6/XRum
 VLg4TTDn+KJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaC+LlgAKCRAFgzErGV9k
 toC7EACX963v4PdjwEP3dgMwmJ0a8D2sXY7y722wX+Vud2PmI73G7DTJnNWzMDJmi1ybhIuB6fX
 spjPrmpec2ofLiqoU7nKWVIIIO7krSOJwbucMX02+7jcbRrXMs0P8EKJm/CimvfAq+jEfhPhlf3
 g2kM4x6jDv6L/kpGC1OEi+7WXUau5i5i4Pnh72iUZli3Sp95rIzwjSaBdxR9N9xKFGTABCATQsP
 xBAAwu7MAy53K3Ee6UcedqtZGn6ppM8cWALXbdxDTsPuOVnrkUiQQoYZbFjJL5Jj0NHiIj22dJN
 fu55fWIkXaQPay7zWAupSzj4ywGBxcMuSYPmmskxRHymIm0VTyL/SIg3zULmeHQaxH8CfgzkJdt
 GTqgPj3SWXXakEHEOllY5ezsHZH6n6KJpszEX6A+A+ww21iVRqvV2dHLOCA6fL03pGpWLw4LTzY
 7mFFYYpHZw5rNQ+SO4A225gpChkKVVr5IY3XMrnCTLeH1yVyKR/YTYL/qJyLKe/f5yFFrfZOfNk
 sdvnw3gdS8dc99rJD4YfQRDBsGDj502bDRClSC/buC8T/DVqSuK9d5amB04UZZw/l5YX/RhpO4u
 72mUXtTYUeuBURJaKgrRySHLXcMgH6GrZ+XNz3d+JMK4ZhgX8HMQsk5Ai5mX1QU+otEGMG2zByp
 eBoRhK2f21cbkZw==
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

The QCM6490 and QCS9100 targets always enable debug UART, but this is
not really optimal for typical users.

Move these debug UART options to config fragments so that they aren't
enabled by default.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 board/qualcomm/debug-qcm6490.config | 5 +++++
 board/qualcomm/debug-qcs9100.config | 5 +++++
 configs/qcm6490_defconfig           | 6 ------
 configs/qcs9100_defconfig           | 6 ------
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/board/qualcomm/debug-qcm6490.config b/board/qualcomm/debug-qcm6490.config
new file mode 100644
index 0000000000000000000000000000000000000000..9ea54758794ef9d2f698cb4026da44be2360147a
--- /dev/null
+++ b/board/qualcomm/debug-qcm6490.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x994000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
diff --git a/board/qualcomm/debug-qcs9100.config b/board/qualcomm/debug-qcs9100.config
new file mode 100644
index 0000000000000000000000000000000000000000..8ca042b440d100e9583ff9504f1b0e67a491dfcf
--- /dev/null
+++ b/board/qualcomm/debug-qcs9100.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0xA8C000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index ba26924da161b1c4b5378955185f314b05cb1006..22afa7be1a944e5e0d712ef8aed21ea2b7fa2fa1 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -7,14 +7,8 @@
 
 # Otherwise buildman thinks this isn't an ARM platform
 CONFIG_ARM=y
 
-CONFIG_DEBUG_UART=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_BASE=0x994000
-CONFIG_DEBUG_UART_MSM_GENI=y
-CONFIG_DEBUG_UART_CLOCK=14745600
-
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0x9fc00000
 CONFIG_REMAKE_ELF=y
 
diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
index 10ff4d2539803143c8b770b6b28e8dc52b1d5846..4ceeba63ec12cebbc2124eb256a255450500152f 100644
--- a/configs/qcs9100_defconfig
+++ b/configs/qcs9100_defconfig
@@ -4,14 +4,8 @@
 # a dedicated "uefi" partition for edk2/U-Boot)
 
 #include "qcom_defconfig"
 
-CONFIG_DEBUG_UART=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_BASE=0xA8C000
-CONFIG_DEBUG_UART_MSM_GENI=y
-CONFIG_DEBUG_UART_CLOCK=14745600
-
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0xaf000000
 CONFIG_REMAKE_ELF=y
 

-- 
2.49.0

