Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BC6C5CFC1
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 10:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3CCC8104D;
	Tue, 11 Aug 2026 10:53:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Py36cPjbiSYo; Tue, 11 Aug 2026 10:53:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D609A81069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786445624;
	bh=PSmPoLB4+Ei0y98PzTpcigGb+GnyCiTDJJb5OhSkyqc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=woAMnGtA75j6prL1J3qPISHhP6+DYpxNv9hx3SsJl8r/gCNdVBhtO/knqMik0YR6F
	 Cls6YJrcB/x66A0Pxj6SJaoJgl4CFROqz+QAu38sUH/yew56846HAvyFb/hBOv/6ed
	 QvU1HNwRYQeoSg0bweanXZmK3epxWQkEw8dDOfR8MoV6669UKHdnnt1zwW06Dt+UQR
	 EgITUn4nTWaDqVu9+oWcXDA9ky+UoSoDwfRxpDkhL5XRshQ1Up421Tb9mxibJlQipp
	 0zKS15H1eA2O8XyF4gA9gEEKohv/VvHtN6M9AKjYu8pSP5SZi3Lko3K/kljBGkmD8P
	 3nF8TThir2zNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D609A81069;
	Tue, 11 Aug 2026 10:53:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F8F2345
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 219BA40752
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BXruAjyULhsH for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 10:53:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c111::5;
 helo=dm1pr04cu001.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5F2944073C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F2944073C
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F2944073C
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrTzl6/HCSmgGSmX/MknAxOSFl69oAoZhEIeUsb1i2d4r5NBSuCCJDzmTR/U0h2EqtMqqwHklHH7qe1LngkhGM/Q5TUcrkPI6K8fFsDZWYZ2X56FYA9fqSvPMJ0VHIlNQKxaEWptqSDr8XRbCQWoT6LwyOeIObOZMncvP7eAoNakUKNxsHhPQr3Ee5q0ArK3kCS6A/vyFv39ICimfndiB9aw04LfLmDjpdD8fpKnqts0xN5ty8UYiL74Lm0NAM8gbJjcnIgqwEPlVfSJ0EQq8lADrcJNL2QD4L4BOQRpoDTtFwZi665yBFHoeb2vh0lRKPgP522lGEF2LfurNK/f2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSmPoLB4+Ei0y98PzTpcigGb+GnyCiTDJJb5OhSkyqc=;
 b=iX0WKPDN8GqrawPgD475A48LoXUZkXNx41+BR7OHi8Ceg6Ub/qhQHxQApp8cEHqBLUiEOW2y4NlLkyrY2mrZ0UHjhT8GN3j+5FN5Zg6zAHcD1XWKQyp39K4l37oHKhEtxyV+7guuAWISi7v+Sk6D+t3h4sQduaTVtS9P9FViaURXv1W5Q1jt14mNU5ygyiH+b65v1Q7rgndi7zaW8xLba5DTcKD2phG+Ys6b8TTet6OZtmlgPsNKsJIjK30Qa3ZbefcSG53oGna/cQiAy25anNXL0jZEhHpb7kDzbztJ5VuzavKV5HqGQqnrAv/O8KUBmruVVR16yymYBZLbhLvK9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from MN2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:208:1a0::17)
 by SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 10:53:35 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::33) by MN2PR07CA0007.outlook.office365.com
 (2603:10b6:208:1a0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.24 via Frontend Transport; Tue,
 11 Aug 2026 10:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 10:53:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 05:53:33 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 11 Aug 2026 05:53:31 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 3/6] gpio: delay: set gpio_count and validate index against
 it
Date: Tue, 11 Aug 2026 16:23:11 +0530
Message-ID: <20260811105314.3837228-4-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811105314.3837228-1-pranav.sanwal@amd.com>
References: <20260811105314.3837228-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 87061c42-95c5-4b59-0a68-08def796ca49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1YuVscDJoi95qvnvFv1LBajoz22URA2eb1/RcaWfiO6+TPZWXFmXGE7AnScGERgqjKVaHff05PT4AM70obJJy/JU4aHngL66V9UT9mwM2XUuyhJI2u/wRRsHjdUzjXMb0VZgnpcjWWxwKvWvoVysyy3usxS8QQwWLMRfAZ3vKysZCi9Gcm9HBMGX++xGI/5gLSd/P5UM15+If9G3DvDebat7WQzq5L6Whqd638c8TW5uno1YQFNcXOl87kofJWhWPrrz0YktX1VAIrBi6AJiKggcpOKJO6YPwgjY2hY6/1b5nptFQ2nIbMNf9uGJnN7ncJDBkfQUJcvy0D46CwZIsEJ8gehskR0z/pt43FyhDdSP+xZSEdUKAt/dDjxk7VEOvNrqzw7s9jMYhtTf/A/Y8x390XMJ7kbaUBra7Ll3FnlI7uG//tu5dpdSaPX44LS4kOfdFMsuKlypBRzxAUW8MYykuMvol7TbUUkGRd8FvXzCr5hqabPQ+OG5yPrbuY20Va5mwrQSGDONGn5gJf8S4x8jLMVULZ8M8xvK+/3jNoPVkXaROodHYYnm4Zp2tuayB1i/qtpvk2UfmjPc+QHGGb4ITtnkoEnvE8J4phloja1hjC5CvIQeLQDebdsA0OyFoxNmGI5JFO9+jSOfOTlvD4DihXs8HNNsrNz6TXkW7R+aCixdSmxbklrNMyiQ1lJs0vl1lDx4QR7qaQaWtsBXWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2594zV6NVT8TEpE9PAEktGv2n1tFStc2ZP3CnjcD3XhhUHQNLbHxQ6FNKqYf5fnoa35OjfBVLLEZbY1TxlP1hwACvg3SVL+gQcvL11PQrtzvThgHDXsDbxSo5Wa1CzU7MPJMnXX5VffpbQKXbBsIE3jQnfDZN+kxYLJQLdAkNn9inyvfNYIE0fpWxJFZvtSPWQ5UNxImY+2kSoFu+BYTok/wcoIJ8llGDmikxFg1uJVDHbgUdaHhMtMuEgv64lEnNcJY3ZdIHDbwRyC7zl1yEhr+F0xwjd3Y9OclAvQzQwZAQcvHWCvnLIRcaRBikdeMYA55UUwW0AYYnJ/xPf7IZESWYDtWkZEKHwiCkf7ZybfV5XSw1kmTd6+2xKow14hk4tjc6+2Q2YKhBGRYhXPsRpRVg4Eqkq8E2ajGUCXLWPOazfKQxNwpsVYtJAc4QBn7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:53:34.3700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87061c42-95c5-4b59-0a68-08def796ca49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSmPoLB4+Ei0y98PzTpcigGb+GnyCiTDJJb5OhSkyqc=;
 b=HclZXhciaexRMILbFEVybULgtvgYl6Pf1wEzG1cYk8XTkR9j6iFHNGgcNwwioy+xXWZtJxbMsfP0wMWVMF5GCWZzqRxqQD3bvitUpJ9QQbt7G1c25ZOkr2HQOkqNhQXT/IYRHJ5XANAqK0WYwFeZyGZ/iUlixwcuWJE5FALfPDs=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=HclZXhci
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

gpio_delay_probe() never set the uclass's gpio_count for this device,
leaving it at 0. This left gpio_post_probe()'s claimed/name tracking
arrays sized for zero entries, and left gpio_delay_xlate()'s bounds
check validating the requested index against a hardcoded 32 that has
no relation to how many lines this instance actually manages (ngpio,
from its own "gpios" property).

Set gpio_count in probe() to the real count, and validate against it
in xlate(), matching the pattern already used by the generic
gpio_xlate_offs_flags() default implementation.

Fixes: c866f2f197e2 ("gpio: Add GPIO delay driver")
Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/gpio/gpio-delay.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-delay.c b/drivers/gpio/gpio-delay.c
index 9105deecc4f..533e7d2f8ef 100644
--- a/drivers/gpio/gpio-delay.c
+++ b/drivers/gpio/gpio-delay.c
@@ -68,12 +68,13 @@ static int gpio_delay_direction_output(struct udevice *dev, unsigned int offset,
 static int gpio_delay_xlate(struct udevice *dev, struct gpio_desc *desc,
 			    struct ofnode_phandle_args *args)
 {
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
 	struct gpio_delay_priv *priv = dev_get_priv(dev);
 
 	if (args->args_count < 3)
 		return -EINVAL;
 
-	if (args->args[0] >= 32)
+	if (args->args[0] >= uc_priv->gpio_count)
 		return -EINVAL;
 
 	struct gpio_delay_desc *d = &priv->descs[args->args[0]];
@@ -97,6 +98,7 @@ static const struct dm_gpio_ops gpio_delay_ops = {
 
 static int gpio_delay_probe(struct udevice *dev)
 {
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
 	struct gpio_delay_priv *priv = dev_get_priv(dev);
 	struct gpio_delay_desc *d;
 	ofnode node = dev_ofnode(dev);
@@ -112,6 +114,8 @@ static int gpio_delay_probe(struct udevice *dev)
 	if (!priv->descs)
 		return -ENOMEM;
 
+	uc_priv->gpio_count = ngpio;
+
 	/* Request all GPIOs described in the controller node */
 	for (i = 0; i < ngpio; i++) {
 		d = &priv->descs[i];
-- 
2.43.7

