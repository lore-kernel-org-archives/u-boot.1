Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45857C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E499E88591;
	Fri, 26 Jul 2024 15:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="CQ2l5DHt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30C7387B84; Fri, 26 Jul 2024 15:24:45 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 764CB881BA
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 15:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f0dfdc9e16so6173731fa.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1722000281; x=1722605081;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CP/r+We5xlQL+f858ae5sEUk8lgZQvt8ZUsa4PVEj0I=;
 b=CQ2l5DHtEBoIU/g2+nWvct1RiW635Eq0wC/oMdA+JI1oroO0Gp4pRPSXzf7fykxfPu
 O5yUsVCAKl+xtzNdrPx2Qwx4tZPlMKf3OskJPcXiiWjF+b4yICNTxJp2M4uWWJ9dpeJJ
 s0NaKIcLveO20oH+lx2nB8ajU1dkqQ/ZVS9KxazZzs/lNx96/u/Nq8jsb2gpG7UixBfT
 vjifEPkVJyMebxPJSzzGOLK6X7LjAT0Xkna+V3NSSc0dS118qUVh3LyUXrUgUWlvG3hC
 e6ew0yAxZ3vhYLEcfuPratxcRlTNM+X+bD9uYVfSqzRNRjIBDa9rk61Hp3oEHArLZIg0
 4bQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722000281; x=1722605081;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CP/r+We5xlQL+f858ae5sEUk8lgZQvt8ZUsa4PVEj0I=;
 b=TAnPb4cGjCXPlDfXws4jmTdt8Yiim08k8FTLTs6JHC96VhowLZW75+KGp2MQ6yqdBu
 WFiDeC4yHy5j4+0/7iVaCrMCgwbw9GdOv6A1StaEqpNqBIKpsJNADRupm+prh9i++u55
 xtUByXRVQVuJW0Zi0QtL1IsR9M6ZMfQ6uNG2pwX/7bk3iDdaAl/ZicTbpWCJzbW1NjYX
 t1YllKx2jrcq3oRVyichAh60rvdqwi5v7rv9U/JXrnwdZeCYFIQMQEMPrRC7WoIhUicm
 Q8N/GfoOYKShnHUnwQmHS1iZp1nrYJ9CQVvGpeEAk2KhugstAeGLGVA86mnBaJ4QNQZK
 FaHA==
X-Gm-Message-State: AOJu0YyPI+vIOtcfOL0JB99KiBctBoMueq6inSncGifr3AJe7LZlktRE
 uepztslxeqpZ4bYmvd159VEd7rehcRk/luIHzUlJoXsUdnPg53wylpoYh824OyEZlGAeZXOvQl3
 40rlKqFnxw6GpLG+qvSM2pMs3/ODCCaRfzoM5+A==
X-Google-Smtp-Source: AGHT+IEL3iBos9n7bYf50TAOXpoOXP2Csm9t8nPyHnMjfdpdYqmCCYcjVKbjAHVd0c/ZlSG3qU9JUoTne0DFX/INlls=
X-Received: by 2002:a2e:9795:0:b0:2ef:2543:457c with SMTP id
 38308e7fff4ca-2f039ca2d9emr43357461fa.24.1722000280570; Fri, 26 Jul 2024
 06:24:40 -0700 (PDT)
MIME-Version: 1.0
From: Zixun LI <admin@hifiphile.com>
Date: Fri, 26 Jul 2024 15:24:28 +0200
Message-ID: <CA+GyqeYypLOeAMxZyy6MbG6rXmc6ksi==64gC-z7v5ZQtDURqw@mail.gmail.com>
Subject: cmd: bind/unbind by class index doesn't work with usb gadget
To: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 26 Jul 2024 15:50:59 +0200
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

Bind/unbind a gadget function driver to a USB gadget device doesn't work
with class index, while using node path is ok. For example:

U-Boot> dm tree

 Class     Index  Probed  Driver                Name
-----------------------------------------------------------
 root          0  [ + ]   root_driver           root_driver
 simple_bus    0  [ + ]   simple_bus            |-- ahb
 simple_bus    1  [ + ]   simple_bus            |   |-- apb
 ...
 usb           0  [   ]   atmel_usba_udc        |   |   |-- gadget@f803c000

U-Boot> bind usb 0 usb_ether
Cannot find device 0 of class usb

Both USB host uclass and USB gadget uclass are using the same name "usb"
while they are under different class id of UCLASS_USB and
UCLASS_USB_GADGET_GENERIC.

bind_by_class_index() of cmd/bind.c uses uclass_get_by_name() to find
class id, since both class have the same name it will get the id of
UCLASS_USB instead since it is at the front of the uclass id list.

Then uclass_find_device() will try to find the wrong device and fail.

But fixing this issue simply by renaming gadget uclass name will break
the DT alias feature DM_UC_FLAG_SEQ_ALIAS.

Any idea how to fix it ? Like adding a name_seq_alias field to
uclass_driver structure ?
