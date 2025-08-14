Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C9FCA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 17:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 448B383A15;
	Thu, 14 Aug 2025 19:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VDnHBt7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2705A83980; Thu, 14 Aug 2025 19:50:55 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 168F783A15
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 19:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-88432ccff13so31433539f.0
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 10:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755193852; x=1755798652; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yIjVKeM/+3Qh9RU1pVLaB70/qHANZkLxjMBTQP0r+po=;
 b=VDnHBt7Wa16H9BMJa0WILF9MqdiQMVB5ko1t8MwQthXzQw/DMQWEFAESNpCpcToYb/
 06L8uTqiW4Q0WfUbfAjaf1PPylClZxTBh0j+oc3JHjVn1tPmoHE5qzw0IdrnbE178edU
 VOQ5GUTPdpTnGsm4ME8xRkWS14ShnJ4i7ljFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755193852; x=1755798652;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIjVKeM/+3Qh9RU1pVLaB70/qHANZkLxjMBTQP0r+po=;
 b=op8kwCw6GV1pmM2PM6ZwoxQzTNAC8dfT71dD0XI+4BqVs885niWarG2UjEztO0uRWp
 hRAmnqxBvC9b0RmmXhEcX60yJdsAEcbOkybj0ogBd1nkmsVhAp8XKNMk0k2VAHNbZO6V
 NTIRCLlbhTyxz7D/K/mt2UF0xTZHH3mJINCw4nLpm1M0fkRB11pwEONI/GK7XCsE5Jhr
 rYP1oicrdf4d5Tx6zXOnLysDTW0Esa9VRSzn/ePVJ+lsXlgOnx/5dmAiZOMwHuyPJcdi
 WMiobSBfBl29LvuhfqvSH09NfXttzyFkcxOxMMLkFgrQy4UA8A9im9VELprqkOKjxyIM
 aySQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZoyUXm+4LDkzxiG9mIFF/5Kwjw6fRNb+padYLjOyxTNmUbt9QiFurIOfb5ObEAabfhq6BXaI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0kg7qjn1UGgM/O3YYoxLlUYQy3C+S/OkDw+hqSCK8Dqvol86E
 06ft0muz1U4SiJxWQ+ySYFE0uIB+X8510OOX5oD8fJY2hW5uWUhrefXxYiad21DkbuY=
X-Gm-Gg: ASbGnctxUkY533HzBKAvE3NPuniBtPm5ZpUnENXxwSJtxgVk/w3epAx8W0T3713t5bl
 OcBryjohF+1sOU8D8A7Eka4dwKFhmmz5MIpRuvp7sxzI0BwsiOdbdlcKVFj/2BbRaNWUmkp7jU2
 71OKC9gJWrFbL6LMG8CUciYcIvtgb89FiZ0M2C06KcSEob5TptNeLe8dcmnKuKAxygu3W71EZFX
 EAkqhWMbulopFa//gdIY5mZ5TYCEF7p0nUEyaE5z3PxqFrHBnvZ4mVmVHRWhVs1CQTOEEbDrO5Z
 RhBesq6NnvtIN2Xy9YiYSvpFs5GIp1KEflmPL1LNaS/N9hOSmH2wtebqhd04gn6R6dIc2YVluCU
 U2u2rwxYe5Da3eXYwPoby6dkMHue1834FlbkvPvVcykYOhGkHIJvKjBeX
X-Google-Smtp-Source: AGHT+IG0h7ckhQXJgQ1r5CfQstnsqCHfU2Lg7MR8EvwKW+MwwRWqkknCVMROBAT4jSThGmU1fdqRXw==
X-Received: by 2002:a05:6602:480d:b0:879:26b0:1cca with SMTP id
 ca18e2360f4ac-884339e5f00mr769173239f.13.1755193851800; 
 Thu, 14 Aug 2025 10:50:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-883f198f8e7sm531634439f.17.2025.08.14.10.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 10:50:50 -0700 (PDT)
Date: Thu, 14 Aug 2025 11:50:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: tuomas.tynkkynen@iki.fi, jan.kiszka@siemens.com, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl
Subject: Re: [PATCH 1/2] Kconfig: Convert SYS_EARLY_PCI_INIT to Kconfig
Message-ID: <20250814175047.GO124814@bill-the-cat>
References: <20250814165932.1584854-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TWa94OqUdj7jBmSS"
Content-Disposition: inline
In-Reply-To: <20250814165932.1584854-1-festevam@gmail.com>
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


--TWa94OqUdj7jBmSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 01:59:31PM -0300, Fabio Estevam wrote:

> The CONFIG_SYS_EARLY_PCI_INIT symbol is currently not supported
> by Kconfig.
>=20
> Make it a Kconfig symbol so that users could select it via defconfig.
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--TWa94OqUdj7jBmSS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJ4h9wAKCRAr4qD1Cr/k
Cr9IAP9I/oYKlDpTXMTcAqjtBdn/V7dVFPB7YOfVzb8PhJdZtQD/YLhEPNro6Pve
A+VXHoDQZ0Kb17vyGnNW8jdEbtMeng8=
=A5n1
-----END PGP SIGNATURE-----

--TWa94OqUdj7jBmSS--
