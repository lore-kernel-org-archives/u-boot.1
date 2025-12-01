Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F423D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 18:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B573C83D2E;
	Mon,  1 Dec 2025 19:37:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b3npBnFW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B0D283D39; Mon,  1 Dec 2025 19:37:57 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3773A83D18
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 19:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c6d13986f8so3169282a34.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 10:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764614273; x=1765219073; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftQhBnx4TJ7gcFJJ993PNPFMiffU91fD6Vbi6xMTkPo=;
 b=b3npBnFWEXhn7m28cMJ7vDc9nTqzto4ILc0VIanOpEkIv0bAvpt9zpz5GCtNJCqPz/
 BLaJKeNLwyB+Kw5yIfwkJq/Uq+GUBf48sb7tUEEsWGi584Fik/0nVfeWZrUrIRhRbcIj
 K+MjLcBMr3pZ/IUCgSTX7Khk72nD06080sp6GhN5T+m4VXbgS5bDZzHEVb0soeJeDKRU
 9XkTEaKx28tDaLtKwBCY+gIcbCmgCdVPPdYvQuPspLMoFx/0kAlLfnYRtTS0Aoa0GDU3
 oIcVc5U8YhoIdpKRHnjNNHG37NwQMVzu+wssETti+ijbqg/UD4V+NgKt92wa+w9mOf7N
 44vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764614273; x=1765219073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ftQhBnx4TJ7gcFJJ993PNPFMiffU91fD6Vbi6xMTkPo=;
 b=paXEnXnOINGZLm/UM2aP8VfhHoxbvn1AHHBFVyluOhDcPs3wNzo7baqizR4shGx0Y2
 2c1G4bawELfZf4NwqRyioBvSDS8nZOeEOGFPqE6WOpCzLmw5H/gMi8K2AbV1FOutkSlD
 dR1k+Wfz4C/IXhHFlgMH1MH1120c1vwfzWknAlT2LjKGyWDAEy4XS5kkgu1Fxo3gra3v
 iu7gfSpRc7oonpJxJR+bzhYw6LJas328Mb/VFwhgpFbpC0zSOplU0vs+ofkKxeBzz6HC
 OnFmjLuIgoKL4GPWPr2hVo7yOtBb+cC2XvPMCazpHI6MTBCpQE/A1ExfOc/BDQEm5fmA
 k3kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiT2DtbzSqr3GvjWHhDi7O5L5rzGD4P3H9QTxQcsY3hnL+X1JiIW+pv0Ig/q9jCqaCHrStbJU=@lists.denx.de
X-Gm-Message-State: AOJu0YxPht9LB5NRau8P4E/th5Uzt1OtjkLXUlJZPI7BrLLWAi5CeAR9
 kBz7FqNsY27geaopB8cfYspOgTZrwB/00yt+ZFNRpRPES7XY1xmGWxCJW2e5pefniKo0/ZO5xx9
 usZZq2iBla2+e8uZhmAix/YgB0bLiHl4=
X-Gm-Gg: ASbGncu5XU6y7vbNPKk5h9U9L+1LdE8lVt0bQNpVq7U1qEsB1w1va6VczCpbtPHWVnx
 uQiZKg5qHGZkLqJyZcZo1Fy2WCCcsepM8JTEwm35g3JtZe/1yKdHd4e3uu24Nz6exGTRlijBHEO
 bUQWqhfDPx609AS5hXyLSbolyCyRcLMePooyvFsuzFn1+x+MvbcplXgcaFReMnnMnQNs21ywcoA
 6Q0GYIbj57Xe/NKKyhXR2Mktlxw3/A8RJ6YM/gUI73ePqka+paV2dIfSOr4oZZ2k4PrR0TF
X-Google-Smtp-Source: AGHT+IGnzsHpF5KsMBCH/J00YlqCUjvFmX0PZtqxfZB+oUllcYgUQ2JXTrRp9wgZUjx8oWsrftjuOjYFw9KEQSNkDPg=
X-Received: by 2002:a05:6830:2b1e:b0:79e:7e5e:7c63 with SMTP id
 46e09a7af769-7c798ba4d5emr24081314a34.14.1764614272894; Mon, 01 Dec 2025
 10:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20251128153130.GC2125796@bill-the-cat>
 <CAC_iWjKp1ztEW23e7rujk-oFuYS_qfMi+CF+VEdwcCHmXrtgkg@mail.gmail.com>
 <20251128164957.GD2125796@bill-the-cat>
 <CAN7C2SCpM4V3GL=_tox+9ePEx6DcVNK+pdfxn_ysiOyvYuEn+A@mail.gmail.com>
 <20251201164405.GG303283@bill-the-cat>
 <CAN7C2SBPwcPdUQeufJ+c3XxVKVmU4PE7nbYqLaNy9ynqkWhJgA@mail.gmail.com>
 <20251201165422.GI303283@bill-the-cat>
 <CAN7C2SBP7_kGmuXN2J5CF97ebxSpxtmtZ81_kGPjcV=_n-FyQw@mail.gmail.com>
 <20251201170938.GL303283@bill-the-cat>
 <CAN7C2SDmv=0gubdEy_ikENQWy47UGFa9JHv+E-QZO2GCZnz_Rw@mail.gmail.com>
 <20251201182729.GP303283@bill-the-cat>
In-Reply-To: <20251201182729.GP303283@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 2 Dec 2025 02:37:42 +0800
X-Gm-Features: AWmQ_bn8vd9HIe0_6RJ2udG0J7lh7B-WMX4_GcNPPrD4-9rl7otOZi4nfQGiLyk
Message-ID: <CAN7C2SB6SbdFgBh9FaM0EWCO-WYNgfmNjYZE+_nMp40WQfz0pw@mail.gmail.com>
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
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:27=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Dec 02, 2025 at 01:59:53AM +0800, Sune Brian wrote:
> > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=97=
=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:09=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > >
> > > On Tue, Dec 02, 2025 at 01:07:00AM +0800, Sune Brian wrote:
> > > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=
=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:54=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > > >
> > > > > On Tue, Dec 02, 2025 at 12:52:06AM +0800, Sune Brian wrote:
> > > > > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=
=882=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:44=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > > >
> > > > > > > On Sat, Nov 29, 2025 at 08:46:14AM +0800, Sune Brian wrote:
> > > > > > > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B411=E6=
=9C=8829=E6=97=A5=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:50=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > > > > > > > >
> > > > > > > > > On Fri, Nov 28, 2025 at 06:44:12PM +0200, Ilias Apalodima=
s wrote:
> > > > > > > > > > On Fri, 28 Nov 2025 at 17:31, Tom Rini <trini@konsulko.=
com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Nov 28, 2025 at 10:11:53AM +0800, Yuslaimi, A=
lif Zakuan wrote:
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > On 27/11/2025 11:09 pm, Marek Vasut wrote:
> > > > > > > > > > > > > [CAUTION: This email is from outside your organiz=
ation. Unless you trust
> > > > > > > > > > > > > the sender, do not click on links or open attachm=
ents as it may be a
> > > > > > > > > > > > > fraudulent email attempting to steal your informa=
tion and/or compromise
> > > > > > > > > > > > > your computer.]
> > > > > > > > > > > > >
> > > > > > > > > > > > > On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hello everyone,
> > > > > > > > > > > > >
> > > > > > > > > > > > > > I already have the referenced commit in my test=
 branch, and I can
> > > > > > > > > > > > > > confirm that the same compilation error still a=
ppears on CycloneV when
> > > > > > > > > > > > > > certain directories produce no SPL objects.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The existing fix ensures that built-in.o is alw=
ays present, but it does
> > > > > > > > > > > > > > not prevent ar from generating empty built-in.a=
 archives, which older
> > > > > > > > > > > > > > ARM 32-bit linkers (such as CycloneV toolchains=
) reject as =E2=80=9Cfile
> > > > > > > > > > > > > > truncated=E2=80=9D.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Which toolchain is this ?
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > I am using Linaro arm-linux-gnueabihf GCC 7.5.0 to =
compile our SoC32 devices
> > > > > > > > > > > > - CycloneV and Arria10
> > > > > > > > > > >
> > > > > > > > > > > Ilias, do you recall the solution to this problem fro=
m when it came up
> > > > > > > > > > > on IRC a few weeks ago?
> > > > > > > > > >
> > > > > > > > > > Nop unfortunately not.
> > > > > > > > > > Was this caused by the Kbuild bump? I remember the logi=
c around
> > > > > > > > > > builtin changing significantly.
> > > > > > > > >
> > > > > > > > > Yes, and I kinda thought we narrowed it down to something=
 being missing
> > > > > > > > > from the update, since the kernel does support this old o=
f a toolchain
> > > > > > > > > (or at least the 10.x? someone else this on).
> > > > > > > >
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > Actually I am not sure u-boot itself have minimum requireme=
nt on each tag
> > > > > > > > or branch listed?
> > > > > > >
> > > > > > > We do not currently have a test for anything other than "newe=
r than
> > > > > > > gcc-6" for ARM, but should have the same minimum requirements=
 as the
> > > > > > > linux kernel, but are lacking enforcement checks (but I also =
think the
> > > > > > > kernel is?).
> > > > > > >
> > > > > > > --
> > > > > > > Tom
> > > > > >
> > > > > > Hi Tom,
> > > > > >
> > > > > > Oops, missing the kernel version. Add it back for better debug.
> > > > >
> > > > > Sorry, what I meant was that it's a kbuild related issue as to wh=
at
> > > > > version of gcc can be used. We don't have a check, and should, bu=
t also
> > > > > the versions in question here should be expected to work. There's=
 just
> > > > > some change we're missing.
> > > > >
> > > > > --
> > > > > Tom
> > > >
> > > > So long story short this patch itself should not introduce from beg=
inning.
> > > > It is a GCC version depended issue.
> > > > But how to pin-point down to which version is a bit hard.
> > > > Distro link with GCC version and not all gcc version can easily che=
cked.
> > > >
> > > > Any idea how to easily check this?
> > >
> > > We can use the check we have today in arch/arm/config.mk under
> > > "checkgcc6" to check for something much newer. But! It's a problem of=
 a
> > > missing kbuild change I think, based on when this problem was first
> > > reported.
> > >
> > > --
> > > Tom
> >
> > Tom,
> >
> > For GCC version sub-version do not matters?
> > For example 6.x.x 7.x.x 8.x.x
> > Or 9.3 9.4 etc also matters?
> > So to determine the supported version it just need to pin-point to
> > the major GCC version?
> > Then the possible version break only <=3D10 or <10?
> > Based on the previous build success case.
> > 9.2.0 fails 11.4.0 passed.
>
> Looking through logs now, I see the kernel says 8.1 or newer:
> https://www.kernel.org/doc/html/latest/process/changes.html which is why
> I have been saying there's an underlying kbuild problem (missing
> change(s)) that needs to be resolved. I don't know if 10.x works or
> fails, but that's still beside the point to me as 9.2.0 should work.
>
> --
> Tom

Do this apply to arm-linux-gnueabihf-gcc ?
Or the 8.1 is apply to base gcc not cross-compile?
Just want to confirm.

Brian
