Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8CFC2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 19:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FFF8884DC;
	Thu, 20 Jun 2024 21:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FLzNqcpB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FC7288532; Thu, 20 Jun 2024 21:20:26 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B79088126
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 21:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-681ad26f4a5so794763a12.2
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 12:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718911222; x=1719516022; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bf5cfr2F4ori7yPnh6I9ev+ME+j830JkF8En1IzuFw8=;
 b=FLzNqcpBJsPfumDiWu9e8rPwHpwRYMgoRfAJHzEm9QwKH/JJLrV7h8HWkiak+s2Coe
 B6d28/NbAEoDOO20mFV4UocguJW3UQXDXE4J5M8Z85iyCdIg268MMyp4l5GQj0cDZbTS
 slNqmO0FvCd5ZhCzWzLFLIE2+qPzOh4Uwa9VE6V0qYpS9JZPs8578E8MdAZLmCDO+g9t
 wY/afOJj57p6x5fBoT7biNBLv+vVGd3ji980IQx7JiE44suyIiJQufDmHTRtteCEp8+f
 TRdT4Bq3Ll2DHMsDUwly1hpYRfjlZXft/RnRZmE3KVeWEK+RNz9zV12Dl+KBaxAp/3lo
 GG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718911222; x=1719516022;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bf5cfr2F4ori7yPnh6I9ev+ME+j830JkF8En1IzuFw8=;
 b=hilRGd+hXMQnIO3Bg0BMu+BDASjZ3vSRwHOEER/biv+94EGOLs/0cVpGtMx/y+w6jr
 ECSCpojcXjX6EstYcHvMuaONxnYATH9eXmS08h2MdsE1ZG5b6lmeu94s6tlXNDR35BI+
 lO2ue6N7Oha6IVrFHnvR0kK4vDjC4egRLmkgYK6C9aOvUh9rSW6MS1glsz4PUcUWneMp
 8H0107VkgcCaiw9K6F4bgnoVFNxVsDaM3VU0rP+uhJo/Tl0iwZ/4dlAiRnzMFpSEoHFw
 ObDvbi1efWokV38fOGXIfhyUatQRxglOxGi3GaN0xjH8IMYQ+MkwRusHbipSZTG81fsX
 rbjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2pHL8xPbBpf8bberZt1ZnktHHeHOIwlls9xJocUtVaI9dvrR3/JnK2Nk3G/uAzP95i241WLhISECOASzF8sqL7qKuWA==
X-Gm-Message-State: AOJu0YxMzyMaxvT0f4XWdwtLmyOpbtk5uukWLYH5+6aVNL0WOBv/6Cve
 BLT4qLfErUKJNpBIhSAnWNXnH6Sd7f7bDAZg8drVZe2HcFoXgMMm0gi82lbptFSMqE2QDXPQZoT
 yRV+6lkZE+BJHQ3Z1jR8ZosHk2h6RL6sIt4ag1Q==
X-Google-Smtp-Source: AGHT+IGjD8XS4gKvWCN3p7vVH9ObDoloCLkOGCQQnOWxbUburyYnNODa36UA4meYX8ErVgf2+1BaBFzav2p+Yst+pdI=
X-Received: by 2002:a17:90a:e40b:b0:2c7:5622:cf02 with SMTP id
 98e67ed59e1d1-2c7b59f8783mr6324718a91.2.1718911222400; Thu, 20 Jun 2024
 12:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240620191631.28811-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20240620191631.28811-1-ilias.apalodimas@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Jun 2024 22:19:46 +0300
Message-ID: <CAC_iWjKafGj7wMtWAD0G_g-ArfQBoL_22oWjo69jjzjOvC030g@mail.gmail.com>
Subject: Re: [PATCH 1/2] tpm: Fix return code, if the eventlog buffer is full
To: xypron.glpk@gmx.de
Cc: Tom Rini <trini@konsulko.com>, Eddie James <eajames@linux.ibm.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
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

On Thu, 20 Jun 2024 at 22:16, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> We currently return 'No space left on device' if the eventlong buffer
> we allocated is not enough. On a similar check later on that function
> during the call to tcg2_log_init() we return 'No buffer space
> available'. So switch both error codes to -ENOBUFS since we are always
> checking a buffer and not a device.
>
> Fixes: 97707f12fdab ("tpm: Support boot measurements")

and now I wonder why checkpatch didn't warn on this. There's a
'commit' missing after the Fixes tag. Sorry!

> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/tpm-v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
