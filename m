Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2698ED2F339
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 15:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F3C7803F5;
	Tue, 13 Jan 2026 16:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZG4XH/8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF29F80433; Tue, 13 Jan 2026 16:51:20 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B39E080325
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 16:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gmh6UU8Qjx659M2yJjb81Tbjip4G0n2XuGHyjG4AU74zC6ILAaws1pU99ooPzbxPvUcIt+I8zmgCpXxC4FyQwCLTPJVCv+hLZMd5+tVqGXO66dxKQeLbBktdsDvCwpx3w05RHOQI5930G/vx7qU32QlTI4ANUzELh0u4T0IfSKvpiTFsArRTWRRxKu0ohTeyN8WRJ4VvYIfKdWOuZqdxZpSxIEByBvC+zPlun33FLRadXIg71UsaitR2w0GLnaBX5IFk8QAOzhiLvSAKeB1qw1tFBjh9OgJq6TQ6+aVMMdUVxQsV1X0kkCJ9LdkoEwSiTeNBcXGAgW/TTIF0jzyIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R65fla/tOfV67udgRSPFqUbAKZUGbNncAIn1jVXIJ3Y=;
 b=IDjJ1cMCQDORX85gxn1EhnlrSds9StG3z47zOFlt6Z411XmbrQG/hdUfnQjk9BdvUL3iR1xRVkQi7HjFvUAu18pAAImzZP/5csu554esnfCkG0YtVPcLfg6aPmDejUaP8MWUp0IkJYzCwh8GkRuaWDr4nKqqUEXSJ5ls4TG3p0pNRnejKLCp7RSHmdKdvRsYNu/xunAoDxZc3aR16kBw2bPf/itKvv9mUa6q8bhTmq8FDCJV4aQObSpryf1AaxbbKcxqHwW+5zWCQZcriF4sQIs3mvVrgQtPgzKrAeuUhMHux/ahedryVxtHFGj1lM4Iu18jpc4987dtPd3YbIe7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R65fla/tOfV67udgRSPFqUbAKZUGbNncAIn1jVXIJ3Y=;
 b=ZG4XH/8c1qoflyDjCa0Af6N/jffI/a3RyOaRQvhfeNei3Mm5nEjMxE20y6ayqXS11XwFHiGxSqVsqOCwgYFIUCcZOfkxF7jr/sop/khVVjfWof3c4shzbXt3uUZW7iPX5YC2ev1AVWo85s7sftH2v5OgRfg6Lwd/ZFdNidJx3FA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DUZPR04MB9746.eurprd04.prod.outlook.com (2603:10a6:10:4b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 15:51:16 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 15:51:16 +0000
Message-ID: <e8f194b8-f02e-4c46-8cb3-d02efe66e2e7@cherry.de>
Date: Tue, 13 Jan 2026 16:51:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Fix typo "addtional" -> "additional" in pflash
 section.
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Manjae Cho <manjae.cho@samsung.com>, u-boot@lists.denx.de
References: <20251229123344.7365-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251229123344.7365-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::9) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DUZPR04MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: 42dd5bc4-ebe0-46b1-ae96-08de52bb95d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dSszTFNSaktybkpyRHNvUHdyVkdKZ1ZwVUdOdFNwelZoYXhRNEQ0MXJWSS95?=
 =?utf-8?B?Ykd4K0N3SmZVWnc1dFp0cUVXWjREWnoxWnIrSFQ4c1BqRHB0RDBaN3RqUGZQ?=
 =?utf-8?B?WWl1dkJiZ0ZJRWpTSGRET2xCTHZnRWRnd1F5bSt1THY0cGZ3UlFYdnc2KytF?=
 =?utf-8?B?cGs2bjBPTHNwZXRBblZ2b2hjYXBjSXJPUVhTQ0t4Q1c5RHRCT01ocTdaYXRm?=
 =?utf-8?B?MGl3U1JDdWNwNEVoZjRqQ2NCSStUb2pzeTVsbU8zajRyZXQ5SmZkTDV6VmFw?=
 =?utf-8?B?RkVrcG5vQTEwY1lDUkROZXlxRkJXWUFGRUFuT1Q1UGdMVWZuOThqVFY1RHJj?=
 =?utf-8?B?ZDYzTzkwc2lpdVRkY0F1SXZSV2ZmZnlXdXJyY0RyN0tPTHVOUXo2WlVNQnBw?=
 =?utf-8?B?aUc2NkY5by9OWGV3ZlVTalhQZDVMWFB3S3ZwRnUxUU5BR1grWGtWZXc2b2JV?=
 =?utf-8?B?TlRjb3JnL3dKalprWXowSGZlbnJaN3EwbXY2MEgrK3BSaDJuNW14OThIQmtP?=
 =?utf-8?B?M3FoUm41ZThHR04vcWV3TmRKelRvY3JvZzg0WGdsb1NnNUg0TzhFTzhnWHlZ?=
 =?utf-8?B?Q3FjVkQxMUhLcjhtcitQL2pEY3kwemVIa2x2b1M5U2NpUE1SV0F5aXhUVWZv?=
 =?utf-8?B?a1IxL3FSUWFGZ2dUZDh6eFhOUjNod1NwSWhLYmExRUdtdzg3MU5oUmJ6YWt6?=
 =?utf-8?B?YlBSV2c0V1paQ0s2WU8xTWVnMUFOdnFnMGtKR2ZVN1BJelZjeXdsWE5LV20x?=
 =?utf-8?B?eTRiRzBOREpnSGg0T0VLc0Q5YlBNbjNVODJZTERESzhFS0RIWmwyWlg3U3U4?=
 =?utf-8?B?ayt2YW03SXE3SnhNaDVXTmwvOXBJV29MMEhxeEZJbklPSzRMR241aG5mTm11?=
 =?utf-8?B?UkZyd3RmZWcyQm4wRTdMcHRaQUVqSm5XbThJYlFUQXFoa3VoMkRJQ0NwVm9Q?=
 =?utf-8?B?a2M3ZS9QYjFQdjJMOUd5My9RUHBIbHE3UlYwMXAyUUU2bVJ3RnhpK01MYnBm?=
 =?utf-8?B?VGZNbnRPZ1A4a1REQ0tlRXdCMjVjaTZjaThTdnFoSmNHQ1ZCRnNmdzBhZkpy?=
 =?utf-8?B?SXkyNUtIZC9qazNJeXc5Sk41RzgrcmUrWnhsc3NtM0Z0RjRwbHY0MGVFODdn?=
 =?utf-8?B?U0pqamp3NWUyU0g3QjhJaXJDd2U0eGRWK2NuKzVKeEpOTnF3WXMyemhNa0ha?=
 =?utf-8?B?K01DUWlGcFNTVXlyN3hXVUQyNGtnTGNZZ1B5Qy9Xd1ppbk92U1d0SjdzOVIz?=
 =?utf-8?B?cldlMlhrbkxObWVRaHptYzNZOWxBeEszOVZ6dnBZdUM3dTNKbGdrSm5pVkhU?=
 =?utf-8?B?Vng3eWp0amdZSVpJYzJMRE9oenVMd1dmL1dwZlh4TnA0UWhvZ1JJblI5ZkdU?=
 =?utf-8?B?WktNME9OeUNDZVZQeHhHZTdtUFJYY2VWQWVYUW1qeVZvRitWUEhRZW1QOHFn?=
 =?utf-8?B?RHJobGhrTHIrdHU2Rm9RVUdjWmtCdDdWNTN4b3VybG1Idk53ZUozaUNXbWZj?=
 =?utf-8?B?TkZ5ZmtReWpVeEhFdjdRYVE5TlJlcnMrVVFLUURFOG45RC9hT0MrRU1vY04y?=
 =?utf-8?B?UUg4aDJsZlZBUi9tVklGcGVKRm5ZVytzRjFjVXpZL0VsWEIzZDd1V0t2a1VB?=
 =?utf-8?B?b0ZxM1NpbWo2UXdPNnh5UHUvLzBjL1hyYi81dzRhNDd5VjNDalNxVFpSV3pH?=
 =?utf-8?B?Vk5qeDBwUjYxeHRhdDJsczBHZ1czSDg3akwxTDdudTZ4SHVmTEo2cEo5Zks3?=
 =?utf-8?B?TzgzallJcVVIcWtUSU5BZ0xQQ3d3cTArZ05sM2dTRmhCc043emhKMkJJZnZM?=
 =?utf-8?B?ZFlsaTJQcGFvWjJZTEFUNTZtNThpVkZ6RmlGM2FqTkFoUU5oUTRzTTBzREVI?=
 =?utf-8?B?N2JLSVRPM3RFaDNqMFlINGFobWRZOUlxYzRZa1dzQmVSUW1BSEZid0xwMFR6?=
 =?utf-8?Q?1BEoj28q8b2uRI6FRDkf5/Ee2P8I70BQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGNzekRvL2NnWUhOakNkQmIzOVRwQmVxWkZ1aVkwYTVtOXEyTVNRTGhUeUZ5?=
 =?utf-8?B?eERwNFZub0RQekJ5U3lxU3E3UERuN2VMMStENUlnRUhtRks2SGNTKysxSnJV?=
 =?utf-8?B?RTcyalhobktGdTA2UnNQdUFPQWpNdlNNNlY2RmtCTCs5VDE5VFN6SkNXdUFv?=
 =?utf-8?B?dnd0Zks4Tmp5bkRIcFduWU5zLzVRS3VLaXFrejhERWUxTlBvZGFOSGFWTkxS?=
 =?utf-8?B?R29JOHA2dFdsdWFOcDhlUDhWWUZhaklhaFlnRTZFQi9LMnhPYkNobkxUWmFy?=
 =?utf-8?B?ektEdW9zemZDTlhnanBiNXJYWVg1REw5ODJ0WlFGTEZMTFNySXlsc0ZHZ3BT?=
 =?utf-8?B?MlU5K2lYUm1SNXYyNlhsVEZNTkJFRU5XclFtVEphejJZaVBFMzd0dHFDRHp4?=
 =?utf-8?B?V2VFM3FUVUJVWGd2bzhKYVVOMHJvcFFUdk9xdTNVOHE4ZFVRUS9uQzJjZEhh?=
 =?utf-8?B?eGVrSm5jRnh4bzJkS0VjTkxTbURYMjIzd2dHcS9kS3FRQmZ4eWM0YWxsQlRs?=
 =?utf-8?B?VVYrdWJjbnd5SzhJSkRycGEzdE9NWE9raUN1STZNWFVFU2FqREUzQTF1Zm1u?=
 =?utf-8?B?RGpqbGVxNGNhQWQ3R2xsZG90UVMxS1kxdno4bnVSTlRycXZEWTFHU3VGL2Zz?=
 =?utf-8?B?cEZyUzhMRTRzWmtlTnV0MjF5NnZieVZMeFZQVll4d3RTOVBmOHdXbTZUZ21B?=
 =?utf-8?B?anVDWEg0TmdkSy9hUDhDd2dLUCt0dFBHM0RvRVJFbGdOaUo3L1VGb3FMdGZt?=
 =?utf-8?B?U0djbHRtam9GMG95SUk4eXQyVEs3UVZDNjE1OFBsRmo0eHErSnJBbmlKM3ZP?=
 =?utf-8?B?dkVFKzBrWDdOSGJKL25GL0FxTmNuVmh2Sy9xdGdjbW1VYjhJbEdrdkJkWVlS?=
 =?utf-8?B?UTE0ZmkwZlpqZGcrM1pIdTFIYk52bnNyMGFsa1Vwa285ZUM1NUI4K0x6c2l3?=
 =?utf-8?B?UVdPZ2dIdy8zUXNtdWNUYzdvcEFEQVQ4VzV5Rnd1VzEvQzRXdHhaY1c0cWhW?=
 =?utf-8?B?NDF1M1ZMcTlEZ25FdmFiR1RZbkREeXBsMFpZRm1BdzFjV0hvZkdnNjhZeXBP?=
 =?utf-8?B?Rm1ZNTd0NmJweTFWU0s3ajFIQmF5N0VHQTJ2cXFVODQ1Z3ZNL3Z5SUtPZjBj?=
 =?utf-8?B?bFZpdUNQbkl5QXJnaHBJWXRMWWp6UUY2QnA3dTB1RFVVVi9heDcxNnVMWmRL?=
 =?utf-8?B?NWVZZUJxTnc4L3dyZlpSenVzcDFrMWYwVkhqUk9aQXYvbS9pbUtZeW1wOXpF?=
 =?utf-8?B?ZVF0SVR0ZkFEQUhwTEFtblJlaW1WR2hMVVY1eEZJQW0vNGxINlR6a29IK2Fw?=
 =?utf-8?B?THFXL0NXdE1ZaGExcGF3MVdoTDYrYmV2U1QxU0g0Rzc4cTJtMElyZ2c4VENK?=
 =?utf-8?B?eEdCeHpTVi9SNlJPaHh0aVYvQUtwRCtDbzBwVVhRbjZaZzVyT1JueXcvWGpW?=
 =?utf-8?B?M3FOd1laVTJpa0s3d2JzR0wyZ1NsZEZMODAxNXRtTWU0cDFMQVV4QkdtK29S?=
 =?utf-8?B?OTFiVlNiVnBIRVdqY0I5RmxZVGN1TGVMZzFiaFlKeHV0WXIxUUlpYjF0dVRP?=
 =?utf-8?B?TktuQnVMYk1MejJZbisrNDlURnpjcUc0cis2Q1llRGdGbEJDcjlFRmNlcGN4?=
 =?utf-8?B?YldHYUZRWUlkRTh3TURKSUhlSlJiUmJQbWJkUnBuVFBhN0RCK3EwWWYzQUgz?=
 =?utf-8?B?cnBQNEszNk11WGlwWFZ6ZytMZWZpZGNheHVwMFhSZ3ZYMjBhbXRueHMxbTZ4?=
 =?utf-8?B?MHB2OVNzdnYwdHZGQXRPSEsvQzBsZ1VGTE4vdzZ2ZWdxVVhFOWhWMUgzeXNl?=
 =?utf-8?B?R0xOUHdIdGd3RkJUcEgwNnh5QUNvTFdBZitRME5HN2hQVmxEbG9sUXFqM2pP?=
 =?utf-8?B?V3E1U1cyOTZFeHp4eTlTakJ2Wnk4L1A1aG5jdGJKMDFUVk9oaXlqSUFuSEJI?=
 =?utf-8?B?dmtsNmt6OEN2ZVZLVmFiUm1uT3owR2FBbU5OUU9KQWlxMmZSelN6cmEwOXp5?=
 =?utf-8?B?K09TbWRJVjBZQ0dVdHFxQUsvVnpqM28rNjlDRTRGNDdtaWMwT3Jyd0laVXk5?=
 =?utf-8?B?MlVFZUVMZkJYMjVXTitxcUx5bkVIN0JiWGlNWDgxUks2OFJUU2VTZFV4MWsx?=
 =?utf-8?B?NzRDZ1BOenRQWDNETlhaQmdOOUtDdVNxS1NpbVBVVGZsT0xYL1hOaDdxRlc3?=
 =?utf-8?B?Uk81dEcxSlptQmMrZE1zenpUb1k5Zm40TkFRUUpjYzl3aEpPdndzQk5reVRW?=
 =?utf-8?B?L2VWN0RIbG9XaUx1QlBaeXJkdnVaMVJ2MDZ0TkJHeW1zNlJpSGpNMEVrM3Fv?=
 =?utf-8?B?OGhaM01mR1RlSHhTUUhGblo4KzgxZGJCMVRiSEFKUktqWDRDMzV2QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dd5bc4-ebe0-46b1-ae96-08de52bb95d6
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 15:51:16.0810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kIePhX7ZirVPV1mVYzCeA5dbHDOz2ysLF7fYqLJEllvFAblp9dVLhru319bXEUuKXcB9J/4W9y1uYFQbaTtwpgpn5LFxLfl9HLCfZgMpXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9746
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

Hi Heinrich, Manjae Cho,

On 12/29/25 1:33 PM, Heinrich Schuchardt wrote:
> From: Manjae Cho <manjae.cho@samsung.com>
> 
> %s/addtional/additional/
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
