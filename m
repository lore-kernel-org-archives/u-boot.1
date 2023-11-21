Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9624BC5AD4C
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF10875E9;
	Tue, 21 Nov 2023 03:17:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T2zo0Lgi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FB17875E9; Tue, 21 Nov 2023 03:17:27 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6252D87584
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5c9ea2ec8deso19723147b3.0
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 18:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700533043; x=1701137843; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fv3mYhjDSzdmxJyMG5tjNXFES5UfYKl3ZJ3N4qfRjig=;
 b=T2zo0LgidCXNTIX3t+9rMQpoDz+brJjY3l3uK7rcSa0tuI3BWFJFWASt8qlP+g1vBh
 Ha6rg/A5lOjsIx4vREZPU05VpJ8cT76NRJad9jRDMLtVNzd0LqO9LV0d2QY6E2OPiesH
 L4sgxc5xMics5xs2DcJVTlAltuYMrdBWUVscE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700533043; x=1701137843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fv3mYhjDSzdmxJyMG5tjNXFES5UfYKl3ZJ3N4qfRjig=;
 b=NEi4mSqb8K1Jio2fzt6+RSNshcZEK4kWPsMkvgnoci7DHg8J1Hnq8YW9rI+Q+CtM86
 w4KMhyflBwCYov9UMQhXM7z3n9XTLn15TISA3wkc5/7z8u79o+Ty88w0Ub8OigNNWxmL
 y6WQfF1wZghxXsp2wrxsp5hH7G5BuzF+ijGJG4OYdh8C4lQHgTY4NJO3J8K8ZKTUUHix
 uxa3I/NQYhnOke242uxXygzKv1U9FehssF/7+RkihAoWzSczfdhNKzUL1Zrxsh4woO5P
 Go7wVHb+uJzGFmEcXVJtv6aqV8YSEufQUH/QMkd3GIgZhE+r5PWD8NkxrA+AQFI4l48T
 FU6A==
X-Gm-Message-State: AOJu0YzBHzHn83smhD+LQIijHFih9q4VRMSAqCcEEeK6UjbLhf4H02+p
 fd9CxtkF0X5+bMzKRAxIr4vc+gLf3pPp6kPl/XDgsQ==
X-Google-Smtp-Source: AGHT+IF9VUCQUKCzXSUE1jNQnxhwhU/P4bnOBHvVoHAV+SDyb8YDUOPAInlX9yfnujDh/ot9dVpLEYMop7xejmHVZ0w=
X-Received: by 2002:a81:bc4b:0:b0:5cb:23:d28f with SMTP id
 b11-20020a81bc4b000000b005cb0023d28fmr3232780ywl.14.1700533042946; 
 Mon, 20 Nov 2023 18:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20231120201609.619598-1-trini@konsulko.com>
In-Reply-To: <20231120201609.619598-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Nov 2023 19:16:06 -0700
Message-ID: <CAPnjgZ3mHpFXEsEENT348SynV2FfZ3ckXHoyFQBfknPC6+HPCg@mail.gmail.com>
Subject: Re: [PATCH] libretech-cc: Populate SMBIOS information
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 u-boot-amlogic@groups.io
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

On Mon, 20 Nov 2023 at 13:16, Tom Rini <trini@konsulko.com> wrote:
>
> Enable CONFIG_SYSINFO_SMBIOS and populate the nodes so that Linux can
> eventually display this information
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Posting this as this was the easiest platform for me to test some SMBIOS
> related patches on and I needed to populate the nodes so I could check
> things in dmidecode once Linux was up.
>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: u-boot-amlogic@groups.io
> ---
>  .../meson-gxl-s905x-libretech-cc-u-boot.dtsi  | 23 +++++++++++++++++++
>  configs/libretech-cc_defconfig                |  2 ++
>  2 files changed, 25 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
