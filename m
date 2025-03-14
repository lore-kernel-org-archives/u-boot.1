Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38910C28B30
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 05:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64B7B81DB4;
	Fri, 14 Mar 2025 06:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="w8GLw7hg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C65BA80F9C; Fri, 14 Mar 2025 05:10:54 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c004::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B134A808A2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 05:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjFC0kK7lAB0qok20wATI3p2uDl7E7XU5xifqM1SlSPY7KU3zqXrugk2/izRoFtatKt5v8vhVisfLWfpXPY4/js9f9pwjU+yZP+feV2Ai+O8tDLXl/cjHN+DeugK14pJsuNeY14tq3gatMu5vtSsNCniMgSGBVCC2hptNXMUt6DtRKLc41qvqAwMZbL6sgyZIMQczXhsSAiS8PCBX6Se8I+jdlNP+mQfPVP9xfZjGpM5K4iUXfx6bbrCsppZhVaCjTFGWJjrfbUUJtyY4MSf6nY6ubsNYqcojZfpOpPBOv5ZI+RS5N4n7iuo0Uv1xlADbzMARlxxAFc2PyniRsimww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwNWq/J2MtBA2/siSNSvjyVnpVNLv+TseHJ5a4eyOeA=;
 b=Cy4NjPowjlHhlqUenduiSnJVrx1ow2CT0MVphPOJkhhNi+yMIzFmNeZL6+rjVuMfIYeQPxS2f54dJTJyRywOs8d3xJBw3nvHdtM+SIkEV/p9HTA/pnI96xS4OhFM89cKlN/xUjht/ye0OSVrJM2EbWFm3ZfPQt0MCag+liwEAVOppYwotL52Hh0FA5oNTKlnxYNUQVLptGmJzXRum6UHNh5u/2fCEAsVUmpD3SjC83A+glBVCz5R3ZrzYABDMqGIvDYdDnlM38nNDlMoB6olBhSKjlDDK+O36GqktcUeB/wp4ipLab7v4wIcmr0IRoAr1cY5jPkTELaccA1IGEAAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwNWq/J2MtBA2/siSNSvjyVnpVNLv+TseHJ5a4eyOeA=;
 b=w8GLw7hgZvr3YhHdYsRFUX5pcUEAAWq4zcmC2ENJVR1M/lkkix8RdcrQ5zh62b/5eNnep+4qvalUTkDEvd9Hc50OoZ/fbg7xuFoJiTZ2n7gjktmeEGWrY0uq4xAa6EgkQt+wfS47bay5EcFKqZIf4xgFN/sHuak9Xg6zyvhtXUGTB9+85IKMMdwetOZrXDeAYR1p4vk8193da6FvFkCS72bbppavALtXZlheXNT+q8oa5DCW3B2Usoega6dtmdP+haReTA4cn4PLkL2Ug1V3iW4oMpUgQTFIhRMTyCpcyXQIVF3kjwsD/zqhyUXhRUxW6qNuvBO5mZf1F4FmqB9DKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB4387.namprd03.prod.outlook.com (2603:10b6:408:3b::30)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 04:10:50 +0000
Received: from BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874]) by BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 04:10:49 +0000
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
Subject: [resend v2 12/13] configs: sandbox_defconfig: Enable configs for
 sandbox i3c
Date: Fri, 14 Mar 2025 12:09:01 +0800
Message-Id: <20250314040902.43621-13-dinesh.maniyam@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77faf071-9d58-4697-f4ea-08dd62ae3432
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oiija2WZU6Zc7GEdWxvVkXyPmajdELJF4a6WZO+6TQi7lViClLgyEuU1ZM3+?=
 =?us-ascii?Q?5Z1M1tcHGqGHE3ijaC1FxLVVKDL+eVSp9PqbrDP5nwk6k7Dg5KYH8Uihfun5?=
 =?us-ascii?Q?PSQY1LrOXzEJ3jXudmTCZxDeTFOEl6+LJTQExPue1+XRgUOuOFJPzPQaoaM+?=
 =?us-ascii?Q?fONBKKSJZ6pmeu0L1Zs4LYkmDZQNdexUWcuBOs+1PA1LBdGv/N0zGfXgWPz7?=
 =?us-ascii?Q?Hq1RfiwR3BSSgiMh1sF+upS9cgyWVL9BpOojGQztyqLPG5tiRQiUpc0oID9k?=
 =?us-ascii?Q?Q9eNVGvcH7WgzA+eHBxyeY7+5uLgu2vKo8KE1s5J3MDNz7wNrGUfyh8CzfJ5?=
 =?us-ascii?Q?8PtpH9yhlfCYDy4AYIWGYZJaAX420UWh3ZWRdqxgGpIknprI1Rz1GhJCeYMs?=
 =?us-ascii?Q?KLQR0DbYZofAKsMwscZAmxFNLkfFKdBZc0JUzf5ycs016mQxx1hN8yEcbu7I?=
 =?us-ascii?Q?Zk1dKyj4zjnzOiK5yiiHXiwz1Id9seq1Vp2QvJAVde8IXiLIsN/nOvUdcRWg?=
 =?us-ascii?Q?q0YaVsCi+qVOTKlG4b7BOGLKZcmQd0eqFoW3r9QO+VBLxsoVZoYFJKR31MTH?=
 =?us-ascii?Q?IYQIwqpacwzo1uE6wsmdxCNi7WS+d59BFAqS2VxCdVl588y+RlLdCd1+er8E?=
 =?us-ascii?Q?dOKjr7D4D3igEmO4YrMKqksxSA52ZeiYP8966tLFigu3e68CuuylfR6WbRun?=
 =?us-ascii?Q?FX7c+W4PXJ331alHHD4cUwa21LDrj6hAOE0okk6slaV4Uo2mTb4FYYm8nqyZ?=
 =?us-ascii?Q?h3v1O3yDf+YuI1UqXde/XagxDPKjtVNCHHTrTHyvolqdPjgMPaxwBqxRDHzA?=
 =?us-ascii?Q?3XjOHgv5NcZyyUaAMgAQxm6nJG9fss7b3qkm9y2x4dSkJoxAVvMgOOCc+lRe?=
 =?us-ascii?Q?qjtuQv728tonD4jyNnLFgGXyTvV4kYjDVg0bNZm2DQsIAjFcJtYYSIo96fFr?=
 =?us-ascii?Q?SAkzQ+m3rC15AUHvVbmMXMbTQt9v2y9aCjp33jImuCjyHV/ICaiMH2vlW+/T?=
 =?us-ascii?Q?xDEH/3Y1i3ary2P6u39GaZ/tmq7eBBhGu7JUdW8ocItC/jwmGKOVunJf7L76?=
 =?us-ascii?Q?oEtf3NLi3xf3OhXXv4RlkpD9FiX4HhBHqogDHcz9LBKWpEuTZ/eRk1XDunHf?=
 =?us-ascii?Q?7GDzGJTJ5zBJjj1YKPFoYUIG7UWaRIlgPOhzExQlraG+qg6lj/W0/DSnwvX+?=
 =?us-ascii?Q?aWa6kod4ymROEsvd/JLCmAsbAa4zIWADmhG+mqsEnuiZWwYdBcuqcp6/Pow6?=
 =?us-ascii?Q?Uqykz34SUgQrsuEIgysEQoJ9K+ELUJQej2zhg0YJaViZsIBU3sph8k1C1OJb?=
 =?us-ascii?Q?Um9W73UgXNZzZ27Wp1hZ61lT20EyDBRXJAyP153s0Nc2PHwddAVdCqj/mpXA?=
 =?us-ascii?Q?L7Jl1wPUMKe5/n4Z9yHZV4DpeyyS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB4387.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zm/ON4ePthX3gMrSuoA6HJgTYtR1xHEFyNUCaTr8Feo1sLa/AKpSM4zfqt64?=
 =?us-ascii?Q?w55cKr+EBkNLFY95aNSpPy3DXoBygTWdLZgXpunBy4zpsKaagLl7YaWCd0q5?=
 =?us-ascii?Q?pDpSRdt/4R3cBeXIx8fhP3nbc+rjjXFB4R99MX5PW65gwR28Lm60TgFlOev5?=
 =?us-ascii?Q?IQi60pBBt2GpB3njujsf0M3IgzgviMaNeClBnxCSC28tRCAuHQ9D++2qaDuD?=
 =?us-ascii?Q?eGfzrdZMkF+F5IRqgJicyCMP/Uc4LTgZD55nxL123S7vjGzvxod0BULqBgA0?=
 =?us-ascii?Q?vNvvR5wb2WZB0TqcErO2oIp7UAZVizgBYSM4cLiuBdTsj0LvOfg0M4YPUXFI?=
 =?us-ascii?Q?5ENMd/7g08ZnLep+L60fi/wQRYLh5zMW5XzAXt6CbEbjJYD76liFvweTlVUL?=
 =?us-ascii?Q?USbNbDqRUz/6FitEimCjdY3zdXRQCyEZwS6hNP7eEyxrLJRMsFCAWnNcKTA2?=
 =?us-ascii?Q?cgyKQHWbBkQepPFfLfmq4aJxIlZuazOAtjgXou8ObIWHzTRA3lfHhmu+riUR?=
 =?us-ascii?Q?yda2LhKp/wc2G64Dtp3NdXtREGEth239pzejJVLhDyXoMUuZBNV3GykiIEh+?=
 =?us-ascii?Q?QTqxyCNKucbzim49AdRmnPaZ0gULE6u9zJnMaWxmreH8MIs3KN4p9WZx8Cje?=
 =?us-ascii?Q?qMcWpwPH30gOSiVtppWizTsJ71WKx9cTJceUzjYZQHOxhx4Z3oAKSNm9EloC?=
 =?us-ascii?Q?ACqvFfwgOs9pJmQo7wWAxrVGTTUqJrp30gQIbWTk/OakHmIWbnFMJ5fmTdBj?=
 =?us-ascii?Q?PNs3O2G7RKkFCAyo60pQwc6M7vKWNcszwazyYDgxYTiTnuyd5qxWFeom8FvS?=
 =?us-ascii?Q?jtCZlAM4UsDVszRkStM1xXu9p6jpD2aJqLR3+NanbzfFTn3Ld+NLfgqDM6O6?=
 =?us-ascii?Q?LlAI+y5n3U4dPmXAKGNWrsyU4E9URz3yDERiHM4dNdvvI+/hgz7pf9LFL8hP?=
 =?us-ascii?Q?MYmXnVGkfSc9eOGQXBz/4DTuVmNRgFiBc8OM907wmQl3nmhFCZmt/Hwq8+TQ?=
 =?us-ascii?Q?i2xyW0e+W9Ni+4tPZ+LQFeq8juRpjtve2Prvp8d/ymXqfcQEGciICuGTu9Z0?=
 =?us-ascii?Q?mjkrwqrgns/8Xhb1facL93qZyp1sk0Zs1qj6HGLY4OhDfjQc3Nmt3N3rmH0y?=
 =?us-ascii?Q?nowI697tdDi89NYw8htTlhjuNq/X9o4Q34GggOsLJRUecEMGX1sMh7Lc2hQA?=
 =?us-ascii?Q?mrOAlXi0m+EEqtyBFXqkLNCYHzyTJltJORoffwIgndwdFafh/Dpm7gHnnfMq?=
 =?us-ascii?Q?c6YBoqHozk0dLsz9ghR5zVlZ2lc233ERxzTA31kakyDSKpSIAJA6rXtfTk/P?=
 =?us-ascii?Q?ciifKYD7wZxM/R2G6alfEhgxlfmNJm1YjDmuDPSL+QQIFsC6TA36FTVcHsfU?=
 =?us-ascii?Q?vP4H8bIGjBhEuOY4poKPygCANCBQM0GL7WtaAqIw+XoGmgLICSoHDlX36Y1F?=
 =?us-ascii?Q?1xPPKmU8Os9vT21HMUp+05WT9hdS/YWCa5paH6iwpYgihpf7Uu0yOlDty7W/?=
 =?us-ascii?Q?QMGf6Bw6QSuHjj0Bv9SioHSqcWt+NcYi3HLmChLxEnjebtyErY3sf1BqgY2G?=
 =?us-ascii?Q?h5WX4n65NBuVDVVOHEajNgOfdpsmL9fKQEgnMCjwz1JKxI8/eIY/UTNlOHYX?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77faf071-9d58-4697-f4ea-08dd62ae3432
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4387.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:10:49.8687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsKau6WFjhg7hFBKfrcoiFH+cBp25WbkBAlfsxcl2aGdA4rP0Ad6UPee1b2t3PlO3J8Me9zUzWAeJqB5zYApEzdJpo/rZdr2HZpCxORgZIo=
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

Enable configs for sandbox i3c.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/sandbox_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 861a1f4cd90..d3617da8792 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -364,3 +364,6 @@ CONFIG_TEST_FDTDEC=y
 CONFIG_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
+CONFIG_I3C=y
+CONFIG_I3C_SANDBOX=y
+CONFIG_CMD_I3C=y
-- 
2.26.2

