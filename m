Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C254D1489A
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 04:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74D5983A26;
	Thu,  8 Jan 2026 05:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P0E4VkpP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D8F683B21; Thu,  8 Jan 2026 05:07:41 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D121D83A1E
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 05:07:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6503b561daeso4113559a12.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 20:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767845258; x=1768450058; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H81lh8wRXY6GYG8LlvQUbOgRfeyiotEtfLZGXWoMFvE=;
 b=P0E4VkpPGECSokv49HY3UEObt7mP4ixsWWxYzYdrhY9d/WYQ4q7z+1RASjlRCRaZjH
 hgxSnikXjQXsWlwH7hvweKjsf857WtV0M8ca0CpJKC0FHKjON16YbwIqMws/oZ4CZiEn
 2ForXPpSXIpGkglUeeaehH9XA8fnvydLUAzjBxI2uLfBBgmEZXqw+F/4CX+CEFifhZzV
 k1PxCc5Rf1KHJUtAjr97NeRHh4GgzrPrhRxzEor06a6/d4uLyjRhIHc3u6uHEGidZjtz
 09kKuPDi2vtAYSusfsjaiWPveH+ty5BVNZdoeE1DXpG4kKQ0vJz0lI3l16Mf+RNyzNVj
 VL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767845258; x=1768450058;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H81lh8wRXY6GYG8LlvQUbOgRfeyiotEtfLZGXWoMFvE=;
 b=MvEbPn0ICD41uCV3GEw+kwXQovRV7+KBbo9Vaw4/Qcvy8/7LQgwMqNNMXXMH9prLbH
 XsSKPoZA2XJp+dqsOv9/z9dbXXHIDAULkAaL78X7vSCxmM/SaUZ/+gCxXeUt/K3Njft1
 N52vWIUogmIGgKvQWK+6ZGNgP0c0vgP03DthK88h/L+NfZ5QEzPlp/OK+hS77kqxBOmr
 hSocU0ioSwACPduNlVwtTNL4EFW5ttqs7rNg4KGINuGJLKBZPTawuD0T8ORGCCUZfIhQ
 155+5KPDaHsjpkZF+q7a8tmDiHp7Z0VUBAZR8Yn4qULi8enx4lUv9Bz3Ckpl4E1ZyH/q
 0hZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8LuRswnsvR3rd8FlRgK3+ntR5PlCzT1XKvemM91fjTad6zVUmJEhPcACB2LaOFqFNdFDiO0c=@lists.denx.de
X-Gm-Message-State: AOJu0YwLDjTbHMEggWgtpSWVXFpKuKPBGrnU5jowbLCHokTFsoLeG7YC
 HWOCHirTw6xylhJcuuOOBy0lg8R+NFaEyW1YQjjXCxMYwLS243X7YxpI9CH3ftOGswRxmzDwN8Z
 rTJaxURwaY7nVXGzLPAUoixSZ44cOVKnaZycPWg0XbitN
X-Gm-Gg: AY/fxX6tV/NvTasdg2buEr7kIUaCg9RlknkSfJI1TwtV1ImwdeRjpCV3xC7Zoy3A0RT
 SCgtiFiungDT2E1Cal2jxaetoOSe+khtBno+9qtOkLFdjzDz5zCnqc/lycmHGBfczXpzyJJFvTT
 WiBAfU+gfo8QPR9/9A8Qv0SySaqwfrIftCAkF5h7ZwLwFURb90WeKoRsCN33pWcq3yPppvgfvPO
 f1Ayn8M9xZL2p0DTI8OYhuCoO9j2p4Od/e9hl7LCO/m3gNeqKt4exLT0DVVUOOm+HrYXY3RuODP
 ZGrdHwTlmKiLhPPum53cXVI2Nv/FhRPBfcMT5Our6dDXxU/fAa8tCBFiCfAhq42fKDrowIjw9Hx
 BCD5Wqm3ih0yItD+OA8lKRyMdO37mJIhVlpMf
X-Google-Smtp-Source: AGHT+IF3Qj5gCdw/p4Jimqv6A8SkYT4AubjzYXFDde7hDN5csbBJ2nIuTwdAd+ZabYT/18XR5iMfE2gUFYUtuf2TX5U=
X-Received: by 2002:a05:6402:1e90:b0:64b:bb79:96bb with SMTP id
 4fb4d7f45d1cf-65097e6c1c6mr3874407a12.24.1767845258015; Wed, 07 Jan 2026
 20:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20260106223409.748335-1-sean.anderson@linux.dev>
In-Reply-To: <20260106223409.748335-1-sean.anderson@linux.dev>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 8 Jan 2026 04:07:25 +0000
X-Gm-Features: AQt7F2ruDPJ9o5hZW3uPq3af383VBsQchai50ge4zpVC3alCmcKBZsooQbHBoxo
Message-ID: <CALeDE9NR8TZw1Vpgn4c0if2z1geXhB1dU_VLi8dOckiZDZZNoA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add power sequencing driver for PCI slots
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi Sean,

> Extend the PCI bridge driver to enable resources associated with PCI
> slots like clocks, power rails, and resets. This is modeled off of the
> PCI power control subsystem in Linux. The traditional compatible for PCI
> slots in U-Boot is pci-bridge, but Linux uses the more-systematic
> pciclass,0604 so add that as an option.

Not sure if you're aware but upstream is doing a big rework of the
pwctrl stuff[1], I'm not sure if this would need to be adjusted to
take any of those changes into account but might be worth considering
reviewing the issues being addressed by that rework too.

Peter

[1] https://lore.kernel.org/linux-pci/20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com/T/#t

> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>
>  drivers/pci/Kconfig      |  8 ++++++
>  drivers/pci/pci-uclass.c | 55 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
>
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index ea9868425d0..efac18b33f6 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -100,6 +100,14 @@ config PCI_ENHANCED_ALLOCATION
>           Enable support for Enhanced Allocation which can be used by supported
>           devices in place of traditional BARS for allocation of resources.
>
> +config PCI_PWRCTRL_SLOT
> +       bool "PCI slot power control"
> +       help
> +         This is a generic driver that controls the power state of different
> +         PCI slots. The clocks and resets for the PCI slots are expected to be
> +         defined in the devicetree node of the PCI bridge. Say N if your PCI
> +         busses don't have software-controlled clocks or power rails.
> +
>  config PCI_ARID
>          bool "Enable Alternate Routing-ID support for PCI"
>          help
> diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
> index c370f8c6400..c5b1ddec45a 100644
> --- a/drivers/pci/pci-uclass.c
> +++ b/drivers/pci/pci-uclass.c
> @@ -6,6 +6,7 @@
>
>  #define LOG_CATEGORY UCLASS_PCI
>
> +#include <clk.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <init.h>
> @@ -14,6 +15,7 @@
>  #include <pci.h>
>  #include <spl.h>
>  #include <asm/global_data.h>
> +#include <asm/gpio.h>
>  #include <asm/io.h>
>  #include <dm/device-internal.h>
>  #include <dm/lists.h>
> @@ -1893,13 +1895,66 @@ static const struct dm_pci_ops pci_bridge_ops = {
>
>  static const struct udevice_id pci_bridge_ids[] = {
>         { .compatible = "pci-bridge" },
> +       { .compatible = "pciclass,0604" },
>         { }
>  };
>
> +static int __maybe_unused pci_bridge_probe(struct udevice *dev)
> +{
> +       struct clk clk;
> +       struct gpio_desc perst;
> +
> +       if (!clk_get_by_index(dev, 0, &clk)) {
> +               int ret = clk_enable(&clk);
> +
> +               if (ret)
> +                       return log_msg_ret("clk", ret);
> +
> +               /* Delay for T_PERST-CLK (100 us for all slot types) */
> +               udelay(100);
> +       }
> +
> +       if (!gpio_request_by_name(dev, "reset-gpios", 0, &perst, 0)) {
> +               unsigned long delay = 0;
> +               int ret;
> +
> +               /*
> +                * If PERST is inactive, the following call to dm_gpio_clrset_flags
> +                * will be the first time we assert it and we will need to
> +                * delay for T_PERST.
> +                */
> +               if (dm_gpio_get_value(&perst) != 1)
> +                       delay = 100;
> +
> +               ret = dm_gpio_clrset_flags(&perst, GPIOD_MASK_DIR,
> +                                          GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> +               if (ret)
> +                       return log_msg_ret("set", ret);
> +               mdelay(delay);
> +
> +               ret = dm_gpio_set_value(&perst, 0);
> +               if (ret)
> +                       return log_msg_ret("clr", ret);
> +
> +               /*
> +                * PCIe section 6.6.1:
> +                * > ... software must wait a minimum of 100 ms before sending a
> +                * > Configuration Request to the device immediately below that
> +                * > Port.
> +                */
> +               mdelay(100);
> +       }
> +
> +       return 0;
> +}
> +
>  U_BOOT_DRIVER(pci_bridge_drv) = {
>         .name           = "pci_bridge_drv",
>         .id             = UCLASS_PCI,
>         .of_match       = pci_bridge_ids,
> +#if CONFIG_IS_ENABLED(PCI_PWRCTRL_SLOT)
> +       .probe          = pci_bridge_probe,
> +#endif
>         .ops            = &pci_bridge_ops,
>  };
>
> --
> 2.35.1.1320.gc452695387.dirty
>
> base-commit: 38ace442b630c5ddf049af83e8db229c012ed355
> branch: pci_pwrseq
