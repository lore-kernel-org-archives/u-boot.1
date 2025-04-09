Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341A4C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 13:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965AD837F2;
	Wed,  9 Apr 2025 15:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YCAFpGAp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B09D837EF; Wed,  9 Apr 2025 15:32:22 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2510836C3
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 15:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=te2PzbTFRZW6rghGV9eAxQfN6pjLwGQscRKZJAS1uvUNvLT3don11w7P1XeISdUwdFcUMg6hlqk1F3uS0zrNK/vJW5GKYhQKh8CmvF41mMr77VQbzujbQBliq381O/NBGXqPuSMXp89Q5Chvd/V9Z4g3IM5koS/sOGX1QD1nKQp7CkyGTMkNejrQGvnEHPF8Dc4+pZYmCchZoPKFCKpvQb1jJmOyR9an4+U+yVzGIZ8gVCSDHpZv7jyMAZXwW5WzGNRa3XjNePi7ZmX3MrWLg/ioC0wdA7jizAVCoUF5pwSRIvRsxgzPFCZ4pQV1y2Bd6QBMkUwDhdIDFQC6SRFAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jL/conp9WBRNGLDc//lALDbbqSHD+XlcnLK6oOsLZoE=;
 b=IEZCSKT6oPo2r2zF3sTl532Ly0kjYeYEOT08jjEQhIlLdGLZfUcDL3+TA2ijX9Rr8CXdJqvsjNA23hChP72BJt8lRwiR56S4PAbpMEOUo5GIWm+PkdQD4t7HsdChkvOiJ+eXCZsCIBHhE/7N/tsW9FI+csLrsbgp+oWt46CV1twioxOrzwOkiDER57g7iroxppn8uoao9NWVoX413jxTmuh9RV1fWp9WZfe9VzCfvprrmHQ2KmV30tMK780kgaYZivibxi3CpkwyFDJIYHpHDuhmro27iO4Ed/S9NQ+MM0E8glYv12Z+sQ6cT30jEaD6DGxBU3zBeangY1h9Y360zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jL/conp9WBRNGLDc//lALDbbqSHD+XlcnLK6oOsLZoE=;
 b=YCAFpGAp95HJXsTMELePOU2Bno2HTpb7o+gCEDBMSadVo/W0/BavNPmskctdQPYidptye7M2qcyk4eW7bhMaurnJf5s3xmhy127ZwqAPmG+acX1d9CoFXobh03jrkFpWQJTYULDy1Egk3jR9NypRqb8XFu9c27dZDV4p5KkGTW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS4PR04MB9551.eurprd04.prod.outlook.com (2603:10a6:20b:4fa::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 13:32:16 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 13:32:16 +0000
Message-ID: <e7ac70c7-676a-4df1-b1bf-5c4bbbc31a1c@cherry.de>
Date: Wed, 9 Apr 2025 15:32:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] rockchip: binman: Use the skip-at-start prop in
 simple-bin image
To: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-9-jonas@kwiboo.se>
 <01e8a4b3-a77c-42ca-a4de-e744755a2b89@cherry.de>
 <CAFLszTgSeGN_+adh6VviNxYmVCGR_iOQN_igBbdEaXxDqKsb_Q@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTgSeGN_+adh6VviNxYmVCGR_iOQN_igBbdEaXxDqKsb_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS4PR04MB9551:EE_
X-MS-Office365-Filtering-Correlation-Id: d7bf591f-f173-472c-8185-08dd776af199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTJGVDNvQUlzZUlwU01ST2d1MlZNek9VckZmOVVSZVZmVHV1amVXNlQ1bjUz?=
 =?utf-8?B?czI4Ylg5WWZxbHI3M1VrSGZ0ZFBJZHNCVzVKSW1RQ3V3eFN3MlFJdFdvRzV2?=
 =?utf-8?B?TXlOa0RReVg4NmhZaCtuckNOQlZpTERUay9zc3IrbnNGbE1PYjRpQXgrOTFX?=
 =?utf-8?B?ZDNNbjZTM21jTEhMeXhUZGxNdHZrbXZBaElVQ3dmWnpaNjJEdkpVV0RTZUlz?=
 =?utf-8?B?T1l6aEh2R3A1RlhZckpZYUdWYWhEWExPTXJIVThsZGVUbHRBd2pLdXdod0I3?=
 =?utf-8?B?OHZZdVNESlhnY1paQ2J6bkZ5N2RJV2xqV2R6elZySklBbEY0cjk2bXpST25z?=
 =?utf-8?B?Q0tZQlp6Z0NzUlY5Slk3Y0Rwc1JJVnUxRi9OUitkVWQxZU5DS0I1WVYyVXJ0?=
 =?utf-8?B?bGl6czVjSVRWRmtJZHdxWXhTZ1FGM2hYRnBpWFVZaUFIM1owSnVPeGFGVUE2?=
 =?utf-8?B?TlFDajYyK2VoWXV6TjFwVzNxMkpydWNiQURUSmJXMm1iczNpM1ZTMmovQVVm?=
 =?utf-8?B?U1FCRjBSc1hadFdYd2FXTmM4YUFPTCtLdDBCSUo5M2xYVXJRMDY2QmEwdTRN?=
 =?utf-8?B?d3d2bm9sVFFCNThOVDd4NFhQZG1GN2FPVi9ZdDlyRk11aHJucGVrWTYzeVIx?=
 =?utf-8?B?WUxJRExQSWVXZng2bXpkOGlvOUxUSVEza2h4UTJHRXk0b01PRjdJVXVKbEMy?=
 =?utf-8?B?M1laU1k5MXZiS3l6bDUyMUtYeHZrdzVFQjhhemphYTRwSmJUS0E3ODJZaUxu?=
 =?utf-8?B?SGhJRUV0UXdMV3R1clYvTTBJK2VadzFTWktRSm1TZ01jQkNzVXhKQ2JObVFz?=
 =?utf-8?B?YzRuNDAzZmgxUks0dGVEaHJvOVF1Q1Q1OGsrYzFjTWl6bDhRNVR4TS84UmF5?=
 =?utf-8?B?bE95SEhoMWdYRENRay9MQm02a1Y4Wi9Kc1dKSmhtUStHSzk2bE1sOFRiMlJp?=
 =?utf-8?B?azYrTUJ1emFrbU1wQmNlV281NTl4NUErSzA3U3NITXRESVdaMDQ4UDhvWTZr?=
 =?utf-8?B?VTcrUkNtOUJVMTZ1NW9iQnNxckNQQUYxVTJ5ZUxaejFSWjA5T2ZDTkQ2OE9t?=
 =?utf-8?B?NE8zeVBZTW5weVkwNkxLTmNFMTZ1aDNLRVRqMCsrWk5DM2lUTU5CcDlzcExn?=
 =?utf-8?B?NzVpSmJTVkswL3UxWnJwMG5QQXNWbkI0YXBXdFU2dkVRb1p5NXZ0LytDSEwv?=
 =?utf-8?B?bGVCV3NlcTNidFQvZDM0TzNPSWVIN3cvNmNKRFdpbFF3cWNWNHRuNWoxVW9E?=
 =?utf-8?B?YWRpS2N2U2k2UkhYSGc2cHQ5amlKaEVJaXdiZ251Lzd1M3BjYmVLemxTcE5Y?=
 =?utf-8?B?ajArWlphRjV3ZGc5UGk5Y3RXbzhQeU8rMVpwdGpHKzNTRkhmNmZYN3hoUmlq?=
 =?utf-8?B?aktOdks3d1ZnMUhFbDVyRXFmaUtDblJOcExPV3U4Qjc5NlhHNGc2d1QyMm5M?=
 =?utf-8?B?UVM5WHRubGtJN3lHK09IY2Q1TUp5ZDVkcEZvWnliLzdrU0tGanRFUXBNNHM2?=
 =?utf-8?B?ZUJKQzdQTnFPWkxhN2F5ZWtwbWVyclJnQ0NKcVRGOWdMQ3RYb0xZNVZ1akxs?=
 =?utf-8?B?dHRnQ0lYYURpaVVJQ1lRaTdNR1dENWJ3cEVNeFVwdkUrSFlMN29PN3NHUDh0?=
 =?utf-8?B?UFU3Umx3RjVxRktueFFzVUd2U2lNaW9iWUMvdEpHdWV2TTREc1lLSjJrcjdO?=
 =?utf-8?B?NVJwSEtpMjZMVlpGSUZsU1F4OU5YbXNQbmpEd3hmL2NnaHNvY2R5aTMxTThP?=
 =?utf-8?B?RytRNEtBSXlyQVZ2L1crUTY0aWRtQkVWRkV2THhkN3VQWGcxS2Y1VEJnNmt5?=
 =?utf-8?B?WjlsQmJFajAvb0l2bjg0eVVpQWdVVlkyeUcvaHpleFJ3ZkF0NHlEY3dRWnpS?=
 =?utf-8?Q?J9LFrhvTsC9Wl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGJ5WHJ3c05vZ1BIdnhRTW95QnFyVUF5TkVHcWhEazlsR2U3cmpCdVlwaWhn?=
 =?utf-8?B?ZVFjVmxyZEZ4QWxJdkRhdFdsaERhRzR3djdJRE11RTdkRDBqbFB4T2JPSGpv?=
 =?utf-8?B?ZU8zaDMxS2s3amJhb2xLSnNuZEs5Mk9INm0yWGtCWVhTQ2RPaEh4Vk1aa3Vl?=
 =?utf-8?B?T2xIWkNrbk9yNEY3YW40Um1WVTkzcjNBVk9KZlByV3dFYm1wVldxRWQ3QjA5?=
 =?utf-8?B?ZlFTMC82Tm11dmozTExkUVMzcitpaXZsdFJ6UE5jVXAxc3ZSbmVpenRWSTAv?=
 =?utf-8?B?V3pBb0RCT01NNTMyNzFuSkN5R1FCak5VZGxiMTlGa0tJTWRuTDVBNGNFcUxT?=
 =?utf-8?B?dFVFNEh4UUxMb2ZsZHl0aDMrbUlERzlIa0ZrNXl4bVZzUzdGVHhqREErT2Mx?=
 =?utf-8?B?c1RZS0pRS0ozc2JWRG1IVVdySFQ3bitOL2JpR0dydXA0L0s4WE1FOWFTbFd1?=
 =?utf-8?B?Sm5DeWVoTi9uM29wVFpBTXlJbmx0cEtPUm13YXZqNGFsbERVdVZHbi9FYnBt?=
 =?utf-8?B?UUNmWVAzRVlLM3lTMTNQUnhvdjNIREdIWE96cC9jWGtqY01ncGJkTFhkdzIw?=
 =?utf-8?B?WldXUDhjMWNXRXJIVVZZRG1Vc0dwM2FVMXg2NE0xd2FiQkdGNWhZekFkRlFm?=
 =?utf-8?B?a3crYW5rYkFTTitFMyttbllaQWJ3VDFiVS92d2xoWHhnSVo2N0NRWDFwTUND?=
 =?utf-8?B?MUJ0NmJ3c0wyVTdYRFc5d0JLZGdlUFRvMnN1ZC9wZEhiL0RVZTVBNGN0aWlt?=
 =?utf-8?B?dVd4R0UzSFFadW5mQkE2UUlKblR6UURzaFRZMk55dFRXTTVxS0lBMlRERHlo?=
 =?utf-8?B?cW5TTnFSYzdJajQrU0NtenMvV3V4d2dpOVRCNVgwNDcxMGY0Z1h0QWZlbnBT?=
 =?utf-8?B?RmU3b1J5ekpXc1VvVUM3TFZkNWZNRFdSL3MxWVBIYmdnNWhjRXA0UkRwcVZa?=
 =?utf-8?B?V3pBRlJrUktUSktxckVuMWtBRHBFbmgyeW1kaW9mMHdUMVIwYkYrdThydVVD?=
 =?utf-8?B?TXBZOG82d3RtZE1GdnRraWY5bjlDUVhwc1dLbTdJYlpXdnNUNVhzK2VWdHJK?=
 =?utf-8?B?RVNlUTlGQ1NXZVRVaXc5V2lUelQwcDZzNjVYcEFpRjhZeWVteDRtQmlDVGtL?=
 =?utf-8?B?OUVueW11TkNOMHB5RHdwaExkQkNVNkJRUUxUVGVXZ3RUb05ibXJHeXJGNHE4?=
 =?utf-8?B?VC9wNGxRS3JOaFdMOC9XNzZjSVE3bm44aTZMRkVXRWJKU2pPaDZQa1F2QkxR?=
 =?utf-8?B?Mmw4NWt0SEN3eTZ1NFl5UXB5WGIzTEtXN1liUjMrVkFFS2JnQkJqc1JrQWw0?=
 =?utf-8?B?cmJadERTcWxyRWh6UmhzZThjNEhaWjBENWVZdnRsdzNkbFNBRVlVRmlIWTFG?=
 =?utf-8?B?NFJLVjhpQ3ZWTDVQeENEMVg4SGR1R05ZUkxFUDkvZW9RaXovTmE0WHpsekpz?=
 =?utf-8?B?U2xEVnJ1ckxkUlUwRlJteEhYbHV3Qisya3cyTEpudnMrQTJFQTN4dzUrRzM2?=
 =?utf-8?B?Zm0vRk51Z2pLbUNiRDgvWkZzczRXNkFuSkpSZUJIcHdVd2JpV2t6T29DVEtQ?=
 =?utf-8?B?c1NOQWlMb3BaUzR4UWhCNFduKzF3cmJHTlIxU3V4U0VBamtGakdlWlkrRU9K?=
 =?utf-8?B?SlpkdWc0VE82d0NHQVlrZEhTUDI3RXJrN0V1RmtWRW85emhjWHhkcUNtQTAx?=
 =?utf-8?B?OUpneThvd3dRcUYyTGdsOHBCcmovL1daZjlZV0ZzdEhQdVl5VFBIV3JYNzda?=
 =?utf-8?B?WVd4ZU1RR2VEamZnOUZuR29TQk5yVHRLemRVK1VYdmRuV0xPOCtBWXcydzlZ?=
 =?utf-8?B?Umpmb3ZUOXVSYWJYNjZSVXR6VkJnendETVduU2hzejVEODRQSldHQzhjSEJk?=
 =?utf-8?B?RmRxdis0RUQvcnIzU0pGL1BPeHZIRklaTjRzM2FUZjBLTHZ1dkYrL1RXYXdm?=
 =?utf-8?B?R0ZybDRHRmZZd2Y1ZnVyUWRuRWtOQjNGQmNxb3RuRUlJNUx1OGU5L24zN3Rs?=
 =?utf-8?B?SExkRE9GMldES01zb1UxcllKWXpaU1BuSHVqVEJpNmM3M3dlUjlEc0dkK0lY?=
 =?utf-8?B?MzRVSjFHY2h3VmpsVkdiK3lEWkorNUZDMTcxS3Q1WmMzMjlZVmVOZkhJN3Zk?=
 =?utf-8?B?cWhUM1VDMWNSUFRoNWIzWmhJVkFub0IvVlcxcXdZYUYrdklpOVFTZU1kdUtD?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bf591f-f173-472c-8185-08dd776af199
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:32:16.1811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4+NKP0bdyavXKiKOxHmGI5cR80YsrjiNY2el/m8yQSTiEjRSPTBRocbLRtw4HqwSeVfw0nlSxNO2AYfu63JnDTvq1Hn9w1yhOCEyzB64tA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9551
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

Hi Simon,

On 4/9/25 3:22 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Wed, 9 Apr 2025 at 04:57, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Jonas, Simon,
>>
>> On 3/29/25 4:06 PM, Jonas Karlman wrote:
>>> From: Simon Glass <sjg@chromium.org>
>>>
>>> The simple-bin image is normally written to MMC media at block 64, which
>>> is a 32K offset from start of storage media.
>>>
>>> Set the skip-at-start property to 0x8000 (32 KiB) so that fdtmap and
>>> other embedded binman symbols in the output binary is referencing image
>>> offsets correctly.
>>>
>>
>> Shouldn't we have this commit BEFORE we add the `fdtmap` node since we
>> know it's wrong before this commit?
>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> Changes in v4:
>>> - Drop defconfig changes
>>> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
>>>
>>> Changes in v2:
>>> - Move this patch to the end of the series
>>> - Drop 0x8000 offset for SPI
>>> ---
>>>    arch/arm/dts/rockchip-u-boot.dtsi | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
>>> index fb38b7b80c43..65b81bf58626 100644
>>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
>>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
>>> @@ -154,6 +154,7 @@
>>>        simple-bin {
>>>                filename = "u-boot-rockchip.bin";
>>>                pad-byte = <0xff>;
>>> +             skip-at-start = <0x8000>;
>>>
>>>                mkimage {
>>>                        filename = "idbloader.img";
>>> @@ -178,7 +179,7 @@
>>>    #else
>>>                u-boot-img {
>>>    #endif
>>> -                     offset = <CONFIG_SPL_PAD_TO>;
>>> +                     offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
>>
>> This is confusing. The documentation states:
>>
>> """
>> offset:
>>       This sets the offset of an entry within the image or section containing
>>       it.
>> """
>>
>> My understanding is that it should be relative to the beginning of the
>> image but this now needs the knowledge of where it will be stored on the
>> MMC device (via the value in skip-at-start).
>>
>> Why is skip-at-start automatically deducted from offset?
> 
> This is how binman works[1]. We are trying to use the feature designs

Why is it deducted?

Cheers,
Quentin
