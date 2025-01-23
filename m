Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A644C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE6BD80243;
	Thu, 23 Jan 2025 15:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CXXK5UjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 794DA807E5; Thu, 23 Jan 2025 15:44:20 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::70b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E555E80815
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWcaMMOEKmFhwXoXf5gdXSpAtDVyPG/hNeO2U9e1i8y+o01LEeEgQpauyR3ms15MuiawZr7Wqy57wjYYsA4bNlX0rXOPTPHDjESJVBmEqP3fks5ZaqzAaIDjrO8epWIYmAR9QiKllHJyKrQGFaY+4DVt7ITpvVkMEIxPEP/E/HA++mJNBuM4xTC+PSRmFfGjGlsWz4huhXh3bSYNVZKlIP5Z0+VKvPy3lknudqhye+Zm2PAdONIM1WJ+B6cxdJkUBoYqCUn6dXM9rBJt+hwgsb3lT+bPWG7axbvXk1X9GU0HmhSQu5JBA+cfpNOMQb2CflSp+JS+XkdJXnjQ4r+Bow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UugPOVEhxZgwuSqVRnoMoqe9jnddaLGdEtIdk0utdBM=;
 b=VudGPZssJhWzsbIu3sh+he8lX+bLqWW67k22LckhNZi/kvJxgORfA/fH8naELy353F9G4fTh0W32OHY1RujT4Mf1ckTF7TGm4ZqLBRAiQWA81leNTnW4stTGVNV0ZZgfA00x0cLMt1RnMNUywOBU4CNV6hxu3JJXxVl14qeDUgJjXaABoFmPo7zIxW2AXzkpMQlQazzOg9/GLRJNRRYZAVqO0LQeIxk6/6FK93doAYQs5U1MvqFZbsh8rFKH/WpH+4KeTmosT6HtRSu3fBnuOeTsI0Q3TVEdypRs7wDvgntPEGbUkjyoYFTnkZHOn0Mtini/K7oFTB95c4/JPrt+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UugPOVEhxZgwuSqVRnoMoqe9jnddaLGdEtIdk0utdBM=;
 b=CXXK5UjZnK/LzR+Wx/pkiyWNLAtMoLMgG6GHlGQ6jTEcJOHNQCVl/SMBUjNG+tmgin64AwGlIJbVTFKKW+e2MhRM8cJGslSWzi8+CqmjckpQWT/pUvOWckQbhcOn8tGLa7VCrlJy63yf3L3lcoUDDQuLv2ay5MU8gTgXU1tearU+Cy9bPUAuGqwuGwvgYB55m0pzxW1RPF3NbVV4bSWKAxI9LrhNQuH0qDp1K+Ie82vifg0W9WB8wa+KGDQo/9CZAYPFXPfpE/fndtw75+JL2ByHE0JDC6T7NPf9GmibTIVUwbzF8i37xZVLCvCv7i2gxtJrJpcQFDOwfcKaK2seRg==
Received: from DB8PR03CA0008.eurprd03.prod.outlook.com (2603:10a6:10:be::21)
 by PR3P195MB0864.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 14:44:08 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:be:cafe::a8) by DB8PR03CA0008.outlook.office365.com
 (2603:10a6:10:be::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Thu,
 23 Jan 2025 14:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 14:44:07 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 23 Jan
 2025 15:44:07 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 23 Jan
 2025 15:44:05 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <d-gole@ti.com>, <upstream@lists.phytec.de>, <y.moog@phytec.de>, "Daniel
 Schultz" <d.schultz@phytec.de>
Subject: [PATCH v3 2/2] board: phytec: common: k3: Expose product infos to
 Linux
Date: Thu, 23 Jan 2025 06:43:50 -0800
Message-ID: <20250123144350.846527-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250123144350.846527-1-d.schultz@phytec.de>
References: <20250123144350.846527-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E8:EE_|PR3P195MB0864:EE_
X-MS-Office365-Filtering-Correlation-Id: e127c940-d500-40d9-20d4-08dd3bbc6442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YUsin+OJumfdAcXplSWVU4WAGM0mWHvTUC+TP84av52iIkbwRcV+e+JYS2nL?=
 =?us-ascii?Q?HM+RhVSMYkgv4SEAjFfI05CZpM/cwLguVf+jvI+usA7T5U/0Sbzru+flihlP?=
 =?us-ascii?Q?nwCm4RahZZrIS2hKEPiY2yiLf6BVfvniYDDt5qDOZ7HJd9USmQkN8gW5VE9m?=
 =?us-ascii?Q?D+4Xs/eUQxsykRL3KQNRahQeKAPsSkNUCHTPhFnJwnm480CMrxqM4LDdC5fJ?=
 =?us-ascii?Q?hM/2F9rXvuyza3jmf7kzvon1j0IiQZAl7viyqCbkFUSg/cC+V9ah9qGFMxQp?=
 =?us-ascii?Q?2mRjUkp1+znoMHPUu8tWEaQv5Pi7zdFFYRs8D0BvA05xdg8xwmom2UoBMxpi?=
 =?us-ascii?Q?8PN+3NsEdzZV9yircXgc+y9guRrAyhJoaaM/ks9ZX555hTt8T6KWPhv+0pgv?=
 =?us-ascii?Q?qo2p6MK1rMSNtkc6IAjTGm9BqSDlphE/LadUGxud5Ub4q/6GYQDKALXCRYMk?=
 =?us-ascii?Q?HIfouUWpc7mYZF5N9kquHZDyseMEaw6LpNX4yU9Wj0TcB8Hkv7Iqx5k+rAv2?=
 =?us-ascii?Q?lbcv1F7Sn515yQYL1jLTw472YZlp8BdmlVAAtTyK95DIa2hxH+bQAilBW0R3?=
 =?us-ascii?Q?Lcmle9cD74pUQmZhorbitntHDWNrbo8XRcZ6jBvRcABno5x7bna3A7Sa//25?=
 =?us-ascii?Q?iB5ovMeoJVwUP2nmf4jTQqVgF0NVOPqgdV+YSdD6tluRp3uKsa0p+nm1s+jM?=
 =?us-ascii?Q?fjoWdAIEvDoyV5WVoBTzC69SR4c4+BfWeZDszaZvbzmIDG5CEraCREjLBYzG?=
 =?us-ascii?Q?SiG8RSqXQtIQO/hqSBGZ3mRYNubV2TjReyGrgIQH4h8Ev99nVK6eM1PRo20q?=
 =?us-ascii?Q?4+wpgWjqKDqWkY3L7E4xyW/rBCXKMYwp0+TZSMIShazMrbPEYQk41tglK1cJ?=
 =?us-ascii?Q?/zR8esAKxXe5mQyOiqsUYfPEo2MF6/lDaBKT7UdQq8Yb/EVsg+d/6LfzXPYc?=
 =?us-ascii?Q?0wzXgu2F9+52MlkRdDsYXVmhy3fP3Q0kc6s2gkzJTh1ZoOmFKRSwbCnKRh4/?=
 =?us-ascii?Q?0EE23QEf1mZuzeUpf8u+sBu6NrMSm8BuXlIWyef81BPW9RLss/Hftl7d3g3O?=
 =?us-ascii?Q?Bu0i/WvpQfk73Es2C+vTcqKzHU1bZ1hkfLZYqo16lZ+Z22sWuirJQrvyug6k?=
 =?us-ascii?Q?vrtzCNCenuTQZaqokWg5rmoS2lcS9lepCdLKGsO7ItStoOsK9/cYEDyl7bc7?=
 =?us-ascii?Q?rKwbrCNVxHujhc8HkXGMkOTafIYCjAUQC5cGifi6s7CMc8HtotLi05/tLx7a?=
 =?us-ascii?Q?5wSh5knUKVu+SGwTjq1MbSez5UJI/HL9wINoJ1oYY/mDe/cM+puKpgl/U2o9?=
 =?us-ascii?Q?KClOMsfIJRLLZYrV46xssQHDembSipM4nHRhERKE66/dKbsKCiLXK7nTfBN4?=
 =?us-ascii?Q?BV3Ot3wuB/qhVw6120Igc0r63ydo8vUq2DVd9q8FjEMNX7mK9yMCyrUOkYfr?=
 =?us-ascii?Q?hj2w8Am4uTr0uSJkq7EbHtU1mVNVy3i6HcN8wfOEZOgwdcx5ntKuazLksGaC?=
 =?us-ascii?Q?PcJBW6U2fntlls0=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 14:44:07.7643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e127c940-d500-40d9-20d4-08dd3bbc6442
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0864
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

Call 'phytec_ft_board_fixup' in the common K3 board code
to expose the product name and part number to Linux.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---

Changes in v2:
 * Removed 'return 0' right before leaving with the same return code anyways.
 * Added Wadim's Reviewed-by.

No changes in v3

 board/phytec/common/k3/board.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index 9ff861cd3f4..3f70dcddf45 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -252,9 +252,21 @@ fixup_error:
 
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
+	struct phytec_eeprom_data data;
+	int ret;
+
 	fdt_apply_som_overlays(blob);
 	fdt_copy_fixed_partitions(blob);
 
+	ret = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
+	if (ret || !data.valid)
+		return 0;
+
+	ret = phytec_ft_board_fixup(&data, blob);
+	if (ret)
+		pr_err("%s: Failed to add PHYTEC information to fdt.\n",
+		       __func__);
+
 	return 0;
 }
 #endif
-- 
2.25.1

