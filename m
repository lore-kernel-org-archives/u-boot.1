Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48C9C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19A0F882F9;
	Tue, 18 Jun 2024 17:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cKlpislH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48A8688381; Tue, 18 Jun 2024 17:23:23 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8E5180245
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52cc9b887f1so221821e87.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718724200; x=1719329000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vBrQJT9urUhd8FrZqL5N4WyzQzPeSa05bfcPqluQjtc=;
 b=cKlpislHL3a4OFmQdO7mKGLluSMnM8qVGcyv3IYE62cPxptwRcbFMeqg6/6EtufCpK
 qtkhoD3L/PMYsfRm+twCfhwECU2juG4pr9nShRqMxFcv7cq0iuVyuCap3cRwXOr3MAEi
 kk2U85zG4CfHdKrJAogzbyQQokKVe1EFnZ89o47AYY+QXkTuoLn69SrYwSnRUeiqoKRy
 pFFk6el4i67c9FGXcwf+Kw6wEhWGAjuXRdv/1aq0/Qd7CkqIdSz+CPa92tHSaACHHJht
 ILQkhlS4lAL3j6ZUGZYk8Ecup8w6VE7VRM4M9iBEYv9AUQaxHjQ947deIv20XFFtJP38
 QgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718724200; x=1719329000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vBrQJT9urUhd8FrZqL5N4WyzQzPeSa05bfcPqluQjtc=;
 b=ghZNaydPIdt0PxS8adMHdBAOYwOQWbZJ8r+yXJAMgF5d8jADU4PbHalSKToV7jD3UR
 Och0hlbJstllIMbXdvMFpx+kBqdlLB3eJ/y6c2fzTuXZroMiMaJMoPDsJW+iTlr8Yf8u
 EvX4nUZY5Qslq9VQSH9XLDwYhDMftMpgCvdM9sjodgyKnDm8+GHCwHfbxZiq5LGGGUKz
 y1ZCQTjZmHUlxYJGlTe/U9cuZaY6Fy3seQBXzqbeMNn3waJL+zerbpntyTJLIz2bPAAa
 AYzjP2XIjzOk3VFMyQ/QoHPy3EATjALVkWVNTrrgtJTY51E5PVYLyi/9uTi9Yh+8Vkkg
 6rlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOp53ARytSjv4SCO8Y5PH3C5Q/BmOkkyh1k6kiriLUbRabof5VxoVEVG0HB9YGTQm3EtggigpSCiFVqALX87wA0CxKKg==
X-Gm-Message-State: AOJu0Yyet38VPva0LdCVp+oXF2o91Y3raB9x1J2k3byFv+RsNdYnaSz5
 K0hkKrlwvg5o42gdwHwj+83yWcWvWGPHG2n2+NGXkslKwIX+imMOc0/eG+Ohnh8=
X-Google-Smtp-Source: AGHT+IF9nZTYLyxdfZVW+ObnfuDsvZdwbTP54bRzjna9UJWBCpY2kmzqweUlko70ZOoB58J6cAlVhA==
X-Received: by 2002:ac2:5e22:0:b0:52c:99ed:4c9a with SMTP id
 2adb3069b0e04-52ca6e99288mr7499448e87.59.1718724199599; 
 Tue, 18 Jun 2024 08:23:19 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286eef9eesm230355265e9.9.2024.06.18.08.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 08:23:18 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>, u-boot@lists.denx.de
Subject: [PATCH v3] doc: describe UEFI measured boot
Date: Tue, 18 Jun 2024 18:23:13 +0300
Message-ID: <20240618152314.10140-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

We currently only describe the process to enable measured boot using
bootm. Describe the UEFI requirements as well which predate bootm.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v2:
- add all bootX commands in the description instead of just bootm
- Remove and extra _ from the header
Changes since v1:
- fixed remarks from Heinrich on titling and DTB measured PCR
 doc/usage/measured_boot.rst | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
index 9691904a9d8a..d31cb05226cd 100644
--- a/doc/usage/measured_boot.rst
+++ b/doc/usage/measured_boot.rst
@@ -7,19 +7,42 @@ U-Boot can perform a measured boot, the process of hashing various components
 of the boot process, extending the results in the TPM and logging the
 component's measurement in memory for the operating system to consume.

+The functionality is available when booting via the EFI subsystem or 'bootm'
+command.
+
+UEFI measured boot
+------------------
+The EFI subsystem implements the `EFI TCG protocol
+<https://trustedcomputinggroup.org/resource/tcg-efi-protocol-specification/>`_
+and the `TCG PC Client Specific Platform Firmware Profile Specification
+<https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/>`_
+which defines the binaries to be measured and the corresponding PCRs to be used.
+
+Requirements
+~~~~~~~~~~~~
+* A hardware TPM 2.0 supported by an enabled U-Boot driver
+* CONFIG_EFI_TCG2_PROTOCOL=y
+* CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE=y
+* optional CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB=y will measure the loaded DTB in PCR 1
+
+Measured legacy boot with bootX command
+---------------------------------------
+The commands booti, bootm, and bootz can be used for measured boot
+using the legacy entry point of the Linux kernel.
+
 By default, U-Boot will measure the operating system (linux) image, the
 initrd image, and the "bootargs" environment variable. By enabling
-CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree image.
+CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree image in PCR1.

 The operating system typically would verify that the hashes found in the
 TPM PCRs match the contents of the event log. This can further be checked
 against the hash results of previous boots.

 Requirements
-------------
+~~~~~~~~~~~~

-* A hardware TPM 2.0 supported by the U-Boot drivers
-* CONFIG_TPM=y
+* A hardware TPM 2.0 supported by an enabled U-Boot driver
+* CONFIG_TPMv2=y
 * CONFIG_MEASURED_BOOT=y
 * Device-tree configuration of the TPM device to specify the memory area
   for event logging. The TPM device node must either contain a phandle to
--
2.45.2

