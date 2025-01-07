Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2748DE77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 07:02:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D49D980609;
	Tue,  7 Jan 2025 07:59:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jUQDLKbN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35238806C9; Tue,  7 Jan 2025 07:59:58 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69BC180740
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:59:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMLihL6fwPeJJGjsjt30fxHQWZTZilirT8+hcQjKsCAbT8osGGLe1l2XVaAZMLOLmYhLDsVoyL1U1LC7pywS21ecGjBxlSsuhbtRBMxG4OS8+Eq/xbgZhaBjrmsL5B1qxtGJ5wLY3Z0HA9wvKrMTOO6T00GiFWil61pIjeRUTy5Kf6M+tCFMAp4y160qGcpywDHwEXiz6U5JRaDELQgxcrM3W4wY/UyBdoyCxb++CNN7y4NdMFhnyseeJDlXUjLwVhm2pJ+OImfYw+t661qOKqu+UVVMt+YoicNr2UptPKijG3MZGP6UQCc/uSVjjz6o+abCHU1PtpE/lWfIXwXW9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn+3GelrPMPA9WMHblcMHZq/cNdLuJqmHrQUTPQsals=;
 b=rIeKSHWD7PA5JsJNwa/YaONCYYPxqvm7cCGzR0fBzDgQbGSbldlxqvvOpaQIdwZrj9AXik+8ito8kkHhwUjVsh8hlxUdFXdN/voUoIbuHlpzd8BZB5csDRYNEkYiPJ2q1RWuL+U+WrSj59NDFmARhq5UcyvgozFziGZtaPW0FdLpifpyQgtlrMrPlsZ4kGTjUjCZCNIJE5cZqG41y0+we9Y1ettvglTFgvkujjdjlD9941Iz7kn2lyTUg96YSg7ihorJynjUjMSUspVnLmuPnqvIXChVVBpNupcW9OpCAG5DcDcc5YHX0swPI8DCaaU1XR8vIl67S2lZbX07xvdLnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn+3GelrPMPA9WMHblcMHZq/cNdLuJqmHrQUTPQsals=;
 b=jUQDLKbNXRLWQ0pJe1Q+9nedcNiW+qh6AhFi1nPupzBma93MwazuQy6EEGwTs+fQgqmHzRu8v/En+X8Hc8XKcgTZN5fIeF99l3qGlEeO/6CdxcuqXk9NGAatyIU6DC2ft+yGVKJDyh+rRN5Augzv0DFk/nkFFq4C720NT3zuau8+WL4edoyWh5k0Q4LzYRpZt3/X2NqxWc0aqvLTmpZvNrEj6XqOg+Wn/Jbq8oFR1G1vAUEwLtVxVyx5LQNcHWMOu6ZLjZfwK08Lcg3kZmK7W1h9i5qVrmT30F3p01B7Eq+xO815O6qI2tpt13D8URbe63RVeeoFCB5EwQGkunzhkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10523.eurprd04.prod.outlook.com (2603:10a6:150:1d4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:59:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:59:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 Jan 2025 16:05:16 +0800
Subject: [PATCH v2 16/16] imx: imx93-11x11-evk: drop duplicated nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-imx-bootstd-v2-16-97671b1694cd@nxp.com>
References: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
In-Reply-To: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10523:EE_
X-MS-Office365-Filtering-Correlation-Id: 799fd035-287e-4f32-d012-08dd2ee8db58
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjNLNHJtcy9xUjhOc0VYRDcrZHZNYzFQa0hLUlJicUo3c0FiNk5rWjRZNGFw?=
 =?utf-8?B?NitMMktBMmh4T1NiWSsvbU1mbWFOc3c1NWZqaWJZVUNGWDdYZDJWSWNVb3ND?=
 =?utf-8?B?bytFL3IvUnJGa2FmR3haK0NHdEJETTRSRXREeWJZN2lvb3p5akc3R2RIOENJ?=
 =?utf-8?B?SHhteHFUZWc2Z1JqSTlOTEZ5RC9HaW9NeEFNSkl3b0VDR3VESnZZcDRzNG9s?=
 =?utf-8?B?RlNjekhQc1QwU2RlYTNhQWxvUmJPT2I1U0dnQTZzREx5ZU5QSStmZC92TSta?=
 =?utf-8?B?YjBLbmgwYUFKTGNRUmw0UGNVSXY5NUN3dEZ3MXh6TXB4clAwUkptcnUyV0xY?=
 =?utf-8?B?WXhSd3NjZWIyRUdMQWlsT3JGTFU4WUQvbEZSTTBQODlDNUgvVVQyUkhQUVdz?=
 =?utf-8?B?QWE4OW4vdkJyaktVd1N5ZUZSS2dERUFXSmZ2Y0NFUjc2L3QyZ3dSbit4UHBs?=
 =?utf-8?B?eGZiQ0p0RDhuRlV2VnZRYTNTM3ZhMEovVWhyamdoR1hBUjlLOVhFS0h4THBl?=
 =?utf-8?B?VUFFTWVOQjZmRUxrWFF4V1ZOTXphd3VxQ3h4VGNkVy9ta2IxRFhvNXZObWw4?=
 =?utf-8?B?Vk1GSGphQjBBTWx1dzlOL2hQQUluNjBEdTliWlFPaEJ4QU1ZRXFaVUtuZEcx?=
 =?utf-8?B?Y3FzLzFpRXFLaEkvdGQxQ1lrUitjM3hQU29XWnMvNE0xVG1jcWpOKzF1OElq?=
 =?utf-8?B?SU9VWHUwenRBVFcvMXhPaVdwYjE0T0FONk43YjhYeXhGMFBDUndmRldSVHkr?=
 =?utf-8?B?S3VURm84UjdGd3JJdllQdnZwcGJaclBuM3ZJSDhRNWRvbFZSTVlWaksyNU5R?=
 =?utf-8?B?ZWxBM2x4V3krYWQrQll5Y1crTVdPaXRoNnY2ejRVTnVnc2dhUjZaSXByaHRq?=
 =?utf-8?B?VSs5K1NpaWdjMUpPblhadnc1ZHZYUlF0cnk0YWVaT3dSWVBhamp4ZWR4ZWE4?=
 =?utf-8?B?TUtZSmF3QmdxTUZTWE5sTnJORmc1TTgwTDM3QmJuSVVUQjJMV1dNYi9SYnZ2?=
 =?utf-8?B?S1JaVEcwdWRMK2pxSTZ1QjFNMVRJWTh1YXJCaytkNHlsQWlVOUxZYVRKeHdV?=
 =?utf-8?B?NGQ1K2QrZXB6NVcvMlhzeEtUUzlnTnN5NUJFNGxxRDc4MTFVb0EzWVlWSEJ4?=
 =?utf-8?B?enl3UzJKZEZtaklLcUFxcldXd1FEdXJFZFBoeXUyOHY4b0JqZ0xUMnFlS01L?=
 =?utf-8?B?N1RzWHU2c3hOb1BVMFBZV0pGVkxFRlNtb1FxbW04c0FWczdLelNnaktqbDJr?=
 =?utf-8?B?MmZ4bzhYQlJzZUhjTnNyWDdqbHZ0OFhSdG84YjBkQ2t2TnhreGpMT1loNTY5?=
 =?utf-8?B?bGprYUhGbVk1Zjg3TG1ud2d5a251UE9HVXVYWSt5VWVaUVM2ZlhiUzl1Visr?=
 =?utf-8?B?UHg3RkJmQkJlNmVkZjk0emRMazY2K1FMWGtnbm1yalRPNlVFNnhBWTN0SnlQ?=
 =?utf-8?B?M25DUHB0L0s4VWJDSFJnVncyQ0g4dEZCbzh2aHZra3JROXhHeFNLZTY1SFRM?=
 =?utf-8?B?U2R6K1JsdUozbVY0Nkh0SUc1WktSMkFWKytkSDIrSG9yODQ3V01nUkoxbVNu?=
 =?utf-8?B?akRwb1JONWVxWTYxOWZXVW90d0J2STJkT3Qxc2lObGszNEo0SHVtZFJNRnRs?=
 =?utf-8?B?aXhhVlMrSVc1eVYyeVlNK1dwdU1jZUdEdDRQeDY1Y2dsTEpPZkxnSjlNSWZZ?=
 =?utf-8?B?c1k1SFdFbzJ3K00vQ3hQdHRFa09yQzVmaTJtUElhSVVCUktCMWVicTZmbTVo?=
 =?utf-8?B?aHRwZW81M1BxQ0JOTG5veFdZZ1hhL2hEU0tvZjNZaGl2MGFMMTR6aXB4QWNz?=
 =?utf-8?B?aGRDM08zREhOeEdXR0N1bmZpZ1hCK05WQkNOd2c3eWlSdCtoVUh0TklYMjg0?=
 =?utf-8?B?N3QxVk4xc0Z1bFlEMm5uZ012Ylp0K3orT2EzUmVJMm1ieERGMUpVSDFLN0Z1?=
 =?utf-8?Q?XZZfycQsa8MjL6X3+7EqL9hQVRb2kTN9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1V3a0V0a0oyQ3ROamNTMm5taHVQL1V3clF3cDJvUlJIN1FFMGJRajVpeHhm?=
 =?utf-8?B?Z1N5MnVScjFGTmRlWG11R3lWc2NaMHFOMHRTaWMrOGQ4ZmI4d25nR2hQNDBm?=
 =?utf-8?B?ZGtlbVc4YTU4dll2b0thN0pncytzL2x1RFNHb0JKODlBK1BkRWthYlZjMFBW?=
 =?utf-8?B?Q1U0ZjY5Y1JpQkJZRnN6UWhwN0daTWJrRHdiVUt4RWtVekFQRjBoMU9zcjV0?=
 =?utf-8?B?YXk0Q0toWmJZeDE5L1VIYkdXREFyaWNSVzZyMTYwdHZxUGxCZ2xZTjBQMVZ0?=
 =?utf-8?B?YmdURDdNekZ4YWxmcURLMFlYdjkwNks4STJiSWJpNVlhVGJkeDZaN2hVeUhs?=
 =?utf-8?B?Y1JGdlRBeGIxZVlWaW9kWHR4S2NlM1N0S1hpWTJmS2hzZmppcGNXeVFJNFNS?=
 =?utf-8?B?d0k0UUNyUUVvZW9NOVcycFhtT0NBOG9OZ2ZoeDlYR3VESWxXMjhQdXRsckR2?=
 =?utf-8?B?cmdQV3NmM2xEdGQ4QzU0RHNXMjRVWHF5akJyb1YzWThqWG1OdVFyZjI3RkJB?=
 =?utf-8?B?WVpnNWFuL21vR1RyRE9KYi9qSUZuWTNVWDEvMlRhdUFjVGRyTk5QMWorSHJJ?=
 =?utf-8?B?S3IybFAyTVlIOUhVUjdUNjNmd3ZDRitmSGNJck5PZURUcmw2N3c3L2tFbWFu?=
 =?utf-8?B?ZWJJTDVIREloQ200TFhoV1dmTHRQR094a0Z1dUtXZFh4UHRaZjNsdHp6MHpr?=
 =?utf-8?B?eEEzOENKWG1XQlhBU0pvRGJCdXE2a0xmOHhZTFRldUZwNGZxUmtYOVFYWWFy?=
 =?utf-8?B?ekZnTzg0dVBNNi9GdkpkZTVGMEJvc0xMeVRlVThJb0Jtc2dDOHN5YXQ3SjhQ?=
 =?utf-8?B?dXVtTm9tN0ZXRkxwMGxheDV3RnZPZ1FvN0xmWjhobHZic0pFTkt3aHhzUmtM?=
 =?utf-8?B?U2dHOG1JVlJUeU9ZT0U1c1pweXVGdnZSRzJDb1BLNE1XL0hNRXk0eDhMQVA0?=
 =?utf-8?B?bU1UZ2gzekhscDYzdTlOclZQdFlBL0NETi9mQ3FKTmFNaTJVc1JpRk1zbWo0?=
 =?utf-8?B?MjZkSHo2Q0Z1RS9nWTZsTHpud0x5U1orUFVZVWNSdngwUDExWDRGem1TWDZU?=
 =?utf-8?B?NE0va3luSk1paHhmSzMyQ1pydTgvVlNaeTh4SklQT1VxSHRvT0JxL1Q0enRF?=
 =?utf-8?B?aXpVQUhudDNYNFlobG1CSER3bTFERnhvcmI3YlRzbnVyVCsrSmlkVWwrQW5a?=
 =?utf-8?B?QWtLQ2pLR29iY1VEek1PenFlYzZMZTJGN1ZYc1JSMmlaa05pVHlSZDgyY1Bx?=
 =?utf-8?B?V05QT3d2bktGZitxY0hDcHlxYlFaQjFRQWR2M2NoSEJjUXZ1c3lBT0h5clFv?=
 =?utf-8?B?K3BHZlZNMlRKeFI2bEQ5KzJRb0VtOTBQQTdoeWhJNFVMd1JPV2NobWNKMGJE?=
 =?utf-8?B?cnBvSGlIRzJvdnRZRnd2TStBaHZPL3lVSEovWnlWZnlFanBEb0dweVlDOFY1?=
 =?utf-8?B?ZTREZkt2LzRYeWM5d2lvOUVYV2pwbDdTbjUrd2NNaTY4RHFKdVlMdlBKa2Fx?=
 =?utf-8?B?dnFkUHBUQXhPTXVPdTl3eUpQQ3ZxV0tTWFZXeWFVclJOVVFucEF1L213a3hr?=
 =?utf-8?B?cjh3akhhNVppc25raE1SMStsVWxmeERTcGtRUkV5dnRwQUNBWUVodkJqaG82?=
 =?utf-8?B?Qzl5Z3RkMDEvank0alVGT3VZZGFIcVpLRVNMTDlqUVdJWjJZdSsrdHIzL2dQ?=
 =?utf-8?B?cFN0WExuYzhYZmRHNGdSdWFMYVhORzNDcTJIbVVuR0VKUStBcDM2TXlvVit0?=
 =?utf-8?B?Z1pPNzd2NHQ0MUZMZFpCSFcxSm81UVREUDYzTDFvUi9YK0pkWFI0cndYQTBn?=
 =?utf-8?B?NnZFQ3NlRjBBNTJiS0JXU3l2eHFFZ3d1SkhEMjRMUmhudnFXRlJSMXB1QW1u?=
 =?utf-8?B?ZldPYVdmc0xWMW1XNndpTXBTVWVhSDR4cE1qV1BYNHFBMUNvZzN1OFNVelVO?=
 =?utf-8?B?bG1zbUI0eHkrUVEzczgzUGxCa1RmRmQvZE5sK0U1U3ZsdjVXTFh1dnpWaC9Z?=
 =?utf-8?B?eGRXZGpkSlQyTTBGR2NuSXZ2Q3dYdEpXRXJsaVdnTTIvdzdkK2R3RWYzdHpV?=
 =?utf-8?B?Nm10c1B5dWRUblM0UmNpd3FFaHV1QklvU3ArR1V4UTNuNUUwZzdLQkdLL2Rr?=
 =?utf-8?Q?xAyrWgmYe+0t2u1ZS1yR79zYD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799fd035-287e-4f32-d012-08dd2ee8db58
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:59:40.4678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViWgyGnHE6dzvCq4aUMNz67e30k7K9vwTANUfvB4hA2xiUrKIrJGzqDlOjysIjzbMe6mtb4Id8NrCXfVICq2mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10523
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

The upstream dts already has the lpi2c2 subnodes, so drop the duplicated
ones in u-boot dtsi.

Since the adp5585 compatible string changes, update the driver
compatible string. i.MX93 11x11 EVK is the only user of the driver as
of now, so it is safe to drop legacy compatible string.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi | 118 -------------------------------
 drivers/gpio/adp5585_gpio.c              |   2 +-
 2 files changed, 1 insertion(+), 119 deletions(-)

diff --git a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
index 408e601bc90eb69744ce1198498e01b12f814ca9..a99ba99bfb4f2c08752472536f2450c8e79fb87e 100644
--- a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
@@ -26,111 +26,6 @@
 	bootph-pre-ram;
 };
 
-&lpi2c2 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_lpi2c2>;
-	pinctrl-1 = <&pinctrl_lpi2c2>;
-	status = "okay";
-
-	pmic@25 {
-		compatible = "nxp,pca9451a";
-		reg = <0x25>;
-		interrupt-parent = <&pcal6524>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-
-		regulators {
-			buck1: BUCK1 {
-				regulator-name = "BUCK1";
-				regulator-min-microvolt = <650000>;
-				regulator-max-microvolt = <2237500>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck2: BUCK2 {
-				regulator-name = "BUCK2";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <2187500>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck4: BUCK4{
-				regulator-name = "BUCK4";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck5: BUCK5{
-				regulator-name = "BUCK5";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6: BUCK6 {
-				regulator-name = "BUCK6";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1: LDO1 {
-				regulator-name = "LDO1";
-				regulator-min-microvolt = <1600000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4: LDO4 {
-				regulator-name = "LDO4";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo5: LDO5 {
-				regulator-name = "LDO5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-
-	pcal6524: gpio@22 {
-		compatible = "nxp,pcal6524";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcal6524>;
-		reg = <0x22>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	adp5585gpio: gpio@34 {
-		compatible = "adp5585";
-		reg = <0x34>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-};
-
 &aips1 {
 	bootph-pre-ram;
 	bootph-all;
@@ -149,19 +44,6 @@
 &iomuxc {
 	bootph-pre-ram;
 	bootph-some-ram;
-
-	pinctrl_lpi2c2: lpi2c2grp {
-		fsl,pins = <
-			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
-			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
-		>;
-	};
-
-	pinctrl_pcal6524: pcal6524grp {
-		fsl,pins = <
-			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
-		>;
-	};
 };
 
 &reg_usdhc2_vmmc {
diff --git a/drivers/gpio/adp5585_gpio.c b/drivers/gpio/adp5585_gpio.c
index ea0cb75459b741c0157aa9077c44163b3c0cab01..114583b3c3bd9a51fbe1960b7532150d0d7cabdd 100644
--- a/drivers/gpio/adp5585_gpio.c
+++ b/drivers/gpio/adp5585_gpio.c
@@ -224,7 +224,7 @@ static int adp5585_probe(struct udevice *dev)
 }
 
 static const struct udevice_id adp5585_ids[] = {
-	{ .compatible = "adp5585" },
+	{ .compatible = "adi,adp5585" },
 	{ }
 };
 

-- 
2.35.3

