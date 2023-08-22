Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389AAEE49AE
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B49D1864B0;
	Tue, 22 Aug 2023 20:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iy31p8vd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E49A2864C7; Tue, 22 Aug 2023 20:56:53 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35EE5864AF
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5007c8308c3so4318539e87.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692730608; x=1693335408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B5GWiCuxSf4YhHFnDbmwKugqV3xUEqlk/1Jz4gajUBM=;
 b=iy31p8vdE75pOO45SEpOs8X2NEJSNfy19eySNBjB0HxBpc7QY4sZKBHNXXIb5NR9W1
 NKUbpiXtnlknMmwpeeJ3IpIuX0k9LcRPCZsKtUuQ9RjTcl2583LpVII5OZywRJhHlU0f
 x28rXLJB4RoldCFE1/+8yptiHiLxwe1jYmxX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692730608; x=1693335408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B5GWiCuxSf4YhHFnDbmwKugqV3xUEqlk/1Jz4gajUBM=;
 b=A+rbH7swhCSfUt8WNlqDQ3YreZsf9mkFidxoGEp9ogj+i9IT1o+mND1EDf8Qj+znnR
 0WyHQizuOLkWysITHL1SrDBi5XNqmq9+AAu3Xf7wCj79R7aqGFqZYeKdrlgs9oJkEoeN
 y+DllkJIUgWRmEVdzTOFSPEhbYPKpLhGr9Eb1wy3UzeowU4ogapLLd72BQydxGH+yyMR
 eFPqmZXLljota8xx1ZxSHEIPMLtzDV1D0c6dqNy9U0Q4+TDP8EnCHRbedx7oHhzZwoDm
 Y1qxXz6mRmskDTc51t2dcmkyat+WBgWZDKX2/pJG+c84jKvbPLoQiBBBjhhuzFpJ/I1T
 0mDw==
X-Gm-Message-State: AOJu0Yx+EDEqTLXyA1qAKoH/2h5ps1GmjpJll5oP9JwSjWa1HJ9t0PMh
 eKdnl1rNTZ4dmEGodcoUUj+LaRDlfrm8rlin4JzSKA==
X-Google-Smtp-Source: AGHT+IGJgB0xUcQ2JSSQM+bGXsrtxZqJR5QIkR7stJOnOONjF0VOvjgZVzq1Q0oRn2vR5pZR0ZYjdoV62aJJigCYq7M=
X-Received: by 2002:a05:6512:304d:b0:4fb:be3c:d8b7 with SMTP id
 b13-20020a056512304d00b004fbbe3cd8b7mr9174844lfb.51.1692730607982; Tue, 22
 Aug 2023 11:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
 <20230822121026.1007105-4-alpernebiyasak@gmail.com>
In-Reply-To: <20230822121026.1007105-4-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Aug 2023 12:56:34 -0600
Message-ID: <CAPnjgZ1f14MJFz0vy8SNnzud4VFEkHunu8_+Md1C1UOW2pKTwA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] qfw: Spawn ramfb device if its file is present
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Asherah Connor <ashe@kivikakk.ee>, Alexander Graf <agraf@csgraf.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>
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

Hi Alper,

On Tue, 22 Aug 2023 at 06:10, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> From: Alexander Graf <agraf@csgraf.de>
>
> Now that we have a ramfb device driver, let's add the necessary glueing
> magic to also spawn it when we find its qfw file node.

So then how do we select which video driver is used? I think we should
have this in the DT so there is some control.

>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> [Alper: Use if IS_ENABLED() instead of #ifdef]
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>
> Changes in v2:
> - Use if (IS_ENABLED(CONFIG_VIDEO_RAMFB)) instead of #ifdef
>
>  drivers/misc/qfw.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/misc/qfw.c b/drivers/misc/qfw.c
> index 7c01bf23d53b..4e4260982cce 100644
> --- a/drivers/misc/qfw.c
> +++ b/drivers/misc/qfw.c
> @@ -16,6 +16,7 @@
>  #include <malloc.h>
>  #include <qfw.h>
>  #include <dm.h>
> +#include <dm/lists.h>
>  #include <misc.h>
>  #include <tables_csum.h>
>  #include <asm/acpi_table.h>
> @@ -307,6 +308,27 @@ void qfw_read_entry(struct udevice *dev, u16 entry, u32 size, void *address)
>                 qfw_read_entry_io(qdev, entry, size, address);
>  }
>
> +static void qfw_bind_ramfb(struct udevice *dev)
> +{
> +       struct fw_file *file;
> +       int ret;
> +
> +       if (!IS_ENABLED(CONFIG_VIDEO_RAMFB))
> +               return;

Needs an error-code return

> +
> +       ret = qfw_read_firmware_list(dev);
> +       if (ret)
> +               return;
> +
> +       file = qfw_find_file(dev, "etc/ramfb");
> +       if (!file) {
> +               /* No ramfb available. */
> +               return;
> +       }
> +
> +       device_bind_driver(dev, "ramfb", "qfw-ramfb", NULL);

check error

> +}
> +
>  int qfw_register(struct udevice *dev)
>  {
>         struct qfw_dev *qdev = dev_get_uclass_priv(dev);
> @@ -323,6 +345,8 @@ int qfw_register(struct udevice *dev)
>         if (dma_enabled & FW_CFG_DMA_ENABLED)
>                 qdev->dma_present = true;
>
> +       qfw_bind_ramfb(dev);
> +
>         return 0;
>  }
>
> --
> 2.40.1
>

Regards,
Simon
