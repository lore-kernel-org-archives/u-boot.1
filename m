Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63650C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B459187D4C;
	Fri, 19 Jan 2024 17:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ybi6NZTG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C76C087D51; Fri, 19 Jan 2024 17:09:42 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8C0887D32
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:09:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5e89ba9810aso8097527b3.2
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680579; x=1706285379; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c4MhdjzsxLebKqd5b20KDnZRjaLnng/GgRrO5/Qwt10=;
 b=Ybi6NZTGvxfgbeQquCu6ctvEkrldCNBbPnjMW+5fSTUWNNCiBZqp1+DpgDUdQqVDQl
 SnEscSxZIhBBD4flD1+tiwIPLKSv8HWZRA5szQgNPNK1kpZdL0w32ZiI5ygFIQRVJcop
 PFhxjrO9vbvZJhCY/AUdCWYAOjOEN1/lIy8gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680579; x=1706285379;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c4MhdjzsxLebKqd5b20KDnZRjaLnng/GgRrO5/Qwt10=;
 b=mTXPqFDn4EKYzIQ541DkQZeb4aBcIvT7i18bybmh3KcPOe5nxjkw37hRAXfQhBz/CP
 gyGU5HLunIwLiLMkA4fAZfOb/J0q8+y66CN5Q2gmLTDEjYvhOXBEbYRHg6LRmYfAv8ZK
 OC4wJ6OM9IS4PzXka8nibgbTBlVWpryiz8uE7azv5oP3qujHeEp76HsGC9atkBwJoldZ
 dxLIpO7SBgh/LGEVDInKR02oajvJEWnON7vvtmlEx+2FQDreBSCghMkoX70PpebuUozC
 0woPO5ASM6RuDwqVuKrW9OnVaJbDyJUnb/lgp8NDUnqNLHN6OzehRYc1EAsKlDDl0z47
 mLIA==
X-Gm-Message-State: AOJu0YxrUwwgJ0gjxoIJSVohBQTSMkv1vmgkabzEw+vyb9jcJ/Xk+AH+
 +qXaQz4EXJzxS2hKhDBiK/KlF9AvXs6hljXduclYGZCiH40ZP4PfbLszJKLlvIw=
X-Google-Smtp-Source: AGHT+IE8YxDDTC1goTmcgt8Cg5P2sIEOqigYyrKV3APwoF25URpyaKByFBzB6882L9q6gXVJSCRTFA==
X-Received: by 2002:a81:6e85:0:b0:5ec:c970:19b6 with SMTP id
 j127-20020a816e85000000b005ecc97019b6mr104893ywc.17.1705680579557; 
 Fri, 19 Jan 2024 08:09:39 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 a126-20020a0dd884000000b005ffa3fa57f9sm274289ywe.51.2024.01.19.08.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:09:39 -0800 (PST)
Date: Fri, 19 Jan 2024 11:09:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] iommu: dont fail silently
Message-ID: <20240119160937.GD12635@bill-the-cat>
References: <20240104171335.342540-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7A8wbaNTXf/AWy3I"
Content-Disposition: inline
In-Reply-To: <20240104171335.342540-1-caleb.connolly@linaro.org>
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


--7A8wbaNTXf/AWy3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2024 at 05:12:22PM +0000, Caleb Connolly wrote:

> When attempting to probe a device which has an associated IOMMU, if the
> IOMMU device can't be found (no driver, disabled driver, driver failed
> to probe, etc) then we currently fail to probe the device with no
> discernable error.
>=20
> If we fail to hook the device up to its IOMMU, we should make sure that
> the user knows about it. Write some better error messages for
> dev_iommu_enable() to facilitate this.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--7A8wbaNTXf/AWy3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnsEACgkQFHw5/5Y0
tyw3xwwAnKZ9fO96RR/o/qbfLNNgeSFQZ8EG4Li3VgpRWyVdmzfCqKQoi/hj+fhQ
WOwCAotwL85yIpD11+7NV2dSB2ReVB1W+ILX95rNMxEzqZh7IPdW0/cNPixzoZDz
wbNJ4Zvpn6Vvo4Bvvtf3agDw2Y8VlcsgDZ+/x2zQBIPsnlcBZm3aoP6vAkbh3yxw
EMqOcEbbPEbPALDK+qIhIo3ZmgyBW3fxuHtszTxRvVSrHDqw5QU1WVcY15mUcIpM
yM/5x2v7cX5SQYjw9eJzIrVQsNq3luRSHfOLwOR7YodXZAoUkqUz2I4bS7Iwqi+q
wQSZh8+s4N8kcuQHoH5yVBJFhyOqesgjCTaanWAo1XyHbTbZY5/+ctcj1mPGqMvJ
JSleCzu50UnBCW1OQI/9vY3GCzOgMfhn4+1k3MBzOK4Fx9wQOOJYV00YIcfkqxT3
JmBZgweYX9s2LS+BkI0WUaA+ajhOMljLKcjg7Xr27Qo2Y3F4LXl2C3cVG0NWaEgr
e87pOu1V
=0RlL
-----END PGP SIGNATURE-----

--7A8wbaNTXf/AWy3I--
