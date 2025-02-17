Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3E1C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 14:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDA32807F1;
	Mon, 17 Feb 2025 15:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l8o9/p5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B24980BAE; Mon, 17 Feb 2025 15:05:41 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1B0A807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 15:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220c2a87378so60307915ad.1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 06:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739801137; x=1740405937; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zg/EVU0f4eFzBH9Wpquuf21heBkWFjy5hpmnqQ/UTNs=;
 b=l8o9/p5e9gv1kDKB7axEZqiNCRc+DT4OASRHXcyZ3SG8IVFiD2oYvnTjPi85alDRut
 q29TbmfCf7pUhvMNzae5ZPXjpKiAALoZjXbCzoRj5jYhEMUpHdqLezf5WVN5tHXd8eUp
 bFiwXZaLhGYCgYYthMKtBtwIGsx8uXAPNTrFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739801137; x=1740405937;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zg/EVU0f4eFzBH9Wpquuf21heBkWFjy5hpmnqQ/UTNs=;
 b=DZiOy4Uj+z0ChH1rIoZ5a8WyNxyk4VQ03UxysDKsSl+rTkDBEPbDsUeftxbx/7Jv15
 2dXPAqxri7vGvI6e9acJzbQffpwsC/zZeWvtVpGN3bmzCE1IiWYX+Yy7I4Ov6lfAQk1K
 NsY617/D40QKRP/fL6qg0chdXxLVjON70unNRrCsQIG0CJ+7UOkZBg7/I0CLn/e+7FNT
 RNJMu57oIvCjrZ8DMUPFdBwJnphpd7S/MAVBxi4oIchzv5FayA+t+63IhHIKiVdbwJZJ
 R4UohkaHcboKxxmEiPzgVCMEfPEaAisBxFhftaLAJtVivNx9Ewcsy/0MVQzsPgvoMtjg
 vq5g==
X-Gm-Message-State: AOJu0YwvNFyrfExLPTvgLpUeP2uVuzUxkey5LenMik6Fv6kOj/oqxyHH
 iJqaL2Pz9EtX3DxY2E5bXqt/S/L13gMSvnNUhkZP2pbIOLlzfY0ZdSsYgUITuWU=
X-Gm-Gg: ASbGncuNvKtMXTevSj4EUtbXaOp2n46yI6je/jXF1QhpuKpKOq6HagPSVSvzDJAxocm
 ckzzsFt/C6ltWOvD6WhdproCNbV6EL2MvPoq2eYNI8SY+LbfihX4oec9hHgTCbnnXaS5Oeig7mp
 EgS6tIAgm5U3iIetRQJaINhk286iLw37ulyo4mRmn7j3JKG8voetPZtAF11oz73YIpkVyupaxwa
 aBIT98ln7MUlE657EmgnfDv5wLrH1IGv+nY3ypUhDhyQMhjlfXGG59n36VnkxytD1FY7wPnn995
 /b5lblhhh3DuQg==
X-Google-Smtp-Source: AGHT+IGX4dYYsQ1A+LIO1LY5u3sAS4bhWhQLiUwWyk7C0SR8FxIgbOQmcQgNpeCF4DbVUOJdGj5Z3w==
X-Received: by 2002:a05:6a21:7899:b0:1ee:73bc:5f2 with SMTP id
 adf61e73a8af0-1ee8cac56cemr16813086637.2.1739801137009; 
 Mon, 17 Feb 2025 06:05:37 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324f22fd95sm6769705b3a.11.2025.02.17.06.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 06:05:35 -0800 (PST)
Date: Mon, 17 Feb 2025 08:05:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Philip Oberfichtner <pro@denx.de>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/28] x86: Improve operation under QEMU
Message-ID: <20250217140532.GG1233568@bill-the-cat>
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216215738.GF1233568@bill-the-cat>
 <CAFLszTjtgMT6Pd9_MG8t4irU-jyoHTd40MwX5m1iqj4rjVED3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="umW28Lcj/p6fp0Bs"
Content-Disposition: inline
In-Reply-To: <CAFLszTjtgMT6Pd9_MG8t4irU-jyoHTd40MwX5m1iqj4rjVED3Q@mail.gmail.com>
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


--umW28Lcj/p6fp0Bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 06:14:12AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 16 Feb 2025 at 14:57, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Feb 16, 2025 at 01:43:45PM -0700, Simon Glass wrote:
> >
> > > U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but =
it
> > > is not perfect.
> > >
> > > With both builds, executing the VESA ROM causes an intermittent hang,=
 at
> > > least on some AMD CPUs.
> > >
> > > With qemu-x86_64 kvm cannot be used since the move to long mode (64-b=
it)
> > > is done in a way that works on real hardware but not with QEMU. This
> > > means that performance is 4-5x slower than it could be, at least on my
> > > CPU.
> > >
> > > We can work around the first problem by using Bochs, which is anyway a
> > > better choice than VESA for QEMU. The second can be addressed by using
> > > the same descriptor across the jump to long mode.
> > >
> > > With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
> >
> > This seems needlessly not against mainline.
>=20
> I just tried it and yes there is a very small delta. I can resend it
> rebased to -next if you like. I'd really like to get some OS-booting
> tests into CI.

Sure, and please start pushing scripts to u-boot-extras. Having these
scripts in u-boot itself explicitly makes it harder to use them for
debug as you now rely on them being within the tree with the changes you
want on whatever older commit you want. And since you want to move these
to Python too you that also means language updates need to be in there
as well. Thanks.

--=20
Tom

--umW28Lcj/p6fp0Bs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezQiQACgkQFHw5/5Y0
tyzjhQwArYVqHUFpomFtiW+i5S/JC2/oMdDkBPWILbq5Me7qwk9HjuTGQOfDGHRk
xas9Gp0soGZoFCh68x8uIE2Qluho2QDemPpkJLsGALB4/Un9H2E2L9JigIr1fiZ8
SqGr69eVuY5nVREZtnJ93xOr3rx04lmFCc8XDCP3UQk4rx7FyluYzXMM0Owq1XBb
wnZ2HfVaK6bbJou+G40P91vRhYO65un4HxGHlt/sTzDQcvBqfMeyH3fAGAZdmHOK
BmDeJD3VsL3x2GHK7ur7lC4/kOAINjGa+EOuTHpFVWiSWKCr4ATvPuamfc+6Y41m
tLU4k2QFUcwpEq89EQZk3JvjXweUnrus+sr6JtBJIDBsT46+z8Mr79QVjk2BhmN4
wOHCCn0I9ZlAL0KuhoQ0hGGSXhC5y4fe7+vbblYVif1g9t/UG/vgdBQ8TouCrqWn
O9FR1r4pff+CCPz96bJJGLCZHMFt4vANBEavc9mPRSqVLe5u3917lSe2EABUXODB
yznpliJo
=pv6D
-----END PGP SIGNATURE-----

--umW28Lcj/p6fp0Bs--
