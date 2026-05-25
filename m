Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959AFCD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 03:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D24E5846A7;
	Mon, 25 May 2026 05:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="TJwB5qDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B060C846DE; Mon, 25 May 2026 05:07:29 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30CAF84671
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 05:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1hhdDf91QYG3uXkzV2GTVd+u3T3EXtQRHke4M8y2vNlTAz6LsRr182f8SJL7UdfTFzLN+cKQ24L/GzAbbUhoNoAYgMA+3FlGUto1iT9gwW5NkE+t7iDiTZrSydJI5NK4MbrjCrM40DYEljErUM8IOnpMVJsKkWGvVE5wevXc1WAgDB3Y/z+28N5Kr9uIkXEZO0ArtgpzknYoi59Wa9wefeeMQ0bnOvMTPlt98iJkP4keAdCsJNVB+7BPWcOKANeH1LT7DMJr+4/Rqo/DTvPu/ovhX1Rmv7ulhJquiBlX1uDeJZD0gWCkKlDtt1j71H2D6dX+RpjzwT/urOTaRDsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmrUVzVQPQQu0eKbcm9ZHb+H/v67C3hlZLI5v3Kawpg=;
 b=AY0Xx+mmDwAIvh+uldrGSKeBmn/0oEl0gOCxYOBSSRN9jOZxDi5urUhebSmL0pjkR7cgiQ4gs+Y0RBk4SU2jp+NaUyilEzhTmz/eawx6KaYcq/Q0CSJdeASMxybzwez+sV2MbEJNWNlmKCUEv684YvfRQlNf496xx0h8azG4ReAUNegDzOszl+589+vcS4xwZ5UlEme69QUb1ZlWwYpmTg57wu02McjswMUabISwAfK22lSpG4UBD0FBYMHyHjz4iVEt7bFzM4dES0JX7f6LbsOVJ9oh9qk/I/WZVFeOmdmsu+tK//99OQ9EF4bI3Z0KCLVyrsd+E+hsQYtLPKIf+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmrUVzVQPQQu0eKbcm9ZHb+H/v67C3hlZLI5v3Kawpg=;
 b=TJwB5qDMobHqYxK+GGWgQVMMHdmN1KgCdhVvLqgbZyVMye0WYaDdc3PYHQNetAVWTiY14fJcdBZrGo3NZGpyVEvKcPNs9sgHJzgWcly6RS3qcAq23kVoyWUh8IAoqfnqvP6vSqo8lbnT/ZUI/Mui7/ATloYoXLNXW32v38ucJEz6spZ+Kkm6sFqRzIxCTEvYApnuynxSYhIcyvkXB7KJxom+yuL8jb5Hnszkq+g7T2bvpEHQOwOES/Coe/chlWjWSifNKwuxD+5jnOgNwrvxqjfHafE8kQVqdqsPpzUTal27k2b+SaXe3u1IwKK7PS+jMq9TzP8x2UtMct26jk/K9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB10829.eurprd04.prod.outlook.com (2603:10a6:800:26b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 03:07:25 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 03:07:25 +0000
From: peng.fan@nxp.com
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] remoteproc: pru: Use dev_read_addr_size_index()
Date: Mon, 25 May 2026 12:24:03 +0800
Message-ID: <20260525042404.2372280-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::7) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI0PR04MB10829:EE_
X-MS-Office365-Filtering-Correlation-Id: 161e5194-d696-40f8-8212-08deba0abeef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: h6bsADEuCqjJn0oJ8m2vFErsLxVonqSU17i5dv22AfkW5n+IlgZCc7L5IrTobTEC4azTePYnX2GnJoAiVjlrijmBNBHfwOBkQQz43yAahdP0fRh/GTyOKSsQ/5eItzKYm7g78DXfYdn3aopw+ANk3U2A965KXvdNa/46qdVmHG4RtmnHJ5cPmv1k/FT84XxEKZ9XI114aG40XyIO6Szq8INMrro+YkTjKadqIiNOdkAm38gfed45iMFYyCaczK6g/EwRomiQn3WU+tUaW9yWo8AQtF0NpMPPxM7Ax3/OyYjylk3w3PhveGHuwzUJOr4krxh4YK1URZpltMqB7Y1mgSKZGj7m9ep5T11spHt7Itm/NbObnqam8jTL0A80xWt40iUjGIUAlPVRaqLZjbz3wx36zSd64w1JIfVnDoBjhRFra9AFhFQH7ZjQzqVQSyl/jW1HQ9z2tSmOZZwCWZ2j5bg63V1l7nUIsYhBm8VjzzVubK+RHu71rd0OXZPeOIWEPLm5MXBh0wtS5jaV5sxzmWU6MbWj/vEkqPxcqzWmDkkcIFNBkFPu+D2MnMsVRaoMO6CA+kkiwU/IaZa111AlR3nrNFXH2nYkiVajDKHang3Cu8/y17O7/o6SCdckyChKA1Wbuh5ZcJwrfXTskcdg+SVAeZveRwAxA/RugU87Z6y0I4yMgbsV+u+K4sq3/ebNfHuC5jnijE4rF7On02pmrCo+wTTarnVb1TOnryPTH5AuHl+J7vGpz1VaXUS1PRIZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GZ9qDp2DVkjn57q/1dhltXNIV51fcuToylFsN9yJEsgoJu+vpLsd/MjL0Pg7?=
 =?us-ascii?Q?Jzs64ekHyMnRuTBxtzdaAyvd6ae7TOGBylSx2KSRBAZvPRwlxVUNwmZXnzWa?=
 =?us-ascii?Q?7NJGuV+M/S+eMwUPtTe/g7+rVjdCn5k/vRe/dw/800Df/Q6eCZRZpRqabN6W?=
 =?us-ascii?Q?w0Go73/xXE2qH/7nx5IWogFcWhuPYln8A/dFcHJ445FlEbGFtQQkL5Vzkgwr?=
 =?us-ascii?Q?QkzMONpoB1+m92IvR80T2iRcax9CgN2N8IiyubVz0+WnRuqJTZMwlU24Nm++?=
 =?us-ascii?Q?de50ron064jQrwzM9nG4d/B77LkU+ZhjgQTxbm2ScXqDYx9rFXMbsOGBBqPt?=
 =?us-ascii?Q?ikGIkuZkusIavlz4NUX+q0VfrAhtTkuMjWLtXbIN6fHfkAY93LZi9JYMt4vC?=
 =?us-ascii?Q?oe89XQ1yMBk4ctomdHfnGCpZFEWLaqw3fmNe+M4A8wRKdF/Y8aFwsH3zQ5E/?=
 =?us-ascii?Q?DkOF6z/akaftobcPoUFIf25SShShIjFTLb1Gk6C4sh1mGeJ66moPaXCHPuI5?=
 =?us-ascii?Q?ZfEQng0FGr7QGNSaq2Nktk8XhwBbutgD04vLich+k+EeP8zjdREayVnsRONR?=
 =?us-ascii?Q?5d4oDuhhMqzxf2qsfF2WBJXpXBMuRKPvbORajXZg+oVLGd4KF++OnHdGNxxO?=
 =?us-ascii?Q?VHEbQK7j0txJSoSmxpsN3jYQIjM0JLQuXWegG7Hlc3eQeVvozvj9fD9HNtqd?=
 =?us-ascii?Q?0VBNjwH2gVCjSWKdeYjP8mR/2syUfmUfedPwarhOYlyE+hOYczwarGjjOwSf?=
 =?us-ascii?Q?8+TH5iTnbgiNzYx89NpkQjIIuCdinFGqz3I6DzFUIkCbHTSI4qZ/JWFQMbIc?=
 =?us-ascii?Q?yajMNUU7eRGoGr2LHG1ZEEWANTta5ytR0GCq/yN5ZO0P3Q0lCb4HiwoIgYQi?=
 =?us-ascii?Q?P4Pcc54kzejhNW23/9GX51DzBnG7ckEoxKbNMfDv0TSXyF4ZHGQZ5SGWmxUf?=
 =?us-ascii?Q?+jsO92t3UZFl4IiARrJFoBo99TqEr47UbtVO8/hpMlxa4sUpk/558WlqvUpV?=
 =?us-ascii?Q?qDDMkzSDR46CYaBbH7rMBnd+myqhT/oqsBKfU7WTSwm6xFJ4j5AN5l9bPW1S?=
 =?us-ascii?Q?ZedRv5aifgAP4VTuh7iy0Kv54KwWInWPtc1SCOtfMpEtileJiOPGpEkSXD0Q?=
 =?us-ascii?Q?R3NHEWG6DbCyYgF3GHpwLwpCl1SNa1WCi63i2LOBT9P0rmNArQ6jMes39r9X?=
 =?us-ascii?Q?J1vztGPIA3dukI4Uq0jXjbTrVUapLaDevGRL90nMikkVTZQbvDFIDdCOAesK?=
 =?us-ascii?Q?vuYOwnS8HF7NxarHRP8eyNy48rIgZbMqaAbbmzrLth4/e8MaRWEahRUhKRit?=
 =?us-ascii?Q?vqcbwz7EalG59VMaX545RnooJe9jZGEe/TFS9M9RVbl+7FUxdIza6iLlyEu4?=
 =?us-ascii?Q?2OyjrR7ZOGDp/Qkfl+JA2FJrMKCYw2ijQhZv+dI9sWhxftfmhmQ6g7RKt9iy?=
 =?us-ascii?Q?aAaPYoeh0motVnAZ4GZ2pumX1y7OJ15WOO8c7euqxzDspgil+SF8iX9e1Ufu?=
 =?us-ascii?Q?ZLw5OsTaepq6sD2ydPHq8KIrvffjwzuAnMQvfjzNuhFEsWraMlRh1FqsI6Yl?=
 =?us-ascii?Q?srQGCgiBP39VfNXcVHVZlohGX5f/nWNbRYqBg6alDIB4FYAjiezh9fVv529q?=
 =?us-ascii?Q?g760XIMkdypTo4SuDzXh6m2XlrG+2wMUOXfgulYkIJTmK4bmgMd5DDjX+sxX?=
 =?us-ascii?Q?wfugskmmXXUIaJ/bzH0ePKrWV3Fs2+iWWF4pKXgGM884YakFVfPN+Ed1HXu/?=
 =?us-ascii?Q?WwdGYN7qnA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161e5194-d696-40f8-8212-08deba0abeef
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 03:07:25.0895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNG+QgECL5gvCQvtRNWzczo8ad69n1TnphhiA5eYKla8B8lZ2zlyLYxmBLkD6LSS1XxYe/rdtCvE0uV66nBGzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10829
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

Use dev_read_addr_size_index() which supports both live device tree and
flat DT backends, avoiding direct dependency on devfdt_* helpers.

While at here, drop unused 'node'.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/pru_rproc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 9aec138637b..b0823bfd22d 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -421,19 +421,16 @@ static void pru_set_id(struct pru_privdata *priv, struct udevice *dev)
 static int pru_probe(struct udevice *dev)
 {
 	struct pru_privdata *priv;
-	ofnode node;
-
-	node = dev_ofnode(dev);
 
 	priv = dev_get_priv(dev);
 	priv->prusspriv = dev_get_priv(dev->parent);
 
-	priv->pru_iram = devfdt_get_addr_size_index(dev, PRU_MEM_IRAM,
-						    &priv->pru_iramsz);
-	priv->pru_ctrl = devfdt_get_addr_size_index(dev, PRU_MEM_CTRL,
-						    &priv->pru_ctrlsz);
-	priv->pru_debug = devfdt_get_addr_size_index(dev, PRU_MEM_DEBUG,
-						     &priv->pru_debugsz);
+	priv->pru_iram = dev_read_addr_size_index(dev, PRU_MEM_IRAM,
+						  &priv->pru_iramsz);
+	priv->pru_ctrl = dev_read_addr_size_index(dev, PRU_MEM_CTRL,
+						  &priv->pru_ctrlsz);
+	priv->pru_debug = dev_read_addr_size_index(dev, PRU_MEM_DEBUG,
+						   &priv->pru_debugsz);
 
 	priv->iram_da = 0;
 	priv->pdram_da = 0;
-- 
2.51.0

