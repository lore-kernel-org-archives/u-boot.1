Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120A9C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 18:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58D0288227;
	Fri, 12 Apr 2024 20:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JFS2TssX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F8787D64; Fri, 12 Apr 2024 20:52:39 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E9B288227
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 20:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-78d683c469dso85643685a.1
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712947956; x=1713552756; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TPjcBvBUVChsestd5ntTWrP/Tao5FxatARNoMAfKPDs=;
 b=JFS2TssX4SwR6VZpJrFgleMk+ZX/F+Mfwcx8YKfEr/CJwS1CHHtCmn2MsywjoOwcPX
 YDE4KtQq2GkNcc0ELLKKQuUSzyhh66m9wR/pPQNEJsJqzeB/XyxEQQzBvd2UScu3VNd9
 XL2YCj8ON/HXkpUFIvA6pINRV5Hcs/IKhfJpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712947956; x=1713552756;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPjcBvBUVChsestd5ntTWrP/Tao5FxatARNoMAfKPDs=;
 b=h3v98avPTcsPzqFJeLg7HxT4XOutfISCCZiMo47QZBCfHb4UhxX29p2w3ggvpsH+k/
 F86Z012cMuUUyhS8J2XEAefLTE7kAgU9DlztdC1qmRKAsrvMRo6bTm9TFJ3JM0myy1tJ
 BL+8WW4FDeBO/ZHx4/HWQe0HlYLuzNGZ5FObv7nVAg3VQ3TRXSFx9jZVqiZj78ZNui19
 NCQcn0wtTOUejD6zTj+xf4ybC8OX6fWg7Luo4/M4oAttNVG4AwA0N4X1fvgE6eRbgVbC
 COD0rLZJ4vMcrpVgnAl1vU5DmRbFt6I5opT5W7DVfYYfD5/29+BAcBiPp2Si/pfYT0x/
 LHtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcZi+8+92gM3EIVe9LVsrS7IwTyg0MkVvKUnCj0J5aZPvEfxMdAtIB9tHyQxKd7eCxudB1XiMHuH0hA64yP9lvGqXZLA==
X-Gm-Message-State: AOJu0YyGHHJ0HFIQnnit7W0LN4aufJ4IcHr+8Idzbz1RZ5TLBNSjYfaL
 Ywohtr1EYaMpwqFApvRvdu4UCqD7b34jpHUyZgO7SNjTXMUcb/bTmr59V4Fv8q4=
X-Google-Smtp-Source: AGHT+IFwgaiZBzoGGcM0zY7QC96eYRkg3cHl6gkIbkNsrq012fJCqKb2zjp7vQCvyoSunB2lAfL1mA==
X-Received: by 2002:a05:620a:191c:b0:78d:554f:ae95 with SMTP id
 bj28-20020a05620a191c00b0078d554fae95mr4876230qkb.48.1712947956565; 
 Fri, 12 Apr 2024 11:52:36 -0700 (PDT)
Received: from bill-the-cat ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 xx18-20020a05620a5d9200b0078d632edfd4sm2737235qkn.14.2024.04.12.11.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 11:52:36 -0700 (PDT)
Date: Fri, 12 Apr 2024 12:52:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Joshua Watt <jpewhacker@gmail.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Love Kumar <love.kumar@amd.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] disk: simplify print_part_header()
Message-ID: <20240412185233.GW2493117@bill-the-cat>
References: <20240403114047.84030-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D/ybc4s9ulldiDQd"
Content-Disposition: inline
In-Reply-To: <20240403114047.84030-1-heinrich.schuchardt@canonical.com>
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


--D/ybc4s9ulldiDQd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 01:40:47PM +0200, Heinrich Schuchardt wrote:

> Using uclass_get_name() reduces the code size.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--D/ybc4s9ulldiDQd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYZgvEACgkQFHw5/5Y0
tyz1/Av7BrJr/OwnnGh/X5700/nh6po0HxufBJ4g+giC7FdstGxA4QXmmcZn6ViW
dOWmtjFWyAqlaFweKocHfcV94TCDDZvk8rURjQMpTaI8AfJB+i2gsCwuK3lSKhSH
6awSiKDs8xFdDkFjAh4+iwh1y0nqw22dIDfR5BvGc0XYopHpAyObgyGzM6AuWdkT
MUHYhL0eqMQS3oKb/g0okvrgExakItwzIVfJGDiqYjnHg4Bwl1vQWOQeJ7MRf0++
K90T3hsVjod0BHAXk8rnPUH/HejrHRfZDYR1TCe06Udq1dRDLLgIaVbuKd27rc+O
ugst16IqZKwbgp1mlOIIxds0ggewQvBdEo8WLX6AapXSdELjRUWpFoOqMPvE5ykD
opOeUd/371BBpR1ys7A7IooVceDUt2zYTfEtWgzGGVaV3qMCUPjBqTOY86bPaqcq
9UfobAbMvHF10VoCM18SLX/0uegzQYvYYyWlCYqgwO8ZUGovel+n1IKOZ//TSCjN
6+Vgrb6E
=avpa
-----END PGP SIGNATURE-----

--D/ybc4s9ulldiDQd--
