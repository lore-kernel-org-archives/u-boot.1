Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BC3CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D70084D3A;
	Sat,  9 May 2026 17:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KwkEHw86";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B94E784D31; Sat,  9 May 2026 17:29:55 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6972784D9A
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-67c9616b4feso4389946a12.1
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 08:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778340593; cv=none;
 d=google.com; s=arc-20240605;
 b=LiSBX+zRrDpAHh6JjJx9AkM829h+2zmSm1u/LmMkQJFNugeehLb0iFec5h9qWa42as
 UMt703sSLRxvRkD9ocafXyFNTSl48/xplDm13C/uxwSrkdr627nI1VJ5VFthwiCG1JBD
 d3SmpSM0Dl5YH7/10eHwTEGTr6xwCIZ0OcFp/nckMU8BVUWC7q2tTN0phhDb4Ag+Ju0f
 3Y7IhDa2AXFWG8ir5tWBcKYuQVKUXMcnUA9nSfSClRtagcYNMJAW3jeWXz5591rTEC93
 ZInAWfUWO3PRMafz3hD7sPILV1ss5Xz5yC4fOiF8FEClO3TOQJoVTuPrnwXJhrob1Dxm
 IgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9ZzpWNzSum+YBP1fT+z2tsxd1D3z/7Ag4xFY/r7DMks=;
 fh=EMjGfQNeCXSfKbxw+peSvXYUsgNLrNriWqlGnbj+SO8=;
 b=Y+AYBh2z5PohdEdPp3rOVs+pSXHJrzj82Tl87Hb7UibvXXXeXAEUYU0BqeXU0RkQVW
 TZBpopSfHm5dWN+v4lW9BPUw8ewCQ4+8BILNtJzu/1LnUeOWc6GxGStj8f3PHnqYMzSX
 D+Eb7yCi5Z5NqOV6yifhkiBXNfrBTZFZJMulXJz24n6iqOq9LR0lavaFtwSCMbOxMdaO
 ozswxhjAKaO1BrK/nAoIIUL8CdkWcDoIGqNF5aG1TjbCJGOVqxjNpXodrTIAjhPBUWQE
 xuehxgza5X9QhEkRmjhynKFSvmnYiQGS7Kbau1bticvmEMA1/VYZx9J1LCg/WM46eLMa
 z/Eg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778340593; x=1778945393; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9ZzpWNzSum+YBP1fT+z2tsxd1D3z/7Ag4xFY/r7DMks=;
 b=KwkEHw86O3v2l7F3/KiwXT1X6tRSJo59Rv8KsGiuwrW6DgL/M26nOs5w5yL0hkuxHW
 jEkxqNk2DAKUutWIJwC1CMwBF2GXq2wJ0HHqARP3sVWywytF1y/2djGRCLMdyEGo/4Tf
 8lnV/7RWfK5bcCvJAJOzziwIqEWAaa3lYjc86UQByMcM+r2RmzouydSqAfQArAXroxL3
 OkZmjRMUcQ2rbfvr7d4QFIHflanUYfXih15keUEkAv9Jjp3MaZEn8/fb8OC30c7Aafxe
 eF2/RU4h7P6LclPEVjoVennjsroA3+N06mdjmeEdjzIDfpJDsS6spk69JpPBJNcznFST
 qlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778340593; x=1778945393;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ZzpWNzSum+YBP1fT+z2tsxd1D3z/7Ag4xFY/r7DMks=;
 b=i3+SoqKmnZKfQ7gnjdfFaID6QJzMKeHTaza8xCTlZ79tQ6Hpd3v8vaiK8rTJ1+cAmq
 SdQKfUwkVnRlvX6/cKzio8jnNAU6AwQrweJvqZJpJfeJ60sfFBZsFqQMr/pRUBt4iXN6
 6pgSUdcgYZTnmW6VlbB0bo+VC9gFZTS2K642ZwUxdlFesJjVF44ESbe9Vgky35gkQfHu
 ThBoKBkOpekX8zDRiQ764ZhNfvuWfuzzGe3vSPtI4/ANO9V4TRvanPmkKZxoBVLhgBxV
 Pdvgt52fHs4+vxh38Poeq/O3e2+rpYWXk2C5lDaKlnZXmJYkAtcHcXakKCsfHzaGE9Uk
 qD7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mVVD3EawQl0GpzZaWPqZlX9EXKM2v5VTDzQKMuE7uKYixIw1PqjWv8HiOyDWZpj9cHqCmrKk=@lists.denx.de
X-Gm-Message-State: AOJu0YxAx9ivVjPBvbW2EZY5XFGrMFUgMiizbXU0Sc8GkfwgqEdw8YxK
 4EA+CQdsNgsNFlCC5Iq81wUeTVhPoNlbkA/yAZlwNRefHWuRMNR6keokLNcOQeC+uJYrp1Uo5bo
 5qepngFAx9qHe0cIFnXQoFUJwUN7vM8ryz8YFots=
X-Gm-Gg: Acq92OFXmYpnEBg8YrJ8MCfFoXEgCV3pkZzSInBmMwwl9YKDMkvqlKEAYsZRKGuBOKf
 y6ZrDYUhlLppAMogmaqPmxdRgh+SWV/GoWGGE0POyBHpS4vChPnqqC4O4Nv4j5G7iYbhEvu3wWT
 5j2UH8/BAg9c/YoUhK+9dZ8vCotsdhhc8bBYZavpgigIlm8cTAydtr/h/WwiPSx18FdsoQKM1Bu
 oJPvQXPPGr0YPF4qjRLbrJXSDmw1yYt8T2HXuHM8DN4MO6jJoB9DaD3QT3AFIX9bW26PsWrUiSd
 XK71Dqq7oxyW+K0TL3H8qYpM+T8HUsMgNyww4Wqzq/YwN612wp87SlXprCzy1zuymTeofcCIGJC
 GDWMHKCouAnw9dgdJUySuC6FHEz/Vx9EfhHIiHvc775umwS6ka5Qdo211OOo448GjUXeSGg18Ob
 QI
X-Received: by 2002:a05:6402:278d:b0:67d:d904:df2b with SMTP id
 4fb4d7f45d1cf-67f706f8439mr1059126a12.7.1778340592713; Sat, 09 May 2026
 08:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260508154108.336B968BEB@verein.lst.de>
 <20260508154239.1E16368BFE@verein.lst.de>
In-Reply-To: <20260508154239.1E16368BFE@verein.lst.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 9 May 2026 16:29:40 +0100
X-Gm-Features: AVHnY4J6AOJIE4WDe15oO9NaTtGbJnu9nJrcK9OI639f1N5AobTIxDlezgF2CLs
Message-ID: <CALeDE9P8OiWqnRDtBHbg+Rk3VFsy3MzUZTeg+V30ygLgt76cPQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] core: Skip parent device nodes without a DT reference
 when looking for dma-ranges
To: Torsten Duwe <duwe@lst.de>
Cc: Simon Glass <sjg@chromium.org>, Matthias Brugger <mbrugger@suse.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Andrea della Porta <andrea.porta@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>, u-boot@lists.denx.de
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

On Fri, 8 May 2026 at 16:42, Torsten Duwe <duwe@lst.de> wrote:
>
> From: Torsten Duwe <duwe@suse.de>
>
> If a device node got created dynamically, there is no guarantee that the
> parent node has an associated device tree node which could specify dma
> constraints. Especially PCI(e) enumeration adds intermediate "bus nodes",
> also dynamically.
>
> Try harder to find the correct configuration by walking up the tree until
> a DT association is found.
>
> Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

>
> ---
>  drivers/core/device.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/core/device.c b/drivers/core/device.c
> index 779f371b9d5..9de64dbb3c5 100644
> --- a/drivers/core/device.c
> +++ b/drivers/core/device.c
> @@ -459,7 +459,19 @@ static int device_get_dma_constraints(struct udevice *dev)
>         u64 size = 0;
>         int ret;
>
> -       if (!CONFIG_IS_ENABLED(DM_DMA) || !parent || !dev_has_ofnode(parent))
> +       if (!CONFIG_IS_ENABLED(DM_DMA) || !parent)
> +               return 0;
> +
> +       /* Look for the first node in the parent chain */
> +       while (parent) {
> +               if (dev_has_ofnode(parent))
> +                       break;
> +
> +               parent = dev_get_parent(parent);
> +       }
> +
> +       /* No parents have a node, bail out */
> +       if (!parent)
>                 return 0;
>
>         /*
> --
> 2.54.0
>
