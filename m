Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28D6CCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 15:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5924883B9B;
	Thu,  6 Nov 2025 16:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="NNSrJgRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBEA683BB5; Thu,  6 Nov 2025 16:51:10 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E964583B85
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 16:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47114a40161so11527575e9.3
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 07:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762444266; x=1763049066; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hJ3VsqDgRspL7seQ1/HUPtFKMqTT1l3pIvLs/Ah9g48=;
 b=NNSrJgRYr6C27/QJCZDr1dRK9RTWi4FETmW5+Hr+Bqq1sgm6CtLN7h5la9PzZWqO/D
 lRAEg7UUSTU2iJo15Gf/JLpX2T/B2IuBQn4xyA4wyAx11Xms/qCAoJR3j6HawvMAIg0H
 chQPj6sLqOGZUkpq9Azoadx3wMzg0p6Ue+w1p09/OkGUzrwTnuOHLRT+DVbEQzD9qBD3
 /OVhNmpsQCuxQ6jGyl3A6MbAb3yfdLiQ5sewc1Y61zu/UrZfoitjpU+t5z1dYd+6Ixnk
 WLb+GLJGBM7sczGZaZRgx77aNf/rTtIJM2KWWWM681AYbhN57+lC2qu0Y2X1sXX7iXTK
 /vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762444266; x=1763049066;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJ3VsqDgRspL7seQ1/HUPtFKMqTT1l3pIvLs/Ah9g48=;
 b=QJ091FWOab3Pcyf2hdyxkFLELSJXk+uiXOLt3HJJweQF/tLVnVXqJHmCVgr0j83swK
 Jos4PVjK9c+IBtakX7HacknkVHNsk7IJnctrdzVt0xT88yX00jsgzB/0MmPAmdBjz9hJ
 kHbvqC/uP3IkOB0pxBwEfa3s9YyTpeEgGmCpDwJieq/s2/BVoElWYaAgpSNEzlyyPolk
 UpAosewrpqTd6ws7IZQVOEhcKcApkCO/Y5tjZKp9nAvfjjCVxmHrH3IZxvffm0MXSq09
 Ul+xExoRGNlBDHhovnSk3AP0DlyEoO4CqWFKVh1VuktH7chPDWC/E5dJkuChFXsaDVcT
 2Wng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR3o/InWifvQ+Q3KzB0Xs3XC40XRvMAFLyI6HYMfZGGmNdfcfrKs/BBQEyLBUMbt+6jZHifb4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0uhdTuwsJWlH9hyHsxPGmMsLnUaf5+GxLdj0on1NzDHHJCQms
 Ld8lusztPfdDTUd6yCZWZZhPqzKzh02S31efZo+DBYX75kW1GaO9SBoB2erRwF8d1RY=
X-Gm-Gg: ASbGncuApHj1L2Yxi3RCuTWKymMeiiU7U6M9qI2hnTbWgAy1anSO27N5ooWCjOcY2ta
 /P01y6mm9yfKtBSvxy7APFhUqDPhAyxUX5O3rJkEo+uT0MXgoaHJUcG2/STWK3VKfkmaO2QA+hA
 2W09x2zvzYHvjKxac82CFPUHi5wpDmHlxexBNtxWBhMJapCBG0TsbiZG3O8AjjRG5MYm2ppYH5t
 H6d6Gn9pbB+7uIPGltZ1NZIeRV0KN2T9/o5MdcjaMpBj/+SmM4uib4OUFUsOx8v9dGqwdGvcFuH
 Ux67d2ZfuEtVeFQlTBK8kaS98k1UygIMRhsvQxKNEVmQ+ECSdSlue3+SY+0sp6d14+iaOmCk/+0
 giqNiEtZH3JzEYJxDr/mf2TumVzxrgh6J2BsuY+WTaGc6pf6v9PgVUcRo+jKspiHV6QVvt5Nzee
 5BHeQmKs7+7kPp
X-Google-Smtp-Source: AGHT+IF1k3DXj9PPGvI0PeH/5OHI3JuCnH2ayuzzEtg6NjXOv7hJQyk10wZYJl7KQ9LbEbreb1nONw==
X-Received: by 2002:a05:600c:681b:b0:475:dbb5:239e with SMTP id
 5b1f17b1804b1-4775cd3b301mr91527985e9.0.1762444266344; 
 Thu, 06 Nov 2025 07:51:06 -0800 (PST)
Received: from [192.168.2.177] ([91.116.220.47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477622f42b0sm56493065e9.4.2025.11.06.07.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 07:51:06 -0800 (PST)
Message-ID: <027c97e7-caa6-45a9-b8d2-21d0743f3b06@suse.com>
Date: Thu, 6 Nov 2025 16:51:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/4] macb: wrap asm/arch/clk.h with ifndef CLK
To: Torsten Duwe <duwe@lst.de>, Simon Glass <sjg@chromium.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Heiko Stuebner <heiko@sntech.de>, Huan Zhou <me@per1cycle.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, =?UTF-8?B?SmFuIMSMZXJtw6Fr?=
 <sairon@sairon.cz>, Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joseph Chen <chenjh@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Tom Rini <trini@konsulko.com>, Volodymyr Babchuk
 <volodymyr_babchuk@epam.com>, Oleksii Moisieiev
 <Oleksii_Moisieiev@epam.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de
References: <20251105163553.15F2A227AAC@verein.lst.de>
 <20251105164426.20BB1227AAA@verein.lst.de>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20251105164426.20BB1227AAA@verein.lst.de>
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



On 05/11/2025 17:44, Torsten Duwe wrote:
> macb.c includes asm/arch/clk.h solely to declare get_macb_pclk_rate().
> That function is platform specific and only required if CONFIG_CLK
> is not set. In case the machine does not provide it, compilation fails
> even when the MACB pclk is detected via the CLK framework.
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Reviewed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>

It seems you forgot my reviewed-by tag, anyway here it comes again :)

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

