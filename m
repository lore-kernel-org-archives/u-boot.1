Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C52CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 11:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0805A835B0;
	Tue, 23 Sep 2025 13:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TnqBCwBC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C070C835AA; Tue, 23 Sep 2025 13:12:37 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D18B80050
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 13:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZfuz5DWjgs2BhyW3Ltx7ui/5QCdk5Lz/bOO6reo+rgpsyldVlTft2cssHgn6hBmatL7RNls8yro4X3vxWmTJLtdudakCJ/WPVE++dFimla00Q8/v0mHAhwqa4OWdaLLbQY3cxDXuHg6TA+r7F0gXP14TuUFoDS1KxuhUuQUg7CwmHbIuyTHz6KWZ0obHJ+GTjzyBUd90A42lbb/hvDMrlMMF/WCRg25Tldm0X5kQ306OV2lhu/uvn8+hSS5eCPpnkB3QiFc79BbnhY4iKKn7wQKelwiGuoJCd5VCvfgd/Z0GDKHOUtyzmoWDkLPhxgI+OXQtFWgt3a2Ym+MwDHp+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N23uWZeV2LThteEM7EcSE7zvhh0/3QCMqf1cKbx4KYY=;
 b=GktwK9d4qEEKx4aldLf2J+3z6v8Y60oHxfY5WysVzHR/8s50WevhyF574yh6VoWWRrG8UcSJ3AhomK2+IZC6hZTvINsrZUiJJPlMu+rED1vUyhE9ZOzrmTF5YlMc6VuwvisXPbFB9OziHSydgcXj2aCMV8quw8Y7tA7AUsg4C1xS4aWbvy3QZm3FWqwdUJ3viX3J6zb2x6lSHiOCtuYr/hnP7R0aBMnOAz70/v7kT2ZZ1OPMtepLV3WtgMzfH+Op3nnL/rNoM+N4NEVEg4Q0ZRsoIzLIc7lY3Sru5/4qgcB3l3zROwmf1H20vvAiDyqnztve3NYNRthSVsHnNpU5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N23uWZeV2LThteEM7EcSE7zvhh0/3QCMqf1cKbx4KYY=;
 b=TnqBCwBC603EowaZ7lumJtkCPQ8XrFjYrwnu94qzh39noUV/02vcBuV++mcuNopWsyJO9oBHxlDnm1AvxuZkVqWg79VENaYHFzUb138wM4jvG6C4+irSuI/w09jSYvaxcN5zOZ9c6/1QS7QWmKLKrqb5kjqSGPqM48VZLdj+jhumxr5qi/rf0XRoblgcRUIhC0D6vDGxU26T+4VUIfFdOu0kGbnMyqxc093mfPNRyq0mndlScUMXPqfzwlZvnBg7Br0c9SiJKlcCqlcNSgsCIwp6sIzdH01aCmMa5FSFKl/kiGiahYZvkuPpJnmF+ZJAbe4b0lFPd94bLRS+SN/10A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7919.eurprd04.prod.outlook.com (2603:10a6:102:c1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 11:12:32 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 11:12:32 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 19:11:50 +0800
Subject: [PATCH 06/10] phy: imx8mq-usb: Add SPL support for i.MX8MQ,
 i.MX8MP, i.MX95, and i.MX94 USB3.0 PHY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-usbnetc-v1-6-507cddbe7214@oss.nxp.com>
References: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
In-Reply-To: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: fcccb9a7-a722-47ef-346b-08ddfa921717
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anM2YStIM1lRMHZQd1h5S3VKbm4wQzBqYlJOcXFBbEJEMTlYY0lQOVdRRHZi?=
 =?utf-8?B?Z0hIMzBOYmVJSndFWmIzditTaXBIVE41NzU0UHRxQWx0OXJTTkVoM3dXVEVk?=
 =?utf-8?B?ZWc1bnpxM3FMYW0vbk5RTDdpRHB4bk1YQkN6aEY1bUtpZE11WmcyWFZ4cndZ?=
 =?utf-8?B?K3ZpMlFKT1VKV0pNbE5VZmtrQnZzZjJOanBrenJaK3pHMUdKdmFpVnpidlFY?=
 =?utf-8?B?MFlIdXlUZmRrNCtOUVgzQWVwbkVFVERIcDhTUU1iWUV4aGxBcVdobzFrV1px?=
 =?utf-8?B?V1gyQUt2NE9hZmJiRm5JeC9EZEZJeTg4cWN4bE5KaEFIOVpkT2Y5enVqNFA0?=
 =?utf-8?B?cWNPZ3dRbEFpc3ZUUTd3Ulg5dXgzY0N1SzROS2ExUFVwNjh1TkFKa0ZiRmpT?=
 =?utf-8?B?ejJNb3AzVzVnNE95UW1WdlVxdERBUEJRQTBPUk9vMkI3cFNEM3VxVUxlNEtl?=
 =?utf-8?B?cUJZZ2NTS2dkbkRRajNBNkhaUVN5dmhqWlQzNEJkTk5DU2pxTGxpVzRDeWNk?=
 =?utf-8?B?SUs2QlVVekRrcmtxUmtFclJNRkxwYzlucXgxS05EVEVyZlZFZDJIcmlzYWVt?=
 =?utf-8?B?OXdiMkJtTk84MVluOFBpdG5rVEdiUWprS0Y3VC9yenNsdEFFUEgxTGl2d3hp?=
 =?utf-8?B?Q0RyU0h4RUVWL3dvanIxTUZCQ1oza0ZJNmlQSGVoK2NRdmdUVEJuUHpGb05N?=
 =?utf-8?B?MFlkOXRsQ1dOOXFWSnV4TzJ2WTF5RmtKZW5NZUVOb0VLNnVsQ29CRHB6ekJO?=
 =?utf-8?B?aDFQNDVLVHRVNGc2eGJDeTc3Q3d0aklDVExNSlIrek9ETmhGczlSYnlxblpD?=
 =?utf-8?B?d094eHRRUzNIYmFJMU1nKzVJaHRYVTRBckdlYnNRejRqMXlOaTM3UDl2SEQ0?=
 =?utf-8?B?L2hHTTc4TkVOK08zM0ZwdWNnNVJSZ2d5RW55Z0VUbDNYNHJWeWpSRkRpY3dL?=
 =?utf-8?B?MlM1andROUV2NzEvd3g0MHpxVlZxQUlMcFhNbW4rNFFJNG9aK2d1K1p6dG83?=
 =?utf-8?B?T3E4WDNkNkR4dy8yN1Q2cU1XRi9tVTNxbVJyQTRMSHdzN1BkN3htdWp5MjhT?=
 =?utf-8?B?YmhrVWI4cXZzbDBycTFyYUl3SlNGakdxMVR4ejZ3bnorUnRRVTR1YXl4eEpL?=
 =?utf-8?B?MkIyV0ozbkNxZkVBT1BNUGdyQUp5bGxLNmhnK1ZJazZMcTd5MlJiM1A1Rzgr?=
 =?utf-8?B?ZFVOSTlpZGNFYjgxaG1ONS9BNHBEc0t1a2NpQVlrekNDUjlPMnhnUllQSFhM?=
 =?utf-8?B?Qm5HRytlL0p1STZsdU8wcGpFU2J4Sk12a2kvM3pDTzlRa1hMVTlRYXJDa0dj?=
 =?utf-8?B?cVg5THFnQXpNaFRpaGkvUlhuUG5xRVRkbzhURWdibnRBQXdlYnNYN1gyY3hy?=
 =?utf-8?B?cGVHeEIrc2NyNjdjSWQrWlExaWRjM3JBUXYzNTlIam92YzhOTm9sTlBsd0Zy?=
 =?utf-8?B?NHdleHB3WXlUVkFTQWN6b3g2L2FtRFVpSzkyZGFSTUZBZTRXeG41WTlDMGhq?=
 =?utf-8?B?c2FxMitib0hQYUxsbm1JVjVoRnF4L1ZIQ3VNMllZc2RFMWRpeWJUNFhmTnQv?=
 =?utf-8?B?TFIyK1laV2NXbkh6OWZCY1JDYzhsWGdRWEZYaHBZNTRUbWdaTm0yOHMySGcv?=
 =?utf-8?B?S1U5b01lTzkyUFcyQ1Z2LzdOYVpxRlB1b0g5NGJ2WHk1NEhMcEsvY09zdU9v?=
 =?utf-8?B?djYweDBoK09kMTZDNUtkZzIzNGxyQ1ArNkNIa0h4T3FkMUM5TnNYUkVlQVZp?=
 =?utf-8?B?Y2xLWXhSUDZjbU1rNFFKME1qZmZRU2lZUjRGSFZjU2tPZ1VodDRXVW9KV3Fv?=
 =?utf-8?B?cmpLT0JHdGdNVkhaV2s4UlByTnVsWXhWdHZWdW9PYXd6dVdtMC95WlMwQ1pS?=
 =?utf-8?B?aG80a3g4ZE9LNkIrb1UwZjdXMnlnaXlnNlk4bXpkbXVVM1hnbnhVRmxoODJJ?=
 =?utf-8?B?VGx1Nm5VKzhWN0dNU3JYNGpVa0VZaGlheDlWeFRpdGRrdnNsT21jSlpXTS92?=
 =?utf-8?Q?FfmUTGtdFNxXoCtE7KcOh1sl57b6n4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk1DRkN6eE5KaFlzWEhlbjdzY2dXa2V1L09qb0E2dEdGNnpTejYxL1JtTFN6?=
 =?utf-8?B?NHk3c0lQMElrRlVkdS9zSVd0V2hDNGRwak5sUG9zS2ZCZ0xVMXZPbVJjTjRO?=
 =?utf-8?B?NXUvWDExam9kTVJGRnNmZ3JkYXJzLy9vbG9qOHk3Z01sRlRZYXp5S2JoeVpy?=
 =?utf-8?B?RUF6SWFJMmt1UXZrRUZYbE11OEVtMzlWRkhQeGR6OFdUaVUraitSa1NUZ3Vl?=
 =?utf-8?B?ZWVVNW1VdldIclRzSll2eTVXQXAxRDAwQ2NLU3NvME9vdkJUM0xWU2VWekR0?=
 =?utf-8?B?VGprSm13THhnZG5jM3RpMlFJYjdsSG9qeHBxejZqSlR0VkZpUjVEYzNmY010?=
 =?utf-8?B?UkU5bVVzRGttMmRrOFlyVDhLTDljdDFqOUJmT2FmZjVxdWExK2FYVnJFTXBK?=
 =?utf-8?B?ZDdQalREOWo3NDRLTXZYVzJPZmFZVTY0dFFHSjNCcGtJVkp0Q3huRWhkMlNN?=
 =?utf-8?B?OTRmVmhrTzVSMVZpcXVpMlg1UytZRUM1N25paW9ibVF1bE9pRUhPVVhGaDE2?=
 =?utf-8?B?N1U4ZFN1cXl3bE53bHcxVzJlNzJaNGRLRzBRY1VWRGR1UVdqTCtNeWlramsv?=
 =?utf-8?B?eVdXcEdnMFg5NlZSZlBUN0cxL1lmcXdLQ2JJQmhjV1kzZkF0NjNDUy91RnRa?=
 =?utf-8?B?NU9BVmkxWDdNQlFGVzk4czJtazFtb2ZWN1ZycUdsdEZpcHZRcEZvZW43cmNn?=
 =?utf-8?B?QmlGL0Zkc0o2RDdoTGJwa2NWWEdXYVR2OXJwRUwwL1kvTHF4Vzc2cVE5UnA4?=
 =?utf-8?B?K0VHaEJlYmR3KzdwbzhJdXpFSCtjSHdrdGswUzFDVFZwOUJlM3FIbmFhUVhH?=
 =?utf-8?B?a05lMldBZGhDQTg4anl1alRiRkVuK2pMcFpjRWJhMFM5OXcvZDlKQ01ta2dV?=
 =?utf-8?B?cjRYVGg3V1g3YUluZW1GS3NCL1VOV0RWTUh4VUtXRmoyUFVQTTF3bVRIVDlO?=
 =?utf-8?B?S0Q2blJscE9NZTQvM3ZIYjJwVFpDZk5hd2FscmxZaEtNays2K1JiUG4wMlJs?=
 =?utf-8?B?NGVSeE12Z0grNStPTGVjekNHZ2lqc3Rnek5mci9mQjlOUWFZYktvb2REZzQr?=
 =?utf-8?B?a1RtZi9oSW80K2Y5STg0VFgxalFkUTJ6Smpmb1hCa3lFWjFnaE00YjhJMXZ2?=
 =?utf-8?B?WWk5UmFWWDdIekxSd0k2TlRQZ0xrYUNNQTZzSnhUT2NRVmhKWFg2WUh5L1NI?=
 =?utf-8?B?QXlBWm8wQTdIc0x4L25kTlVrVitEZHMzamxXcmoyeVdDZit2RXk2S2o0UFln?=
 =?utf-8?B?eW9Hd0V4dWRyd3BEZGZlTy9YdHowQk9XaFBTNGFNdjhBSk1zUkpVcGtTZjZU?=
 =?utf-8?B?Sk5sdjZMYUpXR21QNUh2VUpxWHdQbGp1aW9DUnZRNndjak83Mllqbm9uWlE5?=
 =?utf-8?B?RlF1cWg4Vy8zUkFpZlpxOTVvenR6QnMydmROTkI4citGT1VoWlJjeWVFSEZU?=
 =?utf-8?B?ZjJ4eE5ick9MSTV1U1J2Qnc1eDUvMExzc1RsSzI1VHQ0Z2o4SjFWNExBMHRG?=
 =?utf-8?B?aXRidG9SSkhXMUlLNUE4ZHF4NFVWdDVZYlpTN3A1L01GMUd3dnYzOTdLR2li?=
 =?utf-8?B?TnZSUXJMZnBhbzNQRzVPWitMQ2dZZWgwanVFQndZdE9ZOTBVU0x4QXd2TFY0?=
 =?utf-8?B?ZjdaMElVY05aQ09DSGNpdCswUzkwMzlUcytmNXVMYlQwcGs2Z3FKMHFGbXBx?=
 =?utf-8?B?RGhURXJtTGJ1SEowWDdXbzhoQm5Ed2lyNWw0ZEVmVjNOakovU0JXeUN3ZXNo?=
 =?utf-8?B?dE1raS9uMXdNaEQzSlNzMDdvZGI0VEJNUVE3QjArVEZmNm9hT3l2OC9hZUV4?=
 =?utf-8?B?d1pxeXN4aXpicjVHWFo3NTNCWUhDSzlHVzFLK09ZNlUreDd5WkxQN1FEdnYx?=
 =?utf-8?B?bWFhSEptcG9hZUVQdHYwQmtpUWJwaUFnQ2VMTEoybzJ6aHVHdUI2U0ZCUEJV?=
 =?utf-8?B?SnVOdEE1bXlUYlJaSXhFRTBNV0JLMkFNTFFrSWF2SmN3dEpxd0dnd1NZZFJT?=
 =?utf-8?B?WGUvZXF0YWRub3k0WThVQzdTcEQxRVNZTHJxdWw2RVdqMmVLbmZEZEd1QWtT?=
 =?utf-8?B?em8vd1lacUVKY3hQZVh3QmxMTFN2NjVqVmlHTnBjdkdQQUhKQ1hMeDREbTNk?=
 =?utf-8?Q?q0pXpKMUA4WmagJ1MrhNwXvEF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcccb9a7-a722-47ef-346b-08ddfa921717
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 11:12:31.9140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKInf8WKot6kwFjKdpatNpEhkj2Dd2DDPKTTWb17P8J8c49VofaotHRMN+u9RGqslK0u08EALrPSKr6cOgTmjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7919
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

This patch adds SPL Kconfig option (SPL_PHY_IMX8MQ_USB) for the i.MX8MQ,
i.MX8MP, i.MX95, and i.MX94 USB3.0 PHY driver, allowing the driver to be
compiled and probed in SPL stage.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/phy/Kconfig  | 14 +++++++++++---
 drivers/phy/Makefile |  2 +-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index d36a5f00ef8..420d7c7a44d 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -289,11 +289,19 @@ config PHY_NPCM_USB
 	  Support the USB PHY in NPCM SoCs
 
 config PHY_IMX8MQ_USB
-	bool "NXP i.MX8MQ/i.MX8MP/i.MX95 USB PHY Driver"
+	bool "NXP i.MX8MQ/i.MX8MP/i.MX95/i.MX94 USB PHY Driver"
 	depends on PHY
-	depends on IMX8MQ || IMX8MP || IMX95
+	depends on IMX8MQ || IMX8MP || IMX95 || IMX94
 	help
-	  Support the USB3.0 PHY in NXP i.MX8MQ, i.MX8MP, and i.MX95 SoC
+	  Support the USB3.0 PHY in NXP i.MX8MQ, i.MX8MP, i.MX95, and i.MX94 SoCs.
+
+config SPL_PHY_IMX8MQ_USB
+	bool "Enable NXP i.MX8MQ/i.MX8MP/i.MX95/i.MX94 USB3.0 PHY Driver in SPL"
+	depends on SPL_PHY
+	depends on IMX8MQ || IMX8MP || IMX95 || IMX94
+	help
+	  Enable support for the USB3.0 PHY in NXP i.MX8MQ, i.MX8MP, i.MX95, and
+	  i.MX94 SoCs in SPL.
 
 config PHY_IMX8M_PCIE
 	bool "NXP i.MX8MM/i.MX8MP PCIe PHY Driver"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 98c1ef8683b..5a6df0ecfeb 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_PHY_DA8XX_USB) += phy-da8xx-usb.o
 obj-$(CONFIG_PHY_EXYNOS_USBDRD) += phy-exynos-usbdrd.o
 obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
 obj-$(CONFIG_PHY_NPCM_USB) += phy-npcm-usb.o
-obj-$(CONFIG_PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
+obj-$(CONFIG_$(PHASE_)PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
 obj-$(CONFIG_PHY_IMX8M_PCIE) += phy-imx8m-pcie.o
 obj-$(CONFIG_PHY_XILINX_ZYNQMP) += phy-zynqmp.o
 obj-y += cadence/

-- 
2.43.0

