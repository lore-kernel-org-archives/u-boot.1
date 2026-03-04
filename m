Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B24EDEC03
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 04:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA4383FC1;
	Wed,  4 Mar 2026 05:22:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="e9NCaoR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E49D83E7F; Wed,  4 Mar 2026 04:30:57 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A5EA83F7D
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 04:30:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uh6tSPB4ViSW7B5zcWaQ87ts15YKBhyORcPSNhJ/RPrTBdHlN2ve8JCUg79yMY4g5OiuJj9GFAnn5TeVhVNfth9e1aGlqYKivE6QiZo4EwWUBaufOcpyCuikeeRh1Y7syKLF1p9RyVN688al3H5I/v5O+6wk5tDoauwTdE1yUU/C+Q2ordjNT9SCQzAigwIRKx6hIFBXg1m+Wsiyly+baNGp7s/QQGh7wgf9HvWxw3f4fi/HmXKV0nYT3HxuVxgbjYEDsQWMH9DqDLQ71kFitOT9twl0Fh0sxJdAhj6lrMpoqfxY5Rrsn7ubkALysQD1I7vEywq+7/TL27Zu/f4dtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxl0bb6mIpm4RrMPmNO+bNcRwZ3F7S56wuDq0dJ/FQ0=;
 b=EzMy4yB25iSXtXjzU2UYad6g5cLjRUAGN4KD9+aZC+P0TPmRCEC0S3f8oPjv+2JuyJTS1/B8tT+d9SW3VErbs8+F6lLrfE0hrnlME+zDpsNnojpjDUoFFmhZ4Zvvf1IAQsv+ZEUl1PYtI5uyhXi0bPRxqIYWt2WsV6Zr8UYsXK3iTlXFyhziqxX7bkeNCBiPwQzHeQebjdE1AhZDptaTj3tMbnz0UcAaFqmAlLnXckldC6bA1+6MTNKpQ9XU1ChObbzqPUe8f1g5BEEriRyFvUbR+NgnaImXYVow0EdWlnpmdGGSS1c/dL0Mzikp0jbaRUNscFqyQjtFpob0YH/A3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxl0bb6mIpm4RrMPmNO+bNcRwZ3F7S56wuDq0dJ/FQ0=;
 b=e9NCaoR6VGfUYbuFcCgm0zDk73I5mvuOgxx2P/kY4c8Xa/34a/CIndCnn4RVAeramcqcVYdzufFVaG4HRYGGbP1edALk/wwIb5xyjHYnyRIiFDSM+w2wcaX/SA6XEg9jiFNYPGeomGrUoGDynh25d47EppgKYBg5VzkuR+mwjuhtGI0QTzxbmSi+xjEU1QbD4BDoKAmWxkwcEA653c5LVrAp6yZhYXxjwfckdA0UCwZiROo3TKeFUiX/neJrWAvX/5BNtzNh5owL24axr7eMeT5wWQdO2VSYtRhNELEW1FmgxLvI0dzmMcva/CtsxMoBZE1VpBtV39IYu/YYu1CgWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH0PR03MB6605.namprd03.prod.outlook.com (2603:10b6:510:b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 03:30:52 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 03:30:52 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH 3/3] arm: socfpga: Include required functions for FIT
 implementation in NAND
Date: Wed,  4 Mar 2026 11:30:29 +0800
Message-ID: <20260304033029.10825-4-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260304033029.10825-1-dinesh.maniyam@altera.com>
References: <20260304033029.10825-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::17) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH0PR03MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 1751a42e-d1a5-4203-12a4-08de799e6fc0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: J5KztjPSRzGTDF+297lA9L8smyy5l9J18hvfIl24Lh7sXaas8UMSiFa6vTRR7NXjVNXvAFPMA1r75XcEtGG66aTMB0fnkDGIxP/hR4k6LU5CQBIVoP2ZC85qyVCXHiXyrm//1gcbNSJzpAucQlXdGGpbd0CRcgizsrp20OlXT4yqDRk1WrlxgVnONTtiY/tiYIACYPqwzEQ81a4XBDPfPzTUez27HuWevpknjCjFg0qloIFAzJZfwlACY/A+gJZIV30jlgdKZ9+TU0tCH7sVSuXSQnR1oooEWWEJBf8yr/Cje7g3Yico0HYxZilvM+pHBNky/NiqGRyAEjuwZRxeZ/msspnidTepnW59Zi0OiD51ka7c1W3NyOVoppnfkpLrmQiLMTPj0YDvDX6ffZf7+BhwQkRTUa9r+IAuqRRu9YPRiqIoiO6v8FPFnNsf+/i56af+ViOiFwbsTxL0h94gp+qqaSq+2lTYa1mawBZ75oVv/e7IoULpPVEFzw8uPNL6YYhcEYL0DKovlPpai285b9Cm/7ewUIk1++udMP0U8OUIl1kfkxveHlRwY1b90T3QtMo5v9hZdrV8Ch6O0i88H0RjsxpWdjgx5l04Gb28UCjX9aQTgbjamA+4N6mQ4FD/YlGvXAx8NsRy47h7R72WlTyjl593OS19vvLMK33y51SvJsqVY8tdePJTxLxjzQdQZQ/9BiNp2rPBUxHGkM6GMFiNoPkBZ7+LKnDo8P5XkuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hldv1zO1dZaslYFNhJ9zw0rBhlGsyy9v0XUh/aUf3TthE4YRJYpbWmvGMJJJ?=
 =?us-ascii?Q?DBU1JYvz+0vefpHb4bfEd2/LTxOfNen2XRQ//GZ5tAa4aF5w1xA7f5MxiD3B?=
 =?us-ascii?Q?4ScmfP4WzVHc3yXsyK7KfCo4jJh/eMM4NSqdiVlsrmTmVbeTRcH5kq0zcjFR?=
 =?us-ascii?Q?F+GfJorZZ9dRUWVCWuXLCxQGqgtbX7r8fz6/Q2uw5qnr4E1doewmqEyEZjn2?=
 =?us-ascii?Q?ZNkKfke35DrLmrJvIMYHn7ofloMdVPvh4t/5oqrvP9sZEDjZCWBZy37tXFlU?=
 =?us-ascii?Q?ioYq/Tj41+oQpy/PVvB0tLz8B0Il7J2MEStw/9k6vc8ZNo3vuSfuqJ6OLqzE?=
 =?us-ascii?Q?Mh9jR+ljwLCt8krgfwEmsIx9eXd9IBF77psAPGoe5wYa61GOCb6c9w/yiMyg?=
 =?us-ascii?Q?o2FJW4semLWNm46e2wmBbYECISfcOjRSBTM4OY8wbDkN2WeLiV3tVqrDWzTb?=
 =?us-ascii?Q?0lz38QS8MAAiPUVzjrXNSqMF/5Kcx0km+9NfgVHVUqa5DLoX71kAvLkyTQry?=
 =?us-ascii?Q?BLoLTLw9HYmo8l8/eROx3vgfB+9J8+7Pf5piKfliu2l0qgvYu7wDuueS1p0D?=
 =?us-ascii?Q?phcxBb4GDy+IYPRQaf+NHS2Ai7+zJ4QmebCB65wueqCGZyuUO0LIZUGhdIbw?=
 =?us-ascii?Q?GKAbDWUGgf84vuRkOpFWddF65280vBNxBwTGlXiZEJU/dIr++qfEijFV1jIB?=
 =?us-ascii?Q?ArYyHynQj5XdXCcaWnJjipxn/uROc1hEurA2kTtTcD2C2iZJo0sLnIQjaUmp?=
 =?us-ascii?Q?J4gqtTwrbJLlvZ3wugaJtG1IXYe0f5IsnxYGV7dy8l1NXrHSpcVLP+lOKVDn?=
 =?us-ascii?Q?t24/JSO/nZQQYYQfEfnV052MLFPvOViB31I5YNtdqVOR+xMOQYUqbwCoidox?=
 =?us-ascii?Q?YLLiXuiYvuf8Wj6KRhLod6YYVDIO7NDRdgAqErfSPtZxr3ZBfnaFvnO7G5Vr?=
 =?us-ascii?Q?ATcx+hobLm1B/D0kAeCMz7utS7CpZvZcgis5y9roxtT4Hs147tXb+CJbddFt?=
 =?us-ascii?Q?W8zwqAY+rqvRNenB0pKwBm0UrvpTKbnrGkrxlzHZg/JkSOGGcCfKL9NRcPpR?=
 =?us-ascii?Q?5J4Xr80YI5mWL2MvIHl55o2AH+SUt2y6oKPEitzGRBcLwSFbAFYOuAWEShus?=
 =?us-ascii?Q?qCwmzwvVIoFSx7X65nbTIAS9Llt9hc6TaEa0c/LzJ7Dcc880V5bz9GvrniS3?=
 =?us-ascii?Q?pTA3CT6HbrI3XKZwYVaCNsHo8/b5OAC/W2jqc5dUdmXbtXWjHOlWIJE4anRv?=
 =?us-ascii?Q?YxZsTIuvBzUO5HRlEHRyYA/p6HPrEk1rCKbaT6wlrGDBBZceissq3GxlKC2/?=
 =?us-ascii?Q?DGBON6EsXplz9jzTWSu2Xc7T1vUnYNxxqh+es2kIOsZ71eH6AJEx1vJVAkex?=
 =?us-ascii?Q?BHYpCFCWt20wymX++Hs2wi52k1RDsVI/lVlTXtqPZDLoUWoWY6lQz0szBL5h?=
 =?us-ascii?Q?3v1wPF5eZtTgbrvW24o+neDnpYGVGk77bA78rIN1cfNIs7YZZq4zMcSNQ9Yw?=
 =?us-ascii?Q?KA2KyLXAo4nu8v02ut/6kqmsLIV16ha06JklkafkWsWXPJorKQUqJAPEphwP?=
 =?us-ascii?Q?gnviZR/WgyRwvSjgpvjMuNGexQZh2RoeWiYtXEAbBIcX4XWqY6D47jV3Ndky?=
 =?us-ascii?Q?RrnQCbhrhK2J4xUvUVFIWvCaA5i8IDNTtVGfVLv8ddak4uSG0jS2tjJhoiOX?=
 =?us-ascii?Q?so7YS7yc6OlbuqCSjYwpLM3FWiR9LtSsvSELezribHKPL0jkQtzjgpxeU+9W?=
 =?us-ascii?Q?1DJ8UvO5oeViikJVWj6scwMn22Rv83U=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1751a42e-d1a5-4203-12a4-08de799e6fc0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 03:30:52.4070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RT+ZlfQR+y1hkPL5RUW3x6sLwti62kYS9bL6GsyrmEcQqlYB4LLdlqm247A2pGQgcsT14WSEk5s4ZGWZPzy96AGHXCp934aJygL6og4879I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6605
X-Mailman-Approved-At: Wed, 04 Mar 2026 05:22:07 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Those functions are required in NAND FIT implementation, so include them in
NAND build.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/spl_a10.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
index f2f82716ae2..310dce517a6 100644
--- a/arch/arm/mach-socfpga/spl_a10.c
+++ b/arch/arm/mach-socfpga/spl_a10.c
@@ -287,7 +287,8 @@ void spl_board_prepare_for_boot(void)
 	       SYSMGR_A10_ROMCODE_INITSWSTATE);
 }
 
-#if CONFIG_IS_ENABLED(SPL_LOAD_FIT) && CONFIG_IS_ENABLED(SPL_SPI_LOAD)
+#if CONFIG_IS_ENABLED(SPL_LOAD_FIT) && (CONFIG_IS_ENABLED(SPL_SPI_LOAD) || \
+	CONFIG_IS_ENABLED(SPL_NAND_SUPPORT))
 struct legacy_img_hdr  *spl_get_load_buffer(int offset, size_t size)
 {
 	if (gd->ram_size)
-- 
2.43.7

