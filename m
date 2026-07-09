Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F17C44503
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7314184AB5;
	Thu,  9 Jul 2026 03:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XK0Ltss9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E12DC84AEB; Thu,  9 Jul 2026 03:52:46 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C19FA84994
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 03:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7eb42a2f5feso187066a34.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 18:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783561963; x=1784166763; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YIq/pTtJbPiU6A2Wx7TNFcBkBt2s3SHfa4QkkqfHQOI=;
 b=XK0Ltss9Rpyj4kxIplo9m5WRAbmB05riNIk4aFoRsPKd98nidjW+G5x7uUtNoqEM7Z
 ZkgqZNopruNRDNJ17tK4gbtey3MVEzQ/iOMuHXFGjR9zcO0JN4ioINUuu44S3M8ZtMcH
 tsYc6Qwj0jaMgmL8KVkx9HyRQasKTBQ5CcfjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783561963; x=1784166763;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YIq/pTtJbPiU6A2Wx7TNFcBkBt2s3SHfa4QkkqfHQOI=;
 b=a3MX535wZIfiIQNZOS28XlFoLSRc6eBC/L8xW3pH4cBaT5IUc/MbaeFU26ADSKy7gB
 VrrF+Fx8q95hhE8a9V772PTNgjcRwY4CGwj3/9OR/eQ4Zqe9GV31xoYTQeAdMJyjHTYG
 p/4OoAbjH8bF3CPCGc8t6Y9Iar4RVAdjTschNlas6jf8Fm3KQrcB9UOMawPLL3JQWkar
 sykQk7ZSh1gGmReBioLMdN+0y98+uBDthPGaIEdfgmwm6F1y8Pf2NJj27h4avQ9BbboM
 1lKbOMD9FJzXijnviz/+e+D9U1VCkkG8mtsb50wvb7yKANtMvERlG3sErHyGv6UKIN81
 qEuw==
X-Gm-Message-State: AOJu0YxUCFfuv0xeJT1oEqy/kx+LtyyF/yR6CxTFTKoYgTaIGV64EeZQ
 M3hiPIPF+ymitNVjxVSk/52p43e/KjBewKlIJpNxruUdKUof3/Ec0G0alB3KRPhMyYdBjTPlaSf
 PuRu3EJg=
X-Gm-Gg: AfdE7cl03accl5qoITVnhKBFm/6it9WYFlzsRFosZvTnX4gnsQm9CZ/6RM37ovWseXk
 RX0b64HHCOt51294VvpKLwQ0JSLIVJ7XrlV7GYJg9CluiTWhTslJUqJhHKRO9dgKU4a/Z2tavEl
 oGQYIkyMQ9u/pFKiCCi+qjqoLZO1EQ7MXf5b7mcnFxTlySyr8DKwVE5Rlmr0jDSilQNofhI/dn0
 Se0PPXmjVO6h2baYsHP7XfmzNDpk9emRFdF6DaATxpKeLA8Cj8lssc+d9Xtvd8e7keH1z8SD+Hh
 EMc+E8wfkbWzKiXNfeyMZ3U+8yXGeWncjgxLqXbmM6+phsqx3ux5BYi4EDO203H+CrB7buZ5jzZ
 oqgYoVtJAejrS8B350PufoMnaScFd9q9vzT7Y6qO3Jg12XYiDwu+YdnEZV11zsxsWfFtvXfQC43
 wZoIeNkiXHuzeGIaG7TFb8CGybSmQ2ope8H2r7JMWazxmB0Xn2gzv2o4uyae9d8yxfAZ66mJpOH
 p0wZ6sSBBwdub740KXeQBT45cjVXxFunAEp1A==
X-Received: by 2002:a05:6830:3152:b0:7eb:c792:5091 with SMTP id
 46e09a7af769-7ebcffd9e26mr3352904a34.25.1783561963520; 
 Wed, 08 Jul 2026 18:52:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb2b79c9sm3021428a34.22.2026.07.08.18.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 18:52:42 -0700 (PDT)
Date: Wed, 8 Jul 2026 19:52:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 06/11] Kconfig: Add missing depends on xPL to xPL_ symbols
Message-ID: <20260709015241.GQ749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-7-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zF9veVJOmrXdL1KK"
Content-Disposition: inline
In-Reply-To: <20260708220540.3368825-7-jonas@kwiboo.se>
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


--zF9veVJOmrXdL1KK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 10:05:32PM +0000, Jonas Karlman wrote:

> xPL_<name> symbols should typically depend on the associated xPL symbol.
>=20
> Add missing depends on xPL to xPL_<name> symbols to avoid the xPL_<name>
> symbols being available when the associated xPL symbol is disabled.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  common/Kconfig | 2 ++
>  lib/Kconfig    | 7 ++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)

Did this go through CI? I ask because with SPL/TPL, we have the problem
of PowerPC being special from the rest of the world with these symbols
and I want to be sure everything still is building, before I do a
before/after size check on the series (and probably keep the binaries,
so I can checksum before/after and make sure they're the same).

--=20
Tom

--zF9veVJOmrXdL1KK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak7+6AAKCRAr4qD1Cr/k
ChVHAP97OyIVKKfJiNnbuivTdwBc4jkWphTsibhztYybdeIS1gEA46x1LpkhIdLp
A1QJHVUQOW4nFkaiv1Rt3YPkpiN9jwc=
=VeJf
-----END PGP SIGNATURE-----

--zF9veVJOmrXdL1KK--
