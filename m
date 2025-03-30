Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FA6C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 06:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5D9C80F9C;
	Sun, 30 Mar 2025 08:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R8o7I9C8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01BDC8129B; Sun, 30 Mar 2025 08:48:33 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B760880BA8
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 08:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e6412063976so2377714276.2
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 23:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743317309; x=1743922109; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xsvUCq2vXDzU/b8+kxwwCu61rywjgcdMHKOvvI91T/s=;
 b=R8o7I9C8f8LX7LCD/1cmpfL8ANNCGMWqf5a+MC5bsZxoJcRrkFIliCMIuwV9IL/t4y
 yEPeK1TkKaj7CJDmu2n2fT7mBHuWZZ/7h3LGlpezuDgwpqql9N/HqaboucyKSv7ey7DG
 PrswBK1oXk5qa55E1Od8COFviaGNtIcALMpGT+aI2/6cGP7GDMpm3pVrUMH58vVRSl9Q
 K1t6CHaAMxqPMg8Yr2VZuqv6I/z6aC88JFr0jFoQlOXFDSywIQ6MAmAnzqcPygmgu4cR
 3DnkCTEjfQeApoeKR4lgst9LhqNgw6TOav4OqSi9xUg6OiMxEJCQWgsE1dg785bus5b2
 xJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743317309; x=1743922109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xsvUCq2vXDzU/b8+kxwwCu61rywjgcdMHKOvvI91T/s=;
 b=suko3YJ0HuDkTq+srtLD4LSa2xIa0g6zSgLXwIzvcTPpVabbiwTF53aphmhwEsuN4U
 JBgKcj6yNUJw9XQmqr+9aMA6AWqGDMQQied3o60oVsUexauN6kxir326LlnWHc6SHzyy
 YmTfOR2jpLWVg7/9Rj9PtUxkaIXwxdWT2o4jATXTqk6QykHU6jltfgn6aWqSWdrrCT6S
 DHGkDXJPOYUF4Yeez4oqsjtHSSBKXbtN6/JN2sm1b5Hm4YlQvgUDyGWrJqM3k7K0eF2S
 rDFw49lY+HnIKpAdlgmDwahhPjLcdCgYhv5jNi/DvDIjBPp56RnHnqDIx4aAjas9ypIw
 r/dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyX2RKtTlap+sURmA4+hwLID3Qmb3goI9Y27YcvGaog8dJWfoP5AXd7GCcgltrFu47gfqrLNk=@lists.denx.de
X-Gm-Message-State: AOJu0YxEatybAxfCXjAewthFMZ9MEnyfQXzikwLJNvsv4U32p/Is8+e/
 BFYievOkzFxzbsuyL24z+TrIwH7+n/OXLfF0ULJlNq6+0uOzXPFfTo5BC6AGi3VSVhKu8c/SxMI
 dlvc1RRa/YhGYeui6D5ON1wQb+OTEIlszmyGzHg==
X-Gm-Gg: ASbGncvjgxhsUdUjacnMWszOzpxpKepAI9DBXbxwurPhd++DWDtDGUnXqq0bY34jCFW
 VR8mKaX2niml+L30kKESVMgyORATuc0uIKBWMTj1/0WJgDXUjzS2bqJ9kBn5/Lio8fjY8SYJv+z
 RhutJID07FgSrC2Ip5Aacx85W8iw==
X-Google-Smtp-Source: AGHT+IGap7C8CZAGk1daaWcyPYXPBg1KCV/3z95lt/3KEjUdrmKnevymtVuS5cZQn2UGBkX9ODeZMK2dsrYijHnwGVc=
X-Received: by 2002:a05:6902:228f:b0:e5b:240a:ccdb with SMTP id
 3f1490d57ef6-e6b83920b35mr6518683276.20.1743317309654; Sat, 29 Mar 2025
 23:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250315221813.1265193-1-CFSworks@gmail.com>
 <20250315221813.1265193-6-CFSworks@gmail.com>
In-Reply-To: <20250315221813.1265193-6-CFSworks@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 30 Mar 2025 09:47:53 +0300
X-Gm-Features: AQ5f1JrowjEb2EJqV_O_58LRXbPj-TY0wKGll9OsCUjzuHj4WXGNM7De2pDglxs
Message-ID: <CAC_iWj+C75YExcF0n1gyYCok08Q8VQaseay6c_OEzjePueiCCw@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] arm: Discard unwanted sections in linker script
To: Sam Edwards <cfsworks@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
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

On Sun, 16 Mar 2025 at 00:18, Sam Edwards <cfsworks@gmail.com> wrote:
>
> There are a handful of sections that are not useful in the U-Boot output
> binary. At present, the linker script moves these to the end of the
> binary, after the _image_binary_end marker symbol, so that they don't
> get loaded.
>
> The linker script syntax supports discarding sections that shouldn't be
> included in the output. Switch to this instead, to make the intention
> clearer and reduce the ELF sections that have to be handled later in the
> build. This is also consistent with the other architectures' linker
> scripts.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  arch/arm/cpu/u-boot.lds | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> index 63e82a09fad..817e7a983ae 100644
> --- a/arch/arm/cpu/u-boot.lds
> +++ b/arch/arm/cpu/u-boot.lds
> @@ -181,14 +181,14 @@ SECTIONS
>                 __bss_end = .;
>         }
>
> -       .dynsym _image_binary_end : { *(.dynsym) }
> -       .dynbss : { *(.dynbss) }
> -       .dynstr : { *(.dynstr*) }
> -       .dynamic : { *(.dynamic*) }
> -       .plt : { *(.plt*) }
> -       .interp : { *(.interp*) }
> -       .gnu.hash : { *(.gnu.hash) }
> -       .gnu : { *(.gnu*) }
> -       .ARM.exidx : { *(.ARM.exidx*) }
> -       .gnu.linkonce.armexidx : { *(.gnu.linkonce.armexidx.*) }
> +       /DISCARD/ : { *(.dynsym) }
> +       /DISCARD/ : { *(.dynbss) }
> +       /DISCARD/ : { *(.dynstr*) }
> +       /DISCARD/ : { *(.dynamic*) }
> +       /DISCARD/ : { *(.plt*) }
> +       /DISCARD/ : { *(.interp*) }
> +       /DISCARD/ : { *(.gnu.hash) }
> +       /DISCARD/ : { *(.gnu*) }
> +       /DISCARD/ : { *(.ARM.exidx*) }
> +       /DISCARD/ : { *(.gnu.linkonce.armexidx.*) }
>  }
> --
> 2.48.1
>
