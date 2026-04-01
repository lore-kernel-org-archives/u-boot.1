Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F3A10F6FBF
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 16:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 153F583CE3;
	Wed,  1 Apr 2026 18:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="OrIAn6O4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82643840B5; Wed,  1 Apr 2026 17:05:06 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8047384073
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 17:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ioana.ciornei@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZ47AjZUxzu0cQMlJLloosW0li2s68luNIOdQgHEwhmd1ztZz6PHdzCr0s2kxYjVpUoU+ONqtz95w4iGi1aaOEVY55XgUzW+GyUFYkbkuLqNqwxatQz/kBzWoiDovjc6b2T6HZRvqwtOYcDuSNQ2IwzVW5HKzQQSu2vRRjO93PsytebzxdEb2D2Et56ijTVnzcnKpDdvIzv8vJfY7Av2IrBhyRmCrp+5/TqZLdqiWnifAXgP4wAU6WLELgRoO/k77eb0OLbS81a6r89UskZqCWI3lMj1W+8Pli1FeYIjoQle6gwKZ9YZxjyRug0x0hlstjYCBX5lgFAJxmz3rMr1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIdZvHdm4ddQYMZuab/7Ad2iZDpd8y3vVCDY3xMtFQ4=;
 b=Lk6VFGpGdUrhL5T+MlUdeblDJNzmh7efSPqo3wSblLeC76HNWrLVXNcSkLG6RIXb/hx1RSqZZrw71r9S4jyko5Oux4jx4pHQWqUCLImHENfFDbzdkKEo853RWrWoSHIcApJi4dkoY07JabozF65BrKq1fBaFgam5FFSQ6YzDhYMSZIhgrnV58uPkejraIXMm/Uw/pcwQQH697rxbe4AVqGf1+//INoQeym2agBDkVwZF8VCQY+t4xtsq4LOV5rs8krA4FwfyZnzbMi2ubS2ppH9q5JJQMSvnT7FHV/l/FiR/IrWO6loe4heZQSahXRNLvHN05p6frJLCDH/8TThGgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIdZvHdm4ddQYMZuab/7Ad2iZDpd8y3vVCDY3xMtFQ4=;
 b=OrIAn6O4T4qcdrpVhuYsbFLg6ow5pgiMSLhcBVNpVW0yV3SQXD5sW0q+TljqviC4baSyANU3q30pkOjTRznktmyIA6AeTGoxcq06UCISxixO88XE7fOu2f3pMQ9IlC9d7ASNT7A2X/JNVCVq+QvKtuT+xKFPVHos3ox75A0UafLzmw97eOlJDO2Tr+o5Hc1S29yD4DwLegvK4PaIGyFdRsxc1sSjMtSp1nzqofVQ0P2G/2p1fcYk6cOtyn5P8TCXY2XKMB5WPNHMFLmOrJ9zQ5h0yjYayvfr4JdJmUAwqF4fZCX/ecPX8wdELro0sN7POP40pwdLNcCA3msiunjq5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8251.eurprd04.prod.outlook.com (2603:10a6:10:24f::13)
 by AM9PR04MB8972.eurprd04.prod.outlook.com (2603:10a6:20b:40b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 15:04:59 +0000
Received: from DB9PR04MB8251.eurprd04.prod.outlook.com
 ([fe80::46c7:1df:4f1d:bb49]) by DB9PR04MB8251.eurprd04.prod.outlook.com
 ([fe80::46c7:1df:4f1d:bb49%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 15:04:59 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Subject: [PATCH 1/3] drivers: net: fsl-mc: remove unused parameter from the
 wait_for_mc() function
Date: Wed,  1 Apr 2026 18:04:43 +0300
Message-Id: <20260401150445.3070308-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401150445.3070308-1-ioana.ciornei@nxp.com>
References: <20260401150445.3070308-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To DB9PR04MB8251.eurprd04.prod.outlook.com
 (2603:10a6:10:24f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8251:EE_|AM9PR04MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: ef153e79-e2d0-4d78-e341-08de90000b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: vPJWRl87y3vIDQ1TZePBZkJ+ELhJ3lyL3ng+Qb8SDIbSx3nMidfhMOjMAvN3aXYemR4ZMpCX1rIkmdpgkU9SCBPzcc6EaoqlNipeigtcVkYUsJnRnlc6xWSYTZeWPNtO4PucSP4BOUtI4n2tqrMv7+e5aCU4iomn3MknuK7vIIP7GnUmBNslTMJLvr137S8j/Lq+jyiuA/ir1IJMagklb6y4crIBBGPYOpZjNrzlA+wnqPh2jSCl5GM5iDG5UVyclvVQ6nPQNccetNZ1BS5hOgq0A2SQZMlzosM0Bch1y5urm2yEtpWRf8pefjUT2MiA5iq+1fUNlGs7d3l+KTOoM/GWusj3mKIWMcNoxQRvjCG9OcXC+Akbpwzvaa63CwPROLjkBqhkShAS/yZkkx63akT49k1PkrQLl07C+7ihZdzYA9Lzh6FtMj+xHjBzMe9T2jRdq9NnVyw0dwxqP66YpLQcwqBF0/V3yvh04xXmm2y37kl9rwDyig+fOG/X3CAXjsSB104diIDzBTKkEpf+bjdlyFs0RhiJ+Apzqub8EESqIQyFqwdL9VRs6X/CotXD6HiAaDkKpqFsYIb7v9YMGciqeE9Sg5RiPRdxWn+L5QoQhoPULoGF1yxcWjhO7YQRmjQl46OB86A1XKZxx/PAy4FNd9AaKMHhsVgseWTSvGabVCOBtjZqtYIdaoKbyEOD5SVn1SNf7ONUKrOjJxAPQP4ik4debBZxKxsaQmy4Y7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8251.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uVvnaxPJwyJkNmeSAYzx4xwCFlDd9gq8URDPZNQbcp65jK/uWdz0q/TSaCYx?=
 =?us-ascii?Q?6IKwhPwvoI4S+4B6AGpryUCUrwK4kAuubsfsiKjbasTJa42G6N4RdNd4zPwU?=
 =?us-ascii?Q?se7AesjfsPjxyzXU5s3O/hrDuFr+xkbBiFtaOCIUsg53WAhVHJxHluF6/ngU?=
 =?us-ascii?Q?eKX/IKq3UyDH5i5/ywsil02s5P0E/dsc5tamxnoQZhEOx7uyRw5dT1auJHza?=
 =?us-ascii?Q?+HO/wCZYMC/spbbfyPIQZVB9pTG/ioYAzMD09OD0V0sHcn0lsWIs5Y5LQx/k?=
 =?us-ascii?Q?4974qml7OU7HjU/IOVVjSiF1OWn4+ENkGhW4mda0X4+3g32Apy1mOIB0fAvR?=
 =?us-ascii?Q?J1Mpl+ek189KIl4zM6TbZ+uNXw5+ID+v11CI/KNbaL0KTqJMh8NzqMkpj30q?=
 =?us-ascii?Q?FUVxEa0zdEnv3xn0xVntDOBeJK9gZXn3w2WD9c3YqviRN5wEv+u042/M7fSH?=
 =?us-ascii?Q?t1TBxi9n8szzhH9Z6596bO6HrieBVMPI+fme951E6AT2dq0BNZexCqPPTjUl?=
 =?us-ascii?Q?kRQI72lLefeJqRJEyvjOGsofWJBM6+dgjUnAivFdokeKkAooRBuZIHmW1c5c?=
 =?us-ascii?Q?VzGh0/6pKWBfa4OCr98NB6pt75Gn7saFQEWLx85Jr/Y6zia88/tH8LeDqveD?=
 =?us-ascii?Q?LTVEjIBfCjtaCPYXCJB97bgM2p7ElMKN7y9KL+N4Kinis88/CVkRCnX+/BIr?=
 =?us-ascii?Q?7MvQPJ0ndUKVOnsEmTNygINxDTEQuWp/CJR75V7W7tqM9oW58KAfOtvB9vpw?=
 =?us-ascii?Q?m3MLdNTi4tf2XRsUajkMvpDy33bGRSVqYQOCHkjrtVNqfCnGg+BHh1OjHEy6?=
 =?us-ascii?Q?TrJeR2csr+Cl6ofnYOXH2Qz8FXIUynyedPio18oZ5saxqb0TF27xHcTLlUwX?=
 =?us-ascii?Q?gQsFLzfMxQ8Yv5qkXf2Lp7R+GQcKBoAO0CNfuYJ6/FRX9rZ4U/TVOBwSC+/T?=
 =?us-ascii?Q?xaIrZ7sT1PGjdmVWFtVV+5uv1e65Dln4h+5BrO2YMu/9l7T8qbxad5PixzgK?=
 =?us-ascii?Q?a3AqW7edGuEX3jzDkVE2IV1J+dzObvGSmXlfQdm04VbJubmXWsqrDcrpiD41?=
 =?us-ascii?Q?hVha6OfQ4BwOTXIYSArJvD/jN0xKKfslWEKH5pxiPDOmRmpbaQT/Mn1QmilR?=
 =?us-ascii?Q?rxfG2pjvuImJVpkh7U6BgKU2gFaFYGxLXEQrn0MqQq1VP87uiBI57r0ad3bf?=
 =?us-ascii?Q?HMebDC3QJfAQIzsewKqhgm2MdjHragdHK8uG//BCqZonyHDXkQMixBlAeJ62?=
 =?us-ascii?Q?Zfu/vq5A3egE6R0uximuMOtxFRsMiTng89Yo8OCJHy0vnGIOzc6SMqHioNv+?=
 =?us-ascii?Q?7u8aXjj5lcvU/9d7pMpkZ02HeeK4XcflGY5zZJGDdtC06HHO/XhkLLLh9ftR?=
 =?us-ascii?Q?is/5D2EpczSRiijZCJrWZZ4OVhF+3jA6Yvhdabt2HYYQgD5NkGhCBYNjzzIf?=
 =?us-ascii?Q?hVw0Q6HI9OzVkL/ynNtKJl0inYqt7Jg6CzNiFQWxrQshDmOTRTBt8509pJQO?=
 =?us-ascii?Q?bklIGudlOaxECsRrYMm+uyV9vJni3B3R9HMKvJxUsJTgMLq8G2HGZPO09HCK?=
 =?us-ascii?Q?y0Hak0EWZh68ggleopKLU/Q04+Q+29JULDJq+O4ECOM7RZrTgoC5KM9GHM/R?=
 =?us-ascii?Q?v+xXoYIi6i+m7FklFpE57HVgpiVNQzP6Ho2qW/ttbIg/GgEq9YoLE7n8UpuR?=
 =?us-ascii?Q?xuIuOUuNOmQliMLzA7d1qxiAw3tXYBlUsplX1PEu66tLumAoONfyevNkr53V?=
 =?us-ascii?Q?8yvEW0jXsA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef153e79-e2d0-4d78-e341-08de90000b0f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 15:04:59.4296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIc8/FrmEjtO7CSDWZH0ZI/aqOCbp/hxF9FTBdVp56ap/IpkNNceNrV6aQF4/hN5+1Te0KUA5Cy7HPa98iIimw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8972
X-Mailman-Approved-At: Wed, 01 Apr 2026 18:15:20 +0200
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

The first parameter of the wait_for_mc() function - booting_mc - is not
used. Remove it.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/fsl-mc/mc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/fsl-mc/mc.c b/drivers/net/fsl-mc/mc.c
index c8ed702f50ae..6e42fde536a4 100644
--- a/drivers/net/fsl-mc/mc.c
+++ b/drivers/net/fsl-mc/mc.c
@@ -653,7 +653,7 @@ static int load_mc_aiop_img(u64 aiop_fw_addr)
 }
 #endif
 
-static int wait_for_mc(bool booting_mc, u32 *final_reg_gsr)
+static int wait_for_mc(u32 *final_reg_gsr)
 {
 	u32 reg_gsr;
 	u32 mc_fw_boot_status;
@@ -792,7 +792,7 @@ int mc_init(u64 mc_fw_addr, u64 mc_dpc_addr)
 	 * Deassert reset and release MC core 0 to run
 	 */
 	out_le32(&mc_ccsr_regs->reg_gcr1, GCR1_P1_DE_RST | GCR1_M_ALL_DE_RST);
-	error = wait_for_mc(true, &reg_gsr);
+	error = wait_for_mc(&reg_gsr);
 	if (error != 0)
 		goto out;
 
@@ -856,7 +856,7 @@ int mc_apply_dpl(u64 mc_dpl_addr)
 	 */
 	out_le32(&mc_ccsr_regs->reg_gsr, 0x0);
 	printf("fsl-mc: Deploying data path layout ... ");
-	error = wait_for_mc(false, &reg_gsr);
+	error = wait_for_mc(&reg_gsr);
 
 	if (!error)
 		mc_dpl_applied = 0;
-- 
2.34.1

