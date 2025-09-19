Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038E2CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 15:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C168329F;
	Fri, 19 Sep 2025 17:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RiZ4mH81";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0145C832AD; Fri, 19 Sep 2025 17:08:50 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 901D283285
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 17:08:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3197f534179so1799547fac.2
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 08:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758294526; x=1758899326; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f7k2pfCf79Nxrel9Az128HEX14BLF05cmn3jdEOpAj0=;
 b=RiZ4mH81c4SKPdA9dirKmrzY5UBz0uxw9KfwRXRXo8GgXjx5i7C83pyhtYEOdnTQPz
 A/fhPGYmAT3sZ3v5FGt5TOu28H5ERTTBYvT69Kg2AlAs87IFA8EIZte6iBx/ATY92KkV
 UcmZbhj0+2HeVhbsMHNa6P4mghbp6Ykidrobk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758294526; x=1758899326;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7k2pfCf79Nxrel9Az128HEX14BLF05cmn3jdEOpAj0=;
 b=K6wbu1wlzSzNvaPJtXETiNtNQAqPxhoDD3dl/mdwFRB00uuevYWDvRGEmjc0bmFILx
 ZFDge5BtpFDRKtFWgZjhdxOWntpKrhxnMAV/CCeQm2dVM4F4ESSq5WGCTiw8GM4xXeRA
 K/CpqpijOamULrchm7NxL1ThMdtKlvNJ0ir8Bpk8YDYLNdGIVlYiQoNopUpWegxXkTPi
 M8KVl6JqyWXsyUZ0oLpDGfJAmvcLkkZCQCQPrNl1pnqozkVPsRll0Skzj7JVoOZkv6NH
 +ipwO4aQ6E90yxyEe2M2X4zc+k2ZWK89BPhaUrhIjuDIXlPPAAhemVtEuY1LOShyqht2
 3Fog==
X-Gm-Message-State: AOJu0YzP0kTpi6SyL0xh1g50LBkV/3Doc58TbEeOzxL6I/lZcBD40a4B
 MiOOs6L7WiTYljBq7JGqriDEPMD2Lla9jXnRJWvoBaUJFSClRclM0KnuJzagBFzZwP4=
X-Gm-Gg: ASbGnct9FIdc89KQzayCv8whXCLwDq/J7m+VowJlDpMQPxctcvyR00gDuIIT3p09GSp
 mm3tuAE7JWd9Wp824F3QTOQrX/YpYHlN4YCD8TJ99ypoOib5IR2oUkH6NDzMFcKIB9Ly+1UA97P
 2RWL5/IMiDs0A62aQSWqdjEhYJbO7r29WvnvXABBUWh8tXA04+dv/5leJOeA732mVlaHpZ5FcYF
 ZwAaeYywLM9Ktymo4NrFn1FWR11jfmyyey4PlHEQdcPfDskjYrwvY0kbNH9HF7rWHhHg/y1lLcC
 meg3zzSxZtPJh0LxEXhO/kuoaNK+zeLEw0Y/AV3fkWBzqUWEeI0ikH6AnEw3pVBnxEC3J62EeSq
 72sQZTtr39RkjwSV+9tyyRYqArA3MxqWyk8/1J29NawmmisWhPeJO9UKS
X-Google-Smtp-Source: AGHT+IGq0XcPPc6W25cz4nR+epAhXmfImVYYtcywgWa0/A76Xbr+7Xr/916NkfzDK3NbMFpFmb0Kvw==
X-Received: by 2002:a05:6870:458b:b0:32a:a799:675e with SMTP id
 586e51a60fabf-33bb1fad8d6mr1662890fac.1.1758294526219; 
 Fri, 19 Sep 2025 08:08:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-336e3afa775sm3181168fac.7.2025.09.19.08.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 08:08:45 -0700 (PDT)
Date: Fri, 19 Sep 2025 09:08:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 0/9] exports overhaul
Message-ID: <20250919150843.GV124814@bill-the-cat>
References: <20250919101002.568488-1-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WCX1MJW/3A98RmeD"
Content-Disposition: inline
In-Reply-To: <20250919101002.568488-1-ravi@prevas.dk>
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


--WCX1MJW/3A98RmeD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 12:09:53PM +0200, Rasmus Villemoes wrote:


> This all started from me wondering "why does this standalone app end
> up being so huge"? Oh, it essentially links in its own standard C
> library to get strlen() and snprintf(). Which then led to asking "why
> don't we export all those standard C functions when we have them
> anyway?".
>=20
> CI has chewed on these and seem happy - it was CI which told me about
> the necessity of [1/9]: https://github.com/u-boot/u-boot/pull/813

For the series:

Reviewed-by: Tom Rini <trini@konsulko.com>

That said, in general and looking towards the future, I do think "needs
a non-trivial standalone app" is better done as a standalone EFI app
rather than U-Boot's standalone API support. Our standalone API is weird
and fragile (as this series shows you're well aware) but the EFI one is
well defined and we just implement it.

--=20
Tom

--WCX1MJW/3A98RmeD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaM1x+AAKCRAr4qD1Cr/k
CtzaAP44kcZzEiEaiJOMryw5GkQGqlU3tUhKosuK3bD5m4cN/QD/Y0gnC8sEZ6dH
fcI2OJBBbOz1+hhCAsffZRGeSd2AGwM=
=SqxZ
-----END PGP SIGNATURE-----

--WCX1MJW/3A98RmeD--
