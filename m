Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3815AC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEBD482A0D;
	Tue,  6 May 2025 16:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ApjR+YpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A00E682905; Tue,  6 May 2025 16:13:30 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88AFF800C1
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7q0MUjsdgn5VLRPgTPpDnSsztGBfObHCF5oTvo+R56CBA21s5BflTR3c5DknTzBEhavz4dH+vL3NRrT1RB7P07p6LU+y9IKgcyaCqErlJFxf+4oRSsfaaCUsYukE28xhOEO4h2gFqT4D24HafhDjQYdznvezgCBgEHGFzVt2yF4cmff0LvXPyoiMZFgjgeHpNltVtnANGCBdtrG13rAVy8bJb59TSgxLvG6KH8eSOkjmlcoE6Snpx9kqtUwnYuyTZVGSSSwbdv6Ub5Nmbh0s6GtCUhTvOH7lDN3DvotZxXLCA1FtMNxZc7vQ320wvDDU1SWrtpemclk1/5RibG8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxDvRypIEdjvo1OdRv/u8aSgBZqut036GaaqeA0TXu8=;
 b=TeWkMrVEaY/UNtE7CZjsx6OxmImFECTKV3OJ4BfbQ+edrQ7ZjyGElD4d/5tZH9CVjQVTkoXMIPlAzGpZVngxbADYekbVzoyjORye3MsUyhMktslQj/6fC357pANDg1wvYFaVSMf11D4dPr6AG+MSPBGNm4JdPks8w+Z3a2G7KOotIGL5QEVqpxbOh9eZ2w9W9FRRewhkVy0OOLXiEIKv0D5ORN5FEg1w5vBDSos22svQJa+O1GUTdAZ4MauK2+5oN2XPIwtdiN3mOygTfP5+SfrXsGK69RwF73dt5F5CTv5hYjc74r+VmRnnSR0iXCaOxXjJukWcpj9niXM9E4BzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxDvRypIEdjvo1OdRv/u8aSgBZqut036GaaqeA0TXu8=;
 b=ApjR+YpCQZuQxDC/uxuFt7O99R42ywu/NSbE//ZBpNllHHoqbynxzTCzvSoyy+SSVoWbENsbOSvlJIRuniOc09i8CPFtarDgwVl4kyp+3QUiFLusn9G4XifdpOscm2Xpm1TNdUegF4+9C6GPYxM54hAduNYfTKc16mhB7VkCD1pAlJYrzn0ZsOgmpghQgfDLbvvcJTebZM4plO8iaPGIWejIzOm3HriIJ+9jpkpcroZyK7TcnU3RYd6O3alBu0w5MBktRCC2iU8mqx1V2xz+fi6DIyPuG8d6TI11scHd/iZjy/nvUvBRUBomqqDpxYrcTHyMe3zyB7URKS3eJCCBjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by CH5PR03MB7934.namprd03.prod.outlook.com (2603:10b6:610:215::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 14:13:25 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8678.025; Tue, 6 May 2025
 14:13:25 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 3/5] drivers: ddr: altera: arria10: Fix incorrect address for
 mpu1
Date: Tue,  6 May 2025 07:12:44 -0700
Message-Id: <20250506141246.6672-4-nareshkumar.ravulapalli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: d5e4c76f-1265-4d14-5ac1-08dd8ca82963
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V06SKQkI+APMJ/HhtgazkfzExzfBrW6ecev3rxxalx4IRTkOO8UeUprUql98?=
 =?us-ascii?Q?dtuiDB27OIGyvRcr10tl8NFv0Kd73OPC7Aa1MMi6+1P7f6EQbOkUjJ0sSh+V?=
 =?us-ascii?Q?UziWawCkh5hGZp+UAfybhHang/ix4dhMeZY2tlnGG8ETLIqLiTOvrMt7Z6tY?=
 =?us-ascii?Q?Z0o1okXe8UMLD6/OTPvPySZ1vFT4nNXFT6jSH+jaM6ZfT0riud5iSyMlkPbH?=
 =?us-ascii?Q?92aoJ54UGZMJm6qLZjj41fH3s2z/spK/HZpgASzQj3r/F1UlKc2rb5xjZGFm?=
 =?us-ascii?Q?HP5xP4yg5AWlbf3C9a2knnF4PSkdBqMA3vA04P4hmdJXjdbXW7HKNIki4fGO?=
 =?us-ascii?Q?olalEsCE9sOlUwAz/ObPbV82HJ0l2PkMaI94BKAMSklOEt1CgVPop80yoEcK?=
 =?us-ascii?Q?92dNeISmgyyu2QfWBh8GgZWQLd0Xc8YHw0bJ6SuORc8nw0V1I7kft8tXk1HR?=
 =?us-ascii?Q?Fsfbg+gfGtMpbuszFU24FLHnJU0M3Yn7azfVR9j3dhZk66lO7A/n8t+zmJSI?=
 =?us-ascii?Q?UAE6azy/QuJRAsopDHiEyR7/LZx+sPkFT89DjWJFIEKWeVT1DaKwi1s7bV9H?=
 =?us-ascii?Q?8T+MEGwC2IEEnlnxCQakVg9grbAqL3t39M2leIsY6l9UluHkUeA+IVZ+fBiM?=
 =?us-ascii?Q?tYZimOFdt0YZ/DMl9dNLiQG7uc59hxy3wjXG8L025k0XBwaSn3tJIi9+OuyC?=
 =?us-ascii?Q?ZekicpaWTgeOmCt6MIaXys9Luwwgs67c5YeHgkW9p0eqoRH0GsVrWAwtW0oI?=
 =?us-ascii?Q?ByVxJmrLpYnxAUKYvgHNXqlFQUx8a76fMoAUrBVMJgOyVF/Y96lisozPvL5M?=
 =?us-ascii?Q?7TLiyn4WOFwVza4RNmOVMQwv8K4iYLgacXYB0vICKuM16kS6DSBWjCSd6tdd?=
 =?us-ascii?Q?BvU/b8YKTuBoIuysTJEIhg08+MthZPKDcz9V8JAcLrKP8PifRWjz4ID9S51h?=
 =?us-ascii?Q?h8olcaCTMxS3vP8yzAnx2iVGfqwcimTpEFSD/kxo5M3N4b768502kbCGOlm6?=
 =?us-ascii?Q?fjVOb6Ga+bhrQQXkCdSFfs+FtqqCeEp69TAbEFP9d9sIrB2y+R+1dFmakza3?=
 =?us-ascii?Q?zA61j0R2g2j767FZaG6d2J5mqcYCr4Cr0qTGVC8oOgdBpnO4mjzOZzgYAPkU?=
 =?us-ascii?Q?ZvUXOWql6lv8TUjr8aQCBzT5IkeVd7eRo3ryBCqPLYcTTCI/FpOY6DRY49yG?=
 =?us-ascii?Q?3KdXTpHmkDoGA1ROeJeYrT5VYS5f0fN/vESYTiZqfTB1d+GS4ar/k7iKZV4Z?=
 =?us-ascii?Q?7pjKfAY+ZtnyHsvtcs2tuTmjbv+Gf+OPXdb4tSuwv0N578c7IslmrwcGxvrW?=
 =?us-ascii?Q?GOuSuuG6EjhEe30LQ924mfM862W6M+5f413/YcilfqRDcyD4wXbOJ/35JlH7?=
 =?us-ascii?Q?3Klg66oN+aMpbW24PoLKK/wYUzLsibqNVz316dxfb/CCiYJR5C41SxTgwpMK?=
 =?us-ascii?Q?1RNv2RplNaE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SeMGTfrjHt3+weyISraRD9qI8ofWre7yITuGS9ja6UPgl3u5j0zgKvJc5wP4?=
 =?us-ascii?Q?FpBa0pcKsRc9MUQ6zWxADvPNCLrcOF2TEO6L2rpHseeIfM8j8xO7CTTP73Nn?=
 =?us-ascii?Q?fVh1ws+zGvL8aTItpuzJsCOEH6yLwRP3KyYTifGxtlrSjOHqiPZugO+tI5+d?=
 =?us-ascii?Q?AqlMvqHZU6l5TP/jzlJnQYQL3BMCRmuukLFnBpdcmLjuHBEL481j56bAKa+C?=
 =?us-ascii?Q?eJgRBcjy1Qbzhl9I6BZQYUOZv5+ayQ5lUzw83dHLDOqA2Tql0svJYr7fo0TU?=
 =?us-ascii?Q?kFRO/91wcJ8L1EhYVGxGooG2t39O0k3pNVvJ4zCqWAjW4mBCtadNgY+BRdJt?=
 =?us-ascii?Q?OFZbDDzl5FK8CCWu+skrLBjbR35soC/JsOSej+dFcM/A1UZLLaQiVgPtWY+H?=
 =?us-ascii?Q?xSvI2Yi4OpxQ0YwLTI5naDk1DiXa4eQ1p8KvpV/xuS7pDKClc7kBfipbiqK+?=
 =?us-ascii?Q?GsoqEmQeXivxANalRy2n0BwCCdGCrbofaDN9vajCai6aTsOPshoOJLrrA7mZ?=
 =?us-ascii?Q?HYialx5NAxN4/8QghDr0MCPmZSbtXjfaNetDCMzVyWKBtIFZl9+MP3SeSc6U?=
 =?us-ascii?Q?O+WBCI8L3o3adL063LgDxyWOnJELeY8TKkIj7QLNUevnNr6gvFvAh0VY4Nnw?=
 =?us-ascii?Q?rGrcFp3NDws3DVsvbmE6VswYe2spklBvxFHlBTpeq2OMwjV08YVKBFR6PZzs?=
 =?us-ascii?Q?gxMipGlumwL9xWEbi2+RgWc0uaIBmuHRSTvSbVLep/TsOzwryUzj6i0OuCL4?=
 =?us-ascii?Q?S+5YvrAQ9tYlIgLN1uJ1Ei1LpIMNeOj8bYnpD8V2ZydFqxE4+uSRPmo32TjR?=
 =?us-ascii?Q?QmypzUrTCtHhcezqEHLvpph/3Ng8F/AJfv8S2QhZrAXjHJVKA/und//fQLpx?=
 =?us-ascii?Q?Ahp3mIL4NR6FbePQeR4DrL7zxx1WiZLEjSZMVdp7LJ8z1nFoJSddxkvWFNs+?=
 =?us-ascii?Q?EgVstphlCSKqVIjs9pgbSXZI+5LcTCEu8AI4rQkOqIRNP278v5cX6IPFuL2e?=
 =?us-ascii?Q?0UvWk0vnFLgxMN3FyxnLQdJrrYsj+P7iaDJl1B7aaX9LAKWZ6ubOFlR2yom0?=
 =?us-ascii?Q?93dLhIrvltURFC3n8NBU7w6JriH6HC89eL8oLtd2HEj1fxJYuDqMU5ZqD+xH?=
 =?us-ascii?Q?/ZQ6JIfyoaOj7pl9SZqp2c58jdDH/idGKilWs6CX16WQB5uMTFN+LnLvuizR?=
 =?us-ascii?Q?f+MQXvsy3AvM2/mlb/LDyLziP90iU8e6B7cuHWEGaLXBe8cenT25M7UQzwcJ?=
 =?us-ascii?Q?kLm/8mOdfEXYv5SGuAYx55hl90Fi5FRO5PDJESRiiT3InqOaLNW8T2+kJ4Jp?=
 =?us-ascii?Q?s/tb+MoP5Rxlgb4HxNGzfswNlib+5N7YnmoPMLEivOTH8QMp34PWEs5+BBzk?=
 =?us-ascii?Q?EzVPM6K9Phm0x7Agnh/qWnZd+Qc8Ku9MRwQ69DPZlmRX+VytUE1i3DulprBA?=
 =?us-ascii?Q?9ofzyxlAsqg0JMk+YAjgNdjLY+A4oXuI8z1idtmiqkspEhfqPa5XlsICMFil?=
 =?us-ascii?Q?8Eo+Mcp3EPBz87ZyfBdIB6TEdtiNPErcxxMajIJO3IIMR6R/2xv7i0OqIA/e?=
 =?us-ascii?Q?20VNJSesgUFl96AW7Ahq8duHimRMbj8rUcUsptRLkoZSyKANnaaW1WVqeFLX?=
 =?us-ascii?Q?TuaAUfjN5h9tOAZUrs1/wHA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e4c76f-1265-4d14-5ac1-08dd8ca82963
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:13:25.5958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeLALuKdPVR226hQG9WnYDGAMAixGvtjBzsN3oC+4Sy0y0etFw8IHIcqQsjVbgy51ANEg8RDDMnrZODaJnpStbtnQBr/s8rMsa0Z0FZacOW/LBGcidDQbqBVlgkXg89V
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

SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS is added in
SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET() macro already.
Remove extra SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS in mpu1 address
computation.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/ddr/altera/sdram_arria10.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index 4a82af0b711..d8ad94f31cd 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -477,7 +477,6 @@ const struct firewall_entry firewall_table[] = {
 	},
 	{
 		"mpu1",
-		SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS +
 		SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET(mpuregion1addr),
 		SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET(enable),
 		ALT_NOC_FW_DDR_SCR_EN_MPUREG1EN_SET_MSK
-- 
2.35.3

