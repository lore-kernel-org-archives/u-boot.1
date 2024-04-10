Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FDCCD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 11:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C7718815A;
	Wed, 10 Apr 2024 13:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="jCp94Jrc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC4D488166; Wed, 10 Apr 2024 13:11:28 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68CD988122
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 13:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDDFqe+qigZqTqvHyOJZI+7KjEjsNw5RhyQ8YC3SlSkMGuUSKCaP0V2bLQ7nue6EdOWpx1/43H9U6BJDGP/S8NPA4LzVf+Rl5+BWQsYH2UWJqPSO0JXH/R1uTLVFWpSih4sj+h8UBmWICmhribDmrCg5Vno3zYWwNEb9eFGa5lNw28xN7P42J5zg+aqksnJU3pBDQYeObUTUh8a+38FKtpjNenMiouU7kdMJo2SJQI66CYdHoFIEJAR0FSnj/dUCxbsTvvt0y4vrC33fSDHijXaXO4c7uPhrSW9L8Hgl/eykC1yYLoOwcsTZ2RZ94lKB643haWZQ1Tx7+P2pV/UB8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8w5KUuhrW24nkhBoueXdYAFQBi2+Lr+hb/wCoxz8Mc=;
 b=A6O2x5D/Ff5C5tqjDnJef9USLYMN7XCGqzaR6/UxyZOA46WCU/uYf0tH9is80RwK+Ce0fQjXSP/o3jXhfXep0dqZPhfDwdAQfeXAR1s+cOygldQ2gJbKCQtXsckikv/3w22Jz5UM7UgMKS8IsU6HnAbrCBtqL3PPbz5wtR51wDUlmRUL69u6tI/eH+5K3GoQQyIbAzW0Rbi/g/3tF1AGwLHUjgK2ua63GScRSqumibgaMeIrIivFN4Dx1PR1Wf5+CYLb1nzWz3BJaisSqHgJtYt/wGjZ87aYTJvKvg7Vx43zff9GAujOHUEDBtkBFEulAki8KX6/2ZL6AcY0eG/HPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8w5KUuhrW24nkhBoueXdYAFQBi2+Lr+hb/wCoxz8Mc=;
 b=jCp94Jrc0Ahgx24QYraYOlCy44ToIrIs4qgqPB8Wl9GWui9l5FJGo9H9hteVodlDUa1dzo6Xi7j88surZX5a8P3zCEF2otY9/daJrFuRqMUrRRLvcp8swxCPLNwmaz1btXD7glalecwlDuEilOHtdvaIUHOEZDcu+Xj8wTPwZUA=
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB6233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:78::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 11:11:21 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3704:5975:fae0:7809]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3704:5975:fae0:7809%6]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 11:11:19 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH] gpio: pca953x_gpio: support optional reset-gpios property
Date: Wed, 10 Apr 2024 13:11:08 +0200
Message-Id: <20240410111108.84470-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0104.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::21) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV2PR10MB6233:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Gap8XHhs8L2P7DRyw/7oyc/aD3MT3C9NYRH9gUlaKBj4tVjMrDuUkUiOGBv9W5E+BDl05m95Bhen9mHBJ9xbFehC/QZy3PBLnPvuMDK1XeUSQVMegZyX0mWvwhBFZCycfipv5Q+5es8/HlGH3yYvAUIm6xokNzWi3xiKgW05VYvT6rPavWztuxaUnIwDsZicyjmpHfwaC4znKgKmkfSRqGvtncn12ZgB8CdGIG4FAsasy7ggAGrEpDbNC7Ue/xhKEA5rt1bYVjZMsRsW5CFuwXfecme3JyCMOu3svxyTQaiux3du0pZM8UFYeyX6qno/yhsoaFssFUW8D54YqyZc/OukqNl+AQWUDHMf2U5cpkI6b19cfmiFd6OcVAW9UX6YpgJ+rF1dob+UoTn9WejSishtdodl70shLdCV0T2Q4TD0SeFd/S9vJ9Lopbc/gU8pwKvaV0AWQ+wPrxb90jPumUdzYu3t4SjhpcRtAO9IBpwYFXQUUNGZCFbByP0knXx+LI1j7iEovkwNYJXI7fuVyfVcQvbmy8T3hLrcsO839uGABPrV/TAWOPt2xuLMIyGMmsO4nROuNT1tYzw1w63VVisbcAtM6ngwuNJjLHsj0/7HP21e1+LVAT9JlrbHxzgPdEEJXZdZUyVWniE5kdqLEMn49SxxIZ1qvzhkPdtwRcdMXieC4PjwmRF+iEePFLF3LkEuwqw9z4ffcYWgUeQsjUi8NcqidupKWimRFGSyyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IuQ3BR9agApWf1uP7OvFUk+6pNd9Ssyyf6/c87eF6QRFvN7Y+9NgQgtOUWZF?=
 =?us-ascii?Q?dKTSk9wkScebGitNBAHjeEe8j1Zha82zfmJmuhSflPjIdIQB8dFs9XDfRt5T?=
 =?us-ascii?Q?FcPvZEpoUs2tA+3ydcJQxJPFeLAUITP1NR2v2/dbNOG7xkp5lt37HJFsTQvI?=
 =?us-ascii?Q?hgRwLJKbeTcMqusVecu1QoVvkli2v/JQKen4rlGugULxzJvgTCYmr6p+Af5f?=
 =?us-ascii?Q?IA659af/pRw5HcaKN0qlYtMWuUsgp1667fNf1FfVbV6QASQKsmFsmfk5cuNO?=
 =?us-ascii?Q?eYJFNmy0vhBRCKQ4pMe7NwTrEAnliDz1uvH6UZqyrZcgw1BbfahjSIuNVRkV?=
 =?us-ascii?Q?ta6CBB0md1s79f/c0BefQNGQZGfeZRtik3LScbyrWO1gfBuBpKTJIIyooDsR?=
 =?us-ascii?Q?+yP+nkOlyQPRiAWcjNDPtkUXmfdT8U5aTQiSnVuCvopLHAlSp7Aw9feQFGj7?=
 =?us-ascii?Q?s1sjwvbMMi6ppPfX0ndtxHbbgmHoocPiJBU9wZOtwkrpT92SMhq9uYcDrjUU?=
 =?us-ascii?Q?uNiwsQIQ/pYgdzrRODE1xpxWoU/n7HrXi7lfRdeXa2X3AKGYWdveUOEPQevo?=
 =?us-ascii?Q?Pqc8dckwk7F4/+LqP4tEnXEaZS/cEsfGRCHXEUMqnluA1SyyN/Dw2oMZ3prc?=
 =?us-ascii?Q?u0SWp6/y0vVb8+UKCaBWYspMChW0ZhwvSIKbBA68QeLvErw0/IzWSIjPdMlG?=
 =?us-ascii?Q?G9KWZXOIgpmGIxCMx+W6jQaXSf25WW0dA/HlDhT4hSGCIj/ND02lHNG0DsFU?=
 =?us-ascii?Q?ZjvQAZEW9KYGPkLi+jJY+geJLMS3iTcTb/PUj8Sxn0u4kPrVVgdPxkFPyYVN?=
 =?us-ascii?Q?S1EMkvssigQdie+wy3xzwWLfmAUNduPZXW9FV4+c+XMUMF5Srpw6KJHEMEqo?=
 =?us-ascii?Q?wKK+pcfSBTEswJl/pI+VyKIBLrQpm2DI5gpNQfh4nhNp8aUqKRfnpl+NeF6H?=
 =?us-ascii?Q?imw72JlUpDiME5DUosDxueVYbTgQ+LZhyze/GXduV3RO5ct8+n6VuoBtcfYj?=
 =?us-ascii?Q?3V2ahQAjK6A8dVaSEPEwbGV+dxXJinqOmwZ0NiA3HHHUKRrjTliwGEnvs6uz?=
 =?us-ascii?Q?sA6sS5yDvVc6A79x8wLC7QbXSojxH8VDgpaaoQgQ2w2GNi6SFx+ZYB4bbQSc?=
 =?us-ascii?Q?H/HeYiuTKDXLpINfr6FY/6e5KaK1BYeQhOE5BC75K/WYJqrwf1WEIIIuHIeH?=
 =?us-ascii?Q?O3FxVz/w4vFo//NPDv19MwXSqljeiyznVG4pHi5KZ2vvOqr02N8RphOaNYJa?=
 =?us-ascii?Q?s9vmMnp941sBCNcLZK6pp/evj3Ap2ahbD8G5AgjVM9Yxqg0GlUvWSvN+FvvC?=
 =?us-ascii?Q?1jeaI6aQOr+LuYB6X54iGuexRkzPoGd5QFserANM7YFX9RDXn3Xfs/Re4U71?=
 =?us-ascii?Q?q3Z604j3gH2LSioMG+VEQ72nFboG7FYtIIomz3Iil/QbmLFzoBvcHzYVNVND?=
 =?us-ascii?Q?6Iv6T+zwxOazlDP3nRr1hqZL/ZpWeTxMK3hbMN2nfxOq/m43pRwi6VWtS9S7?=
 =?us-ascii?Q?PA7oGxlXANDkKs+6jRW/spx6FATLp3y0oz67QtHxOkOwv3C19+UMkXFWwDOa?=
 =?us-ascii?Q?BtK1WAS6zSrP/hPrsrGlsk16RcYQCOittOZ2fQzwwOhTRKDzht6xOP/0wV9H?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1d1136-c461-4de5-2c26-08dc594ef269
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 11:11:19.0729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2FfW4dWhpirQVfAVVt/L1n0U9efVmnGR+SKJAiZI99vs+AnKjXd+YXWjxInARFC6t2TsnU17d+Id0nOOhqLBsjYyrfxNVJGplOjQRLQAt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6233
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

The DT bindings for the pca953x family has an optional reset-gpios
property. If present, ensure that the device is taken out of reset
before attempting to read from it.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/gpio/pca953x_gpio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpio/pca953x_gpio.c b/drivers/gpio/pca953x_gpio.c
index b0c66d18317..24b0732f89a 100644
--- a/drivers/gpio/pca953x_gpio.c
+++ b/drivers/gpio/pca953x_gpio.c
@@ -306,6 +306,7 @@ static int pca953x_probe(struct udevice *dev)
 	struct pca953x_info *info = dev_get_plat(dev);
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
 	char name[32], label[8], *str;
+	struct gpio_desc reset;
 	int addr;
 	ulong driver_data;
 	int ret;
@@ -321,6 +322,13 @@ static int pca953x_probe(struct udevice *dev)
 
 	driver_data = dev_get_driver_data(dev);
 
+	/* If a reset-gpios property is present, take the device out of reset. */
+	ret = gpio_request_by_name(dev, "reset-gpios", 0, &reset, GPIOD_IS_OUT);
+	if (ret && ret != -ENOENT) {
+		dev_err(dev, "requesting reset-gpios failed: %d\n", ret);
+		return ret;
+	}
+
 	info->gpio_count = driver_data & PCA_GPIO_MASK;
 	if (info->gpio_count > MAX_BANK * BANK_SZ) {
 		dev_err(dev, "Max support %d pins now\n", MAX_BANK * BANK_SZ);
-- 
2.40.1.1.g1c60b9335d

