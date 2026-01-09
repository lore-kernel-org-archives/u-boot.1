Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9C5D16817
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ADA38430F;
	Fri,  9 Jan 2026 12:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GOlClgtG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0EC08432E; Fri,  9 Jan 2026 12:36:35 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFDF084166
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b72b495aa81so802097066b.2
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 03:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767958588; x=1768563388; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ghTrF59mudYcfxd45qHkykF5Ery/WewN0zRNi+onqTo=;
 b=GOlClgtGhzP1FqYoyk6TEkMHW6woOWbDR1UIEKY1lmDtxQhzHr68CYXUtZYwD/9TkU
 yNMDEgDUv4CbMKlTdoTPF1ibuvDIi3SJz+7hJIUz6vT8DAm3XHw828EpNgnS4dYPvKcz
 FX8KzTAkJjFxe3Db8qbYRxuKrzJPj9omVdxoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958588; x=1768563388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ghTrF59mudYcfxd45qHkykF5Ery/WewN0zRNi+onqTo=;
 b=S5L/mBqEl5KZevI6eOvOwEYtW6ttS4xadSGwigdXYTFqJtSg6r17tJD7UPTCoPjrYT
 Q4wmkamc+ouFYh0ICFE5YfRtcXIPHkCvoO+AMRPgMO+bEbz6oyKC/dyModtYmvMDZnJb
 nhuvFmbNaHw34neEtIvp1WSjiCC8eqHZoqe6Xfy1CQ8qCrY7aruSb2aAiP4+htrL3K6x
 kTUMjCjkqHaSF/76Y4F2wAU/98IuD0W7bnx/DPcdbrtP7V315J+vVIIXiU8Yd9agMg9O
 xYeUx36DNlDcgOQ+dJE6MejY3QAZ7VtEyfstazUFfv97p2oMp2nDL4AIHsHxaa6gcdOF
 X5GQ==
X-Gm-Message-State: AOJu0Yx3OtZrjYRqzsxbLef/RDCipN6Tv8Yiz8Ewxl0uGFAMBDRwcenW
 xXLlgSBiCLvWHXxHEGL9XvaLnVFwNVhKS6mWsI/Zs8Hvou9xS44KAr42FZed680nSvvVFrR9CSz
 mjwqYVBg60i3IhMQsQXBTZZxKPvUbG35qmOmp2cIB
X-Gm-Gg: AY/fxX6DO/x7p76FVJi7o1ZdoJqWovYAi95im9R0gQp28u+zZYmSaIdmHWk739AHZEN
 W8ghzjfGwFkOP0UAjx1kZ/V0SuzvZnHBjSBsMH9kU4rxoRtIH+SgsnoOBRdmLJ7oorpk+2TSXaO
 zLnREHPAghFGyW/OgnZ5SGbSaYcxG9A1twIRP6XUl/K7J/fH5YXfHpq1YeTkaE+4s90k6QIvETN
 BfNoQNnc0qSYK3e+XQLRcY5NbqetnwNjJfzP50S0vqbORtNnX5/ddinVcBKMuPjNLjPNA==
X-Google-Smtp-Source: AGHT+IHvicBBPy5z86V1IeuSv0tQqc/NLvD9B+dyJV91c1BFkORMqW1n0BMcD2V6z8UNvtll8yW0fbUrxGqP3/R/DK8=
X-Received: by 2002:a17:906:4fcf:b0:b7a:259:2a32 with SMTP id
 a640c23a62f3a-b84451edd69mr938131166b.2.1767958588153; Fri, 09 Jan 2026
 03:36:28 -0800 (PST)
MIME-Version: 1.0
References: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
 <20260108-topic-musb-probing-v2026-01-v2-3-2a47c6e0e73a@baylibre.com>
In-Reply-To: <20260108-topic-musb-probing-v2026-01-v2-3-2a47c6e0e73a@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Jan 2026 04:36:16 -0700
X-Gm-Features: AZwV_Qgrl4x7Eu9KvXMUu7P3JGcRXg7jjKFCO1K2cSu-lSUpykdHYA5Lk3IsZ-I
Message-ID: <CAFLszTgEbo8c7_wm4DRZ-R36Pj_R6YsYx+4Ug_-SGv9zUSz0_w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] dm: core: Support multiple drivers with same
 compatibles
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Schocher <hs@nabladev.com>
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

Hi Markus,

On Thu, 8 Jan 2026 at 04:17, Markus Schneider-Pargmann (TI.com)
<msp@baylibre.com> wrote:
>
> Currently once a driver matched the compatible string of a device, other
> drivers are ignored. If the first matching driver returns -ENODEV, no
> other possibly matching drivers are iterated with that compatible of the
> device. Instead the next compatible in the list of compatibles is
> selected, assuming only one driver matches one compatible at a time.
>
> To be able to use the bind function to return -ENODEV and continue
> matching other drivers with the same compatible, move the for loop a bit
> to continue the for loop after -ENODEV was returned. The loop had to be
> adjusted a bit to still support the 'drv' argument properly. Some
> simplifications where done as well.
>
> This is required for ti-musb-host and ti-musb-peripheral which both
> match on the same device but differ based on the dr_mode DT property.
> Depending on this property, the driver is either UCLASS_USB or
> UCLASS_USB_GADGET_GENERIc. By checking the DT property in the bind
> function and returning -ENODEV the other driver can probe instead.
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  drivers/core/lists.c | 65 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 33 insertions(+), 32 deletions(-)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>

I would like to see some discussion about performance here. It seems
that all you are doing here is not exiting the loop early, so the
impact should be small?

> diff --git a/drivers/core/lists.c b/drivers/core/lists.c
> index 9d1ca38212ee7f53b8894f964f096611c8ec20a5..3d9f9bc93954efdd624dddb1833f3a855c3c28de 100644
> --- a/drivers/core/lists.c
> +++ b/drivers/core/lists.c
> @@ -235,50 +235,51 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
>                 log_debug("   - attempt to match compatible string '%s'\n",
>                           compat);
>
> -               id = NULL;
>                 for (entry = driver; entry != driver + n_ents; entry++) {
> +                       /* Search for drivers with matching drv or existing of_match */
>                         if (drv) {
>                                 if (drv != entry)
>                                         continue;
> -                               if (!entry->of_match)
> -                                       break;
> +                       } else if (!entry->of_match) {
> +                               continue;
>                         }
> -                       ret = driver_check_compatible(entry->of_match, &id,
> -                                                     compat);
> -                       if (!ret)
> -                               break;
> -               }
> -               if (entry == driver + n_ents)
> -                       continue;
>
> -               if (pre_reloc_only) {
> -                       if (!ofnode_pre_reloc(node) &&
> -                           !(entry->flags & DM_FLAG_PRE_RELOC)) {
> -                               log_debug("Skipping device pre-relocation\n");
> -                               return 0;
> +                       id = NULL;
> +                       if (entry->of_match) {
> +                               ret = driver_check_compatible(entry->of_match, &id,
> +                                                             compat);
> +                               if (ret)
> +                                       continue;
> +                               log_debug("   - found match at driver '%s' for '%s'\n",
> +                                         entry->name, id->compatible);
> +                       }
> +
> +                       if (pre_reloc_only) {
> +                               if (!ofnode_pre_reloc(node) &&
> +                                   !(entry->flags & DM_FLAG_PRE_RELOC)) {
> +                                       log_debug("   - Skipping device pre-relocation\n");
> +                                       return 0;
> +                               }
> +                       }
> +
> +                       ret = device_bind_with_driver_data(parent, entry, name,
> +                                                          id ? id->data : 0, node,
> +                                                          &dev);
> +                       if (!drv && ret == -ENODEV) {
> +                               log_debug("   - Driver '%s' refuses to bind\n", entry->name);
> +                               continue;
> +                       }
> +                       if (ret) {
> +                               dm_warn("Error binding driver '%s': %d\n", entry->name,
> +                                       ret);
> +                               return log_msg_ret("bind", ret);
>                         }
> -               }
>
> -               if (entry->of_match)
> -                       log_debug("   - found match at driver '%s' for '%s'\n",
> -                                 entry->name, id->compatible);
> -               ret = device_bind_with_driver_data(parent, entry, name,
> -                                                  id ? id->data : 0, node,
> -                                                  &dev);
> -               if (ret == -ENODEV) {
> -                       log_debug("Driver '%s' refuses to bind\n", entry->name);
> -                       continue;
> -               }
> -               if (ret) {
> -                       dm_warn("Error binding driver '%s': %d\n", entry->name,
> -                               ret);
> -                       return log_msg_ret("bind", ret);
> -               } else {
>                         if (devp)
>                                 *devp = dev;
> +
>                         return 0;
>                 }
> -               break;
>         }
>
>         if (ret != -ENODEV)
>
> --
> 2.51.0
>

Regards,
Simon
