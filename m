Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBCAC7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 11:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8C4D82AA4;
	Thu, 26 Jun 2025 13:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="arL0PqUB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F132C82D83; Thu, 26 Jun 2025 13:32:56 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4280880E9A
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 13:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNxLNTrozyxJTwfRIZofakBLuSC/Lry0SqC9fAPMSvJN2kgP3Ms/6TK95Q+jINCjkF8YtMPG7+VAbedwn/I0TW6nVyGXav16KansnZNhFmD6aIMYG7c8zkI0ThD83ZzA8KPT7N2lBOAminPLH8tZhCoctup5c0GcpX7m1zoZ6lw8KvonDYifTt6auqlFeZ5x8dG7wDgVVQci0f7AOc//PiKq6mWudEOP3rfctuGPoGTs8TuSYPE0/pxCQ0gXofb251bGVJpjzFbGrxbNGe38Fy6NXyCWngjwrXDT2KuurmowsRJlgkcTN4aj9jqjbJh1s5KmxDb7d9V+uNIl5J5+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDppRDyJZQClja0bwvD5fTOYVNTjfSS9SNNNLr/UT1Y=;
 b=Tmpjq/qGbaR7YQk74INmHqjBmju0HkDwX5ciLPRS/Zno+TWzS/+CHvnb9PMZ2sYaUXI/+VNUGgo7+uZ+9jhC15Xo/dDEPsLAPsxnX3oeGPyRW+EZmfTqO3kHC545hLa2PPk29W0av5Qqs0a0SB0/e7VaXhpugMuq6z5PO4wr2FTr/eWW4RPGrw0KvO5hSDbemy4QJn7+f8DnPVnVdTNzGeijFzkwlbPvuSiKzccerUeMao1NKVpZxtAmbc9s2DOhkhSSRejfZnZbj1M+9PYtXUYspbppC1Xtjx2lopx48PPBs6VVGu6o73k+qtR1ehp0LdlD3HM+GV5HKq5Gvd7uNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDppRDyJZQClja0bwvD5fTOYVNTjfSS9SNNNLr/UT1Y=;
 b=arL0PqUBYrtwuEr7nixXt/m7eC2IB3AeQhg+vgmgGcIBm+Pfv//mHdFhhsJORTH4rLUhMEnskICCKmNLwg0GYPNVDNLwJ7C6RQKW9/KCnr6NM9hELBricsDImway6Q4v2SPWU6U2CEXoQa3NtSI0LSWEESS81RDXYN9Etg+3sW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10223.eurprd04.prod.outlook.com (2603:10a6:800:229::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 26 Jun
 2025 11:32:47 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 11:32:47 +0000
Message-ID: <b6afd62d-407b-4671-bac8-5a2608acfc22@cherry.de>
Date: Thu, 26 Jun 2025 13:32:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: mtd: Prevent use of uninitialised variable
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250626-mtd_fix-v1-1-1ffcc59a9d0a@linaro.org>
 <b8e3d928-7f3c-46ef-bf6d-6eb8a48931ac@cherry.de>
 <84d760dc-cc1d-46ab-bded-d7c6f72abbf5@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <84d760dc-cc1d-46ab-bded-d7c6f72abbf5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0148.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::32) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10223:EE_
X-MS-Office365-Filtering-Correlation-Id: 272accab-b354-4a64-408b-08ddb4a52cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MW5aS3RRdEttSVhNU2ovdUxWK2Rwc3VPUEJ2ekU4UktyZzRlSnUvVHlCZXVE?=
 =?utf-8?B?cWlmc2xEL0VZdHcvUjdvUEcvWTdDVFZRd0ZXcFBhZ0NNTE90Vk1xcHNZL3BH?=
 =?utf-8?B?eWFDM1V6eWMzVVVoaSs4em94djVwcGhxQmhzQkQ5NXY0SUlQTTdodEFyc01K?=
 =?utf-8?B?dHRET3ptdS9zZWw5ZWIxQ2YxcEdIVTBjVlIxd1dGZkhxeWVVUjFYSTV4TGQw?=
 =?utf-8?B?L1RWbi8zSmg1a0o4YnZjK2JSTEhjLzY0NjM5Y0wraEdJcTY3TWVaQUZPMnYr?=
 =?utf-8?B?VGpnTDRoUnZnWHNTN3NWQXZoSDZwNzFQQVAyT2VGUHNORjg0ZVY2d0IvV0Qy?=
 =?utf-8?B?aGNjbEkwaURicUxqKzhjY3ZlS0pqYTRRU1I2dEhPOG54ZGlERFNSdGMyU3Q2?=
 =?utf-8?B?YVJPa2VrYnNJRTdZY2ZEUWhGcXNIdWc5RlIzNnhhL2ZSY0FYOW1FVDZXVTdT?=
 =?utf-8?B?a0JRY3BlNC9WYWJTeFNnNnovV2VRL0RHYW9xMFhWNG9jWHFSZm56ZmlzT3Nq?=
 =?utf-8?B?dnhGZm83NnJNV0pYejN1WC9SdXpWTkpVQWVGakpsM2FlRUh5UTJoL0ZGc1Bv?=
 =?utf-8?B?QU0rT1Z0d291V2hZQ3g1WjBENk83ai9IWjZYM0xQcm1HazVMUFRtSmtQNXFS?=
 =?utf-8?B?czhGeFA3RCtPaDhBVWpyVVduQ2huUWliNE1rdjU3ODdUVkRvNmRTdVdNTmhh?=
 =?utf-8?B?RG5aN1N4SlMwdkM4WXFwRWF0OXBhdXUzRjNObXJDZUJ6WllEUU5FR2hWTjhw?=
 =?utf-8?B?djluWnduL09YMU1Gd1RKMW9UNkJFcEdyQkxvM3RyMjVEWFFtQVIwMnl3akpH?=
 =?utf-8?B?NWVSTHgwMysveEhFT0hPcm42Qm1Ocmd6MVZoRHB2TnBMN2p0QzcvclIzajFL?=
 =?utf-8?B?K0U2VkdGeURXQXJWR0ZtSUllcnlXYzdzdmZNdDZrMlhJbG0yRmsxeElUU3Fj?=
 =?utf-8?B?aDA0SWNSOW9BUXorUVU2bUFVdy9rUGV4c1ZoZ20zYVNhanh4OWY1L2dZa1JW?=
 =?utf-8?B?M0tXQ1FBZ2thL0x6ZEQvaDZTc000SkovYTF1OFB2YjFaYnFrbUJ1d1IxcVBD?=
 =?utf-8?B?aFZJZjZZZzI2MS8yNVIyalp2SStGMzR1ZFpidWR5TG1SWkpSamd2Q3UyY3Rv?=
 =?utf-8?B?bFRockQ4ZGlPMWpYeEl4Ly94S3Z2aUswQ2ZhYUlsTW9MalI2SmloaUx4b3Ry?=
 =?utf-8?B?L1JWU1RoK1pOYVM3YmJRT05Ec1ZaeDIxV01lV2FZa2JpNVRLSWVwWDBrYXdV?=
 =?utf-8?B?UFF3anVRem1YU2dPOTR2U0ZuYnZTNUtsK2tieHArNUFUbjYzUmMrdkIyZkhx?=
 =?utf-8?B?VEt1eTNZOVNMVG1SbHJqMkQzSXp4UDNSaklMS1RmRXhVZjU4cnF6L1NmajZL?=
 =?utf-8?B?UUFUSzA1ZllLTXRsUTUzMDREZ2JpckN4dmFleGRLc0dSNGhNc2lkMEE3cWNP?=
 =?utf-8?B?bHNWSlJmcGlTN2lGa2l3SnlEUUJ2L3pJR0pVcitLZk5tWlVKTGEzSXY1T0Jw?=
 =?utf-8?B?djkvY0oyWHhIRVYzRWVNVGRTMndDaWl5Zno1MnRhZ0M0S21jb2lKNG54UTB0?=
 =?utf-8?B?ak93L0o4cmNZNVcwT1lCN2dsQ3R4cC95NzFCb3ZXc0NVWjg4SmpsbnJZWGZy?=
 =?utf-8?B?cDJLR0dlQ051VGtycklMVUwyRDA4Sk5Pd2hkL0NTUCttMVdqdmhXY2FoNjhh?=
 =?utf-8?B?dlc0VEdzanBucVgwWk1MQVlpTXJEOE1YS1QwVFdpS1hnSEd4cnBUbWpMVWZ3?=
 =?utf-8?B?UUs2WkNvUG1vVWpqcVhXT1JzbGFQL3VPRk80a2IzZlZsWEJsQ0xqRm5aaG1S?=
 =?utf-8?B?cWg2b0graDRWcTJjaVhhR3BaeW4rcXVYVkhJUWtoamJEL1o5TVJlVm56SS9p?=
 =?utf-8?B?SzA4a2dmRTBhZ040ejNVWkFwUnBPOUpwNy9xNWFaRzU3UEVQQjRWTE94cEh4?=
 =?utf-8?Q?q6T+nleCZ9I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YThPUHFpUkE3TGF5ZnJlalBwUkFMckpDalRkd1VzL3B4MVRwOWJ0K2w2dy9v?=
 =?utf-8?B?S3VEZmFETStHUGdCcjVrb3diN3p6ZUViOVl4dkxjT2tlZE13THN2c1dlTHpG?=
 =?utf-8?B?QnQ2MVRHcmw5OERSSjE4bjVsRGhieTZVWkFSTXVySVZFVloyRkYxZVQrVUhl?=
 =?utf-8?B?d1JNeW0zOE5VRU4vbE5kRk9NSFgxZUMwQ09wNkdKUVZMRXg1WEYyRExrR0sw?=
 =?utf-8?B?NmNCTldjRS9iY01kejAyT2o3dDZWY2V4TmV3NDFxVEdIQjZsZlhzcExuYTk5?=
 =?utf-8?B?SjFnZGlMMXdZZzl4cTJtaGI5RmJRSWFESEg0ZXU0TlB5c1RTcE5MODhzTTZH?=
 =?utf-8?B?YlFrUHNxaHM1Yk8vdkhtcVJLUHdreHpiZ1B5bGRlRXBFSzBZdHpMZThML3Na?=
 =?utf-8?B?TDBaUDg0WVNkekFpZjBkcHlrSzhORmZsbFUrYndXRUk0c0FzdTk4ZWRXZDkv?=
 =?utf-8?B?ZWhub1RQNU80UEVoY3VxRmtVTUVEQlBzajBFdktRbHJLK3dMRnBUcGdxVWFp?=
 =?utf-8?B?YWVlOHZOZnhkMVp5U0gvTTBTUlZOa3F4TUpNUjFTamdENVBKbzAxZW85WmVE?=
 =?utf-8?B?TmE3Y2JkR2RXNzBxSjZDZmlHSGw4b1NkU0Z5d1Z2cEUrT1VpUlVOQXc1dHZV?=
 =?utf-8?B?RjUrV3J4WlU5aGVsRElNaXN5UE50eEhRbjB5WjFlUDdaU3BhOU1CVTJoTFJD?=
 =?utf-8?B?WXdkNU91emJLaWlITHpyWUJraXJ4bFFpeWltcHlEdC84YUdjMVBLTmw0MUg0?=
 =?utf-8?B?UFhXWXF5ak1GcDF0UVVFV2dyUzFPams0Nlc3S1lBS2ZJQ1RtclBQanVtWnZV?=
 =?utf-8?B?VWZBeFpMVk9BM1J6OUFHbVFZWEVCdGZIK1gwRU91VXhTcytxN0d1SGR0bEcz?=
 =?utf-8?B?RkdmVXR4eVVueFdNUUVtRmFIMnVUWnhZRnZIYU5xeGZETEhuTjRnSUZPSDFp?=
 =?utf-8?B?NmgvOHd0UzI4WXF5dnhpczlEdVFyTzdRaFo1VUcxVWVMWTRKdWltL3hMdHly?=
 =?utf-8?B?UFByYWtjUUxTYTNPL3RaMzJrK3FQazFhVW9HSlBxU0habERhQ1ZSSlBqbkQv?=
 =?utf-8?B?Nmg1bWpFUkxKTkp6S3VzWittamEzNjVJNytNa1V6ZGhJVVB1Uko0TVNnZ2Fk?=
 =?utf-8?B?Uk5taEl3aHRYSDhRNE1CNk1MK1c0WTNxT2tyM29PdEI0UWhZemtBb3JCQWcr?=
 =?utf-8?B?M0tjUU5kcmREc3hYVlBYNzdDWnJ3dERWbFM3V1JDbmpJQnR2eVNmSlhBeWg3?=
 =?utf-8?B?eHJOMytLeGJsV3JybHp6MUIrR1R3aUUzZDcyMFBYY3BFYXFnNEJoaDk3M2ND?=
 =?utf-8?B?OXRjcXdEaDJQWUtwUGhLZ0ZZVVd6clRucXludHN6OUtRQ3NQb2RGVENQbGNO?=
 =?utf-8?B?TzdNT0ZCYXdyQm51aFBzZGhhY0pWUEFNKzEwUzZjWm1lOTgrVUwweDhxbURr?=
 =?utf-8?B?V2N3d1VwZXMveUMvMjNoQ0tqcSt4OEEzR2VSbzNDUkcybWpFbkcvb0pIWS81?=
 =?utf-8?B?NGcrNFhWd0VGNk04Y0FHUUIyWVV1MVN5dXIxd0hPSTNkRkduVXNrSUZ1NWdC?=
 =?utf-8?B?VTJMeURhTnlGL1JnZnVZZmRlUWtpY3BkQ2VZaGc0TXRvUkxKODFPQytLMGI5?=
 =?utf-8?B?aWwvTENHNmZQV3NGOTRGVk9hYUpEWFFwait6Q245TFJ6T0ZoaG1sNE8xTU41?=
 =?utf-8?B?YUovL0d0eEdDWUQxWW5pM1lra2kyQWNCWVluZUpPQ0VoUE80Z1B3OFA1YnBi?=
 =?utf-8?B?RHJYbFZGRjk0NWphOWxNMDNVQ09vL05ZYlB5Z1MwaVlQN2J1am5FbzRzN2ZP?=
 =?utf-8?B?bjZ3dXUvWHhrMCs4UUc0NWlvcW1YNXlBSnlpaWs1eVhrQkdIV3NKanA2VzN3?=
 =?utf-8?B?cWdWRFFjaklrcXVVVFpTWERQdzA4eW05QUw3N3psWlZuV010RzdGOFUwSXpj?=
 =?utf-8?B?cmpobFZMbkw5VWhyQ2tIbkRhZWU5c3dJZEVueG5hblZpY2FnaGx1Q1h4S0lt?=
 =?utf-8?B?ZlRPUndCdTQ2MHdJMTJpSUFYN2RFYkpCSGxJYmd2NEQ2Z3A3WWxicFRYMHYz?=
 =?utf-8?B?VnpHMFZyeEFlVEQ4cXVuem43SklxVHFRMEd6bS9TaDZQRDBsb0l3dTZhSW1N?=
 =?utf-8?B?d0tHdlZJRklZdmtSdVJoSlp2L1BySWV5clBVRkR0UGt4RE9rUU8zZ0ZXWEpk?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 272accab-b354-4a64-408b-08ddb4a52cf7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:32:47.4723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArwHi4IL38LR5la8ev7kiPFthpMHGcYzZf9D/Fj7mehicfzb+wrnFQCg/rkQ1JMOjL8/hrFwFUkGGP1mzKsCA9czBJewBbnMyPwTY3xZ8+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10223
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

Hi Andrew,

On 6/26/25 1:29 PM, Andrew Goodbody wrote:
> On 26/06/2025 12:14, Quentin Schulz wrote:
>> Hi Andrew,
>>
>> On 6/26/25 12:49 PM, Andrew Goodbody wrote:
>>> ret maybe used uninitialised in some cases so instead
>>> initialise it first to prevent this.
>>>
>>
>> I don't believe that's true, can you tell us which code path(s) could 
>> trigger this because I didn't find one the 2min I spent reading the code.
> 
> No error path taken before line 563, ret is still not assigned to.
> remaining == 0 which could come from being passed 0 on the command line, 
> line 518, unless there is a check for that that I missed?
> Code reaches line 591 without assigning to ret.
> 

Indeed, clearly missed that!

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
