Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFEFCA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 12:44:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F8C381325;
	Sat,  3 Oct 2026 12:44:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9qSAs4FXAfKM; Sat,  3 Oct 2026 12:44:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6327881305
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791031444;
	b=cUffjcDCmCB2eepsCAtfCMZcOPDWjmW0W4AiPQRnA3p03Im3NgVinpVM1WnXWj4ppxgB
	 mC2OzyaBF8wXR+K7DpBJBDfS5bmYtHBfO2HUsu1VlJuyQifdRBkt37s2mA51VSBZPIytA
	 Bo3ECxsIL/SkJ74RL5oRBVxHIyrcAS2q9CT8TxO4EyxGs9jxMKnwHHrfeCqK/Aw7hy8mj
	 BFY9ncg62C4lGVIItvzaXwmi0thDyKbKN0Pk2gKXPUEePgQo/pbql154UzjV5Lwnfh0rE
	 LLS64271bzZ6nAXytYL0UD7wfFrH2NO2wekJhbfiuqoVsSbwAsedvUl7Fkb51fRoRig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791031444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=H3zgBY48aw+4rmTyHHG6VTv506ZLPY1x5sdMz6LHRJU=;
	b=jh38KlzecxkfcPgCiD3D7Fy3SgFKiGVgb0HHmcDxBqvJIvVZ02duhi7prvyEV8RWn7VP
	 UN1WyelpPnzUXB4a7LjAr62MLtgT7u3/muhJJA5wWSXwdxDlWVLwEoqRwTp1tGvK0Vxac
	 N8izwgbOZkHcAL8caaGsOm1hPIETzNc1aJ7W4VBmGb5Z/OD70I2WlNo91ZgvJe6Py2aWZ
	 pbogcEcuVPKx+dm1tZhucBOvOKJ4gUXcWYXJqOkXI/TMdjV1ShQCLsLYslb6aRsmUsNoV
	 fsP8LV4sAfwyBuiY0AoGD+3wJidD/8gGYFWn0if+CrtSFDeVdFCbuYhii1k5ien2H9g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791031444;
	bh=H3zgBY48aw+4rmTyHHG6VTv506ZLPY1x5sdMz6LHRJU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RDzyVQybesnJXZJMxS+63rJlIerX/d7leTDB8TC05Nj5u5Up8VZm8JIEaYaY/il8+
	 6Zz7wgsLgK4krf0uRNes+C+Oct3FtgakcQDxC0961usWnoUlJs8jvDGQve8LsMelTK
	 kWSpWv0PNNKHYDI9K5L+AXMWkO1Aj5zX56RHwy9BeoYoTP8ZT2zZwpPfE/0+MyEkrr
	 gg4gbTUt1yDNpnCNXSU1URpK2j33/b4IB+zjwMf/GGPZFRqEMRELlK9LEtK5dFJa7h
	 WVaOrk+nV98OtrzNBRejWZ+9//jJD0QRQczcQMoHWEY3QRSPr3o1mPoYrZcEJOSyAW
	 7U1Ocf77/1vKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6327881305;
	Sat,  3 Oct 2026 12:44:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 52833435
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 12:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 386C3400F9
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 12:44:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NlduHwJKJfvw for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 12:43:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9AD5840063
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791031438;
 b=Stpb1bXaZHHDCIB77511u8dIK/ED8qxvKuyMWxvwLDGvkywv8AS2oaRqeGlNcEnchQnn
 CDdVFnifogOBaKMlUMI355/UgzNrIbBRkS/G/RP5/xgXq7ilKYuj7A2MM2vExHe6y8B2k
 8e0WqKYu2DSxj3f8xls9Flbi2La0t9qjho5xYxbmnIt/Vz+wK0ostYnCGA95mFOSUxGPQ
 IQ9lZtreP9S0ZzqNzAkprY4OjxMh/j8AjgZvaJKsPQh3Gr4E8WJrwvYuA5WQBjPtBHaBz
 nbJFEQkkBc9NSC3LNSehEMoDWkawuqj3MvcHYqh/oAYR71Yl/q8Z/QD18Jnu4708q4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791031438;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=H3zgBY48aw+4rmTyHHG6VTv506ZLPY1x5sdMz6LHRJU=;
 b=nR4U4P6RJ4OTYPrtx4oinh6LAonyZ178Vydu49oa4LX+AkYLhHBc43YdhbjoPvxCJMDa
 GFLw93gNFQnpgw1DXrdUPvJYTJ/eymhJ8CHALHpkV3GnCtMfTdBYuTscntGBtAFl/ttZa
 ikcwFnQgIAiRSh83uRUhZ3GjwJ+/fvcMsDSdYp3rArrHLAwSJJw/p7jIZ6Q5o32fZHscA
 J62b58zrFAXg0qBL3A0XyCru7dxRVPOfO6fewtbSfToIcuYKnyc6MOdPznN++RGRSiuTl
 G7tTLY/ZwLxWaewkgyefHW65Oo+ZI03VulIfb3ZY2SlQ6dF+W5vLCS43ysHisw51ffA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=YTvSwNDW; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=YTvSwNDW
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9AD5840063
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 12:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791031403;
 bh=H3zgBY48aw+4rmTyHHG6VTv506ZLPY1x5sdMz6LHRJU=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=YTvSwNDWOOdA5Bu+SrB9ngNY5CfGVjCDMtr/8rS0V+b+hJsyWIkw5sQ3Gx4TNwBk2
 xFxJ5t8xNMCM67FLCMD8LeB2sbu24/cLOyf776D8OSf2FoC8t1XAmsYWGRLmtdG7+8
 Ji2DH5sN4imDwUyRQp5L5mgbx3e5cPCSf2fV4RwnwLgKpIvgUxMKVHRfid5B9LRl8P
 VDzTcaNYGywHnSiZ3D5k9Y+CLbumfNoRGo7RBN8EMzln+TQ3HNug0GbIG9PyKlV59M
 fhAV1rGwcQ7uyzO8a6CJtcWTEiLOCpckgwK6YGZGGgYIGaghxKla6QRATpVjnvwLlN
 4xY20qkxxt2yA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 41ABCB2243CB;
 Sat,  3 Oct 2026 14:43:21 +0200 (CEST)
Message-ID: <b506708c-5ee2-492b-a77c-4bdc9a904b9e@freeshell.de>
Date: Sat, 3 Oct 2026 05:43:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: E Shattow <e@freeshell.de>
Subject: Re: [PATCH v3 4/4] doc: spacemit: k3: Add Pico-ITX board
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>, Junhui Liu <junhui.liu@pigmoral.tech>
References: <20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org>
 <20261003-00-basic-spacemit-k3-v3-4-dea68cd1bd7d@kernel.org>
Content-Language: en-US
In-Reply-To: <20261003-00-basic-spacemit-k3-v3-4-dea68cd1bd7d@kernel.org>
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

Hi Yixun,

On 10/2/26 17:34, Yixun Lan wrote:
> Add documentation for how to test the mainline U-Boot on SpacemiT
> K3 Pico-ITX board, currently it still rely on using vendor FSBL.bin
> file to initialize DDR and boot U-Boot proper, and the opensbi
> firmware is built from an on-going mainline branch.
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  doc/board/spacemit/index.rst             |   1 +
>  doc/board/spacemit/spacemit-pico-itx.rst | 204 +++++++++++++++++++++++++++++++
>  2 files changed, 205 insertions(+)
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
> index 00000000000..dd29e3c31c8
> --- /dev/null
> +++ b/doc/board/spacemit/spacemit-pico-itx.rst
> @@ -0,0 +1,204 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +SpacemiT K3 Pico-ITX
> +====================
> +
> +Building
> +~~~~~~~~
> +1. Install the SpacemiT riscv cross compile toolchain_, or skip it if riscv toolchain is installed.
> +
> +.. _toolchain: https://archive.spacemit.com/toolchain/
> +

Avoid the advertisement for any unnecessary vendor-specific information.

The packaged toolchain from any generic Linux distro is fine enough to
build with as "1. Add a RISC-V toolchain to your PATH." and no other
explanation is required.

I have tested with Debian forky/testing for example, it is fine. Code
size differences between output of GCC major versions may be detailed in
a future update if it becomes important.

> +2. Setup cross compilation environment variable:
> +
> +.. code-block:: console
> +
> +   export CROSS_COMPILE=<riscv64 toolchain prefix, e.g /opt/spacemit/bin/riscv64-unknown-linux-gnu->
> +

Likewise, it is enough to have "2. Set a cross-compilation environment
variable if needed: export CROSS_COMPILE=<riscv64 toolchain prefix>"

There is much documentation about compiling U-Boot at
doc/build/index.rst and so do not name a specific vendor toolchain path
name here.

> +3. Before building U-Boot, OpenSBI should be built first. OpenSBI can be
> +built for SpacemiT K1 SoC as below:

built for SpacemiT K3 SoC ?

However it is clearer to re-phrase that as a statement of requirements.
"3. U-Boot for SpacemiT K3 SoC requires OpenSBI in-development generic
platform object fw_dynamic.bin to be included in the Flattened Image
Tree blob. OpenSBI may be first built as below: ..."

Please if it will help you then do copy any build examples adapted from
my own writing in doc/board/starfive/jh7110_common.rst which contains a
small error in build command details corrected at
https://lore.kernel.org/u-boot/20260924063843.8934-1-e@freeshell.de/

Additional phrasing may be as "Review the OpenSBI developer mailing list
archives for patches to apply in support of SpacemiT K3 Pico-ITX". Let
this be generic enough that we are not dead-linking to something 10
years later when a user is viewing this old document from the future.

> +
> +.. code-block:: console
> +
> +   git clone https://github.com/spacemit-com/opensbi-upstream opensbi
> +   cd opensbi
> +   make PLATFORM=generic

Please refer to upstream directly. I appreciate to make it convenient
with patches curated on a fork repository but this is not durable for
documentation purpose, is this going to exist in 2 years? 10 years? 20
years?. Mailing list archives are durable and if we depend on OpenSBI
then I expect at least upstream OpenSBI git repository to be durable, too.

> +
> +4. Then build U-Boot as following:
> +
> +.. code-block:: console
> +
> +   cd <U-Boot-dir>
> +   make spacemit_k3_defconfig
> +   make OPENSBI=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin
> +
> +This will generate u-boot.itb
> +
> +Testing
> +~~~~~~~
> +Currently, in this stage, the U-Boot SPL isn't ready, and has no ddr initialization code

Instead, as "Currently there is no U-Boot SPL build target. It is
required to use 'FSBL.bin' vendor board support package SPL for DDR
initialization and testing u-boot.itb"

May SPI NOR be erased empty? what exactly must be present in SPI NOR for
successful testing?

> +Thus please test with fasboot command via USB download.

fastboot

> +
> +First, retrieve Bianbu Linux image from archive_ and extract the FSBL.bin firmware.

We should build any out-of-tree dependencies (FSBL.bin) from from source
if it is possible. This is a cheap operation to 'git remote add -f
spacemit-com https://...spacemit-com/uboot-2022.10' on an existing
u-boot git repo.

Assume SPI NOR content is erased. Is there something vendor-specific you
need that is not available by compiling spacemit-com k3-br-v1.0.y branch?

> +
> +Second, hold the FEL button of Pico-ITX board, then press reset button and release it .
> +The board will enter into firmware download mode.
> +
> +.. code-block:: none
> +
> +   sys: 0x10001200
> +   bm:2
> +   usb_init : enter 3296,3072
> +   usb_core_init : enter
> +   DWC3_GRXTHRCFG:0x4400000
> +   ROM: usb download handler
> +    rst
> +   done H
> +   setup= 0x1000680 0x400000,
> +    rst
> +   done H
> +   setup= 0x290500 0x0,
> +   setup= 0x1000680 0x120000,
> +   setup= 0x2000680 0x90000,
> +   setup= 0x2000680 0x200000,
> +   setup= 0x3000680 0xff0000,
> +   setup= 0x3020680 0xff0409,
> +   setup= 0x3010680 0xff0409,
> +   setup= 0x10900 0x0,
> +   usb_rx_bytes : start len[4096]
> +   setup= 0x3020680 0xff0409,
> +   setup= 0x3040680 0xff0409,
> +
> +Run following command to test:
> +
> +.. code-block:: console
> +
> +   fastboot stage FSBL.bin
> +   fastboot continue
> +   sleep 10
> +   fastboot stage u-boot.itb
> +   fastboot continue
> +
> +.. _archive: https://archive.spacemit.com/image/k3/version/bianbu/v4.0.7/
> +.. _uboot: https://bianbu-linux.spacemit.com/en/device/boot#21-firmware-layout
> +
> +Booting
> +~~~~~~~
> +Sample boot log
> +~~~~~~~~~~~~~~~
> +.. code-block:: none
> +
> +   sys: 0x10001200
> +   bm:2
> +   usb_init : enter 3296,3072
> +   usb_core_init : enter
> +   DWC3_GRXTHRCFG:0x4400000
> +   ROM: usb download handler
> +    rst
> +   done H
> +   setup= 0x1000680 0x400000,
> +    rst
> +   done H
> +   setup= 0x2f0500 0x0,
> +   setup= 0x1000680 0x120000,
> +   setup= 0x2000680 0x90000,
> +   setup= 0x2000680 0x200000,
> +   setup= 0x3000680 0xff0000,
> +   setup= 0x3020680 0xff0409,
> +   setup= 0x3010680 0xff0409,
> +   setup= 0x10900 0x0,
> +   usb_rx_bytes : start len[4096]
> +   setup= 0x3020680 0xff0409,
> +   setup= 0x3040680 0xff0409,
> +   fastboot_handle_command: max-download-size
> +   usb_tx_bytes : start len[14]
> +   usb_rx_bytes : start len[4096]
> +   fastboot_handle_command: 00072b20
> +   Starting download of 469792 bytes
> +   usb_tx_bytes : start len[12]
> +   usb_rx_bytes : start len[469792]
> +   usb_tx_bytes : start len[4]
> +   usb_rx_bytes : start len[4096]
> +   fastboot_handle_command: continue
> +   usb_tx_bytes : start len[4]
> +   j...
> +
> +   U-Boot SPL 2022.10 (Sep 07 2026 - 11:31:13 +0000)
> +   LPDDR5 total size: 16 GB, data rate: 6400 MT/s
> +   DDR training consume 5625ms
> +   ..
> +   OpenSBI v1.9-72-g13a401f8
> +      ____                    _____ ____ _____
> +     / __ \                  / ____|  _ \_   _|
> +    | |  | |_ __   ___ _ __ | (___ | |_) || |
> +    | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
> +    | |__| | |_) |  __/ | | |____) | |_) || |_
> +     \____/| .__/ \___|_| |_|_____/|____/_____|
> +           | |
> +           |_|
> +
> +   Platform Name               : SpacemiT K3 Pico-ITX
> +   Platform Features           : medeleg
> +   Platform HART Count         : 8
> +   Platform HART Protection    : pmp
> +   Platform IPI Device         : aclint-mswi
> +   Platform Timer Device       : aclint-mtimer @ 24000000Hz
> +   Platform Console Device     : uart8250
> +   Platform HSM Device         : spacemit-k3-hsm
> +   Platform PMU Device         : ---
> +   Platform Reboot Device      : spacemit-p1-reset
> +   Platform Shutdown Device    : spacemit-p1-reset
> +   Platform Suspend Device     : ---
> +   Platform CPPC Device        : ---
> +   Firmware Base               : 0x100000000
> +   Firmware Size               : 416 KB
> +   Firmware RW Offset          : 0x40000
> +   Firmware RW Size            : 160 KB
> +   Firmware Heap Offset        : 0x57000
> +   Firmware Heap Size          : 68 KB (total), 1 KB (reserved), 14 KB (used), 52 KB (free)
> +   Firmware Scratch Size       : 4096 B (total), 1472 B (used), 2624 B (free)
> +   Runtime SBI Version         : 3.0
> +   Standard SBI Extensions     : time,rfnc,ipi,base,hsm,srst,pmu,dbcn,fwft,legacy,dbtr,sse
> +   Experimental SBI Extensions : none
> +
> +   Domain0 Name                : root
> +   Domain0 Init Order          : 0xffffffff
> +   Domain0 Boot HART           : 0
> +   Domain0 HARTs               : 0x0*,0x1*,0x2*,0x3*,0x4*,0x5*,0x6*,0x7*
> +   Domain0 Region00            : 0x0000000100000000-0x000000010003ffff M: (F,R,X) S/U: ()
> +   Domain0 Region01            : 0x0000000100040000-0x000000010007ffff M: (F,R,W) S/U: ()
> +   Domain0 Region02            : 0x00000000d4017000-0x00000000d4017fff M: (I,R,W) S/U: (R,W)
> +   Domain0 Region03            : 0x00000000e081c000-0x00000000e081ffff M: (I,R,W) S/U: ()
> +   Domain0 Region04            : 0x0000000000000000-0xffffffffffffffff M: () S/U: (R,W,X)
> +   Domain0 Next Address        : 0x0000000102000000
> +   Domain0 Next Arg1           : 0x0000000102091398
> +   Domain0 Next Mode           : S-mode
> +   Domain0 SysReset            : yes
> +   Domain0 SysSuspend          : yes
> +
> +   Boot HART ID                : 0
> +   Boot HART Domain            : root
> +   Boot HART Priv Version      : v1.12
> +   Boot HART Base ISA          : rv64imafdcbvhx
> +   Boot HART ISA Extensions    : smaia,smstateen,sscofpmf,sstc,zicntr,zihpm,smcntrpmf,zicboz,zicbom,svpbmt,sdtrig,svade,ssstateen,v,f,d
> +   Boot HART PMP Count         : 16
> +   Boot HART PMP Granularity   : 12 bits
> +   Boot HART PMP Address Bits  : 38
> +   Boot HART MHPM Info         : 16 (0x0007fff8)
> +   Boot HART Debug Triggers    : 4 triggers
> +   Boot HART MIDELEG           : 0x0000000000003666
> +   Boot HART MEDELEG           : 0x0000000000f0b509
> +
> +   <debug_uart>
> +
> +
> +   U-Boot 2026.10-rc4-00501-g9fba7b59df42 (Sep 22 2026 - 13:08:33 +0000)
> +
> +   DRAM:  16 GiB
> +   Core:  433 devices, 15 uclasses, devicetree: separate
> +   Loading Environment from nowhere...Loading Environment from nowhere... OK
> +   In:    serial@d4017000
> +   Out:   serial@d4017000
> +   Err:   serial@d4017000
> +   Net:   No ethernet found.
> +   =>
> 

Thanks for your work on this,

-E
