Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3B9D63939
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE421892B8;
	Wed, 20 Nov 2024 14:38:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UFzHepjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 683A7892DE; Wed, 20 Nov 2024 14:38:13 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2195B89270
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:38:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7ee11ff7210so3598915a12.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732109889; x=1732714689; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dAHsE1lkiVB2sDMWIOOi8IbVOGlzIZziSAb96sgaWLs=;
 b=UFzHepjdSNTVxM4aERZcOTPbimmkhpI3v3ng33OzuIRlvDdDKcb3yQuPwQW9CxpSMA
 ByJvD+hT0KDuCtADWfRoRaURdKQeo3bJ3XCaoVwKi/Nh4Rdf7X6DyV8BTrtJKRQsKwag
 nu8R70bd7siCKkUwACWLrh/NPKwaikmFvDVt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732109889; x=1732714689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dAHsE1lkiVB2sDMWIOOi8IbVOGlzIZziSAb96sgaWLs=;
 b=RTx0fcTQV8VjVunh5z/wwMbl4hQ/qk4S4Aas+ZHzESeMBbnErLly6HNSXWNFnm7cvt
 3+7kArHK2qACJwTeVnuJ+qbX1v5sHDntqbPPfZMR3jT3tfodRTx1RBtNr6P1m9QB1owi
 c6bHlZiGTeEkcwAgAKDc1tGKohRA3i62xqS8iNm3yIkvs8EQpzR63JrHHXV6ed+U342s
 N+k9P0C5WXdKK3GfeHqTq92ycryH2VxOzDKTKuE6hDttmU1pST7LmtTUTOqa9QxQ4WEA
 3O5aGiF/2ClJ0u9M6WkOEo3ZCwH5twO10Vy2U5MgBa/efUdYGSXTwVWlS1BPIIGJ02SL
 B5lQ==
X-Gm-Message-State: AOJu0YyqwTY07zl7QnYf8pHWyacF2FBjVWdqaqIj7uORvaEx31scs/um
 gogypEdtOAJBCiyEkZK/i/EhsOFNhP/BQ8sdDsBHYLQ3P7ieFHNCbHekC4QmzP9hQuO6ZcM0zUw
 7fMOoTOjPmIc3kzATnwwNBye+Ce1HPvFW+9MIg9N7rcg99Zg=
X-Google-Smtp-Source: AGHT+IFyNfFGL+ak0rXmhlwohQ4Pk/5Q3j8Y2ASdIsj571rpYzDgfED4UpKC2RJeuLxo50X5J+gwXocRmGYW8Jtrho4=
X-Received: by 2002:a05:6a20:12ce:b0:1db:fff7:25d5 with SMTP id
 adf61e73a8af0-1ddaecd0194mr3821938637.19.1732109889705; Wed, 20 Nov 2024
 05:38:09 -0800 (PST)
MIME-Version: 1.0
References: <20241120100157.485418-1-andrew.goodbody@linaro.org>
 <20241120100157.485418-2-andrew.goodbody@linaro.org>
In-Reply-To: <20241120100157.485418-2-andrew.goodbody@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:37:49 -0700
Message-ID: <CAFLszThUfBskWcoDjSYMajDE5RWa+SrrGHmc0Hd8HdPKAyYsLQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] sandbox: Correct guard around readq/writeq
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Igor Prusov <ivprusov@salutedevices.com>, 
 Tom Rini <trini@konsulko.com>
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

On Wed, 20 Nov 2024 at 03:02, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> In include/linux/io.h the declarations of ioread64 and iowrite64
> which make use of readq/writeq are guarded with CONFIG_64BIT so
> guard the sandbox declarations of readq and writeq also with
> CONFIG_64BIT.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>
> Changes in v3:
> This is a new patch in the series at this point.
>
>  arch/sandbox/include/asm/io.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
> index 3d09170063..f656f361cd 100644
> --- a/arch/sandbox/include/asm/io.h
> +++ b/arch/sandbox/include/asm/io.h
> @@ -39,13 +39,13 @@ void sandbox_write(void *addr, unsigned int val, enum sandboxio_size_t size);
>  #define readb(addr) sandbox_read((const void *)addr, SB_SIZE_8)
>  #define readw(addr) sandbox_read((const void *)addr, SB_SIZE_16)
>  #define readl(addr) sandbox_read((const void *)addr, SB_SIZE_32)
> -#ifdef CONFIG_SANDBOX64
> +#ifdef CONFIG_64BIT
>  #define readq(addr) sandbox_read((const void *)addr, SB_SIZE_64)
>  #endif
>  #define writeb(v, addr) sandbox_write((void *)addr, v, SB_SIZE_8)
>  #define writew(v, addr) sandbox_write((void *)addr, v, SB_SIZE_16)
>  #define writel(v, addr) sandbox_write((void *)addr, v, SB_SIZE_32)
> -#ifdef CONFIG_SANDBOX64
> +#ifdef CONFIG_64BIT
>  #define writeq(v, addr) sandbox_write((void *)addr, v, SB_SIZE_64)
>  #endif
>
> --
> 2.39.5
>
