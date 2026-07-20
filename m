Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0115BC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 23:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4817C406DA;
	Mon, 20 Jul 2026 23:35:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Slz-usEKdQ0m; Mon, 20 Jul 2026 23:34:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0EA3A40762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784590499;
	bh=l/CxXS1s817TEeA9lJFiOmGixxe4hFKI34oyywipikE=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=OezO4xmOuaZLrGYioA8CTvZi12Rq3DScRBfeCZ2AV5pqqcHVU3iePDgctMzLb+tei
	 fRuuAT4cJB7+Wt1FjOvoeWQ1Y4NdOeMCYsPlZAyIYCmwK7KqNM4KS1VRqy9r1WNpfe
	 gqUa0QlwhbG4jcy4m5wQ7nkd2ZAfCh2JiNeOpohjKVhRfyjtL2VcdoIfyffv3l6v7I
	 aIDj3/+pP/ZdQOdfVpTpDeQovw4KfLYaHgFx0wGh+5dWv0PvthJIRxojDBX/O0THak
	 DhbkgML9SJ5QYMkBzsImxu+TJcxBMGjPEpV4dKgvuKWCMeNbIPign2A19txePQQShQ
	 k6gU4apVcruZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EA3A40762;
	Mon, 20 Jul 2026 23:34:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DFB00313
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D174140153
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:30:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TzogcJc8RyAA for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 23:30:37 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7F6C2400FC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F6C2400FC
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F6C2400FC
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:30:36 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id F287683C14; Tue, 21 Jul 2026 01:30:34 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 860DF82991
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 01:30:30 +0200 (CEST)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-43bf9548df4so5514563fac.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 16:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784590229; x=1785195029;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l/CxXS1s817TEeA9lJFiOmGixxe4hFKI34oyywipikE=;
 b=L5zQIwaRsTMxyAUnDP8t+cd2+BKTRT1pM/Lkl4LS4dW0gzzhm1f1kwEKB3fjPajWYi
 XluJReeDKPw+FkK0yMqUrpV4DflUuPgjz90kvHnv6HgvmN5+wzm0vh4bQElSPfLN+vzC
 /eM7DFJY0YseNnBZ0ZBagsSHfEW4UJUROThu4DAr4mUcel94ZaifuloBAIkptG4LwFbB
 GTF5yv5Xh8oeB0fcL/vgUmd30zBI8FXlqw14uaZ4GjcwB9OEf2sknbKW8Z6HjjpNV+m5
 sm0CLd2fGmZtXph8Js2iO3NVQDSVVCCmJDHfPHjja46DdFU3It/FmiAfTdG8qm2bNGcT
 Je7g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpiGAgwe+UAXLNi5Dy1eqjYvqd84Vcvcil9zLHvP6B6inJRi4A7mKKdrHdUWSo0bHwXkUz9sO0=@lists.denx.de
X-Gm-Message-State: AOJu0YygRq6RmDq/bFMedtp61LN8TcBtgcI7SxJzQDebB79dUjT8GGRB
 JiIdDZaFMzsV6rjksrak+2g9TRxCjVty4oME/qPf75siAmwHLxXdeFgHFPa/5ICW+fE=
X-Gm-Gg: AfdE7clfepAiyXERHRL+IKySEKxdBgvFNYEVejYqxfArNlxq4iiHSkLE8FBd2se7+gG
 3WSCyKw75iDlbG9SpheFrfo4EU2nXSoPWcOnyGzL+yJYnWs4I3tziBiuKjVTgp3GNEvPDWFJSYQ
 fMfg4PjxIzxkG+aIpG+cu9Lpi7HS+RLroPLdM7xi1wRRq5OgdTTgm7csqsyIGHJ4ilBk0JlnNfv
 LHGPf38ZV69mWsVAN9/FSH5pMmqHvLxsds3RpaknDmCdcHeMeZlHNWfddK1FS1WRN5lwJ8S4W0Z
 a6Yir2j3URP+jD3PKrpiSjPCPcf5tAhEPEfKkbLfzJehbX48cVb1DiuyruviEhDfLtUZmyXVyTb
 NHsk+dqBVBgVqGFiM8oFHpltmwFRXtmVzfVDDl0TuE6anoRbh+pLR92SrxYlY3QkkQeoepM6fHw
 sgRdI/Cr+pqln4N3Tk7SNZV52rGR8jypQLePkxyilVMp8hLeo3oXGFHQSLD/5BbAIHqUzAc+ctf
 ewwMGTCG8W+i+YL4zQ/Duvnp6U=
X-Received: by 2002:a05:6870:309:b0:448:558c:d82f with SMTP id
 586e51a60fabf-45690ddc9e5mr7701574fac.40.1784590229135; 
 Mon, 20 Jul 2026 16:30:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568e6a92f5sm9838535fac.15.2026.07.20.16.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 16:30:28 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:30:23 -0600
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
Subject: Re: [PATCH v5 04/14] crypto: hash: allow DM hash in SPL
Message-ID: <20260720233023.GP749385@bill-the-cat>
References: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
 <20260719-submit-ce-series-v2-v5-4-3c41f66d4522@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gx+3yW8HzLnqBE96"
Content-Disposition: inline
In-Reply-To: <20260719-submit-ce-series-v2-v5-4-3c41f66d4522@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 23:34:55 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784590229; x=1785195029; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l/CxXS1s817TEeA9lJFiOmGixxe4hFKI34oyywipikE=;
 b=DSPqClHIFHpyfEs3kGv4luPFPOhdEUSjUQKu6Hf0tZaFltb0nxSQT1Pn6M5AjCKET0
 DPsmzCYAfS2ZB/mgsa+pSaMwuChMlmaXGSkKyRlbcw1FPnJpj78uZyJj8NarTwlujVTO
 ildpi7LSYM6YTUUMH4jdJ38mmc9etbFHC1NPU=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=DSPqClHI
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DSPqClHI";
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


--Gx+3yW8HzLnqBE96
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 10:13:48PM -0600, James Hilliard wrote:
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
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>   - Remove the bare software-hash fallback scope
>     (suggested by Simon Glass)
>   - Document that SPL_DM_HASH needs a hardware provider unless a
>     phase-aware software hash provider is added
>     (suggested by Simon Glass)
> ---
>  boot/image-fit.c             | 50 +++++++++++++++++++++++---------------=
------
>  drivers/crypto/hash/Kconfig  | 13 ++++++++++++
>  drivers/crypto/hash/Makefile |  2 +-
>  3 files changed, 40 insertions(+), 25 deletions(-)

The changes in here make me worry a bit about platforms relying on the
current behavior (because of the Makefile change), did you put this
through CI? https://docs.u-boot-project.org/en/latest/develop/ci_testing.ht=
ml

--=20
Tom

--Gx+3yW8HzLnqBE96
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal6vjgAKCRAr4qD1Cr/k
CvqVAP9JAS0WRLyfw0ZL2e/is+7iwlSxxC2TT8QdihplMaZB2QD/TTe3+DF13liW
O/N/mzNIU2kYc+f8VwlRN9TTK7vPgQc=
=cYyw
-----END PGP SIGNATURE-----

--Gx+3yW8HzLnqBE96--
