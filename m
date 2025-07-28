Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E1AC83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F70083287;
	Mon, 28 Jul 2025 10:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="aIsJlT7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17B3682F8E; Mon, 28 Jul 2025 08:57:38 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14C6B82F00
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gY4zbDWJieWxlOugt830z/oD0Um9YNdxgYFo4C/56Fv7NmMiDXzGOhUxjbsHuECOXjV3IybGJ+5dQsyIbTL2x3BQkvZorb4uABxX33emLXhgZSpiC9/jmJJLYJkgAPZuo7tFxvqTges7qym3kB8/HiqiYxyP3ehGW70r+NaT7dRN9di4iUwY91Bk9Ips5JHQLrv1Y18UHIwfR75F0kbXTPhQLyGnpF/WFucIHvtUEJ1CFtIYb8ZpghO8uxmt+HWEX6TTj5ZYbcyf0Nw4yNeBPfcl0iNEfTXGEvJd5S+ySrvwSImzb0PaSbtL9hwoWW4nDbiypJQTM27+1LMAliNhxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MdOzS77KeHxgH0Ze0eKNU4Q3JDbr5hvMtjAZqwRXw4=;
 b=RJR4vDdHanYN1IgJ9R1nP+5NOYDbgAjZALvSR2CC3zkGoBEqwC81NokkSdHDtA8MEXjlSXuRfhcLh0V3Jx69y8zJbj+0soE+OLEEwBGUeCAvg1ULmfEHYp6m42p+igNQZKzos7aXAq+Q0MM/RIhCT8LSriaXAsY3YGn+8amRESQ/2vG7LpE3AlX7A+f4jiEhNgNGfRjULHV+tHUOUHgb/AXKRxvxEef2BCzFcqGa41ZdjxmEAZoapfF5hhKcNqsqfyW8Sh3RzbXVfgsEtdfUJlAsX23CtFiSwwa4i7GAA3/s8/8gHjuxcfAmSqqBLdaFQkqnPWfbdw6qr8kCOrnxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MdOzS77KeHxgH0Ze0eKNU4Q3JDbr5hvMtjAZqwRXw4=;
 b=aIsJlT7HUSHJiNg+g8viNwi9ZG0VY3ohZZCc73LeeQ1/epU5EOTbazGbBHSpXWr5MKSeuEpbhmMGzz5xf2TwedZfjNBD7TmuwbkvXffNjwa73buWPrxLfOKYf1l0uEP/YTrVAuOzRtliR064kJlrWXV9nYaW/A9QmxHK7GBsZUrg6nRlbegryPrD9AnbfZe26iyMmpWV9HoeA2XfVgXXODgmyOhscNaJr+SyWkyCYf/okvlCH4CuIYOzdmbSvVDru6lzn4EDwlOmmHq9NsFT6/RJinW7D9j08kzUmS/NYrUCc38eJ7gjhfUjA+GA5VZi61TLwq7sKZvz9qqSCUuAYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM4PR03MB6128.namprd03.prod.outlook.com (2603:10b6:5:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:57:33 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 06:57:33 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v7 11/12] configs: sandbox_defconfig: Enable configs for
 sandbox i3c
Date: Mon, 28 Jul 2025 14:56:11 +0800
Message-Id: <20250728065612.6039-12-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250728065612.6039-1-dinesh.maniyam@altera.com>
References: <20250728065612.6039-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DM4PR03MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a0f2c0-ed93-4da4-c777-08ddcda4070d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z8Xj8vo+dPQisRf2M1DUG4MBesLDe5Wc6Is76JG1BuVLckUslNXclFEzxBoK?=
 =?us-ascii?Q?d9h7WFCWyZHP+/EP5CAkSIY3FELi0416SKYX74CPGotlM458aY1JmSyh4zR2?=
 =?us-ascii?Q?DA/WaKQVXB65QZlW221BwtZzU4rt2zpWVmWGR1m2jPECs8tr+nALmm5+u5NQ?=
 =?us-ascii?Q?QU7zF7IIhUb8DEIrVkhdtOhqo6I+UvoCAcgWevsVpGUihiG3+8i5PCVbYuo8?=
 =?us-ascii?Q?7T0MDArtB1Bdbu52HoDeaVae5QF8TEIHPArBHy39I4HcgG6xW/N9AOhvkVW/?=
 =?us-ascii?Q?Ow3rjjnIPxs0EIOOoeVHfdkxdg44EB2ISIASwdLnG4b3Wdy+EChStZLo1q6z?=
 =?us-ascii?Q?Kh1szCB0kVfohTR1clSOPGHQTyCtkat1Ug2uXjyjZ/WqF/+aEMtKjU0AOUSx?=
 =?us-ascii?Q?US3I2dzLWaFJyXOLLkcChfz+MHHNp5kyYGtXMf2+bqGvP5pqdg9htJWAa8z/?=
 =?us-ascii?Q?QoK5/gFFH5AG0H72aFSkaPZaDhLoKGojJT9JRghuYBr2BYsq0cFu/bf8qVJZ?=
 =?us-ascii?Q?7/yR0JfLHsreR8Yzhii+xpon2YPVSdsmp3oBtakju+0MyKG2r3NKJE/V/2jT?=
 =?us-ascii?Q?P09fHqLsyq/6ex4MMCj3cnABl2+I0iqgDZ326IOdrwU3MOGomKy6c6ngNaGI?=
 =?us-ascii?Q?h2ydwhCwU86KOQvsn4gtUCXwTR1lQudAnpNUWisT2T74llacbA+B9v/HjDYl?=
 =?us-ascii?Q?7e4RAc5qlPvIf8dONQSoGS0eR7RDSewdAUUdJhlR13u+aqgjaSz4QZe6/d9P?=
 =?us-ascii?Q?cnGZRk3mOuDfGa1x6wYIDW1rjGFcoHDj8b7s6Ex00OoBecHofO+9Yilu+VqX?=
 =?us-ascii?Q?rUiVtqth7aTLyHx9kRFtpE3Zow202Gup3hfGKd90oXbpxg5JPXzIwcZT33tf?=
 =?us-ascii?Q?Sl1kRfD9ICTgVGX6C5e2vSKsnKBr1FLntZs6R3bHzPXGgHZ/HM2cQk9D3WAb?=
 =?us-ascii?Q?wiieqMw70UUS9SO1SKgq9B5oGpPQfGopD5WKDaeqMefMBUhUwo8670H1LB4h?=
 =?us-ascii?Q?Kht6j/S7CipY6m29mGpGXDe20HOl6rF/GADnlNHQPIJ3IVD4Gjzc/M44stO8?=
 =?us-ascii?Q?mdb9yS7rfNePcKAZi1DGCALo8nGInxwl/NFbJfzxIDLhgzmbP39Mdof4Vh6z?=
 =?us-ascii?Q?nqFJ+nUncNNc9QqgJ53Ak5/fgFYDIQv0s57DRPjvpU4ffKEVs1dt0+ZUiT21?=
 =?us-ascii?Q?VoPhJJ9VMW29/m63bfAWHK/a26D31TDtVmiLBmxmH4SOKx1AgOLu0QaVlvhc?=
 =?us-ascii?Q?+A8R2ZOMzJrxdkAYDMW68pb6KZ2mVk/Hh6RoaK/OdFX8LvbLO8zrVNlZhYxo?=
 =?us-ascii?Q?Uu+Iw65kU5/UHZ4Dv2Un8mKU92CgCWc/JSaRSxtKMqmb9/4U7hmQ98TYd3NY?=
 =?us-ascii?Q?bKGMJh/+fzj00QiZDUS4D7bjiZcd7tRFNpL7SMf3Au0K5uBlaUQOQv7eDWNd?=
 =?us-ascii?Q?9w/YysURKmI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?db+K9U7bhKC+rDfj8k+YuoK/y/NrMUWs8huBnqTiwAEomcjx3N6yCHu1lakX?=
 =?us-ascii?Q?FBCDvKVgNgoVchG+MbW+i/BCwjv+5tqli+s+obgDlavBgex+eusjJ9NRwFpC?=
 =?us-ascii?Q?8R4gGbBA2E8uUFokXmQh/7C7Pwzh/v6bY3s0Ai8KVdsshMT6AVoACA1LBrxm?=
 =?us-ascii?Q?r17uCQtnzL6E12P9y5JrUZU1JVRu2gghNI+i26CJQsBWlXlSk0qJDDkVS5VF?=
 =?us-ascii?Q?HQhAo+41k6ZwxtLtKck2tDGHSoXtPi421mZyAv9fx2Y93pv9aWnvGt9ZUKbG?=
 =?us-ascii?Q?2LYktjyh0KRe9xDh/bjbPKAEeJgNClD6WKxlH9LEm6p0QXo1QG5lbghxLouk?=
 =?us-ascii?Q?IYv2cGLh7KrVcPrpxmGCdkX3BPlGsW2E634OxEoYhme3OSJGWkzY8gcdQzar?=
 =?us-ascii?Q?E0Se8mJ/gTV+XgvFzzUV5YDWjjcPOlNcuOBkBeotSKyPtK8WEB1qGGdWO4x1?=
 =?us-ascii?Q?x8AUrIQkmEmRWGUa2H5+SxkqfEAI5WcpoWs+AL94frKRq9mLFPV7bOD9M3Yn?=
 =?us-ascii?Q?SH/L8Vqu5+SZJUXfMnTadimUjxmW00tg1qkyKStIMMFyppn+4HeREdqAr24V?=
 =?us-ascii?Q?6zxOQ3GMa4OTgZBn57p+mzDUEaDGiHK65FtS9/bwtQRDHeGDqmmJluvq8ueq?=
 =?us-ascii?Q?bBXyyXRVLHfcqB8xFXsVn0bnsFoHOwsJckLGdi42DbqtyTbk7wmqkPWmMT2Q?=
 =?us-ascii?Q?h7XXxUHBO3MrPsAxrT4WbiI5zpDW1UsqZOyMD2/N1u8A8mpryMMdGCmJZJ+H?=
 =?us-ascii?Q?MbHnuXSty9j2lhfmHl1Nc7wnBFtJWmexZbhE/I5Lqyue0xDBHwI0ew72NQAa?=
 =?us-ascii?Q?Q4wjf/+4t/okKoQLWfSH98U5wcxhreq02/38Z/s3WNml3D4OD2JakHWKTHH3?=
 =?us-ascii?Q?d6tmpZ6SkIucDb4ELtsKQ+DN38f5tlBnyzh8xTHeFu8Au766xLfNRGDlJD/1?=
 =?us-ascii?Q?fmJvhE94+OuPtsvTQGB1CrCf2KJqf9phgZ/kxK2ofyuVjlYkNLImI1zQc0dp?=
 =?us-ascii?Q?jVyqEYb09gnUni8ISHKLRaJsWsQ4rPFGM60eXcvicTCKwkR0ZNeiT5ZO4NjS?=
 =?us-ascii?Q?LdwtW3/sg8tukRz0r7YYgLLSvcEZHm3zxdV+9bUIk4P1yTiYSYDPJmRHrSLR?=
 =?us-ascii?Q?n3BqzfG8GHKbyrj46/GK4sQv2ADKp49vPdU6ZTIqjJ4tL5f5MGL34igydFe4?=
 =?us-ascii?Q?e4+PSMtprap44cqvc5KHffVsotacIv1kqYuIDXQ5NKnIcyw5z9WTWvfJIU7A?=
 =?us-ascii?Q?X9BucJWPt1H6okSuQ+1fbyc0loqueMLxsH1jNBJL9U2gIKJOdaVeg5AHEkAw?=
 =?us-ascii?Q?zqlalS+AAfS/HZuvwQEK+ODqINOf3bF+MnvB9ZBjU06Kgd/fR4J0pqWeRWEw?=
 =?us-ascii?Q?Fy0oXODPvIdNBBl66lf4Ch1NOoMWRWH51P5O5NAFHLzqDTHDiHkiyq5Jejpr?=
 =?us-ascii?Q?3a4cTQIpPgg/kHLsXNamHSoqQcaxjco0nRPFMGsYca6SalR6a2pKYeU7Ybxm?=
 =?us-ascii?Q?/8YGipnLqlN8rSgv++FNMCA2b2Jj0xCCBkyER7X7M7ouboa5yX//aCvim8ou?=
 =?us-ascii?Q?PN8IQfVQEwEhCdQma7ecc3bhUqSf1CUQEsSPnT4bCoixr0OoHS/g74IoPBWY?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a0f2c0-ed93-4da4-c777-08ddcda4070d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:57:33.6213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gX70ZUhkRKC5SjHZKPfNxAjgAF4OKT7/vf8cdfBmgcxL0uWdCW5rLAG3xeuwFwHmFzmm+ExrptWt7KE23UYha7RQ3ORWtdWWOt3o0qDUjOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6128
X-Mailman-Approved-At: Mon, 28 Jul 2025 10:46:50 +0200
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

Enable configs for sandbox i3c.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/sandbox_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 861a1f4cd90..ba98cb0ae99 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -85,6 +85,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_GPT_RENAME=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_I3C=y
 CONFIG_CMD_LOADM=y
 CONFIG_CMD_LSBLK=y
 CONFIG_CMD_MTD=y
@@ -206,6 +207,9 @@ CONFIG_I2C_CROS_EC_LDO=y
 CONFIG_DM_I2C_GPIO=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_ARB_GPIO_CHALLENGE=y
+CONFIG_I3C=y
+CONFIG_I3C_SANDBOX=y
+CONFIG_DW_I3C_MASTER=y
 CONFIG_CROS_EC_KEYB=y
 CONFIG_I8042_KEYB=y
 CONFIG_IOMMU=y
-- 
2.35.3

