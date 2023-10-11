Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBB3CDB47F
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6FA186E8D;
	Wed, 11 Oct 2023 20:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p2hUB+WL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 044FE86E2D; Wed, 11 Oct 2023 20:39:08 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8619C86D9C
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d857c8a1d50so111858276.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049440; x=1697654240; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zR+Cgk4fh66Qpv/MRMAg7slzLFhQ4Gx3ASZcs9ZEu+M=;
 b=p2hUB+WLZ81Iqxfpq2ThGxI7DZBOdPEMdDUU/QLxfMBaxFs2PmDQXHYGsKTpcCmWt9
 0u8fkB7QMIx4a0c0gQ2G8hlzXcFI1HT/cHNxkyeSMWiAXMyZyxOKlZrVal2GofQZBhrx
 AgvVfFDy92dmwnjWv7nQl2mkN+anDaqhycYOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049440; x=1697654240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zR+Cgk4fh66Qpv/MRMAg7slzLFhQ4Gx3ASZcs9ZEu+M=;
 b=ZgVi3Vuj0djx8XwbSytUsgDWD2N9Am+ewt/ja7wvpCaD4wzayXKqpTMRyupuQRPs7G
 RnRIDQdSNc/43sGz8TavsgfK/3OCsVz8tKZXyeNSfFT5KUtPwAOWEVXEJjbLUdVzfGYP
 pHRoXIvxhCEccBKVMkKaM3J1Y1LvNm7faZx/HDtsi+PSkLN8xMv68YeHAgkRqnHR0Z6T
 SpNItok1HAGqLcok1ggnhH9bUSSv5/NAUcRuRuSmU2z5MRkinyiouz/hmb/tGG8Nb2Y8
 8/054bK4tt9mZPViigWk6Pn6pUZ8KLeug6kQK8Z4mHPTeVlGfmrN7DuWJWz6ufD2AGOk
 2bDQ==
X-Gm-Message-State: AOJu0Yz9C6n6CoM8UI/Su9/SVqHRLlqpRHzFCARyGhkDi3/wrjxq/VRx
 NXU2dCQJ4tnlWE+19mur9EBXSQvZhPjV/583yRpFRw==
X-Google-Smtp-Source: AGHT+IHtX76a7oV2c5RIBfBDH4h1VFC9KPCX0CLXu9YqzkXtvCqgOazykBQ56HSf2Sm1PtKzXX2wDQ==
X-Received: by 2002:a05:6902:1889:b0:d3a:28bb:2c95 with SMTP id
 cj9-20020a056902188900b00d3a28bb2c95mr26284238ybb.22.1697049439797; 
 Wed, 11 Oct 2023 11:37:19 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 d82-20020a254f55000000b00d728a2738f1sm4593454ybb.61.2023.10.11.11.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:37:19 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:37:17 -0400
From: Tom Rini <trini@konsulko.com>
To: Lars Feyaerts <lars@bitbiz.be>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] checkpatch: skip fdtdec_* check for tools
Message-ID: <20231011183717.GS3119521@bill-the-cat>
References: <20231002080014.1861669-1-lars@bitbiz.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eUkhsrV3lNjtZl0E"
Content-Disposition: inline
In-Reply-To: <20231002080014.1861669-1-lars@bitbiz.be>
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


--eUkhsrV3lNjtZl0E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 10:00:13AM +0200, Lars Feyaerts wrote:

> Have checkpatch.pl skip warnings for use of fdtdec_* functions in
> ooling; livetree isn't used there.
>=20
> Signed-off-by: Lars Feyaerts <lars@bitbiz.be>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--eUkhsrV3lNjtZl0E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm610ACgkQFHw5/5Y0
tyz06AwArXQkLcfwPGXsxK40sekhrynMkU6Oz6JvT8IeHelHmfkZeBVcoE2AHYvr
CK08jUKp+vMH3fFsblSTqphpWQneLKqcvh1O/KSc6VrChLPnhcSWU/PLJNcOwsaH
MDqsFLV8uGmZvtlrVUKPmZZmV7v+p8EQPhx3dGk+X0RRu1qIbncG4A859NWJ3Q3J
k6ObSdTIlZq6qegOaG7fIjERvy/VlgmFF34Nbl2sOvdJcBAKXhTgBPl2FmGMXrP3
sN9rd9DLBSjhAcG/863NCmdvJeObEl5vwrM9wHcSSFKxw4hJJOZLPkT7gLAdL0lY
MpexVVnKCBmqhTPgGSVXIjp7e43eZf0Kxhwob4zErV+pN+MPjE8FbYOxTo34RSnz
CBwCxsrURLuxV543YnYyWTLvGf0DdEQAG7Xjsk/aUgN42sEU8R92l9IoFHMQZLI3
/SAkMGUcsPQkdaXU+4gpdqHm1YQ5bp9a4EZCScHg/3nduASom1K6j8Bx5xeH5LnD
pNA3hWE/
=K8I5
-----END PGP SIGNATURE-----

--eUkhsrV3lNjtZl0E--
