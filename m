Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95425C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C9BF88718;
	Tue, 11 Jun 2024 20:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mkIBjejD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A17C988735; Tue, 11 Jun 2024 20:52:13 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F227E886DA
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b0645351ebso3959986d6.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131929; x=1718736729; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yoq6Wm+MO0qMARGCSseRxk3HVW40pOh5gD3NiPmwvZ4=;
 b=mkIBjejDoyhmNfCiukxWi0eIeNImWtekUxsuneOfS54rrbmedqqZDY+E54Pu0XQbnC
 WxazP5eTxMI06l1TYVmI7Qy7ixIkoIuUmgJKsWZae4UnWfXhD7gwhFpIGjVbLB7BNM7x
 D1w10dIt5FYHKQ/cyQd23l3avm+XvyU2Fx6LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131929; x=1718736729;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yoq6Wm+MO0qMARGCSseRxk3HVW40pOh5gD3NiPmwvZ4=;
 b=xKDxoFjux10vy0NGX3UDM8GpK/87gGrWL7FB/syz7ciMPQgIxSJ4YnBRpFDzPOPb6j
 oDS2+L3M9B0ykXcMeAZcDdKkt5aT8Yok6KjN8w3noaACKuXPO52YE7eUtK89vxzLzYqA
 vtGWip35tVGmmu55jt+Xe2Ji822QnI/ZlyB8+zSwrG7XKeKz+B8tKX12Tbrv7cDFDy6F
 8JiWPJdO6FIsO9rZ5/skFxWk+t0ADwn6ky9a7OuKEvS2LNjgQv2BQiEtgG7TPemlHHkj
 4zzTUFPewDi73vzVaCRWxivGoNuM6RkigIv05h7roT2IJcUsa8bVK6Qq/uK48lVT5ZnL
 ukEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaZ+GxhrXpAvXD2zxUfAetPcPmt+oymKwDGWT10W6dhJrgyKCG1hCNYE2oy47qpc93VWDiiYKl9xUnQ2XHeohKcwgL0w==
X-Gm-Message-State: AOJu0YzeAzPDp5PkM/dvCb4qe8oPrnWn3lW9VqV++zyqf0YlbHloFAEN
 fGgBz6UItZ9Z8RsDFFDkf+he4m4vDT1Wd17mO2BoUYvtJzuAeneoaw+IUy0tDpixFj9qFtF0qDZ
 k+jgTF7atRJL53kwj6mYg+h48jrf49dWxEALl
X-Google-Smtp-Source: AGHT+IE0eSOIB4WiHpIuB2iRP1iq5D7HVzISFJr+OwVvLQsjqNTh53Wcx5YmLf3wUCbGlbLY+MMlLDRuR3D2+2G5P1k=
X-Received: by 2002:a05:6214:469f:b0:6ad:6d06:ea9e with SMTP id
 6a1803df08f44-6b059cef258mr178095046d6.37.1718131928875; Tue, 11 Jun 2024
 11:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240611-misc-20240610-v2-0-028e82b0b620@cherry.de>
 <20240611-misc-20240610-v2-2-028e82b0b620@cherry.de>
In-Reply-To: <20240611-misc-20240610-v2-2-028e82b0b620@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 12:51:58 -0600
Message-ID: <CAFLszThS5Kqrg1WfeJeoUency6vU8eYQ_U8dQvLzL0eobqDvQg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dm: core: fix signedness in debug messages
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Dario Binacchi <dariobin@libero.it>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Tue, 11 Jun 2024 at 07:04, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> outp always point to an unsigned type in ofnode_read_u* functions but
> the format specifier is currently always using signed type.
>
> This is an issue since the signed type can only contain half of the
> unsigned type values above 0.
>
> However, this now breaks another usecase. Indeed,
> ofnode_read_s32_default is actually passing an s32 but it'll be printed
> as a u32 instead. But since the function is called u32, it makes more
> sense to have it print an unsigned value.
>
> This was discovered because arm,smc-id = <0x82000010>; on RK3588S is
> above the max signed value and therefore would return a negative signed
> decimal value instead of its proper unsigned one.
>
> Fixes: fa12dfa08a7b ("dm: core: support reading a single indexed u64 value")
> Fixes: 4bb7075c830c ("dm: core: support reading a single indexed u32 value")
> Fixes: 7e5196c409f1 ("dm: core: Add ofnode function to read a 64-bit int")
> Fixes: 9e51204527dc ("dm: core: Add operations on device tree references")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  drivers/core/ofnode.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
