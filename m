Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD840CAC58D
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0562C834EC;
	Thu, 11 Sep 2025 14:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="JDbh37nu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1BE78331F; Thu, 11 Sep 2025 11:59:29 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9CCD83314
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 11:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFiKvImP+YilQnyL+13rvNxNJSJEvvF4BKjJVagV/XkJuT4zxX59RrzXlMalY5I9wqlrFnklzrqR0mJOiQTFW3tYtTNVMqdzoqgb2Ol/5Ih8P3G7touRA9Zwak9P7e56HMU/3CIXmGCDGWi83vCAPLl45nNby2DzP/ZzqM30Hs5vTSTN41lL61SrMD/ptikHeUcBZUnydZQ6E/IhyNGZwe4X98+2hoO6mGO9vXzZhE6nqIA6hDxFso1Ul7eab72l0IrtYptFvJqMWIeumEBcpffQF2wh0+EApv/FzYOwU4mLIICxg4RbBeJnDrSHS65ClxT8F0VyMDklzYUo6eQV7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Q0gyltD8198s3+Li+tAtE+IQ0iFevvfagGgGPXEBxw=;
 b=BiChzT/5O3LScE50Fji57TIIihif/E80niteI8TJ2pGDeO5FXDpAeJbBsie/jFrIsXWbKrwAvknbqZm3E1dP/S2XE6IbjlaYncxPigcmFCrAM9r/Is4+KznLS2Z6cno+5iJ/vo0saTEk1j3R8IorhLNzt4A5XNbENGeK5h2zMGU5kKObXJVmY6ZuZ784+fvB9+RrdQYFgHi+ePgvl8ZberQde2ku6omzV9qtMDMSrliP+O472zhd/E4wRyijVnP5UAqeYOqZf9fRZissMTI8U7LbCINIoHSI9eGLKd8IHaZTqCw14S/ZKWamIUIDc3PSec/31J+cCxVF2NTtypCStA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Q0gyltD8198s3+Li+tAtE+IQ0iFevvfagGgGPXEBxw=;
 b=JDbh37nuuY8KqLE+yjRnTwaeR2KL62wO7Fw7WqhYDcsA7iTGHYYZlQfRLDCi1wF4sUj5CU3iUZDBAmoe1zyH5cKT4q4WYYw658NRIharAaeFYThpLADZQxf32k7iLAkr2llHtR6EtRJBBZ65hPN9ejT9nomHvuBaIZG1Lcowi0XjYt0GYEvu3FAMtlkmw8THw5juCqNJrz5l+YrGK4SdCsxMISJS3Obwwo+kq8xkQekKTlzZcJVHZ9ZwjPtEXIyMHbW9zGneY9k8dTYoBkKMpDte13W9PHstp8JJBORorhtfg2zdKJKvWRP3BCBTel/AknJdtJ7RIPAuEK9IKhxV5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DB8PR04MB7131.eurprd04.prod.outlook.com (2603:10a6:10:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.13; Thu, 11 Sep
 2025 09:59:26 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 09:59:26 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com, sumit.garg@linaro.org
Subject: [PATCH 7/8] arm: dts: imx95-evk: set alias for enetc PCI buses
Date: Thu, 11 Sep 2025 17:58:40 +0800
Message-Id: <20250911095841.3659022-8-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250911095841.3659022-1-ye.li@nxp.com>
References: <20250911095841.3659022-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DB8PR04MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 08276022-0813-4c93-83d4-08ddf119e3d9
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|52116014|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E9ln+7WApOmYy7TrYGUhuE5kp4yaYxC5P7uXSp5CPIKAiI5Mzz9INnKiaf5s?=
 =?us-ascii?Q?tKiLb9GuLc8NxZxgaoASHNpGHR7+yQZvAX6DddEJQgQ52jbMJRaxJCcB+0BW?=
 =?us-ascii?Q?w0yRlIavJdAcMGOYizwXpXM4AhwFlAuUNhHtV6KwcPoaiaDJNFgYA8V9lODV?=
 =?us-ascii?Q?Opw4+z1ot49xyrH0n5wB2W85lMgGdxJCuq+YdnJbe1WwgW4Mt2XeHxld8Iy/?=
 =?us-ascii?Q?PoGW7B2YF+oiXqUw2OGTc2TM9KleWOotgRzIhTu5xISMifLVMbBLtEdxbfLw?=
 =?us-ascii?Q?UksqU0ac0wZ58nN5/XRkZfax6+VkmpMNXP5ckE/ZgGyYZizqmoaBsV2GQekU?=
 =?us-ascii?Q?F7INNy8Cec868TwaXL5fM5svOsBpfloEdf9cse7fpJyFz3GcnZw3hTrM+NCx?=
 =?us-ascii?Q?RLx+1tHfX51trj66v0XXtapoP/NzfnjwpLpDmwOfl53t+mRfOiRPwdGS2olU?=
 =?us-ascii?Q?deHxJnDsaSsqoS6zNDgY+3FEvyueWNaWwRKl5dbbGPTksK5DFMCuzzBvLEJe?=
 =?us-ascii?Q?i4/lQspXbyzNCZ5p/IqS6QvSx5QBX8SdhJ2XCzncT5w0rXbvUW6/kAsF0PFO?=
 =?us-ascii?Q?8WoSo46b+V8RxVHklOMcvyvQgvpaIf4Cvx/e++KkRkpM8agpYq6oIvMX/Xqa?=
 =?us-ascii?Q?6to811YDcAKgZBoPh6Rgu8wuhE4GI5D/plZyIe1KPpcDjmLrJ5oMc1lgsocj?=
 =?us-ascii?Q?Pg9VJjeq8eFsWR6xKaNfaOKrMFSsrtGChwFwvMFwV8SrXRLe8qNWylfwqVqQ?=
 =?us-ascii?Q?pO9i/3wIkxgVCgtecIFl3V/c0OokKVbu7la+fvzcfLGVGR1uwip7Q5waTCXZ?=
 =?us-ascii?Q?ISbxX016KCdnVjrbPIN+LMOGnrXYJU13qb1P7KJYZDNIgBfN9wcU+uNkGYH0?=
 =?us-ascii?Q?8LGoGxqJ7G1eIj6BNS+INEu8BvsKye/IP/h+A9tSN/7zgxVJCnMEXdzKzWQF?=
 =?us-ascii?Q?quDLrQxfJRcUq98sHIqllzy8iOo9bAW0nEmhbWi+IHEipYT8TK/c1dUtwEBs?=
 =?us-ascii?Q?1jx6BUjyB03oF9vOeeU6prffa09wP2x0NGpVF1R0DRGPJS9Qj0fpDALvQISi?=
 =?us-ascii?Q?ryEvPn6OGP0wM8XPNnuxuVplBu7NQWsJzCkZrGZIVgP89R8tU87erIMxcd70?=
 =?us-ascii?Q?5w6ozcC+385/07N2njjJRtVfwIEQCSLGW6H8EtwY/VBm5uh3EGS0Xs/6UEgl?=
 =?us-ascii?Q?kKCxEIbqcA5Od2xCeC6PZALA8DeSBn/grzuPmiSFQvIr1m62E8ZikilF+3Gp?=
 =?us-ascii?Q?UclJVd9fEA2qUlW7kGIk10h1ZBHB8UtH+uryjSsdZW1XYle5o6iccilN69fv?=
 =?us-ascii?Q?Far1fEnHfUG8FTNuRIMsER+KyF/AnHAohQFDXC0xluMNiVv9bAq45ud9tz1B?=
 =?us-ascii?Q?D+eB03QcXExCCfXGe66AJ3T95rcenB3eCce6YU1YTv8E+38aYQlI0GjUmkcW?=
 =?us-ascii?Q?pyRNsyqHwzBkJqxJ/PG/8Bwb2MMFJz0YAKm1ksZ3458xe4chODu9chx08zkv?=
 =?us-ascii?Q?LUAWIr8uIrVNRVc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nn/yvivDOJ2TQYL0Z5oB98itDRBvtaQzOV6/vzS4Lpdwo+6o/Jx5qvzK7hht?=
 =?us-ascii?Q?7YKy88lRK3HuW7fDqjNPuCdYVZd4/IgL8DSNmHieERezZiHVBawe5KzGLGGp?=
 =?us-ascii?Q?kGmCZ/XkUaaXoblbm3sEIuraafikn1kbKttVQIFHP0DEqZy6eIEFqfdK1rMf?=
 =?us-ascii?Q?phV8KcGLEDoKMQDobejLeraBbVzJ01iRTf1uMktqXo0mdhwjBMn5IcRbnNZ2?=
 =?us-ascii?Q?NIAsihZ5ETA7gONK3oUgVWtenOWm3PQDxonyIctp68eGU/mHX7JV9xZc3GOX?=
 =?us-ascii?Q?iTSd/I2i2cZ7bt9rxLU/0dDmzvoTjU+RIvSrNbcbL5IlqunEesDeMsZbif5E?=
 =?us-ascii?Q?7BgPGO9jfOylBr2BQzcstAdmUuCr1c2RKU9MW5UoQBAzq9MO7diLfIcuHVcZ?=
 =?us-ascii?Q?HLBxzYV0nPoiN1LX9QBW5C/toqpjpdNketzR8BRQoztYGNn/p9rhSgSAFWiA?=
 =?us-ascii?Q?Lh2vkBsfTZ5fMtFiwPe2RNGQ0/OR9nZqU7zATDUCebdeGjPdapRnNAR42H/c?=
 =?us-ascii?Q?wHh7VU2np1gOK6beZUU/wblB5Pe8+DPrkBt318UtDO+LdDsLLrm25kR+8LW7?=
 =?us-ascii?Q?UVwUq1I16Dn5OPZBLB1aHH+nPwOr4Es8OeCTd57ZWYiq249unos85QluHtxn?=
 =?us-ascii?Q?DvVO1p2tzdCi+GzHortoiDj5zHFbq+/23kYj7/AX3Aw6yqZJmULDDCSUPxbb?=
 =?us-ascii?Q?j+y9t6Y38DFI2hIqvp/ODJRLLDwt6xm8GLc4ER3hv95B3r9pAlulxAnyPGy4?=
 =?us-ascii?Q?yKbHzRWkNQ4pC0h0FZLgtkHZcxM7R/+VQoNGeKISpP7rXzJPaiCFf/4oIYTH?=
 =?us-ascii?Q?2G2Vr43vcQnpFKLIl3RGM6UFh6PgyZgDh823kdtEhPtY7N9N18wPI7tBDKvj?=
 =?us-ascii?Q?Xhc42FTAKBtWbZT6iJtHFvjFTACPMfganucHFP2n0dqFzkLFJKlFTJ1QeRkv?=
 =?us-ascii?Q?O8kLMPp/2tjuE9j6HX81MEHTex7HD8nN+kUN4+1T+WBuvIS8N73wmLslZf7W?=
 =?us-ascii?Q?GcigjvEBkAAdmuSJCfZzRVwM4gWH7eUcutZcQBSPANdMqTSq2lKMCZ5i0+9S?=
 =?us-ascii?Q?fH6GydMjwzG/jRPvNoaif0/3qXOtYq0Y0uLcXEAWjd7S+c3wqditwiZiqvo8?=
 =?us-ascii?Q?sit5GG4LrQ+lExyy7IIuTEePZOUZ6+7vspVeVyaNfkVD2OuQMKwIpLbFnLRj?=
 =?us-ascii?Q?EJxG3sBcDUYNNsu88/cB+P4SdAUMiJWKDzmf96/7nEs3uqPvINAuGQ79hIPB?=
 =?us-ascii?Q?Xm70rmq4SD5PwVMCaRCdEA2ekf5SIvXGN2jYURkScxi6NoyTLdOjASLctglL?=
 =?us-ascii?Q?h9n5sy0pKGdvj7MPn0WHOxTWl/E/hQCWpNzcaUudeqibWP+7RiAHT7zgc8Sa?=
 =?us-ascii?Q?Oz2SCzhTOw8+KkX8WgLKrsl12oqDvlu1KzeT5nYj92IGoYN08jvp8QPvuUky?=
 =?us-ascii?Q?Mjs7cy4wa04ztVitYrNg9LI+VxNlNi18vTWmP1eYeG6tW2M/waDgDlTQGsxy?=
 =?us-ascii?Q?IO8DIMYo09hQ8rWZ5rEy6Baq6jriA5bFO6Rm5LPLMv9NWl+tmTM6o6yN+oJj?=
 =?us-ascii?Q?GxyeOh2Ymq1UsllSnkY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08276022-0813-4c93-83d4-08ddf119e3d9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 09:59:25.9361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8djfqGyEy0YBFG93OfsWIFxN3v86fzmZwrgRlFSQAQsHJu5aEOfDFWW+TcDCW3s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7131
X-Mailman-Approved-At: Thu, 11 Sep 2025 14:15:16 +0200
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

Use fixed seq 0 and 1 for enetc PCI buses, then the seq for PCI controllers
could start after them.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
index 2d1f02baa5f6..8b59831b7ca0 100644
--- a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
@@ -5,6 +5,13 @@
 
 #include "imx95-u-boot.dtsi"
 
+/ {
+	aliases {
+		pci0 = &netc_bus0;
+		pci1 = &netc_bus1;
+	};
+};
+
 &lpuart1 {
 	bootph-pre-ram;
 };
-- 
2.7.4

