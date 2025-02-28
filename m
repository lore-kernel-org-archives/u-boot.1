Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC80C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CDFD81335;
	Fri, 28 Feb 2025 11:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VOh/BBJE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0EF381428; Fri, 28 Feb 2025 11:55:59 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 208D6812D9
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsTRP1r+Xr7BCvjelX79Pp6ckVijoSzWFUtnGSRuvgvo5Bw/kIcMSN38oGQ9W5nVPHxTcb96R1SRMt9K1afprFSWPOMr6J4YHzG1NKxCTqqELOI75CLsbAEl/xoFp9Yg5a6HC0Xe+ePRFZ89lUtgQjACNtCKl5TgROqEI8+SJoEMThvGZEQfI7RsORyZIxDyWPb+CY7r+q3OpsQoFve4SGqE1kUTC8LTQ52dMoggJL0ssa+42qzeypE3OaLj/Jrff2wOBHo9XLibCHu7rp9okXbmKcbI6fIWuleTeOj9tpeV4Qep8VRyUX8vddRFG3tGRZcYfSHPe0IM7//RCwvNEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spC4sleK+DMwyu5N7JyjVTD1QyjhkeqQMCaOBEoJhQk=;
 b=gMK4qnLMmxtu2gfwMGNPHKIbO9TWzITxz3DVFiTV5YzjTkw4sKx2dhHvppxH0NHJBdos5UPY+AVya6MfsjImRkw/obx6or5pG2n5tdcidj2v/QOOHE/pg5npMcQyoicKWrA/LOI3GXTCWGY81Gyz7COJWapRacMkGvtMoxODiL/e0IUdOZY5TwHHlrSwKSWUiYwkIvuDxWQVAvBUBWlkX3Xu5n7KwWIGm8Pnk7iDV+BQazzLJ6QKrluU5jskuUvKmx5uz8KveeAm60R0/GcDWzo3H0tugfWYY+UH7CvKajgFsRpn/jV82lbk07DaVTCEMMG6T0luB4ioxIQ5W1SwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spC4sleK+DMwyu5N7JyjVTD1QyjhkeqQMCaOBEoJhQk=;
 b=VOh/BBJETuhcbKl7jApnYjTaT3O54O2Ku6SOfQXpFO5lDJ2vIrVmyJ85c2T6m4e6jTt//MaT+731Dvq8LXw2RM71J/BS1yPOpCmsosLnnJHC7ANVeoc8pem+vtmMiwqJmiz0mvaIYlLA/6+qcyJcMmq7eAw47e5piTyHKSqXjNNH6lDTs5nYmg06FDF4XWM+dU6dhcz1JvtCrz8xRLBXeIIFi/3stmTyTULF1EwWIwD73EqG8BP9BWI8/Ak1IQ7eiU2QS4n/AJcWQZ9QwHtV/W1sp4mKDkyfVRxBQVRtcDQ9Pv070+CvkM6NhJe3Z/4XDytRIFL00oxf6OiVl9030A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 10:55:56 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:55:56 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:54:11 +0800
Subject: [PATCH v6 20/20] Makefile: add some files to CLEAN_FILES
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-20-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d6d88a-89a3-4b51-1d6e-08dd57e67a0a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2NXbkRUQWp5U0s3TTlZZ3UzU09xSHVacER3UGRQUllPQ1RRWlpVMC9sQUtF?=
 =?utf-8?B?U0NnOTlHZUcwNFVOWkxjSWJrV29ETjFHTGJjTmtycHRBaC9mRSs5S1ExMnVo?=
 =?utf-8?B?alcxNDlSV09Kd3VqbEtMa3NpM3hDTCtuYXQwRXF4d3dFNys0Q2g4VGlkVzVt?=
 =?utf-8?B?bDJHMjVRd1VxaUhFQWVaZFgyM1kxZVFjUU0vVkYxVmM0RkxVdFlhcFhFclAr?=
 =?utf-8?B?M202bi8xRkNqTG5QS2l3TDRmQ3h6a0ZSNUk1ZDFxM0tNNjdabzA2dnRiNGNW?=
 =?utf-8?B?dkxQM1lZejk0Mk9NL3JQaUtRc1BkUitvY2lVYjBrTDJPSE5ZUTlzMm5xOXNK?=
 =?utf-8?B?SUQ0ZlpaWXF5bzlSa2ZOVS9xd2IvSERreWxvZWM5V0UySkJjdXlCZXRhZjlL?=
 =?utf-8?B?eUtJeGJNdzdXc2x6aFJCb2dtZ0J2RnFhNmVrdU9BRkdZZUw4ekdxQmw1MUZV?=
 =?utf-8?B?MW0vdm1mR2lTZG5CRDhONUtzNmNiaE9kZjZKOHE0MVlwZERMVUFhdys5dzkw?=
 =?utf-8?B?bW0wWVlhektlTVBLL0hzLysyN3NJTWtFZWZaQzhwd2g5N0pNT0oyRjdaZ0Ix?=
 =?utf-8?B?YXFLMGNESHZGVzIvRVByU0M5bTBHSW5lRGw4bGJBeklFZXZ5eDJrQ1d6N1Bq?=
 =?utf-8?B?UitMNmJ3elIrWE5jUC9OeEdXMWF0bXBzbi9xcytMcjVmZCtHR3hUUHlPUjYr?=
 =?utf-8?B?MVY4SXJkWWFTZ20xR0cvVlhlZGM1RTFWZ3RoVjFTZExXbVdPTFcvQnRDTzN4?=
 =?utf-8?B?S3JjVkVFUHJGMFhCUGppT2NjV2p5SkVRbWVmWnBCMmx1bzJ3T25OSnJRcm9t?=
 =?utf-8?B?Vk1lR25yaUQ5YmU1YzVSM3dZSDdTdEtEUVp0ckZqSnVISU5hQzg4UG0rNi9v?=
 =?utf-8?B?TU9MZlE4WVZqaElITHRseGg4Y0oveDVmaENjTmxnTk1kZlJrVzBOeTNOZUhy?=
 =?utf-8?B?MmFETytBL05PY0ZFaGFWOFBYNy94OUVWVHZNdHArVVhkbUpIS3NXbTkvYnNn?=
 =?utf-8?B?MUh0M2dFUStoVzdFVWl3VzAwdGdZRVEzUlNWbzdwbzhyZHNCa05aQ2FUbW1P?=
 =?utf-8?B?aStvMWNRM2hwTVBOOS9KWGdxbEFVUHEwM2ZPR0JLcmtNUjl6ZkMrd1ZKenZC?=
 =?utf-8?B?czVuWHozMitUOFhYNmdqd0l2d0VhMkYwZUtjZnBrSHJsVDNnNXlvbHZmR3oy?=
 =?utf-8?B?SytiVFk0b04ycjA5a05xQ3Z6M2R5ZkdNVlZWZHN6VHZsZEFybEk0ZjUwYWlD?=
 =?utf-8?B?OVEyRGdCcW85bnNmNnYwazFOWUd2VGQ5SWQvWE5ETkFjYmt6UmIxdFVNSS93?=
 =?utf-8?B?Y0VmMUFCRjhHN2NyR2NCaldweU9SdTkvbHYrRTc3aC85cElseFNzWCs1dUdR?=
 =?utf-8?B?NXpMT3F0YmRoOXgrYXlteXFVQjhwdlpXaFpGTHBBNWpVNXArZ0NKcE9kSmR4?=
 =?utf-8?B?VklGSlpENjNHVmhsZUw4WDErYWNuNWdLQXFXdGk1OUpIS2pLNDJTbm5xeEla?=
 =?utf-8?B?N0N6V203NjZscThPajFkUWxrdDQ2dzF1OWRnNk9Wam81bGtHZDl2NFFsUFNO?=
 =?utf-8?B?bVRDTDkvTUJtcEtpM2Y1MkwvNkk3SCtHOEh6NUxTcXc3YlpLbDdBdDJtYUIz?=
 =?utf-8?B?b1pTU0JLbU4rUy94WUk2Y2Q3RDFSV0dVZmRMWnE0V1ZaZnRDOVNpTWZjdk4y?=
 =?utf-8?B?TUxaNnBGcHo5Qldud1pSSFJGV2UxdUV5MHpYWVRvdlZpempXRnpKRU0vU3lX?=
 =?utf-8?B?NjJvSU9JZVVxM0twMGFRamVCRUIrWmFEUWpzTXc3SkMxUGxnVk1GUnlrNGE5?=
 =?utf-8?B?bVhnY1N3QlZHSzlqU1VqNzVuQUkwYTR0Tnd1V24zV08xL3pzd1FKS2cvUHdR?=
 =?utf-8?B?TzVQakVjbHJleC91NjZzVk96QnZrQ1pYTENnRjY3VGQ0NGJma2FJMG9SSTJJ?=
 =?utf-8?B?Qm9ISUM3MElRanZVTWZyVHo5THFRR1B6TkJHcksrNG1kRlk3Q29GN0pmTmlw?=
 =?utf-8?B?V3RTSFJnejhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SCt1Y2Y2d05XdmszbDY2R2MwUUMxT3M4VTF4dVFnay90V1k1ZDc1dmJqRUNR?=
 =?utf-8?B?VytRSHVKUjFFWDJGeVNWc1R3ellUOHNwYy9hS1FpcjJFejIzZU8vWmZXTU9h?=
 =?utf-8?B?YndlNU04ZVFLcC9qWDArNHNRN01lc3RTTjBsUTdGaGdHeGdTa1JraUsrVDBI?=
 =?utf-8?B?dGY0UXVBN2hRMGd3aVM3TlhjZDJIdUtsemVJSGduSjdTUExTdi82eUUzOTBk?=
 =?utf-8?B?WGx1MUEwa055Y1NrQWhrQm5KL1FvVzQvS0EraUJDem1DbGkxZHFad1lWd0Zz?=
 =?utf-8?B?aUduelJ2cXVoaEFVUFgrSE5jdDNkVEk3c0ZhMWZQbEkycnVUWHBBdlZNVytx?=
 =?utf-8?B?OFVuclZLL0s3dVFqRVhNRE44NEI4enRKYThja0Via0RiaDNRY0RxRFAvRjZx?=
 =?utf-8?B?Q1pKbGV1TG5pSEdpc3NBcURPTDNZblVNL0lpREpJTDh4aG5MQ2RhSkZmVXJL?=
 =?utf-8?B?R2tLanprSGpDUjlGVEJPNFByQXE5eGhOaDZqTXZIKzdXcVBRZmNUQVJBZVRV?=
 =?utf-8?B?YzM2OWJrUHphR2kwaThjUkJ3T0JNRXZSS0R5UWp3NnVZVzFBRUdVMzJ0WjFw?=
 =?utf-8?B?NVJBL3U3Y1pWT3dXdEJhOHdnZWtYbDNQUFNxYXlBYU0wcVI4aXRIN2g5bTNw?=
 =?utf-8?B?ck5jOW1ocTFhRit6TU84WXgxOXZrQStWQ0IrTzJhZWVGQlVtVmcrcitLK0NO?=
 =?utf-8?B?S0RNSTdTZ2tncDRaeFRFMi9rckkyaW55VCtBczMrY1dsdkcyei9rNXVieTFm?=
 =?utf-8?B?TDhTK0VRSjRMajBvWS9rK1BSMjEySzdpRXkyZ3F5NXQyU0xtNWg4Rlg1Ukd4?=
 =?utf-8?B?cUNxWWR1N21heTRycmNIOHZ0RFVmUFFucTlNWWhtRnZVUGNlcWVweDF6VHVt?=
 =?utf-8?B?MllxZjRXNjdLYzh5WUhDQS9jYTlPaEhXVzRtYlpUQWZQeURoMjVGQitNTUpP?=
 =?utf-8?B?YUN3cWI1aUtBVFVLaER6SzJMRkYwWDhsY2lHTEtxcUxxYXg2UjgyRUlnNVFz?=
 =?utf-8?B?WkJLaGF5TksrS3dWWldrRlN2V0xrNW9zc1RXWHFkcW9wTUI2K05nQVExNjBS?=
 =?utf-8?B?WFBPUkRZN0hOb2tOdjZhVlZCeW9haTZYN3R1QzcwU3Vub1hhN0J4d1BlZzVk?=
 =?utf-8?B?SjVWUUdTMWt4LzRyY1g5ZzBKYXB0Y2VuTXJ1aVZrMDl2WWhPdk01MjNnVkEr?=
 =?utf-8?B?UmtVdUtETzlLdERtZ0dPWkVyOEVWSjRlZEZycmoyK2tlM0t4Sll2WktFU0Ir?=
 =?utf-8?B?NTBITmRKV2FYTjhJMVBZeHZMQmtyTWIycmNkam02eWRodmhzSVRERWJkR0RO?=
 =?utf-8?B?NGs1c3FHV01Nak5GYTZzMldGNGNqSGlYaGliMGlyWisxNWQvUklwR3dFWjR1?=
 =?utf-8?B?dFF0dzZKUXZESk0yYjhLbTdEUmFzb3Bvc05ucmNCTG9YZkIxQS9PRWlFYzA4?=
 =?utf-8?B?U3FpYm5IUzhIcjdpRjNLcTBxQ3hidTlrclZMWk14eldMVWQ5RXlrWXlMaUZJ?=
 =?utf-8?B?QTR4cy8yWFV5TmtnV0JXeE9JaXkrS0pIZzR1Q1NSSXptd2c5cFlJU0VMbjVn?=
 =?utf-8?B?bmFhaktNaDRxcTVUTmloM0cxMUZRUm5haW5iUHVrS0s3ODA2bWVnUjJQODc2?=
 =?utf-8?B?NDc2QnkyMzB3WHhxcFJod0VNdjNZVDR2Rm1FVSt6M0xUaWZhdThLa1pMbUxR?=
 =?utf-8?B?eVlBRDNETmw0Mkc3VFVPVkRXSW9hUTNRY1c4WW5RdnBnSmhJTWRMRjk4RjJD?=
 =?utf-8?B?bUExQW03c2lKaEZySTZKNzZxeDdDUWlQNkNRdG10Yy8zd2pManpicmp0SEhq?=
 =?utf-8?B?dFRyRjFuREgvTHlza2phMGpxNmZaOExlVlVBZUxtSG1YOW9lMWV2aWpaNm9J?=
 =?utf-8?B?MGVFNDRUNFlpRkgycEtrY0J1THZtUHlHYURDUUljOW0vcGYwek1ISTJNMWdE?=
 =?utf-8?B?d3c4WWhrK0U2cHloM1QrWGI0dnEvU0FMSXphK0ZpUEo2L3Zpb1dzQWErQjR4?=
 =?utf-8?B?aGVQc3g2anRaVkVGaEFremVpcm8rRENxR3lld3NoZlYvS3ljVmZQU1NhZjFU?=
 =?utf-8?B?Y2Q1Y2pUczVqcE1PR2RyMHlBMHhwMVpiaGlTcS9HS2Z0OEFOc0FGUlVWdm9Q?=
 =?utf-8?Q?tfEm9xAuUMvvRUbPJoiw97bhR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d6d88a-89a3-4b51-1d6e-08dd57e67a0a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:55:55.9312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qqix33f6FUzq3B2G1Dqs0Llpo2qARaTa6iSR6SsC08mlIGlaVnsjKh/FLuB5sCFiESVQYRjQ5hgXIpL+eIQ4Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845
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

When building the flash.bin of i.MX95 with binman,
mkimage.imx-boot.spl, mkimage.imx-boot.u-boot,
mkimage-out.imx-boot.spl and mkimage-out.imx-boot.u-boot are created.
Add these files to CLEAN_FILES so that they can be removed when running
"make clean".

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5f90cea11d..f2cf4398e0 100644
--- a/Makefile
+++ b/Makefile
@@ -2229,7 +2229,8 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
 	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
-	       Test* capsule*.*.efi-capsule capsule*.map
+	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
+		   mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \

-- 
2.43.0

