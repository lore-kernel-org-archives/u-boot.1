Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5102AC5B542
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 20:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A14948318F;
	Tue, 27 May 2025 22:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bHoJDo/3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67FDB838A0; Tue, 27 May 2025 22:22:15 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3973C8313B
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 22:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3fcfc85f1f5so819457b6e.2
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 13:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748377332; x=1748982132; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QbWv3lzGQaal5VCWVhHlWRHo+cGTdGRdq59va1xS4GI=;
 b=bHoJDo/3CK8977TnUN7i4f/cW2j6C18PJ4zlYKbmNmyerL09bwx1O9JJZeUgRhrn19
 VkF/fD44g2i/GgdwtgriqDGCYZwCe3ADSRyV6BHkxeI8T4jAQEi8i3TEBX8yEVFoUeik
 oQWUhnFsDwT9VXdMNJZ4ceK5ETClCGZCtwbVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748377332; x=1748982132;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QbWv3lzGQaal5VCWVhHlWRHo+cGTdGRdq59va1xS4GI=;
 b=sUfuTLPMZY5T2Ssvm+IWQ4cNg/D/ugbHeIgNIvQEPTGe+8eu+w4kqSssgIuheEv8JV
 snZm+4zwTLyTMWZTnwXgoVxvPXaH/7Z/fuPMe6TGl/kjTpCUkUzgE4rz7Q1h+OMst/hN
 lpvOhs5PrIDWuX9yuuwNJ30mNuHZHP2gMy4dLuMh22XfN8FAv/np8kvsD/TqDZlZyZRM
 FhVRXe/Y+fWPwza3gu04cAE2aiQiFNU2I4W9Jm0y8KYcHSj90+Uws4Jjh2GgIfSkqpEb
 A2rCjWJgIzcb45z9WYbmFCaILmNBLBn908gXLNbhcgPglduDWdnJhXTeLH9C/T88Oy6V
 p2ug==
X-Gm-Message-State: AOJu0YzRbGM1AGuvQl8yY1iDWcpaJ1ZAyZ2swDWcTMFmLp2uHkfbLuvC
 ocyrg0+tdxqqDDm+nOTw+pQjxzEwG+t+RitM+3UV/LvD0MMRPTq9/+mqPe6DuUFoCdUnIlSitGw
 SAk5BcWM=
X-Gm-Gg: ASbGnctmEMEhr5W0iNY3cFtj+MGRmsjghZSvnXXJviD/mL6wfoR86w0awjkbr0s2VGc
 CjrC2YrtI0OVnPo2J8I6j3UBOkvu76V71rlZJTowEBUJv8m9G6iSekb3hDbHUEeKPygkO/Ev3kw
 +tRWT8LjeQdg2KqrVMRVqvIQnDSCgy430OxFwKT3q9zT/n0M8vO02kFv2dZ+gp/0nhE0heB/YqJ
 Z9ck4sq/zah1glQNUHnzDF4Rlgp5zFDug4wFs8W1juucn5ebv809CZw1MScq+JabBh7X5qGSVuV
 /GDPAUDfZy8wAqn+WuRwJ5uXuNkvjThoFmCMHcojTvzSKz+eF2U8P6Sr6IIDX3A6meIQeRiLeN6
 L5/Sx3PXhkx3EApaxjeexmz4=
X-Google-Smtp-Source: AGHT+IEGcRRaeYNjZDXmwHJVM2eVVQgHYDEZXkG8s05ZoPRPCTpCeGwQUxOsh0ykrELqxVRRLgPwMA==
X-Received: by 2002:a05:6808:80aa:b0:404:e0b3:12e with SMTP id
 5614622812f47-406467b8c8dmr8265324b6e.3.1748377331845; 
 Tue, 27 May 2025 13:22:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404d98b27a3sm4826900b6e.35.2025.05.27.13.22.10
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 13:22:10 -0700 (PDT)
Date: Tue, 27 May 2025 14:22:09 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: Merging v6.15-dts to next
Message-ID: <20250527202209.GN100073@bill-the-cat>
References: <20250527155205.GJ100073@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eS7U4nlx0pCW0BxR"
Content-Disposition: inline
In-Reply-To: <20250527155205.GJ100073@bill-the-cat>
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


--eS7U4nlx0pCW0BxR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 09:52:05AM -0600, Tom Rini wrote:

> Hey all,
>=20
> With the Linux kernel release of v6.15 over the weekend, and v6.15-dts
> now being tagged in the devicetree-rebasing repository I'm merging that
> to the next branch now and expect to push it later today.

This is now pushed. The only small hiccup was that our non-upstream
version of dt-bindings/media/video-interfaces.h was now out of sync with
upstream. However, all users of that file are OF_UPSTREAM and so the
easy resolution was to delete the other copy. I'm going to do a little
grep'ing and checking to see if we have other dt-bindings files outside
of dts/upstream/ which are unused and can be removed.

--=20
Tom

--eS7U4nlx0pCW0BxR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg2Hu0ACgkQFHw5/5Y0
tyxBegv+OXV/Fj82YntSP3m3uCUa4zNZItZntQ4dSYOw/KpvD4ufxQnFOlpM8mBH
cuU1amYrpe8ZajY8cDlm///CiKSNz3kJFDBfOvWgi+fngVvCvOqgfdBDpe8B01Sd
cV529R8Ma0FKqgUsaeMviBoXAEXfkkX0ys1aSRioEO84pWfrCm1pfgSSXZ/nsDp9
dVul5dxAetQSYTYhjycEtmEPJ0aeUKYO6r9gK8+on2iAAWw3t56qmJsMujXcmzZ6
yZTLLV4jOvFodJnQbbOIOR8N9yaeKD6dwZPvAY1BV68neAiNdG/ZQdvLfSxHQEMK
4DWfx8uNAwGUb5M0rH35AHMDA/tI5bihrln1RGRDjna95oFQx5Al1+OkVhjaWzhb
XIn7F2gtk04KsdYxJ6q4RkxhHQCEVnvBqmOh/OlS/e6EQNHA9erqNg3VWQDWMiDJ
+IqxfC4ukAwPGK5VITQuwkkUe2cWsVTTlwx162QUK/WfXIA8IBmc4qj/0z+Zi7aD
dAcZpg/m
=8jvy
-----END PGP SIGNATURE-----

--eS7U4nlx0pCW0BxR--
