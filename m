Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DCACFB421
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 00:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30DE088A47;
	Sun,  6 Oct 2024 02:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YVNSHIBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7C0888DD; Sun,  6 Oct 2024 02:01:53 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E9B588A47
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 02:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zb+sMI7pWDbVoXRJa+NN6NXfddaT6W/s45V9l8rBSBrcKbCCPuPyziip8dzrzuUFdyvOwZVnfGb4hn1fsU9aGmETdg1sWFdGVVSkptg3R7ucC40pRqaoF0Lfb8jESiRZ/5TXIfRw42Y9oh92Affs+Fg5Y1KdrJ0KhD3tr1QOLFog1eYsBD99x+eL7TV79/1sapkbbTP6/XIvzStykhQi7tFgK97aBYnZHTq7nYXU54b+2Gsx3CDlOVB1Z3j0HYGN18xolC6/5G0zIeUQ/sS5z2QUe1aVfJrmqQSCnw8HBd3xq7WWZLMXNPt6DVJ7tR4J9IrGaIutqHXgBbr/R1Mmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyzKRCuLJ6dMZ9zXQKmgLQV3oclHLFAIkZdmu0LPiVQ=;
 b=bDOcMvfBu7PfwBbQrDlSMlDxNe1wa4tAKcHNcuzrfUJeCbpCNfz3OvG+4dtQasmL5u1WhP0Gk1DO1Epuzbr+0RRxgUB+YrcM9oYSu58E64y50PR2nB/djf5XczkNH12VC73Ww1BvdlM4LmquYl/yricnTR1SlgjwcxAWmxZtrz9XAUhBN4VcAs9cRx0maG+Df+mmPVflSFCOPcKO4vAeIqWFtIh2m2/4YxLPcPz6+JubduJFcHpzUMYF9QczeK6ESdlPehQnAfvlzhE+dceFrsgsIvYQEH8PbmEmL5/LMIZwzga1VkzKZ8s/74S+E/PrG7Un65WIM8I9+2Win+QHEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyzKRCuLJ6dMZ9zXQKmgLQV3oclHLFAIkZdmu0LPiVQ=;
 b=YVNSHIBnItw7WKnCNt9d6SKjNwhClC1fo2IZFMrQs9P4rh7bKK9pleSourfyjmrUT96tSaN6YDTZGyd1350oN6dgoe7omHb9VyrkwU0rQ1t0SzXPFQ7Xvp/FVZTJG4MVlZbrN8HdHjKmoKA7dSBtiuWhe0fnvvkxYMCoUVKNRMXhFyfeBewGaSUWgY737ww1r55rrL1IW6/A0GxZFQYRk6BzvUE5jxD2KMDWaHnOhZl1e20oNb+zA+TPxpdLEmBEhibvq01O1tz1e3nYw2gfc7EIJzF5JIM0QQZDoRFct8vAyLZZxIW7dJtzOZGzrR/ZUIJBNFNuwVyisNHjTLQr1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Sun, 6 Oct
 2024 00:01:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 00:01:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] imx8: Correct the SCU API return value check
Date: Sun,  6 Oct 2024 09:05:22 +0800
Message-Id: <20241006010522.20841-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:4:7c::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: c69faa9e-1956-4bc2-3000-08dce59a0daa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lsKQZNnaiflv18RrKlI8v4EhEevF0fQxox2s0vTY5HN8Ln2wdCm2DwzazKKZ?=
 =?us-ascii?Q?7UBM2WfC2a0jmaCWj+3JL8bUXPWd1WJkSe7WLKnM0pXGOGLwBq3MvXb+6O1j?=
 =?us-ascii?Q?DlU43XyW8yjMWgeROwSOkNQtgrX7ehIRus3T9bRZlqzOyvxLqGJqn8IA/wxv?=
 =?us-ascii?Q?bAO4BsnbZN7C6iUa8cjL5zivosj+Gz485nw4brVMaE4zLQ84gBWs1qLhk/5G?=
 =?us-ascii?Q?722LcZcmLsyqf3zWqdovXAJVtrKMAGwe1hxOg5LnlFYL94pCODBaHjmxCtWq?=
 =?us-ascii?Q?tSyrZRn/FzvvuEkoABH5wNQfHeW4eR3wPT3hWMxPPl2RcMsj72RprhpmThC4?=
 =?us-ascii?Q?Ne+cfchXhJEjxTQKDqpKod58mwV3WlUSaKsAVdUdvsNVAml2Z8p0OXEKH5zC?=
 =?us-ascii?Q?yQ+Fkm5sOvfBF8915lRrCIoiH2wBp3wIB25ZwiHDj/cJohZk0YGXF+XK54NB?=
 =?us-ascii?Q?O8kAuX6A8ItWkwTPtlb42a6zkzqJfAILcO6OtkaZpAM2T+X/winJtNasLC5u?=
 =?us-ascii?Q?IjeEZe8HEHut7rCcH+vL6rPahz0ohIbWZo09IhL+teKurK+J7aXkh+nWKiGL?=
 =?us-ascii?Q?/N/Sa/5VSZ4+901Hkt46G6r9fUuLd+Wer1rc9Ai4pdNBzE38E+3TvKUa8nYI?=
 =?us-ascii?Q?egi5kkb3KoMmgXcpk82pPPO1MrP9uOvIin+JmzjWqd8maGFkribMsz2preXe?=
 =?us-ascii?Q?QHfn6chv3w8J0dpbbt63B1IBEadLIjh8j3p06NcN9AOGtQd9K2JMoqpw6zoA?=
 =?us-ascii?Q?rXKMvoaR/16fX5CoHm9vDaeT1fBaWoEG3ehO8ucrzmasWCasy4HYknROt2j0?=
 =?us-ascii?Q?HqhYm6HekTiImG9Ui2Y6AqmsXVujy/fGoOUjsI3rgQziyb1GPREITzZ/Wzg6?=
 =?us-ascii?Q?5RtlO4iAS0WXZsC2iFA68kIlQlnUAtb8EisPVTaXeBaogqS2/WtlZg8vJ3LO?=
 =?us-ascii?Q?u45DFo6nLpbjjIbXFIG7ZtfQ52fBn9/CPKPJtrzmy0ZIP+OlK++JNyAJFNLW?=
 =?us-ascii?Q?K7prAzkV+QdUlYrssfv7ZYnBVLcp4kWDlnGSjXIDUpdwH4fuBs2c9liWWgTY?=
 =?us-ascii?Q?KxseGzpj16SZyA+ngW3SeKuLcZVeZAvQJiGFKxJx3BQvMGTySrUCfSzIi9zk?=
 =?us-ascii?Q?1W3RJKUB5S7Tjw3oKVNvHVQdW4zDiQ3poffrt3iCKHac4GZfLMc9Xmhe1UZU?=
 =?us-ascii?Q?EnRc+TsQ++R0ildyC5z99JuKQha8oF59hIelacaOIcGqEEHtWjXaRqXWXl8l?=
 =?us-ascii?Q?QTgIHvKN9806g8mypeXkGUWu33maE72ZIVhik7IfUhcqHkDl4QAQYyg4WhY8?=
 =?us-ascii?Q?PtnuoDdRnPfN+zEg+r8vh/keJYZzMHIV8pQAQcQMiTdv/Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1NF0LjxER+Hm09aAH2dTJRc+fMUGCMhUjmYpGCLmli+CBpL7hNlPOfq+h+TM?=
 =?us-ascii?Q?uX0XcPBU/vK8E1wH4qv0LgmJlv86er+kK+z3Qnn/dXo4IfF+iPqy2BVMnv6+?=
 =?us-ascii?Q?8FaFNJ1r/B9VOHpLWjVnMEKj4VT0DuEm3NjLlsInLY2KoqrWQcByiWa3+wbL?=
 =?us-ascii?Q?+wJ4nT6Inqi5QEMg3VMhQklWMfSg2x+2KNCkNRye0vuCPZbBDTflfQ6gwvgG?=
 =?us-ascii?Q?QCuuc9IYBk6T1Vj51VWjSjpA3eZP19PMQ72imLR49WEfyGGgdFX8UPgrRd6F?=
 =?us-ascii?Q?rm8W+hRKWlBuc2MQLPgo4W+rN9azlcQ3fGb/z10sa3zeLCiSB0Kqb/+GYnWB?=
 =?us-ascii?Q?N9VC6PZTmxHzdwflRtP1L8fyFHH+htJbZvvJsNMPRWKC1imPhnwuXiDh4Iif?=
 =?us-ascii?Q?OB0eEQ4dJamA6Z3o0ww/8bKZbnazqE3RSH/k/k4hghaTYUrmSdxo+uFflur8?=
 =?us-ascii?Q?H0RH0R+h0dfvVaUqH9ZIOJxAd9bzz3JfiReRIqJY3znzXXnIljz7js5XmGAj?=
 =?us-ascii?Q?+Zd/ITybcXDw2XMQjUpOKVjVl22AP/XBZbrEOsY/pkAsa/WtWQQ7vrOe+X0+?=
 =?us-ascii?Q?/HQMbXhGKu9jXmSNB2y3yft4yxEYYUHzkq/rh0W9Ib6N6t/RdQrz2hrbXM/y?=
 =?us-ascii?Q?hUDhQjhcrTprDXgP6aQ/QulvNYdrcX35Npwkrt9ybzWttJB+puxkEKrFCRN8?=
 =?us-ascii?Q?Wte8hV326zSnQXq9bqznQblWXxTH1xdP0nXDQqpYRPvOXXMckKFbHYN2N5Z9?=
 =?us-ascii?Q?s6BZlmKRc9v5rmrdZPxciVINiGRvmhdEwddD7ef8oSUnCFkwECzEzCu0o8Iw?=
 =?us-ascii?Q?f1uy6I3qEKJH6JcNvXr7rtrW+LqK0QpQPPGTYiQjMAo7ftzuggHoMEK2/gjK?=
 =?us-ascii?Q?xwc+hqtGL+BnOHtg6zKDJbSrjyJnfOEKmsWcG8JVOd8Ykt6kiHZU/8bCpvW/?=
 =?us-ascii?Q?nYKsxO/3KO8GlOTZJAkxyfcQAoaMo04X5lxlZ8WHhOm89HXvUAUqSAHaBAnr?=
 =?us-ascii?Q?PVoYFqa7d/fiU/Y6XYE4hyroAV8XZdt3VO/97avcx2zLJuWd6KU1IpSYV0o5?=
 =?us-ascii?Q?UHxL2C0o7cDYiAVo1JclIQlYb8fdpPJxLy85dadkioDxlWeIoQ+mKmK0CpNK?=
 =?us-ascii?Q?K+99g/x2Lvgo7Eb4Pd2MwEjQlB4cWzMpvhtUOjfbUxASHNZqakQlBAnVClrC?=
 =?us-ascii?Q?qEhGNMFZucPKhfFF0LHmYiKJikply9t1xGTMdelT890HfmArOc2S5mzW1xfr?=
 =?us-ascii?Q?7QvsoFW3UbldfAHaFnMeZKaQheO8U+6RBOJKFOEuMhDwvteRuKs3F7bkSo49?=
 =?us-ascii?Q?v9WZnecUbbLN3i4C1tj2jUF/s0XzbbFyPa3R+1uVSSQwY3l4203BwyyziK+1?=
 =?us-ascii?Q?Dn+Fnei/WqS2t18bzldodC8xQ1OXDoqCkegyFhMFG6ySOonj4bYVISrZnh93?=
 =?us-ascii?Q?b9cVWgQGCbYYzXOkWu16fBgwON7hG/cKDNqqzFBmz7W3s+wJnHbXmYYX7ZnF?=
 =?us-ascii?Q?ImsAOKfyaP+nSsO2kpgRUd1yToJ9XgP5JeiWEElzb2JXDRfANtWZTE1I4mOQ?=
 =?us-ascii?Q?rV2ahp1DxhETUCyrnG1f8gbSpSl85pD0ycLnqriO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69faa9e-1956-4bc2-3000-08dce59a0daa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 00:01:39.9769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zauFHQf28RW/Bos/GwCZeX26Mvd/7xkZtzUy34d3LPbgfDGqnKdBbOl9hLxeg3U8e5wm9Ky1sRkNncXJxgRugg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9213
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

The SCU API alrdeay has been converted to return Linux error code,
using SCU error code is not correct here, although SC_ERR_NONE is value
as 0.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8/ahab.c |  8 ++++----
 arch/arm/mach-imx/imx8/cpu.c  | 34 +++++++++++++++++++++-------------
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-imx/imx8/ahab.c b/arch/arm/mach-imx/imx8/ahab.c
index ed44df394b1..324e010bb2c 100644
--- a/arch/arm/mach-imx/imx8/ahab.c
+++ b/arch/arm/mach-imx/imx8/ahab.c
@@ -345,9 +345,9 @@ int ahab_close(void)
 	u16 lc;
 
 	err = sc_seco_chip_info(-1, &lc, NULL, NULL, NULL);
-	if (err != SC_ERR_NONE) {
+	if (err) {
 		printf("Error in get lifecycle\n");
-		return -EIO;
+		return err;
 	}
 
 	if (lc != 0x20) {
@@ -357,9 +357,9 @@ int ahab_close(void)
 	}
 
 	err = sc_seco_forward_lifecycle(-1, 16);
-	if (err != SC_ERR_NONE) {
+	if (err) {
 		printf("Error in forward lifecycle to OEM closed\n");
-		return -EIO;
+		return err;
 	}
 
 	return 0;
diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-imx/imx8/cpu.c
index 834aca82bcf..317db31eeda 100644
--- a/arch/arm/mach-imx/imx8/cpu.c
+++ b/arch/arm/mach-imx/imx8/cpu.c
@@ -48,7 +48,7 @@ static char *get_reset_cause(void)
 {
 	sc_pm_reset_reason_t reason;
 
-	if (sc_pm_reset_reason(-1, &reason) != SC_ERR_NONE)
+	if (sc_pm_reset_reason(-1, &reason))
 		return "Unknown reset";
 
 	switch (reason) {
@@ -160,6 +160,7 @@ int arch_auxiliary_core_up(u32 core_id, ulong boot_private_data)
 	sc_faddr_t tcml_addr;
 	u32 tcml_size = SZ_128K;
 	ulong addr;
+	int ret;
 
 	switch (core_id) {
 	case 0:
@@ -187,10 +188,12 @@ int arch_auxiliary_core_up(u32 core_id, ulong boot_private_data)
 
 	printf("Power on M4 and MU\n");
 
-	if (sc_pm_set_resource_power_mode(-1, core_rsrc, SC_PM_PW_MODE_ON) != SC_ERR_NONE)
-		return -EIO;
+	ret = sc_pm_set_resource_power_mode(-1, core_rsrc, SC_PM_PW_MODE_ON);
+	if (ret)
+		return ret;
 
-	if (sc_pm_set_resource_power_mode(-1, mu_rsrc, SC_PM_PW_MODE_ON) != SC_ERR_NONE)
+	ret = sc_pm_set_resource_power_mode(-1, mu_rsrc, SC_PM_PW_MODE_ON);
+	if (ret)
 		return -EIO;
 
 	printf("Copy M4 image from 0x%lx to TCML 0x%lx\n", addr, (ulong)tcml_addr);
@@ -199,7 +202,8 @@ int arch_auxiliary_core_up(u32 core_id, ulong boot_private_data)
 		memcpy((void *)tcml_addr, (void *)addr, tcml_size);
 
 	printf("Start M4 %u\n", core_id);
-	if (sc_pm_cpu_start(-1, core_rsrc, true, tcml_addr) != SC_ERR_NONE)
+	ret = sc_pm_cpu_start(-1, core_rsrc, true, tcml_addr);
+	if (ret)
 		return -EIO;
 
 	printf("bootaux complete\n");
@@ -242,20 +246,23 @@ int arch_auxiliary_core_up(u32 core_id, ulong boot_private_data)
 
 	printf("Power on aux core %d\n", core_id);
 
-	if (sc_pm_set_resource_power_mode(-1, core_rsrc, SC_PM_PW_MODE_ON) != SC_ERR_NONE)
-		return -EIO;
+	ret = sc_pm_set_resource_power_mode(-1, core_rsrc, SC_PM_PW_MODE_ON);
+	if (ret)
+		return ret;
 
 	if (mu_rsrc != SC_R_NONE) {
-		if (sc_pm_set_resource_power_mode(-1, mu_rsrc, SC_PM_PW_MODE_ON) != SC_ERR_NONE)
+		ret = sc_pm_set_resource_power_mode(-1, mu_rsrc, SC_PM_PW_MODE_ON);
+		if (ret)
 			return -EIO;
 	}
 
 	if (core_id == 1) {
 		struct power_domain pd;
 
-		if (sc_pm_clock_enable(-1, core_rsrc, SC_PM_CLK_PER, true, false) != SC_ERR_NONE) {
+		ret = sc_pm_clock_enable(-1, core_rsrc, SC_PM_CLK_PER, true, false)
+		if (ret) {
 			printf("Error enable clock\n");
-			return -EIO;
+			return ret;
 		}
 
 		if (!imx8_power_domain_lookup_name("audio_sai0", &pd)) {
@@ -286,8 +293,9 @@ int arch_auxiliary_core_up(u32 core_id, ulong boot_private_data)
 
 	printf("Start %s\n", core_id == 0 ? "M4" : "HIFI");
 
-	if (sc_pm_cpu_start(-1, core_rsrc, true, aux_core_ram) != SC_ERR_NONE)
-		return -EIO;
+	ret = sc_pm_cpu_start(-1, core_rsrc, true, aux_core_ram);
+	if (ret)
+		return ret;
 
 	printf("bootaux complete\n");
 	return 0;
@@ -313,7 +321,7 @@ int arch_auxiliary_core_check_up(u32 core_id)
 		return 0;
 	}
 
-	if (sc_pm_get_resource_power_mode(-1, core_rsrc, &power_mode) != SC_ERR_NONE)
+	if (sc_pm_get_resource_power_mode(-1, core_rsrc, &power_mode))
 		return 0;
 
 	if (power_mode != SC_PM_PW_MODE_OFF)
-- 
2.35.3

