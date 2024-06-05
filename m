Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3785C27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 05:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8FE9883CF;
	Thu,  6 Jun 2024 07:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DNiA+Tza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C379288103; Wed,  5 Jun 2024 22:33:48 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAF2188365
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 22:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4214fe0067fso3171205e9.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 13:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717619626; x=1718224426; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ideyByhMtP4IXpaPql+OYEED9tAXfvnrLQ+wM+Zc3to=;
 b=DNiA+Tza9gcv4jS1fF+F0trcDKHRF/6I4fXHalpLiSQMd4Y/8W+1Crcng5R9oc68lN
 3pkW3JWBYDuvsTMIeEpaHEzLn1iouSqXM1YUGg2aLy9W9V5r8amN0pzHOSMoI5xXASJ0
 wsZYaMbAO/AWaMQpiMQ5XsPww9BY2D0SnN7+9tOqQ+li3rFQellzLqsJhSK20tJbb8ez
 aWaJ2jNdw3CR0mP4knbjIFFr3gMshJRYq18qbpNHYT1+GgPWfMLuMJwScj7s7q+ALaP/
 TVKCLe67rjcvnqzSVRnAVEWLJN2n+ThLITqX8cZdPk7cXww59n8J8yqsNfswRQqAKWd7
 7ieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717619626; x=1718224426;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ideyByhMtP4IXpaPql+OYEED9tAXfvnrLQ+wM+Zc3to=;
 b=KRQzkfN7Wlt8gt101KOMvr7kOsYHEMF9WXDlGgelivFlX/j5Zk6FIlaSnvaQADXnQA
 Vx2a6txgc7hr3ZBmmihALgZJBoExRMcEeWPbpG24kh8VRiKljEmrneHjjhKD0e4bvRpl
 jOoM08SfCbqUOY8D8K4hNsKReKGOFT7lXKqkc3NttvRVCq5OQSYlIhCGbtj0GctEBtKj
 kvBY0QqnjCFqHJ+qVr5ToggLc1Iqwr73WbBw8S1HvQ1Ld8E0+OWwQDKDwXuiuk8+5Nii
 UBPRLdkfNjKZbP7SdCFgDUofDM8eM5JmxP1j493yXdngNe7nXCNB495HWpam1wVqjoCg
 42Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2nJTUwbcxO6Xs66NVe9tYehSUkrriQO8oxOFKcKJuIj3eKQRMwxMx+KV9ZXxzSi1ItrJIiza9uh+LOyHS35Pi6avQbA==
X-Gm-Message-State: AOJu0YzzWW0dcofSTYjF3ZVRN+JX5GMr6HYnzCfGZAN7jMMvgQykyao7
 5OU2Dg72keaH08mcyAwIsWrHt0bafENQBwKpdGSFqdcx6/wZqkRK
X-Google-Smtp-Source: AGHT+IHR+YAjbwceYq5OcyvvKN/rkGTM1hRiFCtA8VzlggodAedpvr879Ne40ZKIlIwbJYyTv71szA==
X-Received: by 2002:a05:600c:1c12:b0:41d:d406:9416 with SMTP id
 5b1f17b1804b1-4215634de28mr30445585e9.34.1717619625822; 
 Wed, 05 Jun 2024 13:33:45 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421580fe366sm34022935e9.7.2024.06.05.13.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 13:33:45 -0700 (PDT)
Message-ID: <6660cba9.050a0220.31f78.af87@mx.google.com>
X-Google-Original-Message-ID: <ZmDLqEWnPuGr0oK5@Ansuel-XPS.>
Date: Wed, 5 Jun 2024 22:33:44 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dmitry Dunaev <dunaev@tecon.ru>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eugene Uriev <eugeneuriev@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Pratyush Yadav <p.yadav@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/7] misc: introduce STATUS LED activity function
References: <20240605192146.19052-1-ansuelsmth@gmail.com>
 <20240605202321.GX68077@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605202321.GX68077@bill-the-cat>
X-Mailman-Approved-At: Thu, 06 Jun 2024 07:58:11 +0200
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

On Wed, Jun 05, 2024 at 02:23:21PM -0600, Tom Rini wrote:
> On Wed, Jun 05, 2024 at 09:21:32PM +0200, Christian Marangi wrote:
> 
> > This series expand the STATUS LED framework with a new color
> > and a big new feature. One thing that many device need is a way
> > to communicate to the user that the device is actually doing
> > something.
> > 
> > This is especially useful for recovery steps where an
> > user (for example) insert an USB drive, keep a button pressed
> > and the device autorecover.
> > 
> > There is currently no way to signal the user externally that
> > the bootloader is processing/recoverying aside from setting
> > a LED on.
> > 
> > A solid LED on is not enough and won't actually signal any
> > kind of progress.
> > Solution is the good old blinking LED but uboot doesn't
> > suggest (and support) interrupts and almost all the LED
> > are usually GPIO LED that doesn't support HW blink.
> > 
> > To fix this and handle the problem of device not supporting
> > HW blink, expand the STATUS LED framework with new API.
> > 
> > We introduce a new config LED_STATUS_ACTIVITY, that similar
> > to the RED, GREEN and others, takes the LED ID set in
> > the LED_STATUS config and is used as the global LED for activity
> > operations.
> > 
> > We add status_led_activity() that simulate software blink.
> > Any function that signal activity will call this function.
> > At each call a counter is increased. When the counter reach
> > the freq value, the LED is toggled simulating a blink and
> > the counter is zeroed. When the counter reach the freq value
> > again, the LED is toggled again and so on...
> > 
> > Call to this function is added to the usual operation for
> > recovery. Currently added to tftp traffic and mtd spi and
> > nand write and erase operation.
> > 
> > This also contains a big fixup for the gpio_led driver that
> > currently deviates from the Documentation and make the
> > coloured status led feature unusable.
> 
> Thanks for the work here, this is quite interesting. My only real
> feedback is, can you please rewrite doc/README.LED as doc/api/led.rst
> (and add it to the index), and then document your new functionality
> there as well?
> 

Yes totally, actually my bad for not updating the Documentation.
Honestly I really wanted an early feedback on this for the
implementation. Also I love how it's very easy to add this activity
thing also in other cmd or other task.

-- 
	Ansuel
