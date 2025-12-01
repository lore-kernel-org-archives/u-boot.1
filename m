Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63CFD116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3715383C8C;
	Mon,  1 Dec 2025 18:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LYqTfnEN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC7E183C8C; Mon,  1 Dec 2025 18:07:14 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9519683C29
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c7aee74dceso1258326a34.2
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764608831; x=1765213631; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YY3GVOCDbvTL906jiXzuSQLRSHovXeC4i67M0HNLuBY=;
 b=LYqTfnENiuHDyaUfMitJnAxmCUvoWYAOCMZ21bUHGh8zAc6tJRQHMkXyUmU/2Vj4mr
 IeE3fElDtLzzYJrlxixQHvZFRG1XUPCt+gD3BPwW7SsQGiYOHjAntd7lE7WO+HmgHLs1
 K5dpx4Q6l39gdzaOP7F4hXcMteMjkuIDP438LPMiiFp/O+TNdujFWYAKynGmlmWdsqdT
 YP/ZF5y5uCMW93XrI0VmSC1eFkHiJoZd/TTq5ZuYdGmGXY7ETiwP5VK3b5SfJELijsWe
 r+usELI0udQ5MFfnByoJXpWTKcKx6VH2/mEtCDJmnnmEKRiBDDbm70XgkaJOm0EIBHv7
 sOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764608831; x=1765213631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YY3GVOCDbvTL906jiXzuSQLRSHovXeC4i67M0HNLuBY=;
 b=BbJl0Yt5bE1JZM/J26g38QHPGUagEAQIHLVVGKMBtL6spnie5gUSFODNDhL1jQK/yi
 E7cUmoKj6tk9eQ2+8u3t0VRu5LSn8EQAmiJX0MNNDNDVtZX5h08xfpRN0Sj3JOxWrxYL
 4tmQMIm54Kui4DkqEMgZt4ajFOkW1xKfCl0MCrC8pXSd2jBmIDGgmjuObyvE8Rh0Cy/7
 7MXWfsg34cj4xg64HrvPCVgPejHYLxxtPCvaoAuwgV22kVMV893RXdSnZjB5sbj6M8vZ
 5YwhLAojETf4tGC7QdYEcOJlddAym197WwPirR+L5PILcy+5uE5jPQrvxq3jaddYSUHG
 TWiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfIhHKMv4fPS8S6ezR6ucbZVXQFT+mpK4MXTmeTCZUbFFdfzGywEriN7F8OYa4Qekx+r7Rh4g=@lists.denx.de
X-Gm-Message-State: AOJu0YxeyGNUn27NP2UhmwSROxUbJ7+nnl36+Y4jh+8QzHxCp9B3mbPy
 vUq7NBSIyJucyLKB7yWJxCCCmT2K+Jvnp3fmPQS1KYq0/gPB6HTOpqb5GuHfwk/OdlHHozvIBBW
 qOqa0/G8ZxlJbioofXL8BK+3eYp73xnk=
X-Gm-Gg: ASbGncvRz23dM1oSR6ffSlL6ndFrUo4IR9+MgY69clki7hzX0swNhhiBTREqah5TcX3
 5WYZhsBOZPk30xuyOtu74/uOvqIhEYn0vdCHNc6LtGpUrYE4UIlebylkXoi61Jc+5957k5tGRj9
 uTRIOrVYdnqguBWc3Eb1hpnjlsY/fK2JJQEPLtxI5jejIapQ63q/ICztk2DuipmEN88/DlIUvf/
 WhoyyemIuS8LjQy5+iXoaCQU6y1TlOI4nX0sOCNWyApL8OejQsFDhkwFE72Pi0SRPiseVGk
X-Google-Smtp-Source: AGHT+IH4gNnD4iTygfXDUv1p6bUYSTecHPpTMQr3Xu+neC+2hcY+FKy694o2m4x3DlpMOSaTRm7gHdxY4Arn4T8vB1o=
X-Received: by 2002:a9d:6153:0:b0:7c7:638a:8100 with SMTP id
 46e09a7af769-7c799098bcamr19249021a34.32.1764608830972; Mon, 01 Dec 2025
 09:07:10 -0800 (PST)
MIME-Version: 1.0
References: <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
 <19c33d9d-4cab-4add-9dff-f3b9e051f146@altera.com>
 <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
 <f13e8fd9-9705-46ec-a2c4-9fc4c6a63e38@altera.com>
 <20251128153130.GC2125796@bill-the-cat>
 <CAC_iWjKp1ztEW23e7rujk-oFuYS_qfMi+CF+VEdwcCHmXrtgkg@mail.gmail.com>
 <20251128164957.GD2125796@bill-the-cat>
 <CAN7C2SCpM4V3GL=_tox+9ePEx6DcVNK+pdfxn_ysiOyvYuEn+A@mail.gmail.com>
 <20251201164405.GG303283@bill-the-cat>
 <CAN7C2SBPwcPdUQeufJ+c3XxVKVmU4PE7nbYqLaNy9ynqkWhJgA@mail.gmail.com>
 <20251201165422.GI303283@bill-the-cat>
In-Reply-To: <20251201165422.GI303283@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 2 Dec 2025 01:07:00 +0800
X-Gm-Features: AWmQ_bmT2VYUOdqrgAMwd5WMuxvDP7T7Mzo6kczWrlEVwESfsoQSNJquptq34Yw
Message-ID: <CAN7C2SBP7_kGmuXN2J5CF97ebxSpxtmtZ81_kGPjcV=_n-FyQw@mail.gmail.com>
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
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:54=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Dec 02, 2025 at 12:52:06AM +0800, Sune Brian wrote:
> > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=97=
=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:44=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Sat, Nov 29, 2025 at 08:46:14AM +0800, Sune Brian wrote:
> > > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B411=E6=9C=8829=
=E6=97=A5=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:50=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > > >
> > > > > On Fri, Nov 28, 2025 at 06:44:12PM +0200, Ilias Apalodimas wrote:
> > > > > > On Fri, 28 Nov 2025 at 17:31, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Fri, Nov 28, 2025 at 10:11:53AM +0800, Yuslaimi, Alif Zaku=
an wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > On 27/11/2025 11:09 pm, Marek Vasut wrote:
> > > > > > > > > [CAUTION: This email is from outside your organization. U=
nless you trust
> > > > > > > > > the sender, do not click on links or open attachments as =
it may be a
> > > > > > > > > fraudulent email attempting to steal your information and=
/or compromise
> > > > > > > > > your computer.]
> > > > > > > > >
> > > > > > > > > On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrote:
> > > > > > > > >
> > > > > > > > > Hello everyone,
> > > > > > > > >
> > > > > > > > > > I already have the referenced commit in my test branch,=
 and I can
> > > > > > > > > > confirm that the same compilation error still appears o=
n CycloneV when
> > > > > > > > > > certain directories produce no SPL objects.
> > > > > > > > > >
> > > > > > > > > > The existing fix ensures that built-in.o is always pres=
ent, but it does
> > > > > > > > > > not prevent ar from generating empty built-in.a archive=
s, which older
> > > > > > > > > > ARM 32-bit linkers (such as CycloneV toolchains) reject=
 as =E2=80=9Cfile
> > > > > > > > > > truncated=E2=80=9D.
> > > > > > > > >
> > > > > > > > > Which toolchain is this ?
> > > > > > > > >
> > > > > > > >
> > > > > > > > I am using Linaro arm-linux-gnueabihf GCC 7.5.0 to compile =
our SoC32 devices
> > > > > > > > - CycloneV and Arria10
> > > > > > >
> > > > > > > Ilias, do you recall the solution to this problem from when i=
t came up
> > > > > > > on IRC a few weeks ago?
> > > > > >
> > > > > > Nop unfortunately not.
> > > > > > Was this caused by the Kbuild bump? I remember the logic around
> > > > > > builtin changing significantly.
> > > > >
> > > > > Yes, and I kinda thought we narrowed it down to something being m=
issing
> > > > > from the update, since the kernel does support this old of a tool=
chain
> > > > > (or at least the 10.x? someone else this on).
> > > >
> > > > Hi Tom,
> > > >
> > > > Actually I am not sure u-boot itself have minimum requirement on ea=
ch tag
> > > > or branch listed?
> > >
> > > We do not currently have a test for anything other than "newer than
> > > gcc-6" for ARM, but should have the same minimum requirements as the
> > > linux kernel, but are lacking enforcement checks (but I also think th=
e
> > > kernel is?).
> > >
> > > --
> > > Tom
> >
> > Hi Tom,
> >
> > Oops, missing the kernel version. Add it back for better debug.
>
> Sorry, what I meant was that it's a kbuild related issue as to what
> version of gcc can be used. We don't have a check, and should, but also
> the versions in question here should be expected to work. There's just
> some change we're missing.
>
> --
> Tom

So long story short this patch itself should not introduce from beginning.
It is a GCC version depended issue.
But how to pin-point down to which version is a bit hard.
Distro link with GCC version and not all gcc version can easily checked.

Any idea how to easily check this?

Thanks,
Brian
