Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BE3E74911
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 18:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27980871A2;
	Mon,  2 Oct 2023 20:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iBYOr3sH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 956C98719C; Mon,  2 Oct 2023 20:56:54 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4500869C8
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 20:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-533df112914so53233a12.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696273010; x=1696877810; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/Ct7G1SYU0k5FxrV+2PLjJZZoAGDKfSRVN0CKjKYhS4=;
 b=iBYOr3sHF3HU0CiL3gTBzu5gdGaRzhMe/5PYP6JvHjTNsC4RZLJ/xaDiyTYtX7CH0t
 04sFzU2J0Y6QkMecxaCMvJLLrOTcZNaLMmVdEsaf80z4RTqkuIhJ/oSR2g83aCcK5zKJ
 uSwKu5MoLvPQIUTGmjOg/SUta1MdbSYDjj8bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696273010; x=1696877810;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Ct7G1SYU0k5FxrV+2PLjJZZoAGDKfSRVN0CKjKYhS4=;
 b=XyOWXToVfur9APFfGbumhT9hIXmy9yXuOW0w6Uc9/WuAzbAaV3EaWv5iulpbj8KuC8
 9TKF2NVbhjf3In1kvTn5gU4v3DOGpNz1myv7O6aq0buCdkxI5Wf65WrmW5KDc7Lil/oc
 nfpdOjExMmVj0JRnVCBK8Bhbu5gXf9UwkC4/ftYpBCRVdhvQ7O2JRifOB9R63/+3H2mL
 qIFUnJ65bXarxKkdntozjddMH8U/KZaqjPIspcXh6LO9+ST4/4GGZGD2YtYttfbEz8Lj
 B1GyqLxyHXUMRb0Bhox1EqRaeEodu51g0NqFsgi5+2gMTbv/lyS1ibBAGkLU3OuPs69e
 QlSQ==
X-Gm-Message-State: AOJu0YwZ89+0dGcPXlbWdLXYytI0VkLPSRezaawBKwr/lUbrn78NVeED
 ck17yrRTAV3X2MLDljJQSMpAZZlw+LjnxR+6QI32Du3YiKuK72J9chc=
X-Google-Smtp-Source: AGHT+IHyFiKPzKQeKAuS1iSPGRTMQ5Wd7M7RdrcH6x8iXoAJZr18t1NZxRiIv6yx6VAnC/5fru7KvUHVyYi0gBOrotE=
X-Received: by 2002:a17:907:75c2:b0:9a1:ddb9:6546 with SMTP id
 jl2-20020a17090775c200b009a1ddb96546mr10456935ejc.61.1696273010260; Mon, 02
 Oct 2023 11:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
 <20231002152142.76516-5-detlev.casanova@collabora.com>
In-Reply-To: <20231002152142.76516-5-detlev.casanova@collabora.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Oct 2023 12:56:30 -0600
Message-ID: <CAPnjgZ2pYB9vn-+P-g3dctyZFU_b_MpLM66O8pimtrKMnswJ4Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] sysinfo: Add documentation
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>
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

Hi Detlev,

On Mon, 2 Oct 2023 at 09:22, Detlev Casanova
<detlev.casanova@collabora.com> wrote:
>
> Add documentation for the sysinfo command with examples.
>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  doc/usage/cmd/sysinfo.rst | 56 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 doc/usage/cmd/sysinfo.rst

Reviewed-by: Simon Glass <sjg@chromium.org>
>
> diff --git a/doc/usage/cmd/sysinfo.rst b/doc/usage/cmd/sysinfo.rst
> new file mode 100644
> index 00000000000..1660b2aa1a6
> --- /dev/null
> +++ b/doc/usage/cmd/sysinfo.rst
> @@ -0,0 +1,56 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +sysinfo command
> +===============
> +
> +Synopis
> +-------
> +
> +::
> +
> +    sysinfo id <varname>

[<varname>]

I think, since the params are optional?

> +    sysinfo model <varname>
> +    sysinfo revision <varname>
> +
> +Description
> +-----------
> +
> +The `sysinfo` command is used to show information about the running system
> +
> +The `sysinfo id` command prints or sets an environment variable to the board id
> +as an hex value.
> +
> +    varname
> +        an optional environment variable to store the board id into.
> +
> +The `sysinfo model` command prints or sets an environment variable to the board
> +model name as a string value.
> +
> +    varname
> +        an optional environment variable to store the board model name into.
> +
> +The `sysinfo revision` command prints or sets an environment variable to the
> +board revision in the <MAJOR>.<MINOR> format, where MINOR and MINOR are int
> +values.
> +
> +    varname
> +        an optional environment variable to store the board revision into.
> +
> +Examples
> +--------
> +
> +::
> +
> +    => sysinfo id
> +    0x0b
> +    => sysinfo model
> +    Renesas Starter Kit Premier board rev 2.1
> +    => sysinfo revision varname
> +    => env print varname
> +    2.1
> +
> +Return value
> +------------
> +
> +The return value $? is set to 0 (true) if the command succeeded. If an
> +error occurs, the return value $? is set to 1 (false).
> --
> 2.41.0
>

Regards.

Simon
