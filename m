Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DF8CF2597
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 10:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42ADA88DA3;
	Mon, 14 Oct 2024 12:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HpT1dbJ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E98788E8A; Mon, 14 Oct 2024 12:50:17 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A58B88CEA
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 12:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c9404c0d50so4092425a12.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 03:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728903014; x=1729507814; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=upIQIPxV+QRRLbUyrQT+++Ekcvd3SPiq9gR7qic8AUM=;
 b=HpT1dbJ4cQh56+PgPKN+wI4c1zFVuWddAbckdIQuXI3EF48l4TzxMBmJp4JMWZf48R
 VeQ/v3EPwQY4wa3gbJBy0lny8/nL9E1am7wYzv4d/kwDYeylovlyoxDHd+MM8RlUjFNb
 uQxAukyQu1okn3KAWejYO04JM4qceRF6Ic1OM/esWxO0odjG3GfAbehRThEgn/M9Zt3S
 Qxf9LUKL0CjwI2iYTT2KhqGqqYJW1Y6laN4sHULlcR1SV9Cce83yMn7Vk1r3A8R2mYIW
 MI70ylvcOjqn/uUHajZ3whHxHrzT95reF9YCVIFD579xpJw4ir5lLxgw7CKZA9FH5ARv
 acTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728903014; x=1729507814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=upIQIPxV+QRRLbUyrQT+++Ekcvd3SPiq9gR7qic8AUM=;
 b=AeSYFUX5QaV5QE269ZfvoRn3oTqj8Yk6bebwyB3kninUhFT3DD63YtI9m2sgeRQPrY
 U/xxoaGwrjMhnDu+IQPhq2ydfAuwFanrNTbRvCl7A1SYvlHzW5zUXH8qgfKGjq60KOTu
 7VJJgFiCvo9cc5anBenexrwBdgpUTwY6UeMmSo4JGFYje6isxF8umdSsEP58JwRIGYe3
 MGLGVeuvYJYkKnmPWeTP54Lu9UVG5WqyUyjTYN4C//GVujVwUw6l8nRru9IvmCdA5XW/
 0MCMJLjhSfmbcL6OjzSHPK8n/VZLvFksMs94eq1WR7W/bJ1hFw0njyjSMgEAOj4Y0O6L
 ZNWQ==
X-Gm-Message-State: AOJu0YxviKuHmx2b8dNtDY+LoU8HwPlOODTOjXMPqAlNOX4mwDwJCfe/
 DsEVbCItZG7QMnyGHefr1Q4LRyPOXOQlQxO/O0VEamnUTTEKjU+DB6Fkpo8/QFdexe7xalJQMTy
 JGSaZ0/2A58KDVoSJlANez8CIB1SEJyP1/FNvqg==
X-Google-Smtp-Source: AGHT+IHVbogk5rH1ky1jQdVlkrY+G59m5I//dzWbTJgv07wDXsJVIPs/gwt+yYuY5IwmD6Pg5QEaAkeiAly1JH9Xsik=
X-Received: by 2002:a05:6402:2707:b0:5c9:8705:ea9c with SMTP id
 4fb4d7f45d1cf-5c98705eb49mr144232a12.19.1728903014317; Mon, 14 Oct 2024
 03:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <CAC_iWj+YVGoqC8wRLxQoGTdqCTvERNnAZJ1LktKGySJM4Pnoow@mail.gmail.com>
In-Reply-To: <CAC_iWj+YVGoqC8wRLxQoGTdqCTvERNnAZJ1LktKGySJM4Pnoow@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 14 Oct 2024 16:20:03 +0530
Message-ID: <CADg8p97b+gk4qdsmF2yu102GM+SCwydbzcDTbrrnaEAyBHpPjw@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Make EFI memory allocations synchronous with LMB
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Mon, 14 Oct 2024 at 15:53, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh,
>
> On Sun, 13 Oct 2024 at 13:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> >
> > This is part two of the series to have the EFI and LMB modules have a
> > coherent view of memory. Part one of this goal was to change the LMB
> > module to have a global and persistent memory map. Those patches have
> > now been applied to the next branch.
> >
> > These patches are changing the EFI memory allocation API's such that
> > they rely on the LMB module to allocate RAM memory. This fixes the
> > current scenario where the EFI memory module has no visibility of the
> > allocations/reservations made by the LMB module. One thing to note
> > here is that this is limited to the RAM memory region, i.e. the
> > EFI_CONVENTIONAL_MEMORY type. Any other memory type that is to be
> > added to the EFI memory map, still gets handled by the EFI memory
> > module.
> >
> >
> > Some test logs to highlight the issue that is being fixed by the series.
> >
> > Without patch series
> > --------------------
> >
> > lmb_dump_all:
> >  memory.count = 0x1
> >  memory[0]      [0x40000000-0x820fffff], 0x42100000 bytes flags: none
> >  reserved.count = 0x3
> >  reserved[0]    [0xe100000-0xeffffff], 0x00f00000 bytes flags: no-map
> >  reserved[1]    [0x42000000-0x421fffff], 0x00200000 bytes flags: no-map
> >  reserved[2]    [0x7f77da00-0x820fffff], 0x02982600 bytes flags: no-overwrite
> >
> >
> > => efidebug memmap -- does not show regions allocated by lmb
> >
> > Missing TPMv2 device for EFI_TCG_PROTOCOL
> > Type             Start            End              Attributes
> > ================ ================ ================ ==========
> > CONVENTIONAL     0000000040000000-000000007f751000 WB
> > BOOT DATA        000000007f751000-000000007f756000 WB
> > RUNTIME DATA     000000007f756000-000000007f757000 WB|RT
> > BOOT DATA        000000007f757000-000000007f758000 WB
> > RUNTIME DATA     000000007f758000-000000007f77a000 WB|RT
> > BOOT DATA        000000007f77a000-000000007f781000 WB
> > BOOT CODE        000000007f781000-00000000807b5000 WB
> > RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
> > BOOT CODE        00000000807b6000-00000000817c0000 WB
> > RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
> > BOOT CODE        00000000817d0000-0000000082100000 WB
> > =>
> >
> >
> > Trying to allocate EFI memory with already allocated region succeeds(should fail)
> > ---------------------------------------------------------------------------------
> >
> > => efi_mem alloc 2000 42000000
> > Address returned 0x42000000
> >
> > => efidebug memmap
> > Type             Start            End              Attributes
> > ================ ================ ================ ==========
> > CONVENTIONAL     0000000040000000-0000000042000000 WB
> > BOOT DATA        0000000042000000-0000000042002000 WB
> > CONVENTIONAL     0000000042002000-000000007f751000 WB
>
> Any idea what caused BOOT DATA to start from 000000007f74d000 with the
> patches applied?

That is a good catch indeed :). This memory showed up because I issued
the 'efidebug memmap' command before issuing any other efi command.
And as part of the efi subsystem initialisation, some memory gets
allocated, and that shows up in the EFI memmap. If another bdinfo
command is issued after the efi subsystem initialisation, we would see
this newly added memory as part of the lmb memory map as well.

-sughosh

>
> > BOOT DATA        000000007f751000-000000007f756000 WB
> > RUNTIME DATA     000000007f756000-000000007f757000 WB|RT
> > BOOT DATA        000000007f757000-000000007f758000 WB
> > RUNTIME DATA     000000007f758000-000000007f77a000 WB|RT
> > BOOT DATA        000000007f77a000-000000007f781000 WB
> > BOOT CODE        000000007f781000-00000000807b5000 WB
> > RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
> > BOOT CODE        00000000807b6000-00000000817c0000 WB
> > RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
> > BOOT CODE        00000000817d0000-0000000082100000 WB
> > =>
> >
> >
> > With patch series
> > -----------------
> >
> > lmb_dump_all:
> >  memory.count = 0x1
> >  memory[0]      [0x40000000-0x820fffff], 0x42100000 bytes flags: none
> >  reserved.count = 0x4
> >  reserved[0]    [0xe100000-0xeffffff], 0x00f00000 bytes flags: no-map
> >  reserved[1]    [0x42000000-0x421fffff], 0x00200000 bytes flags: no-map
> >  reserved[2]    [0x7f77a000-0x7f77cfff], 0x00003000 bytes flags: no-notify, no-overwrite
> >  reserved[3]    [0x7f77da00-0x820fffff], 0x02982600 bytes flags: no-overwrite
> >
> >
> > => efidebug memmap -- now shows the lmb allocated memory regions also
> > Missing TPMv2 device for EFI_TCG_PROTOCOL
> > Type             Start            End              Attributes
> > ================ ================ ================ ==========
> > CONVENTIONAL     0000000040000000-0000000042000000 WB
> > BOOT DATA        0000000042000000-0000000042200000 WB
> > CONVENTIONAL     0000000042200000-000000007f74d000 WB
> > BOOT DATA        000000007f74d000-000000007f752000 WB
> > RUNTIME DATA     000000007f752000-000000007f753000 WB|RT
> > BOOT DATA        000000007f753000-000000007f754000 WB
> > RUNTIME DATA     000000007f754000-000000007f776000 WB|RT
> > BOOT DATA        000000007f776000-00000000807b5000 WB
> > RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
> > BOOT DATA        00000000807b6000-00000000817c0000 WB
> > RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
> > BOOT DATA        00000000817d0000-0000000082100000 WB
> > =>
> >
> >
> > Trying to allocate EFI memory with already allocated region fails as expected
> > -----------------------------------------------------------------------------
> >
> > => efi_mem alloc 2000 42000000
> > efi_allocate_pages failed 800000000000000e
> > =>
> >
> > Trying to allocate EFI memory with non-allocated region succeeds
> > ----------------------------------------------------------------
> >
> > => efi_mem alloc 2000 42200000
> > Address returned 0x42200000
> >
> >
>
> Thanks
> /Ilias
