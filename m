Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACD0C87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C79EE831D3;
	Mon, 28 Jul 2025 10:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CCQlptW/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1985A82F14; Mon, 28 Jul 2025 08:57:09 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E800082F8E
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5XWuWKZfn4KSSrX8rPAIig2XEuOFqEjrJviWuDKtY5wTyE2LjfO1WrnMaIcbRZtnA1V0kBa0r/4zzapnbUaybhl0MOlm6SGMvTyKib4v9auD3Gn4ZiVG0UalazCmuijb8I0DGbcDgTDtB0DUvX9u9et9sDnIXAI1h1qwMQGu/OjN+zQhflK1xr8pe3D8QyzceVGx3tF4ntO/utG3DP1VbbHxQNA+Nc9yW5gVo3iijBTp3L9i6SSKloi9iEMHu+o1TLrHGPoLuILtI2kS51bmOoMu+6tE1SGilEiuhe0IUU9hTHLeI1sLY8igmJ7o8U/c2yhfPjajKxrhRHgvXbBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilg6TIemBzl+9AehP2WHb+ln1UJdsUovmaUCMuBW38M=;
 b=aZoRCqIaCwQVo1Y39Sdp+0MnRshfcoyYxd5yGTr8VATk/GKRhJkO4EXcnjGEcf1bJTpeYL/e3XjEMu01E916ZE6tiSGEWCTVJF9JuErU5ia9l0Fgd5MVrfhNMZ+3yDc8/mUzVEtL5UJVq2N/P1fYfmJvyZbf2ogv9s/c0Qnsi/TlsnUwX4VyuymnMEHvKpNZ73aoGUmMqydJz7A7pDQ1GTUqQ7Ca2mKotHH+cGkWhsnRfOWd+ecZzFP25H74BezpHizgjMPl8rdbIE62P6v09PcMHE+2VVzpEgtTkWQ2V3raL8p01krmYzV4eihNTdd1wtteZWuqfGPYd9UCcccAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilg6TIemBzl+9AehP2WHb+ln1UJdsUovmaUCMuBW38M=;
 b=CCQlptW/iqvq0nzsV/m0bMyYk5gOJLyLq305iiJmSSnMvYpfKCrg+SpCOdqVXoUcYE1Hy3LXmjeScd2zM7Dy741W3tMrMm4FwfWLEyEXb4IwUHEEWfuD5lzEcYa3RGyod/f0n2fLS2coaYg4fnfPGM8Mn/rAY4gY6LicoUrBOUy6/ymAfSLFrsN00eOMzBqbzzUOBRZEzrcwKyr2xYiHKY+kzU13/s0JQfn33i53s1RStKUEKx4uPPuN7Kn/b/Z64uM4gGb6giv/QIl8waieeJBCdw429Q55HKxZosDK86ByEhZvuj3Goy+uccMgq+0lDhM6uSQtSlEdXnGi1fnS0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM4PR03MB6128.namprd03.prod.outlook.com (2603:10b6:5:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:57:05 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 06:57:04 +0000
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
Subject: [PATCH v7 06/12] drivers: i3c: Add i3c sandbox simple test.
Date: Mon, 28 Jul 2025 14:56:06 +0800
Message-Id: <20250728065612.6039-7-dinesh.maniyam@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 79e5e7ed-9019-4e8a-d943-08ddcda3f5f4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?idhxzgH9DjwA7hin3BukduhzVIe9I3/vhdqVg1lCd41aIeF2s6KVgMwqgOnU?=
 =?us-ascii?Q?jEM2skusyG/hbWJByazoJ8UENubsw9E5indq45auHHoBlBDJj1jnDsuTaH0d?=
 =?us-ascii?Q?o1nfcWUQdYwC6z930CtmcLNkdospGad1tmoQeGCFkYwuDII5OrB2/6ojEsey?=
 =?us-ascii?Q?4185IAeSqP9O/kVaZ3P1koZ2T6Z/7QuJjyNV5lmak+llw5U7+P1vmCKyHtYM?=
 =?us-ascii?Q?Oq/pylELLOda3gAZSqxonTCIHGw2oJAaMLfrG32kPI0LEdOSaPpql4g0uyTM?=
 =?us-ascii?Q?HonqRN0ei1DbHQzfWoDSqfaXykNtm3mupLiQNTYX4QkoMCpxRb7gtyRpk9f4?=
 =?us-ascii?Q?pS8T12mmKk4Jl7BkIWSHLIjNf5AtIytblKh78dt2toOpM1zGnUTaOZRHGy64?=
 =?us-ascii?Q?WBMd/m6nezHDa1mFc6cZomwmtzHD5LxlY5zfEwxjp396IFum3uUQ+QaHJXqq?=
 =?us-ascii?Q?qxG5v3g0cUz8XzY47Hq4u9HR0gv6PlxocUSZy42+lBkXOvvx5oySeML4PAST?=
 =?us-ascii?Q?7QY5eLGKGxXAR+6xzNLfibvWTMIbotpJ9b917DRy/NnuPTvcwor/pmpvEsY9?=
 =?us-ascii?Q?2mrMXhs3yxEQ5uwXXju4hhlvhfGg017sPMGCmgnz2GzUXVPOVChe6v9AWuUh?=
 =?us-ascii?Q?Pr/+3qo3mR2J4OEKn3D7johGO1/IiWHTRfNylbgAgXP9w1EPtwzDHzl0H2lr?=
 =?us-ascii?Q?uZTpC9yXrha0OyDeeBBmL8HRqD/IC1+BdXxKucYKqPnVcMIEpgTOjJj6Z70m?=
 =?us-ascii?Q?vuqyBFtghkhkXQ+UnyzpkmcmVsIhOirmQWlWvG28mCOxJoklWzKrYJWx4/24?=
 =?us-ascii?Q?ziV1ZH5oJAKZ03Z0R4lQt3XeExgiXuGPwRidAwxRQPBXGo+8S//gxP4qjVqE?=
 =?us-ascii?Q?1p4NXFZneTn5q5BV73MKO7oRmztAZs27pQx4G8m8ypUfjnLqItJE3K6hc8ZU?=
 =?us-ascii?Q?2gTi3v+Dqt2kL3igyzYBlXahRU6GQHP5PjPf8+a5kLKqk14MFHZyQonKA6qp?=
 =?us-ascii?Q?alrzWr/wxKDdFEz6+7qWd14Jy31v9uiytMCWPuRGLdxR3ElucvPFtvWYT4EM?=
 =?us-ascii?Q?fCWLJ8adeNZQ5uBfwlWxA7jPCk3fgGlLtMLi0mASGy6i5T0z3o/hmVXzgxop?=
 =?us-ascii?Q?88kryd84mlk219dEIm7YTcPRbguD8Zue2LwKMGCQtjO7+4f03Rmi47Ho9Dh6?=
 =?us-ascii?Q?MCx8DeWZZ8KLI1nfJxj/qjmoFoxfrtIggJV/8ipBMHrzWOGIayDQ1bL/bzeG?=
 =?us-ascii?Q?xbLHv94DCK+sYN49LaC2gnHuzJsm+sGBpgFTHMYHeGmU2M3yDk+v+ljHe7JK?=
 =?us-ascii?Q?A9W5MajS05sJcD9E7ivqKmdeudJTwk8RZD2ob7iBPYvAQvCgqcNWIsveTtVz?=
 =?us-ascii?Q?DwNvL5g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FVrXmhhs7w4HeLD4yg5yPyQObAOCfVfVzRy3/E3QSwXZ93W5UPrpVWQoMYTP?=
 =?us-ascii?Q?61wwfbeP2u3qnX7x6Kl/6qAn0f19eVOVgpV/yj0/Uh6jEKFSzMCNAKv0VRLp?=
 =?us-ascii?Q?hZm2Te1e4p7NTqSd+skkobBeZkszSv8pRVs4jLdVdTrjul7fxNWpWM/DRYkn?=
 =?us-ascii?Q?MTsMC2NsBEZhdUDSFpMWXWQBv+9O3ieQ90gUy8trvMgWRMmW1yUksBvVWrzO?=
 =?us-ascii?Q?Rm9Q716xl4wXxQ1VBX8G23KeGmtHP9Dy20Ob35Yw0HZhjLfda2Z1EnLAnYDf?=
 =?us-ascii?Q?c0pkMCtxSqh0pSpVlRqih4K8LPD8k65H+BlR3i+IkauvG0qAXB4voVzlOyy5?=
 =?us-ascii?Q?b1ShmOGTsScFtBjc2Dvs9BuTWkwSasrB/h8V2c+G0kRbdhOZl1TAUIBGkIww?=
 =?us-ascii?Q?/Q3uCLtWAwo+pUkTjcmnlMgwO/RSNVbf3vpYlwGYrqwpbmCzPu5kUX8K9cXx?=
 =?us-ascii?Q?NSRZGDtNM7rOSUPQzR+GJ8RVR3sID+68NRCIFtYnp5EgFNfo5eN1YofHZ+2r?=
 =?us-ascii?Q?xH/G9F+Gcf8GEj5QrzzHBtnBn8B4CgMi8ltpr75YXbUqjSpDLf4IKZIFImTy?=
 =?us-ascii?Q?Qp2svcp6chFOG0k6lAklb4TBLGVT6pHNhzqDzFmOId+r/YOcWeH4XStjBAjG?=
 =?us-ascii?Q?cuGjWXdYCUGX4aR8PJK3Be9Cb4Y5PNep1ve4P6vbtAXgZWIF6iY7eSxOE0Ho?=
 =?us-ascii?Q?jjyrVezSKVOymPew8KMtRssAuncbSEoWU8bheKtcM1iG9Qm+pqNTm0NVQwoZ?=
 =?us-ascii?Q?YDBHu3vae+tFS30IaIYR7/S/+leD3PpIrqVYLKh5IFr4BIjF7DRlKEyQuW23?=
 =?us-ascii?Q?OOx0lQ2WP3t/fz25FZ750nRlhnBX7Gaplx9BsYcpe/2wgpDM9meSop4nvFNU?=
 =?us-ascii?Q?QblpFoNnrgDBkFxtKHbGy0XnzRuyB2VQIMSEY6ZowLYYIgHm5LoA83TTN8wx?=
 =?us-ascii?Q?ec8UltCuL7sFeMb9PbEPezXdU/kpeD0WCWUgVMpUKI2aNq46Kim5ROGnWGlJ?=
 =?us-ascii?Q?1H6KwIj+63hKdQV9gE58Mn5yKj3P2TJC3Z8BKooyDgcpg6kzIH6ym6py05hH?=
 =?us-ascii?Q?uxpLV1e/6PzM6hIFNCcjqPItJJL09umcG2/J513zisgLpKycd0CQ9NWPsrZz?=
 =?us-ascii?Q?+v8GJL5+WrnT0ppDFCIxr73naSJ1UIH2MDE5+Rv6sCILArMHMuBMBMJOfeMg?=
 =?us-ascii?Q?9kK6oGz4LkdMGz6uv01pXw1nU4dwoK23AAH917/m3V2yCf9w9asmcev7syJz?=
 =?us-ascii?Q?eu/Xf9X6zvBZNG7EFj/FtOjcxYDRMnndXD58mIMdsPO33vbSac5bewezellj?=
 =?us-ascii?Q?yEfIBzmvvAtqaYILhl88C/2OJeypwcfnUch/Xuqd2ubQHeUg76tNCyi6V7jp?=
 =?us-ascii?Q?sCseTJ8frs5qpoPBC/Ya2vsK21+PuWRCDqSylKtd3w1mJZx4yOdhNEyJyDUo?=
 =?us-ascii?Q?oqqjvSKyzUdM7gjSXhBFrFM61qNE2IpG5e4gR01ALL8UsPjU1jaRz82ht3c4?=
 =?us-ascii?Q?Cpv28frJfCiuNn1IMdmseNccunnDTiQiamHRADki7t54MECrfYq5eDkA8ni0?=
 =?us-ascii?Q?H180a+MsTXJSTRSMsho9rr8lmfLryy/yMzpN7R9U7+i3SkEoFPSe8gkyZrHR?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e5e7ed-9019-4e8a-d943-08ddcda3f5f4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:57:04.9038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgiI1BqbFugG5mQYDPjg8iz8Dm8nCC9s5vOPjZ/7NJUV+Oc6zkO67Ynnf3SE9NKsSDeyHfS+USC+oN2b4omdmNyhRLnr+ELiR2PyfkDhL2s=
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

