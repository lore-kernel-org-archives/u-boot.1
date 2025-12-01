Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3320D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 18:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6890F83D0C;
	Mon,  1 Dec 2025 19:49:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O+wWGvNj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6D4D83D3D; Mon,  1 Dec 2025 19:49:12 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FEEC83CF3
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 19:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c7503c73b4so2662872a34.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 10:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764614947; x=1765219747; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NiB8e8CqwyWFhvqbMWDuCq367X0bvfjxQtiOgh+2Uqw=;
 b=O+wWGvNjiF301g4gkGveUtmFcpmIbR7E4mlMVMNjl+Uko6DzI2xpN45dgHaHuYXnOR
 dcVOoZlP2YCKSgBhw9TZWSn2uDs+/xPJPO9HVsE+YVrm6avWkFHcXGcsKTQXeO8YImHn
 WtWf1Z7lPfUg7Gecd9nwGQlJj+35NU6mGmGJ8OyV/pM4RViESn+2kppFa6EMdgMdwIph
 AimvDPrHA8471KWOpMu0Obp07Es3MwZjnGMWyPKAHtFq8TERsLGd947jaDBLpO5RI5IX
 5UbJPkmZEhOuSQt72T5bXTcAMfe6TcsEEoy0Jj6JYYTmoQJ4rF4EHYlEpn7lxBL2Dd+y
 YoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764614947; x=1765219747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NiB8e8CqwyWFhvqbMWDuCq367X0bvfjxQtiOgh+2Uqw=;
 b=k5qKbPfSwsa6TPL5R1WiUAsw7OHRDwcspbnv2vv56ktIHFjV2i0k77M30RhQecRx2r
 WHnXolHbinGsXcfLYXm4fzceH+4eSMa/uVuSTZ56QaD8Fb+9OZoT3GHbinE2AaejEGjw
 kr/BPmXwNqD+L7OUtgGRnymJC82OsUQIm0stozrZ5oVKrn2xkKjXVawXMQpB4Q6oliGZ
 38cADpJEMpms3Gljq7U5h67BUUiyug/gmAP+sGYuyuPwK8dA4q44ctVL2sh+Lhm+cIHv
 Hx92gFtIwAtBJBYIQqPB0WIjhK5KAsWmBnIA15BgAGx8O7GPpOrcVXLPb8eNScQQDDgR
 0B3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5rJ0mY6j8lwHhpJIUlbipSU0VHZelKqj735sK9Su3OfoEQ7GKSrnoSLT+WMlRZr/vd0zT+wg=@lists.denx.de
X-Gm-Message-State: AOJu0YylnE7thApY7yDAVkJA3gXi0rkUW6+wi3ED0uF112k0a4XTXa0x
 EwVbj7VmC7Fw2ysEieQUWzvlXSNJyjAzu2BTBz8DVlcjI2xxnFNWvQ//pXIs/Dz0UUZwM2tJIZ8
 At7TOBMngRk2ZwBGZuU5fLoP8urrC48k=
X-Gm-Gg: ASbGnctGOZah7VNYTspEJxfDDjfWPmpjG3YhPOFconRbBCAhIoEWTSkoN8Ip+o7b9MC
 iIW+b28P6DhTr0q9Yf5uC7jktxTqB6laHa3bt2fwCcUpzUzlkoUr7YeJkOC3GuFWLu6516ZmXBp
 +CqjvmTzMzQchOGqKd2pWxCwbgDHJvvt7njdWQT3FoLFOkDPFo3swkBvkYAcogM4UEMc+uTo8qs
 GzCfmBDm2r2ZyWuqlGlBo+NmvRCjXp4mZaWBZniD5n29x1yQjgB+jsi3gp9daany+fYPNQA
X-Google-Smtp-Source: AGHT+IEq4zhKF0VQ4H2qbOx8iqHXcnLbwdryXWNlzf/vwZmeNx38pR3C40AMQ6Uco1/pRBgS7PwRPclChttvtxK0m98=
X-Received: by 2002:a05:6830:915:b0:7c7:266:392d with SMTP id
 46e09a7af769-7c798fa32b1mr19314660a34.13.1764614946750; Mon, 01 Dec 2025
 10:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20251128164957.GD2125796@bill-the-cat>
 <CAN7C2SCpM4V3GL=_tox+9ePEx6DcVNK+pdfxn_ysiOyvYuEn+A@mail.gmail.com>
 <20251201164405.GG303283@bill-the-cat>
 <CAN7C2SBPwcPdUQeufJ+c3XxVKVmU4PE7nbYqLaNy9ynqkWhJgA@mail.gmail.com>
 <20251201165422.GI303283@bill-the-cat>
 <CAN7C2SBP7_kGmuXN2J5CF97ebxSpxtmtZ81_kGPjcV=_n-FyQw@mail.gmail.com>
 <20251201170938.GL303283@bill-the-cat>
 <CAN7C2SDmv=0gubdEy_ikENQWy47UGFa9JHv+E-QZO2GCZnz_Rw@mail.gmail.com>
 <20251201182729.GP303283@bill-the-cat>
 <CAN7C2SB6SbdFgBh9FaM0EWCO-WYNgfmNjYZE+_nMp40WQfz0pw@mail.gmail.com>
 <20251201183837.GR303283@bill-the-cat>
In-Reply-To: <20251201183837.GR303283@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 2 Dec 2025 02:48:56 +0800
X-Gm-Features: AWmQ_blhWJreUebebi3BUrjaX5vhGKVcd-3YTGEEbeb9LWjQkuMbKt5i2swB8KY
Message-ID: <CAN7C2SB8jvxuR_1j3Yx188L-OE_pSAQtSCV64YGTSMKF_PO+fw@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from empty
 built-in.a in SPL/TPL/VPL builds
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 u-boot@lists.denx.de, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tien Fong Chee <tien.fong.chee@intel.com>
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

Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=97=A5=
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:38=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Dec 02, 2025 at 02:37:42AM +0800, Sune Brian wrote:
> > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=97=
=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:27=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Dec 02, 2025 at 01:59:53AM +0800, Sune Brian wrote:
> > > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=
=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:09=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > >
> > > > >
> > > > > On Tue, Dec 02, 2025 at 01:07:00AM +0800, Sune Brian wrote:
> > > > > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=
=882=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:54=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > > >
> > > > > > > On Tue, Dec 02, 2025 at 12:52:06AM +0800, Sune Brian wrote:
> > > > > > > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=
=9C=882=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:44=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > > > > > > > >
> > > > > > > > > On Sat, Nov 29, 2025 at 08:46:14AM +0800, Sune Brian wrot=
e:
> > > > > > > > > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B411=
=E6=9C=8829=E6=97=A5=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:50=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Nov 28, 2025 at 06:44:12PM +0200, Ilias Apalo=
dimas wrote:
> > > > > > > > > > > > On Fri, 28 Nov 2025 at 17:31, Tom Rini <trini@konsu=
lko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, Nov 28, 2025 at 10:11:53AM +0800, Yuslaim=
i, Alif Zakuan wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On 27/11/2025 11:09 pm, Marek Vasut wrote:
> > > > > > > > > > > > > > > [CAUTION: This email is from outside your org=
anization. Unless you trust
> > > > > > > > > > > > > > > the sender, do not click on links or open att=
achments as it may be a
> > > > > > > > > > > > > > > fraudulent email attempting to steal your inf=
ormation and/or compromise
> > > > > > > > > > > > > > > your computer.]
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wr=
ote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Hello everyone,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I already have the referenced commit in my =
test branch, and I can
> > > > > > > > > > > > > > > > confirm that the same compilation error sti=
ll appears on CycloneV when
> > > > > > > > > > > > > > > > certain directories produce no SPL objects.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > The existing fix ensures that built-in.o is=
 always present, but it does
> > > > > > > > > > > > > > > > not prevent ar from generating empty built-=
in.a archives, which older
> > > > > > > > > > > > > > > > ARM 32-bit linkers (such as CycloneV toolch=
ains) reject as =E2=80=9Cfile
> > > > > > > > > > > > > > > > truncated=E2=80=9D.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Which toolchain is this ?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I am using Linaro arm-linux-gnueabihf GCC 7.5.0=
 to compile our SoC32 devices
> > > > > > > > > > > > > > - CycloneV and Arria10
> > > > > > > > > > > > >
> > > > > > > > > > > > > Ilias, do you recall the solution to this problem=
 from when it came up
> > > > > > > > > > > > > on IRC a few weeks ago?
> > > > > > > > > > > >
> > > > > > > > > > > > Nop unfortunately not.
> > > > > > > > > > > > Was this caused by the Kbuild bump? I remember the =
logic around
> > > > > > > > > > > > builtin changing significantly.
> > > > > > > > > > >
> > > > > > > > > > > Yes, and I kinda thought we narrowed it down to somet=
hing being missing
> > > > > > > > > > > from the update, since the kernel does support this o=
ld of a toolchain
> > > > > > > > > > > (or at least the 10.x? someone else this on).
> > > > > > > > > >
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > Actually I am not sure u-boot itself have minimum requi=
rement on each tag
> > > > > > > > > > or branch listed?
> > > > > > > > >
> > > > > > > > > We do not currently have a test for anything other than "=
newer than
> > > > > > > > > gcc-6" for ARM, but should have the same minimum requirem=
ents as the
> > > > > > > > > linux kernel, but are lacking enforcement checks (but I a=
lso think the
> > > > > > > > > kernel is?).
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Tom
> > > > > > > >
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > Oops, missing the kernel version. Add it back for better de=
bug.
> > > > > > >
> > > > > > > Sorry, what I meant was that it's a kbuild related issue as t=
o what
> > > > > > > version of gcc can be used. We don't have a check, and should=
, but also
> > > > > > > the versions in question here should be expected to work. The=
re's just
> > > > > > > some change we're missing.
> > > > > > >
> > > > > > > --
> > > > > > > Tom
> > > > > >
> > > > > > So long story short this patch itself should not introduce from=
 beginning.
> > > > > > It is a GCC version depended issue.
> > > > > > But how to pin-point down to which version is a bit hard.
> > > > > > Distro link with GCC version and not all gcc version can easily=
 checked.
> > > > > >
> > > > > > Any idea how to easily check this?
> > > > >
> > > > > We can use the check we have today in arch/arm/config.mk under
> > > > > "checkgcc6" to check for something much newer. But! It's a proble=
m of a
> > > > > missing kbuild change I think, based on when this problem was fir=
st
> > > > > reported.
> > > > >
> > > > > --
> > > > > Tom
> > > >
> > > > Tom,
> > > >
> > > > For GCC version sub-version do not matters?
> > > > For example 6.x.x 7.x.x 8.x.x
> > > > Or 9.3 9.4 etc also matters?
> > > > So to determine the supported version it just need to pin-point to
> > > > the major GCC version?
> > > > Then the possible version break only <=3D10 or <10?
> > > > Based on the previous build success case.
> > > > 9.2.0 fails 11.4.0 passed.
> > >
> > > Looking through logs now, I see the kernel says 8.1 or newer:
> > > https://www.kernel.org/doc/html/latest/process/changes.html which is =
why
> > > I have been saying there's an underlying kbuild problem (missing
> > > change(s)) that needs to be resolved. I don't know if 10.x works or
> > > fails, but that's still beside the point to me as 9.2.0 should work.
> > >
> > > --
> > > Tom
> >
> > Do this apply to arm-linux-gnueabihf-gcc ?
> > Or the 8.1 is apply to base gcc not cross-compile?
> > Just want to confirm.
>
> Yes, it's gcc 8.1 regardless of if it's a cross compiler or not.
>
> --
> Tom

I guess simply use local prebuild test is fastest [1].
But this is still interesting that two VM also used 18.04 failed before.
So I just do a simply test.

arm-linux-gnueabihf-gcc (GNU Toolchain for the A-profile Architecture
8.2-2018-08 (arm-rel-8.23)) 8.2.1 20180802
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

arch/arm/cpu/built-in.a: file not recognized: File truncated
scripts/Makefile.xpl:542: recipe for target 'spl/u-boot-spl' failed
make[1]: *** [spl/u-boot-spl] Error 1
Makefile:2358: recipe for target 'spl/u-boot-spl' failed
make: *** [spl/u-boot-spl] Error 2

Brian

[1] https://developer.arm.com/downloads/-/gnu-a
