Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CB5C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:55:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE817407FA;
	Tue, 25 Aug 2026 22:55:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vIXoeU_zayhR; Tue, 25 Aug 2026 22:55:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787698551;
	bh=LXNeNw7c6zp1CFNY2QgxOtve5f7opLcqolVjkwdV9l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d28EOa5DrNosU6Bx9ZPJ1CzwFHVfXC7pKLzKPQOWb5+XRcWhYO2u60bHj0XoJ7WZy
	 G6bVwNjcWzPQ8DmvAWRWBen5PLVPGmA7AOL8ga7AODGBKKLeNuy0e2W4wLGFekOm32
	 DSxPA1LOYle+Iuh175Vnk78+4KHuv317GpQ26S2WUldPkgf04Gf1RjPH66aYn8WzqW
	 GHUDPXmeCjnvw4xkq7vX5dIDcfIRBY96EqMHBubY4hl20pLsPPtcVkmM1AZ1U7IeYd
	 sKnUM6ZGqv4uI9rmDYhJGXazhNcanD8ClbtRj+NF5Se+ZRIRoVIVPT4V5GH8/BbtJe
	 mWNGFSfzjf/YA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6984140731;
	Tue, 25 Aug 2026 22:55:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BCE67230
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:55:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A341840055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:55:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hgGhha1XxKqA for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:55:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=DT58IbIw
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA2B54000B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:55:48 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7f3faf2b081so341175a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787698547; x=1788303347;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LXNeNw7c6zp1CFNY2QgxOtve5f7opLcqolVjkwdV9l4=;
 b=DT58IbIw7oGRLGj9Idx12Pud/V6dzvb6xKm31OT7Dr4VjXMXQZONOHKGUOld2LuqUI
 RcPVtYnjuzcJACiI6cCB7EI9QdhEWEH5B7yBWj8UE09nwOcgPR+jy78yCd1zYqIyl5S0
 XQ6eHRODPHQ2PkGZAvS2SUWWAg29mRV+icBk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787698547; x=1788303347;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LXNeNw7c6zp1CFNY2QgxOtve5f7opLcqolVjkwdV9l4=;
 b=Reb/yqFA2GutIiyWxkhST9Y5Wc0PvnkGRNfWZJGHTTqUrs/E7KCVykXyR2cMXsuVJD
 6ibGqawmlvPyni1yalf1cBy1tZpC2Duha6mzMLMataGeSEsGajXYEqzO2qKzuCh6ZIy7
 Edt4mPhM0EFYWcm3Z7xupnp090rZ1+LxCJ5TTxaMbkoREqNTjFa6kgb+89Nzb9VAgf3e
 rwukl/2YhqPb1TLPLKyHBdEctTQJn++y2KaproQ6RW0x5B1uoQbPFLw/PicZ9XUeRNy9
 oDZeDxayHCVX+4G8xG14eiIJIwoMvJt/jDdWPcWg9JjGL5kL/q4dAqlCIKRPi5frD0gW
 Tv0g==
X-Gm-Message-State: AFuF++nzdRZt+otmyjf8OjOdn6pQyCdR+wSJVkH+XZXStXCfegH3JgAM
 GJC3mXfLuGmsTUc6m5TazG5xEtVZelgKnd9dMxUTpK2gU27aP+643iiBTVyWDNECWVU=
X-Gm-Gg: AR+sD13mec+bWMGGPfSs1/VV/byKLswo3isUE7stQ4quDpe0KNEa3SurJp8sgX769YA
 SnpKyz3QiqLHijv8/7OdZfXAJavj/YXy7bs16SBe0bTvKH2m9gI9hUUmO/bYGzyEw7+XdLAdDry
 xMoVLGWcfNClRNi+02Jo2Ccwhy0pXRLKUS/brB5xJAFGN9eC0MHwPPwtjvTGZj4fyJzGU7KvnD2
 kh9Vb3LgsUFMjPsgc/+wuyeXjYvcxz4jLDyS2/9u03CiVTLxWCiIjVdYs9gl9sPMNrSOjljgY1t
 XYDioNQV5SdhdAOlDA1cvfWeX7hY6P12bGmV5S5vSZw8HnZ8mzjOk/QS47izuVhW1wPSSkmFwpV
 0Ob0cG/yXgZ42UEn6VOJCBToVmEDeuEuLxbooTRXOBJ9DNqkqOc8Av/M+Bksw0R4rLwb4M3JyGk
 7BrxtaGquW87X+iav014LddxbrBgVLoterRcXVJShBNBYlZwHOgCT1qkBQIv7S443kbzff9tyWs
 zeCZuz8nEs1OKkUA7twbM17rBh6wHCFjq/ExxPC1TQiWqqAPU+znm/3Tl/Dp5vD7EvE0GZCnSFs
 nN2/qhBy2Wi6q1ae6+bj
X-Received: by 2002:a05:6830:43a6:b0:7ec:6749:f38d with SMTP id
 46e09a7af769-7f4c4b796c4mr2310035a34.0.1787698547347; 
 Tue, 25 Aug 2026 15:55:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c8410090sm202461a34.19.2026.08.25.15.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:55:46 -0700 (PDT)
Date: Tue, 25 Aug 2026 16:55:44 -0600
From: Tom Rini <trini@konsulko.com>
To: AK Sharma <maskachoska@yahoo.com>
Cc: u-boot@lists.u-boot-project.org, Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v1 09/12] mips: dts: add EcoNet EN75xx device trees
Message-ID: <20260825225544.GE523975@bill-the-cat>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
 <20260825224330.713151-10-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sKRK/Cyyq+obSzvU"
Content-Disposition: inline
In-Reply-To: <20260825224330.713151-10-maskachoska@yahoo.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--sKRK/Cyyq+obSzvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 04:12:04AM +0530, AK Sharma wrote:

> Add the device trees for the EN7512 and EN7528 reference boards and the
> EN7528 RAM-boot variant.
>=20
> Signed-off-by: AK Sharma <maskachoska@yahoo.com>
> ---
>  arch/mips/dts/Makefile                        |   2 +
>  .../dts/econet,en7512-reference-u-boot.dtsi   |  58 +++++++
>  arch/mips/dts/econet,en7512-reference.dts     |  27 +++
>  arch/mips/dts/econet,en7512.dtsi              |  88 ++++++++++
>  arch/mips/dts/econet,en7528-ram-u-boot.dtsi   |   6 +
>  arch/mips/dts/econet,en7528-ram.dts           |  72 ++++++++
>  .../dts/econet,en7528-reference-u-boot.dtsi   |  62 +++++++
>  arch/mips/dts/econet,en7528-reference.dts     |  25 +++
>  arch/mips/dts/econet,en7528.dtsi              | 164 ++++++++++++++++++
>  9 files changed, 504 insertions(+)
>  create mode 100644 arch/mips/dts/econet,en7512-reference-u-boot.dtsi
>  create mode 100644 arch/mips/dts/econet,en7512-reference.dts
>  create mode 100644 arch/mips/dts/econet,en7512.dtsi
>  create mode 100644 arch/mips/dts/econet,en7528-ram-u-boot.dtsi
>  create mode 100644 arch/mips/dts/econet,en7528-ram.dts
>  create mode 100644 arch/mips/dts/econet,en7528-reference-u-boot.dtsi
>  create mode 100644 arch/mips/dts/econet,en7528-reference.dts
>  create mode 100644 arch/mips/dts/econet,en7528.dtsi

What is the status of upstreaming all of these dts files? Thanks.

--=20
Tom

--sKRK/Cyyq+obSzvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao4dcAAKCRAr4qD1Cr/k
CtQOAP9uig+Yi00cbRWS8TkymgEfOSmN4ISivaT7TVQOLq+n/gD8Ck/fmBWGHLmp
vzyaRAIgbgvHkMx6jVDtybmGiQe1KQE=
=6grK
-----END PGP SIGNATURE-----

--sKRK/Cyyq+obSzvU--
