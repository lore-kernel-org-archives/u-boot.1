Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CE9D6E2CF
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 08:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E4BA891E8;
	Wed, 20 Nov 2024 09:19:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CdjuV+ED";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B98089666; Wed, 20 Nov 2024 09:19:10 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE6FD88C0F
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 09:19:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2fb49510250so50012191fa.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 00:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732090747; x=1732695547; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WtVBcGvCBPZzLVLizXIMiWxIcRO/VS7KioK3Ew0h3fI=;
 b=CdjuV+EDqZ2FiHuq+RWazRgCgTRpnH6SasbNjhaz/Fu34H6DybRVuHXkySoVLd4JQK
 HqZlugpXBBhCs44Vche3kFVKTcY9tVOe6RnFcxKK0eRMB+nRIOfX6wD+uXC/jQtMx8RL
 My7xOjCLb+GtTiwIxBj2zC02IXxmBzbJxD49J6y275hkQxx9EpQp8xwNmbgf1zoTrUyz
 ZCqbRLZmBG4qTGuArMfrDiH4uaEqhRPDkF7m3K02kkwf/3ShPf9aIma/IDEc3abnjo3A
 8W+OiSIdhNKvrglhrJbF3Tdq/DYqV639PkSOQ5QLAV3/YxJuqU2ZE7dsJS7PZTEG8rpO
 ii/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732090747; x=1732695547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WtVBcGvCBPZzLVLizXIMiWxIcRO/VS7KioK3Ew0h3fI=;
 b=bnwOcPzEtjVztxZcl7cI+7Cw3wsFJGXL/AdJCTCPSrqxQcNHCOAtMUcKEpuvthURFK
 81wdZH4mXS8UarO3YXJ9o0CG4oPpQqO8pJoL87Ph/XceF1xhSDOGh82byGvx5Vt+whzi
 1KWW+jEu4rRlm1b/p2YFHhIO8wOhalUsYQ4S2YX+zpQBGcAs6IFpTPterQsddhPxLuTM
 Cmd/KyjZ2+ewLL5DPDJW344F9uORBlNJN1DXGaabUZd0D6N035Yb4WfBUrSOL7zhlXy4
 b0+7svbIAxXnYhRZUEsfbb6i0DtimGHsXan4WhvmeZsDH72YCL8maFF8IAvzJdZAxf7L
 Wsfw==
X-Gm-Message-State: AOJu0Yw67JS61EXKPIXCAp15u3Z5uJ+VhBB0046IX+UHfrwJQ6Qsc7QK
 TZSbi/XdUCgnfvsbBBtiyePBdnBPP2P4YzoZDurLWTE2oDz7B800u9gMip6P07uquhXgVDVvMtO
 0ArCGQotL1ugQgpXtW8YWaFAEYkM=
X-Google-Smtp-Source: AGHT+IF9aBD4YUiqI8PUTR7vL/dLyEtjThirmymQ5NX1ufGcRuVTad21zZmwK4MtuGLW26rGVYHWfrK26/CRnlLvqDM=
X-Received: by 2002:a05:651c:154c:b0:2fb:6027:7c0a with SMTP id
 38308e7fff4ca-2ff8db66029mr11665591fa.8.1732090746803; Wed, 20 Nov 2024
 00:19:06 -0800 (PST)
MIME-Version: 1.0
References: <CANV2PTN5AbNpCu4TGhZ87q_Eyeemxxwu5m=QjwKVS967x8hbnQ@mail.gmail.com>
 <CADg8p94ohYfNLL8jbRA-hNd=fbg9PuVJvp0z-QYTeaGwHZ9q0Q@mail.gmail.com>
 <CANV2PTNdcc61CUTF9_zammmAugjVQOth=UFPiZv3=Qw_YX5RkA@mail.gmail.com>
 <CADg8p97RHvZG23fE8grvE5DzScT+okV-6qSHv_gQUiwggKDtJQ@mail.gmail.com>
In-Reply-To: <CADg8p97RHvZG23fE8grvE5DzScT+okV-6qSHv_gQUiwggKDtJQ@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Wed, 20 Nov 2024 00:18:55 -0800
Message-ID: <CANV2PTP-17Z-MUa8-3mcAHduxzPqb6VN-ZKZS31XkwQ-2X1+8A@mail.gmail.com>
Subject: Re: [BUG regression in HEAD] efi: memory: use the lmb API's for
 allocating and freeing memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi all, (on-list)

On Tue, Nov 19, 2024 at 9:14=E2=80=AFPM Sughosh Ganu <sughosh.ganu@linaro.o=
rg> wrote:
>
> On Wed, 20 Nov 2024 at 10:09, E Shattow <lucent@gmail.com> wrote:
> >
> > On Tue, Nov 19, 2024 at 6:42=E2=80=AFPM Sughosh Ganu <sughosh.ganu@lina=
ro.org> wrote:
> > >
> > > On Wed, 20 Nov 2024 at 04:48, E Shattow <lucent@gmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > On HEAD some commits after v2024.10 I encounter a regression for
> > > > `bootefi bootmgr` fail with error "Not a PE-COFF file";  The fall-t=
hru
> > > > case of global EFI boot is successful.
> > > >
> > > > Having run a git bisect I discover the first bad commit 22f2c9ed:
> > > >
> > > > $ git checkout -b master origin/master
> > > > branch 'master' set up to track 'origin/master'.
> > > > Switched to a new branch 'master'
> > > > $ git bisect start
> > > > status: waiting for both good and bad commits
> > > > $ git bisect bad HEAD
> > > > status: waiting for good commit(s), bad commit known
> > > > $ git bisect good v2024.10
> > > > Bisecting: 850 revisions left to test after this (roughly 10 steps)
> > > > [82686e678e1587ddbd9570f82c58cdc3aecf2dbe] Merge branch 'staging' o=
f
> > > > https://source.denx.de/u-boot/custodians/u-boot-tegra
> > > > $ git bisect good
> > > > Bisecting: 422 revisions left to test after this (roughly 9 steps)
> > > > [8963d433eb5d4a9f3a9def84e9c61a45c13e72bc] Merge tag
> > > > 'u-boot-rockchip-20241026' of
> > > > https://gitlab.denx.de/u-boot/custodians/u-boot-rockchip
> > > > $ git bisect bad
> > > > Bisecting: 214 revisions left to test after this (roughly 8 steps)
> > > > [0a504585d1cefeaf35ae8f860a5e5aa44dfffed5] arm: dts: k3-j722s-binma=
n:
> > > > Add support for HS-SE
> > > > $ git bisect bad
> > > > Bisecting: 106 revisions left to test after this (roughly 7 steps)
> > > > [88057dab2cde8710ccc95d12fb312184e0b023ca] mtd: spi-nor: Allow flas=
hes
> > > > to specify MTD writesize
> > > > $ git bisect good
> > > > Bisecting: 53 revisions left to test after this (roughly 6 steps)
> > > > [625d40ab120dbc6f45dbd975857f8f87e422bd0f] test: boot: fix
> > > > bootflow_cmd_label for when DSA_SANDBOX is disabled
> > > > $ git bisect bad
> > > > Bisecting: 26 revisions left to test after this (roughly 5 steps)
> > > > [5b9261fb0b1ed087387f2036d279fd3f4bb20a61] Makefile: Drop
> > > > SPL_FIT_GENERATOR support
> > > > $ git bisect good
> > > > Bisecting: 13 revisions left to test after this (roughly 4 steps)
> > > > [e1b6822d6522d94d579d53092342b542d368a04b] efi_memory: do not add R=
AM
> > > > memory to the memory map
> > > > $ git bisect bad
> > > > Bisecting: 6 revisions left to test after this (roughly 3 steps)
> > > > [2f6191526a1325b6ddb59795a093eca69dbf8976] lmb: notify of any chang=
es
> > > > to the LMB memory map
> > > > $ git bisect bad
> > > > Bisecting: 2 revisions left to test after this (roughly 2 steps)
> > > > [3c6896ad2fb876b0a23202f62a83c0d44380c9ea] lmb: add a flag to allow
> > > > suppressing memory map change notification
> > > > $ git bisect good
> > > > Bisecting: 0 revisions left to test after this (roughly 1 step)
> > > > [22f2c9ed9f533a56bed09bd4e0e37852b6b9f3b1] efi: memory: use the lmb
> > > > API's for allocating and freeing memory
> > > > $ git bisect bad
> > > > Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > > > [eb052cbb896fee6f947765b44b0d80a54b19ce1a] lmb: add and reserve mem=
ory
> > > > above ram_top
> > > > $ git bisect good
> > > > 22f2c9ed9f533a56bed09bd4e0e37852b6b9f3b1 is the first bad commit
> > > >
> > > > A commit is good if Star64 boots and absent the error about "Not a
> > > > PE-COFF file" (duly confirmed by eficonfig to adjust boot order
> > > > allowing removable media of an OS installer image on SD Card to be =
the
> > > > priority, verifying that the installer runs as expected).  A commit=
 is
> > > > bad if U-Boot crashes and/or has the error "Not a PE-COFF file".
> >
> > >
> > > Can you post the output of the following. Thanks.
> >
> > >
> > > 1) running the 'bdinfo' command
> >
> > U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:43 -0800)
> > ...
> > StarFive # bdinfo
> > boot_params =3D 0x0000000000000000
> > DRAM bank   =3D 0x0000000000000000
> > -> start    =3D 0x0000000040000000
> > -> size     =3D 0x0000000100000000
> > flashstart  =3D 0x0000000000000000
> > flashsize   =3D 0x0000000000000000
> > flashoffset =3D 0x0000000000000000
> > baudrate    =3D 115200 bps
> > relocaddr   =3D 0x00000000fff46000
> > reloc off   =3D 0x00000000bfd46000
> > Build       =3D 64-bit
> > current eth =3D ethernet@16030000
> > ethaddr     =3D 6c:cf:39:00:75:63
> > IP addr     =3D <NULL>
> > fdt_blob    =3D 0x00000000ff72da20
> > lmb_dump_all:
> >  memory.count =3D 0x1
> >  memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes flags: none
> >  reserved.count =3D 0x2
> >  reserved[0]    [0x40000000-0x4005ffff], 0x00060000 bytes flags: no-map
> >  reserved[1]    [0xfe729630-0xffffffff], 0x018d69d0 bytes flags: no-ove=
rwrite
> > devicetree  =3D board
> > serial addr =3D 0x0000000010000000
> >  width      =3D 0x0000000000000004
> >  shift      =3D 0x0000000000000002
> >  offset     =3D 0x0000000000000000
> >  clock      =3D 0x00000000016e3600
> > boot hart   =3D 0x0000000000000001
> > firmware fdt=3D 0x0000000042200000
> >
> > U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19:56:55 -080=
0)
> > ...
> > StarFive # bdinfo
> > boot_params =3D 0x0000000000000000
> > DRAM bank   =3D 0x0000000000000000
> > -> start    =3D 0x0000000040000000
> > -> size     =3D 0x0000000100000000
> > flashstart  =3D 0x0000000000000000
> > flashsize   =3D 0x0000000000000000
> > flashoffset =3D 0x0000000000000000
> > baudrate    =3D 115200 bps
> > relocaddr   =3D 0x00000000fff46000
> > reloc off   =3D 0x00000000bfd46000
> > Build       =3D 64-bit
> > current eth =3D ethernet@16030000
> > ethaddr     =3D 6c:cf:39:00:75:63
> > IP addr     =3D <NULL>
> > fdt_blob    =3D 0x00000000ff72da10
> > lmb_dump_all:
> >  memory.count =3D 0x1
> >  memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes, flags: non=
e
> >  reserved.count =3D 0x3
> >  reserved[0]    [0x40000000-0x4005ffff], 0x60000 bytes, flags: no-map
> >  reserved[1]    [0xfe72d620-0xffffffff], 0x18d29e0 bytes, flags: no-ove=
rwrite
> >  reserved[2]    [0x13fffb000-0x13fffffff], 0x5000 bytes, flags:
> > no-notify, no-overwrite
> > devicetree  =3D board
> > serial addr =3D 0x0000000010000000
> >  width      =3D 0x0000000000000004
> >  shift      =3D 0x0000000000000002
> >  offset     =3D 0x0000000000000000
> >  clock      =3D 0x00000000016e3600
> > boot hart   =3D 0x0000000000000001
> > firmware fdt=3D 0x0000000042200000
> >
> > Differences in bdinfo output between working (parent of the
> > regression) and non-working (origin/master) version:
> >
> > -fdt_blob    =3D 0x00000000ff72da20
> > +fdt_blob    =3D 0x00000000ff72da10
> >  lmb_dump_all:
> >   memory.count =3D 0x1
> > - memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes flags: non=
e
> > - reserved.count =3D 0x2
> > - reserved[0]    [0x40000000-0x4005ffff], 0x00060000 bytes flags: no-ma=
p
> > - reserved[1]    [0xfe729630-0xffffffff], 0x018d69d0 bytes flags: no-ov=
erwrite
> > + memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes, flags: no=
ne
> > + reserved.count =3D 0x3
> > + reserved[0]    [0x40000000-0x4005ffff], 0x60000 bytes, flags: no-map
> > + reserved[1]    [0xfe72d620-0xffffffff], 0x18d29e0 bytes, flags: no-ov=
erwrite
> > + reserved[2]    [0x13fffb000-0x13fffffff], 0x5000 bytes, flags:
> > no-notify, no-overwrite
> >
> > >
> > > 2) do you get any errors when running the 'bootefi bootmgr' command
> > > other than what you mention above
> > >
> >
> > U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:43 -0800)
> > ...
> > StarFive # bootefi bootmgr
> > Booting: mmc 0
> > error: no suitable video mode found.
> >
> > U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19:56:55 -080=
0)
> > ...
> > StarFive # bootefi bootmgr
> > Card did not respond to voltage select! : -110
> > Not a PE-COFF file
> > Loading Boot0000 'mmc 0' failed
> > Loading Boot0001 'nvme 0' failed
> > EFI boot manager: Cannot load any image
> >
> > > 3) What exactly do you mean by "global EFI boot is successful"
> > >
> >
> > I don't know what the correct name of it is. EFI can boot with what I
> > am labeling as global EFI boot and searching for fixed path names (?),
> > or I guess it can decide from EFI variables what to do which I
> > consider to be the user-configured EFI boot. One of these (the
> > user-configured EFI boot) is broken since the regression.
> >
> > U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:43 -0800)
> > ...
> > Card did not respond to voltage select! : -110
> > Failed to load EFI variables
> > ** Booting bootflow '<NULL>' with efi_mgr
> > Booting: mmc 0
> > error: no suitable video mode found.
> >
> > U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19:56:55 -080=
0)
> > ...
> > Card did not respond to voltage select! : -110
> > Failed to load EFI variables
> > ** Booting bootflow '<NULL>' with efi_mgr
> > Not a PE-COFF file
> > Loading Boot0000 'mmc 0' failed
> > Loading Boot0001 'nvme 0' failed
> > EFI boot manager: Cannot load any image
> > Boot failed (err=3D-14)
> > ** Booting bootflow 'mmc@16010000.bootdev.part_1' with efi
> > Booting /\EFI\BOOT\BOOTRISCV64.EFI
> > error: no suitable video mode found.
>
> Based on the logs above, it seems like you are booting using the
> bootmeth efi_mgr? If so, can you try disabling the bootstd config. I
> might be wrong, but I remember some issues with the bootstd efi_mgr
> method on some other platform. Also, are you available on irc?
>
> -sughosh
>
> > > -sughosh
> > >
> > > >
> > > > For context, the Star64 eMMC contains here an installed Debian Linu=
x
> > > > OS in the usual way with Grub2 EFI on the EFI System Partition ther=
e,
> > > > and that image boots fine from U-Boot v2024.10 also when loaded int=
o
> > > > memory and using 'bootefi' directly on that memory address.
> > > >
> >
> > Thanks,
> >
> > -E Shattow

Confirming that some discussion about this happened off-list with a
positive result and now awaiting a fix.

Thanks very much!  -E
