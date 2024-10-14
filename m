Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8657D16260
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E718891C4;
	Mon, 14 Oct 2024 15:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="XUS1e6IY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C578F891D3; Mon, 14 Oct 2024 15:13:13 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E95489063
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539f72c8fc1so951244e87.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911589; x=1729516389; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r89WCchYnGI6BgzDG9MdlXzKq/Cdf2qHdtrU8P8PCTM=;
 b=XUS1e6IYxdP9IDlTQTQ/228rjPdhSXDbW4zv4mDgUhhkRjEAqLizGz/hcp9cg5WBu3
 PeP4SZ5KQ+v8V5cf9643SJXsjZcio/JEkO/we13zKbWStPN38JCcqL19d1Q3ORhihF/T
 RwcUsNpaScr1+kSGu1KFOHcDugvNKp+qnpg8HCcvPHlDnOn1HMVyc1kQ9jbvbVqMHqtS
 xigZ7P3MX4715tXxOOu9HuksAJWlb2eLUSUzUyIIRv1gYW5NX9Q5DfVkVBI1aqKdcbWZ
 6iZAWjemS3Pnc6oI/FdFsaIAEaCfiRLBVCFLBnH9JIRoeZqLYL33hYBdFrw/0Hhkpv5T
 Y8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911589; x=1729516389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r89WCchYnGI6BgzDG9MdlXzKq/Cdf2qHdtrU8P8PCTM=;
 b=R1HZmaFN+w9pNRYollCNt1KMqehcDQr+SW2uXEy9cLH16jnAp1RvX9zw3XdBPH5pes
 cSNeqx7oODE/XhNIJoczC3UJ/RjA2UgNnph75bR55NoTqhsLhhop53G6JqiTY8FDg+0x
 yuvi+PZCCTMh6c+duM1D5ZOwXiAsj86rc9YD4qeP1Xkpgyf/BItO3/ZdV8UGUOAAQL7O
 VfayhDw+L28bG85b7KCsZqS2x2jt44gULQ1WhJj8ZRi7hh4LL437UjMNJf6ENvfUC+qM
 zwrpQGFUXCbcso77sF9LpRmYpx+OYAfWpGdbHeLjg2pleFpgZP178041ZJFcNX65qjiG
 piMQ==
X-Gm-Message-State: AOJu0Ywm/RPHMXtsv5OztAyz0/aOwX+MmsVxYEWU8K0dLfaN3BOOoRur
 klmvVfjbkUvTNJnxrHpvQs7TIGY4H16OUKDc+ieCokymzRyiEgM9t7wcxaF/LGR7Wj1M/p+VpgD
 r
X-Google-Smtp-Source: AGHT+IHDm+MuSzASTQCBQFFUZj5vIgBB/bAidNziQAT/SYoYwSPJjGFFOL4YDKozW+/2ofPI/F+a8g==
X-Received: by 2002:a05:6512:1107:b0:539:f630:f233 with SMTP id
 2adb3069b0e04-539f630f38fmr1853711e87.57.1728911589484; 
 Mon, 14 Oct 2024 06:13:09 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:13:09 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 34/37] arm: mach-bcm283x: Enable ARMV8_MULTIENTRY
Date: Mon, 14 Oct 2024 15:10:50 +0200
Message-ID: <20241014131152.267405-35-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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

On FDT platforms the APs are brought out of reset using the spin-table
as defined in the DT. On ACPI enabled platforms there's no FDT, thus
enable the ARMV8_MULTIENTRY and BLOBLIST to use the ACPI parking
protocol instead.

TEST: - APs enter Linux when run on qemu-system-aarch64 -machine raspi4b
      -	APs on real hardware do not enter Linux, but continue spinning in
        their ACPI parking protocol spinloop. To be investigated.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-bcm283x/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-bcm283x/Kconfig b/arch/arm/mach-bcm283x/Kconfig
index 0ef8156c64..d9303e8c28 100644
--- a/arch/arm/mach-bcm283x/Kconfig
+++ b/arch/arm/mach-bcm283x/Kconfig
@@ -27,6 +27,10 @@ config BCM2837_64B
 	select DRIVER_GICV2
 	select ARM64
 	select CPU_ARMV8
+	select ARMV8_MULTIENTRY if GENERATE_ACPI_TABLE
+	select BLOBLIST if GENERATE_ACPI_TABLE
+	select BLOBLIST_ALLOC if GENERATE_ACPI_TABLE
+	select BLOBLIST_TABLES if GENERATE_ACPI_TABLE
 
 config BCM2711
 	bool "Broadcom BCM2711 SoC support"
@@ -47,6 +51,10 @@ config BCM2711_64B
 	select DRIVER_GICV2
 	select ARM64
 	select CPU_ARMV8
+	select ARMV8_MULTIENTRY if GENERATE_ACPI_TABLE
+	select BLOBLIST if GENERATE_ACPI_TABLE
+	select BLOBLIST_ALLOC if GENERATE_ACPI_TABLE
+	select BLOBLIST_TABLES if GENERATE_ACPI_TABLE
 
 menu "Broadcom BCM283X family"
 	depends on ARCH_BCM283X
@@ -213,6 +221,9 @@ config SYS_SOC
 config SYS_CONFIG_NAME
 	default "rpi"
 
+config BLOBLIST_SIZE_RELOC
+	default 0x20000
+
 source "board/raspberrypi/rpi/Kconfig"
 
 endmenu
-- 
2.46.2

