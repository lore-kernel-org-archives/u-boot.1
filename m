Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D49DD2E00A
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 04:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5603D892B8;
	Wed, 23 Oct 2024 06:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="0BOottL+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC7E8892DB; Wed, 23 Oct 2024 06:14:07 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C314188A4C
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9+D+J+WdviXIzyI9lJDThW7eJ9aQxRPFx0PLx/tOMauYMMUutEDcyczi2E/zedX4hYitcwP8w8VhcjBipGQpHOIIfRops+NI8vsQpi7kgjijdgcIdpCE6I18kkKYL4HFjGTyYWH1VIHxq67trE3Xb1xVi3dXkS3mtfS3/0XJZh8Zi21VkdpofKBdKVzQBlCrIleM5kaOEytdTIvMvcd1qJMLT4VILPEzBiCSnXAI99GUEMrh0QXb1kZvqHl3dmefwMqu/nifPi08bJFd6cwRbW2KpnCSKjpSGhzSerUtJLns9lLLOM8PALrs9EjRPpVzU3+L3neDk2R0k7eiEsqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8VtQ9WrxOV03vYQZteDBJsb8TDTepYrcMJUXyuXYBs=;
 b=hgVF//l0hhF+QYy0xOLWEE+CnlhRzb7draThzSb8x3vKJ4PF7nLVdsRGE/mWiwyQxwzDljOmUwHInK+AjJarq3S7QESE9T3yYSyGzYRJwEWVp/t4zIU4ZbE95hWlJXEkKbl32aE843ugST4YFuacWvtU+EYptdpVw0g5ouRm2LEGZXOGNa5bDSFTD2CfNGkNqoUZov/e/EQx0MMlYS4ORG91ttXn9UOllo6UhmsCv0/lEuiy/GifEwEIUdugnpy1NSwTo+vmDhLcFL7pe1ymhQYxliPcL4UQdhlQQaLa1Lo+8YJhLjFQC8/MKOR2/0ANVpio9NV5sMBjKnZuBfR2Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8VtQ9WrxOV03vYQZteDBJsb8TDTepYrcMJUXyuXYBs=;
 b=0BOottL+m/V4VlhdcxWsp+VD928BRsAuczIzxAMdrAhZGx3t51UvT6PJboTMcyg79U/736IiqgZgJo7lOWELSz7rpkCWLYZVQc1eAR0vD5Z2158IiUUHxzMdMP0oZ5UT4fX1arL/0pOD8PJg+q6vRa62jpdaoQy356uxRg4Mv3J6fi00aMdP5dDk5yuxLfQYJDU90L7bRfBpSrnOrUDXUZ6/fgh+K52CxcJdXtnF4jxXJvFsbIlekiP6pkXqfSa+ON6yHoSZFTdO4WKgSNHTP439n0whmKwXlMY5uTNyNn/H/Yri8t+Wl4hqZUofyV9GFahq5ezYa9Z77M+O8uLQ0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB7959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 04:14:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 04:14:02 +0000
Message-ID: <6bdd212e-2a70-4c32-a463-c83cbf7bd0c7@siemens.com>
Date: Wed, 23 Oct 2024 06:14:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] smbios: Fill UUID from sysinfo when available
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>,
 "Li, Hua Qian (DI FA CTR IPC CN PRC4)" <huaqian.li@siemens.com>
References: <cover.1729577070.git.jan.kiszka@siemens.com>
 <9e440edc2a6bdcb7d768d277dd6afb02ab941ecd.1729577070.git.jan.kiszka@siemens.com>
 <CAFLszTitiTcf6HF_3FAxreBDOw8CFSekf_MHEzPcqwzj+b+bPA@mail.gmail.com>
 <a7031021-c8b9-4bbd-8089-c35a4d4e7ee4@siemens.com>
 <CAFLszTjxD+DjGYUd+o3mELCctOnJZO6U6FSkSjr1su7iVTcmpg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLszTjxD+DjGYUd+o3mELCctOnJZO6U6FSkSjr1su7iVTcmpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 688daf06-af75-40f1-3264-08dcf319202b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0RLSEdhNkRwQ29OWjlMUmdRVlN0ejBLbVZaZE5nV21ZZTBkTytmbCt1M0p3?=
 =?utf-8?B?Q2tHUlVYbW1OWGJKK2FhczJQdDNGb3ZTZDdQWFRXalRpenJmR0FpR2ZSRjVB?=
 =?utf-8?B?VUp6NFVYZW9XMlErZ2RndFM3OWUxeEJZM1lnM1czRUpvWU9naDlyd3Y4RG1m?=
 =?utf-8?B?M2h2R1hRdkFCeGlJOEcyN1ROd0JLZkV2UTlXNkRlTXNITWd3MXRFWGJOQ0lO?=
 =?utf-8?B?a25WMG42OGtxNWlSb0NuTWhXcDlvMjNyUmZTaWJmMFFiWFpyd3lXZ1ZxUHJZ?=
 =?utf-8?B?R3Awc3RCK2R4TTRxZTh0cVJPaEpHOXU5dkx2dkpzTjZVdXV5TnZxcWZmd0lv?=
 =?utf-8?B?Wk5HTXRaQ092R0tJUmhCZmE2WTFUVEp0NkRiZkFJNnhvaTlCRzAreDVmVVlm?=
 =?utf-8?B?eC9WNHF0cmhFT1lJNXpBRVFlbnJJV0ZabnNsaUJocmszOFlsMDZjdW5pMENI?=
 =?utf-8?B?Q3lWcEM5Z1RMaGlvSXYwWWs3MkVuNzdUUkRrN1JWQVl1T2M2ampZcUMrUnhs?=
 =?utf-8?B?QU11enk2UGNsZnAyZjhob3A0Qmc0eWh2WlFiYjkrNFozSDNXSWZmZXd5S1JC?=
 =?utf-8?B?Y1YyWE5STEgzdnFVUUVCN2dZNmdZdE9mTGp0THphSHlZU2t2dmJxR0FxcEh6?=
 =?utf-8?B?c2pnUEJNL1d5VkVwZmV4c1lTdmVFU3hGTEtmQmhhYTlJVllUSmNuZTJ6TzQ4?=
 =?utf-8?B?djVlNnZBQVlVSzNtNmpRMTBXVFM5Mm8rZjl3akl4Rzg0VThmMVFxTkVkK3JM?=
 =?utf-8?B?Z1dNLzZwakpaRU96alo3T202dlVzWHgrTmpQdVh6OHI0U0JqUW1VWjJONDcz?=
 =?utf-8?B?ZHhJQ0NLRG5qbkZPTTcyZStLYWE1UGxrS3hOL0dtOGZnTWdSUUhRaVNZOStK?=
 =?utf-8?B?WnFhc2dnVzhBb3YrY1pHb0tXRmdlNXpwV2gvV2JOb3BHUHpXTUlEdkhMT2Vh?=
 =?utf-8?B?Q0FJb0tSaEgvMHFmL2NoQ3lOQnpNYUQrc004ZUhrNnc1dzZXd1NWS2ZHbE9h?=
 =?utf-8?B?UXdjK3AveEVoM0FlRDlZY2VKZ251NDNsMDNLYUh1OVBWR1RoS3UxbXdQZXM4?=
 =?utf-8?B?VlVMNWtTelJMUWl1dU5MYXBDa2I1OVhsaHVBSEpTT3FiLzZZYWhDVWIxUnJm?=
 =?utf-8?B?T0Y2RVNKTGlxV0FPc0pLNHpFQlU4c0xBS2hFNlIwNUZ6azJxcnZ1ZXdxUE1I?=
 =?utf-8?B?NCsxekVzMDNGZFJHSmdaZEhUNTJuS0JIMkxLM2syZTRkdjhUQkRFUExNdjJM?=
 =?utf-8?B?NnFhUDlnNzB3RXFZb0NLWGxqME5oQUlFLzhZOW5wMktuK2RGL3JHSC9NNWZa?=
 =?utf-8?B?YnZjeXpzUysxdGcxSytEdFRiamNBYlQ0NVVvTkhDRGYzN0ZRTXJ3cWxFWnZ6?=
 =?utf-8?B?OFY3N1pDREp1d2dsam5NQWloS3VHSGU5SHRkbjl4NFVyeHgxMHlpai9WZ216?=
 =?utf-8?B?eG1OaFdCYjNRTHEyZ2JxNW5xZXFBOFJyY0oycHlyUWs2VUxTRnVWRUt0QUVN?=
 =?utf-8?B?S1VLL3JyWjdnY2R1VlNFeUxiT2swR3VQWUFXWE05ZTBGanBSeGlkVTl4TmV3?=
 =?utf-8?B?VVhqbmt6Ujd5V1lmMXlKTWQySDhZQkNhYXUyNFgzWVV4Y0kvTDUxTTE4Z0Ja?=
 =?utf-8?B?TmFqWk1EZlUvclBJa3oyalJJcGhVYkdwMFpJZkNmbU4raHFSY0NsR2RoSDR3?=
 =?utf-8?B?VnZvem5rWm9IWmxlbzdMTllvN2dEZDNjVE1CanM0c0tHdU5KbDZmQy9pMXdn?=
 =?utf-8?Q?C0pvkUgvpcxdy/ohuOex5rhejio3CNB4jjhdpQf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXFXUkVFbk9EblRiWTFqdjUxZ1BkWmhKOWZjbDViUHJpNktpcloxWlhjdk9K?=
 =?utf-8?B?blRwY205eUlzcm44d0gxMysvWFlYVUhPUTRIMDEvWFFxUzJxZm1GZXlXMFk1?=
 =?utf-8?B?alZ1L2h2djlBK0JmNzhGbGFZVU1IVTQrSXZFMjlNQ3dTbGNhTm5idWtKdmF2?=
 =?utf-8?B?dlhHc3oxb05xSDd1M0tTV2Zlc2w5ZFNMaVhkbHdEcHBwOUdjM1lZV3dQQnV6?=
 =?utf-8?B?azMwSm5GVVp4ZHdXS0xsN0ZyQ1puYVgxR1RQRXVpN0pNWUZYTkp2RWdFbFNh?=
 =?utf-8?B?OG5hTXdhd2tBNTY4Z1YwV2VuQU5lMlRMVVloTHVDcFlUQ29HdlFqWFUwWU1K?=
 =?utf-8?B?blhyNjJZWmtqVnJxZHc4bW9ZRlR4eU1ENlppbE54UnJHSlVzejk1MzkzN1Ux?=
 =?utf-8?B?VU43b1JBcFNLb3pCUDhPQ3RGMGcrckZ4TDlHZXpWM3lVQ2ZTVDduOUFLck5s?=
 =?utf-8?B?V0ZQK0tSb3p2dkdhRHF2dWNRYVc1RzdEUW45eXFucit6eGsydEV5Tk95cGVX?=
 =?utf-8?B?V25IOVFEVDMvR2g1MHpYZzJxRDNtNVhCN0JnUitNb1lkVGVUSWNkR3lOdEF6?=
 =?utf-8?B?dXc0VUk5TWJaTGZ4cDJ2NEVjQ0FzeTVWTy9NN2c3QTUzSFIxYTg1Mm5rTnRO?=
 =?utf-8?B?YnpDZ0V6UFU4SEpiUThKekdwRHYwdXFRZ05pWXh5dUphbFJuUUtWcTBwU2hK?=
 =?utf-8?B?d0I1YUl4citrLy9sYU9iYkdqMTRNd3cwdTJEVGM2Y25zOWd1S0JYR2Z0eXZY?=
 =?utf-8?B?OTRWVkxPRXpwRGJXM0RZSy9EdVg5R2d4NGRnZ3ZabUVRc0E0amF0RGcvYmFw?=
 =?utf-8?B?bXFqZ2Q0VGcrUWF1ZklPMkQ1SFluQmh5N3YxUEFiVERNTG9HK2tuWjA0blhG?=
 =?utf-8?B?YXJhUmlxL0NpbGJTTExVSDFzaXpRNkFpZjNJdGE4cWxvbitMZmkwa1NTbGVS?=
 =?utf-8?B?MDFLL1U2U0dsSWE5VnpNOXNZVDBPeW1PTEZxTmZ0VUVVS0ZySWwrMDErNkdO?=
 =?utf-8?B?VXRDVzk4RWVIbGdoTk9uUWRJRG9ReGJHQVN4OGo3OFVvVWw3Wmg1RlVDVjBD?=
 =?utf-8?B?MnRxbFRQM05mT3l5dU5ydWlxRmh6Tk1GTjJLOEVHNExZSDR2MFJTcG9WZzAv?=
 =?utf-8?B?Y2YzNjNoWkdHMzVpOTVTMlhiTVlsUVBtYUpOZTJOb0dOaDFFcTEzY0ljdlpr?=
 =?utf-8?B?MjdhL2RRZTlMcE1ydjVVdkhaVngyR2NacHg4ZkFQV0FwVVRROVI2bHVmMGwr?=
 =?utf-8?B?dy9RbDBGZ1pYU2MyQVdCbDdabG5laTgrUmU2YXV2bU9qQTRycnJjV0ZBUjlp?=
 =?utf-8?B?WDZhR21mdDd2Z0VpTnRvUG9Td21yWlJrQjFXZU52TWdQWjhRaTNVQUxZdzlK?=
 =?utf-8?B?cVF6UjBvdDRjc2QzVXNXeFVnREpQeEJ4aWo3dGN6ZjR0YlQxeHRaT2JrUmdr?=
 =?utf-8?B?ejRKOVVsbUFsMmJYczZ4R29wRElZNXdzVWpJWEplbUJEMUVJWmE5S0FYVjM5?=
 =?utf-8?B?My9reHZhd1o5amZ1UkhIR1BtMmFCRE9tVW1wZGVxOHYzK2xlMk9vckhjZ0lu?=
 =?utf-8?B?UThCYzBaVEhqQ1hHc3pZRWYweHJKcFo2MEx0ajlLd2NSakxUTFRkRnZNMGJU?=
 =?utf-8?B?UG1FdVllaGFhWjRWRHZBeHFJQVNTeTNqWTZ4WkM4eDgrK2VDYlBGRXMvWitI?=
 =?utf-8?B?UnZhdndjc1IyU2VFRHU4NWhtaUR6R3pzOWRyOFI0VThwNUx2KzYwUVlLekpO?=
 =?utf-8?B?MkZMcGxuVHYrdndlNkY2cDVlWU9uOXN6MHlRNCtaRzhwZ0x1RzdObWhjOHNh?=
 =?utf-8?B?b1dsZzBDNWlBL2VGNFg5ZDN0Q3BEdWFxTXhTaGlPemtGdG52NWNjZ0FoU1hk?=
 =?utf-8?B?VGJia2QrTXl2S0JvRXUrMUpQcnpjMlRXNWpyYWZrNlZFenNlQ0V3TlBUWjhn?=
 =?utf-8?B?WkxoaEVTY2NsRjFHWG95UnRpcEhTZTFXb3BOZGVQWHl3NnNJbmtYTWVZaFRy?=
 =?utf-8?B?NlF3RXdNRzh6Z0NubFJQRllMUFlPcjlrVENhZ1ZPaGVsVnE5NU13VFlTVW5I?=
 =?utf-8?B?NmR2VVlaTjhTWXdyRFY2dnlIK1dEMExiQ1YrbGFJdldzcjZLdnFFaEE5RFpx?=
 =?utf-8?Q?YFwarCxnYlqlWNvYkJb7CX4TA?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688daf06-af75-40f1-3264-08dcf319202b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:14:02.0371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znCg8NPBUO+xqAEfp9tY7TkufId7I7I/HueMT9kjAzlc7hwIUZgwXDYApIs1o557h6dAXaysEnTBGrcT3QhoTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7959
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

On 23.10.24 05:39, Simon Glass wrote:
> Hi Jan,
> 
> On Tue, 22 Oct 2024 at 21:41, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 22.10.24 19:00, Simon Glass wrote:
>>> On Tue, 22 Oct 2024 at 08:06, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Allow for the sysinfo drivers to provide a system UUID to SMBIOS. Will
>>>> be first used by the IOT2050 boards.
>>>>
>>>> Based on original patch by Li Hua Qian.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>  include/sysinfo.h | 1 +
>>>>  lib/smbios.c      | 4 ++++
>>>>  2 files changed, 5 insertions(+)
>>>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>
>>> What is this used for? Would you mind adding a comment for it? Should
>>> mention that it is a struct uuid
>>>
>>
>> What exactly is unclear here? The System UUID is a part of the SMBIOS
>> spec that U-Boot just ignored so far.
> 
> OK, well that just mention that, along with the data type.
> 

Now that I look at your data type comment again: It's actually not ok to
misuse sysinfo_get_str for transporting this. The UUID is not converted
into a string by the driver, it is rather returned raw and may even
terminate prematurely if containing some zero. We need a new
sysinfo_get_bin or raw op.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
