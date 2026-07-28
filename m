Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093F7C53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:55:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C773E810EC;
	Wed, 29 Jul 2026 04:55:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jtpSNcDyz2fg; Wed, 29 Jul 2026 04:55:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4753810F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300957;
	bh=cx+tfMA0WbhiBzlNaNzEIRNBM05xVCifAhC2pWI9r2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1ONSfWyG04pPWSF9pWSnZNNPaTKDlwF47sr15W9NHI78BtP6/tS7PICn+hFf/lbqj
	 XFOpCS75meQj6gwcQE5efZcyOSgSb9Qg7ZeP4V4LS9nFW+iCt2ay5s1oNsqjm1HHtr
	 /Nuyf5U+seQKRjBCuaxfCx6dXdeW2KOqZWzV0wVvNzMYeWStAHJUVjMII3/ch6LWNz
	 Tij+ZaAqJkOfbFjacz1tXlTziFt4M2G3S39lJn/F3skqZwhrqmqAJl/hSxr9BSFzt1
	 +P6UzHP5eirw3LNEDK/7vH9OpYpP4AqXxrdEw1yx/3/WKHYqlC8oaM/fNJAemfNmtP
	 V/p5hVmO+rw8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4753810F9;
	Wed, 29 Jul 2026 04:55:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 44AB4490
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36A0D40A14
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:57:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AHKRE4H1XyvT for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:57:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 567AC40A12
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 567AC40A12
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 567AC40A12
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:57:01 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6aae5eb0ee0so62766eaf.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 10:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785261420; x=1785866220;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cx+tfMA0WbhiBzlNaNzEIRNBM05xVCifAhC2pWI9r2A=;
 b=op5ZgaZHK9a4+Mk2AwhX2/tLUXOl5G0GiY24VOFUj8ZGs1DFvOe89laR707j3OLWX1
 rtnGNzB+Mh+s0X3rhnNOc3YNXstvz3dkvToUuS7nn2X3aMCT3jypDsuaqwcvbiLoFCqT
 k/rwEQP/cujsNxVlkmaC1N+ZwcOyzPkgjIl30pJ3QBmEglX/3aQUUiPlYUqvuiuu7ka0
 /sKPs5unbYg0NvVo4orclmfKAfQfsnkAXRWGSWwF1ZDYr0vsw/OdMemBFWIF8X9tquMb
 EbjTM7/LxUGpTVNl6J81sBnSHKR/rmKIU22k53CyCJHKDjNfCEQkFkYFyDmyVwBBiNlh
 w3yQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiEyxerxiBkkgpYhtieGuCyXWxqwWKLipNxwT4bp48FHx+Zi3a4SbHJzNiVO4g1Jg01+fnScU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwvLKhi4Qos7gi6KnbJpaj2JXjfVunYrkfY2Es4eTllaGsIP2An
 CNtvH5xpPPRb/bf4fzs/DBim56BouZe3O8jX5+yzTKZPbChe7q958EvM5BXALjcbazM=
X-Gm-Gg: AR+sD12DNJo33EQsZDUNtgmoahYflG4K2fvU5eew4Bx9ExqnQ37YK/u8syFU7UWoRMu
 oQWPXE6epURKiNdZGlV+d1JpAA+TbhsNkE3gT7z7W2Eq4B5y6DRt48dEyOmsU4ys5EgHmev0UMl
 A7JUIcV1SBN0kj6gKMIASvSHGDdWXbwjNVtuKq2k9vIYueqmiUM/8QIMnb5R1yD+yo/cy+LuUKe
 KwWNAUSCG+w2A53+xobSw4NVDN3iV3m+AbXNMiwouL1Qr/d2+ewgltg38iQGH2WMb4OYanxgeYR
 CCF7WA5m5h3b9LMCUn7LQZ9FyAZ6TrS6E5eBmA257a30ALSKAk3HzmLedCkbA5L4dbEj85xpJcD
 JfOxprKaEAwxiDAvSRhGvX1BalUVSlKUseddQIRcqJ6KZ7dpqM3ipQ75sgT54ebqPbbOSaAxbsy
 S+32ede6okChZPoNFFStjodd2Dlgp8w7sYIWM+/zAAOrbIQQwA5OxT2KBGpHimbj+HIkaZ1xWeo
 X8Lzj1ArKZrGic9+gDAfsXSmgM=
X-Received: by 2002:a05:6820:199b:b0:6a3:813d:c83f with SMTP id
 006d021491bc7-6ac96c440dfmr1927502eaf.53.1785261420018; 
 Tue, 28 Jul 2026 10:57:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-458867fb651sm444827fac.11.2026.07.28.10.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 10:56:59 -0700 (PDT)
Date: Tue, 28 Jul 2026 11:56:54 -0600
From: Tom Rini <trini@konsulko.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, u-boot@lists.u-boot-project.org,
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Simon Glass <sjg@chromium.org>, Thierry Reding <treding@nvidia.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Daniel Golle <daniel@makrotopia.org>,
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Randolph Sapp <rs@ti.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Alexey Charkov <alchark@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michael Walle <mwalle@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 Lukasz Majewski <lukma@denx.de>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>
Subject: Re: [PATCH v6 03/13] crypto: hash: allow DM hash in SPL
Message-ID: <20260728175654.GF1188@bill-the-cat>
References: <20260728-submit-ce-series-v2-v6-0-80c1f7daffa5@gmail.com>
 <20260728-submit-ce-series-v2-v6-3-80c1f7daffa5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1ZD3XESSbH2a0hVK"
Content-Disposition: inline
In-Reply-To: <20260728-submit-ce-series-v2-v6-3-80c1f7daffa5@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:55:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785261420; x=1785866220;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cx+tfMA0WbhiBzlNaNzEIRNBM05xVCifAhC2pWI9r2A=;
 b=QUMpRjJ/ns8q4Ncl8VT8eQiThA9x1eeZ5OGnlq1Kw65nG81R7CgZ5m5tNIFRHo1kec
 vQthNh5orXQ4+P8sevvqSvlTaoKliPWi7yOaPGtJIwEXE+uFW5PZzY8U3NQYROMIZA/k
 vqjQpGjIulN71cigsshkLn/H93dXb2465/R0A=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=QUMpRjJ/
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--1ZD3XESSbH2a0hVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 11:41:46AM -0600, James Hilliard wrote:

> The hash uclass is currently keyed only by CONFIG_DM_HASH, so SPL cannot
> enable UCLASS_HASH independently. Any SPL code using hash_digest*() has to
> rely on U-Boot proper also enabling DM_HASH, and the FIT hash path selects
> the driver-model implementation with a non-phase-aware preprocessor check.
>=20
> Add SPL_DM_HASH, build the hash uclass from CONFIG_$(PHASE_)DM_HASH and u=
se
> CONFIG_IS_ENABLED(DM_HASH) when selecting the FIT hash implementation. Th=
is
> lets SPL FIT verification use a UCLASS_HASH provider without requiring the
> U-Boot proper hash uclass.
>=20
> No in-tree configuration enables both DM_HASH and SPL_CRYPTO, so the
> Makefile object key switch does not remove hash-uclass.o from an existing
> SPL build.
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--1ZD3XESSbH2a0hVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamjtYwAKCRAr4qD1Cr/k
ClGlAP96hGt6BwxbujZl9fG/Ys8HtLPS8ncsgby80XWI7OK08QEAyBOKYjbjQPWH
fItkg/fPDheU0bsUvu2gVCNwH4Wf7AE=
=sQsT
-----END PGP SIGNATURE-----

--1ZD3XESSbH2a0hVK--
