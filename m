Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E76FC38150
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 22:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B113E889CA;
	Sat,  6 Jul 2024 00:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i4P6f/P2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04645889D0; Sat,  6 Jul 2024 00:39:32 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4425889CA
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 00:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7035d5eec5aso256068a34.1
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 15:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720219168; x=1720823968; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QNd5WJMcVnNO2pVEmDoeQiHDBuJ4A02WNRmh6dvukJw=;
 b=i4P6f/P2Z27c1tErh/3bFC8myUdfcOzQYkpcnPuFvfJgq848IcD261LvqfRYrv5jSQ
 TBpFEjUT9ZIax+3PCTKVMUskV9gnYZ6SCv3cy6HpdDdNcLP0jLUpaB0Wc6/YZraDOK2S
 ElCnA0PO1j8b0o87iVklV8KSDIIP6H9C2386w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720219168; x=1720823968;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNd5WJMcVnNO2pVEmDoeQiHDBuJ4A02WNRmh6dvukJw=;
 b=XZv6leWolpC3Dzjz9VxdOK6c9EgxcLjf5+lrL5gJyf5wQ2PgYaAYrBoagi1Fz57jnA
 M+fNIb+bCs2ejn2btgr/P3tD/4MqLJ46EShoVXiyW+DgnDf4EiZKHRMYU/avAVhbN+xe
 nm7gE81GPOtyHSF45ue+4H0ZfW+MjlF7ShH4aRKgyD1HVSVDSI+L1IXKN8L7wyNyMFrm
 jL1v63SCyLbhJVGwTWEAO7yGpZcpjqIeHVwOIvfsMBXgmYC4A8btmimtcydhymjEe2cb
 nc7lDLKaXDiOd7VTC4LIpQU38rq+gYhqz3R7Lgsg1ipGL2D2hjdoKRXNjIjMxjzQZ/Fh
 n2Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjCOWuixKWYTpf0gnq1wuR5D2ICKIp4r+fZUENkewDoj8DHP4gYY4Hg9f8LhqrIAvgSfiTqDsxv5A5UM9j3S1ek4+nYQ==
X-Gm-Message-State: AOJu0YxT8dmQJ73n+Dkvagdt5cqJYLHffC8OOPFjwYjYe/k288g6yuHa
 ztRAwFKm3/rGY6GVhUH3MIL1KlxltP87v10oEKYABL5L6RojiaG7L+OoGqXq3D4=
X-Google-Smtp-Source: AGHT+IEHootT0T4vtf2FLVbgB5/EcXGyE+McfJ2u2dQOfz9qgOVY6RHIpJo1qo0aHhAmJWjV+LfaAg==
X-Received: by 2002:a9d:7601:0:b0:702:fd0:557a with SMTP id
 46e09a7af769-7034a813ecdmr6266258a34.31.1720219168526; 
 Fri, 05 Jul 2024 15:39:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7a99a3fsm2763341a34.16.2024.07.05.15.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 15:39:28 -0700 (PDT)
Date: Fri, 5 Jul 2024 16:39:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] Fix Kconfig coding style from spaces to tab
Message-ID: <20240705223926.GR38804@bill-the-cat>
References: <20240623174021.15247-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lQKr5n583+iOBiTi"
Content-Disposition: inline
In-Reply-To: <20240623174021.15247-1-linux.amoon@gmail.com>
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


--lQKr5n583+iOBiTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 11:10:21PM +0530, Anand Moon wrote:

> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
>=20
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--lQKr5n583+iOBiTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIdh4ACgkQFHw5/5Y0
tyxj7Qv/fIXnZlsODS5dPONzaZaOuSFmgf4nWzW3fAk0QXmSsgc7/j7lB0tvgd1x
hwQ7aXNCwafVDq9dR1o30oL75y7I+ABVKIkC/cVxvhVTWWMh3AZRm54GFP+wNiPs
lY6wYnBCTCOEq8Vdu//mlOUNDNngHOmLqXnaYl8fZRzmVX/zL8vj+ZbXRyOVb9qa
DUoF7tBtCjM+tcqgBLiL3Tm/WWD6n41IsU29NWX6x86u7Y0XS8OC0lKhU69GX2zP
NvYZhANQF99f7aoehzLKLFbta1bzJ/OthgkAv1I5C40gMgZUZBxVbUYyhC52Mco9
wwI34zOQEawB6/G//+IpxWiOEZ5WIf+3PwiKUHwoPvhMv2BLHl9iFPja10H1YmTe
UIkp8YYguQpU8sFtyHYNCjxJ/rjXMags9yIlKPUtRmgVkrhOecs2Yr2fuxpRKA2y
o7NFefu9/JZI6v+Tv1io6Wc3uDXYyfy2nuhp05q5Cx9C3HlR+EvVbBPRL+M0r7bm
pvaJG7rr
=dpID
-----END PGP SIGNATURE-----

--lQKr5n583+iOBiTi--
