Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B32DC19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 17:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2066812D9;
	Thu, 27 Feb 2025 18:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bn1fzNoi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4AFC812BF; Thu, 27 Feb 2025 18:05:10 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84DC981273
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 18:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so23720255ad.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 09:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740675854; x=1741280654; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5R3XfBqDZqWgOD+2Ne9n9CrXPQ59JUtNJ3mHOuUPPFM=;
 b=bn1fzNoi64NDPT2j3+NKCAWij5u/R03Otg9UbcNGKL2GL68l3ev8k71Npjg02I0H6V
 K4GebCXZrHoftw3lY/1rvWfAfYsCxfN8XuPXIMx/beJh69lVQxAUWJMCBynHhEWl4mjP
 xmIhalRQHOJlZFcN6GBXK+0oOESjlSPyxTl6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740675854; x=1741280654;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5R3XfBqDZqWgOD+2Ne9n9CrXPQ59JUtNJ3mHOuUPPFM=;
 b=ZdixqndSb/Z6zWL2FASjSerk5ZhmZHQdtT+wwLCnG7fpc6Z8OEZgvV5lugZjX/qXBv
 rZ1erEtTLvzdVLxKvh6htxtuyfEgPYavY4hVT5J+/0J24iu/MPxeWsISuOP7j5RpEf6K
 wqQCDpwoE0Y3/QBQM+z+IqkWC39e0rZfSn/sKKtB4wnq6E/FZ/M/XZ8sNuV6k/0M3rw+
 sS9MPLuTQF+kioClYMl+/y7TRyTTIsyVmaJdMMsyOJXI7C8a7yd+GgPEM+35jr6SLeKV
 9Rpu2SxYqWyGEEVW0QK9Ub2OhlQaNTmWy47Ld4SMn2Py5Cp/LmHxIgK/Jmil+C9zeBzu
 owIg==
X-Gm-Message-State: AOJu0Yw7kkegumCEEKrzvg3KPUM03ur2FMWL4bgnvdZcjY0Xdr3D9kis
 LjzCfg6uRqBqi588QpQ7EO4QtQjZOwZIOSb30KJbcWlGMelcD9oGOWW9NBwlfLk=
X-Gm-Gg: ASbGncuWjzdCg5B9Ya9fELXcL7wQ6IIpxt0sszu/kU/MMF9yqa2fGAcRxGPeWGhdILY
 DK5khTJOlvh6TfTerHLZAWo4a7b9GmclwJPGEXotu+PIx1f/XGFFKNYE/m/kPOGByaohZVSZPzU
 AyrRWReuJrnmUZcKlUWMV3kDvrhj023xuA8EP8/0uxjVENx/o7QarKgbBJckUiHv4Kz7WAXdwtY
 WKjvr5vMLILsqSaPi7ccaLkbz4ttiiCCBwgY5JVDSF4fqXBrOJN801w48gFrxDWXFYKABFiuS41
 SDAA4ge3cO1rIkji6P4Z3/Bu
X-Google-Smtp-Source: AGHT+IFg2pHmo9/HbMNaoS8vkDwDvWnQ3Bm6Unw/8k3bJ+/I/iH6ySTcLeOXVm119km4UnzanJhrhg==
X-Received: by 2002:a17:903:2f8f:b0:220:d7f9:9ea8 with SMTP id
 d9443c01a7336-221a10ee47amr334561895ad.26.1740675854690; 
 Thu, 27 Feb 2025 09:04:14 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223504c5bf3sm17356115ad.110.2025.02.27.09.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 09:04:14 -0800 (PST)
Date: Thu, 27 Feb 2025 11:04:11 -0600
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
Subject: Re: [PATCH v2 08/15] cmd/cbsysinfo: Allow on ARM as well
Message-ID: <20250227170411.GA2640854@bill-the-cat>
References: <20250226221607.1283592-1-swboyd@chromium.org>
 <20250226221607.1283592-9-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6j5oUKN3yvLn59BR"
Content-Disposition: inline
In-Reply-To: <20250226221607.1283592-9-swboyd@chromium.org>
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


--6j5oUKN3yvLn59BR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 02:15:54PM -0800, Stephen Boyd wrote:

> This command isn't x86 specific. Move it up one level so that it can be
> used on a platform that can find the coreboot table, i.e. x86 or ARM.
>=20
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--6j5oUKN3yvLn59BR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfAmwsACgkQFHw5/5Y0
tywODgv/STfEIzQTzwN6pbm8G4+5XYCHb6JixE86725gu0hfMb2lkB5qSUKJ7nX8
2Q1L2IQUx2/1D2bP+CrP+goU/mYyhytwWQG+azZqIWLy2CSZ5fwvEXaRJYnZI5oU
2hL+xmzwKmkHhUb02G1Lq5xcfmYvoAFsM4b65H81Qrko6Ol6BTD0A3/qwU398awE
VF4r3dtrmSq11nd4zhXE4dNnndN8V7/LZyBVrbREQ38tBqx6VuWStyNks6wBwJkB
oRS7vXTm2pQ1PaPImQ64vU3nK+OAn05rp9Dt24tNhDGFLnvSMCZPzpNCGb3w2zPq
b/+FsFdQa7gAxcn6gjavrSB8d/8vIBd0i1b//3l0Z9E1JYU+owV0en6C2OeEgNjC
Yx9hJQHgtv83W0HMz1SUDsgrGakNeLhwzkNH27/y19QgxtUdrZKyUdr2+EgohGOG
8hLyQjsxYadOzOcPC7sDgiYAOcsH4vYlM+3F7zT8RZWSR3/xzM66sk+uFrAKRppU
e99yXgT1
=UAuM
-----END PGP SIGNATURE-----

--6j5oUKN3yvLn59BR--
