Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18479D6E2AF
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 04:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95128895DF;
	Wed, 20 Nov 2024 05:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BOS14zeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E331B895D0; Wed, 20 Nov 2024 05:39:46 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 622C7895DF
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:39:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb50e84ec7so14988081fa.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 20:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732077584; x=1732682384; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BH0BTo0gQEjRnh3EeXyQKCk7weklX1pLoXq018rMudk=;
 b=BOS14zeSUoUaDL200y9eWS7grWVn5lIcWHfrD+LT/hwPx4Tv97Ik3/r1KZzZIJ2Euc
 YrywVcTzOotNJvLEBXwV9ZCusQ4mO+zVljs00H6MOOfxbzSY3l7qbb8J2MgcsPRRlOaV
 1byT+rKQ8e+Le1ocV52idvZhamZ8kCBRjF+AAJZxOSJsDpHRV2P1YBODuJdloVC3bUNz
 b4QtL3BwkUzXkvBFJSURuQdKTF+7zoBjsybDzp77OUkEnmwCcOOsEzWaz1QX8Y4fNEkb
 Y1YyIiHO/P+1Ocspe2tpt0qRBjDEbHeyb+qbTLqygBEHyTjIB7nv25yR1bIakQMMlb8O
 HkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732077584; x=1732682384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BH0BTo0gQEjRnh3EeXyQKCk7weklX1pLoXq018rMudk=;
 b=XtfO2/ad4yi1Wd5hZMZId+S5r16S0QeZw0T4IOz+QHIGOrJ+zS62kz3bB9H1mG1LVZ
 lT7VdrN5FKWgbCC+6+jhfXM0zDwk19L1Ztq1Hv1kmtjpOdoib3EKjvL7nXvWDJ0h3m1G
 LQIPxOar8ahONugnhdaKaUq1M7ojEHZIkOcKijoRe/g57FhhfnP684+zPmy+AIfr5foy
 oStxHAlIGELZrOzvV9CPNG/lYM16bbvyMzFiC2h7CA7lHw6RwVnd6X+60029bs6TsdCv
 f1fmU0FGDcUlNzYnSX1bONSSZMjWyTwpBndf1umfXzdNqJ8fqomnjsRFt+B4Exz3K0bH
 as0A==
X-Gm-Message-State: AOJu0YxY9t9ZASVuDTBMF+JfKWqviMRGbRxDuMdS8fpmqKMvBadfg7k1
 N7S87qEsc6fpGwghX5JduiVllGwYRw7Pn/yHCk1/Jv6fowxMWnvTdmnmsIA9u3TOvuzMaMuw8Fm
 N9zsSBFrwkPJH0rhoC50E1BwknHg=
X-Gm-Gg: ASbGncuUh/TzwcswBYqoMworhV+oj95k8tApxvAD93ZAvNuiniPMv14YgUw+v+yTMzo
 Io7VGO1l932YgsKtG/+eey4ivQv1uuEzhOBy+iwFSupnOm8AT0d5UYBnp0LA9lWVmDA==
X-Google-Smtp-Source: AGHT+IGo52hWRRf50tl3egAEOOgQW4olAQEm7fqwSRPDLlkKe668WXfX3FLgIf0Q6Yyl+7TQSJ3WTTYeebvnhwDZk8U=
X-Received: by 2002:a05:651c:220c:b0:2fb:62ad:89fe with SMTP id
 38308e7fff4ca-2ff8dbb6375mr5366781fa.16.1732077583223; Tue, 19 Nov 2024
 20:39:43 -0800 (PST)
MIME-Version: 1.0
References: <CANV2PTN5AbNpCu4TGhZ87q_Eyeemxxwu5m=QjwKVS967x8hbnQ@mail.gmail.com>
 <CADg8p94ohYfNLL8jbRA-hNd=fbg9PuVJvp0z-QYTeaGwHZ9q0Q@mail.gmail.com>
In-Reply-To: <CADg8p94ohYfNLL8jbRA-hNd=fbg9PuVJvp0z-QYTeaGwHZ9q0Q@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Tue, 19 Nov 2024 20:39:32 -0800
Message-ID: <CANV2PTNdcc61CUTF9_zammmAugjVQOth=UFPiZv3=Qw_YX5RkA@mail.gmail.com>
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

On Tue, Nov 19, 2024 at 6:42=E2=80=AFPM Sughosh Ganu <sughosh.ganu@linaro.o=
rg> wrote:
>
> On Wed, 20 Nov 2024 at 04:48, E Shattow <lucent@gmail.com> wrote:
> >
> > Hello,
> >
> > On HEAD some commits after v2024.10 I encounter a regression for
> > `bootefi bootmgr` fail with error "Not a PE-COFF file";  The fall-thru
> > case of global EFI boot is successful.
> >
> > Having run a git bisect I discover the first bad commit 22f2c9ed:
> >
> > $ git checkout -b master origin/master
> > branch 'master' set up to track 'origin/master'.
> > Switched to a new branch 'master'
> > $ git bisect start
> > status: waiting for both good and bad commits
> > $ git bisect bad HEAD
> > status: waiting for good commit(s), bad commit known
> > $ git bisect good v2024.10
> > Bisecting: 850 revisions left to test after this (roughly 10 steps)
> > [82686e678e1587ddbd9570f82c58cdc3aecf2dbe] Merge branch 'staging' of
> > https://source.denx.de/u-boot/custodians/u-boot-tegra
> > $ git bisect good
> > Bisecting: 422 revisions left to test after this (roughly 9 steps)
> > [8963d433eb5d4a9f3a9def84e9c61a45c13e72bc] Merge tag
> > 'u-boot-rockchip-20241026' of
> > https://gitlab.denx.de/u-boot/custodians/u-boot-rockchip
> > $ git bisect bad
> > Bisecting: 214 revisions left to test after this (roughly 8 steps)
> > [0a504585d1cefeaf35ae8f860a5e5aa44dfffed5] arm: dts: k3-j722s-binman:
> > Add support for HS-SE
> > $ git bisect bad
> > Bisecting: 106 revisions left to test after this (roughly 7 steps)
> > [88057dab2cde8710ccc95d12fb312184e0b023ca] mtd: spi-nor: Allow flashes
> > to specify MTD writesize
> > $ git bisect good
> > Bisecting: 53 revisions left to test after this (roughly 6 steps)
> > [625d40ab120dbc6f45dbd975857f8f87e422bd0f] test: boot: fix
> > bootflow_cmd_label for when DSA_SANDBOX is disabled
> > $ git bisect bad
> > Bisecting: 26 revisions left to test after this (roughly 5 steps)
> > [5b9261fb0b1ed087387f2036d279fd3f4bb20a61] Makefile: Drop
> > SPL_FIT_GENERATOR support
> > $ git bisect good
> > Bisecting: 13 revisions left to test after this (roughly 4 steps)
> > [e1b6822d6522d94d579d53092342b542d368a04b] efi_memory: do not add RAM
> > memory to the memory map
> > $ git bisect bad
> > Bisecting: 6 revisions left to test after this (roughly 3 steps)
> > [2f6191526a1325b6ddb59795a093eca69dbf8976] lmb: notify of any changes
> > to the LMB memory map
> > $ git bisect bad
> > Bisecting: 2 revisions left to test after this (roughly 2 steps)
> > [3c6896ad2fb876b0a23202f62a83c0d44380c9ea] lmb: add a flag to allow
> > suppressing memory map change notification
> > $ git bisect good
> > Bisecting: 0 revisions left to test after this (roughly 1 step)
> > [22f2c9ed9f533a56bed09bd4e0e37852b6b9f3b1] efi: memory: use the lmb
> > API's for allocating and freeing memory
> > $ git bisect bad
> > Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > [eb052cbb896fee6f947765b44b0d80a54b19ce1a] lmb: add and reserve memory
> > above ram_top
> > $ git bisect good
> > 22f2c9ed9f533a56bed09bd4e0e37852b6b9f3b1 is the first bad commit
> >
> > A commit is good if Star64 boots and absent the error about "Not a
> > PE-COFF file" (duly confirmed by eficonfig to adjust boot order
> > allowing removable media of an OS installer image on SD Card to be the
> > priority, verifying that the installer runs as expected).  A commit is
> > bad if U-Boot crashes and/or has the error "Not a PE-COFF file".

>
> Can you post the output of the following. Thanks.

>
> 1) running the 'bdinfo' command

U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:43 -0800)
...
StarFive # bdinfo
boot_params =3D 0x0000000000000000
DRAM bank   =3D 0x0000000000000000
-> start    =3D 0x0000000040000000
-> size     =3D 0x0000000100000000
flashstart  =3D 0x0000000000000000
flashsize   =3D 0x0000000000000000
flashoffset =3D 0x0000000000000000
baudrate    =3D 115200 bps
relocaddr   =3D 0x00000000fff46000
reloc off   =3D 0x00000000bfd46000
Build       =3D 64-bit
current eth =3D ethernet@16030000
ethaddr     =3D 6c:cf:39:00:75:63
IP addr     =3D <NULL>
fdt_blob    =3D 0x00000000ff72da20
lmb_dump_all:
 memory.count =3D 0x1
 memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes flags: none
 reserved.count =3D 0x2
 reserved[0]    [0x40000000-0x4005ffff], 0x00060000 bytes flags: no-map
 reserved[1]    [0xfe729630-0xffffffff], 0x018d69d0 bytes flags: no-overwri=
te
devicetree  =3D board
serial addr =3D 0x0000000010000000
 width      =3D 0x0000000000000004
 shift      =3D 0x0000000000000002
 offset     =3D 0x0000000000000000
 clock      =3D 0x00000000016e3600
boot hart   =3D 0x0000000000000001
firmware fdt=3D 0x0000000042200000

U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19:56:55 -0800)
...
StarFive # bdinfo
boot_params =3D 0x0000000000000000
DRAM bank   =3D 0x0000000000000000
-> start    =3D 0x0000000040000000
-> size     =3D 0x0000000100000000
flashstart  =3D 0x0000000000000000
flashsize   =3D 0x0000000000000000
flashoffset =3D 0x0000000000000000
baudrate    =3D 115200 bps
relocaddr   =3D 0x00000000fff46000
reloc off   =3D 0x00000000bfd46000
Build       =3D 64-bit
current eth =3D ethernet@16030000
ethaddr     =3D 6c:cf:39:00:75:63
IP addr     =3D <NULL>
fdt_blob    =3D 0x00000000ff72da10
lmb_dump_all:
 memory.count =3D 0x1
 memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes, flags: none
 reserved.count =3D 0x3
 reserved[0]    [0x40000000-0x4005ffff], 0x60000 bytes, flags: no-map
 reserved[1]    [0xfe72d620-0xffffffff], 0x18d29e0 bytes, flags: no-overwri=
te
 reserved[2]    [0x13fffb000-0x13fffffff], 0x5000 bytes, flags:
no-notify, no-overwrite
devicetree  =3D board
serial addr =3D 0x0000000010000000
 width      =3D 0x0000000000000004
 shift      =3D 0x0000000000000002
 offset     =3D 0x0000000000000000
 clock      =3D 0x00000000016e3600
boot hart   =3D 0x0000000000000001
firmware fdt=3D 0x0000000042200000

Differences in bdinfo output between working (parent of the
regression) and non-working (origin/master) version:

-fdt_blob    =3D 0x00000000ff72da20
+fdt_blob    =3D 0x00000000ff72da10
 lmb_dump_all:
  memory.count =3D 0x1
- memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes flags: none
- reserved.count =3D 0x2
- reserved[0]    [0x40000000-0x4005ffff], 0x00060000 bytes flags: no-map
- reserved[1]    [0xfe729630-0xffffffff], 0x018d69d0 bytes flags: no-overwr=
ite
+ memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes, flags: none
+ reserved.count =3D 0x3
+ reserved[0]    [0x40000000-0x4005ffff], 0x60000 bytes, flags: no-map
+ reserved[1]    [0xfe72d620-0xffffffff], 0x18d29e0 bytes, flags: no-overwr=
ite
+ reserved[2]    [0x13fffb000-0x13fffffff], 0x5000 bytes, flags:
no-notify, no-overwrite

>
> 2) do you get any errors when running the 'bootefi bootmgr' command
> other than what you mention above
>

U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:43 -0800)
...
StarFive # bootefi bootmgr
Booting: mmc 0
error: no suitable video mode found.

U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19:56:55 -0800)
...
StarFive # bootefi bootmgr
Card did not respond to voltage select! : -110
Not a PE-COFF file
Loading Boot0000 'mmc 0' failed
Loading Boot0001 'nvme 0' failed
EFI boot manager: Cannot load any image

> 3) What exactly do you mean by "global EFI boot is successful"
>

I don't know what the correct name of it is. EFI can boot with what I
am labeling as global EFI boot and searching for fixed path names (?),
or I guess it can decide from EFI variables what to do which I
consider to be the user-configured EFI boot. One of these (the
user-configured EFI boot) is broken since the regression.

U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:43 -0800)
...
Card did not respond to voltage select! : -110
Failed to load EFI variables
** Booting bootflow '<NULL>' with efi_mgr
Booting: mmc 0
error: no suitable video mode found.

U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19:56:55 -0800)
...
Card did not respond to voltage select! : -110
Failed to load EFI variables
** Booting bootflow '<NULL>' with efi_mgr
Not a PE-COFF file
Loading Boot0000 'mmc 0' failed
Loading Boot0001 'nvme 0' failed
EFI boot manager: Cannot load any image
Boot failed (err=3D-14)
** Booting bootflow 'mmc@16010000.bootdev.part_1' with efi
Booting /\EFI\BOOT\BOOTRISCV64.EFI
error: no suitable video mode found.

> -sughosh
>
> >
> > For context, the Star64 eMMC contains here an installed Debian Linux
> > OS in the usual way with Grub2 EFI on the EFI System Partition there,
> > and that image boots fine from U-Boot v2024.10 also when loaded into
> > memory and using 'bootefi' directly on that memory address.
> >

Thanks,

-E Shattow
