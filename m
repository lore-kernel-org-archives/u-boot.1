Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC35C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 10:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 900B488228;
	Fri, 24 May 2024 12:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fh3JkI2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B9928822F; Fri, 24 May 2024 12:07:57 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B7E887DCD
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 12:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f44b42e9a6so4405225ad.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 03:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716545274; x=1717150074; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mRyrTDbe9ssgJH45VEWOQPFd3486kYxx+36HFqwvcFc=;
 b=fh3JkI2hdgBtFbQIn3z3KonjsRcsCeUYUQTeieQNyFEpgIuO2hh27JZ8o/23RoThnc
 ucdwUwq8lmoYEfCdvlGEN4P2OyIXb+lkwiUNr4vS6dhVMuJdv+kVUmFtnWLxE7QOydvK
 JDmngIQ2r8KQ+Zy1DxU3uy4Uiic25DsUHBYiBL/OU0RMpY6iDkQaiOalmXCZoE85y+hA
 HPNagLI/m78nmvNpcZ7Y3jSRT4AFhV4md7994I8qJTm7lFlQDlfjM2aPw1pQzagCe18J
 YTuiERvLWsz6l0dMrZDzwYe2b/pHsujkAgZ4wKr5Y4F4gbLFiefZt1oMdE5VaKlQ9u86
 8cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716545274; x=1717150074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mRyrTDbe9ssgJH45VEWOQPFd3486kYxx+36HFqwvcFc=;
 b=qKXNBIbOZeD1t5M46zz5Z/KwE6i0gvLlOJ38QYPGObZbE/B2Dgi1VY+1YsVJWNeOpM
 XsbqXS1uSpD1yNNhpDAaVMgE4f6e2ASnWFVOS5r0TWGhk8DjlJXl2aUv55SqWpV068/+
 fQp4vdWJuL8JTk7f4nWRN47lhXGkWBBlTpyfnVr/Jxde1q1tdS1pjBEGlSw1jISJ4IMk
 18QADfCK3KoIqzi/j0lWy+dai8pvlAgeU2KMeWFs3mV3uHB2nSdwM/l9Wn4VBRXEwl3a
 LAzUXXznOJgtjxCB5IMEaLZ+e5BGBfLovpK6BEBvgvK6VHQfODzUrXi7rBSxURjgYnNk
 TQJQ==
X-Gm-Message-State: AOJu0YzNtaN9tNutKE9ai/ECOJJ6MGymZndmzhU2bWJ+ASrEj38TaXf7
 GM71D5wlCDCJ0cBk/DYOnx8k07P4UR8GSfvtqBnNjImNnQ1nH7eCe1whYR6u7oGQyQ9R9Tcgihp
 nKCtJPLB/O7zxLdRPZkq5J4J8yEeknPGuHMMFuw==
X-Google-Smtp-Source: AGHT+IHTf3xmE1FgacxPQcjIIdyIrWlocbS7iIupXEDtyLQtvd/YNMQGtORbwimgEPAnTm7RPmTVuXHoTTrS9TicHs0=
X-Received: by 2002:a05:6a21:3282:b0:1af:f949:30c7 with SMTP id
 adf61e73a8af0-1b212d0a2acmr1904096637.14.1716545273866; Fri, 24 May 2024
 03:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1714138688.git.michal.simek@amd.com>
 <66a52861-6203-4b6f-940e-52e21abfbb1a@amd.com>
In-Reply-To: <66a52861-6203-4b6f-940e-52e21abfbb1a@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 24 May 2024 13:07:17 +0300
Message-ID: <CAC_iWjJzTrTSFNmnRcXH2JoPK5EB1bNgBzbHLvyEy0-JxQ-E2A@mail.gmail.com>
Subject: Re: [PATCH 0/3] lib: smbios: Extend driver with using sysinfo driver
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, 
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

Hi Michal


On Fri, 24 May 2024 at 12:45, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi Ilias,
>
> On 4/26/24 15:38, Michal Simek wrote:
> > Hi,
> >
> > currently only DT way is supported and it is added directly to lib/smbios.c
> > but I think DT and env is only one way how information can be found that's
> > why this series is improving handling with using sysinfo driver which can
> > be platform specific.
> > At the end of day DT should be taken from smbios.c and put to sysinfo DT
> > driver instead of implementing it directly in this generic file.
> >
> > Thanks,
> > Michal
> >
> >
> > Michal Simek (3):
> >    xilinx: Enable SMBIOS command
> >    lib: smbios: Let detect the system via sysinfo
> >    lib: smbios: Detect system properties via SYSINFO IDs
> >
> >   configs/xilinx_versal_net_virt_defconfig |  1 +
> >   configs/xilinx_versal_virt_defconfig     |  1 +
> >   configs/xilinx_zynqmp_kria_defconfig     |  1 +
> >   configs/xilinx_zynqmp_virt_defconfig     |  1 +
> >   include/sysinfo.h                        |  9 +++++
> >   lib/smbios.c                             | 42 +++++++++++++++++++-----
> >   6 files changed, 46 insertions(+), 9 deletions(-)
> >
>
>
> Any comment on this series?

It's mostly Simon that created that sysinfo stuff, so I was expecting
him to have a look.
I can put in on my bucket list, but that's going to take some time


Thanks
/Ilias

>
> Thanks,
> Michal
