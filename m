Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9844EDB7CA
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 07:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4361983936;
	Tue,  7 Apr 2026 09:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XTZyXXT/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 329A883F98; Tue,  7 Apr 2026 09:36:19 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D018352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 09:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPEzIQYiRxtmC2ZAIa4LLB+wdj+rbM4cJO1VRaeCVCFbLwGPe17TDoVZNbx+zqgkAXQlYcQtn3uW22VEs+DNRBNhMFlaCPqs+x4k5N8in0fcIQyV8ebVgr+4qss8hQfQ06Jhna6g3E2H1QRRBKFS3Jv9eCadABARgE9/T7MSiZmrwyFg0Iau407wdk9lcvPvq2sAq1Kk0GYAwXpaeTdyt9feN8vv4rF+9Y9CW8DWtrQ2u+z4RI+3AtfWG5zl4X/sWhW1Ea+orwQh+d0wZOcOU4n769yFt1mjIue8dOcIrZaKgduvW8gBOhPSKx3D5vkAPyXyqxCeWmTjNg9fo3nITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IGAcdCSipKmFmoZd3vIjigudp0gWT5P06WoEMDQve0=;
 b=ecLsZIm2oEzuJjaZ9zVpw7O2j+qgvDRLWNLEEExcElfPD5w4esr0fDWD7zxsPsEKvaxfwe4tA1hCp8ijuOHVw1+2uDPGmjcTTEK5KqJ55z0R03tu6EpKNFzLBZtVWYgv/mKjLULDVuZFcObiBverYjcBX/f6dLnuOQY1jRSicyPEisnNnBWvOHWR9xDJjGCmhSiDb0aBIRMRmvZiKeFfK/R0eg+Ya6bgq9S6KpMPK5vZs0Hwerqio5O2+aTMlxCUVAJwvLzK4tTxiO1ywSgLuAOgpHjzfNZO71tL7nGJB2N0IzRagad0edY7SPMNsc0Enc6shH4Krm62vGy8ldvyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IGAcdCSipKmFmoZd3vIjigudp0gWT5P06WoEMDQve0=;
 b=XTZyXXT/A16yheyYfsAbmT5xO/V27L9XONwTVoAvcBSEylTLy0D6ITooW/uekAXTKYlqHCMXXJUOi+bAlG3zkKKoXPcDYEkeH9pSsce5USfZ4hLANL0w6X5TKVbXUJaB65bswnTAXbUDjDiYgkkR4WmNnvZXDK51h2oWLHLcl1JT8cK94KsYXxsJoGkGQHxTQSxskkuR6OQlzJx9x1i6sxSIYBCCPIbsngf7KExUNTtfhwF6+5ulu9OyXOXcu9PYJsKWgtQiHu622VaJ1hRDz8pnunlgO8DugObt54lTA7yxfLAX26A4W4813OeSJYfDyGDrl+U0v8B5L8hy0UIe3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by DU4PR04MB10910.eurprd04.prod.outlook.com (2603:10a6:10:589::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 07:36:15 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 07:36:12 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: u-boot@lists.denx.de
Cc: simona.toaca@nxp.com, viorel.suman@nxp.com, ye.li@nxp.com,
 marex@nabladev.com
Subject: [PATCH] drivers: ddr: imx: Fix Kconfig for SAVED_DRAM_TIMING_BASE
Date: Tue,  7 Apr 2026 10:47:17 +0300
Message-ID: <20260407074717.2288035-1-simona.toaca@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::9) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|DU4PR04MB10910:EE_
X-MS-Office365-Filtering-Correlation-Id: e72fe910-0367-47d2-13c6-08de947857df
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|366016|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 0bYG4tbu79YL6LH0vM44pTGeT9yHYSF8NXmMrz73mjbBNEhlBK2yv5I2EbbjP/3VarxzmF0R6s0V1fhR3bGfPDxgSADlcwIL3jgoDh5BRJ3mXTz0zz8TS06y4jgits4fA97di/GEsnG5ery2MUguH638+1nr9/Rv+9uhE+KerzCi9JAo1Xk/53IU3hCxSEC+BYAnRfMsny4y7GjQEbKAaghHJRziZ9m2JCLIeUmYXiVb7JZ71FmLBk0rtLi/L5LpX15cbRKvosrKIxRDacoBk/B9OwHka8JaU9mCuuEMwtXmztXYavu+uFQgtRmE4K51zdsOrJy+Ban7V3mVJsDDtFxkmb2jcb2hE9z1x1b2mv15Qv93zeRY/OWwI5gy3O+uQiI6TCZqP7MyMqT81aDtDqBUbgK114TrRQCzK6ReLN/p6wXyz1VudUFF18vxog8ZteaGTzfaKsZfkA7H7y2W8NHpD/Tv/NYJph/vJa2fRU7echG1URFceqZVD+VZM+8vU9IYiFl5I4944VDWKYCBhDcXD7UfLK6k5k6UJ/xxF6vozWZEYIQ4xcIBatXcbZ6wVjBuoE0l2f04mmwFczq7fsx4U9fXN2q7N6gCLWaGyKmltJwPOA/F3Sa/DPDPIlwCFwjZvsv+0E3yjFOs5Vj4gTbCwB+fGOix5LhdgjUw6wK75LssIvJd8VZ9QEMQgyd1/9oF4SWCR2AZe+YD+Of5qCTxieY8BwJXpEkAgCLAJ+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KgyV9YoMkEiy/Pv3+eilpnFflTSI5Bm7BV7QN2DP9oUwDDkS9bOOZBzOzRmf?=
 =?us-ascii?Q?ptAcwgXAyNtSFL5FLJ2PLToWOsjinG+P6Tj+Nc/Lwx7UcDRcnzQnOzka/Mwp?=
 =?us-ascii?Q?LXAw8F/5iXfFsx86239XjRhcDeRA/zmXc7G6S2m0Kvzjr8dai2gAuhbnhj6G?=
 =?us-ascii?Q?OVMginCvqRc5/yI0W8m1CQDGNqkQXR9k0eRMZpSN9QjxeR+Z624Kecp+Qp+w?=
 =?us-ascii?Q?exNK9WmFtTM1NgtpI8P+6D6v1u16qDfUlkRaFjsKXEd2MW1+62kpEkg1FHZm?=
 =?us-ascii?Q?NiDEwXgmVvodZN9RepCVYa0TdMexuUNjTVJKdUR9ci0ycwnsFgYmofnK43Ht?=
 =?us-ascii?Q?iHybIRE8HHgeKQgn5RnT+6E8r0gwxO5W78JyFCxw6f5l5aws+bMnIgwJ6uiq?=
 =?us-ascii?Q?ASX1QzAwiyPXYOBathgMriWSvO3RrAYyQgB1SmHwl6CpR30HZpOnLks9fnae?=
 =?us-ascii?Q?j/8kBdq7cOSZQUvDxNDr3HZtnUXU5JSCEOqJfHf/OvN1tMHY+IFADCW4BeCq?=
 =?us-ascii?Q?e0A2v2ZyhTGwjE66Klmq+7ubrRmYQjJA7OyMCgiPR1FlsXA+3zBV1s7mmX9b?=
 =?us-ascii?Q?jPaThoegOtvd8Z/kQ7XN5aszB444bRdwkzTcr9CAhMCxjyUlAcdv+83hfLN1?=
 =?us-ascii?Q?oWJGJFw6K058m/HgrU9BUgLV80dtfhe1FXPYzXmDb4ky1Cw+iZ5/4WO0A1Nq?=
 =?us-ascii?Q?MTSug3143DluQPxarMmpomBgBYMqSxCc9oFgI7BibkSSOmIAkGwonLK6mPpS?=
 =?us-ascii?Q?A6mdKgDRDJL9ho7CvKNwkOVOfZUcBmanOSocXj+hXlNQAumpkRaHGJEeplUD?=
 =?us-ascii?Q?eK7x8/gyFj7ACoupO+go3EaqRd73VaZJXxtgBEI9g2BUlCxv72UbieLwl7HS?=
 =?us-ascii?Q?jgGDtR1+gm9MDWHAexRMTSl43kH1FGP27bg8S5N+96EYsZw0jCzT2UKVO0GO?=
 =?us-ascii?Q?cdrFZZD4zxrjh0DVHkcSOmaNzVzMVR5Nr3yClMyzUFrBeMFse+c8sJdJXU1q?=
 =?us-ascii?Q?f9fPF48o3MbBbEepknItOZfQuzOLZ4CjpyWb81rU5e/D/f5GYUxst8B10KS6?=
 =?us-ascii?Q?eKXqQscWH3dTdrDYs+v9LKXcIte6bmCp5oANDSDTzJq3ce+2EVbito5u9Rcf?=
 =?us-ascii?Q?JhMOAaI7ozUtTtd9A3p6doA97KYvTBwYfPuZvyM2nvKjukET7b81AlwJ1qQP?=
 =?us-ascii?Q?Y2Dw+EWO6exoLgFfuIUk5Y9sKMGNs0GD3kKOAhS1rvvjZE3zXkV4rcod0YiY?=
 =?us-ascii?Q?uy8cymAOOo4+xwFTTzyEdtX+lwd5qVGhnSG+PhROf6hI9Ez3cvS8dcWrkKrH?=
 =?us-ascii?Q?fkMtoCW7u4n2/Ex7xd85tKsEug3nmeMk8MGOhZC8HR1nfnvkbIdebp0EswJ6?=
 =?us-ascii?Q?yzGMUm5WT/XrJ5OL2R9guvwxw8Vu839BAY6zg/mrMl2L4ZWggbBV/N7wXdQ8?=
 =?us-ascii?Q?foFVxw3Asktm2sW3J93Z0TZxKIb5mC1zky6SjM6mbkvuIogh4cJVX0jW8JNB?=
 =?us-ascii?Q?pKaS2CgjvOxNwnYgR+Hk9vo/+6qZ/DWinWjGuEoI1Wyy3YNzM8sF1Xm9etMs?=
 =?us-ascii?Q?nePx/NHnt1CyMnNTjOWg8QeE5075wssuxenwO+EaaZJv6Y7oyeXZX2s83tWo?=
 =?us-ascii?Q?Tdaabl/tfa0k93YmXvR4oBSsRDxtsnhNkalnfZR2bz1dZPmzRWz54CMaozx+?=
 =?us-ascii?Q?XZp9jBNcU1msFJghGfJqO5igwHXZQeSJgFp/Zq2tTsVHjiOxf9dXktCT804z?=
 =?us-ascii?Q?12qa/ASJoQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72fe910-0367-47d2-13c6-08de947857df
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 07:36:12.7824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiVq5HjrFC9kD/bzj1iy9lqGHUAA87tAGm8Nda9PNplboc6RVL3TbC7iTNOMu0OLp9ngsnvQwIsko/Zleq4RhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10910
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

From: Simona Toaca <simona.toaca@nxp.com>

The 'default' directive should be before 'help'.

Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 drivers/ddr/imx/imx9/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ddr/imx/imx9/Kconfig b/drivers/ddr/imx/imx9/Kconfig
index 0a45340ffb6..b953bca4f06 100644
--- a/drivers/ddr/imx/imx9/Kconfig
+++ b/drivers/ddr/imx/imx9/Kconfig
@@ -24,9 +24,9 @@ config IMX9_DRAM_INLINE_ECC
 
 config SAVED_DRAM_TIMING_BASE
 	hex "Define the base address for saved dram timing"
+	default 0x2051C000
 	help
 	  after DRAM is trained, need to save the dram related timming
 	  info into memory for low power use.
-	default 0x2051C000
 
 endmenu
-- 
2.43.0

