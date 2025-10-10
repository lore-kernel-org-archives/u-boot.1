Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CA8CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8953B83F8D;
	Fri, 10 Oct 2025 21:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="rjYyx/pv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F2ED83FB0; Fri, 10 Oct 2025 21:08:54 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0077883914
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exKa0XRppyorRVvhXJIjXDgOH37wpwJpBM5ngfLlgTZIBLBE3++5BJwet1HYYZDTFGFxk6H7dP1ytei0Tu2c3kYaBefKTE5lFWMsSs/1oc4gMxuHwK/vmxnQuCQCusVl6lUbckKLq86Vj/Gp9LXUUt/ps8+N6QAx+MrHI+HpFX3ysgCnl+GuXs5JcNNLaT8KLR5sdiKHZWb0TNZXgSg/cGo5fb9I0tnxaKDcalfbTeMY9FOG3KBXH6Iy2m9unKi4aLwMVY2Kb9lQ2r93jmm0lSgibhzt13+C7Wkx8f/EmxwOYThUaPFNcpxS7NxTvalWw7A5Ta2OCvnY4CicWtohTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orOzZolwsPSdyAAamqgjtv7CXxnCf0n3eCAcQ1KmiEE=;
 b=m7DObqYRNfRVSz3LkF/bUaH7S9aKuCg+SXmbDjhyoLFAzzZGqOU/Ir38yP9x8IF38V9oLI0KX42qFcUa2NKxkToNqF8QjC/bgJuzwCqlm35dOcSPyp5vhTjVlnr64O678WR6+ZCwIZSTnSww8uOgv+WS0rxqlKQ9HyNvUeek5UCCYIegRhLg77HOUZDrnPev2txf6VcuTx38+tfN0FVOZMYd5mHGebY0J3YObrcsSDU7Ecn5HK1w/viG/OXgxyIq+tjyf6UDldf13x6aRex+MuTyrULCpijJmYGsCjMrU6Iuj6vpWI8xGh/509in0GGDkRJAGRQsl1z+hBtelxV+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orOzZolwsPSdyAAamqgjtv7CXxnCf0n3eCAcQ1KmiEE=;
 b=rjYyx/pvh3qWpSxWGqxY3bpgKaAJTpYKpC9BmcUGnGSoB31VdHks8z2dhPxtNXSGfpDlPfHBw6kLkjR85ciP9wup+0RdX6UEzcA3Y4SA8hzw9Q/yM7ZiePlTNxM50HsbnXOorqZj1S6Bx/OoD10LV/LWURryafrQTCDfYlHx+TxY4gNXNUok3C5S8wvYUy3IaL6rtXfti8op9i34sddNlKlrULiCTcKQX18qjcqs4db0kAIZ7/VJl1EZNBTNFeBOeHMM67XgukpWkHz5FTVFBGSdTFEurwqDoEkx/QM4x4NmFcXq0gcTYQ1aEPvTaKGJnyTvXlHmNzrv1FBRyBqTIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8371.eurprd08.prod.outlook.com (2603:10a6:20b:56a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:08:50 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:08:50 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 01/11] spi: airoha: remove unnecessary operation adjust_op_size
Date: Fri, 10 Oct 2025 22:08:31 +0300
Message-ID: <20251010190841.1590130-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010190841.1590130-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010190841.1590130-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::314) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: e50821fb-b46c-4299-8844-08de083071a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L6N4tz8iRlm2juWmQNeqJzg1D6mqo5Dq7BkXFm5/6E+dYXALuMiBV7ju7/dg?=
 =?us-ascii?Q?bYGudnOiGGeham5M94dh6Afl7i6GPUSz9auNYUzUdd36DiRvbHiLtx2jL724?=
 =?us-ascii?Q?8lN7ZL1kGOsInX/OBSdHQlfK08uPPbyD7q07iZRa6+rPbZCl8u0AvCgmUjQM?=
 =?us-ascii?Q?hniwbcc5CBTqsUgdfxDXPmo2P0CJohiT03+s3xp9INEU+NDLQ79YzIFPeTI9?=
 =?us-ascii?Q?T3kT940BFrebs8EqgcD4SsmzPxaTjUY1GqmaAI1Ee5gfMMxpiTIplzuHqf79?=
 =?us-ascii?Q?IS9Hl8LVmRLUw2qgQQYUJbDZyOgAjTTBfsFaNKSzo5XPOmhaAv/oF6QubJqY?=
 =?us-ascii?Q?ym631WWdb/hwksv3QvHx+gI9yGXlOZMy3qjxHBJ2y3oAW0Q8LyPjnWCjvOu+?=
 =?us-ascii?Q?ehzfM1AsFAHZYfggwsfZFEDbpZrlQMae7AR8GeWi7UUSN7duuW64d09CRyOA?=
 =?us-ascii?Q?jtR95LA87jOnr9pmVU/T9D+9ve20mdnbDVi7H+gcnh4jHato4W6bECMsDO9S?=
 =?us-ascii?Q?7DkdosWG1Bm/IJe3DVn1y/Xf89i5A3ZPnYt9ehEdjF47lwgCasDnkqqHI1Te?=
 =?us-ascii?Q?sfUua3660KIngj6YxePp+2UWXiDcCh0dVr56ge8egjg56MSj5gLzxdbXBKg0?=
 =?us-ascii?Q?PuARwTSuREqume5KjFwT1HS9rdy3a21HKNSjUyfCmKvMWME4T/2oVMcF5bgz?=
 =?us-ascii?Q?zhqwS6JR6hQoLyu1oVw+liB7eKCG7RJkJruUXRady88F/S6npPnRTXtxbXfN?=
 =?us-ascii?Q?Dc93SbIXkCJhy6etWK8NFusPw7D+jJBNoVdzWaHhZbPgXnGuQwSc61MqxGUA?=
 =?us-ascii?Q?QtWNd6+Y9Wyl3jOTZDKrxzlTSoYQau7kuLJsR8sr3jtkScwWyqvKJX8raDEf?=
 =?us-ascii?Q?dFnVvNnjR1rwbiw/EDf0XGb5ksL/NjcoaEEEkLdZk/YIXR+n4Z0UHN7rNC1J?=
 =?us-ascii?Q?jNjH5Z7qjAqxvf5WIpjaD707X9bxkBtnO3ln7agnsS/u24qBgWWuDmckUPzl?=
 =?us-ascii?Q?QFVJL/HnNHi1WwN5UlV4xF9Aq2Eyw95pXcs61K5+bQVCLDWhUYdBJgUbPpG8?=
 =?us-ascii?Q?obACod0nd4o8DTVI5GypyA6qHmd9oVdYIWYyhXWb7zDiA3Z0Atm2Cq1TMVPS?=
 =?us-ascii?Q?Uei1MvcqQbwRm2mXqTC4OK0RD4ogDWQcyAxD/acm1sM0NOg6u3qdiR+rX1dW?=
 =?us-ascii?Q?uy4ZcfAYYTZOHCuJ37fWxtKzQmFnMZljfC3GR39WqQRMfGlGYNBxhDz7HweL?=
 =?us-ascii?Q?8uIfbWDs4WN/jasgk/PBKYeiGF9aN+3KWhQj919fxV5Dqm2RsZTpy+4VCtMI?=
 =?us-ascii?Q?uhu+QbkFLeP6KWFeyindEAZaQm5FgwAJbAuw9lgXJui3AA+9EkZ69LYvbtcM?=
 =?us-ascii?Q?rjYBAA/8is+wU9rIaOnrlj0zK7BV+ysQxK6umAZsjA0IcInTDIZOt/iB743S?=
 =?us-ascii?Q?uuEpQ5EM8M9K79rOjefReKqr/hWQz3OjhR3Vq4PuPEonzSxNSF1ERhEv2Auf?=
 =?us-ascii?Q?78U/g+6i5GH32hfHLL/e9OpZaGxTo7d4A1cs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CMbSKPKjLjbJqFxJ2aoLCq/xNYnZKJYa2R+CdMAcZMu6UJLVNGjbqcXhwefh?=
 =?us-ascii?Q?HC8NfkXMB98p5uL5nZsK2upZrqMbTn/P89uuylke5+KkXAL52HDFL8c8JCKP?=
 =?us-ascii?Q?Vf/bLlz6zgkhqzTQRYqsI2ubL//EAGYF8j2aARj4pFQDzDPN946XRwlzjwQJ?=
 =?us-ascii?Q?LWgWdooL9vCn4cWh2NbosXBIxDYc2NW6oSMcXFSMJ9Yt9xJIGB5PYkWYkO7I?=
 =?us-ascii?Q?ShTZmyGTRin3epJ4FxDJaIsuCh7erwBHF4tJHJi3E9LNkydOYLvZv3G6n2iE?=
 =?us-ascii?Q?6N3UXJ/Czks3Hf0xXryOEdA1HCQzliXlcAw9NF0olfl7B5D8k8QueK6yq3tF?=
 =?us-ascii?Q?Jd2StmBEIxn7+dprAVWrv3MjhvUjdhib4gZL/avPx2rYz5VGMmH5inN71ryU?=
 =?us-ascii?Q?2Hj8X5kA80ntVxagChABgVgae+9LruSNYEyEYpuRsAn2XJMod8TtbiW8KnIw?=
 =?us-ascii?Q?ELDlkK0DJtkip0tAEl8Pg9t3MgX2SXuVrzS/D3EQJUQB2bRXekbF6sLBQoHP?=
 =?us-ascii?Q?AgOEFUix3hFxa5SfQUFeqpoKRXy6BCEc04XUDyxIigNmDxBdqS7m4t+gg8k1?=
 =?us-ascii?Q?nMJbrD1ypfn1+bHvinBQgrbGxAPe1hNA76RX62OW/55rd4RPXsfnHnsE2EaS?=
 =?us-ascii?Q?iIJwTRIJDLHQYJ+mZAivOfkWjJaqU0NxYrzs3HjUHpAQOnm/AIj71xQODB8i?=
 =?us-ascii?Q?iCr7UYcCh+3cUjjxGOXAculIyG6j4KEA2X9r6h9EEXNgN3gOsPyfVzdMp/f+?=
 =?us-ascii?Q?EBDjOnqWorSnO773WTsUJ9q8wRXukEgid2Sz7XPC84jWClFoQxjomw3sqUTs?=
 =?us-ascii?Q?X/c5ftGVVZRR5XEXRiWnKxk0HpuFZwzcXEoexrmebbwFkNiLR76Y/JJ9hBye?=
 =?us-ascii?Q?D2oSdu7AYzGOr1j5P0aKYVCDx5yCySreV5QMDz1DlFYo+d2PhbLOgwillaCP?=
 =?us-ascii?Q?uJhCrVqSR/3eMQ5Qm0XDR+bRNmC7lgWqkpynw3aAALX7uakAb0eNjtcHcy5L?=
 =?us-ascii?Q?iArvlwAn440i3FQ9A9cyL3MKdye8m7FWMSJJKGAnGj6qwia2Lji6d6TmVrbm?=
 =?us-ascii?Q?0x18AAh9tS2HXW5wEFhGQG+t0uzPdmd1VjQQPEh6FbYPJF+Us37EzBIPqhvv?=
 =?us-ascii?Q?+B+xs6wNkEePUT+yA+zxlH+YEs8IFz3dRaDtZdgSTUmWmOeM5Nb7V8Rt7Gnk?=
 =?us-ascii?Q?0DnS4BlCx57YUMp9H7/pv/oQ7fpE858h6qHK/JqTFEvh6+TfMLKHHOIbqbbV?=
 =?us-ascii?Q?i7xPPFTcZoygE5024wNtQ1YTG9/ixEP/plpftCtM9PZzUuYBdjckM2bBvXDx?=
 =?us-ascii?Q?o/AJ7tfkQ4z32qL+k1+etdyTA6mdV2d1QdXNx3ZPrf/9IhWvAJEDHFw57aTr?=
 =?us-ascii?Q?kF/RzbZloVmIFFQBlFM8VrfE1xkZSTXSUlCbNHyNJi0lfbfY0jpxaU4KnMOP?=
 =?us-ascii?Q?rcnr3LBypnKWvKnxDoXfGWEfQWsT5DdiIuDAQKYUsa2CVPmPJRLO5trMJY8T?=
 =?us-ascii?Q?Ju8Qe12quNUjO5Ks1z/RwH0JuOzYOZdhveRdL614DI6Oyt1km+isRPVMzNoV?=
 =?us-ascii?Q?PsnQdaOi0fh3K6/AgxLXttSGPpsVXL0QJ69t7hY3A652ulklPi30pHj1JPdh?=
 =?us-ascii?Q?ICo/5W66EYRJ2FgWquE+Eas=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e50821fb-b46c-4299-8844-08de083071a9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:08:49.3373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoTerb5EVH07+Q7pPf6JuSI5L8hQm3v5tlHsAzQxQWIM/n7n/wkroUUNfprp+0On5ZmEdVBIWrEVZoWnlh+Ruzs0fdvifmPf511Y+BldrFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8371
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

This operation is not needed because airoha_snand_write_data() and
airoha_snand_read_data() will properly handle data transfers above
SPI_MAX_TRANSFER_SIZE.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 3ea25b293d1..4eb01038404 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -525,21 +525,6 @@ static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
 				  SPI_NFI_CUS_SEC_SIZE, val);
 }
 
-static int airoha_snand_adjust_op_size(struct spi_slave *slave,
-				       struct spi_mem_op *op)
-{
-	size_t max_len;
-
-	max_len = 1 + op->addr.nbytes + op->dummy.nbytes;
-	if (max_len >= 160)
-		return -EOPNOTSUPP;
-
-	if (op->data.nbytes > 160 - max_len)
-		op->data.nbytes = 160 - max_len;
-
-	return 0;
-}
-
 static bool airoha_snand_supports_op(struct spi_slave *slave,
 				     const struct spi_mem_op *op)
 {
@@ -691,7 +676,6 @@ static int airoha_snand_nfi_setup(struct spi_slave *slave,
 }
 
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
-	.adjust_op_size = airoha_snand_adjust_op_size,
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
 };
-- 
2.51.0

