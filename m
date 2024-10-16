Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F308D206A5
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:19:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC41B88B16;
	Wed, 16 Oct 2024 09:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tzK/bKFi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F27DA88D3A; Wed, 16 Oct 2024 09:19:01 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16CDB88B16
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X29F+nrZ1HTHpoTzfrYy8qQXwU1wiDClxyBNMgqvcD1ATuOmMkJwimrMt7VvrFemG3LXpyB7oSn8xr4UgyZcwnIFLgKGrb+cQwMo5Wi2Hr97aQe1IIcIIiUEb4xgnxCYAxoT2qsgpY/MNfvfoIj9cV84bEZxdbxsM9qAcd4klagAAmoF8hvr/hhH4+p9pRiVfcRSKYmfgIqc3swQyyRMp49E8tnZ4ZLMjXPaZ15qdjb+MOTfepduZ2SHPfR0ZngqFBC6HK363EBPY9FK3+GIxh9FWcgplxXs+aVE4lqEjmTCC6J73tePovIqzke2LfEnkoZLzGVWU7lJLvXZaYVNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAIF9z+sBYZpqcMW+hqU/7IXTds+gFiyN0DzpPGUicA=;
 b=QdGgzEmJxqV1kfcfFggSB6vJaR98hXic6d+PywLvM0Uz81hzLmg/ChZxc6SMs+jM/2X4VXu4H6lyBl9jg86PmiItUzaqZUBah+4ISYDDYle7yfvQOp9fk678QvJkBW5ct1eMbPvxgzS3dRcnE8hvpjg7md8vsxIWkFVx8R1GU1HXi2dBct9wITf5Jdku6bu8QbRzkhzBage2f4TXmufGzW1agGTaSu6WujqqVf0Bl7MQmqPRXsVCqi1x9DdGtEbQTnULNvYqXxW+vy5Q1TfpqwDMcaWUq3M/g+BrkxQkHVCYTPBv12/1258ShChPlyZlTZF700zZLFuS54GM12GYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAIF9z+sBYZpqcMW+hqU/7IXTds+gFiyN0DzpPGUicA=;
 b=tzK/bKFi2V4CmMDKed19uWU7ffMPKl6rLxsSq6hbbXUASQ53Dqrb9XWmiIY+nHCZOHVH4PxQICq03yvpu/eZ26vDkx2qiSLKPHiPd5N6Cf3CA6nmsyZJpiBW/o6VHWki/nk4RpwJHp6jXJfFk+FMHocsT/JqosY47TdHDCDfvXrZXowKr7hU8DSkEB0sfDyn8dgUYSw+euUodM0uZwYybk5VcmHgFl3v8ocRdnSkbbMalPxRUrSHpKK9QWVZMshLHuvJ702Alij86lJEu6+i6VcZeLwsKNX6BWQB3Za46KOlJ9ZC8Eh5j4ZsJxOYDMtFbkYKr+gpmGvzQ4n3dOQVsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS4PR04MB9362.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 07:18:55 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:18:55 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Subject: [PATCH 00/17] (no cover subject)
Date: Wed, 16 Oct 2024 15:17:53 +0800
Message-Id: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKJoD2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0Mz3czcCktTXZNkI4NE06TU5GSDNCWg2oKi1LTMCrA50bG1tQDXCqq
 EVwAAAA==
X-Change-ID: 20241016-imx95-4c20a5becc0f
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Alice Guo <alice.guo@oss.nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Viorel Suman <viorel.suman@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Teo Hall <teo.hall@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS4PR04MB9362:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b57e7d-430d-4371-5d20-08dcedb2cb43
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzhXRXMwakxVR21WeTYzY2RLay9Hd2ZJYUF2amFXREplY045cStpak5Ka0ZX?=
 =?utf-8?B?MWpXeW1FMGxoSVErWXE5aWdIK0RrRngwcnpOUXRaV3hXUnE5NVlWOStNSEJN?=
 =?utf-8?B?bWFGalg3cERSVnNWLzhGdW9ObEVzeFlEQTN2QWVQZlBsbXljSTVsRVpla3RR?=
 =?utf-8?B?MWRiLzVxMktTYXZ0MG16QWJxT2xtYnBodnk0TEtaWnYyR0EvVlBHVG03NDly?=
 =?utf-8?B?dG0zVk5DQnQ2VUt3WUtQdkdkL2szZU1zZVlzVGdGR1ZzRko4b1BZbytQQWhW?=
 =?utf-8?B?ZHIrZ0E2WllMWXJ3Nk9seDdTVytydEpYcHFuaVlTalRPZEFFM3lMdEdDNXA5?=
 =?utf-8?B?QlAyek4rMzB1RWJmQlR2Mm9UYUtqa082RHlkNmlBNUhWS1h6Z21FdmZDK1Zy?=
 =?utf-8?B?WGZQNUFCRUZlbGVxSXlBSDhaNlRCeVVEaUluMnlxdEc1MzIwYks3UmgvOHR2?=
 =?utf-8?B?SGZyUU42OWliYlJVM2p5dGtIdDdxVHJmVUE0NnVKcWxUS0pxeEFOamhFOHpO?=
 =?utf-8?B?SE9OcjZvY3UyVksvZVhHVGtDTDc5SHdVV3NGSjRjdDhjSk1GSU56dTJDUExL?=
 =?utf-8?B?aFAwZG5hdVJESmt0eC9DdHRSNi8zLzZlUUl5MEFSRWhyTGQ3ZzFNR1A2TmZD?=
 =?utf-8?B?NFhiZjBmT1BST1ZDd2hxNjFPNlFrUHVUQ3czVFMvYXZ3dDZLTlkvRGNFVTdU?=
 =?utf-8?B?Q0ZWYVZiV2M5RDBsWDdHTkRqa0U3Y1JVREVUVWEvL3pLc0lueVV3LzJqekRC?=
 =?utf-8?B?bkpuYUErY1VuU2M3dHJwSzJKTUdwczh1cXJITm9pb3VEeTZHQ2RrVUxReGVH?=
 =?utf-8?B?dS9ldHBIUDUvV0oremFDT3Mrb2p6eXY4L2xPU1RzY2xwMmlSQm1laGV0UFhL?=
 =?utf-8?B?L3RMNTBmSDZWWWZ2TGQzNVdUVTByeUZPRXlIZU5UTlFrN0JiMDlVUnFualFY?=
 =?utf-8?B?TndXK25XcTl6Y2MwdC9kdk96MWk4cldlTEV6UThWQUFubDk5SGVZOFhTVGdv?=
 =?utf-8?B?b3pLRys5Mm4zRG9tZEd4YWlYdkNZcTZVZzcrL1FtV2lwaEFyalRyMXRJUzZo?=
 =?utf-8?B?U0VFUkEyaEFCWUp5V0lONkZQbndqbE52aHd6MjVVcUhLM0s0Nk10WlBkcUN6?=
 =?utf-8?B?WVd5cE5YSVlGek1QMmI4dVBaNU5DY3FhVi8yNTZhZmJCSzBDVjJONXZlMUVH?=
 =?utf-8?B?c3gwU3lxYlFPdWJNSkErV1lreG1WLzdvaVdkRXViUlVDSURUL3ZlT0xrNkRE?=
 =?utf-8?B?eStCWUZpZmI1c3RTM0dtM2xUc1JvNU1TWGwwOWVmN21TbFlhK0hqQ3RSdW1D?=
 =?utf-8?B?WVREOUFjNEhNWVpTZU5lSFlIdFhTOE4vTmZEajBlUzdiL1drbHdvd05Za1dw?=
 =?utf-8?B?bExkUjkwWDZYNmVDeGxUTEZSaTdDYW1MS09hdW5jMHFGa1Q5d0o1cWdSa2h4?=
 =?utf-8?B?V01GQURhVFB6SjR4VzFKcUJGWFV5OGNCT1hhZlRVUWQ2RmxQc3kyeFdWaTZL?=
 =?utf-8?B?bjJQS0dpSU93bW9zcjVpY0M3ckEwZXFsWldRYkhqOWhKTlBCTmtlWWxuTnZj?=
 =?utf-8?B?TmF3TnBaZVlmd01hNXFZajJZZzRUTXJMTWdaWnhlQnJtWUJXUk9sRHdocGc1?=
 =?utf-8?B?RU51Tm1tMk1mMnY4NEE0N1dIT2tVNWVNRmZSc3RzSUhVSFpLSVdKdit6WFRr?=
 =?utf-8?B?UXc5Mk5hUzV6emRHam5BamV3bnFyVTNBbGt1cXZWc2tkOHIvWmNFV29wQkF0?=
 =?utf-8?B?OGtkeUdCTHlqVCtkV1BuQTdJN3VzLzRPbU9xVXNJTXVmK3ZoZzhzb3l2Wkw0?=
 =?utf-8?B?a2xwUlo5RUJoNHJXNzBzUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NS8wSEp5MnUwUHRweDR0OS9URlBFV2liY0xtMkluVytsU2E0dXJIdzF5bWxp?=
 =?utf-8?B?Qm1hTjNDUDNoT04xazN5b2pEK3dYTkw3bDFxVm4zN3RTM0hXTDROSDgxVFpZ?=
 =?utf-8?B?dzhOeVU4SzlITW1kaDl4a05xOXhoRmFmdU9ud3pFcUNtSFZxUldhZVhqUFZX?=
 =?utf-8?B?a01FOVFralUvanpLZXBpWjV3cCtPOFB0aytrcmkwaVdYUUxlYnNXcEJPc0lo?=
 =?utf-8?B?NEM5UlFSOG5tMWZwOWtDRnEwbW5wVTNUdkRtRDZhUE5sODcvbWpuSUxFL0hO?=
 =?utf-8?B?ZndaZmxVUDc3NGxmMWlrMk9hb29NbDNwbm1QZHJ5Vng3RkJxZ3JFdGhQNXVn?=
 =?utf-8?B?VmZ1UnBRTTg5Rkp6eWxEeEVKMmEweW1SVGgxQVRBN1lnRGU1SUxoUTR2REJT?=
 =?utf-8?B?cTh4Y0hWaEZnbndjV1lwb2pnRElDcFdjMWUvdi9nY3BybHJLcHV4OS8zcTEx?=
 =?utf-8?B?ZThhdnpZY2ZjN3RFWGF3dTMxdUNEN0xNMHZtNUw2NzNpOGU4ckNKN1UrcTFS?=
 =?utf-8?B?cnBRWkMzOWkxRzBBVTRvRFJrK1NycCtoQ3paTkt0UmthUS9mVVFkbmRPM0gy?=
 =?utf-8?B?ZU52TmtUWEszOUEwOVBhbmROcmdVWStvc3VvdTRtaFBkVDBTNThRbEQ3SEZC?=
 =?utf-8?B?aDBzaVFsUjJncHI3OG5kY21UazRnSXNTNnBLL3ljeWs3ZTMya3FjWjc0T2w3?=
 =?utf-8?B?V0FSMHdCN0dYekd5N09YOUNxc25icmRWSDI3UDFyMTdYSXF0Y1FGNHAwWS9r?=
 =?utf-8?B?aElWeFMzaU1SZ25yQUpYNlhERksza2s0cmd1a0pwRzhYdEk2R0VJbWtvNi9y?=
 =?utf-8?B?TUdsbnJSR3UxaG15OUdXMkVVemIvZWp4ZTVHQ2NSWkI4NTI3Tlp1cjhFdFdM?=
 =?utf-8?B?OE1BVVpXWjRJV3RZTWx4QmI4dmxJV0locURDakcyUXhheGlKL3pBS2hTN2ho?=
 =?utf-8?B?NHVNWmtsc3M4R0pSU0FuM1lFYjdJV1VBNXVPWkQvdDBuR2dsd1IvczBVL0Zx?=
 =?utf-8?B?OTNTSDl4alpHTFBPR0VzanpzaXFxbFByYkJjQk1zZUN5SWZza3d3U1ovRUhQ?=
 =?utf-8?B?S1MxMFk1YWQxMnd3Z3p1RGJTU3J5WXhheDZYV2VYbG1XNjJOc1NBWDRtczZs?=
 =?utf-8?B?bCtiVnFpYW1JQjR3TW85ek1WdFhYTVQ5ZHV3b3dZeklDZVBYWXp6c0FyQVVq?=
 =?utf-8?B?ek8zMzV0M2g5ZWgvRzhLRzEyK1RHSCtneWFZSmdXOGxrd2hOTnVuQUo0KzNl?=
 =?utf-8?B?QitOWlAzRGFJcFZkdUxEaDh1ZUJnblRjQ2k5UEMrUkEvckJCT1hZa0dreTkr?=
 =?utf-8?B?YzZKNUQwbmdpck15ZTRmaVZHKzFiVmQxK1pjbzh3ZTMrU1ZXdnZHUjBlQnBM?=
 =?utf-8?B?cHZnZWlQYkRBaGd2Z1Z0OHFhZjQrbWdWcTZ0eDBYQVNZY1BCd1IxdUppd2VF?=
 =?utf-8?B?SnE0MzBSbFJWMk9TcDkycTNHRVkyMERxN3NFbTFOb1REc2dYbDRPMUhycjFv?=
 =?utf-8?B?RUI5ZUl4Z24yZ0FkVi9uWWxlMTk3eVJtR0xSY3Q0bFBySklYaXJZZXdBbFFO?=
 =?utf-8?B?emEyNDBpdk9ULzEydjMrWFZFWjN5cXk5VGhQajRwYlIxaHVxb1dTRHg0cHZk?=
 =?utf-8?B?V2M1WUJaVmRIUUxkWVVVbGZLYUl5Y1RzUVI0ZUx1MkJhUXJrQWVWSk1QUllX?=
 =?utf-8?B?d2lYUGk4eTFHRG5EbytqV2srakJKSXB5cS9JN2dMYU9oNDNTQ3IvaGFSMTRT?=
 =?utf-8?B?MDNRTHN4UHNCVXl3Sm1DbWp5WnVZY0xnVzNHSENLYWdNSjVmenpVblZ2V0tu?=
 =?utf-8?B?RTRSb0FzWml3Q29hbWhVODVtbERzbG80MlZPbklQR3V4MjV6dEpGY0RaTlo0?=
 =?utf-8?B?aFBWZW9TcTZDRXVDcmt0WjkzSHorajFVNFpKV2xENzJtSmxrb0NJNzBac2RS?=
 =?utf-8?B?Z1BkYnNNbXBsYm1mNTVUWG9UbFdlUjZac1g5TEhEaXhJc1FFS0s1VCsyMlVS?=
 =?utf-8?B?NDJ1UlVXcytOaFo4YkFraG83MzVmNmh6d0JTTWxQSWZVcndIV0pERmxXa2RC?=
 =?utf-8?B?bXdCOEVZUDJ1WDQ1V2dVcERNa3pLUklWQVd1aG9zMDVGeFNmQTdTNTNLTXNu?=
 =?utf-8?Q?TLne2ojfyYLtdonojDcjlad/b?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b57e7d-430d-4371-5d20-08dcedb2cb43
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:18:55.2865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciYrophEZj73w/oIRS16GiNQWMG4foDDR++yzOVSIOWik2QTJoKOb6D/OYAxlxrsXryn/jFY+2oJhtrMqPaltA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9362
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

This patch set adds the basic support of i.MX95 and has been tested on
i.MX95 19x19 EVK.

Signed-off-by: Alice Guo <alice.guo@oss.nxp.com>
---
Alice Guo (1):
      imx: Kconfig: IMX8_ROMAPI is not configured for i.MX95

Peng Fan (7):
      mailbox: add i.MX95 Messaging Unit (MU) driver
      pinctrl: nxp: add SCMI pin control protocol driver
      scmi_protocols: add SCMI misc protocol protocol_id and message_id for getting the ROM passover data
      scmi_protocols: add SCMI Performance domain management protocol message IDs
      clk: scmi: add the command CLOCK_PARENT_SET
      imx9: scmi: add i.MX95 SoC and clock related code
      scmi: add the macro SCMI_MSG

Teo Hall (1):
      imx: add V2X container support on i.MX95

Viorel Suman (1):
      firmware: scmi: smt: Interrupt communication enable

Ye Li (7):
      clk: scmi: check the clock state/parent/rate control permissions
      scmi_protocols: update struct scmi_base_discover_list_protocols_out
      imx9: add i.MX95 Kconfig and Makefile
      imx9: scmi: soc: Override h_spl_load_read with trampoline buffer
      imx95_evk: add i.MX95 19x19 EVK board basic support
      imx: Support loading container image from RAM device
      imx: Fix ROMAPI driver to load container image

 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi   | 172 ++++++
 arch/arm/include/asm/arch-imx/cpu.h        |   3 +
 arch/arm/include/asm/arch-imx9/clock.h     |  10 +-
 arch/arm/include/asm/arch-imx9/gpio.h      |   2 +
 arch/arm/include/asm/arch-imx9/imx-regs.h  |   7 +-
 arch/arm/include/asm/arch-imx9/sys_proto.h |   3 +-
 arch/arm/include/asm/mach-imx/sys_proto.h  |  44 +-
 arch/arm/mach-imx/Kconfig                  |   2 +-
 arch/arm/mach-imx/image-container.c        |  90 ++-
 arch/arm/mach-imx/imx9/Kconfig             |  13 +
 arch/arm/mach-imx/imx9/Makefile            |  11 +-
 arch/arm/mach-imx/imx9/scmi/Makefile       |   6 +
 arch/arm/mach-imx/imx9/scmi/clock.c        | 328 +++++++++++
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c   | 148 +++++
 arch/arm/mach-imx/imx9/scmi/container.cfg  |   7 +
 arch/arm/mach-imx/imx9/scmi/soc.c          | 872 +++++++++++++++++++++++++++++
 arch/arm/mach-imx/spl_imx_romapi.c         |  47 +-
 board/freescale/imx95_evk/Kconfig          |  12 +
 board/freescale/imx95_evk/Makefile         |  11 +
 board/freescale/imx95_evk/imx95_evk.c      |  75 +++
 board/freescale/imx95_evk/spl.c            | 119 ++++
 common/spl/spl_mmc.c                       |   2 +-
 common/spl/spl_ram.c                       |  34 +-
 configs/imx95_19x19_evk_defconfig          | 189 +++++++
 drivers/clk/clk_scmi.c                     | 134 ++++-
 drivers/firmware/scmi/scmi_agent-uclass.c  |  11 +
 drivers/firmware/scmi/smt.c                |   4 +
 drivers/firmware/scmi/smt.h                |  10 +
 drivers/mailbox/Kconfig                    |   7 +
 drivers/mailbox/Makefile                   |   1 +
 drivers/mailbox/imx-mailbox.c              | 417 ++++++++++++++
 drivers/pinctrl/nxp/Kconfig                |  13 +
 drivers/pinctrl/nxp/Makefile               |   1 +
 drivers/pinctrl/nxp/pinctrl-imx.c          |   7 +-
 drivers/pinctrl/nxp/pinctrl-imx.h          |  11 +
 drivers/pinctrl/nxp/pinctrl-scmi.c         | 136 +++++
 include/configs/imx95_evk.h                | 148 +++++
 include/scmi_agent-uclass.h                |   2 +
 include/scmi_agent.h                       |  11 +
 include/scmi_protocols.h                   | 101 +++-
 40 files changed, 3156 insertions(+), 65 deletions(-)
---
base-commit: 28dc47038edc4e93f32d75a357131bcf01a18d85
change-id: 20241016-imx95-4c20a5becc0f

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

