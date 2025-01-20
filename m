Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E63C02185
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 03:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 514D2801CF;
	Mon, 20 Jan 2025 04:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gi7XrsPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96FCC801F5; Mon, 20 Jan 2025 04:24:14 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EB7480085
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 04:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scRMv/syJ52aFcNPv+fUe01no/PELbUfXpUNEb5ot+I8DHy3mVzMVF9ajhbYx0h0r7fSwHIQbkP7Ip29w1rh6yk1k8zT+iVBZbvSNgJ4BkXfeaKVk6H9/nH5r8CpLH09x5knSap2Xai3Y/hjYaIOa59WMk//f64c8FugcEaVU/zl/8HWgz4UInVepsdD9CVimbDQpqgyRtzPi7Wr+PmIa73ExPlDrvT9AIpn/Doh1n5gm/R5lzIcyt31Asl4pLKfwrsGvXDO5R5GWWjfMOwcDQnEJh+DYkqArUe1ZxkrBkdYie1uIsiUbusvsTLQku2AJnPMo4c2HZGuN1vIYOXvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSJi5aLi8L/lyU4hUA6DbjyXjeEa3D/hcOMrjXTGf5Q=;
 b=wmCl52UW9I9S5Pxi0YQd3I6reWs/FXtabq+0YqeaBbHg5kYLWESJ6O8qvS8Viwx2kU28qCeXt2Kt/7lW8BO6ERK/UHVOoVs04B7viDi9EU6iYzBdQKLK3tMCENv2VkIqpthUYYd7g6Rxy3XixcAgGxQ+xbBNRLqW2JS3D3yQIu9c8h+XNSxkIxy7oP02WoxCx28GF4Qy7jVsHRxEMdLMwTaISUsVDDqX+/2CMh5Z5haFB7WPgJngJvaDkCrmJhWiPzBUBTa10JFYgBT0MUhSK9hzLKWHmWbdTC5iFDjv+yehqE3QUTg9Nce+ZY5NJ4I9AsT+XTcmwk0l3e2sPxo3pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSJi5aLi8L/lyU4hUA6DbjyXjeEa3D/hcOMrjXTGf5Q=;
 b=gi7XrsPPnDejkDroul9jwOYeW5kKen3oa4zGhHyFjxCB93givQaqPnsKn3AObmwBEXGLGRwYGP+Xx+Oj2NP8+pTTMMHWiNiH4XCx+CxuTz5seF6hMZ9VXwTKAKrW7aw7iNfquWWRUeUxoFFgSQEKHJf9UpwcNW/OoVWD6C6fa5Co2gdZUa84eUuCrZYaSha+wKGvsgSesaDL8Ibkh/D1BV2GWeskDSLsQ8XjMkOaTF2fll83CSDZtx1Rz1BQvY0wLiuF4QzbfY645cdw7iiM3EBzZkleTpgvqbGn3W/KEEmpoa24xUrvU/Ak3HTB3pkHkt4lt3nZvbgFXcPXbnRnXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7536.eurprd04.prod.outlook.com (2603:10a6:102:e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 03:24:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 03:24:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, jh80.chung@samsung.com,
 trini@konsulko.com
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, pbrobinson@gmail.com,
 Peng Fan <peng.fan@nxp.com>, Faqiang Zhu <faqiang.zhu@nxp.com>
Subject: [PATCH] mmc: Optimize eMMC erase speed
Date: Mon, 20 Jan 2025 12:30:09 +0800
Message-Id: <20250120043009.30097-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e4f972-6214-4413-4cbc-08dd3901e76b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IILI89ydCJ7KQ2BnWiDQ2gZYGhDO83AqlVNlZndMN1LvYY5MTBgvHh8xVZMR?=
 =?us-ascii?Q?MeQjO8EltDTiKmOr9mt/2XOqY+j0Wek4hX55YdBQ8kxLdIJ8kEqUnvWCZnux?=
 =?us-ascii?Q?Pyw2TtBDNhaR1Q9lHEYBHgV8PmU0FG2eVMu5Ou3nzxn+dVL76sLm+OSpEfhT?=
 =?us-ascii?Q?Fod8JKWO9nsVOPelEGaUlQbWnsp0EfwHajteefD1hK0mq2N0R2i9cF44CL25?=
 =?us-ascii?Q?SSWD7t+hCmD10CyFhBBjDEAHjQrDzhXwqpn2KLU9UpPX0WaASE3kSi/Oyre/?=
 =?us-ascii?Q?/heeM3dWxFlf5AYtwm0+wT67Jsyv+PU0lzEWBOqg6lANJzZxjfeti92QJa4I?=
 =?us-ascii?Q?pVdgf6YL1PfNnCEUg5O0W5PtTOpuxxffPbqNpWcocVhZQLwPKZyiVvvqdMTh?=
 =?us-ascii?Q?80Kstm5fWKMmE0sgY9Liwk9o4CrN/8xjrlsAK1uB5rxa3f7Xb8sZVKeRML45?=
 =?us-ascii?Q?qTwgoImVfukaUmQF3lvPLd54R0JQRn3H91N5yqjclCEWFrQUvkCggEG7aL+6?=
 =?us-ascii?Q?t5eQZ3ZPpTuMOCYap9MGWz6K02/tjvxXYH+OTyIzSGNSQz9x0jYIx54hsyGR?=
 =?us-ascii?Q?nXfKWIFITvN1GMTHvdTFN0bFjGQMA0R6Qq1LFn0kbVlX+0j9KbweNx3EzD6r?=
 =?us-ascii?Q?pSyUJ76jdXeEjfVsa8GwYJHX41r/k1bwpJwxT+/tAf7beO54tRFxkw9l0MxT?=
 =?us-ascii?Q?wFdP76Zgtm1KDGYDvW4yeZvI2URNexzIhiKJOenDO4NIOKVVi2wE9FH4pIIB?=
 =?us-ascii?Q?f3dhhQvkcUxAddTkT83hvXqzw/CaejOu8zzINPy++EDbZOKYbuZSzu4lGfYy?=
 =?us-ascii?Q?KYLWQQPJ00e/KvGUobtBGZfrtMFmOl9Vr3iKfxXNYB2RocEJlJnpGTKgWt+M?=
 =?us-ascii?Q?bd6+nQ78pFjp2ZOeyNCc+LvG+kZTScNoOaLI/a08RUCPzmYHJfD2laFqZxB8?=
 =?us-ascii?Q?5XdQl8PGzq43W9+0Gv/N3rmljXKc+3eD8XuAJrROOqVGT/+nC36tFaAPm3dT?=
 =?us-ascii?Q?WweR6n4MmlGyG0HSQwjyd9M4vm7wkQUHdXx5Um2Ek2d2BFZgpnSXkWyBvvh+?=
 =?us-ascii?Q?1U/6keEhct/c0MFZc8v4ALc9YvYMAXjh8WwstNQFDO8FpDms6UbamOk8aBqR?=
 =?us-ascii?Q?Z6T3xclyLD4dv7fRHHBh2Nn1GprAqB70s2YZdmvXnFGdubUrQFvW9OqRthoa?=
 =?us-ascii?Q?/24kKNfU3lHzOGp8Dlbcdm/0Q6IduFsA8su/XfD2ah6IkU+CYzFDIC2vKnFW?=
 =?us-ascii?Q?8KVv+yr2oqwnvFRRz4O7w3TFw+VmrP8LU/tiuCLXW7Cf2v7JdxfKVuke+N4V?=
 =?us-ascii?Q?eCDjI/Nc4QdebPPhVtAMaQUVjAifNwGjHVrMHM9mXnXeBFV0gyVELKMpsoHO?=
 =?us-ascii?Q?AHBovmpveuiOPuzlpbg4QpPQwJ7nl4njpROYq/W1muGHAzVcLgzrHX2LRpbG?=
 =?us-ascii?Q?0wEfr/0TDcI3wWcdc+znZbeHPBjJmCDl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MQyudCpFENryE1BrVRIZpCWwIRbG4Boj47Sf0uFlzYlI+e7Fj/jUlUUWalsN?=
 =?us-ascii?Q?WSgnMxE5/SuHljE6/AY5Wv9c3wxi21LMju8Onu1IFmYPPGn/V41Q+hsVMGgR?=
 =?us-ascii?Q?myNElCOAVRJw+gtbdICarpyzO0NxlrqnlacF5kvGgxkbPQBeesnN4PXB7MSB?=
 =?us-ascii?Q?Q084uA8d+GCmPA1Gk5crwtUVcjEIp7XVFcJxWTDHpcXX9GpSw9REKh300mLp?=
 =?us-ascii?Q?DuoaZP2Fv+0A6Hj1h8vzYiZVrqR0wf6OdNtM2xrqVkB2+R9GAd/Y3ZZtREHO?=
 =?us-ascii?Q?evAaHa4RXMUru8G7DmNdWKU5oa5nA133V4G2oTgdclaU9e+IWmTRkUoD8mc4?=
 =?us-ascii?Q?GW+vQe4wBFHsGxuaSJX8v67Tqngynp3YlV34aoM2qY9DUsh758Xrvx5lFCBg?=
 =?us-ascii?Q?vpib1tDYj81c2/Hm8XR5/yRwVf6+VzuAKo+CBO2bNBtB14fmM8nlzDpeDzQe?=
 =?us-ascii?Q?xZknj1yfpa57yXH3g9+rLgJ6fP3pQKmqPDazFSWw7pfqI1iLvdEWQK47yA9S?=
 =?us-ascii?Q?KnB7Lm9FT4LVeGm4n/jE/5n00l3QENEVbNbVYBsZtwmhPyDYu6qU7fBmRLnU?=
 =?us-ascii?Q?hlt6M8uS+Y1NeaBH7AyTrxdLFIRS9tRQIWf8bdQA1ym0wwcVhG6EWBt6xGx+?=
 =?us-ascii?Q?HkXvzFpq3f1BNiBiZQuIUX0JRhEZvq6cb+tJmJwfjuxh1VUQLEBIBIHMo0xR?=
 =?us-ascii?Q?Ww6GZ9N6myj1lFoEnfDkbhRswsk4SFB3wjtUAiNxweUIH+VTIxGYtos9nSMG?=
 =?us-ascii?Q?GTAPkP9gicnkABA3ntSSwdVf8RNA6SMGIFOa3r9U9Uw2HgVpV+nm3XPO6KF8?=
 =?us-ascii?Q?mSXZfbEEp80XguLuzSASf8aEt1AWlekCLx3A2hJ3MCGPGe4vZp5vLiJANL4r?=
 =?us-ascii?Q?v92otlsmrBmzq+sl3HgK0bE2VLIXPQx+/bLUyiYvmie/MERz4WEsA5PoXZPg?=
 =?us-ascii?Q?Xlc0M1+BzSePyqfineb8mzkcn2ic1NRNRGPWwl349vLrz0YVGPe86GGPEweK?=
 =?us-ascii?Q?D7sKojINdSQNO4iEzk2Fli232iau35mGa4OlmiDlCNrKy/7QwXlwl+AJFwoM?=
 =?us-ascii?Q?jnrODV1ZK2IFqcmcDaEoD7XbD9tGDxoPTcZ2dbfC47uNYMJ8krIOc9DjnyK2?=
 =?us-ascii?Q?Bo+IJLP3aNWM2chJVqtrAkAeOmavlcmsPprOZXKnJHJ53Tczhxoo8UFbSQpD?=
 =?us-ascii?Q?MOVTyR/qf6LM3/G4QPTc5+rHnOy4V+G698L+gmrj7onBB0OKKMh14IXL7OQn?=
 =?us-ascii?Q?MP1UdfSSKMfoAG5DFiART7AvyCrrrYRYZswURU6o6C392nE6eUevslgVaGp+?=
 =?us-ascii?Q?WQABtgTlBiCqkxTOHcE3wpo5gsXXHnLE2TFbisb1Q72e+bLMvQOGv0P1Ti5L?=
 =?us-ascii?Q?z/U9tu4mKjC0puQ9DZmVScggt7HPFiBr8AIMHffG7aH8mWXfVYYOQhUNwzaU?=
 =?us-ascii?Q?A2yCyr9xMrup/iFpPCliTMyt0YPAWC2mVvTIFJfzMqNET6BNgqHOH6qRJq63?=
 =?us-ascii?Q?0TE0YwvemSAGf+M8Pscj13kwixkCsWTupYmrbYwpNPEItNAK5LfK7bOybSw7?=
 =?us-ascii?Q?wHBwZn8E7qKT0BSrc5GI0DCv5cruixWsZSQWfV5g?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e4f972-6214-4413-4cbc-08dd3901e76b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 03:24:09.9204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWit/m+df88pF4QG/kgh3fSYKR5wPFV01Dx9ZcRTw17pKb1zUMLLsHVWUwMZPL0tWBN+Aq276ozelSLbjR0aRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7536
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

Per JESD84-B51 6.6.9 Erase:
The host can erase a contiguous range of Erase Groups. Starting the erase
process is a three steps sequence. First the host defines the start address
of the range using the ERASE_GROUP_START (CMD35) command, next it defines
the last address of the range using the ERASE_GROUP_END (CMD36) command and
finally it starts the erase process by issuing the ERASE (CMD38) command
with argument bits set to zero. See Table 11 for the arguments supported by
CMD38.  The address field in the erase commands is an Erase Group address,
in byte units for densities up to 2GB, and in sector units for densities
greater than 2GB. The Device will ignore all LSB's below the Erase Group
size, effectively rounding the address down to the Erase Group boundary.

So choose 2GB bytes as check condition.

If the erase size is larger that 2GB, use 2GB to avoid breaking non high
capacity cards. If erase size is less than 2GB and larger than a grp, use
'grpcnt * mmc->erase_grp_size' to cover all the sectors, else use
the number of sectors.

With test erasing 20GB eMMC

board:  Evk_8ulp Evk_8mm   Evk_8mn             Evk_8mp   Mek_8qxpc0 Mek_8qm
			   kingston  sandisk
before: 37.683s   112.738s  129.365s  28.238s   112.605s  500.470s  490.708s
after:  0.093s    0.111s    0.951s    0.080s    0.121s    6.960s    6.915s

Tested-by: Faqiang Zhu <faqiang.zhu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/mmc_write.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/mmc_write.c b/drivers/mmc/mmc_write.c
index c023d15e52a..90fcf2679bb 100644
--- a/drivers/mmc/mmc_write.c
+++ b/drivers/mmc/mmc_write.c
@@ -80,6 +80,8 @@ ulong mmc_berase(struct blk_desc *block_dev, lbaint_t start, lbaint_t blkcnt)
 	struct mmc *mmc = find_mmc_device(dev_num);
 	lbaint_t blk = 0, blk_r = 0;
 	int timeout_ms = 1000;
+	u32 grpcnt;
+
 
 	if (!mmc)
 		return -1;
@@ -123,6 +125,15 @@ ulong mmc_berase(struct blk_desc *block_dev, lbaint_t start, lbaint_t blkcnt)
 		} else {
 			blk_r = ((blkcnt - blk) > mmc->erase_grp_size) ?
 				mmc->erase_grp_size : (blkcnt - blk);
+
+			grpcnt = (blkcnt - blk) / mmc->erase_grp_size;
+			/* Max 2GB per spec */
+			if ((blkcnt - blk) > 0x400000)
+				blk_r = 0x400000;
+			else if (grpcnt)
+				blk_r = grpcnt * mmc->erase_grp_size;
+			else
+				blk_r = blkcnt - blk;
 		}
 		err = mmc_erase_t(mmc, start + blk, blk_r, erase_args);
 		if (err)
-- 
2.35.3

