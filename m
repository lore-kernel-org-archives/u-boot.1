Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5EFF34C5E
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 15:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8233583DC9;
	Mon, 13 Apr 2026 17:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pq+h1cKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E35D1841A2; Mon, 13 Apr 2026 17:04:20 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1BFF839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 17:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b461310af5so3808535ad.1
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 08:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776092657; cv=none;
 d=google.com; s=arc-20240605;
 b=C7V5ZnR7m+qvtbuJ4nGCI53hQPvArcvmtTN0mtvjXdyPJqYd0BtFV1XgO/rWn8hTII
 6p9ppQ7uTgngtA1Q1ykEfUV7lDk+lyweplYwMDh/TDoq8iInpbaW1/fwu3gJFcO+APmN
 VqD/Isl+xFr6skzxoINqb9oPxs0Lnc1xYX56M9F/MGHcl4KhOPZ6232OYPMWu3n18f69
 5kYyKX/1rhgz0HqfId6l7uL1lg3dHkm1T77IrxDt+lkcMTbBZap0kxGD1B0smCsb6laL
 sxO/VC6IqcMLL4YK5ag7R+LTdg3i5nuN16ANqXf9nyWbzL5OZn60s2HZQRa9hkEPaSOy
 qXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aBXHLC89BIjWAr8xwG7Qaxkie702lIDEBsTQIJ8D/Sw=;
 fh=WOZRmYTh+VjseexojtaY3YMikDW3HTv/e9uQHhODrH4=;
 b=UAUloaGcWxFVbXbjmxssjhTbC+JsAZFSbDvP1acqMnFHLTH3g7h22oM5h+I7FZ7yOd
 C1dxeoN5MKFu6nxK2cj/DFcHppcBFbiCWRce8MjRfWYCo/+YeZ5lTeNIDvUzBeYVAneb
 4tR8LssyLMyYHPECqk+6NJA1siEfG5xEXPyfZ6R8m/5D4r1eUKMWnLaPwTnZAzkZhi4C
 +rLpB1UlLhANh3huQ2ordIaR8ttOQ9pYGUZjNBfpeHcriZYZ0Oov9WRveGqTGt7XSEEb
 Qp9nJ71WS7TpxeFVpxR+ySaFAhMK5cq4HfynrwK8csvhWo3Jjh5xaeJc+PSN1vw8aT70
 myQg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776092657; x=1776697457; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aBXHLC89BIjWAr8xwG7Qaxkie702lIDEBsTQIJ8D/Sw=;
 b=Pq+h1cKQj39TVXqWvDqdk+8yDzDz0TyQ2LRiwZzBD90SREIjxl0KTCQerSOo0zwwa4
 BA1lLS6OBI1KD0LN1BAviLuRD+CwUtAAJBTnmZQcBkv1TV+RW3ERrsGmWG+LJRIRdEHl
 CMMWXMiKdMIFx56QfgWhnswNpsZ5cMeTe7mH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776092657; x=1776697457;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBXHLC89BIjWAr8xwG7Qaxkie702lIDEBsTQIJ8D/Sw=;
 b=qSgTdyb+1PkoTckFthdZ/KQUL12dOc5QU9Tsq3cuYz8+KNqBkCrpBvf7KYm/49cuwP
 SVorjVpI7WZ7J7V3Asu8txTbsmpXQymClcUW6ryKmdv7LP/pXyl/cHgezxoOGodxSA6r
 94LKBecyTOUGxSgRywZxlS4ZfT0ueLpBH2uzdjdhwE5WhxpR6OL2LTMURIi6M/o76BO2
 /BYPfDcsCsLiw8/dJGmV/0s/WqFDVT6nnS5/tWvNE2eQ/SogCtj0qlK1Fx4M/wby9ff0
 jkeLQbDfe3fNnqtZSQ/M8hkrR6pQmHcpgcEHvLNs0EGMNdwurnGxRQGZEyV0HC7Ln79D
 ukmQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/z73WAYT7oxgIA+TVbO1MMyDpl2RvbEpHb4m/H1bp13PvaKZT/0M721H1beHhC5ThKlEm2VU8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3xHQ556hXd1KMkjghnj/Lcy6INXlHo8q/y7QLHo/b7wiEnVzZ
 vEGYKLwt9pWoLbcfxbKz71nA7OzEEKDnRtlXr1W97CUlOD0NmjahvrKxY4Zb4yO45sQmVEYaw8m
 ahgFupQHem8bFa4NvYeb4ASJ4NE8aZGtd657Y8epf
X-Gm-Gg: AeBDievQ48TKz/S42+lIg6EwWVGMjX2dHwA/e5B9aJIWfJVY6KZ6oKUbW2KF4SdpSaJ
 0NGreJiaJVVfVo/nGppcoeKymlmn7XRcQrU9a6nEAp+jlLVfKeFsER42fCYWMR0M8ZbFSUahcBG
 /vi7AB32+4y0je5r7RaOvJG3ffCkp3e54Et02u/3yQUcecj8Az/fyYhTCwJwjJIvAhXvd8BdpM2
 QYS3I+LKbOydtLX55HM9jTyq2gP35YDGuPdtAlB91naCO6+dOhCcceM9rocN+T2aTvgYWfRUK2H
 w2coAA==
X-Received: by 2002:a17:902:efd1:b0:2b2:4bbc:14b0 with SMTP id
 d9443c01a7336-2b2c736eb97mr115312815ad.20.1776092656246; Mon, 13 Apr 2026
 08:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260413092240.3719260-1-daniel@thingy.jp>
 <20260413092240.3719260-7-daniel@thingy.jp>
In-Reply-To: <20260413092240.3719260-7-daniel@thingy.jp>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 09:04:00 -0600
X-Gm-Features: AQROBzA7ESDdxh6SepeU3bbG09Lr7hgBZ08xTgaVd_uxj4bNHF2fTFtVjkan-JQ
Message-ID: <CAFLszThB8qWRb3i9sMYDDhhewnwhec0naXtm_7CZWmYv+aOu2Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] board: qemu: m68k: Create virtio mmio instances
To: daniel@thingy.jp
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com, 
 sjg@chromium.org, u-boot@lists.denx.de
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

On 2026-04-13T09:22:34, Daniel Palmer <daniel@thingy.jp> wrote:
> board: qemu: m68k: Create virtio mmio instances
>
> So that you can use virtio network, block etc create the virtio mmio
> instances. There are 128 of these even if they are not all used, a
> single mmio base value is passed via bootinfo.
>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
>
> arch/m68k/Kconfig                     | 14 ++++++-----
>  board/emulation/qemu-m68k/qemu-m68k.c | 45 +++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 6 deletions(-)

> diff --git a/board/emulation/qemu-m68k/qemu-m68k.c b/board/emulation/qemu-m68k/qemu-m68k.c
> @@ -40,6 +40,38 @@
> +static int create_virtio_mmios(void)
> +{
> +     struct driver *drv;
> +     int i, ret;
> +
> +     if (!virtio_mmio_base)
> +             return -ENODEV;

Reviewed-by: Simon Glass <sjg@chromium.org>
