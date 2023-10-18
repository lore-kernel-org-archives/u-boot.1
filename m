Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28361CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 994F286F08;
	Wed, 18 Oct 2023 05:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NY5oscKm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D19E86F4D; Wed, 18 Oct 2023 05:34:07 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8D1986F63
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9ae2cc4d17eso1027825066b.1
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697600044; x=1698204844; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VEkajUbY6/muHCf9PGNBuzYmoqkQyS1Jwo+rmxLYArU=;
 b=NY5oscKm1zo0eYiIB7WatfUjMt098TZmLUl9hTotmjAVqb3c+ZVaKBn447JnrFetPa
 pQs6gH7bAwNeaPz5+JE8l7o44SBk8wRPw7cIfZkl4lL6M6tbfMdMDukXVme3GMfDF25h
 kql8x3w+h+igF3VxcGPGu4qmlriYgfkHBCVew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697600044; x=1698204844;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VEkajUbY6/muHCf9PGNBuzYmoqkQyS1Jwo+rmxLYArU=;
 b=BqbTUARE+9Ihwwi3AnP5uwKyPcQh2JMwoCWIp7sLrUCaW7G2UwumR2JK+EO8rL7+qI
 gOVwKnov+84TDzFzXVW15Syt1U81TphK5UVB4IxeYmMV5OTwbg91fjsUVNJm4T8v0RCV
 SqIkDhaxd55804DZ/jL8Q4+neyde9BuYbd7C44XUBw6/eXh+PhP301FwJSjqfSUN5SS2
 k/nNLNtJbwT5Yr100Al9KbWJD5w79kPT48/K2q9Ruct6n76kO7iNwMeEYyDCR9Sn2zxR
 j5zFX18KGo/D64sri+bE10bx0kOLHhOnrbjFTDlRNQd4HNoDEVv8Z9VeKlBC8wBgzZRw
 5Lkw==
X-Gm-Message-State: AOJu0YwKcSTDkaw2b5A5FTGo+9Um8v9O+zQi76p6Vr7CT7G128C0zotu
 JOtsjbo80vOhEuNOb728xy13qMiczEsAIed9xpA+zw==
X-Google-Smtp-Source: AGHT+IHfXy21O56DL1S1rBFxPq1GnBdzyvCpzMzAv5h/Kxak3TUE1sJ//N63+p1VNCtvq3qyUx93QYCcQu/GEk694LQ=
X-Received: by 2002:a17:907:3181:b0:9c2:a072:78c4 with SMTP id
 xe1-20020a170907318100b009c2a07278c4mr2832179ejb.25.1697600044286; Tue, 17
 Oct 2023 20:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231008213646.622002-1-sjg@chromium.org>
 <20231008213646.622002-4-sjg@chromium.org>
 <4295df86-0a0b-420f-b8d2-ed5c930ea9ee@gmx.de>
 <CAPnjgZ2Tt-=Botwz7QotJYJ9SxKBvS7Tx=C35+j+CRWOLD9ZbA@mail.gmail.com>
 <a163b0a2-3ba8-4149-b696-4eb80a57f10a@linaro.org>
In-Reply-To: <a163b0a2-3ba8-4149-b696-4eb80a57f10a@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Oct 2023 21:33:53 -0600
Message-ID: <CAPnjgZ0MVMVAMs2nVjsAaMXqz8p34AUJvAL_8r=bR1vhH7r=Bw@mail.gmail.com>
Subject: Re: [PATCH 3/5] smbios: Use SMBIOS 3.0 to support an address above 4GB
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Caleb,

On Tue, 17 Oct 2023 at 11:59, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Both,
>
> [...]
> >>>
> >>> @@ -513,13 +517,23 @@ ulong write_smbios_table(ulong addr)
> >>>        */
> >>>       table_addr = (ulong)map_sysmem(tables, 0);
> >>>       if (sizeof(table_addr) > sizeof(u32) && table_addr > (ulong)UINT_MAX) {
> >>
> >> You have to check the end address of the table not the start address here.
> >>
> >> The SMBIOS specification says that you should always supply a 32bit
> >> SMBIOS entry point. Of course this is not possible on boards that don't
> >> have low memory.
> >>
> >> In install_smbios_table() this can be achieved by calling
> >> efi_allocate_pages() with EFI_MAX_ALLOCATE_TYPE and a maximum address of
> >> 4 GiB - 1. Only if this fails use high memory.
> >
> > Hmm perhaps we need a way to allocate memory below 4GB in U-Boot? How
> > does this EFI function work?
>
> Yes, prior to 53fab13a7b11 ("efi: Use the installed SMBIOS tables")
> efi_allocate_pages() was called directly from efi_smbios_register(). My
> boards all malloc() memory above the 4GB boundary and I just recently
> rebased and hit a regression caused by this.
>
> In my testing, calling efi_allocate_pages() from install_smbios_table()
> did work, but I figure that's probably not intended behaviour...
>
> I can confirm that this series does allow my boards to boot again, but
> dmidecode is unable to decode the SMBIOS 3.0 table (even with
> STRICT_DEVMEM disabled fwiw).

OK thank you for digging into this. So I suppose I can repeat that in
qemu, with a suitable distro?

>
> Below is EFI and board memory map info after applying this patch series.
>
> => efidebug tables
> Cannot read EFI system partition
> Cannot read EFI system partition
> Failed to persist EFI variables
> 000000017ea22040  32313633-3532-3634-2d66-3765662d3463  EFI Conformance
> Profiles Table
> 000000017ea21040  36366265-3139-6138-2d37-6565662d3430  Runtime properties
> 000000017fb13000  64663266-3531-3434-2d39-3739342d3461  (unknown)
> => efidebug memmap
> Type             Start            End              Attributes
> ================ ================ ================ ==========
> CONVENTIONAL     0000000080000000-000000017ea1f000 WB
> BOOT DATA        000000017ea1f000-000000017ea21000 WB
> RUNTIME DATA     000000017ea21000-000000017ea22000 WB|RT
> BOOT DATA        000000017ea22000-000000017ea23000 WB
> RUNTIME DATA     000000017ea23000-000000017ea25000 WB|RT
> BOOT DATA        000000017ea25000-000000017ea26000 WB
> RUNTIME DATA     000000017ea26000-000000017ea36000 WB|RT
> BOOT DATA        000000017ea36000-000000017eaef000 WB
> BOOT CODE        000000017eaef000-000000017fb13000 WB
> RUNTIME DATA     000000017fb13000-000000017fb14000 WB|RT
> BOOT CODE        000000017fb14000-000000017ff20000 WB
> RUNTIME CODE     000000017ff20000-000000017ff30000 WB|RT
> BOOT CODE        000000017ff30000-0000000180000000 WB
> BOOT DATA        0000000180000000-000000027c7a0000 WB
> => bdinfo
> boot_params = 0x0000000000000000
> DRAM bank   = 0x0000000000000000
> -> start    = 0x0000000080000000
> -> size     = 0x0000000100000000
> DRAM bank   = 0x0000000000000001
> -> start    = 0x0000000180000000
> -> size     = 0x00000000fc7a0000
> flashstart  = 0x0000000000000000
> flashsize   = 0x0000000000000000
> flashoffset = 0x0000000000000000
> baudrate    = 115200 bps
> relocaddr   = 0x000000017ff26000
> reloc off   = 0x000000017ff26000
> Build       = 64-bit
> fdt_blob    = 0x000000017faef6c0
> new_fdt     = 0x000000017faef6c0
> fdt_size    = 0x0000000000017680
> Video       = framebuffer@9D400000 active
> FB base     = 0x000000009d400000
> FB size     = 1080x2160x32
> lmb_dump_all:
>  memory.cnt = 0x1 / max = 0x40
>  memory[0]      [0x80000000-0x27c79ffff], 0x1fc7a0000 bytes flags: 0
>  reserved.cnt = 0x7 / max = 0x40
>  reserved[0]    [0x85700000-0x85cfffff], 0x00600000 bytes flags: 4
>  reserved[1]    [0x85e00000-0x85efffff], 0x00100000 bytes flags: 4
>  reserved[2]    [0x85fc0000-0x890fffff], 0x03140000 bytes flags: 4
>  reserved[3]    [0x8ab00000-0x8c416fff], 0x01917000 bytes flags: 4
>  reserved[4]    [0x8c500000-0x97bfffff], 0x0b700000 bytes flags: 4
>  reserved[5]    [0x9d400000-0x9f7fffff], 0x02400000 bytes flags: 4
>  reserved[6]    [0x17ea1f000-0x27c79ffff], 0xfdd81000 bytes flags: 0
> devicetree  = board
> arch_number = 0x0000000000000000
> TLB addr    = 0x000000017fff0000
> irq_sp      = 0x000000017faef6b0
> sp start    = 0x000000017faef6b0
> Early malloc usage: a78 / 2000
> >
> > I don't think EFI has been set up by the time this function is called.
> >
> > Regards,
> > Simon
>
> --
> // Caleb (they/them)

Regards,
Simon
