Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA13AC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 05:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 034CC86E37;
	Fri, 17 Nov 2023 06:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QTQdHH2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E149986EB9; Fri, 17 Nov 2023 06:15:12 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B23FF86CBD
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 06:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AH5F6vs127500;
 Thu, 16 Nov 2023 23:15:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700198106;
 bh=WKcCLagz761QlzoaicUY0p2MiwirKm55bLZEV2UZxFg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=QTQdHH2HutgHhoifquVyyKd83TOO3skBk64k/ACo+QgghX6RkM3Ggi+bfcV9CGi43
 YYaUdbgf7O9MfSLxF18odc8592hJuNVcNUQQLk7gWy25d2cjMT4hPLwm3n7dg6GWbr
 VNCVx+i/4cWP7xCsDOaPh2K/WmDcPMYkZIpdDkSQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AH5F56o041864
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 16 Nov 2023 23:15:06 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 Nov 2023 23:15:05 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 Nov 2023 23:15:05 -0600
Received: from [172.24.227.36] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AH5F20g007584;
 Thu, 16 Nov 2023 23:15:03 -0600
Message-ID: <6e832633-fc11-43f5-a501-c58dd1424c6a@ti.com>
Date: Fri, 17 Nov 2023 10:45:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm: dts: k3-binman: Add support for FIT templates
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, "sjg@chromium.org"
 <sjg@chromium.org>
CC: "kamlesh@ti.com" <kamlesh@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>, "afd@ti.com" <afd@ti.com>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>, "nm@ti.com"
 <nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
References: <20231115101024.3441093-1-n-francis@ti.com>
 <20231115101024.3441093-2-n-francis@ti.com>
 <CAPnjgZ22W3EpWdw-t=B9CjGJkQcNm1hARi1efe91JCxhzoZUpA@mail.gmail.com>
 <f99de6984d737ace5b4f6c014909640cef63ce12.camel@toradex.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <f99de6984d737ace5b4f6c014909640cef63ce12.camel@toradex.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Marcel,

On 16/11/23 22:13, Marcel Ziswiler wrote:
> Hi Simon
> 
> On Thu, 2023-11-16 at 09:03 -0700, Simon Glass wrote:
>> Hi Neha,
>>
>> On Wed, 15 Nov 2023 at 03:10, Neha Malcom Francis <n-francis@ti.com> wrote:
>>>
>>> Add templates for FIT images used extensively across K3 boards with most
>>> of the code common. This includes the FIT portions of:
>>>          - tispl.bin
>>>          - u-boot.img
>>>          - sysfw.itb (in case of legacy boot flow)
>>>
>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>> ---
>>>   arch/arm/dts/k3-binman.dtsi | 327 ++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 327 insertions(+)
>>>
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>> What is the DM binary?
> 
>  From [1]:
> 
> DM - Device Management firmware also called TI System Control Interface server (TISCI Server) - This component
> purely plays the role of managing device resources such as power, clock, interrupts, dma etc. This firmware
> runs on a dedicated or multi-use microcontroller outside the security enclave.
> 
> [1] https://docs.u-boot.org/en/latest/board/ti/am62x_sk.html
> 
>> Regards,
>> Simon
> 
> Cheers
> 
> Marcel

Thanks for explaining!

-- 
Thanking You
Neha Malcom Francis
