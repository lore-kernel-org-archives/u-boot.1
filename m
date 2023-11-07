Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF6FC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 23:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1EAA8764C;
	Wed,  8 Nov 2023 00:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SNY/KWQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14C8587663; Wed,  8 Nov 2023 00:14:29 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8EED8763E
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 00:14:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7789aed0e46so416234285a.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 15:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699398865; x=1700003665; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DbXrD/CJx9/aF0xxr3DxCZskrqIssMINN15/iu1uQjg=;
 b=SNY/KWQbjy5iMI+BV+jQQ1Cs3+zt/OEzxCDGdSxl38qWo5G8ZOqnfrcssunTRBc8Ug
 3GQGcPQ+36iS03qCec9WnE6V96RWD2Dcsqy3phaK6c2P4B9jP20wD4LW0KvXfDctew8J
 kMAatl9HDpS1SW7humvtPdTFVEh4iXtuEZ8Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699398865; x=1700003665;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DbXrD/CJx9/aF0xxr3DxCZskrqIssMINN15/iu1uQjg=;
 b=DL9FPdEvI1+IRhVSPjlb0QhlpCKIgY+Xsc25Mnt40X6WWKv8f0dklPaXJjXuRvsmgN
 eOhAbuXfG7eIeSSx0FP7EzTk5xrsWnNmdaf1QDCs5Vaq3sBiz6PGNsymblQyUUqffSTw
 D+2oRl8L0otD/x8Q3aTmT4xEP6VXMhamlWANAilKhMQh4fn9mY1f+K7qh6WcZ33ClPbf
 yVAolPWDSfeYcdDvLhFfQjO/liXpFNW0nFudgQqll0tHLISD0uuS/csPyMARcbz77mj8
 dN+4Yt9y7S+/vQAlCMowuChdn2V2uU9wTi9n2r8RnT4gwh4oRgEODOZLIl0ByrDIG3Wm
 +U4Q==
X-Gm-Message-State: AOJu0YxnAGtBwC3IWmu3P5Dwwt56+9pa23RdwN+6WGMGNbFGdxfd24eQ
 f3c920eFuNlS8eh81KxpgWZr7w==
X-Google-Smtp-Source: AGHT+IEfqAqvBwR7sQNVvl2TemL6+rOT6RCu0Jcuxi7oQxxcu2evu/FZr2Rq3CmhXC5NiQCD02vEiw==
X-Received: by 2002:a05:620a:2556:b0:775:6dfb:874b with SMTP id
 s22-20020a05620a255600b007756dfb874bmr34097qko.51.1699398865604; 
 Tue, 07 Nov 2023 15:14:25 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a37f512000000b00774830b40d4sm393725qkk.47.2023.11.07.15.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 15:14:25 -0800 (PST)
Date: Tue, 7 Nov 2023 18:14:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <20231107231422.GV6601@bill-the-cat>
References: <20231106172601.12c36750@donnerap.manchester.arm.com>
 <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
 <20231106204608.GJ496310@bill-the-cat>
 <CAPnjgZ28HskiFDBDa=s_k6=WNoPfWu88bAaYCY7ew8dcYXW=aQ@mail.gmail.com>
 <20231107193025.GN6601@bill-the-cat>
 <CAL_JsqKkjPyVUxjANC3_rOkEAyNUBY_mXf27N6U++KTpujYYLQ@mail.gmail.com>
 <20231107221023.GS6601@bill-the-cat>
 <20231107-flyaway-arguable-0bccc778b256@spud>
 <20231107223837.GU6601@bill-the-cat>
 <CAPnjgZ0PqwCnm_Dn-ydR+VkN9qGU8FN-wy17802bQpGQrxTbPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="otsK0Y4H5PCeMpVg"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0PqwCnm_Dn-ydR+VkN9qGU8FN-wy17802bQpGQrxTbPQ@mail.gmail.com>
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


--otsK0Y4H5PCeMpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 03:51:21PM -0700, Simon Glass wrote:
> Hi,
>=20
> On Tue, 7 Nov 2023 at 15:38, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Nov 07, 2023 at 10:27:50PM +0000, Conor Dooley wrote:
> > > On Tue, Nov 07, 2023 at 05:10:23PM -0500, Tom Rini wrote:
> > >
> > >
> > > > further clarify or not
> > > > the RISC-V ISA thing that's elsewhere in this thread (and part of t=
he
> > > > kernel, not a U-Boot thing).
> > >
> > > TBH, this a bit fragmented across threads, and as someone that hasn't
> > > been following it it's a bit difficult to tell exactly what is being
> > > asked for. Would someone be able to ask it as a direct question?
> >
> > Sorry for being unclear, and thanks for asking. What I think the U-Boot
> > community would like to know is, what is the device-tree based way to
> > know if a RISC-V platform has the Zbb extensions and so the RNG opcodes,
> > similar (in concept at least?) to the ARMv8.5 RNG feature.
>=20
> Some more details (sorry) from your friendly devicetree and driver
> model maintainer:
>=20
> - U-Boot models hardware (and other things) as devices in driver model [1]
> - U-Boot requires devices to be in the devicetree, with very limited
> exceptions [2]
> - Where multiple devices exist in a uclass, it is desirable to be able
> to number them [3]
> - Similarly it is useful to be able select a particular device, e.g.
> with a phandle [4]
> - U-Boot uses devicetree for configuration as it has no userspace

And I'm very specifically trying to NOT dive in to these particular
details and just find out how the accepted bindings for RISC-V are
intended to solve the question U-Boot has and in turn figure out what
U-Boot should do here. I'm not asking Conor how it should all fit in to
what U-Boot does, just how what's defined now can be used in this case.

--=20
Tom

--otsK0Y4H5PCeMpVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKxMsACgkQFHw5/5Y0
tywXcQwAjiKuI4pxeI+UiyAXZATxcd/N89QCPl8gFbkLLLvY8lSkv+jvB9PFAfnE
iKavS8HGCALJAieAv6Jt9RAWbmeetpaHUcfZ7UcMKfLGqNHoa5pIhK9gbQBittKN
Juj7M4ylA1JUlpy6qoKLx7QCPefkt+qCq9tHgj9a7IpGT7OL3LLoo+WeiXFuWK0/
zQSgwuTy3XgnU4Bogob5oumaZeo2lZ3yIasugq7iv5vNpZWN+gqGpgt43cg4ocV8
KqtwEm1OUOkr5saOpfRXWnO61rXDP+ol1Z8Mimto8Kyq+UkxxNBguZ3LZFSN9ylF
l89CekgFJbm/paQMVfc21kv5kEFS1CSGzSSnDkYOURwrA8GQSNa2WK6m2Iob6Esn
z6wFSa3u6LI1oeQpPahhU+ta/wC3q3iQLNsvRImRwBLl+ziNt9+KepDHE+ThEbm3
JyfSjAUC5y+ozYB5H7pxRX5sOfdN0Ue+patxXQfxsp2kbTLXUvW5RexwKuU8mtWl
AMMAhgu6
=oaBy
-----END PGP SIGNATURE-----

--otsK0Y4H5PCeMpVg--
