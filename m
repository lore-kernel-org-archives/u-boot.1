Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9ADEC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 21:43:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EB9487886;
	Wed, 13 Dec 2023 22:43:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lXxSzVmr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65E8E878B3; Wed, 13 Dec 2023 22:43:14 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48F1D8747A
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 22:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2cc3dd2d897so8756991fa.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 13:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702503791; x=1703108591; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NVytI9euu+eEJR2s2Ywil0CL/l4wwNFWWnJdIER6Gz0=;
 b=lXxSzVmrOwZ1Nw/BnXAIUeZHXUvUTJu60tguxNZKvMerFvCtRqdXY6W5wHsD5LOcuU
 Ki72sVBgdbRKXhpbOi0s5ULIPU0gf4PeoHlEHUSRtGLTstbjt3lzpNyLmRFY4mhFDpKc
 RJAZpWDsNaJ0rp04NMVFZyl3DO4kIwnVReZcykZHLUZRscI6Rk85WeCFVLG5t3cRM90d
 Lr113CsUF2nL2Njp5CT2jr9UUT5uCow81D2FPLAqNBHx+w/0+yj2jnwb6UdeRmIldget
 x4exb6TS+7rgMxj35eTkufe+PaCw6+AVB2N8zr3hlEV7ymkjj/AssidNPcWbdAkqFNWs
 lwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702503791; x=1703108591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NVytI9euu+eEJR2s2Ywil0CL/l4wwNFWWnJdIER6Gz0=;
 b=hNTIkTzdBgeAY1EVoBEAO/d6PRNp6ovcApc+fndBwwZpJhUbYJPNVOYtmWWXsFJm1t
 vRMQZreLZgJ8Wk+HoINIdgkfA3O2lBYE3qIIosDWdXUAKQbRW4NX1HmFoQWMgORBVlEk
 F+macl57ZazZM0ggICXcOugnexf63VBO57eJMndaohOlzmp+DA/GNqvtxZNsoNo4/taA
 WFPn29YKxzRP1GWNmbPf9R4TgYdh6soDXGU0tSre1f4szC7NQs8gd6MK/VDqaDXhLBfl
 GpcTv7A6X3og4yIK3dQzQi+TP9ogOHK4nkPMBjk8KRwWkAS2el6PX9FdxfayTiyiwsvI
 alig==
X-Gm-Message-State: AOJu0YydUJVHVJAfIa2o/rBI5TC7wLQEiZ3080VmPj7hxg82PrUBMiw+
 KGS3QFqFVUYmL97/a99/QXfF8p/pzdCP1PS5d2sZgA==
X-Google-Smtp-Source: AGHT+IFpdVx1YXGJSajM3v4bZffgcpFtAxzKsisGdznw/TYCVihRSuimsStz5YWzgHXTJF4oZXGGLryqIFS/cApn+EI=
X-Received: by 2002:ac2:5457:0:b0:50c:bf8:ad13 with SMTP id
 d23-20020ac25457000000b0050c0bf8ad13mr3281430lfn.100.1702503791544; Wed, 13
 Dec 2023 13:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Dec 2023 23:42:35 +0200
Message-ID: <CAC_iWj+sxOhz5bLe=3cZ1vPx5KZSEe61Y+8eA5KdJBK=0MvvWw@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, sean.anderson@seco.com, neil.armstrong@linaro.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
 u-boot@lists.denx.de
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

Hi Simon,

[...]

>
> Can we add a Kconfig to enable this?

I don't see the point, and I am not the only one.

> > + * @size: str buffer length

[...]

> > +       int cnt = 0;
> > +       char *token;
> > +
> > +       memset(str, 0, size);
>
> *str = '\0' should be enough, assuming size is not 0

I generally prefer initializing all memory, it's not that big of a burden here.

[...]

> > -               str = ofnode_read_string(ctx->node, prop);
> > +               const char *str = NULL;
> > +               char str_dt[128] = { 0 };
> > +               /*
> > +                * If the node is not valid fallback and try the entire DT
>
> s/and/then/ ?
>

Sure

> > +                * so we can at least fill in manufacturer and board type
> > +                */
> > +               if (ofnode_valid(ctx->node)) {
> > +                       str = ofnode_read_string(ctx->node, prop);
> > +               } else {
> > +                       const struct map_sysinfo *nprop;
> > +
> > +                       nprop = convert_sysinfo_to_dt(prop);
> > +                       get_str_from_dt(nprop, str_dt, sizeof(str_dt));
> > +                       str = (const char *)str_dt;
>
> can't you drop the case?

What case?

[...]

Thanks
/Ilias
