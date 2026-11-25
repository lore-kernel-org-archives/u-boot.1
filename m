Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0784E606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 23:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eIUKBC3U;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=ftfrTtuC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E049606D9;
	Wed, 25 Nov 2026 23:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TcRdBJSKDx7X; Wed, 25 Nov 2026 23:53:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 122B0606DA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795650780;
	b=PuXjcFx99iHJezm3pG0YMsB8erxdERl6NCvpEazU8rgT0/onkxKpgm928fv5f6ryAOUm
	 zXUqOd9cIWMb6tH9Pfa1ASDB0kZAplvRyqhebgEA8L5d4bwSzArQM9mBJoO6JPxAdFFYN
	 imYVsRdvdf8DdcJ1ciJMbF7w2ys8lMHxw0LmW4k2raNKZenK5l34kZqQzt3g6Cm5PgLBg
	 VrPFWsDy/bYZ3qSkG9JOvwrjOFiO7pZ2H7FjKtLNF9dV9++eh3edjuZHoSnF3Ufufhek/
	 H5DUMp3QiAVaRT5AW5G+EuQRNXzKjtCVJCL+JryvnSuXy3bhTs/V44USaLSysIrUPLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795650780;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8r1z27oqGBA29QfVIvN2IsueY3lSwRDuutkuswtphmg=;
	b=Pc/n85e74+xa9d4XF5OXofvrT2W+wVB/OzsSLYHye7qTo4Nz6/RojwXQSYJlUvvZgN5p
	 jk4W6GhH0A3uJ1nJfbe9bK3ByBjxmvjyBkr8auceXyyr/zOWo4kgpQY4MVlqu3QSnSJpR
	 0MgL1161hWBUlFn5g+UT41ieHJChwI7exboL3PZw6wgOSKbyoKpbidXeOLO4di07yeI10
	 sRQTXZPrxfsnlJ0h5gLcJTw51bj3/DURZ0fdLXWHR8cWxIEo8KE2/2F8eolvUtzdNIRit
	 9WKSR6+caTGtwfLNFX4QSr9an//RljVjsERp0S0/shwl5oU+DZp2VcKPriV/fPtonRw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795650780;
	bh=8r1z27oqGBA29QfVIvN2IsueY3lSwRDuutkuswtphmg=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eIUKBC3U9Wwk4yEXAl1a9zOTEZlgFvrZpwqaycsP1o+EzAsyj2oRzdOcxy8IpAt6p
	 ahL1uPNAotULGpi0c/CaqBJ0yg4mqfkNW66LNOUwaoSwWulC4FI76YwpUZVVfchB2n
	 xVvWKTs+WdjBwo2fh06SHgkugWubCOXiQ0SRQJVAICJj10nSPVVfwnN5X95BF2tH6w
	 GWyT5d8lWUfVNi4c24CvjeTSGArtFa/aWuI9/ufZdfiYBuQ4GjL6p+CwywY3KLiXl2
	 GrTbaNrdebMK8H3ZMbYYWvK3C/xNaNBBLiUEJPtd+WqymDth27Txf/WvkT/K37eKD9
	 6AOpP5InmlKOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 122B0606DA;
	Wed, 25 Nov 2026 23:53:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF352371
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 23:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0BA84004D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 23:52:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SIKRCOrfWteS for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 23:52:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 94FEA40024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=ftfrTtuC
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 94FEA40024
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 23:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795650770;
 bh=8r1z27oqGBA29QfVIvN2IsueY3lSwRDuutkuswtphmg=;
 h=Date:From:Subject:To:References:In-Reply-To:From;
 b=ftfrTtuC2aDIYeJMABXB5ieqi8TvYPc0S7+VZKGQyOnASbZCT+2+JnLqyvfurc4j1
 48mt0r0ZNAyHNSm7h289gmDy5ppQOihJgO/2+KHal0lEWM48is/3dipsrWBQ7hPvdr
 LdYAPjq5iG55mIWVDVtAOqWd6lM8lgZgCPT0PiuVVcCYvKNCDuizERE42QOKL1Jwix
 EV1cIXmZ3DrU+t21MizufP/LJ47k09+IWWUsNKqvEhwXbfLCO3o5bCVaNpT8B3LLkA
 6DRA2gCWBGEFzoa0x3kv+Fb7MbsTY6Qnpngb7LjU3g40ZTYhpPQqu9JEIkDPqQ4r7o
 LqqB4d3nfdh0A==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id DCED5B22050A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 00:52:49 +0100 (CET)
Message-ID: <0bdd7822-46ea-4e1c-8ce5-a0975ee8cd96@freeshell.de>
Date: Wed, 25 Nov 2026 15:52:40 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: E Shattow <e@freeshell.de>
Subject: Re: [DNM v1 0/7] Guide to build reduced SpacemiT K3 vendor BSP
 (continued)
To: u-boot@lists.u-boot-project.org
References: <20261029001555.1890775-1-e@freeshell.de>
 <20261029003327.1890979-1-e@freeshell.de>
Content-Language: en-US
In-Reply-To: <20261029003327.1890979-1-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update as of November 2026,

On 10/28/26 17:33, E Shattow wrote:
> Do Not Merge
> 
> Informational purpose only, to aid mainline development of SpacemiT K3
> support.
> 
> ...continued from https://lore.kernel.org/u-boot/20261029001555.1890775-1-e@freeshell.de/
> 
> What is known to be working from mainline?
> - mkimage to post-process SPL into spl/u-boot-spl-mkimage.bin
> - FIT U-Boot main app u-boot.itb
> - dependency on OpenSBI
> 
> What do we need from the vendor BSP?
> - SPL
> 

> (Optional) Additional hardware used?
> - K3 Pico-ITX BootROM UART SPL loader mode selected by pull-up via
>   FPC-36P reverse cable and adapter to header pins (2.54mm pitch
>   DuPont connector).

Also an JST GH1.25 4P cable and breakout board accommodates a power
indicator LED and momentary switch. Long-press (~3 seconds) of the
switch begins a flashing power indicator LED sequence and after some
delay (~4 seconds) the power turns off. Short-press of the switch turns
on power when it was off previously. This can be useful to instrument
the power on/off sequence and set boot modes for automated board
testing, without soldering to the reset and boot mode button connections
directly.

OpenCD debug access for K3 Pico-ITX to K3 SoC is connected via five
solder points on the opposite face of PCB and near the same position
where the FPC-36P connector is populated. This is documented at:

https://github.com/spacemit-com/docs-chip/blob/main/en/key_stone/k3/k3_hw/static/pico-jtag-debug.png

Signal layout ordering:
- TRST_N (near "do not dispose in trash" silkscreen iconography)
- TDO
- TMS
- TDI
- TCK (near FPC-36P pin 18 on opposite face of PCB)

OpenCD debug access for K3 CoM260 to K3 SoC is connected via an adapter
for the micro SD card slot.

> 
> The assumption in this guide is root user in a fresh Debian 13
> Trixie build environment on amd64 architecture build host.
> 
> dpkg --add-architecture riscv64
> apt install -y bison ca-certificates flex gcc-riscv64-linux-gnu git \
>   libgnutls28-dev libpython3-dev libssl-dev python3-setuptools swig \
>   curl
> export CROSS_COMPILE=riscv64-linux-gnu-
> 
> git clone https://github.com/riscv-software-src/opensbi.git \
>   opensbi.git

> git -C opensbi.git checkout d28bc6f89837 # origin/master
> # v6 "platform: generic: spacemit: add K3 platform support"
> # https://patchwork.ozlabs.org/project/opensbi/list/?series=530305
> curl https://patchwork.ozlabs.org/series/530305/mbox/ \
>   | git -C opensbi.git am
> make -C opensbi.git O=../opensbi clean
> make -C opensbi.git O=../opensbi PLATFORM=generic

This was since merged in mainline OpenSBI for the next
tag after v1.9 release.

> 
> git clone https://git.u-boot-project.org/u-boot/u-boot.git u-boot.git
> git -C u-boot.git remote add -f spacemit-com \
>   https://github.com/spacemit-com/uboot-2022.10.git
> 

> git -C u-boot.git checkout 03e45557e1f3 # origin/main
> # v1 "Spacemit K3 enable Linux boot"
> # https://patchwork.ozlabs.org/project/uboot/list/?series=530384
> curl https://patchwork.ozlabs.org/series/530384/mbox/ \
>   | git -C u-boot.git am
> make -C u-boot.git O=../u-boot spacemit_k3_defconfig
> fw_dynbin=$(realpath opensbi/platform/generic/firmware/fw_dynamic.bin)
> make -C u-boot.git O=../u-boot OPENSBI=$fw_dynbin

This was since merged in mainline U-Boot for v2026.10-rc6 release candidate.

> 
> git -C u-boot.git checkout k3-br-v1.0.10 # spacemit-com/k3-br-v1.0.y
> # v1 "Guide to build reduced SpacemiT K3 vendor BSP"
> # https://patchwork.ozlabs.org/project/uboot/list/?series=530447
> curl https://patchwork.ozlabs.org/series/530447/mbox/ \
>   | git -C u-boot.git am
> mki=$(realpath u-boot/tools/mkimage)
> make -C u-boot.git O=../bsp-spi \
>   spacemit_k3_uart_spi_defconfig
> make -C u-boot.git O=../bsp-spi MKIMAGE=$mki \
>   spl/u-boot-spl-mkimage.bin
> make -C u-boot.git O=../bsp-nospi \
>   spacemit_k3_uart_nospi_defconfig
> make -C u-boot.git O=../bsp-nospi MKIMAGE=$mki \
>   spl/u-boot-spl-mkimage.bin
> 
> tar -czf reduced-spacemit-k3-vendor-bsp.tar.gz \
>   --transform 's~^~reduced-spacemit-k3-vendor-bsp/~' \
>   bsp-nospi/spl/u-boot-spl-mkimage.bin \
>   bsp-spi/spl/u-boot-spl-mkimage.bin \
>   u-boot/u-boot.itb
> 
> ### K3 Pico-ITX BootROM UART SPL loader
> Connect USB selection bias-pulldown pin 10 high to VCC1V8 pin 1 or
> pin 2 for UART selection and pin 11 high to VCC1V8 selects BootROM
> USB/UART download mode; pin 11 low is normal operation from selected
> NOR/UFS/MMC/NAND secondary boot after SD card. If you do not have a
> flat flex cable then it is possible with a sharp probe and steady
> hands to do so, the easiest method apparently being to connect the
> physically large VCC1V8 leg of the EEPROM part to probe FPC-36P pin 10
> and depress the Firmware DownLoad button held for a moment while
> pressing the reset or powering up the board. The reason for wanting to
> activate BootROM UART mode is to avoid the use of Fastboot USB, and to
> isolate any peripheral configuration that may have been acted upon by
> BootROM which may be different between the available BootROM SPL
> loader modes.

This is confirmed in use that BootROM SPL loader fastboot-compatible
mode does setup of clocks that are not touched by the BootROM SPL loader
UART mode, see the detail about "bsp-spi" following...

> 
> Visual reference:
> https://web.archive.org/web/20261025124009/https://freeshell.de/e/riscv64/K3PicoITX-explainer_boot_resistors-20261017draft.webp
> 
> Connect for fastboot transfers the K3 Pico-ITX USB-C OTG port (not the
> corner USB-C power input/display port) using USB-C to USB-A cable and
> then to any USB-A port on the fastboot and serial terminal host.
> 
> Connect a serial UART cable, note the board TXD is adjacent to the PCB
> board edge and opposite of that is GND with board RXD in the middle;
> swap adapter TXD and adapter RXD as appropriate.
> 
> The vanilla vendor BSP assumes use of fastboot USB in FSBL.bin SPL for
> main.itb loading. If the vanilla vendor BSP main.itb runs with pin 10
> low (the board default) then it again attempts to load an SPL and this
> can be escaped to a hush prompt by fastboot host 'fastboot continue'.
> 
> The UART variants of vendor BSP are patched to assume that u-boot.itb
> is loaded over serial UART in YMODEM protocol. If activated the
> BootROM UART loader assumes loading an SPL over serial UART in XMODEM
> protocol. Using the 'tio' serial terminal software the keybind
> sequences are (Control-t,x,0) for XMODEM and (Control-t,y) for YMODEM.
> If you initiate a transfer and question-mark characters '?' appear
> then the transfer has not synchronized correctly, so abort sending and
> then re-try sending the transfer until you will see '.' progress marks
> appear. The reduction in build config options for "bsp-spi" deletes
> support for USB from SPL. The "bsp-nospi" has nearly all options
> removed leaving only YMODEM loading, DRAM initialization, and
> dependency of EEPROM TLV access for DRAM id.

With mainline U-Boot v2027.01-rc3 the FSL QSPI driver now does clock
enablement (commit 7030b5d8bdf1 "spi: fsl_qspi: Add optional clock
support"). As this was previously, "bsp-spi" was working for 'sf probe'
and SPI NOR data operations in mainline U-Boot main app u-boot.itb *if*
BootROM SPL loader fastboot-compatible mode does its clock setup prior
to loading "bsp-spi". The 'sf probe' detection and SPI NOR data
operations failed if this was instead preceded by BootROM SPL loader
UART mode, which, apparently does not touch the necessary clocks. The
FSL SPI NOR driver in mainline U-Boot main app now works for 'sf probe'
after both SPL of "bsp-spi" or "bsp-nospi". Neither of these has an
effect on SPI NOR detection or access from subsequent Linux kernel use.

OzLabs Patchwork service is severely impacted by "A.I." data scraper bot
traffic and so 'curl' requests to it may timeout or fail to produce
valid output for input to 'git am'. Substituting for "curl ... | git am
..." with the use of 'b4' is recommended.

The revised "Guide to build reduced SpacemiT K3 vendor BSP (continued)"
build steps are now:

dpkg --add-architecture riscv64
apt install -y bison ca-certificates flex gcc-riscv64-linux-gnu git \
  libgnutls28-dev libpython3-dev libssl-dev python3-setuptools swig \
  b4
export CROSS_COMPILE=riscv64-linux-gnu-

git clone https://github.com/riscv-software-src/opensbi.git \
  opensbi.git
git -C opensbi.git checkout origin/master # or any tag after v1.9
make -C opensbi.git O=../opensbi clean
make -C opensbi.git O=../opensbi PLATFORM=generic

git clone https://git.u-boot-project.org/u-boot/u-boot.git u-boot.git
git -C u-boot.git remote add -f spacemit-com \
  https://github.com/spacemit-com/uboot-2022.10.git

git -C u-boot.git checkout origin/main # v2027.01-rc3 or later
make -C u-boot.git O=../u-boot spacemit_k3_defconfig
fw_dynbin=$(realpath opensbi/platform/generic/firmware/fw_dynamic.bin)
make -C u-boot.git O=../u-boot OPENSBI=$fw_dynbin

git -C u-boot.git checkout spacemit-com/k3-br-v1.0.y
# v1 "Guide to build reduced SpacemiT K3 vendor BSP"
pushd u-boot.git
b4 shazam -v1 \
  https://lore.kernel.org/u-boot/20261029001555.1890775-1-e@freeshell.de
popd
mki=$(realpath u-boot/tools/mkimage)
make -C u-boot.git O=../bsp-spi \
  spacemit_k3_uart_spi_defconfig
make -C u-boot.git O=../bsp-spi MKIMAGE=$mki \
  spl/u-boot-spl-mkimage.bin
make -C u-boot.git O=../bsp-nospi \
  spacemit_k3_uart_nospi_defconfig
make -C u-boot.git O=../bsp-nospi MKIMAGE=$mki \
  spl/u-boot-spl-mkimage.bin

tar -czf reduced-spacemit-k3-vendor-bsp.tar.gz \
  --transform 's~^~reduced-spacemit-k3-vendor-bsp/~' \
  bsp-nospi/spl/u-boot-spl-mkimage.bin \
  bsp-spi/spl/u-boot-spl-mkimage.bin \
  u-boot/u-boot.itb

[...]

-E
