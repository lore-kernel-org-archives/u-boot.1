Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B12D2E00A
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 04:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDA3588A4C;
	Wed, 23 Oct 2024 06:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="ANn1AWKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A237488A3D; Wed, 23 Oct 2024 06:14:48 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDFD5892D4
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9T5ea8TpMtW0lZ8PSPm5opuQJsL9bVPBVizIWiDB5T3eCeegq0Vpf5NFI8awa4Gr6Aftg8jcWTrZfrZhrhrYL5cCoxUiacIxCqsqFAXUfpyrMxR7Nm+LNTOgibobl7OsyUJvAw4K+YotKjUhIMLfQVI0fpqnLsXL1PpDWg/YIH6v+386M03ELZJvL6QuIZCXxbMIkLunY8+W2Mg7eKzgBa1fk2DGd9wzAr5B5IP6v/kqmS4c0qiu3eO3E09GPPobOA434jJiLmV+PQclSBvGV6Oo5i9TjvwTS0cum6+scA0Sr5HlQiBFmUSMb+QDzW3Vdd9gWYHddHb6daISGh1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfYZcigZE3lBH93Gvuyls4t2+U4UeuNOq3Tfq5P0JFM=;
 b=eFTcQIiPOL+90caA576GyHGZ4gy/OGiR/mvumZXvOFcRaIdsifBD8QIjIhFznySGeWAZ4zUyV9+jd79jVoM9d5Nnd2/SFRV1Y0MjS6UelO5NzfTj5VybAzyRcRYjAxS4hOJ1bsCRP0wKJhNmogNAdQ6SfCyp9T3JKdeajs8BUFwo76qKEDGUEk/Sz+No4Ga1M2RC8cMH8s/NoCpuHafMhJXtZzJyzGku6ShZyfRV9exQLkDjCfzV0ExGjTUUjlKN/ceg0m6rM4TXsgXH8wHIfxEd/aw7vCXYlgO6Xy/JIMeE4rQu11W1pbe80x9xpK1bQ9+CqPM6761dkfwkRQBcOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfYZcigZE3lBH93Gvuyls4t2+U4UeuNOq3Tfq5P0JFM=;
 b=ANn1AWKQnDzxAzKPhHcyX7lzBnKBVzbI5gz6DNgm4knSGYGQfroBrJ3uO9MAWZ47qpwv4DkFNFTdrWstSDx3K7XDFR1L5oHWcsSOEBMlZhGQn3RHAjkbaCgmK5JX3TeeFa7+LLVUm9lhgC0VmOVvPVkUZqRTntnZLlYy/PLRNjVUor/OklrGqe+bRG66eR1Rpo+BpdYAqEyMs9rpTBodycbWGNSiGI7reqanPHBMmZLjd4jbzRYGRUJWdN26bJb0picS6MbQrvMUBFe3lkuOUvfdDtFEler4r+tSldBRkzP3OLd6hGJQn9tBukwa0emHLUY9zOhfGh7cmfFLF3Llpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB7959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 04:14:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 04:14:43 +0000
Message-ID: <4e8a8120-7ad8-45e4-9373-2d1772ee6304@siemens.com>
Date: Wed, 23 Oct 2024 06:14:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] sysinfo: Add driver for IOT2050 boards
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>,
 "Li, Hua Qian (DI FA CTR IPC CN PRC4)" <huaqian.li@siemens.com>
References: <cover.1729577070.git.jan.kiszka@siemens.com>
 <64b2dae0ae60feded514b774f0e91c303c81a52d.1729577070.git.jan.kiszka@siemens.com>
 <CAFLszTgYaBh8ccEVoRAhGDAysY=XY=5es1k6TmF=mWBEHyYUAA@mail.gmail.com>
 <f1ef1ad7-f4ce-4b96-931b-d51c77a86e8d@siemens.com>
 <CAFLszTgucPfjD5wt4jeM=_Dk7N9URxtW-5WYoNcdPiSZwm3RMA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLszTgucPfjD5wt4jeM=_Dk7N9URxtW-5WYoNcdPiSZwm3RMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fe051e-3622-44b5-e419-08dcf3193915
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFNqRFNTRnhEcnBOSHpyZFdjMG1vQm9LY3VsdzRXS0c2d0s5aTc1U3ZyOVl1?=
 =?utf-8?B?eWl6WVJWTnBKUjFVcFY5OXJvOE5nbFc5RTE4d2NpR09mYVZnci9LMVdLT1VH?=
 =?utf-8?B?ZC9LMjZRQTBHR2ZOengzbENHdlQxZWtob0lGMHlWUzd0MUczUkZHcjg2aVgy?=
 =?utf-8?B?ZHQzamhWRGpTWkpzQTljeDBDUFhYU2YyNTJ6TmZ5R1RmekJwN2JMMHNiaFJQ?=
 =?utf-8?B?UDFISEhKc2dtM1dYeWNmNklJakxNd0lsNDV2dmRjTi9mMXltYnlBK1doNTho?=
 =?utf-8?B?c1d5bVYrOHlRTDgzNnI0bVR0ekc1ZktKRzBiNjVydGZiT09NWFZjdlh6cklH?=
 =?utf-8?B?alVZTk1ZUzZMQXpaUUxTVCs3TkJJOHdPTGFLcStmL2Z5bU9VbWgwSVdNaWlM?=
 =?utf-8?B?MVNzQ3R0ZnZhWUg2ZTN5VmFSS0NsRldyNWVwNkNWVFNQMk9vL2xHUWwraUQy?=
 =?utf-8?B?TXl0WVpoeUxkRnNGeVJuelFLNFM2RHNOTFFQcWhySzQzMUVLaEF5V2dma25Q?=
 =?utf-8?B?SHYxTW95K0tEd3EyQU5YK2c3UWpndm4zcmdGVmllaitvcnlQN1VJKzVWWVp1?=
 =?utf-8?B?Yk5kODdvN0NRWVVnbS9EcnhsenYzeWMyN1o3anU1bHRWd0tHYm8wbU0wTGoy?=
 =?utf-8?B?bDUrMWF0M2RHamNVZGF6ZitVaCtFdjVpaDNVYjIvVytFcDBPZnU0dGJrTG5q?=
 =?utf-8?B?NUNmdTVvWmdILzNzNG5ldkRSME5uOGwzaG8yQmtrWXF1Z1pmRHNUQ09iUW9Y?=
 =?utf-8?B?YWJYVlEwR05lcUZmZmp6TFpndVQza3Zra01ZRm0vekZWd294a0lVU0ROZThD?=
 =?utf-8?B?bUMzeDJXMkZ4U1VBaUVrNmdkVFkxQXQxcXFBTThSaWJ3dGZSWWhNWmFsd0xF?=
 =?utf-8?B?U0FqbmxKRFpZQ2wzQlRrOTRFTCtwcHV6RC8xeGhQQ2Z4ak9Id0kxUjBMSnRB?=
 =?utf-8?B?d1FBZVZBMmM5OFNpN3IrRVBVRVdwNXV3cDFXamEybWI3OEx0S2VqVW9uRkdV?=
 =?utf-8?B?ZUgrZWFvaGdiMzVPd0JHb21yNlNyMjhlZE52OGtlYVNHa0d4VzNCRWpxS0R5?=
 =?utf-8?B?VzNiZUxHVEdKaXZuUEl3TlJVdjRQazFsUCtiUzlWdVE0ME8vc1BMbHltRktY?=
 =?utf-8?B?eWdVQVh0dURsdWo3WUlXN3hUVDJ3YXRUM2pwSnJ2TGxmcDZBMnVYRGJlSWxR?=
 =?utf-8?B?NUdpcm5KNDhNTm8yUWRmYWN5ck9wU0RSOTBZNE54YkZVRXFaZnFCYmdqaDBs?=
 =?utf-8?B?OU02cnpDeE1pU0ZMWUp6dDVPVzJCSk9nSlA2c0Z1RTF1Mks1N1VHSDBHRHlv?=
 =?utf-8?B?dTRRNThSWmltYnk5YXA3dVhmUmhzQ2V2cThEN05hZyt3Vm5YTXplem90SmlB?=
 =?utf-8?B?bDYvVld1RmRRNDlZYlNwc1NXTEMxZGNTY2tYVFBodnNrRUFjNTkzL1dORjhx?=
 =?utf-8?B?bWxDaXc4ekpaYlhoSEdya2loYmdEQzV4QVZ2bUdwcFg5VkhERkRWTk5NcHFx?=
 =?utf-8?B?OG5KUkEyWlYzZW11QnQxQUErRGF4NkRkRm96WHpOcXZ0OG40VW4xRTZvSmQx?=
 =?utf-8?B?MStSRE5rWXA5ZW1yeHRkVmFqdjg5ZUhNbjRuc2V2NmIwL3VEVDNrQWptUWtQ?=
 =?utf-8?B?ajFHU2t0dDFnRmZxeDNoWFM2NGMranRxMCtMeW41dnVXVnluUkdHRFdWLzQr?=
 =?utf-8?B?Rm9KTmRMWFBaYm9qWjdTckRUTERHdkhva0hPY29JczNFdWtsWjV4MVR6TzZh?=
 =?utf-8?Q?uBZYhcA0rNKxsLxybdCHBTgqftAQEWPl9dm0XO3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU82VUczWHZWb0lRcExnb1gvMlpGN3pGTnBKdkoyZjM4MDh5NVBkZXJpM2hi?=
 =?utf-8?B?ckRkcXR4M2ZnK2N4OGV1YnZ1TUo3OXl2b3dYWmJXZGdiNmE1Qjc4WUxZeDJX?=
 =?utf-8?B?TnYyTDk0RTJMT3FoekNSVnFSeS9XeEZDRjJ5dTFqdHpLQXArUkp4eHI2TDEr?=
 =?utf-8?B?WC9qMVgyck96dWRsL0IzaDhYSU0wVmp4a1ZrOC80ZEp2VW1HWnVmbGZJaDZv?=
 =?utf-8?B?Zk54VERHN3BQbXJLd3ZQZ1BtblViYXhwTFdUbnN1RStieFR0QTN1R3VqWmR2?=
 =?utf-8?B?RjZFblEwN0p5azd3a0lubjVtbHVnNTFJQS96Z2RiTmU1ZERzdUhEcEtXQ0hr?=
 =?utf-8?B?VCtMMHNMY3BtMnlrdGw5VDg3NUFmU3RGeXlRU0xjYlhIYmY0OGNHanpDcVlm?=
 =?utf-8?B?TWx5K1JzMUptNTA4MSthVmI3T0hRcGVPanI2ZXUxNWFQOEFab0ttYVkraytC?=
 =?utf-8?B?ZU1jR0NoRDRCUGRYa1FjdFZTQ3FzWVNheXVTVU9xUHJMM2t2c20xUFJsdmVl?=
 =?utf-8?B?K29HZWFiWUpRZTlZb2dkN2x3QTUwNmo5UFE0ZGJzZk9vV1RzNXdJQnd5Ny84?=
 =?utf-8?B?YzBESnczUEo4OHZTMWdLdHNIZ0M3TkU1U1hHKzdneXBkSUxVWWdPMWJNbWpC?=
 =?utf-8?B?YjU5Mlh3LzRoYVBRM0RCQlhRYUVhdkxGSURDa0VrSVhaZUlRVUJUOWdXUW9v?=
 =?utf-8?B?K1lxSTZuT1h2UjlQdE1OVlFyTk9VM2tVWUtWMmVUREFCRkQ4M2tkVStCRE9a?=
 =?utf-8?B?d01MbGJXUUdIbXVPZkkvV1Zyb3VKTWp4NHBYcjAvdzA2ckV4OStCYzJnaklB?=
 =?utf-8?B?YjMrZ0Y1ai9QUUVYczBMLzZWOTkyU1NIUXdEV0lwaHg0aEpJZktkK2JrWGpy?=
 =?utf-8?B?ZUpDb0FHMGFHMCtkemMxeGNSZzI4SUlQRWZnMnN2YkhaZUV0ZXNKZEF1NUlz?=
 =?utf-8?B?alJIc0xmcGhtVDJzcHJ4QUlTYzVFUzdIemduRC90RUU3Z1kwVEc1amhFK1J6?=
 =?utf-8?B?VzZwMDdMNzF4eDJ3MlB4S0s4Z1hHYksvcjdTQlg5MzNtUElGRnVzSmg2Snlp?=
 =?utf-8?B?VWRYVk8ySFU4aGNzd25ISHpTckJpNkNIR1BlZFFXU3dkRWRHQ1RUY2krdFp0?=
 =?utf-8?B?N2NCbjRWTDlmY1NsUDF4dVNPazdhR3pnYytpVER4M1Q0TzREODErOVB4MDl6?=
 =?utf-8?B?R09hS05YWURwcitFOGZzYXJ6SXpiT3NteVl0M0hDUzl1VG1VakpGWThzVXZh?=
 =?utf-8?B?enRZR2ZmVDFYSGRLdXVhL0NCOVpUYWxjb2sxOXVRMjJaS2s5UmFVSDlYVnVr?=
 =?utf-8?B?Z3J6MlNTY0RBODNMbzIwN3RsYWNJTkhBb0tXZUVuZDFUNnFsWXhEN0hIKzdE?=
 =?utf-8?B?Q1YxT2hSVVNnNG9BTVJ6K1M1Y25udWkwVFRaRmtQQ3NMaEJxbUZIUkcyYjRM?=
 =?utf-8?B?UUNveHRwZUZQMnFPRzY2SHhrMnFnOHBOenhjb1llc0wwRFpxRzc5K0p6REIy?=
 =?utf-8?B?SW1OZDZ3MXhtUkNadWFCZEdkZlBvNFBZd0paRk4wRDlFY3dCcFNKUTBwRks0?=
 =?utf-8?B?TGFaQjVhc29UUlZZK01jQmprOEpGR202aUVUeFN4SytMWmUvRXlHQjU4T1dh?=
 =?utf-8?B?YXVXQkk3SGZzRjRTdkF4Q0RiMEFkbEg1SmFaeDczU1hYZFVtNURoaiszSzdu?=
 =?utf-8?B?bXpMWGZUUG4wcVFGeHVNMzQ4elhiVE9xbXIwY3JycVlDNWNRdVdZUWpoc1Nq?=
 =?utf-8?B?SzM1MkcyRjhqWlJxbXlwVy84MjNWV3FTQyszUmhrNGNmNGtyL0ZGMHFhcGFG?=
 =?utf-8?B?bEdxcXhNSkROQVRjUzA3YmRxMWhIK0FkNG9hZmlIVDQvTTV1aEtyUDFOZDAv?=
 =?utf-8?B?Um4xZXovVStpenByMktIZ3JUSUdLcGY3Wk15RHFhWjBMTXlkelpJZ1NCMUg5?=
 =?utf-8?B?VGZIeWZTanI4UW1RUjdnWGN0eDlZV3FlNWJ6Si9hQnV5Z0tmRFl2ejBGQTFn?=
 =?utf-8?B?cHhyQ1JoTytBemRiYk9MWE9mSjNXelBlMjdsWlVJWW9yZHFwcUw1Q0lXeEo4?=
 =?utf-8?B?cDJDc2ZxYlhVMHN4ZXdnSnRLWW9jdmJOQWUwbGVEOG95NHorTmpEMUwxQ00y?=
 =?utf-8?B?VndmSXliZVZLNDI4SXFGYU1LRnBmTTFjMzI0RitzTDZEdzBkZTUwMHVZTkVG?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fe051e-3622-44b5-e419-08dcf3193915
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:14:43.7998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FI2rX1qNZRAP5TQSynhahI0RchTYkXUR1xylLiXVIWNBj0ddgJakMhq21iCZHRcJYf4ZAIh7ls7bTzq0TVkWDQ==
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
> On Tue, 22 Oct 2024 at 21:59, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 22.10.24 19:00, Simon Glass wrote:
>>> On Tue, 22 Oct 2024 at 08:06, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> From: Li Hua Qian <huaqian.li@siemens.com>
>>>>
>>>> This brings a sysinfo driver and DT entry for the IOT2050 board series.
>>>> It translates the board information passed from SE-Boot to SPL into
>>>> values that can be retrieved via the sysinfo API. Will is already used
>>>> to fill the SMBIOS table when booting via EFI.
>>>>
>>>> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
>>>> [Jan: split-off as separate patch, cleanup]
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>  .../dts/k3-am65-iot2050-common-u-boot.dtsi    |  18 +++
>>>>  configs/iot2050_defconfig                     |   1 +
>>>>  drivers/sysinfo/Kconfig                       |   7 +
>>>>  drivers/sysinfo/Makefile                      |   1 +
>>>>  drivers/sysinfo/iot2050.c                     | 143 ++++++++++++++++++
>>>>  drivers/sysinfo/iot2050.h                     |  26 ++++
>>>>  6 files changed, 196 insertions(+)
>>>>  create mode 100644 drivers/sysinfo/iot2050.c
>>>>  create mode 100644 drivers/sysinfo/iot2050.h
>>>
>>> I think strlcpy() might be better than strncpy() for this case
>>>
>>
>> Ack.
>>
>>> The idea with sysinfo is that we use the same enum for all boards, so
>>> please add your new things to sysinfo.h
>>>
>>
>> See below.
>>
>>> Do you actually want all the sysinfo info in capitals? If so, that's
>>> fine, just checking...
>>>
>>
>> This is how it is being shipped already, yes.
>>
>>>>
>>>> diff --git a/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi b/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
>>>> index b6d2c816acc..55337179f9f 100644
>>>> --- a/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
>>>> +++ b/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
>>>> @@ -14,6 +14,24 @@
>>>>                 spi0 = &ospi0;
>>>>         };
>>>>
>>>> +       sysinfo {
>>>> +               compatible = "siemens,sysinfo-iot2050";
>>>> +               /* TI_SRAM_SCRATCH_BOARD_EEPROM_START */
>>>> +               offset = <0x40280000>;
>>>> +               bootph-all;
>>>> +
>>>> +               smbios {
>>>> +                       system {
>>>> +                               manufacturer = "SIEMENS AG";
>>>> +                               product = "SIMATIC IOT2050";
>>>> +                       };
>>>> +
>>>> +                       baseboard {
>>>> +                               manufacturer = "SIEMENS AG";
>>>> +                       };
>>>> +               };
>>>> +       };
>>>> +
>>>>         leds {
>>>>                 bootph-all;
>>>>                 status-led-red {
>>>> diff --git a/configs/iot2050_defconfig b/configs/iot2050_defconfig
>>>> index 2624f0cb573..574e232d119 100644
>>>> --- a/configs/iot2050_defconfig
>>>> +++ b/configs/iot2050_defconfig
>>>> @@ -141,6 +141,7 @@ CONFIG_SOC_TI=y
>>>>  CONFIG_SPI=y
>>>>  CONFIG_DM_SPI=y
>>>>  CONFIG_CADENCE_QSPI=y
>>>> +CONFIG_SYSINFO=y
>>>>  CONFIG_SYSRESET=y
>>>>  CONFIG_SPL_SYSRESET=y
>>>>  CONFIG_SYSRESET_TI_SCI=y
>>>> diff --git a/drivers/sysinfo/Kconfig b/drivers/sysinfo/Kconfig
>>>> index 2030e4babc9..df83df69ffb 100644
>>>> --- a/drivers/sysinfo/Kconfig
>>>> +++ b/drivers/sysinfo/Kconfig
>>>> @@ -31,6 +31,13 @@ config SYSINFO_RCAR3
>>>>         help
>>>>           Support querying SoC version information for Renesas R-Car Gen3.
>>>>
>>>> +config SYSINFO_IOT2050
>>>> +       bool "Enable sysinfo driver for the Siemens IOT2050"
>>>> +       depends on TARGET_IOT2050_A53
>>>> +       default y if TARGET_IOT2050_A53
>>>> +       help
>>>> +         Support querying device information for Siemens IOT2050.
>>>> +
>>>>  config SYSINFO_SANDBOX
>>>>         bool "Enable sysinfo driver for the Sandbox board"
>>>>         help
>>>> diff --git a/drivers/sysinfo/Makefile b/drivers/sysinfo/Makefile
>>>> index 680dde77fe8..26ca3150999 100644
>>>> --- a/drivers/sysinfo/Makefile
>>>> +++ b/drivers/sysinfo/Makefile
>>>> @@ -5,6 +5,7 @@
>>>>  obj-y += sysinfo-uclass.o
>>>>  obj-$(CONFIG_SYSINFO_GAZERBEAM) += gazerbeam.o
>>>>  obj-$(CONFIG_SYSINFO_GPIO) += gpio.o
>>>> +obj-$(CONFIG_SYSINFO_IOT2050) += iot2050.o
>>>>  obj-$(CONFIG_SYSINFO_RCAR3) += rcar3.o
>>>>  obj-$(CONFIG_SYSINFO_SANDBOX) += sandbox.o
>>>>  obj-$(CONFIG_SYSINFO_SMBIOS) += smbios.o
>>>> diff --git a/drivers/sysinfo/iot2050.c b/drivers/sysinfo/iot2050.c
>>>> new file mode 100644
>>>> index 00000000000..5359d6b8d62
>>>> --- /dev/null
>>>> +++ b/drivers/sysinfo/iot2050.c
>>>> @@ -0,0 +1,143 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (c) Siemens AG, 2024
>>>> + */
>>>> +
>>>> +#include <dm.h>
>>>> +#include <sysinfo.h>
>>>> +#include <net.h>
>>>> +#include <asm/arch/hardware.h>
>>>> +
>>>> +#include "iot2050.h"
>>>> +
>>>> +#define IOT2050_INFO_MAGIC             0x20502050
>>>> +
>>>> +struct iot2050_info {
>>>> +       u32 magic;
>>>> +       u16 size;
>>>> +       char name[20 + 1];
>>>> +       char serial[16 + 1];
>>>> +       char mlfb[18 + 1];
>>>> +       char uuid[32 + 1];
>>>> +       char a5e[18 + 1];
>>>> +       u8 mac_addr_cnt;
>>>> +       u8 mac_addr[8][ARP_HLEN];
>>>> +       char seboot_version[40 + 1];
>>>> +       u8 padding[3];
>>>> +       u32 ddr_size_mb;
>>>> +} __packed;
>>>> +
>>>> +/**
>>>> + * struct sysinfo_iot2050_priv - sysinfo private data
>>>> + * @info: iot2050 board info
>>>> + */
>>>> +struct sysinfo_iot2050_priv {
>>>> +       struct iot2050_info *info;
>>>> +};
>>>> +
>>>> +static int sysinfo_iot2050_detect(struct udevice *dev)
>>>> +{
>>>> +       struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
>>>> +
>>>> +       if (priv->info == NULL || priv->info->magic != IOT2050_INFO_MAGIC)
>>>> +               return -EFAULT;
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int sysinfo_iot2050_get_str(struct udevice *dev, int id, size_t size,
>>>> +                                  char *val)
>>>> +{
>>>> +       struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
>>>> +       char byte_str[3] = {0};
>>>> +       unsigned int n;
>>>> +
>>>> +       switch (id) {
>>>> +       case BOARD_NAME:
>>>> +               strncpy(val, priv->info->name, size);
>>>> +               break;
>>>> +       case BOARD_SERIAL:
>>>> +               strncpy(val, priv->info->serial, size);
>>>> +               break;
>>>> +       case BOARD_MLFB:
>>>> +               strncpy(val, priv->info->mlfb, size);
>>>> +               break;
>>>> +       case BOARD_UUID:
>>>> +               for (n = 0; n < min(size, (size_t)16); n++) {
>>>> +                       memcpy(byte_str, priv->info->uuid + n * 2, 2);
>>>> +                       val[n] = (char)hextoul(byte_str, NULL);
>>>> +               }
>>>> +               break;
>>>> +       case BOARD_A5E:
>>>> +               strncpy(val, priv->info->a5e, size);
>>>> +               break;
>>>> +       case BOARD_SEBOOT_VER:
>>>> +               strncpy(val, priv->info->seboot_version, size);
>>>> +               break;
>>>> +       case BOARD_MAC_ADDR_1:
>>>> +       case BOARD_MAC_ADDR_2:
>>>> +       case BOARD_MAC_ADDR_3:
>>>> +       case BOARD_MAC_ADDR_4:
>>>> +       case BOARD_MAC_ADDR_5:
>>>> +       case BOARD_MAC_ADDR_6:
>>>> +       case BOARD_MAC_ADDR_7:
>>>> +       case BOARD_MAC_ADDR_8:
>>>> +               memcpy(val, priv->info->mac_addr[id - BOARD_MAC_ADDR_START],
>>>> +                      ARP_HLEN);
>>>
>>> For this, we really need another parameter to get_str(), i.e. the
>>> index, since we don't know how many MACs there will be. So how about
>>> adding a few new operations?
>>>
>>> int (*get_item_count)(struct udevice *dev, int id);
>>> int (*get_str_item)(struct udevice *dev, int id, int index, size_t
>>> size, char *val);
>>
>> Ok, makes sense.
>>
>>>
>>>> +               return 0;
>>>> +       case BOARD_DDR_SIZE:
>>>> +               memcpy(val, &priv->info->ddr_size_mb,
>>>> +                      sizeof(priv->info->ddr_size_mb));
>>>> +               return 0;
>>>> +       default:
>>>> +               return -EINVAL;
>>>> +       };
>>>> +
>>>> +       val[size - 1] = '\0';
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int sysinfo_iot2050_get_int(struct udevice *dev, int id, int *val)
>>>> +{
>>>> +       struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
>>>> +
>>>> +       switch (id) {
>>>> +       case BOARD_MAC_ADDR_CNT:
>>>> +               *val = priv->info->mac_addr_cnt;
>>>> +               return 0;
>>>> +       default:
>>>> +               return -EINVAL;
>>>> +       };
>>>> +}
>>>> +
>>>> +static const struct sysinfo_ops sysinfo_iot2050_ops = {
>>>> +       .detect = sysinfo_iot2050_detect,
>>>> +       .get_str = sysinfo_iot2050_get_str,
>>>> +       .get_int = sysinfo_iot2050_get_int,
>>>> +};
>>>> +
>>>> +static int sysinfo_iot2050_probe(struct udevice *dev)
>>>> +{
>>>> +       struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
>>>> +       unsigned long offset;
>>>> +
>>>> +       offset = dev_read_u32_default(dev, "offset",
>>>> +                                     TI_SRAM_SCRATCH_BOARD_EEPROM_START);
>>>> +       priv->info = (struct iot2050_info *)offset;
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static const struct udevice_id sysinfo_iot2050_ids[] = {
>>>> +       { .compatible = "siemens,sysinfo-iot2050" },
>>>> +       { /* sentinel */ }
>>>> +};
>>>> +
>>>> +U_BOOT_DRIVER(sysinfo_iot2050) = {
>>>> +       .name           = "sysinfo_iot2050",
>>>> +       .id             = UCLASS_SYSINFO,
>>>> +       .of_match       = sysinfo_iot2050_ids,
>>>> +       .ops            = &sysinfo_iot2050_ops,
>>>> +       .priv_auto      = sizeof(struct sysinfo_iot2050_priv),
>>>> +       .probe          = sysinfo_iot2050_probe,
>>>> +};
>>>> diff --git a/drivers/sysinfo/iot2050.h b/drivers/sysinfo/iot2050.h
>>>> new file mode 100644
>>>> index 00000000000..f659a8282b5
>>>> --- /dev/null
>>>> +++ b/drivers/sysinfo/iot2050.h
>>>> @@ -0,0 +1,26 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Copyright (c) Siemens AG, 2024
>>>> + */
>>>> +
>>>> +#include <sysinfo.h>
>>>> +
>>>> +enum sysinfo_id_iot2050 {
>>>> +       BOARD_MLFB              = SYSINFO_ID_SMBIOS_SYSTEM_VERSION,
>>>> +       BOARD_SERIAL            = SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
>>>> +       BOARD_UUID              = SYSINFO_ID_SMBIOS_SYSTEM_UUID,
>>>> +       BOARD_A5E               = SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
>>>> +       BOARD_NAME              = SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
>>>
>>> Do you need to rename these? It seems better to use the standard
>>> names, although I do think they are quite long.
>>
>> We don't rename, we map pre-existing field names in EEPROM and
>> pre-existing board-specific U-Boot env vars to sysinfo fields here.
> 
> Yes, that's what I mean. Can you just use the SYSINFO_ID... values
> directory, rather than creating mapping?
> 

The mapping is unavoidable ("pre-existing"), and here is the most
logical point for me as it avoids that we have to do it twice: first in
the sysinfo driver (EEPROM->SYSINFO_ID) and then again in
set_board_info_env (SYSINFO_ID->env-vars).

>>
>>>
>>>> +       BOARD_SEBOOT_VER        = SYSINFO_ID_USER + 0,
>>>> +       BOARD_MAC_ADDR_CNT      = SYSINFO_ID_USER + 1,
>>>> +       BOARD_MAC_ADDR_1        = SYSINFO_ID_USER + 2,
>>>> +       BOARD_MAC_ADDR_START    = BOARD_MAC_ADDR_1,
>>>> +       BOARD_MAC_ADDR_2        = SYSINFO_ID_USER + 3,
>>>> +       BOARD_MAC_ADDR_3        = SYSINFO_ID_USER + 4,
>>>> +       BOARD_MAC_ADDR_4        = SYSINFO_ID_USER + 5,
>>>> +       BOARD_MAC_ADDR_5        = SYSINFO_ID_USER + 6,
>>>> +       BOARD_MAC_ADDR_6        = SYSINFO_ID_USER + 7,
>>>> +       BOARD_MAC_ADDR_7        = SYSINFO_ID_USER + 8,
>>>> +       BOARD_MAC_ADDR_8        = SYSINFO_ID_USER + 9,
>>>> +       BOARD_DDR_SIZE          = SYSINFO_ID_USER + 10,
>>>
>>> These are the ones which should be added as standard. Be sure to
>>> comment them as necessary.
>>
>> You mean that BOARD_MAC_ADDR and BOARD_DDR_SIZE should become
>> SYSINFO_ID_BOARD_MAC_ADDR and SYSINFO_ID_BOARD_DDR_SIZE? But
>> BOARD_SEBOOT_VER is nothing that has any meaning beyond our board.
> 
> For BOARD_SEBOOT_VER, I don't know what it is, but just add a comment
> and put it in sysinfo.h. It is OK to add board-specific stufff there.
> 

This still makes no sense to me. What is the point of SYSINFO_ID_USER
then? Why does it exists and is being used elsewhere when it shouldn't?

> Is BOARD_DDR_SIZE the memory size? Perhaps rename it to RAM_SIZE ?
> 

Yes, and I'm also considering to append "_MB" in order to clarify the unit.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
