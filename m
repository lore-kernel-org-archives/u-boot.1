Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB246EEB572
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 13:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62EA086A77;
	Sat,  9 Sep 2023 15:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YjYKXucA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B2F686A78; Sat,  9 Sep 2023 15:32:41 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F42C803AE
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 15:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-58d9ba95c78so29218947b3.1
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 06:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694266357; x=1694871157; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gfqvc6QIAoR4VgzD0V2dgnQNvRkEnNy8hFoz8fFo2nI=;
 b=YjYKXucAZZgBlK7ng8cBbXb4GnJo4B1GG+O5XOnOLokYyqLIA4Rnc/iaOWKsfYvQFE
 sxuRqX3NSk02rjQGaBOOsNv/7cGvH84fHv0E3IqF+97P6geJmyO0z2dbCLS6KADjdrjR
 Sw36F6hcr8q9Z5UYJiLGEgPJhV6122xH4I/c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694266357; x=1694871157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfqvc6QIAoR4VgzD0V2dgnQNvRkEnNy8hFoz8fFo2nI=;
 b=sBSD0YoiQfXBYsSOQInScNrmERrh6V3/r/1h+xeznW419T9nyGkTX5UFB/2Qv1TjLR
 rXuXx+CNrVtwMmHsmKnerbdDOcnsEsERhPcOlwtykzAi122jq8MmFfGAJphB+ZrC2pAk
 1ku0iyxJueQyemRYt90fujUL6keNhNUrWQ+Zl+d0PXF5tLAddog2A5aA19mOWXJnK+Oh
 2EJxz/9UUteOstA4ZhfjtOWZLonYs65rQ0CLXCxROjLqAA4Z70hpz2hkuckyF083qNVo
 /UFEeVybZLn/IKKN40PgTdB7Ghm4XDhmw+TIlDM4Ye5er81EQsITm9bd2Q2g5Ejjm9cT
 3EUw==
X-Gm-Message-State: AOJu0YwOWhL180ubDamiNfeQt96452dbNNSTCJfgXrd6d9brhztVI2zY
 ha31mkHSXqgSYuGyhcCkQ+xmFXLOmClAu7DTeiQjGA==
X-Google-Smtp-Source: AGHT+IFGVbeHFM+qCP/cxSKvbaHlU+8GVOp0iTmuqAAprTAnl6yEAdrKbkhXIbCEeWZckiDSt7uI0w==
X-Received: by 2002:a0d:d8d3:0:b0:589:f47b:beac with SMTP id
 a202-20020a0dd8d3000000b00589f47bbeacmr5212408ywe.39.1694266357412; 
 Sat, 09 Sep 2023 06:32:37 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f749-5d0d-9a20-19cd.res6.spectrum.com.
 [2603:6081:7b00:6400:f749:5d0d:9a20:19cd])
 by smtp.gmail.com with ESMTPSA id
 i135-20020a81918d000000b0059b547b167esm947552ywg.98.2023.09.09.06.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 06:32:36 -0700 (PDT)
Date: Sat, 9 Sep 2023 09:32:35 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH] ufs: ufs-renesas: Drop include common.h
Message-ID: <20230909133235.GR305624@bill-the-cat>
References: <20230909025435.84441-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qYOnGvBi4vwJBS73"
Content-Disposition: inline
In-Reply-To: <20230909025435.84441-1-marek.vasut+renesas@mailbox.org>
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


--qYOnGvBi4vwJBS73
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 09, 2023 at 04:54:35AM +0200, Marek Vasut wrote:

> The "#include <common.h>" is being phased out in favor of more fine
> grained header management, i.e. ideally include a subset of headers
> that are really needed. Remove it from this driver.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--qYOnGvBi4vwJBS73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT8c/MACgkQFHw5/5Y0
tywFUgwAi2kQh1uNtNGxqPokqvuwhM2Fepz5CGFvkYbcy9tyVwAHYZaBLJK8dYlB
81zSYpiJndaDrcOSXLGEftcvghoN350DJKCkdX0s1ptB1IHsxwwzNPkuwut9fqIj
K9saU+hXyHYHAiAWwvJr+sgwbPlyM5piITmmdQrxX7xeEMQY3HhlUZNjdJalRnsW
N0Wi9zD/P53KsGBkV6UmKlMywhTUZP/1c7dM5OcHBggRhkp5AkivOrcS20FfLpk3
f/XilSx/OKfAiQRm/OPUDaEwknQ234BZATUS5XrpPEP+9g7uaUcx8JOnk2wZ+0tc
z5WCcrBXJyz3/fwt8VVKD3sDE7+Sl1glme9qzThnRFD9/TTqogXlm32gZsPKlk9z
NPfYBHHhbms+MnIR4mMWZXNSy40n97BkQBrf8K60W331YoP/o17nKLwj3hYdngyS
mz4yym/ZR+g8YmY7ZvMedGRhPNKnPSn+ha14w+fSfP7eCM3vCzT95ca4l6YmDB7q
zTNHNr8y
=6wTS
-----END PGP SIGNATURE-----

--qYOnGvBi4vwJBS73--
