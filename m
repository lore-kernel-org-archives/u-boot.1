Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F71DC55838
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 07:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D126D80CE9;
	Thu,  6 Aug 2026 07:59:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yPBC3z86FXm0; Thu,  6 Aug 2026 07:59:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C998080CEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786003168;
	bh=fZAGJ6zA7Ie1fu5gcO61c20EY3SBDrCPyKQFqFoz42U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l1U/Sba/uwSatDL/WMuwp+Q0Xh6vRUqaFocP3nDzDJaPesznQn9vnpVdEZl/4KxW8
	 qJxwKGXMYzndokOMe3haY1C+5xVhCbNfPGjlFUJ5W5wQx6hxXF+rgXaBHdYuUqQ/Fg
	 sCBHTlSpXz094aWTqtDhZ3iIYQfflsAGwzQIhonsd07Cmdp5wnY9vU2O6Eh7gaZNvj
	 k0ZajeY5YQoJJHo/aylyBY1ZhhdfOgAcGTO1bNOOU+IwRKHSXZOssQfggkdfB1QN15
	 MND+KD7otLbbkMMEnAQqWwJHI5uIZTyRJJgw4RMo8hvSJk+tHOBaFTCufYNwhDVcN5
	 lQ1Nvw0VDhzgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C998080CEB;
	Thu,  6 Aug 2026 07:59:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EDF1F1AF
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 05:48:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF91740536
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 05:48:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YlELFy7IzBLa for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 05:48:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ukleinek@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 377934052B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 377934052B
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 377934052B
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 05:48:42 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso11352455e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 22:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785995321; x=1786600121;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fZAGJ6zA7Ie1fu5gcO61c20EY3SBDrCPyKQFqFoz42U=;
 b=WL7uJmGxM0IP3uvj/WKOhUDGKE+NKxMWihojPJsZ583mfj6vO7WIbu40WqcULYf7Lh
 Sne3g/1YCa7OHtyiez6JC/SybTQGu7KmwFw9jMJwuXGYdXXn7kQjmlKLKPTLILRU5ekI
 QhZrMYJRq9PEZ9OJtpEwj8UK3BHAajvXH6+MhBjn2lV5tOsU/RfU4rZXIQcOUQpocqsa
 hqafgMoXwqHYvrEJl5PupABPMxpr/u5pYN0A3nUsFk2w0Wo1upkZaHqO+4qG5cJS5QfC
 tEBCynBCVbYrVniZS/6DjAZm6Rl8qIn57DbOG0YNN3/oLHGY6JMrv0XPtfOpklP7peKa
 Bf0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqjEMcmOo+TcBu5h4YM9eny63LpvVLIwI0hqjAXlFliy7BL45GL9NbHn8xu7hKrn0QzTWGOcz0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxQCfAr1vfMPsizopAFO1OE/rw4t+aLt8wiv0sOB/2a09g/R8gu
 CU34kOE7bU6V5T37hR8vlPkx8UlewTUoxZLitHt0zoBMsAjOsCgKuo9Yx5vWXETOOtU=
X-Gm-Gg: AR+sD12JSNdE/HsvSEixGTRIjhaCljrYRT7gaGDquGaReMbNC5Tbkgdso8j376S7B3Z
 ZjMhl3nOH9gYXvEUKQyktT4j2PcIij2b4phcz2E3L7E+zlX45FzUNBbHPNcJuUg9lJM++zQmQrN
 j+pcm1BN57P7gEelSu9rFZNQxI8+WnkfOUqqe+lrbzOmKjmOiH+qpFPsDzAXjfhUk8KzYeNA/wr
 /0atyz7j+cBXiV+jwPmq1m0sI35JnAulpwuPjMlmsdVfnJJT4G6y8aPU5ULy6iCzUWaBbYGPnI1
 dU9AJ9nPcBUxxjFKRfz8Kl80J+N1uGpdFWyOx3gDNnkfQ9yinQCkp+pjaO86k03ou4PwsY0RZTG
 wLncORNLQrYjcTbx/C2X9HFxJjGegHavkmA8rOMFGCGXpqFaXCCAZZ9GHCNH/4x3z8WpeCGBYOC
 p2BjgtfjdW83pDUdN4KoQTw2IJ3MiMKH8YwCF2/FgsIA0qQnSqd9n5YJ3XssW3NvSy6ZZf69izS
 J7S
X-Received: by 2002:a05:600c:354a:b0:495:3e08:ad19 with SMTP id
 5b1f17b1804b1-4994e7b72dcmr159710605e9.9.1785995320396; 
 Wed, 05 Aug 2026 22:48:40 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47ff79a71a2sm3013212f8f.6.2026.08.05.22.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:48:39 -0700 (PDT)
Date: Thu, 6 Aug 2026 07:48:38 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Malysa <malysagreg@gmail.com>
Cc: Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, Tom Rini <trini@konsulko.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Philip Molloy <philip.molloy@analog.com>, 
 Ozan Durgut <ozndrgt@gmail.com>, Caleb Ethridge <caleb.ethridge@analog.com>,
 linux@analog.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] arm: sc5xx: Enable BOOTSTD_DEFAULTS
Message-ID: <anQcSAqpLeHDCXM8@monoceros>
References: <20260804104332.2585195-1-u.kleine-koenig@baylibre.com>
 <CABdDSeV3tiEeVE=_YNn33JN1KDU51h-q8TBOv-Y31T1yF26EkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4mb46dnn2onz4ys2"
Content-Disposition: inline
In-Reply-To: <CABdDSeV3tiEeVE=_YNn33JN1KDU51h-q8TBOv-Y31T1yF26EkA@mail.gmail.com>
X-Mailman-Approved-At: Thu, 06 Aug 2026 07:59:27 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785995321; x=1786600121;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fZAGJ6zA7Ie1fu5gcO61c20EY3SBDrCPyKQFqFoz42U=;
 b=AYvRYqdgnO7eeR4Z9FqrtZ+hqjo0YjwLfrRo3A3CpnHgC4PZoSi01hny0NOnOxxis/
 7p0KH1IQHeYlOZK1u5jxRwKSaXfFZYuIMGjchX4hruMjfI/fQN/bYn8B9QlOXpeBnnH6
 b+CGDGS9Y5yzpu3qtCYj7C93FN421jjAO1pgbh/yF+cvRl/ju4xhnZN8WzuJ+sLUngZL
 mbWyeAbJ9sK8UnugnK0KMOvW/hKqZKtpNUnZhu1AwJT6MeT5/YwsOwpjpEltY7YsEMoA
 B024pmCpo2aUkSCf8EOdhRIWA4Aw/H4WdQ7OD/7zmT1vPdGuNnptwVMHgSFMwLT4imwT
 0pew==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AYvRYqdg
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--4mb46dnn2onz4ys2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] arm: sc5xx: Enable BOOTSTD_DEFAULTS
MIME-Version: 1.0

Hello,

thanks for your feedback.

On Wed, Aug 05, 2026 at 06:48:56PM -0400, Greg Malysa wrote:
> On Tue, Aug 4, 2026 at 6:43=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > [...]
> > base-commit: ece349ade2973e220f524ce59e59711cc919263f
> > --
> > 2.55.0.11.g153666a7d9bb
> >
>=20
> This patch does not apply to uboot/main or uboot/next, please rebase

Oh, it was based on master, didn't notice there are newer other
branches.

> it and resubmit. Note that the sc573-ezkit has been renamed to the
> sc573-ezlite since the base commit referenced here, and another series
> has modified things like the default bootcmd.
>=20
> I have additional questions however:
> 1) This enables things like CONFIG_HUSH_PARSER, CONFIG_BOOTP_PXE, and
> others as well which increase the size of uboot on an already tightly
> packed spi flash. Are these needed or intentional? Why not enable
> CONFIG_SUPPORT_RAW_INITRD individually?

I did that because in general I'm annoyed by (vendor) U-Boots that lack
the stuff that is considered good and needed for alternative Linux
installations.

> 2) How do you intend to use a debian image on these boards? The kernel
> does not currently have mainline support or drivers, and the SPI flash
> memory is likely too small for a debian image, as it required
> extensive tweaking in yocto to build root filesystems that would fit.
> Is it going to use exclusively NFS as the root filesystem?

My usecase here was to be able to start the installer to create a rootfs
on the eMMC for kernel development on "my" sc598 board.
And I'm using a custom kernel with the Debian rootfs because indeed
mainline doesn't work on these machines yet.

> 3) Why not make the same change to the sc594/sc598 boards as well?

That commit is a port of
https://github.com/analogdevicesinc/u-boot/pull/136 to mainline. I just
modified all non-spl config/sc5* without much thinking.

I will respin this series on a newer base commit and verify the
resulting image fits into flash---at least on the one machine I have on
my desk. I don't know other sc5xx boards, if some of these have a
smaller flash, enabling CONFIG_BOOTSTD_DEFAULTS for these probably
doesn't work.

Best regards
Uwe

--4mb46dnn2onz4ys2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp0IDMACgkQj4D7WH0S
/k4Fgwf/TyuJ7QXuOjjz6gmkPGEBq+1a64bvGt+KsUHqsAhrRnWCtYP/2jHWBkwR
appVEK78AlrDBaMiLl7XXNrzkYxyL+oBd90Tw7DpIWRXp21onGcVEEoZs6ZvG3iJ
GWrhoqKuvr74BV1t8EN04FBI5gVNisrmsUh5gUYCOhqXxjcvgZPNfCFNc9SM+9Gv
GfK2cTKLfL/0SSkyAGyqhftMJZl3nrhomHvf6Mb14ktktJqcD4bif30WiK1VFT9s
VTB2x20D20NRfzxa2yNSmy9j3EWwrTWBPRQm13G5/xmn9Tu5FbZevRlAJVI/KMwn
4OfXz34OaiZz1omYzPbYEBFmCqm7ZQ==
=hZ5E
-----END PGP SIGNATURE-----

--4mb46dnn2onz4ys2--
