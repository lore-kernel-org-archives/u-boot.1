Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89249C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D5AA880C5;
	Mon,  4 Mar 2024 16:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U7nG2iA6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B88E88081; Mon,  4 Mar 2024 16:28:48 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68F0388035
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78822ce8c75so68234185a.2
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566124; x=1710170924; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RIyUHcH27yBP+tQvBDsIivYiKHwaIIgiP9P1bZ6f1lo=;
 b=U7nG2iA63FF6x44vnUMqm1dRRDdpZHJ5vNt5z6Hkk41/4oPzPK2CzlarA7CiuCn30r
 dj3k6Bpw87QDi72LAAFJxCsFqfVMiIuVVczFkmm+1N1BCrP08IqwAMlBFJ9coBGXR0xD
 IekPlSIuwktz7xYYPE2Fm97HYTbgVY6PFDqHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566124; x=1710170924;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RIyUHcH27yBP+tQvBDsIivYiKHwaIIgiP9P1bZ6f1lo=;
 b=c0ue4qgrweaN5Sf4aiPH95e2UhmIP7+FIOj642Wksu9hzKEIJ1gne+tKT/wVNT2sYv
 brU3vv+XmeidWQsiz/NQnq+Exah7QJ1eAiMk3Il5r4Bln9uLkWkIcbkLtmqkxDtIvgNO
 OY35+N/bdXrR5D4MGmE1VNhbvkf2feVRfwLkOMzVDIW3EgYCNOQWhTsh8gQlTKReQVz/
 MNhNaaJT/TZaUNJjeTl0R9kAtK/dyiU36UAJ3Rgx0DnUCs3VeaSbwt6zz08t+swx12St
 KaYWabPWOmnUGeFVDI2lQsPlRK+o7RVelOa/mGvUFuxr2erV62SGfqy6iDJScMNAaasL
 oTag==
X-Gm-Message-State: AOJu0Yz6nBfSQUcm//WxqeBXj0N5T3GmBRSCppa7ooAYifhfZXE6OS83
 huSPfkF3D2Pnp9at6HHmnohyJX1zxm9t9Yy/bjzaUwoFcL6kSHkTbfhKMTGaJaQoHLV/ztE5hXC
 p
X-Google-Smtp-Source: AGHT+IGZeJyNwvs5dnywia4882pkJIwxx9a73TRjAcqflCkFV/I2HIISA/1maJg96zN3IY9hkQfGuA==
X-Received: by 2002:a05:620a:1279:b0:788:19a3:98f with SMTP id
 b25-20020a05620a127900b0078819a3098fmr6615930qkl.3.1709566124090; 
 Mon, 04 Mar 2024 07:28:44 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 t15-20020a05620a034f00b00787c4a07c41sm4448415qkm.42.2024.03.04.07.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:28:43 -0800 (PST)
Date: Mon, 4 Mar 2024 10:28:41 -0500
From: Tom Rini <trini@konsulko.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: u-boot@lists.denx.de, Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH] log: fixup log_head after relocating global data
Message-ID: <20240304152841.GF1523872@bill-the-cat>
References: <20240213-spl-logging-2-v1-1-e3a95b04a7f7@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j+xxk/as/toNYzuu"
Content-Disposition: inline
In-Reply-To: <20240213-spl-logging-2-v1-1-e3a95b04a7f7@linutronix.de>
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


--j+xxk/as/toNYzuu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 06:13:28PM +0100, Thomas Wei=DFschuh wrote:

> When `gd` is relocated during `spl_relocate_stack_gd()` the
> doubly-linked circular list in the `log_head` member is broken.
>=20
> The last element of the list should point back to the initial
> `list_head`, but as the initial `list_head` is moved the pointer becomes
> stale. As a result the loop in `log_dispatch` would never finish.
>=20
> Signed-off-by: Thomas Wei=DFschuh <thomas.weissschuh@linutronix.de>

Applied to u-boot/next, thanks!

--=20
Tom

--j+xxk/as/toNYzuu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6KkACgkQFHw5/5Y0
tyy+VAwAhZSSeRI6WEWvYj4kE3AatHTK05XWl+HaS4tVl85bStrlGChvsNfxPclM
TNvwxXbHN6SG+tIyivnDdSFZtNbf46RoL8loaOe5vwP4OeZhNOdIxtdWFdDcPGvj
r2z8J0pTxwbcpczqJCuzu4lU0fqL+u99n6g+ltS52rawguyU2smli8xGHOa1r1lX
LHfLKaUHjoXW6uVBTWZm1F68is/Q7NNAeLCDvrZu1SbZv2CCy0gtN143p8ZR3P2l
rohgnfxQznPsskFui18wDmOoN6PT1MOZV30Gng9aA9rgyKFYzbn6iKmap38/VB55
bENeUM9XIFGn1U8R6q944Adp/rMsnbr0ro9TK8TRlGXQi3cQZ0Y3Fg/3FzirP/ci
MXddJd1VdwQsCw8ghdow1SYMoiZ6wWQ/e1h/h9PAAv9nq32+w9LhUDCsSLZuTjwA
jnXw8WM4/nN2G7L37D68ODsUrrRUP5lApxRIEcy4WH7NOqZO5f5gHxHMeepVvJje
hIb1rrIb
=foID
-----END PGP SIGNATURE-----

--j+xxk/as/toNYzuu--
