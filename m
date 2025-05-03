Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CB7C3ABAD
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 08:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B45281F0D;
	Sat,  3 May 2025 10:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A6YkzAQz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CBEB820E1; Sat,  3 May 2025 10:58:27 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 107C2810EB
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 10:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5f62ef3c383so5086933a12.2
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 01:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746262704; x=1746867504; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fyL+T1EWvlmpcLqTcoKM5Il2U9p6V91/ZbdB+221NxQ=;
 b=A6YkzAQzXv5u0Fl2+VT9t2cEORCBqvAGCSq3z6r9he45aWpgcqbcR1mS5Ej9ixaal2
 jw9YT0V+ip2ZmkyWCQXgfg3rU9IiBbzuo2uqtBowua0ZzFzty0LEAoUxe60xwtmeRQ8l
 RO636Z2my0dloUPu6GHfTUajOw4WFHHWYG3LBzxgYUtdbULdF47vcaUBLFOcbnmRqvaf
 n+2Qw7c52/MIteIXc+18KcD3Zx8iwtnQfuUFAOlYUJPtn0nErT3zMRw5L3eOVDPIQ/mB
 uYrrIkarPbUkaEAteDl11MVYQl2EiiXb4sDL0OlAB+0DnTphvhA9zGMaLFN+ALskbSpr
 d4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746262704; x=1746867504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fyL+T1EWvlmpcLqTcoKM5Il2U9p6V91/ZbdB+221NxQ=;
 b=srRUe9Z7Yto4aqSWJINjw0ddn+R6HfsHsflcY3NYVYSpKOmEHKns4j2xDGaxvKv+JH
 A8sB4npmPSLOqdiID3rfKYGRDo424ZNMMCppPilCJvlH+x77rYukZvfqDhFQmtaoeKVD
 BueMfELF7Ct7yZ0jPVCgpvrYoMHI7KpGtaVeTb48fto81aVdADH+VJmlxVzHhq/39m09
 wCXuc/3biHrpjOX87e44nU4TvFitGnz4T5gp5GZaAEtKcEtq8Pk1fi5YKQ0rDadenvkS
 WcWjeEbqoWFLpWY8MLJDkCzwXL4lNWZManbC3aq8NQ9JQMiITJ2i9j56EoxwaJzPeZ9G
 l02A==
X-Gm-Message-State: AOJu0YzU1Iouyj86LVBy8/bu2wPkGe7VDTnhD2aZVQG1sKvadaSqSaIq
 gAZ4q7B9j1qp72YEa3o8LG6nROWIcRytUNGI004ZmOPccuctWSeTri1M5k54naLcU4E7HtMPkMK
 EZ8dtIlX0LWGX7wIqEzEt2sEy1qjvfYLY
X-Gm-Gg: ASbGncsiLdsRQUMcL4ghnx+6KsmYEqFFE+Ln/YsnMSI2Fd/AI5N2I0lxIcI29/IByl0
 cqRRFIwOHd1fSpQ+FrwnwV7CwLRYFc3V5lAkGt98FTC880PVo3qoI4eGDJNnHRNip2NmnwPf0a7
 klQIpDS/mjvKA96MET0C7QQQvpGzMG16AHtmDgMAaC9OooIt55wRQsEAo=
X-Google-Smtp-Source: AGHT+IHl473tBzmwM4hmdbRICn4mnMg/JULZDdgRfXWswR9ZDhs2MCENDN0LN2HhUi/1z0GG6qn21CV1bU88ykBQVWc=
X-Received: by 2002:a05:6402:354a:b0:5e7:8501:8c86 with SMTP id
 4fb4d7f45d1cf-5fab05c18b2mr363396a12.22.1746262704172; Sat, 03 May 2025
 01:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <0ae3e9bd-cbc7-4a33-8a1c-926dca3aef3f@aicorn.de>
In-Reply-To: <0ae3e9bd-cbc7-4a33-8a1c-926dca3aef3f@aicorn.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 3 May 2025 09:58:13 +0100
X-Gm-Features: ATxdqUFP-2hSwmiEvdGFR60Uh4aL-k-mME15Dya_q6VVkwPfxn6J5dhbqHQHFwk
Message-ID: <CALeDE9P6Yf5K67yQdGTHaim_Ya5zmQamcK3rSboT+dpb+bZBjg@mail.gmail.com>
Subject: Re: raspberrypi cm4 usb not working
To: Moritz Krautwald <Moritz.Krautwald@aicorn.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Moritz,

> I am building a custom yocto image for the raspberry pi compute module
> 4. I am using meta-raspberry scarthgap branch using the raspberrypi4

Can you provide a link to what ever that branch is?

> machine (32-bit version). (U-Boot 2024.01)

That release is quite old, can you test the latest 2025.04 release or
even 2025.07-rc1 to see if that fixes things, I am pretty sure there's
been quite a few fixes to that in the last year+.

> In the /boot/config.txt I added:
> # Enable USB peripheral mode
> dtoverlay=dwc2,dr_mode=peripheral
> which should be the right mode if I understand correctly.
>
> On startup the following is logged:
>
> PCIe BRCM: link up, 5.0 Gbps x1 (SSC)
> PCI: Failed autoconfig bar 10
> starting USB...
> Bus xhci_pci: dm_pci_bus_to_phys: invalid physical address
> xhci-pci init cannot map PCI mem bar
> probe failed, error -5
> No working controllers found

So the USB2 controller on the CM4 isn't PCI based so those errors are
likely spurious.

> I have no idea on what could be the problem and how to fix this.
> Ultimately I want to use the U-Boot ums feature to expose a block device
> via the usb port to another computer. I have searched the mailing list
> and other resources online but only found the following unanswered
> stackoverflow post:
> https://stackoverflow.com/questions/78843599/usb-not-working-in-u-boot-on-raspberry-pi-4b-with-custom-yocto-image

So if I understand your description correctly you want to be able to
emulate the RPi usbboot process described here?

TBH as one of the RPi maintainers here I've never even considered this
so have definitely not tested it in any form nor do I remember anyone
mentioning it.

Taking a quick look without digging out a CM3/CM4 device I think
you're going to need to enable USB_GADGET_DWC2_OTG and associated
configs, I am not sure if the meta you reference above does any of
that for the configs etc.

Peter

[1] https://github.com/raspberrypi/usbboot
