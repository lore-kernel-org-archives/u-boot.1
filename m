Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07041C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 21:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF156874FB;
	Thu,  9 Nov 2023 22:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ex4z5CwM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE1A887015; Thu,  9 Nov 2023 22:22:52 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8639087015
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 22:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-41ccd38eaa5so11687011cf.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 13:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699564969; x=1700169769; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jshgu73E+yAjWOr2zziyGA3DXzDaUM160ulX/xgRUsU=;
 b=ex4z5CwMXJ1V1+hHb/RN8B5joEeFgFOzO0iYr2GSNlUgs+hMXzTP8HhbwCR/HW0wXZ
 /8xHmgNkG66thZNXafw+H/a7Z0YnKVo0eY7DoaGqWvnPjjVb+KbVtq5He4Sa9X2LJoja
 84yahylFr7t3k6T+xcisTVVEO1KRSDIhjBHRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699564969; x=1700169769;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jshgu73E+yAjWOr2zziyGA3DXzDaUM160ulX/xgRUsU=;
 b=Np9mo9K8Jjtt5GcH5FHqROZMeh+edzxo6Vo4+RaZ/jXf/OlVFzQ9S9h8Wzu3DU/gZ6
 xUuwr3LUbeWGb7TXJM9ug9VCljoMSg1Lcc7Xg5Sj/Gu4uX1yIKlx3L/PfKPONDhAcl1o
 7ZrxJH270kSvDCf/Y3wdoCkVJyYuiAIFWjGtQ8wjw4BJIgKHcqEQ1V/rL3nH+dvR7oHc
 QY2FePFb6DO4/mRdj/Cy0qYDvfyi3vBNUgvbYXOs4x8J15EAEMMl7JRaNSFmxNs/+TjH
 czO83bCZBjL0QeR381U5T0lf4DjVCroSYT9KKLR2VIu637fuc0gO3YBMZzv+47HvWiCF
 TG3Q==
X-Gm-Message-State: AOJu0YyzZG7ikNSe9DpzdECYFY36Uoj6t2dL2Otx3hnDeyosRWSGATMs
 2NckCi9eQ6rLajRBu6w7Vs1bLg==
X-Google-Smtp-Source: AGHT+IHgxjzVqTQb2Y/z/ILo3RlQq6OfNxpJkesxp/Es6e47q5JxHAwuF8nGVYqQh0GzndbLZc1/yw==
X-Received: by 2002:ac8:5908:0:b0:41e:7f76:57ec with SMTP id
 8-20020ac85908000000b0041e7f7657ecmr725798qty.15.1699564969307; 
 Thu, 09 Nov 2023 13:22:49 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 i21-20020ac860d5000000b0041ea965dcd9sm2255918qtm.69.2023.11.09.13.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 13:22:48 -0800 (PST)
Date: Thu, 9 Nov 2023 16:22:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 1/6] env: allow to copy value from default environment
 into a buffer
Message-ID: <20231109212246.GK6601@bill-the-cat>
References: <20231108-env_default_theobroma-v1-0-cb493bfdeffd@theobroma-systems.com>
 <20231108-env_default_theobroma-v1-1-cb493bfdeffd@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u2Y5ZAvq9OVfr5Xw"
Content-Disposition: inline
In-Reply-To: <20231108-env_default_theobroma-v1-1-cb493bfdeffd@theobroma-systems.com>
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


--u2Y5ZAvq9OVfr5Xw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 03:20:30PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>=20
> env_get_default suffers from a particular issue int that it can only
> return a value truncated to gd->env_buf (32) characters. This may be
> enough for most variables but it isn't for others, so let's allow users
> to provide a preallocated buffer to copy the value into instead,
> allowing for more control, though it'll still be truncated if the value
> size is bigger than the preallocated buffer.
>=20
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--u2Y5ZAvq9OVfr5Xw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVNTaMACgkQFHw5/5Y0
tyxBMgv+KxSM+NJQRJTJTRoPCU/mS9cUQznidJgyVpZUuUGhjZ+09rg5ZgT3k+nT
Hl9LnxAB4Fshen0XmfZFBe3k2AGh1pb8wBKn7rw1NIXLRUXcJyGJNG1g1Dv7+hSv
X8McaMDdb2h68eNZgTLm3fVyEgFRF5/mJF7uqNtZO9yheV32eYh/p/AFxYpv/gf6
XthcPpVbmQe4V6t038f0zu+FVRSSeeougLmVwsRk2vMj06pAPz8JMBHXDFduh/jp
q2ZjDUo+JL1MMnH7+z5S0zX8oH7TvK+wmsG3zBEF1q/KLtKdqUwqjr8ggYEcjk/9
WMeBXsk4yYjqQBDCPy0BbtIwxw+yBnsydVspUCvLbt9pTEh3kTY4NzzIv+227NXR
6dkCQPIDxaHrnPzjV6085SeWsyvFGn9bTrmWfpIvSo657cTGhg8trF5PcNCb8Gbq
G1xrILEZy0Cwoae/1N9c08ls12QDP22yl31S2B2Aez76ScmuNDQWJ+vgoD4197HG
2vA1Y5qS
=gyN1
-----END PGP SIGNATURE-----

--u2Y5ZAvq9OVfr5Xw--
