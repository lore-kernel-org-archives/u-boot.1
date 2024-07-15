Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2793C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 11:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10BDC88829;
	Mon, 15 Jul 2024 13:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=weidmueller.com header.i=@weidmueller.com header.b="QjZwGtfv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87BCA887F3; Mon, 15 Jul 2024 13:23:14 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 953D18881C
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 13:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6s+T0iBZ4Uo+QGrTd+wDh2a09v1JWW2h8mrpW3DAVJkj+27JrlsQz5wejKRadWJD7pLtHP+BTFm6AcnL4VxJAUqUWxOOjrXFpAngyG8KIKz9omhpIoIrUq/kHwhOOk+dfojRQfsVQF2LtBEJpdyom+r7BbUW07FZZ0qN9eG23zDPGKI7ueg61Gb0BEumYSioNeGIhehZq2Vov6q7gZ3NhZSbqoU3jNKPObXmx0ck77pPUdeKJXHQreMFelJyucdowf2gvQt8cAR0ITtFXz17HsdPEWk8HRce7tsAF89qyZ9u8UrDBCcuRUYFNCmFcVLjWU28KGQ84VRPtFccsosng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EH/JAfSimRzt/1Zkm0E0W/oSfiylGGHQ8Ge3r7vsWQM=;
 b=WniMntMiFBcMhykK44Z3HMWjWfOsjkbq6yF/7b/BfyXgpefFqQJkMbJV32jBVGgO1sYzNuGIYUY2zEO6PgOp9tBHxgQjRe2aYAaFaVw9bKWZdMNTuBDQ0Z6YY4S1WkUtw0G0gEW3toHOt93G4pf4ByMbtK12F8gJHb2jaWQApyeLplf1JbbVhR2Vh1Vzz6CskJ+roHT9v3mblBkgqVmHyHsGyl6NlchbAMF7/fzJQpxWZ1YNGRPLltFpvqeUnEBTwgttiO7/iUUd/i8a6I5W1G6qkq9B/Ewa/Mg4grpKyHxJVSYwAI+Lt8CIupGpg79hUxb480Q2URgQEovl+G0t5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EH/JAfSimRzt/1Zkm0E0W/oSfiylGGHQ8Ge3r7vsWQM=;
 b=QjZwGtfv27yUtr9qs3Hz9XrWIzjHCoqnnwEcyGmZ4A2bsQrtCrGFzSE5OedpjM6iJulORB7v6HVeLWwwdeKTIMwual5y3WGODT37OsztfSSIFyUWMhRJ/VF9jDmH4proZ/JT5/v+sP1Qb+7f5o0lSjwcnFgQ3w20tyN4gtuV+PpDJE/CgAiPp2E5z2mvRA1zzktWeTejnE2T+0de76EN+luLLKxX89dNQRaBzoAIvAfWQxtSBpfVIcaUENkbUVt7e8vIqzUZqe7rCHsXONLkctbDf4KdNX4YMi0VpZSAKiIHrQtWpHDZhPAtlINzYwE5TUqYmovkbHjTDvMS18HjjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by VI0PR08MB10917.eurprd08.prod.outlook.com (2603:10a6:800:252::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 11:23:11 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%3]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 11:23:11 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/1] tpm: call tpm_tis_wait_init() after tpm_tis_init()
Date: Mon, 15 Jul 2024 13:23:01 +0200
Message-Id: <20240715112302.652527-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240715112302.652527-1-lukas.funke-oss@weidmueller.com>
References: <20240715112302.652527-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::15) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|VI0PR08MB10917:EE_
X-MS-Office365-Filtering-Correlation-Id: 3acbadd6-50d3-4db4-3ead-08dca4c082b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lrf9WWASU9/wunSTZBU1lJ7e6pj2nGaAhHPHKO26JFAQnqVwl+DG69Fg3YS1?=
 =?us-ascii?Q?fA/QBEVyTncUhATQ2Cr7UdQMOjj9rQpyq6+0Eivqg+Fii20+eD8ax0h5L05g?=
 =?us-ascii?Q?x8f/fmmbP8OvW2ziAcHQxxot5jBPouax0FBeyxOK4DUggNaGNdlppmLDmjHE?=
 =?us-ascii?Q?4wROSQFaxMJyUJRii+53uu24KHUNoPoLt2tN2xXOqWF6mVVDux3Ci0kLlvtl?=
 =?us-ascii?Q?0GJ5JTfloDpgfOCrlm5XA4Sa92xCjUH0p0QTkRniKB0RH246lZ4Mm/K3ZSfo?=
 =?us-ascii?Q?+LBiteV/+q7wKDuuUh2+qS+s91HAFE0zu+acRxY/a+RYUvVJtDVNZnURK/O5?=
 =?us-ascii?Q?6aEVc9TLXcZ25mbKO3euUCVvIu8xReKAUnVs5EcCxJ146h4PxAvmfqGfF6GU?=
 =?us-ascii?Q?I1F+VYpXKKGUczxLo9LncHogKww9B8DE+F92QQpU7+jCU0Q/dsRGXwfQdzbu?=
 =?us-ascii?Q?3pAq5oTTWEbpRvrToN1RkNzv4ibPAcYr6RYgte9AHboPRqPe3ZLGoJqENkOQ?=
 =?us-ascii?Q?TTcm1LlSRydqTmh5Ds8XvpeAYyeivLUIZZ6vqZ8M084ertKD7JSl9Trnhsr2?=
 =?us-ascii?Q?Yhll7YiHbwBd/g9CA7q3+tB5JLnU260TYOEfBZNg8BLz56bfsjDctI+CnIv3?=
 =?us-ascii?Q?nMBAqMdywm3HidSI2FHUV7dGOzq7VsI425wTVNvHCR6+A00RLQgXeZhGZtzQ?=
 =?us-ascii?Q?1O161ZoOgbDX5UQ/RbBuMl5T9tCV8+xiWd97Q1sLLcCDNwq0QfuXGyXv7FCX?=
 =?us-ascii?Q?rHsk0ziFBh11E4uA99y85vyFyPS9+CWoQmEWmEL7GbXkZo2OP0B8zWmoJ2Gt?=
 =?us-ascii?Q?kVhouhMcBKs/QDRpEuXZuERlbAotxP0zqrzF8kEmUhdY0i1pb63lPwxw+TIW?=
 =?us-ascii?Q?Gz1Ml2/p/OK5r3NbCs2c4quIEN+ADhYNlQM4p+3y6tuMu51Z/EbKlJgKwe8D?=
 =?us-ascii?Q?T3EtWxeg5npNxodHzf5coIZfk8ZRiMagGiecCGrR0zctYn/aNn1M40y1/Aic?=
 =?us-ascii?Q?0iB1JPL8FktpkNjmuDYLg+JUyva/0tq4ZZDWafBH0Ln6bstORaTn3zwjD4wA?=
 =?us-ascii?Q?8MJW95S4G5ZK5aYZNDNFuc4oUemrJYYHk3j14SykmPnj1ok23rbjtfJlPMtx?=
 =?us-ascii?Q?uSwWeNA6u7dV7veiX84ejfV1Q5CeSYkzPDSVlN6D1HJ7fF2TAQPil/UaR5rx?=
 =?us-ascii?Q?JO7m5eY3hFCxlViwHfVla+USrxXN4QhJhaSWKYeupjfFcgziCF9tAu/HculM?=
 =?us-ascii?Q?1mxtBnf+h5sfaka6tL5u3bZ2ho5sy2mnYpQt4vXRnFyASeZKnftVlQQJ8yXX?=
 =?us-ascii?Q?UV3z/f1+WMxD2fNGo0OTyBgU3fIa0lV5/yVL4hfQ3hp2MB17rbD50Q3+cEpO?=
 =?us-ascii?Q?rI206Orq7Dgz9DzWmkLcL/lC0TI2QfeccaENTTrwKFTKS9hEfg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A9p++se/siOgTSNZY4FdVTcgU12kK6NUvRFjjMVyOOKHjeYFGlpcWv8oyIFK?=
 =?us-ascii?Q?Xbnr5i8olnQf32WsIaJqGVsPMTVeYKZ1Qfhva4M1LRoPNMBedO/FrCKXpMO3?=
 =?us-ascii?Q?fZaKpdjCU2CHlTzYsns/NSuhSmo8cmN+UEPzdHWUP+YXF46UiIP/7oUGNE8V?=
 =?us-ascii?Q?LuEM8m4VSkRzriyiuUcX+/SqcY48/IwMDb5PZzrjVdn4oDxlv1FeOGe761SH?=
 =?us-ascii?Q?zagAfmK/rRqBR3g+DevT6VGy844l1mmkxsjbjGh0BZNh2UQl3pTvqFugdhVH?=
 =?us-ascii?Q?ALPGNBHRi6fxSu91PzqtbzT9//u+EJTp4HeQzvqbVFKeLjROVDrvJ2yElAQV?=
 =?us-ascii?Q?aExxot49rmgtgcDkndKU+SSrtjkRxJFLoGBnzOK3gqEY8n7juS4INyMUqxpH?=
 =?us-ascii?Q?Kxzau7vNOF7h2p80HdgOBe+zzMAJFD45Uh0K4jBsbi0SRODAxE1k4uQAfBbB?=
 =?us-ascii?Q?7QTvEf9wHsEnlEbcwYKrRbpc4JRfTcm17Xbd4hHOr6BOlwVVsYj4THwh9cmc?=
 =?us-ascii?Q?Z0f/TFQ+1q5UGBjZbUjHFjImHpUAvKRkJwNeNaWnm8eUFlf/68mZaJosu8p1?=
 =?us-ascii?Q?lntKWCfP4XFKc+s9zqp4zvUy54d/jXgT38AzMtF4oM+vof6B7KlgLMY3unax?=
 =?us-ascii?Q?S0BmqR4MCCS/ouwt5iEG9tFxmx5eRtYs94OLNxGKWiJ0z8VX/fGvu6TGOwU5?=
 =?us-ascii?Q?gTddBhXQHxKpsHsxwhXMVXuw+UUONfrNzYXs7Kv9bZKICAASB6JiJfLY3vpz?=
 =?us-ascii?Q?ZLaKadVPo/q3Qm82/a1bJK2rppW9Py9cU1daMfm2g71MQKxUkG/Yw65Wswk8?=
 =?us-ascii?Q?5myFlhijRKDPwGrbribaXi0VmefNgjkVZdxQvclqIL29zCKEM07GW2c9sjU6?=
 =?us-ascii?Q?qmY5sotdKTNnnZs0GdvRgxCB8pyahDhOmmMgkDlyZ6iYo3xxQa0h35ptvVrU?=
 =?us-ascii?Q?SfdZJLMrGZ+vUJE6qE/m0prLUcNuNaWEsfftefm7C9Cc8glPPUfseOqTnPii?=
 =?us-ascii?Q?7m3xnM5VXcz+cpYw73DYPth+/vRFObMsQeLgvz6Uqfvuf51z5KYaBP0cNFHC?=
 =?us-ascii?Q?YJ7g34iOBMWExfaWtPQDl9WRolkUg4jmFK63h+3asz5NWVwSgqsAqgajM0TX?=
 =?us-ascii?Q?2o1pTKj50VJfUeGOaBJY4YVK/vpy4+MrEMAXqg9RHtTzEQK2VUKVDfj/NIVb?=
 =?us-ascii?Q?/3xBmaWWn0m+11XThR+4psdjEtsAv21d6W2toyN1VCcoXOkw7hZLSY+QMKhD?=
 =?us-ascii?Q?Lgt6IPwiBdp60DqZzMoSdksPLn1VUUUKhaoFTIbnx7Yr4/8qnrU9bd6NjLvh?=
 =?us-ascii?Q?In1b111DbmAZ7uv0QsdLaL+Sj76m22MANI37iZneIapyDHOBvARIrnrwv19r?=
 =?us-ascii?Q?98wwy0qNaAV4+CJe5fI8TXwrBBjLdiauqJhGUVm+GrxXTDqJjsYblEvaD+vg?=
 =?us-ascii?Q?6LeL1QZaeT4bYIWJFMnyZUh9zD5CX6CTBzVdKqTMbecjc4yGnns2xzI9OLwT?=
 =?us-ascii?Q?kEZ3hbvLDRHWzHvZIBcY4t8qamccNMbkuFbAuxBh53PAOMlNS0eRWwKI9keZ?=
 =?us-ascii?Q?zV/uIxgpNfGzyEigUhUmcKTlFgeWWLnWuMRUT4/ObMHwg2xfR2pXAXy8od/l?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acbadd6-50d3-4db4-3ead-08dca4c082b3
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 11:23:11.4392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwGMGtEj8ggpBOsAdcagdgjU3rRJmZ6N3YVDAwOnD1hTFz+fIVmTL70xrVLfRpr7pp0tLK++QghwCd3G41asng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10917
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

From: Lukas Funke <lukas.funke@weidmueller.com>

tpm_tis_wait_init() is using the 'chip->timeout_b' field which is
initialized in tpm_tis_init(). However, the init-function is called
*after* tpm_tis_wait_init() introducing an uninitalized field access.

This commit switches both routines.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 drivers/tpm/tpm2_tis_spi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
index b0fe97ab1d0..5a4dbfd3ccb 100644
--- a/drivers/tpm/tpm2_tis_spi.c
+++ b/drivers/tpm/tpm2_tis_spi.c
@@ -256,17 +256,17 @@ static int tpm_tis_spi_probe(struct udevice *dev)
 	/* Ensure a minimum amount of time elapsed since reset of the TPM */
 	mdelay(drv_data->time_before_first_cmd_ms);
 
+	tpm_tis_ops_register(dev, &phy_ops);
+	ret = tpm_tis_init(dev);
+	if (ret)
+		goto err;
+
 	ret = tpm_tis_wait_init(dev, chip->locality);
 	if (ret) {
 		log(LOGC_DM, LOGL_ERR, "%s: no device found\n", __func__);
 		return ret;
 	}
 
-	tpm_tis_ops_register(dev, &phy_ops);
-	ret = tpm_tis_init(dev);
-	if (ret)
-		goto err;
-
 	priv->pcr_count = drv_data->pcr_count;
 	priv->pcr_select_min = drv_data->pcr_select_min;
 	priv->version = TPM_V2;
-- 
2.30.2

