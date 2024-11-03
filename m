Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86381D11100
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 15:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE03988DEE;
	Sun,  3 Nov 2024 16:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o8EvWccA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DA1388DEE; Sun,  3 Nov 2024 16:02:20 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFD4D88D70
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 16:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4609d75e2f8so38431631cf.1
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 07:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730646137; x=1731250937; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6sz28AG6p6F+hf/wBqIOtsJmdL5PXto+SSwAKJH6j2s=;
 b=o8EvWccAG6f9pSWYi66s6Q70bgeuAEDTJfofqiItJRVoiruTkbGOnMUEG8pa83LMBe
 IvCKayHqga6xdlbogwwQppmmufgsbVJdbLIY9+Bj4sNI9eqzPl142KIvkBbgKTHLDZKJ
 va0JUnJtr7M7d1LsKE5husQ9BCyCER9cEOXOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730646137; x=1731250937;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6sz28AG6p6F+hf/wBqIOtsJmdL5PXto+SSwAKJH6j2s=;
 b=D+JZp4w59MvPiRoPaFP2wChHaHivTYYMU9cQC2eRdZtHLix3PBSTBUZa0ZOIy6yjkF
 MxMv7B+JsZ4njVkMm237fViZ4hqj4xDdv0FRvwzow8jtut8BT3KB7cqGDYzTcyPMJkw5
 s6U3UJUnriUgy/3od19izbRLtI+K+2EbuKcBiDmA9rsTcFPJFUa0hiZecwGLHeGUEqk1
 BgPvOroKfAP1TLnSf0ZDuAZjUJpXp2WEG2nX6wbMiUqUnH75W2u6Tuk9cgA5fb5DLzYU
 WVbpD/0z0EjJ0IDr1akR7WiJSmrIuaAlAl0u919TaZt62N079sa9wbZOVc9DeOiEDptX
 hRIg==
X-Gm-Message-State: AOJu0YygNk+Qy+2etjxp82jrRnx39k++cm3J993gOgD2D08SBPqnV/Dp
 pHNv/QCZPp8MUs0vPs8xVtbSMbsjGwF4V0tsjM5IYcoRJlIvCEJcHbr4PTbojSE=
X-Google-Smtp-Source: AGHT+IH6DpjBwPUlkOvEgAqpSQwjX1cyDs9tuGV1wFeLdhgalQvaiGxfapyx51dAYNZkgMhEhTU5JA==
X-Received: by 2002:ac8:7f16:0:b0:461:22fc:73da with SMTP id
 d75a77b69052e-462ad2c765emr201672671cf.16.1730646136453; 
 Sun, 03 Nov 2024 07:02:16 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad0c2b5asm38087661cf.45.2024.11.03.07.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 07:02:14 -0800 (PST)
Date: Sun, 3 Nov 2024 09:02:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] .readthedocs.yml: update Python version and Ubuntu
 release
Message-ID: <20241103150211.GZ3600562@bill-the-cat>
References: <20241103105635.107181-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="plkAByPqdwsMSsG/"
Content-Disposition: inline
In-Reply-To: <20241103105635.107181-1-heinrich.schuchardt@canonical.com>
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


--plkAByPqdwsMSsG/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2024 at 11:56:35AM +0100, Heinrich Schuchardt wrote:

> The current documentation build dependencies are not compatible with
> Python 3.9. Update to Python 3.12.
>=20
> Use the current Ubuntu LTS release, i.e. 24.04 Noble Numbat.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--plkAByPqdwsMSsG/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcnkG8ACgkQFHw5/5Y0
tyz2jQv+PBTig7Yq/qXud2d/o92eovwoa3SK6InEveAJI27znEQaADI/IQcmLOJK
c3wYTgLFfZ4z4pZbsIMMouRM2WE+DdrmXsnLdYBJToOdMQmupuM11s6b3K93Hd+3
YlZxetwiNVsKy9WWGOPlYh4+nK1549nG4lHsvnN0iVTLo8gOwOb3Gm4sjz/cphqc
fgBiie16mocdCPSoRgDCSzBAJ71Vd2QjKuryCoLq20x1Lsyt0vDlCdbsxG8wx47Z
ZaLdAAvz6RZbyzwNNpsyFWRqMYxWE6Bi4yOAgYGJZKeInnA5dDjzIEaRnaBSt5Cb
AnTG2DV/vf8x+Ig8qiy5KCXAvbF6vMqnwzeeIRLz2KSOWAnnIAI+5go4cvHBQoxj
IjvnMF8fHpHHeazQ3jTxHy4kEqPjX4eWHOdaEMnx1S9yblTTpYmj5VfDcxJllDPA
y+pmxGunG80Vj8rpFYhwJphB03xFGL5yiKMczpXgnQhqalQwhjfK7C2x57x9DMep
J/DDlQ84
=17r4
-----END PGP SIGNATURE-----

--plkAByPqdwsMSsG/--
