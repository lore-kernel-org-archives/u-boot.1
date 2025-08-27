Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F175BCA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 00:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DB8483189;
	Wed, 27 Aug 2025 02:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VbLApsyT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B5958319C; Wed, 27 Aug 2025 02:45:06 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E729C830F6
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 02:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-61c30ceacdcso677591a12.1
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 17:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756255503; x=1756860303; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=orLL4kcqcevtKN/FOzKW0TP8LE0auF0vej4s3l4of0s=;
 b=VbLApsyTvTQqDkKJKsR5H5d6UhEJa/nPInroMWfo7CUu/mRXQ1vPpJoErC3899rFOI
 hPlRDwMgYC+JhUUrsgra9Gw3qf5Vh18CCaA3+FiGomauxpLwmIrjpKIhjDQyirTCEwBs
 iap6ZHQ1Nu47ZnuNE0b/ieQe+FP69YmsHdJWV3M2utcJmf/7w8glviYDOqKG1KNj13nB
 fVl2uMtvUtXL90XYMGY3EeU5772c8JhlpsG3+cdsAyKhIuD/TSl/TrXCJlvvv4GNfzNH
 fhgdts4nwyUhxbTSlX4bTjWvzwKKoqWogucPmUpiQ0fq8oxFPIMAfhuMv9kZkFq+RNhf
 U75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756255503; x=1756860303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=orLL4kcqcevtKN/FOzKW0TP8LE0auF0vej4s3l4of0s=;
 b=waieI22bFfnpu1EO2thdIfA/NCCRFqTtA+QiVFrQFvFr1n208CG3WjPoEoIfEBf70f
 8/CCI5xgG6ueJ5z1SwzIR7MfwIE/6gA4NAI2ov7sfveiK8waN796lRUadOLsquiYoDeF
 Wjz/4isd2YO2t37mUOm3zCquPl8ujoky46ml8umpHyJwU29TtXXHLJhB3oBw2M1eaSKn
 TYN9e5N2k5s2uZBo3JXVqMCdJToprPn/RHgq8FujpG1/pK+xbfNEWtwfuNnVJHsxcbJL
 5ubexJsx4pqdu1V0t5i/vkl9GR2cnU+z6DO7YTlaHLsC6EI7m2f2iy2ynEAcX3CNETuc
 Mohw==
X-Gm-Message-State: AOJu0YzMfZj3YvU7KWx9j04Mp3OIPwpNp2AbPQR2w3GpX7Ql1LsxN9vd
 qq0kykcrwODBQXc1SoCvGdjwXZCoADFcgPVMNLyywpP/K0fGsBSaSUTiC+/fy/LTSuroUPDh5b7
 jVNaCidyqem4iQw+nim95EPS6SCeSdyE=
X-Gm-Gg: ASbGnctWlvaRv8ahJ2rDu++ZZ7XsaWRNAsgxti0kfNYM+miDsy3Ri+F3G21JOuTrbe0
 i0MTVCQAeYk+4J9+4DVa17bCakXrdfzQewob2C0L5dZvwczvJ+y6CbxkWPWGkRSu7Ge6PXM+p3y
 GpmkIntloBT8WBU5co9mA1WcdsXUN+GmFo17LsRqMTIbv5hyGBqdvJKZ6lUpiLv8LdQiGw7X20g
 mkrmrB4Lo99mYNqsyjq/+c1wZF4QWnNOlIijGE=
X-Google-Smtp-Source: AGHT+IGOlVGdR8fQ2J70DbI9KNWSm6v7umRaFs24b4sc9mLfymYeqYd9dNYNRGx+fswrSvMP2n2hu9ZuVyXTL5TLNuE=
X-Received: by 2002:a05:6402:2788:b0:61c:6cb9:2b9f with SMTP id
 4fb4d7f45d1cf-61c983b8039mr3089727a12.8.1756255502940; Tue, 26 Aug 2025
 17:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
 <20250825224459.682403-5-adrianocarvalho.pt@gmail.com>
 <20250825230044.GB124814@bill-the-cat>
 <CACAHuLCyX_32AQozgt-Wf18b7ia5m3nRJZ7bA=M9oM1mwh-OXA@mail.gmail.com>
 <20250827002317.GF124814@bill-the-cat>
In-Reply-To: <20250827002317.GF124814@bill-the-cat>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Wed, 27 Aug 2025 01:44:51 +0100
X-Gm-Features: Ac12FXygKXOgpQdD4cEsKC4tW-6kfhtN49UvOuJ2bGp_XRAH9KRo2yeiWFUQz4w
Message-ID: <CACAHuLB0uwUjnR58qgeoOcHO-PC5geYFuBKF4Mw+=UFjT9urRQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] doc: make pdfdocs: Ensure SVG files are converted to
 PDF before the compilation of *.tex files
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 27 Aug 2025 at 01:23, Tom Rini <trini@konsulko.com> wrote:
> [...]
> This is getting closer, yes. Looking at v6.16 in the kernel, it looks
> like rsvg-convert is a pre-req for pdfdocs there, so we should adopt
> that (and whatever general updates need to be done) as part of
> supporting pdfdocs as a target. I was unaware until now just how
> difficult adding SVG to PDF output was, sorry for the churn here.
>
> --
> Tom

No problem.

I'll take a look at what's being done in Linux.

Com os melhores cumprimentos. / Best regards.
Adriano Carvalho
