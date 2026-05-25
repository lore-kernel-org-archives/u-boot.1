Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A11CD5BD2
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 13:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99299847EF;
	Mon, 25 May 2026 15:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Lz/wG+ss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8466384841; Mon, 25 May 2026 15:52:53 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ACF9846F1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rkh88muVM0eWgCfQdP8FBGDa5HuC7NzLwZD4YtLPKb9AYKEIoICP9qDN7kCAOUYF8zLFqEewhnO0gamABJ34K43BUgT0KyGf0GcGVQHDC2E1H0OFMRnkwco45PeteWlkJgATQG2bxNsvfc4XGiLO+52lxkB533iMYUuJ7WI6YameFLi5ObERk2qSScRa/Mcja11fPT1wDudD7Fih2SpTgcoeIJ+6jRobn8SIXPR3j3SMslzV1zkq3aR+j9jFqTOOGxSCtoCBd8szbs3ArokhPWzRYMj/do2SWeZqI359BvxokYq9Yfucm1UdU7sQLOBf8oHK40T2tl4WZxNmDu2zQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhkMiBMRI2YqkXYOfojHOBm09lIzG/S208blPzWMr2M=;
 b=luqIEsMehJyxmzfLBu9elm5fMcl8ewOMXOPeR/ZsGg9y8DAE/Ymvx/RffSELKgNi23CZVKUDYYDvT+i/Yo1CIKfO/TbFCjnhY93HTMPBH87i2kjnwrVlL+0JZDgW0kTEd728bRg+XVg1+fzqHRj6BoLcFWyKgfb+XKY+tvr5cnYZLm/ZpLdpQ0YIOnHIST9VBXUD/MMlbBrgncJi7iizzTo810c2jcu1F8UB82iav7Q0GunCqj27K6K1ANWZcOMBziwfpwrUD9VAqZAqCRTw9/Ius+Nxie7NDCWNGkqN2E/ov1Pk2ufhcOO15mZ1YZPkrQFtSkpLpY/46vzvBWCn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhkMiBMRI2YqkXYOfojHOBm09lIzG/S208blPzWMr2M=;
 b=Lz/wG+ss7kt40z512SetF9s21j3finzlkRLcdtoKoQVzwzVefJfWQTLFtLpb+LnLXinTqWfvTpobOO9RH+wIq44SWrXbESP9QcdCG+8uOt09UEATr8/8Zh8qKVyfzTGqlu3D4mf8JRDuxS93beMbY9TxSXjg45aYqjRV0O/GkQNtAaircDJEUnjM/KQqVse37yvCb0sfZteEZ1KQC3+7k/OoyP0Ozfyv+6G19ct5Tgl9i3FC8A+BssQiC/wZkjWnLOZXkuVVEGrJfSGWI7emo2+cGa6O/jjncN/BvRUukYiKZUPbhy54MGhLjOMrryiQo0LOM4GgWwoUf+1VvkxLig==
Received: from PR1P264CA0115.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cd::11)
 by PASP264MB5193.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:43d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:52:45 +0000
Received: from PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd:cafe::79) by PR1P264CA0115.outlook.office365.com
 (2603:10a6:102:2cd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 13:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FC.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Mon, 25 May 2026 13:52:45 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id A0AC5202C3;
 Mon, 25 May 2026 15:52:45 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 09/15] tools: fit_image_setup_sig: set required_keynode to
 -1
Date: Mon, 25 May 2026 15:52:35 +0200
Message-ID: <20260525135241.88348-10-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525135241.88348-1-philippe.reynes@softathome.com>
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FC:EE_|PASP264MB5193:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2eb73459-bf7b-4496-b082-08deba64e66b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|6133799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: A+Bab5Up7OTLYE71fW8P/ol/WxFHrTKwU2vD0qUlgv+c59y/sj8HCXg+bapKAY3tFP8rZuW96E2xsgHLq0evXxQBF7qyJFKtzMql4VeLYiUo4zPrUI5qVvNxXYSabEHu2JlxqgRtlR0ByA2+2kNBYNd7ll7nVmq87eqElyF0eBxT/AQzK9UqU7i8pff8PEi7dtO8eGkDM41sZ7zXJkhwfhlH+UAxqky8XoPoPCI30FLKGnnXuxIhdVl458ZBsXLPRLMZy8MvfQsVZ9N0ozSzX6HmvqmKzyqXojkP42+33BKdwj3ag2qkW3m2LXPuhxH0G6A0+kFsIUpTguuD2hUSu9o7837EtXdDK54/kKuZf29R4z9qzjJ/36nrM5nuWDgiBzATzpqLuIuCRez7ckBLlbeyOKg1rN50jrgaUwzSo2s8fax4wOW+P0BfWigDR/fEWD8VkLgV3810P/wlRd0PMx8IdwL0zEH3e2/cWBxdpJl7KhS9M9q4IxP4JTrcvfSzMIzKaaT7OKD0asd4fN13xmn2SvKepuVDFnn/KJGKhHc8E3vgYYk537jzRl4UwCHe0eN3itkjyTTlHc5khg+H39EwDA2zGgfZ5p/5sNuA3NGeoxdQ0EKvkpgXGQriyYp/HMZFulyg12YJigRQQfRx4yQhFEnxuejiJkFrNEaNihukPzem/p6+VfLHsKPcE/4TiGwO839M4j0pZS+ArebEOaHd8Jv+80CNyT2BXoudAE4=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(6133799003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vIlwb/Q5lWXbK87/OHhHlKvPlI7+pZjrYVycAaLqeQvb3H+/BN+cWQWpkvpYoG4BhMNvXYCy2Sx5qlt8byrFr5N+3zo6ANT4mfMjgqlu7cxBJM1z5GumlJ26hK4uzeJflt4qDw3GjFTSdhAwQa3GBpqdQFRpDoVvvDkcRu0y4+gDGs8b+9gHUCK63iqV1ECIr56VEgSwEOGxY6EYQkTj4D7/1C2lnlYWH/AXtoXkjIGi1KScB2XYkndSaG9vIqLSTkLTFr/cDqelnIh9BJaCuGBml6zWUULl6hZQZcB0sFCDUi1NnhDPBwG87Fi02VY086KL5+hzPTi1rLUy7YKExoUcsud+XbI67eUDt5Qi90UNTLck29uSNA5hIOLH90FfhZ1SkV5exlkLTMUbjeteIsArP3YVTXIDnCNYsx7Tot7vIj/FGWGAFwhia7cT5/W0
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:52:45.8025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb73459-bf7b-4496-b082-08deba64e66b
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5193
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

When initializing info about a signature, set required_keynode
to -1 instead of 0, as 0 is a valid keynode offset.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v5:
- initial version
v6:
- no change

 tools/image-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/image-host.c b/tools/image-host.c
index 8b550af0dc1..f5681d6c1f9 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -198,6 +198,7 @@ static int fit_image_setup_sig(struct image_sign_info *info,
 	info->checksum = image_get_checksum_algo(algo_name);
 	info->crypto = image_get_crypto_algo(algo_name);
 	info->padding = image_get_padding_algo(padding_name);
+	info->required_keynode = -1;
 	info->require_keys = require_keys;
 	info->engine_id = engine_id;
 	if (!info->checksum || !info->crypto) {
-- 
2.43.0

