Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58489C46CA1
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 15:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6CE786A21;
	Mon, 18 Sep 2023 17:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mTIpS1UC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF79886A23; Mon, 18 Sep 2023 17:04:47 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0B8A86A1D
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 17:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-59bfb0825efso39572817b3.3
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695049484; x=1695654284; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pLXcMaF7GZlR1YNtdnPTQu1v3Dh80aRgxVG8L4xqfWg=;
 b=mTIpS1UC27oPtX56DSoIoqpyz4Ul9Et4sDBrreWLeIchh0hDZGj0eo4eN/Oif7dsbJ
 Lrx41WpeFqlL71vy0tyQhijp8K8tl3s2edQ7DSchLwV8UT+KowI4QO49fg3ioiaN9UE7
 MP3BPt0a+MFR6Kg1F19HK70AGm4nM+hCutRMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695049484; x=1695654284;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLXcMaF7GZlR1YNtdnPTQu1v3Dh80aRgxVG8L4xqfWg=;
 b=Nu+cp9w7ddJp4Z84mjISWhy2U3N9W7yWDM8MZmV+NPziBEeVN+hfbFmLBH6yTP6TZa
 12G/Or/UirmqTwA6K3qH3zH4gnt1JavD91XWcZpcrlzNAGZ6CB6z/K8XWZ3pZA7PHdwA
 JFnPO4rquXE/17zb7R+AoS0R+TNy5Uu9JIbeel/Tgf4ggALbZKhwuUe1Vh3pQuF1qaUq
 SgfGDgXM48sC7W+yvAM1J+uyM5TX8FaUmguFXF3SNqiOf4OX2gIad9wTySrG0Ng4/OG+
 nF7sc2x2oTN6/XhrTQ+F4AQCV97ExRYBl0dUPijgoVusnY75Oow3g/GlFSpMGciSZQr3
 skhQ==
X-Gm-Message-State: AOJu0YwH/XbkVGOtSfTsE4FEuaUm3rB24ltEDs/J4ItwzfnTWT9sAnBf
 DBqiiTXRMi78jEwAHCOvVYy7ZEdbobhfkNLYMmriBA==
X-Google-Smtp-Source: AGHT+IF+koM+pNzDrMkwBlBrrQLGBv4SnO5aFV3nnBXA+w1GHd5Nu7xHEKTUm23gFIJTrIqSAzstoA==
X-Received: by 2002:a81:6cc4:0:b0:59b:eb5b:fbbb with SMTP id
 h187-20020a816cc4000000b0059beb5bfbbbmr10275882ywc.12.1695049484590; 
 Mon, 18 Sep 2023 08:04:44 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fccb-cc62-ada8-13e0.res6.spectrum.com.
 [2603:6081:7b00:6400:fccb:cc62:ada8:13e0])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a817c0b000000b0054bfc94a10dsm2607357ywc.47.2023.09.18.08.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 08:04:44 -0700 (PDT)
Date: Mon, 18 Sep 2023 11:04:42 -0400
From: Tom Rini <trini@konsulko.com>
To: Randolph <randolph@andestech.com>
Cc: u-boot@lists.denx.de, randolph.sklin@gmail.com, dylan@andestech.com,
 tim609@andestech.com
Subject: Re: [PATCH V2 1/3] configs: andes: add vender prefix for target name
Message-ID: <20230918150442.GV305624@bill-the-cat>
References: <20230918121136.2295900-1-randolph@andestech.com>
 <20230918121136.2295900-2-randolph@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Der17iYIQ6AcxtX5"
Content-Disposition: inline
In-Reply-To: <20230918121136.2295900-2-randolph@andestech.com>
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


--Der17iYIQ6AcxtX5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 08:11:34PM +0800, Randolph wrote:

> Modify "CONFIG_TARGET_AE350" to "CONFIG_TARGET_ANDES_AE350"
>=20
> Signed-off-by: Randolph <randolph@andestech.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Der17iYIQ6AcxtX5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUIZwoACgkQFHw5/5Y0
tyz5kQwAuZ8ExzmVc2Ja6FMKXvV5Thzj/6G0XKWUOQOwWjmiehMiXzXbdWpmv/xA
oZ0XfeMBhyym9RjJ+qFH/Oggb5iVGG/ex6wxAu/tqz0CRJwix1SwqsqeAT1tzPzI
4FQ7NjIAPGVetQGl5Evi2HBVJwAGlauf2uvBn9u3DtcbywL6Jynu5NJkYKRSsNvU
IaNsbCfmHanJdfjE9UVLSwx9j155PQlSJTMhZl9ufnkQBvL8F7tU8e7lnAdzt7Ru
aOgmJz0IgFMEv7t0QqU9B1FylK4BMb6RFky4G5QqdQyy42vnQl8zknfUNvN9QSMZ
mRp6eleVzu0Lx1h477792wW7g0lWZHis/l51p+tTi5LewH9tKfKfhzqqc204bnA/
Hym3M8wzO+NUHFv3jXZ6ye71OHJBCxeoPN1w4uM2p61K4xQEDG0LnY/yu+MZi/sp
UaZXAz5fxV1yqJx1ruLBgVThi5NzvOpfnrDHE7dku5WHbH3EV2y1FPhkDuDoVepK
nTJMqu3G
=Tf1l
-----END PGP SIGNATURE-----

--Der17iYIQ6AcxtX5--
