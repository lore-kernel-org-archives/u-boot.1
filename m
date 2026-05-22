Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604EACD5BAF
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 06:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFEEA841D7;
	Fri, 22 May 2026 08:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="raCGPWkz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5309084673; Fri, 22 May 2026 08:58:37 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0DEA83E81
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 08:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjTySx52uaAeS6ifpFkZro5la8WmVwjsyyQNEQZbV/oK+zuv+YqmUQ3zNVnHbIFbhfb7MUG7Lo3aKvSXWfwtaEvn3hxNO5qNs8FMrxvOoDCsxPbejv5dSRVYAhjBSqd7EbNtQO4Myq1W3oG+zDlESDQPN6OGo2cfsK6rCkrebNVtWtiPkw3AeYVYlRwEwjZ0+IzZvvz+JTHrz0xx5cCjokoBrckM9+lrWqirHbGMKwMe2L7DTOlYuCp7bIcCciWumHTbri8YvpBSJwzRrM2sxMSAaM9XyrruJd3V7sJmlkGtb4pHM84bAv/2kzz15upUKQL3tZvWTF5L1S2qq4r9wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiCzdJyETNzM3XYM6tXki9o2WZw/8AtDXSWQCm4gerk=;
 b=nA8/XdDxLqYkM8n63bf0ykiq/35Mysp7JAAGUCbw+cYAdDae7/nKMYp+qtURjRt3accXHPm7NjeFW59hFxz3EgfZ1uHSnyIT24btQH/lze3WsgDwnFmvdrqdZCmDcPaKIhJdU25giJMSy1KL65otuLbolDOUmcxcvKCKXCwhSev6q2n8u1cxPuurgqXivQBhAeo5JuvNz9zWPqsUttlUbIYp9Cs8KPyRq4ywhsfsb5yhf09muYMDJcCvih6bjKMtApaZ+aJ6DLQXGPGjfghVlJHC6pr6zSnsSOxLNaAro1TNkfo9A1sVx67CvzRC/YI/4j0iFXeyN2wFpYCSVm/Sfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiCzdJyETNzM3XYM6tXki9o2WZw/8AtDXSWQCm4gerk=;
 b=raCGPWkz7K3xDcufnR9HFuEibrztH46TPLxemCpUG4+7tgmAyygQ39z5+V1zU+S/NeMmDMBNoRqS+xv4HXpS7kSyV5IHh95nRqISIL2MTOtLcSE8nZNbpfut057l4rcXoyXbq2OZpjQOA90lwtZG9aSxydZzZzoYdBqF23I4IuE=
Received: from MN2PR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:23a::31)
 by CH0PR10MB4937.namprd10.prod.outlook.com (2603:10b6:610:c5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 06:58:31 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::38) by MN2PR03CA0026.outlook.office365.com
 (2603:10b6:208:23a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 06:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 06:58:31 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 01:58:27 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 01:58:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 22 May 2026 01:58:26 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64M6wLTU965009;
 Fri, 22 May 2026 01:58:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/7] Add UFS clock support for Qualcomm SoCs
From: Neha Malcom Francis <n-francis@ti.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
CC: <u-boot@lists.denx.de>, Sumit Garg <sumit.garg@kernel.org>,
 <u-boot-qcom@groups.io>, Lukasz Majewski <lukma@denx.de>, Tom Rini
 <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, David Wronek
 <david.wronek@mainlining.org>, Jens Reidel <adrian@mainlining.org>, "Luca
 Weiss" <luca.weiss@fairphone.com>, Swathi Tamilselvan
 <swathi.tamilselvan@oss.qualcomm.com>, Aswin Murugan
 <aswin.murugan@oss.qualcomm.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Julien Stephan
 <jstephan@baylibre.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Sumit Garg" <sumit.garg@oss.qualcomm.com>
In-Reply-To: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
References: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
Date: Fri, 22 May 2026 12:28:19 +0530
Message-ID: <177943309950.662973.10649748386217024227.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779433101; l=717;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=oJeO4l+Y4QBuEU7nkPuiYCLyyfjwVCGQymoqume6y9E=;
 b=lP+6qqV2cUeFnji1l+2+SNE5oKFm5smTQDihHjFYjXgWmuMKbxmZHYica//+TtU3BJE0c39fC
 rIYRdg7QyoZCech8/O/nRUABV34TIxjiliZzHP2lSV8G+O5QaL92TZo
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|CH0PR10MB4937:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3acae7-0e27-47cf-9d9d-08deb7cf8902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|22082099003|56012099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 57/KDAVZ4mt4q+0tqz2ENJ3KnM+yIFX5nU9wK7IB81sLvks42uuAvYZAxU/4+/wviYgRdaehVlKGNkJU6YDYTwLF/FO2tJBI96rjZmuNlkyPKmXAJ1+QjPSx7LVR9lSKRKVfysskP25JLdjcsvn/smckgzjEoFN4WWBnLzxODsIe0tvsjRynmvj5s4tCsWf9qeBwOBWK2qyc9GhdOh6sWQtyVN5+A9CTZjBoeREZr+Z0C5dSksZNofl6Hj+XvZeAt0KMreqXqsu5pUfBGZ9D8BKaj9DxrRZGYl2oWCSj6DB0ydhwNUbVadJlh50z75HbbinIUAAMoCIy0IktbIt07qK2tH6H5n45HvMOn5Wh0IeRcOzaNKcVKznNhOLKSj4vkCszxxaVqIeeMUIbYDE35oQTRrm33cmIc/hAIBAmfimNMn0pRB2EKw7WwZ/xWl2ExZcAscrtaVDU4HE6Cno7VDc0rc+Mq2E4aw25bDqC9k53iPDrbksi01mLdmQ+YS5LzDcQrsgwNfcg2WAtGvdouGULWaOnuYkqVswZ7492qZ2IBJ90kT7f8dTTxOP1h46glh5b/LAPEUPrK/W70qanoBSOXqABbzhbJt7GJkucDg4aQuLGfLeHHCg9bzxNLAWE3fq5+f0w9Jt8xhFenDlpg2YIaW306cawgxxA+lk16XcAwQOrqJZFhkOpyYr1mNjfD1l6ANxdyGlqnjfStJxUjOxlG5TSJB4m4g2gJt3dzFI=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(22082099003)(56012099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JFcweHsLsEoY2ZDqwlQT9wryZsPCfqOOsDrTZMx9WHlL8jxIFcb0oU+x6cNbP3iJhxt1LMefV4noAskH14hzs5P5zVCGr87Mx5/jxBySFfA7GwdP7ZswKeasCitmaLXpeE6yFt7c5neV68Tjv6LV+A5GjbTSSACVQeyFKwPxJyfwwNWGs1GaXRURizjUhkJ1eH6DnUILTqj6oTLHsfYDBevKpX8hh2d7shaIJzr65TNjWQyRKjm0GVK7TOoybFFvj6ZkNVSdWlNsVnOixT/kZuWUfM/e+dxgyH17S+gjBGQSAAsT1gf4SJKbcDHipb3fKPFV8aMC8dez34y+LK0/YiH4FdoGAWmvs+XWqdZSbXPxrnWZV4IMrb0dh8lhlv43ub3O2eDPgYwOAOnqRQx1Y7Z3VFkpbEQRyJtKrqIrA6uVTfWkA/sABYTvSQmQEUtw
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 06:58:31.6727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3acae7-0e27-47cf-9d9d-08deb7cf8902
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4937
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

On Mon, 27 Apr 2026 14:56:04 +0530, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:
> Add UFS clock support for Qualcomm SoCs
> 
> This series adds UFS clock support for QCS615, SA8775P SoCs and
> enables U-Boot to initialize UFS clocks independently.
> 
> Previously, U-Boot depended on earlier bootloader stages to
> initialize UFS clocks. When these bootloaders failed to do so,
> UFS registers became inaccessible, preventing UFS initialization.
> This series removes that dependency by adding clock infrastructure
> and enabling U-Boot to configure UFS clocks directly.
> 
> [...]

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
