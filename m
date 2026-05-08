Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161C4CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 17:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A839084DC5;
	Fri,  8 May 2026 19:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b5sqpMiL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34D8384DCE; Fri,  8 May 2026 19:59:18 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AFDA84DC4
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 19:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso941490a12.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 10:59:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778263154; cv=none;
 d=google.com; s=arc-20240605;
 b=GWrlVzgb7WGDfSrlS8fFPjeig6Ym2/ZOgnnEsRPPrYX50QiQsvoQ9X3tBw1y4Q4TXL
 i3CXfvbleZUeoGstJjNGiRXVyz8Vwja9SWC+7y4H+2jeM5LSFz3cn1teCS1oiGcq5e8c
 g53O7ToKm1eW7kR+jbNhdRP26OVaYOb2kCnx9gwWfbRXRAFC1sSHYU5qfNZPeXYPEAX0
 +TVcIwb+DWznMBoTxCTZA/D3BQsnJ66NEM3ReGsRHLwkQJsCDn7awRT6OR4p3tDC/tv+
 /zfa3mha7nY+nj58azp7SDyqqsjkoR6c6Rg9W2czKTK03QWZ7Kh4aKKlFgEvoPtErT88
 zTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AkyEyuBQuEe42OGk9Eak9OdZ6Ls27l2A/3rdiNbid5c=;
 fh=UGsLeeC1AcZOX8WWJFDoNj3PJmg8a9DA4NYbCTpcfgo=;
 b=CA+CfGI7nGByVw5dZFuQ7FeZ5s+R72oBt2cXPcfB/P8EdGBdirrq5UP1H4e6d93FaQ
 R41cnWoIGXdW/NtQvnS3vlSP9oxjw0i/cX4b2bxMVn2uAnfEWLJl+6SF4m45jZ/20hVf
 QVplgM4p/gtk7RLraHqxHTTwSZLVgZ58eyzuO+EpjozNYDaUW4e79yTiRRIG1eyy0HfE
 KJZ3iC0UmdfOfr4UPJ54S+dM9XbOfmFmTJPLKrTviUwYLdtFIcebetrXOpcw87VLF8PO
 pMUDPqH5lsxBFC2u9xkSAWU3/ibeLkjWCmj4w0xEgo5yK9aovHF0CCw/Wz2jrSCrpdGB
 lICw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778263154; x=1778867954; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AkyEyuBQuEe42OGk9Eak9OdZ6Ls27l2A/3rdiNbid5c=;
 b=b5sqpMiLp+aFbbcNS5OII96XKbhApjkjVvRlTwkzOJjlW+OZfAJyIC7DQBEHJeE4e/
 9XRVnTkjD2GdueGAZr/9YJdwiCoxkxnD1dnFlRaDm1K+NCqBqp/lsl8ngOd2Del58GUo
 6BRyIxROAxkg41izcqP0v8UwzjbXA28qFR/Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778263154; x=1778867954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AkyEyuBQuEe42OGk9Eak9OdZ6Ls27l2A/3rdiNbid5c=;
 b=FqePQP5Nix2ec93n6Q0NFPr8I3cjCX7U9xbS5K2jyov9ODU+KQzOE62JOzRwf+YwyR
 QahYhX1It3Xm2OOAPGiIoH0sSUe4g3yGFNtBsfrooErwisOLxxBdpaUZ/cMZcZ0lcE4B
 BU3lXM7v6JcOAAfWWfeif9h1Go/CwSatwGI3sYusFCimC9PJmeZUwMX9+ql7vaqlgZlv
 akNPDxBMC4VzVMINelHfpKLAiDfNPdpQpkeVm6jk/WCgZKtNVHBrMm5r1b9cuCHwaM1k
 CKPo7xR7hXGAOugEouMVaN3uYrsJUnr7HH38X9bhjYQ/8xzHy1XQxAfybChJK2QzFWKD
 Kt/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+LmS9rB+zWO7cfbWptN7J5hGjofen1/EnqBSvYyrK1OEiQ+5D5pjfJLINZLQmqysijf0D7YCw=@lists.denx.de
X-Gm-Message-State: AOJu0YxdpiZGcj2XXc5B50YfnybtlGjVzL9YFmdEJtFWU/K/7DWflaw2
 6PPS65OfkljV+pO5deim6am4z2YUVJa84ED/DVIAg8hV/8M++ncvEdd5xUcMhMURJK+dMD9ADap
 io/EnEVmcqVjeLHfva/kKPEeWLJUyJBdpFMQ+YEtN
X-Gm-Gg: AeBDies8JwFfF7OidyDiLyxZWpZACI0cODPg/nyQOBS16Vr+Hk+UvrRSqXQveJoqBW3
 T8Jla27axXQkv09vaiuPx5N22Zp44gF0H4dZi+zI7YWh+b1AoeMW6gs+cKadWen16Qq31jti8mW
 PAWQIYYSrnKCNWqdfCmwH4KirtQ7mhb+Yw95hMEct3dkSTrkgQTGK3hhNKIBdN1seXAkI/1rtPD
 7kebuANGBccqh9g1PdS6kIU6jACJ66/X+H9jfeTk3TxHbUzravCjMm9EjfewLai/BB9aWhyEBJL
 dIQM7A==
X-Received: by 2002:a05:6a20:a11c:b0:3a2:f402:50df with SMTP id
 adf61e73a8af0-3aa5a9e9051mr16098170637.44.1778263154421; Fri, 08 May 2026
 10:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
 <20260508084834.45637-4-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260508084834.45637-4-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 11:58:57 -0600
X-Gm-Features: AVHnY4LVKZnz1R3XVxrHJUosXCqwu9NQxug7XR0NN4cv5U9orjqK-jPg18aiAA8
Message-ID: <CAFLszTg7DHsiQHmLo19kDjLGNoKWqAzHOn559ANwS8T5mFM3-Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] sysinfo: tq_eeprom: new driver
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de, Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
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

Hi Nora,

On 2026-05-08T08:48:28, Feilke, Alexander
<Alexander.Feilke@ew.tq-group.com> wrote:
> sysinfo: tq_eeprom: new driver
>
> Introduce a sysinfo driver that can be instantiated from the device,
> which will provide information from the EEPROM found on all TQ-Systems
> SoMs.
>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> drivers/sysinfo/Kconfig     |   8 ++
>  drivers/sysinfo/Makefile    |   1 +
>  drivers/sysinfo/tq_eeprom.c | 223 ++++++++++++++++++++++++++++++++++++++++++++
>  include/sysinfo/tq_eeprom.h |  24 +++++
>  4 files changed, 256 insertions(+)

> diff --git a/drivers/sysinfo/tq_eeprom.c b/drivers/sysinfo/tq_eeprom.c
> @@ -0,0 +1,223 @@
> +#include <display_options.h>
> +#include <dm.h>
> +#include <i2c_eeprom.h>
> +#include <log.h>
> +#include <net.h>
> +#include <dm/device_compat.h>
> +#include <linux/ctype.h>
> +#include <linux/sizes.h>
> +#include <sysinfo/tq_eeprom.h>

Can you drop display_options.h and linux/sizes.h ?

> diff --git a/drivers/sysinfo/tq_eeprom.c b/drivers/sysinfo/tq_eeprom.c
> @@ -0,0 +1,223 @@
> +static int tq_eeprom_serial_len_old(const struct tq_eeprom_data *data)
> +{
> +     int i;
> +
> +     for (i = 0; i < sizeof(data->serial); i++) {
> +             if (!isdigit(data->serial[i]))
> +                     break;
> +     }
> +
> +     return i;
> +}
> +
> +static int tq_eeprom_serial_len_new(const struct tq_eeprom_data *data)
> +{
> +     int i;
> +
> +     for (i = 0; i < sizeof(data->serial); i++) {
> +             if (!(isdigit(data->serial[i]) || isupper(data->serial[i])))
> +                     break;
> +     }
> +
> +     return i;
> +}

Please fold these into a single helper taking a 'bool allow_upper' (or similar).

> diff --git a/drivers/sysinfo/tq_eeprom.c b/drivers/sysinfo/tq_eeprom.c
> @@ -0,0 +1,223 @@
> +static int tq_eeprom_dump(const struct sysinfo_tq_eeprom_priv *priv)
> +{
> +     printf("TQ EEPROM:\n");
> +     printf("  ID:  %s\n", priv->id[0] ? priv->id : '<invalid>');
> +     printf("  SN:  %s\n", priv->serial[0] ? priv->serial : '<invalid>');
> +     printf("  MAC: ");
> +     if (is_valid_ethaddr(priv->mac))
> +             printf('%pM\n', priv->mac);
> +     else
> +             printf('<invalid>\n');
> +
> +     return 0;
> +}

Always returns 0 and the caller ignores it, so please make this void.

> diff --git a/drivers/sysinfo/tq_eeprom.c b/drivers/sysinfo/tq_eeprom.c
> @@ -0,0 +1,223 @@
> +     for (i = 0; i < sizeof(data->id); i++) {
> +             if (!(isprint(data->id[i]) && isascii(data->id[i])))
> +                     break;
> +     }

isprint() already implies the ASCII printable range - you can drop the
isascii() check.

Regards,
Simon
