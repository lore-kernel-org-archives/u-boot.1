Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E5CE7C716
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 11:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28DE383B85;
	Sun,  1 Feb 2026 12:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="tPxaVUgK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF86B83B86; Sun,  1 Feb 2026 12:22:25 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AA9083B55
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 12:22:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=19be=AF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1769944941;
 bh=1FchXGT9ZUWQu6GynY5zb1/QIt8IEbRLvd8w8/Zqa78=;
 b=tPxaVUgKeWQlGiXFqMmzHRVwkx92kne3b7Svsxv+8BMDvt4HrO9MXigkhPnv8D2ZVpmPKPOSt
 06/etbc5hRtU9kzdyUoHOSh+iGzVojsWE8GDKdQCkeWZJtTkR96pB3z+RJAqPvPoE0SvYF4wrtu
 mfsCrxxMqAg34TVITERyawNrwEpwC8p+XJGAcMtJi3S1yMlys4PR03/RekWLCKLGWHPZocug6Ig
 4QCRA8+QXiGtdqQ0aW0MnAU+3x3JJSYKJvaB0ssw8US6ct3FZsGnnY5e+psuKrgUoYcrzVyfHX4
 by4AwgfiPxSb5LYhyRwdFUYGcz/G+TcFvuRBFkokMTfw==
X-Forward-Email-ID: 697f3767e70235c31da80f35
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <6055116c-bc2d-4321-95e5-983921f5afd5@kwiboo.se>
Date: Sun, 1 Feb 2026 12:22:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] rockchip: Add initial support for RK3506
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de
References: <20260131233843.3419737-1-jonas@kwiboo.se>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260131233843.3419737-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2/1/2026 12:38 AM, Jonas Karlman wrote:
> This series add initial support for the Rockchip RK3506 SoC.
> 
> Clk and pinctrl drivers have been imported from vendor U-Boot with
> some adjustments and fixes.
> 
> Upstream DT is currently not existing for RK3506, so this series does
> not add support for any new boards, it only add initial arch support.
> 
> Please see my U-Boot rk3506 branch at [1] for a few more commits that
> add DTs and defconfig for e.g. Luckfox Lyra variants and ArmSoM Forge1.
> 
> With this series, board DTs and defconfigs it should be possible to boot
> into U-Boot proper (without OP-TEE) and still have support for MMC,
> Ethernet, OTP, RNG, LEDs, buttons and USB gadget/host.

Below you can find a boot log from a ArmSoM Forge1 that I forgot to
include in the cover letter.

  DDR d27ac532c4 typ 25/03/11-14:46:28,fwver: v1.06
  tREFI:4x, sr_idle:93, pd_idle:13
  PHY drv:clk:40,ca:48,DQ:40,odt:240
  vrefinner:50%, vrefout:50%
  dram drv:40,odt:120
  sr_dq:0, sr_ca:0, sr_clk:0
  rg:0x9-0x1-0x2, 0x0-0x1-0x2,status:a007
  rdtrn:0x14-0x2d-0x47(0x33)
  wrtrn:0x0-0x20-0x3f(0x3f)
  DDR3, 750MHz
  BW=16 Col=10 Bk=8 CS0 Row=15 CS=1 Size=512MB
  out
  
  U-Boot SPL 2026.04-rc1-00108-ga72ec1294fc6 (Feb 01 2026 - 11:04:18 +0000)
  Trying to boot from RAM
  ## Checking hash(es) for config conf-1 ... OK
  ## Checking hash(es) for Image firmware-1 ... crc32+ OK
  ## Checking hash(es) for Image fdt-1 ... crc32+ OK
  spl_perform_arch_fixups: could not map boot_device to ofpath: -19
  spl_perform_arch_fixups: could not map BootROM boot device to ofpath
  
  
  U-Boot 2026.04-rc1-00108-ga72ec1294fc6 (Feb 01 2026 - 11:04:18 +0000)
  
  Model: ArmSoM Forge1
  SoC:   RK3506J
  DRAM:  512 MiB
  Core:  168 devices, 31 uclasses, devicetree: separate
  MMC:   mmc@ff480000: 0
  Loading Environment from nowhere... OK
  In:    serial@ff0a0000
  Out:   serial@ff0a0000
  Err:   serial@ff0a0000
  Net:   eth0: ethernet@ff4c8000, eth1: ethernet@ff4d0000
  Hit any key to stop autoboot: 0
  => bdinfo
  boot_params = 0x00000000
  DRAM bank   = 0x00000000
  -> start    = 0x00000000
  -> size     = 0x20000000
  flashstart  = 0x00000000
  flashsize   = 0x00000000
  flashoffset = 0x00000000
  baudrate    = 1500000 bps
  relocaddr   = 0x1ff61000
  reloc off   = 0x1f761000
  Build       = 32-bit
  current eth = ethernet@ff4c8000
  ethaddr     = a6:e4:17:db:24:ff
  IP addr     = <NULL>
  fdt_blob    = 0x1df36eb0
  lmb_dump_all:
   memory.count = 0x1
   memory[0]      [0x0-0x1fffffff], 0x20000000 bytes, flags: none
   reserved.count = 0x2
   reserved[0]    [0x1cf33000-0x1cf35fff], 0x3000 bytes, flags: no-notify, no-overwrite
   reserved[1]    [0x1cf36e90-0x1fffffff], 0x30c9170 bytes, flags: no-overwrite
  devicetree  = separate
  serial addr = 0xff0a0000
   width      = 0x00000004
   shift      = 0x00000002
   offset     = 0x00000000
   clock      = 0x016e3600
  arch_number = 0x00000000
  TLB addr    = 0x1fff0000
  irq_sp      = 0x1df36ea0
  sp start    = 0x1df36e90
  Early malloc usage: 9c8 / 10000
  => meminfo
  DRAM:  512 MiB
  
  Region                Base          Size           End           Gap
  --------------------------------------------------------------------
  code              1ff61000         8ea00      1ffefa00
  malloc            1df42000       201f000      1ff61000             0
  board_info        1df41f70            84      1df41ff4             c
  global_data       1df41e90            e0      1df41f70             0
  devicetree        1df36eb0          afd8      1df41e88             8
  stack             1cf36e90       1000000      1df36e90            20
  lmb               1cf36e90             0      1cf36e90             0
  lmb               1cf33000          3e90      1cf36e90             0
  free                     0      1cf33000      1cf33000             0
  => net list
  eth0 : ethernet@ff4c8000 a6:e4:17:db:24:ff active
  eth1 : ethernet@ff4d0000 a6:e4:17:db:24:fe
  => adc scan adc@ff4e8000
  [00]: 1019, 1792961 uV
  [01]: 1019, 1792961 uV
  [02]: 0, 0 uV
  [03]: 1011, 1778885 uV
  => misc list
  Device               Index     Driver
  -------------------------------------
  nvmem@ff4f0000           0 rockchip_otp
  => rng
  00000000: 14 f5 ec e0 40 e0 47 82 43 e6 1d f0 eb db a6 c4  ....@.G.C.......
  00000010: 31 d8 21 2c 7e f9 6a 04 bd d2 ae 6f 81 af ab b2  1.!,~.j....o....
  00000020: 4f a5 b1 c6 36 da 20 cb 58 6a 64 02 2c d6 7e f7  O...6. .Xjd.,.~.
  00000030: 15 e4 a3 4e 02 6c 13 9d cf b9 86 2f 7d 55 b0 46  ...N.l...../}U.F
  => led list
  green:heartbeat off
  => button list
  MASKROM         <inactive>
  => usb start
  starting USB...
  USB DWC2
  Bus usb@ff780000: 1 USB Device(s) found
         scanning usb for storage devices... 0 Storage Device(s) found
  => usb tree
  USB device tree:
    1  Hub (480 Mb/s, 0mA)
        U-Boot Root Hub

Regards,
Jonas

> Changes in v2:
> - Use common handling of USB bootsource_id 0x81
> - Re-sort the spl_infos list alphanumerically
> - Drop use of struct rk3506_cru and of_to_plat() ops
> - Define LOG_CATEGORY and use log_debug() in clk driver
> - Extract rk3506_clk_init_xpl() from clk bind() ops
> - Enable SPL_ARMV7_SET_CORTEX_SMPEN
> - Fix mac1 and otg1 access to ddr memory
> - Collect a-b and t-b tags (where applicable)
> 
> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3506

