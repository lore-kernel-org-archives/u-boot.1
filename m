Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C146CD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 08:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B09D1847C3;
	Thu, 18 Jun 2026 10:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qt6dzLCJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 948DF84874; Thu, 18 Jun 2026 10:41:21 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DF3B8460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 10:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490be29c1c5so4920975e9.2
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 01:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781772079; x=1782376879; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WJ4LydsdHjcXy3K3b378CZbbAJ3dIVVGmME16M/EwQk=;
 b=Qt6dzLCJDUg+0jYqQ7lforcnHvzGf89C9sYEtMAb+pRhJZk9jDyoBp5NOMfKr3Nqo4
 roehzPi+yTGMTuZ43tWJYD7PZIQ1S5zn5IzCiGU4XoE3jUej21RqhBT9HOUK5iUEhGI8
 ej8EaVogjDyLEZe9Tt2eL2OZgSZl50IbR4Q49v1kzM0EZ39G4BQs5QSFyadZcXpzklSu
 v+Zq0ZMNYIezH/UJ4M9RloIOxj4h//KW91eECZ6AX5EgTcvXc/xeIiBU6y4XSIVkwEGh
 m49Y9vCgEQIAASfCvSp1X5MBAkiDtCj2PPjjlUNpt+S4nqfutK+HL7M+PZmXwe+lWWSl
 wtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781772079; x=1782376879;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WJ4LydsdHjcXy3K3b378CZbbAJ3dIVVGmME16M/EwQk=;
 b=oTausV0hRyTUb6dUcNim7dhcmaz3WRrrlGW0WwYfkq3/Q7uzwiGfXEdPhNAcRa8uLv
 zGuG8ATPP5TBSt8emhAmAuqg0sbE8HYO6Ks9rezKJ43zjyPK52szeWWpeEAkPO3XS0ix
 lqQOvyQxG0ABriHOoD3i9fPl4XlCkDMRPmQIij4qhX3BXMKS+AOcjgG3kUvnRt5ED1Mp
 oVy9InOgFP8zr4GVUGD+58WXk6fc0AalCjm2ucR+aSMZq7ElcubmdFJ+1w4/yTsbYuYj
 JzGJXZNso5ZoyFcBnuAsnxcw6n1O9QB8tx/f3otFerOa1isUG15qrvNchZsuFOlRrvSE
 mV3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ911lwu4a/1MB+SPG4HeA4u2u3AxCubQ7yzstVJIK/9PObhAmtM+72V2IQIEcHU6f+r9sTvXRI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7vvqnrpav4omT+wB9PgakkAflTdHijcyhjioCC393xamLc7Ue
 r01+3MNCkchaI/put8kQVIptMJVpFrTp/hXRcbJWWHBevVwWrRo0g5AT
X-Gm-Gg: Acq92OEn+RhWOG7W8cgMnw2Z7XP3E+2f/k7I1v4VolbKYXEzrkfZIAKMGvkaLosE9vI
 TnLcxU5sSzAXySC4O/3lDeIWyR8c9+kUFoos2nbCibOn1Dh/Pitn9bMWzbIG4MKUt9WFJ8DIkM9
 3SPwpykUGuraBWpw5bQMcswcbqKlaxq2s4N1Xo7BzmwJqZ7VzCwMwORQ0HGfP3yMiMsC8/bwdAQ
 Kh7cpDnUspUoJ1l4h5NbYrUk9+ZPhVKo+dPALvoqyMDMY2nImMMK05G3T8C86bPgi84ungQCB9S
 GKxUe1RqB/xEuWcNCvwUeriKVD6/cq56AuRlCMLFx/sPEW9DFSHUq2FdFriyKYjqFpUInzAZePE
 57kHAvOwrWQtSnU8/Ckuy7xbNX2Rjidjsuf9cNwq/MAo5mxiT45FOq1uFVe/OmcdNr5dS+XfrJg
 1hbdF9iak0wPVY5MVz5x3QCWzxM4WKW3RC+8L1y0DoXSwh/AVZd1bXiDIJ8Xf7DyBU
X-Received: by 2002:a05:600d:108:20b0:490:abef:dae6 with SMTP id
 5b1f17b1804b1-492333e271amr104893545e9.19.1781772078786; 
 Thu, 18 Jun 2026 01:41:18 -0700 (PDT)
Received: from [192.168.1.3] (host-87-5-34-196.retail.telecomitalia.it.
 [87.5.34.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a154446sm21429695e9.0.2026.06.18.01.41.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 01:41:18 -0700 (PDT)
Message-ID: <067fd2f3-2d0a-4676-b944-20e01103200b@gmail.com>
Date: Thu, 18 Jun 2026 10:41:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] imx9: scmi: Fix SPL trampoline buffer for 1GB DDR
To: Ye Li <ye.li@oss.nxp.com>, Francesco Dolcini <francesco@dolcini.it>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Cc: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com
References: <20260618011749.2871269-1-ye.li@oss.nxp.com>
 <20260618070028.GB18945@francesco-nb>
 <2313d770-7d1a-4275-b2e3-068df38f2852@oss.nxp.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <2313d770-7d1a-4275-b2e3-068df38f2852@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 6/18/26 10:14, Ye Li wrote:
> 
> 
> On 6/18/2026 3:00 PM, Francesco Dolcini wrote:
>> + Emanuele
>>
>> On Thu, Jun 18, 2026 at 09:17:47AM +0800, ye.li@oss.nxp.com wrote:
>>> From: Ye Li <ye.li@nxp.com>
>>>
>>> After supporting get DRAM size from SM, the trampoline buffer address
>>> still depends on PHYS_SDRAM_SIZE. If the real DDR size is less than
>>> PHYS_SDRAM_SIZE, the trampoline buffer address is invalid and SPL will
>>> crash. So use board_phys_sdram_size to get real DDR size to calculate
>>> correct address.
>>>
>>> Fixes: e1cc7117b630 ("imx9: scmi: Get DDR size through SM SCMI API")
>>> Signed-off-by: Ye Li <ye.li@nxp.com>
>>> ---
>>>   arch/arm/mach-imx/imx9/scmi/soc.c | 16 +++++++++++-----
>>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/
>>> scmi/soc.c
>>> index 00b8693fbe0..ce86cdf8574 100644
>>> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
>>> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
>>> @@ -1177,10 +1177,11 @@ enum boot_device get_boot_device(void)
>>>     bool arch_check_dst_in_secure(void *start, ulong size)
>>>   {
>>> -    ulong ns_end = CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE;
>>> -#ifdef PHYS_SDRAM_2_SIZE
>>> -    ns_end += PHYS_SDRAM_2_SIZE;
>>> -#endif
>>> +    ulong ns_end;
>>> +    phys_size_t dram_size;
>>> +
>>> +    board_phys_sdram_size(&dram_size);
>>
>> Emanuele: does this change has any impact on the memory size detection we have
>> implemented in our i.MX95 based boards?
>>
>> Peng: board_phys_sdram_size() in board/toradex/verdin-imx95/verdin-imx95.c
>>
> It won't have impact on the memory size detection. It uses the output of
> memory size detection for selection correct address for trampoline buffer.
> Previously trampoline buffer uses PHYS_SDRAM_SIZE which is defined as 2GB -
> 256MB, if the real DDR size detected at runtime is less than PHYS_SDRAM_SIZE
> (for example 1GB), this buffer address is invalid.
> 
> Best regards,
> Ye Li
> 
>> Francesco
>>
> 

While it is not obvious that board_phys_sdram_size() is safe in all contexts,
it can be called here without side effects.

Tested-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
