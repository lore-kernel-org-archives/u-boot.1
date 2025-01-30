Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B571FC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 13:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD63A820DE;
	Thu, 30 Jan 2025 14:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t00J5iK+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A67B820E3; Thu, 30 Jan 2025 14:49:50 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D17581F69
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 14:49:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so9533175e9.1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 05:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738244987; x=1738849787;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6snSkPbQN9OxUmYqBIC6l7YvB8N7kF3zyy/BwcOTSwI=;
 b=t00J5iK+ee5mOODRgkuwHNCPiZj+VF9EF5DBklXn2g6RTdoL98JJ7v03cY0PraxHK9
 LUeq4wEt1JzulR21ygyr6rKFt6wVfIr9I54tRvhEwuXv4hURcRCdNjG5jthhQqG31Uac
 PRimy4r6THBIWCtW7Zsx9w07CoRNjgFRnwY4YxPT0PSZv3EzzW7H6OkFSsdiM57UyqSQ
 7sSV1fnPUcLURFfCaeqpEWRxfSKgY48PBKNttGLekN6AOhcfaIuvS9ocHvS3KFWwa09M
 hJsJsdGYfG+E+2H6Oov4BMRJG1XzSzbAC06NtkhfJYWh+kEajsnN5seqzfRsLjWvfJsj
 /kZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738244987; x=1738849787;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6snSkPbQN9OxUmYqBIC6l7YvB8N7kF3zyy/BwcOTSwI=;
 b=pmU60Co5q+aqkJmRF2dp32QMGxMGoA1qlc4lDl/yILhjk4aXOJHagY+BH0tZRoaD13
 c5UuKLeUwqtfNx2V/asQJ3ipviPhjPXyTWyAnl8yldBfrjQcqbkV9GSSUiLeSFjGVizR
 oPxGz7B63duWXuvKTZyf+cw0DS4fQnY5Ppx1j10NZPtTJibtGaOszBhVHmnoBQ2Enjp6
 xjNyoNX+D4q7juTG08niIDhVCY0qbWUZczlGUwysdeHMcdaL5q/dJ7WS6uvF6QJOBRFY
 MJlR/AaCf5SbCnU6598MD6mz3ofxjEsSvS7ZyIOtCHCPp7FlPwCSj4L1zJ+nQ2eADJSc
 4NwQ==
X-Gm-Message-State: AOJu0Yyk9y/agOlETnGri8SfI0ZHP44YnC2EZYp9oACGfGaGc0VWdotq
 w7GysMrkwYoatv3RF/8S6teyOBcRjxVnwxPeQjYhINcMBiwFIuFyZ0zzgOCO1hY=
X-Gm-Gg: ASbGnctFCRbxvICB3dCDB4SfrL2Z61rghXVzeTtv2a3O6nLelWQPpmVE75iFdmHxZNQ
 UVjqdTdT+PvZGRd7yqsDfTpmiccKH5mh6rGIRQL69BlA3idV8XTqRLxXtE5NM95szAxIZjPIEXb
 v5DHYEfmjHEVM3mbAoQPHJzadNbWZS3GQ9MoesfijDPxo+nYKIsnIkgUlSvYB6XtnYnNXAi/+/s
 2voovB6elXRFqMEvxYygz+j+Z/uNSZaLZM8HyMpi2FZFj/lsEVZfV5E7nTbrDFlBJiDuoSRuQBO
 U7N91i3W7i7Q8x5CP1Y=
X-Google-Smtp-Source: AGHT+IGExgAi2Q9i/D4RypBFyzUzgZIxLyq02jps9dwG7MjKpJDO7sExy3Rj8UT6z9gS3oYYib6pJw==
X-Received: by 2002:a05:600c:46c9:b0:436:faeb:2a18 with SMTP id
 5b1f17b1804b1-438dc3bb657mr62309795e9.6.1738244986931; 
 Thu, 30 Jan 2025 05:49:46 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e245f4d1sm23788375e9.39.2025.01.30.05.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 05:49:46 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Federico Fuga via B4 Relay <devnull+fuga.studiofuga.com@kernel.org>, Tom
 Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Federico Fuga <fuga@studiofuga.com>
Subject: Re: [PATCH] Fix fastboot handling of partitions when no slots are
 supported
In-Reply-To: <20250128-fastboot_slot_fix-v1-1-1a4688936662@studiofuga.com>
References: <20250128-fastboot_slot_fix-v1-1-1a4688936662@studiofuga.com>
Date: Thu, 30 Jan 2025 14:49:43 +0100
Message-ID: <87r04kfm2w.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Federico,

Thank you for the patch.

On mar., janv. 28, 2025 at 12:18, Federico Fuga via B4 Relay <devnull+fuga.studiofuga.com@kernel.org> wrote:

> From: Federico Fuga <fuga@studiofuga.com>
>
> The fastboot module has a bug that prevents some command to work
> properly on devices that haven't an Android-like partition scheme, that
> is, just one spl and one kernel partition, instead of the redundant
> scheme with _a and _b slots.
>
> This is the schema of our NAND storage (board is based on an AllWinner
> A33 sunxi chip):
>
> => mtdparts
>
> device nand0 <1c03000.nand>, # parts = 4
>  #: name         size            net size        offset          mask_flags
>  0: spl          0x00020000      0x00020000      0x00000000      0
>  1: uboot        0x00100000      0x00100000      0x00020000      0
>  2: kernel_a     0x00400000      0x00400000      0x00120000      0
>  3: ubi          0x07ae0000      0x079e0000 (!)  0x00520000      0
>
> active partition: nand0,0 - (spl) 0x00020000 @ 0x00000000
>
> This happens when we try to erase the spl partition using fastboot:
>
> $ fastboot erase spl
> Erasing 'spl_a'               FAILED (remote: 'invalid NAND device')
> fastboot: error: Command failed
>
> The error occurs because getvars fails to handle the error returned by
> nand layer when a partition cannot be found.
>
> Indeed, getvar_get_part_info returns what is returned by
> fastboot_nand_get_part_info (0 on success, 1 on failure) but it should
> return -ENODEV or -EINVAL instead. Since the cause of failure is not
> returned by the nand function, I decided to return -EINVAL to make it
> simple.
>
> Signed-off-by: Federico Fuga <fuga@studiofuga.com>

I could apply this version, finally :)

b4 got a bit confused since it has been send as a v1 but using the
following command worked for me:

$ b4 shazam -s -l --check 20250128-fastboot_slot_fix-v1-1-1a4688936662@studiofuga.com -v1

Now for the patch itself:

Please use 'fastboot:' prefix as a commit title.
Use '$ git log --oneline -- drivers/fastboot/' to see what other commits
where using as a title.

Some more comments below. Please make sure to answer this email to
acknowledge/reject review feedback.
Also, when sending a v2, please make sure to include a changelog.

If you need help setting things up properly, let me know. I'm also
reachable on IRC https://libera.chat/, channel #u-boot, my nickame is mkorpershoek.

> ---
>  drivers/fastboot/fb_getvar.c | 5 ++++-
>  drivers/fastboot/fb_nand.c   | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
> index 9c2ce65a4e5bce0da6b18aa1b2818f7db556c528..816ed8a6213b5c1f0948a813c6f6a865a4b47ba8 100644
> --- a/drivers/fastboot/fb_getvar.c
> +++ b/drivers/fastboot/fb_getvar.c
> @@ -121,8 +121,11 @@ static int getvar_get_part_info(const char *part_name, char *response,
>  			*size = disk_part.size * disk_part.blksz;
>  	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND)) {
>  		r = fastboot_nand_get_part_info(part_name, &part_info, response);
> -		if (r >= 0 && size)
> +		if (r == 0 && size) {
>  			*size = part_info->size;

Maybe the patch is simpler this way, but I think that it would be better
if fastboot_mmc_get_part_info() and fastboot_nand_get_part_info() would
behave the same. The naming is pretty close already, and having
different behaviours/return codes seems confusing to me.

Is there a strong reason for not modifying fb_nand_lookup() so that it
will return a negative error code?

This way, we can keep the same logic in getvar_get_part_info()

> +		} else {
> +			r = -EINVAL;
> +		}
>  	} else {
>  		fastboot_fail("this storage is not supported in bootloader", response);
>  		r = -ENODEV;
> diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
> index afc64fd5280717ae4041ed70268ccc01cfbb0496..9e2f7c01895785a4409eb67ea48abd02a6a6da26 100644
> --- a/drivers/fastboot/fb_nand.c
> +++ b/drivers/fastboot/fb_nand.c
> @@ -151,7 +151,7 @@ static lbaint_t fb_nand_sparse_reserve(struct sparse_storage *info,
>   *
>   * @part_name: Named device to lookup
>   * @part_info: Pointer to returned part_info pointer
> - * @response: Pointer to fastboot response buffer
> + * @response: 0 on success, 1 otherwise

Why has this been modified? @response is still a pointer to fastboot
response buffer.

If we wish to document the return code, use the Return: syntax:

For example, here it would be:

/**
 * fastboot_nand_get_part_info() - Lookup NAND partion by name
 *
 * @part_name: Named device to lookup
 * @part_info: Pointer to returned part_info pointer
 * @response: Pointer to fastboot response buffer
 *
 * Return: 0 on success, 1 otherwise
 */

>   */
>  int fastboot_nand_get_part_info(const char *part_name,
>  				struct part_info **part_info, char *response)
>
> ---
> base-commit: a517796cfa5d8f4ca2f0c11c78c24a08a102c047
> change-id: 20250128-fastboot_slot_fix-69251576d9bb
>
> Best regards,
> -- 
> Federico Fuga <fuga@studiofuga.com>
