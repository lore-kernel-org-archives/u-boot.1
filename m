Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D57BD116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 19:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B23EC83D17;
	Mon,  1 Dec 2025 20:10:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N0YGYgR7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C446583D4A; Mon,  1 Dec 2025 20:10:39 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BB7883B63
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 20:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c6da5e3353so2714329a34.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 11:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764616236; x=1765221036; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+Le9oQgJefWJpKPSRhjAIPD31VrorW24eJS1ZqiUA8=;
 b=N0YGYgR7lEQiU7EQ74VuE+mAgvyvY7Bm/hnb8/mvGo2rD6IzUndzHN4wOe/4qHQRNg
 WMmfY19rxDCElf+Vu3zqYGMWH4f20EeZuoYfoPsFhDcF7q5is3uiKnYpEJ9FbJFTkOzr
 L00NAsD8/BqiktZeiUjRYeYKC3QxtOjmQZLmx4ahTLkOR3FX3Di3jXIBQmyyM3/r3SAx
 bihEteWm3Q0Q3iPLhZL4SVE7h4w/el2rhw0N7bN6OZvMF+akedyXDPHxdbIhQFNe641F
 Ch+uF1kZADdoW7d1aONVfsJdswyKp0ysU44xUJKkySOdO1/gTQ4wdIw11H/H4ZN7+l5e
 daVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764616236; x=1765221036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/+Le9oQgJefWJpKPSRhjAIPD31VrorW24eJS1ZqiUA8=;
 b=L8p1dGKFjMqHlYZHeHqP1M9b7tXJoccWSBW3jjviqxGYXh/nxYOt4kZCOULlFfXpMW
 UmsrsWyHdoJ5QPkIi695LkO23yjwQ0Nr1k8WvcraVV75McBI8FF1T3b4NcP4S7w7Rxh+
 oyovcBxbbRXtID8LrEPW6+fRZjj0gnwRiJGqi/EiIady5pTy6aWR7wwmEWJGxXKheYW0
 SaMZFvpAXCVwOU8NAXFdJE7phX1JL67rMylWmG3PiJzNdjUcOz9gWIQkK/TZkD+yTKYg
 FoienKFR2TVXEJM4JrDt6VVMd4z2NgbMw76Pskn+6mHvmMTws0MyCdAENIY1zwMuiwCr
 JHXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmHafYzHcPthEgMZtYpIVHqcbqHc/RgVqXqYKygXA0EbGxVW0BaFdfugxIkXW7Pb/h/R6ktpE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw84SrjBlcUatMfz9vqCTs9kwCCUvgbVzsKwj6H6mL/QFC1R7dY
 CSfNHnYp3Xq5S7DJB39N3jSCQ3GjY7zpvR6iM/KCf09Nn70YbuC1fLKii90UzgAbEN7qcSHkyU5
 fuG9aFnBESh2vNp32I8pCzFl8wj3JWuw=
X-Gm-Gg: ASbGncut4iy2fN/PFDAMTiqVVRM5/9+c3YMWqGzNV7LiVp3AAM/7GNwEC73wpRhgTFr
 rLF848jpIblAq25edHxJkQJ6L2GnoBpb3LCtnWb3hi+rpFZ0AsqbPb0jRB5+k1RwyQPPHaC97NV
 fU0MkKfWueVOFuIQf7INsIeoj2t0HlTlsehAMxPD6bxVccS/1gUaDIECDqUpG++XkO//MX5SfEK
 35/a/O9tVbP3eOyQCWAnpj+QWwl2b68ROtHEHOWVJ7gM7IhtoZFqQIBOJT/rqQ/uA4YnHZjAuWF
 6DChnwg=
X-Google-Smtp-Source: AGHT+IFVFeVPtQgyumIAE/UuG5L5XDQT0mOkWaM5AOR4wfMVcxCQ2aGla9noqoGQj3VoO/GS3fhSYvm5eJgEeEBmXO4=
X-Received: by 2002:a05:6830:34a1:b0:7c7:b4e:edb4 with SMTP id
 46e09a7af769-7c7c40a8380mr17637928a34.8.1764616235686; Mon, 01 Dec 2025
 11:10:35 -0800 (PST)
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
Date: Tue, 2 Dec 2025 03:10:24 +0800
X-Gm-Features: AWmQ_bmabAhjttFEtNnmL9ECFUquG0vUUsTa08FeNC05dH1UclvkdW2wyiJCw50
Message-ID: <CAN7C2SBKYS+PhNpvhq0cga_PRan6DE3mEXGXmaa=MiUjNbU8EA@mail.gmail.com>
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

Long story short:

arm-none-linux-gnueabihf-gcc (GNU Toolchain for the A-profile
Architecture 10.2-2020.11 (arm-10.16)) 10.2.1 20201103
Copyright (C) 2020 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

  SYM     spl/u-boot-spl.sym
  CAT     spl/u-boot-spl-dtb.bin
  COPY    spl/u-boot-spl.bin
  MKIMAGE spl/u-boot-spl.sfp
  GENSPLX4 spl/u-boot-splx4.sfp
  SOCBOOT u-boot-with-spl.sfp
  OFCHK   .config

arm-linux-gnueabihf-gcc (Ubuntu 10-20200411-0ubuntu1) 10.0.1 20200411
(experimental) [master revision
bb87d5cc77d:75961caccb7:f883c46b4877f637e0fa5025b4d6b5c9040ec566]
Copyright (C) 2020 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

  LD      spl/u-boot-spl
  OBJCOPY spl/u-boot-spl-nodtb.bin
  SYM     spl/u-boot-spl.sym
  CAT     spl/u-boot-spl-dtb.bin
  COPY    spl/u-boot-spl.bin
  MKIMAGE spl/u-boot-spl.sfp
  GENSPLX4 spl/u-boot-splx4.sfp
  SOCBOOT u-boot-with-spl.sfp
  OFCHK   .config

arm-none-linux-gnueabihf-ld: arch/arm/cpu/built-in.a: file not
recognized: file truncated
scripts/Makefile.xpl:542: recipe for target 'spl/u-boot-spl' failed
make[1]: *** [spl/u-boot-spl] Error 1
Makefile:2358: recipe for target 'spl/u-boot-spl' failed
make: *** [spl/u-boot-spl] Error 2

arm-none-linux-gnueabihf-gcc (GNU Toolchain for the A-profile
Architecture 9.2-2019.12 (arm-9.10)) 9.2.1 20191025
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

So 10.0.1 should be good enough.

Brian
