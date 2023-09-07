Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2ABEC8721
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 12:24:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7F65869D1;
	Thu,  7 Sep 2023 14:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aQP1ej2a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BE2E8620C; Thu,  7 Sep 2023 14:23:53 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0826086410
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 14:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5921a962adfso9396277b3.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694089429; x=1694694229; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GZKIId8/pxLqSzilJwd0TB9ZHBuuis7wXwC8xMrihTs=;
 b=aQP1ej2aVokeUJ7mm0zkrh3PFC8oaHEWlfXHscRYxW18i35iaT+IhX181M+/RfvW2J
 FJZyfAUv17ejoOBbOJhc253zttdNn1eXzakWQNPh3Hpjdi/qPGn91aOqhgqUPYtex7FQ
 bXBCBllTrb4EeDkBm2CtJiHdfHN6Yico5dHoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694089429; x=1694694229;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GZKIId8/pxLqSzilJwd0TB9ZHBuuis7wXwC8xMrihTs=;
 b=XJTOCmKpG/MSSLYaNrOg9S18lDv2c98nO4flFTbpUztBQ8rocOvpPSAViorHESe4K7
 LxdkyvaVyScJ7/UEyhJ1b4jO2TkyRy1/BVT8jKcKfF+lCZnjYuLjBep3WTG8rn/A6KJ+
 6MV/atHRA/tJdM/JmPkS6cljYp9JTi4iDW4+5P4iISyiIvJTbCgM75+Wb3M8Y+P8bsyl
 whfCaQVA8g9suhwuxbJwtGoHeWO/wi8Ru5fA9RExWutWuDVV/uuaOQgiIF8+1Rlo8RLb
 U7quelEtWWsufZ/2se5udvhtOlABF7tOsTAY0nZO8o4VKeH+oMKIJtdHFCAmQiOkF350
 fBDw==
X-Gm-Message-State: AOJu0YyKoqMwhgB239hrtZsKiHfkJtWZJKE6M87onFLl/Q+NqqQ+G5o7
 huQ1N95oObK5f2stOlcDX3P2A413UFmx+YPJWsx2k/jbrPHv5bhruCI=
X-Google-Smtp-Source: AGHT+IHZu6FrvmIyID16uf2ElzjjBHCnMSE0r5jSBhRGqrRZlSBcFC9sfv5huh6qzWVZmllBekoEpO5kcY9Ry7YPuPw=
X-Received: by 2002:a25:aa52:0:b0:d63:44e:cbcc with SMTP id
 s76-20020a25aa52000000b00d63044ecbccmr19244937ybi.22.1694089428523; Thu, 07
 Sep 2023 05:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <ZO/g8T1ohHI23xM8@octopus>
 <CAPnjgZ32h4vtMiScP-4NKEVFCSYcYHV7=bKVSqT3mQSfDPQ=FA@mail.gmail.com>
 <ZPAlCLyi8eB+a6yP@octopus>
 <CAPnjgZ1sB7xCRD7P-SCjJQP2w6p8Kxx2ahJTbfiQ887djxX7qQ@mail.gmail.com>
 <ZPfrMbr6cAOfklAj@octopus>
In-Reply-To: <ZPfrMbr6cAOfklAj@octopus>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Sep 2023 06:23:08 -0600
Message-ID: <CAPnjgZ1=tGWWdD4N=9CNZRc=mNBfpZNycddOZGyyh0ue7Dt+xQ@mail.gmail.com>
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

On Tue, 5 Sept 2023 at 21:00, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, Aug 31, 2023 at 09:04:43AM -0600, Simon Glass wrote:
> > Hi,
> >
> > On Wed, 30 Aug 2023 at 23:28, AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Wed, Aug 30, 2023 at 08:49:05PM -0600, Simon Glass wrote:
> > > > Hi,
> > > >
> > > > On Wed, 30 Aug 2023 at 18:38, AKASHI Takahiro
> > > > <takahiro.akashi@linaro.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > I'm working on implementing SCMI-based pinctrl/gpio driver,
> > > > > and want to re-use sandbox UT to test the code. However,
> > > > > It is somehow sandbox-specific (with additional DT nodes).
> > > > > How can/should we make it more generic for other targets/drivers
> > > > > rather than just by copying the test code?
> > > > > (I have already created a test for pinmux since there is only
> > > > > one existing scenario, but gpio test has many.)
> > > > >
> > > > > Even if I say 'generic', my case may be special since real
> > > > > hardware (device drivers) cannot always run all the test cases,
> > > > > while SCMI-based drivers potentially can with a dummy SCMI server
> > > > > for sandbox.
> > > > > See:
> > > > >     drivers/firmware/scmi/sandbox-scmi_agent.c
> > > >
> > > > We don't have a good way to test drivers that talk to hardware, in general.
> > > >
> > > > For I2C, SPI and some PCI devices you can sometimes write an emulator
> > > > for the chip and then your driver can talk to the emulator as if it
> > > > were talking to the hardware. Sandbox does actually support that with
> > > > memory-mapped I/O too, although it is fairly rarely used.
> > >
> > > Well, I don't want or need to emulate some *real* hardware.
> > > Instead, I would like to emulate what the current sandbox drivers
> > > (pinctrl-sandbox.c and gpio/sandbox.c) emulate so that we can re-use
> > > (some portion of) test cases for sandbox (test/dm/pinmux.c and gpio.c).
> > >
> > > As you might know, SCMI protocol with associated drivers on U-Boot is
> > > so generic that it would be able to talk to any of real pinctrl/gpio
> > > drivers/firmware (say, run on OPTEE or SCP).
> > > By implementing/mimicking protocol messages in sandbox-scmi_agent.c,
> > > SCMI drivers are expected to provide *virtual* pinctrl/gpio devices
> > > similar to what sandbox does.
> >
> > I actually know almost nothing about SCMI.
> >
> > >
> > > I have already implemented pinmux test with some tweaks by copying
> > > test/dm/pinmux.c and duplicating almost the same DT nodes as "pinctrl-gpio"
> > > in test.dts.
> > > But I'm looking for any other means without test code duplication.
> > >
> > > Did I clarify my question a bit?
> >
> > Well you should be able to factor out the test code into a function,
> > then call it from two places with the two different devices (or other
> > params) that are needed.
> >
> > For the DT, copying a few nodes is not the end of the world, IMO.
> >
> > BTW have you seen this talk? [2] It seems that you are moving pieces
> > into firmware which should be OS drivers?
> >
> > Anyway, if you place a sandbox pinmux device under the SCMI node in
> > the DT, then you should end up with a pinmux device you can use likely
> > normal. Then if that device uses the sandbox emulator, you can run the
> > existing tests on it with little modification, I suspect.
> >
> > But if I am still missing the point, a diagram or patch might help me
> > understand!
>
> I just posted my RFC for supporting SCMI pinctrl protocol[1],
> hoping it will help you understand what I'm planning to do regarding
> test methodology, in particular by looking at patch#5 and #6.

OK...I am mostly out this week but will take a look next week.


>
> [1] https://lists.denx.de/pipermail/u-boot/2023-September/529765.html
>
> Thanks,
> -Takahiro Akashi
>
> > Regards,
> > Simon
> >
> >
> > >
> > > -Takahiro Akashi
> > >
> > >
> > > > We have done this a lot with Zephyr, as well[1] and achieved 90% code
> > > > coverage on some boards.
> > > >
> > > > But I'm not quite sure I am answering the right question, so I will stop here.
> > > >
> > > > Regards,
> > > > Simon
> > > >
> > > > [1] https://www.youtube.com/watch?v=usXCAXR2G_c
> >
> > [2] https://www.usenix.org/conference/osdi21/presentation/fri-keynote

Regards,
Simon
