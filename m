Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82B0CF042B
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3949D8907B;
	Wed,  9 Oct 2024 03:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jFsu3FK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9B4889069; Wed,  9 Oct 2024 03:51:42 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AA9C89065
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71dfc1124cdso314754b3a.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438699; x=1729043499; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rs6i3CGqLTM6hqNMH6RspD9qKpI5O1hGR1/+G0Pv2Lo=;
 b=jFsu3FK04oYO28Fjyu5GRsoT3cQJyTidg7ZnLGe0QEWqiuC3z5Pvsm7EVneVvqgQku
 w/EhJeuY3lbf1uKmulHtkbTo6eQrRwhUR48sW08qPN9kiRshgzHeaEWPi0PwFeR14IIv
 62TLcEBOT/Brh5/PaJHCNYT6C+W9Es160oP8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438699; x=1729043499;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rs6i3CGqLTM6hqNMH6RspD9qKpI5O1hGR1/+G0Pv2Lo=;
 b=QWx6+fitlXXNJjNWsX1cmI8lucUrPCL5SD9gu46jZFeI4fWECrnAE4OBUgS5wYrQqT
 48oh/vuI1z8P3CoERpF8zXX0jGlfpGt+rZd1/fir3aoRqnepTRldvVaDGYk0K/rsF7gC
 swgwVPtkwBjWQDL//oAMXWM+iMRIF8KmDn/BciefSKWDuk9CjRxYvIqBI3zQlu7Hzlfv
 VTIiDN5zkrHwQGCAD9OZJGGKzfLz+WUaH5E2rfJkjoPA7cSPw4moUMBcOWfNY6q8tY/9
 4VbjfGdVyCCkky3EsKUD/bL4FqMpOwazN7wL06UC99AIggyw5CcMHx0J9mTNVJrn3719
 h+rA==
X-Gm-Message-State: AOJu0Ywr7MInuIksg3XAsRmLckztvwV7FzHEekr/RtI5eLs0XWq5i0h9
 mbsE54K0O4toKKKZfii7xnMk5Mo+VQEwUaoZiK6JC2QrRmI/AdDeBkM/g0YECSJzuPLZGye4+j1
 aNd79w5VA8d6c78vB1SRcz9wcC5Gr7SDMSqok
X-Google-Smtp-Source: AGHT+IHSIg1GVHZxgGG66TFmmSw+p5CqhA4Wf2tdAWW2GGOQw+2xfug32hIidmVtGm5N91/EfJFGYV4oVH/2mfG0nN8=
X-Received: by 2002:aa7:91c6:0:b0:71d:eefd:e3de with SMTP id
 d2e1a72fcca58-71e104a8637mr7625934b3a.4.1728438698329; Tue, 08 Oct 2024
 18:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241003141029.920035-1-ravi@prevas.dk>
 <20241003141029.920035-2-ravi@prevas.dk>
In-Reply-To: <20241003141029.920035-2-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:51:06 -0600
Message-ID: <CAFLszTi37m5b1T03NnB21OTBgqd1dre+o-6AjjsQvUmY4vnN0g@mail.gmail.com>
Subject: Re: [PATCH 1/4] serial: fix circular rx buffer edge case
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
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

On Thu, 3 Oct 2024 at 08:10, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> The current implementation of the circular rx buffer falls into a
> common trap with circular buffers: It keeps the head/tail indices
> reduced modulo the buffer size. The problem with that is that it makes
> it impossible to distinguish "buffer full" from "buffer empty",
> because in both situations one has head==tail.
>
> This can easily be demonstrated: Build sandbox with RX_BUFFER enabled,
> set the RX_BUFFER_SIZE to 32, and try pasting the string
>
>   01234567890123456789012345678901
>
> Nothing seems to happen, but in reality, all characters have been read
> and put into the buffer, but then tstc ends up believing nothing is in
> the buffer anyway because upriv->rd_ptr == upriv->wr_ptr.
>
> A better approach is to let the indices be free-running, and only
> reduce them modulo the buffer size when accessing the array. Then
> "empty" is head-tail==0 and "full" is head-tail==size. This does rely
> on the buffer size being a power-of-two and the free-running
> indices simply wrapping around to 0 when incremented beyond the
> maximal positive value.
>
> Incidentally, that change from signed to unsigned int also improves
> code generation quite a bit: In C, (signed int)%(signed int) is
> defined to have the sign of the dividend (so (-35) % 32 is -3, not
> 29), and hence despite the modulus being a power-of-two, x % 32 does
> not actually compile to the same as a simple x & 31 - on x86 with -Os,
> it seems that gcc ends up emitting an idiv instruction, which is quite
> expensive.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  drivers/serial/serial-uclass.c | 10 ++++++----
>  include/serial.h               |  4 ++--
>  2 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Perhaps we should use membuff, like in other cases, since it has some tests?
