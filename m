Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7FCFF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E32318394E;
	Mon,  4 May 2026 14:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oFpmBkfc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED2AB80F0E; Mon,  4 May 2026 14:09:45 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09404845E9
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so632358066b.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777896583; cv=none;
 d=google.com; s=arc-20240605;
 b=bQuaZdqWa8ooE5JwIReu83nlZraDYNyTktcWQV3K4suVbDRLvTBFMz+XuwZ8X4iVKd
 RHY+13MzMrS+YRY7Yjp+KtRMnKt3LwhmWRRKPTgusTs8sr+HZvtTo53LU7ytuqNKx7OK
 VJuuAIuVv5jNEdGq9XzmSAaCQ3HRl+ecUAbkBs++LV98cKfxwrHvDzL1v7B8EwX2bfl5
 EOW++rfKGxesrY9f4cBWR2dHxgwqepR1CTj4PAYDhdfz3FR9p+GH6VZnyTWFbllPDTwW
 5EVLdT18C4s8InyGDnC6UQiTbF1jTNzbd9SFS5wZJk8m2BGnwrWghaY4kODHOZ3SzZ/s
 Jfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=35an2fnnMH/jLcx17VvYZ/o1TM4X1ea9D1kzwXU7F48=;
 fh=PvMd4X2mdXT08JWfisjv9stH8Lx5t+gM5zKif/Je664=;
 b=FNhB5BU9g813P1fCCk1DCuysseb3qldLcJoeIqiwApgfF1iLU82/470Pl3j2vi4lM+
 vEOIfIPKXZ11H3mnCLU2/3zm/1w8Vk2rET92tnoK+/WFO5aXzFAOX+/FnrBKblbkx/MS
 mT8106NIgUW7QWpnUSU555rOg0nApGeY23pPkyODnfJECVNW3LhjK1GU0p+mQxMwTUfg
 816WlpP1uUFyF60OCUH+Bj8UQ6kdAL/z/3lqQxWe5xdIDtDVeOwHE/WFZNz4FtZuTXEP
 qcpYSP2zyW0czt8hXfBotfsGZIAiivbHP28s17hjgotJ66vDaiyoFgCC25rvvJV8YkZ9
 ulgA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777896583; x=1778501383; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=35an2fnnMH/jLcx17VvYZ/o1TM4X1ea9D1kzwXU7F48=;
 b=oFpmBkfcRnxmnC6Ef9yw3mgtrK78fDPmXNiGi7Hn7Afef8cxIEokhvJmmXdF2cGU9w
 DlBYOlCsxUrZ0qdwJE9eHxfg7jI53VLHy1x/8tC6FS3A6Q7rfUEIlpS4DhVH/6Arqq12
 byV30nGa2aIIqSkWin6jPXMo54x2a5+FHjGaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777896583; x=1778501383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=35an2fnnMH/jLcx17VvYZ/o1TM4X1ea9D1kzwXU7F48=;
 b=KVrta+Xl2HqhNmmnF8gHA4AvqZidajd5FK6o7wz7PPvp5V4d7RRUV7gAXl8yKdp16z
 l1DY/VkeRt13T4EsRbYTtCd3K5SLf2qTY0jy4m4S1aYuRZ1bFaLuHV9SYtxrwbhpkDNJ
 48QDSXOG9ZZZ70+MotUUnrFfl+4mCi+nUN4/fyXDvzA3GUt/7QY0+bj00oYw2ZRUOF6F
 UxYNsCGpdz4jO2zJdh3pqnnMG7t7ryuvdoaGqQKyuV+dEI9F1INZ/uIo6EyAYTDFrmau
 4t+bLZ3LpVoDMx+1wLJ5gkoeF/Lm1kn20YfLkNh4xvwRSJTR8StKqNyjzr6FfVirHMkB
 yl9w==
X-Gm-Message-State: AOJu0YwMf8GCgj7SYLU5G2Zu85o4jEC/HHKmDbVQVs67oS2qAP2F7SGD
 MtbKwODf70XdveqCQnERuwzO5CEGZMREveD7gQ3g++EiZz4NQsQy8eiHotiRpHdt5jInD4JHh9r
 rLQR+wTmaUVffF6bCWeVE+EvlogDof6sh7KvQmAxY
X-Gm-Gg: AeBDies854UtgXLLFkk08SEgZ1u7dyqfK/HMkePJJFrSljWrW+QwZ9igJdJ2wAABpdf
 X/Jwam3sfKjbD8IYk0S7+JCLQ0reJm0acF4VF20g/MyClEk5VEisZcOGluw9JLvHcZxcn56da/l
 I7qzVp+rYFDIlvVN0019ZQM4ViAbshdW3y1gzY3uu0RiEWbKED6jE99tJdisKMN0Mfih03oeXdT
 jKf6DEKV6VXnV50e3TrjNR5tatKp8+nhCnWhLXwiRzS6mQK/O9XpGKgIHvO25gEyhFB92DVSGLl
 dFO25GXaV0PGudQw
X-Received: by 2002:a17:907:742:b0:bad:ad5:300a with SMTP id
 a640c23a62f3a-bbffc689a52mr498577466b.26.1777896583316; Mon, 04 May 2026
 05:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
 <20260428-spl_fit_full-v1-5-dde63beeaab1@valla.it>
In-Reply-To: <20260428-spl_fit_full-v1-5-dde63beeaab1@valla.it>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:09:31 -0600
X-Gm-Features: AVHnY4IvZ9kIPa2RetVPTixYHZjmKdzIlGz0lj7cyKbutXOhxYtU0a51wyGOyNY
Message-ID: <CAFLszTh2CFomDvn4u6HAo_2mT+2GyvqHfo_y8-agOH-KoCvjPg@mail.gmail.com>
Subject: Re: [PATCH 5/5] spl: fit: add ramdisk load
To: francesco@valla.it
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, 
 Frank Wunderlich <frank-w@public-files.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Anshul Dalal <anshuld@ti.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Dhruva Gole <d-gole@ti.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Michael Walle <mwalle@kernel.org>, Marek Vasut <marek.vasut@mailbox.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 David Lechner <dlechner@baylibre.com>
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

Hi Francesco,

On 2026-04-28T20:24:41, Francesco Valla <francesco@valla.it> wrote:
> spl: fit: add ramdisk load
>
> Add ramdisk loading logic to the 'full' SPL FIT loader, as well as the
> corresponding FDT fixup. This is required for proper support of falcon
> boot using FIT images, but is useless for a U-Boot launch, so make it
> depend on SPL_OS_BOOT.
>
> Signed-off-by: Francesco Valla <francesco@valla.it>
>
> common/spl/spl.c     | 17 ++++++++++++++---
>  common/spl/spl_fit.c | 18 ++++++++++++++++--
>  include/spl.h        | 20 ++++++++++++++++++++
>  3 files changed, 50 insertions(+), 5 deletions(-)

> diff --git a/common/spl/spl.c b/common/spl/spl.c
> @@ -172,6 +172,14 @@ void spl_fixup_fdt(void *fdt_blob)
>                       return;
>               }
>       }
> +
> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT)
> +     err = fdt_initrd(fdt_blob, initrd_start, initrd_end);
> +     if (err) {
> +             printf(PHASE_PROMPT "fdt_initrd err - %d\n", err);
> +             return;
> +     }
> +#endif
>  #endif
>  }

Please us 'if (IS_ENABLED(CONFIG_SPL_OS_BOOT))' - we try to avoid #if
in C files for better build-coverage.

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -1011,6 +1011,20 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
>               }
>       }
>
> +     if (spl_image->os != IH_OS_U_BOOT) {
> +#ifdef CONFIG_SPL_FIT_SIGNATURE
> +             images.verify = 1;
> +#endif
> +             ret = fit_image_load(&images, virt_to_phys((void *)header), NULL,
> +                                  &fit_uname_config, IH_ARCH_DEFAULT,
> +                                  IH_TYPE_RAMDISK, -1, FIT_LOAD_OPTIONAL,
> +                                  &rd_data, &rd_len);
> +             if (ret >= 0) {
> +                     spl_image->ramdisk_addr = rd_data;
> +                     spl_image->ramdisk_size = rd_len;
> +             }
> +     }
> +

There is no SPL_OS_BOOT guard here, so the ramdisk lookup is attempted
for any non-U-Boot OS (ATF, OP-TEE, OpenSBI, Linux). Is that
intentional? With FIT_LOAD_OPTIONAL it is harmless when no ramdisk
node exists, but gating on CONFIG_IS_ENABLED(OS_BOOT) would match the
consumer side in spl_fixup_fdt()

> diff --git a/include/spl.h b/include/spl.h
> @@ -288,6 +288,8 @@ struct spl_image_info {
>       ulong entry_point;
>  #if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
>       void *fdt_addr;
> +     ulong ramdisk_addr;
> +     ulong ramdisk_size;
>  #endif

Only the LOAD_FIT_FULL path populates these (spl_load_simple_fit()
does not load a ramdisk), so they could be gated on LOAD_FIT_FULL
only. Please also add a kernel-doc comment to the new
spl_image_ramdisk_start()/spl_image_ramdisk_end() helpers describing
the units and what they return when the FIT loader is not enabled -
'end' in particular is ambiguous (inclusive vs exclusive), so please
state that it is the exclusive end address expected by fdt_initrd().

Regards,
Simon
