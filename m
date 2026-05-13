Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B647BCD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 16:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CD6D83EF9;
	Wed, 13 May 2026 18:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nmygY3yI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFAF48467B; Wed, 13 May 2026 18:27:10 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D270E8341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 18:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-67bb5ad91bfso12968831a12.0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778689628; cv=none;
 d=google.com; s=arc-20240605;
 b=f7iu2bNlLJ+QZrz1U/A4R1nczlLu6TgZE7XQXhDY3yzecJWJXB1ZbZ8F228b3dkMMS
 EPecfexB4hZZaMOwz/5x3b51+mqeNFMzb+btpTS2KDzCUBOplHrXCf0wqfWGMkiPKo1f
 DhBkzNGmNHPypr4A7HlrDn3JcwTuFpt3weEZUeAvU1O9gOTP/hfxkLnbT7JQLJ9y1QZ7
 AJykE6hN6Kqyok5Ftly4cSixOmvf0KMWZntF1Lp7zpTThQ9sfv723/LJHA1x3Vvk+cHt
 MSsHjDN/vAYWkH/WZohr9+KRsj4SdclpK2AG2M1dqDYryabjVZfU4chyV3YYLGZUQNAz
 ojZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HB07/0nDfDf2UyEVLEwUyrQUiTuq1kKHkICiGeVIqxY=;
 fh=fHga0ntAKbTtcWD0E57+rqrNxme3m6w5h3W/8Ez4J88=;
 b=Nha2QKcXTXlOnNNepVTtr6ohQF4pWcqBO+aIDrYlVWt/mRUBU63i3F+b/A2oHLbQZR
 hzyrgb0TugC79ySqx5NcU2Tad89IEEHoa53BtUEZHpzHJysIPCt+4UThCQMvoQOBVi6I
 /ztHOE4xMY6CgA0WGH57+vFO4mHcprlxazilFSIs7bCn0OXQqEEnK4vlMBAe5UXixxU6
 lqVQzkF8Edfrd/8yGlTIoJOj1ocNy1djDq0bewC2uvC/PvClmjowVmMMxvKDtGJQVBQB
 kaDmKmYVgPjJ7F15KtigOa5+0mAyFmOdqoHQhVPIWBHZRpafiaNl6ZXHqNF1FDL8nrvG
 cS+A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778689628; x=1779294428; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HB07/0nDfDf2UyEVLEwUyrQUiTuq1kKHkICiGeVIqxY=;
 b=nmygY3yIQRtDCdevSR7ObkCZY4jeobhGAWM5KgHB9dvuwNsqQtMNiXHIO2MG/YZo5r
 fw0fEjRmfkDT8KkkEHBUEdUcnRpLVBFCtmVq+xDJnaF4l0YvT03CJqQg24N1mv9y8Vi/
 qa+xYQAV6fkeiAnmP+m/UMXLrJ24wm2w3byHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778689628; x=1779294428;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HB07/0nDfDf2UyEVLEwUyrQUiTuq1kKHkICiGeVIqxY=;
 b=DYBN24Sz6jlWdnge4LKmVNHLFlpTShuFFN8S2H9UBLXpUJKMWFNlX5WA0ZbIQlyPDe
 GFda5oS3EgXRgbEBjUPHQ59p2X637WZ6ldkKZGKhJn7xkHULGRxZuSgMxQWmDyL5R3vW
 Rlt7fMwqcJK8R6KuOyc1M3E/SY/J9IMn+5wLQMbnD1PAy7j1t5KS1PMeIa/IUfupdAEq
 Mh0U5ksKC1Mszrr7CZ4YgNdABmNrFHNDWuid8KCSynPBoUDWtmjHvX5qcmTGUF5cBF3b
 H0g2rWykYXXeO5iQ/3ZDr97a8gINAL02jrJbswkIlB6iRAPYaz4ktEqI/lHbgvSxQ8L1
 Y9hQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CT2KENQe5kxQK7ozDLCiHSeiepVqpoFapTP//7SQM9U74zTnp6p1h9lS7hO5YpkJ7hCVybJA=@lists.denx.de
X-Gm-Message-State: AOJu0YwtiM/gnwykv80cjkT5J6eFq4BJPjUMTs+uyU/cUdg6xQGeuUug
 9pp8AnvIdfM+NGdBmtR9SmVFk6nd0inlbt+Ny5X84cZNawPkeB6dsFy9UzWoBNGza1TR0Z9LFUC
 Hl5Ze92CVvP8XJF31g/UnAhZ8vjQi3tPtRk/8INOF
X-Gm-Gg: Acq92OG9C2Sz53vxAYllKpY+t9wKoQRxaktp42bK/+/zrc6M6XpNYQItEfmyd9Q4mQT
 7aFz2JANRSUqkYRfzjSFlydoEw29nJth1BtuJ+bAYc1aG0ARhtzgr7OPb6acwYexU0NQcnD0F4m
 RWIAtWFKrOuRfcBI+0PTWifbFHg+gU+fCPoSVaFfYDQzZMSomBF/Uw/pxfaFQFKaiM4gUPXqE+Y
 uPt/Ek6lsbpU1ZZkvxrUHfXqbHTob/dyZB3jnCCnMEbqMQj9ihwOGDtrKM+hakwyLHkKdsHc/kR
 /8J+iPnoU3YeCorj
X-Received: by 2002:a17:907:3e89:b0:bd4:d6d6:b4bc with SMTP id
 a640c23a62f3a-bd4d6d6c29amr71013466b.27.1778689628215; Wed, 13 May 2026
 09:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260513015606.591384-1-rs@ti.com>
 <20260513015606.591384-4-rs@ti.com>
In-Reply-To: <20260513015606.591384-4-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 May 2026 10:26:56 -0600
X-Gm-Features: AVHnY4LEAJLsAvz5eu_2ln8I2e2fkVrKoVZKd4GOR9esQ1xp7IPt8OBXoIk1qzk
Message-ID: <CAFLszThL2H3iRTb8jozephjwZNSJYo1mFrq6Ymta6bRZnE+CTg@mail.gmail.com>
Subject: Re: [PATCHv7 3/3] memory: reserve from start_addr_sp to
 initial_relocaddr
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
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

Hi Randolph,

On 2026-05-13T01:56:06, Randolph Sapp <rs@ti.com> wrote:
> memory: reserve from start_addr_sp to initial_relocaddr
>
> Add a new global data struct member called initial_relocaddr. This
> stores the original value of relocaddr, directly from setup_dest_addr.
> This is specifically to avoid any adjustments made by other init
> functions.
>
> Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
> gd->initial_relocaddr instead of gd->ram_top. This allows platform
> specific relocation addresses to work without unnecessarily painting
> over a large range.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
>
> common/board_f.c                  | 9 ++++++++-
>  include/asm-generic/global_data.h | 9 +++++++++
>  lib/efi_loader/efi_memory.c       | 2 +-
>  lib/lmb.c                         | 7 ++++---
>  4 files changed, 22 insertions(+), 5 deletions(-)

> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> @@ -107,6 +107,15 @@ struct global_data {
> +     /**
> +      * @initial_relocaddr: top address of U-Boot in RAM
> +      *
> +      * This should be the original value of relocaddr before any other
> +      * allocations or reservations shift it. This address will, depending on
> +      * the platform, be equivilent to ram_top and should also be considered
> +      * an exclusive address.
> +      */
> +     unsigned long initial_relocaddr;

Typo: equivilent -> equivalent.

How about: "...the value of relocaddr after setup_dest_addr()
completes, before reserve_pram() or any later init function adjusts
it"

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
