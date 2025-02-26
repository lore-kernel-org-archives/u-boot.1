Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE21C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 14:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23784807EE;
	Wed, 26 Feb 2025 15:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tnaaiDuY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D33C880F88; Wed, 26 Feb 2025 15:44:39 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8422F805C3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 15:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e609cff9927so127244276.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 06:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740581076; x=1741185876; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1pI+VMug3Tvxf4ydbMSZen7Cfo+/AVzLMrYNqfGcgTQ=;
 b=tnaaiDuYk41fazN1bshiKUcbw6VN6tm5ovuOpqyIZg/TVFFG6xzzEm4SR1fWQk868A
 yOv6eR7xh1vueQIaqhi2s4u05VjPpBQeVzZrQ3mScxIH+qRcWkxGKgCov7kyDvk7GnRF
 yMblMeXZZZpEyEY1SqJmILFsaQ3YIzJF8olBWHBe23ffmpNe+CcPXjK9R9SNgXQJN84O
 Dym0nxNvTNaVYlEjm38fP9nzYmPxDBkG0SZshJd5Ekj1KowkWWx2lnd302mG6Vv52FHR
 ElO0jFzTX1K08D2TF7VGshtlLqMQ1Tdt6Lj7An3ErV0W8pRAb7hCjxZGcRxAdX+yekdb
 PkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740581076; x=1741185876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1pI+VMug3Tvxf4ydbMSZen7Cfo+/AVzLMrYNqfGcgTQ=;
 b=hjh/dBJCfrdnKMvkfn6snuaPtLqCLZWq/pg8BdlycBmheEaHKzRg4qa4v0mbxwhztG
 adXizJUug3xYHH2qCLyGLZGB+mBvVHUPpw+U0eUuX1PYRqiC+prfgHgBR9VMCRwxO8DY
 H23la87PLGvt6hadZXhhbKxi0KX8yrzyyxPKaHGD7jCD6N11xSXnzjH/rqffNVRaLvT2
 A1kN9uGhNC50+y+1DLFVQ+/VEZ8JjiTldfcyXunbpnI2NxAkLUEiCxXII06xcJR0chdb
 /mg19Eit93H/AI7L6Mb3lzK3jQ/zODJwGOBksNtIHmN71HKL+INOKJjg1x5ReZrBGP8w
 PP3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc7fnXro1kov6l9Qi8rIZ9X7ePOIsOQ76zqzUCGnXmtZmNcroevY53WS+sT5hj/GBv19nXaEk=@lists.denx.de
X-Gm-Message-State: AOJu0YxUUVmY7qPVJGS35PkzmSv9qsCn/7LuAXtMlNwShChoOiMzjqBP
 6l0CB0rQ+tFtjAX3Q54Gw0N03LWZngfx431lKe2oGLQAe1U3dDeyWwAI8LSPvw9ZJ6q8PlVp8UJ
 keB+ANhlfiIsraG4oKAK7rFlIAclDoxpJ1sCLJA==
X-Gm-Gg: ASbGnct9/wmuDLeh4mdf2VzzHpbp1epeL2yaQu2NstPSoyu4JPjCOhUYqaNE9oaHY1Q
 k/5jGf493zw2oPyUaXhpGJP8e59Hetfvf0d8I4apo7fsCwY5Sv6NAqvFKpfws25StPL3I00y8Km
 1VbtfsCBJ+
X-Google-Smtp-Source: AGHT+IE9Q79E/2r0KDzI86TFPvWcmL696UvKkucf0vrQVDl+XlSwFn4/apjff7UsocB2RbhDcS4iwDv+9Itfzu5hLTQ=
X-Received: by 2002:a05:6902:cc2:b0:e57:44de:aba9 with SMTP id
 3f1490d57ef6-e607a4e3ca6mr6604622276.17.1740581076338; Wed, 26 Feb 2025
 06:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-2-CFSworks@gmail.com>
In-Reply-To: <20250224055524.1334929-2-CFSworks@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Feb 2025 16:44:00 +0200
X-Gm-Features: AWEUYZnX-9hWih7XxScOtTpTYBT0IxQ-TSiT4TSLNk-ulwd7WAg8QQjB8yQvLes
Message-ID: <CAC_iWjL2QO-DoArCe=YbHnZg9YkGohWspSz2ESQxmuYzKCD8ew@mail.gmail.com>
Subject: Re: [PATCH 01/17] arm: Remove stray .mmutable reference in linker
 script
To: Sam Edwards <cfsworks@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de
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

On Mon, 24 Feb 2025 at 07:55, Sam Edwards <cfsworks@gmail.com> wrote:
>
> The .mmutable section was deprecated in 2012 [1] and finally removed
> entirely from U-Boot in 2022 [2], so this special handling is no longer
> necessary. Remove it to tidy up the linker script.
>
> [1]: dde3b70dcf3d ("arm: add a common .lds link script")
> [2]: 3135ba642f9a ("arm: pxa: Remove CONFIG_CPU_PXA25X")
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  arch/arm/cpu/u-boot.lds | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> index 2f50087f57a..63e82a09fad 100644
> --- a/arch/arm/cpu/u-boot.lds
> +++ b/arch/arm/cpu/u-boot.lds
> @@ -169,15 +169,6 @@ SECTIONS
>         _end = .;
>         _image_binary_end = .;
>
> -       /*
> -        * Deprecated: this MMU section is used by pxa at present but
> -        * should not be used by new boards/CPUs.
> -        */
> -       . = ALIGN(4096);
> -       .mmutable : {
> -               *(.mmutable)
> -       }
> -
>  /*
>   * These sections occupy the same memory, but their lifetimes do
>   * not overlap: U-Boot initializes .bss only after applying dynamic
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
