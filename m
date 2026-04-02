Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82861D6AAF0
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 16:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A3A983F8F;
	Thu,  2 Apr 2026 18:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QpZgiL6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CFD9840ED; Thu,  2 Apr 2026 18:37:42 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D81883F7D
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 18:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so175762266b.0
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 09:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775147860; cv=none;
 d=google.com; s=arc-20240605;
 b=kEJqVle/qj/lYJTwmTSBkCGrJ+jMD8cr77UWuY7IcB0H4DRWhEnoQkeRbnJ2hnIW2R
 ashFsQTbDe12NjJf4qSS6ktkP/UDN/UqeVTDSmzRnS+I7hYze50+N3SQeJhXeQY0blHe
 hwx4+tHeg86ioK5m28HEYgzz1sSle4bqbmkthwglyzKlXr4Cx/4svJxroB8N4k+KhONK
 YlozkVppHod/llWzwWXceCF6iqjcHku66OQn4FvqCw3MudHAn55FGYYISsqa857G3KfR
 7zX2yEt7VwvmRw/IS3l0tUNwHY19xuJV2l02ClXeoikM+BL42bimUc7zVADO26FuVRo+
 eyvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Q7BIv8uWIJ8pLDBrK5H4keyMVoV5v32vUSjva8w2rDc=;
 fh=8xV1qIKPo9pas0nqHVH0I79/8Oiv0i7iC4KAr5IsCXA=;
 b=Tf+yFr9t+xlhCAUHV1wHQ5g7ISgpIuUBhjAQzuGa9A019rpfRQJUT4RN1yQ5P8Bfjl
 taQ1ZX5VBMwKmENWE4hB6EyU9QBYkQttjrA1XiulPuWlJlFIL+DFkbL10do02++gj+Ov
 f+qEQKTgtOI7EWEWFuJeBnVDdhRiM8QhHaTo4XTcPBAKD4M7vN3wglRqZ32dsWDyn2ZZ
 BhKomIOrVwmDVp4UCPS0vabwHvLl5mTgwCJ9CRC7iu3/FSMCe+3tTRhSadqob+D9+5Be
 T2EH6QQ0NlbI3eD1GnJgR1oQytWKUCEJdRyX4/7ad7qKY15O9jMA27O6DQe7+MDBqKlD
 yTMQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775147860; x=1775752660; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q7BIv8uWIJ8pLDBrK5H4keyMVoV5v32vUSjva8w2rDc=;
 b=QpZgiL6SG9IJdYrNYm+A3TFs7CgV7iIDdC1VXxWCNJGkQeagrx9li4pDtgqRTYOqTb
 gj2sP6YZAptw82FuTHJeDLcwSi7g71KOalfXcOaRh4ql/RVGdbMJ344WebJdvJM1so97
 SeFirMCNJFHbv6wWPu06wACwzgqfukh3UsgcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775147860; x=1775752660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7BIv8uWIJ8pLDBrK5H4keyMVoV5v32vUSjva8w2rDc=;
 b=chgZ7yyHTe/QKp3cISjbqCaPIay17LeKaKsZHNr4bQZevbyJv/ZzcvrSSTxioq+1AT
 3iT1GeiBDXQd0oJ4d5OepT+XgzwOl4D9c061RAe1+/Th8Nm13Gs5nU/b581WySz7EXIY
 6IYRhiDJ8uXaIp8hKsfGTrJPwrKOliGZM44ewX8I8x6OA8BEVaxryTZCoPrdwmAi1j60
 rqakSDU4eZq5AHvNXZ1RY8+YsRyHY0IvdDZt+Ai0gqImHBzT5PBHUJRROsPOtl0KIULx
 pf4aa2eAz3j0q1BYjAeHCpiAAS6iiu+vqTj8W/YYp51hkW/1i8eu1ZlwGCvlO2rtzxOr
 C9hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFs5h1gIJZyQqRzk31pqF1v2N4tjggTO1NQHFK7utfYfCcFpRGmZ17z9fd6ec5PfEyxkBmQ+A=@lists.denx.de
X-Gm-Message-State: AOJu0YxQs3ceI0blsYQTxTr1CQXhqKiJ813ziFBfIHSIzKPktaGr3IIP
 igI38wOydo7iIYvJycpXGVNvLKGSpHMVCcuB/6TCycvtgyJNtkKMmW0wE2i5IpxAqeY3fa2iXJt
 S5378NzJCYl/gyuIGDfUocjgb1co7rb24DocWVd42
X-Gm-Gg: ATEYQzzsnWNISubEA9LqeiA/RlZfnIcBDRrrxC28vHZDeemc0UfB5Q6GxfXoIUezQrz
 RTT7J3MCGgiIgQgzu54XD0RXXjL4MxTp3aRj2Rx4zrJCTRpQmn/UE1iHhzaOxXMt85IBwkoSLfa
 2ogP1YebBF6SsU7M+oPMcnE4FbEUC0rMQv+aZdVo9N7ReFh94JaOjq0xSs2fzJXJSj1Wl99e4Xf
 u+wm2dURp18osieBKJM9dOIbr5QD2AJdNG+NqtpaB+whkCVAPR5Z/aheDxohz8ilyMHnXisttGt
 SQRO8CkXy9YYrMdv
X-Received: by 2002:a17:906:2099:b0:b9c:d04:e05f with SMTP id
 a640c23a62f3a-b9c13b2a8bcmr392455866b.32.1775147859621; Thu, 02 Apr 2026
 09:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775099118.git.daniel@makrotopia.org>
 <6cc0f6ccf692d97dafc073e08195e54b712882b4.1775099118.git.daniel@makrotopia.org>
In-Reply-To: <6cc0f6ccf692d97dafc073e08195e54b712882b4.1775099118.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Apr 2026 10:37:27 -0600
X-Gm-Features: AQROBzDG6uR86I9CNH7fALfAmXOE-k-XMPjxAQkPyTsr6jPaFsIzY9daRnmpTrM
Message-ID: <CAFLszTgmb+6UaF5DW6ZmVnosh2HZKkC2xCbGmQ2gHPb5fLAsJA@mail.gmail.com>
Subject: Re: [2/4] boot: fit: support generating DM verity cmdline parameters
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, 
 Anshul Dalal <anshuld@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>, Aristo Chen <jj251510319013@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Francois Berder <fberder@outlook.fr>, Shiji Yang <yangshiji66@outlook.com>,
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

Hi Daniel,

On 2026-04-02T03:08:27, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: fit: support generating DM verity cmdline parameters
> boot: fit: support generating DM verity cmdline parameters
>
> Add fit_verity_build_cmdline(): when a FILESYSTEM loadable carries a
> dm-verity subnode, construct the dm-mod.create= kernel cmdline parameter
> from the verity metadata (block-size, data-blocks, algo, root-hash,
> salt) and append it to bootargs.
>
> Also add dm-mod.waitfor=/dev/fit0[,/dev/fitN] for each dm-verity device
> so the kernel waits for the underlying FIT block device to appear before
> setting up device-mapper targets. This is needed when the block driver
> probes late, e.g. because it depends on NVMEM calibration data.
>
> The dm-verity target references /dev/fitN where N is the loadable's
> index in the configuration -- matching the order Linux's FIT block
> driver assigns block devices.  hash-start-block is read directly from
> the FIT dm-verity node; mkimage ensures its value equals num-data-blocks
> by invoking veritysetup with --no-superblock.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

> diff --git a/boot/Kconfig b/boot/Kconfig
> @@ -142,6 +142,27 @@ config FIT_CIPHER
> +config FIT_VERITY
> +     ...
> +       and BOOTSTD bootmeths.
> +
> +

Drop extra blank line.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2642,3 +2682,299 @@ out:
> +     if (!data_block_size || data_block_size < 512 ||
> +         !hash_block_size || hash_block_size < 512 ||
> +         !num_data_blocks)
> +             return -EINVAL;

dm-verity requires block sizes to be a power of two (and divisible by
512). The first check `!data_block_size` is redundant given the `<
512` check that follows. Please can you add a power-of-two validation
using is_power_of_2() from <linux/log2.h>? Otherwise the kernel will
likely reject the table at boot time with a confusing error.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2642,3 +2682,299 @@ out:
> +int fit_verity_build_cmdline(const void *fit, int conf_noffset,
> +                          struct bootm_headers *images)
> +{
> +     ...
> +     if (found) {
> +             /* Transfer ownership to the bootm_headers */
> +             images->dm_mod_create = dm_create;
> +             images->dm_mod_waitfor = dm_waitfor;
> +     } else {
> +             free(dm_create);
> +             free(dm_waitfor);
> +     }
> +
> +     return found;

When found > 0, this returns a positive value which could be confused
with an error by callers that only check `< 0`. The call site in
boot_get_loadable() does `if (fit_img_result < 0) return
fit_img_result;` so it works, but I suspect returning 0 for success
and keeping the count internal would be cleaner.  What do you think?

> diff --git a/boot/bootm.c b/boot/bootm.c
> @@ -242,6 +242,7 @@ static int boot_get_kernel(...)
> static int bootm_start(void)
> {
> +     fit_verity_free(&images);
>       memset((void *)&images, 0, sizeof(images));

Just to check: fit_verity_free() is called here before memset(), which
means the pointers must already be valid (or NULL) from a prior boot
attempt. This works because fit_verity_free() checks for NULL
internally, and .bss is zeroed. How about a comment explaining the
ordering?

Regards,
Simon
