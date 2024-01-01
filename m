Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949AFC4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 22:42:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54EF58788F;
	Mon,  1 Jan 2024 23:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O9TolALZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F329887884; Mon,  1 Jan 2024 23:41:44 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2E4886FF4
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 23:41:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-594bea92494so3084373eaf.2
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 14:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704148901; x=1704753701; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CaU7cNL0gtFbzFoh7ilPjfz8IHi6HLsVaLmNV6jGMl8=;
 b=O9TolALZbRSJHulP0qrdHQI+a/xy3kUfKqmyNlkQR5jF2871w+Hsh1SNNEwW+bE9Gc
 ZzlaMqN6YrirNdj/yzqUw3Kep8Fcjel8jn8iX6Ao6RuZi8DHvCdMyBNFabhHxp29PllV
 EWe5jqInPDEg108dV2zUHFu95ROLZ5ujcDosU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704148901; x=1704753701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CaU7cNL0gtFbzFoh7ilPjfz8IHi6HLsVaLmNV6jGMl8=;
 b=ETeridyHhCOYcCN/ipRMRYwE1Ak3pBHGMM1jaCk+pbTBz8WmYtnZHeQKMlq7TPrMKo
 rU6q97MaOPrmCWLEXrQXVnTpI9/+Y7Ec0juS4TUwuUtkRwwcHu3pifWxBKS6Lpvlq/R3
 1X37PtR2WbGMWRV6HqwZzL9TQ5YvuyiehdSbagUX8mWaodIm08Mn9/SwkE872kGyqybK
 C4aVihmgtutI1ra19lH4sz9t9WHWqBmWTyfW868684vqM2W2l17Yuu9tBuaUwZLxT1T5
 tJEcdxp5vIKtG7tixnlUNT7HW56KPVHHDPCoazTTcEiukREHO9QkQ+yS6v//F3JifqQe
 7y2A==
X-Gm-Message-State: AOJu0YzWhRSfbfNHxSleHiaueojyq36zq8EQhTfFSE8jla9gYNwgy1uX
 p8zoQEqkCMIUIh9HdvJ5QiLetmTqmBWj8c2naBkCnAnryUSP
X-Google-Smtp-Source: AGHT+IEM5TFpdho8TKoVBiGeA+JV8WBMJuPpZb5XqT84tSbE893i7RZY5LelCq5p66wdaM9iKJ5W3hG3MfmJadk8sNQ=
X-Received: by 2002:a05:6358:2608:b0:174:d91d:eb45 with SMTP id
 l8-20020a056358260800b00174d91deb45mr15390458rwc.38.1704148901371; Mon, 01
 Jan 2024 14:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20240101115250.78735-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240101115250.78735-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jan 2024 15:41:30 -0700
Message-ID: <CAFLszTicbA6i9ix2ereRnQtRy5UR=B0rVSUdznqQHPkBCThi=Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86: all firmware tables must be paragraph aligned
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

On Mon, Jan 1, 2024 at 4:52=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On qemu-x86_64_defconfig the following was observed:
>
>     =3D> efidebug tables
>     00000000000f0074  eb9d2d31-2d88-11d3-9a16-0090273fc14d  SMBIOS table
>
> The SMBIOS configuration table does not point to a paragraph aligned
> address. The reason is that in write_tables() rom_addr is not aligned and
> copied to gd->arch.smbios_start.
>
> The Simple Firmware Interface requires that the SFI table is paragraph
> aligned but our code does not guarantee this.
>
> As all tables written in write_tables() must be paragraph aligned, we

paragraph-aligned

But was is a paragraph? Is that an x86 term?

> should implement the address rounding in write_tables() and not in table
> specific routines like copy_pirq_routing_table().
>
> Add paragraph alignment in write_tables().
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/x86/lib/tables.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
> index 5b5070f7ca..89d4d30a6a 100644
> --- a/arch/x86/lib/tables.c
> +++ b/arch/x86/lib/tables.c
> @@ -97,6 +97,8 @@ int write_tables(void)
>                 int size =3D table->size ? : CONFIG_ROM_TABLE_SIZE;
>                 u32 rom_table_end;
>
> +               rom_addr =3D ALIGN(rom_addr, 16);
> +
>                 if (!strcmp("smbios", table->name))
>                         gd->arch.smbios_start =3D rom_addr;
>
> --
> 2.43.0
>
