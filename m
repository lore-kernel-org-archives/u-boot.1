Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E038BC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BC4E87D20;
	Fri, 19 Jan 2024 17:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cf4ymg1q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C3E787D0E; Fri, 19 Jan 2024 17:08:54 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A0E187CF4
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6dddc655a60so567060a34.2
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680530; x=1706285330; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p651r/ooOVepX9yhS/vqF8tg9zO9AEvdl47f3wKboDU=;
 b=cf4ymg1qsWRga3c7cU43+d731aOKOhNXkNKYrb4oaQTbdY0xEgUJM/Cpungpl1jbH2
 mhK9pNkxjThLENDh+4MJ5b7iiv2O9PCV0gUaVRcSrA2J6YVOMnIh85fwxMTWeEzl5NJF
 6v2bfNjbVoqmhy+QcMnYBDbk0toGqPy+4dXlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680530; x=1706285330;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p651r/ooOVepX9yhS/vqF8tg9zO9AEvdl47f3wKboDU=;
 b=wDGX5fXLRz0ORbqEauhfJlETXHTGE2UVqN6pAmqlP9YLtbAT5p7oZfrt8SYCensi0J
 NsUYxyPHF25YqyMCd5O3hbanVZkTpnVwGgP/IqGBG/0QaNciORB4cxj2xBIx7KrT0p+U
 leRptlq4Xpm4v9SkNG72cWxxs23CJTU0td8teoefgG0B7GW5gGCnFiVY+sZeWPm+fw8v
 JttrnPm2UCOSQqRgrbRtbXuzFeJZ2bXE3fiGNkPw5ygHG1xn80vqSjr+vpEKqRFSrTX+
 lPEC/WUfdiv16w5vjbcvlrMdiEMo+j9eO7A6F68Km2aF0hfaizk0W8Xp3/UFYr55EvBx
 9LXQ==
X-Gm-Message-State: AOJu0YzKu8HIcd43p58sdQ4gAkuMT2zkUqhB75IbmdiXVKup6yIijy/Z
 hL6ZdYWzDJQgqylsPfibrlewDaMWQw/IaT539Qpmc7X2n9XRtl0zQ0BGCG2DGw8=
X-Google-Smtp-Source: AGHT+IGvaSJ9c/RF5MvBgGWtP4PhLVxDxi2oYvOqOG4Azsz9jfsRtL8ew+L8QFgoCsTBAg0lCf93hQ==
X-Received: by 2002:a05:6358:ce12:b0:175:6ffc:2cc0 with SMTP id
 gt18-20020a056358ce1200b001756ffc2cc0mr2943564rwb.8.1705680530112; 
 Fri, 19 Jan 2024 08:08:50 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 ft2-20020a05690c360200b005f953b9e217sm7393985ywb.61.2024.01.19.08.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:08:49 -0800 (PST)
Date: Fri, 19 Jan 2024 11:08:47 -0500
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] include: env: ti: ti_common: Fix a missing semicolon
Message-ID: <20240119160847.GR12635@bill-the-cat>
References: <20240108-b4-upstream-fix-semicolon-v1-0-9437b3dc90ea@ti.com>
 <20240108-b4-upstream-fix-semicolon-v1-1-9437b3dc90ea@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Eva1kjeEnM7Q8KRc"
Content-Disposition: inline
In-Reply-To: <20240108-b4-upstream-fix-semicolon-v1-1-9437b3dc90ea@ti.com>
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


--Eva1kjeEnM7Q8KRc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 01:48:48PM +0530, Manorit Chawdhry wrote:

> Fix a missing semicolon that leads to syntax error while booting j721s2.
>=20
>     Importing environment from mmc1 ...
>     syntax error at 'run'HUSH died!
>=20
> Fixes: 0d72b0f2f83b ("include: env: ti: ti_common: Run main_cpsw0_qsgmii_=
phyinit conditionally")
>=20
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Applied to u-boot/master, thanks!

--=20
Tom

--Eva1kjeEnM7Q8KRc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqno8ACgkQFHw5/5Y0
tyx0ygwAljvcht3KXWpO/nvuRJ8oY4SCTG7ZZTjLC4eAHya7mo0QMuS7IeZjOJwW
MdSLq3J6vtccgZp0o+9DHG7CylmvkXki5dDoLTjc1JWmEsfu0LEOdvcZKGo7Ma54
q3FoWDPvBaSYFRwkRfjms9YJVnNzWDpOyvw7cBPxQKNp7Vj7v2SEWepMFXrXy5+j
ZxqdsZD4FHH8AzS10mpCtkXm0I6zCfnN0v5wJuCmwl6EbSUAV3L3vL3JOl7iPIAc
vhTwcgjpN3Dg9EBQvdHjU6ZlmKBgDl415Poq8M8vDVnq5WE5VRZDn6D6+uLOuhAa
Kpidv/Wb65ooPYuSC8XPy+1nw0xjoI5RGrYPruqx35xMG828iQdLWjf7M2LXVzRd
E+H3jp64i72LWOJOtWNCq3s7e1xZ3Ef54OAaTQf1+jpoeOBpsUcVs+axx771fOpI
JN/CCpI4ZRKEw7JW31zeQ7ZkGSN41k8wjGe2qI2wo41/YtwxVbHmhnbC66mWvtVD
M0gV/snl
=W+fG
-----END PGP SIGNATURE-----

--Eva1kjeEnM7Q8KRc--
