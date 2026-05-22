Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AB7CD5BB1
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 07:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7487847EF;
	Fri, 22 May 2026 09:53:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="mwcvCfzQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3B838483E; Fri, 22 May 2026 09:53:11 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D816847B0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 09:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NafyRey6ORVy1VHmXWlf272OqpqAOQbIah3nEucduw6z6ulPBiqC72c1CSPXi1RFn6v56lh+aKy0GMzQ17jPRUHdO3FJZl2p0UiAS+Jz7WRuAfpblzRKPaJN2JImL/yICVRDpfGHC2G7J5MaYT25iRejOihD+mGsYpcLan2Z1DkW7dLs1aIpBgsLcN5Gpp3E989J+liLkLnZnF7ILOAQdVxQzuYv2/Ojs3gAuRv5Hvmi6wFHS3OfjOV2TYy+nhu17PKy1eprS2mslTDkNj+WUD68EoNxRkuPIRI+nlmjr8LbvyNjlqz7gH12jakyJga88D7To1UGuNFGHbh8Y1G7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qoe3EV7ClbWZ9WMHb+SXOzb5km+dNkcHVC74AWL+PfA=;
 b=SLcq4N3fAA9ILwRrM2HczrzfFG5MDjYEohzay8xPx9WQPkjdRFNHllrojV39WsjVbIRPoOkvHyKOuEdxa58X7Zzk/3vuZruDzRyw1QTWbjlhhffTWyYti8E2MFHURvfQimmpjAXjpo+qoAwXNWvZt8xf2dnKnPr2kCDpSAZFFQHP2E/iNHThbTN1I6RCEtx30pbUu4QgI+/L/1GlvusrisPb86ukJTbNwypw6CA+8OMhyMB5X1kCMCX5Tr1W5MMCkqea6iR7/CZOm55/tqU1CJC8zIM08492POdFaxfZYbOfTvjOHPIzLjakKZ1JGPeYJuq6WBN4BBSvWlXqgcXhEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qoe3EV7ClbWZ9WMHb+SXOzb5km+dNkcHVC74AWL+PfA=;
 b=mwcvCfzQr6tpGfrHX5CI5IKtbv+ZD1oZiUNyim3Gvk7DTMPxs+LwPhBlpD4XJw/xNhzQiryoNroADRa/QjyNKO0BDVCrnUN85DCaVdmlx90wM0K1TVKTEEdFormX5NUqwi4DiwN+YrbqBEjTkcRcR01OG/g4Y6c4mTpo9VYgx2MosVGM/VOEjhpK1VglsyxaZ1B5n3UspJgpA1FyAe/gDBL4BnOB7s0UhzJ4e6EJLrRJP6X3+/IuYTHAjzUkkA2sR51q2UAoZHo5tREohGp1T924/N+j5PXxXpLAlZh1j5HKn94OX5LZr33bne7JQmkTZ5C6eMD6rkL2WYpfKxRAqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by AS5PR04MB11347.eurprd04.prod.outlook.com
 (2603:10a6:20b:6c6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 07:53:08 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%7]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 07:53:08 +0000
From: Ye Li <ye.li@nxp.com>
To: lukma@denx.de,
	mkorpershoek@kernel.org,
	u-boot@lists.denx.de
Cc: festevam@gmail.com, peng.fan@nxp.com, uboot-imx@nxp.com, ye.li@oss.nxp.com,
 xu.yang_2@nxp.com, jason.he_1@nxp.com
Subject: [PATCH 3/3] usb: ci_udc: verify all dtds are inactive before
 completing request
Date: Fri, 22 May 2026 15:55:12 +0800
Message-Id: <20260522075512.1291485-3-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260522075512.1291485-1-ye.li@nxp.com>
References: <20260522075512.1291485-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0025.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::15) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|AS5PR04MB11347:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f162768-0d53-4de1-38e6-08deb7d72a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|42112799006|19092799006|366016|38350700014|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: DNNXCn0UXp8GQ/5XQOa+YKjOZtrLzZKhoVPzx7XaHwFCqEYF1u9oaQbV7sfDkDnHvZP4CJ0cxN+ScCWQr+awqLOFFEydHeN375KBbb9qNvnTuPoxboSak205vaYVXnIn18j5f8XKGqUocJ1BUWepLI17jStyMsapqljwslQdxlP88/AxP8qpVgDgEPIn9q7ReFB+ZjlP37tV0tUYKyTj4t+zvZG63GujAW4vYhAKVH/c36Q4dBy9Z0dLUh1GwG7HV8RqJBoCnZqXPA+UQK/qcPWBGtKZzLKAMxhVV4sNxz8WkIntFfIf6hAspQt43XyoFctExNjgq2k0a7sQX0uc3A/rRReeYl0UTVhnebxfK4w+8r77oGFDb+5aKTCeiatMSqLNrmCelsMYAYtGzqDMNZ27T+GocRxvGgpSKA2MowdgyfVidf9mDuqy6WWi7qItKBSXvSW1evCAheeJQw2C7Uw/lq1UqVu4iR438L7E97zJQm77NA/IcHea8VjNIEj9NZLYuDz8nX/GpOkvgf1kMl51sRW+t6ZQsWaAEc0f1nvRynlG5AcEOFuKTS3ZAjRUtw9zMmVcoaf4HEmKC7g0k6+Ixse6PsYv7FOPXtMlgHZ2ne5i/2nzdHx8ERM+eQJPgufO0K2cuJh3VCMvhVplGXITlOSjdVQlGXmzm1DW27hY6hQEI5TXHmRuP10F3RrOzTao91Jla3gzr/eOMsyyyR0wPkr7+uecjwe0uZgulQMjlniuy2iLr4BK3dbGejXT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(42112799006)(19092799006)(366016)(38350700014)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bPiuO3WrFquz51uNOFBgSrVEDKOCB4cBM468mt37QuEndC7v/QiCLPiy9Uum?=
 =?us-ascii?Q?qJudw9HkXI6Q6pVPP40ANJ3ONkDFF4WO3HUSTYKFAnrXx/vh/0mziEkE6vvF?=
 =?us-ascii?Q?KX9vZvV+IKpeO7MTes1DsiI9hkAl57r0vVjTJmcTqHdQKAPT06VE/l1SHfvJ?=
 =?us-ascii?Q?kq3dbNFP2qYDgsQENf7JSuCo6zJ1VNsY7n0wtrU3+rSWZQyIeuAB5H78uhJU?=
 =?us-ascii?Q?wiErDri1tpHTjZhwp+YoBT7fhrS96clbNO6tQXKNbVX4wEn7Ox5pcUQVmGVA?=
 =?us-ascii?Q?QkVm4/Z389CUjbbDmufUo0a/hz2Pe5yCkCap4rnJEnheq8kxd18pSCYrYWAl?=
 =?us-ascii?Q?KOenP/TvcbBE3+PoFBWQvO4TnRKLkdS0kzkRbV8qRgKo+4gsDfk+PW91EVuu?=
 =?us-ascii?Q?QNZ7G0jbEc00mdJ0aGdqXX1dtxUI4hxIKB0Vu+XaJydHFihHBZIytaViQRxK?=
 =?us-ascii?Q?eToxBHTixsfQ9+weP9H+R+buEApRm9HY2UxUrembHl42j2322HomDVqtOrLO?=
 =?us-ascii?Q?hvoQMOOFZuCaWs+HXh62LtLPJWnoKdGR8nFokeHyN4QqifLEkbS8KvAS6lVr?=
 =?us-ascii?Q?HQRtTc3k3REPqQ9H5eXmPowLO9ul21PvqAHdpY+nOLlBS9Vcld/MlF8xSG4+?=
 =?us-ascii?Q?+uBjP74JN2EAuKBRP4pRKfDzu4V3OPsehvbFPuuxkm6+8gpM1+xvinIUyua2?=
 =?us-ascii?Q?voy3DhjGkIfG7qhN2EMary629UF2bSh/XmlAgYsZ/4z1k7v7kAD2LzEYE2Jt?=
 =?us-ascii?Q?iH//6FMyoZXRyE9Oeam7MCiIllPSJuYhVuZkLejHBCxX6mCa6ieBDZ30HQk5?=
 =?us-ascii?Q?VbBqylDbghgLFfsKiWPTgFM8WyiIJqDpIc7FQxU83uqPGKw5aP2Ca+u8tiTE?=
 =?us-ascii?Q?kdj7e3viVHXPYTZiuqdD5p3CxvQtueqdweg0S7APVrlPjAcKAQSYVZJ1iVWt?=
 =?us-ascii?Q?6FwfdclIgoLvyJy7Xw7RjofI4gJkCEfLePraajs2h5yzkDYhorNxS5c5Acm0?=
 =?us-ascii?Q?ZBAHW8KIeF3aSKbYOZe/Tr5TSOVbYyFZIvqi2EG2wEctz32ueSx1ZsjdYvWy?=
 =?us-ascii?Q?FHd0DPJ02M1mUIRXkdgjZxj6pmp+wkWJna5/BY0jZYMEKPU/od+E5PCAitow?=
 =?us-ascii?Q?QhmqZy/t9YtZ5hfek28wtT2Q3WHGrvYw+q+zMzcbsveJljFI0d8jjroTWeIj?=
 =?us-ascii?Q?Wwr1EKimoDPRV4qtNXSOu5cflqFNWVFkGGs9mFVCF10zO6bM9IbgzOWPj6oL?=
 =?us-ascii?Q?VHLTgGXm2QO8awB6vz9lq3Y+eWo8Ib3jEH50DHhGi+1ao2Vlp859+AAhu4MI?=
 =?us-ascii?Q?ylEY5r7oasQ6pfKsqpy3kW+xCwe6RRHnM0g1O5/KVUFk+kM+jOGvL6GntI+f?=
 =?us-ascii?Q?a2Qv37+XwONMu6FEw6b7/3piuRuD+y6UNgJIlakNk3lGLiECdEZXOMZwkaA8?=
 =?us-ascii?Q?HDAVVQCKdEdWXTihRurQVfH3kdfCUR+XPRr2941tGWFyskudnrqv9V+JitGx?=
 =?us-ascii?Q?tRgkJxxTq80OXXAx1oZUXM4Fw0woxZvEkTuqMYHqF5f6ryvC4/BHTV4Y9sF8?=
 =?us-ascii?Q?gLTr1vOUUdW/6R3SbrAiZ8K/LQDVZMy9f8eZZx5VFqPDexB3WH2mcDCyUFWB?=
 =?us-ascii?Q?BqG+3JnKskP0Thfl9b7TsmZNglFiuE958r/LaFjSxnOi9Uh+dZXRtXWarTfd?=
 =?us-ascii?Q?RdRVs4YD8FuVquUhtnTNdLiaF8nQjVw9lb+OLlZQSmdyBIpv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f162768-0d53-4de1-38e6-08deb7d72a06
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 07:53:08.6071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoXDOJikBWj7IQDpf7EUkjZpfgRTLF1byTBEDFN+WoKKJMXVbfmu0U+VOnD1SLeb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11347
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

From: Jason He <jason.he_1@nxp.com>

According to device mode spec, the ACTIVE status field of dtds should
be check to determine whether the transfers completed successfully.
However, this is not implemented in handle_ep_complete.
When two EPs are enabled and transferring, EPa requests with multiple dtds
and EPb request with one dtd. Irq is triggred on EPb. The udc_irq handler
finds both EPb's and EPa's ENDPTCOMPLETE=1 while not all of EPa's dtds
have been completed. Because ACTIVE status is not checked, this case
causes crash in ci_udc driver.

Signed-off-by: Jason He <jason.he_1@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/usb/gadget/ci_udc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 0baad83ef90..53796887dac 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -733,6 +733,17 @@ static void handle_ep_complete(struct ci_ep *ci_ep)
 	ci_invalidate_qtd(num);
 	ci_req = list_first_entry(&ci_ep->queue, struct ci_req, queue);
 
+	/* Check all dtd are completed, otherwise return for next irq process */
+	next_td = item;
+	for (j = 0; j < ci_req->dtd_count; j++) {
+		ci_invalidate_td(next_td);
+		if (next_td->info & INFO_ACTIVE)
+			return;
+		if (j != ci_req->dtd_count - 1)
+			next_td = (struct ept_queue_item *)(unsigned long)
+				next_td->next;
+	}
+
 	next_td = item;
 	len = 0;
 	for (j = 0; j < ci_req->dtd_count; j++) {
-- 
2.37.1

