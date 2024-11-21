Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD43D6ED11
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 11:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6836389669;
	Thu, 21 Nov 2024 12:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hiqYHrpu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 964B9894B7; Thu, 21 Nov 2024 12:53:47 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8AD28974B
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 12:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so57006566b.3
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 03:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732190024; x=1732794824; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ik2f/cN73D4Bn+UXEJSv+ELspoDEqERhinJUqd3cPI4=;
 b=hiqYHrpu/byPZGIiYXLhE4347HvbPn2WA8H8ea/W2kEQYayhY83nzms7zgAn99YPlj
 hBYtx/NvCgDER3r5nRUNWbQpbVtqjsFL44GtDgPEkOO7Fo3Mvv+ftCDZWFHal8LQZbWo
 GvigmC+wXiHBAklhGdTSbj7qTfuPkLW8gjtazX+Zrz/qc7nUCRt4qBu2TywiwtHdl8ZH
 q4UyrqkKEakiFYyiFGee5QypcivqrkfrQnO65Um0OYtsgJ4C7KEZqZWrCoU/UCSBbU1u
 DdKfYzPjjfnEIAVTeCsCJZAmAFrdL4DRqJWq7dfOqhQnaTkNL2sV78oCi2wkvT2x51Lf
 EiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732190024; x=1732794824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ik2f/cN73D4Bn+UXEJSv+ELspoDEqERhinJUqd3cPI4=;
 b=EzOxTRS7GS3tbphGMomPt/eyJ6Lun7V9X6Jqzyn0pW3RW+gjjrtCehV0TJuCeYN6a7
 FEZzsy832Kk1zfLHtdYvUpzwxWrGDbp1lWYC0BMm6ZW2Rtm/CwrljOTvURnMDTQBB2sE
 o9BOz2RQvAPiLC/I2W/CIWbE67mAhAbGP20uMEJAPS9ELHZ3dejUKpwisdbCU7/48skV
 craHK6hgNwrcX3GIOg++hdFse0fed66zmPMKKWCjL1oXktJ+JJ8VDskT8JZlrCC8J6u3
 9RoK70jMTt9RbUhg88SmcTDZEFJMcS+FAL/ey7E4PxltGcZx5U/ycaG/kwM5dYWFyEaX
 Mrgg==
X-Gm-Message-State: AOJu0YyaKqtF0jklmUniYBzuisyX8FsVMWQcWA5JN5fU0iznrW3sCAID
 mZRMy1pIzmCBCv4gWYbzkYY+C9toXJPNFA4ZT7SaWbpPFbURQK9hoWoLrnQoDCRdqw+99jFDjYs
 ZPKEm+Pg/oPdwwP4GfMPT5tR15cfeZckF1a6Y9g==
X-Google-Smtp-Source: AGHT+IHN/BObliUdY8yF8TuaEwdj6AMOrr44HEGfnkP8PrmRlSHNTVv9/tU+yGDujH3ef+c+q3D/Su/S8rEEU28a9yg=
X-Received: by 2002:a05:6402:358f:b0:5cf:abc9:2e59 with SMTP id
 4fb4d7f45d1cf-5cff4ae32f7mr5338252a12.1.1732190024107; Thu, 21 Nov 2024
 03:53:44 -0800 (PST)
MIME-Version: 1.0
References: <CANV2PTN5AbNpCu4TGhZ87q_Eyeemxxwu5m=QjwKVS967x8hbnQ@mail.gmail.com>
 <CADg8p94ohYfNLL8jbRA-hNd=fbg9PuVJvp0z-QYTeaGwHZ9q0Q@mail.gmail.com>
 <CANV2PTNdcc61CUTF9_zammmAugjVQOth=UFPiZv3=Qw_YX5RkA@mail.gmail.com>
 <CADg8p97RHvZG23fE8grvE5DzScT+okV-6qSHv_gQUiwggKDtJQ@mail.gmail.com>
 <CANV2PTP-17Z-MUa8-3mcAHduxzPqb6VN-ZKZS31XkwQ-2X1+8A@mail.gmail.com>
 <CADg8p97vUaELMimYc52bT6uVpqnLJWWfYPRJj=rJ6QDUcn8iEg@mail.gmail.com>
In-Reply-To: <CADg8p97vUaELMimYc52bT6uVpqnLJWWfYPRJj=rJ6QDUcn8iEg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 21 Nov 2024 17:23:32 +0530
Message-ID: <CADg8p97iVajMC8FwFsa1e+eFwTGgZwi2AWE9wcEg3K7W0wcRrw@mail.gmail.com>
Subject: Re: [BUG regression in HEAD] efi: memory: use the lmb API's for
 allocating and freeing memory
To: E Shattow <lucent@gmail.com>
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

On Thu, 21 Nov 2024 at 13:34, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Wed, 20 Nov 2024 at 13:49, E Shattow <lucent@gmail.com> wrote:
> >
> > Hi all, (on-list)
> >
> > On Tue, Nov 19, 2024 at 9:14=E2=80=AFPM Sughosh Ganu <sughosh.ganu@lina=
ro.org> wrote:
> > >
> > > On Wed, 20 Nov 2024 at 10:09, E Shattow <lucent@gmail.com> wrote:
> > > >
> > > > On Tue, Nov 19, 2024 at 6:42=E2=80=AFPM Sughosh Ganu <sughosh.ganu@=
linaro.org> wrote:
> > > > >
> > > > > On Wed, 20 Nov 2024 at 04:48, E Shattow <lucent@gmail.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > On HEAD some commits after v2024.10 I encounter a regression fo=
r
> > > > > > `bootefi bootmgr` fail with error "Not a PE-COFF file";  The fa=
ll-thru
> > > > > > case of global EFI boot is successful.
> > > > > >
> > > > > > Having run a git bisect I discover the first bad commit 22f2c9e=
d:
> > > > > >
> > > > > > $ git checkout -b master origin/master
> > > > > > branch 'master' set up to track 'origin/master'.
> > > > > > Switched to a new branch 'master'
> > > > > > $ git bisect start
> > > > > > status: waiting for both good and bad commits
> > > > > > $ git bisect bad HEAD
> > > > > > status: waiting for good commit(s), bad commit known
> > > > > > $ git bisect good v2024.10
> > > > > > Bisecting: 850 revisions left to test after this (roughly 10 st=
eps)
> > > > > > [82686e678e1587ddbd9570f82c58cdc3aecf2dbe] Merge branch 'stagin=
g' of
> > > > > > https://source.denx.de/u-boot/custodians/u-boot-tegra
> > > > > > $ git bisect good
> > > > > > Bisecting: 422 revisions left to test after this (roughly 9 ste=
ps)
> > > > > > [8963d433eb5d4a9f3a9def84e9c61a45c13e72bc] Merge tag
> > > > > > 'u-boot-rockchip-20241026' of
> > > > > > https://gitlab.denx.de/u-boot/custodians/u-boot-rockchip
> > > > > > $ git bisect bad
> > > > > > Bisecting: 214 revisions left to test after this (roughly 8 ste=
ps)
> > > > > > [0a504585d1cefeaf35ae8f860a5e5aa44dfffed5] arm: dts: k3-j722s-b=
inman:
> > > > > > Add support for HS-SE
> > > > > > $ git bisect bad
> > > > > > Bisecting: 106 revisions left to test after this (roughly 7 ste=
ps)
> > > > > > [88057dab2cde8710ccc95d12fb312184e0b023ca] mtd: spi-nor: Allow =
flashes
> > > > > > to specify MTD writesize
> > > > > > $ git bisect good
> > > > > > Bisecting: 53 revisions left to test after this (roughly 6 step=
s)
> > > > > > [625d40ab120dbc6f45dbd975857f8f87e422bd0f] test: boot: fix
> > > > > > bootflow_cmd_label for when DSA_SANDBOX is disabled
> > > > > > $ git bisect bad
> > > > > > Bisecting: 26 revisions left to test after this (roughly 5 step=
s)
> > > > > > [5b9261fb0b1ed087387f2036d279fd3f4bb20a61] Makefile: Drop
> > > > > > SPL_FIT_GENERATOR support
> > > > > > $ git bisect good
> > > > > > Bisecting: 13 revisions left to test after this (roughly 4 step=
s)
> > > > > > [e1b6822d6522d94d579d53092342b542d368a04b] efi_memory: do not a=
dd RAM
> > > > > > memory to the memory map
> > > > > > $ git bisect bad
> > > > > > Bisecting: 6 revisions left to test after this (roughly 3 steps=
)
> > > > > > [2f6191526a1325b6ddb59795a093eca69dbf8976] lmb: notify of any c=
hanges
> > > > > > to the LMB memory map
> > > > > > $ git bisect bad
> > > > > > Bisecting: 2 revisions left to test after this (roughly 2 steps=
)
> > > > > > [3c6896ad2fb876b0a23202f62a83c0d44380c9ea] lmb: add a flag to a=
llow
> > > > > > suppressing memory map change notification
> > > > > > $ git bisect good
> > > > > > Bisecting: 0 revisions left to test after this (roughly 1 step)
> > > > > > [22f2c9ed9f533a56bed09bd4e0e37852b6b9f3b1] efi: memory: use the=
 lmb
> > > > > > API's for allocating and freeing memory
> > > > > > $ git bisect bad
> > > > > > Bisecting: 0 revisions left to test after this (roughly 0 steps=
)
> > > > > > [eb052cbb896fee6f947765b44b0d80a54b19ce1a] lmb: add and reserve=
 memory
> > > > > > above ram_top
> > > > > > $ git bisect good
> > > > > > 22f2c9ed9f533a56bed09bd4e0e37852b6b9f3b1 is the first bad commi=
t
> > > > > >
> > > > > > A commit is good if Star64 boots and absent the error about "No=
t a
> > > > > > PE-COFF file" (duly confirmed by eficonfig to adjust boot order
> > > > > > allowing removable media of an OS installer image on SD Card to=
 be the
> > > > > > priority, verifying that the installer runs as expected).  A co=
mmit is
> > > > > > bad if U-Boot crashes and/or has the error "Not a PE-COFF file"=
.
> > > >
> > > > >
> > > > > Can you post the output of the following. Thanks.
> > > >
> > > > >
> > > > > 1) running the 'bdinfo' command
> > > >
> > > > U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:43 -080=
0)
> > > > ...
> > > > StarFive # bdinfo
> > > > boot_params =3D 0x0000000000000000
> > > > DRAM bank   =3D 0x0000000000000000
> > > > -> start    =3D 0x0000000040000000
> > > > -> size     =3D 0x0000000100000000
> > > > flashstart  =3D 0x0000000000000000
> > > > flashsize   =3D 0x0000000000000000
> > > > flashoffset =3D 0x0000000000000000
> > > > baudrate    =3D 115200 bps
> > > > relocaddr   =3D 0x00000000fff46000
> > > > reloc off   =3D 0x00000000bfd46000
> > > > Build       =3D 64-bit
> > > > current eth =3D ethernet@16030000
> > > > ethaddr     =3D 6c:cf:39:00:75:63
> > > > IP addr     =3D <NULL>
> > > > fdt_blob    =3D 0x00000000ff72da20
> > > > lmb_dump_all:
> > > >  memory.count =3D 0x1
> > > >  memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes flags: =
none
> > > >  reserved.count =3D 0x2
> > > >  reserved[0]    [0x40000000-0x4005ffff], 0x00060000 bytes flags: no=
-map
> > > >  reserved[1]    [0xfe729630-0xffffffff], 0x018d69d0 bytes flags: no=
-overwrite
> > > > devicetree  =3D board
> > > > serial addr =3D 0x0000000010000000
> > > >  width      =3D 0x0000000000000004
> > > >  shift      =3D 0x0000000000000002
> > > >  offset     =3D 0x0000000000000000
> > > >  clock      =3D 0x00000000016e3600
> > > > boot hart   =3D 0x0000000000000001
> > > > firmware fdt=3D 0x0000000042200000
> > > >
> > > > U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19:56:55 =
-0800)
> > > > ...
> > > > StarFive # bdinfo
> > > > boot_params =3D 0x0000000000000000
> > > > DRAM bank   =3D 0x0000000000000000
> > > > -> start    =3D 0x0000000040000000
> > > > -> size     =3D 0x0000000100000000
> > > > flashstart  =3D 0x0000000000000000
> > > > flashsize   =3D 0x0000000000000000
> > > > flashoffset =3D 0x0000000000000000
> > > > baudrate    =3D 115200 bps
> > > > relocaddr   =3D 0x00000000fff46000
> > > > reloc off   =3D 0x00000000bfd46000
> > > > Build       =3D 64-bit
> > > > current eth =3D ethernet@16030000
> > > > ethaddr     =3D 6c:cf:39:00:75:63
> > > > IP addr     =3D <NULL>
> > > > fdt_blob    =3D 0x00000000ff72da10
> > > > lmb_dump_all:
> > > >  memory.count =3D 0x1
> > > >  memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes, flags:=
 none
> > > >  reserved.count =3D 0x3
> > > >  reserved[0]    [0x40000000-0x4005ffff], 0x60000 bytes, flags: no-m=
ap
> > > >  reserved[1]    [0xfe72d620-0xffffffff], 0x18d29e0 bytes, flags: no=
-overwrite
> > > >  reserved[2]    [0x13fffb000-0x13fffffff], 0x5000 bytes, flags:
> > > > no-notify, no-overwrite
> > > > devicetree  =3D board
> > > > serial addr =3D 0x0000000010000000
> > > >  width      =3D 0x0000000000000004
> > > >  shift      =3D 0x0000000000000002
> > > >  offset     =3D 0x0000000000000000
> > > >  clock      =3D 0x00000000016e3600
> > > > boot hart   =3D 0x0000000000000001
> > > > firmware fdt=3D 0x0000000042200000
> > > >
> > > > Differences in bdinfo output between working (parent of the
> > > > regression) and non-working (origin/master) version:
> > > >
> > > > -fdt_blob    =3D 0x00000000ff72da20
> > > > +fdt_blob    =3D 0x00000000ff72da10
> > > >  lmb_dump_all:
> > > >   memory.count =3D 0x1
> > > > - memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes flags:=
 none
> > > > - reserved.count =3D 0x2
> > > > - reserved[0]    [0x40000000-0x4005ffff], 0x00060000 bytes flags: n=
o-map
> > > > - reserved[1]    [0xfe729630-0xffffffff], 0x018d69d0 bytes flags: n=
o-overwrite
> > > > + memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes, flags=
: none
> > > > + reserved.count =3D 0x3
> > > > + reserved[0]    [0x40000000-0x4005ffff], 0x60000 bytes, flags: no-=
map
> > > > + reserved[1]    [0xfe72d620-0xffffffff], 0x18d29e0 bytes, flags: n=
o-overwrite
> > > > + reserved[2]    [0x13fffb000-0x13fffffff], 0x5000 bytes, flags:
> > > > no-notify, no-overwrite
> > > >
> > > > >
> > > > > 2) do you get any errors when running the 'bootefi bootmgr' comma=
nd
> > > > > other than what you mention above
> > > > >
> > > >
> > > > U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:43 -080=
0)
> > > > ...
> > > > StarFive # bootefi bootmgr
> > > > Booting: mmc 0
> > > > error: no suitable video mode found.
> > > >
> > > > U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19:56:55 =
-0800)
> > > > ...
> > > > StarFive # bootefi bootmgr
> > > > Card did not respond to voltage select! : -110
> > > > Not a PE-COFF file
> > > > Loading Boot0000 'mmc 0' failed
> > > > Loading Boot0001 'nvme 0' failed
> > > > EFI boot manager: Cannot load any image
> > > >
> > > > > 3) What exactly do you mean by "global EFI boot is successful"
> > > > >
> > > >
> > > > I don't know what the correct name of it is. EFI can boot with what=
 I
> > > > am labeling as global EFI boot and searching for fixed path names (=
?),
> > > > or I guess it can decide from EFI variables what to do which I
> > > > consider to be the user-configured EFI boot. One of these (the
> > > > user-configured EFI boot) is broken since the regression.
> > > >
> > > > U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:43 -080=
0)
> > > > ...
> > > > Card did not respond to voltage select! : -110
> > > > Failed to load EFI variables
> > > > ** Booting bootflow '<NULL>' with efi_mgr
> > > > Booting: mmc 0
> > > > error: no suitable video mode found.
> > > >
> > > > U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19:56:55 =
-0800)
> > > > ...
> > > > Card did not respond to voltage select! : -110
> > > > Failed to load EFI variables
> > > > ** Booting bootflow '<NULL>' with efi_mgr
> > > > Not a PE-COFF file
> > > > Loading Boot0000 'mmc 0' failed
> > > > Loading Boot0001 'nvme 0' failed
> > > > EFI boot manager: Cannot load any image
> > > > Boot failed (err=3D-14)
> > > > ** Booting bootflow 'mmc@16010000.bootdev.part_1' with efi
> > > > Booting /\EFI\BOOT\BOOTRISCV64.EFI
> > > > error: no suitable video mode found.
> > >
> > > Based on the logs above, it seems like you are booting using the
> > > bootmeth efi_mgr? If so, can you try disabling the bootstd config. I
> > > might be wrong, but I remember some issues with the bootstd efi_mgr
> > > method on some other platform. Also, are you available on irc?
> > >
> > > -sughosh
> > >
> > > > > -sughosh
> > > > >
> > > > > >
> > > > > > For context, the Star64 eMMC contains here an installed Debian =
Linux
> > > > > > OS in the usual way with Grub2 EFI on the EFI System Partition =
there,
> > > > > > and that image boots fine from U-Boot v2024.10 also when loaded=
 into
> > > > > > memory and using 'bootefi' directly on that memory address.
> > > > > >
> > > >
> > > > Thanks,
> > > >
> > > > -E Shattow
> >
> > Confirming that some discussion about this happened off-list with a
> > positive result and now awaiting a fix.
>
> I tried to reproduce this issue on the qemu arm64 virt platform, with
> 4GB of DRAM memory starting from 0x4000_0000 - 0x1_4000_0000. This is
> the exact same memory map for DRAM memory as on your board. I also
> modified the value of ram_top to 4GB, as on your board. But I am
> unable to hit this on the qemu arm64 platform when I try to boot the
> Debian image with 'bootefi bootmgr' command. The only difference that
> I see is that on the qemu emulator, the OS is on a virtio disk, as
> against mmc in your case. So I think we should try to get to the root
> cause of this. I think you mentioned on irc yesterday that you observe
> this on two boards, so there is definitely something going on here.

Heinrich figured out that this is an issue with the mmc driver on
these platforms. So it looks like the mmc driver is unable to load any
data to addresses above 4GB. E Shattow confirmed this by trying to
load an image from the mmc to an address above 4GB with the 'load mmc'
command, which failed. Loading the same to an address below 4GB works.
I am unaware of the mmc controller IP, so why is the mmc driver not
able to access memory addresses above 4GB would have to be
investigated. Thanks.

-sughosh

>
> -sughosh
>
> >
> > Thanks very much!  -E
