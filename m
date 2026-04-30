Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1D0FF8873
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 12:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C87BC845E9;
	Thu, 30 Apr 2026 14:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0fD3oMj9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A9E8432A; Thu, 30 Apr 2026 14:20:55 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C311A842C7
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 14:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJT89Bt6+LgQAEwVD7CDhLsEYgM6ZAkP763DJ83E/1iaH7D0/qaRQeYc1JA/+aZqOAp3SKH8EDb15bfdP8i7DOaUqqukbNFQIlOfpv7LEE4aU0sAP/sfZ6vHyC1a2ePabf46CGxGhcLF8eChPs73G5W1xD+usSwQI2X4JeyHOGX8WRNoWHef+HOhF/SAtIVRBXk9KthBT4TTo3jDr/TVB6lLu6ie2RwglTeHfTPjDzVK8pLGNq74zjbR4lV8JtP0cKePw8oAGCJeh1f21AR/lgPg26XQec0L8lfMij5hGYhdiaj7vsFKZi2IfdrdSnJYNBMXvzZHxEOMYhgqPu4F5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Mf6dVBGhR3uHPfYmHk/m3ItB94zOifWssasQ8fKvr0=;
 b=i0BcjY/YahZ2dyHrdJbAHmV6e6bCHi3Jruy//Jawbh9MNPLovhZkvCMWMoQB/1KFj47LUN2rwRzAqRj6PqUbybd0hZE6d0m+iHNjdfmrQCbTZ2/9bGy91FXa9IddcEUAyE+qtHxvWh7klTkj0xMRvwkbEMYLkeJ8raxdhmetroBef4Tt7gBUAkVG810bC6SuiifdGp/s0YNpLbHx3Y/QBeHtYkoIel/GB0/njH0Uw/FU0RB1YKD8N4VSvtH/ixgP+z/2OueylpMupuX2AQTU1fRVO2j70WIKwRC/ZnFq8lMUtahVCPUewqXvECkmBQk7iNFlg1Vd+eatJiDCD76K9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Mf6dVBGhR3uHPfYmHk/m3ItB94zOifWssasQ8fKvr0=;
 b=0fD3oMj9UkNVizUMpiyFj645ASdwypdPbFa9Sstls88fcdVbxHVy0zu7k7+WWVPgEXbCHHqpDd0uzDpfdG+UDlBlLPWtfFt6QNSOsy1/XfQbPB/kJ4uRrMKNmHjh9p3ZObKbtSOy1WboK6aPrAGWatLAgNu28rboCFsb7OZMmhA=
Received: from BN9P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::35)
 by DSVPR12MB999147.namprd12.prod.outlook.com (2603:10b6:8:38b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Thu, 30 Apr
 2026 12:20:47 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::13) by BN9P221CA0018.outlook.office365.com
 (2603:10b6:408:10a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 12:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 12:20:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 07:20:38 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 05:20:37 -0700
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 07:20:36 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Naman Trivedi <naman.trivedimanojbhai@amd.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 4/4] reset: zynqmp: Implement rst_reset using
 PM_RESET_ACTION_PULSE
Date: Thu, 30 Apr 2026 14:20:04 +0200
Message-ID: <9dde7ae68776d22d37c06646210c30c3a5874e17.1777551598.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777551598.git.michal.simek@amd.com>
References: <cover.1777551598.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1464; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=2Qc2Fs37C/jrzKEvtYsVXVOpAMci+CxO5Zh6VKAh7Rs=;
 b=kA0DAAgWqwf+8E71EfUByyZiAGnzSPyjGh15eJjGcTKmq7ZKHqn6WXApsthePlB7IMiaSOS/D
 4h1BAAWCAAdFiEElwIsQKz21qUWp1lvqwf+8E71EfUFAmnzSPwACgkQqwf+8E71EfXaegEA5meQ
 y1Y6DwMnayqSfCEJdZH6ovcvDzegvlNGuZ6DGIwBAJhHGxZwHU3c7v3PW/bTiuP/aIwu/WRwVKC
 2/YHBE0UB
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|DSVPR12MB999147:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f366e9-348f-41ed-7f39-08dea6b2e8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VU4tT5indnuLAPORccjlROZnud80KdNzRHyTpfzOjXboHyweRvVDldafvc53aa/kmDnIIvTrd1DV+Oi27oYfXff5eCzFp6mzFgJwYuxSWV8AZwxXZb4En3UvIzylTz9JVCuSL8Ha31e6r1oWJ2dDVRxQTeSQ4lTIWrfFWLkZ0aWLDaYddziLZeGC27dPmsxHVRJwX9oFbQW1w9TtOzqQj8ENytDc/h+Gn3hCsBlXkR4B/6Su7QWk0aqajZYUA1JnPb2Vyip4zSx15hImUIpT+tbO7pVKH2RQdCb3dOq/Jv8MywoXAoH4/eaTyQh9Z1MsGZKt4FEWwPVuWm885twZUiVHHB1pv8qKXnEcOWVQeClFClIwPp3jmFLAZPkbEeMSkx10Prirwg1xUYA60OCP4J1YxxkfnmsyvsOmcgIMBpipTy9X7y+SFTAM3Jav6t3vEEzbYi+Zdqkn0LAI0mSuP1jdnyQ8uhMdAv8J9Jrr7ViiB2HH3yocpSQGuXIW08xGytWwWSuM+9951MoFHBQ8tJihlXcFG8EZjE3xJriRZaniTv53SFd2zulIRiCIQzOlaAEeEBkr8mQfoCE+uu5XUyeeiC3O2YPnTMQRmPX5v8gWrrB/daMWlnDr8DH+sZMLsALIwONnbNSugIvBYmXUxSEK0ULc3OIrNl2bXIsrInqZr+Onk4uqKjEgin6yJWeevt6HEGBI/NSk40gyLFxjmvqUOLP2aKqxvb5B4b6u3qefU5t3TpQ58jFmk4c8UebDtpO453aRc6XW/T6EHljRGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hBBPmk5eheU/6AmKvKV0kbVA8iwdZvuYX6OWIUZD9EbXT0QpLBJE53SFSY/1IfDKYkRFN3Hog+xMetnq7gFehL54jqklCkjDDRHdeyeDhJJYfQhyUWB1qQ7SD7pEkJZmaMyPj9LwgxAYfj1CSSYDznKPW7ybmsofpu88wbrJUuB7GwGwlWQrpQ/H8+0Wjsa4zvn2kAHusbafFUfdepmWp6fiy4NzLuGlmeskMtCkC2PMk0VT0I7dF+OBt9QL16ekK2wy9y4JKQthrorBFxApF58KXEYQ3wHFLbhOKpf24cjtTqJowTum6x4WN6WSO1Mz1tOdcLwhMtKNrbz4WJClhbo8Z7NO1frmNv8Gq0swJjBXpNFsEmewK5NS+4Vgm4oKjjV62NtA2rdC/kZs0iskhxpQdorWbIQwrlrhhnhdgwjo0jsNI4QfzT8KjwGRckHb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:20:47.5086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f366e9-348f-41ed-7f39-08dea6b2e8ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999147
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

Implement the rst_reset operation in the ZynqMP reset driver to use
PM_RESET_ACTION_PULSE. This allows the reset controller to perform
a reset pulse in a single firmware call instead of separate assert
and deassert calls.

This matches the Linux kernel implementation of zynqmp_reset_reset().

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/reset/reset-zynqmp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
index d04e8eef3bb4..b87085b6c5e1 100644
--- a/drivers/reset/reset-zynqmp.c
+++ b/drivers/reset/reset-zynqmp.c
@@ -45,6 +45,16 @@ static int zynqmp_reset_deassert(struct reset_ctl *rst)
 				      PM_RESET_ACTION_RELEASE);
 }
 
+static int zynqmp_reset_reset(struct reset_ctl *rst)
+{
+	struct zynqmp_reset_priv *priv = dev_get_priv(rst->dev);
+
+	dev_dbg(rst->dev, "%s(rst=%p) (id=%lu)\n", __func__, rst, rst->id);
+
+	return zynqmp_pm_reset_assert(priv->reset_id + rst->id,
+				      PM_RESET_ACTION_PULSE);
+}
+
 static int zynqmp_reset_request(struct reset_ctl *rst)
 {
 	struct zynqmp_reset_priv *priv = dev_get_priv(rst->dev);
@@ -74,6 +84,7 @@ const struct reset_ops zynqmp_reset_ops = {
 	.request = zynqmp_reset_request,
 	.rst_assert = zynqmp_reset_assert,
 	.rst_deassert = zynqmp_reset_deassert,
+	.rst_reset = zynqmp_reset_reset,
 };
 
 static const struct udevice_id zynqmp_reset_ids[] = {
-- 
2.43.0

