Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0BAC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 21:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BE2960746;
	Mon, 20 Jul 2026 21:12:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bgeJmv3JV11N; Mon, 20 Jul 2026 21:12:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 606B760744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784581932;
	bh=AOxLACfUIOBP2Xx8zYWmMVeb9ya4STWjBgD3Xtd7M/E=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Ase0YEEw6rIHsQ+1L8e2wNQ6UOgIW6xwZ+8Cq4aS+IPg29yJKp9Z6ynHW9inocm19
	 8MWTCkacDhInTOhM1SqbjaD5PY6JpowamGf4IEi3cISiOeqNMar2NsmVRO8TpWmqJF
	 K+ZTQoUS95cbP+7QrTinwwP937ZZdd/enex0dpN70YAug5lSQi+sAcCDUM8sw8u4DG
	 cKxKhjtjLrfJtsiH7qc+dT4+1iiXhzYL+GN4gGx9dNzyiAD0bbPEX7xzwhiBbOReAa
	 kruap+D/ceTQ+detGX2oPRzOWW63NUi3hKMzGV8s8eSACrLUA6C8o7V0EGWseuAnFL
	 5m9+itN0wkJqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 606B760744;
	Mon, 20 Jul 2026 21:12:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C60A9DB4
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:09:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1A334056E
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:09:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id REo9kZEYfrm3 for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 19:09:03 +0000 (UTC)
X-Greylist: delayed 572 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 20 Jul 2026 19:09:02 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org AA0784056A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA0784056A
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA0784056A
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:09:02 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39C2783C14; Mon, 20 Jul 2026 20:59:29 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10C4382991
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:59:27 +0200 (CEST)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-44cd237446cso4482724fac.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784573966; x=1785178766;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AOxLACfUIOBP2Xx8zYWmMVeb9ya4STWjBgD3Xtd7M/E=;
 b=fyWpucCqBUgdjNcgXJvGDtQiCMVADYoQWa1OJj+042FpEdkqDpznf6F0DHHIcMM+Ns
 hBWKrCd5VSWBkoOqinXdGF0mEFBfbN6eEaHgb7wiXoQGBpyvvxmuK0xXDjFzbzra6VtR
 FbizSgiFDv+O49hM3B/dHiRP0defuh+qo5wfzD9BQSthLQcezdmdxyZCVDC5zR2IYKWv
 30e6cWL4JhK7yMejS2fQZ35A2v4qnmgp+nvwI1i2onelwMPs/V7E8hxka2aLdDftoOjY
 rYchZhaX5jiJ7/OBPAu0qVHF4g2IQfcfhrLSwCn20077QcM/4X7N33NCimZxS7xezFr4
 UyhQ==
X-Gm-Message-State: AOJu0YwvYq+NeL5kpmJlWZI6EyNkkto0C5Dkl91Pli8fOcbaiHcu4oEr
 scTrooohNB0q3lDL7BVq4R3dvvD2TgiBYfdPJjOnhTfaXbiL2JVdbHM2ZUXscft7P4c=
X-Gm-Gg: AfdE7cktb+AjddRU7ZOVHIAgpintZ4VLymlXiwxXmlO6o9OQVodRQNtBdnkVvX9b4OC
 43ZRpx9oXco2y23rDdNBT12kIVnzfvUzrI8R0HgWnXVoAppKTpMSFYKGCh8TAOqmG2moc4T9tHo
 cinTflntT3WLSzg4LZTvrAC0d8oQDJtJ81U/0uXvrSkgi4qQYmpbBoBNCtHwqPTjCaDNPNIEaiK
 Nx3jLO2SkN6TQPiF3l/XtKKbB4h2xeAPw6bdbLIl+YWzz+1yn6lwASLLLRw8BlB5hEzCk8c5jQz
 c4Hbztrh3vNFkpUmhIwPvCQSRGtdF5u0pTlUXGdvA5o3L8PotjVibKA0bjNROBDTuvhhibJWxgy
 XHfcj30jdOA0TpwGS55TiVnG7+XJeJVBfEOFhQonESBrArs4G/a/6p8cJhKVFeldJUgJZeV2rWp
 Lvht95mNRepkwwALFXdACwfdeVV4247dD0YJ3Qe0PvuHCNy3cktmrflpFiPZvG0xBO1dU8Ix7mv
 vUcNitvH7Brc1g8oSnBNPX/cwsO76SuoRUsNg==
X-Received: by 2002:a05:6870:c20d:b0:455:d4ba:1db4 with SMTP id
 586e51a60fabf-45690474eb7mr8759513fac.28.1784573965645; 
 Mon, 20 Jul 2026 11:59:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568e73d143sm9360601fac.16.2026.07.20.11.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 11:59:24 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:59:20 -0600
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Dhruva Gole <d-gole@ti.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Johan Jonker <jbx6244@gmail.com>, Apurva Nandan <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Hrushikesh Salunke <h-salunke@ti.com>
Subject: Re: [PATCH 05/11] arm: mach-k3: Add initial am62lx SoC support
Message-ID: <20260720185920.GD749385@bill-the-cat>
References: <20260717-am62lx-v1-0-b9830633afb8@ti.com>
 <20260717-am62lx-v1-5-b9830633afb8@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="en9xLOAbCvLK6aHS"
Content-Disposition: inline
In-Reply-To: <20260717-am62lx-v1-5-b9830633afb8@ti.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 21:12:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784573966; x=1785178766; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AOxLACfUIOBP2Xx8zYWmMVeb9ya4STWjBgD3Xtd7M/E=;
 b=VDvG4DdOv3IBufou9ckIl/NwBe5Gtq4W4iXjeCNul/XV5NzBr5OpZb3DV+oGwJ56yd
 JABjIYNc0V/3Y7HqgFeubYhPVjAxt4P0COoSMVZze19E0rWFQrTKogRHO9yFU5tFsz39
 Tw7u0ZlMdOOM6jwXsSGCIrdfCJcL33LkV6jAw=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VDvG4DdO
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VDvG4DdO";
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


--en9xLOAbCvLK6aHS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 06:23:35PM -0500, Bryan Brattlof wrote:
> Add initial mach-k3 files needed to support boards based on the AM62L
> family of SoCs
>=20
> Signed-off-by: Bryan Brattlof <bb@ti.com>
[snip]
> @@ -84,6 +93,7 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
>  	default 0x43c3f290 if SOC_K3_AM625
>  	default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
>  	default 0x7000f290 if SOC_K3_AM62A7 && ARM64
> +	default 0x43c4f290 if SOC_K3_AM62L3
>  	default 0x43c4f290 if SOC_K3_AM62P5

These are the same values, are there other places where we should also
change SOC_K3_AM62P5 to SOC_K3_AM62P5 || SOC_K3_AM62L3 ? And now the
SOC_K3_AM625 / SOC_K3_AM62A7 example is also staring me in the face. Can
this, and some other entries here be consolidated? Or, would the
consolidation lead to harder to read entries?

--=20
Tom

--en9xLOAbCvLK6aHS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal5wCAAKCRAr4qD1Cr/k
Cg9SAP9nozuk6WP1UEuh5UWDHub8hZvoOSXAJc+JSi7q25QWGQEA6PKehcQdhtfE
l6rXLn8YtyXTeol1nq7+/qctdVL90g0=
=AMrG
-----END PGP SIGNATURE-----

--en9xLOAbCvLK6aHS--
