Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BADCCCD183
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 15:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92DC8836C8;
	Thu, 16 Oct 2025 17:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="XvPRUJH0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8CF88313B; Thu, 16 Oct 2025 17:37:12 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FA2F836D1
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 17:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so7293235e9.1
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760629025; x=1761233825; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h2ESOzT2YzbwsqujF7U3Tapt+ErlQp1NvuHUd0KzmXI=;
 b=XvPRUJH0A11WdNObOB1YeapHqyAf46m82fQSIZQagu/85qvESSYYs4KWMUXO+UGUT1
 H0FkqwVp/6ZLfCbQuYJB43VGYTboqfFG30H4oKhaep5/pyP3kmyG8PJzDgcFd9FO420Z
 BOqfEQzbgYNOQzhCnRWlruEU67W5/I2N7ItD8XJ7roMkh8yuGMNbPJjxTEhHiZwiTpA7
 zJdsqPA4CiLfoH4WsrVEn9KaGF8s0B7/Au2oXIIJri7rtzglBkeR5M7a+mvUGCoYKEDB
 xwijsdf8iPfui/VjA4Tyn+vIs+oap3QV0V+lCLZaQoHjr3RQwzdYLznGxxnq2T4YKaXY
 oskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760629025; x=1761233825;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h2ESOzT2YzbwsqujF7U3Tapt+ErlQp1NvuHUd0KzmXI=;
 b=oyuGrMCg2HU6SjD8C+CJs3pyWx+eRJlCyvz430nvxLk2k/aiZG/Xt1RwEzucvsg+oM
 AvA0U6WCfaZRuGr1s9NW3YFpJ3rkCNPHIKE/w+myoDZWI/gwLcddRZAxYo1Enr26SUnm
 Rh/DRcWcZcwex04l437pvIhbVQkGeWne0322Y6ou26FZGKVKzrbdz0O12EG8kiFonRkp
 Pfdn7HVvfIIcAZWO0md+AKUFXVgBvVBTySx+1GC6VmarAJhBN0Awae1gXwh2lPrqjnT/
 7rKocNesongSk4TxAvzmgUJKHr35tShQb84qhGUqo0CBYIHdc6vUsn7mL2+US5Yho0V2
 puYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+7iqiirX9mxwIUdA/ow5k1fX4FfGRTLaQbxsgHq48aZTQnK00KosFi4euNinw+ASFOKuc62g=@lists.denx.de
X-Gm-Message-State: AOJu0YxA7WtSOnLW7NX+J8dmpaEJ/+yn2MzCXV1YXgVKfnTAePlVUAxo
 3x8W2F+3ysV6bJgUvVAcIlfMMsLSt6LXJ3k0QVigpf+n1ljSN1BTxbpnOr/QpsszBbaV7rlc24M
 esF7T
X-Gm-Gg: ASbGnctZ/Sic64EpAiQxc2edu49fx8EEXojn7c4qRyy2j+X9rCuFtzxMClZ1JzxzJoM
 Trs54GLHRzXUpjwvrZugsU6sZ7rHZE5FYOW4HYteSugiOVQX6lwzJ1gG+afDLY0FRm+N5UEa4jC
 x1oN6G4gGA1L0E1vpVgMdMW6GeSKF1EM6yTeGKnWgBfmaMMk7lYUQh8TAnJx/ztRXo7/Xc+xaZ1
 wWYzMQiIYfQe58g5eCZ23p16TZoshZKrwwhhVQ9g/FYKaEudRO0yxQ3k+P71UE451qK93u+Q+Lp
 4f13FbCQEwxg6UTWGU0FLvS4wD3yDH/1ZsAtMzMuQdMJL7Fr3Pgw7sQiNZhr26VGndtRURw2gJM
 a3NAxaGDAff+cZoQtb+FdA50e3f7VVj+5XRY5UhG3lkL9lCdjOw4R/w/sy8vlKp9vQ43Z4vj9QY
 8gsA9WFuXzeCdkQ5IU1U1naTJmMfA=
X-Google-Smtp-Source: AGHT+IGMRmEMffhajUA9vtyQ/08P59mZ82JoQs1wB4iW/d4AaTiXFDxJSE2dO6+4FuyKUDs3eXf9Ug==
X-Received: by 2002:a05:600c:1d9b:b0:46e:6c40:7377 with SMTP id
 5b1f17b1804b1-4711792007bmr2973185e9.35.1760629025349; 
 Thu, 16 Oct 2025 08:37:05 -0700 (PDT)
Received: from [192.168.1.137] ([91.116.220.47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710f28a920sm22018075e9.7.2025.10.16.08.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 08:37:05 -0700 (PDT)
Message-ID: <78a0c4e1-0988-441d-8b55-d3080176fe93@suse.com>
Date: Thu, 16 Oct 2025 17:36:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] macb: wrap asm/arch/clk.h with ifndef CLK
To: Torsten Duwe <duwe@lst.de>, Simon Glass <sjg@chromium.org>
Cc: Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20251010161442.410C4227AAE@verein.lst.de>
 <20251010161721.7B915227AAE@verein.lst.de>
Content-Language: en-GB
From: Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <20251010161721.7B915227AAE@verein.lst.de>
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



On 10/10/25 18:17, Torsten Duwe wrote:
> macb.c includes asm/arch/clk.h solely to declare get_macb_pclk_rate().
> That function is platform specific and only required if CONFIG_CLK
> is not set. In case the machine does not provide it, compilation fails
> even when the MACB pclk is detected via the CLK framework.
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> Signed-off-by: Torsten Duwe <duwe@suse.de>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   drivers/net/macb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/macb.c b/drivers/net/macb.c
> index cbf5f605518..a54a268036d 100644
> --- a/drivers/net/macb.c
> +++ b/drivers/net/macb.c
> @@ -38,7 +38,9 @@
>   #include <linux/mii.h>
>   #include <asm/io.h>
>   #include <linux/dma-mapping.h>
> +#ifndef CONFIG_CLK
>   #include <asm/arch/clk.h>
> +#endif
>   #include <linux/errno.h>
>   
>   #include "macb.h"

