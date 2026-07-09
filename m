Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44A7C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A7BA84B04;
	Thu,  9 Jul 2026 03:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V3AQsg8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B18D84B04; Thu,  9 Jul 2026 03:53:06 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B3FB84B02
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 03:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-44cd237446cso853724fac.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 18:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783561977; x=1784166777; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QEEMlpsanonmOvbMHUjfY1CyTK+5ZNOvWVlII4mRl4I=;
 b=V3AQsg8k6udLtuezoDtbhxGwv06M9DLoWDMLYM9oILzIJ4ghVNmvKjycLZ0dRkHAaA
 BlY73rNAcZMxj5dZWtpj8v8KLD3+wT4Vjfe9F/x5xTBfSrWAZdkP3IwSeqE5glP6jsSy
 4fj+TEPpI1K/jOcLDrP0KsgkexDRd9fXyvtwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783561977; x=1784166777;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QEEMlpsanonmOvbMHUjfY1CyTK+5ZNOvWVlII4mRl4I=;
 b=OLn9Rpn0FwOIjdWHS805OJ0DfHV+Z8tNDtcEbua/A5DJX4lSzgJ5Vldb6nawGsehqs
 N8f0LI6//KojgXFWznCw2fpfR5ia7i2mpD+cAtGzng+LTD6sOBec/ZgAAZ2n6fNsPUEh
 im29xQ4ApaMLv9ASOK9QGMmFRa7F4iwNOmIBY36FursCF3HwSl/XnSiCl0AWcZ0269D8
 P/2ud4DXbMcsflMEir7DwCkjN/7WBEhz57cwzBJNsG1a0XG1ler9GyaIlkKGULyV6Sna
 mmSwSuuCO7HsI60MiaByi6bQmGlirewZGkHPqUqAP2pmyOdvSdOradFBjeLw4NT8z5jK
 K1QA==
X-Forwarded-Encrypted: i=1;
 AHgh+Roe0HhymSe4/HPSTJmAKf/zd05r9x6FTASUGNqVwc4aFsZMSe9tRrcd1uP9EZDvU/vyQqh+2vs=@lists.denx.de
X-Gm-Message-State: AOJu0YxM5WndDPxeK4cVovqJoOQfG+pxIykyHhvYHU0uj2ZazpMKtDx9
 zuO9XxBvxt3AvnnbiPwy3BFRlOO79Ydrmz2sHVSG5bIo6k3r4NuP9kVbLeFY82Gtgj4=
X-Gm-Gg: AfdE7cmajgUYZGanJB9rNXLatXRZxUtw4rsAKpf2vWyUe+L3USmFQlxVk1YF5T/Em8W
 yjOyCrvDXq1c1hS8z6SD6+/Il60EqBR1MDFc9jR+GluNHXRhJ720OEFPrLd9kQh9ww1NIYVRqoS
 Nz8GO/u915c3KabJraG/5ahqo7Wr/sDfQimwt0hOuaX6dx43tDFPWbxsxyOzBkYktiZ+d6mznJc
 Lqj2/6TAp7zsI3qdweSg/9oHDf+nkNHN8DjX6H36eUYTk12MUG9vVxY3M6esWNtAbIYgvHuz104
 VFTk6bYpE7eDZ0eiTcTghz5wvAnFT89WRfaMzKFoCoBGFRZYPdIhzJsVdNeSbsbZHsONflncC4J
 tg/0wdZ3zPXyZf8rvrdJvLa4WIfgN+IMAFqJZJJICmKrTaSfxc68iCzu1Ufn/UF1/rGHdoJ+L2R
 +Tf3kIAN2081oMrMQAL9E2p5yWJE2w8mXpC7mDDoaCIS6vo5uCK0e/7bDsLLgJ8zmW1iKHO1HoN
 ism8rs7siGzWjCY9k+mcrMmJcuXMCoMcSRAAw==
X-Received: by 2002:a05:6870:2494:b0:448:c34d:9920 with SMTP id
 586e51a60fabf-45163bf3940mr3502244fac.28.1783561976944; 
 Wed, 08 Jul 2026 18:52:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45191643b1fsm616381fac.10.2026.07.08.18.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 18:52:56 -0700 (PDT)
Date: Wed, 8 Jul 2026 19:52:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 07/11] Kconfig: Depend on correct xPL symbol
Message-ID: <20260709015254.GS749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-8-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oabFLuib31OCKOwR"
Content-Disposition: inline
In-Reply-To: <20260708220540.3368825-8-jonas@kwiboo.se>
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


--oabFLuib31OCKOwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 10:05:33PM +0000, Jonas Karlman wrote:

> Change to depend on correct xPL symbol instead of a xPL symbol intended
> for a different phase to make affected symbols available for correct
> phase.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--oabFLuib31OCKOwR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak7+9QAKCRAr4qD1Cr/k
CsMhAP4wvyTdr7wkg8Y214d/BqjqmpGhSSr0ZdlIOLfpO3wKNgEAhH1b4Eqw+XZI
u2F5UxpSARbAXo9o6/MVnvSFlKcSZw4=
=dTXG
-----END PGP SIGNATURE-----

--oabFLuib31OCKOwR--
