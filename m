Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB64EEF4ED4
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 12:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52F7A83FA3;
	Mon,  6 Apr 2026 14:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tQlaSW12";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A7EF83FA3; Mon,  6 Apr 2026 14:19:56 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C62B983F98
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 14:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qB1HjhAJYcT56hqXHlD/KgEDvhWBP0WnFrouQRe74XQ5jwzQZ7/uCW7YewssWNzRro0M3WjFjCd8j4Eh3wcPkKEn759WKYESKmiSBnovbI40ccyaiu3aLeWdhtKBT5h636/vg004nFLejFoSXtV81N0XzO+C1Xu5como9+Ve3KXeLNfbLvxofahCvAe3lCFs5+3vBe+bOIblnAp3JNzffNz/2ANQ6I3dSY36OG6cmIpOcgrslYxpuTlyvSg3EgopiM/4tWF8v3eZcfN1eVoT9vEF7x6dYOVSwXJrr2Zs3OVG+WdoFdDRpFqcKCgxpjjTFro1luGBUr66Gl4vjJKnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soEDHYhRDWVQLqsgjzyxSF03ZWCiB2/ythBIRtX61bU=;
 b=ltg9pOk/UAtkPtCk5BXkD3zAeKOsoD6zdqqv+sCcqIQtSyDxVsYbfQfcC53A9Sl0Pz1sP5VpJUGfownsoz914lnZp9Rk6cgK095GGMrutJcG388A2z3w6J5T4YSlM3tamG3uGKy99oc3Lis2GBwi9XV2fS7iA1sBIbBSdT9V6Frp3NqM1ZZKzKupiqmcN2IPzoieeOzW3qbyHPcHFgguOP0IMoNZJdMV47ZCjT/OyoSdM1Vs8Q1QMRjCJA4YSmN26qgqFWOtf1eA4JJtMtGFun/qAFjU9bPbzoz6tlIZwZBNauX0rPePpD8o6sejXt0t3Gx2w+JMRyUvYERZMZ4NwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soEDHYhRDWVQLqsgjzyxSF03ZWCiB2/ythBIRtX61bU=;
 b=tQlaSW12gmQ+WxikiMkPWN/vKDR6vifhbx+sFcMwTC5jHl0pCpESFxqX6pFZFvB85NmvFc9/QDHYbf0paHv+1nAx/lSeE5xf1P9I8XnhbcSq6DZz5ULllMS6IEBxgQ+BE5hnuZ7Z8GPRWqG8c8Sgxd1ii4blPMWWpjZBRB2oERg=
Received: from BY3PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:39b::7)
 by SA1PR10MB6638.namprd10.prod.outlook.com (2603:10b6:806:2b9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Mon, 6 Apr
 2026 12:19:48 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::56) by BY3PR05CA0032.outlook.office365.com
 (2603:10b6:a03:39b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 12:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 12:19:47 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 07:19:47 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 07:19:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Apr 2026 07:19:46 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9] (may be
 forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 636CJjIh682329;
 Mon, 6 Apr 2026 07:19:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 4/4] common: Add an optionto relocate on ram top
From: Anshul Dalal <anshuld@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <trini@konsulko.com>, <marek.vasut+renesas@mailbox.org>,
 <jonas@kwiboo.se>, <anshuld@ti.com>, <sjg@chromium.org>,
 <u-boot@lists.denx.de>
In-Reply-To: <20260403090109.3564638-5-ilias.apalodimas@linaro.org>
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
 <20260403090109.3564638-5-ilias.apalodimas@linaro.org>
Date: Mon, 6 Apr 2026 17:49:39 +0530
Message-ID: <177547797999.70791.5582291609719254544.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775477981; l=625;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=suq2z6lEQToF8LIghs4od/O2WjIrZrVC2xL9mUASwcU=;
 b=a1lpNdWb0CWV6NvkDu57Ef2ErnsENMzwctGXYxeEgBgB6T4qZr0FZRpgQ8B6vHcxH6pbwYQjd
 2YJX2k07zIGAdY1/abIz59b+ibAVg4MoQ6Q+Sik6wWeAKYWIPp4lgnc
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|SA1PR10MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d791969-55fe-4f9e-6bbb-08de93d6cb5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: z/3RkHLRxQQBgIu6GRyvBWpDIRnL4ssxnxC6gna6yNYDoAWrZOSwFtmdG3T+qtCgne1/9gsY67X8kKVtdJ0DzckXQew9eVppIUdSY7nQMN3OZs9X5p+OTa9hMePt2Oy+a2BaOUnmcMJtGIbRS/cccYUvxw6YJBfA8YVsaRAF70E2P8UONmb1Pbg9xtKOLN0RX60n9jBHzN9YoTbXinWbO+X4FfIFQVl8Nwmo6tsYaOR3yvHGLJTAV4sUzJmDAwnQET0TL3tgLhiXNCdqxiGbe/QoEUXVwJCWdgruf3MFQcPgP7jBo7UIji7xHm35/kjPGK2SYgInoCVzhXMkjcBMuMCSYUojb5yoh+chkcFlPQkgUty0gMfcxUNWyeBjIUWkj5hCSbRikePjb7pwHuLEkx9eCzgCc2WrCLKkjrI74DO0ysqdtvDiPhMWPJwVsxBB679VonIg1r6pHnREpAoYwoWPTMRBkdG4owNnU7xnw7YZrkWha3ziPDGpyrmvkVSq2tt7UxwanecldEutXHnBqVR/1zOuuFCsgu6VA89h8pvHQPzJ7TkYwUud6wWBNHkN3/TLLrDh1LOzg0kqMTXfk0irrOkTdAS39URG24QtMlpXRvZGjoSPGnFCYnczN453yyYISOYM/9zHU4LMrRGoLKZsOBhBUCJ7/+rHY8gSm4UZm0VA+G69D9l/3LTmPrGmpfWZF7ymc1vXmtMeIb6v4bvDNNVt6P9smZij1kLToFsH2KGNxl0qszKaklmByG+PL1RyDGlB5sJoTGz/g3QIxw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5nLZSROIRCx6WCTLRDhlz1TPgZLE7/fOz4bOskyzxWSejM//hutGBMzmVo5mRYo+Yxt6gqowI9SjN4bKXqjFZ5yxiqTxHUYi1iaBymt73nYZl5uPeK+90SClP085SKlpSfgDVrAxgLpfeC7c8p2UdiDsBy0OnMSzyQtL7qYP2dil+QqZBUVFy6BQhcVhjTqk5wpWJpArD+8Qdj7dKQ/PIbwOLmjTsa/VQicS33jbXkrSzE4kz7mTs5AuOqkInYgKNhS+Txn2db9Laz6x5DidDstxfT7N0zh1kiwfe6NW+v9azk0PxQN8ljWucK9wof7GmU5BK5+69wZKa+jm8pwaQAPDia+nzKhlkgjVVg/tXn1nBk4U01MwdyG4g26PNGGHtmgmhTYnx3JyDG21nkfmf9v7oKYFTzZoeurTDZVpUQptaTUw9f22J3KNtuXg0/xG
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:19:47.6182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d791969-55fe-4f9e-6bbb-08de93d6cb5f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6638
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

On Fri, 03 Apr 2026 12:01:06 +0300, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> diff --git a/common/board_f.c b/common/board_f.c
> index dd5518b60db..2eab344037c 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -353,8 +357,19 @@ static int setup_ram_config(void)
>  	 */
>  	gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
>  #endif
> +#if CONFIG_IS_ENABLED(RELOC_ADDR_TOP)

Using a regular 'if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP))' here would avoid
the need for '#if' macros around variable definitions above.

Reviewed-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
