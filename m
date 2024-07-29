Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BC9C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 08:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 508BA88276;
	Mon, 29 Jul 2024 10:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M0ynYfR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47A3874AC; Mon, 29 Jul 2024 10:58:52 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA2F388747
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a7d638a1f27so51766166b.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722243529; x=1722848329; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ii0WGU9UsthECS52+KrOQO9kmcWgI92NHd7mmKuv0RY=;
 b=M0ynYfR5FHaoaSoSiowa1K2IUv0CG/EK/E/Bhnw9ZnmuL25ZGHSqDaIP2/Jssd6kop
 AkueT1ENZOy3l3npe/CGDiaDOxV0iTbg+ZGxl36pOCJVjaWXE/+AASAtT7vn54PKiqPY
 uEC15XqtiIWXAeECHK028LORr0gI5SrTiNIt64DglSANxQ3CmgSOmYSxNn0A7kq05C6Q
 gRE+alxBPWsymJ5/Q1JgbbnixnElXJ+8eAkMBak+bxGVA2q1s4PgKtJuqur08xZ5k4tC
 lA4QbQp8hBTcScSEdyO37EDvumevgP1Zn1cItTsCX536h9uDORgw/8I32WxsMTLjNtlK
 g6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722243529; x=1722848329;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ii0WGU9UsthECS52+KrOQO9kmcWgI92NHd7mmKuv0RY=;
 b=r8rtlAI4Pd0/WyF/k4V/YBV34wRQVh4XGv0Xmx7WpQ2Mdb80ZDg9GtRUl+qYIjBaOY
 8vBgZfqZleu+4u3P/tn0zD2SB/qQFbekQvmb+L1YBpf37zlXjPxaSXsGq8OM21SgjRkJ
 I9kjAkfug/4iYU2lij3OmSslDAixlivvKT1tuGxpPU/AAGszwgD9NIMdwvMMsSalxInD
 YJafllUK630DzSZ3o6Ylf/KgkNzeZdiNvTYTIbIoQZDh4F/OhZavcOppuoYrdQmAS33p
 bvYqKk7fqmBOuwMFgkKvgOzJQRgfQ+yFdDV509l2exu8tJ/fnU7Taq9tIUrCE1JRp5DA
 pmzw==
X-Gm-Message-State: AOJu0YzgsLbGNB+ISx0HCZ5S4dhHQv/lNW4GVrurwHuhUSA01JlCkPy7
 NMKg0g3hzjEZtCEA8Be+OhrPcTazKAwcs58b/tf2nJ00fKl3wOGEsgSi1gb6gAsjmk0fAk3EJ4h
 4tdJQAeJaQWAaFbMqLtYWfH4KKKxAf/1YScRxQA==
X-Google-Smtp-Source: AGHT+IGD9lGro9Hg+ZZzKYF0Bj9MlzkjrrCWd9FIt4b/9XRSLHMmzv07Evu7CKt+9sv3uHxiW8wGK1M7Y+P3NKw9Wf4=
X-Received: by 2002:a50:9f44:0:b0:58e:2f7c:a9c with SMTP id
 4fb4d7f45d1cf-5b02317cffemr5557335a12.26.1722243529049; Mon, 29 Jul 2024
 01:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-41-sughosh.ganu@linaro.org>
 <CAFLszTgSXD3FqwtYjGEHWyt=gxGVZFYCzMs8DDhTkxOg6eW+Og@mail.gmail.com>
In-Reply-To: <CAFLszTgSXD3FqwtYjGEHWyt=gxGVZFYCzMs8DDhTkxOg6eW+Og@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 29 Jul 2024 14:28:38 +0530
Message-ID: <CADg8p96VOh=QExuK9h0jzvbozXN=fHk651M3LNa-=HCywos86Q@mail.gmail.com>
Subject: Re: [PATCH 40/40] lmb: ut: re-enable unit tests
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Fri, 26 Jul 2024 at 05:03, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 24 Jul 2024 at 00:06, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > All the changes needed for making the LMB memory map persistent and
> > global have been made, including making corresponding changes in the
> > test code. Re-enable the unit tests on the platforms.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since rfc: New patch
> >
> >  configs/sandbox64_defconfig        | 4 +++-
> >  configs/sandbox_defconfig          | 7 +++----
> >  configs/sandbox_flattree_defconfig | 4 +++-
> >  configs/sandbox_noinst_defconfig   | 8 ++++----
> >  configs/sandbox_spl_defconfig      | 8 ++++----
> >  configs/sandbox_vpl_defconfig      | 6 ++++--
> >  configs/snow_defconfig             | 2 +-
> >  7 files changed, 22 insertions(+), 17 deletions(-)
>
> It would be much better to change the tests as needed, so they keep passing.

What issue do you see with this approach? If I have to do what you
suggest, I will have to put all the test related changes as part of
the same commit which makes the LMB map persistent and global. I have
seen this kind of approach taken elsewhere, so really not sure what is
the problem with this.

-sughosh

>
> Regards,
> Simon
