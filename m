Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707F3C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83C0081A04;
	Tue,  4 Mar 2025 14:14:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AqNzwRsi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BD0481A0F; Tue,  4 Mar 2025 14:14:11 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB75381A04
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-abf48293ad0so548120766b.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741094048; x=1741698848; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UqahU4Vx1j5yBFXnRRZtkrIY9HG5O6PYwtXv3Jb1wtg=;
 b=AqNzwRsi+W2McC7zUtdOoq+cH55G6xTXIUxoweWbuXlq2bIwPmQJNVlVaV1n3t93dC
 MkvvnTYT+FBAafzJVQMihSXcs/PmQblXF4kxcotk7KhZvuwUMNNEcdoXwNfyNf9L9c4Y
 9V88FVNehjEmG90x9PTnIHVhMF6JbKM5clIAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741094048; x=1741698848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UqahU4Vx1j5yBFXnRRZtkrIY9HG5O6PYwtXv3Jb1wtg=;
 b=IfZ6i5AupQv2PMif8Nca07BzygC0cZt0oPe83c6jYiXOQgylxyWEEXMgUQ2cB9w1cc
 MM+dxRE+IO0GkLy6FC9ugEP2eBMRQ8BsafCd9pNT6fipAcpdLsR8czqUX1V92CLp/0ru
 PuBYL6++hRrPOB290ecEgOr/MbA+qzqXLIx4anlj7ePwPnEShT0+sGyCYH6DntHYe5Tj
 5iNp8pPYdBbxB/ya5tqMwKoXemO7JTZ3aDSZgxr7BENhaZfPucANa237IE1bgsLlauol
 oQdAKzvt+fTW8siJlci6NU0BREmwGyO9KtmJ5/Hc1hdhH+zQ1OgBRmbrutrAr1RibaNZ
 A3Qg==
X-Gm-Message-State: AOJu0YyZhfOpvJKRhVdzPdaFjnYrrum2nsT5juycGez2U/3aXCwoWNgP
 2/0phVwgXEY8PF/aD9RV4R3lvUQCWNCG9nqszCCq2/bdWCHR9ZZKOJ5yXHjon5Buj1C2YevZxew
 Gp6f25heWJ4L/+pI3NR5wn6DoaLz1v65q//Eq
X-Gm-Gg: ASbGncvAPYcTcYmPsVVoZz86ZFRqzIXsMBuMEeh1qOQ/8ZMYEFSvSPym2TKyCRMM8SE
 vrKfp7h40Canrz14ZxpQYqjSDoLJOBRqSirPYXulZ69rt+m/Qw8qyr2RPr/6wL/pqmggcsv/DGu
 IZBcLf+Tg9qD83nwxrRbNCA60VSHk=
X-Google-Smtp-Source: AGHT+IEaLfpxf9q3P4mLoX939+cOa5e6koUpZdVQuj4PUC9YrUa2Vzt/DfkO4ydY1KexzKWuh56LiJUl23bugcNl1SE=
X-Received: by 2002:a17:906:5793:b0:abf:4154:ccf7 with SMTP id
 a640c23a62f3a-abf4154dea7mr1364281566b.20.1741094048326; Tue, 04 Mar 2025
 05:14:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <03a5c263b0449b397ca280d5d22bebf1d5496687.1740499185.git.jerome.forissier@linaro.org>
 <CAFLszTg2TXUzZS=ucjeSZaMWcXdhcChH-ABH+rkn8PYOQTVVUw@mail.gmail.com>
 <570846c3-3401-497c-a949-4d4519cf6e5d@linaro.org>
In-Reply-To: <570846c3-3401-497c-a949-4d4519cf6e5d@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Mar 2025 06:13:53 -0700
X-Gm-Features: AQ5f1JpmN6ATcEIMV3Rm3o6-xjA6jQ4SSgDrlwTgOMX4VTfhW1lI1BeZYO-0tGY
Message-ID: <CAFLszTj5oGj=D-eLCophXfF916iOoe0tkv6aN91Z3oaieNwNTg@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] dm: usb: initialize and scan multiple buses
 simultaneously with uthread
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Julius Lehmann <lehmanju@devpi.de>,
 Guillaume La Roque <glaroque@baylibre.com>
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

Hi Jerome,

On Thu, 27 Feb 2025 at 10:30, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 2/27/25 17:25, Simon Glass wrote:
> > Hi Jerome,
> >
> > On Tue, 25 Feb 2025 at 09:35, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >> Use the uthread framework to initialize and scan USB buses in parallel
> >> for better performance. The console output is slightly modified with a
> >> final per-bus report of the number of devices found, common to UTHREAD
> >> and !UTHREAD. The USB tests are updated accordingly.
> >>
> >> Tested on two platforms:
> >>
> >> 1. arm64 QEMU on a somewhat contrived example (4 USB buses, each with
> >> one audio device, one keyboard, one mouse and one tablet)
> >>
> >>  $ make qemu_arm64_defconfig
> >>  $ make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
> >>  $ qemu-system-aarch64 -M virt -nographic -cpu max -bios u-boot.bin \
> >>      $(for i in {1..4}; do echo -device qemu-xhci,id=xhci$i \
> >>          -device\ usb-{audio,kbd,mouse,tablet},bus=xhci$i.0; \
> >>      done)
> >>
> >> 2. i.MX93 EVK (imx93_11x11_evk_defconfig) with two USB hubs, each with
> >> one webcam and one ethernet adapter, resulting in the following device
> >> tree:
> >>
> >>  USB device tree:
> >>    1  Hub (480 Mb/s, 0mA)
> >>    |  u-boot EHCI Host Controller
> >>    |
> >>    +-2  Hub (480 Mb/s, 100mA)
> >>      |  GenesysLogic USB2.1 Hub
> >>      |
> >>      +-3  Vendor specific (480 Mb/s, 350mA)
> >>      |    Realtek USB 10/100/1000 LAN 001000001
> >>      |
> >>      +-4   (480 Mb/s, 500mA)
> >>            HD Pro Webcam C920 8F7CD51F
> >>
> >>    1  Hub (480 Mb/s, 0mA)
> >>    |  u-boot EHCI Host Controller
> >>    |
> >>    +-2  Hub (480 Mb/s, 100mA)
> >>      |   USB 2.0 Hub
> >>      |
> >>      +-3  Vendor specific (480 Mb/s, 200mA)
> >>      |    Realtek USB 10/100/1000 LAN 000001
> >>      |
> >>      +-4   (480 Mb/s, 500mA)
> >>           Generic OnLan-CS30 201801010008
> >>
> >> Note that i.MX was tested on top of the downstream repository [1] since
> >> USB doesn't work in the upstream master branch.
> >>
> >> [1] https://github.com/nxp-imx/uboot-imx/tree/lf-6.6.52-2.2.0
> >>     commit 6c4545203d12 ("LF-13928 update key for capsule")
> >>
> >> The time spent in usb_init() ("usb start" command) is reported on
> >> the console. Here are the results:
> >>
> >>         | CONFIG_UTHREAD=n | CONFIG_UTHREAD=y
> >> --------+------------------+-----------------
> >> QEMU    |          5628 ms |          2212 ms
> >> i.MX93  |          4591 ms |          2441 ms
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> ---
> >>  drivers/usb/host/usb-uclass.c | 92 ++++++++++++++++++++++++++++-------
> >>  test/boot/bootdev.c           | 14 +++---
> >>  test/boot/bootflow.c          |  2 +-
> >>  3 files changed, 83 insertions(+), 25 deletions(-)
> >
> > What happens to output produced by a thread? Does it get stored
> > somewhere and written when the thread completes, or do the threads
> > intermingle their output?
>
> The latter. That is why I slightly reworked the USB initialization
> output to print a status once the threads are done, and I also updated
> the related tests as you can see in the patch. For instance the tests
> were expecting:
> "Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found"
> The "scanning bus usb@1 for devices..." part is printed by the threads,
> therefore in any order. I decided to move the text
> "Bus usb@1: 5 USB Device(s) found" to after the threads are complete,
> iterating over the devices in a deterministic order.

OK. I think at some point we would want to collected the output and
only show it when at a prompt or when all processing is done.

>
> >
> > I'm not sure if you saw my email about using a state machine for USB.
> > If so, could you please point me to your reply?
>
> I did, but I did not reply because I did not try. I have a feeling that
> the change would be more intrusive than what I did, but above all I am
> not doing the uthread thing to address only USB but as a general
> technique to make things parallel without too much trouble (at least
> that's my hope). So kind of a different goal.

They are separate approaches. I believe that having the usb-scanning
state in one place as an iterator would benefit U-Boot. It is
currently a bit messy.

Regards,
Simon
