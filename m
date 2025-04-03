Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0989DC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 14:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D2482075;
	Thu,  3 Apr 2025 16:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SpiDPEnK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FB998210F; Thu,  3 Apr 2025 16:48:04 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F60282006
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 16:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9AE303F698
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 14:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743691680;
 bh=GfoiLoPSn6LLdmSPM6vk8kfnk63FB/u7Py/piElEM7I=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=SpiDPEnKsN+gNX685yUKSQMJJ+ZvVdJtEt4b7Bo9hXhQW1BAHQKo3OX+ybFj5YbIc
 zlkBz6mBkFyBC2tPLR+p04oTJbk/8JWD+GwnTFQNfuOsTC6uvaveHFBsUvc3vvV4vl
 O5A/KR7q5VOlkIXHxaDQUfo4XkbaiH9lqGfst6kVthm70L2rmR2aDvvJSYo84cRIVp
 vf0Qz+vRlrnRZPeAeHBrWD2C7yddpMqwVKPCM/Nko9xRV8XsE/S3faS8L4vuoJ0dpZ
 lYFed7cHvE8nf4jdPEDHLz/l5o+L3ZZIZ0J6IFBoVTRC6Il+O2r+2TO9jPYzhaWsrD
 xLsdKtdqMXcog==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ce245c5acso11837625e9.2
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 07:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743691680; x=1744296480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GfoiLoPSn6LLdmSPM6vk8kfnk63FB/u7Py/piElEM7I=;
 b=D2KWpvWltFBRTLfUYMsyLJ3B1iAMJuoDr7Yn3c6YZILbe9cUhB9ted+jFhBAubLOLp
 DxrZEHk0A0ioMtJZqSwvsUE7WsiNfib/nTvBZIaNj6dAkLHk1BEmEgMhheG2AgQYyLel
 pCm29sb21TnqdonvlTn74LzQg7/O3KPE9ifZd1H+2UzgLkwoAjE8CaAer0p7/+hlpwxc
 6G9WGbOFw1RtPVT+WFIiFnfOBs7VjbQqj2ek/7FYq52lptQE1iDfRsKxUT+sOVCKfA4e
 PBNUqTeAoPFKv8jlmKjVcS/GQRsDQYgw31PcUDBR8T0aR+cqkxFVKW68JvRG0f16aebE
 iMMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWltBvMZ1CiPIc/saUqP5j0EOTqFUSSSfb9lKt4CQeURw2CCIJXnlnbYR4/DW+dy7VlLdzz2H4=@lists.denx.de
X-Gm-Message-State: AOJu0YwFXxTCic0BNYCmWclczy0ire/zIGwMC70WOaGMBdmRMkhazEah
 gxtZ7Po8idRJ9JiTUQWIJ1lT+ISEgirx63Ap7rvW1kRnh4kPE8R41glJuhAFbyYCzAqWk3QkEXd
 nac/A/tN/hY3FNT7mG5CtxO3SO8vXxck8FhYXkE9Fu5XkUSjHZNWVN8Qrz/Ro2HjfuFA=
X-Gm-Gg: ASbGncvz/NTZgi+vrk8iG812x3WtpAqo3w0A4wDZ+m6NAVUYFnOdzMqCQ30CA//VR3D
 511BvOctBujs6V/V1IN/34PMk2UKHGA2FTnSyuUBq6dxu3GW6fvpe6DSSC4zOUpJobHLenC/AFi
 yUqtkFDrnk6DhXiPdcMBsgP2sTd/Uy+DzytOH+pK4Innvrw50n6ek2Lga3DVUaXGRhq0XOjqRj3
 HRadxHUv8HGL5c24bM3802dr3iLN8+zOX0X6Gdvi1ph0Gt959qX7yxU3oGd8Y/VA8rsmR4R1r6l
 5WLXmzKCDarjyLAnaCV6Q12IXG6ukBKAFwaLWw==
X-Received: by 2002:a05:600c:4e87:b0:43c:f5fe:5c26 with SMTP id
 5b1f17b1804b1-43db61d8249mr182142905e9.4.1743691679793; 
 Thu, 03 Apr 2025 07:47:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8tzd7QF0V+xQxL1VPPSLCbhQM0lumEWsLUdOw1FqnSgjukbVzSgBMX2wBWyyCHvinTiHBJw==
X-Received: by 2002:a05:600c:4e87:b0:43c:f5fe:5c26 with SMTP id
 5b1f17b1804b1-43db61d8249mr182142615e9.4.1743691679437; 
 Thu, 03 Apr 2025 07:47:59 -0700 (PDT)
Received: from workstation5.. ([2a02:3035:6e0:be7c:f00:839:af81:4bb8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1698081sm23653645e9.17.2025.04.03.07.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 07:47:58 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] configs: qemu-arm raise CONFIG_NR_DRAM_BANKS
Date: Thu,  3 Apr 2025 16:47:53 +0200
Message-ID: <20250403144753.1065007-1-heinrich.schuchardt@canonical.com>
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

    qemu-system-aarch64 \
    -machine virt \
    -nographic \
    -cpu cortex-a72 \
    -m 8G \
    -smp 8,sockets=2,cores=4,threads=1 \
    -object memory-backend-ram,id=mem0,size=4G \
    -numa node,cpus=0-3,memdev=mem0 \
    -object memory-backend-ram,id=mem1,size=4G \
    -numa node,cpus=4-7,memdev=mem1 \
    -bios u-boot.bin

Use the default value defined in /Kconfig as 4.

Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	correct title %s/riscv/arm/
---
 configs/qemu_arm64_defconfig | 1 -
 configs/qemu_arm_defconfig   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 03028c76acc..6c9d2505a69 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -3,7 +3,6 @@ CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_QEMU=y
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_BLOBLIST_SIZE_RELOC=0x2000
-CONFIG_NR_DRAM_BANKS=1
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_SECT_SIZE=0x40000
diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
index e09f54e0685..2d642f86ba6 100644
--- a/configs/qemu_arm_defconfig
+++ b/configs/qemu_arm_defconfig
@@ -3,7 +3,6 @@ CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_QEMU=y
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_BLOBLIST_SIZE_RELOC=0x2000
-CONFIG_NR_DRAM_BANKS=1
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_SECT_SIZE=0x40000
-- 
2.48.1

