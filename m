Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8193EC87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 02:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA52682F8E;
	Mon, 28 Jul 2025 04:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YqYyjsYz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B3B68315B; Mon, 28 Jul 2025 04:14:59 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0187582F14
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 04:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYcEUuiG1ai415pziyWlh+vsIcrxX5QpmExMe1mzgcJPkcBVlhIITaRIeSZEW3Mlp/yiA9l7zSNktn5HaYXbMtRyyxFNMr8DksG/gfdLWVI9zFUGTLmX52gr91c5ypMNx3WcBdI6AOGBSWDf1noiuAvqyCtz93+aIpNNPwj+6XnFuglsSKDcmo07gRNkh1uvsAy7I6jLCI0YeAGikbAWJpUNdCgkubveXxfU4TffHCeZ+c3A9eYuT7wPud8e1oOYu9rzQfjqKGVXmSxmxi29adR8IZ7mp2QCH/pA3KOjYsz0fr9gHcQCuNIhrmlG3lqVFJhcWHKDWJzINhLZxY0g0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTvRV17M/EjPjc8BmXmdF1GfwAbDdducKdTWr+p5+B0=;
 b=pb+8DGiAsGL4ao3JTJoIKmXcrrzyhuSBnmqEu1PYA8B5oT0eucAau5P3cLeXh5F4nH7tkhBqzBkhLEq1HWbUN0ANlfRuHakXQD7skleG4v3X27CQdfMThhXECarM4lW9oEeI95cM5cu62AKNawBly0fZfGnIS7WDvlJbGN5eTxhNMBB9zo2rEWE/nVjF/x0EoIJfxdOTAgtw8SU8J9MKuNODqgtl+IlFrfEms7ORX3/ycIvNF++wjoafjLUOrkVIEduXchUnQAasyWOPjI+aLG7o5fbzV6ppQrnYkdBy1j5gKfeqpzU3ulmXt4WWqo4jXy1bBDcjgFCVoa5k2Ll4kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTvRV17M/EjPjc8BmXmdF1GfwAbDdducKdTWr+p5+B0=;
 b=YqYyjsYzF4VFL6n4WL2K3cY//cK6hnwvNbYkpqc6xPu3Oafe0/KRln1nr6Yg2TRfQnfR9flYrl/+NLfC+RPJ5qp2yYOIMLFS2l9VNheJWQieOmekRb5QfIPqgOg1UFT2az6rwRhiS0fUMU3NChazOEXKQ7lbL+nwAJHKjFvMNXo2rx8DvkLY0LMIE/1iDFbPcZnxhsg+d2+GSfxSFOq/fDzjmPWa6UCwunQe8EPDan4yr2utnBkBnXkNzWsRFy2mAKZ6lNRGyihcJNItZq4SZzU1OHyScGa07y/Cadl7hpAKm4o13eoJW1S6uMHeF5nosb2PKukL8m7kJwDKDWi50g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8546.eurprd04.prod.outlook.com (2603:10a6:20b:421::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 02:14:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 02:14:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 28 Jul 2025 11:24:55 +0800
Subject: [PATCH 9/9] ddr: imx9: Add errata registers support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-ddr-imx-v1-9-73da75bb33d3@nxp.com>
References: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
In-Reply-To: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Viorel Suman <viorel.suman@nxp.com>, Tom Zheng <haidong.zheng@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Florin Pavelescu <florin.pavelescu@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3e67ee-58e2-4c99-5027-08ddcd7c8b5f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmVsVlJZRXBZSmRMcUF5b1JvdkVoejdtWGJ1MTBCYkpFblFYK2Z1dDBtM0p1?=
 =?utf-8?B?K2hyRXg0azFSOUkzSXBXeGF4dXFyTGJPWm9yVElmcTBoV05qclpYTTZ3QlhC?=
 =?utf-8?B?ZXg2ZGZiT0E5dXJmazFsWFBXdWZPNVBGNEM5TXZjMzRRUkJSVmxJWStGY280?=
 =?utf-8?B?VWdvcjc1OGlpUkxHYnVkbVNOdytvRWkwTXlJRUhpS0ZUcHgwNXBkWlJYcTAr?=
 =?utf-8?B?YzJXVDVmVnRyRTRHNkV2b3hMdStZRFVRSkdka2lhNi8zcXF2WExYRnJLbVJz?=
 =?utf-8?B?bXdTODJaQ1lVZTdnUzFvNVB6QjN4RWZLaUdGS1dFVnp1d25PcXVIOGliQVNZ?=
 =?utf-8?B?cko2SHdpQlFTcnd0VGVVMEFsSkpuRnhFRWt6YWxrSmhpVU8xWDJvWDduU2ND?=
 =?utf-8?B?VXJuMWhtbTRSOUJMb1ZtSWpEYkVNMTgvTkxyRGF3TzFsMm9KREQ0Y0g0VDcz?=
 =?utf-8?B?ZUlvMnRxU3BJSnRVVjMzTlFLRGtQZy95SE52SnE1L01jRko4dzFUTlJWOHMz?=
 =?utf-8?B?U3c2OGRqUGtac21jaDVTLzlIOFhvZW0wWnlnNy9uZXRLSTJ6Zkw2ekVoMnpl?=
 =?utf-8?B?alF5U1k4K3hsYTNYUzV1OVBXNlM2UzluNGcxdk4xTk9hOGJwOUNyM2x1NU1M?=
 =?utf-8?B?RHdnWGsxd3dQc2s5UkZFdnZRRFk1ZHZud2FDY2pqNlBHR1hQR0F0UGlOWVJn?=
 =?utf-8?B?Z2NFUUd0L3JtOG9FRzRPMzlzL2FQaTVIdnlSc3NtbXJ4cUNranI3MlQzMTNj?=
 =?utf-8?B?WitaYkRXQ3pRUzdhUGlST0tncHJlc3IyanBVTjZMMElWT2xCQjlkZkJYWkEv?=
 =?utf-8?B?Y2N2MWMzcmNmcGJtYTFnV2wvMWRxOHFUSUZxN3phS3ViclUzbUp3dVJPTjlZ?=
 =?utf-8?B?em1RWVBiQTk2UGluY05KTzQ0bnZaYjhJZHlpMm5tZzJFajRUTitNYVpGZ1pG?=
 =?utf-8?B?T1FjcDVzdWJrZTNyK3J4L1ZtT09IWTJGZnUydDdHNzVTZ3FVbjRMTU9BQkE1?=
 =?utf-8?B?VVpoM3BXM1F5dU5yY1Q3aWRjZEcxcnRUZnNjMjJZcjFNa2VWWC9vSlZYV1Bx?=
 =?utf-8?B?U0YvWDl1Vm1KbzM0Wkd6dmZSSmZzSG1jdkZEZXFIdTFlODE2N2YyeXNxNis1?=
 =?utf-8?B?NkRKTWZPTE9uNWdabWdxUXRaMXBNdnZuWndaY2pCZ0ZsTndLbjdHc2gveWNy?=
 =?utf-8?B?cFdkTEdBWTlrZmZicU5rRGtrSnE1c3lqRlZqaFdIZUhGTWVKMUhpNitMeGQ2?=
 =?utf-8?B?ZXR6WlA0TThpaWlNZDE1Uko3endlclB6K1F1S1paMzVjVERMYVlONnFUSzBv?=
 =?utf-8?B?ZWU2aWxYMnZqUTI3b1UwT2dDcHJmVm0veitONDg5dnJLUEhIVWw1YlBRKzNS?=
 =?utf-8?B?Snk5QUZEL2gwZS9ldHdnYU1ZTWM2eVJHdDZ6S3cxcDYyR08wK09scERqc3FS?=
 =?utf-8?B?aEp4TncwSGN3VFd0eDBRZ3pZMXJ3VFRDc093NndyR1hPeUJ2OHZHVEJLWnh5?=
 =?utf-8?B?YzNZMmd2MmF3VGFQaU1ZOXlXdHMzeGgxYXN3WTlLSjF4UDc4SjNNR0ticTU3?=
 =?utf-8?B?S2J5UC9ISkhsTUliVFhhODkrR3lSTHZSdW9WSU55clZ0V2RpQ25iVCtSbm52?=
 =?utf-8?B?MmpjaXREY0xibzJld0o3T2FoMG5rdTNjK0pSU0JBcDlzSFl1U0Q5aHI0b1I0?=
 =?utf-8?B?RFM0Q2drRkZPT3NpZFFvdjJIZmx5WTlZU1c3MStBcExkRVBSRVBmaGdQZ1Zt?=
 =?utf-8?B?QlcyUHJWQlBQUGVxcVRreER6Z29pN251ZmRSMUJVMnBseGZQYUJzQ2YySDh2?=
 =?utf-8?B?T2dYOUpXam9EV0RnRzBkaEJ0Y3RrT1NlU0dUaS9RVkRBUnBPUlQ4YTlBeGh5?=
 =?utf-8?B?WG9haXZzS3Z2a1FnempFSjVZZ25TeCtJb2VjY0FSYU1TME4rTFdNd3p3V1BO?=
 =?utf-8?B?bHkvVGlDMFNUM1V4c1IxbVh6cEdMZnlwS0krdWplMm5wdWUzaEg1aGZzSzRT?=
 =?utf-8?B?OTlkb2lBdmh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFRzVDhmM1RxdEVkMDNKaGhHcDRheFFyOVdhQmVVQTRzazI2QjV6Smg0MnRj?=
 =?utf-8?B?ZjRsQlNJWTdkcVVzakJ1bDVRZ1o1Qlcrc1pwNHpJSjU5QnNvOGpWWFdEMm1l?=
 =?utf-8?B?OVVjcER6M0NSWVpvcjZ1dnoyWWYrbzhUQzZSNTZINC9RSkxQVUxrVnlxdmZW?=
 =?utf-8?B?b1dsVUpudmIwOUdqMzU3cGFpaHVwWFU2eEI4TFYza21MVUdud0J0MXh1bVhu?=
 =?utf-8?B?YytZM3Z2cWRtT3F1MnZKRUNFYWNVWG1jNXpTcWErSTlEU09hb1ZkRUtLNkJO?=
 =?utf-8?B?dTluRWdqeEd1QU1xVDVodWFyUFlIdGdrK0dzZGFIcFQ3R05lbERmenhjeHY2?=
 =?utf-8?B?Wjg5N0dUNnAycG9WT1RyMXQzaUNPY3A2cnYrSlYrRUprdmptZy9vUkpWem5s?=
 =?utf-8?B?Vi9jbGdIaWN1dWtHVDZzV2ZSVFYyOU1PYVlzTkNHWFpzODM4Y2NrNjRqeVVz?=
 =?utf-8?B?MjZQVjVGRlB0cEMxR2FNTTJLNW1TWUlkZXliRXdNc2FMcUJvZEcwblB4eCt1?=
 =?utf-8?B?MTlHM1R0c0RxY1BGSmY0OWwrb29VNnB0VXIyd0c5MkQra1ZJOVU0N3k2aFhQ?=
 =?utf-8?B?cUhFeUxwOXpRT2ppOFZFLzZhZGVXd0hUZHdxOGR6c1cwOEJDSlNHK3VyZDVI?=
 =?utf-8?B?azBNWTE0c1FML3hZR0w3Ui8zSUh3dEpHd0FUb2UxUUNhWldEbVVCRk9QemFD?=
 =?utf-8?B?cDU1SnluWkMweTZjMWs3amJkbjZvYWZvWDZnQUg1QjFHYmwvbys4ZzRIMUFF?=
 =?utf-8?B?Nmc1YnBjRnpmVGZqZjBieGVmRFdxdmZYTXZBLzJUYjlqVjRVSWNqalRKa3g3?=
 =?utf-8?B?aXRwVnNiNUxEUUtIT1ZwSHFKWGRhdUdWK2JIRUtiWFVmSThoK3JsdjFYV1o5?=
 =?utf-8?B?OWI5MHQ0ZjF6Y0ZHdzZzVGFDcEpoT2ZUbDZWTEZCenBpZ3V6dmlDS1lkSTNK?=
 =?utf-8?B?YmdVZ3djM1gwaEoxZENrVGdmZnk4YWxDeHNBaFI5RG5pdEx4eGFLV2N4VVFW?=
 =?utf-8?B?djZwMFV6VzB0K2RQelcwclpzRmZjRm5zcklWOEtvVTlJWUpjTktsZ1pzOWFm?=
 =?utf-8?B?akplak53QXp4UnhVVlhIUXJYeWM4MXNRTXA1NERCbW1nUDNSYmc0V2QwbEZS?=
 =?utf-8?B?RjN3cEJqL3NLbEJwK1RrZ3llbXp4bHRFS2EwZ2pydHkvRVZWNjA4SFNRRmQv?=
 =?utf-8?B?dHVUUnpxN3d2MFBXbmFaQ09IWWVZTlJXc3kyMndybm5SU205NWtXSzU5VFlx?=
 =?utf-8?B?WklQMi84Y296bXF1QXJJYVUwNVJZOVE2T3BhaXBzakFjSXQrWjBtR29GNjZ1?=
 =?utf-8?B?SXZDUUpMVTl1SWptekxRQnlyNW93V0pkTzF3S0NJWVNZblNCeDNDbWVRMUpN?=
 =?utf-8?B?M2hBMWplU1ByWUhua0VnLzEvUXJwK2RtTkVtV1N4azZyRnQ3Wndsa01YYk1Q?=
 =?utf-8?B?b0JPTGNIWE1uQm9nMUpOYktkNnpXNmhKVnEvTEsxUE5aMnVEc0ZCTER6NzFL?=
 =?utf-8?B?Q3M4bnhlMm40OXIralhTcitRelpET214cXZOaVQyaGlzNm9pY0szK3NGbzJ6?=
 =?utf-8?B?aUhxeGFsUDRHQytUbFVSaldNazRiZ1VVbEdqaXRuYmFMcjVGVlpoa0pmQ2Zl?=
 =?utf-8?B?OXVnVE0rUHZBUDh5Z1ZTMkNlWDNHd3poRlJBaW5NTjUzQk5RbDY3VDNVMlZx?=
 =?utf-8?B?YldlWnFqR1BHUkR0NDhCZGJuQXQxQlRUNk8wRmptN3R5RzNhTUtjcGh5R2I0?=
 =?utf-8?B?NUtWWXFsc1VieXo1MitnZS9CbGFjY2xTd3JtaGVMUUx4NVNsVUp3QVBmY1BV?=
 =?utf-8?B?NU53Y055bmw5bTRRMERrTGdUZWdrSUl6bDhFTHBJdHB1RVp4YTR1NjdpMnBZ?=
 =?utf-8?B?czNwOFBrKzUzdU9lK0grOUp5YmVoUDZLNXBOVE5UaW1yYXZjSVNpa3NNbjEx?=
 =?utf-8?B?dE1jaWJpUkNoSit4dTBLaGZIN2JQOVF6NUdjdmhYUEZQa0FQVE1IaGhLQk9Q?=
 =?utf-8?B?WHdXc295V2UzSDMyaHNZcUxZL1NDeXZVZGlLYVJROVFBampYQTA2VUJyck1M?=
 =?utf-8?B?SzJoZzhZRVR6dnZCVGoxRi9tblFiMjlIUjM0WDVtbi9qeGRNNzVMWVVMSkxU?=
 =?utf-8?Q?SGD4Lq4WJITeNV8Zv63gdaiWI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3e67ee-58e2-4c99-5027-08ddcd7c8b5f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 02:14:55.6205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fu3HBX1bq6Dou1pe2bw92JkpIGJ0tcPO+HjxsrT0lppkHvFZxuBFGZ/VnH9B2gLulHGBLbsLAtbD7QPSqTHm+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8546
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

From: Viorel Suman <viorel.suman@nxp.com>

Collect errata registers values after the training and restore errata
registers values before starting quick boot firmware.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Reviewed-by: Tom Zheng <haidong.zheng@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Tested-by: Florin Pavelescu <florin.pavelescu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/ddr.h   |  5 ++++-
 drivers/ddr/imx/phy/Makefile           |  4 ++--
 drivers/ddr/imx/phy/ddrphy_qb.c        |  4 ++++
 drivers/ddr/imx/phy/ddrphy_qb_errata.c | 39 ++++++++++++++++++++++++++++++++++
 drivers/ddr/imx/phy/ddrphy_qb_gen.c    |  3 +++
 5 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/ddr.h b/arch/arm/include/asm/arch-imx9/ddr.h
index 6e5a3e3b6793d0171c2fbe6415821968ac1d3ba4..e30274035ca620fbcee46932b33374055aba3378 100644
--- a/arch/arm/include/asm/arch-imx9/ddr.h
+++ b/arch/arm/include/asm/arch-imx9/ddr.h
@@ -103,6 +103,7 @@ extern struct dram_timing_info dram_timing;
 
 #if (defined(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN) || defined(CONFIG_IMX_SNPS_DDR_PHY_QB))
 #define DDRPHY_QB_FSP_SIZE	3
+#define DDRPHY_QB_ERR_SIZE	6
 #define DDRPHY_QB_CSR_SIZE	1792
 #define DDRPHY_QB_FLAG_2D	BIT(0)	/* =1 if First boot used 2D training, =0 otherwise */
 
@@ -110,13 +111,15 @@ struct ddrphy_qb_state {
 	u32 crc;
 	u32 flags;
 	u32 fsp[DDRPHY_QB_FSP_SIZE];
+	u32 err[DDRPHY_QB_ERR_SIZE];
 	u32 csr[DDRPHY_QB_CSR_SIZE];
 };
 
 #define DDRPHY_QB_STATE_SIZE \
-	(sizeof(u32) * (1 + DDRPHY_QB_FSP_SIZE + DDRPHY_QB_CSR_SIZE))
+	(sizeof(u32) * (1 + DDRPHY_QB_FSP_SIZE + DDRPHY_QB_ERR_SIZE + DDRPHY_QB_CSR_SIZE))
 
 extern struct ddrphy_qb_state qb_state;
+extern const u32 ddrphy_err_cfg[DDRPHY_QB_ERR_SIZE];
 
 #if defined(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN)
 int ddrphy_qb_save(void);
diff --git a/drivers/ddr/imx/phy/Makefile b/drivers/ddr/imx/phy/Makefile
index 2310e69ab5c3036a2903465f4c4e95a79bf0b2c5..75c11625e8a23152e81700b747b216338af1406b 100644
--- a/drivers/ddr/imx/phy/Makefile
+++ b/drivers/ddr/imx/phy/Makefile
@@ -6,6 +6,6 @@
 
 ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_IMX_SNPS_DDR_PHY) += helper.o ddrphy_utils.o ddrphy_train.o
-obj-$(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN) += ddrphy_qb_gen.o
-obj-$(CONFIG_IMX_SNPS_DDR_PHY_QB) += ddrphy_qb.o
+obj-$(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN) += ddrphy_qb_gen.o ddrphy_qb_errata.o
+obj-$(CONFIG_IMX_SNPS_DDR_PHY_QB) += ddrphy_qb.o ddrphy_qb_errata.o
 endif
diff --git a/drivers/ddr/imx/phy/ddrphy_qb.c b/drivers/ddr/imx/phy/ddrphy_qb.c
index 04a6520be5464ac26e30a516265b1b6993eec38c..2bd34bf91fad46e41b3581d79db3523b5442654e 100644
--- a/drivers/ddr/imx/phy/ddrphy_qb.c
+++ b/drivers/ddr/imx/phy/ddrphy_qb.c
@@ -47,6 +47,10 @@ static int ddrphy_qb_restore(struct dram_timing_info *info, int fsp_id)
 		ddrphy_w(0x5403c, 0x78, qb_state.fsp[2] >> 8);   /* TrainedVREFDQ_B1 -> MR14_B1 */
 	}
 
+	/* restore errata registers */
+	for (i = 0; i < DDRPHY_QB_ERR_SIZE; i++)
+		dwc_ddrphy_apb_wr(ddrphy_err_cfg[i], qb_state.err[i]);
+
 	/* save CSRs to address starting with 0x54800 */
 	for (i = 0, to_addr = 0x54800; i < DDRPHY_QB_CSR_SIZE; i++, to_addr++)
 		dwc_ddrphy_apb_wr(to_addr, qb_state.csr[i]);
diff --git a/drivers/ddr/imx/phy/ddrphy_qb_errata.c b/drivers/ddr/imx/phy/ddrphy_qb_errata.c
new file mode 100644
index 0000000000000000000000000000000000000000..91843ab2d939fc973af35ce07a63b1b375463b92
--- /dev/null
+++ b/drivers/ddr/imx/phy/ddrphy_qb_errata.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/arch/ddr.h>
+#include <linux/types.h>
+
+/** Errata CSRs
+ * STAR_3141216	0x020021 -> in ddrphy_csr_cfg
+ * STAR_3256585	0x02000b -> in ddrphy_csr_cfg
+ *		0x12000b -> in ddrphy_csr_cfg
+ *		0x22000b -> in ddrphy_csr_cfg
+ * STAR_3975199	0x0200c7
+ *		0x0200ca
+ *		0x1200c7
+ *		0x1200ca
+ *		0x2200c7
+ *		0x2200ca
+ * STAR_4101789	0x0200c7 -> covered by STAR_3975199
+ *		0x0200c5 -> in ddrphy_csr_cfg
+ *		0x1200c7 -> covered by STAR_3975199
+ *		0x1200c5 -> in ddrphy_csr_cfg
+ *		0x2200c7 -> covered by STAR_3975199
+ *		0x2200c5 -> in ddrphy_csr_cfg
+ */
+
+/**
+ * All from STAR_3975199, the remaining errata registers
+ * are covered by either ddrphy_csr_cfg or STAR_3975199
+ */
+const u32 ddrphy_err_cfg[DDRPHY_QB_ERR_SIZE] = {
+	0x000200c7,
+	0x000200ca,
+	0x001200c7,
+	0x001200ca,
+	0x002200c7,
+	0x002200ca,
+};
diff --git a/drivers/ddr/imx/phy/ddrphy_qb_gen.c b/drivers/ddr/imx/phy/ddrphy_qb_gen.c
index d77bb8480d85770d29e4408c2a723b20377833f0..981bfa88dc59c69905d14ffc6cfad4a92da35843 100644
--- a/drivers/ddr/imx/phy/ddrphy_qb_gen.c
+++ b/drivers/ddr/imx/phy/ddrphy_qb_gen.c
@@ -1819,6 +1819,9 @@ int ddrphy_qb_save(void)
 	/* enable the ddrphy apb */
 	dwc_ddrphy_apb_wr(0xd0000, 0x0);
 
+	for (i = 0; i < DDRPHY_QB_ERR_SIZE; i++)
+		qb_state.err[i] = dwc_ddrphy_apb_rd(ddrphy_err_cfg[i]);
+
 	for (i = 0; i < DDRPHY_QB_CSR_SIZE; i++)
 		qb_state.csr[i] = dwc_ddrphy_apb_rd(ddrphy_csr_cfg[i]);
 

-- 
2.35.3

