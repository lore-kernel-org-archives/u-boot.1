Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAFBCD3420
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1C8F88C8A;
	Sun,  1 Sep 2024 22:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y+qoTtM1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF3B888C6D; Sun,  1 Sep 2024 22:10:23 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4CE588C3F
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7cd967d8234so2130367a12.2
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221418; x=1725826218; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MQHyKaoJSkyD4Ua+V51exR7NeyRvhzWy3guPj6gcpOM=;
 b=Y+qoTtM13NNJWK5VSXOqGySHbHSIVpbW/vWOepSfKTlICcY+vBiroBoSjMj/EeiNuj
 b+r5Cdvf60rtazcr+wthcEAfVlV11OUSCVijaswjCMJsAWl9gN7OIiX/pBnGaK9exLIA
 0JZehRddJ0AYbzkJ6wua1WCgdYW696y6KJfMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221418; x=1725826218;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MQHyKaoJSkyD4Ua+V51exR7NeyRvhzWy3guPj6gcpOM=;
 b=uW8qPnNo3FWL8MhkHJeMmi03YSnF93Fh3jNY1p6v141xp/m+4f4DBug5UjNqrSU0Tb
 mQ+jQkY5rAqu9F3E7CpNih13e2MTv9tWLImNQKZ8WvwfwTuHRAmw16057rKmQklyxdLi
 2R3q3Vl+nplGDShEKE3NoPi52oppa3+1DQSw8XEfdmGccQ556BnhUpkrZLVbmjRW7o15
 hpuoAOQLn70mLozS0QF+u8A7C9lmEw5EYhKfGp4WxDEjl1n4KYDkwA7ufya4dXoC6SMp
 EGavnpOeVFfmcCO9U0D+kLk0FaUTpxRio0gPjQmQK2p9IfY95cjF0IsWsUtniCWcHafI
 qXCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6JmbDlrQiR9zmtZU5VolwPS3uF6ZJlm4SpDmazsF4t8hOx2wQu9bTl31aQbVLMPv/0szx9B0=@lists.denx.de
X-Gm-Message-State: AOJu0YycOY8vzIkveMdU3EF1tJNd25V6MX8+UtBU1ZC6OKVERA9XCnjD
 XU3m13trtX/0lZ3Tp58n1NtdSYvLtYZEUsZXCnSr7Za7y0m1mR6EEH7T8Tj0mEKp3k6hoUrO18+
 3S9ZUSwV9vIVSsFGM3IBpDkUVCI16YEZZOkAX
X-Google-Smtp-Source: AGHT+IEKhTqxxD6/D4sjzWHwE1JSFIz2/8VmKWR4KIft3HJZ3Ff46QPg3YvqTlC3gZrlq4zkEY0oSCjySdjen61p3gs=
X-Received: by 2002:a05:6a21:2d8d:b0:1cc:d2d9:b408 with SMTP id
 adf61e73a8af0-1ced0439cffmr4116659637.3.1725221418062; Sun, 01 Sep 2024
 13:10:18 -0700 (PDT)
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
 <CAFLszTipK435Oii=UuAUaFd4zXPvML8U88s9iCk13hOWL5N2jg@mail.gmail.com>
 <ae9343ac-a862-4a7b-ab8f-dbc4ae5433e4@amd.com>
In-Reply-To: <ae9343ac-a862-4a7b-ab8f-dbc4ae5433e4@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:10:06 -0600
Message-ID: <CAFLszTg9WYPVTrVBbJ_U4yrYWuYDN8+Wtzr=TC9LOs-QKqVxgw@mail.gmail.com>
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

On Mon, 26 Aug 2024 at 02:48, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi Simon,
>
> On 8/9/24 17:58, Simon Glass wrote:
> > Hi Michal,
> >
> > On Fri, 9 Aug 2024 at 08:47, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >>
> >>
> >> On 8/9/24 16:44, Simon Glass wrote:
> >>> Hi Michal,
> >>>
> >>> On Thu, 8 Aug 2024 at 23:39, Michal Simek <michal.simek@amd.com> wrote:
> >>>>
> >>>> Hi Simon,
> >>>>
> >>>> On 8/8/24 16:28, Simon Glass wrote:
> >>>>> Hi Michal,
> >>>>>
> >>>>> On Wed, 7 Aug 2024 at 23:31, Michal Simek <michal.simek@amd.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 8/7/24 16:36, Simon Glass wrote:
> >>>>>>> Hi Prasad,
> >>>>>>>
> >>>>>>> On Tue, 6 Aug 2024 at 23:05, Kummari, Prasad <Prasad.Kummari@amd.com> wrote:
> >>>>>>>>
> >>>>>>>> Hi Glass,
> >>>>>>>>
> >>>>>>>>> -----Original Message-----
> >>>>>>>>> From: Simon Glass <sjg@chromium.org>
> >>>>>>>>> Sent: Wednesday, August 7, 2024 3:21 AM
> >>>>>>>>> To: Kummari, Prasad <Prasad.Kummari@amd.com>
> >>>>>>>>> Cc: u-boot@lists.denx.de; git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> >>>>>>>>> <michal.simek@amd.com>; Abbarapu, Venkatesh
> >>>>>>>>> <venkatesh.abbarapu@amd.com>; git@xilinx.com;
> >>>>>>>>> jagan@amarulasolutions.com; n-francis@ti.com; d-gole@ti.com
> >>>>>>>>> Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
> >>>>>>>>>
> >>>>>>>>> Caution: This message originated from an External Source. Use proper
> >>>>>>>>> caution when opening attachments, clicking links, or responding.
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Hi Prasad,
> >>>>>>>>>
> >>>>>>>>> On Tue, 6 Aug 2024 at 06:08, Prasad Kummari <prasad.kummari@amd.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> Added LMB API to prevent SF command from overwriting reserved memory
> >>>>>>>>>> areas. The current SPI code does not use LMB APIs for loading data
> >>>>>>>>>> into memory addresses. To resolve this, LMB APIs were added to check
> >>>>>>>>>> the load address of an SF command and ensure it does not overwrite
> >>>>>>>>>> reserved memory addresses. Similar checks are used in TFTP, serial
> >>>>>>>>>> load, and boot code to prevent overwriting reserved memory.
> >>>>>>>>>
> >>>>>>>>> The SPI flash may be used to load other things, not just an OS. What is your
> >>>>>>>>> use case or problem here?
> >>>>>>>>
> >>>>>>>> [Prasad]:  We have observed that SF command can overwrite the reserved area without throwing any errors or warnings.
> >>>>>>>>      This issue was noticed when the TF-A area is reserved in the Device Tree at address 0xf000000. The sf command is
> >>>>>>>>      corrupting the reserved area,  and U-Boot relocation address too.
> >>>>>>>>
> >>>>>>>> EX: TF-A reserved at ddr address 0xf000000
> >>>>>>>>
> >>>>>>>>           Versal NET> sf read 0x0f000000 0x0 0x100     ----> Overwriting reserved area.
> >>>>>>>>           device 0 offset 0x0, size 0x100
> >>>>>>>>           SF: 256 bytes @ 0x0 Read: OK
> >>>>>>>>
> >>>>>>>>          U-boot relocation address relocaddr   = 0x000000007fec2000
> >>>>>>>>
> >>>>>>>>           Versal NET> sf write 0x0000000077ec2000 0x0 0x100   --> Overwriting reserved area.
> >>>>>>>>           device 0 offset 0x0, size 0x100
> >>>>>>>>           SF: 256 bytes @ 0x0 Written: OK
> >>>>>>>
> >>>>>>> Yes. There are many things which can overwrite memory, e.g. the mw
> >>>>>>> command. It is a boot loader so this is normal.
> >>>>>>>
> >>>>>>> What image are you loading here?
> >>>>>>
> >>>>>> In spi boot it can be Kernel/rootfs but at the end of day it doesn't really matter.
> >>>>>
> >>>>> OK, in that case yes it should use lmb. That was the question I was
> >>>>> trying to understand.
> >>>>>
> >>>>>>
> >>>>>> We have protection for srec, fs load, tftp and wget already.
> >>>>>>
> >>>>>> c6855195e4b4 ("loads: Block writes into LMB reserved areas of U-Boot")
> >>>>>> aa3c609e2be5 ("fs: prevent overwriting reserved memory")
> >>>>>> a156c47e39ad ("tftp: prevent overwriting reserved memory")
> >>>>>> 04592adbdb99 ("net: wget: prevent overwriting reserved memory")
> >>>>>>
> >>>>>> And this is just +1 patch to protect sf command that it doesn't touch reserved
> >>>>>> location.
> >>>>>> The same code should be used for other commands(nand, usb, etc) which loading
> >>>>>> block of data to memory because all of them shouldn't rewrite reserved memory.
> >>>>>>
> >>>>>> In connection to mw/mtest/etc command protection can be also done but not sure
> >>>>>> if this is useful because you normally not using them for booting.
> >>>>>
> >>>>> Exactly.
> >>>>>
> >>>>> I am hoping that we can pull SPI flash into bootstd...has anyone
> >>>>> looked at that? Are you using scripts or is there a special bootmeth?
> >>>>
> >>>> We didn't find this issue in connection to boot. As I wrote in another reply we
> >>>> found it via spi testcases where TF-A was placed lower in DDR and test overwrite
> >>>> it without any other evidence. Part of the reason is that protection units are
> >>>> not enabled to protect secure FW.
> >>>
> >>> Do you mean the sandbox test test/dm/sf.c ? Or something else? If the
> >>> former, then we could mark dm_test_spi_flash() with CONFIG_SANDBOX
> >>
> >> pytest one and I think it was this one.
> >> https://github.com/Xilinx/u-boot-xlnx/blob/master/test/py/tests/test_spi.py
> >>
> >> Love is working on sending this test upstream as he did with others.
> >
> > OK. But why is TF-A low in RAM? We really need to have a think about
> > this TF-A thing. This is the second problem I've seen in a week (the
> > first was rockchip resetting the timer). Is there a spec for what TF-A
> > is supposed to do / not do?
>
> It is user choice where they put trusted firmware.
> All depends on their application. Normally TF-A is in OCM but some users can
> have a need to use OCM for user application because for example it is much
> faster than DDR.
>
> Not sure if there is any official spec but documentation is here.
> https://trustedfirmware-a.readthedocs.io/en/latest/
>
> But this issue is not related to TF-A. It is just the way how we found it based
> on our partitioning.
> Because DDR can be partitioned for Secure OS, different cpus (RPUs in our case)
> or for processing units(MB/Risc-V/other masters) running out of programmable
> logic. In general when you are reserved location for whatever reason all loading
> commands shouldn't use them.

OK thanks for the info.

Regards,
Simon
