Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF0BCE9D78
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 16:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5802D83FCF;
	Tue,  6 Jan 2026 17:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G8tFjzQs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD2D583FCD; Tue,  6 Jan 2026 17:23:34 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E86983F5D
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 17:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c1e7cdf0905so761187a12.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 08:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767716611; x=1768321411; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIF+zqKYS0qHU1Dpa/3duS5t+XGUw8qrqcSjY8o8mIU=;
 b=G8tFjzQsoRQpiUbKfwHXYEer0l/loJVgc0C6B7YZOIaJ0Dq+4msZmjX0Yl43N+th6J
 vL3Ieppk97P0Jf4OOdFgSWmU2CjWT1sz5bQVEiZaIBsW4LFhfpWNFFs+RRoHElHQO0/C
 bhmUUWrVAw7Q6tLuw5AFPypZ+/12PKPJ1bRVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767716611; x=1768321411;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIF+zqKYS0qHU1Dpa/3duS5t+XGUw8qrqcSjY8o8mIU=;
 b=eGSCs3Qk1xjIvvE31hQz9dgH0ReC/d8FgMP9+TJsAN/tDsLCZfNkZE3ItNd1G2TTvF
 r9NIR8nYZYYFgi5xZB7zqUEL9KOSNnCk1poNrni9T8S1x5QyKLvQL4rfvTEegVX1j4tw
 gtnY2xa/lPd09FigReAhQbgW/8cAt4bcxyNA3onT+nFOvXdTi53IUBw4kSaP8RKiJsO4
 DFqExeESSVis6iqmNJzluWRE7GCA9m96NKMZhxT74RSFDkGe7zdpqV0rTjyLYDxCjqkY
 ChGHPxIISoRKxNQ3NoNiJ1InGzv0uk1l0KU+kZA4i5YQ1AaWIOqBchThvGwO+HpcUT9F
 ZWQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVke/nWod1ajhqNCUAQU/T1QN00hxBZsUYZSkAC+Vwud2Q2IHVPpkYQE5U9VjQwZJ3VbWScsqQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yzc1OFcB+MZM+PV/dvTCDLZHMWyhVPJewDckm35hFLzl/Mh1Ti7
 qHxEKzjoQerxaK1rvVK0lDWCndP3zpg92yGOBhS+BnFkyV6d/AZTuvtFI0uu0lt6PM1iaFBUomT
 kvEwI9L4o5utC3hO5O8BEKKvCgGo3oXy8qSqmrMET
X-Gm-Gg: AY/fxX5tvMcv5+r1ehw+zlPwC9BGvTKhHZMItqxd1+qm5xQXtcVVNWmKv+mGwI6Q48Q
 zK6ILHLWIC3rMSd1PKI4NWSzwqBLTlHK/XrrMQbyKu0/o9odTQMBHXgAr7zFBTND1Sp3a5iX17L
 XSy+yJ4AhJV5+SnBg9SIG9Ukht2XJPW86tbU04Pk3GPY6GgL15eTMNEYrr1dltM0YTCwkaHf5x4
 /B2nJSXeEICP6ZkPBIspZUVFC31s3GY3YItsyvHSRGvhxM5dnULxX+svmAnFveWfTJJUA==
X-Google-Smtp-Source: AGHT+IEv7AEsATFSuYbqC9+ZomUWrbLpPqPg0QHhkcoUjLwoeFIhPNZ6R4nIaTdEKbpFoLrgo61IPfFB0FlJFg4p2Gs=
X-Received: by 2002:a17:90b:5708:b0:341:c964:126c with SMTP id
 98e67ed59e1d1-34f5f34bfcbmr2539425a91.34.1767716611073; Tue, 06 Jan 2026
 08:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20260101-clk-reparent-v2-0-3eb42b78c7f1@outlook.com>
 <20260101-clk-reparent-v2-3-3eb42b78c7f1@outlook.com>
In-Reply-To: <20260101-clk-reparent-v2-3-3eb42b78c7f1@outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Jan 2026 09:22:24 -0700
X-Gm-Features: AQt7F2q3xAm2WA9_5lv7-ZyuMVabOxlHomu7KMD2vvrf6G_Fs3gV89v4Qv7IdV4
Message-ID: <CAFLszTh=GW-j-CoX_PnObJv8g5ukh0vjtWSyLgdepBuJxLRDDg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] clk: use clk_get_parent() helper in
 clk_en(dis)able()
To: forbidden405@outlook.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
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

On Wed, 31 Dec 2025 at 12:52, Yang Xiwen via B4 Relay
<devnull+forbidden405.outlook.com@kernel.org> wrote:
>
> From: Yang Xiwen <forbidden405@outlook.com>
>
> Update clk_enable() and clk_disable() to use clk_get_parent() instead of
> manually accessing clk->dev->parent.
>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/clk/clk-uclass.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)

Reviewed-by: Simon Glass <simon.glass@canonical.com>


>
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index bd18de972bb9..bfad71e7af70 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -656,7 +656,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
>  int clk_enable(struct clk *clk)
>  {
>         const struct clk_ops *ops;
> -       struct clk *clkp = NULL;
> +       struct clk *clkp = NULL, *clk_parent;
>         int ret;
>
>         debug("%s(clk=%p name=%s)\n", __func__, clk, clk->dev->name);
> @@ -672,9 +672,10 @@ int clk_enable(struct clk *clk)
>                                 clkp->enable_count++;
>                                 return 0;
>                         }
> -                       if (clkp->dev->parent &&
> -                           device_get_uclass_id(clkp->dev->parent) == UCLASS_CLK) {
> -                               ret = clk_enable(dev_get_clk_ptr(clkp->dev->parent));
> +
> +                       clk_parent = clk_get_parent(clkp);
> +                       if (!IS_ERR_OR_NULL(clk_parent)) {
> +                               ret = clk_enable(clk_parent);
>                                 if (ret) {
>                                         printf("Enable %s failed\n",
>                                                clkp->dev->parent->name);
> @@ -747,13 +748,16 @@ int clk_disable(struct clk *clk)
>                                 return ret;
>                 }
>
> -               if (clkp && clkp->dev->parent &&
> -                   device_get_uclass_id(clkp->dev->parent) == UCLASS_CLK) {
> -                       ret = clk_disable(dev_get_clk_ptr(clkp->dev->parent));
> -                       if (ret) {
> -                               printf("Disable %s failed\n",
> -                                      clkp->dev->parent->name);
> -                               return ret;
> +               if (clkp) {
> +                       struct clk *clk_parent = clk_get_parent(clkp);
> +
> +                       if (!IS_ERR_OR_NULL(clk_parent)) {
> +                               ret = clk_disable(clk_parent);
> +                               if (ret) {
> +                                       printf("Disable %s failed\n",
> +                                              clkp->dev->parent->name);
> +                                       return ret;
> +                               }
>                         }
>                 }
>         } else {
>
> --
> 2.43.0
>
>
