Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A18ECFA459
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 23:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A37BA84158;
	Fri, 21 Nov 2025 00:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O6T8oYu2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 900C384142; Fri, 21 Nov 2025 00:41:27 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E81A8412A
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 00:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-297dc3e299bso15291405ad.1
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 15:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763682083; x=1764286883; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8lByLk++wWu5/09OxX4b4wUVgXq3lrL94TUb5iEvzoI=;
 b=O6T8oYu26PyVoWKEpw2xbX9YEDaU6dfl5X5woZfJ+gdeCWMMOOYmWRcQoB5G0ozpAn
 6htZ9hahMpx79GZPd86N7POw4zGSGoCoHk/nS7wGWpkLljucFJM9bzkHA/A/4+ABbDcT
 mjhp22fLxrOKMzUv/7vzcGSit9ipZLpNgiiYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763682083; x=1764286883;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8lByLk++wWu5/09OxX4b4wUVgXq3lrL94TUb5iEvzoI=;
 b=AzggPhQS5Uomt7ardkuj5Z7TrdpcO8QF0xAwZ1baXIImwUvU//0NBTo6F+jXf6RORd
 7RqSWK+jfvwHaOUyRcKhhOp9AE2sEZAUSVUMKBarzS3VxOKerzXmnnx5XDL/JPQiYbtk
 hVVpGwKf90c45254/zjM9iroCJro+R5/zStt+NpdGhsA1w/tG+AxFIBDdTO2KQJQl5qR
 asnU06roTqpLhGsDjX0vGWZJQOJHdU4H8lGrq15o2WjJRA9egC13jQtpRWDFKccem5q/
 stSK+Z3Jrd6Bbd1JBH3gv1zgmCNd2SlYaFe4yp6VqmLlFrI4x9y42PPuNh4P9rB6M6rs
 UG0w==
X-Gm-Message-State: AOJu0YyuB2Fwa6vF1QM2pg1TONTmDoUHJh5u+SF0+p5m6kDM7HIc8s6R
 sR+YeoE0iTXxbIwbeVuxa5gWiiMHGtf/bghVUxZ1tjkct5RTQFLxSstKP3afSkfk/XN4Aj1z6YH
 ExfG1Vd02m8sLpYgRDgOHd1gBFegwGz29i5QjkB9m
X-Gm-Gg: ASbGncvDgXlpx/K+g0eO1xrya3G0Yddk/iB9WZe/7UYAdhi0NzdFYQBNwAOrJySXA0T
 NGUJAP6MPHsaeAqjn+GUviyZ8NCW41HsEM4I8Y93ZKD0xgt1JzshVYRMc5tMIYq+wEoj4ya6Cvv
 LMqzIJIqIKcQywvOXAGqdS4jByFVt2itlbIoZn6nOlw+E97AcqpqGoAl12/2z7DpvkAdfMZ99AF
 uqbkbFxyVCDsIjZb/QvAUhTYcAOCZH9K+CPXTwxbm0iipCKTaU3ZYNY+PHy6+CUYs53GA==
X-Google-Smtp-Source: AGHT+IEv3Rii85zYSXSCzkyx4tIrid1C+QKqxjc3GJ864yqpNbXMk/SiUhTsnHQ4z+AzXZ8lY7m/3O5O2dO1+/xhJdM=
X-Received: by 2002:a17:90b:1c04:b0:32e:c6b6:956b with SMTP id
 98e67ed59e1d1-34733e48e4fmr295317a91.4.1763682082983; Thu, 20 Nov 2025
 15:41:22 -0800 (PST)
MIME-Version: 1.0
References: <20251120041439.817233-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251120041439.817233-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Nov 2025 16:40:39 -0700
X-Gm-Features: AWmQ_blaw6AJoseCCJ8ekRdjMXJ-qGDs_dclIO7Gk3-QAcFjs6jX3T4YSVQZ5VU
Message-ID: <CAFLszTjnGtSPvki-i1fHQEU+bn=6cTqjRFyid3D5zQepNEhzog@mail.gmail.com>
Subject: Re: [PATCH] clk: fixed_rate: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Wed, 19 Nov 2025 at 21:14, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> If CONFIG_OF_PLATDATA=y , then the udevice has no valid OF node associated
> with it and ofnode_valid(node) evaluates to 0. The dev_read_u32_default()
> call ultimately reaches ofnode_read_u32_index() which invokes fdt_getprop()
> and passes result of ofnode_to_offset(node) as an offset parameter into it.
>
> The ofnode_to_offset(node) returns -1 for invalid node, which leads to an
> fdt_getprop(..., -1, ...) invocation, which will crash sandbox with SIGSEGV
> because libfdt can not handle negative node offsets without full tree check,
> which U-Boot inhibits to keep size lower.
>
> Add dev_has_ofnode(dev) check and do not assign clock rate in case the
> device has no valid node associated with it, and do not call any of the
> dev_read_*() functions for devices without valid nodes.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/clk/clk_fixed_rate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/clk_fixed_rate.c
> index 95a77d2e041..5c32ae207fe 100644
> --- a/drivers/clk/clk_fixed_rate.c
> +++ b/drivers/clk/clk_fixed_rate.c
> @@ -35,7 +35,7 @@ void clk_fixed_rate_ofdata_to_plat_(struct udevice *dev,
>                                     struct clk_fixed_rate *plat)
>  {
>         struct clk *clk = &plat->clk;
> -       if (CONFIG_IS_ENABLED(OF_REAL))
> +       if (CONFIG_IS_ENABLED(OF_REAL) && dev_has_ofnode(dev))
>                 plat->fixed_rate = dev_read_u32_default(dev, "clock-frequency",
>                                                         0);

What is happening here? It should already be checking this:

static inline __attribute_const__ bool dev_has_ofnode(const struct udevice *dev)
{
#if CONFIG_IS_ENABLED(OF_REAL)
return ofnode_valid(dev_ofnode(dev));
#else
return false;
#endif
}

Regards,
Simon
