Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26496C3ABCC
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 12:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7911C82B12;
	Tue, 13 May 2025 14:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="YbyPIPyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E220B8129F; Tue, 13 May 2025 12:20:58 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4FA680AE0
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 12:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHFNf99xltpFxrGDCmkt92lTHmORzXJ0k8UFldDc51dHackDqB34AfOpfkrURxEdad7U5QhZJ8JEW5xmXbKmJxTAVcb7MZUcnAWtHdWJwXqbK/CSGoB13+gbCxk/8OqEXFURsu4wONKoUQqDx9/uL5CgCrs6taQ9w5FXMhtlvrCcSYalNG44YqdsTZgyBFcNfQdg6QRcIqd0JjC5BdRNN/pZwIhMyqB+Z8Bux4wY45n6SuV4hKULtspLGARfsQ2+Hr/77h/rMD7+pdqqSOh5fH2qNpEc3pui8pLhbDinMQC4bQavYnOB7MpvVYEc/A6ksmUkGfMKm1F4O0LhwBHs5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=temH7Lc+PBXP5oQb4TSeAs1Y2PNxEuyybZH/pm/vryA=;
 b=IdypbmP0xanuN19ONVO4/AgTABA9LzUsO6UhPQvkuRuweauBi4NYHdXHB4xuwx7pyvRXD/S7N4l+S7on6MnTQfal3Wl0Hv+4Qnl6o2RCi6sZHsMGob9nHCXdLLwRLgk/7EEQM+unT4rRSt5tGKyDUbHZ4SxhvSXik2ZqbKCrsTKfVOnK1UcsMddnfy1F5GfPPHw49BpujeCBWUyUNZ8bYtZrhfk/j4dWX36Y6VyWG/j3EdTguO+F/75H44JosRY6YF324cGS8DIXG2NStcPhVCaDny6pgBIcERP8mtRePC03V/ymcJeprBq7LV6HKyJSInPLDhl5tZvZY7CiQIh7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=temH7Lc+PBXP5oQb4TSeAs1Y2PNxEuyybZH/pm/vryA=;
 b=YbyPIPyOqmGLSiwbnI9nEmVWKn0ov7+CO+6+8k2FCA/rI9bBbZcjyfhMsKmmkOyUdhfIdCeaCePPywShepzc85403V6+f4jhIfxTiEqci9/G01K14gQOre//f3ds8+Hgu3RvVv4w5MIBllUgZydVPFf+RTWu8XUs5wWX84ayTulQDihwQMGC4FTlNhiqO3jsTVRwOilsv27sjp4GpBli7hLTGUkPrFOUnPTm3/2V8nj5dV95e4mUpO6eh9zDQrNnAdXdsI6D24X+QWQMrqs0lqLh+II7ei52crY+f4sPWWGRe9p35FFfnuzkRfRjl+jvmMgLhySnDCS+ycSQ1hG4Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB3410.namprd03.prod.outlook.com (2603:10b6:406:bd::11)
 by BN8PR03MB4979.namprd03.prod.outlook.com (2603:10b6:408:db::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 10:20:54 +0000
Received: from BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c]) by BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c%5]) with mapi id 15.20.8722.020; Tue, 13 May 2025
 10:20:54 +0000
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
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v5 08/12] i3c: master: dw-i3c-master: Fix OD_TIMING for spike
 filter
Date: Tue, 13 May 2025 18:19:09 +0800
Message-Id: <20250513101913.30880-9-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250513101913.30880-1-dinesh.maniyam@altera.com>
References: <20250513101913.30880-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To BN7PR03MB3410.namprd03.prod.outlook.com
 (2603:10b6:406:bd::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB3410:EE_|BN8PR03MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: 803ba5d6-0a68-4ce5-8a60-08dd9207d7ba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oVVtowozUr03h8k2CSjfKNlnNfUneI5uszz1Bi6nO9219vtcl4VGZ7JMi8nY?=
 =?us-ascii?Q?7fra+A657w0My7egiZkhNrgm5oowNK/9Bz6GdTwakvIuTWMl92qIUPxW6xUg?=
 =?us-ascii?Q?zo8bZXsCgFJkq05frhSbHKHgLx0fGnOEZ5faGnGhXeEbUOBdmfptO6AKe78Y?=
 =?us-ascii?Q?jXv9Pf6U2n/rCMeVbht664sh2d94s+1J9X1o2sbUH/WKk4JQERXmUSj1lbjy?=
 =?us-ascii?Q?MFwrbRNrz7XIDaVAN77Ahm1XAX81rgZ4Nbc1JOVl8V2ZmCoajQIPC4rruhYh?=
 =?us-ascii?Q?iGUZHPKPTmzZQOH3fyWiJ5AgFwbJONVC9TZ2o4MC9bsMq2I9UQym0wbTJckl?=
 =?us-ascii?Q?PyZbbevdOiIkxeoU/e936U0f3C9QhHueCjoOPdj81EoVQyKptZXvTmFKxL4t?=
 =?us-ascii?Q?1AI6G9Q2HqtRsWx8lAaqHmb6ECJhNoG5xir89O9WMa41o6d4b7G8J5FUIkuM?=
 =?us-ascii?Q?bzwEGZJI6OEsdpAd5BSDjzDe6LTrvUT/tKsjezQKJIubuVftS6uHdWFJwbg0?=
 =?us-ascii?Q?Ors1FDAkmlvKwjhKzmn4O7crQ5DVDDLdjEFZ4dhbXTjySJ0ZgI6XLPRn6pzK?=
 =?us-ascii?Q?aRXEDnYTWeudlq94Es0elsnutl9VXIWu33Zk5gMMawK3quGxpQql3vg4A/XG?=
 =?us-ascii?Q?qWwV62TB5PG1v2jQmylOUktGNiDM7a5ZrBUm1N/XahM+Xk/usIo5BFa43C6E?=
 =?us-ascii?Q?w5JZIVuGbVpsbz6BBmm77fiyRgaXmMqIsX1WIvfUWr582mmp0I9vCVawizrd?=
 =?us-ascii?Q?qhj47HvVOK2y8Z/GMj23LDBsA8D6jgn7GyT3zgUgYA2fo9IfYCgOjufqn8L8?=
 =?us-ascii?Q?vCmSdz63rAhC69BBQfpU7sNj7Uv7spnp8wCTrGzWe1zEvxjFS2WhjDOrFd3E?=
 =?us-ascii?Q?KfrqZcMcxMp4dOP3gb9VR7oDvSYp/QGkcvfAzAvLKJaAD1OUTSvkm2mkG1TC?=
 =?us-ascii?Q?G2T0KZ4fakb+HJqUhRXgWPU93VltAn6jfY3kuW1hLG0daOP1+gOh09RzNt/N?=
 =?us-ascii?Q?iin37ie2xlQmW5OL8E0eQshm3OiuS/iOhdwl+A5RzPFryR5d49/1fbLCgShM?=
 =?us-ascii?Q?VzeyShYr4g5kwHMHX6Qm6feHo2H+HVrXBJ1erhoHfbKGWLH5Lr8MJsvr3btM?=
 =?us-ascii?Q?w7JiwkzTdeWy/VuWArTN6JyghULtGDZwko43mNqCznJxXfU6b1dS+RFWABzW?=
 =?us-ascii?Q?Pdz+s3D1BgkB0zersqtkqYYUTFEVIvKtBDCQNrc4gMLplRMfVefYEwkbPPPJ?=
 =?us-ascii?Q?PuvpAo08P6sE24rQhiXzMS1JFttPUaHq2hIHdyFRRdZhta/o4UjeIujUQXFL?=
 =?us-ascii?Q?mJP74qCY/blTovSanNZgUMIwZZNTQNAZOzp4T9VX5iVTbOoFXZ83sOgZCOEK?=
 =?us-ascii?Q?ZXTe1XFjBxq9KqHc4Pxgc3HZd2BVcFu4uTb/dLchZXVG38D86cpH/5KmhpHK?=
 =?us-ascii?Q?phuiTy/usTs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB3410.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p7XN6rkVAkoigU0UMvA92iTX2mE1FY3zFPz6bMuKGkGEpI+Yxd5K0FUx8rGO?=
 =?us-ascii?Q?z2si6UyX+SXuoJgc2u2IhujjZ45N09ncyqWhd+Lu5BHPghGaBGOKzeWqS/w7?=
 =?us-ascii?Q?vNnAJfnvDq/zryeeHy0AebRwSQm7FobdC2uDOL2bKlMiCuCwnuzO332MlmfU?=
 =?us-ascii?Q?dYAh3yIdA0s02AJ0216Es8XDK4ynAwdrxrginu/JWlfamMHINkIuFbg7LH3V?=
 =?us-ascii?Q?D/6qyhAwjSTLXsnL8p0JDn3LB6CmmGou7hNkp6iZzwirzBM1X2A1jM1HWvBH?=
 =?us-ascii?Q?qi1BePnp7qD01AVH4Ili63eSW2rPyIgYzCDQe3238mUGJ6FTuskJSCAB2r5a?=
 =?us-ascii?Q?AynibEuVn2bH9Tyljk9OWep/UY96eATYXoWh+wlSfU/NmPBR2dC/I0M4Dh40?=
 =?us-ascii?Q?ZdaAjLLrTdW8jGvSqqvdWzEiCo7qqDvl3CTRGMx7ui8PgbTowImD/sHAsMyN?=
 =?us-ascii?Q?qFVMoSJKkCD6CYmdjlWhDHXa67rcfjMsp4BTofXcqSDzV8EfCyujw2vCamuf?=
 =?us-ascii?Q?S+DH0HH5uH6cY0pUxQqjukOBMsuZex01tCI/hE5HvYwKJa0Jxi2U36R1BNMe?=
 =?us-ascii?Q?xDpEngn6rQ2KP2p/yLBrQpEoCtAdTRGpGpNHKryFkFrfNmj1OBjM7+PC9hEt?=
 =?us-ascii?Q?qr9qLGgUEbpcxGfgP2keoBMEa/bpsuZkNZxHuu80WdFtzo47yoB2CAZ8yYfc?=
 =?us-ascii?Q?pfJ5e6sOxVtqZWtLm9h6HcRgO5yQUTd9FZxTRd00UYCfoS/O4DKV91vmlOjq?=
 =?us-ascii?Q?J2okS14VWn3Dqk/Fd8mRgaZevfpN1lpBGLpxrjc91cyYgPcNHOjck+gewY66?=
 =?us-ascii?Q?PjlV0+e0SL8u8E9j/OMIenxLRv2mU3EawBCzJZoaYFgtnkCoq9Bja1eEjlnC?=
 =?us-ascii?Q?E3ss5nl9iAkWUI0IZqir/yEvXq5n7mHGW+5C/ulVzK3c9FB1RKRSnI5Ht+ET?=
 =?us-ascii?Q?R8MJ5wJFsXlHHQ4VuvCTajdbaqzXTamer0cl5sf74Ko40Q+rLwA+mMQy793C?=
 =?us-ascii?Q?E++aHzSVDGx1vb8JEXZy3Ait51cUVJ06Z+u68wRvOLY7oi6Nukrzkj7lD7f7?=
 =?us-ascii?Q?fAjD2Wp6Rb3lStAAokMRJm5bNLYt9vBRQvUsigA2szjQE/X65E+cIRDhaGfK?=
 =?us-ascii?Q?U+b6hcz65O6TzzPn+lFEzTaztEZdKUvnXPl1jpwHHbAlfq6Jlr1Uh//tz6En?=
 =?us-ascii?Q?VqkiGDdq98GBC+TCPOdL0kDXEFAivyeLF2E4Wqv9Qaipj7oaIdCeQ4eZFwWn?=
 =?us-ascii?Q?/YOhEojbESZ3z2hQmmmNCtzkDMKl8optrQZQzBdTsiWkM1q8L52YfJCjfREM?=
 =?us-ascii?Q?etlgCNfVrfxSBJLgAbtpGRz4wTXitnlVk3QFsizyFcDH0ofd2rKHRszsHUKV?=
 =?us-ascii?Q?WQKQr6vhgleR6oU4+p4ZndLtlbykX+vFg3x1hL5ejl7CuUtpuiEMShw2FQPG?=
 =?us-ascii?Q?NTSjneW8EkBB9PCeU9i6OsAnQAMU8gWXjJNBHBE/4nTjjAnIlCEcU7eInDaN?=
 =?us-ascii?Q?BYlkk9s90xs0O+isUcnABy8P2Eb33VUtyATpPyffjaFjeUhdcQKbt5fDnR8o?=
 =?us-ascii?Q?G/H0OnPSn2QE5boaDvagia0klXwY/i+U7WerT1i7R9ao4RoScKqYk+/fvqvY?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803ba5d6-0a68-4ce5-8a60-08dd9207d7ba
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3410.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:20:54.2407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIpB+7OFkIZn/odu2SrNLz5RAJe5BEANuZ6ffuHwu23azIXhWZfQwnNN+CN8M54/dY2roLEO0SjYjmKrTjQIpne59ss/6+1J+z5EAS7howo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4979
X-Mailman-Approved-At: Tue, 13 May 2025 14:28:49 +0200
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
2.26.2

