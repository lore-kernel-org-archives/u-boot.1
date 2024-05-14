Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BE5C25B79
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 16:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF9F0882FA;
	Tue, 14 May 2024 18:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AYgZObwB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9EA787CF8; Tue, 14 May 2024 18:15:39 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3C268832D
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 18:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6a077a861e7so41695486d6.2
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 09:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715703336; x=1716308136; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HIMPuKtX+xqOshBc/iG4dBqpmOAUFZvSzUsqpg03gDY=;
 b=AYgZObwBgWGP/yqD97mqDfNuNAGM7NcCuJVostQyUhb0EkHqmI4GXRxLT67R8tBs4/
 xdEkA/ReG5+ZIfJ/kixvspdFpm5dbDzT6TD+svCd0jo4iGYZJQGN0kJB1SMy97H6QwFV
 p1+LYqRQCZV0708fs0N81kWA5f533YBEkSL7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715703336; x=1716308136;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIMPuKtX+xqOshBc/iG4dBqpmOAUFZvSzUsqpg03gDY=;
 b=SZ38Liwjx5C89tlw6aHz1o7DFAohRELWEYPMKCqsdR1YtXJHROlGGdJ7d/9gHINUnd
 wi5Q70B2uhB2LM7zySieVjmZvZJ85ByX295MDKnOMaPe4hmtCjhqLHWIOs9h8Dco4nlf
 gIw+7FjB/aLqgQ+I0SmzpZTvbfFP83ZBEKhfkQf3G6+fXLRr4ZFTo7AypGsffvfL6kcj
 1779QDjWgCUcSXHpOyvZxPmOUusHdR5fJjenWkzr01gs3z6skCJs81n9rjrNTO183nCS
 J4YtssbCw9YYmxfecELr8OZK87EcnBzhb46oYltnNMeEYvCj6hgRL/VAgbiLSBsGu+xD
 1axw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd01XqcHSch8nLYvlVPrE12nCJHja+tZp0AnlbP/8P/BqT3g/Jquxm6RW9kfq5vEsl5KyVvnh3j6HjlgXLaHEnfgMo/g==
X-Gm-Message-State: AOJu0YynPKHDV7AzTTFfQF+9HVK8utLdBtSfqFfkMKAjHUiN3usKbPcb
 Obp7kFrUQWItEkMn9Po2ojMDut7MtyVuFFqJuPCq7Y1VFAirnOfmk8udo334gneucLpaZqVzI6f
 OqOU=
X-Google-Smtp-Source: AGHT+IHQUxtUdU/VQaozWrGAOzZxUxHmK6d4rrFHSx08a316dCWYnl3BdHrEm6dKK9ta73M0ZjLC3g==
X-Received: by 2002:a05:6214:3f81:b0:6a0:caef:3c4b with SMTP id
 6a1803df08f44-6a16822f259mr163144486d6.48.1715703335827; 
 Tue, 14 May 2024 09:15:35 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f179900sm54840856d6.19.2024.05.14.09.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 09:15:35 -0700 (PDT)
Date: Tue, 14 May 2024 10:15:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] crypto: nuvoton: npcm_sha: Support SHA 384/512
Message-ID: <20240514161532.GP2568172@bill-the-cat>
References: <20240429063803.3049736-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mFd7Iq3CLgmxKQuS"
Content-Disposition: inline
In-Reply-To: <20240429063803.3049736-1-JJLIU0@nuvoton.com>
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


--mFd7Iq3CLgmxKQuS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 02:38:03PM +0800, Jim Liu wrote:

> 1. Use vendor naming rule to rename each function
> 2. add SHA 384/512 support
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Applied to u-boot/next, thanks!

--=20
Tom

--mFd7Iq3CLgmxKQuS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZDjiQACgkQFHw5/5Y0
tyz7rgv/UBksVE4325Uck/abDcK1x8m4aAd36aslNH6X/Nb9Hv4IiDy8hPpydQzy
jvhjgEqm3zzICqf1CjqRgdsW+Q/ZqXWWK1S/R/jmMfVoZAWk/wMKkKY4qOXZB2mD
HED9IdhKA4ze/WQlBVcm/PdGdEo+2oOn+8+PXaDx1dt+KRPfffLo1OoFThDPKx5s
79r8B03HzrSASClSTME/0fQl8akS/Tn1XN3REC/AOYBpCoDRVYLvgTTs0d6SAEZO
UcHRvuM1q5k48mwSeYtrvkYyHCTRXCcU2ErVQ0EkEUU/3AeXBol5zaoP1oRNS4x2
8+zKqSrsQsRrllMcbwLPtufKMuf7t8VUJ4pSqxRyc5xvzvN1xCOqhKccnXfE3NGm
CZHGJiftdKNojtias/sTVrZeNFhSe8tvnsXT/ZilMIG6WQcndAeHd4jP8bawDDR3
T5Tn3mFaiTItkCCXlAS0esDqoIPhv3uheLJ4iN2KH6fT0emEc9gHCnoPDG0vCh30
Wx2rus7H
=Qh9T
-----END PGP SIGNATURE-----

--mFd7Iq3CLgmxKQuS--
