Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B42EC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 10:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78327846A4;
	Fri,  3 Jul 2026 12:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="XNkVCGbJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EA578496E; Fri,  3 Jul 2026 12:13:01 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C0C1841F2
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 12:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SC7Ab5+unB1k/spDj1NLCUYdCzU/4bP/77SBFSadQ3CHikMAUR5BIGefQFHvArVeZHuNWvh3tXQpuCAY3IZMD6PJPW7hPbjPGTwwcPQjtrr46VK7gGL+C7JgIH8rCMfYrDuXTcixATlglDCfuzKSNyKrspVrriRmtXHDE5OOz4yO1TEtTOOOObez3uslt6p10lCQtmVci2YJD+JlVuni2PmJdCkoD59TIKh7RZXEF9UjQZhrlUUMp1umMp9gLxadSVbk7B8+87tzREb3w5+zSO+mu89G201Wcx9XbaPPTdJYpeYW36q2vNT+Ir9I7Zx0mTndz+rdIQSrkwqScn3m/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wW4d/LYsSrklH5eyN/8QSvdcffaceiisDLvuvw1RIrw=;
 b=gFAs1daXwScXKjh1ueYVcPH3Mkhg6ynb/63Okn0UGcsB39E/zIYbUSQCFW96Tzb6MogAvFSPkw44FsJmRlSYASMxCSlpY1hCR8Ugb29yOoRavO4dUm5ulM/nzO7WMxcZhjx0sy3gqKzNLQp6bBTNM0rIpuuQqXBzfnvKGl6dhWnu8OLASd0gLvobYvaAKbeJ5jNW+x/CcpqLCHhsYfFBovSx/1UtS/8jvj+nAmYp0L7lvFbOcEDofCY4QZRJWIN6wj9WI8gNdPrjugG0tNok/O/hUGvI8G6+STl5Cgyq4LmcnMwokno6UjuMy281F9/jwIPxBk0gQimT4rC1UdQxrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wW4d/LYsSrklH5eyN/8QSvdcffaceiisDLvuvw1RIrw=;
 b=XNkVCGbJVybgleUgPCkgBuzJ0RKwIEFz5YK17tkkmYNAhW8LJmNnXxyHfBtaeNph4aYkFBas/4mcVc8umFicIoWBlylUF8QVgpwrJp4Lo0aAWlqyA+9sxWqPGS+30ZdPeP3L5xlkqtBlQQsWOnsDO66qI5yBQXa4RENGLFH/kXDtesnwMzukwIK2siE96pZOMgKLvAcHfhd6+7QZqgUBOoy/e3S8h/wrjz/zL7tATi0AQlrm7X4t1KqK89fcni5M+2b1dcFIlWHjuY4dqcBVZ1MC9BiDaI44XMnYiFMZm2YXfXrsIY0xCoEd2ZVosPylHuJpDS9SCPJvGMjkZpbBlA==
Received: from AM0P309CA0014.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::25)
 by DBAPR10MB4042.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1cf::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:12:57 +0000
Received: from AM4PEPF00027A63.eurprd04.prod.outlook.com
 (2603:10a6:20b:28f:cafe::1b) by AM0P309CA0014.outlook.office365.com
 (2603:10a6:20b:28f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.6 via Frontend Transport; Fri, 3
 Jul 2026 10:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM4PEPF00027A63.mail.protection.outlook.com (10.167.16.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 10:12:56 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 3 Jul
 2026 12:17:11 +0200
Received: from localhost (10.252.26.28) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 3 Jul
 2026 12:12:53 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 3 Jul 2026 12:12:44 +0200
Subject: [PATCH v2 1/2] cyclic: replace uint64_t by u64 suggested by b4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260703-optimize_cyclic_run-v2-1-81762cff0b17@foss.st.com>
References: <20260703-optimize_cyclic_run-v2-0-81762cff0b17@foss.st.com>
In-Reply-To: <20260703-optimize_cyclic_run-v2-0-81762cff0b17@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.15.2
X-Originating-IP: [10.252.26.28]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A63:EE_|DBAPR10MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e6156e-06ad-4927-c9b5-08ded8eba735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: VjBvVHe7R2i8Fia4ZloKhlO20i1/alb+IDT0gc/LsmSy7qfnK3LcuseIz0WqL2VdnIokqYLFGHKD3JLM0VS4OekYsSNhgQtHN5T6RrdUuEkwlFX5kBriulk0fjjtMqYRaycQcUY4s3QswNJADu8e/VGCSZIexQv6nZpvSs10ByEILaH1b7HoZi8I3lhvE/XJNb+91nwhlWvRCynmQp8O1RvAeBoIzmF4tihMIfrvLvzPrFAyJQxv8DQfjECjFXPcBw97Uz9bLu8L/0PEQ3u2e/YT96s+35ACzm0hTojbfsWdbClne3a7g14J3WjO94/gjVUPAF//9CQtGUET42CX7v5Q/Go6D1LHFHHFsGMnS8YnPBTZYldplSYpWzSoLeDZCQblUomgrtIzG2fzDkHzb9a5sE9V1tl92Nho+Tritv+ihvtiivobDMPjrUzPuR+G0AO4sgtqIAeA9GkY5uFUl25Bf0TOQt+btKsTJzJcy5olW0j/QdExcEL9QI+V1hIpYggQvfmUPELOLN5CaKwH5TyhJp/tYE4cRkuhcYVpxQXOsu9gIpe32Z2EBAuWUQ5jtppCMgcWO0htMUWEzD1wL8DRkhTt8GbKmv7FH1EPaFUTxoxnu8pYUjqYr51Vg+8t27I8l8+7eZd9oSjCY/K9vCgiSvVaLIAdlhd6LeTv2gAS8E4+nub3I6JJhdUanii80E/7MxCnR3htC32xOcrqAg==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PxQLOWkPI6nqqGc9zADMy7jNwvuAwGrmdWDi8ix2hzIIUe21gsxqgIxBpcc9mp9Gzto17lwgM1i/pZMasbrcr7qjoj770BjDvBj/f9RRWcQKu8g0MJHbavgqJHnHvQuUq/nfUHm9+eGG21NXM9Ox/kVabQBrlAoEyIAK8w218qn2gS8zFQwX/INy56xZTidk2lp5kDonHgort9PWWABFz7NK2Qfjw/fNV8kv9ImUUkewLHJT+BavXH/tAVrFOrCbjgTHC+FjFupkAu6dNVJy1aYmnx5nxy36QPOYfqe1g3ZA0YQUqP5ud3KFDi3Qn4jXNfthiU0EqgnPpMpm/3OXolv/F5pt9adZ1o8acd+tvt/ctLd8hLw/fSnEgcPIfgX7cvTJseYr8XbkhczGkcvjk0XcKH9PEOm1yngKXymlqLoX2J46TdSG+H/XO+PKH7rV
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:12:56.6555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e6156e-06ad-4927-c9b5-08ded8eba735
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4042
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

For new patch, b4 is suggested to replace type 'uint64_t' by 'u64' :
      CHECK: Prefer kernel type 'u64' over 'uint64_t'

Update cyclic.c accordingly in order to be coherent with following commit.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 common/cyclic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/cyclic.c b/common/cyclic.c
index ec952a01ee1..b37cd6d8ff0 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -41,7 +41,7 @@ static bool cyclic_is_registered(const struct cyclic_info *cyclic)
 }
 
 void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
-		     uint64_t delay_us, const char *name)
+		     u64 delay_us, const char *name)
 {
 	cyclic_unregister(cyclic);
 
@@ -67,7 +67,7 @@ static void cyclic_run(void)
 {
 	struct cyclic_info *cyclic;
 	struct hlist_node *tmp;
-	uint64_t now, cpu_time;
+	u64 now, cpu_time;
 
 	/* Prevent recursion */
 	if (gd->flags & GD_FLG_CYCLIC_RUNNING)

-- 
2.43.0

