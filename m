Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29C8C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 16:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A46687B75;
	Thu, 25 Jan 2024 17:09:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZtihoA79";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9743D87B8F; Thu, 25 Jan 2024 17:09:35 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A068E807EC
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 17:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2cf328885b4so12221981fa.3
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 08:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706198973; x=1706803773; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7CzsVXs9V/H+NN9yq3pI9OL1f4bwqKad4dJuMqfxFNM=;
 b=ZtihoA79tjAbwQvCmyiB1eAkC0dYJeMgPgAmpGLAF082xae5ybmJxiUiYlJRMdvO9l
 jZhpwB7IieXvFHvxp4iiuuC30MKt8BWbd/1/JWJyUrZjCd2vbq79Juxyw/0BxYttqBYR
 rmYEMuEcvj0XVVoKo6021G92vKkUUn3wuQCV8jF9KB0rpZ9yKGNoEiJNK/yn5n7uVSSm
 Ejgg0h61ofDObSba/A3kiBFTPWqY3RCALqWQ2o9F431nwwsVncJMOfFHNokJ+EbNEBsO
 6yYrb0NCiKDcef0VP7bw3ALoJOhNFTd25BAvEmb01Yvc7M8x4EU9/cEBBvjrtiFWbv9y
 NvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706198973; x=1706803773;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7CzsVXs9V/H+NN9yq3pI9OL1f4bwqKad4dJuMqfxFNM=;
 b=iY3Kdr/AGWOQfmoz9XORoWvFcVFA1S7wVnCiF8G/OvuYZzR+wDyAr9G0ebLETEsUBS
 mAiNP097dCg7q2RhtC6dd5GTdyRpOtXWZGGfXfaiIkF4DIvfANnIxe6kFDIfY09RFzby
 dmxPPlfUoJoFDzlO4j7FlsePO+MEpmLTrPI6NYiwVA4BKh+p8ITpJRk8TdPNfUUHMBEg
 SBp+hrKmr3FVYrBXo8/FJhJIIyaqET0w/ecliDjRlhFJmTtj/N2MlWL+E1e56QrSHoDo
 f6uD1Orqfp7qXzck6c1Ni6ZKt86EdET/J4CdyYh441iS7MinqLJ+0WQ7e02TbG1rvXLg
 uLRA==
X-Gm-Message-State: AOJu0YyqXmlhiKwGw10fGPCUVzQ/Rb2ABlpC9MxnqRT+b4+Ar9xVpxoL
 7uvPQJSajxDil3NnNVPElAqauukWd77Sv8Bq56jZV/HMYcZL9pLPAPmqiZA1Fnym3DGd+DzBFj6
 dE6b2pomHx8Kl2fyw0kAq0tIAAKWwLWSxFvlV4g==
X-Google-Smtp-Source: AGHT+IG93kljKLz5byFRy/LYuFSzfJLRVVZtNTxK7WW8Myngv/xjAdIrobIq/CdWvYn7g6XQO71dAMBcPQPWurkVNZU=
X-Received: by 2002:a2e:be9c:0:b0:2cf:3347:369e with SMTP id
 a28-20020a2ebe9c000000b002cf3347369emr894769ljr.68.1706198973093; Thu, 25 Jan
 2024 08:09:33 -0800 (PST)
MIME-Version: 1.0
References: <20240125155438.47617-1-heinrich.schuchardt@canonical.com>
 <20240125155438.47617-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240125155438.47617-6-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 25 Jan 2024 18:08:57 +0200
Message-ID: <CAC_iWj+m0PHxjA-mDZ3ssqBmz_dMeDN21v8aGFQU0uxaNHso4Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] configs: enable smbios command on sandbox
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, u-boot@lists.denx.de
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

On Thu, 25 Jan 2024 at 17:55, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> To make use of the Python smbios test we need the smbios command.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
>         new patch
> ---
>  configs/sandbox_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index ea4e2c1ec39..a8df5e635b2 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -42,6 +42,7 @@ CONFIG_STACKPROTECTOR=y
>  CONFIG_ANDROID_AB=y
>  CONFIG_CMD_CPU=y
>  CONFIG_CMD_LICENSE=y
> +CONFIG_CMD_SMBIOS=y
>  CONFIG_CMD_BOOTM_PRE_LOAD=y
>  CONFIG_CMD_BOOTZ=y
>  CONFIG_BOOTM_OPENRTOS=y
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
