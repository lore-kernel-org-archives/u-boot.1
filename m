Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC642CD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 05:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 930BF83A91;
	Tue, 12 May 2026 07:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jgJMJ9Px";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81082803C6; Tue, 12 May 2026 07:53:51 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E56083EEF
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 07:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGkjUIDFovp7p/2VEzu0Qo5RuFGGt6EpjzYUjSsXxifnRSeGEa9ZN46QXqZIQzL6LFc3MyM/7hj8EqBYoSPbKW1POJVy5TNq2hSwj624AjnHpF1L01R5632tiwkv3uxhhfpguzT21t7G/W7Gbk3snAifI9oY0GLzaiScPaaFn/8U2HUmIQCDl9racWtcI9607Wsk+hKNuE9121lyEcMCC6XKKKZTQCB2Aa/bKonOQ3/dEvaaCvn6oHHqooZdutaBvp7NlalfTjuyicyaN1ASeczSRlroBhBhuim+oGHT3Mi08pAfzUPGTHcEDNU3V4DW0YCar2VgoMF/uBshD+2Rjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMwJqL2AXpL0wMhraPZgY1lcFjedgWy4yoZGoV932oU=;
 b=txqLff6S7yolq+B6JuBIBt1srXwTxIoZgKfQNLh963uMQLFxoLTM+xyKcW+Y6nm91DBRQl83W3SKezed57KU99biyph/hLovVbkhf3aeCuHpnVHU2huIinNoMdU2yw9Blk9dkW5ibsky5M98w9pIOZEj5GQ6UjfgvT51GA3ZcgH/+ojCBjLviOO0sFjZbGJYNe1fqbYUOAQ/uNoZt8HZ6KEVsUXW+lS3EkrBsHXpXY+fy0VTEwrJexwQ3gr8NI+eT1SPcNyjC4wOEhZzmuY4YV0EGChl3hQQ3/n2FEUf5gNik/DaZsaQDr2IJI/lbVlKTHsV4RsbNM92yxSxwh/9Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMwJqL2AXpL0wMhraPZgY1lcFjedgWy4yoZGoV932oU=;
 b=jgJMJ9PxngHgPIWavalMTt3IxhGGqya25oSqOmRlHQeI/V/zOlDvf+Xr06TgVEnsps0Vm/pVuJrE4cZrBSqbqnjWAWBJzMoJ23xXV5SWuSd9uy2H4G/edluV69kXR5MDW5Fxx5+riIDFLZbCHUQJTMTfHE1cM5uW0XNiR2vNVk4=
Received: from BN0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:408:e7::25)
 by CY8PR10MB6780.namprd10.prod.outlook.com (2603:10b6:930:9b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 05:53:46 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::27) by BN0PR03CA0050.outlook.office365.com
 (2603:10b6:408:e7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 05:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 05:53:44 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 00:53:42 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 00:53:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 00:53:41 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64C5reAY1157881;
 Tue, 12 May 2026 00:53:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/4] common: Make TI K3 get_reset_reason() a weak
 global
From: Anshul Dalal <anshuld@ti.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
CC: <u-boot@lists.denx.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, Ye Li
 <ye.li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Bryan Brattlof <bb@ti.com>, Anshul Dalal
 <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>, Devarsh Thakkar
 <devarsht@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Moteen Shah
 <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ji Luo <ji.luo@nxp.com>,
 Richard Weinberger <richard@nod.at>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20260511201235.1066697-4-alexander.sverdlin@siemens.com>
References: <20260511201235.1066697-1-alexander.sverdlin@siemens.com>
 <20260511201235.1066697-4-alexander.sverdlin@siemens.com>
Date: Tue, 12 May 2026 11:23:29 +0530
Message-ID: <177856520968.106112.14841185343946056117.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778565214; l=444;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=YisZupI2IyUm2VUPxuY/aw7BzezwfW/qOmS0IvcUD3E=;
 b=Ray2gJM7gcni/xxwjPSQyDP273leG1aov1aRsxnd7y1yEHGfsGijMtKVbqASpD5V9hlv6itw9
 V0Oer9WFrvoAbz3GFQez0K19JyosVP8DKDNbnbgFMxKFj3t/QD8rM5H
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|CY8PR10MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 9adf2cd7-f608-4213-4fc8-08deafead3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3DgjB/8iAgqf/2+qawBAkaPKvcsBWN29H0xdbbMcV7UddO+WX646rD6QJ1BOQjyUIw8BnWfZ2S4URJbM0WOdGyqlFmzKOtRYcV7+9sZgursFXqVRiM+PPj1eRMfNvtK9r6ZnivEKiUuVXS/uw2DB3GjHXzC7oR24x4vcOThr8Uqo5VjEsGhm1EPJwN6hT8yaQy5MOHt/X00zYLl4ImheDMrdDFvw17amgAkF8ALnMvfBcVLS/PxOAVfb5SJwwi0xJbSivpDV8bqmRdYOZSpWK3mMjb9cODTqtpl4TieBKWJjVjQ659HaODPhyn7V/DsfsF6ffB5XrpMRP39yfLE6U+M7AKcVC5zsStBg/PHoUd4fdSzT0H+OsCv/PoIck4QW7sfy8ErMbvHG+4sPfahpnFZF19VzDnHkdX9h+T+Y2yZGsTW02oIZr74VzZ2+W2CYjQP/8+w3yzqwmCASs0E/cpu2DKMIkuKDwFjAKlONq59QEJKOnvg5sNK8uj1RAjEHGigMO/bH7H/Ed6T4bdbu0Yt23B3e/ikfajjtgCvWUk/pSqxnUPnrSdG9xjciYnH2vJushzEUHomQ8d2d/yb3Lwf2+07NMsBToez/TBrb0Cx1NyRITXi+qYCnh5CbN1ZKDYp8tsSYRXc/96OYBhzyu/FZYyZcOS7XtGsjK/Y/wgl1WHnyG6vYak077f7VRzGGlMmwzZrSAneW05oFnCkD+t5HX42ek039N6Si8KC+qL4=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 01SWt8pm0jXBn8H4UaORU23sGdOmfCNh1zgTaa44M5rnBz6I/5+0zsXmeVCQSFtU32Nld5YkZ9o9jrp3zqAyv+gmWeLo6Iq63yzCCXu9jeZeMJFyX4hWa5Fmd6K39Zq74yQIJEwRhcP+FCEiTaNE6EDpTXjF6axBnt5j4eoVuJyjkGDxJw+Z6AbdRZpZusGNAX6Sxj02Hp+bJR+bSSkzo4FaEyCtAejqXvhv01zfjlraH4mGYDTwF2IcinR/P/6y7op1AOBxiyuKqLCSsa9/+v/FeOfmIyKjlUHUS+M6oFebahGZyUuVAe4E9PYtaKjgWcwGOQoUlx5/jNvTkgzewmU4RJsFtDFpaaLJX/O3mC+vEC/YTCKwfGD6oTmlr6S0OzASLHQqXL8q0wEFRLddqpHu2Fk09vzB9/ZThxS2tKEPaogH4Ygwb7toOo9OEgRx
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 05:53:44.3369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adf2cd7-f608-4213-4fc8-08deafead3d7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6780
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

On Mon, 11 May 2026 22:12:32 +0200, A. Sverdlin <alexander.sverdlin@siemens.com> wrote:
> diff --git a/arch/arm/mach-k3/am62x/boot.c b/arch/arm/mach-k3/am62x/boot.c
> index bae53f1e459..8c46532113a 100644
> --- a/arch/arm/mach-k3/am62x/boot.c
> +++ b/arch/arm/mach-k3/am62x/boot.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
> +#include <init.h>

Are these includes necessary here?

-- 
Anshul Dalal <anshuld@ti.com>
