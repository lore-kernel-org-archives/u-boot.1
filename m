Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B46C2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C486988387;
	Mon, 24 Jun 2024 23:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="qeQmVsiy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEBD1882DC; Mon, 24 Jun 2024 23:20:29 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0FF188387
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a6fbe639a76so766568866b.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1719264027; x=1719868827; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VD2eoFUPRxuTcXicYkbSuHvadir0EqhUiDsAfDWOlIc=;
 b=qeQmVsiyex1dtG4DLkxfE8/69v/P2QXzn/19a0cjIp4jZ/6n30SHTPFDsk6r6OaoIY
 zjUKu1oIgFrT3cvWDWYtLACjRageuuc3OjgzYjPooD/LtJsDrDGuK0bFCVRJqZIwnQm/
 wVgD2lV13DXudu1+pFsKXThS5anwfKk78QrjJBz129ETTVdAgDwFHp4+WWq8gQ2DmtTk
 Bd/y7nLyoLKNnKBgJnc7oQ4v3HkF5uHwxFqmZOlmITd3cJ3WfMkADAnLgEjALFKxTbvw
 1ieBnNTDo0M92WCVgnKvuw4TRDxPg0XKGjVEy+khg6T0+kC+BlW90SEcTquyIEXoEICc
 rkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719264027; x=1719868827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VD2eoFUPRxuTcXicYkbSuHvadir0EqhUiDsAfDWOlIc=;
 b=KaEwEhPZknZeQGHzBB9vpamDcXyje1cY/s93l2YqdcjSpuP5ZsvucKIeCutKGOZ21M
 xVYOifqm0m92eLf5nbns1Lmk14umYPvUhLKiKKEFVwTHxF0JWd6QvR1meSjvnCRYELlA
 FpPgWJUY14xQHcd0ye9igHDKN1O1yhSpcqQSgBT7uZHUaxHRRj/I8s4+0QhFf8HbSVGH
 mxvjSrLpxJeRbdgthZS+cHPniKhJ1OYGury+Wao9WUTIzesjKlQZBuO0nmYNiYuRlItT
 2XvPRktKDodN3nR4PlV0HBw70l+lUkGkz+aa12sRZ/Y6Brp/BZ/7rRxNqe+HyXOUCURR
 Eouw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGHGhJAqckbXwM1r2POuK8JyC39SRxeg77SJoh35TioBrydlMJHa7Vdy3RZ1ut5Wg219qx7yBWo8hjZ2eDBMUXrLXVJQ==
X-Gm-Message-State: AOJu0YzWj6gh3ewc9OJgydjXU23DZvipVdWGVLkMfXcD6039popSyR02
 y8PDXqbrXttFplANbZgFa89WRGMbK9/GJIS+hXFoz+X3Xjf0xGziIMxjskEymuyeokYSEoabilr
 Cbk4OgerZx8yifZ6D5vef//01+MaKajVlXrRQWA==
X-Google-Smtp-Source: AGHT+IG8PvxepLBKAXg4PdoKsShBNJTMe+zKotwQ8mq0S2xdVZBL8xUJeC90p4U9MMzuKgzYIVHn9rcRmJiYdDUvYb0=
X-Received: by 2002:a17:906:99cd:b0:a72:6442:d53a with SMTP id
 a640c23a62f3a-a726442f729mr115306966b.9.1719264026830; Mon, 24 Jun 2024
 14:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240604163546.60225-1-sebastian.reichel@collabora.com>
In-Reply-To: <20240604163546.60225-1-sebastian.reichel@collabora.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 24 Jun 2024 14:20:14 -0700
Message-ID: <CAJ+vNU1+wJBDdvW9g1RgD8HszeA-sDUvB6CBj0qqY0VRiZVeeg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] FUSB302 USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Eugen Hristev <eugen.hristev@collabora.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Simon Glass <sjg@chromium.org>, Soeren Moch <smoch@web.de>,
 Fabio Estevam <festevam@gmail.com>
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

On Tue, Jun 4, 2024 at 9:35=E2=80=AFAM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On ROCK 5B power is usually supplied via it's USB-C port. This port has t=
he
> data lines connected to RK3588, VBUS connected to the input regulator and
> CC pins connected to FUSB302. FUSB302 is a USB-C controller, which can be
> accessed via I2C from RK3588. The USB-C controller is needed to figure ou=
t
> the USB-C cable orientation, but also to do USB PD communication. Thus it
> would be great to enable support for it in the operating system.
>
> But the USB-PD specification requires, that a device reacts to USB-PD mes=
sages
> send by the power-supply within around 5 seconds. If that does not happen=
 the
> power-supply assumes, that the device does not support USB-PD. If a devic=
e
> later starts sending USB-PD messages it is considered an error, which is =
solved
> by doing a hard reset. A USB-PD hard reset means, that all supply voltage=
s are
> removed for a short period of time. For boards, which are solely powered
> through their USB-C port, like the Radxa Rock 5B, this results in an mach=
ine
> reset. This is currently worked around by not describing the FUSB302 in t=
he
> kernel DT, so nothing will ever speak USB-PD on the Rock 5B. This means
>
> 1. the USB-C port cannot be used at all
> 2. the board will be running via fallback supply, which provides limited
>    power capabilities
>
> In order to avoid the hard reset, this adds FUSB302 support to U-Boot, so
> that we react to the power-supply's queries in time. The code, which is
> originally from the Linux kernel, consists of two parts:
>
> 1. the tcpm state machine, which implements the Type C port manager state
>    machine as described in the USB PD specification
> 2. the fusb302 driver, which knows about specific registers
>
> Especially the first part has been heavily modified compared to the
> kernel, which makes use of multiple delayed works and threads. For this
> I used a priorly ported version from Rockchip, removed their hacks and
> any states not necessary in U-Boot (e.g. audio accessory support).
>

Hi Sebastian,

It seems here that your goal was primarily to react to the USB-PD
messages to negotiate board power. It looks like your tpmc class
implementation has the ability to handle role determination among
everything else from the tpmc but it's not clear to me how a tpmc
would hook into a USB controller to provide role feedback.

The rk3588 you're using in this series has a DWC3 controller
configured with dr_mode of otg which means it will register the
dwc3-generic-peripheral driver. When dwc3_core_init_mode is called,
what exists to set dwc->dr_mode according to the mode the TPMC is
showing? In other words what is here to provide the means for your OTG
controller to act in both host mode and device mode?

Perhaps it is beyond the scope of your series but I'm looking for a
framework where a driver monitoring a GPIO can provide the role to UDC
drivers. For example, I'm talking about a USB-B connector with the ID
pin going to a generic GPIO or a GPIO connected to a bus-less type-C
CC controller like the TPS25821 which provides a SINK# pin to specify
if you have a host cable vs a device cable attached.

Best Regards,

Tim
