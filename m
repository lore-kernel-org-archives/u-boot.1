Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDC3D358EE
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47A1A83EB7;
	Thu, 29 Jan 2026 10:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QCtfQ1B7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9122383E52; Thu, 29 Jan 2026 10:39:45 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE6F783E52
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1rhL3wDThUgpnA1r/PE4RCakP6Bv7fQ3ql9M9Y8rxzVXWdQQv0oUp28eppExVBY0el6pQGsosaS7kUtWpMWBr5p7Q+5ZKiZcvEWGRi9EGXrfckUMvBeLlVt38SBLhWDohZmi/8GpoklhvPqLfbALkvBBuokkLExUlWk4EA0AsW1HpIexFpRfSbpKDsumzLjN26VOtuaUTnzLIA9bxnJBU8wgVW+1+ILclh+7VWuy8wrFYLilpGb6lphDi+cpkdJc92OZav14g4hHhoiiUZE1G7fAWpf1dRhsjSmAgPXyn6h/lc2ZlDctQuN4scj/D7j/nM7B1Wpic5ZY2x/tQx+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzSPYp9voSeq5BEJOKfvGgKOgs5nEiaI3FVhg+Qv7Kk=;
 b=OGV1kt9B8/AUEg6wYHNJxZPe8hsaHa9WEirYDKCAE5hGToVdvx1QS/pt3ePj9FjZiY+U4Sb7B+gCUKD1oU+ZP5LxgHnojnzbfOUKLH3tth9jpae9Cdoru2F56IqrAWiCtea/rU/CFdlKRUbM+93Pujpu1jeKSs4f8fHhoysqfMNX2cezRbikIDt8It3+uqWacSWgzxPpYdBF2e9ksvBtDfGun78pQA0JFWXOI6BCz+K3bTmkrb63dRW2JXd6qHEkmNUpzSUIeshyIJ69KH2szPyReUz/R9VldFFS+F+OHCPbMhbTeTfUPWmCXv1Yy0yM8vtBzcxwh7W/M55ttF8TUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzSPYp9voSeq5BEJOKfvGgKOgs5nEiaI3FVhg+Qv7Kk=;
 b=QCtfQ1B7H+nizxHM+pHN+HQ1t87r1pVUpMZ0nGPe4gJ13faWYrf1zkChgvJnHh2aTKa61715S4mc7KDlb3/JBCd75NcvJLz+mAIjG5GGamqEWZURm79kGFFLE7/g2fRHrelNEPkE29d4SWmkPzqVDlf/Nt0TJefc3GOHCASOlN/w8wNu5Qv7LHXM7zDV+bjiSw8KmwwNbFdd+95jjG5PCL3rja2BnEiYFfyAVQDhndMEgxUWVzSoG4oXThapBC7FdL7eQpTSExR1VCcVrVG0Hd+kSI65Jz84vfflhBrKQ1yZD7PMj2MB2GbESzkNrtuY7qjCqPCubOZ727Uq+al+NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10384.eurprd04.prod.outlook.com (2603:10a6:150:1dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 09:39:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:39:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 29 Jan 2026 18:54:07 +0800
Subject: [PATCH v2 05/12] imx8mn_evk: spl: Drop DECLARE_GLOBAL_DATA_PTR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-imx-clean-v2-v2-5-1245ad2c3a01@nxp.com>
References: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
In-Reply-To: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10384:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da40d17-eba6-4ac1-264b-08de5f1a5259
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFVPMWNkbFU1SUQyVEpXZVM4TmptMTV4UVJOckY2eUQ4R21HNEowMVJ3T2lF?=
 =?utf-8?B?YmcwMUhjQ1dQYmFXVnFVdGRUeC8xUVM2Ti9INjdzQ0RYTTB6RHpFUm9WN3RY?=
 =?utf-8?B?OWorL1lMUWVFc0RRaFhPS3NKMkRMdjZTM25kcHQrbmgycVlBbWl0MzV6Y2V0?=
 =?utf-8?B?SXZCblBCaE96cWlsb0t1L1doU1FHMitBMjJWOTZ4S1JFa1VMbUFuRWh5QXp5?=
 =?utf-8?B?Ty9GS0tBNXp2NmtJOTczVGxrMFp0T0pHZXJWUEl6ZWZTKzI5REJETUcxUXpO?=
 =?utf-8?B?MWtYRzRMRjBZTlFDMEt5MVN6VEdVZGkzSFRZMmxxTFJFS2xNMVFFYUJiZ3Zr?=
 =?utf-8?B?NnRTR0dXN29wSnFVTWFiMEQxcmtPd0dHK29HdzlBYXljNWVKeU5Kd2M5QkdS?=
 =?utf-8?B?U0theUd4YW8vMmYvWCtvZFRvcUsvME9iY0xJWGhpUzd0ZkVhWTZoaVA4Unlo?=
 =?utf-8?B?TWtnS281U2x4Y1l4QmxBcmxMaWZnTVpBQ1g1RmtlclpVbklrNXBUZWZsbzVn?=
 =?utf-8?B?SU5NMEpnU1J2U2Z5U2s4T0Mvc1JwTFpYTjJMSXhaUjRkS3EzVWRocE51cGxs?=
 =?utf-8?B?b05rYkltbnk1MTRNMFpiU2NqZXQxWG1ZVTNZOWZrR21EUVRUQzcxU0ZFWkR6?=
 =?utf-8?B?emd6V0RicXpNd1V1NG81NVE1clBJWXZQSG5pazBpc1BWVnZVSUs4SEp0SnJi?=
 =?utf-8?B?T2ZDZXczcGlEbzNuZHgrbzhwb1pCQ3R6aVZiVlovKzJ2bGtrTlZOTXJneTZq?=
 =?utf-8?B?cWRCNDhrN0dzMG5ZWWZ4UW1MZVlEV3FWeTRoQWJGYXU1TzBRQ0I4dEJWdUIw?=
 =?utf-8?B?SmUxV01vMDB0M0FkVzFUWEJTMUtoYkMzMWYvRFEzUU1qSm5pOUhhR28xemY3?=
 =?utf-8?B?WWVMN0lVRm1Kc0gvQlhUL3NvNnZOR2Q4aDhoTW04UmdQaURvQnVIczdiMmlZ?=
 =?utf-8?B?amxSRTdEMnpUbEs1aVJ5aDlpVC9FRk8zTThLemVUb2NuYXUxTTIwTnFnYXN4?=
 =?utf-8?B?ZDlUWTFObnVTbXFJTGxtclRuN2xqUjZTeXZXMWpzeHJUZ05jZllDSHdkbmlK?=
 =?utf-8?B?M3dsenBGV01va0pGR1llMERJZ3B2ejNNL2VidjdJeGhHeE9vUTlma0hibGww?=
 =?utf-8?B?SUNUU1ZxdmxSaEF1NVRhVjNvT0F5NkNVak5lUXF3MjFRRUlYenk3S3drRUZZ?=
 =?utf-8?B?aXpUOXh1WGNCbE1iWk1mcFdRWlNBbFh3UjBXN1FFK3E0aGMrZlcwVENNWWpn?=
 =?utf-8?B?MFVSU3dqTXNzUTVSVFdIMC9saGd2b25ZbmhYQjVzVW1xQmNJVmhYbmpKZCtE?=
 =?utf-8?B?N3VyK0s2NjBDdFl4TFFkcjAzeUVNaHRtUEVlOHhZWTlvZkRxV1d6bEhRaDdO?=
 =?utf-8?B?SUE3aHk3QXl1ZWZBTzg4ekVTbXYxU1Q5VWlueE11Z0haMlRaT2VCWTkvbU00?=
 =?utf-8?B?YUQrNk5TdDBxQWxZdzFKSVV6ZUVxQWFnUE0zeWpXWWpXc0o2bTBtNjV4eXNp?=
 =?utf-8?B?cmg0dUpLK3JPNW11ZHZBWEMxalhGaWZGcGh3UkZaYnhLSjk2Q1BRQStvQUFN?=
 =?utf-8?B?cEpSWHJ4NUFoOWNPZis4dS9KVHNES28vOE9WM0ZHanllVDYrbTdaYnhuMU12?=
 =?utf-8?B?N0N1VS9UVGxSa1NUUUhqUjhYOGVDaW1QVGVqTXdwRzIxTytDY1BmTEJRZXpO?=
 =?utf-8?B?VS9LeWUzTStFSkM3YVI2dHlUU2Mvd1cwYjhxd2VLdE1VUEJ6dmdTNy9Qcm1B?=
 =?utf-8?B?a3dyS09WSjM3a0p5dW94cU9vaXRBZWdIRzdJaGNIbzFrclc3eFdjT3c4ZURY?=
 =?utf-8?B?TXdpYjRTQk5RT0hUYTc0S0Q2bkpSWmNMd2JuOHlmV05SWG9Pa0ZWdGQ0VHlS?=
 =?utf-8?B?SDF6NFNYUEJtYXVGTHg2OWpnbWpJTUFCc2RqbXp6cWZoVG9KVXBUczdoWXB1?=
 =?utf-8?B?UEVSU3kwVnhYU2ZDUzZDSUVpU3BIU0EzSEhvTUR3OFNuQituYXhxMEZPYzBJ?=
 =?utf-8?B?VHlacUIrQWNHRXp2L3dFYXk2eDVaV1lKQU0wZ3lpU0JLZXZnbVNEOTRtZmR1?=
 =?utf-8?B?d3ZPZHUxeU94VFJ5SW5rd3grdFhXN0hpTC9RSVJNOTJNWk1ERkhyTVhETG1S?=
 =?utf-8?B?YksxWHBTNEVERWVsTGVNdXRtQ3VhOG1HemdpTk9KMitXZHdkSFRLNnk4WFNo?=
 =?utf-8?Q?CDvgZ2h9eLtz1mwreNqy2EA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWkyNVdmNVo5NHlhcDhuOG9tZk9oczBuUkZwKzdGeVo2T2hJNUl1TWx1aFBu?=
 =?utf-8?B?eGFSb1hGd1pVY1ZpY01IdUtVU090bk1mUE11MWVPNjl5TTJkMmJPQVpRMG9H?=
 =?utf-8?B?VzFNdXJJdDVCOTU4K0F6VkxaVUtWUG9yTUNITEpsTDh6WnZZY2ZaaUZZTFE5?=
 =?utf-8?B?NCtGU2E0NXlIMVVlWEVBS21VMVV4Tjk0dHpqcm0vVm10TjNnWG5OQnRxOTc1?=
 =?utf-8?B?YTRaaUZtY1hyV1ZRbGV3WGlvS1JKNm9kNDVFQmpzNW5sdk0vaE15R0EzZW5J?=
 =?utf-8?B?U0NydC9DcXpEamlZb0VHRjVXYng4enl5d2NDeWtaZzFkMDlYZW5tb0VZNzhD?=
 =?utf-8?B?TVJUbGxrd3BKSFoxbDE3R1U0RWhuSUtxMjJCOFBWQUlYck1WdVdlZjBGVk04?=
 =?utf-8?B?eGhiNzZ6UDBvWXQ1emxqT3IrNHJBOGpTLysyZjFhb2ltclNhWHp4a0QxQWlQ?=
 =?utf-8?B?ZDg5QTRVa1R5RDZvWi9udkUwR2dwTVNxVzZDcVVmdzV6WCtVZ0pkTThYN3pa?=
 =?utf-8?B?cWRzR21CU2V0UmY1ZDFQS2Y3VURVMjFPb0hiREovUk53N2l4UGtVTTZSelVN?=
 =?utf-8?B?SDZRYkJwVG5QNlI0MFdoVU51TmRScDY1YjJpRTErYndmbm9tQVBCZTl2RmJV?=
 =?utf-8?B?NmRtblQ1OWIwNXlYS3luRDhPanBWTG1rd2hjNmN3dEY2RCtyMXVDM0hVa1B1?=
 =?utf-8?B?ZEtqb0xvMisxMnNma0RzVFVOSG5XT2lRNmtXdkNjY2ZaNFFpNDVoMTE0MTAz?=
 =?utf-8?B?QWZrazFIWVFyMUxaMk56K01uVmNRU2ZrT2dBRjFMYlJYY1ArZEwwZ3NranJ1?=
 =?utf-8?B?QjVnemY5OTdCNHdUR3FBNFo2OWUrN3hKMEtRNTZMUmM5RU9xL29WOE1vNzNl?=
 =?utf-8?B?eTFEYTE3STZOVzNoTFE1bko1emc3NVVpRHpZT25MaXBXcFhMWUpxSXhJUy9k?=
 =?utf-8?B?SVc3SDlnMTdlY3FlZ3FXMXVVNzVTclBvUTUvRS9GTWlLaXhIWmdpT2tBUTIx?=
 =?utf-8?B?b3RkcnRuNUpsR1V6MDhxOXd4NkRJSHNrUFNYVXFBSkcyNHdIV1Iyb05mT1dN?=
 =?utf-8?B?OXFVMU5Cdys3bk91Tmtkc0VPRzdERHI2ZytyZzEzaUFOeit2eUlMUHpZWitF?=
 =?utf-8?B?VGRjVFlOQWJvcS9aQy95NWRNTGQ2ZlR6TCtLODk3dHY5VE9sRTZpVkZ6MVBo?=
 =?utf-8?B?aFpXck5tdHZDSFNuTUN1Y0pGRGNzQlpTRjlHS0lZYzdnbkRrc0NNMHB1VC9n?=
 =?utf-8?B?RjJIMkFsNVZnL0FVVHZSQ1hQcmRva2sxdmZoc0FNU2VxY2IzNG8zbjhlNzE2?=
 =?utf-8?B?czZHV1ZxUVJkMExQejhDU24zQitVTnVLb2toTW55QXpSdzJrMk1rNDVPNmRR?=
 =?utf-8?B?STlmMXZtbDdKVjg4YmozV3pCWno5K0ZvVXBWcFIvY1hNRWZWZldaSFlRNHhQ?=
 =?utf-8?B?K3dETzJnMlZnUTd3NDhuaTY1dFA2R3VQY3I5U1hJRVAxTUJ2eG9WaFA3SWM0?=
 =?utf-8?B?bGMvbTBSdGJTUVJVeW03cGVFRmlNSHU5Y1JwTTFKUFdxM3BIeE80c3hBb3Vx?=
 =?utf-8?B?MDFBeGsxQW9KQnFlSTRLcFNTbzFQVjc3QnBDTDlWOVRINTVFMS9VOGZVcnQv?=
 =?utf-8?B?bE1IR0pqQ0o5UGlNRGU1dnhqVTNyem9FbmRJNFFjZ0g5Q0ZOVTVFTS9rdVRl?=
 =?utf-8?B?REpVaU9zZm1KSlBvUldISmdnb2hTdW8xbWxtaHV0MFFZc0M0WnF0MmlqV2xo?=
 =?utf-8?B?UVZOazY0MGFoTzNzbDRGMTIxZkhSREIyeVMvTUVxTERlU2F0c0dML1hKYkND?=
 =?utf-8?B?Rm5IaVFHOXYvOThWbWhpU3RKV3ZTanc4TVdoQ2NPYjJScnZRYnM0c0Q2d3Fu?=
 =?utf-8?B?NTl4K1VLWld0aHFTWWRML2NYZ29vaTlyc0NkbnRtbytuOE92Y3hWczB6THE5?=
 =?utf-8?B?RFhRNERablo4YVpvVWNIUDRGRW1IZ1pjTVg3bWZ6dzVCYjV1WlBWelFGRWZE?=
 =?utf-8?B?QjZiS1ZiNzRQMm9mL2xIeTJtZGJRTm4xbHI3RjZMNXhVTXg3QW1GQzNEZ3R2?=
 =?utf-8?B?R0kxQ3Q2eE90SWZhdkg1KzdPbnRmYkh2TDhPSzdKSTBmS2RSRGRpaWtCQ1Qz?=
 =?utf-8?B?RVRFNndwQ1NodlJvb2VOTDJ4MUJQNGxBRlYvUmcvSjBBZFhJV0o1UDBkWlFW?=
 =?utf-8?B?cXpOS3Nkc1JGb3BjMHdvL29aUWFrZ3pCL2ZQSHlkclFSenZUQVIrNFMycnBK?=
 =?utf-8?B?Q1ArN1lQTVdxVklKMlE4b0JFWkszS3MwRWRGMENORWxNd3ZYbjA5MmNPSFRq?=
 =?utf-8?B?ZmdNTTY3NmpSdFJRU0xwOGlueHQ0cjg5ZVNVT1llWWp6L0V4czc4Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da40d17-eba6-4ac1-264b-08de5f1a5259
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:39:39.1091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfpWsKw0A1GLXTrs0pseujX0oQFMQFGol8CYEyxjs2vFutnURKy9Ng7IKvDy8XksmyL5fjBG85A/6fFfmTqkyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10384
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

There is no user of "gd", so drop DECLARE_GLOBAL_DATA_PTR.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx8mn_evk/spl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/nxp/imx8mn_evk/spl.c b/board/nxp/imx8mn_evk/spl.c
index f96f5c45789..6554d445a59 100644
--- a/board/nxp/imx8mn_evk/spl.c
+++ b/board/nxp/imx8mn_evk/spl.c
@@ -11,7 +11,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/arch/clock.h>
@@ -32,8 +31,6 @@
 #include <fsl_esdhc_imx.h>
 #include <mmc.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;

-- 
2.51.0

