Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740EEC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 19:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D84B3883E7;
	Mon, 24 Jun 2024 21:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cp5aRXZX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 366AE88400; Mon, 24 Jun 2024 21:54:09 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0119F883BA
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 21:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so3288201a12.2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 12:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719258845; x=1719863645; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=miW2JJyQYt3HigqzMFZKTwc4r74ih2z8MXYb4ofXxBU=;
 b=cp5aRXZXYP0uOyMDt4RZrQgL2Va6+E961rSn8KHcivDYhfKXPMTwUBtyHJYxO/5BgC
 K/C7M475D5iXwK8bqfPJ1oAHVn8EWzaF7hMcXRowO6rBORUvcnhFYz4n2jIzDsf5FAUV
 yI9M0j0JiX9wVTbKQT2ZYycPDtkqV3YEJZ7Tb0bIvktpA0RtMoO7RCO2dqnZZJPdUgKT
 OFLETByy6LVI21tna2HAvMBcHxtoHtQUVPWtq6UnG9FgY3hCR4xKkfgAIukU6GaspdrC
 7YLcZ8FpjWw4pY1q5nvWuOihYAg0X7blSVuROuKAkECTutAhcpr+2vTBo29tOmlYVJX7
 QpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719258845; x=1719863645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=miW2JJyQYt3HigqzMFZKTwc4r74ih2z8MXYb4ofXxBU=;
 b=USUJ94/76IadAkrmggyRiBn0Vr3f6NqQxIS5s+Kh7cFzJMUKbLeDM6Cg0qKvqxV5Tg
 cw46+82WCnbvdOr4NjSJzCRKyO1phojjOVVmJN9fQaLX37U3+//UabYGcCoJ+YS4alZs
 LdlJCJSZPhLIaToWw2Bz8QJMdCYbRSyj2xI3EljXGXsuBQoB4ZPGo7PjKYuc5zJ3sdMr
 /89zN9YdtqXrsSWUZoWKlm3ekCrzcyFsRlc5bGBq+lo1l7csSLME+xYVPQJB3yQ1qWbx
 1Uc4kBwkWFGZhqdluM+Y8Xg4foE4qXNlIzN9SKF3kSEpHsR5ljZoUyovvXSqpqBGoJhW
 /HyA==
X-Gm-Message-State: AOJu0YwylAIIWqJRAunZvzwfoVPzxqT+QyWw7SG3B3G3eg4IFq6Wm/5k
 y45++N+ppAmnjaSYgCOu6sy31mK4ABLe1SjEMRoOhS33RI/nF9XmP40f1+xIQuojNskY+8VGYe0
 CwpAXl0AC6NaBs2WVQF7lz1ELhLuZqA==
X-Google-Smtp-Source: AGHT+IFwAlzVrVtV1Mf3GTSCUxEkDevgn0Ce027kPDpzSJ8FonKycQr/cncE1Z17sRUD4CroAJymBHAKnJq4rIs0A8Y=
X-Received: by 2002:a17:90a:cf86:b0:2c2:ee5c:35a4 with SMTP id
 98e67ed59e1d1-2c861131399mr4473251a91.0.1719258845273; Mon, 24 Jun 2024
 12:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU34T3gpSn0upzfK8ra5pUyVDE-CQZGaNo73btHA4pdE-A@mail.gmail.com>
In-Reply-To: <CAJ+vNU34T3gpSn0upzfK8ra5pUyVDE-CQZGaNo73btHA4pdE-A@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 24 Jun 2024 14:53:52 -0500
Message-ID: <CAHCN7xLoLecTjdThuxHH9K7KP6NVpaajyRov=TO8em2ADPmyyQ@mail.gmail.com>
Subject: Re: USB OTG mode for DWC3 (ie imx8mp) host controller with usb_ether
 USB Ethernet gadget?
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>, 
 Fabio Estevam <festevam@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 dl-uboot-imx <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>,
 Teresa Remmet <t.remmet@phytec.de>
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

On Mon, Jun 24, 2024 at 2:39=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Greetings,
>
> What is missing in U-Boot for the DWC3 host controller to support OTG
> mode for usb_ether (USB Ethernet gadget)? I'm unable to get the usb
> ethernet gadget to work for the imx8mp as it errors out with 'No UDC
> available in the system'.
>
> The ums/acm/sdp gadget's all call udc_device_get_by_index to get the
> UDC controller which for DWC3 is provided by
> drivers/usb/dwc3/dwc3-generic.c and these gadgets work, however
> usb_ether is different in that it calls usb_gadget_register_driver to
> bind the gadget driver to the UDC and for DWC3 this calls
> usb_gadget_probe_driver which iterates over udc_list which does not
> contain DWC3 hosts that are in peripheral/otg mode.
>
> Before I spend a lot more time on this I wanted to see if anyone else
> understands why boards with DWC3 host controllers like imx8mp don't
> seem to register controllers in udc_list that are not in host mode.
>
> I'm also unclear how to get a DWC3 controller to switch roles
> dynamically at runtime based on a gpio state for example. That support
> appears to be missing and I'm not sure what the right way would be to
> go about adding it. I notice that some imx8mp boards like the
> imx8mp-evk have a u-boot.dtsi that just forces its OTG controller to
> peripheral mode and I force the imx8mp-venice OTG controllers into
> host mode.

I think there is some interaction between the DWC controller and a
type-c controller, but I think the mainline code lacks a proper type-c
controller and/or framework.  Not everyone might use a USB Type-C
chip, but it seems like if the USB is set to dual-role, it could
default to peripheral mode until someone starts the USB host stuff
with 'usb start'

I am just not sure how to handle situations where a USB cable may be
connected to a host computer and someone issues a start command and
brings up VBUS which may cause a voltage contention.
I think some people tried to push a Type-C driver if memory serves,
but I think it was rejected.  I don't recall the details and my memory
is terrible.  :-)

adam
>
> Best Regards,
>
> Tim
