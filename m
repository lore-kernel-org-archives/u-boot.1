Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61249C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 22:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D022C87BC0;
	Fri, 15 Dec 2023 23:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qKsGy9YB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A29218775C; Fri, 15 Dec 2023 23:48:46 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1AC287C87
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 23:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3b9f727d94cso603228b6e.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702680522; x=1703285322; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V+hKGYDh5cJk2pVw/HmxoKPYHtcOJTOksfR/mIwunmM=;
 b=qKsGy9YB9YGaImbYSZXdYPerdlwOlA0aj3cnfta+Ko7mApZPHYJjrOEDu/pnC1xcZg
 aLWgDB2lSdb/J93PQBGLdpmE429Qh5N497xCI4JKI3ZONn5L6DAOFMXfLIC8os6L0fjc
 p7FrnxNU49BiUGGme6mimA05N/gaTrhPb/dZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702680522; x=1703285322;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+hKGYDh5cJk2pVw/HmxoKPYHtcOJTOksfR/mIwunmM=;
 b=sSBLpM0qNfr84J9wZW9rGwD8dcF/vnDz3RCq63B66i2bcALm39xk9AmHJrKujdkF0L
 C7tlCp0tYuqDOdtL+GyR6RuxTOH/OShCll8rHiA0D4e/X9F/vh3YQNdo+dX00uXfEugt
 8rFUT00iO6VMEs2W/P60vo3FdcB7yjV3GiUx2ywiDxxjXGKPzIZ5wsHPWaZ/ANl7HTIL
 JDxdulh2iMM6Pl6eN6Wul77DxFq4inDnwJ0rcxUScQmLZk1HFxesRE16it4US2d6aqxl
 3ss7us1+E1cFO8anS3daHE3GErX/KIU1wpJwXzCYmiPsXP6Th9kVhOX6tMtgTVZAD/Cx
 2JIg==
X-Gm-Message-State: AOJu0YxWfj0sJhL/XbyHTGMI4gx+5VESUYgBUXnfMdm+W0w4hF9xq1Zg
 8Y3nAc5gUj8ULiWu0pV3h+zxdQ==
X-Google-Smtp-Source: AGHT+IGKgg6iVL6IUvehRvNWqkWLqd2Q3FnJq9DF60AIS/61RIQ1coqWnquxuEVndQRjjp1CcmHB9A==
X-Received: by 2002:a05:6808:384c:b0:3ba:e76:bed3 with SMTP id
 ej12-20020a056808384c00b003ba0e76bed3mr9686017oib.114.1702680522471; 
 Fri, 15 Dec 2023 14:48:42 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 h28-20020a05620a10bc00b0077f95644dc3sm2266004qkk.57.2023.12.15.14.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 14:48:41 -0800 (PST)
Date: Fri, 15 Dec 2023 17:48:40 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, Apurva Nandan <a-nandan@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] board: ti: k3: Remove need for CFG_SYS_SDRAM_BASE
Message-ID: <20231215224840.GL2513409@bill-the-cat>
References: <20231130144911.254889-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vncPZuXnYWkuC9XZ"
Content-Disposition: inline
In-Reply-To: <20231130144911.254889-1-afd@ti.com>
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


--vncPZuXnYWkuC9XZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 08:49:11AM -0600, Andrew Davis wrote:

> The base address of extended DDR does not change across the K3 family.
> Setting this per SoC is not needed. Remove this definition to help
> remove the last bits from K3 include/configs/*.h files.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--vncPZuXnYWkuC9XZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV818cACgkQFHw5/5Y0
tyxjngv/XsISfZrWZSidObPzjZsYThvpUDMjCvF60+YkUBj8ktPXZGKSwZL/7lFH
OFQP2QSVm+q9nFvcwv44V/e6qkDQHn5LGWy/64duob69EMV1ybPnrseTTYePEAtK
+9Y4z9pgSzbG8BXEqsaznAshP3juuTLocm5bF983wjYW6cNzgb1v0BL9DNYC6iPc
wpGF+lYAq10sfRq2GfWdMp2mcfADhrg77DWEKXE/ZIFjUoFjfuw171pn3L+71k+c
1Lf6a+rnIaFdODBUns4fZS/ng1D7/HiLEEC58+hKJDX2A/QvDfmgbqtEh/AMl/yG
aCXJ9XwsAQZ/q/qxuPM3WM3TIk8Ry9QWeFo1SzHD8G7UiGWmLfeTiDE/0mcxEg+M
Aux5gT6jDCDKyj1Ul5qpZW6ZdcjIzvo46NM8VS7niS/83PrSK7zFr6dBg/715F2p
44aiZShnqkqDD4UMxwaT5LRMa//lTo3xXxpWMGMNM3yIvlDOcF7XrlbhoO6Rok5F
odHV6FuT
=CoJV
-----END PGP SIGNATURE-----

--vncPZuXnYWkuC9XZ--
