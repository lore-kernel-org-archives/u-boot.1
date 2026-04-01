Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E70B10F6FBF
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 15:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92CB484056;
	Wed,  1 Apr 2026 17:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="jYi6EFe8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F92F8407E; Wed,  1 Apr 2026 17:35:45 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B1FF84011
 for <u-boot+nodisclaimer@lists.denx.de>; Wed,  1 Apr 2026 17:35:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0/KwJ9BolzFSpYcky6MO/Hu1scHG4KX5B+Kkb/5cBushO4eCR3wqg5QdD/sIzwZIY/O8Fj363Qz3ypvphstjM8j9Hg708Hn4K/J9Y4RrtgIkQI6k0ySt8wIlks1JPHZ3lOsbJwIairFCYetnPdJZrKPyu3x+FN+uYGI5FpWVHki8Wi216sQNZsfvHyA1oYQkkdXORNA4DlN5EjiH+ibVC1hk7uWMZ9eHit3EpM0tLjcjUMcGd1PqNzaZqwgDx0oh5Bo0+g2KdALSsmg7WtWJKUlEV6lMy8GBVxCrndHy7jdeCofcHSuU1ZAcziwSdS/yuNVFkVo+wv1IAPbOO67wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsLSCvxOD6lj0XrJjZe2bump/Wsq2uDf8LJvcAK61hk=;
 b=ZK8szWc7FMnmWvioTOMNMBuER6vVraP5hZJuG2of1Nk5T2PKw6Eu0gpnQIZs5lb+BlSLs14y9pbCnBpIqj1SH+8SyVefY/uSPZxubUqNL6KaTNNdVkF8OWWPeBwusG7+mYzNTzz+ffsPwMXkM56qwRVPRxZlXvqwQSLera63y0BLzerlToFZ6qeUV97PaMJ21xL0/ABp6fpvFJZQzGxi96TEWYxVHt7FywY3I7wmYFqGB8qDFEF2MSJSB/yFPus8Z3QpmNgHFXyuOyKmRbr0HJek9kf0S33LAQ6mTC0ho8eqFvU32/l0YVVe5RMV6cNVHfmO0klJXwJNGZ5+VJbSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsLSCvxOD6lj0XrJjZe2bump/Wsq2uDf8LJvcAK61hk=;
 b=jYi6EFe8KIFUR1REOgQr8sEK4HQwdJIA96cszXw7sWihd3bfzkxy9WVZRUwURgc3KMSB8iM0lc9IN+amZm6FjKWd3ujv3Ipnpz79jTkYHJ+m05wWcUigpCGAILpul+FY0w9L9sqsL44UWjSjXO5hHL2ESVIlsNoY+SNkod4LnQc/Tl8cx173By3/TuY+0X2Z9Q0QTRShdUs90SN6WjtukHljNXr27Jml/ttJSic7YL3oiWzUIF/1j7YyERCVNe20+WTaDS16jtQPG99BN0/yR8SsGJSOjPONaeRBB9sdwaLjgBQdGcZKU1C6PXk5Kt+L3OPQ5PxENE7vZ8uiAp09Qg==
Received: from PA7P264CA0452.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:398::23)
 by PA3PPF6E5BD8CCF.FRAP264.PROD.OUTLOOK.COM (2603:10a6:108:1::658)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 15:35:37 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398:cafe::ae) by PA7P264CA0452.outlook.office365.com
 (2603:10a6:102:398::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 15:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019231.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Wed, 1 Apr 2026 15:35:37 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id E3D7D20014;
 Wed,  1 Apr 2026 17:35:36 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 yan.wang+nodisclaimer@softathome.com, u-boot+nodisclaimer@lists.denx.de,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 2/3] binman: Generate the preload header and sign the data
 only once
Date: Wed,  1 Apr 2026 17:35:24 +0200
Message-Id: <20260401153525.1541415-2-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260401153525.1541415-1-yan.wang@softathome.com>
References: <20260401153525.1541415-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|PA3PPF6E5BD8CCF:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e0532248-b141-4c78-b029-08de90045274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: huaWCZCwtmUQ/UATCxI7Rys7FJXqovNDudG+6MRj/AzybuNjdn0fYqHRT+r+UoDaJmu2b6XxZdYLxAjN4ZnkjFOhejQ0r39ZcyVnXGsrt3wKsTKU5xWnefKNuchj73m59RCKb3zk7lwG5rTjXJDVSxN6jwNhetfxRcf9m2Kb3BNs6lECSUReoMghuoXKY3fT7q76/aJfUCZp9lxzVSWFbTkFU0hgOY7PpEwOVJowgedSouvEa2GQ99jNsT72YDP9s+REuGfJM5m+iV2w0M+pqWE4FO+iKFXuTfxTA+23TCJmJAZWY5I4P9aKJK5EhXW7/zn8UuGzL0UfHE0TnIRQjgL3LWrzM6+IeANFF33hwMg2a7mHVvg5PZX0wtpPU1yLpa/py/htCS0aeC+jxO3cW+0DwhndnbWL3a4fLWUq+tNZ4lXuxGf46biS270jEFh0jU6OG6oDNXZPgsZNAVT3OB85qszk5JLcyn19Dks6ZqRXw5DRsAr2FgPgLHcqyLLPXefd8YUoEzCB/7mksMi78ylKYJceTnKj8mYCyFHknkZon6XVHEJOlGfHACb+LuUKNIcjmRN5Eauc/8kPQN718D7jtoQrUv6+UTsIEJHdDE88MURhUd+zSGcoN+/rqUNXMGibCqWWvEzv/CTd4F9AKU9iK/oFoAVn6FyJDyUZXToy3CF+DQuQ1TxJ9nudwsnZiiRWeNr3QQFVuhtJAV916VhRuPv9JRcAG4ePsDmJiUrZaQSmfal2hhTSeG3oxjRdgY+NervylMJ4zpuwMebnsQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8zCld8UG4hLgcE15cOaDS0bOuVKyRZNqtsb6piX1g+D6G3SljBZZunRLCbP2FocYJk0KXuLRQy8355uyBUdXwEWo719NExhws2T9Up8hS1vZR4t6aKY6lQ8zIMa0bqNgwX2T0CQxyESXvIdhHb1A5S7p9hathnYyyR09IkMMFNZcD64qk5OrZSTFh1PriQdErqnQ3DxUcARSKK327JzvSz+PaSxRUAC833b4tmX/D5qrZNup3SlVceFEmTAnAV79sjo0GZUKV55/a3kBQFdwKlZ2mzpecIOZPoNavKe2/0/ncBw21ZL1MT8izvQjzZFlM07Qkwz4ujnZP8aZuCs5LJg9cI4idYJ6PvrEfDLy+AfLobllJAcKOWjLHmJ7NAJH5i3vOG6mpuJRPkOoxJGIekIUhmF88qVdRaJ8qTnJfONJ6j9LaVWxOMbBZd+lfZ45
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 15:35:37.0374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0532248-b141-4c78-b029-08de90045274
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PPF6E5BD8CCF
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

From: Paul HENRYS <paul.henrys_ext@softathome.com>

To optimize the preload generation, the header and signatures are
only generated once all data have been collected. This avoids to
sign multiple times.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 tools/binman/etype/pre_load.py | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 00f1a896767..b950a540861 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -152,14 +152,12 @@ class Entry_pre_load(Entry_collection):
         return data + pad
 
     def ObtainContents(self):
-        """Obtain a placeholder for the header contents"""
-        # wait that the image is available
-        self.image = self.GetContents(False)
-        if self.image is None:
-            return False
-        self.SetContents(self._CreateHeader())
+        """Do nothing here.
+        The data will be obtained and handled in ProcessContents
+        """
         return True
 
     def ProcessContents(self):
+        self.image = self.GetContents(True)
         data = self._CreateHeader()
         return self.ProcessContentsUpdate(data)
-- 
2.25.1

