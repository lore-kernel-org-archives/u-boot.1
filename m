Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1F8D2069E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B37E188F45;
	Wed, 16 Oct 2024 08:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="YePgSzPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D96B88D70; Wed, 16 Oct 2024 08:13:43 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29D2988D70
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c9625cfe4dso6014086a12.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729059220; x=1729664020; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r89WCchYnGI6BgzDG9MdlXzKq/Cdf2qHdtrU8P8PCTM=;
 b=YePgSzPnkFtuT7DVKj2ab9rzPQf3aNzp0pd8xlEmkiIvAqVLFCyMgzFARHA9viCknv
 eVUeS+VBcu9QrV/2WFJO2fh9XmQdLFQe8/AP/WYX/n/9JLaUefF97pl9BgX+kqMK1Viy
 RCxoSCdkyG2nk5fDqAgqqGAJwmafh9WbXSkoyATvkuDil55L/iGCSOXhTMmkU4hW6WDx
 SAXtIQWgSwX9k/9X/a7UiEUD4CgbNo+phw+cDl0owoFe2wQ84lT6c4TNpxCoqoIW0IXm
 Js/7QZKogPXob++s52uM1MTfgYDjpLS6LhswqOrOJvEUkHxbGAKaDqe9yawOl6Usx3eF
 G0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729059220; x=1729664020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r89WCchYnGI6BgzDG9MdlXzKq/Cdf2qHdtrU8P8PCTM=;
 b=WCZYJVUJK3KfhRw462SdE2H8t3Z3jwjVFLCSTu8Vr+/BpCT1U0U1Q4HGP/tdmqfUyN
 hE72cVDzQZZOE2YOwWVoxygXUfHfgZTuUx0l0T69HuwgYGaiactlV2yN+cvRHk6ildZM
 4XLCDDtwZB4N2M7FMuA+ecSxg+ns7p1B/7X/9uApHY86pRv3uWeCIwZS6cqpibGU6kCw
 AwWi/oKLyNoAVDGvM7dnY9KhraJKFqgizsM2Dn/wyE/FBQpQwLYbMrx8aGhzuaKM2JoU
 ODlPuJEvTYyG0oVoaWzRqClJ1f2UKNT2uQ5SWuECD9pP3mnbuDdmnCpFSM/szFxXkrbG
 r3Ww==
X-Gm-Message-State: AOJu0YyKBay/UgRbecLW9v8UQianj3x22+mWenvr3MOZLrIBiLOzYuuK
 Jkzhm3odlUl0CaWZTL4o7NZOy7zT5jGjfiUgDFHcIYOtCXXdGjl2of2o/D9ZfO5fEcIIrcN8Qi+
 N
X-Google-Smtp-Source: AGHT+IFqEatIT7hZuKdw3Urtb9sgxMhoeiVyzd65xAip8Ql3Sno8w3bxy45jl0Vpo9+gXnUwAZ3BNA==
X-Received: by 2002:a17:907:9454:b0:a99:762f:b298 with SMTP id
 a640c23a62f3a-a99e3e43d3fmr1443237766b.41.1729059220547; 
 Tue, 15 Oct 2024 23:13:40 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 23:13:40 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 34/37] arm: mach-bcm283x: Enable ARMV8_MULTIENTRY
Date: Wed, 16 Oct 2024 08:04:20 +0200
Message-ID: <20241016060523.888804-35-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
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

