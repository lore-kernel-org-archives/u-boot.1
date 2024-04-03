Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B815CD11C2
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 01:20:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B50287CB7;
	Wed,  3 Apr 2024 03:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="Lg0cuhv4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13B6687CB7; Wed,  3 Apr 2024 03:20:07 +0200 (CEST)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01olkn20800.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:280c::800])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A70CD878A1
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 03:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuKQFQa0CYp8xlg4xg+vzTxM1lk52aCpH/7FQIpMxofX4wOjDMwxViTGd2s/gXsS0qqMVaHYpFniJpJyylaLjTMeWMpQT0GnPN7MoopkbnRyZCJEw7bil4cKn3umPtU85yJ41+4CouBlv+R02goeSB7GOh0qed9bKsTfTmx9BTJutyr8CHyVGA4nE4tvB/NBfPWjlqjVEIooI+8fL5N7b63ey/b51kNebawQMzuV3BusScmN8Y3RQRt2WzmFnXUSCDiUiE7TouGHm58gAWuFtNaiQJQqRc7EKKWVlSj2xA/Z0XZtm7rA2ZRqNdsO0JVZQkWMcOJqysiTgy7CocxmhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu9sNK7sWeHDKMKEtuqe98rj2mv9ouu20r9QW2ZSDRU=;
 b=BhMUnPuoEkKlyNH3hvFfnlGoZNDlWcppmor3OaDkldPR+V+WyoShttSDTvJJApIQpUZHg6L1NJiUNND6xNVgsSOrCR3dYD89AlJa+Zt8qyqf/nBk1OCMfoVQFLocXP1PxtfEUpRVCSsNLUzc6fpnvSuR7l4UMt/RLrzM0N4LVjCpTA9EyyU8vbpRrQ9v2KUwvo7OawDztWxCkZTBEqs0KxLPkc0/0ygTjLykhH92M5o/IP9nb3lWbKVMADak+fxLr4cn84BwsZdXd/DuL3Q3Jt/gbExYqx/3CFrlW6DjiiknYC6YOOfrbat1+qpRcNFBe3VFLjNNTZde515pQurV/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu9sNK7sWeHDKMKEtuqe98rj2mv9ouu20r9QW2ZSDRU=;
 b=Lg0cuhv4WfvIex1irwL8PgLgxnH5krkliX2urqsan6sZBAgcDi42oanwEHxIHAO0u+3URfiIX24gXb7j4K0SFccoOAJ4tDYhQl3zt1NUUegb0Si4kcOPWvsCDTIhpjeRbD5zZi2bi2p69GrOpVG8EbQzq3G0MHlNVT4h6I1CBfXcTNSWfwFfcrF8QD4zaDMk8oqvaNDyZH2YRFoP0XAKxpvbXfumwZWDboocCDvmSX8eyQppFGvlO9KlsVDtjnjGpQy1p7Vu2YDixTl3RXZ9sX8qyxemCS/i1qeeA1vSU63/10yF0cLM5cEh2FOe1oKDUgEnkVxkO4gfBzrTfGfCBA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB6402.apcprd06.prod.outlook.com (2603:1096:400:425::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 01:20:01 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 01:20:01 +0000
Message-ID: <SEZPR06MB69598F7A966ABC6664BD4724963D2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Wed, 3 Apr 2024 09:19:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mmc: dw_mmc: Don't return error if data busy
 timeout
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de
References: <20240201-mmc-v2-0-9f09dc1335fd@outlook.com>
 <20240201-mmc-v2-2-9f09dc1335fd@outlook.com>
 <CGME20240403004155epcas1p1fdb3680cde2a4dee4325e22b9b076e6a@epcas1p1.samsung.com>
 <908bd8cb-b7a3-4701-b636-6d96cd2d2472@samsung.com>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <908bd8cb-b7a3-4701-b636-6d96cd2d2472@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [rfOzz/TS3HNsIyrZOoUdGFbcY+RWXHn3IhWBTGqD69tx8lAVlb1oghihXfoftC7L]
X-ClientProxiedBy: SG2PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:54::22) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID: <970132cb-f193-46e5-aa1d-b3ef9ec745bb@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: a210e365-37e2-489d-b7aa-08dc537c2eca
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HOS1ch7fNT5igygp0t2c/YmvYxRQFSDOAJeBXRzTKHPrjpvC5HfMfZ48LX5OIWfVaoq3mwWjiBukXiSg1WxW/LBxbVNpeTPpUcesh0Ews8Esizw1GpriUIiFDYrw1De5niE5Yo5yFS4kOWd33DBjIGCh0AsE3a0ALU9eKZ/HwT84mEdqQoTmpMfYsCqlb2Rz5a2dQFMRGzIabwaxbS7oINDRKRMZlWNqG7vgvS0AaVkU8zWCOsJuxZm+CDPz+8+Xzeb+Z0NRMPnjOT1w4OuOxzSOOx1ItOdbIwwpS8mCm/Dti8Qgo7nnD1yNG4DL1xiXcp7uWp+oT15V3tEMBIga7/Jh3U0sbofYEWNUSNZmSN/befWZZnuqv7C3UFsfs42TBgkTdF5TJPjif//4mYgqi5T5/stofgxgTwBzEaIrR9moeabGtLPYhxj82Q9B+Ev1Q2RWbyzUv++qyr/1Gb6qPAL61U3TcLU7VhLXPIdqLWYUmzl/xa42jkr9/QDQVV0oaomZPevNqw4M+it3ddyUkXMv23JLxa2vQQc6XeRNHy+Bt25I8tjixSUDvTjJ0i/xtOSbaDw0XNfh90gBKmyAsw4eNkHuqWS5AUChFcFGt1AswFeQMfY4mToZe//AqPaSTcFES4vebeJ98yjYUjnOurzBGGLUBetx8v4EMBNdCI4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU1abTlxOERwMDQrVDJ5SmcxMS85V2NRQjF0Q09UQjZTaWxHaGE0bGQ5Nytl?=
 =?utf-8?B?MGNxNDVhbnpSRmlOSG9scmYrVmk3SGIyTHVJanI4RWJmbmRibDBXRmdmQWxW?=
 =?utf-8?B?YzlYREpKM2ovUWRNK0lvQzNiaWprMXNWanI4UDZTYWZGK2FvRTc4a08ydVQ4?=
 =?utf-8?B?VjR1SzhlaVlDcnZEaklMc3lPYjB3UHJiR0hzQlZLUDJ3M1RxQlpWM0d3b3hl?=
 =?utf-8?B?MmJFdjhGYWluWXJLSmlqdmVXSStzb2trc1NkbmR1MFNPL3AzR2pqa3poSXdP?=
 =?utf-8?B?WFc5QmI4OU41WEJJUmtQdjZ0OE9ST3pBUHMrTXRRRVAzYStsRTZXVnMrQ2Rr?=
 =?utf-8?B?T0RaV013SEZWN1doUmNIbFlEZFlUcWcyL0k5Vlg2RlFzeU11ZlRKRXYySFpK?=
 =?utf-8?B?dDJRazd6S3dJT1R3ZnBQSnR2OHVmdVBrbUtoR3NOVmN3aFd2VFdoaFA1OUNH?=
 =?utf-8?B?dFp2NVpEWkg5dlYvV1NIbzlPNk5MOGMwWDlBRUU1MldwSWJaWkRDa0Z1aGhB?=
 =?utf-8?B?cFRKR1VaRFhvdGZrelo1bUpiTVNEQTR3UjFDYnAwaDlDSC9pdEo3NlZ5QTlw?=
 =?utf-8?B?NGFaMFFkR3VoK2MyNC83RGVCN2MxdmRwRHM0S1lyay8zVTJYVFNKTWJrdVBa?=
 =?utf-8?B?MzN3U3NqcmhmcW9JU2lJQWpuaVhYall5OEpyQnZGSWRPNE9ydFlNbG1QRkZV?=
 =?utf-8?B?NWZMRFBEc3lXK280cDF3TER5UUZneGpHejgrb1l1UG1IQ3preEJTcjhhYkVt?=
 =?utf-8?B?aVpkRG00clhjZUUyaEdCZ2pnK1RENm5LcjZkMkNJam9GVjB0MWw4bCt0MEZh?=
 =?utf-8?B?OFZ6M0NXUjRpRVB0NUpjOUN5WDgwNFpOd0xqY1ZHZCtVRUdBbzFTUXFlMHBE?=
 =?utf-8?B?bzFFZm8xRTh4ekZ5b1NsSHZNZk11SmRGWTdNZGI1REJiYVB4MkdrQkpUTGth?=
 =?utf-8?B?OWIrVlI2dWlZckhhYThBaDE4MUNjRTFTeURraUJnamIvbkoxSmU2dEt0d25R?=
 =?utf-8?B?MTZSVkJIM1pXTjZDOEI1TmJHM2ZyWlU1Szc1WTJEWlZ2NXlWb0x3dkFvQVRH?=
 =?utf-8?B?a2FpMkpuQ2hzRlZKYzY0aUdUdlhESzJDR05WYUNsSHNoaW1rZElqOCtYQWFw?=
 =?utf-8?B?K1NyNmEreFpBNUpQNm44L3V0c3F0OHNpcnJHOWJicWkvaDZMb3kyQ3BRVHgr?=
 =?utf-8?B?VU5LOU0vb3hzN1dyNG4zSWZvc0ZrUUNYZUoyUWdiOCt3Mi9RNnpZa0E1QjRR?=
 =?utf-8?B?SER1R1BjWUFHdEZ0N0Vad3NocG9NMUlBNThzNDV5S056eEhjcmhzbXlSc0J5?=
 =?utf-8?B?T3krdG5JOFRZeXZwVFFrREwrTHZHcDRQemF4Ty9FSXdnZGo4eXJzZ1gzcjhy?=
 =?utf-8?B?dTF3TmdJNlFwVUJNa2FDbHZ2cHdqOFNqaWxDZlN3eCtHT3NwcSthQ0l6NEsv?=
 =?utf-8?B?Mno1ME5mS0NSRVl6TTMzdFpRZGdUcHAwSDl2eUxRdnZWUURNRlUxTnNqdnU4?=
 =?utf-8?B?Zjh6RHRSQVBIYW5qK2VZTXdtU09xcHcraFMzR0FWWGExL2UvcFNpbVJ2Zm85?=
 =?utf-8?B?U2pRd0U2Q2FVMkRwem9xY2NnVndHamxISkhwQmZVZjdTcm9aMkdCcW01cm83?=
 =?utf-8?B?bG81czBTSlRDVkV2a29oMW4zQ2FxR21LZmJZNHFCeGtMR1BQcGhsRTdGdzZJ?=
 =?utf-8?B?SWsxcFV3a3BxMFQwNDhreTRZRTNBUEhLT1JBYm91UEpxaXdFeWdhRXljQldP?=
 =?utf-8?Q?XRHwh5Q5tJ7ux1iKYZv88E0cXQLt7To3AAmlNAj?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a210e365-37e2-489d-b7aa-08dc537c2eca
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 01:20:00.8003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6402
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

On 4/3/2024 8:41 AM, Jaehoon Chung wrote:
> Hi,
>
> On 2/1/24 23:05, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> As described in [1], some poor hardware or cards would fail to release
>> the bus and keep driving data lines low. Ignore it and send the next cmd
>> directly seems okay for most cases.
> This patch seems to be same with previous patch, right?


 From my observation, this patch does fix some weird problems and is 
mostly okay for other dwmmc users. I can't say it is very well tested 
because of I can't come up of other tests i can do except some `mmc 
read` and `mmc write`.


>
> Best Regards,
> Jaehoon Chung
>
>> [1]: https://patchwork.kernel.org/project/linux-mmc/patch/1424458179-5456-1-git-send-email-dianders@chromium.org/
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   drivers/mmc/dw_mmc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
>> index 400066fa99..e103664145 100644
>> --- a/drivers/mmc/dw_mmc.c
>> +++ b/drivers/mmc/dw_mmc.c
>> @@ -262,8 +262,8 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
>>   
>>   	while (dwmci_readl(host, DWMCI_STATUS) & DWMCI_BUSY) {
>>   		if (get_timer(start) > timeout) {
>> -			debug("%s: Timeout on data busy\n", __func__);
>> -			return -ETIMEDOUT;
>> +			debug("%s: Timeout on data busy, continue anyway\n", __func__);
>> +			break;
>>   		}
>>   	}
>>   


-- 
Regards,
Yang Xiwen

