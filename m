Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5DACCF9E3
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 23:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D26F83700;
	Mon,  3 Nov 2025 00:52:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wiuknZoS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3665838A5; Mon,  3 Nov 2025 00:52:48 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1210D83642
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 00:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcY5gh5dnC7hQOa3UEzVdP5LcSKQR21jnQZN0O1XKD3pyw1CFKky1uhBEv+QjtlyL1n9nRrlaDjUNb1ZWpEKnO0xAUjTEpzyqfU7IXkDrEHTStxoYORf9v8zrkU5khXN+HJ5+jLn4XPypwHVDI1S4aqIY1+XzYumxt/D8mooW5SH9qGXCVVABqu129XMMd9D497QhdTQniLOZ3jUAFfYuRGoD7TZdHa+Qho8QzVhqogGGzO3S9oH8P1VX9TCDDJC6e1r0ORKzXtZtSAyIVNX9rdzm2wxsseXDgYV+/Y7qxPAs66icTrh01Y3TUgLrki4BxV7yIkmtjVI7wV8xI2+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeeRr6BkL8/o3nmKITIIgnc7bW6uh+LJUnRSeaTiqq0=;
 b=A8r/vS6XBAfN7BNTSpRz8Y51jQxW7qV06AXmtEKsOh0bSnm2a3NY7AsO6CaQMw3f7Eb8+4BrHPNgJoM88g/255w3gC8jQx5pQWjjNnc3/43VLpnoxaioVc2GnOxVbXY5RE+7Xwl4R3+L2LqEZyyvU9fxLwI4vGZ7LXCTGETpjwexL7b0A46eN8w5xu6/doI3P2UuYes2wR7jS7MkONDnM+tTn4zsxOFqZRoTx9Vgzyj4KftkjxtHw2NfkN/m0O0MFuZ4u3ThDL8iIIhDsUmmyy6dZFLiCvGuTl8FFjzYG2UL2we7iaf+CsdxMKSO7OcqefG3XTGnZchLuF8Q7+qytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeeRr6BkL8/o3nmKITIIgnc7bW6uh+LJUnRSeaTiqq0=;
 b=wiuknZoS6+6a8tpAOjK3SImK9XeoExGwi68u8eeAcKPvYwQg0w5eDnQRhM5o2gH8DWCvJSYfl8o5AIkjAM5NYtjujwCYnUMYoR+ZpvFfz79Vpxa/I8muyC1wYPb/RZB6MQ97ov1+yCtzlZVJwytDXmvGw7MZtFkPblOQ/1yztlg7SL4qId8oeKVWN/61z2GE0TEE3wGRfLVxiUN6x3Fgci8V57IAwknzNc4lNl6+aUwJvY0bNOKq3wq5CMF8xEo91q8vDv3LPd7IvKENfSNVBTcpMBNxk1BEIjqTfySXNkyAolyvweL/KlNzEDzLLHPih4SdTfoB/3p1sWz+tykJZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU5PR08MB10496.eurprd08.prod.outlook.com (2603:10a6:10:527::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sun, 2 Nov
 2025 23:52:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 23:52:43 +0000
Message-ID: <682e5919-af28-4634-87a9-d190995fac11@iopsys.eu>
Date: Mon, 3 Nov 2025 02:52:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spinand: add support for FudanMicro FM25S01A
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tianling Shen <cnsztl@gmail.com>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: u-boot@lists.denx.de
References: <20251101051942.695907-1-cnsztl@gmail.com>
 <6716ef2d-314c-4650-9bd9-d5497833ed32@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <6716ef2d-314c-4650-9bd9-d5497833ed32@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU5PR08MB10496:EE_
X-MS-Office365-Filtering-Correlation-Id: e050127e-d64a-485f-3eda-08de1a6aea49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUt4Vm1iVUZteFFSNXFVU0I2eGZCSk9COURkaC9EQTZ4WU13bUpuYThDWktq?=
 =?utf-8?B?N3dJeVdIMWo4VVM2WTcrU3BDZ2NSdS9DOXNoekp0Ky9YMElBaG9CZjFCZEY2?=
 =?utf-8?B?c2g5QkkzME9GNmNPVjZSR204VUk4blBYaDQ5VzQ1S3ZUOGlJZWw1WDFHazJh?=
 =?utf-8?B?dFVrVUpuQWtjYktXdXdySWRkUmhtU3QrMVRQelNpWVFpTnR6bzhuNjh5QmZS?=
 =?utf-8?B?cGM4NEMyc2k4OURhRlN2anh5eUJ3anIxeEt5TTFOL0VVaytDaThkUDBWUXdS?=
 =?utf-8?B?QnhMb2JzNUdPUU5PeE85MTliWHkvaGlPUjVlb3VrU0gyZG1CVW1qR0FiVUdF?=
 =?utf-8?B?SWd1eFBKd3pMUlRLZGk4REpkNllRT3F5QXFuaFB1R01EaXROV0V3NGRMZ3FT?=
 =?utf-8?B?NGVUUmlQaHl6NEdMaWUvd00xZlBRMC96bUozTEVVNVZZcWllbDVJV01Gallm?=
 =?utf-8?B?a05BR3hJcmZxVXd0OFRpRW5WMkluTDZPcHNTYUtVNXFJaUY4Qno5c1p4a3R3?=
 =?utf-8?B?L0VFa1lvT3BKOW1jaUFYTG9LL1U4cFFCeEpCQU9icjZMWGN2R2J1Ri9nR0x1?=
 =?utf-8?B?VDBFMHhFN2lPVzh5NlZMeUJWR3lZQk5BR015MzBxQmpGT1FueVBEVWJYUFFa?=
 =?utf-8?B?a1lES0pOTTRYaGZqa0dMUW9NajlNWTdJYlR2YXpjT2NybWFNUVpmN01ETWpI?=
 =?utf-8?B?V0h4S1JEVkRqSnFMbXZLdWl2RjV0TVV1WXFBV25jdkl0ZEJHMnlndzlJK2No?=
 =?utf-8?B?bXNGVlB5REhRNndJbjZpaGZqNlRzdnJqS3BTam1wZ0oxUlZ1VnRTWElCTWU4?=
 =?utf-8?B?T3RyblJOM3lna0FHeG9Ka2xhdjU5TzNkMWtEYlVTeGZnOUM2YldXM2c1a1Zn?=
 =?utf-8?B?Z0pCV2ZVM2dJK2FDNHhxL3JPRnVDaFJONi8xUDM2bU1IdGVjOXlWQWRJQlZG?=
 =?utf-8?B?ZVEyeEpwYjl2R1FlblhsditqeEZjdlRnZnVBcmhRZEpaclhjMUhLQzhDeVRy?=
 =?utf-8?B?R2xXSDJ3T2wxdzJ1V3U4RFE3Vk82RUJZTERRdmZCN1BYWU1KakIxdEJLV2Ev?=
 =?utf-8?B?c2FoMVgvV2NnSEVoYXVKZ3dWSCt2STUxbFZVWENac2FKKzVQcDJYV0Qrb283?=
 =?utf-8?B?dTM4RFZtSHJYRWRiR2Q0Zzk2V3VFK20zTVJEeGdYSlR2a3NpUktlQmtXU1lo?=
 =?utf-8?B?MlNaY1pYMGhzT1dyVU9TZytXc0Fic2VFRCtEZnVhZVFnWWNFM1RLL2liMUdI?=
 =?utf-8?B?NzRJanIraGtWUVJtdU54RWpvRGxVSFcwNm4xcEJQRUpaQ1gxN29EcVZVM3Fl?=
 =?utf-8?B?NmV4MTJpaEZVM2RnUW9seDZOdGJ1MHV6RThVbVlNQXpVVHFaRHp0VTFtcWV0?=
 =?utf-8?B?SEkzNWxJOVVUbUx0ZXdpN3lLV0xWZ2xZcWU2QVA0M2t6TmFNdWRiLzNNWlVw?=
 =?utf-8?B?a0UrcUhqcG1uNithNXB5UmEzb1VIVzMzRmxnazNMM3h4WEtSc0NYRGVwV2h2?=
 =?utf-8?B?M2RsUVdVUXhQeVdUM05wYS96dXgyWGZXTGE0NTlFNVUxcTJmQ3FISGdLQmdu?=
 =?utf-8?B?NEhkdXJsVWtOUDA3d2hVWVJaVWxQV3hHUmJMbVV5SFAvT0hMR1E2S2Z0aFdl?=
 =?utf-8?B?N1BRUVhGKzQyQlpyS0FzMVpWakFZL2RmZ2xlR1RDamlFemhVb3A3K0V2R0hP?=
 =?utf-8?B?YWNzSkhzRGpIN0hZNFNUUVlJSzFzL0ozWnNLZ2t4Kys1ZlN4aUdPVDYvR3ht?=
 =?utf-8?B?ZU5qZkIzaElFTkdzNDhtM0FnaTFsSXBOUlNqWnJqQlFnWHFwUklpRk1KRXVz?=
 =?utf-8?B?TWEzM2k0eVFGMURYbURrMzVGRU5VNnhZZURQV0pYR1RtaG92M1c0NjZBd2Iy?=
 =?utf-8?B?Y1YwU3IyK3R3cG4xbzByQlNnWFMra2VjWWpESmoxMjV5RHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzdHQVd1YWc5SXZTOGhEUnVQK0g1OXp5cU5VcC85aUwzZ0E5NEowbU1yZ0Nx?=
 =?utf-8?B?aTNjYVloc1pkaDU3REZVUExFMGxYeDJuUGE3MWhZaXRwOE51Uy9yQ3J0VDdn?=
 =?utf-8?B?WmczRW8yN1Zab1lUT1FUV3kwVjY4QnlUcllYSXg0cXdJK25FTm5KaW5zRXZu?=
 =?utf-8?B?Z3lFVjFYWmJBbytMYXdISTM4RFVyTzgyYlZtZHhSaUJPbHFINlppMmdPTThO?=
 =?utf-8?B?dDBNQi8wVmxBS3RnazliVjkvbVEwOC9Bd2pSbm50TXhrYWUzK3h4aHJpMGZt?=
 =?utf-8?B?ZTBwdW8yM1JVQlBkaHR6MVdyOVZKeEN2QUxSRm0vWk5Nc09iRXUwOXNTdnlF?=
 =?utf-8?B?YW9yM25wNEdtTFVlMlJFL0xseDBPcTlWNUtaemh5TUROdFlvalkrRnlibE9O?=
 =?utf-8?B?R3dNZjdrQlluMjRQMHFtV2FiS2Urb1lBVFhsdCtVYm10dEdWNUJ3R2hvdVBJ?=
 =?utf-8?B?RHVOTG9lN3VmOHFGT3FQL2I3Rm05MTl1RE5tSHNlcDBGVUlQeFhrZVlIM0h4?=
 =?utf-8?B?OWRLMUp5ZHBRam1COGJZcERoR25YWHpleEp2MVFESTlwWStIVFFKTXBHR2xP?=
 =?utf-8?B?ZUVyaisvanlhUy9PTTJNK2ovZ2Z1UkVTKzk0NGtmY2N4R095bnRVdkFBSHB6?=
 =?utf-8?B?NEs5Q0NaTU5aSDQ5aUl6RVZ5a0VPRFlDRnpvc2V5OXpzejJHRHdvTDdCMVVw?=
 =?utf-8?B?UXRxNHloQTEvUG14M3VXUE1xVmtCZjBCRkErMVpTMFhhaWh2S0hJeUIvMDMz?=
 =?utf-8?B?RDhPcE1WV3ZJSy9uZ1Q2d3hGd1ZORDdHcnhNblg0clZOMlo5TmpwbXVoQnVz?=
 =?utf-8?B?UWZsTmpYaEtVdVlRRVdrS0NrdGYrSDRUZzljcXJ2K09aQytia1dXMCtOL0xW?=
 =?utf-8?B?UjNmOXA4cnZMRXZBYkRmY3FkaWlleVpENGUzczBmaEpvbFNFSDBxSEQzS2Zy?=
 =?utf-8?B?MFc2RXZVdjFnR2E5aWI1TitSYVZqT3dGeGVGbklneVpkbThHSUtvYU5LWXZ5?=
 =?utf-8?B?NCsyRUdTZEZ0QUJGbGNYenRFRm1kR254eTZKUERMZWNxbTJFa0pmUjZHZ1dl?=
 =?utf-8?B?QVljUitaWXAzdm1ZY0pMZlJ3SDVRejYwUTh6SndRQlNUcUg5VHhDc25JRnZh?=
 =?utf-8?B?UWxETGtRdFZRcndmMCtMbFplNzRjcjJtNVB6bjljMUdMM1B6T3hqNUhhd3Yy?=
 =?utf-8?B?OWhnRWt1TEd2Zk0rdUNSczk3dTIvUlozUXhwNHBzZkh3VEdZbE5LTDREVDFz?=
 =?utf-8?B?OFM5OWZ4OXhsaXVQVzd1QVZ1RGZDS2lYZTN6ejdLeGN2cmNyTHJIdiswTGVk?=
 =?utf-8?B?T2IrUUt4OHg2UTdRNjNuV0gxTWMyTzM0OXhsVjByNnZHMmd1c1lnTnRMMnFW?=
 =?utf-8?B?UzdFWnoxUDVMTEpoMEc3SHZFYzVtMGdsTDF2VDdjRGo1VkoxNFRIdFJOTTY5?=
 =?utf-8?B?U01ZdktjekU2ZXFmV1dYcy80UUNmWldtZUppUW53QVVRZmFzb2pBZG5VWGRY?=
 =?utf-8?B?TnNNM1RwS2FBOHcyZW5MYkkzL21Va1dLbXA2MXFyK1NSTDFMMk9IWnk4VS9U?=
 =?utf-8?B?dEluL3k1N3pTY2Q0MSt6ZFBEK2lQZ3gzOXJqY1R2UVFkL2Q1VWxmSlVOWTk2?=
 =?utf-8?B?bTFVUFhIWUFVMG1SS1VzalRBSHJUQnNhZDhZTXJreTFBUXhZS0hCNTJzR2tT?=
 =?utf-8?B?Rit4ZUpLU2Y1b3lkc2ErSUxrMVJiWHY2eE1uUEN3MENmczBSaEJHR0lnWDhy?=
 =?utf-8?B?TGx3ZklZdk9iT3NGdW5pbzFwbWt1dGZiNU0wNCtSNkpueUtaTFkvNDV3eWti?=
 =?utf-8?B?bEZuUzJkR0oyZzdDNnFQZjl3aXBjZGxxeGVLNURFRTlOWm53OTVZZFpkVk1j?=
 =?utf-8?B?UjhhNXQ5Z2NKSk9rREZsZ1lSeDRwWVJNWkNkeW1QVXkzTXU3SVFuSUdpYUpo?=
 =?utf-8?B?Nnl3SHBoQ29jQTk2VllWV1dBdHdCbnRTZXZYWXVWajVWRWMybmtFeVJRTUVS?=
 =?utf-8?B?c0sxT2JEV3JrTEdXSHhHM0dWaTE4U2VFdlNINmM5ZUhXSHFjb2JieFY3NFZx?=
 =?utf-8?B?cDlXbkpHSHhSQVdpRU9nbmc5eXNiMUpGQmxzL3AxVVkxaUh6cmd2YnY2b2w0?=
 =?utf-8?B?UFVOUUc3bGhrblh5QjdqYjZ2NHVEd0pvMFk2Q1RVblMremdhZmlSWEUxNlRw?=
 =?utf-8?Q?yG50VDl+JVepn2Rvm1vsH1I=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e050127e-d64a-485f-3eda-08de1a6aea49
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 23:52:43.6056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iMZLsMJjMsPOPapvw916bwOnsW5qpVnnGrwn64u+FlMZgcqRsMgAiKA0JyrdaojPzwYrPQgBi5PPX8YV8nPK+oUyY1x8C2tGJR0/qdibBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10496
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

One more issue found

according to datasheet https://www.fmsh.com/nvm/FM25S01A_ds_eng.pdf
there is no QE bit on this flash

Regards,
Mikhail Kshevetskiy

On 11/1/25 09:28, Mikhail Kshevetskiy wrote:
> Reviewed-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>
>
> On 11/1/25 08:19, Tianling Shen wrote:
>> Add support for FudanMicro FM25S01A SPI NAND.
>>
>> This driver is ported from linux v6.18 and tested on a MT7981 board.
>>
>> Link: https://lore.kernel.org/linux-mtd/20250824170013.3328777-1-cnsztl@gmail.com/
>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>> ---
>>
>> Changes in v2:
>> - add fmsh manufacturer to core files
>>
>> ---
>>  drivers/mtd/nand/spi/Makefile |  2 +-
>>  drivers/mtd/nand/spi/core.c   |  1 +
>>  drivers/mtd/nand/spi/fmsh.c   | 76 +++++++++++++++++++++++++++++++++++
>>  include/linux/mtd/spinand.h   |  1 +
>>  4 files changed, 79 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/mtd/nand/spi/fmsh.c
>>
>> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
>> index 152aa1a3783c..a7a0b2cb4b9e 100644
>> --- a/drivers/mtd/nand/spi/Makefile
>> +++ b/drivers/mtd/nand/spi/Makefile
>> @@ -1,6 +1,6 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>>  spinand-objs := core.o otp.o
>> -spinand-objs += alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
>> +spinand-objs += alliancememory.o ato.o esmt.o fmsh.o foresee.o gigadevice.o macronix.o
>>  spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
>>  obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index 0c4350595469..14af42646122 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -1227,6 +1227,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
>>  	&alliancememory_spinand_manufacturer,
>>  	&ato_spinand_manufacturer,
>>  	&esmt_c8_spinand_manufacturer,
>> +	&fmsh_spinand_manufacturer,
>>  	&foresee_spinand_manufacturer,
>>  	&gigadevice_spinand_manufacturer,
>>  	&macronix_spinand_manufacturer,
>> diff --git a/drivers/mtd/nand/spi/fmsh.c b/drivers/mtd/nand/spi/fmsh.c
>> new file mode 100644
>> index 000000000000..84a567919ebb
>> --- /dev/null
>> +++ b/drivers/mtd/nand/spi/fmsh.c
>> @@ -0,0 +1,76 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2020-2021 Rockchip Electronics Co., Ltd.
>> + *
>> + * Author: Dingqiang Lin <jon.lin@rock-chips.com>
>> + */
>> +
>> +#ifndef __UBOOT__
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#endif
>> +#include <linux/mtd/spinand.h>
>> +
>> +#define SPINAND_MFR_FMSH		0xA1
>> +
>> +static SPINAND_OP_VARIANTS(read_cache_variants,
>> +		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 0),
>> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
>> +		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
>> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
>> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
>> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
>> +
>> +static SPINAND_OP_VARIANTS(write_cache_variants,
>> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
>> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
>> +
>> +static SPINAND_OP_VARIANTS(update_cache_variants,
>> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
>> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
>> +
>> +static int fm25s01a_ooblayout_ecc(struct mtd_info *mtd, int section,
>> +				  struct mtd_oob_region *region)
>> +{
>> +	return -ERANGE;
>> +}
>> +
>> +static int fm25s01a_ooblayout_free(struct mtd_info *mtd, int section,
>> +				   struct mtd_oob_region *region)
>> +{
>> +	if (section)
>> +		return -ERANGE;
>> +
>> +	region->offset = 2;
>> +	region->length = 62;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct mtd_ooblayout_ops fm25s01a_ooblayout = {
>> +	.ecc = fm25s01a_ooblayout_ecc,
>> +	.rfree = fm25s01a_ooblayout_free,
>> +};
>> +
>> +static const struct spinand_info fmsh_spinand_table[] = {
>> +	SPINAND_INFO("FM25S01A",
>> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xE4),
>> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
>> +		     NAND_ECCREQ(1, 512),
>> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +					      &write_cache_variants,
>> +					      &update_cache_variants),
>> +		     SPINAND_HAS_QE_BIT,
>> +		     SPINAND_ECCINFO(&fm25s01a_ooblayout, NULL)),
>> +};
>> +
>> +static const struct spinand_manufacturer_ops fmsh_spinand_manuf_ops = {
>> +};
>> +
>> +const struct spinand_manufacturer fmsh_spinand_manufacturer = {
>> +	.id = SPINAND_MFR_FMSH,
>> +	.name = "Fudan Micro",
>> +	.chips = fmsh_spinand_table,
>> +	.nchips = ARRAY_SIZE(fmsh_spinand_table),
>> +	.ops = &fmsh_spinand_manuf_ops,
>> +};
>> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
>> index cf9b9656d054..e9561c0a3956 100644
>> --- a/include/linux/mtd/spinand.h
>> +++ b/include/linux/mtd/spinand.h
>> @@ -361,6 +361,7 @@ struct spinand_manufacturer {
>>  extern const struct spinand_manufacturer alliancememory_spinand_manufacturer;
>>  extern const struct spinand_manufacturer ato_spinand_manufacturer;
>>  extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
>> +extern const struct spinand_manufacturer fmsh_spinand_manufacturer;
>>  extern const struct spinand_manufacturer foresee_spinand_manufacturer;
>>  extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
>>  extern const struct spinand_manufacturer macronix_spinand_manufacturer;
