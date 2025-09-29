Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E658CAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 20:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 733768329F;
	Mon, 29 Sep 2025 22:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qVpsbpDa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3677E832AD; Mon, 29 Sep 2025 22:50:31 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B22358319C
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 22:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-74c7d98935eso2745531a34.1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 13:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759179027; x=1759783827; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6epCORIqy4AKWe6ipJ10ukCT2IKEuD3aTQSgWJb4rx0=;
 b=qVpsbpDaBG5mYJQPCY9vrCDg5fEGEe43ICz/tmihkXjsaGlj88J3NdJX8+95Wge4N4
 vLdeUw3seIy9ysgwqj32ZfJhiOU7quillFYsntkqW8vbrgcaNAkI956U2sePqZhdW1Ew
 GEe6+cPX9t1aJw0mqLqsQh7ohipQzQhvF1ULE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759179027; x=1759783827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6epCORIqy4AKWe6ipJ10ukCT2IKEuD3aTQSgWJb4rx0=;
 b=ap0FL0/q1HHbAOQdyWV5TOn0cuK0s91Tzt65NoCXnhcCr0Z64fPKHAXJ8bzpYawWxM
 zvI6LxXtzcIFeWEGsKxHBdVaK6l1FfqvkZAtHHu9gEZNXJ2fWGZz8lWSCjfmd7i/bdAX
 snBLChPVbH/YLL971wG9mNVnf9L2bB9ktzLLGt9OwE5mkMgV8crAK4KOog7WHb5WFvHI
 3s73U2oAObYiiOHvgyL1OdJYzRLBPYsjne9CEYx1ekGq1g0IUGfkTd8ZG78GwlIOY21V
 SjYyEcaFKNI4sRUs3UbqcP99g80IajPx8fbWhS8+FiU3241xTAWPlU9Fu3b+fR6pU0/N
 xG/A==
X-Gm-Message-State: AOJu0YzTgpqs39h9v/qhhj6lh3AgUlFl/gjJOG0VFnoiRM9EAiOcTDzG
 z5bRGyqIIqMbqowfaZybVBSBluS3kcUhlRksqtiVcnMqi3s1R4iuDXQPGI619KkGP501sZo1YXr
 gE/nou48=
X-Gm-Gg: ASbGncsyoo1QRrP49TH6oZo2A0nSmBONc1hIo5fJIF8ygDk27SNNIZguu+46hV8dv7x
 iZlf5y6q7TC6E7l1xbyomwjwa++/MBSPkJGzUzBKhI7xXtsP/uZRTpWfbze/HbWrhaB4RAlyTJR
 HgQZNXC7JxoMGf514ykDTgVlIR4UP0dRiJadUlh3121W7zSy7FvPOmJqezGKtmrHZzSphIyI8Hy
 +1ofYkXxoZgkaqEtm7AOvPuPtB3PkBzlgTGMBm9aCeTedyneBtcPA5/bKqT3svB7D7PQF34imwM
 PXfbnzUIIUeTmomvuLBc0piaX91oHbvINOyVwWEt12N7/KArPGhRPfcX7TWKVW7z65MBZ6sfY0E
 SdNBi4w0TOITAGCAa/Y1tgmzvSLtI1VasTtq1f2bUztkxshWm0J1ch3RZJtgeAoAsOsk=
X-Google-Smtp-Source: AGHT+IEc/4F3PUEg7rURdR0YYY4oy95VedQsUnINTWvZt+EJzsS88t/gFW6hrb44TRXlCOvqG3JPFg==
X-Received: by 2002:a05:6830:6083:b0:758:3cc:f8a3 with SMTP id
 46e09a7af769-7a048c01dacmr12422395a34.21.1759179027357; 
 Mon, 29 Sep 2025 13:50:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a2422794c0sm2810109a34.41.2025.09.29.13.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 13:50:26 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:50:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Javier Tia <javier.tia@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] b4-config: Simplify configuration by relying on
 default b4 maintainer
Message-ID: <20250929205024.GP6093@bill-the-cat>
References: <20250929-b4-docs-v1-0-a56c1a1856c5@linaro.org>
 <20250929-b4-docs-v1-2-a56c1a1856c5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yRg3hGO366u7XnNN"
Content-Disposition: inline
In-Reply-To: <20250929-b4-docs-v1-2-a56c1a1856c5@linaro.org>
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


--yRg3hGO366u7XnNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 02:39:29PM -0600, Javier Tia wrote:

> Remove explicit settings for send-auto-to-cmd and send-auto-cc-cmd from
> the project=E2=80=99s .b4-config. The b4 tool provides sensible defaults =
that
> automatically invoke scripts/get_maintainer.pl with recommended
> parameters, making the custom overrides unnecessary.
>=20
> This simplifies the configuration file, reduces maintenance overhead,
> and ensures contributors benefit from ongoing improvements in b4=E2=80=99s
> built-in maintainer discovery.
>=20
> Signed-off-by: Javier Tia <javier.tia@linaro.org>

Sorry, but we just today had the thread on why the upstream defaults
aren't *quite* right.

https://lore.kernel.org/u-boot/20250929160453.GI6093@bill-the-cat/T/#m3d26d=
2ca4c42d620260fedaeca5f869a41fe26e5

--=20
Tom

--yRg3hGO366u7XnNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNrxDAAKCRAr4qD1Cr/k
ChIHAP0TlkCJgVqWPFrMhx2sy/Q3Vw50MUfeaGXoRuH51RMbagD/elEUkw5UHiCB
ETlaPMCA3wEEBm/LXbFUTOJAROfvLg4=
=VqhY
-----END PGP SIGNATURE-----

--yRg3hGO366u7XnNN--
