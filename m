Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F907CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 16:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69B2A84704;
	Thu, 25 Jun 2026 18:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QrMK6YCD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CCF08495B; Thu, 25 Jun 2026 18:32:21 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1ABA805D7
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 18:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e94d272a86so1634958a34.2
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782405136; x=1783009936; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pQ+V2K1rVr6oaPvicDh1vckSbHwZRBPFRpHUn4rjH14=;
 b=QrMK6YCDU+fc+xlyI2MJ32g4f43at70Ej9m7RadajdYxKG2b8wciJnm4621xfb2y3A
 TkhimcuSXHOctQ014J0cVNxwsqcKn1wDtA8ZBxAhED6RmVhigV7qF6fW0Ak1y6c1PnMZ
 vEeVEn0slvN1B0PxK/MFqohfxAhPr99O2tp3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782405136; x=1783009936;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pQ+V2K1rVr6oaPvicDh1vckSbHwZRBPFRpHUn4rjH14=;
 b=bV+LOmjgktEVPC+fqrzCzyeDO2e8RvX48YDPFJTk423ToaOapXVNdg/5Q7d5iQGMxH
 qa/9GVVG2A2YtNxWRVeN/Dw979bvYamHuXjkKKW46+Wv7TGGkE734LdVOA1wL8l4kSHE
 t7CqH6zL7kKZvNYqfVI8rZPJAncX8WW7MirBCrWWz+opNxoTlgm8yC2lEjlA50vSgun7
 Fkg09+08CwIdScL21gnmIBJq/kbtTbVTpfJ2fJrJBThCW5rLkRfK5v1jX3NcaCqnv1o2
 KNY0QwQ7HPzUPE7RhJ3/d4RwFAlDDVTt9hm4U6uP6+vfC561U+ho11wBZDZjUBU7IcT+
 135g==
X-Gm-Message-State: AOJu0YwuWg4x4C8eYuOpHMJIkGDDPu7uRYtosF6C3C6WPGXtFbGtOL9w
 UA0OqT0EBXuICzZkvbnSssJxis/5DyNpUoW7LWtKgaG/srQzDGtW81+o9gdJfHvA+iA=
X-Gm-Gg: AfdE7cmr/94LZtEB0jEIXPKX6mgQR37KVpkrsoUYm5sXUcTXUJU94zzZwshptfTGKoN
 tuegqHIUQo8p3OfYiAC+zkAwLZTNEkHom6DT0U4Yvz/GdT9zmgHTdHmkgSJqq36YI+rBvxiJ0yx
 wbGLJuFeezIscOrRSFvzYnTCIC+fcj9fTckRPeMALWOwMfcntrReMjFIY1mBa1XNT3YAUdHvUpD
 f3PSAiQZYimDXLYwtVFKDpr5yTpVixQROFeEuYUDhDOgJatWd3Fpx7sfh0fbjjqrrbR4CsYLMGn
 +GHM68vPXW7vu6xMvnMOUthP6zvBi8TWeXKroopwFtxuXVBWc/+xOOl7e5zaFCO1yE1C+XeGoLO
 Cp6AC3PboDX8kjVnutFDSL6xA958anTH1/LZzW+iJVYRohwnAoU5wFt1QZXkQYbIiwl0mZIo4Pz
 5HCtrW2cIvHPxSDxDuVax1doPfjZk+ZmW3ru5/I2rpx27cWopRVcdJS6jQUyOKoATAfg5Ok5Icw
 eIjEKFtrjy25aDpVuXI6fXB3sSRuswmFaqYI77A
X-Received: by 2002:a05:6830:6af9:b0:7e7:45f:ce3c with SMTP id
 46e09a7af769-7e99c216e67mr2862027a34.14.1782405136486; 
 Thu, 25 Jun 2026 09:32:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4472f0464a6sm12829073fac.15.2026.06.25.09.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 09:32:15 -0700 (PDT)
Date: Thu, 25 Jun 2026 10:32:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Simon Gaynor <simon.gaynor@ezurio.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Xuhui Lin <xuhui.lin@rock-chips.com>
Subject: Re: [PATCH v2] treewide: change email links from mailman to
 patch.msgid.link with message-id
Message-ID: <20260625163212.GT382693@bill-the-cat>
References: <20260625-ml-switch-ml-links-to-patch-msg-id-v2-1-1f15d8655c8c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ro0T1QP70GI5RKk5"
Content-Disposition: inline
In-Reply-To: <20260625-ml-switch-ml-links-to-patch-msg-id-v2-1-1f15d8655c8c@linaro.org>
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


--Ro0T1QP70GI5RKk5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 05:36:15PM +0200, Neil Armstrong wrote:

> In preparation of the migration of the mailman mailing-list currently
> hosted on the denx.de infrastructure, migrate the links in the code,
> comments and documentation to https://patch.msgid.link to be future proof
> and always link to the expected content data and uses the message-id in
> the URL which will help find the appropriate e-mail in the future.
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks for fixing all these up.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Ro0T1QP70GI5RKk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaj1YCQAKCRAr4qD1Cr/k
Cl4FAP9/De/qL+OagseTIrutnjRTHjA8N8MyfvZPi4OAGYqOfwEAn0DSF37+r5uB
SdcLOCAkXWeDML6Q3s78Y3nRuhbbvw8=
=GTkP
-----END PGP SIGNATURE-----

--Ro0T1QP70GI5RKk5--
