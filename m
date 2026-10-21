Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DBF606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UdZawwDa;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=rg0sQtcl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E89248119B;
	Wed, 21 Oct 2026 08:08:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Motbx1qu2yAH; Wed, 21 Oct 2026 08:08:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4D07281187
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792570112;
	b=rl3wGHHQoBBPE9YmPwlNlBkLyojg4vzHKhYNCdjM9zL8y5JFcVUFThnvpMaMNk0/FIrj
	 YqjCuq+Jjx7yzgAUjsWcAatP/uDGuTqoTvjHyP/wncgy3MQyspaZeUB65Zs7ZbckkNwT2
	 wGNiUE2EO/OtONXMXlgKDUDL4vliFHVJr35OlI/oya/9qXhO7jdoP3YfCvMzqBYN4UMp8
	 XoFdg+pI0R5gy4rq3rh6uwVLrHhumcHX3ETgT7iAOsAg3HwuITJhkkSOZOBgyATF2eb8c
	 54i0Hl66Qvm3vqVneVIwlgMnHK1kZRmi89GHwaJ63+rEsqKiZggPYk40G6DEloPs8hA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792570112;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0c3miyuyU2W2F65hZ8j6zxeFdu28k/DnEJFepI7xV3s=;
	b=ZDXoiydK8FYjr1HirHGe2edqcEu95dkjs2C3u1dilFNVuVc0sfD1YLM/TaWv52iLJ9A+
	 XdGl/3o9wWfaASBzfq/VTI/RAe2UnAl9JfDq5R0d/9Nb0twzcYMhqtI0mAq/qV37k7KQb
	 ySlR1R9Wnt9JaxDp5p8l7OAoYJ7pRsIk67+czb2uOg7fDpFIqmht+gtpzH/ImR3U+HwFj
	 uRmR04kCZSTL28kar/D5H6N5z7zLkBpJQFnYBp41v+GcmSEWiNVPBDcn4XEUlQSREgAly
	 Bxq5UZGmt+mL9Q9hbwk1a5Lsu3ydZpQTEwSw7ysm2rBe3rWke8lRXtRoXqWeN6224WA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792570112;
	bh=0c3miyuyU2W2F65hZ8j6zxeFdu28k/DnEJFepI7xV3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UdZawwDaPy6Fvfjl64RpTM0fdAhjkcNv6MLwv+02nfW61l8uZSOv9Hrwu3m+lmtDA
	 fpkiaXt9Pje8orQRdu9CEn3zpbXe8VY4oiEZlQpUrbx7NcOkecK+RV4Jmps+wc38BG
	 i4fuZqMRzP7lzGLhf4Ww3n+6wrWqBeLLRNrWQgjNnOjQ8OGdp7BtVRikLHr+fFeGv1
	 DKUVSQ3VYyCELk1IQapfIO5YYTnRwiAt6LLcLdKOl+dZ4mwQpU6nJAcT90LZKm7qTt
	 ctiR3Ai/Uj9wq/SxyoRuK/UmSC273+X8eMTooZ4UrFWcJpukq2sYp7HoRvyyAzM91n
	 JMJcu5yT1f9Ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D07281187;
	Wed, 21 Oct 2026 08:08:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A9DE769
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20DCE40568
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 11tUypQJe4O8 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 08:08:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E74A040728
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792570098;
 b=Iktu2LnFHZZjMWHfnhzzu4dbRImw9Zcy0Z2q05zXOsZxiQcfDh2+oSnqYQJT0ULdAPWn
 d8UJjrQvUzyap5nEV12tGX9doGurOd9h1H+x04r19oUYicCwTOLhlvcBtZN0GtkWOT675
 b9PSK0lHNG9Eki9E/lf/Q1BL8KZghc0ZslsV9vNu7SERO0tjy0NyyO+mx5UVzGEPHCp0l
 ftUOxNX4t7oY91EHNzq7vFoPUel4Ut4tbPO9YOQh4wlO9rECkD8BvScuKdyxUejj8UiWb
 i8PDNP+s026cVtt5v4zVVcTng0O0RrYZikkAfQp/WYHgr+BHGg5Xl4XRtC+NzrLl0cQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792570098;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=0c3miyuyU2W2F65hZ8j6zxeFdu28k/DnEJFepI7xV3s=;
 b=mU08sO8W/DvN+ue4glMH5Dkx+QOK0vei+M3fy8N6kzRhBAtydA2yLLbSUogd71Gy/lVe
 +tDuLb7YSymC2WJ3vdQGQAwLvPAGQbFtH3RafH7jnwjD7SIDX58HcP1jFDHBUGMKjLOZL
 Uo1XgfZsv8ZidS9PgSi68D8AzjYtl1cOFZ4cbpucjZu8QfVUC6FcyCEw9aIsN7HVgyvbj
 mWk4HTqx62w+rqpl7VkRpPPmTBR5eoDw1D99+u0iLqo88ck6ev0lRKIHKtDPdkZN8XO+n
 +2Ks2DpxwO+bbgBmcRT9h/W+cYs8YQA/FUNePZxuW1sUxrk2/rAINFsLf3Sf9X2yhpA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=nokia.com;
 dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=rg0sQtcl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=rg0sQtcl
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E74A040728
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UG3sUWGNLx8WvzhaDslRjz25Kr4GIK5wzk+8L3RMGBo1BvWtBbmJsiK1ostW3CI4F40v8xQ8GEAwVwS98glXs0Pzt5biV844X1R0ap2LBNdq5OgXfFXdDX8GTqwMPyjwgAoUBBJZRRhs/M5V0xhNWEQR3AscZ7vrbS1CN90Qy6M2C/d9X9Eid7B61oDB2PL4PrE2ngNxg5sTYeNufxQjKUA/kxdkwQjOQEFNSW0KiGru0Ju3Qll8cOBgLDznQdnmQXQM8KUW6WnEz97nZ0I9+ZGBlYCUOR1fi4LPuUulsX3JkC4H/IBPrM+GN5gHeD19F6BeAsDBdlLPZMpHlF31nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0c3miyuyU2W2F65hZ8j6zxeFdu28k/DnEJFepI7xV3s=;
 b=HJY6yfmx2rWafVExhq2RuBAmuM9UqQmsyB3BRwfO20kZJlr1IT4tsnM/Hj84Z5sqZxNi84KrVrPfs/s75Zx3cZjNz2CF5+lSF0mOveR9HwP/Kk+2BnobTVXYnVD+w4UOcQgQm0zkgXCxiwpop7i1gJgkvWX19fsUyxpz3sWDQaBu5KMvESCYkK72ZcusFjscOSZpOJ0GR8qCJQuWPEtyKZAMUzu+0LuDgap0LcVgCXW1yTF+1mUeXj5SWdkpYxVh5kjX3mygxAJ2heAsjittQhPde0SGaHUQ2btzZ4hkzElvrSD6mJpNYJEEW7lskI3TgW/eK3EQSRaz0aii0BwQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c3miyuyU2W2F65hZ8j6zxeFdu28k/DnEJFepI7xV3s=;
 b=rg0sQtclZMcW7jH/dDyz/aT6g+nencU3wIjSGE3BvlvxrGn/r48bdbe8tb3roLVmd+Pe8rgc80fYyw4UTq9Rb2DnZE5jbJdjKenb1tzXJZ6Xh3X+SWLGrprG6A8TVWkvm/4std3fD7eCuaVwsrubO6SWCJIY1T9QiCzIdGUos8kDNbQWCfEfvNuEl8yZ2qBYdTwZA9aphEOe790hUgC84q4MSLCCscVY0eL09qlCnqP9Nijt5Ho6A4V6Un/OAvCSzqcIxg30Vt6TF2vFOs/LR71Dgi5q2U8zcB9x3dMSkB8+yNvFEQRywgPpUVFbiKXT3nmozctj8EVN1U60ilUPxQ==
Received: from AS9PR06CA0326.eurprd06.prod.outlook.com (2603:10a6:20b:45b::34)
 by PA3PR07MB10627.eurprd07.prod.outlook.com (2603:10a6:102:4ad::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 08:08:11 +0000
Received: from CPH1EPF0000051E.eurprd04.prod.outlook.com
 (2603:10a6:20b:45b:cafe::56) by AS9PR06CA0326.outlook.office365.com
 (2603:10a6:20b:45b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 08:08:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 CPH1EPF0000051E.mail.protection.outlook.com (10.167.241.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 08:08:10 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 3DCDB200CD;
 Wed, 21 Oct 2026 11:08:10 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Wed, 21 Oct 2026 11:08:10 +0300
Subject: [PATCH 2/7] watchdog: warn if programmed timeout not longer than
 servicing interval
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-rinta-watchdog-gettimeout-v1-2-e7f3157b8bab@nokia.com>
References: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
In-Reply-To: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Yuri Zaporozhets <yuriz@vodafonemail.de>, 
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792570090; l=2086;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=F1M5bDNON+canM+gdFE/q+YTl2VkTqZKeF2QibPyKr0=;
 b=/TqJL6AusG5kknnF3VGO1A6K07/M8+TYQ7Sp+M74aGmRY7yaXkC30UcBjHu6nCEk2bANib1gw
 Cke48uhB2t+A2NUny7aPfJXF2Ui7aVmmt/+fdCulfyrPdvloqj/aj4o
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF0000051E:EE_|PA3PR07MB10627:EE_
X-MS-Office365-Filtering-Correlation-Id: ce95dc4e-bc99-48f1-0a01-08df2f4a729d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|18002099003|22082099003|11063799006|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: aO3pKcI5XN5nUOYc+lWBT/hXOOymhHNr+Mah4G2y4HNW9i0TbB3q0KkQJX2Hc/kb9zGpN+vwNXBjuylUiwwOcp8pj9HXjyLGQOzVW7MxYV53SrBEZYtdBfapq0jVaIzCqMmZcHTa8pKEl6Es0xXyEX3iyf4ouSaoYcgn9uHvhGuFcdHFrzCptLnT6DO/LBC29q4GrbOa/J9nTvpXx5XbkT9F7uaHpkiqdyEAm/iWiLAL0Tu9Mkiy0QKCyJccnDI6kRPvfl+y3b/BbnvztNrQyhSvjgW4eTb1TYPRXS0f5RVKd8VDkYuLx7NALeTf/zq9Nn+7X5BVAw7ZUIbwK4+SUaYbZMfp9BrfdaOQ6UF3SMv/G3EViRdyS++otaBhtmSpUJURek5If1IL+BmxZmEd4xNt4l/XpfZ4kuuc45VUXyJx0PC/CveW8YvY7SPEWgdhZGhrGUnULwMzSrDi9zn7pSn/KHDt4eaZ3logwD9WZk+KWzUu8b6HNMAfUYekmADsXRypT1iHij0Zd6TyyqTQny/SmurAd15ppYJhvdeTNin3FeBagfxoQFXpCjKsyp7mrzoaNcmMAjhnUG6ibc3Y3eV9knBx8QggQ7AEDI29Eh5k+m4maz5OWvqx5mcJ+0CzhquvQlHsZ65pFJeJdUM/tcVUDMa/85CgZhHlJKTD/AU=
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(261009223027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VEmgkWEWqMxTAThnpUmB56R7PpVNUAIy4b6KpyWgtr0RFmqC+AQOeHF0OvWRX0oBAFb5VpqXHPOf7hpuzx4YzbxDiOBKwuL7Fiu0v8Y+6Pbs76vqMjebSbSwAky0PFcE1BGjPKt5tT92iRSD1BYJTcZitphD3r/nfBqNMz/5A4dCF3gZhYKFP/6HZuG9NVh/rATTQsL30dFBfRTk3roVTDzYEEniYfa0bR91O4IWjGw9BGj00SomrQholJ7vIKDHpp5IlS8oO6JiouRJXhp4H88b325M4FaRFQcjB5Gaw7UEGa/RKkXSw2SH85BxRwwTruY0ev0E0xMXqc1ZoFhlcU9vNUDPzlUQpQmMNrU2EILCI6v7/+AcoPTfAaX6hS+yg3KLKDOuIYKX4NBSaWI+m7fAAxQ1Yam2bdHFJNzKFIj6qGF86UDR+mrLRkbGvMw3
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:08:10.5951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce95dc4e-bc99-48f1-0a01-08df2f4a729d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CPH1EPF0000051E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR07MB10627
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a driver supports the get_timeout operation, wdt_start() can print
a warning in cases where the programmed timeout is shorter than or equal
to the servicing interval.

Suggested by Stefan Roese on the series "watchdog: report effective timeout"
[https://lore.kernel.org/u-boot/20260823071511.687900-1-stefan.roese@mailbox.org/]

Suggested-by: Stefan Roese <stefan.roese@mailbox.org>
Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/wdt-uclass.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index cdbf1bc2287..57641eb9045 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -146,6 +146,7 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 		char req_str[32];
 		u32 req_s = lldiv(req_timeout_ms, 1000);
 		u32 tout_s = lldiv(timeout_ms, 1000);
+		int get_timeout_ret;
 
 		svc_str[0] = '\0';
 		if (IS_ENABLED(CONFIG_WATCHDOG)) {
@@ -170,7 +171,8 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 		 */
 		req_str[0] = '\0';
 		/* Check programmed timeout from driver if op supported */
-		if (wdt_get_timeout(dev, &timeout_ms) == 0)
+		get_timeout_ret = wdt_get_timeout(dev, &timeout_ms);
+		if (get_timeout_ret == 0)
 			tout_s = lldiv(timeout_ms, 1000);
 		if (req_s != tout_s)
 			snprintf(req_str, sizeof(req_str), ", requested %ds", req_s);
@@ -178,6 +180,12 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 		printf("WDT:   Started %s with%s servicing %s (%ds timeout%s)\n",
 		       dev->name, IS_ENABLED(CONFIG_WATCHDOG) ? "" : "out",
 		       svc_str, tout_s, req_str);
+
+		/* Warn if programmed timeout is not longer than servicing interval */
+		if (IS_ENABLED(CONFIG_WATCHDOG) && get_timeout_ret == 0 &&
+		    timeout_ms <= priv->reset_period)
+			printf("WDT:   timeout %llums is shorter than or equal to servicing interval %ldms\n",
+			       timeout_ms, priv->reset_period);
 	}
 
 	return ret;

-- 
2.39.2

