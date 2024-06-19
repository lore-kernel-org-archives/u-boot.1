Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C380C2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 01:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 559888854B;
	Thu, 20 Jun 2024 03:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QZW+Y6mw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A9C88840C; Thu, 20 Jun 2024 01:07:29 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5C378846D
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 01:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-421bb51d81aso3214485e9.3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 16:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718838445; x=1719443245; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=AzqtTUTwdrOZxHxjwG8g8kO4FPGmPprZDmGEDrYQQ00=;
 b=QZW+Y6mwZnhGZaW0359907y9QsoBtCEmgSOydeHZmbxBjuzxJnwBbK8Iau8IBvzRer
 wQZ3Msc+ARyO1kk3kPAhiSmFrldv6bgPqTFjyfNR0f9QD8j0DrZUhnBp9tuKhCDmUFmk
 NlHooWZz2GvID59w2b8vfuS7wZqQIylWaR5VaNSmJ0LASKHzvGtLhTMJgGqxjdYxicjT
 DpTD50Nn2EmDxLKPLOtCy+cq1nX+lxLJYCJQFlHmGA5g8769YtMtuyhnvRReXnY4BfYJ
 P1oniR4szNXkuzjWETpZV6PV9e+eZ/S5K6zE6cGUG/7se29vVdAPILwshpkrmVMsaq/D
 AWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718838445; x=1719443245;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzqtTUTwdrOZxHxjwG8g8kO4FPGmPprZDmGEDrYQQ00=;
 b=HDStektEZyeJJQ7tPDqwNM5oIsWhGQXqBNm3f3YuFiDSDlS4XQOpzAEgNvRNVlWSmc
 EyHR0uxmhqVx3W2fcQ8omrFEg/fG5T+KssLw4Kq3H9wgjPd7rdss3OyXJX+mev+p2Zsa
 PHOH3b1jl6PCCLcXoSXByDKkj+bbL8gBjsHhi1cubJ/+00QH9sHLd6vWCsypVUFH3V3p
 7qfvd8lS+l6hFjNHuXvYILMhOO+WOVV/sbEGX8oVOnxkHxSdksmQPlRRgYMVBbxwK1AQ
 /eNaCaNSlt4EA3GA0vRdWBalFBrctuyFFFQ/15rD9U6XEMGaAxSqRHRa1WkaJ8nXfkuJ
 ZXnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR/mEL6+08djxJssFjTLNMwyNxJmJlyNX6lOqYHAqgnWOcQzyHeadXqo8q+haqkr5OiM3CBfSSWbOyXO6UcS4YakvoPw==
X-Gm-Message-State: AOJu0Yy5s+P/9q48HBmKXC9F2byknv4autC0JzSE2h8f6JWKyrpFML7x
 m5OSMX3XnVjmJ6qvaG9dNRFm4F7VIbdDli6tdN2tqnr7bgmIxskZ
X-Google-Smtp-Source: AGHT+IFQg2BzaAo5pv0aMBtCvf24SbDcMMF2n4WCvP66B2hJI9WjMoIEn+HSRIxI6Hg2o6x91Oc+CA==
X-Received: by 2002:a5d:5545:0:b0:35f:1f28:2ec9 with SMTP id
 ffacd0b85a97d-36319a85533mr2782132f8f.70.1718838445171; 
 Wed, 19 Jun 2024 16:07:25 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3630795251fsm3963774f8f.68.2024.06.19.16.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 16:07:24 -0700 (PDT)
Message-ID: <667364ac.5d0a0220.a3cef.07b5@mx.google.com>
X-Google-Original-Message-ID: <ZnNkr4MBCCByBToN@Ansuel-XPS.>
Date: Thu, 20 Jun 2024 01:07:27 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Simon Glass <sjg@chromium.org>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Stefan Bosch <stefan_b@posteo.net>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: Re: [PATCH v3 0/9] misc: introduce STATUS LED activity function
References: <20240611231435.10366-1-ansuelsmth@gmail.com>
 <20240619144421.GX68077@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619144421.GX68077@bill-the-cat>
X-Mailman-Approved-At: Thu, 20 Jun 2024 03:31:55 +0200
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

On Wed, Jun 19, 2024 at 08:44:21AM -0600, Tom Rini wrote:
> On Wed, Jun 12, 2024 at 01:14:15AM +0200, Christian Marangi wrote:
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
> > We add status_led_activity_start/stop() used to turn the
> > activity LED on and register a cyclic to make it blink.
> > LED will continue to blink until _stop() is called.
> > 
> > Function that will start some kind of action will first call
> > _start() and then at the end will call stop().
> > If (on the broken implementation) a _start() is called before
> > calling a _stop(), the Cyclic is first unregister and is
> > registered again.
> > 
> > Support for this is initially added to the tftp, mtd and ubi
> > command.
> > 
> > This also contains a big fixup for the gpio_led driver that
> > currently deviates from the Documentation and make the
> > coloured status led feature unusable.
> 
> A number of platforms now fail to build:
> https://source.denx.de/u-boot/u-boot/-/jobs/854228#L1455
> and please rebase on top of current next as well. To make world build
> testing easier you may wish to read over
> https://docs.u-boot.org/en/latest/develop/ci_testing.html but please
> note that there are sometimes spurious failures due to the cyclic
> framework and applying
> https://patchwork.ozlabs.org/project/uboot/patch/20240524210817.1953298-1-rasmus.villemoes@prevas.dk/
> temporarily is likely the quickest path forward at this time.
>

Hi Tom, no idea I had to target next.

I just sent v4 (require moderation approval).

I rebased the thing and fixed the errors catched by the azure pipeline.
Hope the gitlab tests doesn't have additional target that I might have
missed.

I also had to use the suggested testing patch for the tests.

-- 
	Ansuel
