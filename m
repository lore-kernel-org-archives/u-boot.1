Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3E4D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0814A83AC6;
	Fri, 28 Nov 2025 17:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H8AQpdTw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A44D783B64; Fri, 28 Nov 2025 17:50:06 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FDEE83966
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c76f65feb5so1452272a34.0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 08:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764348600; x=1764953400; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZA3ZXxcHCk/44/0v2Xnwdmzse1J51IXjlrvZztO7SgY=;
 b=H8AQpdTwyM8IiJwuBnLDMkzJgwo1haYAoJTa3D5KYiae0hnK3b65Du+EgM/ql+gufK
 M9I03BYsE1yiFpoY4UlB9wFIoK+6QXgpyTtyHxuVGRXHYxMq3Ygx6unjVySfNDgH0Gbj
 VXeB6CSpAZHacruJFm9f21RxDIAGI4RxEzr9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764348600; x=1764953400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZA3ZXxcHCk/44/0v2Xnwdmzse1J51IXjlrvZztO7SgY=;
 b=s94np6B5zcs4golirY8aHsU6nJeIT9xQEk4geJQi1JseD2S1Q8yrHaE3jf1Q/ju4Ep
 G1QNyT0M3Twe8wEoy7uwe0d91J7EGQfvN0kOAzDhxOxO4/rgGyH0NlEDbi7zBAuEH8Re
 fOLpPnufQ7R4FvnUkyyvwcFkKtdMM3SLepaEHTQTsukZd5iS/JOEfvb5/bJZj97aGchb
 C7X2jxF3iCvosAEI/myA8bZiKqVuMfNgSkZjr8x2YX9leycYOPueqTjORg2cjuiQMtkv
 NBTuNBNOJtH1Jigmjyqa4+8N7aakQa9ppm5SieS407l6v1KP9GbRls9GtaYD9n5STVnH
 MVrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZg/S/icq7U/iyS9DKW95TvaZJcM+wjBx8CTBjBhO1N4rdj2x23h8c75Z9uA5k+c0k36ZwBzk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzejk+TyKf3gQwy8pQTuxHJKr/bHEnMencouSSlJ2hlEbGsFCcu
 4vblhmo3g4lJGteYRF4R+LuQZI5nPXAOSGGqSHf23g5/oncQtw1evqf6nlUMxn6Sp/4=
X-Gm-Gg: ASbGnctDW9JQWxzyThnm6tt61B43x/TLahLOkg+fw84L6pB7NVziY99NphyAo9Egyxd
 DUw4R9PWtVnyPylTyt6vclFKYPvZqCpn3Zl7aC1MpwPxCxZmNY5nmieTa4WYdFKlHg9TXeRFjAl
 Jgz8mibA2/EE0iVe9N9m0VvUV2PbkziMXAH4TC96+Vmy99DiBFEqD//gik5RjOadz5bHugs+23T
 3Yz6Bk5VlFzqNnAK5Y71GgTU7YeHQT1MElFUTlnvGGPWq1PwNRUVJbQN8m1AWqAAcuut/VpdeKg
 FxO+4dvYDOvR41FXrGj4eCunvzZoB9E49VdFnAOwKvetKs/iNmPq9Y8i/FUu2o2gpsoqoEkWPV0
 9GxfYNZdSq8uJA/ols0YEPRfsN5s01VJ2wMXKm4vMzcmgUYBIuKvJYxAHUGInqUL9Qu2F54+GCZ
 Hwdzfz+yxiJAiyD0PVzwDxZ9IQPeM3O3x4hNLQWN0Dz7Mq3DThipt4VJq9pNpD
X-Google-Smtp-Source: AGHT+IG0rXACzUtW0d6EZOHnagoAlGUZW3V44utZY8brkfg4G5S3YdP5bscPgroKv9bKsbhdIEtSkw==
X-Received: by 2002:a05:6830:4107:b0:7c7:6558:277a with SMTP id
 46e09a7af769-7c798bff0d0mr13213907a34.15.1764348600024; 
 Fri, 28 Nov 2025 08:50:00 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fe0be23sm1721276a34.21.2025.11.28.08.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 08:49:59 -0800 (PST)
Date: Fri, 28 Nov 2025 10:49:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Brian Sune <briansune@gmail.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from
 empty built-in.a in SPL/TPL/VPL builds
Message-ID: <20251128164957.GD2125796@bill-the-cat>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-3-alif.zakuan.yuslaimi@altera.com>
 <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
 <19c33d9d-4cab-4add-9dff-f3b9e051f146@altera.com>
 <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
 <f13e8fd9-9705-46ec-a2c4-9fc4c6a63e38@altera.com>
 <20251128153130.GC2125796@bill-the-cat>
 <CAC_iWjKp1ztEW23e7rujk-oFuYS_qfMi+CF+VEdwcCHmXrtgkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0PtVx24FNCry4QG2"
Content-Disposition: inline
In-Reply-To: <CAC_iWjKp1ztEW23e7rujk-oFuYS_qfMi+CF+VEdwcCHmXrtgkg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--0PtVx24FNCry4QG2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 06:44:12PM +0200, Ilias Apalodimas wrote:
> On Fri, 28 Nov 2025 at 17:31, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Nov 28, 2025 at 10:11:53AM +0800, Yuslaimi, Alif Zakuan wrote:
> > >
> > >
> > > On 27/11/2025 11:09 pm, Marek Vasut wrote:
> > > > [CAUTION: This email is from outside your organization. Unless you =
trust
> > > > the sender, do not click on links or open attachments as it may be a
> > > > fraudulent email attempting to steal your information and/or compro=
mise
> > > > your computer.]
> > > >
> > > > On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrote:
> > > >
> > > > Hello everyone,
> > > >
> > > > > I already have the referenced commit in my test branch, and I can
> > > > > confirm that the same compilation error still appears on CycloneV=
 when
> > > > > certain directories produce no SPL objects.
> > > > >
> > > > > The existing fix ensures that built-in.o is always present, but i=
t does
> > > > > not prevent ar from generating empty built-in.a archives, which o=
lder
> > > > > ARM 32-bit linkers (such as CycloneV toolchains) reject as =E2=80=
=9Cfile
> > > > > truncated=E2=80=9D.
> > > >
> > > > Which toolchain is this ?
> > > >
> > >
> > > I am using Linaro arm-linux-gnueabihf GCC 7.5.0 to compile our SoC32 =
devices
> > > - CycloneV and Arria10
> >
> > Ilias, do you recall the solution to this problem from when it came up
> > on IRC a few weeks ago?
>=20
> Nop unfortunately not.
> Was this caused by the Kbuild bump? I remember the logic around
> builtin changing significantly.

Yes, and I kinda thought we narrowed it down to something being missing
=66rom the update, since the kernel does support this old of a toolchain
(or at least the 10.x? someone else this on).

--=20
Tom

--0PtVx24FNCry4QG2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSnSsQAKCRAr4qD1Cr/k
Ci4OAP0VRGV9KxAw6Xc+WF6NIZM7dgqdd54BVo8IL2o8PtY70wEA5bMyLueXa9oH
bB8u4SP8suek64y0jTD+BhN8x/4Sgwk=
=A/d7
-----END PGP SIGNATURE-----

--0PtVx24FNCry4QG2--
