Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A281CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 15:56:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F2F183FA7;
	Fri, 10 Oct 2025 17:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iSzvqGZ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A9F83FA7; Fri, 10 Oct 2025 17:56:55 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE4183F8F
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 17:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-43f489502e5so1042915b6e.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760111812; x=1760716612; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OqegRSAq23d9An6IQfZNLtnKjMkNlYGHW9/gHMBARDk=;
 b=iSzvqGZ52+YjBlaReazM0n6UVzckm8GE2GOJeCWEhU6cs6Ccgil+jprumweXsIpw3F
 eYYlNmuNRfCwqnJs03cQbeSQ+IvnuQsNAhuWqz9g3JRMQe/kN3doswxbg5LKVw73nX04
 hTVpNnc8llWU2J8yRkLSa9ieItY9npsGxwVzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760111812; x=1760716612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OqegRSAq23d9An6IQfZNLtnKjMkNlYGHW9/gHMBARDk=;
 b=QtqxYZXVjHbTPST8P9aM6kuqwu3yj1r32pcjZKE47dvjXedsoBYysbkVtknCjtiYXQ
 +dm8u6006BNyMBREzYXebfuaX5NJmQncrB8WNW8NG7fwICsSBEFnOFnG0bTzmcOHnEuR
 mXtEYw4KArUjHD4K8WotzBAPEHRvv5O/lcUnpSUn+OB/rP1fL0IeEPv5QWepgyi3Fqxd
 zVXOPtqTy7/tNQKqrBJCcn5yoD3JD8swnAb/nhwFaJSKM7dMTBBg1jkbwXUTlx5GeOYR
 fkD7kogJrLL9hN8Du0dNddCx/+/CrM4tc5Ls47B6iLbH4wUIs/Yl0nQHk2UKo23cGqBm
 4yaA==
X-Gm-Message-State: AOJu0YxADVaPtDIsUIyrQLhe1wjKYjvKqMtUTgo+XCj3m2bratF4yo7v
 DbbBjsLBBDbBwKYC0+Jk/PqmldEPLGcc4EXjKGleynTP9nSvg+Q3KJzvqoWv7V18g0M=
X-Gm-Gg: ASbGncsyQx2pjmgzT+8QpHps3Ue/45McoSMTJ5FeQIux90V//BM9I3P6Aq4taA//+9m
 uG12iWqx8rbnkpUYURYQOUQH4n5O30dc/hJBVbUcNXKd7xhcBFhu40tk6RoNKECh+mF1AE9NBh7
 smA5SkWSIN1JJk+zn86EqLAuyh9CU0Y/uzGzrbr5tvISjtBko6+t/aBgNo8nPI9UO8VX7DgN41o
 F9pftgIo1lUZmIZviJPSfBti5ZTjBkmdDGiYebg19UUiFpUDCp2IwWQU04UFVq35TNeULErL5NO
 07kcDYZXmsFLJ/4XxI5dCv8YYGhI4bZHqFDTVhjq4z8S9eVANRZ0WzunZ6J9Ps744i7mFaDRru3
 3eFCv2q3XMIhy8Arqp4HQXCjvRlsqR5xg7VsWDhCDtpDJCCLEX1yjDcvOLt3krn+NNAjgMh9P9q
 0WBVsC
X-Google-Smtp-Source: AGHT+IHDmXmbvJyIUqLMD4V9disa7OINJwzI1xPJ5R3J3wRGum/kho7mHWPRcW5DmMLak1xblOdufg==
X-Received: by 2002:a05:6808:1588:b0:43f:7287:a5d0 with SMTP id
 5614622812f47-4417b3bee6fmr6014065b6e.34.1760111812281; 
 Fri, 10 Oct 2025 08:56:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419889ffa4sm716371b6e.10.2025.10.10.08.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 08:56:51 -0700 (PDT)
Date: Fri, 10 Oct 2025 09:56:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v3 2/6] pytest: add test script to validate Firmware
 Handoff
Message-ID: <20251010155649.GC298503@bill-the-cat>
References: <20251010144517.3573014-1-raymond.mao@linaro.org>
 <20251010144517.3573014-3-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4qVk/L7dQH3Z4sMq"
Content-Disposition: inline
In-Reply-To: <20251010144517.3573014-3-raymond.mao@linaro.org>
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


--4qVk/L7dQH3Z4sMq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 07:45:06AM -0700, Raymond Mao wrote:

> Add test cases to validate FDT and TPM eventlog handoff from TF-A
> and OP-TEE via bloblist.
>=20
> For FDT, the nodes 'reserved-memory' and 'firmware' appended by
> OP-TEE indicates a successful handoff.
>=20
> For TPM eventlog, the events 'SECURE_RT_EL3', 'SECURE_RT_EL1_OPTEE'
> and 'SECURE_RT_EL1_OPTEE_EXTRA1' created by TF-A indicates a
> successful handoff.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--4qVk/L7dQH3Z4sMq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOksvQAKCRAr4qD1Cr/k
CniMAP9Pg7CVTWw1PLSLjeE7KDgD3f6Jo7DLnvBu5Xt7ir5aPQEAg3D2ZZ+nt+1s
HktNFUBq/fX9D4Hga4UuogpLKlhNqwQ=
=DRAn
-----END PGP SIGNATURE-----

--4qVk/L7dQH3Z4sMq--
