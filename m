Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E44C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 13:44:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5377088BB7;
	Wed,  7 Aug 2024 15:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="vK6aeAxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C66F88AB8; Tue,  6 Aug 2024 22:29:13 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D45D87876
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 22:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f189a2a7f8so12797951fa.2
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 13:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1722976142; x=1723580942;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cg0h21acBZNTO6+tKUQwWrtC788HGSSlsNMgQGbx6n0=;
 b=vK6aeAxa6V9YMj1ZTZwdb524yZGWYjpXBKb4bZ6CazkQ3FHQmowMVgV9CKrlFvNfo0
 OdlVCos+pAbB+dWv+OFpXL2v8Ne73OQDL9l0Jy9jhGFPmBC2EqwS5HM3KpAGt4Lp81GE
 22VMqEy4nP3ReC6M5U1dAns/Huqryv+2Aty+qxmEEFUZU8ItlDgzdcKJ5Fs7lK+IVO7H
 qVhRGL+E2tRm8O63PKJhQfp7oEPNvp0GvnQfshC11EL8UWzVWd5StnUuIldI6cgNvgzn
 /CRq6bMNo9xENo2sPzubDBHbbl8XN+F039KyssVtxSPSdZFY7uU94DD6tKuTiOBVXtpl
 VSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722976142; x=1723580942;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cg0h21acBZNTO6+tKUQwWrtC788HGSSlsNMgQGbx6n0=;
 b=tbFvHiUpOVcBi/rcFOjLFtHiB16ALS/73Zec0rC6b7FbbD1k0hMBsrUD2BJ00iW/el
 bqa2TKeURU8gI/z+rdW7mGznISRstX4uHR4GF0DDgW8ZFiY7f6Fkc19z6Lo4iHfQQJqL
 SRcyQzrbotRZo4ReNkVPLAHZuewfvzKb3CnReZwNBkflUrZXTXKXgdCy1Fy8wy0ZYRcY
 6tI43PH/VRM8ge/jWrN/qh7BpcTAyUdqG+utkceFHwOtqJcLiR6eANBMGpuazaOuHG5I
 B0zgCn/dHrEwlcbpWDnMxCyuTQSi4ad34LRgvUGOQH0mwEETe/xTXRVNXzPqS03VF4r8
 O6FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh8XQAU6RgM4iwvHT8Qc5wLSDKsmDx2jzg5GGuNs9L6QV/mh3iKZedUfP5vwHKewNnhmCILiHnJwy2PZ1J5anX6QsF6w==
X-Gm-Message-State: AOJu0YwKDEmGdOstFJi6UBXiSTk/L217reYIm1bw20jXedLOSOkMqLOD
 I3st4tdhxy271+zi3nwsGJuDtMZDnNNdbxq/llAD1pcgE2pJRYFLvntkPFCKVkGCoNHthpEE0pU
 KxSitQ+T7Pl/lccMcWi9lSaGZfk0CYp66OwqQsJchSv/VR0UYVsPXzA==
X-Google-Smtp-Source: AGHT+IGXiARuK42yMTeAp8SG4YsUyjtG3pZpZiZt0rqYdklwK83dfgOMkVz1P001HZ7up/4kbS0LIGworjC8eaWFgBE=
X-Received: by 2002:a2e:b6d3:0:b0:2ef:1f68:eae1 with SMTP id
 38308e7fff4ca-2f15aa95b5emr107154271fa.17.1722976142177; Tue, 06 Aug 2024
 13:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240726083102.380719-1-admin@hifiphile.com>
 <87y159oio6.fsf@baylibre.com>
In-Reply-To: <87y159oio6.fsf@baylibre.com>
From: Zixun LI <admin@hifiphile.com>
Date: Tue, 6 Aug 2024 22:28:50 +0200
Message-ID: <CA+GyqeaD26fE9Ks+KP7X+Bok2gF8VE_hgeE2Qfiub8X=REO4EA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: ether: Handle gadget driver registration in
 start and stop
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 07 Aug 2024 15:44:15 +0200
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

Hi Mattijs,

On Tue, Aug 6, 2024 at 4:00=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> I'd like to test this on my end as well. Could you please give some
> details on how this has been tested?
>
> A sequence of U-Boot commands would be helpful, for example.

My tests are done on a custom ATMEL SAM9G25 board powered
by USB Gadget port.

Gadget is enabled in the DT:
&usb2 {
status =3D "okay";
};

usb_ether enabled in board late init:
int board_late_init(void)
{
#ifdef CONFIG_USB_ETHER
usb_ether_init();
#endif
return 0;
}

Without this patch the host will try to enumerate the USB device once
 U-Boot is loaded and result in the error I mentioned.

With this patch USB is connected only when ethernet command, like dhcp
is run, then disconnect when it's finished:
usb 1-1: new high-speed USB device number 91 using xhci_hcd
usb 1-1: New USB device found, idVendor=3D0000, idProduct=3D0000, bcdDevice=
=3D 3.17
usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
usb 1-1: Product: Ethernet Gadget
usb 1-1: Manufacturer: U-Boot
cdc_ether 1-1:1.0 usb0: register 'cdc_ether' at usb-0000:04:00.3-1,
CDC Ethernet Device, de:ad:be:ef:00:00
cdc_ether 1-1:1.0 enp4s0f3u1: renamed from usb0
gadget0: port 1(enp4s0f3u1) entered blocking state
gadget0: port 1(enp4s0f3u1) entered disabled state
cdc_ether 1-1:1.0 enp4s0f3u1: entered allmulticast mode
cdc_ether 1-1:1.0 enp4s0f3u1: entered promiscuous mode
gadget0: port 1(enp4s0f3u1) entered blocking state
gadget0: port 1(enp4s0f3u1) entered forwarding state
usb 1-1: USB disconnect, device number 91
