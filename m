Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8446C25B79
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 06:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23CE687D70;
	Fri, 24 May 2024 08:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YFeMqevn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8232C88321; Fri, 24 May 2024 08:13:43 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3289B87D57
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 08:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-68195b58daeso431890a12.2
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 23:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716531220; x=1717136020; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hFRPg/oChRJvSGmjIA2GFlzfMw5/JACCxPRHIbcxZUI=;
 b=YFeMqevnuYoyZ9PDFMkYXwfp/diIbq8i3t0lrxOA/ZX48HPKBIKlBrnt680ZM2tMGG
 zal7eOwv5wJfv24wABx1i3vRJJsRvl65VRV4aUgbCsGlDVJSsON6LwCDYlbemij9C4yW
 KwZvfcxjdcBTz5fP2IKKdBMKYCu7FjDwPFMXu12dBymUueaM5GpiUFMRwZK6LVjX3wmS
 8RgQSZESHMxLHtYoUKVxeK0Gb87lksKLNDweC5kwm3Uk9BWXD9IEJoKXK3f/Uz/2rsp0
 FNlXAFzFdNbVCAyYMmK3469sQtFPP3hopLixNcMWda9XaVcNGNLBXQN31daqSJVKNeXl
 rOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716531220; x=1717136020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hFRPg/oChRJvSGmjIA2GFlzfMw5/JACCxPRHIbcxZUI=;
 b=hDCAZJH1TRzDvQelY0aiaoBlLMxBBRso+p8ow51mNqXR2UqEZ+aD/KzzCqQmOwwHR3
 TrGwN/rZ+PyYelN2UxwqxtgkWOcUYDDTBk+RYAE2oTj1BVjrPBG2MdjBUSINFDLdqm7N
 f3Mlfiz5Te5gF06OqQFC/u8KfjebXH5A/jlcF5yGj+kwn8eEP5kONttwIEWmzHRa0Ndi
 7m+8Ba4Sq/gYoqOyVKraaYvNdySaUWWOSZdyRC4FbI6zoIekHaJAhVAUk9s0kDXnHHDO
 eDJQg5UW4bIyLrro1YpwXTSgaA/zDkDts9QxNVpox78RySlJYEe45qwscA3Bnl4BGHF0
 rPag==
X-Forwarded-Encrypted: i=1;
 AJvYcCX14CTGD6xEj5AARWmYS2O86HpwcDhi4NQIj4ImE9AFZYD+aI7+gxVToeLNiUfNdCzTcAZKanacOlBJrR3BlkcLurzl1w==
X-Gm-Message-State: AOJu0YzmCtmRhn35WazIvG0+vBjY7pj3ZcajTifJK7W9WSjbt4auhggy
 sqe4Im5GrAW6zG2zbnogvTd78BW4RCZsNpwxe30LyRavUkjcdFK4hjl4dPoXK3Ap+4xAClRrWlJ
 l2MsTiLe7/6V1f3LjS/MOR9eS4cVyefqJ2Mbtj54Bljh9KUR0R7Mj5g==
X-Google-Smtp-Source: AGHT+IFS7hEVmuaHvhFoHOC81WsKp8ic8pDvgz5Wj6mfBg/5b7a5vXN2Zh6WIOP40vm3Q7pV9RuCSkleBW+n+d4Dusw=
X-Received: by 2002:a17:90a:c58a:b0:2b6:7e55:2aad with SMTP id
 98e67ed59e1d1-2bf5e944a51mr1238846a91.7.1716531219701; Thu, 23 May 2024
 23:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
 <20240426-b4-dynamic-uuid-v1-3-e8154e00ec44@linaro.org>
In-Reply-To: <20240426-b4-dynamic-uuid-v1-3-e8154e00ec44@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 24 May 2024 09:13:03 +0300
Message-ID: <CAC_iWj+2QzdTPC=DiKXv5p4U_xiadnE=UGWOWfiMJRcwcH9wVw@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] doc: uefi: document dynamic GUID generation
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

On Fri, 26 Apr 2024 at 17:19, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Document how platforms can generate GUIDs at runtime rather than
> maintaining a list of GUIDs per-board.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  doc/develop/uefi/uefi.rst | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index 0389b269c01b..52076fb4c106 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -448,8 +448,43 @@ the location of the firmware updates is not a very secure
>  practice. Getting this information from the firmware itself is more
>  secure, assuming the firmware has been verified by a previous stage
>  boot loader.
>
> +The image_type_id contains a GUID value which is specific to the image

which is/that is

> +and board being updated, that is to say it should uniquely identify the
> +board model (and revision if relevant) and image pair. Traditionally,
> +these GUIDs are generated manually and hardcoded on a per-board basis,
> +however this scheme makes it difficult to scale up to support many
> +boards.
> +
> +To address this, v5 GUIDs can be used to generate board-specific GUIDs
> +at runtime, based on a set of persistent identifiable information:
> +
> +.. code-block:: c
> +
> +       /**
> +       * efi_capsule_update_info_gen_ids - Generate image_type_id UUIDs
> +       * for all firmware images based on a platform namespace UUID.
> +       *
> +       * @namespace: The arch/platform specific namespace salt. This should be
> +       * hardcoded per platform and replaced by vendors.
> +       * @soc: A string identifying the SoC used on this board.
> +       * @model: The model string for the board.
> +       * @compatible: The most specific (first) root compatible string.
> +       *
> +       * This can be called by board code to populate the image_type_id
> +       * UUID fields deterministically based on the board's model. Allowing

model, allowing

> +       * many boards to be supported without the need for a large hardcoded
> +       * array of fw images. This works using v5 UUIDs.
> +       */
> +       int efi_capsule_update_info_gen_ids(efi_guid_t *namespace, const char *soc,
> +                                                                               const char *model,
> +                                                                               const char *compatible);
> +
> +These strings are combined with the fw_image name to generate GUIDs for
> +each image. This function should be called during board init, before the
> +EFI subsystem is initialised.

initialized

> +
>  The firmware images structure defines the GUID values, image index
>  values and the name of the images that are to be updated through
>  the capsule update feature. These values are to be defined as part of
>  an array. These GUID values would be used by the Firmware Management
>
> --
> 2.44.0
>

With these
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
