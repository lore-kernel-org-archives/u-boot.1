Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15000C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACB39878EA;
	Tue, 26 Dec 2023 10:51:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cM80vms9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F357871C0; Tue, 26 Dec 2023 10:51:01 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 536BC8796D
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3bbbc6bcc78so171378b6e.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584258; x=1704189058; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIze0Q2A7TNCX/P7nZh2uoMTv2/9qAIvQCmNnOfv4cg=;
 b=cM80vms930xpLKwAmy6I/yfQCidkxk/EQcfqzsSu9mW2I2s770Da+N4pO01mVMeo5C
 slYQ2hvHx6HUKnqNLwlZXs41FvqaEOW1Inx7QByIgywL9P8zYMvMozOGiTpssjthAdeA
 tgKhoMmWlsRvMj1qIeSzYrFPumkUp1MT34bKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584258; x=1704189058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hIze0Q2A7TNCX/P7nZh2uoMTv2/9qAIvQCmNnOfv4cg=;
 b=iE7MFYNylSLkHqvH3qwTvGPJiMrZ38AnbMUAgC+A2a6uZvFVLWUexXSlrujXrYqXNG
 z3EKq+E90uHPWcCYbbKMK0udPj6XdBuNaXWcpu/ZcFRYJ7PK8JCk16lqQiZxbflFdkow
 JbkV5kpSXZIBSos6afbdvm84pbQ//xtzO3skT6FL4sawifCEFjMlALOsJqooVmJhRUJQ
 6G15FXl63B7k+zl05nPbVDplAhrj2BN5MwPd2Ho7EQP+vg5UXG7344sibo3TFaS38wGQ
 WrxVd25SgsONI2QhdtNsJpB6h/IZomk+/E0m40SNw7Yczn5ynuAl90AbMi4PAPb7AoGl
 ITZg==
X-Gm-Message-State: AOJu0YyR/v0yV+6mCY6E0xi9QuSchr2MgLCavDthEG9y3H7n1mL+IPIe
 NWCxQBH9gOM7ozRVV5Kxc/0BJg6J+ftasP7Vb0eKt4t8Ul/8
X-Google-Smtp-Source: AGHT+IF2oGHFCejG99O6aanN/uX6gU/7ojPXbgex3A0n2IkvMLwOlkn8dippl/oCAYlXhZW7fvJle5h2jrhla27ZG2s=
X-Received: by 2002:a05:6808:6410:b0:3bb:a5b8:91d0 with SMTP id
 fg16-20020a056808641000b003bba5b891d0mr4191686oib.115.1703584258037; Tue, 26
 Dec 2023 01:50:58 -0800 (PST)
MIME-Version: 1.0
References: <20231223010334.248291-1-xypron.glpk@gmx.de>
 <20231223010334.248291-2-xypron.glpk@gmx.de>
In-Reply-To: <20231223010334.248291-2-xypron.glpk@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:50:46 +0000
Message-ID: <CAFLszTheorQXCn_HHbdbkcCpoc5V0q19q4mJOi0cieQKDY2oDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] smbios: SMBIOS 3.0 (64-bit) Entry Point structure
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Sat, Dec 23, 2023 at 1:03=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
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

We have this struct elsewhere, as mentioned, but this one adds
comments so is nicer.

Reviewed-by: Simon Glass <sjg@chromium.org>

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

Regards,
Simon
