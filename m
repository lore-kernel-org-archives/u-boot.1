Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1838CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 09:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16B5083700;
	Thu, 14 Aug 2025 11:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="FLTbtlq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7BE18380E; Thu, 14 Aug 2025 11:11:17 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A10E8309A
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXPGEZovEuJqovWpuh26GMJ19OAWnF/wJJuDKbrwiaTC/w3C8idRhWE+jtK7rL0BIFUEWoGTS377hdGbD9I+WDe5rjeHB0zB3SIIp+NWzgIeoCKBeVIXc0ZEZuYsQKZRPh7wP6xcKUun+AILIxIOZnFFWMTRza7qjAv9GErdmAFSLCMzIyDVSGHDJhCyIXsUHWLlCcmuQQFMUX+pN+AJ19ODDcA6i2InhPEi7PwaebBA5WcLeHnzCr4cojOfP2DMeVH/r8Qg7A8C1CCtSGf6OdeaGDFUb+1WQLLUMGQtxCJzl2L/Um63+lKY4FFyG9C7FVJtw1UERMprmh4vkMjTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYmKpUEsPPguMA1yxd0uveAK1Jo/HSLAhLnZuuI0LTU=;
 b=u0Z3gxs9YA+WBzmADNXb2B+g06F0MANbpZJYfvuIKu984+kZ1XoEvyobDGeH591JnO5nsV2OUc6zwiwtFgD3EDyY37hWCfycRJQ2FcXSJyoqbyJlcNmE4e2gmDhLXvnIBdsz02NT3Sq9iudqVIiU6hss018D+9xEigK5weRWU75WCDYcL98L0Ce5M+1Okmqup9bUgf8nSqjRtzAUopxgTEhrXOGL+7sIxwfEEKDaWM+btV6WO6yY7ZGj1XkqOXjirFSZbudnsz0Dx6zwtfh//GYtHnjt1A3LYWDejSBfk+hNsOdTVLKOR9cweAyDTUYOjm2nq022GIfTCxe42+bHIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYmKpUEsPPguMA1yxd0uveAK1Jo/HSLAhLnZuuI0LTU=;
 b=FLTbtlq2G4feKXwZaZUAsatVxg4Qqmdq3Ai6qgansbJ4wxQ9TMmo3BUNivd3o1FQBWAaXg4QlWFSKNuZLxUcYeDqM8xR9XyO5b2+M53yEtb2MCzZdha2Y7kUEPT+sroC7TmQP1XgomQ1fTcLmw74Vw+VYwN/PVxEq43NKo1+Wy81iihy0KXYhkBbOAOndwMVwbFbYeUtMR/PPryCLvLKcWUnGyFg3S6N8WyEw4qurTHxfOvdgv0a1sMxz0iV/EXLcQuV7PUOnlPjlgfXzDGgkGaLGieNU74BCYP78QOm2k9DCMvwzGxYmwpk9G4ey45P9oONGJLH3PSa3EEphWHemA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 09:11:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 09:11:12 +0000
Message-ID: <cdfbaad3-e9ed-4678-9a65-c3561537d600@siemens.com>
Date: Thu, 14 Aug 2025 11:11:09 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: CONFIG_SYS_EARLY_PCI_INIT for PCI-attached eMMC
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b55c0a3-58df-4bbf-cc88-08dddb1283c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWZRcDUzWDZsV0dlbmJTejRIdEtqUXVvV1pPbkhkZStFWTBmV2ZFZG5KUmdH?=
 =?utf-8?B?QklWbmVtUVgyYzRWTFJlUjB5d3YrRlB6N0Q3V3N2alpHM2UzQm9IM0NrRXE5?=
 =?utf-8?B?bXJUVnVhYjJvYUJTcXFNSWdrUkJEVU5pU1kwZEZEK1RCRERvclJMY2JsanMr?=
 =?utf-8?B?TUVDdkptWnE0TnVMSkxGOW5WVHJ6Tm16RUNhZUFOMkhaNHhRL3Q3OWd2ZVQ0?=
 =?utf-8?B?aTFsSUJOTVo3RjdXS2swQ2x2d2pmT1liOG1lcE9DcHZ4a2oxd1FIZHlnZzVy?=
 =?utf-8?B?elRuQWJuR1I0S21yMGxyUFlYTm9GZ2U5Y3U2YzFsZ3d0WjI5S3E0Q0tjVE5l?=
 =?utf-8?B?aVBLRE5yY0RXZVdsVU9lM2xiUk1EL2Q3ZHdaSnNMNlhHdW00Y1RoM0E1OTN0?=
 =?utf-8?B?VTJvcm9hYjJHcDlRdkRKbFR1VXYwQm1RVFhHZ2VIMVJ6V0RxN2w0QkNZRTk1?=
 =?utf-8?B?ejdOT1RiZUZabjlvbTY1S0h6akdkelU4cGN1emRQdVZPNWFHdFpOSDdOZitm?=
 =?utf-8?B?SGpJODhZMjhhOXhXZ0pNTlh0aDd1d05YT3c5MXg2SkhBQnhRKzloYW9tS3Nh?=
 =?utf-8?B?ZU1mMTI1MjJkNWxYMVlNRjYzUUxJYm9FZ21mVGxoaENveklkamNmaUhQRWUx?=
 =?utf-8?B?ZG9OZWlMRXZIZnIzV1dWbHVKSDhkOHhqOVIxWEQ4aUYwT2hucVFsdGZJZkpR?=
 =?utf-8?B?eHFSNE5GR1oxUHpJeXljVW5tRkJ3T2kxdWMrN3FxQ21pR1JKSnB6VXk5UlJt?=
 =?utf-8?B?eUpPcEVWOUl2RDdjNFJMb0RVb04vbzAydS9vQ3pDUFVremJBOXd5RklyTFc1?=
 =?utf-8?B?YkU0TjdsVHpBRTRXbFc0TkhKbWpoRWZJMHRFenQzblJEbmgwS1N1YXFoZFc5?=
 =?utf-8?B?ZHdnMklodHJxMVdFWVV1UXc1YmpPTFI5OW5NYnJyTFkxOHViOHE1d0VRVW9z?=
 =?utf-8?B?d1JsTkZmRXVCb0J2Slk5TGV1a01jOEplSkl6c1FLUGhSaDc2L1VmSmkvRGYr?=
 =?utf-8?B?cGllL2x5L2tzNFc3b1pvNVVpeEZ2S0todzFjb2ZqdUpGc1BHbTNGNU92NWV5?=
 =?utf-8?B?RU5ZeTFJYzIyeVdQQ0FtYjlLc0xvK1Exc0RIdkpkR21BOFllSXYxVTdpSi9h?=
 =?utf-8?B?UDV6WFFrRkJnZHkyNklIdXpuRjhxWDNUV25HUWNqRFIwN0w0cTRUdWU2SnYv?=
 =?utf-8?B?ak52QUtySS9kbTNkUjJpemt0c3ZxM2NkMVlTczA0aVlqRVJXTGNzOWZOT293?=
 =?utf-8?B?djUzS1dLTnJmbXJWSjNjVkRCN2lMY3pGR2VPaHlPS1BCY2hNRW1LTzJ5L1Y5?=
 =?utf-8?B?MWdTWHlTVkZab1RLQnFaY01VNldyaURTOXBhNEdUay9Md25OSDBNT2ZTb21F?=
 =?utf-8?B?Zys3WFdBYXRsc1lCa1orYXBhYjdVWEtscmhNSzhmaXNNUndvV3JrUVVCaXpW?=
 =?utf-8?B?R2JWYXdjc1lBWmVXdFh0U2NhZnJkRk14U1JFTmJNb3oweUljQjZQUVhFNm9p?=
 =?utf-8?B?dUdpazFIUC9OQ2xCYU9mUnUxdjdZWWFHbFdIb3dvL29aR1NmTmRuS0NkN1Rz?=
 =?utf-8?B?bE02NDVXMGpOcUpXZ0RsRHZXQ2FPSzIvaDU4REZwTkY0R1ZDWk5qbnp3T3V4?=
 =?utf-8?B?NU9EWWdZTGlIQWt4VlhGS0JDUTN1Zy85eVJOdEE5RGhqUHJKT3pZQnRlc3Yr?=
 =?utf-8?B?SmlrT2lSRi81dlpyZHNLRnZjZDZWN1Y2cjczMVBaTHltVHVaK0RFUzFuS1V5?=
 =?utf-8?B?K3E3R0JaL3F5V2NpZTU5NitiQWhoOXN0THRhMmYwekpuQ3YyNnNiNjFSaGZL?=
 =?utf-8?B?V01TSFIraURaRjVlaFNjNW1UVEswZE9ITjE0OTVoQUJYKzVsb2E1WVBqT29h?=
 =?utf-8?B?ZnNvY0NnRDluZEtLdkt4cHdFaE5YTG1iTzQ0cGlpTXRnSTdTYzhWK2dFRm1X?=
 =?utf-8?Q?SsgMrtxMjHc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFFrQnEzbUg2cUozWVdsRHJyaFZtV2VIVEM2SHBWT1IzS3NuMGR1YVg2UmdJ?=
 =?utf-8?B?V2Fhb2lIbjUwb1dYdldTMHdVMHZxZFFFOUhkNkRaMUFOS3NBNHplbm5iOW9k?=
 =?utf-8?B?WHVmWjVjem1LRnFsYTY4QysvcFFic3JmcVhqaTRoWU5xRjBkd3BxeVE0cUhG?=
 =?utf-8?B?R0tvS2ZoYnNwdHJ5dERXQ01CY1ZWRXJVUkw0Um8vNmFsR2lmZmNtWnhEKzF2?=
 =?utf-8?B?ZjhmcjdXUXRtTlJzZU16L3BSVEJtN1U3UnM1c2V4T2ZKNjBYSmw1VE5wcGFn?=
 =?utf-8?B?QnJJbTQ0bmYzNmJxTEZHRHJZZVQ5ME9JL1hYaG1UMjRoSW9kVDVwd1oxeUpM?=
 =?utf-8?B?eVJRa0dxVVBnVjBHMWh0ekJZSDBmSUowRFU4WmhYYjR4SHlQeW9jWGl2T0hS?=
 =?utf-8?B?aUl4UFBRZTVndDFLbW51YjNIZlBIc0g4cno1UXU4NFh5cldPY3FhNUVmLzhq?=
 =?utf-8?B?QVNYRHVOQ1JjOUJrbFRRdytrM2JmaFp1SmpLRit5QkIwOWZUV1R3QlIxd0dv?=
 =?utf-8?B?MHVWaGFLLzhaRkxHdXdkdmZKWU9MS3N4eUsvTEgrVUtzajEzMU4xUkplK3Mz?=
 =?utf-8?B?TFQ5OUw1clBPMUJYWDRtM1d3TnlVczlCZlZqc0svN1BuUjI1ZGlzQ3hsaS95?=
 =?utf-8?B?bmVqOEhFL1FweERWT0g1dTlmSnRJVHpzdTg1K09kRzQzamxNMGlJcmF3T3pu?=
 =?utf-8?B?VE1rYkN5WWZXbTZHaW03RXdlZDZxRGZvc1BEQVE3QWpEY3YzcVlLQ2gydFAr?=
 =?utf-8?B?ZjJsaS9KU21mV2lEUGpOS1lpSVhidHB5T0RBR2hiNVQ1NUJ3WnJ1RC80Ykl4?=
 =?utf-8?B?dnlRWGtzbktDaStMcWd0MXlmWjYzR0xqVTBFTnduYzQ3R1Z3NjM2bnlWYStx?=
 =?utf-8?B?QWxkWlRIbHE0MVk4RHVRb1JYZWZLWnJlUGFVWFR4VVRRSG1KTlpYVTc4STRn?=
 =?utf-8?B?cUU4ZDBtN0JZYnBkRU1WaWJCVGhqWFlXT0ppNlBOZDhQNTFzd28zVEY5RDRt?=
 =?utf-8?B?K1NPTWxCK1VOdDFmb3J4eW0xemI4Qm9Hb1JBVmlEVk01alU4UzBUSm12a3Qw?=
 =?utf-8?B?ZWJmaXBqaHo4Vjg5SkZEQlVId0MrcVpaTU9Zck1rYjRVOUNUcm9TM1ZQbFZh?=
 =?utf-8?B?RVB4SVZWSkVpSzU1L0Izc3U5ZDczTGQzeUdyaTBDZ25tQVNXdlNBVHIrYURZ?=
 =?utf-8?B?cFhUUDdSRWxmeTd1K0Q1M3FBeTJsN3NmQXkwbzlmSllTbjF2UXpmZVJXcE8v?=
 =?utf-8?B?N3RHbG4zczl0ckRNWGoxcnJWVFhrTlVjM3c4OU9aWVA2K2NDMDhpOURjMTZK?=
 =?utf-8?B?R0t0TVFzb3VIQ2dVZnQydnFJNE9Dd1pTUXpDQVFxM3lvbWVsZ2E1M0tKdTFi?=
 =?utf-8?B?clUzSEJtTXNuU0FhTFJ4NDhTZHZzVUNRdjAwbWdqY1drNzh6ZXg1MzgxWE01?=
 =?utf-8?B?NlN5Mm4rRk5zQkZpczdJOWx2dEpFQXB4U0Vrc3J3VURkVUFHTHpXcy9BMUNq?=
 =?utf-8?B?MDAzdmtwaHF4bUdPTjhPMGdoVkFPYnNmcDl4bWxsV3hRZjUydGdBT2Naajdw?=
 =?utf-8?B?VWE2Y3hQZm9valJsS0xQK2dOa2dSSGo2RVp0cEVuNjlNa3Z3RW9FbXpZV0xn?=
 =?utf-8?B?dzl3YkZ3N3hUL05CSXZRU2UyVFJSR2svZXpaOW9BbGhzREtvUHpGaGZaWFhT?=
 =?utf-8?B?OWZDMVNZR1dJckxFcmY4d1F6WjE4dVVpUEtnejhEVXRJT0txcjdXOTFUOHpZ?=
 =?utf-8?B?Nm15YXRzNFF1VUlMaktHell4MVFtQnJBdmoxYTlGd0ZiY3gxVDdieVA4RGVY?=
 =?utf-8?B?U0VCdHkxMEVmYzBWVmVOdGhJUXNyWG56RFg0MXVBRFdUQm95NGl3OHo3ZENT?=
 =?utf-8?B?cnAxVnVHUklyWm5tdlM5T3hJcFp2VlRNZzhiRUE2Z2lsMnFnK0ovMXR2NkhW?=
 =?utf-8?B?TDJTMVNIRDFlQmw4ODd4a1ovalRvcXpNR0dOdzNHbGZvckpNZmNrc2xtK1ht?=
 =?utf-8?B?dnhpaDNFSlpGdWc3NFNqNnA3V05QZERRNHVISGFROFV2TWtESkgwbVBmQ3Za?=
 =?utf-8?B?MTNHOHNObWRKTjJ4NFdWY1MzQ3dra0pKSWpkdTJ4aWQxR0xkZEc4ZHdDODVt?=
 =?utf-8?Q?gTO9tswq0ssuyPbmdMIZbebrp?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b55c0a3-58df-4bbf-cc88-08dddb1283c0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 09:11:12.4952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cluz64ktTFel1agrIqOs/hQ25kLkers9kNpNRgH/apvQGNLRzCXnZGIOMIMFq92/miv95/qC17R1VrTfZuUzhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6024
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

Hi all,

I'm currently playing with eMMC emulation for qemu-system-aarch64 -M
virt and will likely propose upstream to allow user-instantiate emmc
devices (-> -device sdhci-pci -device emmc).

To make U-Boot recognize such a setup, I currently need this:

diff --git a/include/configs/qemu-arm.h b/include/configs/qemu-arm.h
index e296f398798..4e22aa36fa6 100644
--- a/include/configs/qemu-arm.h
+++ b/include/configs/qemu-arm.h
@@ -11,4 +11,6 @@

 /* For timer, QEMU emulates an ARMv7/ARMv8 architected timer */

+#define CONFIG_SYS_EARLY_PCI_INIT	1
+
 #endif /* __CONFIG_H */

Is this the right way to achieve? Then a patch for U-Boot would follow
as well.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

