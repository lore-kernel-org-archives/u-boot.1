Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F07C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 11:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F365E8798B;
	Wed, 27 Dec 2023 12:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ngIsIdBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DEC28798D; Wed, 27 Dec 2023 12:02:34 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B7D68798A
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 12:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50e759ece35so2449047e87.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 03:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703674951; x=1704279751; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/jlbFABONkHpK+JPAM19Y+i3hoTd67ncWwXgCGBQiqE=;
 b=ngIsIdBSTrZ8BEZzyb7EPauhKho0h/KV/eIbrdUn8BS7Gadwl2reZdRSVN98mDbkax
 lkkBgfhzZgIXJd4P1GuPDgP3rJvxTsZWvXO34EnIZAltJDQSmGBKAThSKi6Ac+o3rM+z
 NHI8g6wwlpa7jK78oK1pTmcp6IayyFUrXG+SEN0v+h7BkVitnkilBtAaFLxIzH7oVFr/
 z13eVa94tov4ST+zoSnVB7G4/lDMv8TC6wlMQmhZnq2Ts36mG7EjA3SWt0l0VUxncUVK
 D9rEIdOm2NXbMu40md3ZrkzHm8F2fdgfj/QeIvc14fbDW+Fw59DsVjSx/RFtb6e6TXVB
 YhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703674951; x=1704279751;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/jlbFABONkHpK+JPAM19Y+i3hoTd67ncWwXgCGBQiqE=;
 b=Xc7LeVuF7Uo2BCNkUH5NNTuHqxYxrNyDbhhr/hg/caN844GvWRCqQT9UpMIDyMt6t8
 BFpVbv6B4t7fQctlNamxyg1hEhUSlxCfGmtm9/KYaDXMf6ap4n3LiKfUhjtZoqW+W5d2
 4wrLDcy+qExYRKlDC0huVCdUF/LNt+az9GJ/W45GbBVO0ggMn2e7eLLBy/nbHCY3skjy
 vhGaBJt2hwKb08iCSyW/bWN5/aKUs59qBmn7Oave32+wHm3hm6Fm7qydCOV8snqFRn6e
 nyDZF6q8EKkGaqAQffqoLR7bq7IVPntLb9tO/ULwxQVIGSSWV3XI6dserbWV5JOTNOEi
 ZFVw==
X-Gm-Message-State: AOJu0YzCIw8fZ/VWN8C7+asmBHfHJXUeQb1+hl92oHYJSIKCI26XALrs
 b0fmzZTYwU20mkq7isGmUqbb08fRbE2085vNtmj2KdLn4GYflA==
X-Google-Smtp-Source: AGHT+IEtJgSLjHxLCoV5ILN6QarOOhhvgq+3EHTpfdkN6vAfD4gsNuzDMNP/805GBttNjPpZJ6XsdfTHMCFo8/yLLTM=
X-Received: by 2002:a05:6512:3451:b0:50b:f896:41ab with SMTP id
 j17-20020a056512345100b0050bf89641abmr3072436lfr.102.1703674951686; Wed, 27
 Dec 2023 03:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20231227074025.2178825-1-sjg@chromium.org>
 <20231227074025.2178825-4-sjg@chromium.org>
In-Reply-To: <20231227074025.2178825-4-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 13:01:55 +0200
Message-ID: <CAC_iWjK6=qv72qrRGxFXigHojKHRh8TZvE6hR7Co_ZB3GeaWCw@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] smbios: SMBIOS 3.0 (64-bit) Entry Point structure
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Wed, 27 Dec 2023 at 09:40, Simon Glass <sjg@chromium.org> wrote:
>
> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> Add definition of the SMBIOS 3.0 (64-bit) Entry Point structure.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v4:
> - Bring in this patch from Heinrich's series
>
>  include/smbios.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/include/smbios.h b/include/smbios.h
> index c9df2706f5a..e601283d293 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -54,6 +54,32 @@ struct __packed smbios_entry {
>         u8 bcd_rev;
>  };
>
> +/**
> + * struct smbios3_entry - SMBIOS 3.0 (64-bit) Entry Point structure
> + */
> +struct __packed smbios3_entry {
> +       /** @anchor: anchor string */
> +       u8 anchor[5];
> +       /** @checksum: checksum of the entry point structure */
> +       u8 checksum;
> +       /** @length: length of the entry point structure */
> +       u8 length;
> +       /** @major_ver: major version of the SMBIOS specification */
> +       u8 major_ver;
> +       /** @minor_ver: minor version of the SMBIOS specification */
> +       u8 minor_ver;
> +       /** @docrev: revision of the SMBIOS specification */
> +       u8 doc_rev;
> +       /** @entry_point_rev: revision of the entry point structure */
> +       u8 entry_point_rev;
> +       /** @reserved: reserved */
> +       u8 reserved;
> +       /** maximum size of SMBIOS table */
> +       u32 max_struct_size;
> +       /** @struct_table_address: 64-bit physical starting address */
> +       u64 struct_table_address;
> +};
> +
>  /* BIOS characteristics */
>  #define BIOS_CHARACTERISTICS_PCI_SUPPORTED     (1 << 7)
>  #define BIOS_CHARACTERISTICS_UPGRADEABLE       (1 << 11)
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
