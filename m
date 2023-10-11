Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8D9CDB47D
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:09:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7245986D3D;
	Wed, 11 Oct 2023 20:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g25ZUQR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6ED586C33; Wed, 11 Oct 2023 20:36:58 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C5C686CF3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-579de633419so1781397b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049394; x=1697654194; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MeDmHol+nWfbJL9MmxjwnujPMNCBiN7YDj5e86+HX1g=;
 b=g25ZUQR3HQXWB84xbVqp9Be8ryJLNpEDtBTlpikM2DbBRudNAR0YJv2wrM6VQHjVuL
 GUyM4pjBMIoKReyJJpWIO0dMiBxCTFPWvRaxToWaLNFJ+FVaw1UASZRG/wyKBuTUpMmo
 uemscexQpmeMzl7Nwi4uWAF0WEWatn4E+2H5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049394; x=1697654194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MeDmHol+nWfbJL9MmxjwnujPMNCBiN7YDj5e86+HX1g=;
 b=NPKg/81F8ZfNs2ilACdi/jAuLdtS1AOMOceWjMICWz3iJjkklLpK0vDa3iBgK/yXKE
 Tk10E/F332NGrE596X9P0phqfBT0enlImAiUrUMg0De7jDFq6FKDpvEgXmgHGz4JQQFA
 TVqNbDZrmqeP8AoxnfySTh/IJ0bNcpuhQqF8+bQLOJVmxzhK5/fWRYD2HEk3ID6QV1EG
 tyMs3T7cXCXmhEfL49ALeRaTlQmZkg/5bEne7NdhqE44p1aW0B0YGclWSGmfEpbLV3uy
 v16kCXoIhrOel74NyutUQarngDr0ZA829vyHC4j4oXCCXHhlibRQgDHH8eVrkpA13qnv
 QCfQ==
X-Gm-Message-State: AOJu0YzmuEn7JhddTO1AWGiyMLnkkat0wje/Xkmr5m1CGt7Nc59RwxUO
 mTUkyRUuocNl/vplzlV+RRpg6w==
X-Google-Smtp-Source: AGHT+IH9rDX15J+UwuLRnJ7EJSiSJyUm8gsj151+gxOUnKR2Rl9w8OlPVZeMerOPslmHpAC5E4P5UQ==
X-Received: by 2002:a0d:e855:0:b0:5a2:3167:b478 with SMTP id
 r82-20020a0de855000000b005a23167b478mr22699992ywe.26.1697049394608; 
 Wed, 11 Oct 2023 11:36:34 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 o203-20020a8173d4000000b005a237c85821sm5379343ywc.110.2023.10.11.11.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:36:34 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:36:32 -0400
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Subject: Re: [PATCH] board: siemens: iot2050: Fix logical bug in PG1/PG2
 detection
Message-ID: <20231011183632.GI3119521@bill-the-cat>
References: <aa0e6927-e35c-48b7-b3fb-785059f48910@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vT6A6CprsfUisYjn"
Content-Disposition: inline
In-Reply-To: <aa0e6927-e35c-48b7-b3fb-785059f48910@siemens.com>
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


--vT6A6CprsfUisYjn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 06:37:25AM +0200, Jan Kiszka wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> This caused the wrong fdtfile to be set and was failing to apply M.2
> settings.
>=20
> Fixes: badaa1f6a7a9 ("boards: siemens: iot2050: Unify PG1 and PG2/M.2 con=
figurations again")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Applied to u-boot/master, thanks!

--=20
Tom

--vT6A6CprsfUisYjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm6zAACgkQFHw5/5Y0
tyzLEQwAkl2ZIPn0b0JB8fJNNhfBQcoXRnVegEpWqm5vJNMJCeUL/96NLkfkmWNi
+aH72Rnx8qPKhEjZdQcg8pP332met71rE4k/0u0XiHGVNA2mOtqaA0m03GJgUy7c
amlbeAnTWEY1vciuRtmSdzxvdeuJrk0iEhrsxd62klJqtj2jQmmm4ZYhpe9c2vyj
2eAjCVdzmMNCX+i8VT8hAXQ7OgNIY7GINSjVy+ouKua+6qex74pYmqnBayQKUcPl
FamoAVzzmS2Xhmeh+NVgV7g34DM9eczprNwUfd5t+QdGHRRqCDyHSqgCSYS2wtU9
TRuthg9RAWEnzsJFR938C//4Bvsjw0hWUcaDmMmHLMuevD6OMSZZUcbrugZAwUGm
RUVB3UkrLUQiV7vyrSkMf/4sZHYeYHRXN3jrBTuvz64wYhc/OGT+TGBwhfb4+aOM
yYl8f4UxzpBb7V8LEWpE3mJsOzNktsjAveIpakG6XjiAXUFV9ZEIlpZDNEgN84eg
4Ozxnmwj
=eJ9m
-----END PGP SIGNATURE-----

--vT6A6CprsfUisYjn--
