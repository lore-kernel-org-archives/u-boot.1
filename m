Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7076FF46C5B
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 16:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9B6583C2B;
	Mon,  6 Apr 2026 18:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QAmsDJ6D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D919C84034; Mon,  6 Apr 2026 18:54:56 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5D148352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 18:54:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b24fede2acso22801825ad.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 09:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775494493; x=1776099293; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZsZQnSha/3vyLhDab+YEm6TOPSoF34A92lnmWs6GWZo=;
 b=QAmsDJ6D7T3RxgllfyS+DdkEPV8GUnq1kxqQt6o2EGggzpKZW+qIcZKv3f0a+SpruW
 F81+l7nI36iGpXJySM/2Ou7q391TYS6AYyV1Nk/jmSNLSIJq5CG0qP++nkOteqvcKg4s
 Gj82ZbSh66/EQlG5+LcZx1Pr4j0/Fcuh8m4MqmDgR3cJpgPjg2vcmnmUskUYuNG2CEYc
 XxfnxX/ie1PeOypGg5jBghRdEoRfePq5Haaf1yB6+Bew66tkEghTJJoBYfXaqeefPm9z
 ttDVPyWsMz3K3KGDlaNytYS0VPWjz/inddPEg55jKe+MowNhYKJ1rxMrsHJ5K6r1pnwe
 AIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775494493; x=1776099293;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZsZQnSha/3vyLhDab+YEm6TOPSoF34A92lnmWs6GWZo=;
 b=AmVtYzRa/Lq4aJRp0+C/FnopM5UUz3+jasJ8KmwfuZfuUQpZJDMSXNr+O5JhhEem89
 64YL9wkVIdZvarPzV6Xx/6EnV9fxbtKIWPnXqyTJj9vVGBZYdPsvzVAof5oj9MILRjj8
 3w28ciBuJRjdYgWp3NkaEED4K6u59JWpTgE+HZOzw7ZbJoj0ddW12yGqoYX+9RG6Lsrz
 JGW6EL1zTYYIX6yYdWDVNn7shv9g0YtAt3cDqrzrl7gSWI7dCaj8hQ8gitcDrwq8SV+6
 nfKUMSMDqXJrcweHGAXQ1GKCcpfZsPIGLqjDMqr4o2P8IxmDVbI6RrDbj9dsZUhhnYzv
 kPeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzJosFaCrfXVftzn56lV4MAFX4mAyWUOpJx5Wi7oF/fU0UOmy1/tBDNXOXKnBmXAwup+a1TzA=@lists.denx.de
X-Gm-Message-State: AOJu0YxXpwbbXZtauAzv3pCjtgRaAuX8NXK6eIZTV9d/dz2d6JWdUhac
 wWQFH+MmR7yKlP/R9/lVJ4mBSZKfYHx2vx5W/vJj8qfZR5Nm8LQs0791PHartg==
X-Gm-Gg: AeBDieuXZdvrvKVpzfgs0FpkBe94rBHpzKFFLCzUutwKINwlEImz+sblhpGlH6BaReg
 rrKWprDBlmR50FB5pqhElfYZB4ClPXoUC6lRtEiyGP+hKCXyhdrepjh94/zQEnK06PveIK7joTy
 fX/fti4eF7HEawy8SwAhWJUNRKTUOEE0eW8IVuVwxtiKK82Xsgj3URHk0i1lXgvlqAZJApnmB7W
 LOMeyLrNbp0pZ5G5rx6+9xMEb5xz6ZcluHqoWuCDAQ9oypzcc4YCSW0Mm2Tvb91jKzrMMHj5ytg
 yUjz08pOOqoN74874GaqPFcyVQ6Rn+EfGfckxNZB08R3plGGaI12TnBw1Y2VHdDRGwdSwYn5BOV
 VeVM0+XOec+co0LaU6nt98U6Cm51QBkzOuvEY8Y4IqhFSqh4wKI/m6x22hLms/dvW/famkTIHsM
 KcPRxni65QfUrbW8wfmQAufXzUhX2r2GtXNDk05J382T4qkuQ94o9oWf+ik8PnOgdB
X-Received: by 2002:a17:902:d585:b0:2b0:6b98:59ec with SMTP id
 d9443c01a7336-2b2818e55cemr141755655ad.34.1775494493004; 
 Mon, 06 Apr 2026 09:54:53 -0700 (PDT)
Received: from google.com (61-230-33-2.dynamic-ip.hinet.net. [61.230.33.2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27475bc2asm149958175ad.19.2026.04.06.09.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 09:54:52 -0700 (PDT)
Date: Tue, 7 Apr 2026 00:54:49 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/5] virtio: mmio: Keep vendor id little endian
Message-ID: <adPlWa9YE9_FZJXe@google.com>
References: <20260406142411.2992618-1-daniel@thingy.jp>
 <20260406142411.2992618-4-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406142411.2992618-4-daniel@thingy.jp>
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

On Mon, Apr 06, 2026 at 11:24:09PM +0900, Daniel Palmer wrote:
> The vendor id is used as a little endian value but it gets
> swapped to the CPU endian in readl(). Swap it back to le
> to avoid the below weird output from `virtio info`.
> 
> Device 0: UMEQ VirtIO Block Device
>             Type: Hard Disk
>             Capacity: 1.0 MB = 0.0 GB (2056 x 512)
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> ---
>  drivers/virtio/virtio_mmio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 1cd737aca249..ddf873fa96fb 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -374,7 +374,7 @@ static int virtio_mmio_probe(struct udevice *udev)
>  		 */
>  		return 0;
>  	}
> -	uc_priv->vendor = readl(priv->base + VIRTIO_MMIO_VENDOR_ID);
> +	uc_priv->vendor = cpu_to_le32(readl(priv->base + VIRTIO_MMIO_VENDOR_ID));

Hi Daniel,

Thanks for the patch!

While using cpu_to_le32() here does fix the visual output, it feels a
bit hacky because it alters the actual core data value just to satisfy
a display quirk.

For example, if someone in the future writes hardware specific logic
like if (uc_priv->vendor == 0x554D4551), it would silently fail on
m68k.

It looks more like a issue in virtio-blk driver to me.
The code currently does this:

sprintf(desc->vendor, "%s", (char *)&uc_priv->vendor);

This direct memory cast relies on little endian byte ordering to spell
"QEMU". On big endian machines, the memory layout naturally spells
"UMEQ".

So maybe we can extract the characters safely using bitwise shifts like
this?

diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
index 3dd0cf36268..af61939270d 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -168,10 +168,15 @@ static int virtio_blk_bind(struct udevice *dev)
         * virtio mmio transport supplies string identification for us,
         * while pci trnasport uses a 2-byte subvendor value.
         */
-       if (uc_priv->vendor >> 16)
-               sprintf(desc->vendor, "%s", (char *)&uc_priv->vendor);
-       else
+       if (uc_priv->vendor >> 16) {
+               desc->vendor[0] = (uc_priv->vendor >>  0) & 0xff;
+               desc->vendor[1] = (uc_priv->vendor >>  8) & 0xff;
+               desc->vendor[2] = (uc_priv->vendor >> 16) & 0xff;
+               desc->vendor[3] = (uc_priv->vendor >> 24) & 0xff;
+               desc->vendor[4] = '\0';
+       } else {
                sprintf(desc->vendor, "%04x", uc_priv->vendor);
+       }
        desc->bdev = dev;

        /* Indicate what driver features we support */

Regards,
Kuan-Wei
