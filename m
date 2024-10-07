Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C80CED245
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 23:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7143E88D7D;
	Tue,  8 Oct 2024 01:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="cnOs31QZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D44AE8860D; Tue,  8 Oct 2024 01:20:32 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B569188CC1
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 01:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPHdty7jTW6nsrE0WHW4gcqNSw2P+i9lnOIQFlk3r+5/KrBErpn12qUq1drgPn50wvtgiiLdc9clhqbknX3MkrA7G2b9QG+81sJPBxY1xkmMQ861NBVlEkaA5b62X5FQEZxB+UpUI3BRy4MJ6gCmcguIlKcL7/1oSDUdIJUK948Vw1yTye6xPuidswszWx/ozwk0C4TJDb3S0U3/HhxHaX2jbGP3jcQioZQMpMQF+HmHMy/L0/t79T5jSOLaQdgIejoCQVCuaQxQLrqARHBJjIbrLoxH+x0S2/uK5qmEZFS4M2tMDBgMmabjtm7QvqjvMUgZUiElA7bbGhgDtMem+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQTiUgS53ESYz6vDTFlxUcRHPVfaI4lOk+aduiQUhbs=;
 b=Iq1AzG+01ft9fta70t/rO+9dZxz5jVc5s2CrmfIK0UdguQceqkUSM8iOOEFgBak991+ztoRfgWcNtC9Sds030q+Idst/HVimO7lzhShf0E2zsOhs7EIwKAXEEjRitmXH6eXUKQ+fq/YyQKdurXPCruOilVeuUcoQ4wjayO7L36mYn1flKAoKYTNzEVlZ8i4bD/TJ4WAdR0ZF/KtYhDXPy3GNrUOc83zsBBI10tkf0m1RrtFm3fJ6jd6ujMglsJBWzhKk5O61LPYpo2pyQrkDN2sNJWy20D23GbhdHrh+ksHdEWjN1eCaF7oaFG/RXIudZxirnxv+H6NbdtdPPSb00w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQTiUgS53ESYz6vDTFlxUcRHPVfaI4lOk+aduiQUhbs=;
 b=cnOs31QZG7hr5bbADEJimxBebHJVGSjFBhYMyd1fl905b5j3sSs/TW80DZt2m7M0M1xV4CqoZxiS7SVY0iPcJiJTLNZxfRc7gcUoa1GLzjpRDg4PzzbBSF9WthXvzeGKIKZDntxVUNLeMeaWu6ePqh6nph+t5FlZQb7ool3rgH84UizN2wVhPhc/xYZzTDrG2D+8hWA3dOyds65mi7kai/SqqAfNtUtqVEEhKNrmw4KUxtmpTCaB06yn+TGBTC5gFgzRi2KQM27/4JkR654pETjKeTTmaKiUTEmKeffaV0MCfMEdE1ditEQkitjhAi1KLFKQrIWkU+JNmfFud/ArFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9140.eurprd08.prod.outlook.com (2603:10a6:102:30b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 23:20:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 23:20:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Subject: [PATCH v4 0/3] cmd/mtd: add missed featuries
Date: Tue,  8 Oct 2024 02:20:13 +0300
Message-ID: <20241007232016.1666523-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0050.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d4b490-6dbf-49e6-e177-08dce7269ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7pgyOIugYWjpEawIgZcCT9urlXFqEOcVNG2RmBu8uab6RoWUM/K7gS+p0DCz?=
 =?us-ascii?Q?SBvASPy+kxMAW5BXb1hZJBqDY3RyjxocnQLG6OdEyruTqjhhXFvapbozGkNU?=
 =?us-ascii?Q?7+SgP0bxk4vFdqKy1lK9DkPU3ilpV82fbnKvgUeb0Pj/WQdY+GZIJmJGO+ey?=
 =?us-ascii?Q?0qsU7mDV6An6kS6tMPU2ozPzAT5a4KSNK4RPTW1ZJhqAS9AStxudHs1W49JW?=
 =?us-ascii?Q?R3LZ59A5e7J4YnJ78cfvvgFXkjTOHwU6Mc9j0i2VERXrADKnhkUUYw3mVU9v?=
 =?us-ascii?Q?XbUiQT5k2n7wy92OP76T/woaRDV1GPX5w2l2+6QbEBBCpR4ydoZ0MxQBy15N?=
 =?us-ascii?Q?1FGZQPoQKCllVWCwu5abeTct3IMYakC2pqqT8T7Dv957nA6ZkprVwwyxKkrV?=
 =?us-ascii?Q?l0bbNlS993firyt/Y5KeHPiaq6h2aCIPn01dhnLGd70J/bjivtU30UNoKZvU?=
 =?us-ascii?Q?mF+9vRmVAvcBwVKt9fhbZovdX+ZX7BrVUAwolob0GJoSq6jLs9PkN2xeI7Aq?=
 =?us-ascii?Q?R0ip1mXABxrbQnioYPjbBMu/fjJ79JD9ZuDMA/9anGSzeY0rtr4WwWGkSHWO?=
 =?us-ascii?Q?WPsAr5Hfzbx2/qJOOB99pSNy/NpgkA6rBcYIcNyQTz6DYtolYGD/wWDlw46R?=
 =?us-ascii?Q?qcXqK1zCldDGm3EKuAEsnqJjHC869W8iqOtlWdDWjwrdheM7yNHmpMKAE1g9?=
 =?us-ascii?Q?GIZ0F+/isw9wN5unccTmKx9zy+ujT69P+AzscAdnBuh9UcnaKYjNP+q6qjNr?=
 =?us-ascii?Q?rwn5cQazGdUeWe7sxy7CbnMPUtACZJg9PYmFz1I4lzXsQPLCFP0OOn+V61xV?=
 =?us-ascii?Q?5Rp+9XXeBOb/eCCBW9W3qem270Wyq3ICaYIigWFFvYRUdJx938RWYtVBwUsq?=
 =?us-ascii?Q?p41adQg8/7vNzyzgxSiD8UB6Kdxa8ZVqk8LrhHysm8FHKOMsQnlHcXOXMnks?=
 =?us-ascii?Q?dSm3UiTiQry+NLP9ig3CnIkILy6DhdtVkAI+3smKWz+3udAchN2X5RiipnT+?=
 =?us-ascii?Q?PYkCsv/2TeYsLTOhQvURkpCCmNCy6Vx1zdBS5CWJ9qRdO6zgDJkggxhvCIjF?=
 =?us-ascii?Q?5GK04CrpQo8NKHaw8TLIlzrWZPe7uWbFTMiGzzqj8FY8PlGlcE1eAq1EvwS2?=
 =?us-ascii?Q?LjMxFz9Bss/bnySasCV/OZAagCyvy0pYT3kzo0UNY7n1Kebr2NPP4IyochQS?=
 =?us-ascii?Q?fOeer+B43ioYh4Ym+vPKlBFaRlvcsoCBWDEKRRcie7p5XSCvz1wa+4y2Oo52?=
 =?us-ascii?Q?tN2glMnVS1sLe1PXJ1URBZqbKL9sin0tfvVSppGxD2kw8BV0p5gw40XMTOsU?=
 =?us-ascii?Q?cXMnZO2eSwF5XUwXqiS7+jWqZkjOznLJm4rc0QfvPWQQjQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hLKeLrrfTQTPWEgWoFtBQhY/kulL9KZUK64aErigz9USZRAzb4WLDQo18xzP?=
 =?us-ascii?Q?aVzEQYiqE0iKDsHx/AAuLNg2YN88ld0lKD4tboPe6TVkY35okT2ix9nqxOvE?=
 =?us-ascii?Q?MrXvwtpUz/iq0ZXM2NRib8CbThFv7F3FsS0CgqmwT+rJSTCT2gocXT6gjmJM?=
 =?us-ascii?Q?x/hjzzJa0TdeM8zea+ZpDhjEEU8uFew3+AMiNs8Tj02FLaihzJx497rRg1x3?=
 =?us-ascii?Q?UK520bm71DnIvU2bQmEmNIbCSPKK0E2k5kJuSwW9JXoGDQvBiCUPtxdzXSnJ?=
 =?us-ascii?Q?oBJNZ25TevDnfyUc9Q3kGiA0qYjGPhdpAN234ks/6D34IazlNaDmUlMYURnD?=
 =?us-ascii?Q?TS+/wj2i9p6wOoGWCpnCfTz1JnSpaaC0jZ5f3j1QcJEzqirSW24igneUlBeD?=
 =?us-ascii?Q?YVMlSfXGO/gSMdKCrNPX/nTmiIh0J8CEmMc/dHwXhEx9x/j6xwO46es1Bcos?=
 =?us-ascii?Q?pAuGtO04ShLLFLHUms2RYuoyuRtNWT/r0dkeyobLAGfEqXck8FR/9VeddG9n?=
 =?us-ascii?Q?f9boK0e0UhZv4gIMq4gUuo2N8aH7ZzgGgKrhh5jE63XbgS25qFXZd//ypTsr?=
 =?us-ascii?Q?nUA84OujPTdyTuvVZItFGYqdk9EjKwJ4XLahKezacSimsed+Dx3W/JvFa57w?=
 =?us-ascii?Q?0flmPsSbstZBCZvfweQDz9VzMBR6VFXDyypTvZTnwoxV7Aa3/X5SKJ5nEigz?=
 =?us-ascii?Q?LBBlM4O6b2Zr0ZCNuVNq8uBF574HEKnsNaX+IA1qa4Xrh4U9t+nVUJimYoLC?=
 =?us-ascii?Q?6lr78s1GcgTn12HxF2GDZprTZn3u2ES57WihLX36m2cPNLAY+X7zh7tzG84v?=
 =?us-ascii?Q?V4d6S0q59nyeYny4Fe0MRlBIUsI/Tl94xaDKf1VWQ1uM1iZlXsfrZbleLFTW?=
 =?us-ascii?Q?j0V8xrmO8sANUsOq8KDsVlxmL86ljfsS5wrWt+SuZdBGCJUXocyiX2ah4m9g?=
 =?us-ascii?Q?f8I8oQ0TwZlFPzCna6GI8rzEBiXR4F+37ovMCf/wS5NLgjLnwsV8xSUhtKBf?=
 =?us-ascii?Q?/Sv7LUo97hNJMuZL2XyC4jhJTzRf9afMj2SIzOONuxJIcdN8q2+eupHuY4r1?=
 =?us-ascii?Q?+m85GXNiC+IZ3vWSXoJDYEIPJCMnY3fHWdxoCSg/dqt91OCfDowzDTZ0/Uey?=
 =?us-ascii?Q?QjMfalt9bMiMXIH6rBguq/mAPpBKzWY/xeKpU0zjrr0cKfi+Yup4Duk7JFKA?=
 =?us-ascii?Q?eyoL/zwK1NICBgFltpo75ycxveCzls1PIpG8W5LQ8+o1P98vRR6al7sDe2DF?=
 =?us-ascii?Q?hYhIhZTFZqWzoJyCdvI4YAe/gIqofHrpa/cpQBvMcgHrds8QxU+mchPh8A13?=
 =?us-ascii?Q?zUUa67zrdGxUCReb9M9+/nCskyyFH33nX2ynSEr5lHuO6YiolYJ6KURujqm+?=
 =?us-ascii?Q?pVkYnXXnL8pnOQpC5Pj4jXWF80O1g+Adt/LBo/d4/Fw8HogP4yy8PK184KOS?=
 =?us-ascii?Q?sMf1qYesdvBWxglf68Jh6OU4brFjyfdMJpNJvqFmbSekaxixy1XnPJpAXdkn?=
 =?us-ascii?Q?+R5ut4yVxOzgGjTeLUay9NVzDc9P6n+xTnIFnelbQMSpR85tZrJpAvCJE5QT?=
 =?us-ascii?Q?4j6Ed2284S9pfCPBgCDafBTbjLN1carGmzMEHXYzLghda7zlskaup9dKXvWZ?=
 =?us-ascii?Q?NvvL76G8jUUQ0ZAM1gYovGI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d4b490-6dbf-49e6-e177-08dce7269ed4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 23:20:24.2566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdCfWu30woz8kHfC2rMqAXF1c+1WFwUZI7UlkAru1fPyeO6pztEaLaAeQyrbz99suYiaqBtKO7hFy6afLL5c/IVJ15nTr6OGO3Go1wnOdDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9140
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch series implements following subcommands:
 * markbad         -- mark block as bad (clone of 'nand markbad')
 * nand_write_test -- destructive test of flash blocks (clone of 'nand torture')
 * nand_read_test  -- non-destructive test of nand flashes

Changes v2:
 * add cover letter

Changes v3:
 * rename 'mtd torture' to 'mtd nand_write_test'
 * rename 'mtd nandread' to 'mtd nand_read_test'
 * improve features description
 * code fixes suggested by Heinrich Schuchardt

Changes v4:
 * fix missed renaming
 * replace '#ifdef CONFIG_CMD_MTD_*' with '#if CONFIG_IS_ENABLED(CMD_MTD_*)'
 * improve nand_read_test output
 * use do_div() properly

Mikhail Kshevetskiy (3):
  cmd: mtd: add markbad command support
  cmd: mtd: add nand_write_test command support
  cmd: mtd: add nand_read_test command support

 cmd/Kconfig |  38 +++++
 cmd/mtd.c   | 452 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 490 insertions(+)

-- 
2.45.2

