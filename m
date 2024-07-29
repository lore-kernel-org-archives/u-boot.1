Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF22C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 08:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48857887D6;
	Mon, 29 Jul 2024 10:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WM+ta23d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4700C887BF; Mon, 29 Jul 2024 10:49:58 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 558AA88651
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5a20de39cfbso4848603a12.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 01:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722242996; x=1722847796; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HdMRbgcUEDo8uD96SVBCOcKIZqIhSwlv82+N7xwWx/8=;
 b=WM+ta23duGKUHgmpxiJOGpkQTuoNkQdVF+yCgdkFI2ux/F6yvNaCjnX6KnZ6cekYEs
 zzN85zwovonaK3sJdcitHfJe7+k/1IMeWh2w+jN/4WbZmGwcMGxw6C1Cve5J4ZDlEqdv
 0R1KVYw2ptxxIAtVQOyicqKKGBufg6O8wGCNZVUQBdnYxXsysGcvj5LIHXXi+RzWeCXV
 IZhRfV1UznobKZjFeBAWLAwmV0T8lyOB4LRMPurfhJKwi76KRdmgR/p5KzM2zjuYL0pQ
 WVhFctsuQGEdcCMqBZU7RreB9dDH6VGK4siNANU8qHzQm1L48dcIMlkef1X+y9fAmzCf
 Db4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722242996; x=1722847796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HdMRbgcUEDo8uD96SVBCOcKIZqIhSwlv82+N7xwWx/8=;
 b=sRUL5kVJiTx9tpa6HHOrD0XsbE6i0qcIw2441+3dNk7dnSyStGmWuE+crtx25RWJUS
 yZ1XERE7lh6Juw3SLb7HGfALNT7YuO5v5c0BusXu60x2JWaSriy4PgC+v0rDzoW0f0rV
 BUgyksc8BXvlX8Wbk2gcvzkQ0xV+8YnHf6tSYbAES43Ma3ZNeXXGmhQ/hP67GWbvR2+U
 GtDawmMVss3fk/yYyzHbQ1zuXkmhCiLOl34sqt1Eaqrgm1Toe2+DOwug54vhpqu89SRB
 2+2vrXJSXw+3/9aV+JPx6l5OJUHZQUNzMiCNSu0/wg2uOXhDa/4NsGxKKmwN6fsJsTbN
 fGnw==
X-Gm-Message-State: AOJu0YxQA3nKaklI0PGgA0haaFm3mS0jE8eLAguauCWaU65MqbzAnnHM
 mfiuPJeSgpolgfMaPAUJko+Fa8zyTLk8m59xXvG33TTeqRXMK4H2iLGPN++nHltwT4vPfePo6Bh
 9njXhn4GNKHkSsWAyTvCDH7JbpAfEEqRbgUrAuw==
X-Google-Smtp-Source: AGHT+IEJ7UUfYWbaYjfJzeSEbYNg2RPbaKVshYtkKt2AJkjoCGWtN3eCL39iJtpMgGVMWs92KZMVwpW+a7uOfImcmZs=
X-Received: by 2002:a05:6402:1e93:b0:5a1:39cf:6ac0 with SMTP id
 4fb4d7f45d1cf-5b0205d6873mr5020313a12.2.1722242995662; Mon, 29 Jul 2024
 01:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-28-sughosh.ganu@linaro.org>
 <CAFLszTiKg2kw1HGcCqcyWgjMsXmSCGKAtOzKStduNEvUR=iZSg@mail.gmail.com>
In-Reply-To: <CAFLszTiKg2kw1HGcCqcyWgjMsXmSCGKAtOzKStduNEvUR=iZSg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 29 Jul 2024 14:19:44 +0530
Message-ID: <CADg8p94kbXZv_P0pWR9XJd+kOit=eJTe-n+33tVOoEy38EvCVA@mail.gmail.com>
Subject: Re: [PATCH 27/40] spl: sandbox: initialise the ram banksize in spl
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

On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 24 Jul 2024 at 00:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Initialise the ram bank information for sandbox in SPL. This is needed
> > for initialising the LMB memory map as part of the platform init.
>
> I don't understand what is going on here...you are moving code into a
> function and should explain why.

Will do. The bd struct's dram values need to be set up before the lmb
initialisation happens.

-sughosh

>
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since rfc: New patch
> >
> >  arch/sandbox/cpu/spl.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
> > index 9ad9da686c..22cd916685 100644
> > --- a/arch/sandbox/cpu/spl.c
> > +++ b/arch/sandbox/cpu/spl.c
> > @@ -121,6 +121,15 @@ static int load_from_image(struct spl_image_info *spl_image,
> >  }
> >  SPL_LOAD_IMAGE_METHOD("sandbox_image", 7, BOOT_DEVICE_BOARD, load_from_image);
> >
> > +int dram_init_banksize(void)
> > +{
> > +       /* These are necessary so TFTP can use LMBs to check its load address */
> > +       gd->bd->bi_dram[0].start = gd->ram_base;
> > +       gd->bd->bi_dram[0].size = get_effective_memsize();
> > +
> > +       return 0;
> > +}
> > +
> >  void spl_board_init(void)
> >  {
> >         struct sandbox_state *state = state_get_current();
> > @@ -128,10 +137,6 @@ void spl_board_init(void)
> >         if (!CONFIG_IS_ENABLED(UNIT_TEST))
> >                 return;
> >
> > -       /* These are necessary so TFTP can use LMBs to check its load address */
> > -       gd->bd->bi_dram[0].start = gd->ram_base;
> > -       gd->bd->bi_dram[0].size = get_effective_memsize();
> > -
> >         if (state->run_unittests) {
> >                 struct unit_test *tests = UNIT_TEST_ALL_START();
> >                 const int count = UNIT_TEST_ALL_COUNT();
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
