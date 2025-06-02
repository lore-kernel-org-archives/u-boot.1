Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254B5C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 15:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A199680F9C;
	Mon,  2 Jun 2025 17:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="RAFkRJ4K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D28082998; Mon,  2 Jun 2025 16:52:41 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21DFF8006D
 for <u-boot+nodisclaimer@lists.denx.de>; Mon,  2 Jun 2025 16:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5lqJjMEintMNo86qbkFsFh8UU604DsRJZgxV5ijlA2Lblc1tZvbBX5ZXJ3svtrw2ImcrtpYbsBgbNP74D3wQXQK/Yz5Oyvh3g5L+fhv0Rfe3QtfKdQZ018Qt7u3KvKYYVHbl172hbnx7ZzNmIZx9umg9V+tZu5XKYpyCd+XSXdqCy3mq/h1rXoE+SEr4BmnykQVHUqWiDRERCN+2kLNvrNur6RAKYeJdaaq6MPB99EY9RYrgLlUBYAKmqjuIxLfqWou5fSMhjtybb9Ti+URkHcJlxp71oMylFQZ9Eqki4vq+avoVvz+a+O92rvhhSxuCHcRGztshkRji0pg/9lzGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfp78A+flClENTXMCSUG6EFW4TL/mfE3ldtr6KxqlLY=;
 b=hCVp/y3pg9800x61Ei3VF1IBzoXILLdB1TkXeGAUHTMgFfpcdogFLNYBkNCfpbQQMiEW8yvhz5mSHUQgd1IEoG8n5mrl2VldBB9Cdygm2qBQzUDUDS98DUhsPqDm8tPjW6I/ryvb9ua/sh5wxCMNhpQ4Yq2axZQVAKoH1SYEkI5Jaj3q6wGxRgwU2VG9/rGnw/d++BHXQUiYVVKt/VQMRXxOKhO879t31A5Nx2glB9rZ3MPQo+x6JwiErpu7FGvz315YeJB/YOY50zDiAQHURP1Tf5yvQKX3OCFezKWwPwNPkYHSoFcaI9OiwZVCbIHoo2UYOlfhHumDAc8kqDm3Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfp78A+flClENTXMCSUG6EFW4TL/mfE3ldtr6KxqlLY=;
 b=RAFkRJ4KZN0EC/NqapBQiAE90N51QVHXwSxLeSJ6rovbDJwkzQYMr1pVBrrQcwwah2eHlf/9USsnZbtKiblJS0//qZf5GPJs/BRAGU/dGtg0CYcvH7FidSgMQa4ZuLLz4kTtuZkH1DIbVGQRLLgmSxClK4cZi55ReyIWzYzclyIMoqcqQjgYuaFGlhikAuTR45Xq8VxZ44ULDCM5NrhAbLkK6VGVXHxgasvI/NgnHoAySSWcQupQHoQR0qhietTDHlxrFll0OxNXVoah3uNUIkzji7hndBqE0jZXrcLAFCChnqeloJWU5lUKTz6X095XeMFPCbFIXHeOPPidmHIsJQ==
Received: from MR2P264CA0146.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1::9) by
 PASP264MB5057.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:436::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.33; Mon, 2 Jun 2025 14:52:36 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1:cafe::a7) by MR2P264CA0146.outlook.office365.com
 (2603:10a6:501:1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Mon,
 2 Jun 2025 14:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Mon, 2 Jun 2025 14:52:36 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.75.47])
 by proxy.softathome.com (Postfix) with ESMTPSA id 6DD392018D;
 Mon,  2 Jun 2025 16:52:36 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: sjg+nodisclaimer@chromium.org, trini+nodisclaimer@konsulko.com,
 alpernebiyasak+nodisclaimer@gmail.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot+nodisclaimer@lists.denx.de, yan wang <yan.wang@softathome.com>
Subject: [PATCH 0/2] Binman: fix signing an encrypted FIT with a
Date: Mon,  2 Jun 2025 16:52:26 +0200
Message-Id: <20250602145228.79778-1-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|PASP264MB5057:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a1f8facc-2ec0-4e20-efba-08dda1e51d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dCEuPBNRxgrjwPKwez693I0BJ6ON7W6cLUI6vM+NRsVlsoeBSe/AnOpOqWJ1?=
 =?us-ascii?Q?f1oGGF+V8A4Sn44SmlGpIZWmTGktguBTW79IY0FOknYtNBaPlW3hec0sWiOz?=
 =?us-ascii?Q?qCiA6wZH3J9UwA+83Dml6o0HKCz39BtLhlAS9oXZitd/Tqk4Ar8RZWIFqNue?=
 =?us-ascii?Q?n5aGg3oiqvwLBf5fkKV2IvBDk6sU3oUGpM77RFi4lK5MCZtGHyfgIZdunm2+?=
 =?us-ascii?Q?/yx7fsLYbteSzGXijlIXBgYRrBT4Xwgl8chdoPJTzSWf2jBlhO6pDx27IgIM?=
 =?us-ascii?Q?LF0fTt7xYeLNIlo8Kf/1+P1/K9rWeS/u8N+HvMCDif9cOKiIIrEYUbLDgQJY?=
 =?us-ascii?Q?/VrXtdaTDv7e322CaC6kn3qOQ2COIIIr8KxO9V6pqY9nGOS1u5VkE2Zh0HCm?=
 =?us-ascii?Q?mCzyBHqKBt6uv7e7kWthbHDhcbUpj+nIpX+MXXpvZ8GXeTORdDu9RaR+DzWN?=
 =?us-ascii?Q?KnFWyZd7TMfKbR/3D5LDNSLUFpJgcH4iZFqm/YplwnPfUggGLi5FCLN1BQMk?=
 =?us-ascii?Q?CwrJ2G6mGYDQsamihgskeTJe35TGAg904I9wYVrqCdZnmqEDJLfeG1IokBuN?=
 =?us-ascii?Q?iTReX+gfMGF4e4c5LBrwAyAEQLLbflGLbTLw8EifRWvAE+q87eKfUtyMCenz?=
 =?us-ascii?Q?Y0alE2ycwN0oFnClUPPm22n6mLha37BKxLzWvcZKjelw6ogbxLaToEsp0tAm?=
 =?us-ascii?Q?OLFWAtNCJddN3Zx6uV7jJ8M4MSlDuuuIiyoA9FszH0L33PVpDmTd8ZJuvdQj?=
 =?us-ascii?Q?D8pyPlNpkeN7wm2n+Fp8jinfOxDppIZyalO2TKPidO68uXG7z4MBJANFR+Es?=
 =?us-ascii?Q?1T+5x4S1Rt2/++a2ZYsw3PneAUWvpaICCrfoAgVg09HgI3jFuFW8w6yksfCu?=
 =?us-ascii?Q?hxZoeFg4VveAOcdRF5XgDdi8mir2NvLplnT7QkAntQO4UO7V8Huxq1N5fnfN?=
 =?us-ascii?Q?vH2/9TGZZcqd6/w3a9y7mVS7+ONKvZm8n16IMUTih+xalmuzcri7pDBUHzDa?=
 =?us-ascii?Q?OPP5+GBgIJMbbGrN26FMLmFHb2bX/QZj2+0T/N/u2yGvmPL/WdHsizi6mAZl?=
 =?us-ascii?Q?heVR08CgR3cahL1Kn9ZTQsv6sZjVRYoIAMZV1wW3CZbZAdxBx2O6Kl5eWi1R?=
 =?us-ascii?Q?udeqTFbWke6u5Xu4cM3jc2hBUNpHtioKyGowcNECq+mTugVjtbonhrzire75?=
 =?us-ascii?Q?Pdz1V0Xi8HmNLxwKUyn3/EKzQhILMHRxgH2cCyz8alHLFJOvhasWh/0/qj2t?=
 =?us-ascii?Q?ZHBG9WyjdwfmMUyiYrJ6bC9wxQLvix/tCtMdBUCYSZTGKcsS+trIS2Eu7Ch4?=
 =?us-ascii?Q?wKDrggcbjuAOdhaop1mOH0VupDMNGrLTO9S1t2qWcjDzW1G7JoI0Ien0cswB?=
 =?us-ascii?Q?Tdv36eLEYHmxyn5VTcMa35DcaeXa6I5Gt2al2pCuKkAXwDBAnYW9I4kV+W0+?=
 =?us-ascii?Q?F6nyfjV5OXoOpZgGrgeRtgQwS/hLY/3FFgwQGtQezCdT5KCBSQULGUvMEeIN?=
 =?us-ascii?Q?/mmBeQaty7IsU+hYyq6yWekNnyTYfrggmsuV?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 14:52:36.6646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f8facc-2ec0-4e20-efba-08dda1e51d47
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5057
X-Mailman-Approved-At: Mon, 02 Jun 2025 17:05:47 +0200
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

When running the test case testPreLoadEncryptedFit, mkimage has been called
multiple times. Each call to Entry_fit's GetData falls into Entry_fit's 
BuildSectionData then mkimage is called. The last mkimage is called after
the image has been signed with the preload key. As mkimage uses a random
IV for encryption and the timestamps may differ, There is a 
mismatch between the previously calculated signature and the 
final fit included in the image.

During ProcessImage, how can one tell when exactly a fit is well generated,
and stop the useless mkimage afterwards?

Paul HENRYS (1):
  tools: binman: Test signing an encrypted FIT with a preload header

yan wang (1):
  binman: Fix signing an encryted FIT with a preload key

 tools/binman/ftest.py                         | 17 +++++
 tools/binman/image.py                         | 10 +++
 .../test/336_pre_load_fit_encrypted.dts       | 63 +++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 tools/binman/test/336_pre_load_fit_encrypted.dts

-- 
2.25.1

