Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88664C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B7F188971;
	Tue, 16 Jul 2024 09:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Fy72otwY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7478E88979; Tue, 16 Jul 2024 09:41:57 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EF8388939
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3680667d831so2053159f8f.3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721115715; x=1721720515;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7K2T6oYmxHQYhRMHBrEfU3+X8BpJGOrTYgEo+wqI+rM=;
 b=Fy72otwY23dtGzwNjRWDQNZXgSUOE+KEQkkKZ9qJIrgIXDXTIjKjbYbB2I6WRTEL17
 /AtQvDZdAXvCx79/A3UVUPR3c7bDQi8BV8icq2i0kCNlcmqcvLbEnDUDeKk6SESeULtP
 Jczw/9aBF65YW5iDm4W2dCykwXzng9k9YH+ASOJ0Lzak8TFJwBh/4XJHiFnr1Qxft/+2
 LwekLlTKWXm0SEOmiNRYzTNYOG4jFTM4B8MLR2WM6jU9Y1ZK8i66iLh0LxJCIYhMdeo9
 eocbFtQrkW0F60kcgVbM4OCg2zT5OW7m7HEftfXRFJhWo7G2BFWMXn9M9Z09OyVUN4zZ
 2T5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721115715; x=1721720515;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7K2T6oYmxHQYhRMHBrEfU3+X8BpJGOrTYgEo+wqI+rM=;
 b=rJKbkeYL2FTKmoEMCeZzxZe6WKshcrDBHls7+IdvWJi2RX1AFGY/AJb+ocV5yCKkp2
 FAtqMRKonAVKehyPSI7PpT1XER/beK3fpX6dcJEqk2nOHp1cst/upvtEcZLvpzi7FeGs
 c0e7AA15m2zauwiCSkodLBCFpQjpyrYbPy8OifEuZFg1rvNUn5heVNGHF57d3pdAxB2l
 T7kH8R5rn3uDny5u22Gy+1AQYOm+pfB9As3X0/D0cgZ9G6pul6W/35oiGiQ5O72K9UKC
 tOUHEbTQj4cR+dlDveg1/odvn02/MQJV6eIBK2YjShge4nlvQoyLsyCqMcsIZlVqcUum
 aFsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF22KROLN68lcHz4AcnFlWcVs870+6szZ45fuU9tAwkjHIlrH8ZL3UKgdy2gg0wfCQeL1y9/gb3N3d/5AVvO2RuX5ZHg==
X-Gm-Message-State: AOJu0YwwUKcFsmV6uozPNWHQTN3KYoPKIMTUJyKKY1QqqSW8igwGnT0C
 mfyLBVq7537compdRty24kNHIuM7qoWTC/ppqxpUp8p3ixwsefXVpw9kPzX8teodJExldJ4INrw
 sgA1S3g==
X-Google-Smtp-Source: AGHT+IGcZ7I0iBchJ1Wr/wsLUtMi8AWgGqixStfZPQCy+vhcc9LUdZv9+KTfS4TpnxKBYeM6XaP3FQ==
X-Received: by 2002:a5d:40c9:0:b0:367:98e6:2a1a with SMTP id
 ffacd0b85a97d-368263159c7mr741649f8f.49.1721115714634; 
 Tue, 16 Jul 2024 00:41:54 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db046e2sm8226987f8f.105.2024.07.16.00.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:41:54 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 08/14] doc: Add a description for bootmeth_sandbox
In-Reply-To: <20240716070419.1897560-9-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
 <20240716070419.1897560-9-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:41:51 +0200
Message-ID: <87le21n5q8.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Simon,

Thank you for the patch.

On mar., juil. 16, 2024 at 08:04, Simon Glass <sjg@chromium.org> wrote:

> Add documentation for the sandbox bootmeth.
>
> Fix up the compatible string to drop the 'extlinux' part, which is not
> relevant to this bootmeth.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> Changes in v2:
> - Adjustments from Heinrich's comments
>
>  boot/bootmeth_sandbox.c          |  2 +-
>  doc/develop/bootstd/index.rst    |  1 +
>  doc/develop/bootstd/overview.rst |  1 +
>  doc/develop/bootstd/sandbox.rst  | 17 +++++++++++++++++
>  4 files changed, 20 insertions(+), 1 deletion(-)
>  create mode 100644 doc/develop/bootstd/sandbox.rst
>
> diff --git a/boot/bootmeth_sandbox.c b/boot/bootmeth_sandbox.c
> index 0bc8f688e30..26c713bb5f3 100644
> --- a/boot/bootmeth_sandbox.c
> +++ b/boot/bootmeth_sandbox.c
> @@ -55,7 +55,7 @@ static struct bootmeth_ops sandbox_bootmeth_ops = {
>  };
>  
>  static const struct udevice_id sandbox_bootmeth_ids[] = {
> -	{ .compatible = "u-boot,sandbox-extlinux" },
> +	{ .compatible = "u-boot,sandbox-bootmeth" },
>  	{ }
>  };
>  
> diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
> index 69fd3c2d2eb..2c5d2d3fade 100644
> --- a/doc/develop/bootstd/index.rst
> +++ b/doc/develop/bootstd/index.rst
> @@ -11,3 +11,4 @@ Standard Boot
>     pxelinux
>     qfw
>     cros
> +   sandbox
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
> index 9b50b5593c4..add054f3088 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -420,6 +420,7 @@ Bootmeth drivers are provided for booting from various media:
>     - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk
>     - EFI boot using boot manager
>     - :doc:`QFW <qfw>`: QEMU firmware interface
> +   - :doc:`sandbox <sandbox>` used only for testing
>  
>  Each driver is controlled by a Kconfig option. If no bootmeth driver is
>  selected by a compatible string in the devicetree, all available bootmeth
> diff --git a/doc/develop/bootstd/sandbox.rst b/doc/develop/bootstd/sandbox.rst
> new file mode 100644
> index 00000000000..a90c1accc84
> --- /dev/null
> +++ b/doc/develop/bootstd/sandbox.rst
> @@ -0,0 +1,17 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +Sandbox Bootmeth
> +================
> +
> +The sandbox bootmeth is only used for testing. It does not provide any facility
> +for booting an OS. While sandbox can do all the processing before the actual
> +boot, it is not connected in this bootmeth.
> +
> +When invoked on a bootdev, this bootmeth pretends to find a bootflow and creates
> +the associated structure.
> +
> +When the bootflow is booted, the bootmeth returns -EENOTSUPP indicating that it
> +is not supported.
> +
> +The compatible string "u-boot,sandbox-bootmeth" is used for the driver. It is present
> +if `CONFIG_BOOTMETH_SANDBOX` is enabled.
> -- 
> 2.34.1
