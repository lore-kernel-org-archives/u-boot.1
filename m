Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EA3C47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 17:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62CE08787C;
	Tue, 16 Jan 2024 18:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GtN0vA5i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6788877B0; Tue, 16 Jan 2024 18:25:35 +0100 (CET)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CBFB8787C
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 18:25:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso85053625ad.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 09:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705425931; x=1706030731;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oxmFGd341WpqQl0tFWSVQXKpO0yP3QQAwybrIR/PPgg=;
 b=GtN0vA5i17+WqLjlmVDxqOHdzPE4y0Jrzs9OQAIgvFSWNGbVLOnLnlepW3nsxrH+zq
 W2wXEzVx4G94yTmXC5bVkEPmPjyrqpf3OVsatJ65bxSy7dop/UjkiqZzZnRHdhU1q5kY
 5zjrRMDEGq908RQ/LMaZG7dLhOLZidAmcK1pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705425931; x=1706030731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oxmFGd341WpqQl0tFWSVQXKpO0yP3QQAwybrIR/PPgg=;
 b=d5klbIuXI1nX/L9EQiar4NRFWprI0aShHjQLoN+MqdEuwksWsb2SSfZfT7JHj7p5Q8
 EFetSvyIDZa8vFxokTKkL9Ich6hI4XECgjtj2YnLsubTT6pLRTzhKSeHax2V+oTO6FZf
 Bx7Qhw+OtX619Eg+63PaonidADtjeX74nXkVh4bxQJZHnCDyam8iGLG2WxvSAgNfXMBP
 CacYT54HSGVjD6rPB/YE7TsTsHwe1JF54bc6yCm05eS3gfprO6fHsJxjmjeQMZTOrHuC
 amsWMrhhEX1qLyHVv4ZF5LqWro2y91qkW1NnQOHx/CrRL0xeSoSJa8ybo0w1E9DtnpRA
 4poA==
X-Gm-Message-State: AOJu0YyMzhSZma8DOdipk3D26AghGdtfqEY1eQZLJCr7tcluO6Kr/kOQ
 873oZMVa6ZTJa6eCTF6MXuGyPAagmf9jWbFlOmqu2LJk+elL5n5kFGI=
X-Google-Smtp-Source: AGHT+IGEcWqaZzlUhniZ0lllm1NAtwzt/bDb4Y2GqhvgBOmmqsDxDw9pDBnx5oT9O+x0FIYCPVguFA==
X-Received: by 2002:a17:903:1112:b0:1d5:efc8:5374 with SMTP id
 n18-20020a170903111200b001d5efc85374mr1000949plh.27.1705425930697; 
 Tue, 16 Jan 2024 09:25:30 -0800 (PST)
Received: from pwmachine.localnet (mx-ll-171.4.233-91.dynamic.3bb.co.th.
 [171.4.233.91]) by smtp.gmail.com with ESMTPSA id
 b15-20020a170902d50f00b001d1cd7e4ad2sm9541673plg.125.2024.01.16.09.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 09:25:30 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v13 00/24] Modernize U-Boot shell
Date: Wed, 17 Jan 2024 00:25:26 +0700
Message-ID: <2170847.irdbgypaU6@pwmachine>
In-Reply-To: <ce968882-f30b-4f49-85cf-c38f78bb6ff8@foss.st.com>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
 <20240111170418.GA7220@francesco-nb>
 <ce968882-f30b-4f49-85cf-c38f78bb6ff8@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
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

Hi!


Le mardi 16 janvier 2024, 00:34:24 +07 Patrice CHOTARD a =E9crit :
> On 1/11/24 18:04, Francesco Dolcini wrote:
> > Hello Tom, Francis
> >=20
> > On Fri, Dec 29, 2023 at 07:55:37PM +0100, Francis Laniel wrote:
> >> Le jeudi 28 d=E9cembre 2023, 21:58:59 CET Tom Rini a =E9crit :
> >>> On Fri, 22 Dec 2023 22:02:20 +0100, Francis Laniel wrote:
> >>>> During 2021 summer, Sean Anderson wrote a contribution to add a new
> >>>> shell,
> >>>> based on LIL, to U-Boot [1, 2].
> >>>> While one of the goals of this contribution was to address the fact
> >>>> actual
> >>>> U-Boot shell, which is based on Busybox hush, is old there was a
> >>>> discussion
> >>>> about adding a new shell versus updating the actual one [3, 4].
> >>>>=20
> >>>> So, in this series, with Harald Seiler, we updated the actual U-Boot
> >>>> shell
> >>>> to reflect what is currently in Busybox source code.
> >>>> Basically, this contribution is about taking a snapshot of Busybox
> >>>> shell/hush.c file (as it exists in commit 37460f5da) and adapt it to
> >>>> suit
> >>>> U-Boot needs.
> >>>>=20
> >>>> [...]
> >>>=20
> >>> Applied to u-boot/next, thanks!
> >>=20
> >> Thank you for the merge!
> >> If there is any problem, do not hesitate to mail me and I will take ca=
re
> >> of
> >> it!
> >=20
> > This change, specifically setting the modern hush shell as default, is
> > breaking our boot script, just noticed since the current U-Boot master
> > has a regression for us.
> >=20
> > We still need to figure out the exact details, here [1] you can find the
> > boot script (that has some placeholder that is replaced during build).
> >=20
> > and the error is something like:
> >=20
> > ```
> > ## Executing script at 90280000
> > Loading DeviceTree: k3-am625-verdin-nonwifi-dev.dtb
> > 69025 bytes read in 11 ms (6 MiB/s)
> > 82 bytes read in 9 ms (8.8 KiB/s)
> > Working FDT set to 90200000
> > syntax error at 'done'HUSH died!
> > resetting ...
> > ```
> >=20
> > that I _assume_ comes from this line
> >=20
> >     env set set_apply_overlays 'env set apply_overlays "for overlay_file
> >     in \\${fdt_overlays}; do echo Applying Overlay: \\${overlay_file} &&
> >     ${load_cmd} \\${loadaddr} \\${overlays_prefix}\\${overlay_file} &&
> >     fdt apply \\${loadaddr}; env set overlay_file; done; true"'>=20
> > [1]
> > https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-b=
sp
> > /u-boot/u-boot-distro-boot/boot.cmd.in
> >=20
> > Francesco
>=20
> Hi all
>=20
> I observed a similar issue with STM32MP157c-DK2 board.
> Since commit 78912cfde281 ("cmd: Set modern hush as default shell") U-Boot
> crashes :
>=20
>=20
> U-Boot 2024.01-00486-g697758e7c81-dirty (Jan 15 2024 - 18:23:52 +0100)
>=20
> CPU: STM32MP157CAC Rev.B
> Model: STMicroelectronics STM32MP157C-DK2 Discovery Board
> Board: stm32mp1 in trusted mode (st,stm32mp157c-dk2)
> Board: MB1272 Var2.0 Rev.C-01
> DRAM:  512 MiB
> Clocks:
> - MPU : 650 MHz
> - MCU : 208.878 MHz
> - AXI : 266.500 MHz
> - PER : 24 MHz
> - DDR : 533 MHz
> optee optee: OP-TEE: revision 4.0 (e92de4ca)
> I/TC: Reserved shared memory is disabled
> I/TC: Dynamic shared memory is enabled
> I/TC: Normal World virtualization support is disabled
> I/TC: Asynchronous notifications are disabled
> Core:  311 devices, 40 uclasses, devicetree: board
> WDT:   Started watchdog@5a002000 with servicing every 1000ms (32s timeout)
> NAND:  0 MiB
> MMC:   STM32 SD/MMC: 0
> Loading Environment from MMC... OK
> In:    No input devices available!
> Out:   No output devices available!
> Err:   No error devices available!
> Net:   eth0: ethernet@5800a000
> Hit any key to stop autoboot:  0
> Boot over mmc0!
> switch to partitions #0, OK
> mmc0 is current device
> Scanning mmc 0:8...
> data abort
> pc : [<ddb3f77a>]          lr : [<ddb44c95>]
> reloc pc : [<c012777a>]    lr : [<c012cc95>]
> sp : dbafc848  ip : ddbfc578     fp : ddbedf18
> r10: 00000000  r9 : dbb15e70     r8 : 00000000
> r7 : dbb5bf98  r6 : dbb5de10     r5 : dbb5bf98  r4 : ddbeda78
> r3 : dbb5dc08  r2 : 000033f8     r1 : 00000071  r0 : ddbede00
> Flags: nzcv  IRQs off  FIQs off  Mode SVC_32 (T)
> Code: 3138 1c48 f854 0030 (eb04) 05c1
> Resetting CPU ...
>=20
>=20
> It crashes in blkcache_fill() , i didn't investigate deeply into this iss=
ue
> yet, but i can reproduce this issue by stopping autoboot by pressing a key
> and running a environment command as shown below :
>=20
> U-Boot 2024.01-00486-g697758e7c81-dirty (Jan 15 2024 - 18:23:52 +0100)
>=20
> CPU: STM32MP157CAC Rev.B
> Model: STMicroelectronics STM32MP157C-DK2 Discovery Board
> Board: stm32mp1 in trusted mode (st,stm32mp157c-dk2)
> Board: MB1272 Var2.0 Rev.C-01
> DRAM:  512 MiB
> Clocks:
> - MPU : 650 MHz
> - MCU : 208.878 MHz
> - AXI : 266.500 MHz
> - PER : 24 MHz
> - DDR : 533 MHz
> optee optee: OP-TEE: revision 4.0 (e92de4ca)
> I/TC: Reserved shared memory is disabled
> I/TC: Dynamic shared memory is enabled
> I/TC: Normal World virtualization support is disabled
> I/TC: Asynchronous notifications are disabled
> Core:  311 devices, 40 uclasses, devicetree: board
> WDT:   Started watchdog@5a002000 with servicing every 1000ms (32s timeout)
> NAND:  0 MiB
> MMC:   STM32 SD/MMC: 0
> Loading Environment from MMC... OK
> In:    No input devices available!
> Out:   No output devices available!
> Err:   No error devices available!
> Net:   eth0: ethernet@5800a000
> Hit any key to stop autoboot:  0
> STM32MP>
> STM32MP>
>=20
>=20
> Then i run "printenv" :
>=20
> STM32MP> printenv
> arch=3Darm
> autoload=3D0
> baudrate=3D115200
> board=3Dstm32mp1
> board_id=3D0x1272
> board_name=3Dstm32mp157c-dk2
> board_rev=3D0x000c
> boot_a_script=3Dload ${devtype} ${devnum}:${distro_bootpart} ${scriptaddr}
> ${prefix}${script}; source ${scriptaddr} boot_auth=3D0
> boot_device=3Dmmc
> boot_efi_binary=3Dload ${devtype} ${devnum}:${distro_bootpart}
> ${kernel_addr_r} efi/boot/bootarm.efi; if fdt addr -q ${fdt_addr_r}; then
> bootefi ${kernel_addr_r} ${fdt_i boot_efi_bootmgr=3Dif fdt addr -q
> ${fdt_addr_r}; then bootefi bootmgr ${fdt_addr_r};else bootefi bootmgr;fi
> boot_extlinux=3Dsysboot ${devtype} ${devnum}:${distro_bootpart} any
> ${scriptaddr} ${prefix}${boot_syslinux_conf} boot_instance=3D0
> boot_net_usb_start=3Dtrue
> boot_part=3D1
> boot_prefixes=3D/ /boot/
> boot_script_dhcp=3Dboot.scr.uimg
> boot_scripts=3Dboot.scr.uimg boot.scr
> boot_syslinux_conf=3Dextlinux/extlinux.conf
> boot_targets=3Dmmc1 ubifs0 mmc0 mmc2 usb0 pxe
> bootcmd=3Drun bootcmd_stm32mp
> bootcmd_mmc0=3Ddevnum=3D0; run mmc_boot
> bootcmd_mmc1=3Ddevnum=3D1; run mmc_boot
> bootcmd_mmc2=3Ddevnum=3D2; run mmc_boot
> bootcmd_pxe=3Drun boot_net_usb_start; dhcp; if pxe get; then pxe boot; fi
> bootcmd_stm32mp=3Decho "Boot over ${boot_device}${boot_instance}!";if test
> ${boot_device} =3D serial || test ${boot_device} =3D usb;then stm32prog
> ${boot_device} ${boot_ins; bootcmd_ubifs0=3Dbootubipart=3DUBI; bootubivol=
=3Dboot;
> bootubioff=3D; run ubifs_boot bootcmd_usb0=3Ddevnum=3D0; run usb_boot
> bootdelay=3D1
> console=3DttySTM0
> cpu=3Darmv7
> distro_bootcmd=3Dfor target in ${boot_targets}; do run bootcmd_${target};=
 done
> efi_dtb_prefixes=3D/ /dtb/ /dtb/current/
> env_check=3Dif env info -p -d -q; then env save; fi
> ethaddr=3D00:80:e1:42:48:f9
> fdt_addr_r=3D0xc4000000
> fdtcontroladdr=3Ddbafd730
> fdtfile=3Dstm32mp157c-dk2.dtb
> fdtoverlay_addr_r=3D0xc4300000
> kernel_addr_r=3D0xc2000000
> load_efi_dtb=3Dload ${devtype} ${devnum}:${distro_bootpart} ${fdt_addr_r}
> ${prefix}${efi_fdtfile} loadaddr=3D0xc2000000
> mmc_boot=3Dif mmc dev ${devnum}; then devtype=3Dmmc; run scan_dev_for_boo=
t_part;
> fi pxefile_addr_r=3D0xc4200000
> ramdisk_addr_r=3D0xc4400000
> scan_dev_for_boot=3Decho Scanning ${devtype} ${devnum}:${distro_bootpart}=
=2E..;
> for prefix in ${boot_prefixes}; do run scan_dev_for_extlinux; run
> scan_dev_for_scripts; do; scan_dev_for_boot_part=3Dpart list ${devtype}
> ${devnum} -bootable devplist; env exists devplist || setenv devplist 1; f=
or
> distro_bootpart in ${devplist}; do if fstype $t scan_dev_for_efi=3Dsetenv
> efi_fdtfile ${fdtfile}; if test -z "${fdtfile}" -a -n "${soc}"; then sete=
nv
> efi_fdtfile ${soc}-${board}${boardver}.dtb; fi; for prefix in ${efe
> scan_dev_for_extlinux=3Dif test -e ${devtype} ${devnum}:${distro_bootpart}
> ${prefix}${boot_syslinux_conf}; then echo Found
> ${prefix}${boot_syslinux_conf}; run boot_extli scan_dev_for_scripts=3Dfor
> script in ${boot_scripts}; do if test -e ${devtype}
> ${devnum}:${distro_bootpart} ${prefix}${script}; then echo Found U-Boot
> script ${prefix}$e scriptaddr=3D0xc4100000
> serial#=3D003700433338511634383330
> serverip=3D192.168.1.1
> soc=3Dstm32mp
> soc_pkg=3DAC
> soc_rev=3DB
> soc_type=3D157C
> splashimage=3D0xc2000000
> splashpos=3Dm,m
> ubifs_boot=3Dif ubi part ${bootubipart} ${bootubioff} && ubifsmount
> ubi0:${bootubivol}; then devtype=3Dubi; devnum=3Dubi0; bootfstype=3Dubifs;
> distro_bootpart=3D${bootubivol}; i usb_boot=3Dusb start; if usb dev ${dev=
num};
> then devtype=3Dusb; run scan_dev_for_boot_part; fi usb_pgood_delay=3D2000
> vendor=3Dst
>=20
> Environment size: 4321/8187 bytes
>=20
>=20
> and after i execute "run bootcmd_mmc0"
>=20
> STM32MP> run bootcmd_mmc0
> switch to partitions #0, OK
> mmc0 is current device
> Scanning mmc 0:8...
> data abort
> pc : [<ddb3f7a4>]          lr : [<ddb44c95>]
> reloc pc : [<c01277a4>]    lr : [<c012cc95>]
> sp : dbafcad8  ip : ddbfc578     fp : ddbedf18
> r10: 00000000  r9 : dbb15e70     r8 : 00000000
> r7 : dbb5f700  r6 : dbb615b8     r5 : dbb5f700  r4 : ddbeda78
> r3 : dbb613b0  r2 : 00005c50     r1 : 0000002e  r0 : 00005c51
> Flags: Nzcv  IRQs off  FIQs off  Mode SVC_32 (T)
> Code: 315b e7e9 2954 d802 (0b11) 316e
> Resetting CPU ...
>=20
> resetting ...
>=20

Again, sorry for the troubles caused...
With regard to crashing in blkcache_fill() I suspect this is because some i=
nput=20
data are wrong due to error in hush.
I am not really sure to understand how you reproduced it. Do you need to ru=
n=20
printenv before to generate the bug?
Also, can you please check the value of scan_dev_for_boot_part? I am wonder=
ing=20
if something is wrong with variable expansion and escaping character.

> Thanks
> Patrice


Best regards.


