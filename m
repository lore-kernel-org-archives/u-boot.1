Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B88CD4847
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 18:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C37688BD2;
	Wed,  4 Sep 2024 20:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nugeubqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAFC488BD2; Wed,  4 Sep 2024 20:14:31 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3AA888BC1
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 20:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e1a9dc3f0a3so4540291276.0
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 11:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725473669; x=1726078469; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YqfVOZ/RkQi7dkrv334I1DikdCkzoa+mSaSa8RMyUf4=;
 b=nugeubqaQVO/I1W7zX99eB7byCqftB41uav73IyESnnjKQp+s2EGbLqhtcjXtU2bIW
 +F6p8gJ5kQRWORazM7IWllr+fByRFYjT+32/uGiKjSDI90J3IVVWvvoo+kqvkgtEglTj
 mLU8PnbgPZkNItZ0SdRn+zeiyntEsYRByNLw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725473669; x=1726078469;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqfVOZ/RkQi7dkrv334I1DikdCkzoa+mSaSa8RMyUf4=;
 b=jt/rui6mRQZrPLB95FrXwXw71i0c8BLb++62Gvu0gRUExevBTIDZDLPyIWcDRiQlLU
 5jKxbreBIpQFFEcf8eYRwf2msri/IpPNysduWKSTeAGhQ604erEgr8uAkZ0sw05d3K16
 n2Yk/Pgsbld9UOkiQj8rm6FVyeNsxbtvpKlLqyfMP7L7A821wRt8CSYVuxTuyxsT2isN
 0AAzVogOU2mxZqCCVHLj8Y9ZuNSV+1ng08v9hfQUHV0hlRdO1RoMCmkfkdlvPEQQoBuq
 GEx/ejSTSa4M5onOKpYvvMrb+F1lifq+QODLRWw+q1DXCDqj6yh31+FKu8RQlQqaustc
 VBmA==
X-Gm-Message-State: AOJu0YzUqa0oP42KtJL9HXdXxgv7RMpPd7Y7ElgKHb89h7RwbzJo6Ldt
 8Qz3k1YBIt8mS8kHYRPFIsrj6TRJ/RtqsJRtuQbjgj0rOBt8W5ie4WJEdhI13HQ=
X-Google-Smtp-Source: AGHT+IG7Z/x0VHM8jXQnKY1mwoFPLDzgGle6niXLb8+PAQLO56fMmpsOpJe1uoJJByuexaixFskeGQ==
X-Received: by 2002:a05:6902:2585:b0:e1a:a3ae:3f49 with SMTP id
 3f1490d57ef6-e1aa3ae5172mr14736129276.43.1725473668634; 
 Wed, 04 Sep 2024 11:14:28 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45801db349asm368991cf.76.2024.09.04.11.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 11:14:27 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:14:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 13/18] mmc: Add more debugging for SPL
Message-ID: <20240904181425.GV2479150@bill-the-cat>
References: <20240828014538.3322013-1-sjg@chromium.org>
 <20240828014538.3322013-14-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9/9GI1RtVinepM1r"
Content-Disposition: inline
In-Reply-To: <20240828014538.3322013-14-sjg@chromium.org>
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


--9/9GI1RtVinepM1r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 07:45:32PM -0600, Simon Glass wrote:

> When MMC booting fails it is sometimes hard to figure out what went
> wrong as there is no error code. It isn't even clear which MMC device
> was chosen, since SPL can have its own numbering.
>=20
> Add some debugging to help with this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> +#if CONFIG_IS_ENABLED(DM_MMC)
> +	log_debug("mmc %d: %s\n", mmc_dev,
> +		  CONFIG_IS_ENABLED(DM_MMC) ? (*mmcp)->dev->name : "?");
> +#endif

Please rework to clean this up. I'm not sure we can drop the #if here
(as if ->dev->name is invalid in the non-DM_MMC case, compilation will
still fail), but it's silly to have a check for
CONFIG_IS_ENABLED(DM_MMC) inside #if CONFIG_IS_ENABLED(DM_MMC)

--=20
Tom

--9/9GI1RtVinepM1r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbYo4EACgkQFHw5/5Y0
tyzHZQv/a8lDBOcOQQCdtLQYF/s/6rvMk6rKqoJrcJh8w1h6WClJowVa0lWDK+p7
Ru2ZftTBOa0Bdh7/odsmC3PtRSF+uJ6oE8UMnxYRJcLioqCTecke5zkpyhjBL1ZL
ePpsAfqUEjV0Em1GE1jiUKhFQ5uM2hUclkUjdMPUNN+RTmwH7Do4yDtCbeSjjScM
DUdwer2RopBRJlzF35ONtKEB+IdLOpUHcWMhbBsm+VG12cslvONk7HcLIWjDkKCL
HnGPbW4o/S8GCW2bDQh2fftJJ2gibn4DbuTkWlOX/YYU0zMCZiyGd3TsSdrBCcQG
txMJpO1bYs3CZL1v9zBZf3LAS4qvqE03Wb/9HwcoKfKskTik4Uislne0DVuIZgDM
9Y1psJqDkppzRv37F7nIWYeV9RLewiMMzwBTG4IqhX2j/O+6tW0wsnsUvKSpALVZ
+jdTOw7vrUUhEg5obmhvs2BQ6EcBTbdR9E2XjP1MSRnlZsAZ/eekL31142GTJpzs
+/JgoLaV
=BinB
-----END PGP SIGNATURE-----

--9/9GI1RtVinepM1r--
