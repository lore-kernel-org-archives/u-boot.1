Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44A4CD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 09:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E31A80398;
	Tue, 12 May 2026 11:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MWVWzFPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0628980F0E; Tue, 12 May 2026 11:45:08 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D89E801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 11:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXc9zeXz0E69ziF4Xtl8OvwkzmyK20BGV+AZiGvZ+5Ohy0Jtw92rgtaX3F7yEGldBi17oDiWNfON88KtUQMx7GV9PHvJmBn/IKxzOQ/2squQ7eq1fot/XhxCkvrrLpPSyOwcVuq9t8f4pPdtQr1U9jjb/03CSHx/9LQTFvN1cwq4jDztpGKtca28Q+mfb2+i8zRrT9PSnqs/0Y/oa0MGldOm3FLeudgieB29fbeAEGM+dHgWt0e0YxwkkzG8zi7lyca/YtkzfLPs+n9ZaqEY4zcSh+/aUYo8OTQmAxpAEGwyyAlMoqk9b4gd72CFk3JLQg6/v3l9NnZcH2To9MA/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66RMMeoeXPwf+Zjexv3dpDx7hVb29seKagu6HsWI/QI=;
 b=kBz19zEEsplPg3aUjV84Qplm5ppmCukug3+671j0R4/SNk8ct4FnKcftGBu1X8YrUf1MFwNNU69Mq2ujVbR37lI5pmCMxrHVAEs7IwdMIYasN5rpHDtySfYtcaqtEkyD3hgImg9MvMlhuuMiL7LWOhion2m0u1pQPOeY/UeTS3YcoeuZT+dabXQCpduwxsNiNUGTebSUrXaPH54nBGA7a8pLkznqtUZ/8rMjDUiohrsPmKZ67s9PYLsaRRdfgnd8fXhGXYYxrXyRtClN42xwdmu7JMI+jGF+Tt2IgV1e2Kq2E9HwuJkRdxiDUWVVejkVi+n5DjN9/ndBfTKcKZlwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66RMMeoeXPwf+Zjexv3dpDx7hVb29seKagu6HsWI/QI=;
 b=MWVWzFPdN4Nr06kd8jlnY5ttJCOiQ++lx7NZbLrzA7hdenRg5T/3gSHOtXDtYssmgWl/Cr8ebSECiO07nYH40O8sWfY4/NX3BPFLWf3MhvxqUGF74J/4kkqqxbCrBMNcP88Th29JbrpdDd/vYvuLXptMAh3BVp49mN2AmEhtZxQ=
Received: from SJ0PR05CA0150.namprd05.prod.outlook.com (2603:10b6:a03:33d::35)
 by BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 09:45:00 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::65) by SJ0PR05CA0150.outlook.office365.com
 (2603:10b6:a03:33d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.15 via Frontend Transport; Tue, 12
 May 2026 09:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 09:44:59 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 04:44:55 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 04:44:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 04:44:55 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64C9iqW21529333;
 Tue, 12 May 2026 04:44:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] arm: dts: k3-am69-aquila: add combined boot firmware image
From: Neha Malcom Francis <n-francis@ti.com>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
CC: <u-boot@lists.denx.de>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Tom Rini <trini@konsulko.com>, Franz Schnyder <franz.schnyder@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>
In-Reply-To: <20260505-am69-combined-binary-v1-1-5b5dc65bcb19@toradex.com>
References: <20260505-am69-combined-binary-v1-1-5b5dc65bcb19@toradex.com>
Date: Tue, 12 May 2026 15:14:49 +0530
Message-ID: <177857908918.1655329.7242382998405759036.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778579093; l=254;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=8kOO+/NPeqLXC3S4VgFcH8Z7XGFiqJqsiGnH4AkbF5U=;
 b=QW3qN0QA+BDL/K9vY3lK6hjFX9RdpuTFaOHXYoahuZXXIB1ONmPCG4ebc0hYPpiQ6QTneqqbo
 Co5RURuF2mgC+xmVvDTXcpU7Csht7jJC/FlTrSExcdtaI8OpFLa7GhB
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|BY5PR10MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c6ff57-5742-40ff-7357-08deb00b2215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KpZ4YUaO8uvJaHnv1dcd1lUJE7X7FdRcNlcUNe9hhsbr3Mx/TzBMw/7ZKmtiR3PTqe05gY56mf6JIGAF2Jar4DrzBbKrr185DzCY/YQ5KLbLJr7XbsBSdQAp19Q/i49iDPp0x8gf29Eol75Xdubf6XqzoJ0BZyKQGuZLusPtcOCBeLC0dolM+SHewM+edvi257K5w1ua+SO0JJG2AmFdWJT4GzZmcz4f147YLTt+y8i+FgVsVt1F0O4OKhDVClwsKQnDYRIxflgVV2EXnUzVNbifz9/qcCECcJTkY1nubKV0wc8lhiTIhARIKtoH594aEew7yOXRa1RMs7nDMqWsB8F577P6dSDrcO52yntM9F36ZSVyuLRmGZZaksYVhK35RDfMug+MFCcYj5xpessOJv5nwUZb09rgogw7yozf3gc9OLRnTU5DCbUShZ3VYvkk2viZW7+PBC8y66FgRh22LX3wqb2yTMKM4NeW/kzDf4WrTJNyPckmoylzA7Du/T3qiU/OlFgiyO5tP3kJbEk2BqR2ORoDZN39GAmS+AbDW/KBcRN0bm71XfX0hd0nZz2Lh5mVhx/G9ibhHt3NnYfmGCWx0e2+qUuls50eo7XP16zFkqNxqOJj7Rfx9MGj5Qc2nV29uKU46kkINLuhPO65TRsY8Zw/+JN499B1pHHFll9hz+DPKX1aOPRDmYo8wSPg2rziZ+TkP0Xv1gQtrEgSPnxrbObll5GA2bmEFSG5M9g=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x7S8C3QL+3O1wHB21SW/9DDURtJvblvzr2aqExXtvayml5BHpdpO1Qq/rNfE+Pkvma5QZoItonFDjUiPb0UpYm+IScu2dkDwLnCS5DjWx0inKRMC65vSD8XzXAJnY1sG2KMBH5DRpKeDZupP20SAsC049aEBdVkbT7dn5bAm2gJOu2Pds0hUG0rU/l1KiBM8ZuLcTvJ9yI8Izbf1/CNtZOXGVh2S5fHSir7oofEG4Px8OgKy06eXelEm7YpyuTpDoroacXpcZJN+huiXAGnE2bU2Ydhjnh6DuA0PB333G8q5fE2lVV7TMk1QYq/PDLIvpuYwddkf1MkN/b5iYG7J0eejV0tV/lX+3XHoAs8Ohvm1UGuKZDjICNW8ocXPDrwgzc8fVnvNpHL186NFg9dtI5Ju5RXOJS29VtJuJHLOs9aqhBNuV2b/4s/UTY9j7rtL
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 09:44:59.4865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c6ff57-5742-40ff-7357-08deb00b2215
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4290
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

On Tue, 05 May 2026 18:36:24 +0200, Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:
> arm: dts: k3-am69-aquila: add combined boot firmware image

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
