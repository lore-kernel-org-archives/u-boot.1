Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A71C02196
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 02:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35716800CF;
	Tue,  4 Feb 2025 03:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y/wnCllv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BEA780104; Tue,  4 Feb 2025 03:00:16 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09FAA800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 03:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6e2362ea655so39172456d6.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 18:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738634413; x=1739239213; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eKbQUlXSKl96dgbLE3vsIM6UgxjWt5M0iTArI8GZ+5U=;
 b=Y/wnCllv26iEzRO4ZGy9d+MVuNhZcUpYeyIhmvALjfaLKy7nFY+BXjRc0KhCWgt2Uy
 Pdg4IaPAtBDCGr5G7FS30D+Rr4DQSAYhNH2Q7tI+ccK5xdbAnAkEX0G3lD4mOeBMKJZs
 E5H4rWhpvosG4rlRtl8Rr8HT4COxOd1nLzqqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738634413; x=1739239213;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKbQUlXSKl96dgbLE3vsIM6UgxjWt5M0iTArI8GZ+5U=;
 b=ZPoajNIARCCRaoxMhzKbh6OIypnmYIv4O6aKt92DbBA1I++emY5Hxh7c1rxuDHRoYC
 d4t2G7JkiNGn1nazMGAU1c6R0XrAjZO6In51gxfgPd0FWNHQmj5rCoMQUhN6iNYZwoWB
 NRiSB/g1G1egsSxON0f+WXU01lRpFmxUKX7BPuV93DbrcmXNKkn5bUcvp5Rp04myN1B+
 lqoYtBpQ4TK6DLDgOxdRsSy27vOqN/GJ57t742xdYQq0/T88JrvIVgn6PbDsvVnzSR/1
 tzlzbQP3/wp9RzoAbHCTFiNTCWXR5atOhqN9d6fs4TeEkirLr9TDdiKlK8uA3xp7HMor
 wJ2g==
X-Gm-Message-State: AOJu0YxfovQyZ1MTvKcJVOtu+ydy0e9LcpAq10HJnizbARrZF66chwTQ
 75Zp+eMySQowoCGohZPVnZvXYRVek/iXGAzpPgEeZhb995bX8FAFBC3U5Ri7HaI=
X-Gm-Gg: ASbGnct2aUhggATM3by/aAOMzWnjGHtGX9qXT9qQZ5O/JvVHHeVbYNG9E35ZbUql9/C
 QSfMAZP1s7JffxDk6+AzVFwk/kQTRTlCA2g2yZitcnIQ4JRXkppjnZNHhPr1QgYpcUCX45cxd/P
 DEI1h8EdShelCQSI5atoN9WkRGRVV+ovsSVkSfrfOgFc8LWHJ0gzX2vQO2wsqgVfSGr1IjrFH+X
 HUDCCZw3kNycfAG7Zlmf5OBzxZfEG8xymGstEwyIK17YLwbGfS27JqfUJXSsxnugJHLAEZoFTmI
 qN0aUBsu0nswdaE=
X-Google-Smtp-Source: AGHT+IEFGLI2URtyAwPcktLCcPUUAZTVsyFT0X5Kr6BzHq+AdbnwOl5rYignpgtk0y+Hk6TJh+JROg==
X-Received: by 2002:a05:6214:3007:b0:6dd:d3b:de38 with SMTP id
 6a1803df08f44-6e243bb8914mr382770916d6.16.1738634412721; 
 Mon, 03 Feb 2025 18:00:12 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2547f0e7csm56516686d6.1.2025.02.03.18.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 18:00:11 -0800 (PST)
Date: Mon, 3 Feb 2025 20:00:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH 21/32] efi: arm: Drop exception code when running as an
 EFI app
Message-ID: <20250204020008.GB1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-22-sjg@chromium.org>
 <20250203200937.GL1233568@bill-the-cat>
 <CAFLszTgO-nErzRg4FnM3rGCeHgfsAKCui3p9OhqP1YipyyN3=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="50BQn6Wr7/kXjHM3"
Content-Disposition: inline
In-Reply-To: <CAFLszTgO-nErzRg4FnM3rGCeHgfsAKCui3p9OhqP1YipyyN3=A@mail.gmail.com>
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


--50BQn6Wr7/kXjHM3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 05:38:52PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 3 Feb 2025 at 13:09, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Feb 03, 2025 at 10:42:14AM -0700, Simon Glass wrote:
> >
> > > This code cannot be used since EFI is in charge of managing exception=
s.
> > > Drop it.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  arch/arm/cpu/armv8/Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Why is SPL on in this case?
>=20
> SPL is enabled by a specific Kconfig option, which seems to have
> exceptions but not exception levels. That seemed to match what the EFI
> app wants, for now.

OK, so why aren't you turning off SPL? You're not using SPL at all,
right?

--=20
Tom

--50BQn6Wr7/kXjHM3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehdKQACgkQFHw5/5Y0
tyyIFwwArdN7Qe2qaVpDnHCo+ztwqo4p8KGeuQc0S/jns8D/tG2GTdJT4rpzk1kI
k+lEL1r1hOXzGz4dQX5sZU/ls6T5odCfMSZxPYvv3ZRBZJbO7BsaEFUsx28t2mVZ
SPARXxkXVtlzldYC9KC1pvHN0iU7wkZ5hd4Ti2Jyt1YKOgqwe3K6SHeaGnf4SzR4
sh5p9W8/vtc4sGPtYgX0l3KM+TTSaKhuK+0j57AQTVoBbfTWAs5dI3RC4ccSh2kV
4Q38Uth9OYX0wgJpinAGcoVdC/c8541Ebar/yDT8gDrU9z9q7D2g9HOman2JtjqH
Snf1b5ADyuXZaifNWi8AjdIX837DdlBvUIyYeDdEpwUONryW8xPlTFWENLtYAcoi
l+NgFFW/QzKmSykHqqVbDgFLpeA9jsdfTxF5WKD2A/xcWIq6wisej/guBBMwOZwE
eyaB6A5qj6cchPGVx4znedY7hDBE3AOr3fVNy9OGRNnFuNcmQBkLSsKTSTaVH9Fn
RJ/n/g7+
=yGPj
-----END PGP SIGNATURE-----

--50BQn6Wr7/kXjHM3--
