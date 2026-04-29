Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F9FFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 07:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4326846FA;
	Wed, 29 Apr 2026 09:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="rcaKVY3S";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rcaKVY3S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E092846E2; Wed, 29 Apr 2026 09:26:32 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8B0846FC
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 09:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=zOPUiWALkNO+DdpT0pXHWdty+fbZzwDF8+HmQ3re8NpKITmSPODg4LUQ69IK76YAOxKplm+VM0fxLCKwTi0l6sxIsE+AL6nLbfZRLTVGI2kI52qp+37hzhnQ5po5hGwElJU9rgdtmt/2F6oGa3GRRZu9gVj7zQ/jpMAuGVfTdYfQPsd62Vv/w8djX7ZYRcPM4oPuLF9BzNsO0o+NNig3AqIPdEPqECFIg8S7lcR0RU3ABs+6TxOlvB12UgQb9AkbGrXNGqTwi2bN0jOuoDwDXmME4TI+Q/nCVzUKsUP3RhRR5o/Nb8kZ/YlnW5mICFKKPoL+xWeoqFgFTqzfqp4nGw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9jhi4xUBFgjvVVugEdR7bIt/GRgOI54oe02QCGgAFI=;
 b=fUaq1vhqKu3j3mCLkF6sxBuBndDUYTbUXh/+xN9iJ3FmwuGza5sz93w/q3WBc4SorDvTac4lD3e8YBPA7Ef+MCCe9Hy7GzE3Rwu8gvKR3ewsCN6LcI9DUCEbRmkm+To2QeIzQFZG1CCjcsasQNJij99mIVkvzLx9PUW1OchJfYzGrNGuwqZVhqxquYGTGbOhVJUrPNe6rxyr5pyiur/gEcXK/ccpqcCOzys9qEGV/49kkyH+vM19HpmeIY8D0oK1I54+81K4/Ax6Xx04T+mONKSz0aYMl6JSh402Z/L0jOIIKuzr7NjQ/1op3af0D4hE+sLiJe1pWhQE6SL00+NZGA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=canonical.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9jhi4xUBFgjvVVugEdR7bIt/GRgOI54oe02QCGgAFI=;
 b=rcaKVY3SyjbL1HxI0RN6ju9r+9iDQVcHKHvl1c7dCZbRRf/m8PdZR+GJ+TQgLAW1mtv14i16+vZR/RrOdOX9Lfzb8aznD4T905Yu6VSlusnA5lX0HDquo6v+TmeJKA2qxmIA2ekE5EPZfAiiKHPjDr2lkRifqEdUOQqkuFl8nhA=
Received: from DU2P251CA0029.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::31)
 by DBBPR08MB6204.eurprd08.prod.outlook.com (2603:10a6:10:1f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 07:26:26 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::c6) by DU2P251CA0029.outlook.office365.com
 (2603:10a6:10:230::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 07:26:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48
 via Frontend Transport; Wed, 29 Apr 2026 07:26:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qsvw1KbJ+sWAi49LkeeijZuY4kg39V3aq48CS4dremEVEL0tr9JDVnGnW5kbvhEXcGX0WzETbWbiAZnCHSF9AMxOjXvP6tSTluX789uZo5bbfyWG+d3yeeK6yob5CzRKiHDGA3rbWAKSB4XPkUIeulwjC/95MChoWAKYCH1vRCFrnVoinRk8WJ+W6Gb+VDTWK6Ap7TLkvAzEh1++mmub6f1umC8k8gIBR11jS7SEBTinrNi2srkmjEG6pQgikoktCjzd9/TnGAr41ZXjsYqF/4XMD96BA2QGVV4g34jmV5OpZBHost8eisRuMJrvVvq9PiqBYGrVqx/WpfkQk/whLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9jhi4xUBFgjvVVugEdR7bIt/GRgOI54oe02QCGgAFI=;
 b=RjspBfw+Mq2rnY9davVCmgzcdjy2yPpZqO/TYQ1I4NVum0Uhulx76wPj+czatusIzKb4IOfP+38diqQ43OfPiC137mZnf2xN77fJQX2t3sAnnpZKoyEAZwFfoVOy3kXw0tjojSbNNw8Y+BJz164P5RfLUFlM7H25y2dsFXYmUbStbPfdzGdH69CYkK80VvBAgNL0Sd7BVCWZC719JyWlhunfHlFOlFPJ8aC4X2RLHTU4RyqGAEftNxgA1grsvLej7AdoNyWZCSJbAHWKdPskH5D2PWrAdSL/eKyiPu4Fjtqd/LIdf/Gk9/mCAIwhlOXJogL2QsZBBRnTaGmEFYaSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9jhi4xUBFgjvVVugEdR7bIt/GRgOI54oe02QCGgAFI=;
 b=rcaKVY3SyjbL1HxI0RN6ju9r+9iDQVcHKHvl1c7dCZbRRf/m8PdZR+GJ+TQgLAW1mtv14i16+vZR/RrOdOX9Lfzb8aznD4T905Yu6VSlusnA5lX0HDquo6v+TmeJKA2qxmIA2ekE5EPZfAiiKHPjDr2lkRifqEdUOQqkuFl8nhA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU0PR08MB9558.eurprd08.prod.outlook.com
 (2603:10a6:10:44d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 07:25:22 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 07:25:22 +0000
Message-ID: <312d751e-1fbc-42f0-ac40-743350218eb4@arm.com>
Date: Wed, 29 Apr 2026 09:25:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: lwip/wget: don't print progress bar when silent
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 nd@arm.com
References: <20260428181434.179888-1-heinrich.schuchardt@canonical.com>
 <20260428181434.179888-4-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260428181434.179888-4-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3PR09CA0026.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::31) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU0PR08MB9558:EE_|DU2PEPF00028D04:EE_|DBBPR08MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 7240ca38-284f-43d3-244d-08dea5c09f35
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info-Original: HtANjzckBf6UxrUrUlPNX9OHmq5WyDrh0HHL9u15xd0nKwVWiYbbq7SKgG6hd+EXCNuuiqUcjaDMfZoDxu7Y1jB8tvTOwGgCqRe/3w0lwkt5welUq2BU8YsS7e4zIV9YelhnA0sjWrgSiIUFAaEeH9TR+peAVBabcVvYKfwFbio8zZ/M99K32U3VLiPkfAMwO9AIURK6hVc5303h9ZHUnlKxnG9kFQZgGLB0NxXalS6Im7wCY3042mp2q3HAKluQZphOxVkGmeh2SZvgwsPdJR3aq7T8vhUbnnAYUP83IFdlrta1bwuXTZaE+vgYfnhwUbJCJpdXFKm6/XRqWDlvMNCvNbQ3ClOmJpl4M7oB6r1e67obRnpNfIOigKwqPhuANwI3furYl1bBrBO1BZDKphKdO4TkzNVX7W7xiN4VkbfF2jNkLHnkTqcsGPmTDa4RLxV7teiKbSivW+P3wVfVXUOZDvfR8x1nmWjKaSCJcK9t+Bukpu9+v0TicWlFt/H+iqGzhCzEAzL5Dw94Ajx0MMQJG4qyUhi4+CBl51Zp3gpn6IwHvVWrg/+qIhpoazVnqv8LycluVXl34+aGD0TWWwZv0O/uxIxjyFlNtRyE0GuDGDcxsO0QjqojZl0RSeJ9iEQ8a1Di2SC2B88HQQ0MMlNj6iCPHW2voTF+AvWpukEGSwjX8ZVDdgoNeyY0qaUrldLR8QICmMWJxyBtpY2TfvOLGfutFHPd2VJ9/vaYUSU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: lJew/k0rKNfa73VZoqUG4kASbIke6MMJrPka/brEn544x4eoeYG86e/CgNHKm0FH01fmpSm0obQXXpTd/jvSzgpyRL3X0oE+j7ZLn1vlqa6Lz9wUtcX4O/X68m6QGuz2DmCLgqr+hcdBNqPOm57L3aaopWOHfTuJtaQMISel4Al6zFioVGSU6a/Fdrk3Gt3N3OOtKIG84RfYFXwVF3oYEcTV5FoICJ6Z2GJR2smypb/ynoofoLdeQvV0X9ocM7WnrGRN/og+roV779/1QIzICuhS3A7F/kICPZH1x67/5jeRwULDtHccAT2kbeDmhxpHXK1LZ4w1UhOEktu1OcCvng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9558
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: dc671892-82cf-4689-b153-08dea5c07967
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|14060799003|35042699022|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: vrnEL1J/B9X0ySxdYMG4QRDfedXZlUalCOOPFdzBKMo8VdSDkCpJjzQSRHuQ4u+qVLiMZYEbiXRRjhxRpVcSvTVtHlqLg1lKccLr8W4nqsUsA8n3bUd4eO46QPo3hveX+ae/30JBS9XsEvOLVWMFheWcFn9vapQKaq3shoPXoKXLzv3wruZS9AHHLBkZthfjaK93T/fzv7jeCFEL5yDwISJIxlIpGo0SZq1i98vcAYOJWAD7je2sXf90kQOOzRwwmgyAA6807lOj14BosFr1bpr7jyFhF9c6sKA/m3LwBA6a5rSOLsSSL+9tpLXrrSKgL746dz6SKT4xer+PFQwC5zfO2jJZeol/DfzUuOxEf9i7eJll4O0dwNfvHoXk4FmEl6W4Mt2mLs8PI+r7WdgOE2+6HuDva7WRGFADuojxHznHPXuFwsyzTCBaJpviM4ju7F1UXxt+l6mJ0ThrcnJGzZszxlDMQBTcCgmOUvru1p2pDFddiXN6fzOCGv85ZcUi/qfBI+GCgCVfhK2cD96xkmmgNew5/3NBCf0OuyibAPLtKPyrSHJnQAWSzI4f82JSMmPSvx4r9jJEo7UtcLdP6bCJRuQo5ZFR4HqLhmRjybpXpL83JyeolWOWfe0SkS93CireTtc3prO1O5Pqul06t8rpHURF7Bli8pTiXw5VRiv3TGZXONKBi7BvKgU6qHaDVwbGmZe428Q5PZv5btZx3E5W0bJAoDXLp6iDEIpB2hhgMLFYOLgN8xIwgxUvKF4pHQ8/mdzLFiwsV8dbe5yCTQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(14060799003)(35042699022)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AnQ82RPOUMVP1xO/fd4cs0OA/yULrIDwo/xIkEAJYIgvkxhvLjFTXvc/mFiisiOjjcW025LCb0vFszmvFNOFlYzv8ppHrqOHwee9YO7gRt1ZJ2ImttAF9WHjOGT9UVoBi43oTvr3kzwLqkv7G0PHSIqxUAQgLP3nQm3rp+M7OyxVKB0cgnwkFNBeSFYVRq3ExOUEf1BFhgoNYlOgeKtJAMe9ugILNX/TNwIdij5ruhrXm3/nBITYSMdv0COasB/E1rwmzErB5IBnAOR+PfYo1W/WniEWv1G948yfBWw8oLjScNdUXLaR8Z8cLVksJummTcFqqElmoe0XFIvrxUo3Ouxp5KBnb8aAr5BSrR7gasAVYWOS3E5md7raOVKoG7pfPyfBxSw2xEjhgOZfneNPNteMDRUAiFHPcQMDCkaAnPK7LqhQbmpiMG5E8UuLmwCb
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:26:25.5576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7240ca38-284f-43d3-244d-08dea5c09f35
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6204
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



On 28/04/2026 20:14, Heinrich Schuchardt wrote:
> When the EFI sub-system request to silence output, do not output a progress
> bar.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  net/lwip/wget.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 983abe2ccd3..e7d302b7541 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -177,6 +177,9 @@ static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
>  	ctx->daddr += len;
>  	ctx->size += len;
>  
> +	if (wget_info->silent)
> +		return 0;
> +
>  	pos = clamp(ctx->size, 0UL, ctx->content_len);
>  
>  	while (ctx->hash_count < pos * 50 / ctx->content_len) {
> @@ -239,9 +242,11 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>  	}
>  
>  	/* Print hash marks for the last packet received */
> -	while (ctx->hash_count < 49) {
> -		putc('#');
> -		ctx->hash_count++;
> +	if (!wget_info->silent) {
> +		while (ctx->hash_count < 49) {
> +			putc('#');
> +			ctx->hash_count++;
> +		}
>  	}
>  
>  	elapsed = get_timer(ctx->start_time);

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome

