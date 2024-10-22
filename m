Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BC2CDD0E1
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 19:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0320588FA7;
	Tue, 22 Oct 2024 21:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="gJsBMC7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFC7C88FA7; Tue, 22 Oct 2024 21:59:53 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A211888F4B
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 21:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmOSC2ZqAi0bSZoLeq8U/B4paLEKL1YTb4tbpOWeUxFC7MAVo1pmDMc8xI8JXE7bV1haUkPcZ9GbajYfqi0O6CrNWKawRexL31/yq5LjS/tXYvmtGgXDwsgk75vt2LjBGIB2n+Qek6f5G3/R/WuaXeyxjbp8E0p0SP2c7ew7bwM3NaWfYN72qYi3LtwhL3ipbLrrvMJMcTUt/DEf9pzHlXVuZaKAMImu4eXSlYBckhFgIZQ7zqsAeC3QDfa66uKKS1SHwS9ddxYoycOX9wcqGUQqs0p6/JfuSAwlrKa1/Us8Z2GIvV74GDxZUMpxKltAPw4as5tXlrZS6jefcUcRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbUqcJo/dVXtC6Ca9hwffeXMxvJUg4fKSDOVjFfAmn0=;
 b=uOnl2Yfn+8IcC4vVpEVyntuit8mER2pHZl0iSPzD9fPUJn9OYyBz9ZwOuefwCdajLmwhEhLRQC4iiQ8QBfmBWOTpAEkrurHjGsOKDePyvz1u0IrokjmIqKXF0vPbyCbSm4QXfPl4cDVtodIE9CmlhJmFbMC1lcGruY86qp/X4AkCktP4pyYutxhIHROlnBJothv1BZcw0gfoe29KN4tBfTsow3lJYN+fS0HKnLxyyAPvQeeOsvQaJuEKW87GgO1a3CEMT6oqUXqr1ugGT5kklmi5o8cw42On+Gaak8NQrb40yj5NLE86vw6ojzEgc/56rB4ZjmAEChZ6jSrIcp9zsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbUqcJo/dVXtC6Ca9hwffeXMxvJUg4fKSDOVjFfAmn0=;
 b=gJsBMC7ClXaMnCaKzpaI3DEa7J5kl4VwblB233LVT2XKychcRR/SJcJs7rlgCD9ed38Cu7G2fwMckwTXm/C3eKqIxak2DZnzftKBn0CskBGPz3U2aU0r8HxFB3k9HFRBctki4HL/D0kqZf2FhUcO4YJsj5goqaqLjeD5PGAlqx2p4GpNc/DNBpKw1sOIjahw3X8vuXCXMUCcJz2meuP9fV04Ic7TYEQzrsGLrn4VemN1ea00WdXHqkP/F9n/uhbYmPWTQxVag3VdJZKQp2zYkSUA8w6Jr7hl9iCGu+1eXirR0cfyAmhRmisfI8RzzungtlnwmCLv8lObsXG/PGuHNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6242.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:92::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Tue, 22 Oct
 2024 19:59:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 19:59:49 +0000
Message-ID: <f1ef1ad7-f4ce-4b96-931b-d51c77a86e8d@siemens.com>
Date: Tue, 22 Oct 2024 21:59:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] sysinfo: Add driver for IOT2050 boards
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>,
 "Li, Hua Qian (DI FA CTR IPC CN PRC4)" <huaqian.li@siemens.com>
References: <cover.1729577070.git.jan.kiszka@siemens.com>
 <64b2dae0ae60feded514b774f0e91c303c81a52d.1729577070.git.jan.kiszka@siemens.com>
 <CAFLszTgYaBh8ccEVoRAhGDAysY=XY=5es1k6TmF=mWBEHyYUAA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLszTgYaBh8ccEVoRAhGDAysY=XY=5es1k6TmF=mWBEHyYUAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: e76bb423-a053-4708-42d9-08dcf2d415e0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFhLWkxyVXVncW43RWpoeno2V2xIaFpUbWcyUU5MSUd3aU1XTDdwNTBENDhx?=
 =?utf-8?B?QkRkaElMRW1CeWRyWGloMnljZnJLdmVjYmRLeFNqTklXTW00SHl2ZkxUT0dD?=
 =?utf-8?B?TERwL0YyQ29mUjZ0R1c4WDI2cWsrK2dKUXowbkY3NXpwQUVtb0tMbTJjR1FC?=
 =?utf-8?B?QjNHaTM0WnhPMXpZVkt4MTYrNElXK3Z3SFc2Tno2T29vYWw1VFdqeFVCSzR4?=
 =?utf-8?B?NkZ3ZmhyVUF6YW52Z0Y4c0FmUzVCL21Db1FDSGZ6WHQyTFJxZ2kycWVvQ1RM?=
 =?utf-8?B?YThEMkh2ZThXZ3ZnYi9McFFBSFdlRDR3ZE9RZDkrSEI2ZWdYM3l4RUJVZXor?=
 =?utf-8?B?d211d1VSTlpPYWhEV094algrMGF0cFhmdUdERG9sN0NvRmRIR3liZ2cxcERy?=
 =?utf-8?B?UEhZczUreHhPQ3ArNXVnMFF4TWdibXV2RHoyMDk2NnE0V2d1L2hmOTQrVEpC?=
 =?utf-8?B?WmE3SndhZ291YVA3MldodXpuTzZ4RzkzUVhYajZVOWNqRkJ4Rm5xRS9rcjlV?=
 =?utf-8?B?SlJvUEZxbm1aN1ozLzNoSDkwK0JGamsvdnJYOUpGVi9POWJhQzJ2Z3E5c2RS?=
 =?utf-8?B?amNpN1hzaUFNT1Z4cytOVVZJNDJjMjRyU01PL0Zsd1c4U2U2Y0NrSXRwSlBJ?=
 =?utf-8?B?ZFZRMUs3cllVcEcyYnNlMlM5WkIrQ21TSytTRW1QazRBcU8zOEJBTk0vckx1?=
 =?utf-8?B?eDM4UGZZeUd2WHFGSEF2emxhRit0M1lWUjVNY1NPRWRuSlJId2I0MkIySGJU?=
 =?utf-8?B?aTFsQ3p4UXhxN2JQb3I1MWVBN1BEY2VmMThIQ3AxYng1QjhvQ0lNVXIyQjJU?=
 =?utf-8?B?WGV6bzVCNzZ3SCtBVU1rS0xUOVE1WUpPNXc4K1krVUdVRWdzVlc0RGpDaDFh?=
 =?utf-8?B?QUFPVkFSSFBEOXRHV0ErWllCajk2RERGVjU0QnVyRm5aWFhFVnBGVS9rOHJX?=
 =?utf-8?B?Vy8wdzliY0tUR1NzWDZDNGc1Z2NLY2U1eUJhV1cyTk9OQ2JtVTJ6dVpWZmNB?=
 =?utf-8?B?RnMvTm56Z29PZkJHQkVFYnhNVzFRMUY4TFY3cThSWTBkNmtoSWhhSUdwTjVN?=
 =?utf-8?B?eGhOZDg5SWo1anFwWk5reWo3OWQxZTNlbkhrcVJic0N0U2c0VjU0b2s2YmhY?=
 =?utf-8?B?NkYzQ2VSOXBrRjdLR2hTSDJaSERRZC9idFVGNGNxeU84c1o1MldYRU5KaEhD?=
 =?utf-8?B?a1Zaam1TWld1ajBBdXBEbEt3M3FJZlIwb01TWDB1OEJpbnRBUGdLZFExaVJ1?=
 =?utf-8?B?MWJ4SGxYS1JoZ2xsTGdRRU43eVg4Z1dlODBBL1U2T2lGSEdLbmVFSkxWemlC?=
 =?utf-8?B?QUxHWFY1MXY2RHd3d0FVYkk1c1lQd1p3bXpwWWFKU3EwYVBCbUkwWUtXT21K?=
 =?utf-8?B?WllnS1laVVlvTHQ0elNySmFXbVR2bTQ1RFJkNzRwKzFMdExTSVJXVVhBZ3Nv?=
 =?utf-8?B?Uy95ckNRTTU3M3BWY2ZJcXE0aFVuSUhlaFBMUmxSRjRzWXNhUlluaGg0UW90?=
 =?utf-8?B?bVZHQW1PWXBZZy9rbGVEUHREaDZvdmJ0QmdRQXFUblNtWEoyN296QWV6aVNs?=
 =?utf-8?B?YnJyZkdZejlHV0o5TjBiT1E4VmlOZEJZOTJCTlhSMThFUnphbW9pT3pCRmF3?=
 =?utf-8?B?U3RBYkh5aWdOTWdpQUJndnBQVWF4bnpGQ3VpN0RIYUlvZnFwT2lzcThFcTR6?=
 =?utf-8?B?M29LL0lDSDBZbWF6ckdPczJ4bjJpK2V5ZEdOMlluR0NlUmsydjZ6K1JEbHUv?=
 =?utf-8?Q?B8oOr4r3hBREBPXXK+/nDyyds325LRvj3apYPEF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M09JQk5QcU5HRTd5bFpzUld5aVN1OW8xeGtqY1Q5cnlvWE1mai9VRHZLdjlW?=
 =?utf-8?B?MVZhZXN2OGZ2QjBKeDlpYkJ0RkpRQVpkaW0yRE9XcTNzM0lMNFUrT2Zvazgx?=
 =?utf-8?B?b2lWYUI4b3ptWUM4cUYyOWx5T2Z6cmt0Und4OFFSdkttTW9uRGZ5Z3dYSmV1?=
 =?utf-8?B?Z1MrejNmZ2txN29CdFR0TmZuajZoSk9zandxblBtbzc4cmhla0pvTFBTTFNG?=
 =?utf-8?B?djNzK1VjTHhOQmx1YTZZazJ6dGtza3NrMjl4LzF5QllSVk82MHM2eG1NbU4z?=
 =?utf-8?B?QVNROHNWYUR3dy81RUhqeGltdHF1Z3VnckQwTU44SklET0o3ZnRVbG1KcnM3?=
 =?utf-8?B?bzZXaHRsSWFNTnMraStnT2ZWOVY4bkx4YVZQTXhoOHA4WklnR3lzMkdXdzND?=
 =?utf-8?B?RnIrTVQxYXowTDltWXFPMlNtekYxMmRHc3FGem4zV1hTa0Y1cCtPdTd6aXhM?=
 =?utf-8?B?UndDQWk5SVZmOCtrcGNrYmJTZE1QU042SnZPNWY1UzJXSHFuYzNxelBQbGZj?=
 =?utf-8?B?V3Y2MlVpTTNzSVRHMmswVVJkbmc0Yms3MHZYNCtVTktWUGJUa2FNdDVoMUlZ?=
 =?utf-8?B?a0pnZmZJNDBkY1hYOWxWaFBPUHdLaDlBSmRpM0VUV2h2c1RxTDNXeUlWMmpQ?=
 =?utf-8?B?UU5TTWN2dkdWVXdpRlJoTnB1enhjaGhVWE0yZVpvaTB1cmRJQ1poVHFHYlAy?=
 =?utf-8?B?VkNFTC93cENsUy8vSVhuRTl1SzFyM3VwK3Z6YlMyWHp4R3lOMlR5M3k1WjNk?=
 =?utf-8?B?Q3FDRjB5a3diNjJrSTFKYmFYdDdUelFzTU5HYmRMRHFRT20wY0cvVXZoMlJp?=
 =?utf-8?B?U1VwWCt0dzRFR0pFd0FIdjVHWHBENkNVMFkrYXhqd25xNmtZVlExZGJjdk1K?=
 =?utf-8?B?RlplTDlDeUo4czJxSndMZnB5UEEwT1ZtWkdmK3ZIaW11clRrZENVb2hHZDVM?=
 =?utf-8?B?NG1zWjB2MnFMNHdUT0kwb09raGM1TnBiYklBR0l6ZUVkTWt4d0RBMzBmSVRW?=
 =?utf-8?B?ZS9tTHZSTW5FR1U4Q2QrQVZmUWJlTmlMaWZMSHRibFZxbzBoVjdGd0ZsK1hK?=
 =?utf-8?B?R2dQaGY0SEpUTGp0TlpqbGtVL1RtTkpIUTNTcnA2elBFK29XNlFjSXJ4RXAx?=
 =?utf-8?B?SFNNak44NExjbjl1WEJENndIT3JyNVk0bTV1TXhqaVE5RW1yeXZBdnBUK0d2?=
 =?utf-8?B?THBQYlMrZ1BRUnhNNTRFNzFMRnVtUjNhT2JKQWN3UHpvd2YremdxaFg1cEkr?=
 =?utf-8?B?bUVicXJ1WVZsV2ZMQm5NK3laODlvMU1yRW12eEVhdDYrTjdHK3J3QTJqUlJG?=
 =?utf-8?B?blo0ZTBFM01SaFM3NmhTUEJDMjg5eU8xRU1Cc0RMdG1SL2NubW1NUTd4bWNm?=
 =?utf-8?B?SzRmZk8va3NSTU1ta0hicUVlS21NS2gwb3pHV2RVVUpsV1Z6UVAvQWpmZUZo?=
 =?utf-8?B?K1ZHYU9kNlQxTjVEa2RQQ2tlRGhsTElUblBaYSs5YTllbUVwQ1Nzdkt4bzRj?=
 =?utf-8?B?NVFiK2hnRjIxVTBjdVBuT2c5M2JYOGo4dGdBWXpmN0F2WDc3Z3dyN1BpYktN?=
 =?utf-8?B?WHV3TmtVZ2Z6bGdwcU43V0l6SHdDMTVjQlhIam1NVVRaZDFwcGlvVjVaY0lF?=
 =?utf-8?B?V2MzT0F5VU9MTnlIL1FnMGZsNUQ2MGtaRVhmUEszMWdpSHdxTm5VbGdGSmJm?=
 =?utf-8?B?TjZkUi9hUkpYOFVPamhXUXFKT0d6cEY0TWlaTkVGNzRGOC9PdEV6bzZ4UWNW?=
 =?utf-8?B?dTB4SlZZTEJIZ1F1dEsxRklMTndPMFZaVlJEaDFzZStkYjVWRVF3cDQ3SSto?=
 =?utf-8?B?T0pzTXc2UXB4U0NVMTArZWVlQXhjRzlLZEg3SW5EWGFLdlErSDVBT1BYUjl1?=
 =?utf-8?B?M2ZlTzNRY0FkL25qQ01JVTZEVlBBbiswbUhwUEdma1ZZTS9tQlZCNVNidEVB?=
 =?utf-8?B?T3FRNUZCRnRKTjdadzVYWHBiQlo2dFN6RzFPcWNoMXdxT3pLLzNBVjlUR2JM?=
 =?utf-8?B?TkJLUTJ4UFhJcG9hK1MzMFlVUWpxQmhJelM5VEg3U0NGM1RUN2tKMHBqcHJm?=
 =?utf-8?B?MWZxN1czZGFEREQzM0NGWUVuTjFuTjJRSXBlMnNYd2o1cDBmTCtWbVpXak9m?=
 =?utf-8?B?VW1TNlhLejFibnlWL0tjV1BBYXdEZ2lZQm9QZ0Q2REpYZytuaUVUOVlpK3h5?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76bb423-a053-4708-42d9-08dcf2d415e0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 19:59:49.4571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9yRHa/N/v74gfWDf0/bb8nzXVwsbeVpe6DMNz6Re272Sa4BGz5fuMg184LvR3ieYrWiRZM+sFlV5ihphrWfvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6242
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

On 22.10.24 19:00, Simon Glass wrote:
> On Tue, 22 Oct 2024 at 08:06, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> From: Li Hua Qian <huaqian.li@siemens.com>
>>
>> This brings a sysinfo driver and DT entry for the IOT2050 board series.
>> It translates the board information passed from SE-Boot to SPL into
>> values that can be retrieved via the sysinfo API. Will is already used
>> to fill the SMBIOS table when booting via EFI.
>>
>> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
>> [Jan: split-off as separate patch, cleanup]
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  .../dts/k3-am65-iot2050-common-u-boot.dtsi    |  18 +++
>>  configs/iot2050_defconfig                     |   1 +
>>  drivers/sysinfo/Kconfig                       |   7 +
>>  drivers/sysinfo/Makefile                      |   1 +
>>  drivers/sysinfo/iot2050.c                     | 143 ++++++++++++++++++
>>  drivers/sysinfo/iot2050.h                     |  26 ++++
>>  6 files changed, 196 insertions(+)
>>  create mode 100644 drivers/sysinfo/iot2050.c
>>  create mode 100644 drivers/sysinfo/iot2050.h
> 
> I think strlcpy() might be better than strncpy() for this case
> 

Ack.

> The idea with sysinfo is that we use the same enum for all boards, so
> please add your new things to sysinfo.h
> 

See below.

> Do you actually want all the sysinfo info in capitals? If so, that's
> fine, just checking...
> 

This is how it is being shipped already, yes.

>>
>> diff --git a/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi b/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
>> index b6d2c816acc..55337179f9f 100644
>> --- a/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
>> @@ -14,6 +14,24 @@
>>                 spi0 = &ospi0;
>>         };
>>
>> +       sysinfo {
>> +               compatible = "siemens,sysinfo-iot2050";
>> +               /* TI_SRAM_SCRATCH_BOARD_EEPROM_START */
>> +               offset = <0x40280000>;
>> +               bootph-all;
>> +
>> +               smbios {
>> +                       system {
>> +                               manufacturer = "SIEMENS AG";
>> +                               product = "SIMATIC IOT2050";
>> +                       };
>> +
>> +                       baseboard {
>> +                               manufacturer = "SIEMENS AG";
>> +                       };
>> +               };
>> +       };
>> +
>>         leds {
>>                 bootph-all;
>>                 status-led-red {
>> diff --git a/configs/iot2050_defconfig b/configs/iot2050_defconfig
>> index 2624f0cb573..574e232d119 100644
>> --- a/configs/iot2050_defconfig
>> +++ b/configs/iot2050_defconfig
>> @@ -141,6 +141,7 @@ CONFIG_SOC_TI=y
>>  CONFIG_SPI=y
>>  CONFIG_DM_SPI=y
>>  CONFIG_CADENCE_QSPI=y
>> +CONFIG_SYSINFO=y
>>  CONFIG_SYSRESET=y
>>  CONFIG_SPL_SYSRESET=y
>>  CONFIG_SYSRESET_TI_SCI=y
>> diff --git a/drivers/sysinfo/Kconfig b/drivers/sysinfo/Kconfig
>> index 2030e4babc9..df83df69ffb 100644
>> --- a/drivers/sysinfo/Kconfig
>> +++ b/drivers/sysinfo/Kconfig
>> @@ -31,6 +31,13 @@ config SYSINFO_RCAR3
>>         help
>>           Support querying SoC version information for Renesas R-Car Gen3.
>>
>> +config SYSINFO_IOT2050
>> +       bool "Enable sysinfo driver for the Siemens IOT2050"
>> +       depends on TARGET_IOT2050_A53
>> +       default y if TARGET_IOT2050_A53
>> +       help
>> +         Support querying device information for Siemens IOT2050.
>> +
>>  config SYSINFO_SANDBOX
>>         bool "Enable sysinfo driver for the Sandbox board"
>>         help
>> diff --git a/drivers/sysinfo/Makefile b/drivers/sysinfo/Makefile
>> index 680dde77fe8..26ca3150999 100644
>> --- a/drivers/sysinfo/Makefile
>> +++ b/drivers/sysinfo/Makefile
>> @@ -5,6 +5,7 @@
>>  obj-y += sysinfo-uclass.o
>>  obj-$(CONFIG_SYSINFO_GAZERBEAM) += gazerbeam.o
>>  obj-$(CONFIG_SYSINFO_GPIO) += gpio.o
>> +obj-$(CONFIG_SYSINFO_IOT2050) += iot2050.o
>>  obj-$(CONFIG_SYSINFO_RCAR3) += rcar3.o
>>  obj-$(CONFIG_SYSINFO_SANDBOX) += sandbox.o
>>  obj-$(CONFIG_SYSINFO_SMBIOS) += smbios.o
>> diff --git a/drivers/sysinfo/iot2050.c b/drivers/sysinfo/iot2050.c
>> new file mode 100644
>> index 00000000000..5359d6b8d62
>> --- /dev/null
>> +++ b/drivers/sysinfo/iot2050.c
>> @@ -0,0 +1,143 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) Siemens AG, 2024
>> + */
>> +
>> +#include <dm.h>
>> +#include <sysinfo.h>
>> +#include <net.h>
>> +#include <asm/arch/hardware.h>
>> +
>> +#include "iot2050.h"
>> +
>> +#define IOT2050_INFO_MAGIC             0x20502050
>> +
>> +struct iot2050_info {
>> +       u32 magic;
>> +       u16 size;
>> +       char name[20 + 1];
>> +       char serial[16 + 1];
>> +       char mlfb[18 + 1];
>> +       char uuid[32 + 1];
>> +       char a5e[18 + 1];
>> +       u8 mac_addr_cnt;
>> +       u8 mac_addr[8][ARP_HLEN];
>> +       char seboot_version[40 + 1];
>> +       u8 padding[3];
>> +       u32 ddr_size_mb;
>> +} __packed;
>> +
>> +/**
>> + * struct sysinfo_iot2050_priv - sysinfo private data
>> + * @info: iot2050 board info
>> + */
>> +struct sysinfo_iot2050_priv {
>> +       struct iot2050_info *info;
>> +};
>> +
>> +static int sysinfo_iot2050_detect(struct udevice *dev)
>> +{
>> +       struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
>> +
>> +       if (priv->info == NULL || priv->info->magic != IOT2050_INFO_MAGIC)
>> +               return -EFAULT;
>> +
>> +       return 0;
>> +}
>> +
>> +static int sysinfo_iot2050_get_str(struct udevice *dev, int id, size_t size,
>> +                                  char *val)
>> +{
>> +       struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
>> +       char byte_str[3] = {0};
>> +       unsigned int n;
>> +
>> +       switch (id) {
>> +       case BOARD_NAME:
>> +               strncpy(val, priv->info->name, size);
>> +               break;
>> +       case BOARD_SERIAL:
>> +               strncpy(val, priv->info->serial, size);
>> +               break;
>> +       case BOARD_MLFB:
>> +               strncpy(val, priv->info->mlfb, size);
>> +               break;
>> +       case BOARD_UUID:
>> +               for (n = 0; n < min(size, (size_t)16); n++) {
>> +                       memcpy(byte_str, priv->info->uuid + n * 2, 2);
>> +                       val[n] = (char)hextoul(byte_str, NULL);
>> +               }
>> +               break;
>> +       case BOARD_A5E:
>> +               strncpy(val, priv->info->a5e, size);
>> +               break;
>> +       case BOARD_SEBOOT_VER:
>> +               strncpy(val, priv->info->seboot_version, size);
>> +               break;
>> +       case BOARD_MAC_ADDR_1:
>> +       case BOARD_MAC_ADDR_2:
>> +       case BOARD_MAC_ADDR_3:
>> +       case BOARD_MAC_ADDR_4:
>> +       case BOARD_MAC_ADDR_5:
>> +       case BOARD_MAC_ADDR_6:
>> +       case BOARD_MAC_ADDR_7:
>> +       case BOARD_MAC_ADDR_8:
>> +               memcpy(val, priv->info->mac_addr[id - BOARD_MAC_ADDR_START],
>> +                      ARP_HLEN);
> 
> For this, we really need another parameter to get_str(), i.e. the
> index, since we don't know how many MACs there will be. So how about
> adding a few new operations?
> 
> int (*get_item_count)(struct udevice *dev, int id);
> int (*get_str_item)(struct udevice *dev, int id, int index, size_t
> size, char *val);

Ok, makes sense.

> 
>> +               return 0;
>> +       case BOARD_DDR_SIZE:
>> +               memcpy(val, &priv->info->ddr_size_mb,
>> +                      sizeof(priv->info->ddr_size_mb));
>> +               return 0;
>> +       default:
>> +               return -EINVAL;
>> +       };
>> +
>> +       val[size - 1] = '\0';
>> +       return 0;
>> +}
>> +
>> +static int sysinfo_iot2050_get_int(struct udevice *dev, int id, int *val)
>> +{
>> +       struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
>> +
>> +       switch (id) {
>> +       case BOARD_MAC_ADDR_CNT:
>> +               *val = priv->info->mac_addr_cnt;
>> +               return 0;
>> +       default:
>> +               return -EINVAL;
>> +       };
>> +}
>> +
>> +static const struct sysinfo_ops sysinfo_iot2050_ops = {
>> +       .detect = sysinfo_iot2050_detect,
>> +       .get_str = sysinfo_iot2050_get_str,
>> +       .get_int = sysinfo_iot2050_get_int,
>> +};
>> +
>> +static int sysinfo_iot2050_probe(struct udevice *dev)
>> +{
>> +       struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
>> +       unsigned long offset;
>> +
>> +       offset = dev_read_u32_default(dev, "offset",
>> +                                     TI_SRAM_SCRATCH_BOARD_EEPROM_START);
>> +       priv->info = (struct iot2050_info *)offset;
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct udevice_id sysinfo_iot2050_ids[] = {
>> +       { .compatible = "siemens,sysinfo-iot2050" },
>> +       { /* sentinel */ }
>> +};
>> +
>> +U_BOOT_DRIVER(sysinfo_iot2050) = {
>> +       .name           = "sysinfo_iot2050",
>> +       .id             = UCLASS_SYSINFO,
>> +       .of_match       = sysinfo_iot2050_ids,
>> +       .ops            = &sysinfo_iot2050_ops,
>> +       .priv_auto      = sizeof(struct sysinfo_iot2050_priv),
>> +       .probe          = sysinfo_iot2050_probe,
>> +};
>> diff --git a/drivers/sysinfo/iot2050.h b/drivers/sysinfo/iot2050.h
>> new file mode 100644
>> index 00000000000..f659a8282b5
>> --- /dev/null
>> +++ b/drivers/sysinfo/iot2050.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) Siemens AG, 2024
>> + */
>> +
>> +#include <sysinfo.h>
>> +
>> +enum sysinfo_id_iot2050 {
>> +       BOARD_MLFB              = SYSINFO_ID_SMBIOS_SYSTEM_VERSION,
>> +       BOARD_SERIAL            = SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
>> +       BOARD_UUID              = SYSINFO_ID_SMBIOS_SYSTEM_UUID,
>> +       BOARD_A5E               = SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
>> +       BOARD_NAME              = SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
> 
> Do you need to rename these? It seems better to use the standard
> names, although I do think they are quite long.

We don't rename, we map pre-existing field names in EEPROM and
pre-existing board-specific U-Boot env vars to sysinfo fields here.

> 
>> +       BOARD_SEBOOT_VER        = SYSINFO_ID_USER + 0,
>> +       BOARD_MAC_ADDR_CNT      = SYSINFO_ID_USER + 1,
>> +       BOARD_MAC_ADDR_1        = SYSINFO_ID_USER + 2,
>> +       BOARD_MAC_ADDR_START    = BOARD_MAC_ADDR_1,
>> +       BOARD_MAC_ADDR_2        = SYSINFO_ID_USER + 3,
>> +       BOARD_MAC_ADDR_3        = SYSINFO_ID_USER + 4,
>> +       BOARD_MAC_ADDR_4        = SYSINFO_ID_USER + 5,
>> +       BOARD_MAC_ADDR_5        = SYSINFO_ID_USER + 6,
>> +       BOARD_MAC_ADDR_6        = SYSINFO_ID_USER + 7,
>> +       BOARD_MAC_ADDR_7        = SYSINFO_ID_USER + 8,
>> +       BOARD_MAC_ADDR_8        = SYSINFO_ID_USER + 9,
>> +       BOARD_DDR_SIZE          = SYSINFO_ID_USER + 10,
> 
> These are the ones which should be added as standard. Be sure to
> comment them as necessary.

You mean that BOARD_MAC_ADDR and BOARD_DDR_SIZE should become
SYSINFO_ID_BOARD_MAC_ADDR and SYSINFO_ID_BOARD_DDR_SIZE? But
BOARD_SEBOOT_VER is nothing that has any meaning beyond our board.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
