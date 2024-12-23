Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAC4E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 18:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FFCF80730;
	Mon, 23 Dec 2024 19:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QSh/vLir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E37C8074B; Mon, 23 Dec 2024 19:32:13 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 369AE8056A
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 19:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa6b4cc7270so657756566b.0
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 10:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734978730; x=1735583530; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/i719OrjvVCbgGGEO51OCnMkxR62ZspwRjURROHQOiI=;
 b=QSh/vLirTq2T7/DfcJE+TmwoONnMVc3BOhkYgSYIRUaGCrSuYcwLMGx/8qoXslAJ8a
 dcBJXkTsUfp9RJAYV8w3oonXYRG+VVy187I0ocNZxQ4YTvLKMJnUAaeZQUjzhj8QLmsM
 ULFxGpfz3UxWCz2XGkowla177jaHdWlI8q7+evUafq/vWDrWryd0hwnDbndY9vG90yn4
 CAWf2WuA2S5y/86C7kvCyo6TBdd/q7OpMEjPZOXHAeGCowwJ551wPgLsmmgtAyVFZ1dF
 HG6/NT/w/ZaO3NseM6mHA0NC7pHZu38MkWnF4nb4OtmmJN86XR8TxasMd6bNW6M0d5R2
 FFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734978730; x=1735583530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/i719OrjvVCbgGGEO51OCnMkxR62ZspwRjURROHQOiI=;
 b=dWkhvF9sX8PRIxaok+N3RgQmPSdYR32O1WkJkaQmMgOlNEwnLxj8BOgsLiSS92eoH2
 OHQR4EKIS0rxuABrtTpS7xXMcvCIdKxG4a1cM3esnIgjSpPN1j54uatkbMXLnIOF2C/W
 hF7VbwDUAMliJweOqgsQ9mxRKB+/e8RzDHIYXLQd3NhmuYnMMG99TQlFxvJ042TPHfoS
 0mN3puc3Y865WRlAFBDZkIqXuuHpmBm9jE4JrteenAwA4cmtFfZJm5nF8Vaa1F9nZ5FT
 QyDV6OTVs2ovzOKPnAj1mzUBeHWSVUGSXeFPukEN1HyYY1Zys6sHjfN1dXjifpI7YGfn
 Q0Ng==
X-Gm-Message-State: AOJu0Yxlus37i0sVwx1UCxbVmSCBdLGwRtKElzPO1pAW3cQQ1RBsfDK9
 FuOorqkeFFoEiVkpStDWBwPvck8okPcpIAGjpKNcpEgTpMbuyIG9RLVS9yT2mvTlgfKeqj019f+
 Y+GHelqAWk2TQH++AGBWhjj4mZSM=
X-Gm-Gg: ASbGncu7CnLavEtNFra+6W3dRI3oyRXjxKEHUoLwIgKI5pBtgCfopRisuGf+t7letFE
 k3U1EDSUjtmhTv7Spm1dMjZS6a+66HPacY9HoJuLJMb37ttckXs0=
X-Google-Smtp-Source: AGHT+IGUAuNlaJcB8DkYxDZlljpJKyqGvEHRzH/rDcAmtlBTXu+JQSqZpg3RnTTWD0IZays6+7bnz5NiY0lxvpb4h6U=
X-Received: by 2002:a05:6402:348d:b0:5d4:55e:f99e with SMTP id
 4fb4d7f45d1cf-5d81ddc09abmr30765761a12.18.1734978730330; Mon, 23 Dec 2024
 10:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-5-trini@konsulko.com>
In-Reply-To: <20241220222612.1757884-5-trini@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 23 Dec 2024 18:31:58 +0000
Message-ID: <CALeDE9M8X7ZK=JSxgADA75XLaJo40g0fKVB3PYHttouj1M1AfQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] blk: Make block subsystems select BLK
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, 20 Dec 2024 at 22:36, Tom Rini <trini@konsulko.com> wrote:

> The BLK symbol has a few meanings, one of which is that it controls the
> driver model portion of a "block device". Rather than having this hidden
> symbol be "default y if ..." it should be select'd by the various block
> subsystems.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
>

Just a minor query against the USB change, other than that the rest looks
fine.

Reviewed-by: Peter Robinson <pbrobinson@gmail.com>


> ---
>  drivers/ata/Kconfig    | 2 ++
>  drivers/block/Kconfig  | 7 +++----
>  drivers/mmc/Kconfig    | 1 +
>  drivers/nvme/Kconfig   | 1 +
>  drivers/scsi/Kconfig   | 1 +
>  drivers/usb/Kconfig    | 1 +
>  drivers/virtio/Kconfig | 1 +
>  7 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 4fbb63a148ac..29ceab849c02 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -1,6 +1,7 @@
>  config AHCI
>         bool "Support SATA controllers with driver model"
>         depends on DM
> +       select BLK
>         help
>           This enables a uclass for disk controllers in U-Boot. Various
> driver
>           types can use this, such as AHCI/SATA. It does not provide any
> standard
> @@ -9,6 +10,7 @@ config AHCI
>
>  config SATA
>         bool "Support SATA controllers"
> +       select BLK
>         help
>           This enables support for SATA (Serial Advanced Technology
>           Attachment), a serial bus standard for connecting to hard drives
> and
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 5283d8981e09..cc75bad02b8c 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -1,8 +1,5 @@
>  config BLK
> -       bool # "Support block devices"
> -       depends on DM
> -       def_bool y if MMC || USB || SCSI || NVME || IDE || AHCI || SATA
> -       def_bool y if EFI_MEDIA || VIRTIO_BLK || PVBLOCK
> +       bool
>         help
>           Enable support for block devices, such as SCSI, MMC and USB
>           flash sticks. These provide a block-level interface which permits
> @@ -100,6 +97,7 @@ config TPL_BLOCK_CACHE
>  config EFI_MEDIA
>         bool "Support EFI media drivers"
>         default y if EFI || SANDBOX
> +       select BLK
>         help
>           Enable this to support media devices on top of UEFI. This enables
>           just the uclass so you also need a specific driver to make this
> do
> @@ -139,6 +137,7 @@ endif  # EFI_MEDIA
>
>  config IDE
>         bool "Support IDE controllers"
> +       select BLK
>         help
>           Enables support for IDE (Integrated Drive Electronics) hard
> drives.
>           This allows access to raw blocks and filesystems on an IDE drive
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index 46513db0d6e3..4827834b4aab 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -3,6 +3,7 @@ menu "MMC Host controller Support"
>  config MMC
>         bool "MMC/SD/SDIO card support"
>         default ARM || PPC || SANDBOX
> +       select BLK
>         select DM_MMC
>         help
>           This selects MultiMediaCard, Secure Digital and Secure
> diff --git a/drivers/nvme/Kconfig b/drivers/nvme/Kconfig
> index 73edb3551606..d138867666bd 100644
> --- a/drivers/nvme/Kconfig
> +++ b/drivers/nvme/Kconfig
> @@ -4,6 +4,7 @@
>
>  config NVME
>         bool "NVM Express device support"
> +       select BLK
>         help
>           This option enables support for NVM Express devices.
>           It supports basic functions of NVMe (read/write).
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 7e21c4ae2bb8..fc87d34cca39 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -1,5 +1,6 @@
>  config SCSI
>         bool "Support SCSI controllers with driver model"
> +       select BLK
>         help
>           This enables support for SCSI (Small Computer System Interface),
>           a parallel interface widely used with storage peripherals such as
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 960b6a906ac4..99c6649e4178 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -1,5 +1,6 @@
>  menuconfig USB
>         bool "USB support"
> +       select BLK
>

Shouldn't this be against USB_STORAGE further down the file?


>         ---help---
>           Universal Serial Bus (USB) is a specification for a serial bus
>           subsystem which offers higher speeds and more features than the
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 1de68867d52e..512ac376f185 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -64,6 +64,7 @@ config VIRTIO_NET
>  config VIRTIO_BLK
>         bool "virtio block driver"
>         depends on VIRTIO
> +       select BLK
>         help
>           This is the virtual block driver for virtio. It can be used with
>           QEMU based targets.
> --
> 2.43.0
>
>
