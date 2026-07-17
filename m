Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B0CC4450F
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 05:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94D8684D8E;
	Fri, 17 Jul 2026 07:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uzyi7q5S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AC7F84D9C; Fri, 17 Jul 2026 07:18:55 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2858484D85
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 07:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qijian.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/wHn+blLTxkYeA5ex3/88BPNl2U7iy1jEUz5CogBS/0A4ArNXUyobtvYNnqIgXkd5Cb0z4o1nG+ZDpdJa4dWUfm6BDj0znHkaWKmvA883vDO7qzQ5iPXh7cfdRtf/KQvKpijkmpHrLKma6ZhOfDAdzC3N/kHTvIOScdcsH1VicUDtHNXhO+ozJ3JeCGsOKo8IU1erGX2UgoBNYCsMad0c9rtevF52s+iquN+dHmpr6m3mKYE0dt74aRP1JScxB7zGkBr64KozJJtnaMu6lS2GJzTfwy0Ecw1zSkksONzuaeXwdF5RnU36uEl2ZskbJBaKi//mYB0pxydUbhkw4ihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3pPQJjEV3esh91frZFxv7APMqX9eoNrSGa7ePgdf/Q=;
 b=W1T9aHpj39ZZJQQK6ibwaK5ARR9ex96LTOGce/p8ztg5wSTv/pd/PghNYwrigQGPyAgvAykOPLblpPHrr7YaLShXO0JAMepv6BCIIDphZu4B1KBUQrDMjTjXXNhIC/fsi63pNmxhhUa3HthDJUe/ovXgQBVm199ITv11eUmni3quvgCDnx/NA9Q1vp2w26ufP5Cq9JPU7mfNxw9X/jwA/5/mtlLBnPm/14ztUuROCGoQJ+zEs0LVFMvovDolglgjnuHv3QVVr+z+KhAYctDf6aQFhFPrFMJuP2PBeAIl0AUMV8viYuc+rTdGiX2yMnADArzzRtxQvHOHVSVbW1ACrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3pPQJjEV3esh91frZFxv7APMqX9eoNrSGa7ePgdf/Q=;
 b=uzyi7q5SzqWb+cgCqLuHdnUtTiACpg1RzrEf8a2/Gu3aJ6975RDb0Qsqtsi/N0AGgpHZ8qwcMQmf4yIXn+VK91YnIoOHKKB6u83ItfDyyAd9/1CTHUAbJYg4ZPxopgu5gveKSBbdDhP7GO3Ud3a5MUVMCO1bpX7lXENGUhMox+TX8CUTin8WrkyUnkga8QkhHufpjcF3aSZENbd64MuoavyJSfcoRN9ti+AH72aRHl3x9WmN/xFcHpD77FwzBD6B/SFNi9i8I+uz/sjzvNtO/RZ91FbtU8aXkzZ0XVh9hA9PrVB/8S6P68O5Hu6qccRS8rS11D/eZpl5zD2dkHOjwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com (2603:10a6:501:97::14)
 by AM8PR04MB7746.eurprd04.prod.outlook.com (2603:10a6:20b:235::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 05:18:50 +0000
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43]) by MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43%4]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 05:18:50 +0000
Message-ID: <7e290ff6-0e97-4c9e-b82b-7425904efb8a@oss.nxp.com>
Date: Fri, 17 Jul 2026 13:18:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: image-fdt: downgrade -EINVAL reservation failure to
 debug
To: Jonas Karlman <jonas@kwiboo.se>, Joseph Guo <qijian.guo@nxp.com>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Randolph Sapp <rs@ti.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260713-downgrade-v1-1-183a2300741b@nxp.com>
 <e1a26574-4f7d-46f0-b757-55f419df326b@gmail.com>
 <d170674c-360e-400c-b263-a35aab640d71@kwiboo.se>
Content-Language: en-US
From: "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>
In-Reply-To: <d170674c-360e-400c-b263-a35aab640d71@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0220.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::12) To MRWPR04MB12117.eurprd04.prod.outlook.com
 (2603:10a6:501:97::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12117:EE_|AM8PR04MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 61759fe2-e731-46e5-146b-08dee3c2e2e9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|19092799006|1800799024|376014|18002099003|22082099003|3023799007|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: B8kUjJGF8Fv6w9tJH2G2qte/bPAVXmWuF8a4owErMFnWbh1T5BrbLnbIwvF1mqNyjN9CpR0NbSGU3BlqHzF9jgdFz6t3kcd7/g6kUhW/sf9hkNC4lH9V3KnKZyM6q7xCTX3396VJgZTf362z1JPlNgQAAsBU7OjfhNiFbLV/xjyynHXeUUGonlAtBA1nvDH/IdJHYXO7+DgM2EAe3vVjd7gyhXEdLRnLqQj+ZvxUVyHpSTSB2kyeRZEZ9CTdfdTcPYe/WkLOv/OhzWbZNTXAQm7aoku+7EZX2C4sDgkeKQq5QtIGgVPnV9k6gJFe1TfFk+BYvxM5sqonLqTk5Y+HbuFOwpcBETvDq8oSlH2/cH2SqiKxrafC2JecCJqZ32X6K9dGTa0zcyUv18kMUQevcXWI01h06RwoJPieAA4yl7zQOXLaVP7Es9xtDosUd53XKDAAqG0EXczdLNQZe/9oJGXfLF0ljOtxSQBzN7NVixyKEgR9KeSOn3ZUZ4Tr5c9b6crxRbf5quoN5jRLH0hWSAXDN+DEZiHITubRxKqZ+AqbOBlHLPmgg6EH5oNQfBnbx9RzaVbPMD5IZiiykDaJMhkGeA7eS4qVpApPvvJx7kbo6Ab7iwEsA1BNKDLeZFuw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12117.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(19092799006)(1800799024)(376014)(18002099003)(22082099003)(3023799007)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bi9taGFpY3ZaS0pQbzRMYncrVkFnY2NEWFhkVEx5UEJuSHdWaTRXdXY4aFBS?=
 =?utf-8?B?Ums5LzV1MHo3NE1RTU41QjBnb2FMa2FyTGp6aDB4dWkzcmN0TE5tQ1gxbGpw?=
 =?utf-8?B?UGJyUTV4bG9YeDE5NXhpTXJwWENMcVhhQTNhaHZFanVtSytlNHBtcFRrUjBE?=
 =?utf-8?B?NFV0S3lPNmU1UDdWdHh4eVIramh4OEh0a3poQlhYSFhyUnUxUW9PcGY3QTYx?=
 =?utf-8?B?QUZHTFBTTDdPNURUOFpCYy9jdWdXdTBTdXVKNVlSQi96UEZKUzZ3L0ZZZmNy?=
 =?utf-8?B?Q3FUUlhBdWlYaDlFazkydGdZWTRlSUFnWnZva29GTDVBMm9GdzcvaHFLcXhU?=
 =?utf-8?B?N1VyYTVlam1SeDBFYmFFSnZ2NE4zVlJGb3U1cVQxN0ZNeVp5SnBOaDlLQVpn?=
 =?utf-8?B?eTFPZkRJUUJNbmoxYlZDTFZNM2hQWW9ueWpnOVVCbWkyOWt2dng5bTA3L1Qw?=
 =?utf-8?B?M1o1aE40M2tlbEt0UTBHZEhSWS9XOXVCWk55eFAxOHYzYWJLWlVOdlppRXdt?=
 =?utf-8?B?RmtsVE5MSktEdjkza0tuREZhVmYzWEJ2cWh6b1dXRE1WS3dybm5nMVVMRWZY?=
 =?utf-8?B?bWZMenN0RW5DQ2RGV0dpa2M5RGhxbk5nc0lHMEg3V3lBNXozRlhtNG9nSloy?=
 =?utf-8?B?SkkydU1PMU9IRUVWWE9BV3B0TExNOGVtamt3a3FNNG1ncXF0cncwVTdLTGZJ?=
 =?utf-8?B?Rk5Hc2pvdUtEU1hjNlYvaTROZVF1c0t3R3RWcG5SZmZkeGRFVlJ0S2VTL052?=
 =?utf-8?B?WVNMSlBFRWo1UmY4aWpkM2x0cmdiVXFtWEdVaisreW9CSVlRMjBwVk03NkN0?=
 =?utf-8?B?TUZXL3ZqSEJwS3NaUlVxcU9CRmtFL1JFZFdCbHhMWTNqV1AxV1hyczl5dUhs?=
 =?utf-8?B?Rnc0VXFFeHZieUZwZ3J4L3VuL01JVFJiS202WWs4QWJVclVzaWFYL1VjM202?=
 =?utf-8?B?ckRlTC9BMFdjSWcvamhab2ZOZUtWQ1VTNGRIKzJZVENQL003Umx1VnNQeGtu?=
 =?utf-8?B?ZFVDeWZ6enlMOWkvZExBL3VEQWhST2FYdDk0d3l1emF2eGV2UVNoSUE5MnNJ?=
 =?utf-8?B?OXlvVjk5ZkFCVGVrc2hSK1AzeW1rY2IvU3ovMEZYcTkzd2E0Q2pPTmJmUkFl?=
 =?utf-8?B?RklSMCs2bXM5RXhUWlVjN2NzYnQ1dDRRVWhIdTBQRHBMcms4SlBjbDJ5NFV0?=
 =?utf-8?B?cjcvQ08wMmRRU0RWblIxUTg3MS9YUUMyc2dtOXZmZkVjUDB4MFdMQjJrN1Jr?=
 =?utf-8?B?d3drSC80V2s0SmF0SWpVSWlRa0JUeWJIcFowUWhxdDBnaG15Q1NQOUVOQzg3?=
 =?utf-8?B?U0ppV0tEOXk0cWx4VlNLTjJtNEloWUdMVXdSR3lnNEx2dXNOeWcrQnRqaGRz?=
 =?utf-8?B?ZzNPTHNHalpNMjNjaWM3cTZQbDZkcmREL3dZV0FWTVRlU2ZhTVI2YU5UYnFn?=
 =?utf-8?B?UFhVYTlaelRXVzBWUlFVL1hoWmxRUFRDVWF0cDE1NHhyT1JHcmlrMitVWXRK?=
 =?utf-8?B?bi9ScXpHVFlsd213c0VoTWlVK0FXQ0pKV0lobTVSNXNaS2hHWWRHSVlqTThT?=
 =?utf-8?B?TUxpR3kwNllhOFh0RTRLU0Z6NEREaU5kT3lsRXA2U2hWR2VtWEN1dG1lbUVy?=
 =?utf-8?B?TnUxOVZXV3c4NzBzeXE1WnRWSVM0L2RUc1BnT2dBdTFqcS9pS2tCRUNPVUdS?=
 =?utf-8?B?c1hZRkl5dEYwbDUzdFArV0tWOEM4czd5WE1FbjVVb0R3OFVWQlJ1SU5GOTNJ?=
 =?utf-8?B?bFNMZzhHaXVwVDJCUk5kZ0JaNVEzbkdLTEIxMEwvSHppajVrN0E1ek1pVC9Q?=
 =?utf-8?B?bUJNMWI5TDZkdFNRTUZNWFB3SEhJRnMyNUI5K2FoUFF1c2V2dFpLK0VFdVlu?=
 =?utf-8?B?RnFsSU5iV0pBblVEZW5IZUFVTGtFWWF0dm1tTzZtUzhFODNUVmtXbUZwOFUr?=
 =?utf-8?B?alUxQ29sQWJYc1FKQ0dpMFVkb3FNQWMvcVdDM00yeHV2UlJQclptL1dwR2lR?=
 =?utf-8?B?c3kwTmxhSmc2TGF4RHl0SGJqWW90aGRKVG1sbnBWVk1ac0xXT1dKelAwTi8v?=
 =?utf-8?B?MXFOMVByLzNwL2MxeDZFODF1ajAraUlCT1pUYWRiSlIvcWNmRUZjZUxKRHRO?=
 =?utf-8?B?aVBiZkhnVTVVVTdlMlk5eTAwbW1YVTNDb0VMY092WS8xZkVsanBXeDNzcGtI?=
 =?utf-8?B?R0U4SHQzRHlCOEpMVnhzSVB0U3NFWHJzMVZVNWR3NTkyMHdYUUNyVzdROGFL?=
 =?utf-8?B?TnZGc1VsNXg5V2tvNzZpcnU2Z2gyTWxpYXRWN0hnQ0JTZTFjZG85THBnKzF5?=
 =?utf-8?B?TXU3cTlrWExDTldSa1grb01hWXVpLzNVVGNhRTR2dU9rZTZwVjVBdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61759fe2-e731-46e5-146b-08dee3c2e2e9
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12117.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 05:18:50.5382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2pL9uLMmD6Pw7esj/Gtthb7UXt+qVVimei6Lhb/awlBPvoKiAxHhFsg/4s58kk9sUTvpZ/cyKIvFD1Zgd4Lxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7746
X-Mailman-Approved-At: Fri, 17 Jul 2026 07:41:15 +0200
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

On 7/16/2026 7:55 PM, Jonas Karlman wrote:
> [You don't often get email from jonas@kwiboo.se. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Joseph and Emanuele,
> 
> On 7/16/2026 10:25 AM, Emanuele Ghidoli wrote:
>>
>>
>> On 7/13/26 10:45, Joseph Guo wrote:
>>> When boot_fdt_handle_region() attempts to reserve a DTS reserved-memory
>>> region via lmb_alloc_mem(), it may receive -EINVAL if the region's
>>> physical address falls outside the LMB-managed memory range (i.e.
>>> below PHYS_SDRAM on platforms where U-Boot does not manage the lower
>>> DRAM window).
>>>
>>> A typical example is platforms like i.MX95 where PHYS_SDRAM starts at
>>> 0x90000000, but remoteproc/rpmsg carveouts (vdev vrings, vdev buffer,
>>> resource table) are placed at 0x88xxxxxx by hardware convention. Those
>>> addresses are unreachable by U-Boot's allocator anyway, so failing to
>>> mark them reserved has no practical consequence -- U-Boot will never
>>> accidentally place the initrd or FDT blob there.
>>>
>>> Printing ERROR for a condition that is harmless and expected on many
>>> platforms is misleading. Downgrade the -EINVAL case to debug() to
>>> suppress the spurious output while preserving full visibility under
>>> DEBUG/log builds.
>>>
>>> Real failures (e.g. -EEXIST from an overlapping reservation) continue
>>> to be reported as ERROR.
> 
> I sent a similar patch 2-3 weeks ago [1], and was planning to send a v2
> that also change lmb_free() to return -EINVAL to also catch the free
> scenario.
> 
> [1] https://patch.msgid.link/20260627204851.1151419-1-jonas@kwiboo.se/
> 
> Regards,
> Jonas
> 

Hi Jonas,

Thanks for your information. This patch can be dropped in that case.

Regards,
Joseph>>>
>>> Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
>>> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
>>> ---
>>>  boot/image-fdt.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>>> index 9e0e0f93edd34ae9056926883b1a802858e179d9..2175fa338f55110862100fa9f491a0957e85ce56 100644
>>> --- a/boot/image-fdt.c
>>> +++ b/boot/image-fdt.c
>>> @@ -95,6 +95,9 @@ static void boot_fdt_handle_region(u64 addr, u64 size, u32 flags, bool free)
>>>              debug("   %s fdt memory region: addr=%llx size=%llx flags=%x\n",
>>>                    free ? "freed" : "reserved", (unsigned long long)addr,
>>>                    (unsigned long long)size, flags);
>>> +    } else if (ret == -EINVAL) {
>>> +            debug("   skipping fdt memory region outside LMB range (addr=%llx size=%llx flags=%x)\n",
>>> +                  (unsigned long long)addr, (unsigned long long)size, flags);
>>>      } else {
>>>              printf("ERROR: %s fdt memory region failed (addr=%llx size=%llx flags=%x): %ld\n",
>>>                     free ? "freeing" : "reserving", (unsigned long long)addr,
>>>
>>> ---
>>> base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
>>> change-id: 20260713-downgrade-f8319ab2d75b
>>>
>>> Best regards,
>>
>> Hi Joseph,
>>
>> Tested on Toradex Aquila iMX95, which has reserved-memory regions for
>> the Cortex-M7 (vrings, vdev buffer, resource table) below PHYS_SDRAM.
>> The spurious ERROR messages are gone and boot is unaffected.
>>
>> Kind regards,
>> Emanuele
>>
>> Tested-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
