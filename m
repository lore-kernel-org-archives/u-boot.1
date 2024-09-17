Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEEDC3ABCB
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0880588E26;
	Tue, 17 Sep 2024 04:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tYSRZCAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AD5788DFC; Tue, 17 Sep 2024 04:31:07 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3111F88DFE
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mliWQTls3FtZ/bNKW3hb6HQ6pCdr05O00rCZjeJsQk/acYiD8h7O/HpvDGIKvq6H/D77DQTg3WYzPvamAHvoGi4z+qZ+jrXDr77f3j76ZMwoovUktUNTHeTxR55gBsqX93T7W6cJtk7rrOhJJh7vOdLYozXeRky/tyyahkCnaWo3a7YlIQjbXtxJivClvcMVjaqlHwdl1icf9xWyYURjwr5ztseujICRDG8adgQQxfO4AHNnHJ31nhEvC1QsjLojjgH1DhdOVPe1UnkQIHh1yLZ2ZKpriSuwcGtgj2/m9AtGwpZfB0ru2t60YdD2ol9BsmB8g3L3a67xuNv03T8cGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soZfKGafllz89Ve0TM/cfF+bRidwH5WvN8QJ5mopvUc=;
 b=ZviaASMwvub4rpYOsAf7evZ/UV7EnbR8Pgqe/BuVCEC6SYq9nrg2JShLTxCjHCwrfIz2bHS+QhLYKcS+HVVNxzOYYpBZ/ly3Ic04tQd5LRB/ZKgFF9lC3U+cn59KCPw8+70qVFboarP01AJy+paPuMOaHQRDW92OkEjEZvbnkXS/s/ShIZnVAhWh5a+NuXCERsBEqF847hkDOrv+x1Rt3Z3pZKikxKcHl8b953IKS35kyjRwKzGDcWT5YxXVrCOG/PSHnI8sXHdQTuteuRxsL8jFQsAB3hn8UoyIfXftLLcaVovcE+XZ6vlD/iiBYSRj/Uu5ZYkezwNqeP+h4DAqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soZfKGafllz89Ve0TM/cfF+bRidwH5WvN8QJ5mopvUc=;
 b=tYSRZCASL9r3LU0deKJbqQCrBRyG5UI0llho3wm73OeD4R23hLt4UNd3H5US2Y/Arsa5HNBQWZ1Z6kTt3wrGyD5e+VU6dLmX/ki1YwdW7P2vg5ee3e41tAGdU/faJvNRY057diGqKoZWjsdmzx9qSxFR8JagYR+xDTzlxETQ1EPweYbICmI220kLFnanfO1xmFfrkNmBiN7ljeK48rNGDwpiLwMxUaHPe0pROg1ZcsS7Qw0DBCImSL4e4/1iF1m/T5BeW7WpDudxOVxDetYyYOuPW0jK6S6EmBI+Cf9iX2NC+PWHzzDE0fc4Ou8LoRyBR7dxxb8RGgcavMaf8Shn+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7493.eurprd04.prod.outlook.com (2603:10a6:20b:293::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Tue, 17 Sep
 2024 02:31:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:31:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:34:03 +0800
Subject: [PATCH 11/21] imx8m: soc: Drop disable_pmu_cpu_nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-11-4fe8effc937e@nxp.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: f31a3729-fa0a-4b11-6925-08dcd6c0c5e7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVcrMFNPQXJLZFhuQ29iVUxmK1I0UEJ3cllqZFZIUHpVTW9jdWN5VXZhelR6?=
 =?utf-8?B?RTR2Umxxbzh5blpNRDMyV2tocFYrWjg2SkJwS2JuSW1SSit6dUVGSmJycndR?=
 =?utf-8?B?QXdUY3FjSy9QR1UrMTAzVkx5SmFwZ1BjQ0pWSlhBRW1vMEpKVUZtMTRGSmVl?=
 =?utf-8?B?ZFg4azBnR1hHM0RiZE1kUUt6U3JSaHNaT1BMZVpMTE04a2crQnJoV282OEU4?=
 =?utf-8?B?TEh3MUJzb1lKeHhiK0Z3bXhNcjZCdnlJRUxwaWE2bjI4Nlgyb1ZuRmVlYUpK?=
 =?utf-8?B?TWsvRUpxcmx6MzFBYXk5M2lHcnQ4OURtNmV1RWpPZ3FGb1dlWTVBdEh3Z0tI?=
 =?utf-8?B?MHVETi9DUHdlUUg3TG1VM2Y0My9ZMkVSaDcveklJVFFuZzFWQThLcm1DZXAx?=
 =?utf-8?B?MEZGbkxuOGE3cVRVNkN3RnhqQlJaRWhxQlNuTWVuNVRhWmZJampQb1g0T0tR?=
 =?utf-8?B?N3JrR3NJNTZPczN2NnhuaUhlSFVxU3YzUUU3SWJNU2xlZkcxUUdBa1NNOUpz?=
 =?utf-8?B?aWtGRWV6aHl6TTROS01HYmd5a2h5c0lyYmNBeHdhRkpwYkVsdW9KaWhOSzUy?=
 =?utf-8?B?MlVBZ1FOTFVBakFRYUFNNFhEOEMrQ0JXSDZNU2dUWkVqUlRpelFkWU0xZlc4?=
 =?utf-8?B?U3pFUFRJYjJ4a1doQ1g4bzB1VlNyWXpldnBLN3RFbmVUS0w4ejUzb0drVUJT?=
 =?utf-8?B?c0o0anVEd29KUnpiUEM3RDJjVG5URzZSV0ZhSlJEMUI2ZVJFOHlvN0YvSlhX?=
 =?utf-8?B?bCtkWE9mOE5mS2dmSVdsTjVaejVyeHNjRmljR0NUSEZYNnVGb3RLMDVja3Va?=
 =?utf-8?B?RW9laFlYQUYrVUp2SnlwRC82bDZ3UHBxY0tYVlYvSHhEN2Fpb2szMDltdkxF?=
 =?utf-8?B?bFFvRUFFUGF5V0RwN096bVpzSFdWNFJLV2lhbEZpMVowZ0hqSHV1RytyS2ZZ?=
 =?utf-8?B?VzZxVnpSKzR3V0MxTkYzNWVyd0hYOUNTMisvbEovTnRxY243SlhTd1VITXN2?=
 =?utf-8?B?VFBSZEdObjIyWURqTmwxMjg4cUViWDBPNnBzMW5zSzV6enpaN2dKdzFFaExF?=
 =?utf-8?B?c2xrQWxwd3EzMkpxYmx3U1N5M2Z6bFptd1MxdHc3K21md1FCbGxTUFA2Smo0?=
 =?utf-8?B?cXFvVG15eGFJN3BselVxQW1qaWcxK3ZYOXlHdkIzOWRlRWRQckd6enhJRlVT?=
 =?utf-8?B?amtQVk1pVVZvTDJnQUpmMzloRzF4ZjZTWkthWTVwWlB3NUZQbndCQmlCSTZJ?=
 =?utf-8?B?WjNVSHRLVlpwNkRWTzNSZ0wyR0ZDYndFVitYME5LU2FmZjc3SFBVNitvSTN1?=
 =?utf-8?B?MGNNM1Qxa3JwU3M1ckVkWG5KUjZEUnlUK1VEMHRjVW9WVEVBNTlrMzVQVk5J?=
 =?utf-8?B?T1hYQW1pSUxjNk5rb2Q5QUdHdFNMVEZMU25DNU8rTGUxc3VWd1NjanJLZ015?=
 =?utf-8?B?cVZnejZ0dEZyNHcwK1BlYXpUV3ZFZ2tLUjNCdWtoaFZqQy9YbVd3aEkyQXFs?=
 =?utf-8?B?SFIzSWhGWG9oQ2NpblVTeDNNcU93QzBMK0kwNDFJVW0wWjhCeUFSOWdpVm1o?=
 =?utf-8?B?Rnp3K2tHVC8rSjJZdVhtTEFwR2lyV1dzMjcwYUJTK09ENkJxTVBLRTJoYlBu?=
 =?utf-8?B?RXoxZGhXVFJacUczTFRWclJZc0lYMm55aDJrbHkrdURWNXNaZngrQjF1UjZ3?=
 =?utf-8?B?bmtwOUdMUDBkcTRXY2lQQThuU3RaTjB1SlZ4UENKVlRHVzQrTWZiK0x5bDdj?=
 =?utf-8?B?Yk9aeHdFM2hLMTZIa3lKeDFHLzhDWmJHRjBnWWJDQWt2WWo5ellSWFZNQWNr?=
 =?utf-8?B?R29wS25wK3hzalpJZ09LL3pwQ3p0ZElCWWxIZHdVRVZwYjFEVlAwRlFYbkJH?=
 =?utf-8?B?TGtvTEtGckF3QTdGeG1FYm5RRDVPSDNLVnBvaHhuUGZYSUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmpBWW11TkdvdXUxS2ZVWGN6SFU2QldJL1FZRjllcXNBTFgrNm40aGV1RE1N?=
 =?utf-8?B?U2NUV1ZKUW1ZZU15Y1lDeTR6ZVk5V2srVjN3NGVTeXBvNG1jQXpqWGtBcWNj?=
 =?utf-8?B?MWNCQS9jL3lZUHNhYWJubU1rUVFYTzdENERhRE56RFEzT3lNNUN6Q3ZmaXg4?=
 =?utf-8?B?QklyamJlSFVjbTRpR2YxT2Z4K3hYN0Fqd0JycmpHeXdMMkJLRU1lQ3g2RVNk?=
 =?utf-8?B?WmQ0MjNzQUNnQ0ZpeEtKK3RnTEdDdTFMMUtCN1Z6S3pjNFI1OUdVSGJ6ckRB?=
 =?utf-8?B?MXNpTFpqdmF2VXNwMWdaVVdXbTJmejB5TDlqWEpGQnJBNDErSGkxVFdpNlNw?=
 =?utf-8?B?RjJRVlVqbUQ1ZFRFZ1hESUxmazN3YmxSSnhxY3lrYnY2cW93OVduR1U2Yi83?=
 =?utf-8?B?ZW90U3puUitwWUNpT1Q5V3ErMHI5dWM5SDNiM0JPQ2tjY05qc2ZzUHEvWHNH?=
 =?utf-8?B?NHNyUXNZKy9iSE1HLzM1RGIvVDZ3ZzFBQjViOVIxTGhvOWdFRDUvNXFvT3R0?=
 =?utf-8?B?TlQwQ21CRXBJK2xnUUdkdzRlbTNGd1JZaUlhRkVxMlFhZk9lbXk0NFQ2VWY1?=
 =?utf-8?B?ZTlVSEU2Q3U3MW1ua3pXeTNxN1dlUS9yWmpVRjRVK0tXQkNheVl0Ym0zMGox?=
 =?utf-8?B?ZlQvcnBSOTN4NzZyWWEvajZ0aDR3MHVXZW9QVllLVFl2a0RRR1lNZC9GbTBz?=
 =?utf-8?B?RHZWejNqSjhoNUdMeWRjdUg3d3hEOVlJQ0JPRkgvcXZIUWNxRzZGdWF5UUlI?=
 =?utf-8?B?RDhWOW5kV1ZPNU5yS3NpaExnSGplSm5hQm5UeDNqVVlWY2hDK0JheS9RK1FF?=
 =?utf-8?B?R3RvL2swWVI5QVNQL21UVnBsSFJzaFZiUnN1czAzRWFBUk95elBsUU15RkUw?=
 =?utf-8?B?UEJVNFJVTXQ4TlJId1YxTitXaUJpWHluamVKcmhFRVhOSmJBMWJ5MzZYaEZh?=
 =?utf-8?B?dzNhbjI4L2tUQlZzQktlSmJkRmNiWUFLNTNTc1lCdFBXRU02MlgxTG9nT1NO?=
 =?utf-8?B?RXlFblJFRTFTV29WWnYwaHhMRENqb0JyVVZHODd5SEZlTnB6Y0RaVXpzekRW?=
 =?utf-8?B?UCtsOWF6TEdLMlBHYUYvRGZXWjU3M0NBVEdyK2lzMkdpQXV6OUlQaWlqK1Z6?=
 =?utf-8?B?aEFHSlNyaitwY3hpZzZYRGpuZTlOaVF2UjBGZDU3V3hobU43L24xVEhTU203?=
 =?utf-8?B?eU82OUt2aDJBVW9kMmRDMzhDam5yL0tQaDE0UllCQXBEV0FHQmM5TjBQeXho?=
 =?utf-8?B?ZFcwSzRjSVA5YlRueHo2SXdJRVF6WUFwc25yeS9uSjI5Smt3ZmcyaEh6QTNE?=
 =?utf-8?B?SmtKYlJjSm5FSk12bFgwQ1lBZHBReDM3S3RZV2lLZStyZ052UEtvdUlFOXFZ?=
 =?utf-8?B?ZWc4WHczcHMzU2xZckEyUFRGVTVQVFJ1REYrRXVSNzVZT1AvQjNrSDRiVk80?=
 =?utf-8?B?S1JUMXlCR0Y4L3NLRmZYR1F3UC9laU13ZUN4M1B6SldDMzAxOHhUVUprOGdZ?=
 =?utf-8?B?SGVPZXVJSFBVakw4T0ZMMjN1NHRiVG1WZVB1SGRyS3ZTRkFsbWRzK09ETXcy?=
 =?utf-8?B?NllwK3hOZ3ZGbDFMeEZMdXFTa0FrcTBJT2FzZmNwZDZvU0lsWThVem9lRnFG?=
 =?utf-8?B?VUtUaWFBSnR4OW1jZHpZN2lGU0ViaUllM0hGbzNCcFQ4UzErOGV4cHYwQ0pP?=
 =?utf-8?B?TitRTk0zSlR2Qk1oZ0lHbVZiWVpSNVVJTFZ1RGdvckxjZmFRYU81YW5Oa0tj?=
 =?utf-8?B?UFJUbXNEMlc0YlFFZlVZa3BXcGgvY1hzVUwya0hUYTg1YXZ5MlZud2lPMEM5?=
 =?utf-8?B?dkpkLzdYaFNBU3NoQ0RjcEtVYmtUcDFJb3dmczhJS2FCUmlVVUhITVZRdUNJ?=
 =?utf-8?B?K0dVcjRaZDY1YnBoRW1aMmFrRzF5SThRZExPNld6dnRHMHZwSGRrMkR3L0ZS?=
 =?utf-8?B?U0ZUenRZVkdWQTJJdW5PRW9OcXBqazIwZkZBUzN3WjJPM0lCczNnblBXWEhO?=
 =?utf-8?B?VGovdDBESXpUYmlzMEpyeE90ajhjTFBiYlJiVHdmMFZzYWFuTGZGQU42MW5l?=
 =?utf-8?B?Rm9tQ0JUakJ6UUJiY245TmhyQUFtK2RRQkhyUkJxVHFKK25HSnpuaU5yekgr?=
 =?utf-8?Q?z6MNMIkL2Gj30OZWAomIFVgCc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31a3729-fa0a-4b11-6925-08dcd6c0c5e7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:31:02.5678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5EaPYWr7lPsnCBmanbfz3YmGWtu8KZQ1ptvBdl6LP86krWq8mNWDObkLt6w+jp9NU6FnBRyVr73LynTTEnoQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7493
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

i.MX8M use PPI for PMU interrupts, there is no reason to update
interrupt-affinity for PMU even interrupt-affinity was wrongly added
to device tree before.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/soc.c | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index be38ca52885..9ed27b59303 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1171,43 +1171,6 @@ static void disable_thermal_cpu_nodes(void *blob, u32 disabled_cores)
 	}
 }
 
-static void disable_pmu_cpu_nodes(void *blob, u32 disabled_cores)
-{
-	static const char * const pmu_path[] = {
-		"/pmu"
-	};
-
-	int nodeoff, cnt, i, ret, j;
-	u32 irq_affinity[4];
-
-	for (i = 0; i < ARRAY_SIZE(pmu_path); i++) {
-		nodeoff = fdt_path_offset(blob, pmu_path[i]);
-		if (nodeoff < 0)
-			continue; /* Not found, skip it */
-
-		cnt = fdtdec_get_int_array_count(blob, nodeoff, "interrupt-affinity",
-						 irq_affinity, 4);
-		if (cnt < 0)
-			continue;
-
-		if (cnt != 4)
-			printf("Warning: %s, interrupt-affinity count %d\n", pmu_path[i], cnt);
-
-		for (j = 0; j < cnt; j++)
-			irq_affinity[j] = cpu_to_fdt32(irq_affinity[j]);
-
-		ret = fdt_setprop(blob, nodeoff, "interrupt-affinity", &irq_affinity,
-				 sizeof(u32) * (4 - disabled_cores));
-		if (ret < 0) {
-			printf("Warning: %s, interrupt-affinity setprop failed %d\n",
-			       pmu_path[i], ret);
-			continue;
-		}
-
-		printf("Update node %s, interrupt-affinity prop\n", pmu_path[i]);
-	}
-}
-
 static int disable_cpu_nodes(void *blob, u32 disabled_cores)
 {
 	static const char * const nodes_path[] = {
@@ -1241,7 +1204,6 @@ static int disable_cpu_nodes(void *blob, u32 disabled_cores)
 	}
 
 	disable_thermal_cpu_nodes(blob, disabled_cores);
-	disable_pmu_cpu_nodes(blob, disabled_cores);
 
 	return 0;
 }

-- 
2.35.3

