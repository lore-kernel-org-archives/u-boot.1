Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D90C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 18:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86A2786487;
	Mon, 28 Aug 2023 20:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nrQZox0t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DF7C86487; Mon, 28 Aug 2023 20:08:10 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 482128648F
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 20:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5921a962adfso42063087b3.1
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 11:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693246086; x=1693850886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b4lyLgkhzSG8lMy6CF5deumMtW6bne2O84u07z2w268=;
 b=nrQZox0tsw8e+sypuM+B+P/eaMtqwwjmSNkeZF0kSDunluo5Cafr9Hhs3f5JNspHB/
 ne6/EW8tUQnEb4EDOY4TlJOTBCd0IjJSDyjVb5EQv3kAx7ihIt0lPZl46wF1cVnzLU6W
 TfmojBklrfyEQGPQbEDx0wKl0VeLCr9q+ECxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693246086; x=1693850886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4lyLgkhzSG8lMy6CF5deumMtW6bne2O84u07z2w268=;
 b=UXW7J0O5huXMJLp4yPLKBuC6PtaA+5cFcu6BsFYuU1Hht+zvrkHek+1DUy+kbsH/Ht
 Jw9db1AP7vDFD2MQm5sTnrIebQcov9tomDI8B0zlgpmPFssFSWA4NY4HEvhAjpqXt3zx
 t6msnChExKXsUIR2j3N4B5FEGc4VzXqbPRdBZcDKi7IHJdLBew6ZdTB2nIbJFcSb6kb/
 YXuuM6ZFsXt3tFmt320+WXHLpwfTND7KPou2FnSeMq8FkOkiSKxzAsBSBYYGd+o2LqUJ
 3EAmo7BKeoaPdXlXi8t+0Hg8v9a6ev7JXm4pT7Su/dpHDygNVIS57wkizQl22OdIc/qT
 cG8g==
X-Gm-Message-State: AOJu0YxFtN5h2gT1Nu0XYMjmhL9Ethy0sedEST4G7YdYy85SM+v+Hb/x
 2Uaa94QDCqX3JWj/oXaKI+Y+xEak8tyjqclokOAVeQ==
X-Google-Smtp-Source: AGHT+IEcSPLA1GetRdMsucOnO9KHLGoZ3z0D7YAci0pj5Pnu6LfFYdRQ9oPdYtYBIoKMLIMtGYMKog==
X-Received: by 2002:a0d:cd45:0:b0:561:206a:ee52 with SMTP id
 p66-20020a0dcd45000000b00561206aee52mr30731750ywd.24.1693246086037; 
 Mon, 28 Aug 2023 11:08:06 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c01a-9a8d-1e42-2ea4.res6.spectrum.com.
 [2603:6081:7b00:6400:c01a:9a8d:1e42:2ea4])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0de501000000b005832fe29034sm2275490ywe.89.2023.08.28.11.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 11:08:05 -0700 (PDT)
Date: Mon, 28 Aug 2023 14:08:03 -0400
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [RFC PATCH 1/5] dt: Provide a way to remove non-compliant nodes
 and properties
Message-ID: <20230828180803.GK3953269@bill-the-cat>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-2-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i61b4jgpx4JxEBfD"
Content-Disposition: inline
In-Reply-To: <20230826090633.239342-2-sughosh.ganu@linaro.org>
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


--i61b4jgpx4JxEBfD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 26, 2023 at 02:36:29PM +0530, Sughosh Ganu wrote:

> Add a function which is registered to spy for a EVT_FT_FIXUP event,
> and removes the non upstreamed nodes and properties from the
> devicetree before it gets passed to the OS.
>=20
> This allows removing entire nodes, or specific properties under nodes
> from the devicetree. The required nodes and properties can be
> registered for removal through the DT_NON_COMPLIANT_PURGE and
> DT_NON_COMPLIANT_PURGE_LIST macros.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

So, the conceptual problem here is that while we do need to have a way
to purge nodes and properties that have been rejected by upstream, we
also need to ensure an upstream attempt was made. To that end, how I
envision things is:
- When we build the docs, something under doc/develop/ has a page /
  section for each binding we're purging, which links to and summarizes
  why it's not appropriate for upstream.
- It's non-default to purge said nodes.
- We at least make checkpatch / et al complain about new purges being
  added, and CI failing on the number of purges increasing without also
  increasing the number of allowed purges.

--=20
Tom

--i61b4jgpx4JxEBfD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTs4oAACgkQFHw5/5Y0
tywLpgwAjY5HA0QxGPY1ZnRc4c9uK8AWlfB3NcU+a0mejSA5YSCIYnJMmofsVnY7
FCJCwVSUgm7ZGkbn8a9uzHwoUyo6llcX0S2725/0BtTTK5G5ShXrO9q1jdUAMIMJ
Wji+gVRGxvJ5eESv0UCRjrD3f+A2V/+AQjRaM/lrb4A2RvuCTUJ+QftXpw/pYBXe
PQQ0zpgonEE2Kfg68aZy9UPddShjvmPAjumTs0IviVM3xvVZsbOhHQHv4NcFScJ0
ZFzMzells/nQp+m0huDkLBJ83g/0+gAyJviVlhiSnvU1uYg+OxWfP0M44JUFKKhO
bOmtEGy3PKRYXZKFyfFU17JscR3ieHB5dbxaitcaDVyu47LKpchDWQwhKekLMrtL
9/dlTEQpenGE3CLbz6iS6FtfM812JDj+ivIzNc5Hud5uXhroRbGXAx1MZeSDbO9z
qwzoHxgnyHhjlx1/ncAzTXPASjWpcQzT1lGkepA9tjdHP0HCxve4kAiPJTki+zor
VLHFdjWe
=IaJN
-----END PGP SIGNATURE-----

--i61b4jgpx4JxEBfD--
