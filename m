Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93ADE7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 11:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69E218012C;
	Fri, 13 Dec 2024 12:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VPqAq2DF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E27780192; Fri, 13 Dec 2024 12:07:54 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EDC7800D6
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 12:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-30229d5b21cso13390871fa.1
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 03:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734088071; x=1734692871; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CjwNKVzocZ291uHq3Mwq0vPS0Q1RpXGIxAp0bHBevF8=;
 b=VPqAq2DFR6jCjMnaJtudPxP2AUwcW7CWXZJbrqZXFvtagaXWY9rhrD0FfTVfSrAM/J
 79QwEGCtL/stURfDENWEPA430Vb3KBqxs+UWrhscLFw+yeF9guI/kWoeVThKf97jZoc+
 i9nj4MgP6+GgWOQ7shVPHu1UlVIXkLr8D464CNeUfDnN4IXt6RHvsJ71rynwWCNsQquC
 GrbBXW8OJ5OcRt2idM/o3KA1KCHvCxyR7Wyjz6Cjf6z7L+9Zgv1Z5LowYZcXn2Lo4pbw
 ssGb5rkiUKxypQKqlPWsrbCo6YaT19Cpy6B4cvyCupgPI3fifna10Z9Xh84UU7MRv3OZ
 58dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734088071; x=1734692871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CjwNKVzocZ291uHq3Mwq0vPS0Q1RpXGIxAp0bHBevF8=;
 b=Fieh7l9gwx3UAbsajisjCQiIzPsYg9T7tUwyYrijtBBEiqmshAPA3m0gJay2w5sGN0
 dnozQcXk9+VgKkfNahJQDvoPoinpsbfri7TYaI5EScNLYrdzbyhNiffJfJNqMBFYToiM
 lI5tap5oo/cP7uc8Zw0U1Imyf6IDFK4NB+CSQ1gM+3u/xezq+VE9By8n5Bgbavf01xgb
 Gjkzv4RUdcXBv10mhCvid2rUmb0kQPNBH3AXfRzGwUr3RzY3veilxgEc2rT/ggsio85k
 c2R8BM6nAHIFTG95dz4yzX8s9zN17grtk8DZHBZ1WHCw9KCLyOf7jfTqnb/jvuDlcA0F
 79Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1Zqj36M/W5zlC565LFgRQjBKYsbuaY0TStrDBbNaR1AjUyaz+9lbFXB4410eU33HxPfP2Gu0=@lists.denx.de
X-Gm-Message-State: AOJu0YxqkwUL68EuDX6BdBhfKSU4o44tl2WPHneqDCYnfAyahGO35qxu
 rV8uOFBYXbzaA1yta3NvMlE23CCdQ3VVOztyKsP3io7bxfD6dZZ00j8s6TlJb8OJqdyXK6TTF0W
 Ccq9KYbtIvi6z5jnxbjr3WGp7Sk8=
X-Gm-Gg: ASbGncvPQdymr6V5VWRRG8BvWassNLJ/t8CfEadlJEVqzxOAI/2LuyPpEOkkNFSyelF
 Mcq2sKWio5Y+MfQ4LAfiTrMf1VwoibpisRhOZ2CA=
X-Google-Smtp-Source: AGHT+IHBbAAm8hOI2INMxLCj5PM06dlGMuNM4QRl3mk4gpAfAVMIrocuAiNqnsRi1q9oa7U06G+2Sxtoinm9HG4QxP4=
X-Received: by 2002:a05:651c:4cb:b0:300:33b1:f0e2 with SMTP id
 38308e7fff4ca-3025442715cmr5588891fa.3.1734088071175; Fri, 13 Dec 2024
 03:07:51 -0800 (PST)
MIME-Version: 1.0
References: <20241213102321.2166920-1-mwalle@kernel.org>
 <20241213102321.2166920-2-mwalle@kernel.org>
In-Reply-To: <20241213102321.2166920-2-mwalle@kernel.org>
From: Heiko Thiery <heiko.thiery@gmail.com>
Date: Fri, 13 Dec 2024 12:07:39 +0100
Message-ID: <CAEyMn7ZkyKweyUYrmV57SxbQjOX=CXqOk21udDALv06kobOKQQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] board: sl28: fix linking with disabled watchdog
To: Michael Walle <mwalle@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de,
 thomas.schaefer@kontron.com
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

Hi,

Am Fr., 13. Dez. 2024 um 11:23 Uhr schrieb Michael Walle <mwalle@kernel.org>:
>
> We don't have a reference to the driver used by
> uclass_get_device_by_driver() in stop_recovery_watchdog(). Fix it by not
> calling that function if the watchdog driver isn't enabled.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Heiko Thiery <heiko.thiery@gmail.com>

> ---
>  board/kontron/sl28/sl28.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/board/kontron/sl28/sl28.c b/board/kontron/sl28/sl28.c
> index adfec8ba237..0baf5c63f18 100644
> --- a/board/kontron/sl28/sl28.c
> +++ b/board/kontron/sl28/sl28.c
> @@ -156,7 +156,8 @@ int fsl_board_late_init(void)
>          * If the watchdog isn't enabled at reset (which is a configuration
>          * option) disabling it doesn't hurt either.
>          */
> -       if (!IS_ENABLED(CONFIG_WATCHDOG_AUTOSTART))
> +       if (IS_ENABLED(CONFIG_WDT_SL28CPLD) &&
> +           !IS_ENABLED(CONFIG_WATCHDOG_AUTOSTART))
>                 stop_recovery_watchdog();
>
>         return 0;
> --
> 2.39.5
>
