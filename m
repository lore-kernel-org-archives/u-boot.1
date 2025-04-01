Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3945C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 14:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC3B8171B;
	Tue,  1 Apr 2025 16:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gcUf9YVo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E399381EDD; Tue,  1 Apr 2025 16:10:29 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A0C8801BE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 16:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72c7332128eso1067828a34.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 07:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743516626; x=1744121426; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NL7JGsRlPsISWlyFncZvCgNKSli641vbAbCYS2snx3M=;
 b=gcUf9YVoX160hx+FW/uVSa7zJGuwjCQZT98C2YrAXiOeRfd4VyydG1m5HVUpGgjUfp
 6+pwv7pTRiT7UwO+cNjjah4cocCfpCItSBi52QrTWpzRR3AFfhwNDBG21TW/qnJNkWCc
 98n0xGvm0euob7PwYSoF02c8vhi9XsANa+Jio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743516626; x=1744121426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NL7JGsRlPsISWlyFncZvCgNKSli641vbAbCYS2snx3M=;
 b=c02xdBnt5BHyaAZK8GucHZuvDQRyGjJNphVP4kkeQBSNBaD0vJfck8cyf0Yd6QWc8l
 COSuN/85QF2+FEKS53KF9x/xgmlM6IQD4rU3PPevEJroOQ+QEYV/qYQbv+nqENjFvnXG
 Y7l4j1Y0TPxdrnesHmoAb0h7aurzYmYRHSRB7Zg7kpjbc16i4K2fDHHOVbwkN0V2zGtf
 FH8o4PxzHdAmI8pCSqODupdF4jn8YxpHYhMzAbtw85WZ9F8lryDUMRye12EGasitsjkB
 y+K0qaVDtz2CtdoJuFiv972aKhnO/ctRuopz76BUlc7sYd4hcB0YQxhh7GgS/glft4Hl
 xHAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVghtBGamMTPEre5Ymp9257vshJP/Qz3EtDSRzqTo9WWmnUQZ0qDCStgGdIBCTYWbvn/XQK320=@lists.denx.de
X-Gm-Message-State: AOJu0YxN4zw//ulSwzX2LA6Kc5xE1/ZZ1ZMnH+oFKVQIJZtK/sW6+iBJ
 lX0iShEdEOIzR1pUBnbAnKOYfAnh5KTgJcUJyYVgXvVczYfqFk9oLJsi5N4IutM=
X-Gm-Gg: ASbGnct23FhiL01vC3fDYEgY+ZxSlGu4isiHIygzZwLk/0zFxDZcLMzqKnrY00UE5bN
 cSk8BxgrJ+XUNn0Tnf69GdKyrADWl3XnJzxFDtyzkFp0RWSPQ9lEoxFvaZK5Z1Xo8S6b2ft9xP9
 RYLLS1t3rkutChfKTvahI/1mlmWgFTP6D0wJNco6pOUWqmKBhRZRvrbulCf+sYMEhLx0l49N/bt
 31kNVSmwqQFbP89xG49izQ69J53t5+aHYOPQog0DeFoZdf7lagM+2CZ90jR67KCf/UDKRgq0nvm
 CCOSs6UDd9h4n0PnXuZ4btLMHyC969MzD+yEU0XUnzh9MyU+oz0vNXJfyEbcPBObYP+FaqtlMEA
 mMHa35g==
X-Google-Smtp-Source: AGHT+IFBRjtwII/ms8dNnIVQNnuncc96ByuVPWy7ly/khAA6pz6AC2RtyDxkAgSqCCzLs7cjbrk4fg==
X-Received: by 2002:a05:6830:2642:b0:727:2ff3:e045 with SMTP id
 46e09a7af769-72c637772c4mr6754015a34.6.1743516626372; 
 Tue, 01 Apr 2025 07:10:26 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c58267427sm1889534a34.49.2025.04.01.07.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 07:10:25 -0700 (PDT)
Date: Tue, 1 Apr 2025 08:10:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, joe.hershberger@ni.com, michal.simek@amd.com,
 marek.vasut+renesas@mailbox.org, cniedermaier@dh-electronics.com,
 xypron.glpk@gmx.de, sjg@chromium.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/3] Enable env in UFS
Message-ID: <20250401141022.GD5495@bill-the-cat>
References: <20250401080015.1470999-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m8zdrzSpocCbLmx/"
Content-Disposition: inline
In-Reply-To: <20250401080015.1470999-1-quic_varada@quicinc.com>
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


--m8zdrzSpocCbLmx/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2025 at 01:30:12PM +0530, Varadarajan Narayanan wrote:

> The qcs9100 based Ride platforms have UFS as their primary storage.
> Hence add support to U-Boot env framework to be able to save and
> retrieve the environment from UFS. The environment will be
> saved/retrieved from the partition specified in the config option
> CONFIG_SYS_UFS_ENV_PART.
>=20
> Also add an API to convert partition name string to block device
> descriptor for UFS. This API will be used to get the block device
> descriptor for the partition specified in CONFIG_SYS_UFS_ENV_PART.

In general, I'm glad to see this, thanks! In specifics, Marek is trying
to bring more consistency to some of the env symbol names and so I know
CONFIG_SYS_UFS_ENV_PART is patterned on CONFIG_SYS_MMC_ENV_PART but lets
use CONFIG_ENV_UFS_PART instead which I think follows where Marek is
going.

Also, this seems to be a generic ENV_IS_IN_SCSI implementation and it's
just that UFS is accessed via "SCSI"? Perhaps we should name things a
bit more generically, and it should already support various AHCI SATA
devices out of the box?

However all of that said, do we want to be encouraging environment to be
stored directly in blocks like this rather than a filesystem on UFS?

--=20
Tom

--m8zdrzSpocCbLmx/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfr88QACgkQFHw5/5Y0
tyxuDgv9FYUWMOF4RWcEkBmfA+qwySZjkppplRW7CTxKZujoIFQSO3jGwrp15Rq7
4nqqddTgUzlwieYQSZODiuoEnf61SqSAQhfQJMplbXpw0VBTi45nmPrAHQfWI18X
25cOFhGmobFjPUrgidIKy+Ero74Rrf5DtfZ+jVG284i8iOx5iPa9hXyAL/b2zWTf
vCJ6AQI+fQz7gjYlCYfHCTdp1Kmlg0towK7yKWmdoYJ7KHNykv3pusZbSglDQvJ2
goo9rGwotgJ/zI5cJFEFKa42DC9k41rhQDCbYWH4fCTkeOavgxnNwp4j7g5zW5dz
8X+efsG39azQAOC4rGwfz2EafPXmLQmSdlpowjcd88Co79BQConMAE/uvNHus3Ug
6B1EAm+uK9eCZzPRZcitIoHZJdA4VhX955znTqjSDD4bNhXehD4Nlt3pNsB9QHx5
0WuDqKC7M2JFw3esGPPcyNDQdYW7jnwmJtUPf180ZOJ9ch8PLhtEXsFWpgMTsioG
a4aWQXaa
=zQVe
-----END PGP SIGNATURE-----

--m8zdrzSpocCbLmx/--
