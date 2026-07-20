Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F5DC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 23:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 611AA4074E;
	Mon, 20 Jul 2026 23:34:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1_5QWocj_yYa; Mon, 20 Jul 2026 23:34:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A9CD406DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784590497;
	bh=fHkmBpP6In4/YnFaXBXSRKkBI9yXemclV8UZ3iTDJN8=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=fW3OLEjMX1NIqFQCxAdTwW9jjoAveF8E3xnb5/2ZN8TznFmLX1v7sK6dSWSjEQfa5
	 IeYMdx82r9nX3PTDBmbxoCQl5YDzMtsmiB8NNHdUqUsthEn7voipwEMPiyybneeiiI
	 rlCyujJbPNxsj0Q2SP6a6zRpRrynJIceV6ivGqal2jGVoaF3LMwuBP0ThFaXk8cutZ
	 aMs8DfN+CNn2exFNxUDpZ9zU2/LdgEr7iSHmlEu5I9Wt1ga5qV7OlU9YC+tMBRY/Vk
	 Jly59KIexZ3lkGXynrihIhVjEufLTYmiArvuBEjOEX8fO1TtxyrN7+nKNVzR/BryPl
	 Afp74BzC+WFmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A9CD406DA;
	Mon, 20 Jul 2026 23:34:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 39AC038E
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:26:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 202C36076A
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:26:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SR64R4EwwBj0 for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 23:26:49 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D653560768
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D653560768
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D653560768
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:26:48 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EDA983C14; Tue, 21 Jul 2026 01:26:47 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D03182991
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 01:26:44 +0200 (CEST)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-44ae14b4fd6so3727115fac.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 16:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784590003; x=1785194803;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fHkmBpP6In4/YnFaXBXSRKkBI9yXemclV8UZ3iTDJN8=;
 b=TZe4/eszeygN9lvPDbINOCm4xEgWERsdI2tZOblxyazCQSAy943ojR51GUqoGin+VY
 LbuiiqgVCxQ+JOVKPsrXYIoe6wxyq1wI6XpRkTQB2NPq9xnJF9nf/jbD+/HEgLZ4jXMT
 4pSV3WBJ/4esb1VjWQGQaa1m6FBDZpXWFcUYv0SquyWk7t4hxGRXYOyUn2aY+wt6wGSE
 l8lCBGARgJl1rY2l2YgvUWdfUuEozASpH/And4HJeoOzxi/1ckiIQeui4Hmk0AypeU8T
 8NlTEQlQAAdHTQrrNjzW6jm4xNLGtLeyBIR///lRr/tOaNnr224YWyMvUIlXVkyFrr5c
 dM2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXmqqjjbqSWMMbZJAoScqT/y1z8jyKE2rQCZ/wjafXNM/HEPzd733y8x2pzTdEhcIEkDbaI3k=@lists.denx.de
X-Gm-Message-State: AOJu0YznzcYwEt2cKzexqrC1E0wnq1/7Bpxk453ahoP6PGSyC0TP4/Yc
 0lS7j/bkMwndnrbhnP/oU32OjXLPG1kUDzJUxplegMD8iFk6klta6mLasirvkX5IR34=
X-Gm-Gg: AfdE7cm2GLc6Pr955KM6jgEbkP5cEPU2rmRdfOCK4dOpY74XGCu4l0iXLJRfC6f1Hzk
 djUqlbjn4BaOtGtUxPRhJO35jJ1gs1itvDysCkqYJ8wQpjuI+GaABj3HRAl9zF2KtzmLyNxZ7By
 N+SWxjQdtoLk2CiE5oV5YRkFT1ddMh+ycq6nzAbn/1xfdAu1az8UJiTdCyV3RfkdA8/PtMgcxgO
 CeByn/afZMF1qLG3ah2EhBiGE1htjZft5V2XWhkonKYB1QngNogUpoCT8vsMzrVnxiEskcbECGy
 04MroYTHWr2fG2mHn0oFCQmrDg5C5DRnug1VIO4oVlweGI83MSAk/b3PW7bdu5tT+OFW17u20Ga
 fe80o8962btcYMDG+jLD4CSSbRFoWny7Aou8nl3KIPSOi4IjZIRJ1rWTpToHea6nYyC0dsorlOE
 tnGbryVwLfvuIeRJzRs72T++S+yddmByWURf+SRaWgCIqc8tB9Vu52ZZCKQI/3NDLOwgMoe2K16
 FBYtLrTOw2dpDGGbzzszCmzhes=
X-Received: by 2002:a05:6820:2d4a:b0:6a1:475f:1350 with SMTP id
 006d021491bc7-6a5367e3632mr8086070eaf.19.1784590003196; 
 Mon, 20 Jul 2026 16:26:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a51a25c857sm9096468eaf.14.2026.07.20.16.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 16:26:42 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:26:37 -0600
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
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
Subject: Re: [PATCH v5 03/14] crypto: aes: allow DM AES in SPL
Message-ID: <20260720232637.GO749385@bill-the-cat>
References: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
 <20260719-submit-ce-series-v2-v5-3-3c41f66d4522@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7se7yjexunn6U8EA"
Content-Disposition: inline
In-Reply-To: <20260719-submit-ce-series-v2-v5-3-3c41f66d4522@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 23:34:55 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784590003; x=1785194803; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fHkmBpP6In4/YnFaXBXSRKkBI9yXemclV8UZ3iTDJN8=;
 b=lEWyDdDH4sYsniBBb4DFBmrEWBSE7GgotgM2I+SYTzZndx+2B5miU96xLhxXW6F6fc
 Bb3UOKBwsnsdx+Dy+nGA/R1IdlY1GE9kcPrMR8fY3uHwL/0m+GzLM9wB21VlA9law+wU
 ESHmx9UIwAQlzlK90FHAb/1hKSJGrDFwWDTKc=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lEWyDdDH
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lEWyDdDH";
 dkim-atps=neutral
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
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--7se7yjexunn6U8EA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 10:13:47PM -0600, James Hilliard wrote:

> The AES uclass Makefile is already keyed by CONFIG_$(PHASE_)DM_AES,
> but there is no SPL_DM_AES symbol to build it for SPL.
>=20
> Add the SPL variant so SPL code can use UCLASS_AES providers, for
> example when decrypting FIT images before loading U-Boot proper. Select
> SPL_CRYPTO from SPL_DM_AES as well, since drivers/Makefile only descends
> into drivers/crypto/ for SPL when SPL_CRYPTO is enabled.
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>   - Select SPL_CRYPTO from SPL_DM_AES  (suggested by Simon Glass)
> ---
>  drivers/crypto/aes/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/crypto/aes/Kconfig b/drivers/crypto/aes/Kconfig
> index 7e1b1b2875d..254cb598568 100644
> --- a/drivers/crypto/aes/Kconfig
> +++ b/drivers/crypto/aes/Kconfig
> @@ -4,6 +4,14 @@ config DM_AES
>  	help
>  	  If you want to use driver model for AES crypto operations, say Y.
> =20
> +config SPL_DM_AES
> +	bool "Enable Driver Model for AES crypto operations in SPL"
> +	depends on SPL_DM
> +	select SPL_CRYPTO
> +	help
> +	  If you want to use driver model for AES crypto operations in SPL,
> +	  say Y.
> +
>  config AES_SOFTWARE
>  	bool "Enable driver for AES in software"
>  	depends on DM_AES && AES

Since this gets used later on, this is fine.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--7se7yjexunn6U8EA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal6urQAKCRAr4qD1Cr/k
ClAvAP4kcUZ4ouzQSpYr8yhIusRJEfSCNDIPDCg6uDocYkc3pQEAgh+NArf6MYf6
XtYRFrAurvsk94Mi7GYobVb5dH36ng8=
=zsZP
-----END PGP SIGNATURE-----

--7se7yjexunn6U8EA--
