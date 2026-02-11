Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6244ECD6D3
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 542D083E76;
	Wed, 11 Feb 2026 19:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BH4GnHVZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F76883D9C; Wed, 11 Feb 2026 19:23:33 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC5EF83E69
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxU3e16Mk3JDmivySSuyy7lDZ7p04F6fBWlygqsCz6AV8BckJ8rLFt7DISlc1HAkKARGdw2XpW/2+O4PCTZw76fqeiOZUv84a1pbLwL2NoclYhPE3EoMJtcSRQl5fdUZnXdcswSshMhw3C8e/lQgzJc0QWbNVZV74LgabH2nufFkwS8WhgNbN9d1l3kFgHuIpll8DUY6rvklrLv/PeLqb8586XD8PX5ykd88tqzQ7A6usaSE8uJjoRw5ggzn2ki3sFQV+oZt2JtQU48PHk2VOPVpUWzzDEUqmLe0s0UnQIOTEgEJsj4MB+oI3qKudf8RmuGNpJD1+/6iL4czKtIsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+on45JFuYCsZ7NKxHobQwnFYSanlLADH3G5jRjn5kY=;
 b=a6WLllEsXdVxU+oF6Ie5kzj/SmdY2YHK+SP2m0Nqh/laUFz+gE733ovGqzFUCUb9NKSC10MCugCGMfLI/1BxscuVUM5fH9hiU6tkh83Xa4BjXI+lRhmgsLFcVL6Ebdu90TSuqbjVS5Fa0hfyeQubwF52bfl7lqrsuJ5eB8LO9avwHPButQ9ewG4a6lN1nP67KSasKTszGhRHv6PBY9i1evtv4lGHFdvFfOympG0colDCzAFoVH5k+FYnjfEx6i07CsaZZYKg5E6LShndJ9HpZz7DNklg+slE6EkNzIRKRg5Kwz1gul2LX1/K3LknqGJKVxNzfZdJTqPzwJVMy3IJrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+on45JFuYCsZ7NKxHobQwnFYSanlLADH3G5jRjn5kY=;
 b=BH4GnHVZAN30HwV/0BrFjlx/EJ9oHO+7pounV/G7LaO9hJr7UymlltxONq30n6zX0KfjSWNc8v0meyvUzWOVbrtWgmHOsOCrk+TByOlks+QxDWbjoP1Z3mEZhgqr58M7OFhXYee+tjAj8bGmZTTuagJqOUa78oLy7X8lL8fzAYzNRpRbFvdvAySAzGXZRyTypmlmNCEIIcoEDH0tP1dYvjQnN160y6lkONlh19R2t6bfNEUJWg01w4PHeAJ1wtfOPIqQIEbOGjfVta2+3tlNsf31zwXO1Qy8TAviXhZOkVPskZs38VofLNOL2lwfqI43qhKlgtcosKPIB7iBYsYTuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB11040.eurprd08.prod.outlook.com (2603:10a6:102:46f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:23:29 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 18:23:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 12/16] airoha: add PCS node for AN7581
Date: Wed, 11 Feb 2026 21:22:26 +0300
Message-ID: <20260211182230.968921-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAWPR08MB11040:EE_
X-MS-Office365-Filtering-Correlation-Id: b99977bf-0843-4c5b-e0e1-08de699aa79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eTbgMoEVKbR2Hk/ngTERkRimwhwn0oh1F04RBiNkUoOwuU7DR6yAeBp1NWh2?=
 =?us-ascii?Q?BkYQAiQcqOfLJvYuB1SBjZHcp9hHnMakhqmNgmpgg67G7ZnmwTvFHRRk3WK8?=
 =?us-ascii?Q?x6/5TAeuDLN5oAA7oEROx3mkZUD4O3XTX0E5E/pknV1tdXNkPESvY/+qjCsP?=
 =?us-ascii?Q?4UtrryMXaLhuS27kejAkOtVq3DMkmTSYOA/FDUWnGE3OGJmN9lVmodSl8LSm?=
 =?us-ascii?Q?tqV9yPmiZCf6YnZqoa5PTzD14JET8g/8uZB/eFGlVnghulXNG5EmHSqB+Far?=
 =?us-ascii?Q?MWkFvQX3I6EXoWl0MghUIsA4DucfYNLF0dZBIjP2RXjY12R9PGxFE8czf3dm?=
 =?us-ascii?Q?TEUhbndgqRkd+u4UIEx/ZD/TZUsvHOBT6LYxcPj82c8G4V4oT0wWpMEawciO?=
 =?us-ascii?Q?x9ki4EY1tta91JzThfG7qxmk7XJhpFmwyzGSZiODdXKO2bpJHn0tCp7egh1T?=
 =?us-ascii?Q?4stPtHTCaH4CW5NmNoWX4jgsWZMjkvgf+pnwyADvc/4l6cSMKmINLFX4rBgr?=
 =?us-ascii?Q?sWyJ6doCy048rOMTHf1yawO7+Xe+UfRwW1Klkm1ZZFchPQocwvKN4aJSOvbJ?=
 =?us-ascii?Q?ILz2JYBYpbuOwlokWNA9Xi/PhVhHibOBMVhUe2hPushDNuCIkwdStu9Qxs73?=
 =?us-ascii?Q?vY6DK3rE5+jCS50CVmiQjyOWoekP+/47m3ZXjg1vXU//ksSUyTi9UzLSLN5k?=
 =?us-ascii?Q?R8yzhkWc6BcPD853vocE0f/ryEARYVkR/FA5K7OZR/13cbr2VIgvFFG3XHj6?=
 =?us-ascii?Q?Xlz+Cnxk7nce77Kxu+OUfHVgVvJuMbTjA4hBzvbGxXcB7OU7XQyOtISwzXkn?=
 =?us-ascii?Q?w0kSWfZ2i5gJbAX1tN3KlYjhzEUG/rWxaGDtvOvc+5H4s1Nb49N1Ktv9fn1r?=
 =?us-ascii?Q?Y985L3ROnhUulq6XW4gVMv9vk1aEtfRZN+QvAdhxmmMm9V2nW2AZ8kX2C/TZ?=
 =?us-ascii?Q?gtJ3WExppTbtfUdqA8q0FEv4ulBhcK3sL0um7AqLlOEqE3RECm3Sox60sYAO?=
 =?us-ascii?Q?6+z9NS1KF4xMMYaqkgLFra2hu8iC2YHq+szXS/4K51y4iPbhTCzM8zz2IFt8?=
 =?us-ascii?Q?r1rXy9AleIkwp9kqB5obso0UWxjb6HS161DrU/BCok9B/XAwXFW2Ku1C3WsW?=
 =?us-ascii?Q?FcwHb57ZFy5qBaqw57+muFNqLNoa2WtTvg2BvIm77Wi8yw/FT8+XnceYV0vU?=
 =?us-ascii?Q?D1mifABL8Q2gCqOJIAP/NAnrDL89iO5u747YhxD1dKPgS9G3Xdq8KswL8N6x?=
 =?us-ascii?Q?bZ++KzXzJaNcj2vxBbVsKr/+8bEeTWvIa2wn2MOVAF2QZaRjP9AKkq/q1kaZ?=
 =?us-ascii?Q?VRCXc3tnwnz8ChnoGAtiIt0oJ0d+tlq+2qM8tBreXEWdJSiec5se9xnIh4tz?=
 =?us-ascii?Q?7skPG2K5yNOICKsQM085DkOkPfrOw4yTHpSDtWjWCco8XPQoO75SCK2znxfT?=
 =?us-ascii?Q?S1H1NO4atMPqL9CDppRC2ArZn4ZqTNDcEfmt5RltuLCXeSyXWh2nj3RtuhVv?=
 =?us-ascii?Q?OHP8mE/1HM8nLXgqW3djCfiMd8MVhIPnFGK72r0Vh5P0MywdVW+Eg+9AEi98?=
 =?us-ascii?Q?6YMeSPSLN6jGmbZIo1Y/EkqHW3Jd3OQho8Mjsv2yGaYfgIU5Yl/2RH1Z5XIz?=
 =?us-ascii?Q?MiA9cqXb+Vfy1pOVmSareWITrVahmiWKSxEU/M7OGFpQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gIOD1NNRpq2moFjs89N+wDDxd2fABcO7zraQCYfHe6Sq/7j4jyjs/W1xnbgn?=
 =?us-ascii?Q?6xYd/7zpwIb4bM7RwR2dTpGwFNS4jNtSsNf5Rifs6ZAu9rZly6VsER37BJV1?=
 =?us-ascii?Q?DcHgoqOVATrzfgv6hEmTJSQdOaClTtWwbR6InnKoVRHmyF3s5f+JXuccW8qm?=
 =?us-ascii?Q?9RMrl2YIfAmahWNvHsLGwOvr7VlOknPYtGRx+6ins/FHEusWS7q9KSP2xdQT?=
 =?us-ascii?Q?KGAnhrfVlRiH6kMSnetV0shvLTlYu8HWiZVxhQWMiQvFFgmI1ApvzQC7oHee?=
 =?us-ascii?Q?MB+GT2pXtAtca9IlQGL2Hew6BsyU+d+zF3GOwQNP12qVsAtKtr+62Bn69jbp?=
 =?us-ascii?Q?lRV6gGjN2Ado/twWbGZVYgzQhSFV+8F4+u/5XbEl3ub6WKYIGZsGABX5jnRa?=
 =?us-ascii?Q?VcD7SpzcTitC2tlDMHTPdMDVU6qHzImwCQGU1COEpAZgRiQ7QBdKrJCIUw9w?=
 =?us-ascii?Q?G9qr1IF/fjjdWHR/7zCbfKPpOJ4+8piursjkLmkFxxlUQAbQYPerxubJgnVg?=
 =?us-ascii?Q?GXi/QuumR3HFoA13e9GxT551gTFsYzuSM5hYzug8Tc0nKjBOYN0tq89a/8T9?=
 =?us-ascii?Q?9A3nFN/PuQ0MzeFaYLYLqPMnKmEyOvVVMuAC9EQh2klzY0n/ypxVAiP2ZL5f?=
 =?us-ascii?Q?tPigCDYDKsixxIIUEYZTo+cY3nuV0D5q0kJEXBtemLxeFpo0IzOiIUjgLrz5?=
 =?us-ascii?Q?DZ2PEvwQ4/8tHcBWET9GrtNhzgsI1y7cTx04NAjwX02seagmwl3dR1YE4vWB?=
 =?us-ascii?Q?DByJudoxNIV2l+GfJRazYcqsznEXmyjxIAeyjCmO8yBp12fJcLWmMvD6hqJg?=
 =?us-ascii?Q?wQm9f7jEDCwQayxpIAp5/vNy5VhQGw5W6B+Lk3oh4c5ey9R0o9U03T89MVMp?=
 =?us-ascii?Q?Un7W/E6y6e8W5/9dGJF36rrva5wtPuzzn0aGdzaqq7cUnrzZrFPBc3AfjBHj?=
 =?us-ascii?Q?mOsMHr/Zi4LS66oqbpNb3FIsO+yuatM78s3befXkqV943x+iZ74i/gD+x4M8?=
 =?us-ascii?Q?F/47A5xxH2jHv0p2bM+BN8sP1cmSwLwgV54Ts2L3AFZS7iiBkkL2hcZjOjoL?=
 =?us-ascii?Q?55WURTYD69ryvkc2eGBp+xWT/pcW0wnlhFyM9M6lgUDdmk6kP2UKuyts85lP?=
 =?us-ascii?Q?0brftLggr4j6/O3GBewFnfiWO+rdQmusq21rAS73kmZyRpcMSMOYzSI/VSXT?=
 =?us-ascii?Q?2k75f66G+PyrqgiKsWmTuzxZ0QQusGC5yJns2LpF7H0pKUvdGFPYZX3FzBmZ?=
 =?us-ascii?Q?tN5ZOghjD0488qQBLDrpgYfNwUZKjBQaKrAR9Q06of1yDkG85wF2OLIgdt0I?=
 =?us-ascii?Q?Z2naQ+pF8mINEc2sH4Q3qqkS9YfOkNwihpLkJo/XXEYM848ngTHc7pIX4rwP?=
 =?us-ascii?Q?74d29nTe/rjNFmE8kyJXXZ36jmdtjuN9l8ue9nA0kiVkxXYPTiqCrHS5zlXa?=
 =?us-ascii?Q?88/sdh7hVwievq5TJFZS9/p5MqS+cD+eIk237KAiIuL0ry3szy+fYzRO4GpF?=
 =?us-ascii?Q?hdhAr0YbF6xkthCVtGMNfX14L9Z2g2JUJgKDDphp873C/wfoXKn9r43jBCcS?=
 =?us-ascii?Q?nb9fYtPmspPwdCKZ9FaGuR97oEW2BT9fjGU1zl69pieUYXFY2rZiTQYkEPxs?=
 =?us-ascii?Q?8abA3M/dOGWZm8ghOA6J97eVggsdfMckaeEYjsdISKaOWomsHGVvvcf/goTP?=
 =?us-ascii?Q?meGkOchLbjztRXTfQC8YmkRG1Eb++MdgBgjbhsGYRGzxyIryPDxhznA344E1?=
 =?us-ascii?Q?Yxm/p0cMLDwz8J6GIEUG2Q8Syc8ipDc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b99977bf-0843-4c5b-e0e1-08de699aa79b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:23:29.3459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUjT6G8KY8QFp+VgzWwR98Ci9JFk6yrfAq8VlPnU0vQE80Woxq6u5o/pzJM5vITDHONdxPwP13S5ROglFg1KmGZRZH2cR28jNdrNe4af+NI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11040
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

Add PCS node for Airoha AN7581 SoC to enable support for Serdes Ethernet
and PON port.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7581-u-boot.dtsi     | 71 +++++++++++++++++++++++++++++
 arch/arm/dts/en7581-evb-u-boot.dtsi | 18 ++++++++
 2 files changed, 89 insertions(+)

diff --git a/arch/arm/dts/an7581-u-boot.dtsi b/arch/arm/dts/an7581-u-boot.dtsi
index c5e24c76457..4548076b96a 100644
--- a/arch/arm/dts/an7581-u-boot.dtsi
+++ b/arch/arm/dts/an7581-u-boot.dtsi
@@ -35,6 +35,48 @@
 			reg = <0x0 0x1fa20000 0x0 0x388>;
 		};
 
+		pon_pcs: pcs@1fa08000 {
+			compatible = "airoha,an7581-pcs-pon";
+			reg = <0x0 0x1fa08000 0x0 0x1000>,
+			      <0x0 0x1fa80000 0x0 0x60>,
+			      <0x0 0x1fa80a00 0x0 0x164>,
+			      <0x0 0x1fa84000 0x0 0x450>,
+			      <0x0 0x1fa85900 0x0 0x338>,
+			      <0x0 0x1fa86000 0x0 0x300>,
+			      <0x0 0x1fa8a000 0x0 0x1000>,
+			      <0x0 0x1fa8b000 0x0 0x1000>;
+			reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+				    "multi_sgmii", "usxgmii",
+				    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+			resets = <&scuclk EN7581_XPON_MAC_RST>,
+				 <&scuclk EN7581_XPON_PHY_RST>;
+			reset-names = "mac", "phy";
+
+			airoha,scu = <&scuclk>;
+		};
+
+		eth_pcs: pcs@1fa09000 {
+			compatible = "airoha,an7581-pcs-eth";
+			reg = <0x0 0x1fa09000 0x0 0x1000>,
+			      <0x0 0x1fa70000 0x0 0x60>,
+			      <0x0 0x1fa70a00 0x0 0x164>,
+			      <0x0 0x1fa74000 0x0 0x450>,
+			      <0x0 0x1fa75900 0x0 0x338>,
+			      <0x0 0x1fa76000 0x0 0x300>,
+			      <0x0 0x1fa7a000 0x0 0x1000>,
+			      <0x0 0x1fa7b000 0x0 0x1000>;
+			reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+				    "multi_sgmii", "usxgmii",
+				    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+			resets = <&scuclk EN7581_XSI_MAC_RST>,
+				 <&scuclk EN7581_XSI_PHY_RST>;
+			reset-names = "mac", "phy";
+
+			airoha,scu = <&scuclk>;
+		};
+
 		eth: ethernet@1fb50000 {
 			compatible = "airoha,en7581-eth";
 			reg = <0 0x1fb50000 0 0x2600>,
@@ -52,6 +94,35 @@
 			reset-names = "fe", "pdma", "qdma",
 				      "hsi0-mac", "hsi1-mac", "hsi-mac",
 				      "xfp-mac";
+
+			gdm1: ethernet@1 {
+				compatible = "airoha,eth-mac";
+				reg = <1>;
+				phy-mode = "internal";
+				status = "disabled";
+
+				fixed-link {
+					speed = <10000>;
+					full-duplex;
+					pause;
+				};
+			};
+
+			gdm2: ethernet@2 {
+				compatible = "airoha,eth-mac";
+				reg = <2>;
+				pcs = <&pon_pcs>;
+
+				status = "disabled";
+			};
+
+			gdm4: ethernet@4 {
+				compatible = "airoha,eth-mac";
+				reg = <4>;
+				pcs = <&eth_pcs>;
+
+				status = "disabled";
+			};
 		};
 
 		switch: switch@1fb58000 {
diff --git a/arch/arm/dts/en7581-evb-u-boot.dtsi b/arch/arm/dts/en7581-evb-u-boot.dtsi
index ebd3b8b4958..9a02122fbfa 100644
--- a/arch/arm/dts/en7581-evb-u-boot.dtsi
+++ b/arch/arm/dts/en7581-evb-u-boot.dtsi
@@ -9,3 +9,21 @@
 };
 
 #include "an7581-u-boot.dtsi"
+
+&gdm1 {
+	status = "okay";
+};
+
+&gdm2 {
+	status = "okay";
+
+	managed = "in-band-status";
+	phy-mode = "10gbase-r";
+};
+
+&gdm4 {
+	status = "okay";
+
+	managed = "in-band-status";
+	phy-mode = "usxgmii";
+};
-- 
2.51.0

