Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F32D41C17
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDBAC83DA8;
	Thu, 11 Dec 2025 11:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hdzb9EOA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09D7C83655; Thu, 11 Dec 2025 09:48:05 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC1D48352B
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEvbZZHXwMwntv/X1G6tIpg2wV+e2kBzsjOdGoVAdxB5GiXT4GjONbFlZUbdrA1JnWxY8froeqGHa1DLNiKOQF3+UOsr+1NQ61Sgc4PjeGkWkjrdViL7JIzx/lP3WklRgh43JntkZ9ppzJMZ0zeuXuqkh4OsQHmzqpf5ZMuR8XOBor0fvV+yW69AIvvKnNtBV2Fxf9BFATRerdQnzeGjNT9rdPE+IE4L7rq9Rjh9sDdvhU/8NOHG5VHyiI+ldxXZ5Tviq8WlGeqehttY9HQlw593ppBKFcmIkxdOObBFN9uocc4nMExVTbrEkc1iEBVQn+33Ig6BFKPyACRn1avqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGgPGXWj1C9mUAvvwSRUdG2G2JkQJR4P7YJaNyjxvgg=;
 b=PKQbj1ZkHgC1SNuCbP48OvhG8JQM04XW7f1gDbxAegHzPmBRUljgA3NrsXx9vf0orGXIyKiaupJc1OdfnzMbEAm3pcqADjsqyV50UvQOuhC8dbVwyUWS5CuHEYgHReZAAlBuVkjvompRmeE3BCH/YYCPp+ajPICAC1EMC7qbPIhjPerZE7+otq8ZwenotHj3cqMZ8e7YzwxIJs71KRjS7h8li847dk0Zammn/VqV0AP/pBc9PmNqZ1us9l2YWk2y378XmlV6wi5MwSiNTs0uFch6R05MB2Ow1qJP1/6GNvjcijk3BrFbRnuzL/Ubnvh35NbJXxt0seX6ZyADfAZuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGgPGXWj1C9mUAvvwSRUdG2G2JkQJR4P7YJaNyjxvgg=;
 b=hdzb9EOAceXAoDDUhncsLsV5bJS6oqwDl8k5EQ0e00JMptjtsRsdNMyozK4q7GhiNoJCewwmbLhzg3QZzoMb8NP4dmS+IQAVYjn0Kxh9k6Y8Do5xXCWiXHtGQqz46MQdLdhPlZpiJ6Rp7DJZl2vx8BUh297yNpDSzeyVfCPrUS41IhNPw2ofbW2m70KwzA7ILoU0nQ/FikoyFqYjUFLBPsi0LOe+IuyFgdsOp7bSEQ92lD4vv/AQzci0UG+rF31wQT7OnTaAkdnxzuBmGXWsnCq9IJkGlXA5lYTPmI2HPbBiPMJTmxTAExmk7iD+IF1JzQV5nWmMSuEQ/AxI46aCMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7718.eurprd04.prod.outlook.com (2603:10a6:20b:29b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 08:48:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 08:48:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: jh80.chung@samsung.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] power: regulator: Fix dependency of SPL_DM_REGULATOR_GPIO
Date: Thu, 11 Dec 2025 18:01:19 +0800
Message-ID: <20251211100119.2470728-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0199.apcprd06.prod.outlook.com (2603:1096:4:1::31)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce9578f-1472-4f38-b98b-08de3891fd4a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4jezjC92hGAsuvS7DVW5WVQ11c4/nMhZCCNbiA4SRydXwNsDTL0d58rDKQGv?=
 =?us-ascii?Q?CDOf9P94zM9hAfvqRfyA1sGYN/WodP2+rbIXIuik58cQpxqgbLDojKfU2QBH?=
 =?us-ascii?Q?yw/Oyj0bDqWNrUAHgCfnm9A/PESkisHlSPp96heiV7aqV7cP/fkzLstJjq0c?=
 =?us-ascii?Q?JjZ6L8LSiQP4ZJqBqU7EvGq0mcaom/1MWIOR3HItNEcfttE3C+85RRuBJw9Y?=
 =?us-ascii?Q?YSnDbES6z+9znLebGBFv4g1vaf2eV6+utK+E0tkov3IBhEJxgsfP0Mg0dcdK?=
 =?us-ascii?Q?TKvn1YcEgVgQUDabxFlfRzKC3xiXLEr4TPkdLFjYaeDBFkKUhs7dTY4/AgnW?=
 =?us-ascii?Q?g4SGEdJiF/IztLuWZCUxyyUaEx/x+LAUAeHwQiYb3Y4Gwf9KnbrlS5j6vGlu?=
 =?us-ascii?Q?Me90I20jv/e0elNKCnbTDPooY3XQFzscWcmGzM+l3BX7XJXjhz8AIVQo+VCL?=
 =?us-ascii?Q?1qpnOGpGGA00/X8a9LsbRdliw5SVHAYLUBxsqzkxcmvCTdf1peskfsSnQiEF?=
 =?us-ascii?Q?LT466tuzn0EOM3eKxU278ZtKik+8TAnBHebTZHOLcTvdGsyKIXBfMuRdtl+g?=
 =?us-ascii?Q?yH3CtrqQY/rFhunQgDXxes6TgvxNIrCGgyXBgDcMLMlrzcEIfqcfC3K1KS+3?=
 =?us-ascii?Q?SYl9Gf+L8lj7MbV/W2zdSTzdo0J+LJN4f86S4GE6cYQM1VGdsOa586qgZvxW?=
 =?us-ascii?Q?GaipAMbUFfH3u4Eqi5hbOx67FPM4PxR7/aCd7Tf0Ng865GGaFnl2P0UhL6+x?=
 =?us-ascii?Q?mlehsxy5BMfOkMyJX3x1cyrpgrM4AbH08hkLcok2lJMXwK3z+iQ7s/qi3M4Y?=
 =?us-ascii?Q?Sn54NS5heHus0kG26IftAKlIG1jUsgu70T8VRYlKqppCjd8XaRvuZlNVYmR0?=
 =?us-ascii?Q?F+Rf6kb5pZ7v63NXVWTAKRx/N+kFd2DMlKXLC8em34iKYdE0TG1aQXTbLG07?=
 =?us-ascii?Q?5pzIkgWXAWrpId/iA8RISaoTKsqbKBmci3+FfTwj4BlX5GLnNvPhf9A0mWop?=
 =?us-ascii?Q?i3utv4x1JB5MjIOen96xInrW19jfSbVXfcNE8DCbT9fpvM5XjvoECkGX4aWn?=
 =?us-ascii?Q?OQcjtd5JcyZgzo6GZL2wV0MouW7PAYXiiNktEl+TwO1yBKIbAhny3kdzoD3k?=
 =?us-ascii?Q?NIhwnNFHaTK0AP9gMHAcri8uFD58GGBSeESAaOT+2ul9y6E0DjEGiXudo/Ls?=
 =?us-ascii?Q?L1ircNdEYtnUKcfoWnf7EcWOkNoiVad9eS0ppDTE2KPblf6lIBS9VzrsgYVp?=
 =?us-ascii?Q?vyNx3c1raAOC5TeqMFhfnFoMA2K2KmJfEFGUhDncSAk5W82giOrlla8a2DcO?=
 =?us-ascii?Q?7uaygmvNbu6L8+d3dvzn6xuMya4IGzJXoZYY8ZgPt9ZZbrPAKQrUe1qFUjC/?=
 =?us-ascii?Q?UQgV0zvzo6cWkTRn57HlWX1Km0cfzMhgmPOfKw8kDe3hlPWgOF9Am2IkeHUe?=
 =?us-ascii?Q?DERX3cow2fMyPakxUvVHpL1b5cTsoDsgQ7HgeImYjB7zws2UX6a6msVrj2qt?=
 =?us-ascii?Q?nS99ivfhXWMcc19cCad5jJ6qChuPCODQcyzN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ENQYbOVAGUcaxEFSn4szpxToCASWy/AEOlZjzZRLTm+OUmo3P5er29FALFCU?=
 =?us-ascii?Q?XW9kPEBi0o7LWwvAJV7Lb29GCWd0nve+Dti/2iK/9fE1reIF4by6YKAWFBpS?=
 =?us-ascii?Q?kMVhTN5AbZwA+4AAFhUsfENQ/ejVzN8CHbfQhh8lkEPpcj1Pmonr4yBBDkAl?=
 =?us-ascii?Q?4aLHpHQfCGJksE0Kmj1OXyucDJFMzpbYhJZnx8jb+ciB2irQj87BhOlMWTcq?=
 =?us-ascii?Q?n7geyalFiaNFMYG2vNiudbxhWodxRfxvuHk/51dbUPjHrOtPPvAusP/oghQD?=
 =?us-ascii?Q?7/QMiWiUG3o9z8Yxhn+THzMjzXjRUf/pLXW9xUWXXryqWu2vMp3FDQXLXC5w?=
 =?us-ascii?Q?dXINTcSlTNC2HeNhkoHaJAFGhNTcx9c6uRm5zSaxI3ba9AMOO8wsjvJSWwH6?=
 =?us-ascii?Q?x+n5AElKlZWB3Mj08GXogGfoEm9zy2TQHD2HwgNXczSiRDtEkSCeyv16t7Fa?=
 =?us-ascii?Q?v1GrPltdxBQqQb42zvBoZK62DKNnrQnDgfxfVg4vYTHlO0+8bAMrxQSyvyoE?=
 =?us-ascii?Q?O75rL2uhoeOeUZj9NxneK9eajjmv2A+Kh3ijL8GYF1QGGiZfrsU4graM0Sfz?=
 =?us-ascii?Q?6wMSwtlh50PcfRkin766cVUtCfMlLYXjP+p653gYGMGrcXpq30kkwGCTYX78?=
 =?us-ascii?Q?zsx460pQxsG3ruoCGS86iJQqEw7/2nhRNWzm6PYUelLTB7VSCXF84hYTQn1Q?=
 =?us-ascii?Q?Li0BCpXckGeRCtLIO2CZP6duYyuNSaIasRZZ5gdmMShb+zoWRL6iNkgBL9wr?=
 =?us-ascii?Q?Il0mAVe950zP1P90dePoMQhRKHa/dw4j3PVSx/VA29EW7kFmdo+GDR02qMTG?=
 =?us-ascii?Q?o8X764ktK/Wgspgb+r1fP2G5KW9Caie4vpuvE/Ay8m1zricu6Cq7SqQhnIgb?=
 =?us-ascii?Q?6U23MtXtBxspD+SeLujfavfJco3OhGbx6Ldi+zhaY7sl0bx3CACYDDceGjup?=
 =?us-ascii?Q?OxhgB1iufXwL1RA0b76sIvgf/iuUCperhqGJSqHvGpJ43HoiAdPjU8TsSIRi?=
 =?us-ascii?Q?691j3PKRVaOX0muM4ks55m+MTrINRIT31+AXpnOYNePEZzbLYp3BqebpzoYD?=
 =?us-ascii?Q?rZ4naWcvjFFYHV9P8t5ozfoKff5njvIgNJnO+ceHQHyBuQjbh1wcWfsLjqgw?=
 =?us-ascii?Q?waxqzqMd+ABVDEjUhoBVuGU8Dde2XNq1TTJGmhJgKFoeXj57jFxATPW2YFMq?=
 =?us-ascii?Q?+i1Vutk2QzSa0fWB5FgksXs/j2aTQ0xUDpNq3yna+k7Nj7sbiIBLaoBCRSss?=
 =?us-ascii?Q?7/CwCHbvy2H5P5cB/f+rrzfGlIEnHxR2BAugwJvYyF5uZe+z2b595Dbs4nrh?=
 =?us-ascii?Q?hAtTurFGHbsKyG2Cke0qIx/NBLSWWgivQt/zGhquRx3Z1IgsI96pVecSkwIR?=
 =?us-ascii?Q?X1LlgMYHrA+56RfXxCRUg5yKF9Onmp9ZNl5qMe/ZvANJkwZns3TdMKpWkKnU?=
 =?us-ascii?Q?KGz9SH3/yjAgW59g4LBoquxfgP4kE+mbIVQ/jhf0YoUbisbT81o5SkGt+3pN?=
 =?us-ascii?Q?ZpG3EBb8cPo47YBW0A6EjAp/MSJNo8/6+Ae/8z9k3y5Gyfn+AjVjBhxLlabR?=
 =?us-ascii?Q?6Y2wcyyQH+jscJLYXTogd/wHgyHYaEnV2Cbd3K+9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce9578f-1472-4f38-b98b-08de3891fd4a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 08:48:00.7226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RccFDDvXd9GdcNJVbGVGsqoy2ZI9zbr5dStddZEGuuaKDazqKfkkd32q2q+qpS3ONC3TX1BCA9agbp7KV3doA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7718
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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

From: Peng Fan <peng.fan@nxp.com>

gpio-regulator uses dm gpio API, so it depends on SPL_DM_GPIO, not
SPL_GPIO.

Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/regulator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 1875e61967c..9a535126c7c 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -249,7 +249,7 @@ config DM_REGULATOR_QCOM_USB_VBUS
 
 config SPL_DM_REGULATOR_GPIO
 	bool "Enable Driver Model for GPIO REGULATOR in SPL"
-	depends on DM_REGULATOR_GPIO && SPL_GPIO
+	depends on DM_REGULATOR_GPIO && SPL_DM_GPIO
 	select SPL_DM_REGULATOR_COMMON
 	---help---
 	This config enables implementation of driver-model regulator uclass
-- 
2.51.0

