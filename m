Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE294FF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C65FE848BE;
	Wed, 29 Apr 2026 16:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fHAGgCSH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA72A848CF; Wed, 29 Apr 2026 16:21:42 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3EE9848BD
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bb91b426e40so211250866b.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472500; cv=none;
 d=google.com; s=arc-20240605;
 b=NY47c1ZaaPaQ45nS/eThpe7Hz6WxbBw7c430ejtqR6PzHCUOksmFFF1na+TRXBmBTK
 jCZfDe7WCTcRAViNb6vlZDBn1k2aDxlDHEAh8B0/5xz+zsFhUvKe8KDDY+e4u0CVIJzT
 /eN8MCiJqlPgjVM2wrljJa0u+zekvqCXbQyhOEsyEaV03nXLKxceKt0q11LwAWm42ws9
 RwFvWih2Q/MayGzO6mdNSqHhBR7q9SJH0mvK8VRMHwrf70MqZK97F6fF+wBKZpZniF15
 NWw6eoFFJXATCVYFnrwD/D/Hg3mHjI94d6CdNs6AWBa+8bbd4k8QIvBJFZyDfyMc7JYm
 3oGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E23U+c6Fyqj2bO9ovOOl0hc+xFd9hL7CNO1HTC2iB+4=;
 fh=AkkFQGgex4/uJFFEvqZIjF/kHc3dyQYXt0MIVYfaUkA=;
 b=EhJAhGd/m9dYhaFO18HKdACnb9SI4/eMltMbGcBF7MzGzeclRTr2jI7ODJTc+jzCp6
 9NsRyd3vfQjStSK9+ubCd8QcWpaMuVRCoV9fRRGcWD5ZfH0Aasjq7Hu2M1Mxssr6MZpv
 vJMhnsOk28pHbphtFstk+e/ZXPJH1LBr46F6eQ+6UAgrcEQkCoNnOKgBdUgCbDliyRbS
 T9Vcvxu9MITUcyBZad8ZZNKv9WCkM8NiywMYC0RG8QVMVbtMWxQUAdLXG1JcC8vFQjCi
 KfK6jOHiY44ADcoNv3hVHZh2S3yJGlI/piorApqtebIEKMFJ2enqm2G8hlI7TJ1A1KMo
 PaZQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777472500; x=1778077300; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E23U+c6Fyqj2bO9ovOOl0hc+xFd9hL7CNO1HTC2iB+4=;
 b=fHAGgCSHY7Lt9lFR0lzQWotoR1T7MHGU4bxG0myvTxRdCtM5dU7uXB+q3aXayo5EtK
 D7YFfh6A1CLYr0usM0qxPuaNk3uIcWe2mBRFOyxOz4Uj5DwQVbfdZe7llmrH1htCdBk0
 l5KPdvLFVV0NSyLCDupNmACGyqEmUJh5c09p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472500; x=1778077300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E23U+c6Fyqj2bO9ovOOl0hc+xFd9hL7CNO1HTC2iB+4=;
 b=gdD9VfA9IvUpgrQcnFYfKjzvxDZBBdoMhhG35mxAFNub6EkL0opugvd5ie3meOSWz+
 w/daHiBkDMIdbKoNnE/9Yrp01VmGU+jGmpnkjqcROo7dZ018C6RI7eMWG26Ux/Iud8+8
 VcINOs7iKUgiPccSCQHLfztMluuX3iryUlSKzP60hF6Gi2b5POMxsXN1psedyfmQRmsQ
 CK4GNx+yV3sbj9k/sasFsWcrfi2yWz43wEbyv566qM14fYoW1Fs7NrrSVoboeDzwBYJ1
 dhBbHKl8R1hQCBd+G4gHaEY16CdrWTSkFfslhwuMpXBaet56nbZDq3cIMdGXkSTVuUnc
 Pz3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bjMdPZzOCtgQG0klCEBR9woQIWAfBxhZXyDlrd/vuxCSVLuMeJhzEgtofq8T2gxHoyDXXIwg=@lists.denx.de
X-Gm-Message-State: AOJu0YyTrGyAo0I3u6CFCO994v1BZ7w1MLoS0jlsWmabuwAvqhS2dK2s
 iPv2PJtpYTq4VVDWZ2ObtJnXfe2rpPS8wjCWYojTAprDRyA2RotCFTKUxl9LjPEUc46+5T71TrU
 uMZU5YP/02ghL87tHzdypZtHZUIvm/NGMW9j526Lb
X-Gm-Gg: AeBDiesDIlkjNlNdyiQEfWNw19tCr4ZK6+9GwC721wvX/fczQylLOnW4+oYajGy1ooW
 2GhwoQrPwEzOmjDnH3QxqOldt81ksemhtExzuK8E5Zfr+zzXFw1OVYcppqwhce5Ql1RZ30z+7p2
 GNSqctwgI/Lwvr0gc2tFIpN2luhdo6TDcd334yJBd7dYUPKcKeRtFbSX7wF9LDWNc3UFtb0qono
 41HtjGJyIxBYfLOVR8yp0haSj1JCkiaOuyBX7NNLzCRhMQj3uUyzs4/EcT7cxcinbH/oM2ESSn4
 ijrtD457tfC/4QZ8
X-Received: by 2002:a17:906:f590:b0:ba9:aeaa:fd01 with SMTP id
 a640c23a62f3a-bb93ee51c1fmr261147866b.43.1777472500397; Wed, 29 Apr 2026
 07:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260428142848.48156-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260428142848.48156-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:21:26 -0600
X-Gm-Features: AVHnY4KGf6-XmJ7zkekVDunrqsPDHpgOIwUrhwwRXnDb-iU8Jo5zNHr9tZ9MvjY
Message-ID: <CAFLszTgKkn0cwfv97FBVDK+FdCM-6BfasCvsA2oDe5qdzeuS4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] .clang-format: add U-Boot specific for each macros
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Javier Tia <floss@jetm.me>,
 Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Heinrich,

On 2026-04-28T14:28:48, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> .clang-format: add U-Boot specific for each macros
>
> Formatting via clang-format is controlled by .clang-format.
> For each statements should be formatted with a brace at the line end:
>
>     for_each() {
>     }
>
> This requires clang-format to know that the symbol is not a function
> but a for each macro. We use some for each macros which don't exist in
> Linux. Add these to file .clang-format.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> .clang-format | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/.clang-format b/.clang-format
> @@ -748,6 +748,57 @@ ForEachMacros:
> +  # U-Boot specific
> +  - '__for_each_child_of_node'

Should the 'git grep' recipe include drivers/ and arch/ as well?

Regards,
Simon
