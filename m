Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2133CCD4F54
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3840384879;
	Mon, 25 May 2026 04:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QW+uH0NE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63ADB84878; Mon, 25 May 2026 04:35:08 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84A05846EB
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYQX/O3/l6BvnA77dNZ4bIOjVYiv3dQ6+o7qFqiGpnTlSQOPRog7h4SyEKrbKbfGWqtx8GPllgnSMsGMnUU2bZQ2/LNDhpy1uC476i5SifkBE+Nzcp1eoK/ehiLN19C4dgAOZfK4QZ68mdlzFwCO5ymZHsIrMMhCAZpimWy5Ub46j90+g5/AObJtDzY/eklbwbLLK9WLgBdgPq4ageugpGkzxWL2a8S/Ho8vIuNkqu92tiDpVeiFF/5QPo+J9F/f4G7XJG29WwMc+LI3SxA1uX8vjOgSk1OD6xzsomDqvNR/9RsmbhjiBBt1FgVAgAnnkMj5ZcWGsSEzYYmhkNCuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZhZlzH7z1dkwtv7mQtrX+eW5PXgJ4e/kFhfmxxEwAc=;
 b=G0EFZjUf/FijBanO/4Hnru0fx/BiS7dX254jwoW6ZUegQS+xq5G3sGeXTld63JfinWvaSv+j5eZAg/AHyGfViO757CgMemtXfwvvrLNhucOp7RBvU3X1f08FEv25blExdg+MXq2CT6JEv0ms/svB+7yphstzfMTlPfeY65TLu36h+UhhOshHXsJP9Y8EIUcDN4IDzEvEFu6nEb/K7qTJdbCv2FVuBCA4fp17l9nl+NYyg24lXl8Pxbd/UO23YXstjKOiQ6fbAUA4pDBle695NfB30BJwe7YBA31kw+xLP3sLQBFyz1dFs3PGICURHbmKrI6rOE3jPOdeuLM3gr4Vdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZhZlzH7z1dkwtv7mQtrX+eW5PXgJ4e/kFhfmxxEwAc=;
 b=QW+uH0NEzzmwyVbBK+XyKyLS6iNJoJ0Xsu2CNnuqrAEF5WMyMN+FmTdPVK29hnXsA7hyIpdxDczgvrkAetL7sKnDzSlGmRGYeVeRfriEiKaN8l57n31tU3d9SH9emx6DfSbTQ1DO2COeiTRs1U4dqXk9YnVd/hZPY5zhX9xjFtI2/WJGP1iyGnYv39EhG5MwZsjnfMwCc6yOJejAPFxNHaMe6s0mXTOp9ED45zqRQNhVUYIgJaADWrncgGAJKG+/lWwQuoNPXYCVTlmxaswTrDohc/d0adm0nIu+J+GR79AJ92GulzOAcDKOZ9mG0xLtgfkggvY36xoPlVvCKbgKDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10118.eurprd04.prod.outlook.com (2603:10a6:102:45b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 02:35:05 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 02:35:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 25 May 2026 11:51:47 +0800
Subject: [PATCH 1/3] watchdog: orion_wdt: use dev_read_addr_size_index()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-devfdt-wdog-v1-1-d8142b674ba0@nxp.com>
References: <20260525-devfdt-wdog-v1-0-d8142b674ba0@nxp.com>
In-Reply-To: <20260525-devfdt-wdog-v1-0-d8142b674ba0@nxp.com>
To: u-boot@lists.denx.de, Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10118:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ed67fe-bb43-4ac2-6290-08deba063a90
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|22082099003|56012099003|18002099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: sU5N1Uz/I7qvwxAZjc/bnhlrwGICchg7EC23VIO/3mCeIcJ5zWy9kboFU+vmObVO3XLcmHS9mebhbOFquACIu9rwdGWUs2ss6r7FlcUVJlsEeWUmbwoQ9XZVI6czdr/M310LR07VGia04g426wC6xgVKQoKQTHtWsybRuh/x7f3Bwdl1S9QC/tos+oNErEVxXIKtZUyKu6Iqi1EM+jGsM27MswloEVDSSzHEb426dkOm7F/Bz6XvP3Y0BqkzXPPg+rSWYxzFuE5jXHIJ/YBaNtENsd3sy+XQT5z1Ysusz/X9Dthd/MOqQ0ZuBWXh8DrulYxT0YJ9vreA43G+f7STJk23uyz3sZ5+H89FpeRW51HXKHztrnU01GkxQgrA8uBNwb6LhgNkWZmUv4eRZMa5ZntZ2RQ/qiKyrVOAni8XbCjHE9ndcXySvInOp2UGypWO/NkX6g59Z3vomkYm+ufU7D4ylfp8n5CL9jnweyv44bfRcwogEQf7ks3fqjtHzsTDoPYp5h0JzLfrKr10JQYZicBUJkxtPPqCBLmOwDUD3/K6at/x8GY/VIMtGJ9LaH/1uEKD4RPLgRgimbQhQozVZsdLUV/HUFo4FBsVvSzSrLf099bIkSIKh3xsU6E5jhqKbKdcfXJe0srRcGu09XKzyjTU53fhFAzHqggvHmL5pjsnKxbsTo/I6ALk3hmqtBTm2DJHzkpQYa27VBtKk8Hd+rz2KRWX0LyBlz2a6qjFRIxgxybcIDQbpbTaC9ipXaBJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(22082099003)(56012099003)(18002099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emZkTjcrOXljMGJuRWx0VHFXWXZTT1VrRkZnM1c5ak0zNWZ4NmlRM1QxeXBH?=
 =?utf-8?B?aS9IN2VTelJoNTVhdm03WEEzb0tXWUZHU1NKM0thUzI4OVdLZnFXaTAyWkdF?=
 =?utf-8?B?Ry80bnloRjZGUjJWY0Q5L0E3ek9vQ1AvMVRMNWdSWXlha1huQlIxSzRxcTYz?=
 =?utf-8?B?eDR6Tjlla3ByYUFCMmZNQjFMUmFMenBnVHFNRisyL1c1dzlDaGIycmJMSlE5?=
 =?utf-8?B?MXJNajJGV05jbDEvUmptK1pmL01yS29nNEc0dGVsUk55TUNHZkhGUkhmL25J?=
 =?utf-8?B?blFpcjJvQ0t5RDk0R1NoTVhHRm1USmloYzZsQjd2UEhRVkFrUGhCdS9DLy84?=
 =?utf-8?B?czVZbW40VFBIelR5b3grcUlxekVyVG1SRW5wNWdlRHNUOEFlMVZkdGJzQ0po?=
 =?utf-8?B?Wm12dmhvRnF6TXhpWFAyU2ZCeU13K1BIY0FxMUhFMm5SakFwenBkQ2dGbnIv?=
 =?utf-8?B?UVh4SDdXdHpka04zY25PcGJFN0VmOTFlOWZGSFBzZHU1VEI1Yi9nK3Ztakk5?=
 =?utf-8?B?VHFjM0R1SWM2S3FpUnVTbllDd2p3ZGFUck5lcEFOZW5pZ1NXcVBDbDlUVUNP?=
 =?utf-8?B?cTREUVMrWlNVbTlZOVNGMEZjZ1g0QkVtVTJ5UHcyUy8xZ2VzYU1HNTVRQm5U?=
 =?utf-8?B?QlUrek5VcTk4U2JTMzRVNk9qOUxRbVVvRUdnWXlGYVA4VU51YmtWMmFGd1Fy?=
 =?utf-8?B?WXZQZXBsdmNmUGhnQzVTSXQwenlUelhzc0NKVC9Ea0JneVVmSU9lTFhlSDEz?=
 =?utf-8?B?VUR5Znl6dE5lVUtBdVhKVjBvelJoMUVRN2RRRnhTbFpwZ1Q0YTRNM1NRTExL?=
 =?utf-8?B?cWI4LzVaOTdMU2FDaytQTXpCNkd6aytMS21SYm9pM3Y2TTY2RVRtUlpIeHVR?=
 =?utf-8?B?TXFTTWF5b3NsTXBIMGc3MmNFQ2Y1OXlFN0RFU01Jdkc0WngwYnZ1ZlExMGNR?=
 =?utf-8?B?S0FOZ085NjVxUy9GWjNsVVZBWDZHWG9PQzltUEY1QWw0WTN2UTYvRDJRK1Ur?=
 =?utf-8?B?ekVzaHFGbEtOZW9uSDJKZnd4VlBRUm8xMVJ0dmFaTm15bjc0NURpTGNVVXdh?=
 =?utf-8?B?TTZoU3JldXcwL1hJOU1oNVJONXZjSWd4RjRyVy9sZHc1M2xmMkxuMFgwVnox?=
 =?utf-8?B?dmw4ajhaSG50U0gxS1JybkdhL2RRV0E3L3U4aUhTTVZMdUY5VVhCYzVnSVQ0?=
 =?utf-8?B?ZmNFZnU5L3FCQmpNUVBZa1NuNEVoL2liNFNYZnE0Z09DU1hRQVBNckplZHA1?=
 =?utf-8?B?MDEzeXFacjFBblVsVlhlUzV0UWVYY0gvNXcwVmhBRTRMU1RWOW45MUxkd05C?=
 =?utf-8?B?MGwvNEY2YnNrUVoxZjBSRktSNGo3OFU1Y2ZFYTNXS1lSVzlBcU5mMnM3aDlz?=
 =?utf-8?B?eGJxelQwZ1huM2pERVkveHk0eEpKMzdNZlY4RUs0TThZNEUwcVhZYWt6RFgv?=
 =?utf-8?B?bjA4cWdQclp6U1k2T2F4MHBpaENFUEtnc0tncHVZZWhxS1ZzRmRGaWwvYitK?=
 =?utf-8?B?OGlidmNjanhUN2xRVGNnWkR1VTY5aEwxbXpUU2xsWE1icjduVGNYaGQyZzJD?=
 =?utf-8?B?TU9Pb1A2aHgyM1I4Qk5qby9OUklTZnBjbUtOUXdiYUhDeVd0ZjltRDF2V0d1?=
 =?utf-8?B?RGtMYTRmczA0UUdpS2tHc0QwWGFyVS9oRDR5K0tJZzJmOUpIcUp1blNxaWNR?=
 =?utf-8?B?T0RCK3hvTXhUZkdEZXV3dHZHMmlVYnY3b1NXaFRkME5RVVRmSSszMnVUeHhm?=
 =?utf-8?B?ZjFqZDlqV3BDRnE5cjBtOHZ4L09qOVBCcGV6SjlzVkVTYUhpangvajZUTm96?=
 =?utf-8?B?bVh6bGk0T0tRS2R4TDFhek1YNzZ5K014M0NWS1cwQldXTXhyczVqVUdRdTJV?=
 =?utf-8?B?YVZEZXVZQjZGQ25GNG5oS2JZMGE5dGRjNXRHQkR6MVhFWlAwMmVsOXJQZ3Ar?=
 =?utf-8?B?WHRoZVg4WC90T1U0RXViV3dSRmZMWXhzOGJLcHRDZFVGSW5XKzM4bmlvZEt6?=
 =?utf-8?B?OTBKeHR5L0VWOVRnL2tRZHBhTmtGQ2RLTFRrQmNXU2FrZS9wUDJ1ekR1VlN2?=
 =?utf-8?B?dGkzNnM0RXJBWkcrdWhOb3pQcmdMdTErbEhaSXo3dng1Sjgxb3VYYU1FV2tD?=
 =?utf-8?B?LzcwVlNVZVQweHNBRldJeXpOTWhIeFJpV3hIc2FWREdoclc3VnJHK29sZ1Yv?=
 =?utf-8?B?VFY5TDVwWlhtSjNmN3BVbDc1bnVjRGRPeUttai9YR1l4WWxBRjhUUDYrSDZF?=
 =?utf-8?B?UWo4VWhBcUMzVkRDcm5tMGhUQVNqV01ZQ2VhVE14VXgrVGlKYWVHSUszcytq?=
 =?utf-8?B?KzE5ZFp6Z2dyS29CN3ZGUzNhTEVYYlI2MCtCZVUwbGI3K2pXc3JTZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ed67fe-bb43-4ac2-6290-08deba063a90
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 02:35:04.9623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZVawY5j05bFzYX4a4KVvSUsIT+H1/RY3/uqaD1ZSGYQJvB9UrsxMSspCIx6DBKB9L2jqZdQ0Laba+RgG+hsSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10118
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

Replace devfdt_read_addr_size_index() with dev_read_addr_size_index() when
retrieving the register base address.

dev_read_addr_size_index() supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/watchdog/orion_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index a2000b968c9..c9bd40c8d8f 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -119,7 +119,7 @@ static inline bool save_reg_from_ofdata(struct udevice *dev, int index,
 	fdt_addr_t addr;
 	fdt_size_t off;
 
-	addr = devfdt_get_addr_size_index(dev, index, &off);
+	addr = dev_read_addr_size_index(dev, index, &off);
 	if (addr == FDT_ADDR_T_NONE)
 		return false;
 

-- 
2.51.0

