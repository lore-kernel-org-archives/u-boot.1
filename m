Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D07C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 18:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CB11849D2;
	Wed,  8 Jul 2026 20:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mC5YaZms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4237E849F0; Wed,  8 Jul 2026 20:07:13 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19AFD8496E
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 20:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-448cf99c133so98551fac.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 11:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783534030; x=1784138830; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3QmmKo16WF5wQbM4yQn9hkx97cQzPtTGhXkCt4BQTWo=;
 b=mC5YaZmsNoCTYVWVhA1f5nupb7A1x13aqs5eoT/ov0hGqfywZoymzETfL2ZOt3Tmex
 A71IOuo9KFcgPIpeLXafLDsWFtXt/fF9vxE90WfnZ91P6aDzzHyjDkBIeGjXAGp11tvF
 Q3Jy9OeP7uI8SEOlYYmzjZqs8O2+xQbFMIX+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783534030; x=1784138830;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3QmmKo16WF5wQbM4yQn9hkx97cQzPtTGhXkCt4BQTWo=;
 b=eQ920ek6++cufIztRxnXgTzHj/XvhGJ/jaUE6PgkA6WIvWn5d3pcGQ3rjVLzfMK8pD
 mDOqjK8pslot2CSXaSjpwhHSt5d5YuZeeOlTojrja8VSxmMOuFUdjieAha84/PoxCzOi
 xogY3VnUIMz0e6jqol+QMfDqotjluxyqHbLgC7uk75BUAD+OtnEUjHyPNCVsULvZd0lo
 O6uq8109kZu5dBAzQz36jmh1hHoBLC2OnA7gs2McS/4vJncFHDiFb+W680CLYCdTLp84
 bE4gn9bBNLnucPp3zd2J8LFunyli1WiKlmH9IauX1nioPZBNBsRcTDDyyFx2XyAs1DXG
 QTlg==
X-Gm-Message-State: AOJu0Yx1ccttceny3eBBjCpZgJu9cx1UIt1RFRljb0AJXjRUmTkEmiqB
 NVXB1VlZnEp5wSyMmr9yBUaydFfJXhoLYAcy3geFPgMvta5N068bpBy6jxj772FB63U=
X-Gm-Gg: AfdE7cnkKww+wnizJegRnyN8tROFUj5GsAj0SLGVAl4bJg6BpXm66OYELZ1sFk0eXMt
 KI047o6NUF0qWnosgTa2GPBHtNvOJiV+61cLtlog7JfnNaO9pXSAmEbyTYR+Kk4IbwqEOKkFVK1
 gEy/ptISQvGzRpzvuOwecgaDfnFz5DeW58peJzHrOh2YrsSVc4rbk4fZa8asPFjG7i8DH2mrBM2
 MYgf1vUcH5i+mSVkbTSVjxuIfcBMO/p6CxtHTIczefwqAwsYNfNtxZR7Gb8ucx5LKWNxcuWT5tO
 IJN/RDGHCCs8Un+JltwdhYyoMEDrrhVb9sto/wY9h6ipvRb3rzcoyeVxWKnyK+KbkzLvkPGQpA7
 oG0Du/eqjXJqsOSxwHeSzSJ1L4xLYJ375aHHsdaOVRWqGpMtt2Za9aWqfaCU/i/H8yGovRaJlGu
 5/nJKlDVqTDZ0eNIFM/4+JZBee4+kEw4awEAX+EN7pffZ6hVmxYPGhNljQrJI2koCCDZXYLtVaV
 tTVacuDMVO8bt4e3coUKkJdnOz1EnE3RPgpBp/TTNQwaz2o
X-Received: by 2002:a05:6808:308c:b0:497:d84e:97a1 with SMTP id
 5614622812f47-4a1ee780e8amr2877015b6e.2.1783534029732; 
 Wed, 08 Jul 2026 11:07:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1ad4ac92csm2261025b6e.5.2026.07.08.11.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 11:07:09 -0700 (PDT)
Date: Wed, 8 Jul 2026 12:07:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v1] bootm: teach handle_decomp_error() about the noload
 decompression buffer
Message-ID: <20260708180706.GB749385@bill-the-cat>
References: <20260705145445.2339-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I4T+5pQI7FxN+CfM"
Content-Disposition: inline
In-Reply-To: <20260705145445.2339-1-aristo.chen@canonical.com>
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


--I4T+5pQI7FxN+CfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 05, 2026 at 02:51:22PM +0000, Aristo Chen wrote:

> For a compressed kernel_noload image, bootm_load_os() allocates a
> per-image decompression buffer of ALIGN(image_len * 8, SZ_1M) rather
> than the global CONFIG_SYS_BOOTM_LEN. When decompression fails on that
> path, handle_decomp_error() still prints
>=20
>     Image too large: increase CONFIG_SYS_BOOTM_LEN
>=20
> which is misleading: increasing CONFIG_SYS_BOOTM_LEN does not help
> because the smaller per-image buffer is the actual bound. Commit
> 2ff26c1e378d ("bootm: fix overflow of the noload kernel decompression
> buffer") worked around this by printing a follow-up note right after
> handle_decomp_error() returned, but the boot log then reads as two
> contradictory sentences.
>=20
> Introduce enum bootm_decomp_limit and pass it into
> handle_decomp_error() so the helper picks the right message in one
> place. For the noload path it now prints
>=20
>     Image too large for the kernel_noload buffer (0x100000 bytes)
>=20
> quoting the actual buffer size; the global path is unchanged. Drop the
> trailing note in bootm_load_os() so only one line is printed.
>=20
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Thanks for doing this. It's clearer for the user and after checking a
handful of platforms, we only grow by 8 bytes, so, that's well worth it.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--I4T+5pQI7FxN+CfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak6RxwAKCRAr4qD1Cr/k
CriVAQDyeN3V6Z7DoEJIPNY51OUT8YaJYzLKNLPAHP8V5bJXbQD/WS9oU2Yw9fvG
/v2TTPOHXD+ZIAYIzsj2tqHq7uV1ewc=
=QupT
-----END PGP SIGNATURE-----

--I4T+5pQI7FxN+CfM--
