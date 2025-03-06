Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D90C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 06:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C4DE808A2;
	Thu,  6 Mar 2025 07:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C798810DC; Thu,  6 Mar 2025 07:20:59 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20731.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9554D81249
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 07:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOVkKpB7mL32s1olJt6b4jn9lfEKhsIeBhyIoWl1AKJ+MtJc3LxXj2AENFRyx4EeAw7adOffVCjuvkMTekG5vWsyVzbdCTsuZJIQd/hQox1gJC4N85XtU+Ud/Oh7yJutqHkaCzcMjUuzdEvrW+Sxq0/XYgkUZLWf69B3KIPVw0fAyoLQyQ1TP+DMqH1eUoLNJ5ZEMEwdIDPSkEWtqTSfUyhPFb6KK4uLzCRRdESMTIjROK6qfd5tecLyUAwymdYhBvLiIApZBP7r6ptb2jZVbkmjdyZBkscLCI0vDEqrzR9o41+AUml+zNX9LHU48pmRmgVhJcvPwHlO1e8bc6LGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0Ty0jRPQTcOCWqfu6b7opkoNymxGrqgPP5vnrETDFM=;
 b=VBXtzTwPkz28ZEUOatwqqHpGKNLU8TcmDM8BE7uJStNT9DcdDQRPKeCDSisyGYKofWGoosb9uNZ51+ua+1B+3UZtxitlfFU7JC5nUJ/+fDP4VKL54N4D+YEVwR9JAMW8pfZr9FHMJf9UyKoDGmBhS1TqcNFVy8x2qwDYJ0HH1y8nx6vRSjpaTNbqN3AO3uTEXEyHYt8PSV79vLVxl4L0DRDCSkqDG9O6oB89F5LKGczvZR57xa7ZKQQgx2ezMTXCe26wOAxPFhbNEQSDOV8FG92ZscDpx5l1HWm1XagYjCpgskmqlk7S1TFdO8gFjOF+2x/jHIzTkaXN/ocoEYihzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.30; Thu, 6 Mar
 2025 06:20:46 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Thu, 6 Mar 2025 06:20:46 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v7 4/8] usb: cdns: starfive: Get dr mode from wrapper device
 dts node
Date: Thu,  6 Mar 2025 14:20:28 +0800
Message-Id: <20250306062032.50314-5-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250306062032.50314-1-minda.chen@starfivetech.com>
References: <20250306062032.50314-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::35) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a311084-fb2c-4a3c-e9de-08dd5c77082c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|41320700013|7416014|52116014|38350700014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: b6ryJVosUbSAfKBz2kIiuJSIQqZ+FKA31KrEmS5NBL7GJojbauHL4+77rA2mh3Os2tlVPxvzuPM9K6pZL0a3Two2v+hnnQKNhi9H44q7Bbihcev+PgAWiHR7u/bQ1uBO/0YXno6VrIT2NLxl4TvewZT+6reXehhYAu7U7R5sbH8q+Yo5b0YtZXXC+zbnIhnIHxcUHsEAAD++wEHFyZ7zcZVgVF7BrYLb6R3FDfQ7LVix7u9QxU2UuD2LH6dPw4gS0neeJgXvp93CTdSz9iVuhbYuETxluPKasRo304PqdrsGtzjhc0hT1jnudJRV0z+wydytd7RWqfkkCMZF5oP4QMZOeCx2rhzLKeOluf5btN/pzZdwMOX+/dAWC0/QOnCt9M4XEmHm7vIFo8hV+uD4RjRBdQ1NLRatAeSCTg7oEzZ6sa2fyAtQDomkDEn4pAMvCNBx37OkCvcT4RYvdIEtI7O1VvrboASlnLj3K4ag7JHCMwMrqCEuVlCrLvytbtuB3UelQc3Ll9fYoC3ODob1qcIsPSipnNBhmdnxQIoneNTcl1RG93ukZpNlBnm9JkNnekjWRjRM4bEpeelPVTg+niCq8Gzerbvhzsc3XDhpibo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(41320700013)(7416014)(52116014)(38350700014)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P7DzdkGCThWOyZLERwQNTXKfi3pl5FsZKzILTIG6QytO7zXvg7zTN9T+bWKT?=
 =?us-ascii?Q?KMTi9NlmoMwJy51kjxVboKqxS8fkvAFtuaXCwWCoIGJjxbhpkNaozPp8qZxG?=
 =?us-ascii?Q?1r0Z6qTMs5HisB2g7kGtXRbi3hfRK+ihHtYJhIOP+A/zA+b1I2EzgptJnAUv?=
 =?us-ascii?Q?MDkgjq+566t23+HynpVIFJyN5S18Rs2UULfcV0ceVrmEANz8I6lUzldCXMTv?=
 =?us-ascii?Q?kRyI7FyH0zO47Ovd/ZSL2n4YF5Rg1qrwKn15I95cE7RJiQAnBH2zltBTOua5?=
 =?us-ascii?Q?mZrBj23lxcI7xcRjf1nDTycs3H6JJTbE5/Lq6UsaVFCbynzhQUqh3nlcQBMk?=
 =?us-ascii?Q?G5YOYYDPZ+5iVNuw+kjO6Mdt4s/U8Po4sdJaIlUz2KBLcTfOLGOtLO03kmyW?=
 =?us-ascii?Q?ArsxfooofeOAhzgz4Nnjq/G3XVkYrcR115Wp6RLSMYJkeJZAq3IKDek4gJCb?=
 =?us-ascii?Q?sb+O/xxP+XGRHMK2+uln4Ok3+nNrKGdibMyiwaIKcW+crzyhH1oqmYmk9Apq?=
 =?us-ascii?Q?2KRfIQ5guQzP/UzUrZVoBxtxA+VS0EOkp2l6sUPg6TmrjKSJtDWuxeGELgCO?=
 =?us-ascii?Q?r+khEMQi16vSSdmMDSWv/BtZLT0pyBPCxsFBUFo6bLhFB2lyTD/IxxRT8PQg?=
 =?us-ascii?Q?TisMK+i+NyFd92YJt9pSxlr+0sB+yV1j6MZr1fZot6sOUUrwzWU+g59RExUU?=
 =?us-ascii?Q?oiGGDn6iZqmeDMSQkfSIFXr7lFQKrBhV3lKQ5rnV7yefGSSeBhQr1/2uVUY0?=
 =?us-ascii?Q?mjt6MybQ9ZkzYxwSj/XMB7gYlepPnN/0SOjE++ztN6FtMIbBkwsJm9qMmGGC?=
 =?us-ascii?Q?7RjSIgPj2nZCK1Dz04dy2DZ82PLFXPflvVm8jaUycVBslf19nVqTmyEaO3rK?=
 =?us-ascii?Q?zOHGLI/T6IoQ7s70lkhBFtW6XFhs2zm0mDCOFrl1x/hpZdZDPR9EubEg0SSv?=
 =?us-ascii?Q?WTPolR5Lnw4AoLpy2XrLDMT9EU/C6h0aBseJEiw/TsfbFICXAdy2nHQPj6/n?=
 =?us-ascii?Q?VzRTaL+swfifGa8P5tT6KjZo+PRjNzHKgDUaj2wjccpcS1MERDbiAw61xHn5?=
 =?us-ascii?Q?3DPZoKhwdebUunK7z6RI9x7JG+3a6KUip0DDBZZO110gcJ8mDT835Zk8nvlw?=
 =?us-ascii?Q?ySHbyihAkCc3PjLzEueHs/hD8eriGBxyRvQ8BTqLCtWICII9pKdpyxfNyWc2?=
 =?us-ascii?Q?MD+vlZEpulD+FMJSmim0mjbZJJV9koz0VPWQxv1L/5wsLVUxX2oXGhmBELh1?=
 =?us-ascii?Q?GZjtHnoGtz3Ci33II5Pv7RHf9wsZNX/aTe6glLNWrD4bMd2hGsdXs6uhqUgq?=
 =?us-ascii?Q?n3AgmvIAdhog91NNlpk3hGJMyF1cUvc9DjlHMB9VNU57o60hc9LWEOhcEqRP?=
 =?us-ascii?Q?ngHCIDkIpoeeNIk5bKbYzPxg+DjsDfrrF40VysA5vT2qD3bUNi2O9/JU+Xlg?=
 =?us-ascii?Q?UH/sLAiP/nYvaXM2hOl/FFJ0ztD5B6LxgFSJAGCYZ4NHqHNI9d5zOq0o3/gq?=
 =?us-ascii?Q?4Oc0IlIflIsSVE62S0KcHwyy870Rz8OFSSxhBNsGro9rmFaPLPB5/n/LVLiz?=
 =?us-ascii?Q?U3cXLcHiJydwkNZ0MHCWflDW/yWbwo8ltxij4StLLzKxZRNxBlCgOz69WtPd?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a311084-fb2c-4a3c-e9de-08dd5c77082c
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:20:46.5499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjL2yB4PsU7u8lCp6NgAAIBxfVMZ+Esulqkzc+SQxaUAYNuDHSH4/0FMRg2c85goCyRVwzzWvPUA0Q8ijtdU37pJBU0KsM+TXYzTzuQWnhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496
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

Cdns core driver also get dr mode from wrapper devcie dts node
to make it is same with Starfive cdns USB Linux kernel driver,
Starfive 7110 OF_UPSTREAM is enabled

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 drivers/phy/starfive/phy-jh7110-pcie.c | 2 +-
 drivers/usb/cdns3/core.c               | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/starfive/phy-jh7110-pcie.c b/drivers/phy/starfive/phy-jh7110-pcie.c
index ecb04bdedfa..a30582821d9 100644
--- a/drivers/phy/starfive/phy-jh7110-pcie.c
+++ b/drivers/phy/starfive/phy-jh7110-pcie.c
@@ -170,7 +170,7 @@ static int starfive_pcie_phy_get_syscon(struct udevice *dev)
 	int ret;
 
 	/* get corresponding syscon phandle */
-	ret = dev_read_phandle_with_args(dev, "starfive,sys-syscon", NULL, 0, 0,
+	ret = dev_read_phandle_with_args(dev, "starfive,sys-syscon", NULL, 1, 0,
 					 &sys_phandle);
 
 	if (ret < 0) {
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 4cfd38ec245..4434dc15bec 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -410,6 +410,9 @@ int cdns3_bind(struct udevice *parent)
 	name = ofnode_get_name(node);
 	dr_mode = usb_get_dr_mode(node);
 
+	if (dr_mode == USB_DR_MODE_UNKNOWN)
+		dr_mode = usb_get_dr_mode(dev_ofnode(parent));
+
 	switch (dr_mode) {
 #if defined(CONFIG_SPL_USB_HOST) || \
 	(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
-- 
2.17.1

