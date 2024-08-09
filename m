Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806B0C52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 14:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BE8C88BE1;
	Fri,  9 Aug 2024 16:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gOmRGt7Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D0DD88BDC; Fri,  9 Aug 2024 16:44:20 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5404188BC4
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 16:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6b79c27dd01so12176986d6.3
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723214657; x=1723819457; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8/KQhw5ZoGPUZkHIZhT/Uo8Lj1nLCSeKlTlhW8ZwtWM=;
 b=gOmRGt7Qnvan5F8IMvKox8ucui+kj3I9hpWQXKbBTzj4eghY7T9dgC614XKhFhj0tC
 pqMUQyivJ0ycXXM5E8JKAJk6zfr9WQR3XLRanwAd5qWKwp8wv5O4LD7ib/KG9pyrg0x9
 10MIrkskiNY3JXu2z3vv5sb52lguA+O7p28xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723214657; x=1723819457;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8/KQhw5ZoGPUZkHIZhT/Uo8Lj1nLCSeKlTlhW8ZwtWM=;
 b=koL0b+ez/yUZalShzhBS3mzLWNSM/mxedwqrt3B4IsWSsV3h7Hets8321JPB4wXQPM
 862LGAd0BiGfe5LZgX/gG6jDvx7oiwck0QK0RRdXwkQYREUASnhcI84mXKiybZC0Xa3K
 r13j4S8G1gsS+C6BVlbPUJFkhPpikoENntNoYcqgrV0Ynkyj9NeiBcpO30Fv1wxpwZPH
 sPQK2DdxeGFcChqiEmAp6XCd/0vzwLQF65EDaaJYSZAOOf6aeCyVpwzg9CglDC9yqTDS
 qXmqY3ty2qFi3Z/dahXbvilYvbCC57r/u2vg+0PMpq5ikqPTE8KKVOm8/uBanevUYO39
 5Mdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLbXAfDbu5jctwuCA1kDgmQNc1vyOzKThPD1kIYCHjeLNjdJa3Jkasug9QLxoF29U+ZUoFLxbQ0mpTDFB93rCxzYC//A==
X-Gm-Message-State: AOJu0Yy8FdkH3km0CM8GOJeP6CcsyJvjoUQZUDERxj4aMWc7u0sfBfnQ
 i7h5TIllAY3wuJjdvIXquSrkXTc2oHs53ojxoKlVbWA2atwsHGlLSyxrgoYUIrAuwXwkE4z1xOq
 NJT1NPph2kWoC3f00wTHRSEiRrniC4rxAnmvV
X-Google-Smtp-Source: AGHT+IEhYWFNPd4pvWm+HXiUmTlxwPE0YfkKTqBWAqw0PqgyY2o5PRpbPhR1k+3Tdckdc5xM4taaJN68ZDiGfCdKC9c=
X-Received: by 2002:a05:6214:390a:b0:6bb:52ee:71bd with SMTP id
 6a1803df08f44-6bd78edfe46mr16841826d6.57.1723214657129; Fri, 09 Aug 2024
 07:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240806120659.686073-1-prasad.kummari@amd.com>
 <CAFLszTgAiRBih1JOtqvBEi8QbVc4-yV7Mq3kam=_FRgw58mtjg@mail.gmail.com>
 <SJ0PR12MB66851EC7FDDD9A61A63E4DE982B82@SJ0PR12MB6685.namprd12.prod.outlook.com>
 <CAFLszTg9VemEeiHkOzh+jnQ84y34V3A+EPU2_YaOJgZwhn=7GQ@mail.gmail.com>
 <9aaf2326-2339-4d9a-b5b8-c5115e844599@amd.com>
 <CAFLszTgHsgJ6hP3FjLicHoiMAh--OCFLJtSUCVWiCukDBczoCw@mail.gmail.com>
 <59d3c644-350a-4325-8e64-c14f6649a60f@amd.com>
In-Reply-To: <59d3c644-350a-4325-8e64-c14f6649a60f@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Aug 2024 08:44:06 -0600
Message-ID: <CAFLszTj5HW1NGaKgV51tCv-i-vSUR3btYcFbc3-WFsG8CJtFCg@mail.gmail.com>
Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
To: Michal Simek <michal.simek@amd.com>
Cc: "Kummari, Prasad" <Prasad.Kummari@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "git (AMD-Xilinx)" <git@amd.com>, "Abbarapu,
 Venkatesh" <venkatesh.abbarapu@amd.com>, 
 "git@xilinx.com" <git@xilinx.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, 
 "n-francis@ti.com" <n-francis@ti.com>, "d-gole@ti.com" <d-gole@ti.com>
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

On Thu, 8 Aug 2024 at 23:39, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi Simon,
>
> On 8/8/24 16:28, Simon Glass wrote:
> > Hi Michal,
> >
> > On Wed, 7 Aug 2024 at 23:31, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >>
> >>
> >> On 8/7/24 16:36, Simon Glass wrote:
> >>> Hi Prasad,
> >>>
> >>> On Tue, 6 Aug 2024 at 23:05, Kummari, Prasad <Prasad.Kummari@amd.com> wrote:
> >>>>
> >>>> Hi Glass,
> >>>>
> >>>>> -----Original Message-----
> >>>>> From: Simon Glass <sjg@chromium.org>
> >>>>> Sent: Wednesday, August 7, 2024 3:21 AM
> >>>>> To: Kummari, Prasad <Prasad.Kummari@amd.com>
> >>>>> Cc: u-boot@lists.denx.de; git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> >>>>> <michal.simek@amd.com>; Abbarapu, Venkatesh
> >>>>> <venkatesh.abbarapu@amd.com>; git@xilinx.com;
> >>>>> jagan@amarulasolutions.com; n-francis@ti.com; d-gole@ti.com
> >>>>> Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
> >>>>>
> >>>>> Caution: This message originated from an External Source. Use proper
> >>>>> caution when opening attachments, clicking links, or responding.
> >>>>>
> >>>>>
> >>>>> Hi Prasad,
> >>>>>
> >>>>> On Tue, 6 Aug 2024 at 06:08, Prasad Kummari <prasad.kummari@amd.com> wrote:
> >>>>>>
> >>>>>> Added LMB API to prevent SF command from overwriting reserved memory
> >>>>>> areas. The current SPI code does not use LMB APIs for loading data
> >>>>>> into memory addresses. To resolve this, LMB APIs were added to check
> >>>>>> the load address of an SF command and ensure it does not overwrite
> >>>>>> reserved memory addresses. Similar checks are used in TFTP, serial
> >>>>>> load, and boot code to prevent overwriting reserved memory.
> >>>>>
> >>>>> The SPI flash may be used to load other things, not just an OS. What is your
> >>>>> use case or problem here?
> >>>>
> >>>> [Prasad]:  We have observed that SF command can overwrite the reserved area without throwing any errors or warnings.
> >>>>    This issue was noticed when the TF-A area is reserved in the Device Tree at address 0xf000000. The sf command is
> >>>>    corrupting the reserved area,  and U-Boot relocation address too.
> >>>>
> >>>> EX: TF-A reserved at ddr address 0xf000000
> >>>>
> >>>>         Versal NET> sf read 0x0f000000 0x0 0x100     ----> Overwriting reserved area.
> >>>>         device 0 offset 0x0, size 0x100
> >>>>         SF: 256 bytes @ 0x0 Read: OK
> >>>>
> >>>>        U-boot relocation address relocaddr   = 0x000000007fec2000
> >>>>
> >>>>         Versal NET> sf write 0x0000000077ec2000 0x0 0x100   --> Overwriting reserved area.
> >>>>         device 0 offset 0x0, size 0x100
> >>>>         SF: 256 bytes @ 0x0 Written: OK
> >>>
> >>> Yes. There are many things which can overwrite memory, e.g. the mw
> >>> command. It is a boot loader so this is normal.
> >>>
> >>> What image are you loading here?
> >>
> >> In spi boot it can be Kernel/rootfs but at the end of day it doesn't really matter.
> >
> > OK, in that case yes it should use lmb. That was the question I was
> > trying to understand.
> >
> >>
> >> We have protection for srec, fs load, tftp and wget already.
> >>
> >> c6855195e4b4 ("loads: Block writes into LMB reserved areas of U-Boot")
> >> aa3c609e2be5 ("fs: prevent overwriting reserved memory")
> >> a156c47e39ad ("tftp: prevent overwriting reserved memory")
> >> 04592adbdb99 ("net: wget: prevent overwriting reserved memory")
> >>
> >> And this is just +1 patch to protect sf command that it doesn't touch reserved
> >> location.
> >> The same code should be used for other commands(nand, usb, etc) which loading
> >> block of data to memory because all of them shouldn't rewrite reserved memory.
> >>
> >> In connection to mw/mtest/etc command protection can be also done but not sure
> >> if this is useful because you normally not using them for booting.
> >
> > Exactly.
> >
> > I am hoping that we can pull SPI flash into bootstd...has anyone
> > looked at that? Are you using scripts or is there a special bootmeth?
>
> We didn't find this issue in connection to boot. As I wrote in another reply we
> found it via spi testcases where TF-A was placed lower in DDR and test overwrite
> it without any other evidence. Part of the reason is that protection units are
> not enabled to protect secure FW.

Do you mean the sandbox test test/dm/sf.c ? Or something else? If the
former, then we could mark dm_test_spi_flash() with CONFIG_SANDBOX

Regards,
Simon
