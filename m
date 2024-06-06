Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96687C41513
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 07:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 088CC882C1;
	Thu,  6 Jun 2024 09:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jeQMTRFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7C55881D9; Thu,  6 Jun 2024 09:16:11 +0200 (CEST)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87669882C1
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 09:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-80ae09dce7eso187078241.2
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717658166; x=1718262966; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SSuo+kC90PULGZOoPmTUQMcKm7Z91j5G4jEgcJ+UuAw=;
 b=jeQMTRFblxHhYcm8DlaYytNKRDokcN4KyJvnhxeYFKupMBnDU9X7wUt8o3P5S3B1kW
 Wob5meCcqBMj9Vp5nEaG7Etr0tK46zWYum88H2lV23IMuxkH/5ejWyRjKtPGbc+nLXJY
 VFAzGqfmzb36suLiGcez/0xMROBwUiLJAkVxWe/uOv6HA2x3A+yOloGtfmhdg220ZZsW
 bPe1apf8OwEoH0+nAwhjGhfOv68X0wD9xDZfdIDkOsw787clXHmE3Xc9uBZALs7tBSiC
 yBTqdrO212PmKWwLQF2GPnpzea/B3MfoH93DN5BSPvmc7adLbXkBiyVMAR8c+yXGaB9W
 uYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717658166; x=1718262966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SSuo+kC90PULGZOoPmTUQMcKm7Z91j5G4jEgcJ+UuAw=;
 b=htLDssvy4qQ5e5kDkALX436gwJ+8l0tOZKYy9Zh6GPflZ6qdMVGKGfT9wCNIbGOSOr
 7plm0d/iKdWT8YUAndWBcWLjOLjRi9eHRAlXBv3TFAuiIABmVA2Jj9T9nYGNoi7Unjk4
 CxDW17rToJJvLryRNKp9C2voaNw6IT9wDzcXfYF/l5rUVCQ0e03jCjDSszrSdt/H2sQH
 Wnqi8MLwfnmioyTbGQQbcYE7fHoTwAHs42n7GJ3r9VbiRf7vMDSk6O3t9pZ9hr3tP+99
 tr/2OjIJWrCOcfE/kIAFWdpxLATIM55caWvqJknvJfnlWieqPUjDn0TyA3c7Xld4DRe6
 X6tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnRkTTUO5mefwvdT7jhhkfDEvCgV6g8+5SELkQvT8WBdA/dKb85f3tuAx9B73aOFsKxnDMTtQraKdqI03WbiZ9sNH+FQ==
X-Gm-Message-State: AOJu0Yw/vkcxf4PXINFX6gTS/9tF6YDH5PNgeTLHG/2xYk79WvT1W7Qe
 MRvnOE1lX/9BL+dUOJpP2+k+P2EpdsMmCxHN78eXg8rH3QlMvX1njcEMCwtLaEX2AMMVWjMVhar
 +Vsy86dPVc0w4ck6de4zA6MIf2mADrko2Wb7tCw==
X-Google-Smtp-Source: AGHT+IG5QHSEDJyJITNi5R0cIxl+2bJ5W6ZxsMtI0hk+LVHNfJXysVCRNnT4gN46B7ufi/F1o7U998ZPfxbiNjsIkGI=
X-Received: by 2002:a67:b346:0:b0:48b:a6d1:774 with SMTP id
 ada2fe7eead31-48c04aab9bbmr5048374137.22.1717658166051; Thu, 06 Jun 2024
 00:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
 <20240603-b4-qcom-capsule-updates-v3-4-fe2e083289ec@linaro.org>
 <CAFA6WYNa2zQoHqqaGYxQ=x=3jdw=rKMVRjXLCB65HG6CxNQAwQ@mail.gmail.com>
 <0361e6b1-b0cc-453b-968e-999d1913a3db@linaro.org>
In-Reply-To: <0361e6b1-b0cc-453b-968e-999d1913a3db@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 6 Jun 2024 12:45:55 +0530
Message-ID: <CAFA6WYNSKdua=g1h5h7YVTyODMc5ZdrZh8Xs9WiE7ff0atF4_w@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] mach-snapdragon: implement capsule update support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Wed, 5 Jun 2024 at 18:03, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Sumit,
> >> +/**
> >> + * qcom_configure_capsule_updates() - Configure the DFU string for capsule updates
> >> + *
> >> + * U-Boot is flashed to the boot partition on Qualcomm boards. In most cases there
> >> + * are two boot partitions, boot_a and boot_b. As we don't currently support doing
> >> + * full A/B updates, we only support updating the currently active boot partition.
> >> + *
> >> + * So we need to find the current slot suffix and the associated boot partition.
> >> + * We do this by looking for the boot partition that has the 'active' flag set
> >> + * in the GPT partition vendor attribute bits.
> >> + */
> >> +void qcom_configure_capsule_updates(void)
> >> +{
> >> +       struct blk_desc *desc;
> >> +       int ret = 0, partnum = -1, devnum;
> >> +       static char dfu_string[32] = { 0 };
> >> +       char name[32]; /* GPT partition name */
> >> +       char *partname = "boot";
> >> +       struct udevice *dev = NULL;
> >> +
> >> +       /*
> >> +        * There is currently no good way to check how U-Boot is booting, but we have
> >> +        * a few hueristics, like here checking if our DTB has a kaslr-seed specified
> >> +        * will tell us if we were chainloaded by another bootloader.
> >> +        * FIXME: we should do this check once and use some proper API to expose the data.
> >
> > If U-Boot is built with LINUX_KERNEL_IMAGE_HEADER enabled then we
> > should know that U-Boot is built as a replacement of Linux kernel and
> > hence chainloaded. Isn't that what you need here?
>
> Not necessarily, you can build with LINUX_KERNEL_IMAGE_HEADER and then
> pack U-Boot into XBL or flash it to hyp and it will still run (the
> kernel header is specifically written to behave like a nop slide). So we
> can't rely on this.
> >

Yeah you can build it in whatever form downstream and run as a NOP too
but I don't think we support any such combination in upstream U-Boot,
right? We should let people know that LINUX_KERNEL_IMAGE_HEADER should
only be enabled if the U-Boot image is flashed into the boot partition
as a replacement for Linux kernel image. BTW, isn't that the real
meaning for that config option? IMHO, the current DT check you have
implemented is implicit and I am unsure if we can reliably depend upon
it.

-Sumit
