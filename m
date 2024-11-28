Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08178D69100
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 11:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CE9489887;
	Thu, 28 Nov 2024 12:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FJJwnj04";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BA5C8988A; Thu, 28 Nov 2024 12:56:07 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49E9F89878
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 12:56:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5cfcd99846fso864159a12.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 03:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732794964; x=1733399764; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rG/umFlZ7FmGxoO6n0gp2s+0BvMlJMQvy7flgYgGPuk=;
 b=FJJwnj046VTPhz8ofBZGrtX26b5TlaPnJ26qJig+8A/wBa8JR+wEc51nJH+b9732Yz
 qL7+JPgW0+Rx/D3StqDJ96O2KFltIfFcsBGfG0op3P2gtR6pOgbSY4a5kUMLzGhzM2h8
 pP/XnM2OL8S0gtr+bJPhUJ6+GN/7EFxLWI3LlAlnrQJYRJpp3WshpBwkFmwhlQiFcTxl
 HFRMZiekP7UfeDz5ZHD8O3G08wGHCdgXDz7n8HuqHwYQoUKA5zz57hbthPMed0hQmX+4
 jLaMNl1O4SHcFm9yodtuYOyoDFKK77UTF7I1YpMnPWjXP6iIlajClLe0deAmDCdGzbkZ
 OPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732794964; x=1733399764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rG/umFlZ7FmGxoO6n0gp2s+0BvMlJMQvy7flgYgGPuk=;
 b=XGjQEnrrRXQAbMmtgBoI/b6y6NpEmbrtX5CrHkOnH3gNed8x/1FaDtbpbap2GM/eIn
 4sVA124CRLqOXm1q0huf1wnp1ob/Z2AL4gUah6XUGlOSx9e1RG1VgStEfY6NC32VQI1V
 gxHUE8QFj/RbBfGJuugEH0V+Wu6ZDOu1J/h/w5uqNQj8VcJBCe67t0dqXg0ugl3dja2S
 OD4idZuF+j5hQyh8IXpWHvfaC08Df26x/6akd+V03r4i6dVa6J9+8c1C9pjuyEiGTUwy
 aO1yzayZ3kKW24UQLO7dr725Egtxr41TYJ4TyU+ZyNTGitv21a3iKm5dv6bhuE3CcBtJ
 23UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJJWl/+/luk0kUQ4hNvz2nlTHOQ1SFC52PxXVXgZStnT8fEKkME0JBQlsRaTk5cXlEEtKZ4Yo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxr3rfqoBqyLJ+CXCjdwRIhmW12JOJ6CWRfctKPqoNGLGXm6k+M
 YJ1aXeNYdNKwc2KThjyj5XOR8gEMAK1QAbMcUaris6Hch4ba0efJTDujOQfvTsjDMwEh9SwsLqn
 loH+llaD1PDLZwNbXSyP2fX40d+LlcQk1pzDNig==
X-Gm-Gg: ASbGncvhOt9v6WuEe01CGUsIPVKZnj9Lelh67eiN98MjxPzPlf8B4GTvcsWs7X3u06e
 zLds0d7sQrnixbeT5HC78Cc7D1FGVWbSD
X-Google-Smtp-Source: AGHT+IE5ITN+P/YWze6fmOToQvKOipUNoWMo61X0fgim3rLH1mugfxVFmPRwoGoY7r6AzzJb1F5AAWXfdR8ICk3BLSI=
X-Received: by 2002:a05:6402:5ce:b0:5cf:bcce:7422 with SMTP id
 4fb4d7f45d1cf-5d080b82568mr5827059a12.6.1732794963618; Thu, 28 Nov 2024
 03:56:03 -0800 (PST)
MIME-Version: 1.0
References: <CANV2PTN5AbNpCu4TGhZ87q_Eyeemxxwu5m=QjwKVS967x8hbnQ@mail.gmail.com>
 <CADg8p94ohYfNLL8jbRA-hNd=fbg9PuVJvp0z-QYTeaGwHZ9q0Q@mail.gmail.com>
 <CANV2PTNdcc61CUTF9_zammmAugjVQOth=UFPiZv3=Qw_YX5RkA@mail.gmail.com>
 <CADg8p97RHvZG23fE8grvE5DzScT+okV-6qSHv_gQUiwggKDtJQ@mail.gmail.com>
 <CANV2PTP-17Z-MUa8-3mcAHduxzPqb6VN-ZKZS31XkwQ-2X1+8A@mail.gmail.com>
 <CADg8p97vUaELMimYc52bT6uVpqnLJWWfYPRJj=rJ6QDUcn8iEg@mail.gmail.com>
 <b3279988-ddda-423f-8caf-3fa5e4192fcb@gmx.de>
 <CANV2PTM55_Fb4_=0sGoZ1XQo89X9_UdH3tNWp=ZcT0KSY9o+kA@mail.gmail.com>
 <CANV2PTNmj4nxShO3tspheDSXohw212yj0unJtzokLHPxoOch0g@mail.gmail.com>
 <CADg8p94M5vNY8jo2Xm83ffgt9WW0Zy=Jba6DD=sz4sf_hUKk-A@mail.gmail.com>
 <0047bc9f-b6e8-4afd-a1b7-cfc0c8d8e73e@gmx.de>
 <CADg8p94tzseoSGom1jBxnTEPZPDG0tfJ-nYFHZVpL9ZztdTV0w@mail.gmail.com>
 <87cyifzk2u.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87cyifzk2u.fsf@bloch.sibelius.xs4all.nl>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 28 Nov 2024 17:25:52 +0530
Message-ID: <CADg8p96xhx2RxsEZ3CXae09R2OVxkYem0RrN2=L0KVROScd2+Q@mail.gmail.com>
Subject: Re: [BUG regression in HEAD] efi: memory: use the lmb API's for
 allocating and freeing memory
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: xypron.glpk@gmx.de, minda.chen@starfivetech.com, hal.feng@starfivetech.com,
 u-boot@lists.denx.de, ilias.apalodimas@linaro.org, trini@konsulko.com, 
 sjg@chromium.org, lucent@gmail.com
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

On Thu, 28 Nov 2024 at 16:44, Mark Kettenis <mark.kettenis@xs4all.nl> wrote=
:
>
> > From: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Date: Thu, 28 Nov 2024 15:51:06 +0530
> >
> > On Wed, 27 Nov 2024 at 21:29, Heinrich Schuchardt <xypron.glpk@gmx.de> =
wrote:
> > >
> > > On 27.11.24 16:21, Sughosh Ganu wrote:
> > > > On Wed, 27 Nov 2024 at 19:41, E Shattow <lucent@gmail.com> wrote:
> > > >>
> > > >> Replying my own message postscript
> > > >>
> > > >> On Wed, Nov 27, 2024 at 4:47=E2=80=AFAM E Shattow <lucent@gmail.co=
m> wrote:
> > > >>>
> > > >>> Following up on this with some positive results:
> > > >>>
> > > >>> On Thu, Nov 21, 2024 at 4:22=E2=80=AFAM Heinrich Schuchardt <xypr=
on.glpk@gmx.de> wrote:
> > > >>>>
> > > >>>> On 21.11.24 09:04, Sughosh Ganu wrote:
> > > >>>>> On Wed, 20 Nov 2024 at 13:49, E Shattow <lucent@gmail.com> wrot=
e:
> > > >>>>>>
> > > >>>>>> Hi all, (on-list)
> > > >>>>>>
> > > >>>>>> On Tue, Nov 19, 2024 at 9:14=E2=80=AFPM Sughosh Ganu <sughosh.=
ganu@linaro.org> wrote:
> > > >>>>>>>
> > > >>>>>>> On Wed, 20 Nov 2024 at 10:09, E Shattow <lucent@gmail.com> wr=
ote:
> > > >>>>>>>>
> > > >>>>>>>> On Tue, Nov 19, 2024 at 6:42=E2=80=AFPM Sughosh Ganu <sughos=
h.ganu@linaro.org> wrote:
> > > >>>>>>>>>
> > > >>>>>>>>> On Wed, 20 Nov 2024 at 04:48, E Shattow <lucent@gmail.com> =
wrote:
> > > >>>>>>>>>>
> > > >>>>>>>>>> Hello,
> > > >>>>>>>>>>
> > > >>>>>>>>>> On HEAD some commits after v2024.10 I encounter a regressi=
on for
> > > >>>>>>>>>> `bootefi bootmgr` fail with error "Not a PE-COFF file";  T=
he fall-thru
> > > >>>>>>>>>> case of global EFI boot is successful.
> > > >>>>>>>>>>
> > > >>>>>>>>>> Having run a git bisect I discover the first bad commit 22=
f2c9ed:
> > > >>>>>>>>>>
> > > >>>>>>>>>> $ git checkout -b master origin/master
> > > >>>>>>>>>> branch 'master' set up to track 'origin/master'.
> > > >>>>>>>>>> Switched to a new branch 'master'
> > > >>>>>>>>>> $ git bisect start
> > > >>>>>>>>>> status: waiting for both good and bad commits
> > > >>>>>>>>>> $ git bisect bad HEAD
> > > >>>>>>>>>> status: waiting for good commit(s), bad commit known
> > > >>>>>>>>>> $ git bisect good v2024.10
> > > >>>>>>>>>> Bisecting: 850 revisions left to test after this (roughly =
10 steps)
> > > >>>>>>>>>> [82686e678e1587ddbd9570f82c58cdc3aecf2dbe] Merge branch 's=
taging' of
> > > >>>>>>>>>> https://source.denx.de/u-boot/custodians/u-boot-tegra
> > > >>>>>>>>>> $ git bisect good
> > > >>>>>>>>>> Bisecting: 422 revisions left to test after this (roughly =
9 steps)
> > > >>>>>>>>>> [8963d433eb5d4a9f3a9def84e9c61a45c13e72bc] Merge tag
> > > >>>>>>>>>> 'u-boot-rockchip-20241026' of
> > > >>>>>>>>>> https://gitlab.denx.de/u-boot/custodians/u-boot-rockchip
> > > >>>>>>>>>> $ git bisect bad
> > > >>>>>>>>>> Bisecting: 214 revisions left to test after this (roughly =
8 steps)
> > > >>>>>>>>>> [0a504585d1cefeaf35ae8f860a5e5aa44dfffed5] arm: dts: k3-j7=
22s-binman:
> > > >>>>>>>>>> Add support for HS-SE
> > > >>>>>>>>>> $ git bisect bad
> > > >>>>>>>>>> Bisecting: 106 revisions left to test after this (roughly =
7 steps)
> > > >>>>>>>>>> [88057dab2cde8710ccc95d12fb312184e0b023ca] mtd: spi-nor: A=
llow flashes
> > > >>>>>>>>>> to specify MTD writesize
> > > >>>>>>>>>> $ git bisect good
> > > >>>>>>>>>> Bisecting: 53 revisions left to test after this (roughly 6=
 steps)
> > > >>>>>>>>>> [625d40ab120dbc6f45dbd975857f8f87e422bd0f] test: boot: fix
> > > >>>>>>>>>> bootflow_cmd_label for when DSA_SANDBOX is disabled
> > > >>>>>>>>>> $ git bisect bad
> > > >>>>>>>>>> Bisecting: 26 revisions left to test after this (roughly 5=
 steps)
> > > >>>>>>>>>> [5b9261fb0b1ed087387f2036d279fd3f4bb20a61] Makefile: Drop
> > > >>>>>>>>>> SPL_FIT_GENERATOR support
> > > >>>>>>>>>> $ git bisect good
> > > >>>>>>>>>> Bisecting: 13 revisions left to test after this (roughly 4=
 steps)
> > > >>>>>>>>>> [e1b6822d6522d94d579d53092342b542d368a04b] efi_memory: do =
not add RAM
> > > >>>>>>>>>> memory to the memory map
> > > >>>>>>>>>> $ git bisect bad
> > > >>>>>>>>>> Bisecting: 6 revisions left to test after this (roughly 3 =
steps)
> > > >>>>>>>>>> [2f6191526a1325b6ddb59795a093eca69dbf8976] lmb: notify of =
any changes
> > > >>>>>>>>>> to the LMB memory map
> > > >>>>>>>>>> $ git bisect bad
> > > >>>>>>>>>> Bisecting: 2 revisions left to test after this (roughly 2 =
steps)
> > > >>>>>>>>>> [3c6896ad2fb876b0a23202f62a83c0d44380c9ea] lmb: add a flag=
 to allow
> > > >>>>>>>>>> suppressing memory map change notification
> > > >>>>>>>>>> $ git bisect good
> > > >>>>>>>>>> Bisecting: 0 revisions left to test after this (roughly 1 =
step)
> > > >>>>>>>>>> [22f2c9ed9f533a56bed09bd4e0e37852b6b9f3b1] efi: memory: us=
e the lmb
> > > >>>>>>>>>> API's for allocating and freeing memory
> > > >>>>>>>>>> $ git bisect bad
> > > >>>>>>>>>> Bisecting: 0 revisions left to test after this (roughly 0 =
steps)
> > > >>>>>>>>>> [eb052cbb896fee6f947765b44b0d80a54b19ce1a] lmb: add and re=
serve memory
> > > >>>>>>>>>> above ram_top
> > > >>>>>>>>>> $ git bisect good
> > > >>>>>>>>>> 22f2c9ed9f533a56bed09bd4e0e37852b6b9f3b1 is the first bad =
commit
> > > >>>>>>>>>>
> > > >>>>>>>>>> A commit is good if Star64 boots and absent the error abou=
t "Not a
> > > >>>>>>>>>> PE-COFF file" (duly confirmed by eficonfig to adjust boot =
order
> > > >>>>>>>>>> allowing removable media of an OS installer image on SD Ca=
rd to be the
> > > >>>>>>>>>> priority, verifying that the installer runs as expected). =
 A commit is
> > > >>>>>>>>>> bad if U-Boot crashes and/or has the error "Not a PE-COFF =
file".
> > > >>>>>>>>
> > > >>>>>>>>>
> > > >>>>>>>>> Can you post the output of the following. Thanks.
> > > >>>>>>>>
> > > >>>>>>>>>
> > > >>>>>>>>> 1) running the 'bdinfo' command
> > > >>>>>>>>
> > > >>>>>>>> U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:=
43 -0800)
> > > >>>>>>>> ...
> > > >>>>>>>> StarFive # bdinfo
> > > >>>>>>>> boot_params =3D 0x0000000000000000
> > > >>>>>>>> DRAM bank   =3D 0x0000000000000000
> > > >>>>>>>> -> start    =3D 0x0000000040000000
> > > >>>>>>>> -> size     =3D 0x0000000100000000
> > > >>>>>>>> flashstart  =3D 0x0000000000000000
> > > >>>>>>>> flashsize   =3D 0x0000000000000000
> > > >>>>>>>> flashoffset =3D 0x0000000000000000
> > > >>>>>>>> baudrate    =3D 115200 bps
> > > >>>>>>>> relocaddr   =3D 0x00000000fff46000
> > > >>>>>>>> reloc off   =3D 0x00000000bfd46000
> > > >>>>>>>> Build       =3D 64-bit
> > > >>>>>>>> current eth =3D ethernet@16030000
> > > >>>>>>>> ethaddr     =3D 6c:cf:39:00:75:63
> > > >>>>>>>> IP addr     =3D <NULL>
> > > >>>>>>>> fdt_blob    =3D 0x00000000ff72da20
> > > >>>>>>>> lmb_dump_all:
> > > >>>>>>>>    memory.count =3D 0x1
> > > >>>>>>>>    memory[0]      [0x40000000-0x13fffffff], 0x100000000 byte=
s flags: none
> > > >>>>>>>>    reserved.count =3D 0x2
> > > >>>>>>>>    reserved[0]    [0x40000000-0x4005ffff], 0x00060000 bytes =
flags: no-map
> > > >>>>>>>>    reserved[1]    [0xfe729630-0xffffffff], 0x018d69d0 bytes =
flags: no-overwrite
> > > >>>>>>>> devicetree  =3D board
> > > >>>>>>>> serial addr =3D 0x0000000010000000
> > > >>>>>>>>    width      =3D 0x0000000000000004
> > > >>>>>>>>    shift      =3D 0x0000000000000002
> > > >>>>>>>>    offset     =3D 0x0000000000000000
> > > >>>>>>>>    clock      =3D 0x00000000016e3600
> > > >>>>>>>> boot hart   =3D 0x0000000000000001
> > > >>>>>>>> firmware fdt=3D 0x0000000042200000
> > > >>>>>>>>
> > > >>>>>>>> U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19=
:56:55 -0800)
> > > >>>>>>>> ...
> > > >>>>>>>> StarFive # bdinfo
> > > >>>>>>>> boot_params =3D 0x0000000000000000
> > > >>>>>>>> DRAM bank   =3D 0x0000000000000000
> > > >>>>>>>> -> start    =3D 0x0000000040000000
> > > >>>>>>>> -> size     =3D 0x0000000100000000
> > > >>>>>>>> flashstart  =3D 0x0000000000000000
> > > >>>>>>>> flashsize   =3D 0x0000000000000000
> > > >>>>>>>> flashoffset =3D 0x0000000000000000
> > > >>>>>>>> baudrate    =3D 115200 bps
> > > >>>>>>>> relocaddr   =3D 0x00000000fff46000
> > > >>>>>>>> reloc off   =3D 0x00000000bfd46000
> > > >>>>>>>> Build       =3D 64-bit
> > > >>>>>>>> current eth =3D ethernet@16030000
> > > >>>>>>>> ethaddr     =3D 6c:cf:39:00:75:63
> > > >>>>>>>> IP addr     =3D <NULL>
> > > >>>>>>>> fdt_blob    =3D 0x00000000ff72da10
> > > >>>>>>>> lmb_dump_all:
> > > >>>>>>>>    memory.count =3D 0x1
> > > >>>>>>>>    memory[0]      [0x40000000-0x13fffffff], 0x100000000 byte=
s, flags: none
> > > >>>>>>>>    reserved.count =3D 0x3
> > > >>>>>>>>    reserved[0]    [0x40000000-0x4005ffff], 0x60000 bytes, fl=
ags: no-map
> > > >>>>>>>>    reserved[1]    [0xfe72d620-0xffffffff], 0x18d29e0 bytes, =
flags: no-overwrite
> > > >>>>>>>>    reserved[2]    [0x13fffb000-0x13fffffff], 0x5000 bytes, f=
lags:
> > > >>>>>>>> no-notify, no-overwrite
> > > >>>>>>>> devicetree  =3D board
> > > >>>>>>>> serial addr =3D 0x0000000010000000
> > > >>>>>>>>    width      =3D 0x0000000000000004
> > > >>>>>>>>    shift      =3D 0x0000000000000002
> > > >>>>>>>>    offset     =3D 0x0000000000000000
> > > >>>>>>>>    clock      =3D 0x00000000016e3600
> > > >>>>>>>> boot hart   =3D 0x0000000000000001
> > > >>>>>>>> firmware fdt=3D 0x0000000042200000
> > > >>>>>>>>
> > > >>>>>>>> Differences in bdinfo output between working (parent of the
> > > >>>>>>>> regression) and non-working (origin/master) version:
> > > >>>>>>>>
> > > >>>>>>>> -fdt_blob    =3D 0x00000000ff72da20
> > > >>>>>>>> +fdt_blob    =3D 0x00000000ff72da10
> > > >>>>>>>>    lmb_dump_all:
> > > >>>>>>>>     memory.count =3D 0x1
> > > >>>>>>>> - memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes=
 flags: none
> > > >>>>>>>> - reserved.count =3D 0x2
> > > >>>>>>>> - reserved[0]    [0x40000000-0x4005ffff], 0x00060000 bytes f=
lags: no-map
> > > >>>>>>>> - reserved[1]    [0xfe729630-0xffffffff], 0x018d69d0 bytes f=
lags: no-overwrite
> > > >>>>>>>> + memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes=
, flags: none
> > > >>>>>>>> + reserved.count =3D 0x3
> > > >>>>>>>> + reserved[0]    [0x40000000-0x4005ffff], 0x60000 bytes, fla=
gs: no-map
> > > >>>>>>>> + reserved[1]    [0xfe72d620-0xffffffff], 0x18d29e0 bytes, f=
lags: no-overwrite
> > > >>>>>>>> + reserved[2]    [0x13fffb000-0x13fffffff], 0x5000 bytes, fl=
ags:
> > > >>>>>>>> no-notify, no-overwrite
> > > >>>>>>>>
> > > >>>>>>>>>
> > > >>>>>>>>> 2) do you get any errors when running the 'bootefi bootmgr'=
 command
> > > >>>>>>>>> other than what you mention above
> > > >>>>>>>>>
> > > >>>>>>>>
> > > >>>>>>>> U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:=
43 -0800)
> > > >>>>>>>> ...
> > > >>>>>>>> StarFive # bootefi bootmgr
> > > >>>>>>>> Booting: mmc 0
> > > >>>>>>>> error: no suitable video mode found.
> > > >>>>>>>>
> > > >>>>>>>> U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19=
:56:55 -0800)
> > > >>>>>>>> ...
> > > >>>>>>>> StarFive # bootefi bootmgr
> > > >>>>>>>> Card did not respond to voltage select! : -110
> > > >>>>>>>> Not a PE-COFF file
> > > >>>>>>>> Loading Boot0000 'mmc 0' failed
> > > >>>>>>>> Loading Boot0001 'nvme 0' failed
> > > >>>>>>>> EFI boot manager: Cannot load any image
> > > >>>>>>>>
> > > >>>>>>>>> 3) What exactly do you mean by "global EFI boot is successf=
ul"
> > > >>>>>>>>>
> > > >>>>>>>>
> > > >>>>>>>> I don't know what the correct name of it is. EFI can boot wi=
th what I
> > > >>>>>>>> am labeling as global EFI boot and searching for fixed path =
names (?),
> > > >>>>>>>> or I guess it can decide from EFI variables what to do which=
 I
> > > >>>>>>>> consider to be the user-configured EFI boot. One of these (t=
he
> > > >>>>>>>> user-configured EFI boot) is broken since the regression.
> > > >>>>>>>>
> > > >>>>>>>> U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:=
43 -0800)
> > > >>>>>>>> ...
> > > >>>>>>>> Card did not respond to voltage select! : -110
> > > >>>>>>>> Failed to load EFI variables
> > > >>>>>>>> ** Booting bootflow '<NULL>' with efi_mgr
> > > >>>>>>>> Booting: mmc 0
> > > >>>>>>>> error: no suitable video mode found.
> > > >>>>>>>>
> > > >>>>>>>> U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19=
:56:55 -0800)
> > > >>>>>>>> ...
> > > >>>>>>>> Card did not respond to voltage select! : -110
> > > >>>>>>>> Failed to load EFI variables
> > > >>>>>>>> ** Booting bootflow '<NULL>' with efi_mgr
> > > >>>>>>>> Not a PE-COFF file
> > > >>>>>>>> Loading Boot0000 'mmc 0' failed
> > > >>>>>>>> Loading Boot0001 'nvme 0' failed
> > > >>>>>>>> EFI boot manager: Cannot load any image
> > > >>>>>>>> Boot failed (err=3D-14)
> > > >>>>>>>> ** Booting bootflow 'mmc@16010000.bootdev.part_1' with efi
> > > >>>>>>>> Booting /\EFI\BOOT\BOOTRISCV64.EFI
> > > >>>>>>>> error: no suitable video mode found.
> > > >>>>>>>
> > > >>>>>>> Based on the logs above, it seems like you are booting using =
the
> > > >>>>>>> bootmeth efi_mgr? If so, can you try disabling the bootstd co=
nfig. I
> > > >>>>>>> might be wrong, but I remember some issues with the bootstd e=
fi_mgr
> > > >>>>>>> method on some other platform. Also, are you available on irc=
?
> > > >>>>>>>
> > > >>>>>>> -sughosh
> > > >>>>>>>
> > > >>>>>>>>> -sughosh
> > > >>>>>>>>>
> > > >>>>>>>>>>
> > > >>>>>>>>>> For context, the Star64 eMMC contains here an installed De=
bian Linux
> > > >>>>>>>>>> OS in the usual way with Grub2 EFI on the EFI System Parti=
tion there,
> > > >>>>>>>>>> and that image boots fine from U-Boot v2024.10 also when l=
oaded into
> > > >>>>>>>>>> memory and using 'bootefi' directly on that memory address=
.
> > > >>>>>>>>>>
> > > >>>>>>>>
> > > >>>>>>>> Thanks,
> > > >>>>>>>>
> > > >>>>>>>> -E Shattow
> > > >>>>>>
> > > >>>>>> Confirming that some discussion about this happened off-list w=
ith a
> > > >>>>>> positive result and now awaiting a fix.
> > > >>>>>
> > > >>>>> I tried to reproduce this issue on the qemu arm64 virt platform=
, with
> > > >>>>> 4GB of DRAM memory starting from 0x4000_0000 - 0x1_4000_0000. T=
his is
> > > >>>>> the exact same memory map for DRAM memory as on your board. I a=
lso
> > > >>>>> modified the value of ram_top to 4GB, as on your board. But I a=
m
> > > >>>>> unable to hit this on the qemu arm64 platform when I try to boo=
t the
> > > >>>>> Debian image with 'bootefi bootmgr' command. The only differenc=
e that
> > > >>>>> I see is that on the qemu emulator, the OS is on a virtio disk,=
 as
> > > >>>>> against mmc in your case. So I think we should try to get to th=
e root
> > > >>>>> cause of this. I think you mentioned on irc yesterday that you =
observe
> > > >>>>> this on two boards, so there is definitely something going on h=
ere.
> > > >>>>>
> > > >>>>> -sughosh
> > > >>>>>
> > > >>>>>>
> > > >>>>>> Thanks very much!  -E
> > > >>>>
> > > >>>> Hello Eric,
> > > >>>>
> > > >>>> I reproduced the issue you had with the Debian installer on a Pi=
ne64
> > > >>>> Star64 with 8 GiB.
> > > >>>>
> > > >>>> try_load_from_media: file_path =3D
> > > >>>> /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/Ve=
nHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/SD(1)/SD(1)
> > > >>>> no file name present, try default file
> > > >>>> try_load_from_media: final_dp =3D
> > > >>>> /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/Ve=
nHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/SD(1)/SD(1)/HD(2=
,0x01,0,0x1da800,0x1000)/\EFI\BOOT\BOOTRISCV64.EFI
> > > >>>> efi_load_image_from_file: buffer 0x23feab000, size 0x11d000
> > > >>>> efi_load_pe: efi 0x000000023feab000, size 0x11d000
> > > >>>> Not a PE-COFF file
> > > >>>> Loading Boot0000 'mmc 1' failed
> > > >>>> EFI boot manager: Cannot load any image
> > > >>>> Boot failed (err=3D-14)
> > > >>>> Card did not respond to voltage select! : -110
> > > >>>> ** Booting bootflow 'mmc@16020000.bootdev.part_2' with efi
> > > >>>> efi_install_fdt: fdt copied to 0x000000023ffba000
> > > >>>> Booting /\EFI\BOOT\BOOTRISCV64.EFI
> > > >>>> efi_load_pe: efi 0x0000000040200000, size 0x11d000
> > > >>>> error: no such device: /.disk/info.
> > > >>>>
> > > >>>> So loading to high memory fails though CONFIG_BOUNCE_BUFFER is e=
nabled.
> > > >>>>
> > > >>>> With CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy booting the Debian inst=
aller
> > > >>>> image succeeds.
> > > >>>>
> > > >>>> In efi_disk.c we call disk_blk_read(). But CONFIG_BOUNCE_BUFFER =
is only
> > > >>>> evaluated in blk_read() same for write. This should be changed.
> > > >>>>
> > > >>>> CONFIG_EFI_LOADER_BOUNCE_BUFFER should not depend on an architec=
ture.
> > > >>>>
> > > >>>> @Hal, @Minda
> > > >>>> The MMC driver not supporting addresses over 4GiB, is this due t=
o a
> > > >>>> hardware deficiency or can that be fixed in the U-Boot driver?
> > > >>>>
> > > >>>> Best regards
> > > >>>>
> > > >>>> Heinrich
> > > >>>>
> > > >>>>
> > > >>>
> > > >>> A combination of these two series remedy this issue:
> > > >>>
> > > >>> "configs: JH7110: enable EFI_LOADER_BOUNCE_BUFFER"
> > > >>> "bouncebuf: Allow allocation from U-Boot heap"
> > > >>>
> > > >>> Tested on 4GB Milk-V Mars CM Lite, 8GB Milk-V Mars CM Lite WiFi, =
4GB
> > > >>> Pine64 Star64.
> > > >>>
> > > >>> Sughosh can you please add to your series my Tested-by: E Shattow
> > > >>> <lucent@gmail.com>
> > > >>>
> > > >> ...
> > > >>>
> > > >>> -E
> > > >>
> > > >> Postscript I'm getting failure when 'load mmc' a large file, but
> > > >> success 'load mmc' a small file. Same applies for 'bootefi bootmgr=
'
> > > >> whatever file access it is making.
> > > >>
> > > >> Okay admittedly I am frustrated and confused what is our testing
> > > >> methodology here? I don't actually know what is broken (something
> > > >> unspecified in an mmc driver) and what we are fixing (preventing t=
he
> > > >> new behavior which does not agree with the old driver - how?).
> > > >>
> > > >> The problem appears to be a broken mmc implementation and we are n=
ot
> > > >> fixing that by these buffering tricks.
> > > >
> > > > As discussed offline, this is because you are trying to load a very
> > > > big file, and your platform only has 8MB of heap region. And I don'=
t
> > > > think that loading multiple MB's of data from mmc is an unusual
> > > > scenario. I am thinking now that the original change which I had
> > > > shared with you would be the most appropriate solution for this.
> > >
> > > I have not seen a distro kernel with less than 8 MiB recently.
> > >
> > > Shouldn't the driver work in chunks?
> >
> > At least the designware mmc driver does not seem to be working in that
> > fashion. The bounce-buffer logic does not consider breaking down the
> > transfer size in smaller chunks -- I think that is expected from the
> > drivers. But currently, the driver seems to be sending the transaction
> > size as is to the bounce_buffer_start() function. Should be fairly
> > straightforward to ascertain this though, just putting a debug print
> > in the bounce buffer function.
>
> I have been following this discussion from a distance, but I think
> you're on the wrong path here with relying on bounce buffers too much.
> A few observations about the generic bounce buffer implementation in
> U-Boot:
>
> * Only a small number of drivers actually implement bounce buffer
>   support.  While there is support for bounce buffers in the blk
>   layer, this may not be sufficient, and it doesn't help non-blk
>   drivers.
>
> * Bounce buffer support in U-Boot is primarily there to make sure DMA
>   buffers are cache-aligned.  That typically is only important for
>   smallish buffers that are allocated on the stack as large memory
>   allocations tend to be properly aligned already.
>
> * Bounce buffers make things slower as they introduce additional
>   memory allocations.
>
> The way U-Boot handles DMA address constraints is by allocating only
> from the address range that allows DMA by implementing
> board_get_usable_ram_top().  This works well because boards that have
> DMA address contraints typically have plenty of RAM that has no DMA
> restrictions.  The typical case is hardware that uses 32-bit DMA
> descriptors which means memory with addresses above 4G isn't DMA
> addressable.  But those boards have at least 2G of memory below that
> limit and nobody is going to load a kernel or initrd that comes close
> to that.
>
> The exception here is EFI.  EFI apps (such as bootloaders or kernels
> with an EFI stub) are typically unaware of any DMA constraints and may
> allocate memory at an arbitrary address.  This is why we have
> CONFIG_EFI_LOADER_BOUNCE_BUFFER.  This implements bounce buffers in
> the EFI layer and bounces before buffers are handed over to the
> drivers.  So this will work even if the individual drivers don't
> implement bounce buffers themselves.
>
> Based on these observations:
>
> * Boards that have DMA constraints should implement
>   board_get_usable_ram_top() and should set
>   CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy.

Heinrich has enabled the above config symbol in the affected
platform's defconfig. But this does not seem to help, and E Shattow
has been observing the issues even after this change.

>
> * The lmb memory allocations should by default return memory below
>   that limit.

Yes, I am planning to send a patch which handles this scenario. The
current LMB code handles the scenario where DRAM banks which fall
above ram_top get reserved, but this scenario of ram_top in the middle
of a given bank needs to be handled.

-sughosh

>
> Cheers,
>
> Mark
