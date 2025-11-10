Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C3DCCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 13:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3705D83A24;
	Mon, 10 Nov 2025 14:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="tRDjJ0gc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D70C083A3B; Mon, 10 Nov 2025 14:52:49 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4952839D6
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 14:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tp9cmM6vJ6KKX4BydoHYVAHvExNDMz7KLLZzfd1UDl9MSEITV5jTVY/4sKMGbpi9C/Se2ckgbrZwqkIrLdbKF4e/CMbHbUduG3wYk0JzEK3iMm6QkYGGidjIZ0htIMvM9H2XDjQKr220l6nhYWRYJiCA3iNvgDkURywBYz5Vl65Udk5vGN7WG1JmW4n/sq8ZzBOcf2k7BQf7/0e3W2XsOyQDe0P8JV4+DsfhDttTaD6VjPpjcb3pyCu+a8NLuvl0Nj5gEHvdtF1KQoLKzz/Xl1/og1pSm+/eOR4HABnFBjSP+v2Q37QSaeSHE8nJdZaFC9REw61wr/2gaIhXhls4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1As9e1sKIOMUA5+sypPXXfO2yKdejh2JKXu7qcIK2c=;
 b=LxZnacmq/DUwlxlHzPt5IwEPpDRcBL8dZ+Bsx3M/JjyUXL10qJNl1QdPV4tJtp/NwrxLTUaTu/5k2oOS0B2sP4xIqrCGrJqSI95EWpaSLX5MyVjFc47XZG0Lt7NKS3rI/4EPcIXEdR5JokntzdXEbltnIydqcQNfsHxe1N4QfiG6g5mQKdruzRhl3wK3lsftTcvMIIbKa1jmUgqfkn318MuygpoBTk1BBGqRmD0JVaD2XylAMr/NloMXEC6DEliyZyywmp/NkxDR94KQaQhwCDFLuA0hs34p/zvUJfn6AvVtAolef/JsQghY9GqjTfKzefd1ELtO7bAN879d743UqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1As9e1sKIOMUA5+sypPXXfO2yKdejh2JKXu7qcIK2c=;
 b=tRDjJ0gcVPKO6s/AlP46YxmmJ1jG6RkIVDcnbBQ9WoQ2JUgAxBYywss4OQizYxAch9cXy5g/Fa7J/c0TAJiGsWkru7O7roAPusdEt7prLgu4XFy7Ezhvkl5STbj5ZFkzo2vgR+MlqS1HN8J4T38FmOzvpLp14/UiidIETFM2Ne1Q2Y1xkQuzzKxgIKgsHRwKvQC3TOzKEAl9o3eQ15QAP7ojFO6vWpN+zdIPxf6YtQJ6+AarWGwQdUA/pSeHanHtO+vzatjMBcGSd5C0LdGDl1pgmeNvKjzIytitENrPzE887tHO5NSfEF7xX4WF/R7fWCd+oO93ypIRn7N7hYTZjA==
Received: from PAZP264CA0127.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f8::18)
 by AM8P195MB0785.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1e2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 13:52:44 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:102:1f8:cafe::39) by PAZP264CA0127.outlook.office365.com
 (2603:10a6:102:1f8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 13:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Mon, 10 Nov 2025 13:52:44 +0000
Received: from ls-radium.phytec (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 10 Nov
 2025 14:52:42 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, <primoz.fiser@norik.com>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 1/2] board: phytec: phytec_som_detection: Add missing
 assignment
Date: Mon, 10 Nov 2025 05:52:27 -0800
Message-ID: <20251110135228.1357377-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9C:EE_|AM8P195MB0785:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa2c116-b322-4478-b756-08de20606c6a
X-LD-Processed: e609157c-80e2-446d-9be3-9c99c2399d29,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hrs4RkfB+xJyOOur2nJex5rlNZTrMsSUTc2LF0kSy1qNTuZZ5NXxMjoHJTL9?=
 =?us-ascii?Q?OXUdcW+ckRal3k7ePiXx9P/gFlLsJWyNk9wIQxk+5x9/txzHSz4IK6mRBtnT?=
 =?us-ascii?Q?he9ifjzqW1w5Imn+aet1tQbsRf8HjNL6AcjhxtwdDHb9aDd42LrpYEFMUY8L?=
 =?us-ascii?Q?1eNML/4jImciHjG/UzcofkRpCBgnU+FTKVSLKD1ZZ2fTR84qzQU8cV6DTcS5?=
 =?us-ascii?Q?y6EgfYwfCSURSBh6rd1ZE+H0GCVWbFKIyBF/13c82zw2VU4dqPHMRLdBIdvI?=
 =?us-ascii?Q?Ok/5mT1X+ejEI/Dqy3XvWfe1qHsjkfF81FzffRE2LDEpD9aWnFLkA41v6sEq?=
 =?us-ascii?Q?/K8h2/xnlCI0XLrkDzafkVJA6Dthv4j6etUh8NGSm5oM2TsXUM9y56K28H5j?=
 =?us-ascii?Q?AzdrjDAI/LDBrJNztwKw+Tm3BtKE4kipT4rVHevG3HTFly6fOW95opH2FsN+?=
 =?us-ascii?Q?ad/+fhdSJiOeGZb+giCrNAmd7r/REKuM5vRSQ4/mkjqiXuV+22WXm0MfmbeY?=
 =?us-ascii?Q?F1X4OUyuR4hZyp8ZrE5SH/YdXvQ5tFhMr607ZGFcBMlvC9k7xjRAskajjM8q?=
 =?us-ascii?Q?LafOSKrOM992n6fYf7XQQo5pvdte7usQe7WQacgSdJ/Znagye721sPpWYSmT?=
 =?us-ascii?Q?4bnZfWoF3ES/At/f2a2JlRE/8Apv9xD9fnt3gewYBs7y5WGTz2YbPayA8yMD?=
 =?us-ascii?Q?iD9DXv11QrugzLqiw8tvXk/lHlR5ygAPV9Bk5MRbRGojRK592ATL7kkv/JuX?=
 =?us-ascii?Q?v58AHspNvmHDofLi/2rD8NfojK8yfDnePlgeqKpVCJXXTJ8tyOPRsB/d4vEZ?=
 =?us-ascii?Q?AazoHMa+yj0W/ubW/gPbIkV6LFxFiVmkGYnIyOBWidPom8UXK5CFyAq3PcaT?=
 =?us-ascii?Q?o/gA9WXP2bGZGTHo4Wfm+FRhn8VViTXCmz4iNsdzF9MF9zXiAgTMhTiM8TGN?=
 =?us-ascii?Q?TWuUOxfUdCNbhCNKvhDnoEvO5e1AHExklYZMDDsia14u3+kAYqS5KKbFEbux?=
 =?us-ascii?Q?0Q1Dt5FPaQrf6595kWLDzglVIvquNzDiuFvgN3neQMdycOLLa1leKvZ877tc?=
 =?us-ascii?Q?bTSjSFiSMLO37NcU3XxS/9g5f8feXB+KHZVHIQuE3yktco1rysIVFmX0dnOY?=
 =?us-ascii?Q?L4GTjhLvg/hxQUrU1sT4kkwsaQqGpBkWYRJbVsLgs7uteGoPcl6Xy4urXd5U?=
 =?us-ascii?Q?pRAORjDcNLOfirdgTkG7gpH7cz66UF0rOl27VnD2yKQyZ/HDokJUO0yHGdDA?=
 =?us-ascii?Q?HDgQOfzFXLvaAiX+OiHgnpN+2pv2ETNIWJfdfM2CJ3BAR4kq4wJFi5d03drV?=
 =?us-ascii?Q?kGMOpeaximIW+owblq83mYPP3HsPZeAN14zFt0qkEfK6M5Xy5IyX//z5OORp?=
 =?us-ascii?Q?snBIDyCOJow7HrWOMvvuSNDK7pZtKYXecsllPWl3C3tBXdb0BwNsoUVBbUXC?=
 =?us-ascii?Q?whyS3BW+f01Sknps2H6ltj6AY9OmS7GG/UfaIx5mSZvwmvU7p7jB7AuJZGlb?=
 =?us-ascii?Q?Vn3W7Uw+g2v1B1WKrNShecJfGF4iXdFkGaHtSj3LuK0EoImFetEw0bD97C9i?=
 =?us-ascii?Q?c409zm50+XwvasPKOJg=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 13:52:44.0629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa2c116-b322-4478-b756-08de20606c6a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB0785
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

Assign the return value of snprintf (total length) to a variable to
properly check if the string has the correct length.

Currently, this variable is always zero and the length check after
snprintf will always fail.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/phytec_som_detection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index 136f4486eb0..ff1711c24b4 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -346,8 +346,8 @@ static int phytec_get_part_number(struct phytec_eeprom_data *data,
 		return 0;
 	}
 	if (api2->som_type <= 3) {
-		snprintf(part, PHYTEC_PART_NUMBER_MAX_LEN + 1, "%s.%s",
-			 product_name, api2->bom_rev);
+		len = snprintf(part, PHYTEC_PART_NUMBER_MAX_LEN + 1, "%s.%s",
+			       product_name, api2->bom_rev);
 		if (len != PHYTEC_PART_NUMBER_KSP_LEN)
 			return -EINVAL;
 		return 0;
-- 
2.25.1

