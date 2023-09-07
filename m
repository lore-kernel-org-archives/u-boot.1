Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA186EE14C3
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 01:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F9D78619A;
	Thu,  7 Sep 2023 03:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FTyroj7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1757086308; Thu,  7 Sep 2023 03:52:48 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE9D68608A
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 03:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-58dfe2d5b9aso5586687b3.1
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 18:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694051563; x=1694656363; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NJk9rDo9yq+UnvHYT0maK0ZQ3S/EblnfK3iXoM5Jv+c=;
 b=FTyroj7EBThsLYknsf1jp5zTdIeiLZbiFHYm5HaESSw4EK+oz6pi+KqRzqIZcXYvje
 g/qL6SciwVcNuUlI5Dx0uwno/u2eQpbRR6nbP4zWq3FayrfXPXzfIwOdRJTmzHzbN8o2
 jmhGN59/ftLqQ+08getvH1wLpmAi1WJobMfMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694051563; x=1694656363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJk9rDo9yq+UnvHYT0maK0ZQ3S/EblnfK3iXoM5Jv+c=;
 b=jXzPt3wruLkmGmPSHaJycuhHOWo+4jSCh/IVLuS4mdAIOnevMAaSXANSbvSDMHvPfW
 g95h2mXpryhJq6/t3sDaSXJrgxN0dX0j8ZGgvD+1tMeJnR67PFbcCKYcURrdIjZmPe4f
 Dih6hK3AhE7QI741aifUJZ4t+BHbPaz7GIoiivEtjRwj2L2D1GtziDl4QNiULZ63M1jQ
 7NjieQ2YamYMDefcbL3XDpySHZ4s99APVtdF6nuuxym+OLKtyY8FVOEl19IG+2WiYF9h
 MS3lCDhC5HumZAf5hY91aFqNC9l5i/7b26S7I/Rz11tI+sDda6GnVEYyAZDSQ7vCvJjn
 mQrg==
X-Gm-Message-State: AOJu0Yy9QDVmAWXwh7Y2yXq84WUINjuWAhy6x5Yo43nua6BjC4S2154v
 x+mOAKyYIzdA+37O901g/aK20dr38BwcJRUrKg26PQ==
X-Google-Smtp-Source: AGHT+IHUJeKmhpwBiRAcaV0KH9H7uH5st68HAixtJriK8o9UmAVkQSVmOJwHBhf10daDmsdNM4oIrg==
X-Received: by 2002:a81:8389:0:b0:56c:e5a3:3e09 with SMTP id
 t131-20020a818389000000b0056ce5a33e09mr1651675ywf.15.1694051563431; 
 Wed, 06 Sep 2023 18:52:43 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-27f1-c90c-e8ad-e559.res6.spectrum.com.
 [2603:6081:7b00:6400:27f1:c90c:e8ad:e559])
 by smtp.gmail.com with ESMTPSA id
 m128-20020a817186000000b005773afca47bsm4058389ywc.27.2023.09.06.18.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 18:52:42 -0700 (PDT)
Date: Wed, 6 Sep 2023 21:52:41 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 2/4] Azure: Rework build the world jobs
Message-ID: <20230907015241.GL305624@bill-the-cat>
References: <20230820173129.781985-1-trini@konsulko.com>
 <20230820173129.781985-2-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GB/Zbwwx+/L385qk"
Content-Disposition: inline
In-Reply-To: <20230820173129.781985-2-trini@konsulko.com>
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


--GB/Zbwwx+/L385qk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2023 at 01:31:27PM -0400, Tom Rini wrote:

> Now that we have 3600 minutes per build job, condense and rework things
> such that our overall time largely doesn't change, but we can also
> largely avoid having to re-tweak this job to avoid timeouts.  Given that
> we have 10 threads, we also move a few of the specific sandbox test
> builds to a prior stage.
>=20
> Note that while sandbox builds with address sanitization enabled (ASAN)
> not all tests pass, so we limit ourselves to just checking that the
> version test passes for now.
>=20
> Link: https://learn.microsoft.com/en-us/azure/devops/pipelines/process/ph=
ases?view=3Dazure-devops&tabs=3Dyaml#timeouts
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--GB/Zbwwx+/L385qk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT5LOYACgkQFHw5/5Y0
tywA3gwAlsazdSSZYHkXIrfMD2hNOmRID/M1rlO7zPqQPoDvDMi+qFT3vjEjNy9x
X6rN1Vp0GZx6EpMNoQDubmSKdxpyG5x+RoR5VDfDTltTjgokDp5+/hNrtfh7spwr
U8mJr9HGF0Flzv6nVvuhKdXxm9GjCilBJtq1Ke0OPCCOpeF9mrzwgMTLt+zQnZi9
G5UXFqvcMQC2izVmfHvhb9XZ8L8RYyXI+G24whsZFK+cpKHq3cYDpNlgUOy2efl6
Q+I5lvubbzEltR9Sx+6APa0vyCv5w4XdyCb/jTJ4E5SBmq/qV123jEN6v5My1vDh
XXgLbJzNZ1GpdPUsxluxounjlcLZd0WUASHLfBB6qYo5GMABMuM8upJkMAsYn6xr
3qWjZTV4si5elTk6Tp6u2L+/vz5CCwWjjdk33FO2S1z1cicWg4X74UaItpKUdiWW
O23bM7sDKbvylfTS4vyZxbbtGBwymGfiCxds3UowFSYbBI1LwQIayPDSMR1SgLau
v+B/djC2
=3byX
-----END PGP SIGNATURE-----

--GB/Zbwwx+/L385qk--
