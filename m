Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC10CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 10:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E5C38815A;
	Wed, 10 Apr 2024 12:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wBw4W/WF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7014488196; Wed, 10 Apr 2024 12:35:38 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C5F58815A
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 12:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-516a01c8490so6259948e87.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 03:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712745336; x=1713350136; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HnJVr4S+FDpgO/rvcDP8wX4LcpztcH9eblQtNAVD/LQ=;
 b=wBw4W/WFpEVqpev5bXvsR5j+GXKr6aE53W8OGyEt9RDqe/oFOQEAcqUJDtG2goPrTd
 /4K1kZH/kDd3s73mxMw+66Rmz9e2mt3Eg37MssS/onl+lAvdXsAde2JpFZWNUijBckTs
 kN9NmJTWQWRjBJajLTqHC/FBNzxv4M3PNuf649v0gt/XLuMA2jX3pryzqi4nBG5CjfKF
 eeVfbvRCp2XOZGTBqn4Og2Ke5OTuDNt/DsgSwcxEOW4ZEVgJGpn+9vfsqXkMkBOMosbZ
 cT02uLP/nvZRLGfktrzbRUtgRJYO0zC+I5jFI3e51SU+4bf3JasHnc/KtVu4VHrw4GAS
 OBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712745336; x=1713350136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HnJVr4S+FDpgO/rvcDP8wX4LcpztcH9eblQtNAVD/LQ=;
 b=qS0+kcIXpxk31ZF7Ga/qOKwfIjPHx6/1dbG4Tvyjy5FGVbZB111p73qx7OE7vfScze
 s3OBc7BIqZR3eVa1olxgsE3CbH8QJb6XsjTKwx1Uggu87BBRFTSWBAeKm9aYoVs7LJvL
 Wx0vTojZfO792L4aVmcRKzkfYU60eqbNoF6OkbpxN34h9rLKewpFV+x1byrL9btoeVmC
 WuiMOI0xAf8h292XUzZ7I1HuBD+coU+aB7Tq/F+kV4eSLS4VOlJW26F6Heraqgpn3qLd
 jrfFGgdzpm57Kzf5HTYFWaWbblFpGeD9SZzSTwL76Rmh667YcgAD1ef9vHH6IkcwsiZ5
 oo1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAGTtxtoOebM7TsfdGgqCzAz6ksNiQQRW6ZJ2EHNEJm7kOa4PRNGeUaoyNfJLKahhfURydxABc3EDQOpJ9GXhp6ZthSA==
X-Gm-Message-State: AOJu0Yx9rqigeAKXTb/RfOW7Nm7HSzEGsLBEhGb/W5tv+n8UGKEcwQ/0
 b/4w+bDhFQHsQt55nf5GnUvgAMJ4r1asKuHFhLo5mHGUYNPoBVlfSNtByg2ONFubHv/7bIIuW/8
 BfcCKBo4RRtZgvpVQQ+EvtnvNCiCAO77YnsIg+A==
X-Google-Smtp-Source: AGHT+IFVbhF/UBg4Ky735X0zJppZ3TxqnIhcD7HNVs8jdaqY6m/2FIPXZRedPzPhE0fg/l5p9zT55RVGf/egG+T5IwM=
X-Received: by 2002:a05:6512:548:b0:517:30a3:d000 with SMTP id
 h8-20020a056512054800b0051730a3d000mr724799lfl.28.1712745335630; Wed, 10 Apr
 2024 03:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240409-b4-dfu-scsi-v1-0-3e1441a60376@linaro.org>
 <20240409-b4-dfu-scsi-v1-2-3e1441a60376@linaro.org>
In-Reply-To: <20240409-b4-dfu-scsi-v1-2-3e1441a60376@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 10 Apr 2024 12:34:59 +0200
Message-ID: <CAC_iWjLZiQabqPURiE5YGsvcstV38-rJ-Hq0NmN0u7HbD2QCfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] disk: expose partition type flags
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
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

On Tue, 9 Apr 2024 at 15:55, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> GPT partition tables include two bytes worth of vendor defined
> attributes, per partition. ChromeOS and Qualcomm both use these (with
> different encoding!) to handle A/B slot switching with a retry counter.
>
> Expose these via the disk_partition struct so that they can be parsed by
> the relevant board code.
>
> This will be used on Qualcomm boards to determine which slot we're
> booting on so that we can flash capsule updates to the correct one.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  disk/part_efi.c | 1 +
>  include/part.h  | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index 4ce9243ef25c..d3ce4dd01dcd 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -292,8 +292,9 @@ int part_get_info_efi(struct blk_desc *desc, int part,
>         snprintf((char *)info->name, sizeof(info->name), "%s",
>                  print_efiname(&gpt_pte[part - 1]));
>         strcpy((char *)info->type, "U-Boot");
>         info->bootable = get_bootable(&gpt_pte[part - 1]);
> +       info->type_flags = gpt_pte[part - 1].attributes.fields.type_guid_specific;
>         if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
>                 uuid_bin_to_str(gpt_pte[part - 1].unique_partition_guid.b,
>                                 (char *)disk_partition_uuid(info),
>                                 UUID_STR_FORMAT_GUID);
> diff --git a/include/part.h b/include/part.h
> index 32ee40488563..afae51f1b933 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -68,8 +68,9 @@ struct disk_partition {
>          * PART_BOOTABLE                the MBR bootable flag is set
>          * PART_EFI_SYSTEM_PARTITION    the partition is an EFI system partition
>          */
>         int     bootable;
> +       u16     type_flags;     /* top 16 bits of GPT partition attributes      */
>  #if CONFIG_IS_ENABLED(PARTITION_UUIDS)
>         char    uuid[UUID_STR_LEN + 1]; /* filesystem UUID as string, if exists */
>  #endif
>  #ifdef CONFIG_PARTITION_TYPE_GUID
>
> --
> 2.44.0
>
I think this would make more sense to be sent along with the capsule
update patches
In any case
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
