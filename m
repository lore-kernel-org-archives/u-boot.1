Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D97FC2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 21:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C18D882E6;
	Sun, 23 Jun 2024 23:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VzZjGbtH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76F7288137; Sun, 23 Jun 2024 23:52:27 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 643AF8819D
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 23:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b50aeb2f31so18872266d6.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 14:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719179544; x=1719784344; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7BTg5MYeXX/ZjUfT/ZfZVN/t2TxuJqv3Y0oSKtie+BU=;
 b=VzZjGbtHHtaAFyklqUxbOJBotZW3iWVOxlDrRXFEBQHAXDkD5ollJiQmvjzplxW6pn
 oAgViqOIh6A5bumL6+TcYY8cK0ir7vnHchyir5LTl4Hq/29xy5iskRGquO6rS66C46OH
 k5z2iYfiqxDlpV5kI6scMVSIeUXlNWG+Wf+u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719179544; x=1719784344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7BTg5MYeXX/ZjUfT/ZfZVN/t2TxuJqv3Y0oSKtie+BU=;
 b=IVYZTjsXFL6IhLSUiuoQwAm8SEvTyF2ByCjzdkLzGZnp3I8tJjbGsgml1M7xixxO+M
 7y3AUhT7CBTr+/E9KkrE+i9l9OiBnwRiTQ95txBqRcMgcmfgBnQEbIt78DFsj+9cmON2
 69msFO/8Gf7jb5OPN3obumY1mdpmdiAlqS7/a6pE7vISPqvpN4/9H5RUUKBpbQIJMv7P
 bOmToeY4VwBRjjaniHEWsDsoMBT1xMSLEZu2ud9zDEwqnqpJd2ycLKHvagNaKjYfwCJx
 Mtyy+WaAoBP0bakjkyYveGZAYJ2iRkQ1Zke8W4A5ITEksJcqbE3KB0DxgK95BBj5mf11
 XHPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU87mfgP8usq3r3IdqL19Yc3KCENtZ6kA8Czfu/ASA6cUfUcS16mlOSJyXH8L6hP1nNqfrDYW/m8jyZjdUd/pI0+4j8vQ==
X-Gm-Message-State: AOJu0YyuOfyxVnKtW82zCI3GR4/KzpEDthAFFeOfHJWuw4MABEtR6BhD
 mwm6FU/VN7O7SogKmNRcchOkXIpPcbzrdBNM3tuOWB18PjiSnjeqi/rUA/e+tks8sFYv9WuJ0BF
 bwtjAgF3Iieoi9yH0qTFjlq4lQyCSqNq6dt7o
X-Google-Smtp-Source: AGHT+IHlC1gHoNhKdJfEIQcYP44PGvrFLGvSnob4T33nQAOdDsA+T4gE+UYOdLXKEy9l1SjafqSCeIevtl+vPk9kf7M=
X-Received: by 2002:a05:6214:5094:b0:6b5:41cf:c402 with SMTP id
 6a1803df08f44-6b541cfc462mr33353946d6.63.1719179544255; Sun, 23 Jun 2024
 14:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240623114838.14639-1-ilias.apalodimas@linaro.org>
 <20240623114838.14639-2-ilias.apalodimas@linaro.org>
In-Reply-To: <20240623114838.14639-2-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 23 Jun 2024 15:52:13 -0600
Message-ID: <CAFLszTg+OA3Dt_9Yjiu5X=Rhnt5g6HRcXQYopg_mQVnyp0=2iw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] tpm: fix the return code, if the eventlog buffer
 is full
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com, 
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Michal Simek <michal.simek@amd.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

Hi Ilias,

On Sun, 23 Jun 2024 at 05:48, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> We currently return 'No space left on device' if the eventlong buffer
> we allocated is not enough. On a similar check later on that function
> during the call to tcg2_log_init() we return 'No buffer space
> available'. So switch both error codes to -ENOBUFS since we are always
> checking a buffer and not a device.
>
> Fixes: commit 97707f12fdab ("tpm: Support boot measurements")
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/tpm-v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

For better or worse, we mostly use -ENOSPC for this sort of thing. But
this will at least make the TPM error stand out.

>
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index a67daed2f3c1..91526af33acb 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -554,7 +554,7 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
>                 if (elog->log_size) {
>                         if (log.found) {
>                                 if (elog->log_size < log.log_position)
> -                                       return -ENOSPC;
> +                                       return -ENOBUFS;
>
>                                 /*
>                                  * Copy the discovered log into the user buffer
> --
> 2.45.2
>

Regards,
Simon
