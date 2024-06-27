Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A412C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50ACC885A8;
	Thu, 27 Jun 2024 13:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="XQ1GZMA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4321C885C7; Thu, 27 Jun 2024 13:36:00 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDA8F885B8
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWOMsySyyDer9wLPjfIuyWSxmhP4QmWWDgS4Jpo1k6XTnkFj3aTK15A9wbuTNf8fGxlUJ8MU7Dw354j436C++467+5RlKHePxx2KO1OGyFpz4YWlqkqsGxzyyq1q6wgoqRp4HMNU4GBSf5mfO32cQ5jYiI+TBCW/QvF6YL5B2cfGSvsjNYy7ZlnPWGaMy5xaiIQSfzHyjCx222Y9xsJr93zdjoInKfjH+hN/KvcJjWA5L5vDz1w5eHUzAGOdnXTcWByNR2Hyp9vXXc5A2JFumhba2e0eARPeOxTi/vwg1r7bORe4CfY9ov7jdCtGHJwCX4SmL2WtBBS32l8MzQxiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rf9DvgQVo2C0VVYwKS1mq5E4sdgw6UfmMqwj7Qfl3vs=;
 b=L9mXaiKpmvARGClIGUR+BumesxJf6gFzvZSS+j5GL+EGlJ+QgFrknWEmvad6pg5ExVyl0ki+2khjUMDDeP/TgvSiqjb+7tEujqDz28yw7jMCFkMakUcBXwPUHMquhe8909dlFuZbg0d0LXTESK4V03ns8HYxy8PyGfCHzi/EOMebeT+R19RthAeZt40j22s5FfR6HdPU4n8jGhu691PfOTnZwEbm9W8R4xQdQS6edzcZuUzTncUcGr0H2ghDE0gLK+FVHEzlMDaNOLD2HzoXm+TPlIPMDUSA/Um4C2yLbFq6JDKdEsp3qUNfFx6Kkb0sO0yADVZP8KZ9gQSU3a6e0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rf9DvgQVo2C0VVYwKS1mq5E4sdgw6UfmMqwj7Qfl3vs=;
 b=XQ1GZMA12dyGGIGp5nYDfYCF6nYV1P0qzItt//r1+JQY2nd9rzsv+rbL4Ko1688s7QqWKYpJC1uHHknCP30OKOkzf0rTVLesbQhR4NVZHTc77hSOnElka12W5W83lixValoUBMaQi2fmobOKNXUM2Z9hRhvuoZZDvepcBazQzERCuwNMKJh9jlLnMgGMiwMeHIerzjdBR/eu8k9vhE5Ghkxl5FxkcWcJo5bPAn06TMKcUxstMfVZ0vTupZAFf/zrq+7UQJwsa0kYAKea0DBbUtMDb46kzhtjuZUa5FDntxe/RSZ6YIJuPEO2UhELdSOy2ibE759R/61QNF1HlMvdeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB6140.eurprd08.prod.outlook.com (2603:10a6:10:20a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:35:55 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:35:55 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Sumit Garg <sumit.garg@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 2/3] dm: core: support dtb switching without devices/drivers
 unloading
Date: Thu, 27 Jun 2024 14:35:45 +0300
Message-ID: <20240627113546.100333-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627113546.100333-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240627113546.100333-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afcc66d-e0c2-4709-d3e9-08dc969d4eb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XRkGhbRZhzgTK51uL6hFVC7q+S2h1l1FmAz7GpijH4dNRcVR0ltj2rWgshln?=
 =?us-ascii?Q?5YlDyVfdZnW2wRXyOtrwHvm5ZCCVGUmFeBczUde5+8YSeqSC7G4SuPdTIHtj?=
 =?us-ascii?Q?8IHBHAyvyLAPytq9JZlJz+1f1F2lrVnkVj/sYdBUo91/GAXDFzwFJ2g0KhNC?=
 =?us-ascii?Q?chmtfxvVlfYfDBfwBqTKm5oY1ZJPoF5nsm/86lWfj9yqagmkmtlYnXC52Nyp?=
 =?us-ascii?Q?WyBEuyjr47lQOg5wF0a9zlPmUPxuxyZV/rGSedmAwKUyFr3xcfuyYYurMvpi?=
 =?us-ascii?Q?jGULxS5Lw08pxk12+KIJ8JNYI5ztkTl09+1rMiJY4rNPvADlcl5sACft+OVD?=
 =?us-ascii?Q?SU+2ZHR3wTFW/ZfTaXMz6OrJAc4ctCG8561jzsZNMjtg6s2Kld6KuxA98bzC?=
 =?us-ascii?Q?J0ZHbMJjcBE31fttlnGZ4v+5t8XrxzNbMh09H1hV1rIuKpaYf6BQ/O0DY77u?=
 =?us-ascii?Q?hjhWrAjw07oukawhG5RZfz86aqiSIbLO/32t679HOofExCPFhKLPsaYqJBHo?=
 =?us-ascii?Q?sbT0gI8oA9/Id5+gES8ed+SU+DGBN+KwARPI2ZngU9sFY9lKZZwvasVQatYV?=
 =?us-ascii?Q?U2OLXKntuwKC9uI/hwfVpstvuPi61SGPp51jvckqtKAcDBY3x+dqvtnBsbqT?=
 =?us-ascii?Q?2ce22NnbQa9N33EBcUCBM7wt6QaMq4Ghnjr8ujiw6NMqxwCIc0B+1oliWMMp?=
 =?us-ascii?Q?L1rJQ7mnwy/KDjZIsbktNO1e2+QH9+st4cwZefltJl8lDf9/qp4QtvFmRnlr?=
 =?us-ascii?Q?CDUDIPkiYVEFruOqUtcRQ56LQS2aZnBr3sNaG0G1eFeaCHUvkeQ4QVI2GbrZ?=
 =?us-ascii?Q?6UA4oHZbHG2LcKsRbdqxGtME23SLzGkC21TvvYQmDOdGiaiyaowfZxSkr2sU?=
 =?us-ascii?Q?dHv+5y6upseTMOXt6pWQf04qAcbjNIqp31oapJ6G70ue6YdWm3XE9RtVcoQD?=
 =?us-ascii?Q?e9HcQiagCXuT8VKWttmY644aG2oIczSieUppjUrFQCiTYNcsr8eZE51HT3kB?=
 =?us-ascii?Q?3rFnBj5QX57yOldvcwJ3OFn3f5V13h5ttRNOpLW9VSabKIHQ3Wfocp4JEGmY?=
 =?us-ascii?Q?nRxG+32P2y67ROzaysSudzZ/PI1AWqeDGBllhk3nocLGzrcjCwvCthaNSOZN?=
 =?us-ascii?Q?W4APwu1kELDyNxle848JyUQzU92iY6aNLEs/nnZ34KctyvKMeBDGGYYUI767?=
 =?us-ascii?Q?jV2tVIjLvSATM0VZKSriAWNu7KZk5N5B98s7BqKyakmMUNMiv2pn3LJQJp/O?=
 =?us-ascii?Q?Hq1NmwhnB8dKPHL4VuKbmRBSiuIM8ABfRSdeWj6T6qOcsmInQ5AmxtA6rMba?=
 =?us-ascii?Q?vSe/9GVopV9H3j2riQ7aN9oruAhdf2CruNri/CJUgVckgFqGEO0f3L5gBCZs?=
 =?us-ascii?Q?jQxVPiFe08tJ9jIzZbFKT02vAUfZqRkR6s/tfKKhLgkFsQ2YbHmI9l3UV6EH?=
 =?us-ascii?Q?2xnoReDV2no=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BFCbeBx0WOCe1fqiwQMmmDkKNfXsNUctQaDI8f0W4f+BfxN9ZuN1Ff/Alh6h?=
 =?us-ascii?Q?QWPZ+C8hmiD70XOzcOQ18XgwfDpQaWGSdwKNp2pH271meeWHYG+uk5MY/yAN?=
 =?us-ascii?Q?RQJfjipzk8ADA0neotsgzDXa28/S17wFEU1gSvi4vxPdvBQ8rVlpxz6nuZzS?=
 =?us-ascii?Q?GDHgSm+4YMQU20Z1SL1GmsyCxkOejq73N8TEHU5o5A9cNcEWbyYM3jrInIw8?=
 =?us-ascii?Q?9zwNg0EdEIEb2JKnoYlzGgYYsAr1iM7Wma5aNJNKjOZCoUGulYy2SKvwK+Ab?=
 =?us-ascii?Q?uYgwhLTbnc9dkFsBcI2t/K9GhNq5Pa8p63XAguog5+c/FDTmd2RVGKKxjoMG?=
 =?us-ascii?Q?p43ys580UOLk26RO9ilfYwwRLwMFiargLIMgzk5xUhUeReSIpOxFe+HrFO7F?=
 =?us-ascii?Q?rI4bvebrWE4QPKEUmRqObYk9ASZ4uowCvR8iK2bEktba/FbVYaIThKFqdokQ?=
 =?us-ascii?Q?smsbG1T4ZNVomhjbdg9t2uGxp7BR2kwIEZ9t3rtNFF1l+1PByrUFzh4URuIq?=
 =?us-ascii?Q?aufm1fFllCxesi/WVB1pvsk7D3nkXzhSyg+icEsCSwCrn0vIS2CYAp3npNVk?=
 =?us-ascii?Q?3wXB4YNUj3aD/c0+p+0H0FbtrSd4h1sC73t+PAhO/zOHsBU6yNbAAnAihjqX?=
 =?us-ascii?Q?Gc0BJpwXpsvyGowQEmnQn2sP+UJ5Iptn+G48Zi+BzaCrQQv+8EsWesMF78ol?=
 =?us-ascii?Q?hw8Kq5HYZ8z3rcG2gsDTIEzp09x7r05gttCAzOFbtcmVjT9zxF9QKuoRPwfi?=
 =?us-ascii?Q?QwAzm322+drSmrBPnmHmLCPHKIrgFOS5vMQEAutHM1DkhV1P1BfxII4RbsDo?=
 =?us-ascii?Q?SVPbUN79xHEgOc1LYPFNjic4C3idmWym4gzlNaLMnC18EEh3Pc9Lo85chHas?=
 =?us-ascii?Q?2OCKJR530XlsIHVdnlQ3k1iKmVpczS1PZdGx46KIQ8GPW2OvUur2lCKmQJFP?=
 =?us-ascii?Q?DTvEAa5oXWqeazF8/EsrEla4OlfKf4NbzQYK8fTnK3Jy5HuTlE18Cn+EbsSw?=
 =?us-ascii?Q?zCGgd0DOvCx9LGeA6zZPFa09XqkJPKCxil8Gjauu66kLsuhGZYx7ctZKnbXW?=
 =?us-ascii?Q?D3pVBtV0snRIzLa/2IbKhBxIGuDNYhROcDv7jnFlKwlonHxgiffDoohAR9j3?=
 =?us-ascii?Q?aKpsUySfBgGP+bmQ2hRAa7INNq5R2jfhCPnJR0pkWiYsDZ0cXu0Ui8oPRqL+?=
 =?us-ascii?Q?W1DOFTR398dWcZ7zDVYval1EIkF4yGcSxLuAuG0uylnGoXUltPa2pfg1Cks1?=
 =?us-ascii?Q?GCz4IHeBSWoyVquxXWmIyXmtirmc14OapQbgSo56Z7duxMeywwIn4zSWTEVy?=
 =?us-ascii?Q?I0pOhRHe0siRJY97zCQtXHVqU1NABZdnD6n6pts2Kv+Pz1GldM3QYPPeYtKG?=
 =?us-ascii?Q?4SW8SGWDeobl2CkKt4cqg38MuqJkkV1qgEfej8TCxLKJkxbPZypEubjHG7Lx?=
 =?us-ascii?Q?4bEqWGWePGNB4DBXC8qq+afKpFNC8MzcTqkQLhgAz3rElHrJduIf46xG2hMI?=
 =?us-ascii?Q?B2GB90pLCuR+E//aJqMOXM3jO8Euaaes+4/25LGrKAPkId+LR351qul3PND2?=
 =?us-ascii?Q?Re+dn5pDi1utX+/K4+3pQMMO8eDTFaoX9OqJ4bS6btrB1eRr64kAkBzHe68u?=
 =?us-ascii?Q?WTQBlzh5x7jm/3KfqcQFKfI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afcc66d-e0c2-4709-d3e9-08dc969d4eb1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:35:55.5467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpLrJ9Jn0HMg7EO+eE/JcTDs4ZpHp1vwhql9x330LiCtxp75jYmj/zMfuzlXuDh/s7LNnwMPJAo/bBAGsZzQuKXBO5iDvhrLmnSCYBVaFMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6140
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

Consider a case when we have several similar boards but leds & buttons
connected differently. Some of leds uses gpio, other pwm, third gpio over
spi bitbang. Also different board may have different gpio hogs. And last
but not least: board type stored inside a ubi volume.

We want a single u-boot image that will support all these boards (we are
not using SPL). So we need runtime dtb switching.

We can't use MULTI_DTB_FIT and DTB_RESELECT because they tries to switch
dtb too early when flash & ubi drivers are not loaded/activated.

The following code do runtime switching

	ret = fdtdec_resetup(&rescan);
	if (!ret && rescan){
		dm_uninit();
		dm_init_and_scan(false);
	}

but it have several nasty issues
 * additional code required to reinitialize console otherwise board will hang.
 * MTD subsystem is not cleared, we need to remove mtd partition before
   switching to new dtb
 * spi-nand flash will be named "spi-nand1" instead of "spi-nand0", thus
   flash becomes unusable
 * some drivers are unable to deinitialize properly (ex: network driver will
   not release mdio interface)
 * some memory will leak, because most of drivers assumes that it will never
   be unloaded

To avoid this nasty issues the following hack was implemented
 * Full DM and console reinitialization was skipped
 * Only missed device/subdevice added from new dtb during device scan.
 * Some driver renames their devices. As result we can't use device names
   to match old device node with a new one. The special field was added to
   struct udevice for this purposes.
 * Driver must be binded to the old device one more time to add missed
   subdevices.
 * uclass must be post_bind to the old device one more time to add missed
   subdevices.
 * We can't use old dtb anymore, so replace old device node with a new one
   for existing devices.

The following restrictions are present:
 * initial dtb MUST be a subset of a new one
 * old devices will NOT be reinitialised
 * no devices will be deleted or deactivated
 * only new devices will be added

Typical usage:
	ret = fdtdec_resetup(&rescan);
	if (!ret && rescan)
		dm_rescan();

The code was tested with: gpio, gpio_hog, leds, buttons.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/core/device.c | 31 +++++++++++++++++++++++++++++++
 drivers/core/root.c   | 15 +++++++++++++++
 dts/Kconfig           |  8 ++++++++
 include/dm/device.h   |  3 +++
 include/dm/root.h     | 23 +++++++++++++++++++++++
 5 files changed, 80 insertions(+)

diff --git a/drivers/core/device.c b/drivers/core/device.c
index bf7f261cbce..4f575ca82e7 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -62,6 +62,34 @@ static int device_bind_common(struct udevice *parent, const struct driver *drv,
 		return ret;
 	}
 
+#if CONFIG_IS_ENABLED(MULTI_DTB_FIT_RESCAN)
+	if (parent) {
+		struct list_head	*entry;
+		ofnode			dev_node;
+
+		list_for_each(entry, &parent->child_head) {
+			dev = list_entry(entry, struct udevice, sibling_node);
+			dev_node = dev_ofnode(dev);
+			if ((dev->driver == drv) && (dev->uclass == uc) &&
+			    (dev->driver_data == driver_data) &&
+			    (strcmp(dev->node_name, ofnode_get_name(node)) == 0))
+			{
+				ret = 0;
+				dev_set_ofnode(dev, node);
+				if (drv->bind)
+					ret = drv->bind(dev);
+
+				if (!ret && uc->uc_drv->post_bind)
+					ret = uc->uc_drv->post_bind(dev);
+
+				if (!ret && devp)
+					*devp = dev;
+				return ret;
+			}
+		}
+	}
+#endif
+
 	dev = calloc(1, sizeof(struct udevice));
 	if (!dev)
 		return -ENOMEM;
@@ -75,6 +103,9 @@ static int device_bind_common(struct udevice *parent, const struct driver *drv,
 	dev_set_plat(dev, plat);
 	dev->driver_data = driver_data;
 	dev->name = name;
+#if CONFIG_IS_ENABLED(MULTI_DTB_FIT_RESCAN)
+	dev->node_name = name;
+#endif
 	dev_set_ofnode(dev, node);
 	dev->parent = parent;
 	dev->driver = drv;
diff --git a/drivers/core/root.c b/drivers/core/root.c
index d4ae652bcfb..4bf1ff80636 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -340,6 +340,21 @@ static int dm_scan(bool pre_reloc_only)
 	return dm_probe_devices(gd->dm_root, pre_reloc_only);
 }
 
+#if CONFIG_IS_ENABLED(MULTI_DTB_FIT_RESCAN)
+int dm_rescan(void)
+{
+	int ret;
+
+	ret = dm_extended_scan(false);
+	if (ret) {
+		debug("dm_extended_scan() failed: %d\n", ret);
+		return ret;
+	}
+
+	return dm_probe_devices(gd->dm_root, false);
+}
+#endif
+
 int dm_init_and_scan(bool pre_reloc_only)
 {
 	int ret;
diff --git a/dts/Kconfig b/dts/Kconfig
index 6883a000a05..ab486b21fe2 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -292,6 +292,14 @@ config DTB_RESELECT
 	  config allows boards to implement a function at a later point
 	  during boot to switch to the "correct" dtb.
 
+config MULTI_DTB_FIT_RESCAN
+	bool "Support switching dtb without drivers unloading (experimental)"
+	depends on MULTI_DTB_FIT
+	help
+	  This configs adds possibility to switch from initial (minimal) dtb
+	  to a "correct" one without devices/drivers unloading (ex: board type
+	  required to switch dtb stored in ubi volume)
+
 config MULTI_DTB_FIT
 	bool "Support embedding several DTBs in a FIT image for u-boot"
 	help
diff --git a/include/dm/device.h b/include/dm/device.h
index add67f9ec06..409b1c4861a 100644
--- a/include/dm/device.h
+++ b/include/dm/device.h
@@ -170,6 +170,9 @@ enum {
 struct udevice {
 	const struct driver *driver;
 	const char *name;
+#if CONFIG_IS_ENABLED(MULTI_DTB_FIT_RESCAN)
+	const char *node_name;
+#endif
 	void *plat_;
 	void *parent_plat_;
 	void *uclass_plat_;
diff --git a/include/dm/root.h b/include/dm/root.h
index b2f30a842f5..dcab28f6c47 100644
--- a/include/dm/root.h
+++ b/include/dm/root.h
@@ -155,6 +155,29 @@ int dm_init(bool of_live);
  */
 int dm_uninit(void);
 
+#if CONFIG_IS_ENABLED(MULTI_DTB_FIT_RESCAN)
+/**
+ * dm_rescan - Rescan ftd and add missed DM devices (experimental)
+ *
+ * This function can be used for switching from initial (minimal) dtb
+ * to a "correct" one without devices/drivers unloading.
+ *
+ * Restrictions:
+ *   - initial dtb MUST be a subset of a new one
+ *   - old devices will NOT be reinitialised
+ *   - no devices will be deleted or deactivated
+ *   - only new devices will be added
+ *
+ * Typical usage:
+ *	ret = fdtdec_resetup(&rescan);
+ *	if (!ret && rescan)
+ *		dm_rescan();
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int dm_rescan(void);
+#endif
+
 #if CONFIG_IS_ENABLED(DM_DEVICE_REMOVE)
 /**
  * dm_remove_devices_flags - Call remove function of all drivers with
-- 
2.43.0

