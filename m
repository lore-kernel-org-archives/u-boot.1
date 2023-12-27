Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D284FC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 10:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 231938771E;
	Wed, 27 Dec 2023 11:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oTMew9Sf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDE05878A1; Wed, 27 Dec 2023 11:56:12 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B166587718
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 11:56:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50e68e93be1so3767959e87.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 02:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703674569; x=1704279369; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YFYPXDzO8ltiok1XMdAhx2apXLVutiMaH8ZaQUJcMqc=;
 b=oTMew9Sfn7ZNSZ+94qMzXgBhW2Vr6R0HwWvWe3wuXsGCtzdunl7nvytmuTcbWePeEo
 W0VUBScWFU5kWO7BF3GfohYm8/R72eCSKR83Ps5Eqx7Y8GY9f8YYn/WYytAeBn6x9hg1
 mU71pdZUNdXuYLqIqT2tmjd99ywQ9MbjDtrghVm2LvfG6OwJsIQdaPChVosR65h9pCGt
 q3qk8CLbaxXZC2vIPhhRbGzYkOJpGdUX63GvCECq4YzVi0RwX3Hl14ilcjkNJa4I7/kS
 rsh3kbSR1QkPOD2bNr4LJ1sPGsMGeY0oFoafYRyuG0d1XS5IFohhAvnsxZxNR+8dxT3+
 OU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703674569; x=1704279369;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YFYPXDzO8ltiok1XMdAhx2apXLVutiMaH8ZaQUJcMqc=;
 b=kijhPan/ofRLvqFVCiOXS+amTUFZsK4TGib9J3TlxP1os/+UrbYjkt+q+VV3/bHm1Q
 yF8+Zs2WkbzK2+UJ2jKBDGYYtHBIaKyW3PE2X4A42KviJViC1YIf5BDK5Eq5F/XTYjGv
 QL/aPue0bGGiKe4jYA4KzxpN8CxKNOXntrjpyBBN+6AwvzRQjBLyfUPQNiM7qE198HVG
 0WpWBWpanWKxn3lNGS4O3ODhBuMdc2SCsgdt0xhnKa4My2z2PUNZpg/H14LE8ZAWTi8W
 w1IJrBl+4jIgI19y4Qlo+gZDd9RrgCfrXQI5wkRws8EYQTihESVVLgDVSoTr8Pjoi1w9
 lNbQ==
X-Gm-Message-State: AOJu0Yyk/v2+lE0pW8Af7J42m9r3SqEaRmMuW7alHBRWl5pYPR5IS+X+
 yPzNse/TAa/AErYMkbpzKzZRdgAunSArUchB9Q+jTJdkN1PDRg==
X-Google-Smtp-Source: AGHT+IEIlqk2pt5EbGAoIFuXzTkMFIgKlwp6VsM8bKurVP4XtFQhysZHuJcjZu7axkKOQb31aW8YNjeqmKa+sBQfK3w=
X-Received: by 2002:a05:6512:159a:b0:50e:7c0e:57d0 with SMTP id
 bp26-20020a056512159a00b0050e7c0e57d0mr1554590lfb.7.1703674569652; Wed, 27
 Dec 2023 02:56:09 -0800 (PST)
MIME-Version: 1.0
References: <20231223010334.248291-1-xypron.glpk@gmx.de>
 <20231223010334.248291-2-xypron.glpk@gmx.de>
In-Reply-To: <20231223010334.248291-2-xypron.glpk@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 12:55:33 +0200
Message-ID: <CAC_iWjLLUy0MCgYasnSGz9fb84z57Vv-agkw1yqpOUxT3BM8Nw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] smbios: SMBIOS 3.0 (64-bit) Entry Point structure
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
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

On Sat, 23 Dec 2023 at 03:09, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> Add definition of the SMBIOS 3.0 (64-bit) Entry Point structure.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         no change
> ---
>  include/smbios.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
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
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
