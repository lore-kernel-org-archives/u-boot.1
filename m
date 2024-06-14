Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB04C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 09:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5951988993;
	Fri, 14 Jun 2024 11:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="onnXuu0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00ED7889A2; Fri, 14 Jun 2024 11:40:39 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99E9288991
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 11:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-35f23f3da44so1816202f8f.0
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 02:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718358036; x=1718962836; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a3VAu3452EYj3StLYM2MCrNVWbFfM3CFBmatFjAMTx0=;
 b=onnXuu0CRlLSeHDCBUNx7cFmIfIh9d80IPBs9xKG2iTiJ7xv2eOr6x2344/KaNMtni
 DBT4nUGMSTNcmurAaG3IqTVDltqaj4cTjyguB0KJ+jXGq2wMZoXsETJLBjb9802gRS5N
 gY2ct/4a7PQEwro1VHHKhvcmGZK435M8XRmf8MtU3utsdoH4niL938YbfcYcNfi3QrFv
 QeWn0J0+ivMkuI045Kv5sEvRp4mH8gO6K8RuPkvDKtYqHC5eyLnSxaxhNMh9okZDOMzj
 wXHlxq0El7EJKACwno+c+HYwRYc4qwBfhjhXbjKjK8FXC77b7UMi47UjAZFUfZSvKZh8
 /m2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718358036; x=1718962836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a3VAu3452EYj3StLYM2MCrNVWbFfM3CFBmatFjAMTx0=;
 b=HnGocowQePHMwQXiZflLm7T3uzTZBzBSEIHGl69qWomfoRFLsjJFizxfj+hGt6s8tu
 KJH/fXanJG/8pLBEpQ8cuaypiiPuhvrM3Er+4/ucIlirqVviRkM92Db8qQihS6keyQz+
 KrrMs5mEZ81TcPN22eHM1O2C0O07SBGv547CIru29j3zGMWLX6j7blU7S9+TA+lyxGPb
 qdpofm9mkus/O4o4ZrUfJNujxiK+eB8h68Tp8SMcZSnis9QxQJAG9lS3Rq4yLMh8FkDf
 cRB7BxEW3y9OOAahEUXnBXCwUDriX30PF/OCvet1+aE0EZZt59RxgDEbMhvsQ4ddP8IE
 cHLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoCXYlu8sX8yFYTw12+Se760mkQWgFHuGdBjKqaZiFA//rTEXJTYVeceQgxaC9Y0jyI3fINjs7vB1Jz9aqlNGnFvKPRg==
X-Gm-Message-State: AOJu0YwCajRkTbfNfImYyo6z7Spq0VJzs9lbTueqfQOI5yaNjRAROKIJ
 IpV5YevchJylXAljyZA9Njz8NJ/uL552Xs7OcJRQkylR58iMzs/RX1aPq2vhI0U=
X-Google-Smtp-Source: AGHT+IGR1sbti5o1aib0DzjGNI1g7+61ZT8R583jgNX9BxCnc1iEVAssTQvIx1UhGzdt/5n+8vdGug==
X-Received: by 2002:a05:6000:d09:b0:360:7a0b:9bd3 with SMTP id
 ffacd0b85a97d-3607a771d52mr1345713f8f.0.1718358035844; 
 Fri, 14 Jun 2024 02:40:35 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750ad177sm3871451f8f.56.2024.06.14.02.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 02:40:35 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Eddie James <eajames@linux.ibm.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Subject: [PATCH] doc: describe UEFI measured boot
Date: Fri, 14 Jun 2024 12:40:30 +0300
Message-ID: <20240614094031.6013-1-ilias.apalodimas@linaro.org>
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
 doc/usage/measured_boot.rst | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
index 9691904a9d8a..1b5dd1dcc438 100644
--- a/doc/usage/measured_boot.rst
+++ b/doc/usage/measured_boot.rst
@@ -7,6 +7,26 @@ U-Boot can perform a measured boot, the process of hashing various components
 of the boot process, extending the results in the TPM and logging the
 component's measurement in memory for the operating system to consume.
 
+The functionality is available when booting via the EFI subsystem or 'bootm'
+command.
+
+UEFI subsystem
+--------------
+The EFI subsystem implements the `EFI TCG protocol
+<https://trustedcomputinggroup.org/resource/tcg-efi-protocol-specification/>`_
+and the `TCG PC Client Specific Platform Firmware Profile Specification
+<https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/>`_
+which defines the binaries to be measured and the corresponding PCRs used.
+
+UEFI requirements
+~~~~~~~~~~~~~~~~~
+* A hardware TPM 2.0 supported by the U-Boot drivers
+* CONFIG_EFI_TCG2_PROTOCOL=y
+* CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE=y
+* optional CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB=y will measure the loaded DTB in PCR 0
+
+bootm
+-----
 By default, U-Boot will measure the operating system (linux) image, the
 initrd image, and the "bootargs" environment variable. By enabling
 CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree image.
@@ -15,8 +35,8 @@ The operating system typically would verify that the hashes found in the
 TPM PCRs match the contents of the event log. This can further be checked
 against the hash results of previous boots.
 
-Requirements
-------------
+bootm requirements
+~~~~~~~~~~~~~~~~~~
 
 * A hardware TPM 2.0 supported by the U-Boot drivers
 * CONFIG_TPM=y
-- 
2.45.1

