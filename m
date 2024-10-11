Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B07CFD31D
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F24892EB;
	Fri, 11 Oct 2024 12:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="DiA8C926";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B94E8938C; Fri, 11 Oct 2024 12:35:34 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1745689371
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9951fba3b4so296574966b.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642931; x=1729247731; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r89WCchYnGI6BgzDG9MdlXzKq/Cdf2qHdtrU8P8PCTM=;
 b=DiA8C926QPBrYrKbcMq8SQnkts8/dyHTOuyvFu3BMPUBYXeOJVFpiosUV3uMj/+xZj
 X58h1+ChnONpWfhomuMv2QbOSOWaI05BVk3xmulnczNJSr6rt8miL3RDL+2vm0pVRIwv
 tDboV8IaHBwmkeLiOfhAzisZGe0SblfmG2+wU954qno9fsr2Eh7HsuzloAUp0FiJwDJ+
 EhxLQL9MKlCqQuRHWSVqtwhD00q5DB2+IVElVhLyGPVZZ7qN8SJy+JZ58X2bnI0WniJP
 KgfeDqC4uX/tMQgJBdpzXHmcVpEaQ5doqb4Azfx1I4TvxZYjlQg1AsBZ8MH+3ijobOyL
 bxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642931; x=1729247731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r89WCchYnGI6BgzDG9MdlXzKq/Cdf2qHdtrU8P8PCTM=;
 b=fFnuHDYW0w6/5enE+3dQSEzuZonG1c+8OaHhhpe3wYNnD0vZqXppoIB3HFbyrV+XfW
 iELzSqXkGhQ5wYA5rN8TB0GkkT/pgm75NTkvHqSa/m+zmrmVEEYzr+O97OP+jBK/LIK8
 wqm3noDJxFh0li8mXjQjORb50PJpRDAy52pMXUkrzoLkpwrRXaZyaHLtk9up44W18+3d
 AJhb9EO9oHx05FJZG1An2+5SLAK6E6/O0u1LeayXmj/6HoBzeguFc6lf9szQz6KtZ9Yr
 0rY8TFY5OPeaZVJRSee2jlQR+dqZoYL8yVmkuAat/VgWmGoVAiIBoDCpajT90dva6Fwz
 QA9A==
X-Gm-Message-State: AOJu0YxnK/+/sKsFU+jqH73X+4hEGWQeerDeOiMhw5VWn5S93t3+YuIi
 5TQPhzeoXLwBO9LyBh1If7wYQUHPBgt0OCyBXkiiY4z6l+2ntforwPkXGEOYACNz7PedK+94moY
 ECL0=
X-Google-Smtp-Source: AGHT+IHcpx3gnOfB91o0OO3XC0RzVVjiDs4J4xmnicdYJQjr6xUNf+ZfVz/hYqb2bt0AQTgIvGdYww==
X-Received: by 2002:a17:907:d3e3:b0:a8d:250a:52b2 with SMTP id
 a640c23a62f3a-a99b943ca69mr181753366b.6.1728642931235; 
 Fri, 11 Oct 2024 03:35:31 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:35:30 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 34/37] arm: mach-bcm283x: Enable ARMV8_MULTIENTRY
Date: Fri, 11 Oct 2024 12:23:15 +0200
Message-ID: <20241011102419.12523-35-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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

