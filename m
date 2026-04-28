Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC44FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D982C846BD;
	Tue, 28 Apr 2026 20:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SdLlZgKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6340A846B5; Tue, 28 Apr 2026 20:22:10 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7859846C8
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b936331786dso1538111366b.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777400525; cv=none;
 d=google.com; s=arc-20240605;
 b=X7/WZTOdvSuKRI4Rje/Outkg40jqp91TC2MRn6ln31I0Cv/9XJOqTC7WgUKBak3zch
 vQUebSZCLiV1bzwSg63kNcu8yRwBCtVhTloVbb9VOYBQGZXBN2CPXCxux7Mw/NzXdupt
 x7IKNHe0iRRMeB5kaxiq7gytAT889w2xvHgKYg7oPI9GLbOLK+yzpPLCW3WCe5Ynw3eX
 z7bfVNhtiBxT+Av3DmOymquf771DFjciMWqBFBsWHh+qQYI1PyJ8p2dv54+44fGNnFs2
 iDuic/j6oBKtzr0lHTJguLxILmsQSqlsHMPXPI8SIk4p6Pmtt9muKPfAmzLTb9N78Hhi
 aqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SE0Zte92CpuqqUMOpPNVtCIS0sqSGUR4iR6n6hS8FGA=;
 fh=FSZLg1kBZKtmq7hkO96s8J8bywdf/NrVlQg027zGQAY=;
 b=Mz/pkpj87w0uNWko2btQ5ccnXPHynFC9TvVBxLyN7FnT6quN+xJqXCTV4xr0oBELfu
 Aw0KllFIiLxaG1XQ2qdtinPYpqzY1Rvz+SEPNwUs18HCpbWi7qZD2ycSTg6cDxcrbt8f
 fe9Y0Lg/k0FXkLDuyGxspr5x3Waj2FhYcZunnLlJfeZnRBzueYh3oj6VIm3Uu410XY27
 ir+s1axmIUvtPIATv4ngeasQqHILtLMvRdGxxzFmoDA2ZqKQVGtcAKXEjd1KLW78Sq9b
 T6JiNYqT84nLlRW3NHKmFFiBiKy5bl+hnhtZUMswb/Xrm1EUQfo3FDZL08OgOPZBOsm8
 q5hg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777400525; x=1778005325; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SE0Zte92CpuqqUMOpPNVtCIS0sqSGUR4iR6n6hS8FGA=;
 b=SdLlZgKdSBuyLlk69BYkIBp0Ns/SxBHoQtpKBdVlQ4kC4IwwcTwS7OfEB/rl4H+3IP
 4JY15od2LTbOIVIY0tLzQfmrZ2rnt+YkLqlRQbSTZukNfbW/5cY/pQdn/8ZGUQUc6W1v
 geR7KC8TonK+5RVUmHNHNouGFby6bG38sFfqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400525; x=1778005325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SE0Zte92CpuqqUMOpPNVtCIS0sqSGUR4iR6n6hS8FGA=;
 b=FrwE8I3Qjx06T5DODAygFP7K8RZ6I47lrMqFq4v5d4HjgOb/a7KKyf9KvLHXsEVmo/
 85POr3bLXEmq+YS7cfTMrHTE+iBxFDYB9UE8PfF7nkpq/Rv1COIcXVeaOQ4/yW5zhJUM
 6MIlPN4Blb379dDRFuiNPqN/Qk3W1EoxDP7WOhn9O2+vgG8brfPfYInLecC8h9ceOFjJ
 L7Ijf1McmbEr4xevf1iFlp0lHbcfDufFu711KTqNIDg5QtWLdqXmWBkt7c12bCEGimWe
 FeFx6J5dFKMddlVac09soTxSvuB+lZyq86bqCEbTA17bhhNS4dd5CURFtiPv6mzlQYLn
 3jGg==
X-Gm-Message-State: AOJu0YygTX41GPMKg0qT/HTZdB7ojAgTZBXmbt0jvvT0ecqifYz9nIi6
 DRKoMPC5UsbFpGmavI2MlkPSLULpPIw9fZQjhGyAKOV2Z3P8LLUlCljpHj4RlGPs/aQqynhXZQ1
 WMxPoi/1MJVUttPc9+I3YhYKTMJd7jGwl65/gsRm8
X-Gm-Gg: AeBDieu52LOIudW3NeM1dQNWwtBW3U1Kx2dTzsEoqhapILjW5VAILxCNwSZbrgqHNy9
 sCWYYP9XfxNnn987Y0VV8yofAUE4t8xHS993CLQxmXfv4PlZwh85b5POAvRz8qNxxOgeR3dEoxe
 B0ebwiesLA9eq5i5N0iOPpadyk4K4xSqr7Qr8YQ6dAW+qPCHHKWz6f/Bd+hk8otdtjbYsb9uZYm
 CNHmWMfMkO2PL+PhTTtzzpKfi2h3Nf2sh+JJJMH9H4LyBREhKqGFOqehl4vvv+0zTDxzDbeoyBp
 nQVWbYjmHMN/BPyK
X-Received: by 2002:a17:907:c007:b0:ba6:4e0f:e3a8 with SMTP id
 a640c23a62f3a-bb8022c2c58mr303032766b.12.1777400525059; Tue, 28 Apr 2026
 11:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com>
 <20260427-fb_gpt-v2-3-9e7fe3c1649a@oss.qualcomm.com>
In-Reply-To: <20260427-fb_gpt-v2-3-9e7fe3c1649a@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:21:52 -0600
X-Gm-Features: AVHnY4JQTsF6msTLoDdqZZsJQQwleTjVwLYihIX7Jx5HcN2HalaW_sh5ZpssktY
Message-ID: <CAFLszTgkMQUv93VFTEzj_dNyjFsQntyG+9zAbnNtjQDTg4Y45Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] fastboot: block: Add GPT/MBR partition table
 flashing support
To: balaji.selvanathan@oss.qualcomm.com
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
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

Hi Balaji,

On 2026-04-27T12:06:41, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> fastboot: block: Add GPT/MBR partition table flashing support
>
> Add support for flashing GPT and MBR partition tables to the
> fastboot block backend. This enables operations like "fastboot flash
> gpt gpt.img" and "fastboot flash mbr mbr.img" for block devices.
>
> The implementation validates partition table names and rejects
> invalid input formats such as ':gpt' or ':mbr' where the device
> prefix is missing. Valid formats include 'gpt', 'mbr', '0:gpt',
> and '1:mbr'.
>
> Update Kconfig dependencies to allow FASTBOOT_GPT_NAME and
> FASTBOOT_MBR_NAME to work with both MMC and block backends.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> drivers/fastboot/Kconfig    |  4 ++--
>  drivers/fastboot/fb_block.c | 49 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 2 deletions(-)

> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> @@ -227,7 +227,7 @@ config FASTBOOT_FLASH_BLOCK_DEVICE_ID
> +Update Kconfig dependencies to allow FASTBOOT_GPT_NAME and
> +FASTBOOT_MBR_NAME to work with both MMC and block backends.`

Stray backtick at the end of this paragraph - please drop it.

> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
> @@ -361,6 +382,34 @@ void fastboot_block_flash_write(const char *part_name, void *download_buffer,
> +#if CONFIG_IS_ENABLED(EFI_PARTITION)
> +     if (is_partition_table_name(part_name, CONFIG_FASTBOOT_GPT_NAME)) {
> +             int device;
> +             const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> +                                                        CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
> +                                                        NULL);
> +
> +             parse_device_partition(part_name, &device, NULL);
> +             fastboot_flash_gpt_partition_table(interface, device,
> +                                                download_buffer, response);
> +             return;
> +     }
> +#endif
> +
> +#if CONFIG_IS_ENABLED(DOS_PARTITION)
> +     if (is_partition_table_name(part_name, CONFIG_FASTBOOT_MBR_NAME)) {
> +             int device;
> +             const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> +                                                        CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
> +                                                        NULL);
> +
> +             parse_device_partition(part_name, &device, NULL);
> +             fastboot_flash_mbr_partition_table(interface, device,
> +                                                download_buffer, response);
> +             return;
> +     }
> +#endif

The two arms are near-identical and both repeat the interface lookup
that fastboot_block_get_part_info() already does. Please factor the
interface/device resolution into a small helper (or move it above the
#ifs) so the GPT and MBR branches reduce to the
is_partition_table_name() check and the helper call.

> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
> @@ -361,6 +382,34 @@ void fastboot_block_flash_write(const char *part_name, void *download_buffer,
> +             parse_device_partition(part_name, &device, NULL);
> +             fastboot_flash_gpt_partition_table(interface, device,
> +                                                download_buffer, response);

The return value of parse_device_partition() is
discarded...is_partition_table_name() happens to filter out ':gpt'
today, so this is safe by construction, but the coupling is pretty
fragile - please check the return and fastboot_fail() on -EINVAL, or
add a comment explaining why it cannot fail. Same in the MBR branch.

Regards,
Simon
