Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF8FD10F58
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 15:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D08968389A;
	Wed, 26 Nov 2025 16:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5I7SI+rC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF2E48398D; Wed, 26 Nov 2025 16:12:51 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D68618312A
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 16:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZDLEluseMA7fmA0G+ybFNuQqJPeLYObKWkOatUwKLsd6A1keRMLcPS92HRENxivWcmTAq6ra7jqnidIrXbPiW9gBrxIPa24NCmj5zYJwHKwWZ0hmG0b9V8VRNanpq3PluEoR8LQ+vWHqFd77Lx7+MZf9BKfLSektzj4COvNeF//ZE1EU3Fk7IY4Nkmyds5415EO6shbjubj8GLCl06NDB4t5/+QvfduqMgwiAX8ZKUTpgPvhRIDqg0qGT0elDXjKwV+chrJi9ny3drk0sGqIt1zNeiZ1uioHvjdAxrwUf0lmAxbY627gEOhkoQ91IXG+ZQrslZKlkEqFPKiRp12Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqUT7X5bt9p0NxcB/4GVfUeJUUad48jX6zTQuoGycAo=;
 b=dIcak0nl3cdWjI8HyaMQmNgsb9iANB1SEjy720rnQ0n/tzuHG9IVnCnJrv3JWHCQOUn/hFNFJzrjaX7tNpab6o5mZEtm1N3Ie7V05iL0RUjAVzH5qWuKlNp+K/HPJ1WW+aSLDdLN+6cR3EXrvP2ulbiQlBDLQ0s+6aV96H7jnGOExMzeyCCvRlIZe/Ce2kZE1ujj/opRDiQOjBnngaBMe5o/MXZDzIEhxIDkZsSeSGuJGSotXen5WBxG1iQl6LSpRyt56aZ6CazfoLat5YXayvrTBCDZeiAXVJeV1kNnWObo9h+ejUZlmWSg88uLPuRst3+mRduKRSGH4eDkltprBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqUT7X5bt9p0NxcB/4GVfUeJUUad48jX6zTQuoGycAo=;
 b=5I7SI+rCWo8U0WBRegk1V3sJnEJh3eG+8gGs8I+xpiilvFJGbLAv1ES4chzSI6cjrNqJmKhFwQDzDMWBhB+wMTZIZ1rdoNqVcrrASHDQgz8pOaqTGJ63sZiW/zSwpzvllsYk/BNqR559n/hfK7/yi4ubJG8uuIUXDlbsyI/J7J4=
Received: from SJ0PR03CA0263.namprd03.prod.outlook.com (2603:10b6:a03:3a0::28)
 by BN7PPF28614436A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 15:12:45 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::fe) by SJ0PR03CA0263.outlook.office365.com
 (2603:10b6:a03:3a0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 15:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 15:12:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 09:12:43 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 07:12:43 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Heiko Schocher
 <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] i2c: cdns: Add timeout for RXDV status bit polling
Date: Wed, 26 Nov 2025 16:12:35 +0100
Message-ID: <ba53d57c179f3390b32bc6094f3ffb5f4cde931e.1764169953.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=9Wzz5OTg7HraH3V7hYWaxa+yO3JN33yZZ19pQRm4X+8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSqSzz5/W7Z70UKjhNvZysVS+n6dh+X3nXBYlG509WzW
 wLOvTgb0FHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATWfGfkWFX44GF147sMn+7
 MeTOuY49edMEJc/b7hDutL11NupL+P6fDP+jzP5Pv8q86fmmpI1M84Kz8kQSf9z2t2pKv23Xl2j
 ROZsbAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|BN7PPF28614436A:EE_
X-MS-Office365-Filtering-Correlation-Id: 0031b93f-59ef-487d-a449-08de2cfe40b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FxZYEx9u+u0OcbRP9N1B4uwJbW2ng0Yj0Wet1YboVjmC4tFZcftw6MbQHs0U?=
 =?us-ascii?Q?EIH8s2eh3sx7d8iCDh5WnMkf3TI0vTEuS+K0CXdVyXSqBMpQRreXKPiiJ59l?=
 =?us-ascii?Q?UfjNVM4eTvTtkcvNuZSYJ0arEc16eZtc7Wqg6lwDwxJvuswPejjI1Z2gz2nc?=
 =?us-ascii?Q?38sJZWWCIxSlt82lBexhOWBCSz8iZXI5dMO/yKGeai53MbE03GsWHME2e2QE?=
 =?us-ascii?Q?nSbt6xAx6LNy+dqdGq6Y1LoTYaxnNonhL616hDIg/37ee5NFERp1Fcpn1bfm?=
 =?us-ascii?Q?f8fpGTw+uEnYi5uYCNPLE5byUJiuztpYrBghfXPBs3y7YM7j7e4QairnC08O?=
 =?us-ascii?Q?aJflgcORu6fd371DvwLho1YI64nbzmtep7R1ncPi4rEDzqKIXfRnVW+qOg7M?=
 =?us-ascii?Q?jJch4wgWChuyddu/KgwaAAhsztqXIvadjPwXB2Str0fKW1r34F6zKKlbPK+m?=
 =?us-ascii?Q?xOO5OoghTDEcXZTYFHcuM+NtUeAgOJc/86WTDwV2qM/WHsov9nXTw02Gfv9A?=
 =?us-ascii?Q?+YaGvla9ojvxuk/aOU7IGB+NKVs0N3wFJ7ooIknlKZ9+HeKQmOxCOtqTC4iP?=
 =?us-ascii?Q?qlvngRmnj44VCxiLuB7VxutdjtrtoEaFiw7Dvs0mShMX62wtCaw3IokHCsoj?=
 =?us-ascii?Q?DnCupTzA5bHkCUHKTKEPqxXS/KlBk+N6HeUtJhQMcb4fGrDRRZIVQe7Tnp8Q?=
 =?us-ascii?Q?BnfLGwmaSB6G4K//faXVsAW88jd2XW0DTYgRTCwdsOlDR9OQbLNek3lhStZE?=
 =?us-ascii?Q?Y83ZiO3EmNmwdPN/p6wkZqBuZcw/nGBBG1OCVolbr7vMv8cyE0Iddo7RlztW?=
 =?us-ascii?Q?jMgZdq82KGjYaLrEakUduUpbQpZAxn3U2N8My8U4PZosAS/lSijG31PlndoZ?=
 =?us-ascii?Q?idKvpqCi4hq0dnL2i5PLsX11t6KyE68cGpAP4MK1jEZmBzPdvFGjS+KwDSJW?=
 =?us-ascii?Q?4g7yLP052FBfxUnlQdaoUa9ExbIdvHoFOsbSthkR2fPT2+n8BKfIBzMW5mgu?=
 =?us-ascii?Q?jExuj5fCchtTXaPBVZe+rMsfaNyMkhR+VzKRlrVwygniEKvuRwYr5erGBOZh?=
 =?us-ascii?Q?n3NtU87AekjuA6s48Lw6oAuKoXbqlgAdDQjNY+X6zSstpInrkzJK6RoYTc0B?=
 =?us-ascii?Q?TlqAfLWhE9xqAI4E2EvcSyM+2guzB2olN3jOjtVQ+TDELwM2/9S1WG+SoTXz?=
 =?us-ascii?Q?5p7QuHzaBGc5P21VVK32craiOdZ8g+2yEck4Rqi29Bx+zsEKYiaXdyJqhrzm?=
 =?us-ascii?Q?f+S7bvEZqsrI1MpkiHG2VKjncWC3Fxj177nUCWIU/2UDiy1Dvl6ecjPmsYhz?=
 =?us-ascii?Q?CUT8pARx1Mlo++lwbJQev2usdWSGpaRmdv92x89GlhbUJq9W8H0LKiP1NdDo?=
 =?us-ascii?Q?a6SGZ94XlxVzaIh18DbNAkSd27NunDwYOkjw4u/JIdKjdhpIiXGW3wAcEJ56?=
 =?us-ascii?Q?ifkk60gBEkUmazBj89y+Nh9DLyX7hOacLE8J56olsKFDkjvvLrjMTrPmqn6w?=
 =?us-ascii?Q?Yc9wt32exdNSD0mFVpRzQ3N5/hpTvcvsKg/Iz4EDeKJf0ekUw9KuATYSLZpn?=
 =?us-ascii?Q?oDy+g5iVJ/bpZI1IAA8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 15:12:45.0732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0031b93f-59ef-487d-a449-08de2cfe40b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF28614436A
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

From: Padmarao Begari <padmarao.begari@amd.com>

Add a timeout mechanism when waiting for the RXDV (Receive Data
Valid) status bit to be set before reading data from the FIFO.
This prevents infinite polling loops that could occur if the
hardware doesn't respond as expected.

The timeout is set to 1000ms (CDNS_I2C_RXDV_TIMEOUT_MS) and uses
the wait_for_bit_le32() function to poll the status register. If
the timeout expires, an error code is returned.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/i2c/i2c-cdns.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/i2c/i2c-cdns.c b/drivers/i2c/i2c-cdns.c
index 3f7cf8533ec7..4e9d4e44899a 100644
--- a/drivers/i2c/i2c-cdns.c
+++ b/drivers/i2c/i2c-cdns.c
@@ -85,6 +85,8 @@ struct cdns_i2c_regs {
 
 #define CDNS_I2C_ARB_LOST_MAX_RETRIES	10
 
+#define CDNS_I2C_RXDV_TIMEOUT_MS	1000
+
 #ifdef DEBUG
 static void cdns_i2c_debug_status(struct cdns_i2c_regs *cdns_i2c)
 {
@@ -349,6 +351,11 @@ static int cdns_i2c_read_data(struct i2c_cdns_bus *i2c_bus, u32 addr, u8 *data,
 	hold_quirk = (i2c_bus->quirks & CDNS_I2C_BROKEN_HOLD_BIT) && updatetx;
 
 	while (recv_count && !is_arbitration_lost(regs)) {
+		int err = wait_for_bit_le32(&regs->status, CDNS_I2C_STATUS_RXDV,
+					    true, CDNS_I2C_RXDV_TIMEOUT_MS, false);
+		if (err)
+			return err;
+
 		while (readl(&regs->status) & CDNS_I2C_STATUS_RXDV) {
 			if (recv_count < i2c_bus->fifo_depth &&
 			    !i2c_bus->hold_flag) {
@@ -452,6 +459,10 @@ static int cdns_i2c_xfer(struct udevice *dev, struct i2c_msg *msg,
 			ret = cdns_i2c_write_data(i2c_bus, msg->addr, msg->buf,
 						  msg->len);
 		}
+
+		if (ret == -ETIMEDOUT)
+			return ret;
+
 		if (ret == -EAGAIN) {
 			msg = message;
 			nmsgs = num_msgs;
-- 
2.43.0

base-commit: d9f73d26af832e19dfd79a4b7bfcf09c498a4873
branch: debian-sent3
