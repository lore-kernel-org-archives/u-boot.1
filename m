Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EF4CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 20:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D682836A4;
	Thu,  2 Oct 2025 22:16:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FWCX6g2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EED1836A4; Thu,  2 Oct 2025 22:16:01 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E0E283693
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 22:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-930a6c601b3so127399839f.3
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 13:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759436157; x=1760040957; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M2jwitKWpNkhUMxH4WooZbpIDV2d//ii/O0PqP1ipKg=;
 b=FWCX6g2Z/vHt9404QyQzpKvNW67NdfGMTcCys32ScPaEo0Ecg6D6ldZ+z5zxxO0tZ8
 VRI9Cpft6z3Zs8yAA8TOBexetY2649PVW+APoZfRQqJ4pkSNr+uz00AgMCkN8fjPs8BA
 IC2wwvVkfz524qE9buPl5D1boimhZK03u5frA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759436157; x=1760040957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M2jwitKWpNkhUMxH4WooZbpIDV2d//ii/O0PqP1ipKg=;
 b=PyqRnrFnd5d0xJrcJzRM49YeknBs3mxA9/SOfF/hsB5AE1vqNSW/MvXcZg2pDgQlS7
 Hg+ogKGGk6bf/qH99/J8ZTjhOYbucDbp20XpAIf3UdPGkWL3rAHKxN25vTNqjxFe8rbt
 z23o5BruKIf1m4gd4gpa9A8wc0ElYcu4uZrAtV86vT9acgC27uXIl1IKCIKu02Nexa9C
 0iLsB86tZU5i+1TwxYEZeMvF7OUxn5xNimsLop49rpYvwgeFLCyhwhCCbndTTNIspdBN
 nPEi5n49HCXPY7L9ngoZueqx4tsXfYX3bFVqr2Xi7CQynIFHmrY3ejgKrahUnlFWEtlJ
 9kPQ==
X-Gm-Message-State: AOJu0YyF8EaikUARzSppZRzHvFwwRt7o60A+BwXdvfMq/Vm2tDF7/o5q
 HvgYA0qc5OAC8/3dVVnvB9nwj1vXskFV6r02J/cfvP3MvUjwq6Wa7XNMzkU3+RiwAvY=
X-Gm-Gg: ASbGncvfnze+Uqr3VDeEVqOn5yh76+NTj0/2mTeDd+5XxC3xpa2fU/eOso3gAkTreq9
 8dUgKcgfePusYCZxcjysq+SKFGICyfEPAGnL1KddSDg9yvUnH0IlV/WDPKfFp5IgtbFniJq4AHP
 tiMc4nkpDMe5M3OvXNpCCUUtkc/5jv4/Qm9iIRhj0Xz047QUrrLoN5CHYGofisq+zKqez+IPavd
 SfGJQPr+UW+VCxaVzX83ZgE6WHDDe9UEu3VeIa9RecpsOJGKaB95Zx/x5P3Wuxr/XVyd2V3f5vC
 SfXkMe2Elh36urXGCxk0VA2dW7SU0Zz0T/DSoYS/0fDaZvg2IxWcye6LAoA/q79380OVdd8+hxb
 Jpf853VO35HfQhkj2mpkJpxA9rr8tk06//b3fTH9zxMmhuqQKeDBaRysrPMDncuT7ZF8XHMzfZq
 eF4zLqrvP1sQ==
X-Google-Smtp-Source: AGHT+IEBdHfC1u8SEsWP5B3O3LbQr/8MbSyIciyLgR7akIviJGf0ZqUDT8DalSocSN0rLj8J4jWu4w==
X-Received: by 2002:a92:cda3:0:b0:42d:89b9:5d30 with SMTP id
 e9e14a558f8ab-42e7ad887d6mr9183535ab.19.1759436157290; 
 Thu, 02 Oct 2025 13:15:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42d8b281774sm13152075ab.22.2025.10.02.13.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 13:15:56 -0700 (PDT)
Date: Thu, 2 Oct 2025 14:15:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>,
 Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH v2 17/17] boot: doc: Update for new global-bootmeth
 features
Message-ID: <20251002201554.GQ6093@bill-the-cat>
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-18-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YNQ98X5MSE4xWhbu"
Content-Disposition: inline
In-Reply-To: <20251001212649.3263574-18-sjg@chromium.org>
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


--YNQ98X5MSE4xWhbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2025 at 03:26:42PM -0600, Simon Glass wrote:

> Provide some developer documentation on the priority feature for global
> bootmeths.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

We should be doing documentation in the patch making the change, not
standalone as this isn't "document old things which weren't documented
before".

--=20
Tom

--YNQ98X5MSE4xWhbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaN7deQAKCRAr4qD1Cr/k
CkbSAP9tnloycWQlCIOnbIJtfE+yLyLpMgh7B8pO65lK6RH+FgEA+Be+m1OYe+Ca
nJl/qTTTfQ/e6mXbYuK/vyirCzZOIAc=
=EmlR
-----END PGP SIGNATURE-----

--YNQ98X5MSE4xWhbu--
