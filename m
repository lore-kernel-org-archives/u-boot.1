Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C0EC54E60
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 11:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE6987DFF;
	Tue, 12 Mar 2024 12:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="KtEFH6oH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B386587E2E; Tue, 12 Mar 2024 12:36:26 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58C8B8780E
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 12:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=380108150e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42C96B3A006852; Tue, 12 Mar 2024 12:36:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=Hj2d4wu6VcDJqNdPpKJFwxzCMaIUQcyVkHiHm1Z6HYw=; b=Kt
 EFH6oH2AjgMCXVCFHZvEtzDKx7pFl8BNYsRWur4ZWHFJ1qzvDJQuBhxwhtOfhK2h
 6OKR4y/vXykPqH4QOtJsRlk8bPgoydvOaO7PX9Az0odDYrQYOwS8DO2li+hq0G40
 Abm8mYev7RgUW/S5AoKAxbYuEXlQAIOnSZuaG7zGRGWYMRRmYarlNJwyRWRXrc3i
 5skN07dOqZaQRQPNvukYHCPfsVULHHIJDmco6J/Xbn5GyaKRAZZtSS5QSyM53afE
 4h2AbZIaDgbejq1tc9V8VpjpYh81QaT0lDF+pYfX7991GWbTqZ+5d4zFvB5N7rT7
 1t57LcZ26hYfNdoeandA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ws3knt3w7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 12:36:18 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 36C4640045;
 Tue, 12 Mar 2024 12:36:14 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8DA6A25F7D8;
 Tue, 12 Mar 2024 12:35:48 +0100 (CET)
Received: from [10.201.20.71] (10.201.20.71) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Mar
 2024 12:35:48 +0100
Message-ID: <244cd370-a772-454e-b676-b7b2ad5671c7@foss.st.com>
Date: Tue, 12 Mar 2024 12:35:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lmb: Avoid to add identical region in
 lmb_add_region_flags()
Content-Language: en-US
To: "Kumar, Udit" <u-kumar1@ti.com>, <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Michal Simek
 <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20240311143918.2927406-1-patrice.chotard@foss.st.com>
 <32e8bffc-dbe7-48d9-985f-d794aa6a4848@ti.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <32e8bffc-dbe7-48d9-985f-d794aa6a4848@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.71]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
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



On 3/11/24 16:36, Kumar, Udit wrote:
> 
> On 3/11/2024 8:09 PM, Patrice Chotard wrote:
>> In case lmb_add_region_flags() is called with the same parameter than
>> an already existing lmb and this lmb is adjacent to its previous lmb with
>> different flag, this lmb is added again.
> 
> 
> Same parameter means , addr and size and different flags correct ?

Hi Udit,

Same parameters means same addr, same size and same flags.

> 
> 
>> Instead breaking the loop, continue, at the next iteration, we are able
>> to detect that this region already exist.
> 
> Once region already exist detected, then you can think of returning error , no ?

Before detecting this region is already present, it's detected 
that this region we want to add is adjacent to a region present in rgn[] array.

That's why i replace the "break" by a "continue" to be able to detect this region is already
present in rgn[] in the next iteration.

Thanks
Patrice

> 
> 
>> Issue reproduced on STM32MP157-DK2 with SCMI DT, bdinfo command's output
>> shows:
>>
>> Before this patch, the last LMB [0xde000000-0xdfffffff] is duplicated:
>> ...
>> lmb_dump_all:nnn
>>   memory.cnt = 0x1 / max = 0x2
>>   memory[0]      [0xc0000000-0xdfffffff], 0x20000000 bytes flags: 0
>>   reserved.cnt = 0x6 / max = 0x10
>>   reserved[0]    [0x10000000-0x10045fff], 0x00046000 bytes flags: 4
>>   reserved[1]    [0x30000000-0x3003ffff], 0x00040000 bytes flags: 4
>>   reserved[2]    [0x38000000-0x3800ffff], 0x00010000 bytes flags: 4
>>   reserved[3]    [0xdaadf000-0xdfffffff], 0x05521000 bytes flags: 0
>>   reserved[4]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
>>   reserved[5]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
>> ...
>>
>> After this patch:
>> ...
>> lmb_dump_all:
>>   memory.cnt = 0x1 / max = 0x2
>>   memory[0]      [0xc0000000-0xdfffffff], 0x20000000 bytes flags: 0
>>   reserved.cnt = 0x5 / max = 0x10
>>   reserved[0]    [0x10000000-0x10045fff], 0x00046000 bytes flags: 4
>>   reserved[1]    [0x30000000-0x3003ffff], 0x00040000 bytes flags: 4
>>   reserved[2]    [0x38000000-0x3800ffff], 0x00010000 bytes flags: 4
>>   reserved[3]    [0xdaadf000-0xdfffffff], 0x05521000 bytes flags: 0
>>   reserved[4]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
>> ...
>>
>> Fixes: 59c0ea5df33f ("lmb: Add support of flags for no-map properties")
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   lib/lmb.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/lmb.c b/lib/lmb.c
>> index 44f98205310..b6afb731440 100644
>> --- a/lib/lmb.c
>> +++ b/lib/lmb.c
>> @@ -285,14 +285,14 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
>>           adjacent = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
>>           if (adjacent > 0) {
>>               if (flags != rgnflags)
>> -                break;
>> +                continue;
>>               rgn->region[i].base -= size;
>>               rgn->region[i].size += size;
>>               coalesced++;
>>               break;
>>           } else if (adjacent < 0) {
>>               if (flags != rgnflags)
>> -                break;
>> +                continue;
>>               rgn->region[i].size += size;
>>               coalesced++;
>>               break;
