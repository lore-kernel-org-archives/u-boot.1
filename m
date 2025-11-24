Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA80CFD318
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 16:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD00583E62;
	Mon, 24 Nov 2025 17:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="HTHqH734";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2FDA83EA6; Mon, 24 Nov 2025 17:31:50 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E2F383BF1
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 17:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ahu95VvcVMrA5ijI8jjO9w0iic3vGsTHaSz+AbWCn24B8MMPgtkXdLl00f+H0HmXBL6RDaTht2FgUbEBcqPuS2rOTzygp5TaOH8X8oNKuAYsffH/smFxA5eQn9haHzFCSCby3Uppq+bZvSf7WrWwvutT3Rke1lBISc+gn8CwXFt/+5YNkxm+NFvM030gRiLiKbNuTS9AUkPvWFpGV97SSRgNEqLwHjBbo///Drr2/cJOwBxEUdaAk4SZcZyOdKBFSDBF0zVa52vzyhLci8tLcTP/rVw/D+T3R+JfMLcayRHudc1+gua35fX7QSLBZG+2/alLTtlUCg9gVd2htoMpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzdNIJPTF3meBSdYVY7TOZp+6Ydty7Iqi23Z3pL2UxY=;
 b=X9jEGmrq8huSeZrGvOp85BeTSZgTCIvJzadzOc12vvcbcYgRXVYvIHVGSaGgNmigW4VrLH1IglJ1tObrf7vQcYWHbByA9sA2VtOtucWFxlxGMVu2c17EbO5eArbs2ydOOJYLBe3EjyQ8kvvPCUex1ivbL9BITjK2oxX7jBBu0tkGKGniDvQH7hrsJej7OhpYkeVX/qPxbvJFO99k8rbcFiFz8ZGcinDJPt3Qwef4tgmsGnZM3aCCGjGAye2lZoXYn3rCrKEPDgrBFb4Ej4PmGFyW3klXesNYAHTKuxylblrVETrdbI9yJWyiqHqy3uEAV+8aH6QZBO/Qu25WpjMafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzdNIJPTF3meBSdYVY7TOZp+6Ydty7Iqi23Z3pL2UxY=;
 b=HTHqH734IOJsoAiClB/3ReZl4Pb8m76k4T3MYLlQ0wdyhSVXJPUfpKZM5pXqv+QkieoF33ljopKe8I1UC9kIwTBEt1kPUEhbTQOO2aSHA6yUnptp68foFlhx6VZhWP0bQ5+ygD7FK6lBV+JxLWbhqcXVYsWd9FObn0SMByVMsik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 16:31:44 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 16:31:43 +0000
Message-ID: <5bfefc10-b58f-4235-83ee-209237c4a2e2@cherry.de>
Date: Mon, 24 Nov 2025 17:31:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: phy: micrel_ksz90x1: disable asymmetric pause
 for KSZ9031
To: Max Merchel <Max.Merchel@ew.tq-group.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
References: <20251121081810.73852-1-Max.Merchel@ew.tq-group.com>
 <20251121081810.73852-2-Max.Merchel@ew.tq-group.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251121081810.73852-2-Max.Merchel@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0022.eurprd05.prod.outlook.com
 (2603:10a6:803:1::35) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAXPR04MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 179de576-ca93-42bb-6c25-08de2b76f441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTVKU0hpeFhuRldlTTRnN2dJTDZnU3JsbkwySWxWTDY4amtJTGVtWEtuS1Np?=
 =?utf-8?B?S3psSDM1cWFhTzNaNTRTQ1RHZ1hLR0E0dEd3L3pnYjNabWk5b2FmdWU0YUdy?=
 =?utf-8?B?TDRrdkxNUmVjKytFaFdMTktZdkZCVUE5OWRkTjNzODFjeU4vMlRJaFp2ZFl5?=
 =?utf-8?B?RGdoa25kMUpmb0JmMUJuMmNDeEtKaXBMMTU3RTJhR1NxTXFRWjB6bjFZNDF6?=
 =?utf-8?B?VVVSNktPV3JPeCtnMkhSY01uQTluL04vRExqTW11UkxnbHZZOW9Xb2NHTXMv?=
 =?utf-8?B?UFBLNWljb2grTlplSEFJZGtyaENWQlZ1c3llcnNiZUZqTzNqZ3lsdHJHcjZG?=
 =?utf-8?B?RjFHMVBBNWJmeFVNc2taMEpuc3QyNHhISEowcGhyd29QT3RxYThURGtwVmdO?=
 =?utf-8?B?eWhUM2Y2aHJWVytZU0NvSHl5VmxyVVVKOFg4SU14OEdYejM1K3FTT3V2ckhq?=
 =?utf-8?B?MVJzR0h6U3RaTDkxL0J3d0F1a0ovYUNkVnB5ZlVWeUhsTEMxcHVlS0RQa0No?=
 =?utf-8?B?NHYyZFJtYzBMYklzY0V3Mi9aMFFFQTRnbTdtZ3Nrdk9DY1lpYTQzMzRGMnRK?=
 =?utf-8?B?OXF4dHcwUFJhTWQ3dmNyWDJjWjVCbnRmMjFMRUEwZmhMZWZ3b2pMalpCWDdZ?=
 =?utf-8?B?WWFyemtRWFlJM0J0ZFN1WXc2c20wZjJqTGhrSldZbjN2bjhoVExMYmtPQW5Q?=
 =?utf-8?B?WEM0NWtITlV5NHpNTDJscHZVa1VDWkdWU1hmRmNtd3doWGYraFcwdXgrL0ZU?=
 =?utf-8?B?ZCtDNUJDenhWcHZJMXM0bzJ4YjI3NWVFejQ2cFdpbThCOHVjOVpXY2hLRERC?=
 =?utf-8?B?a2ZuSnNBRy8wZWNxVWl1V0RlZmlVYTUxaUVuMndzcFBuREk0b1BuMWlPVzNJ?=
 =?utf-8?B?WFdJUG85NndoQVJqaG9hcVVncHJYZUt3MmIwd3ZZOTRjR1o1SWsrK3JwWU1z?=
 =?utf-8?B?WXFHWjI3ZXEzcnFYanJJcDdXMTNkMkk1MnBDc3pUUVFpYmFrNm5TcGNDcFF5?=
 =?utf-8?B?N3lJaU9ZQXdhSkRNdm1LR2lPK0VFMWhyeVhpRnUvSWVsRzQ5QWQ5QXpUWmt0?=
 =?utf-8?B?SWxVTzdFWFFNWmxhRmRDQVlDVFhrMHRkbWV0OUdQcGJ1V1dEWUdvZVIrckd4?=
 =?utf-8?B?REtDeGd6MVk0Rmd5d0VuR0V3WVE5cXZHWWZKcXRmQzJFQk5PU2pidHB6N1Bo?=
 =?utf-8?B?RFFKd0Z3OVUrdmJUZkJUdWRTR0p2VmsvUWZKTENNbTgyS1lNVU1NVXd5aG9v?=
 =?utf-8?B?WUxDZmRhN0NjNnJ2aHA5VFRIRkh6VUt3S3crTEhIWENCZ05VNkdwMXl6dFZr?=
 =?utf-8?B?RXVlRmd6eE1BWFQxREVlbEhGZlIyV1BlQisyMG5QcFFhVEVNNlZzZWlBVmpS?=
 =?utf-8?B?eHhzNTYvc3p5cDNzOU5vOHpZWUEyZ1RQdjlqTTVnTjdOMUs4YnFiSGFYN0lv?=
 =?utf-8?B?QjhRRVNRc0hHRFNlcEpVWVlFYXZENnluNExDb3FmMEFVR001VXQya0thR2lX?=
 =?utf-8?B?T0Rkdzc3WDlWMVZGWkpSZTBrekJDYUNSRVVSRHdDSUk2R0x1NW1FcGw5QTYw?=
 =?utf-8?B?U2w1UkpDYWpVdjRuQkI1WklzLzhaTzc0TkZyL0x6aTd0ZFQ4NVhWSUZGU2hP?=
 =?utf-8?B?WEpzU2ZCdzRtWjV3VGs3N3dPN2JsMnE4UXJzUVNQd1d3Vm13YnBaY0hKOTdh?=
 =?utf-8?B?Tzl2bEVQbFM4M29VS3J0VFpBbVptYW1RSGwwRko1WUcvaWRNK2NOSHdtOUtK?=
 =?utf-8?B?dFdBY25BZ1ExZ0R6bTMrZ1pwUEI3eEZWQ0RObTlIdjdzNWdNVjNUa3llQS95?=
 =?utf-8?B?aFJCTFhxaGpFYzBaeVN1aitkL0V3MElhK0c1emE5UUZSakxxOGwwYTYwTGJR?=
 =?utf-8?B?UjM3R3FDdnFKcjBmbjhwVTROZ0lNbzhpU0c5TkxPVThkeXFBNlZsUUpQUUp4?=
 =?utf-8?Q?isdVUPi/ExFAMMpnUBvC13Ub3a58rjAk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0NkcXljMi9IcHJQK2R5REhOVzVrTm9INTJoNm1ML3NOSzY4eG1TeHJaejg2?=
 =?utf-8?B?eW14R0JrcEVaa1VIZUp3MENTWDNNem1PVHFLcXBkL1lYUVNQc3Y2WkxqZWxq?=
 =?utf-8?B?Rm1WUUF4WWRKQnBhU3RIeWJWMTBNU2NSdFFKNEovTDR1RjhhdXVSY1gwNEQz?=
 =?utf-8?B?MGNHbE5GanJZRDd4QkNRdkVraGZtOExOZG5VZDRTdVN2bjRRd0QzbVJyVzRo?=
 =?utf-8?B?V2NhZXo4Q3B6VmhtdldzMWZDMHlKU2QxYXJRVnEyclZsM2lrS0IxcEgxOVF3?=
 =?utf-8?B?bTJVQXBjaTJwMVZENVQzVCtxR0huR3UrM05yRGpIeExhcjZuSHJVSUF4MWp3?=
 =?utf-8?B?ZVp2UGhnZG1JSmdWV0h6WVY2VTBsNEFVUmVQcmhTWk1jaFZrK0tsSjM0ZkE3?=
 =?utf-8?B?RVdPYzNrdEhZSnNkOWYrM3pyam1ta1Y1Z3dRNG0yYUMrSjM3cXhKdEdQRG1P?=
 =?utf-8?B?K29HS2w5VFl0OFBFUXVnUDhUQUl0dzVpbWhuZWd2MGNKdWw2aGZxRDZYU21X?=
 =?utf-8?B?QTZmZ1dZTmJmY0tTVUczTktPajR0NTJRZmRGUk1NYTRMNTZvbHZGL2tCWktv?=
 =?utf-8?B?SWY5cU5QNVBVWFlET2VBRTROYlBtQ2c2Q1lqenRXbWQ5Y0ZNKzM5VlAyQWwz?=
 =?utf-8?B?d3FQS2tRRm5ndnRPTm9KNUdQUkJtQldNa0JGZ1MvL2MwVmVVc3dRRFFQdE90?=
 =?utf-8?B?YWVTV0RaRVgycWh6cFY2MTFGcGhDUDJKc0k5S2l4ek9uR2FiSmlFbmxQRzdT?=
 =?utf-8?B?VUgvM3p6T2xNOVoxL01tdk5BWFZYMEpKL1dCbFpXcGpQSWFWM0M0TkFZWkNE?=
 =?utf-8?B?T1RiR0FKYXcwbTN3MDQ1amJFaFJEeGJXVjkxZXBHTkVSRGppci9nQ1RXMzQ1?=
 =?utf-8?B?elB6RW5yMzBiR2l3YzdqQ1JXdWI4eGxlLzFCZmFmSFdYUFNmZXRkZmNQUUFt?=
 =?utf-8?B?Z3VxWmgwWkpVSFVZb2oxWExvRmJRTDBkcFRJVllZdlYxd1dLZ2RPRk1SekNi?=
 =?utf-8?B?aEhVL3dnd2U3Y0VRcHg4a2NLSndFY1VxUzN3TVY3cW5SQW5weU80UWFmMmpu?=
 =?utf-8?B?UGdTMFFjSWJ6SSsyY29VTERzTld6UUo1WnBXMEZYeXJUSHpueFlRbDM3QWZ3?=
 =?utf-8?B?UElUYVlrL1FwcDVPNloxVjEwTjZ5cHpzWGRMbWJHeVgrY2gwTWN2RGtQVzVX?=
 =?utf-8?B?MlB6Rzl3N3hMMFhlYVhJbTIvUFZQbVYzeDRKeWFJUnphRFFQeURLR3hmVFE4?=
 =?utf-8?B?dGRJYkpqaC85d0k5QStGMm9CeTlmaks4UkVuaWJSZmpETEJKaGIydTY3NDJ3?=
 =?utf-8?B?emZRZE44N3RUZFdMV1hDOG9iVDhLSnA0UnBhYnlPWmswTitOb0RmVUx2eENo?=
 =?utf-8?B?Wk9yM1BzaisvUXhJTGtteEQvSFF5SHVxRjg4SUgwNjhHVGFzdENqcVhRYnNo?=
 =?utf-8?B?MjhyMy9MNU4wTUFrbk83elh3d3BXendTUHpxeEZ6UDd4UmhMSEE1ZW4zeUNV?=
 =?utf-8?B?N2lETEszaXkxeEdLMUdDcGp1UHY1VDR2TVFwbzRXcVVJbkNNbHQ2ekpMZ2dR?=
 =?utf-8?B?a0h5a1djeDYvR0owQUJBeVo5aC9IR3lwSkFvRXgvR3l6eWVPNmZ5aDNQR1lO?=
 =?utf-8?B?ekluT1lVRmtwbTNSOWZQTVJrb1BhSDIvNlRqSkduWkRLVXpnK2V6MGlaNnh2?=
 =?utf-8?B?WTlnL3lOdFI4R1FJeUFSNStsOWpWbjVzOC9VVlpLSmtpejRPcEFlZVlUTHBY?=
 =?utf-8?B?NGpQbldsR2M3bkc0MWp3dTFIQk5SNkdoNGdRbWlpdU9zem9QNkxZZGpXdHJG?=
 =?utf-8?B?RkJZbERYWllXa3RnVGlBVGhOVFZkcEZsNHNyL3ZHN3VKZGlDL2lESXM0T1VE?=
 =?utf-8?B?YU0yMXkyaThTWTV1R1pVRS9oMG5hSFRXc25kVnhxVktueUt2VFd4OHZHK0hM?=
 =?utf-8?B?YzBSV2JBRFhDaEY0eTJJbHJrdHRRbjFEZ3RBZkxidzZPNXZqK2Yxc1R3TDVv?=
 =?utf-8?B?WHpLV0o3VFRuNFhma0pzSUxVTWJ3OFZMejIrSy94YmJyMkJJY0F2dDNwS0lL?=
 =?utf-8?B?QkRRUnRqaEF4dTZQZXRiZ2NkZzFOeE0vcGNVY3FWaGVpL1QrR0Q2dnBmZ0Q5?=
 =?utf-8?B?Z2lOaDVuRHZPdHJmWlZEMmVueCtCbnRYQVhidE1NdFlTbXM3TjBGYzU4K1RT?=
 =?utf-8?Q?081rvW3Mhgk5/JCego60X8g=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 179de576-ca93-42bb-6c25-08de2b76f441
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 16:31:43.8215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpnUkLxW+VrSSF6CEj0yw2QmoaN0L9I70s4DEZynssjoEgqMrc9wGpmdXCyduC1bFr2sdX73WRK0XhA5tFzfpGUHc/RZFRb7vYdMzkbIIFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154
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

Hi Max, Markus,

On 11/21/25 9:18 AM, Max Merchel wrote:
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> 
> Disable the support due to chip errata and call genphy_config_aneg
> instead of genphy_config. For a complete describtion look at the
> errata sheets: DS80000691D or DS80000692D.
> 

Linux counterpart seems to be 3aed3e2a143c ("net: phy: micrel: add Asym 
Pause workaround"). It does seem to set an additional bit 
(ADVERTISE_PAUSE_CAP in U-Boot) but the explanation doesn't seem to 
apply to U-Boot.

Though another interesting commit is in the Linux tree as well, 
407d8098cb1a ("net: phy: micrel: add Asym Pause workaround for 
KSZ9021"). I assume we need a similar fix in ksz9021_config()?

> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
> ---
>   drivers/net/phy/micrel_ksz90x1.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
> index a02dbe900b8..bc42506c65e 100644
> --- a/drivers/net/phy/micrel_ksz90x1.c
> +++ b/drivers/net/phy/micrel_ksz90x1.c
> @@ -336,6 +336,7 @@ static int ksz9031_phy_extwrite(struct phy_device *phydev, int addr,
>   
>   static int ksz9031_config(struct phy_device *phydev)
>   {
> +	unsigned int features = phydev->drv->features;

It's a u32 member, so we can simply use a u32 for the local variable.

This will be overshadowed by unsigned features in the if block, just 
remove the overshadowing variable and features = phydev->drv->features; 
in the if block since you'll already have set it.

>   	int ret;
>   
>   	ret = ksz9031_of_config(phydev);
> @@ -371,7 +372,22 @@ static int ksz9031_config(struct phy_device *phydev)
>   		return 0;
>   	}
>   
> -	return genphy_config(phydev);
> +	/* Silicon Errata Sheet (DS80000691D or DS80000692D):
> +	 * Whenever the device's Asymmetric Pause capability is set to 1,
> +	 * link-up may fail after a link-up to link-down transition.
> +	 *
> +	 * Workaround:
> +	 * Do not enable the Asymmetric Pause capability bit.
> +	 */
> +	features &= ~ADVERTISE_PAUSE_ASYM;
> +	/* update feature support and forward to advertised features */
> +	phydev->supported = features;
> +	phydev->advertising = phydev->supported;
> +
> +	/* genphy_restart_aneg called from genphy_config_aneg */
> +	return genphy_config_aneg(phydev);
> +
> +	return 0;

Don't need the return 0 here as it won't be reached.

Is this errata only applicable if 1000BASE-T is supported? I couldn't 
find that in the doc but maybe I misread. In which case, we need the 
exact same logic in the if (env_get("disable_giga")) section I think?

Cheers,
Quentin
