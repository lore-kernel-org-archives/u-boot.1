Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A445EEE57F9
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B50D88D75;
	Thu, 12 Sep 2024 02:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CoXNYGP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C6BB88D68; Thu, 12 Sep 2024 02:59:09 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 633E188D7F
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-718d8d6af8fso255664b3a.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102744; x=1726707544; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=77Q8lr9BKD7MyqNH9EI2s+lEVnPH+6P8Cx5LdmYRJHk=;
 b=CoXNYGP1FiOOwlJYs5AJuR1o7U2nVKPjbRngrY27VHsd8Xudjnpi28L4I8ieG84P20
 oKlWCSuyPW4OqWE/owojoEg4maZh1qx0oO0U3ZQm+HZ3Pr/J88qGoqA/GyvCVmVVBou5
 lT7wON0DiQ1kiaBXhMD3XyG3qgsSO5QMuVFJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102744; x=1726707544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=77Q8lr9BKD7MyqNH9EI2s+lEVnPH+6P8Cx5LdmYRJHk=;
 b=CgQ86TrBOjpOFcLcpKeQZ/c/Zz3gjvKZbHvOPvnAx5zZLttr2WPV6A+sZskgBF0q9B
 UpUmD/r+uhANHsk5q0yWsgdaCqfxc9bW4tBSq3PNgHlc+lcl4PSBdqZKtvRegGHqfatT
 pdDuPSCYejKbhJOuF/rmn0Q2WkdjyKx99tcbYxjzW4jy2vVI+jveVzezrrBBNpk3eLLu
 aPMzj/TBWCRjYn6Rj12X3O+xtaW92Kqjnjs4V1B1+vCGMDr3T5PnBg89tT483BLtg2JK
 RXMwdBalQ0mToUHBYXlmZjHAfizvBDDJalul2sj+BwVtpBGUMMD9FELTQUZ5uGntspRS
 6n2Q==
X-Gm-Message-State: AOJu0YwUZ35G/6rjKeRGaAsTnbTh6THy3Y7Tk7+00WyDJ13F5sG11wdb
 zpsKz/eZpMjifusng3UXIevhnLMWibSloymjd0u8SvONgrUT56r2caqKCISIpwebP1Fb2rh5SrS
 VJnUngPt+vRqECb3WgcrFD3qpfcugK9TkzxnhSfi5YYDDYVo=
X-Google-Smtp-Source: AGHT+IG9eR1TbOqBK9sGXWLyh8kekPaGioY88izzwvDG+5Pyd19EEQGzFq50UYXYWFx74CbBqxY1REtBlSoW5nLddMc=
X-Received: by 2002:a05:6a00:1a86:b0:717:839c:6838 with SMTP id
 d2e1a72fcca58-71926095e9bmr1300204b3a.14.1726102743870; Wed, 11 Sep 2024
 17:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-20-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-20-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:26 -0600
Message-ID: <CAFLszTj90Xm50hNCC0S3wn7nJyXp4R2JoMMg1+sCUabjJGhJTQ@mail.gmail.com>
Subject: Re: [PATCH v3 19/30] arm: gic-v3-its: Rename objects
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Tom Rini <trini@konsulko.com>
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

Hi Patrick,

On Wed, 11 Sept 2024 at 00:29, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> The code accesses the gic-v3 node, but not the gic-v3-its node,
> thus rename the objects to clarify which node it operates on.
>
> The following commit will make use of the gic-v3-its node for real.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  arch/arm/lib/gic-v3-its.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

But how many interrupt controllers are there? Would
uclass_first_device_err(UCLASS_IRQ) work?

>
> diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
> index 2cc0a32f9d..22fa46a341 100644
> --- a/arch/arm/lib/gic-v3-its.c
> +++ b/arch/arm/lib/gic-v3-its.c
> @@ -35,10 +35,10 @@ static int gic_v3_its_get_gic_addr(struct gic_v3_its_priv *priv)
>         int ret;
>
>         ret = uclass_get_device_by_driver(UCLASS_IRQ,
> -                                         DM_DRIVER_GET(arm_gic_v3_its), &dev);
> +                                         DM_DRIVER_GET(arm_gic_v3), &dev);
>         if (ret) {
>                 pr_err("%s: failed to get %s irq device\n", __func__,
> -                      DM_DRIVER_GET(arm_gic_v3_its)->name);
> +                      DM_DRIVER_GET(arm_gic_v3)->name);
>                 return ret;
>         }
>
> @@ -158,13 +158,13 @@ int gic_lpi_tables_init(u64 base, u32 num_redist)
>         return 0;
>  }
>
> -static const struct udevice_id gic_v3_its_ids[] = {
> +static const struct udevice_id gic_v3_ids[] = {
>         { .compatible = "arm,gic-v3" },
>         {}
>  };
>
> -U_BOOT_DRIVER(arm_gic_v3_its) = {
> +U_BOOT_DRIVER(arm_gic_v3) = {
>         .name           = "gic-v3",
>         .id             = UCLASS_IRQ,
> -       .of_match       = gic_v3_its_ids,
> +       .of_match       = gic_v3_ids,
>  };
> --
> 2.46.0
>

Regards,
Simon
