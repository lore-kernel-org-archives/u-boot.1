Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14487E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 20:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D678031D;
	Wed,  1 Jan 2025 21:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="URbMz7du";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13B0A80317; Wed,  1 Jan 2025 21:41:40 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5278800D7
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 21:41:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4679ea3b13bso81436001cf.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 12:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735764096; x=1736368896; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g8brWiMPxkV5bihUFzA6Ug2xrDsFzZiNdgUiU6vKXCI=;
 b=URbMz7duTwDJAaShZgbE1rPkpjZirYSQcqPKN96sG30BdKxzI/9UUT5QiKl+Bn5HC7
 CuZbauNcGSJsPLphmt1b5pH85pvA8TuI3LTNA+3AtPRSBxN0896eU9P5BQQLi6D9iaWo
 Ozk+xXx+BGPa/qI7S2w8KrxbClFCMKx5crBWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735764096; x=1736368896;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8brWiMPxkV5bihUFzA6Ug2xrDsFzZiNdgUiU6vKXCI=;
 b=ViWfvfiJu9MAADFKl3AYZxLSqvvZ5EejQ1r0RGRqsEAC13L0CqLbUtVtSpvlMD5dUh
 RPeVu8Ngdf+uYCux2ysvNuavdQkBawpnlOEc3mwILZehd29meQae/gp3F9g01ApklE3N
 ByTLY1XpFkpQr+fTCUCA0ezsnK6qXMQCvVFND8lmhJePEUyQLRw5068XxIGxRRDeM0Iu
 fHUKYedbyBlcHLNLofG6XDKTuxRcCqtejJixJ+vrVbBC0/3kP3t/y+23ZRpBldUTaTff
 G7oe0FRJ3lSjYC0fzFdmngSoEZsA3QUxNBl31TFVfWglQWVtcwEl4RAMBmqAchz4Qwvm
 hbCQ==
X-Gm-Message-State: AOJu0Yx87cnh5G9gF9XGRCL3fCnztHdQUoIzfy1KFH7E5lZVx6lALEFL
 tS3mOIg1qu0kTYI7EmJ8NzaLiX+P/lw+3zDGn07O22gJJrHBmsfhZMgeYBX9z00=
X-Gm-Gg: ASbGncvwk4oV90wnaCq7F80CARD49AEOEDK5rylBsC3ZpcQnYYIk0ScOl0Henvsj83y
 GHh1IoDDt9E9/8JrC/H60w7G96GGUeLQBsnYiCuqMST90/ThLWHWFrTae+IwMYhN0Qy6pW9xcp4
 2qNrIoq+am3fcfPwI+gWFwNAm9FHj2s7GNKhEPxNiMt7HyGm9m7kq/cDT7b1acy9hOUwykrb3FV
 LxNeNo66soccMnPMxdLsdnR9Cts57K3zuLNnjjrjJEynKHIlKutPeknLw==
X-Google-Smtp-Source: AGHT+IEmW3ZLgRpvk2FaUVVAmHQ2WHBIixRbA3HiO5MSelPgBdILqoPR9SiAYgnqvFLh6oI58Q45Gg==
X-Received: by 2002:ac8:5a42:0:b0:467:50d0:8869 with SMTP id
 d75a77b69052e-46a4a8df373mr752829191cf.18.1735764096579; 
 Wed, 01 Jan 2025 12:41:36 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb1788fsm128872961cf.54.2025.01.01.12.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 12:41:35 -0800 (PST)
Date: Wed, 1 Jan 2025 14:41:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 ycliang@andestech.com, tekieli.lukasz@gmail.com,
 frattaroli.nicolas@gmail.com, yuanlai.cui@motor-comm.com,
 xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com,
 jie.han@motor-comm.com
Subject: Re: [PATCH v1 1/2] net: phy: Add driver for Motorcomm YT8531S
 Gigabit ethernet phy
Message-ID: <20250101204131.GK3476@bill-the-cat>
References: <20241124073844.7785-1-Frank.Sae@motor-comm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Az6o+GGPVwaWK+tj"
Content-Disposition: inline
In-Reply-To: <20241124073844.7785-1-Frank.Sae@motor-comm.com>
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


--Az6o+GGPVwaWK+tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 11:38:43PM -0800, Frank Sae wrote:

> Add driver for Motorcomm YT8531S Gigabit ethernet phy.
>=20
> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
> ---
>  drivers/net/phy/motorcomm.c | 96 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 4d67203ee7..a1d5eac7bf 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Motorcomm 8531 PHY driver.
> + * Motorcomm YT8511/YT8531/YT8531S/YT8821 PHY driver.
>   *
> - * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + * Copyright (C) 2024 Motorcomm Electronic Technology Co., Ltd.
>   */
> =20

When applying, I've NOT removed the StarFive copyright line as I assume
this is an unintentional change.

--=20
Tom

--Az6o+GGPVwaWK+tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd1qHgACgkQFHw5/5Y0
tywPdAv+NVOzBB6jludiZfDXB8iXvbfRb3WoPUTsud2dZcMSnkXyfzW+GqASrQE8
jabyyJ4BBWsZkVWxj3oBd0jHwrmyi0cvBpH/T/2XKJmeY2iZW2R0H+H5OSXjhhHD
mbleI/WelgHumNSF/s067UKtaip0FnlYBmFDbvcH9MhZaRBrUJGbcR7XgDSaXvkC
tnb6ko+01jX3OJkveQu5g84BsvKujW0yiCurUXqWin9oRzP75mOGhf0IRwyExp7G
aUVC2yhw9f54JHlE7j923ieUrZvczMbFjaELaaXUVVI+qEb9i87PJRu9EnUX5RET
O5usdoqguVOhpbWIFjLEld/weGLwEpf6RmeFFbYi3rITzHdgq3UeTv3cEEaUna3N
+LplGALQo26QraAhCnsOI8OulUAwQD6lxdeK5grTEOAoqVX8B0FwfswyZ9Pd51b3
BpMF9xHTR8Gbbw2pKNt7SdoQcZQFy0IiFTDZmU6xsCzYx4DZqlpBBUMCPYiFREt5
52NIftT/
=GyPm
-----END PGP SIGNATURE-----

--Az6o+GGPVwaWK+tj--
