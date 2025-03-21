Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE7FC35FF3
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A20A281DFA;
	Fri, 21 Mar 2025 08:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vJn1xjbz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95AE9805C8; Fri, 21 Mar 2025 08:16:26 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 500998141E
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwkCfiaKgRkbrNO6frvp1pl2oV+7TMW1yc0GGDIZ3Z1/DngbzKbathLjoSBlHIZO2brZdvZI/qpPOGWEyN7gQh5LxNh/D/4goWEZrEOo8TormEt0OJQ5lHWOAyGO7xJJjNxwGLuUqPWrorwtvwJQEK/pIKxvVMk8iFuT1Buvew3LM4QarzFxTYoaEeWT+GfeSqmwq0WD1hU0IQr3Pz4LJ7BzdJazOLLRknpl9MW8gF7pfKcrRsdIU6szPNKAT8GuH+uR8FhDEF9u2EFJmSbAb+yoEo8Kfs5kpchU9cNJtsWXVF034DRkpeKZ7hyb/+LEpTgksEJCuBTh3i5D770CdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEodqiJSL/Cf8Rx2z5QdD6oaeSvYSgxuq2pGs8S3zGQ=;
 b=MpQMj5Y+RhJbsS9OUZ+SIuhIlFM3i6dogN1zLKsS7qefmTW/p3etmakmYTzhe5fG+gta9d5Q7aewmSDiEebBTXyX1xQvIdtImFSReLX4DmcN7zjIYoetTpew57BUm6mMv++sMKHelm21mNxXoBizQU6yz6lJk3hX+h9FrOfZhmF6b4WsCTf052+MzY0YNTzuWpqwdZhZlUhyIUDjWcRv1YZGpwgvcOIC4H+Z1fXR6J++7ZH1agcFOMlXQ0MPqX6UDUtnlVrSAq2Man7Y28x9KoxHZkwEkD0jPU3PG+uNtr38J8jh+JO/Jo+aMbXQ+MhIH0aYlmSXBI3aHwI1hVB9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEodqiJSL/Cf8Rx2z5QdD6oaeSvYSgxuq2pGs8S3zGQ=;
 b=vJn1xjbz7gGX70OArNmD3TM137F89TH8siweeKPha/nj0i30WJT5HybSzujNYerEchtJFeGnuMlApXY2Tx1JkEIkOYDCHS3BST4F+9dvsdZodCIG+xYBG1jonMmL/zVIjY4jwXndwcKTAZ2DF5tAgEcuCtFpVDcmvuHX1T32E/IkQUHL9ExX95bfhT7lLE5hFXpkvOXzIdFVQFmOQa3+3D9pUUM7bK9lsAlI88M0Y9R/g3igraAJm7524k8xRIDKuGQsHemb3dK/Zd3smQj3aDI45mpXNX+kjnigV17JSjFeQpOzJPDrJnZYVmkJQBgi3EN0ATx1vhwxKXN3xbRtww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7421.eurprd04.prod.outlook.com (2603:10a6:800:1b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 07:16:22 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:16:22 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:21 +0800
Subject: [PATCH v8 07/19] clk: scmi: check the clock state/parent/rate
 control permissions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-imx95-v1-7-f2c8ba815f89@oss.nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
In-Reply-To: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 672337ed-3284-4f0d-a0d4-08dd6848488b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alpHZG9ENU9KQ09rc3JFVWFobmp1V29aOGhUNGFPandGaEltc3BiSzZ1eWpj?=
 =?utf-8?B?M2NzU3JkL3E2M0MrRVVtamZ1d1o5VVFmQzM1WW1id2V6TFNTMFR1dTJ0ZHZv?=
 =?utf-8?B?Sm5FUUNaTWp5MDdJb0FOdkF2Y1ljYlFEcmpvbU1vMFUrWENJVWo0VllJSHBi?=
 =?utf-8?B?WitzTFhndkNXNm43cSsyems1VEhnVWN0cU5OdnFGTEhIY1drNmpsYTI4bmZD?=
 =?utf-8?B?RkZhWGpUSjNOemRKTlJhdXFpc1lRd3Q1MDl5QlFpcXhTTUdhd3R5SzV5Uk10?=
 =?utf-8?B?SGdSNjY2YlBKYXh0SjlTeEhZbU1ZR1hwSFhzeklGcnJXWnBkelJyTFRkZ2h6?=
 =?utf-8?B?cHpkL2IvTWVwcmppbUtmdjJ2N3JRQzZzWStCU01BSzhubEVSSGNlMGcxcVFu?=
 =?utf-8?B?Q0dlbXlYOVpwS096Q3J2NC8zTC9lOFVhWmJoTkVrcWd3ekp3YUp3Y1FPVGVB?=
 =?utf-8?B?RkhYOW1TYWNwZnUvaXB2b2E2MnVpVWhSZk0xQkx2dEZLWHZjNzFOeC9lU2di?=
 =?utf-8?B?VVQ3SGV3OXF6ZG9RRG9lWnliVzJZS0VqTVRLVDJZbkZxN3RVU2c2MWljQ3l4?=
 =?utf-8?B?bkQxMEc1bTlYaGVVdkF0VGVhb1dZcXN2cmJPMjVwb1E4ZW80dlh3NVYzTk9u?=
 =?utf-8?B?cG1QZ2dMZVp4cFcvYkk1aFJHM1prcVphSXRZTEpHYTNkeDlNdGlHV2paRUJS?=
 =?utf-8?B?ellBVmRaM1VxMmNmaWovRElMZlNQTjc2UzY0cDU5VElSdXhvbS9tYkI2Q3JN?=
 =?utf-8?B?R3dJckJ1dUduQkppY2JMSURPMnJLUm0xZlYyZmZNRXhGd244QUR1eVZtelVD?=
 =?utf-8?B?YTQvZVNJL2hlN0M4L2pNOTlEWVg1V2ViVGNtOEFPcUNrdEw3Z2lpaFYxNU5Q?=
 =?utf-8?B?NzJ6YStTa2NOM0F4ZUJYRnE1TWhIV0ZZemM1U1RHVGpMZEFISHlzSGNXK2Nh?=
 =?utf-8?B?Qmo3cHI2bmtrQlc4V2lMVGFSalBGYUV1M3hXSGlvMms0ZkMxSGpnc1Y1OW5o?=
 =?utf-8?B?MEF0RXA1QWlHOTd4eEZ3YTN2dUFVcDdTMHpWRmZQUWJFaGdmWDF5Rm16RzM0?=
 =?utf-8?B?bVpBVjFKcUNVWG9xUDBpRWZFRVVEb1JDSW4xM3Rjd1NNcHl1KzV3cFYzNmZm?=
 =?utf-8?B?bjlxUi80MDJVQ1RPSlNhc2Eya3lYWGlOQTVtTWtSck82MFFzR05WeVVLMUY2?=
 =?utf-8?B?NVBLY0RVK0xvVTRCSEV5Rk9VQU5KSHhsUlJtV1l0d2RFWVdDT1V2ZzRsYWpB?=
 =?utf-8?B?MDZnYmQ5MHlXVFRYUkJJSSttbkljMkRvZlNIOFhTa3BjZ2ppVVBJLzk1TzRQ?=
 =?utf-8?B?eUtYSHZIWkY1OGk3aEd5aEF2RHhXaUV5VzBiS2NhZWtHZnVLcGxYTlIxQ1Y3?=
 =?utf-8?B?VjhWTmh1T0tYSi9PK29scEtEMEV0Vk5UdklTTEJydmp2NnlSblRyN0Rqb2ky?=
 =?utf-8?B?UE84bjBBMTBJTHQ2TDhSbFBYTzRveUMwS2RlTFFpYk9rbFFxa0RDK2hjeVhJ?=
 =?utf-8?B?L0ZDK0JIQjBLcjg3cmFrMGhHbk43SEVvZm85dThrZmJGQnNzaVJSRzV4ZCs0?=
 =?utf-8?B?UFk5eVF1U01zMHZtaFUxbU13ZXMwVWtnWjhGdTZhZGE1aGgxU0RxekgzN0hQ?=
 =?utf-8?B?bjRuVDBSRDB0Ny9uWG9iQjAzUmhuWW1MaGwrd2NPUDVQUHE1eWxHS2c3ejFL?=
 =?utf-8?B?VlF4ZmZXR25kbmVNS2lkTjlnUnBiMVZIeFRJU2JxcCs1V3p3aDBUVnlDbGdZ?=
 =?utf-8?B?N0hRTldNRGkwN1FtLzVvazlIUVNBMnlYemMva2NRUWdxK3k1RkFEanRlSkFK?=
 =?utf-8?B?bFhFMHlWWmpzMFE4cEVJeVYyeUhPckFja0JFRTZlWGd6aDdKTXE4N2MvS2VR?=
 =?utf-8?B?T1FuMFlzVmZUNmt2a0ZtaUc4a3psdEZYUTd6bmNYa255NHlLWjlsZnM1Rk1X?=
 =?utf-8?B?MTJXUXlxdjJXTlRIOHozdm1yVVdxS0d5QkV2aXJaNWc0emxwemk3NHN2cnpH?=
 =?utf-8?B?R2d3aUtIOG53PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHNmL2MwY21wdW9BTGtzeU5od3NWM0hmWXlGK3U3SmV2eGRKc2xBNWZYTGFs?=
 =?utf-8?B?a3EvRjdjT3ZZSTlJZ0J0eWNrdmtSRXpHRFVyVTcxNHlqQ3R5Q092bm9HMU1C?=
 =?utf-8?B?dDFKdkZGRmFhRG9qbWJyaXY0VWkvWU40R01ncU9tSCtCNFFIYk9PN2tmdVVW?=
 =?utf-8?B?V0R4bWg5RzE5akNDR3ZMek1VMEdMOVo3V3VxV2hQSGJOVW5pZFRiSENRM2VP?=
 =?utf-8?B?RXkxQzhLMDJ5ZHNUa3E4NjhCWk5KYUFlVjVIbVdRRUFxR2gxRncwNW40MEtP?=
 =?utf-8?B?S0xXa3E0c2hoSlNpUEVUendETXJpRWVDOS9CWm9OT3RTLzhjcUtaZ0N4Qkxh?=
 =?utf-8?B?SkVpTURPa1pMZTRJSDVHRk4rV0YyY29mVktISFA3Zk1KM01XU3ZrbGQ5NDRF?=
 =?utf-8?B?UzdxSGxEVFlIWDdzU2pMQlI3T1J6TjRHUlVoYkpRRUJCTmNMUWphbXBCeElx?=
 =?utf-8?B?aUZrT254SUlPTUxDZmxOQk4yUHJTK0dZRXR0M1FLdmRxZW5PRjZjdkd1QWlP?=
 =?utf-8?B?KzdUdFdVSHN6UHlTS3gxZ3lIME9DZzJ0bWIwQkhlcEloZXo4eit6VmV0TkRP?=
 =?utf-8?B?ZVJrSVA1UTQ4c3hwNGF4VGduWXhocVZKMmcrcldRTzhrWDh4cHl0djNoNlVW?=
 =?utf-8?B?bzRaSjFvRVA2M0wycnF3U25UbEQwbml2YXdxWG4xc3pUdlBLek1VckgwQ1Zk?=
 =?utf-8?B?RXJpUnNEN3d3RWtiMFV4ODJjdDBJWGNDaGRoZ3ZKVENhRDRDdG1rM05jZnZo?=
 =?utf-8?B?MmNRWnBiTmo2VFY3dnliOENjRGFldjhMZjVpWTBTS3ArS2tlbXF5bXBXbGNr?=
 =?utf-8?B?bWV1VUUrRFcvdU1MRm1vOXNmN296MTJhZm9zY09kYTd1Y20zMXFtaFpxL05Y?=
 =?utf-8?B?TXVoc1RXNU05VloycUtBcU5LUDg2Z01iRzNPKzU4NUNIc2gwZDBNWkpSTFJ0?=
 =?utf-8?B?eXo0WFBSYUxMbUtqQ0VXcGQvaFlxOFNzNnNxb1pnazN6L212UE5wdjlOZHlH?=
 =?utf-8?B?UW5JUnFsZWFFayszV05sQnY1RVoxb2M3SjliOXFaUW1BRWlNK1o0UkFBdGtl?=
 =?utf-8?B?aDhpNnpBdS9mdHd2dVdWeDNHRDhDUHJVS20vZVNRN1ZKQ0JjTVhTdGxIUzhE?=
 =?utf-8?B?U1IyekZiZDdoT3JSbVNXaFJwVnBMUW94TXFja0ZBa1drVm1kdTFqZCsvRzRz?=
 =?utf-8?B?ZzE3UloyZ2dicUd5dTA1bXJVOGh5bzhpVHpzY2pxTW1CenBaR1JwY0taSG9w?=
 =?utf-8?B?ZUtNNTRHOTU1Ump5NytXdnZoRG1UOGJ2dWdOam8wZ3Y3R1h6MnczM0Fkelhh?=
 =?utf-8?B?Q04vWHhtRnhXSHRQZGhhUlV2VmJLcHFxaUorN2RwRDBwRGtydWJkTFBKRVdW?=
 =?utf-8?B?MzhRSUY0MmRoYm1ndk5KaXk2QmM3UnRQUlp0aGZMbGFOcXd3aUhHNkVsNVlx?=
 =?utf-8?B?UGY2SjVPd3JaejU1ZTNzNHVPS3piWUIvbU84bUFiTGM4MGp2Nm1aT0dYSGd1?=
 =?utf-8?B?MG41Y2hwYWNCQmdMTnU0dm5hU2NQeUdBTUdwYm5JUkp1OS9CSk83OFFEVWc2?=
 =?utf-8?B?UHZNR2VKOWlENEFyaFdpTWdtbnIyYjRhTENtcFBqQU5RMkpSN21JSzBHejZr?=
 =?utf-8?B?bTdjeXZxZUJDeHJHNW1nY0g0ZUZobjljaEhmVEV3SS9LbWVVYnNubWJCWTll?=
 =?utf-8?B?UGhYUU5uY1BpK2QrQktPR3Q5UmJGaUozZ2t2c3FXVmNDTHF2OFJpaG9PaWx4?=
 =?utf-8?B?bmxUSWhLWUR1TmcxRUh5QXFNZjhvdWdQRFEvMG1pNm0vZlhFamZUby9wZStr?=
 =?utf-8?B?UGFDc0ROdG9iNjBiVk1mRUJmQng0TE1vZ1VUVTYxVG85MlJzdk5TOUJMQzc4?=
 =?utf-8?B?MURIOVJUektaMVNld0kya1hnbytxRjhmN3hEMmtTNDlEc0FPbTNtaGFoWFJC?=
 =?utf-8?B?UFBoaFFtWGszOWh5UTJPb05YVVcxdjN2c0tTdHR0V0lUZmxYNkd5TjVrQ1pL?=
 =?utf-8?B?Z1BiTFpxc3Y1c1JFdVMwSGVGS0tDODJVb2YxWnpndW5LMDVUVzkrWmp3Vzdw?=
 =?utf-8?B?WU8xRkFiREJ0N2U3dktOdXhyMkpGYU1FTktzMXNrM0htNFc2MGR3QklTcFJX?=
 =?utf-8?Q?EkMwDRQ08aASfLXayGLurZhGH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672337ed-3284-4f0d-a0d4-08dd6848488b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:16:22.1642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loXoKPN+2DyS2QQTDRxZCUtz/0dpvEVpJef18e5/0luu7POTvPMJ595Zdv+CP24ZHAGKfubI+foZalbdzKg4Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7421
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

Clock driver based on SCMI clock management protocol in Linux checks
clock state, parent and rate control permissions. To be consistent with
the kernel driver, add this check here.

When using common clock framework (CCF), use the clock signal ID to get
the clock registered by clk_register() in scmi_clk_probe(), and then
obatin the struct clk_scmi variable with container_of().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk_scmi.c   | 173 +++++++++++++++++++++++++++++++++++++++++++----
 include/scmi_protocols.h |  24 +++++++
 2 files changed, 185 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 84333cdd0cc..d120c1eba06 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -12,6 +12,56 @@
 #include <asm/types.h>
 #include <linux/clk-provider.h>
 
+struct clk_scmi {
+	struct clk clk;
+	u32 ctrl_flags;
+};
+
+static int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 *perm)
+{
+	u32 version;
+	int ret;
+
+	struct scmi_clk_get_permissions_in in = {
+		.clock_id = clkid,
+	};
+	struct scmi_clk_get_permissions_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_CLOCK,
+		.message_id = SCMI_CLOCK_GET_PERMISSIONS,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+
+	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &version);
+	if (ret) {
+		log_debug("%s: get SCMI clock management protocol version failed\n", __func__);
+		return ret;
+	}
+
+	if (version < CLOCK_PROTOCOL_VERSION_3_0) {
+		log_debug("%s: SCMI clock management protocol version is less than 3.0.\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret) {
+		log_debug("%s: get SCMI clock management protocol permissions failed\n", __func__);
+		return ret;
+	}
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0) {
+		log_debug("%s: the status code of getting permissions: %d\n", __func__, ret);
+		return ret;
+	}
+
+	*perm = out.permissions;
+	return 0;
+}
+
 static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 {
 	struct scmi_clk_protocol_attr_out out;
@@ -32,7 +82,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	return 0;
 }
 
-static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
+static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
+				 u32 *attr)
 {
 	struct scmi_clk_attribute_in in = {
 		.clock_id = clkid,
@@ -53,6 +104,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
 		return ret;
 
 	*name = strdup(out.clock_name);
+	*attr = out.attributes;
 
 	return 0;
 }
@@ -78,12 +130,48 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 
 static int scmi_clk_enable(struct clk *clk)
 {
-	return scmi_clk_gate(clk, 1);
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return scmi_clk_gate(clk, 1);
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+		return scmi_clk_gate(clk, 1);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock cannot be enabled by the agent.\n", __func__);
+	return 0;
 }
 
 static int scmi_clk_disable(struct clk *clk)
 {
-	return scmi_clk_gate(clk, 0);
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return scmi_clk_gate(clk, 0);
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+		return scmi_clk_gate(clk, 0);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock cannot be disabled by the agent.\n", __func__);
+	return 0;
 }
 
 static ulong scmi_clk_get_rate(struct clk *clk)
@@ -108,7 +196,7 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
 }
 
-static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct scmi_clk_rate_set_in in = {
 		.clock_id = clk->id,
@@ -133,9 +221,32 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 	return scmi_clk_get_rate(clk);
 }
 
+static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return __scmi_clk_set_rate(clk, rate);
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_RATE_CONTROL)
+		return __scmi_clk_set_rate(clk, rate);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock rate cannot be changed by the agent.\n", __func__);
+	return 0;
+}
+
 static int scmi_clk_probe(struct udevice *dev)
 {
-	struct clk *clk;
+	struct clk_scmi *clk_scmi;
 	size_t num_clocks, i;
 	int ret;
 
@@ -156,29 +267,44 @@ static int scmi_clk_probe(struct udevice *dev)
 
 	for (i = 0; i < num_clocks; i++) {
 		char *clock_name;
+		u32 attributes;
 
-		if (!scmi_clk_get_attibute(dev, i, &clock_name)) {
-			clk = kzalloc(sizeof(*clk), GFP_KERNEL);
-			if (!clk || !clock_name)
+		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
+			clk_scmi = kzalloc(sizeof(*clk_scmi), GFP_KERNEL);
+			if (!clk_scmi || !clock_name)
 				ret = -ENOMEM;
 			else
-				ret = clk_register(clk, dev->driver->name,
+				ret = clk_register(&clk_scmi->clk, dev->driver->name,
 						   clock_name, dev->name);
 
 			if (ret) {
-				free(clk);
+				free(clk_scmi);
 				free(clock_name);
+				free(&attributes);
 				return ret;
 			}
 
-			clk_dm(i, clk);
+			clk_dm(i, &clk_scmi->clk);
+
+			if (CLK_HAS_RESTRICTIONS(attributes)) {
+				u32 perm;
+
+				ret = scmi_clk_get_permissions(dev, i, &perm);
+				if (ret < 0)
+					clk_scmi->ctrl_flags = 0;
+				else
+					clk_scmi->ctrl_flags = perm;
+			} else {
+				clk_scmi->ctrl_flags = SUPPORT_CLK_STAT_CONTROL | SUPPORT_CLK_PARENT_CONTROL |
+						       SUPPORT_CLK_RATE_CONTROL;
+			}
 		}
 	}
 
 	return 0;
 }
 
-static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct scmi_clk_parent_set_in in = {
 		.clock_id = clk->id,
@@ -197,6 +323,29 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 	return scmi_to_linux_errno(out.status);
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return -ENOTSUPP;
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_PARENT_CONTROL)
+		return __scmi_clk_set_parent(clk, parent);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock's parent cannot be changed by the agent.\n", __func__);
+	return 0;
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 342a65ae7f4..519b906b4ce 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -731,6 +731,7 @@ int scmi_pwd_name_get(struct udevice *dev, u32 domain_id, u8 **name);
 /*
  * SCMI Clock Protocol
  */
+#define CLOCK_PROTOCOL_VERSION_3_0	0x30000
 
 enum scmi_clock_message_id {
 	SCMI_CLOCK_ATTRIBUTES = 0x3,
@@ -738,6 +739,7 @@ enum scmi_clock_message_id {
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
 	SCMI_CLOCK_PARENT_SET = 0xD,
+	SCMI_CLOCK_GET_PERMISSIONS = 0xF,
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -776,6 +778,7 @@ struct scmi_clk_attribute_in {
 struct scmi_clk_attribute_out {
 	s32 status;
 	u32 attributes;
+#define CLK_HAS_RESTRICTIONS(x)	((x) & BIT(1))
 	char clock_name[SCMI_CLOCK_NAME_LENGTH_MAX];
 };
 
@@ -858,6 +861,27 @@ struct scmi_clk_parent_set_out {
 	s32 status;
 };
 
+/**
+ * @clock_id:	Identifier for the clock device.
+ */
+struct scmi_clk_get_permissions_in {
+	u32 clock_id;
+};
+
+/**
+ * @status:	Negative 32-bit integers are used to return error status codes.
+ * @permissions:	Bit[31] Clock state control, Bit[30] Clock parent control,
+ * Bit[29] Clock rate control, Bits[28:0] Reserved, must be zero.
+ */
+struct scmi_clk_get_permissions_out {
+	s32 status;
+	u32 permissions;
+};
+
+#define SUPPORT_CLK_STAT_CONTROL	BIT(31)
+#define SUPPORT_CLK_PARENT_CONTROL	BIT(30)
+#define SUPPORT_CLK_RATE_CONTROL	BIT(29)
+
 /*
  * SCMI Reset Domain Protocol
  */

-- 
2.43.0

