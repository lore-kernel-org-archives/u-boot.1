Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099D0CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCB7686E11;
	Mon, 16 Oct 2023 23:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e7Ms4XKN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B55886BB3; Mon, 16 Oct 2023 23:55:09 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FB638669F
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9a58dbd5daeso815098766b.2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697493302; x=1698098102; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3YWkWP3Owg3i41gWopwE0/+zhmjQO0vcIbH3BO7MAoM=;
 b=e7Ms4XKNzUPDZnbg6HOwmY5byFC72/EGXdPSfOfVAvhVfdzowwZAF16PejrwKGBZ93
 WUuzKaFt+1+FD6mlM7oJ99VUKBjoDhBOtc+2U9W5i5i31jqrfV9Z9WSJf7ain4UN//LI
 L4esze1HI8n1wgPe2sI3JOkTJX2am5n64xU5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697493302; x=1698098102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3YWkWP3Owg3i41gWopwE0/+zhmjQO0vcIbH3BO7MAoM=;
 b=mTrkdpH4ne3Ejf49DULWKD/7IWFiYNKyxmajbYoN5zwEX+QLCYaLLcyVynmVRENCi5
 4DlUJHG/tOEOcbsWpBcmiUWLeunZ3mdE7nbktci3VtnQ8cx2+N+ZweFkn5XChYDZOIgh
 YBMYZAaJ0pP+8Q5zkZh1Ohb8Zvw+R2jeLJ3qInTX1Y/uJkTaicxcHDvM88DCVZfYjNU4
 FF1xpYFsEKPwZ5qR4h6qbBXv66Pv3TRrCcqfMh/6uHqWwi8l5WLl5Y0S8QGOOfudlkGp
 ksWA90y+l0N6RsKFXtYRYSOotxYgygwclvCDXZ5h4AuKtJhXvnC87ut52YAf6zIX+UMd
 90+A==
X-Gm-Message-State: AOJu0YyH0UK7aTtJvy5eJrZAGfWXhKoFd7eFrQ8Yvm4XMS5mnH6KIjtf
 A3pxz8fPFgSLjTFhu4F//zZLBubJ9HBgfyaMTla/2Q==
X-Google-Smtp-Source: AGHT+IHAmqOPQrxyKuFnx8OxPn+i6XHCY/fekvnXEaPGA1dgJCKjekL5jGeRx565wf58P51KaGSoRw3i4rMnBFEMrLk=
X-Received: by 2002:a17:906:fe43:b0:9c3:70d5:dc57 with SMTP id
 wz3-20020a170906fe4300b009c370d5dc57mr297993ejb.40.1697493301910; Mon, 16 Oct
 2023 14:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231016083522.945453-1-rasmus.villemoes@prevas.dk>
 <20231016083522.945453-3-rasmus.villemoes@prevas.dk>
In-Reply-To: <20231016083522.945453-3-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Oct 2023 15:54:49 -0600
Message-ID: <CAPnjgZ2=5VLHvkr1fNQBDE=3FGPG8gzYjYDbz9yt+WtvH=BrHA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: introduce CONFIG_CONSOLE_FLUSH_ON_NEWLINE
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Michal Suchanek <msuchanek@suse.de>, Marek Vasut <marex@denx.de>
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

On Mon, 16 Oct 2023 at 02:36, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> When debugging, one sometimes only gets partial output lines or
> nothing at all from the last printf, because the uart has a largish
> buffer, and the code after the printf() may cause the CPU to hang
> before the uart IP has time to actually emit all the characters. That
> can be very confusing, because one doesn't then know exactly where the
> hang happens.
>
> Introduce a config knob allowing one to wait for the uart fifo to
> drain whenever a newline character is printed, roughly corresponding
> to the effect of setvbuf(..., _IOLBF, ...) in ordinary C programs.
>
> Since this uses IS_ENABLED() instead of cpp ifdef, we can remove the
> ifdef around the _serial_flush() definition - if neither
> CONSOLE_FLUSH_SUPPORT or CONSOLE_FLUSH_ON_NEWLINE are enabled, the
> compiler elides _serial_flush(), but it won't warn about it being
> unused.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  common/Kconfig                 | 10 ++++++++++
>  drivers/serial/serial-uclass.c |  8 ++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
