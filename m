Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4796E95A62
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E667D86DC5;
	Sat,  7 Oct 2023 22:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GMmbUt5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E0828691E; Sat,  7 Oct 2023 22:19:14 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 967B3863CF
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9a9f139cd94so544230566b.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696709947; x=1697314747; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Im+cJfozZpRiwGpqQhQ/wG+DFqVQNWj1I3lMM/m9ZVE=;
 b=GMmbUt5zZMxbQTc+8TkvRX4BRAzA9c4idFGC9qwHAbL6iGtFiQahFNg7Q0WHcDOqVX
 QYImuSzrvvOVSK6wBs1NDzD8zHIl5BxJfgUDOh0NqDdpBpFnR4XWiUSeCThI6koe3h5D
 UW8zbDUXvrZlzShMeDyPvrT2ZYKiHjK2gaCdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696709947; x=1697314747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Im+cJfozZpRiwGpqQhQ/wG+DFqVQNWj1I3lMM/m9ZVE=;
 b=VSfH9C9xYpHnBhBY4EOO1pwjuVXULes7UpJ9HTIAnGb/bv3cREYWCb6044a3C4e5WZ
 8JfLkU02UjjcGobwQlvmWVVL9/XR1DP3LjobHzq1sb1DUEO8kAV/qrVJRys/6oq1DTh2
 LeCjzy2PwzJ1vaHIgvh7PWp2R5Zv53G7Jj5EHQ/WBDrFPb4CZfDzEa5/D/PDN8TcypMe
 YliNyhI3lJKcigc7BM1mln8F8gYb1IT035AkgshNNJBvj3IXIqCZnBUmw3wDFQu3K3zm
 yRxIMihQI7U8JSdaC2awb98GJLxXiT6APpY6abrlmoCxr9edB6qQspxNR3IRFfhFCPvt
 ICzQ==
X-Gm-Message-State: AOJu0YyXQcbGyvnJ3l9VmwpYTCwQb0lEG2pgFA9oebza9lDt4On7fwtf
 Noo9Rjx1yjoImMx3tiVldCQjkRuFIE0mNDMZDg8APA==
X-Google-Smtp-Source: AGHT+IGTUDZMlXg0Gd01AuoTrbmXw/EIrnXBm7AhCbO92Oj8A5LRSOvJSHcyud8TAW0boMrEhc/tFX5fLEK3CkHHNfA=
X-Received: by 2002:a17:907:2d8d:b0:9a5:a701:2b90 with SMTP id
 gt13-20020a1709072d8d00b009a5a7012b90mr14236829ejc.40.1696709946837; Sat, 07
 Oct 2023 13:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231007155535.1699567-1-benwolsieffer@gmail.com>
In-Reply-To: <20231007155535.1699567-1-benwolsieffer@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Oct 2023 14:18:48 -0600
Message-ID: <CAPnjgZ0qrDB_+HUNdGeCzS2FS4+fb1x9Cyr7xTjGccLCHpxwWg@mail.gmail.com>
Subject: Re: [PATCH] arm: rpi: explicitly enumerate mmc boot targets
To: Ben Wolsieffer <benwolsieffer@gmail.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Ben,

On Sat, 7 Oct 2023 at 09:55, Ben Wolsieffer <benwolsieffer@gmail.com> wrote:
>
> Using the unqualified "mmc" boot target causes the Raspberry Pi 4 to
> fail to boot. c771e5b explains this approach as follows:
>
> > We don't need to specify the mmc devices individually, since they are
> > used in order from 0 to 2, and standard boot uses that order anyway.
>
> In practice, U-Boot first attempts to boot from the unconnected mmc1
> interface, and, when this fails, moves on to attempt the USB and network
> boot targets rather than trying mmc0.
>
> This patch explicitly enumerates the mmc interfaces, causing each to be
> attempted in turn. This matches what is done on other boards, and allows
> the system to boot successfully.
>
> Fixes: c771e5b8c2 ("arm: rpi: Switch to standard boot")
> Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
> ---
>  board/raspberrypi/rpi/rpi.env | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> index 30228285ed..02210b97b5 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -74,4 +74,4 @@ pxefile_addr_r=0x02500000
>  fdt_addr_r=0x02600000
>  ramdisk_addr_r=0x02700000
>
> -boot_targets=mmc usb pxe dhcp
> +boot_targets=mmc0 mmc1 mmc2 usb pxe dhcp
> --
> 2.42.0
>

Does this patch help? [1]. Alternatively, if you just remove that
variable entirely, does it do the right thing?

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230923205017.1754340-1-sjg@chromium.org/
