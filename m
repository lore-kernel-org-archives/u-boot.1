Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C155C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 849D687884;
	Mon, 23 Oct 2023 09:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MWeSqotN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3156F87895; Mon, 23 Oct 2023 09:58:16 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E655587816
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53f9af41444so4700384a12.1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698047892; x=1698652692; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TLR1zoZDpmovpdSg6WGO/dBx9B1XggtrroWlsbTeyE4=;
 b=MWeSqotNztcOhHF83SmzKOsHkt5GopQ0DYTEPn+/S/mWI+JhFVKMJX5xRYV/Ik6WTu
 D9up+EycGJkp0EfBDPDO5BsVBqFX4wxQSneInhAVygFU8gBRKJnjhxAdp0nOSfvKXvh/
 HSugLTxit+8Te51qM0yfCWotYrPYDxYW6NswM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698047892; x=1698652692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TLR1zoZDpmovpdSg6WGO/dBx9B1XggtrroWlsbTeyE4=;
 b=A+oUuv8jpMgiX9GWhkVeZqzrMQvoDdY3aZBbcmsYfQXg9oewqQppbG8NPwb7VDaRLP
 K7H1TMNr9EMmqFOsbDIJ1xOZKvW3m6BqUDNq/vwj+O+TkadTt8GGBXKhW6i928e8+9af
 htuaswmBrDfkOkpW85PM1tQK2skd/N24+70yAB9f4bdJb0bFPo7LoHWhVGC9DgRV6ZSc
 GPSaaRG2rPEXZwAf9xYMXcrO2vO2j1oxIeFW23KnC7GGMNYqIH6sPIT3IRE70RptNPxe
 2014jV2XSYtlclo3fu/f4Q7Dy622/tNeQd/Tto4xoHd5odx8LbNfeifGysiwhTMbtmDa
 4EEw==
X-Gm-Message-State: AOJu0YyDktBtZIBeX1st+9CvxlwDJsB3dtN3w4GzTbKOWyOKyyz7kkCK
 N8qVOn4fN6DCT6B5QaSJkX4a6tcFh2BAHEwZlzRKzw==
X-Google-Smtp-Source: AGHT+IFMJqdrlHxWLz9YacjzGiepH4tWwbfGdOGP5zAm0Tz3CpgvGHqWNtLBPkTUbXhk77k0QaipdwHr/u/YH1db+Zg=
X-Received: by 2002:a17:907:1c85:b0:9b2:6d09:847c with SMTP id
 nb5-20020a1709071c8500b009b26d09847cmr5741272ejc.10.1698047892093; Mon, 23
 Oct 2023 00:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231006100737.343745-1-n-francis@ti.com>
 <20231006100737.343745-2-n-francis@ti.com>
 <CAPnjgZ2RAwdZxZMccwcLL5QLs-HyBcx6B=LLKfVSjSb0qpjGxg@mail.gmail.com>
 <c052dc27-e919-4f62-a104-4412954e7032@ti.com>
 <CAPnjgZ2RvujUiVrhpb-v7Z94JTyP=1e6ptc=mC7A6rVF9NZxdQ@mail.gmail.com>
 <cf363bf1-68ed-4fa9-8ac5-24326f774cac@ti.com>
 <CAPnjgZ0X_DMjaPkxKLHigugPVdj4hnLpsOUuNL9MudJRd4a3_g@mail.gmail.com>
 <303b9e75-31c4-41a3-b96f-762c66cd839f@ti.com>
In-Reply-To: <303b9e75-31c4-41a3-b96f-762c66cd839f@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Oct 2023 00:57:54 -0700
Message-ID: <CAPnjgZ0mKArhgCkS76mE7bwx5Ltx89D9+87_4Fva5AwpJixyaw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] binman: openssl: x509: ti_secure_rom: Add support
 for bootcore_opts
To: Neha Malcom Francis <n-francis@ti.com>
Cc: trini@konsulko.com, alpernebiyasak@gmail.com, u-boot@lists.denx.de, 
 vigneshr@ti.com, u-kumar1@ti.com, a-nandan@ti.com
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

Hi Neha,

On Mon, 23 Oct 2023 at 00:06, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> Hi Simon
>
> On 19/10/23 19:25, Simon Glass wrote:
> > Hi Neha,
> >
> > On Tue, 17 Oct 2023 at 23:20, Neha Malcom Francis <n-francis@ti.com> wrote:
> >>
> >> Hi Simon
> >>
> >> On 18/10/23 09:03, Simon Glass wrote:
> >>> Hi Neha,
> >>>
> >>> On Tue, 17 Oct 2023 at 03:58, Neha Malcom Francis <n-francis@ti.com> wrote:
> >>>>
> >>>> Hi Simon
> >>>>
> >>>> On 08/10/23 04:39, Simon Glass wrote:
> >>>>> Hi Neha,
> >>>>>
> >>>>> On Fri, 6 Oct 2023 at 04:07, Neha Malcom Francis <n-francis@ti.com> wrote:
> >>>>>>
> >>>>>> According to the TRMs of K3 platform of devices, the ROM boot image
> >>>>>> format specifies a "Core Options Field" that provides the capability to
> >>>>>> set the boot core in lockstep when set to 0 or to split mode when set
> >>>>>> to 2. Add support for providing the same from the binman DTS. Also
> >>>>>> modify existing test case for ensuring future coverage.
> >>>>>>
> >>>>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> >>>>>> ---
> >>>>>> Link to J721E TRM: https://www.ti.com/lit/zip/spruil1
> >>>>>> Section 4.5.4.1 Boot Info
> >>>>>>
> >>>>>> Changes in v3:
> >>>>>>            - updated function comments
> >>>>>>            - removed inconsistency in setting bootcore_opts to 32
> >>>>>>
> >>>>>> Changes in v2:
> >>>>>>            - included TRM link in commit message
> >>>>>>
> >>>>>>     tools/binman/btool/openssl.py           |  6 ++++--
> >>>>>>     tools/binman/entries.rst                |  1 +
> >>>>>>     tools/binman/etype/ti_secure_rom.py     | 11 +++++++++--
> >>>>>>     tools/binman/etype/x509_cert.py         |  3 ++-
> >>>>>>     tools/binman/test/297_ti_secure_rom.dts |  1 +
> >>>>>>     5 files changed, 17 insertions(+), 5 deletions(-)
> >>>>>>
> >>>>
> >>>> [...]
> >>>>
> >>>>>> diff --git a/tools/binman/test/297_ti_secure_rom.dts b/tools/binman/test/297_ti_secure_rom.dts
> >>>>>> index d1313769f4..1a3eca9425 100644
> >>>>>> --- a/tools/binman/test/297_ti_secure_rom.dts
> >>>>>> +++ b/tools/binman/test/297_ti_secure_rom.dts
> >>>>>> @@ -9,6 +9,7 @@
> >>>>>>            binman {
> >>>>>>                    ti-secure-rom {
> >>>>>>                            content = <&unsecure_binary>;
> >>>>>> +                       core-opts = <2>;
> >>>>>
> >>>>> here ^
> >>>>>
> >>>>> Do you think there could be a binding file in dt-bindings/ for this value?
> >>>>>
> >>>>
> >>>> Sorry for getting back to this patch so late, but wanted to ask about this. I
> >>>> had seen a last version of getting the binman compatible in dt-bindings but I
> >>>> don't see it merged. Not sure where I would add this property in.
> >>>
> >>> Yes it is difficult to do anything genuinely new.
> >>>
> >>> I am anticipating something like compatible = "ti,secure-rom"
> >>>
> >>> so I suppose you could create a header file with suitable values for
> >>> this property.
> >>>
> >>> On the other hand, you could wait until there is progress with the bindings.
> >>>
> >>>
> >>
> >> I can try adding a header file for now, but follow up question; shouldn't it be
> >> added to arch/arm/dts rather than include/dt-bindings? There was traction by DT
> >> maintainers to move all such constants not directly used by the driver (in this
> >> case binman) to arch/arm/dts? [1] If you mean to use these constants in binman,
> >> will need to see how we can do that.
> >
> > You can put the constant in the .dtsi and #include your binding file.
> > But if you hit problems, let's worry about it later.
> >
>
> I'm a little confused on what has to be done regarding the binding ATM, so I'll
> stick to waiting for some progress with the binman bindings and then tackle it.
>

Yes that sounds fine.

> >>
> >>>>
> >>>>>>                    };
> >>>>>>                    unsecure_binary: blob-ext {
> >>>>>>                            filename = "ti_unsecure.bin";
> >>>>>> --
> >>>>>> 2.34.1
> >>>>>>
> >>> Regards,
> >>> Simon
> >>
> >> [1] https://lore.kernel.org/all/c4d53e9c-dac0-8ccc-dc86-faada324beba@linaro.org/
> > Regards,
> > Simon
>

Regards,
Simon
