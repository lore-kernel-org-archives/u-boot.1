Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91C4C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 08:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AD7286F83;
	Fri, 17 Nov 2023 09:30:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aO4WxBbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8D6F86FCE; Fri, 17 Nov 2023 09:30:54 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BC1B86F5C
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 09:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AH8UlOW055420;
 Fri, 17 Nov 2023 02:30:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700209847;
 bh=fFoptRHz+gGIKkLi7NG5yxl1eEr+hLY0nsnFraEbbtc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=aO4WxBbb9lQ+DnYkSTz7VVahHsiyUaD8t2Ig2SwKeYz8EQweU0En3jaNA/rFZqVpb
 mqGs1ZDH52eP66KPff05Ltw2pL6c9qHP2H2224ZxenqN0s5sDL5UwGlhDzETI9JNzz
 yKFSvwuvRHfsdKTOyqctLdNspID6C+CmhK8jFvwo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AH8Ul5q037784
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 17 Nov 2023 02:30:47 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 02:30:46 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 02:30:46 -0600
Received: from [172.24.227.36] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AH8UiPH066203;
 Fri, 17 Nov 2023 02:30:45 -0600
Message-ID: <4f440a06-892b-4098-9565-6b21778bb5bb@ti.com>
Date: Fri, 17 Nov 2023 14:00:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/10] board: ti: j721e: Enable ESM initialization for
 J7200
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, <nm@ti.com>
CC: "Kumar, Udit" <u-kumar1@ti.com>, Keerthy <j-keerthy@ti.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
References: <20231003081038.24299-1-j-keerthy@ti.com>
 <20231003081038.24299-11-j-keerthy@ti.com>
 <838b07a0-8490-c05b-b08f-3ab6d3e1737a@ti.com>
 <20231003151033.GD8465@bill-the-cat>
 <726d44fe-bd81-4409-a9b2-776eea34fd67@ti.com>
 <20231116184052.GE170968@bill-the-cat>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231116184052.GE170968@bill-the-cat>
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

Hi Tom

On 17/11/23 00:10, Tom Rini wrote:
> On Thu, Nov 16, 2023 at 11:43:50AM +0530, Neha Malcom Francis wrote:
>> Hi Tom,
>>
>> Trying to bring back this series here.
>>
>> On 03/10/23 20:40, Tom Rini wrote:
>>> On Tue, Oct 03, 2023 at 07:57:04PM +0530, Kumar, Udit wrote:
>>>>
>>>> On 10/3/2023 1:40 PM, Keerthy wrote:
>>>>> Enable ESM initialization for J7200
>>>>>
>>>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>>>> ---
>>>>>     board/ti/j721e/evm.c | 6 ++++--
>>>>>     1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
>>>>> index 42fa94b7a5..070b28326f 100644
>>>>> --- a/board/ti/j721e/evm.c
>>>>> +++ b/board/ti/j721e/evm.c
>>>>> @@ -543,7 +543,8 @@ void spl_board_init(void)
>>>>>     	}
>>>>>     #ifdef CONFIG_ESM_K3
>>>>> -	if (board_ti_k3_is("J721EX-PM2-SOM")) {
>>>>> +	if ((board_ti_k3_is("J721EX-PM2-SOM")) ||
>>>>> +	    IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM)) {
>>>>
>>>>
>>>> Could we align on one kind of check,  For J721E check is done against
>>>> board-id, whereas for J7200 checking
>>>
>>> We should look at figuring out how to split this file in two.  One for
>>> "generic J721E systems" and one for "TI EVMs", as I've mentioned in
>>> other threads, so that it's easier for custom platforms to drop code
>>> they don' require.
>>>
>>
>> Yes that does make sense. Would it be okay if we solve that problem
>> separately in a different patch series? We can move along with this current
>> series for now (after making the required change in CONFIG/board-id for v2)
>> since ESM support is important for these platforms.
> 
> Well, I think part of the answer to your question is (and this is a more
> general TI one too), what outstanding changes need to come in now to
> make existing platforms functional for v2024.01 ? My first thought is
> that this series would be taken to -next, if I took it now, which means
> there's time before it would be in master, and so if it really makes the
> re-org later easier, we could take it, but if not, can we re-org then do
> this? But if we need this to deal with regressions, OK, yes, we can take
> it like this now.
> 

Maybe focusing on the re-org after having in the changes would help give more 
perspective on how we can split? Not sure just a thought... in that case I 
prefer taking this in and having a working error signaling module in rather than 
delaying it if that's okay.

-- 
Thanking You
Neha Malcom Francis
