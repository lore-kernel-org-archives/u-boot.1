Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A99FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 05:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE5E5846F2;
	Wed, 29 Apr 2026 07:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="KAnPjEZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6992F846F1; Wed, 29 Apr 2026 07:12:18 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D91846CB
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyH/UBEhkmN3NPGaf6UbSPaFLsqzXxZiJD27Ri0U1mQfChxP+vrCy5vOnrTuO0LEWbTVZ/PHofqLfj8MLPrMwlekYRkg/mFQjeAZJsrC1tSZwG1tm91oHIbGVSGkSro4pMYy1diAa4dvLY1kEc1k3fjGHUSrs7GSarcoXJh5bbl7PtclXaQGIO5yDtkBCXfOo/pqq3jpvRKLYhDqqEri3x1ys1QOWigOfEGIu5b9QytpB1msCKOvX7vT7LQ0rCe0DC37t6TFIEthjM+BU8YP74x8GKilKxoGkxoayowtmJq7R7SGNeBTSy8DuR8ynLd8Hi/WzPDQPFIggNeMI72VWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJQwUFYBsKsBaEIoo2LYkq5LCOiawat6SLtpyeNj0p0=;
 b=pbyhFVxyS9C7PdPVAGjXaaT34Vx85WNJJbMA1pCswWhRcC4ttTpLlMolKWH1LoPajZGDWmxy9sVoZrMGaVH4wkegVbS4fNB67e8QFhixOMbanY4mDBANkkforKuOT9vcPS0xJorxNuhLKi10kdoARRIhM8In/7EROsAhZL0WFzKSGUahRbvellwM6dZzgvIbA9aawZXzA/hQJML2c73XaREKKf1oXn6SnG3Fba7hUM+btqhVhSugwBXGqfEZKA6bfkB6amCZAhlDluz2MBIOJkbOkC7oL0+vvlxUyqoKiTd/HP5Mv4f04OZAqCyPt1oQBWHiLipufwQ4whZIxfxSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJQwUFYBsKsBaEIoo2LYkq5LCOiawat6SLtpyeNj0p0=;
 b=KAnPjEZhSgqaDVj5LobBPm9OHVwFKNLDIfGn3mGOIv4UsWxNKZrMD8qIeVbErlCEeRxpaBxeimbDNuVjYKtWAoc+/wMpFm/UPr5nSsxCcc5EwbkfymAofr0aW/X3CxuJjBh+SZnE3ly/eoT/aNsOpotZ3Dbr+EqwcPcAtRCNDMy8Ai25s55L0iq6E+BGUMv818sinF6kF21RO6f8l2SSj3huxBiKuClgfGnHri0IIFHIewlBMI1BnW8jwq3Y+AdDuJmaCS05yIGLjyFcUOoWWmc6F+aOg63z1XIZ5EmnnG/YiUtbqWyRXdAsB+83TZ3YP5y1XUJm9HPVPARkudKk4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM6PR03MB5259.namprd03.prod.outlook.com (2603:10b6:5:245::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 05:12:14 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 05:12:13 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Heiko Schocher <hs@nabladev.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peng Fan <peng.fan@nxp.com>,
 Wojciech Szamocki <wojciech.szamocki@nokia.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
Subject: [PATCH 2/3] i2c: designware_i2c: Remove clk disabled codes
Date: Wed, 29 Apr 2026 13:11:17 +0800
Message-ID: <2e5bd18743849a8be91ad4690075a545fa56177c.1777439293.git.dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1777439293.git.dinesh.maniyam@altera.com>
References: <cover.1777439293.git.dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:a03:331::9) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DM6PR03MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: adbf8590-800f-4cf9-53be-08dea5addfaa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: +74lWB5fHx7kbHZfEiO8tAX1mKheNw4Rb+nJUx+6cumkbpYZ+Orw7eTXwcpiAMvOEChA98jYrrnjMzR8jnrP/WyC+T4jgK9hw1k0RRQMHlg6AfR6NQtpRec+xFw7bOayRRKssnttj5wgHYSWzaJgBiHoERqpUDUcJDxziq5SFIc3JPV8xDwEJqq5D1QvljoXaBvz4hyBN/riuCDQhcl8UfHpqQ2eBitL8A5LgnT6jqgOovFQU2/EJPkCdqWfSTkLGCjV+BC7UjpTmPBnjkve8YlEUPij9Ul8KCTGSXNB8VDe+LRL3mLieQbzrqEhz/5JDeZD+QDjEg3lvWPewyN/e70QETaOD6+dyj0ADmWV/U3p8EykEJGsyuo32JmtC1ufeuGUqvPxYTZ4oA/2oIIu5tkGRdLPcUw2VytCsCAvomPc3Mm2bZPR+5mK7a5pA1dg1WaOpv5yYOHtg4Mx0iEDnDQSVWua1EX+nQgOFGVFMvG5jz9fwyCJA+uE2VY7CloHvG5SXoLwk1hlO3vllfRWhvaGALfIBxoI63DkVn5mXciz9SiFn3alxAhAMy0jur6EjgurajOmHYQ5fX0zOl0h9qO8iA2ycCTlbliP/bHrlVQdlPhuQWxcYps6a897/sLkbBx7wFqyI7AKq6UFKSqzP/J3EPFXDK3BqOzKaGjQWCvydWbw4dncMLRRJ7WHuBLTLmLtZIrYQIreg6abpWAXYnb34KIho79Sh+fBfQL/F20=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7aIlfygBGBuXZCOUfo+T2pGpH58JUWJknZWXwfeocVxiiNF3j2hAmHk4UkFv?=
 =?us-ascii?Q?ZvIElFSsfuB4V07fOHXVTQdnKsRoqadM2EeVA/H+26L5fIVTDlITR/Cp9cqj?=
 =?us-ascii?Q?/R+pPa+GozQEL+JTGy6uITxnNSMJC2u5VAqWfoncPDer1IkxxYVfWkJN9ele?=
 =?us-ascii?Q?bPCidY0bk2/d4QkNNNvybQTtl5I51+NvTfTXlEAgQRh458rCNu2tIFmIOR++?=
 =?us-ascii?Q?SM3VyOA45SZ2nvIg3BTrPYBnlpQNwV83bsgOa3yWbl6LFh7mTaVPj42712iO?=
 =?us-ascii?Q?vPQEb5WYPYkUKU+wOCAZNlwPHFHhJOZtOAQsh3bUOJnLEfAfDwJYwH3YVf2U?=
 =?us-ascii?Q?UVeV9DLj5/H6xaQ7Nsgs0VOE4LK0oZomLe+BHLvpVEAcmRit4QxKja6Skj/a?=
 =?us-ascii?Q?XjhNp/nW/PO+RaJmn01iks8h1vCHewgS/GR8flBtL1ShQpBav8MKVPvksoIA?=
 =?us-ascii?Q?qUJEq19qj6Wn0TkjT8cWFF5Wq6LzUNEQ66xh4IjS7HJJ/pZJoOEpYzef1C2l?=
 =?us-ascii?Q?AD8EFXMyFr5EaGNUQKe0NVHGSfnEk1QEHsP/rOFDr8fndGsRyxHGkxJgBHfT?=
 =?us-ascii?Q?Ue1uv59UyqIVZrWBLsN4Wn9g3GP7MPIzlw9l2W8gHD+OJ/m72llEID+QHp4P?=
 =?us-ascii?Q?WqbNXbloB7cE+kxdUQvcSpYk1zQCecglw+Rar7fK8EcRLSy3C22wI3O89r49?=
 =?us-ascii?Q?1EpPLNout7TSfzlpaj09kGYwGENavVPOUKGjpkZsBQQ39r30b7iP8ZPsTd1B?=
 =?us-ascii?Q?x57Ew/NpsB0L6lgslhc2ZenxfxZSDmnAhV1ELLpEg/J5SkKq7OLNtgluOIMJ?=
 =?us-ascii?Q?2hgVk+n4pPPqylBC0Vc/Q1GWntVC7rh5t9no0UDy4XK/gNKFYBPra5P564wg?=
 =?us-ascii?Q?DdXdKISXbpn4jhnfWEOAnhGaiw35KrspTNvLmAZBLv0DAsgOPQFV1CNPdntL?=
 =?us-ascii?Q?HP9Q1TRQPVfjFWatRqyjWNFZaHoUT5fkhjujj6GLKFsRzaLt4ChA8OT2buck?=
 =?us-ascii?Q?ow1mjZxPJaPlRZ68zW+aB7ZyfU/GN9mDg/F6yF8zulMOmQxW3HwdauDbna2D?=
 =?us-ascii?Q?objeexZQ7ZqZs0QHDrJ0apbBYKXUmSv5oXx4nR1nvyhos4zywAGpTHXAmN5R?=
 =?us-ascii?Q?RKuAQmY6crtcDukjqZwRsGd6gDhSzYJ+KhleLOJuBTOVBzndL8bjEskktS80?=
 =?us-ascii?Q?0HjFYPXC/2y+BwNzfrSwGFaeKtJRYapt9wZ5zoJdRv1vHrm958jOqQUNB/Mu?=
 =?us-ascii?Q?LtoTWBWRWINPuW2HxncKqgscu7crCXAHmpQJCtPSa+cQwS8DM9IxynbC30Wd?=
 =?us-ascii?Q?advqmzAffxvZAbpuOfYfy1FM6mQvhs9mjP0eBm38R9LUXx8TMuimw5zGnL37?=
 =?us-ascii?Q?Xu4ckXO0j08fePJCaQgs3ERgALqfHNUZBUCcPSQEwGiASEmVWtKH55GjWfpe?=
 =?us-ascii?Q?DHsg/X8CjpKTGdi7wrpo+uzLa8gfVJlq3V/9FD4eBpRyNPpwTPSWaPlgw1HE?=
 =?us-ascii?Q?VAMescTn/xU5iMw3xZjLEq+9YgWmXAv89xVkK/Y7qPRnJw8CUJNPtbFLjxtE?=
 =?us-ascii?Q?nzslnS0x7z8eR5XEn6qInm4ntXLNTka2gl5uCb8sTkfniuB1NKrSZc+eslaH?=
 =?us-ascii?Q?R2Ou+ADBPnOjga4aXDTVgXk31cjZeJDFDJI9+53nvpoEoFORduMyD/P3k5eN?=
 =?us-ascii?Q?MQWZZMFdl98uunzQyvOz4i0fWURzPtZdcxShX7voO3tyvv7O+JJAdArbzlFy?=
 =?us-ascii?Q?nZTTHCHe5PN4XbEtAWLs40QVezLxJQQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adbf8590-800f-4cf9-53be-08dea5addfaa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 05:12:13.7691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjGYshXRPWfomq2z41ZPJRSmlJy+uOvtVS5BbUgofUPsR12TqNr337Y7Y4RfJMfby78MqOjzwvuawCA61ag7dMfrQfpDUSilZsrh6EpFOAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5259
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

l4_sp_clk is disabled when i2c device is removed, this would
causing unexpected failing behavior for other peripherals which
are still running with l4_sp_clk. The patch removes the codes
implementation for disabling the lp_spl_clk.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/i2c/designware_i2c.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
index 8ad716f410e..40153c72545 100644
--- a/drivers/i2c/designware_i2c.c
+++ b/drivers/i2c/designware_i2c.c
@@ -807,10 +807,6 @@ int designware_i2c_remove(struct udevice *dev)
 {
 	struct dw_i2c *priv = dev_get_priv(dev);
 
-#if CONFIG_IS_ENABLED(CLK)
-	clk_disable(&priv->clk);
-#endif
-
 	return reset_release_bulk(&priv->resets);
 }
 
-- 
2.43.7

