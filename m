Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D175C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 01:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09B5888B78;
	Fri, 19 Jul 2024 03:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50EFF88276; Fri, 19 Jul 2024 03:38:45 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F6E88B54
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 03:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBVq5Fxdz/FCLqLcHBH32oaMSGcWjDYVsli3YX2l9o4egg79d8ZAwVo9dig61Oyb68bEIluyOTP7eBzzQVoBIFhgR1Xl7Gr4pAbPSv66oHVLMbvGOsiZNPJ4Fe8iWWTC+Jm/oBc0kW60nHIaDzh2nRaGTeIVdzDl1n3IkLKYcZJ7/Qhx1UNPxKQfcmY89tINZruYopecxnYO6IxovWyAazXsNkvYQk0/cebz7rzBmZyFW5TrYlRNaPrrkgfEjyE3fINnd0Vymw4tN4r1XWqRHcaPzndhiCv8lQsGmAOQsvglno2NnDcCzZHV5MTBuQr+NZ3E82kv27K2xPpeW9o7lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDdHzCQc5qDfJLE11ZEBBo2WEIlPcVFBVFDTts/pLlk=;
 b=SMsN+20jpn7/h0UD/rezkdnohlOWI5INyZynlyWQX7jCs3jNArVGMwZ6yHgp/5t7WQ8ViEw8iz3cUbvxsdkUbJEgwJ0skQCr3itn5wTYDmiJQ8bzFkiQnPuSRVlKw+CK/m1TQ1JF1uB5iWJlEAWWjxnyvE1JF3mi6jcfhZywoHb2fmxJ5TAS421MVSTXq+fvEE9p9j5keph+fR5GZ4sqVGwWQbfFO/vyx8id0v34x8eT7FADT8M7TTj78V9D4S29HtpeELlulC9jIA3RoUV2/ae/pMzEEmzwPHrkicRZPwcFdtihDTBu0nr6AhwZqf6Ibe21xaiG94lT0JyTSC5WHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.46; Fri, 19 Jul
 2024 01:38:36 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::bd9e:fb57:ebf7:9d71]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::bd9e:fb57:ebf7:9d71%4])
 with mapi id 15.20.7741.046; Fri, 19 Jul 2024 01:38:36 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v3 5/8] pinctrl: starfive: Setup USB default disable
 overcurrent pin
Date: Fri, 19 Jul 2024 09:38:19 +0800
Message-Id: <20240719013822.101374-6-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240719013822.101374-1-minda.chen@starfivetech.com>
References: <20240719013822.101374-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0623:EE_
X-MS-Office365-Filtering-Correlation-Id: c27c1fca-10d0-4586-15f1-08dca79381f4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|52116014|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: z7fMsnsJct6gW4g+gwtyOBzmzZLnGC92ejBU2+rJfQbwfLIyD+97B7Zah90+dpg6VzRiAeuPT53DTYo7CoSuEPX0eXj7tZKAuafPzGZ+E6Y1Ktbp2n1D6qp6T+iCZaTqcefg/37kq/alt/YlXNnh+UMT+jVhPMzY8iqOPZewRNTf3KTURxXeyHm3VwGTNRppCJ/u9RNoQpBFnOEbNVmA9PVx2iNvGT7tPGNlnEeH9kcqmv2qAap2e/fXp0o9PJZ2X5FUdxllpcXwQJIr3DfXuz0667ivrO4BV91RjJMFyKTzeMnykJGZLaXQ2nrDWh22xOdXxCfP5gwCikAQNQ0xLlRth1AIky5peY4HsqyAnnd0/oBmG5M/jc5Ls881YrgnF7EuG+Hws3CFFgFcw0P0JgQgFT4IJRRYoKjeLtJO2Pg9Z/JQRGGoo14sdugJAsPhSRIYUnU4EfJKL4BDY3/3ie/iQ0tzrHW3nDZMteF5ZjPcq1CTLiGHZNIMXXxxQJ91B57XzzfzAuNptcuI9tqE5ZxJXkgsSVayvfQ69Kr3tcOUiJ6NJ86mK1Rce5R4FxfzMTrNXDdvyLM+cOIbW4bUH/UPVZW2J99ue1os2LjTIFngvFCKkUxTyzh0s5O/cSUdpmrXPIr/8D4QShTGQajiDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(52116014)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BQYl/6RYXEn+bJpJNvcQM2MzeQVj6FkZvHSF4pIuiA0MMeT6KO82RL7cIjV0?=
 =?us-ascii?Q?7Gja2dWWI5fSjzrPXDvSTN5sG/P1q+D4oUY87quHElEVDytMY8+FHyEhKoOa?=
 =?us-ascii?Q?uxNzgydOTFZ8s9uLN8Pq7oQ+ErHG1ZbAwQTC+z7nqMcxdvpAmU3vDxD6Mg8C?=
 =?us-ascii?Q?/I0VkyoQbwc4nU1F3Ifuh92G4eOFJRXpKQXNAXRB4682+zS8bUf+iNNwz1bM?=
 =?us-ascii?Q?y1XalaeZkRRTV+Ol2nfKt6WmLph5OGgLAcmf2yHjbbzdNQlaGp9cHbxgcOTd?=
 =?us-ascii?Q?6+y5dihTkPunrAcctRWZ92EKOmsOjhg7pEF35W8MyEISGW3RADZxXCh+lgdT?=
 =?us-ascii?Q?nLGf6o3+zV/N93y93vQqLwDp0BQ/jrjdk6OBWkR4YPhx/XEJ2pv8FNfnqtcO?=
 =?us-ascii?Q?MWXh0zV9JZa6lGUBt9roIATUFVlUM7pQpmpAn5t/e4gdMcVd5kLhms0Am+Wh?=
 =?us-ascii?Q?juf4mnrty4MSW5JRden/byuUALcWWmBgABYt+57Z3uoXdTBhNw/RwXh44JSO?=
 =?us-ascii?Q?VV3tvY80gER6ZgmT+PtDJGma7puz4HSNEt4kQglKpt4ZPZg7bQOv3rwh1IfQ?=
 =?us-ascii?Q?syUTjF6/po/tY9MLPhvcRRg8+MlAl+ECgQzyiU+axTSUZTC9gkMsFYc4/2rP?=
 =?us-ascii?Q?+PqLzNMxPKQm1VQlorrfO/cmHvxY5SZs4QCkE1ektIKB5qB/1z0/I3SyKCL9?=
 =?us-ascii?Q?+C0me/K/dILjamqzVU0j48Mga8uXBNM62BP9fkLu2jmBDDyw9+yCvuO8vRkD?=
 =?us-ascii?Q?xPv4T+Qe5uOTyco7JINZ9MrICbD8uLp+gtlqZTny4ELCckWiL2i7WftZREst?=
 =?us-ascii?Q?coxj4bpTJtpZ/ZGZIvlOTzH42JJ73ZOVC/AXI4wN/DR77CgzLX5vLJZj5acT?=
 =?us-ascii?Q?F6uAWLESdPyyLIJ53ndPn6kOA/npn4WZRJCDxqZo2ya6iHEgU8v0nL8MLdPM?=
 =?us-ascii?Q?342GrbnSEq1wzpR++jlLmA1cAkIGGuTEX0psCM6j4tO+DJWm1jQeAihxoPqD?=
 =?us-ascii?Q?Hex3tjVsABqNYVZh5a3ur8+OjAkqcDk820AO/m6zcYlHyZwCeqnZBzaoCXfZ?=
 =?us-ascii?Q?fHYGLfeLM/WXv4XAnJlxa6MBPug4IM39HkDByK0s8+uRspTcudKUmytfdNXo?=
 =?us-ascii?Q?/E60gL0t1a9B0IWeMXfLAMwyhm4ao8F995lBJYp/9tQZpeVj3rdGg+MhN8X8?=
 =?us-ascii?Q?3F+1NryCpLJ8ka2w0t0EXqeumU6m18JU7Hrf6pZG0onHb6R4k0U86NrTKmDs?=
 =?us-ascii?Q?EJGrw7gh/Dt177IUt00T8GCGwf49ZM3nc7Q5ahyaoMUIUMvcW4/2Whihzduc?=
 =?us-ascii?Q?imq+zG64l+W2gCtSL8HGnaSnoCEr8dJh69m+ukfoEkV0V66Pj032khDJTws4?=
 =?us-ascii?Q?W/CtlOalhuV7G6Un7h/5ztjsoA1vZ4CAipJjnSBBDoVW0i63wKewDRkvCvuU?=
 =?us-ascii?Q?0Pu6wlW2G5C13is8AYohukt13HsySen5kZPf/oRz2EXSm++wb/OsoXAaztBY?=
 =?us-ascii?Q?aSU+W4tS7vUamiLk6PU6SMsTYk9RYoM4qjqk6fM2Y6XMkRRW5EU9F/9lKguk?=
 =?us-ascii?Q?iaObNkIHZoWu85gfEAgp9chr/3t8DP+jvocmPE5kyjfEU0U3JDUzJjLvSU90?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27c1fca-10d0-4586-15f1-08dca79381f4
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 01:38:36.2859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoai5b8EU+DZzDJlaLAdw1nRDNCGqKiTDcFr8fM6h50tZhexQ7Ekp713syNI7nNTU0UjCNhurkn8KxmNpTghMbVeHUv5uEASTm+8+SVLTz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0623
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

For some JH7110 boards, USB host overcurent pin is not reserved,
To make USB host work, overcurrent pin must be disabled. So set the
pin default disabled.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/pinctrl/starfive/pinctrl-jh7110-sys.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c b/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c
index dafba65eae..1102985ab9 100644
--- a/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c
+++ b/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c
@@ -378,8 +378,15 @@ static int jh7110_sys_pinctrl_probe(struct udevice *dev)
 {
 	struct starfive_pinctrl_soc_info *info =
 		(struct starfive_pinctrl_soc_info *)dev_get_driver_data(dev);
-
-	return starfive_pinctrl_probe(dev, info);
+	struct starfive_pinctrl_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = starfive_pinctrl_probe(dev, info);
+	/* Set default the usb controller overcurrent signal. */
+	if (!ret)
+		clrsetbits_le32(priv->base + JH7110_SYS_GPI,
+				GENMASK(22, 16), BIT(16));
+	return ret;
 }
 
 static const struct udevice_id jh7110_sys_pinctrl_ids[] = {
-- 
2.17.1

