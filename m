Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D091E71D31
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 13:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20B7C86EE0;
	Fri, 29 Sep 2023 15:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KuV3xWGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 411A986E49; Fri, 29 Sep 2023 15:21:43 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0BCC86EEA
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 15:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-59e77e4f707so172175477b3.0
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695993700; x=1696598500; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W9i1ue+6vj+pGXtTYb73Cr0YbvDNuZHW94bdKy78xiI=;
 b=KuV3xWGToXt+vpxDSdUvkxXGTYEnwZwl74sHFSBzu/FQnVmQCpc8cji/9AFWSVJaS4
 dsLfzDR9SnNDw5Ir5xxLD+ZEg8ul8RctTRlqEPXOFbcv/SGjFC1Hr68BR7qQlbOr3Euh
 REV8X9tUI4Kq3b46qoNFyubSARuYAD9eAyE6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695993700; x=1696598500;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9i1ue+6vj+pGXtTYb73Cr0YbvDNuZHW94bdKy78xiI=;
 b=NwFMXDtRA3emVSO8FBvT19SKGrxItqhMGXek+3YZmBV0zxpqWv31oNjbA0wUFMg4Lo
 1bcGmB6LSiEL2puqLxLcIFWkKjZ2Vs1pGtza/UTUJAnn7qDjyCqMvYVDIXFC5m53NBuW
 WNKxnorC2Jc/pN1csav5EKy3EcYDJWClEHSFKDXFpOUgdBjQdy8Z6ZOeMGPJFU5iAtxo
 /+YLZaTYn+gfTLID1UyIV6PWeFNoamd/LfBLHKYtVE6+z+HWWu5SmwD8QYlrDIUAOuGm
 3o3beyRU4YikUy1VnHAy2VG1ThsBpr6Hs1OH6qJg2WDy134ggelL3Ti2togw1/l9RaB1
 74bg==
X-Gm-Message-State: AOJu0YymUkfaEEBE3Pc0QmufM18/hlMpfDIx7pIHTMQfyYkR/y8XPMtp
 SS4JXaLWg6cvy3EtjYlWzULwGnjs76xy8AI6lDa0ng==
X-Google-Smtp-Source: AGHT+IHHdcB7SGEBtXh4uk4vfPkI/Bi9qZt+gp2ygUR457WpmnPORIQzPPI64HY/kI6o4cGGKcHSHQ==
X-Received: by 2002:a81:a24e:0:b0:59b:5170:a0f3 with SMTP id
 z14-20020a81a24e000000b0059b5170a0f3mr4116047ywg.36.1695993699676; 
 Fri, 29 Sep 2023 06:21:39 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a39b-08c7-b2a8-b94f.res6.spectrum.com.
 [2603:6081:7b00:6400:a39b:8c7:b2a8:b94f])
 by smtp.gmail.com with ESMTPSA id
 s123-20020a0de981000000b0059b4e981fe6sm5379006ywe.102.2023.09.29.06.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 06:21:39 -0700 (PDT)
Date: Fri, 29 Sep 2023 09:21:37 -0400
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] configs: iot2050: Disable CONFIG_CONSOLE_MUX
Message-ID: <20230929132137.GM305624@bill-the-cat>
References: <0ce3edbb-d501-4f93-90b1-3c9fa138493e@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uIFhugiBCa806Q46"
Content-Disposition: inline
In-Reply-To: <0ce3edbb-d501-4f93-90b1-3c9fa138493e@siemens.com>
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


--uIFhugiBCa806Q46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 07:22:04PM +0200, Jan Kiszka wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> We only have serial as console option, and leaving this on turns on
> SYS_CONSOLE_IS_IN_ENV which is also not true for these devices, leaving
> an ugly
>=20
> In:    No input devices available!
> Out:   No output devices available!
> Err:   No error devices available!
>=20
> behind.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Applied to u-boot/master, thanks!

--=20
Tom

--uIFhugiBCa806Q46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUWz2EACgkQFHw5/5Y0
tyzHrQv/agSMJEOb00BZu0FU7ZWpUuvc6A+V6zU209eP81xXSQHfI2K5IWx2U62V
4yR4RKAC/ALTSZEge/HFi/EVjL2Zr83cVTH9FjNENvVMuz6rlelIMhBN6u6n5LCR
L1b8Qsx8tQwAMS7yKC2eiUwlX7fKZNOgkjrtq0d0JWw2ZJF/HRv1uLeHtHnLZK09
c3KnW9Rk44PouKc9ck1CazzYw/68X19qJZskLz4NU/thZao9Wutvf7WZpf6dRBfh
MXN5HeteHer/hetvjKGw+wLKE3+Y87wnVrnUjsNHEiU+mllX6jcDv1/qnaXOKzug
T/L9WsONlJyAHYjCj29kLRpjQ9BsCqgnSeINcvVMTsCFs/fzl7PA+CDN3Kw4lXCx
m3+2awIZ0634MmLlSdkhth4xMdqRYkb5AZlftrLa7AWLasiKvX06zP1/nyI5E8ru
JHWOlcDOa9O2RI4BoIx9iFI860FAXvwbVPKNmiO6v7ESTFI0XsKfZMzXbZPyeKJj
he2hSen5
=lizk
-----END PGP SIGNATURE-----

--uIFhugiBCa806Q46--
