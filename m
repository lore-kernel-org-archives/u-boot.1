Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0213E6895E
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 09:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29E958928C;
	Thu, 31 Oct 2024 10:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vdJMEl5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E32F89241; Thu, 31 Oct 2024 10:04:53 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E0F78928E
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 10:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zbr+zt1jY5Rs/L4RvYZ5GA9WYyxHSZQdthegDpbdzYLkQRojj7gIcph8npB6bAs6ezey+Q8SNUhH0u7p6nZy3duyn4BOVDMbHt7wn/tlgwIE+6ZeS7ZXTUb5nYUDQXL3QRMjga84pOdMhm7mVOTSc3GA+sNV154EKa04J+Bid8/kfNoi7SDyQl5olFzQKXrJa7yuCoLfDK8CH0MfRADEooVcV5bMSbMNGRqF2G+f5J67gvXipsB/aSxIF0ZoVzeXMBwD1uHkizeKcrZ2acr9LWwbALTXJCWwKdxk9FVgnqpL/P39rbagybOfdLI8Ac32TCUFsqdO0VTA1W2KZtPd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BctyXhVEZQ87P1W2F9KaVuw7mJNXVT/yteZuPWPqvck=;
 b=o08jyDS4hsCv8X02581iV9eg6J592VbnwubBN5RXim12516KSf5XivoK8OSBl+49BbvS3g2hiI5DDcwfeb+vNXg/Kux8JibBK2cLE8b0OHS5i/RjTV6xLqx3kYHhLekQAMWLXG53XB9T+kKJJkjRc9vrEBQp50Zadpsyr8XKNOBGKOPDRnmoC1kJnJ7nvRBNTRwb3SQ65DQ7fAUqq/xISEmmizI8La97hjXN5ymG3QQcegX/cthFPnH0kMWR+l3sQlCrwCxcuft7ih8QFrk0xpW+exWtGaSU32H4YcLuFhDqZat3xeZ0DfX0ok5QBfX0Dq4rodkrR+o8iiqsuyHyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BctyXhVEZQ87P1W2F9KaVuw7mJNXVT/yteZuPWPqvck=;
 b=vdJMEl5Qa3MDZSw6LL1B0s9RvSzK/atwfiabeTZINxUxqO1PpVjg8BbkjklPUHxh87P4ioRdokTF9ZvDY7Gj9d/3xZiDrkCuXVMVEsi8uX2nzhSFH+Bh1vl+RZYhBoMyonc1tU8ho5/UndX0oGP8r/JWw6Bqd6/RJvI5nqiPKmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 09:04:47 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 09:04:47 +0000
Message-ID: <64ad4f12-561f-473f-ba41-1633aed7b5c8@amd.com>
Date: Thu, 31 Oct 2024 10:04:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] drivers: bootcount: Add ZynqMP specific bootcount
 support
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: trini@konsulko.com, hs@denx.de, pro@denx.de, sjg@chromium.org,
 vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
References: <20241029185814.7937-1-vassilisamir@gmail.com>
 <20241029185814.7937-2-vassilisamir@gmail.com>
 <c6ad234b-e756-4ea3-8381-63ffca1c2c5c@amd.com>
 <ZyJE7K8Eo7A6smyT@vamoirid-laptop>
 <bf1c5738-de6a-49d5-9920-bbeb30ebd879@amd.com>
 <ZyJZAP9e5iRRtRM1@vamoirid-laptop>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ZyJZAP9e5iRRtRM1@vamoirid-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0032.eurprd02.prod.outlook.com
 (2603:10a6:803:14::45) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ2PR12MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: 07bc0b69-596a-4748-8b7f-08dcf98b119a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1cyeFRIbHQwTlErWW9Rb3ZvVlFSM1FiaVFCaFg3SkRUNnQvdGQ3NHd0NEVj?=
 =?utf-8?B?K2RuWW4wSklnV3JmaTRlV3JDWUVWQ2ZNYnpjVFZCSFJ3MHhhZmtPM0pkQ3Va?=
 =?utf-8?B?VUNqSWpmcFNseTl2Skxuajh3ckdzdnBUR3JWcWhxNVNKOVc2UVFjM2ExZUVw?=
 =?utf-8?B?SWVjcG9rSzdGOWkrOTU2SlZlb3hUbnIwcVFxaVdRL01HdFhCc3BXM1JOZ2dJ?=
 =?utf-8?B?UTEzUzE0QjdsbnhucThQelJiKzFoWUFIZkphMnhyVkVUYUVGaGh1VWF0bTMw?=
 =?utf-8?B?Z2N5S3lnWkJlV2lIRHFwNWxyVy83TzU3OTE0TGJRME9lajViazF0c2hpUm9z?=
 =?utf-8?B?QmtYdndBTmZSZjZwTHprdTZEOHBJSmNqaFFRV2Qwdmkwbk81NGZ0U0d3NEpF?=
 =?utf-8?B?d3I0enN0akFWenVhQkpheEVhSndoQ0Y2WkNyejFxQjc2YWJyaTBQRW13QWg5?=
 =?utf-8?B?YjJ5bTlveW5jekFZNHV2N3ZoV0dEZmRYdGVzSkRSQUx5VEJBcGNIRkhSczZi?=
 =?utf-8?B?UmV0Ylc2YkIxNzVuV2JlZ1NNRDkwaTJLT3lqZ1FLd1FpSFU3dldJVlVKbnd1?=
 =?utf-8?B?QnNCVnFSYlI2SGtpQ3FYOG9LWDBZc0tsblI4K2l3eFpuQkwrR2M2bkRmMHgz?=
 =?utf-8?B?VFJ0ajVoTEhRU1BrYnZUbE1xaUlVTjlybFZzaWswTkRzdDVUckxrTUpVVkx5?=
 =?utf-8?B?ZC9pd3pVQzdET2M3Sno2NENTK3FFMkVrVzB5SDJSYXVDMWdrbEREOFduRjI0?=
 =?utf-8?B?cDJMSVdhUU1OeEM1dkJnamRGQTExQlFBU2tiZklmSVlxdlFRd0Y3SVgxQk5R?=
 =?utf-8?B?THRuVXFueFpCVmRCRGhRTFY0VWJNbFhINlVRV1lWcWdRZG5ZTFl2KyttM3RS?=
 =?utf-8?B?aENHRElUVDFpRTlEeUdhZW14RGNlV1MySXJzaHJicEptdmRPNU4yYk5kMWxa?=
 =?utf-8?B?MEVSU3lic0xac3E0cXU0aWQ0R3NXa3kxOHRYVG1pUzFKVnZEQ2hpeTh2b2pG?=
 =?utf-8?B?U2YyQ2VWbmpKV2ZkTlIzNUN5UnkvcUlpbWlOaCtsK2crdnhVamtZRlVIaWll?=
 =?utf-8?B?ZEFPdS9aOW9IZWxZVmVXaldTR0czRTltT3B4OXljcmFNbElzSzREdjB3Snlj?=
 =?utf-8?B?OTI1bjdSbjFTL3hoa1hTUlRORGJUTjZ0OWVMMW4xanJmQUU2c3d1MTB4L2Qz?=
 =?utf-8?B?ZFdpSDYycXl3SkJCeDA5UHpRY0tZeXdrRitPL1NGY3gxaEdlanlzQ0RVeUc0?=
 =?utf-8?B?VzlxN0gweDM3VUx0dm9vRk1kaVBralhhOTlQajdnNkdEMlcwbHE5Y3cxQ2xF?=
 =?utf-8?B?NWhnUnozeGZqL0lWcTZFcEVlV0s5S1haUktVTk0rN1dDb0J3TnlmSzIyRkRY?=
 =?utf-8?B?WHpxN25MaXJ5eTJvSHhqcmhWYkJzaDNLbGYzYVM4TTNKZ0hOeDhBR3ZsaGVQ?=
 =?utf-8?B?NjdEZFMzYWE4NytVNnZyS0NwanJycURMcXV2c2RMN2p6eVE3Sk9lTGJaZFg5?=
 =?utf-8?B?RGRVR3Q3ZGdBSDZvM2ZWV2pkWjd2bHMyWUFJcGkydHpSMFNzVUJLcVI5OW5t?=
 =?utf-8?B?YWlyNkx2Y2l0UTlKUHQzKzIwd1JnZytBRDU4UTNTOHVRRGQzQ2RNRlFrN0I0?=
 =?utf-8?B?VVMrS3VSaTJtRFJMejhnZ3B2ZFlCQzRDVVl4cS9jS2dFVVlVV2l3Sk90VWJh?=
 =?utf-8?B?OWU0T09vNUY4YTd6NStJQ3Y2ellCcS8rbEExR2ZTeHVQWmV5ZzNMZnUvZlVj?=
 =?utf-8?Q?uuLI1K3qsha/9Ff00CRNrdUU1X7Uo8ZN27oHax2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDZYK0Z0eW5KUWpwNFNZWFZhUkpIV1dQczJNbEYvckxRWFhiK2ovRXp3Z2pu?=
 =?utf-8?B?UitGNndrcjRwd0VvSjRyelVDVlUrSGpSVzFFZzRNWlYrN3RxeXUzdk5nUG9a?=
 =?utf-8?B?SzFPYm9EU0RyUUdRNDBWOHgwN04wZzZYSUhwcU9iKzBGdDUydkxhQVpaU3BW?=
 =?utf-8?B?eXM5QjQ1a05yYUs3WlN1S3V5cWo4akNEdzJjS3Z2VU1PdGxNb2J6cENVaXNF?=
 =?utf-8?B?RFhGeG9UR2xpNTFhdHVJVDdTQ2VaMlpRNW0zWm90bEJMcmR5b3c3TmZWSnlY?=
 =?utf-8?B?V2JBTDcrUWZCd1dRQ0VoTHhRb0J0QTczUFRlWEhXaTFwZjFGUURDV29raThw?=
 =?utf-8?B?V2VBdVlyK1F0Smc4ZlZHaXE1ZjA3djRrc003V3d4RWlLZGdDMW93b1VCaVZY?=
 =?utf-8?B?Q0Fpei9ySFA3WDV3bkljaTV3dTNTYTlPbjZNOVpMaURBVUhRT0s3cTg1aWsr?=
 =?utf-8?B?TDN3Q2lxVVhlaDZWL1BZdithT292N2lXWXYrMnhyNnBxMTRHOVZKQ0tjTVNh?=
 =?utf-8?B?NjdWaitVbjJPbnRGMmVBbWc3TXBIWnNveDk2RVV2UDZ3L3k0SDNqKzBVdjU0?=
 =?utf-8?B?Q3BtV21FZkhxNTVrdVBDQzEyTGpJeVhmSjRaejdJUzBqMWJYWGhrUWttKy9h?=
 =?utf-8?B?d3UrUmYwQkQ4OFNZaUp1dHoyVGJMMldwYXJWQnE3OVA4TDg2MlE2MHdKekxL?=
 =?utf-8?B?QURZSlR1SzUvNXZGVDVDSDI2RXloTkllUDlOZlBWaFJoK1E5QmFxMS9HaXIw?=
 =?utf-8?B?azFqYnZTbEhnVXlidkFBRlJZeFF6cTh4M2JWYnEyRzViTi9kM285QytybjV0?=
 =?utf-8?B?VkdKSWtjUHArT0pNZG5GZkpjNEsvaEN3Qlk5R284NDFqbTVRNDNhejFpKzRB?=
 =?utf-8?B?MDJFUDFjMjdLVDB1T0VGYUV0dG5lM210YmtneXZmb0ZjcG5jb1MzY015bGVL?=
 =?utf-8?B?bHp4TXVMSnc1aUZ2LzZHSGRrd0hJUXltNWthbkppaWU0SzRDQTRyTkJQWTYw?=
 =?utf-8?B?ZlU0emFIU0UvaklKSnV5dVMvbGpUSHVkb3BhYkNFbzNsOGc4dytIQ0ZsUHJJ?=
 =?utf-8?B?cExWSEQrbHZ5SzlMV3BlbGJvbldoVlA0V3k3ZCtLdm9GVGt1bEpIUkN5ekJP?=
 =?utf-8?B?RStPM05IWGc1WEpXSW5vTlBTTUFyU2YveXVWSitBazdCOUUrRk1UL3c5UGp3?=
 =?utf-8?B?bVdNeVc2YllhTXFLZHZ5dFo5Z1RLbkh5S2dUVEdmVlVHemtMQVlvcXBwSjZ3?=
 =?utf-8?B?NW40dUJMMlVOUG91cFhWeFVxMnpFdjVTTjBvOFFWTkx1dHBvelV3Ylkvei9O?=
 =?utf-8?B?YmZ0V3BFQW9TZ1dVbDJSN0s5Q0hpdHJxZHJ4N1BaTkxIdEx0ZGMySEtwWlNU?=
 =?utf-8?B?ZVA1cVc1TnJja1JBODdOS3EvNVRYZFhlMm1DcHMxVis2V2RCK0xVZVVVSEE4?=
 =?utf-8?B?OTgzUXZKaDY1R0xQZDZzV0JBQUZMblkvSFU2SzJTdXcwbFljU2tVK053TTk1?=
 =?utf-8?B?RjVtalB3TklHS09sSVNucjkxNytkME94VDdpbFloT2MrK1BnS3gzNTNrM25U?=
 =?utf-8?B?RXRMZDR4TkI4STNEWnNscHpubHp5YUh3NEszbmx5M3Z6eUM4SmNZL3FVZWtL?=
 =?utf-8?B?Wmg3YjdaRG5iYVJTVGhUWlhKdTlMWE1nYzgreXJ6bEpmVnk0TGhuVkZqdkdK?=
 =?utf-8?B?TXlQVG9SU0lKZzdvRGljaDhkbnp0NTdzRTBhUm1LMGNqS3lBWGRoTEZYNVdl?=
 =?utf-8?B?YVQ2UkJOZWlXR3RVYXFMWi94N3g2WXBueElEL3I0bVJ6ejFEN3FQWkYydGh4?=
 =?utf-8?B?UUl2amptN1NLakJGbFpJUDFRc2dIY1dsTjlJQk9UM0VaRWQwdHQreStxTTJQ?=
 =?utf-8?B?M2E4Slhod0hxOFZ1dlc2dGl6d1pYWEd5SWt2NDhOTFkvK2tiR09BVFpoZzAr?=
 =?utf-8?B?L2JoZnJVQWJ6RDI4b0NmMDY3NGVSb2htT01MazRsNDBpSnN3QkZpalJRektU?=
 =?utf-8?B?QmNxU04wc3Y2Y2tYRXpNTmpaUmc2KzdidjFoa1l4S1ZvM3hMTStoSUxvdzYv?=
 =?utf-8?B?eFd4cjJBdEpUL3o0dkc1Zzkwemh4ZWozdjJseXlZT1NYc2wzY2xtMTltdHJ0?=
 =?utf-8?Q?rVzjtQElX486nH3qAHUDfgU3f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bc0b69-596a-4748-8b7f-08dcf98b119a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:04:47.3229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F47a6MFxIsWnz993wer05a8WtdqtXqiScaPO5p4lU92hL33pNp2MMk33CDxXbM9h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781
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



On 10/30/24 17:04, Vasileios Amoiridis wrote:
> On Wed, Oct 30, 2024 at 04:49:10PM +0100, Michal Simek wrote:
>>
>>
>> On 10/30/24 15:38, Vasileios Amoiridis wrote:
>>> On Wed, Oct 30, 2024 at 02:13:43PM +0100, Michal Simek wrote:
>>>>
>>>>
>>>> On 10/29/24 19:58, Vasileios Amoiridis wrote:
>>>>> From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
>>>>>
>>>>> Add native support of the bootcount mechanism in the ZynqMP by utilising internal
>>>>> PMU registers. The Persistent Global Storage Registers of the Platform Management
>>>>> Unit can keep their value during reboot cycles unless there is a POR reset, making
>>>>> them appropriate for the bootcount mechanism.
>>>>>
>>>>> Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
>>>>> ---
>>>>>     drivers/bootcount/Kconfig            |  4 ++++
>>>>>     drivers/bootcount/Makefile           |  1 +
>>>>>     drivers/bootcount/bootcount_zynqmp.c | 28 ++++++++++++++++++++++++++++
>>>>>     3 files changed, 33 insertions(+)
>>>>>     create mode 100644 drivers/bootcount/bootcount_zynqmp.c
>>>>>
>>>>> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
>>>>> index fa6d8e7128..95b6a9541a 100644
>>>>> --- a/drivers/bootcount/Kconfig
>>>>> +++ b/drivers/bootcount/Kconfig
>>>>> @@ -82,6 +82,10 @@ config BOOTCOUNT_AT91
>>>>>     	bool "Boot counter for Atmel AT91SAM9XE"
>>>>>     	depends on AT91SAM9XE
>>>>> +config BOOTCOUNT_ZYNQMP
>>>>> +	bool "Boot counter for Zynq UltraScale+ MPSoC"
>>>>> +	depends on ARCH_ZYNQMP
>>>>
>>>>
>>>> help would help to also described where that count is stored.
>>>>
>>>
>>> Hi Michal,
>>>
>>> thanks for the review. Indeed I could add it.
>>>
>>>> And why not to have it under DM/U_BOOT_DRIVER?
>>>> You don't need to create compatible string for it just instantiate it.
>>>>
>>>> Look at:
>>>>
>>>> U_BOOT_DRVINFO(soc_xilinx_zynqmp) = {
>>>>            .name = "soc_xilinx_zynqmp",
>>>> };
>>>>
>>>
>>> I was not fully aware of this, I could try it. Just out of curiosity, is
>>> this the new/prefered way of adding new drivers?
>>>
>>>>
>>>>> +
>>>>>     config DM_BOOTCOUNT
>>>>>             bool "Boot counter in a device-model device"
>>>>>     	help
>>>>> diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
>>>>> index 245f879633..487adc1212 100644
>>>>> --- a/drivers/bootcount/Makefile
>>>>> +++ b/drivers/bootcount/Makefile
>>>>> @@ -3,6 +3,7 @@
>>>>>     obj-$(CONFIG_BOOTCOUNT_GENERIC)	+= bootcount.o
>>>>>     obj-$(CONFIG_BOOTCOUNT_MEM)	+= bootcount.o
>>>>>     obj-$(CONFIG_BOOTCOUNT_AT91)	+= bootcount_at91.o
>>>>> +obj-$(CONFIG_BOOTCOUNT_ZYNQMP)  += bootcount_zynqmp.o
>>>>
>>>> please put it to the end of CONFIG_BOOTCOUNT to have it at least in correct location
>>>>
>>>>>     obj-$(CONFIG_BOOTCOUNT_AM33XX)	+= bootcount_davinci.o
>>>>>     obj-$(CONFIG_BOOTCOUNT_RAM)	+= bootcount_ram.o
>>>>>     obj-$(CONFIG_BOOTCOUNT_ENV)	+= bootcount_env.o
>>>>> diff --git a/drivers/bootcount/bootcount_zynqmp.c b/drivers/bootcount/bootcount_zynqmp.c
>>>>> new file mode 100644
>>>>> index 0000000000..9bb801e188
>>>>> --- /dev/null
>>>>> +++ b/drivers/bootcount/bootcount_zynqmp.c
>>>>> @@ -0,0 +1,28 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>>> +// SPDX-FileCopyrightText: 2024 CERN (home.cern)
>>>>> +
>>>>> +#include <bootcount.h>
>>>>> +#include <stdio.h>
>>>>> +#include <zynqmp_firmware.h>
>>>>> +
>>>>> +#define PMU_PERS_GLOB_GEN_STORAGE0 0x00FFD80050
>>>>
>>>> In arch/arm/mach-zynqmp/include/mach/hardware.h
>>>> there is already structure defined and gen_storage0 is there too.
>>>> Please use it.
>>>>
>>>> Regarding this location. Exception in PMUFW is using this reg.
>>>> It means at the end of day it is up to you if you want to use it or not.
>>>>
>>>
>>> In master branch (commit 5cca0e3f6e0ff17db92476235ea1bb9cd8cbc9eb) there
>>> is no gen_storage0 in the structure pmu_regs, only gen_storage4 and
>>> gen_storage6.
>>
>> you are right but easy to extend that structure to have it there.
>>
>>>
>>> But in any case though, I don't use gen_storage0 which is the
>>> Global General Storage 0 but the Persistent Global General Storage 0
>>> which is in the in the offset 0x50 and is defined in [1]. According to
>>> this document, only registers {4:7} are used by FSBL and other Xilinx
>>> software products so from what I understand registers {0:3} are free to
>>> use. If that's not the case, which one of them is free for use?
>>>
>>> [1]: https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/PERS_GLOB_GEN_STORAGE0-PMU_GLOBAL-Register
>>
>> in embedded sw you can find this
>> lib/sw_apps/zynqmp_pmufw/src/xpfw_start.S:77:           addik   r3,     r0,
>> 0xffd80050
>> lib/sw_apps/zynqmp_pmufw/src/xpfw_start.S:81:           addik   r3,     r0,
>> 0xffd80054
>>
>> And there are 2 pages which describe their usage
>>
>> https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841724/PMU+Firmware#PMUFirmware-RegistersreservedforPMUFirmware
>>
>> https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842019/Zynq+UltraScale+FSBL#ZynqUltraScale+FSBL-WhatarethememoryregionsandregistersreservedforFSBL?
>>
>> But as I said I am fine if you choose one and you will use it for bootcount.
>>
>> Thanks
>> M
>>
> 
> Ah okay I see. It was much easier to look on the UG1087 document, I
> didn't think of looking somewhere else. Thanks!
> 
> In that case I would prefer to use maybe use one of the 2 registers
> that are not used, like pers_gen_storage{2,3}. Would that still be
> okay for you?

No problem from my side.

M



