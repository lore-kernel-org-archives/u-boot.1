Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6758C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 14:21:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 346D381FEE;
	Fri,  6 Jun 2025 16:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aBHRnmx7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 325DF81FEE; Fri,  6 Jun 2025 16:21:03 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2733800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 16:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72ecb4d9a10so1971564a34.3
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749219659; x=1749824459; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1fTuTViddeKQQA5qJyUZREIxCQig8NSdJWnG+0Qq988=;
 b=aBHRnmx73YNXm4tjw9vfMY6OEXRVpPJ+QK9y2bQp0Y4sOqKEJPCOTx/1cCsaWazADc
 zUEt/ItEbiySSM3Ao28eh3JdKxx3MU7WIbrjjMDq83jTJLh1WRRx4poRmYj4DnKvQYuN
 mE2B3M54dtAXBpc2fCpcI7j5pthJ/4cI81wC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749219659; x=1749824459;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1fTuTViddeKQQA5qJyUZREIxCQig8NSdJWnG+0Qq988=;
 b=aELQqApwQ5lsknUytTGuETPW01zTavvjLYxQleRr+if4gwc7eH8aEv0W6izf5G4Qt2
 3A/Dcit3qdQI9VnCHplCdk7nZ+6QNgx2xvltIpLKuhBEryV6rXmU66yKX/Uv45wuVPrq
 XduJERE0jzWwnPtcqiJeF1MC2iupNncJaP47aEwcowXzqBISLOH0gmC5l87dH1WyfMCu
 5k75zYe+TWgnk+E7ZdGprfQar3KpweWSCebfcG1XvfDWJCC39qd9MXzK6P5KTcl/r8aT
 oxHlLQRoErzRIUsSDGrtKQlEbx+dvGAEe+MDp+P68EYSSbLm0FoiXeJS+GIYmPn1dW7G
 jM7w==
X-Gm-Message-State: AOJu0YwYoEecv+4DHogFEHZ0UX6UjuHdgo+/PUR/9WSaba0UJmYqXBxa
 PycUpW+S3E2EvkXImBPIP1opBzsFkFfxU8sGvo92+d6qOeJ3nn8jRU1eYJLjr5hg5u8/jQICZkc
 dun/9YfM=
X-Gm-Gg: ASbGnct8dqyUNseYd9O0ZPPz0alayVV1Gm33xwsQewVQet4oZsubSH9piykMUN4HWED
 l/lVRUH5M6OJJYo0pw0H/WiQJaR/WC72i4wiTvPqj2Y/hXD5W/1De6lZrW7DWjzSikNa/xbY1mZ
 VcVDE++No84HLXfXKZksFt+W7BhTmgAtmIMCr2Y15tfBdLGPJjX03mAWlDbuYLCF0lpK6CVHq8o
 0lg5I5U+tOCurPkDir/pyKnzm/xVVZu7XugLSaQloBbQT9WXtM9nBLp4tUd197jElgQD7R9N/+M
 cG+CPZYV0zSuqfUb4tA/TUp9s0cc+/Ryi3ryt2t2PIJEPZeN33dWwTR+ZWYOdHueYjgV0XVsT8C
 AVhBV2uMuErRz
X-Google-Smtp-Source: AGHT+IFSBDkF9l+RG0mDjA6NlBaBD+R6iLrhC7RE543gD+RHxGMpXpe146VF5ekqAdYZ5nuO3miDNg==
X-Received: by 2002:a05:6830:2a06:b0:72b:9506:8db1 with SMTP id
 46e09a7af769-73888db98c7mr2204421a34.4.1749219659531; 
 Fri, 06 Jun 2025 07:20:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7388a0899f7sm287624a34.65.2025.06.06.07.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 07:20:58 -0700 (PDT)
Date: Fri, 6 Jun 2025 08:20:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 12/13] Update doc/README.SNTP
Message-ID: <20250606142056.GP1382132@bill-the-cat>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
 <20250606064211.3091237-13-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C4zoTxfgmLIpFXZG"
Content-Disposition: inline
In-Reply-To: <20250606064211.3091237-13-jerome.forissier@linaro.org>
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


--C4zoTxfgmLIpFXZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 06, 2025 at 08:41:48AM +0200, Jerome Forissier wrote:

> Fix an error in doc/README.SNTP ("timeoffset") and clarify the
> differences between CONFIG_NET=3Dy and CONFIG_NET_LWIP=3Dy.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>=20
> Changes in v2:
> - New patch
>=20
>  doc/README.SNTP | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)

Thanks for touching the docs. But, can you please convert this to rst
and then update it?

--=20
Tom

--C4zoTxfgmLIpFXZG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhC+UgACgkQFHw5/5Y0
tyzWgQwAgpnRBP+gT14PHRmbHdNBoyomrd2EgjAsmYwxRb07tuiXjovnVJC2FU8V
ZbQjial5fX9DZ5C68rzB9FDZG/DoLj51nLzlE7JhWFkJYp9iPrWWj3lWI5YgtWvu
iZi1bRzfqhj0OePWVDvWE3CQ6xXae7oBjTMDsKH3fYEjNmWPCAdtAOq7GHYxs7UL
TVffRi9Qonp/AnWGrEMIavxIEZvnDXQpoSGFAq/fYq8JVO4qs0V1uThWH9ffijhZ
DMyYob8f83Oe02nhlNYOswp4eq4KY0lGUqATWK2SVgazSOpdQEFYy0kJdnm4DTv6
ihQlzEhxSlYs4JBkWZSD7OvVSM2g/OXx3qM2ZRpVYWc9LRY1FkfAGVGN+hyLNWA0
iwB9icc/cB0pQWdSdKlc1GVA6O2aczbYute6g8/ieut1EaxwdaqbU5/rsjzWiN3O
cMg864WuVb9fNWXgbbIcknDdx32lMwq+zfqw0B9rCLjAZflQVibHICpuqdNF1lfm
Vcg3TS5T
=PKWt
-----END PGP SIGNATURE-----

--C4zoTxfgmLIpFXZG--
