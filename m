Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ED0C61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 19:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC0A081F0D;
	Fri,  6 Jun 2025 21:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="MSdcO1UT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8177582AAA; Fri,  6 Jun 2025 21:49:16 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9263F807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 21:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nY5qYtD7+f9tib1faN+YN4MSjCN/Gk85owASKbj+EEaqVICI6JjkA32CaBtV0T3rLong/hWOZbrgE9FN8QisFArFjrfAxzvlxhJIb1M+E1Jz/ieBgYfWo68QcKXjbgSFIb236He1E4/RNykNpBipo8ewDS1QK9S12EXv190p862kPvdGXvE1AAs+wcd8dyrrm9SknGIXmVAZRCNhWFPRIBUpoIj/Mj44jIkgUncHn96rjI4W4ImfxaLdvuS549Qj9NUmOa99Efgfrf+7eSc9ePDfj/FbVV3WAJCBfnvTSpn6c0OVym3sCygA23xq/8ZMfbnUWFVmjcAHsb/GlhE2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9KfjvkJiKVzAj/dEqSwjEcCVw4y1duuOGnhK0kOZQQ=;
 b=Qm+i1n8YwRUpign5EAuDlQZc78Ogj3tt5/wETt5iBjFe9nzl3ACBgyyQLGcUAXl8h72jKmADDziKqY874TzQSC7CITPz1GWqtEwNcoQwiz1rnoSv7k7pG7yyhMorhYZqjyFbq5l67ISnnRFBqaaRCeWUpcBYYKLhRyPjikfqs2vSjmdE3rlh+9YuKKQSHwH3J0y57n18F99RoYhfXpDG9JDp5FnbWDn5ZZUa1FQ3tUrWBAXPSCUxMtC5EsQaCpHINpY4i6kOwzoQ0S1gHiHbrO4jMVqgQgaBcdNamMgPdVWaDXKClcO+EfWWtx+pLXxPfxSMP94VybPQQ2q/iSWmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9KfjvkJiKVzAj/dEqSwjEcCVw4y1duuOGnhK0kOZQQ=;
 b=MSdcO1UTVBPQsD+eRR18/MTg6rSGs1XCTqLwy99NbqmQ8IJXEEsk6LNZceggwNRmjQWa9llGag48quDBUnT6j/HeEUPSMnxC1FrY+8Cr1yprYdxSZNZRQ1BDqGV7EJNP0CQlW0BYT1WEBwUpPQ/l0CzUUMeiI8oW8i5nMwE/yxsIYJEJrbZqN7Qo/2xfR3aCj8Vd2jAfm2e7wPZwv/8f8T/YBzMEWZgYin65nZCohFS2+Q4hfbrxC10LpAaLMFz5NkLh9hkNGNq/PQlqRzZ/LkJuzD7O09mFomswYZ1/CM+TjmFSZK4iIxMol+C3Bb0hvaul+4AXU5tZu8bZTCTNtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB8992.eurprd08.prod.outlook.com (2603:10a6:102:325::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Fri, 6 Jun
 2025 19:49:11 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 19:49:11 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 0/3] drivers/net/airoha_eth: fixes
Date: Fri,  6 Jun 2025 22:49:00 +0300
Message-ID: <20250606194903.459732-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF00011B62.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:4) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: a873e1b9-a93f-4015-e72c-08dda5333518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWlwekxWaDNvSUlRUTc5VXE1VGMzZnVoUjV1SnBEWFVMaXZ3ajI0VitrNDlS?=
 =?utf-8?B?RVlzbUtSZndzR0RxUE1mQ1lkUUZObWEwTTlaUWZISDcyRUdTaFAyUTFlcVB2?=
 =?utf-8?B?ZldPb242VVRHaTBSOWpQa3JGbU9kYUN6R1BNcUdMVXA2OUNGSEg0MHNoVU9y?=
 =?utf-8?B?dWVNVTFHclRKbTVSQ2U4a3k5dTJCUEkrT3BGYTFhdEsrZHlsMkorMG4zSmVj?=
 =?utf-8?B?Q2ppM284RVh1TlV1c0c1c0M3UjlGU0NGb05HdWpFWnVqRzcybHExZjI0eENO?=
 =?utf-8?B?bUc1bDRCUXM0ZTA1K0FzUExxN21pQzlZQTZtVGh5cE1zTCs5NVIycE5ZQXRs?=
 =?utf-8?B?SGdncXYxRnBvSW1WR3VCVkNBUENRTC9zeFFFOTdUdXdudytzaFJSK1FpV1NU?=
 =?utf-8?B?dmxrUVk0RXU4RDVLUkRWbnY2anFUa1YvdFRGLzVGZ3EyT2E0Z1dNWVcwa2lw?=
 =?utf-8?B?SytDZktHUDZISDlHQmFkUGY4M2V3Skw4ZU5hN0cwcm1xVXFFY0diVmRnQ3hK?=
 =?utf-8?B?S0FSUVpGTk5FZTk1Ym1zNnM4bzhobFdNZVpKT1JWN0FVdTFZUUQ1MlFGVEVU?=
 =?utf-8?B?Z1hzeWNyRVlsMVhpd1FrcHl1YnF3MTBlK0daZlg0M2ozVFVwTG9URXE0ZVlj?=
 =?utf-8?B?ZFB3UGxLNWlEbjVjRW52eDdrSUZ3Y0s1MHhIeWJvM2t3R1RuVWwrU0E4ak4w?=
 =?utf-8?B?RXdtN1c4WnFXUGgwenNuV2h4dDNyaWVldUdwMTJ6cVBiWUx4SVlPSjdIcE5p?=
 =?utf-8?B?MWU4YVluaEhFYlk1dnlncWU5ckRJTStHRUl5TnRid0ZpUlhUQnNPbXdSdVM2?=
 =?utf-8?B?cXBuNWNzWjBjQUdSZFV2MEJGOS93RCs4OUE0MmNURTFYQVRwcmx2WG9IdFB0?=
 =?utf-8?B?L015cVhKdU1TMzlOc2xQNDlGTzMwN3AwY21zM1ZUeHJ6dUFkejVSZWVSanVW?=
 =?utf-8?B?S1FSbDFwTUxvMVIyK05yejhiYWdCby9vaUE3RTRyVlNaUHN0R0Y5RWEvc0tj?=
 =?utf-8?B?ODRPYXhqejg3dFhpc0J6bC9FTk0zbTduQVY5UEFVVkNjSU9oL1hMTGVBdTFJ?=
 =?utf-8?B?YUY0S3JScWN4NlZINnhoVWpNZmE4eUlrNkpFTjNJc2pqbGhBU2dRbmFISlRx?=
 =?utf-8?B?ZW5VTzdMSnpGRjJvczRlYUtRR0RVMWdjZnJWTXpWK2FrVUYwYW5HU0pmZlhS?=
 =?utf-8?B?T3NrOVRiMDJCMlJXeTNPc1V4UU9yMksxV0Z6a21HY1hzZWNvZFdPRi95ank5?=
 =?utf-8?B?cFd5TVhOTGo0VnF1SlFlZkRIdWJCUVRlallRUkJEZzc0S2ZJMElhdmhnWXU5?=
 =?utf-8?B?cTZXR0NFTGljc3VqakZzUk5VNEN5OE83REo0cm1HeitHNWFDTTByeE9ZcmFr?=
 =?utf-8?B?WmNIaWNmNEpCb015UnFtUlNGYkt0NHBLbTh0WlAzNVh4YzhZcnVjMVpGbjJz?=
 =?utf-8?B?VUFsWkZ4NGRNNE9ndDZWWUVkZ3RjRnQ5Y2RwUERvSGZldmJwMS9tL0x4NVUz?=
 =?utf-8?B?V21iRDVjOGdiWkx6VlBBRTZ4Q29uRUNHeGxNRWtNWjNndnpaKzN6OW5iRVlz?=
 =?utf-8?B?TXVuV1NMWnYyVVdzZnJvcUZ1ZkRHMWRIWUpwZjJJdlg0QTBjVStXRFlUeWRC?=
 =?utf-8?B?SHhkZWxkTWlhd2VVZmFSMG45Q1M4TzVHUmFqVzljK3R5aHZpbW9PWkVoMytl?=
 =?utf-8?B?NGZjeHRldjFyWWlvV1I4UDhoN1dmc1RMRHpjZlFZcEVwQWhpeklqZTdERFM3?=
 =?utf-8?B?dnNGbXlwYkpPWE41QVZVb1U3ME5NeVRNcGZMLzlQNkVGUEVPcnhhcUdGQWlQ?=
 =?utf-8?B?RGJyQW5MZlZaMVhWaC9zYXlVOWdRL2Nid0U3aWk4YUp1MWpxTUVrd0JKTkZk?=
 =?utf-8?B?SGk5SXlxeU93UUVrRWIwVnN5YVFraHVhUzUzUkh4Y01pcWQzK3JVbjFTVG9E?=
 =?utf-8?B?L1Rod3V1S1VmeTB2c0V2RXJILzc2K1RqVlBzNVlTdXdjTHFyZVpGOHdKQmRS?=
 =?utf-8?B?dmxRbGpQZ1pBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTBuWmVrelpxeE5FTlBYendtaVEvUU11RDJkSmMrRno3WTB1V2ZtaFNyNW1n?=
 =?utf-8?B?b3BrSTZtNFIrL2VaNjF4TU9xUXhXT3h0U3JKYzc2ejZOcUhZSmJvZ09WaExO?=
 =?utf-8?B?cjcwUGtpSXR1d09aZ0c3clRjNTZYSUplcTBRSTM1YkJBS2FSUmtyUG1xelV2?=
 =?utf-8?B?eEljbkowTGdUT3JwWkZoV05YUmp4VDk1MGRQbDhqQUJsZTRhbEVKSjFBWnhV?=
 =?utf-8?B?Q2hwKzJpRm0ydDl6KzBLNm5senNSN1ZKMVY0ck1mOXNQSm4xcWpVQXV2MkFK?=
 =?utf-8?B?YzlaVG5hZk5Lam5LTVppSFVEQlBXQmxvR1JOdE5MUzREOVB2V2VBL3orczRQ?=
 =?utf-8?B?RGR1ZGdoVlZ0amFZUE5VTCtUblZxSVcyRU1lQ0NtNlZsbjB2cnUwcVd5Q1VM?=
 =?utf-8?B?Q2FubmFSRWFTYWo1b3dXZlZpS2xhZ2Mvc2F2c1pyb1BrNWZsT3BqcXh3OGpL?=
 =?utf-8?B?YW9ueWN2cXB5S3JTUm9RZWRZRklRb0dVS2tqV1Mwd2xqdW9pYmhVQmZXcHNY?=
 =?utf-8?B?U0lSc0cyYkQ3YzZWSkZBOER6SWwxYUN5RjV5eUpLYzFhOWorNzRLZGNpREQ4?=
 =?utf-8?B?TXdTQm5ZS2gzTXRaa21PN0YvekxoUk4wb1RSQVdEZDRCemV6ekhacGNuOTB5?=
 =?utf-8?B?MGlYNU94aDQ5WFFWZVRvdkhEMU92NThvV2tVVXQ4QWhiLzZobTB5VFNVL3FK?=
 =?utf-8?B?cUJIYm9UaS95L1J2d2U2dmUrKzQrd3RpVEt5a21wMmdBZDBZa012K0xDM2dL?=
 =?utf-8?B?VE4wdU9ob2hHUEsweUNRbTBZTitYSis2TXZqanBqL05vclIvRHNndDRpalQ1?=
 =?utf-8?B?YUJybHgwNERGM1VVMWR6VmxZcTlFUGRsSWVaS0tSS08vOW9LSkwzRHBVeHRj?=
 =?utf-8?B?YlZBTW15WDcyd0RiZURXZldyeDNGSWplcmlEeGVNZGh0QzI1aUtsYUJoQ1Ew?=
 =?utf-8?B?M0twU3h1T0lvZXdwZEtSTkJVenp3TXNkMVp6U2tBU0ltbFFvSjFDNXBTMzlq?=
 =?utf-8?B?Q0xpaElxdUJwMGxFTmY0RHBidjR3VjkxVCtRbHFOZFVvenZTOWN0WlJPOTc1?=
 =?utf-8?B?UDVYSnYyQkpsK0RxaHZDb0N1OEVPMERFVmNvd1FQaElIUm0wTjd4dk1STzRP?=
 =?utf-8?B?SEFqNFI1eEZoM083YlFLWWUraThaSWFZZ08vL0UxS2RVeTdGYkZ1SzJWclVF?=
 =?utf-8?B?VTVQTUdQUVNqbEdCQklkZi9Vc2VqU205TE5rR3FTd2pJOFpqSjdNRW1tNFdh?=
 =?utf-8?B?UHdhS2svdmFVYy9ZdWkyZzNCZHNDb2xVUk82V1ZsQXdKSkJTeDFzZmdNazFE?=
 =?utf-8?B?d0dVZjJjWUhkQmlZUUN1VE9VejV1Y0dwbHRTdUNoVlRwUDV4MUxmMTg4cVdD?=
 =?utf-8?B?L2lnK21lVWJ2VWNpaUEyeEE5WnRWL09vdkZSR3JmZ3NZWkM4L3B3MklOb2Jl?=
 =?utf-8?B?Z3o2dlh2QnhOb09rNXp3bTJXdllpa2pWbWhUdXI2NzBFaGVUS1pJb0J1dlpK?=
 =?utf-8?B?ZkxRUEEvK1BRa2tUdVE5VmtETHdWMGJ6TVZRdnF4QUJLaGFBZTZXbStiMTBH?=
 =?utf-8?B?WTMxQm1WanN6YSt0a2t1SFdibTM5Z09na3Y1L1FxN0t4SjBORlhidWJpVGdy?=
 =?utf-8?B?Q0RTTDZkVlpZOG8ycEZNbHo4cTROMElqMmVZMTlSTHlmUDJmTlRzNFhRajRX?=
 =?utf-8?B?TlprNU44Zml2VVRBRFhXdzgrVnlUdzNMQlJ3MzNwZVVjdG9NUEZGdkV0RWVM?=
 =?utf-8?B?SURFWW9tRWtnd243b0RDY3lrSkFtYTZvVUppaU85a0NDWEVTYmhlV3hMZWQ3?=
 =?utf-8?B?bVJIekNmNTA2RFpsa2o3bjFaWjFtaFhKRlo0VDRVY0RxZjJFZDExaWhUd3lv?=
 =?utf-8?B?M2RMdUdmRkkwZzUvUmZncjNwUWMrTSszbjlBVG54T3g0eE03QjNjTXNCeDRi?=
 =?utf-8?B?UzVHNHNWcndCQjhsU2VTdkkwS29MZk96VkhQMXJrRGhhTkl5ZElaMlZiUURk?=
 =?utf-8?B?YTBlcWNTVzgvWE1PZlZ6SjdHU1krS2NPU1RweXJvbzFPY0ZlMzY5bVpxbTc4?=
 =?utf-8?B?VVIrTmVHenRVenZVa1dsbnJLUU5XWUgrNHA0aTIzb2YzWlozanQ5TzQ5Ymlr?=
 =?utf-8?B?NFNFQ0l6MkxvaGFuN1NyUTh3M0wrc21mZzFRdTloK0pCTjN0dGlPTy9rK1F5?=
 =?utf-8?Q?x7GkKMzsDdAtrBgFEIiGTvw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a873e1b9-a93f-4015-e72c-08dda5333518
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 19:49:11.2118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDp2WFHLfuAZ8G+ToodLpPYIgJ6xKIuCfXWb4CZ3ywhIlHQOvH/f3go9yG7MfAnJXKKY3ZcqfmK2iuUz7TyxIWfDEJvEGH2+a7cKPxIvxVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8992
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

several fixes for airoha ethernet driver

Mikhail Kshevetskiy (3):
  drivers/net/airoha_eth: add missed terminator for compatible devices
    list
  drivers/net/airoha_eth: fix packet transmission errors
  drivers/net/airoha_eth: fix stalling in package receiving

 drivers/net/airoha_eth.c | 69 +++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 15 deletions(-)

-- 
2.47.2

