Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F368C48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 11:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B584387E80;
	Mon, 19 Feb 2024 12:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uVJdUoW+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82CA387EAF; Mon, 19 Feb 2024 12:43:04 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B0A787DE9
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 12:42:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5643eccad0bso2097331a12.1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 03:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708342975; x=1708947775; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZGBQvGiV5HvhalYvSAgvC3dFo5g+FmbqrV7mkqwuRD8=;
 b=uVJdUoW+Ch/Pp44+BK3NLalXrQHms0J+Y9Yg7+2/ApNRRwDi8HLKg6d1hSR5ZGuEv2
 Fol2klmJr7eVzki9HHkHHdwV9GKtmoCT3J4x7jfPGaJ65acOgYhQ68eYCHyb7r7m0WoM
 0y2UfCJbSStIfPWFQzxxV7n5ffT9Dwv18o/IERNlYnSjVxVnff05Yl57QgVHS+qC91Rk
 lsM+UMV2zrEKC7Za+5BymSCMgTjD3S3SsTIiPDKLiRtWA+fbpuXoQJLgfsYqPBYvjIHT
 +0mb6bA5353PgnC0kkuEKywLtZyKdBGe8k21bZjit1zBRVQBlmTiY0/1Q+u5ofszUnrt
 3OlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708342975; x=1708947775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZGBQvGiV5HvhalYvSAgvC3dFo5g+FmbqrV7mkqwuRD8=;
 b=MHmIrCvLfiHlUm3QiGk5lzdw3obUJHzrHpHO/isP344UrKeh18O1Nbfase9EihHr7V
 ciLkfBoEGoc4WcxGUL55hLNmYUBmT6QVisbkyNhZh7PyiIbINNQ2UPi6f0YzWEqiZwnK
 77Gvhyl7ZDIuXlGa0e1h/KWwft25w5Sj0sIbOV7uVhbG2aS8UVnLWh8htIrTl7GqAV4F
 gCCyZYGu8JPFqZPng+FsM2tpDcPh1EypaubrgnDqkT5wPFYczFPC2X3MyJr+TIbH3cIX
 /i1L4BBdkEu7aMGnO5Dr7ug/4Kr0JlQlXQTCVXp0T6nUIwOjVKgxpIOJ6GUowTCZfzsh
 dJKA==
X-Gm-Message-State: AOJu0Yx6hjtlHyVkdSO+Ws0SF+yxD8D/g4dyKr94n9rCQe5DWiKd3mlp
 vSWjtX8WcwweXQiR/ArLEwVEnuz/M04Pqk0mgG6e0wdKWJDYMkTkA+AvvQa55wHZxVjcRYmySvY
 sqDqUgu2nrQHoby8wyn8/gJBmZeNDL9eSoQ9fdA==
X-Google-Smtp-Source: AGHT+IFpQLHCZXj9kpRw3bGOnYyxok6Et8HuA/qN3P6+gTDDuhf+J2xnf1uSEU2nH9nGpRys4h8q6L/ODaELnBl5ZBE=
X-Received: by 2002:a05:6402:785:b0:563:ef90:9395 with SMTP id
 d5-20020a056402078500b00563ef909395mr5181982edy.38.1708342974837; Mon, 19 Feb
 2024 03:42:54 -0800 (PST)
MIME-Version: 1.0
References: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
 <20240212074712.3657076-18-sughosh.ganu@linaro.org>
 <7cc3cab2-19e3-4f6b-b6c3-c48d549a3f3c@amd.com>
In-Reply-To: <7cc3cab2-19e3-4f6b-b6c3-c48d549a3f3c@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 19 Feb 2024 17:12:43 +0530
Message-ID: <CADg8p96_e2+0qqaceOe9Y8g81X2jjdX_-_S7qpoO6tTGEkW_0w@mail.gmail.com>
Subject: Re: [PATCH v2 17/21] tools: mkfwumdata: migrate to metadata version 2
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>, 
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Jassi Brar <jaswinder.singh@linaro.org>
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

hi Michal,

On Thu, 15 Feb 2024 at 20:01, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi,
>
> On 2/12/24 08:47, Sughosh Ganu wrote:
> > Migrate the metadata generation tool to generate the version 2
> > metadata.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >
> > Changes since V1:
> > * Compute location of struct fwu_fw_store_desc using pointer
> >    arithmetic.
> >
> >   tools/mkfwumdata.c | 45 ++++++++++++++++++++++++++++++++++-----------
> >   1 file changed, 34 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
> > index 9732a8ddc5..fb847e3a78 100644
> > --- a/tools/mkfwumdata.c
> > +++ b/tools/mkfwumdata.c
> > @@ -14,12 +14,13 @@
> >   #include <unistd.h>
> >   #include <uuid/uuid.h>
> >
> > -/* This will dynamically allocate the fwu_mdata */
> > -#define CONFIG_FWU_NUM_BANKS         0
> > -#define CONFIG_FWU_NUM_IMAGES_PER_BANK       0
> > -
> >   /* Since we can not include fwu.h, redefine version here. */
> > -#define FWU_MDATA_VERSION            1
> > +#define FWU_MDATA_VERSION            2
> > +
> > +#define MAX_BANKS                    4
> > +
> > +#define BANK_INVALID                 0xFF
> > +#define BANK_ACCEPTED                        0xFC
>
> I think in previous version only active bank was accepted not others.
> I don't think it is wrong behavior but please consider to select it too.
> I was just surprised to see both banks in that state.

In the current version as well, we do accept all the images, for all
banks. This is happening in the fwu_parse_fill_image_uuid() function,
where on line 207 we are setting the accepted field to 1 for all banks
for a given image.

-sughosh
