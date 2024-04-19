Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2697DC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 21:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2CCC886C1;
	Fri, 19 Apr 2024 23:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="of1xwQV5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F5BD8862B; Fri, 19 Apr 2024 23:31:45 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA19388526
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 23:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-69b514d3cf4so19837266d6.0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713562299; x=1714167099; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VhGSalxpGlFp/REv0gWb0Yonh768+Uf2nouhX1irRx0=;
 b=of1xwQV5ySL7Wx/qHXdDJrRZN8mjM8MYonCYGOMH8HWZl+9lkMR6GBH8ZkcDq/rE4I
 NPYmHTJK71fZUytpeHz/PI9pBR+HKFImXii8ZNXzO8N7St/KXYEcTR15resdkjvs+Pjr
 TWtO03lDozc/KnQU6qHuB8HvYUmtCg3rj6s3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713562299; x=1714167099;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhGSalxpGlFp/REv0gWb0Yonh768+Uf2nouhX1irRx0=;
 b=qH5y1SVsCF8wlpKM1IepcP7/3lBzyGtrXbmhrN9Lno+KeSkSMOK8KLmjXfV/H3AbAP
 Vxtom2e3Pci+dcDdVnN6HLOF8ynQ/c/ykm/QFtWkLz7QhzIOCjeBmrp8hGgQyps+tgN7
 JflpcCQBbK1bdSzEK1drDr1rH/+0uZKYzqio9P6hnBfNiqWbqGfp5zE+cAGlSWktbcpu
 bGfGwANxQnuPdNF9Uk7l5AiiS8caI5793vTExZXDqYLqjDXs1x+yWdu3CIcC6u2UmqPd
 ILb//mXQ5bALXxeIXdjXkewQCABKyoorR+rJJK+DfOtMnrQX6OlnJM8Est06ZtcwRNmG
 yAUg==
X-Gm-Message-State: AOJu0YwneeDZ3sqGiN8/UjnSG+HOtX4VhAlZvjPRQp26G6KYs1Keporb
 rbNIAN1x7DikciGxt6xDL4nf/bEgDN+8yeXODXcwSJg/vc77lx6tM+GiMd8Y2L8=
X-Google-Smtp-Source: AGHT+IGJm3DsYRL3hWsKbJGvKe0MBAe9P9MOfDk1xVbttzXmMrGOwTjwnkkqysvmsgQxOyEktTcYPw==
X-Received: by 2002:ad4:4bb3:0:b0:6a0:6545:2306 with SMTP id
 i19-20020ad44bb3000000b006a065452306mr2672468qvw.28.1713562299678; 
 Fri, 19 Apr 2024 14:31:39 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 b17-20020a0cc991000000b006a0488c5cd1sm1880982qvk.83.2024.04.19.14.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 14:31:39 -0700 (PDT)
Date: Fri, 19 Apr 2024 15:31:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, igor.opaniuk@gmail.com
Subject: Re: Pull request for tpm-master-18042024
Message-ID: <20240419213136.GN1054907@bill-the-cat>
References: <20240418171401.4742-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EunRHG+hUIYqkF6k"
Content-Disposition: inline
In-Reply-To: <20240418171401.4742-1-ilias.apalodimas@linaro.org>
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


--EunRHG+hUIYqkF6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 08:14:01PM +0300, Ilias Apalodimas wrote:

> OP-TEE fixes only on this PR, no TPM related ones.
>=20
> The following changes since commit 2c3fa4b8add3cb6a440184ab67debc6867d383=
c0:
>=20
>   sandbox: don't call os_close with invalid file descriptor (2024-04-17 1=
7:06:16 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-master-18=
042024
>=20
> for you to fetch changes up to b905599b36e3d8158c5cd045c26278416909b422:
>=20
>   tee: remove common.h inclusion (2024-04-18 16:04:48 +0300)
>=20
> Igor says:
> "The problem initially was in the TEE sandbox driver implementation
>  (drivers/tee/sandbox.c) and it's limitations, which doesn't
>  permit to have multiple simultaneous sessions with different TAs.
>  This is what actually happened in this CI run [1], firstly "optee_rpmb"
>  cmd was executed (and after execution we had one session open), and
>  then "scp03", which also makes calls to OP-TEE, however it fails
>  in sandbox_tee_open_session() because of this check:
>=20
>  if (state->ta) {
>      printf("A session is already open\n");
>      return -EBUSY;
>  }
>=20
>  I had two ways in mind to address that:
>  1. Close a session on each optee_rpmb cmd invocation.
>  I don't see any reason to keep this session open, as obviously
>  there is no other mechanism (tbh, I don't know if DM calls ".remove" for=
 active
>  devices) to close it automatically before handing over control to
>  Linux kernel. As a result we might end up with some orphaned sessions
>  registered in OP-TEE OS core (obvious resource leak).
>  2. Extend TEE sandbox driver, add support for multiple
>  simultaneous sessions just to handle the case.
>=20
>  I've chosen the first approach, as IMO it was "kill two birds with one s=
tone",
>  I could address resource leak in OP-TEE and bypass limitations of
>  TEE sandbox driver."
>=20
> Link: https://lore.kernel.org/u-boot/CAByghJZVRbnFUwJdgU534tvGA+DX2pArf0i=
7ySik=3DBrXgADe3Q@mail.gmail.com/
>=20
> The CI https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/20=
414
> showed no problems
>=20
> Please pull
> /Ilias
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--EunRHG+hUIYqkF6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYi4rUACgkQFHw5/5Y0
tyw21Qv+NJp12SCJf92TmV41JktaeIamz88bHpLFBZcEnlB+OncB1mq0y3O1V98p
EW6VgnD4lB0hgC7DDpqa7j1RWNo0hwIt/fQ6E2faGFf1d1tuBXdLnt8T14hfNr7A
VawVTOVwPuHyVq3Bn7EaSTdsm5nB2FCw/THDPcvrnYD4grJnADJjTvI00aqmUPo3
p+yrcAih8J6ex8kBquJ0JEc8W+2VHfZU1DWMoMpkAQFnw4CKb9BFLFgmgHZjm8J0
2UU7wDiYkLCJ4XqCjHuF+mRcoxufbCIJ0cAlFXL/PRlUmlUxGgJYvcxDW+PiNsGU
EzDp90iJDWL/W93doc52VIS9IJWXSYR/10kEm7xWViBGCnKtkQ0YQ894AjbqtFNC
T0QygWC34HrKz82yHri7F2jv+eFqofmX9/n5hd9r/Q1Z8gpIIxRMsu607PO8uNDF
1qG1htVmxyCo6Wo572gWYGJv/Gzw2Du8dHpHnv3M5/zY7g18iXMfOSx+ocD8LoRd
rzHQnvpU
=WlMY
-----END PGP SIGNATURE-----

--EunRHG+hUIYqkF6k--
