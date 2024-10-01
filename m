Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB63CF3185
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 20:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C80EA892CE;
	Tue,  1 Oct 2024 22:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="cWaFaoKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7884389221; Tue,  1 Oct 2024 22:44:59 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20712.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::712])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 592CC8928E
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 22:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbC+QyfJHR6xPpt2wxEqxRmnBWwbGlVpDCVwu8LVXhqsi8uQuOJIbmPETq+mwqc5Ntr9kvnUnaHxgDwciR4E1ZTesgRjjOVdswnHGkjsJr1Pzcd37TU4P0nxkjkrafHPH2/mNFXmzcm+xUJlMgEYZzsy6VkQYR7GU0HoBwwd/TwXd6ZdTjILHrwBDbIethtj1OnITvD9zCrddvHGWAI6y4Oohyu+cn0AW7KjwuH0R4zPW2GuWK2GyjgFlnEXeP6zoL9fj1Qiw0YNoYzFqF8G0tjjuvfHsaOF9InF52npCKGFxXN7hAb8QZa99x2QMWl+MKo8Msiphjgds7BqClDofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhnO1yTnFxziEMejN/Hd504ElHxiEG6WbNOmy1FbNTI=;
 b=skFQH/JDLy/zjOY5su0v3BG31fNNyzaz9cqgCe679sxChf85QEDBfyh6YvJMVAXb3yMjq5SMATSQZuN5qXkwsxrRq3oYwBGlUhVuvC09NzDsYoQddq4A52jgQg4vJHk9uPVHF0p23XRxP7eR/vZD7pNZKniEqVTy/Zdkx/I6NdzsytiXFwZeK7j9IF/6/k6XqypbIAZ2KL+5mo3TSVdHpqoBTC2GtyPxcJ0wfXmRFrv2RCB2mzPJ2yVMn0r0YwWzvSlYMoOuCRaodGM8xJ+bGgXjBcJ9SyIIzzIMf9nx7N6h+/g4rM7xtcbpoT4lkTC2UALnTULmVR6pjdpRPTPaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhnO1yTnFxziEMejN/Hd504ElHxiEG6WbNOmy1FbNTI=;
 b=cWaFaoKwdQ5L7KotHIbsk/zQ3QK1MCPkkobI8t6kwypdsIPXXIANfQHom27YbSzVgZ+HhlwZlrVTEXo6B8pRMB3CHIRrdPDv06764pj3ZidEcp8eNWVUto8bQSX16Lbf6Ualn/6NqcXrhvdHYnGs38vFaW4Nn1aGKyscINuGJhbTHTzF+cHC8aWnwsu2IZZJ3FYEJoQVxFhe7TqeTi59y3j4Iq6mbuU6XM/q2tEI822eTgNexlSUwKni5v8jGB0lsybjmNaagQEBDaIosUBUp8Mvf11VLmGI6ntb/4rlrV1Lj5HILy+uxD8r5MulQeubbph/WUms+883J1GAfZadQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6539.eurprd08.prod.outlook.com (2603:10a6:10:23f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 20:44:54 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 20:44:54 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 William Zhang <william.zhang@broadcom.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 02/10] mtd: spinand: Add a NAND page I/O request type
Date: Tue,  1 Oct 2024 23:44:34 +0300
Message-ID: <20241001204444.917238-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B5E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:16) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f086802-aa2e-47aa-2841-08dce259e7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lfivIfjhwFVLFhlO4rxhvHzaBy5Fk+iKjOJ46X4CSQvqOTiJDIdCx+ztvxlX?=
 =?us-ascii?Q?Iyz5bpTiNYZPuhhzygbA0kv55knXH6HSgq/iRbMyKE3qNmbe7Ld8OQ1tAb11?=
 =?us-ascii?Q?QW+d4pZfdog2zlBt+QLO+E0EYNYoRwX688U0Ne1o+CuuoHWmDoqYPvRn6QeL?=
 =?us-ascii?Q?mKHkmSjZbo5LL6DoURoRBbbs2NPeWMyPnihwdHrlBOKrk0Q8jHyKNt7sHfrT?=
 =?us-ascii?Q?IcbV+ir+95/Eodgi98DB3iNbSJ30LkS4Eicyg/K+yZvJJuKvH0VFqUvxoyH9?=
 =?us-ascii?Q?gr0cKT8Hp9xHNcDmLoUP1JEZfTAsgEHxYaiVoXZm5DhP/KwL7bzILudiealj?=
 =?us-ascii?Q?yutyUHGdhx1LSjn1BNgIe1xsyWPuwGn6BVZTtsJp+Mi9Rmy+1Ixc1ttbuaLS?=
 =?us-ascii?Q?FSCs1q1cS/rhkMWhGrSUxZVeAnRatnWE76KXapIglLjm5+wmRJ8kZax91U1M?=
 =?us-ascii?Q?INISnsJ8ncwsKjkAsI/QD+xe1AliTpE2XKuQyZNBQYlvXS57BT227H/P9spM?=
 =?us-ascii?Q?XgZ/+B0RIrB2RDAp4BxSj6/Pq6Zy1slX1mCOf9CCr6Ued7I9PcQoc9jNqOFt?=
 =?us-ascii?Q?AxQLr0WvOKH0HMa1MAtouSedAD0E0dtVMBzeKaoKJfot0YGMKEfxjKoS7Y+q?=
 =?us-ascii?Q?lNVir/oMp8lVRfNL0w5AtaP/5nE/e3gGptKM/qHS4ud+UTeOvqMhe2WaVypR?=
 =?us-ascii?Q?UzNKTYoJwwTLJjR/+WZbEj2p2+HA7H8s1joohrshdF1lrTESRNtkG6v1KWcB?=
 =?us-ascii?Q?UH96QfMXgAkSUtFl+0gGV53ZWBwsC91HaCnIOb0P+KmvKRgiL9ecMKMg6CCl?=
 =?us-ascii?Q?T7u7hDmHYtZXmJejZMupEjvQ+wOuu38pOmJ4VZ3KCx5PKpzWiKKZTtaKuDTP?=
 =?us-ascii?Q?VhNTU0O66ScdChLGM/FN3oI+onOdT4zoO/aGFE74p3/dfMoLqTFPkgRn/H/p?=
 =?us-ascii?Q?VEOU41qpaPBsvMJmh7Qxu8oSRnoiQN4RChiGaT/xSGwe8W0FvGejLYTmAezN?=
 =?us-ascii?Q?llDUWoskAEnbaYDiRHn3iGMVcNNPa6psapCfXT1rNU9dezndwrelSRqUMAm2?=
 =?us-ascii?Q?Ddz8tA5nCiZXumXKJ2iYvE14yAYOIJbp5lB1nwszxZWCNPLaaLxLcauUi2sm?=
 =?us-ascii?Q?MjPfFnhHYNWH2LtGDNgYF8B1he76hNAMrn9/IrwEdFBFN8IQluwTBJxBFUB8?=
 =?us-ascii?Q?oCRyM0D1sJmo63y3tQ7fzTIv18z9Z1sA2vSkPbxxeTnVeMGXra/blyw3FyPZ?=
 =?us-ascii?Q?bqSbiwvKz0XpM5OpdaJfG+jKGqzEfv1YLL+rWomnZO9VcsCWzqqxPeQQhQZn?=
 =?us-ascii?Q?xrtQDe4nZSybuN3Ic3Zz5SJi1AJ40X7q+mQUgg/sJtxQylznERtrz8djNVt9?=
 =?us-ascii?Q?rkSaT0s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qAYmw/NkbqS6WmjpzAhlBv/+ziS2gXhkex5aUa/VQfItLsxh6I4zmeB9hmmn?=
 =?us-ascii?Q?Nr2rrU24ls81f0PyZP4dGmW3cRqv6nj/WH7lqcaups+CJZqJb710rQvRD81o?=
 =?us-ascii?Q?Fr8eFAdDmFgzEE1m71Lt1BnNzMt4mUc6gMR4cMxGWboWDIKVcPyeTn00DpvB?=
 =?us-ascii?Q?RkKEx0njoep8ftwhD6UJ+IN9BdEdaUxNQwPyFucjW+wT+PnjnL1o/8r4RkzQ?=
 =?us-ascii?Q?2jhhrFbMx9Pl2KSVL3xRraliwGadCg/On+HSWWnRbgLlsQVo0XjOb2NqTiF3?=
 =?us-ascii?Q?bGkjKChJzLpepc8FzeLqr4Z9EKeRHrw7TkrrA+X+b6BKtuwRiASemy3aZHQA?=
 =?us-ascii?Q?8z66BWLlHb8ucyBQ1SZu5ViDDxeJilUUyAJWeLJOL2HERgsXpnuxffbbcODY?=
 =?us-ascii?Q?TgH44JN4xfE1AImUDHfXmRPnHwO4uzc+1jnEWtO4u63QccUTwk6TKTP3S7lC?=
 =?us-ascii?Q?5pbRvexN3usTdd/5p85dBss0ucWzFlsillG5I4N0G467ZnsLf/TB+69lK7g/?=
 =?us-ascii?Q?eQyAN2576c4dhFVbucYhpxvj2Kd2y4EXCvv7PLsDAjVCKCh7vjPuldztqH1u?=
 =?us-ascii?Q?EI+5XiO4Pls9aNYHxLUBTGCpNVhdILaK7wBO2BZkWJBxrFVm6pp8xYHlxPwA?=
 =?us-ascii?Q?v4j/WTaAEGVnvGoIIzZalO9aarhI0Y3Axywxd0Aubptnw5yjrz19u3uq8wnt?=
 =?us-ascii?Q?+Pk7Wr52NHS+rv8U3Gx2A37YlS67+OGftokhiy1YaLliqSdPjhFX2ERszJaF?=
 =?us-ascii?Q?MLYz/XxMaCBL/rEh0Y3ODWscLi/P+BCo2+v/yTs823uojHvmxEKUDQn6rsFW?=
 =?us-ascii?Q?MRaxXiwsqeoZNWm5++RJWNaF4bAFnGmvPabvT1GRPCLTd1vEZISDUK9dz9GI?=
 =?us-ascii?Q?XenQLqhH3ZbDAvDc4vKY7m2AciYWkJUR/9OtrkTcNZiepExHC9rBaGmGZ/tP?=
 =?us-ascii?Q?KgDchEw3M+A0dGhjjyumOeidluB5sLmolKY/CiN+S32wuZP3a3lePirTrbt3?=
 =?us-ascii?Q?VkWsgw09HMvBiAx9Y684vhzlV06La/ogFGbMD5Iw2CwEWKSPko40PeULRKOd?=
 =?us-ascii?Q?wnBDX7YNGnM2b0IUjiaMvn3RAZHtaw9slpY0JCsVn+jaoOP4yqO35UGZCF7c?=
 =?us-ascii?Q?59GokYPd94d1HN9Se3URNWhQi/I4IXx7g1WJAHfCIkyOX3suaOWBT9MUAW4u?=
 =?us-ascii?Q?vdhFS7HoKQ94lLzZOmJ4xE660kMG/AFGYI0HQX6eflyWzKglfTMWCtoWtxqc?=
 =?us-ascii?Q?pob3zNPOWeJqoET3gLPPVH1HyaIZ1hdAK+SmtxBdYZDN6mWsDlDOUcJpeZ/k?=
 =?us-ascii?Q?dA1I3HfgATknNrf7d0bvfrviRSv3+BJnQpLAlD8xqWLjGyjccpsgR1FkgdwD?=
 =?us-ascii?Q?Z2h8eRbVCWvyElvxcHXDrhH2s9sIudhazHw2jLQuNQOf+UjHK/yHFqkFCUOa?=
 =?us-ascii?Q?dC3grJkdkK0Rs2bgzKt9Nx04DdlIm6e/wvzy2znOjYLUFyYQ4kKeJ/pXq+EP?=
 =?us-ascii?Q?iOLgwUi4K3Qd6oUoC1jF4KUVl6Ok0sPPdHmpaTp1giPV5a8ZxER/NDvUTkfo?=
 =?us-ascii?Q?4gjLa4f5Sw73yDJC1HTGJTLeYhs7V2dNg1HFJ+EnrA3fBitbsWOmPeEjcDMF?=
 =?us-ascii?Q?bLsiViIhkiyl7kc4qZ9DV/U=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f086802-aa2e-47aa-2841-08dce259e7a2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:44:54.7304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfeQo1BqcvWbjadQL1PhZBAkStx9yxcu4eo7RpfSoZLjo2ZZKN1WMpQHlxhD9ib+DmmENjDqqvNRZZZrzah2NBJD89qvv+I2TSvFEO+1JXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6539
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

Use an enum to differentiate the type of I/O (reading or writing a
page). Also update the request iterator.

This is a port of linux patch 701981cab01696584a12e5f0e7c2ad931a326059
created by Miquel Raynal <miquel.raynal@bootlin.com>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c |  4 ++--
 include/linux/mtd/nand.h    | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index ea00cd7dcf0..8f227ce81fa 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -523,7 +523,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, from, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
@@ -575,7 +575,7 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, to, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 651f8706df5..0afdaed5715 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -80,8 +80,19 @@ struct nand_pos {
 	unsigned int page;
 };
 
+/**
+ * enum nand_page_io_req_type - Direction of an I/O request
+ * @NAND_PAGE_READ: from the chip, to the controller
+ * @NAND_PAGE_WRITE: from the controller, to the chip
+ */
+enum nand_page_io_req_type {
+	NAND_PAGE_READ = 0,
+	NAND_PAGE_WRITE,
+};
+
 /**
  * struct nand_page_io_req - NAND I/O request object
+ * @type: the type of page I/O: read or write
  * @pos: the position this I/O request is targeting
  * @dataoffs: the offset within the page
  * @datalen: number of data bytes to read from/write to this page
@@ -97,6 +108,7 @@ struct nand_pos {
  * specific commands/operations.
  */
 struct nand_page_io_req {
+	enum nand_page_io_req_type type;
 	struct nand_pos pos;
 	unsigned int dataoffs;
 	unsigned int datalen;
@@ -613,11 +625,13 @@ static inline void nanddev_pos_next_page(struct nand_device *nand,
  * layer.
  */
 static inline void nanddev_io_iter_init(struct nand_device *nand,
+					enum nand_page_io_req_type reqtype,
 					loff_t offs, struct mtd_oob_ops *req,
 					struct nand_io_iter *iter)
 {
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
 
+	iter->req.type = reqtype;
 	iter->req.mode = req->mode;
 	iter->req.dataoffs = nanddev_offs_to_pos(nand, offs, &iter->req.pos);
 	iter->req.ooboffs = req->ooboffs;
@@ -687,8 +701,8 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
  *
  * Should be used for iterate over pages that are contained in an MTD request.
  */
-#define nanddev_io_for_each_page(nand, start, req, iter)		\
-	for (nanddev_io_iter_init(nand, start, req, iter);		\
+#define nanddev_io_for_each_page(nand, type, start, req, iter)		\
+	for (nanddev_io_iter_init(nand, type, start, req, iter);	\
 	     !nanddev_io_iter_end(nand, iter);				\
 	     nanddev_io_iter_next_page(nand, iter))
 
-- 
2.45.2

