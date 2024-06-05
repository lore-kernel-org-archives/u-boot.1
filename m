Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55C7C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 16:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23BD187A09;
	Wed,  5 Jun 2024 18:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PkfrzlZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BADF88300; Wed,  5 Jun 2024 18:01:03 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA41E879F3
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 18:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kS/rBYS6DtDpLtE5dzCjfv3HPbc6xNSRXI47B6twpMXjbvWfi/YqlWzweohqWGAqqK8ZZ7KyXRmTBKGyX2L8O4EoiiXF1vqkegxVrb1AcggkivQxQaqAaetQ54hr29CzMpPGMQhYv6zLEjkngFezBSltTYfTkSA7IUDwWnM4ijAW3xvmBzAihMUnmy/3nLIX0SzyG8sUcNmBpQsNOFB2QGKgtHMOXozBPVS+iyLOL4/MXNVV9xo7csos9lwifB0huxseqrAVP2VEel7pTIRTEywLHZt6yW+6i5KlLGNOPdDgm3Nxn0zMR3PFvuko9KC8nsmQSyqZ8lmlpILezgypMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyY+4kh/p0fsFfUx4wkXWfwh6rK/M8LHWkC8QJYv2H4=;
 b=jHy6WJW97YugImwr7ew+8icxpY+CF3fpG7G7eqWFYAtYZIGcsDpBZBelaKlfzEk+6AZHYBArNfjWhDVTe6eBDukzu/RvfwaFqOFgUpv9GeNphaIZrZ4+6nIFUDpmoYW78mL5OmfkLQGo7C/YPtzjMss91gxSmVwFpT6QIBlhpyvouHt6Tr2xgo070AHDfalbp7N/VbBSEe66kcs44++yhCk8aSjmIaO2+cNJ+zo7cHaVgTJYkpO/dABwZ1ROBdyN+Uua+vkUmCANun/xYqDJ1YPIppshUbzIG9YnoaEMAZdsieBTgmPrl5XsHho5im+zFo7CE7lXQ5yKWZ7Zb56qvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyY+4kh/p0fsFfUx4wkXWfwh6rK/M8LHWkC8QJYv2H4=;
 b=PkfrzlZJm5gaML+9ofrz9xEcrPPsNB/0wVHj0y+4B+skxPH/eNjCuwgWFQ/ycelscjYDfDIxTMGQZ6jKT/FN1CiEYzjG7llWQQrv3RropqXGXeBAiNN/vkRJaHHkDlIT4w6C27jQZa5oGXuQyX4kYEvzNtIwJipAQj+CeJCd/yA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PR3PR04MB7275.eurprd04.prod.outlook.com (2603:10a6:102:8d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 16:00:59 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 16:00:58 +0000
Message-ID: <baa5c005-8dd2-4015-88b3-3d974be51744@cherry.de>
Date: Wed, 5 Jun 2024 18:00:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] rockchip: rk8xx: fix broken [np]ldo callbacks
To: Anand Moon <linux.amoon@gmail.com>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20240605-pmic-rk8xx-v1-0-2349fdf68aa0@cherry.de>
 <CANAwSgQR1pWEvUaf-moLK4bF=o7gBUp2KzbWDk8-D7xkZEXFNA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CANAwSgQR1pWEvUaf-moLK4bF=o7gBUp2KzbWDk8-D7xkZEXFNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0043.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::28) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PR3PR04MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 31be52b2-b4da-49e6-2571-08dc8578b07d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmxVUkFCcnVPSitSVlNnNG5GQ3lsbHdEUXRrRVVoMWF1T1NVU2FkWkdzRWw5?=
 =?utf-8?B?a0FkRnRuQXpWSFlkOUV6MVlWenE0VjdMaS9hT3FpT3hNN3p4VDI1VERtNmN5?=
 =?utf-8?B?RFVZSTJWd3VQTnQ5bUwwdHdmK2JraTdIallyd1JYYXAzbWFya3kwcjdQWGhH?=
 =?utf-8?B?VGorVUl3Nlo5NUJBd3gwZDY4Q3ZjRzlzS0U3MUhtc1d3T3JoT3orM1JwaElZ?=
 =?utf-8?B?cDJoQ1YvRjBIVWtlMm04N2c3UVlFYmJ0bENRZXhoM3RHMmRsaVoyUllVRUt0?=
 =?utf-8?B?Nk0zR08yMStBQkU2cVhrV2RNRWJTRWtLbUhLNGNPNDdjZVBWY3l0aWF6bkNi?=
 =?utf-8?B?ODFKOXVWRVZtbEtES1M0bzhzOVRmUnpvd0hNeGhlcllBalZOZ1lONUtLRGVM?=
 =?utf-8?B?eTQ3UzRxeXJHUnlqZmZ0N2E5NWxqeHBUSHp3U05sd0l0b2VUQkxLRTNqNm9t?=
 =?utf-8?B?OStTSFQ5S2VkMGs1cFhSTVkrU05BOUs5c3g0ZjdJK2Yybnoxa2QxdzRLM2FU?=
 =?utf-8?B?N09YR2RkbWRqMm9KYXlTUWtsKytpaGtLNEs5Q0J5bFloTUQ2VXZOVkZyalRC?=
 =?utf-8?B?RzhvakEwTjVmM2pEUnQzRVRQSkg5N1l2cnJnZWk1SEhlWGtjQ1M5Q29SSVBP?=
 =?utf-8?B?TGJCQjdUTnFac1F1dDJlckNOd3JLZkJCalVKYzNrYjZ6UVh5c1VZanpyUHRt?=
 =?utf-8?B?QnZIS01Bam1aK1UyRmlES3RqUS9SMHo4cmtxL0FMUzl4YWNIaEVqcUFpelUw?=
 =?utf-8?B?Qm9VcUxOY2ZQak5UcEtoQkRjSk15bHlrbkpaWjdpL2p1eEorQmV1TFR6ZU16?=
 =?utf-8?B?aUxILy81a0xsU3NUc2NPeDBLYzIwMVpDSDFnb3ROOEF6TTF1dk53RldwcXkx?=
 =?utf-8?B?OFVrdmhlSTNxVHg1QmVFYmtlMzZLdW4vQkFtMkR2cjQ4OHk1cUhQQklzbnZz?=
 =?utf-8?B?NVJybFpwM3B4SnZyOGMwUWxPa0FJM2JDU3ZNZmVBbndqcEpwV1ArU3ZXa0VW?=
 =?utf-8?B?c0Z0WG9QMmpCRHVlTWNQMGxBMEYyMnc1TS8xdlBSdnh3M3YzWktscy9WcnZZ?=
 =?utf-8?B?ei9RU1F3ZWVleEJXdFY4SUpUOFljdXJtMlFJcHlMbnZwYmlsZ1NTaVcxVmxC?=
 =?utf-8?B?TXpXbnI1d1VOVUlBc2g0QWJ4WmladUl5blFCdkZyb1VnTzR2VzZwYWVtNUNo?=
 =?utf-8?B?NExaeTNqZlVSbVNuR0hqVWt2cGwxOGJ3NC9URE9pY2tNU2JyeUpMc3ZYZWxo?=
 =?utf-8?B?cHQwMEYvTlVzTnZHVnpOVGhlbW1IaUIyNFJob1Z2bzIyVnhOMXh4U3FPQ2V2?=
 =?utf-8?B?dnhzOTBTKytxcGJqb1NVTWJhMnpoaTZWTkxuWnppOWpqTEFyNkFXRGVYcWdQ?=
 =?utf-8?B?MkJacFdZRlMzbGh2R3N4TGNrcGtQeTlCOVBYYUF3engrMHF3Vllrem1FNlI0?=
 =?utf-8?B?a3Q5SUVtYVdYRkVOV2NJRGVuQ3NxOEtBTEFJWld0K3kxbE9vSFk1Vk85ekJy?=
 =?utf-8?B?dzFXbmdRaUhyL08vTnE2VlV6b2M4dXBRQmF0dm0xclh4S0NIeC9aN05EYXla?=
 =?utf-8?B?L2hWMytwSkI2RUFrYmJ5c1dsaU1sNDVHWmtpWWFNYzU0RVFTS2taa2FHdFN3?=
 =?utf-8?B?cXB4N0lUZ2JsNW5wUlhRMVNwUzkxMkFiZXZacm4yYUFvZC90SURtNDJBajR1?=
 =?utf-8?B?d1NWK0FLc2lwTWZWMGRONFE3TERsaTFDaVZyRzNiazZ5NmlMVFlTMUJIblpZ?=
 =?utf-8?Q?TuYqBTRQs/Akmhm5WQEISIDyf666/O5gd8v0kL3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkNBSnBsQm1FTGd2bGQ0VWhCb2JHSm4wYlpxQW5EWXdtTEYwME00Z3NRNXBX?=
 =?utf-8?B?R3hIQlhNQ0doKzlJcm9sNmFJRzFDbURQbXcyb0Vab2M0b3R0TUlkMTlpRUg1?=
 =?utf-8?B?ZWQwUW9WbGsvOWFFV1FkOWkrS2dnT1NPc3JtOHdkUktVUHcrOEhyend3bjJI?=
 =?utf-8?B?MGNpWUE3U05rSkN1Y3BzTTFXeWt4YUt0WGtCT0hGMUxyckQ4WC9YRElFVzNw?=
 =?utf-8?B?S3ZYc3o5d2dhbEVoNFp3Zmw0NnhCencxb0ZFOXlLUDllVkxhalVFWjhZMlVp?=
 =?utf-8?B?a0xxSHhUdFVtVmN5YjlNNWZqVTZOMzRsdzB4bFNIMzNueWFqV2p1UXRhdmg1?=
 =?utf-8?B?RndlYWZNdk16c1Z4cjF6Kzd5TW1mWDVnNkpobUdGS2JQMEp6ZXJwUFE3U3NF?=
 =?utf-8?B?amFBMldaNVU0U2dBemw2VXJHVEQ5SmhEU04veFVjWi9EcHJ0amJjRS91Y2Ja?=
 =?utf-8?B?L08wMXAyZURqdVZnSVBIMEtGUVpPZThoOU5seGpBajhmWm1yTE1ULzZCZ0Jh?=
 =?utf-8?B?VkRLdjUrNW5BTkNqb0pNcTRzMkY1YUl3MFhwNUlkUnVaSVI0bm5Gem1MRjgw?=
 =?utf-8?B?dml5QjMrMEJsT1VpQVNKall6TnJkUS9zY3VyV1gvdVZMQ3NOU0dvbW1zNWpK?=
 =?utf-8?B?WVBUNTJEcHJCTE5LbU5yQzBhamZKOEFHMGZRTUVncGltTlhVVVp2dkUzT1dN?=
 =?utf-8?B?UGtWOEwvdjVnb0ZRSFZUMjZKa2NFc09PVGliS25QRGNDVjlLK05xdTVBNDJ5?=
 =?utf-8?B?dHMxZ3IrY3d2U1BEMG1TQm9xZ1FqV01MZGNQcWV6NmdEbmxlRi9odnRPc0h3?=
 =?utf-8?B?RDAwZnZRaDZQLzZHQ241N0x5OUJsdHAzb0cwNmtoa2g3RXpGUFY0N2IzQXc0?=
 =?utf-8?B?TVNWVnlKMjNsYU1EQkZSa2ZQT2xOT1dGM0NqRTc1U2VJRnVEbVpadUdNeGJJ?=
 =?utf-8?B?a1pTeVQyT1RZTHNkcXVEYlVxSDd4Y2xJNFNrTCtrR0x2QkZrdWdJZFY4QXFy?=
 =?utf-8?B?eTgxeUpvRjIwY0FSVVJZdjBCbU5qQ1MwREhZOVNrWFBxclJoT0ZXSXJYUGFJ?=
 =?utf-8?B?NmoxbVNESzR4d0syV25yTXVMNFlBWnBuSjY1a2FML1NYY2k3WFZJb1gvcEJs?=
 =?utf-8?B?QzIvTzhnUCtpRlVNemIwdnUwK1lyL2FwR1Z3OHBIYkhWZUlGeVViRHMxNlBO?=
 =?utf-8?B?L3I3eGV5SFpEaGQ5R1Era1F1Y3RzYzRQb0IwWDlSNWs5SVVvbTlpNHRtdit6?=
 =?utf-8?B?MzZYdnphQzdFM1ZvdFNZQnp5STJjNlB1a3RwVXJjOVlOOWVmNEVjdlVGb0NW?=
 =?utf-8?B?QkJqT1hrVVo0eno0L1p1UXlzUHJvdDBqcTZ6TExJTU9VVDlyWFcydWNGODM1?=
 =?utf-8?B?QjhDTDZCNk1Wc0MvcHU5ZjVTWDdlYktucHl1d1dYRVZTSWpCZWYwZzdjQ0pa?=
 =?utf-8?B?NW95VENhMlhwZnM0a3FhL1RDZzUvSmhLNDhSNkJSeFpuTThKMkc1YmEyR0pY?=
 =?utf-8?B?RENoNlBtRWRzdVVpYXdVRWg3L2N5RklEdTcrWk03ZzNiWWlzcmFPSi9LeXNC?=
 =?utf-8?B?eHBkKzJRY1owV3RDZUxwQVY4RFdxaWoxSnJBMlp4Z3NRSDE3dWw5Vk1seXkx?=
 =?utf-8?B?MXUvZzZnVVdBUG9vRkkrMGk4TFQ2Y2JpL2R1b0cvUDBnZXJPWVQrMnpiZGxx?=
 =?utf-8?B?ZXhWd2IrY3kxV3RuNGt3UW80VnBBREFHcGhNdlBqNzIza1JaUWZLcGo3T25y?=
 =?utf-8?B?QTNqMkVTQkIyVEVpaVZ3MFlTcGlTTEtaZ0dYQkpqMFlMeFV2emJhL0xNQXgw?=
 =?utf-8?B?eXdtTkxIb0RDSTJsU3hIbm1ZSlRxZDRGcXlVa3VFb3hub0NaWGg4d1VuUlJt?=
 =?utf-8?B?OTFhdFdiMEl2ZFkvY2ZZOFdteldnUW8wU2FlSGU3UTk2SWE4ZHd3M2dOdU5h?=
 =?utf-8?B?ZXlDc1dPTWpxZGtONHlqVEVHenA4TC9YTW82RTlRVWhpTVR6bzJSbnBRZ01Y?=
 =?utf-8?B?amc4RCtkMyt4dC9rSnJGbGVCcythK3VYRjdqSEpnR0wrQVZVVnorZTdPU1hS?=
 =?utf-8?B?ak1FcUw4Y2xWTW1OM3RrajZrZldFdU9qZjVTWDNnbzhqQ1VFbkVRYzQ2TVhm?=
 =?utf-8?B?clhkYndLNjlBTkI2QVgvN2ZiQ0FqZjR0c1NhWXNWSVJjSEZGalRWSjB3ZXkr?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 31be52b2-b4da-49e6-2571-08dc8578b07d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 16:00:58.8170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETbCWEBUCQvZcUYQqZDpzq372ChOrUxLufDynublKoWXk+6gLXddGTic0h/pxg7Ow99xY9+bDM99SRI5B2kKZoPUWLuhnVYEi5RM1dGxQ1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7275
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

Hi Anand,

On 6/5/24 3:11 PM, Anand Moon wrote:
> Hi Quentin,
> 
> On Wed, 5 Jun 2024 at 15:03, Quentin Schulz <foss+uboot@0leil.net> wrote:
>>
>> This is for master branch, merge ASAP as it's known to break at least
>> Chromebook Jerry.
>>
>> @Simon, can you please check that this fixes your CB?
>>
>> The wrong udevice was passed to the functions, making them call the
>> pmic callbacks on the parent of the pmic udevice instead of the pmic
>> udevice itself.
>>
>> While at it, ensure consistency by having all internal functions use
>> pmic udevice instead of the regulator udevice.
>>
>> Finally, clarify operator precedence in ternary condition as reported by
>> my linter.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> I see we have not been able to follow configs on a few of the board's for RK3588
> 
> CONFIG_CMD_REGULATOR=y
> CONFIG_PMIC_RK8XX=y
> CONFIG_REGULATOR_RK8XX=y
> 
> could you enable the options with imply for all the rockchip boards?
> 

This patch series is a bug fix (ok, plus some cosmetic stuff) for master 
before the next release in July, the suggested change is not a bug fix 
so feel free to send a patch for the next branch instead :)

I'm personally not too keen in adding a lot of "imply" but I am no 
authority there, so whatever the maintainer(s) prefer :)

Thanks,
Quentin
