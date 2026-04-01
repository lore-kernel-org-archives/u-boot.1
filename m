Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07607107636B
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 05:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F69684010;
	Wed,  1 Apr 2026 07:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gWcTVnYc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C434984056; Wed,  1 Apr 2026 07:25:29 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1664083F5B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 07:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONtweIxleD1RJTSlG9XjdnRh2124jWyaYA7RZhiH16r4mfuNdz6XdTAjM9m0dwkRYvtCtwplILmY8CE5sJqMb2Lvw0rVDNR1ilGbCua8poNz86T7lFe3379P0O3u0V6OrnfBmJlVdGoEE3s9xaEMDFVscnilSqDIesdTSG41NyZNGec/sh0gykqAMcLD8b/vvkr/MmzDNf+c77La2Y4qy+G363u3bVlEA1S0N73yCIVvwtS9QEr3i9+TNEd7fbX/PF4+RiKn7VQ68TqrzkiMG/W/0FRDL/5l6zIaEGK7v4yifpqJLMo0YVK133+QeuJ4b6REMuCP+EXExDo98Zq/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPShrRCr3mkAsJ25VS5WXbuBGe1oxlNp3j7md3BQGN0=;
 b=H/UpWN0TjHdHtZmYokFDgeydnZcozvVzdx+1ciaHGfjw8h9I0EFOFllJ7W3o1UtNVfNzEpVWD1lAjx/kh2nGYlvtGlJ52HHC+ipNhUnA221vpI6mSr99USVsoKKLYK3oeGacY3MRGX/pY6Gd3fOn319/oiSxm8jDwcN0V3kfJ46NNgH4MMnkyuy4WRwS6NkcrawxjGfQznvvDUo/CC7j9cozDQ6VyVKWbFTSzAOSBaCP1iNyh11gPR+RodjTB/O4W2TggZiLjcq4NdgcPxij8ewk6nGDhDcKenKjA2CR93qzDvtftMZV/ykXtcHyM7JGlZm60bvzF9TX0Z5g2vcRfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPShrRCr3mkAsJ25VS5WXbuBGe1oxlNp3j7md3BQGN0=;
 b=gWcTVnYcCSpiGzykYaOnJ1f25ZcRyam9F7gHs42VmJlncU2mb8hC9pTMI+1A3RbRw6VeMONyKvLZuh87RtpV1DGRp9gTY41L/9DaAfMwCgp6b4H+XP9+zg7WYC1IDYGm9qKNXp0mifZJ9P6aAlbZZgXSZeGWkYhnyKnKC08Lgkc=
Received: from SN7PR18CA0004.namprd18.prod.outlook.com (2603:10b6:806:f3::13)
 by BY5PR10MB4386.namprd10.prod.outlook.com (2603:10b6:a03:20d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 05:25:24 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::6b) by SN7PR18CA0004.outlook.office365.com
 (2603:10b6:806:f3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 05:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 05:25:23 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 00:25:19 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 00:25:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 00:25:19 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9] (may be
 forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6315PIo14108375;
 Wed, 1 Apr 2026 00:25:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] board: ti: am62dx: Separate resource management
 config from am62ax
From: Anshul Dalal <anshuld@ti.com>
To: Paresh Bhagat <p-bhagat@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <praneeth@ti.com>,
 <vigneshr@ti.com>, <bb@ti.com>, <afd@ti.com>, <nm@ti.com>, <v-singh1@ti.com>
In-Reply-To: <20260325070804.3037288-1-p-bhagat@ti.com>
References: <20260325070804.3037288-1-p-bhagat@ti.com>
Date: Wed, 1 Apr 2026 10:55:15 +0530
Message-ID: <177502111503.1449064.4221122982795542475.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775021118; l=230;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=paRGdau+jSGLNmRYmYQ2uu6Bhgcd6W1uk7GzTrTJ13U=;
 b=7JUkZdLjbXbjdU+Y7cFKzhvCuZryXFRYL9+5Y7FhgR86N7raR48qgzymuLMtJ2mKikS8BU6CM
 ZjYtEhNuEYEBb6iC4AweW7C0RYwGLfckz1UKQB5WmuAqLozDeIXT9s9
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|BY5PR10MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a020fe-c806-4973-7445-08de8faf1346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: zqu5acueIc6nbH2iizHTE9HVyzv9QViVYAwNbVUnkzbwKMVNePOKGOORSheE9XQMMhHw17IG/RfXqlikO9myUJfkb+Pq299qucGMNU1zKDzHdQZC+WBPsyqoXOX8x+he2u0DzFqMI5qZDx0YkkxZFZw6mw6MMmeJT2SYHazjKn0crG5tz/glPEVayvsNeId5PehGUngsvEmvGfrhl0HSojQ/HLBTgvq4MzpMAjUZshfQYVGPwES6g6s2+Kl5EBnRwfGVHn3ZcuhxqWlln+cx8TY7CMN0CIcAoRkmr7mMmsJzq96Kp/swvn2JCuHZ2rXSl3f+zVl8oEtED4tLe66oliV6Np44WSmEqpkeC9yyO+kK3sE3RZa/4mYPZ5EiS0AQUMgQc7nzg08m3jqqDSHzL/k9RKlvfseRAyo8IaPngS3Rx90IL8beK059TENBAyoD05i6uih9tvAxa9ksDG+ABapQGjWpopl/ClQxZEsCeQPm/GTfiZEXi8dus5Pi/AUzlZQtM9xp5+JouKR23rtr2zBieBTYihey/EG+20d0TDrsyotYRUzl2pqCHjLC0GHu/yf7sBcuk+PLzlC5YtFAz1ks39dvaOo8K7+a82ouRbuJ/NIrnMxJJH0jlLjzM34Ow479JgxPn20EJw/HYO8YaWN4/ea4VfIlz5fnKCZCS5pdKn7eeF7keqB1Xi98af1q11s+OH/5FK8gPxLpyAGsUYWy3jzevkQdx4KvuOxo9+AOkLJHMI07rmEecfHVAS8/jY+11nbUXHflmLx1vPaWWg==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kuO3AtF/mO6yqfTUSsb8e1jd6CxysBahnqMQNMAU81T4RSII1YH/zNTI+GUY6xvKThMgu9JU9MI5FzSdbPBmqb4yEdWMm4Ga93K6IiWhmZA/mXAmtAROFrJS3PatZHq538j1g9FoxdLPkG99mSc9cRqcf856rAmg1yIrpzJ8S0oxzrLagMeL5jTVu2Ca5sOPKEtKh2rSZHG0h49suAAyQoy+FRNu0wki6hF09wTLYgltpdixQjqILybqa2DynZFlOdAuA17WL0igj3Vvgot8FPCXUiC+uZlkkxY17xhvepL/IzZnzMNftliz18IPLM05hXwpSlima/Chgu6+cfdMlPhqBP5moUASsjuYh1MoNqvSuzKCZLM4sflyW6R5T54vDT/4o3a682oinxwn7XCsbagKuzh8JE/afGzJrN8LYQ9gARmxmd+quYfHJngqCzEM
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 05:25:23.7843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a020fe-c806-4973-7445-08de8faf1346
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4386
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

On Wed, 25 Mar 2026 12:38:04 +0530, Paresh Bhagat <p-bhagat@ti.com> wrote:
> board: ti: am62dx: Separate resource management config from am62ax

Reviewed-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
