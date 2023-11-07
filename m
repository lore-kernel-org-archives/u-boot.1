Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C58CC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 23:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25FDD876D2;
	Wed,  8 Nov 2023 00:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cWjQLrpi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FA9A876C3; Wed,  8 Nov 2023 00:23:22 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D93E876C2
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 00:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7789aed0e46so416655485a.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 15:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699399388; x=1700004188; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2djbIGFuQRIQl2UdGUkMzBxGSUzUAC+4NmpcsImg/ZY=;
 b=cWjQLrpiIvL8CK1AP92R56A4nBie14Nql8FvL3pLHGNikHhRqeJZMxiUSESOnFjrfx
 KHsDrMcS5ZmqQ95T2AOpdeCb1pV4vn0AWCYTpAxlp0dQ6D2fD1nz3Qy02Z3kJh1Hrjzq
 r1hvT7BtUJQppYt4svCIAU5xtaAiiuSsTFXIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699399388; x=1700004188;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2djbIGFuQRIQl2UdGUkMzBxGSUzUAC+4NmpcsImg/ZY=;
 b=MrGIu4GKWL1527lw6M0VU5MCYsVi5y8LY3FjCaMQ9tynZiBmS+U6L/GR1gpBZ24mtQ
 BQH4uWquVtniiWUV2W5D2hbRtApBb6c5QxTkEm729dn97+osz4KovD3QlqStsAet/ghD
 O6GTRerZI2QJfEno/pwziDJhZWnzHNFREWmhFfztIPELWMTbAOPmTJAZrXqEpSt+Rpml
 sJzYUuWny4CXFMdRAyFMl2/Y3tASFF+SOLuSFYM0T4WCiGz6bZ84h7nOL7u+gGr/3VUO
 uiGM7WheThiIDO5LAHycB/wI1RFvEzKJyZ806N3l6mk7JPMIQbwe7aroM3A97qWUKarh
 O8uA==
X-Gm-Message-State: AOJu0YyQSVSLEa4T28pYxjeKDCfpvm+Yo8Vu1JvfYHdcfZpQNclA3pbK
 SWfEQKkQXNCTRuBWBV5YDDlS0w==
X-Google-Smtp-Source: AGHT+IFVsLQI2Ri+sRqrmuA9oaZ0Rwapb1LOShYdKRo8OlAku5g+ULkWoy3vfYbrpe1HEE5xHr1sIg==
X-Received: by 2002:a05:620a:d54:b0:778:b0f5:d4e7 with SMTP id
 o20-20020a05620a0d5400b00778b0f5d4e7mr62114qkl.46.1699399388169; 
 Tue, 07 Nov 2023 15:23:08 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a05620a113000b00773f008da40sm393825qkk.125.2023.11.07.15.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 15:23:07 -0800 (PST)
Date: Tue, 7 Nov 2023 18:23:05 -0500
From: Tom Rini <trini@konsulko.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, palmer@dabbelt.com
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <20231107232305.GW6601@bill-the-cat>
References: <20231106172601.12c36750@donnerap.manchester.arm.com>
 <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
 <20231106204608.GJ496310@bill-the-cat>
 <CAPnjgZ28HskiFDBDa=s_k6=WNoPfWu88bAaYCY7ew8dcYXW=aQ@mail.gmail.com>
 <20231107193025.GN6601@bill-the-cat>
 <CAL_JsqKkjPyVUxjANC3_rOkEAyNUBY_mXf27N6U++KTpujYYLQ@mail.gmail.com>
 <20231107221023.GS6601@bill-the-cat>
 <20231107-flyaway-arguable-0bccc778b256@spud>
 <20231107223837.GU6601@bill-the-cat>
 <20231107-audible-undoing-293506af3890@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DWn667PRjYhim5Rh"
Content-Disposition: inline
In-Reply-To: <20231107-audible-undoing-293506af3890@spud>
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


--DWn667PRjYhim5Rh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 11:12:16PM +0000, Conor Dooley wrote:
> +CC Palmer
>=20
> On Tue, Nov 07, 2023 at 05:38:37PM -0500, Tom Rini wrote:
> > On Tue, Nov 07, 2023 at 10:27:50PM +0000, Conor Dooley wrote:
> > > On Tue, Nov 07, 2023 at 05:10:23PM -0500, Tom Rini wrote:
> > >=20
> > >=20
> > > > further clarify or not
> > > > the RISC-V ISA thing that's elsewhere in this thread (and part of t=
he
> > > > kernel, not a U-Boot thing).
> > >=20
> > > TBH, this a bit fragmented across threads, and as someone that hasn't
> > > been following it it's a bit difficult to tell exactly what is being
> > > asked for. Would someone be able to ask it as a direct question?
> >=20
> > Sorry for being unclear, and thanks for asking. What I think the U-Boot
> > community would like to know is, what is the device-tree based way to
> > know if a RISC-V platform has the Zbb extensions
>=20
> For this one, it's pretty straightforward IMO - if riscv,isa-extensions
> contains "zbb", then you are safe to use those instructions. My
> understanding is that relying on getting illegal instruction traps is
> not a sufficient test for usability of standard extensions, as a vendor
> extension could be using the same opcodes as a standard extension.
>=20
> > so the RNG opcodes,
> > similar (in concept at least?) to the ARMv8.5 RNG feature.
>=20
> The ordinary extensions that are instructions - like Zbkb that provides
> bit manipulation instructions for cryptography you will be able to rely
> on riscv,isa-extensions also. Zkr is actually a CSR acting as an entropy
> source and is a bit more complicated. RISC-V Cryptography Extensions
> Volume I, Chapter Four [0] is the relevant thing for use of the CSR
> provided by Zkr, and it says "The seed CSR is also access controlled by
> execution mode, and attempted read or write access will raise an illegal
> instruction exception outside M mode unless access is explicitly granted."
> My take is that either the SBI implementation needs to provide S-Mode
> U-Boot with an accurate devicetree (including what extensions are valid
> for use in S-mode) or if the devicetree is provided as part of the U-Boot
> binary then it needs to match what is available at that privilege level
> on the platform. In this case, you would also be able to rely on
> riscv,isa-extensions for that detection. There is an existing dt-binding
> patch
> <https://lore.kernel.org/linux-riscv/20231107105556.517187-6-cleger@rivos=
inc.com/>
> that adds Zkr, and my proposal would be to document that the presence of =
Zkr
> explicitly in riscv,isa-extensions means that the bit in mseccfg.[s,u]seed
> has been set so it can be used at the current privilege level.
>=20
> If that's not acceptable, and people think that having Zkr in the
> devicetree means that the hardware has the extension, regardless of
> usability at the present privilege level, then IMO we need an SBI ecall
> defined to request entablement of the CSR & report as to whether or not
> that was possible.
>=20
> I'm not sure how any of the above lines up with the ARMv8.5 RNG feature
> unfortunately.

Thanks. Setting aside Simon's follow-up, this is what I was looking for.
We might have to wait for Heinrich to return from the conference to have
time to look at how to utilize the above and see what we can do from
there.

--=20
Tom

--DWn667PRjYhim5Rh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKxtkACgkQFHw5/5Y0
tyx4ZQv+M92qFmj2cO6BQ9pVdKHNrPeQlyz6INXv+AYcqjntyLbyv01iu7bMUyvk
WpNGz/r+qkXC6budimnM0s9aMraWcCLpZ3qL4oB8vgTr1rwhy4XnB2B1W9XcpwvE
dlv8RnMdHja4tB3vkeguITKblR3/dOHDK8P1AKu03HHDIGuHee+j/lmLl7xK8HUx
dUq8rQPpYKSzu6W93dMw7ENbLIDOgJEl8oJtBXGJ5IKGqi3+JewANQv8xzQTM58m
ompu65CYLUfkJJG2AJJtl0tArNCQ9GBlpmROwm6OKbHmvLh2YLUqQb/URZiPTW5w
8PuOySdhkkStp8JLig5EsuIL0TjRZi12cN970WBGj6w5pEqbyOk9OXAFAeu4G0OC
gBJwYCK86fsNlaiwE79oiEWpv5ejQngTORd06EjVOXIOVoWURgXmKOuIw4sO4vjH
XFaJ9SQ4oM6QnU+fhZhkCjaV9fNTOaf5DPY+8LoIzPuvJblKJ7CpJkgliNso2yfD
weiXctZp
=qARz
-----END PGP SIGNATURE-----

--DWn667PRjYhim5Rh--
