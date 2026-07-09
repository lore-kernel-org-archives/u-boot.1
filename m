Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD859C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 14:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FD8A84BEA;
	Thu,  9 Jul 2026 16:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z8+rKcOo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DC4D84B7F; Thu,  9 Jul 2026 16:29:45 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A41684BE3
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 16:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBf+q7/4dlT92coZZ8qY2oRyhN2gh/AyP0RgqWTMbx9yq2wDFt/9QhwdGN95OC8mZ7Dy6WxwdmeSWUJomz3uV+U5b4XFasfdpfmi0PKQR2WFbRzWU32aGRyzo81rqSIEJc/p1tDvO4BO4ff8zW+hwl/fnnWT6thcGej/YQ86X22aBl9yTZ6ERQFM3Jbg6mCTspHbHd4MIJd5yQ+Z+OJro3wBPytszQQubBDniEy+Qtwn8XY51gk1G+vcXPDWfrJcuZ/DuawcbIPdgG1tnWGL4zLCZehIxyObVeN9CE2halvwEJM2UmqgUugLDF6uaFA6BlhAccXHH8OEhv8ZaEvycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLmIXXNny3x+DFh0iUsmlh8Ue+O7wzo1q9U40YaR3Hw=;
 b=p1wED7gyQ8CBh/Z4a/8GR59kIZWenNxnWoTuc1qZ8quRZgAfpIRcXcae2TrRc7zio8yDBfkftBDG5tz2isJTFRrP0rBPMyrA6vgT4VgnEfLJECqku3enmCHNtY67iYOlMipyyn8blwYwbebQ7NpFG5DMWrBc+VVDcP2ILhRgW8R0lMUDbCvcXSsDBmEZxbHNCEubFe1nyOW/PHK1c4oPxqTNuEONiFovKLbqGa0bD2Lr0ZuD1VWYuUF/+lOI9W94Ban7Zauiils9Xyc0WjolxDWVrKjqkSeyK0sO3JBZ1506f51BL8z2PWIJ7Ww/bIju1G02Q3W+JA5wWNg1h3gmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLmIXXNny3x+DFh0iUsmlh8Ue+O7wzo1q9U40YaR3Hw=;
 b=z8+rKcOoSyIln/tPDQ8EUpWpgsgjFb2NB7WEcZtuT9n487AMmlYzBHCHGQp2lLnNhW3AMTiC0DXCZ0LwQ9JsE8bwGo2odkkDVOIDYLkKsensm6PmprXxaa0is9bzfvS9LUVBYBXSQ9NmBgAEMsHiAlpMaO4J+UtcMDDkqfZDWxA=
Received: from MN0P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::26)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 14:29:33 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::9c) by MN0P222CA0024.outlook.office365.com
 (2603:10b6:208:531::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 14:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 14:29:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 09:29:09 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 9 Jul 2026 09:29:07 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH 0/3] gpio: improve claim diagnostics and fix gpio-delay offset
 handling
Date: Thu, 9 Jul 2026 19:58:58 +0530
Message-ID: <20260709142901.2054431-1-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6cd132-043b-4c08-d2ba-08deddc67e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: rdxXJbnFWgQwjm40ixhzsgX8GQQnYEHeOjrsdXxC31IW+sphCSjDOZ8/4OgaLHMAXyAWqq91sjfEu9VEugvQcP8QtXvarSCHwLZLoa/JsvVKPepgdRhdJQjCZVkGH//UJrn+7Ceujefj9aIAb4nV8AqmtiCpvkHBxuv+SLGffEAszDvPWqGNqhn5usqz+M2aGmj3QZYciPCBzz/GpSKItwfc4U+GvQjSKLLAL2zQ3351sPMj+L5NSRxWv/5JW1A8+kGYe7EKhi6n8NBPziZ6h4DxfGdQnDoCmAplW8xY+F5NodWZAz9z6FDVONkBbBRH8rsy/Jc2SIKzM5ywOp+jL/2iCvmWMgGTPtKrK3X3764Uh7OgF+lUNnAMP8LDdJc0OI9Un+CUaIkmzmNvV9abIXZnRb6RW6K2PwQ4lPq71PuZgOeK/NrYwwhXKA8mUxZrweGPpXEu8lLkVQtrzSCvnjMKQYHX1F2mbm4tovMP4T70vKQqhK94Vm99tNOnMWC+ODThBLQhZIZWTuC8fznPJQjaQLsI3LqqT7VTfFIM3vt83I3+bRuYn3wPeZB64+hAp/ahRMNXKruJPI/yQDbN5XAV9cU/He48KNckIAmlAb7jq7t6388bIontT8P5J2tAaBYtUVCMZQENdQ+GpA1jUE8BcRGGYbIOddxxzzKJea8rMhSce186tMIgqZKm0zsY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vQrti5+uffb24m5vpDu4QcuBl1xj5KocUrV+7HMGUhjGn00NRtxsBy+8BWB0pBsqqAz3CCN8NyBcgYZgQNNn2dHxAJF/OFyg9EDtWTyqqQA6t8YVrwvNtWzLMNJiVa6Pwr6roA//eQ66waHwspm4iJ6L6wQGBS2Wlyh1HBvQyUkHFFUl7C375BbJltiIfSqdOiuksX9KWZkIaTrXOsYyPTldWSWdTqWbYGn1d7PqrDjV39Ze7muJeqMiieMMi5qiTYjrnfltXJkRqsuU5w46j6XsBb8aHHOOZIaDwFlOsUiv5eBVsboEnd6IETNxy0rm0IpSt2uSWdnYn11DrD+gM6b3s78U1sBJXTV7dMOMt07HQVnnNhgUOLVDg2IOPC5yCpTFgmX4n8ECnKNDM1I4tTaK2S8A0nK5EoL3ozgE+aanys4kjz7cfhqCwXAPPyiP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:29:32.7044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6cd132-043b-4c08-d2ba-08deddc67e6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
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

This series improves diagnosability of GPIO offset collisions in the
uclass layer and fixes two related bugs in the gpio-delay driver that
were uncovered while debugging such a collision.

Patch 1 adds a dev_warn() in dm_gpio_request() that prints which
label already holds a GPIO offset when a new request collides with
it, so an -EBUSY failure can be root-caused instead of failing
silently.

Patch 2 fixes gpio_delay_probe()/gpio_delay_xlate() to size and
validate against the driver's actual GPIO count (from its "gpios"
property) instead of a hardcoded 32, matching the pattern used by the
generic uclass xlate implementation and correctly sizing the
claimed/name tracking arrays.

Patch 3 fixes gpio_delay_xlate() to propagate the requested index
into desc->offset. Previously every consumer's descriptor came back
with offset 0 regardless of which index was requested, so on boards
where gpio-delay wraps more than one real GPIO line, every consumer
past the first silently collided with the first consumer's
already-claimed offset 0 and was never toggled. This was the root
cause behind the series; patches 1 and 2 are diagnostic and
robustness fixes found along the way.

Patches 2 and 3 are tagged Fixes: c866f2f197e2 ("gpio: Add GPIO
delay driver").

Pranav Sanwal (3):
  gpio: uclass: warn when a gpio offset is already claimed
  gpio: delay: set gpio_count and validate index against it
  gpio: delay: fix offset propagation in gpio_delay_xlate()

 drivers/gpio/gpio-delay.c  | 8 +++++++-
 drivers/gpio/gpio-uclass.c | 6 +++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.34.1

