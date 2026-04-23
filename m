Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC4AFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44B5E843C5;
	Sat, 25 Apr 2026 18:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MprzVbNS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA00A84105; Sat, 25 Apr 2026 18:45:55 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7639883FF5
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dcd8ef572aso2906610a34.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777135552; cv=none;
 d=google.com; s=arc-20240605;
 b=PNlaNcE/LF8tdoAB2sAe3mj3gR/H/lVKGpaLXpl89CjTSCqRY4SMF2zmqnyTic02jp
 sw1LBQLSqWfQoevyxHMJWJ6VtQf2OhZ5e/T1dFpUTDPrKqgn8spnQ64T7hgoYEmTTsJE
 RMETRzfcAnjbjWuLbkbafYHwYIded9u/8+WiujHVA+aEK9AYlro2ABoKxBU0v/dRibLX
 K/li0LuCYlDr+C1kk/d4AWdcrOB4baSNK2GEFFNh5i/PVnhDjslrvDtdPCNKTUUwi3N0
 Yc5axbLDmKs2RxbIZ6WC3t9lVjBTsWQl6FBx6yBP/xVfUU9Pdl7713yuVOfpc+D9GmEc
 GFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tAPfanhmVCl70f7M6wdAB9llVjfhaMp/GoJI5gGU8LQ=;
 fh=aaODkfIO4AEHi5TFUT6oBY/pY3tp8NU+UtOkxWE2xbY=;
 b=g7vFy35GrKNe85nM/iihgToK5goulZ7jQY+If97f2Fl7ZrsISKEYqx3zA3Z8ERDKuV
 OUQLgxyLbMDP7kVaQy8oVSX7szZg1xwAJCos3VAsxHr0n5DydA8cpIolMAmiPDzO6trb
 t7EDfrq4lSxekfHXUoT8bSFuA/ZPrnTrdRiVQFjYi8wTqmWG5olwKQOyIJBTETRvzIQB
 cw7dcJtpe3F+tgUGxGBsNq+px2ij0JdCzCguMq429XERoarhQdxftE/TiCSKow/Sqll6
 GwgZ4Fatss2eMdRy6DOvCEFhz3ADHnHT230VqYyl2zHvplYx2pYF+YM8sHXebvIajBX8
 bPpQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777135552; x=1777740352; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tAPfanhmVCl70f7M6wdAB9llVjfhaMp/GoJI5gGU8LQ=;
 b=MprzVbNS1/QcyhFOaSL5QwYpn+FqLPUW6ol/WeUBGEUW1TbktlZJ/ucADVnVdsKLzq
 eMjyPCD/ipY1kFJEQIaEeN/iLsIimSavs4WJXrTUXUdj+4kyoN/6r93oemlINpN32Hj2
 uM/Ze038OGbRFMj+Hkj2j1FRFXDuoGCSxVmeqNVZ7Z0mdj2hoQP84V8P6Mr9a9lwCfsM
 xEML6p5b7j3FWpQkEJ8mJiaQZbgI7C45Zy5Al1uBiuTxusPTRqwsC5xcAWBZHwMZg2Re
 3Vp/1tpemq38o/G14L2in5GizQ6ZbHED3Qy+iPQlAO7Jn8YqXZ9rsLkKKipqRrH6ALbf
 Ddbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777135552; x=1777740352;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tAPfanhmVCl70f7M6wdAB9llVjfhaMp/GoJI5gGU8LQ=;
 b=JIZ/PtJviBp4eelGEG+TF29QIVbJO0jZrZStzeYIUScjcC8wS4ytrBH3OOjf37oXb5
 EJzmOxIpISBRq+u7X/JfnVAKQoStMSdAxdcHrK5tnJ+UF/QmaxhUV46+gh+HuhvlJ76b
 K6ZPYFrR0eYUmWyfZhXHvn0pHhCWi7QgnyMgt1dMc8Ge7PywMtM0K+OY2PcRxmaYzNXY
 Va4cAP6ZF1NKkP/67moGBMxK4Xlh5LFZspK+JIv8Lqupu/vDbP2s01ynSNPuHvr7zBXt
 UOYUtKeMuCBt9gtWoWDF2jz9U50zM+H6yMRhSpRPB2PdoR1HbXymCmvoxqSDviHt0Een
 5cTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YKmH9T0jEgHPVhCpc4CXCwiZCQizg0hEPQ/VJ1rkTOzE6O1iNHjJLpxV6MaSKOvznjmaegGs=@lists.denx.de
X-Gm-Message-State: AOJu0YxHzIN4WxCzvMMsU1y96jB7xt6z8hmIi0OoujfFZWtCy5TnjjYh
 9f5lj8N514vEiq8XXqalHzogLVjNmc8XTXNEKxRt/cwbXEDXH33TyCwknoLxb1TRzCV+8MGQC6f
 2ZJZDDdDPhrnY/Js6lS1tdMxCnWLTsput6g==
X-Gm-Gg: AeBDiesUfURuesVBJ6Of+kQM++JqQRCRfBcLFXJVS8bUtDRZIeiIta41Wz/XEF5uIqw
 r68kV0PiVr7Dyua7o2tChURKdjU4U+c+eb4txxEPs0YnbswqUfAq88VSte7LFL8dVPihYLW6cjC
 +ORV1QCe4YXscEJWyXFZFvDtweMsqDdvM82zk3/hN2OGu1JnLIfen2RajSbs4U2S6IIQRN8OJ5n
 EcpS99CyiTTYJHAA+dOEXzGA+iXEVqflyD5VrMG9/XJxvqm/lgAAF8ltC43cfhnHZQmCYtsR9Zm
 CbncCo0ypHxOg9xkwAg=
X-Received: by 2002:a05:6820:290c:b0:694:979e:333d with SMTP id
 006d021491bc7-694979e352dmr5771424eaf.37.1776931511852; Thu, 23 Apr 2026
 01:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260422165938.35925-1-micbis.openwrt@gmail.com>
 <20260422165938.35925-2-micbis.openwrt@gmail.com>
 <edd83758-4f28-425c-b828-fb1e7a885d4d@mailbox.org>
In-Reply-To: <edd83758-4f28-425c-b828-fb1e7a885d4d@mailbox.org>
From: Michele Bisogno <micbis.openwrt@gmail.com>
Date: Thu, 23 Apr 2026 10:05:00 +0200
X-Gm-Features: AQROBzDKKPOSmFuBhFNiJm6_z9BkimRGucysZ6kpDYPIJM2uqyh4c4hUuDymshw
Message-ID: <CAP8xZ6n2ibGnmAacHB0t6pjhAYuyYL9kRfPGayCDneLM3rLQVQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] usb: gadget: rcar: Fix gadget registration
 lifecycle in remove
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 25 Apr 2026 18:55:44 +0200
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

On Thu, 23 Apr 2026 at 05:02, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 4/22/26 6:59 PM, Michele Bisogno wrote:
> > The driver currently fails to unregister the USB gadget when the
> > device is removed or the driver is unbound. This leads to dangling
> > pointers in the UDC core and potential memory corruption.
> >
> > Add a call to usb_del_gadget_udc() in the remove path to ensure
> > a clean teardown of the gadget interface.
> >
> > Signed-off-by: Michele Bisogno <micbis.openwrt@gmail.com>
> > ---
> >   drivers/usb/gadget/rcar/common.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/usb/gadget/rcar/common.c b/drivers/usb/gadget/rcar/common.c
> > index 2ba022a3f2c..f7b34f0485f 100644
> > --- a/drivers/usb/gadget/rcar/common.c
> > +++ b/drivers/usb/gadget/rcar/common.c
> > @@ -447,8 +447,12 @@ err_clk:
> >   static int usbhs_udc_otg_remove(struct udevice *dev)
> >   {
> >       struct usbhs_priv_otg_data *priv = dev_get_priv(dev);
> > +     struct usb_gadget *gadget;
> >
> >       usbhs_rcar3_power_ctrl(&priv->usbhs_priv, false);
> > +     gadget = usbhsg_get_gadget(&priv->usbhs_priv);
>
> One more nitpick, usbhsg_get_gadget() can never return NULL, so this
> test for NULL is unnecessary, please drop it.

OK.
