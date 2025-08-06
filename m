Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B031AC87FCA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDE0C84285;
	Wed,  6 Aug 2025 07:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="HxXJHqvR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 820F083950; Wed,  6 Aug 2025 06:33:58 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5628783965
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 06:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vg2/4SNreZ4Dv7lBZiktYT47AeVZY/FSzLcwkRgjuNscVFBVvyZZ611Zg3DtwGAzCXFJhu9iVib3egNzMqbKVMwsHygQ97NHYkndkPe6fZQTGucGxeE1Tbk4VV8XqEm8aKKnHobhGw6cqvregkFvNOefsEyfAvbTjH9Kz3YSRrONT2wjo8El5PAM5+5EAiX8r2dv/FWqSp6dVgbHLf2WcuhGpX3+adtPsS4R8Bi75lZQg3104JuEDUMI1BaUVWY7zEIG30tXePzvN0ul2d38miXTrZytkbUp5He493tIFW8rf6hDzEvieauOH5HmUKnyPXIJPNPuD67nPMLEElyvAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilg6TIemBzl+9AehP2WHb+ln1UJdsUovmaUCMuBW38M=;
 b=jGs4Z1juLDTVZis8dtNJ0HQJClVRqxNaO7A8hLsW4V7v5Ppz6twvLWCsmki5Ucw6virh1/dD+fWEzQQxcx7eEeb/E3JJWPlZ+E8yeHeGdhQMN55bdofYq79uT0U/eIiZRRskA6ZM677S4FwdRgYmG2u/5Kn3q6Hlj4nkJ94ehLFz0+0sjtm4z/a+oDoiPx29GcRWxoeN/BqEOy/T76TTg4Vw7m3S+aK1fLtcoHBL+Y9Gpq03RG+cdMGOBGE/z9qJbajbo5uFoRtAEFkENldoMFnpNrE40Y6MMs+uDmm5wWgQMdccCOSsSTN2h0pZLZlGiNj4mDXuFsfXUmZ6AkSjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilg6TIemBzl+9AehP2WHb+ln1UJdsUovmaUCMuBW38M=;
 b=HxXJHqvRdLEqkQ/tXrloQMra+br5tS9d8BJW1+Sn01yaxbPV742Tk+1kG3MIwRHb7xf7eNfe9w+ltTB8TuGa0sVXxiDhMQWzWEX8Ff+Nonv3nWASZKR3Bd2j2T/HOg7ysiFkxQZko8ARjzyVrr4ZrkaDvI9DaNilDHQGpwjok2kb7ypLLv9n4Ev3uE7vhVhHJ8wqi/68gM3OtzMl/a3Cimteb6/nXVu8AJRE/WdJWi1O8hVg4BVz9OYukDpv8hXcfv+khIyLzwT4jViCVp+krX5c+4UGFfHVkh4CnBe4vQw+M69xr6hGd7tcJl4YkBzJsm8iPgwGCdgmdYQGUR2d9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB5202.namprd03.prod.outlook.com (2603:10b6:a03:220::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:33:42 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:33:42 +0000
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
Subject: [PATCH v8 06/12] drivers: i3c: Add i3c sandbox simple test.
Date: Wed,  6 Aug 2025 12:32:29 +0800
Message-Id: <20250806043235.2260-8-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250806043235.2260-1-dinesh.maniyam@altera.com>
References: <20250806043235.2260-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY5PR03MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: a30da156-fc5a-407e-0ec6-08ddd4a26bf5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yrz2DneVVSstHj7nFspYqC9IeowjqnrC5m5iEkZWdlt/nSMhPFg9Po5oWvPZ?=
 =?us-ascii?Q?Ri2zGuFJehumNhFwJlfv6WDLCIz+fvck8pEmJdB9GGHIgxDiev6JTtuLtOeP?=
 =?us-ascii?Q?YVTmgpjtSRvNNmmw6Ba1C/MX1kStVcaNk54QqSGyzONzF8HcxZvWIyjwUh3j?=
 =?us-ascii?Q?Qn7fvn2ltL/gnGglo5QZ0RWUMQRY7zkXUOr0Pa/tCBvsOtuI+oFDqLjMbDnD?=
 =?us-ascii?Q?tcupY0t4nU13vKixFfSXFjhrBoChfpoZOKkaud6alFhjw+1PM4Cld6Sf17u+?=
 =?us-ascii?Q?a0kA/Y4iAF1KerJPE1LRUMnepywMaLqQKLYf2HNk2fy4ZW+30BGpLmnBIM9S?=
 =?us-ascii?Q?/qZh30VSUWmnWhKnjHyMVl7Ic/jAo4J/t2qa86q0PzKsfm5wZYhB72YITAEA?=
 =?us-ascii?Q?xw+uAc96o0GyYh28Wed0jhXdh6RTylJcVdH2GiYlANZF6H1ytHxkqlJ5ee4F?=
 =?us-ascii?Q?HzB6zu65WSIzgi7l7T/sjYx9HqZW9aTntSkz9fzT5HZYpNK6f+GBGyq3ZrJw?=
 =?us-ascii?Q?8MHlZM85VpEZVcQCR1LEnZQtH7SzP1w9e9kCwCHsqJlKR5d8bCFR7fRiginU?=
 =?us-ascii?Q?0y59XrPP5w69snhde4pgjBMMB3D+myCjni/JvMeGTDd+bMy6HjYvu8ie4A+R?=
 =?us-ascii?Q?iyeVFBhjqyi95IaagFHFpD39Qnby884dOri9p3pWMk0DTEPOqHUMke8nP8OH?=
 =?us-ascii?Q?zuwJLHWIVqPrQgA/eyr2Viw4ezvvHfJ+I4A2quqB/sFrjBpM9gHQ9ktLk1HR?=
 =?us-ascii?Q?tzYelaS7nPgpzHvjVs0i0XnhvSBUnHsn7bspqYGxWG29AUrBhposINo/fFFe?=
 =?us-ascii?Q?/qweUmxv5Y9A6T2hlrLaLp0+GNakT9pAW5baP/HQfmQV7eRNJuBpos9krTGS?=
 =?us-ascii?Q?sk++0M7/qI8X8Awaa67+g8hmfHlu2Taxrreuj/4HqP0q6L4MArA9GmHlkN8X?=
 =?us-ascii?Q?5oSgVRn6mAFFsGzUmjH5kUB8RUWsl8OzMNv2rRg/y3wGS0ByV5pvpCmA/5rN?=
 =?us-ascii?Q?NDiss16AiAZf8hu3un1OpH8CnQKUoBj+QnVgb2YAhqi2Sr7OVwv1L5b+unfj?=
 =?us-ascii?Q?KhVyTBNJMOfH6iO5hms1j14XCJnrU4HSFRZgvg/JFOO3dTeSg4KV49xaulxD?=
 =?us-ascii?Q?/K8CcevGPZ3VMU6pr6vHvWLJE3WNMyTkWuyukGftFSeex5AJiANroaWdcjYH?=
 =?us-ascii?Q?Nz2CWntj7J5LtdRgl7u/cYBbAbMqLVeru4tEHgPPk3wHD5Tt/R+VLgqOmtm2?=
 =?us-ascii?Q?EPtHY04XdIMI8GEWsCjHLalggQU/Z/ku4vtGStVVHQvkDlf7JtoqSl+pf2mi?=
 =?us-ascii?Q?4Ot1m+VMYhzwRCr7cekoZ6714FqXESoc0wAQ6eJqeQT2Ccb0JV7ixyAyxDgL?=
 =?us-ascii?Q?/Jtpx4jxRiYqEr6W1DGSSfDbzMZnpOUxSATAqAVz9GMFO6Vl2pVT5u7ugTs7?=
 =?us-ascii?Q?blpqIByvHQI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fA6CNrdt3LRMgeiVCLt2anIcGNfJDUZeUhY48EqG2GGuHhHzszAlPHotYuuF?=
 =?us-ascii?Q?SVIpXqXZ1l4375Z9iDZgFcAM7UebwzqzN/G3PYHJh7RUQMhod4pQ2oce4++2?=
 =?us-ascii?Q?qnThaiFX67Gte3hTTPoQ+7zRpXW9LrqLBidlhfqWJfL1IMHuifemM2CAmmrZ?=
 =?us-ascii?Q?Cm+BluLP4SQgN1SHEfrOmWpZM179VwU0indpa6SzD7RrjYYKx3rj+Thnd6c2?=
 =?us-ascii?Q?nW/rio5wsuQzYs7kcWciDowQmZwundn7DUvSHFSTnPLawN3zug1XBeynl6k9?=
 =?us-ascii?Q?+WHRr8nAI4wnPoXLHgcf0woyHZGYwW90H3MqljiGXpQKIAqxbWxKN5ilN6FW?=
 =?us-ascii?Q?/hL13RClaEKrXzqVBnlTxBWW1y8OE03800nxavWv7lCHmjawSrPbbWFzod6v?=
 =?us-ascii?Q?AWiKg4zGeYlGsFb23ug9Ffw5taWw/E3t3i/tFWFe6Ca12JPVv+JjXeSL59Rl?=
 =?us-ascii?Q?y+9nx1tY+gASkc9gX3Lbml8TBD4PJROEcsp2K9lLhLpdsM4dZSZ8cAmnN2is?=
 =?us-ascii?Q?4PZOAcCNLMTg1OD39lZWKd544QAyKRG6tKRYCF5ZYHSYXJ4GkaXLqyIAatBC?=
 =?us-ascii?Q?I0xUkUtrTklOVW08Xsse8HloY5F5zxFym1DMLDwUE7Cqd+3lrVFZehkXPqWc?=
 =?us-ascii?Q?6BerUY5oG5W/MGBx+Nfd1XpQSOuVE8hJ4mS7oH6JT7dS1fejv14CTdq0YhFx?=
 =?us-ascii?Q?39ws4LFDKbhYSRRcWZ6+eh9I60eufluzc0R3jDa/zA1Z31pya9DIZjrXRppf?=
 =?us-ascii?Q?vU/ZfdLo0OK6OZ5yu9iIIcTPf1bb0u11kgdlterYAZaxL9PlTLp/Ku5h8dce?=
 =?us-ascii?Q?jT+nC0ut1/6Ygrpk6inxC/sf/l1DeRH/bbyOeg6rAOjyCIBL3frz0UANqBvm?=
 =?us-ascii?Q?F663BAixnUagPsXGc066HSa3+njBoOTOx2z3rV1LsXsJskmSOXfIzSlJEbNv?=
 =?us-ascii?Q?flsdCcZyaX5yNqX9fc6lTMzsPmOb2k59vcqM8kRnhwmAjXL29Od5nDDRq8ae?=
 =?us-ascii?Q?tJZmlxbT7abh/Lfu1I94QnfXNLs6VNY+NGc/TqkyrvYTFmkqj5tnclm1pkTy?=
 =?us-ascii?Q?RhWUkh2BFu3QWkbewSFW6aNhkfl8ukyFXPyFsbkR20QpMkGAmw6VJEgwgNZs?=
 =?us-ascii?Q?oRr0e13WOIpl/Q1VY5//wu9Z0hA8ByHDjJ/9GO7GO1PVyLkcfRLQbHC8+cjw?=
 =?us-ascii?Q?F+YAFlHT6MYf3C/BN+NeC55SbRvgOwOxSQZpGZ6L08RhqMCTRZXjl+PBn+b1?=
 =?us-ascii?Q?ezuuGWxzxtsmrKmL9OStG/E5UNYPiyMFUYoR9vFSmpoJwJg+MZNWLn75VUS7?=
 =?us-ascii?Q?JKkFPtqd9R6y4JqSHq5KpytvKlh4rkODLyNfAHp6jyJO+03aQ/QZ1gyX69S3?=
 =?us-ascii?Q?c0exCs8mmt8XvO0KQ8votOwIeB7TKOFyNRnZlNUf6vcf9z2MHKh+5m2kRzI+?=
 =?us-ascii?Q?7/cb9Kp+jdKcWIDYpRoPDRQekgUZn59j7iOK1J9549RSf0iZ2tNzzH9zsRR6?=
 =?us-ascii?Q?/lDL9roWrQH2MhpewyAEIRxSbbBCAq41G96thLaJ9mcH2yRgShnpJws7rpFb?=
 =?us-ascii?Q?NcIZtmt5IbwTVoC+wPWyx2zh4ARyBSCgMKEM59I2lTA3hVugpzvqQPu0Q3pa?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30da156-fc5a-407e-0ec6-08ddd4a26bf5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 04:33:42.0408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPQcWTXAQQkj271TrUiPdipr4I6i2UFtMoHoIZuPenrpmGnJp4LFTAAOExRV+KVHPY0LYhja70DhB2FP0yi2HHCW7MFXl0RMgA1ITgMuRyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5202
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
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

Add s simple test for the I3C uclass in sandbox.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/sandbox/dts/test.dts |  8 ++++++
 drivers/i3c/Kconfig       |  6 +++++
 drivers/i3c/Makefile      |  1 +
 drivers/i3c/sandbox_i3c.c | 56 +++++++++++++++++++++++++++++++++++++++
 test/dm/Makefile          |  1 +
 test/dm/i3c.c             | 34 ++++++++++++++++++++++++
 6 files changed, 106 insertions(+)
 create mode 100644 drivers/i3c/sandbox_i3c.c
 create mode 100644 test/dm/i3c.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index b8f3012873e..491c7dd56b1 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -935,6 +935,14 @@
 		};
 	};
 
+	i3c0 {
+		compatible = "sandbox,i3c";
+	};
+
+	i3c1 {
+		compatible = "sandbox,i3c";
+	};
+
 	bootcount@0 {
 		compatible = "u-boot,bootcount-rtc";
 		rtc = <&rtc_1>;
diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index d4451057de0..d877a744353 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -14,6 +14,12 @@ menuconfig I3C
 	  If you want I3C support, you should say Y here and also to the
 	  specific driver for your bus adapter(s) below.
 
+config I3C_SANDBOX
+	bool "Enable support for the sandbox I3C"
+	help
+	  This is a sandbox I3C used for testing. It provides 2 interfaces and
+	  records the settings passed into it.
+
 if I3C
 
 source "drivers/i3c/master/Kconfig"
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index 5ddc4743c86..d38d2350c9a 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -2,3 +2,4 @@
 
 obj-y				:= i3c-uclass.o device.o master.o
 obj-y				+= master/
+obj-$(CONFIG_I3C_SANDBOX) 	+= sandbox_i3c.o
diff --git a/drivers/i3c/sandbox_i3c.c b/drivers/i3c/sandbox_i3c.c
new file mode 100644
index 00000000000..e452e982566
--- /dev/null
+++ b/drivers/i3c/sandbox_i3c.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <i3c.h>
+#include <linux/i3c/master.h>
+
+struct sandbox_i3c_priv {
+	struct i3c_priv_xfer i3c_xfers;
+};
+
+static int sandbox_i3c_priv_read(struct udevice *dev, u32 dev_number,
+				 u8 *buf, u32 buf_size)
+{
+	struct sandbox_i3c_priv *priv = dev_get_priv(dev);
+	struct i3c_priv_xfer i3c_xfers;
+
+	i3c_xfers = priv->i3c_xfers;
+	i3c_xfers.data.in = buf;
+	i3c_xfers.len = buf_size;
+
+	return 0;
+}
+
+static int sandbox_i3c_priv_write(struct udevice *dev, u32 dev_number,
+				  u8 *buf, u32 buf_size)
+{
+	struct sandbox_i3c_priv *priv = dev_get_priv(dev);
+	struct i3c_priv_xfer i3c_xfers;
+
+	i3c_xfers = priv->i3c_xfers;
+	i3c_xfers.data.out = buf;
+	i3c_xfers.len = buf_size;
+
+	return 0;
+}
+
+static const struct dm_i3c_ops sandbox_i3c_ops = {
+	.read = sandbox_i3c_priv_read,
+	.write = sandbox_i3c_priv_write,
+};
+
+static const struct udevice_id sandbox_i3c_ids[] = {
+	{ .compatible = "sandbox,i3c" },
+	{ }
+};
+
+U_BOOT_DRIVER(i3c_sandbox) = {
+	.name = "i3c_sandbox",
+	.id = UCLASS_I3C,
+	.of_match = sandbox_i3c_ids,
+	.ops    = &sandbox_i3c_ops,
+};
diff --git a/test/dm/Makefile b/test/dm/Makefile
index e44f3d89e77..c6c12713d7f 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_FWU_MDATA_GPT_BLK) += fwu_mdata.o
 obj-$(CONFIG_SANDBOX) += host.o
 obj-$(CONFIG_DM_HWSPINLOCK) += hwspinlock.o
 obj-$(CONFIG_DM_I2C) += i2c.o
+obj-$(CONFIG_I3C) += i3c.o
 obj-$(CONFIG_SOUND) += i2s.o
 obj-$(CONFIG_CLK_K210_SET_RATE) += k210_pll.o
 obj-$(CONFIG_IOMMU) += iommu.o
diff --git a/test/dm/i3c.c b/test/dm/i3c.c
new file mode 100644
index 00000000000..81336e67555
--- /dev/null
+++ b/test/dm/i3c.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <dm.h>
+#include <i3c.h>
+#include <dm/test.h>
+#include <test/ut.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* Basic test of the i3c uclass */
+static int dm_test_i3c_base(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+
+	ut_assertok(uclass_get_device(UCLASS_I3C, 0, &dev));
+	ut_assertok(dm_i3c_read(dev, 0, NULL, 1));
+	ut_assertok(dm_i3c_read(dev, 0, NULL, 4));
+	ut_assertok(dm_i3c_write(dev, 0, "AABB", 2));
+	ut_assertok(dm_i3c_write(dev, 0, "AABBCCDD", 4));
+
+	ut_assertok(uclass_get_device(UCLASS_I3C, 1, &dev));
+	ut_assertok(dm_i3c_read(dev, 1, NULL, 1));
+	ut_assertok(dm_i3c_read(dev, 1, NULL, 4));
+	ut_assertok(dm_i3c_write(dev, 1, "AABB", 2));
+	ut_assertok(dm_i3c_write(dev, 1, "AABBCCDD", 4));
+
+	ut_asserteq(-ENODEV, uclass_get_device(UCLASS_I3C, 2, &dev));
+
+	return 0;
+}
+DM_TEST(dm_test_i3c_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.35.3

