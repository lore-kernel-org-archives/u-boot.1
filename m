Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0F8CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 10:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F47A84119;
	Mon, 18 May 2026 12:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HwLp1Uqj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401CD84150; Mon, 18 May 2026 12:30:12 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E9E483EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 12:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpNkAEza2Mr/9/9nzl7mXDHy4+NFhUBMipI8iaMRUyC4JRb0S98SjkRJR8czhocI5FvevoVsX5/DBd6IQgXD4Hvq1xyWIJ4r6A8rFu47krYJjw5Su0Vmc9ydOk9iJceYfwxDb7HoKMCdGr181AgVtLdhO2FzCFJeVVEla24gaHZLrmYrauVF3x5EpKMAnGoxyDInitR4OPyopBRWlUMMayOT22boF1qlQ0HXYPI20xJa9iLmBWyAesdeJz4U8JuPB4NuT7o0o02p0cvL74jf+fm46tMAdOw8QIu2eSBlv6vxeGyVQoAc9KFTOLJXj/JX3KzpYw2z0F27TGiLCxDezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKFfj1vBLTYpvjWPnkSGHS6+3UbAsIJ1/vpA9mAqgCo=;
 b=RFxjF6tdSn4UJVzTgdzKRnVXTgGdnGLGAJnt4Cx0povM7r6ZDZPKiSyWlf1uWuW2tFmUFu57Vjwp+g1ygk2STnuBPyJ5kBVxEyaozE/NP3wNz8sUXBarjHc55zefurnZcq/WP8J+3BHjpFClBp11EJDzSU+hDSgtMNhO0i6FvjPDlTh9cgNrkwiyhQBqKO18akbMRxuBCHyvW8gkcyiDHiETrJZ14nvIVcc1kiR/NPPIrGNrZhztHYSZr9kqTcG0AIP25nulbeuSuggBTJMsxKPmDUO+fI1Vs6TLmKdJQCoKjz57fI47l0uNYSILFjDMGBw6O64jwokebY24M+rw1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKFfj1vBLTYpvjWPnkSGHS6+3UbAsIJ1/vpA9mAqgCo=;
 b=HwLp1UqjZ2XliwcRnd6q4Nk7DG/tmDAVGnCVUYGkJOhjDDg1U+D4iCibvBlKsB4ex10tPptoyPEfjMjCF5M0CM6BV9vF/nNpToTlMofYR4Y2nJUqFIrqkm2aae6Xj4WgHLjOkuypR007bEPnN2GmRJa5j0hrXWJJXgz5QGL/b6c=
Received: from BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::17)
 by DM3PPFEACE3F2B7.namprd10.prod.outlook.com (2603:10b6:f:fc00::c54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 10:30:05 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::1e) by BY1P220CA0026.outlook.office365.com
 (2603:10b6:a03:5c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Mon, 18
 May 2026 10:30:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 10:30:04 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 05:30:04 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 05:30:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 18 May 2026 05:30:03 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64IAU11J1686547;
 Mon, 18 May 2026 05:30:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] board: ti: j722s: add processor ACL entry for wkup_r5
From: Neha Malcom Francis <n-francis@ti.com>
To: Abhash Kumar Jha <a-kumar2@ti.com>
CC: <trini@konsulko.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <sebin.francis@ti.com>, <u-boot@lists.denx.de>
In-Reply-To: <20260515081745.1062139-1-a-kumar2@ti.com>
References: <20260515081745.1062139-1-a-kumar2@ti.com>
Date: Mon, 18 May 2026 15:59:54 +0530
Message-ID: <177910019492.553890.3033295567098441334.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779100201; l=238;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=Q/L4w0kc3cjQr0T1xL1SyRM+FHrG93IV7yKLPSWIvio=;
 b=PkFQmGhh3ViEJRrjEkKRWXQRMA8sahZ+iXE3c6BZyj8kfYHr8zjOVfZBCPl8igsL2Y1pa++o+
 qck6xChoB6XDyg2e2vALDoQmjh+X0lpJ/8PEW8QroHB2lTRyx3fOS4q
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|DM3PPFEACE3F2B7:EE_
X-MS-Office365-Filtering-Correlation-Id: e45b5b87-19d8-4727-01ab-08deb4c86ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: JcRxSOUA07nSYlniOHEhakgUTf70ay36bOtRlZNTsi6h4j0iEGisIg3fM3wQdr3CJ1l1wXfoA+IPMiVZSUI31omeQHwxK6rDNo1Rmm/m5r4qQTrQpEO7VK/cZ4vGczlYv+QVF1s9M5H6IB8N8ftz+YJkBy746Koo/CVeE/GZgH65/EXj4bB9G+nZ79XfMG1+w0EvgTAImYGfzPk7xyVobyFFdWUfgGd/tn979w5mHGUWsqE10qbBYoEPfQrgzAiOyk6EVAVLkgXYbilOYj0oU5O9odQpPviAQ3bsWSG851l/UX3zvvGnN9dpm4uboiuksNzY6eE+olDGRiOOEWzAgVxQ/Anpb9zr60PS5fU9DdrI1QUQToOpV1E7yUcMJ8tmRk5LPMZtXNYeoHwc0UF7X9StMQ6kOWCU62fAPe0uaG50hZmUd8hzM+nvpMo4GJXOF6kbyZeTchfnDEvwqCO6IiNqzlv6LcedHeUpd+qnbu2Kb0TfkMtBSeiJHJo3Bblo4h1lgkLWSHfs0YMSjtJ769pGOs2uFYUp+mg85N8doI0vb0YibdYU6OoksZfae7lsLj4sqvcLpKmsakPXdgpjl/yDYLkefZ0Q6C9/F8+qN/AFiaPwtw1U8e3p1yY3rJg3/AmNClmMzXk3Vt+VHRaUGxuOLFBpKofDQykH9GbO1Cgk2S03cyQBUEOT1SS03d9sKx4Yw4glfaMQBtXmt8PwAiYJQudMgrZ5o21PoMmOAkA=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UCmHiuuEgaUCgjnGKqKNnef4EK/s6T8MZm5qsL5oylae/wo3dvCdt3mkP3m4PWHXVPJ3KDDIbRxUo+DjYPSHrOMZ/ApJAIwO8C8RoN+stu877NswoQMFKmBfI/hPa3YMBdxpUNtDGYltTNZzWMRan7kKblk+z/x58aRkaidr38eWpzUm+Go4HVh0uETR1O9VA2NIirXw3eixCFpZDLOovZ8CYOQYBx7tYSy0S0+s5f3fveTu3GDdlIDDEtjaQR9Pk+IP4q3owReX0Qo6F+PSXAzom/IOpL+1CHXg/D7j0BRKdkBdRKsJ6ZiXfXByHEyYk2c33w+r1nIxtPgOE5+QdHOQskcZYcsGp716Nwag+7WzbsJbWjO7DDyDvpfeeAPK/HqdgmgxHzlyHPkl2GBdklkcDAOKoZnAzMZ5TXuXW2w1tLLY1SM9UTwn9OXzgZTw
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 10:30:04.5711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e45b5b87-19d8-4727-01ab-08deb4c86ced
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEACE3F2B7
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

On Fri, 15 May 2026 13:47:45 +0530, Abhash Kumar Jha <a-kumar2@ti.com> wrote:
> board: ti: j722s: add processor ACL entry for wkup_r5

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
