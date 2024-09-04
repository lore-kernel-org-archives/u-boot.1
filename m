Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A89CD3431
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 07:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA02D88B68;
	Wed,  4 Sep 2024 09:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SNU3brfr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2722088C08; Wed,  4 Sep 2024 09:18:35 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F51A831A1
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 09:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2f64cc05564so14921051fa.2
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 00:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725434312; x=1726039112; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G0SqsWNxw5NTEV0E4AGdIGI3/Ne5m6xGyDmFPrJaV54=;
 b=SNU3brfrcWcMkKaRR3V7dh8Eg9u8p5r8JmeSZWp0q0FjIqm+fkLowgMs0efBIQzZFK
 gPVEQdjlNG4U+0Dmi9xCaaSaaH29WQ7+7K73Y30EtUYuHFLgNB94aXwHtyRwPkfth0px
 FHbkGP+BTcsAqcPaMHMvRYhuV9qP5DPv68aTJmciV/GnYerdoHfqj2VhxqlpbqcHeoMH
 dOnvPIB99N58fD0WB6DcXCckK+X9amdRaYg5qVonbJriPSFrSlxJ47PDszHnv1KCxZj/
 6RSqsAA6ffmWqcgjr1CqigZ683iVNAzk8pBu1UkxiqRinE7B9vte9GbiNymj3yRA5dL0
 9nQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725434312; x=1726039112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G0SqsWNxw5NTEV0E4AGdIGI3/Ne5m6xGyDmFPrJaV54=;
 b=A0fSRcdTcNpOqMmtIQ16Afey0UAgR3EntDX2vWt4ndswl6YSI6nFSaCOfRMxLX/kR/
 gYthBHanabD6B1KNq84B6pXYL0TSajE/ogfMXMVTL8C2VeMsJzGpNsQzkyukvYyg+4N7
 JtcSnxeZ3VLUnktA5cc2a/mAHTNvuYwETJ5Elm0ZzBDt04eElqH82qUqwCmYWIqZUBys
 v0jQ7QRA06tWOK26DloWvXiq3uvTwYvO8bJ2WIRJ5i9cAF/gT8/FYLhnXCnYe82mmg+x
 E9d4KHtX8IVbEJWTE3W3LRy3+MBpXvNrA4ltOYWsDZsVnubM3JPw58upADIbq0SZJ3tP
 5kbA==
X-Gm-Message-State: AOJu0YzSHrQ7D7000PnONGUNfXtee6zMBIdqFWH0KWvWUKvNkKlVtjL9
 HZ93QYSV/XRtfOPm6z+R41+7jSi1qkHt0AvGcvp/51Ly+zMF06SAHBV/rjk+PC3Jxh7Js+yuyhj
 mH1s4L51XlH2X774csKhiXV63dT0Q7nj63LGBYA==
X-Google-Smtp-Source: AGHT+IE98IIUn5uaykchvMXF8UYda4WAC1SRoMCvbrsI92W4zDXWXqajITHL581jPt+rvUsamqE5W+cu/mAC4LfjH88=
X-Received: by 2002:a2e:511a:0:b0:2f6:5f0a:9d00 with SMTP id
 38308e7fff4ca-2f65f0a9f7dmr2262801fa.1.1725434312238; Wed, 04 Sep 2024
 00:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <20240830114057.891069-3-sughosh.ganu@linaro.org>
 <8ca6fe22-c8ff-47a9-9cc0-b4781b9cc58a@amd.com>
In-Reply-To: <8ca6fe22-c8ff-47a9-9cc0-b4781b9cc58a@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 4 Sep 2024 12:48:21 +0530
Message-ID: <CADg8p97Jh8Sor2VJDed2jDjs0iE1Hp4X1G2qw44vn8-rWDRt=Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] fwu: v2: try reading both copies of metadata
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, 3 Sept 2024 at 22:37, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 8/30/24 13:40, Sughosh Ganu wrote:
> > In the version 2 of the FWU metadata, the metadata is broken into two
> > parts, a top-level structure, which provides information on the total
> > size of the structure among other things. Try reading the primary
> > partition first, and if that fails, try reading the secondary
> > partition. This will help in the scenario where the primary metadata
> > partition has been corrupted, but the secondary partition is intact.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   lib/fwu_updates/fwu_v2.c | 77 +++++++++++++++++++++-------------------
> >   1 file changed, 41 insertions(+), 36 deletions(-)
> >
> > diff --git a/lib/fwu_updates/fwu_v2.c b/lib/fwu_updates/fwu_v2.c
> > index d0d8a25929..69306282aa 100644
> > --- a/lib/fwu_updates/fwu_v2.c
> > +++ b/lib/fwu_updates/fwu_v2.c
> > @@ -10,6 +10,12 @@
> >   #include <linux/types.h>
> >
> >   #define FWU_MDATA_VERSION   0x2U
> > +#define FWU_IMG_DESC_OFFSET  0x20U
> > +
> > +static struct fwu_mdata g_mdata;
> > +
> > +#define PRI_PART             0x1U
> > +#define SEC_PART             0x2U
> >
> >   static inline struct fwu_fw_store_desc *fwu_get_fw_desc(struct fwu_mdata *mdata)
> >   {
> > @@ -109,6 +115,31 @@ static int fwu_trial_state_start(uint update_index)
> >       return 0;
> >   }
> >
> > +static bool fwu_get_mdata_mandatory(uint part)
> > +{
> > +     int ret = 0;
> > +     struct udevice *fwu_dev = fwu_get_dev();
> > +
> > +     memset(&g_mdata, 0, sizeof(struct fwu_mdata));
> > +
> > +     ret = fwu_read_mdata(fwu_dev, &g_mdata,
> > +                          part == PRI_PART ? true : false,
> > +                          sizeof(struct fwu_mdata));
> > +     if (ret)
> > +             return false;
> > +
> > +     if (g_mdata.version != FWU_MDATA_VERSION)
> > +             return false;
>
> Any reason to remove error logs which were here?

They just got dropped during the code refactor. Will put them back. Thanks.

-sughosh
