Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C37DC36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 07:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C26E281DE3;
	Tue,  1 Apr 2025 09:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KcCJ1FPD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CDED81F44; Tue,  1 Apr 2025 09:57:29 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41790801BE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 09:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzbn8E2lZePM53DhKK/jxxFaS5doo3QsIDMUaVg4nJOkogRWCLuDmNjbs+6mpene0VCrs43LdL/gb5Xsfn3mCO2wO+xmkWIVoJUSFxkEIGYj1WejPzzUdYwGpzFBKjjp3Y2MOeBnZikPmlfhmEs/FpPo4dkzy7KKFD3R4BOHP/CY6VQ9kVvKQtDTli/ZqCHkGMjY+UPnllKDx8e1f3nIZp0iMETsQVODoiFQdIIAW4cCv6jG2VA7k9NxytJSzAcE2yMOP00FIgirDs7quYT+NwHkSmLUKcZNOXHLf6EAOJ1FAWIPKm8rvskbCU9NXeyGBFeSKdvVUYtbiIjA8Pwc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCrsCm7I4OvHIFcHrfD6sJj+5S0Zug2zwe4ZitxCDDE=;
 b=l3RD7N3YWfNm/hKhWZOh1Q4T4sl/TaAhGw6jYCDGtWgUfbzvFmKdMSo5ruOWVS9xJ6EuK3Otc6hvixka6qFcf1MwWjeRsNxhLCY/tAPu0/C7rxyhH7T0mpt2bM1PoWT8krlQUttQQPbadFueHx2DGgQPYTl/GBr4DN4mvROZUY8Wx6MueumeCw0FXmjIc49OlrA1BYDnPK62YZbHob4yPtFCJHYSoNOY33vvH/pelG1vJmsJSKrfcZID65OWD6o4HbVeMpuBWX2oS17ASYIWLDYNEsl48v9lj1mLiAuK2S0H+5jBTy2tPq4NUnP2eN70nkQxpbJSlYtT8VCOQ/OpLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCrsCm7I4OvHIFcHrfD6sJj+5S0Zug2zwe4ZitxCDDE=;
 b=KcCJ1FPDHwd8WPOd4S3RIPbBSF3eLQSGXNzoJm2f0v4r0AxE/QYW3vIK8BAy9aDBXfUze/fsr+r80Qln5M8mxPSmjHhYHXvdfLSQSJA9UxbFKkscrGd951vYwA/vc+EdjT3JwEk2cC3O+h1za9gmTMHSDV0Kpg9nqKUlQUWhJOBsBHMK77VWijoWeAGIzNYsMYQUIGLf5Mjk8sWlrD162u4yDiq4UYiufMcgE81KH1zC9bY5dkUgenRkyxnkqt8GY8mnJIttx8fsvTd4YsqFShQzU8ulpFqLXlRMjtWRFCdbXZpARhBXC/vaWhAUwj/xA/vmDMCASThnUYkOYKpJQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB8020.eurprd04.prod.outlook.com (2603:10a6:20b:244::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Tue, 1 Apr
 2025 07:57:24 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 07:57:24 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, sbabic@denx.de,
 sjg@chromium.org, seanga2@gmail.com, lukma@denx.de,
 alpernebiyasak@gmail.com
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, viorel.suman@nxp.com, ye.li@nxp.com
Subject: [PATCH] firmware: scmi: smt: Interrupt communication enable
Date: Tue,  1 Apr 2025 15:56:35 +0800
Message-ID: <20250401075635.3802640-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ff3397-a8b6-4f74-46f7-08dd70f2d687
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gdGSvgR+Ac4D42uOe9k4vOJXKtmyssyFMcCbRkspd4r/xqiZgHn5UkRjvlxi?=
 =?us-ascii?Q?lJSWAq0XALxcERDNAYT1z6QSU306N+JAtYgbL496KzBLvtv3jj9hBAz3oFcA?=
 =?us-ascii?Q?S1WawdY+KCH0MzWx6JJ5xgRLygoi7SLfK6ApYbkZDOBEAMwoocBPXo8t41HS?=
 =?us-ascii?Q?Z7lOyKaPkryGRiGJiOKrRVNK5/c0v/xZNULE34ZLFFBMk4bqaSB3FxaKdgIg?=
 =?us-ascii?Q?VEEpD6flDKQw72+XFFcd9CkZJtoszxEI49dqF6vD0oei+BtoKzV9yg5LrdgK?=
 =?us-ascii?Q?gPCFdJWKZgE51Sw6jqLNSxKW+RU6mxDdlGve/kf1GKa7qxUo7O1xxvFxGUPN?=
 =?us-ascii?Q?upDvOs3zxwQ1RwemSXJGvmSOthIRZjr5EUowXCdasdCofSr8b2osexTj1OJS?=
 =?us-ascii?Q?/4KDmkTFSRt6u/fgN7KpRRwHjoR9USYJLCibjcqHw5qaap8IeQ7UyzdtVq/2?=
 =?us-ascii?Q?vI/zqc5nYftKI8AIX/Uij/ehfy5z8vX2d9xO6uY6eQgFJc3QQ1TMqPvNw1Td?=
 =?us-ascii?Q?V/0cRF1dQYKppgEneFXI/sJoC3uLbvhVgUt0+KZ9cQkuk5AMyUWd2dtDCljw?=
 =?us-ascii?Q?ihGNW+N7iId9t90z83mc6benuxn6nyGqPotJeyfaqhtuTZ+ig3Go9BqIQbAC?=
 =?us-ascii?Q?damsh4cTMZeACFJkZb1AWXY4iPueTMK+07gRyfITse4QP5MRy7jI7gP+ZSqd?=
 =?us-ascii?Q?178mNl/nsfxCsOhWVMl9w7Ip9yZhCSmBfGPkMrt7dXNnfxqsyCJG5P4GxlY6?=
 =?us-ascii?Q?Wk9ybVv5uYAPW7Kovle0153yaJWb+Kg+u4fK0+ro1VyYQ711KGmlmOuhIDZL?=
 =?us-ascii?Q?+UsiLgLbI9yCDwqx7dU5J1M/X2nSrFeXPulg41FevsAAp/xNHdshFApam1pS?=
 =?us-ascii?Q?YAMLzP82S8tWt5crczCwg0W8cDObzS3UTSbjYbnE/a0IZtBqAuHLEwrhHeuK?=
 =?us-ascii?Q?PIR1YCtxP2qP4g0rZBe4u9UFCcLQ2DOLhxKVKTQI0C4rW+8AVca5k/4W4V3+?=
 =?us-ascii?Q?fN2Vf/tHBJiT9D7gYtaxWzkShRrYjLHud7fhb3/70Rf6xnx+SU/Y+FsOeV2L?=
 =?us-ascii?Q?3Z1SO03qcnAf8F1zo26oPKSsxsM5shvXsMZsgZEeVzuqSJ+hxyU5BHy2TvFF?=
 =?us-ascii?Q?JG+LwiOcr76dRFWzANUKN7l3t1+fLWRPYW3c+i5kGLGbc4+c98WKi0dPeZqC?=
 =?us-ascii?Q?pnuEWEUee4bOrY9JMqCRZVhI9xU1LvJkHk0Rl6tpnrMmmfmuPfxkbqpF4Waq?=
 =?us-ascii?Q?7p+veFjpwQO4YNLK7b0orjapui75JF4ZBkv8nRTv+kxAc8MlvYYBcxc3fksC?=
 =?us-ascii?Q?hEkB2ujXgg2L38Yva5bJWnuMPwzjcB/Ph8wRm5PMqmOJoJs9Z+csS+Noly/v?=
 =?us-ascii?Q?tA2ffkUcAT0JiL7cI7m+VUZDkQNH5EFt1S/2eYCybYr8TwWiWM9U5KQc3+Dv?=
 =?us-ascii?Q?wXkd4rwGFBWCsTgL3c4qBgmgaqk+viLAYl6zW7xBl1/L0HBMjAZNIg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EJx6nUHprIhJkrPmqZHP37QkMdqp1LgFfCXeGUXT24nJjLw9gZGqXZoifzD2?=
 =?us-ascii?Q?eCcG3OsO27TAb6hhPBPEm+nipuRZ2qddiWtUwk9Yes4xZPkMvKg+8yXZr6p/?=
 =?us-ascii?Q?d4TWi8J3VD3YVqfT/W2mnwChNG/RzwAS/+vIafk8byMgZpU1+Ikow0ow18R0?=
 =?us-ascii?Q?EORYtJBeGOWEUV4yrckLnV4eF6EYH5/5lLSMndLBYZkPDZHO58OqSp8MlBA6?=
 =?us-ascii?Q?OGAFfDL9tMgw+REh/zfLgpSAd3cgrMJO0L191ajn/SmZjqehGH2c003dCPe+?=
 =?us-ascii?Q?KcFiD0SZFbNku2igeoedQbQKTS8Q5lMbNWdjyc3soeiH48X7G2UQCr3IGXWD?=
 =?us-ascii?Q?1hPcc/NE9v+TIQPKDnUIu3dy8u+nRmbgqCRwWrgjI2c7ScvAH47Gg/l/bLC6?=
 =?us-ascii?Q?NIOgfQrdWA72dCXvghfU+IeiG0mFgDqh2p7Khy7YKqB6mEKnXguFSbotC0A4?=
 =?us-ascii?Q?ZfQvFkYjuD7GeK6kZK93eKvrilcAPj3XqIdo1AfG1vmSymHIRKwNvk+EbQ8I?=
 =?us-ascii?Q?9v3EkrQzmS30jNY7ajOUegqJbHBTgs5J+pvOt2/e+QM8v2HcDBW5KT5/KXtV?=
 =?us-ascii?Q?ccKnZbrg1TMaD3zOFKZqrGzGEXq7cowjyi987b37L/wYfGPsPZQxCvB/XjoH?=
 =?us-ascii?Q?R4MHgYQVKBRSL9i4kA21V3+QDdEZXOziAYnTiKqoxLkYPi/2pqMvDwKFfxmh?=
 =?us-ascii?Q?G54Pxqe5jTBzCIzVnnm54wB7aul9exyHoyshHJnN1J1zI0/WxuUtQqxV69QT?=
 =?us-ascii?Q?M/sIS7IcQ3npBdbO/H4SBY7iyoY6cSsYCvtbKmqug590P/UJW89sOGtgimh9?=
 =?us-ascii?Q?pmHtPb1jscbKPRQixlvAT8xEh0hH8+d1Wy/oObugjVrpay95blXiEmoQfaxW?=
 =?us-ascii?Q?TcyNshotGgcoUMIQNOTdUhl4dJXWy7yCJOxVmd3wMmSKpC7zV2vC7vMnu6YP?=
 =?us-ascii?Q?crK30mExJgvdpBPayaarbv+uuCQjBYplYgmLb9rovuYQlBBPTGMKY+M9Nitx?=
 =?us-ascii?Q?TXx1jxRWzwGx9ChTSCi0amdnpzEWRZcADtiQwVd9Q5O8ePml+uJVRpVtWqcL?=
 =?us-ascii?Q?wgGwiP3vOX3cCREF/61HsqVB7y973LjIxK2gGMYgiCO1hcWGw6i7jW2V4Mjt?=
 =?us-ascii?Q?vCC79dzdlGjIOMtUNeMbrOOetVwVPIV1/dPugFcRfL7aZ/HLiNctCFGUJs1e?=
 =?us-ascii?Q?VG34iubICaF6LjQI0MiUS8P7YHG4qOCAmHBy8eVyR9xKMgsN4RQLrC/h7Eqs?=
 =?us-ascii?Q?TI+/oGl9bYW/Eo1kGVKQwRhPIPFAMknHLuuWOD64TbA6kEc3iLpTb9y84zbw?=
 =?us-ascii?Q?QXxyi1HwaSgUDx8VqSuBJNEIj+KXXqDLXek6v4z0bnm0DlxKxzrTggIcFJPK?=
 =?us-ascii?Q?3GTeKGdCqTVGWIM8IPCuQUo65Rf460FayBcJ4+DwM0qhbp+qWjIisGi3KEU+?=
 =?us-ascii?Q?sh32VgrJvA3z6kjG7ITnG5RuqAJBgDEIX0Q4r+oqKlvJ2vdOLaZ4jxNwHFP/?=
 =?us-ascii?Q?T9dw6n3cr9E10pYBEMijcLNm6EuITu2eKOGO78FnFDPBJPxHFt+CDoRyrFHI?=
 =?us-ascii?Q?+hIZ4vr0vgdCYAFtTNpesJMd9IjQjMdIpSVa8Qy6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ff3397-a8b6-4f74-46f7-08dd70f2d687
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 07:57:24.4627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzJXUXnYzQLs/VIbGR3NH+GwX7A8s1ymWfGYw0s75FZXt1S5PDI8H7BIAw20K84B1og+uTkJO9myWFIZ9xY1zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8020
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

From: Viorel Suman <viorel.suman@nxp.com>

i.MX95 System Manager uses interrupt driven communication which requires
the caller to set Bit[0] of channel flags to 1. When transmission
completes and the previous general purpose interrupt has been processed
by the other core, i.MX95 System Manager will set General Purpose
Interrupt Control Register (GCR). U-Boot polls General-purpose Status
(GSR) to check if the operation is finished.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/firmware/scmi/smt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index 67d2f450024..3253f4211d6 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -20,6 +20,16 @@
 
 #include "smt.h"
 
+static void scmi_smt_enable_intr(struct scmi_smt *smt, bool enable)
+{
+	struct scmi_smt_header *hdr = (void *)smt->buf;
+
+	if (enable)
+		hdr->flags |= SCMI_SHMEM_FLAG_INTR_ENABLED;
+	else
+		hdr->flags &= ~SCMI_SHMEM_FLAG_INTR_ENABLED;
+}
+
 /**
  * Get shared memory configuration defined by the referred DT phandle
  * Return with a errno compliant value.
@@ -48,6 +58,9 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
 	if (!smt->buf)
 		return -ENOMEM;
 
+	if (device_is_compatible(dev, "arm,scmi") && ofnode_has_property(dev_ofnode(dev), "mboxes"))
+		scmi_smt_enable_intr(smt, true);
+
 #ifdef CONFIG_ARM
 	if (dcache_status())
 		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, MMU_SECTION_SIZE),
-- 
2.43.0

