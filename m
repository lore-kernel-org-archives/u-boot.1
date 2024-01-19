Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F80C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A5F387D54;
	Fri, 19 Jan 2024 17:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IybaN9V2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D27387D4C; Fri, 19 Jan 2024 17:09:32 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EEE487CF4
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5f254d1a6daso10145937b3.2
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680568; x=1706285368; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mcIJ6Br888RFukRsP9lBIh6weIRkqoak3cDf3rxLes0=;
 b=IybaN9V2v+gW/38kRYxJxpzRTzh1Ywll12SaaEF4eOv323Jhh9zmhCdfZp5LIN4pvE
 pE+ZtepuPeJRJmUcVK06SK8JnmajSOJeWJpX4o4syK3pxwTYKXCmLsOxH38qLqYwyecp
 EO6v6AdBe3tgNYnW+gpApqBhlHFDO9cueEdYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680568; x=1706285368;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mcIJ6Br888RFukRsP9lBIh6weIRkqoak3cDf3rxLes0=;
 b=jGIZEM9v9X8HePXVdXMrLQRbFr4E+W6+4uQD9nkF/jv+kAGhBEwar/TK8T5HJfotFk
 5FNbaHbjf+TooESA2g21FzUrGXXha3kwl4W0pAUcaViq28jVunQcZ6r0Smx6rPDl5qzU
 1EGtRZWrRiX7XlMxAQHJVXxZJCNsDrk8zBqd58gYeBCfqZpbRpYkOiIqpiuPtt7G9+F4
 W+lR0D6nkWcFDk/Jnb6CxbCRBP9dE2Yk4zmo62ot4nJFdbJz/uOknMoFILCqwmmF4HP5
 ZFzsYJDTwDlziEyAF2q0GHp/uhwyvG34jsfxXjzAZucAjYZIGODqwr7kFT8tLXfTpL58
 7ORA==
X-Gm-Message-State: AOJu0YxMISQmh1w7/XYeWB9dPh3T5v9qnIn6wyQAKjRzYSKdQhe2TsCZ
 h6s36iY6hOQ1gunRFmnFpPceNap4B5kuQbMhmX6pAWA4nM0Vbk4zBjibzhIH5Yp5cIhKH3iBFW9
 O
X-Google-Smtp-Source: AGHT+IGMigBKYzHnEKcP4gxHKC0UoqCFfqpmLZLjejVMExyfUarDHPzNUykI2YdtznTLK0d09levbg==
X-Received: by 2002:a81:ab4d:0:b0:5f9:60e7:a598 with SMTP id
 d13-20020a81ab4d000000b005f960e7a598mr79019ywk.100.1705680567493; 
 Fri, 19 Jan 2024 08:09:27 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 fq17-20020a05690c351100b005e25dc30d2fsm7516505ywb.45.2024.01.19.08.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:09:27 -0800 (PST)
Date: Fri, 19 Jan 2024 11:09:25 -0500
From: Tom Rini <trini@konsulko.com>
To: Tobias Deiminger <tdmg@linutronix.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>
Subject: Re: [PATCH 1/1] test: Skip cleanup test if not built out of tree
Message-ID: <20240119160925.GA12635@bill-the-cat>
References: <20240108211100.112730-1-tdmg@linutronix.de>
 <20240108211100.112730-2-tdmg@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CYIwIFC18G95/sGh"
Content-Disposition: inline
In-Reply-To: <20240108211100.112730-2-tdmg@linutronix.de>
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


--CYIwIFC18G95/sGh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 10:11:00PM +0100, Tobias Deiminger wrote:

> 42c0e5bb054d ("test: Find leftovers after clean/mrproper") assumes out
> of tree builds. test_clean and test_mrproper fail if the assumption
> isn't met.
>=20
> However there are valid scenarios where tests run with in source builds
> (i.e., test.py --build-dir=3D.).
>=20
> Automatically skip cleanup tests in such scenarios to prevent false
> positives.
>=20
> Signed-off-by: Tobias Deiminger <tdmg@linutronix.de>
> Reviewed-by: Harald Seiler <u-boot@rahix.de>

Applied to u-boot/master, thanks!

--=20
Tom

--CYIwIFC18G95/sGh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnrUACgkQFHw5/5Y0
tywQzwv/VBx3DH1e6EJ0CNvO8wYnKiCSNDT140o4Mefjs3h5YEkZc8SgltHcjuyw
yvRDpV2nlfe8WyAsEf76OjnBq1ku/t0zgJ/P0xbpKVCQKE+/wysEb0wmkHSvfbC5
1hKe0ZhBDXnQF/12JQmk7iNrem4yzyOowrSYblPft//hEvNa5V7ZunYrbt5+YUZD
h04ImI5m2+Vf0dziN8N4cCV+Dgeb8ATiIo3bqhQFCb7nJADORaTJ+MFqQoCQYoQr
xCjApcVj9ExXnOLIlJnnnyqaRUrM2ul9SiPiAagEui9Q1Jd+FnSCcNp1VSSZKRrF
0cgM39VYG7f+alAg7jT/TC14HjPNYba6e3FuS1rsdVcT6aY9Nd4co2zuHSMV2gyE
zVkfCP1jhOEAt3yLEoinIRz48bzMXq55scdJLxyTpkewBGjDFWk0x/gqK5RCoqTh
DAh1eRdT3cGEfoYfX2LL42bM9ecYwjfFmxDU1mtAy6f+UXIeBjOZ8gW0Rf0yA9sy
CGQoKi33
=xNDZ
-----END PGP SIGNATURE-----

--CYIwIFC18G95/sGh--
