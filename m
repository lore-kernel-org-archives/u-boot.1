Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6D6D63939
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F71F89301;
	Wed, 20 Nov 2024 14:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WzOoV17w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46A1589301; Wed, 20 Nov 2024 14:37:53 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C72F989270
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7248c1849bdso3882621b3a.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732109869; x=1732714669; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SI8dLpTfmNMtgNqtCmSfO1+r+1V+NNU3e9iDLDGfjN0=;
 b=WzOoV17wFBAtA2GU1w5zvNK+/Bjh5BuqeV+BjZIX/jvgqBnbUyBWcCDTZP3V9mlJmE
 zmKnt7XCEPufECs9PUHbP96PHZs/SodH354eAp95Qv+jqCg4Lrwu5MArFDP+kKwmRGqk
 90T0ZxaVer5LtXThEo36OsIy1nrCamFSQyfp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732109869; x=1732714669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SI8dLpTfmNMtgNqtCmSfO1+r+1V+NNU3e9iDLDGfjN0=;
 b=oDcM8Vokp0fQ5qhJ9W9K9JD8v7pcqYxQZlCtPn45QAwxawiimY2ovfRwTOuVDXiphm
 iKzBZoOFRF+eWBrI1Q2YTZiY0qJuqQlG8Wl5bn10iQgLIeZfYKxbZ1CK3flBq70+3Dl4
 xUwjrXtRNdykOxn2fFNq0nCzTDke29JP8XrQbdkttOCxRckI30AlmhsN+4ssDXkpw0JE
 ppPhfDQcPFwNsGtpIkeDjoBcujGFVGo2nM2aqDIv6BmaahRWeaoyjFTuU7oto15Up0jg
 /1y2Prb4yxgzndjwYfse0e4N1eTW2sxHoKKXkGAWBRsT4hyjPykhjLW8Zts5JXD7JcZN
 HbCw==
X-Gm-Message-State: AOJu0YxHRid8wwbT/7ZwGQXa1zQS0MRSVFT5So3qtTnsCu/43oOMPLu/
 xuXSmePauOsbjFUSnlisCN+ykd8/OyvwoZnJhu8GxCY9CBX2066Gbwftml5rOmfKEdueCAc5Ec2
 xEDLuGR1+NoRbT5WFiFA2WlDfNHBAc6ItdHB2
X-Google-Smtp-Source: AGHT+IGVSzwZU8Gb8CQq6qSdceAPfE0gdFDug4HL2PxMknNLG2TvKNgpkJi4YM8s7GKUTx5fdTQ3mcEy4Nk5id8jm9E=
X-Received: by 2002:a05:6a00:1783:b0:71e:db72:3c87 with SMTP id
 d2e1a72fcca58-724bed27a8bmr3894401b3a.20.1732109869288; Wed, 20 Nov 2024
 05:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20241119131844.4078144-1-sjg@chromium.org>
 <20241119131844.4078144-13-sjg@chromium.org>
 <CAC_iWjLVH8puoEvqu-UH6T8xvtQVvkAqksqtHq9+m+Xwq9xUjg@mail.gmail.com>
In-Reply-To: <CAC_iWjLVH8puoEvqu-UH6T8xvtQVvkAqksqtHq9+m+Xwq9xUjg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:37:34 -0700
Message-ID: <CAFLszTjh0gczViYomndt7PAsLR78o9aLTRJH5dW4eBdbmmRzyw@mail.gmail.com>
Subject: Re: [PATCH 12/39] bootm: Allow building bootm.c without
 CONFIG_SYS_BOOTM_LEN
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Ilias,

On Wed, 20 Nov 2024 at 03:56, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Tue, 19 Nov 2024 at 15:19, Simon Glass <sjg@chromium.org> wrote:
> >
> > This code cannot be compiled by boards which don't have this option. Add
> > an accessor in the header file to avoid another #ifdef
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  boot/bootm.c    | 8 ++++----
> >  include/bootm.h | 8 ++++++++
> >  2 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/boot/bootm.c b/boot/bootm.c
> > index 16a43d519a8..0a1040ef923 100644
> > --- a/boot/bootm.c
> > +++ b/boot/bootm.c
> > @@ -633,11 +633,11 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
> >         load_buf = map_sysmem(load, 0);
> >         image_buf = map_sysmem(os.image_start, image_len);
> >         err = image_decomp(os.comp, load, os.image_start, os.type,
> > -                          load_buf, image_buf, image_len,
> > -                          CONFIG_SYS_BOOTM_LEN, &load_end);
> > +                          load_buf, image_buf, image_len, bootm_len(),
> > +                          &load_end);
> >         if (err) {
> > -               err = handle_decomp_error(os.comp, load_end - load,
> > -                                         CONFIG_SYS_BOOTM_LEN, err);
> > +               err = handle_decomp_error(os.comp, load_end - load, bootm_len(),
> > +                                         err);
> >                 bootstage_error(BOOTSTAGE_ID_DECOMP_IMAGE);
> >                 return err;
> >         }
> > diff --git a/include/bootm.h b/include/bootm.h
> > index c471615b08c..d174f18ac18 100644
> > --- a/include/bootm.h
> > +++ b/include/bootm.h
> > @@ -89,6 +89,14 @@ struct bootm_info {
> >  #define bootm_x86_set(_bmi, _field, _val)
> >  #endif
> >
> > +static inline ulong bootm_len(void)
> > +{
> > +#ifdef CONFIG_SYS_BOOTM_LEN
> > +       return CONFIG_SYS_BOOTM_LEN;
> > +#endif
> > +       return 0;
> > +}
>
> Do we really need a function for this?
> Why don't you
> #ifdef CONFIG_SYS_BOOTM_LEN
> #define SYS_BOOTM_LEN CONFIG_SYS_BOOTM_LEN
> #else
> #define SYS_BOOTM_LEN 0
> #endif

Yes, we could. Just trying to avoid #ifdefs in the C files and provide
a way to improve this logic later...IMO using this value when it is
not defined should be an error, but we cannot do that in the
tools-only build, without yet more refactoring.

Regards,
Simon
