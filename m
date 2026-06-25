Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E584CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 10:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C902B847C8;
	Thu, 25 Jun 2026 12:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JiwKVmj4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC8584954; Thu, 25 Jun 2026 12:59:11 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB76B8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 12:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c0d6c75c58cso33508866b.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 03:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782385148; cv=none;
 d=google.com; s=arc-20260327;
 b=JJ4KboVNUn0BIV90fCmPEQRlFjz/2jxlkNDbQHwy6ar8G4VU0UgXKfF1nM7rQdxB8G
 MblgwS+u2OtB/IZNhAFsIfJ7J6KrIdDCl0wtF2kKkb2AHDC8vbWIf3HrJWo3S6nOkh+U
 i4RZfObc1702bAqZMQQ38iYsh9DGIxP1aKFovWzClvj5Yqnaiyt8GNex3dHqeBJUqzS5
 BQa7ieMf4RMVsAqm/0cn8yif27YDXQuVlUn145NYTT4Rsr4hl3EfvP/5i/WK3upiv6G8
 gegyi+/RtAVvkvRogkVezaf0DpoMpWt61NmjXcrFLtpS32cQJG8QrhGTQ3ecv50af7Nj
 ADTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5SXAbI567M9ai/vSwBBq8hYCT9W7X2aQ6VWikbgyE54=;
 fh=EwJU1mVuO3sY+j+e45zVUlabzQ1yFmJAhesnaad0Pbo=;
 b=F8XmfppoM8XEgzKkh+DmNrHsVMvFD3SBp8cyt/TIHqxQA7DleH7oahByGKd4Zl9Z2H
 0cwtyq0cUSkdPT6pA+LADlvVx8LCQOrZ9JX5eQCn3JfsgcTOli4DoQr2wcg0Jq+0qzS0
 opNdJrGcuED64VMS61ClDQusZYCIlsqerDiU82IR1R7L9ofZiFtTMfP2sHW2+cfT/Mlk
 dnZEvTBk/uZ6vlo3GUzxA91BuNfPezDzVJzOudccrJjJWwf/SgQshP36kFgULDzg3Tyi
 UG2H/jAJGfwi2xGF4x0dWSbl1L55F2lVK65Y4So/jWbQ2Z43coejv2hHvR1D3zVPHMH/
 +p4Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782385148; x=1782989948; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5SXAbI567M9ai/vSwBBq8hYCT9W7X2aQ6VWikbgyE54=;
 b=JiwKVmj48HIW0l6x+YjPl/5bODioVyGrU2NXkvcjuDS2qTLpH6IGdHSqzfnbBOMX0q
 ALxroPcZDe7qj73rGkphJJsq+BChJ11/uwuXpoKGYnxZMemL8a3DTpqWGiJ4xxeYmtYW
 M7lN5kSLkAeSnfTRsD70cIU+366PCDBu0EAXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782385148; x=1782989948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5SXAbI567M9ai/vSwBBq8hYCT9W7X2aQ6VWikbgyE54=;
 b=gqE+Dd5jtXgiHbIYTaJd+QAhRO+4zrH99M2XaGugx+plNKsir7Hedljo9ug9T/1bq+
 20xOvbLl6WWYF0N9Gwu7NMQ9mCQqCeCkHFC0WflQsJ5EewT2/Hf9XGo+nF3JRS5iVWYL
 JThOcr8tHu40g8Oxe9ZKLKdcWOxnalqQn1IPoIEBDB6A1vWKpDNxprzzIDKF8pw22mUC
 2Hf0narwyS4g+oITo15ePIuSc2C9GTaBZnrq2gBpjcsMZ/p5Hu+H0zVDDefQg4ZCy6VQ
 3Iq7Lc9z61ido3PcXhtn4QLuqXyvneyzyG7kI2350h2ndzvHHl+CnGdwlM8EdUcpEKMl
 IQAQ==
X-Gm-Message-State: AOJu0Yzqe/8fSX8aNPfKXUGRTVgVjFxmcD+KFfC67TDWyeRzNC54BIIZ
 /ok+PqDim0t5QARg4AKZxhZDLpUVQZjLSs61aezTtZ6b5ClM19TQR7/mk4/HqYecojgAMiIQo4B
 n8XXFRVJ00k7d5inZBPR+RY3nKWFQ7ZczzOEO5vcq
X-Gm-Gg: AfdE7cns0+z/tKW69+uEkJWEVeyS0op1k7VhGUKHelYhTWcuKdUMqsjGYmrfDD61liH
 RXRDSVAi2nzYSgBn3FsKy1z27DrYLiCOODClMXe+x0nLOViyA1A3d9JfOEX+ld2FPLy+rI+tZa/
 BaGN0Y9Tl5SBFb0blNpciTeaOYiUu+/qXspFXCYjlv6cvb5a0yipFQuBM2re6OzCUdUPMkr41Ey
 5LMm0Wn/5zNIe4P/JoaVDLGm8ipe9ZZiPEfh/ksDJrmNPeUivkfHJC3a29xgq208Cu98kXbgQ==
X-Received: by 2002:a17:907:868b:b0:bd7:f75a:817c with SMTP id
 a640c23a62f3a-c1205deeee3mr144564266b.17.1782385148122; Thu, 25 Jun 2026
 03:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260619-riscv-full-fit-image-support-v1-0-c6477cf4f410@maquefel.me>
 <20260619-riscv-full-fit-image-support-v1-2-c6477cf4f410@maquefel.me>
In-Reply-To: <20260619-riscv-full-fit-image-support-v1-2-c6477cf4f410@maquefel.me>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 11:58:55 +0100
X-Gm-Features: AVVi8CeHyupajCzEQsIK9aifeDgSQKT19F44TFKwaaaf4u76yc1Z03q8Rlb9Tdk
Message-ID: <CAFLszTgi=hWWoEZVx9iKprQ6xkMb=8F115m-hW=bcqR2sJGBZQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] spl: opensbi: fix OS image address retrieval from
 FIT
To: nikita.shubin@maquefel.me
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <ravi@prevas.dk>, Anshul Dalal <anshuld@ti.com>,
 Michael Walle <mwalle@kernel.org>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Dhruva Gole <d-gole@ti.com>, Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
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

Hi Nikita,

On 2026-06-19T12:52:56, Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> spl: opensbi: fix OS image address retrieval from FIT
>
> The current implementation of spl_invoke_opensbi() attempts to locate
> the next-stage OS (U-Boot proper or Linux) by parsing the FDT blob
> pointed to by spl_image->fdt_addr. This FDT, however, is the one that
> will be passed to the OS (e.g. a kernel device tree), not the FIT image
> itself. As a result, when a FIT image containing multiple components
> (firmware, loadables, fdt) is loaded, U-Boot SPL cannot find the OS node
> because it searches in the wrong FDT.
>
> Fix this by storing the load addresses of U-Boot and Linux in
> spl_image_info during the loadables phase (spl_load_fit_image()).
> In spl_invoke_opensbi(), use these stored addresses if they are
> non-zero, and fall back to parsing the FDT only if no address is stored,
> maintaining backward compatibility.
>
> This ensures that the correct entry point is passed to OpenSBI,
> allowing proper boot flow with FIT images.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
> common/spl/spl_fit.c     |  8 ++++++++
>  common/spl/spl_opensbi.c | 33 +++++++++++++++++++--------------
>  include/spl.h            |  8 ++++++++
>  3 files changed, 35 insertions(+), 14 deletions(-)

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -1020,6 +1020,14 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
>                                    &img_data, &img_len);
>               if (ret < 0)
>                       return ret;
> +
> +#if CONFIG_IS_ENABLED(OPENSBI)
> +             if (fit_image_check_os((const void *)header, ret, IH_OS_LINUX))
> +                     spl_image->kernel_addr = img_data;
> +
> +             if (fit_image_check_os((const void *)header, ret, IH_OS_U_BOOT))
> +                     spl_image->uboot_addr = img_data;
> +#endif
>       }

I don't like this approach. The real reason spl_invoke_opensbi() fails
in the LOAD_FIT_FULL path is that nothing populates the /fit-images
node in the outgoing FDT - the simple FIT loader does this via
spl_fit_record_loadable() / fdt_record_loadable(), and spl_opensbi.c
then walks it.

I think it would be better to fix it that way: call
fdt_record_loadable() for each loadable (and for the firmware/fdt) so
the OS DT carries /fit-images just like in the simple-FIT case. Then
spl_invoke_opensbi() needs no changes, ATF gets the same fix for free,
and we avoid carving out RISC-V/OpenSBI-specific fields in struct
spl_image_info...I wonder if you are deliberately wanting the
simple-FIT case to be different? If so can you please explain why?

If you do want to cache the addresses on spl_image_info, drop the
OPENSBI-specific naming and guards - the loadables loop has no
business knowing about OpenSBI, and the fields should be filled in
both spl_load_simple_fit() and spl_load_fit_image() for consistency.

> diff --git a/include/spl.h b/include/spl.h
> @@ -288,6 +292,10 @@ struct spl_image_info {
>       ulong entry_point;
>  #if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
>       void *fdt_addr;
> +#if CONFIG_IS_ENABLED(OPENSBI)
> +     ulong uboot_addr;
> +     ulong kernel_addr;
> +#endif
>  #endif

Nesting OPENSBI inside LOAD_FIT is fragile - if anyone enables
SPL_OPENSBI without SPL_LOAD_FIT these fields silently vanish while
spl_opensbi.c still references them. At minimum the guards should
match spl_opensbi.c.

Also, uboot_addr here is the load address of the loadable, but the
existing spl_invoke_opensbi() prefers the entry point
(fit_image_get_entry()), falling back to the load address. Storing
only the load address is a behavioural change for images that set an
explicit entry property - please mention this in the commit message,
or store entry_point instead.

> diff --git a/common/spl/spl_opensbi.c b/common/spl/spl_opensbi.c
> @@ -81,22 +81,27 @@ void __noreturn spl_invoke_opensbi(struct spl_image_info *spl_image)
> -     if (CONFIG_IS_ENABLED(LOAD_FIT_OPENSBI_OS_BOOT))
> +     if (CONFIG_IS_ENABLED(LOAD_FIT_OPENSBI_OS_BOOT)) {
>               os_type = IH_OS_LINUX;
> -     else
> +             os_entry = spl_image->kernel_addr;
> +     } else {
>               os_type = IH_OS_U_BOOT;
> -
> -     ret = spl_opensbi_find_os_node(spl_image->fdt_addr, &os_node, os_type);
> -     if (ret) {
> -             pr_err("Can't find %s node for opensbi, %d\n",
> -                    genimg_get_os_name(os_type), ret);
> -             hang();
> +             os_entry = spl_image->uboot_addr;
>       }

Using 0 as a sentinel for "no cached address" is dodgy - a load
address of 0 is unusual but not impossible, and silently falling
through to FDT parsing is hard to debug. A separate bool would be
cleaner, or better, record loadables into the FDT as suggested above.

Regards,
Simon
