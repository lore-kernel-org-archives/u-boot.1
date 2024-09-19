Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CBBCDD563
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52680890BD;
	Thu, 19 Sep 2024 02:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nefwGePK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A28A489066; Thu, 19 Sep 2024 02:15:26 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B9FD8907F
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIwTgXAxdSE8W1xTs7VQ9h5/vYH1MADVmeg9VkLGfhtEZeEuq+q2gZ1Dv8UQEMar93nmYGk9GTa3AEkABvYpCpQaxuKSocxBkzwMA8HbuAvRUwIufXA6XmyuhHITpXhiu3krTJC9WeE6SQPSmi2WPszcnvAiSuUT1yx5tRoDPk4NGZ514R2rijRmTE9eG64hJaRwguN1AeHsilPKUEraKkYO/6Gz+ssMW5GCwn2qc7yfVVk4SNCpt/Uk68oWebzqZECrtjvo4dFTrvzL0sOkU1zmJ9HYrLaxVARHJ6TT/MMFHNFL7HhPAWeJy/sZOmhDH3Z5PW9gTY/vG5JDoaH6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOzEUvo7I/DFtxEp4b+VsMBd1oJzXLTq02ZgJXwZ6KM=;
 b=W0ZIK4JkeoTAA0BSBfZsQGOG4ZKNvJUOOgj48Lf4DsMmw28MA7Lt/qCb+bNl/gjk+aEDK6mK5SmaCM+LROGB4qG+XKr1ChL8GIoS/mptwwUafYoi4aNbxtgWWI019BT4M9ngp3X+qBoB/R2Ei9GYLG6vVGP/tKSYrdKEcwPOpBtz9rg/5yHzaBvyC6FAHtwlFYulX+G6nHKHJY8SI6zBGoy7FUKSnj4t+30HFoFWBcf9pXZrYo6oG/lpNxVMiGgvyhSrDuP1Vf/szbEB30Al3dwMyoiB+R90saFU97MyEEKBrfkkmcBGoRil/m2wdvGXEW+LPvFqvvAjy4de3Rto4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOzEUvo7I/DFtxEp4b+VsMBd1oJzXLTq02ZgJXwZ6KM=;
 b=nefwGePKABln4uy6SpxaRheQ5pP7Mjiz0JJJTSg+HPwQD5VvIMmKLEfY5fQzJjL4leIuxtbJNMFKFiGTgZ9KEyuMwokkxjSMbJpazbcr9SEBbt9i8Asw1Ccyf+L2ntZ0wZOWE07uxQGvYWriFykCD4SHudXey1AsUU5ZRg75ncltJ/sAj2yW7I1g+T5XGZOGMCkKw0Xx+m5KRZbaIv8dbcmNmZsuKoFKEpWGudGbLl+tNbd1+2ovxmvW2eCAN7CINm/leuwy4nk6XjcUqfiHCqO1DSp8sN9r6dfOX04CHQi5BUq8ZlT4qM3Pqq5rDC7Cztm6laGlB51x7ja4HewO7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7872.eurprd04.prod.outlook.com (2603:10a6:102:ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:15:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:15:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:18 +0800
Subject: [PATCH v2 19/21] imx93_evk: spl: update pmic settings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-19-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: c225cba3-2b46-4bf0-178f-08dcd840273c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkdHU2t4UnVkc0VwZmZVQnI2eWhWUlM5MmxGNE04ajBXRWthYUhFT0V2elRG?=
 =?utf-8?B?VzBVY0RLWEgvVkI2R2JVTUtLV1E3czl6eUFVek9USy92dEpTZmlXMWN2cXVt?=
 =?utf-8?B?dS9yZlhPVkFQVnFtZWFoUWhuUjhYN2srdXB1eHMxdkVKWjlvVHh0cDNtMCtB?=
 =?utf-8?B?ZGpOclBxZnNteEFzaGM4Z25WVW9Vb0tvRzdIVkpmMG9rb1VzWVB5ekhMMklQ?=
 =?utf-8?B?Z25vMzBuL1JmdG04ekkrdkp6N2V4UG9WV29NSjVLSDlzVSszVklhU2wweFda?=
 =?utf-8?B?MW9CYW5laDVJd203VEh6R0F2S3k5UnF1cGtJSnp6c21UcXVuUVhRWGNFZnVh?=
 =?utf-8?B?dERCQVFGb1VQdDJCQllsOWtsREZNeXEvdjdpQzBIY25KWTJHSDZscE1vWm1r?=
 =?utf-8?B?azJuUEdPN1J2eVplK3lMM0s0MzVtK0hSNTF6akpScUZ6ZkRwcFFrK2RtRE9N?=
 =?utf-8?B?dC9BeGh0NlJleGFpVlhySDYyTEg2bEorNExQVDF6Z2R1MEVaV1lPM0txd3JQ?=
 =?utf-8?B?Mk43UUdjZzRXcVhJRjlkWk12MG1hc2lTRytoakZLR3JlSGxRUUpDZDR2RHRB?=
 =?utf-8?B?OEYzK2N4NXozd3Vob1BDL3NtbTZhK2k2SDFLUDRuZG5tN29mT3Z0WXRMdkV3?=
 =?utf-8?B?bDloeU4rZFdaZ0thbU8wSDVub0VuTXpFQWFTeDRMMDBwSDFNS1g0TFE5Yml4?=
 =?utf-8?B?RDN4T1pTRitPc1g5Y0ZpRUpML2tZWUxRU3hLOFdndndUTitKdWtZUTNJV0N2?=
 =?utf-8?B?bzEyTHdKcGVGdHpGNS9EcUE0N29mN09ZeXArNzFXWlRYYTE1Nm1MbVhGVmli?=
 =?utf-8?B?eXh6U2I1QmZqRnl0YmJvdHRCMkVCVkxEaXk4RDRhOElGU2x6aXNVUEdlbHJK?=
 =?utf-8?B?MUI0TmRmaUh4MGxvbXo2VjE2VXZtZS9iU09SUi9NdGlrYllyUEhJeWdHSTVw?=
 =?utf-8?B?QWZmTXMrZXlyanpUTE04VjlHaHdLMWpXa0RMYzEwaFMzL1BnMUhnQnMxZFJk?=
 =?utf-8?B?bTIreHVJWkltTWY2bXZWbExMZWZuZncxYzk2c21DdEw2VkpzODhjRXowd1Bo?=
 =?utf-8?B?UG9qQ2kvc2FlNlJKVmE4QTVMYUNjZ1VpYmltNFl2OEh3UzV4ZlE5NitsQm1s?=
 =?utf-8?B?djZBMzRhMGFtNGpPLzdpbHhVT2dJRTlyRGlRT2IxQnlOVVkzWVl0VUY2Y2Qx?=
 =?utf-8?B?endwSnZjNU1FNTZxaitlcmk0UGNHNlhkeVB0S2hYc2psNWxUVVNmTTU0WkFQ?=
 =?utf-8?B?ZHI0Umx6anhxaVhTNll0R3pQNmxzN20xUGVpVEw2d0hYVW5LQzVXRkZrV0JD?=
 =?utf-8?B?bEtrOTVNcmM4a21pVm9lRE9heklkbmhXS0taRHJmUHB6azhaSWJBVXlUVjhV?=
 =?utf-8?B?RkVGc3JtNERsSUcrRzAwUzJCR3RrMFIwa1g0U0tjdUdodi9GeTZBc3pRNzNI?=
 =?utf-8?B?OGFDaGtyRGFtdG04U200MWZGVk9KUkRFSnpZV1dXTTdvNUlnODR5Q2JXcGFX?=
 =?utf-8?B?UGJrMk52VUJYYTgxeEFJQ0xXNUhnVVR0RzBwdUtES0tESHNSdysyNnJnT2Jp?=
 =?utf-8?B?cWtKZitXdWVFL2dBOENReVZLY3ZYTmRpYkRGZGFmOSs2Y293dStuMmpWdFd1?=
 =?utf-8?B?QSs1L1QybDlORVc1WTZZL1gwMUxjTkFNRnQxK25ncmpLT3hWVFpNaHBoMlBl?=
 =?utf-8?B?RllaRGV0Z2hmK3pMcllYaDRmS3owSDFGUC8xN2pua08yOWVXK0VWb1p6Z3Zo?=
 =?utf-8?B?Zi9neVJYSTdHbEl6Zll5NnBmRDIzbGtYVzhYc29TSXN2NEhwOGpYakNVNUhB?=
 =?utf-8?B?ajM2OEY2bDhScHZadW5NRWprekNyQkZOcXpzRkdDejI4VnoyVElzeXJpVHZp?=
 =?utf-8?B?K0ZpRXg1V0dOakVwZUhpQ2gwUzZuL3B6MG5QQnBoUWFCNEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVVkVkhoeWw3d2FnV3l4cTZwZnU5ZGQzS1Zpd2FPblh1aU1SblpPNUQ1b01z?=
 =?utf-8?B?ZjB3eG1MREcveGpzZ1EvbEttbS9hNldYblZYVG51RldVbWlTMlIzak1zc2tW?=
 =?utf-8?B?VXZtV3JwSEkzSVJYR1ViUU5NdEdibWEzV2tSamQwZHd0SCt2cFhRR0FGeksv?=
 =?utf-8?B?TkFUY1lUdTNnTXVjUDBQTFZxSlZnNnFQU082ejJ2aWpLNjRlL1hXWWMwcW1C?=
 =?utf-8?B?bmVnYlZKZW1MaWpkaU14aXNtQlhLemMrYktDdjJEZmVlU3pkL0MrNWpoajdU?=
 =?utf-8?B?OVdIZXFSbG52SDhiRURtWWQyTVZOMjNNTThTR2ZValRzcnkvazRIZFlXOGpG?=
 =?utf-8?B?akZvQlQ3Uk44WTVEQkZNazhOZ29HSzcvdWs0TEFXamZnVm9vMkFxUVpTSnNy?=
 =?utf-8?B?L25FZ3hnbUpGdm42WWZpRXE5MUZIdFk2dERVT25YbkxUZnF3R1BXOC9aYzVq?=
 =?utf-8?B?NEZXWkkzcGlBR29ic2NSS25pcnJsOHRSNWVFM05HVzIyTmdyekF3WXkzdlVW?=
 =?utf-8?B?dVVkS1o0dnhrMEZSVW5oYTdlQWVBU2pONmtkN3lvaUVEY1FjaU9kRjhGMnUv?=
 =?utf-8?B?dmVqUlRxbjRxcEk4S3R5RTkwRmpjMVFvR05XclZDNmJNbXVyTkV2bEtsR2Zl?=
 =?utf-8?B?RmtlQjhtZzcvTlMwbzY1NHF2T3hyYkl5Q0MrR3VZa25TeFhyQ2RVMkMvYTUx?=
 =?utf-8?B?S3pvU05OZ2RkOTFnZWV0WUxSOWw0UmM1bnNOQWxsZkEzcWZDd3hPZjFadXk4?=
 =?utf-8?B?ZmRmSGtxcXZ6RG9UZkl4aHhXWFVvbFkvNWhidVRRN0YrV3V0YVJiOVBuK25j?=
 =?utf-8?B?Qm1YWE5Va1l6REtQU0RQMjhMUjcrSHdCMUQ5RFJWSVpyTnJGVFRYRElZM1Vq?=
 =?utf-8?B?NjVBZ05QVFo5cU9rajFhUGxmcFJXM0s0QnZRVVJ4U3NZZFpRZ1lHRU5DSEd0?=
 =?utf-8?B?a0kwcm5ubjQ4NUxUTlA5YUhhM3JMdW9NNktqM3luTzUxWVNKVDFuWkpULzIw?=
 =?utf-8?B?dmE1Um5vcUhuNzR6THJSTCtncDlQRTVreUxnMDIza0xQYU9xYmU1Y1gzQm5V?=
 =?utf-8?B?dlU4Rk1ROVNwWXRTU2tDOG44eFVGMk93T2tvd1BZdzVzaE9nc1NKVk5lMEln?=
 =?utf-8?B?RXFHOWNYMlNsa1ZIMUgvTGpMWG5lWXdXNWlBVEpibkdjSTRKeEhWSUUzWXNW?=
 =?utf-8?B?YU9XTUtySTFnV3lKOXVlcjl5VGhpaHp3Nm9XcXNZYk1mVHZHYVVNbktvMFNj?=
 =?utf-8?B?RVBhM1RqbWNNR0dWWXAyV1NlOTluSC9TeEU2dkVneTFUQW5xM1RCek1ZMmxD?=
 =?utf-8?B?QlB6SC9uR3dZUFNVb3FvU1FXN2lZejBGR2V6SFFKOUdnRnRMWTZ6TThlTTJD?=
 =?utf-8?B?SlhkYmUwQmtGZ0RHallQT2Z6bmJ1aTRnYUtueGpEcnRmN0NqTC9CYVhNNm5D?=
 =?utf-8?B?OGx4QjZZYUV5RXJRWDRqUE4rNUl2VWNtbm1PaXRteW5YdUQxWWp5bXhBZllj?=
 =?utf-8?B?aGJwVWhINW5HU29NLzBEQ3k3cVJyN1YxWmJTYWhIdTd0ZDhQOE1NbWtvOGJl?=
 =?utf-8?B?c0VPcEFOYXZjVG5EN1d0TUh1VlRYNEFSdFR1MHBWaU1mbi8rS0FiVGxNeW5y?=
 =?utf-8?B?bFFiZmxqTnFaa3Y4bTFYV2U4WFluTVUwNFdBQWc2RzlObVg5OUFCdUs0UFFz?=
 =?utf-8?B?UjlHZER6cmhZUE9yR0pqZ0dXcm5BMTVSc1B3aS9WK2ZVQUpQejdEY2M0Qzkr?=
 =?utf-8?B?U0QzcThQd3ZlL0t0VTh2YWpDZWs4TzBkWFZZOGRaQld6NE83TEZqZlppdmVB?=
 =?utf-8?B?dXd0QnFTR3ZOZkYvWWFtN2lZcGwxckM2MnlGOHg3SFhKUVBhR3RPdW5SYktv?=
 =?utf-8?B?SDhWNTkvVzQwTjB0Mmp1UHMxbXpWSjJORzdvbjJjZUtSOGdlOUJNWm5xZ1FC?=
 =?utf-8?B?c2VSREZrNFBoSU9hKzlleWFaWUVXMUJCSWg2NkI3ZStpSHdXL0dQYmVZeDBV?=
 =?utf-8?B?RzJHdTFHR2pOYy9lNzZ6bElJWTNXRWhaSlhNb3BnaGppRHVZZzdLWlRSS3Vm?=
 =?utf-8?B?emZKNmw4cm8rdkRkVjM1aXZMUWVLSTBhejdBeUs5RnkvMERqUlZsZGx5WFRx?=
 =?utf-8?Q?JeNVP/YL253Tq3E9ia01QCAy+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c225cba3-2b46-4bf0-178f-08dcd840273c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:15:22.8508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erGaUPLcu3feCS4H6ZcoR+nPuXSctJOb7cMAf363yOK5M+WeTRbvhs4hwdgCu0LT4ll1NgZdz3PjJifuVMegRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7872
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

1. Use runtime voltage selection for LD/OD/ND mode.
2. According to latest PE/TE report, the voltages of VDD_SOC for
   LD and ND mode need add 50mv margin, so LD voltage is 0.75v->0.8v,
   ND voltage is 0.8v->0.85v.
3. Use TOFF_DEB to differentiate new trimmed pmic and old pmic

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx93_evk/spl.c | 42 +++++++++++++++++++++++++++++++----------
 include/power/pca9450.h         |  2 ++
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index 2ad7489ada7..503286ce3af 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -62,6 +62,7 @@ int power_init_board(void)
 {
 	struct udevice *dev;
 	int ret;
+	unsigned int val = 0, buck_val;
 
 	ret = pmic_get("pmic@25", &dev);
 	if (ret == -ENODEV) {
@@ -77,20 +78,41 @@ int power_init_board(void)
 	/* enable DVS control through PMIC_STBY_REQ */
 	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
 
-	if (is_voltage_mode(VOLT_LOW_DRIVE))
-		/* 0.75v for Low drive mode
-		 */
-		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x0c);
-		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x0c);
+	ret = pmic_reg_read(dev, PCA9450_PWR_CTRL);
+	if (ret < 0)
+		return ret;
+
+	val = ret;
+
+	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
+		buck_val = 0x0c; /* 0.8v for Low drive mode */
+		printf("PMIC: Low Drive Voltage Mode\n");
+	} else if (is_voltage_mode(VOLT_NOMINAL_DRIVE)) {
+		buck_val = 0x10; /* 0.85v for Nominal drive mode */
+		printf("PMIC: Nominal Voltage Mode\n");
+	} else {
+		buck_val = 0x14; /* 0.9v for Over drive mode */
+		printf("PMIC: Over Drive Voltage Mode\n");
+	}
+
+	if (val & PCA9450_REG_PWRCTRL_TOFF_DEB) {
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, buck_val);
+		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, buck_val);
 	} else {
-		/* 0.9v for Over drive mode
-		 */
-		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x18);
-		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x18);
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, buck_val + 0x4);
+		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, buck_val + 0x4);
+	}
+
+	if (IS_ENABLED(CONFIG_IMX93_EVK_LPDDR4X)) {
+		/* Set VDDQ to 1.1V from buck2 */
+		pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x28);
 	}
 
 	/* set standby voltage to 0.65v */
-	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x4);
+	if (val & PCA9450_REG_PWRCTRL_TOFF_DEB)
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x0);
+	else
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x4);
 
 	/* I2C_LT_EN*/
 	pmic_reg_write(dev, 0xa, 0x3);
diff --git a/include/power/pca9450.h b/include/power/pca9450.h
index b8219d535ad..f896d829d37 100644
--- a/include/power/pca9450.h
+++ b/include/power/pca9450.h
@@ -54,6 +54,8 @@ enum {
 	PCA9450_REG_NUM,
 };
 
+#define PCA9450_REG_PWRCTRL_TOFF_DEB    BIT(5)
+
 int power_pca9450_init(unsigned char bus, unsigned char addr);
 
 enum {

-- 
2.35.3

