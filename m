Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02ECE95A8E
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 21:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1384486C26;
	Sun,  8 Oct 2023 23:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d0uksVIw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CF2686CDB; Sun,  8 Oct 2023 23:50:17 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8338986587
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 23:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-77acb04309dso176917739f.2
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 14:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696801814; x=1697406614; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=doOLO7TnwKN64HL0/FShBMsjmhiq3g16i5NR+3rnKAY=;
 b=d0uksVIwuHt+DCNV2z8luPjqNESWqfeU9yCJt2QPKBKH5rDCfPwhB0P1FQKgyNnprG
 Zu1DwPCIAA73OWaD93XYHF7HV63YAnFBfo7lSa4RFX/apSGh8tm87B+TXOZwcypJbBCu
 ERkXE/dEAoLjDiZhnz2SIQwB+qkQOkPxve9khbTJzXAHBu6cAzekXLODIuFgdXFoBbjo
 ZXrdLEdhhAMNTJTlZstUPrup+tjEaW1J273dCu0xsKx8dSyF82qp4NqMIYV9hL0pWP2W
 JlwFjVT7ZiiayS7PFPM6LbqVZjf+x7At4Pss+CciV6RaKyUmBO8IgmNq3iSNHpea48+T
 6i9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696801814; x=1697406614;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=doOLO7TnwKN64HL0/FShBMsjmhiq3g16i5NR+3rnKAY=;
 b=TTYVFVuTbDYINlEKZelliRc3POzpwYH9CbpYYLu4Xm1LWMnfBOvKitI64Rd5kezxxc
 egR1ibMPHC4ReyvMU3zDUcAPBOqNoO6ZFSw/qy77hyOdK6cM+Jjz4LhIfTW4fFte+kNA
 caJ3QWNbSusCn8GpvmXrJ+iJYLEeZ+ekabCH+OCzg/RogP8WnLdJ8z+jWX9h059I3MQW
 27dpzLegln15JeMcOecgfBArEFzs2Gzgw3dDX//Jzad7gtV4znOZcyAGHTlyMZBkvwR0
 cGrgclrVsyBMzNmBwNBMItv0Xdnoni4Pa3kvNF7e/Z2uAw9FcfdRHMWKRR54cpA55kTh
 xcKA==
X-Gm-Message-State: AOJu0YzYQQaLItZKCIidcLWqT2dKKR1uePmubHW/Jb8niG/3YLj8AYzF
 KvxcqtwJutSfjFox6yI93RsWEnojtPJUgw==
X-Google-Smtp-Source: AGHT+IF23TCD7SJ2qGeaSLycLFKTweH+sbsl9fzYVwUknsAIjK4l6PKKKfHJaP+fyo5MVj3cF5CE1A==
X-Received: by 2002:a6b:f318:0:b0:798:3e95:274f with SMTP id
 m24-20020a6bf318000000b007983e95274fmr17105423ioh.19.1696801814107; 
 Sun, 08 Oct 2023 14:50:14 -0700 (PDT)
Received: from ?IPV6:2001:470:42c4:101:970b:72ee:fe52:77dd?
 ([2001:470:42c4:101:970b:72ee:fe52:77dd])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a029682000000b0042b3e04510asm1741178jai.98.2023.10.08.14.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Oct 2023 14:50:13 -0700 (PDT)
Message-ID: <f2856fda-ff90-97b2-a53a-59a7368f0549@gmail.com>
Date: Sun, 8 Oct 2023 15:50:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ARM: psci: move GIC address override to Kconfig
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20231001225212.19081-1-andre.przywara@arm.com>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20231001225212.19081-1-andre.przywara@arm.com>
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

On 10/1/23 16:52, Andre Przywara wrote:
> As the code to switch an ARM core from secure to the non-secure state
> needs to know the base address of the Generic Interrupt Controller
> (GIC), we read an Arm Cortex defined system register that is supposed to
> hold that base address. However there are SoCs out there that get this
> wrong, and this CBAR register either reads as 0 or points to the wrong
> address. To accommodate those systems, so far we use a macro defined in
> some platform specific header files, for affected boards.
> 
> To simplify future extensions, replace that macro with a Kconfig variable
> that holds this override address, and define a default value for SoCs
> that need it.

Hi Andre,

Looks great to me. I'll update my PSCI series atop this once either this 
or the R528 series lands (I don't want my series to depend on *two* 
pending patchsets).

> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Sam Edwards <CFSworks@gmail.com>

Cheers,
Sam
