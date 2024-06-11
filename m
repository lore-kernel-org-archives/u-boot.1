Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1DEC27C5E
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 14:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98454886E7;
	Tue, 11 Jun 2024 16:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nq1uj11e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E53D3886EB; Tue, 11 Jun 2024 16:07:25 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99154886E7
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-703ed15b273so4326983b3a.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 07:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718114842; x=1718719642; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pOFIlSxileHn+NzXEzYqjVnJJNFq2gTHQhMfZUhd3AA=;
 b=nq1uj11e26zJV4ZHugsAobXKrZ2DChDI1OIPpHqUfBGuaunuAKc8Yx2KNR5Lqwf2AK
 Fw26aBfUzaLP3t9aeVJuOowwf3HI6+my3YBRrT7KwxnaoI0lggRXv7sMIqBwfOLLkIqg
 nZh5PZOKLfjsRK/PRphlE26AG3sVACn0QNfANiPGh7exkJzcORYi618dScZYtUOHRGqF
 Lp94SMONKtAJo9XoRtUjgi06jxNJ9oKnTSrQ4P6IgwTB/95QicvJypawIcWJ1PCladtl
 xTUGjacsN3ljUTbqGGcUS5ZxYBH3X4DVSYIqAIHbpRSPXW4DcsKWE4cqKm6I79Qqqw/j
 NkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718114842; x=1718719642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pOFIlSxileHn+NzXEzYqjVnJJNFq2gTHQhMfZUhd3AA=;
 b=JZwpcA3cS9d/Y3MYUaFTlUem8sdyMYhpDbVtohUkqMynlt+EFpXnBGpw7GUhrAKMFy
 rQwpvSVdY5tj2Bk9Mkjzlj7yrz4UVH4aQzafX7J4ksYFNNmivxLNkFwqxcZff4eKqLk/
 SWiRLS+7GPMb3t9H2aVZ4Ka5kbUeSkXs4ay3+CyuKAN5IOlQvRAheTqAp61gdrlTG5lo
 3RsVGm0MvW0uJfsLt+aPPSrEYR7yfJiBhLPlDPnUEjB+2Q+W0YFXgHT6+gwDirOMmXh8
 TV5k5q47Im7GbHl127YiTu7OpS1/3dFM8mBjyAWCxppnEh3au1uftxnCpDO1XHZLHqZL
 H2BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfFyP1QKn6k0ePpqMVlhCInAzDt1W8QRFQU/C+el1JOQ1Etklw+gx6TArhV/GKuGZ6u1IlxzPxAadI0qHYNAb8ljwc/A==
X-Gm-Message-State: AOJu0Yz2f+R/SD63oYN5aICsrT9lBIAF6U9Zt5SiUMBwN/1rxZvmfBr+
 iX3cHPu/+M/e32lf1ZYRe8cN25NVYGaIktjnf3fZ7OmOZqudHWGYNtL82jl3BVJzZdfpuBr0boM
 spOPfNqheG1wvErEnFRU5WheD372aJq6Sy5M2Dw==
X-Google-Smtp-Source: AGHT+IFjgfSlVjP8kjU0Htj2f0YrL5LmdoV6aSc4Wkw8r17Ax0qSAI9e5I4B7Sf+X71hVM8/Pj/c893pQJEfiPTI6c4=
X-Received: by 2002:a17:90a:10d7:b0:2bd:fadd:75e3 with SMTP id
 98e67ed59e1d1-2c2bcc4cef2mr13871378a91.34.1718114841874; Tue, 11 Jun 2024
 07:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-23-sughosh.ganu@linaro.org>
 <20240610174450.GX68077@bill-the-cat>
 <CADg8p96rjN48peBf=cxbs7k7ku0stV-4bBhL5+RrTnPJVS1tjQ@mail.gmail.com>
 <20240611135918.GD68077@bill-the-cat>
In-Reply-To: <20240611135918.GD68077@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Jun 2024 17:06:45 +0300
Message-ID: <CAC_iWjKNN8848NoE2u9ZYLUZVO45RyY77cL+1D6+iy1at0wDFA@mail.gmail.com>
Subject: Re: [RFC PATCH 22/31] test: lmb: run the LMB tests only on sandbox
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
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

On Tue, 11 Jun 2024 at 17:05, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jun 11, 2024 at 02:25:05PM +0530, Sughosh Ganu wrote:
> > On Mon, 10 Jun 2024 at 23:14, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Jun 08, 2024 at 12:22:31AM +0530, Sughosh Ganu wrote:
> > >
> > > > The LMB memory map is now persistent and global. Running the tests for
> > > > the LMB module will result in the memory map getting reset, and this
> > > > will have side-effects on the rest of the working of the platform. Run
> > > > the LMB tests only on the sandbox platform, which is meant for running
> > > > such kinds of tests.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > >
> > > I'm not sure about this. We can reset real hardware as often as we need,
> > > too. Did you run in to problems with this test on non-sandbox?
> >
> > But do we want to reset the state of the LMB memory map on real
> > hardware? This was working up until now because of the local nature of
> > the LMB variables. But if the LMB memory map is to be persistent,
> > should we allow it to be changed for running some test? That would
> > have side effects? I think running these tests on sandbox should
> > suffice. I mean there isn't any aspect of the LMB module that is not
> > getting tested on sandbox, right?
>
> When running our test/ test code on hardware side effects are fine, this
> isn't a POST type test that gets used in production. Do changes, reset
> platform as needed just like sandbox, etc. And yes, a user running tests
> that have side effects manually and then not dealing with them is user
> error.
>

So the lmb changes are scary to begin with. I think the tests
shouldn't be limited to sandbox.
Can't we plan c tests in test/dm etc that call functions and test?
IOW we could allocate EFI memory and try to overwrite it with LMB,
vice versa etc, without having to deal with the predefined areas.

Regards
/Ilias
> --
> Tom
