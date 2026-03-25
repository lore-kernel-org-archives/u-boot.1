Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A69106B533
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 13:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D09AA83FC6;
	Wed, 25 Mar 2026 14:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="SlQtOR7u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2B93838BB; Wed, 25 Mar 2026 06:46:55 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A960381E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 06:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/B4+hj+iT9qQRZ0wIpR1OnNlDcgOfw1e2mRg/FTLfQ1FzPKX6cQg9V1CsKFr2WKwSE8VdbOO2nGd9HiiSOMRpakVq8eNGSDVK5Xuo7X07alrg+iFkbfI4f+DI481FCtzKJUYYqbkVHAkAb9AYbt8WnlKq+jHJYTKdlb1AQYoR68f63EVIGf8CosixmceLx3PMw8ZF9+lRITlnMDLv+c5vgT0UmnIGnhzuVBms9G979mJRsZcPc/KBtHUZniG4XfLI5fqIPBYIrQFm9i6HZMoBFIBNoZb9n5M7AIyry39vsPQRhAt/iu+WWEY7B5QfPyterzJCAW+c7xcwbjn0kCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXKMn5k1C85IEFHVCkVoXFSCIgWwhauXCzCHaXp6rT0=;
 b=cXT1AkK4F/pnGahNoJ66mI7RZ3uDod7/86Q1hq5X1tvKoVvJsYgrSJqw3tA8/oXy6Dncvbw0g1axNyxydCzvhqDEI6amrNWo1vvjqHt19whuBvo6OuEdWEg3zYYYu4+Grtpdf1qUREErsaEVmvgo5zbJYGem1rYqyuRRmkAh3pS1az2EilsjEaFNEBXShpfUvKCMJsadi0JVCezLxfgh52P8MkpZv5yN19cKsIgxy61XG6MjEkDfaEhOZplFQSl6yfmxTJzF/Pd1N+TmArTY3NtO/koeOoe5TLBN/8DP0oVGPbkuZyAwR2NVXn5EzutVE/k0eeYhV/X3uK+vAgIYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXKMn5k1C85IEFHVCkVoXFSCIgWwhauXCzCHaXp6rT0=;
 b=SlQtOR7uoi2rwrDUZpKarVlN7rEyittSEdA/4EXd2Ms5oJ++Tff0iaG516xl/M+CvGqq6xHJ9AZU/ptbAYPqfFO1nCSuOMXpX8IM7cIfQV7xrUKbKQUTdPnwh0watPADA9+DAZUqbg7fk+vPVSPdEd1Azg5gw8zwWO6Bc9B8OM0Npr/E3euHpguP0TtskXHS5lfyK2ivYl16uOVjj8zHQOeJInoeaYlmLSeFNP7sx27LAgRb/HbjPzYcdJtPR2bQlauJvs4y9h6NKJUrpSSHqKwpPT+3c4tCkMFmaJt664+XPkRe3y5m5FUNHZzPedrFScCv4zKWa+KkgtkMr2rIvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH0PR03MB6398.namprd03.prod.outlook.com (2603:10b6:510:a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 05:46:50 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 05:46:49 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH] arm: socfpga: Reset MPFE NoC after programming peripheral /
 combined RBF
Date: Wed, 25 Mar 2026 13:46:38 +0800
Message-ID: <20260325054638.13533-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0060.namprd11.prod.outlook.com
 (2603:10b6:a03:80::37) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH0PR03MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ce50f5-b346-485b-ae17-08de8a31e871
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|55112099003; 
X-Microsoft-Antispam-Message-Info: MZwi8YhKrgJpBslOz0Se3ggWldKM3GT4E5xseACKBz9cUAVG0tVB/DhQPW0WmUO6HpOIAFug6A/pfK30hxBy3XD4dsUkR6rZdYKHBoZ0I6lhcwlNyk1ljuUTAnGVEmX3YRyt56d/NTyJ1ouRxzML5dmU0GOYnpwBrhYeNBJjtOuRNSvz+tb3E5TCdc36t5I/7KvavyHg+4dCA6qEJQnvp54P0SExwogRGCsKVgCXj734OezNSvBhVGazALxy1tlfu7+eXd2gPTvz+4IonXuEpbLW/sLKPHmCxDSagA+Qnc7ijMEc4Yq1qm0RnnknkwtGxVfkWTAsx0QJwePkJsLGfzDn14pZDzTd/uTbKhqb8plX22RPKXJ3cnQ4DtPH/9MIfwnyU1izdnGdxYoG5jooCH9Vc9zwxhwyEeLr9KpBED3lzZ8jQAf8z77j8ZGoTre1biZIdQjU2CZ83oV7Af4PyyDSstAJ6yMRU63YLtgyKvaU1mK6jztRuf4ux6xS77KgxWENVubsLk9a6CaO4RlaI/7i8fqdhF3TlMngtCrDeexANp7lxLsJ9WwcmW8Vqw7vXVA+tbU4tViTYKs9uMN2nwsjMf3uKxMQD/OPJIhyhdu2acL+qg+KcLAh5XkF6IiTccfuGG/WyR7wO0PxzElAnm8i8OnannTBIok6ssS054SemXxcew2e9q6zlU7HVqFuMowlg9ccYFFIMqbBz2+ytObnUhk+MUC24M/doehcKqY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v95Xc4T6c+e/+TfuvLVj+myQTqilePCTWv+/Tf7Jr+WgJf6cu10zUFs4Mdkn?=
 =?us-ascii?Q?LZjfZREwPf+0TpPMtrCiO9Trkkt89QeURu4XMjnzOIA7qvMhBQVqF/AeUJDu?=
 =?us-ascii?Q?bWx66QsSo+TS/Un7llp8uE64dbLiRkZZWb9Xqz4QfnBrNsOxfC7n0qD5GMQD?=
 =?us-ascii?Q?UqL3YfZ3yXM3uIhuvCuUEGU1rPxWb1h3uVgu4vKSMwGVbpYMyDPj1x71ZYr9?=
 =?us-ascii?Q?C0B89cYcDHdgWW2T+aCMjdWRpLEU1HUlG/IVkXpYHC0clRAATtfG5fidSFWg?=
 =?us-ascii?Q?OEBRgiWbLnH7g80Xlh8OiQG/Eyto80FLmVSsy8qZ7IguVRrF0BXvMHsqn0Z4?=
 =?us-ascii?Q?L6WREtKr/szG8ZEB9smuIo8VtTKeV3/KMwCOFX8vX2uJAcPWwRiTXi3/e5kH?=
 =?us-ascii?Q?gD/1cMzqCCDC3uNNbDD5lfJTVAM3enq7ZbOFv8s7SB74Ql/sFHKvoKCuH2lw?=
 =?us-ascii?Q?iBTWZbygnAQhtgTc2RnJS/5nZhGMY1ZiWDS9S5nn5CW0yfkfl6jyiU0KYGri?=
 =?us-ascii?Q?G9hhSfa2nimCrn1NK24U9GLZFqseWvmPEfsl7b2ej0PxL1c57UfH6wVR/ZGa?=
 =?us-ascii?Q?TNfT3Bo+mai2NHh5QM7wbMBmyOLfHLTbicc7Avu0QWcGm1V2ty2yzAHqWNgT?=
 =?us-ascii?Q?oe+4d69TTn8J9WtakRNvi+zbOs8SGG1mXvCEoOyXboolnIorO2pgcq60rUhH?=
 =?us-ascii?Q?BDbbEfzuvdgge9EJ2uEA9KtjYOlCr/t/7R9RhLdg2AtfWc7C6d5EDQMTnhzZ?=
 =?us-ascii?Q?NGtIbi16+OocutgzVXu4PAKxepbM7vKdiL3bkLlmDLD+yVLaVUOYUV0lMDhe?=
 =?us-ascii?Q?UO7jcoOaRHS8mgbYXW37GIgvppWeOIZboPX6WiHvD4EST1PUhfwQvDQGmLFt?=
 =?us-ascii?Q?oNHmGjIEPXyis0nHczDacWhyq03ddBaUd6TrHPCQSGffb64sbF7R7EKHOg25?=
 =?us-ascii?Q?UmJZDlVzi9j0hJES/WmbkAjNFlPOLgY0xg42NiOOGzzdM5nIFQ31hd+wvcIl?=
 =?us-ascii?Q?TxaHm5vpbpbsl/TzakvbBMqWEBGpI+DtfJmdThGPT/xHdFU/JDREDujMYYSc?=
 =?us-ascii?Q?6bSoeqoTVfxaa/FMGPZPT+kZKezP0SB1f9GPDRybkTS8OwQcbG4Wm7dSwKyz?=
 =?us-ascii?Q?CNh853MLC2m3zKFTavdEgKLJOoFNss8I7So6bctYbyhizvx1OnJVDjiDn/AZ?=
 =?us-ascii?Q?hdFQiRooiEvlXT/jDdMEDfZv/8mXjI0UHga/8wBrZ3RIWW8FXW+7ps7mtDHz?=
 =?us-ascii?Q?xbjkatGp3AqunbgKkCRUiFJVCK7tRuXKjR/Cr4pgOc0HHN0QG2ugcfsRqmil?=
 =?us-ascii?Q?49T4beW/pYGkdTRQzSn6bYOlVjT5Ft6z2ajMugqoFk1ozVpVwGJIu+0xLQmE?=
 =?us-ascii?Q?vVSLUAYnKjLJoqWBySUhmECFVAXwHt9mf+eFOlkMDNS/qPARbnXVOqFbnYqc?=
 =?us-ascii?Q?O6jNx9DM0aMfJFeC0vAPdfz1SvMR5Y0Rt4h8Y3Jz8aUvLuSAcK3LViK/Od6j?=
 =?us-ascii?Q?LvisEKlcpTJlqThsnU0D8+SJFfCwlMBDqKeq4nAiJu69/GOvplSrJ5jnNb6I?=
 =?us-ascii?Q?+YZFMQf9Gq7S6jKiQfkbxDpDvPtPIca7ZM23zacNaXclsEYskwpw6Dyv6j8h?=
 =?us-ascii?Q?K4RIRWNX+Q+K5ld6nGiD0BR6RspjsysHR3szeXSjbOtys3gCmAYQWvd5x80S?=
 =?us-ascii?Q?Rox1ruvge6LwmhJFwdABXQkj/qI2q6iDbpkoFCrpQshbXwLDEZQYpX6esZbY?=
 =?us-ascii?Q?6zmFg/Kl1FURnrsfQZbNFWx54a7tDS8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ce50f5-b346-485b-ae17-08de8a31e871
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 05:46:49.3745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4gaMrFvXa7G3EFZDjdPyJkJ7CRYuntY3qGfziGTXKVH8SPzNxabJ0CmUJWCPFr9hZAapGbm35W0RJuXz4mFBkaamI+7U4ww4vabxSfNZno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6398
X-Mailman-Approved-At: Wed, 25 Mar 2026 14:25:38 +0100
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

This patch triggers warm reset to recover the MPFE NoC from corruption
due to high frequency transient clock output from HPS EMIF IOPLL at
VCO startup after peripheral RBF is programmed.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/include/mach/system_manager_arria10.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h b/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h
index 0afe63e647e..73e953465a4 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h
@@ -37,6 +37,10 @@
 #define SYSMGR_A10_ISW_HANDOFF_BASE		0x230
 #define SYSMGR_A10_ISW_HANDOFF_7		0x1c
 
+#define SYSMGR_A10_ROMCODE_CTRL			0x204
+#define SYSMGR_A10_ROMCODE_QSPIRESETCOMMAND	0x208
+#define SYSMGR_A10_ISW_HANDOFF			0x230
+
 #define SYSMGR_SDMMC				SYSMGR_A10_SDMMC
 
 #define SYSMGR_SDMMC_SMPLSEL_SHIFT	4
-- 
2.43.7

