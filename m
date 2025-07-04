Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97B6C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 20:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E8682A76;
	Fri,  4 Jul 2025 22:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MIS4kEcJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E13F82063; Fri,  4 Jul 2025 22:59:12 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0474482063
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 22:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-40d12821c1cso278343b6e.2
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751662749; x=1752267549; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8iwLsy/yVz50HlOcNmEDxzZdz/gHWH1Po9NBn/lyHE=;
 b=MIS4kEcJDaxJopAF5it8UNulA7jJ+LoRcLFoRtcSlBfjruNkh0ClZudmiA+aa5IWtD
 3DJxdIRrjRNlbAJwfxItlrxsH0wRli+AStMhJB3K0E3ol6ubj2NfdjQrybb07esrRsaC
 9xS5TU1wlVA/EoFy5Xk48ayqdApLZOFB1xtus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751662749; x=1752267549;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q8iwLsy/yVz50HlOcNmEDxzZdz/gHWH1Po9NBn/lyHE=;
 b=HdtTo2MLoFWUF6jdNoq7ofT2jY4uB9w2yfENmrb3xhPT/n2eaczu0+wKoOsOGQF4Y3
 ekmOAp2BLyC87Eig9zQyakmjKOs3DXMCLo+2z1vaiVK3dbu0c+A2tYCvObHmxPndTHxu
 El+w596GEW4YWBrnF7kSWMwZBQB4dQDAj4IRv0N0ObHoM/qty8VWTVyq6W1KwDdTIvoK
 Gnv55d3hvWlVgrx/hTZhPWiebO0m/TBE0jWGiq6w85ga3hjeipKpGtMZAfEFIYI1G+wH
 jLYrwraKQNQXlUZYUdReoykv76kpkGnmM5mleV4h9oLSeST58trvVb6qwzlIlQZXOyaU
 BIAg==
X-Gm-Message-State: AOJu0Yz+dc4Knn95q6LeE60M6tRR3UvBudsKoSlqRz8H7ZzM0TxqB+5E
 rfZm2OcDcSfXktr4UGtBOsY0mDzCSMwb9YxeYFmE5NbYBkNoBEQbQ9VDemZ/dOAVkZc=
X-Gm-Gg: ASbGncuRii6e+43nZlCbWjJopSCz8kitfzvS90cvkYvWt+emfU2U71XPCBsNYjnNHwd
 y4vbYAAg1RcmtVF1jgfvij6OkrL/hFpajCGU6pqSBCKQn8m1oK2drVZPq3i3NTfMlCs5dKLIdL4
 aTbmSstaVMg3tvOaljA6v18LjcbrQzqvd3V28jAFFrH4QSZsmXE8lfOecpAOQygTCJGWtib6ekA
 G6qKbUzwGqNlFDhTtu7UnB9avByDwyTdRh+sI66dLWM11NVY6YhFs1Vlc47yKFuIRRRdk1K8V/m
 evftj13aXbxoo4198PEEWMrfFdMZyPHH1TtHRu7ZRdp9Xic4Fv/t4gzCs7AAshcNXyyZxBcUkTG
 d2cjVRSAuj4NpJ6HQbYPx
X-Google-Smtp-Source: AGHT+IFPGrH06H//BmvhJEa7V1Hb5cLdqrRL4YCElD717vmXq9Cqp2bmvZ19S0lqym0PTI9Z0rUAMA==
X-Received: by 2002:a05:6808:16a4:b0:40a:b141:8f57 with SMTP id
 5614622812f47-40d0408094fmr2711145b6e.3.1751662748663; 
 Fri, 04 Jul 2025 13:59:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40d02a43f13sm427453b6e.11.2025.07.04.13.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 13:59:07 -0700 (PDT)
Date: Fri, 4 Jul 2025 14:59:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: PCI config read functions
Message-ID: <20250704205905.GL6424@bill-the-cat>
References: <3df65973-626b-4894-84bd-5a03a19032c2@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pnv+QfLutJ5VqLgJ"
Content-Disposition: inline
In-Reply-To: <3df65973-626b-4894-84bd-5a03a19032c2@linaro.org>
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


--pnv+QfLutJ5VqLgJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2025 at 10:53:55AM +0100, Andrew Goodbody wrote:
> Hi Tom,
>=20
> Smatch reports that the callers of the functions
> (dm_)pci_config_read(8|16|32) from drivers/pci/pci-uclass.c do not check =
the
> return value for an error before using the variable that should have been
> assigned with the value read. However in the error path that variable is =
not
> assigned to and so the code can use an uninitialised variable in that cas=
e.
> eg line 1396 in drivers/pci/pci-uclass.c addr may not have been assigned =
to
> in the error case.
>=20
> This also seems to be the case with callers from other files as well.
>=20
> Would a patch that adds a default assignment before returning an error to
> the affected functions be accepted?

Can you please check the size growth on say qemu_arm* and we can go from
there? Thanks.

--=20
Tom

--pnv+QfLutJ5VqLgJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhoQJkACgkQFHw5/5Y0
tyx2Twv+KlMV/qZja6CUGfdOMBySrk7FIP3agta8WlfgeaLxzcOH9r6NCnj/3aOT
cN9mkKTTivBzdO3JZ1/+T51EkiPbrtxMop1rdNip3c1g95en11Q8M8qwPj9PsmUR
E1UZiUKlSxWzMP3WWXchJaCOWJ9VYi8AXq1U4MV0eP+n4rPE/x4YsCUl5T0ctKeX
lIEHn01sxlSBc+1MoUQaepyUcfiSLp/Mg2NedIE4OSjRD/5azBaZKqffjZrN+vD6
cZ74/JRTfRlVP1XSIZ1qfl4/PRArWVaMoxlNeJqnKtstfvHGv++6v+Byhk2Y2XHT
OMpIPUDK1lrSTG0tpbdAj0IzHJ07g1soFVXtqiSJRXxCTmCNKy4zGrfsEDR/KriS
BcbM3zKnsMQ5p/3X117rVwPt7vRQXB8CEIkK4Jsqcm5ghQBKOVHqfEpTqrr35bQJ
jjnRwUG8F/mcawlgetUDJw+Cr3KoGGLsrGSKP9o3afAtvj5dhMqolEmXp29yFuTs
d9u3y2nb
=N2rj
-----END PGP SIGNATURE-----

--pnv+QfLutJ5VqLgJ--
