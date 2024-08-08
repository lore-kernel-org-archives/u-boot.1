Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DAAC52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 14:28:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1E4988A74;
	Thu,  8 Aug 2024 16:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l5le955h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1054D88A6B; Thu,  8 Aug 2024 16:28:15 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA3248896F
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 16:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-709346604a7so430512a34.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723127291; x=1723732091; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o/76PqbuocqvcZD41bIw1PLF2dHEA90+P4oVvFjh3Bg=;
 b=l5le955hLaotxb5y/xXs6NIER6vIFcTs21tLF4smfhlaKUXdpwrK9N86HamsZpndxY
 oWQKFOArx/vL6rDGhYGMJpnMksN6Dn4BXwloZ6Jl9LolyC/r44wFS1fuKfNPvAs6ge3X
 sxZblkZhIJvUCbFXNfBGETb3lRGB3JaFSx2bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723127291; x=1723732091;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o/76PqbuocqvcZD41bIw1PLF2dHEA90+P4oVvFjh3Bg=;
 b=nBMn07Lbmxx8J1WjPkToKfw0MfoX+NG7w7I84OlVAKVHFQ0H+jTQVz9lrk7cgbuKGw
 Dr4W0eX/Ol8gt89kiTTTFyH3nC9EPK4UOMYHnevf4+1XtzUcuY64XBFtAeQXd4TsyVzF
 QALlOZNYYKLoQ+z2pr6oQG/QV6ROUYQW2HeDr195Vlr4WQzESB4fUfk0O2mIZXUswqZ/
 98ULkWJcueSMUdOgw05CytTm6APTijYIPGHVbOHUTU7/UFxEMUxcAcLk5xJsZP9QKRVj
 iqsvSreSIsFvlYkW3V4bNih/R3uJ2Stka0/mrN8ZDSVsdJbUrTJCBanQAUk+TS1SzewT
 JbVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFyTpeMHHcNdtWXCS6o7hRWdcWxy9CLSdBZeoFaB9WMIprUQr4ripYU7yKqev+DXBlA9bXCVTCjLf9cyaBVqmJO6EoTg==
X-Gm-Message-State: AOJu0Yz3JBe5wDnFNz9sTdgDBYr61tmvY9ZaTW14o56d30lXDnrXqJ2s
 RSMzz2tqwBF7CwAa94VoqD/TAvC4wD/tjzUWIzYBfjsR72Wvnt/So3jU7J372wD0+PJ12BPQk2z
 umqSPb1CQZlaMUmd8E1d4Kxnb/ZFk2iIxsDVP
X-Google-Smtp-Source: AGHT+IE+gNi+bJmeCSovKP+/d9YbuT759DTBZMO/34dKye8UWBYkQs17OpHdROSJwPH5Ru6Th9JziQRh2Qii6guIdXU=
X-Received: by 2002:a05:6830:6011:b0:709:47a6:627c with SMTP id
 46e09a7af769-70b4fc22248mr2484124a34.4.1723127291249; Thu, 08 Aug 2024
 07:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240806120659.686073-1-prasad.kummari@amd.com>
 <CAFLszTgAiRBih1JOtqvBEi8QbVc4-yV7Mq3kam=_FRgw58mtjg@mail.gmail.com>
 <SJ0PR12MB66851EC7FDDD9A61A63E4DE982B82@SJ0PR12MB6685.namprd12.prod.outlook.com>
 <CAFLszTg9VemEeiHkOzh+jnQ84y34V3A+EPU2_YaOJgZwhn=7GQ@mail.gmail.com>
 <9aaf2326-2339-4d9a-b5b8-c5115e844599@amd.com>
In-Reply-To: <9aaf2326-2339-4d9a-b5b8-c5115e844599@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Aug 2024 08:28:00 -0600
Message-ID: <CAFLszTgHsgJ6hP3FjLicHoiMAh--OCFLJtSUCVWiCukDBczoCw@mail.gmail.com>
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

On Wed, 7 Aug 2024 at 23:31, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 8/7/24 16:36, Simon Glass wrote:
> > Hi Prasad,
> >
> > On Tue, 6 Aug 2024 at 23:05, Kummari, Prasad <Prasad.Kummari@amd.com> wrote:
> >>
> >> Hi Glass,
> >>
> >>> -----Original Message-----
> >>> From: Simon Glass <sjg@chromium.org>
> >>> Sent: Wednesday, August 7, 2024 3:21 AM
> >>> To: Kummari, Prasad <Prasad.Kummari@amd.com>
> >>> Cc: u-boot@lists.denx.de; git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> >>> <michal.simek@amd.com>; Abbarapu, Venkatesh
> >>> <venkatesh.abbarapu@amd.com>; git@xilinx.com;
> >>> jagan@amarulasolutions.com; n-francis@ti.com; d-gole@ti.com
> >>> Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
> >>>
> >>> Caution: This message originated from an External Source. Use proper
> >>> caution when opening attachments, clicking links, or responding.
> >>>
> >>>
> >>> Hi Prasad,
> >>>
> >>> On Tue, 6 Aug 2024 at 06:08, Prasad Kummari <prasad.kummari@amd.com> wrote:
> >>>>
> >>>> Added LMB API to prevent SF command from overwriting reserved memory
> >>>> areas. The current SPI code does not use LMB APIs for loading data
> >>>> into memory addresses. To resolve this, LMB APIs were added to check
> >>>> the load address of an SF command and ensure it does not overwrite
> >>>> reserved memory addresses. Similar checks are used in TFTP, serial
> >>>> load, and boot code to prevent overwriting reserved memory.
> >>>
> >>> The SPI flash may be used to load other things, not just an OS. What is your
> >>> use case or problem here?
> >>
> >> [Prasad]:  We have observed that SF command can overwrite the reserved area without throwing any errors or warnings.
> >>   This issue was noticed when the TF-A area is reserved in the Device Tree at address 0xf000000. The sf command is
> >>   corrupting the reserved area,  and U-Boot relocation address too.
> >>
> >> EX: TF-A reserved at ddr address 0xf000000
> >>
> >>        Versal NET> sf read 0x0f000000 0x0 0x100     ----> Overwriting reserved area.
> >>        device 0 offset 0x0, size 0x100
> >>        SF: 256 bytes @ 0x0 Read: OK
> >>
> >>       U-boot relocation address relocaddr   = 0x000000007fec2000
> >>
> >>        Versal NET> sf write 0x0000000077ec2000 0x0 0x100   --> Overwriting reserved area.
> >>        device 0 offset 0x0, size 0x100
> >>        SF: 256 bytes @ 0x0 Written: OK
> >
> > Yes. There are many things which can overwrite memory, e.g. the mw
> > command. It is a boot loader so this is normal.
> >
> > What image are you loading here?
>
> In spi boot it can be Kernel/rootfs but at the end of day it doesn't really matter.

OK, in that case yes it should use lmb. That was the question I was
trying to understand.

>
> We have protection for srec, fs load, tftp and wget already.
>
> c6855195e4b4 ("loads: Block writes into LMB reserved areas of U-Boot")
> aa3c609e2be5 ("fs: prevent overwriting reserved memory")
> a156c47e39ad ("tftp: prevent overwriting reserved memory")
> 04592adbdb99 ("net: wget: prevent overwriting reserved memory")
>
> And this is just +1 patch to protect sf command that it doesn't touch reserved
> location.
> The same code should be used for other commands(nand, usb, etc) which loading
> block of data to memory because all of them shouldn't rewrite reserved memory.
>
> In connection to mw/mtest/etc command protection can be also done but not sure
> if this is useful because you normally not using them for booting.

Exactly.

I am hoping that we can pull SPI flash into bootstd...has anyone
looked at that? Are you using scripts or is there a special bootmeth?

Regards,
Simon
