Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678D6E9271B
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 17:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BD1386C3F;
	Thu,  5 Oct 2023 19:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DKe9r6CY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0674586C43; Thu,  5 Oct 2023 19:46:17 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCE3A86C39
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 19:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d8181087dc9so1410254276.3
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 10:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696527971; x=1697132771; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g52xfY8ZxzIimwkhNY7mMuL2L1PXp0wVeXL790zdlV0=;
 b=DKe9r6CYjKuB7QS9qIXrvyLqlZ1ow2sVO2z2LJA37GbY8wMabG2KE/iEmtY6jbbLVD
 swVV6LCNOZuzXUg9zNGQfHjP3Lm9MRWUUE8fdJOq5bKMA6seUvPUVw2VcbBfGfFpgReS
 s+OPhT+nFwARwZee2AaOaXCEM8BvXq+/8DKNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696527971; x=1697132771;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g52xfY8ZxzIimwkhNY7mMuL2L1PXp0wVeXL790zdlV0=;
 b=qRH6fFEsmmF4f19w6ZHAuLHdhbMVxSTi2j8R3FhtYDugIK1uRisNkxu+jQuS6cBjKU
 3WVC1kw5LbIPcOo8YQaYdzvSjjoWlTOxl+QklWGH/HDP+oSf6yig0jE7b38gJwRxaymq
 kvMV5wA09fkfemYVIIebYXinvdTSVD7kjvnQxgIu7oJOZ/gkudXtr9p5RQnvnx3roOg6
 va/5lLKKxoatdgi2JT6pRv4q7x5rbDcGKsWNo941tEmqqZs8uwpyX6oZ2gmzPZIYYkt4
 Oxttqun6jip3uzZq/rjL8qsF5giiOJXK6rMW/HWwlAUN4/7eufmC1ItcJALc02AB0kKI
 9PYw==
X-Gm-Message-State: AOJu0YyFlMSUoAErYnZ2lHZnFI3kRNzckVBdjJIXd1dlcOIdtAifoIvv
 iApMX8hkOn6d3OSOvoKdEBATPWmTTl4V9VM3gWT5OA==
X-Google-Smtp-Source: AGHT+IFyNXhkGHULo6hHNWO//DEiuX2UqDk7vwX6dmFkKwlKJKgTvtCZm9nQNBDdJObJvC7qlhOw4w==
X-Received: by 2002:a25:f80b:0:b0:d74:6c43:f327 with SMTP id
 u11-20020a25f80b000000b00d746c43f327mr6180865ybd.10.1696527970649; 
 Thu, 05 Oct 2023 10:46:10 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f1fa-53fc-3572-fce8.res6.spectrum.com.
 [2603:6081:7b00:6400:f1fa:53fc:3572:fce8])
 by smtp.gmail.com with ESMTPSA id
 f131-20020a255189000000b00d72176bdc5csm523583ybb.40.2023.10.05.10.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 10:46:10 -0700 (PDT)
Date: Thu, 5 Oct 2023 13:46:08 -0400
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [PULL] u-boot-riscv/master
Message-ID: <20231005174608.GU8465@bill-the-cat>
References: <ZR5vj5SgDa3RbDV5@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HevFzp8yV/wNu816"
Content-Disposition: inline
In-Reply-To: <ZR5vj5SgDa3RbDV5@swlinux02>
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


--HevFzp8yV/wNu816
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 04:10:55PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 65b9b3462bec2966911658836983819ab4e482=
3e:
>=20
>   Merge branch 'next_pinctrl_sync' of https://source.denx.de/u-boot/custo=
dians/u-boot-sh (2023-10-02 15:19:02 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to 7cfdacbe8020292845bd5eba63b576b8586c433c:
>=20
>   configs: sifive: enable poweroff command on Unmatched (2023-10-04 18:23=
:59 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/18005
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--HevFzp8yV/wNu816
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUe9lkACgkQFHw5/5Y0
tyzFBwv/Qglq6AFvjykuCqmkMPHYoQzYY2Odmum+6Wlh0qtwe7ZdB2DBp8thX3oP
31iIKg/WqF946k714K4Yt0hnBQRceV2Rrr4JhXYLcMFuBnD0UriPtoEvlObpMYJN
hYx3y6d7bLUWh8MMkGUhFRgqUXEO8W1enLf89fVjkcE1w7p+j+9xPWQIGQz2+eM4
fKzEjZuE02Hsw76OLmR9jYjruyZpPIY4U+BrQYzP4GngTsw6r7XRsnmx1I2hshOM
/pvUntt0GNRnMOGdhMGxVrHGhplr1HJnJdEaDY0sjrUSbuS8Q8DEEO30JzNt15Aw
03anSbpLQ5ucvwhXnFn8T+XV9KjzQZ9m5vPFtQe1Tde5E/7jgAP+cY8G2uqIL04k
CnKAfUiAi9gvXZMj1sQFz6UYh1nCXNXaxL7mLzGOe1WWMA1I2WIf/TMVaM5kuKSc
Seqi2X1YCI8SRDCvzw5SKr7fc5wLiOmndA6XrLyylLrTtSH8JlwApL1/j7TmmLdS
K3iFNVFn
=jCkZ
-----END PGP SIGNATURE-----

--HevFzp8yV/wNu816--
