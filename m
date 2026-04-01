Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA9DD35172
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 10:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8A3A84020;
	Wed,  1 Apr 2026 12:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="p0rSkeiJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9642840AA; Wed,  1 Apr 2026 12:25:16 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B746F8407E
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 12:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZZtVd+Y2C4RMrGuVvsPVxA+RuRITCntjiwEaXLXv+4+/XkoXb45jvTG4oWe69mqLyHD7P5aCS36LMGGhq5H/+zf25lyGIBSF81PV7zrAYrRfF9VFYltZFKgsCMW3OuJr21mEGCNRhYJGG0gldwFXH8mB7BBT6y2+gAMQXN0nq2otrHGZhctdNfu4m5cLVDwkG2qaBjkMS1TFTjX8qGbfz4u3Io4ar6ndHlGzn6fmlJycztvLh340pRWGoDRlue73LsbYe55Wl5gotuBn8SNLJx5LcLiSW95/+xq9IsRVd8Y7y0nmtGXeJJjBKjqkyPumXzhNiafAbS+pKbANqkFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGVi/O9uaQaSA347V1tZ+7/N28U2x5Do5eJTVI3wbp8=;
 b=ipoEQZW7OLJbhcogOYossQZvIotWb0VFLwvKYrdI2JeWsxKU3nBs3kI7G1JE/Y7SKGFwAOwaN9hMx/XQBEP4y4E1QkwZPtfdYlxdGGAPC0oTsXrUtKiC0IO1snLoRuw9PI92ctYgUb2iNgyxJKcxmz0JdDcSsyKL9C2zREIACUI01LxNq1gtrQUuENuGnYjqb3GJrDQ9DQVSo75mQCkFkENY7nGYy/8V6EqyZAy5SO/2AK/3dvQ44j1I5Y3a303b2/lIqVpGKm2arM3iEmv0anuV+3tW8Kb9QFT4sUNmKA3Mp3NyY1WCpjWBKxhaIuxuLz/SDQeqJwJIiLc4Fsbc8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=mailbox.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGVi/O9uaQaSA347V1tZ+7/N28U2x5Do5eJTVI3wbp8=;
 b=p0rSkeiJQsEII7yZNOpOLJkMA6fVDSl6NBeEUdE+nf6EBmv3PqTqzLZRk+WO/pC/rocSH0aQwHir3Xn9e8yPYUG2/ElqNxWeEyMAWJr18B5W6pgXq5Bj9pJLP/ykMfIprqvRA+by/56+t1M7IMr7Sj+iy4Z7bWMMQDF2DmkM2qc=
Received: from SJ0PR13CA0064.namprd13.prod.outlook.com (2603:10b6:a03:2c4::9)
 by CY5PR10MB6168.namprd10.prod.outlook.com (2603:10b6:930:30::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 10:25:10 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::ab) by SJ0PR13CA0064.outlook.office365.com
 (2603:10b6:a03:2c4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.16 via Frontend Transport; Wed,
 1 Apr 2026 10:25:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:25:09 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:25:08 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:25:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 05:25:08 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9] (may be
 forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 631AP7tY4093230;
 Wed, 1 Apr 2026 05:25:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/4] fdtdec: Introduce fdtdec_setup_mem_ram_top() to
 determine end of topmost DRAM bank
From: Anshul Dalal <anshuld@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <marek.vasut+renesas@mailbox.org>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
In-Reply-To: <20260331080117.2370092-3-ilias.apalodimas@linaro.org>
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-3-ilias.apalodimas@linaro.org>
Date: Wed, 1 Apr 2026 15:55:00 +0530
Message-ID: <177503910097.1968416.12481135125773540508.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775039103; l=485;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=SnmV1vDz1NME+KZMGaPZqokXzcQaMBULOkNdpyVYtDc=;
 b=g1WxFqzD3oRzLl6fqLss8941M94UfjhT27PgNaeyy7AEHBWig6I4Wc3moPPYTg+yAhKOyj21P
 pF2/X0deSnzDO+GEs3GYv2DhAt9WSc8cAj0UNmSPT77dnrWqwegFDvS
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|CY5PR10MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 3979078e-9ce8-41de-bbcc-08de8fd8f3d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Fdr21xlLFNYC3YAZ3arF+E8ATxFpJgPkUU57Fnn6x//HglaqHotpqONcfeparvb/dgNGhQs7O4DjJetsCR7Wc6mg88Z3DmWXVz+u2oTWPTxsh+bsiBgbl/OZG+th+qNfIjNJcC/zhAZwPHGERGxdtRgzGkUlA/lys9ltFb0O9taHUeZAt0SIxp9LChQVkjVDoKXO3pMRnZsYfUTWINAIEGSTpA9sosQXRYs5xeN6BGBvpf586+HpoTxqd1bcm5oTQAiUWc+eeX54D9ScTdMXujFYIKlQbkzdLYmkmjP9ciu0cfQCTn2x+g7NcW+o9zBns1/I3G6JriBnCGR409L+CaJrmNijpt9WrtI4vzdbhOd825ganUMoJ6tdzO56vfA/1LPouPa+OtE3Bd4siSkwQK2Pu3fjADvCat7D4R3o8MJiyIpex7I/aQVhHJyLmesvg+p3DRHp4YiJZDvmp9q7ojJYRa/d/tW9KSpKsJaiGgmH8lcNRsLOXXZC1Hh259phoTi3GaiXi/ShQAiaaDhfAxdFtj+Bv91v6r+IONLlFXxGqWb93Fj7SP3RNOIQBbN0bIskUzLXdSNgvy/iPqvKjFtonE1aIfic5ndtV3zZdwUdCsieh6lE+PCV13OWjd8a//4qS3ABCQNXZY5RzPQO4JfkK4+zXUicD82gSLUuM+1cU4UeyyeGxRp0DiBpEHZDefQuAvXZYjpSQARbOP+EWe+cDwo3BZwGrpypkrNJtWZ0MRjcT4VxURGAtnea6fy9LQ1SUFQZ2oMNRMHSVTWiPw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MZ/8iz4LAxE76bjyHdLIu8XBVK1ZCiufyADJQztxnIxIqPgms3NsewQ6IH0eX5EBHmEw3o8UfUqjL+tN6CeVoBqAyZeRTgweykW9kPathN+YCzjswdWUk9A+OyrD+ZFqWJDS3amDcLrUVbllMgqR9jbyG7sKk6k3MEMLkI9nPHFobgZZVS6J7J1SJkuIA36UucGkTpoK7CuE8Fw1AMdddYFSTfhjvnWBj4VzvYr6fhHDmBhorLk4eGRHOwnW4s8ei6iNQ4Fot7QtwchROhWqJRoo+8paZ/FfnM8Ddnk8vVAW/ZLXwxgCoXIshGJ3A6CJpjtx1YpIxDxkJZfjJS2AYMaiqxHxOGi1sZz5PRQ6xagaFruecxITpx+kxixqXgM483xX9ZMj0Gmm5SIWGr1xoX9kF4iczR8fbFJa3jrZj31kzZswrWX+AZ9dWa5w+JJW
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:25:09.8251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3979078e-9ce8-41de-bbcc-08de8fd8f3d2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6168
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

On Tue, 31 Mar 2026 11:01:12 +0300, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> Introduce function fdtdec_setup_mem_ram_top(), which determines the topmost
> address in the last DRAM bank, to be assigned into gd->ram_top in order to
> relocate U-Boot to the actual end of all DRAM. This makes use of iterator
> function fdtdec_setup_mem_for_each_bank() introduced in previous commit.

Reviewed-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
