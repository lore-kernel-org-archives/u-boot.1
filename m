Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52024CCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA9F188DC4;
	Thu, 26 Sep 2024 10:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="EepuNEiq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB9B088E11; Thu, 26 Sep 2024 10:03:39 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FE5888DF3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c5b9d2195eso816063a12.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337815; x=1727942615; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wxDsb0af6ASC4Tdyl9uKHE2f8Nvd40cAYOhWqjEiNgw=;
 b=EepuNEiqowhk6lPq2JA+GW6XimvwOMykLseN7JnMr2O/yYy6PsRAQIQwOiVbibJaRv
 QPvXNk4YAve0+Ry5PbvqSm/ZR5a7eCxYj94OR5lLiCTPF+C4jhXmCSwZYgFnnW2KkUyn
 h+czeaKJJqxkHNuIH8EEoLZdUx4LAJnzYGmCdvDdljKdeZYycacuZKBy2lq5YxNZ30ZW
 ysIXE7cUdPxlhg03RUZMrsXLuC7WityIMdjWzQqm7UdKi+Xkris8xU3jmto2NEUR4lzb
 lslqtKE4H4UFa7wXMdDsCWaEUy7i1eN/89jxp7jOJCOZTanuMvLP8IpPX4CvwGK4+XIA
 AKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337815; x=1727942615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wxDsb0af6ASC4Tdyl9uKHE2f8Nvd40cAYOhWqjEiNgw=;
 b=VN4tnvArWvrhu3aearTG1cPD6mcjVzT88C0LxIMdjwTw1p7yHo5pNJoAG0qd5KXYBH
 AxLf9TisxZAg11vFia4m86AUz4rMZp0cEtKRF3ougDaR529Kwim0+aDnsa5qEGps4Pj3
 ay6vCcwq6WUq2sXE231aElprtEiRJkQ3043dHn9Kt5Zvhr9BV+xOq1p2MhZaR+5g/lQe
 mIiNRV3QK88r69sSzjF57Bnje4WfYeQzlVFGOXqVBx774tuYrdE2Ycssnfu3u/Q6Js8n
 v/PbaPzM2VfSwBH3FikLe/vlGxuFP3bQVj9pU0BdmJSSAnZoma1WNP/+Qdj8r4SskEA7
 n8Ww==
X-Gm-Message-State: AOJu0Ywi9SCLlBwRLwhlySdfZ3zKFSxywu3xu2Wlwiih1e1cGGzSGfia
 9W4ww/zFgUbfnaYfowx/1v/Q8GblMRxM9QWRZXWCqF8GFGuHC+8m18cAgRk6Kgf3XNFK04h9Qxr
 6re0=
X-Google-Smtp-Source: AGHT+IHd8r9QKY1ZS3S8Rb0EzaWCRxo77kXDGL531GbKbxGSNoqrKfCnE08RFzmXOUvXFpAmNJQeAQ==
X-Received: by 2002:a05:6402:27ca:b0:5c5:f95a:5a97 with SMTP id
 4fb4d7f45d1cf-5c720582a06mr4503161a12.0.1727337815004; 
 Thu, 26 Sep 2024 01:03:35 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:03:33 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 33/36] arm: mach-bcm283x: Enable ARMV8_MULTIENTRY
Date: Thu, 26 Sep 2024 09:59:21 +0200
Message-ID: <20240926080021.148031-34-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
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
2.46.0

