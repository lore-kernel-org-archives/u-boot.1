Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BFBC36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 22:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB05382C13;
	Mon,  7 Apr 2025 00:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bA00D5Rj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C69882B8E; Mon,  7 Apr 2025 00:09:35 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 848D182C13
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 00:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac2963dc379so610368966b.2
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 15:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743977373; x=1744582173; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b0jBW5X0XiYSii1oOb5znw50BBByw8cuiN8gAQ9IO0E=;
 b=bA00D5RjttTZ+NZ8g0x1EzeOHCuW38r030zeZvuitR67OrEU62YB+cpgo8Dv3FBE8S
 OI4tQoO8ViHeq3txAiehk6IVmz8IwHaIKN8IcAlOjIK5g9Sh0jqmN2L1WZclJFJzYSmN
 Sy7uTqESO0H8U19dzXwhMcUiDF553G6aT4RCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743977373; x=1744582173;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b0jBW5X0XiYSii1oOb5znw50BBByw8cuiN8gAQ9IO0E=;
 b=g30Y1GNaxna4BlKGo/TP9yGcAWogxnNE3ZkVfbfsFFwKDhIdIUj3dimYBxq8NpJOv9
 ygOREy4+JMTjr/K5u40fgOdb0NVdyiee4xAXBVW1RIVIQ269K4uXMQPJ8+YlUiJmWG/e
 4Z7rpg4ZO5wVG46rh9cyH6dkjrMMgHWnYXYVJQMNTQPWTY5/bLzJt1lifjZSjwQoHBoz
 yTybj8RQ2TlBGvF0Srpnm20RXqgYiAzhEzgQG31wB3vEyVNydAFKhFRiFoI+xSXLFfe+
 JCvgjGIGda3L1+bpxhuD66pzNUUhtN8Nl1ssykefSE3siAHnUQFLxXaOIfM8YIktLsJH
 W1Rw==
X-Gm-Message-State: AOJu0YxBDE/wrLBsKIQ+j2v8yqA6W8amen5so3D300JfjgtUsfBeXaiN
 SvNTp5D/XY9oyQZa7dm3BuexCjAaBvpcH6ghOs/ovyc/GHM9S8+gqSAb4Co6QPT/wTVdH2tcIaD
 lQivkr1JPcG82D43NyQmydWI9tcRfJYv1Ekm1
X-Gm-Gg: ASbGncvyO1+9Ztyjd9uOhJmhzvPCHA2opHR5NZzBkRPdAnZxGnkzHbQjl/Iy6BEyOEc
 mAPP9uO2pkeJXFPT0NbUWz7NrWh5snbPHxGRZVHAPnWYAe4sts31RMz0I2X7oN/I/gd1h4QXBaM
 DXFnc3q4y/fWUy6W+V8hYjVVxcnGRzRA8Qhw/G
X-Google-Smtp-Source: AGHT+IHqzqaphfhaNCTAvlxk9NnjEJkEml4Wrym+NvvL8mOccqJhL8sIU2+GtsQq84RsrlHJtrd2lcCidsS7PXvK2ks=
X-Received: by 2002:a17:907:6e86:b0:ac3:4373:e8bf with SMTP id
 a640c23a62f3a-ac7d16bc07emr1106444666b.10.1743977372498; Sun, 06 Apr 2025
 15:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250405221308.498047-1-sjg@chromium.org>
 <20250405221308.498047-2-sjg@chromium.org>
 <dc4dec57-6fba-4224-9f84-1cc63c58eacd@kwiboo.se>
 <CAFLszTim=Fq9rv0BfypZoje=i+HU_ZTdFK_GSQoZSsESWm=Jqg@mail.gmail.com>
 <a1026fc5-de0c-4a88-891e-1bdb5b98b705@kwiboo.se>
In-Reply-To: <a1026fc5-de0c-4a88-891e-1bdb5b98b705@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 10:09:20 +1200
X-Gm-Features: ATxdqUFBxKXrUpbOpsIqj3jTp1hZixUTNCjk_8dbKxt3Vvp-0diEGdA46_adzYA
Message-ID: <CAFLszTi_7vv-CBxat=naT6iWmPUPFvCNZhVxj+JvHr_GUqwn_Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] designware: Use the remove() method with related
 drivers
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 neil.armstrong@linaro.org, 
 =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>, 
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot-amlogic@groups.io
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

Hi Jonas,

On Mon, 7 Apr 2025 at 09:36, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-04-06 23:10, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Sun, 6 Apr 2025 at 21:02, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 2025-04-06 00:12, Simon Glass wrote:
> >>> Several drivers make use of the designware Ethernet driver but do not
> >>> implement the remove() method. Add this so that DMA is stopped when the
> >>> OS is booted to avoid memory corruption, etc.
> >>
> >> The designware Ethernet driver core should not need the remove() ops as
> >> the eth_ops.stop() ops already should stop DMA. And the eth-uclass
> >> pre_remove() ops already call the eth_ops.stop() ops.
> >>
> >> All these drivers seem to use designware_eth_ops and thus have correct
> >> stop() ops configured and should really not need the remove() ops.
> >>
> >
> > That's interesting. I wrote that code about 9 years ago so perhaps can
> > be forgiven for forgetting.
> >
> > Very few drivers set the DM_FLAG_ACTIVE_DMA flag, certainly not the
> > designware ones. So how would they be removed?
>
> Ahh, I see, remove() is only called for devices with ACTIVE_DMA or
> OS_PREPARE. So I guess that was probably the issue all along?

I suppose so, yes.

>
> There is some confusion that dm_remove_devices_active() does not remove
> device_active()=true devices and instead only remove ACTIVE_DMA and/or
> OS_PREPARE flagged devices.
>
> >
> >> Side note, this also misses the gmac rockchip driver that uses its own
> >> eth_ops instead of designware_eth_ops, however it also use same stop()
> >> ops as all these drivers.
> >
> > Hmm yes I saw that but then apparently forgot to include it.
> >
> > I can perhaps redo this patch to add the DMA flag.
>
> Maybe eth_post_probe() or similar should add the OS_PREPARE or
> ACTIVE_DMA flag for all eth-uclass, to ensure remove() and thus stop()
> gets called when dm_remove_devices_active() is called.

But not all network drivers use DMA. It should really be set by the driver.

>
> There is probably no need to add all these remove() ops, as they would
> still not have been called by dm_remove_devices_active().

Well, since we can rely on the eth uclass, that is correct, but I
still think it is better to add it, as an example to other drivers.

Regards,
Simon
