Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8E1CF31AE
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98B67892FD;
	Wed,  2 Oct 2024 11:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="YOeSimUn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F41D4892F0; Wed,  2 Oct 2024 11:53:03 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0321E88F64
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cb2191107so53312035e9.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862781; x=1728467581; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r89WCchYnGI6BgzDG9MdlXzKq/Cdf2qHdtrU8P8PCTM=;
 b=YOeSimUnfnx2G56cWFe+V5bVg3plLN8pYIhL8W+tMxfQ+cUJUlxrGD+v/xZd2o7ofF
 QOBQ40/tz53MjFhvgWCCM2mdICnpGKcBlbzW49HVTvYQA1a6Fs6dumtbqt9Lu6jK8142
 mLrzGY9XDrSa7SlW75eBkSyR5JA+wghT44h2u9GzClEbdyA5wMdxyDMj/Uhl5IW99Vgz
 tG96787kfActd/ZCSmgUirybAkySaIkTqo+RbMLTvyj5woURtXdJdN8Xnj6DBHf+BVBS
 DJ9MmZOoqoIzKoNhn3Y0tM6meDvvi0e7XXKj9smC1lYrtvItgi4sXY8qa9Km5tRldlDJ
 qbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862781; x=1728467581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r89WCchYnGI6BgzDG9MdlXzKq/Cdf2qHdtrU8P8PCTM=;
 b=Gn/F3NC2eCAm4oIzR7swM/UKZn2ZdkLsM42isyWpA4DtXNmrS32hWe6Tp3C4ZIK73J
 l21y6HYrsIN7qZGmcc4b4kDiAsM0YaN44e71I81yg6GorNPL2dAAw3eTPtzEWqBV4a39
 dm0Dqx1RT79AJ0iBHMui/bLtUuCNt7V+lsN5pnIDpYSBYeEuvFT1nHd6dRtw/GtLVAcS
 0g2B01bMVDpXhcHz2jqk/9l+V2LlPyh+Z6SrZd6eJBahDBQnJIj9d7TPC4Gdcau/Rk/O
 ufOntja1QUjO5d8YHk7DvrTe95A/eVCKG/VBvDBc2Qm4QchqBoizyVMJOBGfNCLG80aN
 facA==
X-Gm-Message-State: AOJu0Yw66BWtjyPb3e9yf6PuoawGIlUvks3FHDwh6OXVYcnL3QU9ImYS
 RLRqlZWu8B8vRDIgREGp46Tis4+tKpYwhJ0uRyWkM6dPQjJN7UV9Fzop2twIXmds3bM9X3fsp2q
 w
X-Google-Smtp-Source: AGHT+IGKjjuDV2RZMupPOL5v6RKHPT1oMXqti0rPKBuepMffX9NC+CbMdK8cLk5bR45vO2FuNs62rA==
X-Received: by 2002:a05:600c:a02:b0:426:66e9:b844 with SMTP id
 5b1f17b1804b1-42f777b66a4mr20856175e9.8.1727862781331; 
 Wed, 02 Oct 2024 02:53:01 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:53:01 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 34/37] arm: mach-bcm283x: Enable ARMV8_MULTIENTRY
Date: Wed,  2 Oct 2024 11:47:25 +0200
Message-ID: <20241002094832.24933-35-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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

