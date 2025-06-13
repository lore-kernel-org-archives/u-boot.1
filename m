Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF93C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28BF882D21;
	Fri, 13 Jun 2025 16:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ODpNix2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30C22808AF; Fri, 13 Jun 2025 16:22:46 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25F5F82D21
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 16:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4a58c2430edso23469661cf.1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 07:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749824563; x=1750429363; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0H0Z6TfAnf1HziUyjB0xPxppXpTHY5o8Kc7xWphWHMU=;
 b=ODpNix2yiy1Kp81Ob6JCJ+zp7UDeX/5VPp0eNj+dz8SEUgvjtrM6hbh/GoJdNS0xdA
 WTROT+kIJS12wAV/57FzmF0oxBT6oIqBd6wvtXvMVnKxPPjhZT5XkZ+OFHtWrOzUS7CS
 Use4CrvI26ySchwtPAUe6fzoF3+lJyD7dKYP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749824563; x=1750429363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0H0Z6TfAnf1HziUyjB0xPxppXpTHY5o8Kc7xWphWHMU=;
 b=shSmsBj35RyvcsJKd8TFulQJo+AabhIrksa7PyeSWJnJm2OmRyKLpVYrjg/akMZBgK
 VCv4xh8yz739B8YWmLV8sx8ewlVdzSL7x+T6miDfdsPNPR42wbUXup5LgCo0Z0T4PQTI
 xT83R+I7FIHWomgJodsFpuMM3DnapL/wVWOgHWQz4F2Bgq6Z4zZjc1fPwZIso6STC0DM
 U2I6hEMu9zVtuf189RvZHfY5KMC2VQk4e9eaVth3HfhK4fKShjvz2E3um29bXv5rkC/q
 mVQ2oq3bS7xPLzNbgSzphTiafuds4i7ltmzUqbIE8VsIYTWeZDqsWHXkn32ae0bdGzx8
 mk0Q==
X-Gm-Message-State: AOJu0Yw0tGntTtYkiWnHGYUIQ23ARmHpjLUADtaaEzJY8ex15oBsGMBJ
 v1j83wyS/luSk5kAJ81L0k8eq/5UCbdCjs4s0lxyAMDFz8e2Q9syYAuPirm9MP8CmrgrHWwc15k
 /5dPr03Q=
X-Gm-Gg: ASbGnctwHoWBqgWVzKi3uPcwsEKkYUQ/EUI1ZKVO+ZNlr0LQM2fpDI4o+dJgnCvNogU
 x89HQbEOywzsLV0Jh5WKgyAgpP3felCkVy7otggsbIKIn37CQ8S60dPs5jiW7Ug+rG/jBgz5zle
 toCbJ7XmrpLkEk5J1nW2kdGsVDW5tuhhm3R41ktSRN5gOwQwBO+APl3TnUT7IQ26W2ydYy4KHnd
 Gtxu7y8GaR7jCiveRq0WmVt98bo46xoKTDHUshnPWAGWzLSuvdhU9kAki3uoFnIeO2vLCt2ersg
 MCjT5Yoq/Y5OldIzGfKtX7vourHxQfMdBuG6J7xthKWB5kEB8edSeq5jj68Z1abG7EywEZ/vunT
 kkvZubPns6FzwZSqRqW8lNRe4dst6ZepuAg==
X-Google-Smtp-Source: AGHT+IHd1len11Kulc9vVGPWtiibAYUe6PzUeK8DnSodiVGg3RhfeOfdlRXHHjQm1cTIaROlAh19yw==
X-Received: by 2002:a05:6820:2213:b0:60f:1fac:b899 with SMTP id
 006d021491bc7-6110ef6be53mr574723eaf.2.1749824551019; 
 Fri, 13 Jun 2025 07:22:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61108da6baesm182138eaf.11.2025.06.13.07.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:22:30 -0700 (PDT)
Date: Fri, 13 Jun 2025 08:22:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] arm: zynqmp: Remove local copy of
 'dt-bindings/clock/xlnx-zynqmp-clk.h'
Message-ID: <20250613142227.GW1382132@bill-the-cat>
References: <20250612181128.340232-1-trini@konsulko.com>
 <5e694bb1-02e7-48c2-8b07-35882fff0939@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mKejaX2DOAfjT0g+"
Content-Disposition: inline
In-Reply-To: <5e694bb1-02e7-48c2-8b07-35882fff0939@amd.com>
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


--mKejaX2DOAfjT0g+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 10:31:33AM +0200, Michal Simek wrote:
>=20
>=20
> On 6/12/25 20:11, Tom Rini wrote:
> > As part of the recent cleanup of dt-bindigns header files we did not
> > remove our copy of dt-bindings/clock/xlnx-zynqmp-clk.h at the time. This
> > is because the difference between ours and current upstream is that
> > current upstream has a #warning to not use it and to instead use
> > xlnx-zynqmp-clk.h. So we change zynqmp-clk-ccf.dtsi to use the other
> > and upstream-only file and then delete our dt-bindings file.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Michal Simek <michal.simek@amd.com>
> > ---
> >   arch/arm/dts/zynqmp-clk-ccf.dtsi            |   2 +-
> >   include/dt-bindings/clock/xlnx-zynqmp-clk.h | 126 --------------------
> >   2 files changed, 1 insertion(+), 127 deletions(-)
> >   delete mode 100644 include/dt-bindings/clock/xlnx-zynqmp-clk.h
> >=20
>=20
> Tested-by: Michal Simek <michal.simek@amd.com>
>=20
> I expect you will take this patch via your tree. If not, please let me kn=
ow.

It's a regular cleanup you can take it in your next PR for -next.

--=20
Tom

--mKejaX2DOAfjT0g+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhMNCAACgkQFHw5/5Y0
tyx2bgv9Fi4AsZGPc2r6ah7BVMgRug3Www7dYiaoWMFuLYbsVm/BNNSspmB9aslH
MejCXtCCHXZasejwwXXRaQ/Wq0JCfg31Fz3MzuY0AlNnCBBYGTwWtljwbWHuowuT
/FPwXV6cIE9P5ejzG0r9W2sK+XT1lx56DodLlzLlEJFHsI/QeuuS/IfbTXsAxFcQ
RV5iL/J9+XtAn4rdDoUD/6Sgoeaz49VQxhqrFA5ACkMMIjZF41m+0pmupfQZU3yD
zmxJ2yJtnOi/Vc/GSVflq7pM+flIGTv3Fcth5TYxeeqi1EadVfzAyDrsbJGweYyG
eVQnlgjlEiMm0fL+HMwvU0iHbk+WRwNUBpn/bun7pqeGVUl9YZbZW5074YlZgFI1
tl4SCRNgBzg2B9y2I/wdY8pN8mDCz/z6tEyiEQo2T09CmJbUufuKDkct1YmaAKj9
oKHNMhimbZQ36sQNTmw4CKuCXC3ybnDIRYwkS9dV9gfLs1bkPJdSPy2d9lVEWFEy
d3rQi+I2
=s0F0
-----END PGP SIGNATURE-----

--mKejaX2DOAfjT0g+--
