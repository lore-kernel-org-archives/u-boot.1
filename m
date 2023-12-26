Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFC8C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6E3C878D3;
	Tue, 26 Dec 2023 10:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R+l1VclG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A0AC878C9; Tue, 26 Dec 2023 10:47:16 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13D76878BF
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3bbb9f39e30so176725b6e.3
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584032; x=1704188832; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rnMGZ4vGKdNhwYTBi5RTRffoV9eBzwKy9LiLpJmzQmU=;
 b=R+l1VclG9lm8DExqHHwnWllcJn07Iy/qEK+rLOplr4/6Wf72yxiPzatdLVC4Jr353y
 +6hrcKDp/WhkWltBgqavPgp532T8gB47JFTrffL7CgbTgB8sfIO0jRNVt1k6IsPCxRR7
 unbCyOgEY0pdrMlMfBw1ce/ko+c1fb5wZiNTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584032; x=1704188832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rnMGZ4vGKdNhwYTBi5RTRffoV9eBzwKy9LiLpJmzQmU=;
 b=efRv9W5Zw0QQ+HY1IHCzSUG7LE3cKef4p9YSQre/L9sUHzx2gGEwNW+3L0HSAB6imb
 qyL8QeZdOD2SV9tya5Hx/aEOa+yzYJ5FpWSngOcY3Ow/qgx2cPUmitf0qCqZasXC3rsH
 SvKv79bxCiVzzgHOGPum4Kz0pU1kl9noJz7H7mjmEk+SjPvwm5aaybDkj7sbdUm0u1hp
 CEiGjRKBehPX7z4R3zxbBNRrGsUvbk8BVTkOr8bHUkan25DE5IsKTfmCgfHoTsrtK9Us
 m1lBJe0otRROYvm5XGp7YbaNZa+DgJMM9dYqfQTOlfTv2f9u29Xe0dWV5n5Q6EhYqXit
 kp/A==
X-Gm-Message-State: AOJu0YxQOVyN1yV/Kvc0nNyMM5aMF5k5uzBF6yksZVVibwXplIgRUN0g
 rqMmv1++bLPY571FwWMONMlogLNKm7USw1diKRXl1jGYJIpH
X-Google-Smtp-Source: AGHT+IHl7Udu5pQcZTlPIL1oYriNpAmP7rlsMfXF5M3JhhYzORNtbRl4qrUUlmiESGQcMmftUZm+P17Cc8BBvr6Yq8U=
X-Received: by 2002:a05:6808:ec2:b0:3b8:b72c:cbaf with SMTP id
 q2-20020a0568080ec200b003b8b72ccbafmr5995175oiv.101.1703584032723; Tue, 26
 Dec 2023 01:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20231221105017.6895-1-heinrich.schuchardt@canonical.com>
 <20231221105017.6895-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231221105017.6895-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:46:57 +0000
Message-ID: <CAFLszTgikbtkcs0UuiU5ipnmvvz+e+AkTkF-jiJc97cXvSqwCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] smbios: SMBIOS 3.0 (64-bit) Entry Point structure
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Heinrich,

On Thu, Dec 21, 2023 at 10:50=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add definition of the SMBIOS 3.0 (64-bit) Entry Point structure.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/smbios.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)\\

What happened to the patch here? [1]

>
> diff --git a/include/smbios.h b/include/smbios.h
> index c9df2706f5..e601283d29 100644
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
> 2.40.1
>

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20231015024511.3995580=
-4-sjg@chromium.org/
