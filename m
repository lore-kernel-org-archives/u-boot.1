Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3A7CA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 16:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E17D839DD;
	Thu, 14 Aug 2025 18:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TUCJn/9y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B148839DD; Thu, 14 Aug 2025 18:40:28 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E24F6839D7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 18:40:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3e57376f5abso7822955ab.0
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755189624; x=1755794424; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CSw6OLL6MhAGVP+E9Yk6VG8nMmU0d5nGL0U2+WeCvKc=;
 b=TUCJn/9yaOhryNnsrPO4lKDEIBkWYHS3OxkgCcq84TLpUEcJUUGAeQlivjCH7v5MF+
 S60U026IXknnTJ4rEdpLXD4RAPAeNMWn1ntMy216RNCc2D0CUUBgRkSAXSzDiuMMUQN7
 4dhnNqERMMfFFT0oWh+CjXp5dw8qU3Duxa6Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755189624; x=1755794424;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSw6OLL6MhAGVP+E9Yk6VG8nMmU0d5nGL0U2+WeCvKc=;
 b=OOUFGK3wNbFhwwKE+zOJfXydEcSm6FX1us3PX4ba9lP88XrqPop/rYfzyLVXlqaX5w
 9fpR8Qo6C0LdaRALEuwHho1Z7adW9qL8ZXcYiSwYrA0T1s7Axk8sVU+0/K/zpGrIilrT
 JOjE59NYUx+X9phje+zLcbEnW1CQ0ZVEmNiGoVfFDzVKkXGyZReohJ93+IVM1izvTioN
 xVxdDhr5Hv7T79L6Dvirrn0ec5he9ZiE/JhYr5yV2XilEMS96Nc5Kyoww23i+FHFnud0
 v0YTN0PXy/Ma9gS9R0vi15c2z8LyjjOOABtc5XU2xzAJr2mKndXiuOLuKed4Zzc5JKh2
 4vxQ==
X-Gm-Message-State: AOJu0YykcEZxPe+CI9DkzBrZO0SPwLOxwbZIoCiFNQS68+/s0Ah0xGaM
 HLzCqgr7BIMrFAIk/Gj+uL8Y+YnqKRhQwZFaswsAXNuSHsGLgbk9NGyXRCJ/8+dpbCoXGyN6Er6
 5a0uPfLQ=
X-Gm-Gg: ASbGncvqS8d76CBsFMCBBb0eYp+lGQ7MTt4lz1mudCXmuH3JqkcS3wMe4JMEv24YCxl
 eg0IPDT2/qPLR0icPLPDGLxpFagLMMkgW41ugifCCT9EIXZ7X4YHxFzRgCNI/KXU+uDD80buli6
 H3xSUMI+zJpeX6ONnd+ux7HtABn2XNx45nmO+o1IY2OgQdEhi/FTXqz70BxMgLU3NSrZiAT04Qx
 dp/U0b3113rF++Xm60Z3u9/Os8x1/9qbXnqPMbmHopEp0HwBW/y//z0IsOwZH8UA7vHuh/FXgKy
 J2eQ/3vS4MRj3Izb1PLu/IzT2ZIxqo25Ols34DjYT7ruVulCyWiTL2xcAiQCVBkH2nJA9+HSTxw
 yetx8tkIcci/NIp8zzEoRD5gzFCGPIKmKti5/mMeB2twUHRVAQMqnsE1x
X-Google-Smtp-Source: AGHT+IGYj6fGo3O6KG4TnKlVeFuAoOV6ux4jirVEgGGd3JrOu9s2y9wYhP0tseiA9iKekU8WotE9Tw==
X-Received: by 2002:a05:6e02:1445:b0:3e5:5e09:4487 with SMTP id
 e9e14a558f8ab-3e5708ea1e0mr73404255ab.21.1755189624522; 
 Thu, 14 Aug 2025 09:40:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e533bd29b8sm68634495ab.3.2025.08.14.09.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 09:40:23 -0700 (PDT)
Date: Thu, 14 Aug 2025 10:40:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Marius Dinu <m95d+git@psihoexpert.ro>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] timer: Mark this as incompatible with SYS_ARCH_TIMER
Message-ID: <20250814164021.GM124814@bill-the-cat>
References: <20250813205511.3420638-1-trini@konsulko.com>
 <20250813205511.3420638-2-trini@konsulko.com>
 <aJ4OR2rhl6eFV3GE@GRAPHRT>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WyCuwNcXBWzJyCFq"
Content-Disposition: inline
In-Reply-To: <aJ4OR2rhl6eFV3GE@GRAPHRT>
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


--WyCuwNcXBWzJyCFq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 07:26:47PM +0300, Marius Dinu wrote:
> On Wed, 2025-08-13 14.55.11 +-0600, Tom Rini wrote:
> > The timers implemented under SYS_ARCH_TIMER are not part of the TIMER
> > framework and thus cannot be enabled at the same time. Express this
> > dependency in Kconfig and add a note to the help of SYS_ARCH_TIMER.
> >=20
> > Reported-by: Marius Dinu <m95d+git@psihoexpert.ro>
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Marius, I ended up reworking things a bit (and also found part 1/2 of
> > this series) but please let me know if you feel this should retain your
> > Author and such instead. Thanks!
>=20
> No need for credits.

OK.

> I think you should keep the warning message in the Timer drivers menu.
> It provides a quick explanation why the menu is empty.

I thought about it, and we don't do anything like that for other
either/or choices, and it's now in the help text itself at least. The
other thing however, is that a few platforms do allow for both, because
they play some games with CFG_SYS_TIMER* defines. So I'm not entirely
sure what to do here.

> Bugs are reported in this mailing list too?

Yes.

--=20
Tom

--WyCuwNcXBWzJyCFq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJ4RdQAKCRAr4qD1Cr/k
CsIaAP9Uy5NqvTfPZxu6J1ldURxnEVn/HnU93eMxhrbSi716RQD9GD5QQ6h6ydID
S4D1OGAbI17t26PTUUOCfCXvHwztQQo=
=heoh
-----END PGP SIGNATURE-----

--WyCuwNcXBWzJyCFq--
