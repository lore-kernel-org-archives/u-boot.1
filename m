Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D17E7D26A
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C2A686BF7;
	Tue, 26 Sep 2023 10:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ghIk4YW2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2B5B86D4D; Tue, 26 Sep 2023 10:58:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F2286BB2
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695718714; x=1696323514; i=xypron.glpk@gmx.de;
 bh=z73rT8b1JVeeNMujmz/su9pua/Ceb6PcIhOxD65MX9E=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ghIk4YW2UXAe2BfebckXMDWyobKQ+zKhdbH4I1O5/EO87lNweIAUjRh7B2PJypJaMgYAolzry0H
 dqOha/CWVcs8EG4gs/c+H/Iupp9b8TKM1yC87NcWjpVPoI8hLpv6eqCC4wEILTkompEUXJbo1bnBd
 5PP9xAP743VfeiFCLKcpIC251mnhCxxd965ak+RbZVfL2OxmeyyINm1bmolfqAL1J5Y8dwgJ1/61V
 F9GL3jdT9zermUVUR+svgDWA5DeQRPkNQ8NIocRmd5ClIwqGsEO+9GkG+uS9z67bSCNeiUoHcK9Wc
 56aFOldght+Og2iuv9HdnwrEdPBCb8OTdk4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwwdl-1rZI6D00WR-00yNbg; Tue, 26
 Sep 2023 10:58:34 +0200
Message-ID: <2487902a-1b98-42be-9d7c-16c98fd56815@gmx.de>
Date: Tue, 26 Sep 2023 10:58:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] blk: sandbox: Support binding a device with a given
 logical block size
Content-Language: en-US, de-DE
To: Bin Meng <bmeng@tinylab.org>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heiko Schocher <hs@denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Johan Jonker <jbx6244@gmail.com>,
 Joshua Watt <jpewhacker@gmail.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Suchanek <msuchanek@suse.de>, Peng Fan <peng.fan@nxp.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20230926084346.2237483-1-bmeng@tinylab.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230926084346.2237483-1-bmeng@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JsFWbSoehpxqgsRWKL+TOuCBUD9LXLcVxSpPi3y3RP/BSNZK0sm
 fGjzYF44JIJtLyCCVVqKv6H1W3nq63xZslq+F1jXD5ncNQdvAgGKEgDgrK0IrA3n7EArjHb
 +YQO8T59b4cmjvVhSN2x59XSlA33Tg1kmZWLQVCz8WIuHlq5CTfiZQ0OOGmWOGCVy0xc01O
 Z8oTTXmMjSUNWZ4SEidSg==
UI-OutboundReport: notjunk:1;M01:P0:ed71C2luEaI=;Oe+H0qTCfEYCjZbsNCGL+2kHtE/
 pu/MXri/Fg9AgaiogAbr2P9yq7Cr53sxU7hBK7iu3UU+Jeuo2Ep1lbD9bBs6TtC1cNmoqmrd1
 zHsuURaIB6iHM4rxVZm6FMzqbzKv6Z4Nzujdcd71WnrmV8FKaKAO0CZXNZqS5YK6wjkjP+v5M
 HR8WFZNP1uVzzsIc/3TVeyRfKMFradvfBaaM+JfgSZYWX4gJx/J+tDnk3iMlLfwzJaGhcVkAv
 I02wVNfzVj7xfkd6jyySYcXuHBkAq0HRieUAvR+gq0JchuKJcBFktiy3jzvIo8G0bvPX2sydj
 yiGL9ym7S1nfX4KOib1xtO7n1p5Ll416xVS/Y80ZBQ9xEi+zIywN9Ov4ohjP9G5ArvmBNtEEA
 42oYeXyDU50jq7t74xXNa/V7kB42rRH+QbJWVbso7cYxxsH5wDk51xTAwzRQg7oXLNy7rP7QS
 FDb2dMT7W476JlxYcFJ4ojQqFjyu0bS3P2Gcqk4uokq7+Q2ekG4UycfL/nYbZ+WEBNu+xADfg
 6az8fRFVyHVJekzDLbXEpbGdiPH267ajPfjospGkqQIcEBj9717SgiBI49SF21Dco0y3NRoTB
 NCpR/pCzbq3DIVmg14bSRZQxGrzAtnHjXiSQI8lzCIANCnmq6Qlhlvt0FVPuLx0TJKkoW7uKF
 G8eWxGk98p4FEovIvVK3a6od04A+IiwOSnMUJ2xZpzySsJi7J4OEN8TMgX93B5Y5fEnLqYugS
 svmtr/UpfbtwbtNh762fPVoySRSYktCAAOEqflrcW18LVaYwdFUBmuCOFaoNMZ/WDdycXFE4C
 GJ/xJ+tKA9jEi/4QPZIn5NYO3QJzqvfIlvxORjfWvLl6MuStB+pBLs3zhGWLSD5Gr7nVg0qOl
 t7I1h7jwEl16/gs3btJI5oGsS1P9VohI86RYrnFZsrgzUM9ow2Pu8W14IXjoB/R1Ix5/3P9O7
 WSWTLE8SdfAJoqF3anwPSSMzFYM=
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

On 9/26/23 10:43, Bin Meng wrote:
> At present on Sandbox when binding to a host backing file, the host
> block device is created with a hard-coded 512 bytes block size.
>
> Such assumption works for most cases, but for situation that with a raw
> image file dump from a pre-formatted GPT partitioned disk image from a
> 4KiB block size device, when binding this file to a host device and mapp=
ing
> this device to a blkmap, "blkmap" command like "blkmap part" won't work
> correctly, due to block size mismatch during parsing the partition table=
.
>
> This series updates Sandbox block driver, as well as the blkmap driver,
> to get rid of the hard-coded 512 bytes block size assumption.
>
> This series is available at u-boot-x86/blk for testing.

It is really good to have an easy way to test other block sizes.

We can also use QEMU for alternative block sizes:

$ qemu-system-riscv64 -device nvme,help
logical_block_size=3D<size>
physical_block_size=3D<size>

In the commit messages, please, make it clear that you refer to logical
block sizes and not to the physical block size.

Best regards

Heinrich

>
> Test log (512 block size):
>
>    =3D> host bind 0 test.img
>    =3D> host info
>    dev       blocks  blksz label           path
>      0       262144    512 0               test.img
>    =3D> blkmap create 0
>    Created "0"
>    =3D> blkmap map 0 0 40000 linear host 0 0
>    Block 0x0+0x40000 mapped to block 0x0 of "host 0"
>    =3D> blkmap info
>    Device 0: Vendor: U-Boot Rev: 1.0 Prod: blkmap
>                Type: Hard Disk
>                Capacity: 128.0 MB =3D 0.1 GB (262144 x 512)
>    =3D> blkmap part
>
>    Partition Map for BLKMAP device 0  --   Partition Type: EFI
>
>    Part    Start LBA       End LBA         Name
>            Attributes
>            Type GUID
>            Partition GUID
>      1     0x00000022      0x000000bd      "u-boot-spl"
>            attrs:  0x0000000000000000
>            type:   5b193300-fc78-40cd-8002-e86c45580b47
>                    (5b193300-fc78-40cd-8002-e86c45580b47)
>            guid:   0bb6bb6e-4aac-4c27-be03-016b01e7b941
>      2     0x00000822      0x00000c84      "u-boot"
>            attrs:  0x0000000000000000
>            type:   2e54b353-1271-4842-806f-e436d6af6985
>                    (2e54b353-1271-4842-806f-e436d6af6985)
>            guid:   91d50814-8e31-4cc0-97dc-779e1dc59056
>      3     0x00000c85      0x0000cc84      "rootfs"
>            attrs:  0x0000000000000004
>            type:   0fc63daf-8483-4772-8e79-3d69d8477de4
>                    (linux)
>            guid:   42799722-6e55-46e6-afa9-529e7af3f03b
>
> Test log (4096 block size):
>
>    =3D> host bind 0 test.img 4096
>    =3D> host info
>    dev       blocks  blksz label           path
>      0        32768   4096 0               test.img
>    =3D> blkmap create 0
>    Created "0"
>    =3D> blkmap map 0 0 8000 linear host 0 0
>    Block 0x0+0x8000 mapped to block 0x0 of "host 0"
>    =3D> blkmap info
>    Device 0: Vendor: U-Boot Rev: 1.0 Prod: blkmap
>                Type: Hard Disk
>                Capacity: 128.0 MB =3D 0.1 GB (32768 x 4096)
>    =3D> blkmap part
>
>    Partition Map for BLKMAP device 0  --   Partition Type: EFI
>
>    Part    Start LBA       End LBA         Name
>            Attributes
>            Type GUID
>            Partition GUID
>      1     0x00000100      0x00001fff      "primary"
>            attrs:  0x0000000000000000
>            type:   0fc63daf-8483-4772-8e79-3d69d8477de4
>                    (linux)
>            guid:   eba904d7-72c1-4dbd-bb4e-36be49cba5e3
>      2     0x00002000      0x00007ffa      "primary"
>            attrs:  0x0000000000000000
>            type:   0fc63daf-8483-4772-8e79-3d69d8477de4
>                    (linux)
>            guid:   c48c360e-db47-46da-ab87-26416fad3cd3
>
>
> Bin Meng (15):
>    blk: Use a macro for the typical block size
>    cmd: host: Mandate the filename parameter in the 'bind' command
>    blk: sandbox: Support binding a device with a given logical block siz=
e
>    blk: host_dev: Make host_sb_detach_file() and host_sb_ops static
>    blk: host_dev: Sanity check on the size of host backing file
>    cmd: host: Print out the block size of the host device
>    blk: blkmap: Make bind/unbind routines static
>    cmd: blkmap: Make map_handlers[] and its .fn static
>    blk: blkmap: Support mapping to device of any block size
>    cmd: blk_common: Use macros for the return values
>    dm: blk: Rename get_desc() and make it externally visible
>    cmd: blk_common: Stop using hard-coded block size for Sandbox
>      operations
>    dm: blk: Drop blk_{read,write}_devnum()
>    disk: part: Print out the unknown device uclass id
>    disk: part: Handle blkmap device in print_part_header()
>
>   cmd/blk_common.c            | 34 +++++++++++++++----------
>   cmd/blkmap.c                |  7 ++---
>   cmd/host.c                  | 25 +++++++++++++-----
>   common/usb_storage.c        |  4 +--
>   disk/part.c                 |  5 +++-
>   drivers/ata/dwc_ahsata.c    |  3 ++-
>   drivers/ata/fsl_sata.c      |  3 ++-
>   drivers/ata/sata_mv.c       |  3 ++-
>   drivers/ata/sata_sil.c      |  3 ++-
>   drivers/block/blk-uclass.c  | 51 +++++--------------------------------
>   drivers/block/blkmap.c      | 16 ++++++------
>   drivers/block/host-uclass.c | 15 ++++++++---
>   drivers/block/host_dev.c    | 11 +++++---
>   drivers/mmc/mmc-uclass.c    |  2 +-
>   drivers/nvme/nvme.c         |  2 +-
>   include/blk.h               | 40 ++++++++++-------------------
>   include/sandbox_host.h      |  7 +++--
>   test/dm/blk.c               |  7 ++---
>   test/dm/host.c              | 26 +++++++++----------
>   19 files changed, 129 insertions(+), 135 deletions(-)
>

