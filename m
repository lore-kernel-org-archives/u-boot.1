Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0494BC0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 19:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB2CF86852;
	Tue, 15 Aug 2023 21:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JOc/eCQR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40B6E86863; Tue, 15 Aug 2023 21:17:40 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71EAE86801
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 21:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5654051b27fso4393160a12.0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 12:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692127055; x=1692731855;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aV66Y01J54tsHnj0agaUT+Yje/h5VS4iHHLC9UV8fsE=;
 b=JOc/eCQRgPOn03rwvJo/q4GBWdpFKdyNAP1iMoWvg0l3ArvDxn8Lf4/dUODsohjS+M
 9/qTCn0yHc97Oym3VayOlnchvt0DI5fI9wPA8fIBQ0YTBtqgsTUXsZsN1Mm4dHUn1T8Z
 pyaZLJhaS1bvL0/zODyNStftRAIrkmkLcBqp11BqNcntjiyPK/UKGX/cv6vYwGO1xaCi
 //lAlxqGNetiaoYqkXlgmSqjwlPWg52CN6o38u1mcF+s4bDC2UCy1fmStIfVSXQSTHVR
 sViiE+r5JpNr70MZD0M+FyCdcjVCeYtEEAgofh/MDj71Bdd7TMdH1w1OlGx4QNDUByKl
 NdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692127055; x=1692731855;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aV66Y01J54tsHnj0agaUT+Yje/h5VS4iHHLC9UV8fsE=;
 b=JT0fBblbLIn0/fn8drg9X4LKZ8C1e/Hi88CsW/+EeCyUQNrVASBvkSqODwhVYovtZ7
 4EpOcllIA7Lkq03YVAO2ttMP41n128T4ItH214rcHfTbukvkxZaUGDGW+z6ZQ00iNp8S
 qRTClj3D0J+1I6+Wrk/wDk6Ce6UNP0aTwR6W99mQQq1cOYxCJ3kgp3lCnZ3j/BcEhUhq
 1pIqdLtc+qUWbK3tTRFIj307rdDtxp1edMaQNQGl78AVgZjTraPSHCClRm4o91HJIk9O
 zVgxo5dkekfvLY/TIAjuOuKfW32HBPbBGp492+AF6P/Bbpmho5Lwjvofums3aa4YnMTR
 jQeQ==
X-Gm-Message-State: AOJu0YzO6ewSFn4/8Pgl+a7uI6dyy1eW0x4x29lTufDAkzd2T6jTkK++
 KXLwg7W1NxjQX8f5Jxy0QfY=
X-Google-Smtp-Source: AGHT+IE8oF90rFn4jejhc4yh90yAO9VKAuxuhZOlsfhqBCLZNabR8rtsXziqFiSwcFdsMVtYt0e4dA==
X-Received: by 2002:a05:6a20:7485:b0:143:4382:f836 with SMTP id
 p5-20020a056a20748500b001434382f836mr17731065pzd.14.1692127055425; 
 Tue, 15 Aug 2023 12:17:35 -0700 (PDT)
Received: from [10.64.107.252] (static-198-54-134-172.cust.tzulo.com.
 [198.54.134.172]) by smtp.gmail.com with ESMTPSA id
 z20-20020a63ac54000000b0054fd46531a1sm10604600pgn.5.2023.08.15.12.17.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Aug 2023 12:17:34 -0700 (PDT)
Message-ID: <225be7f9-558e-4695-0b38-b30b0229cdcd@gmail.com>
Date: Tue, 15 Aug 2023 13:17:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] sunxi: psci: implement PSCI on R528
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>
References: <20230812003055.74527-1-CFSworks@gmail.com>
 <20230812003055.74527-4-CFSworks@gmail.com>
 <20230814151642.6f47f6b5@donnerap.manchester.arm.com>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20230814151642.6f47f6b5@donnerap.manchester.arm.com>
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

On 8/14/23 08:16, Andre Przywara wrote:
> Hi Sam,
> 
>> This patch adds the necessary code to make nonsec booting and PSCI
>> secondary core management functional on the R528/T113.
> 
> Unfortunately this patch breaks the build on older 32-bit SoCs, as
> SUNXI_CPUX_BASE is not defined there. That's a typical problem of the
> "C-if" approach, but typically there is a clean, albeit not trivial,
> solution:
> 
> It seems like SUNXI_CPUX_BASE and SUNXI_CPUCFG_BASE are mutually
> exclusive, and I actually carry a "#define SUNXI_CPUCFG_BASE 0" hack in my
> patches already.
> So I wonder if we should unify those two into SUNXI_CPUCFG_BASE, with the
> following rework:

The SUNXI_CPUX_BASE -> SUNXI_CPUCFG_BASE rename worked excellently. 
We're having the same problem with SUNXI_R_CPUCFG_BASE as well, though. 
How do you want to handle that?

Thanks,
Sam
