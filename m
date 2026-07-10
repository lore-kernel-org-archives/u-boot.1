Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F53C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 09:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E55D184119;
	Fri, 10 Jul 2026 11:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="akIr1qzK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECB26843B6; Fri, 10 Jul 2026 11:28:38 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 693688407E
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gq5bM2kwcIMDg6hYn869FO312KUSUa/1MI15vgSPMP4G5ubHdAtAlWMkf1p5GOLkVrObJ8oZnJwNOcQbBvLozOPkVdPx2FkF1dMVRrehe/jYEiwfyyJX5oS5s3IaaDkT8pYTH9CUAl8qum+kiNV88awDrpAOWwCFZwLWxk1cPfaJhi3xNbPsJiKaxZnGbjGLnuXGtfBN9FCbpIOUeOUP7s6h+rvFUJUBEGLEXwCloUm39WTc3YuIlhtCaveFRpyDxal5HyOVZfrh9q8cH2nTAPgBkq2d7jAuWfsysZ5RwVqfY/dlQnwS0AGW+5bKZlGIsq8jZWGBjL+P4h/awm3PIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n47Vuaie5As94VqdhuL93U6RLYQGyJs4KGddnPTxKBE=;
 b=u9yd3Mb4mAMyL9DkAQknqHh3x79q2LNGA9mD4QYMska+hXhAjv+BK9kZJczAtAgJ2IvVFgcBh9XFTVRsF/GD6QqS7w362F7drAIGFJBLIecpSDbPZsoBf6ohbbYSmTAVDmTOktFI8tj2PI/L8vnVkHbfDQ57j/WDQPJBg0PpBtlwF9zAkOTR3KBtzyuDAohzodRRntNlcb3J3v/a6l/pL4Le42WoWMzTCGGZu96HEyd+yyT5zgY2y7JqWeuRApB5fAauvX6QVIJ6r8VHxTJeJpa7RHD2BRSgUyp1A5PsTV140bQDyf85RjfNP1K5BI20KU7mVWJqZDrEN+QFCGrHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n47Vuaie5As94VqdhuL93U6RLYQGyJs4KGddnPTxKBE=;
 b=akIr1qzKypvpxwodQN1uI66Zu4efmwiGKxgb2nZ6jZDdQzGVqwn9o8DQkhPK1qAVTdJ1pr+z178jC6tCM2BpaaATXHRL8dDn+Aa0ApzbodP/6M7rr24BG903tn4DdLV4iE+pdy2+GOFIEzSlAV7+03owJ7arGHK9Bue8mhBo1LENLigul/pcIumxr5uR48HHiGfzQSBHI9LQ20QwwlHqK0oa8qeJ4gYgF4x9K+7GmRTeLR6ikyKOcM7S6Q/I0nbOoboam6ChfC74nsuMMchDNPYCLEvuzldCVRxyd53TyPHLuLqUe0QgExDKbFZjDVQhHdsfQ0LOA4hitx/mkCzvHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12214.eurprd04.prod.outlook.com
 (2603:10a6:150:336::18) by AS5PR04MB9855.eurprd04.prod.outlook.com
 (2603:10a6:20b:652::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 09:28:33 +0000
Received: from GV2PR04MB12214.eurprd04.prod.outlook.com
 ([fe80::52c:37d:f2c0:797d]) by GV2PR04MB12214.eurprd04.prod.outlook.com
 ([fe80::52c:37d:f2c0:797d%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 09:28:33 +0000
Message-ID: <adfa3625-6870-4bae-919d-f7c9ff6e44fb@oss.nxp.com>
Date: Fri, 10 Jul 2026 17:28:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] usb: ci_udc: verify all dtds are inactive before
 completing request
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, Ye Li <ye.li@nxp.com>,
 lukma@denx.de, u-boot@lists.denx.de
Cc: festevam@gmail.com, peng.fan@nxp.com, uboot-imx@nxp.com,
 xu.yang_2@nxp.com, jason.he_1@nxp.com
References: <20260522075512.1291485-1-ye.li@nxp.com>
 <20260522075512.1291485-3-ye.li@nxp.com> <87fr2mhlxu.fsf@kernel.org>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <87fr2mhlxu.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0027.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::14) To GV2PR04MB12214.eurprd04.prod.outlook.com
 (2603:10a6:150:336::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12214:EE_|AS5PR04MB9855:EE_
X-MS-Office365-Filtering-Correlation-Id: 4992c61e-823e-4fc3-26e3-08dede659c89
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|19092799006|42112799006|4143699003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Mjk/Pgpq09jcgS2D4BTQgnb4sk39OLXiMNV4hy9zBLahFfVVG0xyHrvAeB+SDhBaCHkeir80Tg30kDaaQ+heYmWfSBjeU8hbFo3fxltefFBLXxx0TNSD/d+9dlAocz2BKN5RPp4lx/9kAGDEDtnNOym4aIoznWbvKxmdOvbgxvPXFdT0logdUZfeHix4diZzQA6kSqG1BJBRXOD7lm0l00KcxUdLzRHTzl85URBEWapmf1G2sBbyDJICiR1WGjKwOWWooig+x+zvdEq+5ii1/hbeVA56x93qSb6zmZOS05Rn1FrH9ZnQap2/cmAjM5F024Tta5e1lvYjna3jkIkzkgW4agVKPoLd8lFHLViYofLRo3PHHdCBkqvgbsegomSFP+7f1XMbbbIJW/VQ2J9JxaFbwYDuZLIAQax1H7Kzy9BWPIfAFzVM8ssVfT3wfAVhrfQH5YziXo+4jYhCJO+JVUDJFwbCSTtA+W/kCKjLMNK8xVKiZuXIgoxtc2VPvy0XRRpH5Vut+qK8/jM9DDin8kw6X2p0TYrP1ipwdGlH6D/c9S2tAnAqYC+RJBtkowYgXGt+S/UZZADCbXwPCATvzIPkqx7Rkj9NrsM/TArpsu70wvROk4YF4tvjbfcdlVvacVT9WmYHRoe70TKG3T3aFUtPfJI9UlYTc5TJ+ty2pMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12214.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(19092799006)(42112799006)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXRmWko2QnlBRDR3bjUrSVhPNHFsKzgxdkxoUVBSbUZ5YnUxNURBMVM5Y2Rw?=
 =?utf-8?B?TmRwaXV6U1RhZDNaMndaR0MzaWFzMldYUDFTZkl5U0xLTjgzU0xkaFoxQkI1?=
 =?utf-8?B?TGVrUjJjRCtiaTlWNmhnV216aTltcmJRN3dpUWtQdUhjQkVQbzZSL056V0dS?=
 =?utf-8?B?K1JOa1FTOTlBcXhSSUdkdlhQWFR2a0xLVy9hYitCdm03Z3JkZHdQTW91UW5P?=
 =?utf-8?B?TlJxbktoUEIxbXJmOU1zUSt3c2tabjF3dWxQWXA3SzJRVThZOHpYTEFuVVc1?=
 =?utf-8?B?NWNJWEdudnZUdCtSLzVTd3I5SnNkb01FbFh5clhaSzZBR3lVdTJDdkxaZG95?=
 =?utf-8?B?cFdmMWJ1SmtJeW9rWjlUd2g0MEs0ejdJRGFVU2s3Y2tITDBDeUFoMHlKUm1j?=
 =?utf-8?B?MjFWa29NdzFpTDdXY1lJRVBqelEwYjhhb0txSVpOZ2JvZ2pYQ3pqaVRRRllG?=
 =?utf-8?B?T1lleGc3Q0JPUnl1RVlMSW41WEVFS0dydzlJbmtQMy9wWGlLc2lnbVRuUjYy?=
 =?utf-8?B?RXJ4ZzRoWlZuQWlZN2drZWhLbXBUajFrSm9QNHB4RmpnYWxqaURMZmZvbXBz?=
 =?utf-8?B?cGZqakNWR3VSWWMwUEZ1b3BUclBZRTZZaDRRKzR1VHAyd3lRb3M2Nk1tcmJ3?=
 =?utf-8?B?Qjg2SE5NL1F4c3lJVHJwako2bmdobjNyU20vWnpCczFLRWZvUThJUDliSmd6?=
 =?utf-8?B?MXlEcWRmUlN6MlZCc0Rsc2IrV0oreHRLTStXczZPdUNxeHpDN0NUL2ovUUlm?=
 =?utf-8?B?a1JnOXB1U2lnUkRtR01zZjJ3UERzYVlrSUZjQUNpL2cxcmt2QzNPYnFsb1J0?=
 =?utf-8?B?TzFqZFQvaTlFR3FYQTRFWVdPYURpcE9xM0h5enJ0U3RXSVpiMEdlM3BDSm9q?=
 =?utf-8?B?SWdhcmhFRVJPeWpnaWR0Y2ZEQTAyN05ZNnNMM1U4UUpEbXgvOE9BM3RMMTUz?=
 =?utf-8?B?NHhDNGwrZDJEdjh3ZitGdVFJYjFYUVhFcXNwQ2JlMm51ME5SUDI1SXdMRE5k?=
 =?utf-8?B?UExERlBpZkpSN2xQYUQ5MEVrbzVoVytzb0NqN202QmhwQjlMbUw0VFFoZDkw?=
 =?utf-8?B?eXZJUVdTVW9yQ25mUEE2Z052T21hUGhvMmhSMk5mQ0p4VUo4ZTBSWTJWdDdC?=
 =?utf-8?B?N1A2VmFLU043NHQwVWZWZlZQQ2p6anBUQ2x0YkJIVGYxbzVlK3NsTTYrMTNS?=
 =?utf-8?B?MkN5eGdmMWMyU1ZOMXo1NE10U0EzUnk2NEZLQS9lYWpqckdJSzNNOXc4d1BL?=
 =?utf-8?B?dXRDc0lrR2ZrYU5yK3dJZ052Vm1VaWpPQ0RRLzlzek1ocFRhN2l1aXF4bEdW?=
 =?utf-8?B?V2E4NjhMMVZseUlRTzY0dlZpOHdQNVFTWGRQcFlSVjRkeHpzYTM2a0NFS3JH?=
 =?utf-8?B?cDRIbzJyeE1KWEprRjhWQjg1eUtKQWZFSGhRdWplaTE5eXR2NXZPbG9RVkdT?=
 =?utf-8?B?UEZHL3ZUOWNUa0lTbm8yMmdpRVBCcE1pR1h4YURCR1Iwb0ZjSEtUc0k3c01V?=
 =?utf-8?B?dUJKRHhWaGhFVmljaU5zT0JybnJQc2I4UFJyMEEweWlYTnhDclg1cFdTdVhS?=
 =?utf-8?B?MzR3V09heDNXd25aTGtxT3gvQlgxMkhQWEdVUnpGU0dUek41SU55aGdrbE43?=
 =?utf-8?B?alNEK0ZXYXhweHpUeUFCelVkWHJQYTVZM2JqQ1BuNlFSSytVeGR4MVUrcjlN?=
 =?utf-8?B?UmxBdzJ2OVVPZmdNNlpvVmJUUFhQclNlOFU1VXRaN1lHaVZiemFRbm40aTVu?=
 =?utf-8?B?TlZMTk9HSytOOERxQkkzNlF1aVE3dWI0NXUybkh2SHFpMlhHbm03MTJpWjJ4?=
 =?utf-8?B?TzBCNWF5U1daSTc3YmJSRjBrTHd1OVhPM3U0dFhWTjU5Y2cvS25uMWhZbHFN?=
 =?utf-8?B?WXhoOG4vNlBkSk12b1RoK21rMmRlK2F6VGFUOStvaEF3L1R5ZU5ab3lmYWpZ?=
 =?utf-8?B?TEw2eDZHM2kvbXB5bnJKTWZxMHZaREpybWIrSzNEVk44ZFRzZWQya082TEsr?=
 =?utf-8?B?dmNKUGlVMEd4aGVaRk1aZnV1dnlBSkJpYTBhcXl3bmhZRi8zb1NiaGxzMVhM?=
 =?utf-8?B?TldhUldlTWZrbkEwMVNtZitpOEh3a09mRlNsSXRwVDhjNndGY3JGdDJSTmd3?=
 =?utf-8?B?MGRTZU1RSjJHcCtBWk1qZEtLeFRVSDFEbi9qMlhxc21TK3cyQnRpcGpDeTkw?=
 =?utf-8?B?MDdPUVd0Nk9jZm05Y1dDQTcvZHJFbEM5WGF1bWVTOWZiQjdMWTNQNWg4eXVh?=
 =?utf-8?B?bXYwVElKckNiS2lBMUJ2UElsWU5vWUdpSU5GL2cwdzl1bTdVU1RyVXFVYmZw?=
 =?utf-8?Q?gemv+M9KRHs0/7oP0d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4992c61e-823e-4fc3-26e3-08dede659c89
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12214.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 09:28:33.6301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIZ8YdXl1e6WrczFmxAJbEIrYLTIg/U/5zjwMN049SY61RoUXv/W+lmrDlPaKCR3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9855
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

Hi Mattijs,

On 6/16/2026 5:30 PM, Mattijs Korpershoek wrote:
> Hi Ye,
> 
> Thank you for the patch.
> 
> On Fri, May 22, 2026 at 15:55, Ye Li <ye.li@nxp.com> wrote:
> 
>> From: Jason He <jason.he_1@nxp.com>
>>
>> According to device mode spec, the ACTIVE status field of dtds should
>> be check to determine whether the transfers completed successfully.
>> However, this is not implemented in handle_ep_complete.
>> When two EPs are enabled and transferring, EPa requests with multiple dtds
>> and EPb request with one dtd. Irq is triggred on EPb. The udc_irq handler
>> finds both EPb's and EPa's ENDPTCOMPLETE=1 while not all of EPa's dtds
>> have been completed. Because ACTIVE status is not checked, this case
>> causes crash in ci_udc driver.
>>
>> Signed-off-by: Jason He <jason.he_1@nxp.com>
>> Signed-off-by: Ye Li <ye.li@nxp.com>
>> ---
>>   drivers/usb/gadget/ci_udc.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
>> index 0baad83ef90..53796887dac 100644
>> --- a/drivers/usb/gadget/ci_udc.c
>> +++ b/drivers/usb/gadget/ci_udc.c
>> @@ -733,6 +733,17 @@ static void handle_ep_complete(struct ci_ep *ci_ep)
>>   	ci_invalidate_qtd(num);
>>   	ci_req = list_first_entry(&ci_ep->queue, struct ci_req, queue);
>>   
>> +	/* Check all dtd are completed, otherwise return for next irq process */
>> +	next_td = item;
>> +	for (j = 0; j < ci_req->dtd_count; j++) {
>> +		ci_invalidate_td(next_td);
>> +		if (next_td->info & INFO_ACTIVE)
>> +			return;
>> +		if (j != ci_req->dtd_count - 1)
>> +			next_td = (struct ept_queue_item *)(unsigned long)
>> +				next_td->next;
>> +	}
> 
> A very similar loop (that walks all the dtds) is just below:
> 
>> +
>>   	next_td = item;
>>   	len = 0;
>>   	for (j = 0; j < ci_req->dtd_count; j++) {
> 
> Can't we merge both loops together?
> 
This loop will free each dtd. If the ACTIVE flag is set in the middle of 
loop, previous dtds should NOT be freed since this transfer is not done. 
That's why we add a loop to check ACTIVE prior this loop.

If merge two loops together, another list to temporally record dtds for 
free is needed. Then have to traverse the list to free each one when no 
ACTIVE found. This traversing will add a loop too.

Best regards,
Ye Li

>> -- 
>> 2.37.1

