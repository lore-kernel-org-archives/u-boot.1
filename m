Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495C6D6AAFE
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 19:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D8C883F7D;
	Thu,  2 Apr 2026 21:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QjbGvD/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 887CE84020; Thu,  2 Apr 2026 21:35:26 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51E6C83CF5
 for <u-boot+nodisclaimer@lists.denx.de>; Thu,  2 Apr 2026 21:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d91f82d819so1319627a34.1
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 02 Apr 2026 12:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775158521; x=1775763321; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VGk8wOg0mDTuSTaW3C1fPXaoll9hckIOYGNUL5g5yB8=;
 b=QjbGvD/FxMR7CxkvgSLiC6uAEP2R0EMmN7iJDrBap+Ymm294QpCXzwVhl9QVo3MGDX
 aDDU8BCOkNUk0m2DcjpTxb1rjX2JvIiC7FcSa738Ghx5FO30j7vUvg5QMWLgyv+Qwold
 qmuFrR1jhRuyjgu7OoHFX5OSiXZUC+wN3XUHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775158521; x=1775763321;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGk8wOg0mDTuSTaW3C1fPXaoll9hckIOYGNUL5g5yB8=;
 b=hz0UiZWCyhmeMQqwfNHDDu4fzUI6vS3dviBvGuTZpcaZ2SpNsi7RS/T9CDNH0hKAFG
 c++ZwtdKDsd01Jwi5CWrLyYLGUJpOSZ8MMJYJ94/9DNxGJfzcbMg4pXqc4nf3GP6Kr4F
 TAjzSxjVJlVEsLNfX7tEW2/+SFbTjkISVT/4iIybh5/ZorX5hiertnvupkJVz/uwBDJT
 UzrYoT5QFCSj9i3Rp+cQDIy4LCn22aM/+IkOE7VNF4PQ9q02QvBkDzBZXT+sYspn+MeC
 kRPMbh6E6BE8oYHl3M1+nMA5co4ijeG7VOzXD+QtL8hTjsrJPm17nYeJ63YBk3msyzW8
 X3gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH50zAk1lVhQJB6XqcXsdKcvCxL4PcrQXjYleDC+2CJM7vrpF1q22l06BAf6JcS27/Vjj4NPU=@lists.denx.de
X-Gm-Message-State: AOJu0YzvNMY2tHueUrklyV6WiM0wes4k1LPODtYPu340bZNyM7i9LMYd
 vtYQlECWj5qDtqHZnBfZiKtvog0oIbTQa5BjN5Zh5aTdk94V+/61TorFqgwxkzfJ6hbPLYXCxvz
 BbYJUv3s=
X-Gm-Gg: ATEYQzzXH5yBP9cv2BiWaLSFyS3yo7JT7hLo66AOTVEHkk0vp4VX2mpbKoPzMcHQesn
 nPUL1Vno5ljJpbUe3ECAp4Omzt711DFy0n+r96iuwwzlu8Y/NgC/2RjZp0JSqKL4fIZUKaVOnhS
 6WKEj/28JdHJllQAeM+2yqDHC3LC3pniGyLW245jt/NP+uT0qMPpW+2nJP+AWq5gp9Aua/XCaVL
 R5nCnHErFW1UX7ZT/byJZD5vnZS7dgybTJvx5uJRyLRx2LL2ewpf+KHunxZ2HzurNDDGFCc/4N2
 yE9ugEOSM5WZj7xTMArjPxUIpU4NgKsJyENJ6kEgtkyZmbSxBjOs7/WtYzBXpHxi3zt9h1/Rise
 ryAd7ZIKgJk5huf2YKu+QyxtEK0B9b8kLPYLrBs6Tac/HSl2HZpswgBYWXNXGrdGTi97D+WlHB3
 6LsHbqDO/4glvPnVpdy7ao7ZlCkJ5y0suS+6SklOP36Z3APeqXQJTIdB/ZYoWdTZSge8yTsjiuL
 gdtaCsM3FMYih4nRqaXvayXBULPecPfpZEVXYih6tAdhdO9
X-Received: by 2002:a4a:e84c:0:b0:67e:3028:8bc with SMTP id
 006d021491bc7-68220a48281mr240709eaf.57.1775158520874; 
 Thu, 02 Apr 2026 12:35:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-422eb42db1bsm3428575fac.17.2026.04.02.12.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 12:35:20 -0700 (PDT)
Date: Thu, 2 Apr 2026 13:35:18 -0600
From: Tom Rini <trini@konsulko.com>
To: yan wang <yan.wang@softathome.com>
Cc: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com,
 philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot+nodisclaimer@lists.denx.de,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: Re: [PATCH v2 1/3] tools: binman: Test signing an encrypted FIT with
 a preload header
Message-ID: <20260402193518.GH41863@bill-the-cat>
References: <20260402192431.2421155-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0LtXj98g8+HqjAIw"
Content-Disposition: inline
In-Reply-To: <20260402192431.2421155-1-yan.wang@softathome.com>
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


--0LtXj98g8+HqjAIw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2026 at 09:24:29PM +0200, yan wang wrote:

> From: Paul HENRYS <paul.henrys_ext@softathome.com>
>=20
> Add a test to verify the preload header correctly signs an encrypted
> FIT. This test exercises the case where encryption uses random IVs that
> would change between mkimage calls.
>=20
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
> Changes for v2:
> - Rename test file as 351_pre_load_fit_encrypted.dts
> - Update the commit message according to the remarks made
>=20
>  tools/binman/ftest.py                         | 17 +++++
>  .../test/351_pre_load_fit_encrypted.dts       | 63 +++++++++++++++++++
>  2 files changed, 80 insertions(+)
>  create mode 100644 tools/binman/test/351_pre_load_fit_encrypted.dts

This should be against next, and we stopped using a numeric prefix on
test files and instead put them in to appropriate directories there (so
tools/binman/test/fit in this case), thanks.

--=20
Tom

--0LtXj98g8+HqjAIw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCac7E8gAKCRAr4qD1Cr/k
ChLqAQDNoswSqnUEx/F00RPT2xPJsulZJUTAXLhb++CrUhYmpAD+KAxfXILr+EkG
mxjLNo+3vKnAeK0NWEFONz0r8pBE2AA=
=uQB4
-----END PGP SIGNATURE-----

--0LtXj98g8+HqjAIw--
