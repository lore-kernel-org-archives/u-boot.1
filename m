Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B0EC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD08888897;
	Fri, 14 Jun 2024 14:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZqrcZ8nS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D32F8891B; Fri, 14 Jun 2024 14:14:17 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AABE881BF
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4218180a122so15280655e9.1
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 05:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718367254; x=1718972054; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xK7vL0jPjFD9RiwkpQoc1PmvMEUlR7DyBTLQ20rsSc4=;
 b=ZqrcZ8nSqaOyVAaf4vSgTZLlU5IwZVYXweZNaDYemPrGlbULsYKTw/buYa3yXTj24U
 sX4RRJufgfDyYrti6GAyhu7jAjlv+4gOoCqR97WMbwrP411rO/FAgVupXOtR37kYOcgA
 MTSC4Adxlzs077q6SWcuW5x+8GcyErdGlFzM/4tm+KJ5XeRH1sBK9Er9Ag/GSuefKf9v
 WfwFHS0S6vN9bQzPJ+CTB3r3OXohWC1070qwj1Vdoi3lSdWL3FKkX4NGmZLl02L6QF1L
 KGS9oBWPqhFH0rzSEaB2As7N8sLuf8Slxr7me7aF+BjkKKNqCdGZlBIjHdaQero8M3JH
 t7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718367254; x=1718972054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xK7vL0jPjFD9RiwkpQoc1PmvMEUlR7DyBTLQ20rsSc4=;
 b=Z6wrNHOTeHFi3w4WnCskQIXLCZUufVb0v1DQNnxJie9+KVy+A7glufvIMz2THnW03D
 pMzQkV1hcG4lCmA0xxtnuEYbwCE8/TW+nS0t1DzZ/ARIqX2TUB6MC21siTWdYgIrjMBX
 LsR2T6/sTqbwlkoeQKCT0yT0RduIFY4hezv+9OytKvv/M90viWw/jppXnSvM1JjXddw+
 chpQzgnBLujyogAKW9FfGf8TZzQbWZX7ZXF0AzOCdHE23FO+x3z/rGW+aKJWBnSQK5jF
 FXfEc5IYW3LCeOW9ZiYKKw9hBtKVh1r+aubNHBB8y2CGbkAdBzwl4Ql9jvzsis1kZo3B
 L/JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlq2gWblz/v4cFlPpeNZzIfCJ4uprlNc7lxB2+bwaCiEc6nVNXWSPJTp9WpWN6emtKNVnoIrFcGUxWfxzaV95t4r1X0Q==
X-Gm-Message-State: AOJu0YzLsG4c1CM7y9NyosFQ2YoaCYaXNL1xaqptRKjRSpuNKklMcdwt
 48d5xF8v9WvIDDZvCXVATiyjAw3IVFe5s32PmZgqZZspD/KCPJBj7r6naKyb7Aw=
X-Google-Smtp-Source: AGHT+IEc4thnlFng1pzrZ2LDXKRMjYUF/5N5q2LGSyHlHhxhokGJgu5d6+uxYeEgQJ6O5oJb9TAvRQ==
X-Received: by 2002:a05:600c:33a2:b0:421:5597:ea27 with SMTP id
 5b1f17b1804b1-42304828e19mr26842485e9.22.1718367254486; 
 Fri, 14 Jun 2024 05:14:14 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f61280f6sm59261255e9.27.2024.06.14.05.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 05:14:13 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>, u-boot@lists.denx.de
Subject: [PATCH v2] doc: describe UEFI measured boot
Date: Fri, 14 Jun 2024 15:14:03 +0300
Message-ID: <20240614121404.16952-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.1
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
Changes since v1:
- fixed remarks from Heinrich on titling and DTB measured PCR
 doc/usage/measured_boot.rst | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
index 9691904a9d8a..b5f7b05aeb02 100644
--- a/doc/usage/measured_boot.rst
+++ b/doc/usage/measured_boot.rst
@@ -7,19 +7,39 @@ U-Boot can perform a measured boot, the process of hashing various components
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
+Measured legacy boot with bootm command
+----------------------------------------
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
2.45.1

