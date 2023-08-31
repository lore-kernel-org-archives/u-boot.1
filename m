Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747D2C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 15:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C07648658D;
	Thu, 31 Aug 2023 17:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HElabPfU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 707848659D; Thu, 31 Aug 2023 17:05:06 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66C258657F
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 17:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4e6so1226331a12.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693494303; x=1694099103; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BJM8em0ov9qrsSQxC2fSymbw9N2mX4+H9JmCMCCp5M8=;
 b=HElabPfUGTdfeHdzZ5onX5EBdkUt+bUxsta9kMdA/D7/+/YQvqf8iuUVgwBMeNQpgq
 1n8wBn7JZxnMiTg4UmcNsbD19Ig0UiBkD1DyUf11OIXLVJovJ2r05cKhgbqqxUlHGCgr
 vfTqM9GMKXnUlJGOwpPL/PBJd0Rghzjk0n9vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693494303; x=1694099103;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BJM8em0ov9qrsSQxC2fSymbw9N2mX4+H9JmCMCCp5M8=;
 b=dGF4iUrbl0cUAVSpttpWBiecvOZddXvE0dN6TQqL6Y4Td5+uYprIr3IBurtjTi1Xx9
 syh6CMZZ22/45sTAsI4qL1iif5lXFeW6HzsIXvW5HgdsHZpcQc9RRjPNX4+bnvehNfi5
 na6ItkIorqYRA0vhg9eUZG63qUrt/FfLyVO393Eq1TJYkiePiLZQnIoRWxpuf6KoPWQb
 q7Obqv/Qn3hlMI7g4FryN8vFrs/yoTk+ClGsgwpFnW9T4xRykdqzJphmQUGsKdJc4hYh
 CPDrDpgQO8IDZvRaO3hJwyEOOc0tUis2ImtTbQACqFrXRs0mmsoVbBhZ5LsqumLyJWKw
 175Q==
X-Gm-Message-State: AOJu0YzbAKpMSlFF1LO4M1QHHluvS4VUFPZm/enzxUuExn2zGpbqaA81
 zSI8/P+AQpe2sQ2foJUFkIoXKWrdbnWMVemFig6QdA==
X-Google-Smtp-Source: AGHT+IGxUjCJUv7ZFP2cLT4bNt9nM4kofBGiGzH/xexTicHaOpZ7hTpT0HHQV0By/BhEXy8+HJr+hTtnbFMVHC9CB+0=
X-Received: by 2002:aa7:d6cb:0:b0:525:7f37:e87a with SMTP id
 x11-20020aa7d6cb000000b005257f37e87amr4538940edr.16.1693494302674; Thu, 31
 Aug 2023 08:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <ZO/g8T1ohHI23xM8@octopus>
 <CAPnjgZ32h4vtMiScP-4NKEVFCSYcYHV7=bKVSqT3mQSfDPQ=FA@mail.gmail.com>
 <ZPAlCLyi8eB+a6yP@octopus>
In-Reply-To: <ZPAlCLyi8eB+a6yP@octopus>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Aug 2023 09:04:43 -0600
Message-ID: <CAPnjgZ1sB7xCRD7P-SCjJQP2w6p8Kxx2ahJTbfiQ887djxX7qQ@mail.gmail.com>
Subject: Re: [RFC] make sandbox UT more generic
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

Hi,

On Wed, 30 Aug 2023 at 23:28, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Hi Simon,
>
> On Wed, Aug 30, 2023 at 08:49:05PM -0600, Simon Glass wrote:
> > Hi,
> >
> > On Wed, 30 Aug 2023 at 18:38, AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> > >
> > > Hi,
> > >
> > > I'm working on implementing SCMI-based pinctrl/gpio driver,
> > > and want to re-use sandbox UT to test the code. However,
> > > It is somehow sandbox-specific (with additional DT nodes).
> > > How can/should we make it more generic for other targets/drivers
> > > rather than just by copying the test code?
> > > (I have already created a test for pinmux since there is only
> > > one existing scenario, but gpio test has many.)
> > >
> > > Even if I say 'generic', my case may be special since real
> > > hardware (device drivers) cannot always run all the test cases,
> > > while SCMI-based drivers potentially can with a dummy SCMI server
> > > for sandbox.
> > > See:
> > >     drivers/firmware/scmi/sandbox-scmi_agent.c
> >
> > We don't have a good way to test drivers that talk to hardware, in general.
> >
> > For I2C, SPI and some PCI devices you can sometimes write an emulator
> > for the chip and then your driver can talk to the emulator as if it
> > were talking to the hardware. Sandbox does actually support that with
> > memory-mapped I/O too, although it is fairly rarely used.
>
> Well, I don't want or need to emulate some *real* hardware.
> Instead, I would like to emulate what the current sandbox drivers
> (pinctrl-sandbox.c and gpio/sandbox.c) emulate so that we can re-use
> (some portion of) test cases for sandbox (test/dm/pinmux.c and gpio.c).
>
> As you might know, SCMI protocol with associated drivers on U-Boot is
> so generic that it would be able to talk to any of real pinctrl/gpio
> drivers/firmware (say, run on OPTEE or SCP).
> By implementing/mimicking protocol messages in sandbox-scmi_agent.c,
> SCMI drivers are expected to provide *virtual* pinctrl/gpio devices
> similar to what sandbox does.

I actually know almost nothing about SCMI.

>
> I have already implemented pinmux test with some tweaks by copying
> test/dm/pinmux.c and duplicating almost the same DT nodes as "pinctrl-gpio"
> in test.dts.
> But I'm looking for any other means without test code duplication.
>
> Did I clarify my question a bit?

Well you should be able to factor out the test code into a function,
then call it from two places with the two different devices (or other
params) that are needed.

For the DT, copying a few nodes is not the end of the world, IMO.

BTW have you seen this talk? [2] It seems that you are moving pieces
into firmware which should be OS drivers?

Anyway, if you place a sandbox pinmux device under the SCMI node in
the DT, then you should end up with a pinmux device you can use likely
normal. Then if that device uses the sandbox emulator, you can run the
existing tests on it with little modification, I suspect.

But if I am still missing the point, a diagram or patch might help me
understand!

Regards,
Simon


>
> -Takahiro Akashi
>
>
> > We have done this a lot with Zephyr, as well[1] and achieved 90% code
> > coverage on some boards.
> >
> > But I'm not quite sure I am answering the right question, so I will stop here.
> >
> > Regards,
> > Simon
> >
> > [1] https://www.youtube.com/watch?v=usXCAXR2G_c

[2] https://www.usenix.org/conference/osdi21/presentation/fri-keynote
