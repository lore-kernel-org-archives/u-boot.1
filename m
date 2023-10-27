Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD5EC25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 20:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F11DA87755;
	Fri, 27 Oct 2023 22:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="L9nX+iBU";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="L9nX+iBU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 950CB87752; Fri, 27 Oct 2023 22:40:52 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe13::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E0ED8774A
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 22:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Ih7p9dRBVKeP5uJLyKwkVV1IPfCZm7PMBv+uxwNdLwD9TbEzLojm95v6vnn3Osb+y4j54YQrx5x/KFDf/eNCak6F89+whMZNxh78AiaG1LYOh0w0Z4BfW+03DHGoH/QBzfRNCKK4hCNXmJN/VWGU3PVLDO9jhYL9d6p63DeQDE71F0n6IRh6yzRFrFaANBpN2P2RvggRLeuEQqtp7yErrBAEpODw3fau5O6FVbMNbIJHXU0YFKmbUg4xY7KB4hxzSv6Iu+TawAu2Beal2bZ2vSR28rnKtF64pCwWl9bZSNBFOtVF5qlRsOKVRH76MFGWZ9muYW+O/jeUdf4+Qki/Iw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mNlZ5v9pnMIqLAD88nSsJxbPzCBC7hd1n/etc1AbXM=;
 b=PsOJiBNKicPjC+GWViPCA/eR9pz7R8jMhVY85cWzPdOvjOHzgz+OHzGAwNU96jT3vcXkHQxpxze2ebvwap0rM/yMYl+zLHamRfk7gD+kau5sJV8dfMJcz5mVTLLkjOx59O2MlZnRx1psAI9mDaq5Cboo8/S7jE+V6sAHwo1k0hPZCyexIwDeHx4PebmE9HufuJEsUkI61bY9mNgppfdU7Wr+Yq/yxUF+CiuEIl8HRcUdrmyzqy0+e+bRrlaj43EERRByG9TFUaCuh3kM0UOatLHjLxYfz5O0pH9de7OMRuhEzzRiN/yUOZrrcRxgNh4gCQjGFdn9v5Upd8+7LJAp9Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.83) smtp.rcpttodomain=arm.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mNlZ5v9pnMIqLAD88nSsJxbPzCBC7hd1n/etc1AbXM=;
 b=L9nX+iBUDdBqXDyQwDZQKIBLj3DgQ4864ZJsTe06STKDELm++0JF8rQaUCUlOJWRW6hENXiAUXDuRQ3sN8ZBWBaJ9MzU+NRCWX560U1o52ZJssimPW0vobzwA3E2J2LbkzQEF5Wtij4vJBYQmiIjy+Tt85oogTQyB0bxr0eyUiKefFSMKq8VzHz/+qisI8bNkCna8OYMt+0ISKfsa0XeTi3K7Ry6ycDgRA7Iljj57K97QaCZcUzh2jY+V4j6h+pJrSGx2zD80IjN6+d3+sLVDhNSEmMjKjJmW6AQignepTUxUtXDOK6SFjFt+17NU6WUSxmXSLLMekxenpLcCCF1Nw==
Received: from DB7PR02CA0022.eurprd02.prod.outlook.com (2603:10a6:10:52::35)
 by PAXPR03MB8201.eurprd03.prod.outlook.com (2603:10a6:102:248::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 20:40:47 +0000
Received: from DB8EUR05FT012.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:52:cafe::c8) by DB7PR02CA0022.outlook.office365.com
 (2603:10a6:10:52::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.25 via Frontend
 Transport; Fri, 27 Oct 2023 20:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.83)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.83; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.83) by
 DB8EUR05FT012.mail.protection.outlook.com (10.233.239.1) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.22 via Frontend Transport; Fri, 27 Oct 2023 20:40:47 +0000
Received: from outmta (unknown [192.168.82.140])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 DEEA2200813AA; Fri, 27 Oct 2023 20:40:46 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (unknown
 [104.47.17.104])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 8B8652008006F; 
 Fri, 27 Oct 2023 20:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JE7OY6R6SYOeJubCHREizZ1c3kH1fW/lnzsYuExlTWg2hoXI1fs2TvriKk52EXqdY3nGWTfvHqPw3hL6oTQ5DMB+hbyaMjU1rLsdgXkleQsy8IoQEWGHevJz5HupYGubkhnvhulxHUvc6hF0goiF+f3xgkVBYTcStfAHMBQG6Cy/gKfeIDX8ExCP9bIUiwA0K1guNH/cLQSoQ6Xdp9jFibhdjuVNq68CLPsOAxCeG+bf3AckO5ikRTTDQkfL9pW+wOFbFkfmjtQpOdP9pOsptM8FI/7VkbAns7brMNnW0ZR9aAGQ4nGxEzAy1rwroJbVk+ktG8rphdFOo1+2IBCPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mNlZ5v9pnMIqLAD88nSsJxbPzCBC7hd1n/etc1AbXM=;
 b=UxaoPi9YZc8F1IDfYFLKpdjLna0G9kVLdnJd8JxV0aDaUv3TavMk/IvmCn4F2Hm3qPegntRBIRw2Ib7qQkc4MmkLccGr5AMaGO8KMN0sEj1r6ZlZYs/k1jiHzJ7bimhXVaIU9DV690mdvRsw7WeAPRc7Vr8EI/f9Ob4hrC8Utn8ji0P7PpMHCHuNlD1bm4JZz6lkl5iScf6CukGxOdkiJVNZLLOXJnc2EvTv16bbKOLHB0+4Jt3hfkIIyB1WoRJlIjuF4qVFBVMhWH+PBUGQTnhcyrEuLbZR7k0f4wNn5YXC1hdekcuYtqjJUYFedMX4zYlc7SHblkKu+XNyqmBcnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mNlZ5v9pnMIqLAD88nSsJxbPzCBC7hd1n/etc1AbXM=;
 b=L9nX+iBUDdBqXDyQwDZQKIBLj3DgQ4864ZJsTe06STKDELm++0JF8rQaUCUlOJWRW6hENXiAUXDuRQ3sN8ZBWBaJ9MzU+NRCWX560U1o52ZJssimPW0vobzwA3E2J2LbkzQEF5Wtij4vJBYQmiIjy+Tt85oogTQyB0bxr0eyUiKefFSMKq8VzHz/+qisI8bNkCna8OYMt+0ISKfsa0XeTi3K7Ry6ycDgRA7Iljj57K97QaCZcUzh2jY+V4j6h+pJrSGx2zD80IjN6+d3+sLVDhNSEmMjKjJmW6AQignepTUxUtXDOK6SFjFt+17NU6WUSxmXSLLMekxenpLcCCF1Nw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PAVPR03MB9211.eurprd03.prod.outlook.com (2603:10a6:102:325::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 20:40:33 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::7d1a:d4ce:f301:582a]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::7d1a:d4ce:f301:582a%6]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 20:40:33 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 3/3] arm: semihosting: Support semihosting fallback on 32-bit
 ARM
Date: Fri, 27 Oct 2023 16:40:15 -0400
Message-Id: <20231027204015.1547595-4-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20231027204015.1547595-1-sean.anderson@seco.com>
References: <20231027204015.1547595-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|PAVPR03MB9211:EE_|DB8EUR05FT012:EE_|PAXPR03MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: adc5013e-30d0-4852-990c-08dbd72cffd7
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: tpj7emxsxePftsMfILMMR6BB4s4wJnv6qWvWxPtnTDx8RGxBew/6CvoWsCcg7P0YT8K6/R3yFWuwm7mY+U/bahOpXAcefBtlok/CUNI9b75rJRc5HedTOR4YYrFfPcF5RkLL8ymCfsbKzV/ryUihk9KzeRHrui1eYWjpiE0f/37GU04SYqz4hUapzkiJv7ALG9VTSOD4kV4bm3dZT5NgW8yXuQH0fIpo7eHwnQZhFZhn+x9fs2W15aAnAMHl2aoyWE/ho+ANh17BTETzH35VIdH3IKIueHX4SJcpu0XpW420PJr9PiasUKPJwHNWt36ickgy1HTDvm1GtFNNs9RVHkBOxl0s1Yhu/MLcrR/SpmTs1+2sMhcqAKhj1/VgAUBE6Osiw18hd3Gg+bBRiRRUQf9dlZ8Lq8iYJ5GxK+PW5vOSr1tvxLlCqluudJoIRT5giqzWc1z2GLJ4WUQXy+Hh3YzVS188/uJJocFhphRD8uek/vyd/RTHnPSltxdaCQkfSNT2wUIzuYFtasaBqTIvFS3NLV64PVe5dl33U2vGXUNSIyvQhi8N8MMPvGGgSVxhtvTxxn0veqPR/0xaQZMAiCGTC75TEtPhLD90GVd4RPFbdqAbfiKN3qDNIDbMjxgd
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39850400004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(107886003)(41300700001)(8936002)(8676002)(54906003)(6486002)(44832011)(4326008)(478600001)(38350700005)(2906002)(5660300002)(316002)(36756003)(66476007)(66946007)(66556008)(86362001)(6916009)(66899024)(52116002)(6512007)(1076003)(2616005)(26005)(6506007)(83380400001)(38100700002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9211
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT012.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: cb7b2858-c7e8-4670-e5e4-08dbd72cf765
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2jopefSd/Mf76t+T55calp0TBgQBOaJ3vlUE7zIEY6bWnGozqGqOdfhwzJ8ax61O0uSt8q0ayOgndZjOyYji14BXYhp7g3ewes58ki3idylDHbNM82jFzX0aNe92gFi8v9kYH/lgMNgqBeD8/7iiPmQkvMgmL9ptxDCX8gl8ehCjDdanbrMzFCkewws6ohKG+6QjIZS35Y5ht+yZmJlA5cAgDvTofUuDetktgAZMBq+fUNguXey066b7jcUezVYRsaXM/EyPy69aHcZeCZd7c2Ik9hcOR5u5redR871hnPzupUe176cEQ6udOJwjldfZ6kVfkGtRm/qeVMI3PyR+F4a/oE18GNj432Rhpe42k79b2s3xaAFahtOVFLmBHlc9i257QMYfIPnYNAsqap4Q6xXpDSQ+3RrbExO8W4Z3/Pp9gZV6IIiV5nB821oiyWaal7QgN8ijFKB0Vllld9bITZN+V9YIQKeuxAMRK9TK2XYj6ILT9qhx5wMl/xWLY67sLtm6wQD/E1WMaksyskT7zhPo+NZVwKSQRXfkZXhSJLov3afjeoCzXpr+2rQg42xIx2Syn80rRIWfNPQI7IxBGHjszoKV2wicT7oy6PqNPViHU4QQizwcs3GVrDjAwppZWa4O38ucsojD2m2iW0lbObtG0IhBB7fzLDoDoJI4vzOtyNQTCohkdXCgsw1IHMlwBRvzVWanKN6gABBz5e5wFOiOBBopgvbZJW2LA1CWJKBk9Adf9MjVOthIFKHn+6vwd+594QmQ4bKbLugtOWqEvA==
X-Forefront-Antispam-Report: CIP:20.160.56.83; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(396003)(39850400004)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799009)(36840700001)(40470700004)(46966006)(66899024)(40460700003)(1076003)(26005)(6512007)(2616005)(86362001)(7596003)(40480700001)(36756003)(82740400003)(356005)(7636003)(83380400001)(2906002)(36860700001)(6486002)(107886003)(336012)(6506007)(34070700002)(47076005)(478600001)(6666004)(4326008)(316002)(8936002)(8676002)(6916009)(54906003)(70206006)(41300700001)(5660300002)(44832011)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 20:40:47.3128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adc5013e-30d0-4852-990c-08dbd72cffd7
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.83];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT012.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB8201
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

Add support for a semihosting fallback on 32-bit ARM. The assembly is
lightly adapted from the irq return code, except there is no offset
since lr already points to the correct instruction. The C side is mostly
like ARM64, except we have fewer cases to deal with.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 arch/arm/lib/interrupts.c | 31 +++++++++++++++++++++++++++++++
 arch/arm/lib/vectors.S    |  7 +++++++
 lib/Kconfig               |  4 ++--
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/interrupts.c b/arch/arm/lib/interrupts.c
index 6dc27d1d589..9961472f69f 100644
--- a/arch/arm/lib/interrupts.c
+++ b/arch/arm/lib/interrupts.c
@@ -22,6 +22,7 @@
 #include <cpu_func.h>
 #include <efi_loader.h>
 #include <irq_func.h>
+#include <semihosting.h>
 #include <asm/global_data.h>
 #include <asm/proc-armv/ptrace.h>
 #include <asm/ptrace.h>
@@ -135,6 +136,32 @@ static inline void fixup_pc(struct pt_regs *regs, int offset)
 	regs->ARM_pc = pc | (regs->ARM_pc & PCMASK);
 }
 
+/*
+ * Try to "emulate" a semihosting call in the event that we don't have a
+ * debugger attached.
+ */
+static bool smh_emulate_trap(struct pt_regs *regs)
+{
+	if (regs->ARM_cpsr & T_BIT) {
+		u16 *insn = (u16 *)(regs->ARM_pc - 2);
+
+		if (*insn != SMH_T32_SVC)
+			return false;
+	} else {
+		u32 *insn = (u32 *)(regs->ARM_pc - 4);
+
+		if (*insn != SMH_A32_SVC)
+			return false;
+	}
+
+	/* Avoid future semihosting calls */
+	disable_semihosting();
+
+	/* Just pretend the call failed */
+	regs->ARM_r0 = -1;
+	return true;
+}
+
 void do_undefined_instruction (struct pt_regs *pt_regs)
 {
 	efi_restore_gd();
@@ -147,6 +174,10 @@ void do_undefined_instruction (struct pt_regs *pt_regs)
 
 void do_software_interrupt (struct pt_regs *pt_regs)
 {
+	if (CONFIG_IS_ENABLED(SEMIHOSTING_FALLBACK) &&
+	    smh_emulate_trap(pt_regs))
+		return;
+
 	efi_restore_gd();
 	printf ("software interrupt\n");
 	fixup_pc(pt_regs, -4);
diff --git a/arch/arm/lib/vectors.S b/arch/arm/lib/vectors.S
index fe8ca403ac9..843f9b9c281 100644
--- a/arch/arm/lib/vectors.S
+++ b/arch/arm/lib/vectors.S
@@ -275,6 +275,13 @@ software_interrupt:
 	get_bad_stack_swi
 	bad_save_user_regs
 	bl	do_software_interrupt
+#if CONFIG_IS_ENABLED(SEMIHOSTING_FALLBACK)
+	ldmia	sp, {r0 - lr}^			@ Calling r0 - lr
+	mov	r0, r0
+	ldr	lr, [sp, #S_PC]			@ Get PC
+	add	sp, sp, #S_FRAME_SIZE
+	movs	pc, lr		@ return & move spsr_svc into cpsr
+#endif
 
 	.align	5
 prefetch_abort:
diff --git a/lib/Kconfig b/lib/Kconfig
index f6ca559897e..3cabb07bfd6 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -93,7 +93,7 @@ config SEMIHOSTING
 
 config SEMIHOSTING_FALLBACK
 	bool "Recover gracefully when semihosting fails"
-	depends on SEMIHOSTING && (ARM64 || RISCV)
+	depends on SEMIHOSTING
 	default y
 	help
 	  Normally, if U-Boot makes a semihosting call and no debugger is
@@ -116,7 +116,7 @@ config SPL_SEMIHOSTING
 
 config SPL_SEMIHOSTING_FALLBACK
 	bool "Recover gracefully when semihosting fails in SPL"
-	depends on SPL_SEMIHOSTING && (ARM64 || RISCV)
+	depends on SPL_SEMIHOSTING
 	select ARMV8_SPL_EXCEPTION_VECTORS if ARM64
 	default y
 	help
-- 
2.35.1.1320.gc452695387.dirty

