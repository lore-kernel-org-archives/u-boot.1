Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED812606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s+9ybJTF;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=a1VkPPY/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C519A40852;
	Thu, 29 Oct 2026 00:33:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xp0GpKbhY3r8; Thu, 29 Oct 2026 00:33:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 737B540849
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793234036;
	b=c72IPQ4OXf6V9k2ToMa+BFSAxwy0+QA0Y1DsNoHd+KTPm7HJaXUeOEXs0AVdgM26feqK
	 YDnqFGRy42S0Au6OQ8mn2Vo85p4Aj5FxGhEac21tdK/LL4qUCUauGDdHiE/iWDFbEB5dB
	 HnFVsN5CGe7Ta6gqZE+/gcz1t+BVJGHbNwWg0d1WjIO3XAWlObpSkFwY+RKUYqfnL9Crf
	 aRJlQTJH9fs/9tEobHf3FR4ZVhJveqzG/lupZhiCcoAHTo8ydF+5TlIy7kFgZdv23C+fB
	 1cMh89ygmj7CVOEgSMVCLEnwXpdNc/p4pq3fPrVRTcFhnv7dXTUT0yPX1OkiozwjcLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793234036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x0skn8jwq+XWlWaZc7lSxTu3OrBZ7UuO3R/y9g4q1jQ=;
	b=M/gHTPm3Wxc5EL7wbLz43LDcnPYvMKev2vemNWuug0Tsq4V0QfOUyKB1HWZb2sa/4e8z
	 oeKoBAKkFHsdW+mzkn8bLRolD00kuzQexpdONYy7tOCXHN23tt9R96+GeoMdc+vwqyZTa
	 vudBe2ZPsTzOxHMP0mVk+362qEi1CC1uyAsUwFUxLvYcp6Et/JXFe98FcHBAP/9XrRrUV
	 GQGNhjNGB74YBvHnwxAoNKwqjahcoWwrTj2sHsI1Q/V5lr8CyOZCyOzU9vGOThkGtggvy
	 h5/BrggyjFuPcehLquQ4zc1ta9gSLI1IMSBN75WfjT8TyzlDGYTC9ExO0T59wy0sLTQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b="a1VkPPY/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793234036;
	bh=x0skn8jwq+XWlWaZc7lSxTu3OrBZ7UuO3R/y9g4q1jQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s+9ybJTFvRYoCPN1Y8QLCI86thLuLCeiM80wL14ylo0bDy1M/nM1G3KFP5JRx/oyM
	 bsrGubTzgrHsaz96g2pnIWfo4gT4pRQcWsCYyGuiXbHc7QRdjfFxTdk++ICGsHHcYJ
	 nTnYPfsbf/5eRQtbmupuARE/Bi+3p/iHJbQ8H6pHqreDSOzZXqL1azXhb7Ua2YHsJm
	 yXXf2f8WONxQuLHSbNrbNzoS5HkxyquQQQaQ5Yetm7UuQxeotA3OYnMSimqsi8Fox7
	 lp6hbSb4ztWV0QdXu7annYr94kYXtNXm8VvITNBygxGrlHa0AdhrKlaB+QarY999cN
	 EaMea8sPg8qpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 737B540849;
	Thu, 29 Oct 2026 00:33:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CC6062A8
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B13154084A
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:33:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id th5h72rKGbwO for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 00:33:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 66B3A40846
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793234033;
 b=juIDd8yWQ7TPQm/jVO1S/Ef1BaKu+ZHR2WCqTJR1FE2NzfwHBRNrQfNF759Tlv2DFmKe
 X0pdbGT79dI2wJYy819xP7tEQwmtOd3ZR3GXrj0IlyAziW0OSY91Fuuj96Sq+wHN3eue5
 o01BMzNr7+audOYXQB/5hELVVqZSzQGK1wTmsHDT2ILqXm+CtTohEi0116P5uguNjQ4cZ
 pdRJ6BbSeDgC48jQrBtZz+gCDkGA4TR0Co1zIJWVUIk6O9mzbsibxiM4H2Y14QIB+i/E8
 qOJtnRE1kx4J7FnjCwd9Z7amXCLc5jpi2rY3l7qSMNf2Nuwa4RmewLgmaFNBjNB/KIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793234033;
 h=Received-SPF:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=x0skn8jwq+XWlWaZc7lSxTu3OrBZ7UuO3R/y9g4q1jQ=;
 b=O5uOtgElEeFpBqg5wydKpiaT6nIwBSz1kflDvjBSEi5praXxRNjKvC8NdZecMT1v9ndj
 5NVpWyZ/6PtoTFBCOzZTAopXZXwMIXyXzdzfABKQYOgZ6GMp3yAHcPzpgGi4iC5jDLdVi
 FCr2zhPKhUYTNwjj5DI16rg8+HG9m2nBJlKdyBuu0QpE1LdOSobqgqVSA6dJAG8CN17UK
 OmiA2F8A0erKR8mvhWJYDababcKCMu5wYI14Y0DcWEkPfVaR7wpAkGeI38taeCSX/i/CT
 v/sB4nqAL/hyziGtW4s4fZ0Vc1nyJR+lbAa26GDwmBY+YylZ4q8N/FWKdLlhgO5/phg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b="a1VkPPY/"; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=a1VkPPY/
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66B3A40846
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793234028;
 bh=x0skn8jwq+XWlWaZc7lSxTu3OrBZ7UuO3R/y9g4q1jQ=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=a1VkPPY/rFisLlmWmLQfBQ9KStolUPK7lXruWr8gNNdip6/wFdcBHI6DBBhoZkVg2
 jstzOzqvbFGJVWfMOHKkP/Tn62RRh0H5WaxYW2qqDkLMPq1tqNbEAUObdfXDNRZxr0
 +WVT2VGQ1ugIYB/oFuggPXFFmzTKHgE6zkpBNUm0b0ImXj0dw6M8aCR2USc8zUBLU5
 KBMfhmMiK2jKWfTJYR3WEhBYPjJV1BLgO7zoXyHsMTFrMbi/NgDK3QPT2WQcA28ANQ
 RkmsUPZlqi6y9qqI/wX474PU6kvyJkcG9FtnymCjqYItlkMmViF5abE/uz3OTllVxG
 G57Vm7AEzaMjA==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id E0FCCB220B30
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 01:33:47 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org
Subject: [DNM v1 0/7] Guide to build reduced SpacemiT K3 vendor BSP (continued)
Date: Wed, 28 Oct 2026 17:33:27 -0700
Message-ID: <20261029003327.1890979-1-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029001555.1890775-1-e@freeshell.de>
References: <20261029001555.1890775-1-e@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Do Not Merge

Informational purpose only, to aid mainline development of SpacemiT K3
support.

...continued from https://lore.kernel.org/u-boot/20261029001555.1890775-1-e@freeshell.de/

What is known to be working from mainline?
- mkimage to post-process SPL into spl/u-boot-spl-mkimage.bin
- FIT U-Boot main app u-boot.itb
- dependency on OpenSBI

What do we need from the vendor BSP?
- SPL

(Optional) Additional hardware used?
- K3 Pico-ITX BootROM UART SPL loader mode selected by pull-up via
  FPC-36P reverse cable and adapter to header pins (2.54mm pitch
  DuPont connector).

The assumption in this guide is root user in a fresh Debian 13
Trixie build environment on amd64 architecture build host.

dpkg --add-architecture riscv64
apt install -y bison ca-certificates flex gcc-riscv64-linux-gnu git \
  libgnutls28-dev libpython3-dev libssl-dev python3-setuptools swig \
  curl
export CROSS_COMPILE=riscv64-linux-gnu-

git clone https://github.com/riscv-software-src/opensbi.git \
  opensbi.git
git -C opensbi.git checkout d28bc6f89837 # origin/master
# v6 "platform: generic: spacemit: add K3 platform support"
# https://patchwork.ozlabs.org/project/opensbi/list/?series=530305
curl https://patchwork.ozlabs.org/series/530305/mbox/ \
  | git -C opensbi.git am
make -C opensbi.git O=../opensbi clean
make -C opensbi.git O=../opensbi PLATFORM=generic

git clone https://git.u-boot-project.org/u-boot/u-boot.git u-boot.git
git -C u-boot.git remote add -f spacemit-com \
  https://github.com/spacemit-com/uboot-2022.10.git

git -C u-boot.git checkout 03e45557e1f3 # origin/main
# v1 "Spacemit K3 enable Linux boot"
# https://patchwork.ozlabs.org/project/uboot/list/?series=530384
curl https://patchwork.ozlabs.org/series/530384/mbox/ \
  | git -C u-boot.git am
make -C u-boot.git O=../u-boot spacemit_k3_defconfig
fw_dynbin=$(realpath opensbi/platform/generic/firmware/fw_dynamic.bin)
make -C u-boot.git O=../u-boot OPENSBI=$fw_dynbin

git -C u-boot.git checkout k3-br-v1.0.10 # spacemit-com/k3-br-v1.0.y
# v1 "Guide to build reduced SpacemiT K3 vendor BSP"
# https://patchwork.ozlabs.org/project/uboot/list/?series=530447
curl https://patchwork.ozlabs.org/series/530447/mbox/ \
  | git -C u-boot.git am
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

### K3 Pico-ITX BootROM UART SPL loader
Connect USB selection bias-pulldown pin 10 high to VCC1V8 pin 1 or
pin 2 for UART selection and pin 11 high to VCC1V8 selects BootROM
USB/UART download mode; pin 11 low is normal operation from selected
NOR/UFS/MMC/NAND secondary boot after SD card. If you do not have a
flat flex cable then it is possible with a sharp probe and steady
hands to do so, the easiest method apparently being to connect the
physically large VCC1V8 leg of the EEPROM part to probe FPC-36P pin 10
and depress the Firmware DownLoad button held for a moment while
pressing the reset or powering up the board. The reason for wanting to
activate BootROM UART mode is to avoid the use of Fastboot USB, and to
isolate any peripheral configuration that may have been acted upon by
BootROM which may be different between the available BootROM SPL
loader modes.

Visual reference:
https://web.archive.org/web/20261025124009/https://freeshell.de/e/riscv64/K3PicoITX-explainer_boot_resistors-20261017draft.webp

Connect for fastboot transfers the K3 Pico-ITX USB-C OTG port (not the
corner USB-C power input/display port) using USB-C to USB-A cable and
then to any USB-A port on the fastboot and serial terminal host.

Connect a serial UART cable, note the board TXD is adjacent to the PCB
board edge and opposite of that is GND with board RXD in the middle;
swap adapter TXD and adapter RXD as appropriate.

The vanilla vendor BSP assumes use of fastboot USB in FSBL.bin SPL for
main.itb loading. If the vanilla vendor BSP main.itb runs with pin 10
low (the board default) then it again attempts to load an SPL and this
can be escaped to a hush prompt by fastboot host 'fastboot continue'.

The UART variants of vendor BSP are patched to assume that u-boot.itb
is loaded over serial UART in YMODEM protocol. If activated the
BootROM UART loader assumes loading an SPL over serial UART in XMODEM
protocol. Using the 'tio' serial terminal software the keybind
sequences are (Control-t,x,0) for XMODEM and (Control-t,y) for YMODEM.
If you initiate a transfer and question-mark characters '?' appear
then the transfer has not synchronized correctly, so abort sending and
then re-try sending the transfer until you will see '.' progress marks
appear. The reduction in build config options for "bsp-spi" deletes
support for USB from SPL. The "bsp-nospi" has nearly all options
removed leaving only YMODEM loading, DRAM initialization, and
dependency of EEPROM TLV access for DRAM id.

Example boot 'mini.efi' netinst Debian debian-installer:
Power on or reset board with FDL button pressed (or pin 11 high)
  sys: 0x10001200
  bm:2
  usb_init : enter 3296,3072
  usb_core_init : enter 
  DWC3_GRXTHRCFG:0x4400000
  ROM: usb download handler
   rst
  done H
  setup= 0x1000680 0x400000,
   rst
  done H
  setup= 0x1a0500 0x0,
  setup= 0x1000680 0x120000,
  setup= 0x2000680 0x90000,
  setup= 0x2000680 0x200000,
  setup= 0x3000680 0xff0000,
  setup= 0x3020680 0xff0409,
  setup= 0x3010680 0xff0409,
  setup= 0x10900 0x0,
  usb_rx_bytes : start len[4096]
  setup= 0x3020680 0xff0409,
  setup= 0x3040680 0xff0409,
host$ fastboot stage bsp-nospi/spl/u-boot-spl-mkimage.bin
  fastboot_handle_command: max-download-size
  usb_tx_bytes : start len[14]
  usb_rx_bytes : start len[4096]
  fastboot_handle_command: 0003cd00
  Starting download of 249088 bytes
  usb_tx_bytes : start len[12]
  usb_rx_bytes : start len[249088]
  usb_tx_bytes : start len[4]
  usb_rx_bytes : start len[4096]
host$ fastboot continue
  fastboot_handle_command: continue
  usb_tx_bytes : start len[4]
  j...
  U-Boot SPL 2022.10-00007-g69c3d4b55f6 (Oct 28 2026 - 21:57:06 +0000)
  LPDDR5 total size: 32 GB, data rate: 6400 MT/s
  DDR training consume 5612ms
  Get cluster clk error
  CCC
host$ curl -LO \
 https://d-i.debian.org/daily-images/riscv64/daily/netboot/mini.efi
host$ python3 -m http.server 8000
(Control-t,y)
  [16:28:01.384] Send file with YMODEM
  [16:28:01.384] Enter file name:
u-boot/u-boot.itb
  [16:28:01.384] Enter file name: u-boot/u-boot.itb
  [16:28:01.384] Send file with YMODEM
  [16:28:12.766] Sending file 'u-boot/u-boot.itb'  
  [16:28:12.766] Press any key to abort transfer
  ...|
  [16:29:57.267] Done
  Loaded 1115321 bytes
  load failed: uboot=-1 esos=-1
  <debug_uart>
  clk_register: failed to get external_clk device (parent of espi_s...
  U-Boot 2027.01-rc1-00037-g96c9b2e9d606 (Oct 28 2026 - 21:54:22 +0...
  DRAM:  16 GiB
  clk_register: failed to get external_clk device (parent of espi_s...
  Core:  452 devices, 21 uclasses, devicetree: separate
  *** Warning - spi_flash_probe_bus_cs() failed, using default envi...
  In:    serial@d4017000
  Out:   serial@d4017000
  Err:   serial@d4017000
  Net:   
  Warning: ethernet@cac80000 (eth0) using random MAC address - 06:3...
  eth0: ethernet@cac80000
  Hit any key to stop autoboot: 2 1 0
(Control-c)
  =>
dhcp
  => dhcp
  ethernet@cac80000 Waiting for PHY auto negotiation to complete......
  DHCP client bound to address 192.168.2.81 (29 ms)
  error: no file name
=> 
wget http://host:8000/mini.efi
  ##################################################
  88906240 bytes transferred in 760 ms (111.6 MiB/s)
  Bytes transferred = 88906240 (54c9a00 hex)
bootefi $loadaddr

