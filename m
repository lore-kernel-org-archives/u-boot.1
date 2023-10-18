Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D583ECDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 08:39:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E39F86B05;
	Wed, 18 Oct 2023 10:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XKgUa0EL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85D3486BB8; Wed, 18 Oct 2023 10:38:59 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A2D186A9F
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 10:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-565334377d0so4908408a12.2
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 01:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697618335; x=1698223135; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TZnS4C62TpW2KM24oVB5eGRMRzqf6JSMCdNhXwwdXjQ=;
 b=XKgUa0ELrSnLFmXJYvCp9e+1jgWap5Bzh/kUd5duJGGlO3ccvIoXRCZCR8cN/kKLQS
 V5u5SC6QA6A4dIX86j1lB7Tdn2CD8o+ByLGvmGPX+LhmvfKK4OCc5a3d/hgjtcDIVeh8
 dGwSgkEz3ZWPjrbkep+XcsnLyZ3mLDyJ4P2D0i4Q5gIISwCPa3rlLE1dRAKsN1po0cAo
 YVK8tKYypTWP8XAtkYvUxOP2O0o7VjFW4P1fEdMIGIWiloFIrMtVYMPcampq+V0YJKfl
 fCa/F3dhlcjAYp8J29DkE9CEPRAj10NvMkUYdPoAh6rIuad3TcVyojuh/jylIDH/MDl6
 xOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697618335; x=1698223135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TZnS4C62TpW2KM24oVB5eGRMRzqf6JSMCdNhXwwdXjQ=;
 b=rntWbbujUktywLGbFfZAE7Xm0XJPBpk1ud/PAFVI81WGZeO6UCJaR0o2S9iQBde9bw
 4dOwHtyBaUBdk5TgJmxbUDqTFpMPZ7Ffiqc4tNuoTRjBvJuWQVegh0x/vgfBnZAi0asN
 NJ6yiQct8dMq9sMe/mWT/OjroMDkJGD3GtMB/g2Pk0OlBnaJAdJPixxqkDLA1ttI1uYm
 GkDC+zAWgpZpMP1Rj9X1an15KPa7wfyP3syGZnJPHgdzli9KtLR46C6cVDgKmBtitl4W
 ZyAa07NCDPeT321K9KEVmFz7jntX6qRiKv5f1bh2rGe366pArla17fvReHiXSxGOcdJl
 CqJQ==
X-Gm-Message-State: AOJu0YxwVHHVUdwlCBlQpjjT5B2ekvieSMGxoTyXqxl/aH9KR6m+xtW5
 1HHl51q+0qv45yBMilwVwWv3LsFZB6Yb1FK9G8sAFw==
X-Google-Smtp-Source: AGHT+IHh4xCVPIh/Er3RFzWTVUY8GGj65b1li0JJT+szF1jFxKGDn+7eayN1tvpd9lIQLnx1w3hU5x+/t7Uf41YlyJc=
X-Received: by 2002:a05:6a21:7189:b0:154:e793:52b3 with SMTP id
 wq9-20020a056a21718900b00154e79352b3mr4223985pzb.0.1697618334731; Wed, 18 Oct
 2023 01:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
 <20231016064526.2410856-9-masahisa.kojima@linaro.org> <ZS7gBMES7sBTbUu+@hades>
In-Reply-To: <ZS7gBMES7sBTbUu+@hades>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Wed, 18 Oct 2023 17:38:43 +0900
Message-ID: <CADQ0-X9eRfRHRhxVpqG06hgB406onVRNVabEA2umPbxN0OcF1g@mail.gmail.com>
Subject: Re: [PATCH v7 8/9] cmd: efidebug: add uri device path
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
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

On Wed, 18 Oct 2023 at 04:27, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Kojima-san,
>
> [...]
>
> > +                     id = (int)hextoul(argv[1], &endp);
> > +                     if (*endp != '\0' || id > 0xffff)
> > +                             return CMD_RET_USAGE;
> > +
> > +                     efi_create_indexed_name(var_name16, sizeof(var_name16),
> > +                                             "Boot", id);
> > +
> > +                     label = efi_convert_string(argv[2]);
> > +                     if (!label)
> > +                             return CMD_RET_FAILURE;
> > +                     lo.label = label;
> > +
> > +                     uridp_len = sizeof(struct efi_device_path) + strlen(argv[3]) + 1;
> > +                     fp_free = efi_alloc(uridp_len + sizeof(END));
> > +                     uridp = (struct efi_device_path_uri *)fp_free;
> > +                     uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> > +                     uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
> > +                     uridp->dp.length = uridp_len;
> > +                     if (!wget_validate_uri(argv[3])) {
> > +                             printf("ERROR: invalid URI\n");
> > +                             r = CMD_RET_FAILURE;
> > +                             goto out;
> > +                     }
>
> This needs to be moved right under label = efi_convert_string(argv[2]);
> and group all the checks together early.  You won't have to allocate and
> free the memory as well

OK.

>
> > +
> > +                     strcpy(uridp->uri, argv[3]);
> > +                     pos = (char *)uridp + uridp_len;
> > +                     memcpy(pos, &END, sizeof(END));
> > +                     fp_size += uridp_len + sizeof(END);
>
> Assign this earlier and use it on fp_free = efi_alloc(...)

OK.

Thanks,
Masahisa Kojima

>
> > +                     file_path = (struct efi_device_path *)uridp;
> > +                     argc -= 3;
>
> [...]
>
> > + *
> > + * @uri:     uri string of target file of wget
> > + * Return:   true if uri is valid, false if uri is invalid
> > + */
> > +bool wget_validate_uri(char *uri);
> > +
> >  #endif /* __NET_H__ */
> > diff --git a/net/wget.c b/net/wget.c
> > index 2087146b37..6ae2237a0a 100644
> > --- a/net/wget.c
> > +++ b/net/wget.c
> > @@ -566,3 +566,74 @@ out:
> >       return ret;
> >  }
> >  #endif
> > +
>
> Regards
> /Ilias
