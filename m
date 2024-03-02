Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE96C54798
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 19:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A2D687DC4;
	Sat,  2 Mar 2024 20:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="mPpTdf28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB5C487E2A; Sat,  2 Mar 2024 20:17:23 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0C6F87DBB
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 20:17:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8beb=KJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1709407023; bh=TjG8q1BKfylZuviPxmQKQM/j6KLgQb1Cm/XX9Ret7Zk=;
 b=mPpTdf283U1Eulf7p2pLUiwOjxj5ArZx68wT5w06PCHxSJuoF2sKk/3ZUnMEhmT7+tb/fU9EX
 mqBccFkmj0IbmOT3yueep2Xy2O65EiKTLjlX59VaxiW0WwDGFM0P+sU2T5PwGXTyMEp7Ml6TWFi
 DTz1XMzLt8eZ8vHsE8AGJrtpX8pqgit8mNKWr+aVHQV9YLxdWNiPD1xehoCZZvjgzOqizwYSKPM
 iBIQ/Obcz+A3YEdsH9H94OFC1G+I1KbnIl/VP6CuRt7NKAEvNeG5+VgOB/9faSZzd+91ol7MFrL
 gbk0sT4YtDB4FRz9zuombsBr67Rj71mdvswZlaj6fQyg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Christopher
 Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v3 1/6] rockchip: Add common default bss and stack addresses
Date: Sat,  2 Mar 2024 19:16:11 +0000
Message-ID: <20240302191629.322562-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302191629.322562-1-jonas@kwiboo.se>
References: <20240302191629.322562-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65e37b2daae288b7577bf271
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

On Rockchip the typical aarch64 boot steps are as follows:
- BROM load TPL to SRAM
- TPL init full DRAM
  - use stack in SRAM at TPL_STACK addr
  - use malloc heap on stack, size is TPL_SYS_MALLOC_F_LEN
- TPL jump back to BROM
- BROM load SPL to beginning of DRAM
- SPL init storage devices
  - use bss in DRAM at SPL_BSS_START_ADDR, size is SPL_BSS_MAX_SIZE
  - use stack in DRAM at SPL_STACK addr (or CUSTOM_SYS_INIT_SP_ADDR)
  - use malloc heap on stack, size is SPL_SYS_MALLOC_F_LEN
- SPL load FIT images from storage to DRAM
  - use stack in DRAM at SPL_STACK_R_ADDR
  - use new malloc heap on stack, size is SPL_STACK_R_MALLOC_SIMPLE_LEN
- SPL jump to TF-A at 0x40000
- (optional) TF-A load OPTEE
- TF-A jump to U-Boot proper at TEXT_BASE
- U-Boot proper init pre-reloc devices
  - use stack in DRAM at CUSTOM_SYS_INIT_SP_ADDR
  - use malloc heap on stack, size is SYS_MALLOC_F_LEN
- U-Boot proper relocate to end of usable DRAM
- U-Boot proper init devices and complete boot

SPL have access to full DRAM, however, current configuration for text
base, stack addr and malloc heap size used at the different boot steps
are at risk of overlapping, e.g. when U-Boot proper + FDT grows close
to 1 MiB on RK3328/RK3399 or when pre-reloc and reloc stack and malloc
heap overlap on ROCK 5A.

Fix this by defining safe defaults for bss, stack and malloc size and
addresses. A range at around [60 MiB, 64 MiB) was chosen to be used for
bss and stack until U-Boot proper have been relocated to end of usable
DRAM. The range was primarily chosen to be able to accommodate SoCs with
a small amount of embedded DRAM, e.g. RK3308G has 64 MiB DRAM.

Overiew of the new common memory layout:
[    0,   2M) - SPL / TF-A / reserved
[   2M,   +X) - U-Boot proper pre-reloc
[   -X,  64M) - bss, stack and malloc heap

During SPL pre-reloc phase:
[    0,	256K) - SPL binary is loaded by BROM to beginning of DRAM
[   -X,	 63M) - SPL pre-reloc stack
[ -32K,	 63M)   - SPL pre-reloc malloc heap
[63.5M,	+32K) - SPL bss

After SPL reloc phase:
[    0,	256K) - SPL binary
[ 256K,	  +X) - TF-A image is loaded by SPL
[   2M,	  +X) - U-Boot proper + FDT image is loaded by SPL
[   -X,	 62M) - SPL reloc stack
[  60M,	 62M)   - SPL reloc malloc heap
[ -32K,	 63M) - SPL init malloc heap, memory allocated during SPL
                pre-reloc phase is still in use at reloc phase
[63.5M,	+32K) - SPL bss

During U-Boot proper pre-reloc phase:
[    0,   2M) - TF-A / reserved
[   2M,   +X) - U-Boot proper + FDT
[   -X,  63M) - U-Boot proper pre-reloc stack (shared addr with SPL)
[ -64K,  63M)   - U-Boot proper pre-reloc malloc heap

After U-Boot proper has relocated to top of memory we should be able to
use 2M+ for loading kernel, initrd, scripts etc.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/Kconfig | 55 ++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 2c6b045c51c8..edbe3fd30853 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -534,6 +534,21 @@ config ROCKCHIP_SPI_IMAGE
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default TEXT_BASE
 
+config ROCKCHIP_COMMON_STACK_ADDR
+	bool
+	depends on SPL_SHARES_INIT_SP_ADDR
+	select HAS_CUSTOM_SYS_INIT_SP_ADDR
+	imply SPL_LIBCOMMON_SUPPORT if SPL
+	imply SPL_LIBGENERIC_SUPPORT if SPL
+	imply SPL_ROCKCHIP_COMMON_BOARD if SPL
+	imply SPL_SYS_MALLOC_F if SPL
+	imply SPL_SYS_MALLOC_SIMPLE if SPL
+	imply TPL_LIBCOMMON_SUPPORT if TPL
+	imply TPL_LIBGENERIC_SUPPORT if TPL
+	imply TPL_ROCKCHIP_COMMON_BOARD if TPL
+	imply TPL_SYS_MALLOC_F if TPL
+	imply TPL_SYS_MALLOC_SIMPLE if TPL
+
 source "arch/arm/mach-rockchip/px30/Kconfig"
 source "arch/arm/mach-rockchip/rk3036/Kconfig"
 source "arch/arm/mach-rockchip/rk3066/Kconfig"
@@ -549,4 +564,44 @@ source "arch/arm/mach-rockchip/rk3568/Kconfig"
 source "arch/arm/mach-rockchip/rk3588/Kconfig"
 source "arch/arm/mach-rockchip/rv1108/Kconfig"
 source "arch/arm/mach-rockchip/rv1126/Kconfig"
+
+if ROCKCHIP_COMMON_STACK_ADDR && SPL_SHARES_INIT_SP_ADDR
+
+config CUSTOM_SYS_INIT_SP_ADDR
+	default 0x3f00000
+
+config SYS_MALLOC_F_LEN
+	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
+
+config SPL_SYS_MALLOC_F_LEN
+	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
+
+config TPL_SYS_MALLOC_F_LEN
+	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
+
+config TEXT_BASE
+	default 0x00200000 if ARM64
+
+config SPL_TEXT_BASE
+	default 0x0 if ARM64
+
+config SPL_HAS_BSS_LINKER_SECTION
+	default y if ARM64
+
+config SPL_BSS_START_ADDR
+	default 0x3f80000
+
+config SPL_BSS_MAX_SIZE
+	default 0x8000 if SPL_BSS_START_ADDR = 0x3f80000
+
+config SPL_STACK_R
+	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
+
+config SPL_STACK_R_ADDR
+	default 0x3e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
+
+config SPL_STACK_R_MALLOC_SIMPLE_LEN
+	default 0x200000 if SPL_STACK_R_ADDR = 0x3e00000
+
+endif
 endif
-- 
2.43.0

