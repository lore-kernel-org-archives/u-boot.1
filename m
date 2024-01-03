Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F891C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 19:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B4C87645;
	Wed,  3 Jan 2024 20:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vtaj2s1n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAD6F876FF; Wed,  3 Jan 2024 20:27:17 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 870DD87509
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 20:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-427a3887483so81151171cf.3
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 11:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704310032; x=1704914832; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YhroeqHT5cXKMpYRYzpi+Xh3q2aUt0nqqAeQbtMWrA8=;
 b=Vtaj2s1nZUIcLdI28aKNjNKQcSlJq68W/ytawNfs5zagU7X1ai8Ruwt4D8hF7c5Cz6
 YbGuRnJ83fnqZdLtAFY4ZJMIgtKFauoQthVC6fTPB9LOzZADu9rld8mlKhDRmeSs3cvZ
 vxWZK5vabQLs1CgxGfpD/0r1hmsLjg9VQV6mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704310032; x=1704914832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YhroeqHT5cXKMpYRYzpi+Xh3q2aUt0nqqAeQbtMWrA8=;
 b=Ulb0gHD/PJlPSE6/k0prVzFRctDcrAnnb9NZ8zDQXhXpl5iDZWFN+CG9Wr/WQaHo0/
 e2fh17e2Im4NFK/oVcaFpJZHjoM0bNxk/9sJMEraMLgQf7ihScK9ArKh48Fw1jo2Qv+o
 aO8umKAa9D76fbOrubwUbcPCkHxj88TCyyA44YFmLdExVJ3ZfXEpDfrQ4ykLILyEwNLZ
 q6M5XsLPv4zzjS1Ka5iiyXAHPf1nUT1BgX3tCJf/OqjqqkieOkr7pLMVPnav5sDS+eXq
 uXMAdzmmFxxXiSas2gN9PDTYRT3B+uikYre78NEo+Z6CWzepyciZoUN9ZRNhlZxuIP2i
 NC4Q==
X-Gm-Message-State: AOJu0YxQZ6zlDfvLz8zV2lz27Z4skYH31Kj5AWQ2ea0hMV6B+cMqEUJk
 FOY7CrsL0N1R5TUoT5QBoQw9NMPeOGhu0A==
X-Google-Smtp-Source: AGHT+IESVXwC3OoRMClG/pJA9stEsK7fCYvEkBH1BpWTxw9MAiCrig7O5pzCGUHvqgVl8AJoupb9UQ==
X-Received: by 2002:a05:622a:1c17:b0:428:f37:f1b8 with SMTP id
 bq23-20020a05622a1c1700b004280f37f1b8mr8490175qtb.113.1704310032497; 
 Wed, 03 Jan 2024 11:27:12 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 ge7-20020a05622a5c8700b0042836231a8asm1206539qtb.45.2024.01.03.11.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 11:27:12 -0800 (PST)
Date: Wed, 3 Jan 2024 14:27:10 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v3] test/py: mii: Add tests for mii command
Message-ID: <20240103192710.GO1610741@bill-the-cat>
References: <a6b464aff98b7ddcfa076c2155a1be51beec8583.1704177781.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TJF0F7kDz+KcNWfB"
Content-Disposition: inline
In-Reply-To: <a6b464aff98b7ddcfa076c2155a1be51beec8583.1704177781.git.love.kumar@amd.com>
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


--TJF0F7kDz+KcNWfB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 12:14:35PM +0530, Love Kumar wrote:

> Add below test cases for mii commands:
> mii_info -To display MII PHY info
> mii_list - To list MII devices
> mii_set_device - To set MII device
> mii_read - To reads register from MII PHY address
> mii_dump - To display data from MII PHY address
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--TJF0F7kDz+KcNWfB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWVtQcACgkQFHw5/5Y0
tyw+fgv/QX/+5X2zc4/JnrmJmASAYZhM9pW8YBdclbAUdvB5Js4qnUrQwO1/ZcOQ
/2E0HWfxYmL5uJ5EyqM67/rKgjh2BhEyl1DiP7ppCVFSPiqNQwYIp55I2G770KMu
MMIFsFogWkVeNnLHUSf3prJPk9C4iWx+Jom5DKguaN7uafKnpmlJ6iERphg1Kl50
fORY6ruSSLGX5KabQpQgnsPVoI9kW1lI4SSxEeYcH5kb0GYIZsdk7Didq6XBe5oD
A9hVnaqiPyuMyvG+yIfmlhObMr6OuKaZD6qpNJHjcCny7NqpSXXjWk7XSoyT1MGm
LwWYKoVyccoG8qxWpS+A+uoCaMhIAF372UaKw+6jBj9BerbF1+JN0wwSZ1hCF2D6
r4ttobRuD7cBij22D58cAAmJMgaEMlm1s6I1oh2hZ1YX/qymaSox6c6wx4wk3btu
4fHL3lcMrukO/dlVlW9i4JIKCQrF32vf69hd77qH6NBdAFdnRotYRQE6ouFwWQYc
HedwaAsK
=sLNX
-----END PGP SIGNATURE-----

--TJF0F7kDz+KcNWfB--
