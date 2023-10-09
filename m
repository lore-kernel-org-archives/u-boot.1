Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773DAE95A91
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 14:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CDE886D48;
	Mon,  9 Oct 2023 16:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ljLWlB2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 643D086C1E; Mon,  9 Oct 2023 16:36:18 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4462F863C9
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 16:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59e88a28b98so39347867b3.1
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696862173; x=1697466973; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=98C1ihTk2K6RYBxxbygsTEeBfxRTxU7IAx8L+EKtxZY=;
 b=ljLWlB2PEoyIdgZ5EbgRV+agxrtCaICU7JnYIUxTRhTBfZwTLKynqzcmusKfmtHqG0
 uypnKQlNGHef83OVwm8W3dBFitZc5NPweX/vBSPxGLL2U5o2r75vnwSk/ENZ3QoSmCRl
 nA032VTrC84C7mo7LLczmOe/ZYOLl43f7Mhw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696862173; x=1697466973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98C1ihTk2K6RYBxxbygsTEeBfxRTxU7IAx8L+EKtxZY=;
 b=mnYM/NrsEUKChpIdVxYEcYl9rGi3vpZPW4PaS7JUhTJe6bBaTqQfHvhPjXAbvipscf
 Q0GJX/8TkfKCsE3MXcXgGhhlFYMH02NDO455JM0So/lUf4O5hq0tAdMvgu6u3+V74EYj
 eb+9/jSdGf+4Ivmf4hMTwxd97K8tJgI3why0x8TX274zxsim6I+s79lLfOxYxpExrlq1
 Oac0hjKw1cjVRZPf/YMXE5VrvbCtx/Koh+xdW4UY1HIIJg5JtAoI3YrHNuDDkh6Zgb5o
 k+gtGDC0ei/tA4lBe/99gJda9hpR27EBS2MAPdc8mSHa5cIa53XrxhL8HoAbi8aNCJRM
 +5Tg==
X-Gm-Message-State: AOJu0YwD7cQbauxQDkX1cUj3xslCWXfsgFGfSOmDSK+MQlAXPBlHBGX0
 JZhtefP6xrumn5tpVk0C22aNHHkXvHa6CqxwV84XJQ==
X-Google-Smtp-Source: AGHT+IHhzRPwFKTr8w+bqXQpCcBw3uJJWQ2j/E4eGwyzxKjvt1agq1JoguUGeUskwcZZNMYnZRlRuA==
X-Received: by 2002:a81:4e10:0:b0:56c:e480:2b2b with SMTP id
 c16-20020a814e10000000b0056ce4802b2bmr7924185ywb.12.1696862173032; 
 Mon, 09 Oct 2023 07:36:13 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fae2-bb7a-3833-e7d0.res6.spectrum.com.
 [2603:6081:7b00:6400:fae2:bb7a:3833:e7d0])
 by smtp.gmail.com with ESMTPSA id
 u185-20020a8160c2000000b005928ba6806dsm3724401ywb.97.2023.10.09.07.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 07:36:12 -0700 (PDT)
Date: Mon, 9 Oct 2023 10:36:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 07/27] test: Make UNIT_TEST depend on CMDLINE
Message-ID: <20231009143610.GM2227687@bill-the-cat>
References: <20231007231255.277623-1-sjg@chromium.org>
 <20231007231255.277623-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kxDjSS/JbN82Z9UP"
Content-Disposition: inline
In-Reply-To: <20231007231255.277623-8-sjg@chromium.org>
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


--kxDjSS/JbN82Z9UP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 05:12:26PM -0600, Simon Glass wrote:

> Many tests make some use of the command line, so require it for all test
> code.
>=20
> This could be teased apart, perhaps with a test flag indicating that ut
> uses the command line. Leave that for later.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--kxDjSS/JbN82Z9UP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUkD9oACgkQFHw5/5Y0
tyw4Ygv/duBlcQr4jKPuS03lAe5WrFYsjcGAgItKaFx9ew9b0XRRJnBftjBXw50I
EsdFONkm3qpGlteGx7dy2szgQ8wUrhzfK7yD1dLGpGV4LOwUaJt3kbLmavxBpRGH
mXBUZIdNCD3tk9kbe6+L6fLTKLuNYjFRRt7re+mp891N9QQGl6EZKvolp2M2kIU4
ekHpfAyX2blGokzSBVK6UxEPX62XgD8IeX+TjioEw+bUWfBYhAf2kgDAtSIZd68Y
2iaQnzJgU8CsLb9+rvTdJ9CDfGNr/0752YuQfDmcfuwpk4DizdeQ5TYudbjuuaZG
eODVJ82i3aAjQnplUKWnkdEPv0792z9Q8he36uSnPorn9roJPSCR4FeQ9EVNvPjA
bH5RcSFLD84QyVCDjMwh7975GM5gOpYBQPwoAlyNSV44ZQ9mhSzTNeIL3q08aXBz
s5Lr2exPuOF/aVHe5UYkgrdXUPWZKN0UbwVD4zJGHU0xk/xMt7HCkl8t7IFIyPgd
RJEqVseb
=WBPC
-----END PGP SIGNATURE-----

--kxDjSS/JbN82Z9UP--
