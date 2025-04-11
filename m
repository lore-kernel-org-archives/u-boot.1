Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE4BC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 05:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B5A83E9F;
	Fri, 11 Apr 2025 07:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UO1EYtEi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B726E83EA6; Fri, 11 Apr 2025 07:55:54 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E8D83E96
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ST46bhPK5UhpEq2wK19vBsmbXM2g4yKysuPOoPGBNXcUVgN6ZkTEmqpf6rV1cSbKgjBgQgE47d+nYxFqOZoPLnxGp3hUbSrrHCELqIHRy+LNjPa+mUDwGw7wVuBHx3m2ItYSMVaF3pIO124NxA5rDO+P+Gc0P3/lDq6p4lMMUemyHJ54+fLTyzyjNj4EWxLVELciZ0Xc+wBeXPnoOBw2xdfp1pVHgOW76bx4RgfdivzDWjVKhWVqhbkOvmWpIjlsg1DF0r06T5yaimQC+ghnWh2KnIPYhpbjav4y9kRwE69ywpxj0GYVTgR84Se/gAyddG2A3MPU87E5tqSU+weE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsQZZh6DASF7pUt+N8712CKL17YoTl7KKw095YgtqsU=;
 b=js7AaMZs41CkxPC6aE+Qk25WNHnSaq6lLFTIqScy1j+ng6e/hvPwU7+DGStlumHimfOSLwkW+pNhEl1z7qyuWX5FNp5bdrvTGIxbZseCJGT8W3g9Jom1iG9UPG5WYT7CvFmYdJC6HdnHozbZ7PjxdPqu52pWDlet4pd1XIMCfn695LnZEIPjIiLAYYZZge9rMi0ZKs81Mgbh+rVfZCXJluDoNNyNjmyB1rukKT5CTshpeozM/BDtgs69iHCEJRA1iVKtPqK71qgryuEj6jUQhWtBmW9C5GBEmnJOtiTN4BbCndZiy3kOwcSMb5cVSLvZe2FmDt2OGuGJygkWeKnWYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=amd.com; 
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsQZZh6DASF7pUt+N8712CKL17YoTl7KKw095YgtqsU=;
 b=UO1EYtEiH0L+SJG3Q32VMlTFtVnzeBbGAOu63To3nF5IvmqtZRBVbVoUO2LhI1KqTHlxQtBXZJYFfM+7/adEbde1+UGsva4SbXZlxAPHpliqLN0eBG7LZ9lhzJ/+TeCp2jommcefnNPExWaXPoSUU2djuk/IetEqaAeU0tXpETM=
Received: from SJ2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:a03:505::12)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 05:55:46 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::46) by SJ2PR07CA0007.outlook.office365.com
 (2603:10b6:a03:505::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Fri,
 11 Apr 2025 05:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 05:55:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 00:55:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 00:55:42 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Apr 2025 00:55:42 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2] usb: onboard-hub: Fix return type for regulator APIs
Date: Fri, 11 Apr 2025 07:55:38 +0200
Message-ID: <a2d520f14efc30fc28ec59881205e156dabbfcd9.1744350937.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 75aeb80b-ef3e-4dcc-2911-08dd78bd805a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ofj2SHkBTxJPspR6y/4aixpEGoSQfx4MmKOJVJkbzp1hUqfzpdQ3cwxwCquN?=
 =?us-ascii?Q?IZZDIEDlIMfc3lLd9Jo2G3ENIwrRvON9npWaTxJ+2IDOtDS1alfEQqg9+7+q?=
 =?us-ascii?Q?uPzI7bnBtSDSQlXACanqwm1QKp3TOkvrazwi5ErlGwPuGAbS1bK064Qz/FN6?=
 =?us-ascii?Q?M47Q/jIoNMShTLLmSLOGnQWnxzeQCTyBtQVqshQgEBlZ146HT9KpAQELiGIu?=
 =?us-ascii?Q?orUEWBPuyScCDmPXBxtCUoe8IUUW5Z9q66Bnn0W0r53relOutFwDmOyo8aiu?=
 =?us-ascii?Q?Rr/lAYBAafB6uGviS4VcX49eZ9oZHltqXDBMlG0wpykJj9Z6/h1Pr/Mi9mOj?=
 =?us-ascii?Q?tcJmUwT/gKMrS26qMywPaP98hzrkGODtKhyrEqw72cu4G65MgbU2kQFmpU+2?=
 =?us-ascii?Q?zlVeAWM8DqhNDa7EjigzJo1Jhgu18NF6Kf962W1Gf2r8otSAOIAl1qMy0WoI?=
 =?us-ascii?Q?ZeEKRnUQM+9a2vcn1QeMMPAdp2UmorFvKwIzFUqYeBSnNkpfj0wq1rl37QEh?=
 =?us-ascii?Q?LxXn7ILSY82RhXfpiYFpYPMGzGs4rLGjk/6ol5uiernVvTXQqMZy55Yoa1r1?=
 =?us-ascii?Q?m7SutzZErriSfj86ZdMnG0lJkPDBwNh53u365+fiYupcBdkuIWrS4jS4P4HP?=
 =?us-ascii?Q?XBX7RK7VJzOcKdXKP1mKkUK6qwNgC5+KSOyEb5cI2gsvq2BbKZTH9kFK8jqx?=
 =?us-ascii?Q?vhUVpSVtUxXR6Qit2pZ4MfDGU5mB/ZofTBi4uVz7R2ebCskfytJoYk/xu6Vg?=
 =?us-ascii?Q?5X4hUxTYD54ZBpTPHnRmQZ2F1k8k/lsdr1kDWY5yix2a12r3S1PWB+eavRjN?=
 =?us-ascii?Q?olnHjZe/QORbLdAVQe9uMLDXzL53wiwaUVQC+b7iuO3jXn9I6EizcLmpAxKs?=
 =?us-ascii?Q?U1YmIJ18c0owBihaXhNKv/DrFA+F4Eqo//YElHyeKPJyEZKHPsa+072bfYm3?=
 =?us-ascii?Q?x2wFPN041VKoK7CfAw7ktiqndnao+42NBQoDym28kHJJqRPD2GfE3w7xaYTa?=
 =?us-ascii?Q?s76WlT1fxv7oq+usXbNkH2t2qIhfhRzjTE8P8IoIh7hlC61//Fj7o5dXHWEW?=
 =?us-ascii?Q?9yu/Bf2s6oSlsEBgm+amFcbX1QspGf0QuKQF8vfz09as67uuObH7YDkhVgEd?=
 =?us-ascii?Q?1DIZrLYjq/C8tcLKtlYiTW85WZX8pHgQEl5f7SDDOhEeECS3e9oZLJWwTPLU?=
 =?us-ascii?Q?zjttgJGj0+LXDqwLi4XpnjwdB/AmCykP+FNJSUUa9g5sphvXsUGyatbSRvIC?=
 =?us-ascii?Q?XRxy1PH2gYHRgoApquXGH2sdQFVPX+o/YaJ/ChG2hdTYd9pA20NaDiEfNy78?=
 =?us-ascii?Q?TkLjGvCDg8naV7Dynu1Y5YR0DXYQEPlnq0j4bjg3gLLxdCEp8PJbWAq4nD74?=
 =?us-ascii?Q?c75z523/w97U419TWTG03djHyVNstlxa61CbNYBwvrH3yBJjfnea8J+jfG6I?=
 =?us-ascii?Q?rY1SlFQ2n6Iib9JTcmy21WMaMKLFR/9UpCGeGxKbAx4OEcFzKpNdzGxIfbDS?=
 =?us-ascii?Q?s33bglH31dsXjqgIkZASrzRndmKxD3cyLjCF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 05:55:45.2460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75aeb80b-ef3e-4dcc-2911-08dd78bd805a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
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

From: Padmarao Begari <padmarao.begari@amd.com>

Apart from ENOENT observing return value as ENOSYS when
!DM_REGULATOR that's why cover both configurations.
Changed code is not working as operation should be "&&"
not "||" (ret != -ENOENT && ret != -ENOSYS).

Also fix the remove function where the regulator_set_enable_if_allowed()
function is returning an error.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Update logic around ret in remove - reported by Marek

 common/usb_onboard_hub.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 7fe62b043e6a..d17c85dd6225 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -146,7 +146,7 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	int ret;
 
 	ret = device_get_supply_regulator(dev, "vdd-supply", &hub->vdd);
-	if (ret && ret != -ENOENT) {
+	if (ret && ret != -ENOENT && ret != -ENOSYS) {
 		dev_err(dev, "can't get vdd-supply: %d\n", ret);
 		return ret;
 	}
@@ -204,14 +204,16 @@ static int usb_onboard_hub_bind(struct udevice *dev)
 static int usb_onboard_hub_remove(struct udevice *dev)
 {
 	struct onboard_hub *hub = dev_get_priv(dev);
-	int ret;
+	int ret = 0;
 
 	if (hub->reset_gpio)
 		dm_gpio_free(hub->reset_gpio->dev, hub->reset_gpio);
 
-	ret = regulator_set_enable_if_allowed(hub->vdd, false);
-	if (ret)
-		dev_err(dev, "can't disable vdd-supply: %d\n", ret);
+	if (hub->vdd) {
+		ret = regulator_set_enable_if_allowed(hub->vdd, false);
+		if (ret)
+			dev_err(dev, "can't disable vdd-supply: %d\n", ret);
+	}
 
 	return ret;
 }
-- 
2.43.0

