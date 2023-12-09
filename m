Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBC3C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 13:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D5898764C;
	Sat,  9 Dec 2023 14:49:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p8kwebGg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42F9D8764D; Sat,  9 Dec 2023 14:49:35 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D57F8761C
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 14:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-db53f8cf4afso2732656276.3
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 05:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702129772; x=1702734572; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=viGG3ddVUOR9jQnPQ6fpgIoks73+hLt4VcHUHdAj3ro=;
 b=p8kwebGgD8/VFzw/6A9jcSltV4rSuN3jtvpDbQmrl1rXKUVbei+KjzLE4CuYZ2B/So
 +pbYgRxSI84eqZlcXtoeJaJe9g8VaekZAVff67aqaaSAXkGaEQEQ5yo8ySOUp1zkqipO
 7govCcjFZueXCjr23Wf6X1lLPn7n5B34IBkec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702129772; x=1702734572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=viGG3ddVUOR9jQnPQ6fpgIoks73+hLt4VcHUHdAj3ro=;
 b=uPsFO2/InHnNBOZmNsmptNslJhKbLp+ulwJkiPKP0ySq/2pqXjZXDonXlX+kv2aJlE
 LoelbmkTcmp0LI9nEH6eFV6HW2cTmP28Rshb2VhTynskg2ziz7ZQ5KPnhJaiMn0S8ImR
 EfQCZUoebR9FfpXFIjER3/zTjG4Sjee676poMgG93kV+lfvhvs6adoxkAb+PHGniTL5b
 Ls8WvQIdyl1XxpkE1bX2cKmhbBpg/7+T47Ps7OuliAD77VIGnegD2V8C1OG7kl+Me12Z
 wgHJg2wBUebrq68VbYGle+dcT3O1PZn9j3lMrhBfKMgGppv80zERK7I5G1ZStxXuUUKN
 BEAA==
X-Gm-Message-State: AOJu0YwM4W9FFMi0YFDkEIkFjtzJgxJCCAWmIjtSEK8NF23mzQzkM1Ed
 HClZZQ398HGpH5PATVrU+9MnUeKZNUZQbIFB+uiuaQ==
X-Google-Smtp-Source: AGHT+IGyqh0MfXCtfW0qMNEwlVotCFaWVb4ByIgEydTNG3d+yi4AZIcmya5vNcO59kb6OD2ffGEm7g==
X-Received: by 2002:a5b:783:0:b0:db7:d3f9:adcd with SMTP id
 b3-20020a5b0783000000b00db7d3f9adcdmr862845ybq.54.1702129771705; 
 Sat, 09 Dec 2023 05:49:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a056902038100b00db5331d70d5sm1270420ybs.33.2023.12.09.05.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 05:49:31 -0800 (PST)
Date: Sat, 9 Dec 2023 08:49:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-gitdm PATCH 2/2] Add some more employers
Message-ID: <20231209134929.GD2513409@bill-the-cat>
References: <20231203044719.667116-1-sjg@chromium.org>
 <20231203044719.667116-2-sjg@chromium.org>
 <966886ca-3e37-4c31-bffd-64d7ccbba7e5@kwiboo.se>
 <20231203213247.GW2513409@bill-the-cat>
 <CAPnjgZ0S2RZuuSGtqu6EMdogAerWpmOM65DpCN+T7jdEq8MzYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1Wj8zIsDExNQ9FbD"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0S2RZuuSGtqu6EMdogAerWpmOM65DpCN+T7jdEq8MzYA@mail.gmail.com>
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


--1Wj8zIsDExNQ9FbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 05:44:28PM -0700, Simon Glass wrote:

> Hi Tom,
>=20
> Would it be worth be resending this as individual patches and copying
> the people for each domain? Or perhaps we could have a way to
> encourage people to add the details?

It's just one table, and entry. So I will add a line to the release
emails encouraging people that want to make sure their company is
attributed correctly to send an email.

--=20
Tom

--1Wj8zIsDExNQ9FbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0cGkACgkQFHw5/5Y0
tyzAiQwAplXmAco3WFZGh4eFmlCpZAb6A0WK4DEevi7oQTKZoAawZ58fQ7ElyDk1
DG7doHWe868DFpPLcr2ZAM2EAvtpEw9L740KRZIWxlBCbB3JMVFCEpTEnQ9hb5Qh
sYi2VPo2tkAe2qNYEctw8EzTCSecfj7sHa86EIgB2A3iuPvaFKuD5TXQNL6pRmRQ
W6F/36i2VowyV85OtzxR6T1SbW6qXvhNOPfK/GzBzdxz6/KGRrGF8yP26QB39rhw
x2hnhBAF1M45zeyZvtc48Lx5pCijdSU3bEYlnkSO9cW6CPGlnlUbRUGNiAjwAz1P
Lq97uhUOlivCagsDZ+osooyb789HnCwhoJ8ByzDCKHQycHaodIkQe9lda5VYg5nK
GX7hh8781had/0OR1KCT1lTmywf225fmDBkcBB+/RO8zVEVOz/CZkCNpjdx3IhYN
MA+WxZ8PdgXg0mz2NGFs0unLxxFn5tYYcEFMJ4bJRkkMZLRyo6FVdE8w9viyBhlF
UeI2xuPB
=BOLg
-----END PGP SIGNATURE-----

--1Wj8zIsDExNQ9FbD--
