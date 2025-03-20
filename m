Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F964C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 07:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A467081101;
	Thu, 20 Mar 2025 08:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YznyHar8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A562F8129F; Thu, 20 Mar 2025 08:26:37 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB7E809D4
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 08:26:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52K7QOjo541311
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Mar 2025 02:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742455584;
 bh=T/YXkXOg4yw39prvw9AjApCQsEuTLkIugacvw5owe2U=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=YznyHar8df1HeyxDBTK2exmEkGhq3CPiC0JPNuGB5+BNm0tXH+UGpadwpBLJzr1m7
 ocnLsqwwr/9zzxIlJpqk4koa62m8T+VQEFGk5chCEeP0jaJIb5ZXx1zJdrGrIsyE6c
 xV3CQCq+vRFmVldTR2MKa/EKF2GLQ8qvyEG5uFYk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52K7QObL042946;
 Thu, 20 Mar 2025 02:26:24 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Mar 2025 02:26:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Mar 2025 02:26:24 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52K7QG4s027743;
 Thu, 20 Mar 2025 02:26:17 -0500
Message-ID: <89c485d1-448c-4572-b264-97aa91a42c4d@ti.com>
Date: Thu, 20 Mar 2025 12:56:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] net: tftp: Increase TFTP pkt string length to
 include null character
To: Wadim Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>
CC: AKASHI Takahiro <akashi.tkhro@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Simon Glass
 <sjg@chromium.org>, Jayesh Choudhary <j-choudhary@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Ramon Fried
 <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, "Bryan
 Brattlof" <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Manorit
 Chawdhry <m-chawdhry@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>, <danishanwar@ti.com>, <u-boot@lists.denx.de>
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-2-c-vankar@ti.com>
 <20250107142258.GH3476@bill-the-cat>
 <91021f80-2d2e-47f9-bdad-a652ebea7986@ti.com>
 <20250109152707.GX3476@bill-the-cat>
 <37787903-8385-41e9-91ee-9c7db33f413f@phytec.de>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <37787903-8385-41e9-91ee-9c7db33f413f@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hello Wadim,

On 20/03/25 12:44, Wadim Egorov wrote:
> Am 09.01.25 um 23:27 schrieb Tom Rini:
>> On Thu, Jan 09, 2025 at 12:41:56PM +0530, Vankar, Chintan wrote:
>>>
>>>
>>> On 1/7/2025 7:52 PM, Tom Rini wrote:
>>>> On Tue, Jan 07, 2025 at 03:08:28PM +0530, Chintan Vankar wrote:
>>>>
>>>>> 'sprintf()' function defined in 'tiny-printf.c' is returning length 
>>>>> of the
>>>>> string excluding null character. Fix this by increasing TFTP pkt 
>>>>> length by
>>>>> 1 to avoid TFTP error of request being not-null terminated while
>>>>> requesting length of packet.
>>>>>
>>>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> 
> Tested-by: Wadim Egorov <w.egorov@phytec.de>
> 

Thank you for testing the patch.

>>>>
>>>> Erm, if tiny-printf's sprintf doesn't work like lib/vsprintf.c's 
>>>> sprintf
>>>> in this regard, we should be fixing tiny-printf.
>>>>
>>>
>>> Hello Tom, I have observed that 'sprintf()' defined in lib/vsprintf.c
>>> at here:
>>> https://github.com/torvalds/linux/blob/master/lib/vsprintf.c#L3035
>>> also behaves the same way, that returns length of the string excluding
>>> null character.
>>
>> Then please rework the commit message, thanks.
> 
> Any updates on this patch?
> 
> I can see the exact same error when using ethernet boot on phycore-am62x:
> 

The fixed for this issue is there in "tiny-printf.c" file itself and fix
for the same is posted by Alexander at:
https://lore.kernel.org/r/20250220124908.3396843-1-alexander.sverdlin@siemens.com/


Regards,
Chintan.

> Filename 'phyboard-lyra-am62xx-3/tispl.bin'.
> Load address: 0x82000000
> Loading: *
> TFTP error: 'Request not null-terminated' (4)
> 
