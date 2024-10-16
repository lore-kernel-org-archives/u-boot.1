Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58547D206A5
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28FA188E18;
	Wed, 16 Oct 2024 09:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HYuIzPQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7161888E11; Wed, 16 Oct 2024 09:19:44 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85E7488E19
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsG1ZqkvR2jprz4Fy/wP+v7VkD6HX5gvy6RLmS1EkniXJOGPZxhZANMtUX/AMm0c6PfXXahXFArrNNhGXGvpwAb43sEXE1A+6Kwbt6cpfGY3gU4O3+VwqUbR1i4Y0esAce+8ee/qaoca9cNWIGQ3sHOm76oLqyO6kGccHC8DLKS4zQIIWrA8Mc99KJSs9n4pjT3TJPXGJJyHNpl+ufd27IW9QwqLBwOU5pJ6Ad70zBm639y4RV1ap9xG9ZxDSpo0BpBPwrXS8Q9jP5bWbSmLl8WCR/RwamKnZQNiXzgbg6Ny1D+KoYkKrJiDD/D6HQTJjDJ628j/QDv09EkUaHpxHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U8wfdNPzExHN6f4s/lmeRIWv9K5RqS5JOkb4aiq1DI=;
 b=UvLuk13YvMs7+noj/DS/kx1neGWhItIMyFux5qZF5F+p+XKMv525cACAw29ts8zriuJRFkPd5PIqL9RbArg9chO71Rj4hMzVd1RpqmIILxOJDDzvNgDZSOtjUvikCx/dZyCUPONj+WqjaRh1wHgDrOrOliSLPaF4RVATzkrPBm/qlZrmazJRq0jAuS/huL+B4d6rgQoVdIPz3EuRhtifRinIf78IpfnlZVrHMLSA4PBXuEY63KSC+yIOxMOUEX7nkfSRwLfHoPn1N6tv/m8SpoZOusHPLtz5g+hMLAknaAR3u7izim4QEzcP8AbIuAooYanymT3mnAyPwpGT+aJ8Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U8wfdNPzExHN6f4s/lmeRIWv9K5RqS5JOkb4aiq1DI=;
 b=HYuIzPQZYoAGGmIj3oWg55ggW/ISG7OU4Qv+f8lRxVN+Juxr1qJMBulgDLzXXeF5v/mTBxtiBaWYDUKOK7kO2QTDb/qREE2B+emfejEOGsjOcn0e2Y5r670f2UTSgtqRZAdPPJZq5kZeoa1zxNUNojTvg60B88lFvWGjQ8MXbsRJJLWbsGrKRCsO/17seC953Wy9KrHp/8ICzI0bwXW0Yf05OqyG40+ADVcvrF8xT3Uk5BGZdvoLPAs/uCSswsJbyZYgeKBZptu9EURgHwFi5MT1s17jnkp68UhFlN/U7DbvCCXLELcPe4YeWzpcA51q7SrmNeplIF10zNk4X/InVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 07:19:40 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:19:40 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 16 Oct 2024 15:18:04 +0800
Subject: [PATCH 11/17] imx9: scmi: soc: Override h_spl_load_read with
 trampoline buffer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95-v1-11-f640c8f3bc1b@oss.nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
In-Reply-To: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Alice Guo <alice.guo@oss.nxp.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 98af9dfd-f79a-4ec9-ee4a-08dcedb2e667
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aW5qdG8zZHNwSDZ2NVFiVHlKN0JyajVRdDA5dmNzWlMwWHI4RS9oMFkyd0R4?=
 =?utf-8?B?bnh2RDZHY0p5T0FXQ2hjVHBtNWVDSXFiSTNFYWk2UThacEJRaGlqWkQxelZT?=
 =?utf-8?B?TW16d3ROOVZYUkozVEhiNTNmL1BkeGw2blM1V01NWDFZQnRoVWVQNDZYSHdz?=
 =?utf-8?B?NUc1TVV1Sy9TSjZDYnpkUnM5ZlNmQ09IVGhXTi9ySnEra0dpRFFSam5DSHV0?=
 =?utf-8?B?WEd0THFPN2dldEd0ZnEyQXFTY3cyMk1JNXRDL1pPeVh4S1Y0aXZiN01nYTRL?=
 =?utf-8?B?VTg4Z2tGU3VaUzFyeVYzUGlNd0JEejRSc2ZBRWt6L2k2Y3FLUG56bGRsR1JF?=
 =?utf-8?B?d2lYS3VoSm5YanRkWjByQVdVTkRnYWNINzNBQy9MZkdCTC82bTJlZENFM0Fu?=
 =?utf-8?B?MXl2cGRtWHk5Nlg1TWNRT20venNKb3hKWGNQRU9iUUh1VmZMRDJEcStLOEZB?=
 =?utf-8?B?cEtsb2xOdk00eVlVTlFHYjJONDErOGt0Y3hFdkljRFN2dG9Wc01aTEYvSTJ1?=
 =?utf-8?B?SkMzMHlnVUpLOU5PS0xaVGdEMnQ1WGNrWFdleUpOVWxPN1pmczZ6eW9ST1BZ?=
 =?utf-8?B?S1gxbk5ocjdKZXJQUnl1eS96bHFOS3Zud0dFTDg4WmtnWHprTU1iZ3lqZnNl?=
 =?utf-8?B?dTFaWUpwY0lNZWZmcVFCdCtKTS9sTjlyaE1pM1BiSkladURZUjgrUmVBZG1x?=
 =?utf-8?B?OTlVcUVFRzZXM3JPRmNtNUM0QVp0WjJYTVF0M1FvZ1NwWUEyK1FIVUlrNHdw?=
 =?utf-8?B?bUMyVjhZTFJHTVVEeGhMZ0E1cllFaU1vY3ExR2M5SE0zVG53YnR1RUt1RnJm?=
 =?utf-8?B?aVhheE16d0pmeUgrZ1RjSnRYU2M0T0ROUHFsaFVrckp2OWtEUFBLTHdkMldq?=
 =?utf-8?B?UVhjcHQxaFQwSzJLQ3Bhek5vMEFaaDBFaGxYVlErN1lYN3Z3Y3FPQVlIUS8w?=
 =?utf-8?B?SkQ5Zm5WcE1QUkl1VmI3K2dvQ2tEUk03OEkxdElHYUZzTkdINnhqUkxJeVVw?=
 =?utf-8?B?cXlmdG9HUVZJUEpHS2RyU2FtQmNlWWtSTmE2OHdlMlZFR0c2aGtaV1FvYlhE?=
 =?utf-8?B?RHNpMmdEVy95VDZBN0ViL2pkbzRGMjVsUUM2WjVsNW9zUjZaYmdlOEQ1M3d2?=
 =?utf-8?B?TXNoamN3aC9oY2pXMmlPUHhtMlZCQlRwamduM3BTM28wVWVDOUQzS2E4bGlQ?=
 =?utf-8?B?Q1RmSlIrV1pGdWxhZjhnSmF2ZzRUS3o1YXA2WmRici9leHJZbU1JWG1Fbnpk?=
 =?utf-8?B?TEI4dWRLWGpncmxDaHN5OHpaTWE4cU8xMEM2b3hMVG5YY2hEbVFzRSsrSVB3?=
 =?utf-8?B?QTN0RUVTTCtVa1JHTUdlOUplZEZ5d3dMMDJnWG5QSmNEWk1ERHRHWGIyMGRE?=
 =?utf-8?B?MHpkYS9Fb3pDeE94UFpUUURlaHpUK1ZmRUZWZU1lcjFMUVpsWElGeXZpdEVY?=
 =?utf-8?B?c3dPRHkxeWZUQXhzNFN5VDRNSTRqS244Tk9rKzYwNHdGRk4xVTU3OUd5UTdx?=
 =?utf-8?B?Ly9mdUZhbVRCL09aMUVjUExoRDJSc3NGYzgyQm5UWkhRWkRFdmZHSExOU1VQ?=
 =?utf-8?B?bTROUFI4RVdGYnJzWnI5MklTQ29oYnIvQ1VMc2ZNbW10WUphY1ZmN3c3cmlZ?=
 =?utf-8?B?dFZnS2tqTVlSNkFpNVpBN2J2VjVBUlBBai90cjd0cE5BN0FVYWxlbFBWN2Nu?=
 =?utf-8?B?cTJ5MG1CUXY1Z1hNN0M1YWQvWWNvNHl3SGlqc3BYRVpta0pEeXVsYWRoTUtu?=
 =?utf-8?B?VDNieXgweFJEN0laOUZLT3VzQnI3SUdhOTlkQTR0b01Db1N2eDZTZlpjUkN2?=
 =?utf-8?B?aDNxcENOallRMi90UGU4Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ci9pTmdMbytmcDVJUm1DdGZzUnUyWUM5enhrU0FCTE03YkVhMnFnN1FPaG5o?=
 =?utf-8?B?aTdnRkY1VkZQVG5zYkFhQzNJMG5FK09uTGw2cXA4QnFDdzk3bG52dTJZVGFu?=
 =?utf-8?B?bWFGVlFESmFMRnJFTndjODBiNFR1QUZoUFJkc2xWMkdsaCtwYVhuRWdVMVND?=
 =?utf-8?B?Zkp2Tm9HWmtpMzFFYVJvRkpaK0R1T0ExUWVIem1ISWcrOEppQ3dNT25XRlph?=
 =?utf-8?B?Mk1OeHJQd0lTbWhNVWVjaGJ3Ym1NU1laKzNad3pvN2psSWtuS0ZNOWRTdG5N?=
 =?utf-8?B?dEFxU2ppMFF0MkVkYVhuSkh0VGJJaU8yNW1JbXlnT3ZwQWZQMG9jTi80RXNQ?=
 =?utf-8?B?Ui91Y29BRCtmTFIrQmZWVU9TenBWTmRXY0lneHFRbnQvazZEcDd4aExlUEI4?=
 =?utf-8?B?eFp4Y3NBdXo1cXZWZnFnNCt4dElGeUVHM1BacXNqc3RWcnZMbFNtK3JTd1V4?=
 =?utf-8?B?RDBKS3JjM1hTZEQrWHhWa0NsUFg3czdVZmN2M0dNaGxOd1Rpd0pQVmdQQjBm?=
 =?utf-8?B?aTc1NG9zNE02ek1kUmxKWGhkN1FTNXpOSWRBbkZGMDYzeUozNG1BVDZXODVz?=
 =?utf-8?B?TzY5NFpNcjdHV3NvVjUreHgwS0c1aVlvckJEekhDd0x1S2VKSmNRRnkvemtn?=
 =?utf-8?B?WklwOXBhN2cyU01mZWpBMG5Kbk93dWJJVGFxOFBZaHNaci9PdDBsR1Jqc3JP?=
 =?utf-8?B?aE9LS0R6SUlONHpvUHlUdE5XUGdOTE5YUW1LV3dLSVk0K1cyWmtBVzZiRE13?=
 =?utf-8?B?UURjRTMxTG1XY1NxVDJVUjVyRTFGU0ZwNkdIV1NaTndxa2YxajJmYUZvblA2?=
 =?utf-8?B?K0EvWGxiZVVHd3JOZVVPWG5CN2Y1WXIzcHBzdElWVnJuUFJOYks3T0dONHhT?=
 =?utf-8?B?QS9FazdwdEFrK3RkL3cvRVRUSjdLeWxvay9QWDN2dDRkL2VnOERVRWJKNUo2?=
 =?utf-8?B?L0NHZlBydzBNY0o4cHNjbDBDRXczekxLMUdJazB0UmpzUUNwY2IzRnIrWFRZ?=
 =?utf-8?B?eXlITFJRdGk5a1d6eS9Xby9UZERFQlpzU2xaNlRROVI2ZmdVWnVMRlQ3dTZM?=
 =?utf-8?B?R3ZnZGhqaEcwNGFMZENVKzNXWWVKbC9JUldnRFlWZWtIYUVLYUl4M1dQb1Vo?=
 =?utf-8?B?SDNWZyt2dUk0ek1tVENuRkZWZkdVc3ZMVHc1aGNRZW93a2VScXNJZFI5MDFs?=
 =?utf-8?B?S2Z3S3Nzc1pNRDB5ZzltRkhtS2tVRENKNG9wN00rN2NaMFhKcmJiVFluWGkz?=
 =?utf-8?B?eTJYTWp1eE4vbU9idjIyY0c0NzZ3NFUrQlhNSlBwR3JmTUZ3NG1zT3FtY1hu?=
 =?utf-8?B?bCtLeUdYeWpsYlY0enRrRFFMSlp6NzcyOGFqNmF1V3JBdERwR3I4L2x5cjNm?=
 =?utf-8?B?S1UvWFBlRTZ1anZJZXc2Z1psYnZjaERPK0UxU2hFaVVVa0FNNWRrNGc5Z0wx?=
 =?utf-8?B?R0llaTh6VnV0N0tkZ0pKZ1ErM3V5VkVBbkxEQlJURHFiZitDQ3RRbVRKak9a?=
 =?utf-8?B?ZnQ5ZXdmYkNiSjFPdEtsbmh2SVBQMitvMnRSb1JLN2lHNTB0eEJlUGZUTHhr?=
 =?utf-8?B?eE5haDlHVEhRWldLZUdheUNNWnQxZGlVS3VIZEVQcllIcDlteDBlSjd4dkJj?=
 =?utf-8?B?RytDd1hwMEFPbkwrb0puQ2tSL1E5Zm50N0JiOXR3SExVTHR3bmNGUFRhbFM3?=
 =?utf-8?B?aTgzeHd2OTIwZlJQU3lrdzhtbDd5NStVS3RXQVZTTlB4SDBqUnB1akIySW4z?=
 =?utf-8?B?MnZxWHpONXYxdEQwS1pERkZrVzBuSXR6cEZnWUdmdG9JdmVjeFZaaVhaSG95?=
 =?utf-8?B?WlhEYzJnWVZsYXNFbXdRVTZ5WFVuOUwrNTcwbTNVRk5mSHJOVE1nWHFoUDEz?=
 =?utf-8?B?OGxvSHVCUXYwUEUxY2tyL3FuUlhYQ3dpZ3FYZTY2c3k0c3FQNGdMaDhxNHBB?=
 =?utf-8?B?V0dSWWNKN08yakFkNzJnRjFBc2RUUndTMFlhb2RvQVhZRXRTL20xM3FVRXEv?=
 =?utf-8?B?eDRGYldoaDF1UFVvdGFOcXFzdndvbTlwRENMb3UyR25mb01yb1loQ2ljcWx4?=
 =?utf-8?B?a0t2WFVHM2VzZkdhK0xPcHlvSTNiMSt2cjhwb25FVHR0ZWJhRndoT3hJNm1R?=
 =?utf-8?Q?XitYZDwT6GINeQGokl+ZNPIby?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98af9dfd-f79a-4ec9-ee4a-08dcedb2e667
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:19:40.6581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: razCwP5vIdz1TzmcJFtnrwJVpfR/czKatbqarL76Bw0rcsjC+ddHnsCBdCM0CBDopC1qK6BNBK0VYtZeNkJtpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
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

When SPL loading image to secure region, for example, ATF and tee to
DDR secure region. Because the USDHC controller is non-secure master,
it can't access this region and will cause loading issue.

So override h_spl_load_read to use a trampoline buffer in nonsecure
region, then use CPU to copy the image from trampoline buffer to
destination secure region.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 40 +++++++++++++++++++++++++++++++++++++++
 common/spl/spl_mmc.c              |  2 +-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index fefb1a6f4ca58722a5d93c39e4f6a7aaf85aa177..8a7df24afecc1d6d77b7162be639b56af95fd975 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -41,6 +41,8 @@
 #include <scmi_agent.h>
 #include <scmi_protocols.h>
 #endif
+#include <spl.h>
+#include <mmc.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -830,3 +832,41 @@ enum boot_device get_boot_device(void)
 	return boot_dev;
 }
 #endif
+
+ulong h_spl_load_read(struct spl_load_info *load, ulong off,
+		      ulong size, void *buf)
+{
+	struct blk_desc *bd = load->priv;
+	lbaint_t sector = off >> bd->log2blksz;
+	lbaint_t count = size >> bd->log2blksz;
+	ulong trampoline_sz = SZ_16M;
+	void *trampoline = (void *)((ulong)CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE - trampoline_sz);
+	ulong ns_ddr_end = CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE;
+	ulong read_count, trampoline_cnt = trampoline_sz >> bd->log2blksz, actual, total;
+
+#ifdef PHYS_SDRAM_2_SIZE
+	ns_ddr_end += PHYS_SDRAM_2_SIZE;
+#endif
+
+	/* Check if the buf is in non-secure world, otherwise copy from trampoline */
+	if ((ulong)buf < CFG_SYS_SDRAM_BASE || (ulong)buf + (count * sector) > ns_ddr_end) {
+		total = 0;
+		while (count) {
+			read_count = trampoline_cnt > count ? count : trampoline_cnt;
+			actual = blk_dread(bd, sector, read_count, trampoline);
+			if (actual != read_count) {
+				printf("Error in blk_dread, %lu, %lu\n", read_count, actual);
+				return 0;
+			}
+			memcpy(buf, trampoline, actual * 512);
+			buf += actual * 512;
+			sector += actual;
+			total += actual;
+			count -= actual;
+		}
+
+		return total << bd->log2blksz;
+	}
+
+	return blk_dread(bd, sector, count, buf) << bd->log2blksz;
+}
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 1f69659321620739d066bd806acd1d282b66bad3..d15a6945f9c24ee427b847c036413c52475c44a8 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -17,7 +17,7 @@
 #include <image.h>
 #include <imx_container.h>
 
-static ulong h_spl_load_read(struct spl_load_info *load, ulong off,
+ulong __weak h_spl_load_read(struct spl_load_info *load, ulong off,
 			     ulong size, void *buf)
 {
 	struct blk_desc *bd = load->priv;

-- 
2.34.1

