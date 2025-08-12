Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAF5CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 09:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4028C83214;
	Tue, 12 Aug 2025 11:42:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="v9+ltsRm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CC228327A; Tue, 12 Aug 2025 11:42:41 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0165783087
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 11:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWE9eInNQdrPuMkRyq9/vXfou/uTWvmf1isb3zWR8NbSfKusgXz9yWQ+t+WoYfl0oExl5pk4TuEbxmhk+f4aob7QKzyObVVptU5DGCIUo8q7Tsg5rurdDBoggKVUCiu18LrgteO7M64KwQAqrqFzkU77jY2XU6nZsliKBdgF3jZ7r0mpWFXv7LeU/0tc05/EQm5eO9rVFCI49eBuStKGhmik6UjvojrtD5wIt/BEuONmqlqDoWrmtC594glQRlEaxOaZbbI+p3W0OLzHMqLzwaIUQqSH5OjS5RQL/rXIyRjbLqWZpDNOh/XReWp2RoAbsh/TwTZslBuEYfETduVIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcEoa/lSfpupbmaoTsbezFdDjm5uDTntlTdArlcHfq8=;
 b=lCDxmTs935/Vzqrf3aliPSIIWpytNW/wNa/Dfs6iM2BDHDsXFSq1SeHhQNpngsc7bu/ECqQsx+fhOzYgywwXPEtwb+b0piYwEINN6Q03aXd5fjyrzb2Na6PkY2ktsto5Bj7Bq8h7PSEnc5Iz81rAakfZkrmAJJ7yB1MKPNNRB/vC8eoSkhg3GqxQN/UGNJY54HpgHKT8mDitMHnrRhFe9aKsHW4+tQ34ihg0c2IjNoFWs2afyU7d7Q0HK9SPmp233jVUPIrWkKxJLqcyUbaaqh0BUxLxzSy5euORVoO7I8gRR3j9PAiKI/xZ89Lox8txMODyCuL1OUksJhxO6xIncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcEoa/lSfpupbmaoTsbezFdDjm5uDTntlTdArlcHfq8=;
 b=v9+ltsRmDIhw8uvvEYNnuvaYe7qt9UfSbbnPr8yv0au8dAIrxGtKi3+bZcCOULOrtRnVJjcAMURzWYBFWimBQomt06i3JKLPfs31iaJnZwwZ4+5gIjM8mZLKs3RG+KJiU1PQ9ZbctiR1c/3YO1NifKKsWro9j4k8Vyn7+fAdhZBjryX3eNuiCpyBHl/mHXOF2MvS471B29lbba4Iva8TchYI8D/YPu04IFiA4usDLdGIgmWw3d6kjLsDb70c9aLcnsMMY/dQXQ6TIahaxKIUcI4mtdl6EYokdamOqrVHJ8WcuiYJlm6FdZpGWU/Ao+97GDmp0RxMdKNQdE3CXSpPMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VI0PR10MB8428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:231::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 09:42:35 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9009.013; Tue, 12 Aug 2025
 09:42:35 +0000
Message-ID: <21c96d32-0735-400e-9263-17634d7b06a3@kontron.de>
Date: Tue, 12 Aug 2025 11:42:34 +0200
User-Agent: Mozilla Thunderbird
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v4 05/24] mtd: spinand: simulate behavior of linux's
 function spinand_wait()
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250809010457.3125925-6-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
In-Reply-To: <20250809010457.3125925-6-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::13) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|VI0PR10MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9fa23e-9f89-44b9-d7c5-08ddd9849130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0FVOVlaUHJsdWl0L3dhUUR0akVpeWUzdXZEZnZKZ3hYVGluN09hQVB5MTVp?=
 =?utf-8?B?TUowMzZKekdLM0E4MXZjNm1kTWJ3VUJsd3EzeE96cVJKeDVaVHBjQkV0N0Z3?=
 =?utf-8?B?bmtBSmhCZUxDU0xZK0daUzFpOCtXVUp0djdhZWVrcFR3V3ZzRnVNT0p5cXpS?=
 =?utf-8?B?MjN5Wm1UQlllV0dLL3l1dVFUcFNvR2laTUdJcTF5UGJDRGtaZlNWOHR4QTNw?=
 =?utf-8?B?RnI5NlB3R1kzemdDWVhOSzA0ZGhud1ZVUndOaFg4Vzl0bzhvWHdoRkZpc2RI?=
 =?utf-8?B?a0c3QkdPS1ozZlFzZFVLWXVjbUYzQm9TNk1ucHJDYkxJeVJKanFYYVJJbGxj?=
 =?utf-8?B?UGJYMk5NZDZnb3dDcEVBRnUrb1B1ekFEZTNIYU9TUGcyamE2SUJOOUdTTmhB?=
 =?utf-8?B?RmJLU3Z3SHk0bFBqcGhtaEJrazhWS3Z4MUtZdVpqMHNOMW1uT1U5WEZnM1Zp?=
 =?utf-8?B?SmJTenE4REFLdnNJeWZSSlBOZTBvVjNzbml5VmNHSEZHYk02VVo4UTFyendJ?=
 =?utf-8?B?QVZwbFFMejdEVS9xTFpmOFZPaFkrY3FET251TWMzZkM4eHVadGJocUk5ZkdM?=
 =?utf-8?B?RHJyWVFkdUpUWjJjL1Q5cVB3MjdCRXBKeXFLTTltQm45amVqWC9ZTy83TS9l?=
 =?utf-8?B?eEJIMkluOXlWRERoeGVBc1AyQS80Z1Frc2s5MW5vNEFTUTVwMTZ3NTJGZkNH?=
 =?utf-8?B?WlovcWEyU3RSd1dOeUlCUEpabFluSDZRSkFzcUFGdXY0aUZqZGhiaUE2bFBz?=
 =?utf-8?B?cTdIa0xIUjNLUUF4VTN3MXdQd3pGRWhXS2FBMjhMa0dkQUVjbWtRaE01OXJW?=
 =?utf-8?B?eHo1c3BpUmJTeFdvcEIvNHkyMVlOeXMzRFZicTZpQWhMOHpoY2dZWXA0eGMv?=
 =?utf-8?B?Q0c4d1ZGcGpwaU84Uk9pODZoL3ZhUmhLZWVUY01Ob1BYbzQ2LzZ3b3ZHb2Zv?=
 =?utf-8?B?L3prOXlQWmdDaENHeHN3b2M1TmR3cXdtVUpLVWNSVWFFeW95a3VQREQwZjlV?=
 =?utf-8?B?MWY1UzNEd3FSdG1iZU5yempJMmR3cEx3QitQUHFsNjdESzIvVTRQY0NyTmta?=
 =?utf-8?B?V01nallIaUlGK3cySkp0bllKb0RUamRMWnhieDMwSEVvK3dyNkE3cTBhRHA5?=
 =?utf-8?B?UlZOWTEzb1VBT3BZMyt1OGdIMUs1Ukt2b01Ub0dDdE5PRXlXbVZyaEdOSWM4?=
 =?utf-8?B?RDA2MHRGejZ1a0E4ZmkvN25WWUJ3ZCtwQ2w3ejhselh4UE9ndzVpeFB6K3lm?=
 =?utf-8?B?TEUrN0pwc054ZEgxeWtvdVlLWWY5bHZHUW5WUUYxNnpRTytYWUlmSnhNbXlZ?=
 =?utf-8?B?bk9vT0NCcWgrcWtlN3E5eDVObjh3V3p1VWhweFFrTEU3Z09pUmVMeFEvbUdj?=
 =?utf-8?B?ZXNnbTNQZXMvd2NoN1Q4Wm9EYmRCdTdjU1Q4cituS1VPZTBIV2V6R0ZCZ0U5?=
 =?utf-8?B?dXJEL2dVNWIwZmRoYUNRSkdUNU9HTHJPczRpb0k4cExxTGZZc3JwRkVNdW9E?=
 =?utf-8?B?Z3ZOa1NSRUZXNnZTQlh5ZFFHa1pUdGdTUmY2SjlzVHZ6VVhpYUM2K2dJNnRP?=
 =?utf-8?B?TzNLZzlFYmh5QlhTZW5aa3dkdnJJV3F4UUZRWTJVcDZLMis5dm94NzVqMW1i?=
 =?utf-8?B?MVlqV21yY24zWU0yMlVyVnhTZGFhcGpETjF0enpVYTF5LzByV2ljWndudExm?=
 =?utf-8?B?K3FIMndLSktnN3diRExvNmF4d3ZoUHBUSnRsNTVUczB3Vmt4cFhLRnFqQnh2?=
 =?utf-8?B?d2VseXhzWXBMcEJpVHlwbEdYME1jMkFPNGJzSlRuWS8yYmQzSkN5cE9rTWVE?=
 =?utf-8?B?Wkg3YVUvaGx0MmRQVWpXdVJtUkIvTXJGWWtJeXRIUlVOc2l5aVJZTWhpeHl1?=
 =?utf-8?B?K3B5TlNoN2lhV3A4RUxQb2dFSnZqTW1peGQ0SThjVGxLRXBmWnNEa1lUZ1Ar?=
 =?utf-8?B?VzhKWVVTNEtXNmU5R1pNUkw2T1VSaUsyTyt1YlR6c3lKWmdaUVZyNk9KdWVP?=
 =?utf-8?B?UWFGQ2hGNmR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTJBd2ovTkxuTmYvZTlvZHl6YTFVUy8xbHRyU0oxU0RRSUpLNXpzd1lrSWJz?=
 =?utf-8?B?MDJUM01UREdDYnRIamZvRlQvNkRBOEdMVm4vSUJkb1NvUjZIYkdmTGlJQnYv?=
 =?utf-8?B?RzNTRUJVUVRJMERFSGF1Snd2L3UxZ2pSaTBlN284M3A2cEhLSUtGMnBIK2dC?=
 =?utf-8?B?aDczRmJXVWIyMmxVSVg1dE9MSFF0anpCS003bDV0UHl6UmpGT0VMVWV2OCs0?=
 =?utf-8?B?SFppMU5QcHV5YWhnSndZRk9lUG1hUjBCNUVjNEpzM3BMMmU1ZHU5ektJZHlI?=
 =?utf-8?B?L2ZTa0NKYm5qenlMTWJZc3FsK1RJbFM4ZllWQ1lnSTVyUzcvYS82WUdlS0xD?=
 =?utf-8?B?YnIzZkZLNGhSdy8zdjFBdlJrRzZYSDlqM3pzUmFESExncUtUT1NLSVozN3Uy?=
 =?utf-8?B?ZDl5U3Zza1dyNW5HdENNeVRSOU51R0pKcUhRcmxOZGUvSWVvRXdwcndtVkxQ?=
 =?utf-8?B?TE5UZmk1SGlzZnczUXl3bjFWS0pxek9yb29RNllJbStxZXp0d2U0eFdPcU5y?=
 =?utf-8?B?Ty82dDFpNHczdWU0T09HZGxSVEFqcWVrUGVDNVRwUVVySk9zWXZmaDU0N0Ev?=
 =?utf-8?B?cThzTFRQQ2lyY2RGTTZLTitaaWc4MFRrYlZ4ZzRjcGYzMy9tenJ5M1M2eGFO?=
 =?utf-8?B?V2xCMFdwMERSUlBLQ2pPR3lqT2oxVjFZMTVkcmtMcnQxNWV5eFpCaDJRQnJz?=
 =?utf-8?B?Sk9HTlhwcnBQaDROdDU0LzZUREc4THMySFFkSHVqOGtwWVp5bEYxc0pvL1Nt?=
 =?utf-8?B?cjc5YXU0WkVqZkt4LzJ1UFVlcjlDMUY2cGNjd211RTBXRVZXd3d2M1dBbkM5?=
 =?utf-8?B?cCtlT2hDcnYvWmJQekRrcWpwY29KeEN3WDd4Ymp4bzJIdGJZUzlkYmR1Nmh2?=
 =?utf-8?B?OUh5Y051SmhKczh3SWRZam9sWUpIaXRTNkx5YTM1U0UwSjY0YkRnNGEvUWJm?=
 =?utf-8?B?OWZ0bjdrSzdhR0dNT0FzWVJzWW96ckFyb0U2aTdneDFJRW80VDRuRFdvc090?=
 =?utf-8?B?ME1YK1dFQS9LWS83UTRHTTNNWnZ2dHpEY0tqQkY5TElvS0ZYQjd0a3lEbFN0?=
 =?utf-8?B?VDMzK09iMnNLeUYvZjh6bU40SUw4T1gvS3l0ckJSV2JHeFlGZi9Ic2pFdTI1?=
 =?utf-8?B?TGV2akJKM3ZBTFVCWFNUaVlKSmNYN2lhYjh0dkpzblRXUEhYNXRtdk5RZVIy?=
 =?utf-8?B?dm5YNlNvOFJwTitta2g2b3hBbkFyZHZ0K1MvYmdGT0gwZHc5TXNMZzhFZWxN?=
 =?utf-8?B?RDhPdHNORS9ONmd4WTh5RlJsQUNwSVVqeVpGd0FHSWg5UG90ZXM1WENVNUFa?=
 =?utf-8?B?V1puNnpVU2NmbkJyN0sxeXdRdlhSeE5UYVdkaEVIbzh6T1ppZTFhK3VZL2ky?=
 =?utf-8?B?cVZtU2laMklHcFNGNkpKaWsyeDNjcTl2OTJMdGJXU3gzQ3htMDhpYjV0YkRF?=
 =?utf-8?B?WlkvaHhUcEgrMGpIRmxFZUhRZTFiYm5jQnpvVjJTSUVtTXdnWlVORzlWUVBk?=
 =?utf-8?B?UnhOMlgvWVp1U2ljR2VHY3RFZTFSMUNqSkxFNURDK3RzMk5kanE1aGluOG1Q?=
 =?utf-8?B?c014RGk5MVpRYlphZkZwOFM2KzFaZERlaFJ1aTNoNVM2eXZ2ejY1eUcxK0l0?=
 =?utf-8?B?TEc0UXN5cXhmWjUvRHVxYXFKaDhXZFUrV1FPVE9XODAzYnUya1JSLzNVWHZp?=
 =?utf-8?B?Qm5Pa0FuRDJkSVUwTVJJZDlOeTJDRVdyNGd1N3lvdHczQUVwd1Q4SnRkZDJP?=
 =?utf-8?B?Ri95NFgydm5aRUlJUWNlK1NFM3ZZYXVOM2ZraGZZZlVSSVRCejNOdzFocnI5?=
 =?utf-8?B?MndUdytHVTRQUzBXVy9jMVoxOXVBZ1ZaNWgzT0ozYjNjTVRzWHdkMHdwTEZG?=
 =?utf-8?B?Wm5zTVNreFk1K0VNUUpQR3hYUUpudk5GN1V5Qm1CZjBqOWNycmhKK01HdHE5?=
 =?utf-8?B?QzE5Rk9SazA4aTRRdityOEhTQ3VPWEtzTGZnWmRITE5hcDNaMGFOY2NYUW95?=
 =?utf-8?B?SjY4RDU2OVNrS04yQWtRWm5kbTFOLzVIYk8rWXlQNXNjdGY4TzVSZnpldzdT?=
 =?utf-8?B?cCtqSUtEaHFBMUszMTlPZjYxUVA2cWFneTF4ZEc3ZzVackgrck9RT2Fqamow?=
 =?utf-8?B?d3FyTmJVMHp4amVIRldGY2orWWtpakdmbmVFTWVFOUM5ay9LckszTXBCUGxx?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9fa23e-9f89-44b9-d7c5-08ddd9849130
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:42:35.3253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yuna6tCyc+CPESUItwKu76oiJUSVeBlVqFO7CDVqbqZ2h4Cyfuh5ptzRhcFGk7rvOlnR8cZBWEgJZqhS7RQVmi8cl/Bcd53shuYcZGVhp8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8428
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

Am 09.08.25 um 03:04 schrieb Mikhail Kshevetskiy:
> also call schedule() to allow periodic actions

I don't think "simulate" is a good verb here. What about the following:

###
mtd: spinand: Extend spinand_wait() to match Linux kernel implementation

This aligns spinand_wait() with the kernel. Instead of calling into
spi_mem_poll_status() which is not implemented in U-Boot, we open-code
the polling logic and make sure that schedule() is called periodically.
###

> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/spi/core.c | 35 ++++++++++++++++++++++++++++-------
>  include/linux/mtd/spinand.h | 22 ++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 34e5ac33c63..f99568050fb 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -32,6 +32,7 @@
>  #include <linux/bug.h>
>  #include <linux/mtd/spinand.h>
>  #include <linux/printk.h>
> +#include <linux/delay.h>
>  #endif
>  
>  struct spinand_plat {
> @@ -362,21 +363,29 @@ static int spinand_erase_op(struct spinand_device *spinand,
>  	return spi_mem_exec_op(spinand->slave, &op);
>  }
>  
> -static int spinand_wait(struct spinand_device *spinand, u8 *s)
> +static int spinand_wait(struct spinand_device *spinand,

You are adding the kdoc header for this function in patch 17 of this
series. It would be nice to include it here in this patch instead.

> +			unsigned long initial_delay_us,
> +			unsigned long poll_delay_us,
> +			u8 *s)
>  {
>  	unsigned long start, stop;
>  	u8 status;
>  	int ret;
>  
> +	udelay(initial_delay_us);
>  	start = get_timer(0);
> -	stop = 400;
> +	stop = SPINAND_WAITRDY_TIMEOUT_MS;
>  	do {
> +		schedule();
> +
>  		ret = spinand_read_status(spinand, &status);
>  		if (ret)
>  			return ret;
>  
>  		if (!(status & STATUS_BUSY))
>  			goto out;
> +
> +		udelay(poll_delay_us);
>  	} while (get_timer(start) < stop);
>  
>  	/*
> @@ -418,7 +427,10 @@ static int spinand_reset_op(struct spinand_device *spinand)
>  	if (ret)
>  		return ret;
>  
> -	return spinand_wait(spinand, NULL);
> +	return spinand_wait(spinand,
> +			    SPINAND_RESET_INITIAL_DELAY_US,
> +			    SPINAND_RESET_POLL_DELAY_US,
> +			    NULL);
>  }
>  
>  static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
> @@ -466,7 +478,10 @@ static int spinand_read_page(struct spinand_device *spinand,
>  	if (ret)
>  		return ret;
>  
> -	ret = spinand_wait(spinand, &status);
> +	ret = spinand_wait(spinand,
> +			   SPINAND_READ_INITIAL_DELAY_US,
> +			   SPINAND_READ_POLL_DELAY_US,
> +			   &status);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -498,9 +513,12 @@ static int spinand_write_page(struct spinand_device *spinand,
>  	if (ret)
>  		return ret;
>  
> -	ret = spinand_wait(spinand, &status);
> +	ret = spinand_wait(spinand,
> +			   SPINAND_WRITE_INITIAL_DELAY_US,
> +			   SPINAND_WRITE_POLL_DELAY_US,
> +			   &status);
>  	if (!ret && (status & STATUS_PROG_FAILED))
> -		ret = -EIO;
> +		return -EIO;
>  
>  	return ret;
>  }
> @@ -702,7 +720,10 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
>  	if (ret)
>  		return ret;
>  
> -	ret = spinand_wait(spinand, &status);
> +	ret = spinand_wait(spinand,
> +			   SPINAND_ERASE_INITIAL_DELAY_US,
> +			   SPINAND_ERASE_POLL_DELAY_US,
> +			   &status);
>  	if (!ret && (status & STATUS_ERASE_FAILED))
>  		ret = -EIO;
>  
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 163269313f6..ba6c2ba149d 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -176,6 +176,28 @@ struct spinand_op;
>  struct spinand_device;
>  
>  #define SPINAND_MAX_ID_LEN	4
> +/*
> + * For erase, write and read operation, we got the following timings :
> + * tBERS (erase) 1ms to 4ms
> + * tPROG 300us to 400us
> + * tREAD 25us to 100us
> + * In order to minimize latency, the min value is divided by 4 for the
> + * initial delay, and dividing by 20 for the poll delay.
> + * For reset, 5us/10us/500us if the device is respectively
> + * reading/programming/erasing when the RESET occurs. Since we always
> + * issue a RESET when the device is IDLE, 5us is selected for both initial
> + * and poll delay.
> + */
> +#define SPINAND_READ_INITIAL_DELAY_US	6
> +#define SPINAND_READ_POLL_DELAY_US	5
> +#define SPINAND_RESET_INITIAL_DELAY_US	5
> +#define SPINAND_RESET_POLL_DELAY_US	5
> +#define SPINAND_WRITE_INITIAL_DELAY_US	75
> +#define SPINAND_WRITE_POLL_DELAY_US	15
> +#define SPINAND_ERASE_INITIAL_DELAY_US	250
> +#define SPINAND_ERASE_POLL_DELAY_US	50
> +
> +#define SPINAND_WAITRDY_TIMEOUT_MS	400
>  
>  /**
>   * struct spinand_id - SPI NAND id structure

