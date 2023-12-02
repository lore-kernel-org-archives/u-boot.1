Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A445CC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 688B387759;
	Sat,  2 Dec 2023 19:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HEf8mwB/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E71A08774E; Sat,  2 Dec 2023 19:28:32 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E33DA87720
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5d4f71f7e9fso16549027b3.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541707; x=1702146507; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bhV9QWsQF2J39P4LKolwti7+tYqej/Rq5FbP7op6MwM=;
 b=HEf8mwB/M7Kk+2ZPvzLfUaBNF6mvYXwT89uFSb5PapCkMTyRMjBn9bDdD0jP7frDMm
 BA10ba6gPMcI+XZF684L7j/kdXuBwpSgt3hXsKDDM6bIWQ2CNwEDBPFo9fD2xXjDnUeA
 ngGK4nHYLw3ZF3UE1euAnfgY7As8OpXEqMcss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541707; x=1702146507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bhV9QWsQF2J39P4LKolwti7+tYqej/Rq5FbP7op6MwM=;
 b=ECYAyVSywbMCcYsXb15pv40mHu8QKVWQQYLLk0uIqzbugnODT06ybz2Pw1pWzhImRD
 6OUZsXRw2Nj+h67hE+wAyOvih5zV9T9cEHlElzZis0W0gTgE4Q7kFtboF2M2LN1eWy1M
 q9/H5rLy0sYGs96xHlSuNVhoKXwRWtum2pMTCkun/J68I1LA3h2WRvylyVtdFqlb21UV
 m2zOdxf5+FSaXpYWubt+7QUU3sWM9LG63HxmpHV4kMwN/FVnZ5WVE4rlw3u1B3ELMW6Y
 jRPv/CB8BQ1gyZkOLGSSXlnhl8K8gYdZFyN9u5QPbmxy0kGD5LpM4GaVISYyxBht2L/D
 dNrg==
X-Gm-Message-State: AOJu0YyRLapC38aDkx8YCArbQkwI8isX7mohVtYBQrRBwytUYTXEW/Xc
 nVtxsVGXbunuwFMjJEdj/61XGH/ytPNHpHi57Ovu/OQicJly+Ik+nQHfkw==
X-Google-Smtp-Source: AGHT+IHw/gx3XDtuu89qY7Gl+DXrGAsfXPINVtkxKiinCEqbr8gynESyNe9HD71uX0SzvcxB6eEpHK0U0UCc7l4TFu8=
X-Received: by 2002:a81:9ad6:0:b0:5d7:1940:dd8b with SMTP id
 r205-20020a819ad6000000b005d71940dd8bmr887637ywg.97.1701541707416; Sat, 02
 Dec 2023 10:28:27 -0800 (PST)
MIME-Version: 1.0
References: <45DABC1E-1E63-47C5-BFBF-689EE01AAE48@web.de>
In-Reply-To: <45DABC1E-1E63-47C5-BFBF-689EE01AAE48@web.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:27:13 -0700
Message-ID: <CAPnjgZ1d08hYcCTFXQZto_FnrQewqJJ-asNu8uMcWbRncf7jcQ@mail.gmail.com>
Subject: Re: How to use I2C in U-Boot SPL
To: Thomas Thielemann <th.thielemann@web.de>
Cc: u-boot@lists.denx.de
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

kHi Thomas,

On Wed, 22 Nov 2023 at 13:57, Thomas Thielemann <th.thielemann@web.de> wrote:
>
> Hello U-Boot,
>
> I was able to use the I2C commands from within U-Boot to control my I2C device:
>
> Configured the Processor GPIOs for the I2C bus in device tree
> Enabled the I2C bus in device tree
> Added my device to the I2C bus in device tree
> Wrote my script into a U-Boot variable
> Run my script
> Now I want to do the same from within the U-Boot SPL. I extended int board_early_init_f(void) in board.c for my hardware. The debug output is printed at run time. But the I2C device is not found.
>
> How do I review whether the I2C bus is using the right GPIOs and whether my device is configured right?
>
> static int i2c_get_dev(uint bus_num, uint dev_num, struct udevice **i2c_dev)
> {
>     int ret;
>
>     if (!i2c_led_bus) {
>         ret = uclass_get_device_by_seq(UCLASS_I2C, bus_num, &i2c_led_bus);
>         if (ret) {
>             printf("I2C bus %i not found (%d)\n", dev_num, ret);
>             return -ENODEV;
>         }
>     }
>
>     return i2c_get_chip(i2c_led_bus, dev_num, bus_num, i2c_dev);
> }
> #endif
>
> static int i2c_enable_leds(void)
> {
>     log_info("i2c_enable_leds\n");
>     const uint  bus_num = 1;    // i2c bus
>     const uint  dev_num = 0x28;     // i2c chip address
>     const uint  dev_addr = 0x00;    // write all bytes in one junk from start
>     const uint  dev_addr_len = 1;
>     int     ret;
>     const uint  cmd_len = 29;       // cmd_len is the number of bytes.
>     uchar   cmd[29] = {
>         0x40, 0x3c, // init
>         0x00, 0x00, 0x00, 0x00, 0x00, // unused
>         0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, // set intensitiy to max
>         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // unused
>         0xff, 0x00, 0x00, // RGB LED
>         0xff, 0x00, 0x00 // RGB LED
>     };
> #if CONFIG_IS_ENABLED(DM_I2C)
>     struct udevice *i2c_dev;
>     struct dm_i2c_chip *i2c_chip;
> #endif
>
> #if CONFIG_IS_ENABLED(DM_I2C)
>     ret = i2c_get_dev(bus_num, dev_num, &i2c_dev);
>     if (!ret)
>         ret = i2c_set_chip_offset_len(i2c_dev, dev_addr_len);
>     if (ret) {
>         log_err("Failed to write to 0x28 (%d)\n", ret);
>         return ret;
>     }
>     i2c_chip = dev_get_parent_plat(i2c_dev);
>     if (!i2c_chip) {
>         log_err("Failed to write to 0x28 (%d)\n", ret);
>         return ret;
>     }
> #endif
>
> #if CONFIG_IS_ENABLED(DM_I2C)
>         i2c_chip->flags &= ~DM_I2C_CHIP_WR_ADDRESS;
>         ret = dm_i2c_write(i2c_dev, dev_addr, cmd, cmd_len);
> #else
>         ret = i2c_write(dev_num, dev_addr, dev_addr_len, cmd, cmd_len);
> #endif
>         if (ret)
>             log_err("Failed to write to 0x28 (%d)\n", ret);
>
>     return 0;
> }
> int board_early_init_f(void)
> {
>     i2c_enable_leds();
>
>     return 0;
> }

You should use driver mode for this, i.e. add your i2c device to the
devicetree with a suitable driver in place, then probe it, e.g. with
uclass_first_device(UCLASS_LED)

Accessing the chip directly like this is a bit hacky :-)

If you include a bit more info about what piece breaks, it would help
people to offer ideas.

Regards,
SImon
