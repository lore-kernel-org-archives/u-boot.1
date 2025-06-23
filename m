Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9157C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 08:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B888B81F66;
	Mon, 23 Jun 2025 10:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZCZRKHc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A81B981FEE; Mon, 23 Jun 2025 10:06:25 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82CB480548
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 10:06:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1IV1DNFx0h6yKyUhRtpfEqbi7a+A/EmoNEHqNTyXdJFwugePC/3JuHYXOuXXnE2ae8KNXi3CTbftlgyWNr8QnXMHUZv766/ni25xX/vTR+6OsqEE12MURbpflGTERty/ZUnVtU6dlSIK97/d4Ix9LwR6Bzc4H6JDTuEIKw1jY4FNxYYyR+uhI8M/iXEiWS+LIGK0oAP80EukzMb1yVmNSSgwTVZiKPAZ3AcjcXaz5DXAPfXujyGdL6vOdNoK1nBJVyHoUHzfQBFioNsRoc599CGIBhjfwXlczKuvO/BcpIQPj2+aZil0rt6aCqL/Izh5WEoM4d7Y6vAQ2Nh3Ni+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78vpW4VLtTG7E1gNrbsSel3dAd9Z+akHsh6XFBp67wc=;
 b=VRZfhdJPxBdMjdQl/RNBf0JUKqzrUyGGdzEBEPwhxEfbZyGcr6ZlBrkXEJqIXfAEZg7CCtii6XqlqB60aeCFOamOyuoaBuJ0XaOhYz4Tx4yDgRnOpQb/slk5oRRp2+OgZJkBxrqOeVAU1jN7+Y3nmKpXQrVbeg9mtvlxDJLCpiyJFRA+rJEq1PEez9bIEhg2/6dOv+H9Jv7Z5G2AgCzIjdffoXW82mciyyL0pyZsgml6abZobFP2qRhqNlO1B9bac2plaxj8h+zX78srxzCsWWp7W0MMw9qsfrb3VipCe2NerJDDZKjzSjN3ZH6NyMi4j39REf/xuSmWtvV2UYL/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78vpW4VLtTG7E1gNrbsSel3dAd9Z+akHsh6XFBp67wc=;
 b=ZCZRKHc8iL6y2g6lyxi9sBXMKRZ5TqzWCcLms2wIAU7h/dvgyfy7GlvhEdz+y6GypX2HF9gGRp0LnMyeod3pvv/w5QexJTjIz9BKdkWgHtKe5USVVhp6QWhIx3Nyh9P3+zLVlqGepxd8XZNFET6LCH4nnIJEGElo/mbrSq25We0=
Received: from MW2PR2101CA0013.namprd21.prod.outlook.com (2603:10b6:302:1::26)
 by DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 23 Jun
 2025 08:06:19 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::a) by MW2PR2101CA0013.outlook.office365.com
 (2603:10b6:302:1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14 via Frontend Transport; Mon,
 23 Jun 2025 08:06:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 08:06:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 03:06:16 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 23 Jun 2025 03:06:14 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <hs@denx.de>, <trini@konsulko.com>,
 <sjg@chromium.org>, <git@amd.com>
Subject: [PATCH v2] i2c: mux: Fix the crash when the i2c-arbitrator node is
 present
Date: Mon, 23 Jun 2025 13:36:07 +0530
Message-ID: <20250623080607.100895-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: a1433137-52d8-46f2-a299-08ddb22cd53d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K1YZYZIkUvBydIcsWDHlnCoRFbDik9FuYqacpzFZ5PndwTPCL+BcV62t93ne?=
 =?us-ascii?Q?+Fo2WMYTjNaJH/pMzyIqDCSh22P4JHHRWXVHfdDP+Tzps/dsQW+o3dMPSBlN?=
 =?us-ascii?Q?BNBpreInsEV7RNHOqVofQyNzl9oYRtWuTsN7AA6EUN7apuMnrvM/JI3J3anG?=
 =?us-ascii?Q?4y3fX/e5QnxM1TZdq1hnAqKhx8fU+wzVEa00hyya0QQl+BZqhuzXwb0J9BRu?=
 =?us-ascii?Q?ZLgNNth/npM4VrVJ8QBOMzm4DWLv+WZUid0xgEyXIEiv5OkDdpA4N4fmcwUp?=
 =?us-ascii?Q?IUTENNBQHKJYBWNwtfd4oSntu71oGt+gg8j+sdkYCUsdebm1cZJSKLao06IB?=
 =?us-ascii?Q?d7nUpxURTC4vVFrPklJaSh5MXXBpQ7Nrio0M8TpqsaKxGZP5kzT33q8if8Mo?=
 =?us-ascii?Q?KaYy0lumL7aGgpdEqq91J1pzg1k647md1HXtj+mXQ8XfFaw7Svtncgp1dzaA?=
 =?us-ascii?Q?t1l1buNe7F5zCGtm6PdyaPNETae6/RhK5gNc3U5kJcnw8R8jLGtV+uNChi8E?=
 =?us-ascii?Q?iFjY8h1b/wCTCo48liM737TGFvsGgYUvYXiF50B7mVkbbCEqk7HhWGMW5Bqf?=
 =?us-ascii?Q?eoCUvu2ZlyVEbYBlyZPFlCtoqVCT757UOujMhPXhXTUvRwEY11CHT7u2Mi2H?=
 =?us-ascii?Q?rK4PlOBeL7v1nD5Ls7pJcz9PFghVlK5n91iy1XnF5UFa1RI6OU30DpuEPqdZ?=
 =?us-ascii?Q?a2hGOhGQvUR+9GwyqEq3iOh8/5to0he5BSAXIOSG805Udvcgj8XdFvT2icao?=
 =?us-ascii?Q?nQdmmGBPuXgIwyxCLqYgwq5wdo4ywwLJOUMr4T22O2sg7LLDLjiwQl5i9fx9?=
 =?us-ascii?Q?Rj9cZniWDJPAzJeNFzaU6LN6JtO/FENQbPwvFBIDaSjxMetQJYhpVzoPeMKl?=
 =?us-ascii?Q?V1BRzSLD8Q9zq15ZsWvyEZzYPNaBDVEgyQqRuaDNn1U4cPJou7azdlSpx3LF?=
 =?us-ascii?Q?fBS0fyg+KEGvzRjBGMtxeB/TdI6RVou7pHTD/vouziJovsY8fbIyXUF9NTgN?=
 =?us-ascii?Q?s/7KJJn2n6KAWA9oRRjSMptS/Lps5fo3W3y/2LVMBwvbBPoC/HPyilaSPcAy?=
 =?us-ascii?Q?5WjNTijSCOTNSZ6IXCfehD9o8SxjNr/alEpCdBuLeNidDUoMTMVQpbC7Xo1e?=
 =?us-ascii?Q?kklo8j2Z/PEfLB8vW1xNZeSS4YH/CcvBtKvyxHeEVp660m2JzrX1V6sRDkoV?=
 =?us-ascii?Q?79bqZgKbtI3Cnz9mt49BbpjzeADIjlbkTh+8alDayKoaKAgKjIGBpzKiY5Ka?=
 =?us-ascii?Q?1oACmsMNsT1u1kvu3EvAXGCpTDVUlQ0n4eVYf+gdc6Rjw9kewxxQ/1sPUp65?=
 =?us-ascii?Q?UE7z7PH4gr0xY7vBwe8w0kzJONw7LF/5HDbAEAvgVpZqvlv7DzqffufsTdkh?=
 =?us-ascii?Q?UdxsDsgR4Npo8KFeZOnvK9ahi/UMhM87RuyDxMZfN/AiByr71lj5beLcgGBW?=
 =?us-ascii?Q?Ii9E0gqKIfX1C2DiqojN85pLU5WaoMvcMFruUELHmu1sFMEOnpyEhyvnhgf/?=
 =?us-ascii?Q?cK6C357513iWaAladrkBy+eFj3K/boiDoK5c?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 08:06:18.1642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1433137-52d8-46f2-a299-08ddb22cd53d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444
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

Observing the crash when we add the i2c-arbitrator node in the device
tree as per the DT bindings. The issue is with the child node of
i2c-arbitrator@72 i.e., i2c@f1950000->i2c-arbitrator@72->i2c-arb, as the
arbitrator uses the uclass of mux(UCLASS_I2C_MUX) and the mux uclass driver
checks for the "reg" property using the i2c_mux_child_post_bind() function,
if it won't find the "reg" property it will return -EINVAL which is leading
to the crash.
So, add the logic to check whether the  child node has the "reg" property,
if the "reg" property exists then read the "reg" and update the channel.

https://www.kernel.org/doc/Documentation/devicetree/bindings/i2c/i2c-arb.txt

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Return immediately if "reg" property is missing for arbitrator case.
---
 drivers/i2c/muxes/i2c-mux-uclass.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/muxes/i2c-mux-uclass.c b/drivers/i2c/muxes/i2c-mux-uclass.c
index d1999d21feb..012881de05b 100644
--- a/drivers/i2c/muxes/i2c-mux-uclass.c
+++ b/drivers/i2c/muxes/i2c-mux-uclass.c
@@ -40,6 +40,11 @@ static int i2c_mux_child_post_bind(struct udevice *dev)
 	struct i2c_mux_bus *plat = dev_get_parent_plat(dev);
 	int channel;
 
+	ofnode node = dev_ofnode(dev);
+
+	if (!ofnode_has_property(node, "reg"))
+		return 0;
+
 	channel = dev_read_u32_default(dev, "reg", -1);
 	if (channel < 0)
 		return -EINVAL;
-- 
2.34.1

