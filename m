Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815A4E8B397
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 18:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2FFA8341A;
	Wed,  4 Feb 2026 19:18:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lPZVW5qR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45FB4839DF; Wed,  4 Feb 2026 19:18:58 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BECF83015
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 19:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so148805f8f.2
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 10:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770229135; x=1770833935; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pRR55caPeh6BNmqb1UMZrCSOKnudi7X57dRclmv4wUw=;
 b=lPZVW5qRDMZDL/+Eymz4qHmeH7hRshzVDyiLPkev6ZiS1EINJsU0CL31CekUTXS8NV
 5nuuwp6+cSe07KhuHJshzEAeuROTIJwWmyQAigA0B3cUKmuICeqaV5EIu5BCkApDjoQB
 XjWT6N9Hag2n54PPqF/Xwx4yo34+SlgaAVdgkzzHEP+FWK/QxYqPLfGnbPEnwJ7+8+WG
 TLAPS+AfrTOnPufr/ofKt20MTcMf2MBvUNbZX55PEwnXthjr98rgwJLEUmxB8+a7SdSF
 P64L8m4DCQHujtPZ+Acq9M/N0lBQhrktsY/bSIFMLs0kH+lBZ7lGrZsv+EovL2BQ2Mzz
 WTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770229135; x=1770833935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pRR55caPeh6BNmqb1UMZrCSOKnudi7X57dRclmv4wUw=;
 b=BcA2FRoCkTGRxBwyIxIR+egjjYfoAYbLhWcIqDPo3jY7lg5K2RGPW/XNXaRQv6EwQK
 gr+n2RBf7Cln9DusiwIec50JDCjZPFnHxX8ZMZH0uLRFTo6a9hvGHBo1W+m3rKSZ4EsQ
 4l+NgAt7hlr0+V6yj3C5QS6v1P2KO337mLwdkxthJ8/0+VERYj1FQ0sG0mu+N0hTijxL
 AiLtITbQtweJQ4rNWV4nCVdISUN1tPzpbQuMyfSyLR8wlxPVh6+8m5Nyg6y0zQPc/ezk
 EVM4yJwFvlHWmk+6qwAU1JiLDZWVpKLwZGDarNNEGnycvVpPsXbNErCMhgbS6+2G8STY
 +OqA==
X-Gm-Message-State: AOJu0Yxfc9ppPu5VCSMM872lp5ZL1I4bEGrjLG8TVhPlKGZcbbEq2jcF
 Cq7+k2o+vBYjl8MSpf6KimGwmvtr3hONvHS+Nj/QSuNuNTEtw56+WPW7MWhg+OQG
X-Gm-Gg: AZuq6aJbwFYXRh+KI6t7UHzMshvJ7xdnlbm43Ce3lggBEVBFgOVqmQ62D5jUAHzLX5B
 Dvcks6fihxEQ0+XtlZsvVCUUmyOWCbrYk3rxRGUgy95mxL6aIGNtkwY5bwj9SaFfxWhByIBT87/
 Q/p279GPuyRGp63E8Rcw4K3oYiB5l+sCATHcHQFzZ2CD8zzI1N8Rky2mX25/gHIH13o+nEMVBLm
 m8zSKwAFuWbTFPiy4Jsp7mwpO5yvlOSFUCFcaRbXf19jWB7CyWxTZXsrCt0oF4e6/MjS9e3JVYR
 dBk05vXWqSa9NSwd5uzwzVJvVuTckeMbfsGzrqP0o212Hi8dQijg/385nLOe+9sLiYCQyTTre8U
 j8A6zXWV4dBJ63yb2/MHY39ls1l+JLBxZmCA5xlgEz7ROscAPGNL/A4mV2drqKs3wNasT/Ubc5s
 IxjLZI1j42EaZr9LIZEOpESsdTRKo47OMN1dA6C94mMCsDYT5/CBE1ZZvW/JDWBGcLzdivF2B1F
 IgPrw==
X-Received: by 2002:a05:6000:240e:b0:435:bbd7:18d8 with SMTP id
 ffacd0b85a97d-43617e3c68dmr5500694f8f.17.1770229135118; 
 Wed, 04 Feb 2026 10:18:55 -0800 (PST)
Received: from jernej-laptop.localnet (178-79-79-213.dynamic.telemach.net.
 [178.79.79.213]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436180640e5sm7261032f8f.40.2026.02.04.10.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 10:18:54 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Paul Kocialkowski <contact@paulk.fr>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>, Paul Kocialkowski <paulk@sys-base.io>,
 Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH v2 3/3] sunxi: a133: dram: Align parameters terminology
 with Allwinner
Date: Wed, 04 Feb 2026 18:36:37 +0100
Message-ID: <2397004.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20260128235727.1322861-3-contact@paulk.fr>
References: <20260128235727.1322861-1-contact@paulk.fr>
 <20260128235727.1322861-3-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne =C4=8Detrtek, 29. januar 2026 ob 00:57:17 Srednjeevropski standardni =
=C4=8Das je Paul Kocialkowski napisal(a):
> There is a mistmatch between Allwinner's dram_para BSP definitions and the
> parameters names in mainline u-boot for TPR1-3. What we call TPR1 is actu=
ally
> MR22 while TPR2 is TPR0 and TPR3 is TPR1. MR22 does get written to the
> corresponding register. This only concerns LPDDR4 support.
>=20
> Introduce a new Kconfig entry for MR22 and proceed with the rename.
> Update the only config currently using it.
>=20
> See the list of parameters from the Allwinner BSP at the end of:
> https://linux-sunxi.org/A133/DRAMC
>=20
> Note that the H616/H6 code is coherent with this new TPR0 definition
> (and does not use TPR1 and MR22).
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> Sponsored-by: MEC Electronics GmbH <https://www.mec.at/>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


