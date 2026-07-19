Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD73C44512
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 17:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68D8B84A29;
	Sun, 19 Jul 2026 19:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fKtGddnt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC04584A49; Sun, 19 Jul 2026 19:59:43 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59E2F8494B
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 19:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-697cee2eb6dso6296170a12.0
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 10:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784483981; cv=none;
 d=google.com; s=arc-20260327;
 b=SgZg+7NwCRnb1LyASxWnu6tD/PwFJIUVZpeBsxzp7QeGTYLZujptQfcK0cdkxqJ7VX
 9XO9UQF4O+sSFvzPldzkBDUd7H6a7mVXM9tPKStNPsqrDLpbMlArfovv+6C1i8mxWlA1
 63Ldr2t3PIXfwSypjgnqaC/ruR4el5AhqXQfmvESOLxqUOmFhdRmzvHtqlcTi+GXnJ5l
 0p4eYfmBHsuUT4FPNSgMtzPqDMKow3xWlE+BX5gIB1KI/J+NczHFFIDD1caXfxOs0/Jw
 UGJUjhfHiZNJBGzNSYIs1o7tB7LjcgHDq5CVyOh6kwtslTZEQLp+qpxy/EcXd/AXQB7w
 14PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Sw725D5Zrn867ssn/DqZzXLcCxYHDU4qXLGy3H0rKEk=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=LvTb1AY6+NLEN0q/DgfZUZHkPvWcbshDOnvz6JwlTc46USYvm95R1vpRlK4SMZaXFI
 y11ImA1zFPJ1Czu2wRnPUnozApQ6J4qpjkyQ9MaO2u2zHjcGhq5EmF3cFLVDC+/oo5sQ
 uXNBxEkvNqk1Cp7HHiejGYCjlri+SHFydumQFtGbSE8JZq5JGp+dbyLtgXnToNn0y/NC
 RSWHMxLT3EWngkjxLs6iRxNn6HjP9/ASiJ8C72g+ECxxjmBceHLmFTrYd6bJycLVS56D
 if6Ll8/EI5s7qRw3CpQ2v9u535Ca8m4i9zgChxyWDtRAGEA6yDAagEy8qL02SYAw1zh1
 wLqg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784483981; x=1785088781; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Sw725D5Zrn867ssn/DqZzXLcCxYHDU4qXLGy3H0rKEk=;
 b=fKtGddntGIGdjVUHwfgUfUP2ZmESY3KXPfkW1GN6DgJLqu1lC6NG2ZMJihBricLw5/
 M+YWoe4cEAPUaPx806q8JiX8qfDn88n2LJDR/21ENuvMrtHmqh2FnPAj7L9lsANupC/y
 a5OTiD+GLwdVqjaUINj5luEXMl9HvbB0/dFhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784483981; x=1785088781;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Sw725D5Zrn867ssn/DqZzXLcCxYHDU4qXLGy3H0rKEk=;
 b=HoEKOKbBnsQ0TTkIpKrN8sg2fsmJM+N6NGSGK876Z1B6wUTaS3la1yI8XlDQ+/JAWW
 w3WXmr1oqJI+SYOrbPN2NG4fxvPHMT2deChv4MVP7pT6oYeYTV3Gz8Z9y+jNAqtsA1Lw
 L0ppQKwk+eNUkx8G9w+AcaUkzM2IFxhlJbBjZrKGkebDrq/+GNp3xdF1f9C2caGp3N+R
 wQ/FPFuDvBQh3KvsACB4a8qk5pL/SYX+/E42sFlDiIumsWsem/w8dpVyvfrvTfCpMb/U
 y8/ViZDfhFI1udutWl1kVRMh14Xo6SvJE6IyeLBjhiaMPBnhpfVcE0hR89/SYVysx8zp
 /ksQ==
X-Gm-Message-State: AOJu0YywLU4GjHO+ibmj9kcnXmxs/t/fBAwL8UHvtoioZ1CY3YZZMmSX
 OokMOspkfzQKdphwTMiBSrWKqX9Yo0rP+t7wGH481wPDSKcP1hojus/4ZraaSvE426GjpBUv6kH
 2doBkm5ETuUBkhEvDL5/HtIk/25vEnWWwiDyLpyUU
X-Gm-Gg: AfdE7ck9kEL2xGIB+AKGYAlvD5TtJqSlZ+KVW0ZDXDiWQdUF4M+BVAjvhCQmK9kT5Ne
 Fa2pz/6RhbwCQjncrjvZNpqqjSFxjlXKxVOpnAQEA3rrq3oF85gOHzBVNeSxZfP1pLN9cc4Sjlp
 hywlmN9p894PpGnZmoVJ+BYTO9/eWXbcGInPMnjOcscRaUsdZ1C89ToZHvsq8s+BH7/B4ihrHIi
 z5Ui2N0v92pYx9ysWdXRenlTfNf8XV2BsZGTF9xzSkQKBpmNNkjKNIENofq
X-Received: by 2002:a05:6402:5292:b0:698:1504:bb23 with SMTP id
 4fb4d7f45d1cf-69e652f9099mr3984317a12.29.1784483980718; Sun, 19 Jul 2026
 10:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260716205213.340109-2-dmukhin@ford.com>
In-Reply-To: <20260716205213.340109-2-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Jul 2026 11:59:29 -0600
X-Gm-Features: AUfX_mxlwJbuo7fAvkHrWRbIp98b7jOfTbrmRsCRB0K8cAqmafaaLxTuuDhVgTU
Message-ID: <CAFLszTgTACNfa+_LnLGvivq+vr1fjz9-c=Phfxe2Kgb4mLHh3A@mail.gmail.com>
Subject: Re: [PATCH v1] x86: add support for CONFIG_REMAKE_ELF
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-07-16T20:52:14, None <dmukhin@ford.com> wrote:
> x86: add support for CONFIG_REMAKE_ELF
>
> Fix objcopy/ld parameters for x86 to enable CONFIG_REMAKE_ELF
> configurations.
>
> That adds new 'PLATFORM_ELF_ELFLDFLAGS' make variable for injecting
> proper linker arguments when u-boot.elf is requested.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> Makefile           | 1 +
>  arch/x86/config.mk | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)

> That adds new 'PLATFORM_ELF_ELFLDFLAGS' make variable for injecting
> proper linker arguments when u-boot.elf is requested.

The variable is actually called PLATFORM_ELFLDFLAGS - please can you
fix the name here. Also, please use the imperative ("Add a new ...
variable") and mention what fails today when CONFIG_REMAKE_ELF is
enabled on x86 (presumably ld picking the wrong emulation).

> diff --git a/Makefile b/Makefile
> @@ -2003,6 +2003,7 @@ u-boot-with-spl-pbl.bin: spl/u-boot-spl.pbl $(UBOOT_BINLOAD) FORCE
>  quiet_cmd_u-boot-elf ?= LD      $@
>       cmd_u-boot-elf ?= $(LD) u-boot-elf.o -o $@ \
>       $(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
> +     $(PLATFORM_ELFLDFLAGS) \

Please can you add the same to cmd_u-boot-spl-elf just below,
otherwise CONFIG_SPL_REMAKE_ELF still fails on x86 (SPL is always
32-bit, so it wants -m elf_i386).

> diff --git a/arch/x86/config.mk b/arch/x86/config.mk
> @@ -24,9 +24,13 @@ EFI_IS_32BIT :=
> -PLATFORM_CPPFLAGS += -march=i386 -m32
> +PLATFORM_CPPFLAGS    += -march=i386 -m32
> +PLATFORM_ELFFLAGS    += -O elf32-i386 -B i386
> +PLATFORM_ELFLDFLAGS  += -m elf_i386

Please drop the whitespace churn on the existing PLATFORM_CPPFLAGS
lines - the rest of the file uses a single space before +=

BTW, further down this file there is already:

    KBUILD_LDFLAGS += -m $(if $(IS_32BIT),elf_i386,elf_x86_64)

so you could set PLATFORM_ELFLDFLAGS the same way in one line outside
the ifeq, next to that. What do you think?

I'm also interested in which x86 platform you are using - I am working
on getting Alder Lake supported at the moment.

Regards,
Simon
