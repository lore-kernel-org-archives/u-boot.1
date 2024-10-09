Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF617CEE350
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 21:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A09588E2D;
	Wed,  9 Oct 2024 23:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Iwg0IaJA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CFCD88DDD; Wed,  9 Oct 2024 23:14:26 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F5DC88DCF
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 23:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cbc5d17c2eso2094776d6.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728508463; x=1729113263; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pTTQ3ln1LCoSsQ64QAgvIjjEXvUdpLIH0ALXPGK17tI=;
 b=Iwg0IaJAxPK1y7kjmfywS9y21aRo0Pwe3FP+s9bMcveJPh3Q+14yltp9xIYDotcqPh
 9VpHJXEPwOcmfQCfyjery1o39D/DXFH4jDCFmFL5jZ6ENNUgBnO3arNU477Vv491zjYS
 nGVZMm2KGPOrvmai2GBcardNc17lIaiR2l6Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728508463; x=1729113263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pTTQ3ln1LCoSsQ64QAgvIjjEXvUdpLIH0ALXPGK17tI=;
 b=v42utvFbHn2VbrZ8CrlixV53teP4dn8en0+dsr+zvX989E0pTFnIBFFzDv5+IXl16W
 CnTN5R6T58DjHuMVC8irFikWZjFO32r/m5Jt/7EOBPVkPQisDuclV+dOOHQjw35Kk3Mt
 F7cIB/ZrcoGwT3G50xe8ZUE7qr/niN8tD9nBL1S7XnnjRMTvMpte6XHnSe0mAGN3xNgk
 cUpc7RjFEcT3pCb8rtjV5YFTPBwIt9z8QTWMGViWGg4KAiQVbCp76soDaNTo1uEkxRhA
 ICf9SYApHesVMSlClQST7h90rhSD9mj7RQbXNH5i0g7MBB2P89VCi4asvMdAm6akjsDJ
 l1HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmxw6k2zDo8kFheAFCsCr9Mi+FFysNWX/+pTaODmTUsVCbB+m8zIYGXfnupWmGYVM0e2Dewqk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9Yyx12FzO44vggpod1ogOmTZSI7hKBm/bWjY3w+No+iqWizje
 pUL8u1nd79Irr/YgNLuBms0MJCOweidNswVXDdEP6s7HGceRWhGVTbaAjwjs6FVmUFqnpB86V8+
 qrIuUW9gsFOFIF0GeP36ZwiHqDftcKP5PYMlp
X-Google-Smtp-Source: AGHT+IG0eXq076RA5YIABVJRWMpihiRB75MtcvZklD7egNnBmPvaRkNg9hznnbjLGXG83OcYZF6TL7CYFJLSN7iTOKI=
X-Received: by 2002:a05:6214:4402:b0:6ca:756d:68a8 with SMTP id
 6a1803df08f44-6cbc9304943mr51619836d6.15.1728508463273; Wed, 09 Oct 2024
 14:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20241009115552.31455-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241009115552.31455-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 9 Oct 2024 15:14:12 -0600
Message-ID: <CAFLszTiB8=SDPz2Tz-J3JUdVaVb2iHaE0Oj=84hmxZ6oEZKFPA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: Show the FirmwareVendor and
 FirmwareRevision in helloworld
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Wed, 9 Oct 2024 at 05:56, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Show the firmware vendor and revision to make it clear which firmware is
> used, e.g. whether U-Boot is providing the boot services.
>
> The output will look like
>
>     Firmware vendor: Das U-Boot
>     Firmware revision: 20241000
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/helloworld.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
> index 586177de0c8..f9154386472 100644
> --- a/lib/efi_loader/helloworld.c
> +++ b/lib/efi_loader/helloworld.c
> @@ -71,6 +71,33 @@ static void uint2dec(u32 value, u16 **buf)
>         *buf = pos;
>  }
>
> +/*
> + * Print an unsigned 32bit value as hexadecimal number to an u16 string
> + *
> + * @value:     value to be printed
> + * @buf:       pointer to buffer address
> + *             on return position of terminating zero word
> + */
> +static void uint2hex(u32 value, u16 **buf)
> +{
> +       u16 *pos = *buf;
> +       int i;
> +       u16 c;
> +
> +       for (i = 0; i < 8; ++i) {
> +               /* Write current digit */
> +               c = value >> 28;
> +               value <<= 4;
> +               if (c < 10)
> +                       c += '0';
> +               else
> +                       c += 'a' - 10;
> +               *pos++ = c;
> +       }
> +       *pos = 0;
> +       *buf = pos;
> +}
> +
>  /**
>   * print_uefi_revision() - print UEFI revision number
>   */
> @@ -96,6 +123,16 @@ static void print_uefi_revision(void)
>         con_out->output_string(con_out, u"Running on UEFI ");
>         con_out->output_string(con_out, rev);
>         con_out->output_string(con_out, u"\r\n");
> +
> +       con_out->output_string(con_out, u"Firmware vendor: ");
> +       con_out->output_string(con_out, systable->fw_vendor);
> +       con_out->output_string(con_out, u"\r\n");
> +
> +       buf = rev;
> +       uint2hex(systable->fw_revision, &buf);
> +       con_out->output_string(con_out, u"Firmware revision: ");
> +       con_out->output_string(con_out, rev);
> +       con_out->output_string(con_out, u"\r\n");
>  }
>
>  /**
> --
> 2.45.2
>
