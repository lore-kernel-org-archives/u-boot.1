Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784E5EDE9B6
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 12:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D606C86423;
	Thu, 14 Sep 2023 14:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qq8UkGqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C7D786459; Thu, 14 Sep 2023 14:13:03 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC379863ED
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 14:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-502e385e33bso1478621e87.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 05:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694693581; x=1695298381; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mgbSRXbz3BsrHgJii/zxOwxJ5h2bxq5dF2mGLOLpDt8=;
 b=qq8UkGqoblI9UGJ/i9Y9r3blGvWL8C1LHqRv0w5pgeE+WgqTXJvWbppewKk35TCjxL
 Tn6xqgrEeIxYXyl/VczI5Z9XfxCb4okumEoTpN//HqimWomCiKhuH9gvbkEAvJVQmBz9
 ZAR2+CPLQuszY0wL793UeSuSSVfRTSkPYmpBPgFTSgjoztXSz/5ury/0mA8q82x63Gu2
 YJ8w19ojXyRmhlyjb6NKZyRckiKsXPVQwlUbCMvxowfuuTaHRh8oG747wgLQl87MDpRF
 gqXh0vdl0LLn3K/UXoNPaCoA4EvWeh2dHWpMm2E897jwxRcRKJzgBn+bm+wZBptZmRto
 C3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694693581; x=1695298381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mgbSRXbz3BsrHgJii/zxOwxJ5h2bxq5dF2mGLOLpDt8=;
 b=qb+ntcYvdKaNz93S2oK2MDIO8RhWMYL9iV4Gj5mIzFX0N4jOmLQpdLViHJBYKZAfsy
 RAnliZhLfoDi0SZGUOvzn9DtByjk2KDGXlSMIIvlH8tOi68HEl8NmcwfAvPMh4DeQc0T
 zEIeiYcLLblIGntHvcZkCX6v5r0ABzGNHh9narvIeHISaVBziKiQ+oFnDt0aER3BVzHH
 8lekCnufOvjHZzsNzcu+mYVQXgzRp5bGBazFflHIgDRRRkTbKjoNhErNQUS7XmfwEFKw
 dXuDFQv92BH4uBCPNBKlzs8utKHjD1w8uMaT6ODQgzfzVm3pDZOPD8qpER9IjrHRKNlF
 YTrg==
X-Gm-Message-State: AOJu0YzXDDmX1/q08YJ1urXKc4djw3CpLvck9s+1rM3DJgsMdrPVYs/t
 AO//xtrU/xwdg+8uq8Gkf6X3BmQo2H3qZ/jHcRVm0g==
X-Google-Smtp-Source: AGHT+IE+0a2byaiA2cE2UHCMBmZ8EDedi5M35taHgwtfQatt+pay+H+KLspTTlchnkqqRVqYzPY0Mf+gTrksa7rg0ZQ=
X-Received: by 2002:a05:6512:3d12:b0:4fb:89b3:3373 with SMTP id
 d18-20020a0565123d1200b004fb89b33373mr5244574lfv.43.1694693580869; Thu, 14
 Sep 2023 05:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230908120002.29851-1-sughosh.ganu@linaro.org>
 <20230913192422.GP305624@bill-the-cat>
In-Reply-To: <20230913192422.GP305624@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 14 Sep 2023 17:42:49 +0530
Message-ID: <CADg8p974hyYwip59pTAE8grqOpftx+CzLQU8XefsJpzukW-saA@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add some more EFI capsule tooling support
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>
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

hi Tom,

On Thu, 14 Sept 2023 at 00:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Sep 08, 2023 at 05:29:54PM +0530, Sughosh Ganu wrote:
>
> > Recently, a set of patches were merged in next, which were adding
> > support for generating capsules as part of the U-Boot build. Mid way
> > through the review of those patches, it was decided to drop the
> > patches for generating capsules through a config file. That was
> > primarily due to the use of absolute paths in binman for testing the
> > capsule genertion through config file. Now that the base set of
> > patches have been merged, this series is picking up the remaining
> > patches for review. This series addresses the concern that Simon Glass
> > had with the use of absolute paths.
> >
> > The first set of patches are adding support for generating capsules by
> > parsing the capsule parameters through a config file, and adding a
> > binman entry type for this. These are patches 1-5.
> >
> > The other set of patches is for generating empty accept and revert
> > capsules through binman. These capsules are needed for the FWU A/B
> > update functionality.
>
> I think what we really need next is to be able to implement and document
> how to use the capsule (and FWU!) spec / mechanisms on another platform
> and I think the Synquacer DeveloperBox would be a good target here as I
> believe you have access to one and so does Simon to we can deal with
> feedback on a real platform that both of you have access to.

That should be possible. And although I personally don't have access
to the board, folks in the team do(including Ilias). I will work on
this once the patches for supporting empty capsules in binman get
merged.

-sughosh
