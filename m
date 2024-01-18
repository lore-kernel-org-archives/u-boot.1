Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A11FC4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 14:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A245887B5F;
	Thu, 18 Jan 2024 15:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i1kOHPOK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A56487B8D; Thu, 18 Jan 2024 15:10:07 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84EFF87B5F
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 15:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-783137d8049so1102546185a.2
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 06:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705586998; x=1706191798; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E2cDU2wyjcHHgsH5qLraCW946iLMKJZQRLIvJWM8Cxo=;
 b=i1kOHPOKvzKdGGAe9CI2UaHwsP9qMNVO8yhdTcXpPRV5f02CFj7CEF4UafhZ7p8DBE
 YZKOk3hqjV9ZwTRUQv9Nvzbwr7sIrdTVyeBygvgcRi5XR34S+heKIsZVm4z4KbC3GeJH
 2a1HdjAp1med/68d9MAGolowcVCSkdfCTaTSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705586998; x=1706191798;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2cDU2wyjcHHgsH5qLraCW946iLMKJZQRLIvJWM8Cxo=;
 b=g8AsIzNOMiXjLUjz2L0XarJ/QB2nq0TCZCED/WhZ1lpZboo/wBnFUUjRRH9RSr973n
 oOM59QyePKwPZQmndWWleW5rUP/CiCOvB7BY5ADd4yYGaBx5QLdJWbyW/5cIsCtt5v+J
 Q1zhxXtq7/IMoiV777qKrEER+zftuKcKMQM2HfjynDzmlwUDGnZvByxcR543ItLEEIzI
 wrHCjBQlMk80JvdyXieVn0Ms3nVej5xU7CcL+uqYZuLHt2y1Js/X9KmbVRLgUkCFX/ir
 B5SYCpohDCeDorVVKAz67TOp7jiihMvZodWUqrjVJM6Ry0I3VZFMlVEllnTweFRd6+jS
 T8NA==
X-Gm-Message-State: AOJu0YzH+4K/dd0Jlt2+4zM+yCeLpKkz2eDJbWfLfTgT+eYi/w+DGDI2
 kQHCAHOhGo8Qy8tiqUHx+4Tve7nqCtYuhQvahlm8Tc5ND04FHP3IVA53mU6cfuM=
X-Google-Smtp-Source: AGHT+IEZO//yg5DnG+F0BUVtK7fnrwcs9di8vAjaqGPlDvE/I/Q5LdGZa4eA9xBoFurVYnOmjP5bZw==
X-Received: by 2002:ad4:5dcd:0:b0:681:22fd:4e66 with SMTP id
 m13-20020ad45dcd000000b0068122fd4e66mr1006739qvh.38.1705586998279; 
 Thu, 18 Jan 2024 06:09:58 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 b8-20020a0ce888000000b0067a2c201c95sm1452020qvo.51.2024.01.18.06.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:09:57 -0800 (PST)
Date: Thu, 18 Jan 2024 09:09:56 -0500
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Cc: u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v13 00/24] Modernize U-Boot shell
Message-ID: <20240118140956.GB12635@bill-the-cat>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
 <2170847.irdbgypaU6@pwmachine>
 <3033df6b-e9c2-41e7-a83e-4c3200268629@foss.st.com>
 <12363012.O9o76ZdvQC@pwmachine>
 <20240117173912.GA4046@francesco-nb>
 <f6e43c8e-9cc3-4edf-bef2-425092d9d43e@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WbmsNKeEueBJRIvz"
Content-Disposition: inline
In-Reply-To: <f6e43c8e-9cc3-4edf-bef2-425092d9d43e@foss.st.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--WbmsNKeEueBJRIvz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 08:05:15AM +0100, Patrice CHOTARD wrote:
>=20
>=20
> On 1/17/24 18:39, Francesco Dolcini wrote:
> > On Thu, Jan 18, 2024 at 12:30:42AM +0700, Francis Laniel wrote:
> >> Le mercredi 17 janvier 2024, 17:05:28 +07 Patrice CHOTARD a =E9crit :
> >>> On 1/16/24 18:25, Francis Laniel wrote:
> >>>> Le mardi 16 janvier 2024, 00:34:24 +07 Patrice CHOTARD a =E9crit :
> >>>>> On 1/11/24 18:04, Francesco Dolcini wrote:
> >>>>>> On Fri, Dec 29, 2023 at 07:55:37PM +0100, Francis Laniel wrote:
> >>>>>>> Le jeudi 28 d=E9cembre 2023, 21:58:59 CET Tom Rini a =E9crit :
> >>>>>>>> On Fri, 22 Dec 2023 22:02:20 +0100, Francis Laniel wrote:
> >>>>>>>>> During 2021 summer, Sean Anderson wrote a contribution to add a=
 new
> >>>>>>>>> shell,
> >>>>>>>>> based on LIL, to U-Boot [1, 2].
> >>>>>>>>> While one of the goals of this contribution was to address the =
fact
> >>>>>>>>> actual
> >>>>>>>>> U-Boot shell, which is based on Busybox hush, is old there was a
> >>>>>>>>> discussion
> >>>>>>>>> about adding a new shell versus updating the actual one [3, 4].
> >>>>>>>>>
> >>>>>>>>> So, in this series, with Harald Seiler, we updated the actual U=
-Boot
> >>>>>>>>> shell
> >>>>>>>>> to reflect what is currently in Busybox source code.
> >>>>>>>>> Basically, this contribution is about taking a snapshot of Busy=
box
> >>>>>>>>> shell/hush.c file (as it exists in commit 37460f5da) and adapt =
it to
> >>>>>>>>> suit
> >>>>>>>>> U-Boot needs.
> >>>>>>>>>
> >>>>>>>>> [...]
> >>>>>>>>
> >>>>>>>> Applied to u-boot/next, thanks!
> >>>>>>>
> >>>>>>> Thank you for the merge!
> >>>>>>> If there is any problem, do not hesitate to mail me and I will ta=
ke
> >>>>>>> care
> >>>>>>> of
> >>>>>>> it!
> >>>>>>
> >>>>>> This change, specifically setting the modern hush shell as default=
, is
> >>>>>> breaking our boot script, just noticed since the current U-Boot ma=
ster
> >>>>>> has a regression for us.
> >>>>>>
> >>>>>> We still need to figure out the exact details, here [1] you can fi=
nd the
> >>>>>> boot script (that has some placeholder that is replaced during bui=
ld).
> >>>>>>
> >>>>>> and the error is something like:
> >>>>>>
> >>>>>> ```
> >>>>>> ## Executing script at 90280000
> >>>>>> Loading DeviceTree: k3-am625-verdin-nonwifi-dev.dtb
> >>>>>> 69025 bytes read in 11 ms (6 MiB/s)
> >>>>>> 82 bytes read in 9 ms (8.8 KiB/s)
> >>>>>> Working FDT set to 90200000
> >>>>>> syntax error at 'done'HUSH died!
> >>>>>> resetting ...
> >>>>>> ```
> >>>>>>
> >>>>>> that I _assume_ comes from this line
> >>>>>>
> >>>>>>     env set set_apply_overlays 'env set apply_overlays "for overla=
y_file
> >>>>>>     in \\${fdt_overlays}; do echo Applying Overlay: \\${overlay_fi=
le} &&
> >>>>>>     ${load_cmd} \\${loadaddr} \\${overlays_prefix}\\${overlay_file=
} &&
> >>>>>>     fdt apply \\${loadaddr}; env set overlay_file; done; true"'>
> >>>>>>
> >>>>>> [1]
> >>>>>> https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/reci=
pes-bs
> >>>>>> p
> >>>>>> /u-boot/u-boot-distro-boot/boot.cmd.in
> >>>>>>
> >>>>>> Francesco
> >>>>>
> >>>>> Hi all
> >>>>>
> >>>>> I observed a similar issue with STM32MP157c-DK2 board.
> >>>>> Since commit 78912cfde281 ("cmd: Set modern hush as default shell")
> >>>>> U-Boot
> >>>>> crashes :
> >>>>>
> >>>>>
> >>>>> U-Boot 2024.01-00486-g697758e7c81-dirty (Jan 15 2024 - 18:23:52 +01=
00)
> >>>>>
> >>>>> CPU: STM32MP157CAC Rev.B
> >>>>> Model: STMicroelectronics STM32MP157C-DK2 Discovery Board
> >>>>> Board: stm32mp1 in trusted mode (st,stm32mp157c-dk2)
> >>>>> Board: MB1272 Var2.0 Rev.C-01
> >>>>> DRAM:  512 MiB
> >>>>> Clocks:
> >>>>> - MPU : 650 MHz
> >>>>> - MCU : 208.878 MHz
> >>>>> - AXI : 266.500 MHz
> >>>>> - PER : 24 MHz
> >>>>> - DDR : 533 MHz
> >>>>> optee optee: OP-TEE: revision 4.0 (e92de4ca)
> >>>>> I/TC: Reserved shared memory is disabled
> >>>>> I/TC: Dynamic shared memory is enabled
> >>>>> I/TC: Normal World virtualization support is disabled
> >>>>> I/TC: Asynchronous notifications are disabled
> >>>>> Core:  311 devices, 40 uclasses, devicetree: board
> >>>>> WDT:   Started watchdog@5a002000 with servicing every 1000ms (32s
> >>>>> timeout)
> >>>>> NAND:  0 MiB
> >>>>> MMC:   STM32 SD/MMC: 0
> >>>>> Loading Environment from MMC... OK
> >>>>> In:    No input devices available!
> >>>>> Out:   No output devices available!
> >>>>> Err:   No error devices available!
> >>>>> Net:   eth0: ethernet@5800a000
> >>>>> Hit any key to stop autoboot:  0
> >>>>> Boot over mmc0!
> >>>>> switch to partitions #0, OK
> >>>>> mmc0 is current device
> >>>>> Scanning mmc 0:8...
> >>>>> data abort
> >>>>> pc : [<ddb3f77a>]          lr : [<ddb44c95>]
> >>>>> reloc pc : [<c012777a>]    lr : [<c012cc95>]
> >>>>> sp : dbafc848  ip : ddbfc578     fp : ddbedf18
> >>>>> r10: 00000000  r9 : dbb15e70     r8 : 00000000
> >>>>> r7 : dbb5bf98  r6 : dbb5de10     r5 : dbb5bf98  r4 : ddbeda78
> >>>>> r3 : dbb5dc08  r2 : 000033f8     r1 : 00000071  r0 : ddbede00
> >>>>> Flags: nzcv  IRQs off  FIQs off  Mode SVC_32 (T)
> >>>>> Code: 3138 1c48 f854 0030 (eb04) 05c1
> >>>>> Resetting CPU ...
> >>
> >> I will take a look at the issue, trying to reproduce it and understand=
 the=20
> >> root cause.
> >> I cannot give you any ETA for the fix, so for now I can only advise yo=
u to=20
> >> stick with the old parser.
> >=20
> > Should we revert the change that set the modern hush shell as default
> > till this is fixed?
> >=20
> > This is preventing us to run our automated test suite against current
> > master. Whatever other issue might be introduced we will not be able to
> > report.
> >=20
> > Tom?
> >=20
> > Francesco
> >=20
> >=20
>=20
> Hi=20
>=20
> fully agree with Francesco's proposal.

OK, I'll revert the default change for the moment, hopefully we can get
this fixed soon however.

--=20
Tom

--WbmsNKeEueBJRIvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWpMTQACgkQFHw5/5Y0
tyxJnQv/R+ukuQz39iE3oniaJs9d5Pm823MCHE7vzm/DCyGgKV9dCXSfTg58rce3
CDnVm+HXoN1j7j5nyFav3q1RvAJW7TiOuGAVhlTwS14dx5vdAotJUzStXeOlPNP4
T3iMmWHJcNoMi3a8F3s7Wj1jMG02v7Sru5mKtvggYWYBUNX66Ch8fw3pxE5ZAvso
z1gLo/N9r+h7rIqJ51oNZsPSz9sS7Kif7YUOZqZMEl+5LZ5hNY4g0Gl4dwcFXO15
qBXoDa1IyHfD9axefHc/xUXN+Q68oi1KdeE+vuASjwFqECp/YaSeplTAGdgLsYt4
GwwnPmJEXSbiKpJTbubldTWU173B6RQJPufiw1GAwcxEgwxoyOckMfFidA76SvyE
TsjS38FSpXGEpSHejxKspB4fc7XoJnFqmtAwZWHoI7MHWNi8G/FHOfAH6Xvduz4U
dcnysYtgbz70FCMRaek4LWBEb1pkkTywjMrfoQKhbeZt4BgWENzbbB05cq5cvIYV
xxLcr89X
=EKv6
-----END PGP SIGNATURE-----

--WbmsNKeEueBJRIvz--
