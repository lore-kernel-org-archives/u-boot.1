Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D411C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB1A807CD;
	Wed, 15 Jan 2025 14:30:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="v9X73bvv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E70FD80703; Wed, 15 Jan 2025 14:30:23 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93734800C2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEPwI9NbLYo80zm/idG5WpynW9ILzu5Rt4ToCBtPBfI71KgJvOn5NLO+QWtoLNU+3fip/yeyafteJFT+NPQ1gLXyMSCa3vEy1YsmOhfWfKgvbLiq7Nq+zlkl/NUgm2CJSU6XXiJ3pyHK34DbucDwrE76oxtVtu16A0PC0jjz0ZtQ3BJ1onkeRXCJ6ibI4j+W4nwuaCXHvLQ+Zmwhg09roo01eJWMBZ8kdpERVY2xPq/Jw46uoLLEak6qwUXKfgVH6JjFLRziKN1xL7sQg8joQFtN6ETE8/qNrwJOAPVp/wKCP5ORz6PhsN4I0w7OUHvByXXLdKraKJWOIVM/V68bNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v18yble2QdP2jT3pTpbiRviglDMLfL6iRoGn+SU1TGQ=;
 b=J5CcA7M9Mo3FV89TcC/2cplUfcSHVl7kGSA10XuwK+x4jkYi0BQY9qRK6H1XQMDctYWfZgkpFp9yrN11c+dZDrU2+ahNyNYbt3OygGeD6hxM9Yoco0YA4zkWQpBwQH/H7PBtSyDc32zfBZYO3/g57DOMwe63mK8EDaya67iWruHov7596FuyXu80dDXSOINpXjErJpAqVedqPRJwpBejXtSw98KHEDuajU9qN8a3Tpht69uUwYQMZakQDzDrcqgRt7YzQNIiwTtYiM1oe7mA11X6xs8Mhz48XIP7J1P3t5D7d0FTl4mVX2eLbuT1cSNjI04AvKQTTxwITenlaJK7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v18yble2QdP2jT3pTpbiRviglDMLfL6iRoGn+SU1TGQ=;
 b=v9X73bvv9Hb2Bap1lVKPmo9l4ZL/hlJmnYN/DQxJbk+bHsFVPSH+wnSs/CG4g/xDO6UpSEyiw+pYB1PqHWNRwPXmTs49pP2A/l7Ot20k9zz68FWx7+B/8Nv7VpDcOThJFwL/N7NIRLZHGMyyN70ubbjFBc9css7NoT2Vp96GEZchyTC8jlU2OtsN5Hhtna0kS0+ZCh5XwFHZF62WvkpNMDWC6d8dUj+ixt9lJTFqsDZyAI34l9zRxxDiBzsjZ0vI/EexrpGiOAlEp2Ka8oCDysAcRnjQ3QHPw35hNW7LX2Ctw4x9nYtwD1YdTWVczd2mWzsHYW3FIkKyrPZgHLN0dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8593.eurprd04.prod.outlook.com (2603:10a6:20b:424::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:30:17 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:30:17 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:29:04 +0800
Subject: [PATCH v4 17/20] tools: imx8image: add i.MX95 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-17-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=14298;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=I1chBRPo7grdfJwCVxzFAo+YXmKfWsA5jWb6XXUn58g=;
 b=8NEXIxxrYDBmZ698pCeRffezt2GmlkLlL9FG0eqcFgjPy/78H0Mo1WIm5yHoCFM9nZ+g9/nHx
 pQZ9TaJSJgjBA8DONGBNveZBLVvBLmEzVld59GOkoYeXpnjbHnhpL7j
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: d244b1fd-145f-4602-a725-08dd3568c015
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzZVZVpicUl1UHRPaHFoQkNJSm9lVFQ5aXltNWpwVDFZcVFJcEdPaUEvT0xM?=
 =?utf-8?B?MjBqSzFzYTlFSGs0Z3hJRjR5cXYrWGF3VU5SWEE0U3BjTGw5TFNYZHU0TTJG?=
 =?utf-8?B?R3JNM1dWNFpnc1N5UFY2V2JIcW03QmVOSERUd3A0SVJYVFVkd3UzSG54R0tB?=
 =?utf-8?B?dnJaWnhZT2RQSWFqNDZYK2RhaWJ3U21mQi8rZitPUzRScnV2OEVlZ1lSZGFW?=
 =?utf-8?B?UFNWUG9VKzdScGNYS1Q5N0d0cjd0dVhqNHBkWGRGMjMzdkRpL1VUenFEUzRk?=
 =?utf-8?B?eHE5Z1ZWMW1sMy9XTmt2K3NiM0hWUmIyMDJBVVZuQzRRVlorbXh6MUZFMS90?=
 =?utf-8?B?SlM0eDJHNzMvSG9xaUtKakhZeXo1aFhFV29UN1Vpcy92S3Q1emROQ05ndTJw?=
 =?utf-8?B?V3dKVTVOMVZnbXFtTCtiQjRvcU94RVZub2hpZ0V4am1Ea0FQSlNtVTFsREdC?=
 =?utf-8?B?NVFPb3N3YURNN0tKSXNBQjl0MDNvN2Iyd21CS1ZGZng0YXhINDhoZmFYUitk?=
 =?utf-8?B?NDRBOEczVGZZblFxQjhOUG5ybGkybTFKY294YkkzNGh0TmhQMHJ6Q3p6WTdT?=
 =?utf-8?B?Vnd4OXFuQ2hSM1NNRDc0WVFHZENwZ0dYeTVlcGNQcEtlM2FtNWRPcVMvSHJB?=
 =?utf-8?B?SnVyMXg3Y3Q4eGF1bUtzQmFFTHA5Vmg2d1B5VENra050YkcvVkJRTVVYOTNw?=
 =?utf-8?B?MnRNa3lrOHNzZ0pRNVY4WGdhUHNhVnFLaUZQc1dZT3RsMC9uN1d0QURjNmts?=
 =?utf-8?B?ZU1PRE5ZZldwN0lGWTJlQlpQYkJnelhCbjZaalRzM1dCdzVxL3VoOTNlQ09i?=
 =?utf-8?B?UVl1cnExOUhhWlJhMUczSkNSSTRWQnJaWVU3VFlmQ3pXbnpUNitCdDNCY0lW?=
 =?utf-8?B?TkE1VDRKQjhpMEVEUSt0dDQvOHVvNHk1VGQ1RGdaaERJQTVTc0hPQy9KMmUw?=
 =?utf-8?B?dkROaU04U1VjVUdEMWQ4aEQ0YmZackxxTm1pTDBGaCtzRFF4cWNZRFdyNGxD?=
 =?utf-8?B?V2VDN1l3SHJoL1AwNnRiMGcwVktyMk9kZHhuOXpiVWlUak5TZndTOWVzMm9L?=
 =?utf-8?B?S2MwcHRIUTFpZWMwWjZNeVd2WmlaVXZtS1ZVNWpsSGtWblN1OHQrOWlCVEhB?=
 =?utf-8?B?Visya3ZpSVIzb2FIQ0grdkNKdk1OT2ZPTHl0NlRXeXk5TTdUa0VBeHplMlkw?=
 =?utf-8?B?ejk4WHZ0T1hYMytpR3FrS2IrM2xvZG9Za3RXYUwyNWNaYmtwOVI5T0RYZlZE?=
 =?utf-8?B?ei91L0ZPQmdPRXg3eTJpWSt6SmlDYXdxek5FR01oMVRRZC9tTUdJYkNvak45?=
 =?utf-8?B?aHNtVHhIbUVQbFpITy83RUpzV0xkNTVZM0lOWUFkdnJ3UHRTL0NRZHpDaUU3?=
 =?utf-8?B?ajRGdWNwQ2dvVU9ETDhPbjVaUG1Xa2xldFlEQlJzR0dhTWtoOFNzUER0UGpR?=
 =?utf-8?B?RDBjMTNiZFpaYzFWWHdsKzRiblZBMytSNDNFcVhlOVdoNFZpbDR6eGpGN3VC?=
 =?utf-8?B?NDd5Q2ttYWFHR04zc1hmb21rY0RvT0lGWGZjYXNuUDM0RjRieEw4dWRRK1NV?=
 =?utf-8?B?NDdwc1RRWmI5cExyTTBWbHFaa2Y0QmRoTnFweTZKZjM1a0hrZVg3QjNJdkQz?=
 =?utf-8?B?UDZidm1EOHgzSXRJdE15WFJoZ3hXQ3dvSjJrNTBRSldERFp2OC9XYUpUN3ov?=
 =?utf-8?B?bWdLdDI1eEtDVW96dVhWQXpZQ2hBbGZvWThLR0xKRXZuckNlaTd5RHg1b0Y4?=
 =?utf-8?B?amlocWtUVERFWUxhUGQwOUlCMGR1TGJVVmhGenNiOW5vd0w5UEJhU0dXZXZT?=
 =?utf-8?B?RFd4TkdDcHhpbzY1dlk2RGpsdXhjQ01SeW43WXAzc1UvUWhaSHJkNkRVV3V3?=
 =?utf-8?B?ZEtrN1N3ZVNucVRkZjYrRGRBSWUrZFZHWFA5bUNWTlFLTmRaelBIWHhCeERD?=
 =?utf-8?Q?tw1xlOElUcTC8Qijgxu2zR6C/OLmwyiW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVFSelk0NDNuL1lLS0pERk1rdEcwVVNWd2lIVHR2Wk1FNzJMNHowakRUR1A5?=
 =?utf-8?B?ek9ld1UzUmFSNEhYdzNoY1FQNDNCRld6NzVmTEtTS0xzZXI5SGVMd0FqVUM4?=
 =?utf-8?B?UTJOUFFxZHhSUmlMNXphVEw4TCtSNCsySndNUEVsV2ZyUk82aFZkb3FaL3Fs?=
 =?utf-8?B?bk1LWXVOTzNMUGdtMEJZdnNveWpHL2FTK3ozSklhN1Q5MVNXUEFBTGRlWVRl?=
 =?utf-8?B?OTFPaG9IelArRHQ4L3VBRGNzZjVUczhpYzZGUmNielhNM1hSQWJtdGt5UWFh?=
 =?utf-8?B?ZkZLbUQvT3dleG1XVzBQSXlqcjdZdXQyY09WRmdwRkhYTVZJWVFIK2tzaGZy?=
 =?utf-8?B?SGdzWWJjTm4zaE9GSndqSWdrcXptS3krNTd5TDlNV3Q4aEc0MlE0QWxYYUZ6?=
 =?utf-8?B?U21lNmpuOERzRUNJemE3b2Q0Znp2bEhsTk45L3Y0ZFZnQzlhRzJzZkJkckYz?=
 =?utf-8?B?OE5FaXUwaG8wV1I5NUZpMm1UNUtjd3RjVWwzbVpVRWNabENQM3hWZEZFcGt0?=
 =?utf-8?B?cGdiYXJXMEk3Z29LN01nTFB6SjlZdkdISkpTM2IvdmxWemZPZ3FtTmNVdEk1?=
 =?utf-8?B?WFphVEk5SGIralFyOWUyTlJrQ21lN2NWcTBTYllCNTErR2pxcUV0WDVNUWZP?=
 =?utf-8?B?UzRJMkZ0dElxTHVvRjcySkEwMlk3clFVWWM0dEVpU3AvRE9wMXE2d3BaN0Ft?=
 =?utf-8?B?anM1UGk0YUNiMHM1dXB3SnNEY3dXTi9ZYXlaZzc4STZZTzcxK2xBZDJVVEY0?=
 =?utf-8?B?OW0wVjBsSEs3VkpRV3d5dGppdjJDdXJuRXB2WWFRYjU4R3NobnFmbmR5RTdZ?=
 =?utf-8?B?aVFkeHZlNHozbXE5VVdoVzJIcmhKd1RYVW5QTWo3OElQV3dmKzBTQzZsWDZS?=
 =?utf-8?B?dGxla0FaWnV3TTUvK1E3VUI4ZzB6WnhrdzZ4dmJaUmo1NmgybXhxcC9BQnE3?=
 =?utf-8?B?SHpFYytEMTdtdDUvWFpZbDVROC9TWTB5OWVVc1BueTNhQS9vS1NBSGNpTjUw?=
 =?utf-8?B?OUs1bGMydDNRN0djZmdmSU11NU85ZG9uM1J3eUZDY1R2L3I1WU9VaEhENHBZ?=
 =?utf-8?B?Y1RlL3dIelJiK2t4VGRxdGRyV04xbXdCWFVKRlc5WWNQSGFsNWo2blAyeWFx?=
 =?utf-8?B?NTg3U3loMzcwbFRtRFBrR0M3Z05USWpucXJPNUYyajZZRWFQMVBPSjdWd0Fj?=
 =?utf-8?B?bHdKZXM1MW5uZ1czUDhJNXdrZHl2VnloR2J5dkwzZlJEb09iamY1c0RkVmZw?=
 =?utf-8?B?WlVSYWt6VXBrTjFwbGFld0piaVFGckRUeXdBN09MdGcrZno3RS9mUWdudGxG?=
 =?utf-8?B?OU5ERiszSlNCWVJxQUlrQWNSbWRWeVY3anphYjFRQzlUd1ZJanZnQ01IWGlL?=
 =?utf-8?B?aUhOUnh6VFhZMWQ3b3UrTDBlM3RuRUJwRE5rdWJxSCtMWkQvbklUYW9VUzBh?=
 =?utf-8?B?WE5jbVp4RVZzMmVBcU1uRUUwbVAvd2pEN1VadEVzNkpraVFlODNSdElOSnFI?=
 =?utf-8?B?QmtpTm5tMUdvVVk1RjlIdUJxYzM2bTlRQTVseEFvSVBJNGYrK29rUGh0bXVB?=
 =?utf-8?B?M21GbGUzSTZEZjJaUFovMUpUZ2t5ZkY5TDVDTldiNUUzUXNVeDdscTQ3Rjll?=
 =?utf-8?B?N2tSZ1lvaEczMXJPRXlmcjcwc3FNeWNJVEhFNFBodk02K2p0L1V6VUxoUUsv?=
 =?utf-8?B?WU9nbElvMUhKSGs5NVFvUEVqYmFHeEVNOFBWSFpvVDd5aUNUajJwOWJ6TUZO?=
 =?utf-8?B?SGZZMnM5UkRLb1hsLzczSGI4YzRUZzBseFkxTDhsTWE3b0NMcVVwTXRGcUJq?=
 =?utf-8?B?RmxuRlNrV1hKNXE0OFE4QXFONWVHY2ZYNWc1M0FqQmR0T3I2NzNMQ0VCTTFC?=
 =?utf-8?B?TXRlOUloTTYxQmY5VkNiczd1OEZreFhHYjVtWDhPMGVOVkdoejROb0JXcHVK?=
 =?utf-8?B?eEZvaFRTci84SVpaR1pQL2VxajB1RTg1aElxOTdmU2xEVUVQSGRUTmQ0QXkz?=
 =?utf-8?B?cUw0OGhUU1VKZG16TlZtUTI0bW1XQzg2SkNmWEl3bzFsc0lJSXJldTdBd0sz?=
 =?utf-8?B?WUxBSjZ1WnZ5ZmVUWmFoK25Wa2RGQ2ovZ2kyTWRhVXRwZ0JFRHhaOTNJbzFt?=
 =?utf-8?Q?/bamIE2oPMmTHzdhJi2StViNe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d244b1fd-145f-4602-a725-08dd3568c015
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:30:17.3487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjYIe9fybiqNNHXuCiVGsTZjcB5SMmRTUq466SOfTBUFcTfdfPT4RUJK79NszN7LieoKW6dH/z75tPztCCLE7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8593
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

i.MX95 uses binman to invoke mkimage to create image container. 2 image
containers are needed currently. The first one is composed of
ahab-container.img, LPDDR firmware images, OEI images, System Manager
image and u-boot-spl.bin. The second one is comsisted of ARM Trusted
firmware and u-boot.bin.

Because DDR OEI image and LPDDR firmware images have to be packaged
together and named as m33-oei-ddrfw.bin by binman, so imx9_image.sh does
not check if m33-oei-ddrfw.bin exists.

When using "make imx95_19x19_evk_defconfig; make", imx9_image.sh will
delete the line for u-boot.bin in container.cfg. In fact, binman is
always called after the u-boot.bin is built, so imx9_image.sh does not
check if u-boot.bin exists.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/imx8image.h |  19 +++++--
 tools/imx8image.c   | 143 +++++++++++++++++++++++++++++++++++++++++++++++-----
 tools/imx9_image.sh |   8 +++
 3 files changed, 153 insertions(+), 17 deletions(-)

diff --git a/include/imx8image.h b/include/imx8image.h
index 6b95e93fb50980f9e86099b3103142dcbe38764a..b48e2b039698a225e152bddfe4b29be2fcbdc730 100644
--- a/include/imx8image.h
+++ b/include/imx8image.h
@@ -157,7 +157,9 @@ enum imx8image_cmd {
 	CMD_SOC_TYPE,
 	CMD_CONTAINER,
 	CMD_IMAGE,
-	CMD_DATA
+	CMD_DATA,
+	CMD_DUMMY_V2X,
+	CMD_HOLD
 };
 
 enum imx8image_core_type {
@@ -169,7 +171,9 @@ enum imx8image_core_type {
 	CFG_A35,
 	CFG_A55,
 	CFG_A53,
-	CFG_A72
+	CFG_A72,
+	CFG_M33,
+	CFG_OEI
 };
 
 enum imx8image_fld_types {
@@ -208,7 +212,10 @@ typedef enum option_type {
 	FILEOFF,
 	MSG_BLOCK,
 	SENTINEL,
-	UPOWER
+	UPOWER,
+	OEI,
+	DUMMY_V2X,
+	HOLD
 } option_type_t;
 
 typedef struct {
@@ -227,12 +234,16 @@ typedef struct {
 #define CORE_CA35       4
 #define CORE_CA72       5
 #define CORE_SECO       6
+#define CORE_M33        7
 
 #define CORE_ULP_CM33		0x1
 #define CORE_ULP_CA35		0x2
 #define CORE_ULP_UPOWER 	0x4
 #define CORE_ULP_SENTINEL 	0x6
 
+#define CORE_IMX95_M33P		0
+#define CORE_IMX95_A55C0	2
+
 #define SC_R_OTP	357U
 #define SC_R_DEBUG	354U
 #define SC_R_ROM_0	236U
@@ -246,10 +257,12 @@ typedef struct {
 #define IMG_TYPE_EXEC    0x03   /* Executable image type */
 #define IMG_TYPE_DATA    0x04   /* Data image type */
 #define IMG_TYPE_DCD_DDR 0x05   /* DCD/DDR image type */
+#define IMG_TYPE_OEI     0x05   /* Optional Executable image type */
 #define IMG_TYPE_SECO    0x06   /* SECO image type */
 #define IMG_TYPE_SENTINEL 0x06	/* SENTINEL image type */
 #define IMG_TYPE_PROV    0x07   /* Provisioning image type */
 #define IMG_TYPE_DEK     0x08   /* DEK validation type */
+#define IMG_TYPE_V2X_DUMMY 0x0E /* V2X Dummy image */
 
 #define IMG_TYPE_SHIFT   0
 #define IMG_TYPE_MASK    0x1f
diff --git a/tools/imx8image.c b/tools/imx8image.c
index 15510d3e712495c3508e130fcb2b4df42b07136b..9c4b43174558ec669f9a196c08756bcc6522b752 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -7,6 +7,7 @@
 
 #include "imx8image.h"
 #include <image.h>
+#include <linux/sizes.h>
 
 static int p_idx;
 static int sector_size;
@@ -54,6 +55,8 @@ static table_entry_t imx8image_cmds[] = {
 	{CMD_CONTAINER,         "CONTAINER",            "new container",      },
 	{CMD_IMAGE,             "IMAGE",                "new image",          },
 	{CMD_DATA,              "DATA",                 "new data",           },
+	{CMD_DUMMY_V2X,         "DUMMY_V2X",            "v2x",                },
+	{CMD_HOLD,              "HOLD",                 "hold",               },
 	{-1,                    "",                     "",	              },
 };
 
@@ -66,6 +69,8 @@ static table_entry_t imx8image_core_entries[] = {
 	{CFG_A55,	"A55",			"A55 core",	},
 	{CFG_A53,	"A53",			"A53 core",	},
 	{CFG_A72,	"A72",			"A72 core",	},
+	{CFG_OEI,	"OEI",			"OEI", },
+	{CFG_M33,	"M33",			"M33 core", },
 	{-1,		"",			"",		},
 };
 
@@ -144,6 +149,14 @@ static void parse_cfg_cmd(image_t *param_stack, int32_t cmd, char *token,
 			exit(EXIT_FAILURE);
 		}
 		break;
+	case CMD_DUMMY_V2X:
+		param_stack[p_idx].option = DUMMY_V2X;
+		param_stack[p_idx++].entry = (uint32_t)strtoll(token, NULL, 0);
+		break;
+	case CMD_HOLD:
+		param_stack[p_idx].option = HOLD;
+		param_stack[p_idx].entry = (uint32_t)strtoll(token, NULL, 0);
+		param_stack[p_idx++].filename = NULL;
 	default:
 		break;
 	}
@@ -221,6 +234,16 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 				(*cmd == CMD_DATA) ? DATA : AP;
 			param_stack[p_idx].filename = token;
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].option = OEI;
+			param_stack[p_idx].filename = token;
+			param_stack[p_idx].ext = CORE_CM4_0;
+			break;
+		case CFG_M33:
+			param_stack[p_idx].option = M40;
+			param_stack[p_idx].ext = 0;
+			param_stack[p_idx].filename = token;
+			break;
 		}
 		break;
 	case CFG_LOAD_ADDR:
@@ -238,9 +261,15 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 		case CFG_A53:
 		case CFG_A55:
 		case CFG_A72:
+		case CFG_M33:
 			param_stack[p_idx++].entry =
 				(uint32_t)strtoll(token, NULL, 0);
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].dst = (uint32_t)strtoll(token, NULL, 0);
+			param_stack[p_idx].entry = param_stack[p_idx].dst + 1;
+			p_idx++;
+			break;
 		}
 	default:
 		break;
@@ -548,6 +577,7 @@ static void set_image_array_entry(flash_header_v3_t *container,
 				  char *tmp_filename, bool dcd_skip)
 {
 	uint64_t entry = image_stack->entry;
+	uint64_t dst = image_stack->dst;
 	uint64_t core = image_stack->ext;
 	uint32_t meta;
 	char *tmp_name = "";
@@ -557,7 +587,9 @@ static void set_image_array_entry(flash_header_v3_t *container,
 	img->offset = offset;  /* Is re-adjusted later */
 	img->size = size;
 
-	set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	if (type != DUMMY_V2X) {
+		set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	}
 
 	switch (type) {
 	case SECO:
@@ -579,6 +611,27 @@ static void set_image_array_entry(flash_header_v3_t *container,
 		img->dst = 0xe4000000; /* S400 IRAM base */
 		img->entry = 0xe4000000;
 		break;
+	case OEI:
+		if (soc != IMX9) {
+			fprintf(stderr, "Error: invalid core id: %" PRIi64 "\n", core);
+			exit(EXIT_FAILURE);
+		}
+
+		img->hab_flags |= IMG_TYPE_OEI;
+		if (core == CORE_CM4_0) {
+			img->hab_flags |= CORE_ULP_CM33 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_M33P;
+
+		} else {
+			img->hab_flags |= CORE_ULP_CA35 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_A55C0;
+		}
+		tmp_name = "OEI";
+		img->dst = (dst ? dst : entry);
+		img->entry = entry;
+		img->meta = meta;
+		custom_partition = 0;
+		break;
 	case AP:
 		if (soc == QX && core == CORE_CA35) {
 			meta = IMAGE_A35_DEFAULT_META(custom_partition);
@@ -586,8 +639,10 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			meta = IMAGE_A53_DEFAULT_META(custom_partition);
 		} else if (soc == QM && core == CORE_CA72) {
 			meta = IMAGE_A72_DEFAULT_META(custom_partition);
-		} else if (((soc == ULP) || (soc == IMX9)) && core == CORE_CA35) {
+		} else if ((soc == ULP) && core == CORE_CA35) {
 			meta = 0;
+		} else if ((soc == IMX9) && core == CORE_CA35) {
+			meta = CORE_IMX95_A55C0;
 		} else {
 			fprintf(stderr,
 				"Error: invalid AP core id: %" PRIu64 "\n",
@@ -686,6 +741,15 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			img->entry = 0x28300200;
 		}
 		break;
+	case DUMMY_V2X:
+		img->hab_flags |= IMG_TYPE_V2X_DUMMY;
+		img->hab_flags |= CORE_SC << BOOT_IMG_FLAGS_CORE_SHIFT;
+		tmp_name = "V2X Dummy";
+		set_image_hash(img, "/dev/null", IMAGE_HASH_ALGO_DEFAULT);
+		img->dst = entry;
+		img->entry = entry;
+		img->size = 0; /* dummy image has no size */
+		break;
 	default:
 		fprintf(stderr, "unrecognized image type (%d)\n", type);
 		exit(EXIT_FAILURE);
@@ -708,15 +772,26 @@ void set_container(flash_header_v3_t *container,  uint16_t sw_version,
 	fprintf(stdout, "container flags: 0x%x\n", container->flags);
 }
 
-static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
+static int get_container_image_start_pos(image_t *image_stack, uint32_t align, uint32_t *v2x)
 {
 	image_t *img_sp = image_stack;
 	/*8K total container header*/
 	int file_off = CONTAINER_IMAGE_ARRAY_START_OFFSET;
 	FILE *fd = NULL;
-	flash_header_v3_t header;
+	flash_header_v3_t *header;
+	flash_header_v3_t *header2;
+	void *p;
 	int ret;
 
+	p = calloc(1, SZ_4K);
+	if (!p) {
+		fprintf(stderr, "Fail to alloc 4K memory\n");
+		exit(EXIT_FAILURE);
+	}
+
+	header = p;
+	header2 = p + FIRST_CONTAINER_HEADER_LENGTH;
+
 	while (img_sp->option != NO_IMG) {
 		if (img_sp->option == APPEND) {
 			fd = fopen(img_sp->filename, "r");
@@ -725,7 +800,7 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 				exit(EXIT_FAILURE);
 			}
 
-			ret = fread(&header, sizeof(header), 1, fd);
+			ret = fread(header, SZ_4K, 1, fd);
 			if (ret != 1) {
 				printf("Failure Read header %d\n", ret);
 				exit(EXIT_FAILURE);
@@ -733,19 +808,27 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 
 			fclose(fd);
 
-			if (header.tag != IVT_HEADER_TAG_B0) {
-				fprintf(stderr, "header tag mismatched file %s\n", img_sp->filename);
+			if (header->tag != IVT_HEADER_TAG_B0) {
+				fprintf(stderr, "header tag mismatched \n");
 				exit(EXIT_FAILURE);
 			} else {
-				file_off +=
-					header.img[header.num_images - 1].size;
-				file_off = ALIGN(file_off, align);
+				if (header2->tag != IVT_HEADER_TAG_B0) {
+					file_off += header->img[header->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+				} else {
+					file_off = header2->img[header2->num_images - 1].offset + FIRST_CONTAINER_HEADER_LENGTH;
+					file_off += header2->img[header2->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+					fprintf(stderr, "Has 2nd container %x\n", file_off);
+					*v2x = true;
+				}
 			}
 		}
 
 		img_sp++;
 	}
 
+	free(p);
 	return file_off;
 }
 
@@ -837,6 +920,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	char *tmp_filename = NULL;
 	uint32_t size = 0;
 	uint32_t file_padding = 0;
+	uint32_t v2x = false;
 	int ret;
 
 	int container = -1;
@@ -860,7 +944,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	set_imx_hdr_v3(&imx_header, 0);
 	set_imx_hdr_v3(&imx_header, 1);
 
-	file_off = get_container_image_start_pos(image_stack, sector_size);
+	file_off = get_container_image_start_pos(image_stack, sector_size, &v2x);
 	fprintf(stdout, "container image offset (aligned):%x\n", file_off);
 
 	/* step through image stack and generate the header */
@@ -869,6 +953,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	/* stop once we reach null terminator */
 	while (img_sp->option != NO_IMG) {
 		switch (img_sp->option) {
+		case OEI:
 		case AP:
 		case M40:
 		case M41:
@@ -891,6 +976,30 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 			file_off += ALIGN(sbuf.st_size, sector_size);
 			break;
 
+		case DUMMY_V2X:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			tmp_filename = "dummy";
+			set_image_array_entry(&imx_header.fhdr[container],
+						soc,
+						img_sp,
+						file_off,
+						0,
+						tmp_filename,
+						dcd_skip);
+			img_sp->src = file_off;
+			break;
+
+		case HOLD:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			file_off += ALIGN(img_sp->entry, sector_size);
+			break;
+
 		case SECO:
 		case SENTINEL:
 			if (container < 0) {
@@ -962,11 +1071,15 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	do {
 		if (img_sp->option == APPEND) {
 			copy_file(ofd, img_sp->filename, 0, 0);
-			file_padding += FIRST_CONTAINER_HEADER_LENGTH;
+			if (v2x)
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH * 2;
+			else
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH;
 		}
 		img_sp++;
 	} while (img_sp->option != NO_IMG);
 
+	fprintf(stderr, "%s: %x %d\n", __func__, file_padding, v2x);
 	/* Add padding or skip appended container */
 	ret = lseek(ofd, file_padding, SEEK_SET);
 	if (ret < 0) {
@@ -979,6 +1092,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		/* Note: Image offset are not contained in the image */
 		tmp = flatten_container_header(&imx_header, container + 1,
 					       &size, file_padding);
+		fprintf(stderr, "error writing image hdr %x\n", size);
 		/* Write image header */
 		if (write(ofd, tmp, size) != size) {
 			fprintf(stderr, "error writing image hdr\n");
@@ -999,7 +1113,8 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		    img_sp->option == AP || img_sp->option == DATA ||
 		    img_sp->option == SCD || img_sp->option == SCFW ||
 		    img_sp->option == SECO || img_sp->option == MSG_BLOCK ||
-		    img_sp->option == UPOWER || img_sp->option == SENTINEL) {
+		    img_sp->option == UPOWER || img_sp->option == SENTINEL ||
+		    img_sp->option == OEI) {
 			copy_file_aligned(ofd, img_sp->filename, img_sp->src,
 					  sector_size);
 		}
@@ -1030,7 +1145,7 @@ int imx8image_copy_image(int outfd, struct image_tool_params *mparams)
 	fprintf(stdout, "CONTAINER SW VERSION:\t0x%04x\n", sw_version);
 
 	build_container(soc, sector_size, emmc_fastboot,
-			img_sp, dcd_skip, fuse_version, sw_version, outfd);
+			img_sp, false, fuse_version, sw_version, outfd);
 
 	return 0;
 }
diff --git a/tools/imx9_image.sh b/tools/imx9_image.sh
index ca78a57a19a06ade4792da6d2435cbc4fa07de62..6523d1a0ad109db2da29bae122a20b084c2522ed 100755
--- a/tools/imx9_image.sh
+++ b/tools/imx9_image.sh
@@ -18,6 +18,14 @@ for f in $blobs; do
 		continue
 	fi
 
+	if [ $f = "m33-oei-ddrfw.bin" ]; then
+		continue
+	fi
+
+	if [ $f = "u-boot.bin" ]; then
+		continue
+	fi
+
 	if [ ! -f $tmp ]; then
 		echo "WARNING '$tmp' not found, resulting binary may be not-functional" >&2
 

-- 
2.34.1

