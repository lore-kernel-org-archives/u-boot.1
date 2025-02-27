Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE94C282C5
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 17:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0C808129F;
	Thu, 27 Feb 2025 18:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q8KEvUUU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822F681280; Thu, 27 Feb 2025 18:05:04 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E907D81253
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 18:05:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-222e8d07dc6so23554845ad.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 09:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740675873; x=1741280673; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pb/GVLq9qOH19y+fjrTkCdmpDzClfngmHwDB6Ji1ZUw=;
 b=q8KEvUUU5nP9OKZgsJ6imMZ/WFIUzC6DLx1RW6o+0brXnN5xPqCUQSxuZsaoTye+5w
 ikEk4mfz6ix+U1petUVlPyufZrrDPK4lTRxRGRVKPqMrbxaBvo1rI1fFOW019DbJxPSK
 E59BlJpUjo8DoYdR5SNbZe7DJbYrPh6akmrks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740675873; x=1741280673;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pb/GVLq9qOH19y+fjrTkCdmpDzClfngmHwDB6Ji1ZUw=;
 b=XNCCAZZeVaAku+lQFG+3L1MaTtwa/yQZCSuPFRYXUSGze7hnNdFQIbmQikzGLubY9T
 XzNpyUv+58f9PbisXSNvXv2SgqQM3DwAhM4uX6DmIoON9RTXx3ZS1m48xmyglqZF4KFK
 cS7wUmQ59VQqInll/W3Fpb5CoYNEVC7mpou0yYgnT3aRst/Nsgr+UyStxXBRjzqdaW0a
 FefT+dyZqVO1+tMs1nyJUboSi+or0XiO+R3yV6XIepXMjz6mdAhpEKEbGS+6+SyqXSkS
 jRNMaDnK9D+TcFdxwd6+qHavuu1/FeenDWR5eC8xgTvGH/hMnjaWdavRCyWFld3MM86Z
 j09w==
X-Gm-Message-State: AOJu0YxtnSI7NNV94zBfPul5K8N0PsmNthCDhyef2W7XXVSa0Uc3VtLf
 TdPVcHB7cSejKQImrsvtuWPQ4U0r+m9dYJFey59Y+K4pzorbwn8AfDzpbZ2KQ/U=
X-Gm-Gg: ASbGncvMhd8Wv1KMVSrB1hc1pSdsWu0E3XMECyrYO668//XeBwETv6zdHkJo8YMoHQr
 TGKZ2KwXN4lEC5NeUwFgerKMZE2d1QU7yQsVPkobQ1CHeqj9BlMqg9dD5XmX3iGa3HElHzU3Dse
 mOAokb9MFeaDQkdZAblbfi4uwu79VRJRCbdnGVaT3rcaPT3JWFwHc8X17hbuB2Y2j2xqULMbxhf
 IXKQ0HyfIZGCEUJ+a7Vn0vB2qKbHoCM2TpYvIpZ2ThC18dpiCAJAN7gBtfsH+eKg10K1yNi/Bun
 eFoAyocJvNbYD4Pn39hOyJtz
X-Google-Smtp-Source: AGHT+IGD8oySG4eJql+2p6TepSuCiP2YaVgbUCPuGBsuX1vTojuvraZA9p7FZGrSLSbq4CELNy1B1A==
X-Received: by 2002:a17:903:fa7:b0:21f:892c:ea61 with SMTP id
 d9443c01a7336-2234b05eb20mr68879955ad.19.1740675872749; 
 Thu, 27 Feb 2025 09:04:32 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223504c5bddsm17387885ad.140.2025.02.27.09.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 09:04:32 -0800 (PST)
Date: Thu, 27 Feb 2025 11:04:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 15/15] cmd: ximg: Support LZ4 compressed images
Message-ID: <20250227170428.GD2640854@bill-the-cat>
References: <20250226221607.1283592-1-swboyd@chromium.org>
 <20250226221607.1283592-16-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XjmIzspteR7yWioa"
Content-Disposition: inline
In-Reply-To: <20250226221607.1283592-16-swboyd@chromium.org>
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


--XjmIzspteR7yWioa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 02:16:01PM -0800, Stephen Boyd wrote:

> Add support to decompress LZ4 images. LZ4 is used on more recent
> Chromebooks to store the FIT image.
>=20
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--XjmIzspteR7yWioa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfAmxwACgkQFHw5/5Y0
tyz0yAv9ErMthdji/1mstImeymgP2HLfjQk7w+0Fo+tpEm6FfpwxQ3I5+0rrp59Z
SRX1Jx1N0mjVzoCRqkXTMN0luNDBsPZokBGtPvvPR9gxO1agJzNSJqJTYJfUC7m3
zKdVEwVe/cDBY6NIgWMgNAzc/Pe1w9nrQ7ZI+Z12QPwqmxc1ePSGW8mEq/ccEviz
f16wyjrIcQK1kuARjLeTjQtqW+p1uUrE4HaWk3mMFUrK8QshstwCg/zfCxEF8QsO
yTZEmaSGSFDIqpN84yG2OSscolkP6eTvVrC4XMyRBZewUJVqjNLUqbrKkpDNX9gf
WKJm5up+TFamPlF2JwjCF6YIZSJBHr8e3s83786yDvwkQ6+gKArw95RcoHiSc0dF
/RqbyKn8RPQgHMI7fRkU7YpG/+5jaSxtGywTHa4EFgxl4rmu9Xl1pVrHk91kjIWV
XIr8Wh4h7mnMKIhnuef9SdRL/LzcGiyFCkQWe1Fb9GSQJAOAXi0wM7K1266nf3hh
F/DEUhBs
=NLP2
-----END PGP SIGNATURE-----

--XjmIzspteR7yWioa--
