Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E9BE63FE8
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 12:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCC988352B;
	Sun,  5 Apr 2026 14:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b9/lddVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BA0683C5E; Sun,  5 Apr 2026 14:04:20 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 404488341A
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 14:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9c3a9fe80fso402054866b.3
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 05:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775390658; cv=none;
 d=google.com; s=arc-20240605;
 b=hnhWSVL3lNb+XFzZfGQmhtPcMOF8TDIGDHd+fgy1RZV2cUOcQge7yQyeASe1VncTg/
 r349McmnWQ/r+TUbTNTd2Yx0cnyyMM01smg/NqLyfmEm+ONSoYBLgn8gLO+xHIPxkMEN
 8LUV/irfvBBPWdrP54dUTKQtmNQ4t0KNgSk/zQ872M+iLvARgkk1Q5WOStNYdcnVE1eD
 5GXJHQILPVt19eYCnMwbV0QRK3ge/2oXHB0dXwI5nmt7QPGuTTWS6qLAno/TnONiIgme
 OwXdg6jHtEgoWBMcGIjsICIeHSp/BguU7a0w1LoTKrYbqbx7UVoYI901UxLFdcLo+gd3
 MjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ki8wwIRQKnCnChNKHLFnZxQTM/nBK5H8mTxOGu/Tv/Y=;
 fh=b1+pp7YovxRd7WNPbw0ucw9PIjcN+WB2u46o+vu8QbQ=;
 b=QTkBxLlvrqI+IoQ69DUkPXkf4E024AQFJqw8HMqFB8nUok+vg2jeXLe/8ozv9yJHjR
 HIxKt1Y1uESgGcz7u39fLL9IRGI3GhT8oARJ/pXx/AQ749N4DEG03YjrUrDivxTZBKMl
 bPvvzlb9Em+5Zcog91aJyEhnwjxAx8TuAhlkyZUKfoqnqkSLQ1cD8SDAYoqUzGMHMOFJ
 oJSYeeQl1eWkM/PH13lgQJfIRAmFAGOUDxt2LKlG5lJRk8YjtDL8S5LqjTpD2J34gVJm
 9VQgeqoEEjwlsCFfi4zQNzSJfV6z4SoIiN0j4rF/t6L3odRorpyW7o9PoUKk9+KJwYAh
 dSHA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775390658; x=1775995458; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ki8wwIRQKnCnChNKHLFnZxQTM/nBK5H8mTxOGu/Tv/Y=;
 b=b9/lddVN7fpJQhtoCekR+rp9TCbzpZuDUdsE5F8pln87nF6IftWisPce5eAU3X2qo/
 AUw6kcFv6/xuIQLo2fh3rkL7rqleSPubKXIQCFqJnh8C+P6P3oHHmGIq9Jk6Kv9PmVsG
 GOX2UjEY9U814RkC8qFScbjzMd8Y24cybzOtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775390658; x=1775995458;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ki8wwIRQKnCnChNKHLFnZxQTM/nBK5H8mTxOGu/Tv/Y=;
 b=eq7UmknL7OEqIyhPnHFePVsXUD4WwKi3S3kBAqKIYfHEvTk7ExgUixPzsBI24rKE7i
 5Xbyq5DHMwh/on/H/Nt6pmIxMgJzYnbacctmpmxymP5NceAUS5FEED3BQXVQH0IUrV3a
 9mGUTMk8ymQRJbTo3kb9FMGxm8cU+PAh5nf5zXYc3P0xC+mdFwcbW2WD9vni0ZVyU/Fj
 gVXjuy6TPdFjhz2yKlJF7cVc7uJAHNngP8KLkxJIqLFElaz6QjNSxv2F69Z+sJ+6+aj/
 IqC1SP3UGEJUGzu7SKpSDmIR3NOrXVvQ5RjWQq4fbpCilp4EiIskK+xhW9ZX6ciqByIc
 7Hkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQAjC1gg7wH2edRQm/SedMQALmX4WtvfN5VKk0S8YzKpFeBEu+PeiOQ3XAzo2HT+nuc1Oe0pM=@lists.denx.de
X-Gm-Message-State: AOJu0YyexVM4Sb8qWVmINSs6flc6Y33ZHIz0qP0DlhZoJli0tWT+OfOh
 BpFV474656rjCJhtyPqLLtLYwJvcriYB2yWPlEv+WMfd/9TLxa/jNlMBuuV36Q8NaUn4cJSCLsG
 l/hDiemzperlPGfQfAI4xyVAvWO1fpFoiEQVlh7AO
X-Gm-Gg: AeBDievx3+rAdigFWoEEVoczdEnXW4iIBMKJ2ahqoVQ2hwjY0o7D5GodT7INafS3NnT
 pMRQ4ZY3OALc/mssUP3JaeQmd8VLiGb3MoHBqfRtTMrYf2EX7pKuLA331pP2LUo6l/wD/s/89RA
 yD24o84HG3R8FyWpTgTvm8TqwId/qTL8bE3RHw4vjwxh7cqpqqXlj+eoTPzFzQrNK8tcXmxKlxp
 kXiHMMNWfw3tC2T6SuzlJBaYwLpa2Nh5GGLJL37paW8uwLm235+BrndQd1ZX2DT7NMKnDbByvMp
 9biutg==
X-Received: by 2002:a17:907:9494:b0:b9c:93f4:d8f4 with SMTP id
 a640c23a62f3a-b9c93f4da60mr288887666b.17.1775390657590; Sun, 05 Apr 2026
 05:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
 <20260403090109.3564638-5-ilias.apalodimas@linaro.org>
In-Reply-To: <20260403090109.3564638-5-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Apr 2026 06:04:05 -0600
X-Gm-Features: AQROBzCPSdnxrvd2CL4P5KjVr99vS-mIuu260fk_5NoWDL6VqCPh4LFGtFZIylg
Message-ID: <CAFLszThg53tcrR7TDsk-de7e-7ZbcLixkij3QQW5m8Fmgy1Pmg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] common: Add an optionto relocate on ram top
To: ilias.apalodimas@linaro.org
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
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

Hi Ilias,

On 2026-04-03T09:01:02, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> common: Add an optionto relocate on ram top
>
> Right now we only relocate u-boot to the top of the first
> memory bank unless the board specific code overwrites it.
> This is problematic when loading big binaries as it
> fragments the contiguous memory space for no apparent reason.
>
> It's worth noting that there are cases where we must not relocate
> above the 4GiB boundary (64bit hardware with 32bit only capable
> DMA). E.g This will break platforms, if the ethernet
> controller cannot DMA above 4 GiB, and once U-Boot does
> get relocated above 4 GiB, the packet buffer which is built
> into the U-Boot binary is also relocated above 4 GiB.
>
> A previous patch moves the bi_dram[] info from bd to gd and make
> the memory bank information available early. So move the
> dram_init_banksize() INITCALL before the relocation address calculation
> and use it to derive the address.
>
> Also add a Kconfig option and allow the common code to relocate U-Boot
> [...]

> diff --git a/Kconfig b/Kconfig
> @@ -491,6 +491,14 @@ config SKIP_RELOCATE_CODE_DATA_OFFSET
> +config RELOC_ADDR_TOP
> +     bool "Relocate to the topmost memory address"
> +     help
> +       When U-Boot relocates, it chooses the end of the first memory bank.

Adding an explicit "depends on EXPERT" would be clearer, even though
the surrounding menu structure implies it. Please can you add a
warning in the help text that this should only be used if all devices
can DMA to high memory?

> diff --git a/common/board_f.c b/common/board_f.c
> @@ -353,8 +357,19 @@ static int setup_ram_config(void)
> +#if CONFIG_IS_ENABLED(RELOC_ADDR_TOP)
> +     for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> +             if (gd->ram_top <= gd->bi_dram[bank].start)
> +                     gd->ram_top = gd->bi_dram[bank].start +
> +                                     gd->bi_dram[bank].size;
> +             total_size += gd->bi_dram[bank].size;
> +     }
> +
> +     gd->ram_size = total_size;
> +#else
> +     gd->ram_top = gd->ram_base + get_effective_memsize();
> +     gd->ram_top = board_get_usable_ram_top(gd->mon_len);
> +#endif

The RELOC_ADDR_TOP path does not call board_get_usable_ram_top()

Some boards override this to keep ram_top below 4 GiB for DMA reasons
(see arch/arm/mach-tegra/board2.c). Bypassing it means those
constraints are silently ignored. Should board_get_usable_ram_top() be
called after the loop?

Regards,
Simon
