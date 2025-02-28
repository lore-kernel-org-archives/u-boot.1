Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A707C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D3A81197;
	Fri, 28 Feb 2025 11:58:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AAdXodhU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9937E811D8; Fri, 28 Feb 2025 11:58:46 +0100 (CET)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 595D381100
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-52096b4e163so842846e0c.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 02:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740740323; x=1741345123; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RO79H0tgzCem9kOuA6MrlI83V935EFj1PnNG0zGIWdA=;
 b=AAdXodhU0gAO/vKTLrrrtf2zRkDw+yUZY4pKWAkT87aT4KVgbxouVUfmFWVRxERIX7
 NkUck4aJJYKvPyH+7o67NNqJZWRfoEVfzhF2p5YwVpqIZIsQj9f3NVCjV75Hdfxi2btl
 rdCIddzgLsyXRo6d4x/qGPYJ0eRhM9lzEtEDZr0IjdT46iPnGLT20oh9eB9CyrkqUe1f
 UQExfQvxdMdmv9fYuYjKc6tbIHVUY1u8wO0kFWy+TXOdGrRVEiVuavFtsNGZ6Q6a8/u8
 C+Q9cptfaYBwBF9njvEKqfp+4jXTiQliQcNuUfoRxZ0CfeExl9RjqiT7trtb8aoJXZHg
 vwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740740323; x=1741345123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RO79H0tgzCem9kOuA6MrlI83V935EFj1PnNG0zGIWdA=;
 b=shONPzCJ2sSyxQO0WrXauOr9KyXryAVupbp7M219Ugd2mj1KQhwhDd9NJs8KWlHPhp
 BIrtZOAOu9OUs36Ht77kFxC/pXHNiL2nRy6nF2JEPepGBvpgFtaCaBpbBKES3uyD6Z26
 cCcS+YgwS9b++6O9wy5MLKFlmYuKs4bcF72ly6Ac4GEL0LHeJY7uQ+iG8le7ZfN1e+tg
 uoT+x9/AhLvK7SWy75lyumGEvnpEhRQpU3gbfSJvj7PdJIJXqgBKZ7qebIjSzszBoZk7
 /mIFMDo3LOP+SiZh6ptkQ6tlmcbEavJKgC48lSAlLR35sXHSYxOzBo8m22DCj7Ccx2mS
 1Unw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1ssB/z/JVFt6h63sKWLAvqF1aFjjHZaBcg1Q0X6hWg72jAPCsE1tSzFSpiNKeAxj5EhZem/k=@lists.denx.de
X-Gm-Message-State: AOJu0Ywkq7icTy9zdmTjI+tUYbZNgLHMBQOKrYZXG0a+egbnJfMXFlh6
 vUR1kRWG5DutGoV6rBVatYGuK5FNs0fFrhCaP/Z0bgLrj/sd+dluiEIbkPT6ISuM3aNGMOABLtI
 5ryJZ5faDhdnH0/q8ZknjSyebHuiTY4ZoaWJ3Jw==
X-Gm-Gg: ASbGnctvVzHptFdtPtMciGs6QZJHdVbY9im6tpnf09UVz4VTDB7Q5bHxeTsyaAwBV7W
 jS1bTgik1F9Usye6IRuLmuLcm6yKARlDhCUZVfwQWwEa87BPMlhJHm0Ay9djXZELzgu7jn/516C
 gNOq5WcGRrOg==
X-Google-Smtp-Source: AGHT+IE4/doG7LV2qgnLVoOlLhLamZo4sN+z/1WJrw1OSlVjSog++kh6xp7WTt3u3Eozq3KZd7TSMsQavoHdW+Zknqw=
X-Received: by 2002:a05:6122:2385:b0:520:43e0:8ea0 with SMTP id
 71dfb90a1353d-5235b8cd9b8mr1416226e0c.11.1740740323154; Fri, 28 Feb 2025
 02:58:43 -0800 (PST)
MIME-Version: 1.0
References: <20250227093559.797618-1-manikandan.m@microchip.com>
 <20250227093559.797618-2-manikandan.m@microchip.com>
 <CAFA6WYPEDujKz5jVW7ySynXi2T9kQWdJ+1MVBA1mGzMpBUMJmA@mail.gmail.com>
 <c2a277d8-b1bb-4b32-9245-81aba4ba13be@microchip.com>
 <4e339939-0427-44a3-8ce5-356c32e7411c@linaro.org>
 <40f5911d-6967-40a7-b4f4-a29679c8d909@microchip.com>
In-Reply-To: <40f5911d-6967-40a7-b4f4-a29679c8d909@microchip.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 28 Feb 2025 16:28:32 +0530
X-Gm-Features: AQ5f1JrzYGv8APM3gNcK0OM2XJHmmmDaC5QWddDe9BbYuKKd09UuixfbbFU9IEU
Message-ID: <CAFA6WYNw86eNNfBh6+omtuVFBDVzAPyU79B0s2eYfPY7U1exEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: clk: define additional PMC clocks
To: Manikandan.M@microchip.com
Cc: eugen.hristev@linaro.org, lukma@denx.de, seanga2@gmail.com, 
 kever.yang@rock-chips.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 festevam@denx.de, Oliver.Gaskell@analog.com, aford173@gmail.com, 
 prasad.kummari@amd.com, caleb.connolly@linaro.org, andre.przywara@arm.com, 
 neil.armstrong@linaro.org, mibodhi@gmail.com, Nicolas.Ferre@microchip.com, 
 Mihai.Sain@microchip.com, sjg@chromium.org, u-boot@lists.denx.de
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

On Fri, 28 Feb 2025 at 15:20, <Manikandan.M@microchip.com> wrote:
>
> Hi Eugen,
>
> On 27/02/25 7:48 pm, Eugen Hristev wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > On 2/27/25 12:37, Manikandan.M@microchip.com wrote:
> >> Hi Sumit,
> >>
> >> On 27/02/25 3:14 pm, Sumit Garg wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>
> >>> On Thu, 27 Feb 2025 at 15:06, Manikandan Muralidharan
> >>> <manikandan.m@microchip.com> wrote:
> >>>>
> >>>> Add PMC clock definitions for MCK and UTMI which will be required
> >>>> for the sam9x7 OF_upstream DT since the clock framework is not in
> >>>> sync with Linux and also include this header in 'clock/at91.h' file
> >>>
> >>> You should rather drop these local DT bindings headers which will
> >>> allow dts/upstream/include/dt-bindings/clock/at91.h to be included
> >>> automatically.
> >> Other SoC DTs where OF_UPSTREAM migration is not added yet, depends on
> >> the local DT bindings header, dropping this will lead to issues with
> >> compilation.
> >> We can drop this altogether when we sync the u-boot clock framework with
> >> Linux.
> >>>
> >>> -Sumit
> >>>
> >>>>
> >>>> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> >>>> ---
> >>>>    include/dt-bindings/clk/at91.h   | 3 +++
> >>>>    include/dt-bindings/clock/at91.h | 2 ++
> >>>>    2 files changed, 5 insertions(+)
> >>>>
> >>>> diff --git a/include/dt-bindings/clk/at91.h b/include/dt-bindings/clk/at91.h
> >>>> index a178b94157b..016c6e0c620 100644
> >>>> --- a/include/dt-bindings/clk/at91.h
> >>>> +++ b/include/dt-bindings/clk/at91.h
> >>>> @@ -24,4 +24,7 @@
> >>>>    #define USB_UTMI2              1
> >>>>    #define USB_UTMI3              2
> >>>>
> >>>> +#define PMC_MCK                        1
> >>>> +#define PMC_UTMI               2
> >
> > Where in the patch series do you need these defines ?
> >
> >>>> +
> >>>>    #endif
> >>>> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
> >>>> index ab3ee241d10..7235b3ba01e 100644
> >>>> --- a/include/dt-bindings/clock/at91.h
> >>>> +++ b/include/dt-bindings/clock/at91.h
> >>>> @@ -6,6 +6,8 @@
> >>>>     * Licensed under GPLv2 or later.
> >>>>     */
> >>>>
> >>>> +#include <dt-bindings/clk/at91.h>
> >>>> +
> >
> > I find this odd to include one at91.h in another at91.h
> >
> > Let's consider to remove one of these files in the future, and have just
> > one that is identical with the bindings one from Linux
> >
> > Meanwhile, let's see where do you need the PMC_*
> The PMC_MCK and PMC_UTMI are defined in the dts/upstream sam9x7 SoC DT.
> since during compilation the clock/at91.h from u-boot is used and to
> resolve the syntax issues I had to declare them in clk/at91.h and
> include the header in clock/at91.h
>
> if we drop the clock/at91.h from u-boot, the sam9x75 will pass using the
> includes from upstream Linux but will break other SoC that has not
> migrated to OF_UPSTREAM yet.
>
> Or we can align u-boot's clock/at91.h with Linux and drop clk/at91.h,
> replace it with clock/at91.h in drivers and DT.
> Please let me know if that works.

I would rather favor the U-Boot drivers and DT to directly use
dts/upstream/include/dt-bindings/clock/at91.h instead and drop local
DT bindings import. It then becomes easier for other SoCs to migrate
to OF_UPSTREAM too.

-Sumit

> >
> >>>>    #ifndef _DT_BINDINGS_CLK_AT91_H
> >>>>    #define _DT_BINDINGS_CLK_AT91_H
> >>>>
> >>>> --
> >>>> 2.25.1
> >>>>
> >>
> >
>
> --
> Thanks and Regards,
> Manikandan M.
>
