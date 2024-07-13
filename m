Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74635C2BD09
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 00:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9845C88789;
	Sat, 13 Jul 2024 02:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="GT+G8clW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C7C788765; Sat, 13 Jul 2024 02:23:26 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C6ED88789
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 02:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a77c7d3e8bcso344027166b.1
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 17:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1720830202; x=1721435002; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rf86SDKvGLAWtinCCCNRtmD8Hbn3dF48w12MiQDncxc=;
 b=GT+G8clW3yFDMWe+PVAbiwdmIxB9iX7wbasKKdT0A2WMuwuOBNdkuI4eTk6w3rt+Kj
 wgP6oRmbvxGfHroicPanApPwJEGSgadikoDtj7z79FjNXt9D5l9WT8dukT0NLGIPmaBU
 6UhXheEQV/67T/6CQHdvp/151GXVknKZXwhp5hwUwTKEWaSViCz6/F88A1Wv9iiIsM2i
 S70T7DbH8og1S27Etcwp8RkNc12m9V4t9stqVXN7igc2HGDheyUgwAIhWKI2vARmDgK6
 Y0rT5dwt19LQ42qh3w1bET04AjgjvFW+KsDdlbw7+l2cmQcGlnGnCzDs4wMkwzIBLgKT
 wUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720830202; x=1721435002;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rf86SDKvGLAWtinCCCNRtmD8Hbn3dF48w12MiQDncxc=;
 b=F8Oye1POsvR2Lkpt7Fqk9f+gakwSuEPbDEB1/q7AHb0I30SO0a2HeSS3B8rdoTXlPs
 nPJjm+5Ox6b/43JVdXr45E4AEVe0VfRJUWXwO9OCjBz/0k3+uOGoYDyH0NpAO2itxubd
 kJt9fyJrTmPY1igKx1Yy/zhGEbExI2n3h55VtlOOTHB2R8CLGzcEYvg0TFfLv4UXeo1G
 4ta6zvGEQ1F6CF4wSgylRsyzQ6mBKqgNM3ZvZiLs74i4sC6MiaRjVC8QzyRMa4EEXoU1
 twfUcRRBZ2EOjqaOFG/R9JbYyyRxEZNvEmI6mJN5bzwkpPSTKx27W2CTqAAl/JGChwBo
 6Viw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtxaEqFXk0xknHZfy3lML5GhVn3hWtxSGJiXEKpiRPr9nhoDEuL/Uq1NxgxiGA/ZPb4B1kYy3frR4ugC2bY4KbHmqz+w==
X-Gm-Message-State: AOJu0YwJZUW63YJaSsVkkKcDKcQV/fEqzLOQG6NKBdlL80qGuYn0uq15
 5IG+jK2nKxisp5CAcjGv/g7E5FLimR/uiuI/V5r6agAtWguHPa+E+Mo9r0aQUmIbpNOTzrW61Yc
 TKl7qrnaLiR8cqr+oZEjLhpZd+4Asc5VX/CacEA==
X-Google-Smtp-Source: AGHT+IFj8O8pInZ5+vvqbR4/5XwoJf3JYrd6GcSjjLCTfQ2frMhbFqe9Gsllh4FZoLXQOM1o0BY0P778Mmai3YwaF8Y=
X-Received: by 2002:a17:906:2758:b0:a77:cc90:7733 with SMTP id
 a640c23a62f3a-a780b6b3ae7mr729206566b.31.1720830201795; Fri, 12 Jul 2024
 17:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240604163546.60225-1-sebastian.reichel@collabora.com>
 <20240604163546.60225-2-sebastian.reichel@collabora.com>
In-Reply-To: <20240604163546.60225-2-sebastian.reichel@collabora.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 12 Jul 2024 17:23:10 -0700
Message-ID: <CAJ+vNU0T_yd9mVrj7kDaub_4KtD+7acLDi+k9YpzY5qQMuMvSg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] usb: tcpm: add core framework
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Eugen Hristev <eugen.hristev@collabora.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Simon Glass <sjg@chromium.org>, Soeren Moch <smoch@web.de>,
 Wang Jie <dave.wang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jun 4, 2024 at 9:36=E2=80=AFAM Sebastian Reichel
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
>

Hi Sebastian,

I have a board that has a STMicroelectronics STUSB4500 USB PD sink
controller [1] on it that I would be interested in writing a driver
for using this TCPM class. This device is a USB PD sink controller
which has a nice 'auto-run' feature that has 3 updatable NVM backed
PDO's that it negotiates on its own with the the PD source so that you
get basic functionality without needing a driver.

I am struggling a bit to get the stusb4500 working in a driver that
fits into your framework and I think its the fact that the STUSB4500
has no buffering capability so the processing of messages during the
PD negotiation is extremely timing critical and I'm often missing the
SRC_CAP message. To help me understand the correct operation of the
tcpm state machine can you by chance enable DEBUG in fusb302.c and
tcpm.c and share the output with me?

I'm trying to understand the required state machine transitions. It
looks to me like for a SINK the state machine should go like this:
INVALID_STATE -> SNK_UNATTACHED
SNK_UNATTACHED -> SNK_ATTACH_WAIT
^^^ during tcpm_init
SNK_ATTACH_WAIT -> SNK_DEBOUNCED
SNK_DEBOUNCED -> SNK_ATTACHED
SNK_ATTACHED -> SNK_STARTUP
SNK_STARTUP -> SNK_DISCOVERY
SNK_DISCOVERY -> SNK_WAIT_CAPABILITIES

At this point drvops->set_pd_rx(on) is called to allow your driver to
accept PD messages but I don't understand the following logic:
        case SNK_WAIT_CAPABILITIES:
                ret =3D drvops->set_pd_rx(dev, true);
                if (ret < 0) {
                        tcpm_set_state(dev, SNK_READY, 0);
                        break;
                }
                /*
                 * If VBUS has never been low, and we time out waiting
                 * for source cap, try a soft reset first, in case we
                 * were already in a stable contract before this boot.
                 * Do this only once.
                 */
                if (port->vbus_never_low) {
                        port->vbus_never_low =3D false;
                        tcpm_set_state(dev, SOFT_RESET_SEND,
                                       PD_T_SINK_WAIT_CAP);
                } else {
                        tcpm_set_state(dev, hard_reset_state(port),
                                       PD_T_SINK_WAIT_CAP);
                }

Why on error would you go straight to SNK_READY? The comment indicates
a return value of >=3D0 is a timeout. Why on success would you either go
straight to a hard/soft reset? What does fusb302.c return from
set_pd_rx and do after that call?

Also I would like to add the ability to show the PDO descriptions and
the current negotiated PD contract in cmd/tcpm.c do_print_info so I
will work on that. I would also like to add the capability to modify
for the STUSB4500 the 3 stored PDO's and request a new contract (for
example to up the wattage requested by and delivered to a board before
enabling a higher power peripheral) and to store the modified PDO's in
NVM. Do you think it would make sense for me to add a command handler
operation to the tcpm class so non-common device-specific commands
could be added or do you think I should just add my own
U_BOOT_CMD(stusb4500, ...) for this in my driver?

Best Regards,

Tim
[1] https://www.st.com/resource/en/datasheet/stusb4500.pdf
https://www.st.com/resource/en/user_manual/um2650-the-stusb4500-software-pr=
ograming-guide-stmicroelectronics.pdf
