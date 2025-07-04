Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36433C8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 21:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DECE82FE1;
	Fri,  4 Jul 2025 23:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="4MUSDt4V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84D1582F30; Fri,  4 Jul 2025 23:00:02 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16DDC82F4E
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 23:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1AXy9FiqxF219sLPHz9txKUBH6YhWMv9oeHecftXdXo1MmtmdQYTr1mvtzaHbLp5TwXEnt2ETuE8esRIpj09K362klkBW8J3iezcTiHKNNP3qYjXc5264gr1dd20eMwUzO0yTzXToggf2wH9PEIsxv0bN94jTQ71BUBLFrX7xbbF374s/ky1BL85sK6riX6zQkl+ITERbXBfnLKDqdKIrF4SNR18mJ2eyVK2piabRqkkUKg0AFzBkrrBiS6l0kl1plG6mkTDd8iyE0CtQcriy4sQ3Yf/ABPQjwabYqnKxGRGAvBOjMN8JY+f+RFd5JPP4mrd8aekctwFlp3CwIddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyChzFLZC29KBElQp4cEHXR/VzCocTaxMXRbgp+VHpM=;
 b=ykpYgPs7Z5xrRgHSYh/D6prb1kLvhUFS4TubocxhS+4YCoRnd3u54YpG6yQLhr9PzPMKRo6b//G0FKGfSYB2dNpOPY8LO3Ttg+W6n311KIVw1cZIz91TxErL5PdEU9UdpJcNkbTmzcpn2VLhgq289efyPEMDj2PzKiQP05myajQboRVUYEN1MGqqlS/QCBFnEdxElArb/0NAj4UcuYh1vb7L0cAdqEygdS2ni9vFcNL7DLHCkezzmLS7fdmoe2mLrFsLWuSzPOwKJu3xtDhc8d+eCAtJHL27Z2397jsLl3/rSp+ZYQlSVpRi4JzWvp+0sUyY8jrDtwr2qOY9C8dlbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyChzFLZC29KBElQp4cEHXR/VzCocTaxMXRbgp+VHpM=;
 b=4MUSDt4VDYtkf4VeTLq0UgIiREo9zju6jE9h5SMj3vXXppGdGZHtywlevxEBXfi9rqFyNywcyx3G9baZgfcy6Hn3z7LLuUJ6vEz4JoF1gR6T3N1HZ1JBXqEXIhWTQ64TBBlP6tjSBD01qnMs2od8s0O8D4Q6WeJt5+SWKd+3UPLlMJ3xrWJ2q4vx/2AHb6NGMhSXnuRWIOVrD+qhpzkVuY1Q54FbPu2r6njen2ytDCDUDlIW1sI7aLiYAuHhlRq3hWg1S/9vfngY0gyKaQRGN/naWkkFWwpKe5dDd6K6RpvS+M5cwXelmV/J5o7YxDQAuvWW2aqaL0ThLFZgiWCfew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB6342.eurprd08.prod.outlook.com (2603:10a6:20b:31a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 20:59:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%6]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 20:59:59 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 4/4] drivers/net/airoha_eth: enable hw padding of short tx
 packets
Date: Fri,  4 Jul 2025 23:59:43 +0300
Message-ID: <20250704205943.1398968-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250704205943.1398968-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250610072924.1066329-1-mikhail.kshevetskiy@iopsys.eu>
 <20250704205943.1398968-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: a10fcc5a-b613-475a-25dc-08ddbb3dbc8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wA4dvEkjsVuMsemmNS5eip5Q4VWnPvChaPuE+d/FkhC1wphDYVlQC+cQq8W9?=
 =?us-ascii?Q?ySfq2OAhjqPETmmu4//rhl7mNP/+IyKGH6ZYvnHEkajCdqsjE//1QUIYXwtO?=
 =?us-ascii?Q?z+jwn/Q8WGGBBUE1QOXJqIurqGoXGkgbaKK2ODDATj76Wp+IzfhSqvncaQRW?=
 =?us-ascii?Q?ZSA/XJkMfBjp+divnvM3IdTuE82tH2yFAdZvLGFxUgLLy6Ut1oDG6R018GkM?=
 =?us-ascii?Q?ov/qhRyqFN4OBGldTmB7N+YlRjaRVmRYuMERjFQMarOa6odgzneeqCHVfb5n?=
 =?us-ascii?Q?HYlPOlGeRyoK6r+WABB+1LG9Wbu7V3hax9UsdcOPzGF8H7ol92aGwNxdgk5c?=
 =?us-ascii?Q?OrTcZOaiBTLWxi1qW9NEMQC+e3FD7f4mmUb6a9etZEgl4mrzeXUMQP2dWk17?=
 =?us-ascii?Q?9HoSp7+UL9aB5MepCgufsoNv9gwngvw01ePEzz716zFwu4H8IFHkiMdr5eFx?=
 =?us-ascii?Q?aCoHP9SeGiEjBrShPL5/b7xM3ptaEmRYQpP0YwpTJlaFH504uy27m3WHV/10?=
 =?us-ascii?Q?VInOckUj+ndCKmywatY37sNC69FuEUEKREcHXp1S3MbhavH8TElw78OV01vn?=
 =?us-ascii?Q?GnB5IcerZzN7oGMd+ScH6nDBe0y2Q9me3LBY3Ids7sjLcQq50nxxIMBhgflW?=
 =?us-ascii?Q?Atynu+7TBMl7Tyhhg0+5MCUo9wdhPVFAC1CGrlI2HT4XTViAQVpUq2XC8bSC?=
 =?us-ascii?Q?V0zc2+W/DNznD0syL8mAd8mFB3eQa4wnAtWtxqbg92SVbyrTLIdpvKbloQKd?=
 =?us-ascii?Q?mLKp8yfZpx6ZA2I5wjeswbYdocgnQmpd+egUSrIa/JCxersoXjbFP8Dqol+5?=
 =?us-ascii?Q?DrJbkAmzmQBqJrkHDbQy4f9JmcJmLrwOKqjdlIYhc4lzFXPjM/yBAbFjZ1nJ?=
 =?us-ascii?Q?DaagqAfiv5tvcu9qZbueGS0XMLoPj31jmBFE31U8Xnf0sIxueAsvjoKUf5+4?=
 =?us-ascii?Q?QwI8u6+cLVGhpsi0ixajjNciim/UesmRWb7cfcrDFnPeVGflI4xI21K+wjYp?=
 =?us-ascii?Q?dzZpKvkWq/wfU1ysziOu3m4VQhfSOp14pc3nqZX3IbIeDBEIvJK5BW26wul0?=
 =?us-ascii?Q?oKWb4qlZtzhMm7FxRZRjZ+UWpzni2pIULL8CIzUDojZ9Wu/n1Xmnifcr8qQD?=
 =?us-ascii?Q?cMEXcRLyWIiBNqA6x4As2IyLCLqgU/2j1LVDUjhiKe3hIaOEcQPr6Ooflx1g?=
 =?us-ascii?Q?meRUK7eABHr4Ls99wLih7tIv8cDuFPkvqwnebRn57MroWjsC5/1o+C/g5R3s?=
 =?us-ascii?Q?6BIVlSSHzEHhnD3u2LBfWxUmZc4RW5MQoAlTU2amFd1JCUxS2VVLp8mC0FVU?=
 =?us-ascii?Q?zGXo10sh2QEIRt2SxE/h3vt68O3qAYvFPtshAnSI42pdNOggT2JieT1xmLLy?=
 =?us-ascii?Q?dlPkApVz5g9v4MUvWdpKrRtsaLPjgdMxk8BG0IIZXv/qAAc49TJlOc9nJPmi?=
 =?us-ascii?Q?b3hcTaS23y/BzaXv56LSqAohM8lPHZHvfof40rg4b6ghbXFRXJNWPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MZRrDKr0Dqf5/fXa0QPB6iRhUaRf791TBAcSY7Wu/rv8iJ93VA+WjeegoiJM?=
 =?us-ascii?Q?zfmnKrBwN+WPp0C1nm2YDIC+fQQwIa9ElxhEV+fPQ1YAJgYLd6dVgqeMYUqR?=
 =?us-ascii?Q?S22A4ipFaFB9eMysmNcL3xpu8PbsMNyIJBwkmTQbXJ8jYw5fGHRylb4ZEaiH?=
 =?us-ascii?Q?cnwT4IltoPbzEX4qqfv6i7QWx/uCueLnNM3amt6eA5XY6opPMOqLqrfkqxac?=
 =?us-ascii?Q?Jy3qQiTZQlm6R7jOKeuVj2gSzN5TqPTBOsXt8w/mVV8iE1+q7vYpgDWy6kyz?=
 =?us-ascii?Q?lirwrneQPP1gIu9nON+cSusLaXyqCOjL+rv+aVLgYlFtUxczL8gA6Rwp+rm1?=
 =?us-ascii?Q?f4AO2+P/CCxgmSn9Eo/pZ8MxOD2LlVH4PshedqcVVRZ3zpnFl7fbGlOAnUPl?=
 =?us-ascii?Q?bZH3pjNxxftvqhTlhNMQVK+ZhkY05ba2aXY9AlW2HnbvSBYpbUY16TD5yD4U?=
 =?us-ascii?Q?mIvafwzJSx/Y8/G5krxPyy5WUVc7UYWsLGP6QkxlG5HgK40DozJQqgENEw9M?=
 =?us-ascii?Q?QhYz+7JPy/dkLAo3GbnHLIIJd6gvCdhwx8uRZwyb+AbHRmu8snN1AGc3gLUY?=
 =?us-ascii?Q?4delYebIFeQJa27dTXbpwmaySfXthTqGkar2/dYx+a5KVSJmVNBwhbAtht1I?=
 =?us-ascii?Q?cRBXZrsm/h0CYrddhSsbMwhVAxRNsjM6YFZ1FK5NTfe2nlC881zShwCn8z4v?=
 =?us-ascii?Q?hgIfAdgP4K+Rjb5YnvH3u4DdiufA6xSPIAs6d/d4PKOzBFUQzEBOyGOws+Vc?=
 =?us-ascii?Q?9JGNwMeiK1TSiFJf06c1RvgSHjc9cyIxHvvbTi5gG08F7i6jGgLGYBBuBTA6?=
 =?us-ascii?Q?0upgBNyhlPNscVjn3xTisQM+wL6s92MEa24fApCZ8YU2UtQ3xvxmg935zxLP?=
 =?us-ascii?Q?9KBDxwLNf87qoAv4o1t+1C6SXpO0LlLjF8LmC2mGR41t/wiAUkSD6XSY+jx9?=
 =?us-ascii?Q?oSLQOjYGYXer9jCf8im7gwabxgZGSdibf8AIMUyRGdrs6WLbQ29LtBS3iVh9?=
 =?us-ascii?Q?sDwu7IzZbRsw8bUXyZozEJy8G3CBSOdyR5sbyYsYaZXgcAkcSem/LEGozKXA?=
 =?us-ascii?Q?w6ma5IiPypvx67WU9n2RpjkSnM09sOj5hb0sx+B4qLhZBqrpp27KBPJ1BxWW?=
 =?us-ascii?Q?k4jZHE+pOQTv3yw78ay55xyP27n2D+NX3ifyi6gwNirYsSIO2eMP75/QAWj7?=
 =?us-ascii?Q?TETpLJ54RGplf02lyq/ERcYajw+5z3dsS90gWku9k8Ux5DzEeEvuSh6/H9yw?=
 =?us-ascii?Q?rMD7BbYpO0L8l+UhDEYBm9f2MQYynekTX3qyv9tS92E534mcyCgkUQlWSYG7?=
 =?us-ascii?Q?AB3YV5GSzLNwVxUXfLHTdaOR8NZLlHKYrK1V+ZPJafdwERPepbLDADzsfjFJ?=
 =?us-ascii?Q?hBDHiRTeBF82vFrlmwpVeRM9/cvsd/enU1PkWBkXhhGqhGn0zIc6/30AuCjP?=
 =?us-ascii?Q?RwUpl4eLD73xU0gTFnX3DNeZZfy2+xULT2lhErQsrD9n9BlKiZ+xCgApKt7C?=
 =?us-ascii?Q?7yk9zRYtpgipyb8TrcNn8JCrJwMVTnBVJMyq9Ak2pu2GNuZYICJ40JkD8tKn?=
 =?us-ascii?Q?Na2fEAuvmWbvlhavNvjcOVDA/v2Pwh9fPtLG78KkLC9PCe0xI1leD2LZr97F?=
 =?us-ascii?Q?jeC3zgJCmFDVSfnsOdJbF8c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a10fcc5a-b613-475a-25dc-08ddbb3dbc8b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 20:59:58.9521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrZX03iq9L0BNpjJGGF4wnBxm/X3TTKsMRwezQWxj+luyGClGJ92/MDHiS+Fq4e2lpAcALQFoK7mqFjdnUVwWvdknizH0hxYF5zb7beVGC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6342
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

Transmission of short packets does not work good for XFI (GDM2) and
HSGMII (GDM3) interfaces. The issue can be solved with:

 - padding of short packets to 60 bytes
 - setting of PAD_EN bit in the corresponding REG_GDM_FWD_CFG(n)
   register.

The issue should present for the lan switch (GDM1) as well, but it does
does not appear due to unknown reason.

This patch set PAD_EN bit for the used GDM.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 477a132fb1f..6588eb3a806 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -97,6 +97,7 @@
 	 (_n) == 2 ? GDM2_BASE : GDM1_BASE)
 
 #define REG_GDM_FWD_CFG(_n)		GDM_BASE(_n)
+#define GDM_PAD_EN			BIT(28)
 #define GDM_DROP_CRC_ERR		BIT(23)
 #define GDM_IP4_CKSUM			BIT(22)
 #define GDM_TCP_CKSUM			BIT(21)
@@ -380,8 +381,11 @@ static void airoha_fe_maccr_init(struct airoha_eth *eth)
 	int p;
 
 	for (p = 1; p <= ARRAY_SIZE(eth->ports); p++) {
-		/* Disable any kind of CRC drop or offload */
-		airoha_fe_wr(eth, REG_GDM_FWD_CFG(p), 0);
+		/*
+		 * Disable any kind of CRC drop or offload.
+		 * Enable padding of short TX packets to 60 bytes.
+		 */
+		airoha_fe_wr(eth, REG_GDM_FWD_CFG(p), GDM_PAD_EN);
 	}
 }
 
@@ -830,6 +834,11 @@ static int airoha_eth_send(struct udevice *dev, void *packet, int length)
 	u32 val;
 	int i;
 
+	/*
+	 * There is no need to pad short TX packets to 60 bytes since the
+	 * GDM_PAD_EN bit set in the corresponding REG_GDM_FWD_CFG(n) register.
+	 */
+
 	dma_addr = dma_map_single(packet, length, DMA_TO_DEVICE);
 
 	qid = 0;
-- 
2.47.2

