Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED002C27C75
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 06:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3360D886DA;
	Wed, 12 Jun 2024 08:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="EGUDfebV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B06888791; Wed, 12 Jun 2024 08:13:39 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4647288373
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 08:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718172815; x=1718777615; i=xypron.glpk@gmx.de;
 bh=JfDNwDQad/ZgVJyVHN73UXhbUva28fe3X7X1399ojtE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=EGUDfebViyEQDwgcr5iHdmhdSXAl47hz/KdwWXAcekUZc/jWZHJqom2W9WFzFB4G
 NrkKpFuopidM1ef3q3rU+QKIgSXGw4WicEM7A0k0a8hG+eA+56eE29zToFuTKt/mj
 uUrGD/C7Aq155zrKK70104xwocfmPNejOp/w+tmzWWmHQo60YkXzl3QcgmoV31Hwc
 JcvrI0fb907nnFB2l2SbK2KqOcmCfCUkOA7jFVPM7YLTrZ1xDVOi/QVvfJdCkM0jP
 ZTsqt1IH2ZhkRnyUzDkhqqXV21mCeXfsdVBH1DVDXYrLed+l89bkGannR/fhtAlfw
 xJilXKqcYdnPHohE2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([109.42.176.212]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7GM-1s6mqy2od0-009EE8; Wed, 12
 Jun 2024 08:13:35 +0200
Date: Wed, 12 Jun 2024 08:13:31 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_04/31=5D_lmb=3A_remove_local?=
 =?US-ASCII?Q?_instances_of_the_lmb_structure_variable?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFLszTi1ZR+qeEuEbGUE2Fv3h1ahX3S_2ySBPQjgkfruiW8Xtw@mail.gmail.com>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-5-sughosh.ganu@linaro.org>
 <CAFLszTjQW72_Z8Dx4g1mVx5Y=wq9xeXYVBffxLUto6sDp6CMbw@mail.gmail.com>
 <20240611210145.GM68077@bill-the-cat>
 <CAFLszTjd4Sf=_um7QbkpbLAO9=2=vX_LkHv6br=9FPAPFhbH5Q@mail.gmail.com>
 <20240611225554.GO68077@bill-the-cat>
 <CAFLszTi1ZR+qeEuEbGUE2Fv3h1ahX3S_2ySBPQjgkfruiW8Xtw@mail.gmail.com>
Message-ID: <A4908B3E-821D-4826-AC82-A536D98B6974@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0AHsaOk+JLNH69gXINz0e2Q76HP7I12DvtdS1Hc+giIKrAK3tzY
 V896jVMZtGJUw4WoPRksx07PfCefKEt5SHQkq39FcBszHiDkC+5HEUisafFIpImrwV+Qse8
 sXRVpTfCJaDx4RcscCT7bjtDN6RNKEBsMoLfkFSHACefA4kcOMsRaJ3giDY3VNjf3hFAXhJ
 kx7hVz4Qz2X8JWEiyluNA==
UI-OutboundReport: notjunk:1;M01:P0:P3BsawNNay8=;+xiYRZlocGV+GWONzHa1pX0r/t8
 Wi/ASpwDnJD3uPQ98r30K82tbskb4KjR/7KjJS2Iv6O9qTvxLjKmAcS4Ax16dQyjlhb18FnRp
 i8ZAUhyEAYuBTFZfynngjcTQfz9AXfCHWC3l4oQ0BeKNCaUOSeK3946UCSCc3pk00KIpK9w3l
 Mi3CfrO1MIF8N5UBl+8jviTF8tU6Zn2XaCk3EI+QzcNCjIYGze3vLa+3BWXRhI0lx9T3NWM0Y
 u+YtBMkG/x2tqduoxaktu+eSQ5UNJY8zrkqknmDSqHdfC7FQRPHwu0s8ALA2SwfxrFTRnID5c
 iT8poZKt/AFMop6dsY9NC+U9dkpNg3ipnL/wceeFiXZ8u1WMLV1sjs7aAHs/NYzULsjK0lF/D
 B3A5EqY/Nf5wBWxSl0+zbRGMz7MbGLBoV3R3eZKEwYbqqfnVVMG3dXTHdmwhZB7AWI/0n/j3B
 Xq4g39WDvS8l5AlD9+8HgbkALFxy7T6DVY/h9soRIn0P6LOH0X/8wuyzINI8E1OujjU9uBRZZ
 PevOs679e6fELdza87OEZv/TIQuX98VtySBYul2IZINXexCSZaNupJWww8nrgD1EeCDYsHWEH
 LlpFE9RtnGtZ85c9XnNFIxN0o+e/T8fVo0vu9D2wKgVjIJyW5GLQqbnwPUrPs5ZLM6mcaXuwZ
 EJH3kA1V1PuzMrlb0RfjUqo3bz+CvQWTDeEStAPU3R0FYz3S3kjGU2LhKHK5hvwvccXhahRLH
 F+gnFAuDODfk/Jnuv423dBleOAVYz2bd22fiqFYNwX07dA+rB66tDoXMckKigIpkC5RivkHto
 1usjH2+/luR6i7NPSbs7E8RuJP92i3dvjyOVjWTZKbqeA=
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



Am 12=2E Juni 2024 04:41:39 MESZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>Hi Tom,
>
>On Tue, 11 Jun 2024 at 16:55, Tom Rini <trini@konsulko=2Ecom> wrote:
>>
>> On Tue, Jun 11, 2024 at 04:08:56PM -0600, Simon Glass wrote:
>> > Hi Tom,
>> >
>> > On Tue, 11 Jun 2024 at 15:01, Tom Rini <trini@konsulko=2Ecom> wrote:
>> > >
>> > > On Tue, Jun 11, 2024 at 12:52:22PM -0600, Simon Glass wrote:
>> > > > Hi Sughosh,
>> > > >
>> > > > On Fri, 7 Jun 2024 at 12:53, Sughosh Ganu <sughosh=2Eganu@linaro=
=2Eorg> wrote:
>> > > > >
>> > > > > With the move of the LMB structure to a persistent state, there=
 is no
>> > > > > need to declare the variable locally, and pass it as part of th=
e LMB
>> > > > > API's=2E Remove all local variable instances and change the API=
's
>> > > > > correspondingly=2E
>> > > > >
>> > > > > Signed-off-by: Sughosh Ganu <sughosh=2Eganu@linaro=2Eorg>
>> > > > > ---
>> > > > >  arch/arc/lib/cache=2Ec                 |   4 +-
>> > > > >  arch/arm/lib/stack=2Ec                 |   4 +-
>> > > > >  arch/arm/mach-apple/board=2Ec          |  17 ++-
>> > > > >  arch/arm/mach-snapdragon/board=2Ec     |  17 ++-
>> > > > >  arch/arm/mach-stm32mp/dram_init=2Ec    |   7 +-
>> > > > >  arch/arm/mach-stm32mp/stm32mp1/cpu=2Ec |   6 +-
>> > > > >  arch/m68k/lib/bootm=2Ec                |   7 +-
>> > > > >  arch/microblaze/lib/bootm=2Ec          |   4 +-
>> > > > >  arch/mips/lib/bootm=2Ec                |   9 +-
>> > > > >  arch/nios2/lib/bootm=2Ec               |   4 +-
>> > > > >  arch/powerpc/cpu/mpc85xx/mp=2Ec        |   4 +-
>> > > > >  arch/powerpc/include/asm/mp=2Eh        |   4 +-
>> > > > >  arch/powerpc/lib/bootm=2Ec             |  14 +-
>> > > > >  arch/riscv/lib/bootm=2Ec               |   4 +-
>> > > > >  arch/sh/lib/bootm=2Ec                  |   4 +-
>> > > > >  arch/x86/lib/bootm=2Ec                 |   4 +-
>> > > > >  arch/xtensa/lib/bootm=2Ec              |   4 +-
>> > > > >  board/xilinx/common/board=2Ec          |   7 +-
>> > > > >  boot/bootm=2Ec                         |  26 ++--
>> > > > >  boot/bootm_os=2Ec                      |   5 +-
>> > > > >  boot/image-board=2Ec                   |  32 ++---
>> > > > >  boot/image-fdt=2Ec                     |  29 ++---
>> > > > >  cmd/bdinfo=2Ec                         |   6 +-
>> > > > >  cmd/booti=2Ec                          |   2 +-
>> > > > >  cmd/bootz=2Ec                          |   2 +-
>> > > > >  cmd/load=2Ec                           |   7 +-
>> > > > >  drivers/iommu/apple_dart=2Ec           |   7 +-
>> > > > >  drivers/iommu/sandbox_iommu=2Ec        |  15 +--
>> > > > >  fs/fs=2Ec                              |   7 +-
>> > > > >  include/image=2Eh                      |  22 +---
>> > > > >  include/lmb=2Eh                        |  39 +++---
>> > > > >  lib/lmb=2Ec                            |  81 ++++++------
>> > > > >  net/tftp=2Ec                           |   5 +-
>> > > > >  net/wget=2Ec                           |   5 +-
>> > > > >  test/cmd/bdinfo=2Ec                    |   2 +-
>> > > > >  test/lib/lmb=2Ec                       | 187 +++++++++++++----=
----------
>> > > > >  36 files changed, 270 insertions(+), 333 deletions(-)
>> > > >
>> > > > This isn't necessary=2E=2E=2Eand it will make things harder=2E Yo=
u can have a
>> > > > global 'lmb' while still allowing passing a different pointer whe=
n
>> > > > needed=2E
>> > >
>> > > There's only one reservation checking system and list of known
>> > > reservations, keep in mind=2E
>> >
>> > There is only one driver model, too, but we use a pointer=2E It makes
>> > tests much easier=2E
>> >
>> > In fact I see elsewhere in this series that it causes problems with
>> > tests=2E Best to use a pointer so it is easy to update=2E
>>
>> Maybe? I worry that will lead to thinking that we still, like today,
>> have many LMB lists, rather than a single LMB list that everyone must
>> use=2E
>
>Do people worry about that with driver model?
>
>Also IMO there is only really one LMB list today=2E We create it at the
>start of bootm and then it is done when we boot=2E The file-loading
>stuff is what makes all this confusing=2E=2E=2Eand with bootstd that is
>under control as well=2E

As we have a command line interface bootstd is not the only case to consid=
er=2E We should not start making assumptions about the sequence of commands=
 entered manually=2E

Best regards

Heinrich

>
>At lot of this effort seems to be about dealing with random scripts
>which load things=2E We want to make sure we complain if something
>overlaps=2E But we should be making the bootstd case work nicely and
>doing things within that framework=2E Also EFI sort-of has its own
>thing, which it is very-much in control of=2E
>
>Overall I think this is a bit more subtle that just combining allocators=
=2E
>
>Regards,
>Simon
