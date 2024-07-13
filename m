Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BD3C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B128888818;
	Sat, 13 Jul 2024 17:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iEWX3Aof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B159388817; Sat, 13 Jul 2024 17:13:52 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76189887F3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b2c6291038so25248256d6.0
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883629; x=1721488429; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7oJu1Likw+IyeQKNfI5hGRurhFllv6HqdVaDHHzcdrE=;
 b=iEWX3AofwmKU0miGMBgdgsXjuSEE1k+XkCk5TaRGS/zl3WyMa/Ohu7BlZFAvEpK3Ag
 wiwXZTgzeK4g+vBjQGZrfZ0v+zxMkPm1+QPz/78LgijQbRU54F323eNIOO6x3bQeOanL
 HoSriItqntBv5zCmI9arFdQ5fC5RLsdw2Drcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883629; x=1721488429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7oJu1Likw+IyeQKNfI5hGRurhFllv6HqdVaDHHzcdrE=;
 b=BCXQkVLyqZ+bdiVBSVNQsCPfctKdcAmZC0zyl6MRr1v0dXpiUkaqWP6QvyI/Fg97+u
 R8+Cbi12D7WBRoRa/9ZjyrRe6Bksg2NSSvUwcsJawTqfBsgvJdici/AVI9ZNYsO1Lah9
 DCBXARHx42wLhl+QgSwUJeF1tBNOPdFAX2O/r2AVYlmVXPv3ID/K34MyLAm54Hibr6YG
 aQq0x2zvijxc69CO3UDKCvz4fkdYMv8X80YR0o4ppL2swWM4XwKuplcQ9hQzGeCQc4ku
 uejNiE0JT6tdFEVMw8rFZRHQFpxCDBCkXvYg52t/y5gQH1zGHAz5u3YSMHgNG+uGytFh
 6x8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQS11p59Uv4mg18I4LEHAYCY537el/DHNc5e8c4YAv+6a6yBo0cC3/yqGtwADsW0/JZT909ROpych1ZZ/veZw0t9HmTQ==
X-Gm-Message-State: AOJu0YwUxCJF8q5lRdoVmGcisoHwEdaWnPo3hnxxneIn8mewO5njwP0T
 893C93kekDJA999GxsWUnDL1Lpv/s2BQMzdRh2W7oQ5B32rZ0tLKpbqtocKwP8LKub2lfGD1bKS
 1IMjrPNN4Hp+3O4ms6lJI+jmeeYmxqeKAqlxM
X-Google-Smtp-Source: AGHT+IHRvmiGUdiK770cnMgWVkAF88I1jJSfnC3p7EhkN8aLwF/cUIACXav69kgEd044Af8ahekD4xIIEDUYcgod8KY=
X-Received: by 2002:a05:6214:1415:b0:6b5:1cea:649d with SMTP id
 6a1803df08f44-6b754b9f737mr77612186d6.11.1720883629279; Sat, 13 Jul 2024
 08:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240604163546.60225-1-sebastian.reichel@collabora.com>
 <20240604163546.60225-2-sebastian.reichel@collabora.com>
In-Reply-To: <20240604163546.60225-2-sebastian.reichel@collabora.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:37 +0100
Message-ID: <CAFLszTiZsNVpRrzd0PfA_d369TN-HFpKe_5pZq1eXbLc34dZ3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] usb: tcpm: add core framework
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Eugen Hristev <eugen.hristev@collabora.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Soeren Moch <smoch@web.de>, Wang Jie <dave.wang@rock-chips.com>
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

00000000000000000000000000000000000000000000000000000000000000000000Hi
Sebastian,

On Tue, 4 Jun 2024 at 17:35, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> This adds TCPM framework in preparation for fusb302 support, which can
> handle USB power delivery messages. This is needed to solve issues with
> devices, that are running from a USB-C port supporting USB-PD, but not
> having a battery.
>
> Such a device currently boots to the kernel without interacting with
> the power-supply at all. If there are no USB-PD message replies within
> 5 seconds, the power-supply assumes the peripheral is not capable of
> USB-PD. It usually takes more than 5 seconds for the system to reach
> the kernel and probe the I2C based fusb302 chip driver. Thus the
> system always runs into this state. The power-supply's solution to
> fix this error state is a hard reset, which involves removing the
> power from VBUS. Boards without a battery (or huge capacitors) will
> reset at this point resulting in a boot loop.
>
> This imports the TCPM framework from the kernel. The porting has
> originally been done by Rockchip using hardware timers and the Linux
> kernel's TCPM code from some years ago.
>
> I had a look at upgrading to the latest TCPM kernel code, but that
> beast became a lot more complex due to adding more USB-C features.
> I believe these features are not needed in U-Boot and with multiple
> kthreads and hrtimers being involved it is non-trivial to port them.
> Instead I worked on stripping down features from the Rockchip port
> to an even more basic level. Also the TCPM code has been reworked
> to avoid complete use of any timers (Rockchip used SoC specific
> hardware timers + IRQ to implement delayed work mechanism). Instead
> the delayed state changes are handled directly from the poll loop.
>
> Note, that (in contrast to the original Rockchip port) the state
> machine has the same hard reset quirk, that the kernel has - i.e.
> it avoids disabling the CC pin resistors for devices that are not
> self-powered. Without that quirk, the Radxa Rock 5B will not just
> end up doing a machine reset when a hard reset is triggered, but will
> not even recover, because the CPU will loose power and the FUSB302
> will keep this state because of leak voltage arriving through the RX
> serial pin (assuming a serial adapter is connected).
>
> This also includes a 'tcpm' command, which can be used to get
> information about the current state and the negotiated voltage
> and current.
>
> Co-developed-by: Wang Jie <dave.wang@rock-chips.com>
> Signed-off-by: Wang Jie <dave.wang@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  Makefile                         |    1 +
>  cmd/Kconfig                      |    7 +
>  cmd/Makefile                     |    1 +
>  cmd/tcpm.c                       |  142 ++
>  drivers/usb/Kconfig              |    2 +
>  drivers/usb/tcpm/Kconfig         |    8 +
>  drivers/usb/tcpm/Makefile        |    3 +
>  drivers/usb/tcpm/tcpm-internal.h |  174 +++
>  drivers/usb/tcpm/tcpm-uclass.c   |  102 ++
>  drivers/usb/tcpm/tcpm.c          | 2251 ++++++++++++++++++++++++++++++
>  include/dm/uclass-id.h           |    1 +
>  include/usb/pd.h                 |  516 +++++++
>  include/usb/tcpm.h               |   99 ++
>  13 files changed, 3307 insertions(+)
>  create mode 100644 cmd/tcpm.c
>  create mode 100644 drivers/usb/tcpm/Kconfig
>  create mode 100644 drivers/usb/tcpm/Makefile
>  create mode 100644 drivers/usb/tcpm/tcpm-internal.h
>  create mode 100644 drivers/usb/tcpm/tcpm-uclass.c
>  create mode 100644 drivers/usb/tcpm/tcpm.c
>  create mode 100644 include/usb/pd.h
>  create mode 100644 include/usb/tcpm.h

Can you please add docs for the command (and perhaps the whole feature)?

How is this tested? It should be possible to write a simple i2c
emulator for the chip as a way to cover this in CI (search for
UCLASS_I2C_EMUL to see examples).

Regards,
Simon
