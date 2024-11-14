Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70C2D65C7C
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 11:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C11B89612;
	Thu, 14 Nov 2024 12:51:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="gHyCWtju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B74D895F5; Thu, 14 Nov 2024 12:51:02 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E5C989608
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 12:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2fb5a9c7420so4864351fa.3
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 03:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1731585059; x=1732189859; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glYXEayqGkBtz456cbuvUKBsWkcTQ22t9hjB17rfES0=;
 b=gHyCWtjuY0ZTBhbIyF0+D6fLRhT6ElpLXQ+Cah4RcfDCtbFopoQVE3nUXsd+FiLXXn
 N5uagPEKi3Jz2+nA3+aXlel9fFMJQ+5dxMMKil5EZ9Oo/ek8k+zh3Br03zgjznYCTwoM
 p2ZeD2LO30tHQyob0D8NyTJ4Ow9E7AWgqc9p0qHFE+Ugy+2tmbbCBQwLyZOJb61dGyzq
 +6xKoHS7ZcwDFYXxBEswPrLZEJbTnUWyeUACX+IS1JQwOcJuY7y3ahlKWwmFGM+iFWW5
 PTvJ4mdrHRHQQEgTkVHv0YCL6Bssc+75IgWHOwVtOy5CAc6XKqA9xwQxGrQtrwGqJboT
 +q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731585059; x=1732189859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glYXEayqGkBtz456cbuvUKBsWkcTQ22t9hjB17rfES0=;
 b=cX59ubeF6+FzlsbgtfafmQ8efTrAjWzxDXkanYsM07DRIlRCtkE9RM0TD5GB0pEe1k
 twRxI8YpqR10lJl0nF81vrGgQwYhMW16R1B58XSJqpq77VG5K/jfwk7VfyCHO5EqSK2M
 7IQW8OP3LOzK2VzPlhVNjmhdSbluEYwe0/zROth3ZxESmcJPmGEFB92F/tzl2kcTGcCA
 swQM7dobmf0gAOZOAgKdKUcT+llusvGxkzmDOgcr8edoWiLwTKtAXwAuM1D6BYBP0nih
 J4rPKXhQIwiQ0PC9iCfH6V2zAHaYK6kKi5HqqFibXGxZMW3BVqXgTp13AXjTIMTnJxX3
 Cfgw==
X-Gm-Message-State: AOJu0YxgDSfjxvyew4Z+rj6P+EjjTmy/jnECywZXf2jnqmXDbu0VmbIJ
 whoVboICBq4w/8y4V5+K39VEv/MvAh8zSSBTGnFGpGzZMH35mBBTp7imr7X3I+c9ZsjMZY9tWuF
 7
X-Google-Smtp-Source: AGHT+IFspEyTejkgZCLtommDM5f/pH+/3nIJQkw2zRdShb2Sfmy9z2sylsDfuwd/QxBbA1P7uD/h9A==
X-Received: by 2002:a05:651c:411a:b0:2ff:59e6:b9af with SMTP id
 38308e7fff4ca-2ff59e6bae9mr7017201fa.33.1731585059582; 
 Thu, 14 Nov 2024 03:50:59 -0800 (PST)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab76dafsm17954735e9.10.2024.11.14.03.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 03:50:58 -0800 (PST)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Bin Meng <bmeng.cn@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] configs: Add QEMU riscv ACPI defconfig
Date: Thu, 14 Nov 2024 12:50:44 +0100
Message-ID: <20241114115049.2070780-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241114115049.2070780-1-patrick.rudolph@9elements.com>
References: <20241114115049.2070780-1-patrick.rudolph@9elements.com>
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

Build test QEMU riscv with ACPI enabled.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 board/emulation/qemu-riscv/MAINTAINERS |  1 +
 configs/qemu-riscv64_acpi_defconfig    | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 configs/qemu-riscv64_acpi_defconfig

diff --git a/board/emulation/qemu-riscv/MAINTAINERS b/board/emulation/qemu-riscv/MAINTAINERS
index 3d7453f1b4..83c5f6f864 100644
--- a/board/emulation/qemu-riscv/MAINTAINERS
+++ b/board/emulation/qemu-riscv/MAINTAINERS
@@ -10,3 +10,4 @@ F:	configs/qemu-riscv32_spl_defconfig
 F:	configs/qemu-riscv64_defconfig
 F:	configs/qemu-riscv64_smode_defconfig
 F:	configs/qemu-riscv64_spl_defconfig
+F:      configs/qemu-riscv64_acpi_defconfig
diff --git a/configs/qemu-riscv64_acpi_defconfig b/configs/qemu-riscv64_acpi_defconfig
new file mode 100644
index 0000000000..7594b84322
--- /dev/null
+++ b/configs/qemu-riscv64_acpi_defconfig
@@ -0,0 +1,25 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x800000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
+CONFIG_ENV_SIZE=0x20000
+CONFIG_DEFAULT_DEVICE_TREE="qemu-virt64"
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_SYS_LOAD_ADDR=0x80200000
+CONFIG_TARGET_QEMU_VIRT=y
+CONFIG_ARCH_RV64I=y
+CONFIG_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_DISPLAY_BOARDINFO=y
+CONFIG_CMD_BOOTEFI_SELFTEST=y
+CONFIG_CMD_NVEDIT_EFI=y
+# CONFIG_CMD_MII is not set
+CONFIG_CMD_QFW=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_DM_MTD=y
+CONFIG_FLASH_SHOW_PROGRESS=0
+CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_ACPI=y
+CONFIG_GENERATE_ACPI_TABLE=y
-- 
2.46.2

