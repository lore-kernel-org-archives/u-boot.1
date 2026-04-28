Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6565FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 15:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43E0B84150;
	Tue, 28 Apr 2026 17:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fbhctAMv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3814384255; Tue, 28 Apr 2026 17:21:16 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1910D83693
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 17:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FM1Vrcbvdav6dNebexCZCp+MXfcGlXkKuK3hfaQDV4InRWn8xxteFpcuhR7YlNTI9E3LbH/x6tMXjKKRmAxJPTVHLjVrBflFErSnfQ2k1+qA0eZuVcw078pjr7DmZ+fBecpm1nNDYe/xJg0zhUevLdwzDLTrkOavFjUDN4+bKGZDO7nXBgH229/8LHGSY9pX2dVtaMjWafGsWpeCn2HgP2e8ie2Y4aK7XUPisgHWba+mu/qcX33r2pSbR6yr0N2w4HrfxOO6FX2YWlFkvkTAWNiHwTOIVLkEn6fqSRxkcmitSIhigobxkm4MFwXs7YgCodR11YpVT0+Cv9pUuu/xAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAp9RkrrhC81+FoPn35TauQVbVlJ8J1T5ajUKNQzt/c=;
 b=uNa41orGn4cFKyaREoDJQXvoZmSDxEEwP3ovZnbldOMzNn6YetwoG56C04UaClKP3SXRnqKiCqFqdv+bVXblnAsrGgGAzYrIj7MN+6fe2UDSrXOlq6gKvPWDrb7XDSFeu0pXH7LUEpjFjiQR/2FCPlIHZA81FsJ6O7GGR7TL46HboPI9AeV7d+TxeADNoPW8EdHcCuZOmBGjTM3/TEM2+8+id+a2leMVtGVS6DuctPPnCZojLGUPl74C+xznMVfXtLEz4fUsZ7YE+k33beWn+BHaM3MywMDMmYRHdLOHb37GiLLl7XFSFIdfXngv9xuTwcHwzFjjJhIQrrfLSYW99w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAp9RkrrhC81+FoPn35TauQVbVlJ8J1T5ajUKNQzt/c=;
 b=fbhctAMvyHqy3mJzqGdoBigxVxxOGxPKi221tpoaBJiKQd5HOzO/SIAmSqblURr/fU77Y7aImLVUGevFxY6V3J4/zlMco3gdky16TV/kWMUxPPzZtiJnL8ilBibhC/d16EUZMy58lehiQysMAhuB8aoCcchRkZuVeDPJkGCdmONDF/L5fXDirM1z8g/p+pLnQjg2dXMCozODRXFvdxkr+ynbWBge4J55MxKbnU/0ZvtHiD4SWsbb+bSB2eFVJxl+rD/1P2lEVpGP6P6GF58A2ASyRuwi059g8SljLQLbpboD9khwLEWJJkCpgCZajPc+jC4LUs7megdA36uXhVgydQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by VI0PR04MB10256.eurprd04.prod.outlook.com
 (2603:10a6:800:241::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 15:21:11 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 15:21:11 +0000
Message-ID: <18ce19be-c35d-408d-9648-9b08d5433299@oss.nxp.com>
Date: Tue, 28 Apr 2026 23:20:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: imx_lpi2c: Fix MSR status check issue in STOP
To: Heiko Schocher <hs@nabladev.com>, Ye Li <ye.li@nxp.com>,
 festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com
Cc: uboot-imx@nxp.com
References: <20260428085312.1808358-1-ye.li@nxp.com>
 <41960ee3-8645-4d79-0a01-e9642b674a6b@nabladev.com>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <41960ee3-8645-4d79-0a01-e9642b674a6b@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0009.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::19) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|VI0PR04MB10256:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8651ef-f13e-42dd-f6cd-08dea539c76b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|42112799006|19092799006|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: yDOlMLY1AQA7pRdOMGOz9grcfqC3xxcY6ZuFvQ9Eb+s3h8p6oA6N4Xx8p+DofaBPC/Xn8RgqcW5JNyKH1qNJQNfH9OcRfXl/1b7Rp3ydT8/6hmEUZB9DMB9qAEdEhhlyNrS/HBcAJJvYkY8nUr/41TeveDErBlsZ7xxmTQVIehqE1P9xb5BbAEbo2k0ScrxD1M0U5cDkjI6nHP/amkTkAa7h/CDrZIvE5K0Fppf7f+DK26V0/XybAiV1WrmdKF/eQL8HczvmoatQDPl/yJQsxd8f75Ti16xMWBrVMQhDB745+YZ74mx/IB52qaR4DB2COQcllsflyl9Ra4DY2cvISPOQCYtDQjh4h8NUjJi0M0UB+lAJyfNd5lw67T33/9EELdCJFITF4SX0ZsWw4NCiwxrF/Ss3b//WgETpNa3zU0KNiSi0wtQSmJBYRAMTDq+nXEW89K/LWtl617zyh1RkDtVI/ALLjg8tzshZMKig0ITm0rFzZ7JKMPRbzVF0xJlQoBN6z6CwhEGCr8w0IoXVCGhSelH3wQ8cvh9bpyHC6kKZ5CzQ1S0VRcum8D+DWXm8UGGZYz4OYUYS29rkTpj4Jqm5ouwLPWyotul7IMcoRLqPiA8h+yG8M7T9ihoU7ED+G6QqButGXx09gksFXdV9+bnlIr7+/UWYhQyRRFs3ljFxkCaO24TLE6tUQHAWnKyjrKxOs3qp9BPu7TUkjVxwnBYL3iwqlobq+RRPI81SsY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(42112799006)(19092799006)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDJsSDRiamNsT0FkOVMvK3crbWZsNm1DN0hobWNkK1RnTjBkdkhvNEEvb3cw?=
 =?utf-8?B?ZkFTa1ZOZWs4TEdOY1doMWlBb0t5dkxmNTBseHlLMnVLUGhVQjBXQ2MzMFZR?=
 =?utf-8?B?cVpYeEMzL0FYWUd1NktHSFZaUGo4UlB5Wk9SMXNPTGJ6c1d4WlhTOXUvWDlS?=
 =?utf-8?B?QWRLbzdGYzdIeU9jdC9BYXFpSFhLOTZQRDJRaWN6NGxVTGFBS1hDbFhLVlRm?=
 =?utf-8?B?WU9OSE1ZUTU1VU13M2phOXBRTmxwSlExb0ZpQmhoWHlUaC9aM0doMmFkMHVH?=
 =?utf-8?B?SVQ2UVRiMnk4NllGUFJkWHg0S05QbHRsUk45cXBOM0F5L1FNcEFQYUo4by9u?=
 =?utf-8?B?UitvV0xkZis2YmVPR2xSd3ArVS85TFUrWmwrQ09ub2ErTE9UWVhHWmMycklj?=
 =?utf-8?B?dTMrd1JRNGU0UjR4S0E4WTdHN0N4a3VUS211dmsvTitmVmMvSUxvZzhNUTM1?=
 =?utf-8?B?d3NLWVZpeUhUUzF6cHlDYzZoVDMyTEJaN2hwQjBTK3hPR1NRbzlEZFY4MnBJ?=
 =?utf-8?B?V1JGYllhb1N2ZGpuZzh3WnprdWtLRUVzalJvU0l5dDJlbEZUcVcyaUZvUnJ3?=
 =?utf-8?B?ZGdCcXg3QUx2aEtuN09aSFhSSXZzRGJZaHFSemQyZG9uRE03N2kvSzNEUzk4?=
 =?utf-8?B?c2FBZDBxclJVdTRwdDRqZDBxekxMNHkvbkdOYnI0QUh1Rm9rbW1rZ3hLbXJ4?=
 =?utf-8?B?bFgybWJPTzQyMXFoWlo2bFhCNHl0V2NSb3lFNWFadjhIdVNTbUNwQUcwS1dz?=
 =?utf-8?B?SXFUanhDRjdxaU1SaHRTazB2SWhHMkN0VGR6WDVGdVJtcjdXaURLb3VKc1hm?=
 =?utf-8?B?TTByRTRUNFhUOXB6b2xnMlpqY0tyeldEN1ZZUmh0S2VUZ0FOT3YzZU43MDVU?=
 =?utf-8?B?TWNraEZyNDRrbDVUa2laazkvd1NXRW5BOVhsTnoza3JOMENObXZUWnh1ZldJ?=
 =?utf-8?B?Wms5WkNXcm44TG9McVlHOG5CeXZQNnBYWHdqR0FEdVdONU5lYVpWRXVwSkhu?=
 =?utf-8?B?Uzk2S0Q2M1ZqdmhFd2o0d21FamdueFMwWU9BYnBiNFY0MzlDUWNCSDlqY1Rp?=
 =?utf-8?B?SzY3aUM3SUYrS1RLS3lzbFl0R1ZHbkdSQ2wxbEZNcE5RK2NOR2RmTHlBSWxF?=
 =?utf-8?B?L1dUckdnMzFNWmNBRjk4TXpQK3krRTdEeHlnaTZnb2h6aTVBT1RIR01Tbmk3?=
 =?utf-8?B?WVdnTE9mNlpEWUFPOHE3cm8rK3RWSG5zaFhGdktxWlpUZW5WWjVtTXU5b2t1?=
 =?utf-8?B?Y2I1TW10RDNxdlk2WGpReWFtNjFzNmJxMjZoNExBUGxFcGxaRloyeDltMWtH?=
 =?utf-8?B?b0N5OXVIaStCRWZodTBEcU1UcWVtNXR6SWtyTk90Y1pxZUZrVUFqOHBjOW5J?=
 =?utf-8?B?UUZDaGNseGhEY2R6dTRqTmt4OVQ2ekp1bnc0OXAvd09zT2FaZGxQOWZlRGUx?=
 =?utf-8?B?YmwvdnZYLytqTGl0c1kyRVQzSTl6eEhmMlRkaXJpbWRTSHZuRktlemcwcitP?=
 =?utf-8?B?QVkrZzJUWWJ4S0FDSWZacXdJaDlUcDk0Yit0RnppQndXMmIwQ1NIRWZXbmFi?=
 =?utf-8?B?aFozaHF4VzVYNzNUUFFQeVN6TmJCaUhTSU1IUW9OWjlBdHRuV1RSNU5oSm80?=
 =?utf-8?B?TkJWeUdHN1BXYTNpTk1QY3ltNmc2ZVFPenBNWkdLejVPeWNXQTJOQXJjVUxF?=
 =?utf-8?B?SlZJMk00cGladWxLcCt4Q3F3bTJKR2hqMnczaGZGNk8yRFJvOGJ1VE8zbkFa?=
 =?utf-8?B?SGVXV0hhMVJIbEo5VGNLU3VPZUJteElHN3hFeVl4TnJza2t3WnZ4NlRZOUI1?=
 =?utf-8?B?T09DaXJEajFDMmxpM01LMm1ZNy9oWGpobVdMQXV4THphU3BjVTZlV1Q3LzZz?=
 =?utf-8?B?d1lpbWZORjRPQ0dXRGx6MEg4YnhSYlkwUkFMYzhiOEZpbVFqa2tmcGVmVFR3?=
 =?utf-8?B?V2NLcXA1WnI0Vk8zb0ZkNlh4ZWhZWnJIdUhnb3owV0lWbTdYUmZwd2IwdlVs?=
 =?utf-8?B?TElLTXVyV2lEaUg3ODRLdEJwQ1BIZGYzMGczZndiLzd5bUtmZTZINnNFQ0RL?=
 =?utf-8?B?Ti9UZ2dGdStTTHdCSnVvZVhIaCthNGpiTGl4MW1ndkljRG50UmhVQzlIY2Mv?=
 =?utf-8?B?SlN3eUxDaHNLSTRrdVJqSlBvbHJSUDcvU1drTkVzZVNSYUFFaHlucTVTem5r?=
 =?utf-8?B?bm9UWGN6RVd6V1I1MnpRTVNMNWNDQ0E0ZGliWGV5SmFzanE3K2REUWR6T2N1?=
 =?utf-8?B?NDYzYjNza05nc1M4M0VrVThMQ0srbGFrMmtSVGlSQTkvU1JtVk4rQXpTM3dS?=
 =?utf-8?B?Z0NuMWtZY1RKaFNieU00QmdFenFHcnVTSjNMcjJoNWlndzN6eTBvZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8651ef-f13e-42dd-f6cd-08dea539c76b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 15:21:11.3898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWIFMBHYWgUgsJF73Sf2ARjFOvxVQBAB/8pFjAZx3GNeTa79TnfaeXVCnTGOIrxZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10256
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

Hi Heiko,

On 4/28/2026 5:55 PM, Heiko Schocher wrote:
> Hello Ye Li,
> 
> On 28.04.26 10:53, Ye Li wrote:
>> In bus_i2c_stop, the MSR SDF is checked in a loop after stop command
>> is sent. Meanwhile, some error status in MSR is also checked by
>> imx_lpci2c_check_clear_error. But the imx_lpci2c_check_clear_error
>> will clear the MSR.
>>
>> It causes problem in below situation:
>> In current loop, SDF does not set, but error status is found by
>> imx_lpci2c_check_clear_error (for example, NDF), then NDF will be cleared
>> and result has NDF error. However, because SDF does not set in this loop,
>> it goes not next loop. When SDF is set in next loop,
>> imx_lpci2c_check_clear_error is re-executed, but as the MSR is cleared,
>> the result is 0. Then the stop return 0. But it should return NDF error.
>>
>> Signed-off-by: Ye Li <ye.li@nxp.com>
>> ---
>>   drivers/i2c/imx_lpi2c.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
>> index a309fd6f07c..e2b4fd334ec 100644
>> --- a/drivers/i2c/imx_lpi2c.c
>> +++ b/drivers/i2c/imx_lpi2c.c
>> @@ -239,7 +239,6 @@ static int bus_i2c_stop(struct udevice *bus)
>>       start_time = get_timer(0);
>>       while (1) {
>>           status = readl(&regs->msr);
>> -        result = imx_lpci2c_check_clear_error(regs);
> 
> Wouldn;t it be better to evaluate bits in result too, and return
> if error bits found?

I find below commit in history, please take a look. If evaluate bits and 
return, it moves back to previous clock issue.

commit a32effd2838a62a5d1dcc01f613508f1d90b5667
Author: Gao Pan <pandy.gao@nxp.com>
Date:   Sun Jul 8 11:46:41 2018 +0800

     imx: lpi2c: fix clock issue when NACK detected

     For LPI2C IP, NACK is detected by the rising edge of the ninth clock.
     In current uboot driver, once NACK is detected, it will reset and then
     disable LPI2C master. As a result, we can never see the falling edge
     of the ninth clock.

     Signed-off-by: Gao Pan <pandy.gao@nxp.com>
     Signed-off-by: Peng Fan <peng.fan@nxp.com>
     Reviewed-by: Heiko Schocher <hs@denx.de>


Best regards,
Ye Li

> 
>>           /* stop detect flag */
>>           if (status & LPI2C_MSR_SDF_MASK) {
>>               /* clear stop flag */
>> @@ -250,10 +249,13 @@ static int bus_i2c_stop(struct udevice *bus)
>>           if (get_timer(start_time) > LPI2C_NACK_TOUT_MS) {
>>               debug("stop timeout\n");
>> +            result = imx_lpci2c_check_clear_error(regs);
>>               return -ETIMEDOUT;
>>           }
>>       }
>> +    result = imx_lpci2c_check_clear_error(regs);
>> +
>>       return result;
>>   }
>>
> 
> bye,
> Heiko

