Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26660C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 20:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62ADC846FD;
	Sun,  5 Jul 2026 22:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UAnlvRxP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93BAC84832; Sun,  5 Jul 2026 22:26:38 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FC1B846F8
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 22:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e9ecb1e13cso2035357a34.3
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 13:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783283195; x=1783887995; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SsiRJw2w2PEObiWbQBb5kBFhTIILv0boIvFsENuRrGk=;
 b=UAnlvRxPm4QXpzeO9f2BmPFbkEN+4OBmXtf3ggqK5UBuuYYnAsBu1uJRD1pPWzEXng
 MxuhPE3zOTTI2yiqv1PNRx8bUDUIlSNrN/oUHyS+j8EoH/h6LL0IQ9K501l8NEg8rIZe
 X4EnBwKZVbJNQDKvXKHH8gbhxIDfzXIM2a3uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783283195; x=1783887995;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SsiRJw2w2PEObiWbQBb5kBFhTIILv0boIvFsENuRrGk=;
 b=K8Xo+sfkZsApwy03C4w6EogBtQQhqQts2aTi52Gd5aUYyeIp3JpKvtEx8OcQbPUo7u
 8I4NDlM9RtqPodxsug0UoeyduQ1e0DLFv0ARPJSjIkhwK+8P0r7Odyn7e3og9v5/3hq1
 lUU44HSc+l5/E0dYiaPD379jPT/FQpz2utX/+7oYJ5W2nHocCi+KZ5ZwpCWvz4ksBkc4
 25tY7oLH9eYTXakHEGRt/OBFWt78QAmYUA4mFzE3tqiidGb7k1e6yPsFiS04LOaAh2T4
 QkLW94TBkj7t4BtDeguZfo/ZqNqUltEmhREfp0snamszIIwNbhnn8H2zW/D7fMaPGU66
 oPdA==
X-Gm-Message-State: AOJu0Yw1AwRGANeIUn7/OdAVFmYJfTcc3cdtPlvqx8Frczx8eio3/8su
 eVjdeUwyz3e3lPeMBAJrKdSajETLHHSjC8QwfR/EXGt9h7f6nusvac6sxMtaMunLS5U=
X-Gm-Gg: AfdE7ck+27m2vOEOlyzL0lixXX4UcOwLKssQEyUIuRfoCvTHjrngfmr02C7XtyFfOYz
 L8lW3bSGe6+/JlgRcogDCXuS5icMPjhmd3hOQBF8fUGxe5XwedXCyt6CR9ksZx5904KtGPdHkkn
 cvUlLMNGWTwrXrX0XlEVPntxQLKAbKbF8WeTKsrVStvcZpc5vte/H8w0cBRlbhjWV+3Tm97PjGJ
 MpGfDWLZv9EjRnif86aXW8LHmfbkJggktZ3F1Lk8VVAh3axR4OeGaFZVsiw19WA20XIb24qnD1Q
 QShmRdpjeBaekb3kPfyyNHUpeWMNhRqdCppVs9o4KzXqnXRqq1pDks9aEHiNQetGzQ29PCLUj24
 Qk0w0iVuf5BiWAMAdTNkNRi9K95231xAvy222EMb5q3lnyRKUBMW1gzlrE64lSjHc4Ky5P4VKd7
 Jyq2LOrIZe+NdnSpQXWA+nEn66rRv1GBLarJxe7mcV2scd3GY/4kZRnBEtV3DfKioh+DtTX8oaQ
 NBv1gjeYZEB2uKlP6zW0VN0S7lcFugiS+RkXw==
X-Received: by 2002:a05:6830:82b9:b0:7e9:5de:cb93 with SMTP id
 46e09a7af769-7eb7fe84cbfmr5548081a34.18.1783283194715; 
 Sun, 05 Jul 2026 13:26:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb8a1fe31bsm3490931a34.2.2026.07.05.13.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 13:26:33 -0700 (PDT)
Date: Sun, 5 Jul 2026 14:26:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Javier Tia <floss@jetm.me>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 01/11] doc: Move the b4 guide into sending_patches
Message-ID: <20260705202631.GP749385@bill-the-cat>
References: <20260705193251.2190705-1-sjg@chromium.org>
 <20260705193251.2190705-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2q7wMoZ/wsWdXwEZ"
Content-Disposition: inline
In-Reply-To: <20260705193251.2190705-2-sjg@chromium.org>
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


--2q7wMoZ/wsWdXwEZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 05, 2026 at 01:32:12PM -0600, Simon Glass wrote:

> The b4 contributor guide sits in the coding-style document, which is an
> odd place for it. Move it into sending_patches.rst, next to the patman
> note, so both patch-sending tools are described together.
>=20
> The b4_contrib label moves with it, so the reference from process.rst
> still resolves.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--2q7wMoZ/wsWdXwEZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakq99AAKCRAr4qD1Cr/k
ChBsAPsGNkNXeJzjix+BytJKSyKOxxFEBn7B9FWJDf82wwh5VQEAgZEFrIauCizI
ZWquueFinUH33xwZ0xtTAUpFHdiESgo=
=Rmsx
-----END PGP SIGNATURE-----

--2q7wMoZ/wsWdXwEZ--
