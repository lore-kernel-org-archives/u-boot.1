Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6234C54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 14:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C67087F76;
	Tue, 19 Mar 2024 15:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ow33su74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A76B879E8; Tue, 19 Mar 2024 15:00:31 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 825DA8808A
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 15:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-609ed7ca444so51933227b3.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 07:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710856827; x=1711461627; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CDPhqWotjW9WGI2agB4o+N7owKCqWKrHPrtTK6PAx6Q=;
 b=Ow33su742h93hjzgU7lQNvS3/d6+WIq0dPp7Aw3VMYnsxqtsEaGw4YqzE6bfgQYV8G
 uMZSoqr9OOsAG11El9fFWODldPzH6xlYiFyTr7UX4eja4weokS2ZQySOzY2z8ugW0Jy3
 IVwf3IF/f3PRYcTskzp7jCDJn/BcA5HKPJhqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710856827; x=1711461627;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CDPhqWotjW9WGI2agB4o+N7owKCqWKrHPrtTK6PAx6Q=;
 b=BYYW1DWLKHJ4DP5ILyteJRm7mbrV5KCAp2h5NBEA6s8SwxY4JeJ6mh/0HnohPCx8hu
 lLgR3iJD3CyoVtNw1qI53iCYs3CVpGBdb2egBi69QsNEPADZrBEkCp1GF0htP90p0Sa+
 XrQiQ4QNZmd1pRVmnwx3vZpfTn4fHevXmGqwCYILLBI8Zbwe8cZrjn1Ao5hJbA1/dTO6
 9W2mzJQeP2xaOZwPzB3xQ8MRGRagWpZLUL0j5Wt4l8W4PHHZa5kVCg9AzEy1p/7qcziO
 4fkJcCWciERKHfYSQLGmN69n4M5DWkDe7CpKuH1LAiTaFiYhtbbk7rPpOP3+VF/+h3hM
 y2UA==
X-Gm-Message-State: AOJu0Yxk9M4YH9t0f4PRJnXFCFiNTsoL90JRddiJhhHN/L2cCXS/HyhK
 BdTfS3wVFrl4dBkh23PC3nciwvBgUcLtZGPgLLdT9f2N3lzZZJHwiBkpyCXt4BU=
X-Google-Smtp-Source: AGHT+IGK4viFDcabPDwaOEo7w+Hcjiu+wyWuYixe6cpRlGjN9XVSe6F6e1riIgfRW+Emcmph7VVwBw==
X-Received: by 2002:a81:dd03:0:b0:60c:be8c:78cb with SMTP id
 e3-20020a81dd03000000b0060cbe8c78cbmr14115311ywn.23.1710856827232; 
 Tue, 19 Mar 2024 07:00:27 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 gb13-20020a05690c408d00b006049315b542sm2315733ywb.136.2024.03.19.07.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 07:00:26 -0700 (PDT)
Date: Tue, 19 Mar 2024 10:00:24 -0400
From: Tom Rini <trini@konsulko.com>
To: Benjamin Schneider <bschnei@gmail.com>
Cc: u-boot@lists.denx.de, Benjamin Schneider <ben@bens.haus>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v3] arm: dts: armada-37xx: update devicetrees from linux
Message-ID: <20240319140024.GF3442575@bill-the-cat>
References: <20240318234448.16646-1-ben@bens.haus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZHd1QurCm5BWx+y1"
Content-Disposition: inline
In-Reply-To: <20240318234448.16646-1-ben@bens.haus>
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


--ZHd1QurCm5BWx+y1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 04:44:48PM -0700, Benjamin Schneider wrote:

> Update existing armada-37xx DTS files with those in linux
> and add devicetree for ESPRESSObin Ultra device.
>=20
> Signed-off-by: Benjamin Schneider <ben@bens.haus>

Please depend on:
https://patchwork.ozlabs.org/project/uboot/patch/20240318150318.8292-1-mare=
k.vasut+renesas@mailbox.org/
and rebase using OF_UPSTREAM (and a -u-boot.dtsi for now if needed
still).

--=20
Tom

--ZHd1QurCm5BWx+y1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX5mnEACgkQFHw5/5Y0
tyyZIQv+PYD3SwmnNqk//Fx07abj0God7qV0Y49t5Sd+JtJQDnTlaslr4IOUd2Rd
d4MfPpwFyOdFoCswW2NbIP0pJX8DwRE9UzCTNl6KDT5qBz6Cfmn01Y1hv53biXfH
lvYdC+a7mc74EfEHTdv42EHF1CAeByRwgiRW0ysWr6FCUHJ2UVXl1tj/K91CUfCR
yGvQzRdUNF5nIob5GIdV2dW+ktPVSnnk3InT7YpVbWUCdlnrqqd6pCEpV2OeBNmd
E7bImG68EZMmNSBWd240aI1mUUnBXTm4c+ZNiBtPoI0zqnxkLlEKcaS2DDiwqYHX
aDeOoR/JrQ1xdoGzwP4ieRhDK2mjoDmoBv0h6cMIPczh0DgxK4u9P37D0ceaPaV/
0169BwMk2oeLxDltul3VHfFqd8zH63YEvl/WXQhAosznioOx1kxYU9bnkviF+/gH
SZJu/yhD3U4QYVWI5w4FN91PzAARZr9k8OW8Agjjp6RzkOclNWhei33r7ksGpnCR
xm5uHrAw
=SzTo
-----END PGP SIGNATURE-----

--ZHd1QurCm5BWx+y1--
