Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97B0CA0ED3
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 07:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F54D88C8B;
	Wed,  4 Sep 2024 09:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w1mVJvoc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C22F88CA0; Wed,  4 Sep 2024 09:18:58 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BBD3831A1
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 09:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c26b5f1ea6so497648a12.0
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 00:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725434336; x=1726039136; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mKprRrHhunUY7XpMNsNjgn+fFvRusP/Gs1aRKeXpRys=;
 b=w1mVJvoci3whgJ3t9ht2bEHY+prS5mbzu+wNk+PMuirHNS8y/yutmz5+MaKp/AHA8a
 s3tsT1J3AQPF8cUYW2D3pknDOKF9DiAZujpALov33P6xO9eCFDF0B22v/401/d++yNGo
 TaqL0VKL3tg1zmSvhYmw1vmmF8hrhKtj0AFgvPdaA8GPoZr6IftWfrM9/WlpNyDAVQQH
 PEYS+qNeHZEP+EYoS+baTyNrqrQzUCukTDo5YQj4xlTTXDz/3imF1fjH4g80UTdBnGTQ
 wA3lR8GtFsyViCIL7DqnS55B6rk4MDajEa4AJ13SMFse/+S9GHnWrkTlCgfUAuQeJBP0
 Y4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725434336; x=1726039136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mKprRrHhunUY7XpMNsNjgn+fFvRusP/Gs1aRKeXpRys=;
 b=Qgs2U/64tudLEUg8Hg6gY8LIItnOVpE63kURZdDtWERNZpcfwntbepO0f3VqReUyQY
 4/TWfib4CIIr3VEQeQWj+cRtnMmZr2coj3YbJWOrF+No7yVkvdunyhOh5H7G5HJtC/Br
 h7EIMfgj6ULfxkK7AYWtY4voXNTHwpddxlRo0xXI3NI68W1sm5Doureko5Ne3yWEJoIH
 9NrH6wCoQSs+vD08q8FPufd9RiWCqIToCYeuY+/GKDhF/IkUlrmWrtcYRdHcv0PIiJZh
 d5VEEgw8Xbh8p+YvkssZMfrEziYXPudWHtf8u6m0cwE/8ta9V9w9iWok+7uKWmNXca2Q
 X3dw==
X-Gm-Message-State: AOJu0YzX2poD7OVkY4s2/tVvlaUcTbC5NRsombwTvME761AaQKDFQnYv
 DUjC7pUPRyrRvfoY8eSG5MZTOq6HgrT4DnihBnX+yg2v84A9jmhmSr03TJ7J0FTqerm5Q3J+AiW
 Jek9kleNn7bffnMyKq/IMzbqjs3Cya151Ms5bcw==
X-Google-Smtp-Source: AGHT+IFTNXq/FtTAYp96QY0DZZoTJPZvDVr1iPdufcCEKdgVZx1j6QoIlWZPukXv/LlAyRHm+0AADhXbsG2Du8h5Fxw=
X-Received: by 2002:a05:6402:26c7:b0:5c0:ad76:f6d5 with SMTP id
 4fb4d7f45d1cf-5c2c28f86d3mr1049032a12.5.1725434335965; Wed, 04 Sep 2024
 00:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <20240830114057.891069-2-sughosh.ganu@linaro.org>
 <f6c4b95b-9748-4cbb-b3f8-7f69b6c4c451@amd.com>
In-Reply-To: <f6c4b95b-9748-4cbb-b3f8-7f69b6c4c451@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 4 Sep 2024 12:48:45 +0530
Message-ID: <CADg8p96K2jx4F+Z2FpwS0tEHQZpnb+nEtsHMW1nmi2QK+GTZ9g@mail.gmail.com>
Subject: Re: [PATCH 1/6] fwu: v2: perform some checks before reading metadata
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

On Tue, 3 Sept 2024 at 19:22, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 8/30/24 13:40, Sughosh Ganu wrote:
> > The version 2 of the FWU metadata has a top level structure, followed
> > by optional information on the updatable images. Perform some sanity
> > checks on some of the fields in the top level structure to determine
> > if the rest of the structure has to be read.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   lib/fwu_updates/fwu_v2.c | 36 ++++++++++++++++++------------------
> >   1 file changed, 18 insertions(+), 18 deletions(-)
> >
> > diff --git a/lib/fwu_updates/fwu_v2.c b/lib/fwu_updates/fwu_v2.c
> > index 108bc9bb4a..d0d8a25929 100644
> > --- a/lib/fwu_updates/fwu_v2.c
> > +++ b/lib/fwu_updates/fwu_v2.c
> > @@ -58,24 +58,6 @@ static int fwu_mdata_sanity_checks(void)
> >       struct fwu_data *data = fwu_get_data();
> >       struct fwu_mdata *mdata = data->fwu_mdata;
> >
> > -     if (mdata->version != FWU_MDATA_VERSION) {
> > -             log_err("FWU metadata version %u. Expected value of %u\n",
> > -                     mdata->version, FWU_MDATA_VERSION);
> > -             return -EINVAL;
> > -     }
> > -
> > -     if (!mdata->desc_offset) {
> > -             log_err("No image information provided with the Metadata. ");
> > -             log_err("Image information expected in the metadata\n");
> > -             return -EINVAL;
> > -     }
> > -
> > -     if (mdata->desc_offset != 0x20) {
> > -             log_err("Descriptor Offset(0x%x) in the FWU Metadata not equal to 0x20\n",
> > -                     mdata->desc_offset);
> > -             return -EINVAL;
> > -     }
> > -
> >       num_banks = fwu_get_fw_desc(mdata)->num_banks;
> >       num_images = fwu_get_fw_desc(mdata)->num_images;
> >
> > @@ -238,6 +220,24 @@ int fwu_init(void)
> >               return ret;
> >       }
> >
> > +     if (mdata.version != FWU_MDATA_VERSION) {
> > +             log_err("FWU metadata version %u. Expected value of %u\n",
> > +                     mdata.version, FWU_MDATA_VERSION);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!mdata.desc_offset) {
> > +             log_err("No image information provided with the Metadata. ");
> > +             log_err("Image information expected in the metadata\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (mdata.desc_offset != 0x20) {
>
> In 2/6 you are introducing this macro
> +#define FWU_IMG_DESC_OFFSET    0x20U
>
> I think you can do it directly here and just use it in 2/6.

Will do. Thanks.

-sughosh

>
>
> > +             log_err("Descriptor Offset(0x%x) in the FWU Metadata not equal to 0x20\n",
> > +                     mdata.desc_offset);
> > +             return -EINVAL;
> > +     }
> > +
> >       ret = fwu_mdata_copies_allocate(mdata.metadata_size);
> >       if (ret)
> >               return ret;
>
> M
