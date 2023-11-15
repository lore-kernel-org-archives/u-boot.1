Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67D5C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B3A87454;
	Wed, 15 Nov 2023 23:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ccGuRIkD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2701987454; Wed, 15 Nov 2023 23:37:21 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32672869F7
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-77a277eb084so6421585a.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087838; x=1700692638; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9viu+bUjU5HlPBi6jbSbWzpJpnBfoCfZwbe+nmnMQ6M=;
 b=ccGuRIkDhEUiayKEl4eOJjPaLO+PbXG8OxSfZ6LxZTL3fESL39YQjxJFkJ7CS18yn/
 awgDUEqA+FmA08fAISrHeEzl6AfVPi6V49VfqMxRLnCwoSkPYNBdYgG9OK16gRGyYQrM
 0hq8z7ePv5oPRmxV310Gvd6TFgB8DHNXlEVqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087838; x=1700692638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9viu+bUjU5HlPBi6jbSbWzpJpnBfoCfZwbe+nmnMQ6M=;
 b=xM1vtQqSmyDllIqdtpUaE3zjVKkirrHZkZfv2hPN1pD1ufmzSMEkVzjiHe5zWdu3NL
 fSnzWf8qNpsLPbiQ5SoSD9H10RJ8qpGfCTXRA4jdKVFsiBrX8KJrYQzAmEgy00BfMrBC
 vbl+bqmtsEbuda1YKtQMkbmrevFOL6JHfQRDmyJZ80kc5aDZFTHud034HEIYdRFwHDK3
 h+/wai9f4blEntsZu96PhCynVGQqAPj+atm0KL+l7Q+6Pr0yTk74o9WzyLUGHCb16DII
 1R8fV4faOfHtme8Urz2wv0gJXt3ykacM9jFpGx2TYu5quZmK44IDApyXRMSTDTAKnepo
 fMlg==
X-Gm-Message-State: AOJu0YyVt3sb35N2ZjnyfkbhwXU9ggf1roRKwYC3asXYScfirYQJiEoB
 IdeO9L9puBen74vYYrHxBfWSqhiC9X3OxkIzkhTo/A==
X-Google-Smtp-Source: AGHT+IFVMhx6OObSSckXhUUhZy7aAzGxTuLlPWHvfaBa0eYWnRg5wmkKHpZgtlGMrbQbPHUtQZuAfg==
X-Received: by 2002:a05:620a:25ca:b0:77b:e19f:2979 with SMTP id
 y10-20020a05620a25ca00b0077be19f2979mr6893663qko.54.1700087838026; 
 Wed, 15 Nov 2023 14:37:18 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a05620a0d4500b0076dacd14484sm3780711qkl.83.2023.11.15.14.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:37:17 -0800 (PST)
Date: Wed, 15 Nov 2023 17:37:15 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 16/29] bootm: Reduce arguments to boot_find_os()
Message-ID: <20231115223715.GX6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-17-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BxsZTLFQo2YBB0Cw"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-17-sjg@chromium.org>
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


--BxsZTLFQo2YBB0Cw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:09:01PM -0700, Simon Glass wrote:

> This function only uses one argument so pass it in directly.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Aside from a typo in the subject (boot_ not bootm_):

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--BxsZTLFQo2YBB0Cw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVSBsACgkQFHw5/5Y0
tyzOJQwAisSqJWSFZz/KpyfQp3Jlqkm8sLKzCfCXA4ifHkIgouwPJvRMlTY0tqzT
K4fYQLTtz40mekB2lRvjQOsjr5ua47e7abBI83kuBeLs/iK5/84WhYOEoJcGEJD5
Z1V5oo7rhkuxA0lF79LWgs1OvJzWnM7Nb4K+P2TY+Iv0B/UxlE+Pt41oj1uxjsjD
Jzz7oEbviITWT6qiZ3yLEg/PVzI2DhhY5G/YmTsPxafqbYEV6YDc033PVrqAAlyy
bMbms/HmwJGhAk5aTakO7ar+Z20FZyqbxOLDON36lj0GU+JZVEfCWeYl+l2WBf1Q
W/LpRIyzcxCcsGkYblfaxVjtryqwAE6jifH6rtqBam7Gk+cNRqcQtk3iyaZxLUHK
j8MvEvIhaBUoOYQ00VyULRNHTUV0zl023RwVqgxeyuqNIPybnfXtx6OU3u6SGiAU
0+oSIRql+dMDunKaUMOHO0jX0D1zpJVgeKuGlLteEhaTGp+GEchGzKJrimmEWCvy
a9Fb4j+Z
=3omh
-----END PGP SIGNATURE-----

--BxsZTLFQo2YBB0Cw--
