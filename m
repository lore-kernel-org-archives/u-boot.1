Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C11C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 15:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38E97884EA;
	Fri, 26 Apr 2024 17:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jdJPDOjM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D8AC88505; Fri, 26 Apr 2024 17:51:48 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD7C488300
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 17:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-de5b1e6beceso703379276.0
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714146704; x=1714751504; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4QSuwpxe587FXumRhtFiFelfbxJLiDC+oQBKsyQo6/w=;
 b=jdJPDOjMEJYlvzqy7H8bKR3GMqDSkSW8MlyQNYqUg+XWv2LyPioWds3q9OxeXIE5HB
 m+q/uC8aQ/4AMR43CKcR/7sjzBEosNM9ecpf8d9q7jgv/QlahfgBHuUx+5GrrSMOwLLR
 rMudnO7gs2K3jQE9FlkioNLPtat4Re2rDJqp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714146704; x=1714751504;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QSuwpxe587FXumRhtFiFelfbxJLiDC+oQBKsyQo6/w=;
 b=BloNfZrgRp/2xrkfuaGXeo4l/udQqIAmzOhkysK5BrfuuMWulN9wlodCS1HRO0v2FQ
 A4pdnC8lOJ3unh1RcQqU7otJ6Uw0fZvt5Q2A4lf43yUU1qbs8GwSfHwkw3mzbx1x3J6f
 fmsfQy9J8fGhGip/uqFlTK/98v2Dd1tun1WCenPSc08mEd/ybpAOsmOfzvEvg2U3i11L
 Y9kPD+MxRrnKHz4jmbJhv7UZonqKZQR0v0uakVTO164qQwULDCz/wBxYIDvbbQ3vyD8p
 0FD92XHfBf10G5MB5Dz37Abb0Mj1vqdbefffuHs0e00zoFUX9BK76vGm2JDR9PggCv3m
 s1vQ==
X-Gm-Message-State: AOJu0YxpHrEPldNEOL/7SPLUmFauOGgMI4AKmXrN08XpzCBe/D3kR99V
 5u92FxIkjk7fu0krZAGtZX1QRRiI+EbXr7phVIEHmrq+Nu6yc1QCo9HDwsVjQiBvStpIypb0y90
 sfyE=
X-Google-Smtp-Source: AGHT+IFJKZbeoO2/n/RTvR0Bg7Ym2XPsr+I1lY8wmn9p5WOOD3qdHns1UtrCnyaa7pCQXYL5LOQ5aQ==
X-Received: by 2002:a05:690c:6c89:b0:617:cbc7:26fe with SMTP id
 is9-20020a05690c6c8900b00617cbc726femr3197345ywb.16.1714146704515; 
 Fri, 26 Apr 2024 08:51:44 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 js7-20020a05622a808700b0043936ed09bfsm6523826qtb.27.2024.04.26.08.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 08:51:44 -0700 (PDT)
Date: Fri, 26 Apr 2024 09:51:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, igor.opaniuk@gmail.com
Subject: Re: Pull request for optee-master-26042024
Message-ID: <20240426155141.GI1054907@bill-the-cat>
References: <20240426070653.4325-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AIwGrlWbqq8Hlf+J"
Content-Disposition: inline
In-Reply-To: <20240426070653.4325-1-ilias.apalodimas@linaro.org>
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


--AIwGrlWbqq8Hlf+J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 10:06:53AM +0300, Ilias Apalodimas wrote:

> Hi Tom
>=20
> The following changes since commit d097f9e1299a3bdb7de468f0d9bbc63932f461=
cd:
>=20
>   Merge tag 'fsl-qoriq-2024-4-24' of https://source.denx.de/u-boot/custod=
ians/u-boot-fsl-qoriq (2024-04-23 17:53:06 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/optee-master-=
26042024
>=20
> for you to fetch changes up to 4242b3976fdc5c6e7b90fb5bf38c5c345a0a9d49:
>=20
>   MAINTAINERS: add entries for tee-related orphaned files (2024-04-26 08:=
28:35 +0300)
>=20
> The CI in https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines=
/20537
> had no issues
>=20
> Please pull
> Thanks
> /Ilias

Applied to u-boot/master, thanks!

--=20
Tom

--AIwGrlWbqq8Hlf+J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYrzY0ACgkQFHw5/5Y0
tyzgxAwAh6V4QQjzSvsheQ+KxRLEnZs4u0Ij26749YlkIYEgh9s0IdA3rOI6F3Bx
oGx6lmQVNnM1LMkV4jG+Ad3FAdnQWMsdvIegoJCiZcx12m1i6A8lN6apJUqpw21D
Q/6WnPSpPJfjWRh6efHnH5etdqCPsykZx7Zmj0M3BEGp333A7PpiGeb5csFIWXvb
KHbzdlE007kdmojE+h6MUI7/u8UwvXBXj04meQfUFXsv+kN0wjONlApZKpwS8G5+
UZHbidWUVzOBkXyJIhrs1OvICZTydb6e9rW4V7AeJyCviJ4ACfDcXtu0WWmQSoJC
gX0tU8maReNlSDNlpwo01utGfUr1Mjm67uxCmPPB9iv/EGSNRFgpb5Baw6DDs/CT
S3ozHjTN4uilAsv0Ppn+CpNWTRV1390fKZxf+CXXLMsE7E3N6hEPFdvSwyK/rSIj
g4J/YsjyXUUCvxqgAuneipLtBO3MM7FZF+mWQWkJMa4IMKuY6i4DoPLhz5Hd4Um6
GbaY868L
=ammi
-----END PGP SIGNATURE-----

--AIwGrlWbqq8Hlf+J--
