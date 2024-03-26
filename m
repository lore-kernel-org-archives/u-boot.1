Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DB7CD11DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 10:22:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AD4888028;
	Tue, 26 Mar 2024 11:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HzalKbxV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5F6787E47; Tue, 26 Mar 2024 01:59:45 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B929487D7F
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 01:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ninomegadriver@gmail.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-db4364ecd6aso4770027276.2
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 17:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711414781; x=1712019581; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QVMiio0no9/d03gYqCLNlX6zMEPgJSax5Kl7GRbPPfs=;
 b=HzalKbxVO471RZNgGDAACFUGSuDIEHk6GxpsKZ08o4q5QBVeo0vbqkd0KtP/DHqzcs
 WPYvSwSiT2RQ+6vIJxFZVNWjdiPvPxQ52NQmbnBZ0kQwaEZWOIgoNvC3PXMkc/QHts+e
 Ef880HLk+gzpDjFNxcDXRpMfrMknkloOf+wExQYBb2WlTwTM8YdpI20hIDfuwdckTVF3
 iv3ipZGqPW1+x8NOSqnITYc4mcdS5yhU96kw2mPwyOQVnU8iJo+xJKGcOdIFntXKckR0
 Bh17PoBFOoYwfyTCABNeSmgl0O2iSBw7IlYX9chpmMdNMondfAK/PyH4WedizSeL+n6X
 mnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711414781; x=1712019581;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QVMiio0no9/d03gYqCLNlX6zMEPgJSax5Kl7GRbPPfs=;
 b=s2shYGhIFnIOAs/GCz3FY4ilVTfAZNSTzCJJKN5EkW5BM+tnTLOvpsfIu7lR/HEwGH
 n+2fzP4R3YRnI51PS8Z2CVkWWM6DitJgnm480gmhaS4fkQv/jGOzFQkVWEh9GLRBVvKh
 PM1iXLlqjxqlQs3HHQe1mQQKPFCsvzmk+jTQYcyn9Km1TRBYNH2NdUBlJGEiAh1TPdcw
 gPQ4sApGbLurIUtF1QYegPIFPtFBDk16zDSrx30xVQ3KOXApuiApv1pzyxgrA6vZ+BLd
 8AmyQrMJyEYgEo8XYrUIWxk5Gw+ev83udhBzDIqcd2imK07UAaQyV7FfBxOewP9bwhYo
 J6ZQ==
X-Gm-Message-State: AOJu0Yy2QhvAyBqryaq6YYNkCDgjGiPa8S7uGkK5aQfdgH/xsChqdPZi
 BycHMaCshtqJe9U4gk0ZSi5+rRmWyDIOFKrMWux5/lT6EM22HXkUWUrA9Y7SxMY0z0A9pTYlcHT
 JIdUG9Sz2I1qt9Ay1RmSV00Cete6LPypbENU=
X-Google-Smtp-Source: AGHT+IHnYSb2SzrO3jga8PmcTj5azdLqSjzxp8g8ZEpMGwVEoONFcm1YYxa+qUt+LHakaz6IzefBkEYcGCnP8L8Pnoo=
X-Received: by 2002:a25:ac9:0:b0:dcd:3d0f:1ba2 with SMTP id
 192-20020a250ac9000000b00dcd3d0f1ba2mr5197666ybk.33.1711414780664; Mon, 25
 Mar 2024 17:59:40 -0700 (PDT)
MIME-Version: 1.0
From: MegaDriver <ninomegadriver@gmail.com>
Date: Mon, 25 Mar 2024 21:59:29 -0300
Message-ID: <CA+N_sTcrKLZ8nKpnDNNrA8EtfG+M7SEafJPXz6U+J3kZEvgO1w@mail.gmail.com>
Subject: Help to figure out where I'm stuck...
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Tue, 26 Mar 2024 11:21:12 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi all,

I've developed my own board for the Allwinner V3S SOC based on the Lichee
Pi schematics with some custom modifications for my project. Now I'm
getting stuck after U-Boot outputs the total RAM for the second time. I did
some patching to the source code to output more information. I've
redirected all the debug and *debug messages to printf with numbering so I
can make things easier on locating the step in the source code.

Any U-Boot wizards out there that could give me a hand locating where
U-Boot is hanging?

Thanks a bunch!

Here's my latest output:
21:43:47.488 ->
21:43:47.488 -> U-Boot SPL 2024.04-rc4 (Mar 25 2024 - 21:40:21 -0300)
21:43:47.488 -> [5]DRAM:[9929]MBUS port 0 cfg0 00a0000d cfg1 00500064
21:43:47.521 -> [9929]MBUS port 1 cfg0 07000009 cfg1 00000600
21:43:47.521 -> [9929]MBUS port 2 cfg0 0100000d cfg1 00500080
21:43:47.521 -> [9929]MBUS port 3 cfg0 01000009 cfg1 00000064
21:43:47.521 -> [9929]MBUS port 4 cfg0 08000009 cfg1 00000640
21:43:47.521 -> [9929]MBUS port 5 cfg0 0180000d cfg1 00000100
21:43:47.521 -> [9929]MBUS port 6 cfg0 00640009 cfg1 00000032
21:43:47.521 -> [9929]MBUS port 7 cfg0 01800009 cfg1 00000100
21:43:47.521 -> [9929]MBUS port 8 cfg0 20000008 cfg1 00001000
21:43:47.521 -> [9929]MBUS port 9 cfg0 02800009 cfg1 00000100
21:43:47.554 ->  64 MiB
21:43:47.554 -> SPL malloc() before relocation used 0x0 bytes (0 KB)
21:43:47.554 -> SPL.c: board_init_r
21:43:47.554 -> >>SPL: board_init_r()
21:43:47.554 -> spl_init
21:43:47.554 -> size=18, ptr=18, limit=100000: 4fd00000
21:43:47.554 -> Before: boot_from_devices
21:43:47.554 -> Trying to boot from MMC1
21:43:47.554 -> [5937]init mmc 0 resource
21:43:47.554 -> [5938]init mmc 0 clock and io
21:43:47.587 -> [5927]mmc 0 set mod-clk req 24000000 parent 24000000 n 1 m
1 rate 24000000
21:43:47.587 -> common/malloc_simple.c:27-alloc_simple() size=190, ptr=1a8,
limit=100000: common/malloc_simple.c:48-malloc_simple() 4fd00018
21:43:47.587 -> [5652]clock is disabled (0Hz)
21:43:47.587 -> [5928]set ios: bus_width: 0, clock: 0
21:43:47.587 -> [5630]selecting mode MMC legacy (freq : 0 MHz)
21:43:47.587 -> [5928]set ios: bus_width: 1, clock: 0
21:43:47.587 -> [5652]clock is enabled (400000Hz)
21:43:47.587 -> [5928]set ios: bus_width: 1, clock: 400000
21:43:47.587 -> [5927]mmc 0 set mod-clk req 400000 parent 24000000 n 4 m 15
rate 400000
21:43:47.620 -> [5931]mmc 0, cmd 0(0x80008000), arg 0x00000000
21:43:47.620 -> [5936]mmc resp 0x00000000
21:43:47.620 -> [5931]mmc 0, cmd 8(0x80000148), arg 0x000001aa
21:43:47.620 -> [5936]mmc resp 0x000001aa
21:43:47.620 -> [5931]mmc 0, cmd 55(0x80000177), arg 0x00000000
21:43:47.620 -> [5936]mmc resp 0x00000120
21:43:47.620 -> [5931]mmc 0, cmd 41(0x80000069), arg 0x40300000
21:43:47.620 -> [5936]mmc resp 0x00ff8000
21:43:47.620 -> [5931]mmc 0, cmd 55(0x80000177), arg 0x00000000
21:43:47.653 -> [5936]mmc resp 0x00000120
21:43:47.653 -> [5931]mmc 0, cmd 41(0x80000069), arg 0x40300000
21:43:47.653 -> [5936]mmc resp 0x00ff8000
21:43:47.653 -> [5931]mmc 0, cmd 55(0x80000177), arg 0x00000000
21:43:47.653 -> [5936]mmc resp 0x00000120
21:43:47.653 -> [5931]mmc 0, cmd 41(0x80000069), arg 0x40300000
21:43:47.653 -> [5936]mmc resp 0x80ff8000
21:43:47.653 -> [5931]mmc 0, cmd 2(0x800001c2), arg 0x00000000
21:43:47.653 -> [5935]mmc resp 0x3eaa5507 0x40000000 0x50505344 0xc855aa41
21:43:47.653 -> [5931]mmc 0, cmd 3(0x80000143), arg 0x00000000
21:43:47.686 -> [5936]mmc resp 0x21070500
21:43:47.686 -> [5931]mmc 0, cmd 9(0x800001c9), arg 0x21070000
21:43:47.686 -> [5935]mmc resp 0x168000bf 0xeebbff9f 0x535a80ef 0x007f0032
21:43:47.686 -> [5630]selecting mode MMC legacy (freq : 25 MHz)
21:43:47.686 -> [5931]mmc 0, cmd 7(0x80000147), arg 0x21070000
21:43:47.686 -> [5936]mmc resp 0x00000700
21:43:47.686 -> [5931]mmc 0, cmd 55(0x80000177), arg 0x21070000
21:43:47.720 -> [5936]mmc resp 0x00000920
21:43:47.720 -> [5931]mmc 0, cmd 51(0x80002373), arg 0x00000000
21:43:47.720 -> [5932]trans data 8 bytes
21:43:47.720 -> [5933]cacl timeout 78 msec
21:43:47.720 -> [5936]mmc resp 0x00000920
21:43:47.720 -> [5931]mmc 0, cmd 6(0x80002346), arg 0x00fffff1
21:43:47.720 -> [5932]trans data 64 bytes
21:43:47.720 -> [5933]cacl timeout 78 msec
21:43:47.720 -> [5936]mmc resp 0x00000900
21:43:47.720 -> [5643]trying mode SD High Speed (50MHz) width 4 (at 50 MHz)
21:43:47.720 -> [5931]mmc 0, cmd 55(0x80000177), arg 0x21070000
21:43:47.753 -> [5936]mmc resp 0x00000920
21:43:47.753 -> [5931]mmc 0, cmd 6(0x80000146), arg 0x00000002
21:43:47.753 -> [5936]mmc resp 0x00000920
21:43:47.753 -> [5928]set ios: bus_width: 4, clock: 400000
21:43:47.753 -> [5927]mmc 0 set mod-clk req 400000 parent 24000000 n 4 m 15
rate 400000
21:43:47.753 -> [5931]mmc 0, cmd 6(0x80002346), arg 0x80fffff1
21:43:47.753 -> [5932]trans data 64 bytes
21:43:47.786 -> [5933]cacl timeout 78 msec
21:43:47.786 -> [5929]data timeout 80
21:43:47.786 -> [5630]selecting mode MMC legacy (freq : 25 MHz)
21:43:47.786 -> [5652]clock is enabled (25000000Hz)
21:43:47.786 -> [5928]set ios: bus_width: 4, clock: 25000000
21:43:47.786 -> [5927]mmc 0 set mod-clk req 25000000 parent 600000000 n 2 m
12 rate 25000000
21:43:47.820 -> [5643]trying mode SD High Speed (50MHz) width 1 (at 50 MHz)
21:43:47.820 -> [5931]mmc 0, cmd 55(0x80000177), arg 0x21070000
21:43:47.820 -> [5936]mmc resp 0x00000920
21:43:47.820 -> [5931]mmc 0, cmd 6(0x80000146), arg 0x00000000
21:43:47.820 -> [5936]mmc resp 0x00000920
21:43:47.820 -> [5928]set ios: bus_width: 1, clock: 25000000
21:43:47.820 -> [5927]mmc 0 set mod-clk req 25000000 parent 600000000 n 2 m
12 rate 25000000
21:43:47.820 -> [5931]mmc 0, cmd 6(0x80002346), arg 0x80fffff1
21:43:47.820 -> [5932]trans data 64 bytes
21:43:47.820 -> [5933]cacl timeout 78 msec
21:43:47.820 -> [5936]mmc resp 0x00000900
21:43:47.820 -> [5630]selecting mode SD High Speed (50MHz) (freq : 50 MHz)
21:43:47.852 -> [5652]clock is enabled (50000000Hz)
21:43:47.852 -> [5928]set ios: bus_width: 1, clock: 50000000
21:43:47.852 -> [5927]mmc 0 set mod-clk req 50000000 parent 600000000 n 1 m
12 rate 50000000
21:43:47.852 -> [5931]mmc 0, cmd 55(0x80000177), arg 0x21070000
21:43:47.852 -> [5936]mmc resp 0x00000920
21:43:47.886 -> [5931]mmc 0, cmd 13(0x8000234d), arg 0x00000000
21:43:47.886 -> [5932]trans data 64 bytes
21:43:47.886 -> [5933]cacl timeout 78 msec
21:43:47.886 -> [5936]mmc resp 0x00000920
21:43:47.886 -> [9954]spl_mmc_boot_mode(): user part
21:43:47.886 -> [8459]spl: mmc boot mode: raw
21:43:47.886 -> [5931]mmc 0, cmd 16(0x80000150), arg 0x00000200
21:43:47.886 -> [5936]mmc resp 0x00000900
21:43:47.886 -> [5931]mmc 0, cmd 17(0x80002351), arg 0x0000a000
21:43:47.886 -> [5932]trans data 512 bytes
21:43:47.886 -> [5933]cacl timeout 78 msec
21:43:47.886 -> [5936]mmc resp 0x00000900
21:43:47.886 -> [5931]mmc 0, cmd 16(0x80000150), arg 0x00000200
21:43:47.886 -> [5936]mmc resp 0x00000900
21:43:47.886 -> [5931]mmc 0, cmd 18(0x80003352), arg 0x0000a000
21:43:47.886 -> [5932]trans data 478208 bytes
21:43:47.985 -> [5933]cacl timeout 78 msec
21:43:47.985 -> [5936]mmc resp 0x00000900
21:43:47.985 -> [5930]mmc cmd 12 check rsp busy
21:43:47.985 -> After: boot_from_devices
21:43:47.985 -> Before: spl_perform_fixups
21:43:47.985 -> After: spl_perform_fixups
21:43:47.985 -> Jumping to U-Boot...
21:43:47.985 -> SPL malloc() used 0x1a8 bytes (0 KB)
21:43:47.985 -> Before: spl_board_prepare_for_boot
21:43:48.018 -> After: spl_board_prepare_for_boot
21:43:48.018 -> Before: jump_to_image
21:43:48.018 -> image entry point: 0x42e00000
21:43:48.184 -> otph-pre-sram: [5011]false
21:43:48.184 -> [5010]ofnode_read_bool: u-boot,dm-pre-reloc: [5011]false
21:43:48.184 -> [5010]ofnode_read_bool: u-boot,dm-pre-proper: [5011]false
21:43:48.184 -> [5010]ofnode_read_bool: u-boot,dm-spl: [5011]false
21:43:48.184 -> [5010]ofnode_read_bool: u-boot,dm-tpl: [5011]false
21:43:48.184 -> [5010]ofnode_read_bool: u-boot,dm-vpl: [5011]false
21:43:48.184 -> [5010]ofnode_read_bool: bootph-all: [5011]false
21:43:48.184 -> [5010]ofnode_read_bool: bootph-some-ram: [5011]false
21:43:48.184 -> [5010]ofnode_read_bool: bootph-pre-ram: [5011]false
21:43:48.184 -> [5010]ofnode_read_bool: bootph-pre-sram: [5011]false
21:43:48.184 -> [5010]ofnode_read_bool: u-boot,dm-pre-reloc: [5011]false
21:43:48.217 -> [5010]ofnode_read_bool: u-boot,dm-pre-proper: [5011]false
21:43:48.217 -> [5010]ofnode_read_bool: u-boot,dm-spl: [5011]false
21:43:48.217 -> [5010]ofnode_read_bool: u-boot,dm-tpl: [5011]false
21:43:48.217 -> [5010]ofnode_read_bool: u-boot,dm-vpl: [5011]false
21:43:48.250 -> [1038]initcall: 42e023a9
21:43:48.250 -> [1038]initcall: 42e26821
21:43:48.250 -> [4]env_init: Environment FAT init done (ret=-2)
21:43:48.250 -> [1038]initcall: 42e16ccd
21:43:48.250 -> [1038]initcall: 42e25375
21:43:48.250 -> common/malloc_simple.c:27-        alloc_simple() size=18,
ptr=27c, limit=2000: 6134
21:43:48.250 -> [4955]bind node serial@1c28000
21:43:48.250 -> [4957]   - attempt to match compatible string
'snps,dw-apb-uart'
21:43:48.250 -> [4959]   - found match at 'ns16550_serial': 'ns16550'
matches 'snps,dw-apb-uart'
21:43:48.250 -> common/malloc_simple.c:27-        alloc_simple() size=50,
ptr=2cc, limit=2000: 614c
21:43:48.284 -> [1062]Looking for 'serial' at 7272, name serial@1c28000
21:43:48.284 -> [1063]   - serial0, /soc/serial@1c28000
21:43:48.284 -> [1064]Found seq 0
21:43:48.284 -> [4936]   - seq=0
21:43:48.284 -> common/malloc_simple.c:27-        alloc_simple() size=20,
ptr=2ec, limit=2000: 619c
21:43:48.284 -> [4939]Bound device serial@1c28000 to root_driver
21:43:48.317 -> common/malloc_simple.c:27-        alloc_simple() size=18,
ptr=304, limit=2000: 61bc
21:43:48.317 -> common/malloc_simple.c:27-        alloc_simple() size=10,
ptr=314, limit=2000: 61d4
21:43:48.317 -> [1056]fdtdec_get_addr_size_auto_noparent:
[1052]fdtdec_get_addr_size_auto_parent: [1055]na=1, ns=1,
[1047]fdtdec_get_addr_size_fixed: reg: [1050]addr=01c28000, size=400
21:43:48.317 -> [94]OF: ** translation for device serial@1c28000 **
21:43:48.317 -> [95]OF: bus is default (na=1, ns=1) on soc
21:43:48.317 -> [97]OF: parent bus is default (na=1, ns=1) on
21:43:48.317 -> [90]OF: no ranges, 1:1 translation
21:43:48.350 -> [93]OF: with offset: 29523968
21:43:48.350 -> [96]OF: reached root node
21:43:48.350 -> [5000]ofnode_read_u32_index: reg-offset: [5001](not found)
21:43:48.350 -> [5000]ofnode_read_u32_index: reg-shift: [5003]0x2 (2)
21:43:48.350 -> [5000]ofnode_read_u32_index: reg-io-width: [5003]0x4 (4)
21:43:48.383 -> [1039]fdtdec_get_int: #clock-cells: [1040]0x1 (1)
21:43:48.383 -> drivers/core/uclass.c:538-uclass_get_device_by_ofnode()
Looking for clock@1c20000
21:43:48.383 -> drivers/core/uclass.c:389-uclass_find_device_by_ofnode()
Looking for clock@1c20000
21:43:48.383 -> drivers/core/uclass.c:398-uclass_find_device_by_ofnode()
    - checking osc24M_clk
21:43:48.416 -> drivers/core/uclass.c:398-uclass_find_device_by_ofnode()
    - checking osc32k_clk
21:43:48.416 -> drivers/core/uclass.c:408-uclass_find_device_by_ofnode()
 - result for clock@1c20000: (none) (ret=-19)
21:43:48.416 -> drivers/core/uclass.c:541-uclass_get_device_by_ofnode()
 - result for clock@1c20000: (none) (ret=-19)
21:43:48.416 -> [4430]clk_get_by_index_tail: uclass_get_device_by_of_offset
failed: err=-19
21:43:48.416 -> drivers/clk/clk-uclass.c:91-clk_get_by_index_tail() get:
returning err=-19
21:43:48.416 -> [5000]ofnode_read_u32_index: clock-frequency: [5001](not
found)
21:43:48.449 -> common/malloc_simple.c:27-        alloc_simple() size=18,
ptr=32c, limit=2000: 61e4
21:43:48.449 ->
drivers/pinctrl/pinctrl-uclass.c:87-pinctrl_select_state_full()
ns16550_serial serial@1c28000: pinctrl_select_state_full:
uclass_get_device_by_phandle_id: err=-19
21:43:48.483 -> [1039]fdtdec_get_int: #reset-cells: [1040]0x1 (1)
21:43:48.483 -> common/malloc_simple.c:27-        alloc_simple() size=40,
ptr=370, limit=2000: aligned to 6200
21:43:48.483 -> [1039]fdtdec_get_int: #reset-cells: [1040]0x1 (1)
21:43:48.483 -> drivers/core/uclass.c:538-uclass_get_device_by_ofnode()
Looking for clock@1c20000
21:43:48.483 -> drivers/core/uclass.c:389-uclass_find_device_by_ofnode()
Looking for clock@1c20000
21:43:48.483 -> common/malloc_simple.c:27-        alloc_simple() size=18,
ptr=388, limit=2000: 6240
21:43:48.483 -> drivers/core/uclass.c:408-uclass_find_device_by_ofnode()
 - result for clock@1c20000: (none) (ret=-19)
21:43:48.516 -> drivers/core/uclass.c:541-uclass_get_device_by_ofnode()
 - result for clock@1c20000: (none) (ret=-19)
21:43:48.516 -> [4767]reset_get_by_index_tail:
uclass_get_device_by_ofnode() failed: -19
21:43:48.549 -> [4768]clock@1c20000 49
21:43:48.549 -> [1038]initcall: 42e17fdd
21:43:48.549 -> [1038]initcall: 42e3f65d
21:43:48.549 ->
21:43:48.549 ->
21:43:48.549 -> U-Boot 2024.04-rc4 (Mar 25 2024 - 21:40:21 -0300) Allwinner
Technology
21:43:48.549 ->
21:43:48.549 -> [1038]initcall: 42e16b71
21:43:48.549 -> U-Boot code: 42E00000 -> 42E63890  BSS: -> 42E65ED4
21:43:48.549 -> [1038]initcall: 42e16a9d
21:43:48.549 -> [1038]initcall: 42e16c55
21:43:48.549 -> common/malloc_simple.c:27-        alloc_simple() size=18,
ptr=3a0, limit=2000: 6258
21:43:48.549 -> [1038]initcall: 42e022e1
21:43:48.549 -> CPU:   Allwinner V3s (SUN8I 1681)
21:43:48.549 -> [1038]initcall: 42e171d1
21:43:48.549 -> Model: Lichee Pi Zero
21:43:48.549 -> [1038]initcall: 42e16d1f
21:43:48.582 -> [1036]initcall: event 8/misc_init_f
21:43:48.582 -> [1038]initcall: 42e16aa1
21:43:48.582 -> [1038]initcall: 42e16ba5
21:43:48.582 -> [14]DRAM:  [1038]initcall: 42e02595
21:43:48.582 -> [1038]initcall: 42e16aa1
21:43:48.582 -> [1038]initcall: 42e16aa1
21:43:48.582 -> [1038]initcall: 42e16aa1
21:43:48.582 -> [1038]initcall: 42e16f1d
21:43:48.582 -> Monitor len: 00065ED4
21:43:48.615 -> Ram size: 04000000
21:43:48.615 -> Ram top: 44000000
21:43:48.615 -> [1038]initcall: 42e16a89
21:43:48.615 -> [1038]initcall: 42e16cfb
21:43:48.615 -> [1038]initcall: 42e01e91
21:43:48.615 -> [10027]TLB table from 43ff0000 to 43ff5000
21:43:48.615 -> [1038]initcall: 42e16cff
21:43:48.615 -> [1038]initcall: 42e16d03
21:43:48.615 -> [1038]initcall: 42e16b29
21:43:48.615 -> Reserving 407k for U-Boot at: 43f8a000
21:43:48.615 -> [1038]initcall: 42e16d65
21:43:48.615 -> Reserving 2176k for malloc() at: 43d6a000
21:43:48.615 -> [1038]initcall: 42e16d29
21:43:48.615 -> Reserving 68 Bytes for Board Info at: 43d69fb0
21:43:48.615 -> [1038]initcall: 42e16d8d
21:43:48.615 -> Reserving 296 Bytes for Global Data at: 43d69e80
21:43:48.648 -> [1038]initcall: 42e16ad9
21:43:48.648 -> Reserving 15232 Bytes for FDT at: 43d66300
21:43:48.648 -> [1038]initcall: 42e16d07
21:43:48.648 -> [1038]initcall: 42e16d0b
21:43:48.648 -> [1038]initcall: 42e16d1b
21:43:48.648 -> [1038]initcall: 42e16f81
21:43:48.648 -> [1038]initcall: 42e16aab
21:43:48.648 -> [1038]initcall: 42e16dc5
21:43:48.648 ->
21:43:48.648 -> RAM Configuration:
21:43:48.648 -> Bank #0: 40000000
21:43:48.648 -> [15]DRAM:  64 MiB
21:43:48.648 -> [1038]initcall: 42e16aa1
21:43:48.648 -> [1038]initcall: 42e16f93
21:43:48.648 -> [1038]initcall: 42e16ac5
21:43:48.648 -> New Stack Pointer is: 43d662e0
21:43:48.648 -> [1038]initcall: 42e16aa1
21:43:48.648 -> [1038]initcall: 42e16c2d
21:43:48.682 -> [1038]initcall: 42e16d0f
21:43:48.682 -> [1038]initcall: 42e16d13
21:43:48.682 -> [1038]initcall: 42e16bc5
21:43:48.682 -> Relocation Offset is: 0118a000
21:43:48.682 -> Relocating to 43f8a000, new gd at 43d69e80, sp at 43d662e0
21:43:48.682 -> [1038]initcall: 42e16cef
21:43:48.682 -> [1038]initcall: 42e18e75
21:43:48.682 -> [1038]initcall: 42e16b95
21:43:48.682 -> init_sequence_f: Finished
21:43:48.682 -> board_init_f finished
21:43:48.715 -> [1038]initcall: 43fa0fd9
21:43:48.715 -> [1038]initcall: 43fa0fdd
21:43:48.715 -> [1038]initcall: 43fa3095
21:43:48.715 -> [1038]initcall: 43fa117d
21:43:48.748 -> [10034]dram_bank_mmu_setup: bank: 0
21:43:48.748 -> [1038]initcall: 43fa1145
21:43:48.748 -> [1226]efi_runtime_relocate: Relocating to offset=43f8a000
21:43:48.748 -> [1227]efi_runtime_relocate: rel->info=0x17 *p=0x42e336f5
rel->offset=42e00f50
