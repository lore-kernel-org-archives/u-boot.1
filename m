Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14BCCF855D
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 08:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E371E84067;
	Thu, 20 Nov 2025 09:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="QVUS3jD5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C5EF8406D; Thu, 20 Nov 2025 09:39:16 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ED3384062
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 09:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlG/Rq+jL/lnwjzpR9p7HbGQGTkeZnY7rBgrKrwusjpgvxj4kVEtU7BHeahTGj3JnK82t8d9ty0Iuq0Dx4yZUzB6W+Ve6HYw/V8ASGNfotqzdTLjJVrC9TavxbZQybRdCHLz6JnNQeHetEd22U1kN6brSzlO3XN9GZq1/Y3WbA9meqadbxF4CWfPXyBApjnmAdCTFJ3KsFetq1H4xWlQY3wt5n4q+oYtdpfCqqzaE9oDf99SChQz7vppXT2SeWv+uLgKNDsspp2hwVxJLeROXVcs0rtwXinWpiPytPmzf6Kef0Xq80BxVdYKnnpZDC/UhT4h1OF3MDzqnAc/rcQ0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6nTtEVvPdM/vqRu/yOzCcHaVA2xo1+OVZO652EoXDQ=;
 b=OmkjgSSP5kHr6UdFk6qZB13CZyNjFLn5x8MAnblxY2ENg/cFJ7aHHXlYXPkqPuDF+NZq6dKoiOSP1JYhZaT4BZ+N8/pLc/2ElC8Cn6nAE3oY3T5bLbOfpiIw+7/G88avXwRK7hJNPG7jclpRxndo5a2BMQ/c9zafIzKJDaWQUAm63IjI4TPq3H0oxIti5VQn2kY8UASiTgCOrMvEcXwv5i47a7Ar1ccfRCprdJbm0F79Yynx7rRm9CCbNTjQ+XrIp2oAAyfxUHFjupYnLUIi/c3oWgxGFqPnaf188xBfsSrJl6iQb0Z4IZ6NADfOCuNd3BqnUC85u5+rv6TTpSRBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6nTtEVvPdM/vqRu/yOzCcHaVA2xo1+OVZO652EoXDQ=;
 b=QVUS3jD5myWCjKWrpvbSHaxf5eYF6bmyV0LtKpuvPhK3qQ/XSOLgK5jE0OI081B+kIfLi3VcmRmjsHT3s3zgwWTm5xC3WVb5mXe4NOpOBzDN8Hm1GQ/QpIymZmu0ShMa9azJ3o+VoIqSE+Zg8HEWk+QW7YXA/Sc9I0OTwJTmoCaXheRJDut8wYuD1bWaykMjiMB+YAd16zvPap4xXhnhVxmIdXOzQBcvt4WVBnaitUgZnxY81rr/dbXsUt24/M5zIqVWKyo/qz+LaMl/sl12tngflxMZI6g3O54X3AtCzWeCUuGTJYjan9U774cepLpyQpS6Oeztyppms4GaotBYyg==
Received: from DU2P251CA0021.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::24)
 by VI0P195MB3250.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:31e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 08:39:07 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::de) by DU2P251CA0021.outlook.office365.com
 (2603:10a6:10:230::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 08:39:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 08:39:06 +0000
Received: from llp-anderweit.phytec.de (172.25.32.82) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 20 Nov
 2025 09:39:06 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>,
 <jerome.forissier@linaro.org>, <y.moog@phytec.de>
Subject: [PATCH v2] net: tftp: Remove tftp_init_load_addr error path
Date: Thu, 20 Nov 2025 09:38:55 +0100
Message-ID: <20251120083855.2350372-1-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.32.82]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|VI0P195MB3250:EE_
X-MS-Office365-Filtering-Correlation-Id: fc20b8ff-414b-4c02-5ac2-08de28104475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YOZvfaSCC8fxljEbQAwD4KO3FmUfMLzaeoKQosP1fPmN1yADDiDLHC8Zp5LV?=
 =?us-ascii?Q?PSBGAg5WZnUJIWgjS+1m+V+ZnBddJ0ZCh2gVqBKXqtP7P2fwmB2myu4WZB15?=
 =?us-ascii?Q?vclyt6C1P6CjA/bpHFu7/M+KiT7Rh4HzbKcuS2BkeJHnSATqqOPT1rSgxId6?=
 =?us-ascii?Q?hpLNC5sUVCve7x4259TdsxP0qlf8yOBk6s5LCm/s2LSEZfiwzHnDOId2Yx5N?=
 =?us-ascii?Q?NpDI3HOlbe/1ilHxk7yocG/F4EagYbS6c+dXQNxn7bmzTVmy3FphQL90bqX1?=
 =?us-ascii?Q?tm8XNIbSa2/n9RG/YzPVC4BllzQMzRHKozmz4V8zBUnIDZlrWqWvD8OSfiYi?=
 =?us-ascii?Q?QWGNQhMwqfUYS0dQxYZd88aSfxQCCd+kUeEq7gofIPbSC9XfK2rd3EqF7PGk?=
 =?us-ascii?Q?4z0ANM/88RFFZgPOmCn+budXnEOm9SOeiMOgb+nda9pUiWf6nmdbYi7WNrhg?=
 =?us-ascii?Q?xw4eZsOotbtBOLS7Rc8Vwy73ZDPmb740McFGj6f35EUldJ5emSIfAGfydOYT?=
 =?us-ascii?Q?6N90+EE4u9+eEFGB6/Vodk/0syqIK7Jmt1waJsJX7PvFMhP/TSHka021OSyx?=
 =?us-ascii?Q?Y496X7I19XG67YZNn6a1t1OjXiTEg9t3TPvNtGT/brHO9wBcyNSq8Ucq2tt+?=
 =?us-ascii?Q?089mwTr/Oq1CL+d/1TNnOg6mGSOI7v16nZl0kIDlGzJ08LXQWiZoJdqWeJTl?=
 =?us-ascii?Q?/HP+s40eB+OR+pnyWC6H79YYLOxNQQ+8RTWNYOJYeQEkJSmWZnkj7U6nZn2x?=
 =?us-ascii?Q?J1kPfXupbNWyDYN/37f8NOiNNo2GTcAnn1XYgdEKToY9JrQycTqqT6/IASEo?=
 =?us-ascii?Q?kXa1/7df0MUlCS+1Op0agRtEgctCr51NLlfpM3XiYc35DiZQ+e513TWrdaNf?=
 =?us-ascii?Q?nOWHrwRxha6FUW1KQxrC/y5dA93jNHLREM3bJItuoDy84gSvcZ+BpcxcIska?=
 =?us-ascii?Q?BWQo56b9gucc2WsHGtcWjP+hA5lGh7apwmjWZZ4NrhII8uCjicmOZfoCphD4?=
 =?us-ascii?Q?y7pScenFkS02xK0VQJ9+wcRnGSjBrWJ0lsuYcArOfhWwmOklD0O/vAK45wyr?=
 =?us-ascii?Q?kLhvaFcB3DmB0xBBvFkjPGXMkqk2zL6b3bdnXT3eLAn59X7pt2RYByZU+trB?=
 =?us-ascii?Q?mmgHPI2PfV7RxDA9wPgkVr38NblvF6YYuRU9bOqpfLLHwYFO5KoOnPM9eiAb?=
 =?us-ascii?Q?VNLicx9L2kkqB5cSTtQ+22OB0TkzRpoY/96LBMw6UPAjhTQRgawm5Bmj6BD2?=
 =?us-ascii?Q?JgsDJ03n78gUfh2aLzufbi34G4YQMxqPE1MmoqCgtpmv2aAOs3201TPNDCKN?=
 =?us-ascii?Q?aCWr/6OV828/iARp5t9AcdF6gCiLkb6jh/8M1aLPw845cGBq/RkTbwzPTvcB?=
 =?us-ascii?Q?HRbK1UAoDS18hojaLV8Kb8pTxpKpRwVJF38yCDvAJ93Fa9/nGNbECXoEIUHj?=
 =?us-ascii?Q?mUuD08qEdVSS5MKTLSJIKu7UMWAv3C0nLj1gBrxdZsT/Pvj+AclP5gdfnCjM?=
 =?us-ascii?Q?v1inkzAO2wb4dt6pJ9z5uxi+AoWLh+PYF9KOT2C6zAiwvHJvU8cRNsOU4mIy?=
 =?us-ascii?Q?Cg2L5lMvdjt9p0i/pnM=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 08:39:06.5624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc20b8ff-414b-4c02-5ac2-08de28104475
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB3250
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

tftp_init_load_addr() always returns 0 since commit af45c84871e4 ("tftp:
rework the logic to validate the load address"), so we don't need to
check if it failed and can remove the error handling.
Also change tftp_init_load_addr() to static void since the return value
is now unused.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
v2: change tftp_init_load_addr() to static void as suggested by Yannic
---
 net/tftp.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/net/tftp.c b/net/tftp.c
index 1760877107fa..3b0f4cd2006e 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -714,10 +714,9 @@ static void tftp_timeout_handler(void)
 	}
 }
 
-static int tftp_init_load_addr(void)
+static void tftp_init_load_addr(void)
 {
 	tftp_load_addr = image_load_addr;
-	return 0;
 }
 
 static int saved_tftp_block_size_option;
@@ -901,13 +900,7 @@ void tftp_start(enum proto_t protocol)
 	} else
 #endif
 	{
-		if (tftp_init_load_addr()) {
-			eth_halt();
-			net_set_state(NETLOOP_FAIL);
-			puts("\nTFTP error: ");
-			puts("trying to overwrite reserved memory...\n");
-			return;
-		}
+		tftp_init_load_addr();
 		printf("Load address: 0x%lx\n", tftp_load_addr);
 		puts("Loading: *\b");
 		tftp_state = STATE_SEND_RRQ;
@@ -953,12 +946,7 @@ void tftp_start_server(void)
 {
 	tftp_filename[0] = 0;
 
-	if (tftp_init_load_addr()) {
-		eth_halt();
-		net_set_state(NETLOOP_FAIL);
-		puts("\nTFTP error: trying to overwrite reserved memory...\n");
-		return;
-	}
+	tftp_init_load_addr();
 	printf("Using %s device\n", eth_get_name());
 	printf("Listening for TFTP transfer on %pI4\n", &net_ip);
 	printf("Load address: 0x%lx\n", tftp_load_addr);
-- 
2.43.0

