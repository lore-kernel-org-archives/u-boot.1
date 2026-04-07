Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77580FF512C
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 18:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F0108404A;
	Tue,  7 Apr 2026 20:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RHZJ7H/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FD088405F; Tue,  7 Apr 2026 20:14:06 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69E9483F75
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 20:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-66bb6eb28acso9671776a12.0
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 11:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775585644; cv=none;
 d=google.com; s=arc-20240605;
 b=iTkY/x10Mb105rNR0SnEJpQDnF9VCb/Q1pn+UhoHbq5qyd7g3yGZNOA1WqIEPyrIxR
 PdHTE4mE3hKUKBSAyuAx7Qvcu7gYDrFVQgF4/Ko79TWpHaDWtSblR9UC9rtoX425gJTl
 jlPSonnFFqjPJg0kb2Ebt2g0a+1EFhJQBpixeiT9LsSw1T/zTpCtBwpHsn9OsSNfK9cE
 i7PqsnEhOZviWdx9zHWNM+DVqE2DRj1QxU4vGtqqgVGGIsVXUqjuQKyCNFQsdwMu1A/x
 tkvnsUceeAgI35k2VnCiiXeA9H8VPuKwnmNAhfpyJtBOwxueydCH0CDIQOE1FJv1VZ4p
 lBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nHrQ0x4c69LDE6Qx5C/l0X6IOZtwPcpa90MPd7VqjlY=;
 fh=xvtPdHsw2fYZi/vc7GUrf448xroWVihwIxbwZ117NSw=;
 b=BXTxxgGYGkQtvMw6i+thXGbG57zpGc/NG2ozoJBxUtchKL7Ss8tafNI8RzuDgWIbq7
 Msig8+P95V6/mT5cdiWVbnOlkKkaoR5cVmk6ck7fhFyF7HtywOahKDaydgRRIce8Rtk8
 ZJQQsHulUlBra31aegUgtNuV5HMABR1n69OgXE5Gz1JnWxd1T8rKCLrrt1RRRWAE3NUA
 ETSEZTlC4VoC+c6Ge2SnDsrFkZZAZoEUVe0NBoNKkYtQD5a5wNz489sLicPK5y6XkFj2
 /BN24saBXD9uyfZRy9Jxopm+z1+6Ldc6bdnOKHHigolvVGtAsUrVrnuHAUDrNVmNAspx
 Ot4g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775585644; x=1776190444; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nHrQ0x4c69LDE6Qx5C/l0X6IOZtwPcpa90MPd7VqjlY=;
 b=RHZJ7H/FEcMXeVfe2ojZT1MLpr3/mF0TvK3IJfRKB7Qm5b0tdRg6YCg9/muH79ahne
 xKBhwgIBCLnXyOrzOoNpGdRr+6th6TKVFy/JgjVFcKXILlbPXChjPpBYUhBS8azbAoLR
 tJOoLlJnrCRoVMqWr79GUHhGOLT5HnGEYvkeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775585644; x=1776190444;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHrQ0x4c69LDE6Qx5C/l0X6IOZtwPcpa90MPd7VqjlY=;
 b=dMql+u2Yvx6fvncJG31Li+oZ9VhVtdB2HNXfbH+bCAGQsVlrXB1u7bF6NKFUGKvbhA
 R8XfHsUyaNOVXhbYgU+TpcpyKtNPgdMKM18myXsynvhI7X0XXS9yk3IXOlF3FklPtaXA
 GOQlqUsIppmQT49ngMst8UumyHXcTjGjwTdBCsJfw/ZXqcIK2iQq9r94tkPuaDeQLDWg
 mgcIKMGdIvrR9g7rQNIwZY0ng3Y0Ab5K0qmzjFSXyzqbwLFVX4RQ/KfMfwHqpDVV3dLS
 3ToSqnngKXyUq2p3C3sybbJwY+Selb72VYQxAMVwQBTgy9N4atVO8NmdKHC9fHaswfxF
 +lGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvE+pBb9RLE1t5QQiMNnG9GHcf0lr+xwntAZ5d/huvnODhgrZPMw+wDgK5chxIdNXzaMZwDtI=@lists.denx.de
X-Gm-Message-State: AOJu0Yweg9FGz63LNRVfJvJuPQBNhE7U9hTXYeno/hs9a7tWblLpKzrZ
 ROo1ge1v4xpXCyq2LIF7i3aMVGjrPYh2a9R6+stAW8/7bs/eAdpJv8XiRYFoBRhc8dJZf5ksHGa
 Vhey37U0l7HluPwOV6+tWrvuANhVNAueOlrKhooRLe/tUbgFlFOuAuw==
X-Gm-Gg: AeBDieuS+gV7Ce1WZvtmlhawq3+740E7y0gwh2zaM2+D7Oj8VRheLeP5e6uW840+PF+
 skpE0xupb4uC6P+j+ITXZ7H/DXsF7rEmzmI0cixpQYuOE2triID3k0jHcRv8Zf7RfU8puC7fnGx
 fL4UCweujWF9gHGNwQ2/rzHtb1z/Kw71rpHCHehXJ/Qv1Ky5tcm0bxjM2EQtQox8lYZfhK93So8
 mFcEwetoQESWXvQURsr6rrcL2WOupPRj4u8+jqSfVoxIrLpNsOE9aTjSfE0P1183FuG7ZJn9ZQz
 Y9I/tg==
X-Received: by 2002:a17:907:9717:b0:b9c:6ef1:ed13 with SMTP id
 a640c23a62f3a-b9c6ef20f71mr826330566b.31.1775585643675; Tue, 07 Apr 2026
 11:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775121078.git.simona.toaca@nxp.com>
 <7edcce04b39aabc1f58e09814e7fadff226e2bb8.1775121078.git.simona.toaca@nxp.com>
 <CAFLszTgb5a3QtyviHc-MRTdDUoDUWnYksWXMeCUxagHmvfQK2g@mail.gmail.com>
 <mtfbgewm7kw4jzmxjkksdmq2ahb3mdrb6p5bi5qvpow2tydyl7@bejuojige3bw>
In-Reply-To: <mtfbgewm7kw4jzmxjkksdmq2ahb3mdrb6p5bi5qvpow2tydyl7@bejuojige3bw>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Apr 2026 12:13:51 -0600
X-Gm-Features: AQROBzD5hbZCjG9hy4vo2lAoESlsTPknP-JHiuwwPMN2omva544TFD5YR6XF49w
Message-ID: <CAFLszThADHGE_8aAFExK8Kv_Ef9LG5Xcio=znkNwFH-eUESzsg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] imx9: Add support for saving DDR training data to
 NVM
To: Simona Toaca <simona.toaca@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com, 
 alice.guo@nxp.com, viorel.suman@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com, 
 ping.bai@nxp.com, marex@nabladev.com, sebastien.szymanski@armadeus.com, 
 ravi@prevas.dk, joao.goncalves@toradex.com, ji.luo@nxp.com, 
 semen.protsenko@linaro.org, tharvey@gateworks.com, qijian.guo@nxp.com
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

Hi Simona,

On Mon, 6 Apr 2026 at 02:28, Simona Toaca <simona.toaca@oss.nxp.com> wrote:
>
> Hi Simon,
>
> On Sun, Apr 05, 2026 at 05:49:56AM -0600, Simon Glass wrote:
> > Hi,
> >
> > On Thu, 2 Apr 2026 at 03:29, Simona Toaca (OSS)
> > <simona.toaca@oss.nxp.com> wrote:
> > >
> > > From: Simona Toaca <simona.toaca@nxp.com>
> > >
> > > DDR training data can be saved to NVM and be available
> > > to OEI at boot time, which will trigger QuickBoot flow.
> > >
> > > U-Boot only checks for data integrity (CRC32), while
> > > OEI is in charge of authentication when it tries to
> > > load the data from NVM.
> > >
> > > On iMX95 A0/A1, 'authentication' is done via another
> > > CRC32. On the other boards, authentication is done by
> > > using ELE to check the MAC stored in the ddrphy_qb_state
> > > structure.
> > >
> > > Supported platforms: iMX94, iMX95, iMX952 (using OEI)
> > > Supported storage types: eMMC, SD, SPI flash.
> > >
> > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > > Signed-off-by: Ye Li <ye.li@nxp.com>
> > > Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
> > > ---
> > >  arch/arm/include/asm/arch-imx9/ddr.h |  48 +++-
> > >  arch/arm/include/asm/mach-imx/qb.h   |  15 ++
> > >  arch/arm/mach-imx/imx9/Makefile      |   6 +-
> > >  arch/arm/mach-imx/imx9/qb.c          | 379 +++++++++++++++++++++++++++
> > >  arch/arm/mach-imx/imx9/scmi/soc.c    |   7 +
> > >  drivers/ddr/imx/imx9/Kconfig         |   7 +
> > >  6 files changed, 459 insertions(+), 3 deletions(-)
> > >  create mode 100644 arch/arm/include/asm/mach-imx/qb.h
> > >  create mode 100644 arch/arm/mach-imx/imx9/qb.c
> >
> > Note that this feature is present on x86 boards already.
> >
> > I wonder if we could make this more generic? E.g. it could be a
> > function of UCLASS_RAM ? I could do the x86 part to try it out if you
> > like.
> >
>
> Can you please point me to the implementation for x86? This Quickboot
> feature is specific to Synopsis DDR PHYs, and the location where we
> save this data is specific to iMX9 series (since it is needed by OEI).
> I need a bit more details about what you mean.

Yes, if you look at mrccache_save() you will see how this works. It is
controlled by a flash layout within the SPI-flash node:

 spi: spi {
    #address-cells = <1>;
    #size-cells = <0>;
    compatible = "intel,ich9-spi";
    spi-flash@0 {
       #address-cells = <1>;
       #size-cells = <1>;
       reg = <0>;
       m25p,fast-read;
       compatible = "winbond,w25q64dw",
          "jedec,spi-nor";
       memory-map = <0xff800000 0x00800000>;
       rw-mrc-cache {
          label = "rw-mrc-cache";
          reg = <0x005e0000 0x00010000>;
       };
    };
 };

Regards,
Simon
