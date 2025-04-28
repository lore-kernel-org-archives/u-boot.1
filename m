Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455BAC369D3
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68E0382918;
	Mon, 28 Apr 2025 12:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="h61HCTV8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EBDE82145; Mon, 28 Apr 2025 12:39:06 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A46C8272A
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEea41o1jLulkNz0Wmtq2bBFy2Wt/ajs+ZxKoweXfpYD8KTjlyRV1pD+nR4C6GerTz/EzaISoB2ioJ7wr23/4kNEMgeiHsANGqWC9EFISCFIdnoNQLOGrhFwCvgzlyxR6cJAhSTKH1UiuFLkjqPcez617nw4KsKGWI2AGA5ayhXsbfaDSyUzpnQZ+nw9t17wx8K3Uh3GTWIvJtbtN+S2MjOkiAVh/wXw3k/q3GGAc6CNDMK1c02UEjXeVW2WvgJpFearQKzZj5LrS3tznzpdMAR9lAoOU+NUZXxMShiy1tGdqe2dBT/qM9eLy6i34fy0IgjLxC0mr1GCVwXFUHkdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9+It9L2QfiZ5GzRSWJHUlr6ud+tpHmWbslmFiKPX4U=;
 b=reVsmsjotOhJ/FZwNU3Rdp0binWUrW1EvA+gRVNEMrpooHDkBmafG5YfujK4PECW3n0Ed9rLNs2Qn5cD4ip8K7AMCcfSyL8nzyWazLmdtIQaY6oRSqp0RQtcE0b1urKYqcW48D6J+xcytwXvK5AnJ3g5IxI1+3QVOX3QiAouqXhy12FkHVWs9nf0Qogbk84ZDSkUwl7qwk4mV0f9hqSkVrngtuQBNZr1sXbaxIUEVbmElM46Un+sM/EJEDyUW7vC6aATO/IcQAEN5m/vVIb8XwXpODerDpKD5nQ33LnE4Jjfd4fHewbRsVw3tuXHKr4mjRxzQABd5HItHn1chHMgkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9+It9L2QfiZ5GzRSWJHUlr6ud+tpHmWbslmFiKPX4U=;
 b=h61HCTV8LBC2wRVB/FdHiJ5PJwNY5Mcb/ceE5jMsPpUEsc8VGIdIpSE5+20EJyKaZ4C2Gvo9pS6OIOEToVXfpsVWQ66jFuSd6C3/8Q0CttRf4jOltS3yGFJjTpVrbeiq048s0YYTSvMavmG+QSy+ScB1QSUNdhQK3UYkI4o0bWIMlaDgcSkz3Nn8VZQqlJN7MOPc+xmtocUNNFEQJ+BEPF+fCpvZSvFejGvNcoPLkgU0y2uOOdBtHYOOgte4YosRueq4RURWNKid50ZABofrXlX6iKm+tx5iJ5bCAS9rSFTPShJBEMeIzNClHZ+/14nPhdtwdrn5G4BKWK6acQGMqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:39:01 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:39:00 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:32 +0800
Subject: [PATCH v11 09/21] sandbox: add SCMI clock control permissions to
 sandbox
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-9-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1a41f3-d2fc-42d8-0898-08dd8640e33e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWFtTWVqd3Nwb1BvSXF3RENJaVZEWnA4bXhBZERTVHpVeklLaDdWV3N1M3hN?=
 =?utf-8?B?Wlg5emZEUE1NVUlmZkQ3UU12QzZIUTNSZ25BOWcrMkhJZHlQOW00aDVnc0RD?=
 =?utf-8?B?UWRENzNIWXFyYzd1Q2xnOXlUVDRzQUNyaGpRZ1EzVzJuWDduMTlEeUJlTk5W?=
 =?utf-8?B?NDNEZ2JGMmNXb0pqSjg1SGR1bllHVVIzNmcvR2pReFdWcUJJWmxkQ1RxQXBS?=
 =?utf-8?B?YmV3cm5iSWd2ODZ5cTJCVFJQMXJRdVlFTVRQNmg3Z3dFczBGa3FUdUcrZWpp?=
 =?utf-8?B?eGg0aVQ0aDdYSTFxTDFUUFVicVBrb0JrNGJKSUt2VkJPN2Q5YTR4ajRMRVpW?=
 =?utf-8?B?VjFkcFlkYWhaakh2Qkp1T1VySWZPQjF6amNRczN5d21BZzU3VlBiQ25lL0ZH?=
 =?utf-8?B?ME5JUDBNYmxOUWg2VU80UDh2WmFLTmhMQk9uZHpIZFdqODdRRWhoNmNuL2NF?=
 =?utf-8?B?K2xiUnFWN2tJRVJyNEMrb3BsMDM4YlNZWDBGZmlRdkR2UUZuemgvM0ZLWThW?=
 =?utf-8?B?R3hwREhqRzYraGY3MWlqdzhGSjJ4dkFhK3AzR2RKbU9LVS93M3ZZRlZOQ2hJ?=
 =?utf-8?B?VVM3NUNadFYwT3gzSEV4aTRKZUxzZjg1RnZ6cmRoYUlYWGxRVmsyejhQWjlM?=
 =?utf-8?B?VU54MzEzOUFaK1huWXZ0aHM5Zm5UU0REemxIWGJoaFE5K2kyUzdzU2F3SWJC?=
 =?utf-8?B?N2ZURk0yWmh0NFlhcVFEUUFjTE94aW5HZGZVbXlNRmdIYUNzQzBTLzVzbnQy?=
 =?utf-8?B?VE9BSVAxTkpJakpybjllVkRGT09vM0xmTmNUREcvTUUraUJUcHA1NGltUU8r?=
 =?utf-8?B?Zm51aW0raVFscVZYcEkwN2FBc096aGErSXEzUjlQYzJETnpYWFJjTnczbHhQ?=
 =?utf-8?B?UlRISHNGS0xFa2dVdTNHUUFDRlZMY05ZQkd4Q2lYYjNRVFNGdldBQ3JsdElF?=
 =?utf-8?B?N1QxdWFBcExjN0x2MTZBdzBtMkF2bUxjWlo1d1JrUVJENWwrUHZCaVZidVp3?=
 =?utf-8?B?bDQ3ancxVVZiMUU2cWdWWlB1aWl2Y2Jlc1BwQkU0QUpEbS95cXhaU2FrdWhp?=
 =?utf-8?B?dXFQRGJWUUIxNE1EbXdKSTA3TmxrSjZYenJxb0ZtWnVGVEFoRk56YVZMdmZJ?=
 =?utf-8?B?MnZRWFpsZkljMlNsSUMrVFduQVZLRDhjSGlKblg2eC8zMVVjaVdXd0ZLYXoz?=
 =?utf-8?B?L1pZbmFwQUhUQlNtWGtZZTlkZzBMbEs1cHpBcnAzNVVRcnlJY04yOTdnSDVs?=
 =?utf-8?B?K2w5T0xwVmJTWWdxZ0tmanpqUk5vMUJGL3ZleXhhTU5sN2VlRXpuSC9GeUtJ?=
 =?utf-8?B?THBHd3RBS1lKL0lHZnF2VlYwMkEwTG8zZ3pzVzNNUXhRc3V1R1pTYWkveWFG?=
 =?utf-8?B?TmtrN1dDb3I0cExFSmZqMTQzYnNyRWNPL01FVHpZWHlhelpWQ0NmcloxOGJR?=
 =?utf-8?B?a0J1Q3krYm5sTVZNblg2UEhSTzZ6SS9wZWI5NTB6S0lxUFppWDVuYVoybDNQ?=
 =?utf-8?B?Q1BVRi9ON2JvM0ZYOG03a3hXQ2NVWlVnK3htNGt3T1dOQ0ZzNnRpdzRDb3VB?=
 =?utf-8?B?cU1UUkgwZWlkU2h0VUtCcHh3ZjMxbW1YcC9vSXRid1ZtN0ZLeWVoSENRS3Iy?=
 =?utf-8?B?Sk1mdHhQZGNnUndMMjc1TzZMcjhRRDVBUGlFcklHaXhzV3oyZE1Oek0xUTcw?=
 =?utf-8?B?NmRlL1M0bDFCa0I1Yi9nd3YwdytQVUFvRU8vOVZUNXFsRzIvYnEydER2TE5D?=
 =?utf-8?B?bWlLMkdKUnRINmZtdXhsQlBaOHlyMUtsaS9HYlNxc0xNNTg1eGYvQlUrS0tH?=
 =?utf-8?B?a1BHQkViYzFPVVBGZ2E2SVFTc3hsZ1FEU2o2WnBVMDV4SzdPMmRzYTI3RVRo?=
 =?utf-8?B?NFlXT3hwMXJEbzA2RXR1NG95L2o5VUpLcExENUJXc1hIYTNiNEtKajBjY21D?=
 =?utf-8?B?UkI1UExDNEpvYkptYXFHc3hXUHErK0M4djROZTEvKzVSdW9hVkEvbWVJK09I?=
 =?utf-8?B?NDdMNXlWbnRnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG03amNzTU9EYzRERG9jOCs1aUJRWkY0Qk5NVEl5UUNRUHBjZzJOdnhYTlhV?=
 =?utf-8?B?TW11ZGJ3OVhRMjhMRS9aNEFXcW9paVIzNWU5RHMvdUowK1NHM1hZL0szNGxx?=
 =?utf-8?B?WGN2V1EvRHJ0dFFwb0k3MzB5bXUwVnRKUTFDbGxWbzFLTTl6VlpWbDNxUXU3?=
 =?utf-8?B?ajdJUmcvM2NwYUhGRjNjQnh0V2tKY3AvZ2FBR2xlOE1yZEIwelFEK3RRbXhT?=
 =?utf-8?B?VklNcm90T3d5SkdXWFFIYXJQdHJSWklHTTRtV1RZb0Z0UnlIcFFvTWZtWjJs?=
 =?utf-8?B?TEMyNjlOMWpIM0MraWE1Y1JKQ1Nrc0ppR1lmUGlSRFBGWDJTaWRqQ0M1ZDFt?=
 =?utf-8?B?bnlRWG9XUzhoWGRaeFBKbFhZbHF2MVRFc1hqZzlYdmR4ZkNsSXhMUWZTNUM4?=
 =?utf-8?B?d1hwaWVjVXgvZUV4dEorNzZhN3d0MzVDUGxoY1F3WkE1Mjc4SXhEM3lVcHIr?=
 =?utf-8?B?T2Q2UGVtWU9zaUQ1R1NnMDhwK3UydGUxMjdqQ3dFbFRRQ1NqK0xOWE9UaldX?=
 =?utf-8?B?QStkakppU2k4SVF1cjU3NndLdDY2cjdSeDcveEtvTVltaDRPdkdyeGs4N3JU?=
 =?utf-8?B?Vm54VE9tV0JmWlNHZVd3Wkl0ZytZSkxERmxNZlVTZDBIa2MxVlJScE02Wjhn?=
 =?utf-8?B?NGFNZW5CWEJIa3ZxeGlmWnFvN3A0SERBcHFWN21pZDl4V3hkL1gwNDZzZGdX?=
 =?utf-8?B?QzNZSTYvaVQ4U05zcHZid05LOGdmVHFTQkNVdGtvRUw1WUlSNnF2d0djT0Iy?=
 =?utf-8?B?YXV0Mm52SVpENWVJZXpEbU9VUzVEYjlNTVJPeEgwY1d3cDJGSEdmM1JHTy9E?=
 =?utf-8?B?dEtBbDE0ZnFQcys0QU5Edk9PTERuaVhGM1ZHMmFjR0FwZFNzUzdSbStNck91?=
 =?utf-8?B?MzRvejZsMUhRUW9kZTQ0d3JiWnErVGlJY21xcTJ3V2hGRHBHSVE0VGRZME93?=
 =?utf-8?B?VElZbTNmMGZnZSt5ZTVObGhFdXo3OW9SV1o4bTdZRGl4cUM1YzA2L3hYV0VK?=
 =?utf-8?B?Q0VHK0NhbEtRMHlLNm53SVZYeVl0TFdFeDFRY3RqcUt3Zm5sbzhJM0c5WTN6?=
 =?utf-8?B?Ujg5b3pzVmZpbFQxM1dEd2xFRHBkaEhkSkhQdXpYTzNoYzBZRkFsWmNCalNw?=
 =?utf-8?B?UzQwZFV0N3BCMUlzS04weGE4dGp3ejhFTG9nZE1SSnNQb1NoRTJGdkg1dTBM?=
 =?utf-8?B?TUhXKzRMblkyMDdYUXdEdGwrS0RNclBoTkg0azBnR2x3NDN3SVR2cjVLRWxj?=
 =?utf-8?B?QUpnUk14aktxbXpyMUEyZE54SE90VEtucXIrRU5pL2lieGovd0VBWER0ai81?=
 =?utf-8?B?eXViY0grcUpLS1RrNTIyV3UwOGppclNzS3R4YVZSa2tKeVpjd3lyU1RyZ0hI?=
 =?utf-8?B?cm54YklncmVmdTUrNVRORlZhRjdFT1Jmb1ladCtpbnVvazVJQUdMQWlFMmpz?=
 =?utf-8?B?TDJ1QW50TjJNWVpQelBPTTR3cjlQZWR0OHFxYjA1QVZGM1UxZ3pHc2xPM3d3?=
 =?utf-8?B?UWg1SkFaaFplMnJDNkIwblJWTzlaNjZoa2lCMS9wL0dpTWJYNlY0djBQV2Nu?=
 =?utf-8?B?L1Z4RUREUFUzdmFnZ1dJMHZRNm1Rd2UxbXh5bWphQlhzcmpLVGF4Q29DUVlo?=
 =?utf-8?B?UDRVaittTmJXdkpjeWdCRTVlcXJNS0todG5GRE9GTjZxYnQzdHk4UkkvUkha?=
 =?utf-8?B?YVF5a0VBRkUzd0djalFaR2YyNTR6Nzk5Y2ZueXpFbytoSU9QVUdlNmQzMTZ5?=
 =?utf-8?B?M2xzOWVsV01WSjdHSmRWbEVqMGJ6d2ozYUowWVJlVDBXNCtXZFFlU2ozdy9Y?=
 =?utf-8?B?SFJQTEdIVWhWb25xYjNpWTdESTNCMUcxS0ZLVnpnRURUWDFOUDh4QzdQQ0oy?=
 =?utf-8?B?ZzV1KzMxaHYyb1NpbytXUG9KSlQ2WG0zaTMzVndGbTdmeUNKM1dVb2VybjBq?=
 =?utf-8?B?TkZFanh5ZHZXR3VsY1cvd0ZFS2ZIVkNLaktwbEhUY2JoUHdRc2xTMWQ1L1NL?=
 =?utf-8?B?aGZhL3NJSTc1UEJLSFFLcy9CL1ZGdTVsYlpUS1NUTk9JUE9hZmM3Y3NzTUo1?=
 =?utf-8?B?NE5YT3NKYURQSEJmZVBSYVMrTHRFNjUza1JKNWdrZSsxanJ4OWg2TVQ4dUhW?=
 =?utf-8?Q?C90MKQYXVLlN9heO7Fj29g1yM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1a41f3-d2fc-42d8-0898-08dd8640e33e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:39:00.6357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwGiEDQWVfAQHj6kc3B0KpYp6+nPjkjjuQoePiYET3x8BB9ymg7AjCSxqO0UHoj3rIGHGlohe/SLg+ASrhAYvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940
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

From: Alice Guo <alice.guo@nxp.com>

This patch is used to add SCMI clock control permissions to sandbox for
testing.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/sandbox/include/asm/scmi_test.h       |  2 ++
 drivers/firmware/scmi/sandbox-scmi_agent.c | 56 ++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
index 619f8f5098c..b30e536a357 100644
--- a/arch/sandbox/include/asm/scmi_test.h
+++ b/arch/sandbox/include/asm/scmi_test.h
@@ -27,10 +27,12 @@ struct sandbox_scmi_pwd {
  * @id:		Identifier of the clock used in the SCMI protocol
  * @enabled:	Clock state: true if enabled, false if disabled
  * @rate:	Clock rate in Hertz
+ * @perm:	Indicating state/parent/rate permission
  */
 struct sandbox_scmi_clk {
 	bool enabled;
 	ulong rate;
+	u32 perm;
 };
 
 /**
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 19be280ec44..74a87832dcb 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -80,9 +80,9 @@ static struct sandbox_scmi_pwd scmi_pwdom[] = {
 };
 
 static struct sandbox_scmi_clk scmi_clk[] = {
-	{ .rate = 333 },
-	{ .rate = 200 },
-	{ .rate = 1000 },
+	{ .rate = 333, .perm = 0xE0000000 },
+	{ .rate = 200, .perm = 0xE0000000 },
+	{ .rate = 1000, .perm = 0xE0000000 },
 };
 
 static struct sandbox_scmi_reset scmi_reset[] = {
@@ -700,6 +700,21 @@ static int sandbox_scmi_pwd_name_get(struct udevice *dev, struct scmi_msg *msg)
 
 /* Clock Protocol */
 
+static int sandbox_scmi_clock_protocol_version(struct udevice *dev,
+					       struct scmi_msg *msg)
+{
+	struct scmi_protocol_version_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_protocol_version_out *)msg->out_msg;
+	out->version = 0x30000;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
 static int sandbox_scmi_clock_protocol_attribs(struct udevice *dev,
 					       struct scmi_msg *msg)
 {
@@ -740,6 +755,9 @@ static int sandbox_scmi_clock_attribs(struct udevice *dev, struct scmi_msg *msg)
 		if (clk_state->enabled)
 			out->attributes = 1;
 
+		/* Restricted clock */
+		out->attributes |= BIT(1);
+
 		ret = snprintf(out->clock_name, sizeof(out->clock_name),
 			       "clk%u", in->clock_id);
 		assert(ret > 0 && ret < sizeof(out->clock_name));
@@ -837,6 +855,34 @@ static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
 	return 0;
 }
 
+static int sandbox_scmi_clock_permissions_get(struct udevice *dev,
+					      struct scmi_msg *msg)
+{
+	struct scmi_clk_get_permissions_in *in = NULL;
+	struct scmi_clk_get_permissions_out *out = NULL;
+	struct sandbox_scmi_clk *clk_state = NULL;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	in = (struct scmi_clk_get_permissions_in *)msg->in_msg;
+	out = (struct scmi_clk_get_permissions_out *)msg->out_msg;
+
+	clk_state = get_scmi_clk_state(in->clock_id);
+	if (!clk_state) {
+		dev_err(dev, "Unexpected clock ID %u\n", in->clock_id);
+
+		out->status = SCMI_NOT_FOUND;
+	} else {
+		out->permissions = clk_state->perm;
+
+		out->status = SCMI_SUCCESS;
+	}
+
+	return 0;
+}
+
 static int sandbox_scmi_rd_attribs(struct udevice *dev, struct scmi_msg *msg)
 {
 	struct scmi_rd_attr_in *in = NULL;
@@ -1193,6 +1239,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_proto_not_supported(msg);
 
 		switch (msg->message_id) {
+		case SCMI_PROTOCOL_VERSION:
+			return sandbox_scmi_clock_protocol_version(dev, msg);
 		case SCMI_PROTOCOL_ATTRIBUTES:
 			return sandbox_scmi_clock_protocol_attribs(dev, msg);
 		case SCMI_CLOCK_ATTRIBUTES:
@@ -1203,6 +1251,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_scmi_clock_rate_get(dev, msg);
 		case SCMI_CLOCK_CONFIG_SET:
 			return sandbox_scmi_clock_gate(dev, msg);
+		case SCMI_CLOCK_GET_PERMISSIONS:
+			return sandbox_scmi_clock_permissions_get(dev, msg);
 		default:
 			break;
 		}

-- 
2.43.0

