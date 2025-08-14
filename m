Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF429CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 04:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74A0C83865;
	Thu, 14 Aug 2025 06:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="EraP6lQ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A70938382F; Thu, 14 Aug 2025 05:18:03 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AEEB837B6
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 05:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONv/Pd91C9nCD4bdLOzxZbhnb3K5yAeItc0oQSq9GwEhveSD3BwHnM8Ng61/2YdeJVqsy4RFatw+ADJwK9dvoT7jXYLum23COT+2Ya3XVE0gflvI4Hc8YZ5ONOEIrmUu0f8+CVChYI0MvVkC0m0RrtkFhgePyNtOhzUZNNVv5sq9ZrmHh9cg4F4mcwliTbKWmwcq5QueQ/WJZ31PW7traMFJHKFLiFwS3dnNet1U/fHZgbRnHMNWoijJULwA55YvGsl4JC5hcgmUiTPGzvdimjyIYAAYxkarBLo+Gl51MedM+ZAvy+h7i6DXVXVpc+RJuvmiN8vKyDYtId9V3dnNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+37dOk+kvYI1hlDNju5XaAkNhYzb8S62umXjQVsKREM=;
 b=QP8w+urydxu1xeY6H4mYWxb1Nrnv4I/ol6p8ZkrRIpkcCHbIRJlz8ZxOEeLiFYVE0V665F7YgNDgpZcoCYqopumeyJuIwri8GwGnCmiohxNdqMhZcu6Bi4naVaPuE1zjedtyKU8nr4MXkQnC6ES29bd3rPgc/1er0DkKIVx/Nkhb8QYEpE2DPcZl/D7iOYM4L2SY3PDC7a+WYHphpU/3rQxIk8TOaOu26Rr68oHqtExouh2/tsJ7Efe+Rm8CsHl6YWX24dKSYemTMmI1YBcmJ4g4phvxvR56NdWj3Z6JM2a8OJ0BFyzg8Fd97POA15CHoqUmlrk+8MxdSkrIZFt3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+37dOk+kvYI1hlDNju5XaAkNhYzb8S62umXjQVsKREM=;
 b=EraP6lQ6PHTlBHxwldBzOm5gh08bKDoEuW+66zCB04uHjXvJIskS4BFExP2IDxYp4lmzc4Mz66n3fa8IIl/lIHjRQ9egA6vTTAbSaIYV2+Tbqfx2xU+hYizDYy9DSoJK9tHfpZabLHfeY53WIWMIt2blGlGTESJ7m5whmjnZft622UTBErXmjPTN1J4TJuot+c6+Em63KX/WmmnG8SAial/69dFkKCOT16Rwvfj8VQvlXUNUnJTnpZO1eZM5kxh+XxDYoJIw5NlYWDOJLfjerk+huLoa4NQCAh+f/A/nUdz73D6AXED303hVnKf9mqDVX4h02fZoQsba4S2Nyi8qfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SA0PR03MB5580.namprd03.prod.outlook.com (2603:10b6:806:b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 03:17:57 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%6]) with mapi id 15.20.9031.008; Thu, 14 Aug 2025
 03:17:57 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mahesh Rao <mahesh.rao@altera.com>
Subject: [PATCH v2 0/3] socfpga: Agilex5: Fix dcache usage in SPL and SMC
 mailbox flow
Date: Thu, 14 Aug 2025 11:17:38 +0800
Message-Id: <20250814031741.4887-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::17) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|SA0PR03MB5580:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1deefa-370e-4ffd-f104-08dddae12a96
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uFooTwiYS5euHy72RsOv4VQfXh9O6O6SWL2m5SiiJ7sUrC0+Ir0S62Uxrjb+?=
 =?us-ascii?Q?UWmxpZxuH/PFbxbGYfuveOfgRz5NGlKjLcnESsIbRMqOuaI1dWHBscMGjWGA?=
 =?us-ascii?Q?fgHa4SwhpYXy/ieFxvmeEQaDpHwk6IBmiV998JK7ZNKSWJVDcvh8U2SOMCz6?=
 =?us-ascii?Q?L3BmDmBaaE2nGujI3bzABwUfnaoZvZUig1B2HH5Tk4bPyTHnbPtkQePNdX51?=
 =?us-ascii?Q?HuhEPVXoodtwPYe3Wg7AKforAZcqPj/st4bNpS4TzkRJlLKISM38esrSLgoc?=
 =?us-ascii?Q?ZMAeKK2gs4LrD9rFPoF3NLKtk3q0v9mW7tl8gjiose72gJ374oINMBzGQ3Cr?=
 =?us-ascii?Q?toYCpF9awBKaFxkaGMVGNj4sQPSbpuUGKTLAqSx5W645bzHyK4Tp51ud5qix?=
 =?us-ascii?Q?EM/yqJzBbRjRZECbMtEeYFQBUyjEjWuhvvMSp1c2nykm1Y0r9hzJPo3OgyRX?=
 =?us-ascii?Q?Atd0l3TI85JBpAunCb42iW6b7goTV9G7OMlqC7EpEuqb86+e57Kwr9XCza8G?=
 =?us-ascii?Q?4qTk/AvxcCSq2q76LlldbPeG2f06ut4YbAwkfzffSINXkbPben+MNnenrMVE?=
 =?us-ascii?Q?WIBqqK/ZF+/4Q7MtSo7NqbjEP4UVgfuWFgCmX8qqMGfQqNYLdJVFZsLh7dgC?=
 =?us-ascii?Q?wbdiyE59KVDzEiWsucU5VBEjCcwFkiZ6PmJ1Sv8fO0sqd1Dnz+BWlmewS7fW?=
 =?us-ascii?Q?ev7Ew68C+hO/jvWVLuqllJrsu9jj9OWBr3GyadmhgzmHdZCU9hHQwzCNZ5S3?=
 =?us-ascii?Q?l4GNzP828LqPcvkmZRW3b28mMePVfZOZrJ3o4PnbLEw57OTUkUuy1j4Y//5e?=
 =?us-ascii?Q?lVCKFulnvXt2AIUI85osOjDxKSJDrX27z+fr17r9o5O3fzlKgg6I6i4tyTOI?=
 =?us-ascii?Q?oBzGifMSjuhe2p/l5/dITy08jbLYBe2H9IlelXqyjuFPpkIYFbbQQMocOUT/?=
 =?us-ascii?Q?lquOOzyNbe9zCCLWppc1nT+ZrA7c0hWPz9+WeF2+JIV8jY/EUZ4BPHZAK3y4?=
 =?us-ascii?Q?rhpcc81T45Ifila6YFgDy1iDvj/2jUSUwoLRPf5BVuzY8M+rrYyXFFo06yd5?=
 =?us-ascii?Q?sPku9N2O3b7ZfWQS9st4DFOjlkhyhBJEit3qnj+rJu3cLXExTjgwVOsoqyGE?=
 =?us-ascii?Q?oRBUuumFP7sEYvHA7N0MiKLvxx/H9mztHiIu/+hPktw1dALKcr6ETpJ2Hs0U?=
 =?us-ascii?Q?S0nHc+D4TefQN6PJtePDiJncLFbrPlKHaCnn+YqWIKvAoAAbr0PfGNLLS2Rd?=
 =?us-ascii?Q?7x+3vZtUvvMTp1shuB3Csn6GJyfw4+GEPz+ittECnuGn34X4WyFFcf4ZW+lZ?=
 =?us-ascii?Q?Q9mHLBe18sC0WgByNMfh44Vrn9+SZu22L1Dkjh3Pw+FFaJZkZMQmWrvGNhFv?=
 =?us-ascii?Q?hYSmXyhNU3TXJKXWpjX+JGIyO/LGaNZMym+Hp9rVNU50Bhdb+rL1tJvUhCIP?=
 =?us-ascii?Q?wADwkJJjhy0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qUevLwiKmMRB+44YqRBlSeM43GMvWfHY4GbcqnuERm3RvEer54zyV8H3PJha?=
 =?us-ascii?Q?CayFJl7v7nlYiaLE/RuXSr3t+4ZBo3VE0iP1L+4zyXmtZX7e/FcXGqwFA7WO?=
 =?us-ascii?Q?j14j3icYoeaO4rTz6BoAHChUagFngigFGZIZysA5VgGU+JXNXFdHAzXWNXhM?=
 =?us-ascii?Q?Uzvcj1vPpGDZarmXTlO5t3ay5f342YqQ+Rn7xEYJLkzCgqQNQJ/cP7SVoBnS?=
 =?us-ascii?Q?rpUKhgAomGGwWEnj2imioDx0ffFuS9Dp/zS4njJKzSXHjIn90yhud6JKHU6i?=
 =?us-ascii?Q?NH06mKNkpo6tjC8Zh4Pbyf4FUeKiZ1/FZk6OltBzX5tH1jnbslDrXNEzVVGa?=
 =?us-ascii?Q?YoLdWrh5pXSqv6VT15nYdNLOgGeDh5uDJWP+DpXKLpt/Qv5DNJ18QYLTOE75?=
 =?us-ascii?Q?igcPwl9pgC/D1ypmweckcEZLcoja277CDxqhd2IiAdOevIC4ACmwOJIzKVFO?=
 =?us-ascii?Q?ZFotQZdHsDPpTgJOrmEbOFhSSa5I+rJLIYeLuo44THhjz/GlCj/WBmhsFh5q?=
 =?us-ascii?Q?egsOHbLVtWmfyT5FUdPMAh8BIii1+wXuEvGrPK6pzoz+n//vkaeOL7YdeRhq?=
 =?us-ascii?Q?fNVy38xG9I6p5plIUv1y4BhhNY0yKrsv5j3+fz9dEVqyq3GveDJSfqTuY5mS?=
 =?us-ascii?Q?50c5F94nSTXSFaZoKdfhJfmlLZ48SdhQ1ZBTDvO2Wyj0ENYRFNdYmAhxQcet?=
 =?us-ascii?Q?y/iG2NgsrqH/ncLwbMhhDJuiVQtNwany+oGbltzsd+2u1bYJ1uKswNVyksl/?=
 =?us-ascii?Q?Q/Pn3PTxpISn8fhosXUBrYN/fbpMShAlcT2IfDCUcjE/meWHTXH5p9v3pR6u?=
 =?us-ascii?Q?6sRDiobiS4NjJRqi5ntSZpC5F/4RWoLfe4whQb/ekminD+ST9l/h3klvzqQU?=
 =?us-ascii?Q?VtLwZ01ZhP5U7AqmtYVTYqEHQ2CfBS4ex59jQxoWCkl1E21lDkAJbg739/6P?=
 =?us-ascii?Q?usBuF+KzhP046VEm2hb5W8bYsA2kARAbtwHbJA/Xi/7oR/G8XwzGg9oh73kH?=
 =?us-ascii?Q?55QhUDS3DHso+wzdhlfbVTSFupx6i0pYx1S6RvOeLUkgEiqLlaxmlYMJO/d1?=
 =?us-ascii?Q?7hrDehGEAv/0kxqMUz2kTF7vjZnTkNw/UIfI/4YOIs7BIcpzeQICl5+bACuj?=
 =?us-ascii?Q?PDmrTPGsQoL2bGkq7P7S6rZLaDG4I2BTanBfVsCr7U5we8SuMc8F0GnRcRmp?=
 =?us-ascii?Q?yUuQ1HN7cCvRAZPaoVbv1Bfq65FQaKA8cLBbyEAZSL/wJUTLWxbGBHVTHec8?=
 =?us-ascii?Q?XPdfX8I4hIvbeiGmCtUJjZyFOJZBN6pT0pjeAOWUMVznW20djSxVal/LKQrj?=
 =?us-ascii?Q?ljzrXd6DgwnAzOGYHvYNgvsW/e6nLfGZhNLCv0W534wMf/T7qDIUrgpmfEMi?=
 =?us-ascii?Q?ShJkx4PTiVPS1zyEQrzgwAhM8d8FSoFFSXCGCXFWc2ruGALEoVS722Q6yIRH?=
 =?us-ascii?Q?BwmhuOC1IYPjHSCo4oYfNPEg7XosWFNIh+veI3CPtRi1fPllTME4Bw76KpVL?=
 =?us-ascii?Q?dnuRToNhhbs+pAOp9JFIjrFktm3SThzB7oRHioNuz3NEBfren30ytQI5ylYD?=
 =?us-ascii?Q?dTIQbWK56QBIO2/PDLOjZpI1f7h/jpAVIlQAe000hlcQ9CGj8VkFERbCQzII?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1deefa-370e-4ffd-f104-08dddae12a96
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 03:17:57.7035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kTvSTmF6YzDIX9AeKcIQ8OdydCnfsXCrP7+fPFZ16JAvBShMTvnianRza1a88Q9m82kMmQZ/pnJoTu/pK1xXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5580
X-Mailman-Approved-At: Thu, 14 Aug 2025 06:34:12 +0200
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

Hi all,

Proposing the following fix to address data cache handling issues in
the Agilex5 platform, particularly in the SPL build and SMC mailbox
communication path. It ensures correctness in cache operations.
Other than that, trying to resolve undefined symbol errors, and
provides the necessary configuration to disable data cache in
SPL where required.

Patch Summary:
[1/3] arch: arm: mach-socfpga: smc: Add dcache flushing and
invalidation in smc_send_mailbox()

Ensures that the response buffer from the secure monitor call (SMC)
is properly invalidated in cache to avoid stale data access.

Updates pointer arithmetic by replacing u64 with uintptr_t to
improve portability and correctness.

[2/3] cache: Check dcache availability before calling cache functions

Adds a !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) check before calling
dcache_status() and mmu_status() to avoid compilation failures
when dcache is disabled.

[3/3] configs: agilex5: Enable config SPL_SYS_DCACHE_OFF

Disables SPL data cache explicitly via CONFIG_SPL_SYS_DCACHE_OFF
to align with the above changes and prevent inconsistencies during
early boot.

This patchset has been tested on Agilex5 and resolves the SPL build
issues related to missing symbols, while also improving runtime
robustness in SMC-based communication.

Let me know if there are any concerns or feedback. Thank you!

Changes from previous submitted patches:
v1:
Using weak function to resolve the compilation failed
with undefined function when invoking cache related function.
https://patchwork.ozlabs.org/project/uboot/patch/
20250806032206.16688-3-boon.khai.ng@altera.com/

Boon Khai Ng (3):
  arch: arm: mach-socfpga: smc: Add dcache flushing and invalidation in
    smc_send_mailbox()
  cache: Check dcache availability before calling cache functions
  configs: agilex5: Enable config SPL_SYS_DCACHE_OFF

 arch/arm/include/asm/io.h         | 28 ++++++++++++++++------------
 arch/arm/mach-socfpga/smc_api.c   |  1 +
 common/memsize.c                  |  5 ++++-
 configs/socfpga_agilex5_defconfig |  1 +
 4 files changed, 22 insertions(+), 13 deletions(-)

-- 
2.35.3

