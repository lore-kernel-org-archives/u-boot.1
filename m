Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B99C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79DD8806D4;
	Wed, 15 Jan 2025 02:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WBpcntEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3A8E806D6; Wed, 15 Jan 2025 02:17:55 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E72B8069A
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d3ecae02beso7856811a12.0
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736903873; x=1737508673; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zr31npFw6/oKrE7pFbrtGZwIr5ri7cadXnH1PlSYPzQ=;
 b=WBpcntEK4Y3cGBNJ4WDhMNWV8GjGx69scHLA2EkKwhZpyIXfg69YNCMGoXf0EHikQX
 y87gT5UPY7CGOp+oPhYisLywndwmHAqZDYbiMZ8LQ1Cy6ZwLNyzyAVnosnWwfECwPxly
 PpEbdZ2tq2mg8pbanQwM+Z9JYgtZ97C7xo86Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736903873; x=1737508673;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zr31npFw6/oKrE7pFbrtGZwIr5ri7cadXnH1PlSYPzQ=;
 b=Yv0VGEuPyXn7Iw6y6uBHQlGTEVtE1joqOpqPJVoK2NwnkjpGOtMxYd7N6guzdAsB/Y
 houg6mlGLlKm7Bmv4kwSgtx+3sb5QCiUzrUuz6JdG2B/oN29AARZDtW3CQRMXqc8GN8c
 3Xodnz+KzEyFmAxeUI27EOE06NBFlaFJvPgMeR7J1saIJkXGAXR7/46nywjA7QRjPJRm
 06c9JstAnfnbWcrbZv0pso056OWSl5vaxwk02NC8AQgcVmlE9RKbI3ONKI9nR96e2elz
 m+k52dZ/1GDcpp+0kQYfvcW618TtvEiQD1yWxC9dTDmD75va1Br+L5+Pk2sUSF+qAi3B
 UGaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJu0dMLN4xuwaL7yvl/zFP6OIyxSkxKC7oyglWeI1VzzRqrDi5j6WgLKoeIjH8cN9CbQMXcjI=@lists.denx.de
X-Gm-Message-State: AOJu0YzXFoXvpMrIyYEFb1q0WFxnB4HeGaSFLK3gdghXRszz2kA65rhi
 brvFCYgcp1ElT6m30KYsvfY2HK5kSEDBeGUrf1dc1epRE0Hmc9Y74vE0ITJJDGaQ9cS/40SsMNs
 K503jpys94ktdDMwZ4IQIxkoyKj2crFPjEI8k
X-Gm-Gg: ASbGncuMFOXOAzFMCqYi259nlYZTAZijZeU+S+0XNqXeGoHaDVxvps0RZYWqy+l8IyV
 aTThLlWFjdMpZ6MTURkopLYv9piMxzf9Iz43CDkQ=
X-Google-Smtp-Source: AGHT+IF8xAIhZgHIe2UzWJlAsEdxBPl3hxhDlEaNMBu7t2Rr+wUnz3XnzfEFBwQZqPVjnpegjQeVRA1zcCdUAdKzdg8=
X-Received: by 2002:a17:907:7f08:b0:aab:9430:40e9 with SMTP id
 a640c23a62f3a-ab2ab70a84emr2408391366b.32.1736903873047; Tue, 14 Jan 2025
 17:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20250112034213.13153-1-semen.protsenko@linaro.org>
 <20250112034213.13153-4-semen.protsenko@linaro.org>
 <e865e678-3319-4b89-b2c9-28a2ddea46f1@gmx.de>
In-Reply-To: <e865e678-3319-4b89-b2c9-28a2ddea46f1@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jan 2025 18:17:41 -0700
X-Gm-Features: AbW1kvZ_5BJil5Z_sjkL--4txv7WBn2ouugsrzCEz-_KQw0-mSjbkCtTiCsyGBo
Message-ID: <CAFLszTgieQ0d=Y0q_jovuwH6mtXUKr-TzE7mwfvDw4_vbbVV9A@mail.gmail.com>
Subject: Re: [PATCH 3/3] bootstd: Fix incorrect struct name in
 bootmeth_setup_iter_order()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Heinrich,

On Mon, 13 Jan 2025 at 00:49, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 1/12/25 04:42, Sam Protsenko wrote:
> > There is no such thing as struct bootmeth, it's probably a typo. This
> > issue doesn't affect the execution as it's a pointer, and pointer sizes
> > are the same for all data types. But it can be confusing, so make it
> > struct udevice, as it should be.
> >
> > Fixes: a950d31abe98 ("bootstd: Add the bootmeth uclass and helpers")
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >   boot/bootmeth-uclass.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
> > index 049389403191..2496e8c1d8a8 100644
> > --- a/boot/bootmeth-uclass.c
> > +++ b/boot/bootmeth-uclass.c
> > @@ -139,7 +139,7 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
> >                       goto err_order;
> >               }
> >               memcpy(order, std->bootmeth_order,
> > -                    count * sizeof(struct bootmeth *));
> > +                    count * sizeof(struct udevice *));
>
> I found this description of the field:
> @bootmeth_order: List of bootmeth devices to use, in order, NULL-terminated
>
> As the list is NULL terminated, shouldn't we copy the NULL value, i.e.
>
>      (count + 1) * sizeof(struct udevice *)
>
> so that we can still identify the end of the list?
>

Unfortunately that comment is out of date. The bootmeth_count member
holds the count now.

And probably it would be better as an alist now that we have that.

[..]

Regards,
Simom
