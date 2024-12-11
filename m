Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF431E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 14:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35A40802B4;
	Wed, 11 Dec 2024 15:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MRCr5vOZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 627C2802E3; Wed, 11 Dec 2024 15:53:50 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A8E880274
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 15:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6efe4e3d698so50092157b3.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 06:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733928827; x=1734533627; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sDoXQgSfOck1gbCvN1mQB/2uDInHuL7sK/AgAzrWYxs=;
 b=MRCr5vOZJCTZ0pslDmkRvvEV753jC+Rr57dVTwzxEBI3ocSz8PU8Dnj9EBOCPVtu2A
 j3DYjnm2gFkSgUZdUAbLKCMFgDLRoFpXWjy3wSG/UvjWaAmmOjKgCJluPVmEw2JMhje+
 yv0JHmNbKdQEzvrcFMsprChNUwxvpN2qMT5fRkFtHXUFEnsAmB21eHK++Jn17zj89dRd
 T6WgX/hS+4ajU4Uf0/29nSchL1tzVfeh1fOHfr7eTw0Sr8bsQwRi83aIkXfSMb9I5iIk
 +SmyHELHB1539eAXDfWFjFG4aUqcbnD4/C2I7fGxGZUnMipCmUtRYLlGVulKU1I6SOzY
 JfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733928827; x=1734533627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sDoXQgSfOck1gbCvN1mQB/2uDInHuL7sK/AgAzrWYxs=;
 b=ownf5KZnDEgfBfs6VzPm8qZJ8Y0P+ZWd4+mtaTrlO2Yixvk/Z/zVK1X9Wi6C2xx6Si
 a2K1P+d0WSmg2VVzJSkBqqR3/A2kqFddl8fAzshgpR+4gepZpCRcQCQcFe4KysX83y0u
 uhvDU1fhOref8TPiUSC1rqHMZkyOkOmDROlmq/+3mr0MCkra30h3MJl61298QaiYVsEF
 Ba9d/HDntnqXU8v3osB/0vqmIYAmxb+iwHuI1XoDa1GYLaA3cStFgBoj1c5SagSq2/j8
 9M7Xsia+z1fOvAm8MlEHnqtY63f56phSVBwFpBg8iLIXQdjIsSvx+q2nrmxxvoMDuQsq
 wM8w==
X-Gm-Message-State: AOJu0YzvA032+Wa2qZFb006kutushTOOyHCMEiNizHK6OuYW5kDXg3GA
 9M0ecdcYpAex3gupjQStwq9qg3s9c084IVlP2dtXGzFCmu6tcVOx3WiAPkcJ1jvjIgk4Rg8ihoa
 +pSoHg2RuOOvYv3t5LwTVN2JpVH9amvc4b6lraQ==
X-Gm-Gg: ASbGnctCi7yUOGm6wzZxoIEYDusoDIFDHcUNr2p8chzbMfvx401EzNAiAY87HFKsuJk
 CBWS8NF4HIihuJ4v+/aOQEXTKq24GPmiMR+Q=
X-Google-Smtp-Source: AGHT+IHSfbXdzuvFcFwsFL1irAe/YvGzFfgMSkFRGFDlibjC9NMcL9WT3U7JXQzwCSOjDvJalSoWf1VxbElnwSHfA/A=
X-Received: by 2002:a05:690c:6811:b0:6ef:aae1:ac51 with SMTP id
 00721157ae682-6f148046696mr29911777b3.27.1733928826982; Wed, 11 Dec 2024
 06:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-8-sjg@chromium.org>
In-Reply-To: <20241211135418.563803-8-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Dec 2024 16:53:11 +0200
Message-ID: <CAC_iWj+u+2edj42qcyjHSJzW=41kjE1VOWMYXrbGwibK-Bn8iQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/23] doc: efi: Add the EFI-loader API documentation
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
>
> Bring in the documentation from the efi_loader.h header file, so we can
> see the API defined there.
>
> Fix efi_alloc() to avoid a warning.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Put the header-file in its own section
>
> Changes in v2:
> - Add new patch to add the EFI-loader API documentation
>
>  doc/api/efi.rst      | 6 ++++++
>  include/efi_loader.h | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/doc/api/efi.rst b/doc/api/efi.rst
> index 43d6f936fb0..49814bcf5ea 100644
> --- a/doc/api/efi.rst
> +++ b/doc/api/efi.rst
> @@ -54,6 +54,12 @@ drivers, handles, loaded images, and the memory map).
>  .. kernel-doc:: cmd/efidebug.c
>     :internal:
>
> +Overall API
> +-----------
> +
> +.. kernel-doc:: include/efi_loader.h
> +   :internal:
> +
>  Initialization of the UEFI sub-system
>  -------------------------------------
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 00a1259c006..3f75f2efcb6 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -764,7 +764,7 @@ efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
>   *
>   * Allocate memory from pool and zero it out.
>   *
> - * @size:      number of bytes to allocate
> + * @len:       number of bytes to allocate
>   * Return:     pointer to allocated memory or NULL
>   */
>  void *efi_alloc(size_t len);
> --
> 2.34.1
>

If that gets placed on a different patchset
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
