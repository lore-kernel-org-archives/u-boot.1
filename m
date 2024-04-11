Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DE6CD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 03:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6AD988120;
	Thu, 11 Apr 2024 05:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="C2lFQ8+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A99B688120; Thu, 11 Apr 2024 05:23:08 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDB0387F70
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwM8lim247IuNTBVmlI1lrzHTKt7wux+hnRsDKo9SMksDmlt4/1u79i9a71Og7wESAEhNZctHAIjT3UIkyzUaBFbMwMKXMxkpLDzzcNuEcG40duZfm7ApwUBZbmC07DoO3i+HxQ9oJAGxrWVL2jau90wcH1eSvasx9m3kFlw71qz3x60dWYd1kpUL7mDbfkgNLJfBJ4AdqAejtd/pVSjkvA9BkOHWpcPYWE7wp/35lp+YjzuOiwyzSBJpcL/7pB8pe9q/jenqcbBH7L0WPkFMw0IoXY0Jdfa9xc/ZRpKkngq7kmZYxZxvA7CzO54BEl675xI3FpG89d6ZTe27eT5VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyxwE4PFsjfN2Fu5YySoDH0PGxFU76thRYrBQmq3lR0=;
 b=gb63w5ei2eQC4xrzUpxACFgRLG4seNrK66IzzXczQRBxr4iGJjiGAkFhTgpOYQltM/BMdmrZ+rIeG5eclbW8+xu8EDANYJz8KBMW1Pn42NDecrvMRxy+Bjr3iwFaPt0/Kkf2n4SwsGvbVT1rXg8dB9zdoAdyihN409y/7C/KsUlYeFrjAxoYjVuLNOI32u+wN5DG5VOCqe/cRKfTOFHttn8uEgW45OXkG5pgD3PEBbFt+2x1phyA/0uoStMwq5k9XFh+UPeoZ4xQJGGWZKS+1SdWRdwzuMNUumEcTW2XK5i60k2RPafpl+kXNi/UbbUaw5YoNQEg1SvyLhwGgmcong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyxwE4PFsjfN2Fu5YySoDH0PGxFU76thRYrBQmq3lR0=;
 b=C2lFQ8+PQnBSoYl2wjy/yncuEvYGU6WiHlUDVFcgkOuEtmzXRuOhnadAJl4db2v3doEcUgbUE3doqdpfNmVwnUbhtVTpEDZUr8pGZpFe1j48vgeRUC57KqVV/6rp7zV5by93gwTsAFF/r+gi2JHCeJyAtfgdyCVQNEm5PkG7hzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7951.eurprd04.prod.outlook.com (2603:10a6:102:ca::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 11 Apr
 2024 03:23:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 11 Apr 2024
 03:23:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 11 Apr 2024 12:23:00 +0800
Subject: [PATCH v5 2/5] serial: lpuart: use ipg clk for i.MX7ULP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-imx93-of-v2-v5-2-9eb3c64ff160@nxp.com>
References: <20240411-imx93-of-v2-v5-0-9eb3c64ff160@nxp.com>
In-Reply-To: <20240411-imx93-of-v2-v5-0-9eb3c64ff160@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 81dc6020-6e20-4f4d-de32-08dc59d6b3b6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RdTAuxU8WwPdKYAdVEIcPhi7lthbCksHYjom4ohwNvJUmWCtE3pRRi2xz5FGxVORMPHAZmY1WBZIGaOrBrHWE/OUf4BekxqdiFI2Zi/KLm5mVZPwpHkftUWdOS5lxQWP3dv5dRrRcQAXZtpcL4/QvBbUHQ8FRpr9ypc2L/1YP2dKIL94oalwXMa6KPHD+b6Pe3DSvq5rFGh9swtPT00vUKn3zm2FT7xwFWCrASClHm8EhO6oL0TxaJ09lhh9svS3vP9TnR0IA7T4FxfKS7R7odJjyWaSVcRW+7uBKB9/X2Y37zWmftn7oxojth26VrODN3HnlkudlSJTPmJFTIVaQSPDnQ7XUFXVNAsc+wGeET3A3J/0+GOOXhO+Q7JrTYOaJ4eUAQOFrT/IaUwRdW7JRKW4WNOT6F3CYh/GTdA2teW/ZhNLwHqImQpxV8ZZO3dvJZqgQVVg7khehnX2QfsUGZaQ0QUsUDRWS9Kh8mCctianvTawKIuVA5aFF7rDphnZYIwhZyNS4+P4vlaCQFlwDN/S8CeJPY/oqol8pvGfqW3BTAfWSy5Wy3xAuVroc73YEnnmPHxfajhBlyETiDw3BuVMqP7wNBmoyigmKwLI+etfsq1a0EnfhqADw2/zR/HbTqOezT/wLhZYFKWOdox1QBxHCJ/eIOoPVObsGb3TIS96foy8C64Vv2wwAiTSAsK7+IO4WTpylztiyOW3onqcgVSEJyoRZglz6XrnhzU7nWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(366007)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGNHR0s4ZlhJWnA2dWduSG9lc25lZnlaZUFVekFCMVdmV2NGRWsrUmR3aXJM?=
 =?utf-8?B?b2ZPQUlKYzErOWJvNTVQV3lGY1RoWFNrRExSQVhDUjNyZzQwcXUraFo3emp6?=
 =?utf-8?B?RlhNZDY5UlpxL21uVUl0SmpHek8wR3pNRitFbWcvelR2NXZuZXZQOWR1cC9s?=
 =?utf-8?B?akpWSllMNUM4UkQ5dmhBY2lXVzVHbDBhWU52U2g4TXBKVUtJaUpmaG1WTkV6?=
 =?utf-8?B?RnBsME03ZlpDL1NhZFQ2WHRSVDFsQkZ4MGlsTXp4dEJtYUw1UUFIajkwNTVI?=
 =?utf-8?B?VXgwU2krWmNqTkJONEFaZ2pObmVBOEJuSmwxL3ZYbitZZitscHB4ZkE5RXRC?=
 =?utf-8?B?bkNqUU8ydkdTTWJJUDJzU1VERlNGOUF5MGN3MkszYTRNQXF4TTgyVitpQk4r?=
 =?utf-8?B?Sk14NUY0NXdQOEx1cDlQRm9BdnFXTERyVStDeFA4TFl4UWNNMWs1OXNpVmlo?=
 =?utf-8?B?c0c5RG1PdEJBay9XZVBEcXNON1l2NzBLWHBmU0dPdnNxY3NZbDFOek04OExq?=
 =?utf-8?B?dWFEaFRhdnZVU1h2Um56WU12dDh3SmM4Sk5SWDAwa0VKWnFqZkt5d2pBRHJu?=
 =?utf-8?B?Wm41OEJXTVJYeFVxN1FIcGtuMENsOFhEZHBFQzFsUWcvOEp0QWE3Zjl5ZzN4?=
 =?utf-8?B?QUF6cmlzODF1WGZKaWlBck84c2dvTU1udW5lQnl1djA1UVNncVdHYUhVcXVY?=
 =?utf-8?B?VmJxU3hsVXBZT1BaeFFQSythVVJ4MjF4OVdGV2JIZXI1NlFoVk9QdUNOTFAv?=
 =?utf-8?B?TWhXN1lUNytNdCthcitMcXhGSXdSajdtU3d1NkZocExuSGxwNzBMaGtZZzVy?=
 =?utf-8?B?ZHRBbmRvZE5YcW5qc1ovdWs3TVQ1NlgreC95blJ2M1lKMnYrSXp4MDFTdnhQ?=
 =?utf-8?B?NSsvbDl1dHQySUM5RXhLeEI3SWovdmNkZmZVSEhTODZPbVBaZUlpRm95TWFF?=
 =?utf-8?B?Qzl6RjUyTGpEUzZteWVzTVQxRG5DVlJvZkhUMHFWR3BobWJVUGFnOVJjUjNT?=
 =?utf-8?B?Z1cyWmU0Wm03TGdHT2gvcEd6U282bFI4TTRaQ3BZb2JhRWxwZ3ozZFkzYXo4?=
 =?utf-8?B?Zjh2anFmSVNxRUpvOTFtS0ZFWEI3OEJVeXpqNDZxVWcrTmloRjFrYmMwY1VE?=
 =?utf-8?B?UE9xRXpzMzlxS1VMSkxWOFhFd0VSSE9Fd2g0eFRHSnh3RXhWZTM2b2F1WGg3?=
 =?utf-8?B?TWlxMG5WcGpHeFNiRTE0M1ZqWmdXYWhsNXZ3cjFESFA4cXVraU8xWEQ1RGpx?=
 =?utf-8?B?NTM2TFR6anc4SnluVG1lWngyUFZTeWdOcXhoQ1dqemx1Tkg4aGFYczBrR2FS?=
 =?utf-8?B?OUtnNDhkSmFSUFZCc1YyWDNQM0hWUjFHRkpCQ3FTQndjR1oxd09rWElvOTNV?=
 =?utf-8?B?U3NyOVZmNS93UTcrY3BMYmU2akdQb3YvaDBSV0ZrVUsvcTBnaXBxYXhCMnky?=
 =?utf-8?B?TmhSbmxxbVNEMXNUdXJWM2JxMHMycmNQQTYya29GdHBGUExzUGdVNy8rVjQ3?=
 =?utf-8?B?K21XWUh4cmNRZ0RxWk5zMHYweS9BS1ZoZXN5d3cxTXNJSllOTmdvZE4vajI1?=
 =?utf-8?B?M2ViN1JmWUJRcVFuS1ZOQUdocFV4aE4rVEtDRkxxRmFUbFRpWGF5WGlrbkVs?=
 =?utf-8?B?N2hyK1pESDRpRUJsb2duYjREUlVxdkFRaTY5dTA5enhidDJlRzI5NWRnOHJE?=
 =?utf-8?B?ZUwveWxHbEdjeDFCKzl5NWJRUnV3SndzRlNiRC9ZSitsVlZEVW1rNTNGeDBW?=
 =?utf-8?B?bUlQa0x0akVSSW45NVE4SzNRVFUrSnVBbHpJbG9jb1VOdTA5bWhNdkdIS1k1?=
 =?utf-8?B?N3RFYU92MElHNEo2SVZDa1RLNCtKR3dLcSsxdEx3NGJRREdNYzJpVVFYMWdi?=
 =?utf-8?B?bVEvNEZhOHpialhPd043V29iZWtmdWk5VEMxUGtiUDFHckdac0pwd2RDRjlo?=
 =?utf-8?B?ZkVlVGFXQXRuSkIxTTVOOFg1UTF5eERiL25tQ0hjTGhTY0ZKemNHVWF5SFU3?=
 =?utf-8?B?MGh6V1d6aFFjaDZzcEFBMHhOK1pPVGx1YXNaSEVEZ2M5SGhJc0tVL1VRR1pv?=
 =?utf-8?B?VEtpTEkxNzlneklURlM2S0dPd1FMMzZBTURveXpTMEdLM3RhN3FWdVFiWmRD?=
 =?utf-8?Q?5QqfYI6mPBqPHsaeiopTPn57b?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dc6020-6e20-4f4d-de32-08dc59d6b3b6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 03:23:05.3767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rcnze8X9cS8lFZQuaFPRzSrA+1mg0hAIeR5smhlllKRbIBxKdEExnJuicZLh7wj2O+brrK94v5FSdKZgjBNaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7951
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

To i.MX7ULP compatible lpuart, there is only ipg clk, no per clk.
So add a devtype check for i.MX7ULP.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/serial/serial_lpuart.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.c
index ce08a6b4486..891352293f9 100644
--- a/drivers/serial/serial_lpuart.c
+++ b/drivers/serial/serial_lpuart.c
@@ -111,11 +111,18 @@ u32 __weak get_lpuart_clk(void)
 #if CONFIG_IS_ENABLED(CLK)
 static int get_lpuart_clk_rate(struct udevice *dev, u32 *clk)
 {
+	struct lpuart_serial_plat *plat = dev_get_plat(dev);
 	struct clk per_clk;
 	ulong rate;
 	int ret;
+	char *name;
+
+	if (plat->devtype == DEV_MX7ULP)
+		name = "ipg";
+	else
+		name = "per";
 
-	ret = clk_get_by_name(dev, "per", &per_clk);
+	ret = clk_get_by_name(dev, name, &per_clk);
 	if (ret) {
 		dev_err(dev, "Failed to get per clk: %d\n", ret);
 		return ret;
@@ -479,19 +486,22 @@ static int lpuart_serial_pending(struct udevice *dev, bool input)
 static int lpuart_serial_probe(struct udevice *dev)
 {
 #if CONFIG_IS_ENABLED(CLK)
+	struct lpuart_serial_plat *plat = dev_get_plat(dev);
 	struct clk per_clk;
 	struct clk ipg_clk;
 	int ret;
 
-	ret = clk_get_by_name(dev, "per", &per_clk);
-	if (!ret) {
-		ret = clk_enable(&per_clk);
-		if (ret) {
-			dev_err(dev, "Failed to enable per clk: %d\n", ret);
-			return ret;
+	if (plat->devtype != DEV_MX7ULP) {
+		ret = clk_get_by_name(dev, "per", &per_clk);
+		if (!ret) {
+			ret = clk_enable(&per_clk);
+			if (ret) {
+				dev_err(dev, "Failed to enable per clk: %d\n", ret);
+				return ret;
+			}
+		} else {
+			debug("%s: Failed to get per clk: %d\n", __func__, ret);
 		}
-	} else {
-		debug("%s: Failed to get per clk: %d\n", __func__, ret);
 	}
 
 	ret = clk_get_by_name(dev, "ipg", &ipg_clk);

-- 
2.35.3

