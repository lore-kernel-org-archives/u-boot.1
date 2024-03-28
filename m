Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0520DC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 01:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBAD18809B;
	Thu, 28 Mar 2024 02:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IttT5MQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53D6B87FD7; Thu, 28 Mar 2024 02:27:03 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C40C87FD7
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 02:27:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US1fxoAhDdTwBHin3hbAZKgX3f9kLzvYpDnmRODm6Pr5Lb4yGRq9jNmdXjwBB3Jy4DY1M5i89uzY4/AJUmzs1W9zNIt7DEjUydBtSsyLenQwHwdjRZ2m9ct7QjTdE5WvCJHTiePMPGg6eaOz0KFBFjbZxbDlC2/GGxP+QG4GwjfGQ70blCs8uJksZ0ncAtqUzDubc/BEhyJU9zbirTjEGTQCGO2ZQNdKrcRD9aoAJoE+7XI1NXCvOvPtZHM8Fn5NrYgSsMAZoIy5qnAp8DqUFqUvf1N4rIrpjWvO6UmgkqOuzC0GlYxbRbbwg60h2EtDSvgx1yRJQF74DJim22T5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vC8R7+v3c7chlZ35/uEpKnQ18vJqA72euAnFo/MDDmQ=;
 b=NV4DsC5bzJWIGrIYiL6IzKMU6b3lSKzzyD3Jt9Ufri0DTeVtkE4sQuT3EvP9rERJrJ2s0zqx5mvoMsvdI+2uvyv+c5Lhly8ip6KNJ2M1N2Zh4c/H4j2kxzeL0eOxQYU7Uszt35jCU0DyaygNNnJnHw686mX9h80k8hHR6Sd1tmOoGFnDVi9YgOcTovRonwA/EYjGk3U+LXB7dyQCTNgnIr/WGxgzhlI3bjPCG5mwC4NkI4C/GkAO80K4paHCdBjgJ6nE9t49jUORDBsq5uVwM5vaFhIN2pMHVczRxVhpImCrGlY+e9ClP8an6i+r98vL+sjfdpCyi6eacWlZOdYsRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC8R7+v3c7chlZ35/uEpKnQ18vJqA72euAnFo/MDDmQ=;
 b=IttT5MQbGxbbD0f5W2Upv18OVyqdFfe4PgzEDUdDKY82OZDYYsCirZfC8vnnhPcOFDMPqYc+3gnGG7Pftv6nyCROCyjJesZrPd9hB8ZwUGyZbxQOsCJ+sECrjoCXgNY9OVXp4diVCzrI37Mdz3qwZ8MVjvSRyrVScZl1tjoNyYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8763.eurprd04.prod.outlook.com (2603:10a6:20b:40a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Thu, 28 Mar
 2024 01:26:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 01:26:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/4] imx8m: convert i.MX8MM/Q/N/P-EVK to OF_UPSTREAM
Date: Thu, 28 Mar 2024 10:26:33 +0800
Message-Id: <20240328-imx8m-v1-0-2be5e6657a88@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFnVBGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyML3czcCotc3SSzVAtLc0PTZNOUZCWg2oKi1LTMCrA50bG1tQC+qpG
 XVwAAAA==
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f8c3c2-3fa1-4161-0b4f-08dc4ec628b0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnq7OpRb45hk2K7f/42d3WnBcqV2PvYV9aTyGTCHHxRDJ94aH2wbcH6fO1Wkt7VyU6cpaWJqgbMIgPomPN6qwBjauzlNE+QhOHL1v8Knd8RSw5vgF+V7a9QYALYorU7GLw76af7pghWo6GrL8tlj1xO49rW/C3Tar0paxy29YbbGcpDhgvY/jc3yDAmQh9XNFxANcC7EnQ3cUQQF7oTVK8c8Go6V4juFegSb+Q7SZR4QB4UK7OKYmBo1uDNiriXz4mKmyxFovPXMA9ISNxcgYK8r0KKDn5lrVE/oTIk+US3bmt+b2Yj+UfbwZxaDxjW5nmalQrwZvkmRgfExCmEzQfenYX/ws7gm84x9ij93jdkwnNDZVgXAU6rMFwakMMnYd6IThipksqKO1+u9Rt/GPWrlaIAWHF9pLuGbsnflsDmw+NgCRuAmZr1lWo+US4z/MqaC7IR/LOgfVtK1FuQJ5wrpUVMHnGiVAbtNSOfZRbolH1D9QoT5yFV2iec4PLA1JEtRf8Ic/WGY+hz0nhOJMHuXMgX9u+Tz8fXNXH0ksSqRrz/sC5u2LqPgC88s9JYRoVF7oAWx+lgjw9xfQTq/qvJ6pvNv8ZgoUjxqCc5mpLRzNLevkpXV2ksukMxz0Y/npZzR82GdLJVW1pu3fRKtKW9hY4zb1F8rflSt/qgqV7+zCl+JpeoZonfy+eWRx1fUP6stjFbgyTw1Tu7ugt3ieQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGt1V0o3L29uTENicVF3RE5jZjlITnRBZ2dnZTFDejUvc0F1YkhZQlo3M1lV?=
 =?utf-8?B?bVpyeTJOYzVYczUrenF1Z1cyUkkxbTNWTmp3SThpRURIVW1pSmErQWpic25O?=
 =?utf-8?B?L3EyNzg0RmhvZ0JXNWY4ODc3UDlVK041RHFxNlZkdnpkS2xxVTlraURDQVhS?=
 =?utf-8?B?VE45WlZNSmxHZDQ0N3RESi85NGRwaytlYWlxRkxIYnZtUDVIeUYrUENpMURY?=
 =?utf-8?B?cnhKRkJDOTF4aDR6cnlNTzcwL3pWTCtiNFpjTXA4RFdEa3lFb1krZ2dXNElw?=
 =?utf-8?B?cFZkaldvL2J6RFMxRmlBOG1rM0JianRRbnV1QnBzYjltaVRPTXpmUk5QUTdE?=
 =?utf-8?B?QWROaE9xa3A0aFR1Tm9PSWdma3BJYWpNQ2dDakNGVEtBV2YvQU1TN1ZPVjJY?=
 =?utf-8?B?N1NtU3V5QjZHTFVyZ2lJZVNWa0dYQWYxSUhCSlljRnd2cmgrYWZ1azJsT3Y3?=
 =?utf-8?B?eVF2czZaQzFWZjJZYkpPdFUwNEdwMnBsaCsvQU1UT2VXRVBRTEFtZ2JHeGF0?=
 =?utf-8?B?ZkUwRTVrRk9xSEZzV3I4NUd5VUpLZUJzZDFOYU1TUEhIVmJrbjdhTFhnM3h6?=
 =?utf-8?B?SEo2K2hEc0U5dkdqMXdCZDlaZ0ZXNUVWNWp4Nkhkb0RHMEJ5cmZ4ZFE3bndI?=
 =?utf-8?B?QkVnT0xNWHdnMUE5M1dmRHdPeGFTOWF5enM0eU9xb25LcWtwdXlYbHljOWVO?=
 =?utf-8?B?Q1IrSExQL09sM01wY1pNcFdIRlJtUUUvdGN1UnIrdVlrak1kbG1oSEpQU1RU?=
 =?utf-8?B?QXNacXNiaEkra2J3aU9IUWlWRWgzZjdweHVmbVQ0UEhKZVhRcXRGZGtiSkhm?=
 =?utf-8?B?bGF5TjAvVUJmZXVvTWlWZk1LNzNjV3kvR3FWMEM3SWNiMzkvclJlUmdSYldt?=
 =?utf-8?B?NXVXQ3M1am5VU2lSQk95NmhraU93N2FaMjhvUW9DSXVEdTM1WVNnTkFsTWE4?=
 =?utf-8?B?eE5wT0JzQTJKOC93ZlNGWUxJR242RlFVT2Q0OVRCQVZ0OENvZldkanVZbkVV?=
 =?utf-8?B?UnNlMEF4TzRBNVBOYVNwNFArTDRrQVA3UHRJQUtyTHM4MnBQT1FPY0sraFdq?=
 =?utf-8?B?aUY3dXFMYzFkREV4WmFNU2tQVHZoTVlpWGtmcVVJdUY5Zzg1aGNBVGE4dU0z?=
 =?utf-8?B?dXM5SnMxV2R5ZG5qdWhzb1pqdE9UazllN2l1bkg5RUZBZmlIU0V5WVF1R1gv?=
 =?utf-8?B?dzNXQStUWUZOWlE1OW5mK2F5RHdNaXFRak9OSEgzUWk2dW5jRHFzbTlMVklQ?=
 =?utf-8?B?ZE9EUXNnNUNRV0JwTzN3bkpTREU5cDczNjRndjMyK01IT2E1ZDR3c1BDeWta?=
 =?utf-8?B?d0R3K3BST1pFQTVrV2E1b0pKWnlTdy92TFBrZ2hHbUNmdE5wQmNDVm56KzZl?=
 =?utf-8?B?cHY3R2kwU296aVFNbHN2ZzQwRnBJMGloTjlNNGVPdmtzbHJpUG5OTFJoZHk5?=
 =?utf-8?B?K1BoS0JtdWFjRnMvVEdFUGFoU0s0eVo5em5vWUJVRkNIcUhsaFlDVHZnazVO?=
 =?utf-8?B?VlFUVGN1RDZXVW13WkdmRE50RmJnc2RFVU9oYlc0dTgyZW9iT1h0bkgzbzNK?=
 =?utf-8?B?N1dvdHltVHB4TmUxNlRLazY0RUxhc1JDdXdlbXdTeXB6OXo3Q1JSd2ljb0lw?=
 =?utf-8?B?Z0o1NEtlU3NLa2xXd3JjUGxmYmIrY1pFY3hlQ2M0allDL2pIVi8yTW1NWVZC?=
 =?utf-8?B?ZjFZRTNSdXg3ZVRSWktVaTlFMVBLTjVHQjYrdlExUFowM1pjYmxrekI5cXhK?=
 =?utf-8?B?ZmZ0Y21XaFUzTHpOUFMzanFqUUo5VUlueXhXeWZUcXEvRUkvZElMbE4zdmVD?=
 =?utf-8?B?QmxuUzFtYk1qbkplREk1UVhZeGN1eVhwQjFTeUxsamNLL21Wb1FsRDZlUFNn?=
 =?utf-8?B?bVY3WGUwSTR5TTZrWXQrQ29hNnRYZ0NZK0xBSHVTU0h1b3BPQ2pka0lHczAr?=
 =?utf-8?B?RXh5dW9yQXMrMW5JWFRsaWxOVG9lVUtnZitkd2c0Q2wvVEN3bUFOVWlUWDJ6?=
 =?utf-8?B?YXNZNjhuSDJWcWpOUzZ5ZGJPWjhuVVhEWkQ4aWZaaStndEN3WktiTnZWMTJ3?=
 =?utf-8?B?NXFublJBWGNhMmVKRzJLUVh0dUhTai9rR1dHdEJXOStrcFkvZExuNW5rRmNJ?=
 =?utf-8?Q?AvG6Z4TQBjOcl4sadg23M3o6M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f8c3c2-3fa1-4161-0b4f-08dc4ec628b0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 01:26:58.6308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKqjHM3iVUmGUlT6zhnuaabc3hTa8vWxb7I9NtgpeQePQuulsMqnt4GUJWlGNWJpn5bsgfS1FlNnRlEx/KSryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8763
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

This patchset is to convert NXP i.MX8M[Q,M,N,P] EVK boards to
OF_UPSTREAM

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (4):
      imx: imx8mq_evk: convert to OF_UPSTREAM
      imx: imx8mm_evk: convert to OF_UPSTREAM
      imx: imx8mn-evk: convert to OF_UPSTREAM
      imx: imx8mp_evk: convert to OF_UPSTREAM

 arch/arm/dts/Makefile             |   1 -
 arch/arm/dts/imx8mm-evk.dts       | 128 -------
 arch/arm/dts/imx8mm-evk.dtsi      | 615 --------------------------------
 arch/arm/dts/imx8mn-ddr4-evk.dts  | 160 ---------
 arch/arm/dts/imx8mn-evk.dts       | 128 -------
 arch/arm/dts/imx8mp-evk.dts       | 684 ------------------------------------
 arch/arm/dts/imx8mq-evk.dts       | 712 --------------------------------------
 arch/arm/mach-imx/imx8m/Kconfig   |   5 +
 configs/imx8mm_evk_defconfig      |   2 +-
 configs/imx8mm_evk_fspi_defconfig |   2 +-
 configs/imx8mn_ddr4_evk_defconfig |   2 +-
 configs/imx8mn_evk_defconfig      |   2 +-
 configs/imx8mp_evk_defconfig      |   2 +-
 configs/imx8mq_evk_defconfig      |   2 +-
 14 files changed, 11 insertions(+), 2434 deletions(-)
---
base-commit: ab8d9ca3044acf51d8ff3bf3c4718c48f30ad606
change-id: 20240328-imx8m-b6e89715c5dc

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

