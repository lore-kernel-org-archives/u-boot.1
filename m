Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD76C369C2
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 10:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E42F58192A;
	Mon, 21 Apr 2025 12:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dGr0Encd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79B0281F0D; Mon, 21 Apr 2025 12:10:13 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 764838192A
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 12:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac25520a289so501422566b.3
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 03:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745230211; x=1745835011; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZyCKXMmKhJNYk+h22nUYKXf8UMPT6u1SolGLi0CjMHA=;
 b=dGr0EncdUgzLamuuM29PPbKz9uon/QgugeBCSQFz6ZL1LKetRbXN5PncsOD8dzbj/l
 8PVLR+zbn1C7S/meZiylCXevQXDiTobVcVv8QT0MLBhZTwBUQNzSrY6vn4qJB+B19Jaf
 cKWmJQIewZe+DmsBloX7/FQGH3o4whgCR6HTAEzLCzJv+glV5P7NWlx6YirNXNJp/PvX
 tf101iJ48/dC4MB7Nbsecm5tqn6YScH0+jVsActx2yhekj9yBfhf/q8bDpw0PO7pEdXJ
 UI/JfuEKCSC27db/bJRMxyqZPgwr72aXINMWawkfom9eXDKzfbXnmzvZLx7wV3KgDq+e
 VaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745230211; x=1745835011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZyCKXMmKhJNYk+h22nUYKXf8UMPT6u1SolGLi0CjMHA=;
 b=HmCSKwxwBfxXIPXMKucaCIjeHhv/3z0SYc7MvDxriAb+12WOG/8otb6pfWJLsrjvQb
 Mnzf4KynvbbXYjM0oj4Yv4b3RSKkGunnY1eP7nuzO0w9WtDZ3qGWm/hG8xRskO+DVNJe
 GFinLQRpatjiE74yxkKiT9yOuxYOKYYBdkwkUvJTBhOXRWwHJ2ODmmvsUxRh7AsUYRbY
 GPuhvy5fuGo4QJzpQkEve9hPUCHOKN2nhgjU+g+YRwD1t0fGU01rolcUtq4sn+wCtEdi
 l/ZiaCL9z2hiqW3yFlzAQUSvXvOc0AvirTjGgKyIBJXW8ZspkyJ9ZK1EWi/Tqd2oX3Q1
 CyQQ==
X-Gm-Message-State: AOJu0YzH225me/bRKnV8Op1pvX0ADhVsll1MblXhwQIgUcXsR1XV68ou
 CdwPJo7R56OILuuiO2j3w1fjWsdh3agnlewfL3BTDqSR+WdiX/9C4DX0sr8hSIxCocqyMppMrAi
 FpAZtGaMhdWqHAA8vDX6t3zgzFlU=
X-Gm-Gg: ASbGnctPbuNDzoR/JFGTs/MMaXvfagRBOGrIaAgQ2R5WVKlSAIEiLi0ZKgGuS7Z5QwW
 qVMDaqGjNx8qP+4qlYk6FJ0s1nNGwEpkuX1J3Ie+4zMchjjRq/7LvVi4hsmg2KcmP41byM/9i/6
 c0tibN9NL6r5X1nrAjomr9R4DCMvyWSWpCqdf2co6KRdFZs8aBEg==
X-Google-Smtp-Source: AGHT+IEeLJM/bH04prIkVD72xUwtvtmnkla7QSS0hqF6qcoED30bGB3VaJdpODs/jbkEfsCnAIOJni3isqYfTWjW1qw=
X-Received: by 2002:a17:907:98b:b0:ac1:e881:8997 with SMTP id
 a640c23a62f3a-acb74aa9ffemr1113585166b.3.1745230210567; Mon, 21 Apr 2025
 03:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241220003447.2913443-1-sjg@chromium.org>
 <20241220003447.2913443-5-sjg@chromium.org>
In-Reply-To: <20241220003447.2913443-5-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 21 Apr 2025 11:09:59 +0100
X-Gm-Features: ATxdqUEMHw6L8-xtLTUv-cxE9_Njf6LgPWKT6cVfH1h5UnocNEb5IAhNMpHjBdA
Message-ID: <CALeDE9MhePJOFBaW8HO=sEpRK8SRr=x4uCufas_bvS7cG4zhMQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] rpi: Update environment to support booti and large
 initrd
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>, 
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
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

Applied

On Fri, 20 Dec 2024 at 00:35, Simon Glass <sjg@chromium.org> wrote:
>
> The existing values don't provide for decompressing an arm64 boot-image.
> Add those values and move things apart a bit so that a 50MB kernel can be
> accommodated.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Update the comment block with the new values, including compression
>
>  board/raspberrypi/rpi/rpi.env | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> index 9b9fad82828..9ac9d6768ca 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -48,28 +48,33 @@ dfu_alt_info+=zImage fat 0 1
>   *
>   * scriptaddr and pxefile_addr_r can be pretty much anywhere that doesn't
>   * conflict with something else. Reserving 1M for each of them at
> - * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty.
> + * 0x05400000-0x05500000 and 0x05500000-0x05600000 should be plenty.
>   *
>   * On ARM, both the DTB and any possible initrd must be loaded such that they
>   * fit inside the lowmem mapping in Linux. In practice, this usually means not
>   * more than ~700M away from the start of the kernel image but this number can
>   * be larger OR smaller depending on e.g. the 'vmalloc=xxxM' command line
>   * parameter given to the kernel. So reserving memory from low to high
> - * satisfies this constraint again. Reserving 1M at 0x02600000-0x02700000 for
> - * the DTB leaves rest of the free RAM to the initrd starting at 0x02700000.
> - * Even with the smallest possible CPU-GPU memory split of the CPU getting
> - * only 64M, the remaining 25M starting at 0x02700000 should allow quite
> - * large initrds before they start colliding with U-Boot.
> + * satisfies this constraint again. Reserving 1M at 0x05600000-0x05700000 for
> + * the DTB leaves rest of the free RAM to the initrd starting at 0x05700000.
> + * This means that the board must have at least 128MB of RAM available to
> + * U-Boot, more if the initrd is large.
>   *
> - * Limit bootm_size to 512MB so that all boot images stay within the bottom
> + * For compressed kernels, the maximum size is just under 32MB, with an area for
> + * decompression at 0x02000000 with space for 52MB, which is plenty for current
> + * kernels.
> + *
> + * limit bootm_size to 512MB so that all boot images stay within the bottom
>   * 512MB of memory
>   */
>  bootm_size=0x20000000
>
>  kernel_addr_r=0x00080000
> -scriptaddr=0x02400000
> -pxefile_addr_r=0x02500000
> -fdt_addr_r=0x02600000
> -ramdisk_addr_r=0x02700000
> +kernel_comp_addr_r=0x02000000
> +kernel_comp_size=0x03400000
> +scriptaddr=0x05400000
> +pxefile_addr_r=0x05500000
> +fdt_addr_r=0x05600000
> +ramdisk_addr_r=0x05700000
>
>  boot_targets=mmc usb pxe dhcp
> --
> 2.34.1
>
