Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5ACCAC59B
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 18:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 178BD83236;
	Tue, 16 Sep 2025 20:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YtQSP5Vj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C9748323A; Tue, 16 Sep 2025 20:33:00 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF2CC81E13
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 20:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-331d60b0a37so885958fac.0
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758047576; x=1758652376; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N0b2amVxi764Kfoau/7F4SXqO3GJQ/okBID4gYAnzI0=;
 b=YtQSP5VjPpjUv2acKZsDglHeHlrMWectAC4R2VZg/IDn5+LjR5pBnkgtS2rJxDpS3W
 KUlITV5U0Fk0EptCjHknsDtBLZ7SVtzLPhtFK7NfLnHCntTN3mC2/Ug3zp5gyBhaOaiP
 B8FyvvdKV924gx7m1D0JyzAf/skH0jL4qn/LM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758047576; x=1758652376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0b2amVxi764Kfoau/7F4SXqO3GJQ/okBID4gYAnzI0=;
 b=A6vCemkrRMeUVWPlUJCZNl3G4oZCL4h9cn/PcLMxUtpMUYcWiq+Hm8D3dt9Daa+5N9
 Er0RQHKfEvJe5McMsy5hRcU3BOPyaSK8xUxcg8mceE9NudCYhfIWT47Yv1Vzxk/i7f5U
 w67ivczf1xAf82gVPRgtETpK6lOeD/K+7Ph4a1h7mZMvHmqexTE+4vXifZIdoFlvsvlL
 v4mulBS7ly2lS4l/j7ZZ5irUW5TUXIKUHzwk4190SHeuZ9QR/P0TwwsRP5BiKjBXzfqo
 wDkI3Uu+qYdxFzLF35Bk4m4kFa4me0LIwletudOkYquKLEILjGNMvTNbfmcyRx24/QAW
 39GQ==
X-Gm-Message-State: AOJu0YykROqYtrb4QC7ioaNOd4C1QFzcfjYvHMfFEi2OmIX9TfDK3+iH
 TD+eZz//206m/uggQgEntkwK9UFll+Jnx4mEW4kGhU7+vSNaQT/r2dwba0MRxe97GbU=
X-Gm-Gg: ASbGncu10ot7QpVkR/1n6SFJAdqWCPFdKDUwPiVwG59gO3mxxn1I0ca5rmp0lL8Zk6n
 +XCF/28jaEve2raBlKbm4lp5Zgvs8Km25lWvmGbMIMHf2JD3G0d9IVY9L2LaCLBnFbLiQKGDyaN
 MfK3Bx04opqAPaR6Pei8rM+FyEiWwzQEDQbFhXIGlHLCQ4llXvevNWbnN3itS9KA4+9GyZC6pL/
 zEn0yB8Hvg39JAwBB/bDTPPww60GtVPMYcfsxd5Uz4IWWUsdL3sPSysgL00LDZf5hBhPPiMrSPE
 skBLRnOkTdSKr5D7mlg9cncfbZeNhagHyeCpNBBv2ttGrkFOCxy47JTuTZsUZzXmGGd7ox/cxSo
 TtSxDhtnDP5urcX3uHv8SFUmHjq9lXNPGpxn2zFK+q1qivCNSswxrFUUC
X-Google-Smtp-Source: AGHT+IGp9Q61LvGlhA1KpFdYP2KTKZ7zPkaOG1nL0f6IDrdVJtQT8TJL416aMvJ/iuNY3iZfqXftrQ==
X-Received: by 2002:a05:6870:718a:b0:315:6c17:e881 with SMTP id
 586e51a60fabf-32e567d1495mr8651042fac.23.1758047576620; 
 Tue, 16 Sep 2025 11:32:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-75c5c0c1908sm705875a34.32.2025.09.16.11.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:32:55 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:32:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com,
 kever.yang@rock-chips.com, hl@rock-chips.com, tim@feathertop.org,
 marek.vasut+renesas@mailbox.org
Subject: Re: [PATCH v1 3/8] spl: mmc: split spl_mmc_do_fs_boot into
 regular/os_boot
Message-ID: <20250916183253.GC124814@bill-the-cat>
References: <20250916105857.163951-1-anshuld@ti.com>
 <20250916105857.163951-4-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sEQC7BJOgYeP04UN"
Content-Disposition: inline
In-Reply-To: <20250916105857.163951-4-anshuld@ti.com>
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


--sEQC7BJOgYeP04UN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 04:28:51PM +0530, Anshul Dalal wrote:

> Currently the logic to handle falcon mode as well as the regular boot is
> inside spl_mmc_do_fs_boot, this prevents us from cleanly extending
> falcon mode functionality like toggleable fallback to U-Boot proper.
>=20
> Therefore this patch splits the logic into spl_mmc_fs_load and
> spl_mmc_fs_load_os to handle the regular boot and falcon mode use case.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
[snip]
> +		printf("%s, Failed to load falcon payload: %d\n", __func__,
> +		       ret);
> +		printf("Fallback to U-Boot\n");

These are new. Do we really need to be adding them?

--=20
Tom

--sEQC7BJOgYeP04UN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMmtVQAKCRAr4qD1Cr/k
CsATAQCvSDK9wsydPB7ft5bOujN8UPY3zP26K9zYiGMIpayg+AD/XJu60t3xa2ed
PCX/6cobxRxQ30I1ZcU+wa/yDQ8JzQQ=
=1rWb
-----END PGP SIGNATURE-----

--sEQC7BJOgYeP04UN--
