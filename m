Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A99C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 845868798C;
	Tue, 26 Dec 2023 10:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nFofUdBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 116DF87872; Tue, 26 Dec 2023 10:51:06 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B5987872
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d9b3a967dbso1224197b3a.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584261; x=1704189061; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTOzg2frOsbtyz4y6O+jgfL505OT9ZKdQiymupuIWmU=;
 b=nFofUdBM7+B8x/ieDsIMZ7rOK/k5RlGCsXd0Zh9iEW+MIt3rhh6PuAqslcEb4BAkVy
 Ocr8K8GR/ilTeLWGJlexPWxQANxcHGpMeMnjNXlISD9FeTAG4QceQkhs7R3D4+iXA9LB
 8pCWK1KdPy9VFmWZmNee8lwZfsq1ztQVVdl6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584261; x=1704189061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JTOzg2frOsbtyz4y6O+jgfL505OT9ZKdQiymupuIWmU=;
 b=C/ORbBDVIEctEda5H/UAFRIazEa/CS5OBJr90lJWLOb+l4ltMT5JCIo+8nwvrdBDgb
 NXcwQ/DS/CTy19DpSTbYwTpMCFLSrDe/mr1oXYDObcA3Cyk3m5Q8hCgc54MoJzDUdy5w
 pyWDmu9RQEjsw2IWWlY96KFtB+w5xuBHErkxSt07+igKUwGns212v73PTBDUUGXv9Hm9
 B7k/RmnOYYSiHqfzHYHOL+DcVurvuLTOExVAwrXb45qbs9tUwpStZWz6jNYQ9NiBypiM
 5TISVEe55nKgnfTKiGxkjQLJghoXh3N38+Y6aBnBp1Fp0KdpVE0ZK7yB3nAiyTx7WAYG
 1LpQ==
X-Gm-Message-State: AOJu0YxVQYPlkhpZzP/aBgnS0pHCgg8vh/d93N7OV6xGO9xVephb1yHi
 9e2LrgzVgTsgIM17TSAVrWq8P5jVpXlpyrEsrNafk9yJywF7+mllya94MjLcUA==
X-Google-Smtp-Source: AGHT+IF3weyZ7ydaFvBWXvHEQlQ6q/Y5BKe/JPZD7y3yiuEvrwVcj5JmKv/PS3Ula9XnzNaRy4mN9Au0WiAil5bh380=
X-Received: by 2002:a05:6a20:3c89:b0:187:c3db:8999 with SMTP id
 b9-20020a056a203c8900b00187c3db8999mr7691001pzj.45.1703584261454; Tue, 26 Dec
 2023 01:51:01 -0800 (PST)
MIME-Version: 1.0
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
 <20231223004429.247301-5-xypron.glpk@gmx.de>
In-Reply-To: <20231223004429.247301-5-xypron.glpk@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:50:48 +0000
Message-ID: <CAFLszTj1tbJJPDdpf0sGLy9dou_=0py1Xcn40Eu4wNi3L9cfig@mail.gmail.com>
Subject: Re: [PATCH 4/5] doc: man-page for smbios command
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

On Sat, Dec 23, 2023 at 12:49=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> Provide a man-page for the smbios command.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  doc/usage/cmd/smbios.rst | 93 ++++++++++++++++++++++++++++++++++++++++
>  doc/usage/index.rst      |  1 +
>  2 files changed, 94 insertions(+)
>  create mode 100644 doc/usage/cmd/smbios.rst
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/doc/usage/cmd/smbios.rst b/doc/usage/cmd/smbios.rst
> new file mode 100644
> index 0000000000..1ffd706d7d
> --- /dev/null
> +++ b/doc/usage/cmd/smbios.rst
> @@ -0,0 +1,93 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later:
> +
> +smbios command
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Synopsis
> +--------
> +
> +::
> +
> +        smbios
> +
> +Description
> +-----------
> +
> +The smbios command displays information from the SMBIOS tables.
> +
> +Examples
> +--------
> +
> +The example below shows an example output of the smbios command.
> +
> +::

It doesn't matter, but can't that :: go on the previous line?

> +
> +    =3D> smbios
> +    SMBIOS 2.8.0 present.
> +    8 structures occupying 81 bytes
> +    Table at 0x6d35018
> +
> +    Handle 0x0100, DMI type 1, 27 bytes at 0x6d35018
> +    System Information
> +        Manufacturer: QEMU
> +        Product Name: Standard PC (i440FX + PIIX, 1996)
> +        Version: pc-i440fx-2.5
> +        Serial Number:
> +        UUID 00000000-0000-0000-0000-000000000000
> +        Wake Up Type:
> +        Serial Number:
> +        SKU Number:
> +
> +    Handle 0x0300, DMI type 3, 22 bytes at 0x6d35069
> +    Header and Data:
> +        00000000: 03 16 00 03 01 01 02 00 00 03 03 03 02 00 00 00
> +        00000010: 00 00 00 00 00 00
> +    Strings:
> +        String 1: QEMU
> +        String 2: pc-i440fx-2.5
> +
> +    Handle 0x0400, DMI type 4, 42 bytes at 0x6d35093
> +    Header and Data:
> +        00000000: 04 2a 00 04 01 03 01 02 63 06 00 00 fd ab 81 07
> +        00000010: 03 00 00 00 d0 07 d0 07 41 01 ff ff ff ff ff ff
> +        00000020: 00 00 00 01 01 01 02 00 01 00
> +    Strings:
> +        String 1: CPU 0
> +        String 2: QEMU
> +        String 3: pc-i440fx-2.5
> +
> +    Handle 0x1000, DMI type 16, 23 bytes at 0x6d350d7
> +    Header and Data:
> +        00000000: 10 17 00 10 01 03 06 00 00 02 00 fe ff 01 00 00
> +        00000010: 00 00 00 00 00 00 00
> +
> +    Handle 0x1100, DMI type 17, 40 bytes at 0x6d350f0
> +    Header and Data:
> +        00000000: 11 28 00 11 00 10 fe ff ff ff ff ff 80 00 09 00
> +        00000010: 01 00 07 02 00 00 00 02 00 00 00 00 00 00 00 00
> +        00000020: 00 00 00 00 00 00 00 00
> +    Strings:
> +        String 1: DIMM 0
> +        String 2: QEMU
> +
> +    Handle 0x1300, DMI type 19, 31 bytes at 0x6d35125
> +    Header and Data:
> +        00000000: 13 1f 00 13 00 00 00 00 ff ff 01 00 00 10 01 00
> +        00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +
> +    Handle 0x2000, DMI type 32, 11 bytes at 0x6d35146
> +    Header and Data:
> +        00000000: 20 0b 00 20 00 00 00 00 00 00 00
> +
> +    Handle 0x7f00, DMI type 127, 4 bytes at 0x6d35153
> +    End Of Table
> +
> +Configuration
> +-------------
> +
> +The command is only available if CONFIG_CMD_SMBIOS=3Dy.
> +
> +Return value
> +------------
> +
> +The return value $? is 0 (true) on success, 1 (false) otherwise.
> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index 1a626c03c2..eb2b2311f8 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -102,6 +102,7 @@ Shell commands
>     cmd/size
>     cmd/sleep
>     cmd/sm
> +   cmd/smbios
>     cmd/sound
>     cmd/source
>     cmd/temperature
> --
> 2.43.0
>

Regards,
Simon
