Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59524F3ED5E
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 20:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B107E84154;
	Sat, 11 Apr 2026 22:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y/EAroaa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 132C384118; Sat, 11 Apr 2026 22:31:13 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56D4A84181
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 22:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso561772066b.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 13:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775939469; cv=none;
 d=google.com; s=arc-20240605;
 b=IS4CPFFOMIvKo87hcenWvwNf5Dft/RYkC+qMya7sexYhx4EoTSaNBKXp+lMuH9m+JZ
 A7VqJE1Al/7M5mG82rLG/VkRGUaX8u4eZ/BkBoxKcbIAM2cSFvnGdD1F+43uh9eMIsJr
 08kyP4ZTwuwJ4+UKxFKlxzCc4yW9FNp7yoC6NuApk3y9WbMkCEakwg5rIo/ncnrCh1fd
 1kc0TajZspoikPU95Q1RXaGnxb6TWTyp7KZb0dZQlOEeFTZdAQQXdtbh2ZKH6OqFnGRT
 +4p39+qjfgByOhEKn3Hll5ctDjdntJl155YHTkxm5QrFQOWVGCg9ZcJnApwCfn8hmeMR
 /HoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TQK6A2m1Ng85AjXyt1S6hx5mynGKOnm4ca1A91EQN80=;
 fh=DNnc0PxDvDAOtN2DNlU78zUxlw1DS1Be5zZEFqtZAt8=;
 b=aFlnn/D+WuRoR8LwUbuB+gtnH6iT3RxINuOifn7+mqo7cPrvUwSFNUu+20CznEY4z1
 elq0oRKMbp0UoyBuMYpjwYDl7pX8dt8ajSssRsedjiZNiP2S7XVFQBKcdG6P4xKqnFuv
 LG7yZ7h1YuK5hnOV6tH12isVuO+7ILCdIU7Vc8GjfQo1oZBYX4oqUaz1XuvkK4FP70JO
 o4PaUoHZaGNO4XE82NjI5QgzTfcGfpIXlX4X49bU/EYa9IybLUoVAgGn+dZwYHsC4wUp
 7aogzicv2ZKf3igs8D5gRHU8RXcICAZNljgYRtrB6JR9hMZqKLx+Tz3kv56aBCodiHJs
 8/GA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775939469; x=1776544269; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TQK6A2m1Ng85AjXyt1S6hx5mynGKOnm4ca1A91EQN80=;
 b=Y/EAroaakxnK+OoIq4X2VTHJ7yN9LASOCoUQ5q5FJnZEQDn5zgqovQq5gkVuSffjup
 3/8r7BgUv8XPgN3sIUSt7lUqH2I38svIiENz4LsJKlQd3HU6eysEARu8xw+TuW2L3nqq
 wAGKALsu/qgvOXTyqGsbKmAeynAU6PSMZYsb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775939469; x=1776544269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQK6A2m1Ng85AjXyt1S6hx5mynGKOnm4ca1A91EQN80=;
 b=kGtd8wVOcBu2YDU6xhYiEKR1RgvverniT0qKguK03scZb46POxmD53ktruwU1h1uvQ
 25X7ODpsk3cf26ciDb2b8oVP0At8nFM3Y7EdzCAX3Tis6uPaBvMUr+HUZZecv3fu1Sk0
 5oBtZHaRR4nEt7sxBtAFnma8sX1pqx7JCPvYiHEX5szHmsYlCAWzY8RV+t7RItOPFqa6
 JK8zEtuZazvcnciaGHew8Abol21uqy4msGK/kB+eQ/hwTut4fPiHNqqlo8syuofsscS1
 3e3XvqNeMhD4LIAcEhP1lHVa0xJ9ItiqOHmTU7TCmvjFNmHchK88uIKQfy54d4BuCIFc
 hPDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPG9EksKi59BkGGu0HFBlf9GyV9iiEbvP3Xu8IYHkEyhZQOLjc9SixCiR9WevuPZxET8sFqZk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3wjkESNghzeE7DFEV5mCYau0578Xf3EmEHdPRgT3UHzF/dXlT
 3n/0/feb1xdJBh3prgUVi0aKRfoUcnZR5XcHPDGwk74mjLmJk+SdIF2fWVYHiaeLE9LbL78N2VW
 u0zxBaRJBHvmg+BQQLzqox/eSt90vDAxesISZ9/yw
X-Gm-Gg: AeBDiesPv0BmiP1Fn0IG29E/J2n+VIUiO8hiwtE0qdhZ/aFF1V9YoqEUf9X0RGXM5Ky
 RXajUYZkGUy8v3p9tJllLsc8MGGcr7b/mnnrtAt+Vgu9Xv80hgyHmBVRPNnK8JooeY8ksqpRr4n
 2NkZUy7LjwPN0Z+vNZqLxs+MaFcGCPGazRgJiBb46VsEq5jHuniTn8U8XEQ1bt4paG8IMU3nfF7
 ZOc1DJ9YDaHCyxL5l52an4T8h4IVVUyVMSWu7SFrE04kxqk3rBtIEqYAW0Du0XCK+ZEMnni2P/i
 CCv01Q==
X-Received: by 2002:a17:906:7947:b0:b9c:30b7:770f with SMTP id
 a640c23a62f3a-b9d7265d35emr490450566b.34.1775939468704; Sat, 11 Apr 2026
 13:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260408220928.3328551-1-daniel@thingy.jp>
 <20260408220928.3328551-5-daniel@thingy.jp>
In-Reply-To: <20260408220928.3328551-5-daniel@thingy.jp>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 14:30:54 -0600
X-Gm-Features: AQROBzC16FWlOcijl06vs9Tn4NvfJJtKklXvXQFdtY9uS71DpAunCDC1cm32JfE
Message-ID: <CAFLszTjXCmp5f6y-5mkFG1R+B5A6dqrWRAmrYG2evD5Q4N5PVA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] virtio: blk: Fix converting the vendor id to a
 string
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
> virtio: blk: Fix converting the vendor id to a string
>
> Currently we are trying to work out if the vendor id is from
> a virtio-mmio device and then casting a u32 to a char* and using
> it as a C-string. By chance there is usually a zero after the u32
> and it works.
>
> Since the vendor id we are trying to convert to a string is QEMU's
> just define a value for the QEMU vendor id, check if the vendor
> id matches and then use a predefined string for "QEMU".
>
> I don't think we should have been assumming all virtio-mmio vendor
> ids are printable ASCII chars in the first place so do this special
> casing just for QEMU. If the vendor id isn't QEMU print the hex
> value of it.
>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
>
> drivers/virtio/virtio_blk.c | 12 +++++-------
>  include/virtio_mmio.h       |  2 ++
>  2 files changed, 7 insertions(+), 7 deletions(-)

> diff --git a/include/virtio_mmio.h b/include/virtio_mmio.h
> @@ -5,6 +5,8 @@
> +#define VIRTIO_MMIO_VENDOR_QEMU      0x554d4551

This vendor ID applies to all virtio transports, not just virtio-mmio,
e.g. virtio_blk.c must include virtio_mmio.h even when built for
platforms that only have virtio-pci

Please can you move this to include/virtio.h instead? Something like
VIRTIO_VENDOR_QEMU would be more appropriate.

With that:
Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
