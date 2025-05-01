Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739EFC3ABA9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 23:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7348C8070C;
	Fri,  2 May 2025 01:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q0n7lP40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA03880F03; Fri,  2 May 2025 01:03:55 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 875D38059D
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 01:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2c769da02b0so1190822fac.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 16:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746140632; x=1746745432; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pj8FWuU5nCs0sov8prWLq+GUSDGXQevou+4cBmn3adg=;
 b=q0n7lP406NQPUsD9VZAu/qLZ2Ymu38K5wZfMB+od+l9D4O79hzqNbShe2UeDrrpLvZ
 LVAau7xQ+5WNcanrOu/J0FcMW9XRq2SSEkyXCSHr2e+CzTdLAFwTSVtU0BsatrO/zOhJ
 JBKBiht5/hYteDiBkMRzjrDiCN5gyD1CPwXBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746140632; x=1746745432;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pj8FWuU5nCs0sov8prWLq+GUSDGXQevou+4cBmn3adg=;
 b=uvBcU/IzE4DeffR8ypnqL32GYg/HGbqJT+/HKSHJTrragCnF0wNR0SjVmmeompOLKx
 v/YxuiB9tzqjmKQwaBNstvsfSe+Zs+SGJWBjDyXZwE6/gcrKYgeD3r9ehNuAuvdH3xIh
 ahHcSiRn2+eFNhN1dWMLlsv8+qJ3ATkUDL7P6JgQwjip9o95Le12jvmLFFlNa/KMCOks
 joJWE+f54Zv4lcXN/44I+16j9DM2FbTbA3txwfvT0M7YXcufgWfgcQZw1xsNqCpwEyB6
 Go9idWqKkIWQ8Eh1pGvpENgDCBg1BxLVy+WeSesMUW3lVtc4RILTWWecAcC0ot56MiTT
 YUaA==
X-Gm-Message-State: AOJu0YyYer3XiZ9w4sTXpl0zTRwBignRbnjx/CJeYXmFPrx3ePyQ+RBQ
 b07c3OnucdAR69GKqGu34OSvDVqhaQ5G2kh/EId91C+8AtcjgBGFxkDa/D1Ksug=
X-Gm-Gg: ASbGnctnlKgchwqI6Cc/JJEVITLtaOJgwi+m6Twk27dSKQ3KC32Xtzpj9PAYCF1Hgoc
 wKkdtSQf2ColNnonkVynlujZrf7PIEUJM1WzHzwKHOa6HyhBj/XR1aoNDN3Awsh8eJj22s1r2Tb
 7FcfX0JciUEUBy6H//Pv51GXGHLCRUqlAiHIZcyWm6+3bPrtNaUB8PbN7MIjhedmhoSFA14zWNB
 q2Gr5vowTf06WbttDZILLNPfJ/grBS72L4JcTxL9/NJjWoiIOQLvqlHkYNlOpNcc/VltiM3SocJ
 UJzPatjf5TT284kpSprJGj7n62o0RZuxBZ2C6gYu6HrSlBc/VahyYKX8MUstCi0dqnLdpF7D9RD
 12g==
X-Google-Smtp-Source: AGHT+IHHwIQRqlJzk7IlAnAuQTAX3YsbdFD44dV/55wwGLSLohqukWVafefloXPWZohlvfGjkMMCgA==
X-Received: by 2002:a05:6870:891c:b0:2d6:7266:a8d8 with SMTP id
 586e51a60fabf-2dab2f9ac2bmr321308fac.3.1746140632186; 
 Thu, 01 May 2025 16:03:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0e5094fsm354792fac.4.2025.05.01.16.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 16:03:51 -0700 (PDT)
Date: Thu, 1 May 2025 17:03:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Max Filippov <jcmvbkbc@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de
Subject: Convert xtfpga U-Boot platform to DM_SERIAL
Message-ID: <20250501230349.GM1261075@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jdfzjFOZdauUqtpC"
Content-Disposition: inline
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


--jdfzjFOZdauUqtpC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

Does anyone have time and knowledge to convert the xtfpga platform to
using DM_SERIAL in U-Boot? It wasn't just a trivial enable
CONFIG_DM_SERIAL and have success so I didn't look harder than that yet.
Thanks!

--=20
Tom

--jdfzjFOZdauUqtpC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgT/c0ACgkQFHw5/5Y0
tyzREgwAgxQa7oFGWOq3AWgapSWojM83SJ9R3tQsQ8E7z4VYEbz5HqMWrHN+IAuE
3IqZo3SE1OGoBxposAzm1+cchAUz8y3kN1vRFjJRhX+xoaq8pwFCdjHZjiHsmNGz
jc0XhekCQLpE+aGp9+0Q9+5Gnro6J2rzlAhiwdBiEN/LgB0KVrVasKo2flhv7XJH
nL9PphQhGj80L8KDH+ed+CLKc178On9YYXJPIOeD6PtnETvaWCLAYvgtEFqQrkDS
vP+JEJOdgYspyeAKu1jeCaNysBjIykcIN0P2rh4EgxW66U61DfXcy6OS2Fx3JaC7
fmaywcTjjMYed+YuPgBUe1k6asZdHzn+7PD2sC82YiJwJQDgG2BgDjs1JLiVDPIr
gH98qx7rnDwNmmEsHXOXX9A6xorSrMXffbLm5Lr3iedoralAeW+y0UhO2lzMHLf0
TjGLujP3WtZOGAJ+GDOrl1z5p+oP3P/lvlc0Hk+XgTFa3Jh+mA9EsSiTEVapCiSK
C6/sV3lO
=cjTm
-----END PGP SIGNATURE-----

--jdfzjFOZdauUqtpC--
