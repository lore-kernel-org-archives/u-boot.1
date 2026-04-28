Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE43FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 12:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08362845D8;
	Tue, 28 Apr 2026 14:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="LZXc4fOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD52F8466B; Tue, 28 Apr 2026 10:51:34 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41EF48465A
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ew4IcSexA9kWVCfVW+BBYE5USvc6CSac8fbRk63gBgmGXYAeyiJLRn03WhbsOpNsVzxWRlHZXUWUz0yLTzt0zLaIUxAyCv2w6ydH0YwQb+Ka6edE/N5rFReiZrXasRceNAjUbUSTJZOitwjL3Ep8V8otl21Pp4wQRJ4r17T786SaJLdYXr6Z1NRVHyjdfpxQXZqCwUOztTg1Nk4c1oJcVJEKusYUmlTjRXFA5qszweNLthH8uKA6ceziEXjFTHPt5450mG9acPfh4G5EipnRdRC5Dk5R4HPdS/wLGqichMtfw0KtPpgJi0FBAWMnGDqptbPfXjLjsZfq2X5kOQ/Klw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6og6z/IpRsvs1PzanEh0dY1gJqYdbZL0k1FGPx1oHQ=;
 b=lCSAjFcxOsLQeLhMDm2gFP5K2/5bXx5mqIp9//RV6f8WXTWHDJ8zZruA3C6haR/bViGI14Oclxqh0Y274fmmlwGsVelG6Yr4udKcKwqPdl80SGWwDe8khDC9cENVYKLco2Jsxnxi4LvTb4WbVzZsRde1OrPVu8PMzlk7MFruVYO1y8tM47daj11R1NtMktZ4V4w2LtaVhWPmjUZgNeBXsvSu3hhfyJTgbptsCa2GI0Zmlm7ZPwR+PDHbXI0p9FtlBs1Lf8DTF8v+9YQtgoUS0dx4VbNE4c6khTi7vg6+0TUtQ58LJwIUhsfUefmYRyci3mJcu9hndo5pw24p+7QxwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6og6z/IpRsvs1PzanEh0dY1gJqYdbZL0k1FGPx1oHQ=;
 b=LZXc4fOh+F74RpJ7U/GQKU0XeW7jFMXfkevXMWkq5M+avutgZTG2YvKixht6xrvscnOemiMVSzWbQ+RvZMlDhRl8E92TiDjlC+8j7FxX8wL1VIriblw8oh5WZCN6NKkMynuMA28ri8OB7lfkEYkj5nJ5t+WBPNqZ7K+KZJ5EmNqCmz8Zfllqs8y+vPT5UUnAwQn5J4N40CtnsHDwvmho/G/J8uScaSoeA46n0C3CmGN2laCHYFbSAEUXcdfz96wrXz749NAyfoaf9l2Ygx41J4qskXKhtoSRHHFXcKfyRs4JWcz0XS+alBVh+9UUp0wsf3Iaf45DyLDfv9pm4BZ62Q==
Received: from CH0PR03CA0353.namprd03.prod.outlook.com (2603:10b6:610:11a::15)
 by DSWPR22MB996875.namprd22.prod.outlook.com (2603:10b6:8:3b0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:51:28 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::3) by CH0PR03CA0353.outlook.office365.com
 (2603:10b6:610:11a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Tue,
 28 Apr 2026 08:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay2.compute.ge-healthcare.net;
Received: from mkerelay2.compute.ge-healthcare.net (165.85.157.49) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 08:51:27 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id A82F61290D;
 Tue, 28 Apr 2026 11:51:25 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: festevam@gmail.com, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: brian.ruley@gehealthcare.com,
	u-boot@lists.denx.de
Subject: [PATCH v2 6/7] clk: clk-divider: add clk_register_divider_table()
Date: Tue, 28 Apr 2026 11:51:11 +0300
Message-ID: <20260428085117.402523-6-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
References: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|DSWPR22MB996875:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f04a5331-606b-4ff3-3c52-08dea50355ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6XcWLpWaUt0Is9aO65OFaIhbBzj+kgijwEcuwSlGOFg6E0QNOj24zyEsjib1RC9LPw3FbO7rCR1e9V5s7jXaG+EwA3bUuTBkPP25RZtYifbp1B6aDtohGS0EIxEQYG3zST7YKLNvXGEmrN4KjQ9buHzmJTMOTuUYDnEX4qmEAMFPo/wb4IbZrGUTJs7S1FoVBgVai7cmewn9lvjX+llPIWHT8jFVKmQ1vmfNpt47VXmpXmGSKoEe7Tg7xfUkEKSRJ4Dx+egpml7DNsXI5AYaNRww5XOsdUdvMjoi7QL9Yo8tqKTILdIOJBe2RLuMwzBjM72BF5dR1k8KWQFJQ/5+4D+LH0Q8mKeIUA9z0nAnqDuax3fpv/babDzBZ0a/uknIRGAxbESXo8Yd5dnbtiTSpKNEsfxZ1OI+bunUiGolnGAAlypVjEv7uMZxQhYoVeNI9O+ynCIiibdClc2VycW7XxJcm+6uZP89Of3HK1BCwUOXjIjays+kClyio9XouSJBZKxIWcn0RbM17I45VLCHYzbHMcWFLKLt89q/HsMoeUIRZvWJS6x9TVF/AqpuKLfjZJlHCmHP9pEtprF833a9KfGuSSVpvH73v8RKIYONqRU35gzysESgQfTckFulOojqZqSTs4U7opCRRRFGWDufMAzBjQnyhK6uKzaqfHklW0GXImtjjtkW+vkbHMZRwHy7OUbgdolr92nkOeIsK1Febjma67CQKuUOk+IBpw0MOrEFHKEAoiLzeiVCz6dA6U16nDsAYURVtaFioFIS1IADiA==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kqMa28GgdLFI+BkAU863oINEpUUbDmkRtaBkHf5ffqGmtjktZvdwCSG/i6cx9Ed1DyomA0rCh5piqpw29ZE7tFPcFIwzJHjeqDpd4Lrz9zPUWKXck7UK7skZi0KqrZVIY3L7Lxr3W04n3xoJt5tzYwZBQGXk+VElLcezV6C0+3ErIthTFZw/8/3t9Cq+1Od1NyUNpW1HTAkVyE+n+6UA4JyJ83wUdNn/WNx+E0w9CGO9893mlRAdtRiTE2NpfPF/SZeox9SC2ipB5pzqqPhbFv3VetqNC4ilaT5T24xoy7BL8HoArt6Zjkm6JsvGMNpiYP8pYpo7YVt5qqvHdjXO4o9moAo+GI5Qha9ntAabrAfz16m9JMSEh28qStLI1hnV6QGJghOlLggMLnlGkkIcKOWdnEswJWr/ybnnoTw3+iFRDw5tjR1Lbiit1q21g96/
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:51:27.6818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f04a5331-606b-4ff3-3c52-08dea50355ef
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR22MB996875
X-Mailman-Approved-At: Tue, 28 Apr 2026 14:41:00 +0200
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

The existing clk_register_divider() only supports linear or
power-of-two divider mappings. Some hardware (e.g. i.MX6 PLL5
post_div and video_div) uses non-linear register-value-to-divisor
mappings that require a lookup table.

Add clk_register_divider_table() which accepts a clk_div_table,
and reimplement clk_register_divider() as a wrapper passing
table=NULL.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---
Changes for v2:
- New
---
 drivers/clk/clk-divider.c    | 16 +++++++++++++---
 include/linux/clk-provider.h |  5 +++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index e692b9c2167..d30786a9e6c 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -228,20 +228,30 @@ static struct clk *_register_divider(struct udevice *dev, const char *name,
 	return clk;
 }
 
-struct clk *clk_register_divider(struct udevice *dev, const char *name,
+struct clk *clk_register_divider_table(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_divider_flags)
+		u8 clk_divider_flags, const struct clk_div_table *table)
 {
 	struct clk *clk;
 
 	clk =  _register_divider(dev, name, parent_name, flags, reg, shift,
-				 width, clk_divider_flags, NULL);
+				 width, clk_divider_flags, table);
 	if (IS_ERR(clk))
 		return ERR_CAST(clk);
 	return clk;
 }
 
+struct clk *clk_register_divider(struct udevice *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		void __iomem *reg, u8 shift, u8 width,
+		u8 clk_divider_flags)
+{
+	return clk_register_divider_table(dev, name, parent_name, flags, reg,
+					  shift, width, clk_divider_flags,
+					  NULL);
+}
+
 U_BOOT_DRIVER(ccf_clk_divider) = {
 	.name	= UBOOT_DM_CLK_CCF_DIVIDER,
 	.id	= UCLASS_CLK,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 2d754fa4287..366f2d968a3 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -246,6 +246,11 @@ struct clk *clk_register_fixed_factor(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div);
 
+struct clk *clk_register_divider_table(struct udevice *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		void __iomem *reg, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table);
+
 struct clk *clk_register_divider(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
-- 
2.47.3

