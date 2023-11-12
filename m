Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE5CC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 03:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C394874E1;
	Sun, 12 Nov 2023 04:09:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FLX/xyYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED316874C3; Sun, 12 Nov 2023 04:08:59 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4392871A0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 04:08:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-991c786369cso527342866b.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 19:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699758537; x=1700363337; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I+kTQ9qAt6ViU8dx1+HqLerdxxnV5aFrF0woq6QzJ/8=;
 b=FLX/xyYZK+GigS8wHNwENMMoxaHsUuf/RZRG/rPSqD7+3NRXTvNYqlL7ITFV450KUg
 dSmMIyo3XFqcc/qJTjLBtOlrFkYjb7tjvyt1zKQUkJFzF6DhjyZK8ixFpXIM3kcgGsh5
 F6Sj+b3FYdK0d+VrlXAYaebLTU1GKPOZ6rA4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699758537; x=1700363337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I+kTQ9qAt6ViU8dx1+HqLerdxxnV5aFrF0woq6QzJ/8=;
 b=ZEf7c21gCGMj8I4K6B9W2NMyIUXAy7kkJPKRYKSqVsIGkiSw1U49PVChyK/UmjSbeV
 s3iZjPBQEqEihVPG34EHW5LlRj7kF8bXCbNFC/lhdxR199wwHe7fc5V+cASD4SuBpxDG
 5J8hcui73X2PS1ztobmI/nLmqSGhgbmXhPA6QlC1+IFHdgvuFrs/v068wF2q1m33dxiF
 nEhxIGvmezGbrBinoL4tpOV9A8P0lfWm0xEr1Q+ajwxt4nXU5NGktRWPu6GH2SxiTzvg
 a+RoVebSIv5DVeFTyYujghpa3njGpAXzNtoQhGCvXtiXJN2vx6/kkGJ6TRFTw7kjXL5k
 +QXQ==
X-Gm-Message-State: AOJu0YxMvhEmNk8XYuktYPepHXqFVxNSA1B7zvOpiDC28MrgVslATzU8
 oMwSEFsVVeHjvuiasdbjluEiqf1/jIkTnEu8cLlXtg==
X-Google-Smtp-Source: AGHT+IFkQVIpN6EdENAGrsBCAfWonGOytRGjL1hPeAZktjd6OBdXqu6ktri0s5RRxUUAEktVivOGUUrOofJnH11tzFI=
X-Received: by 2002:a17:906:f8ce:b0:9da:f76f:c101 with SMTP id
 lh14-20020a170906f8ce00b009daf76fc101mr1995266ejb.37.1699758537182; Sat, 11
 Nov 2023 19:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20231111134112.165377-1-heinrich.schuchardt@canonical.com>
 <20231111134112.165377-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231111134112.165377-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Nov 2023 20:08:38 -0700
Message-ID: <CAPnjgZ0fR9dbdydxLBp9Md+pWmovRAJsNf163KyyJAY_wdpfpA@mail.gmail.com>
Subject: Re: [PATCH 1/3] acpi: fix struct acpi_xsdt
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
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

On Sat, 11 Nov 2023 at 06:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The size of the ACPI table header is not a multiple of 8. We have to mark
> struct acpi_xsdt as packed to correctly read the entries.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/acpi/acpi_table.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

It is really unfortunate.

Would it be worth adding a test for this, which actually checks the
member offset?

>
> diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
> index a3b67259e6..20ac3b51ba 100644
> --- a/include/acpi/acpi_table.h
> +++ b/include/acpi/acpi_table.h
> @@ -80,7 +80,7 @@ struct acpi_rsdt {
>  };
>
>  /* XSDT (Extended System Description Table) */
> -struct acpi_xsdt {
> +struct __packed acpi_xsdt {
>         struct acpi_table_header header;
>         u64 entry[MAX_ACPI_TABLES];
>  };
> --
> 2.40.1
>

Regards,
Simon
