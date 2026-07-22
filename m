Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D6BC44532
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 00:52:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CAB1608ED;
	Thu, 23 Jul 2026 00:52:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Zj-iO_8DtWr; Thu, 23 Jul 2026 00:52:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C60E960902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784767967;
	bh=0IynkgUwPZtTzwCfgPx0ken+x92dqtLJWpH7bMv1ie0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c7wqKxMiswCPVoDzNrlFsAH6oVYEAH4rA0BtiY99h4sZ5SorgJ/ZO9SaXL5yRa358
	 8O1VMO+Q1FpKjmscUH3q/jhvi9HbZ4FVhhKYguGCiE4z+9aZ1wXF3adE9ZVve1+QbC
	 AeAqnMPahhdLluprZiOvmnzdZ9SOgvN7RS5AiY9w6nTjY2RPJC5xbYJ7k8VY37aNfh
	 sy0uLAcorfe6abXhscu5TZx5tge7WTWEiK0e54Kzolt9MfZ4F5EYa3vPZIAKu/BJGB
	 mBUJV+qKt+62oU3/R8KwIhPHL2FJPlzfpWOcv32kKTeD9sR037xid7os1+qqJV+PqO
	 MnYZbvkMai/zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C60E960902;
	Thu, 23 Jul 2026 00:52:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E9AE51093
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D037C60665
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:25:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d8vcdwIW0BAq for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 16:25:22 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7E761605D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E761605D3
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E761605D3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:25:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECFB983E76; Wed, 22 Jul 2026 18:25:20 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A6CB8404D
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 18:25:18 +0200 (CEST)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-49ff971e903so3475591b6e.0
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784737517; x=1785342317;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0IynkgUwPZtTzwCfgPx0ken+x92dqtLJWpH7bMv1ie0=;
 b=YsqmU+zAMgY8fObvMGkqRrL0Z4JSNH9re8fvghEg+9Ci9ixDzCvFc5kq/xEo5yQoml
 pAqFxuoDvfpMSK0GWVKCMaWGJ6EXnmbQFA1Rdz3JfMNvic3vsDceKFdcoAsfjRcs9UbB
 hASy3D/Qv/3/LnORlmhN6qlXU2vQFMGUOsjPshgg/yIYnFhUl8Fk523uA/02ClTHyj9Y
 m8aB1Vqayff7cJOYHlfqYnvnUzoKbmNjEFpqDq659zViJ3VtyQm/0BcpQta6bCNqXgyG
 bkaMIQONgj1OF8EVakcvLUyIQN2h/gDYQZqN7RRzK9Gk7XThkCmn8PQSvvmrn8sVzP0s
 uldg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrlyJiyq2VXlJjRWL6EQHieCIoLiTX5GSI8KumEoBlxrWsrPmVUUKpKIe342atyfgHe+Iqisio=@lists.denx.de
X-Gm-Message-State: AOJu0YypNiixFyb+pm2U8HDFKx6ScmJajulWaxubH0nAbl5mP53/lbDo
 B7us/xZixX7ImZp4NPu9Sgn6AyyHXwdXq33xcM/qTqhFz25qWfBMAy02sacxd2llgCM=
X-Gm-Gg: AR+sD103VHfZrEU/zD47EX39hZFivSNBPG3e3d3eLK627FOUzakgXpc9ad9dVmfAa64
 CSBNICUp/MQ6wInYKn//SgwYmfrB4iCx9rWmCaUxlE27HsYFYOyZrKRhd4zKN6/aLbSfjEVdpib
 bX/LTBs0bXbqKDAZSbIveTvs01DVCHUDhDO4vLJZY1b4fLx+G5mXmD20XQPQCOp+U84ZZFDfGSs
 FKyn3vVzhCAxW3x39Hyd4b5AjsYA7hPhYEEZwR4PjrGXSbU5rXQVkV1UANPLnMD0WnyLRDqhEiY
 HJZtDQUUE+M6lKbo8sxzgzXBtyMiwmb2RDLjjIg4R++m8yMAoSQ/rGgyO8XgzJQt43hszx/YmAp
 n/H3q0a+Myq+gFdt6sPT43RdQdK+aY+KnXp0iLfPhQ99uEtlvpCt9L2BDBnlhGPPhkeY4UEiJ/6
 ZAeRTYZk+I8HSjQiGiwrGstwlKRvDmP3Aq0ohlOtroIw6PDIsjP8sRZaB8YZvmnGwKmKg0n4Upb
 /9OdGiHSRd5uJLfSiSQEzYN6whO1ucVEMeMPg==
X-Received: by 2002:a05:6809:197:10b0:4ab:224d:6dd6 with SMTP id
 5614622812f47-4ab224d7338mr1048367b6e.15.1784737516951; 
 Wed, 22 Jul 2026 09:25:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0eeb073dsm1367247b6e.16.2026.07.22.09.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 09:25:16 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:25:10 -0600
From: Tom Rini <trini@konsulko.com>
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
Message-ID: <20260722162510.GY749385@bill-the-cat>
References: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
 <20260719-submit-ce-series-v2-v5-4-3c41f66d4522@gmail.com>
 <20260720233023.GP749385@bill-the-cat>
 <CADvTj4qHHW6pvRENss206Q6-UG0RJOgftvYeZviaJrh6bcKLLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EWPQEBIVL8OeR90o"
Content-Disposition: inline
In-Reply-To: <CADvTj4qHHW6pvRENss206Q6-UG0RJOgftvYeZviaJrh6bcKLLg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 00:52:44 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784737517; x=1785342317; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0IynkgUwPZtTzwCfgPx0ken+x92dqtLJWpH7bMv1ie0=;
 b=KwWZGxExzblFApWK+5vQ0ifNU3VlrURyjxvNB58uxAfCQa/7FcvvGOqMQ7QAz+TSDs
 b+9sxWU6lcb30Ier6eavBv873cI+a4tuRyM204hqk2onfwusiQVGM40f0tm2DamwovD5
 53nbtVGPES+wxYRubHatrh4xOhNnlVCwvtrIE=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KwWZGxEx
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KwWZGxEx";
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--EWPQEBIVL8OeR90o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 08:21:17AM -0600, James Hilliard wrote:
> On Mon, Jul 20, 2026 at 7:30=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Sun, Jul 19, 2026 at 10:13:48PM -0600, James Hilliard wrote:
> > > The hash uclass is currently keyed only by CONFIG_DM_HASH, so SPL can=
not
> > > enable UCLASS_HASH independently. Any SPL code using hash_digest*() h=
as to
> > > rely on U-Boot proper also enabling DM_HASH, and the FIT hash path se=
lects
> > > the driver-model implementation with a non-phase-aware preprocessor c=
heck.
> > >
> > > Add SPL_DM_HASH, build the hash uclass from CONFIG_$(PHASE_)DM_HASH a=
nd use
> > > CONFIG_IS_ENABLED(DM_HASH) when selecting the FIT hash implementation=
=2E This
> > > lets SPL FIT verification use a UCLASS_HASH provider without requirin=
g the
> > > U-Boot proper hash uclass.
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > ---
> > > Changes v2 -> v3:
> > >   - Remove the bare software-hash fallback scope
> > >     (suggested by Simon Glass)
> > >   - Document that SPL_DM_HASH needs a hardware provider unless a
> > >     phase-aware software hash provider is added
> > >     (suggested by Simon Glass)
> > > ---
> > >  boot/image-fit.c             | 50 +++++++++++++++++++++++-----------=
----------
> > >  drivers/crypto/hash/Kconfig  | 13 ++++++++++++
> > >  drivers/crypto/hash/Makefile |  2 +-
> > >  3 files changed, 40 insertions(+), 25 deletions(-)
> >
> > The changes in here make me worry a bit about platforms relying on the
> > current behavior (because of the Makefile change), did you put this
> > through CI? https://docs.u-boot-project.org/en/latest/develop/ci_testin=
g.html
>=20
> Looks fine to me when I ran it through CI:
> https://github.com/u-boot/u-boot/pull/1014/checks

Thanks. We have cases where SPL builds of FEATURE depend on FEATURE and
not SPL_FEATURE being enabled, hence the concern.

--=20
Tom

--EWPQEBIVL8OeR90o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamDu5gAKCRAr4qD1Cr/k
Chx+AP9O6EPo519Bip+Up9m6gpNlrlLEw/8QBh7NwxRr0oCu5gEAs9IJf7X+SfRh
9tp2JHJz6AaPVnZD7QC6MK/cGCBT2gk=
=wRJI
-----END PGP SIGNATURE-----

--EWPQEBIVL8OeR90o--
