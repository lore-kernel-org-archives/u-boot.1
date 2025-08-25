Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEEECA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 19:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD7F830A0;
	Mon, 25 Aug 2025 21:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MFUm1iVE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E72782DA1; Mon, 25 Aug 2025 21:08:09 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7050B830A0
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 21:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-314c3dc92f4so2018374fac.1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 12:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756148883; x=1756753683; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H+8X9tt18VAeKkE7pPGvB3V4TrX3h8aeVp2THSfao8o=;
 b=MFUm1iVEqPwZCiYEcDG/PiZSwmF39M3Gw7mf/DZcGApHBRhexBGNmiYZjeyJBj3wfq
 GYA54tXyjSJ1Yr31CFIZTV53MxdqSo9snwB7EXMal7TVnDt31R/+FmitgYwewlhjDter
 o4ehiYaKpTWfIszTCQ5y9qR+UTs6wNiMpasvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756148883; x=1756753683;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H+8X9tt18VAeKkE7pPGvB3V4TrX3h8aeVp2THSfao8o=;
 b=C4F4iDkQbuhWeP0dl5FtrUsxgpzHKGaVmbiNOUr5ezyxDXlhjZySaWEgDq+xC34bXu
 +OwRhRUyQwKujzA4igfLAD/iLF8NXcNcllfP3gIInu5wqj8w4WUx+kx0ObMl7mwdTiXK
 vEGANoVflQ5uckT/HXVRS9gog3HnYs/LRSjfteWb4hLzMh/agtXQ3/I70Vh1Yt+HWx3O
 4K6gcdqA06XR/8v1+HO5rC/M7RlXC2A4a+uCHZasG4yi7X/spXYO0xeIKO0tYyn1DQHX
 zthXNIEp2NY97xMsg0xMxS/FiLmSjz54IQJkb/z+u5EHwFOyhXCtUGECF3Q7y/u3Ty2i
 O5ig==
X-Gm-Message-State: AOJu0Ywp83aXrYvfxn5pALJasliHODHD3Es2WOsZcnhrGpU0SauLaf/V
 GJLn5DC4dFOULRm2XVorWHt308Jc5Wj719z20Ry7TQzu22WtdNmFc/DxzDjbLDAd6qhMLKAzUv/
 LS/Gq3vY=
X-Gm-Gg: ASbGnct6w/ZEvdScw0Wa1EYSMLMz/LyTz1mcQ/Feu4ZkcKTXsBlm0D5Ut4pS/iKiWr2
 oehrQ0iwCvtm5RPRuH2U3p94kuqZfA4ePmIW5LW+DJW9+Moxcb2erbj9uSu8gbh6+LVmw+ATLtE
 cuRrv1yvaxavDoxSbHxaDs2wjD1hLaqyWqNE0SiMgJRA7eAzkLlaRvTChohDMCzrlFVMVD65gO/
 jcZMXdbwSwj/jVB8dSbwkchumbvfetfaDi8UWVoVV5CVIWzqWif7HSKQ7xt9PRiJSCEIka8YvrG
 Ld2yUomKtWobbEgkxCkpmsiash4haCkeVHN2Hr5ox6OXUbqXQiIb5PwpKHCb8FgMZklcQ2uFbnl
 AMcJeAvr8y2Vl2y0g4ziGOJ6RTCXh99ejwbhfZ4MjzyJwwirzrv6nY+40
X-Google-Smtp-Source: AGHT+IFDRmdvJa5HxHGxquvzWxuh2AqFH+DRfdjgmBrfODtvn72e/M8nqN/rXrMKqDGKkabO0K7ZJw==
X-Received: by 2002:a05:6870:b402:b0:314:f331:1fab with SMTP id
 586e51a60fabf-315434ca36dmr341209fac.0.1756148882862; 
 Mon, 25 Aug 2025 12:08:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-314f79c54ebsm2016397fac.3.2025.08.25.12.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 12:08:01 -0700 (PDT)
Date: Mon, 25 Aug 2025 13:07:59 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.10-rc3 released
Message-ID: <20250825190759.GV124814@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EsHKrtmp3m2Z2h/N"
Content-Disposition: inline
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


--EsHKrtmp3m2Z2h/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and I have tagged and pushed things out and will merge
this to next and push once CI completes. I've tried to pick up
everything I see that's a regression fix and not something I would
expect another custodian to pickup but if there's anything critical
people see, please reach out.

We're continuing with a community meeting following the release
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/btj-wgcg-euw
August 26th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

In terms of a rough changelog:
- Enhancements, improvements and new platforms on ARM for sunxi, qcom,
  renesas, iMX and xilinx. Then on RISC-V for xilinx, microchip and
  andes platforms.
- A number of networking fixes (both stack and PHYs, drivers, etc).
- RAUC support fixes.
- nand dump fixes, and a benchmarking subcommand.

I continue to plan to do an rc release every two weeks and the final
release will be 06 October 2025.

Thanks all!

--=20
Tom

--EsHKrtmp3m2Z2h/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKy0jwAKCRAr4qD1Cr/k
CpimAP4+Vxd6bPs2wvy/gur+ysIh8F1BWk+2ZyEseTkpHJJ/IQEAyvBFNTIBvzWq
32x3kN9jOq1CIl6Gp6xQ8aB1Kr4sNwg=
=3clx
-----END PGP SIGNATURE-----

--EsHKrtmp3m2Z2h/N--
