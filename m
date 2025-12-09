Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD63D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 02:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B922683C01;
	Tue,  9 Dec 2025 03:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LH7V/J1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F53A83B81; Tue,  9 Dec 2025 03:48:24 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFB7583C0C
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 03:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i10emzzroMwjtKx8qQVZBCSTt4mUoIrn/G72iJFbdOL9KVvPbY2/O40vBl2iQQRIdJrhhw92eXfi2ThORF4kCUlJss+XZt2D+IQoDaftw6P6xvLyKvLNV9R1giPjJ0Tix2XcAmBtlS6fz+7ODvsY7dBzEasvo2/x0MzPWPsPuZZZ+ULV54bKw3c0qLwnoHItKJhvyyoCYJ1mH2oLVIgSxpLjsrPVBBXoDqLgYoeI8DbLxTVA5DhiamDXL/qKkF/JUpRw3w/m98g0MAxXA9R95hbZwYckDkpIFcAzyX/ga03XSPK7vm5ZvRx4mepLn4/qw+qIvay+y+sCbV0oVsQwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHVtcSKeaGjjNju8jQQ0GFpOqItCSbqIocYnsF0Uxno=;
 b=SOJ2gyHn0xXMk7ABqkX4kIcF0xSgYDAh8JirYKL5HEmxYHoHN4mZizR82d+oS6uJa6YzmHJnFLV3h7qa2hKzUyZ5dxe+OW3tDV2sUpZgUwU160kp5A2N1JoEik2YvMHhTGXMMhta/TUYyt74jqsRqdVjGjubEDk6B9EDbCaBuQwsD87btVSpSyOiDgx2mwD717L5ThIDvW+ShkaSpDEORwZcKQ5S0klaLBBX1YUDhwU7c8NLb8UabFr+4Hc1/3hS62hZNaN/xK3oobfU5kaQHUhhma8snJorfOy5kAxD9WZsWvMDV68nD9P3bwdaxt4xEnkMkQ662CjS7OQ+ewArnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHVtcSKeaGjjNju8jQQ0GFpOqItCSbqIocYnsF0Uxno=;
 b=LH7V/J1p87GmejBGay89AJKq7Rwg142cQwnuS4YEDU7K4Q2G9ccSwkFkkkFQyibOLH+HOL4txIfPJFIQ81YhzKutncnvaSdanasmDQcNw2yX79rdXemyXzAGXGyShhmXCqRhRRdKzk8dTEtCYhLo6hjKuOD5H74rkWsagxy6qmccZ36AyQ8B2EODONq/XMn9NNAwajGNGxhhYJRFEQNbH6+BBa072xp6zHv4e3qfxzTsGTQWvZOXWlFg+nnfvI/fBgcFGK1p8AlhgbMe8Xn0pZy1MYDHh5zAr6ZfPyky8F/sAfK3BY0rNuyPdqmAOqmTJOq64I0He+TYJY7ZRdtVuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11897.eurprd04.prod.outlook.com (2603:10a6:10:61d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Tue, 9 Dec
 2025 02:48:19 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 02:48:19 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 09 Dec 2025 10:47:10 +0800
Subject: [PATCH v2 3/5] usb: ehci-mx6: Add support for i.MX8ULP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-imx8ulp-v1-3-97e76ed1d967@nxp.com>
References: <20251209-imx8ulp-v1-0-97e76ed1d967@nxp.com>
In-Reply-To: <20251209-imx8ulp-v1-0-97e76ed1d967@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>, Marek Vasut <marek.vasut@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Stefano Babic <sbabic@nabladev.com>, Lukasz Majewski <lukma@denx.de>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11897:EE_
X-MS-Office365-Filtering-Correlation-Id: d13cd5c3-8a2f-4eab-9856-08de36cd6935
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1R1RW1Ed1pTSytXTFBBTE1qRU1reFE1Sm1OY09HZTFjMUQxUExmOHJVOVJW?=
 =?utf-8?B?bXFOdzRrcVdtY29QemUrM1k1ZEx0MWt0cjFsU29RZVV1c1lBT00vd0E0alJj?=
 =?utf-8?B?S1JZUDg1SmNzQVhtQlNhRXc2L2dYek8zVnhNVTMrb1cySHc3dThEMVlVS0Ry?=
 =?utf-8?B?ZUplaHcvRWl3Z0VCM1NoUjNJSG0wTkJGc01BZXNCeEtkN0NTN3ZFNERHWXI0?=
 =?utf-8?B?TUpqcXBBTU5FcHpwaUIyYXArdzF3aTZ4V0QzQU92Mms5WEp5YzgyTWQwb1Rt?=
 =?utf-8?B?VGN2dk9HTnpFbDFFaERxZEZPOHFyMnBRK0ZJN3d5aVVDSFluZXNZbWdyVzdD?=
 =?utf-8?B?UXU4VElPRzQvVjlyM3F5R1c2ZnhObnBwTWtEOUhranh2VlY5NHNEOXBhS3k2?=
 =?utf-8?B?RGxmQmVJSnI4M2dObnhSUWRQdkxvWGhoTyt3VUdQNTRCY001SlA4MndmL0Zu?=
 =?utf-8?B?UDNnek9LMkx0bEhEYjhJblF1bVBhL3g4NkhsNWp0V09kYnNsajVtOXdtbkNX?=
 =?utf-8?B?MUloQTJMTVlaM3NXUElVTUs1R3QrNWg3Z2s4d3Znb3NBbVVIVE1ZWGNXK3RH?=
 =?utf-8?B?VlQ2VnQxMUdUNkoxK01vVW45TDA1Nm9jaldwQmNCc3YxdWRGSTVHV2g0Y0Vn?=
 =?utf-8?B?OWZGTWJHS2wybWJJVlNha01TenEzdlpoeVdIMFNLQUNvdU5ocHBwUnhuMTRL?=
 =?utf-8?B?Vzh3VWo1Y2FsV1dLbDRNYmU4K1JWNmZ1cmYydWVEcVpIdDFLU2dTNU9hWVVu?=
 =?utf-8?B?NDlRZnV4M3F3OWZGN0o0N0RmditUSEFONEk2aHZTWGRXbHZxd0JiWlRVRndT?=
 =?utf-8?B?TThZb0VMVmJWL3FRYytjNVlxZ1ZpKzQ1Wk5acXBIUGlFdnI3UnJzbkZTVERs?=
 =?utf-8?B?U3l4ZitZdUNlNGJYd0c5NmlaOHEyUVFzTU55Z3RmUzYxVEVBY3JoaUJrV285?=
 =?utf-8?B?M29XY1JTSEFEaWpwVFpqN3hvUnM2TmRMT3FyOXpGTlI1ek1pKzhMTHUwZURh?=
 =?utf-8?B?TzVLUFhGby9pcjZweVBXSGdMNW84NUR4WnlFM2NZNGkzNXZIaWM1WE9pQlJh?=
 =?utf-8?B?dEZpUWRpUEZYbXRDbUpUQm50WXBlZ0EvVG5OcVZpakQ3b3ltc1RtUWdET2VR?=
 =?utf-8?B?eUNXMUJjbUdTbEdTcWNOWXN1S2VybEJxS2NlV1dXUTBXZTN6ek9xMjJaa2Fu?=
 =?utf-8?B?bVJlVDFpUHNZNnFoTFRDY1FudDRieVhUSVc0T0pGaWN1UWkya1dOanZscnll?=
 =?utf-8?B?K1JQZVRJSDcwQk9scGUxc2FZek5JNVJuaU41Vm8yU2VyaWpQT3lqZlhvZDdy?=
 =?utf-8?B?c1duaDAvekVJV2RPdE9DR01Vdk1FNFVuemt2cHQzNjZYdXVua0QwWm1CTmZS?=
 =?utf-8?B?RUs1WGxndUIycFNnTGt1clArR3U4VWlKWUZGclYzTTV4elR6UlBYUWVDa2hM?=
 =?utf-8?B?ZUZESTArM0dweWxiQTlCd0RMbDMyL2o0UjBpYUgwdUFZMldLQVcwK1JsbEdB?=
 =?utf-8?B?QzlRMFZGRmIwS0R1SnlRNGFoODcwdDBtd2pYWGpOMG0wYWNOOFkzdVpXTnph?=
 =?utf-8?B?WDc2MGR2bVpHbWhySlU5RGhCcWxSN0RURTJiVm9MSmdMOTFxUGNIZUVVR0dK?=
 =?utf-8?B?aVZPR3JRTnBHVEFhZ1VmSlVtNzM0aDQzSWpwdDJQUXJyRjhMdExGQmlsdkg4?=
 =?utf-8?B?dTc3clJkdFJ6dDhKQXhmYjg5OGVXZjgvQ3pjc1dhTjhzTXhJM0FRVGx6N3hN?=
 =?utf-8?B?QVVNZ3VlY1hkTjZzTGZvc1k1VngwSWlGTVRsdWhCc016MXo1ZENldXFNcXJw?=
 =?utf-8?B?dm9IUktDUHduMUcxSEtYTkx6QXIwMVN0RjJyQkhGYWVDSmJnVzhITGpYREtm?=
 =?utf-8?B?UzZVL1JnMGdTUGtvKzVud2NrMXhjR3dtT2RtQjhOaW1Pc1ZEVm9uOGErcDBE?=
 =?utf-8?B?MHRhWjRKL0JkQWVGM1QrRzJWT0YrZk1UUk1WOThXK3ByUklVQzg2ZHZybE9W?=
 =?utf-8?B?eXFNTDJpcjgrYm5xcFVRTk93UzRZckQ2Z0Fuc294aS83ZGxrWU50bDlJM21Q?=
 =?utf-8?Q?qOjCju?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXJoa3daT2V3UWxTT2hPVjFtM2xMaWhuY1NvMDNIMXhpTjFDV1owMEtVamlh?=
 =?utf-8?B?a0RCeklvK1RNVTVUTzdYSFBSQkpuOTZBRGZ6QnB1K3NmRzVwZjEyMVlpVHZF?=
 =?utf-8?B?NytiWC9rZm1QbVNDY2loNnBpcEJwZk0vS09CdUJCVFlmdEJ4Q1RDK0tDZ1o2?=
 =?utf-8?B?NldOK0RpTmRhZmMvamVOYVUxUXZtSWg4Qkc1bWtoQ1NOYi9jV3BpU0FEenpL?=
 =?utf-8?B?ZmhHa0hXbG1HcWxKWWFKLzlwMmlMSmQzUG0xcklJNjVENlAzdnhJU0xMR1F0?=
 =?utf-8?B?ZHhsaW00azJ6ekhFcSsyVU9xWWpDeWxQUHFkeWxudE1pcklGbkJUVTBianhH?=
 =?utf-8?B?U0NUN3k5ZlBSYmxnempEMXhOTzNBcW9nR0c3eVpCTVV4Z3QyOTNlL0VQQjlt?=
 =?utf-8?B?RVAvbWJIN1hadERaOHFodzBkUVJ3Z3p4dTUyelF2ZWF5K1o0VnRwVDcxWmV4?=
 =?utf-8?B?QTV3WXdoaXU2eEUvcjJNUXhtcHlJNE1yeDE5M002VnNVZG5TUGVvRHI5UGFz?=
 =?utf-8?B?WldOaXozREVqa3IzanR1UnEwZXFIblBHaW9nSWJXQm11RllDdXBLKzltdjNw?=
 =?utf-8?B?K2FhaEJ3MFRNSXdLUi8yLzJPc2ZUb1FkSU14VkNkUFltWXJnVUhZVjg0eXRM?=
 =?utf-8?B?WCszMmpWMVpwQjFIWlppejJBVG5PbTFVSjNOUE1Fb2VSTTN2UUhNT3BQYkJj?=
 =?utf-8?B?VG1KUVAyVTZSQm1jU1FWbHpVZmpRRG1Wc2FaK2l3amMwRk9uaitnRTM1QUJy?=
 =?utf-8?B?YzhmZjgyTXlOUHcybGRTT3ZIWjN6NWFaUU9pMHBBTW81Z1hpU2g1VkhNdTdI?=
 =?utf-8?B?VzBzaThqODFaNC9JVlc1QWJsV1E5WEt4MThxTFhacndNbEU0aGFuV0k2eU5z?=
 =?utf-8?B?R3FZWkdRaVV4ZzlNN0Z3NURLM01mSUVQTnlDVmJxcndFNnJ6N3o5blJIOVVJ?=
 =?utf-8?B?bnhIK0tnblJMb2dKVCtWNHNZQS9UUkNjQkk5R0NCUFg5R2luaUxaT2dRbnNT?=
 =?utf-8?B?L0RraWJCMDQzVHFzRXZkeW5UVFlLdXdlVzJCQmNlZzZPZGlsUkpONWoxNGZH?=
 =?utf-8?B?Q0VmU3pNRkV4RzF2OXh5L2NrYXQwVVZJWDhjWkxyU2Jid1FGQmp5NExoZHhH?=
 =?utf-8?B?NnVPRU95LzdsL2FZeStad2ZvS1k0bURBZ0NSS0tJZ2VtTFJQcG5NNE83TGpW?=
 =?utf-8?B?QVlKa1dNa3N3eDFvY0x6QVF0TWtsMm1pbDRRRzJjbTRzNlR2QVI2SlpRcENq?=
 =?utf-8?B?TmIwcHFwTFFDTjJTdGlpSGx0bDlKRnNNYjNQc01ZSTBBMGdPRjJ4VUZQdloy?=
 =?utf-8?B?a0VBdWlMQTlrMEtDQi92NUYrdFF2T2sxWnFTbWxTVlZnUjRoQTVaMTJCZVZx?=
 =?utf-8?B?MUV2cllZVlJoQmUwWUJSYU9MVDZ3WGRjY0kzQlBoT0h0Zm5LdE55RmdWKyt5?=
 =?utf-8?B?dHRFTGdhQUoxTXZiRjFMeUVlYTBZbHByclBSQ2hiS2kyVnZWenREYjFPOXNR?=
 =?utf-8?B?LzdlUy81eDdSMk93YVZHMXFWMllUbXhWMVY3emtvNllDNnNFSWZKcm9UdTQ2?=
 =?utf-8?B?R0RIbHhVZXlRY1VXY2RqRHZ5dVRocGh6ZEZGMTFZVGgvVml4RENhYUVUd1Q4?=
 =?utf-8?B?cTFaWkdGbTVSeVR1RkN5QzQxTVlMVFpwbUR6dUlBampZZ0Z3ZExiZFpSa000?=
 =?utf-8?B?Q0NIbVJpblN5c1NZVVVFWUhHVFZlMVdjZkh5NVFNb083N1dJWE5UNXhidnFI?=
 =?utf-8?B?dENjUklBOWxNa0tQNEVySEdLa1dRbnM5VjFHQzBYRHFWVkJVbWdhdW1FVGhw?=
 =?utf-8?B?RWw0ZThrOGpxRGJmRGdKUzNMQU9hc2pvQWFpa0JtcHVCS1BpamhJRThMMDkx?=
 =?utf-8?B?QlpHZTUrRmUra1IxNDVKblNNaVAzVGk1UGVOOFlJaVk3TjBSL1pGaEJVU1g5?=
 =?utf-8?B?T2cvdDFYUXhvNXhtUDVWSk9HVjArckF5eERjYWR0SWppeUlWUm92WS8yTmxp?=
 =?utf-8?B?WnpmZzNRbGVsUXBEbDJndHg3b2pJbnp3ZTB6cE9zTG1oYUE4WXZpbHlXMVkx?=
 =?utf-8?B?eVVMVHNac2pmQThBQ2I3bmxwWW44Ymg2bkhuSlY0ZlNPMXJNQ2ZCbzVPZ1hp?=
 =?utf-8?Q?5bBDsJE5UHyafm2G7Dybq0ZPr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13cd5c3-8a2f-4eab-9856-08de36cd6935
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 02:48:19.5622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kENbHzkEAppQ7PrbjjY4CuMNgFR7UxOZgi6mYurfkGZM/x5gqNWq1UFrcBnJxLvw/jQYH2otfipoTZcifkz9EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11897
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

The i.MX8ULP shares the same USB OTG and PHY controllers as the
i.MX7ULP. Update the driver to support i.MX8ULP.

i.MX8ULP uses the property phys for the phandle of the USB PHY connected
to the port.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/usb/host/Kconfig    |  2 +-
 drivers/usb/host/ehci-mx6.c | 32 +++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 99f381db9f9..91267bf37b8 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -202,7 +202,7 @@ config USB_EHCI_MX5
 
 config USB_EHCI_MX6
 	bool "Support for i.MX6/i.MX7ULP on-chip EHCI USB controller"
-	depends on ARCH_MX6 || ARCH_MX7ULP || ARCH_IMXRT
+	depends on ARCH_MX6 || ARCH_MX7ULP || ARCH_IMXRT || ARCH_IMX8ULP
 	select EHCI_HCD_INIT_AFTER_RESET
 	default y
 	---help---
diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index fdaf1002190..8f01b29c74e 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -160,25 +160,30 @@ static void __maybe_unused
 usb_power_config_mx7(void *usbnc) { }
 #endif
 
-#if defined(CONFIG_MX7ULP) && !defined(CONFIG_PHY)
+#if (defined(CONFIG_MX7ULP) || defined(CONFIG_IMX8ULP)) && !defined(CONFIG_PHY)
 static void usb_power_config_mx7ulp(struct usbphy_regs __iomem *usbphy)
 {
-	if (!is_mx7ulp())
+	if (!(is_mx7ulp() || is_imx8ulp()))
 		return;
 
 	writel(ANADIG_USB2_CHRG_DETECT_EN_B |
 	       ANADIG_USB2_CHRG_DETECT_CHK_CHRG_B,
 	       &usbphy->usb1_chrg_detect);
 
+#if IS_ENABLED(CONFIG_IMX8ULP)
+	enable_usb_pll((ulong)usbphy);
+#else
 	scg_enable_usb_pll(true);
+#endif
 }
 #else
 static void __maybe_unused
 usb_power_config_mx7ulp(void *usbphy) { }
 #endif
 
-#if defined(CONFIG_MX6) || defined(CONFIG_MX7ULP) || defined(CONFIG_IMXRT)
-static const unsigned phy_bases[] = {
+#if defined(CONFIG_MX6) || defined(CONFIG_MX7ULP) || defined(CONFIG_IMXRT) || \
+    defined(CONFIG_IMX8ULP)
+static const ulong phy_bases[] = {
 	USB_PHY0_BASE_ADDR,
 #if defined(USB_PHY1_BASE_ADDR)
 	USB_PHY1_BASE_ADDR,
@@ -374,6 +379,11 @@ int ehci_hcd_init(int index, enum usb_init_type init,
 		(struct usbphy_regs __iomem *)USB_PHY0_BASE_ADDR;
 	struct usbnc_regs *usbnc = (struct usbnc_regs *)(USB_BASE_ADDR +
 			(0x10000 * index) + USBNC_OFFSET);
+#elif defined(CONFIG_IMX8ULP)
+	u32 controller_spacing = 0x20000;
+	struct usbphy_regs __iomem *usbphy = (struct usbphy_regs __iomem *)(ulong)phy_bases[index];
+	struct usbnc_regs *usbnc = (struct usbnc_regs *)(USB_BASE_ADDR +
+				    (controller_spacing * index) + USBNC_OFFSET);
 #endif
 	struct usb_ehci *ehci = (struct usb_ehci *)(USB_BASE_ADDR +
 		(controller_spacing * index));
@@ -404,7 +414,7 @@ int ehci_hcd_init(int index, enum usb_init_type init,
 	usb_power_config_mx6(anatop, index);
 #elif defined (CONFIG_MX7)
 	usb_power_config_mx7(usbnc);
-#elif defined (CONFIG_MX7ULP)
+#elif defined(CONFIG_MX7ULP) || defined(CONFIG_IMX8ULP)
 	usb_power_config_mx7ulp(usbphy);
 #endif
 
@@ -544,12 +554,15 @@ static int ehci_usb_phy_mode(struct udevice *dev)
 	 * About fsl,usbphy, Refer to
 	 * Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt.
 	 */
-	if (is_mx6() || is_mx7ulp() || is_imxrt()) {
+	if (is_mx6() || is_mx7ulp() || is_imxrt() || is_imx8ulp()) {
 		phy_off = fdtdec_lookup_phandle(blob,
 						offset,
 						"fsl,usbphy");
-		if (phy_off < 0)
-			return -EINVAL;
+		if (phy_off < 0) {
+			phy_off = fdtdec_lookup_phandle(blob, offset, "phys");
+			if (phy_off < 0)
+				return -EINVAL;
+		}
 
 		addr = (void __iomem *)fdtdec_get_addr_size_auto_noparent(blob, phy_off,
 									  "reg", 0, NULL, false);
@@ -727,7 +740,8 @@ static int ehci_usb_probe(struct udevice *dev)
 
 	usb_oc_config(priv->misc_addr, priv->portnr);
 
-#if defined(CONFIG_MX6) || defined(CONFIG_MX7ULP) || defined(CONFIG_IMXRT)
+#if defined(CONFIG_MX6) || defined(CONFIG_MX7ULP) || defined(CONFIG_IMXRT) || \
+    defined(CONFIG_IMX8ULP)
 	usb_internal_phy_clock_gate(priv->phy_addr, 1);
 	usb_phy_enable(ehci, priv->phy_addr);
 #endif

-- 
2.43.0

