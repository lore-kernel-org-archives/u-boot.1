Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51FBC28B30
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 05:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD7D181DD4;
	Fri, 14 Mar 2025 06:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Z0fEvYOV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A14BF80F9C; Fri, 14 Mar 2025 05:11:01 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170110000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c102::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A571808A2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 05:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIlLBI/qBZwoJKift1LfdwkF4HVSFZ08LoGimX/HE2EHz65kKqXNhj7L+9MRAOVEqJAH5gXfOh5XEpXwQkW4npAq0MHNSuv99wxaFnryUKm57Q1Ea/Fm75VNn4WsmDlM/QlLCpTRpUv6LUA6A4Ydei2LxtEczB+Dzj5NuEqb/MTm5Py0Zstb/zXsaCzKQwfiLmFR6c0NzfXYKWIbZb8dzymTrgRkHMSJwDTOA+3P6Smp3T/N3yM6ErXQYs12+I6DmP0xiQp8TUdHM1S4sphiwMJDTZOM4O35VLyrOAC2LWlaYqtg9E/Hars+hAg7K+ripG97Ln0Xd6EnVgOTiCtZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqwVqsLCjgJ6mx5us/7YYdo0rqth+mAKltd7QhH8jGI=;
 b=An47tErrAIXRoWrnkfencoqUjejzCr82u38+WdsQiYHEINhC2nwczHsWiFYy5FWDxVZVUKINMJWGJAqsu7QCe6t5CW86BJCKGoHQHDPLJ+xgoSUquQSpoeZWCza86DW+qhl9cQyvSwR88Qdap/1r6UE0MjQ/+2WTrHZdJafm9PKoQ18QATcm8rQ76oJl3fXifSRXi1jgWSdbPT3yQzPsmXKlB00bcYo+PvOZwNMPekmnaAuJkqi5HYPuboyOoLCi2z3vBUxe2cubnCGbOQBAa6yHuX2zqSTP7cpWXyp8KHq4l+WiV+lJZhWQB7vJ+5BKfJ7U1OIy3XnQZvmHDjl4Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqwVqsLCjgJ6mx5us/7YYdo0rqth+mAKltd7QhH8jGI=;
 b=Z0fEvYOVTiQ2RkS6Zm1y5IW77TqbsAOjUuyE4UEVA0NynrvXIdcNGAi9f9LPDA+knO4ZGZgW+j1VK9Tk7rYrbOFJzcfYpq53/H9K8YS/MXuKE4MBnq7u/Qu9WSSPbAQZzjX2N+Z2DAFW5h3+v0ON0I/rDBd+6hqFaYVCdkitq02b8McI+loTzShYrbEaf5oHfnX3pVfunjKIlYc7ydebWYXVyRfHJ9Dp4yIpgwsikfGAoU774cIot3usqzXCSSiRivHuBm5pofb55Az370DmHrP7/ZFsC0zf6x7twH6wJcoR6z2wcrTiXAow80OKq9K6Py2dnZHvGnMTRhFwdQqNNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB4387.namprd03.prod.outlook.com (2603:10b6:408:3b::30)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 04:10:57 +0000
Received: from BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874]) by BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 04:10:57 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
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
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v2 13/13] configs: agilex5_defconfig: Enable i3c configs for
 agilex5
Date: Fri, 14 Mar 2025 12:09:02 +0800
Message-Id: <20250314040902.43621-14-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250314040902.43621-1-dinesh.maniyam@altera.com>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To BN7PR03MB4387.namprd03.prod.outlook.com
 (2603:10b6:408:3b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB4387:EE_|SJ0PR03MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: ae071fc1-0fb0-4f16-3483-08dd62ae3881
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mPvwN46Xv7a4ezL5LlDF6coJZcDuCWP8DapvMA3Ji6ZUmMKzr5Im4JqbT5dg?=
 =?us-ascii?Q?tW4DihFdEn+mOj3PAj6Yt1o6MchbNRgoQuWz9s4NvyOZ57v12O/Frp8IlBai?=
 =?us-ascii?Q?KPZ2XhqnwXPfY/qF5zENHU1g8Yf+mlLZkFnaenXj9NkrnO5hJy79wWplrsSD?=
 =?us-ascii?Q?h0rcYKhIQMEaiADFFBNF8rUu8xwnjcdG5Q9xoGjaP/rnjcbvfYHElnwVxxon?=
 =?us-ascii?Q?P3py9wyT1r8fVuBL98bDumd0YsxHDwbiIOZ88wO8IwEdtxdJI4uNRwZHjQts?=
 =?us-ascii?Q?Y12k02L0t3CFgjdQjQ78dDGGM2Bg+sBT6U4Vgup9ufFJk6JwGI/7BTvegMXv?=
 =?us-ascii?Q?4l9KLa3fCHgwJHQHz0ddePZgQc1XdUOhRpbjN6ImJg8qZNFXFqQ1tZQPkR6P?=
 =?us-ascii?Q?P08NfXESjZltpr1JNPT1B8OwmJslQHT5RngZctIgDDzuKI156zIKIid5yJQF?=
 =?us-ascii?Q?lAF9V3HW8zvPPhadf8IvtJ6b5xG1VrpsE0UQmhOSHDg9TaQgvjEsk4UDR0F+?=
 =?us-ascii?Q?PlA+JtmhLjb7HHXKqF8No0yslVZCGUG6V2O36RxaoxVyzGjsGhoVC2jLCmgG?=
 =?us-ascii?Q?QMQnRBcMn5owDW8GX0dQiDGp7ip17m8PUQQjVOnUZ3t6Tr4sY2ZO2ivjnj/X?=
 =?us-ascii?Q?37yPXbJ7LMrD6PjId1QrfkYl5vZQLBLKdCjm1C4Yk5eBodAW++ZaFeKV28oA?=
 =?us-ascii?Q?nuW1iAQKJTTqeQddnCD4j87d/9hNYci6p+2kqeAY201YXSlaXxIwfmPEOcjR?=
 =?us-ascii?Q?+Mk7S3mfq9rGeOkkfS9ffN6dBrHX/JdswRcKngD3X4Sry/Fs4oNrq5DWaRgo?=
 =?us-ascii?Q?2vxJbthUfmYvADr5yMC/nEYoiW/0e3HehLV+rztDZ1j5mASecJFby8Hxy1vS?=
 =?us-ascii?Q?Ts6tZ7w2tZjHD3T+4b5roj6Q0ASTRvRc/wikFbIvajc6T7yqn1ePOOoMDo5f?=
 =?us-ascii?Q?FOF/wNTJCvIp5WQZ5EUwB6xKX1E8yQqFiBWMROFssTBNkWZm7TscN+A1Rw6u?=
 =?us-ascii?Q?YPfgu8px+9X+QICoYovobsS0ja2wQJrQh+EsUOkJRBtDK5S5wmfoyHjU3KT4?=
 =?us-ascii?Q?pRG7V2aB7ONEvMCDhE1sWdRa0wnSvacOd28MDqPB/H37WSAZ6PZNqIl0yYYa?=
 =?us-ascii?Q?9rEIocppNlr+oEVej4jaGmfeR048SRcMAOpsYKk6ufIvxjnAd4BU95oI8+MK?=
 =?us-ascii?Q?0XFcJTaKd7YjHtzo3VDNrXeXXckNR7/EOa6rG8sgeaSLa/uUcgqUkq2uggNS?=
 =?us-ascii?Q?zbZSiR/kocW666VSxwpFnKxk5JY6RtFO3miiqd9c2bOKDt/n06P+/udq92X8?=
 =?us-ascii?Q?D9uCoaivTTb6cDDZSWHOpomUtGy3Uj95z+S9vPmpHIjbINamMMNAi4y0f45g?=
 =?us-ascii?Q?zXDof5Z3fOvWAJ6heb+ENKTAf5is?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB4387.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hy+ZybjIh3MWvmGylRyKDf9ONPX+nmhE8sCJKYUlzygg4O2M7SJ46Qeq0i4t?=
 =?us-ascii?Q?id42Abs0CAPp5STj+aBfXYE05i552tf1symJaseLHUzatLHN7QarjTumDKJz?=
 =?us-ascii?Q?YSfKoJwH05dD73TNsaQwVzLy8uT5a/QTfQZQa74XkMUni2gRWR7g8Sz1L/cm?=
 =?us-ascii?Q?w30j+lXHkBLuUPN0CLo8c1WsBhAoxSo7hghD/fmypj0wDmoe6rtvCR7tPJv4?=
 =?us-ascii?Q?jlRssid6zRVUfFwPcT4kXqVen1DxdwTTUYRLKqe3sLWiQcCNAMPoSTSIFq1m?=
 =?us-ascii?Q?sB3+QGtOR4JEA/iQFb8NrPK3g72/23mCe8/dN1Vt92Sjil6Ib/rGxMJxhtTG?=
 =?us-ascii?Q?0qGnbCNTLVB37DV9QNxGqwTFFr01wzpHMnpvShixJfF+F7S3Q+vAAu+RKUgi?=
 =?us-ascii?Q?5a7o7eVaWIs57PyJHSZFxkbGV6W9eFivH3WHfNS9WnDnPG7fZTniyiohk5SX?=
 =?us-ascii?Q?2KTObQgidqm2aPec2AB9fnwC4MhVAWsN/kS/VH5tjX64znRFSDXkIqDGtI3s?=
 =?us-ascii?Q?bJlJ7c3B6EKJU91CgJQ3sOMgVcSTHDNb8KA0cAA2KYmDYCPpOmLuJAAxQWNv?=
 =?us-ascii?Q?cIMcgRB2Kf+FMyndhfDUoaZF+GwIFU4XvLAosvy6KFOynVT1p1DvaIxlvANa?=
 =?us-ascii?Q?Bxk4rsV4V6755Ggf/l6i495mtJHGbxGZnHUj4VgmuUXYeEeYgsJnp0CX5ce9?=
 =?us-ascii?Q?jK+hqoC+KEYC6f3A47WECjD0tHlRlB6roEOvfKO+7U3wGVBWtZdiV3plYBUe?=
 =?us-ascii?Q?Vazqmsqel08eJiUl9F3847uo6EpkhR7Z2R4Bct5JXGgRrJfHwLeOJN4V19oX?=
 =?us-ascii?Q?rJwTnl6a/PfP7WjeTWdFw3kyCttJnPiY2FzboOBZJG/LQNK/SB9q5wxJUlwn?=
 =?us-ascii?Q?JbJcV52h87UuKNgUgdiB7hO3dH9GVLXwtGD7DBSlQgmfZzk9mcqOLxC26ekx?=
 =?us-ascii?Q?H4gi5cMREFV6V3glNzAjMfqXY9/tK/mT2EMcXw7pyU46H3BcMxLNrM1VlmBE?=
 =?us-ascii?Q?OFIewWZbNTahtl1Ba8eS87jcU6Ht9vl+ls2McOyD5kizqprvqWYkXKK2rv7o?=
 =?us-ascii?Q?K1sKbeUzNk5eCXzg/H6JEU3l4+v3AkWth5mq9utdlDuBGe3pKjx2e56PiZjT?=
 =?us-ascii?Q?32vFkbvWz/1WemS3Bdug57y9U9R+HdcLdOK9BGVyj0pOGu50OWED0Q/x3b+l?=
 =?us-ascii?Q?TRHIu0Eyvs08QaArt38dMKrms5qiU5Lj0kZQ4NMlipsr2eeALVKmseJkqLux?=
 =?us-ascii?Q?jcqF414Nt+rx/HkhUXBTzorS+CIwyy0SfFVYMuPA3YKKppH2BZID1BBK85hy?=
 =?us-ascii?Q?5So9pSDLlxLu7P6cv8XEmjFm4zerrSK52be9DDo93BWNHVp11fkJJuT96q6A?=
 =?us-ascii?Q?uem4QLl6gKCrb3JWBFXa6nOlnBDdC9aiJ33d4N8XFxhqSPKXJT9I/wJg7yri?=
 =?us-ascii?Q?9O5bvMqDe0z1ca0/OdbePnWn3bIvptGBfm3x/GD5EUt2HR4IpnD13ZjuGq1k?=
 =?us-ascii?Q?TrJcSiwVMhBO4zyPL/IVSvgkv7XtKb6zbGtgAxo3KW5ppmybeTemtcTpcj8A?=
 =?us-ascii?Q?lrVc9zsXH/cCRLXXcP1VRDL5CfUAiM/idgSMoi9LtZ3uxDGhHprao3RIRLOD?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae071fc1-0fb0-4f16-3483-08dd62ae3881
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4387.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:10:57.0961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYUS9yA1Q9z44+EbQl60oEmKPnLTXiOikyDnyWDQD/nbWPxh/0Z1Gq7xunq6eIhOI0X8yfqMsAG/yb/l3zSADApI6aLbgXo1jiDO8q0DKKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5757
X-Mailman-Approved-At: Fri, 14 Mar 2025 06:36:33 +0100
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

Enable configs for i3c in agilex5.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/socfpga_agilex5_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 8577ac610c2..5d380011fab 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -88,3 +88,6 @@ CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
+CONFIG_I3C=y
+CONFIG_DW_I3C_MASTER=y
+CONFIG_CMD_I3C=y
-- 
2.26.2

