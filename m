Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21D9C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 11:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8884287056;
	Fri, 17 Nov 2023 12:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="j05beaJY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAB8686E96; Fri, 17 Nov 2023 12:38:38 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::724])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C94F886EB8
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 12:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtOcO3ZkmKD8ttLsc+Uj+SwqxFDOGNDRzkXOxvr/TtOOdvzxrMMoQvaPSRKq7m6p7lhCzIjeazOzv4x9KC2tzTtcSQBSGA9jKhID+OnDsVbRXw5GllZP6xOL3EHTUjUkYL48+12LCQVEbuuySKmNnIq4hNWUimYqLX0C3V4r7fAILVWqwMYcwBm1eyRFeGzQ0nq7Nq2QkfrmkNNDon78g9ibKhO1BDhUgo0fCkZhnAyCT/mAYcc5kAyNSobwyIg4Mm/UoptZVh6bUVRHvwF/OSWBPibYj5IaOByw5KhzAHUrzah3LuTCadQsu0z8xqQMrqdSKfxhtMB7t47Qw6EYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZL9sPwCr4VsdJsi1PHh3Q4O/y4yF32FKJCDM0ShQ9A=;
 b=Fym7W/iUTCei+iIPe2I3D8Pbc2g3Tj/hHSyFj10d+KVLTDTmpmpxZEsRR+aaQzbrseWITAuGwFLvDQ0bLmgKTlv2I2Huo2tq2lHe7x8x7lXVmvQB+3toGSj4iWay/14Xa7WCcsz2s35N+LN8IfAH5sucBFGOHFmoS9stcXSgmbex0JMtghf7boeElHQPqQHE8H5yF0rIlR9w0MIZUl3K/xIfB1AewUibuveY67+Cj+j9LFW6OL2Z4n4AA8o6Aw92V7e+AspZ4cgRANvRHpG+NIAMi1Lo2Ul3yR6Xer+8ZFy52WwZOHYV68TaLzT2C10yK8ghr53YKY+j8xoqe2Nzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZL9sPwCr4VsdJsi1PHh3Q4O/y4yF32FKJCDM0ShQ9A=;
 b=j05beaJYG3Q0W7IR4bvBARhMUtzOBWb2tQFskIRzfjRJR1yXOTkl5H8V+GGy+ZUShYti1wLbOCLpnVWT5eRx0R8PulFt3dH4ox7QrbOiqrie+B5ZVeah4ASo7Npjo7d0E2kNAiXa1hyVHpuF4SgxO3SwHJBRxz87gRFmzTeT2Z0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB3664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 11:38:21 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 11:38:21 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 1/6] led-uclass: honour ->label field populated by driver's
 own .bind
Date: Fri, 17 Nov 2023 12:38:06 +0100
Message-Id: <20231117113811.149329-2-rasmus.villemoes@prevas.dk>
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
X-MS-Office365-Filtering-Correlation-Id: 2a3545f1-48de-4dbb-613c-08dbe761b376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fuFLIB2pYC11UViyXmLnl2b3uFLsSNImsFW1fJ4leLLtNSv/ezeX8KG8pKgoVFzxx6aI3TNFpAF7jXZOVC0572B/BRMEAye0CDaKkrd/scjbc1eyc1iPYS6A80R45pm44rQSC3+uG+kPDW3+PMX6FdgvSCeLEUJn5QI0SAVitgvhsiV7rjh6Amf8G3g0LDtDAlcVJzDnIh4LZZSi7c5jXwS6j/MZ7qLqjV3B0lfqsraxASZNZ5Fls5JX9cKyGhRkmgnChqJSh6jJMfcHE/1RdAu0ktOxHCZ+a7uUtzAT+VD/bIu31m0js5ahQtG10cHHNo2i0L9YrG3ny0KkNnZosSWGiUSCxDrZfgRVNj1TdGtJVo/rf2CC9LBZeOoa1jcP3QADKL6qokHrAo77wanMrMiL4BgtO0pL0Ur+IOBiNUiCreVKrRVrBS79BdlkN7ZzAvUnhj/djakMdDvsCrtPZvWtl5cjSrQcD+A2m1kOOZh4WRqTaFu+FF5lmhhBM49sAqGjOh9LoxDY2ostLSO32zeYHEVWUhPHAZqqr0qiWIV3N03j5yMgZOuVxksyZ8UDkyQ1o8/ehM26hlXGoF752yKen3bMDD7+VfZOx9Qj/qROTHiQroOH+quVxJkGtIomyCfZpgaKS2DhjeL7biue5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(39840400004)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(52116002)(6506007)(6512007)(36756003)(6486002)(41300700001)(8976002)(8936002)(4744005)(6666004)(107886003)(5660300002)(86362001)(1076003)(8676002)(4326008)(38100700002)(26005)(2906002)(44832011)(83380400001)(66476007)(66556008)(54906003)(66946007)(478600001)(6916009)(316002)(2616005)(142923001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?buUnxLB+44Dx9uT+ltub7M5s0y2XdKQziuQY86hPCB01fz9d6FFCMzUfgMhn?=
 =?us-ascii?Q?K0Cbx6xTGN++znNezk+uoklJko38mli6CJ5itDx2s9CSUYheYBLPzx7Ds3i9?=
 =?us-ascii?Q?cTgQkKqcmdXkNF8V4KA8qXZQdHzol9e9h8fGaeBzGKNLaNNjoZJEHacUlmNd?=
 =?us-ascii?Q?Uxvv5VUjFUYakfE0InbFuniW7kWs/E6PCS3mp0DUQvAZhNcYSb1Kr12uGykC?=
 =?us-ascii?Q?bcqQkBcSsCDaTGJB0C8H4motuLB/Mzhfs99u0hrE2FAO88iyh4rj4YhyIThN?=
 =?us-ascii?Q?j30LLbsTlmla1T2gULyy0+mkqeH99WPMHgMHPjRPaZ/jak7m+bANNTgnI8Ag?=
 =?us-ascii?Q?pHkQ212rWATH/HnShFWRc2+bOREVboSd/AQ9J2d2Db2oXmtZMNT9xQV7dN9Q?=
 =?us-ascii?Q?ZK/SUN7Rk2r2jXZWtJz4nN9XW49rjYaTxRlX3TIpxt040sOqJjVsLHo/gor2?=
 =?us-ascii?Q?uDZKuDtrU8GfawpiRZbFm+YwGFZ/qG99FZEuZj5tEoYqHquaFszyTqXeLeE6?=
 =?us-ascii?Q?hb16XO2OTRHeFcMpNcSrK7f41AHPdPhVmg+uMvxUKl7SA+3PU20dWrM1TIaW?=
 =?us-ascii?Q?rD8ZwBF7WTOw4jCYYeD8ZHCrr0zMaTxzv2XI3d+itTTm3ykKF8/V4VNckiOb?=
 =?us-ascii?Q?Qg86ThgTdw1s5RL3eCZ5JPv97IZM2zrzXVsufaDpp+Bx8gesT/EVzXFIKeR9?=
 =?us-ascii?Q?nQB1ZVCBMJVZvoyXvF+dEvut1/eNxGb5vBTY0zVoEwaUe8MxG4TqZ8K6eg9C?=
 =?us-ascii?Q?jtwu+jaG7GT2cRYQ3riUPQM3MSyOILwuZ2ArUH2+Q3roDoliM3P2bGRJn74a?=
 =?us-ascii?Q?3E4yqmDz4clRq4+osMsl1wbdMFyVb2hUjVoDvhqEqWSqFibcuZzUfsVZKfYK?=
 =?us-ascii?Q?2lOGhCQ68nhsxD1b9MHcZ1JN+HhSyf+AdliZHoRDDimCJ0KTVSRBRrt4p7PQ?=
 =?us-ascii?Q?YmCc1Qik7BU2ohdxzcWJny5yiQ1LLxBNyEB+pSemjT/cXJJB3aBKYd/xeqaB?=
 =?us-ascii?Q?+HHBg+PbLOIvd0wrlq9o9fTpPuM3zO5k+Bs3BGwGa4cnT5Y+0J0topWVd0CS?=
 =?us-ascii?Q?hZHz0fSxJRvWPO/yEKPYRsht8FNJIuoy8KNEFDbW4YYywH+Z3Z/mL3V08iwG?=
 =?us-ascii?Q?kshzaY4ZhLvyUxgPFO4K4/pfY23j2tWmH4+fU+UOopXyT477vj6VdHTu/Z02?=
 =?us-ascii?Q?NqiRE/hv1JrY+loHnuSk1myJ1cu0cYZ7pJlA66bd7hUUev9waxhWgNc7emYg?=
 =?us-ascii?Q?F6nktPavu9jThisY4RWgRGvCj5aPYYL+4AVn/ZUF5vxIr6ZV7oXjts91gAWE?=
 =?us-ascii?Q?2gqlqagTRrSNcuCNhySH6Jeof8kJ7tsTGYyHj7tTPEwhADUMED2KCjFymBho?=
 =?us-ascii?Q?2sF5JvMcL/Vn4yb4lB2KM7QzRrc+i4KqTmzimIZV9zOZd6FRHcjJ4FF1uTCI?=
 =?us-ascii?Q?gBWEUaXjSfAnZSJHtyt8q8xGAxWKYd8wwWEdgp3RTrSsZmcn56Ji1JbZv1L1?=
 =?us-ascii?Q?TYZMq7fBVjGrtZdzwAc7zo9TJQ6/2niJ8ogIC2vvXEDEbAZhGLEJI3tNIbkx?=
 =?us-ascii?Q?7PVJeAsz/k9bKwPGOF0Clfm3XJvstN53/YQE+CgCft66mLRkDA9DS5Mj3VuG?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3545f1-48de-4dbb-613c-08dbe761b376
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 11:38:21.3329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5l0YwAGNuuoRgXkrojz4R1HPS6JPlB5euxpJdwrmLi6NuD1mhfTFuVgfx+RarQqfYC/Je9/ZgpYjZPlJO/clTk89pLTyEKoG7LWQYDWQvsk=
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

If the driver's own .bind method has populated uc_plat->label, don't
override that. This is necessary for an upcoming driver for ti,lp5562,
where the DT binding unfortunately says to use "chan-name" and not
"label".

Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/led/led-uclass.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 68ca3c29702..009f1080197 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -71,7 +71,9 @@ static int led_post_bind(struct udevice *dev)
 	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 	const char *default_state;
 
-	uc_plat->label = dev_read_string(dev, "label");
+	if (!uc_plat->label)
+		uc_plat->label = dev_read_string(dev, "label");
+
 	if (!uc_plat->label)
 		uc_plat->label = ofnode_get_name(dev_ofnode(dev));
 
-- 
2.40.1.1.g1c60b9335d

