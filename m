Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066E3C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 14:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A4AA807D7;
	Tue, 11 Mar 2025 15:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Sx4SSe07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A30281671; Tue, 11 Mar 2025 15:32:35 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF6F801FB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 15:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6fed0620395so29428947b3.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 07:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741703552; x=1742308352; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u+vsY9PsecySLraGP8nB95EA36c0BWCGX9cAcgpVpxQ=;
 b=Sx4SSe07AyEJ0K/5j3xtufXBxta3rGiVQeYBo7Pk4spHNFgN9jcJ2fhTsoq1fVk67K
 ljsW3rlElY7/ii1pHXvM9yZufPv1vtCk8UroIHgo+Ds9wm3fftCtmCpOuI1+2EOX8URt
 KYx71ZsOu6TFgQh+opbUQhSTbc/B5dyEOUL/FgocKJmYHiY5SRT38f8aUNJAWUJLFNvB
 eUxIhS/liuKdlv94lV2Dd9FqzVm0lUcpmCWhikAHCNtG8kvPYb7QdYdLupe5xRu8Y3Ye
 dj1lzJM0QqNSAXD9K5O9NSTBes7cisk2Yjj1hLxEuKJZ5xmplYE1QydBH6yj6ZX+yFfc
 BDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741703552; x=1742308352;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u+vsY9PsecySLraGP8nB95EA36c0BWCGX9cAcgpVpxQ=;
 b=h1q9X+AtEFsTRCC2MJsPsOq/69I5SCb1w/Xh8Rz0LAw1JNygJtOf+rflpb4AKKLbGS
 WxvTraj15Do6cvIy+aWOC0Rs9a5AORnxmuFYn7DJjttQWsvGD2ie0GkU9nGFJ3/1RtJp
 HkZYNwyrdMrmEOvYwkGhprJHZxZDMGTJpf2GQpQg/shVMZhlUxPymr1lV715RKF2bCPp
 3F7SlteACVc5jxr594+bC38bz5cUwiUw8yrZQe+sIJGAEyVTGg/9wesUXwCFyyn7V82r
 awAEwW72z2R94HQTzOwirvXD1I/sh11rjp1Oq16R7ErTiF9PnhM9P01js8c6ddV7Zi6E
 o/Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIWO4akwjSTeOaIJUmTLEVNhy43PwOEw98H9a9aIdXNDHcWdg8heFciqqDMwfedkJuoC9xKMc=@lists.denx.de
X-Gm-Message-State: AOJu0YwCDiV+3uYAkTRL0GNmUwqj/VDq7o6S6R3K99MdQ5iFGtF4zyzB
 vcDAg1zrXmuGzoO654j/qmgQw8/WgmdMunvGKyMEw+6su4O0xpgRhGCRbfdV+m63yOFJTwmEIsd
 /VFd/FhBpcsM+iu4XExV+SArQ5syKsGUKdnIAeg==
X-Gm-Gg: ASbGncsUyjl1EqKl/te4Zo9Esidu/1VMi4PeBg0xR6KD99EqPOx4sI0DRVtv3ZlorLt
 S3X+xQITh2tZWM6cw1TF78znDG0fj0WthI0EMcAJi5Mz1kL34NRD46oA9te7OOCMezzmn7TP4vO
 5a//IvtBtG+9irgniUAvJeGmHysAc=
X-Google-Smtp-Source: AGHT+IFYxVTdMtMJ7n2DopIXNbiv3pq3zeafyW9gmm2tX0bCs3fNB9yORF2D35nM18V4s1FxDnOnsYAHc/NsSgw8N5Y=
X-Received: by 2002:a05:690c:45c3:b0:6f9:a062:2a06 with SMTP id
 00721157ae682-6febf2a4c4emr242587437b3.8.1741703551999; Tue, 11 Mar 2025
 07:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-14-CFSworks@gmail.com>
In-Reply-To: <20250224055524.1334929-14-CFSworks@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Mar 2025 16:31:55 +0200
X-Gm-Features: AQ5f1JovwLGBFwM550By9ca4Rjs7EjeWQ1qfQ0amqWqGZ4TPMYQ6YygLZUhkmL4
Message-ID: <CAC_iWj+cX71f0R2a9gXg0iGFSV9R=yf4eP8vhwVbdyQRtB6bQg@mail.gmail.com>
Subject: Re: [PATCH 13/17] makefile: Add `norelro` linker option
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

On Mon, 24 Feb 2025 at 07:56, Sam Edwards <cfsworks@gmail.com> wrote:
>
> RELRO is an instruction to a dynamic loader to make a memory range
> read-only after relocations are applied, for added security. Some
> linkers (e.g. LLD) require that all sections covered by the RELRO are
> contiguous, so that only a single RELRO is needed. U-Boot at present
> neither satisfies this requirement (e.g. x86_64 linker script currently
> puts .dynamic too far from .got) nor preserves the RELRO when converting
> away from ELF, therefore add `-z norelro` to global linker options.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 87b07d8989a..c869b5c55fa 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -820,6 +820,7 @@ KBUILD_AFLAGS += $(KAFLAGS)
>  KBUILD_CFLAGS += $(KCFLAGS)
>
>  KBUILD_LDFLAGS  += -z noexecstack
> +KBUILD_LDFLAGS  += -z norelro
>  KBUILD_LDFLAGS  += $(call ld-option,--no-warn-rwx-segments)
>
>  KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
> --
> 2.45.2
>

I guess we can bring it back eventually when we clean up the linkler
scripts more

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
