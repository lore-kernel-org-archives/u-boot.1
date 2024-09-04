Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A1ECD4F3C
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 22:25:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F87D88B89;
	Thu,  5 Sep 2024 00:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ns7ZrMPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9376E88BB0; Thu,  5 Sep 2024 00:25:39 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D64188B86
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 00:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-70f6cb5518aso112819a34.1
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 15:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725488736; x=1726093536; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IBBNXzxwnuKyu2H3mb2BrHHTKTfBxBtlW1orh5BP/AE=;
 b=ns7ZrMPPsN2So3SAC6TEbHWLOBresnEWYMxJ7yYzhnrflB9awU1qmvmboA96gH8RLS
 BByfwE3VuuqxMHqgEqzsgeqFm1WSeDroxm/CYQm88Srk3WoSo1VqZ3Zij/sIyTxPyJtQ
 RuXGSed3gg51L+NgEKFGWjPPEN62j3QMt/Mn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725488736; x=1726093536;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IBBNXzxwnuKyu2H3mb2BrHHTKTfBxBtlW1orh5BP/AE=;
 b=nuEC/+zKFWgx81LhQhzvPGAeC7ljqH/BZmUTwBX61CF5+DoDhiCqqvLUouAskNjE2n
 SmHl1UFRX6cYvLodxkFBFzMBgRKBwSoJryqo3aYHTEPMB2MPXExyoa0nrtc3v+ad7BtG
 9HpD70w3zwZEuiNSije0h1m1YpJXjgeb3bSXdm5mmmsm5UUeq9P+MeymDIiqK5ImGJia
 FiTkTruurg011TvA235JkpyhqinRIDpaqweuKZYUcD4m1UdYtxuZ4gi5YgEENH3zWSv8
 3zGg2MdnHSgNRzp4LTWPQG/6WEQ+Hd9fOVElHeUAE/vMmSPfBy6USO6zEYxMUi13xXXw
 7BcA==
X-Gm-Message-State: AOJu0YwXWxSXofoBN8+T9RFjiVyYdTDPPki4o1SvkNatAyk46MbLcV9l
 OLZzqLnF3DUIJeHre3repzZxK2sam7PlT+HoR8+PT++NtckSMxS+5PSTVNjz1M8=
X-Google-Smtp-Source: AGHT+IHsqdxaoSWxyQfCEpEtcSUUrfO8n0eIZ6sL0t96rM/D6vBpBal/a73lz1pmy8NOst3diGjIoA==
X-Received: by 2002:a05:6830:490e:b0:709:49c5:fd99 with SMTP id
 46e09a7af769-70f71ee9a36mr19151929a34.4.1725488736064; 
 Wed, 04 Sep 2024 15:25:36 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5202de768sm2494766d6.66.2024.09.04.15.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 15:25:35 -0700 (PDT)
Date: Wed, 4 Sep 2024 16:25:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>
Subject: Re: [PATCH 03/19] boot: Allow FIT to fall back from best-match option
Message-ID: <20240904222531.GA2479150@bill-the-cat>
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829145802.1827952-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6QCI8GN+kjU1VYHO"
Content-Disposition: inline
In-Reply-To: <20240829145802.1827952-4-sjg@chromium.org>
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


--6QCI8GN+kjU1VYHO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 08:57:46AM -0600, Simon Glass wrote:
> When the best-match feature fails to find something, use the provided
> config name as a fallback. The allows SPL to select a suitable config
> when best-match is enabled.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  boot/image-fit.c | 19 ++++++++++---------
>  include/image.h  |  4 +++-
>  2 files changed, 13 insertions(+), 10 deletions(-)

Don't we need a documentation update? If no, because this mechanism
isn't well documented, can you please follow up with that? Thanks.

--=20
Tom

--6QCI8GN+kjU1VYHO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbY3lgACgkQFHw5/5Y0
tyyRrgv+M5sLMosGVj/ON7wJ6voRFkUPfiW/AIGXlEHuPaV28VrgggzfpFjYmaXk
djuqg5KgWkZyV4GnP8/jnHYL15qJ53s2EyJb5QbixSIPFMz+RpP0XsCpF8uRpwsz
pOqwkUNFjcflfsjOWzeaxB4LW0Kq/EktORiN74yWrlGM//ArHBDhRW/6Ri9Ni5KP
hKaPy86LGQ1zDjjrNQBkAVUjYFHJuHj6/iZFH/lCO40JgTsWqQM+bq7mqQzBd+iq
1K3XX+LVsjk4F2v9MOEqMnR41uer7PFUiM8nfsz0/me8nASzivmm1jV8ql+nGEYO
pIiChNCKyd4Df5FQviQ4rnB23vfQtAnvzmLeP01eKg+nlOWS1PCX/ToP+66MAwMU
UH0op81mo/v5NuNB+oZ7I4odxr5aaJGKIkFaGk6ldJoV/VL5STjLlnJkGIhCrc1Y
+xK645GGhG+MTWvxV6sk/297xIzvG5WBkveiFwDViANUU3h9pXVIKEJ6SyUHAJ35
CQVe8U2U
=D/Mw
-----END PGP SIGNATURE-----

--6QCI8GN+kjU1VYHO--
