Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079E9C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 15:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A21E876A6;
	Sat,  9 Dec 2023 16:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EfhEOu+A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59C268764D; Sat,  9 Dec 2023 16:49:10 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C50C876A6
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 16:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6d9e993d94dso1174251a34.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 07:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702136947; x=1702741747; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KaTMtzMlyNUUfrcjSOR5G105egzSFlicv3qlu2xdMmA=;
 b=EfhEOu+AEs6DEEOl80n08MBslgMivZ1SsezCm89Bs5s1QsWSTWQRP/cAWFuXoKO0qn
 dFqiTm6cDcdRcq9dqGuD5SJMJsveuubCZGSf1zQOFJagooxCoqaqm5KvgRLDAy/CLeXh
 K1ZwOi5IepM/qKjf5RFPyHNHsS/7jN+7EZUfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702136947; x=1702741747;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KaTMtzMlyNUUfrcjSOR5G105egzSFlicv3qlu2xdMmA=;
 b=Tf6WLCAwRDqQq00XN8yM/26axlsNrj/ZNa/9zjTQdUtC8MMW58thtrTFOXJepVNHkX
 XavWhjpOTUQF8XFTupmRm54SPFlvS5Mtjper3ysIyHb6oTpbjwqsHwjqJkS0jwjKdfvQ
 g4kohXzC+HIbUKk9d/ZwBOW0B+67CBouOL/GBSyyHDjxBTl5Tz3nuyMTNpl9X8q6rIlS
 4eay5n0rBRPgjKd0sxXM2qSdXDsWlq6mp99C6PlmdsXH+0miFGmZL9c79zVj+C1DazfR
 BSgPiVvZ0p36dMakMtYeZ07UrxLUmgjYsyNfLVxCKjfOe0Yf4KUi1i3KqI3AwaPCFmFe
 YOYg==
X-Gm-Message-State: AOJu0YwT1IcFil6jcNVvgNJK0T6RxtjVByyFK2SptJhW5Eums4XB+Xcu
 FPWHv/MuWJcYVh0uQJveNQH9xQ==
X-Google-Smtp-Source: AGHT+IE593Ru/q5nA8ySIDn1B3nAADf+2J8i9Bu4vyCpQUSQLQDBYHotgJByR5uugxB6w+MqTANvFw==
X-Received: by 2002:a05:6830:d7:b0:6d9:f26b:47c with SMTP id
 x23-20020a05683000d700b006d9f26b047cmr1658747oto.18.1702136946790; 
 Sat, 09 Dec 2023 07:49:06 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a816909000000b005dd004432a3sm1546737ywc.137.2023.12.09.07.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 07:49:06 -0800 (PST)
Date: Sat, 9 Dec 2023 10:49:04 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 11/13] x86: zboot: Separate logic functions from commands
Message-ID: <20231209154904.GK2513409@bill-the-cat>
References: <20231204002944.897949-1-sjg@chromium.org>
 <20231204002944.897949-11-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gvTPnbDA+uM4ivJ8"
Content-Disposition: inline
In-Reply-To: <20231204002944.897949-11-sjg@chromium.org>
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


--gvTPnbDA+uM4ivJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 05:29:36PM -0700, Simon Glass wrote:

> Move zboot_start() and zboot_info() in with the other logic functions.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--gvTPnbDA+uM4ivJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0jHAACgkQFHw5/5Y0
tyzJAAv9Evt7xPg6/7xN7aCE+uH9cUvcG5K2aoIxhBbSexFPhzWvzQWd4HLMq2Ix
eyqv3dH1kctmLCl/tQbpPRAA7xY+3bHX51BBzLuwOKfg7J72LZcmM5rVEc7vq/fd
yRCwJwbMNBmJqwLY6tIlXoyvZgqPfdyvBwZaHZBT6XV/GJNrcTe6PRi6P9l/YKM3
g+7mGVmOLCm+mP6EXdpaPsB2j6JNNN+k3pxcxZyRSlS7jw6mMbt6zsP73w4z1/9V
E1T6rfrmas9/JBUey+ju9SIeZsvZGWoiz+WCl/VU7qedVmbN/nP9GQZaAB18JyPI
qsdpLWiTBRyO4DgZDpiZCbmE3lLLi0cp+dHy9mxD5/OGI2fOlxX0hnniDe7CAhS5
WbaITBIe8nAf5H2+VH0An22nAw3RWUCY9VeEwY0em2LZXH3oyg8M1yrXbcF2uXnF
tCpAXpu6hbck7x+LI65o/EGLA5/ZhXulprK8YDYIxQSIUqMNstlA6NxyMD4rzNj9
huKoESsK
=xYFh
-----END PGP SIGNATURE-----

--gvTPnbDA+uM4ivJ8--
