Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCDFC30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 05:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DF0E888B3;
	Thu,  4 Jul 2024 07:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7A33888B3; Thu,  4 Jul 2024 07:50:36 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 661C4888A1
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 07:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gd+MCcYQaJK5pjsapA43hFVLVUQulZe15DWXsESdsI514rLKOwK3rjPgLRfXRrJzrQfapD4Wnd6+G6bK+h+WOlLIbEtRZymwhLrD/INbztbgZDUqrpnUS+SOHHDNcyTqgexAPBvzbejtk0UhoSdD2BXzfahKVjDSMuC0t6FErunxfwkabfti9Xii/QiK//rNjE4tnzwycdNesDpp3t+GL629JFlm2QOTI4K6mOs/SmrT9MpXPUYMT2X8SgHGV9hFa3DBKXx7QKSxfhLgjsKi/yxhpLFi7s9vka4isTKyzNjF1Gos8EM+0OQf5eC22u0rNwk+Wd+DEdouVES0Kk3O7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8MQpOesbuWwC/BS+SGpdalIf4L5iGzSwGDhaQHOsVM=;
 b=gu/4sr2BMDLRt64NlAdK2VuX8nMLM502gszfUMrbz0PSXD9xenq3kBiZRU+l8cCuvBZDbIdrdk1WAXig3jAMEP71dHnbo5cIU/Zk4PsCvVpMoDGhLFmE/MoVBsu91wcEqbfwjf5gHfqIRB1MhnD4M8yQXrB8Vl+PEF0HtksiLkij6+kgzGzAXwpVy4oOT+wpD2uLHevd/a5zXBOf3s3TSx1FwEmyl4FTqtN3j6iV7Wa4ZY3/c4cauez8PiJ6YxlBxLbmiFcfAh9ylzzbk4CtutR/xDSlaaRklESAyd6lqNWKNVpq7o/osCsVm0SXfCoSZRjVgwlZ3WyC8WYHHsMNEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0766.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 05:50:29 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::358e:d57d:439f:4e8a]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::358e:d57d:439f:4e8a%7])
 with mapi id 15.20.7719.029; Thu, 4 Jul 2024 05:50:29 +0000
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
Subject: [PATCH v2 8/8] MAINTAINERS: Update Starfive visionfive2 maintain
 files.
Date: Thu,  4 Jul 2024 13:50:14 +0800
Message-Id: <20240704055014.55117-9-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240704055014.55117-1-minda.chen@starfivetech.com>
References: <20240704055014.55117-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::21) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0766:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b8ea57-7b24-4faf-2c45-08dc9bed35c4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: hl83XuMRuLGPYgK8hym6uVASC4jqYnnZY57s9vS+i8zRtlr0AwT1wsHo60z5NBPe2vziS0NJt6L+8FiaieAeW3vbM+dFewBYCm7RC8ZnknZd9V5jxnOKCAmtcUbOA7xpFGHA4w/G+dLBh+yVrG2bg9klF7oPi5w/UcJVpRs0f3V1OaFWekK6UHRJXe64cK3oGWdhrqxcomudYmUel13+fjh1OgSFXgwBeD7rxS7m8FkYF/6VcjLQBC7R0obCNRILmgrPFHJCaqMv6acgdpQPUbQJnHX8r9tVEc45+NN5lOV/eP7NuQTQHs8RQCbNoJDuMlt35492IAqO6A/LJLx2+FRVlC51uazzDUY44mmsog+HQ3r99mFpOu9iyaCa1ODEKgaW78j0vumQomu0lUbGp6HrmvuBRlY0bUIQx2zJTSOSM6WW9+FGry5CXwJEo33ArwKuuUnHvOkFZnPY4Y8+WXskmsxKAzkgCE1T2etMZw4P/EEK9is1Pkkq/JiypAoQGLfhqOzKly8uaxmbWBKji9JJ0sNcHqBqy+10SUMXHwhmcuJ2qUa6PfzPBJ0cF6sJF2UkXkXRZ2eawaGL+lgucJTKO0+/Qq0iwFcQmVwQJXRE5qFTvvAlHEM+W5Ht1vOCIwBI7hjvneeebsEIqtly3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(7416014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m4Y8qSpFH4qVPsZT3S3RWRv7rk/4PlIssTuaZW/j3EmYLNKmh7X23o+ZuRWV?=
 =?us-ascii?Q?RAhTxQtJK49YBpm/Q9TaVAZSOehaQCUZp4VuT3fsdhPzLnAfq+3yXlN/O6Ts?=
 =?us-ascii?Q?24ZNzVSDVlimnJHOBqaKzd2y8KmaF2WXjlSXclowKRy3YSYKPy95pB6EZt9B?=
 =?us-ascii?Q?1DwA8X0C3nTmzl4rbDfw+s4HS+cQTh7ty8ACshDVbmQPPO2SU1toTvMz7u7e?=
 =?us-ascii?Q?/bhrRsjB/LB7MhGJCPDlJB1mtfqVhBW2YCWggtpQkav24+H2NnudulNKCofj?=
 =?us-ascii?Q?CNedLk6USWjszbYRCSrKVQyzLxOcvQyBVAeERiN8qqDqRsudlOYNOl4Zg0MW?=
 =?us-ascii?Q?lGIBsj7+LLFD3SEw5ZlhW+OmnTtKj4CCEtyAnSyfdJuFfVVoI95u1uYxhJw8?=
 =?us-ascii?Q?yYM2V2l6PvJ/XLg2xzrBzUCKLi4tcTKPBp2pINn0TpdWKiNpSGW9vmvT/WY7?=
 =?us-ascii?Q?jOHXhXVqUa02yPz9OwcsimI0tBPJTEVhDIYSjfaaAZDRRYrW6LttubTy/TmW?=
 =?us-ascii?Q?CUk63u7QuAEuKC2OVC+m/RmS5L/0dAMqEebWW60bS+romAzk/u13NMXKGDB0?=
 =?us-ascii?Q?rOqXzAxLATJDDNsm5o5IgWIIC8y2mOdelHhysHGmeAUT/ADd0YoddBzGYIbZ?=
 =?us-ascii?Q?2rqMELdEMSkP9Q/cJGUnShUUEsUVisLOZ+DwdMNQc0Ce4+mS+m5EVW99M2Cw?=
 =?us-ascii?Q?zcSZC9QwTYWGuG+nqQcat5f2WNmpblVlDr4GfR6w1h2eI0D/Ucggv/dRR7Pb?=
 =?us-ascii?Q?aapbdqq5upjbxQ8O2cF/CjkCzN15NAIo2wIg2GSZs92bbpdtjBb3VmFEZWHt?=
 =?us-ascii?Q?8sfjwcyMXL3QXzUYdvL30uARNsB5v3bKPvwvnVVsY0wXJVPfIx6ISBrT74iC?=
 =?us-ascii?Q?XHPWtleQxfSCpx1Cdgfr1x/z4b1cNiLGwyPszp+fM6rIvw5AxaWW8LDFNe3s?=
 =?us-ascii?Q?SxvmlrGuCif3oe19TK6SonQPkHw2Qq2NBNr9R4OHEgpFnZsbghRdn6+wK0h9?=
 =?us-ascii?Q?6/Mh2bVw8U5DDG//HoaFO1VWSEiQpDbbY8P3H763keFqBuj4zm/6jsM6mn7t?=
 =?us-ascii?Q?pJillw+qf+sC9LcEEp5RlAJ4iTvGe7j0Q+h7ZlFUPhyrKuhSQmFCJh5CP8n8?=
 =?us-ascii?Q?CCO1Du9VKcS1W8P4ufmQAhPYBFVfAYw14wqnSk6K3m8Fzk1VQ/aUoMeOo0Y3?=
 =?us-ascii?Q?wYMuKqZhNLh1nfGlLrn69j1Ce65UbzPa7bSloSQLO3Ft9GRhCOs9L1lBdzqh?=
 =?us-ascii?Q?bSCLYVqBAuoUsfSl8UpgUE9f0GBjE0pMBP1AnWm0t4Gj/d6Go3YxsRtZhUIu?=
 =?us-ascii?Q?Cl2713OB5DYmt7lFZHDm+bQhHBYZ1j9lGgry4M3lxiJYkZMeLzVQVq1ZfOYg?=
 =?us-ascii?Q?SVd5H+XHbHY4sWakiysseYnaydVqexvS8MfDNaVFT/pTvJHXmQD8fw6L4VeH?=
 =?us-ascii?Q?U8QMHBizumSdsy9d8SAp8qfrm6/P9UVi7F0Iw5noOw1tmkBqWSo78IHjt3gQ?=
 =?us-ascii?Q?9jyRfS9f/kkB4Bc9sPOM+7MVbknnEH06qY32qHi2wjH33M/NKG7xLHyHOQk3?=
 =?us-ascii?Q?v6UdG1y60cAzDK1wBuqG0Zet9ZhZGL6F1HGX0Ebc4D8PVVn/LwZoTn8iU2wu?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b8ea57-7b24-4faf-2c45-08dc9bed35c4
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 05:50:29.3047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thL47ufw4399TKKDF9HwqJHEpWlDzR8h3OtzK+R4aHiVc1aJSZCRrLZ04lTrywx8+iNr4bXVDJn564UwfOhq5Ly+TrcHt6bNTiNUrgfpbn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0766
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

Add USB related files to Starfive visionfive2 MAINTAINERS.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 board/starfive/visionfive2/MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visionfive2/MAINTAINERS
index d7f638f9b4..1faf83f581 100644
--- a/board/starfive/visionfive2/MAINTAINERS
+++ b/board/starfive/visionfive2/MAINTAINERS
@@ -6,3 +6,5 @@ F:	board/starfive/visionfive2/
 F:	include/configs/starfive-visionfive2.h
 F:	configs/starfive_visionfive2_defconfig
 F:	drivers/pci/pcie_starfive_jh7110.c
+F:	drivers/phy/starfive/
+F:	drivers/usb/cdns3/cdns3-starfive.c
-- 
2.17.1

