Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEC2EE4982
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 17:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E17A86E9A;
	Fri, 18 Aug 2023 19:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kxGaOMsy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDBE686E9C; Fri, 18 Aug 2023 19:40:34 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C38086E52
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 19:40:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6887ccba675so997086b3a.3
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 10:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692380430; x=1692985230;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tBHpOWId06CW8tvaYdewDHgVi2FR3qVK7sLLRbrZ5FE=;
 b=kxGaOMsy6rF+Mx+1sdF3QjT5Rp4irhOr4vtroNWKx8MOqIVZ8fKiFdyzYOAa8yXiIw
 NQRDq/+Ul0Ls9Jh10AGZInWBeB7t3w2/lkE1DyDOyKYd/KV2ywLFz5yOmT/XN1RNqZfy
 TJdczpiW8hQrPX58fQiM0re8QfTBU8cRExXQDM+NhCqItLiyMC7bSeP+f05fpsBu9Q0z
 5S2diV0YjeC4w/kg+cqvjYNbnbqAZAw0dMOb9SNqSRv0DcNBZbKmpatrrmNzcJNoUO+G
 RtGWWVUpOoAAGgTz/x3xG4CQNGTdR6/dEW5OnKKDTxbYhUyCN7rrtbZE+wU6o96uRMFY
 OJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692380430; x=1692985230;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tBHpOWId06CW8tvaYdewDHgVi2FR3qVK7sLLRbrZ5FE=;
 b=gv2mZLGyFnLCbjZ5fvNVWaO79aKgkDF46yyhVnkcVq7hFM60GIjuJWjtF5GKg21kGa
 kjPdo43FGlMAbDWJwL7JzH87chbPdhPmxVky2BrCOSuY/VTU6tPrlxhUm/o2NTtQknvl
 sDxGqektSDMvibCeR++VYEWji0zBnxaM7iFP1z7+DTgpNL2Tj8GOg5aqHdgWNWOmC78a
 4MijUNzk4sIOqpaHzAQn+WgNjV57Gq2XHZ5py3Q5FLrdTarsIP1Zy+anBlxQMkc/AimM
 9E76+9SLbvIglvjPHf3NJjyDpyR5YtBxFFSQE2+VO/SL6Ph67L+EGKmp2M7z97WHiy/a
 FGLw==
X-Gm-Message-State: AOJu0Yy3oO6ZotP0F9ahE/GYBNO79Nrnb/PKLxiOYRes9kL8GIRSLiku
 Lwn7sr9U9OQm8v68RXaFN+w=
X-Google-Smtp-Source: AGHT+IEmnsSOh4uOrhxXGaf5QEGyDhlJUv5bRr/VUi2LFe7inOF+NlItXWDuzNLJWC26L9b4xsM0yA==
X-Received: by 2002:a05:6a20:297:b0:12c:e745:78b3 with SMTP id
 23-20020a056a20029700b0012ce74578b3mr3421649pza.62.1692380430380; 
 Fri, 18 Aug 2023 10:40:30 -0700 (PDT)
Received: from [10.64.107.252] (static-198-54-134-172.cust.tzulo.com.
 [198.54.134.172]) by smtp.gmail.com with ESMTPSA id
 u20-20020aa78494000000b00688431379f6sm1786739pfn.115.2023.08.18.10.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 10:40:29 -0700 (PDT)
Message-ID: <ba7bf86f-3f4d-036a-9531-72a97d741f91@gmail.com>
Date: Fri, 18 Aug 2023 10:40:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/5] sunxi: psci: clean away preprocessor macros
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>
References: <20230816173420.83232-1-CFSworks@gmail.com>
 <20230816173420.83232-2-CFSworks@gmail.com>
 <20230818151103.3fe5a32e@donnerap.manchester.arm.com>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20230818151103.3fe5a32e@donnerap.manchester.arm.com>
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

On 8/18/23 07:11, Andre Przywara wrote:

Hi Andre,

> The resulting object file is different (8 byte larger,
> even), so it's hard to prove

I'm no stranger to reading object code. Since the output should be 
identical in principle, I'll spend a little bit of time today seeing if 
I can identify what's changing. If it's easy enough, I'd like to adjust 
my patch so that the optimizer does produce the same output. (Keep in 
mind I'm on Clang, though. If Clang already gives the same output for 
both, I'll just report back to use that when comparing.)

>> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thank you!

> 
> Cheers,
> Andre

Likewise,
Sam
