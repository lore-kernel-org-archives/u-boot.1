Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438F9D5A6E4
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 06:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C275289BFC;
	Tue, 26 Nov 2024 07:31:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jVEucEyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB46589C08; Tue, 26 Nov 2024 07:31:55 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6FF588F20
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-724e1b08fc7so3467585b3a.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 22:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732602711; x=1733207511; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yNz8xDRL1bPbYz6Lw6aV9leVyjEOvdHASUEXnZNakfw=;
 b=jVEucEylWq/nKQyYbUK9OMFYUAJ4muPGwMEDgO6xAy5PpUZ0Kya+tZZLHLX79NJWIy
 o6fgOOQN2SPkjzrgVhBfTKxcQWY0wp+k2PnlH/I/WK1b/0bna3kR0L9sN+1CCI3m9EBv
 /3datS57CHu1bGtWCKFdU7F9r2PuIH3n2HAQOWm0c2V1fZxuESUKLMfUgpWomF1B0G62
 tsfUfG28nhGo5iYxp/sP6jgZrQOIW1qJ2y5C9aorMx91V/WjN4+isojc8wDPz0LQRk8U
 Uw3Wo4H41Acbl+q0KrCqpS87UxqFdXXjpfJvjd/6fDaHjk9C5f5kfaK0Avve8jprqyMI
 p8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732602711; x=1733207511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yNz8xDRL1bPbYz6Lw6aV9leVyjEOvdHASUEXnZNakfw=;
 b=bfsgGYeEQ7yOjkG+iftDd0y4m2erC5JaiGVYcbUk8u/QjVrmzzwKQdQ7gBvOpjVw2x
 9Meqv5bzwXIrBal2m/7AKQB9bvJ9nnPxg1XpURuh9uHBRuAlC+C7DA8gvIS+cfjvyID/
 VpeUMLfox47FJ5futMkLVKtgk/jt2v4YOgeuQ8i949Ir/1Hq8BhCHgTlJyStLjqEnHob
 vhn80mXUgqGNTBXRdyftsVNyshzIJkzH1z3ZghvuIpyHoWi1GoisYPVeI7GBs7s6ciCN
 kBh9Q703fIfThXQgj++XLi0KtpQbGND55th1zXNMxUDRN/LdCJyZIGD5R+kw2kX7RoBv
 IA0A==
X-Gm-Message-State: AOJu0YxIhVM2iTUJFKf/1Z2Xh3RGALP+WeAX9dpnTgOeSkGcoAZX1POo
 wDiapGRKxOX4hmRZkA+4fXNiU68DCD/4TwJWexYERAg3xqBb4jzTqpx7gjKojHDHzOLRSZBKozq
 fBtxysk2Z7MFkOLI0yYT3qghwQNRJBqdgDGLRvw==
X-Gm-Gg: ASbGncvTw00IsVuhiQSl/uMAjA1tNVZ6oCI9NVUSsSV/WmoN28tcamiN04lWcQrw0MO
 ZhtZV+Lfa74+8V/b3+PGUZ7H9l2B+/g==
X-Google-Smtp-Source: AGHT+IE2Z7UYzjyFg2SvT1pnYfd/8WdnMjTNr3lOFjz5gA1M78D09iPPMqGdArn/JjIRzWoQODlS9z6wSZJMYNAACi0=
X-Received: by 2002:a17:90b:380c:b0:2ea:4c5f:923e with SMTP id
 98e67ed59e1d1-2eb0e12578dmr18928607a91.5.1732602711370; Mon, 25 Nov 2024
 22:31:51 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-2-sjg@chromium.org>
In-Reply-To: <20241125204456.1525752-2-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 26 Nov 2024 08:31:15 +0200
Message-ID: <CAC_iWjLhYSHbwgN=Z+-4wk=gWzVrxHs_mb4focBchMXyYPL=7g@mail.gmail.com>
Subject: Re: [PATCH 01/13] efi: Define fields in struct efi_mem_desc
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
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

On Mon, 25 Nov 2024 at 22:45, Simon Glass <sjg@chromium.org> wrote:
>
> There is quite a bit of confusion in the EFI code as to whether a field
> contains an address or a pointer. As a first step towards resolving
> this, document the memory-descriptor struct, indicating that it holds
> addresses, not pointers.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  include/efi.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/include/efi.h b/include/efi.h
> index c559fda3004..6f48c6569d5 100644
> --- a/include/efi.h
> +++ b/include/efi.h
> @@ -273,6 +273,21 @@ enum efi_memory_type {
>  #define EFI_PAGE_SIZE          (1ULL << EFI_PAGE_SHIFT)
>  #define EFI_PAGE_MASK          (EFI_PAGE_SIZE - 1)
>
> +/**
> + * struct efi_mem_desc - defines an EFI memory record
> + *
> + * type (enum efi_memory_type): EFI memory-type
> + * reserved: unused

@type, @reserved
> + * @physical_start: Start address of region in physical memory. Note that this
> + *     is an address, not a pointer. Use map_sysmem(physical_start) to convert
> + *     to a pointer
> + * @virtual_start: Start address of region in physical memory. Note that this
> + *     is an address, not a pointer. Use map_sysmem(virtual_start) to convert
> + *     to a pointer
> + * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
> + *     bytes)
> + * @attribute: Memory attributes (see EFI_MEMORY_...)
> + */
>  struct efi_mem_desc {
>         u32 type;
>         u32 reserved;
> --
> 2.43.0
>

Thanks
/Ilias
