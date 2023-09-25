Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52ECCE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68AF386CC2;
	Mon, 25 Sep 2023 16:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g+LhSl11";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F145386CC9; Mon, 25 Sep 2023 16:02:28 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8B7886C67
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d865854ef96so4638734276.2
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 07:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695650545; x=1696255345; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aGhMGPJrO44C5nMkWh8rHij9931LvODT9Bef11IfGQI=;
 b=g+LhSl11Owl7GawonDF0yH0nQ8SCFC3HrzhxWVRmjE6FvdJqxlbcAUkFRoL4wwzqoL
 8vBimGePUxJ9PuwiTYw7zq3YhnCIPtmT0TGR6NPMrql9ynj2iMJYD4XcYlBeC/nmXwfW
 1gVV9cG81/glVN+cANuzRZWQTLWoXLlnjPHXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695650545; x=1696255345;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aGhMGPJrO44C5nMkWh8rHij9931LvODT9Bef11IfGQI=;
 b=QWeKiWVbjTjJyZOyLMvnaqIK30FBAngmAdmgx/5xxQhZwugC+nzpJMa27QwSCHvGQc
 sQtRYovz/eNafG3nj23pze+hSHgKVkHGEZPK0dhyCaBMm4z3ev0LDftpLQa0PQZMHOp2
 TydHmp3CrXjIMz4oOabRNPL/aFM/RrvCTA/6mCIMErNCUW5RASGRkqsmv05dUXuOaFPg
 NpfFa5g7hPofTRkydZ3WqhW6JmEONprsU+ybtJ1pTDApoToRqZTRMbZj0lXGQ9Y3Gs4D
 Vb09wDXiY55QtlUgPqVLkL2BbTWjyOn/+HJ6g+HNSlg2ncbl/ymLfJaf01ZhYi+ZL4HP
 QsrQ==
X-Gm-Message-State: AOJu0YwIYCoKvAsq1OrnGCuHQOe745FCkA/TAf/NJCK7BtBZ/EkZZt8X
 cdGt98T4GkLXHB2meWh5eqgA0g==
X-Google-Smtp-Source: AGHT+IH7YGCIWXHZULvUlJgBrsQ+MuLGLXhauRDlP9rmYu9C92uWL1Y2J+1+PQbTxiwcVTZh+XpFmA==
X-Received: by 2002:a25:da11:0:b0:d84:b0f8:916 with SMTP id
 n17-20020a25da11000000b00d84b0f80916mr6940795ybf.64.1695650545673; 
 Mon, 25 Sep 2023 07:02:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 i137-20020a25d18f000000b00d81425266c1sm2217750ybg.42.2023.09.25.07.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:02:25 -0700 (PDT)
Date: Mon, 25 Sep 2023 10:02:23 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/3] Fix code style for time functions
Message-ID: <20230925140223.GQ305624@bill-the-cat>
References: <20230925023958.1913268-1-sjg@chromium.org>
 <20230925023958.1913268-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6PhYzgTt3zKKqmsn"
Content-Disposition: inline
In-Reply-To: <20230925023958.1913268-2-sjg@chromium.org>
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


--6PhYzgTt3zKKqmsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 08:39:50PM -0600, Simon Glass wrote:

> Fix the code style used for some time functions.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--6PhYzgTt3zKKqmsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmURkuwACgkQFHw5/5Y0
tyzN5Av8DtyGBrDXXOxHDXRSFs2+g0A04iJxd0DHyEzVobREaNuCiMa3QyS1w3dV
70E7nqA/fUkcf2Ok63VHyPYi3dsD/LK70yhH9V7JMJDQoLhJqV2vNU/bJTcUlZ1K
KOKgSqdExAL0h3ZQl3GT8AvFh7zLgp7OioimzXOwBHJpXc0tK4abqo2qRgpBFqVU
NvSnjL4NcSMbtxhDp9qp5KbSfiOMB4d0PXzH3YavFCAwtr70ZrEv3e5hAum0zD7Q
/NcFiYR9TV7efS6DtIPrv+oY5P0zB584vl6mXwB1hlTz1JI0nm2RJbPXF6q/W9ep
vFgfFeROk5pEZ4aDTII5hdhuWerWpVklONQg82Wluy3PO7ESWKSSjw5YiNT550pk
XvDvfqqA9k4xaoL/oKKO/OBb2hw+doPDnF72a1VKp2EJZ4Ectk2DfhUNCEpEq6wa
mAJdQaqLloUN9rO8pIGXkbmUvs2V6seiy2RzWt2Ajy5gV0m/5QKiGcKcLVZMmAkf
S5doO8vi
=m8jn
-----END PGP SIGNATURE-----

--6PhYzgTt3zKKqmsn--
