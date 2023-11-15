Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAC3C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F02C787206;
	Wed, 15 Nov 2023 23:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RSE9EjOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5221869F7; Wed, 15 Nov 2023 23:36:28 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D50F87206
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7789a4c01ddso6775285a.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087785; x=1700692585; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rh1PkK9F848/V84yBdFyEg667lZdKoxqzHlGOAm5yuI=;
 b=RSE9EjOPwVAJ7WbBTQhdYpn00sJOtXdRWyNjxmH9dtNDIVuHjyyYZkcBMBN6uU6iRm
 zKiHHBdsF/OxPGHM167xPfpdlV1S0V5IzwOTaD1gBC6mwNmC/pRzje5eEgeYV7SNchX7
 I5NzH1Jbf9zyT3w+/Qs43O/sZCiDj34/JE1tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087785; x=1700692585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rh1PkK9F848/V84yBdFyEg667lZdKoxqzHlGOAm5yuI=;
 b=LDCmJFFguDvpobDu/+ILEzUDhW49WRb7QoJYyZTEWTPZ60j/44mbuUbJ0NvWL8C5U5
 gu+gboWEx7ebFYRQrdlyAVC/7SHk3cAT+mwAz4tgu0OkmYqEZZpZUxK3afwZIENFgliN
 6kN38iAyeOAHsayoCWNHXVB0kQeEL+YEsTcZwy0U0UcSVzDLlPtdS99xtLI+2DCb1ZS7
 kfWmXfop8BmzGuyfjU8XO9e96O4bUunN6qmF0fv4LMUbp18ZT+nNQBsjbj5xgCGhpNsF
 2tiHjxJA3zMlGxFv8G9rNtkRsmnnfwE1PZ9WPduLPiCBcaQ5WsvsqqiaPP7m1l5129Ox
 v6Lg==
X-Gm-Message-State: AOJu0YzxeqeEgB64wFlvB2jDM9AEnqjOxHz7yc8InKERZwHIScCrrNPb
 Xi7uMgcdWK8QtgIRSeJj82J/NQ==
X-Google-Smtp-Source: AGHT+IFtBrNnCM4JE3wPrEJyDNoqWV99SSjOG3lDu/liGc5e4fKNRe85ClZZE87HqR/yTHBCsgdYhg==
X-Received: by 2002:a05:620a:3705:b0:774:3147:4274 with SMTP id
 de5-20020a05620a370500b0077431474274mr7713576qkb.14.1700087785415; 
 Wed, 15 Nov 2023 14:36:25 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a05620a260a00b0076f21383b6csm3798972qko.112.2023.11.15.14.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:36:24 -0800 (PST)
Date: Wed, 15 Nov 2023 17:36:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 06/29] bootm: Drop arguments from bootm_start()
Message-ID: <20231115223622.GO6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="16c9BYAsYzlOaH54"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-7-sjg@chromium.org>
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


--16c9BYAsYzlOaH54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:08:51PM -0700, Simon Glass wrote:

> This function does not use its arguments. Drop them.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--16c9BYAsYzlOaH54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVR+YACgkQFHw5/5Y0
tyyzNQv8D+DliDl9QC4iDDPY6DQocFIGdbgtpwhtTjNilUJftGoKX1eqAihhU+O/
1XJaVs0E02SKB/G091bWKPg+2YUz8qM5KS89/Mjt4Qg4TYUGrik+lRbPXcsOAgFh
Fc91jkUAIX0NrSrltPE8GJX82c20Gt8yn5qOjIQ5zqEpa863t54LdLqr930I6LFl
88fgD/iCwolqyF8GduAAfAOc0Ack4Eif73KQiC1y0fCsipkOu61kVBdmmZ+30q1n
J70NGcUnb4eGuSIx0MLgVVuO7uVgp/PkbbPDC1RTQYW2kbS8zkTzjBB0KZBEvBMS
Fe6ZGfB4mXvzyMKNCslLNK8zUPW1omG7SOi/W+ipJPDuyHxvNZCDih6uhNCDHpfY
+d4jDGFCQjWE/87GzFF70rDo3zHbgExrkUVTCW9toFR0dquIIAm9LRxIJjueR5Wf
hxdnycFgyY8mqzkVHMtOgvhmtFGjhspvTNXc8bzH6ssrBPRTOlqBM4xX//yiYZS9
cS57OHYj
=Ge8G
-----END PGP SIGNATURE-----

--16c9BYAsYzlOaH54--
