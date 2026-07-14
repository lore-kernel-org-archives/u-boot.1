Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD53C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 01:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ED8D84C85;
	Tue, 14 Jul 2026 03:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="shcfHf6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E9F984CA1; Tue, 14 Jul 2026 03:53:31 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED55984B51
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 03:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e9f829d75aso357025a34.0
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 18:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783994007; x=1784598807; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n77av5TNyFyiYUhXippPSb9OFf8Gck6gs1RSHr2qK0k=;
 b=shcfHf6UYIzvhjgMzZKklORpj+KRqmarcq8lfrlV+bMjkfYzaGq1cSR5Ce+vbupVBs
 u9sJp8zRfg/FF//JkpKyBDU8WsiRYhzjfPdp2WIc9UNzMPqHFYByROpi1wnDn1nXFLYi
 cUbF44aYa+Tb4d6yoyWJIS7yPko5m2gU0MqEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783994007; x=1784598807;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n77av5TNyFyiYUhXippPSb9OFf8Gck6gs1RSHr2qK0k=;
 b=Cn6qgchDx5GEc+wCqi9uAx6f8KxFA7GG1YAnFKYA6Ik+usY1pbn4/+172V583j/TIz
 nebrjCpwDZJbJlpj8hHbqGXvz5M+l/Bn0OFB36XyqKgegqQCSp6Vr8dnAeVWqYMG+PtB
 /s/dY9lND2SYLwWyysrfJuV+7fV0q5+L7fN47pxGJOUnasts0Wf+WTXAs4MTxTl8WIQC
 eltsHa31RrfQxM+XIgceTrbxh28nfrnn+PDUtx2HaqVqkC5q/5QSJyC1tJuvBKOtK+c0
 I1mv5aGNrF2A4K26vPr65WniQSE4gYtwPipD+xuCKmchpur4kmZT56EAL5Mzv2a9hGHe
 zobQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fuvXC5wKFd7qyZA85DErnM6/yp+PXHMU2gPpNf8dxRNbf51ngPAWwKY/hSHx7gDpOjL4RzPE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywtl8ydTWCXMs8/fmuhwS0FE9uPEnZuIPB/6LaCP5m2xk5EKxuU
 yuxKZacxIC60w392bcb13WCa77SdTR4K9w1lUoDKcWGCcYs+zIuB48TZ7SuV0kNXEbw=
X-Gm-Gg: AfdE7cmRs6HK2Nbz7y7d6NEfiEDSKf8tDJFZJAvQ5sHdWsvFbcVm+dvMGZz3o5y+Q7J
 qKkYn+E/FXbiOqK6858khaX6kZK5b0XU3kamliAB2MjBvvT8tfRSH5jbYocWRWeEnHYgwLNW3PV
 xTtDWNHi/udZZb1Qje/o+5w0Y+6m65v9MOmA7looFFp1Ajy95xVJpLJhtDXTA4MyUcc+LlCypjO
 dmDjuPWj4RdczupeRmnnf4ERqfyCDZB1Ybk+y/Oa3bk4GQom8zEFYuObAlgZJeBjjBnLnjLRCct
 AGxnN93NR6qTp3W6n5l9P4INkLosF66pmbQCyPmbtD2grLu/pNNp9wLm6SKnti1Xs9L+HKYVwsa
 EYHhXnMm5apeKDoO+D1fpKQbR3XL37SKZxbk/ZBhPh19dLnre2XE1AKeTPUwD+c4cCk9S4FHuxO
 m3rbtJ4xk5yw9FMAlstlqBYBTCJNvbe1Qpy7cDkdZFzZcwtN0TnSBNS0JhPWGQ8O+2POxQ/ZHIp
 0UjZSpm99ADByt5DC+PGX7FslX6xQd3Vd2VGQ==
X-Received: by 2002:a05:6830:370c:b0:7e9:d634:77b8 with SMTP id
 46e09a7af769-7ec096027b6mr7130086a34.2.1783994007588; 
 Mon, 13 Jul 2026 18:53:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcafdf8f2sm14195145a34.11.2026.07.13.18.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 18:53:26 -0700 (PDT)
Date: Mon, 13 Jul 2026 19:53:24 -0600
From: Tom Rini <trini@konsulko.com>
To: "Jacky.Cao@sony.com" <Jacky.Cao@sony.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "nora.schiffer@ew.tq-group.com" <nora.schiffer@ew.tq-group.com>,
 "Steffen.Doster@tq-group.com" <Steffen.Doster@tq-group.com>,
 "alexander.feilke@ew.tq-group.com" <alexander.feilke@ew.tq-group.com>,
 "Max.Merchel@ew.tq-group.com" <Max.Merchel@ew.tq-group.com>
Subject: Re: [PATCH v1] env: Fix compile error for envtools
Message-ID: <20260714015324.GZ749385@bill-the-cat>
References: <20260713083141.2772971-1-Jacky.Cao@sony.com>
 <MRWPR04MB1233021A0AF8D2117DBE5984888FA2@MRWPR04MB12330.eurprd04.prod.outlook.com>
 <KL1PR04MB6734F919E17C467C8B29DBD787F92@KL1PR04MB6734.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OYxY2slXZErklE9R"
Content-Disposition: inline
In-Reply-To: <KL1PR04MB6734F919E17C467C8B29DBD787F92@KL1PR04MB6734.apcprd04.prod.outlook.com>
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


--OYxY2slXZErklE9R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 01:35:42AM +0000, Jacky.Cao@sony.com wrote:
> >> Following error happens when build envtools for mx6qsabrelite.
> >>=20
> >> $ make tools envtools
> >>   UPD     include/generated/timestamp_autogenerated.h
> >>   HOSTCC  tools/printinitialenv
> >>   GENENV  u-boot-initial-env
> >>   COPY    tools/version.h
> >>   HOSTCC  tools/env/crc32.o
> >>   HOSTCC  tools/env/ctype.o
> >>   HOSTCC  tools/env/env_attr.o
> >>   HOSTCC  tools/env/env_flags.o
> >> In file included from ./arch/arm/include/asm/mach-imx/regs-lcdif.h:16,
> >>                  from ./arch/arm/include/asm/arch/imx-regs.h:371,
> >>                  from include/configs/mx6_common.h:21,
> >>                  from include/configs/nitrogen6x.h:13,
> >>                  from include/config.h:3,
> >>                  from include/env.h:12,
> >>                  from tools/env/../../env/flags.c:7,
> >>                  from tools/env/env_flags.c:1:
> >> ./arch/arm/include/asm/mach-imx/regs-common.h:51:9: error:
> >> unknown type name 'uint8_t'
> >
> >"#include <linux/types.h>" was already in
> >arch/arm/include/asm/mach-imx/regs-common.h
> >
> >Are u using an old tree?
>=20
> I use master branch of OSS u-boot repo and meet the issue with
> below commands:
>=20
> make mx6qsabrelite_defconfig
> make -j8
> make tools envtools

What host distribution are you building on? And, <config.h> *must* come
first in the include list, for it to function correctly.

--=20
Tom

--OYxY2slXZErklE9R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalWWkAAKCRAr4qD1Cr/k
CvTBAP49/6PF0gZF2IudXVnrTLozfFawVMO6pHAHsEcXmP1G/AD/ZLfKdd/BNrGb
8/JxNpPs2umAW5iHwUm+P7m6YfByjQs=
=ngx8
-----END PGP SIGNATURE-----

--OYxY2slXZErklE9R--
