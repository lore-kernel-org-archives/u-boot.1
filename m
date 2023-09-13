Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA46EDEC7C
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 16:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B9EB86B9A;
	Wed, 13 Sep 2023 18:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bLKXMxHR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 104FD867D2; Wed, 13 Sep 2023 18:22:24 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32AC086CA7
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 18:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-58d40c2debeso72332587b3.2
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 09:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694622139; x=1695226939; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eb4sQTLg9gaUrTg5EsiDPbIZroL//Xn+2bq+UCasE0M=;
 b=bLKXMxHRYHm65MWMH1Q8b7WLMbDPLzL4ZJY0VpdxXhLCG+Bb7YwjJ0K1cZy+TuSp3c
 H45Y5XRUwCVQlUlE5cE+k8BarI8sXX3BMZ8nXPxAlR3V/pfpU8Ix4ry2eqAZ9f9Jypes
 aSUuBCMRkqVZqD7SmCLZo7GojDj6/wDmSiJvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694622139; x=1695226939;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eb4sQTLg9gaUrTg5EsiDPbIZroL//Xn+2bq+UCasE0M=;
 b=mqV22hcCp/Iaso6XXG6M4IxNxql/rl/WhevIk4h5Os4D32bT3j8PZ7UWTNxcWyURWC
 QlRih3TOpWgkmjYAK0Doe6pDXis/H1xvOVeo2eUEisGuiySnoahX9dE9YKPDvNU9zKAY
 ssAc46I/c9a4GaZcRpZBpuqR3+WEXrSe663WpWCjSdkicDBBdJ3fc5prsFtoNcrBEItE
 0JFv9QInBPjJd1Aey5fiVt+KGIkn8vlIHeVAS4KbyL9g5YA3z/wObFSLwt4STx3u32Is
 HnjpNsEVEa2Km7Hi7Wp5PGmx7jNg8+c8T7BBoYrSWSB5NUj/5CPa1vf7v/7CrqabLJqv
 nclA==
X-Gm-Message-State: AOJu0Yxu1BtPtyEuI2fZ+myMFIT/qkFPtQAEkt80BlYwCKXz69/mLlQJ
 H8w+QU9TaAzew95qbSstY3ZMUGoyn1ykASbsh4y7sw==
X-Google-Smtp-Source: AGHT+IG9vlKUKDSQZ6cd3APuh5FLQvcglHPj3cI3ybLcu0urPHVvsCyGNbs6oBouLAh+Z1hbX/uZwQ==
X-Received: by 2002:a25:1545:0:b0:d81:6116:ac2d with SMTP id
 66-20020a251545000000b00d816116ac2dmr1699599ybv.59.1694622139670; 
 Wed, 13 Sep 2023 09:22:19 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2580-cbcf-c7bd-45ce.res6.spectrum.com.
 [2603:6081:7b00:6400:2580:cbcf:c7bd:45ce])
 by smtp.gmail.com with ESMTPSA id
 n62-20020a25d641000000b00d7f06aa25c5sm2813152ybg.58.2023.09.13.09.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 09:22:19 -0700 (PDT)
Date: Wed, 13 Sep 2023 12:22:17 -0400
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>
Subject: Re: bootstd: CACHE Misaligned operation errors (Marvell Armada 385)
Message-ID: <20230913162217.GN305624@bill-the-cat>
References: <CAJaLiFyTMW40gdMRjQhSTcUb_4ZRtLPo119EfBih9k_bcpNbdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pfIvXoi1udMDwDkJ"
Content-Disposition: inline
In-Reply-To: <CAJaLiFyTMW40gdMRjQhSTcUb_4ZRtLPo119EfBih9k_bcpNbdg@mail.gmail.com>
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


--pfIvXoi1udMDwDkJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 12:38:00PM -0700, Tony Dinh wrote:

> I've been testing the boostd for a few Marvell boards and seeing this
> error on the Thecus N2350 (Marvell Armada 385, dual-core CPU). The
> "bootflow scan scsi" command triggered the "CACHE: Misaligned
> operation at range" error. However, this error did not affect the
> result of the scan, i.e. the bootflow for scsi partition was created
> correctly, and u-boot is running normally.
>=20
> Enabling CONFIG_SYS_DCACHE_OFF got rid of the errors altogether.
> Perhaps this is a case where the DCACHE is not required and should be
> turned off?
>=20
> Please see the log after the break below.
=20
Can you please try -next ?  There's at least one SCSI related cache
alignment fix there that's not in master, thanks.

--=20
Tom

--pfIvXoi1udMDwDkJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUB4bkACgkQFHw5/5Y0
tywrXAwAqgHlrUZnLvip+zwwa8TmCtzKdLzLorPMNmBYNZOoZv5JU49ZLkucsAiT
AJAcjQ8AXVlusH7emD0t4Lv2f/b2JGCjealimnEkExTvS1JfkCS/5HxVtlYkIpTD
eWc/yjIv/vvZt202qXbhbXgt40FZZCWr9kRihK/7wMwPfBJPxExqJHgTiE/C2S43
A5+8RtuW4eZ9KeVqy45ergCEK2ocrb29T/gTYlIHDT+5OjN7jjY4UDjNosSZaOB7
vCPhAjYx8O2ViM4iDpwDoGIbxiH4k5dCYQyy6WOimz2zd+tjL77TL/rHB5vEeSzl
I/3xK1P3Jpd7QJ7RCez784HhYksGw+zHL9VsCkDLQA9L6tDqIzwinGBBuh3KEdZh
1qGIS2Sjw0AULzmIjZpRJTR1P+Mic1dfr7ptnBY9d1MKyTfLISsT/zmXjhyq8d8F
hOd2PzDOy42KweVBHl7QQb42iiAm0Ii5PLXGtJKtevHZB38dPWm6VUUJYLBEmFox
dVReN/XO
=yr61
-----END PGP SIGNATURE-----

--pfIvXoi1udMDwDkJ--
