Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C88FF46C4E
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 17:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03F3283EC6;
	Mon,  6 Apr 2026 19:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OCQ/n46x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A06783FA3; Mon,  6 Apr 2026 19:14:58 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E748983C2B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 19:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b9c6680aaf8so436490266b.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 10:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775495695; cv=none;
 d=google.com; s=arc-20240605;
 b=hB2NwwNEX7h2iJ7atd5HhfXAxEu4MFR/NaCyQTOXV3/kmkFSH8Ts9y28jCxJGR2XJS
 gJbV8mkdaymrNCCMfqYDdNpGJdqcbVwessshiI4Tf987JGiIqsza3vIUJNa26qmHDr3W
 6gF9eTiQNmaM/xJ7GsoJgjqLwUfYqhj1pOa+RObXVan1LLSg/i6YaQNQIGrB+eBpm4Ma
 jZ6AV3QIPdvDUzcTBrhHK+0e+KFyHLtPIHzB/Q/9MznK2J1m5ciIVGUcuy/uDnYeUhy4
 5c/9Jc2hw29KvOYIIGMZ40Oszj2BiG+qyG6vc9g8Ee0BmSldqa9sPIpTN1GkH9/4ZJr9
 JZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VuJJbmnyghqnpY6Jw8xJjpGsN03duKt59Z1BDjK6zZQ=;
 fh=JPDSdnKD6W7aw8GIhYsqYjpHi+K2R8/k1Q66YrxWHGw=;
 b=DEBnqV+myTZJPAQP/AOTDKkyahalh917tqZcdJJfjeGYKYxTeuW1QQh/1A2ocOr3hf
 Mc9E/SMnRFQilNSdWCvkjmZSKGWTbnvYWkkYhlI+ycVAFpsZA9yt81V0DoImafNu9SNp
 uatK/LTN6OEH+1PSNxyQUHz5XOV9ICotLO7ljCRKBEGNUdhkPkwAL1BbynK8sJUOO1oc
 igmilkMvG+sHa/DQsj5eMj3j10gmPoezoRmdaI+NBTLQoNYdUscB31fZxuoOw3RHu2Xv
 K6ATOA/4dcf9VNs7Qmt0funW8klhGPFQHKYpilaCp4flYoJymKpGLurXjCwFiht5gbpC
 3iEw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775495695; x=1776100495; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VuJJbmnyghqnpY6Jw8xJjpGsN03duKt59Z1BDjK6zZQ=;
 b=OCQ/n46xUY7Pzp01rKH3RwTEQb4iSoy4RqxIvVjuo6+sA6VHVAQ+OaRy6xq5bHAd2M
 FVK+8H31ezxFs0bNJNA6x2BUM93Z6Th/02I0jb0GXQ1LCilfLoRNs+hU3THazKAkp5JM
 YUb1Ze8GK2POxH+xylzc0dmymnwmido0HJras=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775495695; x=1776100495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VuJJbmnyghqnpY6Jw8xJjpGsN03duKt59Z1BDjK6zZQ=;
 b=b5S4YJeO2NsZTKDbT1gBPz87XIGM/nH322k2kZ3/+a89dCw/jWpQVbjq0JWm9AS82g
 1Wq809J4GMfPjJHEqYeyJYGAs/dwK35Za8SlTnolUTedlmz8tFDF1sB8ullM4Nk7eocV
 QvIDHM4XS/a5bjcvzho1Prcqjp5TxPSLSo8uy6lhGLJdhtJNyCKr78C4RsykXIcgYMVf
 qbJ9oLN5ZOBZL+1l0Cm2X+WTiet4R6f3lkcQkIZNfaH3uKA6tJa35P0ar0Xpj59Dr0uy
 MFZv8xCj184198FNZeuKKn7l8DE67sFzpErmD8c8u890s72QD/JmivEejvJ9AjMQslbL
 UcGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhcJO6CCKx7P2AmeV/IW9hO8UMVqry4C+F4OCtFYYXtPCKeQuzvfZ0wFIJprrtkCXB+6Fv2MM=@lists.denx.de
X-Gm-Message-State: AOJu0YynvOQCaRLD0JalfNtZ16lzdD6wMAuSbOKMsGeSYCmoQSHLDcrk
 3Pbywh4aB0FAa84joTG5LKKqxdR3pWvmVWH7s3TcHe/jvcAtfFVUUEXiGGKlVAi5Vu1yDc/NQDj
 YbIkFx6FDeTUJ5NhoqbDGTb75DwX/szFSFEbkUuwa
X-Gm-Gg: AeBDievblOFPDCpt0EWPdQ2yIlzdygWxAG18fKBNucVNAUpo7EQyuTsBRbhv+kdlTc1
 Ncqx53THTfmJmqrOEFrsVdCvSsV8bjc1JiXheTwIZrs5PPjRXj6SV//+DAD2Xc8KvfrdAAbz1B0
 hUlnlAO3ubbrP0nZijJ+JjPPaX1RTcKW1hxdW7irm+mdzMK4an7APE7CicIUCRbIbWjuBPT3Ta/
 dg1cn7YkHUQQ05hMrT4jqow9yZ3syXaiCKnKVhWDg28lQgMxlpKONzG22qI9AzhmPbk9Ssuu1BZ
 lUKiwg==
X-Received: by 2002:a17:907:d005:b0:b9b:e4ea:93a9 with SMTP id
 a640c23a62f3a-b9c679a44c2mr672240966b.24.1775495695316; Mon, 06 Apr 2026
 10:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260403135205.26979-1-ansuelsmth@gmail.com>
 <20260403135205.26979-6-ansuelsmth@gmail.com>
In-Reply-To: <20260403135205.26979-6-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Apr 2026 11:14:43 -0600
X-Gm-Features: AQROBzAwsc0NRt02Xa6c6yGUEkNq5p5PAm0KLomu_--9ddN--FlFspr8cIKL4PE
Message-ID: <CAFLszTjHv+vVunXKHW8ppyq0z3Tr=LZTqiFQEGc4nFcTWwiFgA@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] misc: fw_loader: introduce FIP loader driver
To: ansuelsmth@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peng Fan <peng.fan@nxp.com>, Justin Klaassen <justin@tidylabs.net>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Harsha Vardhan V M <h-vm@ti.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
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

Hi Christian,

On 2026-04-03T13:51:57, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fw_loader: introduce FIP loader driver
>
> Introduce a variant of the FS loader driver to extract images from FIP
> image. These image can contain additional binary used to init Network
> accelerator or PHY firmware blob.
>
> The way FIP handle image type is with the usage of UUID.
>
> This FIP loader driver implement a simple FIP image parser that check
> every entry for a matching UUID.
>
> Similar to FS loader, this driver also support both UBI and Block
> devices.
>
> Also an additional property is added to handle special case with eMMC
> that doesn't have a GPT partition and require a global offset to
> reference the FIP partition.
>
> An example usage of this driver is the following:
>
> [...]

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,578 @@
> +static int blk_read_fip_firmware(struct firmware *firmwarep,
> +                              struct blk_desc *desc,
> +                              struct disk_partition *part_info,
> +                              unsigned int part_offset,
> +                              const struct fip_toc_entry *ent)
> +{
> +     ...
> +     size_t size = ent->size;
> +     ...
> +     blkcnt = BLOCK_CNT(size + firmwarep->offset, desc);
> +     blkstart = ent->offset_address + firmwarep->offset;
> +     ...
> +     if (pos) {
> +             to_read = min(desc->blksz - pos, (unsigned long)size);
> +             ...
> +     }
> +
> +     /* Consume all the remaining block */
> +     for (i = 0; i < blkcnt && read < size; i++) {
> +             to_read = min(desc->blksz, (unsigned long)(size - read));

This reads the full ent->size bytes but starts at ent->offset_address
+ firmwarep->offset. Compare with ubi_read_fip_firmware() which
correctly reads (size - offset) bytes. The blk variant should also
adjust size by firmwarep->offset so the behaviour is consistent.

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,578 @@
> +static int fw_get_fip_firmware_size(struct udevice *dev)
> +{
> +     ...
> +     return ent.size;
> +}

ent.size is u64 but the function returns int. This could truncate
large sizes. The same issue exists in fw_get_fip_firmware(). How about
using ulong which is the common type in U-Boot?

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,578 @@
> +static int fw_get_fip_firmware(struct udevice *dev)
> +{
> +     ...
> +     ret = fw_parse_storage_info(dev, &info);
> +     if (ret)
> +             return ret;
> +
> +     struct firmware *firmwarep = dev_get_priv(dev);

Please can you move the firmwarep declaration to the top of the block.
The same pattern appears in fw_get_fip_firmware_size().

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,578 @@
> +     if (ent.size + firmwarep->offset > firmwarep->size) {
> +             log_err("Not enough space to read firmware\n");
> +             return -ENOMEM;
> +     }

I suspect this check is wrong. If firmwarep->offset is an offset into
the FIP entry, you likely want to verify that (ent.size -
firmwarep->offset) fits in the buffer, not (ent.size +
firmwarep->offset).

Also -NOSPC might be better, since we are not actually out of memory.
When people see -ENOMEM they tend to want to increase the malloc size.

> diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
> @@ -25,11 +25,13 @@ struct phandle_part {
> +     int partoffset;

partoffset is declared as int but used as unsigned int in
fip_storage_info and read from DT with ofnode_read_u32(). Please can
you change this to u32 for consistency.

Regards,
Simon
