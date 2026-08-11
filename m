Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C193DC5CFC1
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 10:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65154607C9;
	Tue, 11 Aug 2026 10:53:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xcJGYfRWY3xx; Tue, 11 Aug 2026 10:53:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C355607C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786445620;
	bh=ZkQnN6cabAD9+mtl5fW4SuFg0d0duRLJ8fZ10II8X80=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S1Gbk5Tgr8SCNOS58w+sTP+WhP8cOnVfVfKiUAU7ls8gn+lKG8to8NGRBMngh39ce
	 /DsJ5VsOmv4KhfHgwWv+CcXZzMfCQ6hG9uHq8LDj/tRpbB9sURMVeQNXGGr+ian3nz
	 7BHHwow9O8G9LZE6cYHLNexdoGsKNJKBww+fTmWf7+NU2NsXAUqXdUhfjFHF5xZk/8
	 YODP7RiEjnsd+sRGOx4p3LVK9WWDnJcDEqAB4t3uiZMk4iVz6oEzh4xbl65Cv2ikpx
	 XnxpOTncMp9cjTzXlZ9OWwRvnewaNbqbKjuCMqbtbjhN6+/re2jeY5A2msAh5vKMbs
	 cSn8PBinMzYYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C355607C2;
	Tue, 11 Aug 2026 10:53:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DAE0F4E0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CCAAF40752
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YwM9QOVoNIRb for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 10:53:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c111::9;
 helo=dm5pr21cu001.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EFAF14073C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EFAF14073C
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EFAF14073C
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6fe1CtjGz53Oor5rgp0X1ESgvNQ21g0ECTFabgslSToMMrHCWpUCxpB0nXDbCK2NGW8xQT/TeA6u8qfbDNBqkWuVJnfY4TEeMN3exaOHMSZkhGQw1YRPV7hYqouBpkunUSbrbNl72TIOb6xTKz04gu94/kztK3nvNFhae/tQLa1xyuhdboZhe5t0jbd8FIIAinURqFwazYyrAaW8I1Z5bf4vgLVfcUhfWdUlKP2ks9HiVi6mL43kJ59au7P2R72UqKTvKIEBXTotg52bL0N1A7AxLlWwmOTs7Ti62mew3ra14s/uW3JDJDumxlAln2irAD/oQmFrjNQi5wYH9vuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkQnN6cabAD9+mtl5fW4SuFg0d0duRLJ8fZ10II8X80=;
 b=G9qgPHb8lzE1k2owSkuejkH5HzlaGBsqohBvaFOqREOjL6yzUFwtA3JD9VknippW00HgKD47+tNNhP98mWrsPFJ3dH/nVptze3FBCFgB8FtxBfyf6MXJaSk+0aMzCKW5ckb/GaZZ0J4Vh/nlwYItjH7Wfy3iVv5hQlfzlmsKSqfneon5K5KxLYA3IJ4pavVP83rLu3AmBMGWpJ/BnWLlGxvuxo9kbdIzBpb8DcXqoddfymriUooE22CD5SSAtYVb//qg+DSPxsB2/eB/dcJSDoZw+3iLTuFRlRBcEgDvZLdlfm+WD8OzkabO0s+PJOaQCo+qwmRlKEGlzrrBQ1r7fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from CH0PR03CA0095.namprd03.prod.outlook.com (2603:10b6:610:cd::10)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 10:53:32 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::5f) by CH0PR03CA0095.outlook.office365.com
 (2603:10b6:610:cd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 10:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 10:53:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 05:53:31 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 11 Aug 2026 05:53:30 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 2/6] gpio: cmd: warn when a gpio offset is already claimed
Date: Tue, 11 Aug 2026 16:23:10 +0530
Message-ID: <20260811105314.3837228-3-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811105314.3837228-1-pranav.sanwal@amd.com>
References: <20260811105314.3837228-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: aa4d4147-121a-40a1-62e5-08def796c935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: m3gLUdtFs+SQAMYjUdWQdNH3SjBY9ToV4UN78NhfjKq1bEw0rOwIapaQMYC/sXqYK4O/h+O7YuKGMSYvfcp6+4eaDlmOabKMJKHISPlJNBQCG+iG8trPAJu2C1fTG1eDlAoeqHe8kntqXNnPOAFu7oOI04pHa5bQ/xApaipOTwz0ukcqzf5fuoGNaHCjqKwv7N+2KcJmKph34AQbyX65kf7yUSC8NTd7F+fPo8BNMa1BcW26qEGtj/kp1EehoBZBbWP+BrbI7232GDN+smu/cRkEglCS8l1VrxUNta7cdhjQVUpPI6pNJ+Mvoa/A281kZR1t+dRLZonZ4poucGHmncljV0FsREMXI73NW+PPPJCrXq8nIbT+TiTZqCcSpXLtqo10aTJbesl7Q8GRFvKBUDEmqiQP4k+UYXYE6xRdSd05X6fCjwIY1x42vLweCX6uts0F68Gk5oqLrU9vdQFrOXhywBO1nnrsdryoZ/wTldnUFduLVFZaQ22h7bxO7iA9kY1u0rny4hqJE3591Af/u4DVXIDvsrEW6nQ2wlxI6nFpF8JsX1MFAaD6PBXbSORpPsOHSkEZSXE7D8IjSh1172ujmbwHTwtv/fmCGxab6YXaMPWmqN8ZgCuj0DwVd/13Z4PiLV3aROHh1QA5p35eOtYuPbNZppwNl/3GSTkIj0lCPk9S10hylQIhei8MWm0L6XMC6PsOnx3HdXhGSKijBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tz2vYRKwz+NsU1b8qr/iNSgRNdRn7Ob2ySOhrAsDl1/3GpF5bAsSRT2qvmdM/eMpjp46cqGFm8anDkZt40eKOr8G+wKsonlVgdZju7ewXYWTQD4ataes67EN7lq+XJJq+nmjz3YBRETgHN+kVhFdGPoQNRe/dkCgMVKRiiSnquAuEkBOfJGhxihvTSrCs8z1ZLwk20AcUVZhLoHr5ivKNDBB6yYrTpdoBjIEIPMy15FiHdlKQfZnZzaJEf3EfvU5w6ioxl86Du66+KhLceZEyMHqfolPIItIlMHXO+E7Ct7pHo/ZDQVu686kindcEy3KS4RO775l0bLRjCVeWcYcYt0UC0VUdiK3HUB7wDkNPcDn3TUNkcapk50VU99iJont/JMu6LGA8tqXhol3tonWx+TrmDVbQCwH++04QZvuUpfzFWKQkUZTs8yM5/vjzz1N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:53:32.5265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4d4147-121a-40a1-62e5-08def796c935
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkQnN6cabAD9+mtl5fW4SuFg0d0duRLJ8fZ10II8X80=;
 b=hAemdPdiDofZQe90GJo2dzpu1qFmSTWrgAiYJ30tQ4c+/MgUtYM1P3IPD1h4pQWnh9v2oExIUgwHMGgS+Lli2Qeyxe5xe7ux251MKkOoWQF0LCC3CSZF3xQoucD3Mj4BXvR9QExXQ7I2EHz2k/hsIflNIHOIp0fu7qwVI9qwMI8=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=hAemdPdi
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The "gpio" command silently swallows -EBUSY from gpio_request(), since
a pin already claimed by a driver or hog is a normal, expected
condition for "gpio set"/"gpio toggle" etc. This makes an unexpected
offset collision (e.g. two consumers unintentionally routed to the
same underlying offset) opaque to debug from the command line.

Print which label already holds the pin when this happens, using the
device/offset already resolved by gpio_lookup_name().

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 cmd/gpio.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/cmd/gpio.c b/cmd/gpio.c
index 7a43dc6ab18..6992ed0e79a 100644
--- a/cmd/gpio.c
+++ b/cmd/gpio.c
@@ -137,6 +137,8 @@ static int do_gpio(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	unsigned int gpio;
 	enum gpio_cmd sub_cmd;
+	struct udevice *dev;
+	unsigned int offset;
 	int value;
 	const char *str_cmd, *str_gpio = NULL;
 #ifdef CONFIG_CMD_GPIO_READ
@@ -217,7 +219,7 @@ static int do_gpio(struct cmd_tbl *cmdtp, int flag, int argc,
 	 * code here to use the GPIO uclass interface instead of the numbered
 	 * GPIO compatibility layer.
 	 */
-	ret = gpio_lookup_name(str_gpio, NULL, NULL, &gpio);
+	ret = gpio_lookup_name(str_gpio, &dev, &offset, &gpio);
 	if (ret) {
 		printf("GPIO: '%s' not found\n", str_gpio);
 		return cmd_process_error(cmdtp, ret);
@@ -230,7 +232,12 @@ static int do_gpio(struct cmd_tbl *cmdtp, int flag, int argc,
 #endif
 	/* grab the pin before we tweak it */
 	ret = gpio_request(gpio, "cmd_gpio");
-	if (ret && ret != -EBUSY) {
+	if (IS_ENABLED(CONFIG_DM_GPIO) && ret == -EBUSY) {
+		struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+
+		printf("gpio: pin %s (gpio %u) already claimed by '%s'\n",
+		       str_gpio, gpio, uc_priv->name[offset]);
+	} else if (ret && ret != -EBUSY) {
 		printf("gpio: requesting pin %u failed\n", gpio);
 		return -1;
 	}
-- 
2.43.7

