Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3736ACD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 21:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CFAF848B4;
	Mon,  1 Jun 2026 23:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CKymkJQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9842D848C5; Mon,  1 Jun 2026 23:13:13 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1D684894
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 23:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bed4cc46252so230594766b.3
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 14:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780348391; cv=none;
 d=google.com; s=arc-20240605;
 b=RdO9gzTZO+sx8MVHOpIhajC0a5ufTok4JxGan/KDUkuDUd9Xx77BXJQ20n1HzA9LTG
 fUgaP14vVG3oSjK5PCHb/F6ib2Iw1XsorL4NvhzbulsUp/IMXp6/KAvAM5FmKygHJKz/
 TeoNkwNYdewpb9h6dHyzqn2qIP+er4e+GpoFkrv0lCq0ftRkD64AGGWH9DJFNuXJSqwM
 P9JcL0VELp7UsFx3L7UqBuju/qYwgT506dVBE55RMxh2tAYMdhIFyJS3IAUxVhk7pVXR
 vGHbLwUze4qJ/wLhEHWuGDY2atGXpiWwTFG+8z62RfgtIgwyDir6gZ4IMm+u0TSidwNg
 bm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CGZPwO/lOhqeFiDywG6yy1fcA0APOmNj5Gil2WxZgBs=;
 fh=t3/TrjUs7RNfwmTeskIoVizcV7KuRbfgKqNpVyjH70U=;
 b=k6gxfjgWbZSW4cXdMExR8Lp4i/zjmp9OLTmNhpbCwkJmBttHQunPMpkyXD+1lANap5
 5xoD8Siz3ahRM9IQtwFmUJLZ4hX0YRGveRi4jRMjbZRPv9uQ1m3rZebAIVIUnHdjiweX
 6MKP5g16ZsUeJ9H/hqvlVIPGeqADEUMZ9NLPKJQTIlkUdkAlPG/GPsJKqld0dXB4DxE3
 oQdG5r8yf9VXVIgSmijldaj2tTCdKlRQuFTHbxFhVWKdBXZHCaZDpjqpS5xj9biUtSXj
 6tssurNcr7GU7xlttyAM6u99i0mxesrO/f+1yEGjrsQiXcuKUUUJLjKGz4DZkfAqhK/z
 Ewog==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780348391; x=1780953191; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CGZPwO/lOhqeFiDywG6yy1fcA0APOmNj5Gil2WxZgBs=;
 b=CKymkJQ2gW3XTSjXOWbtr217h/RTEKkhvn6kR14wgGuudgBKdi31ApDD7jsWeo/qwG
 Wg3u323mOmlXRvGkkTV25d1URUbS6M9bPExn3AU2KI+eIpKE3zj3E9hJOkT2GoepPPfM
 fKlnvHHxjBsm0mvzCO2czWAMeByImUIm0IAvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780348391; x=1780953191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGZPwO/lOhqeFiDywG6yy1fcA0APOmNj5Gil2WxZgBs=;
 b=CvFgc+6ixkS4gDu9eXfPIjIiQn+Yqq7njos8XYqt5jNfeZfptQ0aKuFpJjXcEW9Ghm
 buIR08ZCDgb3aL/cB3UHyR5QGmN/zMJMYHJy0A+i8FEwUgXShaA/Oqvfdm8D8cyRImKD
 YPJeAjI3zr58GtJ88MNrTI/qhIVwO1owbUOpl+MmCGojS77PaZDITny72eOYadSTHDHr
 SBpsoOpXsXKLqTdwbr0QNV1uRSzcNraIWMKr4t5Pn1NL8s0c5g1opO81F3v0cXHDQFlV
 QU4odLIG0vuJIYhfvCwR1Wn8Eyr4NgCBF1c/sN42PmDjd0ssH9xW5Ze5tln940XTr1OS
 YP9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RZqnicrKjm910Uievm3U+/XAjfDgyRV019fH1iPo9vozl9JAbmHuIKusFvMg608DcYuCfvKU=@lists.denx.de
X-Gm-Message-State: AOJu0YwT2j3N7IBmpjE+IGaquVQ7RbKL7olla4YYk1Fqrn/Fvml6gi9e
 9lTnj5mYEY02n/B9Rf+dgf70X04e5kRzGdyo7l6+i55EUlSjLETEpPpoZDi6CzHwUy/SqKor0/t
 6V7Obs89nXEVtG9Z9exPiO4RWmX4yuoImS0ryH4Q2
X-Gm-Gg: Acq92OEVT4ReiC1Aig8f3yllKfNB+hAMWQYhb4VQc6NYscBGMfzYO+B8mX4Qi8xw7ce
 l2JNBQmvibtef3CaE/Qcoy884Fak8TCzMERQKltKxNBPRKImtJsMs+dRxH+yTomok1Ar9J38F67
 l/1NoNcSsZgb+vwWOalH0aYkd1ndUYLNZUulb04fEqXOQUgOairK7RRkfzyF8+zFixRRRVW4NFc
 MLQmdctR7NE2t0Hsvj4m1lTiBb8qRXSIbVQgUHn1c/EcSBWDxswnQoOVK9snEFWxYKxUft3D3nF
 0TKjvqFAiVvNLBlj50c8meNnmFY=
X-Received: by 2002:a17:907:9484:b0:bee:215e:546e with SMTP id
 a640c23a62f3a-bee215eac1amr298203466b.1.1780348391161; Mon, 01 Jun 2026
 14:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
 <20260527095123.50797-3-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260527095123.50797-3-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 15:12:59 -0600
X-Gm-Features: AVHnY4J6d6nan_RNCZlUBGcF2KrwbJ_opGfxHnIfyoDvlrqrKxZIXmZfM7y6oaM
Message-ID: <CAFLszTgtmOD5LB2rN-JL79i5WiE2zBGxSXWpMgL8sEhM0g3hwg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] sysinfo: add sysinfo_get_and_detect() helper
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
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

On 2026-05-27T09:51:17, Alexander Feilke
<Alexander.Feilke@ew.tq-group.com> wrote:
> sysinfo: add sysinfo_get_and_detect() helper
>
> sysinfo_detect() is commonly called after sysinfo_get(). Make the API a
> bit more convenient to use by introducing a helper.
>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> include/sysinfo.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

> diff --git a/include/sysinfo.h b/include/sysinfo.h
> @@ -373,6 +373,26 @@ int sysinfo_get_data_by_index(struct udevice *dev, int id, int index,
> +/**
> + * sysinfo_get_and_detect() - Get the sysinfo device and run its detect
> + * operation.
> + * @devp:    Pointer to structure to receive the sysinfo device.
> + *
> + * This is a convenience wrapper around sysinfo_get() followed by
> + * sysinfo_detect()
> + *
> + * Return: 0 if OK, -ve on error.
> + */

Please keep the kerneldoc brief on one line, as with sysinfo_get() and
the others in this file. Something like 'sysinfo_get_and_detect() -
Get the sysinfo device and detect it', with the rest in the body.

> diff --git a/include/sysinfo.h b/include/sysinfo.h
> @@ -373,6 +373,26 @@ int sysinfo_get_data_by_index(struct udevice *dev, int id, int index,
> +static inline int sysinfo_get_and_detect(struct udevice **devp)
> +{
> +     int ret = sysinfo_get(devp);
> +
> +     if (!ret)
> +             ret = sysinfo_detect(*devp);
> +
> +     return ret;
> +}

Please can you put the implementation in
drivers/sysinfo/sysinfo-uclass.c alongside sysinfo_get() and
sysinfo_detect()? It keeps the uclass API in one place and matches the
other wrappers.

> diff --git a/include/sysinfo.h b/include/sysinfo.h
> @@ -438,6 +458,11 @@ static inline int sysinfo_get(struct udevice **devp)
> +static inline int sysinfo_get_and_detect(struct udevice **devp)
> +{
> +     return -ENOSYS;
> +}

Please add coverage for the new helper to test/dm/sysinfo.c - at
minimum a call that returns 0 and verifies BOOL_CALLED_DETECT then
reads back true.

Regards,
Simon
