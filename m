Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BA6EE14C3
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 01:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31823869E6;
	Thu,  7 Sep 2023 03:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YptwhD4n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CD6F869E4; Thu,  7 Sep 2023 03:53:17 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D9D3869E6
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 03:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5922380064bso5155607b3.2
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 18:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694051593; x=1694656393; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0ytfGIDzjjBUFKp9YoCwY/DtmWBp1vW9LrOogjNOJOs=;
 b=YptwhD4nugSY3bKgoz5w82BN5i4lKp2PeKV3A3T0wLPhwrwNSUXK39XISsM7TLzT0s
 uM/Xf/7vlNmdQXc//fbr5uZA0eojiqz5DqBsKtQQE5HLnQroH6nvC6KL8UIZN9jfZzXM
 33Od9tNT/R0nb8Xix2dxkQS3MGZcg8KY0lLtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694051593; x=1694656393;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ytfGIDzjjBUFKp9YoCwY/DtmWBp1vW9LrOogjNOJOs=;
 b=hHHZPHSpHA+nSDRvYivujzmNxSbyGS3tQifWnCNyjXK/r7MNa5ZxtbOUQ2IPOAJsmo
 0GLjml3Xy4GXdMvkSSdTUWwKpxYSjJQxUQVi1wth7uq06qnezXy2XNe6p9Am84Hv0KMc
 ziZk2g5QufQd39bMdzda2P3kvntjXGWO7WCr2QUfVB3W7SMa2r4P/Sgq/HzL9+iVcONF
 na4p6zmvFRHzGTemVCVbcAi8FwBYHBZ/gsZlZg1SO2jDKj+eePQ2dDSyHNhU0aMoh5bD
 HZOuCByxFt/dQZIYR5L8zW9NFYo+C0uceqUNUM4CZCnZ1Vg2HcbtfieKfcQ5cpeuA8o7
 3D8A==
X-Gm-Message-State: AOJu0YyFW6XCZP4Mfm0Byx8/Zi8ljU2mNJzE8ErL8DgfvGHbkWAj9no5
 OeZd6MjchDnOOdsHa1BhYTa4jw==
X-Google-Smtp-Source: AGHT+IFYkluWs+qFjDMDAqh0avjVQrcQjl7dfRTPvIKT1858WBl735mG5oY9jTbyLroBjPvBEUwjAA==
X-Received: by 2002:a0d:e305:0:b0:58d:7599:676a with SMTP id
 m5-20020a0de305000000b0058d7599676amr17569842ywe.37.1694051593034; 
 Wed, 06 Sep 2023 18:53:13 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-27f1-c90c-e8ad-e559.res6.spectrum.com.
 [2603:6081:7b00:6400:27f1:c90c:e8ad:e559])
 by smtp.gmail.com with ESMTPSA id
 s63-20020a0dd042000000b0057a918d6644sm4078024ywd.128.2023.09.06.18.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 18:53:12 -0700 (PDT)
Date: Wed, 6 Sep 2023 21:53:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] .gitlab-ci: Test sandbox64 board in addition to sandbox
Message-ID: <20230907015310.GR305624@bill-the-cat>
References: <20230901084810.238594-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ca6BtnR4mEOvderh"
Content-Disposition: inline
In-Reply-To: <20230901084810.238594-1-marek.vasut+renesas@mailbox.org>
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


--Ca6BtnR4mEOvderh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 10:48:10AM +0200, Marek Vasut wrote:

> Test both 32bit and 64bit sandbox boards in CI.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--Ca6BtnR4mEOvderh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT5LQYACgkQFHw5/5Y0
tyyiWQwAn9zpW8mRJqEVjOaoS8ub9HlwYwELV4qG6rr0NvooqPh2PtyD8YCL4HcI
fqmmzSw0W2Z2FwSj7tmuL4JhR6ZAEnJpidJpac8Tt8BCuoe8A0pnd+zy20aWGsoh
HU6YZIVFln+oButuO2oQNuy1gq+7pq49rLn3u1mMixW5OnI/Z3fUbBwkciQo+OxJ
Aq/m4SIgXaCg1SdIhH6aBQ9jGLIFPljI6qDikN57WaUiJappeSMzxyzvrz+30mRw
PzUZCPAMX2fE03mnDnq01AKYyhEKib/eRHo7a4ZNkhmJTpM2Jz8yKzRHYtgBoYhm
8sAVTsVCLUCjdQS6oxJPSo2jeqCnGSbvD8z6uWMwpRLJ0SEKzSMCpWB/4y9eONix
slhGz/kC5s5UoHTqo5AuZhwzhBn1l8G/WI/EDevHMPDskVu2oacPBMCcnBecfUtV
lifVfP1V9HX6jw/esC101BxmuCmYvFu9cWdxurqzduBr1d84FMRBoczkqBZ6NnvQ
FV1NYgNv
=c9aK
-----END PGP SIGNATURE-----

--Ca6BtnR4mEOvderh--
