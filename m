Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4999CD98F2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 17:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D91D1846B0;
	Wed, 17 Jun 2026 19:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UJ2KuNgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE286846B0; Wed, 17 Jun 2026 19:07:26 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6209C8460E
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 19:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-43b7e186a0cso2730821fac.0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781716043; x=1782320843; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7uH1uzZyCTXITPNE8l3PPz9rmWCho15k6RkJNYcrw2M=;
 b=UJ2KuNgnOKynBIgcCfKm+1VeiZzxgr8+56m25PZLnmhnNauE3vCQZvm0P8hGxuoDRP
 Ey8mSim/Z6Z85+zPc+xhyGbD4bjt0mKdS3Ca7+EMHExax3pMX4hiHLwtPvDbiivDst4P
 ExsGeOfOnP/eXUn0u9GUdmH8oQPF7eANyg0YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781716043; x=1782320843;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7uH1uzZyCTXITPNE8l3PPz9rmWCho15k6RkJNYcrw2M=;
 b=UrXA0hTYR+sWVJmEYDJI17pP28NzAza7AjjD/BKPcXqPl+GVEa7trWQL35Lrfuz1Iq
 0kWvCgUqk6G2S+NYDQgqUoIQOJvL0lDGVAUGiLONNoJUxd8Ik2GGGF9qRIPdJn4SsKQ7
 MxKCDo4euMhxsSj2vsh0kgnbADCSE4fD2bzrz4dGI0VRsrNe1XgsWTVCs+qw8OdGd67e
 5/LYgxo+6tLy6UN/twafpsxoMw6Q5Ub5eZjTJ+fVSqFWy+QOM5SmW9ki33Vb2ECLuu+L
 m0EoSSIaWLEphwRUlej4yYMM7U9fXeNEY1/rgp32Pc0X+K6wzvDJCY2n/E/VAFxSxY9L
 MrYw==
X-Gm-Message-State: AOJu0YweArNaPHJYYI9xfPmmnpBGKo6oML17wwR8Pl8G4Rb7DRAtoVVK
 AxJ2H0BwZZG6z2YRnSHRa1LllHCxTTQDVvDyZbygjakhoexZondpGUUfIr6UR6O3NV0=
X-Gm-Gg: Acq92OEAKnsIU/5CNEt1G+mxaUXLDlzRsJdCWU87FSYYp3xGTBzuSaUXtVo+L8O6Ruq
 RiGMTLowfwuAG611eGgppOeDO0MZmHeVCIaG3Iy6748pvJ864ujawIKgDxFdtx/d+EFqdlpK5ln
 MyOCEM1soq+bUiribTzi5V7hJEGGbvXYFlexvFIlCk6kNfNW+yvwJcwfdxWFGDqhi+7oIUNdCN/
 ArInFqSKn4T/JpaInCEZgs8Ago4/w+Z2aRG5olwymOY0BPyg0tfOgGVfK7TMKPhtGXBDJ5Zyftl
 ZMkRVEofA/X/P3CZjxGNr20X3M5D0mcnP9gx1b23IF3QqucFLbdxOGssvJzkRHuC3ucQcxBZ5hW
 u7M3KbOR1E22zR1rlFG2/58ECh8fjJvL2RDqB+BFEF4dhTqFXW6bV/+33rO5s2YSRLwi5h6qREv
 e1pdco4W/PE0HfURvCAP9E6fG4kp0byQzpaRX8kNaULX7goVk/TE4+UR5QT5bq3FGbnr3uuCv6c
 Fz86yMhIdA5+jwx+B/WdGwL+i0emWosGzUQjEyCSZsCJNLsoeg=
X-Received: by 2002:a05:6870:d14f:b0:43c:586:60a8 with SMTP id
 586e51a60fabf-446dfb387camr59343fac.33.1781716043118; 
 Wed, 17 Jun 2026 10:07:23 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44308b0057csm5032444fac.8.2026.06.17.10.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 10:07:22 -0700 (PDT)
Date: Wed, 17 Jun 2026 11:07:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v6 1/7] qemu-arm64: merge built-in DT
Message-ID: <20260617170720.GA1942927@bill-the-cat>
References: <20260608130924.112831-1-ludwig.nussel@siemens.com>
 <20260608150852.v6.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tXp4LADZemEvMXbj"
Content-Disposition: inline
In-Reply-To: <20260608150852.v6.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
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


--tXp4LADZemEvMXbj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2026 at 03:08:47PM +0200, Ludwig Nussel wrote:

> The keys trusted for FIT signature verification are supposed to be
> embedded in the device tree built into u-boot. When running in Qemu it's
> convenient to use the device tree provided by the VM which doesn't know
> about signatures though. So merge both device trees at startup.
>=20
> Make sure CONFIG_OF_OMIT_DTB is not set in qemu_arm64_defconfig to take
> advantage of the feature by default.
>=20
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

This leads to failure to build on qemu_arm and qemu_arm64 in CI. Please
see https://docs.u-boot-project.org/en/latest/develop/ci_testing.html
and resubmit, thanks.

--=20
Tom

--tXp4LADZemEvMXbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajLURAAKCRAr4qD1Cr/k
CiTKAP4qAvj4JATgGD7nJvsPTWoJnvxucQoZT/xtGQxukcYjEAEAh0zweP4oLRgn
S4E5GFjN1i8BWrzmu6OEQXFW7oUlPAI=
=E2KI
-----END PGP SIGNATURE-----

--tXp4LADZemEvMXbj--
