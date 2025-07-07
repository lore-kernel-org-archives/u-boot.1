Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54DDC83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 08:45:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1230B8304D;
	Mon,  7 Jul 2025 10:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p/DQHu6i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38EC983093; Mon,  7 Jul 2025 10:45:15 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B9AA83046
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 10:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oh5TgBYPEE/UCeTfK5bW6nWIGYHU5wp63DyQduZeee71XplLKe5+JuBX3QxEQlXa6PiZ8MkPwVeqY3Elmyh6QB9QPqPuMd9IyHuc2q8AbEDi+Re++tCHg9hyPKB/nWPoHOg1XvrheeXTBdrB+Y5LX6ftuNKvsamDPTQahIoC8Q2YNRXC7sRoQTpszXbvcR3/342560nyg2YjbX50joroefIt0S7SUtHzD4f7/hc8SFv49fmXDblM4fp3oB8w/5sGbvo5a1rnQeD14rHN6YPdRHl4vY4dNL/0vl1HbJywYhdZbZDMlsfpgoYK9wxU6Z/aRnDFOA/Zcp7WHf6NTLa6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtoMrbU6sDyf3FGzdoKBLMgiiYLpOrdDVK2xk1ZqApw=;
 b=uZsmGgpPo7BVovt/+LZzUFDiqdJhDwhAFdzaeNDTxVl+89JVAgoJwxNjlW7L0ClX2dXNWfCI/Svgvw1ZnmNsYv7CVhNevMFKooZTfs3A1O0Fx81SCbBwM5mZ3acC7b7enKPL3ioWmOAnVnc+xUMR9fBg+MWHM/AJXoV5zhZjeKcGYhIXzuoIt5OUTsNttP2hRwzhH5ZsdWdqAkOpO82qtOZ1yYCVbdNTPYCLTNnOfNg+3B6FfW+hBTWFGsS8cznKiRBQxt9LPxkkwnmuoUUm1XUbrJu4QnaWV+/WYQF1hRJCl+zBx79rEEBTXip4Okikml1DaC9k68kokIEQwAQSpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtoMrbU6sDyf3FGzdoKBLMgiiYLpOrdDVK2xk1ZqApw=;
 b=p/DQHu6idhrxMQuLCXbEjRQTWaPfstE1wYacVCc8KobqoBNCR2KE5607gwmn2mqzFj+qEb7U27takmy+EXOp2nDCyOTDC1oqoSm7AS/TY30XOMXLackqHZyreSykuzrghiyzS4sVt0BRmufYEY2vqRYdha2utQyIfZiwRpS+rQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Mon, 7 Jul
 2025 08:45:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 08:45:09 +0000
Message-ID: <a2019e15-0510-4b05-8b4b-05a1b2b1276e@amd.com>
Date: Mon, 7 Jul 2025 10:45:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: zynqmp: Enable rng-seed generation
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <0e55eb3eade94e9cd0ffe04da0618aa6b1589f01.1751442246.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <0e55eb3eade94e9cd0ffe04da0618aa6b1589f01.1751442246.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:a03:331::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4e4d83-98ed-4f07-fa2c-08ddbd329477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXRVZnRYWGx0N1hZaUhuOUd0Y013Y3N5anVncVBscGExOXpiT3JCVFVJNGp2?=
 =?utf-8?B?SGYwSnM3Um9pdXFWLzNiSHBSQzhwa1FLVmZabW91Mks4VHlITEJGaUhqdVBl?=
 =?utf-8?B?WUZNcnpDK0JtTWkwUVRzSmNZQ1gzVmptbURhOW0yT0FUcnBXbVJSSkRMUnpC?=
 =?utf-8?B?Z3J6TkhJWUNIcWlaK3NaRUtvNWtZbXZPSDgxTnMxTkp1N3VNQzA1c3FwS0Na?=
 =?utf-8?B?aEZZSkRHZ2ZuR096RGhlbitLZGlMRVpKbEdkZzl1REh2d05INEk2bHpGSmI0?=
 =?utf-8?B?WmUzcHp2NEZuZGFBQ3ZRRVd3R3hQR1FkVS8wYXVaek1BUnNpMTQrOCtXMjlP?=
 =?utf-8?B?THFOZHA0NVJ4MHVvRjVySzl4a29RcXBiOG5ENFNCQ0ZhVStvN0xWWmRCN3B1?=
 =?utf-8?B?SXdrcVRiL1hNaTdwcnVISkdlY25qVGZBZUVOUStNMlRLTW1xTmJpSFZzcTNw?=
 =?utf-8?B?Z2J0SmFyV1ZYeGg5WGZVRzhoSVE0dERCcjhQSUFweUkySHJncDJ0emFjM1hX?=
 =?utf-8?B?cVllSVlvZGRnQVBCTGxIdW80MFVhVmdBQ0lic2JReTF0dk9scE9ZQmdYUDUz?=
 =?utf-8?B?RExqN0JBRm5SY2xjNkhJc1U3MjVua3MydlNXM2h6ZjZXbjBjZ3Y4UmJqdFc1?=
 =?utf-8?B?RUpjY0ZDcEwwVGlxRmRqbVJCWXQ1UWM1TjA3ZTBuMVU3MDQzVFR2SS96RnJJ?=
 =?utf-8?B?THF5VHRoM2padEZBTlBCU1VxUm1CT3BRWUw4SmpsMFIwbzdQZ2kydGFoNXZ4?=
 =?utf-8?B?U0EzSXBHeGxJT0tCWkRsdGxtWlJidE1BR1dsWTFlRmx0SVdtbGxZKzVybUYy?=
 =?utf-8?B?ZXpMOEx5OFA0ekxRRUdwVUxrem5BaHRyNk94WjIyemNYV3czMzE2L2xRZVhx?=
 =?utf-8?B?UmxWSzVuVEtucFVQOHBsenoxV3VZaDFGWWpxeFYxUFEzbjh4WElNWEphVWQx?=
 =?utf-8?B?U1VOaXAwSFhoUWlla09tcmJuVTVCU0VDNnlzSWVFRHZ4dlFMYWRVL2EyUVpC?=
 =?utf-8?B?M2JDb2JvTUNJcmZtRTEzblM5UlFQYlhsZGtyb1NmNGRBcXhVTFgzamRoL216?=
 =?utf-8?B?YlBwOFFZWWwwSyt2ejBJVHR4eXYvWUE1bHk1NVlYdEZRbW5EY0g0cDl2TEY2?=
 =?utf-8?B?bVNjTnRWY0RyUXhJcXYxbXhScXFYWnZkTFlPWFhoSHE1ZjRHZVM5YVVEbnpv?=
 =?utf-8?B?ODhaWkk0UkdJYUhjQXdJdXYrTmUzZER2bWovSFhYQUV1WTlPemwvYlBKVUYx?=
 =?utf-8?B?ODZ2RldTU2x3U0pvODZISVpiUlZHbVRxbUFRL3hQSHhVUEVidytiWWQ2RkRO?=
 =?utf-8?B?b2xSRXRoNEU3VGVPLzZkYUJrLzZ6RUZzanJLMHJwYVdHV2ZPK1FMMXNQaDQz?=
 =?utf-8?B?VGdEbENPNEp1TzdldkF5UUZYTmZwdEI2RURsbEhtTU1NeTNndWxGNnRwMDNX?=
 =?utf-8?B?cFgzUUJSTzV2clA4SUE3cVNBei9qd0ExeXpNeVE2WjVkVXowYlNqckwzSGQ5?=
 =?utf-8?B?QUtyL2dpMzlSZEZldlIrTHFnUmtZRzQ4T3hxdGNXclIwTWQyd0xkbUVDeGMy?=
 =?utf-8?B?U0NEYUZSYkpmYWxoOW5ybFp2QTVjSFVqSWJUM2N6aXFoWWdta2t1b3NVWmlq?=
 =?utf-8?B?b1NXN0FKa1BoVFpNV0VCa1M1RGVYNGVoT0RBMVdZWXl4WU03aE1IMk1RMDJy?=
 =?utf-8?B?UzBoVjVkclM1MkhjZGZyMzNnOWlhOVhIaUExMnpuM20rVHNFOUVBZ0VtWXlo?=
 =?utf-8?B?dFZWanNHV0RZMVlHSURFYlAzelcwUkYyQnJqbHowOUhKaFlveEVENUk2NFlP?=
 =?utf-8?B?RXVkNExpTWJhSEE0TGR0UUtpdXNYd1RzMEF2T2EwN2hKMWNjSDJJS1lGYmY0?=
 =?utf-8?B?aGpFOHNBa0JnNC9ENmlOYlBKOVhkMnNCOGlJSEdWa1dJa0hqM0E1SGtPUGla?=
 =?utf-8?Q?9PsaspT4aJY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2phR0EweFpJYnk3Q3JwUFlYMG80U1VvTnBvQnRjcUZOcmM1VW54TUdkeWov?=
 =?utf-8?B?cVlqcnJVbVlVUk5ScmVRMUFlWmVrUisxM01PMFkwVGhJZlhCRWZ3VlVuNGdl?=
 =?utf-8?B?RVd5eHVhZ1l1NklOME8wT05iZHVDRnl5cm4xUUtLeVR6NXlCTC9hd25zMFVx?=
 =?utf-8?B?N2ZMTTZjVGVnUHdZcjlSNlpSam1PdnFPcnd0NmEzYzNPSndSUjhQeEZHN0h6?=
 =?utf-8?B?Y0FQcDVOdUZ6WnpqTTFiNjh3SkF6ME5TdE1vVmlIZzFLZjk3dDZMWk1aUERG?=
 =?utf-8?B?V0U4bDNmZ2tTaDgvMndibWpFWk1mOW5kY1BPWVhRbFhRN05oMGZaZEhxNERk?=
 =?utf-8?B?QjJSdStUOHVyQ1NlUU11YklkTVg5YjRxSk1meHltM1R3eHByaHE1azh5Zjkv?=
 =?utf-8?B?dW11cTR0UytxMnppMEVYR3JvSllBZHovT2VMdkpJOTRXUkxJb3ZzbnNEUWo1?=
 =?utf-8?B?WncrditSUlREWE5oMmZTWExaa01KMjdNZWRPc1QwQ1dmb1JJZGhrQlRudktV?=
 =?utf-8?B?eFB0Z1gyRlduRmRkT1JRK3N1Q0dPVjAvZGoxWm1LRUpQbnRUZTMyYXh0MTJD?=
 =?utf-8?B?NUlCRHA1aUU0YmpmS3FocW9GbmhHeUtlQ2M5M2FadGVaL1JsTXRrS0cwME5P?=
 =?utf-8?B?a2k4OEtiNGFGd2lXY1dMakRVR1Ard3lENHlQLzRkc3JYcXdpa0FBWlFiSUFj?=
 =?utf-8?B?UzFUNU9Od0ZQeExFeE5BNXdyM3VyVkV3NHVYZkhyM1JkYldaY1dqOTNqZzAr?=
 =?utf-8?B?OHJBZnFDVkw4eEFUU2RDdWp1a0tVM3FzQmRJbGVxb09hWDBMRDVtemFTTVk5?=
 =?utf-8?B?Tk04OThRS1ptN1A2VFZmYXJ3bjJpRmZMVmZKT24vQVBIOVpOYWNOL1lTUlNq?=
 =?utf-8?B?S0pLbEhXanNaWUwzVGoxUVB3ZVRVVU5yS2lFNkkxejROVjNWejRheHNXbUhE?=
 =?utf-8?B?YkNrZ2FEWENvSUdBU1FWNnFHS3I0Y3pvaVZRSFhoU0hJMEh3K1ptcnF0ZjlK?=
 =?utf-8?B?MnNFbVN1Uk44T2lUTGYrdjlwRjZZZWh1cnpkTDlpOWlIU2U5LzRBalJWb0Uv?=
 =?utf-8?B?RG92YXR1ZDd0Z3QrWkdSbjNBcEhLU1l2QnRFbXVQUjNjdXhoVFdCd2t0ZHk4?=
 =?utf-8?B?Q25ld0ZHTXJjSTdHTWZOYW04WlVHVjhyUkJGNjhmS01VaXp2SEgxRXNBWlhp?=
 =?utf-8?B?RlNORkFpWUF4MjgzUW1ZUVZVZS9xZUMvTFpqU2ZRb1B2WnJHVzFyUFE3Q2xi?=
 =?utf-8?B?bmt1K3JTSDY3a3A0YW42NTBTZXI1ZnhCbnlidEJudkZQRUJOYVFacDdOYU1Z?=
 =?utf-8?B?R2hYTEdmZjNZTThUeVUzODFNbXJIL2VVZ3pvNlZJU3ZvU0FKNCtFbllMcktx?=
 =?utf-8?B?bjRYN0hjQzczV0FCOWlmNjFzKzQxTUZLa3hiU2FhMGt0Ykd1c0h0a21xUjkv?=
 =?utf-8?B?cW5mcURNV0FXTksyRkhSaDVyVTRTNGE2N01DR3RnT2tKRS9YaWxOU09wWWZh?=
 =?utf-8?B?Y3pWUk5tNldVTXFJaGR0REJ5U3U2Wkt1b21qUjFYMlZvaTRFWUYyUFhtckdZ?=
 =?utf-8?B?Mm9YcWltR3ZzK2UrNzFJRElrUVExNmxnazYxakJVaXQrQW5KbC9GSVBIWjh6?=
 =?utf-8?B?dGlCZ2pLMDJGL3pUUDlTNDAwN2JXOEhFMkc4dDBHOWpFbzQxK2NtcnBnUDAy?=
 =?utf-8?B?ZXhUNDFJamdNNlNIc0N6d1JmQXJkYmNzcmwvc0NwL2Vsd0VjbTFwTlE3SzRS?=
 =?utf-8?B?VzlUTUNMOVVlZFZ0RElheXBGelVtaVFtdU9RUUNYUVZ2SE1jeWxFSlowb3Nj?=
 =?utf-8?B?UVBTV0pzdXJUalNoWk5sOHlic0FGL2FqMGR0UW4vcTF4aVRVNnE5ZElqVHVE?=
 =?utf-8?B?UTdKRXRySVhaQmZmcWNLZXE0RWRRT2g0T1dBUWpFcDJkQnBvWGdBN0J6RU0y?=
 =?utf-8?B?Sk14TWV4SWJYQVpvWVBqVGVkM2xGaDA3aHFOMWtBeTg2OXRpVVh2c09ZMWE0?=
 =?utf-8?B?WUwyUGNHeElneEt2N0VXS0RtSkxha052YmEveWZYcjBQa0UvMzFNeGo5OGVW?=
 =?utf-8?B?U0xvRElrNUJTVGgwTExnYlh2VjJXaVg2Tk4yQ2pnNjNwWTNQdG1GMHZBRWJp?=
 =?utf-8?Q?SCMUfSav+6mW7ojhZHoFLhNy+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4e4d83-98ed-4f07-fa2c-08ddbd329477
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 08:45:09.4749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIcrNNGOlBN28dNW6Cd3p8p7JQgrxjVJe90N6vGZEhJBsh0JfUB3oN3NFfrvjXFq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
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



On 7/2/25 09:44, Michal Simek wrote:
> SOM has TPM with RNG in it that's why enable rng-seed generation.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v3:
> - Move malloc allocation before rng_read
> 
> Changes in v2:
> - Free alloc area in case of error
> 
>   board/xilinx/common/board.c          | 33 +++++++++++++++++++++++++++-
>   configs/xilinx_zynqmp_kria_defconfig |  1 +
>   2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 8ffe74299016..ceb58da6d3cd 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
>    * (C) Copyright 2014 - 2022, Xilinx, Inc.
> - * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
> + * (C) Copyright 2022 - 2025, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -712,3 +712,34 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   }
>   
>   #endif
> +
> +#if IS_ENABLED(CONFIG_BOARD_RNG_SEED)
> +/* Use hardware rng to seed Linux random. */
> +__weak int board_rng_seed(struct abuf *buf)
> +{
> +	struct udevice *dev;
> +	ulong len = 64;
> +	u64 *data;
> +
> +	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> +		printf("No RNG device\n");
> +		return -ENODEV;
> +	}
> +
> +	data = malloc(len);
> +	if (!data) {
> +		printf("Out of memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (dm_rng_read(dev, data, len)) {
> +		printf("Reading RNG failed\n");
> +		free(data);
> +		return -EIO;
> +	}
> +
> +	abuf_init_set(buf, data, len);
> +
> +	return 0;
> +}
> +#endif
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index 22ba8a7cc158..3e2ac6144050 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -46,6 +46,7 @@ CONFIG_USE_PREBOOT=y
>   CONFIG_SYS_PBSIZE=2073
>   CONFIG_BOARD_EARLY_INIT_R=y
>   CONFIG_CLOCKS=y
> +CONFIG_BOARD_RNG_SEED=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   # CONFIG_SPL_BINMAN_SYMBOLS is not set
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set

Applied.
M
