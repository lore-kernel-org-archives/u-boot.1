Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BD1C282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 13:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73D89811B2;
	Mon,  3 Mar 2025 14:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K+/kO2Kt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 550E0811B3; Mon,  3 Mar 2025 14:48:24 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D84E5801DE
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 14:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6ef7c9e9592so33751847b3.1
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 05:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741009701; x=1741614501; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=60qN+HLjIdgXEwQeHf4YKvHTOsJ/SulMKNaRYG14LhM=;
 b=K+/kO2KttRTcPD/NfVlJfhuFarSneIaKYNyG6ThKyU8H3bUJhcLyYKLy/zoPNbZH5P
 QomkvHLlE60no6YNKFbQBYj4RNnaR+Jp3BvbCzeJ8PWFn8YkBlp27oB6hkacWFIig6Hk
 YFPgql3+rUIB+b9XZsgAXxQ+lldf7boy6A5gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741009701; x=1741614501;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60qN+HLjIdgXEwQeHf4YKvHTOsJ/SulMKNaRYG14LhM=;
 b=dGKMj73C6upEOUZzLw3wPBooytpg8RE8AbCES1x9aIS+qJ/7ASK8hFbsVCTtmLgtrx
 YAyxBx/141MMSDlDcWEMP4nuPoq0Qk+AbtwzjQf3+iSPxEZY77KKym7X1XPeKFsahmCF
 /SiKm3RjiMZJ8ADrbrEWxCfKIc5sn8xbRjG92RsUFZeE1V1rDpHk0ZFyUU2WydqJEiXt
 AuTxpst+D/1DZNSht6motBAg+15xG9bxoXx1vljuYxLU5RNhpYiLdG6D3oeobaduNraK
 iMuC7fqepuDE9EftsPRld6rhlIgQReyEKUKdDXvBdzBptCUTTIkJtJjSpLPKkXKtVkbL
 xdiQ==
X-Gm-Message-State: AOJu0YwpuIAP0WuxzpiEKDV7O7LpmknbS6AiJxHo2M3JHP6TI2aoUsDA
 VV2ygVdWNY7UgMLWDJgfcr64i4jMPU4AXmQRckymPK3Z0QTohye5jpwTR3PSyO+9hB71bRtUY95
 o
X-Gm-Gg: ASbGncuGMqu2nqn4D3T2/zJoG7yQfcenyi7MIs6NpKtYEWsF0sseH1OvClpMJsVtLdL
 S7/1At8bSk5M0P2M5pMTfoEZ1lzq5EUPK8e+T9B5TOsr4KWdnudnxHS1d38s8wuS3llv8v1LcEp
 hQYKvbatmBOv9rNho+GE4/NJjUPzS+o2gJ9qtcB1XuhMJc/CIXm/DMRrzrO4A8A1rni2AID01am
 EJf5urrVPzR+B3gxco2ooKbRRdQl6rNsaqnp5GioBbOpBre8TvAq6LbYVKleBs4RzsPQBxvpjWo
 pgZ0/uK6YfKnQDAxvbFJKoC96A/5KDKFIjMhM114RjU=
X-Google-Smtp-Source: AGHT+IFwBSejVPUbuqTeftzNgIlNCa7iaJCUhLwJgqwtnP5L6VMLiWo178bDJb2D9UmnCo8hSjfuqA==
X-Received: by 2002:a05:690c:28b:b0:6fd:4718:9bde with SMTP id
 00721157ae682-6fd49fd005fmr138045247b3.9.1741009700739; 
 Mon, 03 Mar 2025 05:48:20 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd6a1a1873sm9718607b3.3.2025.03.03.05.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 05:48:20 -0800 (PST)
Date: Mon, 3 Mar 2025 07:48:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: Pull request efi-2025-04-rc4
Message-ID: <20250303134817.GP2640854@bill-the-cat>
References: <9e777fab-8183-4938-b578-cf0f26936f18@gmx.de>
 <38CCE958-BF87-4BE0-9D0D-9E3ED8C3D16E@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vCnt5n01LbQt9b8l"
Content-Disposition: inline
In-Reply-To: <38CCE958-BF87-4BE0-9D0D-9E3ED8C3D16E@gmx.de>
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


--vCnt5n01LbQt9b8l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03, 2025 at 01:12:42AM +0100, Heinrich Schuchardt wrote:
> Am 2. M=E4rz 2025 09:11:34 MEZ schrieb Heinrich Schuchardt <xypron.glpk@g=
mx.de>:
> >Dear Tom,
> >
> >The following changes since commit b78f8677cde8b1dde31b66f5b780f2e9b62fb=
a7f:
> >
> >  arch: arm: dts: k3-am642-phycore-som-binman: Add custMpk to overlays
> >(2025-02-27 08:07:38 -0600)
> >
> >are available in the Git repository at:
> >
> >  https://source.denx.de/u-boot/custodians/u-boot-efi.git
> >tags/efi-2025-04-rc4
> >
> >for you to fetch changes up to 32a6c5eac0004bcfbb75d7ff9e9d627aca0e2852:
> >
> >  legacy-net: wget: fix wget_info handling after new tcp legacy stack
> >(2025-02-28 15:26:05 +0100)
> >
> >Gitlab CI showed no issues:
> >https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24904
>=20
>=20
> Hello Tom,
>=20
> these bug fixes shold go into origin/master. But it seems you created a b=
ranch for next (WIP/02MAR2025-next).

Indeed, thanks!

--=20
Tom

--vCnt5n01LbQt9b8l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfFsxUACgkQFHw5/5Y0
tywSzAwAk7rrfnngv+yLMjf9bbtdpFEiYaq7prc8uJeXk9mXuvDRT6osnuzVm7wW
X3zC9+DzS/PhzeIC6HR2XlQ1gXPzzyYWBOIg/wzC8TXHjSNJp5iA9tqVVpgxy+dT
kaSMarRG+qhVv6d6oo7+vTr9kwnSwW5lNjcfqV+RoOXxQFa6XCQOH6gckPuA5zWU
gk2i9FwNBEPRcpKb99wcqP3OBz6g2+pW7Gt3P8/VZQkMiu6XgUM5/KSi+WzyZoWV
lpODJ8HwYM4L0R1HlHuKKxDzlY1o0qKL1HazYF7YeviKUgt4RvCIJu1n/ys5eZGU
72hkC5cN0NZuBT+CDywb2KZFHcTorgFEXwEPgX2TYXkNiWHfaqJJ/3Zb8WeJrLeC
uTc3ndazN8KPJR9P89Maycykx3rvO+aNeDs/pZmD+eXBMOAv51VBGZkxKQ/BEt1W
OWaDc8xaSABbbiu+WoiLuIvxkYLodvEPTiHFERU7Mv4mpIOnn0jI+KWSCpeeG6F2
vi0HqBcx
=yaPX
-----END PGP SIGNATURE-----

--vCnt5n01LbQt9b8l--
