Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8538E75423
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78A6E8423D;
	Wed, 24 Dec 2025 09:25:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="QwbG0Gjl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 367DF8424D; Wed, 24 Dec 2025 09:25:03 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AC0F84246
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1vD4htnG8eCxBmuDte5Ux7zUfm2GUeat1OGR8Dq534pzo6NmCGpzKXQAwtFp+8/wDNV2qYFjtHzmyaLZM9uPbFfn5eHeMcqCPFHPiy66abC/YQunAVxp7ws+GJ///Jr0+n2ZbCmrCndlQf5TMckeHcgsJyNpJ5+Elch/6oIjDw5yy6f0VciT0tN9Z0ZHCZomk2rm7gKzyTyAdZeKhL9uye8/kQ7SQ0gu/fy2d0ppLNP0By5ktWG/TdcavywYHqh2Eh0Zx3dnQEgb/qIzWQcZ7nCB523L+j6e/1MQ5Wg1+DASwdi7OyALrkqTiTcWrMk2vUO13DJArzCLYDWzcYPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iizGJLWNPeqja1yB0DdpnrzXd2nq3LUSYnXzMoG0/s=;
 b=KCyQ4V6coqLJbEFZVqkYDLqli62yEtrcbBt2ks9l5F5t2esopyB76H0gI+PTR8RDinsxbe89Nhk8hwusAzOYtnTorZVRU9f5HUdhPRrGzkgPTtWg9Uo9Iv8eO+67mZd5X5zEiON1c4Q+n8wrcIOVJETh8SVTce1fcfG89mwyLKugYOQSSdN1pfObO/BYufSRGrvWibzw1j9ZsdMX9yKKK1cCUq0XVWx05uieO1Jb15FpURy3L4mGQbE31I4b3VVVaemCimcipNNh+JuP0cqy/cmxE8b36A/QzxFcMhx829QV69FMvJ+SYBS8giF8uh++4sD0Zd5fjmh1GoiGWICaEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iizGJLWNPeqja1yB0DdpnrzXd2nq3LUSYnXzMoG0/s=;
 b=QwbG0GjlYO6m+aM1iinGN1Dq+AfSSBsFfiWvHwDA/v1iFc3zhuqHUEN0X0fRxj8Itwqi8ylDKsUgJQizaINClkhc8P/wrYpb+HfaDk0ou/I7ofRIVqOpZbUTqe4c2I7gDdHgwyKCNKcse/vWWlAiqI/0xdK3VezdtluOj6/1arL5Zr93wdgMLL4jKaEekvC5zAIBW0zOWMKXYbWfm306W7PLgxorORJFrAlr+rqCjZ3MmDpTXDsNLY9XcIFOUg9YMaAarktp5jmrjpPbMyIrgTMKkxUSrlANwLAsTqqgaNVHI938DJ8yO78MeL3X75ggX4G7lYYEi3CAHd5n0Hcg+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6562.eurprd08.prod.outlook.com (2603:10a6:20b:355::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:24:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:24:59 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND 13/19] configs: enable PCS for Airoha AN7581
Date: Wed, 24 Dec 2025 11:24:03 +0300
Message-ID: <20251224082409.1347373-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: fb99c438-9d2c-4d86-ad1b-08de42c5ed42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gSvmEOxPkE5dQW0jo0+Vr188H2o8tdpyEkTfiSUaN7jssBk9q2Qt99DdBJe9?=
 =?us-ascii?Q?5DlLj1XdGjpVooialcnlmXSYTXw35m+R3AOjS7W7LnIys04sB0NsSiU4rDAD?=
 =?us-ascii?Q?C/cF5K4nihEajQh4UQwdLwNYCdNpU+LnAiMWB3NZ+WwBk4Mww1YDkxsStKty?=
 =?us-ascii?Q?jxCa9NLjmKrLm07PBzssPtKoJgDGMFeFsDtebPsaQzLv1/XEXcBMwmMzv6bS?=
 =?us-ascii?Q?rNilscQTsUMAV9l2YlTMtceJm2jTe607qb67P1ZgWP/AN2Q1DXctfZhyaO2e?=
 =?us-ascii?Q?xqsVrZLZl4oMzsEFf3de0+QEjFA6UdnvCxfS1lLwNYYk2EJmA8g4P9iFSCRB?=
 =?us-ascii?Q?rGVQ2GX/cqVE1YwxYEU6X4k0Do50X9pPfib8pLE5W1NIaUB0/7bWyxFUprlH?=
 =?us-ascii?Q?IWjnMUJE4DfWfK18426TCi4LsHl4OePBDLaTXZqpyTKchByw2MEDTtseFXZT?=
 =?us-ascii?Q?7bgK2hrQ7nFDNq6H1NzZYaq018BAobSC+j1Xp9gz6rPQQ8iVpt1bxf0iuLdi?=
 =?us-ascii?Q?LgQfc1SuWVtnH2uA44RWY1iPlkY3UlWjSVEIx9gYmkxeCNURz7rUyydfEM/m?=
 =?us-ascii?Q?OvkxYLXvKMve+QO3POKfy3ZG3F8w/nr0Q6FSRS+Y//uo/kIAFs/rpSoKXiVN?=
 =?us-ascii?Q?Tbap9HWpQc11/5koeEm3cUYHtX423r/xsNof+GkaZjX7GRzG3v8XDmVr+dg8?=
 =?us-ascii?Q?pbhxNuVNc1I2USBmNE5NnqDgGvK0Rs/FLBFfYiPpHpMlshcnbreklLGvlsvw?=
 =?us-ascii?Q?EQZK33NcivEKpSiwowZjjlmWbroz89aYAQ6NFYgSnu2pO0OGqNrsMf97WM6X?=
 =?us-ascii?Q?naBmKAVKwZ+sl9mI850zPtl+xsPGY8XXRFf4Uq4l6Jh9+Im2qhlRDD9CJX9S?=
 =?us-ascii?Q?Rf/xuc168l5XVS+vYazKk/NKTLp1VskEXIP8hLIpXYMCRySoBdJ5xueG3C2e?=
 =?us-ascii?Q?VsI4nVd3hlbqWTK2xE0cJAujRvmd8V6ennfPIcQCXulsFDhVbnAP80oGAIfv?=
 =?us-ascii?Q?aHfjfZG2d+0E5TdPr1rE4UEFNeCP5uLiIaTx06j9zmO0lqx7s4ipEjQrJuNM?=
 =?us-ascii?Q?B9ey6Gk9vv7KPHntOAEgQXXcww9a0H6VXboj6C0FHt4okwF/XQoDD8x9hNle?=
 =?us-ascii?Q?HlD3smU9b5CZn5yrxe/LBZF8+mrLB2PnMq3YPcsT40kEmD8yZWE4IYfIO76T?=
 =?us-ascii?Q?+xdezxw0+9s349/kE2Ajw8o9ixSOnNDSBHul5fWLKkvCoeUavdoDaABvbg0X?=
 =?us-ascii?Q?3pz1iaUpmxxvmqfz17FAZj+lCS85zyLbQPrz9Pa6d3JRuMwkbFDiSq1H0a1V?=
 =?us-ascii?Q?THVb4/la51vFcwWHzSsVC1PiNjXgf6MK3QmPtqLFJnGnE/0JrT6wAEjEFZxo?=
 =?us-ascii?Q?Yzu1ymDU40+14LhFGD5KhSzv6RTdxCV0Tjvs7R3UCE17AhEMGwirNe97whXr?=
 =?us-ascii?Q?5FhgZLds4otnUTCPX1pwQPLz53XOJf9bI4snLOhhdR49AOl8psqkrqcWcFs/?=
 =?us-ascii?Q?jZ06kDwkPB73pYaG1RJdo4G105gWm6slBm9HraSzBOapSp8y/pYz63lARw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ANxBMsnnKTen2nbJJoce/2hkiz40JqOSr2GOPGxIPM+daifPMBLkOCIquwog?=
 =?us-ascii?Q?tJnOBslYzk2TPVhRLUbCqajP9aokkg86QjhuoHR6sRIxSh6km5YWiopm0QEL?=
 =?us-ascii?Q?KiZWYT/tv15e3zWqsbH5CMtWQc/zvsDjUNJ1syei2AR1UcsE05XLXTk4O4I6?=
 =?us-ascii?Q?rs/Q5NyqAEB64qEx3N54TMPJNYqiuJ7qgcT/9WjKvxqsTbtqQKsSBvx1l7D9?=
 =?us-ascii?Q?cPZlXcvBOiG+Dk0G3YjVW1LtpBmKN08LjsJxCSVvnbL8KiXnqbd/LhDDJmAh?=
 =?us-ascii?Q?gEkPHK5Hk5uNBUdaJu5hTSGcRUyoVJZWJXjMorZQSYfjgkXwbVmbOkxZLtE3?=
 =?us-ascii?Q?pZpkCg20suLVDoEwvbnWBIq6KCzSb3R2DJgo+2ezyWjX6rj4FKqGqrljcQqc?=
 =?us-ascii?Q?SnwdwTanGyuEas088p2XyJRoBvwkqkaWjeaF0Qv6twMS4C0j4QEVFISi+cwA?=
 =?us-ascii?Q?ctDNV+E7jb5gtQBhKlNG+x4BtaRkTJco+Fx+OffMo6GMyAohq1thBDtHKkeM?=
 =?us-ascii?Q?Cinl10ItHd30hPuZIwHNP5ZKAT73jAGuC28UhYvSYHAXqZHpbngD3aAN7IlC?=
 =?us-ascii?Q?odnIzzfzFrulNTy+97ktQxP7ohRgduWEOa4+RDzZld4TfSYbchvfav4F5ct+?=
 =?us-ascii?Q?lLaxhZ6CEJf6PTgq74HhMk3gKK54KXgOw9ov838EhylbwYLxB1koVYJ2BhJi?=
 =?us-ascii?Q?PncXGXvUWmW/B0+EjCRprVGqrjoambzRs3Y4XLzIcgLpvtwou9xb1ib03gAx?=
 =?us-ascii?Q?veinaN7ZsmByGhXBBVvywuWMzb5rFcNtX4RwUGMJpwTiecyaAntv9zmmb3as?=
 =?us-ascii?Q?c+gejjb54gYrM12bOxawzWa3xajShIDwjJZabDCokhgTPsUNjnx5098xnZjM?=
 =?us-ascii?Q?rVCbJw7XFip4ByaqlxF3UM7NPBleN5aodjbWPkUCCZTN6ZDjF3wPl1ESxHE4?=
 =?us-ascii?Q?RNvwHU9iA4ROrtxJIABx5AFyUrITkgmD1t/d3HnWpsYSwK6qotcTZeduSw+L?=
 =?us-ascii?Q?wOl2B3xSJskUrF2Hc40WyFoNEGt3BQ8xKj1tdeiQI17trYZpgE8/JJPSvHOM?=
 =?us-ascii?Q?m4urG5sF6c71LhTy6JYIOxpxOH48J//ju+JSsW3K91fkktKK23L/h/Xg4LU4?=
 =?us-ascii?Q?5tws8t1S1OamdGT1O97sxopH2CGAw8suKcQ3oRR+Rxfryf7YIAqomlTF3tpJ?=
 =?us-ascii?Q?3I1iTWbJ1PjXPTnDIe/BmvXUToH9F/ErRGOAtDLCz+l39HI71ffRE4V68DXi?=
 =?us-ascii?Q?OTGlYv+dGp/UQmKxAPMm3v4XLwPlEivF3Zdif74I+aQB9kW/sGWK/8Am/gj7?=
 =?us-ascii?Q?PzinBgAZSQkFdjJLEJ2TnivlTlyMq0RgDumFCs20vwxi51oG/vNbSAYpdckc?=
 =?us-ascii?Q?8EoKJhl3vcxGPkHxVW26Gp3OwEG8r6zssdysjIFT86b0oiGCCs/LWatelxKY?=
 =?us-ascii?Q?CofrDBeAEbru7T4u8iifcu7oY60EnKVoFx2rv26ZJBtRG2c4RWB7RY/ttWey?=
 =?us-ascii?Q?1IxiJfuW125kJJkzz3YllyxUDc0zVDyq5oykvhoMzJJoIozVpieD053lZwAG?=
 =?us-ascii?Q?NP+sAILGBX2l+L2UJZKssLf/DbCPEd2zwsyZ+4MO52LbJWM/aq5NpOyMNCBj?=
 =?us-ascii?Q?3bbfJJkh5yVBFBdvdXzcv4lk7bikU6hcgXOs/69H1DcgHHBI3iXk08f2XRFE?=
 =?us-ascii?Q?DQ9H8HbiTSe+otezZN0DlOgbMnN0AAP9qdB+CJti8FG0YnT39RUElfzhqhQP?=
 =?us-ascii?Q?qEZjmCPrPzF5F2lMo/B3RWS7CS4UujE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fb99c438-9d2c-4d86-ad1b-08de42c5ed42
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:24:59.2361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3GQvzwCKjOZzlDjZuaPnTVFHIVzdiE3yfVLpvEzIaJIqH7vZsrUWJBwLt3OiZWoIHC3pM0UZ1jgwyup1CjgwUT7lZhbVuWC3LHY9dGkfVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6562
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

From: Christian Marangi <ansuelsmth@gmail.com>

Enable PCS config for Airoha AN7581 SoC by default to enable
support for External PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 configs/an7581_evb_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index 73af30cd693..37786ace2b4 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -66,6 +66,8 @@ CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_AIROHA_ETH=y
+CONFIG_PCS_AIROHA_AN7581=y
+CONFIG_PHYLIB=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
-- 
2.51.0

