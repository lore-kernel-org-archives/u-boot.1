Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09969CD11DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81E938812B;
	Thu, 28 Mar 2024 11:58:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="i2egMjil";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ED6787DE6; Thu, 28 Mar 2024 11:58:17 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72CA0880B2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:58:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBDwCNdg2YAh4o6wJ7nlB/abONBjvwY92Csw1YuIgY+9gXckjohED8y2SG9VwKcBZEITojTp+IEJx0+D5LcXa85xrJU7ChSa8aJ+6ggssm9Yk5g9MgPUEBR+knnKlq6EqLav65i16MC2NX0EfmFtQnezb3zJp1uLaJ0sNlW2yltxUmEufdH8wwfQnHVf6AAhZ1Nj1IjAlnGQwBemVYgfq+DrtgP75KYQBg4dy8M9pt368Pygz2q6VQKbnYeqBy1TN8Iwqno+q1qL+TTjtoBg9UqCFEoC7Cy18ou742fv5Uo20ZqAhY9ctaWZqGN6QwgEn5F8x4iq5/tU3oHuyJsonA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2TdLRrD3zSvCJSQ0hknFktQXjXztaYdpIzNnB9eCt8=;
 b=MqtsV6VbCcRXxmRuoA+aJIuog/NCl0fD6bjsPNUBf5UYRav1uFiGLgG2DKXSIIT7R6h+vJnH+UjsyvbAQfnKmRcAcooG7k01ffYrpiR/WMLjh4JznccoYrqrKjltcdFzI7FWKaViaea9MRA/zcd/ucepMya+QY/HcXK1l4fO8k3lezri2IVfa+BoaW7QssfEWqhRgGGY0CYCxYEK23hQT+ceziu6KxlD9t9EkSSMXWmWirjJqn9PXZp1CDmyx+ICV/XLcUH7m6tNP6xgnas+NSaBVphJN0V/RTy1hCaw5vVgYQo6/m/gs9miSiwMExrFYisN4uGBRDdMYAJw1dbwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2TdLRrD3zSvCJSQ0hknFktQXjXztaYdpIzNnB9eCt8=;
 b=i2egMjilLykeL7sJr9rz6Yl8AdMw9qrzG+yB9XcWRtmJQhtQyr4NUwt6JUTAIbJG/66O9zAaT1lI1aRbl/juRLod3p6cnRDyHaoSus7T+KvRf+FKrZcDVjDJL0fo/qocFvXK9psdjk597h3REsQ4iixV9UbAp1CiVxs28xvfyis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DUZPR04MB9900.eurprd04.prod.outlook.com (2603:10a6:10:4da::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 10:58:14 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a%7]) with mapi id 15.20.7362.035; Thu, 28 Mar 2024
 10:58:14 +0000
From: Ye Li <ye.li@nxp.com>
To: sbabic@denx.de, u-boot@lists.denx.de, festevam@gmail.com, peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH] net: fec_mxc: Avoid enable regulator failure
Date: Thu, 28 Mar 2024 18:57:59 +0800
Message-Id: <1711623479-62657-1-git-send-email-ye.li@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DUZPR04MB9900:EE_
X-MS-Office365-Filtering-Correlation-Id: f9142b5a-f22c-4fcc-6cfc-08dc4f15f70f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4z3auMv1HkLgEAlc/X5f7EN+Jrni6msEJZxVU2HZj37tA4Q1oUcnhodq5rM5TuYJ6D5ePXwJfMc7KsaJIsibOBX+IIwpiTUu3NMWx00XpxfX9oYGNGH7tEE79ClrJL8VgeIjed6q8HafwynugK0q+lwUzVykQyCffU0si70jI+Dc6/9rRiw4mFEBiGoHcGPpmBhTmPM1CFUG0mpLKuXr67k8n8lh1zQnnOKSFIvaBaMAi5HBxKNCu/UI09qvh/Zz8HXHqndhlUE8j1XASRuJsFBYdlGKD3sorMH+5qcy7h08gjDkcja+pTm042DJtwR2XxfoyGyIVXJxkf1EfLgmfkogtXeuw0ik57NrR1zqwa2CwEcSFV5/6qEeavmTk0AvRZkHX0xy17z+rV08bIm2/c1lf0MMTPb7/QqouXTRbHdDWrzbjZ86s2pGyZLBJK4etruTayhYgvFX/JzsMtDQHIqx9z41TfpCHf+EHXGb79Mn1K4ciol86tC1kvA0RM6YOBSgVpRgenbyP8D1AZxxVJBXgkxm8Hl0sr5rkXccphC1NrsuwxgwqTcQmb2dxd7tdcuEA0bzXowZQYPBMDB4jTLGqbEYgOFl9HDwrb2JGL7iFQvNTdosnXSr39nRTIeVJZBtsVMMwwfpdpx8kp2trbmWC8UDZrhSVAHqdGQcnEWBWFN9DAmXXxOKc2GXxyJqjiU4e2Tm2B3dMRBrS8pgT2OAcCCAfzxvQzs3PaOq3Z4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oiUMhP6NmZHWhDeZLuv0onGFVYDKjytn9dOjM/Oc6EPG9vlQVhpZmN2QZpBB?=
 =?us-ascii?Q?FHHYwOEt95l5dCW5SvH+U9xG9r8f7GLRv9AtXHoqe466ZDa/Bcmj2ArSxtum?=
 =?us-ascii?Q?39PYUI5rwsVeVu8Ubv8CR7jmM2GvFNKi91NvEhypRMXgVJTAx2vuDdjmGwdj?=
 =?us-ascii?Q?MqvvXtKNpLRoKNIy+H9Dyg7uucC9ZprL+aPKFMIeoEgLOIgs6U+AZBBb4qFg?=
 =?us-ascii?Q?+d2+QuitGnd/Po0aOFOjEcT6Hj/UstfCqQKk1orQQHTjDsA/nCAnrgkh4S8b?=
 =?us-ascii?Q?BdSPTOEf1W9z9EKxpHgp1fzcD5cxQHZH6fppds3ZLeGV8LMOA56PngVrbECg?=
 =?us-ascii?Q?QLNz/GSMvw0r9kf+he5pfNiNEjIruLPRAbex4Ugt1PPpRSvuS++e7JmyASgM?=
 =?us-ascii?Q?0btCeXoGdpXNS44qFu8Y0mOy7eFtZd8KGepFND4W4/8bcLN+X5r+eL1kADcA?=
 =?us-ascii?Q?g3D04k50aXK07FHEDAteibK0LWtwckRfgta9g6mx5iJropPeL3cBaJDIVLno?=
 =?us-ascii?Q?zuvahGTqw6nGCaqxIP5eo4AtKHzK/LN5jR6vV71WRk47+ludBQXr7uNgNiyX?=
 =?us-ascii?Q?cXO5kKrcseyI6zmoOkofPZlW+cmpFM3tEcx2kMafdGY+LbsFmhBTE6+3rH5z?=
 =?us-ascii?Q?qoysqX5tJEHQf/LFTmMbkCqJ+ZH93pVdwfalmzAYvWWO6ojxJqSy5suTlUpa?=
 =?us-ascii?Q?sh8ul7/ia8D840HNMY97OhW5zi0DeylCrjilLEiLA65RWJPBc+/rnp+D8lXm?=
 =?us-ascii?Q?5fWG8kL0C8D7GYcPvRdTQ59J0wpkajLkBEZAxuO3szsIAYXFwZjn6QuQz68H?=
 =?us-ascii?Q?/YrbEgQ4wsXMvtqs3cUx0fAW/1silrIZNScdx0ocW0Q8Y/HW15kg4Zi9YvGH?=
 =?us-ascii?Q?HcxkCOdoui8uJSO0hqIbq9/2AZWWXQ0vnWv78XNtBVETg3zMpu2othNjRYnk?=
 =?us-ascii?Q?WSCjbQdQYYVZQ9Vwcg97eqxi8/34r4de6oJ52ZXFqMjiCtR8S84tZv44vSUm?=
 =?us-ascii?Q?jMw78rNwLjkgZk2JZCPbzzp0yR3vVpDA73jE6nUcopNPDd+6fI+kFJVGUz3l?=
 =?us-ascii?Q?qQp8iiGJQ0pbgCNIT8AphcKQxmlXiJeHFQa7C6DV3YdC37H3gr4b8g7fK5qm?=
 =?us-ascii?Q?RUEKYBKP4gbzioVqVsEiTixtHhj62Zub3MRI5x1xRATwX0Dk1KP0LsjwlU+j?=
 =?us-ascii?Q?KmOO5Mq0GfAAzPPJR5XnGM0OUhR8GzhofavGYNXReSEPdwtPZVINvqiMD+Ab?=
 =?us-ascii?Q?0/jKZRnOiZwlF5rq9HHrQEae2AqQh/bfLHiCO4abQqNq5QvnIErEtIdSW2++?=
 =?us-ascii?Q?jmqLANgx/NnOgNW4Y6lpb6Xg50VYE3eSPMOx5+YvJAR3bHX3Y7GegWkb7QXY?=
 =?us-ascii?Q?Ao4FzoQtfhEMHE+eW6jVN+7S32X9eLixrdAd8hUuXn6YhIB6AzjWmHMpfEfA?=
 =?us-ascii?Q?S/kj4pqpDDUZGQp8oeSZSMCP3nWJW+f6gcsiP5zuj//EEME8DoB8czr8EM6N?=
 =?us-ascii?Q?atFrC5oiS7+4YMxXSZ2mNB6aazPfTWJTwHu+Ubp4o/E8+6HF7kAGg3sU/M0P?=
 =?us-ascii?Q?lEdcTROCAB4BoQdiJ5GrU3i0jOokT68t2i5GsFMF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9142b5a-f22c-4fcc-6cfc-08dc4f15f70f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 10:58:14.0403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Rp5D5VHL3jCmeayms6G+BWoSTXPpZRynanp/cIsZyKZz67zB9Flx08Z2S6fdfHI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9900
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

Change to regulator_set_enable_if_allowed to avoid enable failure,
in case same phy supply shared by multiple FEC controllers.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/net/fec_mxc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index ac93767..90af18f 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -1310,7 +1310,7 @@ static int fecmxc_probe(struct udevice *dev)
 
 #ifdef CONFIG_DM_REGULATOR
 	if (priv->phy_supply) {
-		ret = regulator_set_enable(priv->phy_supply, true);
+		ret = regulator_set_enable_if_allowed(priv->phy_supply, true);
 		if (ret) {
 			printf("%s: Error enabling phy supply\n", dev->name);
 			return ret;
-- 
2.7.4

