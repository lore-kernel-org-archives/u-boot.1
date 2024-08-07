Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC748C52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F74288D16;
	Wed,  7 Aug 2024 16:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E1PZrkX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57DE788D2E; Wed,  7 Aug 2024 16:36:39 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C0EB88BE7
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7093705c708so1961876a34.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723041396; x=1723646196; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EJmf5vTBrOwjh0E/e9JMEO5+2G+KRNXu58sDHKOQieM=;
 b=E1PZrkX4ekUGbIN1VsdsEFLjhS9pFGs5Vd4X3xvJvLbBxPCQxoZsLg6lmiySCyRx8Y
 cCq81+sEaX+WdFMfd3fE7hCHVdPYlGwZNh/zjM7FMsLG3Xi1mT70LNfGIjzTCS7IM/RN
 h83EvvApQAIhJsHbkRIIV9MmEjbvIpX/Dr1vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723041396; x=1723646196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EJmf5vTBrOwjh0E/e9JMEO5+2G+KRNXu58sDHKOQieM=;
 b=E8/diKX1y3kqpd66Q++kzMP6YQ9XX14vmCplIk1c7BlpqfsdvU2J2M3ceLAoAow8dw
 HHfb71M37DYIWQGbRjNkumkV1T8tNaf5zNJlLMuotfDpkx5TQ4ASuoYYV8CpHavLalfa
 ryWHDMN1Q1ZR/17VHvA05P6i2JSKbLb/8nF5X7zi02mgl26fXDpudkjBKybb4zGwvtqI
 PjhOK1nKbX6eOtClGipKGtMrpbjUXEnRmuvP3CTLbyBXckYhn/8Mpf1KPTKxNDhsUZZh
 l1/yWWYGDDGTH+1FxfqGnfIw2X9Gec585aYPDzqQDfG7lPKGG8lXAoB2RtbxS+yIBj+o
 3s3Q==
X-Gm-Message-State: AOJu0YzsG7LQ3+jYhwXsBzYIPlVjrNb9uR9KoMpRgXUH9iNhEk6x/onm
 dS9mK54A623z+Q7F2E+Wo+caPPmGD/Xfg9OAaeBqgpndmgqIgi43b8q/aNlfsksz3+Pv9AgFVBt
 yYmPT33yjwGYntpBzYqU7P67TBLa3xF4o6WpX
X-Google-Smtp-Source: AGHT+IHqsBnGyWuKQ2C0Q5IVxmNZmz2K35FA9leBoIEwjh1KT4aS5eb4DQqbzSZZmJQmLOgMXeEZ8gnn45WqxniOGRg=
X-Received: by 2002:a05:6830:700c:b0:709:4bc5:a016 with SMTP id
 46e09a7af769-709b995c59cmr28653127a34.25.1723041395894; Wed, 07 Aug 2024
 07:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240806120659.686073-1-prasad.kummari@amd.com>
 <CAFLszTgAiRBih1JOtqvBEi8QbVc4-yV7Mq3kam=_FRgw58mtjg@mail.gmail.com>
 <SJ0PR12MB66851EC7FDDD9A61A63E4DE982B82@SJ0PR12MB6685.namprd12.prod.outlook.com>
In-Reply-To: <SJ0PR12MB66851EC7FDDD9A61A63E4DE982B82@SJ0PR12MB6685.namprd12.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Aug 2024 08:36:25 -0600
Message-ID: <CAFLszTg9VemEeiHkOzh+jnQ84y34V3A+EPU2_YaOJgZwhn=7GQ@mail.gmail.com>
Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
To: "Kummari, Prasad" <Prasad.Kummari@amd.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "git (AMD-Xilinx)" <git@amd.com>, 
 "Simek, Michal" <michal.simek@amd.com>, "Abbarapu,
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

Hi Prasad,

On Tue, 6 Aug 2024 at 23:05, Kummari, Prasad <Prasad.Kummari@amd.com> wrote:
>
> Hi Glass,
>
> > -----Original Message-----
> > From: Simon Glass <sjg@chromium.org>
> > Sent: Wednesday, August 7, 2024 3:21 AM
> > To: Kummari, Prasad <Prasad.Kummari@amd.com>
> > Cc: u-boot@lists.denx.de; git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> > <michal.simek@amd.com>; Abbarapu, Venkatesh
> > <venkatesh.abbarapu@amd.com>; git@xilinx.com;
> > jagan@amarulasolutions.com; n-francis@ti.com; d-gole@ti.com
> > Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > Hi Prasad,
> >
> > On Tue, 6 Aug 2024 at 06:08, Prasad Kummari <prasad.kummari@amd.com> wrote:
> > >
> > > Added LMB API to prevent SF command from overwriting reserved memory
> > > areas. The current SPI code does not use LMB APIs for loading data
> > > into memory addresses. To resolve this, LMB APIs were added to check
> > > the load address of an SF command and ensure it does not overwrite
> > > reserved memory addresses. Similar checks are used in TFTP, serial
> > > load, and boot code to prevent overwriting reserved memory.
> >
> > The SPI flash may be used to load other things, not just an OS. What is your
> > use case or problem here?
>
> [Prasad]:  We have observed that SF command can overwrite the reserved area without throwing any errors or warnings.
>  This issue was noticed when the TF-A area is reserved in the Device Tree at address 0xf000000. The sf command is
>  corrupting the reserved area,  and U-Boot relocation address too.
>
> EX: TF-A reserved at ddr address 0xf000000
>
>       Versal NET> sf read 0x0f000000 0x0 0x100     ----> Overwriting reserved area.
>       device 0 offset 0x0, size 0x100
>       SF: 256 bytes @ 0x0 Read: OK
>
>      U-boot relocation address relocaddr   = 0x000000007fec2000
>
>       Versal NET> sf write 0x0000000077ec2000 0x0 0x100   --> Overwriting reserved area.
>       device 0 offset 0x0, size 0x100
>       SF: 256 bytes @ 0x0 Written: OK

Yes. There are many things which can overwrite memory, e.g. the mw
command. It is a boot loader so this is normal.

What image are you loading here?

Regards,
Simon
