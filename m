Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A218CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 19:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E58D83959;
	Tue,  7 Oct 2025 21:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n7rKnmmb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E97B8397A; Tue,  7 Oct 2025 21:48:25 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E21DF8394E
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 21:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7a7b084ef77so3822681a34.2
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 12:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759866501; x=1760471301; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=19zllCZBio5ly3Lqg1UqLCTg8IfKbW2Pl/Y/tZsZRJc=;
 b=n7rKnmmbE19d0EXQQmJTSGoBNsMZN4XrWP4I4tLxKzgWipE6wW5Xp5zzlhkqwyfOjQ
 IQZNJ7ojPJ3RKI18/EECqDOjG6J1AiTFewqTOnwCCtzS0D/DAITlqMpU0zUfsnRA9vS4
 1lO7Amf2IhMDli1zZPt/LXYyK2j+8/RyPr+Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759866501; x=1760471301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19zllCZBio5ly3Lqg1UqLCTg8IfKbW2Pl/Y/tZsZRJc=;
 b=h4gqeKBkw+spJCJLvlw3J31bEkbJ2RAenXrskOtSw3s6sMgEmNLSE3iMACuS4QHfVd
 /ISaIkHF3SLgqjipaD1l6nH+E4rZi2jSChxqzX1wg5wnT+aVZJiMcMtBk3a0sZGtERZ+
 3I2tZjE5gQZ0KDs7mzRKL9S2xhJAnG9RiVNqnJtuxkkub+kHd9oEpPWgKHXMu0vFQiT4
 OeAQ7wIYvAKjVuLxskVdWDhlWbhobFQnsApZRBUrlXrRMpH7J2/ngt8H3sVKAd6ummU5
 ApMNAWxh3PmiYzS2EwIKgvGR4i5I8RNaPg4xprbEaE4chHAcnIuK6p3tGkBwNTDF9f6J
 zt+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXByl6FxwtcEOsXCF6stJw/qa0x6KFm/k7XjszwCb9BHTvKqnUCh4O4uWE6Xveu4l4NMHNsTn8=@lists.denx.de
X-Gm-Message-State: AOJu0YxBzMPlH9ogDFhqa/1yMs3NIUSFej0oFwbaq2xtqp3wIe4Mg1m2
 Jdoy+bg219JoSRaEAyNUNgg60rhoThug/JLlnhnakYZescArRW10yQBBCb8sQn/GZ8Y=
X-Gm-Gg: ASbGncsFM6w+kj++g80v44Aqf0rM2tGExKDuBfc2+eTaxU5pn1ZeDLFwswf5bj3okXL
 UV4zIWp65x9xuJDxIGe7OztTszBvSaNm4DVXdC9kUSTwYVm3jspuoigYZeSpc/tyO3Ao/3qzHKS
 Bm+qT/F5ndh7dhbcWOvnMBhE7tgJAKc8BM/llWyOa0nb5Nn2NS35gGFEYE7G5WNjI3rzX129GAP
 yMWBGIkbrpLPqOiUSCleFg1lbcSWCtoBgX+oBBIa8iRvxdHPkD8DLaCSnDjp8qW8YLJP5BCsyuX
 eNNwx26Yc1ufMuLNQw0mj4IuioUtp1cEAIjhrMWxm93k3yi2mdjco7tqxDRh7BsGfoFF911yVPr
 yiOmHkU27WcwVKUk/BJ8JdcKlfke7/jsZupbHoCN5/Zp8vosczI2Y+EjhXmSS1dAsU0Ba0NTuW2
 z20SrD8vbd/Q==
X-Google-Smtp-Source: AGHT+IEb9DTNwE5NC3U2tQ1RDovHBYCKdeQjyXcczTGy67BWLFiCXI6OuUkBbkpnEUX+Dsnd42mSQw==
X-Received: by 2002:a05:6808:3086:b0:43c:8714:fe3c with SMTP id
 5614622812f47-4417b4074c5mr415463b6e.51.1759866501458; 
 Tue, 07 Oct 2025 12:48:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43fb25ca017sm3985707b6e.27.2025.10.07.12.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 12:48:20 -0700 (PDT)
Date: Tue, 7 Oct 2025 13:48:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] bootstd: Fix bootflow info for efi_mgr
Message-ID: <20251007194818.GP298503@bill-the-cat>
References: <20251003222714.4921-1-semen.protsenko@linaro.org>
 <CAFLszTiic5c_ZwX4hWJEAx=VGXxR8KOsNw2AQwzh92G-PRncGA@mail.gmail.com>
 <CAPLW+4n_wCzhsyVYiz1AzA4R0Z32nkjOs31F8TDwZXpyUM-J4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sQQqcF09hnnBo1Wo"
Content-Disposition: inline
In-Reply-To: <CAPLW+4n_wCzhsyVYiz1AzA4R0Z32nkjOs31F8TDwZXpyUM-J4Q@mail.gmail.com>
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


--sQQqcF09hnnBo1Wo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 02:32:15PM -0500, Sam Protsenko wrote:
> Hi Simon,
>=20
> On Mon, Oct 6, 2025 at 3:40=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>=20
> [snip]
>=20
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > If you like, you could an a test for this to bootflow_cmd_info()
> >
>=20
> I remember the last time when I tried running bootstd tests they were
> broken. Are they functional now? Also, do we have some short
> documentation on running bootstd tests? If so, could you please
> reference it. I mean, I can add the test, but unfortunately don't have
> enough time to fix the broken test suite (if it's still broken).

I think any future regressions in this area are things that smatch would
catch and we'll get that in CI soon enough. Coverity (and smatch) may or
may not have also caught this, FWIW.

--=20
Tom

--sQQqcF09hnnBo1Wo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOVufwAKCRAr4qD1Cr/k
Cp0jAP9US+SoIGgnXaC8kkHiSEvTFbWVdnjubqG24kA962K+cQEA5Qlxmux9LueE
/KEHjNBQRfYh2Tqd5utA/CSk+850GAY=
=Tnpb
-----END PGP SIGNATURE-----

--sQQqcF09hnnBo1Wo--
