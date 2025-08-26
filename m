Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358DFCA0EFA
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 13:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 289BB830E4;
	Tue, 26 Aug 2025 15:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kneron.us
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kneron.us header.i=@kneron.us header.b="he1LzQF9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1176E82DA1; Tue, 26 Aug 2025 05:36:44 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::71c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EC97809A5
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 05:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kneron.us
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chance.yang@kneron.us
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+pjLA3R0qyxhPvm17MFTYIYNZ+u4saO3HC8RCXneuPvQ47xfoYVEo+OQzPZQztaDxmHMoi8Foe9+z1cZ6nL+XiBfIOrnE6HDKBaCWJDvgZwvCD/DpjFUK4MLIb0Ko8KOkoZ7ERuLFQrIqkIm0RnsGuQzRhIarev8IlHeiw7KQoIjcoNIaMsOWylSpPFv+IRWFr/jMNsMjbq0X9pe16UbF5EZreAgg01C0BhNDMn5SJNy0azgG7PoQMp0Ov9lNGcJ1A0NjXFZ6c/MfUEg/q3egOt0SVj+CfhyiboRdB0DnPPOCXF66xbFs+blBIlIRxoSWQoi4sMUBe4Vvwz5y8kIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhE8Uu/CaLhj4tdk8Nuxlm64+8l0q7BmTIRZTuVE3l4=;
 b=H9WC+MhB1+CgUeaiphYH4m4W8qPuGRMRf5+yTOtvyjq8CCa/nD2vlgx0Xo/s7D9DoHr++RhsZeu3Uq0BRk93frpm/leYZy7awDE/svKqbhzVmhzhn7LPA4OBbuArLRXgpdnmvuEmQvyBEepjy1Zk64lWEe+7oul5ANh8mK9HXnuA9ot+8F643KUp7H1lTvEtHh/+mYIvVppHR3hc1GCa1XxI0q1RTSp4TC1jUDLieqk+NArWwOoUejNqdFQH8rN8KwV2p430/EJDvtzEGF09ZfOphswPHgJt0x5PO/a1jaJBAzKq2V4YSMaxeJn0Mk071DGwsvdguvV4cFd5/TV/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kneron.us; dmarc=pass action=none header.from=kneron.us;
 dkim=pass header.d=kneron.us; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kneron.us; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhE8Uu/CaLhj4tdk8Nuxlm64+8l0q7BmTIRZTuVE3l4=;
 b=he1LzQF974+zU+k9IuQcYo1rbp8nIxwR9m7A9FFQmanCDq27sL18nMJ8yx2sZIoISp5yRF4l/lqk0Udn6VLjpLcBgEhMfqfz8/zztm3AHFDLm1S8wvUzfO8BpzdYZXu/e8GBW/b/73JSgTwCdENG1+R+luH5Ib0P/kUpK89c6oo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kneron.us;
Received: from PH0PR14MB4360.namprd14.prod.outlook.com (2603:10b6:510:26::18)
 by IA1PR14MB5683.namprd14.prod.outlook.com (2603:10b6:208:3a1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 03:36:38 +0000
Received: from PH0PR14MB4360.namprd14.prod.outlook.com
 ([fe80::f91d:52ba:8284:3e02]) by PH0PR14MB4360.namprd14.prod.outlook.com
 ([fe80::f91d:52ba:8284:3e02%7]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 03:36:38 +0000
From: Chance Yang <chance.yang@kneron.us>
Date: Tue, 26 Aug 2025 11:36:17 +0800
Subject: [PATCH v2] fastboot: Fix has-slot command always returning yes for
 fb_nand
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-master-v2-1-30b787a2f9fd@kneron.us>
X-B4-Tracking: v=1; b=H4sIALArrWgC/2XMQQ6CMBCF4auQWVtTCgV05T0Mi0Kn0hhbM4ONh
 vTuVrYu/5eXbwNG8shwrjYgTJ59DCXUoYJ5MeGGwtvSoKTSspeDeBhekcTUGd00J22d1FDOT0L
 n3zt0HUsvntdIn91N9W/9I1ItaqH71g0Tzl2r7eUekGI4vhjGnPMXZ8cloZwAAAA=
X-Change-ID: 20250708-master-b6a53395df05
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, morgan.chang@kneron.us, 
 Chance Yang <chance.yang@kneron.us>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1634; i=chance.yang@kneron.us; 
 h=from:subject:message-id;
 bh=eIaTm3XZYwnFSUe1xIKPmBbwMXa5OA0JbXNyDZry3y4=; 
 b=owGbwMvMwCVmsuR+7eedxj8YT6slMWSs1T7wLWCPetAln6BHT1cV3Y581D1F0zxxe/aW4NCnV
 xinzw407ShlYRDjYpAVU2T5nK2037uled6tKz37YeawMoEMYeDiFICJzFBn+Cu+p/uqXlzpEsnr
 mZ9mTXdh4LB72bxheqxpsEnRqeWN3IcYGW5/bstz965YIhq9InDXxViH5+Xck6a5RQTwZoWp/f6
 +lxcA
X-Developer-Key: i=chance.yang@kneron.us; a=openpgp;
 fpr=F36B22BF4B84839EDAD48CBF34A4DF7DF3B933F8
X-ClientProxiedBy: TPYP295CA0026.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::20) To PH0PR14MB4360.namprd14.prod.outlook.com
 (2603:10b6:510:26::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR14MB4360:EE_|IA1PR14MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e893aa-dcfa-45ca-1be7-08dde451c36b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|80162021|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWlOVlQyczJjdCtEMFU1R1YyeWNKcDJFUlp5bDBLVnh1Nm9nb3h1V3I5anFR?=
 =?utf-8?B?Z1RvRXVxazdoNy93SXZCK3BwcHNGV1Q5Q0JvNUpkeUU0OGE4U3FrZERMQUFH?=
 =?utf-8?B?bHRtZ3VEUld4WlpXRTNQb3V6eUJDdnJZd2R1bnNVMTg4QlMxQjU1Vjc1VU5T?=
 =?utf-8?B?OXNzdW0vbDdPeG8vQmQrb1E5M2tISHk4VkJMdzNWZWFrNFdWRjZoRVV5Ujhl?=
 =?utf-8?B?RkdXTEs3eWx5SkwvcER3d2ZHK2JXZENFbEhxMWxNcFU0NktnLzFDUXBhZlNG?=
 =?utf-8?B?RnVpUmlTYXUxTVhGUkdEWTRWZU9jTDlhTHFsRWs2Z0tWWFkvUlpKWXpsZDE5?=
 =?utf-8?B?R1pGUUc4RFdBUTc3L0hkZTJEb3hxN0lKRmt2d2thZzVkRm03eWg4dE9sa1R3?=
 =?utf-8?B?T0tLWjh5STZOQllCbVN6TXRyeU1PUGdJRkRZeVlVOFlYRFp5MStvQWZ1eEYv?=
 =?utf-8?B?NGFId3pBZ08zNEdwZGlYaXcvYmdzdUMvNVFmMG56eGlsOVpyQ01zUzl4cHZr?=
 =?utf-8?B?OStVQUY4Ynh4a2htY1ViN0VxM3Z6ZzNsVjhJMVdOdDlxQVJjZVJuWldlUHh2?=
 =?utf-8?B?YUZGZzk5OU95bFhxWDdJRWhXSlJuZ2Z0VTVTSHp0OGJ2b0VtYjRQUnlyd1Fn?=
 =?utf-8?B?ejgrSTN0MjE0cEswZE92eUlsUHRSaUkwTDVWb3NFc2Fsb1BYM3REc0hYS0Q1?=
 =?utf-8?B?REhDb2c3VlRKT0VWVkJXMTQ2a0Raa1NsZjJxdnh2VmtyT29iMWFLNC9ObHVn?=
 =?utf-8?B?Qk92Q2RtNmQ2Rk5JejUxNEF5Qm8vdFgrYzhEdi9QZWtxZjg0NUxiNVdoWXlk?=
 =?utf-8?B?eGNWWEdXSlN4R2NkaTlnaXFhTEIzazhFcXZ4dlV3dWZjRHpLL2lvNUJ1cWRZ?=
 =?utf-8?B?VXFQdTR3NUw2YkRoRXlTUC9FQ3VlcmxPTG55Mzk2WW1YL1M3RjhHWXFEY3cz?=
 =?utf-8?B?NTBMeGVkK2hhVkJRc29nb3I1eE5pQnJkM0dlU0lWK0d6MW1mNHQ0TWQ2eTFY?=
 =?utf-8?B?NFJQaHdFbG5uaU5Oald1RTgvNndEVmFNR2lwd0xYb1BmNFlYWWpBZ0VNbEx4?=
 =?utf-8?B?eVJoR1lSMFROOEZDcHZPUTRNbDhVdDZaU0N1YXJ4eTZURkV4U2gwdzRZd3Rp?=
 =?utf-8?B?MDN0bnIyTFpkZUZkT2txK2IwcUdtenpXVDVXb2lvNUpQWFR2aWRKSTlQUi80?=
 =?utf-8?B?OS9EeVVaSU5NTm9aU09FQ2NsSzVqc05wYVhGVUp1dnRxTEJSSGtzWC9nVXFR?=
 =?utf-8?B?SEgzeVZta2F2SFZwU2d4MjBHK2U2elk5RGVnSVpyd0pzYzVlMFl6a3FqV0o0?=
 =?utf-8?B?QThHMWl2cDRWYkFLTXk5SDh4NVpOVlpNZHZ4dWV2T01xd3p5ckRkeGVWY04y?=
 =?utf-8?B?N0FlTlVlVFhINlR6NGRzVHlOaSttdUtCT1hxa1E3Rm9xNkNzVU1KbVp1b0Nw?=
 =?utf-8?B?WlVvZHFlSzRyZW1NTEtvbERoanF1alNoR1VYWVJLSTZtL3VwbmQ3SEg1a0Yw?=
 =?utf-8?B?ckIzR1hveXlOZEh3bHlPa253elFnWWZrOHFIM2tQY3dLS1lLcFJ0SkpBclpP?=
 =?utf-8?B?b0dlNzVLcDhra2hkSUM5RVkxUXJLZUtnbENUSWE1RjZZbGdPYWkybUZUOWR2?=
 =?utf-8?B?ZWMzYnZlaWpjY3hMRUoxOGxNczVXV2dpTnVHRjJZV0MyOTN3VWtZdVN0ZTdt?=
 =?utf-8?B?cWZGOGxwcjFaVHJpWlRoNVMyQU9UanJmRndidGQ3aEpmQ1o1bm5VeE9vQTNL?=
 =?utf-8?B?VWJTWFVZMG55OEE4cVFHU3VhQjFvcTZLM2VWRFkxUitWdENTYVI0NEY1Zlpq?=
 =?utf-8?B?Q3dkUTFCOTVOZnAzS3VhdGtNZERJcjRCVGZDNk1lbk5jQ09qMFlob0hYajVZ?=
 =?utf-8?B?RWJicVM3YWFodlBLaUd2YmRJNERqYVFwcnJwbC9WVDl2ZzhkclY1UkZCNmdN?=
 =?utf-8?B?UktlZTUydHo2UmtFWElGSjhBWWlLVFUxMC9QWjg0ZkpJcVlwamttWDBKZ1Vp?=
 =?utf-8?Q?k6hBQAsdF76ltu23RE3SanzoRPl3vU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR14MB4360.namprd14.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(80162021)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUJaSnF2UjFHU3QzM2ZBSFdZODVHN05lS2d1U2kyeDdnR1d3R1dPSXQ5MjZn?=
 =?utf-8?B?blhkY1o2WEI3OVp2d0lWYkJDd096bWhwK3IyZTZYc2Q5NXJZZHdNejdnaTZS?=
 =?utf-8?B?bjFaL3Z4NnVheUN5T2Mza0JINWUxOEJyemh2c3JUYldJOW5sd1VNb1UwQzVm?=
 =?utf-8?B?ZDN2RnJqeENJa21TQk0xTVYvdFRWNk5MZXZlTWFadWp3cUZSc1NSdE5tUmNO?=
 =?utf-8?B?bFh3T0RibU9uYmJIcE4zMG1nbW9LWEozRkllKzhXYll3UzZyMjZxZHR1bFlU?=
 =?utf-8?B?c1RjWk1wSDMrdm5xY2hUdVhhb3hoWldNQmRpMXBjKy90ZW1DOHpmakFWdHNV?=
 =?utf-8?B?T0p6SFovaFlHSSthbmZWUUwrRmUvVWdIaXVWZEROejd1WnZvUjJrWm9tOGRU?=
 =?utf-8?B?Wm40cUZFK29LV2lGV0doOEJHZXB3OUNDRmR1VEQra0w5TlA0ai8zMFpjOWky?=
 =?utf-8?B?Vnc0V3JlYjJJMXRkRFliT2RmRVNSTjBBUUdwc1pqTUhLK1ZqNWExSVphcThD?=
 =?utf-8?B?a3F2OFZ5N1lXdW11VTQ3MTk2YWxndVYxYnJZOW9VSFNjMEp3NTJoL2V1QTU4?=
 =?utf-8?B?KzVyZ0xNVzFqTW9QRnhURWlLakxaQ3VTSXdIajNSVVMyTWJlaWZ2ZWNvVytv?=
 =?utf-8?B?UkVDbkkxeUZaSml5WFZMNWdwQ3BNdmhrdGZkMzdUYmRkTE9DcmFOUzhNcU9E?=
 =?utf-8?B?bXp1VmpnTWRLajE1RXpRSVp4dXo2c096ZG8zSFdNZ2Q5RFljY2djZ2VTUHRz?=
 =?utf-8?B?Sm0za1pyWWhCYTJNUWNDNytlb1cyOUdMSnNIdWxSUnVDYlFUSFRpNVBiR3pD?=
 =?utf-8?B?dUdoUzZ3RFByZ25VTHZHdWNweVA4MkdDdXBOSFZMWkdzeGkwYUtRQTc5cllw?=
 =?utf-8?B?TEQyQi95M29lcTM2RlhHQ2NyQXJland0MWtRQWdnNHdYMnBNUjAwQk9UQUE4?=
 =?utf-8?B?ZGFOcG1jVTl4WldiVTdxOGJTUFB6em41SndvYXdGTTVaYVBLOUM4TVhZRnNF?=
 =?utf-8?B?YlBHNlJxY2Ewc1hKc2R4SnhCbC84UlZIVzhCaWx4ZmhpclBWNjdzb3dCeWxm?=
 =?utf-8?B?bERDblc5bmlaS251blNaQm5aK2NadlpnM1NOMkpBck43THEzdFdvcEhmVnpM?=
 =?utf-8?B?ZWFTVEdMSGM5SVRRWWY0M3I4YUhwcG9zVGVCbDVjVllRTHlQakdkQlJjZ0Jr?=
 =?utf-8?B?KzkzbjRPTmM2NCtpQlNZcDd0dkpMZjBtbCt2V2pmYjZLQnNsVG1vSkNWVWdB?=
 =?utf-8?B?Nk8wVW5OUit0ajJvQ0c4dVJhSWZWYWp4Q0grUXNIcW90cnZsZ2k4VzcwaGdI?=
 =?utf-8?B?UzZOY1oyQmdpeW54ZEtCdGowWklid1JKRGR0Z2lFUUdlZjE4ZGVVNmg5MW1q?=
 =?utf-8?B?ZlJobFhDMkFsc25qbVNqQk5WTDgwSHJ0M0FuL2VOTytmbTAwSU5BM3RiaFhX?=
 =?utf-8?B?QzVZTmlITzhpakV6Q3QwdFhzRWZ0OTJuRXE5WkZtTG9tSFJZVzduVStRR0xp?=
 =?utf-8?B?alhaclpJeFpnVTM5QXh6Y3FSQUtjNnFhL2FiWVJYYjNNSjRNcUlTTzdFTGc1?=
 =?utf-8?B?emlKT1RJMnRlY0ErWmliK2RuZUxpZHZzdDJKZTNjSXlpRm4wNk1oNzVxeEF0?=
 =?utf-8?B?WGRHSUVlTzZMN0hDSk42R3RLR3RZcVVUYVEzSFJ6ZUlSOTVXRWQ4emFyQVIv?=
 =?utf-8?B?V01wSzA2TmdrRkZuZWF1MkFGdFBuMzZOVzF6R0pnQ3pnZThHMEZKOFk5UWRm?=
 =?utf-8?B?Um9aTmtPSnBjV0M4SmFkU0pDSVI3Q3EveThIOFpTSmhTL0I3QTJJS2ViRGRF?=
 =?utf-8?B?QmlIbG9HVFNmT1dFakl5aTBXVXNxcEtnVTVTK3VsblRqTWRYZURpL2pOUFIw?=
 =?utf-8?B?dWpoOE9wd0xqSHFaVyt0OTZwdDZlVzhYVDNqelNIQUxXTXI2WEo3QU81L0pm?=
 =?utf-8?B?R1VCM3Y1UXN5WU81WE90ZTB5UUNUc3dIU2M5djRVOVFhMzMzajl0d1lWdk85?=
 =?utf-8?B?NVBZU3pVZDdMNlhaVCtCdXA0MVlUOVVMbDBQcS9qWnJSeGNONHVPLzZUNW4r?=
 =?utf-8?B?OEJUMVRHWnpYVml2Ny9OZjBuMDNvQ2FEQlZoQmVsMFVybmR5M3hHWXE3eDBN?=
 =?utf-8?Q?KQFNq+fOCP1fdaA6nPvS7+lgU?=
X-OriginatorOrg: kneron.us
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e893aa-dcfa-45ca-1be7-08dde451c36b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB4360.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 03:36:38.0921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f92b0f4b-650a-4d8a-bae3-0e64697d65f2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yGGFa2aUbBJrMVNSSbSV36tQ+5IkhbwONHDTJuAxa6MX5JhzLXyZ7MmtLEO5yvL1KE86udaufa8ahh2dIxOfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR14MB5683
X-Mailman-Approved-At: Tue, 26 Aug 2025 15:08:40 +0200
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

The issue was a mismatch in return value conventions between functions:
- getvar_get_part_info() expects >= 0 for success
- fb_nand_lookup() returns 0 on success, 1 on failure (from
mtdparts_init and find_dev_and_part)

When partition didn't exist, fb_nand_lookup returned 1, but
fastboot_nand_get_part_info passed it directly to getvar_get_part_info,
which treated 1 >= 0 as success, causing has-slot to always return yes.

Fix by converting positive return values to -ENOENT in
fastboot_nand_get_part_info to match the expected error convention.

Signed-off-by: Chance Yang <chance.yang@kneron.us>
---
Changes in v2:
- cover all the failure paths in fb_nand_lookup()
- Link to v1: https://lore.kernel.org/r/20250708-master-v1-1-574f8bec645d@kneron.us
---
 drivers/fastboot/fb_nand.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
index afc64fd5280717ae4041ed70268ccc01cfbb0496..6df3917e129556fef71640ebb1347c5eb86e648a 100644
--- a/drivers/fastboot/fb_nand.c
+++ b/drivers/fastboot/fb_nand.c
@@ -157,8 +157,13 @@ int fastboot_nand_get_part_info(const char *part_name,
 				struct part_info **part_info, char *response)
 {
 	struct mtd_info *mtd = NULL;
+	int ret;
+
+	ret = fb_nand_lookup(part_name, &mtd, part_info, response);
+	if (ret)
+		return -ENOENT;
 
-	return fb_nand_lookup(part_name, &mtd, part_info, response);
+	return ret;
 }
 
 /**

---
base-commit: d1d53c252a4a746db5ebcdf0d6de3aa0feec504e
change-id: 20250708-master-b6a53395df05

Best regards,
-- 
Chance Yang <chance.yang@kneron.us>

