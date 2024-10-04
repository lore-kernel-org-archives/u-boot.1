Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1467CF8853
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 17:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F23E588DA9;
	Fri,  4 Oct 2024 19:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UpHeUnCD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A51288E96; Fri,  4 Oct 2024 19:15:07 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C21888C4C
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 19:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7ae3e3db294so137484785a.2
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 10:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728062104; x=1728666904; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Jfzq3SZLOg6Ss22y8ItyqsyBtA7QD6RuFNIt+EcVKZ8=;
 b=UpHeUnCDfFrjcvbQoDbYWb9Bj8dygt86L1xy6Ie43lsXQlb4SZzixw9kLEeRmGOo/G
 S1QdnA4tceRXmMfP7FTRmxayhZqUBnphkIOd6Gprr8e/7+IiLY+zOCB+mTeP6t0HlrRR
 9rWc9tZJQ1DTSrZ2j4TrG5TSJYC2GILzEtO28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728062104; x=1728666904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jfzq3SZLOg6Ss22y8ItyqsyBtA7QD6RuFNIt+EcVKZ8=;
 b=tVEBvLertaqVuFJvbJVKtcKB8Yj/TdoZKotfMV2Mpexd4VuGNFtmwY8VjNgLnWnLyY
 qXAjJyR3BNx1EdpZMYxDS32cXqj/JDMWZisn0YTSLMPP0bPUTRxwhUA8FD0zxtXeFGWx
 92RnZ3XHIki2lckHrw17Z8hRzMLWBHZKH4SCCmNL+yEoYmNfb5WKZ1pbuCeGnXH7NCjL
 DCv9lqiUfaZZRBh0z+PL4cmO4RgJND86nqBHenf2fF6BY2aNI/49IDBOgTV7Sw1zbgVH
 uFE8nOdKSYdgF6x7lqKNCAIYHOCY9v+by/nuxqK01Qt1M7vFJ6L4SlZO6lUqI79jNEIL
 5Lag==
X-Gm-Message-State: AOJu0Yz/l31pZc2HMZL9TbbxRjcRP4R1mV3bq9/KEMEAPBjssiWgb5ql
 y+2+d7E2bi6iTMTOmMzY97+9IzpdYLSwOdS3B98qgsghosYmbdv2X26GANHYwaGNSz7+M/tpre5
 n
X-Google-Smtp-Source: AGHT+IFGOSXpv+mjlaz92Hp9cauU9XPIXVFAgMs3C/T7FfKXmY/YYbGEirz/H+51pXbY8BfLPxukkQ==
X-Received: by 2002:a05:620a:31a5:b0:7a9:c129:297a with SMTP id
 af79cd13be357-7ae6f44cb1fmr577580285a.32.1728062104075; 
 Fri, 04 Oct 2024 10:15:04 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae756614basm2379085a.92.2024.10.04.10.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 10:15:03 -0700 (PDT)
Date: Fri, 4 Oct 2024 11:15:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 13/13] global_data.h: remove unnecesary include of cyclic.h
Message-ID: <20241004171500.GD4737@bill-the-cat>
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-14-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5ZDs/2W3UuTDg3fP"
Content-Disposition: inline
In-Reply-To: <20241003212802.3810-14-ravi@prevas.dk>
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


--5ZDs/2W3UuTDg3fP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 11:28:02PM +0200, Rasmus Villemoes wrote:

> Nothing in cyclic.h is needed to define struct global_data, so do not
> include that header.
>=20
> If any .c file relies on getting cyclic.h through asm/global_data.h,
> it needs to include it itself.
>=20
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--5ZDs/2W3UuTDg3fP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcAIpQACgkQFHw5/5Y0
tyw/Wgv8CesjEG52uM3dOSZP3IZcQ00kAv0TPRqr9knY/EqUwQECOVy75Jfe3gVP
Rd5blDpizalCfekSioVqVUzp6YAzEDEp3g52fbsi5v/Hfa/gvpgA+qayIXFC01du
09gzN96bfAKj3x4aQ0RIQrlBEY55tPMZIA6LefSgLDuVUwtTdUcC7FYSMdj/f0xs
h/saWpnOXavzwbqM7rBorbIrhuLm82N+6FCUuMbZZ2xy11zVFVGstkKJHoMfLwGV
hsFL+Q470CATIAhgRAEdcyZtjcAGoR91QbhyOeW0Loj1LWq9wyagTjKi3nhYJldO
I4za7iOTUctIjKYQniMlrjhjwN6POgfR7g5Tw+204errSkD+4plCGakiSjsPtIYf
ZDde4PXisA2eFiwQz78QfgGbDuOotr7SRsaUSEnGAxpsjsl5rhlBNVKdxJps9PKU
mBxLgYTEtbxgfK2PjbMg4e6qdSq38/wPI845HbyRfcDDBxDk+E730dE09fX6CaeM
UToswZ3M
=wjth
-----END PGP SIGNATURE-----

--5ZDs/2W3UuTDg3fP--
