Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D9BC83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C46083264;
	Wed, 16 Jul 2025 09:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Do9uioOb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 768FD82E37; Wed, 16 Jul 2025 09:09:21 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B8608317B
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxj+Pg8/3eyhH1oVjiF6wnMAxPlS2Ne7BFLxKhEpIVSKdywErNtYpPqdYxJdqGuqPSmNtCY8UvSrpNtyLmvwX58mlaRNXZqeiABWDE28Mmba9NB9ldo8pDb92FIwKn/k4VMBVMmM5ERCGdsJb8OU4EjzS7nQrfv6FDfI85fiKbnP0zbkBpl/LXMZ51NS61TpBwEzNffkkueeE6SkkXq1Bb+NY4WlEl5cotZFOjGzCrGLztqPK5uVKykBxbwo734GRfca/pG3EAefrs5H9JdriblFZyqx5BlXQoj6nef0XuOS0kYk7AnBpomKaean7dX2W25gKZYUcaN+oEtx3mKN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOSAMQ8SqgsOZ/ij5sz9RnuM/WHcchQndKgC6pJukZg=;
 b=VW4czPWmV9h12jjk5IuB/BAZJvdT3aiPk7O8uwwNIRb48spquthe7gT0/5kqq8QBnNnly7R20d+S6WYOaM9uqOcffLvn0qhxX9l6R3Lyypol7ORhdUX6Mfn0HuV36taERFkXkP93CqzF2KMn/N5bq69+p5cqEdGAq8viCer40vHsuq2At0yjJ6dTRvx9Fhz9IyT37mlae6tKyTJFqybm91QqlxeOF06Kp3QGa96uBrdB7SoAhM52M19CwNLVXEhKvfWBFT9/phZPBp9pDEctr/Foe30S57AJKl6EgTcRmIpWqRiH9hUThZeO4w4Sw2M+tt8DScMGJmhj9l2JdzTH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOSAMQ8SqgsOZ/ij5sz9RnuM/WHcchQndKgC6pJukZg=;
 b=Do9uioObBb4rp1G/DaA2xVvTjq9Pjbpb4u6EtkxNbgxvrR6DhpVwZJ9+s7Agy5e3e/gISECNItIAJUvgJ8MhLKlmb13qLCY4sJ2BdlnlEf17qg/31MqWBaguvxDlcAM1doNibKac3vaWkeaqJ54whcr27fb40KLabSFZgl3LhlEP2woTj8qW72q2ZIOkEW/n8EXs9Pd6xD8AXkqDbyIUGKKv2Xq4jXiNRS/3arwT9jolFbLWCAb+ogDHEyPFw8wejf8PbfrfiHRpGukYfnMxfATzYhZYZSi9NHlSFjL23Il79Ix++FSTymNVGM5UJXbFUol4YgxF6t8RZLAP1fnZ/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH7PR03MB7170.namprd03.prod.outlook.com (2603:10b6:510:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:09:16 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:09:16 +0000
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
Subject: [PATCH v6 08/12] i3c: master: dw-i3c-master: Fix OD_TIMING for spike
 filter
Date: Wed, 16 Jul 2025 15:08:06 +0800
Message-Id: <20250716070810.8030-9-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250716070810.8030-1-dinesh.maniyam@altera.com>
References: <20250716070810.8030-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH7PR03MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: f2398872-f5b2-4f38-a0d4-08ddc437acb8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ald/bHB1OYt7rRnz8Bwz54Ea6S2RELLvPIMlIlJbE/WfZ0WQb/K/vJk8nMjx?=
 =?us-ascii?Q?Q1NU81iOBX6Ioq37BNIdMAeJBw3/mcUv9K9bj4EpY0b2vaTxVodQ2sYxWx29?=
 =?us-ascii?Q?HyiTEjKQh/p1XE9Gw3exOlagmxOmVsjjxAJl/PwMM6oRcpxU513/cPs0oTS1?=
 =?us-ascii?Q?jpTDn+Q+6QX3641zAahXIanZumLtKlp26D8rQgZRkyeDvRJoR5kI7bAei8dT?=
 =?us-ascii?Q?sGJsx4xK5znDSI49HD0+FBXLavZyrO/Dd24fcfuvDD3oX9Txjblgj2MdKoX4?=
 =?us-ascii?Q?gpUXoXhbvl5UCfa3vV4FmD4HHY4iowvF7ijyyt5xu/2tERBiOR5wGInnRGtj?=
 =?us-ascii?Q?Sr6PhoY79jBtsSQvEjV6pkW43owrFvoGOZJxWXHbeEfPsrkL+Mp7yESo7ESm?=
 =?us-ascii?Q?VBL+OFaJXvoocN+rcLLvbe3njppMq+kniiBIXmiZZM6aj/5lQAQfW0EIMEcO?=
 =?us-ascii?Q?ox34AwEpxrHd8LCXoWAFsJqoTxiKMhSG+5o6m8ewBtLXJiaZ3yHmkUlGF/sw?=
 =?us-ascii?Q?7cDnVxU9hITM8EZIXiGDdM1l9iJidWzt6OS1bA09HFZAt0EvfRASPR8duwr8?=
 =?us-ascii?Q?lSa7/nAhnew6UnbR7Or0WovAiMG3ZfVimRFQrv0bxO0e23au2ZhgG0/eG8kn?=
 =?us-ascii?Q?l7Q/pnN3hBVbt7bCw6Pv42IpPFhgU8rw9EqiZS03OUO+nvVvFwIW6g2ARadZ?=
 =?us-ascii?Q?4oj8koXtgPY/JYe2n3fWz8rebldZ8GmuiUXOmu2agwp/gYHIMOyKuWAKQwjv?=
 =?us-ascii?Q?hntw6tDXIL85b/HOySbBElyT0zggE/CKkY1v1JbwPYUkRWTWSMtBh30755hV?=
 =?us-ascii?Q?VJYa6IIBv1qpup1CHTPzPEDJOm1fwMwK7U2N2iNpKAatV6C8hO6erxdVTXuG?=
 =?us-ascii?Q?sJyL1bEzkxbAdtDPvBAfZpcVCXI/Pf539l/7sQO2npaZziZV12KcmL1687HX?=
 =?us-ascii?Q?txkTFwSnzuUgYLqanlLu5Z2mtqwVd4akto/rLh7SCrkTEDI5/Efpx0AViD/a?=
 =?us-ascii?Q?IrV8u1bIrnX7RU7f2tEpMPNC/lXAv+B5qvBjCnqUg/lU8mlRj4xwBaze7iCN?=
 =?us-ascii?Q?WQJzCuPheuC2Z3eI96jv7Jr4lke+EIQJTiJylOLIMjH3I6Hk+2Z/MZ09diOs?=
 =?us-ascii?Q?PdRXc1UbYPQnp1ZaZ8vi/7R26OWSR7hoOYLzT/OL1VxwWJd7DMybp0yf+KlG?=
 =?us-ascii?Q?GueW0Vxw72k5K1dZ6a4LItAGPvzUKGt4ugTLLZHpCeC2rBy+Ik4Lw9x6cHkV?=
 =?us-ascii?Q?wNDSRqMYt37mCflgOVBipX0WEBkro7PwitcxZ4ZHyxOMyxujvoM7UVLeeWOO?=
 =?us-ascii?Q?bnyTS3xwUQssmyFpuL3qfT+Z2p8wHHSA6TgfDcXb1QOmg2sfPrSpDNDVYTiW?=
 =?us-ascii?Q?ikgWf3DRcfwJfl2j+FW0M2saNFN2PECcimYUC9bOZ4ozWNCbFgiJfDtA34V+?=
 =?us-ascii?Q?uBPabURSYPM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nihKSm1x/eZy8KkLswSz73hr64XPR0iUeAOTa5nRfD/kTS/+I0R+N2TJbOt1?=
 =?us-ascii?Q?WuZFB7kbD9Xl5FJY13t5NZHBBNN2WxSC0abiiPvWxK5icZOWTHJycaW3JYTu?=
 =?us-ascii?Q?NGPFEETkM9CuHO5SBA/ZMHcUqhGRRuz3++4u+Rw7BqVXnVQOApJPEySjHrXo?=
 =?us-ascii?Q?pSgR7KSXkevfLg8e4+RrwdCKZjz6dB/g7ggcd7Ec9z04eD4JafIEkagXqVkq?=
 =?us-ascii?Q?pQqZLdAz5uFTG5wP6sXTrTzNpHRoGyto3Ke4N8LaI5EUcXTiEk+29+oCM569?=
 =?us-ascii?Q?ceWIdRoJJVGQu0RKnP37v9khy+KQ3enjFvm9LyHsYExGje2v4j6aMjRGfWHA?=
 =?us-ascii?Q?cQuHuZNh9wpdC5QZ2pFMmMUdibnAl/tyGOKfThzUL2xThiiNgWEZgSWJYzcC?=
 =?us-ascii?Q?eiLTKPJH++0SvuXGT6fSfh4Rpv3GnL+uRrXRhw8EuE+vsZUQPgsNz8YDi2th?=
 =?us-ascii?Q?7fXfbHvRHR0ufyDAW0tOVGnHdw8D++zJ1YAKhQiemSgxIg+ctiKNgRGfWTnH?=
 =?us-ascii?Q?wu/Lz3iXvqRso2QN5/pNBDF83ipZvzim9eRUlNL173QQfW5kn4QoLneqv5a/?=
 =?us-ascii?Q?UKuD87Qy7renmCsmIngF41cSMIw4WoMhQ+FegTro5rAjrStkAyinI6GPJNE0?=
 =?us-ascii?Q?HsLwpRIlei4c8BnmezpNCsjv+95KeJHvVNqktxoMSJt0NFEb87YahfrRctvN?=
 =?us-ascii?Q?14nFnge070Txr+GD7ZbURqgi8za1QxDXW8gZRp97qg9Le66Ihr6z8cdisVy2?=
 =?us-ascii?Q?aIeCyN7/wI5RggsnYnNQg0OgaI0Eu2Tg/nildvEGreZhTCMkJhbN3RabY4fw?=
 =?us-ascii?Q?DQl2WMQjfWRGFXI/SeNwcLbgBTAbkJkWSjR2BFBf0KFSUyN8pJuwT4HsCabq?=
 =?us-ascii?Q?GEfRsUbYwxcvXPUGc//T9/wfJU0amrWrJEBZJht06icYdK+lCzXM1OfrAsu8?=
 =?us-ascii?Q?Y/dtjZG5ehFLL/LHE6Tkae2Ygm7Z5IrNi7ZO8CT+jXd7p+F0QvKik0tnZCnK?=
 =?us-ascii?Q?qRndbsUb37of46QeAM9yUih1dAlnj1w4VYKEOIagqXwDGmSMFTE6qPny/bME?=
 =?us-ascii?Q?j97cmS0bcwZ83cMfVp1/Bp75Ht+mjLC1Y44prGcMvjkiDC+7MDk2IssDx5Wd?=
 =?us-ascii?Q?xxBBpoxvpEK1CiFkx9yfi3tQDTrlg5nulmMUPey/9DKy8yIXyGhFUK9Xjb79?=
 =?us-ascii?Q?9Qq6LV8OC/6avr6Czf4RNwN0DVTgEVbhaFFejrIyqPMGY0QJlDvliKsvprBD?=
 =?us-ascii?Q?OFN+xUHYjQVz2ha7YyIAnODY+Mafvc+wrQnUwzuoXTJemNb2++Ta4DZRwlea?=
 =?us-ascii?Q?BvKy1nve8GCyVGs9XJfSo5NveUYdtQNN2v4PjoSKw2bjnK3uL1UFFgixn6xY?=
 =?us-ascii?Q?cFGVoGd7sdRiI2OI2bgJJ9t6md2v4M2aLVC212XdfChOW6rIzQ7UppFHn5Hq?=
 =?us-ascii?Q?Cbe6F9gYkJdEHj+ipx8culfQW4r9FM4/ukkhTq3A7ZY5687U+dchyCn7ewkc?=
 =?us-ascii?Q?dvSPtwe1FqTVvC0nIgfxNciAS452VYOl/C+dXpRG+y0kI8gm+SdloofK/sd+?=
 =?us-ascii?Q?mbvOB/fGCcLxQJSatAqNY7hH22vxJcXpFNYeTmGLJJp91eJcW1A7IqldJ+3K?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2398872-f5b2-4f38-a0d4-08ddc437acb8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:09:15.9510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+N5c9nxpI+chIrD5774Khp0RedqSD9CFCDs9epzJ3cnYHmabqdDFlvpB3jQo5JgXhP+vY5y7PpemmxxSJ8BlzLSZS+HPDzEe55ZP8KeTWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7170
X-Mailman-Approved-At: Wed, 16 Jul 2025 09:18:59 +0200
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

Fix the I3C device with spike filter unable to detect issue by setting
tHIGH_INIT to 200ns for first broadcast address.
This is according to MIPI SPEC 1.1.1 for first broadcast address
which is already part of linux upstreamed patch.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/i3c/master/dw-i3c-master.c | 23 +++++++++++++++++++++++
 include/dw-i3c.h                   |  1 +
 include/linux/i3c/master.h         |  1 +
 3 files changed, 25 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 8b3d5531a7f..6d3d2ab5e71 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -334,6 +334,14 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	if (hcnt < SCL_I3C_TIMING_CNT_MIN)
 		hcnt = SCL_I3C_TIMING_CNT_MIN;
 
+	/* set back to THIGH_MAX_NS, after disable spike filter */
+	if (!master->first_broadcast) {
+		lcnt = SCL_I3C_TIMING_LCNT(readl(master->regs + SCL_I3C_OD_TIMING));
+		scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | lcnt;
+		writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
+		return 0;
+	}
+
 	lcnt = DIV_ROUND_UP(core_rate, master->base.bus.scl_rate.i3c) - hcnt;
 	if (lcnt < SCL_I3C_TIMING_CNT_MIN)
 		lcnt = SCL_I3C_TIMING_CNT_MIN;
@@ -351,6 +359,9 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	lcnt = max_t(u8,
 		     DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period), lcnt);
 
+	/* first broadcast thigh to 200ns, to disable spike filter */
+	hcnt = DIV_ROUND_UP(I3C_BUS_THIGH_INIT_OD_MIN_NS, core_period);
+
 	scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
 
@@ -406,6 +417,9 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	u32 thld_ctrl;
 	int ret;
 
+	/* first broadcast to disable spike filter */
+	master->first_broadcast = true;
+
 	switch (bus->mode) {
 	case I3C_BUS_MODE_MIXED_FAST:
 	case I3C_BUS_MODE_MIXED_LIMITED:
@@ -485,6 +499,15 @@ static void dw_i3c_master_irq_handler(struct dw_i3c_master *master)
 	if (status & INTR_TRANSFER_ERR_STAT)
 		writel(INTR_TRANSFER_ERR_STAT, master->regs + INTR_STATUS);
 
+	/* set back to THIGH_MAX_NS, after disable spike filter */
+	if (master->first_broadcast) {
+		master->first_broadcast = false;
+		int ret = dw_i3c_clk_cfg(master);
+
+		if (ret)
+			pr_err("Failed to set clk cfg\n");
+	}
+
 	spin_unlock(&master->xferqueue.lock);
 }
 
diff --git a/include/dw-i3c.h b/include/dw-i3c.h
index 920f18bccb4..42c37d6dfa2 100644
--- a/include/dw-i3c.h
+++ b/include/dw-i3c.h
@@ -240,6 +240,7 @@ struct dw_i3c_master {
 	char version[5];
 	char type[5];
 	u8 addrs[MAX_DEVS];
+	bool first_broadcast;
 };
 
 struct dw_i3c_i2c_dev_data {
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 213de4ca06a..04017f34822 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -278,6 +278,7 @@ struct i3c_device {
 #define I3C_BUS_I2C_FM_PLUS_SCL_RATE	1000000
 #define I3C_BUS_I2C_FM_SCL_RATE		400000
 #define I3C_BUS_TLOW_OD_MIN_NS		200
+#define I3C_BUS_THIGH_INIT_OD_MIN_NS	200
 
 /**
  * enum i3c_bus_mode - I3C bus mode
-- 
2.35.3

