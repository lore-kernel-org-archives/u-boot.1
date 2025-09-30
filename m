Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EE6CAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 16:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50D6882998;
	Tue, 30 Sep 2025 18:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VhOW2W7g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D43DA82998; Tue, 30 Sep 2025 18:19:44 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABDB5800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 18:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-42521ca36d6so30130285ab.3
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 09:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759249181; x=1759853981; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dxiJvw+N69B+AeyPJCzWkvSXNOTtdlmIWNsM59D42Lc=;
 b=VhOW2W7gEzj7O2wg9P0d9QOykfeTKQUnu1hEGzroXsEdiUjkbsT7mTyT3lDINeK69M
 oIq6AtEG2ctK59oSmj2C90ezbkJYZbLLyoheEn5KLlM+3HiHrTHaCkWs5ptHxuXRG+Ek
 rF5jSpC5DLHs+aX2D4sTmLZBccOBMydRIAeZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759249181; x=1759853981;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxiJvw+N69B+AeyPJCzWkvSXNOTtdlmIWNsM59D42Lc=;
 b=SMb3dtRO4iFhwhvUSxeLsLvhXR6Yz8XtG/FonhVJZCL7RPTEQ1SEms417SXcr71cJd
 G4gnV8sKpd3KWFbO8WVJRyR5egNO7ONotM26MBS2hpC9oW9+wJcUZzBgFOV+N61cmjrw
 Fb6zvj+9/uTgRWLyYpd4SOLBdLIDB+ucjLDDFdKGbwrf7odFnDZWsAKCAZ4igHYfJt+V
 rsxrzSoRAFvtdKeKMJ7YkaP57snD5qz/9ivZu+PuWHsgiDR/hAg05OM7jXATsYYQyxm5
 t4tMog9beZqUSeWuOVE4ZlPj60YzLgy86Tg/6hQAnSiqxOwDsHWheP+FB6VKSqURbLb1
 NSZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLiR0MBWw4HpVJjk9leQlqNcID7IQV5p08dmfGRddrrALNZ9ZI9PzKLCsivn4uRZBnJVDs2QA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0KyoV3gkicyTwIB+YXUHkS47s6ydSUTl1e0cZywtIqJEhbLkH
 Kl5NO9Q5hB89qtZ/CiaTgJ2tZcTeEnRQlP1SwUYrSMx3iBdNHR/LUM0VjpnnHExeeJk=
X-Gm-Gg: ASbGncsCQdGEfWMRsAJCYYWy8oPT03DRUtmERQUxEL4krTm4WPGlcUmuNT0LVlXILIh
 xi3fzXVXS/Yjn2tF9sDWOHYpjnl3Z0wI/3/yOgKN31mHRExE6vSNW00/MKDvQwrz3vqWXqmmobD
 8qSeiNIFzOQrW21uGKLa4X8GBFnYqBKP8xLBLz8VCIMOEdvYI1DCIMuuqHDYNVYIqin1JlAakJ5
 7js3UXST2Lg/Zr4NiMt1HE+F9VW0KZTXs7+0kR1YNLoAmq06jQ+3eEBuDtBXZYFi14VEAt7PzHh
 LGy6boqj9rmsnGibI/4vWlW10y6eVSZszrrD3Ma81sAeKsHERJevJbPaimP+fcBaJi227NeSh0m
 czAaRK+RpQdc0jUqV5fI9ReBqtK62YQqe1Dt4otE+RYjAiadzfT8zNHhKcM/GBbzBuuxitLMijn
 a/ILWwvKkV+jzJmRA=
X-Google-Smtp-Source: AGHT+IGxY7OwK2UGzyTN+zX5s/gIks/+z2TA/NsBikl3jPTpfuYI07JlR0b4ntrM8h+nPZYmg3MfUA==
X-Received: by 2002:a05:6e02:1a04:b0:423:fce3:9255 with SMTP id
 e9e14a558f8ab-42d816236fdmr7379985ab.23.1759249181283; 
 Tue, 30 Sep 2025 09:19:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-4295fef7c08sm38938165ab.38.2025.09.30.09.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 09:19:40 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:19:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Conor.Dooley@microchip.com
Cc: Jamie.Gibbons@microchip.com, u-boot@lists.denx.de,
 Valentina.FernandezAlanis@microchip.com, Cyril.Jean@microchip.com,
 ycliang@andestech.com
Subject: Re: [PATCH] board: mpfs_icicle: fix pointer assignment in
 board_fdt_blob_setup()
Message-ID: <20250930161937.GF6093@bill-the-cat>
References: <20250930154534.3914214-1-jamie.gibbons@microchip.com>
 <20250930154837.GB6093@bill-the-cat>
 <f6b35b7a-457b-48e9-bec7-df3e57b9f6ed@microchip.com>
 <20250930155518.GC6093@bill-the-cat>
 <6e30a206-a0c0-4ecf-9d69-6ce35f4a52b3@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SA7bljayBaHRhyR7"
Content-Disposition: inline
In-Reply-To: <6e30a206-a0c0-4ecf-9d69-6ce35f4a52b3@microchip.com>
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


--SA7bljayBaHRhyR7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 04:03:29PM +0000, Conor.Dooley@microchip.com wrote:
> On 30/09/2025 16:55, Tom Rini wrote:
> > On Tue, Sep 30, 2025 at 03:51:02PM +0000, Conor.Dooley@microchip.com wr=
ote:
> >> On 30/09/2025 16:48, Tom Rini wrote:
> >>> On Tue, Sep 30, 2025 at 04:45:34PM +0100, Jamie Gibbons wrote:
> >>>
> >>>> Correct the assignment in board_fdt_blob_setup() to use *fdtp instea=
d of
> >>>> fdtp, ensuring the caller receives the correct FDT address. This
> >>>> resolves an issue where the device tree pointer was not properly set=
 due
> >>>> to assigning to the local parameter rather than the dereferenced
> >>>> pointer.
> >>>>
> >>>> Fixes: 63a8506580b6 ("board: mpfs_icicle: implement board_fdt_blob_s=
etup()/board_fit_config_name_match()")
> >>>
> >>> This commit is not in master nor next, where is it? I think this is
> >>> something that can be folded in to another patch and that patch
> >>> re-posted. Thanks.
> >>
> >> It should be:
> >> Fixes: 7c16ebba1ed ("board: mpfs_icicle: implement board_fdt_blob_setu=
p()/board_fit_config_name_match()")
> >> and the patch is
> >> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Ah. And that is in master, so this should be for v2025.10 then?
> >=20
>=20
> Yeah, I would say so. It's not working correctly at the moment,
> it's not just a theoretical problem.

I'll edit to have just the correct fixes tag when applying then, thanks.

--=20
Tom

--SA7bljayBaHRhyR7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNwDGQAKCRAr4qD1Cr/k
CupxAPkBPo1JK8NXT6LUSUEkb50Zjr0stygYOzBRzjhCte+7OwEA2NfhmczxpHjn
x7xCt8ZhGBZ2sEMjhNNT1tiBOZlY/gk=
=QwIn
-----END PGP SIGNATURE-----

--SA7bljayBaHRhyR7--
