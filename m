Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B40E7718B
	for <u-boot@archiver.kernel.org>; Fri, 27 Dec 2024 18:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E706780362;
	Fri, 27 Dec 2024 19:23:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mzX0IIa2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95AA38036D; Fri, 27 Dec 2024 19:23:16 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 170F48035E
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 19:23:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b6f7d7e128so728726085a.1
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 10:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735323793; x=1735928593; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PZcFd1RbFSpM6f61LyzmDsDT4oCQWfZ4KXf3mIG47FQ=;
 b=mzX0IIa2wcyfxJ64mGqrewFkNhNus36vXNVc+NEVNV7JK0S67uTcur41zsnSf9ikgR
 9XfwDxpkdbE8jDY8grjXJvrN125PV6elC9U1abMBJv+sLEBrThT7xRHnxhD8YJ5u/cSW
 P0j37af+gy7aZ2aRO0VWKQsR7aiJe1ukS9WtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735323793; x=1735928593;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZcFd1RbFSpM6f61LyzmDsDT4oCQWfZ4KXf3mIG47FQ=;
 b=lnV8W7hQj8rCD+LqOwJ0z3pdi31EiHBTNPBakT9hwJiUncVbExP+yqVuP8bzSOKIlp
 nZ7yocM6MfDZTWicwnsDo0Mqheo11x2Vev7fHna4FNQDint9KTvLC8+JIQKieMLrR5di
 +i7fJi6qxUTEJ7XvjByKA2/lUrmil5BrdK14iRR5viKpbRHRMWk5WQE6LirVl+0oYNtE
 YJNz3vNAQpi/NLlbGg/5Up9Qxzt2RrJ8R4o7CPGXSBXIHCeVIoYKUptGoWwDDsLKLNZl
 rk2AkJ9pfL6nV51Blm8IQwKRWVkLYphBOt+EE6XVnyL6IHtKaa22KwvV2W/Jz2Hplk5U
 lN+w==
X-Gm-Message-State: AOJu0YyEJqvEs9d/6jZPSfxTMR4gQt7CZW9J9ryBQT2Q2NCG3xqiq30A
 lvxkshtHkrvXmYEW3Zmer9tPFKjpo+3k+NdeJLT0VTHEvtszm5nScWBgIhVhSqk=
X-Gm-Gg: ASbGnctHQPIzaygBd2FZtnyehbO6Vhx9PqR5+lKTV2G/nzZykkzRvkkRwbztUdRGCfd
 qwlwhTLLYXv8xXjm0VgUR9b0guLYOhS7N0pziDyVav39bHP1gxnq81dJ3lIomWZNqwfGjKP8e+t
 cOeHrkidNgQY6NjEE3kclN9tbjBqSUykJxdffmwE/H2cPoTZb38ca4zJGtCeb9RkT0Mjva0FT/l
 NEuI3IovcvuzibLoL9yX357Sj0R2qMUlF32rkvRnFK8IN5GQG73Vloxyg==
X-Google-Smtp-Source: AGHT+IFbeHQ9GZKZ+5W5A+4WQFWLYLMlrnc5WTbbHcEvDVl7/ZnZvC/450o57SvFAl6ankOTSicWTg==
X-Received: by 2002:a05:6214:29e7:b0:6d9:87d:66f4 with SMTP id
 6a1803df08f44-6dd1555469bmr469556026d6.8.1735323791426; 
 Fri, 27 Dec 2024 10:23:11 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb4b1sm80301786d6.78.2024.12.27.10.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Dec 2024 10:23:10 -0800 (PST)
Date: Fri, 27 Dec 2024 12:23:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, tudor.ambarus@linaro.org, j-humphreys@ti.com,
 marex@denx.de, michal.simek@amd.com, jagan@amarulasolutions.com,
 vigneshr@ti.com, u-kumar1@ti.com, seanga2@gmail.com,
 caleb.connolly@linaro.org, sjg@chromium.org,
 william.zhang@broadcom.com, stefan_b@posteo.net,
 quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com,
 p-mantena@ti.com, git@amd.com
Subject: Re: [PATCH v5] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Message-ID: <20241227182306.GE1505244@bill-the-cat>
References: <20241227044934.2109997-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CxGKVB6eA+FkXgrX"
Content-Disposition: inline
In-Reply-To: <20241227044934.2109997-1-venkatesh.abbarapu@amd.com>
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


--CxGKVB6eA+FkXgrX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2024 at 10:19:34AM +0530, Venkatesh Yadav Abbarapu wrote:

> Update the spi_nor_read() function based on the config SPI_FLASH_BAR
> and update the length and bank calculation by spliting the memory of
> 16MB size banks only when the address width is 3byte.
> Fix the read issue for 4byte address width by passing the entire
> length to the read function. Also update the size when the configuration
> is stacked.
>=20
> Fixes: 5d40b3d384 ("mtd: spi-nor: Add parallel and stacked memories suppo=
rt")
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

I don't think you've run this through CI?
https://source.denx.de/u-boot/u-boot/-/jobs/984698#L289 and similar on
all sandbox targets, and Azure shows it too.

--=20
Tom

--CxGKVB6eA+FkXgrX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdu8IYACgkQFHw5/5Y0
tywjqwwAmO0e1OFHekuY0eQ4nIlaKD0CFdqYOh2Qz58Fwh74jU9YMWYjVpoTpRMp
gJ1V9ER+SnPldynw/iA5K1kIAdsT+X6caySY7EsJaAbEO/saeirK+W1cT8n2+5u4
U5Kc5F5cdMSOzLIXp1i1iRDLfN9TJHBQp5fVaa0ZNFFGWvdpMcWmbVLbD3yEu3cW
JAFRUXkBC/hfipsLc+g8Eb3ZFsKOaE98ADoFijF4b1b0URVPQ8Fa6/gYlkCxxAMU
KFKXC7NXZQZNhMDWA455bY7B6AjnRDOuoL/WFqVdP4ltJjsU8JJaQlpW/tU8tXK3
EYw4uYl8BNWXLulvKKhueusd10pCXmySqQlqKMyMnftF+8fPOM54UrLBAQw6idab
L4/cP5iZX0egURLyVip/AwDp/sIYaqIgNkLztlX/hJUD/JTRQTCMeuEgT6RA7Dkv
gQgSECBcmd7P8ZSRG+afd+LgYn7R7iE3YZRt0Ih15xWJT8zAMKcltcJkKVDn9rFf
9FulTXK2
=8hMQ
-----END PGP SIGNATURE-----

--CxGKVB6eA+FkXgrX--
