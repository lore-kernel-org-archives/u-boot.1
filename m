Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CD9C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 04:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F65A88190;
	Wed, 15 May 2024 06:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wiwynn.com header.i=@wiwynn.com header.b="1AkqNL39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A99BA88190; Wed, 15 May 2024 06:05:46 +0200 (CEST)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C5C6880B5
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 06:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=wiwynn.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Delphine_CC_Chiu@wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4Am10p3QF/B006rqEKB926jReZDF1kh0c/HnUJNAZtF4Iyfi5zAYD1zpth1YujYOXi7PxsfEbqey8usIkTlyaIG/liy+zlIJGNfpJMmMcANQiTvRXSeM7wOC/xhOEBq5iGgrcIChhl/rbMwcbE/edgITK7pvYOhy9W2H089ZYmsbLEQDu2k4gUDXPKmjzUb1MaXLCL9hMQvmBhOYsZ2AlSLxE3R5n4vxzwtHQoCXjsEnrrq1Eo/jNnOgiN0NStgW8UAR92yGufMWwr3AuFlyIxUu3jVksSnhwWQh32CGHBxuS5gZmU9mBMaIA1SUpx4ji7Fq42Z1eOcLRyMcF7DgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqUNRDzP/Fv1GyuqC4m7ZFX10035VI2QnSmTOdnVGFU=;
 b=eIJO8tIYyuVEAZtFgFc/rPkKdaWavMLbCgTzrgEggTnK/HrY3I2YyUrjj22Wl5hkoMwDJIf8KAyVLKQsyQaJpiwYGgzJ/2fKFBgMtXyYwRe1nUnaRgqkYGtzFfx+Bo6qhDjrJx+ai30y1CT4BcYY0jax1+omf8fHBlDdCGJZshI7T4X14sbdXRTs52S8LJJxDZ/XnY4Jc1ibYmvLA5da+GT3CYVeCIgtST7HjwTnXX86s2oNs8euF0JBWM511zLONBwDDFlxu8Fo1Qsrt5WsWkKZMNULgBAkintRSYGscSEAcLr01OC8lWz/9keFbIW+jAR9K6majx0jDE9JxaDw0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqUNRDzP/Fv1GyuqC4m7ZFX10035VI2QnSmTOdnVGFU=;
 b=1AkqNL39/aTKTeWc210Pq7FZ/wC+avGXf3ocwmElTZUreZFwTaIkIO5vezQNLUh81fv5h+L17WjrzeL/MrzOv2e5Ns+k/koNsWhitDUIAkW2PyL5uVtL506jBoY1vjWhPPBRRGOQu3NkHAz/Kvo7ZSXRBvyYk6A59Lge35Qtd/upBjspWTFpOBgknPLimjkL7zWl/cZjYHngIhbXzTp6ZAXpHnFa6UosRKwwBel+1Y0MPDYKDrbgedfEc1QANF/KGfJpNwZ3qFC9FpbBQ5Zs2nHqtjDakXn4BT0sU2u9d2gPrJsiN1+02/6gDM/L9BJLTJb8+VfUNo3Q7bBtgrme6Q==
Received: from SG2PR02CA0101.apcprd02.prod.outlook.com (2603:1096:4:92::17) by
 JH0PR04MB8296.apcprd04.prod.outlook.com (2603:1096:990:7e::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Wed, 15 May 2024 04:05:40 +0000
Received: from HK3PEPF0000021B.apcprd03.prod.outlook.com
 (2603:1096:4:92:cafe::4c) by SG2PR02CA0101.outlook.office365.com
 (2603:1096:4:92::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Wed, 15 May 2024 04:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021B.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server id 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 04:05:40
 +0000
From: DelphineCCChiu <delphine_cc_chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: DelphineCCChiu <delphine_cc_chiu@wiwynn.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 u-boot@lists.denx.de
Subject: [PATCH v1 1/2] mem_test: Support to save mtest result in environment
Date: Wed, 15 May 2024 12:05:24 +0800
Message-Id: <20240515040526.178161-2-delphine_cc_chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240515040526.178161-1-delphine_cc_chiu@wiwynn.com>
References: <20240515040526.178161-1-delphine_cc_chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021B:EE_|JH0PR04MB8296:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 315b979f-1ea4-4169-4cee-08dc749448cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?879viqI/SYl6WtXznNDH2o5dthUYudp0Gm17xqldH+AEZ7Co7anaetJh6Vh6?=
 =?us-ascii?Q?p5Yvg8+M3mzDjmrPE74NgAZ61+YoROrMx8RSb4f+iaU9uU/uannYN2mIBy29?=
 =?us-ascii?Q?rqh6n0V6BGaCftgnCdTCVSNPZ8bHtvoYxKa+GwvAWWNJ8mFRMchNc89OKe4s?=
 =?us-ascii?Q?0znWM9BR9D4UlsTPLxyF7yoXBcGEYS0ZV8sYpW5U0fm1TRadrrZhxQsiUMhN?=
 =?us-ascii?Q?EBkfiG4fwzXXEgKorLZa9pkOzhI9DZm0sZ0B2AuvLXeXy7O3lJIEQW+NJCyV?=
 =?us-ascii?Q?V+Rqp9sh2uR1u58WDd+nOaOiXSBhHSsNIcJ0SwOTfN5JsFslQaYRmJ5CiMvh?=
 =?us-ascii?Q?yCn3FCWyj12g0kEddupppT7e2nrKOSCQLB5Ayd4hJd1Tt63yuJ2CQc5btwj9?=
 =?us-ascii?Q?lOIzlqyi40YtgpaQ249Pz6b9XuB8y+zMAaZ+hNx9dNOnyRzKTe7/yJvo7MpX?=
 =?us-ascii?Q?NmHvZKTtqviXcdRKr/DwBrO5m3ElpZvz8vOCQuK2wvBi8q2IZh9vLO3HIhyr?=
 =?us-ascii?Q?/PhBd0c/4twBhTvMnilxMe8umJdwnx+WWHKlub2458SrLSHFhQU1cB/gVeKZ?=
 =?us-ascii?Q?qDiNDIjsR3DAf7cxYzEfytntslsUrfqa8QuCheVOqrOqINA3soi6JO2pSLt4?=
 =?us-ascii?Q?Ay00rUjP6CTo9zR1xIqbubK3KA0BjdvVwxE/bjI5TMPFN700aWKrhVFYRQVB?=
 =?us-ascii?Q?II80Zn3SwS3E5OUUwbhuK47NGV9G85LDHNAv1aImz7t+t1o2qzrevf8QqB0g?=
 =?us-ascii?Q?cXSp9WLuy+Ptdws6Wv/hYFJd/q1GF4b+4cWAxSQTINIP2DeqE0IW5BfUQVaT?=
 =?us-ascii?Q?mYsVsy9PBDBg1ebroDakCuGDupJAlEkCuh1VPEO5ExQKa3ps+d4qpiX3fqNB?=
 =?us-ascii?Q?GPQiXsANFtj75TMtQEr2W6yJrKLCPsXCRnJIlQ0Ui8vR9CVAte61qbRt694o?=
 =?us-ascii?Q?EpBWi5aXnL7mHx7QA7koi++AZK28noj2ILqwmEyl5+Yb+zsXU7FBQ0/URJpo?=
 =?us-ascii?Q?2ZFRU487n+HU+1E2h+9ucrKr9qIc936/lgDK9bLQhdj43aOvDNECnJpwqhHa?=
 =?us-ascii?Q?OpHgfNNDml6jZ3XWY8WfA8Bc1oIjh0Ndfk2xsEI6akdtFtwieaLp94XRr68e?=
 =?us-ascii?Q?kwp4zxANvv+lp9Gnbs65EJ1BI8OCrbLucWnOmHUTWofZSlZOJL5jXoGss7Hy?=
 =?us-ascii?Q?QTDMzmOu1GxyPE/whOQ0cgNW9u+uj5VBKXBhXjK1zkjwJaUIg2DLRhTbE5x9?=
 =?us-ascii?Q?eqTzNjgZiEGAi7fuo3jJZqp7WVJu8gYZuCKsQ2tuEBWcDR4tf3vY9geOHCcG?=
 =?us-ascii?Q?Tf9T2zKvG1FVV49FWxkzSpNbOWujXToDs+TD+Jq8cwVS7QF0PZBf8nnx1O5T?=
 =?us-ascii?Q?A0iDIHfJl/N5mPHj/G+fOu7+waAG?=
X-Forefront-Antispam-Report: CIP:211.20.1.79; CTRY:TW; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:211-20-1-79.hinet-ip.hinet.net;
 CAT:NONE; SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 04:05:40.3157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 315b979f-1ea4-4169-4cee-08dc749448cb
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167; Ip=[211.20.1.79];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021B.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB8296
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

Set mtest_result in environment after doing mtest in u-boot so that user
can check the result in user space.

Signed-off-by: DelphineCCChiu <delphine_cc_chiu@wiwynn.com>
---
 cmd/mem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/cmd/mem.c b/cmd/mem.c
index 392ed1756b..bb6a3d2e60 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -21,6 +21,7 @@
 #include <watchdog.h>
 #include <asm/io.h>
 #include <linux/compiler.h>
+#include <environment.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -943,6 +944,13 @@ static int do_mem_mtest(cmd_tbl_t *cmdtp, int flag, int argc,
 		ret = errs != 0;
 	}
 
+	if (errs == 0)
+		env_set("memtest_result", "pass");
+	else
+		env_set("memtest_result", "fail");
+
+	env_save();
+
 	return ret;
 }
 #endif	/* CONFIG_CMD_MEMTEST */
-- 
2.25.1

