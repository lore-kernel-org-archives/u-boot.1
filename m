Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C520ED3C934
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 05:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87D9A89202;
	Sun, 20 Oct 2024 07:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729400570;
	bh=PmD293XWrB67Onp3ZhI94maVfzUYC8msAHb+b/B2Xjc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=asala6IR0sA6f/kGFJ4B6Pw53FrwLywnxAS+TGHjH3TxydEcDwkibn5dgrAqTonOh
	 fsfLT+M1q4op83amaLK9rbpIicAQ2RGDqgpTIpFYKG4fUMOKTkQnJSsi4hSovWMiws
	 QenUT/xN6H0v2ueAOFP2db9mfYXbKePf66PpM7cOUCkS/mF/fU4A256i3+pi5GIY6x
	 MxUc33PRdlgEVDOXbXDWS32sRTGGO68IMI7gxefNDO9E5maLoYUHFXpxNUEFsZLSgP
	 lIqSsCHgdmu09m0+Xm/E91Ur0VO0JednGKlgBAXDHxr/lrhQtg14ItO6ZIaoBuAjPQ
	 ah9JDAVuouWBw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CBCBA88DF3;
 Sun, 20 Oct 2024 07:02:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729400567;
 bh=PmD293XWrB67Onp3ZhI94maVfzUYC8msAHb+b/B2Xjc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=imqiWM5nopbZpbA1Ls4zu5x56AQkXrSQBysuJIiiYvynJPEZV96TXhUkW4BvNoZiB
 wgy7EWaxIR8WB0rmvMQJJ5xaKrDTQt2wwG48IIOQtR4WDcPN7mwl8dYq/F3cIHmDiw
 cB2jRAKgD/MkE0RfE2pvQMVvLLKP9WeqoDvATFHrfgVz20R3RcZM9BQBlScfBHETNJ
 IHaNUmwXGs0jyWubwyX8UbNyFsmxmpxRFDx/HgZrCs3ouUVhBdGMnWXodfwaifYGeb
 hLsaHVIgWyxTGWdIpdPlXSUKoDTJkii+G61T8BTgXGoUXgortXOj2twwX3r4PVFvkt
 W7nOlaG9REZuA==
Message-ID: <f21c4689-7279-4824-b944-fb28c982b7bc@denx.de>
Date: Sun, 20 Oct 2024 04:52:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] ARM: dts: socfpga: add Mercury+ AA1 for u-boot dts
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 michal.simek@amd.com, jit.loon.lim@intel.com, barnas@google.com
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
 <20241013143232.2090645-4-l.rubusch@gmail.com>
 <5e52d3d1-51d7-4e93-b5ad-b3782e157dac@denx.de>
 <CAFXKEHYQ6vsuNv31cMkx_pCnRThZwUitVZR3ptQVUrcYxVeKjQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFXKEHYQ6vsuNv31cMkx_pCnRThZwUitVZR3ptQVUrcYxVeKjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/18/24 11:57 PM, Lothar Rubusch wrote:
> On Mon, Oct 14, 2024 at 8:42 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 10/13/24 4:32 PM, Lothar Rubusch wrote:
>>
>> [...]
>>
>>> diff --git a/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
>>> new file mode 100644
>>> index 0000000000..1b29ab9358
>>> --- /dev/null
>>> +++ b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
>>> @@ -0,0 +1,86 @@
>>> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>>> +/*
>>> + * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +/* The arria10 family */
>>> +#include "socfpga/socfpga_arria10_mercury_aa1.dtsi"
>>> +
>>> +/ {
>>> +     aliases {
>>> +             ethernet0 = &gmac0;
>>> +             serial0 = &uart0;
>>> +             serial1 = &uart1;
>>> +             i2c0 = &i2c1;
>>> +             i2c1 = &i2c0;
>>> +             spi0 = &qspi;
>>> +     };
>>> +};
>>> +
>>> +&qspi {
>>> +     bootph-all;
>>> +     status = "okay";
>>> +     flash0: s25fl512s@0 {
>>> +             bootph-all;
>>> +
>>> +             cdns,page-size = <256>;
>>> +             cdns,block-size = <16>;
>>> +
>>> +             cdns,tshsl-ns = <200>;
>>> +             cdns,tsd2d-ns = <255>;
>>> +             cdns,tchsh-ns = <20>;
>>> +             cdns,tslch-ns = <20>;
>>> +     };
>>> +};
>>> +
>>> +/* Carrier board support */
>>> +#if IS_ENABLED(CONFIG_ENCLUSTRA_PE1)
>>> +# include "socfpga/socfpga_enclustra_mercury_pe1.dtsi"
>>> +#elif IS_ENABLED(CONFIG_ENCLUSTRA_PE3)
>>> +# include "socfpga/socfpga_enclustra_mercury_pe3.dtsi"
>>> +#elif IS_ENABLED(CONFIG_ENCLUSTRA_ST1)
>>> +# include "socfpga/socfpga_enclustra_mercury_st1.dtsi"
>>> +#endif
>>
>> Can this be moved to socfpga_arria10_mercury_aa1-u-boot.dtsi instead ,
>> as this is likely not going to be part of the upstream
>> socfpga_arria10_mercury_aa1.dts ?
> 
> I may try to put more of this content into a ...-u-boot.dtsi and then
> try to take more advantage out of the u-boot DT generation process. I
> will have a look on what I could improve to match the u-boot DT
> generation approach still a bit better.
> 
> I was orienting myself a bit by the other arria10 devices there. But I
> think .dts in dts/upstream will definitely not work with the current
> approach, and as a .dts file due to this bitstream loading and muxing
> situation needed to be done in SPL and u-boot only. I'll see if I can
> figure out.

Thank you !
