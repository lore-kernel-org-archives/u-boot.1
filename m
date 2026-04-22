Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBD7FA1FD6
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 17:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ADD78435C;
	Wed, 22 Apr 2026 19:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EarNMasE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33CF48435C; Wed, 22 Apr 2026 19:07:49 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 124C384333
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 19:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-409de4132b5so3635586fac.1
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776877666; x=1777482466; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EqEbg9U/e3JMyihINHqQ0KhTSVVs+vT3jFzow8q9UcQ=;
 b=EarNMasEq5g5cVkj3fc5poR+DKBDQp64I/E3NlMabV4lylHTSIqFxyNE5NODcNhohy
 /LD0C55bbo5tgVb62+oeHtY+v4GTflApoLJQkJc6zqhfuUTuS2Zb08ryhtItAzYHmoiv
 oIAPjVKpY11UOqpOH7E5aLFEUWqJ9W8ttxV88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776877666; x=1777482466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EqEbg9U/e3JMyihINHqQ0KhTSVVs+vT3jFzow8q9UcQ=;
 b=lWPOncbbfZEfI/bauNfCbg1MS/XCIahUKjoVN37M7mojNseG1q+YWYBshyeHfzx2dH
 LVIfgmZLPQ+Emw5HhWIxuY4mj6npcDQaAPHz3JcK3583azoP+CO1bYAITws+6ztwI5oU
 aElQPuT8/TihGJsBVuEES83ElfslGMYtZ+Fs8OJ8rSX6Ey3xhb3wtfEFFsj+BBTf9Vta
 ObYuWykpTpTA78Timibf8WeP7YpzSsurYxKMSUOdFyfAbIBxsOXM+W1HGTx3YU4SBVis
 BbaSKXBSYjOlb1dtHngxRQ6kWeAMu5/RNORmKBPpcZ6ydEy+87ZZJMHxL92Lz7qFUr2J
 8/RA==
X-Gm-Message-State: AOJu0Yy28vWnIPa4nTtkTGXjvuDA3Y5eVDIYtyI1rc9/mAvvVJfCnibo
 eGhfa2zVtAfB8bLvIea90LowPDTf7+Jw2z7mlF9+9JvyGpqABp3BYO4dG2wgoGOstlk=
X-Gm-Gg: AeBDiev0uHRH1ln4T+49qeiWdxNGUN9bb32wWL5unKT+UVVKC40bKPmfak1Ez6orVlE
 HQZPBGcMPOrtp3y2wuuiRu+4asFeR10yWF+YuDCAG16S6E6pNqdic/jDOKvXAZOg7XNM32Oo+x1
 n5KwzTTEXZl2rS/EQPh+mkzf2pe9LK0DUcpjbtN1DEvIMYE6nMspUN2NQQWec8wVAs7aknmnU1L
 WCrYiW16y/rqyJfoEATh457Xj/hieSW8Cg+7IKNL0Ux6lu65L4OeBNKRq1R4ZVVDNZa595CyU48
 fGRG6XlZe3qfl3AF8CBnt2tlawOZs1hraQuxp8dxklCmpR8HqqlJzTSpaH47jRA0Rwy7G4oeGBD
 xIOVOQhU2u9hzfWn2E+/Gwaflo2MXmBTbM2uCBsWCAaXIbBO5ltvg3f65a53AQreAGrd/IeIQ9I
 +AI+Iyofu+uH5lGYEdc2N6ZaiZNSzxiKFfsVW2eLOiBFAQOGqtVHtl+SeBfsQZDxCL3F5qlJMU5
 LRPmwD4vf+VYFOrmiQursKSmHNrzd/9g9zvU/h5gdKR/vJsqg3YJEi+JsE+/g==
X-Received: by 2002:a05:6870:c210:b0:42f:b6d5:c127 with SMTP id
 586e51a60fabf-42fb6d5f2cdmr3634928fac.21.1776877665699; 
 Wed, 22 Apr 2026 10:07:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a2e8esm15935324fac.10.2026.04.22.10.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 10:07:44 -0700 (PDT)
Date: Wed, 22 Apr 2026 11:07:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Jie Zhang <jzhang918@gmail.com>
Cc: u-boot@lists.denx.de, Jie Zhang <jie.zhang@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>,
 Ozan Durgut <ozan.durgut@analog.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, linux@analog.com
Subject: Re: [PATCH 1/1] arm: dts: add/fix I2C controllers for sc5xx
Message-ID: <20260422170741.GA1881723@bill-the-cat>
References: <20260402171330.165754-1-jzhang918@gmail.com>
 <20260402171330.165754-2-jzhang918@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9IUQSlIAhe7aYpgb"
Content-Disposition: inline
In-Reply-To: <20260402171330.165754-2-jzhang918@gmail.com>
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


--9IUQSlIAhe7aYpgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2026 at 01:13:16PM -0400, Jie Zhang wrote:

> From: Jie Zhang <jie.zhang@analog.com>
>=20
> sc59x processors have 6 I2C controllers, but their devicetrees
> currently have only 3. The length of its register block should
> be 0x100 instead of 0x1000. All I2C nodes should be disabled in
> sc5xx.dtsi. They can be enabled in board devicetree files if
> they are used on the boards. Add missing I2C controllers and
> fix the above issues.
>=20
> Signed-off-by: Jie Zhang <jie.zhang@analog.com>
> ---
>  arch/arm/dts/sc573-ezlite.dts    |  2 ++
>  arch/arm/dts/sc584-ezkit.dts     |  2 ++
>  arch/arm/dts/sc589-ezkit.dts     |  2 ++
>  arch/arm/dts/sc594-som.dtsi      | 13 +++++++++++++
>  arch/arm/dts/sc598-som-revD.dtsi |  2 ++
>  arch/arm/dts/sc598-som-revE.dtsi |  2 ++
>  arch/arm/dts/sc598-som.dtsi      | 12 ++++++++++++
>  arch/arm/dts/sc59x.dtsi          | 30 ++++++++++++++++++++++++++++++
>  arch/arm/dts/sc5xx.dtsi          | 12 ++++++------
>  9 files changed, 71 insertions(+), 6 deletions(-)

This no longer applies to current master, sorry, please rebase and
resend.

--=20
Tom

--9IUQSlIAhe7aYpgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaekAXQAKCRAr4qD1Cr/k
CnadAQCvbjOtoghJiUsIwmQJ8eO8xz5nT4kz2//cxp2h9KafegD8CIDA7Uu8FfPB
5Rq+yA0khwbfeyrTJvzZ+Ei1GNiOBAU=
=y46e
-----END PGP SIGNATURE-----

--9IUQSlIAhe7aYpgb--
