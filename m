Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F7DCAC5B1
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 14:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A648980107;
	Thu, 25 Sep 2025 16:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CRpsNCi5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E8A5809A5; Thu, 25 Sep 2025 16:18:56 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CAB0800D7
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 16:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-30cce892b7dso669881fac.1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758809933; x=1759414733; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4Mj6H7zX7T6rbhN8mWbnjoD2VETQ82G0hcDBOrFuBAE=;
 b=CRpsNCi5AV/1g+EGWI6qZfVkUixT7kwgcyhxa72N5iqNsnSfpLWmG2jW/jFNiO3H8w
 UMKLp8rrLq50g5V0WnZZ5S8D+C0f0IsWiVjfdj1tMVo0BgJ54DkNVoUXM7EiXmjaschF
 GHnu8vAhf8DlTVpSobIiAkjq8bQVyqMv0JMG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758809933; x=1759414733;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Mj6H7zX7T6rbhN8mWbnjoD2VETQ82G0hcDBOrFuBAE=;
 b=Rfi2kJvWeV0tMQSMFvbrAY8LGms/oxlo/PwocSJe7oHq4C1DeKWJNdIYViTGjaA6Gs
 WbYToKLLA0Yv8L4Ny6kSpo+6sM+obAQ0wGLEOJgsICIM++3HuGUobNtVydWPbOhl6ckX
 QPxdxViYICFGaH2qL+nw/SI16Gqrj5RyJpPEekXXyWe5qla/5TmmT8nRMmXK6wSM2B/Q
 rBoE5p72bWvoBut6i4PsaVt2mPDAsEkKz3tqdQJSQ861bsDqwMcH+oA+XrBfjGhLBAXb
 NwwdFIfZ1/MFyrZI7AcJkOoy7iWm1K3Z5OTIyk4E7prJJ5s/XuxEbuk7izQ8p2ukT96O
 QzXA==
X-Gm-Message-State: AOJu0Yx6kWFuSK6X2HKkfI0hUpuOxhht2Y9sNmyIFScAjZdFRe6SYtfj
 3Onj2jOYsP0tH57mMfXglm+LVP/EPVJ5tsazMIPVopt4wanw4IMId4CGx1diFXIwSHA=
X-Gm-Gg: ASbGncsrfRihl+GuXe2xmXGaqrwEmAC9GtAxmKyTd/tdwSr02U1cWEr6ZgXHxmYCpCl
 C/zjNdc3xJsgYfEDQxbsMJPwlEo8+sjux0QvuoeJapLfB/lVinHrZfPch9TsljT56Q0oKJT2JEm
 ZbrXDex09NPTBy6npdALwiYsABH8a1/tQ40sS5SKNSkmnvEtRrNMFL4RAq2t5dFAJIbUJKf9KH9
 n9NgRzazUrAEqVCjwR2ASqpbO2+bL9YQgFfSwIyVx0MPPu9JBuC1XAz2VF/K6b+GcK5NlTZytyw
 9seH/kVNK3Z0IPlJK9YMp+MeuhRmH/0AJgwDqLdvZoV5UNxELM7l7eiq9taMubADGd5+f5bx3mT
 I/guOnH0TI+a2mCuQnRvd3mTTkx56/AeINZcfZOcpxJWoEig7pq4LnS89
X-Google-Smtp-Source: AGHT+IGq5be/fDcpDnwed3TQD3XXTyEM5aA71wrMH8xgWzp4qo6rUqd+UwnkfZl2r9t0Nq40g5LDcA==
X-Received: by 2002:a05:6871:341f:b0:315:7fe7:40a9 with SMTP id
 586e51a60fabf-35ee8f14026mr2063429fac.29.1758809932921; 
 Thu, 25 Sep 2025 07:18:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a233315ea9sm431073a34.11.2025.09.25.07.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 07:18:51 -0700 (PDT)
Date: Thu, 25 Sep 2025 08:18:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 Ezra Buehler <ezra.buehler@husqvarnagroup.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Peter Robinson <pbrobinson@gmail.com>, Stefan Roese <sr@denx.de>,
 Thomas Chou <thomas@wytron.com.tw>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v7 2/5] bootstd: select BLK rather than depending on it
Message-ID: <20250925141849.GM197373@bill-the-cat>
References: <20250925002308.2825164-1-sjg@u-boot.org>
 <20250925002308.2825164-3-sjg@u-boot.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0UhDLv8TKKpXqCuM"
Content-Disposition: inline
In-Reply-To: <20250925002308.2825164-3-sjg@u-boot.org>
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


--0UhDLv8TKKpXqCuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 06:23:01PM -0600, Simon Glass wrote:

> From: Simon Glass <sjg@chromium.org>
>=20
> With recent changes to how BLK works, we must use 'select' to enable the
> BLK feature, which is currently required by BOOTSTD.
>=20
> This fixes the following error:
>=20
>     GEN     Makefile
>   scripts/kconfig/conf  --syncconfig Kconfig
>   boot/Kconfig:496:error: recursive dependency detected!
>   boot/Kconfig:496:	symbol BOOTSTD_DEFAULTS depends on BOOTSTD
>   boot/Kconfig:441:	symbol BOOTSTD default is visible depending on BLK
>   drivers/block/Kconfig:1:	symbol BLK is selected by USB
>   drivers/usb/Kconfig:1:	symbol USB is selected by BOOTSTD_DEFAULTS
>=20
> Disable BOOTSTD for the boards which don't have enough space or some
> other problem:
>=20
>   zynq_cse_nand
>   zynq_cse_nor
>   zynq_cse_qspi
>   gardena-smart-gateway-mt7688
>   10m50
>   3c120
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This is the wrong direction. Please instead get the dependencies correct
in the next patch. You're likely missing some conditionals on the
selects you add as bootstd does not depend on BLK.

--=20
Tom

--0UhDLv8TKKpXqCuM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNVPRQAKCRAr4qD1Cr/k
CrUtAQCWy/Z4UIE2vuJOUO+dAkWVWKEqa2ewSjlYItXOdBgLrAEA2bVITfR5AIuN
oQyywE90ysRtCeysn3vhZbw+s/dtJg0=
=C2Ec
-----END PGP SIGNATURE-----

--0UhDLv8TKKpXqCuM--
