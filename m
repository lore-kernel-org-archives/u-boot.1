Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D735AC52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 15:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23F3A88BCE;
	Fri,  9 Aug 2024 17:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WU9VzW6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AB2D88600; Fri,  9 Aug 2024 17:58:16 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00FA788BE1
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 17:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-44fe28eb1bfso12111131cf.0
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723219093; x=1723823893; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nr9YUXD437XhgWQn0POkbSOro8iXXiHB4gPlqVsSDNs=;
 b=WU9VzW6XrVP3UbinqYkiwf+24NYBlO+BMMKS3qWbWo5XqrpotMEAng/SYDAof3fu+q
 RNlACMudCKMdmx0Nhde5VwtbuxOwVShuN2A1Ry3tj/YSCv2U0cnbZD3Qpg5WUVMrvI6b
 VoImOoPD8rhaIf79qJtyK3pIl5IPeaKEqKCBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723219093; x=1723823893;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nr9YUXD437XhgWQn0POkbSOro8iXXiHB4gPlqVsSDNs=;
 b=ZaekniypyRCw5y6vPhqM4c6V96Gt2MlEG8V1bqxraEGZmFy8vQJ3jQ2yLXjU1/8p6U
 CZeaCmfJGDgEGOEUoqpVjs12pMRhJ6NDKgyR1AsTlhKaGqBYcUzuz1vzB0bViAp+OTiS
 +hYvZSxdU7E2OM0rBrC5cUs0woU570uzFdu6tWO35InufBBBJpUBXmm08vMlovIBPaPQ
 FfsscSn79YI8Jo1h1tg8NxqkLqgihEk9O9ZH4dSL6zM+uKNjDjGuhfCwz20Y30PahUWC
 MRl/oNdprT3//pg+jW+OYhYVjpgNU5biE0295SKxFjyQ25ESx3CSq2mJNWQPLA2vdQSf
 grkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrPub3cbAhEaUMiH6syRFsTCq9JNV+Bd+xY4h0gJmFu9YAivT2CfDpTag5/103odmb02uemcOKY/ygIiHnLNZu39LsIQ==
X-Gm-Message-State: AOJu0Yx1pVYQz8gtoALLfhEhPSmfa4I6ksj/sNgrVClKAUcI5zSjOiBx
 01bRFFl0px+UY1+c8uCeECmsha5mYLyeIGz384ZYcSg6Eo2DOWKBWITOiVE+FHXeu4UKJ15RRXP
 WOoyrZHHuM+XWpY0k/Z8mkYnlVh5rDaMT4zEc
X-Google-Smtp-Source: AGHT+IFioWeB4FhjQHtUF6+3LHL3ObGkiQ5JfipNRsBWQYbH3th3TF0lweHZ9Bp3ik62ufsny8zu9Cq2wjk00stLwHI=
X-Received: by 2002:a05:6214:4804:b0:6b7:d793:ae71 with SMTP id
 6a1803df08f44-6bd78d5f229mr23697956d6.25.1723219092791; Fri, 09 Aug 2024
 08:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240806120659.686073-1-prasad.kummari@amd.com>
 <CAFLszTgAiRBih1JOtqvBEi8QbVc4-yV7Mq3kam=_FRgw58mtjg@mail.gmail.com>
 <SJ0PR12MB66851EC7FDDD9A61A63E4DE982B82@SJ0PR12MB6685.namprd12.prod.outlook.com>
 <CAFLszTg9VemEeiHkOzh+jnQ84y34V3A+EPU2_YaOJgZwhn=7GQ@mail.gmail.com>
 <9aaf2326-2339-4d9a-b5b8-c5115e844599@amd.com>
 <CAFLszTgHsgJ6hP3FjLicHoiMAh--OCFLJtSUCVWiCukDBczoCw@mail.gmail.com>
 <59d3c644-350a-4325-8e64-c14f6649a60f@amd.com>
 <CAFLszTj5HW1NGaKgV51tCv-i-vSUR3btYcFbc3-WFsG8CJtFCg@mail.gmail.com>
 <cab33499-07f3-4833-836c-005f3ec67fbb@amd.com>
In-Reply-To: <cab33499-07f3-4833-836c-005f3ec67fbb@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Aug 2024 09:58:02 -0600
Message-ID: <CAFLszTipK435Oii=UuAUaFd4zXPvML8U88s9iCk13hOWL5N2jg@mail.gmail.com>
Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
To: Michal Simek <michal.simek@amd.com>
Cc: "Kummari, Prasad" <Prasad.Kummari@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "git (AMD-Xilinx)" <git@amd.com>, "Abbarapu,
 Venkatesh" <venkatesh.abbarapu@amd.com>, 
 "git@xilinx.com" <git@xilinx.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, 
 "n-francis@ti.com" <n-francis@ti.com>, "d-gole@ti.com" <d-gole@ti.com>,
 Love Kumar <love.kumar@amd.com>
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

Hi Michal,

On Fri, 9 Aug 2024 at 08:47, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 8/9/24 16:44, Simon Glass wrote:
> > Hi Michal,
> >
> > On Thu, 8 Aug 2024 at 23:39, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 8/8/24 16:28, Simon Glass wrote:
> >>> Hi Michal,
> >>>
> >>> On Wed, 7 Aug 2024 at 23:31, Michal Simek <michal.simek@amd.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 8/7/24 16:36, Simon Glass wrote:
> >>>>> Hi Prasad,
> >>>>>
> >>>>> On Tue, 6 Aug 2024 at 23:05, Kummari, Prasad <Prasad.Kummari@amd.com> wrote:
> >>>>>>
> >>>>>> Hi Glass,
> >>>>>>
> >>>>>>> -----Original Message-----
> >>>>>>> From: Simon Glass <sjg@chromium.org>
> >>>>>>> Sent: Wednesday, August 7, 2024 3:21 AM
> >>>>>>> To: Kummari, Prasad <Prasad.Kummari@amd.com>
> >>>>>>> Cc: u-boot@lists.denx.de; git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> >>>>>>> <michal.simek@amd.com>; Abbarapu, Venkatesh
> >>>>>>> <venkatesh.abbarapu@amd.com>; git@xilinx.com;
> >>>>>>> jagan@amarulasolutions.com; n-francis@ti.com; d-gole@ti.com
> >>>>>>> Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
> >>>>>>>
> >>>>>>> Caution: This message originated from an External Source. Use proper
> >>>>>>> caution when opening attachments, clicking links, or responding.
> >>>>>>>
> >>>>>>>
> >>>>>>> Hi Prasad,
> >>>>>>>
> >>>>>>> On Tue, 6 Aug 2024 at 06:08, Prasad Kummari <prasad.kummari@amd.com> wrote:
> >>>>>>>>
> >>>>>>>> Added LMB API to prevent SF command from overwriting reserved memory
> >>>>>>>> areas. The current SPI code does not use LMB APIs for loading data
> >>>>>>>> into memory addresses. To resolve this, LMB APIs were added to check
> >>>>>>>> the load address of an SF command and ensure it does not overwrite
> >>>>>>>> reserved memory addresses. Similar checks are used in TFTP, serial
> >>>>>>>> load, and boot code to prevent overwriting reserved memory.
> >>>>>>>
> >>>>>>> The SPI flash may be used to load other things, not just an OS. What is your
> >>>>>>> use case or problem here?
> >>>>>>
> >>>>>> [Prasad]:  We have observed that SF command can overwrite the reserved area without throwing any errors or warnings.
> >>>>>>     This issue was noticed when the TF-A area is reserved in the Device Tree at address 0xf000000. The sf command is
> >>>>>>     corrupting the reserved area,  and U-Boot relocation address too.
> >>>>>>
> >>>>>> EX: TF-A reserved at ddr address 0xf000000
> >>>>>>
> >>>>>>          Versal NET> sf read 0x0f000000 0x0 0x100     ----> Overwriting reserved area.
> >>>>>>          device 0 offset 0x0, size 0x100
> >>>>>>          SF: 256 bytes @ 0x0 Read: OK
> >>>>>>
> >>>>>>         U-boot relocation address relocaddr   = 0x000000007fec2000
> >>>>>>
> >>>>>>          Versal NET> sf write 0x0000000077ec2000 0x0 0x100   --> Overwriting reserved area.
> >>>>>>          device 0 offset 0x0, size 0x100
> >>>>>>          SF: 256 bytes @ 0x0 Written: OK
> >>>>>
> >>>>> Yes. There are many things which can overwrite memory, e.g. the mw
> >>>>> command. It is a boot loader so this is normal.
> >>>>>
> >>>>> What image are you loading here?
> >>>>
> >>>> In spi boot it can be Kernel/rootfs but at the end of day it doesn't really matter.
> >>>
> >>> OK, in that case yes it should use lmb. That was the question I was
> >>> trying to understand.
> >>>
> >>>>
> >>>> We have protection for srec, fs load, tftp and wget already.
> >>>>
> >>>> c6855195e4b4 ("loads: Block writes into LMB reserved areas of U-Boot")
> >>>> aa3c609e2be5 ("fs: prevent overwriting reserved memory")
> >>>> a156c47e39ad ("tftp: prevent overwriting reserved memory")
> >>>> 04592adbdb99 ("net: wget: prevent overwriting reserved memory")
> >>>>
> >>>> And this is just +1 patch to protect sf command that it doesn't touch reserved
> >>>> location.
> >>>> The same code should be used for other commands(nand, usb, etc) which loading
> >>>> block of data to memory because all of them shouldn't rewrite reserved memory.
> >>>>
> >>>> In connection to mw/mtest/etc command protection can be also done but not sure
> >>>> if this is useful because you normally not using them for booting.
> >>>
> >>> Exactly.
> >>>
> >>> I am hoping that we can pull SPI flash into bootstd...has anyone
> >>> looked at that? Are you using scripts or is there a special bootmeth?
> >>
> >> We didn't find this issue in connection to boot. As I wrote in another reply we
> >> found it via spi testcases where TF-A was placed lower in DDR and test overwrite
> >> it without any other evidence. Part of the reason is that protection units are
> >> not enabled to protect secure FW.
> >
> > Do you mean the sandbox test test/dm/sf.c ? Or something else? If the
> > former, then we could mark dm_test_spi_flash() with CONFIG_SANDBOX
>
> pytest one and I think it was this one.
> https://github.com/Xilinx/u-boot-xlnx/blob/master/test/py/tests/test_spi.py
>
> Love is working on sending this test upstream as he did with others.

OK. But why is TF-A low in RAM? We really need to have a think about
this TF-A thing. This is the second problem I've seen in a week (the
first was rockchip resetting the timer). Is there a spec for what TF-A
is supposed to do / not do?

Regards,
Simon
