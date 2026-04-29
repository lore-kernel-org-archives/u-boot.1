Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4054FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 07:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89935846D2;
	Wed, 29 Apr 2026 09:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sq4SfVaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62CA8846D8; Wed, 29 Apr 2026 09:08:15 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED0E6846CE
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 09:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-79db5e18ac6so7049817b3.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 00:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777446491; cv=none;
 d=google.com; s=arc-20240605;
 b=VMaAz+Uobi3bRurK9OvLq5qgbQj7APM4nABxh+j28JfGJ0iYQPmnaYc/napNvhKAEN
 N4P8P/fJ4LiRFVKVhAC4bEgVdLVH3/LETxbD0JsVWvj7pMYSETnDfGFj1col9upRKogD
 Sc57Jxl+eax7HZXXqS8UTSi3KdcSU6JZn4Y1a43V3RehO44sP0CPf2tbklxjRwbqJSNp
 GMwnXwYBJX0pO8ArCBoVMWypvSFTBo5q5wmZEeLMeI1fmUv0RNA6DYwauIbvwdQLRUkq
 p94afm9fxrz2BHSnZj/ztMx2ChF28molH1mtutgcRAq/FJ46jTRW74j6gas0FTlly9vy
 qcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pdXuj8J5EYt3x1/2SG9wxneeDwW/VE3/KES1tgEhR3M=;
 fh=+7KOj+MIzoIM6Xe4Z2VThumnaLTGh0LHJIVhLbC5Yio=;
 b=NyrNfWPyLkjbaW/9NkmYvNuK/RWvg0VO8DO3Kj5J600Kcizfy36OkTXbZ/4GrVi8+t
 E9JNt2aGEpBTZ7hps1wPV69qdb8QV6L9/N0D/K2qdOoNCvt7A8ed5T8M0qYo5Z9ftN0X
 84XT/0ZxrXIUOE3OJx/t3GgX9xncePDdeW+yCRxuGr/DvitjFwmhOrZ2IfD0s7kYmDxh
 gKR0LcgdDR4A2vXLbEY9Z+E2QrlHZRlyF0XpJ2ZkNPtGP3opBH5+ipxMEL/h1vH9/myC
 4eeDRae4rBcwyr6TsMenCLdL8+exNYh+Vhy896t50t5v3zu6FGEnXUPWs/Swv7HMYI9e
 A3Hg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777446491; x=1778051291; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pdXuj8J5EYt3x1/2SG9wxneeDwW/VE3/KES1tgEhR3M=;
 b=sq4SfVaTkAURrtmKbm5FJdoXcUzuzt3wQSF/S2XL4I1+K0KOV4Sy/enFYHpUS7wpXU
 K/IVaS12N59p+mg+P39PIHbdMJSSvcEreyYGFCMfpOpfUVJQK+Q4Y0uqnuuezQG+sHyX
 ivOW1lEKD/TMZeNS4eRWdox/6Nb9B3E1v0L5MGsHduQgEV8wwt0EJbSMmdSBu85PEL1U
 XDcmKrZ19Eo0f70Ej77kmsMliq/Cl0sByt7j6vxPxwpFj0Cjie7Gt6pL1DN1i/cwxF76
 S8S+z5Jf/f/ABXZcjfnrX831OlYEUZoXVfBSWWTSGztxsGiYpoAkJ9KqKPqAfS3S+05J
 JqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777446491; x=1778051291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdXuj8J5EYt3x1/2SG9wxneeDwW/VE3/KES1tgEhR3M=;
 b=q4w+ogneiwht8hg31o7HX9obqfMOcDsHCQroa1yHMSJg7f698eWPmXSFsyC9Vpt95r
 +JSVvaRLHiBvhRwpmC+MsINmo+XS88Zz9cjheKGFF3Ed45fqzFTNP8WwTR4hwFsd3afN
 XDzkdvEni29qXu0Ch7PhM+155YT6apIwCyV0Eo8kmexUIAs+kU3Pi6ESpbAqjAVOt5y/
 p6rut7z1ndkpGLnpX4SC0uAHOJiwLQdf9M6HEk4IbJXBHhi3QyAie/WeP54LsTiWBU8e
 6I2gn7yF+SKNvsvfEyyOQSzd1Yc2DzwF8FEsEYGnLDsZORA1M9OCYrpSSXdKb98Pw0To
 WPCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cxWrOghj+LX9sRT/VhYHOa1XfFmJDeNdGZ6JV50fS++15yYkAZkPVNqV5xcuWBCYhVScKjHI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9pYmiifQzFAzZazQauNcnpFTPd15rAZccGcOyLcpSthasO3Pm
 16bNWiJKUBQp1ADlDxb3Hb1Ka8IrMAWc0AfJO5it9VK3xkYmKvCc8e7SlB7fWKRUFG7CDwRmFCc
 S0U7x/S8QG7TyCwLLiSC/YMjjnLCrmpjBgdIa2eKOtw==
X-Gm-Gg: AeBDietRsS1ibUG7k0QiLyl1oeZeEMrmB36aVQ88xOlx4yHlY3jXJOWZPptCBGeOu4U
 +EUFdVX6WJBAwjSv8XiTI5COQVV3YLUm+D7zo6p3wbQ+Hi+4528ulQEU+aFN97cGUks1NRLub0u
 tLggcRF05LbOwyBymLLzvmigGGzxDE8TLSFgRc5fRWtMJeXqPc7KdlA7pxZ30MSeNacFPjtJXRT
 JEuLFW4/ZJg8o3eRac9fSioLNNQmZn6Es2GLj1+x5e3tR/lMnNDm1ZEp9sU2Nk+XAqYEuiUolsE
 32NxP8V/d3o1tsqp2f/MOZ+z19jT53wQ5dxfwSafO8xrTkkXSWTV+bi/7EZDCobTKIzkQtujjH7
 j7JURU1gLYCdMvwot4DQtIoF1dYRp8SaZZuKJfKICecC6atBUEkiWFGpL8VxIqK76Qk3NuIGsd1
 02m/OOXODJZvCi3Z58oQMB54PNdfWgHHSLh88edeBxHlXXQTqv2orHivoXV8wRjn704u5d6UQJo
 upGA9NQ+h+aGJcNg3URqjRbws2KxZqXBBjzoZh2aS4rNBst4uzWbWF5KjQ26eOcAMZb3RkyvnD/
 37WHamjjFNObAg1VdAROCYRPd0Ip0InuF9mhj7C22T/UuR18lgi71SQnS9vIBum25nGmIdvonCJ
 8JwZQjsAn11p4aZSN
X-Received: by 2002:a05:690e:4091:b0:656:a9d2:9155 with SMTP id
 956f58d0204a3-65bff48cc16mr1309511d50.44.1777446490752; Wed, 29 Apr 2026
 00:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
 <20260416055948.130041-7-ilias.apalodimas@linaro.org>
 <6944f28f-131f-4a08-9ef9-aae812926f4b@mailbox.org>
 <CAC_iWj+ufWdroVDCh9qNAYfsjON5r_pdfOUgyB=h=b2b_rMVKg@mail.gmail.com>
 <8b87df2b-1904-4f2c-862d-924daff649e6@mailbox.org>
 <CAC_iWj+1PNaGjX5DH3hA4iednKruydKjy-0YoXuWTCJHmPVCDA@mail.gmail.com>
 <73312691-c9a1-45a6-be3d-232949432b60@mailbox.org>
 <CAC_iWj+bT0Ab_MuGWa5seQBQ4WaAGSqWnPvZ=D9G2SgBH0X0Dg@mail.gmail.com>
 <3d37e4a7-2beb-49df-bc0d-aff41d403f74@mailbox.org>
In-Reply-To: <3d37e4a7-2beb-49df-bc0d-aff41d403f74@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 29 Apr 2026 10:07:34 +0300
X-Gm-Features: AVHnY4IdEguDRaC3udNr-1QiXfwTd513X0wVAFIT_ynnrhlTBY3JoS0A6irBWIE
Message-ID: <CAC_iWj+aUteV6kpHyBP6orp_oj49eeGsZggcsxU+=njFb5FtdQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] common: Add an option to relocate on ram top
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
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

On Wed, 29 Apr 2026 at 04:07, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 4/28/26 9:31 AM, Ilias Apalodimas wrote:
> > On Tue, 28 Apr 2026 at 09:43, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >>
> >> On 4/27/26 4:33 PM, Ilias Apalodimas wrote:
> >>
> >> [...]
> >>
> >>>>>>> +++ b/common/board_f.c
> >>>>>>> @@ -339,7 +339,22 @@ static int setup_ram_base(void)
> >>>>>>>      static int setup_ram_config(void)
> >>>>>>>      {
> >>>>>>>          debug("Monitor len: %08x\n", gd->mon_len);
> >>>>>>> -#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
> >>>>>>> +
> >>>>>>> +     if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
> >>>>>>> +             int bank;
> >>>>>>> +             phys_size_t total_size = 0;
> >>>>>>> +
> >>>>>>> +             for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> >>>>>>> +                     if (gd->ram_top <= gd->bi_dram[bank].start)
> >>>>>>> +                             gd->ram_top = gd->bi_dram[bank].start +
> >>>>>>> +                                             gd->bi_dram[bank].size;
> >>>>>>> +                     total_size += gd->bi_dram[bank].size;
> >>>>>>> +             }
> >>>>>>> +             gd->ram_size = total_size;
> >>>>>>
> >>>>>> Shouldn't this also apply board_get_usable_ram_top() to be consistent ?
> >>>>>
> >>>>> Simon asked the same thing. I'd rather keep this option strict for now
> >>>>> and always relocate to the upper memory boundary fnor now. Once I do
> >>>>> further cleanups, I can either add it or remove the function entirely
> >>>>> since dram_init_banksize() (which hs also board specific) runs really
> >>>>> early now.
> >>>>
> >>>> Maybe the default board_get_usable_ram_top() can return the ram top if
> >>>> CONFIG_IS_ENABLED(RELOC_ADDR_TOP) ? That would still allow users to use
> >>>> board_get_usable_ram_top() consistently to reduce the ram top.
> >>>
> >>> dram_init_banksize() can be used instead now to reduce that and we can
> >>> remove this option eventually. Is there anything that we can't achieve
> >>> with only that ?
> >> I think I might be confused, but it seems board_get_usable_ram_top() is
> >> used to set gd->ram_top , which is U-Boot's top of RAM and may not be
> >> the same as physical top of RAM . So no, dram_init_banksize() has to
> >> configure the correct physical RAM topology, board_get_usable_ram_top()
> >> can be used to make space at ram_top unavailable to U-Boot .
> >
> > I don't think you are confused but what I am trying to do with this
> > option here is make the process of relocating to the last bank
> > standard. So people that want U-Boot to calculate the reloc address
> > based on the information they initalized on dram_init_banksize() _ the
> > reserved DT regions should enable this option. if they have their own
> > per board calculation logic, they can leave it as is, in which case
> > we'll still call board_get_usable_ram_top().
> That I do understand, I think board_get_usable_ram_top(top) should by
> default return its input parameter "top" . If user does need to adjust
> their ram_top, they can override board_get_usable_ram_top() and possibly
> consume the "top" parameter too. That way, the user has the actual ram
> top at their disposal, and they can use it if they need it, instead of
> reimplementing the logic to get their ram top. Most users should ideally
> not override board_get_usable_ram_top() of course.

Ok, I'll add a call to that and adjust the default behavior of
board_get_usable_ram_top()
