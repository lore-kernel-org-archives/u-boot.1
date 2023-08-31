Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B627AC83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 05:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59ABF86545;
	Thu, 31 Aug 2023 07:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PCHSanUp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A91D86546; Thu, 31 Aug 2023 07:28:48 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A18E86524
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 07:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bf7b5e1f06so881595ad.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 22:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693459723; x=1694064523; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9AyfhzHra7t2MRcLpzWBb+I8SXAN6+InGALBZubFOkY=;
 b=PCHSanUp8pzLK7jkmmHyFbFBbblifvIetReKn+U0m6e0EUx6TmkquiNEfHhcocBNl7
 aQIt3zYs9gUDBe2UJ4DlgjM+Z2/2/nLrb6bHp9kbnCz8Cxw+MFB35YE7Svf3+kby9Bsd
 i69lLfPRB2zW8N0UEQuuuTNrtTYjExTUiPd77YXFfOV6JFxTQkxnQavTZ2TxuDvIyJPS
 j4U1zirI85pJJL64iv0lBCf/4Jzru7JU3/ojYxlfp2r6ZxGXhBgtYSaet320F0t6HlxD
 LrfjLSiORDGUyzP2IOnkEk2NoUmcUkp4QJsuGl070SsQprmdc2A3fEahbFz+wyVMlBI2
 UXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693459723; x=1694064523;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9AyfhzHra7t2MRcLpzWBb+I8SXAN6+InGALBZubFOkY=;
 b=THiTOTTu3nvXJzJhBgq8XDLBMSc9/J89VY7sOLVpJzvOSIKUMoXiqeshmjj3qqOTdk
 /ACy5GvaW0ITVRGh7hfTTPJYIWAqCkwggdJgtvenvKAxRK5gswggYoK9fbDFlxqasEAo
 2y//SZgGAemejgnEprYZzQW6FrzPliyEP8MDPFloiXokzW1NZeGx0PJsM72U0zOuJN0w
 TJUZ5NwZCP6MU4ES+k9YXFcybugllTSEjaOwAAtCmLNppHtdDULFsjXzH5N0kNoJJqhT
 eXLbDPGTrImHXSXcwLsw9AG2vpsekPD6pZ/DC4a/u/PCzRCxa4i5i8ki28WPF7PNY8Eg
 DufA==
X-Gm-Message-State: AOJu0YwvJscpDUIt3N2vcJVpqjdxsjxUrF/l2+43nTplISqNcUv+Kmut
 OFYSQGwpwQoNGSR5T6fKscCEsw==
X-Google-Smtp-Source: AGHT+IHU7IaSlIrTx9lR5kX/CGWTJPP37QJL+PV7PXdJc2icj012ep2Uzqi9BzFL2hHyCz//DQQVNg==
X-Received: by 2002:a17:902:d2c8:b0:1c1:ee23:bb75 with SMTP id
 n8-20020a170902d2c800b001c1ee23bb75mr4269362plc.1.1693459723446; 
 Wed, 30 Aug 2023 22:28:43 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:15e5:d5f9:7b14:839d])
 by smtp.gmail.com with ESMTPSA id
 x13-20020a170902820d00b001c0cb2aa2easm421171pln.121.2023.08.30.22.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 22:28:43 -0700 (PDT)
Date: Thu, 31 Aug 2023 14:28:40 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [RFC] make sandbox UT more generic
Message-ID: <ZPAlCLyi8eB+a6yP@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <ZO/g8T1ohHI23xM8@octopus>
 <CAPnjgZ32h4vtMiScP-4NKEVFCSYcYHV7=bKVSqT3mQSfDPQ=FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ32h4vtMiScP-4NKEVFCSYcYHV7=bKVSqT3mQSfDPQ=FA@mail.gmail.com>
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

On Wed, Aug 30, 2023 at 08:49:05PM -0600, Simon Glass wrote:
> Hi,
> 
> On Wed, 30 Aug 2023 at 18:38, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Hi,
> >
> > I'm working on implementing SCMI-based pinctrl/gpio driver,
> > and want to re-use sandbox UT to test the code. However,
> > It is somehow sandbox-specific (with additional DT nodes).
> > How can/should we make it more generic for other targets/drivers
> > rather than just by copying the test code?
> > (I have already created a test for pinmux since there is only
> > one existing scenario, but gpio test has many.)
> >
> > Even if I say 'generic', my case may be special since real
> > hardware (device drivers) cannot always run all the test cases,
> > while SCMI-based drivers potentially can with a dummy SCMI server
> > for sandbox.
> > See:
> >     drivers/firmware/scmi/sandbox-scmi_agent.c
> 
> We don't have a good way to test drivers that talk to hardware, in general.
> 
> For I2C, SPI and some PCI devices you can sometimes write an emulator
> for the chip and then your driver can talk to the emulator as if it
> were talking to the hardware. Sandbox does actually support that with
> memory-mapped I/O too, although it is fairly rarely used.

Well, I don't want or need to emulate some *real* hardware.
Instead, I would like to emulate what the current sandbox drivers
(pinctrl-sandbox.c and gpio/sandbox.c) emulate so that we can re-use
(some portion of) test cases for sandbox (test/dm/pinmux.c and gpio.c).

As you might know, SCMI protocol with associated drivers on U-Boot is
so generic that it would be able to talk to any of real pinctrl/gpio
drivers/firmware (say, run on OPTEE or SCP).
By implementing/mimicking protocol messages in sandbox-scmi_agent.c,
SCMI drivers are expected to provide *virtual* pinctrl/gpio devices
similar to what sandbox does.

I have already implemented pinmux test with some tweaks by copying
test/dm/pinmux.c and duplicating almost the same DT nodes as "pinctrl-gpio"
in test.dts.
But I'm looking for any other means without test code duplication.

Did I clarify my question a bit?

-Takahiro Akashi


> We have done this a lot with Zephyr, as well[1] and achieved 90% code
> coverage on some boards.
> 
> But I'm not quite sure I am answering the right question, so I will stop here.
> 
> Regards,
> Simon
> 
> [1] https://www.youtube.com/watch?v=usXCAXR2G_c
