Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DACC25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 10:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C78ED87FBC;
	Wed, 22 May 2024 12:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rsofRpLM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30986881C3; Wed, 22 May 2024 12:49:25 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F9C387F95
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 12:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1716374960; x=1716979760; i=xypron.glpk@gmx.de;
 bh=8+qPFpROYdFoniWHXKGbpSGlgIqxWc/kTe/kZO293wI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rsofRpLM0JmLg6nwshGkFa8FcJfUYxXr70tD7WIWnsraax8+N0RdJEcYW41V4aRI
 kBRkCXNOiaZoDWVOsxtWI7sE0qoe/a45yiDBfYKgIoWWwdcLyP3TI13/UmNZMRgOe
 MxUvmJJ1D+HZ2yL3g6YbNVkYDlCBL/LkT7hyZ8Kb02FrY+D7qH+M2hfWuYFeEo81e
 yF6HGEfhsMx0GrkyxLVgdo+3mWxblAjREKEk4JyVYgW81tG/dwy/EzVs9QsTNmPLZ
 8rPLxPodlCQVL4TbvI/5Py7TWezx56ZvRVKCeifqdId7Kf4NfK5Uqm5x6KO3vC3Tp
 PGyQpSevkGXhGF1aIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.169] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQvCv-1rveel2bSB-00P28q; Wed, 22
 May 2024 12:49:20 +0200
Message-ID: <d69ec20f-fd25-487f-b7f4-37944326023b@gmx.de>
Date: Wed, 22 May 2024 12:49:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v4] board: starfive: support Pine64 Star64 board
To: H Bell <dmoo_dv@protonmail.com>
References: <AQPxMmhcaeYN5rt7y4Jg392tXwS9syCQiDuYw33ZbtjOpANLCaGUAx9nP2YjKGSDSka8vM5BQkV9DepT_8Q0ipjQO18tbbk_gk8CgPFDnGI=@protonmail.com>
Content-Language: en-US
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <AQPxMmhcaeYN5rt7y4Jg392tXwS9syCQiDuYw33ZbtjOpANLCaGUAx9nP2YjKGSDSka8vM5BQkV9DepT_8Q0ipjQO18tbbk_gk8CgPFDnGI=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xKtW5CAGG/P2rNqhKB7jOB2sJUsUmLkJZ+vEVOwVeD8LEwSpIh3
 s87F8s6MCF0P548yJbfBp/zPC0PBFBEyQ4qr1u3vmKRluLyr1EJC3oTQZw5otxYICTl/iQR
 D4KpfAOCH6P81LZFuyReqPcH0u6JC1WIkeP18nCosa0i1b90WF7DPJPuzGEMZsCKeMUiSXv
 Fr4QdCBLKuyqTXLaQKMvQ==
UI-OutboundReport: notjunk:1;M01:P0:EBC/0na0vwI=;h8ZwPPtqkBO4qR3WwW84Mbn2Ux+
 GlLhCamY6aV96qWBEZsLr1Y6hTHdXmgPmVt/RTFJzpcIvT6wPcyXCtzLHtQojl5oBN1ZP1B16
 xaq49/bNXFd3GrchJxGIbm4OrmpIW5mjUb9ezizZ17nWDrvDDDXNiLuH/WdmcDq/7Wquvy1+g
 ZV/udNECYnrRaI9/KdDVQEVufukYBT4jrmaNhSVMC7Cx4CzmOWT8dWnOYXsOp00ktyJ4CmXO2
 8EyLOXykbXDUhx0DUjCdVBVOHnUAQVpxoKwKZvTG4RBYOKahjsAxDEKIvWOJENNErKA4sZxYb
 IO0/9/jy3/LFCT4oreW35fExIByZiub1RbothgUe1c2vE62X7WPtx6N1x8lLRbEbRFPaOd7lO
 2DnG/SAbJCD7dphslwjFTeXfpQVO0GTy3GPuAkTuj7a0ypqvAlUAumyuXS9a0bqWLNrWWHxgJ
 2mh9NWmBLRo6u/3EiYgmZ+wy3VCW9L6kwMwKmO2FAqDWix3WNO968BdgMVV1uxTB7nU4pdI5V
 dmSRKfgiCLqdbduJ7nvLl9zqQsTIOAQLhjJu3fx0jollhtptjv65X6Fze5FQCykwdGTif0xY1
 AMe9iZ3tqVGppuvDlSd+EY2kTrNl4A0IVZwkkXLH8iWarYfcrnPbrLlx+20RmYfbnmGrKkRCg
 fc+nsXfDhPdqTuDlGAy61bKeMYaF8Ci/vqpsRGEGPP1dfSnzaH7u1Jv3dyr+8V8rf9EPv6BH5
 PWX9Asc4KNBG7hr+mAyr4wWkbFx7Ze/5r3lX4zfLIigCMUpMAvbarcDo9usnDW2uQjbHERpnG
 jZch0GpzK6DhPOudsliSOZn7dTeLknquBjga+KX5ZlegI=
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

On 5/20/24 06:42, H Bell wrote:
> Add documentation files
>
> Signed-off-by: Henry Bell <dmoo_dv@protonmail.com>
> Cc: ycliang@andestech.com
> Cc: heinrich.schuchardt@canonical.com
> ---
>
> Changes since v1
>
> - New patch
>
> Changes since v2
>
> - Remove extra params to
> - Clarification on boot section
> - Add entry on MAC adresses and how to correct them
>
> Changes	since v3
>
> - Rebase against d678a59d2d
> ---
>   doc/board/starfive/index.rst         |   1 +
>   doc/board/starfive/pine64_star64.rst | 136 +++++++++++++++++++++++++++
>   2 files changed, 137 insertions(+)
>   create mode 100644 doc/board/starfive/pine64_star64.rst
>
> diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
> index d369b986cc..72ab6ddfbf 100644
> --- a/doc/board/starfive/index.rst
> +++ b/doc/board/starfive/index.rst
> @@ -8,4 +8,5 @@ StarFive
>
>      milk-v_mars
>      milk-v_mars_cm
> +   pine64_star64
>      visionfive2
> diff --git a/doc/board/starfive/pine64_star64.rst b/doc/board/starfive/p=
ine64_star64.rst
> new file mode 100644
> index 0000000000..567d1207ba
> --- /dev/null
> +++ b/doc/board/starfive/pine64_star64.rst
> @@ -0,0 +1,136 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Pine64 Star64
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This fails to build in our CI. The length of the underline does not
match the title.

Please, ensure that 'make htmldocs' throws no warnings.

Best regards

Heinrich

> +
> +U-Boot for the Star64 uses the same U-Boot binaries as the VisionFive 2=
 board.
> +In U-Boot SPL the actual board is detected and the device-tree patched
> +accordingly.
> +
> +Building
> +~~~~~~~~
> +
> +1. Add the RISC-V toolchain to your PATH.
> +2. Setup ARCH & cross compilation environment variable:
> +
> +.. code-block:: none
> +
> +   export CROSS_COMPILE=3D<riscv64 toolchain prefix>
> +
> +The M-mode software OpenSBI provides the supervisor binary interface (S=
BI) and
> +is responsible for the switch to S-Mode. It is a prerequisite to build =
U-Boot.
> +Support for the JH7110 was introduced in OpenSBI 1.2. It is recommended=
 to use
> +a current release.
> +
> +.. code-block:: console
> +
> +	git clone https://github.com/riscv/opensbi.git
> +	cd opensbi
> +	make PLATFORM=3Dgeneric FW_TEXT_START=3D0x40000000
> +
> +Now build the U-Boot SPL and U-Boot proper.
> +
> +.. code-block:: console
> +
> +	cd <U-Boot-dir>
> +	make starfive_visionfive2_defconfig
> +	make OPENSBI=3D$(opensbi_dir)/build/platform/generic/firmware/fw_dynam=
ic.bin
> +
> +This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out)=
 as well
> +as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
> +
> +Device-tree selection
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +U-Boot will set variable $fdtfile to starfive/jh7110-pine64-star64.dtb.
> +
> +To overrule this selection the variable can be set manually and saved i=
n the
> +environment
> +
> +::
> +
> +    setenv fdtfile my_device-tree.dtb
> +    env save
> +
> +or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to se=
t to
> +provide a default value.
> +
> +Boot source selection
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +The board provides the DIP switches (marked S1804) adjacent to the 40pi=
n GPIO
> +Bus for boot selection. The ``L`` (0) and ``H`` (1) silk screening to t=
he side
> +of the should be used to determine state (not the ``ON/ONKE`` markings
> +physically on the component). ``GPIO_0`` is channel 2 on the switch, wh=
ile
> +``GPIO_1`` is channel 1.
> +
> ++ (QSPI) Flash: 00 ``??``
> ++ SD: 01 ``??``
> ++ EMMC: 10 ``??``
> ++ UART: 11 ``??``
> +
> +Preparing the SD-Card
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +The device firmware loads U-Boot SPL (u-boot-spl.bin.normal.out) from t=
he
> +partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You are =
free
> +to choose any partition number.
> +
> +With the default configuration U-Boot SPL loads the U-Boot FIT image
> +(u-boot.itb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITI=
ON=3D0x2).
> +When formatting it is recommended to use GUID
> +BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
> +
> +The FIT image (u-boot.itb) is a combination of OpenSBI's fw_dynamic.bin=
,
> +u-boot-nodtb.bin and the device tree blob.
> +
> +Format the SD card (make sure the disk has GPT, otherwise use gdisk to =
switch)
> +
> +.. code-block:: bash
> +
> +	sudo sgdisk --clear \
> +	  --set-alignment=3D2 \
> +	  --new=3D1:4096:8191 --change-name=3D1:spl --typecode=3D1:2E54B353-12=
71-4842-806F-E436D6AF6985\
> +	  --new=3D2:8192:16383 --change-name=3D2:uboot --typecode=3D2:BC13C2FF=
-59E6-4262-A352-B275FD6F7172  \
> +	  --new=3D3:16384:1654784 --change-name=3D3:system --typecode=3D3:EBD0=
A0A2-B9E5-4433-87C0-68B6B72699C7 \
> +	  /dev/sdb
> +
> +Copy U-Boot to the SD card
> +
> +.. code-block:: bash
> +
> +	sudo dd if=3Du-boot-spl.bin.normal.out of=3D/dev/sdb1
> +	sudo dd if=3Du-boot.itb of=3D/dev/sdb2
> +
> +	sudo mount /dev/sdb3 /mnt/
> +	sudo cp u-boot-spl.bin.normal.out /mnt/
> +	sudo cp u-boot.itb /mnt/
> +	sudo cp Image.gz /mnt/
> +	sudo cp initramfs.cpio.gz /mnt/
> +	sudo cp jh7110-starfive-visionfive-2.dtb /mnt/
> +	sudo umount /mnt
> +
> +Booting
> +~~~~~~~
> +
> +Once you plugin the sdcard and power up, you should see the U-Boot prom=
pt.
> +
> +MAC address issues
> +~~~~~~~~~~~~~~~~~~
> +
> +The Star64 does not currently ship with unique serial numbers per-devic=
e.
> +Devices tested (all 4GiB RAM) have the same serial number of
> +``STAR64V1-2310-D004E000-00000005`` and the mac addresses of
> +``6c:cf:39:00:75:61`` (lower) and ``6c:cf:39:00:75:62`` (upper) port wi=
ll be
> +assigned. Shipped models also have the EEPROM set as write protected, s=
o it
> +cannot be changed using ``mac`` commands.
> +
> +The MAC addresses may be "set" as follows by writing as a custom config=
 to SPI
> +(Change the last 3 bytes of MAC addreses as appropriate):
> +
> +::
> +
> +	env set ethaddr 6c:cf:39:00:75:63
> +	env set eth1addr 6c:cf:39:00:75:64
> +	env save
> +	reset

