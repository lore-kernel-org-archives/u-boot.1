Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC69D49230
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 14:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F7FE83106;
	Fri, 12 Dec 2025 15:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P4RJqWBu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70C13835FD; Fri, 12 Dec 2025 15:29:06 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 515A480325
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 15:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4558f9682efso745436b6e.3
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 06:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765549743; x=1766154543; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nWtLwuutEGB5JAqdiaKQd72qVpXx3hwhRVLD/4V7K28=;
 b=P4RJqWBu6/CTkCwp5AhQZPAM9b0HelKTD+TMW7pWEZVFvz8LWeP3xCYC4K4502SRG8
 okb6b5GIFRzunPmWLMfSLxExA1QEA0KWOykDPlMYYjFsK1d7Bdw93AiTmUYaavaqG6Hu
 v3SlE8zZPPTcrASnbzcF4VjpptyjHnYzGiOrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765549743; x=1766154543;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWtLwuutEGB5JAqdiaKQd72qVpXx3hwhRVLD/4V7K28=;
 b=k4Jvc5gxSHdh71TSTrfmnXsMELS6ZOvz527SEU0yMMuMPMVXAsXwWIxVhy8xYAlvro
 LABTRXDGYQiGWR7szjn8rHEuicT2CDS/ojRgbJ0ww53sGZmD054lGBLWZeQzGqX0g856
 IDVtkjGKIKZ3m0bvzGV4fc+cnjInY8ePNF1F9CUZxAgEP7JNjoYbACIaYohipsTQ1R8u
 h+Hu/QPLXtMu6XrNgHs+fpjaOW6FoMtGm2a3oMZ+025hwbDspEVEFdDq7mO/Pq9Exm5y
 QnM14KPLAnpaf9KjboeDhQKs8Li5dcPdUpOCl0qtcjKEudHWDU/zBXbccfMcPFDnaab3
 a5ig==
X-Gm-Message-State: AOJu0Yzf5YgYJVKl7a0M3ZcrtH89KIl8DsLGNe7ztEgb9MJ7LePc9QTB
 9hc8yKLtAzAk1+vP2B582xQ4/v0+vK7NrBvHOGSs7b1SkuDHJude6xXCwC4/jMzUULo=
X-Gm-Gg: AY/fxX5a3F+gu6A4VG6JnyzN1XMLApUNgX8F0vGjYheoMOcXTbjuYfEVowmEH2Aoi6+
 IIizS8lvlM5T6FHyyGnfahcSxgpL39V17BHeFp42ODkAz11d9nI1KT4WmAR0CzVrWy73Z5Vszai
 AlqHt4Qe9tMuQPatniW8LJNg2You3tiDmq2TrPNCb2LdMpbwDsBFpnJmwGC0JMzkPuDZFvSot0S
 yO0rZO4hRCtBASfUDwf/z+3HbspBGPlDpGxWUuvam4OWrCbBkrALJxV1uxcRmZTLKR7E//ws8se
 EbVVUjZal59skJD+/i+bZrKPcEXrxYqoiCOxMcsW76vnhFX4vDMmkmft/mY7YNaj1wiMMlWUzc6
 QHT/PtNdzitO0R/fUGC1ea6I8Mk6OV4cJ9AT4Pmg4HbGrCHRS6lsiTcyg3shbWWIKoTrZWQeNoY
 dBIKHJvMIeVZafltSKFVeVsFYPiFYGOFHwA7dPbUMQ7FFZ1RoV3w==
X-Google-Smtp-Source: AGHT+IGxiG3or6mDQu4vuqER6WWmZqI9vlKAVVMeOFnvoyEIyhAioZH0nn+zGMBZoVkyHAfRYr6psA==
X-Received: by 2002:a05:6808:2e43:b0:453:308c:52cb with SMTP id
 5614622812f47-455ac99ced3mr967488b6e.63.1765549743052; 
 Fri, 12 Dec 2025 06:29:03 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598b46c12sm2576457b6e.3.2025.12.12.06.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 06:29:02 -0800 (PST)
Date: Fri, 12 Dec 2025 08:28:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andre Przywara <andre.przywara@arm.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v2 3/6] net: nfs: Add licence header
Message-ID: <20251212142859.GQ303283@bill-the-cat>
References: <20251212-lwip_nfs-v2-0-9cb5a60520d8@linaro.org>
 <20251212-lwip_nfs-v2-3-9cb5a60520d8@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y2Eq4JUj0CBiVb0x"
Content-Disposition: inline
In-Reply-To: <20251212-lwip_nfs-v2-3-9cb5a60520d8@linaro.org>
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


--y2Eq4JUj0CBiVb0x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 11:32:26AM +0000, Andrew Goodbody wrote:

> Add the same GPL2+ licence header to the NFS code as appears on other
> NFS related files.
>=20
> Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  net/nfs.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/net/nfs.c b/net/nfs.c
> index 537d4c62de267527c85c5b1ddf2cda696f4ebae4..7bae7c78642cb33e5040c44ed=
9d0378222069923 100644
> --- a/net/nfs.c
> +++ b/net/nfs.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * NFS support driver - based on etherboot and U-BOOT's tftp.c
>   *

Sigh, I really need to add a check for this to checkpatch.pl. The "+"
style is deprecated by SPDX and should be "or-later". If and only if you
have to v3 this, please update this. Thanks.

--=20
Tom

--y2Eq4JUj0CBiVb0x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTwmqwAKCRAr4qD1Cr/k
CoUnAP9Q273g5o7FJz6ntli9B3WypKdUTi/55DHRtliQJVmCLgEA7lzQ0PDJfejq
T/okacrDSDcggw3ZOWkzE6I3MIA/vAs=
=sgfr
-----END PGP SIGNATURE-----

--y2Eq4JUj0CBiVb0x--
