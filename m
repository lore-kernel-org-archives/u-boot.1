Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47909D58D5F
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 16:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B71D89A4A;
	Mon, 25 Nov 2024 17:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wiR99Wzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 362C989A4B; Mon, 25 Nov 2024 17:01:43 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6169C89662
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 17:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4APG1WZP696220
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Nov 2024 10:01:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732550492;
 bh=PH/SLT0iCNnjRUAD0MjUhfPjIuCx7yZO+asnv3aoLY4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=wiR99WzuOHeVqoXDQxVFPPDDhyCcSHgF4xVHiBCbsOiduMKfU3zu60sZNYyCE4VY5
 qxOT7vFl+ErjRd8Kk/xVThJCRrIDPQti4fcH3W9jCfa08EEIv5Fr39jIHvhpGk7Qsl
 b7lBLYU8L1CKBB7VY5XpfPhK5tnl9m4XhMT+vo/g=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4APG1Vps091703
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Nov 2024 10:01:32 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Nov 2024 10:01:31 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Nov 2024 10:01:31 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4APG1R22009352;
 Mon, 25 Nov 2024 10:01:27 -0600
Message-ID: <0a277443-acf8-4cf4-8462-949a15c012d5@ti.com>
Date: Mon, 25 Nov 2024 21:31:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] board: ti: am64x: evm: Set "dfu_alt_info" only if
 interface is Serial Flash
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <j-humphreys@ti.com>,
 <m-chawdhry@ti.com>, <rogerq@kernel.org>, <nm@ti.com>,
 <sjg@chromium.org>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>,
 <afd@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
References: <20241124070828.617558-1-s-vadapalli@ti.com>
 <20241124070828.617558-2-s-vadapalli@ti.com>
 <5d7974f8-7b29-43f7-a6bf-e364ce37967f@ti.com>
 <qt4cvxsksteeqakcki5vflrjyqwfszajelhcqcnwiqmijt4rn3@oktsm3t3pqvc>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <qt4cvxsksteeqakcki5vflrjyqwfszajelhcqcnwiqmijt4rn3@oktsm3t3pqvc>
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


On 11/25/2024 10:55 AM, Siddharth Vadapalli wrote:
> On Mon, Nov 25, 2024 at 09:27:50AM +0530, Kumar, Udit wrote:
>> On 11/24/2024 12:37 PM, Siddharth Vadapalli wrote:
>>> Commit 5b84d2de5e6c ("board: am64x: Define capsule update firmware info")
>>> updated the "dfu_alt_info" variable to support use-cases with Serial Flash.
>>> However, this breaks use-cases where interface is not Serial Flash ("sf").
>>> Fix this by setting "dfu_alt_info" only when the interface is "sf".
>>>
>>> Fixes: 5b84d2de5e6c ("board: am64x: Define capsule update firmware info")
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>>
>>> v1:
>>> https://patchwork.ozlabs.org/project/uboot/patch/20241124051545.382397-2-s-vadapalli@ti.com/
>>> Changes since v1:
>>> - Replaced "SPI Flash" with "Serial Flash" everywhere.
>>>
>>> Regards,
>>> Siddharth.
>>>
>>>    board/ti/am64x/evm.c | 8 +++++++-
>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
>>> index 00b8317d6b..18f7770bc1 100644
>>> --- a/board/ti/am64x/evm.c
>>> +++ b/board/ti/am64x/evm.c
>>> @@ -56,7 +56,13 @@ struct efi_capsule_update_info update_info = {
>>>    #if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
>>>    void set_dfu_alt_info(char *interface, char *devstr)
>>>    {
>>> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
>> Could you evaluate possibility of moving this function along with others to
>>
>> board/ti/common/ area.
> Sure, but that doesn't have to be tied to this fix. I will take a look
> at it independent of this series.

Ok, Please take care in other series.

For this series

Acked-by: Udit Kumar <u-kumar1@ti.com>


>
> Regards,
> Siddharth.
