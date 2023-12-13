Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB30C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 23:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED3087926;
	Thu, 14 Dec 2023 00:06:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e+IqM0PO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 685BC8790E; Thu, 14 Dec 2023 00:06:19 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BAFD87918
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 00:06:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5e2f9e9a2e8so9436477b3.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 15:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702508775; x=1703113575; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CpEjMwK1sp14wB3FENswPZnggwW/6RG6w/KIlfdv+p4=;
 b=e+IqM0POcarNx3MoUc3mAQ03oT7LK7EOm23wBrIxT/0AiQVpqPyJnlCsZ51+rVAxYL
 5d4M5WrXNN08SRPlWX5a9K8JWyZLjLlAgExpPW2c4GUXzlwRzqzILAsAU0lJScQIveaw
 MJgq2/1kPveUce0XnjcIHC51WVhtXh+2ZtxBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702508775; x=1703113575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpEjMwK1sp14wB3FENswPZnggwW/6RG6w/KIlfdv+p4=;
 b=dhd+Qe6im0r64K2xaF7IEW2Xm+1NFrAx4MleLzANYON5zKOtCk9Ic0MMWcdyVNRgcN
 XxXSH9Qk3Yvr2elXxBfznarJXoEkg+30E9RpEc+Z2Pwv4yDuw5ZuVgsS6Tbo2R/rRnZB
 XNghm8nklh4P+AZL4oU4b9r6H7xBw0FxbBIgw6e0tMbGZ/AYQxLNEY/ecAPWeQNGzxNH
 TRvIQs1dsb7Wvs0oJABU7MtIYUt9/yyq37N/JXJPDP0m4fMgeJqX9gODb8joDDP5ui7I
 dNjEzUgoSMKOyUErV7EsSrhU8XDqiDhr79dVZClZCdggJ++iEdSxOBAPcORZx0EHA1sq
 pNDg==
X-Gm-Message-State: AOJu0YwVWMo0ihS5tCJja5Pb7XMAun1c3SET/0HXGJGdYnEcXQw1H1dW
 4fRQRjAep7bSCa5m7FSX57lBOxT6UlrJfCp7Xq0=
X-Google-Smtp-Source: AGHT+IEdg+3mdGYiZ3Z6jaKUxu3UIp99SPHlff62tIj0KOw3BWkSOlTMpQNvH7kuI0MFwmIGBayhNA==
X-Received: by 2002:a81:52c6:0:b0:5e2:fc6f:d718 with SMTP id
 g189-20020a8152c6000000b005e2fc6fd718mr1148836ywb.101.1702508775308; 
 Wed, 13 Dec 2023 15:06:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 p21-20020a0de615000000b005e2eb26da82sm714273ywe.10.2023.12.13.15.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 15:06:14 -0800 (PST)
Date: Wed, 13 Dec 2023 18:06:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v2] test/py: mii: Add tests for mii command
Message-ID: <20231213230613.GS2513409@bill-the-cat>
References: <92d06d89e2d2d6b1738c62453789872dcb6bfa92.1701777713.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xls/rmKuFCt8ykAM"
Content-Disposition: inline
In-Reply-To: <92d06d89e2d2d6b1738c62453789872dcb6bfa92.1701777713.git.love.kumar@amd.com>
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


--Xls/rmKuFCt8ykAM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 05:32:17PM +0530, Love Kumar wrote:

> Add below test cases for mii commands:
> mii_info -To display MII PHY info
> mii_list - To list MII devices
> mii_set_device - To set MII device
> mii_read - To reads register from MII PHY address
> mii_dump - To display data from MII PHY address
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Xls/rmKuFCt8ykAM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6OOUACgkQFHw5/5Y0
tyz+zwv/R2pqI5s+tUVEQkQyeUASI2fWH/4IZB52fgJvHAahe/b9A4NkLOCoQHAv
MafXBAQBxypiPUsBribbLco6YOuNw+LOfCAF/G4DxQ0/r6jfhCvPpdiZB+AimEns
vARAaJ6rlyjaP1zHhVbrxvHWi3vMRzy1aYI20ntNnoxcTheC7EvbinqXDzOyyi2M
KeiBo79kppSnquiGEyjDGqRdb2pecSgX5JC+kSL/hmzfa0+iEsWj01JDWYpzXg7u
y6xJvcIjUiBXak6DNjYxzybTwWTtymKBuX4j5KE5FuYr+wexS04cMejw0bQgK4vw
aaGGNBV4Sacr7ELjBc/fzv87nUY3T91aKfsAJ02yN5TYp9EKBpXXXz/NqhSjYwJ0
UPl7hqTJ/XBajc30VxbzNWJbN75N8w84PKcvWZVrbRcNXqp9uuCxXxYtbtY2X9Ch
TCp6/J4q7NfYoR1g9GmLg0bYSbXajknjsvNcq9vC8gZEjMUH/ZdvLPy4lXc53Bxs
mRZy7zfK
=vMLy
-----END PGP SIGNATURE-----

--Xls/rmKuFCt8ykAM--
