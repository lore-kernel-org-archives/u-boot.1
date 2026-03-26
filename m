Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E49106F313
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 09:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC2F484082;
	Thu, 26 Mar 2026 10:37:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bThvDlIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB62F84090; Thu, 26 Mar 2026 10:37:41 +0100 (CET)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D0E383FE1
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 10:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64e9f9226a7so829947d50.2
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 02:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774517858; cv=none;
 d=google.com; s=arc-20240605;
 b=gKuMYxamevHPtB21zpJVv8fTQoDbYGDPwmip+FDPN0SI4An0Au4xOiKyBiaOaDIdw0
 xtZtGXFIlZRmtivb8az1QG6ya6Ce1QeT0KimpDzBxmdH4cSmms0lT/yvk61/QoMP1Pxn
 +7kOgMMY/glrkRDlk0+/K7tA6IJHNOooMzmLmiurIWunYS1aUoE3WTgTyLztc0zxoYAs
 ER+XfOJ/O9deTd4GRqQUHxCu4bLgkt97rNWCZWqfBw86IWMlWZRZRD+dVA11Xj+QPSQV
 vAAG5oIORsLjtKDaoASiSrmJi6jXs9tosA4dv/J5nJAhcdBf+ZDv7YmVRenmDSwtJ2xm
 P8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Vzqj5N8bfx7tobPdCoo0JIHk9oR9fLErkH6F5h4UgBk=;
 fh=nEkXRhqCjx3ONPRTdOk67xC+ThsQtT0sulRkQM3zgmo=;
 b=UuCLARt4n9JYFeMaEgsZcm0uZnYQIdH9+6bYMVfKW8ySlW75TRFo86zFym/laf0RZ8
 eWpFBrRV+BoArK2ASmtzDlN29ljVB8lIz8NI4MeUW9v2ucbLPPwmqpyYMptKR5CVlVzN
 dedUfY378KEnPq4IwIwBP17Z+3fFwGI8zNtPqGBrHV7KyfYIv3kpvcxhpgQ+1vdbqm7w
 UB/MOXl+Itk3ALWASw49+jdkmJV8TBxjMmzBM6OPhTx3wIf3gLjYvD4FDw5xAIRyig3g
 PotBRREHUTtb/VOG8gJjyNwbh3Nox4zMGj71X3Z4Xuik6Pl/097subfGoPVQUjLTu+ag
 s5/g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774517858; x=1775122658; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vzqj5N8bfx7tobPdCoo0JIHk9oR9fLErkH6F5h4UgBk=;
 b=bThvDlIazx2X2ToNXO8YjPWvtR0v3qJGz5rJmob8qAT/bTj1PfvjBu18d9bTjZ+nC2
 zDrR3UCq6moOh2rLb2w5ZdaFQOmeqSH5JOyMq/OLcwwAZX3HSnMvJCLXnWbglAlddyoG
 se4RI0JBLP4y0YwnpyL7NLb7aAOnT9FBMcukiu86qNzLDhS4vad4rpo7hF3oymkj6DTd
 fh+r2ViF3QiV+TYm7JDxQ1sTMlsgENN9io+ZmHSTxwi0I/+rfPCuUjRPOQHWjTKLRgsm
 XUJkTKEvAZoxD2PVzLWoBReV46iPWqa15nFk9gJlPIyNLbuTw+c1Tm6E1Wj4W2CsF52b
 Y2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774517858; x=1775122658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vzqj5N8bfx7tobPdCoo0JIHk9oR9fLErkH6F5h4UgBk=;
 b=SoRwLjNP4mNIwdKheDvUkH0RSaa4xaKS0qXGzslBgfKusnBfW1v39F0L89EvynChss
 03tonN4a7GvRxjCKQNOO/i05YUW9h0CYxxlaSQUlk0J34s50o5j1IzPsvtUQEkrdLpfm
 s9waJsb5ytJBZMx6R7nIi2ybAIddfZ+23BmdNwKom0STuMskjclMVhHlHPIESjJXmGot
 uyomGFnTMKRFHZ+zrhI4ia0Hc0LWHl+0lsm4jqfrVnatqTv9aQ0nY7YXcde7rOM/Xq6M
 ZwSd3xz+xmWTnDVuqhqkKAGZpXDhUOA+SXzkLdh78JP+qwtC+V/W6QLcKEF/zef8JlcL
 hnSA==
X-Gm-Message-State: AOJu0Yzd60U5U6eHnxSBoOGBwIyiIobBdyxtvrhsQZMbvizGfwHHljG6
 56IbqYWp6TMFS8iw1pHs1G+ZWxffaLQPoPjYR4mTOR+Pj8Uu0LtR42HEqntViu2BC7mQXIgTjwZ
 Jo7u44UaWF/QnEF1BOLpas0k7EwapRfexvz9P8P8N3A==
X-Gm-Gg: ATEYQzyc16rT28L1L8/BXheO2EYBWlMIVSzArjNX2VrU7IrKc2nXWkCe4GyEAZxO5Qh
 sb43G3Xj3ypIUHcq+P2L4RtR0UwjBYW9zY1ZfY7AD1voG4f5AY3QglrqyV/32I6S5jjrWV5Abey
 dhSnJYTdnvjepjRXy8eULGm5xnDyUXzfHLwaEVJCr6FcuyVdjvM8DL6yId4zmxPsRJ5XmHHe3qG
 HdiYqzRr8J4lmlnBpileaRIhOoWZmaonCQtRLURUJjMj4VZGXYXaZdH4pwxCPcD9WlkF04b2OXz
 pSWjuDmGroh+2OFpZoNV7KofI4ANNt0HQ6hH9nBBW/I17TGwy5hz4RkzCO4RMrGfcGQR6XbJfD4
 tRotJbVzKgWN6rA27tO1iMbxmyPooJb6aUQhMca7wOpJ1FgMR/O5b0SxhcdYfGmqpTmYOqgiL0K
 nEeYeI+To8xXoJQTraYx+6Vs0pvFV09GgMYd4bUdMSs1y6r4CR8oar6fF+zCDx/ugK9yVbP3S2u
 XiLwpDxE3fq1RwzEgiEYV/JRY7vix8fHZs0u1Elw6AHQsm57t51MBH7GZs5qJ2rJGqZJqbegi1c
 Niduw5izVNnMlfYQAyUsQGsDREO+8yVN9AXQxQW5Zhmd
X-Received: by 2002:a05:690e:419b:b0:64e:edea:dee3 with SMTP id
 956f58d0204a3-64eedeae164mr4259860d50.44.1774517857990; Thu, 26 Mar 2026
 02:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260325031743.371728-1-marek.vasut+renesas@mailbox.org>
 <20260325031743.371728-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260325031743.371728-2-marek.vasut+renesas@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Mar 2026 11:37:01 +0200
X-Gm-Features: AaiRm51EjpLRrMgJQFh6Fre_Yn6EDBQ3Y8JFt-PRz-SxzAvDukC0uhdhoU8hyKk
Message-ID: <CAC_iWjJX2Te=28zZYq=xMJd4r1AcxMXyejL19PTwKRcxoFkQsw@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] fdtdec: Introduce fdtdec_setup_mem_ram_top() to
 determine end of topmost DRAM bank
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Raymond Mao <raymondmaoca@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi Marek

[...]

> + * fdtdec_setup_mem_ram_top() - decode and setup gd->ram_top to highest address
> + * available in any memory bank
> + *
> + * Decode the /memory 'reg' property to determine the highest end of the memory
> + * bank and populate the global data ram_top with it.
> + *
> + * This function should be called from a boards board_get_usable_ram_top().
> + * This helper function allows for boards to query the device tree for topmost
> + * DRAM address.
> + *
> + * Return: 0 if OK, -EINVAL if the /memory node or reg property is missing or
> + * invalid
> + */
> +int fdtdec_setup_mem_ram_top(void);
> +
>  /**
>   * fdtdec_setup_memory_banksize() - decode and populate gd->bd->bi_dram
>   *
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index d820f75b031..bdb26d8fb75 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1162,6 +1162,24 @@ int fdtdec_setup_mem_size_base_lowest(void)
>         return fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_size_base_lowest_bankfn);
>  }
>
> +static void fdtdec_setup_mem_ram_top_bankfn(struct resource *res, int bank)
> +{
> +       if ((res->end + 1) > gd->ram_top)
> +               gd->ram_top = res->end + 1;

We can also update gd->ram_size.

I'll send a v2 with some changes in board_f.c using this code, so I'll
update it there

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> +}
> +
> +int fdtdec_setup_mem_ram_top(void)
> +{
> +       phys_addr_t old_top = gd->ram_top;
> +       int ret;
> +
> +       ret = fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_ram_top_bankfn);
> +       if (ret)
> +               gd->ram_top = old_top;
> +
> +       return ret;
> +}
> +
>  static int uncompress_blob(const void *src, ulong sz_src, void **dstp)
>  {
>  #if CONFIG_IS_ENABLED(MULTI_DTB_FIT_GZIP) ||\
> --
> 2.53.0
>
