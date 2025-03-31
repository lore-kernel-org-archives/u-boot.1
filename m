Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAE9C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 22:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 640718171B;
	Tue,  1 Apr 2025 00:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MuiX7ggL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7730481879; Tue,  1 Apr 2025 00:49:28 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D400E80FDA
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 00:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72b82c8230aso1142276a34.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743461364; x=1744066164; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OrobOnl60uhqMBi47dj+cmDxcC8YC1GKwdDwlKDpFWE=;
 b=MuiX7ggLv/YQEreKw0Wj7jpQm6XV55lnEuLg3aRB4ewXC+aaAaEhe3iH1dC9APsWrY
 OtZKM8nyD/ctD1y2hoocytN0BbtrGjIv51eF7Q+m2QDY7EAWNstULmYZfqc7cDCIbexx
 ovSEF5rrVxsSjFS79i/SGFKoKvTtbjq3yICAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743461364; x=1744066164;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OrobOnl60uhqMBi47dj+cmDxcC8YC1GKwdDwlKDpFWE=;
 b=d+Gu9zf8hqqOqj+jpVaX8oYgtZHnsWZBfNT6EVjYb3BO8qzoA4hAnqTRMqm4Z4tKeR
 WcNNvbCX4p6AZWXYIiRVCOuguPE+Xl0ucPeZ33WxXoTnQiNK94q6kx8n4pk5ULD+ZWBh
 Q1SV0txzWusnHotHjLWF0s8avJ6WweJpvcwzYdZki3+Q+pZts52V/Z0Fcuja2ysZahCH
 eBZfyqaeoaZcgdWObC6CuqhH7IPUwFlUJSxd28tErwRMeEGRR1ZDaXA5xTvigzCZI55t
 yXsSKfRqOkX5I7tybWn4b9qIklu8KKYB0ki66M3/SYl9wVfqynvExk3/wDIHaAcHtcPs
 iIlw==
X-Gm-Message-State: AOJu0YxrGNS//kSmz7poZp48WJcwlemsyX02DLfKP2pByaiOsbhhbCS3
 Km76AjFKIgqcDqO6cX2oZ2o66UrNjIhQd43fHiS9lqq1Goxb8lCqJ0VUXiEruy8=
X-Gm-Gg: ASbGncsGxiGKHTpGxEtp3boQFCXOVyMEc9G9v5O9i3YQV3kFhspifsmHxn7Z4HiVNOY
 scCcj4KPHWJNnjrPJYTTGAQZGn9lYEfypyRVbR9+6n4NIOB4Cj3+I/eX/+zK1A9Ibivq1ro+QTm
 Y9a2ixoqJCtBIbdSucl3MttzE9k3XnpEV8Ook64S4ndvigQdZlhbGL78b1nromzbKH7IJuExROw
 NOXGbt58GXTZO4SJlwpuenlapFmEdB9z1b1PUZjneWoJAkWXenaEwDF34YKILxwttqdfmdHoAfG
 4hbSwJxRDZndAKRiwI5xWL380BKX8Oe908Gw4WQ+fQldlnRTE1YZDa8CyI1+jPk0rO2OUsBKCtM
 Vg0+dFw==
X-Google-Smtp-Source: AGHT+IH98Q147xnrgceEwobxpPKOe2buLqVEpbK484hc5Ur2GBkKQInXTwi0Rp9vLzhhApyw2G7AaA==
X-Received: by 2002:a05:6830:6c0f:b0:72a:1625:ef11 with SMTP id
 46e09a7af769-72c638322fdmr6744810a34.27.1743461364323; 
 Mon, 31 Mar 2025 15:49:24 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580ba906sm1637842a34.25.2025.03.31.15.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 15:49:23 -0700 (PDT)
Date: Mon, 31 Mar 2025 16:49:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lothar Rubusch <l.rubusch@gmail.com>,
 Olivier L'Heureux <olivier.lheureux@mind.be>,
 Yang Gang <yanggang@byosoft.com.cn>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: Pull request efi-next-20250104
Message-ID: <20250331224920.GA5495@bill-the-cat>
References: <5222dd9e-83f6-40ad-adc1-dc3fe1651991@gmx.de>
 <8510745.T7Z3S40VBb@diego>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6lRX5mjSbmW4IXJJ"
Content-Disposition: inline
In-Reply-To: <8510745.T7Z3S40VBb@diego>
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


--6lRX5mjSbmW4IXJJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 11:28:34PM +0200, Heiko St=FCbner wrote:
> Hi,
>=20
> Am Samstag, 4. Januar 2025, 04:19:40 MESZ schrieb Heinrich Schuchardt:
> > Dear Tom,
> >=20
> > The following changes since commit ec9263b4f15c4cf82eb6a211c67baa638506=
5b8e:
> >=20
> >    Fix neighbor discovery ethernet address saving (2025-01-01 14:40:04
> > -0600)
> >=20
> > are available in the Git repository at:
> >=20
> >    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> > tags/efi-next-20250104
> >=20
> > for you to fetch changes up to ce190e1b33b8c0e1228f4123759dfa1981c202de:
> >=20
> >    efi: Correct ECPT table GUID (2025-01-04 02:17:06 +0100)
> >=20
> > Gitlab CI reported no issues:
> > https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24075
> >=20
> > ----------------------------------------------------------------
> > Pull request efi-next-20250104
> >=20
> > Documentation:
> >=20
> > * doc: develop: Fix typos and wording in binman/binman.rst
> > * doc: develop: Fix typos and wording in gdb.rst
> > * doc: sandbox: Fix the "sb" command name
> > * doc/develop/distro.rst: Better document upstream definition of
> > extlinux.conf
> >=20
> > UEFI:
> >=20
> > With this pull request the UEFI sub-system detects all boot devices even
> > if they have not been probed before. If this adds to much boot delay
> > individual bootmeths and bootdevs can be disabled via the customizing.
> >=20
> > * efi_loader: avoid writing message in Exit() boot service
> > * efi_loader: run bootdev_hunt() to find ESP
> > * efi_loader: update EFI specification version
> > * cmd: efidebug: update output of memory attributes
> > * efi_loader: Don't warn if the TCG2 FinalEvents table is not installed
> > * cmd: bootmenu: add parameter -e for UEFI boot options
> > * efi_loader: Update startimage_exit self-test to check error
> > * efi: Correct ECPT table GUID
> >=20
> > Others:
> >=20
> > Building the API demo application for riscv64 is supported.
> >=20
> > * API: unify platform_sys_info() implementations
> > * examples: implement _start and syscall for RISC-V
> > * examples: use architecture specific memset() on RISC-V
> > * examples: use QEMU compatible LOAD_ADDR on RISC-V
> > * test: fix test_extension.py
> > * configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
> > * CI: xilinx_versal_virt: disable USB_DWC3
> > * net: eth_bootdev_hunt() should not run DHCP
> >=20
> > ----------------------------------------------------------------
> > Adriano Cordova (1):
> >        efi_loader: Expose efi_reinstall_protocol_interface in efi_loade=
r.h
> >=20
> > Aleksandar Gerasimovski (1):
> >        efi_loader: fix pe reloc pointer overrun
> >=20
> > Heinrich Schuchardt (13):
> >        API: unify platform_sys_info() implementations
> >        examples: implement _start and syscall for RISC-V
> >        examples: use architecture specific memset() on RISC-V
> >        examples: use QEMU compatible LOAD_ADDR on RISC-V
> >        efi_loader: avoid writing message in Exit() boot service
> >        test: fix test_extension.py
> >        configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
> >        CI: xilinx_versal_virt: disable USB_DWC3
>=20
>=20
> >        net: eth_bootdev_hunt() should not run DHCP
>=20
> this change seems to break the "normal" pxe boot from distroboot on
> (at least one, but probably all) Rockchip board(s).
>=20
> Up to u-boot 2025.01 distro-boot on Rockchip boards just worked
> normally, the network came up, dhcp ran (and provided the tftp-server
> address in my setup) and then "pxe" could retrieve the pxelinux.cfg/foo...
> file.
>=20
> Trying the same setup on 2025.04-rc5 does not work anymore, because
> that dhcp is never run, before pxe tries to get its file.
>=20
> Of course running the dhcp manually before handing over to distro-boot
> works, but that needs human interaction. Similarly reverting that patch
> also makes things works again ;-) .
>=20
>=20
> So while EFI might be faster now, pxe from distroboot is broken and I'm
> wondering, who is supposed to do the dhcp call now?

Well, it's not an intentional regression. I guess we need a revert for
today and a plan for tomorrow.

--=20
Tom

--6lRX5mjSbmW4IXJJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfrG+wACgkQFHw5/5Y0
tyzB4gwAq7IxnFejV11Mu//UXI7Xs6xZwLqYCDUw6TmmAWOsOBe9ztppu1/Gl7bZ
oOKNN5sZ6uoNNLgM3dtTgtQYayG7kRlghdxF3qnUojmLIA6UXXCgQgaFDk/ZjoEx
YMHYFWT0qfx75drnWHfrq5iA4HiZgevxQTx16I7AmN9054eKdQcXc+m48/c96Jx4
XdIjgKgc19LAlL9a8FtiARixxdGn/nbAOHKlh4IqZwpe69U7UGlWi00D11F+9gX4
P2Bvo4zI1C8rFkJ4x6KAlRv/qxvPVN/68+08aX5mhN4J7EX1C22FV77p80Wj0cGI
UDbeO5hVioxVjeuPFFpgisWrcye1uIwiyv2UKB6BmNZipthqPHyd8oNSEROYyhv9
E5u9Xr0fC+eGxPMFDHTSymuoua+IclJWB6AG3mvob81LSZzOH8uO4xbOa5/CNEc2
4nIvqFN5wtZwEduhn6MFhhTllOmwXaB0pWJUq0F2yY9RS2/5of46MP4ZevogYPXX
SdGhhTqu
=5LLK
-----END PGP SIGNATURE-----

--6lRX5mjSbmW4IXJJ--
