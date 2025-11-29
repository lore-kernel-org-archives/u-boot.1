Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139FDD116EA
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 00:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7326683A7A;
	Sat, 29 Nov 2025 01:46:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UMJVFsGh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45C0383A8C; Sat, 29 Nov 2025 01:46:32 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F63483A5B
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 01:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c7aee74dceso624216a34.2
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 16:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764377188; x=1764981988; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULgu2YkRxIGkwtQljA9/RQp6WjdD+OwWPb0yonRuSGU=;
 b=UMJVFsGhAEtTxy+nOvZkC402dKWIk3i5h7Tcbq9QRmd42pNyIYRlask5VMNjNuqYs4
 5VT1gEHS7p3Mi5Sz3ANbRSmkQYDcQeyXCgwi9v+d9Xm8qYbwuRXjSkStvy/gOwtOV0Vd
 jKYlqOheDJ2L5lsGmUHelTDnjPzbv4zKMk+pWJTAVEoY3GiJnMpqPx2npWqLWNVd2yap
 pkmDvprrxI/QSsRjAxdKanZK74qMo2LJk6rGjV3MJs00ijaRBNDFjKhSde5y3ruVAoWn
 bhT82XxqkV+d0MXg+bfqPAiteF8eScu7ZPiSRJbwfamN/xvCwgGmSkIK3ruOkP+e4EeV
 EPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764377188; x=1764981988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ULgu2YkRxIGkwtQljA9/RQp6WjdD+OwWPb0yonRuSGU=;
 b=EqFaw0/9fPQHZ8+UsYz4K+zMjDdgobZRlgnjTHxDWw2dJ0Xv7C+F+Z20Z1VnvLnAPh
 l4SuPk1xyOJSnAtmaBwWWE+2ZUpX0bkUXEvIcXQIl2SVZiJnmh9cfiRpvRc/mZt1LBqX
 BChTmv8cxddKFg9CYX0nbHDC3/CZLOA7aFbuNlQAGEGsi6Kc/QCZcvokLf5CmvDe3flL
 bL+iq+UAPsZSKDW6o+Ak0ypGWI0Q75fKM7Uau5XSc4gLzI5cxmfmvT+qaSa8Mln6xA3c
 6M+BePlvAgl1dq/QsPI+CISipzA42J3NswqSe5zUEcfYc3q95kAgliVrwF/DX8lttmhO
 g1UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvKXKCBIOMJ82ndvo+xSj7k3D+mPgyKEnMntP/rnvI7LqC0mG0oNlsJZJqH14XUry0EfaHJHM=@lists.denx.de
X-Gm-Message-State: AOJu0YzRuVP5GBADnP5DpzA9Z8dOuSCwK9lca4Qd1yIe3PYl5k0QqLjs
 3EBF1CUTERqDr3OGn+EabWJU3wYrCdf79qr71NKwhPWwfQsVAfrEn0NUCOYlkyPcdK35eYL6Kl/
 oJczLOTeIhb7Vw4PKZdlwpg8qUfWtVyg=
X-Gm-Gg: ASbGnctZ08y5hfU5WSq2Xvdm7JSUC+3gmavKODHqhFPiUEF29HYl4baqeDclv9+xfLW
 39OAHX74Qg9dp7BVga8a2pF9kPGX3C7vQsrNHJK3Rw6j1S2bU+ZMfEl4eOGyFbnc1cgcMCn6uO3
 mdGkshUjrQIyzT2RFTxYoURTdTNh7gBLYsSFaeIzwdcpnW28Od2NhuhJw417E2pNCxpUizhwzFf
 KOgMqzHIUrqgcEKR9hWGDFxV7NmMH9s6XpJVnyXKjKJLyy19PrhUCsgdnWIajqSs4BGEZ7TpxY3
 0c9V8A==
X-Google-Smtp-Source: AGHT+IF6iKF5o7sWopAODs1OcmLYURzktJrzemEUj6CuQ0ko4mwAK9p60cCmF2CQxkYnjXWEgluYrprpvUjApyndFyo=
X-Received: by 2002:a05:6830:7188:b0:73e:9b34:9a0f with SMTP id
 46e09a7af769-7c798f7d50cmr13163147a34.7.1764377188246; Fri, 28 Nov 2025
 16:46:28 -0800 (PST)
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
In-Reply-To: <20251128164957.GD2125796@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 29 Nov 2025 08:46:14 +0800
X-Gm-Features: AWmQ_bnpa5kZmDo80dEQCqXW00AsvLL6yb8689jtBnZd68f3VXnGuFX3QQwpiCg
Message-ID: <CAN7C2SCpM4V3GL=_tox+9ePEx6DcVNK+pdfxn_ysiOyvYuEn+A@mail.gmail.com>
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

Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B411=E6=9C=8829=E6=97=A5=
=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:50=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Nov 28, 2025 at 06:44:12PM +0200, Ilias Apalodimas wrote:
> > On Fri, 28 Nov 2025 at 17:31, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Nov 28, 2025 at 10:11:53AM +0800, Yuslaimi, Alif Zakuan wrote=
:
> > > >
> > > >
> > > > On 27/11/2025 11:09 pm, Marek Vasut wrote:
> > > > > [CAUTION: This email is from outside your organization. Unless yo=
u trust
> > > > > the sender, do not click on links or open attachments as it may b=
e a
> > > > > fraudulent email attempting to steal your information and/or comp=
romise
> > > > > your computer.]
> > > > >
> > > > > On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrote:
> > > > >
> > > > > Hello everyone,
> > > > >
> > > > > > I already have the referenced commit in my test branch, and I c=
an
> > > > > > confirm that the same compilation error still appears on Cyclon=
eV when
> > > > > > certain directories produce no SPL objects.
> > > > > >
> > > > > > The existing fix ensures that built-in.o is always present, but=
 it does
> > > > > > not prevent ar from generating empty built-in.a archives, which=
 older
> > > > > > ARM 32-bit linkers (such as CycloneV toolchains) reject as =E2=
=80=9Cfile
> > > > > > truncated=E2=80=9D.
> > > > >
> > > > > Which toolchain is this ?
> > > > >
> > > >
> > > > I am using Linaro arm-linux-gnueabihf GCC 7.5.0 to compile our SoC3=
2 devices
> > > > - CycloneV and Arria10
> > >
> > > Ilias, do you recall the solution to this problem from when it came u=
p
> > > on IRC a few weeks ago?
> >
> > Nop unfortunately not.
> > Was this caused by the Kbuild bump? I remember the logic around
> > builtin changing significantly.
>
> Yes, and I kinda thought we narrowed it down to something being missing
> from the update, since the kernel does support this old of a toolchain
> (or at least the 10.x? someone else this on).

Hi Tom,

Actually I am not sure u-boot itself have minimum requirement on each tag
or branch listed?

On ubuntu 18.04 LTS

HEAD detached at v2025.10

x-gnueabi-ld.real: arch/arm/cpu/built-in.a: file not recognized: file trunc=
ated
scripts/Makefile.xpl:541: recipe for target 'spl/u-boot-spl' failed
make[1]: *** [spl/u-boot-spl] Error 1
Makefile:2358: recipe for target 'spl/u-boot-spl' failed
make: *** [spl/u-boot-spl] Error 2

Same fail I experienced before.
All are default distro package
gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
arm-xilinx-linux-gnueabi-gcc.real (GCC) 9.2.0

On Ubuntu 22.04 LTS

No issue on build what so ever.
All are default distro package
gcc (Ubuntu 11.4.0-1ubuntu1~22.04.2) 11.4.
arm-linux-gnueabihf-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0

Thanks,
Brian
