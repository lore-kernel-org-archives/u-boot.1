Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36614C3ABC0
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6915C82999;
	Tue,  6 May 2025 16:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cB58iY6I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CD34829D4; Tue,  6 May 2025 16:13:23 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74ABD82905
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2qkgGtNxaH7FNE9Eb2kVVdcV6FHZhFVxG1v87j4jmKj2pkSEUgWvRAYYmyxvJscUHsIdoE0Ph+G5f23HQwsmaGggTonjvbyXpz9N6V92Ga+c3SkOGCvd0fcwp8+nrPoaEzvAkSQF+KdctNNSOgzkLoHEa1pHlycmUb6CnGGneeMCYWKoULZVdCiU7kZwFyrbpT7ZyUBHenJJibVS23Dm0IrVM/dzfZyiCtA2YLkgyfKBl+uqcSSkVfnxEZ8ysIRF8gDA0/xssaFqxipJQewUmIY/izrIwLj05td0Buh1YE0YcZ3EvUca8LtdZnFyoT6F6tMx4pn4ugOntj+fQ0pRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6p2pVwqCThv/YW5BOgYdTSkWU6SEWBz31nI5A+AkAs=;
 b=mczBOWpVC2C2/TQ7L9kgmWfIhl4FfgfKIcppgkAqVH6imkj/txVfZvCYy3FsnPjE3qGAo43J3lleJ+ZGG3njt7rvAyKcjE7kzlpFP07WXu+uuDCQaWlcqBdILhtE+TpxHh012+sdsfRIDT9NyfMrRfn/NMLClcEvFct8J1G3t6UrthPST+ZDvGyGQGkbZMl1AgHeKzPFJiUAReWB3b00+6v12PkWXrZ9tUHpOcHjeCNWsVGCaZ5lVnhDBY4X9tkP4bgJoqMwNd1hFXk8tnjxjpA3LWCzMd2pcxl0xit72NiIIaAYWDBDhBINUoldymhVHCMFp/cQGjjZIksY3Yzxug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6p2pVwqCThv/YW5BOgYdTSkWU6SEWBz31nI5A+AkAs=;
 b=cB58iY6In47MX9I1+bKnWszdGdpBfRir5EbIJSvt1z7HDztbnZVoPrx00AgMNCmC7iWwwMlfpRRPWu1xLQhkzy0+ERAqG8MbmveuI2jfDdRbYVt6w4Qt4cSo/MdqAvX9HIl5ogDVutcY/C3FwxJWq09qbT/5APNmaCSCfBSKwv5MMMsCjWN84QDEEPKhdEz2Rk7l4JrDjauLCw0m+AqJIS0vRaNmgIVzbIEptDkWK9WDWMewFwisOFEUwN3veRq6378qO0qX4aETBHumnWv/ZqmCKVSzI1VT6jgbZF6r75rWin1mNJlLp3VXJYeOWjwRBL9cuVHt6CqFp+gqiFI3qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by CH5PR03MB7934.namprd03.prod.outlook.com (2603:10b6:610:215::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 14:13:18 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8678.025; Tue, 6 May 2025
 14:13:18 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 2/5] drivers: ddr: altera: arria10: Add valid RAM size check
Date: Tue,  6 May 2025 07:12:43 -0700
Message-Id: <20250506141246.6672-3-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250506141246.6672-1-nareshkumar.ravulapalli@altera.com>
References: <20250506141246.6672-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|CH5PR03MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd6330a-364d-46ed-ae5d-08dd8ca82631
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MrgO3k/tjkhAMCHQj8i95VaK7sMuKcfksEvybtqRO5Au+G7SiI5VY2GYglDS?=
 =?us-ascii?Q?nu/H9vMAWsGZEyGGWwQJzcbrZ+K0iZu4xGTDOjClQa54yT6nStigoxZkX4+x?=
 =?us-ascii?Q?xv+V81rxbtKdE11sBhzYNqmnRaaSJocNDfxz1dQhyKlrdl6UnpXvBx3DwZs9?=
 =?us-ascii?Q?EAwiuaI86DW6d2pV0qTl2T4yj8RfTTUt7z+JD9jefrYRjHc4Zw/uw++l6qX5?=
 =?us-ascii?Q?qS27YaRLzUDONmqshORiMQiOfMhxfZQOQMOb1p/8NfBA7wk3jFsrm2jxL1bz?=
 =?us-ascii?Q?8WMm3OPdgY3rIvXucqf5T2HyOeDzGSSHm6WX+d+5ctyeQRMCqa+KbfMnLUyM?=
 =?us-ascii?Q?vPmewch3zn6Gs5fIlUfrWQ9zpEBuoawEeTSzj2Z8a0Nx9TcGbCORo1tudNHo?=
 =?us-ascii?Q?KIuRzPF+vgQT4etjY1f/NGh0x462CFBPRwV+CVACc7EUC0jqmGuUJVtrvtAe?=
 =?us-ascii?Q?Q9O6ZHD2Pam9PFWYWJw5xEyeaBIoycM6HG71mLl5ISqhQ2UbXfY2yx6sIMDE?=
 =?us-ascii?Q?kyh7UoLcsImUaTttnkU3GBeYY7r07NKqi8O/7l/RQFSDujySKqWrxL55Xcrx?=
 =?us-ascii?Q?uT17xCd0fBo8SdrWTRSmT3zC5hS2iFMPe+weda0F4cF2q/X7I59xp79rwrs/?=
 =?us-ascii?Q?4K1Ji66BzecfzKznhLPO5224y9LKSukaJMXWFhHlUtNQa5MYj5/QLJGYqDid?=
 =?us-ascii?Q?fHMO3Y2GZA/vT1M6pST+DkC3LsHBNqYMFuKCayF6LEjuy9e5a2MwrhM9GGgS?=
 =?us-ascii?Q?xjkyOK/bk2cPrVxlR86Cj3oe5LFtIf/TERh1K7YjbFMXAMYSQxvR400watA2?=
 =?us-ascii?Q?gP5XblzVLrPecxajKh8jIkJNVXXcplGRDpEQ00XhaWRy7l2Rc39vjIzfwYaD?=
 =?us-ascii?Q?BXZdonvcMN0ig3ujLX3uPsMleIgLHZ5LmCFp8Z1k/MNVT3K3lpCkJHWHozmM?=
 =?us-ascii?Q?u4Ypc8x7ijrCFaOe6oZC7yzxTmk6efBgru4sWtuWUdXWCWS0tCn8wOcMopQ8?=
 =?us-ascii?Q?2B58s904tdAMpU24EdISKXTRyYEGH8hAhn/60MyuowRy/fKOu+f5oqn5QG86?=
 =?us-ascii?Q?KzYjyjm8NDJYOQHtpTYWr1E7SdB4GDTk4nLzDCfZB45mgUxlrd8+IHFBvgtu?=
 =?us-ascii?Q?aN9NVlKXwYzmJiFoD2jEl8XIM6IZQ89ATwqIHFsZozYDD31GhSc8KiInzwtP?=
 =?us-ascii?Q?nixN4IXH3nYJwUfwAdO4YFFliJHPvIEBepYUwp6U5K9GIjDhi92jOZAtFy8Y?=
 =?us-ascii?Q?S3ZBdCLySjIWgBtdIdoyniuRnaa5lItFmXTVwiHqVq433YCzMiWpFRgo8Q4v?=
 =?us-ascii?Q?jPB32V95xKxSLIUlePb5RgR+W5ic3ptNBP07n8+kIfswzMwKQ6Qwm4uuxDnF?=
 =?us-ascii?Q?npz6dJaAKcZYFGyIqjEGTQQ19BxUl2T5YaQJbkb4j5Bn3bTdC3mZb/4dBuO9?=
 =?us-ascii?Q?ku0qbBcQt8Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cpOsD9tk60CzSN636dPAaWnX9GoJ3RdtybQz6Sdj8z2QKPTHyFHTphG8KGQr?=
 =?us-ascii?Q?L7mXpMVi70Mw0vCWpwY3zx148+TUApFt1Hx1tGYvD7kC4jlbhu15UbzzDKpQ?=
 =?us-ascii?Q?P2O3nWMHRdEhxAjM0vEydMFx+K6V/b5IjGdQ57hFUuf7fCh9/M7JCAk/n6Hk?=
 =?us-ascii?Q?V89UXjy8BGFIn0bZUl9+D1qVMPUeN+5N1xtyU/f876x1NxNUKvMGYsUYJaU+?=
 =?us-ascii?Q?PAm2cFe+/pXO4X6DAT2OW6kS1VNkZsOyAPKb5/Prl07Xdn03GzC9YH+Q7pgP?=
 =?us-ascii?Q?YMSc2oZxOwFMFJQDNsbQ8ounTcwCRPbo9M1dN1u0cAA58Q9OM4cgKfovdxIv?=
 =?us-ascii?Q?UbO1Nvq6rFyzSkYfwQmhv+NnVEyHJza8/UhZWwlTLh7ZGAfeT/6sM57/URpv?=
 =?us-ascii?Q?+WF3yajPrc+7Fk0NmYAoSaZIcCz+4r/rwkufkSerp9KK/72Mq2oNfGU+j+97?=
 =?us-ascii?Q?qy1jgGOl42qMj0v8xGCESZ/xdksGz/ZHcUFku7mBo0iBLa9+1j+QU2OMnc1u?=
 =?us-ascii?Q?du4WkAK27RzdK1Le+4I/mXlGG6ysCLaHktZFzHWOdDuGsM0e5zNV4R+WAIYn?=
 =?us-ascii?Q?CNkPjdFT+BgJ4WugryrOTKt47cmfuTCMjgjJh9CIF5r9CHBWvWMdW9qgMkN3?=
 =?us-ascii?Q?rdCR6QIogNfXYOybnzgzoQwSTRTbWZ7YkP15CVgHezWbwIgF6DTqWepuEM9J?=
 =?us-ascii?Q?LBrd1Ae5E7BSzwDmErSJgmOvcyPyZvV+70bSQbx/o0QZcUj7vX8yYzMjWZa4?=
 =?us-ascii?Q?FKe4Kt+JjKXPpSQXMBx+NMMdVujCwzBNJfCLZDEmgW1D29ACfaG2+f5Wxub6?=
 =?us-ascii?Q?waI4+SIZGM4mmx18GVbqLtfX5X5pB5lQXAIv/zN75UddRa1iQvDIIVeLOgwg?=
 =?us-ascii?Q?sDssBl+u+fVEAGti5obARDFC0KhcQ42aO8AYI1JIMfP2aYs/eqI/RpF/WKF3?=
 =?us-ascii?Q?UMfgELQZgsQepN9nCwf4OD+DQC7rnJPBd7x38ju2ATxUrZvtjhQ22qo5ivly?=
 =?us-ascii?Q?LLSPahuGfa6Cep1ltbFGjvo1pkMPi2fqsu/9a6xGzxw/nMhKhTLxRq2Li44m?=
 =?us-ascii?Q?/aDUiOzuuBzCyQZxsp3n55AkkQ1aSIRorHg9rsprcOzi1mtBHdka0U+tNYJB?=
 =?us-ascii?Q?tsW40xp0+6u6OCWhKOqJj5zrYEuS9fZ+Hg01rzWofGdbWKdqeeHSSlNk3Gc0?=
 =?us-ascii?Q?Dzb5nLEVsmhO1NhLCOXVJ41UCzL2KHvNtWr9nE0Fi2TQCMUUmFu12H0xZQRK?=
 =?us-ascii?Q?nUXqtuBp3Xqtmru+209o0vabOCobXHj2HdpRsvZ7Ggmw5BDjpH2jDVMLQtEC?=
 =?us-ascii?Q?tdizGL4l1maaA8qzov0egKnuN6zT1ZBao97SZCfJlUuYqcqf6t7HsGKU+kT+?=
 =?us-ascii?Q?YP1JiaXuCBUB+lUe61uugKSh5fpV/aKK6bSb+0/HAbsICFIkqHN09yahKzhD?=
 =?us-ascii?Q?NqXlM6uemGufMv3Z/IwqjmAyu0XrwVKfCdZU4piO1S/xRflnTpWRajV4S+Cv?=
 =?us-ascii?Q?t543FGjffbxLTuLrNfBGyjUMgHW+Pj/X6ioFa3NE3tfTSzf1mIsGSBh9slV2?=
 =?us-ascii?Q?imxgPr1ZyeKWQe5MufkCvV6uW/UzpkEr9+StCCPivfpg6oxyh5aWQSAACzsA?=
 =?us-ascii?Q?GwiCd0mcGbKNf3/9Cmgh340=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd6330a-364d-46ed-ae5d-08dd8ca82631
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:13:18.4360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjF+aotwaMvlgv9EGlGgiErHqFJ3PC8O+spXtPhMtgNeN9eSs9qlVJ649DBl4jOHcAs9Z1D4z9bKcn+YWhId4/dPRAwzv+4WgqV5h76NRJQP4JAF8eeEELAM4B/eQWiK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7934
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

Add call to get_ram_size() function to check memory range
for valid RAM.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/ddr/altera/sdram_arria10.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index d75203a1d2a..4a82af0b711 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -669,6 +669,22 @@ static int of_sdram_firewall_setup(const void *blob)
 	return 0;
 }
 
+static void sdram_size_check(void)
+{
+	phys_size_t ram_check = 0;
+
+	debug("DDR: Running SDRAM size sanity check\n");
+
+	ram_check = get_ram_size((long *)gd->bd->bi_dram[0].start,
+				 gd->bd->bi_dram[0].size);
+	if (ram_check != gd->bd->bi_dram[0].size) {
+		puts("DDR: SDRAM size check failed!\n");
+		hang();
+	}
+
+	debug("DDR: SDRAM size check passed!\n");
+}
+
 int ddr_calibration_sequence(void)
 {
 	schedule();
@@ -722,5 +738,7 @@ int ddr_calibration_sequence(void)
 	if (sdram_is_ecc_enabled())
 		sdram_init_ecc_bits(gd->ram_size);
 
+	sdram_size_check();
+
 	return 0;
 }
-- 
2.35.3

