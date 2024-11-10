Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6F8D5E37B
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 08:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ABBD89370;
	Sun, 10 Nov 2024 09:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S3qtUx6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42D1B89371; Sun, 10 Nov 2024 09:41:49 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF2AF89366
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 09:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7f3f1849849so2453997a12.1
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 00:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731228105; x=1731832905; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZEwYhMIZcvFMTwqD/KunkLANseT/9dYeILrb+fORIs8=;
 b=S3qtUx6cobFTPOSA84F8ZdDRtSj74XyLCQ+fc9WnwcEk510hx4SCasmVvcNi+2K7Fy
 XNh9VaVZt4qP+nNr1qMwmkw1s0bBBqrAVlcEusHyIE0Q9bQbY4SqHQIWEmKMdjmWPqAe
 OH2Nb0X/z1UfqBQTNIZ4oOSDNzNW0a7s4h+4RxqMNZjj3uRUallTJMmf99G9szMLio/D
 /RLwA4qnIV/+NvbRfcBezcfV3NOv2tyuaAQrG6dEvIRE9Zrv/YxMEZ9nF3bbrFeXno9s
 OaaJJhfcY9zQTeTIwUBKzRyfihMe2w0/R2znQhEGDq9zOTYdSTLfoVyp1OWRt73ZWMyx
 7maQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731228105; x=1731832905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZEwYhMIZcvFMTwqD/KunkLANseT/9dYeILrb+fORIs8=;
 b=iWzJzo+0tmOPxMjO3lh2PM3XbGFCRW8kyNOSKGzJC9bB7G5mEbcyMBr8hm8OHwHs6j
 rJMZOOB3+56bMX/w8/NW5nu09WbLliaMqejuGHubcXN+89Kbc2FFvNWL/qPYMoel8FhY
 g65qwIsCk161aaKJFkzK3Ix0QFERRaQ+ZpBTD+rHIFloYWue0K2NrjmYMobmb6xeVVH9
 eTQ9EnzGPxDvTEXiK3L5IRhwu1evM+ku/yeEY5PD72ToHsbrC/qVpJACcYp/KswlWrp5
 F8XarNK/oekAgN0jv2Z9IIGu6Aexqxj+yPjPqLQZIXBQVoNrJCsfRRhuQ3jO0x0i/TQE
 OJNA==
X-Gm-Message-State: AOJu0YxqPnNVaGVQMo6WZwvpKEvCVPwwENJ2RiilHDl6LxRY96177SPZ
 NMODRQt99xF6pEzCzCAY9n93CmIdjOhc92C1fEq/ZebY21HPgD7+oK8ZpUWEJMYYh0wud7USFor
 te0SbHoq4vwo8LXYDkyj/eTtCMz6Q2xq+xJEXRQ==
X-Google-Smtp-Source: AGHT+IG32P60r6/zP1Ghg24JLn2W1iotiECtGRIZscklv6il9XPZ2vIKVzEdXRTJ+g/TNg2WNFI4h4BkiqKgASxhA6I=
X-Received: by 2002:a17:90b:524a:b0:2e2:c00c:cb79 with SMTP id
 98e67ed59e1d1-2e9b165597dmr11750969a91.3.1731228105424; Sun, 10 Nov 2024
 00:41:45 -0800 (PST)
MIME-Version: 1.0
References: <20241108133850.431075-1-adrianox@gmail.com>
 <20241108133850.431075-14-adrianox@gmail.com>
In-Reply-To: <20241108133850.431075-14-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 10 Nov 2024 10:41:09 +0200
Message-ID: <CAC_iWj+JZ0bEnRL9eRS+eotBcUSh1EKucwAB2EGV5--n0mXSXg@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] lib: uuid: display HTTP and IPV4 Config II
 protocols
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Fri, 8 Nov 2024 at 15:40, Adriano Cordova <adrianox@gmail.com> wrote:
>
> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> Add long texts for
>
> * EFI HTTP Protocol
> * EFI HTTP Service Binding Protocol
> * EFI IPv4 Configuration II Protocol
>
> to the uuid library.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  lib/uuid.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index c6a27b7d04..dfc8218fb5 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -174,6 +174,20 @@ static const struct {
>                 "Firmware Management",
>                 EFI_FIRMWARE_MANAGEMENT_PROTOCOL_GUID
>         },
> +#ifdef CONFIG_EFI_HTTP_PROTOCOL

Can you change this to
#if IS_ENABLED(...)

> +       {
> +               "HTTP",
> +               EFI_HTTP_PROTOCOL_GUID,
> +       },
> +       {
> +               "HTTP Service Binding",
> +               EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID,
> +       },
> +       {
> +               "IPv4 Config2",
> +               EFI_IP4_CONFIG2_PROTOCOL_GUID,
> +       },
> +#endif
>         /* Configuration table GUIDs */
>         {
>                 "ACPI table",
> --
> 2.43.0
>

With the above
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
