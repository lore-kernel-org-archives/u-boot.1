Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFF4C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 10:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8538E88E85;
	Thu, 25 Apr 2024 12:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B46D28865A; Thu, 25 Apr 2024 12:47:02 +0200 (CEST)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8fa8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEA968865A
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 12:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VQCGW2kHJzmR7;
 Thu, 25 Apr 2024 12:46:59 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VQCGS533zzr81; Thu, 25 Apr 2024 12:46:56 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH v4 00/11] rockchip: Support getting DRAM banks from TPL for
 rk3568 and rk3588
Date: Thu, 25 Apr 2024 12:46:23 +0200
Message-Id: <20240425-rk35xx-dram-atags-v4-0-331401a58e8e@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIA0KmYC/32NQQqDMBBFryKz7pRoElq76j2KixijhhJTZkJQx
 Ls39QBdvgf//R3YkXcMj2oHctmzj0sBdanAzmaZHPqhMDSiUULVGukt9briQCagSWZilNq2Y92
 Oyso7lN2H3OjXs/nqCs+eU6TtvMjyZ//VskSBurda3XQvrRieaXaxpxgM8sbJBb7aGKA7juMLx
 Faej74AAAA=
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, John Clark <inindev@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, 
 Eugen Hristev <eugen.hristev@collabora.com>, Andy Yan <andyshrk@163.com>, 
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jagan Teki <jagan@edgeble.ai>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Joseph Chen <chenjh@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>
Cc: u-boot@lists.denx.de, Chris Morgan <macromorgan@hotmail.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

This is a new version of the patch series started by Chris Morgan here:
https://lore.kernel.org/u-boot/20240401181435.553351-1-macroalpha82@gmail.com/

Thanks Chris for starting this effort and allowing me to take over the
development.

Allow RK3568 and RK3588 based boards to get the RAM bank configuration
from the ROCKCHIP_TPL stage instead of the current logic. This fixes
both an issue where 256MB of RAM is blocked for devices with >= 4GB
of RAM and where memory holes need to be defined for devices with
more than 16GB of RAM. In the event that neither SoC is used or the
ROCKCHIP_TPL stage is not used, fall back to existing logic.

The logic handles creating memory holes from reserved memory areas
defined in mem_map data struct in SoC C files, but only if the DRAM area
overlaps with one reserved memory area.

Since mem_map data struct is used, it should be rather straightforward
to add support for other SoCs if needed.

The logic is taken from Rockchip's U-Boot tag linux-5.10-gen-rkr4.1
(e08e32143dd).

Note that Rockchip's U-Boot/TF-A/OP-TEE modify the ATAGS at runtime as
well, but the DDR_MEM tag seems to be pretty much stable (though BL31
seems to be reserving only 1MB for itself at the moment).

u32 for ATAGS is used because it simplifies the pointer arithmetic and
it's expected that ATAGS are always below the 4GB limit allowed by u32.

The default number of DRAM banks is increased to 10 if
ROCKCHIP_EXTERNAL_TPL is used, making it almost guaranteed that the new
logic will be used for new devices, provided the ATAGS are valid.

This was tested on Rock5B 16GB, Rock5B 8G and Jaguar 4G. U-Boot reports
the appropriate DRAM size and the kernel passes the memtest.

Boot the kernel with the following params:

setenv bootargs 'memtest=1 console=uart,mmio32,0xfeb50000 earlyprintk'

Jaguar 4GB:
"""
[    0.000000] early_memtest: # of tests: 1
[    0.000000]   0x0000000000200000 - 0x0000000002010000 pattern 0000000000000000
[    0.000000]   0x0000000003b80000 - 0x00000000eced1000 pattern 0000000000000000
[    0.000000]   0x00000000ecee4000 - 0x00000000f0000000 pattern 0000000000000000
[    0.000000]   0x00000001f0000000 - 0x00000001ff790d38 pattern 0000000000000000
[    0.000000]   0x00000001ff790d64 - 0x00000001ff790d68 pattern 0000000000000000
[    0.000000]   0x00000001ff790d94 - 0x00000001ff790d98 pattern 0000000000000000
[    0.000000]   0x00000001ff790dc4 - 0x00000001ff790dc8 pattern 0000000000000000
[    0.000000]   0x00000001ff790df9 - 0x00000001ff790e00 pattern 0000000000000000
[    0.000000]   0x00000001ff790e2c - 0x00000001ff790e30 pattern 0000000000000000
[    0.000000]   0x00000001ff790e5c - 0x00000001ff790e60 pattern 0000000000000000
[    0.000000]   0x00000001ff790e8c - 0x00000001ff790e90 pattern 0000000000000000
[    0.000000]   0x00000001ff790ebc - 0x00000001ff790ec0 pattern 0000000000000000
[    0.000000]   0x00000001ff790eec - 0x00000001ff790ef0 pattern 0000000000000000
[    0.000000]   0x00000001ff790f1f - 0x00000001ff790f20 pattern 0000000000000000
[    0.000000]   0x00000001ff790f4f - 0x00000001ff790f50 pattern 0000000000000000
[    0.000000]   0x00000001ff790f7f - 0x00000001ff790f80 pattern 0000000000000000
[    0.000000]   0x00000001ff790faf - 0x00000001ff790fb0 pattern 0000000000000000
[    0.000000]   0x00000001ff790fdf - 0x00000001ff790fe0 pattern 0000000000000000
[    0.000000]   0x00000001ff79100f - 0x00000001ff791010 pattern 0000000000000000
[    0.000000]   0x00000001ff79103f - 0x00000001ff791040 pattern 0000000000000000
[    0.000000]   0x00000001ff79106f - 0x00000001ff791070 pattern 0000000000000000
[    0.000000]   0x00000001ff79109f - 0x00000001ff7910a0 pattern 0000000000000000
[    0.000000]   0x00000001ff7910cf - 0x00000001ff7910d0 pattern 0000000000000000
[    0.000000]   0x00000001ff7910fc - 0x00000001ff791100 pattern 0000000000000000
[    0.000000]   0x00000001ff79112c - 0x00000001ff791130 pattern 0000000000000000
[    0.000000]   0x00000001ff79115c - 0x00000001ff791160 pattern 0000000000000000
[    0.000000]   0x00000001ff79118c - 0x00000001ff791190 pattern 0000000000000000
[    0.000000]   0x00000001ff7911bc - 0x00000001ff7911c0 pattern 0000000000000000
[    0.000000]   0x00000001ff7911ec - 0x00000001ff7911f0 pattern 0000000000000000
[    0.000000]   0x00000001ff79121c - 0x00000001ff791220 pattern 0000000000000000
[    0.000000]   0x00000001ff79124c - 0x00000001ff791250 pattern 0000000000000000
[    0.000000]   0x00000001ff79127c - 0x00000001ff791280 pattern 0000000000000000
[    0.000000]   0x00000001ff7912ad - 0x00000001ff7912b0 pattern 0000000000000000
[    0.000000]   0x00000001ff7912dd - 0x00000001ff7912e0 pattern 0000000000000000
[    0.000000]   0x00000001ff79130d - 0x00000001ff791310 pattern 0000000000000000
[    0.000000]   0x00000001ff79133d - 0x00000001ff791340 pattern 0000000000000000
[    0.000000]   0x00000001ff79136d - 0x00000001ff791370 pattern 0000000000000000
[    0.000000]   0x00000001ff803ffc - 0x00000001ff804000 pattern 0000000000000000

$ lsmem --output SIZE --bytes --json | jq '[.memory[].size] | add / 1024 / 1024 / 1024'
4
"""

Rock5B 8G:
"""
[    0.000000] early_memtest: # of tests: 1
[    0.000000]   0x0000000000200000 - 0x0000000002010000 pattern 0000000000000000
[    0.000000]   0x0000000003b80000 - 0x00000000ecbc6000 pattern 0000000000000000
[    0.000000]   0x00000000ecbd8000 - 0x00000000f0000000 pattern 0000000000000000
[    0.000000]   0x0000000100000000 - 0x0000000200000000 pattern 0000000000000000
[    0.000000]   0x00000002f0000000 - 0x00000002fef8e090 pattern 0000000000000000
[    0.000000]   0x00000002fef8e0bc - 0x00000002fef8e0c0 pattern 0000000000000000
[    0.000000]   0x00000002fef8e0ec - 0x00000002fef8e0f0 pattern 0000000000000000
[    0.000000]   0x00000002fef8e11c - 0x00000002fef8e120 pattern 0000000000000000
[    0.000000]   0x00000002fef8e14c - 0x00000002fef8e150 pattern 0000000000000000
[    0.000000]   0x00000002fef8e17c - 0x00000002fef8e180 pattern 0000000000000000
[    0.000000]   0x00000002fef8e1ac - 0x00000002fef8e1b0 pattern 0000000000000000
[    0.000000]   0x00000002fef8e1dc - 0x00000002fef8e1e0 pattern 0000000000000000
[    0.000000]   0x00000002fef8e20c - 0x00000002fef8e210 pattern 0000000000000000
[    0.000000]   0x00000002fef8e23f - 0x00000002fef8e240 pattern 0000000000000000
[    0.000000]   0x00000002fef8e26f - 0x00000002fef8e270 pattern 0000000000000000
[    0.000000]   0x00000002fef8e29f - 0x00000002fef8e2a0 pattern 0000000000000000
[    0.000000]   0x00000002fef8e2cf - 0x00000002fef8e2d0 pattern 0000000000000000
[    0.000000]   0x00000002fef8e2ff - 0x00000002fef8e300 pattern 0000000000000000
[    0.000000]   0x00000002fef8e32f - 0x00000002fef8e330 pattern 0000000000000000
[    0.000000]   0x00000002fef8e35f - 0x00000002fef8e360 pattern 0000000000000000
[    0.000000]   0x00000002fef8e38f - 0x00000002fef8e390 pattern 0000000000000000
[    0.000000]   0x00000002fef8e3bf - 0x00000002fef8e3c0 pattern 0000000000000000
[    0.000000]   0x00000002fef8e3ef - 0x00000002fef8e3f0 pattern 0000000000000000
[    0.000000]   0x00000002fef8e41c - 0x00000002fef8e420 pattern 0000000000000000
[    0.000000]   0x00000002fef8e44c - 0x00000002fef8e450 pattern 0000000000000000
[    0.000000]   0x00000002fef8e47c - 0x00000002fef8e480 pattern 0000000000000000
[    0.000000]   0x00000002fef8e4ac - 0x00000002fef8e4b0 pattern 0000000000000000
[    0.000000]   0x00000002fef8e4dc - 0x00000002fef8e4e0 pattern 0000000000000000
[    0.000000]   0x00000002fef8e50c - 0x00000002fef8e510 pattern 0000000000000000
[    0.000000]   0x00000002fef8e53c - 0x00000002fef8e540 pattern 0000000000000000
[    0.000000]   0x00000002fef8e56c - 0x00000002fef8e570 pattern 0000000000000000
[    0.000000]   0x00000002fef8e59c - 0x00000002fef8e5a0 pattern 0000000000000000
[    0.000000]   0x00000002fef8e5cd - 0x00000002fef8e5d0 pattern 0000000000000000
[    0.000000]   0x00000002fef8e5fd - 0x00000002fef8e600 pattern 0000000000000000
[    0.000000]   0x00000002fef8e62d - 0x00000002fef8e630 pattern 0000000000000000
[    0.000000]   0x00000002fef8e65d - 0x00000002fef8e660 pattern 0000000000000000
[    0.000000]   0x00000002fef8e68d - 0x00000002fef8e690 pattern 0000000000000000

$ lsmem --output SIZE --bytes --json | jq '[.memory[].size] | add / 1024 / 1024 / 1024'
8
"""

Rock5B 16GB:
"""
[    0.000000] early_memtest: # of tests: 1
[    0.000000]   0x0000000000200000 - 0x0000000002010000 pattern 0000000000000000
[    0.000000]   0x0000000003b80000 - 0x00000000ecbc6000 pattern 0000000000000000
[    0.000000]   0x00000000ecbd8000 - 0x00000000f0000000 pattern 0000000000000000
[    0.000000]   0x0000000100000000 - 0x00000003fc000000 pattern 0000000000000000
[    0.000000]   0x00000003fc500000 - 0x00000003fff00000 pattern 0000000000000000
[    0.000000]   0x00000004f0000000 - 0x00000004fdf88090 pattern 0000000000000000
[    0.000000]   0x00000004fdf880bc - 0x00000004fdf880c0 pattern 0000000000000000
[    0.000000]   0x00000004fdf880ec - 0x00000004fdf880f0 pattern 0000000000000000
[    0.000000]   0x00000004fdf8811c - 0x00000004fdf88120 pattern 0000000000000000
[    0.000000]   0x00000004fdf8814c - 0x00000004fdf88150 pattern 0000000000000000
[    0.000000]   0x00000004fdf8817c - 0x00000004fdf88180 pattern 0000000000000000
[    0.000000]   0x00000004fdf881ac - 0x00000004fdf881b0 pattern 0000000000000000
[    0.000000]   0x00000004fdf881dc - 0x00000004fdf881e0 pattern 0000000000000000
[    0.000000]   0x00000004fdf8820c - 0x00000004fdf88210 pattern 0000000000000000
[    0.000000]   0x00000004fdf8823f - 0x00000004fdf88240 pattern 0000000000000000
[    0.000000]   0x00000004fdf8826f - 0x00000004fdf88270 pattern 0000000000000000
[    0.000000]   0x00000004fdf8829f - 0x00000004fdf882a0 pattern 0000000000000000
[    0.000000]   0x00000004fdf882cf - 0x00000004fdf882d0 pattern 0000000000000000
[    0.000000]   0x00000004fdf882ff - 0x00000004fdf88300 pattern 0000000000000000
[    0.000000]   0x00000004fdf8832f - 0x00000004fdf88330 pattern 0000000000000000
[    0.000000]   0x00000004fdf8835f - 0x00000004fdf88360 pattern 0000000000000000
[    0.000000]   0x00000004fdf8838f - 0x00000004fdf88390 pattern 0000000000000000
[    0.000000]   0x00000004fdf883bf - 0x00000004fdf883c0 pattern 0000000000000000
[    0.000000]   0x00000004fdf883ef - 0x00000004fdf883f0 pattern 0000000000000000
[    0.000000]   0x00000004fdf8841c - 0x00000004fdf88420 pattern 0000000000000000
[    0.000000]   0x00000004fdf8844c - 0x00000004fdf88450 pattern 0000000000000000
[    0.000000]   0x00000004fdf8847c - 0x00000004fdf88480 pattern 0000000000000000
[    0.000000]   0x00000004fdf884ac - 0x00000004fdf884b0 pattern 0000000000000000
[    0.000000]   0x00000004fdf884dc - 0x00000004fdf884e0 pattern 0000000000000000
[    0.000000]   0x00000004fdf8850c - 0x00000004fdf88510 pattern 0000000000000000
[    0.000000]   0x00000004fdf8853c - 0x00000004fdf88540 pattern 0000000000000000
[    0.000000]   0x00000004fdf8856c - 0x00000004fdf88570 pattern 0000000000000000
[    0.000000]   0x00000004fdf8859c - 0x00000004fdf885a0 pattern 0000000000000000
[    0.000000]   0x00000004fdf885cd - 0x00000004fdf885d0 pattern 0000000000000000
[    0.000000]   0x00000004fdf885fd - 0x00000004fdf88600 pattern 0000000000000000
[    0.000000]   0x00000004fdf8862d - 0x00000004fdf88630 pattern 0000000000000000
[    0.000000]   0x00000004fdf8865d - 0x00000004fdf88660 pattern 0000000000000000
[    0.000000]   0x00000004fdf8868d - 0x00000004fdf88690 pattern 0000000000000000

$ lsmem --output SIZE --bytes --json | jq '[.memory[].size] | add / 1024 / 1024 / 1024'
16
"""

I tested on Rock5B 16GB that without the memory holes and without using
this new logic, the kernel fails this memtest, so this test seems valid.

This has NOT been tested on RK356x as I don't own any.

Note that the logic for excluding DRAM memory areas from the memory
areas to consider for putting holes in DRAM banks based on mem_map
struct may conflict with SDRAM, ROM or flashes if we ever add those to
the SoC's mem_map... Something we can tackle the day we do it, it's good
enough for now.

Co-Developed-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
Changes in v4:
- fix infinite while loop if there's no hole to create by incrementing
  the pointer in the no-match path,
- fix identification of non-DRAM memory areas in mem_map by checking for
  PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE instead of
  looking for ! PTE_BLOCK_NON_SHARE since PTE_BLOCK_NON_SHARE is 0 so
  using it as a mask always makes the result the same value, regardless
  of the other operand,
- Link to v3: https://lore.kernel.org/r/20240415-rk35xx-dram-atags-v3-0-5bc5475b3c0d@theobroma-systems.com

Changes in v3:
- Split board migration to new DRAM ATAGS mechanism into separate
  commits,
- Use mem_map instead of hardcoded values for reserved memory area for
  MMIO,
- Add tag hash check to match Rockchip's downstream implementation,
- Bail from while loop as soon as a tag with no size is encountered to
  match Rockchip's downstream implementation,
- Use enum instead of constants for ATAG magic,
- Add debug messages and comments,
- Fix atags traversal by using tag size instead of checking every 16B,
- Migrate Jaguar to new mechanism,
- Default NR_DRAM_BANKS to 10 when ROCKCHIP_EXTERNAL_TPL is used so the
  default allows to use this new logic,
- Define tag_header data struct to parse the first two bytes of a tag
  more easily,
- Do not stop at CORE magic, directly look for DDR_MEM,
- Bail from while loop as soon as an unknown tag is used to match
  Rockchip's downstream implementation,
- Use phys_size_t and phys_addr_t wherever possible,

Link to v2: https://lore.kernel.org/u-boot/20240401181435.553351-1-macroalpha82@gmail.com/
Link to v1: https://lore.kernel.org/u-boot/20240330050515.470025-1-macroalpha82@gmail.com/

---
Quentin Schulz (11):
      rockchip: sdram: Support getting banks from TPL for rk3568 and rk3588
      rockchip: NR_DRAM_BANKS now defaults to 10 when Rockchip TPL blob is used
      rockchip: nanopc-t6-rk3588: use DRAM banks from ATAGS
      rockchip: quartzpro64-rk3588: use DRAM banks from ATAGS
      rockchip: rock5a-rk3588s: use DRAM banks from ATAGS
      rockchip: rock5b-rk3588: use DRAM banks from ATAGS
      rockchip: evb_rk3588 et al.: use DRAM banks from ATAGS
      rockchip: toybrick_rk3588: use DRAM banks from ATAGS
      rockchip: turing-rk1-rk3588: use DRAM banks from ATAGS
      rockchip: rk3588: use DRAM banks from ATAGS
      rockchip: rk356x: use DRAM banks from ATAGS

 arch/arm/mach-rockchip/Kconfig                     |   3 +
 arch/arm/mach-rockchip/sdram.c                     | 258 +++++++++++++++++++++
 board/friendlyelec/nanopc-t6-rk3588/Makefile       |   6 -
 .../nanopc-t6-rk3588/nanopc-t6-rk3588.c            |  39 ----
 board/pine64/quartzpro64-rk3588/Makefile           |   3 -
 .../pine64/quartzpro64-rk3588/quartzpro64-rk3588.c |  39 ----
 board/radxa/rock5a-rk3588s/Makefile                |   6 -
 board/radxa/rock5a-rk3588s/rock5a-rk3588s.c        |  39 ----
 board/radxa/rock5b-rk3588/Makefile                 |   6 -
 board/radxa/rock5b-rk3588/rock5b-rk3588.c          |  39 ----
 board/rockchip/evb_rk3588/Makefile                 |   6 -
 board/rockchip/evb_rk3588/evb-rk3588.c             |  39 ----
 board/rockchip/toybrick_rk3588/Makefile            |   6 -
 board/rockchip/toybrick_rk3588/toybrick-rk3588.c   |  39 ----
 board/turing/turing-rk1-rk3588/Makefile            |   6 -
 board/turing/turing-rk1-rk3588/turing-rk1-rk3588.c |  39 ----
 configs/anbernic-rgxx3-rk3566_defconfig            |   1 -
 configs/bpi-r2-pro-rk3568_defconfig                |   1 -
 configs/coolpi-4b-rk3588s_defconfig                |   2 -
 configs/coolpi-cm5-evb-rk3588_defconfig            |   2 -
 configs/evb-rk3568_defconfig                       |   1 -
 configs/evb-rk3588_defconfig                       |   2 -
 configs/generic-rk3568_defconfig                   |   1 -
 configs/generic-rk3588_defconfig                   |   2 -
 configs/jaguar-rk3588_defconfig                    |   1 -
 configs/lubancat-2-rk3568_defconfig                |   1 -
 configs/nanopc-t6-rk3588_defconfig                 |   2 -
 configs/nanopi-r5c-rk3568_defconfig                |   1 -
 configs/nanopi-r5s-rk3568_defconfig                |   1 -
 configs/neu6a-io-rk3588_defconfig                  |   1 -
 configs/neu6b-io-rk3588_defconfig                  |   1 -
 configs/odroid-m1-rk3568_defconfig                 |   1 -
 configs/orangepi-5-plus-rk3588_defconfig           |   2 -
 configs/orangepi-5-rk3588s_defconfig               |   2 -
 configs/pinetab2-rk3566_defconfig                  |   1 -
 configs/quartz64-a-rk3566_defconfig                |   1 -
 configs/quartz64-b-rk3566_defconfig                |   1 -
 configs/quartzpro64-rk3588_defconfig               |   2 -
 configs/radxa-cm3-io-rk3566_defconfig              |   1 -
 configs/radxa-e25-rk3568_defconfig                 |   1 -
 configs/rock-3a-rk3568_defconfig                   |   1 -
 configs/rock5a-rk3588s_defconfig                   |   2 -
 configs/rock5b-rk3588_defconfig                    |   2 -
 configs/soquartz-blade-rk3566_defconfig            |   1 -
 configs/soquartz-cm4-rk3566_defconfig              |   1 -
 configs/soquartz-model-a-rk3566_defconfig          |   1 -
 configs/toybrick-rk3588_defconfig                  |   2 -
 configs/turing-rk1-rk3588_defconfig                |   2 -
 48 files changed, 261 insertions(+), 356 deletions(-)
---
base-commit: d097f9e1299a3bdb7de468f0d9bbc63932f461cd
change-id: 20240415-rk35xx-dram-atags-35c9f19f4c38

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>

