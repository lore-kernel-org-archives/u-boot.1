Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F2EC5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 08:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA49287E67;
	Tue, 27 Feb 2024 09:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="Eu/GYOux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A8B87C94; Tue, 27 Feb 2024 09:57:38 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10B0787C94
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 09:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JICtl72GUaU39AbYME5Zjvha4SRnBHetjOnIcme5ONbT5frQXfUZBogCkJrGKvCCKKJ4FbPnRWyIZASt7LttYSAiF1LSUFSTq0iCJ4CsL1WGAkb+FG1iWevk8RM/1XMYr+MCvJFaiO/72PC1US6IeP7QzC1C9eECs6j7pL2qbsVEVm3JBEB2ag0DlRXEcuGT3LskR0o/yuSOPinQXFiUIQxw6s2wi7EMkDA84YwkkN+nJSgaNB7w0HqoWOpPcs42Abzz7WqDAQACuYk8eIL17CYcyIEz0SEk4WzoDA3f/9iOlR3ApEvLNMTOoMkYzKVnTOQx8bG1aNDfFKpPRFztGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pRYznsne66XTi2ZRF4QGoeVE0ROHLGEAmTeSbdkDbM=;
 b=OyqN61Jexf/RfsJjvrKLR5kE07DAd3PMz+cEkvmsTnSfrnv/WiZ3KO12sv8OXV4NHcT3qLvL9+guMlaBlLCx2RZc+H8l23lW9NybBOk9jgpT8qVu1uItEnuDtJGhxhk8LdmHsF5HsrAX38v0hb1KxloChwHawKaXyi4x6qLTdFOJRW/4stxTC3FB9mP2FE7UFYADUq3upcy/1Z2pXpbwZXA0C1o6LuLs/NODYyWtv4dyreITeJz8NFWnad+UHaLAbeLT8UfyEjs8bgblZzROED3mc/d3Qng5gT9W3ZeMqXlXCu7IvkjSEsN2jAN1ABu0/X3iQSN+0LRUvzXATBlHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pRYznsne66XTi2ZRF4QGoeVE0ROHLGEAmTeSbdkDbM=;
 b=Eu/GYOuxc3P2K/E1pk/oAbZcmQ76HeSck555vMUUqn6xMQoLDtsgIYde2SkXP2D8xFrfFdrxnBEIWta34ZJB5pjLOt/djcmKYYoqIXPegT/2rF6fO20k5JQsaNetf8uwZth5rBIOWTdK6v1qFuQehKPSZUd9VRBLL59yLFgr5Uk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by VI0PR08MB10711.eurprd08.prod.outlook.com (2603:10a6:800:20c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 08:57:33 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5%6]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 08:57:33 +0000
Message-ID: <ee6ab688-49b0-4385-8144-7c37eb5bbeeb@weidmueller.com>
Date: Tue, 27 Feb 2024 09:57:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add label to pmu fwnode
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>
References: <20240227084008.2086287-1-lukas.funke-oss@weidmueller.com>
 <95f2396d-782e-42c1-8579-ca1a55d788eb@amd.com>
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <95f2396d-782e-42c1-8579-ca1a55d788eb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::10) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|VI0PR08MB10711:EE_
X-MS-Office365-Filtering-Correlation-Id: 94691ec4-4fa6-4ce9-3a58-08dc37722328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OjKoFaDIytUhzS1xRPQKsCXQmxJ/EzpmQHtIVGpGWW3zS+EsiX9fFKa9F3POH3iLMBvt/Gv89ngpjzQyvkgO/U7lFUUgqNeT1/Oy8c7VD2E/y80GxI0s9m5C4/s+sNEVqlfxbmwoLOLRyfoaaYdJgEqVGVtrSZdLpWCv/zGeax2s3JteBw37l2iZO/EIMMHgHj1s8ZgyCWJR5OOIRIuVzl2YF2kc0bNli7mvMXLjgGCyLUM7aYb1XeGuTDMq8rPTbrLqv3I0CV8+t6NPzD39IcyLDGvTxSGCP4Vffv+EGN0Zkw5e7XSXECUCzycSkbZlfCl48C52VayiRE54fiMwht7jP/3tSnEJUBYNfcWrxXDOy53uvVjeb+sIWLwzt9lZzcA91sJ4BkK/MSH+7iMIg7mU1R1Lvf//mMolZXpcqu7y83N/PiycLvaDkWSA9E5B2fWmYovsWcD1Im/NIa5/fQZaTuvidvJ9LK7k+e36FjcUwMUmvQ+GxQ1mp6Pfn3R9mtlRxnR129eHVVowvGNB9i9GO6fr5B2Kg0nUtVnfF56X3XE7rAvudJeWReqG9KlzjhixZlWQDikZl93bHIsh86B7kPZzyjPqTxaJr4it8uPqniLT4Frehk2iHqtFtG6gW/DB1d4yyMY+ZQ49gi4GVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejlzL2pQaTlFUml1ZlZmN2Jpc2J0ekRGN1dNdFJ1RGNNb2c4TTZTWExMdC9q?=
 =?utf-8?B?amhIV3NiMlJnWWNreldEeWl4MHFMZFRWVmlydmQvaDFTUkp1QitOWmxtNTds?=
 =?utf-8?B?UnQ4N0dGRGZGM29GY0J2NGgyMDNXdDN1aitlL2MrVHYrTFN1K2dEa3E5V2xR?=
 =?utf-8?B?bUgrRUxOeWNwbTFITUtyU3o2VmV4UWh6NlpQVkxSMUlMQWErYXFxSkdJUUhG?=
 =?utf-8?B?a2t6UEwzMjVnNjdyWTBzdEdjNlg5UC9zZk81Wkdnc0JsNGYzNGFUVGZsMFBh?=
 =?utf-8?B?MEVTMklhaFdFcjdnb2VmVVlQSjhYL0xMeHdza1kxNUdWMW5OM3B1QitYTHg1?=
 =?utf-8?B?QWdHYzBzcTBQeVMrU0JXemsxSWNmeDF4Q3ZHOG05YXBVVWZ0WG1wWjQ3TUxG?=
 =?utf-8?B?Sy9MNmhvaFdMaDgzbHpaMjJCSzB5azhZU2xOUysxUDYxNXo4V0tuTDlPTHUv?=
 =?utf-8?B?QTk1RUlPWmlDaU5nSWE0MDYvSGhNQmVZT21Sc2V5czBCSHVJbzBnVVZoRnBZ?=
 =?utf-8?B?Tm5DdlFzeE9iZ0FnYjdsZHhUMWRYTTUxZlliTHVwWHkxalNrUk9mNHR0OEZZ?=
 =?utf-8?B?YUJGQTQ2RThNVFk1cnFqaStscitUZ1lkVTJ3S1p0SlRSblNzZldsdHdTdmoy?=
 =?utf-8?B?RkRzdDBURTJCNDdLaGJzYnUzaFp6aVJwNzRzaUlUSTFMR3VjVlNUeHJXSVRL?=
 =?utf-8?B?eVlycFVHcGdyc1cxeUplelk2Q0g0bGR1RTBqRjQwS2VndWxFT3cyT2VuekE2?=
 =?utf-8?B?RTJhM2oydjdrOTNYRlB3U01wekowZG56bEQvR0s5TkFvdmkxWmVMMzNHNHM5?=
 =?utf-8?B?Z2lvaktoYXdaMnNCYzFCMzhTeXdvQ3RIVmxJMDlNWWxkRnNQR1gyeHFWT2Yr?=
 =?utf-8?B?d2pueVpNOHdzckRWOVFFWUZKM0pDZ0dtVk5YNkFSTUpiVWw1L01IcmFrWDE1?=
 =?utf-8?B?QmVjaGlZTUxYV1F5TThWZmlIakZ3aXhHSGxHcW95Qk1WSURlUHFPbjQ2aHo2?=
 =?utf-8?B?MWMwTjhPeHpLazU5WlZIRnFPd3Qwbm9tSnUrT0w0RXZMRzE1U3ZqZkErLzJ5?=
 =?utf-8?B?MjRFSVZLdjZOUVFQTTF1QkxjVXY0cW1welNhM0xud0Q1US9vQkRBYmV0S1BU?=
 =?utf-8?B?TFh3eUtPeUxydDRQQ0Y1Z2kvdEtUUE55elhlYjRrWnlRWkt5Z2E1Q3czcTdi?=
 =?utf-8?B?eUVNdnp4Wm5mLzFkcW91V1d1ZGthdzZWaHlUczR6TnBGNlNnMVBWNHgvK2hl?=
 =?utf-8?B?T2Y4M2g2L0QrTTE1WEp0Mnlsa0pHNXJwMEZzaGhINThBd1JWNzBPUGJ1aWVU?=
 =?utf-8?B?U2NzT2FpKzY2WUVkVWNKdVhpTml0eDIvZFVzMG1HYzNDUEY4QXNDWUxiWnB3?=
 =?utf-8?B?cmRMdURwNTRkUy8xRkUzUlpzTmtmemtSeVNOdUg4b0ZISGRoOTNuejZsK2lq?=
 =?utf-8?B?VWQwVkIyU2JsekQwUElKTVlSR21iQTdUSHAvK1VuT1V3b3Nyb1duVWZuVVhn?=
 =?utf-8?B?VHcyRytHNDFrWkRHczVrZjRrdGpmWXp6U0N5VWdJSWo5RncyYXhuRzdWWHhn?=
 =?utf-8?B?dHpDNEJ2UEo1SXVxcGtTdUZVTHVqRStsTk96UDBaRmxqb3JDR0dzeSt2ZTY0?=
 =?utf-8?B?SE1lcjVwMVdIblZ2YW5WSlJLZ1dmMmY5eFh1KzVsaUVVM0FrVkwyNzd4WUNv?=
 =?utf-8?B?SnVWSHA2Zncva043aUF0U244T1o5dmx5ODV2TFhiSForTWtmUnFyUkd1N0Fn?=
 =?utf-8?B?RW1jZGswTUdqSXB3WXB0UEN6dmZnNkN4bjEyUlhGWHR4cENJZFp1ei9pcm5y?=
 =?utf-8?B?OFN6dlIzUFY4UmUrN29URXZxREFQZkFPSlJ3Z3ZLMG1NQXE3NmJPUVh0U3hi?=
 =?utf-8?B?dDhzcW5EZ3lQN3p6YmtZMWdYMi9oYVNlejVqSm0rMGR6RzRVQ2s2UW82T1hm?=
 =?utf-8?B?VWlVcFFSa2YvaFhMV2kvbVgwbHN0OElQMXNHY1MwaWltaU5KbHpRSHhWck9L?=
 =?utf-8?B?ai9sZ1JYNndpR0Zic2huamVVN05SeGJGMEJvVDY4RVBvdkRISlZWSEk2MEl6?=
 =?utf-8?B?bGw2WnB6QkhKMzB5SUFTMkhTcVdQWjRmWWZ5QlFiNC9zTVovVWhNcGlKRmt5?=
 =?utf-8?B?dFhFRldIRERQMTQ0c3I1WXpWUHRrQWR4WTlsVVZsdVJsblJxdFA1TU9pdUt4?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94691ec4-4fa6-4ce9-3a58-08dc37722328
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 08:57:33.6154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfsRdUl9r+BHpLpxAuu2QwsEM2uZTi97JSO5aqNuiastrB9FqUaWBRozzpnjQxOY5T+P1dnW/XaDXK46UqF3yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10711
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

On 27.02.2024 09:45, Michal Simek wrote:
> 
> 
> On 2/27/24 09:40, lukas.funke-oss@weidmueller.com wrote:
>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>
>> Some zynqmp SoCs (the cg series) only have two cpus. Thus, for some
>> cases the cpu-affinity has to adapted, because cpu3 and cpu4 are
> 
> interrupt-affinity right?

Duh. Can you update the message accordingly or should I send a new version?

> 
> 
>> missing. By adding a label to the pmu fwnode the cpu affinity can
>> be adapted in a device specific dt.
> 
> Why do you need to do it? What problem do you have if you don't change it?
> It shouldn't be different compare to max_cpus=2 right?

We remove the cpu nodes for our cg devices in order to have a dt that 
really reflects the hardware. This way one does not have to pass 
additional parameters to the kernel. Unfortunately if the cpu nodes are 
missing dtc complaits about them due to the interrupt-affinity property.

Since you seem surprised by this: is this the correct way?

> 
>>
>> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
>> ---
>>   arch/arm/dts/zynqmp.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
>> index b50b83b772..457f8e394f 100644
>> --- a/arch/arm/dts/zynqmp.dtsi
>> +++ b/arch/arm/dts/zynqmp.dtsi
>> @@ -168,7 +168,7 @@
>>           bootph-all;
>>       };
>> -    pmu {
>> +    pmu: pmu {
>>           compatible = "arm,armv8-pmuv3";
>>           interrupt-parent = <&gic>;
>>           interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
> 
> And I actually prefer to have labels for all nodes to be able to 
> reference it.
> That's why patch itself is good.
> 
> Thanks,
> Michal

Best regards
Lukas

