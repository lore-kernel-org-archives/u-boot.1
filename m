Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F165AC27C55
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A96B884FB;
	Thu,  6 Jun 2024 18:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="a91QmcHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C27788247; Thu,  6 Jun 2024 15:32:25 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB2D28752A
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 15:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0mF0UL2i2L88spTL4Fdj/eGANDfhbBCeJh1QC+F4EnuH3mO+u6dATMjQ2sgUg2ci8V6+G7k6aZlYhXd0qbJwVAraAW11tUvv2Myg5gHj6SYSl5hsyKJNX6s+C3TjCyrEZ6RqES1RNoa5a7WhPuhGxYHvnYtOFS2JQFb5m0FUiqPLe4CMYXrMlmqoky6pSZPoGs+0qNaK1+VVPs1E9LvtlQS8VNgFiaSHrf9SXYSazKK1HqMqfHdSz+XUNyNOvTS1iG0vt4vDUjDNSbb+Di+nEG4vhEMwaY4TYjnma7YgXlnpGIXzklJHTclxlrLLsIGXxJZ2ep5pNrirCVT4tH61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnWkaBMQ0Vmc7cPL9Hs4AdMWXwb2x5dyvc9fzfrQZWE=;
 b=NOT1NL4xNO/ET5XT7Swa/B2r9EhtgITuXNXw93k3NtYAASsUCGN7uaail1vBWsyAntW6vd0OB/CJUrc3juxA47O7S6tWMRLEguBn5eW4u5/AqNtTpjMUE7SD4Zbjqwv1XnpJYtVGlWb3OEgjsW+lP+SYF2WbdxcGrceeWVmHLrb3b8f0dDQ11Z20nvem90bmZMTWsXkcgedcsQl757S5kLbI/KmQxmwuqXcuz7H/zPJC/afu6CQTxEIne/PGKhPOwieXQuyW8U0q6B/3leehqMsxS2QkC+0GBa3woMDAPHvxZSmuS4c5Q89be0TRBwuN4ZkOeiQTD6W4ASg7jOFZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnWkaBMQ0Vmc7cPL9Hs4AdMWXwb2x5dyvc9fzfrQZWE=;
 b=a91QmcHDAfXqwL+zEJ2TYAzZ45PLLITiUJdQoNBc3MnfabUsVuMD/ytMnLD7513CzaadrgzxCvjRo0Gtq4fTsq1RIUaD6ZT0ccDxynP7yW8zaUL/Hvmkx46X9YXiJxrfupD8qKwXYNSkx+XXwwLbfQvnwa5mDMtwR0azTaz8Rxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by VI0PR04MB10292.eurprd04.prod.outlook.com (2603:10a6:800:243::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 13:32:19 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 13:32:19 +0000
Message-ID: <60ddb985-8fa6-455b-a0a5-45da16b8f469@cherry.de>
Date: Thu, 6 Jun 2024 15:32:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] misc: introduce STATUS LED activity function
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eugene Uriev <eugeneuriev@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Pratyush Yadav <p.yadav@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
References: <20240605192146.19052-1-ansuelsmth@gmail.com>
 <85d02b8a-dee1-42db-a804-d065517391aa@cherry.de>
 <666186d4.050a0220.fbb8b.00ff@mx.google.com>
 <96b43c02-aad4-4fd9-b35b-bc4e1d232a47@cherry.de>
 <6661a306.df0a0220.1f4b34.4513@mx.google.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <6661a306.df0a0220.1f4b34.4513@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA0P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::18) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|VI0PR04MB10292:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e107e2-120a-4ace-6b02-08dc862d167d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUVpN0I1bDI4V21SeUIzK0VKUEx4b0xDSGlmem5zblFlaEIzY3MxSWZXSGRG?=
 =?utf-8?B?b2Rpc0NnVzRkMG5BdHljQ0NtK0dKamIyM0FqTGZxMkVaZS9JaWl2VUdUc3hZ?=
 =?utf-8?B?OE9IT2drOWZCR3Nyd01KM0JTUmV4K1E3YUJseWtQT0d6VVREL0ZYODhrWEhG?=
 =?utf-8?B?N1hLU1AvbHIzdFc4ZkFzVDUwVjloTlJtRGVZQ0xDdzBWdWVPaVdtVEl6WGR3?=
 =?utf-8?B?QnpObG1COGFNaXNDNk00NldmN1NVQWtGL001Nm9tWGhWS1U2Snk3L28wQkZ5?=
 =?utf-8?B?eTR6cWZkeXBVQU5UYzdtYVVJZEs3N3MrSXRIT2VzV0ZnTVdkYUVKcFV1YnlU?=
 =?utf-8?B?Mk15enV2TWFKY2ZTYjlCM1FDYno1Y0NZZzROSWV4dXRyWlRvOUJ3M1NLU1ZQ?=
 =?utf-8?B?Q3ovdHVxaWNBdG5TeWlrZEFJUGhSemhtT0o1WXBiQmw3NTVtNlVBaHYrK0FC?=
 =?utf-8?B?UXZRVjYrTW0vYWR4TTRBVEFsY2wzNjlCSHI2c2JnN3FKc3pvaGhSdmdwWFRo?=
 =?utf-8?B?RStUeFNGbXNoZU92L2lWZkp5NThIdVV4bXNaZ2hHZk9zQTB2UytMWG8zNVFT?=
 =?utf-8?B?TG1UVVZiOXdzOEtyeXBaemlpbSs5QWFqYmEwR3JGMzExeGhPcldVOXloUTNS?=
 =?utf-8?B?ZEUwOFV1NzBRRk5MblRkQ3RkRVhCVmRaeUtGUDV1cy9aZzJWbzRLTGF1Sjg0?=
 =?utf-8?B?MzlJS3RCcU1RQmYwUWNVNVZRZm9JcnJDMFRaYkN2eklBbld0MlpPc0pYV2oz?=
 =?utf-8?B?VkI1aHdlRlBZeWRhQmdqSHpDUFRPcC9OWC9QNmREMTYvcytMNUdJdVR1UC9Z?=
 =?utf-8?B?RWNZRFJtYTVuK2U5amkrSG5xcW4vbmJVbVNBYVlIVEgxdkp2SlBpKzZlVXhV?=
 =?utf-8?B?QWozcUNOQk9ZdURRcEROZzRpcmEyOFpEUHB2a0NwcCtiSDNyRlZoWGEwSVJ4?=
 =?utf-8?B?TkhObDYxTmNpb2Vtb1FIeVU5eEtJQmRnYUxsQTFSVGg1Qi9HQjhsRWZmMm9R?=
 =?utf-8?B?cTgwYXhtb3VYZkdmYjd4cjd6OXVFZ1I4enQvQnd0K0Nub0pVekRwK0JFbEtQ?=
 =?utf-8?B?WjNUbGMrcUQ1MXQvK2dBZFZRcnE5Ry9VdlpYRzdYc1FzT2UzMHhyaDVnTy9J?=
 =?utf-8?B?L3hLb3pWWVhlUXZtczlZWUtXK0JNdGV1ZDY2ckVSQXA1SmdIa2M5L0xPQ3lr?=
 =?utf-8?B?bGgwMVBPQ3VNRm03UmtaVmtSeGlQL2ovMTBWei9FWTBKVXhpV0xlbXVmRWh1?=
 =?utf-8?B?WnBKK2xtTzBKQys4RWprZCsyd0tvTEZVenA5SjR6RExtN096VHhJdEtiN0VV?=
 =?utf-8?B?MmpKYVNUMTFmM2cxQmZRN0pleFBhTno2UVNJMDMrUldjSytocFdpMmJSY2xO?=
 =?utf-8?B?NW9GbHVDWk9KR0I1S3V0WFYzb0JZdlc2TXo3VkREMzgzSzZwSEZ1Q1haSGpS?=
 =?utf-8?B?WGducUEzRTBENlRJQ1BhWG5hajVWMExnMUpkSkxhMUEwZ1E1TklWUHBOWk5z?=
 =?utf-8?B?MUpXNmQ5VWp0QzJ0Y0NQUCtlNmpVd3VyZkh1ckRBK0xyM29Pc2N3NXRjMU9z?=
 =?utf-8?B?SFJnSVhkdWpxejVObndpSnZFMG1JVjdQNGtiUGVGSi9oVUpFQ2JLdHoxdmpm?=
 =?utf-8?B?T1VacWRsOXJ5TWppbzdLUENtWWRqYlVQTEN5T0g0M3ZCaFFDTU1xUS9Hd3Rx?=
 =?utf-8?Q?zRaHmAgOnbGnNWcEMfF7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(7416005)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzFuWjdlbmFEZUZvbGpVZ1ZqNktsNTVyMjY0WGNSM2VHcjdhZDNLSklRUVl5?=
 =?utf-8?B?ZXVSS2d6V3ZNSG4vQ3hzOEN5OStieUU5dFh5TTM1cnVUUjZNNzQ0TzBMckJp?=
 =?utf-8?B?L29jQWhQQm4rbjd5UkRYRUo5WWkvd2t5RWVuYmRaRDdodDRwcTU5RzNOckh6?=
 =?utf-8?B?UEErV3ZvcmNURzA1NDlTeGJNQU54Y0JRSVd6cWF5endObjdNS0hQYnlVZzZ1?=
 =?utf-8?B?dlJIT3RnSCtWNjBMVk84VGlhOC9WaWhsQ0dyQWtXVE5VV3VmWTZRejMrNlMw?=
 =?utf-8?B?cWI2dGdvbjRmTW1PN2greUx4QWhFWWhabm5rWndDL0RWNVZaWlIzeENEdmNs?=
 =?utf-8?B?Yk50ZHhKbnNoeTlmdnJER2g4dmhIREkzOWdYZS8wUXM2a3g1NGlZTHNINFd1?=
 =?utf-8?B?VzV3WVdtTXJZMXdUSUwzVFk1bWJWd0tuNnBPUVFBazRCclhvY1RyRkxEZU1U?=
 =?utf-8?B?UG5zV09FQzVJQUIyK3hBSnZHS0FPZlZsRFhnN05aOFEweWh3SUhGaTY3Ymsx?=
 =?utf-8?B?cVdzcnhtLy9GdmlEd014YjIrQVRnZ1dYUXNnalVxYVNJdy9xaXRrNmEyNVhF?=
 =?utf-8?B?bzMyclI4TU5UWjFXTncvbDI5aXl1YnpMeEJWOVBDSTNNVGpYZDhkd2czQko0?=
 =?utf-8?B?ZS93MHhlRlhuZkRMVDVqbHFoQUJqdFNtVnJabFhycU4xRk9xWDdPV1JhTno1?=
 =?utf-8?B?ZlhLWTY3S1pPSmNvSG9ldENGbWwrVThDb1NqcWZ3Slc1SElkcEF6UzQvSzAr?=
 =?utf-8?B?bEZYNnk2Mm9ZVmhQSWVTYWZsWVpZZUM5WkJtSlNxem1LaDlVa0FlMzQ2TE45?=
 =?utf-8?B?eEQ1b21qemI4eG01ZUhKTyt3RXgxYm52azNCenl6anNWWDJpcWNpUitNUTk5?=
 =?utf-8?B?bEE4eGoyczRiTzF0eVR3QUtaOGt5cU83L2RqRGU3Q3dTSmFGWEtlQVBpRlZL?=
 =?utf-8?B?L2dSL09HcitRUGlEVUswUXBUbzYwMTJaa1FRN0EvS0M1V1pQc1VZbENPSzY4?=
 =?utf-8?B?Zm1Sd3N6dXphU3BUWUl1U1BnUE14S1FSNE5IaCtTZXBDU2dKUStET1Z4c3hw?=
 =?utf-8?B?S1Y0NW9aTUFqb0xWeDhyZHNpYnlzNEV3OEo5WkxEZmlKY2JibzBBSVdOWnVJ?=
 =?utf-8?B?L0NOTjJxbTAzdjVmbzVhTXlFcEw3Slp0ZEdlcVlvc3Vsd0hyd2lnTHlWMlBw?=
 =?utf-8?B?NU9RWXVJcUpQcm55KzVnajhkTGZncGVwd1kxUW1HcWhiazh6YjZmWld6YnNJ?=
 =?utf-8?B?TlpmSUZIdUhrdkJ1Q0JRNXFIalM3ZUc4MW44TGJXR0ErcTBCdEl2Ukp1REFs?=
 =?utf-8?B?WlZoRTRvRVc0SS8vQWRZQWR0M1BBSjM2eFh2YjlocGQ2U3J5cHdvQVAwTE1z?=
 =?utf-8?B?OUdhNHFrVm1JcVc1NkpzdkJrdzRoK1dEbzFYK1VGTnowZ0c3L3M4TnNXemFG?=
 =?utf-8?B?Ky9TVk5tOWc3QXVkV0p0UjZYS0ZYQzRkNkVYd29RTjR5TWU1Lzk2RktwUTR6?=
 =?utf-8?B?a1JBS2J6Zi9ZTlpLYkh2Z2RoRGtoSGVEcFhKVzAySnJVelRnOHBaQjNhQW5D?=
 =?utf-8?B?M2llZ0t3bnBLY1dWczRoU3RGYWdQQjg0WWZwdEUyakVSVTlmb1NsTnNWVHU3?=
 =?utf-8?B?YjlubjRpeU1rVFA4N2pwUkwzYkdzUndWZUlMQ1I5eHI1eG4zS2lsUlZ5K1Ir?=
 =?utf-8?B?QUR1RU5RN2hVOEZObkdaN0RIVGNRVi8xZzJReHphaFFNQXZaYkRITW1Wa0F2?=
 =?utf-8?B?NytGeDhFS3VYK1pHNWc1WnF3TjlrajJOall5ODYydWhTQWpkZEl3eGFodGhQ?=
 =?utf-8?B?QjRndlEyOFBlM0tzUWk2c09YSDJnTmFGSFFhckROaXN1MG1oVWNadXdwZmhS?=
 =?utf-8?B?QlcvZHIyVGFXaGwreloxWVJPNFdtVGRGYzFTb1I1aER1T05CUy8vK2RZcnND?=
 =?utf-8?B?NlMrL2VTaUNndWwyVlFia2dXT2VEOEVkWGIzWUt6Vnpxck0vbHE1Y1RXNWE1?=
 =?utf-8?B?RUREdmE3TVBOcC9aaEtHYVlCN1l0RWppVU1lTlZMd0ZjQkliU0g2Y0tJdENx?=
 =?utf-8?B?Z0E0dHRMdnFVamRTdWNLTCtGdjdxd3Z1Q2cyUnVEUUxCYWFUVVVrbDhWRzBr?=
 =?utf-8?B?RGVQaWlTSXNxUkNLREErVGJSMzNrbVFneGNsRFlRZGFaWHdDcmp5aXhNM29X?=
 =?utf-8?Q?rqWeS1cfn3d+NYs5SQgaG7k=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e107e2-120a-4ace-6b02-08dc862d167d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 13:32:18.9572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: di0zmFmGf8Wa7tZ2oYAP2WeIBInU56hbiuDMqZ9EUTmllhJb/3uw+pffTX4xUWzT7GQOIAluMoyh9U/gDghfDhTF4hCx37VsKFXiSPoxGic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10292
X-Mailman-Approved-At: Thu, 06 Jun 2024 18:34:03 +0200
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

Hi Christian,

On 6/6/24 1:52 PM, Christian Marangi wrote:
> On Thu, Jun 06, 2024 at 12:55:37PM +0200, Quentin Schulz wrote:
>> Hi Christian,
>>
>> On 6/6/24 11:52 AM, Christian Marangi wrote:
>>> On Thu, Jun 06, 2024 at 11:12:11AM +0200, Quentin Schulz wrote:
>>>> Hi Christian,
>>>>
>>>> On 6/5/24 9:21 PM, Christian Marangi wrote:
>>>>> This series expand the STATUS LED framework with a new color
>>>>> and a big new feature. One thing that many device need is a way
>>>>> to communicate to the user that the device is actually doing
>>>>> something.
>>>>>
>>>>> This is especially useful for recovery steps where an
>>>>> user (for example) insert an USB drive, keep a button pressed
>>>>> and the device autorecover.
>>>>>
>>>>> There is currently no way to signal the user externally that
>>>>> the bootloader is processing/recoverying aside from setting
>>>>> a LED on.
>>>>>
>>>>> A solid LED on is not enough and won't actually signal any
>>>>> kind of progress.
>>>>> Solution is the good old blinking LED but uboot doesn't
>>>>> suggest (and support) interrupts and almost all the LED
>>>>> are usually GPIO LED that doesn't support HW blink.
>>>>>
>>>>
>>>> I haven't used it yet but we do have a cyclic framework now for things
>>>> happening in the background. I think this is a good use-case for this
>>>> framework? Something would set the blinking frequency (could be from CLI
>>>> directly, or as part of board files, or architecture, etc...) and the LED
>>>> would just blink then. This would allow to highlight stages in the boot
>>>> process, though that is not like an activity LED so if you're stuck in a
>>>> stage, you wouldn't know if something is still happening or if you're really
>>>> stuck (e.g. no packet on TFTP or TFTP very slow). The benefit is that it
>>>> would be way less intrusive than patching all commands that could make use
>>>> of that LED. Right now, this only adds support to MTD, SPI and TFTP, but
>>>> what about MMC, NVMe, USB, other net stuff (e.g. wget), etc...
>>>>
>>>
>>> Can you hint me on where is this framework? Checking the tftp code i
>>> couldn't find extra call to it. Maybe it's attached to the schedule()
>>> function?
>>>
>>
>> https://docs.u-boot.org/en/latest/develop/cyclic.html
>>
> 
> Thanks looks very interesting and looks handy to make use of the
> watchdog for it. I will try now to rework the implementation for the sw
> blink to make use of cyclic thing.
> 
>>> Also notice that it's really not a one setting since almost all device
>>> have GPIO LEDs and doesn't have a way to support HW Blink so the
>>> "activity" function needs to be called multiple time to increase the
>>> counter and toggle the LED.
>>>
>>
>> Cyclic callback would be called twice per expected blink period, where you
>> would toggle the GPIO (essentially making it 50% duty cycle, but could be
>> more fine-grained if you want a different duty cycle).
>>
> 
> Well status LED already have CONFIG_STATUS_LED_FREQ where you can set a
> value. I will just use this.
> 

This actually only appears in the rST doc, nothing actually makes use of 
this right now, so it's not something we **need** to use.

What I meant is, if you only provide a frequency, a specific, hardcoded, 
pattern is expected. E.g. for 1KHz, you enable the LED for 0.5ms and 
disable it for 0.5ms (or 1ms and 1ms, depending on how you see 
LED_STATUS_FREQ working). Could be 0.2ms and 0.8ms but it would always 
be this. How do you differentiate between "something is happening on 
NAND" and "TFTP is being used" if you don't have the ability to change 
the duty cycle? Or are you expecting people to have multiple LED of 
different colors for that?

>>> Also this have the extra feature that you can check if something gets
>>> stuck in the process. The lifecycle is:
>>> - Turn on the ACTIVITY LED at the start of the thing
>>> - Blink once in a while (for very little task this might not happen)
>>> - Turn off the ACTIVITY LED at the end of the thing
>>>
>>> Soo if something goes wrong the LED would never turn OFF but would stay
>>> solid ON.
>>>
>>
>> Yes, that's something that wouldn't be covered by cyclic framework here. It
>> all depends what you want to do, if it's an activity LED, then we need to
>> hook ourselves deep into frameworks where stuff is actually happening. If
>> it's just to specify which stage of the boot we reached, then cyclic would
>> be good enough probably (register for stage 1, unregister stage1+register
>> for stage2 for different frequency, etc...).
>>
> 
> The cyclic framework can reduce the implementation to just START and
> STOP. We would lose the ability to know if there is an actual progress
> or not tho... So maybe that is bad but honestly a TFTP transfer can be
> tracked by the other machine and MTD write/erase won't magically stop
> and get stalled... (and even with that they will timeout and the status
> LED stop will be called anyway)
> 
> So a dumb blinking with the watchdog is O.K. This is really a simple
> thing to show that something is happening (use case of recovering the
> device without actually using serial)
> 

Then it's not so much an activity LED anymore, rather a "i'm still alive 
and doing X thing right now, but maybe I'm stuck who knows", e.g. a 
little bit like a glorified heartbeat (I'm not saying it's bad, it's 
just a different use case :) ).

>>> More than happy to rework this to a less intrusive implementation.
>>>
>>> Maybe this can be generalized to some generic API like task_start(),
>>> task_processing() and task_end()? Might make more sense than having to
>>> add specific LED function to each function?
>>>
>>
>> This also likely would introduce a hit in performance if we need to toggle
>> the GPIO in the same thread that we do TFTP/storage medium reading/writing?
>> I assume we could still adapt cyclic to make it spawn a one time event
>> instead of looping (e.g. by unregistering itself at the end of its own
>> callback?).
> 
> But the penality is that bad? Unless you have the crazy idea of an
> absurt low value for the freq, it would be triggered once every 200
> iteration. If you are transfering MB of data you are probably on x86 or
> high end device where a GPIO bit set doesn't really affect anything.
> 

The kernel on Aarch64 is usually a few MB, sometimes a few tens of MB, 
then you may have an initramfs which is also in the tens of MB.

People are trying to get U-Boot to boot into Linux ASAP, so maybe 
they'll be bothered by this. If they are, they can always disable the 
support for this LED status feature or improve it, so I wouldn't be too 
worried about it for now since it won't be on by default anyway?

> My current idea is that start() will register a cyclic and LED will
> blink with watchdog. Stop will deregister it.
> 

Sounds good :)

>>
>>> (AFAIK linux kernel have something similar used for all the trace
>>> framework so having something in uboot to trace these kind of operation
>>> might be interesting)
>>>
>>
>> Indeed, that's what's being done with ledtrig_.* functions, they are however
>> scheduled on a workqueue and called from the subsystem directly.
>>
>> I'm a bit confused also as to why we control the LED blinking from the cmd/
>> ? E.g. for cmd/mtd.c I would assume that the changes made to the mtd
>> subsystem should be enough to handle those? Similarly, since UBI is for use
>> over NAND/MTD, shouldn't that already be handled by the MTD subsystem, and
>> if not, why not in the UBI subsystem instead of the CMD_UBI? One of the
>> issues is that you may not necessarily go through the cmd/ to do stuff with
>> storage medium or network (e.g. directly from board files).
> 
> It's a mix of cmd and subsystem cause you need to turn the LED on. Use
> the activity function to increase the conunter and toggle the LED at
> actual activity (example a mtd write command, a single block received from
> TFTP)
> 
> If the cyclic thing works as I think MAYBE we can just add this to the
> cmd part without having to disturb all the subsystem. And that is a much
> cleaner approach.
> 

Why isn't the subsystem turning the LED on when writing to the counter, 
why does it have to go through the CMD?

If I'm not mistaken, I have my disk-activity LED in Linux working just 
fine without having to rely on a userspace tool to activate it for me? 
Maybe I missed something there though :)

>>
>> For the net protocols, why not hook this to the net_[sg]et_*_handler for
>> example so it's protocol-agnostic? No clue how difficult this would be, or
>> if you'd rather have something like per-protocol activity?
> 
> Attaching to the net handler would provide a way too generic activity
> thing and would result in a dump NIC LED. We want to show activity when
> we actually want to signal stuff not when the device is executin ASM
> instructions ahahah
> 

How does one define "when we actually want to signal stuff"? The further 
away you're from the subsystem, the more consumers we're going to have 
to patch to add this logic.

> So yes I feel adding this way in way too generic subsystem might
> deviates from the idea of this. Even attaching to the write and erase
> function was a bit problematic and too generic.
> 
>>
>> Finally, maybe we also want to have a Kconfig symbol per "type" of activity
>> to control what should be "monitored", and I would also suggest if we go
>> this route to have a Kconfig symbol for the frequency per "type" of activity
>> as well, so that one can know which activity is happening right now.
>>
> 
> Yes that might be good but I have some fear we might explode with
> Kconfig. I think it's better to first have a solid idea on how this
> works and then we can think of the configuration part.
> 

Oh, we've seen much worse with the VPL_/TPL_/SPL_// symbols :) Can come 
later though if someone has a usecase for it.

Cheers,
Quentin
