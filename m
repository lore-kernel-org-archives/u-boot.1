Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A97DCD98D8
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 18:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C75E383FEC;
	Sat, 13 Jun 2026 20:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JRL4Gk/Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA3FD8466E; Sat, 13 Jun 2026 20:17:57 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B50FC801A9
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 20:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-8ce9ddeddefso23926826d6.0
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 11:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781374674; cv=none;
 d=google.com; s=arc-20240605;
 b=U0Q5PCUwAGrmniNZm/2lWrCRHzmzgb+RbaT8i9m3r4Df5qpLeyOTw11yV13pzZ0MY4
 M1gwm8snQrWoXlJj1sYj5OZS6/YMTLYnQkcx7KGR8ZmFBLgtFM2qh+JPxZdnwRrx5d+E
 gE5u9HnsJMQ6YAkttAv+jklBbVpraQ2MJ1COdOH7ZwioOsj/TzlNUf1rMmOQViSmTkdM
 68ex1PB4WqXx8ljvPyP10ESDb375+zHLb0XdwkFsBwopSbD5QlN0jZfbgrzzFMkVqmJ5
 uGqz9XV3TY9KM4tY7mVAOuW/PGXAZ4O8KPm/3WME2cNSLUEmxBHZra1IL0ZQ4+wPosTo
 EikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8VoW1kVQhxIOkaltttKVym4mVLNop4J6woL+o8fMoRg=;
 fh=y15Gw9MbzVJg6zcJoC+v/1gL2Oy47PtfagmC/PpPHgw=;
 b=bgBhRlaFTjtuBsFZ5yzKcl4W9GCwz9kWcaqUdzuOqtGV9cAZb4gH4uFP0lMuiXDuiB
 UZe5qlMa4IIKWRIiVRJ5rL4xfeMOeIF/Yw/vlcoAYGvQmNioH/r8p5CrEDkcDaLrICgr
 qYPDJYoq6A+q/0kAiNgNe0JeeYlnTOC2iSo3XY/XcBDoCaIH0cO/EMOLe3fKbUORKyuM
 fL1n69dU6ezGDzYOOdPPql7UYGDI1lC4QgRavmoewtxOilapdwKL2nArOvsNO7baeh9C
 swCHO5A4QsQ+Me9UOW4LFdB4r1teg0DtTfMwnRnRyy6C2cJ0qqseVWgNC2jAStKWETJy
 YEJA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781374674; x=1781979474; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8VoW1kVQhxIOkaltttKVym4mVLNop4J6woL+o8fMoRg=;
 b=JRL4Gk/YTY5LAhuXXOZ/xDbXf60PdC6YosdgVQ1HzSeYr+ABjfB7gW78vdvXUQ56YO
 ONHEv5BDyxQzgY/Ki0z6nIfQCR4fdRITztmMu9nhJn9lUUfhn0AOfhz9N5izg4MUpymV
 03m7HwfY+Vm/+XGC2gF7kDf+K2zCXOT/xK3bbsxWqR3KjqDSx/AqzgUXfGgf1xqQ0GLy
 VbQ8QHk3HeyDT3JoUqwv9IMOLrJBD0GujlrmScaTi7lmbmNZgQn0ez9sbNky6kupT3uE
 /xXArlGaVhtV6CqMFwpa0dEYbHqzfDqDiu8pbK4mG8itX3h31t7pRvtgnjg7wktRaK65
 je2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781374674; x=1781979474;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8VoW1kVQhxIOkaltttKVym4mVLNop4J6woL+o8fMoRg=;
 b=tPfTXbeMtlWedoQcDxJ77TRjiToDWhA4TohpEj2qYNlaor59dR+jtJ3PaAfzYt2JtL
 CjYLSk5+Orr9Vdi5XXj+JjIRtSVLpTWDyAx/BbM7mDtuwjkEjipNhHN8q3VF3dTlcs4P
 jeLJKUGjX++Y50/VIQxPlLFI8AZWiIKBGNM2iG1dkAoY4k69eaovZt4HXdm/hHm1wOsa
 2wkYHYIkGgtVLDLUZ3gcUJVujurCklvX6xhL+A8cimug0hluN1+fTiKWKeH0geDHwQdS
 kWdBp5mVwn2/jrG5Pj6TzHdtbkxNKeb8jXWm7kIuu00eQ4iwRPObscKmlyYdp5/j5sEk
 dE8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fXjyt5lk6IUVdzQGXdlAjGCfzobTr5Xv+Dhtf1UW86BxwODF//UjabBHh4BiGPMW6SVcZ42M=@lists.denx.de
X-Gm-Message-State: AOJu0YyPoqJwAr2DR0qNNdtNHJPxQlcTp9LLB0xqdgw+Mrg8MTWl7pO+
 69J6BGf8k3n8yde/lXIfFCvloDT3/HLWqCwB+fTb9yKU2jjVizk6snFiMJDVims34JMkmC35zW+
 AdHRF/yi2Be71gPGrSX87+HQN8zvFKcY=
X-Gm-Gg: Acq92OGeuEnS2ABFPVaeMbxdRIYvFYY/bWV+FJSqkAMvM9YGLYHqr8pc2WxPKS5nlu4
 8zO41tSQGqFYXMUd3gm0DJw6sSLMl5nbY/kqhxdcsgssAcrw2f/bPUCjz/T1qqF51pH0XaZkbpO
 x04WCiyRMtXmWMFYSmHEHDTlX8r13e3FLCiITm7FjxMq7FZQvS+MjryzPOJuzx1fgYLr6Xqxl9P
 gtKyMevRyR21VK7wWQxmlJmr541LV4anw+5+V1Pgx+KSCGawhia5fAky0jcWt6zUtoo9OX50rVu
 N+n9uyqkIDxdUR8/wfWmiow8tq09Ot6s9Ypz9a8nIWBkbYFNKg2E46RVknhdFEoTkH3vggoiOUQ
 qYLYgLigRGNy86VWKTun+gykbhLHsfm5g3DYK/Pdgu5nSiwwzbIQyhJVs6ZC10c2A8n1l640vQf
 O5vQ==
X-Received: by 2002:a05:6214:2b93:b0:8cc:d165:7ed6 with SMTP id
 6a1803df08f44-8d32f7910ccmr139043276d6.43.1781374674438; Sat, 13 Jun 2026
 11:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260613172444.4023442-1-heiko@sntech.de>
In-Reply-To: <20260613172444.4023442-1-heiko@sntech.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 13 Jun 2026 19:17:41 +0100
X-Gm-Features: AVVi8Ccm7tqiCzTCowRZERXueq-cHjJrOyjhZtVnJFFiq-aBXcoGrnq3oiY-veA
Message-ID: <CALeDE9Nu1TyY_c8USOqt-MQKpDXVGGCWMGzKkEJL1JPBkTQ8Lw@mail.gmail.com>
Subject: Re: [PATCH] lmb: Add the Rockchip architecture as requiring DMA below
 4G
To: Heiko Stuebner <heiko@sntech.de>
Cc: trini@konsulko.com, quentin.schulz@cherry.de, u-boot@lists.denx.de, 
 kever.yang@rock-chips.com, jonas@kwiboo.se
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

On Sat, 13 Jun 2026 at 18:43, Heiko Stuebner <heiko@sntech.de> wrote:
>
> Loading EFI parts like a Debian-Installer on Rockchip SoCs creates
> interesting results, in that on some boards the Grub bootloader can't
> find any partitions on a USB-Stick, or loading a kernel from Grub spews
>     EHCI fail timeout STS_IAA set
> messages before failing and on others the loading something like efivars
> from an eMMC creates read errors and making the MMC vanish from U-Boot.
>
> This only affected boards with at least 4GB of RAM.
>
> These boards have at least 256MB of memory placed above the actual 4GB
> address space (due to the iomem being in between) and while kernel,
> initramfs, dt are generally loaded to predefined addresses, additional
> EFI parts (efivars, etc) are likely just loaded "somewhere" and it seems
> this always landed in that higher up memory part.
>
> Also in the Linux-kernel peripherals like EMMC, USB, etc already run
> with a 32bit dma-mask set.
>
> So far, I've seen this on RK3568 and RK3588, but as the same peripherals
> are used on most Rockchip SoCs, it makes sense to limit this on all.
>
> So add ARCH_ROCKCHIP to the default-y list of LMB_LIMIT_DMA_BELOW_RAM_TOP.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  lib/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index cf13ac1bdad..9e0f0ad7d06 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1298,7 +1298,7 @@ config SPL_LMB_ARCH_MEM_MAP
>  config LMB_LIMIT_DMA_BELOW_RAM_TOP
>         bool
>         depends on LMB
> -       default y if ARCH_BCM283X
> +       default y if ARCH_BCM283X || ARCH_ROCKCHIP
>         help
>           Some architectures can not DMA above ram_top boundary,
>           which is after 4 GiB or 32-bit boundary too. Limit the
> --
> 2.47.3
>
