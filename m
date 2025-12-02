Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA434CFD2F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 08:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F88283E1E;
	Tue,  2 Dec 2025 09:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FCVc2wZr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B91E83E20; Tue,  2 Dec 2025 09:03:07 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0338B83DE0
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 09:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c7aee74dceso1533522a34.2
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 00:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764662584; x=1765267384; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XCb4YOc0Ca4OHVzocPAFnnNYdfgw1SaQIcfrBa2D0s=;
 b=FCVc2wZrJ3COlO1TplTgzzYFAkoXekP7rG0dhu1FJgmOYabpPffIYBUIwltUwr4PZ5
 35oFnPNBL2hAu2LSsdleIbdBi9PrMU3z4a9z3Do+QI4vBJpoAqSK+ZgpM+hJhz6qPoIa
 EhMm8ckBisIox27bPWIFwZw42vXhbkQOv6yji8xiPdIyYj/AG2Mtrj8mEulofstOaFiD
 KloUX4277veI6+OEmAy66iT7Jk6C6kp7V0Z20SIm3rlqmN4s1MWdmUIgQp2jXLDXa5Jk
 3Scgen11QN4bU9nDlQAnGDTZBV8HkdXmpZWskFPHDDw82fQTFXxidypeNHBP9g5sKpeu
 7xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764662584; x=1765267384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1XCb4YOc0Ca4OHVzocPAFnnNYdfgw1SaQIcfrBa2D0s=;
 b=jPiAqRBPNspfP6oN9tl2eQcDFf6BwKzhBnEbCP++BpCLjo1odV+/ge/VEe6++x/8Ix
 ZZluaYGh3BkqDRf5pjdajdhWIvFWMHvkq1TGg9PDKLRF9ZiVL9Nkk0eGAdiSpQ0rz48x
 5e1npon6hSmJ+TSN2ZdQmLPMI17H670a7VxZSD3tuR8WG6nNY5DoNwoasP099tfiLAE2
 Ps/fduZ5M3jmG7O9sm3AwOEs/eS1w6FX87J9hY3fGXMNM/wHPDHV2TawetGDMG2TtQhS
 OlJFRKjq2gp048lFN1NB2onql8FA/ZrshHk0bJcI0n5O0Oy8udigricfGuVMAJMHClu7
 F4/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUUi0flMfopebtRmz385HVBOo1gmK2Do70e0w9mOjSmeaMfIvEWBggnvyEC+IWMKXOWXwahMw=@lists.denx.de
X-Gm-Message-State: AOJu0YyBGyaGjTFv0RH+25Hcc7bijv9yBAtQ5DKiwKxLlX3fBHqI079/
 PlWQP47HQ+vatmrUpWNUXlmu3GaKhqy6+4C2IDYd7rdrRoB5vJ9yBfYoKL7zeUmiL6ww/gAjazp
 j17en6PKFoRbWf1Bwg6NO/5WqzDLCnuQ=
X-Gm-Gg: ASbGncvGLAaoBcDGF79PKcGglOEa16ChE8HDrxMz5kphdtYcRTtkBUGBEgT6pXcgIOR
 A3rq1FRrVVfvcGUKoGnsttYltCghnyAQBWhwWPgxg36wdDRFLlHxErzjTMpu1ZqEIeCasGAMVn0
 fAfV5xxR6I83ob2WkaW2fKMfT9QodLea6QFBrZjskLyHweG8Sk4Pfr1teYCylYTm9U3jwMnD8CF
 yKIdL4cEPjXl8zjEbkPdF83nR4IALtm3pyYQvM7RmAltjxfjVzEcWxrVs2TW4CL264AvWfA
X-Google-Smtp-Source: AGHT+IFsPlzHOCdF44Yoft4c+8K685w5C19j3D6fztCwy2nDO4XS9FKQzfrMWluUX6kXw+OpY1WffOw9jF4030bxm8Y=
X-Received: by 2002:a05:6830:61ca:b0:7c7:6319:da9e with SMTP id
 46e09a7af769-7c799075bfdmr21134713a34.19.1764662583670; Tue, 02 Dec 2025
 00:03:03 -0800 (PST)
MIME-Version: 1.0
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-3-alif.zakuan.yuslaimi@altera.com>
 <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
 <19c33d9d-4cab-4add-9dff-f3b9e051f146@altera.com>
 <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
 <f13e8fd9-9705-46ec-a2c4-9fc4c6a63e38@altera.com>
 <20251128153130.GC2125796@bill-the-cat>
 <CAC_iWjKp1ztEW23e7rujk-oFuYS_qfMi+CF+VEdwcCHmXrtgkg@mail.gmail.com>
 <20251128164957.GD2125796@bill-the-cat>
 <CAC_iWjLYvzHHJ+KYj68KWa=E+V3wc360HRf_dWCh7ny5bdEU9A@mail.gmail.com>
In-Reply-To: <CAC_iWjLYvzHHJ+KYj68KWa=E+V3wc360HRf_dWCh7ny5bdEU9A@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 2 Dec 2025 16:02:52 +0800
X-Gm-Features: AWmQ_bkMVn3KPU8GB_xTLlZ3FjtxDZykpRNKapf3cqZVeT8NC7DSw3W6cY949iA
Message-ID: <CAN7C2SAEZgm8KshbGU3d48U3w01vtG5zvbzZRbA_3tE5S0E+Lw@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from empty
 built-in.a in SPL/TPL/VPL builds
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
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

Ilias Apalodimas <ilias.apalodimas@linaro.org> =E6=96=BC 2025=E5=B9=B412=E6=
=9C=882=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:56=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi Tom,
>
> On Fri, 28 Nov 2025 at 18:50, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Nov 28, 2025 at 06:44:12PM +0200, Ilias Apalodimas wrote:
> > > On Fri, 28 Nov 2025 at 17:31, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Nov 28, 2025 at 10:11:53AM +0800, Yuslaimi, Alif Zakuan wro=
te:
> > > > >
> > > > >
> > > > > On 27/11/2025 11:09 pm, Marek Vasut wrote:
> > > > > > [CAUTION: This email is from outside your organization. Unless =
you trust
> > > > > > the sender, do not click on links or open attachments as it may=
 be a
> > > > > > fraudulent email attempting to steal your information and/or co=
mpromise
> > > > > > your computer.]
> > > > > >
> > > > > > On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrote:
> > > > > >
> > > > > > Hello everyone,
> > > > > >
> > > > > > > I already have the referenced commit in my test branch, and I=
 can
> > > > > > > confirm that the same compilation error still appears on Cycl=
oneV when
> > > > > > > certain directories produce no SPL objects.
> > > > > > >
> > > > > > > The existing fix ensures that built-in.o is always present, b=
ut it does
> > > > > > > not prevent ar from generating empty built-in.a archives, whi=
ch older
> > > > > > > ARM 32-bit linkers (such as CycloneV toolchains) reject as =
=E2=80=9Cfile
> > > > > > > truncated=E2=80=9D.
> > > > > >
> > > > > > Which toolchain is this ?
> > > > > >
> > > > >
> > > > > I am using Linaro arm-linux-gnueabihf GCC 7.5.0 to compile our So=
C32 devices
> > > > > - CycloneV and Arria10
> > > >
> > > > Ilias, do you recall the solution to this problem from when it came=
 up
> > > > on IRC a few weeks ago?
> > >
> > > Nop unfortunately not.
> > > Was this caused by the Kbuild bump? I remember the logic around
> > > builtin changing significantly.
> >
> > Yes, and I kinda thought we narrowed it down to something being missing
> > from the update, since the kernel does support this old of a toolchain
> > (or at least the 10.x? someone else this on).
>
> Ok, let me go through my irc logs in case I find it.
> Reading the email thread we should compile with anything > 8.1 right?
>
> Cheers
> /Ilias
> >
> > --
> > Tom

Hi llias and Tom,

I have a question might be wrong or not even exist.
Tom mentioned GCC 8.1 kbuild but u-boot is considered as
kernel build or it does not always be that case?

At least so fat there are nothing can build properly below 10.0.1
Using ARM official cross compile binaries.

Thanks,
Brian
