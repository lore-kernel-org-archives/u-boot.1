Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A36C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 296CF8802D;
	Mon,  4 Mar 2024 16:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cvBrWxc7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78BC487FFA; Mon,  4 Mar 2024 16:27:28 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E636088018
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6ddf26eba3cso3648423a34.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566044; x=1710170844; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDnlJN6BW8GI9Oz9JTTqMrcuPzWA9Nm8IKstX3m5LbY=;
 b=cvBrWxc7LrocDoDfCIJIUlCAjPqtgc7mtxmB2EPrXC3GV6+hjO3v+1zRa+Y8qHTw9z
 W3nbbF2CHoFtJHbAMXURYw28akkXnxBf2JgbYidyi3LFJmYNF3t73NH1Ri3VXlKmRDds
 aIzPmC6B1q/WmfMfexLVUolgYGuZhHBIrzgow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566044; x=1710170844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDnlJN6BW8GI9Oz9JTTqMrcuPzWA9Nm8IKstX3m5LbY=;
 b=QCp3JLVTyZrvnuHUipcnBbFcBTRCc/551mAMGCAO9QVd8BMCtrRHT/OQ7rvuT0LaWt
 QYDa0IEPOPLOOdB9HCoz+u8Dl2VAYOwKCpRa0uqo+uVqlBnQTufzlEEQmW6kGLrzqSJu
 +eVYP2FePu2GohljeDRrcSfOu4Qo+VWXXuGWd+N6s62jUTcOAjJUscHlmwgvAqYEoGQD
 g99FCWiLsiOKpCpX5f0/+Jk7kEAjR0P3eEwcJJGOwpOVYkF+5gztuOuuuJwBnF7w8gN6
 uwX3HUh5wOeEYvRzi6Z0Ierhdk+jOe3cryKURoCAdojQX5f4YwoF4vkpGT3yzOHbHry9
 wR3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2g3+cABpUQAgVPEY088Bx1wiaU0cTqbYqQjEXuR2+465i0l/sxhtJN67U+ftYzWlWOMqxqy6nbYFKJY1K9/tzZJZLlQ==
X-Gm-Message-State: AOJu0Yz/dlPoCIl0mDDcoL3BMmRQME4ZqnDxHD2Vd7VCNzgcu0wxHR5t
 7lKwJ/VphXhiidbzv+52+ot2LEAuW4Pn2WNcI8oV2hPzL3cOWBZfeeYm+U0KVEQ=
X-Google-Smtp-Source: AGHT+IGEXbxO/sJcYReVXoKsFTiOP371Ga6o04L8WEgcxGA+REvaurHDhRlx1jREDD5E3/PL6ibT7g==
X-Received: by 2002:a05:6870:61d4:b0:220:fc89:db73 with SMTP id
 b20-20020a05687061d400b00220fc89db73mr5338326oah.0.1709566044356; 
 Mon, 04 Mar 2024 07:27:24 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 s22-20020ae9f716000000b00788131dfa04sm2734662qkg.132.2024.03.04.07.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:27:23 -0800 (PST)
Date: Mon, 4 Mar 2024 10:27:21 -0500
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Simon Glass <sjg@chromium.org>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] boot: pxe_utils: skip fdt setup in case legacy
 kernel is booted
Message-ID: <20240304152721.GR1523872@bill-the-cat>
References: <20240125201654.17685-1-clamor95@gmail.com>
 <20240125201654.17685-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DQ9ig4hQ+JACuj77"
Content-Disposition: inline
In-Reply-To: <20240125201654.17685-2-clamor95@gmail.com>
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


--DQ9ig4hQ+JACuj77
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:16:54PM +0200, Svyatoslav Ryhel wrote:

> Currently, if boot with extlinux.conf and do not set the fdt
> U-Boot will provide its own device tree. This behavior is
> beneficial if the U-Boot device tree is in sync with Linux,
> but it totally halts the booting of pre-dtb kernels (3.4 for
> example) since it uses ATAGs. To fix this, pass `-` in the
> fdt extlinux field as a signal that no tree should be used.
>=20
> Suggested-by: Jonas Schw=F6bel <jonasschwoebel@yahoo.de>
> Tested-by: Jethro Bull <jethrob@hotmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--DQ9ig4hQ+JACuj77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6FkACgkQFHw5/5Y0
tyzRyAv/Vdfkpe8cYAgt3eB6zKpMb3WKbA5drw99cEz4t6JvVOTE+CLOSwWbmKT/
LB8LYzMDrnqwdA8S3pJ85Lfk3Q1JLqzcu7Nm1Gq37Klno3lqQo2A24gzxrHTktyy
e0yGSqnxFfDbsVcx/6pjJDQyFfPmoqzWnYECIpeN3Qcwp1nvgtxnxlzv4A/0l6Tt
LXXJvEjM/NMAPsncfZJXsHCPFBwhDSRfMCT9GLO5Tz4ulguFTrBHcsUBW7/jViJt
LCskrSJ2oYsZhA/1D9kUGWuXZlEEhiY/qkRt2caYil09HmPOBrrcWzpGEH1GhY/S
wfoO6gCnMv6hM5nlACTVzzOUeezyNBNSHv8zkfMhBASKdkbFsgeKghdjx2HZ5Yuv
Lnj/YnX9F3vJiqkSR48ppjyhduGN9JG9GLLVAfg328vOHGRE6wMTR62mo7/+yGVZ
c7t86/HjItFI50XkBK7fNEMHyPYnKVh02V2+8XtkLgvkAOqLo2tOZpkRWa7PRHZo
Ak/Hs3W/
=Z42Y
-----END PGP SIGNATURE-----

--DQ9ig4hQ+JACuj77--
