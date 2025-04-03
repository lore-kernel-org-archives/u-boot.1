Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BA8C3601A
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 14:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CBC1810E8;
	Thu,  3 Apr 2025 16:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TL6jDAUT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C80D820DE; Thu,  3 Apr 2025 16:28:30 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74907807B1
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 16:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 700D23F716
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 14:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743690504;
 bh=IJPR9lhjLT5tC5Wh92cMWPi9Be7zajtPTWnOvcAcgdA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=TL6jDAUTvxIaVVNnYcxGDWy6qCCAAR0n9KUL0Us2zWwf3x5CoPMipEVYHqzGBEb+4
 d+oQzhfneMuPozL1t5EvCwK8iR9UGn+cmeTzt/oQU3jiRELyPA1pgw+3QlmPd1KP3Y
 k4aODB18T5KuUYup9aQxjuE0YPUEAq5yNUllpxkomp4dO2yW6uHVyf53lW0j74qtCy
 m6qOWNmrGHhVAE7fkPP9q75VXNaofoXhND9k3KNWrVxld9eqv/oTlafpcJYjNKjNWS
 vGNtdyebpLoxrkuDrcuoXCTBm+sScSnjYJUa4z+JnW4q4r+QUcnf0a251ZQZ5ol+QT
 /CMJelo5iPecw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso6848715e9.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 07:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743690503; x=1744295303;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IJPR9lhjLT5tC5Wh92cMWPi9Be7zajtPTWnOvcAcgdA=;
 b=PksnB8zVqQpbkvoXI+Vs4Gw3Qdn6s2oNqC9QphftpHJIjRrwXiRDsNcZa4ZwGBcIeb
 BfX2+A0079eMu9uBkYXaM8z0SvzyJrwUEriIc1dZt8CvmGxwnETzv3tGpNgjB9WMYI18
 HFWneEXUzkage0Xc0bxOJqjW5gmsKxFdSJD+BaI87LSY7LFYrUwk4kBre1SzoMb8IWRE
 dkHAoxeWrSm6K/uTE80Miqq6ENM4AP/Eyz+MEKiyLKjh4l5aWZzm2wGpjZakHiCADG+h
 V9BLd0pb1xXmvkdu9im+LiWkTCM52mjofI2I8fzDpQV7/cR+2ksSH1joVyiCraDGHEIy
 fQtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+FmtUv7JcfMsCH+c03u/LwOM3zAae7Z9bmxBMjGRnhaHbwCgTZId8y+Toj+u5XWvf20qseh8=@lists.denx.de
X-Gm-Message-State: AOJu0Yza0y1BrYkSks3o0JOfCEW+p31vqqBn+H6c8kd9lo+CtIROrHAg
 /gEioyBer5EYwlgztarmEmFraKCU03FhIRMdHTvtN29uZF4SNgsoihELGPx2BGUWlI07B2f+TJP
 TsQsC65FDXVtKotniBd6jnNpWS4EivJzuLgv7GrG0WxMCGzCsXa+kSG+sMiqHV6ACYs2OTcdGf1
 o=
X-Gm-Gg: ASbGnctMHlJ0uBvZQGE+TD9/Cz7Y57GS9MiZYvz28OmBCSNjBYc3OR1d0E3WP1xta5j
 HBYE6fkKrNbAlQ1d0DS9kGJ9UobFEbzX399WLWk+BQnPI4Jngk3tS3nEUfD0/MFZNKLt9AC9vG+
 2AksvDO0QPEuwVuviqoM7DXhgh3SF/07ctLbulKBR9tH77IBiMaq17jkrrV2KnJVfDL3qQ2WXo3
 0YqjUwpAQtnXO5t1ubV+f6ANTssaYlOMY59Go/cvc6OEz8LQVC7epN9f9fPZDgxMtHBvQVVr0pf
 guEfxj/mYkwJ0jRf2/8cFr9mEfF87ymfDoO+Ww==
X-Received: by 2002:a05:600c:6548:b0:43c:fb95:c752 with SMTP id
 5b1f17b1804b1-43ec40eeed4mr24032485e9.3.1743690503612; 
 Thu, 03 Apr 2025 07:28:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyaK6iqZRLZ4nJnnDHStk+oh1A5syTeoCuNWemRRd8nVsRavGzgU9XKqyRFzkj/VNdfagt9g==
X-Received: by 2002:a05:600c:6548:b0:43c:fb95:c752 with SMTP id
 5b1f17b1804b1-43ec40eeed4mr24032295e9.3.1743690503245; 
 Thu, 03 Apr 2025 07:28:23 -0700 (PDT)
Received: from workstation5.. ([2a02:3035:6e0:be7c:f00:839:af81:4bb8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34bf193sm19890745e9.24.2025.04.03.07.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 07:28:22 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] configs: qemu-riscv raise CONFIG_NR_DRAM_BANKS
Date: Thu,  3 Apr 2025 16:28:16 +0200
Message-ID: <20250403142816.1057084-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

The number of memory banks in QEMU is not bounded by 1.

In this example we have two banks:

    qemu-system-riscv64 \
    -machine virt \
    -nographic \
    -m 8192 \
    -smp 8,sockets=2,cores=4,threads=1 \
    -numa node,cpus=0-3,mem=4096 \
    -numa node,cpus=4-7,mem=4096 \
    -kernel u-boot

As we will see RISC-V NUMA systems using U-Boot
we should be able to emulate these.

Use the default value defined in /Kconfig as 4.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/qemu-riscv32_defconfig       | 1 -
 configs/qemu-riscv32_smode_defconfig | 1 -
 configs/qemu-riscv32_spl_defconfig   | 1 -
 configs/qemu-riscv64_defconfig       | 1 -
 configs/qemu-riscv64_smode_defconfig | 1 -
 configs/qemu-riscv64_spl_defconfig   | 1 -
 6 files changed, 6 deletions(-)

diff --git a/configs/qemu-riscv32_defconfig b/configs/qemu-riscv32_defconfig
index 1cd80f5769e..e937f9439d7 100644
--- a/configs/qemu-riscv32_defconfig
+++ b/configs/qemu-riscv32_defconfig
@@ -1,6 +1,5 @@
 CONFIG_RISCV=y
 CONFIG_SYS_MALLOC_LEN=0x800000
-CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x20000
diff --git a/configs/qemu-riscv32_smode_defconfig b/configs/qemu-riscv32_smode_defconfig
index 6f871c83644..a71b938acde 100644
--- a/configs/qemu-riscv32_smode_defconfig
+++ b/configs/qemu-riscv32_smode_defconfig
@@ -1,6 +1,5 @@
 CONFIG_RISCV=y
 CONFIG_SYS_MALLOC_LEN=0x800000
-CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x20000
diff --git a/configs/qemu-riscv32_spl_defconfig b/configs/qemu-riscv32_spl_defconfig
index 9906f8b2dad..e014eda0777 100644
--- a/configs/qemu-riscv32_spl_defconfig
+++ b/configs/qemu-riscv32_spl_defconfig
@@ -1,6 +1,5 @@
 CONFIG_RISCV=y
 CONFIG_SYS_MALLOC_LEN=0x800000
-CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x20000
diff --git a/configs/qemu-riscv64_defconfig b/configs/qemu-riscv64_defconfig
index cdd511b0e72..e90ec0ac27e 100644
--- a/configs/qemu-riscv64_defconfig
+++ b/configs/qemu-riscv64_defconfig
@@ -1,6 +1,5 @@
 CONFIG_RISCV=y
 CONFIG_SYS_MALLOC_LEN=0x800000
-CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x20000
diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_smode_defconfig
index 2f62f17bc8c..24c92f6d5b4 100644
--- a/configs/qemu-riscv64_smode_defconfig
+++ b/configs/qemu-riscv64_smode_defconfig
@@ -1,6 +1,5 @@
 CONFIG_RISCV=y
 CONFIG_SYS_MALLOC_LEN=0x800000
-CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x20000
diff --git a/configs/qemu-riscv64_spl_defconfig b/configs/qemu-riscv64_spl_defconfig
index 27e092bd208..bfb4613b68d 100644
--- a/configs/qemu-riscv64_spl_defconfig
+++ b/configs/qemu-riscv64_spl_defconfig
@@ -1,6 +1,5 @@
 CONFIG_RISCV=y
 CONFIG_SYS_MALLOC_LEN=0x800000
-CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x20000
-- 
2.48.1

