Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0107FE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 03:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27E818035E;
	Sat,  4 Jan 2025 04:20:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eE7UeFMw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40D00804CB; Sat,  4 Jan 2025 04:19:59 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45FC9803C6
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:19:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGDsFYBHwxYRFUsepZH7fRWSUfycIebtX7UlH1A4nhIrF8/AmSfkF9jrs7uJunjIR8vOdD8K1+lFjB66kj1OAO+Gt2+d79QuWCA6g9G1nPvHf3bhiWTjeCJXgvI/OP4SAC1f4MciyE1OHEroD768VrZAiZqflh+6gYfBsClkTFwgRCooDeU7hbzznx050YBPPvT0WOveGQ3iytKjQvBmfoqjeTbX4unMoE7Vf3djUcS3iVpT7Yq9t6Y2fJM4LGvkpJ9cYx6O6vUsAQmwLSxwnFPExXp3aOo5L2E1boCk0//5+TBPX0DFNTuYKipl0Vv62YLDpbPAgtjjcDYEL+m3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjKHbdltrW81DtDjKaV3gkga4jwnM1Qvg75tC97abCg=;
 b=aXJBVNHVWc5/IqJLge4M9t0Lf/mOk8fWbsXFAv3PBK2OM6zs+sio5mNSrL2oyxx0xMhpzmUQ5zj1vLT1u0uxJQZOG5ghooJg1SpMV37S5kyc3N21pPYcuipIes6Vcbi5wSHIZKEo99pHmGD7izNTrE9HUYNR3DEaRMOc2+Yw+lj+tIBEIsz+MNAn9iJzqw6+BV0n6DCfQpZsOUFzxtqMhXLENkcVNYq6k0cvClaG78tD6PezN9LwIeqt+RKT0DUxAcIkrFUoX2oKlwuriAe/R4d4yPwwegPrnOH8/gQ/mTxfgZNwDdB9GZPyHegGauu3tKMeUwwjh3yPCRjtZzjSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjKHbdltrW81DtDjKaV3gkga4jwnM1Qvg75tC97abCg=;
 b=eE7UeFMwRMzELCNlKwXI5lGsO/0Nj+rnpIf41lgXQHUaxGYjmFevnaF1kt0D+Jikfwli/3bN0MBGfqeTR0C2eNjRYKgnwWQ1+ZtZeVqL10aSXPpaCv5Daa/5q20iIN4mU4s2HOP6xH58lBuAJfVbI/XUyDmsaV3UHPyj+Emf7YoDcaUl07S0pEOPhHpVw30imB2ez8ON6ykxk4Qk/6ZziFCzmg6IdGGH+dtIrjVxwQBn6zCf4iPOkPtJCq+7i7gGCWhRIvUXm0EkmPi0zr/4GpkO89YuDH7RWgg7yAvhib/aKhOBEG5UvS7R415DIPKe0+IDB8OkpvlUap1HCN1x/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Sat, 4 Jan
 2025 03:19:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 03:19:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 Jan 2025 12:25:42 +0800
Subject: [PATCH 08/12] imx: imx8mm_evk: Enable dynamic settings to mmcdev
 and mmcroot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-imx-bootstd-v1-8-e09618cc1d65@nxp.com>
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
In-Reply-To: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0cd0df-37a2-4efe-5901-08dd2c6ea722
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEdKeU9hb0NTVyt3cElmZE0zL25kVFl3TVFRRE5DMlhiTythdjFwWjJOcll5?=
 =?utf-8?B?cnZsQmtIYm5ucE1saURvUVBqc1pxNzdySVJEZy96ak4zdjk1QTRxYTQxdlFl?=
 =?utf-8?B?Y1IxeWVDMmttaWFpQnRiZG1HRWN1QmxWN3ArbzdCQVZvV3BhUkk1dnMzTy9k?=
 =?utf-8?B?Qks5di9MTGY1dldneXBiRjFEbDVXemlIbFVhSmFFQ0t2dFVUaGdGbDRHZVFN?=
 =?utf-8?B?VU9GeWk4RE4wR3Y5Q0UyUlRPUUFBbWpHTVlzNjJBTW1HSUpMYUppdzc0akF3?=
 =?utf-8?B?bUM5TENWUDl4ZHMwa1dILytDZlR4MVVYY01zWHFmQ1hCTkZDTDhVQjVFU0Fi?=
 =?utf-8?B?RTZTeTN5QWYzWVdzdXBMY0ZTUEhsT2RKOTF4REpXYmN0a0JJM0Nsb1kvTlBK?=
 =?utf-8?B?YkZNSk1KaE1kb3E5K0JlYXFwRFh3UHIyOVh5c2Y4eHN3RVBsc2lkUnF5Yi9B?=
 =?utf-8?B?WU1zU2t0VTVXWFBMSzhUVjlKajVOSHVONTcvRzhLUUZaQnNSbHlmc3N6bjJO?=
 =?utf-8?B?SHVETHQ4cVNybGdtOVVhSkt3YXYyMnIxNkdNSHdzQWhSeU5NUjloMUQ4Wmly?=
 =?utf-8?B?OEYydExqTHJ2aGFkbnFZOHZMZjl3NGsyL2FDUjJtejQ3VjJaaU80L0syZkwz?=
 =?utf-8?B?MU5rRkh3bHJqU3NVOGxUalRleXBOWjdZTHUzTkc1enFkNzZkWmlqOFRFbFYv?=
 =?utf-8?B?Mkw3aUwvZkpXbmZubVZucllHZWc3dmhITU51T01BVU1QSmlmMWN0eWJhNS9U?=
 =?utf-8?B?MGdCd294WG9DaGZRWEFHOVNnOExXcFg3SjIyQmdVY251Sk5sN25YNDgwWEFF?=
 =?utf-8?B?RGdhenhHYXI2YisyN0NyOTFvdUg1enVJUHU2aXVZUU1KR2NkRzB6MTJBT2No?=
 =?utf-8?B?OUZZVit6dWJiVEN2aDYranA3ZjEwQURpTmZMZGdGYkFGWG5xaTJkR2Fjdlky?=
 =?utf-8?B?M2hFZnZiVUthVWx2ZFRzbFMrZzZ3N04rUkpMRnZkazVqdzVCWWFlVUd5aWti?=
 =?utf-8?B?aHdkZ3ZNL0t6ZW1Fc1hLb0dOQWc2SnVkaVhCMG9kTHJrR003SE5nenhXSWJK?=
 =?utf-8?B?bGhEL0J3dW1Pa1RKc0FGdHJHMkx6dW85T1RDNmJtV2V4cmkyZTdVTHZITlQz?=
 =?utf-8?B?Mm1EMWFiYjFhdDR5Y0Q5c1lvbWcvaHVaREJlMlQxZTlLV3Y1SGwxcmdFMy94?=
 =?utf-8?B?TEtrTHdQTjczOXovUzRNN2NubWkrM2RZYnFSRWxYUllkS3dKRHJDY2h4ZVVE?=
 =?utf-8?B?bXJOT0szRVlZd3J3UEZ5aWNYU3ZuMks3M2JqVlZFWHQwbmpEY3ZDbFF3SHQw?=
 =?utf-8?B?UG54UTMrckhLYXYrbTQ2aVcwVUJyWXl4azgyQ2RuWUFsMTQveWRmQUlSYkdu?=
 =?utf-8?B?NnYvQWV3VDJWeG1ES1lBVkZQZmg2RkY1SGh2WVBLdm1CVlh6T3ZLRllKeXNq?=
 =?utf-8?B?L1hlU0g5SUFBMmlKcnBNTGZXNUY4NWlLTHNTS01MQ2JSLzFGOE8zY3h3YTRH?=
 =?utf-8?B?U0JqZE1QZ0xCVHV5RnZObmNaY0pROXNVdTlZY01SY25RR2t3WVE3RlFLM29r?=
 =?utf-8?B?cXZTNTJiTnZzOEJiaS9YcTVmb0dsN250THp3aTZLcCtEdXE4WUxibDBxbGEw?=
 =?utf-8?B?a0pQalJQRFlHR0s2djQ3V2FRNURzWFdhUEhaa0FneXlSa0QrQXZpK0lvaVZ5?=
 =?utf-8?B?T2t5Tk9LeWhaazY0SFo0OWhQSjhPMjZ6a0JPZExuS0RvZVluK2tRMjQyNEM1?=
 =?utf-8?B?OWxVdFBSUXlCemVLME9RajNuRG5BSTg0UVhjQ0dVRGRWR3ByU2dUdW8rS3Yv?=
 =?utf-8?B?M3RMSWNybCt1aHNGZ1F6T3A4VmIzb3ZDMldtbi9OM0hrWW1OQ0xjdTJNTTRM?=
 =?utf-8?B?aTRyUnBhWWtOOFZvRDJTS3MwRzBVMlRNL0VOeEthbDR6Q2JLVGJpbjcvbmty?=
 =?utf-8?Q?P1cM1MEjjME5eosfy0PiWltP2TXPMTGj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ly9wWmM5Wm1VdmRJdlBMWmJQcXhjcVE4bkFlRjdMNTlzTXNla3dMZURBVis0?=
 =?utf-8?B?eTUrSkMyVUFEcDUxZWxlbkZiaStmTXJKTVFlWERkRUdmVTJKSlNmZGVYSi9D?=
 =?utf-8?B?NzV6SUt2K3RzejdJUW56QW1qY0ZnVnU3b1N5NzdmNER0K3U1WEY2MzcvWi9E?=
 =?utf-8?B?Z0dkcEFxa1VKQ1A1T1ErcmhRYkltNG56K1pjL3BQRnhWRUNWT3R3QmgwSUpp?=
 =?utf-8?B?dGtBaGorQ2NjZ3ZxR3NzWm1LR1hROVQ5SlVlOHZTSDBsZjg3YUlNdkg1YS9v?=
 =?utf-8?B?MzNIY2ZSMWZwMmpuM3c1d0ZtbGVlVnBmUGp4dWdtTEZKZ3duUnpXNWt1aXVo?=
 =?utf-8?B?Wkp0a2ZNR08yM241Y0VkK3lneXpvbHVFdDdYL0hnelFxKzRlZXc1Zi9OT2Nm?=
 =?utf-8?B?UndreU9tSjJqYkhMMGFHVjRVNStIa01WZHBRYm9WOGNtNERpRXRVUlFPQnRB?=
 =?utf-8?B?dmVNb1I0bnJ3VWtJRFV1R29wOHc0dmtMY0dTc1EwbEF3VDBMbGhuNXJqYm9k?=
 =?utf-8?B?RjE2Qjg3NHVTVHNkR0o1N3g2VmVlZEhqZVRqbnJmT3A4dEVpUmZCaHY4Z0hU?=
 =?utf-8?B?N2drVXM3RVZ3b0lDYjN2YTVOZXphL0VpVGpwM0IvcWtHS1hESVd4RUZkTnBw?=
 =?utf-8?B?TDdGa0FHaUQ2b3l5VmRoZzA4b1hkaFhvUmx4aVRyQ1QrM3F3OFZmQ1FtOTRm?=
 =?utf-8?B?MTNTVU5tdVpkNjE2dC9WbnkzTTVwT0gvZlVpajRSKzh0ZGFvRmdEamNwdStZ?=
 =?utf-8?B?bnppT0pWVkJSSlpFK2kvMmJ4TkNraHBRL2E4aVJEZ3JGZDBYK2lVSUVYYVBQ?=
 =?utf-8?B?WTZJRUphb0RUSGs0ZXZITGNTMTQxeFlGOUpSckU3cGtVdVJjTEJpV0VCWm43?=
 =?utf-8?B?UVRuY0FuOTBicVY0YklBS0lvSG51eUJKWFlnd3Ewd2w2enFrQ0R3L0Q5OUV6?=
 =?utf-8?B?d3gwZytsZ3VMUTZ5QUx5dllGdS96TmNxcE1GVHAwYVRXR1J2bHA2SGFhaGZh?=
 =?utf-8?B?aWpqVllUMkhaaVN3T3NMUHNSbVYvekVsQUhGSnU2bEFZZFFEWW1TeGNTQTVN?=
 =?utf-8?B?ejdtblBwcFBNL0pDR0R4TzBFNnN5MnJnaFpKK1ZGK0lEdVV3REN4SHFCTmhU?=
 =?utf-8?B?V0tCMm5DWEc0U3h1Uno2TW53ak1sa3JXN0h0dWV4MUVxUU8yZXU1Y05ZMTFu?=
 =?utf-8?B?SGVmYW5TWmhKemtIT2ZTeFdkeGpqSHFDZElmTHBaZ2htVDZSZndMem1pajlY?=
 =?utf-8?B?cFFoRmcyQVA1RUNwYXNmZlJrVXhWc2FjcGVJOWNkMVdxL0c5WURVNkVVQmFx?=
 =?utf-8?B?UHFWRHhzU3JPazFJQ1NhUFZKSlZpMGlBUDF0aVhYamVXdktSLzM0Zll6WTBn?=
 =?utf-8?B?N2FkZk94UkY5TnIrS3o1TlY3RjNXdE5zcDNUMjBtUmsxVmppZjJmWG51RFh4?=
 =?utf-8?B?aG5sZkdrU0hkUkF1K3lyUGlVUnRmOW9JLzhxTkJ2eUw4UE1xemRuekJZcnlp?=
 =?utf-8?B?TCtIQXlETWs1ZlJQeGJmWUxHZGJ0ZklERzB3dU9vSTBkNXVUTEZ5dSs3QlN0?=
 =?utf-8?B?ZXpya1pTWGgzRCtTY0J3aU9xKzVUT2lJYU1aTWtORHR5ZlZNRmd4VWxJb1k5?=
 =?utf-8?B?ckh5endBdEVvRDR1K1I3UkVIMjVOSGZTVUtYTGtjRkF5QjZ3bzFUaHMwNWtB?=
 =?utf-8?B?aHZkaEJWOTMxRm9aYzNXU1k3SHZCb0huaTdZMVBOeWo0NG83M044aTNQQmc4?=
 =?utf-8?B?bkR6UlFtS0pSRWlZNzF5TncyZHhiSElseFhxRzJlV1pjTlp2TVpjYnZxa3Ro?=
 =?utf-8?B?ZGhtWmJyQTNLaUszUzVLbnRaMFdaanRoc0JpRVA4OTRVWnZUN0NHWFNxQUpM?=
 =?utf-8?B?OFRscng0a3Z6djAwR1dST3lNZjVQV29rRW5VZlRsK3dYakxHWENwY2ppc1c0?=
 =?utf-8?B?L1UyUzMwbDFla01vVS84cG9ZRExnTDJBdGpka2ttMUtRMXBBNTRJYVRlTnAy?=
 =?utf-8?B?bS9XYVpybjI2Ri8zMHM1MENvWWZCcEZabGxmR3l3cWg0azcrQnpxK1dueGRy?=
 =?utf-8?B?b1l6WE9lSHFIVkl4VjVLTzNRbXRuUk5nMFZ5MUVNS1ZlSjhMU0RyZzhXNmU0?=
 =?utf-8?Q?qBl/F8X21SXZyUx9tU6vzsBLx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0cd0df-37a2-4efe-5901-08dd2c6ea722
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 03:19:51.9409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1Gc6hskYlhnIe/FGa0Eo4H5ppUmQlSm1C1VQKTtTLIITjDNzL1gtO+X2bDpAPxQGOaENgHfxPaSh66O0CpBYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9566
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

From: Peng Fan <peng.fan@nxp.com>

Enable dynamic settings to mmcdev and mmcroot for i.MX8MM-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mm_evk/imx8mm_evk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/freescale/imx8mm_evk/imx8mm_evk.c b/board/freescale/imx8mm_evk/imx8mm_evk.c
index 4c4436af3b1dd7e796e48458488d2df4e60c182a..d41db8d31d81b44b86a7aab5fa57d97d99e41a05 100644
--- a/board/freescale/imx8mm_evk/imx8mm_evk.c
+++ b/board/freescale/imx8mm_evk/imx8mm_evk.c
@@ -59,6 +59,9 @@ int board_mmc_get_env_dev(int devno)
 
 int board_late_init(void)
 {
+	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+		board_late_mmc_env_init();
+
 	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)) {
 		env_set("board_name", "EVK");
 		env_set("board_rev", "iMX8MM");

-- 
2.35.3

