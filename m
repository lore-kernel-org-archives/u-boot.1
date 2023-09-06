Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAEAEB8FAD
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 03:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAF6C86660;
	Wed,  6 Sep 2023 05:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QFm4JGdU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B51C86660; Wed,  6 Sep 2023 05:00:09 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C31986584
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 05:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68cb5278e3fso753442b3a.1
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 20:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693969204; x=1694574004; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+EPxQZjCadBOZdt3t61CSpCT9YOPdLlB+MGI4y0If3g=;
 b=QFm4JGdUbar9Af/BXrs+YstPRDBj4cV2ozZ9eZwzI3GmaNT2S4TxtQHIe0cM3ATD6Q
 MBvNjfymQ4jtcXH6S+wNgGaVcMDbCDon+0971KONzXmzyfDAuB5cenXxEkeomN1JovB+
 3xntqVzvh+vPWz41YExUNVZhdEQiIPDtVqZJg587Y/RtXY4U3rtx9bZo7Ylh3HzCuM4k
 EMl6dh5r7npSI1nEZyYF4/GMtwoGO2rqYRHCcpXFYntqGeHp82+4n+d65VGY71sFRrNz
 81SHn6qVMTQIkgdMDPgjDBB2BxycsUHPF9mf4gQRsvIBm5KMJB0zI5LwmhQ5ZUV6OrVT
 CE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693969204; x=1694574004;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+EPxQZjCadBOZdt3t61CSpCT9YOPdLlB+MGI4y0If3g=;
 b=g1lUknguDNp6a9c/9Mx9pfH8+VDaWNS239qbRJCdtX34Vh9nNslqSON1uTgOpTsLuM
 +lNoxIVrIME1VUBQS7t6a85o8PUzMZmVRjn6HSABj1vgOmpTx9pOyTXvEAvQDmyHYEHt
 4hZEbNG0bOMiJmOWMgzjjlfvDEN5pcr9sfdufsMAh95FZjKK798OUf2naRAoWiPx5HiH
 g4XuFF2BJ1m3ytUxEXvIQyTLuyzMk6ZUwjZZY9RgMskGMPC7d4nWAYjMYpZqu+INu5/s
 baGZxnvmRKJKyHPrr2hzRR3qxRKOkFrGfh0Zx9L8Pc8gjirtKci59N/upGH4dRssp6TW
 A8XQ==
X-Gm-Message-State: AOJu0YzCX1wAWNvieW+8jjkurJ0n+JqAoRhWpTrmKixur4nl6YLhPBRt
 IkZV+jdoRiVBKbbYqXP95kTpSw==
X-Google-Smtp-Source: AGHT+IEtdDOkyREHbCJWguuaiIKetfm5rHgjGe/p0HXomHiPkJw5V8JzXP3+r9pV6mTo5pJ87++zbQ==
X-Received: by 2002:a05:6a20:7d8c:b0:13d:d5bd:758f with SMTP id
 v12-20020a056a207d8c00b0013dd5bd758fmr20661220pzj.6.1693969203864; 
 Tue, 05 Sep 2023 20:00:03 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:8294:a07d:b7e9:4033])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a170902700400b001c0c86a5415sm9945147plk.154.2023.09.05.20.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 20:00:03 -0700 (PDT)
Date: Wed, 6 Sep 2023 12:00:01 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [RFC] make sandbox UT more generic
Message-ID: <ZPfrMbr6cAOfklAj@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <ZO/g8T1ohHI23xM8@octopus>
 <CAPnjgZ32h4vtMiScP-4NKEVFCSYcYHV7=bKVSqT3mQSfDPQ=FA@mail.gmail.com>
 <ZPAlCLyi8eB+a6yP@octopus>
 <CAPnjgZ1sB7xCRD7P-SCjJQP2w6p8Kxx2ahJTbfiQ887djxX7qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1sB7xCRD7P-SCjJQP2w6p8Kxx2ahJTbfiQ887djxX7qQ@mail.gmail.com>
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

Hi Simon,

On Thu, Aug 31, 2023 at 09:04:43AM -0600, Simon Glass wrote:
> Hi,
> 
> On Wed, 30 Aug 2023 at 23:28, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Wed, Aug 30, 2023 at 08:49:05PM -0600, Simon Glass wrote:
> > > Hi,
> > >
> > > On Wed, 30 Aug 2023 at 18:38, AKASHI Takahiro
> > > <takahiro.akashi@linaro.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I'm working on implementing SCMI-based pinctrl/gpio driver,
> > > > and want to re-use sandbox UT to test the code. However,
> > > > It is somehow sandbox-specific (with additional DT nodes).
> > > > How can/should we make it more generic for other targets/drivers
> > > > rather than just by copying the test code?
> > > > (I have already created a test for pinmux since there is only
> > > > one existing scenario, but gpio test has many.)
> > > >
> > > > Even if I say 'generic', my case may be special since real
> > > > hardware (device drivers) cannot always run all the test cases,
> > > > while SCMI-based drivers potentially can with a dummy SCMI server
> > > > for sandbox.
> > > > See:
> > > >     drivers/firmware/scmi/sandbox-scmi_agent.c
> > >
> > > We don't have a good way to test drivers that talk to hardware, in general.
> > >
> > > For I2C, SPI and some PCI devices you can sometimes write an emulator
> > > for the chip and then your driver can talk to the emulator as if it
> > > were talking to the hardware. Sandbox does actually support that with
> > > memory-mapped I/O too, although it is fairly rarely used.
> >
> > Well, I don't want or need to emulate some *real* hardware.
> > Instead, I would like to emulate what the current sandbox drivers
> > (pinctrl-sandbox.c and gpio/sandbox.c) emulate so that we can re-use
> > (some portion of) test cases for sandbox (test/dm/pinmux.c and gpio.c).
> >
> > As you might know, SCMI protocol with associated drivers on U-Boot is
> > so generic that it would be able to talk to any of real pinctrl/gpio
> > drivers/firmware (say, run on OPTEE or SCP).
> > By implementing/mimicking protocol messages in sandbox-scmi_agent.c,
> > SCMI drivers are expected to provide *virtual* pinctrl/gpio devices
> > similar to what sandbox does.
> 
> I actually know almost nothing about SCMI.
> 
> >
> > I have already implemented pinmux test with some tweaks by copying
> > test/dm/pinmux.c and duplicating almost the same DT nodes as "pinctrl-gpio"
> > in test.dts.
> > But I'm looking for any other means without test code duplication.
> >
> > Did I clarify my question a bit?
> 
> Well you should be able to factor out the test code into a function,
> then call it from two places with the two different devices (or other
> params) that are needed.
> 
> For the DT, copying a few nodes is not the end of the world, IMO.
> 
> BTW have you seen this talk? [2] It seems that you are moving pieces
> into firmware which should be OS drivers?
> 
> Anyway, if you place a sandbox pinmux device under the SCMI node in
> the DT, then you should end up with a pinmux device you can use likely
> normal. Then if that device uses the sandbox emulator, you can run the
> existing tests on it with little modification, I suspect.
> 
> But if I am still missing the point, a diagram or patch might help me
> understand!

I just posted my RFC for supporting SCMI pinctrl protocol[1],
hoping it will help you understand what I'm planning to do regarding
test methodology, in particular by looking at patch#5 and #6.

[1] https://lists.denx.de/pipermail/u-boot/2023-September/529765.html

Thanks,
-Takahiro Akashi

> Regards,
> Simon
> 
> 
> >
> > -Takahiro Akashi
> >
> >
> > > We have done this a lot with Zephyr, as well[1] and achieved 90% code
> > > coverage on some boards.
> > >
> > > But I'm not quite sure I am answering the right question, so I will stop here.
> > >
> > > Regards,
> > > Simon
> > >
> > > [1] https://www.youtube.com/watch?v=usXCAXR2G_c
> 
> [2] https://www.usenix.org/conference/osdi21/presentation/fri-keynote
