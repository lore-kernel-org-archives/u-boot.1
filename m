Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688D9CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 15:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1EB58341A;
	Mon, 11 May 2026 17:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hrqzfLmv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DBD683A91; Mon, 11 May 2026 17:03:53 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366B381E18
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 17:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dcc9b506d9so3566470a34.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778511829; x=1779116629; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WAEJ/TCPG+/b+RbO4vi4vT9yY0Sk8mDg/w0VPQ9wGVk=;
 b=hrqzfLmvBw53FbVibbGTGZvPuvNuFFoZYgypSGbT4IfP0U38e5gAEBj0vLq3PJubaK
 0OEMVPlIA8zNWS/Dv2S74vp3ZThyAvIoLV1qMtarQ5GbrPPspON8pswmBo6BMn2v4DTE
 nfpInagKpcyQUDvaxnFN1uusrpKH04s3uaE74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778511829; x=1779116629;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WAEJ/TCPG+/b+RbO4vi4vT9yY0Sk8mDg/w0VPQ9wGVk=;
 b=oliHgL407ZFxbybM5JxHZTpoyQv7yH1KqWqYndKr5qOhTvAgbCrUBhyqJxdFWkiHFe
 1qdkFzBPl30IlJdQbUs8jjUBnJkgHxwiRk5anYOQF1c4J+cI8HapRjqBuojO8d0/Tp08
 pjnw9vkEUN/Muigu8PUaD8hwACTU2fPm5XJ00mQjJeNx5+/DUaoCmNvgpXEeKZULlQvX
 Qc9fp0YSZbKDoAgRxs0sPUFi5BzjEFeqGSeNeVYqkfcj+pJUixR6JVr2WfECujnVPvDu
 slzilhv1sTKt7v8k231uPfRabrhwdb+tSEj/gPTX1DJ+X3Lc6V1Mt5b5kpREdKU+LrLj
 xw4A==
X-Gm-Message-State: AOJu0Yywf3wSrmvgoLyfwWZ8G7uULyng/wVS6AeC5q5awn+ASs5TnY0p
 Pv4XgzCz6Dlx32ZM4A1keVRv4hVMmD5jumItkWbKnP/qpLxEeopsbMF4sKN/sns40Ok=
X-Gm-Gg: Acq92OEM94vdyLrJDOQ8UkzczIua5zdlOtYxZRJBjw1/h4pJfve4V2vInPhAY704Z7f
 PXaK6ktYM4Y5GAlpWOL20i+/aeRn2Akl8+bB0K0cszsy431U6CVDI+yPxE8jqekHUTx1AbqgT69
 /HBtgE4hcXXW5K59Yis9Rk4SAYkY0zOr8nlaJS3eb4fCi0CnlS6Sct11xKt9EtnqxnxWYssakSd
 BbEuldttqYWCc6QfQGH+yuSROuekdpSM0aYJ0wht9eYvKjY0TTN3ElaUW7WoFR7+YQy1k/8cQ/Z
 y/XG8o8MRtbcO2sYxxth//UBANylteDstKROAgyOXUGn2LaybtL2Xsf7+r4ttybL1ZeNMHNO9lF
 uZdXoa3Y1tkrVkIBjWFH1wqEzIGE529pZPvbKBnc27rngH7s344ZrpBwNaNQ8pVDk3B2B0kU187
 EZmmBSRT7pJiNG4sLDYLLVWUMAif+ipmLLZEz9jsTnsjVHqLQGydVbl2beq79qXRpU/tczdEKoq
 OrdYGp1btjiacjU4+x0o4NE4lB4UVkjLXO5reAzYuf+aDdYb5I=
X-Received: by 2002:a05:6820:1c9a:b0:696:233b:20fa with SMTP id
 006d021491bc7-69998c8f453mr12552936eaf.1.1778511829338; 
 Mon, 11 May 2026 08:03:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b5f955880sm737238eaf.2.2026.05.11.08.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 08:03:48 -0700 (PDT)
Date: Mon, 11 May 2026 09:03:45 -0600
From: Tom Rini <trini@konsulko.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@nabladev.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Philip Oberfichtner <pro@denx.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Fabio Estevam <festevam@denx.de>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 David Lechner <dlechner@baylibre.com>, Michael Walle <mwalle@kernel.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Benjamin ROBIN <dev@benjarobin.fr>
Subject: Re: [PATCH v2] env: migrate static flags list to Kconfig
Message-ID: <20260511150345.GI1858239@bill-the-cat>
References: <20260511144437.46645-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8c3biMvCCkzl/Sz3"
Content-Disposition: inline
In-Reply-To: <20260511144437.46645-1-james.hilliard1@gmail.com>
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


--8c3biMvCCkzl/Sz3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 08:44:31AM -0600, James Hilliard wrote:

> Environment callbacks can already be configured from Kconfig with
> CONFIG_ENV_CALLBACK_LIST_STATIC, but static environment flags still
> require board headers to define CFG_ENV_FLAGS_LIST_STATIC.
>=20
> Add CONFIG_ENV_FLAGS_LIST_STATIC and use it as the only board-provided
> static environment flags list. Convert the remaining default-config users
> from CFG_ENV_FLAGS_LIST_STATIC to defconfig settings and drop the legacy
> header macro from ENV_FLAGS_LIST_STATIC.
>=20
> Move the environment flags format documentation out of README and into
> the developer environment documentation. Include the format in the
> Kconfig help as well.
>=20
> This lets boards configure writeable-list policy and type validation
> from defconfig without adding a config header solely for env flags.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>   - Convert existing CFG_ENV_FLAGS_LIST_STATIC users to
>     CONFIG_ENV_FLAGS_LIST_STATIC in defconfigs.
>   - Drop CFG_ENV_FLAGS_LIST_STATIC support instead of appending the new
>     Kconfig value after the legacy C macro.
>   - Remove the trailing-comma requirement for board-specific static flags.
>   - Place the migrated defconfig entries in savedefconfig order.
>   - Move environment flags documentation from README to
>     doc/develop/environment.rst.
>   - Add the flags-list format to the CONFIG_ENV_FLAGS_LIST_STATIC Kconfig
>     help text.
> ---
>  README                               | 45 +---------------------------

Thanks for doing this. If there's no other feedback, can you send a
follow-up where you remove this whole section from the README, and if
there is other feedback, change to just removing this part of the README
(that's the usual practice when we find content in the README that's not
in the rST files).

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--8c3biMvCCkzl/Sz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagHv0QAKCRAr4qD1Cr/k
ChYGAPsFPXG4xTKHep0ECz8iGhChtJJg/OD1wz8qO6wgiH5StAD9FZ0w1vO8pGsp
k7b2V0WfHPdsU52evQYwwHKKDuZlBgI=
=gaqf
-----END PGP SIGNATURE-----

--8c3biMvCCkzl/Sz3--
