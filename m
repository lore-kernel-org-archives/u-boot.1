Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1A2C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 07:40:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFB918206E;
	Wed,  2 Jul 2025 09:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hiGUegLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00D1682F14; Wed,  2 Jul 2025 09:40:17 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 100AD81FEE
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 09:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLEZVkbpbA2ysbS7LjnNaC6Rwjo7pdzBySpCClqaNooot4SLFuuqZDma+GAwhQJsMesRYTirtSqjuffrd7WKGB1I3ToSYxeeYnFH3lXZAXc6a7EYm1nY6VsC00cxtEPpo/xKIyNvdE2LX17G2u1XYJ0LIFw5k+DrI9SNdQbjfj6j0yKD/EuwvU8cov32FwPcb4tZP+3+0eKkJVKTKDICYfVmQsm7rc6GERDxSsg4rHCZiKMph1xiNkZmge5z85P9mGihHSJCB70Pbp1g0FMEeDNRuP+Z9Hh7DAEBu6ncVIIBHrihL9p47MaxswMHM7r1WdJVIAYjYs/UPrub6lDGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxp8u41bOLs+/i1Q/0etiB3npQoPNk8lUHVJnF3h6X4=;
 b=S7GdnxhOhnc56Z4IMG3n4s1g0dI1fajVb7Yz2OY33Lyj6powu+tvnvTUzBb1ukTVTBg163hnPnBOv4YUb/oPUiiohMzDYBdtN+LnJavy+z8sjVl9INBXie4YK9xiUWYlrxYdB80jim4N3JgBuIY44xYHBXnYsFG/s/wGBEXDbKRDGKFjYAXBUQAp84OOL/991fPTI4xN+7latfeN2lx+CtFmdK8ReP4Bm/I0Kumg3M+VBd9BoN81maV73vWI98IeCa3f6g1kzj+E/SKyb8pEeK1DDCEx4miezbU98xtQlt7wOLybBTS9ATM+5jCWuPR1Il4vr+HjzVLIM2klFhUs0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxp8u41bOLs+/i1Q/0etiB3npQoPNk8lUHVJnF3h6X4=;
 b=hiGUegLwjEN20xSLuP0SHcbgqwieBIDUghG7s/Vvg3r6ITR7FnkiuSzH4o0eJFz3en+SP6eie3JVEEx0+abH00hDs4irOHYYc7NKGwCTrAu9J2yYshCWI1UxlLBeF+hu2r4pSTjApjuzntcqxHEzgLRTwp30dfgj3QH0awfSN2JfcOzvwjcC0vQQwKNyUL6L0MIfhbtxLxzqAV2xxajSyFWQZv+caz8eCj0au6FG/+MlhylVOS9ySnvaruL+dubPhnAlhGieaT6ivnVeIJ6asXLjVLU4uNn1oc4e9PYrxt8XuNvOu1ByxBz/xx7Fs/0yB3zMzvQzflWLTcwak+9v9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Wed, 2 Jul
 2025 07:40:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 07:40:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: Peng Fan <peng.fan@nxp.com>,
 Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>,
 Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
 Akio Hirayama <hirayama.akio@socionext.com>,
 Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] Revert "drivers: mmc: rpmb: Use R1 response"
Date: Wed,  2 Jul 2025 16:50:42 +0800
Message-Id: <175144621272.27323.14051143557817090594.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <5e3239ff-205f-44de-ba43-8b32eefdbe73@siemens.com>
References: <5e3239ff-205f-44de-ba43-8b32eefdbe73@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::29) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee74e2d-6cfb-4db8-1a6c-08ddb93badf5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ykk5aXFTTUJNZkJFelhTcFQwU1pZUlp4UG14a05YRDByWlRsRVl6Wm5EME14?=
 =?utf-8?B?dlJ6WVF2UW1ESCtyb2tDUmVhTjBTTHV2eGs2R0ZidGFjYVMyUFJpaTNGRmJR?=
 =?utf-8?B?RWE0ZTdudEFYdzEzcVNZT1pxcCtqSnl6NkhldHdoY1p5aTNCemtETGpiZmti?=
 =?utf-8?B?bW5oL2Jab3ZDaFY3Ri9udk04MjB6UFJjbkhKQ055ak0xSHd6eklhbmJSOHlu?=
 =?utf-8?B?S1NSMlJRbUlrVjZWc3VRWE9uUjRMcTYzNUVIS2Q3YzgwUVh4RnVyaTN4bEpT?=
 =?utf-8?B?ZXhhNzZmaVdyL3lhc3hZbHplN3VoZ1BKbFhFSjNDelRrS1RlUGdHbkdqUlFX?=
 =?utf-8?B?L2Y4dTgvZGhqK3VxMDlHUTc5bGU4Z3ZkbzRKMDRPejczYncrOVF5cS9ORnlH?=
 =?utf-8?B?c2ViWW5hOEl0NDhxL0x1ampxWGNidXZrcEVtZEJYdlFnUlMxYlFoRFI5VzNa?=
 =?utf-8?B?SUttSlFYeGErMmlqdFllcDZwaXhZdVNuN2cvbU03R3ZVbHhUdVZjOUJ1dGhF?=
 =?utf-8?B?VlMzSmxrTkxGSVFXTHlEai9VbnNIem9TVUFxa2ZEL3V5R2NDYkFMNTFCR0RO?=
 =?utf-8?B?VmZQM1NrZ2kvTm5LZ3AzdytPRXlvTENqUkVIN2RBUXdFd2xMSDB6VWVZcHZG?=
 =?utf-8?B?YXhmdm9QaWR4bHkyUE95TDZlam1IRHhTNUYrcmtTKzNTOHhPSnQ5c050TkJR?=
 =?utf-8?B?NWNXKzJZQjFoVjFhTGlkTzl3aVFGcU43aXlUbXN0UGhHTkpTdmh0dUtOdXBr?=
 =?utf-8?B?SFlkQjJVR2ZmLzRKQWNtTnRXWG9FL3dxd3hFa2hLZ2xadUk5UXN0NDhGWVpM?=
 =?utf-8?B?ZHRxYmdoV21HektsVzJsY1k5cmgvZkUvTmxFbStpdFV6cWwvV0QrVG1uRm9T?=
 =?utf-8?B?dGhvNjlDakppYXEza1E1RUxSZzZ6R1J6S2NEV0t4Rk1oaEtRSzk5ZXJ2WjA3?=
 =?utf-8?B?UkJRZFVuVk03dSttdEo4SnpHSU8rRzV1c0ZuOFZ0OU9yWTNCbU1BZzlRZG12?=
 =?utf-8?B?ZDFGeUU5c3J0dUhQTFdRZno3aWVkNUdpa0lUNERRN0NCY1BvejhGQTdlYlVw?=
 =?utf-8?B?dFYzWlFTQ0paQ1ZBN3IvZXl0em1uWGlSTHVuUGdIbS9zby9oaEoxVlJLM0pQ?=
 =?utf-8?B?c1NoNjlZeFlkQ25lRWpMTnozRWtrUUhBd2t2ejZ1Q2RqZWhNVFhFQnQ0NG5Y?=
 =?utf-8?B?LzljbWl0bnovM2RFVm5DMXhOOU9UVXJybUhVZ29WY0NJVkRYbnZJODRiR0VN?=
 =?utf-8?B?M0NLeDkyRnVwM0M1b2MwTFRrT0pFS1RTTkcxUVM0VmR4QlNEa2xyeXhLR0po?=
 =?utf-8?B?bFFIa2N5bjdoS0YzdWNpMy9helRuZmJ5UGxmVVJ5eDk1bGNPQUdnKzA2WE5s?=
 =?utf-8?B?cTl5TFNKdEZNalZmZGFHamg3MnVzNzRTb3lEejhoUDljemRrdEJudnZ0TU5H?=
 =?utf-8?B?WWFrcDdGRzBhcVNyQ3k3RzB5TGZ4TWtqem1La1puNEpWTE9MSWw1S21rcEJL?=
 =?utf-8?B?dkFZMCtGa0V1OE5CT1RzZE54S3BvSE1rSCtobC8vekt3U3JpcFBRMmw1aGNC?=
 =?utf-8?B?TTR2OU9nZUwxMXNCL3RkNEpWdUM5emNBOWZ1ZzU2Q204Rjc2RmNUMEN1THY0?=
 =?utf-8?B?TXU3R2RGUEs2cllmeFRxd3BZRGl4WWJVbGZoNGttR3FRaUJmRENTMVVNWHlP?=
 =?utf-8?B?ZWV0Z09SbjhoUUJTTmZCdFlMc0pkTWtoUnZjbUxtNWJGbHF4TmZSc0FCMTU2?=
 =?utf-8?B?SXZZQzBXdDk5SXhweWM4N0pyVy9zZGF4OHFmcDV5Yk01QXFwSmlVUDN5ZXQr?=
 =?utf-8?B?UDdqNCtSRVAwSVhtbU83MmUyTTBPZXRHc25CRUJreFlvWHZhcWFTQmNDV1Bu?=
 =?utf-8?B?eXlwVllzSGxWcmp3Q3BIdkVUdFRua0lOdzZNbWM4MnhhOS9vSjZRVmZ5ZEls?=
 =?utf-8?B?blJGejdleCsvL1dKZUVlaXY2alpYM3ByZlhtSnhwZWJrbnI5UGhFNjEwUzVo?=
 =?utf-8?B?MjVJMHFyUW5BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1djRUU0aHIzRzcyTng0V2NLUmtBSi9ZZlh0WnQ5VEUwZmpHU1IwMWxYK0Vx?=
 =?utf-8?B?ZHFlVVFwNGNwSHBXczcyQUxvMnBsc2t4TEo1NEJtZVhEMWlaVFlQdWdtcHFQ?=
 =?utf-8?B?S3VvT3owSjNZMlB6alRJWHlvdC9laERNc0lpUXZ1M3h6d0N6anBRWmVpMlRG?=
 =?utf-8?B?RmNjZFRhU3lhVmxWdUQ2SnhORXI0bnBjMU1GOGk3d2o5Q1lpQ2V5OUxxaUxH?=
 =?utf-8?B?OHBqbytYY2lkM2hEL0diSENpdWJnZmpVY1AwRFd0T3pXeEVHbitVa0R4bXd2?=
 =?utf-8?B?ZFVHZ2krMzNsMDFrb3FGV3hjeFJVVTA2RHRLVFR1MXllNW9oNmdiV1liZjU3?=
 =?utf-8?B?QmRHdXlScVhVRC9COVIvOTN6dmd0S2NWaHhiVWIyVEhlK1l0U202QjlaNTBR?=
 =?utf-8?B?Mlh5VXBNUFhhOXlJd2d3bXhrc1V0TkgwUGthblRsbk16UlVpbTVTek5senRP?=
 =?utf-8?B?TjB1Qkg4dVlSbGRKcHBKRUs2UlB2M29MUk43N3BRTi8vMlgwTlhJWWFGUXYx?=
 =?utf-8?B?VjVPSXVLeEpNeWFHTk5IRGlKT3ZRUkhyY1YwR2djcngyNmN5OGRlaFBvVTEw?=
 =?utf-8?B?RFIrRTFLci96cWtKeHZoa3p3eXZNRC9UMEpMUjIxdEJyMGdlQlJsQmJoNjFr?=
 =?utf-8?B?K2x2bnpvd2wyK0xkZ2tFR2xES25QZW1Kek03aVgwY2k1bGgzQXRzNHg4VUZJ?=
 =?utf-8?B?NURDRTRXcWQvU2t2bm1XQjdCQUZJUE4vK01JbXVqQVVXVEF5SFlzTUlZWWdS?=
 =?utf-8?B?NWU3SVQ1bmx3YldIS29DS0FDRFRnQmdPV3N5ZWFOcFdJRlh3eldpaCt2VWtw?=
 =?utf-8?B?Vk01aFN2QmoxeVdPYXMzTUNGeUJzdUhWSmpiMFZSMGRkaEZjYVFNV0dDUUJl?=
 =?utf-8?B?Ti9kZTJVa0pQVVRiaWNRQjNsNnhhcnYxNjFGcDBVNlBMVkFtZEp5dDVLOTE5?=
 =?utf-8?B?TnduUWh1WHBESTNpVVc0VE1sV1hTRndDeFpTRXhYWGtHNWdSa0dEWGhJR2Fq?=
 =?utf-8?B?emZDWXNTWStaWlV5dk0yQzVoOHdNRGpvVWlOOVFXaW0yUTVObEtab3g3SEJJ?=
 =?utf-8?B?WjFkanloQlpOZjZRSW5YZ1hURmwzOEtMNDBJU01DeUs4TFc4dUl5YXQ1dlJq?=
 =?utf-8?B?elhrUGg0b09WOHYzQ2pHekNhY3Q4R0tvWU92SGliNVZQVUFwRk9iNjRnVGZ0?=
 =?utf-8?B?R2xoS1Z6b0h4NGFnZCtkZmdDMzYvb2NCSUtKU0pMSUNBa0ZLQ2RJdHlhai9U?=
 =?utf-8?B?bG9oYXhJTmVpdnBJNVYrRXdJbU44Y2hvYnV6UC9YQjVUSDZaY01mS0F6UWkw?=
 =?utf-8?B?azdrdUVvVTJTM3dtYVZiTUc3eXhPd3pJZ1dZdmN6dWYva3F5VFpNYXI1Mnp1?=
 =?utf-8?B?c0Y5bXhpS0J5ZVl3MlhxT3hoZWNCZ1V4cCtDSHhVK1VLaHZFSXRMVGlZVVNy?=
 =?utf-8?B?R2FOQjNmenJaWldYcWFGRzd5NUswd0NxQXBxZmpiK3VGa1R2YUhtWkZ1dFpq?=
 =?utf-8?B?NEVyUVdpSkVYYUxaWG02cFpaVUQzVHUvSFRGVnlmVGJzSk9SN1J1ZFU4THdC?=
 =?utf-8?B?VWtNMFVENWpERnJoZ2dLc0F6ZlZRakdhM0k2UXE4OC9WTkhrTzc3eEtmRnpp?=
 =?utf-8?B?ZlMrdnVGeStEc2RTSHZaOWdOY0NRZXVlTnc5N0V6UzBudjZCa3BwRldVZ3ZS?=
 =?utf-8?B?NEVrWTBUWGJvVGNkeS95UHpBMzVHdERjVTluendWVjlQSzhUOWNFYjB1eENN?=
 =?utf-8?B?SElqOTI0NHJWQUtQaHFqZnFuVC9RWTI5cHdHNDFHVDNwODIwWmhCWktsdjJy?=
 =?utf-8?B?dm92dGRpV0YwdW5nK2w0SCtmQzdVRis3bk4xMVFKSTQ3ZkZpU1BmRnVCd1Nn?=
 =?utf-8?B?cmVMUC9rNE9LNmg5NmowWi9hL01vTGlKQ3FMWUJFMHg2ZXgvdHY2b2JmQlBr?=
 =?utf-8?B?UWwvd3R3Vm5BUm5BSGlTR21KS21NYjdPQUJlZUtuVFpUUUtQN0pVekYvaEF4?=
 =?utf-8?B?aTdHM2Rub0REakFXb0ZwUVUwMmlYakd6SWR4U1JFZm9saC84QUdiUERMZkVx?=
 =?utf-8?B?QzVFV3hob04zcUkxYjgrc0hPc3MwalgrakFvOHhkeEtKZXlQZzlWVE1LeW9v?=
 =?utf-8?Q?nvCDiegsnljpWa1RygWDgVhx9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee74e2d-6cfb-4db8-1a6c-08ddb93badf5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 07:40:13.3944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSBLXdai5tDhAD2AB8R4K0KBd46oYmGt91iRz2VoTugXoobjUFTd8gxMUs/rgCRSWBK1HMlXuzpgBGFe7HNIEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371
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


On Fri, 20 Jun 2025 20:47:01 +0200, Jan Kiszka wrote:
> This reverts commit ae93d8106bdb5926efef9222d553adb295ebce96.
> It is no longer needed since 24b1e0c7e2e3.
> 
> Since the obsolete include pulled in byteorder.h which is needed by now,
> include this one directly.
> 
> 
> [...]

Applied, thanks!

[1/1] Revert "drivers: mmc: rpmb: Use R1 response"
      commit: 49666c41e9f956682490c409f540bbc21f35cb70

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
