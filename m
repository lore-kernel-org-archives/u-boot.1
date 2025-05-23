Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20E2C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 14:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BB238329B;
	Fri, 23 May 2025 16:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qOQZ2FPN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7AF18329C; Fri, 23 May 2025 16:05:02 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E011D83285
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 16:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-605f7d3215cso4716357eaf.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748009098; x=1748613898; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nbWwDftIGz5yJd9K415Bsc+AmfdFI1EPNjTOtqPgLGc=;
 b=qOQZ2FPNauEFiVpE6CUF9/aLLlDQ4QWWaaTMdjVTstD3U6hIO9JA+DkweTik1Kp5Mh
 SEk1ACDHb9OHp0LFh3Bg2ERFiweAcddPh7o8ckdANZH/ScVm2IXLr9ohSFs1dMG5VNlJ
 cJBSby5rOsfYFqf3DXf9yeUcpAR+1A1/+5buI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748009098; x=1748613898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbWwDftIGz5yJd9K415Bsc+AmfdFI1EPNjTOtqPgLGc=;
 b=l1BF5+h0JR+C3D8OlLbO986dL9dH2lDmCAeWNVWDhzk4yiHYJgqwQej4WpuK8GDbAg
 60MB9NdwZE2NpOh1H53PAyOTQzLe8g71EGQH06eGYfFcvMGGsMEWljInsfriPNrYioAe
 b9ep5aUvoXLlMNe70woMhI7WNfS+t/mdxYWvAkNTNBiab44ntnLlluysj4GHCO6sOJLa
 iqb18qkqUQwlOx0rL4yNidMvtXWC0WXCrVc2/xIgy3ARYRQpWVOZk4UrcSEEip38wBkm
 t5zI3LfgU3YJjej+dwDEz84uTkI1L3gp40mTc5Jq7Ijqg8MbkFanyYBFVmlgjbSCdfyG
 xBeg==
X-Gm-Message-State: AOJu0YxIiptv4zFC/Oejnduz4J3NtO2StKhzEJJ166brst0CpSQhN6Kn
 iaqu0BkZBxusGW5HrthImigcNW8uxlA5gnxWAB93kDzXPVeHKg4eGDGis7MzMq0+hrfMAryftL7
 9J1iBLXc=
X-Gm-Gg: ASbGncti8olczrXLcJkXPWPO0haO6MUG98DOlK0a9R5TQUaRDDibVSqKZBvuo6323Y8
 v6gNewuP7JGym+wH3gLdbkvdyFFFrzLu/zTiG55oR+PHc+5+Rh8e+uHMPxKzrUce1O2mZb/8An6
 IzyqM4IDR5fIHxNG+L7y1dqB6udmqOjD0NfPFh5n/XIGbE2fhunZHPuuic5HxS1m3mO3azXcv/4
 th0BRLvpuGE9RdTiGiOw6WCk9nIX01uGuzay7K9+IsvzVK8PCBauGE1j5oE9xxag5YXX/waLOLj
 hwEjAuesKu6t2sKxjxfeBifCD5/+Hz5hKbQEEdZn+jwYybz7k+wpdeUbRI8wDDwl/56G6i4S8cZ
 HZlUzDVNUSR6S
X-Google-Smtp-Source: AGHT+IGfyWF9A6FzeYSkPwTB6x7I8nbvS9W+z5PVSkKVOtDSB/Dz6lguRb+HPA/usOE5WOr+6weePA==
X-Received: by 2002:a05:6820:c83:b0:60a:5d5:b087 with SMTP id
 006d021491bc7-60a05d5b3b8mr16673131eaf.6.1748009098659; 
 Fri, 23 May 2025 07:04:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f2f1e2desm3149501eaf.5.2025.05.23.07.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 07:04:57 -0700 (PDT)
Date: Fri, 23 May 2025 08:04:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 01/30] patman: Move all non-test logic into control
 module
Message-ID: <20250523140455.GP100073@bill-the-cat>
References: <20250504132356.2317305-2-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
 <CAFLszTi6LwvSoNtThF5DzKjJNFzJxB5rk5DjYi9wzsfkiwwjcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oFbnrb8s0R7az1CJ"
Content-Disposition: inline
In-Reply-To: <CAFLszTi6LwvSoNtThF5DzKjJNFzJxB5rk5DjYi9wzsfkiwwjcg@mail.gmail.com>
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


--oFbnrb8s0R7az1CJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 08:19:30AM -0500, Simon Glass wrote:
> It is easier for tests if the top-level control logic is all in one
> module. Create a new do_patman() function to handle this. Move the
> existing code into it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  tools/patman/__main__.py | 49 ++----------------------------------
>  tools/patman/control.py  | 54 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 54 insertions(+), 49 deletions(-)
>=20
> Applied to sjg/master, thanks!

Odd. I thought you had posted this against master or next, intending it
for mainline, which is why I assigned it to you in patchwork. I see the
cover letter is missing what commit it's against. And instead here you
are once again spamming the list and with messages about your personal
tree. Why?

--=20
Tom

--oFbnrb8s0R7az1CJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgwgIMACgkQFHw5/5Y0
tyxKJwv/e3ScW4u9ygYYWQpFW33227PyXdBLKv1sMqfWxc25UDFY6hqkXcfcThY2
3jfoc9wBh8JxzwaHTV8sDRwjL6GQ2N8SpE/K4K8R97VAeOHh2ZmpRsZlpsTi0ucK
aVpbqZI4Nk+v3owmGsrjOT/ckCnUKThV7CiAVU4pFcY7sPA+pPaWAjotORUvtUtu
Wt7gLZtQVchSOEBSuyXHvHmbmym6w6BT95hggyjTlRNk1S8wUIvQ4e7dr6f4PAHY
o7/g6bFjSxEAhmBz0WpFDaaQ7oGsTb3tJrRlWrPH39AykpwjJl3C18a0o+AhIySE
8667G6WJh1hOUANmDmjaJaBMyuNIRkBDAA8dXU9JYGWq0W66rFwLtVqxsoSkI77Z
NjIsnAp1FTwAEDKka+PPn7T3UVixKI3Abbem7QSOQxGeOAC5AiZPqp+MA5EJkAE1
zGUAW9/PG1mToSU6LR/5C3unlzrFZxCeWiqvbQfE+Wpd1si+3bsxHTF1ZEZIY05o
/rMWjEIY
=w8NN
-----END PGP SIGNATURE-----

--oFbnrb8s0R7az1CJ--
