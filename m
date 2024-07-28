Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95077C3DA49
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 19:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB89488732;
	Sun, 28 Jul 2024 21:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FRTixiJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F40B88772; Sun, 28 Jul 2024 21:36:17 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC3D388677
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 21:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7a1d436c95fso157376285a.3
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 12:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722195374; x=1722800174; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ceMnTQmigXNvZFyKwFQtR6nr5kvnFb2vmaxObgAfkYw=;
 b=FRTixiJ+6Xw6vX/Iu1KuoPjjes+x6btcDA1v89YMNDEyT6YNr9q+qNyWk9wJRrtLbf
 +YJTK42Q6/li39kYE9OuhTVdKuHmGzXmUBD3YOztI5HrjSQMHD26Vpncr0hCyHQkC8A8
 GeatfKhnSbqagWp9CP5/GPzmva5cj7WgohUM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722195374; x=1722800174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ceMnTQmigXNvZFyKwFQtR6nr5kvnFb2vmaxObgAfkYw=;
 b=LVYjc18+Kbok7R/2kGJtV03P4OWInay0DtqViEQW47oxBOOFS52HP3FBs66oRQUNtq
 i9+328UIY+8/pDGbTNBdlbTri0VlvlsgTpyYTkk7yx5gi8M/Q/uLGfJ7sKv0OszhcRj/
 WkrRPu+/0gwIynp1LGzBOLCgJTYH3RKCRb6P2zqw/K2535tyLKcMnDy8Nknl9gwhwjEc
 E4aeGQJV8VAFnZd3sjvEgEyuh76OVe7w8UVOKctAdiGZ2nH8h2nmdWhfqRw+G98K70ZC
 zETZGV1Oxkn0RJy0MHml/pNtdAprPmDTezZIWF2qi7tOEsG/SUUacEYBJE28WQ8O+zuo
 o2rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1NrxKdNQxctHc/NXZ1ml/uex5hlSGgJvN9Th3yWWQtN/cU+tm3LeHwd7k5RPugnFStNsTmUBKb1DS21cCchxY4jH7oA==
X-Gm-Message-State: AOJu0Yz+aEYR9xx2PJ0waDXIetPgC7UfLcAYv9gLDZoNQQYBkJR7s8TC
 2qzZSD86Cv5bDfOntqOmgjNLKds/rlRw0kRie7bLZ/MJvuA70snN61ethebbwLCs0rQ0AOsL4ir
 15UD5dOfhEzGZ8bCfbcjcPfUmZQSY6qZ+tBOg
X-Google-Smtp-Source: AGHT+IEss6OmZNvY1bGI1wZV2KnW1icF+FCxWQggCufuuHmbmG2RYGEhz/beUcEmzAtwT9gmzl1d83meUIbGcNB6Q9E=
X-Received: by 2002:a05:6214:2a89:b0:6b5:e3fe:e734 with SMTP id
 6a1803df08f44-6bb559bc695mr79216696d6.3.1722195373745; Sun, 28 Jul 2024
 12:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <CA+GyqeYypLOeAMxZyy6MbG6rXmc6ksi==64gC-z7v5ZQtDURqw@mail.gmail.com>
In-Reply-To: <CA+GyqeYypLOeAMxZyy6MbG6rXmc6ksi==64gC-z7v5ZQtDURqw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 28 Jul 2024 13:36:03 -0600
Message-ID: <CAFLszTjxz-oUQCCY40pzm1t3+V+Rbv0+WsQ8a-7FX8=f1kJW3w@mail.gmail.com>
Subject: Re: cmd: bind/unbind by class index doesn't work with usb gadget
To: Zixun LI <admin@hifiphile.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, 
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de
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

Hi Zixun,

On Fri, 26 Jul 2024 at 07:24, Zixun LI <admin@hifiphile.com> wrote:
>
> Bind/unbind a gadget function driver to a USB gadget device doesn't work
> with class index, while using node path is ok. For example:
>
> U-Boot> dm tree
>
>  Class     Index  Probed  Driver                Name
> -----------------------------------------------------------
>  root          0  [ + ]   root_driver           root_driver
>  simple_bus    0  [ + ]   simple_bus            |-- ahb
>  simple_bus    1  [ + ]   simple_bus            |   |-- apb
>  ...
>  usb           0  [   ]   atmel_usba_udc        |   |   |-- gadget@f803c000
>
> U-Boot> bind usb 0 usb_ether
> Cannot find device 0 of class usb
>
> Both USB host uclass and USB gadget uclass are using the same name "usb"
> while they are under different class id of UCLASS_USB and
> UCLASS_USB_GADGET_GENERIC.
>
> bind_by_class_index() of cmd/bind.c uses uclass_get_by_name() to find
> class id, since both class have the same name it will get the id of
> UCLASS_USB instead since it is at the front of the uclass id list.
>
> Then uclass_find_device() will try to find the wrong device and fail.
>
> But fixing this issue simply by renaming gadget uclass name will break
> the DT alias feature DM_UC_FLAG_SEQ_ALIAS.
>
> Any idea how to fix it ? Like adding a name_seq_alias field to
> uclass_driver structure ?

It looks like test/py/tests/test_bind.py does not cover this case.

We don't have a check for duplicate uclass names but probably should.
Also sandbox builds USB gadget support but I don't think it is used.
If it were we could add a test for this case.

I think the UDC uclass should be renamed to "usb_gadget". That may end
up requiring changes elsewhere, but I'm not sure.

There are also weird things like omap2430_musb having two different uclass IDs!

Regards,
SImon
