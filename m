Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6BAD116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 18:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8936783D0D;
	Mon,  1 Dec 2025 19:00:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bMkzlzkK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 933D083D03; Mon,  1 Dec 2025 19:00:09 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0DAD803F5
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 19:00:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c6dbdaced8so2963662a34.1
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 10:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764612004; x=1765216804; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0EvWGdJmL7g+9kVC7xj0lp1+HeLi4LXG3yoBqYTLMww=;
 b=bMkzlzkKyc59Jq/ST21ovkqGVS7nuzxCC3v/dtce+qDMHXm7vMaZ/D9pNrHmG9dKm7
 9apJIQciLCkGVVHoFEW+ASE3Pi7ajK4mHN2EL0iuiI8CHQdPMOK10Rv0joPUZZn9oKnB
 I8rJLQsW0MFyAExy6jdgjpkLXzNp5Lsr7k+nOmgUkIAdjXnsLmTNX/D7Jq7pqSjviMeg
 EoVqB3oaHPiM5YvEDQJLLEbh/GtcRqZz3CZz8O9FU7/nPynZ3IIHcCPxPbQT/et5PKog
 S0BZGRYMn2K576XKNl3OgwS7wEESqYicHtL4clwmvSKjdy6xyCdTZVikjvzdWa17Zc7D
 eNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764612004; x=1765216804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0EvWGdJmL7g+9kVC7xj0lp1+HeLi4LXG3yoBqYTLMww=;
 b=VBE6UOkzcz8vJR094mlJZUMxem7M4C5tJkre//HWKTv3Ye0S14lrLZ6EfblNI29x0g
 DuDpM/xRuq9699s7It0WFPjEklHIriZnjMGgk58bO9HJbRh3dwCT31PWaGkhVqSq6L7z
 r0SfH39j5kJmsr4jcQJyb6rAW3XQmFOwZc0/2kzDGIy4zY/sybNbCXGy2LqvDtuHKTSV
 Vj48eAFlK6FS+4d1pkOZjymFGweW8Eiyx94dXzsbNOcszXDV4/Ce8fIyKC5CO0AIh/s1
 AmdiRJwOGW9vBlYAD/L8PSs+6nqhlT3BXsw7OtYZLfo1oS5V4Y2x9koRoccepQn7WWv2
 VOuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUllDRo5JufZlycOklgTzX2qBqQ5l+IyLibRAV3FjplzkzwxbuYSlg6mqdIhucmV5ETiwrM7hE=@lists.denx.de
X-Gm-Message-State: AOJu0YxxQgOHzMvuX3lyeQV5ozNiLXiyjqN8oZSdyHWFway8de8JlXqA
 AMuoie1OgS2MYl0kGubWdRdzp3NX7crNJAeaiFTeBDoF76sKVS8KljWZODlddxp9t2uVRCMtxkO
 J4OTwcdF5kQTgWOyfJVRA0JuonZLiSak=
X-Gm-Gg: ASbGncu1w4fIze4OdR9ZzMAIKWy6iS69gFlyaFEpfDZ8X+6fh1zHE7QdEFECTKrvUQ0
 13brHIaET+ivXuBmbJqZM1ZnJJcer+SR3DgZj3Mf7DiEigrhT94HGdwlq+L7MRS1pQ86gmBkgYQ
 VmFMUZEzHqXz3wH/V8umweWrwrwYheMzl6QxTFgkq1NmXGyrq/Md69HnShVcXM0fH8AtmHim7b1
 tj9zEGOgaTGNJgYxtKMGgi1VSZjGLD4JsIsA+g/yXfA5iUk2Wz1lBxuzm390O+6KolHerKi8ctK
 9mJhhjQ=
X-Google-Smtp-Source: AGHT+IGei9dNwPtEHnKyOX8Iku73B9uGzD6IKsSQTRNE0sCD+C+rpNTMrv8TPUwUdlw69GKtVWELZg1vizVwlJiF8gE=
X-Received: by 2002:a05:6830:34a7:b0:7b4:1768:ff3b with SMTP id
 46e09a7af769-7c7c4466f4fmr12221641a34.22.1764612004040; Mon, 01 Dec 2025
 10:00:04 -0800 (PST)
MIME-Version: 1.0
References: <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
 <f13e8fd9-9705-46ec-a2c4-9fc4c6a63e38@altera.com>
 <20251128153130.GC2125796@bill-the-cat>
 <CAC_iWjKp1ztEW23e7rujk-oFuYS_qfMi+CF+VEdwcCHmXrtgkg@mail.gmail.com>
 <20251128164957.GD2125796@bill-the-cat>
 <CAN7C2SCpM4V3GL=_tox+9ePEx6DcVNK+pdfxn_ysiOyvYuEn+A@mail.gmail.com>
 <20251201164405.GG303283@bill-the-cat>
 <CAN7C2SBPwcPdUQeufJ+c3XxVKVmU4PE7nbYqLaNy9ynqkWhJgA@mail.gmail.com>
 <20251201165422.GI303283@bill-the-cat>
 <CAN7C2SBP7_kGmuXN2J5CF97ebxSpxtmtZ81_kGPjcV=_n-FyQw@mail.gmail.com>
 <20251201170938.GL303283@bill-the-cat>
In-Reply-To: <20251201170938.GL303283@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 2 Dec 2025 01:59:53 +0800
X-Gm-Features: AWmQ_blCd-KmRslhld6JDgULwum_Kct44Fp9z8m3M93snvsCNAkuLV1mJjCuFX0
Message-ID: <CAN7C2SDmv=0gubdEy_ikENQWy47UGFa9JHv+E-QZO2GCZnz_Rw@mail.gmail.com>
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
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:09=E5=AF=AB=E9=81=93=EF=BC=9A

>
> On Tue, Dec 02, 2025 at 01:07:00AM +0800, Sune Brian wrote:
> > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=97=
=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:54=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Dec 02, 2025 at 12:52:06AM +0800, Sune Brian wrote:
> > > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=
=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:44=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > > >
> > > > > On Sat, Nov 29, 2025 at 08:46:14AM +0800, Sune Brian wrote:
> > > > > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B411=E6=9C=
=8829=E6=97=A5=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:50=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > > >
> > > > > > > On Fri, Nov 28, 2025 at 06:44:12PM +0200, Ilias Apalodimas wr=
ote:
> > > > > > > > On Fri, 28 Nov 2025 at 17:31, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Nov 28, 2025 at 10:11:53AM +0800, Yuslaimi, Alif =
Zakuan wrote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > On 27/11/2025 11:09 pm, Marek Vasut wrote:
> > > > > > > > > > > [CAUTION: This email is from outside your organizatio=
n. Unless you trust
> > > > > > > > > > > the sender, do not click on links or open attachments=
 as it may be a
> > > > > > > > > > > fraudulent email attempting to steal your information=
 and/or compromise
> > > > > > > > > > > your computer.]
> > > > > > > > > > >
> > > > > > > > > > > On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hello everyone,
> > > > > > > > > > >
> > > > > > > > > > > > I already have the referenced commit in my test bra=
nch, and I can
> > > > > > > > > > > > confirm that the same compilation error still appea=
rs on CycloneV when
> > > > > > > > > > > > certain directories produce no SPL objects.
> > > > > > > > > > > >
> > > > > > > > > > > > The existing fix ensures that built-in.o is always =
present, but it does
> > > > > > > > > > > > not prevent ar from generating empty built-in.a arc=
hives, which older
> > > > > > > > > > > > ARM 32-bit linkers (such as CycloneV toolchains) re=
ject as =E2=80=9Cfile
> > > > > > > > > > > > truncated=E2=80=9D.
> > > > > > > > > > >
> > > > > > > > > > > Which toolchain is this ?
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I am using Linaro arm-linux-gnueabihf GCC 7.5.0 to comp=
ile our SoC32 devices
> > > > > > > > > > - CycloneV and Arria10
> > > > > > > > >
> > > > > > > > > Ilias, do you recall the solution to this problem from wh=
en it came up
> > > > > > > > > on IRC a few weeks ago?
> > > > > > > >
> > > > > > > > Nop unfortunately not.
> > > > > > > > Was this caused by the Kbuild bump? I remember the logic ar=
ound
> > > > > > > > builtin changing significantly.
> > > > > > >
> > > > > > > Yes, and I kinda thought we narrowed it down to something bei=
ng missing
> > > > > > > from the update, since the kernel does support this old of a =
toolchain
> > > > > > > (or at least the 10.x? someone else this on).
> > > > > >
> > > > > > Hi Tom,
> > > > > >
> > > > > > Actually I am not sure u-boot itself have minimum requirement o=
n each tag
> > > > > > or branch listed?
> > > > >
> > > > > We do not currently have a test for anything other than "newer th=
an
> > > > > gcc-6" for ARM, but should have the same minimum requirements as =
the
> > > > > linux kernel, but are lacking enforcement checks (but I also thin=
k the
> > > > > kernel is?).
> > > > >
> > > > > --
> > > > > Tom
> > > >
> > > > Hi Tom,
> > > >
> > > > Oops, missing the kernel version. Add it back for better debug.
> > >
> > > Sorry, what I meant was that it's a kbuild related issue as to what
> > > version of gcc can be used. We don't have a check, and should, but al=
so
> > > the versions in question here should be expected to work. There's jus=
t
> > > some change we're missing.
> > >
> > > --
> > > Tom
> >
> > So long story short this patch itself should not introduce from beginni=
ng.
> > It is a GCC version depended issue.
> > But how to pin-point down to which version is a bit hard.
> > Distro link with GCC version and not all gcc version can easily checked=
.
> >
> > Any idea how to easily check this?
>
> We can use the check we have today in arch/arm/config.mk under
> "checkgcc6" to check for something much newer. But! It's a problem of a
> missing kbuild change I think, based on when this problem was first
> reported.
>
> --
> Tom

Tom,

For GCC version sub-version do not matters?
For example 6.x.x 7.x.x 8.x.x
Or 9.3 9.4 etc also matters?
So to determine the supported version it just need to pin-point to
the major GCC version?
Then the possible version break only <=3D10 or <10?
Based on the previous build success case.
9.2.0 fails 11.4.0 passed.

Brian
