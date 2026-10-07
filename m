Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4F1CA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 07:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1162E40519;
	Wed,  7 Oct 2026 07:42:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MGo1AgDvdYQu; Wed,  7 Oct 2026 07:42:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1DB5F40637
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791358932;
	b=kXSG9bF2V2pIXwXSSeMQFs9LVYs9LgtHotQWMryNoZJcM8DKqb/kCmrD6N90+/5zjf9p
	 DVE3FeP3dI+cDezPhwPiLlIWgQktu9tRFjGZ/ephuumOdm1MTQRlHZW7OLxEBQkypxLWu
	 ToZmWVuFnWPjjBFGx+ai/99C1AVXFhRyTD1lW7w3vl2xOHDz5mRNh++6YPQct6qOaJ071
	 PHVbQfbrBKccQ5nKyK6/rHvZjCq3vlZvRlExm472vP2Sh6f/mbwstd4P+5kqPEB+OX/40
	 0PRTOy9W0pD+SzfnzcjQmw/7Z9+R+272WDtX6QTRIkh3vRfCKwfwCebAm3Dp6eV6EaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791358932;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GRT3PtelpfrkziCq+wHinDu/f0zMcvW05sNQ0ZVVG64=;
	b=azgaux/Amfl0skV3t+Hga5CtmiP2ya/LFBH77IOlkKs9MLku3jhL6INolrWxED8OBRwd
	 rA8ZXNmYKljCTZLVbX3L2a8sOREKpdC5sT0p7Kq7pDmm7He0QP4L4o6azQQSHKFHOXG8F
	 BVkCCWuBC/D5o/is5jGvY0ZrjqNDJX2Lg1aRbgfYh4g2KT7s2NOpFFxAQqbmKj2MYzVho
	 xQq3uk8db6iql6dS68IOjzlr+n4Jo2qtT9apM9sPKs/ZF/lx4VAX383eUiDgyuPNDcymI
	 gEQFmr6rgWmfICroS95/GLYQFs5EqcU1fzZ6HX+FojjkWxX85s4YLnDODHhLPa+0awQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791358932;
	bh=GRT3PtelpfrkziCq+wHinDu/f0zMcvW05sNQ0ZVVG64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lVSFoaBW4DXnJd7JaTTLOsf6UaxeXXDzSJYJZ8zX35KM3w9cBFiTGZ5TvFolggtkg
	 fG72oR0oPBnLropBHRmE9Ai67t/vI4cWO5S36Q5a06FzeYthissra0oHNCuumGza6q
	 yzaj8ajMjfxSsBcE+0LpTQCPZO/jJ5fCesOK0bGkKev3a6gdzQOXWgCgsVcTLBcj6D
	 WJp/pHbUKgCuDvJwXJEsIbHIANiP/ljSAuPw+Q9irinckzmrxq4QEzrke48M1NG1fk
	 fPxwV/NrBHT5nCbsPWQxX4pV98alyvmQO2Wh+PGIpHDov0kPpFFqtY7sRke5linIoF
	 Cn7d25VSsicdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DB5F40637;
	Wed,  7 Oct 2026 07:42:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A7F83341
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:41:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E9DB40070
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:41:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fssvFNMmTz00 for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 07:41:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 20E6540062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791358865;
 b=oECa2NjCvEjYfmTMLHecKBdH8Swa0wgdlG/qMUY//LNIBIDIfw3DhKJfrzTsKjktQ+Gn
 96xJYtGQ5FTB65e30401cVVdyxLFyplfTaymHKVQl8zYtxz68ET6Q9yBJgjOUa6X0mbpy
 oc0QErJeRs7BedkBWe9Ny1jDjl5BFJg0djqSOJdnV0X9hKTgWMcW4nt6jHEI/EZziLG5K
 nvQvFaY/RvUO3t02XrfSh9nz/FMGdQKCC5TLTfftdCJJlgym6SerWjbpp0GDRoXBQyX5r
 lLKlsL2gEFhz2fBNWg2C8vmKbt0iti6v94l7odDNSKH9OHsOib762wFeBTgS0pOUVwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791358865;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=GRT3PtelpfrkziCq+wHinDu/f0zMcvW05sNQ0ZVVG64=;
 b=Dy0QKAlCbFD48t7uRqzXzXwv8Fc/Q5UvqmKZNt+oBP1E2X6lWyazGnpaAYnbVyizlALS
 LxScbPbrU0hdlZO+b0PGwtv21HgBsJZj652qaGb4/S1A0+OmSZD44oZGzf6A5KnGswLzX
 FKRR1c0DGWWZY7oJ4jox3d2KH6yVcpMx2AdnjspX8uu6bOelRw6ky8nusH4eHySTMgPwQ
 ikLfU8N+VyPFlzEEdjlryhgOao3Mbv2Y/DvR0BqbMnc7od4PNm+mIIj24LSOZ5JZmuTje
 BcCcllR8XZFEg/O/nP+gCuRuF34hKsKhzj4QBldpCyGDyITX86QFk0Ln2AgptO+DENQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=Fk8PbRNS; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=Fk8PbRNS
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20E6540062
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791358825;
 bh=GRT3PtelpfrkziCq+wHinDu/f0zMcvW05sNQ0ZVVG64=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Fk8PbRNSKU8McVozsYvsykbSPVaMG7dSftQMwbPxRgbRgArzQAJvDazlAwaJOx5zN
 iZAOUtoACs1Q9kg7kU3XeuD8iN5ujQc1SyAEE6tPr9Obpr/x+q79waldD6HdpqbalT
 bFY8R/67P2TC3FqyQD8js+FteHFDfWfygx//9owe3buM0J5tsj5B8Skt8kuMHMIkbe
 fkQ0997km7dFCcwSJ1lZEQxpl4vXjXOPo3xab2Mm8BK4yuMPvfCIPf7mRL4KTWlLn0
 9pAncURS+o3srtLSE2Ggfr5/y03O+hnNoXjPrTi+9Q3OtckYYE3Fv3QZR04R31HKdV
 KyW+GUcydhfWQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 6B436B220082;
 Wed,  7 Oct 2026 09:40:23 +0200 (CEST)
Message-ID: <006d1d63-d5e1-4b81-a8b3-b73e279912d1@freeshell.de>
Date: Wed, 7 Oct 2026 00:40:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] doc: spacemit: k3: Add Pico-ITX board
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>, Junhui Liu <junhui.liu@pigmoral.tech>
References: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
 <20261007-00-basic-spacemit-k3-v4-4-c44d09937088@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261007-00-basic-spacemit-k3-v4-4-c44d09937088@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 10/6/26 22:11, Yixun Lan wrote:
> Add documentation for how to test the mainline U-Boot on SpacemiT
> K3 Pico-ITX board, currently it still rely on using vendor FSBL.bin
> file to initialize DDR and boot U-Boot proper, and the opensbi
> firmware is built from an on-going mainline branch.
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  doc/board/spacemit/index.rst             |   1 +
>  doc/board/spacemit/spacemit-pico-itx.rst | 200 +++++++++++++++++++++++++++++++
>  2 files changed, 201 insertions(+)
> 
> diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
> index 71854e5735b..51918f0acc7 100644
> --- a/doc/board/spacemit/index.rst
> +++ b/doc/board/spacemit/index.rst
> @@ -8,4 +8,5 @@ SpacemiT
>     bananapi-f3
>     k1-mmc
>     k1-spl
> +   spacemit-pico-itx
>  
> diff --git a/doc/board/spacemit/spacemit-pico-itx.rst b/doc/board/spacemit/spacemit-pico-itx.rst
> new file mode 100644
> index 00000000000..18d11d6671b
> --- /dev/null
> +++ b/doc/board/spacemit/spacemit-pico-itx.rst
> @@ -0,0 +1,200 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +SpacemiT K3 Pico-ITX
> +====================
> +
> +Building
> +~~~~~~~~
> +1. Add a RISC-V toolchain to your PATH
> +
> +2. Setup cross compilation environment variable:
> +
> +   .. code-block:: console
> +
> +      export CROSS_COMPILE=<riscv64 toolchain prefix>
> +
> +3. U-Boot for SpacemiT K3 SoC requires OpenSBI in-development generic
> +platform object fw_dynamic.bin to be included in the Flattened Image
> +Tree blob. OpenSBI may be first built as below:
> +
> +   .. code-block:: console
> +
> +      # Clone OpenSBI fork sources with K3 specific patches
> +      git clone https://github.com/spacemit-com/opensbi-upstream opensbi
> +      cd opensbi
> +      make PLATFORM=generic
> +
> +4. Then build U-Boot as following:
> +
> +   .. code-block:: console
> +
> +      cd <U-Boot-dir>
> +      make spacemit_k3_defconfig
> +      make OPENSBI=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin
> +
> +This will generate u-boot.itb
> +
> +Testing
> +~~~~~~~
> +Currently there is no U-Boot SPL build target. It is required to use 'FSBL.bin' vendor
> +board support package SPL for DDR initialization and testing u-boot.itb. Please test with
> +fastboot command via USB download.
> +
> +First, retrieve Bianbu Linux image from archive_ and extract the FSBL.bin firmware.
> +
> +Second, hold the FEL button of Pico-ITX board, then press reset button and release it .
> +The board will enter into firmware download mode.
> +
> +   .. code-block:: none
> +
> +      sys: 0x10001200
> +      bm:2
> +      usb_init : enter 3296,3072
> +      usb_core_init : enter
> +      DWC3_GRXTHRCFG:0x4400000
> +      ROM: usb download handler
> +       rst
> +      done H
> +      setup= 0x1000680 0x400000,
> +       rst
> +      done H
> +      setup= 0x290500 0x0,
> +      setup= 0x1000680 0x120000,
> +      setup= 0x2000680 0x90000,
> +      setup= 0x2000680 0x200000,
> +      setup= 0x3000680 0xff0000,
> +      setup= 0x3020680 0xff0409,
> +      setup= 0x3010680 0xff0409,
> +      setup= 0x10900 0x0,
> +      usb_rx_bytes : start len[4096]
> +      setup= 0x3020680 0xff0409,
> +      setup= 0x3040680 0xff0409,
> +
> +Run following command to test:
> +
> +   .. code-block:: console
> +
> +      fastboot stage FSBL.bin
> +      fastboot continue
> +      sleep 10
> +      fastboot stage u-boot.itb
> +      fastboot continue
> +
> +.. _archive: https://archive.spacemit.com/image/k3/version/bianbu/v4.0.7/
> +.. _uboot: https://bianbu-linux.spacemit.com/en/device/boot#21-firmware-layout
> +
> +Booting
> +~~~~~~~
> +Sample boot log
> +~~~~~~~~~~~~~~~
> +   .. code-block:: none
> +
> +      sys: 0x10001200
> +      bm:2
> +      usb_init : enter 3296,3072
> +      usb_core_init : enter
> +      DWC3_GRXTHRCFG:0x4400000
> +      ROM: usb download handler
> +       rst
> +      done H
> +      setup= 0x1000680 0x400000,
> +       rst
> +      done H
> +      setup= 0x2f0500 0x0,
> +      setup= 0x1000680 0x120000,
> +      setup= 0x2000680 0x90000,
> +      setup= 0x2000680 0x200000,
> +      setup= 0x3000680 0xff0000,
> +      setup= 0x3020680 0xff0409,
> +      setup= 0x3010680 0xff0409,
> +      setup= 0x10900 0x0,
> +      usb_rx_bytes : start len[4096]
> +      setup= 0x3020680 0xff0409,
> +      setup= 0x3040680 0xff0409,
> +      fastboot_handle_command: max-download-size
> +      usb_tx_bytes : start len[14]
> +      usb_rx_bytes : start len[4096]
> +      fastboot_handle_command: 00072b20
> +      Starting download of 469792 bytes
> +      usb_tx_bytes : start len[12]
> +      usb_rx_bytes : start len[469792]
> +      usb_tx_bytes : start len[4]
> +      usb_rx_bytes : start len[4096]
> +      fastboot_handle_command: continue
> +      usb_tx_bytes : start len[4]
> +      j...
> +      U-Boot SPL 2022.10 (Sep 07 2026 - 11:31:13 +0000)
> +      LPDDR5 total size: 16 GB, data rate: 6400 MT/s
> +      DDR training consume 5625ms
> +      ..
> +      OpenSBI v1.9-72-g13a401f8
> +         ____                    _____ ____ _____
> +        / __ \                  / ____|  _ \_   _|
> +       | |  | |_ __   ___ _ __ | (___ | |_) || |
> +       | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
> +       | |__| | |_) |  __/ | | |____) | |_) || |_
> +        \____/| .__/ \___|_| |_|_____/|____/_____|
> +              | |
> +              |_|
> +      Platform Name               : SpacemiT K3 Pico-ITX
> +      Platform Features           : medeleg
> +      Platform HART Count         : 8
> +      Platform HART Protection    : pmp
> +      Platform IPI Device         : aclint-mswi
> +      Platform Timer Device       : aclint-mtimer @ 24000000Hz
> +      Platform Console Device     : uart8250
> +      Platform HSM Device         : spacemit-k3-hsm
> +      Platform PMU Device         : ---
> +      Platform Reboot Device      : spacemit-p1-reset
> +      Platform Shutdown Device    : spacemit-p1-reset
> +      Platform Suspend Device     : ---
> +      Platform CPPC Device        : ---
> +      Firmware Base               : 0x100000000
> +      Firmware Size               : 416 KB
> +      Firmware RW Offset          : 0x40000
> +      Firmware RW Size            : 160 KB
> +      Firmware Heap Offset        : 0x57000
> +      Firmware Heap Size          : 68 KB (total), 1 KB (reserved), 14 KB (used), 52 KB (free)
> +      Firmware Scratch Size       : 4096 B (total), 1472 B (used), 2624 B (free)
> +      Runtime SBI Version         : 3.0
> +      Standard SBI Extensions     : time,rfnc,ipi,base,hsm,srst,pmu,dbcn,fwft,legacy,dbtr,sse
> +      Experimental SBI Extensions : none
> +      Domain0 Name                : root
> +      Domain0 Init Order          : 0xffffffff
> +      Domain0 Boot HART           : 0
> +      Domain0 HARTs               : 0x0*,0x1*,0x2*,0x3*,0x4*,0x5*,0x6*,0x7*
> +      Domain0 Region00            : 0x0000000100000000-0x000000010003ffff M: (F,R,X) S/U: ()
> +      Domain0 Region01            : 0x0000000100040000-0x000000010007ffff M: (F,R,W) S/U: ()
> +      Domain0 Region02            : 0x00000000d4017000-0x00000000d4017fff M: (I,R,W) S/U: (R,W)
> +      Domain0 Region03            : 0x00000000e081c000-0x00000000e081ffff M: (I,R,W) S/U: ()
> +      Domain0 Region04            : 0x0000000000000000-0xffffffffffffffff M: () S/U: (R,W,X)
> +      Domain0 Next Address        : 0x0000000102000000
> +      Domain0 Next Arg1           : 0x0000000102091398
> +      Domain0 Next Mode           : S-mode
> +      Domain0 SysReset            : yes
> +      Domain0 SysSuspend          : yes
> +      Boot HART ID                : 0
> +      Boot HART Domain            : root
> +      Boot HART Priv Version      : v1.12
> +      Boot HART Base ISA          : rv64imafdcbvhx
> +      Boot HART ISA Extensions    : smaia,smstateen,sscofpmf,sstc,zicntr,zihpm,smcntrpmf,zicboz,zicbom,svpbmt,sdtrig,svade,ssstateen,v,f,d
> +      Boot HART PMP Count         : 16
> +      Boot HART PMP Granularity   : 12 bits
> +      Boot HART PMP Address Bits  : 38
> +      Boot HART MHPM Info         : 16 (0x0007fff8)
> +      Boot HART Debug Triggers    : 4 triggers
> +      Boot HART MIDELEG           : 0x0000000000003666
> +      Boot HART MEDELEG           : 0x0000000000f0b509
> +
> +      <debug_uart>
> +
> +      U-Boot 2026.10-rc4-00501-g9fba7b59df42 (Sep 22 2026 - 13:08:33 +0000)
> +
> +      DRAM:  16 GiB
> +      Core:  433 devices, 15 uclasses, devicetree: separate
> +      Loading Environment from nowhere...Loading Environment from nowhere... OK
> +      In:    serial@d4017000
> +      Out:   serial@d4017000
> +      Err:   serial@d4017000
> +      Net:   No ethernet found.
> +      =>
> 

Reviewed-by: E Shattow <e@freeshell.de>
