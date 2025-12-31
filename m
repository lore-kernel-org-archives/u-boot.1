Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B30EE645E
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 19:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DBE58419C;
	Wed, 31 Dec 2025 20:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CEEiohWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0421A84183; Wed, 31 Dec 2025 20:30:56 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D6888419C
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 20:30:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b8010b8f078so1588826566b.0
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 11:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767209453; x=1767814253; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CRuHR4yBzg0KPNeF4Bzjhp5VczdW9irHqMAukkja0/c=;
 b=CEEiohWIaBDm+l7g1f8CeTInsKDz+lPIC/OPH6SHzmqU0sC0wDebmj8xcM7pKj1tOV
 kyWwdfx+RXyMarwQ0/ybxT9EmcXzFAj8wJ30mO77JuftbZIFMOsWa0YnYSN2dRMA2Nwb
 ccmnZfJgNSjIl4SYwJPqSIKD+L9Ps+/Bgvfuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767209453; x=1767814253;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRuHR4yBzg0KPNeF4Bzjhp5VczdW9irHqMAukkja0/c=;
 b=VaJDOLFMa1j3Ha+BVwFypHNcxKU0lBkRiyzu1NDtKoRfZhomoJdT9Awe++hz2jc5og
 GUoeHFBAkIQQSY6Oa57yaNoBXOqkFaJvHdF9dgYTTp5jJlDHDj7BqI0pCFgtMw1slHp3
 93sPnxJxDoPzAzWbg1rAoXwwPDerZBnKBcFude4m5cz+Ghv22KQahD2GUBktk0BpZ1e0
 AZtlNbpYN+HQY3jfz/tRYtU1hq8IwrUyajmgKgkKNIfVNExaYEm/HdRnhhWDco2iF4hs
 nW7BETaK+PHXyp3l82cckSefIo9UzjXkJO2f/lsiOgUiBlKdfNuCrZwuYHI6HxVFJ0eU
 pkNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkviu7D+j8QAQVEdm01qimDouZiUne1EQLYSObrAKAHkg9hA/s+4Srzb1eJpWnhPMT4jAx4f0=@lists.denx.de
X-Gm-Message-State: AOJu0YwsQy6h0kiwL4XF1KO/f5pA9KpvZdv7s64vXTR97s//0joa3X4h
 g1OWJfuG3yoSsJgmHkj4KEYTjz5uYnpavBhwgF8y3b27r/G6EsRJKpbEYQR3ocF70woy890RtoM
 hr+ztpYLWWdMb7aTZS1DpZwdCgcQSmHz7Q9BR011O
X-Gm-Gg: AY/fxX4hKTj9Fyb8KfZsAVF3GIUe9YBrSy86Ad+ZETCZIRY8VypL3V6kNn8H0D+nf7c
 wKqHZNm4dGGqP7Ab81cY3AanPxSkUcgNhxRKEXHuuBDpV2Ktaq5mr4VYdeSRwBsvdz0M2kfGtJS
 oPo1dzuZ4bRlsYs5P6aJHjhmFKqXoJNpasjBMCSTN0KmSCzo/ZcXI4twQSJjz/Mppukem04JgL8
 IRaxCVd4fNT4/whS4CXxLO2jJ77mf97F0NjNv0pt9K6fSNl7xWe915al+hxN4EVCvQln/NiK+Jx
 U3j6
X-Google-Smtp-Source: AGHT+IFupQg4ZkzCdRSMT7T9NX/mC67swFDBX4q7cwx3+ovdS6MyqTeOukMEqpJatxve6kTTDmFAY2fbdEQpAUDgLt4=
X-Received: by 2002:a17:906:c147:b0:b80:751:ee5f with SMTP id
 a640c23a62f3a-b80371d448amr3928526466b.52.1767209453418; Wed, 31 Dec 2025
 11:30:53 -0800 (PST)
MIME-Version: 1.0
References: <20251231134320.53025-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251231134320.53025-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Dec 2025 12:30:40 -0700
X-Gm-Features: AQt7F2q0xXdeU0NeOEbbwAIwZSDwQX8NT75Zcj15nwwXSTpDWtbiQOkcOUiRfXM
Message-ID: <CAFLszTjnzMJOPWnA-qfLaUO-4p6RBzPmjDqf12oxzydoVnkgfg@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: describe QEMU VGA emulation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, 31 Dec 2025 at 06:44, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Describe how the QEMU defconfigs can be used with an emulated GPU.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/board/emulation/index.rst |  1 +
>  doc/board/emulation/video.rst | 63 +++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
>  create mode 100644 doc/board/emulation/video.rst

Reviewed-by: Simon Glass <simon.glass@canonical.com>

>
> diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
> index f8908166276..bda2240725f 100644
> --- a/doc/board/emulation/index.rst
> +++ b/doc/board/emulation/index.rst
> @@ -15,6 +15,7 @@ Emulation
>     qemu-sbsa
>     qemu-x86
>     qemu-xtensa
> +   video
>
>  Also see
>
> diff --git a/doc/board/emulation/video.rst b/doc/board/emulation/video.rst
> new file mode 100644
> index 00000000000..4943dcabeab
> --- /dev/null
> +++ b/doc/board/emulation/video.rst
> @@ -0,0 +1,63 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Emulation of a graphics adapter
> +===============================
> +
> +Currently QEMU's ``bochs-display`` is the only emulated GPU that U-Boot's
> +generic QEMU defconfigs support. It emulates a PCIe connected graphics card

PCIe-connected

> +with VESA 2.0 VBE extensions.
> +
> +The following parameters can be specified.
> +
> +edid
> +    controls if EDID information is available. Allowable values are ``off`` and
> +    ``on``. The default is on.
> +
> +vgamem
> +    specifies the display memory size. The default value is 16 MiB.
> +    For UHD resolution 32 MiB is required.
> +
> +The following configuration parameters are relevant:
> +
> +CONFIG_VIDEO_BOCHS
> +    enable support for the Bochs GPU.
> +
> +CONFIG_VIDEO_BOCHS_SIZE_X
> +    defines the display width.
> +
> +CONFIG_VIDEO_BOCHS_SIZE_Y
> +    defines isplay height.

display

> +
> +CONFIG_VIDEO_PCI_DEFAULT_FB_SIZE
> +    sets the framebuffer size that QEMU can use for a device driver that is
> +    enabled after relocation. This should be chosed as

chosen

> +
> +    .. code-block::
> +
> +        CONFIG_VIDEO_PCI_DEFAULT_FB_SIZE >=
> +       4 * CONFIG_VIDEO_BOCHS_SIZE_X * CONFIG_VIDEO_BOCHS_SIZE_Y
> +
> +Here is an example QEMU invocation for qemu-riscv64_smode_defconfig:
> +
> +.. code-block:: bash
> +
> +    qemu-system-riscv64 \
> +      -M virt \
> +      -device bochs-display,vgamem=33554432 \
> +      -serial mon:stdio \
> +      -device qemu-xhci \
> +      -device usb-kbd \
> +      -kernel u-boot
> +
> +``mon:stdio`` provides a serial console. ``qemu-xhci`` a USB root hub.
> +``usb-kbd`` a USB keyboard.
> +
> +To start QEMU without GPU emulation use parameter ``-nographic`` like in the
> +following example.
> +
> +.. code-block:: bash
> +
> +    qemu-system-riscv64 \
> +      -M virt \
> +      -nographic \
> +      -kernel u-boot
> --
> 2.51.0
>

The Concept tree has build-qemu which handles these details. I wonder
if those scripts could be put into the extra repo Tom created?

Regards,
Simon
