Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF8AC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 16:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D243806FC;
	Thu, 20 Mar 2025 17:03:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="M+F9T9wC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBB528070C; Thu, 20 Mar 2025 17:03:43 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::728])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CF86803CC
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 17:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAOzmfaly97VNxouEoucdFcO6dsIGhMJ9zVfwd942xts/JFfGYh9tWUpm5iEHYsULYoYkcPOxLBs12Tn4yzBajqanzfFShYxb7OsAqNS7f2VuFSyRoJyMNWhnm9RkPtifhwPKdOzMKsTCdU7FikbECKxgtpmaf7xFUu5KMeoMtjtP0H7OEn5ss/OrjJwi+BnJAc6lnkaK/yNRoHZx1L0356NftpVszbOQahMkBl6kXUachIMJs/yJSjuMuFaVmIz+LEDqKPqaWbrQ3bccTA/2AwF34o7A5PCbKP8Bq+HVGopRJlFnBIsbujvjVOw2jMVY8i5GBGqBoX5IsyBlckD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnHE2R2uoTgsYqH+zDEM5q+pgMdHt165J1+4gPkrZS4=;
 b=oha49yA9qGgR26XmuCrcVw3qYEtZqla9EtebUkPrJhKp9wXBaGKwW/j22FRqUAbm/pbAzfCRmwiwtAaRG94L9bZRNVOFa56hHw8Q1zacZEkA5SbtwqDyEoJrvsfy3Yi3eGRKxpBn+xxSgIyC9EIJ1sL6wahk1Ej4L4oO8N6J8+leTAOQESiDZ1Raz0lTzOumB6cbrJuYFGhh2Z6pU7O4UBrOgfOuFmAyVzwAupfE2s2CZlHmy/T1WH5fXoV6yBlL+5Bu7vobsu4UXgxq2u9xOVJKUUcg43fa++vBQ7a0QQYD5OwXKW2ktWLOF9qJBUtWzIIL5gWu1lWqY40jJR4I6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=denx.de smtp.mailfrom=topic.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=topic.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnHE2R2uoTgsYqH+zDEM5q+pgMdHt165J1+4gPkrZS4=;
 b=M+F9T9wCblKvXSI89S3Xuq236rP2+e0Tl++xSFce+wil3XpUEyieGFOSChaASLXxofWEoPOi5VOCt6C9OylHAIGiR1tY2eeFA8mAqhbYuuIAE+jUT86lQNpxmnxfX304zFYv6T+z5GWjidVBd693FUd/sPuOhg90JLhzWxcNyFl1arFE0vtiAY/3Ufbjh2dkYPk9pmw6LSAY1Lz+UzgR5zj8Xa60INHxEIo9LQgmdIVdMN5Rmj7a/mPTO/Gc9a4WuZ3VRcDJldLiC7SkUCyIBMAiXHV7YmWUA0xlPN44pgkT13iV/YcSb328VhNRLQsuSMJFsnOBn4XnawKjhcmfQg==
Received: from DU7P251CA0029.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::35)
 by PA4PR04MB9341.eurprd04.prod.outlook.com (2603:10a6:102:2a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 16:03:34 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::ea) by DU7P251CA0029.outlook.office365.com
 (2603:10a6:10:551::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 16:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 16:03:34 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.109)
 by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server
 (TLS12) via SMTP; Thu, 20 Mar 2025 16:03:33 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PR3PR04MB7404.eurprd04.prod.outlook.com (2603:10a6:102:8f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:03:31 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 16:03:31 +0000
Message-ID: <86ddc7c3-55c4-4994-8e48-a26f5d59589c@topic.nl>
Date: Thu, 20 Mar 2025 17:03:30 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: block devices on MTD and UBI
To: hs@denx.de
CC: Alexey Romanov <avromanov@salutedevices.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <cd57ac47-02b6-458e-86a7-7c837a89b550@topic.nl>
 <78f39c8c-b0fd-915e-ba66-213f58464680@denx.de>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <78f39c8c-b0fd-915e-ba66-213f58464680@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR02CA0146.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::13) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|PR3PR04MB7404:EE_|DU6PEPF00009525:EE_|PA4PR04MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a27f11e-867b-45fa-d92f-08dd67c8c447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?Y0FtOWJKRGk1ZWhRM0JBOFhUeDZYaVJyWnU2VllYSkRIM0hwcDBWZDRRVitW?=
 =?utf-8?B?OWQ0VGFDKzR6dlpkVnB6eHVTQlVKQ1BRbmhzZ3dBeXNndHMvZFE1SWYxQmky?=
 =?utf-8?B?R2tTS1hiUWpUdW9OZEhHSEUyV1ZheWxxNjFIL2ViZVVnRy84bTdwSHJDanpt?=
 =?utf-8?B?SlRGRE5pL0g5YUNaeVIxZ29lZXBYeWJrdStJSExteTN2cmpRbG5pSS9ZUXo1?=
 =?utf-8?B?dkQweGVYbHY2anFmTUZRWEhDajgwV3hkemJVdmtkU2Zxd053bVNSMDRoTGhT?=
 =?utf-8?B?RnFLaUV1SS9ZOWpTSElLQWF4SVRTRk44b2taN2hnMU9CM2dSRHZaaG45VTUw?=
 =?utf-8?B?Y2lJK1k5RmZqelJMS09vNU9tMGpZU21sQkJnYnJ4U2MxZGR6b1ltb3BrRVNy?=
 =?utf-8?B?MHNvTjdmc2E2cGdoR1lTaHFxUC9EQkV2dno3UE9hajNQd0QwY1o1QzNkVWhr?=
 =?utf-8?B?emZYT1NCVFByTmtMVUpYVERlUmdEUGJFTlpjdXkzWkoyeFpYRU1PUlpLaVdD?=
 =?utf-8?B?akNTbUR6UFBYTWxIeE9EdjU5REZMdGZmZndnb1U3YmdJSFNoNWZxbzdpTWc3?=
 =?utf-8?B?TFhhbzlqNWR4d1d4U244dHpEQXdyYjg5Zlh3UzhJbEh6VGM2WGZGdVhkMzAz?=
 =?utf-8?B?dUJmOHdid1dNRkNCNmNGZDhtSzBwWk9wQXFPdEo5ejI3MWdqUlg2RUtKcitH?=
 =?utf-8?B?bXphY3V4Q3h4NmpmU1JWdEpXNit0V0hxSHoweHQzVkJvMDBRTnIzaFlyQ1Jv?=
 =?utf-8?B?RXhEUDlvdmlSb2kzMzd3b3psb0l3MDMzNFNCV1FOcmRpSVVZTFFjTmVSc2hD?=
 =?utf-8?B?K3VDWlBXdHVkVFVrQ3l0ZkdvTkZPbmMrL3E3QStDa0x0WlI4YWR6VnJoRHhI?=
 =?utf-8?B?T2tJNjhzeUVHNVhralpIZEV3S2lWbjloVGR2ZHViMFdRcnVHc0d5TDhxMHpI?=
 =?utf-8?B?ZUdXSWlsYm1MZy9CL2E5YWJTYnlTMlBqR3BSM21FLzVxSkFDaUJxRklNL0JH?=
 =?utf-8?B?cjR0S045L0toek8xK0QvM205NWxmK1FYRnNkMEtjN2xXOTNIZzJjMHJqaTR1?=
 =?utf-8?B?Yk1rOFY4MDdCWStZWWYvQks2VUcvdFZiOUFJcEhFRDlaOGRXY1Ircmk0R0ts?=
 =?utf-8?B?UWtnRGJyQVc4VEJkQjVzK3YyY2NMK1hGL2xDWkV5UGdRMTBLeWNxayt1dmx6?=
 =?utf-8?B?V1pwdTdMOUg3Zm1NVElxaFhaT2hmelljNzdweVVEZWVQTUNIZVlWamt4MWF4?=
 =?utf-8?B?bVZtL1lnTjkzb01NbGU1UVQyMkVIc2U1MVhFVG5UTDVEU2hJMVhDcFY2MHho?=
 =?utf-8?B?NXVXNVJ2ZHlDU1RjSHRvaTczdkd0eHFIeGVOTDVTZEV4ZEZ1NEo2akpWbGtK?=
 =?utf-8?B?UlJVQlhqclJEZDlBNDltdjVWQ0tlVkRtM0Z2RDRZS21OVGRBTFBJbEZLV1po?=
 =?utf-8?B?VGVOSU52aW1WK0NXQjBkcWl5SjVEaG0wVGhRUVlZNlBLK0t1RVBNdlJkZTVv?=
 =?utf-8?B?cUx2c3lUUUtla3pSLzBDOUg3aFlZZmdMNGltaXc2VFM2eE53L1pUU1VkMFN4?=
 =?utf-8?B?SzRzcDZyVmRvc1E3Wmpid1FQOUl6Y24yQVIvZ0hhUzNHbHVHdmFWTHZVcHBh?=
 =?utf-8?B?VFZoYkxid0NQdnZGdi8vaUZSRnd3ZnRseDFKd29YUHhrK0Q5K3VnWUt4OTRR?=
 =?utf-8?B?YURrVithZ2xuM3VLb1ZMR0JucDNJaDB1clRHOEFYempZU1NaNmxZSGt3Wjlo?=
 =?utf-8?B?UEk2ODc0WWRRV0Ira3VXOXF3Z2lrWDFscXA4K2gyTW55NG4rS2R0VWdzbFBy?=
 =?utf-8?B?bGk2MU5ncUthUlVJRU9jVFo5ZUJYWm9aUmR6MWJHNCtXNnJvTnF4VnRtU2xN?=
 =?utf-8?Q?/hJSY7zpEAMAq?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7404
X-CodeTwo-MessageID: 1caf4235-420d-426f-b320-02bef58c6c12.20250320160333@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a662d496-853f-4c60-8077-08dd67c8c2c7
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|14060799003|82310400026|35042699022|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXREZ1NJY0FQUEtHbGxJdy9ZdHo0MVoyQjNFS2s1eldmR3pycGxZTjI1OXQ4?=
 =?utf-8?B?KzFJenJvTWtub2ZjbysxK1FMN051OVJtUW1ValFpaEkrMWs4WmJ4OXlFWDMv?=
 =?utf-8?B?b0lqaEpXLy9QdDlMdmJxYmtZd3JPaU9NV0VLT2ZTdGJHZ2k3MVAwVml4OXlh?=
 =?utf-8?B?aEZqQ2pBSlZGTGNJUFVqcjYxaHFRZWdYd0VweDZYZTNoeGFON1Y4SVRWekxr?=
 =?utf-8?B?T1lrUjVUTkdyU2x4dFJ1alhoNHVaeFUvUmQreDlMM2ZMU09FTTZUNE05L2Vx?=
 =?utf-8?B?OTl3ZlFIRTNEYnJ6TFloQzV2ZzVNUW9pbXp3djh5UUJoeDlpZkI1T2VHWGw4?=
 =?utf-8?B?c0dQZDlMaDRLc0lKY1BpUFU3OENvYWk3RDFsbkhuSEFRQlJ1WVRGVnBWbHZS?=
 =?utf-8?B?dTFXNGlpZXFpT3JrbWlFanNKNFJWQ3o3WXZRK1Y2VE5KVHVzYUlML1BCOGZM?=
 =?utf-8?B?RkZmb2wvT2NPdlhmRHNHTVNRd0x5WUk5RVJRM1IvMFZVcUdFSklicVJHRGI4?=
 =?utf-8?B?VnlUcExWMEdMN3pVUm0wUE1DdFFFNC9IYUV3SnIvUEs0NnpWT1Jaam5ocTFW?=
 =?utf-8?B?eFJ4bC9ZQVp1bmYvNkd3V0plQXFnQjlYOFpLTXBKVVJoSFZzYzErZS9PM2tO?=
 =?utf-8?B?bTVONGkwc1Z4U1h6dkoweDREYnNDTGhMRkViTEpuZWcwZ1hBcVk5VVpmRDhr?=
 =?utf-8?B?VDYwdlhXWTQyRW8vdnBpa2ZiS043aWNiRHluc0t2RHRnTThkaHdrMnZQZ1ZK?=
 =?utf-8?B?Wm12N0h2cTFMNHpEbTdFM2lhSlVVeFl0Mi9scEdsRGxCWGJWTHlJZHJ5eDgw?=
 =?utf-8?B?Q2ZEMnZ4Tm83N2ZNYncybkx5RzIvcFpzU3o0b3RGUVVCbDJybExzL2ZHaXN3?=
 =?utf-8?B?VWxqenB1QnBld1YyM0c2ZEhFU3lRS3lHalpPcDREOTM5S0lVNXJUTEc5M3ow?=
 =?utf-8?B?Y0drcFI1bVBsWnh6WFp0NENJOXdVU0VxTjdnM2ZBY1l2NXN0Ykd6NTlnbG9u?=
 =?utf-8?B?Vis3c2NSU2x5TXNRaUlIdlNENVgwbWdIL05ReDdCWGhrNlNhZ0xQYytVK1FG?=
 =?utf-8?B?bHZUTHA3Z1VJa2lUbTNybEUzRU1NVDJkcVV1YU94TlZBK0pUSUNubTAraVpG?=
 =?utf-8?B?MDBGclc5TzQ4SEJIRXNtcytNbS96SWdGQWF5WDhIT0FOUktqNWhhMTM5TExC?=
 =?utf-8?B?dkVCVG0yT2hGQURydWs0M2VGMVBVZGFkT1k0UGl1cm5nejBkMHI3S09sbWJr?=
 =?utf-8?B?dlQ2OGszSDZuR3NWYUZYczhHZUp1Mld4aHh0a29SR3oxOG5tYXNQZ1ExbFRj?=
 =?utf-8?B?U2syU0xScFZFbGRRcVI5K3p5cVpseWIrWU5tQ0NSTTRaWDhDcmdEbUFJL1Zt?=
 =?utf-8?B?TVFpRmp1ZGpKZmsydjlzcndGekpkL3lKaTdtc2FZWnc4WHo1dmpUUnpnTVFG?=
 =?utf-8?B?NDNSYnVSVGkyNVQ0SmZIRkcxNTBoV0RyczhKdDZpUEk3VFpYRnk3d2xtN28w?=
 =?utf-8?B?dnlYYThXQWlueVRkS0VXblNjWnIzb3NkbkpnMXBJdncxMWJuRnFjemRTRWY2?=
 =?utf-8?B?R0NoZVVNUmZSMmp1K3hQWXF3RFFoVDY1Tk4vemlIRXhZQzhsVkNkZjc4eGc2?=
 =?utf-8?B?T1NVT2ZlK2pjeHdiQmtnWGFlcVlpSEZkZWZGT2hWaGdTWmFvcEx5VnFzOGJN?=
 =?utf-8?B?ZHFNZlUrVi94SVRMMnBZS2I2Um5abWFMZzJHTFNYT2ZQOTR2dmtFSnpJUXF6?=
 =?utf-8?B?dVNya0d4OE9TSFNWbzJPMFhzM2JuYmJQZk10WngvYkRXU3pCZU1hVE5hQWlR?=
 =?utf-8?B?Rjc3WitkTnhUU1JmSEZmNTNURDlVUWpVSzJ1cnhyRW1FTExlSDc5M0V6TnNi?=
 =?utf-8?B?Mk41VjVIY3dxMHJYTGZ3QmE2VzIwTzU3d1MvVisvT2cxOXQwMjVGZTJoNkdK?=
 =?utf-8?Q?eG+s3I0fvsQ=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(14060799003)(82310400026)(35042699022)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:03:34.0016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a27f11e-867b-45fa-d92f-08dd67c8c447
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9341
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

On 19-03-2025 15:06, Heiko Schocher wrote:
> Hello Mike,
>
> On 18.03.25 10:04, Mike Looijmans wrote:
>> I think I have everything set up to access MTD (and UBI) devices as=20
>> "block", however, lsblk always ignores them, and refuses to list=20
>> anything but the mmc. I can read ubifs and boot from it though, and=20
>> since UBI runs on top of MTD block devices, MTD block device should=20
>> be working, right?
>
> Yes. I must admit, I have no device on which I have such a setup...
>
> added Alexey (who introduced ubi block support), may he can give some=20
> hints.
>
>> I also have UBI_BLOCK enabled, so I would expect UBI volumes to=20
>> appear in the "lsblk" as well.
>
> good, that would have been my first question, if you have enabled=20
> "UBI_BLOCK"
>
>> Example U-boot session:
>>
>> Zynq> mtd list
>> SF: Detected n25q256ax1 with page size 256 Bytes, erase size 64 KiB,=20
>> total 32 MiB
>> List of MTD devices:
>> * nor0
>> =C2=A0=C2=A0 - device: flash@0
>> =C2=A0=C2=A0 - parent: spi@e000d000
>> =C2=A0=C2=A0 - driver: jedec_spi_nor
>> =C2=A0=C2=A0 - path: /axi/spi@e000d000/flash@0
>> =C2=A0=C2=A0 - type: NOR flash
>> =C2=A0=C2=A0 - block size: 0x10000 bytes
>> =C2=A0=C2=A0 - min I/O: 0x1 bytes
>> =C2=A0=C2=A0 - 0x000000000000-0x000002000000 : "nor0"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 0x0000000=
00000-0x000000100000 : "qspi-boot-bin"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 0x0000001=
00000-0x000002000000 : "qspi-rootfs"
>
> Aha, SPI NOR. I fear this is not supported yet.
>
> Do you have somehow called ubi_part() ?
>
> Can you try "ubi part...." and look if this helps?

See below I guess...


>
>>
>> Zynq> lsblk
>> Block Driver=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Devic=
es
>> -----------------------------
>> efi_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 : <none>
>> mmc_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 : mmc 0
>> mtd_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 : <none>
>> ubi_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 : <none>
>
> Here (and for mtd) seems something missing!
>
>> usb_storage_blk=C2=A0=C2=A0=C2=A0=C2=A0 : <none>
>>
>> Zynq> ubi part qspi-rootfs
>> Zynq> ubi list
>> 0: qspi-rootfs
>> Zynq> lsblk
>> Block Driver=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Devic=
es
>> -----------------------------
>> efi_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 : <none>
>> mmc_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 : mmc 0
>> mtd_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 : <none>
>> ubi_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 : <none>
>> usb_storage_blk=C2=A0=C2=A0=C2=A0=C2=A0 : <none>
>>
>>
>> I would have expected the SPI NOR flash to appear in the "mtd_blk"=20
>> devices, and would expect the UBI volumes to appear in the "ubi_blk"=20
>> list.
>> What am I missing?
>
> It seems to me, that you have to implement this like it is done for=20
> spi nand:
>
> drivers/mtd/nand/spi/core.c
> 1180 static int spinand_bind(struct udevice *dev)
> 1181 {
> 1182=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (blk_enabled()) {
> 1183=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spinand_plat *plat =3D dev_get_plat(dev)=
;
> 1184=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> 1185
> 1186=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (CONFIG_IS_ENABLED(MTD_BLOCK)) {
> 1187=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ret =3D mtd_bind(dev, &plat->mtd);
> 1188=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (ret)
> 1189=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> 1190=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> 1191
> 1192=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (CONFIG_IS_ENABLED(UBI_BLOCK))
> 1193=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 return ubi_bind(dev);
> 1194=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> 1195
> 1196=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> 1197 }
>
I guess that shouldn't be to hard to implement... I'll send a patch if=20
that fixes the MTD missing...


> The only thing I just stumbled over is:
>
> drivers/mtd/ubi/block.c
> =C2=A035 static struct ubi_device *get_ubi_device(void)
> =C2=A036 {
> =C2=A037=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ubi_devic=
es[0];
> =C2=A038 }
>
> may this is not perfect.

That might be because there can be only one active UBI device anyway.


>
> But as said, I cannot try out ...
>
>> What I'm aiming for here is to be able to:
>> - Read from squashfs in (raw) MTD partition (NOR flash is ideal for=20
>> that)
>> - Read kernel/devicetree (fit) from UBI volume
>> - Read from squashfs inside UBI volume
>>
>>
>> I can read files from UBIFS (and boot into Linux using bootcmd_ubifs)=20
>> just fine, e.g.:
>> Zynq> ubifsmount ubi0:qspi-rootfs
>> Zynq> ls ubi 0
>> <DIR>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5200=C2=A0 Fri Mar 09 12=
:34:56 2018=C2=A0 bin
>> <DIR>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 160=C2=A0 Fri Mar =
09 12:34:56 2018=C2=A0 dev
>> <DIR>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4984=C2=A0 Fri Mar 09 12=
:34:56 2018=C2=A0 etc
>> ...
>>
>>
>
> Good to hear that UBI/UBIFS setup is working!
>
> So I fear there is some "add feature"/debug work ToDo to get this up and
> working ...
>
Good to know it's just missing and not due to something I broke or missed..=
.

Thanks for your reply.


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



