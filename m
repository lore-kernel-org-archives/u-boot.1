Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4876EE9539B
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 13:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B30D083B1E;
	Wed,  4 Feb 2026 14:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="iS58Y9dW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF4B83AA9; Wed,  4 Feb 2026 14:17:01 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3E1483A3D
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 14:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niko.mauno@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1Zq1b3n8f/M6zdza7leFA1YgDF0RzKJ7TSOEtR1upMgTutxzFBM7FGSu7J61hzX6pwl7zozN+viWvxDQGxOkzKpukm8HaZtX2eR7DDXPhQScEQ2GHlaatmzSJT88WUwNoel70LO+scudjXPWkfsvlWthQGKPpYXFiCDsCESd0taK04QUzbS0FM9DUBoEwykRvaDjjnNKbKiO3/dtU0gQFmqmPk/jkzu/9O7j7HV7jGy+Bp2yrjUBOFlpfflisYwzsJjp0uohQv84ZhkAs9WIDcgxwwifBVWFzCQYicYdVpfYMzn3nTbFpZfcM8Lizmo+S4uLpD6hXYvwm+Nodt4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylzaBk10wdcym0SjHWY83w1oxfVCarD38lxNLwupQ1I=;
 b=KWOjHL2wIq9lqCOWQOEbiQ3YOZLzAHacgmLURq1fttbT9x0rcJyJCKL9OsWRrxryeVqXRglH6O6wgu/ma0kmvc4//YT8TxjhS8O/g6kHMQC9IUqYuyTnUDu5HwWgehyekhSsoHtpdieVxSVTFNPjtluB/zsz5ZrTyDhOwECVapcQmi8B3d4wdto31LRVERehBtkM9nAzKVvoC5FkUlAqrEfydOV0Xk4RBge8+BbCq9tv08aIaHAJL4qeDRWsPVkZ4vHG5rjtjd5Rb8ewHjDozrx35iyF0+n9Rh6y/8VoldIzi1dxqvQ0Uy61fAssfY+s+xQINAunFopfWPhfSJH17Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylzaBk10wdcym0SjHWY83w1oxfVCarD38lxNLwupQ1I=;
 b=iS58Y9dWFMU8CtNBgjRry9lcRIHkgi6Dvs72gLBNSJ8i2q3YYQLHd2sb9Px71cf6hn4uOeNvYhtCszW4ziKSB/pXMGfXvmq/1Lz/L3Dajq43B3UyKK3Ux60bU5UwzP4ZhK6lIs3vBMbQ/GT4h98gb20Sy5AUW7UqvvoelqJYHxt5E7+rUepcMKVZjoTnGvcjlx85XbUf9Y2jEpqBVDfP25lhySZ+CD8zdFqG+nLJQ3inlfer79B1BxeAyHZgCs510wayQUUonjyBIrHJDOZziid1zf5jzAku+HEiZJprYmXXAj+3O4aFvDaMFaiKdjwf96/12YbZvVGyuPrY8lBd/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by GV4PR06MB10191.eurprd06.prod.outlook.com (2603:10a6:150:2df::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 13:16:58 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::fb61:408a:ba4e:990f]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::fb61:408a:ba4e:990f%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 13:16:58 +0000
From: niko.mauno@vaisala.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH v2 3/3] bootcount: dm_i2c: Support also single word mode
Date: Wed,  4 Feb 2026 15:17:37 +0200
Message-ID: <20260204131804.23805-3-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770197302.git.niko.mauno@vaisala.com>
References: <cover.1770197302.git.niko.mauno@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007563.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3fb) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|GV4PR06MB10191:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f696fc-660f-45fb-b896-08de63efacc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6JRjXWbXjovgpwe1jPneIzKmpR6/phwcUZU3rPoq+2WKVhd212vuDbCDfO3s?=
 =?us-ascii?Q?HKCWZ01TydYt6Y2pDP+lpgEcNUECjxIWZ0YZekhKXBBVv9YhvrMEVG/HPPwT?=
 =?us-ascii?Q?yM1bBTIqophDBX/i+IWvpeHxZCjVgtJSS3dGyiQ2KnanxznakWqSbW6/GYXq?=
 =?us-ascii?Q?EpavHeq4URv+aTbTRwSoirS2jgxd9JTO1Czyp75r6zLf68s36QOndQZZMZsP?=
 =?us-ascii?Q?IXeLMm8V2ymb2eeLFVr1kW3nR2I4NnTVqyEcO+8l77Deou3vrhKy0Ysj4AfT?=
 =?us-ascii?Q?yC7J6MFC2ZKNzTOFkRlOkPQBzM8/iCBX9DJ8S+hv9CvgxdXILnTQo+fUBbq+?=
 =?us-ascii?Q?2HlpBl9d/z5qx6i+9OmQi/micTCGpASdYIy1jxuiIV1dq4uwPeiJTBH/dfg4?=
 =?us-ascii?Q?s4qOp2sUPtY79Mz9cS0blFGOIJ13g5Gt1VtOtwJ0e/fgNmPBA3KjnnXxvv8D?=
 =?us-ascii?Q?9h0DsasoRWbdBnwdRL+cFA7ax3fU5OhGP+VF5FSWNjgevdsOGdWLSFwZGSX0?=
 =?us-ascii?Q?yIw6sRb6gzU0qpQFWSaqbm6V6FIWazGw/HFvjAIFvuLYxqWJ1Ee9nnc7ZSVv?=
 =?us-ascii?Q?N/7ew86sh+zZLNh1rScb6hcmqreuLmRwBYj3sO5I0im7uhz7UAD9bFA0bBwQ?=
 =?us-ascii?Q?X9ewphKnBf2PSGbaGmSSILIhF0nhP/YJgZVCF4NXzNz3m9j3U4p9Lbrq6BxE?=
 =?us-ascii?Q?PuF2HLkYWH4cb9B1//hZj6rFV95IK2irWi+g5xvIEBtpRcUS582siOG6V0CV?=
 =?us-ascii?Q?gySMeQ1K5kPewfAksUP4dCx3sTXakJtx2gk3ATBW+4pdzCVfKYKb9KNqRvSv?=
 =?us-ascii?Q?B0tvsLJ+CRqx9m0PR3vSW+8JJi9BnScyAvma1OuYwONYvMBUollwNpwsbmrB?=
 =?us-ascii?Q?mmG8mRVNpUBR3K1ezLF0guyCEtHJqHeR2VB227q6N4YwP0u1cFMX9cS3uR0B?=
 =?us-ascii?Q?vBDTrKZegQjTKqcxKZ3Vb4HoK+JyVJE53r1F6Pyq9hrRsIFSvqgCWHjMRw0s?=
 =?us-ascii?Q?KVR78L6v15ZmGu38/as5npyfBWZQtwvuEGHUk1mMf+/eubEntnrroNfv+AF4?=
 =?us-ascii?Q?vLYNzARi1XMSA/rw5Kjkkxzt7WoGeOVXTIUGW8cjlbhYU7nRIksGpsT5f9d0?=
 =?us-ascii?Q?RQu2j7a64cHawC7ZgOW68chbtDIlt841XHPo6xyFhH0CAVHvDPd+sqJaNcyX?=
 =?us-ascii?Q?FI/47eWLpecw0IOBwE3pBHT9kWds8hDHoSn5+PTAsNYwex79+10KsUPqfOzp?=
 =?us-ascii?Q?3JQclln7WbRLtKNf9fwG3shg9N2MB/FgGGSKmnM4GB3f/z1KCQTF1YBQcOSi?=
 =?us-ascii?Q?o/wv/PUdavJrQpZN7BVjVIpIJPq2N1IJBePX/toLz3iyrZ8/AoKxZy68UCcM?=
 =?us-ascii?Q?nJiogNzty4FvfBXzXxV/BmwsYPOfb4mraKEt5UStdVhfrhxyT4g0RlWL17UV?=
 =?us-ascii?Q?fIBN7PH2TDDCV/NQNrIPdvrsjeAdfH28vh/YDqw6lXwtfzKN7qWqy29/Vcs8?=
 =?us-ascii?Q?Kc0uAhmywDhBu0jKJQBrtf9vlZ83mjY0MzcW3ZYZEQnl9nLuK9WAxcPCMtPf?=
 =?us-ascii?Q?Wnujr4/BAKCaHRJEE1tdxU2lw+DNAOmtwD4SVtz6d7ryk3D8I57tnvuxVtWk?=
 =?us-ascii?Q?R0mAtBfSSLfmEgpZIS6SyNA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR06MB8447.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o189m5Fb7ctDKGdamZV4oSnOARpzbS+0rKUqfPHTDEN2Xw9PTGkWINCqPr4B?=
 =?us-ascii?Q?rqEeF/tampdEgnJKHd9fZ8mEAtfxP8WvwtOQBkVSsHxLmCfxUrzCUeJiAs9G?=
 =?us-ascii?Q?O+k6kk3IIQVShJeUgfSTTCtrrQjNLJg5e6bD91N72u7Myfj9qDKHtxqtangI?=
 =?us-ascii?Q?nWFrybz2FTc01Gk+bz1xhafCivF8wcGFEEc+EmPn+VOoB0WAFScZdIzZdFsG?=
 =?us-ascii?Q?Vg+vn516k7LqI5+HFknpQThyZycM0gmYdAbR0Hj81SF0shGtzV9m7syiPIIo?=
 =?us-ascii?Q?hQItfDgQnQiUag0AdiL+rFz4hLehh0TGN2toJbhOT23Nyrm/Yni6YUDYy8yk?=
 =?us-ascii?Q?NF9tC36/4e3u0sa2T7KzkTXcMqMJbrYqwG+W9GRela4UDMIy+4QWPB1LLlPj?=
 =?us-ascii?Q?1f+GUNRdPfsP7e28pMS7viLRFfXMy1LbFwdCs1DzFlnY6q82B29i/x1wujEG?=
 =?us-ascii?Q?PFYuQvQxR7pRKApG7wYl2ketbKGR1OCZmkixk1yBLKFl7elmLo2kojOryL/2?=
 =?us-ascii?Q?442S3Lb8eb8RFWlNAuaNFlYs6ZWoWt4WJg/4yeStKY04nNT9TqLOBVvy3QmU?=
 =?us-ascii?Q?flAEQ/MKJ8sKsdWnThk0J6iQKEIABgEc6l4Id4GW+jPIKLuI92bbyuwIVc0f?=
 =?us-ascii?Q?LdJkKMOghf3sNdZCexlVlPG3GXBuDsAtscVplYTchw6XDbHnjU0ps3YRxxXp?=
 =?us-ascii?Q?IybJwvl/4dxMXyxErFYBECtzkoNVof0pRfFqGtUxrWdI3ykUq8QnWJoIvpiK?=
 =?us-ascii?Q?I8sJK7YMjKBoEOHQnaz2CDEgVhJiLEcvwNQ49B3GiQLktOZE8VlVUNyap5dA?=
 =?us-ascii?Q?KGG1CoQehwyayS9oS4Yi5SDuzL3b72EzbauSNqlxuMcvbLMI5+iLkymYYkCe?=
 =?us-ascii?Q?FAvs6yXFizjPzIn03sfG6QRZBRL9FJ8sDdVQY+p3m8hHwNBeVOAgcUtF7Aro?=
 =?us-ascii?Q?e3mhikpZYlN456fhIWRDCLr1L00mcD2Qj/hCkNZI5a9ixqYIz2zeiNmZsViZ?=
 =?us-ascii?Q?GlQVcNGbe2R3sQlYDLS1X2aqSFwH0iyG4rVdgDH19pcOF+L/DSI3iZtT1hw4?=
 =?us-ascii?Q?mbtTPFiy7UbfAEH2OgEpEEk/541a8cOYaQ9cYxw4ieDMSK+CaiWruBlNVv2S?=
 =?us-ascii?Q?BFOde0OftZmt35TF9/zyljnit+uKszMcRT18es4dHYpl1TLVMQVXnP2sf2vG?=
 =?us-ascii?Q?T67ug2ifo6UahympRxUBpSeRdwoDHj1eCYmGRKUbPErTlI/B+u2Brq2PnC1B?=
 =?us-ascii?Q?why6aIsbCr1Gh56l6NwcZ3Zu4h2sninRG0lpAdKGRNR2WKd5sJYPudrZW4pP?=
 =?us-ascii?Q?GYAweRiESu3yyHW5Cvyd68MKIJvEBz1EogCsLxHxFQ5ZZqJfuYx+zkRNpyn8?=
 =?us-ascii?Q?MGrT96TOLWKNn3j97B8R0u8svgpN6ofAKU78l+fZJz7uYFWCDCY9EHVGEKbb?=
 =?us-ascii?Q?VBwjXm/WD/quxsL27v+7TyF0JkukFwGJ6bQrXd0ahSlr/CQVSZGkWmnce78E?=
 =?us-ascii?Q?Dqh8HJjEW/YqhZv5Puow23zxfvxMRy59KKQyRdjcgoz3jBys6bw2LEBPLCfJ?=
 =?us-ascii?Q?cI3ulUNvqxwwW3cJeoP1ivAOguW0NakzaYP4u5k5isaSxi+oFbgrJJ8Fyeaf?=
 =?us-ascii?Q?AbBBI47VZvhYJWbYMYp8hXpxouddNxl9RXrJDr4ywvTXFkO6sumj+HizilmR?=
 =?us-ascii?Q?LikdYEnD62gtkyrm07VIRxHE8B9RUJI4kyXz6Rz2v27qG8ooUZogSuCvU4lT?=
 =?us-ascii?Q?odPrEqToj6H3gnc7JlfTgh0hthgG9uw=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f696fc-660f-45fb-b896-08de63efacc4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 13:16:58.1485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtXbBLCs+fnGa7EWW8jqHfSaDu8mWVE8CffCAb2BkCTZ8CxcmvcaysaP7z5eS7IuB9fVbI8dRAXswcD5JxXoLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR06MB10191
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

From: Niko Mauno <niko.mauno@vaisala.com>

In addition to pre-existing half-word (2 byte) mode, add support for
the driver to work also in single word (4 byte) mode by adding
'size = <0x4>;' in the device tree node.

Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 drivers/bootcount/bootcount_dm_i2c.c | 74 ++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 20 deletions(-)

diff --git a/drivers/bootcount/bootcount_dm_i2c.c b/drivers/bootcount/bootcount_dm_i2c.c
index e27034cbeb0..07359ecfa6c 100644
--- a/drivers/bootcount/bootcount_dm_i2c.c
+++ b/drivers/bootcount/bootcount_dm_i2c.c
@@ -15,6 +15,7 @@
 struct bootcount_i2c_priv {
 	struct udevice *bcdev;
 	unsigned int offset;
+	unsigned int size;
 };
 
 static int bootcount_i2c_set(struct udevice *dev, const u32 val)
@@ -22,13 +23,22 @@ static int bootcount_i2c_set(struct udevice *dev, const u32 val)
 	int ret;
 	struct bootcount_i2c_priv *priv = dev_get_priv(dev);
 
-	ret = dm_i2c_reg_write(priv->bcdev, priv->offset, BC_MAGIC);
-	if (ret < 0)
-		goto err_exit;
-
-	ret = dm_i2c_reg_write(priv->bcdev, priv->offset + 1, val & 0xff);
-	if (ret < 0)
-		goto err_exit;
+	if (priv->size == 4) {
+		u32 bc = (CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK)
+			| (val & BOOTCOUNT_COUNT_MASK);
+
+		ret = dm_i2c_write(priv->bcdev, priv->offset, (uint8_t *)&bc, sizeof(bc));
+		if (ret < 0)
+			goto err_exit;
+	} else {
+		ret = dm_i2c_reg_write(priv->bcdev, priv->offset, BC_MAGIC);
+		if (ret < 0)
+			goto err_exit;
+
+		ret = dm_i2c_reg_write(priv->bcdev, priv->offset + 1, val & 0xff);
+		if (ret < 0)
+			goto err_exit;
+	}
 
 	return 0;
 
@@ -42,21 +52,39 @@ static int bootcount_i2c_get(struct udevice *dev, u32 *val)
 	int ret;
 	struct bootcount_i2c_priv *priv = dev_get_priv(dev);
 
-	ret = dm_i2c_reg_read(priv->bcdev, priv->offset);
-	if (ret < 0)
-		goto err_exit;
-
-	if ((ret & 0xff) != BC_MAGIC) {
-		log_debug("%s: Invalid Magic, reset bootcounter.\n", __func__);
-		*val = 0;
-		return bootcount_i2c_set(dev, 0);
+	if (priv->size == 4) {
+		u32 bc;
+
+		ret = dm_i2c_read(priv->bcdev, priv->offset, (uint8_t *)&bc, sizeof(bc));
+		if (ret < 0)
+			goto err_exit;
+
+		if ((bc & BOOTCOUNT_MAGIC_MASK) !=
+		    (CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK)) {
+			log_debug("%s: Invalid Magic, reset bootcounter.\n", __func__);
+			*val = 0;
+			return bootcount_i2c_set(dev, 0);
+		}
+
+		*val = (bc & BOOTCOUNT_COUNT_MASK);
+	} else {
+		ret = dm_i2c_reg_read(priv->bcdev, priv->offset);
+		if (ret < 0)
+			goto err_exit;
+
+		if ((ret & 0xff) != BC_MAGIC) {
+			log_debug("%s: Invalid Magic, reset bootcounter.\n", __func__);
+			*val = 0;
+			return bootcount_i2c_set(dev, 0);
+		}
+
+		ret = dm_i2c_reg_read(priv->bcdev, priv->offset + 1);
+		if (ret < 0)
+			goto err_exit;
+
+		*val = ret;
 	}
 
-	ret = dm_i2c_reg_read(priv->bcdev, priv->offset + 1);
-	if (ret < 0)
-		goto err_exit;
-
-	*val = ret;
 	return 0;
 
 err_exit:
@@ -73,6 +101,12 @@ static int bootcount_i2c_probe(struct udevice *dev)
 	if (ret)
 		goto exit;
 
+	priv->size = dev_read_u32_default(dev, "size", 2);
+	if (priv->size != 2 && priv->size != 4) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	ret = i2c_get_chip_by_phandle(dev, "i2cbcdev", &priv->bcdev);
 
 exit:
-- 
2.47.3

