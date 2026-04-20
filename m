Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1263FEA719F
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 04:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E020C842C2;
	Mon, 20 Apr 2026 06:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MBfCh5X2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFBAD842E0; Mon, 20 Apr 2026 06:07:26 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D15E080087
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 06:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ba388bc0a9dso464827266b.1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 21:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776658044; cv=none;
 d=google.com; s=arc-20240605;
 b=ALk6nl1rUiK1KTeavHtIqvQhufl1ACC5HlKqAu+38aXtr1SHMAxIS5s8EmT9GCXiLn
 8QcF8n7dVXOHZ/NkiASDA7TNmbgjIbtRRMadZoHhj5IjF2PfhWjMGa/t76OFoUUXJ0UH
 NVG+BO8gZlFHdMZvzjKjRe6hWuXFClAxLdRjvVy4rpsbDUEnnhVbak9UQT3WPUkygpbg
 6ItfP7HbesMuoD5n4CdsVjwhePvIOroq69Icv7VQV86tB4w7ZXTYBOtbt27x6LwG1EBJ
 PUI8WO10kwwb5Ne14cfeGy9ChKCOYUvxJkuuJe09IbYMkkG/+2Nvf4jY/db8zrJ6Tytx
 +Gxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZM2Y3vQV04VyNsa4aTJBhLZ+YrYrTSd5u0Kmjct01As=;
 fh=KKR1m3rWr3Epw/ElaWa8fzDqDpgvAcH+LAnEOwNkDfI=;
 b=JnC0vO7BIubIr8E71kzGh82tMfAy5aOzywD6BrPIJQg9oo0MNpRrcD5AvlkW5QOWyD
 DBEHDg5i/krVnPHML7Y1DBb7d/2557nAT5HAd47rVPTj6EQTHLWe8LTlr4g8kU3FA8Bf
 AKDXu+UC/2bdMdqpEQ7kudHrTr5Uv1CDztRI2L9R88Ugi1Plg8ZAl9Dnx6tGq/5kvvoy
 uSgfICDSfBwaCJL4SsH9gqpc3vWH2rxDQ3GOHV3qtU/Uz3DE/Ss9c1E/g2y8TDgvCB0R
 qXBOuytkZ8Wgo0cswVvpkSd1Pv2UMnU8CGXsiRvZj6l+volSzqhJEjY70FBv5dAwYSGH
 MwnQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776658044; x=1777262844; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZM2Y3vQV04VyNsa4aTJBhLZ+YrYrTSd5u0Kmjct01As=;
 b=MBfCh5X2GcRHTCjr7HvQoUTNT8dufdlSPcSFM8IddlEeQ8wCvCbriL33OdIjBV5Xmd
 16Xc02ALpr+mEt1rOkq+YlgS1BP9g5kh1VYEa9M9hxqIzfxh865WmOZz2HAJLl2C4p+R
 4nbqLNzdadRlAHn+KYVTUwSISNSkYiX/CIg3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776658044; x=1777262844;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZM2Y3vQV04VyNsa4aTJBhLZ+YrYrTSd5u0Kmjct01As=;
 b=SlfgtRFFwN1DB7VSbAlVueaXdR/YxKq+b82n9a6mrgHJVA64abeue35FYyUvdgorTu
 9VWWFFATOSmWbDUrykk4l9SllNKg/CIFs3o9Od55jaPGsMJ/7C/MLZdjvVQ7DOT0rjQL
 gSdL1eFmpH4f++0nA/za47EpPNnfh5bwZQh0D20zImQcCiotF2V5T5VGtlaYcZRQ0f9L
 5kKNwqUd3Q/pxe5ROZu+7+RsUTdUsjs1uMD5+zFVlH8+3I/paNQVYmUdyrYgOb0mKtMQ
 s67ehXaqSLWCw9jBvRKDdwUa8DDoyN3BVTklr9d6wnCzFne1UYI1mpvUUwtWYZqBDnT3
 xFfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9a7hgs7tBW8C3dKi71lO4J1JaLY3VywmiVJYf9waDkCNZH/mXsCGycjqyAzIpyE9IbJH79Fl4=@lists.denx.de
X-Gm-Message-State: AOJu0YzPQrC48+2dNg6wpDcuA3R8Z0qMKJJw2W/aDDoVFQ1buqBgnxyo
 kkV1Bsh8Y5uv4X/sQca+pcJOeNZFfuvI0uxEbT50xl85coiDWBM2J13XwLDGo4SbC+XLpQfisOl
 KDde7lEPXWUGwKIqIN4gi9Ls3JZ0uX0ycth0Xt22p
X-Gm-Gg: AeBDiesxhWRR7ZZZDGjdz8GMYoI153c5mt30tkNWJAwKUlKR9qZHZOCzCW8zm1rqaoN
 pBrxRCoca4v/70tpZtOBAVjPT1Z7HUoUYevxo/XwJcw7Icv9YaYj7yFGr2cW7+X926LcO2xpuO0
 W7CI5O3Au2sIS7ah7LH+AN9pQlBwbm8MuGZZXIoTdwkFJyJ580arz1AZ6lDEKIZIAv5FEhaLJsX
 gxK481Icw7PPVyjEOZxZRFW9dW4kTaIqP+iE3UeEQkYGpbGjbbht2WpC+XTzem4RfDiimSItNQW
 /Jhx7eZ1xZkEhf8MjtGC
X-Received: by 2002:a17:907:e107:b0:ba3:cc7a:622b with SMTP id
 a640c23a62f3a-ba41aa130edmr391759366b.31.1776658044328; Sun, 19 Apr 2026
 21:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
 <20260417120951.3454249-7-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260417120951.3454249-7-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 16:06:51 +1200
X-Gm-Features: AQROBzATgJXOfGjaOtATLZxI8JbGLDfmtQlqtQEOXROP9qmpcgioaq9szxQjeJU
Message-ID: <CAFLszTirJnE2Guyz541ebivyWWDeawT+nxLGO=-FWTefH4X2QQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] doc: document mkimage fatfs type and Qualcomm
 multi-DTB
To: aswin.murugan@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, 
 gchan9527@gmail.com, mchitale@ventanamicro.com, maximmosk4@gmail.com, 
 jonas@kwiboo.se, marek.vasut@mailbox.org, quentin.schulz@cherry.de, 
 peng.fan@nxp.com, sajattack@postmarketos.org, 
 balaji.selvanathan@oss.qualcomm.com, wolfgang.wallner@at.abb.com, 
 e@freeshell.de, yangshiji66@outlook.com, jan.kiszka@siemens.com, 
 funderscore@postmarketos.org, hs@nabladev.com, kory.maincent@bootlin.com, 
 jj251510319013@gmail.com, carlos.lopezr4096@gmail.com, u-boot-qcom@groups.io, 
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

Hi Aswin,

On 2026-04-17T12:09:44, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrote:
> doc: document mkimage fatfs type and Qualcomm multi-DTB
>
> Update doc/mkimage.1 to document the new fatfs image type,
> the --fat-* long options, a fatfs entry in the CONFIGURATION
> section, and two usage examples.
>
> Add doc/board/qualcomm/multi_dtb.rst describing the
> Qualcomm FIT-based multi-DTB packaging workflow for
> Snapdragon platforms. The document covers:
> - FIT ITS configuration and compatible string matching
> - QCOM metadata binary format and identifier properties
> - Guidelines for adding new socver/boardrev entries
> - Step-by-step image creation using mkimage -T fatfs
>
> Update doc/board/qualcomm/index.rst to include the new
> multi_dtb page in the toctree.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>
> doc/board/qualcomm/index.rst     |   1 +
>  doc/board/qualcomm/multi_dtb.rst | 352 +++++++++++++++++++++++++++++++++++++++
>  doc/mkimage.1                    | 103 ++++++++++++
>  3 files changed, 456 insertions(+)

> diff --git a/doc/board/qualcomm/multi_dtb.rst b/doc/board/qualcomm/multi_dtb.rst
> @@ -0,0 +1,352 @@
> +       cp -rap <u-boot build dir>/dts/upstream/src/arm64/qcom/*.dtb* \
> +               fit_image/arch/arm64/boot/dts/qcom/

The text above refers to "Qualcomm Linux Kernel Tree" but the
placeholder says "u-boot build dir". Please change this to reference
the kernel build directory.

> diff --git a/doc/board/qualcomm/multi_dtb.rst b/doc/board/qualcomm/multi_dtb.rst
> @@ -0,0 +1,352 @@
> +1. **Install required tools**::
> +
> +       sudo apt-get install device-tree-compiler u-boot-tools mtools

Step 6 notes that dosfstools is also required for mkfs.vfat - please
add dosfstools to this install command.

> diff --git a/doc/board/qualcomm/multi_dtb.rst b/doc/board/qualcomm/multi_dtb.rst
> @@ -0,0 +1,352 @@
> +6. **Pack the FIT image into a FAT partition image using mkimage**
> +
> +   The `mkimage tool supports creating FAT filesystem images directly via
> +   the fatfs image type.
> +
> +       mkimage -T fatfs -d out/ fitimage.bin \

This code block is missing the RST literal-block marker, i.e. the text
before it should end with ::

> diff --git a/doc/mkimage.1 b/doc/mkimage.1
> @@ -903,10 +984,32 @@ of data storage.
> +.BR mkfs.vfat (8),
> +.BR mcopy (1),

The SEE ALSO entries should be in alphabetical order. Please swap
these two lines so mcopy comes before mkfs.vfat

Regards,
Simon
