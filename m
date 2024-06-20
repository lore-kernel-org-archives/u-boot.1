Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E2DC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 13:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFCD288543;
	Thu, 20 Jun 2024 15:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nYoRbovM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A695C88543; Thu, 20 Jun 2024 15:59:06 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE1C08854B
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 15:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a6f8ebbd268so338866166b.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718891937; x=1719496737; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8vZpB7Xa0+4sYqr37ZVc3qBwTh6XfYB461JZux+DB+0=;
 b=nYoRbovMktkhbNjI8BxGNT2pDERU+ZvArl2eMi/piufC7wY3lMoc2J8YY1erLQXyvG
 1EbRx/O3BCzyPD+HYXkwjN+9T+amaC4smZiXpL7LhUg/jaCzwfzXsdTWYJpx1QUEMMMI
 y3CdahBGe5nE5FwNuPN7rgN+YrPdQZWirkg6DC+8/l/lft6oLjauMp21IaX56eqPegvO
 FNykpgRCy+DssbspMg7isHVhLYRmW6PCanufF7fxB4+S/9iN+h2tk3YZN9yFwOjS1Xv6
 77Nbxt+dDcEaJySRPaOtoNBCDscYh43ukLpfPXT71Acnc0cG207bqOF5I/Nyu7tI+nhN
 YXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718891937; x=1719496737;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8vZpB7Xa0+4sYqr37ZVc3qBwTh6XfYB461JZux+DB+0=;
 b=LESheQiklTVt4hV7WSt1wkXPb/cSMkOdxPUNo1IDVJxZAZZO7oJwecwkg7m65yNnaF
 hdbK7AHtvtECXpEwx3bisJuqv11akSmPkeyrgV+zRFlQcZN1IBVWt47AlIbzrjHkfZRk
 IZRWKl1KRldO93Neter81ueAo8NU1VizrnfC47FbMMP31bSuVgBdKAMwyaZ5A4R9FNgC
 B0YqMyrvPONN+ApvNZOcqmAt/3/VYnia+8h09qWSW1aK9PFYOf+QUXFZoNYVGzovwdv4
 72+qU0gE5KMCAL0RNd8jtxvGh6z3YZhvkIsmUd1J9uwar/Bj+eyBdKs7oKwTR3Xx8IMR
 aeEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNW88NqbIqIzbaN0mKZrWlHLfcj22/IfdybPJjb0mLULk5a2vn37ZR0tunNWsaIkrShg9+KtkScAjeNDqziEVci1ENIQ==
X-Gm-Message-State: AOJu0YwMHae4bbfZB6GRux09d7kznlsYncJmmmIwqGaNOrjWbuJEgCYT
 8+e6Y/Diby1yT1MQvqO+MziVnLW2AOiEd8RZa2nVvSqo/uxLRte+84IiibAzVe8=
X-Google-Smtp-Source: AGHT+IG4msm1sRnLSdRtqYqZc18RH+hMDvyRPahfmLMzYNiaSEkpFxVL/7c5CndPXk0bOUJcrW1afA==
X-Received: by 2002:a17:906:1348:b0:a6f:b352:a74b with SMTP id
 a640c23a62f3a-a6fb352a781mr287217566b.38.1718891937066; 
 Thu, 20 Jun 2024 06:58:57 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::ebdd? ([2a02:8109:aa0d:be00::ebdd])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56fa67ecsm760914866b.215.2024.06.20.06.58.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 06:58:56 -0700 (PDT)
Message-ID: <7c12b0ac-5785-4199-9faf-5661b8809137@linaro.org>
Date: Thu, 20 Jun 2024 15:58:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] Add fdt_kaslrseed function to add kaslr-seed to
 chosen node
To: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>, Andy Yan <andy.yan@rock-chips.com>,
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240618210609.1744727-1-tharvey@gateworks.com>
 <20240618210609.1744727-2-tharvey@gateworks.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240618210609.1744727-2-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Tim,

On 18/06/2024 23:06, Tim Harvey wrote:
> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> randomize the virtual address at which the kernel image is loaded, it
> expects entropy to be provided by the bootloader by populating
> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
> 
> Add a fdt_kaslrseed function to accommodate this allowing an existing
> node to be overwritten if present. For now use the first rng device
> but it would be good to enhance this in the future to allow some sort
> of selection or policy in choosing the rng device used.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Andy Yan <andy.yan@rock-chips.com>
> Cc: Akash Gajjar <gajjar04akash@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Devarsh Thakkar <devarsht@ti.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Chris Morgan <macromorgan@hotmail.com>
> ---
> v6:
>   - collected tags
> v5:
>   - move function to boot/fdt_support.c
>   - remove ability to select rng index and note in the commit log
>     something like this as a future enhancement.
>   - fixed typo in commit message s/it's/its/
>   - use cmd_process_error per Michal's suggestion
> v4:
>   - add missing /n to notice in kaslrseed cmd
>   - combine ints in declaration
>   - remove unused vars from board/xilinx/common/board.c ft_board_setup
> v3:
>   - skip if CONFIG_MEASURED_BOOT
>   - fix skip for CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT
>   - pass in rng index and bool to specify overwrite
>   - remove duplicate error strings printed outside of fdt_kaslrseed
>   - added note to commit log about how EFI STUB weeds out kalsr-seed
> v2:
>   - fix typo in commit msg
>   - use stack for seed to avoid unecessary malloc/free
>   - move to a library function and deduplicate code by using it
>     elsewhere
> ---
>   boot/fdt_support.c    | 44 +++++++++++++++++++++++++++++++++++++++++++
>   include/fdt_support.h | 10 ++++++++++
>   2 files changed, 54 insertions(+)
> 
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 2bd80a9dfb18..b1b2679dea0c 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -7,12 +7,15 @@
>    */
>   
>   #include <common.h>
> +#include <dm.h>
>   #include <abuf.h>
>   #include <env.h>
>   #include <log.h>
>   #include <mapmem.h>
>   #include <net.h>
> +#include <rng.h>
>   #include <stdio_dev.h>
> +#include <dm/device_compat.h>
>   #include <dm/ofnode.h>
>   #include <linux/ctype.h>
>   #include <linux/types.h>
> @@ -274,6 +277,47 @@ int fdt_initrd(void *fdt, ulong initrd_start, ulong initrd_end)
>   	return 0;
>   }
>   
> +int fdt_kaslrseed(void *fdt, bool overwrite)
> +{
> +	int len, err, nodeoffset;
> +	struct udevice *dev;
> +	const u64 *orig;
> +	u64 data = 0;
> +
> +	err = fdt_check_header(fdt);
> +	if (err < 0)
> +		return err;

All the paths that call fdt_kaslrseed() call fdt_check_header() 
beforehand, I think it's safe to drop this.
> +
> +	/* find or create "/chosen" node. */
> +	nodeoffset = fdt_find_or_add_subnode(fdt, 0, "chosen");
> +	if (nodeoffset < 0)
> +		return nodeoffset;

Arguably, this shouldn't be the responsibility of this function, maybe 
it would be better to error our here?
> +
> +	/* return without error if we are not overwriting and existing non-zero node */
> +	orig = fdt_getprop(fdt, nodeoffset, "kaslr-seed", &len);
> +	if (orig && len == sizeof(*orig))
> +		data = fdt64_to_cpu(*orig);
> +	if (data && !overwrite) {
> +		debug("not overwriting existing kaslr-seed\n");
> +		return 0;
> +	}
> +	err = uclass_get_device(UCLASS_RNG, 0, &dev);
> +	if (err) {
> +		printf("No RNG device\n");
> +		return err;
> +	}
> +	err = dm_rng_read(dev, &data, sizeof(data));
> +	if (err) {
> +		dev_err(dev, "dm_rng_read failed: %d\n", err);
> +		return err;
> +	}
> +	err = fdt_setprop(fdt, nodeoffset, "kaslr-seed", &data, sizeof(data));
> +	if (err < 0)
> +		printf("WARNING: could not set kaslr-seed %s.\n", fdt_strerror(err));
> +
> +	return err;
> +}
> +
>   /**
>    * board_fdt_chosen_bootargs - boards may override this function to use
>    *                             alternative kernel command line arguments
> diff --git a/include/fdt_support.h b/include/fdt_support.h
> index 4b71b8948d99..741e2360c224 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -463,4 +463,14 @@ void fdt_fixup_board_enet(void *blob);
>   #ifdef CONFIG_CMD_PSTORE
>   void fdt_fixup_pstore(void *blob);
>   #endif
> +
> +/**
> + * fdt_kaslrseed() - create a 'kaslr-seed' node in chosen
> + *
> + * @blob:	fdt blob
> + * @overwrite:	do not overwrite existing non-zero node unless true
> + * Return:	0 if OK, -ve on error
> + */
> +int fdt_kaslrseed(void *blob, bool overwrite);
> +
>   #endif /* ifndef __FDT_SUPPORT_H */

-- 
// Caleb (they/them)
