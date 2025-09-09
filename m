Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AE6CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 21:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED65B831A4;
	Tue,  9 Sep 2025 23:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iDKPS9jx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49E828319C; Tue,  9 Sep 2025 23:56:07 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4049483192
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 23:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-88c347db574so85921939f.0
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 14:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757454951; x=1758059751; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=43bmXtztE+jcGF7Ve6fgripKzHQ9FqmOSmCIX7idYS0=;
 b=iDKPS9jxpBvzC6fvTJoY5W//XyXtDv6jeByrMrYsKq+M43Fo2xjb5awK4/x1haFAf/
 elttTwXOfUtc+0gzqus1DvD/40DpGfYAuikTMuCodwK7/+fVdXlmrxyQS9z/Vefna6vN
 8RriglOD0J1QrsbSYARPgPNpypx42sebTgqfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757454951; x=1758059751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43bmXtztE+jcGF7Ve6fgripKzHQ9FqmOSmCIX7idYS0=;
 b=Cl1PTJW9iVncjZmk9u3Eik1+Imli0S1mdh3vkBY1HYBu4UnGjIFMA9vgfsbVCgs7KN
 Ur1cC0RwPdbStQE/rjhdT8tjE4Vj4VejaywL3EPmpge8ZmrXLcrtAOC47dibpcMFhBrK
 VKOWgjD2ccCXnFt4/Bpwhi+2sAtvkQMzxK3A1/6RlKo6i8MSd7lNclgguhtOcIfNjaL+
 8v+yQl0JuWFH0Q0/C2py3w+Drcqw1t83jzyUsXs+PrTCw4wA0WKwOAxL4eRxsGx8FVla
 pyvw0zdHclU8ajQMTw+n7vLrHgRzxd0ir510fmPD55EFQ+GUCdx0TXz7SpslZVsDVKxA
 oMBw==
X-Gm-Message-State: AOJu0YyWuKcvDTI0Sj85lFAPLg+NSHSJbk5Jp5vt5HGn7MIPXXUmLac2
 qHEsYmXeVanfndaNgtaEhe82yQ2cCuuVQdgPlJhvLLZaX/Ik8Mz1drDOUZDOPT1EpDXldmL+gfm
 R5rMW6IY=
X-Gm-Gg: ASbGncvuaCBmgtzvdQrr2J7xYzezFZJUT+h4agQQvhKpb00U4KBbs68xEz4DX5H3lOO
 1JSdSCY7D7XQ19beaFwXek9y1/j/5UMq9qIdEHuruY1wUaaEf4UvwuX6/EpmnJk9MSRa9kLa+0U
 mMa/qwpMKSSUCZejl0sySwA/Jc718veu6j5q0278iodFGCfKBuFzs89GHTDkWaMRhj2HrVlGMEE
 kHM77OwVEK1rC0XifmxO1r0QuoywZ/Omm+WennFCCygIOXEjrMSbX6yC9XpFY6GUhxpihSuVq4A
 hPb4MoNKoH8AagT5xlMyZ6FTHzGH2EcdK2M/UMl4Bltpt/iPFZmQ0Udkk3TsHEEI2n2Gn6mWL/Z
 eQlUOasRKP7/6CVttBfl0EnV7+BIJRE63DA9ycJ4Xcf9SHjFVtGj2ezy6Hg93RRcL1Ig=
X-Google-Smtp-Source: AGHT+IGa9vDSi+nArgme2dt0/ViyPHNyt6qT5d6gadkR5WV6uPO/wOywmD7nrAohIy47rBxDgrOjqg==
X-Received: by 2002:a05:6602:2dc7:b0:887:37c8:56ac with SMTP id
 ca18e2360f4ac-8877765bfc3mr2371664839f.4.1757454950626; 
 Tue, 09 Sep 2025 14:55:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-889b50482ffsm306076939f.19.2025.09.09.14.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 14:55:49 -0700 (PDT)
Date: Tue, 9 Sep 2025 15:55:46 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.10-rc4 released
Message-ID: <20250909215546.GC124814@bill-the-cat>
References: <20250908162046.GS124814@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qbox7nuSYT0tLB9D"
Content-Disposition: inline
In-Reply-To: <20250908162046.GS124814@bill-the-cat>
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


--Qbox7nuSYT0tLB9D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08, 2025 at 10:20:46AM -0600, Tom Rini wrote:

> Hey all,
>=20
> It's release day and I have tagged and pushed things out and will merge
> this to next and push once CI completes. One thing I should mention up
> front is that in terms of project organization, we're moving ahead with
> SFC and they'll be joining us on the community call that follows the
> v2025.10 release itself. I would strongly encourage anyone with
> questions or concerns to join and speak up, or reach out privately if
> desired. If anyone knows of regression fixes that need to be picked up
> still please reach out.
>=20
> We're continuing with a community meeting following the release
> and once again this is the same time as the previous meeting. The
> meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> September 9th, 2025. 9am (GMT -06:00)
>=20
> To join by phone:
> https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

Brief call summary:
- -rc4 is out, please test and report any regressions / outstanding
  regression fixes (I've pushed two today).
- Talked about the move to Software Freedom Conservancy (SFC) a bit
  about why we're doing this and what it will help with.
- Confirmed that the clang-format series should come to -next in a few
  weeks.
- Confirmed that we use the GNU11 C standard, and if some things aren't
  compiled with that flag, it's a bug, In turn, for C formatting, GNU11
  features are allowed and generally don't conflict with
  style/preference things. But some of us (myself for sure at times)
  haven't changed our mental templates on what's allowed or not.
- Talked about standard boot and overlays. Andre pointed out his older
  series at
  https://lore.kernel.org/u-boot/20230210110213.2531190-1-andre.przywara@ar=
m.com/
  and I noted systemd has also adopted a solution in this area.
- Talked a little about needing to better document using b4 or git
  publish and less emphasis on patman as it has issues currently. Other
  documentation clarifications in general are also likely needed and
  welcomed.

--=20
Tom

--Qbox7nuSYT0tLB9D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMCiWwAKCRAr4qD1Cr/k
Cj63AP99NypBjQrWW2HEy4fNJ8qolWR3Ea+yuwSg7dhdvjdZ8AEAotrjY2tI+v+H
jZjNqldJ6XRjmta03WUwjS5YwEVhDQw=
=9oCi
-----END PGP SIGNATURE-----

--Qbox7nuSYT0tLB9D--
