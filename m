Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0BEFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA6D8845D0;
	Tue, 28 Apr 2026 09:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i/li4xU+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19EAD842D7; Tue, 28 Apr 2026 09:32:40 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10AE48465D
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-651b4d09141so14768167d50.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 00:32:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777361555; cv=none;
 d=google.com; s=arc-20240605;
 b=Gke1j/G7zISS0fvYBXLKSR+Zw2dKaUWz1Yo0CUHZgd/gnV0OxbtuYB6kaZSHKbsuP4
 QRxlPfp2e+Oi57UDoYS7PRgjB1RuyVjy9My+U3C3nGajR4CbtMdW0MahR5VnBzWB3VPv
 tlUIznhz8ZncoN/pfBtOutGT+F77GummmnxRZLNdOa2BjEtT04zXz4ulSkGgVQdJIbJO
 5Mf8SZvavE9DkzoiFjSq08o/mn8mGDpXDB4G1vlvHJL/Usu9KRDagHIcrkqOueTjTGyu
 0tcBLcRU34l9Q41PWmNMKEKXJwDWmxFF+CxpRWLUFe3q72aMoZhS6Xen1SA+C7v0LdJj
 O/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=auGA8e8dgARaA025uqFpHRfczPwdur2SlCqPboDW8w4=;
 fh=ptrbFVqF3Hhnpc2XaP/T4NwIdIEfzCU0650LUDM8IqA=;
 b=IfpAto0qQ+h1cRC2GBmHQNVvCwDZTGmoWHVF7PiuTb/N1mTDl8B5P2+N7CElklPnCv
 6gl2lsGBGSDKb5ci/o8I6o81Jj1lWmsjbkP0a8BYUamcmcUouFjnHh1cEyzhJLHb7uie
 p8pBWLubR92HNlq6DyeR/r75Kj4D4kZZoLWQyLRpO3ZqHevZp8udGBBRdOHczJcmvwPA
 Qd5+noXiaBCda9eDRjBu+cGfBmGgmwl7m5DYgoB6FsCugSzvxPKszASY4FnxQ4nwH8PS
 6kKBTNEP52I2vk5tF6vZi/KO8j2ai8YoiTThfttdccnqjF5J1t5CbOLm+X6AhsRG+DO5
 nV6Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777361555; x=1777966355; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=auGA8e8dgARaA025uqFpHRfczPwdur2SlCqPboDW8w4=;
 b=i/li4xU+K29YzerIM0blKOIxYhEAiyqGgO0pvWstJyecC+d8Wcu9KSdw5A8PXEa7qZ
 ny1OSKN094U7Z39YEALZ5x8Z6oYhZvnem5PpfRNmm98zEQr1+p95lWcKyXDU7C6hkYUR
 lglS2BKxyH/pYSfMqzi2uRPcfVB4vpi9YD2jWK5WxETjf0/q4X7YGGC//uNhgSnVMxOC
 WYTfHRnnlhV53qYU2/BJl+AudWbx2U8XoNv45h5T2KKSYYLWXFqOnQxLxkIq18W8z/Na
 CkqUSLMpRAnuCJobTc9bcU4hdG2vnHqpVPbFygb2RWNrEXRWnL8bxB5wSZRk3hyVerML
 DeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361555; x=1777966355;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=auGA8e8dgARaA025uqFpHRfczPwdur2SlCqPboDW8w4=;
 b=SYg6t5qtLVi3JJ5pXxZqVc1Sh7s+NfGhSBadkn+DkbpCttLHGFPt57XiEDVRhLsQiN
 OXjBylbjykFCcspPoCtD5B7Ax7+e8wOuYm1jyAR7ldweoRLsXjgK+IVq46Vf3PFAlwGa
 rmXZy92AV5xOqJufwOivxdxmgWPnOlJhgb42XZxd8/b27Z6roNu8X95JctztafCfqCPr
 C1e7s5obO28gP5LGsJZeirfMsQKkxCqtAVAYyUqcfIey5Bd43hXVHbfbGiakJ50xMSkq
 gw/ldXtiIdTAu/sadX2ARxlUCO42S7cilulauDRIQ9bn9kKG9Q+LwKj7yr0LtBK84//4
 qAEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FqwwiGcBbRtKx3kH5FLUdRkbarB1cDJkDHZTBk4j4kwdtyMhklu5DynNWOlCjgkWl1rx1O94=@lists.denx.de
X-Gm-Message-State: AOJu0YxTDSRTlGdumFAYWQBWXRnpBHkdgyViS7j0lzmhnDPnjYbyP410
 HgBHBTduRGen/2FRqn3LGOaH98q7cbs60DTql6SfFIub4pxSGEabsihg0D4OwmxIfk3/pjvC3cn
 rwArW9+YgcuAIyArTx4TxK4kYkmLk5CCYCWejYRgOa0WFcqk1Zl3Kl9o=
X-Gm-Gg: AeBDievnr8t3gsIhYFQSDNLlSK8s5THBp39/smV+fcsQI2vSfA1dJCgGtY8ITb9UCww
 /DfkWLB0ktlkDaruZ4xtAfWHSWztx9WAAzzzCHHbqAtGKuNZsYq4szS2RBeNqzrowvSqg3asTUi
 h7xaD6X+9eoEjd+bW96ZsivVxzZWJEqYYWdCFVjem43eehHxmML3tmHEZpxXTjqZL5+oy9rrYMS
 Igp6YYXSjEb2wzEbDfnewe/U7L0BjEsL8F7HG+dF1P30rXtzV3z9rUUxTaiVC45Yao1HU6gqXk9
 tafKCn9VaqrFqU+0WHHaIC2wpJOEsQOALqjXAB5BMhrHjJwuVfzumvO3iol+jJiSbs5wvssmM6e
 kCTLF0t8HRTNK2mZzzA/cKtzLFyHDvYWZTdXbYOdg/ohvNKW/lTPh+VQjMQBjDUwvF+rajQxGB0
 KId1IaizZdMBoJlAx2XMel390jsiqG3ivNRkdWK/O63yu1Hz/KLm9QWi/6vFOVC913nwqFsORLq
 yPoUwjjP+Pg5fhTpZmuReKmMxzFdCD6tsSZtfpYywUhFNkMRbJhddoVuyr8DSVQpuLxrM03d3fv
 yFWgpfT+2WhcfT0y/h+ywFsrDT3aYBp5vPINUCgPp9gLV5IxPe6yuGv87yZSIFI1ist2Iy9LalY
 Ewm35fhHGJkKOPDPk
X-Received: by 2002:a05:690e:42ce:b0:654:3fca:3515 with SMTP id
 956f58d0204a3-65bee3e6f3cmr924608d50.30.1777361554742; Tue, 28 Apr 2026
 00:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
 <20260416055948.130041-7-ilias.apalodimas@linaro.org>
 <6944f28f-131f-4a08-9ef9-aae812926f4b@mailbox.org>
 <CAC_iWj+ufWdroVDCh9qNAYfsjON5r_pdfOUgyB=h=b2b_rMVKg@mail.gmail.com>
 <8b87df2b-1904-4f2c-862d-924daff649e6@mailbox.org>
 <CAC_iWj+1PNaGjX5DH3hA4iednKruydKjy-0YoXuWTCJHmPVCDA@mail.gmail.com>
 <73312691-c9a1-45a6-be3d-232949432b60@mailbox.org>
In-Reply-To: <73312691-c9a1-45a6-be3d-232949432b60@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 Apr 2026 10:31:58 +0300
X-Gm-Features: AVHnY4I40m-G_TxsjtKeVHXxMiO_pWqAap-LmWdK_OD5QeyV0eo5YhMrg6Uea4c
Message-ID: <CAC_iWj+bT0Ab_MuGWa5seQBQ4WaAGSqWnPvZ=D9G2SgBH0X0Dg@mail.gmail.com>
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

On Tue, 28 Apr 2026 at 09:43, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 4/27/26 4:33 PM, Ilias Apalodimas wrote:
>
> [...]
>
> >>>>> +++ b/common/board_f.c
> >>>>> @@ -339,7 +339,22 @@ static int setup_ram_base(void)
> >>>>>     static int setup_ram_config(void)
> >>>>>     {
> >>>>>         debug("Monitor len: %08x\n", gd->mon_len);
> >>>>> -#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
> >>>>> +
> >>>>> +     if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
> >>>>> +             int bank;
> >>>>> +             phys_size_t total_size = 0;
> >>>>> +
> >>>>> +             for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> >>>>> +                     if (gd->ram_top <= gd->bi_dram[bank].start)
> >>>>> +                             gd->ram_top = gd->bi_dram[bank].start +
> >>>>> +                                             gd->bi_dram[bank].size;
> >>>>> +                     total_size += gd->bi_dram[bank].size;
> >>>>> +             }
> >>>>> +             gd->ram_size = total_size;
> >>>>
> >>>> Shouldn't this also apply board_get_usable_ram_top() to be consistent ?
> >>>
> >>> Simon asked the same thing. I'd rather keep this option strict for now
> >>> and always relocate to the upper memory boundary fnor now. Once I do
> >>> further cleanups, I can either add it or remove the function entirely
> >>> since dram_init_banksize() (which hs also board specific) runs really
> >>> early now.
> >>
> >> Maybe the default board_get_usable_ram_top() can return the ram top if
> >> CONFIG_IS_ENABLED(RELOC_ADDR_TOP) ? That would still allow users to use
> >> board_get_usable_ram_top() consistently to reduce the ram top.
> >
> > dram_init_banksize() can be used instead now to reduce that and we can
> > remove this option eventually. Is there anything that we can't achieve
> > with only that ?
> I think I might be confused, but it seems board_get_usable_ram_top() is
> used to set gd->ram_top , which is U-Boot's top of RAM and may not be
> the same as physical top of RAM . So no, dram_init_banksize() has to
> configure the correct physical RAM topology, board_get_usable_ram_top()
> can be used to make space at ram_top unavailable to U-Boot .

I don't think you are confused but what I am trying to do with this
option here is make the process of relocating to the last bank
standard. So people that want U-Boot to calculate the reloc address
based on the information they initalized on dram_init_banksize() _ the
reserved DT regions should enable this option. if they have their own
per board calculation logic, they can leave it as is, in which case
we'll still call board_get_usable_ram_top().

Cheers
/Ilias
