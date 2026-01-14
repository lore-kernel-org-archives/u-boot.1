Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A98D37E39
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD89E82C7F;
	Wed, 14 Jan 2026 15:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sBi/sbal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D86B83655; Wed, 14 Jan 2026 15:49:24 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A6AC8063E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7cfccba483eso229151a34.0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768402161; x=1769006961; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KEPuMG0MTjPWlgqjDOb6YT78oLYnAEJmNPmYiYLzYn0=;
 b=sBi/sbalj7aT1jbnAXZiamiEwqUhxng7iPHQ18kWvLcingdgzx4qkCqT1TOU1eh5Pv
 KDFWNSMDoHqz/OQTWHRvNlFjBStB+aeqWhipEhvF6LXYqbixFwqHWXWFlqiJnfcDNhlg
 OM3V7lHgS0IoM1Lvw629xM2xUwvVqeQkzGE6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768402161; x=1769006961;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KEPuMG0MTjPWlgqjDOb6YT78oLYnAEJmNPmYiYLzYn0=;
 b=bYdzY3RczHw/g2Wb0ujGiPZwzqQ1WjwNgyp/19dhZgQSVblUFL1pJEnQgzIVVERy4h
 HpEXeULFZNyeuBJI9/jdDqnQWpogXeysPSg/CCg4ISKy5dlcKEvMoUeypsMO/i/i1k4g
 zA+8wjS606jusDMdIWCygzzXNJ0SW3QoMxkOqoSydg7A7cVdtQOz5X9c7HkZMD21uRuJ
 oa3jav5b1gITUB8VLj2iggbcl1a4pI2NTioYepWNyjfIN5bb7d2TnTZXBcqgN1fEcYcn
 2koPZY8tnriszJfjnjEoAzl1ZfaVMqap1aNpSYxFUQS49F/xX+Bghfdiz7eYOAJuJMzs
 1PTQ==
X-Gm-Message-State: AOJu0YylEd9QrH4j1Cew9YIHWKW78+PtUuHa0fWVsnl4C9UmHkDvWWa7
 VTkQQum81Iw27Ui0K3tiHFOygRzLUmwxTgBr1Jmz5bDPF/ykdtfLc6Kix4/25GamOHM=
X-Gm-Gg: AY/fxX5pLYMR7zTFNo8lI0cnWx5lXXEhZFX9kc9MYWTbdlYgNjKlp5USx6jUnHzgClc
 LbfZ5J/cKrcGwl2V0v+G1iPeLMpTmUs6vvcriOai2fAOAgPlyemwKvmrSUo38/7xnCf1hud9U5r
 bEsz8ISn2/9BSOBZ0Vzy4EQgX1n9vCuBNyGvOp57mMrbSOCfKrEg8y6q8nZNM4bk1oBz/5/XclV
 5vF0fBNQKDFeK9MY/HVjzKvW/707zseSN5ajdfBjUUFCFk+F/bpgfGBNwZJm0mC0CF6F16JlEZm
 LjxGDQYn14pKGSdSa7lNXLNcam/OGN8D43KTAQOx+opMh3pqqXXtWBbcFhh6G4AbS499zv/dQQ+
 zr+7c6mxvItuTLI50OYjqBUX00OJETXPdWVTMEooE+T9zMa14qPndp5sN7KJTHyrzV0pIWCXeZh
 B1Cs0B7p1+rz5JxnNGV8QCOGCVXUFao+X0LQgT6NA+sw0zLhDMXlTg3RHVIjnv1iHF0tHOEbc+c
 D4OpIUgYJtQ0MYRF2mCMsxpI8rwmJ9y9phSxeZhDBkgKzcmZA==
X-Received: by 2002:a05:6830:254c:b0:7c7:1c87:4f95 with SMTP id
 46e09a7af769-7cfcb5830f8mr1717167a34.4.1768402161047; 
 Wed, 14 Jan 2026 06:49:21 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478af6efsm17861448a34.18.2026.01.14.06.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 06:49:20 -0800 (PST)
Date: Wed, 14 Jan 2026 08:49:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 thomas.petazzoni@bootlin.com, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH] fwu-mdata: Allow multiple metadata storage drivers to be
 enabled
Message-ID: <20260114144918.GC3416603@bill-the-cat>
References: <20260114095654.736511-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="STcbprC1uinxQiHj"
Content-Disposition: inline
In-Reply-To: <20260114095654.736511-1-kory.maincent@bootlin.com>
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


--STcbprC1uinxQiHj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 10:56:53AM +0100, Kory Maincent wrote:

> Change the Kconfig from a "choice" to a conditional block, allowing
> multiple FWU metadata storage drivers to be selected simultaneously
> instead of being mutually exclusive.
>=20
> This enables systems with FWU metadata on different storage types
> (e.g., both GPT-partitioned block devices and MTD devices) to have
> both drivers compiled in. The board can then select the appropriate
> driver at runtime based on the devicetree description.
>=20
> The change converts FWU_MDATA to a menuconfig and replaces the
> "choice/endchoice" block with "if FWU_MDATA/endif", making
> FWU_MDATA_GPT_BLK default to 'y' for backward compatibility.
>=20
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--STcbprC1uinxQiHj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWes7gAKCRAr4qD1Cr/k
CoPoAQD2sHqhFFJyKFvF1kyM/WpXH/YZuBSDX0ppztv9EzB6hQEAyOUmDarkdrbs
9LVtzMYmciIVUheq/HNd+hUbFk95egA=
=BDoM
-----END PGP SIGNATURE-----

--STcbprC1uinxQiHj--
