Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F019DCF8864
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79C1483A6A;
	Thu, 20 Nov 2025 17:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hH2n+h9S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6AE283A6A; Thu, 20 Nov 2025 17:06:25 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63AFF83935
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-656b8ca52e8so424489eaf.3
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763654782; x=1764259582; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BPQHyOZll0Z0BeZt2j0P5Oy51JJGXlG4WWshMjIdo7o=;
 b=hH2n+h9SMcohUzyttg6ZiUICk5dgrI6Wc/Hha6WzhQACWOMmhAdK+oyea4eyOmWsI7
 9J3l9rjVexxVvG0LrLXKh9w/p2+cN6EywkuLNbtGC6wdC9vt9qyXKhDkpJYK5oPt85rR
 2b+rwu+9kNIQ+fWdwSXyJFU9O8u4nckJUtoEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763654782; x=1764259582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BPQHyOZll0Z0BeZt2j0P5Oy51JJGXlG4WWshMjIdo7o=;
 b=UsP85N92ekHVb6Ojn4C0IemEWv0QrMtffyliFG9TsMxKPewXwox69nKNXKhEYHjFh3
 bY5urY1MhqKKQ+IigRzT1w7WpQZgL5WycC50ASYmnslxWgmR6/5Bz4GrfBzCiIwEq7dC
 nnxpFTRx6o1UR+Stwqlk8rgNFNWShBCXWLcimeeoA5aYKjDNhTFqL5B0C2p4oPLzKDGo
 wwDPUoLWJpKmgpPlJkRYCR1qFv6jYxSS/+iLMxNNPDSt+9piUV2uHOva0hhlOzUbEeGA
 66hvDd9tuev6wRbMW580Qd8VqM2l9dbwrYtoiWzO2IdlVzQNuXHCJEzLIVguhqzasvvG
 mmEA==
X-Gm-Message-State: AOJu0YxeHtUJcdlFOYK8YC2P2vqZZIdJLsy2FqNIkShKJm9hQEy0P5tG
 Qnc5uXmo8YlIOOFk1FRVnAAkjT1v8eaKkp2NvgNnT2NdEV7rlHMeV+K1ETN3wEPwxCJ2vScgw4t
 aj1ndlps=
X-Gm-Gg: ASbGncv8x0F4sA/aaMog/H5cZDDqZhDlbMmLYKDu5pMSCWj6yHnbngF+HAE6wbYDvQ2
 hXCXpZaURqYdyAEXSPuTI9kzftT7C7AwOs0bufxIIqzF6YUI6ZJTJ1tb9lrPHEo494PW7hvFHNM
 nLcuR1Akq1SGr3KhYqk33nM4o29AdbCyjhuBuf/D3jMwYlPxJyHB9dUgDQZ8kU6VV562IFQLcqW
 54BfqiC0jPHAhLIV4yg4IuBQR7O2vJffwTYlPfr0dPkO3TPDx1jJX7viSp7kwjJSkBaGnfJECKy
 RIIRQZXMr+ZEenpT/+DTduOZeYo7D+ixSRrQ5ylU1mwz77jwBfN8HMf16CfVp397K1dB1bhrIgV
 ZkuJf5R+I1SlEMwivYe9fdMQGPgd1ZnzZhzt5WsXe71VWabjW1FAWfWFNJOuPfnPyTk3J43zXXZ
 xPcJ17pXWhysNiP7y0yEprMGAhqdSbFM1YXNbBc3lNBS+DTtmwqA==
X-Google-Smtp-Source: AGHT+IFflTXXPOj70p3XjpWP41gTUZ34qadalYHX/HgOqFuxJYSoQzV/bZAqcpiKbECOcaiFsYaquA==
X-Received: by 2002:a05:6808:190c:b0:44d:a3d4:902f with SMTP id
 5614622812f47-450ff3aa088mr1654051b6e.52.1763654781988; 
 Thu, 20 Nov 2025 08:06:21 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450ffbe9a88sm759256b6e.0.2025.11.20.08.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:06:21 -0800 (PST)
Date: Thu, 20 Nov 2025 10:06:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v2 3/4] Gitlab: sage: Add Pine64+ platform
Message-ID: <20251120160619.GJ2125796@bill-the-cat>
References: <20251118210015.624758-1-trini@konsulko.com>
 <20251118210015.624758-3-trini@konsulko.com>
 <2b123aec-d0bf-4cf8-9f4d-32ca2865d6ab@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZQn8jOaaTGYtwJTL"
Content-Disposition: inline
In-Reply-To: <2b123aec-d0bf-4cf8-9f4d-32ca2865d6ab@linaro.org>
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


--ZQn8jOaaTGYtwJTL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 04:51:46PM +0100, Jerome Forissier wrote:
> Hi Tom,
>=20
> On 11/18/25 22:00, Tom Rini wrote:
> > This adds the Pine64+ platform to the sage lab, for both legacy and lwIP
> > networking stacks. In order to build this platform we need to copy
> > certain files that were built in the container to /tmp and then set
> > BINMAN_INDIRS to /tmp in order to find them when building.
> >=20
> > For now, we disable the test_net_pxe_boot_config test on lwIP as it
> > leads to a crash that needs to be investigated.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Andre Przywara <andre.przywara@arm.com>
> > Cc: Jerome Forissier <jerome.forissier@linaro.org>
> >=20
> > Andre, Jerome, how would you like to handle looking in to this issue?
> > https://source.denx.de/u-boot/u-boot/-/jobs/1303375#L2235 shows the
> > crash and I don't have enough sunxi targets to know if this is more
> > broadly breakable or not. But it doesn't happen on lwIP + Pi for
> > example, nor lwIP + Hummingboard (mx6cuboxi defconfig). I can't at this
> > point give remote access to the lab directly, but I can help come up
> > with a gitlab job that'll acquire the board, build and try and boot
> > whatever you have.
>=20
> Well the crash dump doesn't tell much on its own, except that we have
> an invalid read at address 0x17. But we do have the ELR so it would be
> helpful to have the u-boot.elf file. Could it be made available as a job
> artifact, especially in case of failure (or always)?

We do not have a literal 'u-boot.elf' in this case, but we do have the
full u-boot file gdb can read for example, would that help? Given that
we expire artifacts after a week, this is probably OK, or maybe a
commented out section for "To debug things, add ..." if I don't see how
to only save it on failures (there are options to do specific actions on
failures, but, need to look in to it).

--=20
Tom

--ZQn8jOaaTGYtwJTL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaR88dwAKCRAr4qD1Cr/k
CqfcAQDGbGYtkNj+Q1kekS+DdV4o2umcguO+Z1wE8mjPQBwnjAD8CXYnhg0G+q1K
YVOe0OV+lPEaYcDIdoeUAmQiDnihEgg=
=HV1u
-----END PGP SIGNATURE-----

--ZQn8jOaaTGYtwJTL--
