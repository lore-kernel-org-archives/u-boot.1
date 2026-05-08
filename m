Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1930BCD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 18:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C87884DC3;
	Fri,  8 May 2026 20:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ITIp3Ouc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E029E84DC4; Fri,  8 May 2026 20:04:01 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9A9184D1E
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 20:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ba545100a13so397320666b.2
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 11:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778263439; cv=none;
 d=google.com; s=arc-20240605;
 b=le1HzpCTENnrbv0uRSlcOss6vAZVzmaJjZDtLcIKwYZTzkcUxbjmRsNpPuXZeOh4yD
 7HYcHt3w8vOThxPTPx2/sym3SvFQNk2rCAoszfOdwFSrih2/xAFyNPgK3PK1yeHdUDVH
 wJL3RHeETVZXZxA+3kZynseLS8IgLagAMa5C4EJnJ3zsGnIub0pKwhRqqgvfY9mgVHoL
 fqUE3BIpuecUNvma8dlVe2TjM6D3ybDToyuCUMdl/YNl4JlHYSw4Oi82MmnEroAKi0tg
 ovB4JGWPnSW95/HyWixvJgSTIQ0/7/XljBJt4U/pngxB8APXatYgnDbJ9LVqUGW8gM9p
 duew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KqkVC8d2KrtUjP+YfQ519mfLEOGgY45x4cj85ZAaJos=;
 fh=syKhMRT2ZKudEbKaXzCBO8z7H5J34wK/WOX8AWEo+tM=;
 b=Jf9YqB5D6ar7s06zoE0brCUdeuN8yRndlmi5daj1vh+i3jjr308cfuqdA3Pwn/n6ul
 yafSKzV/HjF0H6ysURN9Pcr65yTTls3J+9tbi2gm8OX//adhaKCOACINhEwYcNw2gwL6
 6tts+LRR4pTWg4PVDlwpJUETfs5gxdqval8yBAMCiaUooNUKt20NaKgYCZp5sKSjSGuW
 ueaYnsYVm/9mizUbthxlNG3UdrX0pgPKqgDPa+IrdiLew1yAY1FrOGrTDabG8n/WfhMP
 NBdWzgfGC92FCUj94JYgtKKK4ZVSanA0cyHqfchDEwH3YJiTgDM3DvHI1HerSC3WtwJu
 uldg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778263439; x=1778868239; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KqkVC8d2KrtUjP+YfQ519mfLEOGgY45x4cj85ZAaJos=;
 b=ITIp3OucfK/yitkfZkPAMsL/+XUt8yNOw7zUycESMwpzl1+L3AbD4cq/0H75X08AeQ
 snM9jvkvY4CEa6V9KhGwFiTIMklKEsThkblXJSwiwC2od4xd9vfY9uArYzacwQJlTGoM
 rMcYFRDSe8YLUU4PMGICatNoHbZTjcpimF738=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778263439; x=1778868239;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KqkVC8d2KrtUjP+YfQ519mfLEOGgY45x4cj85ZAaJos=;
 b=ieamwqX7YRZA8G65X+ExYdxPWmfm5DYiE0ZUDNJv/uRW/OgYwb+UJBTSN35IyGEQlN
 82VJrbWodTaZKuY3C0Ty9hH4j3FG+CMCVoE6bI/eoEyg6IgEjNcuygVmNQjzRtkfa3Wl
 zfQZGaNOcCz7dOY98GnuYVT6+ZwesAZYT7o7suM7jozoEU6gsrwRBRCuZqvhlYzAsV2c
 5C2OxDcbo2eiSVJxjeWdf11w0+AudBLfAL2o3R8ksiSldm8DQ+i8gg1kywhpy3Czw1J2
 7pb7GW3XFlBvpTCVRVKb8GFbPm98EUdWXQKwenEoPaAc0rhyBnYOqs2DDdY9Adn0uwGv
 G13A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xb2dI/NVXw7y3NbXYgCl36u+K0L+uFhS6/ghzp45wBijn1QKZmDcZnY8mtaTo66uJx0LSdm0=@lists.denx.de
X-Gm-Message-State: AOJu0YyIYlXuj4ivAB8hiz5Fl4XJNDj+tQXrvxjiDdAMs3zohg4Pz86O
 68GDvPBBtGjmfFmbKzooswGCGjauFLNp4638fg7zLlxRV5rjzKNQpnsq+DoJVBgKHj6Xx7CFRMl
 dG8cnKBdESM5Bfs0k8o4oeO4ohdqhK4dZZboVdXsi
X-Gm-Gg: AeBDievZYXvywLO6e7GXff4MmpHAPc0MHeRKVZIGEvRVqhWiOCZ+geM2XCVzzlZgHJ/
 Pe6JT5Xlaa88xWvimDUG8i98LuWx8JM9fg7QcqmxGw/me/fWwO/i6Pz3bsTRme4AZdrlVCb831d
 vMPoysCrwOwsiTxp3QM3M1OixwYXxMltlqfCQpBGqfyujYQlwhNUttzdl2r9GefPMbvyY29w8Rl
 iRMu0ApAAtxhcDsWyokab/6ahzfJdB4f7TlFgz4ZA3Fl57wXnYoAXqLtYCD6VDvrSnJU5EbVhnA
 wyWDGQ==
X-Received: by 2002:a17:907:3d12:b0:bab:c646:dc7c with SMTP id
 a640c23a62f3a-bc56d51b1fcmr882716766b.34.1778263439339; Fri, 08 May 2026
 11:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
 <20260508084834.45637-6-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260508084834.45637-6-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 12:03:47 -0600
X-Gm-Features: AVHnY4KGMj87yLQeQcuqx3A-hqFcvxIiIBstekpjuLJ_jhLqtClG7Ql_WQZI9sY
Message-ID: <CAFLszTiYQQYY21drfSaHfaNq4bzuS-0=pBEA-qU_8L3RE41JAg@mail.gmail.com>
Subject: Re: [PATCH 5/6] board: tq: common: add sysinfo helpers
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de, Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Nora,

On 2026-05-08T08:48:28, Feilke, Alexander
<Alexander.Feilke@ew.tq-group.com> wrote:
> board: tq: common: add sysinfo helpers
>
> Add a number of helpers based on the tq_eeprom sysinfo driver and
> related hardware detection features. The helpers set up the U-Boot
> environment and fixup the OS Device Tree.
>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> board/tq/common/Kconfig      | 27 +++++++++++++++++++++++++++
>  board/tq/common/Makefile     |  4 ++++
>  board/tq/common/tq_sysinfo.c | 32 ++++++++++++++++++++++++++++++++
>  board/tq/common/tq_sysinfo.h | 18 ++++++++++++++++++
>  4 files changed, 81 insertions(+)

> diff --git a/board/tq/common/tq_sysinfo.h b/board/tq/common/tq_sysinfo.h
> @@ -0,0 +1,18 @@
> +#ifndef __TQ_SYSINFO_H
> +
> +#ifndef CONFIG_XPL_BUILD
> +
> +void tq_common_sysinfo_setup(void);
> +
> +#endif
> +
> +#endif /* __TQ_SYSINFO_H */

The include guard is missing its '#define __TQ_SYSINFO_H' - please add
it right after the #ifndef.

Also, why hide the prototype behind #ifndef CONFIG_XPL_BUILD? It is
cleaner to leave the declaration unconditional and gate the .o via
Kconfig - a stray SPL caller will then fail at link time rather than
with a confusing 'implicit declaration' warning.

> diff --git a/board/tq/common/Kconfig b/board/tq/common/Kconfig
> @@ -14,3 +14,30 @@ config TQ_COMMON_SDMMC
> +config TQ_COMMON_SPL_BOARD_SETUP
> +     bool
> +     depends on SPL

Is this option referenced in this series?

> diff --git a/board/tq/common/Makefile b/board/tq/common/Makefile
> @@ -8,3 +8,7 @@
> +ifneq ($(CONFIG_XPL_BUILD),y)
> +obj-$(CONFIG_TQ_COMMON_SYSINFO) += tq_sysinfo.o
> +endif

Can you use the standard obj-$(CONFIG_$(PHASE_)FOO) pattern here? Then
just ensure that TQ_COMMON_SYSINFO is not selected in SPL - that is
the convention elsewhere and avoids the matching #ifndef
CONFIG_XPL_BUILD in the header.

Regards,
Simon
