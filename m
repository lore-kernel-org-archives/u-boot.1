Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D053C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A548684AD3;
	Thu,  9 Jul 2026 03:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uGpUETgI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2523A8407E; Thu,  9 Jul 2026 03:52:25 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FBEC8407E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 03:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e6128bd9b3so649385a34.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 18:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783561942; x=1784166742; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uxjcZSDJupojLo5TlHfN8IuNv1P65o4+Jr0NSPTcIJs=;
 b=uGpUETgI4QoAo7faBHQWPcVWGPVsraVIPJPC0dfPNONUr0b2n3pNKxTh9xOOpZdtig
 K+WWN/Z149TBYNnYEoBW1nlJj9FhgoHZCH6YiksKXUUsx7wnWG3GK1zT9eVEZl/QqQou
 id6ALGM5mVbRRwCTZ4MBkWz1Z7UZRNqMG6wFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783561942; x=1784166742;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uxjcZSDJupojLo5TlHfN8IuNv1P65o4+Jr0NSPTcIJs=;
 b=S1MxeeYqAZquAN16fDMkPFswT5RlNl3bRx1w9SvZBEM1FXfNjiCbuNYalPImAaqqDH
 cFXbRaKqrOprYuxsQMnDCDMyzwV7L5fWt0MzVaPrN3c40fUME80G1DPNM/atNCeK2Wbh
 f+IiRy5xoKZqpRhjmZkLufzlbHaV/sHLKT3pywzUDz8ZbiTPQIB6rCEpkLUm6xXQe14G
 wJ2ebLuMr+RKNnx1RfUOsadAypapjCiDy9dRVozk5FurNTuItZFxRFyagAXhriawpit2
 1GcVMR2JTA1UOjc2u4rBvZZDjeJN0vrzucWSyNYhOPVE0pSpZSN3YulzM5WQYiHyQ2Pr
 Evwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HZDv0EWKR87pFiU+iSQFOTyNdXvRJ4ezJHytW3ogE5yB+HrT5UbFMvCy+90nbJDrZEk4U8fk=@lists.denx.de
X-Gm-Message-State: AOJu0YwgtQhDbpdl/4qKmZ9zTAcYdF5zapcj3H/OxjuYo4EGAb3aPvMc
 6cKtZ5lzoxGW7uDeZYv1ZN7S9vFd7PGegzJg2Ic8UCxIwUIvmJcFS0xzzzYXlSWgAUo=
X-Gm-Gg: AfdE7ckGK+xIB6pjLjjA0dt8uffwF3HFb/A/Fns36xwDMTFVibqjkXDJFjlE1kRJNl+
 AI+Qz4NmL6TXtd5GXcw2ODIAPNpMXcmfMubeYOuAajtqlchT8j40fza3nlXEVyibI2QU8uGyzNE
 bdjf3OApyZ82FgAHgjDHfZEBGWR4dCHC3xBqjt2aQQ8AHQrTIu0yodu8SOcrEhM8ydHuLXq23hw
 QEJuaSr3HZfHJkORqx5n54dSS9HNpf5ntbRvAWrf4ERCKeSZUvKgdLRZZCTmUlMYS7MsZMrv0O8
 aPnPnGViwhUFSsuNum6FoCCy56oUyKY+oXSpe7CYAuS+VlomTmCJJUfVl7OBq4foPxuTnEbxR18
 2bvMSqHhwSTiHR2aWfr0H+YcRno+wqWLntjjipGE/pOid4mreYZOEcJX7ykjQHlwKkh0PbvkMtv
 4U0fr7uENXf+iiJLCRfMQHb6HcK6r86Gv904uQkAb7h9qHZ1wfz/D14BqZ4vWGdwsL4kzZZJoZs
 kPwETBNtMypC3IIi4MI7hesm0SfYVHG4Jm1mw==
X-Received: by 2002:a05:6830:67fe:b0:7dc:c7aa:22bd with SMTP id
 46e09a7af769-7ebcff349b0mr3544569a34.6.1783561941769; 
 Wed, 08 Jul 2026 18:52:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb2631dfsm3036139a34.13.2026.07.08.18.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 18:52:20 -0700 (PDT)
Date: Wed, 8 Jul 2026 19:52:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 03/11] rockchip: clk: rk3368: Drop redundant
 CONFIG_TPL_BUILD checks
Message-ID: <20260709015218.GN749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-4-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xUDRZHl/LU1REzYK"
Content-Disposition: inline
In-Reply-To: <20260708220540.3368825-4-jonas@kwiboo.se>
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


--xUDRZHl/LU1REzYK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 10:05:29PM +0000, Jonas Karlman wrote:

> The XPL_BUILD symbol is set for all xPL phases, i.e. TPL, VPL and SPL.
> Conditional guards that test for both XPL_BUILD and TPL_BUILD symbols
> are therefore redundant.
>=20
> Drop the redundant TPL_BUILD symbol check from conditional guards that
> also test for the XPL_BUILD symbol to cleanup from an old SPL to XPL
> symbol rename.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--xUDRZHl/LU1REzYK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak7+0gAKCRAr4qD1Cr/k
ClPIAQDc1hQG/dlkUiQbEsP4q30pJ60KBulays7ivZwrji+MlgD/bpyAV2pZA/1t
Cn4wGOizxXQjhVs3xrda64L12c1SHQA=
=SOm1
-----END PGP SIGNATURE-----

--xUDRZHl/LU1REzYK--
