Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56172C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 08:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77072874D2;
	Thu, 26 Oct 2023 10:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698309372;
	bh=JiisnOTRqklzDOP0WZKGyu8xSoEljSLYbCr/gLrRv78=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R9LnQ5go4EWLUZaM764Iv1PK+b5vak2Bq3idRkrqOAicBe0Pj+EiXKHwykqcVDiQW
	 Gb5kW1m6yl5ZwzcgGXhF8llulGeoFSMOpU63mjhBnY0/SIeWKhnXF/bc0RY2BB45OS
	 6HK1lDuLyMtOGRJkFMBsOYchffvPEb4v4s81hFBTxKxTM7NZRDQRo2eabqXBuLe0Px
	 clhvqQ93IfZlKigxmIe3PmJuxlg4ErmS7J+3pzkrBxUueMEo7M8cZCjjPJ3F92Bphr
	 3FXQz+bb2pBZLGEho0hlojCHkRYBBDoTCVeD0Irdcjy+DkC6Zsqt8/47G6LFCzSreP
	 yYW3OZQFuAwlg==
Received: from [IPV6:2001:a61:61a8:7a01:e565:eadf:6648:67ad] (unknown
 [IPv6:2001:a61:61a8:7a01:e565:eadf:6648:67ad])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: sbabic@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C1ADC874D5;
 Thu, 26 Oct 2023 10:36:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698309371;
 bh=JiisnOTRqklzDOP0WZKGyu8xSoEljSLYbCr/gLrRv78=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SysFh9w8HFsoMEBaa5AOzcSDr3YXM84a00Xs+PC0yzIiURecz6ZrhOuaxN+PPxa8J
 c4vVR9Esju7YMz/BQ68ATLcTs8If+AxWGnf7wgmyquVbnkS4nOGwCPtKmi3ZV4ikyB
 be8pw6FwJ4cLcDW7/LDc7B2/pR1wQJOJVZuTDVnqhEB1RXlvCOzN66Pov/0RroDhQ7
 5M/5C4tmVt38BBrgjeWgfKzLh1j7nCHVVwcEzECBPrVKFEbeVOG7avsewbRaZt4n4Y
 lDG2TUHG9iEFRB8o7Rd2BhhY5oiTUizzNBenfHf9GE6rueAfJEnn7TsjpwueAnSZCI
 OgLMVmtgPwHHw==
Message-ID: <6ab14ae1-7044-4663-98e4-919b9d1757b9@denx.de>
Date: Thu, 26 Oct 2023 10:36:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] imx: spl_imx_romapi: fix emmc fast boot mode case
Content-Language: de-DE
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Marcel Ziswiler <marcel@ziswiler.com>, u-boot@lists.denx.de
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Peng Fan <peng.fan@nxp.com>
References: <20231026073220.244387-1-marcel@ziswiler.com>
 <20231026073220.244387-3-marcel@ziswiler.com>
 <f9ce2b20-1fa1-408c-9ae6-4dd382c9c999@prevas.dk>
From: Stefano Babic <sbabic@denx.de>
In-Reply-To: <f9ce2b20-1fa1-408c-9ae6-4dd382c9c999@prevas.dk>
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

On 26.10.23 10:29, Rasmus Villemoes wrote:
> On 26/10/2023 09.32, Marcel Ziswiler wrote:
>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>
>> This fixes a regression in the eMMC fast boot mode case where the buffer
>> was missing 464 bytes.
>>
>> The code figures out how many bytes must at least be fetched to honor
>> the current read, rounds that up to the ss->pagesize [which is a no-op
>> in the USB download case because that has ->pagesize==1], fetches that
>> many bytes, but then recorded the original upper bound as the new end of
>> the valid data. However, this did not take into account the rounding up
>> to the ss->pagesize. Fix this by recording the actual bytes downloaded.
>>
>> Fixes: 4b4472438f5a ("imx: spl_imx_romapi: avoid tricky use of spl_load_simple_fit() to get full FIT size")
>> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>
> 
> Thanks for reporting and fixing this, and sorry for the trouble.
> 
> Acked-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> 

And thanks for all your work - I will apply this fix soon.

Regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================

