Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7E1C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 07:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66CCF88361;
	Tue, 28 May 2024 09:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jMGy6xWo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2022388414; Tue, 28 May 2024 09:48:58 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A92E587F31
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 09:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S7mrDt108514;
 Tue, 28 May 2024 02:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716882533;
 bh=I0evMr+hEQcujlZvW3+S0zM5Nk2Ob+lzn8xgsjEkTNE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=jMGy6xWoSZkSivjDaiOLSer1NNjTR6uTkntCm9vMFFVjyd2RGjDhWV20PS6/NBUzh
 uXJ55FMtde6HTKhAqEvaXi7snmb4bdaXYMTl/3Xc9S/9G6l7v+qV536WogEaso1Vh/
 3agrZrGqJnNSjSh6QwlcigniRoawWIoifLmRn6To=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S7mrlq036779
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 02:48:53 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 02:48:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 02:48:52 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S7mnCG022020;
 Tue, 28 May 2024 02:48:50 -0500
Message-ID: <b3949600-5eab-48f8-a279-f952fdf81225@ti.com>
Date: Tue, 28 May 2024 13:18:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-j721e-r5-common-proc-board: Set parent clock
 for clock ID 342
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <nm@ti.com>,
 <sjg@chromium.org>, <u-kumar1@ti.com>
References: <20240528073727.4057843-1-n-francis@ti.com>
 <20240528074432.c6zbd3iwmsvnn5rv@uda0497581>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240528074432.c6zbd3iwmsvnn5rv@uda0497581>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Manorit

On 28/05/24 13:14, Manorit Chawdhry wrote:
> Hi Neha,
> 
> On 13:07-20240528, Neha Malcom Francis wrote:
>> From: Apurva Nandan <a-nandan@ti.com>
>>
>> This virtual clock mux configuration enables the use of dynamic frequency
>> scaling on A72 clock ID 202 by setting up the required register.
>>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>> Boot logs:
>> https://gist.github.com/nehamalcom/138d25fe32d4d80af3e0e4c19c1b18e0
>>
>>   arch/arm/dts/k3-j721e-r5-common-proc-board.dts | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
>> index 9655ca21d02..25e4b4c7663 100644
>> --- a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
>> +++ b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
>> @@ -28,7 +28,8 @@
>>   				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
>>   		resets = <&k3_reset 202 0>;
>>   		clocks = <&k3_clks 61 1>;
>> -		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>;
>> +		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 342 0>;
>> +		assigned-clock-parents= <0>, <0>, <&k3_clks 342 2>;
> 
> I think it would be better to base this patch on top of your j721e
> of_upstream series. There you have introduced k3-j721e-r5.dtsi [0] and I
> feel it would be better to put this change on that file maybe.
> 
> [0]: https://lore.kernel.org/u-boot/20240520095916.1809962-2-n-francis@ti.com/
> 

I'll line this up after OF_UPSTREAM is taken in or requires a next version 
whichever happens first. Thanks for the review!

> Regards,
> Manorit
>>   		assigned-clock-rates = <2000000000>, <200000000>;
>>   		ti,sci = <&dmsc>;
>>   		ti,sci-proc-id = <32>;
>> -- 
>> 2.34.1
>>

-- 
Thanking You
Neha Malcom Francis
