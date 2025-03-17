Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B2AC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 08:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A58408058A;
	Mon, 17 Mar 2025 09:59:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sBldVtCk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52E1280F4C; Mon, 17 Mar 2025 09:59:48 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C85580107
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-vm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52H8xhWQ2754582
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 17 Mar 2025 03:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742201983;
 bh=PRmBUrNR8OekVVNeerGvEqyub7KKjsqxcJR1I2DXZxs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=sBldVtCkUn4a3nhpscitYujwgPaD6srjj9ab+Mr0WA2q0gmgGRFA2XVKvY8WFuFh0
 m3FBopz007pdiU7G4Aq8PxOmdGxZvuT/XKB6kqxFYWH+imy0cO/LfIIJDsorWFWGnU
 8gYi1W0LUf8JqCSMPnc2Fd3HTZkh0PKV7CgXDzDk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52H8xhFC026474;
 Mon, 17 Mar 2025 03:59:43 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Mar 2025 03:59:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Mar 2025 03:59:42 -0500
Received: from [10.24.69.179] ([10.24.69.179])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52H8xeR3068461;
 Mon, 17 Mar 2025 03:59:40 -0500
Message-ID: <f9ae49bc-0bc8-54a9-acaa-e1d80bfbcb45@ti.com>
Date: Mon, 17 Mar 2025 14:29:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 1/4] cmd: fuse: Remove custom string functions
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>
References: <20250313115517.1181829-1-h-vm@ti.com>
 <20250313115517.1181829-2-h-vm@ti.com>
 <20250313161539.GE2640854@bill-the-cat>
 <768e6b56-b55a-834b-4abc-41b9cee701e1@ti.com>
 <20250314140928.GL2640854@bill-the-cat>
From: Harsha Vardhan V M <h-vm@ti.com>
In-Reply-To: <20250314140928.GL2640854@bill-the-cat>
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



On 14/03/25 19:39, Tom Rini wrote:
> On Fri, Mar 14, 2025 at 07:13:19PM +0530, Harsha Vardhan V M wrote:
>>
>>
>> On 13/03/25 21:45, Tom Rini wrote:
>>> On Thu, Mar 13, 2025 at 05:25:14PM +0530, Harsha Vardhan V M wrote:
>>>
>>>> Remove custom string functions and replace them with normal string
>>>> functions. Remove the custom strtou32 and replace it with str2long.
>>>>
>>>> Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
>>>
>>> Thanks for doing this.
>>>
>>>> ---
>>>>    cmd/fuse.c | 27 ++++++++-------------------
>>>>    1 file changed, 8 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/cmd/fuse.c b/cmd/fuse.c
>>>> index 598ef496a43..9f489570634 100644
>>>> --- a/cmd/fuse.c
>>>> +++ b/cmd/fuse.c
>>>> @@ -15,17 +15,6 @@
>>>>    #include <vsprintf.h>
>>>>    #include <linux/errno.h>
>>>> -static int strtou32(const char *str, unsigned int base, u32 *result)
>>>> -{
>>>> -	char *ep;
>>>> -
>>>> -	*result = simple_strtoul(str, &ep, base);
>>>> -	if (ep == str || *ep != '\0')
>>>> -		return -EINVAL;
>>>> -
>>>> -	return 0;
>>>> -}
>>>> -
>>>>    static int confirm_prog(void)
>>>>    {
>>>>    	puts("Warning: Programming fuses is an irreversible operation!\n"
>>>> @@ -54,14 +43,14 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
>>>>    	argc -= 2 + confirmed;
>>>>    	argv += 2 + confirmed;
>>>> -	if (argc < 2 || strtou32(argv[0], 0, &bank) ||
>>>> -			strtou32(argv[1], 0, &word))
>>>> +	if (argc < 2 || !(str2long(argv[0], (ulong *)&bank)) ||
>>>> +			!(str2long(argv[1], (ulong *)&word)))
>>>
>>> I didn't know we had "str2long" which is a differently rarely used
>>> function. Why not just simple_strtoul inline? Am I missing something?
>>> Thanks.
>>
>> We cannot use simple_strtoul inline directly because we need proper error
>> checking to ensure the simple_strtoul conversion was successful. The
>> str2long function is a wrapper around simple_strtoul and the necessary error
>> checks. Hence, using str2long here.
>> Thanks.
> 
> I'm sorry I'm still not getting it. We virtually never call str2long. I
> was taking a quick look at why if anything the 4 callers in the entire
> tree today have more special error checking requirements than every
> other command which parses user input.
> 

Hi Tom,
I tried to retain the error checking done by the custom strtou32 
function, hence replaced the custom strtou32 function with str2long. I 
did notice that in some other files in the cmd/ directory, 
simple_strtoul is used inline with NULL as the endp parameter, like 
this: simple_strtoul(argv[2], NULL, 16).

Do I proceed with replacing the custom strtou32 function with 
simple_strtoul inline by passing NULL as the endp parameter, similar to 
the example above? Please let me know if you have an alternative suggestion.

Thanks,
Harsha
