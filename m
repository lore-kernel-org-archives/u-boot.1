Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E6FD6ACF4
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 16:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21D5D897D9;
	Wed, 27 Nov 2024 17:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EfuZxbby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 535EB897DD; Wed, 27 Nov 2024 17:52:38 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35146896C7
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 17:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa520699becso792644666b.1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 08:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732726356; x=1733331156; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qhyhAnPbYXwXOLQPaC5WFmtwhM798KMRNn6CPTawPSM=;
 b=EfuZxbbyoqsAwpGiySasc0FVviVE3Zhf5LN8WpVqNrgS6hpV5V2mSF4G9vKcBB+U2W
 jA0bXoOzpXBJ43CoKUSirrW2CwJi/DgJP0z6Ml8vbDlhj5XB9nWyhoqPlobnlV9xHKOp
 PQvA+auVO7sGQ1JT19H/zND0OSbhyMPNbCISI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732726356; x=1733331156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qhyhAnPbYXwXOLQPaC5WFmtwhM798KMRNn6CPTawPSM=;
 b=TBF83j8/h3Qox2gpLM7tdw1jwOUVf+7oXQQnEpobqji6hy26BCzRFyFoCOXnBF4TEE
 VWlmyzLEo9BNcECCOUcx5JsBfVw35kpo3t9YyKPCxReWDXo+v5ys37mxTwW+/ejeGpSb
 pbuY7VElTsrJN5zeHOldbaPXzCXyWBjiuwqte0IROUDBo54wSWT4Gh8nuQVOZItgaTIt
 2ELM8can+ev/YaP+Tvdy8z5KHS0wCILoMNDYbp3/LeIee9EY6aL/YeHbVcS4ZDOpIc1z
 0dUyQ+gfb5JWABdaop8zxLNP28avcjRdNh5LAu+7BL4cdwT8Pl2TxRMB8QuGAAPeMInk
 ISoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiANROAD+vRxTsdAQD0ByrkcoTH7BeAcKw3L2QyvJ0iL+lKrzk92Pxz8RnSKgWjDaOmSGYGwE=@lists.denx.de
X-Gm-Message-State: AOJu0YwIC3CUXcgSOGYsFvuspKAvobnyLkkl6FB4PKNYOwzPeIREIGAs
 TNWxs4aw9uJpEb1+LDDZV8yEMJaADEVl8h6d+jSD8Uilb9xtVzWiXNw2rj5VvR5bXjGhTjWUodu
 +lvsjOv+3PntbqkOak0HmOZS4z0jIcVrH8t2b
X-Gm-Gg: ASbGncsaS06+ZJhAw1m2oYcC7+WSJg4IiZLnTkiAv9IZPfFNfOOvDzU3ZSv5wL4svUr
 a+pl/n5oP1QT3lB31W7rh3ix16dVWUsw=
X-Google-Smtp-Source: AGHT+IHe4nFUwVaEgQVl7IcVi0RKsllJQPiq7WvMdDk5ZB80kwQZziRu7PsYtktEZLDx66cCWP+x13MyBU5LCCp8zv4=
X-Received: by 2002:a17:906:30c7:b0:aa5:1d68:1f45 with SMTP id
 a640c23a62f3a-aa580ecbd34mr282592966b.10.1732726355633; Wed, 27 Nov 2024
 08:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20241113052050.1862420-1-caleb.connolly@linaro.org>
In-Reply-To: <20241113052050.1862420-1-caleb.connolly@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Nov 2024 09:52:24 -0700
Message-ID: <CAFLszThAmn_NU-PoYopjx17Bk6QxgbFaCWJjKdMAG5JzLJWdEg@mail.gmail.com>
Subject: Re: [PATCH] dm: core: ofnode: safely fallback in ofnode_lookup_fdt
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
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

Hi Caleb,

On Tue, 12 Nov 2024 at 22:21, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Under some conditions it's possible to hit the null condition here like
> when running with OF_LIVE and using the ofnode API before
> initr_of_live() is called. There is very little null
> checking for this in the FDT framework, so returning null here can
> result in weird null pointer conditions.
>
> Instead let's return the control FDT in the fallback case, this is
> usually what the user was expecting.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/core/ofnode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> index 950895e72a99..7a7f25fc537c 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -152,9 +152,9 @@ void *ofnode_lookup_fdt(ofnode node)
>                 uint i = OFTREE_TREE_ID(node.of_offset);
>
>                 if (i >= oftree_count) {
>                         log_debug("Invalid tree ID %x\n", i);
> -                       return NULL;
> +                       return (void *)gd->fdt_blob;
>                 }
>
>                 return oftree_list[i];
>         } else {
> --
> 2.47.0
>

Eek I really don't like that, since it will silently return an
unexpected value. I think we should panic. Do you know what code path
gets you here?

More work is needed in livetree to sort of the rough edges, sadly...

Regards,
Simon
