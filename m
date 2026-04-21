Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4AEF8FA90
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1C184309;
	Tue, 21 Apr 2026 17:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hNnNCae1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA186842C7; Tue, 21 Apr 2026 17:04:14 +0200 (CEST)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3B8B83BC8
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7dbb89ab229so4106122a34.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776783850; x=1777388650; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hUZCC1jm+X4Zh2s22q9kEiQ10SUPEazDx7UYJiAJLk4=;
 b=hNnNCae1lgHrXMURbcCOXdk9Qr5tppccdsC+MQUp4cysW561fvo+dBUqAuouToh5pQ
 2I6igr0xLH4irK+bOK4XPNr+hcx1IOWgjGVGur/9jLhPQ9pGOVFFkL4aLQ/BUA0peNr9
 +RXPyDqz9oVLSb+vFBuNhi4hSfm/G7UtmBVv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776783850; x=1777388650;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hUZCC1jm+X4Zh2s22q9kEiQ10SUPEazDx7UYJiAJLk4=;
 b=ljd2y+lFGuk882D5PEFCsvOpYw/A8dRvn9y/bngeJswp0Wk2+szT7+41bKodaz83aW
 fO0swvfVasyLfjJ1y0vV7WPec7JApjNhsFx4vOiVozng6H1jny/rjUamQfhuoQbntfjU
 nA6PnlXg5pZ8KHo6cVnPDZDigJ5WjykuWM8UZPPJzBu3O3eU0lTNZpwtAA0YdsIMAt6n
 wQVMwqw/my4aa7894zEL/uJM7Mu9A4XGnKpX6j14CHjbOVLTCJ9h+1bMrHDdWXN21Cib
 UOmf0+tblbNfILengeiUX6Fc9FgMe9bgXjbjukgRsyyKUOE+CnJ6zqTPZ1DMAPXe3hmE
 q3Qw==
X-Gm-Message-State: AOJu0YwGnlGjjKPBqU6sdm2PTG3eAn+HvPnGSji8SqSGoc+NgOiqkRGp
 KAb8xWNExPeQFfZzJLaYcN3zqF1gy2Fzt6vL63p2xVtxRtPBmlwAJLw/1M993QD14X0=
X-Gm-Gg: AeBDieuFSvs2wNbSihQ8KB/9nyvd+xGhd9NasbI8L/5oIXms+HSMPugsM+kcW1K4L8y
 hrAw+RCAzRHpBKVhKf5CKCbV8mPgjHDN9j275ApF97qygSLnTWbFwT32EvqaTUUTFSwg96UGrF2
 H+UEVkTN3+NJ+dLGsZqBkLhpna+li8goaE9dmHocMR9lD1r3NbYrZEaubW3dOqRpOXa6Dt5SeFS
 SqIbYEwlip4ZOpF7GE0QZKlWIiHE5YKwqUz6a70Ddk6/ioqaxwLC/AXf5wHjBO2vCwFyCkn7BAk
 +yyuPZ66FHM59rGv08k2aJPD91rj9rWiXujUVHEa0wkeEAUmQad+2qkSXHI0FOrd7MSnxs3cZ1V
 Hhr5coW5OVI2yIx0NChHc2IkMbt2b7Q+6rd3xAU0jBc8OdD7VuQNGFOovOVlT4qYdKVJqKdhSRL
 R+I1ZEwgZ70PPWMyinn+QquZVY6V3mREju9NW13R/PmeXIIoGENG5mlOGdy6SfRTQpbsuRb1Yrp
 SytkgHDBC3P4yHC0GkillL7P6yQaHqs5r8jOmvRaz6W0awnkrolCDGnbw+/bw==
X-Received: by 2002:a05:6830:8292:b0:7d7:ef4a:5ba0 with SMTP id
 46e09a7af769-7dc950f996bmr12466595a34.12.1776783849666; 
 Tue, 21 Apr 2026 08:04:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dcd56bd0e4sm3074792a34.2.2026.04.21.08.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:04:08 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:04:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 5/6] fdtdec: apply DT overlays from bloblist
Message-ID: <20260421150406.GG3036003@bill-the-cat>
References: <20250718141621.3147633-1-raymond.mao@linaro.org>
 <20250718141621.3147633-6-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sMs0gwqANjNM/RpU"
Content-Disposition: inline
In-Reply-To: <20250718141621.3147633-6-raymond.mao@linaro.org>
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


--sMs0gwqANjNM/RpU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 07:16:18AM -0700, Raymond Mao wrote:

> During FDT setup, apply all existing DT overlays from the bloblist
> to the base FDT if bloblist is being used for handoff from previous
> boot stage.
> According to the Firmware Handoff spec update to support DT overlay [1],
> an overlay must have the same top-level compatible string as its target
> base DT has.
> Before applying the overlays, check whether sufficient space is
> reserved in the base DT blob, if not, resize the blob to the allowed
> padded size, which is limited by CONFIG_SYS_FDT_PAD and the bloblist
> spare space size.
> After all overlays are applied, resize the merged DT to its actual size.
>=20
> [1] Add Transfer Entry for Devicetree Overlay
> https://github.com/FirmwareHandoff/firmware_handoff/pull/74
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--sMs0gwqANjNM/RpU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaeeR5QAKCRAr4qD1Cr/k
CkeeAP9WtZ1JZenGMrT0UfOQK3GLMjrd9CD3Hq1S+KzcGmE1zgEAjFbmYqUCVPks
X7FrzXFe6jGa6PDqXmYqDAegNnutwQk=
=icbo
-----END PGP SIGNATURE-----

--sMs0gwqANjNM/RpU--
