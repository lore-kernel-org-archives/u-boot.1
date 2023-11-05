Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8522BC4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 21:54:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BC3D86E75;
	Sun,  5 Nov 2023 22:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Pdfle4Ih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1E6686E47; Sun,  5 Nov 2023 22:54:18 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B34AA86E47
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 22:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E25F43FA95
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 21:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699221254;
 bh=GYjwEylvZ6aTZRXGX1UAo7APcYpk46vjmmkPuZVulkk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Pdfle4Ih3/WcFxR28IrvBTvJq/GQAatvqtuaJNYmdOroguHRf9LhE272BEZH9eJOn
 OR+5ZcwmNFP+dtHyxdQpWWGzzBUCUKASDb5EwPkPEIF/iYeb/JSMSjPwalFHw1kNKB
 ja43+W66LvHNrHm5IR02iWI9QoiCRnGOKq3HbwxcOOXDPIkC+nRPhh3r5WY+nBPrqJ
 nqbqgr3HlXBHmKo8QwpBqVG2LUem3zpkeXfe0fDc/EuRvDosZY9xhmgFFD4kPesHsA
 xBRenI9rve/fWhWYuMe4V16ObArEotm5P0COJaV/17PnvUPpU6IeWiHLtBqx6eXdXU
 xJsH4/BT168aQ==
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2804e851d5cso3331776a91.0
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 13:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699221253; x=1699826053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GYjwEylvZ6aTZRXGX1UAo7APcYpk46vjmmkPuZVulkk=;
 b=sp0VCc9qC6WZD/KhgkbKM4IhzkD9xMrEEtH31T+3ZI9xhLqy5y33MfTH/t7/tL7dGL
 3loQImQnYE10FLQ7bmbxbsI4/vgOVe83Jg+dyn/PlUYd8wBCbRf28P2eaLdSKTe3y1PN
 j+zqjLP0Jze3U5+xt7mt4V+GT4wV1iPTaJnvzpJTCLZ09BNcCUgEJ95JTZmHC0fOzVGm
 b/BBy/S1QY+OWexs9xdTyRyraw0OUIxBPSaRqyMhLARPK3if862wRn+Jzf3cQ/SmR5/D
 5nBLDSPpsKwyArfaZX76qKXwuzDatGh8CTseYwshV26AQh90PApF6fkZ1xMtYJ3qeP95
 IhPA==
X-Gm-Message-State: AOJu0YzlYGH9lJGnb6ue7xbxCAWja4q2z5WD60s2aQs+oNBdmmqa85Ts
 dRa3fvf5r5a9C13lsy1DwvyYBISDPxG4KvkEu4iYqJz5aQ/NghdEh0TcCTzODfx2094gL33ZPtd
 ZM2CcwREKYZNjHNPmR/gnYZO7pOnN3pU=
X-Received: by 2002:a17:90a:19ce:b0:280:2985:56af with SMTP id
 14-20020a17090a19ce00b00280298556afmr22528860pjj.45.1699221253122; 
 Sun, 05 Nov 2023 13:54:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE6MWlQyA7winWglBasnX3BxfG7bSukWtCXrSQTAwbdUKXMFmof8TtmVYaCH2Df9LLKSvPcA==
X-Received: by 2002:a17:90a:19ce:b0:280:2985:56af with SMTP id
 14-20020a17090a19ce00b00280298556afmr22528848pjj.45.1699221252748; 
 Sun, 05 Nov 2023 13:54:12 -0800 (PST)
Received: from [100.70.206.203] ([206.181.83.18])
 by smtp.gmail.com with ESMTPSA id
 18-20020a17090a199200b002810810cc80sm268291pji.37.2023.11.05.13.54.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 13:54:12 -0800 (PST)
Message-ID: <e0d4ec60-96fe-44c0-ac18-69b69bc14283@canonical.com>
Date: Sun, 5 Nov 2023 23:54:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] rng: detect RISC-V Zkr RNG device in bind method
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Xiang W <merlew4n6@gmail.com>, Andre Przywara <andre.przywara@arm.com>
References: <20231104065107.23623-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ36uRkVGKicr_hD-=0HO+i9giQ7vRxo0uKD+BGQnLWdWw@mail.gmail.com>
 <874c3e34-56db-4f3a-acad-099d16735333@canonical.com>
 <CAPnjgZ3LHxNtf1RGRJzwT-9vF_03JdN_3SRF3o9QYNzshpp1cQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ3LHxNtf1RGRJzwT-9vF_03JdN_3SRF3o9QYNzshpp1cQ@mail.gmail.com>
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

On 11/5/23 18:25, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sun, 5 Nov 2023 at 03:47, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 11/4/23 21:42, Simon Glass wrote:
>>> Hi Heinrich,
>>>
>>> On Sat, 4 Nov 2023 at 06:51, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> The existence of devices should be checked in the bind method and not in
>>>> the probe method. Adjust the RISC-V Zkr RNG driver accordingly.
>>>>
>>>> Use ENOENT (and not ENODEV) to signal that the device is not available.
>>>>
>>>> Fixes: ceec977ba1a9 ("rng: Provide a RNG based on the RISC-V Zkr ISA extension")
>>>> Reported-by: Andre Przywara <andre.przywara@arm.com>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>>    drivers/rng/riscv_zkr_rng.c | 34 ++++++++++++++++++++++++++--------
>>>>    1 file changed, 26 insertions(+), 8 deletions(-)
>>>
>>> This device should be in the DT, so you have some control over which
>>> RNG is used.
>>
>> The device-tree provided by QEMU does not contain such a device as Zkr
>> is an ISA extension and not a device. This device-tree is not under the
>> control of the U-Boot project.
> 
> Why do you bring up QEMU? I would expect that it follows the norma dt
> bindings, so it should not be any different from real hardware?

Yes Simon, QEMU follows the normal bindings. If you want to change 
these, please, contribute to the RISC-V working groups or to the Linux 
kernel project.

> 
> Anyway, you could add it. It is just a binding. I believe RISC-V has
> all sorts of isa options which result in different machine features.
> 
> What are you going to do when you want to choose between the ISA RNG
> and a TPM one?

First of all there are different configurations switches for both 
drivers. But of course you can enable both. They will be different 
U-Boot devices. The rng command has a parameter to choose a RNG device 
by device number. This is not different to having two USB drives.

Best regards

Heinrich
