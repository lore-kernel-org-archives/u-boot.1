Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE300CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 09:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 578C3871E2;
	Thu, 19 Oct 2023 11:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="YRkKywpI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E11E871DD; Thu, 19 Oct 2023 11:58:51 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe12::729])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE20E871D0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 11:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL3PP43Snbr13rcsN275XIrYfuBpPHJdyT3W5GzFkeeEnX0VbrnkB03HGorzyLYLLasjyEsobF3pDrxqN6MjQwjvtof0vvFGkH5KB2WJLYH8E59tvDZkhx0RcSekX6XDfQK3xuiE2DZPSaceKYzLVptu1MLxmBwVZdrhX+1XJFE158LoYX/fk5JG7rEdC782AECbBW94KAlOzjYnfPJGSf//2H5yq0nR45lHK0amXIlX2sNYOAc4v45DKS3TiJ5X7AI7aEkb7TrdJ5q9Rt5jiEunradfs72jJLEWxeWxMX7v7+QQnz4ubpli7swH7BzWySwChZNQY4KKENkP1jNEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOKMqbEpwOyUivFbQ0gahUJPL5o9k64syp5zCvA4LGY=;
 b=KkZ14x0pzxzqULBC/SGCwRBaPlAy0//vMMpa3MBe/04hmj2JLNow4GhdbYKOqzB9uhqkwvWnBPT1m4fDxrOdyTyoDkzZ5EbhVU9nBfjf/Qo0LqiY13djztho73o68QDd2zEK08L34Lrc4Nlq1/HPKNwKppcizgRgTIZur0NWffyuG7sGn3RrFSHYEaRM+B9DwPPcwUY2DV0pM8FbpPSIbzmXPzmRcBaB84/b054O8ywUWDYNvEvSEO37nZbPyy5k+vxAmUNra7K4Lh0vKYi/Ks+Yk2fz9+iLNniuo2NSq2QPa2udUIkzU9MvvLQdcx8+8RXo5dOy6KjOhPvgK42NMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOKMqbEpwOyUivFbQ0gahUJPL5o9k64syp5zCvA4LGY=;
 b=YRkKywpIJGHCz2/ep2k9Bz+cjUAIF8z1jerWrHv9eDacPDbqtOnfpNtOqK7My5HUwJ4ecxd5ewXmuyfU87ap4222xwsZaprHH06gKFAbbuOC0I7ymlZyutu8nvo4w988wkYK4M637RC6o64wMH34G+6n24wqWrUI9fUXFQSfinQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB7481.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:424::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 09:58:47 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 09:58:47 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 2/6] led-uclass: honour ->label field populated by driver's
 own .bind
Date: Thu, 19 Oct 2023 11:58:33 +0200
Message-Id: <20231019095837.2084458-3-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0094.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::35) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU0PR10MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae78e70-e6d6-461e-8196-08dbd089fcbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0P9X/0CcCtEk3kOHJvkEmVX4pEJWDssQpHs1tmtVGkfBaiODglHAN0Jo4MSL/IVq8OED1nitTFGcsrkIk1i0PzazBOISe2VaembyibJeGp5F8lHSNOBHLXeScYQzdWvoCPjcB6mT6voQVSOvmBLLIXCj2EUUfiwKg+zmDSxIKeKGlPOlgQkiAmq4w29wugff18srs1bgu7NP8+KtaFxQtyEN+uBriWfk7YOo9Pg9byJuqHEFq3NSzFiN1AS3TzzHVVyOiGHY7fOLr0ZyLQlK4CEBOPCmzYvEU8IBC+3xNJqSIPXVxdWFYq2FiOeN7THTRTc3it0NAnIUJoT5f+jC9kjZVxU0W+hs7mYbALaAGH6WdaV26FgDzHTthvGKv8ZTfJFheL/ASkQWLNpaBPnBY3LFLLZSxkR1Kf761QYaGY3WcGDcaU1owD7642gxwrXSqji7mqCOsrDQNtZvTAnLDFVtNKDU0Tdt6tYg62Xug0j4fr/zabl3Sb+SSeyuSczJAUUozJUjZ6aIaqmpqemeL8dUaW/wPzpqp3+62K7reIAEOf/S3B9xNxEfB38ycccNrHyaK5HOVxVdZ00xaPgoONbcvlEqWga0i6PposNGHTY08uVERUFFbMdBg1i23bw3Rncua5ROA6xt1pBkAVDkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(346002)(39850400004)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(38350700005)(2906002)(38100700002)(44832011)(41300700001)(36756003)(4744005)(86362001)(83380400001)(26005)(6512007)(1076003)(52116002)(6506007)(2616005)(107886003)(5660300002)(4326008)(6666004)(478600001)(8676002)(6486002)(66476007)(54906003)(66946007)(6916009)(8976002)(316002)(8936002)(66556008)(142923001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L4qRxMrOzcCjAJXdc90j70fQmG+fU1zAPf7Dtc01cpr2smgQQuttN5CdlWJU?=
 =?us-ascii?Q?zE2uZjK7Sv3yHVQFvUJjAx2IgESMw0q4HDWGWCJHv2JOpjrGcHDqkJkfQZG+?=
 =?us-ascii?Q?eyg5RlrIlIrI+m/vo5DMLLhJPTktHNOkfHtSP7U9VQs9gc362uIWGUvbK+3X?=
 =?us-ascii?Q?5MH7l4MTA6mBoqyOxw6VpTMYqa03k0hr/6mFILfBCnixp+WYEGRyFNPLSxQN?=
 =?us-ascii?Q?94JVz9kYksixUOGt61QetWh7Vx+L6vWL7UNXqvclSRiGzzdeSQ9fKtEPzBZP?=
 =?us-ascii?Q?HDMmAidkqYb5RPI0GSyDakCfUx+8O+pOh/eoR5AT6AAFp9Q85ue+B0u2C9Cx?=
 =?us-ascii?Q?SG4ftuO0Ch2VKEtS8t+OzX65X3XVifZOtnWdS7U2hg2T0fKQyEml5VCYk1mK?=
 =?us-ascii?Q?iaORuQlKYF1OoiayMqqwByIOP50FhPFpnP+rC9hdrS1zB3uK5ZcBMednvxmO?=
 =?us-ascii?Q?qTlMzHRJBW+omHzDIPmSScpSqqZEqPVZuP/aCObFpL33IkR5+jmBQMEuCWoT?=
 =?us-ascii?Q?BPAcQ0wBbh0rwGXn0DVmoNPWogJafwWRAzNkQHFNZhFlSWJbgBMUS8nPPdWI?=
 =?us-ascii?Q?gYfBCt2TBtGRph3C//NgmTh1XHMYmfS2ZczhNsx2r3azZwKs89MPNjSxgPEM?=
 =?us-ascii?Q?A14DLITJ8T9tjyQJO7RPDQBAgEqnQaIc84f57BfgrHAtxSb6sRvbuprJQ3Vy?=
 =?us-ascii?Q?1HuaFxd869SHV+sDdwUoBeVxkdVsfpGvYrtG2XITxuoz09wlBD6j1zm/6cul?=
 =?us-ascii?Q?A81OBwT4H75/yzY4rtRTIr/Jl1s5QUOQ8HFM+cPcvF9jHXbaz7R+QjuU/q4R?=
 =?us-ascii?Q?U9m5tuXl+sTiiD6NaYpESODZWGg7lv8gMIAmVWNjwaj3Tqq8xTVTXk2woqF7?=
 =?us-ascii?Q?PUSRqq064UwcT70klN8XesaldFmgi9EF5R/r8cwedPdM9ZKapjcMjELFciRa?=
 =?us-ascii?Q?VtRhjWDbmJcaS5N7dELBjvEl3oXlzJBieL4xsr06dNp2x3wQL4A8CpG3toWH?=
 =?us-ascii?Q?t6Z0UHRM4be/zhvQAHgPRGK8evrDJKnXzxxrwDdbuqoEXqyOU2ZUiv0wjJjc?=
 =?us-ascii?Q?btkzY0mjZowX7InYJz3Kkg+II+hzCVOPsr9dCsp+5gPSWBQJ3/zy8npBwdGy?=
 =?us-ascii?Q?g5zTYvbzVzfwEmekHP9a7aA4Ev3sB67B7HjsfRGXT/JiP0HNbgKTVsDXhg0z?=
 =?us-ascii?Q?ATbFij3Mupr7M+u4IBHqo0oFeT8VSxUdWjmTKwWRzdE0sNSrESlR1lY8cfhO?=
 =?us-ascii?Q?4cE3gteXBWwHVefOjnHoLJ7kxV5Qm9i04GJpx5sxI/AZYL33dqYc/PjgDoNR?=
 =?us-ascii?Q?UU+N0261xrhgPTA3LBQCxlgjZ6jnvm85HgxzdytbDqO6cmer4Cg/DVsrfnH9?=
 =?us-ascii?Q?Ynw8mjzzlrRveORYmyysnKyM5W4jnF+ivW82KNC6/z6WHpW1R9iui8h9wR34?=
 =?us-ascii?Q?FUw7XlGm7CprAjZkunm/H2stizyCBcZtqd1FRG/Z4n9BXt30U6FN0MpVFr1X?=
 =?us-ascii?Q?Zh4TK+2r1A9CrPORPJ+drjEwFTNeT+qpaida25YF9fbl8PTYmHY11UqTf/d7?=
 =?us-ascii?Q?HYNmOpudnMB0ilB/LSqd1perTxf3QHoixaO4G5Ck7grksNXEw5iWqNgwd7WX?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae78e70-e6d6-461e-8196-08dbd089fcbf
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 09:58:47.4091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Abu0SBnJzQgmmHxga3LcFwKGMwt6AulMfXxzBm8adbZaQu2ubzJbfEn56Jcr3BcUKtS9/77jJ4yYDhQs8JRG8UFRAT5U7emnh5UsnmqIoak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7481
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

If the driver's own .bind method has populated uc_plat->label, don't
override that. This is necessary for an upcoming driver for ti,lp5562,
where the DT binding unfortunately says to use "chan-name" and not
"label".

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/led/led-uclass.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 5a5d07b9a7..0232fa84de 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -71,7 +71,9 @@ static int led_post_bind(struct udevice *dev)
 	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 	const char *default_state;
 
-	uc_plat->label = dev_read_string(dev, "label");
+	if (!uc_plat->label)
+		uc_plat->label = dev_read_string(dev, "label");
+
 	if (!uc_plat->label && !dev_read_string(dev, "compatible"))
 		uc_plat->label = ofnode_get_name(dev_ofnode(dev));
 
-- 
2.40.1.1.g1c60b9335d

