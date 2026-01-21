Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8BAC44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 19:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DE05839DF;
	Wed, 21 Jan 2026 20:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kjHCumpy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AFFE83B0B; Wed, 21 Jan 2026 20:53:55 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51386839DF
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 20:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MX5F25JMvwMQ16OmZ5qUOZnFmFqgYqEo81hB91Qk3VYDMc+k9O8fqFYdmf7x4WL9ZeG97MMGmXc5305YYn8pqJGsF3PjmCIxZQ6yj3wcjWoY8bxXHnRXpcnUn/cz5f3cMYzSe8NlQLYijkM2DQxbS4nKV+IF4xYRnysRWLyxAVD5Go1TUfmHrv47svIF2kjcXw6jmzx2Hx+GyeeyaZ9X/OvLp9EuOwfs9JrY08aSzZe/tqgeiKu73aioOhttrE166Q7WyaTTtVlDwpUDRLnorhZtG0DWEpTPITcDN0M5xtBY/tAOxMlFPewXqnA/EOJh30wZxVlcnhV2L1hBFxOlDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0cCU3C4SeUMR9CEAo2EnXWGfrRk8DW55YcKHSwPjMY=;
 b=obfQ80ETTZ73dC07wbA5Wxr2Tvl61vJHw+Wad/YaVeZBPN7c/qy5tqp3ZMNbtXka07toeRQ0mq/h6D0vcOMwB+W4WZ4dE7Eg/lJt0kKFsN+rDHLcZkgXIhGUjX1/D2qOCZQpqfBiU17AAdnBMBV+rtwd0OUTPbH8EI/J2eXF1qFN22/FASjN5osm7xZl75Cr3/6sboJSJSPcTIS4j9QIEzxCi2SzVEyODs49q6xZEGK8lPvFdU0ee6tN4vcjGsbgZQsNse5ex11bxn5rjLdor7HxzkmX++mHWq+R5p8h1KnWQ/sBc325cEAhNY0psN6ZU3pVKZsqKhrPE8mX9AVeiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0cCU3C4SeUMR9CEAo2EnXWGfrRk8DW55YcKHSwPjMY=;
 b=kjHCumpyhB/qqswjOeiwt8m1y/+ev1hdR+MYpwfRVi9gf/cUoinixAgUXiRoDAKOIVKlz3jZkLnKCBdebn3aPJHRWTdWHJYxZG84mWtMW+O8lO3f1Tz7XkvVL8OdFSOKTvnCD5OdHBuBIG6zYwKgVR+OnL6pzFHZnjxIvKi4SRM=
Received: from BN9PR03CA0868.namprd03.prod.outlook.com (2603:10b6:408:13d::33)
 by PH7PR10MB5674.namprd10.prod.outlook.com (2603:10b6:510:126::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 19:53:44 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::b7) by BN9PR03CA0868.outlook.office365.com
 (2603:10b6:408:13d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Wed,
 21 Jan 2026 19:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Wed, 21 Jan 2026 19:53:44 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 13:53:41 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 13:53:41 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 13:53:41 -0600
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.68])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60LJre8D3424431;
 Wed, 21 Jan 2026 13:53:40 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v3 0/4] board: ti: Add 32k crystal initialization
Date: Wed, 21 Jan 2026 13:53:36 -0600
Message-ID: <20260121195340.3041549-1-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|PH7PR10MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ac670b-863c-42ed-f037-08de5926c8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ifOkb2Ca4bor/iLiJv0Eivljk2q+5QHoYWSK2onlt5GonQwilQQdagXVK+Wf?=
 =?us-ascii?Q?2W0lQSKQkrDt3cQTfrkdmK837KORAidJtOdIxQqncOq1us4qN53N0NzVsKUU?=
 =?us-ascii?Q?/Nr3m037jwn7fLbSXsr71ceEO+8AZZXmqVZJH+vOWDTnme27Ni2nW4Kc3zEO?=
 =?us-ascii?Q?XTDkvLe/wqsTRYs5NkX5lBpCnNrpNXSGOjA7wak5L6HCaTBQxGoiC52/TNk3?=
 =?us-ascii?Q?x3iC92hEYhIkY82/lPhMr021nG98bg7ymcLERkfdN38nIb0p5Gia08xxFivo?=
 =?us-ascii?Q?qqQz8MQRtVyskJhmvRUwpzdXbWRCB+vcBjPmH3U88h4ydAeYo+LuQN5MgZ+n?=
 =?us-ascii?Q?H5as3Rc1DmsiCpiVvs3BJesBVMekHHOL9C1IC4uRIv1PfUbJ0wiTrwovSCkW?=
 =?us-ascii?Q?aMs1bZhdfSu+qRrtvDWCtNLYuFOelUy8nUtd1BqmUUd9gwAouQO2LoU25S1M?=
 =?us-ascii?Q?X30Bk8VIbnNpkZVPJ+K+dgOUY0FJu635W0jNU3SNRv9dScp25EM7/h0uF0zG?=
 =?us-ascii?Q?u2iYmO4rXu9YTpZziIBMA4rwaSSDymjsv+jIdJ4tuhVUsSklWPI1yTy7Cdfc?=
 =?us-ascii?Q?25wQ/UKdAlhY2WL601oFD3LcscqdGWMftwuvHfwRIv7npbORYclTyYC8Dtuy?=
 =?us-ascii?Q?wgEiZ3QzNnPOynoo/fM5V75HRyyUv8FAkHmFpZNpX1j/S4kVm5oI65IAJqYC?=
 =?us-ascii?Q?z0qQMOFVCBnosg5Gi63bpEIH/bnAMHfnuBaXVEZvXtc6VyrPcTJt6E1OgByS?=
 =?us-ascii?Q?3B/f2lcKKB6XuVCUvcVlC+y6ATwwTn56ankNm39+9Koa90t+RhSCSIOFk1sF?=
 =?us-ascii?Q?6CElxS+6BtDac8Yhegk4giwGk+sk3yAxDqNFmYEWsSGInUEyTmRHXw6vVWBI?=
 =?us-ascii?Q?tDiOuxMBjMOI+T/T3bmXzYZ4O3oogsDixh0zLnSqU5sV7GfuoEDdtnBgDeom?=
 =?us-ascii?Q?BzRojLUL/hej2VOhelo0q/I8/HS3RmOHnVD7sP9Jrsb9KY4G85gsBKCqOMcy?=
 =?us-ascii?Q?f0dgd73b/WEC1D2ce9W5GxLktakEfW4isUCxjpzI3DWg07/OPERDTHjg//IQ?=
 =?us-ascii?Q?VkyIcB5yUzyoqBkYIHuhqrso1oI7A0d189VTU95bp3ho84oWddQ9iqvcl7JS?=
 =?us-ascii?Q?yxdxqobNkx0dxKSlZv4b17oZ19VHJhKA6vHortWxR5PYYEKpZAH+OFjZ/5gd?=
 =?us-ascii?Q?bM/pkp4HEqa6Z+NPbB5Is3LyyZK81K1Bzymfal/JoMUEnldp77xxBUh62IWM?=
 =?us-ascii?Q?c4OXIlGmYCh9MjL8K00arYb2JPLkT+GMAD7LpwEk9OXPHcB35tfeoSW+XDev?=
 =?us-ascii?Q?jA7G5RE4uhJRmbRFUAeMwux7iuTdJSpk9+J4irXdHEhy57LxA78uIeft2kdZ?=
 =?us-ascii?Q?Pu2S9LlTh7qYxBPmrKk255sm79T0bUWSkoCVnBlPd7pj7BoCsPtlXUK4ngWn?=
 =?us-ascii?Q?mIriY+RTqNVWyRYzvAUBJIKt0AgvAR7ynHicTlSqWXNUvn35eFpcYRww6lyh?=
 =?us-ascii?Q?ynApWy3WALL+orWg0fvYQIxldR547LRwWtut5bigluDb5vHzdZUjF/oUmk2g?=
 =?us-ascii?Q?wiMvcZsZJUuoa0t7axhsccY4lPqx9w/5CtA4AIxp8uxEHaMGkBOaymHmfRl7?=
 =?us-ascii?Q?bPqwbOAYaBDdCmXFhwfOX94nbBt9rD951tNusQNMVEKgCdWLgjiJhPCl4ZN2?=
 =?us-ascii?Q?Nrh1hg=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 19:53:44.2665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ac670b-863c-42ed-f037-08de5926c8b1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5674
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

Add 32k crystal initialization support for am62x, am62ax and am62px TI boards.

Changes for v3:
- Rebase and fixed am62d build failure

Changes for v2:
- Created a common API which can be called from individual board files
- Squashed defconfig and board file changes into single commits


Vishal Mahaveer (4):
  board: ti: common: Add function for initialization of 32k crystal
  board: ti: am62x: Enable 32k crystal on the board
  board: ti: am62ax/am62dx: Enable 32k crystal on the board
  board: ti: am62px: Enable 32k crystal on the board

 board/ti/am62ax/evm.c           |  7 +++++++
 board/ti/am62dx/evm.c           |  7 +++++++
 board/ti/am62px/evm.c           |  4 ++++
 board/ti/am62x/evm.c            |  4 ++++
 board/ti/common/Kconfig         |  5 +++++
 board/ti/common/Makefile        |  1 +
 board/ti/common/k3_32k_lfosc.c  | 22 ++++++++++++++++++++++
 board/ti/common/k3_32k_lfosc.h  | 15 +++++++++++++++
 configs/am62ax_evm_r5_defconfig |  2 ++
 configs/am62px_evm_r5_defconfig |  2 ++
 configs/am62x_evm_r5_defconfig  |  2 ++
 11 files changed, 71 insertions(+)
 create mode 100644 board/ti/common/k3_32k_lfosc.c
 create mode 100644 board/ti/common/k3_32k_lfosc.h

-- 
2.34.1

