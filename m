Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20969C3ABC6
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 19:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFAD0828A2;
	Thu,  8 May 2025 21:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CQsEHjNi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29FA982905; Thu,  8 May 2025 21:34:12 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 167F882162
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 21:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-73044329768so1029479a34.3
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746732849; x=1747337649; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HMZvOu5/B5BJN9neyrZnpZbEjwZph1STuP1/YwM6i+o=;
 b=CQsEHjNidMymkWIl3ZJIIMJesXsUevNyLC1kuBN1twx1Q1pRyVoFJZel8fZ+UIBa4v
 fsu2sLDsTq3F1r6PFpcXlXrKWwy3ZKy2kD4cWIf3q3j0w2HQOkkPPCyuYR2kQUI7nfsu
 Bd6agfcA3GtcXQIwFRfIiI5CHAT+WyGsm3aQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746732849; x=1747337649;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMZvOu5/B5BJN9neyrZnpZbEjwZph1STuP1/YwM6i+o=;
 b=PhR8/I0Kk5khmADjPFS2aDS9cpnnLW27Qpi9LB+0s8n/SvT97MBzWvrD67TPphDNTh
 DkIThLwdVQxYCD94JtzpzkRoP6F4371yKv8HDH016EoF8v/uMw+EB6Y2idiU9Ie31lKl
 m1DFCo0VnMh8APUSy1PxEsbHUXWaYv9T+swarUjwiVINeSMXqHE2dxITq+kWYyecHR1n
 6O+xjzweQPlOZDEWk8oEcIwAU+4Vj66LfFe7HMQgxY7xhnJ7azAf4Q4xbirObYc7Vxre
 rfKgk+kooZc+f6wio8rnu673ZWjAeJ5GyTK8k/r0QqjV5568kc72uetzjpJ2rIOGu39i
 Pd1Q==
X-Gm-Message-State: AOJu0Yx/BOyEYyChqsLiGGvYu6u0g9/cQ2KqouOa+Z+0S4lDb6NFv0d9
 BDLR7xUlUpJItMjGnxT3r5jXq+I+eWsRoXVDtmOvIIB+0rgZkGPGiwEGFqM7SXs=
X-Gm-Gg: ASbGncuF34WsQKtlh/d2Am7bWACeEOc+FGJTn8kvn8LFuSCVkR9zno0/+eivdWz8zQn
 429W7CG0adDPVd+AXonZZEjOSs41/Ui4kSAza2uDCzqLoQ2Pgc2hxcpHGWNFubQ7RG1dpo0dP6m
 u7KZ6pe8VT8sHl1z5iTTId/qOpi3qgrYz7kUIWcSc9sMEJ7gRAsJc5yYYLa13pivNPgYRqBWCnL
 jpilFt/nRW7waMzrehcS0dGMv8V0qan6FW8XaE0Gh5ROt5/3m8goOl3KNDJxKKp9ieCJW6k+pkt
 E9NhhX0bYDdXSvv2wzmj3Gajn00N9+FPG3aGckMwj/X+pWXA1F246TMcuB1PxIjrOqMrvhPEoyY
 7YA==
X-Google-Smtp-Source: AGHT+IEJz5LSlHuRjnJKvVzEA0jGlMOOm6hsXOaY9GF8G1teCjv4pnrVIe7OdIQM30NDdXRurRMChA==
X-Received: by 2002:a05:6830:3788:b0:72c:10db:f210 with SMTP id
 46e09a7af769-732269faf05mr837702a34.13.1746732848820; 
 Thu, 08 May 2025 12:34:08 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732264b2e5asm205552a34.19.2025.05.08.12.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 12:34:08 -0700 (PDT)
Date: Thu, 8 May 2025 13:34:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Johannes Krottmayer <johannes@krotti42.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] arm: cpu: armv7m: add ENTRY/ENDPROC macros
Message-ID: <20250508193406.GF603748@bill-the-cat>
References: <20250507060739.326096-1-johannes@krotti42.com>
 <20250507060739.326096-2-johannes@krotti42.com>
 <20250507165533.GO5430@bill-the-cat>
 <6d3af68a-15a7-4dd4-8095-ee2ac6037c0e@krotti42.com>
 <a138ecb5-680e-4272-8211-dbb354745247@krotti42.com>
 <20250507225123.GR5430@bill-the-cat>
 <20250508185943.628503-1-johannes@krotti42.com>
 <a88cd4e4-c558-4fc3-86a5-e25e581d7b5d@krotti42.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="csgFQjv2a634vUGX"
Content-Disposition: inline
In-Reply-To: <a88cd4e4-c558-4fc3-86a5-e25e581d7b5d@krotti42.com>
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


--csgFQjv2a634vUGX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2025 at 07:09:33PM +0000, Johannes Krottmayer wrote:

> Hi Tom!
>=20
> I have tested the patch on real hardware and it works. But have
> must add an additional board which is currently not in the U-Boot
> tree from STMicroelectronis. Maybe I will release a patch series
> too.

OK, thanks!

--=20
Tom

--csgFQjv2a634vUGX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgdBy4ACgkQFHw5/5Y0
tyyY0wv/WgIr6H1hPo1+2BSa59tePL7R8/fkdrVp1/7neH1saKrxADvRdPoYI9vH
Q/gbrGkLh2qSiwGelAKpJlq0YiZarKP37L2W/LuyMUNXNqOcobouFiBN/5n9T9cl
eDWmO/I08QugxO/FdD7ukVex+AfVmzQjgT8Fq7xHwQzH2y7bUNY3Tnj6xzhNkbgz
SF8ElFpANkZGd6R+9gql3St8c2ueZpQCMIo7OdTm5js3fS+UEaVn16y1sSTnhd/y
5l99ce63cjqJG9r2bfNwsCD50HvV/kU/a8ekXjFeyfWIUqv3OK2Gs7KBE6dElwCv
XC/kMPBaYmFK/D6Kt/84IXRgzmqFRQonLsrE23xijJctrunxAnh6hAG+DJRfSLep
UI79NfoBGqZu26smLG/9g219s+Mm5Pq3s24uVPy2VCghZcrORTIPPK/Y9/Vp6GH0
gr3QfXDmgPXC8q3eN10eJ1ayVd6ZxD9HUvd5PmiwCxKoxTYiMQyqyWqjB5QkxH9a
B1HpGPmZ
=BJde
-----END PGP SIGNATURE-----

--csgFQjv2a634vUGX--
