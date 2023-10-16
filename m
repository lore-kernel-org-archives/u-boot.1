Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572F0CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73D5386C2D;
	Mon, 16 Oct 2023 23:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="budnCB5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F38CB86B79; Mon, 16 Oct 2023 23:31:48 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38A6586B79
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d8a000f6a51so5602660276.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697491901; x=1698096701; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q2Y5h6/uzyvJKScexeD3TuTYE3xKZ28YYTSlfL/GVGs=;
 b=budnCB5e9fs1o5i7JL6AJVPuD4ONkuBYHWG/Xr/Tn8Zt57t59iEBLUPRoZpGyL5xyp
 lZuoXwMoqz/OqG8qBP6EvQGLqMuum6tCJbBDANw1+goiQmEAgY29+KiYup0dpR/025FX
 ADkHNJocs0PDei+v9SVjrRqS5/EgbhKXMfFLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697491901; x=1698096701;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2Y5h6/uzyvJKScexeD3TuTYE3xKZ28YYTSlfL/GVGs=;
 b=rVOPeVYGTzjdnnnXddWiGaqGaKG6lecFJx09S1+fqDUaNTV2io/042OfRlZaa2cVFl
 K9NSQQ+s9JQ+2/T6EI3AmUPWXqnkg7OVRhtfooHge4nIqUfHoNnD5+IyG1OGk3A7nRot
 G3yRF6NUIye2Mf+kCoqEeycF0ti3SnwpOdCdqeuQTpIdQ4EMz4IjRvtSCXIkrc9hY+Zx
 KRXF0o6bLOI7SSgN+kwFqdIa/yfbbKRI7P9saHbh3XW/wq7pkrTyrvkPFAinjFAvkXIm
 u5+MubgkAuVFtedV2oNQrFkp+4/c0fPf5ogNs4NniVqld5M5mzJsd2mfxHoUDqTo6VRJ
 kqgg==
X-Gm-Message-State: AOJu0YxVivmByLnnpqiFK4jUXRv5AlsztgSsAhs8qL9JbEyo2939aeJx
 iOLnx0BLhcYhoGtevKFEfYaCUA==
X-Google-Smtp-Source: AGHT+IH/8xD8g9bTLjcYGEp/jb61d2zeWsJryBi5e1P7oNwe0CDaEq+jtAikzVl6RC3o+I91F/R2cw==
X-Received: by 2002:a25:7811:0:b0:d9b:4a2c:7a73 with SMTP id
 t17-20020a257811000000b00d9b4a2c7a73mr208662ybc.61.1697491900887; 
 Mon, 16 Oct 2023 14:31:40 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 p13-20020a056902014d00b00d9a3fe483cfsm8612ybh.23.2023.10.16.14.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 14:31:40 -0700 (PDT)
Date: Mon, 16 Oct 2023 17:31:38 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Knecht <rknecht@pm.me>, Neil Armstrong <neil.armstrong@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Dzmitry Sankouski <dsankouski@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/6] freescale: fix long help handling in mac command
Message-ID: <20231016213138.GI3119521@bill-the-cat>
References: <20230930120147.59482-1-heinrich.schuchardt@canonical.com>
 <20230930120147.59482-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rG/SWEZTUKWtzBas"
Content-Disposition: inline
In-Reply-To: <20230930120147.59482-3-heinrich.schuchardt@canonical.com>
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


--rG/SWEZTUKWtzBas
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 30, 2023 at 02:01:43PM +0200, Heinrich Schuchardt wrote:

> CONFIG_SYS_LONGHELP=3Dn we want to reduce the size of the U-Boot binary.
> The long text should be reduced to and empty string in this case.
>=20
> There is not need to call cmd_usage() directly. It is sufficient to
> return CMD_RET_USAGE.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--rG/SWEZTUKWtzBas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUtq7oACgkQFHw5/5Y0
tyyV1AwApNQzsiGigJ0nUY4xtctw2QPNPCsXh5zJ/fTvyiJf0MVPSIiqs9sS9YV/
symmDBcF+y2/txhykB7LmrDa2EeUDRtnUIBcrpBHlTnTE4VqilPKT7N9HBeBENhd
5iW+BaaUpmtafbCnDutA5GRTG92fd910j6NKUJirVbKDK7CxAPHFVc0U9D5g9u7z
32l/ArqSDg1SQhZy9dYU8Bt6iVeEhiCHE6r2PD8Kgd0NL8lcXWLFD8DQ72NOn/CL
fu/F9T6OsKdZ5WHHuadomIbhQckYBqfvTmyGS+N9zRu2N3VLz8WKLlsXSMRYj5L/
w8sG62epmJGqcCbl9duWs+GKkryEwPh5Qipk1e4X6dPW/jfzHPPFRMmRwh4OTZY4
gKm8n4RGrpCBfwZccAhnbZfAKTGJeY2PFFVKOm43Dlnat/b52nNHNF1L7S3Kr6IJ
t6xy4Eh/tqU/oxF01cN9dJv4uVprG+QUCyD59UAob7P/gvDmpqK4zdjs1Ew+kqa6
i+Wd64lo
=9Q4S
-----END PGP SIGNATURE-----

--rG/SWEZTUKWtzBas--
