Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CDCC3DA49
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 02:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEAE988768;
	Wed, 17 Jul 2024 04:00:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="YIjSWkY9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7350C887D3; Wed, 17 Jul 2024 04:00:22 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D607B8852E
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 04:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a77d85f7fa3so57731366b.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 19:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1721181619; x=1721786419; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOpZqGxZpyPkNmoZ1lacVbNsXsC9ecpSUsRmfmdMoVs=;
 b=YIjSWkY9cCFNiInLyFGgOg1Ss40cIbkq/5bSpE6e9VI9IL3QI0I391qJMvzIQEmDm4
 bpNPwdV/7nBhpjOg2LcFKt+cyfXU0i6QJSRqvnu43SZqOlwnJghaWPcmT1JJR1UBC56f
 2omgXXf3PpT7ljkZfQAU2xwpnX5c60DJpVFbZoDqTKghZO9IiBGypyYatctKKSnzZEzc
 03oWA8TkXFcyf/2uGLbqQhVR3GjBC9nkvOHPA/Zs1H3vzXUdfGmQ1nzkdXB+prDMEVFe
 1OhBSC9bp1mpTuMCCuFijkkiascr6Xe6AV6O/UMDrnHE3yDjndU03RAvITGm0lt32HHQ
 w7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721181619; x=1721786419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zOpZqGxZpyPkNmoZ1lacVbNsXsC9ecpSUsRmfmdMoVs=;
 b=RwyN/1vpgYgm31yui9TDEb91JOlfsG2yssnii9qluUYXeb8GE/I1LubmD2uv0PrKN5
 F6j3Qfw3v0Gtme92FJ+KajDqA94/RUOKV+wMYKd3iyxhNZEh2KrlYv6eMpzSsWmWJlJ8
 hHSkOyRicq8/RnmVHX6y2+UsycfIPSSv2jhRE5EeiEBzgTP4t1ascHrfT/1McHlig9wO
 uufyv2UyLcPOmZABjE43UwNTSGmnfFzCcXPJI15OIb4M0KsBCCURaRzzsYL1ih3OP3YG
 sJAmbbBkaDhJLh3LU42hmLv9mml5Zyli+oXS0RazRROUkgeIWU+L+cxdluMXrDL00wNY
 1fWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwRAXvx8v5L6guj6h7HPY3BNmfAi3pdcUpqjgt+eTvKRdFjhm3DMuPVs0+uzyzZ6udQlxMNFiw4KQ8W55RyzKsKUdR8A==
X-Gm-Message-State: AOJu0YxoRWlyUzZmKO9mID7KPRXlmkFAmxFw2pwo9A4fMC5jDzzLIl6N
 cQHSaZGOUYdzzIJ4qNamINalrd1eX9ZRGLJ65zDj2hVeWNT539oZRFpwfO9ulRz8YoaE8+65Riz
 dxuhtOlQXRQLv7ktRsIU9fZ/P52gLKmibe9xXgg==
X-Google-Smtp-Source: AGHT+IHdumBjjFfU3ouorkUmHSFKndsrDXtP/K4+vL0wFpKrz8P1wpif9ms+jUZjgz7kEORJGh6Kup4U3tBwHD6rVp8=
X-Received: by 2002:a17:906:2bd4:b0:a72:7ede:4d12 with SMTP id
 a640c23a62f3a-a7a00455a31mr31682266b.5.1721181618810; Tue, 16 Jul 2024
 19:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240604163546.60225-1-sebastian.reichel@collabora.com>
 <20240604163546.60225-2-sebastian.reichel@collabora.com>
 <CAJ+vNU0T_yd9mVrj7kDaub_4KtD+7acLDi+k9YpzY5qQMuMvSg@mail.gmail.com>
In-Reply-To: <CAJ+vNU0T_yd9mVrj7kDaub_4KtD+7acLDi+k9YpzY5qQMuMvSg@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 16 Jul 2024 19:00:06 -0700
Message-ID: <CAJ+vNU2dt95YLO7-77Va=8eLD1o5xWtE5DyAsVZnXMrKvmzayQ@mail.gmail.com>
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

On Fri, Jul 12, 2024 at 5:23=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> On Tue, Jun 4, 2024 at 9:36=E2=80=AFAM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> >
> > This adds TCPM framework in preparation for fusb302 support, which can
> > handle USB power delivery messages. This is needed to solve issues with
> > devices, that are running from a USB-C port supporting USB-PD, but not
> > having a battery.
> >
> > Such a device currently boots to the kernel without interacting with
> > the power-supply at all. If there are no USB-PD message replies within
> > 5 seconds, the power-supply assumes the peripheral is not capable of
> > USB-PD. It usually takes more than 5 seconds for the system to reach
> > the kernel and probe the I2C based fusb302 chip driver. Thus the
> > system always runs into this state. The power-supply's solution to
> > fix this error state is a hard reset, which involves removing the
> > power from VBUS. Boards without a battery (or huge capacitors) will
> > reset at this point resulting in a boot loop.
> >
> > This imports the TCPM framework from the kernel. The porting has
> > originally been done by Rockchip using hardware timers and the Linux
> > kernel's TCPM code from some years ago.
> >
> > I had a look at upgrading to the latest TCPM kernel code, but that
> > beast became a lot more complex due to adding more USB-C features.
> > I believe these features are not needed in U-Boot and with multiple
> > kthreads and hrtimers being involved it is non-trivial to port them.
> > Instead I worked on stripping down features from the Rockchip port
> > to an even more basic level. Also the TCPM code has been reworked
> > to avoid complete use of any timers (Rockchip used SoC specific
> > hardware timers + IRQ to implement delayed work mechanism). Instead
> > the delayed state changes are handled directly from the poll loop.
> >
> > Note, that (in contrast to the original Rockchip port) the state
> > machine has the same hard reset quirk, that the kernel has - i.e.
> > it avoids disabling the CC pin resistors for devices that are not
> > self-powered. Without that quirk, the Radxa Rock 5B will not just
> > end up doing a machine reset when a hard reset is triggered, but will
> > not even recover, because the CPU will loose power and the FUSB302
> > will keep this state because of leak voltage arriving through the RX
> > serial pin (assuming a serial adapter is connected).
> >
> > This also includes a 'tcpm' command, which can be used to get
> > information about the current state and the negotiated voltage
> > and current.
> >
> > Co-developed-by: Wang Jie <dave.wang@rock-chips.com>
> > Signed-off-by: Wang Jie <dave.wang@rock-chips.com>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  Makefile                         |    1 +
> >  cmd/Kconfig                      |    7 +
> >  cmd/Makefile                     |    1 +
> >  cmd/tcpm.c                       |  142 ++
> >  drivers/usb/Kconfig              |    2 +
> >  drivers/usb/tcpm/Kconfig         |    8 +
> >  drivers/usb/tcpm/Makefile        |    3 +
> >  drivers/usb/tcpm/tcpm-internal.h |  174 +++
> >  drivers/usb/tcpm/tcpm-uclass.c   |  102 ++
> >  drivers/usb/tcpm/tcpm.c          | 2251 ++++++++++++++++++++++++++++++
> >  include/dm/uclass-id.h           |    1 +
> >  include/usb/pd.h                 |  516 +++++++
> >  include/usb/tcpm.h               |   99 ++
> >  13 files changed, 3307 insertions(+)
> >  create mode 100644 cmd/tcpm.c
> >  create mode 100644 drivers/usb/tcpm/Kconfig
> >  create mode 100644 drivers/usb/tcpm/Makefile
> >  create mode 100644 drivers/usb/tcpm/tcpm-internal.h
> >  create mode 100644 drivers/usb/tcpm/tcpm-uclass.c
> >  create mode 100644 drivers/usb/tcpm/tcpm.c
> >  create mode 100644 include/usb/pd.h
> >  create mode 100644 include/usb/tcpm.h
> >
>
> Hi Sebastian,
>
> I have a board that has a STMicroelectronics STUSB4500 USB PD sink
> controller [1] on it that I would be interested in writing a driver
> for using this TCPM class. This device is a USB PD sink controller
> which has a nice 'auto-run' feature that has 3 updatable NVM backed
> PDO's that it negotiates on its own with the the PD source so that you
> get basic functionality without needing a driver.
>
> I am struggling a bit to get the stusb4500 working in a driver that
> fits into your framework and I think its the fact that the STUSB4500
> has no buffering capability so the processing of messages during the
> PD negotiation is extremely timing critical and I'm often missing the
> SRC_CAP message. To help me understand the correct operation of the
> tcpm state machine can you by chance enable DEBUG in fusb302.c and
> tcpm.c and share the output with me?
>
> I'm trying to understand the required state machine transitions. It
> looks to me like for a SINK the state machine should go like this:
> INVALID_STATE -> SNK_UNATTACHED
> SNK_UNATTACHED -> SNK_ATTACH_WAIT
> ^^^ during tcpm_init
> SNK_ATTACH_WAIT -> SNK_DEBOUNCED
> SNK_DEBOUNCED -> SNK_ATTACHED
> SNK_ATTACHED -> SNK_STARTUP
> SNK_STARTUP -> SNK_DISCOVERY
> SNK_DISCOVERY -> SNK_WAIT_CAPABILITIES
>
> At this point drvops->set_pd_rx(on) is called to allow your driver to
> accept PD messages but I don't understand the following logic:
>         case SNK_WAIT_CAPABILITIES:
>                 ret =3D drvops->set_pd_rx(dev, true);
>                 if (ret < 0) {
>                         tcpm_set_state(dev, SNK_READY, 0);
>                         break;
>                 }
>                 /*
>                  * If VBUS has never been low, and we time out waiting
>                  * for source cap, try a soft reset first, in case we
>                  * were already in a stable contract before this boot.
>                  * Do this only once.
>                  */
>                 if (port->vbus_never_low) {
>                         port->vbus_never_low =3D false;
>                         tcpm_set_state(dev, SOFT_RESET_SEND,
>                                        PD_T_SINK_WAIT_CAP);
>                 } else {
>                         tcpm_set_state(dev, hard_reset_state(port),
>                                        PD_T_SINK_WAIT_CAP);
>                 }
>
> Why on error would you go straight to SNK_READY? The comment indicates
> a return value of >=3D0 is a timeout. Why on success would you either go
> straight to a hard/soft reset? What does fusb302.c return from
> set_pd_rx and do after that call?

Hi Sebastian,

I've managed to make it further through the TCPM state machine with my
stusb4500 driver. I figured out that the intended operation of
SNK_WAIT_CAPABILITIES is to send a soft reset which gets the PD SRC to
send SRC_CAP which transitions to SNK_NEGOTIATE_CAPABILITIES then the
PD SRC sends an ACCEPT which transitions to SNK_TRANSITION_SINK then a
PS_READY which transitions to SNK_READY.

I am seeing that when a PD_DATA_REQUEST to negotiate a contract my
board loses power which does not happen if the STUSB4500 is allowed to
run in its auto-run mode. Do you know if there is some sort of power
glitch that is expected when a PD_DATA_REQUEST is sent from the SNK to
the SRC that must be managed with hold-up caps or something?

Best Regards,

Tim
