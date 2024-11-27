Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95EAD6ACDC
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 14:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32421896FD;
	Wed, 27 Nov 2024 15:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AHbUhwVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8D4C897B5; Wed, 27 Nov 2024 15:11:30 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D358C89782
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 15:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f7657f9f62so74513381fa.3
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 06:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732716687; x=1733321487; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsOuB8wkTUpVC0ajUmPb+oHRAPA2XStWYyBjl2qPTEU=;
 b=AHbUhwVPm9BzckOddaWmO2ugXVr0dawNwqdRtjF6rimxg39cl2ENtwEmrJomGg/r7i
 9YNk1TlzdZ6qa9Vx5NA9oDYV6YUlLGr6TOZdMm57okxwp3NaQG2qJw2gddxel/lSrCbT
 3DKsEVgdoeNVY82XzHhzSKaLepiU3Awc5H0kO4SAqa/nwdUoIefM/g4nAOdfpJic27Rc
 zsEAJx5A38fFVLsdE5FxJlaWKek2A9Hbr2tNFfMWLO8IcF+vWrNOwelqrTVCY31dXrzi
 A7WKHGMg4DRDMrhY+8RKwUw1HRb8JUu5uKn/mtjeMJrWNVVPGJmcDA8mZ1Sr/U8LXPWS
 jTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732716687; x=1733321487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsOuB8wkTUpVC0ajUmPb+oHRAPA2XStWYyBjl2qPTEU=;
 b=bhB8UQ96tdpb5zrum1IMp739DmvTwF6NERhifZTLkhpIfOPA8K4c0BpbMaD2htxF93
 6nuch+l7Cy9hGd9fZcU7qLkdR08ypzzme+5BU9v36beXf8U+Rs0onmFRw7zX+OIfVGyO
 c6p7CCXGtEUxVTRQiAj6yJVAcb+59PxGYuHxdBHIXb37AV+3vjS2FaxyS5uczwSOg9WX
 Yptqfo9XUPnlAfnwNw6ZdHI1APkjxy7ZefFkBbBVnAlZeJS2KfT4xQ8gj0cEaBf+8H+B
 NGjm9ilKmvaGIeASf3AdyO2FLoGqy/U/4obNb3mBDYUkKVN9/TGEDF4/98m9Vxv4ejWq
 i3IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAwSrx2BveWGws7cB2s7JLjXxlR2KmId76zg9W/wGMbRH25Aocy2LHo4g4jEi5Lc4c4g1n7EY=@lists.denx.de
X-Gm-Message-State: AOJu0YyOliLE69DvZPd16tKSnC265UzAoarO3GWhhW56Sp+R4hAQudlX
 rMFGgIt9eSgvmCGbAc0cXTDLAwyzX8+zsgyg6G/XVM6TPR8vIGLITxeBhj2+2blDVhQ02I4dghS
 wNwSW0W5CpUnS5OjbmgqWKE4QgaY=
X-Gm-Gg: ASbGnctpZduO3AiJnGwY3+J1/uJ/r1HWzgREpDJgwqMmC4OcaGpHp/tPq2z9CCttWlD
 ReEmqhYwoHP2zNeqYW1BBx6eqgzmnj/NQVEunT6IjeWaKBJIBdZNgb+0bw1BqyqWj+A==
X-Google-Smtp-Source: AGHT+IEQx8gt3pnv3wlM9jCD2+umSGLpLizT1tJi7+gP/JuhgbqCZcQ4vbtAEhIQWh5P3vbLGWnhg7j88PxNdW19L6s=
X-Received: by 2002:a2e:9a11:0:b0:2fb:5014:c963 with SMTP id
 38308e7fff4ca-2ffd606ef2cmr17104071fa.20.1732716686605; Wed, 27 Nov 2024
 06:11:26 -0800 (PST)
MIME-Version: 1.0
References: <CANV2PTN5AbNpCu4TGhZ87q_Eyeemxxwu5m=QjwKVS967x8hbnQ@mail.gmail.com>
 <CADg8p94ohYfNLL8jbRA-hNd=fbg9PuVJvp0z-QYTeaGwHZ9q0Q@mail.gmail.com>
 <CANV2PTNdcc61CUTF9_zammmAugjVQOth=UFPiZv3=Qw_YX5RkA@mail.gmail.com>
 <CADg8p97RHvZG23fE8grvE5DzScT+okV-6qSHv_gQUiwggKDtJQ@mail.gmail.com>
 <CANV2PTP-17Z-MUa8-3mcAHduxzPqb6VN-ZKZS31XkwQ-2X1+8A@mail.gmail.com>
 <CADg8p97vUaELMimYc52bT6uVpqnLJWWfYPRJj=rJ6QDUcn8iEg@mail.gmail.com>
 <b3279988-ddda-423f-8caf-3fa5e4192fcb@gmx.de>
 <CANV2PTM55_Fb4_=0sGoZ1XQo89X9_UdH3tNWp=ZcT0KSY9o+kA@mail.gmail.com>
In-Reply-To: <CANV2PTM55_Fb4_=0sGoZ1XQo89X9_UdH3tNWp=ZcT0KSY9o+kA@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Wed, 27 Nov 2024 06:11:15 -0800
Message-ID: <CANV2PTNmj4nxShO3tspheDSXohw212yj0unJtzokLHPxoOch0g@mail.gmail.com>
Subject: Re: [BUG regression in HEAD] efi: memory: use the lmb API's for
 allocating and freeing memory
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Replying my own message postscript

On Wed, Nov 27, 2024 at 4:47=E2=80=AFAM E Shattow <lucent@gmail.com> wrote:
>
> Following up on this with some positive results:
>
> On Thu, Nov 21, 2024 at 4:22=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@=
gmx.de> wrote:
> >
> > On 21.11.24 09:04, Sughosh Ganu wrote:
> > > On Wed, 20 Nov 2024 at 13:49, E Shattow <lucent@gmail.com> wrote:
> > >>
> > >> Hi all, (on-list)
> > >>
> > >> On Tue, Nov 19, 2024 at 9:14=E2=80=AFPM Sughosh Ganu <sughosh.ganu@l=
inaro.org> wrote:
> > >>>
> > >>> On Wed, 20 Nov 2024 at 10:09, E Shattow <lucent@gmail.com> wrote:
> > >>>>
> > >>>> On Tue, Nov 19, 2024 at 6:42=E2=80=AFPM Sughosh Ganu <sughosh.ganu=
@linaro.org> wrote:
> > >>>>>
> > >>>>> On Wed, 20 Nov 2024 at 04:48, E Shattow <lucent@gmail.com> wrote:
> > >>>>>>
> > >>>>>> Hello,
> > >>>>>>
> > >>>>>> On HEAD some commits after v2024.10 I encounter a regression for
> > >>>>>> `bootefi bootmgr` fail with error "Not a PE-COFF file";  The fal=
l-thru
> > >>>>>> case of global EFI boot is successful.
> > >>>>>>
> > >>>>>> Having run a git bisect I discover the first bad commit 22f2c9ed=
:
> > >>>>>>
> > >>>>>> $ git checkout -b master origin/master
> > >>>>>> branch 'master' set up to track 'origin/master'.
> > >>>>>> Switched to a new branch 'master'
> > >>>>>> $ git bisect start
> > >>>>>> status: waiting for both good and bad commits
> > >>>>>> $ git bisect bad HEAD
> > >>>>>> status: waiting for good commit(s), bad commit known
> > >>>>>> $ git bisect good v2024.10
> > >>>>>> Bisecting: 850 revisions left to test after this (roughly 10 ste=
ps)
> > >>>>>> [82686e678e1587ddbd9570f82c58cdc3aecf2dbe] Merge branch 'staging=
' of
> > >>>>>> https://source.denx.de/u-boot/custodians/u-boot-tegra
> > >>>>>> $ git bisect good
> > >>>>>> Bisecting: 422 revisions left to test after this (roughly 9 step=
s)
> > >>>>>> [8963d433eb5d4a9f3a9def84e9c61a45c13e72bc] Merge tag
> > >>>>>> 'u-boot-rockchip-20241026' of
> > >>>>>> https://gitlab.denx.de/u-boot/custodians/u-boot-rockchip
> > >>>>>> $ git bisect bad
> > >>>>>> Bisecting: 214 revisions left to test after this (roughly 8 step=
s)
> > >>>>>> [0a504585d1cefeaf35ae8f860a5e5aa44dfffed5] arm: dts: k3-j722s-bi=
nman:
> > >>>>>> Add support for HS-SE
> > >>>>>> $ git bisect bad
> > >>>>>> Bisecting: 106 revisions left to test after this (roughly 7 step=
s)
> > >>>>>> [88057dab2cde8710ccc95d12fb312184e0b023ca] mtd: spi-nor: Allow f=
lashes
> > >>>>>> to specify MTD writesize
> > >>>>>> $ git bisect good
> > >>>>>> Bisecting: 53 revisions left to test after this (roughly 6 steps=
)
> > >>>>>> [625d40ab120dbc6f45dbd975857f8f87e422bd0f] test: boot: fix
> > >>>>>> bootflow_cmd_label for when DSA_SANDBOX is disabled
> > >>>>>> $ git bisect bad
> > >>>>>> Bisecting: 26 revisions left to test after this (roughly 5 steps=
)
> > >>>>>> [5b9261fb0b1ed087387f2036d279fd3f4bb20a61] Makefile: Drop
> > >>>>>> SPL_FIT_GENERATOR support
> > >>>>>> $ git bisect good
> > >>>>>> Bisecting: 13 revisions left to test after this (roughly 4 steps=
)
> > >>>>>> [e1b6822d6522d94d579d53092342b542d368a04b] efi_memory: do not ad=
d RAM
> > >>>>>> memory to the memory map
> > >>>>>> $ git bisect bad
> > >>>>>> Bisecting: 6 revisions left to test after this (roughly 3 steps)
> > >>>>>> [2f6191526a1325b6ddb59795a093eca69dbf8976] lmb: notify of any ch=
anges
> > >>>>>> to the LMB memory map
> > >>>>>> $ git bisect bad
> > >>>>>> Bisecting: 2 revisions left to test after this (roughly 2 steps)
> > >>>>>> [3c6896ad2fb876b0a23202f62a83c0d44380c9ea] lmb: add a flag to al=
low
> > >>>>>> suppressing memory map change notification
> > >>>>>> $ git bisect good
> > >>>>>> Bisecting: 0 revisions left to test after this (roughly 1 step)
> > >>>>>> [22f2c9ed9f533a56bed09bd4e0e37852b6b9f3b1] efi: memory: use the =
lmb
> > >>>>>> API's for allocating and freeing memory
> > >>>>>> $ git bisect bad
> > >>>>>> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > >>>>>> [eb052cbb896fee6f947765b44b0d80a54b19ce1a] lmb: add and reserve =
memory
> > >>>>>> above ram_top
> > >>>>>> $ git bisect good
> > >>>>>> 22f2c9ed9f533a56bed09bd4e0e37852b6b9f3b1 is the first bad commit
> > >>>>>>
> > >>>>>> A commit is good if Star64 boots and absent the error about "Not=
 a
> > >>>>>> PE-COFF file" (duly confirmed by eficonfig to adjust boot order
> > >>>>>> allowing removable media of an OS installer image on SD Card to =
be the
> > >>>>>> priority, verifying that the installer runs as expected).  A com=
mit is
> > >>>>>> bad if U-Boot crashes and/or has the error "Not a PE-COFF file".
> > >>>>
> > >>>>>
> > >>>>> Can you post the output of the following. Thanks.
> > >>>>
> > >>>>>
> > >>>>> 1) running the 'bdinfo' command
> > >>>>
> > >>>> U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:43 -08=
00)
> > >>>> ...
> > >>>> StarFive # bdinfo
> > >>>> boot_params =3D 0x0000000000000000
> > >>>> DRAM bank   =3D 0x0000000000000000
> > >>>> -> start    =3D 0x0000000040000000
> > >>>> -> size     =3D 0x0000000100000000
> > >>>> flashstart  =3D 0x0000000000000000
> > >>>> flashsize   =3D 0x0000000000000000
> > >>>> flashoffset =3D 0x0000000000000000
> > >>>> baudrate    =3D 115200 bps
> > >>>> relocaddr   =3D 0x00000000fff46000
> > >>>> reloc off   =3D 0x00000000bfd46000
> > >>>> Build       =3D 64-bit
> > >>>> current eth =3D ethernet@16030000
> > >>>> ethaddr     =3D 6c:cf:39:00:75:63
> > >>>> IP addr     =3D <NULL>
> > >>>> fdt_blob    =3D 0x00000000ff72da20
> > >>>> lmb_dump_all:
> > >>>>   memory.count =3D 0x1
> > >>>>   memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes flags=
: none
> > >>>>   reserved.count =3D 0x2
> > >>>>   reserved[0]    [0x40000000-0x4005ffff], 0x00060000 bytes flags: =
no-map
> > >>>>   reserved[1]    [0xfe729630-0xffffffff], 0x018d69d0 bytes flags: =
no-overwrite
> > >>>> devicetree  =3D board
> > >>>> serial addr =3D 0x0000000010000000
> > >>>>   width      =3D 0x0000000000000004
> > >>>>   shift      =3D 0x0000000000000002
> > >>>>   offset     =3D 0x0000000000000000
> > >>>>   clock      =3D 0x00000000016e3600
> > >>>> boot hart   =3D 0x0000000000000001
> > >>>> firmware fdt=3D 0x0000000042200000
> > >>>>
> > >>>> U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19:56:55=
 -0800)
> > >>>> ...
> > >>>> StarFive # bdinfo
> > >>>> boot_params =3D 0x0000000000000000
> > >>>> DRAM bank   =3D 0x0000000000000000
> > >>>> -> start    =3D 0x0000000040000000
> > >>>> -> size     =3D 0x0000000100000000
> > >>>> flashstart  =3D 0x0000000000000000
> > >>>> flashsize   =3D 0x0000000000000000
> > >>>> flashoffset =3D 0x0000000000000000
> > >>>> baudrate    =3D 115200 bps
> > >>>> relocaddr   =3D 0x00000000fff46000
> > >>>> reloc off   =3D 0x00000000bfd46000
> > >>>> Build       =3D 64-bit
> > >>>> current eth =3D ethernet@16030000
> > >>>> ethaddr     =3D 6c:cf:39:00:75:63
> > >>>> IP addr     =3D <NULL>
> > >>>> fdt_blob    =3D 0x00000000ff72da10
> > >>>> lmb_dump_all:
> > >>>>   memory.count =3D 0x1
> > >>>>   memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes, flag=
s: none
> > >>>>   reserved.count =3D 0x3
> > >>>>   reserved[0]    [0x40000000-0x4005ffff], 0x60000 bytes, flags: no=
-map
> > >>>>   reserved[1]    [0xfe72d620-0xffffffff], 0x18d29e0 bytes, flags: =
no-overwrite
> > >>>>   reserved[2]    [0x13fffb000-0x13fffffff], 0x5000 bytes, flags:
> > >>>> no-notify, no-overwrite
> > >>>> devicetree  =3D board
> > >>>> serial addr =3D 0x0000000010000000
> > >>>>   width      =3D 0x0000000000000004
> > >>>>   shift      =3D 0x0000000000000002
> > >>>>   offset     =3D 0x0000000000000000
> > >>>>   clock      =3D 0x00000000016e3600
> > >>>> boot hart   =3D 0x0000000000000001
> > >>>> firmware fdt=3D 0x0000000042200000
> > >>>>
> > >>>> Differences in bdinfo output between working (parent of the
> > >>>> regression) and non-working (origin/master) version:
> > >>>>
> > >>>> -fdt_blob    =3D 0x00000000ff72da20
> > >>>> +fdt_blob    =3D 0x00000000ff72da10
> > >>>>   lmb_dump_all:
> > >>>>    memory.count =3D 0x1
> > >>>> - memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes flags=
: none
> > >>>> - reserved.count =3D 0x2
> > >>>> - reserved[0]    [0x40000000-0x4005ffff], 0x00060000 bytes flags: =
no-map
> > >>>> - reserved[1]    [0xfe729630-0xffffffff], 0x018d69d0 bytes flags: =
no-overwrite
> > >>>> + memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes, flag=
s: none
> > >>>> + reserved.count =3D 0x3
> > >>>> + reserved[0]    [0x40000000-0x4005ffff], 0x60000 bytes, flags: no=
-map
> > >>>> + reserved[1]    [0xfe72d620-0xffffffff], 0x18d29e0 bytes, flags: =
no-overwrite
> > >>>> + reserved[2]    [0x13fffb000-0x13fffffff], 0x5000 bytes, flags:
> > >>>> no-notify, no-overwrite
> > >>>>
> > >>>>>
> > >>>>> 2) do you get any errors when running the 'bootefi bootmgr' comma=
nd
> > >>>>> other than what you mention above
> > >>>>>
> > >>>>
> > >>>> U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:43 -08=
00)
> > >>>> ...
> > >>>> StarFive # bootefi bootmgr
> > >>>> Booting: mmc 0
> > >>>> error: no suitable video mode found.
> > >>>>
> > >>>> U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19:56:55=
 -0800)
> > >>>> ...
> > >>>> StarFive # bootefi bootmgr
> > >>>> Card did not respond to voltage select! : -110
> > >>>> Not a PE-COFF file
> > >>>> Loading Boot0000 'mmc 0' failed
> > >>>> Loading Boot0001 'nvme 0' failed
> > >>>> EFI boot manager: Cannot load any image
> > >>>>
> > >>>>> 3) What exactly do you mean by "global EFI boot is successful"
> > >>>>>
> > >>>>
> > >>>> I don't know what the correct name of it is. EFI can boot with wha=
t I
> > >>>> am labeling as global EFI boot and searching for fixed path names =
(?),
> > >>>> or I guess it can decide from EFI variables what to do which I
> > >>>> consider to be the user-configured EFI boot. One of these (the
> > >>>> user-configured EFI boot) is broken since the regression.
> > >>>>
> > >>>> U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:43 -08=
00)
> > >>>> ...
> > >>>> Card did not respond to voltage select! : -110
> > >>>> Failed to load EFI variables
> > >>>> ** Booting bootflow '<NULL>' with efi_mgr
> > >>>> Booting: mmc 0
> > >>>> error: no suitable video mode found.
> > >>>>
> > >>>> U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19:56:55=
 -0800)
> > >>>> ...
> > >>>> Card did not respond to voltage select! : -110
> > >>>> Failed to load EFI variables
> > >>>> ** Booting bootflow '<NULL>' with efi_mgr
> > >>>> Not a PE-COFF file
> > >>>> Loading Boot0000 'mmc 0' failed
> > >>>> Loading Boot0001 'nvme 0' failed
> > >>>> EFI boot manager: Cannot load any image
> > >>>> Boot failed (err=3D-14)
> > >>>> ** Booting bootflow 'mmc@16010000.bootdev.part_1' with efi
> > >>>> Booting /\EFI\BOOT\BOOTRISCV64.EFI
> > >>>> error: no suitable video mode found.
> > >>>
> > >>> Based on the logs above, it seems like you are booting using the
> > >>> bootmeth efi_mgr? If so, can you try disabling the bootstd config. =
I
> > >>> might be wrong, but I remember some issues with the bootstd efi_mgr
> > >>> method on some other platform. Also, are you available on irc?
> > >>>
> > >>> -sughosh
> > >>>
> > >>>>> -sughosh
> > >>>>>
> > >>>>>>
> > >>>>>> For context, the Star64 eMMC contains here an installed Debian L=
inux
> > >>>>>> OS in the usual way with Grub2 EFI on the EFI System Partition t=
here,
> > >>>>>> and that image boots fine from U-Boot v2024.10 also when loaded =
into
> > >>>>>> memory and using 'bootefi' directly on that memory address.
> > >>>>>>
> > >>>>
> > >>>> Thanks,
> > >>>>
> > >>>> -E Shattow
> > >>
> > >> Confirming that some discussion about this happened off-list with a
> > >> positive result and now awaiting a fix.
> > >
> > > I tried to reproduce this issue on the qemu arm64 virt platform, with
> > > 4GB of DRAM memory starting from 0x4000_0000 - 0x1_4000_0000. This is
> > > the exact same memory map for DRAM memory as on your board. I also
> > > modified the value of ram_top to 4GB, as on your board. But I am
> > > unable to hit this on the qemu arm64 platform when I try to boot the
> > > Debian image with 'bootefi bootmgr' command. The only difference that
> > > I see is that on the qemu emulator, the OS is on a virtio disk, as
> > > against mmc in your case. So I think we should try to get to the root
> > > cause of this. I think you mentioned on irc yesterday that you observ=
e
> > > this on two boards, so there is definitely something going on here.
> > >
> > > -sughosh
> > >
> > >>
> > >> Thanks very much!  -E
> >
> > Hello Eric,
> >
> > I reproduced the issue you had with the Debian installer on a Pine64
> > Star64 with 8 GiB.
> >
> > try_load_from_media: file_path =3D
> > /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61=
d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/SD(1)/SD(1)
> > no file name present, try default file
> > try_load_from_media: final_dp =3D
> > /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61=
d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/SD(1)/SD(1)/HD(2,0x01,0=
,0x1da800,0x1000)/\EFI\BOOT\BOOTRISCV64.EFI
> > efi_load_image_from_file: buffer 0x23feab000, size 0x11d000
> > efi_load_pe: efi 0x000000023feab000, size 0x11d000
> > Not a PE-COFF file
> > Loading Boot0000 'mmc 1' failed
> > EFI boot manager: Cannot load any image
> > Boot failed (err=3D-14)
> > Card did not respond to voltage select! : -110
> > ** Booting bootflow 'mmc@16020000.bootdev.part_2' with efi
> > efi_install_fdt: fdt copied to 0x000000023ffba000
> > Booting /\EFI\BOOT\BOOTRISCV64.EFI
> > efi_load_pe: efi 0x0000000040200000, size 0x11d000
> > error: no such device: /.disk/info.
> >
> > So loading to high memory fails though CONFIG_BOUNCE_BUFFER is enabled.
> >
> > With CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy booting the Debian installer
> > image succeeds.
> >
> > In efi_disk.c we call disk_blk_read(). But CONFIG_BOUNCE_BUFFER is only
> > evaluated in blk_read() same for write. This should be changed.
> >
> > CONFIG_EFI_LOADER_BOUNCE_BUFFER should not depend on an architecture.
> >
> > @Hal, @Minda
> > The MMC driver not supporting addresses over 4GiB, is this due to a
> > hardware deficiency or can that be fixed in the U-Boot driver?
> >
> > Best regards
> >
> > Heinrich
> >
> >
>
> A combination of these two series remedy this issue:
>
> "configs: JH7110: enable EFI_LOADER_BOUNCE_BUFFER"
> "bouncebuf: Allow allocation from U-Boot heap"
>
> Tested on 4GB Milk-V Mars CM Lite, 8GB Milk-V Mars CM Lite WiFi, 4GB
> Pine64 Star64.
>
> Sughosh can you please add to your series my Tested-by: E Shattow
> <lucent@gmail.com>
>
...
>
> -E

Postscript I'm getting failure when 'load mmc' a large file, but
success 'load mmc' a small file. Same applies for 'bootefi bootmgr'
whatever file access it is making.

Okay admittedly I am frustrated and confused what is our testing
methodology here? I don't actually know what is broken (something
unspecified in an mmc driver) and what we are fixing (preventing the
new behavior which does not agree with the old driver - how?).

The problem appears to be a broken mmc implementation and we are not
fixing that by these buffering tricks.

-E
