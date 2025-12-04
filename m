Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C6FD1CDCF
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FF1583D13;
	Thu,  4 Dec 2025 05:14:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ch0d7Bth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFF3283BB1; Thu,  4 Dec 2025 05:14:50 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B653583B1E
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:14:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVRIsnLQr0QiBgQBA/HZ3+JFuQrkdSUB8UQlFIgEi1v9FjaIddbUzPeiHMsiFB8E5MeruC305s634zVqj/2YRyVF1fao/PnbtUyuzUZJwargkhVvU7aVOcUDBK4PtIFY7CAWqRq91ReWkqPk771pUEf4I6H28kTW3AqGafI1R3sID86/c/xSITaR5xlOyemhOGuopz0ksOeYaVeBDNjost8+OoH+rBItP1OdZ8PfzSI1soRb22fU3pc/i2y+oR7/Epll6YojOP4HbOLn2NmGVbGi39lXKUKRk8AWSDqH6D7oifqNDCpSCZLuNl5QFq9Rj98DByJ79SdVqt+0GVMFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w34da1vU3OmfZdzmE7JdH8kQgy7IBvXg2QoSBtRjqic=;
 b=WJd/7dikbaHYCYYGWdlE5YcmyDNGOaN3IJxxEsoT9ecTSjRrQQUUrXezenDe3/Hn3GqRRuZsquXYgPu+s6FU7EPadzMiti0b5DbBhduo67lEnpecAvpxAcXEEbYYMScaeEBqMs68K49IVTdnjT9UBTcSB5MYY5MWB74MeAXTwjJOFXphZtGvYGkBTLOJJ4CqPTIneb0JWwDRVv+DIHzLyl6oCCbW19d7+rxij9lP8JPMbHWZRUNs56RY2ECrFwiNTKsglqq+D0mDy9QXEB0bUwcfGHMyplAAWsgUOYYKgZHNrksVJXzlLEXTfT2eW/qN9b1Wh2zEo9k0yro1DkuNZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w34da1vU3OmfZdzmE7JdH8kQgy7IBvXg2QoSBtRjqic=;
 b=ch0d7BthwhjdTqzoCU3PKmrOXN03gHgxB3/LtD3D3Ti/pGnILtkl68g2nGLAsVVy7oNzIWyYBWaqfYWbSbi5nqODr6gzjebv7HLitYPtzOzlICCx7QpQnwvQ90NwqsHTa7NZnd0IpH85RVup5WQI75UELliVn6ODZz4G9FVKfOzHR9RImtAeMcD52R+3mCe9QFQQITrxOIsyn0D2+ZO/UOPLjhQOe4KD6Bk+Mn/sK/P9qPgzzvNOSH+Ae4bCTex8W+rT1HkzxDMdSf0sS6YTtdIcBFXayvRB/sAAjBpyvjsf7PbSolAJv3s4Je8AYKsPG+ovsMzRJ66iThs0nE7o7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10009.eurprd08.prod.outlook.com (2603:10a6:20b:64b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 04:14:47 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:14:47 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <ziyao@disroot.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Markus Gothe <markus.gothe@genexis.eu>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 03/19] net: airoha: allocate string for GDM port name
Date: Thu,  4 Dec 2025 07:14:17 +0300
Message-ID: <20251204041433.3459826-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10009:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f6779e-bbeb-42eb-14a7-08de32eba919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OKAVCrJBjS6lHiCeYg19w66ao8sdeYFZoePt+MCtTGOnWaVkYetiyJWdLEnY?=
 =?us-ascii?Q?DNJax9J3yk0Mioe+MnZgekHc2xcXZ8+vSdIwg+dr/ysfcq+YyA0NEScwp+W6?=
 =?us-ascii?Q?oZhU2eZdgv6vMYrMTCbi7b8FzrDtUdKKDx8UajOVuCaFTyCg6DLQL7pqG7/p?=
 =?us-ascii?Q?nw7Val7gAkekp3lDvUUGgZe3VAnt7H0kLMLpfgXipUJJgKNtPxHSl18U2dtP?=
 =?us-ascii?Q?RI9dPmy4pI8B+8wB+8aLjq30GBemEq9P8KxgxK/gKlqdBwHUScy1Msu2SkYl?=
 =?us-ascii?Q?wD7RLy0EHTis1o0+yXg8KhQI/Qy5GfNWm8v3/MRmktTsG20guYvnIvLt6/RQ?=
 =?us-ascii?Q?1WlmvS109qesYTunN4PJqXWBrHxY53pYIW319ikSKK8ORx0BoP4j2k9BD3Bf?=
 =?us-ascii?Q?xwv8fuYte9BClMCx/VKdrt+4t/L2oGivaORkaRuEC455Wk8F8Dl7DFl3UhRu?=
 =?us-ascii?Q?geD8CH4uX0dcCbx+EtsVIIhtzDhmfIiJUqTKDFwDSfFjrxjVamFwY6TFs1cR?=
 =?us-ascii?Q?XGl6+MVl+s/0fI7J2kRAjuzrt1kDORB4v5Jx7XuKpuV4u1zpYthlhFNo99Ai?=
 =?us-ascii?Q?HrtvJWigm85tlxv0/zE1mrU/QEjh7WjF3HWV8a8rgcXtB+RkQjLYnnSno4xE?=
 =?us-ascii?Q?tsPR+GYxZicNw3o3/g8KOQS8dPa4xYBnRxHistn4ZocMTdVdOEIk9HFdsh5g?=
 =?us-ascii?Q?1AiET6lCNXX0RdRCWd6yeHsm9HcNI7rhvlRCnMKb9ixzWp2BP2fka1DxAcgF?=
 =?us-ascii?Q?iDYwkovkjLVl+CYquzVvcjSpbJKxx4sLAmtA8VM3AGoNC0DtoDm2GJErW4Ul?=
 =?us-ascii?Q?HTbpOSkt+3RUSxwpw6UXLTBJfjFW2uuggxbiH5n4nJAxL7xxsNPFA82HY2ft?=
 =?us-ascii?Q?PgCFWo/SELxYvpUQyaDDrJyLaPWtOSC7CQU3mo5QZTdeSUhO793x62yy/pK4?=
 =?us-ascii?Q?Q1bvOmqRfc2/Nb3Id35kS/T6YNVpc85kkXc7clLl2cJ/HD+5KHcwoPSno9pM?=
 =?us-ascii?Q?nN2oX2Bkz3pyf927g/+Afu6giJZs4ryh+0WPcjtCnJRfihxS2LzHbf/b4JM8?=
 =?us-ascii?Q?6EYcbJRzcXAu43k7oC+3nNM5WggQS6JFCPTQ2rSYnaouQ71B1ESpM420CRPK?=
 =?us-ascii?Q?7Lg7RkvFWBlQc37uM8QYVKMpnrmch/0RFl0WJHMeQyt7bji5FPYVWRme+OyE?=
 =?us-ascii?Q?BDPlkrcU1udPj878bHPfmQWmOJUPmrtE/nsnx0cO7o2U5monRW6t1A39fVfo?=
 =?us-ascii?Q?szXG7NoP79s9H/Mp/nUop4eOYvYd8EVLoAeEnWHmsUMpxF+6C33xxSaBMHYV?=
 =?us-ascii?Q?Eo6H7QNapELD/sj1r3oNfcaa6HYTkLb0o0QwiBkg2hRy2hP6Q2H0UGDxLKZF?=
 =?us-ascii?Q?40P2e3/aagzAH+N2+ohnhM4r6xUUgDQdQPfj4JX5XvzFuZ67L2DMD5JCi/OF?=
 =?us-ascii?Q?MM483f/yquOCGRZ3LcIHXJ1FlQKSMxQrVJfemlAE25LKAojKz2pCVyI5l2UF?=
 =?us-ascii?Q?oM0TYqZa99Lina7M602K+sckeqQZFjoaM2jvlUp4RdCGwuI7GO4b/cgGmg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?01+RaezgZD7fafMdOTXHjzriFO5hmuhDX3gR+CJzSAg6J/dcE8bizzu4fM/T?=
 =?us-ascii?Q?z63DfXLz3XLlAte8nVV2WnaRidSr2gwjNbtDzPe4KrUqIpvCey39lyNi4xTk?=
 =?us-ascii?Q?fKWEm8GRtmKsK2GaSJd5tVClE83GGjxMi+6Rk7yTv9oyWzE0+P5kOiluD54C?=
 =?us-ascii?Q?15hUFNEGIyB4v9vAuXrJPhfJBB5yuRHAKNV7Bf4y/RpbeoS7lnQFCweFdDGG?=
 =?us-ascii?Q?fySsbwYIBfZVx6A/LBd48p4CiHFkwpn439lWrcWyMtUH8WpjVbLf4jcQcFQe?=
 =?us-ascii?Q?l0wdbL+mRrQwZPTPSzndGR3DNUsByqAi/bxRw3zVRTH/mOktDhSPmlxyr8vb?=
 =?us-ascii?Q?S/9ANhkQkY+qAIQFRUvTRJeedqAfpXZzkU/c1+Ft1visspIERg5JeHZoldtO?=
 =?us-ascii?Q?lxrC7+mNiEROuEE9FYK0yd0L3rZmLlBtwMSo7AR9px1A93N17tfxO67p9+mz?=
 =?us-ascii?Q?dIKfWjIw7IqMsx+uqRsbRyE0No0UzpsBNcQeH4SMglRvTr2kh8zXSr3Wmk4s?=
 =?us-ascii?Q?kjtMHMo0EM0CEXeHFiKSSv1C9Pk5Wo++ji7GaJjeBADYQl2z6oSbh8UUVr25?=
 =?us-ascii?Q?tpUqWnHCejDX9LQoqQEelrcPR/zSJnsWRmM2vnmC8m6TnY2DpZoFtOhSxDo5?=
 =?us-ascii?Q?0yL1i+209QZoPSd57aVOP0aMwueCK6DEEdbSzue3qF4ykhX1lubXs6UyM1Id?=
 =?us-ascii?Q?d58jKcwYKOo29S0wocs4QKSEIBglFg3ahMcgd6DQTjMGfVZRxPNs6bZgt3IF?=
 =?us-ascii?Q?lsDCzMOEngaqIiGJvMtDTjfAvobQmAMnwfnGE0gt5W6N0+vQv7ECjyFkW6P4?=
 =?us-ascii?Q?un4ltJ/FsBXRjAzz7XqjIKuja69Fc8cYWCAnCawf94QzIjTE5NcOl/fcPDpg?=
 =?us-ascii?Q?tvVvCq7PHK6neV1ehU63ceCALk6UM8IlgEmVlvmD3gXnoGrXNWkWxvdRYrFF?=
 =?us-ascii?Q?hFQXhnM8ZIPZdczY20ZUV0d6Ok10QXZlGs/W68Hmri1d5Pc9zI9c/R77XEJ1?=
 =?us-ascii?Q?jV9DWFpiOXKkDuVKccYhbnxUY/WziIZjy/6ylHjArJmsFll3VXCXC6g6bjay?=
 =?us-ascii?Q?OB4OBRwkEaXdkVGad0EMEhM30x3wgMygrhlaMw0ewXRaOuOZJkn667DQsNAC?=
 =?us-ascii?Q?tFTuZGUD/xePHxOukJbeT/Dc4sdBbwftZADsPwQtE5J584ZEEGhujVbKisqk?=
 =?us-ascii?Q?bi/6afB33gqXli82VCevR/EmQk9MI3SHWBqCLgSxD1SmktyBhQDJzhAikbk7?=
 =?us-ascii?Q?vIJ7AsnAhE+y9eO0NXHJGuNAW9qkLGWeULa6fMiU2xD6L9q+2IeigayFHIty?=
 =?us-ascii?Q?zJUHdG0gYsLJ5vKSj+q4NGjUcxN8dBSixXafp+RSFbVPp2FjDRnlBcye2wvw?=
 =?us-ascii?Q?W2yqf2xxNvdw4yJBskwz4SqMw2ORvIjU/uZZ3MaXB0mnETvqHXEiGchHUxN9?=
 =?us-ascii?Q?FR8L0flyuvYUXZ32OunwZtKZ6azATQZyFnMuIcL4j6Jvhuaz0AndzA4aAQzr?=
 =?us-ascii?Q?jXmpTn9k0JBwwyc/aUSET+6GfpIwHzl6fkcaTJMxfuuViJgLlMWiy9K5YnKP?=
 =?us-ascii?Q?pJJOFB9RHmLUoyeDYnkC627pX89g3/osIauSwHwlHjGLvKDJmJc6alCg19Pp?=
 =?us-ascii?Q?w2XArE/ooWJ41ejpfHBrIm0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f6779e-bbeb-42eb-14a7-08de32eba919
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:14:47.0680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuAdT05Kp76e8p67AIzTMw//mr6q/1ezX9gPR46NWposn6FMB5fm38sIT5anN/g+9rAzRPnMg8YHvEZS7onHAQoj9ZleQozaAcwePcbLXB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10009
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

Allocate string for GDM port. This have following benefits:
 - avoid out of boundaries access to gdm_port_str[] array in
   airoha_alloc_gdm_port()
 - no entries for non-used GDM ports

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 31937137d59..900cea46264 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -330,7 +330,6 @@ struct airoha_eth {
 	struct airoha_eth_soc_data *soc;
 
 	struct airoha_qdma qdma[AIROHA_MAX_NUM_QDMA];
-	char gdm_port_str[AIROHA_MAX_NUM_GDM_PORTS][AIROHA_GDM_PORT_STRING_LEN];
 };
 
 struct airoha_eth_soc_data {
@@ -791,12 +790,21 @@ static int airoha_alloc_gdm_port(struct udevice *dev, ofnode node)
 	if (id > AIROHA_MAX_NUM_GDM_PORTS)
 		return -EINVAL;
 
-	str = eth->gdm_port_str[id];
+	str = malloc(AIROHA_GDM_PORT_STRING_LEN);
+	if (!str)
+		return -ENOMEM;
+
 	snprintf(str, AIROHA_GDM_PORT_STRING_LEN,
 		 "airoha-gdm%d", id);
 
-	return device_bind_with_driver_data(dev, &airoha_eth_port, str,
-					    (ulong)eth, node, &gdm_dev);
+	ret = device_bind_with_driver_data(dev, &airoha_eth_port, str,
+					   (ulong)eth, node, &gdm_dev);
+	if (ret) {
+		free(str);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int airoha_eth_probe(struct udevice *dev)
-- 
2.51.0

