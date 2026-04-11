Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2641FF3ED5E
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 20:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DCAC84198;
	Sat, 11 Apr 2026 22:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VU5cByAJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4858884198; Sat, 11 Apr 2026 22:31:24 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AA2D841B9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 22:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-66f727d6849so4671146a12.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 13:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775939480; cv=none;
 d=google.com; s=arc-20240605;
 b=kZiD0V2spfQzU5TPg47tB6aTJlNsnK0vvKtziHeFnTNpEJyd8LdV+3xHlIRyMZ2xHP
 0kZsfN4+6jtNsMkLTWfG1SmlOX/9bM4+sIgLJ8FYuyUvYpaFnrvZKHDSHTMFPoRtwrKQ
 341sV31vDq0M87/qVjIyGDdsSR3AhAl8auwnOVPx7SiFJGLzlTfpaKNVUtKf/mTpYBFy
 qFdNY4pQiLRQx0/F/J2xt5RBfMKtFXUd+5mNRxeVLXNMuA/J+vw93iNtswhX8vOSXiav
 UhQQEVqRoQSXXEntBCwBmLUfp2YAwXRINK67m/wEyOzLsjXpoHxm428zSETGhOU7occS
 UrTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=asciO2sC2l8wVvFXsrQEdWvaKuH8CNKKLgigQZwvWCE=;
 fh=zmaIjKiWjntoLGDg2H+ia8/7xCQKism+FOaSsAFHQho=;
 b=WDjz2H+HC3cQUhnu6K5hmhy145GWAonZdVMWAN12gAyBi/+aqqQ6NyccCl0lcWknj3
 4lU519Ob7yCWVDd8rsgI3nLq9MyALLhFcv/Ul4DZIgvizaxA8bGXEW89rTqNNzPN8FoR
 1iTWSyG3ajvSp2itSgkEXT4kWIsQ0EP5PqIXMumcpXgjZ4SfyFIFDQc/iCdI2SfBG1SQ
 7pCmCFkEUOFBOg7rXAuHXVCiGNX2Pek5AuJ7wlR2qgzOKgqpr0nUL/DyN256WGINVcGA
 FF1Fi8tpk5SJAr5j0RHQoJcVdyQpRBHs7vk1WjdNH3amYHrredlQ7btvagOIk2lE2OSB
 mxxQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775939480; x=1776544280; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=asciO2sC2l8wVvFXsrQEdWvaKuH8CNKKLgigQZwvWCE=;
 b=VU5cByAJgvTTZ84dIFAUIAL643Zn0luQ/StCreB1WB/jUc3PtfDruvpvqtuRPQX1ss
 GPqwzTk0Psaxzk2kz6V4r18KZAjlWEcA8P+yXYnq0NSc7ig2entaRIY1KbrTLD3Gb6Vp
 WxR6to7CLuxGKSc4mWbDGYRLAG/pGnEI+C4Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775939480; x=1776544280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asciO2sC2l8wVvFXsrQEdWvaKuH8CNKKLgigQZwvWCE=;
 b=XgG3AWZVJIoiEOX1sOvglfNS9upWaBMTqOOMjUHRUwHM+Xezt7ggERY8byCRdVT7Mr
 oqpDQ2mpxXydXnPMxhtqDphvg2Mv/0Keah15r8GE6nk0JGMGR2NmeL3gom7N7Gi8NdS0
 qDJxvN1tUXlUc12WxXiSG2oq577yh5cq4xN7b4JjX28ijBs0qnV1vI8Ye5oe0eOKqZDj
 TrElQjxhSgO9XBROHzaz8LkDJn3LgFtc19N9o2/+BjUjXYPM6yTMPYnoNzxgv9qpbZ9z
 kCLBnjqK54/XtHgbEFX5iLAoJpd2ybraUVngI+emshm4pd61lRAUC7BAZ7NVCK+X9H0C
 YgWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpjkFXvl/XW8dDLPRa8Ajht/bRwfH30RhwAwmOA4JrjtEDa0pGb5/v5J/Kc6j/qb6V7m6jxnE=@lists.denx.de
X-Gm-Message-State: AOJu0YwcI19HN9avnfGqWKTVdMVvbhpxG9gxQ8V+VLslwHYez8ub9HOs
 38m53uVgOd9rhRK1KVYJzl2cLWFR++Weimb8kA7VtxNmbRRlTaLrDTjB/L5rXsQxM9/Npi1Eb1z
 bnrtOWUM4V5vwhLw0wenM2fB3arwOmyFk+qphJb8/
X-Gm-Gg: AeBDiev+YyljLFJSzX4y/mjqnWehRbuu7Zzq3tHUdTfxpwDwvftFdobvsxZ6DNBA946
 pclHf3KHl0hZ1iuSAd1z1puzx2tSFOxs0qPsR12w5VHGgI/KM/MjIzgVAsH3ih0kv/gDFYFhst6
 7sy5nsxMtRLjNg6aKgtAKqMgLAnE8a3XItA+m1WVdnZrU4GBwj/HudXzFdm6aqXoLSnFN5Wimca
 6451TyQP57raVR6vHzMbfeWpmjNp5NAcPT3xOfq1T/xPksyngmbgwLpwycNIWvq7rdErt7lSL8a
 KxMfgA==
X-Received: by 2002:a17:907:848:b0:b9d:1670:6794 with SMTP id
 a640c23a62f3a-b9d729bc9d5mr401124966b.35.1775939480436; Sat, 11 Apr 2026
 13:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260408220928.3328551-1-daniel@thingy.jp>
 <20260408220928.3328551-6-daniel@thingy.jp>
In-Reply-To: <20260408220928.3328551-6-daniel@thingy.jp>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 14:31:04 -0600
X-Gm-Features: AQROBzC2IsPxIhXfuRDiZqf2v3hsX0W41g89puNl_wR1txgh8-tCLW3cdGxd4eM
Message-ID: <CAFLszTi_QuEj_trUW-kAPw6cY_JbgmvqRQbQGi8ddU0Zn0dPpw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] board: qemu: m68k: Create virtio mmio instances
To: daniel@thingy.jp
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com, 
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

Hi Daniel,

On 2026-04-08T22:09:23, Daniel Palmer <daniel@thingy.jp> wrote:
> board: qemu: m68k: Create virtio mmio instances
>
> So that you can use virtio network, block etc create the virtio mmio
> instances. There are 128 of these even if they are not all used, a
> single mmio base value is passed via bootinfo.
>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
>
> arch/m68k/Kconfig                     | 14 ++++++-----
>  board/emulation/qemu-m68k/qemu-m68k.c | 47 +++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 6 deletions(-)

> diff --git a/board/emulation/qemu-m68k/qemu-m68k.c b/board/emulation/qemu-m68k/qemu-m68k.c
> @@ -25,6 +30,38 @@ static struct qemu_virt_ctrl_plat reset_plat;
> +static inline int create_virtio_mmios(void)

Please can you drop the inline keyword here? It is not needed for a
function called only once and not in a header file.

> diff --git a/board/emulation/qemu-m68k/qemu-m68k.c b/board/emulation/qemu-m68k/qemu-m68k.c
> @@ -80,6 +120,13 @@ int board_early_init_f(void)
> +int board_early_init_r(void)
> +{
> +     create_virtio_mmios();
> +
> +     return 0;
> +}

The return value from create_virtio_mmios() is discarded - really this
should be checked. If not, perhaps log_debug() or log_warning() would
help report when virtio-mmio devices are not created?

Regards,
Simon
