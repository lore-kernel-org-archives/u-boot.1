Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17137C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 11:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FF088700A;
	Fri, 17 Nov 2023 12:38:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="UpjGrO16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A584F874C3; Fri, 17 Nov 2023 12:38:46 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20730.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::730])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 152A48700A
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 12:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXlCDTbGVptmN4ySo08FZu3w2DF8+lU00EVsv1kkEifWBkFVLOU0DuxjrMcbNMB02PRH50K7nPrysHcZWL/V+4EZGQcEAwDuQUIF+pXhE7x+tVPn+9HJHXonLPL1TCC3YMz3MI08BKygKjLqN1dOkLwra59iHWSk9xhAaL+MxXi9ZNRG7luZReLwGP+EVusyjRFYShqF3JY2VlcjVlg9TnoveSyx5UmDwK6CLZoUNM5rRMIeX/SdnIoobGN3s61ZvT0ryZ8iOFe870ZEyD9yP6/SACizYsHBnWW67n4HcsLipAvBvcNq5XFQW9ivI5IpMsVDYNp6BVMCyjobLa9W5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fSI7/xn02EatSRAaXuthuJNosdTzLuB9JzGwKeIGPk=;
 b=NXHYGMt9vWEV9Xmmi7RPsqNYd+FM4Nw+bdlONw/ZjcZWHRf9h6z6mDm4eVj5xvzvsg/OrcoEeRUYraABbeY9UpXfSH560w8fbFMtAMxUXda7V6q6/Uid0GuYgLm2aEQmSQKwO8r2cI5keN8uxWzrFkialFiaKi/0Q7/g4F8SfV5xaA5sUXuaauJw47nWtoJcfRqmFJnpjM67mScEHWn1WAvA47QJzUe0S47oiTr6TUKnDwUnvEnd5lfo9FWJ4Fg7JX2Sz5uT0FNgQxMSDbxZEv9iAqUsBTYPMGhq587bIoz6SZJ63p/O6AuxyOp4gnzTZ1n5bRCsh+3zUrdi+xrM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fSI7/xn02EatSRAaXuthuJNosdTzLuB9JzGwKeIGPk=;
 b=UpjGrO162OORxH8KrlnG8dkANpMXXOPG0IK4DlXnXP5RqvPvFOTVVJDey6FeajEhlEPZXERtV7oJM7AHK3UezqJh9XXjf0h0TinO0PZLyTdCz9xs0J/lWdkfkK/PcjzED+xPZgpHs/KFHgmPgKg3wvitLmFOhLRBzAufXYt+Sis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB3664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 11:38:22 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 11:38:22 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 2/6] led-uclass: do not create fallback label for top-level
 node
Date: Fri, 17 Nov 2023 12:38:07 +0100
Message-Id: <20231117113811.149329-3-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20231117113811.149329-1-rasmus.villemoes@prevas.dk>
References: <20231117113811.149329-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0000FA93.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:4:0:16) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB3664:EE_
X-MS-Office365-Filtering-Correlation-Id: e1892985-25fd-4ac4-85cd-08dbe761b418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfUuPVSubpPXPg2WUMaiLDVoOcOK3kiGw1srnuxz+Qkvwm+OL6LYlWPi9BprnQb8Z06jyZVrwsBqVoTQoB2i73ch/wXCkCB9qLSGbP24JDicKyr5wmZlfHT1kYDqU1XsfSVHIYoBSxpGFyem0AgVLQ/NODXYRTSKRszKsL9jWyZucpKJ1l6rHK89ZGwxSK/CsPZ4UOsXYrrEJitDnB2IidV+I4gZpJszJl7I5TiLEysZTKn8hKHGjEhLOIv8QwNksKmkqjdKGAwDCrPz/yIdigj8wjz7g1IlyFfj/sdQ+c+LXMz/wJr6oS+Z3AXz+ifjP+tV/tex6+Ckg5UlLJz3TJtgLz28Lh85t3L4VUxpt2zmNYEePMgRP6+jyjvQqn/Wpzhh6QZ74H+IxrHsFhTT0o2qo0BXrr7snmfnFPJD2fq3m65qwST9+9QO6KDc5Mtnrhwvpwd1GOA6CPfLg/HXS5Ov5QCffwdTaI1wxA2Mcb9LKhWTljqezXsM2zWW7MVFBb0XVoABGVVe9gb5SPAjMEgpCzY/+c6QtOogs3YugSczSwWiqS7jAXEzMQE3nO+I+qsFXF2Xl4saQX2/9yKgy9p9AmNFZYONb9UyF7Pg0pCXfE5bDakehW70xwnLY/Yy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(39840400004)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(52116002)(6506007)(6512007)(36756003)(6486002)(41300700001)(8976002)(8936002)(6666004)(107886003)(5660300002)(86362001)(1076003)(8676002)(4326008)(38100700002)(26005)(2906002)(44832011)(83380400001)(66476007)(66556008)(54906003)(66946007)(478600001)(6916009)(316002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BaXqTg0ncEMKybhp0hyccI+AyAvgvfXt1ATdS1CM3UyyFR+bOQsmWPR4vSHp?=
 =?us-ascii?Q?2pyprvToLUBd3ykHDzzySp5qZAgFA/JBs5z3+lPpwA5WIMBKT8KOBjwxwMaL?=
 =?us-ascii?Q?f6wniyYSvuI9yu5Cjwmk/EIm2PMLi1Qtf0FosH8b3e2byHqq4XTpIU81LRtB?=
 =?us-ascii?Q?ehTHAb73Zf/BouP8DhY2uIR3WBJ+yTgaPl7zVBNo961D5XD2URH9Y6Urxmfz?=
 =?us-ascii?Q?tZ+FVZn5bFl/+LYfTs9ItNF4fo7X5ANge+CX7zie6Sae4LK3vrqa6N15KNtD?=
 =?us-ascii?Q?lKJCw9Ta644ChX2+p6HvIxcApz2IViOYL1tz/Rms1TYbov72Hy9bxe+bTcsY?=
 =?us-ascii?Q?OluEP4bRwMYiiEj0N+H91tDfmYzVA7dyN99u4xmOvmN/jNkHTsKR2X1C37H7?=
 =?us-ascii?Q?LCInFpdotRmBgTej7M/+wZOQ2HQp16KGFdGvqvHQ4vXry0joxL3Tob6jDDjG?=
 =?us-ascii?Q?DpbF7juqpdsI0MgMApkXHdusZ4ppfvRnzCS8aXpGCyR4xQJ9aVYRP9A1z6G3?=
 =?us-ascii?Q?gRj3Uhl6OKw7ODENOOLEZowOxcZxCopUAlJ53a0WY7b+aWlfKQMxFhMXYdxr?=
 =?us-ascii?Q?g9xZDQVQ0+6V3xiTipG8539BoymkIuxrfv96KsuAgM74O2Pmgf3ZD3Pcrw9v?=
 =?us-ascii?Q?1jWwqNkL+6UbGrkRT52ImvKMsvf42ckUNa9K6PFjYunbO8OQqNFE+/ZTJua1?=
 =?us-ascii?Q?Ia+7ZocUuCVTh8ddlkDNisqr9bpiHIfUDVW+hfSNh6Gx/lUDSpahTkG2VpL4?=
 =?us-ascii?Q?zQPWGSRck2hc6VNuWUzPerFSY+D44TpeV9/lvM8ZlQygzVJKjq9nGSUlw8Wh?=
 =?us-ascii?Q?fWtWtDGWa25y3AcOQER2YukSjsFx9UD/4xYLYfZEPjlxLYylt+ad4IhrW6+j?=
 =?us-ascii?Q?GkClUCijEYBPflMMz0fzx2f4b5qiNfPA3+Z7YZhnP5fAgDFMEKeTvHqCuvmG?=
 =?us-ascii?Q?vraX0Nl+69RQpRYLeGp2gfy3e5oMhifjkX+31brIEjSa8NKf9/60hpFKR+0/?=
 =?us-ascii?Q?vEHNYFqKyMCc7gaTaXf0aDR76XjaJOebsQMmWw+DxiH0JMxezZKptH4O70Nb?=
 =?us-ascii?Q?y45dV9ivKQhPoxY+pKvH6WsiJYVaCHD/haKW7GlUvI7nA+NhcDGYvTWhRxTG?=
 =?us-ascii?Q?vvtvi6rIGNX648ZuVr8sOSI7pNhAm8cZQKRUPcTO4RMxJqdheBdKHUz3Nbsr?=
 =?us-ascii?Q?DD3EDMx8bMrNz73cHMErdEqhwmEyGXjaMdruwj2VVCDOwI2cMXHhrHKIGHgM?=
 =?us-ascii?Q?ARStU+KefEpJkOa8Wng333dhDLR4GHJB3AmvJnozpQtzyLzRkaPmaRQ5E2lz?=
 =?us-ascii?Q?vkf6B80gdoX8prWEq+B/EXuMrTrswW2iL+buJ0KZ4kVw7PUXf0v21pA2oa1q?=
 =?us-ascii?Q?EnczqGS7xVGzIHntpmgUcz5f6NaiO7VEGZlt4XzJ+BvVd4EDEWGPaaEykv/M?=
 =?us-ascii?Q?63BbYRVJH/i42OhqnK7K3Xg5VGH8S2esV9sBH/BYxVwBzmDPdpv7qDMNBurF?=
 =?us-ascii?Q?XUPL0gbhtsSSavVy+5NZgZjf3q2aIm/I09W3VW7jAbXGEbTiuR8jbrn7Tz38?=
 =?us-ascii?Q?5reIj6lLauNZngt5axG12sP9Hl6A0NS6R1AhiStDGZUF74ibhKaG1s9O+rX8?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e1892985-25fd-4ac4-85cd-08dbe761b418
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 11:38:22.3411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnzmGGlGuE5CUR7p4viVvYr4Vip1UHZwIR6TPyy2pQZDaHPq9RxIi5ahvf0UNSFzU2tnmU4DO5KFd1qj+sB28WuWSWbMWnR8sLSeI/MZzFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3664
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

Many existing drivers, and led-uclass itself, rely on uc_plat->label
being NULL for the device representing the top node, as opposed to the
child nodes representing individual LEDs. This means that the drivers
whose .probe methods rely on this were broken by 83c63f0d1185 ("led:
Move OF "label" property parsing to core"), and also that the top node
wrongly shows up with 'led list'.

Binding the same driver to the top node as to the individual child
nodes is arguably wrong, and the approach of using a UCLASS_NOP driver
for the top node is probably better - this has for example been done
in commits 01074697801b and 910b01c27c04.

Until remaining affected drivers are fixed, we can use a heuristic
that only sets the label to the fallback value derived from the node
name if the node does not have a "compatible" property - i.e., if it
has been bound to the LED driver explicitly via
device_bind_driver_to_node(). This is similar to what e3aa76644c2a did
for gpio_led, but that fix was then supplanted by 01074697801b.

Fixes: 83c63f0d1185 ("led: Move OF "label" property parsing to core")
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/led/led-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 009f1080197..0232fa84def 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -74,7 +74,7 @@ static int led_post_bind(struct udevice *dev)
 	if (!uc_plat->label)
 		uc_plat->label = dev_read_string(dev, "label");
 
-	if (!uc_plat->label)
+	if (!uc_plat->label && !dev_read_string(dev, "compatible"))
 		uc_plat->label = ofnode_get_name(dev_ofnode(dev));
 
 	uc_plat->default_state = LEDST_COUNT;
-- 
2.40.1.1.g1c60b9335d

