Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EB6CA0EFA
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 14:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29BFF830A0;
	Tue, 26 Aug 2025 16:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="4sSSJzq5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3A1D83102; Tue, 26 Aug 2025 16:33:47 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42D71828A2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 16:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lF/Nr+/n6tPg15UXMrRhlbhaXURZfBiPBeEQpN0NJUaVjO2thqeCdpkZu7Yb3tGY+wblS1AYVuD8aibMB/WRCE9CzfLzC9ZA2lKq448th96537JvXkI8PAxcPNBqGzHsSjR50x9+eoBczFG4DoNIsUrTDq3IXSWzy1Aok0j6Zec37CnRVyxGDT6N1YosLjLTWpnFJINBCqjgvn7WxEuESWOtDoBlEExLtt7c5eSsir7haQs7K1mc2bJUnaDgFDe3WCuwhd43B7bh54tVSb4+KHTRRjvlU2B1p6ONATx8g5qBKD95ntAg36pHRlaBJLPQAnNhNJJtwHh1QXp+lPOoPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7PN+v2LjpQVh4o1R2DTbSjs84kjnlzCe9B93xtbjOQ=;
 b=w2PukFDMgkpRXfcRus1Lqjb+1nxye7dSJMnDUh59xg1Fc7dmZ3x4gLsIpmGfGtkb6Iuk+Y+47aRnPUGjrSg0ISh8uvudLgyHyry0FWzyEFQpHY4R5mq2VXuZZ89xeiWPoiTAiOZLvK2jgkdFTu5WiPMGAJbRJBenwy+G2bW3cgN+XImJ0pUnpML7Rkke8E6wQjv36mh8rhqmrsG4Z4Pf5Hi4s9TdLbAdIdrPlXt8kK4ySQvAgvGQlINBLlCLXpGOix4lfKBDefLbMpePLpjh8mVrgC7hcNphajj/mSLakSAYsyYiqvtwN8SG/UdLIE4tE2WiO9+1ARRO6CFLGo8+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7PN+v2LjpQVh4o1R2DTbSjs84kjnlzCe9B93xtbjOQ=;
 b=4sSSJzq5XORILOjtWdGq7XOz3tM5JesS9puxiRS7R7x4b6D6pXddc166fEtg+M/24kSyhtjv78AymehLar1+OL2M6zyGNrKlcJSGhCUl8JGNegG3cy/ShXIAkff2ADwQE/uVNsz8HcxXQVlLUtM6Exgq1LeshRa0zGb1hccSdbkuKRCqUuZXoUJWV8nnpnmjFFXYYVie1pCvIysqYUH6cXisSFMO6iCf7xDEbzAHRrHgktde3T6hXHqNAZIbZUKFs2TCU/Wzix3Qf8+Ebl5vKvaP4k9VW28BtOvkRnmVP+nnqdiBYPsXP2dZokom/GiCEPb4+4DiwNxjy9Ajp+WBtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10110.eurprd08.prod.outlook.com (2603:10a6:20b:62e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Tue, 26 Aug
 2025 14:33:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Tue, 26 Aug 2025
 14:33:42 +0000
Message-ID: <621f10e6-5264-4f24-b28a-272050c82e91@iopsys.eu>
Date: Tue, 26 Aug 2025 17:33:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: mtd: fix speed measurement in the speed benchmark
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
References: <20250825234829.155483-1-mikhail.kshevetskiy@iopsys.eu>
 <87h5xu2mcg.fsf@bootlin.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <87h5xu2mcg.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0322.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10110:EE_
X-MS-Office365-Filtering-Correlation-Id: 924ae5ec-a24b-41d5-4da5-08dde4ad8e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bU9HTk5LOCszanlCcTh0WWJ2VFU0R0E0c2dGSFpBTmh0WUR6ekRTU0dDaDNM?=
 =?utf-8?B?KzVTejdkME1SZjZ1d3RZbTBRMHJWemZWZG1VcEQyVVFYREExdG40NTliZE9a?=
 =?utf-8?B?V2tiOTBCcFJJQnA5QndKTmpHMkZsSmxLeldyZnZoeDJmci9TRHpzcU5ad3Zv?=
 =?utf-8?B?RlpYYThHRFFncUQyblhpSy9SQ1BFbmE1THVYTTlaWTBJZ2xEa1R6dXdOU3pu?=
 =?utf-8?B?eUFDM2p0ckFoenRnU2dPcmdoTEgra090bGV1K0NIZXo3dDZRS3hjd2F3c3JD?=
 =?utf-8?B?OEtyK2Z4dHRteDFpUlFjTXNyYWtEOEVTR0dDc05WL1pHSExWaUZwdUovdDVF?=
 =?utf-8?B?NnZzeXcyNHFLODR0NjYvbkVPZGkvZHpBYzk3MXRNT1M4Z0tOZ1d4UFUwMGVJ?=
 =?utf-8?B?UWo1bkJlV3FwTzJzelYzN3hyVjgyb2g2dFBxTVhHTlg5YzJ5dXNuc0ZPK0Ew?=
 =?utf-8?B?bC9IVm5RZDQ3VGZ5ZlVlZkYyd3FTT0JhOUUxZjZUREM1RVA2dTJOUXJtaW81?=
 =?utf-8?B?dWhiOGF3TkFGcVRMYnd2S2lacVdmcHJZUVorM3cvWmV2bGJ6RUg4RFQvWldJ?=
 =?utf-8?B?Mm5yRG1Zdm9nTERESTlGTExtTTVxL3lVQ3NXZ2NyZTV2WmNvLzA4U1lVanFL?=
 =?utf-8?B?NVIzeE1Wc0NHK2lBeUhYRTAxWldaV0JNYTJYcmVvYWIxV1k1cHk0L0tQYXJq?=
 =?utf-8?B?S0U4TXlET21GUW0xK2hyUi9vbVJaTkJ2Nk5ucVZpajN5bEd5MFB5a1JEMFp2?=
 =?utf-8?B?SnJCeWNqZE5GSHk5T1hHbDhyOUpFR1ExeUl0Y2I4MDFNWjdIUFVXOEJFRy9V?=
 =?utf-8?B?TVBwMzk1bDRLV3hrQytNMEVYdENNTUp1STVxUkl1OWdFUUNUczNCWk9lcHVG?=
 =?utf-8?B?YitDMlg3dkRQaUc5M3NXeDBkSmcyZUxrcWNxR2J6SjNFRVd5K1FoaWtGUmJX?=
 =?utf-8?B?SWJuZmhxQU1vdU5sWUIvajRXeFFWeERpTWJ1OTFEckVpdEsyOUJDVm1OTnRP?=
 =?utf-8?B?N2NhdXRBRlVHTXVPWUl2NGgyK2FQUWtqNmR5aUpNWnVPeGdiS21adldacTho?=
 =?utf-8?B?cFFIczFmdm9LcHhHdndKQWFVZW53OVQrZUlLTnNHdFh0Zzh1QUpiclBVM0lO?=
 =?utf-8?B?TXQ2UGlDaWVoREsxVnRMSUhYcFlESUVwM3hoWlNwWGx1YU5vay8xN0d3Wkto?=
 =?utf-8?B?WHc3UGozNDVKeFNERFZvaCtYSUNDbWpsMUZvRzFFMVI5RzV1MkRING1GWmFM?=
 =?utf-8?B?b1VrYm1vaVUyc1paNDJtbTlBNXRPYXdEYU1UMUJCSXNwNzNJbG5CeXhQeGY5?=
 =?utf-8?B?ZS9WeFBIZUwvNWhtWk1PTmFEVzk4NlVmdFNxVnB6a0wxMnZDeERqeUl3Zi9E?=
 =?utf-8?B?cmEvRjkzZ1VHWDRjNFNqRDlJanNsbVV1UTF4dWxuZ3hHMEJvdC9yTGdraWph?=
 =?utf-8?B?T010OU1pQ2ttakRrYVR6T20yWTg5eEJLallhZG5Kck04STdJbi9qT1J6dEtI?=
 =?utf-8?B?V1l5azloVWpjelFTSVc2SWVmK2dhd1FydXdKQkQ4QnAvbjlxMXpnYzZGU01x?=
 =?utf-8?B?dnNmR08waFh3UnYvL05lbGJ0bFI1Mkc1R3E0TmdzbitzWDhaMHQ3MUo1RWpO?=
 =?utf-8?B?M1djVHhSYUowd0dMRGUveENuQk1neitHZnJ2dVROaEM5NTgwMGZMRWlhS1Z2?=
 =?utf-8?B?TlVRZUdWZGtzOGhPOVVNWDZPMVAzTnZXMnNhTkdjVWFBeHFGVEIwZmlIaG9C?=
 =?utf-8?B?eWtta2VndkUxeWFrTFVweGVpcHI3TTF5d2hTRDI3K0tzZzNJTEZtUS9nK1Jl?=
 =?utf-8?B?QjNoeFlFNDJSYTBDcG9XTzkyWXl2cmR5LytKUzF4bkc0Z0NRSjhZR2ErS2NB?=
 =?utf-8?B?QXcxUUd3SGJOM1NiSkVvMG9LVkxUK09mZG1RNjIraE1pQVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXpqMi9TQWRmV2h3QlJnbE5IYm5yYk81T2tEeTE1RDVaMk9XWXVFMlJrc3pN?=
 =?utf-8?B?OWpNb1MrbmljaUJNUEpNZzI5RHRLZDZvM29jbG55RlF0ZHhHQVVkTTJ4bC9p?=
 =?utf-8?B?UnUxNnkyUCs1dUlBRkMzdVBsSzkrRE5JKytTTWF4eTRhVjQraVdjNXdlUEVV?=
 =?utf-8?B?N3d4ZmpmU1BSendDVk5CVk85Z3VQOTBNRDV1VGJyMkFpUUw4Qk8zeDdpL0JT?=
 =?utf-8?B?bXRleldoY1J1TGwzSmlpQ25KaHdrRERwUFFhdDArdVllYXVsRGh6aG55Qnd2?=
 =?utf-8?B?VU95bURaUmE1OWNpeC9ycGxaQ1VNajZsQi9kcmxSWE43RmFEbG1iZytmOHA3?=
 =?utf-8?B?b0VnZURaTUNFdmNyb3JHdDZmRmxoWmpxcGIyQ2RnbU45ZDdUSElWQWhWR3N5?=
 =?utf-8?B?a1JySnlPRVNqUm9KYjFMaHVINW85cklBcUhhZE1QeERXRC96b2Y5RnBuOVlV?=
 =?utf-8?B?eklDUit4L0V6bU1WRlBuV1VnTjR1TUVmSmU5bCt6ZVMySEFDL2dnRTkxbmpU?=
 =?utf-8?B?Z3FVRko5di8xemZZem5peDJiV0RSaFVYWkFnZllSR0lmeExqRVpQd1dtcEN4?=
 =?utf-8?B?YVA0cWI3aStsZ1RkM08zcG5seDNUc1VPcHNTQVdwTWh1VVR4NkZmYnRtZzd3?=
 =?utf-8?B?aGNkVjMrMVdRNUEwK0hiOG5qNVp0YlhjU0c3VFJjTytsZWdDS1dpcEVSRUlr?=
 =?utf-8?B?RnA3Z2t5UTIvVStuRGkvM1dTSXlRWnBjMGlqMlNnSkVrVVZxNEczSWJsTVlT?=
 =?utf-8?B?K2RFQlFpdXN4R0ExSTN3Y2l0NlNkelZjUlBWcjZsWEdlYm1wNFhHdkZWZmRk?=
 =?utf-8?B?U1FqeEZrOU8vRkdBNVVSNmkzdGd0VjlPQ0hORXA4dVRZM3diR0NKSnNpaTFp?=
 =?utf-8?B?c21iSU90MFJyMktNYzMyTTdrOXhtbTJtSjZ3UzlhOTJuU0VXUWhMVlR4VmhJ?=
 =?utf-8?B?a2JSSGljaEFocWt0TzZLMlZDWG9KVkFvOVdxY2tiL1BxMGlQNzFid29uVXlM?=
 =?utf-8?B?aFlMTjRNMlpJYzhzeDJiZUxNUU11VlJTV3ByVktnMHBKYzZkWkVEZ0Z5WUlY?=
 =?utf-8?B?RHEyNnM5TWQrK3NTNS9zdXltRG4xTUwwUklscnVmMVJRemIrYzN6NmRjNzhB?=
 =?utf-8?B?QVV2QVAvcVAwSG9pNGNTbXpQME5Bcll6SFhnTk00M2E3d0hJOWNOT3dRMyth?=
 =?utf-8?B?UGFRMkJmdXhBbVhNRUxoZDJrbnhwb01BYlQ3c2srTmF0M21oWUlTY1FYVGhD?=
 =?utf-8?B?clpXVlBOVEF1aHBzVUNjLzZMeDV5LzRHRlg3RFJnd2Z4L01QcXB1OE5oc0pl?=
 =?utf-8?B?bGw1MzdKNStkb2hhcXJqVWdCditweTVqZTNPREMxWU9NZ09jZFJGN3FYMDkr?=
 =?utf-8?B?SEE1dG41dks0MDZ1SXRxQ1c5RnNxSW56UWdxVnhkbzRFblQ5dktJVFJuZWhi?=
 =?utf-8?B?OEw0OFREVkM1eTFEUURkQ0hvVlFDZzV1SkJFREF2Vkc5cWJxZThUeVpmZnhX?=
 =?utf-8?B?emd3Q2NMVW1YWlY1MUlieEJLekdDMnZ2SDduclBjQnhMYld1Nk9FZlloeVhy?=
 =?utf-8?B?cWcyRm1RV0xwczdaYTVYRnRjbDhCbFB2eVRrK21lZGMxWTdKb1htL01CeXQv?=
 =?utf-8?B?NW9JaXJYcjFzbUNrWTg0WXJSQllCUjhTd0pmNVNXbTVVbFhEOThSU28rYVln?=
 =?utf-8?B?ZmJOVUhLUEMxU29ueVBOekhPWm1MZTZ0cHRCUFpRQkxqVCtGVjdaaFBxMGo0?=
 =?utf-8?B?V2ZrQzRDb3BYaHZHZmR3WTRKWFd1dHZiZ1RoK0Y4RE52RzFDdXdtS054VzIv?=
 =?utf-8?B?bWFMRC9sblZiUkZsV2Zid2kzMkVsaHJIUmZsMEQ2c0ExWHZTWGVrMHNRV1JY?=
 =?utf-8?B?cCt3UEI1TlVhZ2dpK25GOGdNdGttUjcyK0Q3R1Q1b25oVzROOHFpWndsRkwz?=
 =?utf-8?B?T1dqWmNHTEtLSXB1K2pnaUNSS2s0T1pMMFdxc254SFVMNW5oNzNQUWxydEdi?=
 =?utf-8?B?dVhKVzRQRXpTeDJGU0EvV3NlbTFqQyt2dTg1a0xDcUV5Mk9SZEtVK2tvVHR5?=
 =?utf-8?B?Wjl3Z0o1alFIYU10WXdLcGRVTWVHQUM1ZmJOb1JOZ0FGRjQrYmFTajZuTEVF?=
 =?utf-8?B?d0UyYzFFV1ZvM3V0cXlWS0FZUkt2VHBTNnV0cE9sRjY4SUVjc1dnSExoUDEx?=
 =?utf-8?Q?Cg0Jgx6GMeoy3AR5lqb2a3U=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 924ae5ec-a24b-41d5-4da5-08dde4ad8e02
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 14:33:42.1552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THgvJ44esr6qc3tXyHAoo0jgqsWMCo7SEBbykTmD9hewCwLi6pMkV2ZKWGjuhyQhDotriEg9wyQiVwVcHuBb+x6PsyJmOut6G0yrdEYE128=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10110
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


On 26.08.2025 17:23, Miquel Raynal wrote:
> Hello Mikhail,
>
> On 26/08/2025 at 02:48:29 +03, Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> wrote:
>
>> The shown speed inverse linearly depends on size of data.
>> See the output:
>>
>>   spi-nand: spi_nand nand@0: Micron SPI NAND was found.
>>   spi-nand: spi_nand nand@0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
>>   ...
>>   => mtd read.benchmark spi-nand0 $loadaddr 0 0x40000
>>   Reading 262144 byte(s) (128 page(s)) at offset 0x00000000
>>   Read speed: 63kiB/s
>>   => mtd read.benchmark spi-nand0 $loadaddr 0 0x20000
>>   Reading 131072 byte(s) (64 page(s)) at offset 0x00000000
>>   Read speed: 127kiB/s
>>   => mtd read.benchmark spi-nand0 $loadaddr 0 0x10000
>>   Reading 65536 byte(s) (32 page(s)) at offset 0x00000000
>>   Read speed: 254kiB/s
>>
>> In the spi-nand case 'io_op.len' is not the same as 'len',
>> thus we divide a size of the single block on total time.
>> This is wrong, we should divide on the time for a single
>> block.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Happy to see this is useful :-) But you're totally right, it didn't use
> the correct length. Maybe I would rephrase a bit the last two sentences
> to make the commit clearer:
>
> "In the spi-nand case 'io_op.len' is not always the same as 'len', thus
> we are using the wrong amount of data to derive the speed."
>
> However, regarding the diff,
>
>> @@ -594,9 +594,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
>>  
>>  	if (benchmark && bench_start) {
>>  		bench_end = timer_get_us();
>> +		block_time = (bench_end - bench_start) / (len / io_op.len);
>>  		printf("%s speed: %lukiB/s\n",
>>  		       read ? "Read" : "Write",
>> -		       ((io_op.len * 1000000) / (bench_end - bench_start)) / 1024);
>> +		       ((io_op.len * 1000000) / block_time) / 1024);
> Why not just dividing the length by the benchmark time instead of
> reducing and rounding the denominator in the first place, which I
> believe makes the final result less precise?

Do we use 64 bit math? If not we may easily get an overflow.
Actually for 32-bit math it's better use a less precise formula:
(io_op.len * (1000000/1024)) / block_time; thus we will have about 22
bit for length.

>
> Thanks,
> Miquèl
