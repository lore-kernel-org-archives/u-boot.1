Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E16DCCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 04:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F42F83849;
	Mon, 20 Oct 2025 06:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=legrand.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=Legrand.com header.i=@Legrand.com header.b="Rj6MTCAO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 932E8831D5; Mon, 20 Oct 2025 00:36:33 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DF84807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 00:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=legrand.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ronald.wahl@legrand.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2l9pSlb/0kfeu18ucgGjtwF/0r00BomHz5cD8zYblQOPihHlk5EZp5ZWk0JQHnqqlABB8ZHHccy/HUPEt+F1PYYgToKRPkxv4fzqEx3TdrgbKpCjO9DG+bVgb7X+Jap6ILY0vEGjriEqTDDO7ZeP9mMQXU4ZpSnwuWfEgd13K3aSTkh1CX30l5zWlR+28nLCv8mrvgXfd/3dspMLPYDCSFyAuO+Ou51FPrkwB+UgFZW6xLeN+6slZhRtUnj9LKIPRN/lMZI1dwXQMK9g8roUw5TnYQonENl6q+xA7XK4azJw7FYwwtaD0Z/bE9dSkgoOTznaAVjkgQviWWkoPgQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SBKZJCol6893sHQZvAdlFEPw/3Mxnlqx/L9NnpEhBA=;
 b=mEGwsmEKo9ipb8EXDm6t1ciBhXUidJrmMMuEUuRyz3BLvj1vF+uswbIhJCU+PZZAHoNa7kDEm+DGD5DvMYgRAYsm/5jEmYMpRrtCs63O8YJcOJiYsn5R3P/xpcd85Apng2X0uKSM1YuovQT4UHFGMw3pQN2cOeLwwFGzvLVwQx8d/kPkXihAGYOkAr/NVJnNaObqE16dxjyi9LG1qCEcklt3l9ZK4jfqNjuG0pwRZ3umCPLEbBhWxi1GBJt1lA7Tstvh8m3oqw8hNol/Qc08a5XMc0DLR3hY2dokVvvMUU/p0cxtY17l6GwHDy/oYXnNQRUrpZ62pf+AqMmObNpvnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=legrand.com; dmarc=pass action=none header.from=legrand.com;
 dkim=pass header.d=legrand.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Legrand.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SBKZJCol6893sHQZvAdlFEPw/3Mxnlqx/L9NnpEhBA=;
 b=Rj6MTCAOpdhik60n49I1p18v2BVzVyUKvChlvC0TyCGN4B09ZOlrzK4Xc2auOXrl/70GchEXi07MADKIYaXX3XJBo+knFRMsRpZ8Bg80oqD279wX8Jw+aAR7BwOLzN61HDWb35rtAewozx9f9uuzqCnu1TFGOxQ58E52YwABUdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=legrand.com;
Received: from DUZPR06MB9057.eurprd06.prod.outlook.com (2603:10a6:10:4b2::18)
 by DB9PR06MB7257.eurprd06.prod.outlook.com (2603:10a6:10:21e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Sun, 19 Oct
 2025 22:36:29 +0000
Received: from DUZPR06MB9057.eurprd06.prod.outlook.com
 ([fe80::7883:195d:c189:373b]) by DUZPR06MB9057.eurprd06.prod.outlook.com
 ([fe80::7883:195d:c189:373b%6]) with mapi id 15.20.9228.014; Sun, 19 Oct 2025
 22:36:28 +0000
Message-ID: <b21e8dc3-7ec7-4fcd-a0ef-1d214fc8a1e9@legrand.com>
Date: Mon, 20 Oct 2025 00:36:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: cadence-qspi: Remove cdns,is-dma property handling
To: E Shattow <e@freeshell.de>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de, git@amd.com
Cc: Boon Khai Ng <boon.khai.ng@altera.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <6205c6585589b423692b6ed063506b4c51c04c77.1760006086.git.michal.simek@amd.com>
 <3949b231-b62f-4fac-a078-bd066940420f@freeshell.de>
Content-Language: en-US
From: Ronald Wahl <ronald.wahl@legrand.com>
In-Reply-To: <3949b231-b62f-4fac-a078-bd066940420f@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0407.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::16) To DUZPR06MB9057.eurprd06.prod.outlook.com
 (2603:10a6:10:4b2::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DUZPR06MB9057:EE_|DB9PR06MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 310e460b-5491-4134-67af-08de0f5ff1c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFlKSTZuckpZYmpLc0NxOHZwdzBKaXZ0Y08wbEpVZkd5YXFzanVieVZiaTc5?=
 =?utf-8?B?Z0tTV3I3T0FNeUVQcGNtUytCeGxMSkVqZU5YNCtIb3U4a2MvR1hwZXNtWFJp?=
 =?utf-8?B?cXliVUswV1U3NTRiV05xbDRaYklPa1VkRHNLekNWSSsrR1JlUlE1RWVwc3BV?=
 =?utf-8?B?ajRpaDVZeXoyQ3dHL1d2ZHFLTlZVMVJGdzd3VXh2OEhXK0lTUHp0bVQ4eDhQ?=
 =?utf-8?B?Q0pVb2ZyWmd2QmVvUENaRGdaSVQ5NUkrWkErVEpXVXNsRWRBdytYcHoxcy83?=
 =?utf-8?B?THhmRnZYRS91QTRaeWlVQktMdmxHYVlVdjkyZzNCeWdTaVZwTkdpRlJDK1Yv?=
 =?utf-8?B?NUN5N29aNkIzZVBiVXM1VVFBakl6Slg1OXNoMmErRy8zT29NWEZrSHNES2hp?=
 =?utf-8?B?Y2htVXNQck92NURHaDZCTThIUDk5bk5aVkNwRTlFR05mWHVJamdFQ3Evb2xD?=
 =?utf-8?B?UUxoZGpKbTJhUEp1dlZaaklJVzlOQzFRRWhGRlVvYUVkUyt3VGZ1elRIR294?=
 =?utf-8?B?S3pHYTlWTDMrTE9TQXExVDAydVpzQldJRWNYa21jelRRZE1wQXg3N0t6dS9N?=
 =?utf-8?B?dUNpY1pkaUhDT0lSa2ErMGZrRCt1LzFtcWJSWFluRUQ1V0hTSFF1R3hsTXcx?=
 =?utf-8?B?UVNZbi9BUEFhTFlMakhUSUdVYXRjaXZ3OGllM1hXUGJtSVhIbTc1QzlOeCtK?=
 =?utf-8?B?cjViK3ZKVEhLRklscHI1NVNyQkl1OEhtcXV2bzNBeEZwMjhHSTBRU0dpRHpL?=
 =?utf-8?B?NHk4cXZoaVFhVEhPa20yQXlYcFVsams5eTBvL1B5TmlHcWl5b2FkajBkZ2NL?=
 =?utf-8?B?QTB2UUN3djZlcXRreWlTZ3lqLzJKaldmbGpSclBJRnJyRFAzRHJRNmNMOFpv?=
 =?utf-8?B?UWxXTHEwOHRrTkdEc1FhTFBpcU9FcGUwZTliOE1wNndxTVhmbmFXWkQ3ZUlK?=
 =?utf-8?B?ZWp3RVRpY0FtOTNsRzg4TSszSmxkSVVjVkdLc3Nyem1JUlgvMSs3VnlOYmR6?=
 =?utf-8?B?WlR0N3Jac3d6aHJTbkR4cHlBYmhGVGZPUHdpOGVaQmVnV3N1ZjdEOEZrMDIy?=
 =?utf-8?B?Mks3MkNGZHY4UVJLckdyQ2djZlc1S1g1aE94YjlJbXpYTVhiSG9XSFkxK2c3?=
 =?utf-8?B?SnFQS0ppWHpnTHdMUGpTc3d2eG1XTWJqaFNOY3hvVGhMU3Y3N0dsYVpIbVR2?=
 =?utf-8?B?cndmcUFmQUg4SmJJbXo3Q0poQlNlL0owaE9sYzhySzhPRFgrdG4walQvSkNt?=
 =?utf-8?B?dEJLVXcxb0l2YWhPMUVOQnQzL2g1STM1K05jZFJONk1NZVMyN2t2aE51R3Jx?=
 =?utf-8?B?ZFJrUG1zNnk2Z1NITGhQdmYwb0tnS3g5RE1TWU5BRTBrbjl6WFpzZVorT3pv?=
 =?utf-8?B?RW9UdGxjalRNaUgzL2I4aC9zaDM0cUt3bmdZMTd2eFZVYjYva1hoUHZiVDRP?=
 =?utf-8?B?Vk9yVkNmMDlCcmtmMHhGZnQ1Y0NBWEdPOGxhZmxpSXltWGFUcGpFZ0dKejBS?=
 =?utf-8?B?UEQvQzJ3RVFabVpzdXY3SXFiVzBmUzk5VURMZ0JNWmRJNnZUdEJpTXI3ZWdk?=
 =?utf-8?B?a0tmSjV3NkJIYUdRS0dkRVdTS1lwWlAzaGZGdUREa1YyMHc1OXFRSEtuZTdz?=
 =?utf-8?B?ZDhTTjVReURWeDdqOXpqdS9NZFVCZy82ZkVYSmdhYmNmNXlta2JRbzdmaHV1?=
 =?utf-8?B?YnRJWEduSkJ0cVVDVjQ4WGR5aTZZYmZ3dXNSTm1aOTczTnVuanpCNG1lL1Nj?=
 =?utf-8?B?ellkT3pidzdSS2lPQ01TdEFlbEFoZTRENjRjU3BGQmRud2RoRjM3Zks3Tzgw?=
 =?utf-8?B?NWNubG9WL2pUQ0lKc1BFV3B6TEowMnBDL1g4TytvWk94NmNOMjFZclZ1TjZo?=
 =?utf-8?B?ZVZBdGJlbzBrOU4rbFZyTHFGa3ZNb1hTaFlabzREczJtLzI4bWIvR2JxQWFJ?=
 =?utf-8?Q?NFGHepTyjga5sU2inrLHPqOrVdOC5SRh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DUZPR06MB9057.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enJnOFZSTUovNlRKQnp5UW1zNk5jcFF3WEpGakxJR28ybi9wODBmbjc5cVRB?=
 =?utf-8?B?Qlg0azBPNDNBWm9nVk45R2ZxMHU2VkhlNCtpYnhESXVpMHdhb1MrM1NVVmFk?=
 =?utf-8?B?R21oT2ZkS2tZazBqUXRmWVkrLzJtUUowQ05JL24yOGRkRnJtN0RxK0hZbWpE?=
 =?utf-8?B?RjRvc3R4YWJVOVhwRkwyd01FQ3RzQU9TSVhKY1IxUStBQlFQcUEvL0llVjg0?=
 =?utf-8?B?QW1qYSttb2oxemtFa1U0UzNLQUk3T1U4TFFiMDJ0RlYrRjdmcnZmL0JlQWJ5?=
 =?utf-8?B?OFFQRS85WWRzWU0zdll0VmQxUkhObHF1R0QyeVJaRmF6cDE4VFl3aTV3aU95?=
 =?utf-8?B?cG9WN3U5L0RHOXJMck5WcXhoRS9DWktuOVNQbXVka3BRMVFBdkhreElmV1Jm?=
 =?utf-8?B?YUc0MDZEc1c3NEEybG5ZVzZlb1pST0VrVEVnL0JjMklhWXNPTTBEbE8xSTRP?=
 =?utf-8?B?ekJJelNMNlhnSDRBSWlLZWg1YXQxZDJYU0h0S0c0V0sxLzR3TjBsVUFzVVFn?=
 =?utf-8?B?UkxhaG11K215a3J3TkF1QnFEQ2FJZDBkRC9yZzdmeXVDaWZYY0VoUlNScEoz?=
 =?utf-8?B?VFY1YWNxS1orTHdDcWRrWEZJU0dnWXllQk4wMXVtdHpYeEc1VURKb0g1ckNi?=
 =?utf-8?B?cWRRdTRqWlZ0N0RTa2gwY2MvUUJHbHdZRFlhWDRvVGNQRUxGWmdCUU5vdnNr?=
 =?utf-8?B?MDFVNTR6ajAzd3Q1aE1mSVY4Ny9pdXpEaDEvUmlDdk9VdGhLbHZpUEVCNm9o?=
 =?utf-8?B?WUtCck0vL1Q5WWxqcHVLTVdKMmJCRjN1a3QyL0cwUnlRNFViMXVQUXFZMlNU?=
 =?utf-8?B?OVpJU1hzdUsrYVpkR3N2TWlQK0VCeC9ZY0dqTkppcG9PZnJUbW50VHF6OUtE?=
 =?utf-8?B?bDJXaVVRK3E2UDJ0T1RaOGJSc1UrUGhwUHRIRlB0WG9nMW9kT0hFanN0OWpR?=
 =?utf-8?B?TU5pS05mR1FsM24wWTh3RkxEWDNobkVZM3NFa2ZhV2RCVWlrM0pDRjZoakMr?=
 =?utf-8?B?VU40T0F6VTZQdEo3Q0VPMkZsZS9IQm9NK0E0ZCtWbnh0aHFDS2J1eU13amF3?=
 =?utf-8?B?UE9Dbm1TQm1uMDZEZkpHVTBMQnlMWmJFVE1FSnc3Y1YyalFFeng3c1JGNWNS?=
 =?utf-8?B?MWhaTlpjN3ZNSWNMb2FNSXZRNUcrTFRrWVNRbWd6Z01RQ1V3ckFPM0RPV3Nh?=
 =?utf-8?B?YTFkS0pyYjJtRWx2SllYeURydklzTnMxeTMrZTlscUJscFNVc1l1ZHZyYVY0?=
 =?utf-8?B?YlBlL3N5ZEFoUU5PMEZJdHAxdzRIYlJ2cEpCb1M3RUNveHBDeUxQT0xFQ1p6?=
 =?utf-8?B?V2lwTHM4SkxHQ2NzNUpWZmhMREdLOXZ0UllLUDZrL2Nqc3NqVDJORC9oUmdo?=
 =?utf-8?B?SE0yeWlEeVMyb2phdFlpVEhQbTIrS3ltVmpkbFdIZWVhaDJYY1Jtb2JpU2s2?=
 =?utf-8?B?Rm5ZT3F6KzJUaVdwa1NOVTZFc0pHSDRGMEpzQzF6TVZIWnZ2cW1RMUMwcUwv?=
 =?utf-8?B?bmVHR2kxQ2Fpb1l1c2NiWkhCSFVVTTYwSlFjTGk2OHZFZXZyd3lUQkViY1Q4?=
 =?utf-8?B?OWx0U1pzbzltdWtMR2h0c0UySEdwUWpZSGk0c1hwM21aR3dPTFpmeEd1VUFr?=
 =?utf-8?B?cmFPNU0vcGw3U1I0bzM0NjNKdDVVc2VDb1Qrc0dDcGJwYzhjQmdQZDgzNldL?=
 =?utf-8?B?SXp6alBkaEk3MlFDS0wxVy9pWkFNVDc0SmM0Q2VmMm1MYmdhTzJ1ZFBqOTBT?=
 =?utf-8?B?N3VEWDR6Vk5MQnB0ZDVmRkFxZlNlUWtlbjJzd2MzSEtrckJWTFp1YjE0Yzhk?=
 =?utf-8?B?djNBYndHTXZxMTlTMHlQajlwNlMxSlpkMDZ0ZnYxWURTa3pGWUVwTXJwNjA5?=
 =?utf-8?B?U0IxeDZSSVFsSS81aVV3N0s4MVpYR3lsR2Fmb2svNnFlOFlTOFdFQ2haall2?=
 =?utf-8?B?dW9Nanlrc0RJQ1ZCYUd4anQvU1B0RkVSQXdhS1VBemN5TndQbjc1eDM2SHJX?=
 =?utf-8?B?ZFNIVEpMRVg3TUl6L0p3MXVJdll6SUFEc2t1NGpjT2hRYnB6dkVRL1JPaGNp?=
 =?utf-8?B?V2xvSkl6NmwyVThxK1cybStzeWlpdHlKK3NxVUk0V3V5bjhIcHkyY01UclRW?=
 =?utf-8?B?a2xLRVcxejVXMm8zeTNhQVkweHFBcVNCNDhGNjRRRUVTSFNaN0N0aEY3VFZs?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: Legrand.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310e460b-5491-4134-67af-08de0f5ff1c7
X-MS-Exchange-CrossTenant-AuthSource: DUZPR06MB9057.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2025 22:36:28.7389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wt+Nl99PG97kWie2iHlDbtHBdsZZ1Me2R0XLYXDj1nvJ9/PV0vkjNjmfl7t0tfm3lxXIy7YdJR8VgoROq2X/Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7257
X-Mailman-Approved-At: Mon, 20 Oct 2025 06:31:54 +0200
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

On 20.10.25 00:03, E Shattow wrote:
> On 10/9/25 03:34, Michal Simek wrote:
>> Remove cdns,is-dma DT property handling. Property is not the part of DT
>> binding and it is also hardcoded to value 1 in all DTs that's why remove=
 it
>> because none is also testing value 0.
>> If there is any use case when this configuration should be supported thi=
s
>> patch can be reverted.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> Changes in v2:
>> - Remove other functions which are reported as unused by gitlab CI.
>>
>> v1: https://lore.kernel.org/r/c6a5b4bfe565668eb3299d5c5a5548a2163b129a.1=
758786568.git.michal.simek@amd.com>>> ---
>>   arch/arm/dts/versal-mini-ospi.dtsi     |   1 -
>>   arch/arm/dts/versal-net-mini-ospi.dtsi |   1 -
>>   drivers/spi/cadence_qspi.c             |   8 +-
>>   drivers/spi/cadence_qspi.h             |   5 --
>>   drivers/spi/cadence_qspi_apb.c         | 119 -------------------------
>>   5 files changed, 1 insertion(+), 133 deletions(-)
>>
>> diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/versal-mi=
ni-ospi.dtsi
>> index eec2a08e7c70..6991f6a51db0 100644
>> --- a/arch/arm/dts/versal-mini-ospi.dtsi
>> +++ b/arch/arm/dts/versal-mini-ospi.dtsi
>> @@ -38,7 +38,6 @@
>>                num-cs =3D <1>;
>>                cdns,fifo-depth =3D <256>;
>>                cdns,fifo-width =3D <4>;
>> -             cdns,is-dma =3D <1>;
>>                cdns,trigger-address =3D <0xc0000000>;
>>                #address-cells =3D <1>;
>>                #size-cells =3D <0>;
>> diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/versa=
l-net-mini-ospi.dtsi
>> index 1c94b352dc97..d2d5ec8e5cbf 100644
>> --- a/arch/arm/dts/versal-net-mini-ospi.dtsi
>> +++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
>> @@ -52,7 +52,6 @@
>>                num-cs =3D <1>;
>>                cdns,fifo-depth =3D <256>;
>>                cdns,fifo-width =3D <4>;
>> -             cdns,is-dma =3D <1>;
>>                cdns,is-stig-pgm =3D <1>;
>>                cdns,trigger-address =3D <0xc0000000>;
>>                #address-cells =3D <1>;
>> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
>> index 599596f9f087..849bd930edf0 100644
>> --- a/drivers/spi/cadence_qspi.c
>> +++ b/drivers/spi/cadence_qspi.c
>> @@ -210,7 +210,6 @@ static int cadence_spi_probe(struct udevice *bus)
>>
>>        priv->regbase           =3D plat->regbase;
>>        priv->ahbbase           =3D plat->ahbbase;
>> -     priv->is_dma            =3D plat->is_dma;
>>        priv->is_decoded_cs     =3D plat->is_decoded_cs;
>>        priv->fifo_depth        =3D plat->fifo_depth;
>>        priv->fifo_width        =3D plat->fifo_width;
>> @@ -348,10 +347,7 @@ static int cadence_spi_mem_exec_op(struct spi_slave=
 *spi,
>>        case CQSPI_READ:
>>                err =3D cadence_qspi_apb_read_setup(priv, op);
>>                if (!err) {
>> -                     if (priv->is_dma)
>> -                             err =3D cadence_qspi_apb_dma_read(priv, op=
);
>> -                     else
>> -                             err =3D cadence_qspi_apb_read_execute(priv=
, op);
>> +                     err =3D cadence_qspi_apb_dma_read(priv, op);
>>                }
>>                break;
>>        case CQSPI_WRITE:
>> @@ -412,8 +408,6 @@ static int cadence_spi_of_to_plat(struct udevice *bu=
s)
>>        if (plat->ahbsize >=3D SZ_8M)
>>                priv->use_dac_mode =3D true;
>>
>> -     plat->is_dma =3D dev_read_bool(bus, "cdns,is-dma");
>> -
>>        /* All other parameters are embedded in the child node */
>>        subnode =3D cadence_qspi_get_subnode(bus);
>>        if (!ofnode_valid(subnode)) {
>> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
>> index 879e7f8dbfb8..10c4ad14cc05 100644
>> --- a/drivers/spi/cadence_qspi.h
>> +++ b/drivers/spi/cadence_qspi.h
>> @@ -223,8 +223,6 @@ struct cadence_spi_plat {
>>        u32             tchsh_ns;
>>        u32             tslch_ns;
>>        u32             quirks;
>> -
>> -     bool            is_dma;
>>   };
>>
>>   struct cadence_spi_priv {
>> @@ -261,7 +259,6 @@ struct cadence_spi_priv {
>>        bool            ddr_init;
>>        bool            is_decoded_cs;
>>        bool            use_dac_mode;
>> -     bool            is_dma;
>>
>>        /* Transaction protocol parameters. */
>>        u8              inst_width;
>> @@ -292,8 +289,6 @@ int cadence_qspi_apb_command_write(struct cadence_sp=
i_priv *priv,
>>
>>   int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
>>                                const struct spi_mem_op *op);
>> -int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
>> -                               const struct spi_mem_op *op);
>>   int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
>>                                 const struct spi_mem_op *op);
>>   int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
>> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_a=
pb.c
>> index 4696c09f754b..58be017720bc 100644
>> --- a/drivers/spi/cadence_qspi_apb.c
>> +++ b/drivers/spi/cadence_qspi_apb.c
>> @@ -667,125 +667,6 @@ int cadence_qspi_apb_read_setup(struct cadence_spi=
_priv *priv,
>>        return 0;
>>   }
>>
>> -static u32 cadence_qspi_get_rd_sram_level(struct cadence_spi_priv *priv=
)
>> -{
>> -     u32 reg =3D readl(priv->regbase + CQSPI_REG_SDRAMLEVEL);
>> -     reg >>=3D CQSPI_REG_SDRAMLEVEL_RD_LSB;
>> -     return reg & CQSPI_REG_SDRAMLEVEL_RD_MASK;
>> -}
>> -
>> -static int cadence_qspi_wait_for_data(struct cadence_spi_priv *priv)
>> -{
>> -     unsigned int timeout =3D 10000;
>> -     u32 reg;
>> -
>> -     while (timeout--) {
>> -             reg =3D cadence_qspi_get_rd_sram_level(priv);
>> -             if (reg)
>> -                     return reg;
>> -             udelay(1);
>> -     }
>> -
>> -     return -ETIMEDOUT;
>> -}
>> -
>> -static int
>> -cadence_qspi_apb_indirect_read_execute(struct cadence_spi_priv *priv,
>> -                                    unsigned int n_rx, u8 *rxbuf)
>> -{
>> -     unsigned int remaining =3D n_rx;
>> -     unsigned int bytes_to_read =3D 0;
>> -     int ret;
>> -
>> -     writel(n_rx, priv->regbase + CQSPI_REG_INDIRECTRDBYTES);
>> -
>> -     /* Start the indirect read transfer */
>> -     writel(CQSPI_REG_INDIRECTRD_START,
>> -            priv->regbase + CQSPI_REG_INDIRECTRD);
>> -
>> -     while (remaining > 0) {
>> -             ret =3D cadence_qspi_wait_for_data(priv);
>> -             if (ret < 0) {
>> -                     printf("Indirect write timed out (%i)\n", ret);
>> -                     goto failrd;
>> -             }
>> -
>> -             bytes_to_read =3D ret;
>> -
>> -             while (bytes_to_read !=3D 0) {
>> -                     bytes_to_read *=3D priv->fifo_width;
>> -                     bytes_to_read =3D bytes_to_read > remaining ?
>> -                                     remaining : bytes_to_read;
>> -                     /*
>> -                      * Handle non-4-byte aligned access to avoid
>> -                      * data abort.
>> -                      */
>> -                     if (((uintptr_t)rxbuf % 4) || (bytes_to_read % 4))
>> -                             readsb(priv->ahbbase, rxbuf, bytes_to_read=
);
>> -                     else
>> -                             readsl(priv->ahbbase, rxbuf,
>> -                                    bytes_to_read >> 2);
>> -                     rxbuf +=3D bytes_to_read;
>> -                     remaining -=3D bytes_to_read;
>> -                     bytes_to_read =3D cadence_qspi_get_rd_sram_level(p=
riv);
>> -             }
>> -     }
>> -
>> -     /* Check indirect done status */
>> -     ret =3D wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTRD,
>> -                             CQSPI_REG_INDIRECTRD_DONE, 1, 10, 0);
>> -     if (ret) {
>> -             printf("Indirect read completion error (%i)\n", ret);
>> -             goto failrd;
>> -     }
>> -
>> -     /* Clear indirect completion status */
>> -     writel(CQSPI_REG_INDIRECTRD_DONE,
>> -            priv->regbase + CQSPI_REG_INDIRECTRD);
>> -
>> -     /* Check indirect done status */
>> -     ret =3D wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTRD,
>> -                             CQSPI_REG_INDIRECTRD_DONE, 0, 10, 0);
>> -     if (ret) {
>> -             printf("Indirect read clear completion error (%i)\n", ret)=
;
>> -             goto failrd;
>> -     }
>> -
>> -     /* Wait til QSPI is idle */
>> -     if (!cadence_qspi_wait_idle(priv->regbase))
>> -             return -EIO;
>> -
>> -     return 0;
>> -
>> -failrd:
>> -     /* Cancel the indirect read */
>> -     writel(CQSPI_REG_INDIRECTRD_CANCEL,
>> -            priv->regbase + CQSPI_REG_INDIRECTRD);
>> -     return ret;
>> -}
>> -
>> -int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
>> -                               const struct spi_mem_op *op)
>> -{
>> -     u64 from =3D op->addr.val;
>> -     void *buf =3D op->data.buf.in;
>> -     size_t len =3D op->data.nbytes;
>> -
>> -     cadence_qspi_apb_enable_linear_mode(true);
>> -
>> -     if (priv->use_dac_mode && (from + len < priv->ahbsize)) {
>> -             if (len < 256 ||
>> -                 dma_memcpy(buf, priv->ahbbase + from, len) < 0) {
>> -                     memcpy_fromio(buf, priv->ahbbase + from, len);
>> -             }
>> -             if (!cadence_qspi_wait_idle(priv->regbase))
>> -                     return -EIO;
>> -             return 0;
>> -     }
>> -
>> -     return cadence_qspi_apb_indirect_read_execute(priv, len, buf);
>> -}
>> -
>>   /* Opcode + Address (3/4 bytes) */
>>   int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
>>                                 const struct spi_mem_op *op)
>
> Your patch results in corrupted SPI NOR flash writing from U-Boot on
> starfive_visionfive2_defconfig target board Pine64 Star64:
>
> a040578d8270ed8788d7663808ea63ce5ffd7840 is the first bad commit
> commit a040578d8270ed8788d7663808ea63ce5ffd7840
> Author: Michal Simek <michal.simek@amd.com>
> Date:   Thu Oct 9 12:34:48 2025 +0200
>
>      spi: cadence-qspi: Remove cdns,is-dma property handling
>
> Steps to reproduce with Star64:
>
> 1). Set JH-7110 SoC RGPIO configured for UART BootROM loader mode
> 2). Power on and Transfer U-Boot SPL by XMODEM as prompted by BootROM
> 3). Transfer U-Boot main by YMODEM from U-Boot SPL prompt
> 4). Having `(cd $HOME/build/u-boot && python3 -m http.server 6789)` or
> similar for serving U-Boot SPL and U-Boot Main to save some time with
> UART transfer:
> 4a). wget $loadaddr http://host:6789/spl/u-boot-spl.bin.normal.out && sf
> update $loadaddr 0 $filesize
> 4b). wget $loadaddr http://host:6789/u-boot.itb && sf update $loadaddr
> 100000 $filesize
>
> Repeat steps 4a and 4b, note that each time all bytes are written and no
> bytes are skipped. Written data is wrong and device unsuccessfully boots
> in SPI NOR flash BootROM loader configuration showing wrong information
> to output.
>
> Please follow up with your analysis of why these changes have this effect=
.

I guess this is because the committer didn't take into account that when
a DT did not mention the property then it is 0 (false).

I assume TI K3 hardware is affected as well. So I think the patch must
be reverted.

- ron

________________________________

Ce message, ainsi que tous les fichiers joints =C3=A0 ce message, peuvent c=
ontenir des informations sensibles et/ ou confidentielles ne devant pas =C3=
=AAtre divulgu=C3=A9es. Si vous n'=C3=AAtes pas le destinataire de ce messa=
ge (ou que vous recevez ce message par erreur), nous vous remercions de le =
notifier imm=C3=A9diatement =C3=A0 son exp=C3=A9diteur, et de d=C3=A9truire=
 ce message. Toute copie, divulgation, modification, utilisation ou diffusi=
on, non autoris=C3=A9e, directe ou indirecte, de tout ou partie de ce messa=
ge, est strictement interdite.


This e-mail, and any document attached hereby, may contain confidential and=
/or privileged information. If you are not the intended recipient (or have =
received this e-mail in error) please notify the sender immediately and des=
troy this e-mail. Any unauthorized, direct or indirect, copying, disclosure=
, distribution or other use of the material or parts thereof is strictly fo=
rbidden.
