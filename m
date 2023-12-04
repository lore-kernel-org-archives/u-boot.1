Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D153C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BF8F8788D;
	Mon,  4 Dec 2023 09:25:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vN/HxQ2k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E001C8788D; Mon,  4 Dec 2023 09:25:29 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69BDF8787A
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c9fbb846b7so9792011fa.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701678326; x=1702283126; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BpGCES18AOJ/bAgUXZ7dwcoQgA7Vk5Oe0Ix+GDC8qjI=;
 b=vN/HxQ2kdqHr0N4qh7+OMiJHZQPLi/y7iLrUMk30InDr9leiXNefw4e++jygmdQYBC
 2T5nZHpfQty2hxqfWCnOdcAj5L2l1oA9bi/CemSRuoNzcGn7pLlwABRWnyXVTwrgoADW
 F6Y5aervLJSPXPRDnbDk06PdfGQOPfHGzko15l8Cm3eCuIVc9teSDTawTZJDkuyadeKP
 uakpzFJKR8Pp6eSJf61IS20k9FzQ/21g8AqacljX6TEaQdTDae4MhxVzUOcqGh+jfaMp
 WKNne4d3o9vX9544VbU+CiFitzdUD7DhTuhvHZLqSVEOqS+6Dl9Dy1l475CGmJj7ty/L
 wRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701678326; x=1702283126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BpGCES18AOJ/bAgUXZ7dwcoQgA7Vk5Oe0Ix+GDC8qjI=;
 b=bahsJ1boYt+YHcGRq1NAX9TKfmCgaM9sKbtNcjKTwtLX4JFbeL4O0KlhcVAuxEyJ/H
 ESe9eed+UQyVfCoHjLsk20M5U2oND72FvyyZYNKgi05oTuplyCDSufTGSBIcNl28ZuIx
 MNNURWxe2cfr6oLcwZUE1fhG8rP/Q2gahIuoK0MLdaR+xDwRUueRDBcNQF3FVfMX7wJQ
 kMXdDfUVRCJuO/CCgvVjwytU/O7AE+Kbz6QYLrhIRb2ABJ5lNVtp9uAtjdSJVPSqccHh
 Yq6V8QRVZGsYA9EOuTMurBA+OHag2Tkcl9Fll4KQne0RQCpQWat5jc41GTOyzBicsfJa
 wnDg==
X-Gm-Message-State: AOJu0YzvHmze1lcO1nuOz9Zme3VGOKskeAAKngC7UG7sphhgVGqBZEOR
 DRDSVIZTqKBptV3mDz8dncDgs9UFjE3mE5Co+VGIfL+8F1oYAqX6
X-Google-Smtp-Source: AGHT+IFLXkmY4w9jZx7kga2Qb4QJyGHjzIT03fl+q7Hhc8PBgqRmqV7LLbY/2cbC8GahuHXCafpmncy89MtIR0quBUk=
X-Received: by 2002:a2e:9055:0:b0:2ca:61c:d0d5 with SMTP id
 n21-20020a2e9055000000b002ca061cd0d5mr289356ljg.102.1701678325739; Mon, 04
 Dec 2023 00:25:25 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-2-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-2-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 4 Dec 2023 10:24:49 +0200
Message-ID: <CAC_iWjJ8qkOGVVqDa-_vg4x2W2rocb=ysQDPJhEgE0rOnwox6w@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] bloblist: Update the tag numbering
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, Bin Meng <bmeng.cn@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>, 
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
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

Hi all,

[...]

>  common/bloblist.c  | 16 +++++++++---
>  include/bloblist.h | 65 ++++++++++++++++++++++++----------------------
>  test/bloblist.c    |  4 +--
>  3 files changed, 48 insertions(+), 37 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index a22f6c12b0..349ceddea5 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -36,16 +36,24 @@ static struct tag_name {
>         enum bloblist_tag_t tag;
>         const char *name;
>  } tag_name[] = {
> -       { BLOBLISTT_NONE, "(none)" },
> +       { BLOBLISTT_VOID, "(void)" },
>
>         /* BLOBLISTT_AREA_FIRMWARE_TOP */
> +       { BLOBLISTT_CONTROL_FDT, "Control FDT" },
> +       { BLOBLISTT_HOB_BLOCK, "HOB block" },
> +       { BLOBLISTT_HOB_LIST, "HOB list" },
> +       { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
>
>         /* BLOBLISTT_AREA_FIRMWARE */
> -       { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
> -       { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
>         { BLOBLISTT_TPM2_TCG_LOG, "TPM v2 log space" },
>         { BLOBLISTT_TCPA_LOG, "TPM log space" },
> -       { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },

There are some TPM Eventlog related entries that are missing here.
Can we add them?

> +       { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
> +
> +       /* BLOBLISTT_AREA_ARM */
> +       { BLOBLISTT_OPTEE_PAGABLE_PART, "OP-TEE pagable part" },
> +
> +       /* BLOBLISTT_AREA_OTHER */
> +       { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
[...]

Thanks
/Ilias
