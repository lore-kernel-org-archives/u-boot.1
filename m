Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB83CCD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 12:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E34183EEF;
	Sun, 14 Jun 2026 14:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j+6UpjWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48BD58486B; Sun, 14 Jun 2026 14:22:29 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B79C800AE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 14:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8434840cea8so1390072b3a.3
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 05:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781439745; cv=none;
 d=google.com; s=arc-20240605;
 b=Gy1sdstLfamzm8KwYUHiXiAwezUMrXicUuwuYUPnm15lYIpOSJN090ItNvNIuENKKp
 Jo5PfMIdeouocqxbsbgucn/+zvSTX/IHKilt/8gMSnYl+YbAa/DXkmbfKxLJWFpl0XYM
 8QqntxnNTVjXoFCWowzEUA5weuBLf4MTSultD1QMbhRt39wn07gAwfhHJ0rmGkbTXwQo
 a9Wz4haDBwYkRaf/C0coSIB74nIqaA4taRnH5zoXiMrBewkNOGJpodS2GSL0X4fQFaxG
 M7F1Pr2nn0vbwNYRcW+Z36GGocnTc9qlENbggi+jvpiR+T1om08hJeGbK8rY+B+TE0tG
 BLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f/7nvnB5H6x3t9AuG17xWzF3+JhsZ/NdMnGhQHIalyM=;
 fh=YDH4tYxYY/L18TkSaMEaPWRyobgWco5gBQA2N64+Pfk=;
 b=P9EcLrDWWGt4MnTBRILKfNvo9yZMxJ4aUcJH/Mw17j01ylNghjmCXCYZDj00BoLEF0
 aelEjI4s2gRccTKmb2iq2fs9HVWbtG2/sFQJR7eosIb13TDrG3cd8B76JdstcNyFsdNJ
 Jzqr675HGUOhyjpHFL2G3jJ8z4A7HAkw6dA72m8bcyhvUo3Js9kEFqscMTSipQ/efkWI
 SrHv65SXcQX/OVonpmDWzeuHOUc7nZ+TxYzQzjkKEavdiB/nBi6cuxwiKpub4U8pZesN
 r4mWu+xeLryfQg3ODk8KJ2jtK6Ocp1t/Pf2hI8Yd9ZZSXmZ/sVLgyLu/fb8UNnV6Ys7H
 u7Kg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781439745; x=1782044545; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f/7nvnB5H6x3t9AuG17xWzF3+JhsZ/NdMnGhQHIalyM=;
 b=j+6UpjWWgBeIJhKCZX8ij1WypyZDk6oLXMHOs0w5EJdvqQq916MIagMQJc+DNlWykh
 CHaoGBar5GDTaWGQh62kxZ4Ij2FgCCys6z61zUCwwfL1Z4IPwnvXUrLaFABoiBA/EwzE
 JHj4XsvrfEuKDhlEbW9SKii2f7NNbaHCCEUt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781439745; x=1782044545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f/7nvnB5H6x3t9AuG17xWzF3+JhsZ/NdMnGhQHIalyM=;
 b=tRYFUK1UmUrXeoKpJThnGtP1UfdY/igOgH1KlonXJB94+JXO9jEs3hFSKtnzUoUAXC
 A+EnON8aW9RJekm7TwQTfFgMERhia1eITO1XVKAMr81g8nczRlkPSErfIfAOYI96bmlF
 +ttP0L5BcYkvYQOMZ/PesEJzBkzuyOCwRrEqJ3hGBQt+byMZwODKr711HHD+lJrQtDXH
 1wFzVdyCXg/SoCdq+5ZMhpIQnh85fK3AcYPZFPAH6Xxh71k/Gnf2VrMq6Yin/p0/5Rms
 7L/RsYTR/IITGC+/3jV1NkRWTsYc7G2G+qXF+vKuXCZMeA7gVjlmW3112g86iIUcABdN
 puMQ==
X-Gm-Message-State: AOJu0YwWKOlaBD7epbDZbJP3/E7aJEDgSh6QR7R/tkE7XKM8F9dRWNWT
 Ex+exuyXRhsT3vxheyyjy1gVbI+N/nahAa4uAK8CJmJ/98r38G/ZhLxZmIFV4YDPgXtpmOR1Eer
 axy+lGjKUGaWs4JbFOgudnmWUQgBbph+G+q8nm+Cg
X-Gm-Gg: Acq92OE/3BOWHwtZLPiPUN/7ncb3M9m+gAFHb6PsqDjWv8QiCRmg41PlgcNi9Zi+pIV
 oNsTrhzi73GSU4E8GUrTolJ3+0cOcPY8SIYVYxX8j0HV3hCXLlrSgmYuVXtnszDyFg4jLsfL8jX
 JvSmhaZSReye/we+assSXDqPuSftg8kSCT10e/1GsM79q/FUHfQgAX5z1Kemfy7FtusZt+TJc0l
 QOC1pbDl3klqpD7/UF0GGWGE/Co6BHW3AgQCSRm95QL9SiCQLX23GwD3rFLJXzAZv09AK6JimmE
 /0YxLg==
X-Received: by 2002:a05:6a00:138b:b0:842:51af:b3af with SMTP id
 d2e1a72fcca58-8434cb0bb9dmr10633350b3a.3.1781439745595; Sun, 14 Jun 2026
 05:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260612020606.284001-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260612020606.284001-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 06:22:10 -0600
X-Gm-Features: AVVi8CdM0vELX7Cz-LPYXfKIYl7_nvjvFyff16wuDTg1M5sSbV35EBH0SD9i12o
Message-ID: <CAFLszTiFZUn7MPZe6i8yfmtv9MZGgHpC5Vb9POBqXy_23tFn2A@mail.gmail.com>
Subject: Re: [PATCH] treewide: Staticize and constify acpi ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
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

Hi Marek,

On 2026-06-12T02:05:38, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> treewide: Staticize and constify acpi ops
>
> Set the acpi_ops structure as static const where applicable. The
> The structure is not accessible from outside of drivers and is not
> going to be modified at runtime. The structure may be unused in a
> couple of drivers depending on their configuration, mark those
> sites with __maybe_unused .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> arch/arm/lib/gic-v2.c                    | 2 +-
>  arch/arm/lib/gic-v3-its.c                | 2 +-
>  arch/x86/cpu/apollolake/cpu.c            | 4 +---
>  arch/x86/cpu/apollolake/hostbridge.c     | 2 +-
>  arch/x86/cpu/apollolake/lpc.c            | 2 +-
>  arch/x86/cpu/intel_common/generic_wifi.c | 2 +-
>  arch/x86/lib/fsp/fsp_graphics.c          | 2 +-
>  board/google/chromebook_coral/coral.c    | 2 +-
>  drivers/core/acpi.c                      | 4 ++--
>  drivers/core/root.c                      | 2 +-
>  drivers/cpu/armv8_cpu.c                  | 2 +-
>  drivers/cpu/bcm283x_cpu.c                | 2 +-
>  drivers/gpio/sandbox.c                   | 4 ++--
>  drivers/i2c/designware_i2c_pci.c         | 2 +-
>  drivers/mmc/pci_mmc.c                    | 4 ++--
>  drivers/rtc/sandbox_rtc.c                | 2 +-
>  drivers/sound/da7219.c                   | 2 +-
>  drivers/sound/max98357a.c                | 2 +-
>  drivers/tpm/cr50_i2c.c                   | 2 +-
>  include/dm/device.h                      | 2 +-
>  test/dm/acpi.c                           | 2 +-
>  21 files changed, 24 insertions(+), 26 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
