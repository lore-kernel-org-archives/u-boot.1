Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A99FC3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 12:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3593882A25;
	Tue, 13 May 2025 14:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="d50Ds3/2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F4A982952; Tue, 13 May 2025 12:20:07 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546B680AE0
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 12:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSs4XyzmcCUPbcpu/8HgRhriJpOOdrks+OT6AVg5L0OMnmf0Kf3DL3AM2IpDc2tHN6+IFdtyV9cQe3m5e0u7ZJ8YVzrOrL1nLSdXjvxltJLQhMJDhdYG92RUTg0il2RRc3xSp1IrIP9Vv+2th84yhV6bVCW1R5XTN4gVC9sfjvq7YP821ZRFY9Hy/skj/gQyaqUoC1LjtCTSSkJhm+Af/DgLuglw/h5iQFm62+7/7IgBt3ZrNROoqLY3GyxeejAueY+2HwZ+bPcH1FO4EMj/V/6esW3Okms61mSo5RtHVctIh1ofIpE0LKkXAVQ1CYnzVMHrXIiWFLtPj3gNBePpsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fi/bIBB6MeH7+HVN/QYs/1v6cJOsHANdBAn+qsZQJ0=;
 b=xbsdybVIkl8HNMnlOmIKLxIuqiY8WiIyxbsi3N+eOvIIFjExhh4qZpo/T7IALplBdRe6OibUbHdXm+b0yfQwzQp5xDrs+NuAStU2nRNcuRJqENwj5fUUJahp9ZoreMeIjFTcVyIVWSCXK6+iIZm8oV1on5VQHXVnNPLOiigorPOoDvC93jyFAf/tRwzGPLTaimst7aerBJSM/NTOHrkbEUs/0On4bw9Er3jK8QGhZmE2WskjYfhiH3rWZVxH5rhDSrcQrU4pQ2G7MV6e+w3smEQGrrXMdp0UZqEgal8ln+m8gPlIs5C5zTMl8rK8QNLFi9ZpjCrF9g1xAPUPBuCRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fi/bIBB6MeH7+HVN/QYs/1v6cJOsHANdBAn+qsZQJ0=;
 b=d50Ds3/2QG3O+YWMcUYWqD2OyTvq14BsKe758BNz0o0PZeXxMPEm3kJFX8kehBtrG/TXUeg7n5mihfO4JBFkCCZwjk6RX62iQcHj41IO3KHAx54EYQ+LbIJibXy9/vJEjBXwCJLHB+xpDMCzZIrY3nhl++jR4I4S/AW130usi38khEBW20OQYEVAntVV0Qsojr8QeEps3kR9KUMlaZsx3K766WiwyusmkKVVZglEzwRuWNpb0vVa4dqI0uMqciyClzGMjTgZ9zOjL/JeQw9GNOp2EzWJxc7trKQ09MzbNYLl9fDb94O44D8mn+dzoIMH9ro0L4OAfpoMpIA8ZgA4LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB3410.namprd03.prod.outlook.com (2603:10b6:406:bd::11)
 by BN8PR03MB4979.namprd03.prod.outlook.com (2603:10b6:408:db::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 10:20:02 +0000
Received: from BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c]) by BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c%5]) with mapi id 15.20.8722.020; Tue, 13 May 2025
 10:20:02 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v5 01/12] drivers: i3c: Add new i3c uclass id
Date: Tue, 13 May 2025 18:19:02 +0800
Message-Id: <20250513101913.30880-2-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250513101913.30880-1-dinesh.maniyam@altera.com>
References: <20250513101913.30880-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To BN7PR03MB3410.namprd03.prod.outlook.com
 (2603:10b6:406:bd::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB3410:EE_|BN8PR03MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bae4bc-3624-4d7b-e1c7-08dd9207b8f6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8dA8JJZ8HbgKASpWtmoUDMnwQ3Px2kEdTzXjqCUjeHYEo6j9XZE35D0PdeBo?=
 =?us-ascii?Q?jNG67Feae10JacajxLwP4bX3sMv1rBMoJbYnf/YJZxMYfX3GYuI4X2L9YYnb?=
 =?us-ascii?Q?XYg8wUvDVkW7ktkWuvZq1HmP2elFIMTa0MtfphRnMPnDqBWNlFMhoyzDbkMM?=
 =?us-ascii?Q?OOwW+kmZ11AE+W4HdXU2dxry7v9wkprMZl76Et/nzHp3JtRZWEgHONVMhg44?=
 =?us-ascii?Q?fwPirsuKGa7pBI+f5P7AEEh6PGG4BJx7lBEl/daWtSmM5DLFfnfYS+a45AvT?=
 =?us-ascii?Q?xY8l/UEZrFH5QmU5idkRSXyC7YzkhkHSDMveLpnkJlUCtfU5mlW9xt2VDE03?=
 =?us-ascii?Q?Siu8rHNfNH/eMXpbsHKPEgt/P+6lVuk61WXYmvBfo8p06R+eL9+cARP6UZ8+?=
 =?us-ascii?Q?SyQutPygXSu73PZ/EY4yPFzDeJd+To5hZOMJNb9gVY+KqBuumnSQpaMuRReC?=
 =?us-ascii?Q?i/zrvOjbAQgEP/6bx+Je/5gTB731wPamhSbEmDP7EEpCVu508wyPY4slPLrq?=
 =?us-ascii?Q?yVl9e7WIaRER08qj+ZraEoLIwJx1GydY3ttWmiB4FOD1g/dgjrLAN0hovEmT?=
 =?us-ascii?Q?XgKuC6Q6QKyYa/cik6fx8Ajqe64ZN4vtumX0CzDSbJ7ZXRPpipXrOKZBKyBd?=
 =?us-ascii?Q?HdcunB+/sflkaQy0odhI0ohLXlOgRO6a/9B02obwSRaaIXoiasa3H58F97MD?=
 =?us-ascii?Q?JJo3bl9F+W5Fh6jQhz8E0DQaOvo6vzvCnoKH0nIPUoPz4wBu0/rbp4HsQt0+?=
 =?us-ascii?Q?4QXXMz6OS+WNcvhA+niV0I8Wm8MM2GksJVf44Imv/RT7d0Vj/WNd+CbW/WZy?=
 =?us-ascii?Q?jZ+k0jpkPM7hsR1sm391VYzLo8jKG4qmalz1KrSDKmyUID8qgzn2B3urGI4r?=
 =?us-ascii?Q?MLxiRkLFUWku6DRGd2V77UOiL70EIXsEmDaWZYVi1J/2pymxP2KIOKRfulCZ?=
 =?us-ascii?Q?qyy3tqu7uuLNcH15FLtuWsT39XAGQpkJ7xa5hzT++DhIRmKfm31M67BtGVNE?=
 =?us-ascii?Q?uYkHGCNAdzpAtec/KRVtYq6ta5nur4LqGnkPrjRQb6o5I3z8fbRQ4nwE0bue?=
 =?us-ascii?Q?JuC7mKXqkkDFhJ784dvwQ8G3foUor9roKpD1FwqRwXq+HHkCs6sT3WqkbXJD?=
 =?us-ascii?Q?d2Hp7lzGjeKyeUodxXhGjtBLt8/EJvY7Xn6HXTMTpXE1D5m0xZHIUdnvk17R?=
 =?us-ascii?Q?xmNuINTJODrT87os7PwdBvJlJayh6ZqSs6gEXZLxzp6lpUpiDyRJGxfGjVQ+?=
 =?us-ascii?Q?nvCDtjCPm1IpGK6j/R4mVaROHlCPRIaC+kaEnkRrBgXz6VPnKQYz/QYTApOC?=
 =?us-ascii?Q?EzP3DYNOrHwuXoAShY41IWzzlF9ZbD9PH3LJOREbTj3WCSeq8sn8IoXgo/Gr?=
 =?us-ascii?Q?7NKIC1yP6+P8Fvz6qR468nSxzOp1EldTMfA6F4LsQvZ/8301Sz9PKAP/Cku0?=
 =?us-ascii?Q?Po/V4S14dm4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB3410.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EQ6Bo5lpjgjXoN3Z6PqIDvK/gAy1PSaQ5rdr2KcKiUGJEuXBr4UoUrS/ukMG?=
 =?us-ascii?Q?WHJ1yxuhLpUMB79EdgSXxOHeu98FPi/JYHKris2q1FCGqXIkMpTHFJRT4ncR?=
 =?us-ascii?Q?BOdaC6isPIRopt0I6U8aC3HZMcF1/2HbM+DneABzYuW3ORShhv8QYlN84dWm?=
 =?us-ascii?Q?q0EM3/PxfZ2zpvzPcujZ+z9+Dl7q7yq2odabqBEpX/q79OLqti/V/5iY8Q7x?=
 =?us-ascii?Q?IRLeZAa7RkVlssr60eDofDNQljmHwai/b6Zw4RwtYp0gW1kTZuEBU2cD3xne?=
 =?us-ascii?Q?upbbWDb3YbgPJDkvgbLFK7bv5D4dGy3M/IZ/o7xTNOE3JSdd6w7PKh9BSdZj?=
 =?us-ascii?Q?Dw2PX1MP3LSt6bR5ue5nPkRHBKzNtfJuNUlLAzGSxK1OV8MUhRadjJrqjhsZ?=
 =?us-ascii?Q?v8l+RTpicnKW8QZyOz8om6D4n633qQIf0AylYnlWHqGW5RerLNBY9lNQHeEY?=
 =?us-ascii?Q?E3JD06YOWMHY3xUo4WobWtHkt14cXVYnT7XTwBdaGPStQhuuFMJOfELZuSPQ?=
 =?us-ascii?Q?MuZoKdXhYZI/H9x3PbPyK2f4bfASWnbQC5RvB87CtdSLVtAxpyjQKsnU5hR5?=
 =?us-ascii?Q?jclwuPzax9qoUXJoxALdXQPpcz0mxvAfKKuqvb4EF2kZRhyFtDvQOYKW7cqv?=
 =?us-ascii?Q?pXJSBoJesLskhw6m3BNeQdANYX25cCypGOEeeCAMs640V78vzBpMKaABjYoy?=
 =?us-ascii?Q?FJ+SGXyD1UPQZkVJV2hmzg8qOALgidzqD6MtDXhwuV2FusSioK9uJ0yKmgaS?=
 =?us-ascii?Q?TOm9xHbvDA50G4y8PXDUXEv46eCm5DeDImlnuscthJDx7HXI0t+j4mBsr3KT?=
 =?us-ascii?Q?Dt9EIWiNVGc7lfbHkq9zuB6jVKFU1NaTMKO5SXni8n7bEML6E7zdseZ/2XBq?=
 =?us-ascii?Q?8wsdoGHE/MJ4J+8cKxQkFTR0/mJRNswgrA7O+mOn4y/if3UYlLYnpR84lStC?=
 =?us-ascii?Q?g6v1XxEvah6Qzsv28s7wtLtUOMq3isaOqbTxk1ti/Ye7vtaFQd7U2jurlee2?=
 =?us-ascii?Q?vX0U8s8ZBnq6XKlzcjPv4dwqTqGHKK2yRlbJCY6t9UGxQ+TvpRQ3iei1xBKQ?=
 =?us-ascii?Q?gmuLuBd2V4X4r96pXpDwm89hY6uZtiJSl3UhRukM0gB65nsQ9KPErnI3ImJy?=
 =?us-ascii?Q?KbeDSS3Cj7RvzZ+E66dAKVYW6EWOfwEQMwZN25UWX9Ymu5CA1HhvTBDwxXRe?=
 =?us-ascii?Q?r7PECNkQd+ujAzn/3/Ha2bC4FNRixY4t/ogjnrb1rxzK8L4ESSSEqlRvrNif?=
 =?us-ascii?Q?vomqXcQgBRncPgVCUXgmPmzcTuTB/zDzvlG4gBYa49BWqfwKbQA1h8TnH4AN?=
 =?us-ascii?Q?pDzihoSYpi+mIzok8q2HukhQdA5mf9ph87TPxgliqVI0pQ5AUUGQLhwYmrok?=
 =?us-ascii?Q?Dc2GRj2IBKoBvLbh+HUpc4mJK8FKdWhf56/tUFbplCtnBKoiE4WpBDCFDJbJ?=
 =?us-ascii?Q?nmNA/Qy2MNeq1TbhzAsgIwLjyQVba+spVpORoV5/HPFDf5gpTqPv2+FpvmKD?=
 =?us-ascii?Q?VAaj/5bx5zxV+hx/M0Glab/YduT+idtSgbg+NlHeSKawqBiueigt3miJBx49?=
 =?us-ascii?Q?HMagYlUoC2K09kG1Z5uKuSj8uw87aXFabss4jdfNZjEQHK978/HUmoExmgrE?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bae4bc-3624-4d7b-e1c7-08dd9207b8f6
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3410.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:20:02.4952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYL5l4jLuOqX7BdFN/Hcic/gquH81awinnpHLafe4abmNU6ddu4Tax0FLk6cSZ643G2xjJuJLphRrD4IsYUvCLDelv3wiECoptq2Jl8mkZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4979
X-Mailman-Approved-At: Tue, 13 May 2025 14:28:49 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add i3c general uclass id.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 include/dm/uclass-id.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 270088ad94f..1d259b439ff 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -78,6 +78,7 @@ enum uclass_id {
 	UCLASS_I2C_GENERIC,	/* Generic I2C device */
 	UCLASS_I2C_MUX,		/* I2C multiplexer */
 	UCLASS_I2S,		/* I2S bus */
+	UCLASS_I3C,		/* I3C bus */
 	UCLASS_IDE,		/* IDE device */
 	UCLASS_IOMMU,		/* IOMMU */
 	UCLASS_IRQ,		/* Interrupt controller */
-- 
2.26.2

