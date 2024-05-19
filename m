Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1270CC25B77
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 19:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FC00881AD;
	Sun, 19 May 2024 21:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="mWjtbUzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE117880F8; Sun, 19 May 2024 21:55:46 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65149881EA
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 21:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SigTi26gcaq0EiG+evsIbZXiDyTsA1iCRJXwljSw2/j5+DwwNWB99AbTvfmA8U2dnmJqZ6o2Limsh0ibDYUWhl6651/y1FZSY7x3OABlgQ2KPWRDf+UN4sHmkvZHRU7c0lXk4Dkc2emL4ZaqOYdI4tLORdX23mRkj+xOInWV2F2nNS3AcpeRi4KEO8VZ4YZ7OfLCD0UUYCFKFmTUzy/OW8bWY1Iud+DGCV/GOHyHQtTEEwE/u93baesMj+WiM/ABOimzfI6o3/K24hDXrrf8CTYWJXgzVQBG2SsmzxnEQrah0xR77Vg16bMAVLPKWGqeRsMM+oZQN6tso1hMuRnbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2nB+T4/zRGVvOJMKu042tyDRoQkadALfppjUa9tUfA=;
 b=OgfLQ7aLRA6tzc3o9RogDEKGtiNAOH7GODfcw38gGuOYPdeaOsgEcO7kKfE0irrlZAhmy/59rcZAGPlFBdWNKrjFOfc2dbE+kVesT1nhpI8VzYHSgsqWUTbHNlAkl7XI77er5OVkopRvVeDI/3m8hXHj5rak8ikOWXpLNsKLeK0kK4oO6+Q+A9+K3/t2xdqhBplJB0kK4obqP6Mv4+7kWHw7QPa75riRo+L4yWIUYAi8dcdZ6/rsJMO4hANElQTnj9AK3Rv6H1AnrhpbAvdVoLY720xuDNwpuaJ/etICWBlDYZilXqKUIcOaznMDKkHUXBseBJc2FkKqT9sdFWQl4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2nB+T4/zRGVvOJMKu042tyDRoQkadALfppjUa9tUfA=;
 b=mWjtbUzInMHhUiCBUGq+QwwQTQHGknT0BrEkGUgTRejWN2sKmpQTbJBEYlbNy+JW9OtIgUCbD+KJvqJJhcobDueZNr4wQ4ApbiX3iQtrp/AxsmzjJ6msVma6oam6oqLappzb479HewKLBOPAyjHf1ausKfzlPYooPdkRYB0rufk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3716.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:156::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Sun, 19 May
 2024 19:55:42 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7587.030; Sun, 19 May 2024
 19:55:42 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v3 2/3] wdt-uclass: prevent multiple cyclic_register calls
Date: Sun, 19 May 2024 21:55:31 +0200
Message-Id: <20240519195532.1648830-3-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240519195532.1648830-1-rasmus.villemoes@prevas.dk>
References: <20240519195532.1648830-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3716:EE_
X-MS-Office365-Filtering-Correlation-Id: 4899eef1-e644-476d-134d-08dc783da9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|52116005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gVMjO5SyC7aIBlNUT/k5ecDJac8zAgRqVfFhTqcLo7t9EYvOWaBzNR4UplLx?=
 =?us-ascii?Q?WjXnL31fWeHkf+80SxtBXGg3m6zntUtwDBqFgtvum3DU1sdZmF7O72FfFDxh?=
 =?us-ascii?Q?k+HtqRP21qWjUs5B3/wlZbe9oDhap2hmqTJBNyyjHYA8IEA2nWfEqp3BR1xw?=
 =?us-ascii?Q?ShCl4Y2T/75GJ3XBa2n8DY8eCjA3U9IeaCscB8pYB0TUfWXYjftMuaOURn4h?=
 =?us-ascii?Q?pYC3zqJ3bDqjoIfcdZ5BzV+yGun9tkanrlSDmHBvcH50KcuGLVsSAihiwQ9C?=
 =?us-ascii?Q?bphK5Bhvpygy4kHKjd/PBVyRIMXoLBQDNOOn+xyZspt0ON3Wk+jT188IIpcJ?=
 =?us-ascii?Q?x+SxtSMpnznje+BVOTxgssjtjbgI7zhhxPcIBDM1D/T7YMpMJqSoNkckPx5d?=
 =?us-ascii?Q?L5WbzjH54qLKefA2b7XZFBclO42XFMTXPV8cmI2Ifaw/kU2ShbQ09KB7MRfi?=
 =?us-ascii?Q?cNKc+GTSp7kou0nLr7I4f8cAdtXCcyIhKt6jq46ZYsMVBBEnI5XGxDqqKnrJ?=
 =?us-ascii?Q?BL1ezlyfojwGQuu4AhODAcsozrChAYhUdUP6oKa9OoT+eGyzY9bXlDO3jkaE?=
 =?us-ascii?Q?Jj0m9yK5GSHlJHR3ty5jH/x9QJtVEtRO0zMMbhTxeOEZo0HXsxhI1kZk5f+T?=
 =?us-ascii?Q?FeYDk84Lc/IFVG/HWSYiUB7loN3XhUPffBfCn9cX1ATnvmv9jeeh7m9XEMwN?=
 =?us-ascii?Q?s5KssEM2kasiaajktYHEtLC/lZPVAEZxDJ9cLMiLg2o4/yzsHc1zIQwKIFsz?=
 =?us-ascii?Q?3AcfCu74Z4cZwwgbmt6JFMfb1yI8dMLGOwmXGPgTZEcfTv0vJnBb9PHZYlhe?=
 =?us-ascii?Q?NvIyww84Xvonpi3UrTGo6gRjn7CuyvAevGZcOrKg4KXW/Sg1bB2IRo1K/OBK?=
 =?us-ascii?Q?EfijH5lpfAtmE7lwuv1ZuyTQG4MkbUUjlqlXMHKzjP4zpzTmvfuXQBE4Z89O?=
 =?us-ascii?Q?h+/vyjKG7tsPK5fEHQpAOoJVsStMtwwvVpVabYn/aydl54IegOtio7jEVGet?=
 =?us-ascii?Q?nCkj49SZAkn66+HjyPnGLf2Glt7FoSG4kUhTa3eoOudL9glzt5+5FtzLVSLE?=
 =?us-ascii?Q?SwY0QhheWlYP6bL1hccf1DkattgfSONYfduvw0kBRxPXviSQx5atEQcDVBLI?=
 =?us-ascii?Q?BqQP/VY/luIHupIDD7zgotw+0whDFePdeIxf92XE4WvNQXNYMYf8Ezt9AsJX?=
 =?us-ascii?Q?w2rY4nxxUOkuzBHXbtK8RVpq9qxAdWAJoElvSqv6Nzyp5lrn8tz9mVfKbQQi?=
 =?us-ascii?Q?6PAy7dUZa5yg8ANxnclIOk08U8AX2jQ7AoyQPt71IaZVZxxJEBQVLwuSkhn9?=
 =?us-ascii?Q?QBxfwy+RaQwLXW7UBvnl51VLfKd3h+Ruxx4mcio9jBd3pw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NnNNMyQNBT0tTV9oXn3uBQqptzTnvmQB7Lg/uxuHjVzystRdnhKpfOwr9kJT?=
 =?us-ascii?Q?52mUm0L6YSl0onjpmNF3luFH14vH9SDxwjn+ibjhtjPyoTeo5b8C7MWmwncQ?=
 =?us-ascii?Q?P6vKs5vqMrhFyST9ytASU0pTaZTxt/OXbYtU6pLHxLJQgn+B5vl6FESYNgio?=
 =?us-ascii?Q?en36iSHKp/MbMPaWBxpHYEhmN0GUNE6Ky01XruojFNmd/4/mm2lPSOklI+yp?=
 =?us-ascii?Q?fq27zkcahLfFBo3o48psQRUXra7jGQMTEynHkh+1iz8/C+xkDcqtxzqrfaed?=
 =?us-ascii?Q?FZqfMmf9bvPMYs5xMzT7VhUO2rPZyQ00ZAfjmOdTuc0H5Yn83x/DswT4pKB+?=
 =?us-ascii?Q?HgvtBP9MudTjNEoaQB+Gz9jAI0pEw6ftkGh/Lk1Wa/jbz05LIMzD2oId6q0N?=
 =?us-ascii?Q?t4AYhGVyC8VnQU+5zCFRSEH1AjSfifljppGky3qq1ER4uUmJzmW3zNC4y/cn?=
 =?us-ascii?Q?Qfo24EHedVFAe+XLEcjAExh/G/iROWaNTAPF4CW4vpKNeQgCidRkUN7d6Q/f?=
 =?us-ascii?Q?wXGvg6Q67nfusBAYqVN5OvUW4cQe8ZvdPQaDsHVcURIhRcqauAurXwHDc3Ik?=
 =?us-ascii?Q?hEvT/M+EbjSwbTTBaKRmBenqBMllp4k7jFitWOATPVCse9I1/FmAVlU71UoN?=
 =?us-ascii?Q?T7MtANObV7nq8fyvM/74las4s0tsmabfVtWLVps1TCskEK0yCtH7N1QOkRlb?=
 =?us-ascii?Q?RGflkI3TugfyAkkmRZ/QQmJLMmJ08kvLiIIJeqNvz+WIEPoptEH+eM6vWnED?=
 =?us-ascii?Q?Tb6u611sSHLTJlWhKAx8gf+jzR2s4pMANfGjHT2oAL9SwcFFzw51o/pAMxvj?=
 =?us-ascii?Q?zZnsvTcxopNhhnQ9GOyUJPcG7TLIvK2lZLsvr5ZU/D9IR93fMD11IZlE5WE3?=
 =?us-ascii?Q?ivR5k2wB3I7yx58hbvIV0wFE2Ixam+D1ihjxzXeW3OwxuIN+s+kn8ffys9NC?=
 =?us-ascii?Q?hIH2dLEYIp3z9HZSZBiU2qZeLUG9jPeQOXjuky7A/ld+wJ8RBUQPBFnfphjV?=
 =?us-ascii?Q?5A2RvKrahXE7xeDWbVOBfLZHuBmOHkVBR3J6yLr7gOWeBcljg/fB2yp5OMtL?=
 =?us-ascii?Q?DGrSt+6jBCH3AbB73Of/61wWKrx6my3kIr68PDgYYXomaiBz1EJgrVVrALr8?=
 =?us-ascii?Q?+rGpWoQXKC4hRX8mHkKqV6qIghrooYZBN1SnrA60pM+lTP63E0kWCi6nL28m?=
 =?us-ascii?Q?pMVCQQU/UKsjwVG2tJdrcE3AkXNNWl8QVgzzxbkKz1FuUdpGn1vP4OkjzKKx?=
 =?us-ascii?Q?ZcAaGaahx2N7FRNA4VxpHkVix514CfheoA/hQKc5H16A3WnXRM7xJa3qlOyw?=
 =?us-ascii?Q?r5Kg++K8/nPC8atKw43uzJ43TluGgYKpkLAcWnYCBHdgk+70CZpk0LW8f+2h?=
 =?us-ascii?Q?TMZKDj7O1SSp7TIiG9pTQ/qHVUxUWpobm3bVmko/dnNk9UQWF+BCTFM5zQPX?=
 =?us-ascii?Q?1BkZkk5Li7uFKqrSHGpOfJN+jorJCmqgXa3g+2P8BAFeojyZUX4y8jQ/oXTm?=
 =?us-ascii?Q?1EmUsGkk0QbIZpRT1c4xFUJyZn8BENytnqZ/UbRqIKudEZirf6PVy4V8xDOS?=
 =?us-ascii?Q?ZU2zmUZnPjZmpJw5Jqag2zgK5YZ30hR8wXTszS20J3r8R2w6xudGSny/5Nwq?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4899eef1-e644-476d-134d-08dc783da9eb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2024 19:55:41.9748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nW7poDORvU6W16TDMSeDzJNkMqjF9+79rogCjd/VMXREp8DP9S5XbdKhvIpUSlha0iaHFvMUXrxgklA9PeOoTPoGqI5b29MqKYJ/VFN91jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3716
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

Currently, the cyclic_register() done in wdt_start() is not undone in
wdt_stop(). Moreover, calling wdt_start multiple times (which is
perfectly allowed on an already started device, e.g. to change the
timeout value) will result in another struct cyclic_info being
registered, referring to the same watchdog device.

This can easily be seen on e.g. a wandboard:

=> cyclic list
function: watchdog@20bc000, cpu-time: 22 us, frequency: 1.01 times/s
=> wdt list
watchdog@20bc000 (imx_wdt)
=> wdt dev watchdog@20bc000
=> wdt start 50000
WDT:   Started watchdog@20bc000 with servicing every 1000ms (50s timeout)
=> cyclic list
function: watchdog@20bc000, cpu-time: 37 us, frequency: 1.03 times/s
function: watchdog@20bc000, cpu-time: 241 us, frequency: 1.01 times/s
=> wdt start 12345
WDT:   Started watchdog@20bc000 with servicing every 1000ms (12s timeout)
=> cyclic list
function: watchdog@20bc000, cpu-time: 36 us, frequency: 1.03 times/s
function: watchdog@20bc000, cpu-time: 100 us, frequency: 1.04 times/s
function: watchdog@20bc000, cpu-time: 299 us, frequency: 1.00 times/s

So properly unregister the watchdog device from the cyclic framework
in wdt_stop(). In wdt_start(), we cannot just skip the registration,
as the (new) timeout value may mean that we have to ask the cyclic
framework to call us more often. So if we're already running,
first unregister the old cyclic instance.

Reviewed-by: Stefan Roese <sr@denx.de>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/watchdog/wdt-uclass.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index c88312ec721..12850016c93 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -121,10 +121,11 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 		struct wdt_priv *priv = dev_get_uclass_priv(dev);
 		char str[16];
 
-		priv->running = true;
-
 		memset(str, 0, 16);
 		if (IS_ENABLED(CONFIG_WATCHDOG)) {
+			if (priv->running)
+				cyclic_unregister(priv->cyclic);
+
 			/* Register the watchdog driver as a cyclic function */
 			priv->cyclic = cyclic_register(wdt_cyclic,
 						       priv->reset_period * 1000,
@@ -139,6 +140,7 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 			}
 		}
 
+		priv->running = true;
 		printf("WDT:   Started %s with%s servicing %s (%ds timeout)\n",
 		       dev->name, IS_ENABLED(CONFIG_WATCHDOG) ? "" : "out",
 		       str, (u32)lldiv(timeout_ms, 1000));
@@ -159,6 +161,9 @@ int wdt_stop(struct udevice *dev)
 	if (ret == 0) {
 		struct wdt_priv *priv = dev_get_uclass_priv(dev);
 
+		if (IS_ENABLED(CONFIG_WATCHDOG) && priv->running)
+			cyclic_unregister(priv->cyclic);
+
 		priv->running = false;
 	}
 
-- 
2.40.1.1.g1c60b9335d

