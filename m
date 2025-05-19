Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2A8C3ABD8
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 14:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F87982B70;
	Mon, 19 May 2025 16:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L+uvbrFJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8EB282B72; Mon, 19 May 2025 16:49:55 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B43EF81FEE
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 16:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7303d9d5edeso1668982a34.1
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747666192; x=1748270992; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jfNNeDgCpLTffNABzsfn3UYtrusMo+iZUd9RX9PelG8=;
 b=L+uvbrFJTBcMygycR1dj8lnywKUThyuS+1OVe2EKEM1hR+yRf9Cz1aOGBzdBX7K6qt
 W5sUGbWvdr2DzySbgoY/nqqPPEBjfy/KPPk4SpWFV6OwjbLYElzltAJaoOxdUshIhYzU
 U2w9QZVw+kB8fQrzSeIDkZhONwkJGoRTMlpwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747666192; x=1748270992;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfNNeDgCpLTffNABzsfn3UYtrusMo+iZUd9RX9PelG8=;
 b=pE5pGJWCelbYSxrzbAfMbuCdQfdCpvlhmg/FjsrJYg1bALkuHg1nuiCofpuFkEfUjS
 XgrJGCoiLn4yzENo7BTbcApVpYffYBJ3HhFOTKVtK1M8L8XU7G2KX3X0t3J1HHUjwUqY
 whO/Z6Hftbyzwzmf+R6XgEpjaZL/+T9njbuBMH8bOm7Q7JKSp7ymGwPetKJFKfFykxuh
 1nvjSIwfB+bnVhkbNa1/mvW2GCgmhL94nUC2vzfNtE3Tn7hQeuAITGj9/35qWsbUSnnj
 41kHP5SLACAmZiLMM0OO5kTe8R0m08cIHgpBM2RffWUBzwpg0zBlLxecKPXI8S7w0Yko
 5W1Q==
X-Gm-Message-State: AOJu0Yz8yeXydnXfcfGclL653aUJJu+LbGkb7PDvZEbzFFxrTFJelxaN
 tUZVa3wcirnBBHopgYxmZqBKRznB1QEXO9Bi9UHMsYkpg2DcbBEI7JcQFMRZwpVtEe1Yuy/Dxl4
 QZHys
X-Gm-Gg: ASbGncv26JyMdaVkC1wOQ3rfjFsiRogkAaWjsc9LfkVCmxQfVrsLBOYWnmxttTAHJUN
 3WKbWxI/YXJoqd0cvQJcpkpakwgP23fE89bNgxZAW0frEBWKAMzncRAEQwUmWwyS22gHAx3kXhk
 BBNuC0RQzmAPqWx7mZAQKfN7yitKZLF0fP3tMEeT91ZIEeKNkH7dtfeaFNXyXAOXkJPLO3p4R3g
 AYWNKaAhR0DlHwyNJhUMRBvrPfIBKZ3KNxmHGxR5e0fPUuYbTrk0zfN/vVgLbvhSk45wj1BQ38P
 r5r+lydMMtYXKhuY++pP1VivXYKcdkBq7Baxj/9Yz3ThZ0c+q72AtdonDihF9Nmv3EwEePNlKU5
 +yMmF64wk73+4
X-Google-Smtp-Source: AGHT+IFWAWP6+oWMJ2R8Amx3Wq6GWD5CEsQIeEaZLrAaEVryjt3HEIn3iDqT3TmqXeJIjUAoFcJiXA==
X-Received: by 2002:a05:6830:6819:b0:72b:992b:e41 with SMTP id
 46e09a7af769-734f6b8af80mr8220420a34.23.1747666192448; 
 Mon, 19 May 2025 07:49:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3ab1dsm1477536a34.51.2025.05.19.07.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 07:49:51 -0700 (PDT)
Date: Mon, 19 May 2025 08:49:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Benjamin ROBIN <dev@benjarobin.fr>
Cc: u-boot@lists.denx.de, jerome.forissier@linaro.org, joe.hershberger@ni.com
Subject: Re: [PATCH] env: Fix network support when CONFIG_NET_LWIP is set
Message-ID: <20250519144949.GP100073@bill-the-cat>
References: <20250517200930.78975-1-dev@benjarobin.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7ywriDrJqZkNy+Eu"
Content-Disposition: inline
In-Reply-To: <20250517200930.78975-1-dev@benjarobin.fr>
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


--7ywriDrJqZkNy+Eu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 17, 2025 at 10:09:30PM +0200, Benjamin ROBIN wrote:

> When lwIP (CONFIG_NET_LWIP) is used instead of legacy stack (CONFIG_NET),
> environment flags support associated with network was not built: restore
> support of "i" and "m" environment flags.
>=20
> Signed-off-by: Benjamin ROBIN <dev@benjarobin.fr>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--7ywriDrJqZkNy+Eu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgrRQ0ACgkQFHw5/5Y0
tyxHhwv/Uf+HPeETXt1klTzzXhXnCnzhFjwdpKOkvnhdkeUAx2DOmd9wMiRZ6b9t
uuyPBOMw7C8PZJR6OqV/zA2y0T/sM3boDjd2otyduqmYpcHW/UEemVPP6hD+REVb
3mF7DEmy5YZlJ3q7mlRuawHIKaUh6b0FgmBL3ghf8DTMjFgdFDDGI/KFEYm7uaQU
dWrT6GgimkSfyRyqecMM1TnDLf6rHoxoxK6j7NJK/z6wf8BN7GDpuXgRkWfrRwyA
Q39UVYRzWHhxmakUWHozjtEyT522V1p1xwkZ02Ne8SVCw2AAKTjQu3PqN1rsjtur
nIjNqijgTjwW6Po68Xp5xxneL5CiFy6VC70rsF5DqiWJxVmMueaq0Ruju8Ghvugd
ZWM/ynVkkjywrsUX20bBS4/jmUurnXGqwuXjJyHEbWd0slmc+RjhBVeM/glQZT4z
F9nhatArcyWNHoLmQcIFNN5o/kMh2tdzOihO46NewSlE0b3oXZ/8L8+3dJ+FnG6y
YwJfyuBS
=gB+N
-----END PGP SIGNATURE-----

--7ywriDrJqZkNy+Eu--
