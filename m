Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644CEE7DEE3
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 14:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B83CA83E8E;
	Mon,  2 Feb 2026 15:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dtwTl1Vd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1484F83F00; Mon,  2 Feb 2026 15:38:19 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA2E383D8A
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 15:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-662f5c5507cso2637121eaf.3
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 06:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770043095; x=1770647895; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X1pR/mHf1ysap6I6aDDK2d21dSAaRJqbCpZFEuvm/ao=;
 b=dtwTl1VdqyKEI/XuRG5vCX+MwjqPOr7xnxYCbwv1MTw/e86nrhoXReOIA/FHVXnsu0
 2TCd795RyUq/8HXQdZS864mVZFt+hUHGX4eoPc/KQjZ8PA9aVeP0sUnnfvQZRvGwhQna
 7gkY0HkLHCkF97hnhZmXjM+ZLcF3xad51yhHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770043095; x=1770647895;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X1pR/mHf1ysap6I6aDDK2d21dSAaRJqbCpZFEuvm/ao=;
 b=si2h9VqtOigxvqOeb4udh7z6ZuRjZnxbbX4koOWMuYDGDo5CfGta2vrfmmTij86q0p
 1myytoHfsxfWq0A4u0B3s0KHwoMfhewm3lmrca6+zzUmObPFxyIWHM+h4D6+OcfkZEl+
 P9cKaHsjXKFMTGl2s/RBSRT5e8p4jlPbkHOXn8TpUE67hW+797dR5xol3gw3Qfs0ucYk
 HOn3A2UkWasmdEmBq5vOVEBryrW+h+5H/6kYXds4UxOWM3Rvy3kUyo+7zMu5JbmhEVLH
 39TcnHKhwAsRiF9O6UyW8GidQ1Aq1gq0r2DZ/CR7BTX9t1abHCiphZXLryFIs9/wm+zM
 BJ/w==
X-Gm-Message-State: AOJu0YwINVi+1fIuy3o+fKe5wteRZfkFfOxbrhmAZRpOgMtfjKZYIR/u
 wcE5kK8T1YyUgkGEgRvGUyE/aeGZzrJLlDPRo0ltTm0sUEqfEWx/aU4dSeAAv+xqeZY=
X-Gm-Gg: AZuq6aLl69tOgqyz++M4jZ7uvpFCKYnusTWmX4hCeKjrb6TO8k+l/kKg0KWoKi1/1hE
 vq8brtOB6s4KYO/j1zjSPjYCT+MIj6bhERi0cdA3SztTajHdGPHrcrZO7aMU3AGAPX777mwvzG4
 o/YQ0vM5f+pWHqYYwmkKz8vhEAGrOnxvkoRy+dQZ5baZ0HpKIE+QAEAE14NEaYG0iRYsNGk6LwA
 O6Yv0mstds3g9ScGqdBZdxGympotxShiu5U1Nxvbl0DlZ103GR4ORS2kKd4hVUoJ89E4XxR4xjk
 KSIKAL3PLTh+il2USTbXF1eS64eO5EqcnB7gZiAZIzYg1zlIG14BQDtECjDOAC/nL4d35VJB+C2
 iVphaGCQtgPx/uuy42f/IGOhkIZYymAdlHKDGJVn1Odlo3GEIjazl6qDw+rIC+1oZslRioXDhEp
 9oibHFP5MfbzjDhZXWG0T0HDSeaIjxahn2vLomkX35wg9pRidsoaDj6efwFTySxtOfEYJXDUbdO
 ++iQNfYCeePhC9woXM/4vGBWdA4I97tXT/t9ZM=
X-Received: by 2002:a05:6820:3098:b0:65d:1697:e6cc with SMTP id
 006d021491bc7-6630f3b204amr5413186eaf.60.1770043095043; 
 Mon, 02 Feb 2026 06:38:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6630606f2dfsm8683499eaf.13.2026.02.02.06.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 06:38:14 -0800 (PST)
Date: Mon, 2 Feb 2026 08:38:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Vitor Soares <vitor.soares@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Andrew Davis <afd@ti.com>, Gowtham Tammana <g-tammana@ti.com>,
 Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH master] arch: arm: dts: k3: refactor common nodes to
 k3-*-r5.dtsi
Message-ID: <20260202143811.GC2603314@bill-the-cat>
References: <20260122-r5_dt_refactor-v1-1-5442a4321756@ti.com>
 <DG4BZ97UWPF0.FCYZ7RUNHS94@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/kPXNrt8l1U3V9J1"
Content-Disposition: inline
In-Reply-To: <DG4BZ97UWPF0.FCYZ7RUNHS94@ti.com>
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


--/kPXNrt8l1U3V9J1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2026 at 01:55:19PM +0530, Anshul Dalal wrote:
> On Thu Jan 22, 2026 at 7:38 PM IST, Anshul Dalal wrote:
> > This patch refactors the nodes in each board's R5 device-tree to common
> > SoC level dtsi. No functional change is intended from this patch.
> >
> > Signed-off-by: Anshul Dalal <anshuld@ti.com>
>=20
> Any updates on this patch?

I've been letting it collect tags as it's not been quite 2 weeks.

--=20
Tom

--/kPXNrt8l1U3V9J1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYC20AAKCRAr4qD1Cr/k
Ck+JAP9R7ZCUNsdnN4oPOdO+T5kP0vFR1LHZyDpewGExU850qwEAggtonVAdxGAX
/2LRr5D6oSfHM9YHDrc2pFizFREn2Ak=
=yGcq
-----END PGP SIGNATURE-----

--/kPXNrt8l1U3V9J1--
