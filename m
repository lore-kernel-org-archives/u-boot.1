Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF6ECFB424
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 07:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41BC888916;
	Sun,  6 Oct 2024 09:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GxXSPcLi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C46B387BF4; Sun,  6 Oct 2024 09:09:14 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFE3587BF4
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 09:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0jMi05sXh3SCBOQTpObvxlyH7Tsi4POl27Sxmhxu/eeoATEw0sO4C4wjfzaeoOvA22pRAo7i9rsyBwDl4xuyP+8DCQTSTWr0XHbOsQGrjBZ2BkOWGJ3F5wO99NOIyjZNFmFgPs4ECmfIZolWU+/Cxn2ldskut9AY4SmxJvPYUeZ9KTrlORVgToSGDMSQ9iIeCh9dYzQWTPeSig8amnjUq7pTldggCedYjsYxlRIGoT4QMVUKFkFe5kb2+QsvRQmetAaZdBSnibdJuWLMR0vHlhbaxCjgai76My7JL9K78nzOgB2cboqn1UdiD0gGLpr8gDhx23600Ylne3WQuJehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3t/DxQ6Hecc9nL5qTX0vY+oVZDQPLiAzXZ4TtBUgh0=;
 b=NZTM2dK0OBMj1e8jowJjabF7bYhrcaglojUUWPGm9+7HcE3xnqrUTYIXlyFalOzdqfh60HilhXyVXQJuoe6dVcnfjxThEdDGxe6psXiBw2a/srKqR0/Z1c6cIbN9lUgflu4Sp/7TuXblMzQVUTlDtVP+ybhOE9v4SChyDqpR4GjO8iepXJmEn4vo6VFoKnUTGlSeZ/z/RhVfNNa+Yav7XxS4SdatEIIWYa48K4l/nwizrDIFI/Hy9M/q4bXjVyz0ovvbefSSgFcPE/x6zsUMa2HyU5JXyLvqtKxdeJyAEYf+AHdoB3BRCfY3FeeWludD8/Ls9afGn3xs5HQjLFUAfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3t/DxQ6Hecc9nL5qTX0vY+oVZDQPLiAzXZ4TtBUgh0=;
 b=GxXSPcLiIBJoIAVPOC9Q/tDGl25M0Dhjqj/ZemaVAcJWDU3iRSnSaSu56P0v9j3+PT4zWA/MhwZ1BnnHxM/5Idd+pPkjVYTmfqckIhi7LWD9KSq3HjSnTZCA7Neu/Vwox/mMWHFoGB3XNTl2/6v8DQmFDn6xL8E+n9NwcKGwCeZqbCKbJEYXEBVRvO8GARyhyjGGGZuB5iMdSA4hUkTAFolBP8eR3eCanGoLt/15+twSArJu9qu0JCGrgtF5miTXtcw72Eys7Ia+Ek7sXSZqoLj2leR4OEly0d+BS7yIsjgNNqk+B3SlemvZ969NAKVNKAVi7v5JwHBy8yrIhtd6vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB6873.eurprd04.prod.outlook.com (2603:10a6:10:115::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Sun, 6 Oct
 2024 07:08:15 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 07:08:15 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, festevam@gmail.com,
 marex@denx.de, viorel.suman@nxp.com, Alice Guo <alice.guo@nxp.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v1 2/2] firmware: scmi: smt: enable doorbel return
Date: Sun,  6 Oct 2024 15:07:02 +0800
Message-Id: <20241006070702.2792392-2-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241006070702.2792392-1-alice.guo@oss.nxp.com>
References: <20241006070702.2792392-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 4894c772-2b35-4a0c-a6fe-08dce5d5a59b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1rGhZr/Jmz3SUia3Di+QMec+Zop1HDDclyGXc89x+OJZTdUDxrXXyZQmsGpT?=
 =?us-ascii?Q?90UQltdBT6NGX37v11orGpuC4UxsrbNOWSfGpRExCGDfLH4r02iIrchZ4bP1?=
 =?us-ascii?Q?vhaNHuRptNbQ1EDUuSs3vVpAP8qASIAkP/QRZYX5+eWRJMJTVXKyLc40Yjno?=
 =?us-ascii?Q?uIz18LIaz4t9h9bjW1P1MuKomkq9lKqUujF5Q+WO213pKxw5iDNuBlXdP9Ys?=
 =?us-ascii?Q?Y5TmTEFeKq99fsCGSgHwjyr/pqwIhiY+hG+JJoAmQmL8WnKG34cmg5Nlh/0n?=
 =?us-ascii?Q?cipTl7VVnpYVLISYqd2UAAI6mTke9TnAKFJxntx7uBMfwmPLnGzNP5RUcC9W?=
 =?us-ascii?Q?+Vqjvtvn6kmdt5mv+3NQU+AURbwWCQuk6sAwW6X6ER6bax4Y9JZXkjvVmoMT?=
 =?us-ascii?Q?I70TAgVrPjTb+PdTzHNs68B4FznpIrfJFRbEBEc3VGbGgx+puFW+TI4Cd20A?=
 =?us-ascii?Q?TVDbCOODVWBBmWx6B9Im9mVD62VChBZYQo/DJ9O84q+NX9X80CmfNL+gdG+V?=
 =?us-ascii?Q?Ozaa4pZ1QlVqqTqmCbFgbi6qPYiN3n31I+X8tJBQ/Rpv30kn8Vv/q2hDflUX?=
 =?us-ascii?Q?oAjeqxJUdC68tqr69frS7/XTYO3mEYDJCw7bm68TJcysDWM2KDQjSqu12DpA?=
 =?us-ascii?Q?7uuFrtdBcPxjfPOU5eu2aeGKxxLnv7TTmRjOuhf5DSOYIEy6I+QkSJkUkzdF?=
 =?us-ascii?Q?gvIvwJQR5PHhGfVrHgGLhp6yrDAp4p9PRb3Wc9VfTV40dBxKZIPQ0cJvo/xd?=
 =?us-ascii?Q?XA15N6AEKx5BRrAJo8P5Ub0hYl52go7qd8pW80IFpmYQ1TF8fNNdLdn6vmj8?=
 =?us-ascii?Q?aiGpmhYIqHrVDbY6aLRkEkVNft9Q6bSnRVpatcU3H9DV++nPxivEfsUSdWZC?=
 =?us-ascii?Q?VVulo5iMdXo8ax2LSqXztW0R6xumzH1F9G9iSeSpO/6EgwPUHP0XL9pg/KRB?=
 =?us-ascii?Q?4eDFuAZJNrMOIsoTmi9L5xMESpN1pgFwm9lueln32BQapyNLe8cLoQCtMDaQ?=
 =?us-ascii?Q?Z7Ck5XUM+az/kcSP6cX7nylU5zmQbSMDcaVrYpbPKpPR32KPXwSWAgKSfvAd?=
 =?us-ascii?Q?koSPj9v4f4+4epPNzvbnKPJ3c6aY7lDAobCkGMpLmzdaudadpYSVDKzY9Hcy?=
 =?us-ascii?Q?8MsOkWAT9BUbYm6NPPNjfznM/KXvzOom5bXwNL8cTPDs4Y8jV/Z4YlhRuMSf?=
 =?us-ascii?Q?nBB7DoKnUPC/V8bPq0/4kXUq8FUeVkZ0JzwYtwLjwPNVb/CSQu1moqshs0re?=
 =?us-ascii?Q?0+arV2S9TXbKxv6OlEzo7wF/Jfm9MLxHkpjwDTmMt+2Dz/6R9rRFLmPR0BF/?=
 =?us-ascii?Q?bC78Za0x29WUVOZ6mrQfkWFf9Ll8z4q/I1Lrq+pwrU/E3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6WSY0EDsdhiiWFCflfTIXx1ZUloJozXTw4BEwp5E5xOfqP2NFbF8L32kQFg9?=
 =?us-ascii?Q?XG0PjVU+WnrqdGrc3GVeAW7HEPuNtFqm76yw9Vk1mjlF70kGvHaEr+yRZPk6?=
 =?us-ascii?Q?qH3RK7LaiawkvmRQEPLPHY2qZICQTp5LgXKxaXPTNnK4WJBV01PPhGffQHYg?=
 =?us-ascii?Q?FRkdwiFxY48CzRSNtocJT4SdGdmTyy7sHBFBaVa/q9QHpm4dL3K9VaXd7WnW?=
 =?us-ascii?Q?Ph1jPozP0/aR20xrlhSduheRWzaE+ByjkqKyiXugeWyK7c/SFQZPh6pS0wCI?=
 =?us-ascii?Q?YyhZrYoTgYHCi0smrfgFQ0RmtAWcxkBdx7eGHlrgVo8alByO7j/Pw5lDTW5A?=
 =?us-ascii?Q?hcOr5g+KrxcPV6DEGVIQKsVNmn6Y6A2d817nadDoNj/TAb2CBwUMNnPb47eL?=
 =?us-ascii?Q?yCwBvrKm8eqdthxks5NFkyrf3xg63oZJuDxRTeyyKJ2EjGyJepMjkUYWMR1q?=
 =?us-ascii?Q?ED0ToRUUU0TChzd49zk+ZoIfO7QYgyjL2k96J6dRGFBzpqF28EMIQXCs1sPD?=
 =?us-ascii?Q?PvPx+7OlCzzxn6drMEYSpQ8nXMgQjMH+pCe3pBKk85wb9f19fH7033m+KY4H?=
 =?us-ascii?Q?d1WbGAfxC1JWRkkk7l/CoPhcTNpj//+HL4e3uN45qYUyNSrDQHyybIT3QU3W?=
 =?us-ascii?Q?XpIYrDAmtw/Ogzpf5/JPJeimvdoupGkE8uq1E0SiEPdif+l5K6GcfvELF0uf?=
 =?us-ascii?Q?VzqOtQFMd+4TfQL8mI7UNw642wAez5059l6BT58dQk8ICmcqQoHMu+4pnxMp?=
 =?us-ascii?Q?LfJunysBQruB5cRGI34AWxzKxzeDrvSVX8xrV037T602jFNJGlq+sFdl7k3I?=
 =?us-ascii?Q?lpUcqg9CbfW4z2rpoZ7JT1ecBbOZBiUBLkUzQ3/Qqj80U2IcEqrAIPZbqoew?=
 =?us-ascii?Q?HebdcO2ZIeu196qUVXKj0yRvFcrNgL7Ueual+xwE1bavAuCOGlf0KvWRBjml?=
 =?us-ascii?Q?p6Y9VjpX6wL6TaU0zIstsSe9OPf4RSRb0F1TIoOUVsviVhh53/MrA8BPetZA?=
 =?us-ascii?Q?kVIh4AiqYY9P/TR+Cpj5jKfMxZy55JT/ax5knl2dZ4GGvOMAJdI5zcGntdHq?=
 =?us-ascii?Q?dz3oGPoPFhRnmhsVs/3pT2WsLB5Nn5oN/SY5Vvmm/wHLfal9SAK/3H4m/qnL?=
 =?us-ascii?Q?pFapAYlAv25LMwUw7cFjM7p8mPFRGynBOVC2GEJNesz8Ya7pDgDlHVhPoOLT?=
 =?us-ascii?Q?x0SuRDvl4HD4MnrapJ7cZruQCAdZLpzFBG3KRZd51oifRfSgGqNXLLV0uV3g?=
 =?us-ascii?Q?kPHmiR3dT/dGBuU5vxyDterA+KiIz0aX+1Riw6IpUbZEpL+vD5T/DTwiyZcN?=
 =?us-ascii?Q?TCtJWumbxCTcrG942hzIqxoTTublXoJIE/cK79QubdkeLcRK8zQnzBYZX6yS?=
 =?us-ascii?Q?rJ1tnhtYCBXQurt4zNKBOl7kcSSPbnWiNOITH9Acv45VMpD+YKNd/6fWMhdA?=
 =?us-ascii?Q?V/W+6qojmbIv/5GHbnc34p/DQYizCWKUQ0LN2Sd/VQC3ATHWc7ABON303/h5?=
 =?us-ascii?Q?f1uDCCDmzJNO6hP3gJhSue7yH390mAEiQQjZuVUAWjXkflz3l0DwXemkzqzy?=
 =?us-ascii?Q?fWfK76K6UgUbUtbpl4E9vj4DV60Mztyz6zoTxchn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4894c772-2b35-4a0c-a6fe-08dce5d5a59b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 07:08:15.1256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEWtTZlARx903GFNQwMwqRfKlYvJQYdojCO+Q0JAbBpA8cfMZglnCO88B9/1lzDNYE/8q2RYN0ob6IyO3sMEGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6873
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

From: Viorel Suman <viorel.suman@nxp.com>

Enable doorbel return to work iMX95 System Manager.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/firmware/scmi/smt.c |  3 +++
 drivers/firmware/scmi/smt.h | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index e9d401f0da..98e07d3a16 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -49,6 +49,9 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
 	if (!smt->buf)
 		return -ENOMEM;
 
+	/* make this configurable as function of DTS property */
+	scmi_smt_enable_intr(smt, true);
+
 #ifdef CONFIG_ARM
 	if (dcache_status()) {
 		if (IS_ENABLED(CONFIG_ARM64))
diff --git a/drivers/firmware/scmi/smt.h b/drivers/firmware/scmi/smt.h
index 9d669a6c92..768b0f4c8a 100644
--- a/drivers/firmware/scmi/smt.h
+++ b/drivers/firmware/scmi/smt.h
@@ -84,6 +84,16 @@ static inline void scmi_smt_put_channel(struct scmi_smt *smt)
 	hdr->channel_status &= ~SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR;
 }
 
+static inline void scmi_smt_enable_intr(struct scmi_smt *smt, bool enable)
+{
+	struct scmi_smt_header *hdr = (void *)smt->buf;
+
+	if (enable)
+		hdr->flags |= SCMI_SHMEM_FLAG_INTR_ENABLED;
+	else
+		hdr->flags &= ~SCMI_SHMEM_FLAG_INTR_ENABLED;
+}
+
 int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt);
 
 /*
-- 
2.34.1

