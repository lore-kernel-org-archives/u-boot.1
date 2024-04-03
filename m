Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A80CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 11:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12AFF88241;
	Wed,  3 Apr 2024 13:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PgKqG2yq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 640BF88322; Wed,  3 Apr 2024 13:19:14 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 089EF88241
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 13:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-61500da846fso22157907b3.1
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 04:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712143151; x=1712747951; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vRt4aXsZX2YfyQ2WfqFisPBnLA3EaqQhqhNqYNCV/P0=;
 b=PgKqG2yqohOxFYP20mh0dHRIrEBVq8uHNW4gk5SHVyomG6vYTnEr6jurTvpU3gRKY9
 I1a/VtSv/eKAmJFKPMuLZuAj1dweuEfYlDMdh+ew0FBxKg0QvEtt0HX2ldO37vWc1n/y
 +7zbpGMznrXzk1ypaWvwJiT6bvLuzUaxA17sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712143151; x=1712747951;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vRt4aXsZX2YfyQ2WfqFisPBnLA3EaqQhqhNqYNCV/P0=;
 b=JC0rxzCCioMWAhSx00SPtS4rujEG2wro4+G7QIdG9UMZX/yILVkBCRBILsVVimzb/6
 mqmsLXzAABHpaq3yFUVYclKU8qxH1ZZUbPH7zfQkE45HN35Ertj7RjHpD1JTdbI+KNa1
 OKp8CZbSkLpXw5awmGQezfE2vLRuv5+rKX8JsPhYMd8p+dUHsT0OpY/PlJ2TwXZe3bLc
 i6Qpvvd6CHAyXQm9t4eOYVZdiIzaoHhK7KjHflMn/q56NDkfzh1eo/dRNeKaAanQ1/si
 BtJm7haQopQKQv/8CrR0PtCnZxGxMqqvzUXxVLKItjLsN79aGDcJvH10C7331usAlfOw
 249A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWviYa3NCNccKmrFWsbh+TkQd6Hoedi7p9E/hh/nqZePyJ9LOjTP9bwVsARqqWRln6ziHikYeBwEHkSwCMZYAYBNvrCZA==
X-Gm-Message-State: AOJu0YyBMAtESLW8LpY9h/4vPIhQ3qMCDhyTq+Lqo2N4ug+cSr3l5cIr
 cf3Yuo5csJOkY/qHlRspigYjrnBzl4pfTUQq+O/p4VCsixQ9+X4fq5raJh6yKYM=
X-Google-Smtp-Source: AGHT+IH/C10NfCRD2ZejGklCTjAHwFX8uKkMUB8xoB71QjLrX/uneGJyCS1FbByX8dANWdX3gNwiiw==
X-Received: by 2002:a81:5f07:0:b0:610:e1f5:64d with SMTP id
 t7-20020a815f07000000b00610e1f5064dmr14825708ywb.23.1712143149873; 
 Wed, 03 Apr 2024 04:19:09 -0700 (PDT)
Received: from oliver.lan ([23.155.80.164]) by smtp.gmail.com with ESMTPSA id
 y13-20020a81d30d000000b0060a0f62c589sm3287220ywi.137.2024.04.03.04.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 04:19:09 -0700 (PDT)
Date: Wed, 3 Apr 2024 07:19:07 -0400
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Colin McAllister <colin.mcallister@garmin.com>, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20240402
Message-ID: <20240403111907.GA3633@oliver.lan>
References: <875xx0gl7f.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xW4Eylb3P8LV37fV"
Content-Disposition: inline
In-Reply-To: <875xx0gl7f.fsf@baylibre.com>
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


--xW4Eylb3P8LV37fV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 11:36:36AM +0200, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Here are some fixes for master including:
>=20
> - Fix #if logic in android_ab command
> - Fix ANDROID_AB_BACKUP_OFFSET in android_ab
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pi=
pelines/20142
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit 425dc46a2c8ebe6d1a5a7d2d7ac5506aa77834=
09:
>=20
>   Merge tag 'u-boot-imx-master-20240330' of https://gitlab.denx.de/u-boot=
/custodians/u-boot-imx (2024-03-30 14:07:37 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20240402
>=20
> for you to fetch changes up to 7a0cfb87672f727b089844dc635bef01d512816f:
>=20
>   android_ab: Fix ANDROID_AB_BACKUP_OFFSET (2024-04-02 09:09:58 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--xW4Eylb3P8LV37fV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYNOygACgkQFHw5/5Y0
tyx7LAv/a1IDNsUHK4iGoFRGUl2G2DYNC6aNu6O+w/bOohSiBFMTC/rWY/+m839l
8mLPZJ7M+NOkN6ttgWvRBqZ69ptVTrpbq1QFD7jDXj31Ccohz+cf2EJygt/4pOpR
DhijCKMtT2LKoq9TAp9RJfrjrCBCeE50OqBfjN2P54Py8RvjSmXpfMBxlxRSr6fU
JmKKwKpLa5qsFBe3jO7W/JI/5MCxjedLl8c83XhwyMv3BcMPpJTuTgCj9IVI+9Gd
NzrYQBzeatLzxdbw66sB6IJsxPAtf3fI4yxb2smUHYqS9MDKx28ghz/K57FrlSLY
uTXhha49MSgeCVSNy/eAZpDBBZ8/Jw5SophbFs6f0fWs6ERuDkO/5F27gfXPhJP8
VujwxJ//X4jX/e7gGEp2tHQq8wmSN4ifO04IjxGQ6uQLKFLFz9RgnBwWReBeUu5W
lh0F9ihpgRDztd5zRPipuDC4ixFJCVG6qFxJg15RywV8r6WJLoBC9Q2Y3WBfe8ew
b6gfx5E/
=qr+k
-----END PGP SIGNATURE-----

--xW4Eylb3P8LV37fV--
