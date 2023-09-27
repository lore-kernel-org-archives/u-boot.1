Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01559E7F14F
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 23:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6E5686BE7;
	Thu, 28 Sep 2023 01:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S5rZAaW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DD6786C37; Thu, 28 Sep 2023 01:28:56 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E7B486A24
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 01:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-79fa416b7ffso377302239f.2
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 16:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695857333; x=1696462133; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DDKdRL2dzuR+VBAPhrewl8Bmsfc6TVB5eSHZARgNO9s=;
 b=S5rZAaW61OZmPRGDggHvxXJGrIPjMnSVG3DeTorz8O00DwPn3yaUJzu8XlBV/ma+n2
 GMg5pwNY1LJfJD91PKLLqvKM/Mg1kwggwMd6n04KW8PWA01TO5k9Btxzbnkf/jobp7AG
 QBGXDYGOJUq73DXWIm4b1WeFezN7RwPX3Fksrj5tDfqWOP29uAxwo5TkFXaLqyRRQSzk
 IfoX7m4J20u1Ss23h0F/CwSMtBV1AEI2TRpWgkHu3fC9XbiQIfqxGOvpR+zgLcJOZz8E
 Vo++72t+jkzt1eYQHSBL4Fat/ARqsDc7/J9+/8HLdJn/2G0W6jsrtZq/WdVuu6fNWdXk
 L+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695857333; x=1696462133;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DDKdRL2dzuR+VBAPhrewl8Bmsfc6TVB5eSHZARgNO9s=;
 b=MvX0uFHNJGG9fav1layJ6jUmxZRfv4Q/feIAfAyXmvq8Ep3/qMv7drhopaLlkrt4VL
 OQZQJcF0mu1ijtHEUChPUZpxn4L1K17p1vGD5DsQwIG0k6S8qmAb0QRgdorwcpVxIuZH
 3zFgyO3nB36maaTO8vw1Hq5Lz25BohzWPyoJyeJFAIbYKr/3tUXULsOSYCfiSjLGfR8s
 ypt261bP2bDKUTF3ZzTelRGo/l7h8xQJZlGPoQ2sD4dfU8NNvy/MjoPPKDgbc6O5ISSL
 QhAYgkfV2dnDnys9QtcSQhCHs/aLWLI6O4WmrIkMyszCyEWpiG7058bmMJyWSFs5uWQP
 5xHg==
X-Gm-Message-State: AOJu0Yy4W4NKSoEc9rwQU93OUXn6Tc2RDX79nkAaFemMRAWP85ICvM9A
 Lcs3C4DjaHy9ktWmf0okx/4=
X-Google-Smtp-Source: AGHT+IFb6YjQXVjWxjZYFWYoWujgpUEJiSb8jMBdwZIiIIE2LNOuYSDkDmU/NFO5hmEj/76cOoiQjQ==
X-Received: by 2002:a5e:c818:0:b0:783:5209:c01 with SMTP id
 y24-20020a5ec818000000b0078352090c01mr3934192iol.17.1695857332893; 
 Wed, 27 Sep 2023 16:28:52 -0700 (PDT)
Received: from ?IPV6:2001:470:42c4:101:e9f:af6b:c19f:be24?
 ([2001:470:42c4:101:e9f:af6b:c19f:be24])
 by smtp.gmail.com with ESMTPSA id
 d26-20020a02a49a000000b004290fd3a68dsm4097552jam.1.2023.09.27.16.28.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 16:28:52 -0700 (PDT)
Message-ID: <123596d6-f7c8-f7f1-9a0a-07f68a5ed1b8@gmail.com>
Date: Wed, 27 Sep 2023 17:28:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/5] HACK: sunxi: psci: be compatible with v1 of R528
 patchset
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>
References: <20230816173420.83232-1-CFSworks@gmail.com>
 <20230816173420.83232-6-CFSworks@gmail.com>
 <20230927173221.122c8de2@donnerap.manchester.arm.com>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20230927173221.122c8de2@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/27/23 10:32, Andre Przywara wrote:
> On Wed, 16 Aug 2023 10:34:20 -0700
> Sam Edwards <cfsworks@gmail.com> wrote:
> 
> Hi Sam,

Hi Andre,

> Mmh, I didn't find a better solution than keeping this in.

I'll keep it if your R528 v2 doesn't find some other way to address it.

>> +#endif
>> +#if defined(SUNXI_CPUX_BASE) && defined(SUNXI_CPUCFG_BASE)
>> +#undef SUNXI_CPUCFG_BASE
>> +#define SUNXI_CPUCFG_BASE SUNXI_CPUX_BASE
> 
> So what's the story with this? Do we name this differently
> (SUNXI_CPUX_BASE) because the IP block is different from the other SoCs?
> Or is there another SUNXI_CPUCFG IP block on the R528/T113s SoCs?
> 
> If not, I think we should use the SUNXI_CPUCFG_BASE name directly in
> cpu_sunxi_ncat2.h, as we never claimed that same names for some MMIO
> address blocks means they are compatible.
> 
> Please let me know if I miss something.

That's just for compatibility with R528 series v1. It's expected that 
you'll rename it to SUNXI_CPUCFG_BASE for v2. The preprocessor trickery 
looks for *both* being defined and applies the update. The rest of the 
code proceeds using SUNXI_CPUCFG_BASE. (Keep in mind this is particular 
patch is a hack patch, it's not considered for inclusion.)

Warm regards,
Sam
