Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A69C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 07:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1CA784119;
	Fri, 10 Jul 2026 09:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OKvYoJAa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D94EC843B6; Fri, 10 Jul 2026 09:12:25 +0200 (CEST)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2396A8407E
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 09:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-667971437d6so831364d50.2
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 00:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783667542; cv=none;
 d=google.com; s=arc-20260327;
 b=bdQJu64mR93M0NDq/EbVCInA/TCqZrSW35vthMjz7ie9eqgw49MyiQ8Oe2FPslVlFT
 hZVWZFVu2+j1CrCQMrGEJZQur26+sG0JlNYt2YYeOvFBtZyUwcumezXUpFyVx22cYQug
 cJk98QdlVt36kDE4MO1QL9tXBHKn44MYZz13n0h2i/k8cabGBTkKVMZQH16VF1hl2Ujl
 UhKhf44e4zudBe1LQNc7Wwvm4bGJc6yo7kS94svpronSTKQcwiWna5ja2MnHKA5wsGjH
 CQ14GaupVSzPl3R7UXiXCrGLIBBL2opXmjJ8M5T1k2avv2BmRdQRo7kXpyKaWBY3ri+L
 V7Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jX+mY68Wp679STgVacYwKizXqn0kRASgoNkNa6aH0yM=;
 fh=KxUBlU7/WYm+G9F9qCsC9tg5lmvNkYmY/BKR/aIbr2U=;
 b=sU3oRArGO35sr+P6hp/TmelK0ZwwKHbslMFdWmiP9W+if/Fa431nl9qN0vcnS18uvh
 B1WALmdb7GVwKiR13vnRTef3I3pcuSa1Jmzpau0/O3KCg9neBkUL3fmN2OpUKRhboIr1
 PgBjM5fcajOn8qma8tCJWnGJlpn3MZwfkwNFBjW+9nLxmaqDAWAi8xjFGoaZGz6Qik1Q
 y43ZULyS0vd/3e+ZB0+WS/mM20uuz4JM5cNXl2m8TFsfLjZq4JMhmCt9BlCfb2oqYXqm
 nEaT/T2Hn1csr+a+Y+vlubrHO1X/agV6r+dUEq5Zn2bz/LoZgB07Efl31Mm8uLlqwXtE
 KJ7w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783667542; x=1784272342; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jX+mY68Wp679STgVacYwKizXqn0kRASgoNkNa6aH0yM=;
 b=OKvYoJAaLD209hgxIolu+ShgwMZovYhClJo4n6nXxpswGw292jCaJDTovJOyywnP7m
 C5F3pW2E0/KjuM62/3N6KM/oMFnr3mVSO7ROACaCr7Osj2fXSElv3FXmokSPQJPlw+Ix
 Dp96KSd2ge//yQQAI4/pEYZqOiphmRtjtl7syvh71QhJgdeU4p5i+kWBAyD8k6/Dha6l
 Q+mnR6036f8U+3FwwjbEfDZiv+nqCQvtwnNPpHxa5vgzbZQse802RCvRgjEZWXlnQawy
 kHc2RfgQv87YV63mZbO5Lr+tiR7u/mXNHl9xhaWoTePDmZTSmftnAE5dLCF5ZLxJaK2r
 67Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783667542; x=1784272342;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jX+mY68Wp679STgVacYwKizXqn0kRASgoNkNa6aH0yM=;
 b=XQk+WbWzWyVmImLHkWMzkK1R/eAWa7Ok+mlZPAy/fhmdxbqldYA3xDyhTTeZOg0xnW
 JYZQgvNTci1zBAjgl3twWadJ+JlcX7J512sO2p1z1MqKsAr4wrQDpxQ+DmHCxWqiVA2/
 PpNdxsuus1L6GFLaovMt9sQdNM1TaklD385uh6/82cOyxbLOEglyf0uO5ON6hw6Dpvq2
 Ydyruz7YKZncAjlsE0UaxbRJoFx+4xyQjx+R1GNYlNSgTg9GI+YtW+p/FKhC0Ty5/OOg
 +yCLYtCbrIvCNx+1/E2KBuxSo98MRbY3hys3bmSXtDt2tNz8avC/Bz5yJZC0Sc0+CAfy
 rNqg==
X-Gm-Message-State: AOJu0YxhQljFfJLmMnnAhS/qGSt4DSx/VI+LU6nGgpK64N4k8go1Bg7h
 V8qru2k8gHHwoeVktO4msbzPHdI4rUqLGhgtXxee0qk6ZbKYiBWIRxu1amAaqegayi9E9m+223N
 tkm+JI5c60A0n8Yae3j1Iw8h7CXIj07E7/W93QjecSw==
X-Gm-Gg: AfdE7cm4aJ2eIWQviS3GxhOMl6kUHti2t4XvlAObxiHPV69Qc3HMUmkKhba+A18/IMo
 Gy8dxkWt+nP5TFWHpS05e44LfTCHvVsvasxsPOg+MgtSbNfW/H4xeaZY9nW2aK0lP3o5crSK4HA
 Ab5dSbPva6h1yDZxaNAb/BjDUphvBq3BBgLmq9RSQldrA6JeGXcC+39qCMLCxP82RZW8d+PQ5w9
 zB4tt/BOpYdBx+InzAL5+ca0nOt+ZruRgJpMb2xwUTGSEJw+sUUvvHqLt4TMpMaPNogGmF/q2E1
 /LjncFFmhEDNsa4nGgSdnROrjzpxVqwV1D2AfAe7caiCmAjM0ZNM4gQNWPKQDqTM4yyDv5xmTeW
 MySRZpbmo4LMdSq8CKrz282nTVqdPzg7ywmMSbAQHOuWnlGtdFAIM4OnLYEoO+ZpePc2ykERLDI
 ZjHlpp4imy77LanoYQtsQPGGBuiRWIUHHUOduXYLsCGUbPkrpxD8jBOeoWbkqJv6vs+dk/14Sjf
 hJoIwv9vPRSCAN8m3WHtkKAujGbQmgg3QSilT4tS16IGLhEBXAK+MZ/0aY5UykAZ/lWLmGXWrOj
 wPga8BAAxNQ0WhDoU/Srpym/IMoos6OqSZ1mcwVbSmzn1ca7dvekarShs0JZUEScqLrwQx+OofU
 nv9E0wg==
X-Received: by 2002:a53:b007:0:b0:664:e429:dd2b with SMTP id
 956f58d0204a3-6679f1ad370mr5333217d50.63.1783667541868; Fri, 10 Jul 2026
 00:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260708013019.288985-1-trini@konsulko.com>
 <20260708013019.288985-3-trini@konsulko.com>
In-Reply-To: <20260708013019.288985-3-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Jul 2026 10:11:45 +0300
X-Gm-Features: AVVi8CfZrc5fDDn8zwaHpbJBeulgIch0-a_QFL4-w7CSKHam3U9gbyA_ntZDe7U
Message-ID: <CAC_iWj+33V6M1MMGXkMLDR3iUEvVt_jwEcxfZ_xNH58y8Ozsow@mail.gmail.com>
Subject: Re: [PATCH 2/7] vexpress64: Correct CONFIG symbol logic around device
 tree passage
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Feng <fenghua@phytium.com.cn>, 
 Linus Walleij <linusw@kernel.org>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Raymond Mao <raymondmaoca@gmail.com>
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

On Wed, 8 Jul 2026 at 04:30, Tom Rini <trini@konsulko.com> wrote:
>
> When we don't have BLOBLIST_PASSAGE_MANDATORY enabled, then we're being
> passed the device tree in some other manner, via OF_HAS_PRIOR_STAGE.
> Correct our logic around which symbols are used to guard what is
> generated / used and when.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: David Feng <fenghua@phytium.com.cn>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Peter Hoyes <Peter.Hoyes@arm.com>
> Cc: Raymond Mao <raymondmaoca@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  board/armltd/vexpress64/Kconfig      | 2 +-
>  board/armltd/vexpress64/Makefile     | 2 ++
>  board/armltd/vexpress64/vexpress64.c | 4 ++--
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/board/armltd/vexpress64/Kconfig b/board/armltd/vexpress64/Kconfig
> index 49c7fda0b83a..a988c7198498 100644
> --- a/board/armltd/vexpress64/Kconfig
> +++ b/board/armltd/vexpress64/Kconfig
> @@ -31,7 +31,7 @@ choice
>  config TARGET_VEXPRESS64_BASE_FVP
>         bool "Support Versatile Express ARMv8a FVP BASE model"
>         select VEXPRESS64_BASE_MODEL
> -       imply OF_HAS_PRIOR_STAGE if !BLOBLIST
> +       imply OF_HAS_PRIOR_STAGE
>
>  config TARGET_VEXPRESS64_BASER_FVP
>         bool "Support Versatile Express ARMv8r64 FVP BASE model"
> diff --git a/board/armltd/vexpress64/Makefile b/board/armltd/vexpress64/Makefile
> index b0dd1d0af879..5f9dc2af930a 100644
> --- a/board/armltd/vexpress64/Makefile
> +++ b/board/armltd/vexpress64/Makefile
> @@ -5,6 +5,8 @@
>
>  obj-y  := vexpress64.o
>
> +ifeq ($(CONFIG_BLOBLIST_PASSAGE_MANDATORY),)
>  obj-$(CONFIG_OF_HAS_PRIOR_STAGE)       += lowlevel_init.o
> +endif
>
>  obj-$(CONFIG_TARGET_VEXPRESS64_JUNO)   += pcie.o
> diff --git a/board/armltd/vexpress64/vexpress64.c b/board/armltd/vexpress64/vexpress64.c
> index d68da0e3d650..8b6b96d757d5 100644
> --- a/board/armltd/vexpress64/vexpress64.c
> +++ b/board/armltd/vexpress64/vexpress64.c
> @@ -97,7 +97,7 @@ int dram_init_banksize(void)
>   * Push the variable into the .data section so that it
>   * does not get cleared later.
>   */
> -#ifdef CONFIG_OF_HAS_PRIOR_STAGE
> +#ifndef CONFIG_BLOBLIST_PASSAGE_MANDATORY
>  unsigned long __section(".data") prior_stage_fdt_address[2];
>  #endif
>
> @@ -150,7 +150,7 @@ static phys_addr_t find_dtb_in_nor_flash(const char *partname)
>  }
>  #endif
>
> -#ifdef CONFIG_OF_HAS_PRIOR_STAGE
> +#ifndef CONFIG_BLOBLIST_PASSAGE_MANDATORY
>  /*
>   * Filter for a valid DTB, as TF-A happens to provide a pointer to some
>   * data structure using the DTB format, which we cannot use.
> --
> 2.43.0
>
