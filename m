Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1221E6ADDD
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 02:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C65E893A7;
	Sat, 23 Nov 2024 03:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aOhcakyb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95436893CA; Sat, 23 Nov 2024 03:41:41 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EB98891E8
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 03:41:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6d415acf76aso20157746d6.0
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 18:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732329698; x=1732934498; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bmiYoov0TnfKU7apqEpq9IdMcVM8K9Ad62Of74hotqg=;
 b=aOhcakybzoqyelVzXII5w9l38jSxeSlcDf6SJy5r7rn7coFqRum8q2FLJsdA7AKmtv
 l1vROylOCT6Sri0CwtBnlrncmPLucLZSYp5d9L62jxLpjaMMZnMht+7cCPwOgvgnqZJA
 5MqWL0BotLpc1poK3TKKif2UhLzlbkaV1dqmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732329698; x=1732934498;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmiYoov0TnfKU7apqEpq9IdMcVM8K9Ad62Of74hotqg=;
 b=fxOV9jnQTHWWgflPmM4/riYbGNTVWupLMDH9dOhV5YbfnN8R4Mupbm6TRq8sHRAOdP
 wV6rlToc0QzrklUOryWFXQ5uu/JzD5OqwJubxASTpRBhtswt+mouPqeoimB8w+Zs7A0p
 jUpxbktLM6SegJp6N1GCwTTbUtgXrp3oVt4NRhlvjd66ZMcyBCXZtxVR2e71QtOG10J2
 Y/S0cEBBj6xq43jrfYk1fG2bzHO85uTCYjm2jyLsMGIu2jqyg1+ofVYF+WAAD5zq64g0
 WRWSBGgTRHB/bvJz9bpIs5nJ5TTuTlZ/DEX1KYgQYYHxfZa+nU4PPn9papuMk18hDRKT
 FtMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcENo7XfB4OX9ZmLI2IV5OdejSrpwWfFfkSLS4q70X549v8PqmpcUTDQvxx8s1aCRnE55LV3U=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8coOxPID4PBMpndINy506txW6eL83WUkdCrpnK6V4PP9uDX0y
 jw//Pdj3JxrCir+Rc9/J54Jp409rUB/Y4V4pj8KpOQA+nnMHPnZ4nS/vqr+sSA+QzD99Z+8tkXO
 U
X-Gm-Gg: ASbGnctGmnO/Taf9lo9cn/Lc/sISNzatk9PKT69tVgcSsHnJ63oUbmJeaoxmjKgspSp
 HcFL42eIidUtXXFwxg1+dC8TqDbROqLYmwLKR4ldOHldVutwbkS1Z5BZlMLt3J5yaUi/MqwZ2ln
 5DMdmRen6IHaTsHTpaE7emt5hkyVGhUMFZGuqk57xjv+hLUO+7ojRQ1x5AKxF2WvENX9UfGH8WG
 lAnqmm9U24VLyWgJuoIK9xyidIgh8ApQ0ptUZRf0/mYj7g5aA==
X-Google-Smtp-Source: AGHT+IFeYVX4Ah5KltzTFYifERmSQky9HUGWICzwREkjR8j6/MYdElCLodxtzZoAru0cL0gnY4Pbtg==
X-Received: by 2002:a05:6214:2587:b0:6d4:382:6c72 with SMTP id
 6a1803df08f44-6d45115538amr67200266d6.32.1732329698491; 
 Fri, 22 Nov 2024 18:41:38 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451a97b1asm17266226d6.40.2024.11.22.18.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 18:41:37 -0800 (PST)
Date: Fri, 22 Nov 2024 20:41:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] test: unit test for hextoull()
Message-ID: <20241123024134.GP3600562@bill-the-cat>
References: <20241113211512.93184-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QmMNRFZl+OWnfZu2"
Content-Disposition: inline
In-Reply-To: <20241113211512.93184-1-heinrich.schuchardt@canonical.com>
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


--QmMNRFZl+OWnfZu2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 10:15:12PM +0100, Heinrich Schuchardt wrote:

> Provide a unit test for the hextoull() function.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--QmMNRFZl+OWnfZu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdBQN4ACgkQFHw5/5Y0
tyzHfQv8DtpNqM9nzmRO29I7pyWBJsyWXDn0gJH73dRTNSgCK9NUcdlP2DI165lR
rtMOanH4mIOQ16O29p/oGfAEukAesYoodJmpTonzh1cT2Y03YEUBYAObgJS7Cnjt
rrTH5g32U7jBhB9/368th/ZkXFbV1qoR8AB7SYuv5sQNarQ/5PphZUW3fyt4aLyV
caMHgOyg1JVWynCk9KNd8nRrsWhORg2I1SxEIzJFKU4+EorEQPOgesZN9OFhpFer
nwK7iE0jjN3viUGp2OrcASz2SqNX9bodVyKfrRLZmRrrkymbfeeLFyO3hEO7w4cg
T48I65IlDBveUFKHaxYXwboQGZaMMvHaa8S2Gx8MXfs/WcGsuY7SJl3y1jm1M8rw
dWc9LOFIFGKMD7usITTs+nuqhKWUBbPk04vCMkNc8y3GHf42fm+7rz4rxEWiv8Cn
KlOm6CpaVUbn0aR8rqvVh01Lti/HuUF1AlWkTo9xYSML43UNfVhRT26RPbUVwmwh
6po3mI+A
=No0N
-----END PGP SIGNATURE-----

--QmMNRFZl+OWnfZu2--
