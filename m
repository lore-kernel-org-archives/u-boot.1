Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F61C48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 15:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D62B587C7E;
	Tue,  6 Feb 2024 16:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="QIv+0NG4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E61B8206E; Tue,  6 Feb 2024 15:34:39 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43880875A0
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 15:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rXMWq-0005Oy-9S; Tue, 06 Feb 2024 09:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=PoZySK9eUQiWvy6xNKxMLOHKR/oYO0JoXvAL7kd8u9o=; b=QIv+0NG4XEaIS4
 BpSsh88f61n8CPsKgD9KzU43BrNVhxBLTgG2xKWS1wP3EPgOA9Msx7ogrDPuTHy6X+14Yoah56A8s
 G+rRW+3dpFK/8jhtprvrboQXitGsUDA2WdTvghuV1NpMc3c83JtiVSUiHHK1I0mxgVqlOS55HZXij
 DbZbqYzSt7eY30NNOYQy0DdHMbqSskVz7FaNBgxd93zCuyIc2zj2UCgTtTCXBJ20JYC34TIwkGO4Y
 oG8bjzLlgbyJl/8KG6dofSfY4aG/myHQvssYHhEN65CCbBLoxtv97idU7/6voWVm3aIy1K2jFhrB+
 d7iyPq8BZoLWvWN/Kb+A==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: u-boot@lists.denx.de
Cc: Tom.zheng <haidong.zheng@nxp.com>, Ye Li <ye.li@nxp.com>, Primoz Fiser
 <primoz.fiser@norik.com>, Fabio Estevam <festevam@denx.de>, Peng Fan
 <peng.fan@nxp.com>, Ken Sloat <ken.s@variscite.com>, Nate Drude
 <nate.d@variscite.com>, lukas.skupinski@landisgyr.com,
 lukas.skupinski@landisgyr.com
Subject: imx93-var-som: ahab: U-boot is hanging
Date: Tue, 06 Feb 2024 15:34:25 +0100
Message-ID: <87y1bx1x1q.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 06 Feb 2024 16:21:15 +0100
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


Hello,

I am using the imx93-var-som_defconfig configuration on commit
v2024.04-rc1. When producing signed or unsigned images on an unclosed
board everything works fine.

However, once the board is closed (ahab_close command is issued), u-boot
hangs this way:

--8<---------------cut here---------------start------------->8---
U-Boot SPL 2024.04-rc1-00004-g8494a62b246-dirty (Feb 06 2024 - 15:24:49 +0100)
SOC: 0xa0009300
LC: 0x40040
M33 prepare ok
Normal Boot
Trying to boot from BOOTROM
Boot Stage: USB boot
NOTICE:  BL31: v2.6(release):d8bc791fb
NOTICE:  BL31: Built : 18:11:44, Mar 15 2023


U-Boot 2024.04-rc1-00004-g8494a62b246-dirty (Feb 06 2024 - 15:24:49 +0100)

U-Boot code: 80200000 -> 802B4328  BSS: -> 802BA420
CPU:   i.MX93 rev1.0
Model: Variscite VAR-SOM-MX93 on Symphony evaluation board
DRAM:  Monitor len: 000BA420
Ram size: 80000000
Ram top: 100000000
Reserving 745k for U-Boot at: fff25000
Reserving 32784k for malloc() at: fdf21000
Reserving 152 Bytes for Board Info at: fdf20f60
Reserving 480 Bytes for Global Data at: fdf20d80
Reserving 24832 Bytes for FDT at: fdf1ac80

RAM Configuration:
Bank #0: 80000000 2 GiB
Bank #1: 0 0 Bytes

DRAM:  2 GiB
New Stack Pointer is: fdf1ac70
Relocation Offset is: 7fd25000
Relocating to fff25000, new gd at fdf20d80, sp at fdf1ac70
Added memory mapping (5): 80000000 80000000
Pre-reloc malloc() used 0x17478 bytes (93 KB)
before mem_malloc_init
--8<---------------cut here---------------end--------------->8---

It seems that signature checking is OK because both the SPL and regular
u-boot are started. However, something seems to cause u-boot to hang.

Here I am hanging in initr_malloc function, right in the
mem_malloc_init call:

--8<---------------cut here---------------start------------->8---
static int initr_malloc(void)
{
	ulong start;

#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
	debug("Pre-reloc malloc() used %#lx bytes (%ld KB)\n", gd->malloc_ptr,
	      gd->malloc_ptr / 1024);
#endif
	/* The malloc area is immediately below the monitor copy in DRAM */
	/*
	 * This value MUST match the value of gd->start_addr_sp in board_f.c:
	 * reserve_noncached().
	 */
	start = gd->relocaddr - TOTAL_MALLOC_LEN;
	gd_set_malloc_start(start);
	debug("before mem_malloc_init\n");
	mem_malloc_init((ulong)map_sysmem(start, TOTAL_MALLOC_LEN),
			TOTAL_MALLOC_LEN);

	debug("after mem_malloc_init\n");
	return 0;
}
--8<---------------cut here---------------end--------------->8---

If I add initcall traces, then I'm not going that far:

--8<---------------cut here---------------start------------->8---
U-Boot SPL 2024.04-rc1-00004-g8494a62b246-dirty (Feb 06 2024 - 15:06:54 +0100)
SOC: 0xa0009300
LC: 0x40040
M33 prepare ok
Normal Boot
Trying to boot from BOOTROM
Boot Stage: USB boot
NOTICE:  BL31: v2.6(release):d8bc791fb
NOTICE:  BL31: Built : 18:11:44, Mar 15 2023
initcall: 000000008027189c

U-Boot 2024.04-rc1-00004-g8494a62b246-dirty (Feb 06 2024 - 15:06:54 +0100)

initcall: 000000008022481c
U-Boot code: 80200000 -> 802B43C0  BSS: -> 802BA4A0
initcall: 0000000080224654
initcall: 0000000080203844
CPU:   i.MX93 rev1.0
initcall: 0000000080224fdc
Model: Variscite VAR-SOM-MX93 on Symphony evaluation board
initcall: event 8/(unknown)
initcall: 0000000080224850
DRAM:  initcall: 00000000802035a8
initcall: 0000000080224bb8
Monitor len: 000BA4A0
Ram size: 80000000
Ram top: 100000000
initcall: 0000000080224640
initcall: 00000000802248b8
initcall: 0000000080202e24
initcall: 00000000802248c0
initcall: 00000000802248c8
initcall: 00000000802247b4
Reserving 745k for U-Boot at: fff25000
initcall: 0000000080224968
Reserving 32784k for malloc() at: fdf21000
initcall: 0000000080224908
Reserving 152 Bytes for Board Info at: fdf20f60
initcall: 00000000802249a8
Reserving 480 Bytes for Global Data at: fdf20d80
initcall: 0000000080224744
Reserving 24832 Bytes for FDT at: fdf1ac80
initcall: 00000000802248d0
initcall: 00000000802248d8
initcall: 00000000802248f8
initcall: 0000000080224c30
initcall: 00000000802035e0
initcall: 00000000802249ec

RAM Configuration:
Bank #0: 80000000 2 GiB
Bank #1: 0 0 Bytes

DRAM:  2 GiB
initcall: 0000000080224c44
initcall: 0000000080224720
New Stack Pointer is: fdf1ac70
initcall: 000000008022465c
initcall: 00000000802248e0
initcall: 00000000802248e8
initcall: 00000000802246a0
Relocation Offset is: 7fd25000
Relocating to fff25000, new gd at fdf20d80, sp at fdf1ac70
initcall: 0000000080224900
initcall: 0000000080227704
initcall: 00000000fff49c8c
initcall: 00000000fff49c94
initcall: 00000000fff4c8c0
initcall: 00000000fff49f54
Added memory mapping (5): 80000000 80000000
initcall: 00000000fff49f04
initcall: 00000000fff49f74
initcall: 00000000fff49ea4
Pre-r
--8<---------------cut here---------------end--------------->8---

and I am stopping in the process of writing the "Pre-reloc ..." trace.

All-in-all, fusing the board seems to change something causing the
previously working images (on a non-closed board) to stop working.

Does it ring a bell to anyone?

Thanks,

Mathieu
