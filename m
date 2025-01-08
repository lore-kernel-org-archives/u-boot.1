Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CF9E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 14:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D439800DF;
	Wed,  8 Jan 2025 15:20:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AMbV5y9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2331803DC; Wed,  8 Jan 2025 15:20:52 +0100 (CET)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F40878006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 15:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-51873e55d27so549585e0c.1
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 06:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736346049; x=1736950849; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PBweJS+9MTVOuFprPZ1vuboDEM93WDMvg1FybDwNgQE=;
 b=AMbV5y9vqinHiMLBQv/O56X9vTIH6LyjnpR/YzuZwc+PG4likFN3zhwBuEmpt5GVPc
 pfiz62KRHNC8KWyOGvtrebb+P1Em+ZTNAOTOFAQ5GdUV1UfJPb+JBoy5Re5Y+roHYCaZ
 kow9zaIdpw6PPL2YHbGdhqTbO3diC37QNWMR7B2FIRWui44LKftN1DKvrUm7NsVSj/Jp
 7vEJgc1b5QC0r5z3oUNgqUzuYNZayFniaaqUmO9YJcciWRz5D2Z2VLEfw8I3KrpoZt8W
 zW3y5J2MEptYA4fEhX8EQHUkGuM2p9osHvNBuNe/FHV0x0qWyDYeHkw5Uhuw6NDwj3NN
 XTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736346049; x=1736950849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PBweJS+9MTVOuFprPZ1vuboDEM93WDMvg1FybDwNgQE=;
 b=pciIUwiymaI57FbWhxiAgkZN4hYm8hUUwvKXRr5Ki8ldWOEw0mCXkWuvptCMqj9eDO
 BUoeRVMWIPRT/utJNiQ0vSweNYnn4w8no0DdO2DgNQ2f3ZGxr43Vr7hjYogo23YuHp1/
 k6C1WVWqkanmuR09VNN+pcwRLYIzZwxynTeJ2XDGWxcvsb1+pNQmag9IUs4SZTmAd7jx
 gXNWRS+UgXr/EVtiA50qlBd3/qNZElN5EgJ5Al8r3C5TBLFnWh+ZOk2TwYXKBRC9HZ6I
 kdyBmHnz/eJtYrgNVYdog0x5SuP7xRBO/w1jwWVbUVpwNGkH8MjUgRcVw+W34zkmmumK
 IENA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF1K5m8kxaHKyVtATay8R3d4d5/H4/3xg4JyG9Whi2TaU2ZSRAZ5gowP4TiGALo6c2EE/IggE=@lists.denx.de
X-Gm-Message-State: AOJu0YyfSkbQSKK9NlZMtb/YvaFemSPoEfndpteAszqrfjgUGWyndc25
 E4FrEqv0mScuFxrZktPQeUy/kJh+8DCtc8lCKjxJv9o4dNhgbF1WU8GmeEiG6CVlf9IhLXHDeKW
 h06e+jL2g7U/cLWIWZlewhSz0jiiNIMAWqgUd5w==
X-Gm-Gg: ASbGncuc+6IxmGX2jqDvNywhV5aDE4avOrs+UcvNcsN+eifL7Q/bW66yTv2uwhsGA5e
 lNebP4aLLaX6svybRVJNZrSh1qOaOpqyUc+ze8c7s
X-Google-Smtp-Source: AGHT+IE2vEdd3hAZ678Xd/qdJ9u5ggpVB2NlA+98849y2IW2OUmSHkNjBK6ubRIeEh+JBTNGmg6q34hIY50nrTcLCs4=
X-Received: by 2002:a05:6122:1e07:b0:516:dc0f:c925 with SMTP id
 71dfb90a1353d-51c5e5fd62dmr4521167e0c.6.1736346048719; Wed, 08 Jan 2025
 06:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20250103051404.1965469-1-quic_varada@quicinc.com>
 <20250103051404.1965469-2-quic_varada@quicinc.com>
 <1ae282b0-8e68-4360-b3d2-73a10b7b8f37@linaro.org>
 <Z3zyuZZ0TA47KXpZ@hu-varada-blr.qualcomm.com>
 <909dc9b6-fb70-45c7-83f2-74c89b5049a5@linaro.org>
 <Z34RRETdZn8rDhYe@hu-varada-blr.qualcomm.com>
 <a56b87c0-0e70-4e0b-aeb7-9f10b2c7c6d0@linaro.org>
In-Reply-To: <a56b87c0-0e70-4e0b-aeb7-9f10b2c7c6d0@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 8 Jan 2025 19:50:37 +0530
X-Gm-Features: AbW1kvZTkkhKw18GzYJXfj9QQbP1QOA-kTeVnZdoTR5jwh5vRtzyNjthU_BFUG4
Message-ID: <CAFA6WYPkOTb_tM86AEbUyJ4LJxu=9_f2ZQe3rQzZmy8K6uBbvg@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dts: sa8775p-ride-r3-u-boot: add override dtsi
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: neil.armstrong@linaro.org, trini@konsulko.com, lukma@denx.de, 
 seanga2@gmail.com, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 Volodymyr_Babchuk@epam.com, lehmanju@devpi.de, bhupesh.linux@gmail.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Wed, 8 Jan 2025 at 19:36, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 08/01/2025 06:46, Varadarajan Narayanan wrote:
> > On Tue, Jan 07, 2025 at 12:36:23PM +0100, Caleb Connolly wrote:
> >>
> >>
> >> On 07/01/2025 10:24, Varadarajan Narayanan wrote:
> >>> On Fri, Jan 03, 2025 at 04:17:14PM +0100, neil.armstrong@linaro.org wrote:
> >>>> On 03/01/2025 06:14, Varadarajan Narayanan wrote:
> >>>>> Add initial support for the QCS9100 (derived from SA8775p) Ride platforms.
> >>>>> Define memory layout statically.
> >>>>>
> >>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >>>>> ---
> >>>>>   arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi | 22 ++++++++++++++++++++++
> >>>>>   arch/arm/dts/sa8775p-ride-u-boot.dtsi    | 11 +++++++++++
> >>>>>   2 files changed, 33 insertions(+)
> >>>>>   create mode 100644 arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
> >>>>>   create mode 100644 arch/arm/dts/sa8775p-ride-u-boot.dtsi
> >>>>>
> >>>>> diff --git a/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
> >>>>> new file mode 100644
> >>>>> index 0000000000..7d01d5f6a1
> >>>>> --- /dev/null
> >>>>> +++ b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
> >>>>> @@ -0,0 +1,22 @@
> >>>>> +// SPDX-License-Identifier: BSD-3-Clause
> >>>>> +/*
> >>>>> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> >>>>> + */
> >>>>> +
> >>>>> +/ {
> >>>>> + model = "Qualcomm QCS9100 Ride Rev3";
> >>>>> + compatible = "qcom,qcs9100-ride-r3", "qcom,qcs9100", "qcom,sa8775p";
> >>>>
> >>>> Why do you redefine those ? they are already defined in the upstream sa8775p-ride-r3.dts
> >>>
> >>> To include QCS9100 info to the model and compatible strings,
> >>> so that users might not get confused if a wrong U-Boot has
> >>> booted on the platform.
> >>
> >> They are already defined in dts/upstream/src/arm64/qcom/sa8775p-ride-r3.dts
> >>
> >> That file is patched at build time to include this dtsi file at the end.
> >
> > [1] defines it as "Qualcomm SA8775P Ride Rev3". We want to define
> > as "Qualcomm QCS9100 Ride Rev3", i.e. s/SA8775P/QCS9100/. That is
> > why having it here. This would not be needed once [2] gets into
> > U-Boot.
>
> hmm I see, well that's a pickle. I don't think we have a process yet for
> handling these cases where we're blocked on a DTS sync.
>
> I would rather avoid creating this weird situation where we use the
> sa8775p dts and pretend it's a different board especially if it's only
> temporary until the proper dts lands.
>
> Some proposals:
>
> 1. remove the model/compatible properties assuming the sa8775p-ride-r3
> board using the same memory map, add another u-boot dtsi for
> qcs9100-ride-r3 once it's merged in
> 2. import qcs9100-ride-r3.dts into arch/arm/dts in u-boot as part of
> this series (but need to remember to remove it later!)

> 3. somehow cherry-pick the relevant patch into the subtree early

This is the preferred approach, following should create a cherry-pick
patch for this platform on top of next branch:

$ ./tools/update-subtree.sh pick dts db6231faa8ef46e5ff5d5ece0c930a07c6358562

Then you should rather include that cherry picked patch in this
patch-set instead. The next DT sync will take care of it
automatically.

-Sumit

> or ask
> Tom to sync the DT subtree
> 4. wait for the next sync which hopefully won't be too long(?)
>
> I'd be ok with 1 or maybe 2 for this specific case, I'll see if 3/4 are
> viable for the future.
>
> Feel free to pick one of those approaches and respin if that works for you.
>
> Kind regards,
> >
> > 1. https://source.denx.de/u-boot/u-boot/-/blob/master/dts/upstream/src/arm64/qcom/sa8775p-ride-r3.dts
> > 2. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dts
> >
> > Thanks
> > Varada
> >
> >>> Please let me know if this should still be removed.
> >>>
> >>> Thanks
> >>> Varada
> >>>
> >>>>> +
> >>>>> + /* Will be removed when bootloader updates later */
> >>>>> + memory@80000000 {
> >>>>> +         device_type = "memory";
> >>>>> +         reg = <0x0 0x80000000 0x0 0x3ee00000>,
> >>>>> +               <0x0 0xc0000000 0x0 0x04d00000>,
> >>>>> +               <0xD 0x00000000 0x2 0x54100000>,
> >>>>> +               <0xA 0x80000000 0x1 0x52d00000>,
> >>>>> +               <0x9 0x00000000 0x1 0x80000000>,
> >>>>> +               <0x1 0x00000000 0x2 0xf7500000>,
> >>>>> +               <0x0 0xd0000000 0x0 0x00100000>,
> >>>>> +               <0x0 0xd3500000 0x0 0x07c00000>;
> >>>>> + };
> >>>>
> >>>> Ack, this should be removed once the SMEM code is merged.
> >>>>
> >>>>> +};
> >>>>> diff --git a/arch/arm/dts/sa8775p-ride-u-boot.dtsi b/arch/arm/dts/sa8775p-ride-u-boot.dtsi
> >>>>> new file mode 100644
> >>>>> index 0000000000..979462dfec
> >>>>> --- /dev/null
> >>>>> +++ b/arch/arm/dts/sa8775p-ride-u-boot.dtsi
> >>>>> @@ -0,0 +1,11 @@
> >>>>> +// SPDX-License-Identifier: BSD-3-Clause
> >>>>> +/*
> >>>>> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> >>>>> + */
> >>>>> +/dts-v1/;
> >>>>> +
> >>>>> +#include "sa8775p-ride.dts"
> >>>>
> >>>> Why ? this file will be automatically appended to sa8775p-ride.dts, no need to import is before.
> >>>>
> >>>>> +/ {
> >>>>> + model = "Qualcomm QCS9100 Ride";
> >>>>> + compatible = "qcom,qcs9100-ride", "qcom,qcs9100", "qcom,sa8775p";
> >>>>
> >>>> Same, unneeded.
> >>>>
> >>>> In fact, this file is completely unneeded.
> >>>>
> >>>>> +};
> >>>>
> >>>> Neil
> >>>>
> >>
> >> --
> >> // Caleb (they/them)
> >>
>
> --
> // Caleb (they/them)
>
