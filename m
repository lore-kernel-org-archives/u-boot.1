Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21571CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 13:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B6D386EF1;
	Tue, 17 Oct 2023 15:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oI1CCnsU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B85386ECA; Tue, 17 Oct 2023 15:32:30 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D30C86940
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 15:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a7a80a96dbso57141067b3.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 06:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697549546; x=1698154346; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XKNoIfSO2TIcgpT21hf/j/MNXhit3XnG/yKcwMJTung=;
 b=oI1CCnsUPK/OB3SpS5mZxWuJHPL9cNZmiHHJxaOi790p67YAoKrnuRk/kWp7HQOsQU
 eXDl3oGu/53XCI7sUkelG8e+4h+D4ZK99UXtCVzKoOp+empSaDa3auDS9iR+VL2dX3Rr
 ait9uWqT+5aI4ed1HF8HXBaNLEbKqEbAykNxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697549546; x=1698154346;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XKNoIfSO2TIcgpT21hf/j/MNXhit3XnG/yKcwMJTung=;
 b=fb31EIdq+pAQFlpcEhuBuwCQrQIl8nTYXX9eHsd/R31XjEyiLi0JFmNLbt5iszEjto
 LGo52ZGu6DLtQ5DFQlzfSXjrqgKgXo7HAdmH+Ah3hg4hEBDyj+ot16FpY/ZY1M4JiFeC
 lSvKXCTD1gjQEQRRLgBu9PJMWWlGUk2R9CE677F0Ur9nuTJQFviIYSG3n8O/iP7tZBMY
 Ya5CNZgRPPpK2WdovGEi/iXIbR0dE+g5V1xxRSms8ibHoLcFwqS0c+YpHLdw8X2ovBd5
 R5aXSxSt5jceZPEcvPClByHjVlb7uTeBi4gvTq5/KkhC7ThbhEzDuXbY42/lz+s7AjaP
 rbxg==
X-Gm-Message-State: AOJu0YwYz3ULmngNW8eEdPlIXSFDP26AAGX6ePRksxqvBO5a7X7VCeNU
 QdLBC5TK8Xe3V7x60BlthzQ1AA==
X-Google-Smtp-Source: AGHT+IFwXGeo+E5Pm753M1UxXrfexr6Lo3Uvb5IwP1IKKolPXgkAvWBCwVeETM4CciawMdQzl9X9fA==
X-Received: by 2002:a0d:e890:0:b0:5a7:bc0e:8ce9 with SMTP id
 r138-20020a0de890000000b005a7bc0e8ce9mr1415461ywe.24.1697549546691; 
 Tue, 17 Oct 2023 06:32:26 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 v5-20020a81a545000000b005a2245c3506sm607815ywg.42.2023.10.17.06.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 06:32:26 -0700 (PDT)
Date: Tue, 17 Oct 2023 09:32:24 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 02/32] bootstd: Correct dependencies on CMDLINE
Message-ID: <20231017133224.GS3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F7UKgkTyLtIv/RD8"
Content-Disposition: inline
In-Reply-To: <20231016222835.596572-3-sjg@chromium.org>
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


--F7UKgkTyLtIv/RD8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 04:27:53PM -0600, Simon Glass wrote:

> With recent changes over the last few years in boot/Kconfig it is
> no-longer possible to disable CMDLINE. It results in various link
> errors because some options which require CMDLINE are enabled
> regardless of whether it is available.
>=20
> Add the necessary conditions to fix this.
>=20
> Note that it would be better to have all commands depend on CMDLINE,
> but that is extremely difficult at present, since some functions use
> CMD_xxx to enable feature xxx. For example networking and environment
> have a number of problems to tease apart.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Since you later rework things to tease apart most, if not all of this,
please split out the patches which tease things apart in to their own
series so that the rest of this becomes reviewable and also reasonable
looking.

--=20
Tom

--F7UKgkTyLtIv/RD8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUujN4ACgkQFHw5/5Y0
tyzsmwv/QqT9MzJ+FUUTDg9h3GjF3NMFdKaP5VXIDTmZYa/7bp304Tl2wctg557g
6tKVXVv+M28O1g+57BMV/6QgLYjtF7GWqySCnVjLr5eLfddxmfiZcTG9HW7Fud6O
3YQtoCEQwHzQcDiRIJUZjIWBs/TZ7BbV7Az32aAnqSP4R+wb/+alVWIVNqo8vZf9
4RBm5RLqDKFos97sOKpDQYmdBUNo/DAEiAyXlIWxKZ7ul0+2juqAosOIz9S1jaK5
fAdMpC5vJTKkqdqaKJpTU5EA5XnVRqpyQ2o6giFka2S3VfIBVg+8dejtjIQs6KF1
rpXv38eA/NVkdUqUa+zE0ixYTvVJyAJg0iYeOXZSybeRRk7m1TfiqjmeoDD+X6Du
lXgSAVgaVHOkZxsxnOdPYKWAmE31TqCiPbXnsMCDKZdz/auTEcXfSOMCrriiPz3S
o7HNBHaR/quEvJjHRey1Oxps1WQnICBCFzeINu7sxGAxyonZsAl3qye4euqHLOQX
dDlmnhpu
=a71C
-----END PGP SIGNATURE-----

--F7UKgkTyLtIv/RD8--
