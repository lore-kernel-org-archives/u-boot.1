Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E38D3943A
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA1BF83CF5;
	Thu,  2 Apr 2026 17:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="InlKmlWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8DDF83CF5; Thu,  2 Apr 2026 17:37:29 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16FB580212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 17:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fT4HCovkrjY4oshVsfQc4+6Arkut8HdHcR1VrgkTqlSvq+DkDbZivFLvjAQYixV4wPYxThqj0R42m6B4TQA8IYnFy/CcE31iKScddd0Yizf3VETWmbXO3Kq4n5OUq66AmkqUBdjSixde+Rid8ibhsoDo6QYTNZXkWcFUB9Bud44pIB4IkXqVaW3GWlFAdNTtw7+baa+A5CCcsXGWYH8kRIdX3n4NZhpTyGHNZ9t6zyVUalkSwYncgVhWnP0R+a0IeaV1ISvW5foE5JN1hiUfkXRnNCg6orJAJlF9BeYh2VEEKW/mrcizJgurXLiITgfjXL66/BVQPeP/pIu54VRAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/fpxCczxDQ/0SkBmHLg3+vJ1D+eoil6vGX5K3TJYVI=;
 b=L3W6wKQqv61J79NFzXPLM29kTXAsVDfcWEoOR2OXfPhWl3raKetPa9PnZXW0hXjuUL/G40LBSc0pR1faSNiOjvFcgMhaYy3PxXZSVf1zzAN2wlkLXyZLGBFhGiW3Utr1hkiPsMiE6vr2hTuvzx+cnD44EFNaCUg8FFN9xE5BIEsGQ+cYGxoapjUUoLxySDtfJDSd+QttcxmmjtK9Vv7S8bSjqT6mJe03eQU3Za6JRWphEFMa5RH0/acNG+zjSTD7GSYeYWE/dQmuuHVVzqaV5FgMaLoM9ujsTYUmhznJ+cqX2soPxWAMXdDbcdnPOz6kSTQhZtqeFD8R4RecU8ENGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/fpxCczxDQ/0SkBmHLg3+vJ1D+eoil6vGX5K3TJYVI=;
 b=InlKmlWpy6xANSEI89ffVeo2uSRh5j/PDUw2WJZMcXBAI0mLaFdlwFiLguaYujUGvV1tGerWUIsJfzwRSVP6hU7ZOduurKSrAyQLY2NJ4xb2+ADEyKCgdpho84HLpcAfC1PKxt6eT5v4sxhP7dQtvNMDV/rmt8trqgMjmKtdDMc=
Received: from SJ0PR13CA0132.namprd13.prod.outlook.com (2603:10b6:a03:2c6::17)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 15:37:21 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::3c) by SJ0PR13CA0132.outlook.office365.com
 (2603:10b6:a03:2c6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17 via Frontend Transport; Thu,
 2 Apr 2026 15:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 15:37:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 10:37:19 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 08:37:18 -0700
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 10:37:17 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: Casey Connolly <casey.connolly@linaro.org>, Jerome Forissier
 <jerome.forissier@arm.com>, Kory Maincent <kory.maincent@bootlin.com>, "Leo
 Yu-Chi Liang" <ycliang@andestech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Padmarao Begari <padmarao.begari@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sughosh Ganu
 <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 0/3] fwu: Call EFI stack initialization after preboot
Date: Thu, 2 Apr 2026 17:36:57 +0200
Message-ID: <cover.1775144215.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=QKcDLYn/4ziEvcBwmVHafkAKvYogUWcBkYeq/NK7qu0=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSe61V5o8F853KiutLam3//3tJ3FSs9csLOP8z1tarUj
 ePhO2KOdpSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEvh1g+F/hdszl85p4kw2b
 PR1Yp1S8TPrALfTlUn2kaNaqxJKjba8ZGc7Wbbv+XL+2cMoJwXn1XwIi+46dXcfYf/ZgSn8No+L
 aC2wA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|CY5PR12MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 783557ba-433d-49f5-41e4-08de90cdba9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ge3/kxVkg7+Dg4LM3lxjeKC/O7yVDLC7wJjWUp4X2iZoppBWwG5HpwlDY1McTUd62m5r0cQXERboJYwkiwtnYwU1DZMoh+GB020yxYN3IjNL6d0nZfNYvqLT66Yo9VGWmdi5JRt1awSaKssK5Ng0Bd83w/++fCGKdd9zsrcJQ6TuXbPHkKb0h0co1Rk/5JEIEsYDo232lplRsSfOSe20AvJYhcNs+BXjsSkkHlginQ4UxKl7qu3H0EwEWbKoWaMfsaz/ebHnLF4AThFLHfF0PQuNJvO3gf1Tn2WdddTHoPRiYWXkd3O2nM1Tr78SeDDXBuFdaTw6B2zOHSLxrdC6Djf0smvBHiO53HtTEiWXgzb8J4WfX9CZ0G6l+WEbrY3N7FVWorN2saKtdbBJ0aJLn/4zMhxNCIDb9j+5xShSKNI9TNxgy1nc4B1q0COuGFAmiW2zkeyOkqbgVA7yrt6wgYcdrcVehKYDO/EycqwrZK5ZvsI7K795Nl0Ijd4wkyxsJ77ZNywQRGYuvoxLuCbd/QCiPmtKVCe4/fI6Jl1o7lrogfndZwkCpYfpCHcvH/j4DpVc3DPo0RI9W7mW4hzvJPQLCgXENPWaSA1o1OfQvxnVWuYmXqzQ3i3a7aXjNo9lzYI7UpZFWHPfbm8Xt8b372O/S25AOzNbdal9NNMq3zX8XbC3suUk34DvIFyuhktgKOpZ53svbUcOJz5urKy3mQ2inYzN51YRXQEJsu9YAzjVKraBzM1RidlWF1dCjs3KWX09o4OL0auq6yfwiJ/McA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2d8sghZX4yEcXt00Jwymn0nzztXr8y1WXhRjbjirca/bQIxqC5q7s+GMEV6ERm4Txh07Rna1Ne+bYU1Pq8B7KlNaLE6xjisUn+QidjkBlDZyatf5zzVGMOsB1WrkNIZBZ0wyArlj3eiXo94htWYQ9XY7nfGhrd/g8IVnqUIe3qpVE6gXky/iSbZqiPowucA31rKcYxzSGaT+ID8JSQjj/Iu1fF9Yw66+m1KpV4zjUK3pxqs1WcUEIF+Y7eIaEMqITkKYfDc0vjfTG1otwDwbWYG/gOBlhJNpzJGJ4I2hWErotNc0JlbJ4kNunTm2gTLIJ6rD8DswHZEAst6bB9USsY/X8gOff2mtq5owKosd5HtpUYAJFOI1M7hJbreboURBiihk5Idve6ekzdjmcllXO6Rbbd+7/v5UtnlMLIkg3HqcRiAngaMYw7gRV3wv5u+T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 15:37:20.5289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 783557ba-433d-49f5-41e4-08de90cdba9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105
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

Hi,

the whole series is trying to address issues we have on platforms where usb
and ufs init are not done before efi initialization. This is happening on
platforms where A/B update is enabled. FWU code is called early and do EFI
initialization before usb and ufs started that's why they are not visible.

We are workarounding it by starting usb/ufs from board file but this should
be more generic approach.

Thanks,
Michal

Changes in v4:
- update dm tests

Changes in v3:
- add missing type_name extension

Changes in v2:
- new patch in series
- check return value

Michal Simek (3):
  event: Check return value from event_notify_null()
  event: Introduce EVT_POST_PREBOOT event
  fwu: Move boottime checks to EVT_POST_PREBOOT

 common/board_r.c      | 6 +++++-
 common/event.c        | 3 +++
 common/main.c         | 4 ++++
 include/event.h       | 9 +++++++++
 lib/fwu_updates/fwu.c | 2 +-
 test/dm/fwu_mdata.c   | 4 ++--
 6 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.43.0

base-commit: 0cdcef58834c0ad223952987d9bde449badeea31
branch: debian-sent3
