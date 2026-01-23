Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E4DD74EDC
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 14:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AECF83B21;
	Fri, 23 Jan 2026 15:39:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VWiITTyj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 863C283B27; Fri, 23 Jan 2026 15:39:01 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF9E083B0B
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 15:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-45c733ccc32so701499b6e.0
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 06:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769179137; x=1769783937; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VNHtJbsABgTg2gAj5heDTMFUZOaA/didMgHAcLUlVSk=;
 b=VWiITTyjlB7V6+XMo+aJmL0AaAvAmkZDMaEztsmeZe6gPyptHQ7ENRJFTSdxGmte+U
 o4VevOtKSxFSNUfSN1GS+U2opm2T8VhC+C4joq+/w6FJ79HvhfARStv1XCBM1AbgNouk
 uZ9fAzIbZvwTLqey7jPFDrDGd+erO68oFkDgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769179137; x=1769783937;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VNHtJbsABgTg2gAj5heDTMFUZOaA/didMgHAcLUlVSk=;
 b=NzuCzrTeLjHWXVjU5fSmyPn54MGTOhm448BWOeFo29VOJbQwS5rL2mgSObYzgDUay/
 NBC0z2p2XQyeRNFCcZZTdQo+iN9MN+IDq8AB3U49u7coSJjI4PK9D145k+zPZUEkydhN
 NAFl9kV3/7lSVcZMJGAAyDjXe3qxwyGIwKitlHAFVoC8uAM3IwoXpHOZQwZP30Ehqaze
 xrzbK1oqRopdAl3ILGBLs45TjZgatD1a3RwnlN+E8gtAJ5jH5ii5ifMBI0HyHwB+O3wB
 yqUcrL3T+xJaREHc7h7tELqrllyXm09NU9R4SX+QnwjqJ3dedb7ZQE5pdmozsHQu7P+T
 WGXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8OCa4t5AxN/TB7PPK3Jy8bIENg7vPyU3ESBo9m4LfKeAXBVTv4ZpdPXszcwTXluC0gUbimxE=@lists.denx.de
X-Gm-Message-State: AOJu0YyuhR9nUXM/qMZnlnoL2SiMVQtD+3h8I/VAXsYdm+kncep7tCVr
 ujMghB11Dyc+6ylWDu+DAXG5RVJz2rHetb2TD4AyEFiZdKNlBSbeW/n6efKDCzadIaM=
X-Gm-Gg: AZuq6aIw5PtGmP1YZwDIXTws5Xtaex5lVaS+2yW+DV/qJCvesA+zebG4VwjBJlnON1g
 McxJSyKsFY1KpP7zsw+GJIR3DDSh76iTkst3JE/ntUaCF6CPexe/6vr1nTqK6Z9f/P4+ytBA5ok
 dN+bOyi08CZ2IsIKp29RGzHdWZK29QHQy/TVgzAYXNtn4nKBPHg12RCBEpXehWY6cApX4RwPBfR
 I6d6oTITNaUYIvxfygDQ+Vxcf6wzZWVNVdi+1v4wZk8D8aYXhd5go4TJeDKZoA7IytcQ8/gR1rR
 d+qv/WY5JJlJuiMidOuLyCni9h/ftLadVchC5CMFJMIRsqUu4HgiIF24ORfPDgjmYw5Zuzfjjty
 eIF5cP5AeYIhwQDZnP1g33UpmdkwHIh6kz42es3Sz5/9RBSkfhNh8lye7uRauwmPps6NTYPu+P2
 nQpP7nyC6WdQN9+cfzqv9KylNJ2Hh4UnBGtDoGxpVJtmiTteeDdc+u/VC+IApU2sqvKK9MolQ16
 2K6VPm1zO3u+GvWBqXRUhh5H6AWEpCAXcpPc8M=
X-Received: by 2002:a05:6808:1911:b0:43b:8cf4:9284 with SMTP id
 5614622812f47-45eb1a81685mr1562194b6e.14.1769179137452; 
 Fri, 23 Jan 2026 06:38:57 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45eb4235b50sm1290388b6e.14.2026.01.23.06.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:38:56 -0800 (PST)
Date: Fri, 23 Jan 2026 08:38:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Peng Fan <peng.fan@nxp.com>
Cc: alice.guo@oss.nxp.com, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH RESEND] board: nxp: Rename board directory from
 board/freescale to board/nxp
Message-ID: <20260123143854.GJ3416603@bill-the-cat>
References: <20260123-nxp-v1-1-91feb4312639@nxp.com>
 <aab556e9-9789-41f0-a4c8-01d48c191940@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v50szIdneJew9rL9"
Content-Disposition: inline
In-Reply-To: <aab556e9-9789-41f0-a4c8-01d48c191940@mailbox.org>
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


--v50szIdneJew9rL9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 11:29:48AM +0100, Marek Vasut wrote:
> On 1/23/26 8:54 AM, alice.guo@oss.nxp.com wrote:
> > From: Alice Guo <alice.guo@nxp.com>
> >=20
> > This patch renames the board directory from board/freescale to
> > board/nxp because NXP now provides Board Support Packages (BSPs) and
> > tools for the former Freescale i.MX and other i.MX products.
> >=20
> > All relevant references have been updated accordingly. This change does
> > not affect functionality.
> >=20
> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> This should be applied for master branch ASAP, so it won't conflict with
> other patches.

Honestly, I'd like to see Peng pick this up and send it to me in a pull
request. It's going to be a bit messy I'm sure.

--=20
Tom

--v50szIdneJew9rL9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXOH/gAKCRAr4qD1Cr/k
Cs9RAP0TghVHf6uBQTfLoHM+LNC6s9glW7okbNSRfITIHgw9zAEArWkJp8biQ2jv
qxln9IOW83fijgNtQz9mALCAc86/zgs=
=LHju
-----END PGP SIGNATURE-----

--v50szIdneJew9rL9--
