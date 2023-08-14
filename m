Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EB7EB64DD
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 18:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C07B86844;
	Mon, 14 Aug 2023 20:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oMNmwTsT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58BBC868D0; Mon, 14 Aug 2023 20:31:15 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4514B86828
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 20:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-563e21a6011so3472424a12.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692037871; x=1692642671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MPhNB+LyjZYopE6SUXheOjjx/BXuwmgjtJ+x8BGb9pg=;
 b=oMNmwTsTCPN2cUe7lPCvKXoSM0h2i21eChLNCg0z1He/+861CSAGC89M3h5seaNFzC
 eMdlyCjgdHiG9WdvNx1K5D2p8NFZWeqdf5h1xdAl07h8ySyIoVfM8GD3+LU53s0G0PFy
 XrN0F51+umxQgSeNc7iza+KaVnQgFiK46HPumoTPg4TKlr1RriB+ANh/qMR1uwaQ8B8f
 K1/NscMW/EajnBrq+3xLcYWc6ODBcetpNi4/9QqOmnomzQKkN98ZbszmO6ExvKzsx/qk
 Y9exp/bqVlyb05oxq00jvwqvlEdbh34N6Je+cji7HWJOHJGu89vaC80CWFWVu/MOI01H
 yr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692037871; x=1692642671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MPhNB+LyjZYopE6SUXheOjjx/BXuwmgjtJ+x8BGb9pg=;
 b=edGMeMJzfcWBMsZ9wEpjaRteuxhENOIlIyxFIMUk4uyV/eeKYWbGAAyhdgJde4g7NG
 shixE69oF0LUR6rBeFu6GRE2P8z+1jnrxc7PzMxsHOYYIZfSD1y1dwzBcbe72KHwxkxM
 q67Jzb57pPRFLePGnke/6kSnhWYDN+Z7R7/Xl64NuVJQDrcTE7fl1vRzN/bBmJ+9Kmta
 oqxicaZmdob6GoYr0SUIkm85qq1HP/d02n0DGKgdIrSNRSx2eP0HkxUS4TdIhqPSxs/y
 27YZ9ZxL55MDsJ+7JVR46We03hbvPRG4DfGf80y6+q+fSEXNuh7UGjI3h2O++w+R9JPe
 UHBA==
X-Gm-Message-State: AOJu0Yx2eEMFhUxqF+LG5Qs2Vf+DR/Ol04fogq7wvxcCa0cZZOuD5Mfu
 XvaewNfPqQI2SJFy5ottmAc=
X-Google-Smtp-Source: AGHT+IFDEFdThfYRu3nkePiQ7uCRjdmYy7zbmjhuG0/XZwLrDk+wZUWHZw1kPZEqRMAyITBw42Fqig==
X-Received: by 2002:a17:90a:a883:b0:267:fb26:32bd with SMTP id
 h3-20020a17090aa88300b00267fb2632bdmr8635378pjq.7.1692037871520; 
 Mon, 14 Aug 2023 11:31:11 -0700 (PDT)
Received: from [10.64.107.252] (static-198-54-134-172.cust.tzulo.com.
 [198.54.134.172]) by smtp.gmail.com with ESMTPSA id
 s88-20020a17090a69e100b00265c742a262sm8972803pjj.4.2023.08.14.11.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Aug 2023 11:31:10 -0700 (PDT)
Message-ID: <95603ff4-9cf2-c20d-3c17-84135bb931a2@gmail.com>
Date: Mon, 14 Aug 2023 12:31:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] Allwinner R528/T113s PSCI
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>
References: <20230812003055.74527-1-CFSworks@gmail.com>
 <20230814150648.1dddd00d@donnerap.manchester.arm.com>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20230814150648.1dddd00d@donnerap.manchester.arm.com>
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

On 8/14/23 08:06, Andre Przywara wrote:
> Hi Sam,
> 
> many many thanks for sending this, I especially like your clean up around
> the #ifdef's!
> 
> The patches looks good on the first glance (apart from some regression in
> patch 3/3), but I will reply to them individually.
> 
> Cheers,
> Andre

Thanks for your attention to these! While you're in a PSCI headspace, 
could you also look at my patch titled:
sunxi: psci: remove redundant initialization from psci_arch_init

...dated May 31?

This one should be pretty uncontroversial and straightforward to review. :)

Many thanks,
Sam
