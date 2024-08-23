Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E9BC5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CECDF88C31;
	Fri, 23 Aug 2024 22:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ogVKI/E+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6ED788936; Fri, 23 Aug 2024 22:47:42 +0200 (CEST)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE14288A99
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4fce23b0e32so825165e0c.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724446060; x=1725050860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RBerO+IJHEXf5q8UxEBUFoh4qiu0moFIn/HYdcxUdpc=;
 b=ogVKI/E+vz4W/3v91V2ouL2Zg8XA3zExavEtCh6IBRtlBYnsZjEP19+PWCcgDZpqnH
 xnYCYqbz9yL12UDezPswXgs8pBvJjsdIMf74GfgA4RBC3xdb8Dz9JZvjoe1OXM8UhYdu
 9H+FQKudkmOZ1BhOy5G1IV1PJEsoeyuqh+Pgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724446060; x=1725050860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RBerO+IJHEXf5q8UxEBUFoh4qiu0moFIn/HYdcxUdpc=;
 b=PU+19SqDfhIhguigzvdgkm8HI73sVZa0xFTBrHLSnZAyGv1+JDtOMgQDLoQNSbQyB9
 vo/8vPXMLP/RRMUbkfEpQMMClMaMSowL4w/l1wfZKdvsfdWM4EcyQaiiU2WkCyk7jRxS
 UuF0/NYrhqpU84BuYmz9kQiwtW1uTSCQInhEdqocg6GVNTOAmYYbvqvFcXcbUGVF7mdS
 HlyEGMSMFM3iS1mLG14vo5hacFEhQyiQRk7b/IwpYRvz+f/oLwR40E0T8vAahl2PSEdn
 4QzVa4fU+q2uNyRm4FBqqA5BtkDzAXTd6E7pGUCZ4qEJUViPDJaMpcnhVJwzj05mQHf5
 3Azw==
X-Gm-Message-State: AOJu0YyOUNalKqh1h9fW8eDb6yU7oSjTaAKGQLtH15Cxn01M45tVF8fa
 K47jyiOURXjWzh0SA3vA7E6ec9tZqsGxsKLoYd9PkOIE6WGKCAYuELdk5NTLanpnJL3nLepMmtI
 obiruQ3u23JPDqEPn8wAWpzz5I4eBfksuCGfr
X-Google-Smtp-Source: AGHT+IHI2tfC6zMLe3gapDjXJdAqIi0UK89wdcNIxYwby8skAyccFO0nIwdDEdwNjyULYClIZVP5fhPqicwVnY7LU10=
X-Received: by 2002:a05:6122:c9c:b0:4f6:b094:80aa with SMTP id
 71dfb90a1353d-4fd1a7e1943mr4655520e0c.9.1724446059629; Fri, 23 Aug 2024
 13:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
 <20240821105839.2870293-28-sughosh.ganu@linaro.org>
In-Reply-To: <20240821105839.2870293-28-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Aug 2024 14:47:29 -0600
Message-ID: <CAFLszTjyyH39VFtR6yL2Ae2p_XzWooxwMY_iN1mtoX0XoSpWPg@mail.gmail.com>
Subject: Re: [PATCH v3 27/27] lmb: add logic to print lmb flag strings
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
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

Hi Sughosh,

On Wed, 21 Aug 2024 at 05:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Instead of printing the LMB flags as numerical values, print them as
> strings. This makes it easier to understand what flags are associated
> with the lmb region. Also make corresponding changes to the bdinfo
> command's test code.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2:
> * Change the logic to accomodate new value of LMB_NONE(0).
> * s/print_region_flags()/lmb_print_region_flags().
> * s/"LMB_NOMAP"/"no-map".
> * s/"LMB_NOOVERWRITE"/"no-overwrite".
>
>  lib/lmb.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

nit below

>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 11959760b6..0379798837 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -26,6 +26,19 @@ DECLARE_GLOBAL_DATA_PTR;
>
>  static struct lmb lmb;
>
> +static void lmb_print_region_flags(enum lmb_flags flags)
> +{
> +       uint64_t bitpos;
> +       const char *flag_str[] = { "none", "no-map", "no-overwrite" };

This implicitly follows the enum values, but I think that is fine
given that this is debug / dump code.

> +
> +       do {
> +               bitpos = flags ? fls(flags) - 1 : 0;
> +               printf("%s", flag_str[bitpos]);
> +               flags &= ~(1ull << bitpos);
> +               flags ? puts(", ") : puts("\n");

That line is pretty uncommon C :-) How about putting the ? inside the puts()?

> +       } while (flags);
> +}
> +
>  static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
>  {
>         struct lmb_region *rgn = lmb_rgn_lst->data;
> @@ -41,8 +54,9 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
>                 end = base + size - 1;
>                 flags = rgn[i].flags;
>
> -               printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: %x\n",
> -                      name, i, base, end, size, flags);
> +               printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: ",
> +                      name, i, base, end, size);
> +               lmb_print_region_flags(flags);
>         }
>  }
>
> --
> 2.34.1
>

Regards,
Simon
