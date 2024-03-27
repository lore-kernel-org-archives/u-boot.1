Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0447AC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 12:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80AE088085;
	Wed, 27 Mar 2024 13:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dthr23Qc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 015CC88085; Wed, 27 Mar 2024 13:13:04 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC7318802E
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 13:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-690c43c5b5aso37566606d6.1
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 05:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711541580; x=1712146380; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q7bOMSQX24O6Qvro7a01ESuH486qhwnywjY/L1LXcEY=;
 b=Dthr23QcIWWPgr3obzaz3lbgRVLnUTzhSg/rvXTGWVX1BkkVlill3vG9P260mrWMeu
 N7W779ogBC6LVgz3DajLCP7dal+Gi3PcpmONTZPBo0kx4+8OC9eiizRZ8S7RcAyEZaIF
 dMvWcuM8jhp30ctjuoqmmpWjKnXMFTr/BRI7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711541580; x=1712146380;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7bOMSQX24O6Qvro7a01ESuH486qhwnywjY/L1LXcEY=;
 b=teKtyQrCjTJT4XaJkDR0ImFANVoA4KiKM3FWp9SOlx4lZkDY0Ej7hYamBevmcIFLRO
 CRoyd2+RvK3OZKJyfyGX/9ctDLWZU9D2XVBkVOl+fupIsFXKAwpM5dE9YqgzZVMEiPO9
 ydrEfvb4LvurUPKX0clvrm8m43R5V6YW5qiUeby2bgb/8DibpgsWae5iQBJieexI+BFy
 KIElA4NQWiH8XsM6k4oSgWjSnJHluOMgMq3jT50lfKvC786f+YqIjfgKwxeZR5cTRmXC
 KRHH0n7YP9qd3KcXKq5yxv9cfJaQcMc5zN2GQhmsKLCrVFo/Wl5mcw+pjtNooyTd3cYu
 /W5A==
X-Gm-Message-State: AOJu0YzEZnHeeShdEBb//+Pveli1uLt/0m1SPGKHDyKoRmGnotHvH4ni
 DBjH1+LYLx2N8UF6j3CR6NnYIiqnLopeWaIN8CEdWlKpw2bpLZflTwm+dVUNmHVcOeMwFfbRsG/
 D
X-Google-Smtp-Source: AGHT+IGCONjcnSQHgqmnljcO0JopzR2xIyqR0seFUPRw8E58XfRXaPtJZr47c/WMxzjUFjHuEqJBSQ==
X-Received: by 2002:a05:6214:2609:b0:696:7902:983d with SMTP id
 gu9-20020a056214260900b006967902983dmr4548730qvb.47.1711541580579; 
 Wed, 27 Mar 2024 05:13:00 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a0562140da600b00696af399fbbsm463205qvh.110.2024.03.27.05.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 05:13:00 -0700 (PDT)
Date: Wed, 27 Mar 2024 08:12:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20240327121258.GI3442575@bill-the-cat>
References: <ZgLME470PHld19If@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Eqin/1zXyIohTKHI"
Content-Disposition: inline
In-Reply-To: <ZgLME470PHld19If@swlinux02>
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


--Eqin/1zXyIohTKHI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 09:22:27PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit dde373bde392c38649c8c4420e0c98ef8d38d9=
dc:
>=20
>   Prepare v2024.04-rc5 (2024-03-25 21:56:50 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to 0cfe1bc6ed9b322d2b03ded3175ac5de3ed2b784:
>=20
>   spl: riscv: opensbi: fix check of PAYLOAD_ARGS_ADDR (2024-03-26 17:31:2=
4 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/20075

Applied to u-boot/master, thanks!

--=20
Tom

--Eqin/1zXyIohTKHI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYEDUoACgkQFHw5/5Y0
tyzK6AwAl/TRUcRf49YDIo7OcWwZExNu9lRIGEAv+ltuZTBPbb4hwG/8+nOzSe+P
ncqhhfHlk2V19UreQlkuj5FX1NDLDo/1gB6bpet9TRaPmyM5uksn7mTuJJhEKwBS
29iH/urgZfhQWoHGoZkUTOvZ8vcPEWuSNbgmCXkEPNPY7zhW2uliGqN8whNR/Yyf
x0Ris/vBh1+hP7f+/Rf3h8mIGvzYgvJpAXsGLgXxQtKdJgzS/DCLdAr0VQzK69CY
Kb5NtvPuh1HzUeZPOVeGXGUISDMUSkvGpMluJ12CPC4a8raECkJogPoOhXBXa076
REUTRknGF2mSzHy8v+sGTrGHIu0msbyXItnzVEuN7Rwc51lhwmzq9OzaUcnx4rlB
vtVV3FwwMYB+lRcbVa7lZDp4Vn+9f1UuYa8rXoNzHA5Cuh1f6HeUZbxruR+K8rHl
M6v7cXatligUMvY9LPN/ehOznbBrGcbpYgQs930B00tazuRZ+4gHK40cPrnop1b2
GSss9kbt
=SLgH
-----END PGP SIGNATURE-----

--Eqin/1zXyIohTKHI--
