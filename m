Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5058DE64AB3
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 14:39:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F071C89662;
	Tue,  3 Dec 2024 15:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TUNAhF2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0222B89677; Tue,  3 Dec 2024 15:38:12 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D777789682
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXQHw88oSIp4nN8/btB46f4V20pOpToBLCLVKCJ/mm1qsZwDL5LVBnZcOLk7jW9u5vHCjFV+UJW1ugS2kZwhDQHONsweFGLAeeetXz6NruCCIGJnyFp+9RpqgOdXSWk/BGu6HkqAtSDNsmJUcm5UjvqVcASg+1xC0LQAjRkOqNxtuDo/U6opmE3CHNqSyCvgYgzhirCUh/U/K3LHESPOOBENmPG9zBxiG1/uFFvvh+sR6jLxZrT5txxMxqaRwgDNtSiDlMN1dU52kU8CtriRz/JAO+t3zRR/r5uozG3SBCLUccEBD6Z+tjQSEpwkK9I6nWClrQiTmG0sbI5e5s0pFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1QaH4qwwCy60Db0ueRA8cid/AfG/0AJ3Pfngvh5si4=;
 b=Cyz7PLlX6DENUXdpVPzapCND+rJymJzg03GmTLwU4D509rsJxAUJ76nkTAFJhyjwcUkC2HJYBNLhMbS/kRemCS4BAPPdxvUvAw6wGCxAvt/TSl6NNgXwVF+KdLWBpoEuuTN2cf9zWJ6Z1lMnh/FDfWRv7NRn9IY83dz4ofzuhrB9YFBeO96ox6wiqk7gGDlM0SIJqJ0KM8ZUEtJA2JsxxtVRsZ4xnIalJzl9Ql7xUHLeCl9zFic0VOHlqZ+KhrLCZSNclWdYBk7d8kPNE/c6bFI5Q57LcAIAnSJU6cKrwgNuo+XWmLQUHpJJp6oZJ9oiONthqt2yTcFbIKtzzvubhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1QaH4qwwCy60Db0ueRA8cid/AfG/0AJ3Pfngvh5si4=;
 b=TUNAhF2lBnLg4DdK4Tc9e83GrWC/Nd1m9i4zo07n1Pe4V8HBcYfT7FLt4/P0zSK7OfUoMEoCmoRq5GiVQuvLCveAYKI3H2Iw9PaEadQDEPE5FbyctQM6NMJizl0B57qCr4WVHGXwCBzGg3AfPdaxokrnbOB9pSuwbq0uZCj7XkvWDMqDXH6/qiYhy+bEuy0PRQ+xLHXZ4QC6IKyINwb41U5e35wMSL+t/HQSZvbhGvwG7P3BmbSs3ju+WukKrXHOp5eO8qdr7EpZcYOJZvzAYPCNkGhV6dqiUR1y+yO+Ct+kjLaTjpTnIQ1Wcsmc3AFNZomnxupcxiK5lRGaYb0lCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8741.eurprd04.prod.outlook.com (2603:10a6:10:2df::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 14:38:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:38:04 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Dec 2024 23:42:51 +0800
Subject: [PATCH 08/11] ddr: imx: Add new rates for i.MX91
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-imx91-v1-8-48d2eaa4519e@nxp.com>
References: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
In-Reply-To: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: JH0PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5a::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ecddf6e-7591-411e-8c09-08dd13a8187f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cld3ZGdNUlpaQ3hMZ0dvNktxd01QQ3lyc1ZaUERlV3JSVDJMbjVXY1doSTY2?=
 =?utf-8?B?aWUxRElaQk4zOU5uZ3lJekU5elNCQVVwUWIydWxUck1Pc0daK25xUk1Yejh1?=
 =?utf-8?B?VGw0L2dxUFUzeEtXZ0l1ZWZ3MFNGWTdkQTV6TkhwYVY5U3k5TlBtODd6U3kw?=
 =?utf-8?B?K1BNOW1JMi9KeG9GZXhDazJ4dW84TzhlRGhLVENKTFJMWW1iY1FGWjZKeDcx?=
 =?utf-8?B?ZVpUa2xURTJvdm80eGRSSEFGWGRWV3U1UnZWQjNVWVdKWk1aU285eFRTdnI4?=
 =?utf-8?B?T3ZsWnpFSkJ5TEZyNkdScTVUd3JRQjBiR0VuOG1nWmFMMTJHZm9zRzJzVmpj?=
 =?utf-8?B?aGxSQU44a0xFdlFoTGE1bmd1WWdneWM4U1hsTmEwN2JPZ0lDYVhiZ01yWS9B?=
 =?utf-8?B?aXRva1g4N25nNXlQaDlUcDUyR2wwS2VNbHlRY3Rtb2tuRFk0YStkNXdwMHUw?=
 =?utf-8?B?OStsVnBXY0ZtTFdwbi9UekFsRis4SktNMWpXTVhXSE9SclU2QTYrTGxVelZ1?=
 =?utf-8?B?d0pPYmhqYlJrRTZYM0lvQjNJVUVxbGYxaE1TdWNzTGw2L2ZoS1hoZWRCajNt?=
 =?utf-8?B?U1BpcytJNTVwWmFKeFdoL3NwT0xWN2NiUHZTQ3M3WVAvTlp3RTFpSnhpcnJw?=
 =?utf-8?B?ZkFadjJyNjUwMUx0UFVKaDNpdjIxUnRqanlHN2FEeEZVblVXLzJMR1JsUWll?=
 =?utf-8?B?dldhWHg2WEZXOE1obkZRbU5iMGs4SnczTEhISnp3TVpKR0VRQzZrQ05ldlg0?=
 =?utf-8?B?a1lmendZZ1p0WllIV1RzaWZnT254dk1lWG1SL0VzeTlNV1NjN0FqTmdVYnFP?=
 =?utf-8?B?aFEzYVFOSVNwWTZPSVMzMUY1d29SVTBDRXB0Ump3WmFvRm5IeHBnMjdDUjV3?=
 =?utf-8?B?S1ErVGN6UlZac243RGhFVjdHbUV2SFZlbDFpU2FjTlNHYytYWDRKU1ZOdjJB?=
 =?utf-8?B?d0ZzOUM3NXZWb3F4OUNlZCtLREdNQytid0g3REEvbDg1TGxaV3lNSHJ4MldD?=
 =?utf-8?B?eFNqc2N2T0VsYkMyeVNqU3hML2VpMGFQUU5mVTZtclN4a29RZTQ4eElrUDZm?=
 =?utf-8?B?cGVJNFVuN2MyK2VWRm5URXJNeEtWTjB3Rm10eENuN3A2UG5keFQxZm5JUWJ1?=
 =?utf-8?B?NkxyTVFhL285TzJMdXZmR3Y4ZTVIK3kvOWFkVGJmZjVSQUZQTkltb2FDbVZp?=
 =?utf-8?B?elduWjZIUnlBdUZHK014V1Nyc2pLdnBJT1ZzYUJLUVpoempqR0VhT2YvSm9U?=
 =?utf-8?B?QUVyYW5NYWNJaUFXU0xpNDcweEJRaTJ4SXlKb0M3c0o3ZlR0Ukx6TXBIczBG?=
 =?utf-8?B?UGRIdmJhS2NpMFpzUXIzMlJmRTF1VkdJVng0VW5EakdVNlgzQVpLUWhMc2RC?=
 =?utf-8?B?Um9pK1RzbE5DbHYwMldlbEVjNzhCSTVlNzduaTJRblNoRkdvbjZySm9qYURr?=
 =?utf-8?B?UGQzbjBVa01mVzBHTDJlTzdjYmdNOEYzU1JhNlYwWmtFSmFjbjhTbkFRRGJP?=
 =?utf-8?B?UW9DOTNHbjFETExiY3BxbU9UbkFkYkRtWmRNdnZUaDhJOW9UY0hVbzNSWHdH?=
 =?utf-8?B?L1JTMXRSR2R4TGpPSUo5ay92SldhYUxyYVJYY1V3VFF5SlBIRS8xYU1vYjdP?=
 =?utf-8?B?aWMxWjVGTVZORHp3NGhZYjVNMjhycU5kdmFXbUVDaDJiT1Q0UEJZcExJWVI1?=
 =?utf-8?B?WFJhRHJ0cjVhd2JDMmoyWUtoTTg2QlhqdmJkYVptSzd5TUhTM3ZId1VXRXh2?=
 =?utf-8?B?MEU5Y2dRKzlSL1pZUy9WaXpZa0RBMlBxVjU5NS9mU0JKNm9YSkhtVERoZ3A5?=
 =?utf-8?B?RDcwUitrTjFPTU9OYklTcFd3aHVaOWwxMWR0NTBrZ0FVaHNuWEMwZ1JoZ2FK?=
 =?utf-8?B?cXpvemFyb3I4N2d4Tng5SlIvOGV4STFTTEtjOTZsa3JSZ1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEE4QldMRFRvZEo2dkdJdUlHeGlYRWZWZjlPU3IwKzg1c1c1ZjhjNUJYMXBj?=
 =?utf-8?B?ZktFU1JaN3lBcUNzbktidTBTZzQ5VldJV1R5VW55QUp5ZWhuSE5WeWs3cGdz?=
 =?utf-8?B?RjNEWWVFQ0ZLakZ5KzFTUXF0THVKditFNU13VDhzLzQyMU9ZTUpEWjhUeVho?=
 =?utf-8?B?YW5jMDZvMVd6ZGxGQmlXQ1Nsbm5vc3ZuVk9HNGlYbFNmekR5ZUVndWliTCtS?=
 =?utf-8?B?dnMrM01vdEt6ZFM4ZWNRQ3pTSVZlVDVUUlBHRUJsb2g5eCtlcTBzbWxIQXZq?=
 =?utf-8?B?Rmh6WVorUSt3ZVpsbm9YTVpvT3hlbDZMU1Q2ZjJCa3B6TXRFWVlqRlpmQkY4?=
 =?utf-8?B?U3hLOUVNd1MxWmVZSTJucEc4ZTk3NWJTdjQxRUJYVFJOaXF3MS82K0JIQmdp?=
 =?utf-8?B?Z3NYcld0cVovRFFaNWpxdjdMVWU5citJdG8vTHg4NjVLenM2cTRDRVBxZ0Nv?=
 =?utf-8?B?enhYanJIbFFkZnZqWHc0VmpSOWZ6QW9QZHBtVlE5ZnNCZ1ZBN3BmdWcrTHhX?=
 =?utf-8?B?N3B1aVlnclRibW1YK1VhYVd2QkFkbFM5UTR2TGREeXJnd1h2ZjFXSmJkNzlt?=
 =?utf-8?B?NzNrNVZtNDZJL0luVHRUM1ZBdjJ0bjU2Y29lSUtxc2lURzkvb2Nxa1RreUo4?=
 =?utf-8?B?SFJKN3d2NDBxMzlhS0FZUmRXLzBUOVZiV3l6OUhQMzRMZm5QUWNiMkppdGNR?=
 =?utf-8?B?QnVPUTFvY040VDlackNBWFNWYTdhajBSaVdCRGd2ODFzaDB0STliZGNrcjE1?=
 =?utf-8?B?Y05wRHBJeEpKNzE1MGFoZE02ckxsN2wzVWU3dW9HWE5WU25MK21qU0tSaEZx?=
 =?utf-8?B?QzZNb1JqUEw1VXNoZnU5TGJLK09IeEZMMUZTRXI1QTFmVnBZcUovZEVBOUZJ?=
 =?utf-8?B?c09vRGFkak1XaDdhSlgwRkhYdlpVd3EyUnhqeDloZkFUVlFkS1RTa2M1N0ov?=
 =?utf-8?B?YjFBV2FwbTNNbDRCd3MxL0Y2OHJjRFF5SHFEbzVtOWR4U2c2OEoySFJIUnF3?=
 =?utf-8?B?ODdYNU9Ob1RwWTZROXJXTkFoRnFkVFV3M1J5ZUVvaGJzaC84bmE3bmVhWGNV?=
 =?utf-8?B?RUhmbll3R210MmJhMzFnc1dTT2dUUmt1L0dtVmhQblphYmt0enVhTGJSWDZF?=
 =?utf-8?B?UjIrZnRHVFp3ZkRmQUxSQTA1bVEzOVJFYUVaYzdTTjBrU085aWxkcmxEK1Qz?=
 =?utf-8?B?TnlKSjNhYlFiVmxwbmN1WTlUTFdqQkJEaVpOb0hkK09xanFPS2k0R3U4ZEor?=
 =?utf-8?B?RU9WT3IvRGp5OFRRdGFsZjhkdk5GaWRhRXB4UENTRFJ0N3g2ZTlBZUJZUTly?=
 =?utf-8?B?YU1oN1QyQWg5Uk9QcEdoZ29EVjlJVkpORU53VzBERXlsVmxHVWNjSktXMjlX?=
 =?utf-8?B?dXlBSW9Da3ZKOCtPNC9UZFhaYUpJampCVkdHZVNSR053UExwUVZsTmpyZFlG?=
 =?utf-8?B?QlcrdTJhY0VuZFd1QzhRVElHdzRVTmVTRm85RXpJOG9KYk1KMXllY25wbTRQ?=
 =?utf-8?B?ZXplaVBSbXNQdDlPU3c2WlBLZkdDNGJsaC8rMUtGaGd4NXB3SGx2UVFtbnh3?=
 =?utf-8?B?SGVvVHEySTZNWDR0S1haWkZwaHVQUFlBMXFReG9vUmIyTTgrZ2FoUFFDR1Y2?=
 =?utf-8?B?MG9yNTRZRmpkVjVrYjdDUVR2RldQZkIvZE44dmppdFB4TDcydmIvZzFjZnBZ?=
 =?utf-8?B?VEQzKzNwVGhRVEJwUldyVGtJYzI3SEhwWlNtRmd1L21rSUlqOCtYZEVDSUJv?=
 =?utf-8?B?Y1pnUXdjNXlaVVZGNW9handoVlk5ZDNxMTdDRVpnZXhwUXhyUUtxMUZGWCsy?=
 =?utf-8?B?Y0Z1TTdsQlVoSGs2NGIrei9GcmJBUElFbnpQNisvem5ETlVuNE9ZR0tEWHhN?=
 =?utf-8?B?aURRcVRqTFVOU2p0WlAzTE8rTUdidFZ0K0xSeGN4cSt1THBydFlLdVg1N3lk?=
 =?utf-8?B?cG9pWTRHbzBYUk5VUmdpRm1lcHhyUmtMZk1nbjhidmV4OG9YeDBPd0RSd2Vq?=
 =?utf-8?B?RzBJS0crckxrZVBtbVY1bGJ3clVmKzN4RTJVaU1CVHZoU0w1L09rREpzejlG?=
 =?utf-8?B?bCtadzdJMUxKQU45bnRWNVFnOG9qQVYvMWtXVDJya2ZzYldad1pGaWlxOTRr?=
 =?utf-8?Q?UDMh6oLHAihU8ABx+6Wq6z8Nu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecddf6e-7591-411e-8c09-08dd13a8187f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:38:04.4319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4Oil+RxL2crv0q2vPvruQYnSfFkouA1zm7aRkFsE9dJQZqiQCUc+t6KUSL43LjN6ao7MCmZ4oGjLwWotMK8rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8741
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

From: Ye Li <ye.li@nxp.com>

iMX91 reuses iMX93 controller and PHY, but with lower speed,
so add new DDR rates for i.MX91.

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/ddr/imx/phy/ddrphy_utils.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ddr/imx/phy/ddrphy_utils.c b/drivers/ddr/imx/phy/ddrphy_utils.c
index 14278f5ad8fce74156c03161e139975f9aa749d1..8e350de8315e40372f583c7a84c3ee5ed8b827d9 100644
--- a/drivers/ddr/imx/phy/ddrphy_utils.c
+++ b/drivers/ddr/imx/phy/ddrphy_utils.c
@@ -144,6 +144,10 @@ void ddrphy_init_set_dfi_clk(unsigned int drate)
 		dram_pll_init(MHZ(400));
 		dram_disable_bypass();
 		break;
+	case 1200:
+		dram_pll_init(MHZ(300));
+		dram_disable_bypass();
+		break;
 	case 1066:
 		dram_pll_init(MHZ(266));
 		dram_disable_bypass();
@@ -152,6 +156,10 @@ void ddrphy_init_set_dfi_clk(unsigned int drate)
 		dram_pll_init(MHZ(233));
 		dram_disable_bypass();
 		break;
+	case 800:
+		dram_pll_init(MHZ(200));
+		dram_disable_bypass();
+		break;
 	case 667:
 		dram_pll_init(MHZ(167));
 		dram_disable_bypass();

-- 
2.35.3

