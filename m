Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F2CC4707C
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 15:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F34BA87A98;
	Wed, 10 Jan 2024 16:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="azMSZHA6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D60D87776; Wed, 10 Jan 2024 16:46:10 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE8C087A97
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 16:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-78333a8d428so83025885a.1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 07:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704901564; x=1705506364; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r5tf3mFXfnS6bB8YRbq3a4OstKAHFSqEMK8npqD72P8=;
 b=azMSZHA6ER1tIykEvCK+uYRzQfzuyC3C8NjK+bdnGQ9f8DDvNHp9kwQia3Gtkspqag
 yjx1cYoi0dhhNpDkHE+33leYNCPeHJ1zLEsAiBTfQHwcDzfNMLN0THPKT4hoyoJrB5ZR
 dHiIX1LbgiRbgZ+zDp2K3tVARsIMP/6qPukKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704901564; x=1705506364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r5tf3mFXfnS6bB8YRbq3a4OstKAHFSqEMK8npqD72P8=;
 b=tsm/WBNb9/+Qd3A2IAPwUDJEhRKFJJ8S8Xl9phHRBB8s4D7PjWrWrwLFCLaN3VdC1Y
 4qGNlyPWP+VvtWEMWX5gSSEpaUBeW3gbk6gCTJL3u4icexoYBeJ8b38HduQc7jnReR18
 4g3K65jxcUezQGbIq2kPyrcS9s70iSs1bHBJPVWhSMbs8h41+Tt6N7q4BtIRktMTic8o
 muSGSjtCUa6ywjiqIkabZV+Iqnex47JUfaLHy7DV+zblsI8B4sp15dQYAFobkxutQzGX
 2CON2F10EwQgiOQY0bzJHyQpwSzpKgg8Wg7GDh8eHYqhHwVU8EwJGQd+Id0aiBNFEhm3
 oMPA==
X-Gm-Message-State: AOJu0Ywn1erOh2tOBj0QWRwhlrxswK8sQQw/ZkNshYAj3q5z6GZsiGyL
 UoPB2xk6pnDPNyNGZhmnr39IiSHTk+EK/Q==
X-Google-Smtp-Source: AGHT+IGAs3rgKbkyNyFv4YV4ZSQDNl+0oRCMxp93RnLXbKq7oz/JJYL7iZYTIaY2glSujyEbUd6d3Q==
X-Received: by 2002:a05:6214:5294:b0:681:1197:e7b8 with SMTP id
 kj20-20020a056214529400b006811197e7b8mr390851qvb.40.1704901564610; 
 Wed, 10 Jan 2024 07:46:04 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 w16-20020a0cfc50000000b00680890461e2sm1791283qvp.90.2024.01.10.07.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 07:46:04 -0800 (PST)
Date: Wed, 10 Jan 2024 10:46:02 -0500
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-marvell/master
Message-ID: <20240110154602.GF1610741@bill-the-cat>
References: <f8ce7a1a-8a39-458b-9202-ef2f364969a1@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vdVWuUmqcvzb8dkU"
Content-Disposition: inline
In-Reply-To: <f8ce7a1a-8a39-458b-9202-ef2f364969a1@denx.de>
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


--vdVWuUmqcvzb8dkU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 03:47:24PM +0100, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull this next batch of Marvell related patches:
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--vdVWuUmqcvzb8dkU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWeu7MACgkQFHw5/5Y0
tyzKNQwAiSnl91yxAwAJeqafE4Ko0RgOqB5r8gZa67ycYzxPtTdl8nC1oNpAk/t2
lGSTfnzH8cqNtiFNsJHPkUSmkTNzcsEw22smZp+72L81KZ/0MDNQMjTfq97/VsuS
i2h14baBi4iU6rJwO/q/H9aA+omvMH9mzVM+ZMJ7G7q6jJjk3gMh0fkocKWJgJpv
m7XNnrmbCiq/IBeJ+kFVgRWvcpRC+JXi4i4htTbb6nXjuxjARyOj1GYYBsOl+g4u
i819iApF6L7jpQyTxFAHwTkdswyDm50Hp53yf9smW74vZ5jwu/m5xDCt2AMdmYzO
7Mf9LRLzwBuF0bAM/EYFlDA0KExUe+8V43NIoVaXXUe7Huarstj5hIxjZLttL6B4
PyPXxpy1XRyjqniAph6gdj1UrBQeieS8cFYGq8MK+Z6TRArYXR7pBAt2MIv/r7O6
1K7bCOeJxuOoPuIsC0ci8Sq5PANL+szzcZ68O/RKU8Ba9thhUipFrz/Yp7w7zmkb
ps5tzoOr
=bWaY
-----END PGP SIGNATURE-----

--vdVWuUmqcvzb8dkU--
