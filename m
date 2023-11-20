Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99426C197A0
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 04:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8044F8700E;
	Mon, 20 Nov 2023 05:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fYnW+qSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E84E87063; Mon, 20 Nov 2023 05:41:22 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BA0C86BFA
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 05:41:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AK4fBs0043093;
 Sun, 19 Nov 2023 22:41:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700455271;
 bh=xUm8axQFNrIE9leX2cTottOOkBt+auiM2aZC++w7hsQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=fYnW+qSFIi81qoYpiNdimD48V0mcHpryTX5AvkE4FV243bF8swMJjHy5cSLjHdNNb
 jHFp16MBHc+RUNSbUrwf55L9iEyqg72suaOk++wDUdrSqwXEp7JxQ1FSVYJjpOJo4U
 1/Gc+X5A/rch6i/0nfL+fB3WHiY9Ti2Ct/595xg4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AK4fBNX103727
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 19 Nov 2023 22:41:11 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 19
 Nov 2023 22:41:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 19 Nov 2023 22:41:11 -0600
Received: from [172.24.227.36] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AK4f87Y119961;
 Sun, 19 Nov 2023 22:41:09 -0600
Message-ID: <46e34035-a503-4548-8958-5fd7cacaa058@ti.com>
Date: Mon, 20 Nov 2023 10:11:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/10] board: ti: j721e: Enable ESM initialization for
 J7200
To: Tom Rini <trini@konsulko.com>
CC: <nm@ti.com>, "Kumar, Udit" <u-kumar1@ti.com>, Keerthy <j-keerthy@ti.com>, 
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
References: <20231003081038.24299-1-j-keerthy@ti.com>
 <20231003081038.24299-11-j-keerthy@ti.com>
 <838b07a0-8490-c05b-b08f-3ab6d3e1737a@ti.com>
 <20231003151033.GD8465@bill-the-cat>
 <726d44fe-bd81-4409-a9b2-776eea34fd67@ti.com>
 <20231116184052.GE170968@bill-the-cat>
 <4f440a06-892b-4098-9565-6b21778bb5bb@ti.com>
 <20231117140713.GD170968@bill-the-cat>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231117140713.GD170968@bill-the-cat>
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

Hi Tom,

On 17/11/23 19:37, Tom Rini wrote:
> On Fri, Nov 17, 2023 at 02:00:43PM +0530, Neha Malcom Francis wrote:
>> Hi Tom
>>
>> On 17/11/23 00:10, Tom Rini wrote:
>>> On Thu, Nov 16, 2023 at 11:43:50AM +0530, Neha Malcom Francis wrote:
>>>> Hi Tom,
>>>>
>>>> Trying to bring back this series here.
>>>>
>>>> On 03/10/23 20:40, Tom Rini wrote:
>>>>> On Tue, Oct 03, 2023 at 07:57:04PM +0530, Kumar, Udit wrote:
>>>>>>
>>>>>> On 10/3/2023 1:40 PM, Keerthy wrote:
>>>>>>> Enable ESM initialization for J7200
>>>>>>>
>>>>>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>>>>>> ---
>>>>>>>      board/ti/j721e/evm.c | 6 ++++--
>>>>>>>      1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
>>>>>>> index 42fa94b7a5..070b28326f 100644
>>>>>>> --- a/board/ti/j721e/evm.c
>>>>>>> +++ b/board/ti/j721e/evm.c
>>>>>>> @@ -543,7 +543,8 @@ void spl_board_init(void)
>>>>>>>      	}
>>>>>>>      #ifdef CONFIG_ESM_K3
>>>>>>> -	if (board_ti_k3_is("J721EX-PM2-SOM")) {
>>>>>>> +	if ((board_ti_k3_is("J721EX-PM2-SOM")) ||
>>>>>>> +	    IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM)) {
>>>>>>
>>>>>>
>>>>>> Could we align on one kind of check,  For J721E check is done against
>>>>>> board-id, whereas for J7200 checking
>>>>>
>>>>> We should look at figuring out how to split this file in two.  One for
>>>>> "generic J721E systems" and one for "TI EVMs", as I've mentioned in
>>>>> other threads, so that it's easier for custom platforms to drop code
>>>>> they don' require.
>>>>>
>>>>
>>>> Yes that does make sense. Would it be okay if we solve that problem
>>>> separately in a different patch series? We can move along with this current
>>>> series for now (after making the required change in CONFIG/board-id for v2)
>>>> since ESM support is important for these platforms.
>>>
>>> Well, I think part of the answer to your question is (and this is a more
>>> general TI one too), what outstanding changes need to come in now to
>>> make existing platforms functional for v2024.01 ? My first thought is
>>> that this series would be taken to -next, if I took it now, which means
>>> there's time before it would be in master, and so if it really makes the
>>> re-org later easier, we could take it, but if not, can we re-org then do
>>> this? But if we need this to deal with regressions, OK, yes, we can take
>>> it like this now.
>>>
>>
>> Maybe focusing on the re-org after having in the changes would help give
>> more perspective on how we can split? Not sure just a thought... in that
>> case I prefer taking this in and having a working error signaling module in
>> rather than delaying it if that's okay.
> 
> OK, please rebase on top of whatever other series are needed (and note
> so in the cover letter) and mark it as non-RFC, thanks.
> 

Thanks! I'll rebase and send the next version.

-- 
Thanking You
Neha Malcom Francis
