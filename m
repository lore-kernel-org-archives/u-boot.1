Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D74FC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 21:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F22BD84AD6;
	Fri, 10 Jul 2026 23:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tCsQPp8h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAFAD84AF5; Fri, 10 Jul 2026 23:25:18 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1EDC84AA4
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 23:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-448cf99c133so2128673fac.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783718715; x=1784323515; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R9tBctfzzHOiBjBY61/VqXXjOjOnG52lKQIagASSSt4=;
 b=tCsQPp8hTmO5+mKgqUVpObf3+YHRMjoOVIeBWVMNgmiMczHY3jcNH3mmVIrZCAUxJG
 Fxtn+Ci+W1hQK5Lr4k9LBOwanUdl/kr76lX9Va+Hc0Pb9QJoN+8HY8Zupyyi5AOIBqBa
 aQ5Z7kMX1nZ+/W3nPKWhwwjcSOGUqtPDF7/Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783718715; x=1784323515;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R9tBctfzzHOiBjBY61/VqXXjOjOnG52lKQIagASSSt4=;
 b=q/rtyinF912JXp8VqZyCgMUIwlNOVFV6goCgpWpMP4w9yAxINMsDpndL2HvsPltFLL
 aR+hYIFRHDvP4r/NrNomGIIYhFvkrRK7N40sA2OSK1dCgJPDW5QHMz7/GikV3XMUpRKD
 IxLlQmoG5Ec7+uyeFy81K2SKQsXr6ZClydweLxjEnwM1AQX/o6FnHOXWA4E1aV3xFYBf
 Iyrq0YCxuOcDm6e7+TSiWQ1r+w0GBn0xvzH552u3CO9vlS12WHyucwfUJ59mPmEg0aoc
 bQnv60ePyQ5pq5ypPTOJv2r6PBi9DWzLMukOTgsc76BF72xZzL3bFYIerqmmJkWq3kMR
 nvzg==
X-Gm-Message-State: AOJu0YzdeZs4k0jf7/fGGSL+fmVDNYDejE8nf72C/hnREFUBg9PQ9BOm
 5d4ExbyiIdw7toryxIpouutbt4S0iUHNbX38zuPLa0neKC/6R7A5YvHMwEnUkYOp7k4ngdpsFHs
 G7sUIPMw=
X-Gm-Gg: AfdE7cnX9S66VRk1fdEohdGu+3sgqmB0xxthjisA7YxpdCDmoV4e/8ELDsyH+Uqcwfw
 CudOsfIikQbzyheG7RZWOtwXGE/9Ild0lWSt0+f8roMLb67M1KwA005OQRfxLo4GMSbYfkCMwdM
 IP76EXsOPuGNzLMTQjpb2wq/IYM90Fy9UJkRhgIGgKfCjPHZMfwwBttfEpV5oshCBLolmY87sEN
 +yJLISYNQ34OQIfLB5tmziwOIycWMpjMFx+pkpdSeAO5uokKSIljYu30kg+yddApDwFxp9lFipe
 obdXl0U+BQigggEeUCpMpiowGwFaUwShk4ar/hp4NkGF64ZxY4FLG8XSQ/TghZ+ubgJQbUT33zM
 086oArfLzP7Ng0cE+wL9fS4x2m0/LQiQsr/IVD3W5ai0OqHdph4XQIxQ9zPDlZQs/tM2i0TRSrk
 F6j2gYB3CdxNzD+5PW2oOWQytVP6y4mzt+2JJ6LUqW1jFGN+JO04f5R9lArAfkB7mQi70ju5wXn
 Ta8lsbJBFLWOdAw60NVsa16/RbAZQuRai9xdg4eO8pRdy/d
X-Received: by 2002:a05:6870:e310:b0:439:bb0e:670a with SMTP id
 586e51a60fabf-451f292a6ccmr281842fac.14.1783718715419; 
 Fri, 10 Jul 2026 14:25:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451912dd9ecsm6084976fac.5.2026.07.10.14.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:25:14 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:25:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH] clk: ti: Use CPU ticks to count timeout
Message-ID: <20260710212511.GP749385@bill-the-cat>
References: <20260708-fix-beagle-v1-1-c9b5393e6d23@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U6If8gPWLsVHnjou"
Content-Disposition: inline
In-Reply-To: <20260708-fix-beagle-v1-1-c9b5393e6d23@bootlin.com>
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


--U6If8gPWLsVHnjou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 10:38:10AM +0200, Bastien Curutchet wrote:

> readl_relaxed_poll_timeout() relies on timers. On the beaglebone black,
> the timer used by readl_relaxed_poll_timeout() depends on this clock
> driver. So we have a sort of circular dependency [enable_clock ->
> timer_init -> enable_clock -> timer_init]. It leads to a
> division-per-zero during the second timer_init() and the beaglebone
> fails to boot with following message:
> | CPU  : AM335X-GP rev 2.1
> | Model: TI AM335x BeagleBone Black
> | DRAM:  512 MiB
> | ### ERROR ### Please RESET the board ###
>=20
> Replace readl_relaxed_poll_timeout() with a simple loop that uses CPU
> ticks to countdown the timeout. This loop and the value of LDELAY are
> inspired from what's done in arch/arm/mach-omap2/am33xx/clock.c
> Also, arch/arm/mach-omap2/am33xx/clock.c doesn't return an error on
> timeout, it only logs it, so let's stick with it.
>=20
> Fixes: de2e3f00f2fa ("clk: ti: Remove AM33xx dependency")
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

Reported-by: Tom Rini <trini@konsulko.com>
Tested-by: Tom Rini <trini@konsulko.com>

Thanks!

--=20
Tom

--U6If8gPWLsVHnjou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalFjLwAKCRAr4qD1Cr/k
CsjfAQDUEbMnTPXATBeqyJJ4exSFSgfvM2t2LTGyiOC/3Hww7wEA7s5IjHJaPV2I
Nj5pNgguwia1Xz1F7dbk3vPTAKrVDgQ=
=HMgj
-----END PGP SIGNATURE-----

--U6If8gPWLsVHnjou--
