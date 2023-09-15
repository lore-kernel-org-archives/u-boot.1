Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00296CD37A7
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 19:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECAAE864C7;
	Fri, 15 Sep 2023 21:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JEEcvDum";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53F82864DD; Fri, 15 Sep 2023 21:48:38 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CDB5863C9
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 21:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-ccc462deca6so2348604276.0
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694807315; x=1695412115; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pbg/FlrqKoC9cPCaIItgNNja8rT29xYeQxIXun0761U=;
 b=JEEcvDumcjZSZNOVD7Uvw8RteYuiVTT3PzfSlfMC33uMpK3elY9xEZ2XrdVCWiPEnc
 4D+uFgbOmAck2EfxZDFN5OO+JMo0SFx0lFZAA270/iN5raraOdnBfx8981LEuHbsU2P6
 iJMlpEZ3WyJBMrQ6/voRu1mMk2IXZJUsY7p7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694807315; x=1695412115;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbg/FlrqKoC9cPCaIItgNNja8rT29xYeQxIXun0761U=;
 b=AtrfO7r1pk9FU/rudbfyQTpLgC57wBgRCebZe4OxnV/cSKynU2gtmSgBpWq7qgXkWt
 MAy01X1xfq4a8Ji1wTr50ZKassTAy0NXALZIohggmtDSqaMtx2r6OGUeYDveqRvT5WfJ
 vzA9WVUuRaffJCJopd0wqeN8u6aMgQjJZiol6cWDNZvQlY5un3jrxQ4vdOFxtg4LvfKd
 IC3TbbyHluhftmt/eJ6ZOnVGy5X4fnduluMeZkt2CT1aUcmCvlQ2jeGyKOIv/rqKyrfT
 jXBmgzbzhoYzphYVSqom7UNOVBYEmUdAV3coaCgR7RaFQpm+VXjo416XpeYun1kq9H0i
 gAEg==
X-Gm-Message-State: AOJu0YzArqV07MBoiBAbYy/zDgEO1ujFkUkFRDDfKYvdkFwk6D+kUJzE
 XNFPfPzmeBovICDn117D5BkIDg==
X-Google-Smtp-Source: AGHT+IGKTALmRIXGk2iCoh7iuxA2qkdOPjs4UxhLvV+sLWTGTXJIHj6JDdwvjlgrlBU9LbpGJOxEcw==
X-Received: by 2002:a25:694a:0:b0:d81:afb1:bf77 with SMTP id
 e71-20020a25694a000000b00d81afb1bf77mr2468761ybc.28.1694807315040; 
 Fri, 15 Sep 2023 12:48:35 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ba48-499c-2259-fcdc.res6.spectrum.com.
 [2603:6081:7b00:6400:ba48:499c:2259:fcdc])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a259207000000b00d815cb9accbsm925458ybo.32.2023.09.15.12.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 12:48:34 -0700 (PDT)
Date: Fri, 15 Sep 2023 15:48:32 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] common: Drop linux/printk.h from common header
Message-ID: <20230915194832.GF305624@bill-the-cat>
References: <20230915002147.797352-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xNnPTmP1C38Mxlvn"
Content-Disposition: inline
In-Reply-To: <20230915002147.797352-1-sjg@chromium.org>
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


--xNnPTmP1C38Mxlvn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 06:21:46PM -0600, Simon Glass wrote:

> This old patch was marked as deferred. Bring it back to life, to continue
> towards the removal of common.h
>=20
> Move this out of the common header and include it only where needed.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
>  317 files changed, 322 insertions(+), 3 deletions(-)

So, going back to the original series here, how did you determine that
the files changed here need <linux/printk.h> ? I can see how to get
there with some grep'ing but I think my original complaint was that we
added the new header too widely.

--=20
Tom

--xNnPTmP1C38Mxlvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUEtQcACgkQFHw5/5Y0
tyxqgQv/cd6KuAsQRIBFKAjNDtvX5vGa6YjR5U/kZKmQpycgfK8cVzLeVxtNiCqA
8HsjaqF+sFiHFN1Pfpf6BW3AO0IxZUrwEYEP3NNLBiv0tl7w9FqpHGtsiCmGbibW
4aMqqGvsl5tkb3lDtEJVTlj5d64Fs8Lt45DPTyEgPgLzYIUYQZZfUxvmr6xyrx00
rZJlMImaQeMo8G48rpAOE8MpMLNI9TLpGu01d0lrvJgVKCotxcJkOrhiO5qE+fPG
qWCZRIDTapKJn2wPsztMuDB+xykLwlw+Z9W9z04HV9Xh2+jT5yttEwiIzQAnRvL2
2IL/FRvg+amF2Xn0ceV5HbSvrqAD+7OD+0QoD40HEBVv+nOA/761au3ItMIcvG2t
TOv3QV4dr/Mvyww8mJ6kdWg2A6PVRRf5H1qVOZjtPtZhCjaVJL9eGh1VcvF9B4ox
8/w0Gkw1clOnJX6DKg0JmBUz0gsAZZ7KI+iLXSCrfAFonpteDmLCvnDOQaIKM7h2
Q0ODpt/D
=oc2Y
-----END PGP SIGNATURE-----

--xNnPTmP1C38Mxlvn--
