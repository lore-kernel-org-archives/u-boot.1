Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E38EFA0C26
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 05:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C074783936;
	Wed, 15 Apr 2026 07:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="a+9sT/IH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB8D83B99; Wed, 15 Apr 2026 07:18:15 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19138838BB
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 07:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kcou31izIh4hONu2d1c3BGhg1Kgn9Cov+gkymt+ZHD3TWmptmp+d0KruGiChxZapmbNeJQr++oF4yCgC/8trgEQF4xUi1t3EiwPjNgW+y9/fpRYCxEgYb7T+POFAIX9/n8sMOdTok1HGXVmLFnJk76cDn/PG/KkcFHNVa9YmjnAxXd7u1cLbpQfne3bm/OE1bWvMIu41vHukH9CJXfFfNw1F0afZAgwqcOYnG8Cgomb9dYxIjVhfuibLJfGvyZryI7SyjpMptYmKLQPVSK0nBFzIq2UDDEtNQ+ThzRrczQtx33q4w+19gRQLsmPF7ttgnjdOhroIRzMbdCdoW8jU5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP24m9lqBZ1f1WMRWhYcBzJFHw+YhqJPiWPfb4acrS8=;
 b=HT/DeRwV5FVYl8i1LSzdesi8mUwcxkbBmbLOv9nGGk+2ibi1SOn91zQLpx7/BfKpL/36UzdKkY/TYlSsr2/I8y1do6Gp5GbKZe0CJNopNwQ6RUAxdZ0JYz/CQFNTOiDTDLp7DIt4YIjW63xxf4IB2d0ja9U68wIRBAjD/agTy6jVDWwWDveKhvKL/v001zNgAOIEimx8dTHKJVKj4/FvHWkBd3XAALnLcrBEQ7hqDzARcERQ6KeMKDGoVyt0eY/8KuIo6sdZuwAJUPlNUsKeCu3238rDCAfVjbiEd8I1vEWbbRduBUtRdK2XhPeZXVTFF36tqQ9l1u47S+1rMJrCBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP24m9lqBZ1f1WMRWhYcBzJFHw+YhqJPiWPfb4acrS8=;
 b=a+9sT/IH1wdkgZFZ5uGOLSwQNjBMcye/Um29FcXLRqfRk7pk5AS+ZLlLiQzkHkauPjGdpzu27IMAN14cKlkCaXV34lj3J8gVUw2OW70NSR8Uj6F2kD6bOWgsxDtL7FeHRO7vjk0dnbdF+RpCwH1S69OicijBknwLpBiIppR4XauEgBhaBRyTxE77SBgg6cgP3aKzT6rrDzyEpW4bg6t5V2IJVhVtHax+cggFFBri0JO4QvDQ6LLCDOUsRwIBLDCfI2KEexOxQ+Ss2HZBY3WccgWIMPdLlM+sJ869P0G03SahXalxcYoGAOGiUmGttTzYG1YlKmFR/4y8d79oL8jNog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CH2PR03MB5222.namprd03.prod.outlook.com (2603:10b6:610:9b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.41; Wed, 15 Apr
 2026 05:18:09 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 05:18:09 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2] drivers: fpga: arria10: Remove unreachable code.
Date: Wed, 15 Apr 2026 13:17:20 +0800
Message-ID: <20260415051720.9679-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0380.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::25) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|CH2PR03MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f13a202-f1c2-42e7-543c-08de9aae61f4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|55112099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: M15M3yqJ9Aw7y3z4Wr3dNbWWbcViRNppWytxVZc1WoiOZpNFaplx6Ls5s9d6bjvEEB+zBFU7uprD9eU4Srt/oRX39GZE1u9OBL9liwPdJp8ZCL6g0AvyBZ3EW+sjxdmNSpMoD3iIZJfrJfkfiVksErEFxcdMy8PDqg2myfrPC6OVzCSBOzah6ZuGbtx39ZJHRVbXoXJLTobhFbIBdvnKKcaa3JO/oLdiUAHuGt3u9+5sgCPMUQ7qO30QYjoRweO5KQiRBPB7Xj6VZIjp7l78bee2+EnvCLU+KOHpK0KZmR66RtOU96X5mmQohok7X0xOX85N28embIgyDLnOwHowa77jzEoYOyF4FsKpAdeabHqVXYEoS6QkVo+FpRxiIAKHyAjGZC3wfix2s0JHc0O6E9BVyaFLN+5njVmCCmsL2tIINnOeIeL9JVviW8PL2xVnFpIyGDo5rXpWeLouaMx0JDtsp5oP+jXwDgvcBTR0yEOupQWTuiG27NjgRQgszaFjuuYxjxqIRUGvdrnwUecrBlfsGKRW7QmsJcB5YIeITb2KW29lf4/OkqzHIenNgPBC4DQAaIhBpMrHpZL5/g/9cz79AG0kfeubHDacjJJ/x+PgsawBcma+tl8xYYT9oZPywxMSd1/44uDtcNIDFvPIwhJXLAa3P0uO2+RXf3yjZVWEHwADJdN1GIxY2aP+6r3Y9rhwTQ7/z64RV+yv9Q4jgVjVMt9q/PbOwVH1BSGVJFA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jdlOpcvmBobhnX9c/Uss3Rw2rNaNcf3kIxffX5cEO96UdJ4zYZf92zl0KflP?=
 =?us-ascii?Q?R/gtkAliQBePXBEVGUe+uuVrhkOA5PpgW491nDRBRyX0r25e3L2mBuKMqeeg?=
 =?us-ascii?Q?4PGMKnFeJMHyY6ZnL43gXrxh/iRI97cQMXXqm6UUXgNuysIhpONaakpQDLn/?=
 =?us-ascii?Q?2vvh40vK/TUPjAr6slNlb1/ULINNCrp3j+BiFLXVttCQP2GWAY37NlfvZltF?=
 =?us-ascii?Q?/6dnOfDkiG7QDE8UB1tb/yTO0f0aHt0Dw6Tsv8dvTSexCEeGk2dAXh5gW7RW?=
 =?us-ascii?Q?CyBM7daxZfTW/QOXSw6mumTmI64mebzIstB//8C6IFWjd00SCIjJ9O4cE19i?=
 =?us-ascii?Q?tdGUeia+kl1qANwzmSQBNG/A5L99ULL/oEXho7lC5m6IAAPzSaUHQUJwE4ez?=
 =?us-ascii?Q?XFyfQCQPCQdrOpsEr7h7vjZnMR9KSe9g2zK9GhXGOEf5JlO0A3jm1L8W+EyB?=
 =?us-ascii?Q?IaaJc9OEwjZUW0WA5tAe/EXTJcyhVJ1kZWLem4SM3pKz2x061PGc7yCpMGmv?=
 =?us-ascii?Q?f2nBIevSjQFV5p5VMUT0iXrafUbPzACbpxwn1ItXi+USQ3yJYJxNmywrSC8P?=
 =?us-ascii?Q?AbSoYYt2G5bE8ptSfu7fU68ZkLLsg9gP9La8XQo1yF0IMeqMR7epP9QL0LOw?=
 =?us-ascii?Q?SEgvRL981oZomGYMQbq+DzoW8WrDSIzFqC+DoXwCnNY4pYAk0DdiXVGOyplX?=
 =?us-ascii?Q?vowRyO1hfImCtDV378yJS9QbVglEyehHYpi+GWhFWjNYZFJr5EDO4QIsk9GU?=
 =?us-ascii?Q?6vtzSk8rw0vowK2o7r+qRdp2F05ibjzKm8pmzQgiaL32ityUQ4xWrlP5von/?=
 =?us-ascii?Q?EFRco2MZJN3+DZBzTjaJxV7Crv6viJQfvKGL7c8VG5wN3VvuTinbev/WzHkc?=
 =?us-ascii?Q?hC3oGOJFcdRKeFd6N+2ofwl9qNab+wMnENFEBqQTVIKb29N7foNqUTCRQB5w?=
 =?us-ascii?Q?CC+pxRIiAJVTBCUE8SUlsYtXW6Zn0A8dhRKJwGCJofWwyB8TopdTfd/4qmDW?=
 =?us-ascii?Q?9zJG0gpb1GSHPJ6rekCcQZLh/fZmN+wolfJRguPUqvALRHlMzrLBsBD4cNaL?=
 =?us-ascii?Q?Sw/wxs0V7URvqUYMEXb8kUIvCH54U6Rn3NvyvUtP/QxtrADPzyMkkSaylUZv?=
 =?us-ascii?Q?vCewAVRtsvuA1B97qrzetoKoBmS4sj8NeFCOXRTRx6NJFU4hSb801kKDY1mC?=
 =?us-ascii?Q?tw1pns43yAbfwK1OwarPkXJBEwcZ2eSAFkfX2TW+k1vFZXTb+kiFhwSmPpn+?=
 =?us-ascii?Q?Ri/a2xtyQk2bHJaGwD7wIEJGytCTCr0Y/uDnuqtk428BHPW7eI0iKZN5Q6Gj?=
 =?us-ascii?Q?j7tSUS3O/x/v31PPswGr156ZueunYRDJzyY8bQV7aDD+213kNoL/vJQECdTE?=
 =?us-ascii?Q?t28jyo5Fzq/tJf2+AhSXhOUq7DTnkJGVTcfpcs/M2TSBWhvKxYKfY5xLgYRZ?=
 =?us-ascii?Q?+1iVpaQ5C4Z3AgeHPBSWOCOPBDbiM/uZza4ItBnhU3jB9pUDvAHfq1rJEV+C?=
 =?us-ascii?Q?+Vk+jtY3RSMTlcM1AUaedX5ihmtmDrf0+0iSaWvEgl/wuYWzMm1tmJaTnXcy?=
 =?us-ascii?Q?NY/4IWXvyFMMea06+tmspW04I2v6IqnCgIlsbveSyUySQJFJ8EODUc8J9N/L?=
 =?us-ascii?Q?We3oqLTwXbEyMZUlkIsWfFLlI0mRzGSndewZZMvEaXJqO0pSu1nf/7fPz7s5?=
 =?us-ascii?Q?E4GXeEEY/fxyz4viTFruSFW+TJDVJDDw0X1AjqP26qRgy36JtrDfVoXfis6a?=
 =?us-ascii?Q?rN4sZlivrfaVer+ijyfrN6ZcHk1t2Kk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f13a202-f1c2-42e7-543c-08de9aae61f4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 05:18:09.5514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRL/uYF2/QAEGcTfhWAepTsb6ImQ2cmbsrSvnBAHfJQ1Ek5U6cXEwUoTM6Q2UK+huCbGDNWRyqGTELcqMjy8OHRLHkazJFiVIFCPNnzu4Cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5222
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

The schedule() call after the break statement is unreachable.
Remove the dead code as it has no functional impact.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/fpga/socfpga_arria10.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/socfpga_arria10.c b/drivers/fpga/socfpga_arria10.c
index e9822b2bb0e..b85cc3e076d 100644
--- a/drivers/fpga/socfpga_arria10.c
+++ b/drivers/fpga/socfpga_arria10.c
@@ -532,8 +532,6 @@ static void get_rbf_image_info(struct rbf_info *rbf, u16 *buffer)
 
 		rbf->section = unknown;
 		break;
-
-		schedule();
 	}
 }
 
-- 
2.43.7

