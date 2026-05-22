Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AC4CD5BB1
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 13:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D581846A7;
	Fri, 22 May 2026 15:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="NJkEqr3v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2842846FD; Fri, 22 May 2026 15:49:36 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C25118469F
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 15:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqsubWtJxm2lAlq36L2ebP5lnlC34iIsdwEFqu2y9ld/44wFl45qL//TNQV5IoteNsd/ZJAZVSOmIjAw1PXjT8rmkpQMlWjf7ii/GtQnr3XOVbhz8akBXgEm6rytrpJZG1xToA0gWpf+rxX3bjTk78qVjfdMo++IHO+G/gEq5BV5QeoCqVwip/cwfliXgLVYIsHZbEXccW5jFj/wiUlPf6fdEvy7foZK/P4NxJias5EBQ9uAlr91Zgwhvex7UhwxulrOb21DXOtQ71MIiG8LBnOSqVata8G8ognyd8IOoT/8HNFBVTGpO6WM9g9ObpTJb+61XlB03mQGwukeSj6O9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESOJ0D1fUZ1yRPwNuu1DB7Dm2dlOjqriyXumLKaqD34=;
 b=m2ZN701F2cdOj0svcDV2+4SfjBo3QqI8CnR3uzyjv9JuAvXJh9YwQai44o++JyPztRsJWoLUJT1ZKKEs8SA0DMofcVHcUzRSPplGipdGDt8vBGcMgYMyh71X6orVi5xzUpEVnDQEaX2A77b8i30DUzgpUdDe3hdewUuYN8Fc0WgrFn8mJvOF+iUXGvi6eqabt37apoJED5TcLpBC6oSCibUeWjWhny61W2te9LIxhh7cFH8RO+7p+XUDN3ZLRaokEmW+idTOXwC7O7Xf1cu72c6qUwW/GtUss/ezvKGT3I+XELJRdyNaUMRo/8/edEWQIzKPwvqk0wfzgdOAbn9rcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESOJ0D1fUZ1yRPwNuu1DB7Dm2dlOjqriyXumLKaqD34=;
 b=NJkEqr3vDbQ8Kql96gueAlACup8Mt9F20tYgu96a0CLaF+gZczc1q46fh7CMRoueQttvzJhNPT4veoGJYLBsAvxRONwRDYBgS5BcBZkzQeGccLnwDkPkgMTSnnngRUqQ9XcOv8FbEbqYrnVqu8JNrUPMOy5IZ4+lZLnhnzg1Ez2T54pI22jEbzwLTS7PPgW1y75XIcbJvxd92CIa0D3bCFFKx63FGngiZFzV8LdDjK7Iik5cYVTuby2BJBAnpLG5GuUq2zF5LUlDyhKzDgEbMHQ56+Q7qWOAQ7oR2p0udmJDfP+OaCfxDgJXGPAwozf0IOakaxxtyXCTDFpXgJDYiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by DU0PR04MB9348.eurprd04.prod.outlook.com
 (2603:10a6:10:358::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Fri, 22 May
 2026 13:49:31 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%7]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 13:49:31 +0000
From: Ye Li <ye.li@nxp.com>
To: festevam@gmail.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH 1/3] cpu: imx8_cpu: Fix CPU segment information print
Date: Fri, 22 May 2026 21:51:42 +0800
Message-Id: <20260522135144.1643089-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0214.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::10) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|DU0PR04MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 21840bd6-6631-4fb2-9bc8-08deb808f31f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|42112799006|19092799006|18002099003|56012099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: V+ZalDskcd8WyCehTCxwhmtox0X86BOGPv/AERu8/q3F3uf+LmmQ7Eh9hLFjxZUp8NSqZcGw1L7FyhehLG2wZN6NMdIY27oumHVuHliTSzq3IGj9SXYfRf8Ks1KTFm/ythlNsbktqY6wmLFAXbk7W+4CPaLt+IgrRT/Fzq/W5fwcKwSwRQQ7Y2hoYbgJLVHqDca4UUDpULBvP/+pER6A79mneIxtw7CczsLwZi0XKlnmk9dJu6OVw0phsCA8QxN8MDMIOKqNDBgF3Yd/t2tcobwfV/EDVEZQLwEdIQwXS85g6gXMD09kGg6q7WhiW9SggAj2vgzT8+XaLZrZUj3TUAjxG4+q+VkuVzSrgwfKZ7RJ3RtSQiL2x8hu8KJrbJQ39il89Sgfaq+RrmMMEn0cXIRYC+MOSIW+et3V4K3kxrpK/6RqX3P2koDyF9lhmSFe3VdU2iBU7Sjy8wGVnubfguxMuBneYKcPq5CI9u+GJWZklCfTF1LCLcqTQ4CJIr9f5nmdVRdGMSCC/md3ROTB+k55FQf17bA8AJeQFwnOFy1LELWtM1yd0Eiy/ZUnj0zxlll9tkBJeBT2GPiEcU2d4an9gFE8dxV0NC9g+vfSZMIsq3e8HfBgi14YGAz+w8Ln5iUjhTBhRtZBqW00quy7iG5BKkeO8shnEENpilgnmjr0VrkZ/BwducJbulBqfZn3eizEygR3PSkSZp4PVXanS+0XM4wCLw1iTlysRdsKFKNUmqVWo4VCoD6XZX7KceJ4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(42112799006)(19092799006)(18002099003)(56012099003)(11063799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qvKppTWNmdTFqkRcd2nAER3nrVkwfqKMS2Kf8SRTGU+sjJB1RBVWcZi9cd4d?=
 =?us-ascii?Q?XumdB9mnRNHmQiTBHkDIqTIJ6py2vyhVVXjTWW9dP8h32/CTui9iuzjit066?=
 =?us-ascii?Q?P21IJKscfkZeo3H4aXqxhHbsgfzSzJes1nsjhXQH980NHPaqaqzeIGZ4ljzD?=
 =?us-ascii?Q?ub43xOselcfO/q7YQreFqfbwaLdgUoGFm6nGG0vXEpxQ+Q8U//7OHvWwyXMU?=
 =?us-ascii?Q?yBG3VBOeP7Vo1GE/I9+M+Hwt9Z+4t64uWV0bDRpmA2XUnWyYJEikrrnxf9w/?=
 =?us-ascii?Q?Nit+P4wMP0jy7HQWboqN2RWEtA5JM1G7BDOrmfsad1AR7CCMPdVYdNs4A+eK?=
 =?us-ascii?Q?1NsUd0zeCPPZloKv994+8sP9ItB6ObDseDNF0xsGlk5eP7LfmyspsFMDYEAp?=
 =?us-ascii?Q?WHZsF3/TK8Gv2Ftow/YIK+qoilnhE2N3S7thnaIZstReaXv1xPOtLdplIxHu?=
 =?us-ascii?Q?jcSYrDCe8uWB6Bm5VgcU197R/YfSls/lZuYFMUjcfK6tVdyJ09zyO08KqaVv?=
 =?us-ascii?Q?+qNDaFtYTs1mKBk8wFTAUbgUR+AdUEzXcIRDy2kwfRrMJ43G9mPG0TCyXEl3?=
 =?us-ascii?Q?5L4fTegJ+n0e/hJ8mqDcwbFMMsOI+w4NcQG57BlGUYL9qXCF3rcpi+zoTGaz?=
 =?us-ascii?Q?Pk2y8UoT9NdICXQ7vUGvtSI+p0y5vxUje+XSUz12wllpLK+mPRfVkPq3p9g2?=
 =?us-ascii?Q?7A/cmqRGlojHJSjc+vGePUDffBP6OqvdElBUo0nLdsgyuPZF6fKgG755wxYt?=
 =?us-ascii?Q?HbTbfIH6Tm0Qt64aNjlU+eYGRTNte67fPFoszQbmUX9P/yyDaS60bIta2itU?=
 =?us-ascii?Q?IhCwSJo+G41tteKjvxEG1TAhAHLPxzb/w20pWyF0+69WQz6e/1o+1LSIuW++?=
 =?us-ascii?Q?EIRbPfumbFabNPWF2oqsNC4vCxHhKJ9Ur2ujWb1eacznOhUj5DtG/m4rXr52?=
 =?us-ascii?Q?C7WaqMIY4lm0cmKnUOKxsbN0VAm7mmZgQbDs25PKLHqcsJwpnWtYH6LiZ+X8?=
 =?us-ascii?Q?18lDCD8r4yRM4osRX+cL53eVGPCoYvPCXzGxfdmcjlKGR0IDoYNUUr88Onrs?=
 =?us-ascii?Q?dzH+DVCeAa9DTO0UJ38YWFHiwRY5iJjqRS8pSlqsiLOXLsNq52O+DhVhPYDC?=
 =?us-ascii?Q?C8OFCh4jmDEpmZIoXhfNkO2OONXV35VKgOCF8RaCnYEoDMkUmiJrS94ULdL+?=
 =?us-ascii?Q?3MzToMgEouXk8FRgcfi3K3czpZxpBAvYnZxHZ5SYjrkNcnIsp6SV+oYOKjkL?=
 =?us-ascii?Q?D12e4J3XmTCVqvzH1df8xkxrLf7EjqH57kXJ9HHCUDS8DmSeXjiRbccsGLNH?=
 =?us-ascii?Q?bbG7j1UPX7fQy62UM+p0+BqIuVkNlfnOOHELJniZYjp+5OLW41QzYCheiksl?=
 =?us-ascii?Q?eIIfelMNaWrUi6HrHku7n6v0nUR0ou5nt3txhdRrOY04BOL9s5fPeeRBAeBf?=
 =?us-ascii?Q?yRAnjMHRp1rrjyrlBDcKIwUfEYmUydGbjikc8cXX7nXh5PwLQGLiT91CzchO?=
 =?us-ascii?Q?2wu8g/GpHnKj5bwS8fE/jkAY9Jo1H4cH32VtjOe5T08KIIQKYRnQzBMghelQ?=
 =?us-ascii?Q?Mt83Ga8UuL43IvcL/VFxU5RMzlrXvjFDUB7LKHadyesBY+9Cpa6VuexzjyMH?=
 =?us-ascii?Q?V6lPsLICzxoSPMVRvtR4dxhIK5JBKn43isjFvy/3cJY5IvoMG1RFmLiiyi/S?=
 =?us-ascii?Q?XkKa0XHTniy08YBi4s0ixffT2AWNvPhkCFTROdonz6i+aV/+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21840bd6-6631-4fb2-9bc8-08deb808f31f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 13:49:31.2887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8Z1DK3KCClSBYVCSZYVKykFLiLYHjNqAw3u38hWyXJqqAZXAfzWib7vXAe9WMid
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9348
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

Should not use CONFIG_IMX_TMU to determine the print of CPU market
segment information. Only iMX8 platforms don't have segment fuse.
And there is no extended commercial part on iMX9 (91/93/94/95),
fix it to extended industrial.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/cpu/imx8_cpu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index c6bb938e398..0da5d88efb1 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -226,7 +226,7 @@ static int cpu_imx_get_desc(const struct udevice *dev, char *buf, int size)
 	ret = snprintf(buf, size, "NXP i.MX%s Rev%s %s at %u MHz",
 		       plat->type, plat->rev, plat->name, plat->freq_mhz);
 
-	if (IS_ENABLED(CONFIG_IMX_TMU)) {
+	if (!IS_ENABLED(CONFIG_IMX8)) { /* imx8 does not have segment fuse */
 		switch (get_cpu_temp_grade(&minc, &maxc)) {
 		case TEMP_AUTOMOTIVE:
 			grade = "Automotive temperature grade";
@@ -235,7 +235,10 @@ static int cpu_imx_get_desc(const struct udevice *dev, char *buf, int size)
 			grade = "Industrial temperature grade";
 			break;
 		case TEMP_EXTCOMMERCIAL:
-			grade = "Extended Consumer temperature grade";
+			if (IS_ENABLED(CONFIG_ARCH_IMX9))
+				grade = "Extended Industrial temperature grade";
+			else
+				grade = "Extended Consumer temperature grade";
 			break;
 		default:
 			grade = "Consumer temperature grade";
-- 
2.37.1

