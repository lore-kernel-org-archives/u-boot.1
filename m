Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B58D35171
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 10:25:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C518407E;
	Wed,  1 Apr 2026 12:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S+uBQL/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 824A7840B0; Wed,  1 Apr 2026 12:25:18 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 735D084090
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 12:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qN/46afBZHmV9BGcltpU5dK7Q0sJnPM5HOdoqk0rkd5onStD6lSFg5z3Fn6z364poU2aAiBHuE/UvJdYUNxRU/yQCcvsWk/3ENDgVShvzA5csOjzdcLpaV3PR0OTRRU9d2VBa6RYtVWiWl4I6JOXeRaNvPkAwm5nqSO0MLVVwk4a+GHlZlh/BDffrH4L8LMdvcKOpstj+rKLf0/Z0WFuubTYWTaBqvpqaW878qdpfBOPKSm52CgN3COXPozKLaWcp19mmH4NeBFkV0TyofT0BRJcmYc0KsjbWgVqh6UGj26+P1ltWmQU3i16Pg4S8+yQgmlHZ29y0QQaFSfs1Ti0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHosIS+aGOgu9zAn/+4VbiG/Q/waczeiXz0Wv1oVPjI=;
 b=BlJ3JruEKttB3wIqrgfDy/u1XXIA6JFhltuMZoMzbcGutP2K1ErbLwy/4U4aWaKDt98pC8RTTf9T5vakgiTVs3/oC+ZhTXzufbvgE69e3166WmDZggC4lmi6voYeJMhoAUD18X6lY/D+WvF/uimQd959PN5+4B+Q3xsPGx+h2Emd65U+JeX4jqJqe7/NcKzLVhzh+DQN5dZIiOi1aUailvli8YDtrGNWkq+/D6lNKFgoCV0E541OrGnhiu7yEB7413P2nHMMvcaMSEzOIVPMp+pZfk87quOB9jRIR93duuQf0x3vKE1dkeHhepksv7xkp60xbOrbSGNl2QaGg0bRYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=mailbox.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHosIS+aGOgu9zAn/+4VbiG/Q/waczeiXz0Wv1oVPjI=;
 b=S+uBQL/4GBDrkQhnPXWCf49lrVv6B7U8147CRc2vsGH0GgyjMCoVTaP5TbSDT15nuhEvegBsW1I4XLi6RRYBkkyP9jYNwdOa4f0yHDcSwsvnzq3fwKKdFkBmK5VQwZbdvmIA6e4dLszu6Zr87oZ8f39rjNotgZmlGm1Z3MyEqSA=
Received: from SA1P222CA0156.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::19)
 by SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 10:25:13 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::1e) by SA1P222CA0156.outlook.office365.com
 (2603:10b6:806:3c3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 10:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:25:12 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:25:12 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:25:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 05:25:12 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9] (may be
 forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 631APB134093349;
 Wed, 1 Apr 2026 05:25:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 4/4] common: Allow relocations on the top of the
 last bank
From: Anshul Dalal <anshuld@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <marek.vasut+renesas@mailbox.org>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
In-Reply-To: <20260331080117.2370092-5-ilias.apalodimas@linaro.org>
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-5-ilias.apalodimas@linaro.org>
Date: Wed, 1 Apr 2026 15:55:01 +0530
Message-ID: <177503910100.1968416.1541488991356907095.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775039103; l=951;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=3zxePvOGpma2KaeQ4iP3BCgBtIHZECCvmX+CWLZC2zo=;
 b=4mfZgTdd4g+YKBacfudEfyGWtX+NPQBfPLJw+9ebl04bmCx0UHAULDQHCTs/g7KJs7Q8oLs5x
 tWaWZ8cuPQiDdd1HO/MYVBGTy2zzXoKMYS9IYRzHhkBKq2Q8tWaxC/p
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|SJ0PR10MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: 3605219b-28e8-433b-c735-08de8fd8f5a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: oLvfq6Wcl7uQB71H8brmwhTYZcJuCpggEOavGcLmzdcAcKF/xsjfN/YEJnYEYnh4cGOLs81HO/navobckY1yljR9pRPeGu28DSwAh0WLQxVzbToqvW3xIhZiRbN58mB4t4YGwTSMiDS2/PcCrT4P3qonzOKXAn9SAWVW7EJFW8CHbruyMUFfTSu1bH/icRf4uT/MAsSfdmvrghfAtuKW2R0LYkE6A59MMEKS2EdLgmKp6XXWuyZXaleQYTnnZbf1IT9Oht2LyUBf/tUdsL8YQ89LZPlQgiAv4GXUyECqthCytWnzMf+/ZlOJ4bIpShl3cuxxSM066bjYyMpIUpARqW5Mte2rKUeNfgWI1Aa/ERxVNNR/uqh5hmqZWAaQbvlEj4G70jQGT5bHX9U7ARDcB5L2/KYZPjLPajIAkU5agCrYeLYP3OhHQI05kS5rY+LEFLfgX4QQC3oR4ep+Tca6NMq8tgjlhWeDIOC1N7TXz5/l5A/rROmCgqP2Pk+woa5elspHhtpK8jLfdRKqExxLY+n93L/tuz8yPzZNpyvT13fUVSUo+je9Y0/0lPsqb7Zpoq0hhJQP5G5HhWlcfjxxK2rOsP/un3VtFEoim3hpgeauQO6FhUIVDW999nqUfAdyPun6+OWX0UENcGngQnhx5lbd/HhAajmuU0K9qSVibIqNuUvn8uhoF+cFizZpqAQ8Dbu7FRWI+K+lVzoN7pJHOlxJignQhxXpneA04jlsRNX6OocHaHmdIHRPZNZEp7B9cPIp08bDb+5BvNavMvVBig==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ugIamTIZWkUWu3AK6Nf281Db9J+7EO6RlsT1vYrlx/kHgF1K3EWCVH4UYVpOse79cQNmGr6GNk+mcBsZi8mlmKp9ur8EXUnhtwnSqYnRb27KBGOUmY9fFsI9fAl8xTZgFbsKx1jb9lK7rw4VDUlWnGaYm/M58M1PYicmW3UmFlDWjPlji7/A6aWd8ide4BVZIDU0e0JTgtjybObtb8q+I8dvUIwXlyKv9H85PIydN+hNzHHZI5vL0DZqjorrRn3Z8qNV753s/ABMYBROJNgdiSzLQljjPbuzhkeXGyBG+mqsR0aAI6o6Gwz3EdtwHRe6sFtkw9A5AT7FEccO1mQy26yUnE0reKp5DaFkRO+Q1+cH9hhEUb5SkgIlPXMpRnr7IMga0F1Bh1HdXXsgntLMD8fwJC/G7TafpxHB3ASrlQgGJuIv/tnGWmZ7v+3PTTKm
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:25:12.9128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3605219b-28e8-433b-c735-08de8fd8f5a1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4479
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

On Tue, 31 Mar 2026 11:01:14 +0300, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> diff --git a/common/board_f.c b/common/board_f.c
> index df2b0dc899b..4270f368e65 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -321,6 +323,19 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>  		 */
>  		return 0;
>  #endif
> +	if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK)) {
> +		phys_addr_t old_top = gd->ram_top;
> +
> +		ret = fdtdec_setup_mem_ram_top();
> +		if (ret)
> +			debug("failed to relocate to ram top");

Should we not do an early exit here in case of failure?

> +		ret = fdtdec_setup_ram_size();
> +		if (ret) {
> +			debug("failed to calculate RAM size");
> +			gd->ram_top = old_top;

This should be redundant since fdtdec_setup_mem_ram_top already resets to
old_top in case of failure and fdtdec_setup_ram_size only modifies gd->ram_size.

-- 
Anshul Dalal <anshuld@ti.com>
