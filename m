Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDEDD58B15
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 07:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A90E843D1;
	Sun, 15 Mar 2026 08:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="mLw1xw6q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E18478440B; Sun, 15 Mar 2026 08:48:14 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C6C5842DF
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 08:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=da41Z3PbkSc0LTI+wJtPeZZmnKndux2Fj4ZDc6eks+OUEaPIc3VRbmUIQ+F2lt3FduRrbs3CQWMRqZ01V7gduruDXi7tPGd3NfMc+auLrJQrgg8MXMGeraTIBfdrEZ8D6RP1If7kEp9XNXH4nxx9c8SdIsc61R54NWFn5vxPDmb+Ep8Hj2Yy+qCKESVVylCydB19qXgoymPW8Ym8KVeVjx/COATrMJl8AqQ0/3ZnWQxren377kXvy1DIRRYWHBly6E8e1bgk8po0wpwDM2g5wnpJAC/xhBG7X8b3xG57//2sBZVsO9kO05rsAKcmD7yqEt2PM9RSIfQXmyVzmRaaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydnchtvajLbOXOt9sYYhSW7Yi1TFJEA0R/HV6K90dWM=;
 b=YbIMI9H1br1EfjkURih91pKUAT/Gp/Ap+tZjNKFEnsWqnzRpRlaF+RyXkqG7zBU9kRCMWzJIEvjxN2iOPQPHDHdLhQsrmM28mvF9Qt7KxK8r8an/B90S4tcSiYrF03AjwUWLftB7gY8OZd+S9gIZs3ccdfBrkyYWuI0W1eCY3knY3WVUfXm8Le3UsFdjpBPE7072HW3vuNvSglPV8dFypquC7btggXL/KaN94GOc4Nos+LoJ7b0+t2DPWzToeLB7i2nTCxgw7snv39JQOK2M3X4QTG+TcuG/wFQNjjFgxemxmUwo6zNxo2MmPhLCk73Gtbf1yeva2ItLv6ZKJzv9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydnchtvajLbOXOt9sYYhSW7Yi1TFJEA0R/HV6K90dWM=;
 b=mLw1xw6qOOD1SpQLxMdKAwH6jAO31tkAqkx7oMPnDVZJjM3jwOkPTUxHsF+wdZ1xAiVQ1SXNNxD2cPCdBQcPvQDVGSmTYuO6e4PkzFrLzVty9wJZlA2yExyXerqyWzckW2loTeb3RBTDGNebVk6HaaO6KKV5E3LIK+yZFustW/QhxynalRXbm3GOsdD4Xr0BlYc2x10xjFs0RdMmFgDyRTnqYwj41IJEL0CmtQy/X/XG4ZjOkIP3p+cKLWumjBUmQskZEXurGfEl4mxq/lp+LmcqGNmKTwko512cyrkm6Xj0hNxBucwMCs4m/jYM1z5rB9Y+v7f5KkG4mm9Qd7GfgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU0PR08MB8613.eurprd08.prod.outlook.com (2603:10a6:10:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Sun, 15 Mar
 2026 07:48:09 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9700.021; Sun, 15 Mar 2026
 07:48:09 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 2/3] net: pcs-airoha: unify code using SCU regmap helper
Date: Sun, 15 Mar 2026 10:47:56 +0300
Message-ID: <20260315074757.3829709-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315074757.3829709-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260315074757.3829709-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::7) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU0PR08MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e274d2-67bd-4bc5-bd25-08de826733b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: j0/H6otKcwti8Fjgwfluvg4POLAmzPnkPpVxLYKL5fZm1FDRcQ5M2nAJ2CqI9JGTW59vbkvyBRflMqZ/ZeMBSOvjuLRcwA96TzAj0N55t5IisVE05FqRf1ppKhx/oDqS3/CiSsBkQ7I3wu+3cEUpb8RdbrWLrc8M8Aj+izXEqBO10DAYNV3pK2Q4oiMle5LmT7yVGZF9mf7CIBys8MgxvLRaME+F33YtOhmpk9JQ6In/ZmtDFmFhCcbvmNG8MwcFy5g7d2CTgXpMIHE6Xh7NiHtk4kKILl9M27oi5roVvuD10u7q4lAQwXrhTrFYaE7nmNAhJtgka9EMP2ME1R0iJbWqr8If6PQVG++ftCyjBf+hyFpbDtMDX9HWnwpzT9VEZLllOvzjhQlTp1RguBX5eFqQuaOAjxvrcxreyKkkzlFrTRz1KyCxdzEzNTGhn323BO1T1mMd+YxK7P6eC5Ain+ylKjClNAf0voF99x+wQxb+fbbJNaM788fQEPMIchM3lowYntwfW4amYLTDkQ1a23P+Jn32uq9Vs9YZuJmuidV+6wf7wfIaMuWuArKLBmvgq6lK/uYbCv1hoFLgiG4MMhq/38n9CNcoPC0LoCrlhUUCBBaaEModHYKK5rK2PVRddNc2W8beARjiufwN8WEsKn7wmqqwGSGuZTv27nqG/QvcAUEO8oF58TEDJZut6Y95K/WXOuqM1dHsixXwRB9v1QrwWlhTlyufyDz9QELmpmHQ0lPF6Y4PKV3nsDhd5GCFJkRVYTigWA9Tg6J2+KDpm/sjBlLqheTX7MuvU6FV1b4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aiT/GuuDu6rpFi44UPMFoDkASXw+hHTvlTTY7NQX3NDN/k/LNDCJhKUClHqm?=
 =?us-ascii?Q?lspGNbk5QAxrH8JMFdZb8zTj/Fj30TC4SULEOi5MTUmUMlQrRbla2fGgDNR8?=
 =?us-ascii?Q?ePuRvRXMpscgZFTqq+wcXPiBBWN3NZWUZZJ02lh77F4pKnva8RHZ/mInh+V6?=
 =?us-ascii?Q?0uYIaTEOzGzgnOJ25i9NNGD5mM+bqn8lnLKmUbDkU114HQjWmtvyXI1RB8iq?=
 =?us-ascii?Q?IKqElnz5nnJrN9IoUU/M22X6Bs8nadlDuY4cCmmbBLhgozKzpUYVbzuwGp+a?=
 =?us-ascii?Q?SN43VS3FtlRBdcBWMObLmIas8r2k/rv0crepzwJ62upZ5xXYSivBhKxCa8R0?=
 =?us-ascii?Q?yg8plDqU7T2nQ/MKk147EGa4S9xfgubIDLEPtXoB7sGWXPWaZmNvkgx3bDTV?=
 =?us-ascii?Q?c5qTepxBdXzhRUVN8d6zBVbXEIzmlNRNJoduMbRYEs6Zv/i5xTMjEBt4lqVl?=
 =?us-ascii?Q?Uvia8qc7mmRZm/vJL0VBGON4cn5z4JIuwMip84KlJfIbr9QMuFIQsajrYXKI?=
 =?us-ascii?Q?JuRMwyQY5R+cxQ7bT9g3g6ls1MRMa48sKHgu92uxUbvFWWkloM4zYi5wS7EF?=
 =?us-ascii?Q?r3b6phCEANLWJ536vcoKPATVhKgMUVfJyWSOR7GUOH7et3KyXbNbOJQyC2SW?=
 =?us-ascii?Q?jN7bCg5g2XNtZPHqA466rD2cuNYH8rXFRlDJfsc86ZL3I2Vks4cdQUP3JOkJ?=
 =?us-ascii?Q?jE98VCqReRrcyoTDGRu/M4XWnYgSZs4POtUzb/fu16IhoGDcTp+umUmcCuS8?=
 =?us-ascii?Q?A76MaGsrObCIDYBQ0PjQbTVVvDUZvoa7KCD9vQyBloPgCxgvyl3YYMaHa2op?=
 =?us-ascii?Q?d655TK/3ffVo0Bprk+Gccc1Fv36p2cqrh6vz7+tizyMdw0Lvn5hmJ2AWEDBI?=
 =?us-ascii?Q?jYFLeSZRqBo9peZ5kxBSpfnmMNJfVXVtwidOPcXP0a5x6UiT5Mu/xyhM1gvM?=
 =?us-ascii?Q?fm+g2d67/bbXBKTpk2YM02oykMFszacmufuxmCEzNyhQ5pc+QESY5KeF4fLf?=
 =?us-ascii?Q?vBJFzCIgbp1snyhMXghxzjZuyN09qVohOWpwkVClftUoxhxUU3JWDgZ86xyh?=
 =?us-ascii?Q?LYYe/yjfY5MGXOZP8haUASB5cNT6pV8SVX+HvMTnsl8mVZILc9zAI0r/Gqvn?=
 =?us-ascii?Q?OgxcjMnUGy/5uOUy/RUQT8CPj1M6u+HkYzCvWoMkSGV4W+AgFKf62xggDW1L?=
 =?us-ascii?Q?d2omze2FUiQmD3Vk0UFPlBVTKnEUDiVmCUiZFjnL/dh6G/pFLhoZxYL8ZmM8?=
 =?us-ascii?Q?VEXuqHR3DhpkX2UbMVU9eHILyVlCnW6TTKJOrVq4RYmwf2BTHk2j+r19AFcg?=
 =?us-ascii?Q?8Eh+H7E124FnZY/3+7maEdIN5MjpxmdW4uJpwrdSMNK1LALxzrwBeEfe5QNL?=
 =?us-ascii?Q?lm/E6OZ9PmKauxJBm5G9bQyRKpjBA2oS0QsuX/dWX2Lr54r12iqnswgpeN/4?=
 =?us-ascii?Q?386xvQuxcIsz3QjbkkTY8o4Xn2kmKfoRII+mO+5zedGKr19jILZJsam/r4lY?=
 =?us-ascii?Q?X3GjsBsaLjdMIHTJlYbSetfsrhnQ5qQSAqVn5jP6Gtp1P2O/AthsQ66z7JRE?=
 =?us-ascii?Q?4+anRkvgF34laLx9KG62T7bc9t6wfBVzmWUvfeMS/0QwGEoAANGzpUfqPf4z?=
 =?us-ascii?Q?77F+ydG9N83xcgu9P33XwQSmtzpRwkIa3K7nXPURv4L6g/L7/QNs/2eH8Rh3?=
 =?us-ascii?Q?gkiVuZPoAar1PDEVd9QxU2toYBQyHkNp8UgZicvpoVJbZcU9jsb6THOH5TQh?=
 =?us-ascii?Q?UWhKYWBwAivS9JAIp+/8RXN9DAd6kjo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e274d2-67bd-4bc5-bd25-08de826733b0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 07:48:09.5375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1iteuFA3TRLkPRktdrNuChSA6pp3F46J2Q4BZLFsGFDG7eaJp1rPanekB9y+SMQ2vDEqdsNAVTZium9+3+7aFHzPKXzdyQZyXaMKkV+Vqb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8613
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

Use common code to get CHIP_SCU registers instead of driver one.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha/pcs-airoha-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/airoha/pcs-airoha-common.c b/drivers/net/airoha/pcs-airoha-common.c
index 2e5cb085498..1263092fcdd 100644
--- a/drivers/net/airoha/pcs-airoha-common.c
+++ b/drivers/net/airoha/pcs-airoha-common.c
@@ -10,7 +10,7 @@
 #include <net.h>
 #include <regmap.h>
 #include <reset.h>
-#include <syscon.h>
+#include <asm/arch/scu-regmap.h>
 
 #include "pcs-airoha.h"
 
@@ -755,7 +755,7 @@ static int airoha_pcs_probe(struct udevice *dev)
 		return PTR_ERR(priv->xfi_ana);
 
 	/* SCU is used to toggle XFI or HSGMII in global SoC registers */
-	priv->scu = syscon_regmap_lookup_by_phandle(dev, "airoha,scu");
+	priv->scu = airoha_get_scu_regmap();
 	if (IS_ERR(priv->scu))
 		return PTR_ERR(priv->scu);
 
-- 
2.51.0

