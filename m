Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3E4C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 23:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F044F8059D;
	Fri,  2 May 2025 01:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iztSQSRI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 214AE8070C; Fri,  2 May 2025 01:05:37 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 013D7801BE
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 01:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3f94b7bd964so1202400b6e.1
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 16:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746140734; x=1746745534; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D4xxh8XLrQrRJrMOIqAOghyFe9IntNrDy0fGssNazAk=;
 b=iztSQSRIjtrS4u5/SLhv45RbOrEaLRbE72t3Y3/3IdA08dr8C1L2qsev+XiYSuVWGo
 dkP8HHFDfcdMgAmXR/sCqkacP4Us+rgm1KGfEMcB/azkrdlZv97X78MjTbZXXzGUEDwI
 H+RU3uEdqUvmfK+TW2OKxir+aBHXhLbSxWaCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746140734; x=1746745534;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D4xxh8XLrQrRJrMOIqAOghyFe9IntNrDy0fGssNazAk=;
 b=qTu3u8+ntNKGqcpY6pDXb7726twMJYZHG9tpQMwaMAcYEs3ltjrRDh1PayWkHAdDnU
 VSoA57tGgtjanCAGLlqyvit1yCtqBwqbPtZROwVmDva+v6nZNDTK9LJopacUwJMkuI9o
 gsLZ/g73/EHufT2AE3L5MlNrMYmtoDZrAHguVwlBOBUG+EiOPo7gKqzd89G31W/kUDOT
 wluHEfeGiln9RWMg9larfMQ+ElHCt2khAuOY8D0bU8Ipg8fH8XAPydkSrhKDBhZewme9
 IKl9ZJCUp4xiqxcWgAhWNjSBx+pB2zJHXaRSc4WgudLhAyfOP/c2515HRp1OEVFhWygI
 Wtdg==
X-Gm-Message-State: AOJu0YxGORbD4yOtgg+I7WQhBIrsvW86sCl+Wq8S6QFh9igpaZ+l1gKI
 pc0EIuezRKz2xaf0veGYhopJK3GooMT9CDE0aXpUL2JazQsTF0eF/u3JMOFllEs=
X-Gm-Gg: ASbGncvosMz6mjAFXmJIlgpuutGheiIs1E5RyefGQjSLPrhr0F64EWAY/BxomRaEtgL
 U+q+eUIYpY5f7i0FTBoF55byrjKkvWcq3QAALZCnSKY6BiG/uUbuvqZZog1X6Ig67cDBjghFp02
 AsZCQKJk9clgK4ydgs0Q2KMHWMoYguoHUdOzv3CTuozzXUqmJA+c47ZqpeAMp0+ndA1awhjCwDb
 tX3TvsO+rBofxCcO4vzzVEvrDEKS0CUSxirWdNEAD/C7FQTKji6SbKsavHkCb44CBGQJMOVfsQp
 HKVzz+K2xK8Btn3DVYZtsPcVMJApojeG73sTBsBJUvprIFkvWRDy1gUZlMToOEebvd6t9y32eDU
 nrQ==
X-Google-Smtp-Source: AGHT+IGOIc145ve2BYs3Nb3XkHnESXGMtktgmMex3TDXcZYUHuwusxmPQSkotonlLLcKxPWsFmsjIA==
X-Received: by 2002:a05:6808:6c88:b0:401:e721:8b48 with SMTP id
 5614622812f47-4034116320emr757419b6e.8.1746140733696; 
 Thu, 01 May 2025 16:05:33 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7cab6f0sm315255eaf.5.2025.05.01.16.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 16:05:32 -0700 (PDT)
Date: Thu, 1 May 2025 17:05:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Walter Schweizer <swwa@users.sourceforge.net>
Cc: u-boot@lists.denx.de, Tony Dinh <mibodhi@gmail.com>
Subject: Convert DS109 in U-Boot to DM_SERIAL
Message-ID: <20250501230530.GN1261075@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lcnzWLa8Sh5vYBn1"
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


--lcnzWLa8Sh5vYBn1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

Do you have time to look in to converting the ds109 platform in U-Boot
to using DM_SERIAL? The code for triggering a reset via special serial
commands is the harder part of the conversion (and I don't think it's
likely that hard). Thanks!

--=20
Tom

--lcnzWLa8Sh5vYBn1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgT/joACgkQFHw5/5Y0
tyyBJwwAmYY9dMWScT6L/FrORhqP+fIHf7umkmevSdOiTx7j5o8e3YESVywRbEb9
Fe8/Rg6cwGigg5CGsLatBol6VjFolzu6QP3rPNXfsUUfVK48rj32RLaYSE1lnF6u
fZFN46kmNvVdK5ZOJMEm5j17gdaeqpOOON3OR68+F8NNG6bCaLZrQ6gL4/NykXVa
zVuABgbtrAwEsHOo2ngvyDiCv5EppcphU4dU1L/nPHD64iYYpuxylXuqSMGiMCz+
2YMlGI7r95eGpmEQ1BO1Li76vOsxlxlHByzYtihyo+PVClWrWGEcAXi6u04SRtGC
5lKrb/9Xdzhdljm1j/k1L0UR8XTAXDMTipx/rZZ1K9iNGRRhbo7RYwuKIdY9+aXp
sqMu4seSfqq2g9nmAF/TLCQ0oT4MmHb2ogpy4JK2IGTxHhL7qD+tSE3IdP5Fg/su
G3rUCcCFyqfrKH7FMJZZ6kloEaqBGKYtg7iNoWDboPE6IeDz5G1g65kgzKSRHWx5
SGKn0z2I
=ZLMW
-----END PGP SIGNATURE-----

--lcnzWLa8Sh5vYBn1--
