Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DD5D44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 12:58:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B2648958D;
	Tue, 19 Nov 2024 13:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C778952B; Tue, 19 Nov 2024 08:47:04 +0100 (CET)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01on20730.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2011::730])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4717688901
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 08:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jacobe.zang@wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pB1z64YRJUDSL8ROeOAlW/r/hxfKBoVH6n23nkHC0zTC3G1V8LAp2hKunA4wq+wsa9aLEHvOXnzpcKs/WWPyJIaH3/v3+nbObnFfNMbl7yxvcnEoR6RCofL+wJJsbNqyZ4p6i40+lPBhul7Hdw6bqWze1BeoCZbMfhkvZZA6R4jC35rydKXAANh/3K2f+Jaj56+w36PRThp85uhMC4R7Aw4cnn13i/HwIadVgTNJz0/A/ptrAi6NQD+MllbIkwY0dEBv/OuxuOAhcw03+AjIQk3nkWc8cUeliIpR/YFtOa27XyUzMY4VltNG3W3ANsGz5cJx2e2MgnXHvSyiisp4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/huPI7QEzh38olxz5Tjta7xwmcM/cfTCvm1nf/p4T4=;
 b=oXd7Q4nadQZ9vIT9MBE+oZFGrUOAu0yPKckIXqvj/hKBFqllXaUTvNT9lQ2a04p841bdYsoP2um1//1Q7VOKAH7M11ngUfpGci3akd/xTo21zaARXRXTmWM1KlQPgOi5bXKcE7h92KlkvJIqNM7nwsjch5jHJCa/kOj8Cbp60r/BkWCvZCiTzZ5uUYT6JT56hMOqp3AIiJ8Y57S+EmNjhMlC5hvMkeJzdRNTp7E142G11MMHNDrFjR0VhT5H/BrZfLjDqE9mYrghwCRWjlmRomR9oz6vljcsUxLY8u7hrjZLtVpN+UeExam0b2/AMbOPHx+wC2CqyWJgFBcx8ypo3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB8812.apcprd03.prod.outlook.com (2603:1096:990:a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 07:46:56 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 07:46:56 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Tue, 19 Nov 2024 15:46:47 +0800
Subject: [PATCH] board: rockchip: add Khadas Edge2 RK3588 board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-edge2-v1-1-b10c5d7626ca@wesion.com>
X-B4-Tracking: v=1; b=H4sIAGZCPGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQ0NL3dSU9FQjXUOLxGQDy0QTS4PEJCWg2oKi1LTMCrA50bG1tQBNUFI
 VVwAAAA==
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, jacobe.zang@wesion.com
Cc: u-boot@lists.denx.de, nick@khadas.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732002414; l=11027;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=AY0sV/qpSGTK4mQKPtBbKBliQ2EeyidPqYTh1+JO0dY=;
 b=S3Egp9EezyvUIewRIYA37A5udq71D1Q48jzV96ySVYztVmTBdsfQHMMQJ4OVXUgLZuM7MG2rM
 +FSSNMsHuSADAyrKsfzVF5xn1qQK+67U+8CAB4AVQshZhaUAKFtFLp7
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|JH0PR03MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: d0cdebcc-f3b2-40bd-d364-08dd086e5748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2dSM2RqTFB2ZlRhNEV3SW10VGJvSlBCWUtLK04xL292VHAyS0dyU3ZHV29G?=
 =?utf-8?B?Y2FnQ3FyY3Fib1dSL0pQb2VQRFNQaG5TelE5Zm9KdXJXNnhNMWRQMVI5RmFD?=
 =?utf-8?B?Um9HVXpNVGVPNVBUOUlyMzd6T1prQXFheE01QWhub1N2NjVQUDZPZDFONlRU?=
 =?utf-8?B?elRTUkFmVkNsMWFGTnNDeGhGRVdWQnJLcllQeGJjSTZHME1nVzE0N0ZhVDFO?=
 =?utf-8?B?RWZVR2prK1BzTnpiK0RKUlBkQ0pjWHFaMEJpL1VhRHNrclczL2FkMzEwVDBi?=
 =?utf-8?B?clZPOTk3QVhsNGlhQldUTGxUeVR2RkdsU0gzdm5hNVhHcHhqUldUNGxVYzRL?=
 =?utf-8?B?Sk9oSTF5U1hGaWVoMmNBRDR0UEhnQUI2NDBCNG45aVcvRDl6SG5mQmsvNnRa?=
 =?utf-8?B?TTFoU0JHQk5sY254Q0RiUzJjUVROVVFoTmF2Mko3U2FlMC9vWVhmZnZjcFpr?=
 =?utf-8?B?dDAvS25kdFZzc3JreUtwdUxjcUlaLzJDZUMzN1ZjakdUSnFNdFJWQTNZUlp1?=
 =?utf-8?B?NWFqVkJ5endWY1dSNnFSeXAwbGhYV2UzVXY1Kzd6Wjh6VWZRRzBsV3hQRldj?=
 =?utf-8?B?SHk0RjVNQnlTczNkZkR2YkNRVStxY3NTMU42c3hiaTdOakt1aXJOVUlxYzI0?=
 =?utf-8?B?L2UrWWRnbVNxb0dXdERDVUhPYkJtY1BRSjdwRy9JcUVVYnJQcS9ic2REaHBQ?=
 =?utf-8?B?MUpnQW45d1RhYUx6UmdFSVBUQ0hlZ1l6bys5UzN4TGQ0dVF0S01KVkVUOEpn?=
 =?utf-8?B?UURXWDU0dzVLQVM5WkNRU1Rhd3ZWMmJGL3pWNS9ZZUgwbGJyNXUzSkt6S2c4?=
 =?utf-8?B?MTQrU3YydGdsWk9vZjZqL0djU0lkV0YvbllUZ0w0RG5yZnlIZzROL3dORSt0?=
 =?utf-8?B?VDFIWjE2Zjd2VVNUWi95TDI4YnV1L2FuUVdCbGRRVENQQkd6T28xM1ppYlNa?=
 =?utf-8?B?cUpDbW00ckNNR3dOVjVMK2RJdWJtbHpvdmxZWGdrQW1FZnBSSW5DWGh6T2tk?=
 =?utf-8?B?dFNoSUFSTXZkQmlKcFNXZk9nMVFxSjg0SGFOSmkvSFg4ZWtyZk9MQ3VJUmRG?=
 =?utf-8?B?SU5MMDMyakI2UkdBTzN1MkhaNEQ3aHBVQ3VETGQrTG5wRFlRMmZIQUtDTEtL?=
 =?utf-8?B?Q2pQWmdYc1gwV0kxR2JNOTJidXM3UGQvdjVZK29mMlNWRHI3NnB2R09jZ29i?=
 =?utf-8?B?TERXMnZUZW52WG5QUzN0OXJZb1N6YjlCUjlGdUFvNFJLbkJmMmxZUENBTEdt?=
 =?utf-8?B?MklpcEZBMnVNeStUK04zTXNEREkyN3VveVYxK1dHSXVnaFlBeDRyTTdRbW1G?=
 =?utf-8?B?VDVRRUh0SnhFZTYrWlNmaE9MYnpZVXRjWU15KytvSkM2VTVEQkUvOXdDWXNF?=
 =?utf-8?B?ZDhYdTRucHViMHpaeUpuQWdRWmllcWFhL3ExYmMrYXorZGZXRXVrVjhsVkpj?=
 =?utf-8?B?dUhCaXk5T1RzTXNOdlNVNE45bVlrZGV0L3Rmb3p6MjBJUUVEZCtaWjF4d2t4?=
 =?utf-8?B?bmFYNHg3S20zc0R4TDkzNmcrYjUvS2NLNk5ubHFHUDZIbDhCRUFUbFE4WkZk?=
 =?utf-8?B?bEVlODlnVDZBUlRySTVERERUNmQwMXpBSFVOa09XM3cydEx0NlNjZ3M4bVBJ?=
 =?utf-8?B?VlFHbFIrc0V5T3ROdWMwUWVpb09QQk5ac1U4ck8rRlJuUHFvenZGeEFNQmV1?=
 =?utf-8?B?RVhyWmhpVkV6aFNLbG1ZYXgwQk9keWl2ZmpLdDl3MU9jeXFhaWRzUkFJQW95?=
 =?utf-8?B?aVYwK09FeXZpby8yeTBIeHppWExmVXdINTRlSE1rbWJpdU1lVVRxeDVqd0lI?=
 =?utf-8?Q?Va4yBX1bJgclLAmVLrjpJdJsbXRASWG3T161c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB7001.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUoyVGhtaDZYRnFWRldMUGdmaEw5OEpaNWp5SW9RSytFRG80blFnT2h2amc2?=
 =?utf-8?B?ZGdwaVBOM2FtS3BWZ2w1RmhhVHFCbEZQTU1LeUZ4eVo4Q1FFdlhiRWEzRkM2?=
 =?utf-8?B?cVhUdVd1RnRqT1RrUWhSUU1nanZhajF2VEtVVEVsWVZoeHFMaC9XaGpqaFJj?=
 =?utf-8?B?ZVIyZHRGSEU4dTB4b09NRHNhcytSOU91L0l5eE1iZVBZQ1RZNU91VUtGN2lI?=
 =?utf-8?B?VXk2NUVHU243MDhXRCs1RS90WVliUkFUdThaZFJOd3hZT0I3SXVTR1BiRVlj?=
 =?utf-8?B?ZEp1UHlzSHQ2S1NiL3pVNE5jM0ZWRDIzRGRMdkxSU0dXK1VJa1k4MElrSlMz?=
 =?utf-8?B?Nm5Md0hMY0tDNEFDRGpveEpFaVNKdzBoSnliQkZsMEF2eUN6a3VTSjMzZEJu?=
 =?utf-8?B?TVM0YjVHNHRCcmo4akMwYm1QWnJpcFBoS2l5V3JrZlMvdXVqWFN3andBKzdk?=
 =?utf-8?B?eTUxRWRWSVdtRFhTdlZiWEdnYWxpMkxiSXFFS1NXSUlGM29RWFhXRTVTcDVT?=
 =?utf-8?B?KzJrQlhaTlFwNG1TdDliejlBWFpqd2NqL1J2SmswZW9nTnRTWjgrdkxEYzNo?=
 =?utf-8?B?SUdCeWkzQ0hvY0ViaDljZ0tmZ2FHQ2FwN0dObjhKZUNyU21WM1JxZXJaeXEz?=
 =?utf-8?B?TCtXWjZYZ0paNHBJcTF3eURveVRDZjdKQXZhMFNFT05QMWRRUFIvTEVXdEJx?=
 =?utf-8?B?a0VkWGltazkrY051eFFsVVREZ3NOZUM1amVveGFoZ2lhSzY2Z0plM3JhbmI5?=
 =?utf-8?B?TjhrSHBpdzlMbWZ4UmtRdkpubzlVT3gyc2tRUVh1QytLTE1pSHJsNTFmbkxY?=
 =?utf-8?B?NFF6V3N0T0h0VjltZlI3anFjVnVWTlBzRDJ5RjhUVGhqMEhUSHRlbHlUci9m?=
 =?utf-8?B?QnB4RUhNVmR1clI4UHhQd3RlemtZY2c0QlJXeEI5UXVTZlcrakRtZEZLQTBp?=
 =?utf-8?B?VVptdFRKNFk4SFptZzFEYnJxTHkrbURtN1czd3laZUN1dS9NT2JLb0NhNE5W?=
 =?utf-8?B?Rk1RSGI3THBRa2JSVUxSdUxjWkJWMHZOS3R0WlNOMmc5UHZXQlRrYmtLU25H?=
 =?utf-8?B?RGs0OU1FQ05paFVPQjhXcGdyL3J3TnRweWVtU0FXRGt6TVZqeFRoRlhCRTlB?=
 =?utf-8?B?anU2TU0xb1RteHRvbjVDWWd4SWZiR2ZadHk1WnUvMHlNV1lQR2lqVStSOTFY?=
 =?utf-8?B?dVdlZ1Q3TDl5NENMN012Q3UvOXdQUUtmTno4Z2xQS004UGZqa2kveWUwRjRS?=
 =?utf-8?B?QWR3TG5ub3YwekFQZXV1bG9pVUxyMm9TVXFNUjN5SlMwYko4N3VsbGhwaVpt?=
 =?utf-8?B?V1ZKb1I5YS9ScDJJS1orMk1LQ0c5eDExYVRHNFpLMUZ0czlCQ2hrMEwySEl2?=
 =?utf-8?B?am00clhNZmprRFFkK1M0cnFXZVVCTWJTbEJCL1pQS2JUSGV4OXRMa3VLME1x?=
 =?utf-8?B?UnZUaDd0N216QzdGT05qMDNwN05SVmtqVmlhVjJYNWllT1A1dUU3bG5ZNWN3?=
 =?utf-8?B?QUk3c2dvbHN5UTZGTURUSnlScmJKUmYrSmhabzhWdnpqZU9VQkRlWHduMmZW?=
 =?utf-8?B?alZ1UmllWVNaOHNVSlc3dWxINHhQWk04TzlFVDFQeXE1SFNTRDNaRXU0VzNI?=
 =?utf-8?B?ZHYzWHVSaDJsMEpkVExaeE1ITlYyTjY5ejNpVDB3WU9Wa3B0UlBHeThoVitD?=
 =?utf-8?B?b0djS1p3cSs5ZVllMFdYNHV3SnAwRFhrMHp4UUtTcDdwRkdYUzRweWF1Vzdw?=
 =?utf-8?B?SkpRNm5WMlNDQ3FaQmMzaGQva1FwcnFVU3d3VXFxV0Ftd3lPa2dyMGVwNkhX?=
 =?utf-8?B?K1E0WWhsZmFUQ1NXUXRta29GcGZOTC8zM2hKYVF3a2tNM0doL2xmUlZwYTZS?=
 =?utf-8?B?SG5FZUNBS2JDY0NSYzZlaGEwM2hINHRsVVc2TUFBMTJKM0hKNHhqeVpCeDJz?=
 =?utf-8?B?N3M3WC9NaVpHOHhmRnpNN1JaemtML2NsbEFyd2FNcDd2VURlWFFLR1cwemho?=
 =?utf-8?B?NEhHZlhTQzU0K1V3VUxxOU41MDArcVVMU2dPUk02U0p2K0xLSHNXRXJzcGxl?=
 =?utf-8?B?ZFhhcWtPOVRZdU1GRW82UlhaWlVaSGU1aWdFTUQ5VlZjNnNVb3Z3WlU3RE9L?=
 =?utf-8?B?S2FSaVhoRG5DblpVcDg5MDJHMTZhRmIyRk9xWCtrS0FmUVdja2Zjc0tMclRY?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cdebcc-f3b2-40bd-d364-08dd086e5748
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 07:46:56.1207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkpUK2O/1NMwJ6oldMKetPVRxtTFqlk9EyTZgHQW268eu3mz5nfdWXXhmGpgnyd7eqjoj5nXOXtykuXGUmiiZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8812
X-Mailman-Approved-At: Tue, 19 Nov 2024 13:57:58 +0100
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

Khadas Edge2 is a Rockchip RK3588S based SBC (Single Board Computer)
by Khadas.

There are tree variants depending on the DRAM size : 8G and 16G.

Specification:

    Rockchip RK3588S SoC
    4x ARM Cortex-A76, 4x ARM Cortex-A55
    8/16GB memory LPDDR4x
    Mali G610MP4 GPU
    3x MIPI CSI 4x lanes
    2x MIPI-DSI DPHY 4x lanes
    32/64GB eMMC
    1x USB 2.0, 1x USB 3.0, 2x USB-Type-C
    1x HDMI 2.1 output, 1x DP 1.4 output
    USB PD over USB Type-C

Kernel commit:
04d552993522 ("arm64: dts: rockchip: Add Khadas edge2 board")

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
Add support for Khadas Edge2
---
 arch/arm/mach-rockchip/rk3588/Kconfig         |  23 +++
 board/khadas/khadas-edge2-rk3588s/Kconfig     |  12 ++
 board/khadas/khadas-edge2-rk3588s/MAINTAINERS |   6 +
 configs/khadas-edge2-rk3588s_defconfig        | 215 ++++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |   1 +
 include/configs/khadas-edge2-rk3588s.h        |  15 ++
 6 files changed, 272 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index b5a0e624a53..7d817e7f1bd 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -74,6 +74,28 @@ config TARGET_JAGUAR_RK3588
 	      - fan controller (AMC6821 emulation)
 	    * 80-pin Mezzanine connector
 
+config TARGET_KHADAS_EDGE2_RK3588
+	bool "Khadas Edge2 RK3588 board"
+	select BOARD_LATE_INIT
+	help
+	  Khadas Edge2 is a Rockchip RK3588S based SBC (Single Board Computer)
+	  by Khadas.
+
+	  There are tree variants depending on the DRAM size : 8G and 16G.
+
+	  Specification:
+
+	  Rockchip RK3588S SoC
+	  4x ARM Cortex-A76, 4x ARM Cortex-A55
+	  8/16GB memory LPDDR4x
+	  Mali G610MP4 GPU
+	  3x MIPI CSI 4x lanes
+	  2x MIPI-DSI DPHY 4x lanes
+	  32/64GB eMMC
+	  1x USB 2.0, 1x USB 3.0, 2x USB-Type-C
+	  1x HDMI 2.1 output, 1x DP 1.4 output
+	  USB PD over USB Type-C
+
 config TARGET_NANOPCT6_RK3588
 	bool "FriendlyElec NanoPC-T6 RK3588 board"
 	select BOARD_LATE_INIT
@@ -393,6 +415,7 @@ source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
 source "board/friendlyelec/nanopi-r6s-rk3588s/Kconfig"
 source "board/hardkernel/odroid_m2/Kconfig"
 source "board/indiedroid/nova/Kconfig"
+source "board/khadas/khadas-edge2-rk3588s/Kconfig"
 source "board/pine64/quartzpro64-rk3588/Kconfig"
 source "board/turing/turing-rk1-rk3588/Kconfig"
 source "board/radxa/rock5a-rk3588s/Kconfig"
diff --git a/board/khadas/khadas-edge2-rk3588s/Kconfig b/board/khadas/khadas-edge2-rk3588s/Kconfig
new file mode 100644
index 00000000000..dd7b6cd8054
--- /dev/null
+++ b/board/khadas/khadas-edge2-rk3588s/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_KHADAS_EDGE2_RK3588
+
+config SYS_BOARD
+	default "khadas-edge2-rk3588s"
+
+config SYS_VENDOR
+	default "khadas"
+
+config SYS_CONFIG_NAME
+	default "khadas-edge2-rk3588s"
+
+endif
diff --git a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
new file mode 100644
index 00000000000..3f16923b0f2
--- /dev/null
+++ b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
@@ -0,0 +1,6 @@
+KHADAS-EDGE2-RK3588S
+M:	Jacobe Zang <jacobe.zang@wesion.com>
+S:	Maintained
+F:	configs/khadas-edge2-rk3588s_defconfig
+F:	include/configs/khadas-edge2-rk3588s.h
+F:	dts/upstream/src/arm64/rockchip/rk3588s-khadas-edge2.dts
\ No newline at end of file
diff --git a/configs/khadas-edge2-rk3588s_defconfig b/configs/khadas-edge2-rk3588s_defconfig
new file mode 100644
index 00000000000..208c72ca425
--- /dev/null
+++ b/configs/khadas-edge2-rk3588s_defconfig
@@ -0,0 +1,215 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-khadas-edge2"
+CONFIG_SPL_GPIO_SUPPORT=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SYS_MALLOC_F_LEN=0x80000
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_ROCKCHIP_FIT_IMAGE=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_KHADAS_EDGE2_RK3588=y
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-khadas-edge2.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SEPARATE_BSS=y
+CONFIG_SPL_MMC_WRITE=y
+CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_AB=y
+CONFIG_SYS_PROMPT="kedge2# "
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot\n"
+CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_DTIMG=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_SPI=y
+CONFIG_SPL_SPI_SUPPORT=y
+CONFIG_DM=y
+CONFIG_DM_SPI=y
+CONFIG_DM_MMC=y
+# CONFIG_DM_SPI_FLASH=y
+CONFIG_MMC=y
+# CONFIG_MMC_SPI=y
+CONFIG_CMD_SF=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_TFTP_BOOTM=y
+CONFIG_CMD_TFTP_FLASH=y
+CONFIG_CMD_MTD_BLK=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_DTB_MINIMUM=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_OF_U_BOOT_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SARADC_ROCKCHIP_V2=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x1
+CONFIG_FASTBOOT_BUF_ADDR=0xc00800
+CONFIG_FASTBOOT_BUF_SIZE=0x07000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_ROCKCHIP_GPIO_V2=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_I2C_MUX=y
+CONFIG_DM_KEY=y
+CONFIG_RK8XX_PWRKEY=y
+CONFIG_ADC_KEY=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_SPL_MISC=y
+CONFIG_MISC_DECOMPRESS=y
+CONFIG_SPL_MISC_DECOMPRESS=y
+CONFIG_ROCKCHIP_OTP=y
+CONFIG_ROCKCHIP_HW_DECOMPRESS=y
+CONFIG_SPL_ROCKCHIP_HW_DECOMPRESS=y
+CONFIG_SPL_ROCKCHIP_SECURE_OTP=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_MTD=y
+CONFIG_MTD_BLK=y
+CONFIG_MTD_DEVICE=y
+# CONFIG_NAND=y
+# CONFIG_MTD_SPI_NAND=y
+CONFIG_SPI_FLASH=y
+CONFIG_SF_DEFAULT_SPEED=80000000
+CONFIG_SPI_FLASH_EON=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SST=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XMC=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_DM_ETH=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_FUEL_GAUGE=y
+CONFIG_POWER_FG_CW201X=y
+CONFIG_POWER_FG_CW221X=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_SPI_RK8XX=y
+CONFIG_DM_POWER_DELIVERY=y
+CONFIG_TYPEC_TCPM=y
+CONFIG_TYPEC_TCPCI=y
+CONFIG_TYPEC_HUSB311=y
+CONFIG_TYPEC_FUSB302=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REGULATOR_RK860X=y
+CONFIG_REGULATOR_RK806=y
+CONFIG_CHARGER_BQ25700=y
+CONFIG_CHARGER_BQ25890=y
+CONFIG_CHARGER_SC8551=y
+CONFIG_CHARGER_SGM41542=y
+CONFIG_DM_CHARGE_DISPLAY=y
+CONFIG_CHARGE_ANIMATION=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_RAM=y
+CONFIG_SPL_RAM=y
+CONFIG_TPL_RAM=y
+CONFIG_DM_RAMDISK=y
+CONFIG_RAMDISK_RO=y
+CONFIG_DM_RESET=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_RESET_ROCKCHIP=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
+CONFIG_ROCKCHIP_SFC=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Rockchip"
+CONFIG_USB_GADGET_VENDOR_NUM=0x2207
+CONFIG_USB_GADGET_PRODUCT_NUM=0x350a
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_DM_VIDEO=y
+CONFIG_DISPLAY=y
+CONFIG_DRM_ROCKCHIP=y
+CONFIG_DRM_MAXIM_MAX96745=y
+CONFIG_DRM_MAXIM_MAX96755F=y
+CONFIG_DRM_PANEL_ROHM_BU18RL82=y
+CONFIG_DRM_PANEL_MAXIM_MAX96752F=y
+CONFIG_DRM_ROHM_BU18XL82=y
+CONFIG_DRM_ROCKCHIP_DW_HDMI_QP=y
+CONFIG_DRM_ROCKCHIP_DW_MIPI_DSI2=y
+CONFIG_DRM_ROCKCHIP_DW_DP=y
+CONFIG_DRM_ROCKCHIP_ANALOGIX_DP=y
+CONFIG_DRM_ROCKCHIP_SAMSUNG_MIPI_DCPHY=y
+CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX_HDMI=y
+CONFIG_USE_TINY_PRINTF=y
+CONFIG_LIB_RAND=y
+CONFIG_SPL_TINY_MEMSET=y
+CONFIG_RSA=y
+CONFIG_SPL_RSA=y
+CONFIG_RSA_N_SIZE=0x200
+CONFIG_RSA_E_SIZE=0x10
+CONFIG_RSA_C_SIZE=0x20
+CONFIG_XBC=y
+CONFIG_LZ4=y
+CONFIG_LZMA=y
+CONFIG_ERRNO_STR=y
+CONFIG_AVB_LIBAVB=y
+CONFIG_AVB_LIBAVB_AB=y
+CONFIG_AVB_LIBAVB_ATX=y
+CONFIG_AVB_LIBAVB_USER=y
+CONFIG_RK_AVB_LIBAVB_USER=y
+CONFIG_OPTEE_CLIENT=y
+CONFIG_OPTEE_V2=y
+CONFIG_OPTEE_ALWAYS_USE_SECURITY_PARTITION=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 9bab86d2347..ea98b73d33c 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -137,6 +137,7 @@ List of mainline supported Rockchip boards:
      - Generic RK3588S/RK3588 (generic-rk3588)
      - Hardkernel ODROID-M2 (odroid-m2-rk3588s)
      - Indiedroid Nova (nova-rk3588s)
+     - Khadas Edge2 (khadas-edge2-rk3588s)
      - Pine64 QuartzPro64 (quartzpro64-rk3588)
      - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
      - Radxa ROCK 5A (rock5a-rk3588s)
diff --git a/include/configs/khadas-edge2-rk3588s.h b/include/configs/khadas-edge2-rk3588s.h
new file mode 100644
index 00000000000..d279cf3826a
--- /dev/null
+++ b/include/configs/khadas-edge2-rk3588s.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 Khadas Technology Co., Ltd.
+ */
+
+#ifndef __KHADAS_EDGE2_RK3588_H
+#define __KHADAS_EDGE2_RK3588_H
+
+#include <configs/rk3588_common.h>
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#endif /* __KHADAS_EDGE2_RK3588_H */

---
base-commit: cca05617a8f585f3a98a8fa82f75cc68a530d771
change-id: 20241119-edge2-18ac09a490ab

Best regards,
-- 
Jacobe Zang <jacobe.zang@wesion.com>

