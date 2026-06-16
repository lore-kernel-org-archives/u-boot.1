Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7ABCD98E4
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 18:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CBFF848E2;
	Tue, 16 Jun 2026 20:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="anvfX4DM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60A418493E; Tue, 16 Jun 2026 14:52:03 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE556848F0
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NM1MQ5Do8d0J397364RP3E78QxxvyNMHuLT4mQ3L2fStkJmWzUVOJG51THc08rp4e3HwT8wXevZ9skG+JMvxRKgqYrll5HCx2fdl1SmblrYk9Qf9QtY09XDx3EKOa88bAMAt6JOtKGNXKSqbkDJGDSw3lRjapmMgsFQSrBSidF5BrRZKw7h1Ej5Il3IL1L0YsfRNWNClDGekkRct3Fei35xnQ+3u4z13LnVyti9L6GZ8QuBZfEBGluRyA+kyokYMEvR6u2GEI7FiCderwMK4u2JZOV7y7qq6zVovMxqi9b5CmAcX2SJBWmfzMc+azfJ8K7QkrYG4b0gxNkNuZ14zKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6og6z/IpRsvs1PzanEh0dY1gJqYdbZL0k1FGPx1oHQ=;
 b=LoOt3JvdQPRg8nwa4TFLrv6B//fNTj4tD5pGHV2OwMD7f4M/JOjpzswD/e2X66OpNsbNF8MHQqbD/DPp33zZ+cS9cgTt7KsJKLygqWu+oDB/9N2MKB5RxjbaWnmGghA7uWDfoimVcqFsX/4SjcN84dKXqUj8Kabint5Fmv3VjF4/dZaJtXiM7ipNvg+9ZZbYIWtUV10edqRpGdGPHBQ/avVSS41AAHfomySuHnAbvupmMwpXuIT3tLU+6AWiwnfEu7VkxgQG+FP1vlZ1yvKQEnYR7C/vRiJFbWn7PE9gjW5oTPiNxMULXto79XriHeE3nEHbvn1Tal5bmDnod+VSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6og6z/IpRsvs1PzanEh0dY1gJqYdbZL0k1FGPx1oHQ=;
 b=anvfX4DMbj99RSO+7HKttqy0pwjUuz1lmt+ziKhiTZ3EnXHFYpbPayQC1QoaErvAhDPQ2nb04+QSKQpg4XMacoF3ljUzsPH2stfhxiANTEsJsBtSBt6MXCHFwczhx0SHK8uKDt5eptWUrDsSRJaWbFfVccNDRLNA299v0RVEmX/d2ehCdoYkPO88r/K2q5dIQW3iiwr+PMCB5Vh+mD0VjFEFTbH4mwVTG8OKSfDZKodUecRVWh5ut4hiHAyrq8XqJEQzvnHvNROpavEk+RsrJIG4GsDiLW1JbQyBH+8j1gvN+rFwn892AeJqXLI8aS8+9Jt4/kCkCazP3EqNWzX/mg==
Received: from DS1P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:451::8) by
 IA2PR22MB5432.namprd22.prod.outlook.com (2603:10b6:208:4ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:51:58 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:8:451:cafe::3e) by DS1P221CA0002.outlook.office365.com
 (2603:10b6:8:451::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 12:51:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 12:51:58 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id E894512914;
 Tue, 16 Jun 2026 15:51:54 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: brian.ruley@gehealthcare.com, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: shofiqtest@gmail.com,
	festevam@gmail.com,
	u-boot@lists.denx.de
Subject: [PATCH v3 7/8] clk: clk-divider: add clk_register_divider_table()
Date: Tue, 16 Jun 2026 15:51:40 +0300
Message-ID: <20260616125147.3710024-7-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616125147.3710024-1-brian.ruley@gehealthcare.com>
References: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
 <20260616125147.3710024-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|IA2PR22MB5432:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5527a3d2-8e70-49f5-0df7-08decba60d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KSxExH+v0TCYmhzHIsxklDypEG+G6iMYwXdkqw5bCsbBzc50CyZY/cVBQqLqpsdwl7hHrhQIfLd29AQdhXh8C4p1rGlx8XrlgrMckbpE7Dreq+wc0R/wWhhqw3VO4K/LfJ3aYSa9YjjOBpBBiFwQlz1H0kQspoSC4JHCDr+psy4Nn6RltfZqtt8AFxaiQmdjZf5ioSq2Kkr2zimNMzJ80ED998nAo328swXcfnztbjp52J8LtnneNHTq9vtKriiokEIotZmbYnCbnae7WuhKzTBXvS4CVg+gWoCO4s84EDNUfCtOZyaqSVRZfdNrR8F1RnBTj9JA27eRZhiILXImHZPxvglZr6Wxs7l7+YFAgF9FZDn4xElxMPfRtDqL62Y4XfZISJ8prSbB06E6bVbLiY4v3ReGoLjKWDX2GvG9kCYY7qSrJqkueHh5NWD9PEys88WkBwInRI5GIo154KZma0q+40X9XhVYFR6xPmN/4Jz1ae6rAB2uJoXnBSp9JEwhthR+s/uApSLTmsAJcNUjad6AJ6qYxWRy2tNLMDdQDV/HKIhjy8H9z4rcRiYw3eQg40Hponi5E90otV1HuKRG0c2xrvB5RcmJ06/vMWY116QY41qwZf2si+DDsp2TK2VzSJ3lN+7TD7M7tDIfwidqvM38yLzAFxZxI1X+Va8/ZKcZM7S0+N8h2Q4EHt4VdXowwydT3RUWf/ab4aYv98hnt9lisJZceoTHROfA6ZhTTGI=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cUO5FbbyITfAXsocuddTIeVU0LkvUg4x5QB829D0JmZ2MxNUjqZMePUIpFPMHyyhJ2Xy1D7eU89sNehRT2h0LVJVEIzTbiuMhvO+lhmv/qEzjt9RBfLHkKoDpcsSsTMJ8A36IeTAGMYlAYcJpJDE0B2ysbXGLExJYn3fA+xZ0KBqL0Dn72/yc3OfmyBxJZDKnW2ygeZZKVjoI14z1JfK+z8kqAUbMKPsKNHSUeOWntG1Ld7zkrq7+ZRmBXIQdrfXqXsDnrsJpn24rydOw0ky+e2KbJUhfaOllQepsO84LLcKiBc+NfjEQOJA5bzEtWhun3pAku+4aZxx9HaeCJm/JqPkidThCUjgynqNedg0fcCWSTFTCLdgKAJQRINOBGGL+wkwC43zdQV4coGlYzY+HvzWXRNCkX0q3S74dLqmf8AOq2IA//Ovp/yND3sETeXA
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:51:58.0733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5527a3d2-8e70-49f5-0df7-08decba60d60
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR22MB5432
X-Mailman-Approved-At: Tue, 16 Jun 2026 20:53:56 +0200
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

