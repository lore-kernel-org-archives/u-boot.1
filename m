Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE260F99C9C
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 06:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C2C7840D8;
	Mon, 20 Apr 2026 08:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NR8Fotrz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F96D8419E; Mon, 20 Apr 2026 08:07:29 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11BDF83B99
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 08:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-79853c0f5b9so37036227b3.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 23:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776665244; cv=none;
 d=google.com; s=arc-20240605;
 b=jLBDe8W5I/fK+GJe2E1B3Tw8iSHGpf6uUlPMk7UzGcvNr442fJ6Tom2vs2Ixk7KYgQ
 jHnFJwSqZEm1HFdeCJvy9G4meZ2nEHNSnJ5GNwY4WXSwxlIe67Nv4MD8XH4eTFbO6DFw
 G1Ji3ROxi/FpH5vM7Tpirc4w5B0Of4nbQD5KYn3GNlD7Ktbt2if319/kNgTQ+ZLxU2lP
 vU+sEyMgWRtR9MjMdRqLt2NFjfqecKnHuXlccEG1jHi9SoQ7FdwwQ4+reUsbPH1zXqMs
 SnJdTXlkFwOctpqeHziNPUfkQNpOgDsRFz4C8B88/KQX2+WjxNv4caX+ytUUGbcL2o4J
 ycQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=B1jIReC1N5ZXw+ZbV8J5bGoAtAcDM/LlsCALqWLhnLk=;
 fh=Ev8sEGiq8J2iXPIqsS296pE7QnmiqYV6VY5h2/jYy7k=;
 b=NcBDZliIBOkjKNJmYg5h7aW3C9EwhvJOXqysMbXzyayy/TeBYo06KLdz8PYz0AA94L
 htUN57WomsnDQZcK6bCD4gm9617xwjnRBlovvdJfxDYk2hToAvgzszGSCcjiK36dunHc
 yf/Id/cZ+ECo6PPQKk5HFrKPGIhHNLw69RAvRvyUulBCCurueeCSLD6JwkPy6UM4PUhD
 Vj+uP/Pey96ZWfS0kbw3nPVRC1g+5BRULH5+yqBUcdFyZBwKNP4w8/47bGf0WZ/gzRGh
 Dn3bauRpHCYiN9QavjXy6AMAEwn30TOWmbXHEUx/Bbo72rumfS06rZaqew/SESrycqxP
 EVKQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776665244; x=1777270044; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B1jIReC1N5ZXw+ZbV8J5bGoAtAcDM/LlsCALqWLhnLk=;
 b=NR8FotrzSs3JvljoosCHwcMLtlcH1GyCjs1Yv7MiB+AD+3xCyxke8z/ftgYjevvEsq
 P/tKufxxYFhXFtIl/mpXUG+u3jPMb9LreLs3+BlGnCxCwQdetLNnegqKatxfLoO+f1V0
 QTvuuOZ0F/apnW4cJ7BKeJTGBDke2u9wbfmQ1K76R3XunmoUOsh6+yoyytuBOku0RLD8
 2loqowG0F1buPx+ICOt1+MmVFEmDsnF6KjWlz4eJrJ6kA/oiaZYZFPGj5ErCepVXVy7x
 H3+tx4BwumULZ914y/8mXGBloNFvjuMbzCFzb4pw1m+3rDV6lv8snZA5QvwUUVzZzY89
 xc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776665244; x=1777270044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1jIReC1N5ZXw+ZbV8J5bGoAtAcDM/LlsCALqWLhnLk=;
 b=hhrRmk7VF4ViaIUPimEx8XiG+O2wSZDNpmacTy2j0nYugGv7oet0vo9uGzw2Weh7ZP
 s1fR6JmTCoW7T0vsU2aRYCzbOmp68mkM9lJxKhgVprVxXnAI8KNhuWRaEPQh8ohhb49Q
 AdgBdZBCZLpAGgD9GBu5L8ECWlil46oFcjH6p3QlEBE1EHi7AAqbZOHf9MjVC57PCCXn
 yTzssI9byEKiUHLMGrU4cPjOkmSRuxWqOrNBIvz/yuFRnehYisZLdNZow0blMNlhLTCP
 tnvXfwDbD7blZdPAWoCjP71SrKPDiznBW2SILdgtOS8k6P8vxy5l7J8RYQM2wOwM+vaU
 jzNQ==
X-Gm-Message-State: AOJu0YwrgDMSMiqLUEYpmXRc1tfHFihDOF2JWdoa4QEqejzHJVDZjQMO
 b5hAih1QisxJI53oRPPulNwm+pYqjov2aGBqGe0peYthx9CcaBMhsZXC56Pv3CaNHtu7Q+vd8wp
 4DtDJKz6un/xDtojBZOJHYM5PBNEySs/4TAXOWMU2qg==
X-Gm-Gg: AeBDievvcnwJIIR7jy0GNLr3nM725DDtD6XzBunow6O2QzIy6HhPXv5edjv/iIkgIL+
 0cVxtELhAyPACUUFcueHRxIDBAdy9Q7eA6rpzXqhvlUZiGc1wyFCbjFE/yKrP9OXZTorKVQAVnt
 DE6ive/EF4z7hJRZ/rv6K85wm9FATGqO2+CeoVdycvUwRp+zK4ZEJIoEc4jnr87GESceX7vzVM3
 WbrF+qyrorEGhE9Y2d7TgD3EZq42tLTc06oNwYFhvJs0hXwpnLrqURSNN28uDGDwZBnNrG8cIbN
 KCV1OwEtgZvyCaSNA2NCEzTMFUNouqqXCtANCVF979Wn9DCLlTJpPweYZ/75yY/z08wGj9IBMq5
 +xACZaTnE9zZwumycdzoogW9bKbKwGw17CjzKS/gsMIh8A3OYgj6KbLWyJ09dNIAXiz1XDXlJvb
 DJBwWozX4oNemr+kr5N019bYCdTeJmgjNhFKfnRJcjiJwyN31rZKyzcxt1Z7vdpnxuxtgUaoSuO
 Hjw4bDp1xJZtkAKqcrheZLgB4CeN0ncvVLCcCiDzmSRnh1FxPm1HckbyHXUIomLhx/alzCMNbCQ
 k900MMQaDbTy25UVKa0anP7Mm9cCvJrFXgk4Yd5QLP7DpQI0vaL3TjbYZcg3fDYrKQ==
X-Received: by 2002:a05:690e:d4a:b0:651:bd55:6afb with SMTP id
 956f58d0204a3-65310b12945mr9338216d50.57.1776665243795; Sun, 19 Apr 2026
 23:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
 <20260415183250.3031030-7-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260415183250.3031030-7-dario.binacchi@amarulasolutions.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 20 Apr 2026 09:06:46 +0300
X-Gm-Features: AQROBzC5ABRjatijfE-oai3UR5aCeBuWoB_67nVSZXltqibgSP-i-YM1Ccfa6rY
Message-ID: <CAC_iWj+mYfx7pRwm90EXVK5VLL=xoR9BU9sFMAt3wEK1uUNmcg@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] fwu: add helper to get image GUID by type and bank
 index
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Kory Maincent <kory.maincent@bootlin.com>, Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
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

On Wed, 15 Apr 2026 at 21:33, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> Introduce fwu_mdata_get_image_guid() to retrieve a specific image GUID
> from the FWU metadata based on the bank index and image type GUID.
>
> This allows identifying the correct partition in multi-bank (A/B)
> scenarios, ensuring the correct image is targeted depending on the
> current bank.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> ---
>
> Changes in v3:
> - Add kerneldoc comment for fwu_mdata_get_image_guid() above its
>   declaration in fwu.h.
>
> Changes in v2:
> - Add kerneldoc comment for fwu_mdata_get_image_guid().
> - Pass efi_guid_t by pointer for consistency.
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  include/fwu.h         | 11 +++++++++++
>  lib/fwu_updates/fwu.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/include/fwu.h b/include/fwu.h
> index 9cee8fb085cb..68a51fb4296b 100644
> --- a/include/fwu.h
> +++ b/include/fwu.h
> @@ -396,6 +396,17 @@ void fwu_populate_mdata_image_info(struct fwu_data *data);
>   */
>  int fwu_get_mdata_size(uint32_t *mdata_size);
>
> +/**
> + * fwu_mdata_get_image_guid() - Get image GUID for a type and bank
> + * @image_guid: Pointer to be filled with the found image GUID
> + * @image_type_guid: Pointer to the image type GUID to search for
> + * @bank_index: Index of the bank
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int fwu_mdata_get_image_guid(efi_guid_t *image_guid,
> +                            const efi_guid_t *image_type_guid, u32 bank_index);
> +
>  /**
>   * fwu_state_machine_updates() - Update FWU state of the platform
>   * @state: FWU bank state
> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> index 37c613014d18..e5e4907a2d43 100644
> --- a/lib/fwu_updates/fwu.c
> +++ b/lib/fwu_updates/fwu.c
> @@ -243,6 +243,39 @@ int fwu_sync_mdata(struct fwu_mdata *mdata, int part)
>         return 0;
>  }
>
> +/**
> + * fwu_mdata_get_image_guid() - Get image GUID for a type and bank
> + * @image_guid: Pointer to be filled with the found image GUID
> + * @image_type_guid: Pointer to the image type GUID to search for
> + * @bank_index: Index of the bank
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int fwu_mdata_get_image_guid(efi_guid_t *image_guid,
> +                            const efi_guid_t *image_type_guid, u32 bank_index)
> +{
> +       struct fwu_data *data = &g_fwu_data;
> +       struct fwu_image_entry *image;
> +       int i;
> +
> +       if (bank_index >= data->num_banks)
> +               return -EINVAL;
> +
> +       for (i = 0; i < data->num_images; i++) {
> +               image = &data->fwu_images[i];
> +
> +               if (!guidcmp(image_type_guid, &image->image_type_guid)) {
> +                       struct fwu_image_bank_info *bank;
> +
> +                       bank = &image->img_bank_info[bank_index];
> +                       guidcpy(image_guid, &bank->image_guid);
> +                       return 0;
> +               }
> +       }
> +
> +       return -ENOENT;
> +}
> +
>  /**
>   * fwu_mdata_copies_allocate() - Allocate memory for metadata
>   * @mdata_size: Size of the metadata structure
> --
> 2.43.0
>
