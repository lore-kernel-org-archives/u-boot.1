Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EF7D12D60
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 02:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15D75891AC;
	Mon, 11 Nov 2024 03:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 253D1892E5; Mon, 11 Nov 2024 03:09:41 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20719.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E676889198
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 03:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyMuGMYm3M7/qu7fIp1ozL8cBfMeAo1SMrDjqEF/FJmLvBQsAr0QupAAZlnDlx7D/rNHNhNUqXC5QYdt9e22eOprkgb0+lCL3x/2PR9h2CT12xh2xRDGvH/IwfyVWhE46DvKAZHToFcalMvNX7oWYFtmOMVDFsYs+adkKSWw6h4DfYNx+ZZoXow3NB1C+4Jo/+kMHAvISzn1qchcKxj6K8Gk6VlrN3wjwwEVtNOhZCI51sxUyCi7mIT72e/1lm65OPC6gZARwWxFP+Cs4tdNJt6zsI8vRbdnvDN5+cOdMecD1Pbg42ECbjkLv86jOgGg6NxPr9qEGirNZAnCJ6zJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UdUuc3bjF9uaY0gMBk5dVFM4THlJT4z17Fx5MHzCEc=;
 b=OJflGE/Dq2CbD92QKY7vBJFITG8ywn1+6lwO/Z9wE888XxV/lOjy+XLeRWpmLzrH/LPsjBqRrKEHCFSCrOftaz8WiegfFthN64XLYMs1/98lBdcIryUMjTxW0KHsAExjbdhQ438Yg/B0iwe/vuX5WWZ00RpFm27t9ZuboQfYrwWcLnpcFVL3p7GVZejAIkwAEOMng9SWTEs+VSt5t+ci2Zh3OcxfwyM9zSNdY0CVHt2gOtDosfz9x2v6CwGbv2iSDVqE7Axp6tT4SGnW+gm5QKFMoGFA6Xf9/N7ylQZx9VWTsk89hqsu6tEqWplDLCQVrtxTd31C13i3he6TFazDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.36; Mon, 11 Nov
 2024 02:09:41 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.035; Mon, 11 Nov 2024
 02:09:41 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v4 01/13] dts: starfive: Switch to using upstream DT
Date: Mon, 11 Nov 2024 10:07:56 +0800
Message-ID: <20241111020808.38974-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241111020808.38974-1-hal.feng@starfivetech.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_
X-MS-Office365-Filtering-Correlation-Id: ecebdf43-e004-4fd4-446d-08dd01f5e74b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: ArQS1voR4qPMJJRgaYpi+6ygegSGSaMFP3QIyuLF6W8VA1n0Ho0MFOzSSjWjBrOUZJbDwBoqB5rX7m8Xrlz4Qbif8CVYey21Sho1awwvy0nUYemS/4hZSh1bO8h44BxJTr1Ib+nk3Me+/jlgMZjFKPqS/A9h5uYq61fj4/pG/VxhyvW0grb0BblgBB9QWxGi5B6PrwdD1sKlJXg19661PC5eB795NY6CyWepiuvUy6cjcukkHnB0+f1gQYjCrCJCZ4oaODCau4HOHeVK2mIwXyDfZF90YADYOUFLP7hbh+VbKMsWwq3I0d1ESIpHhBUJ4ikl+D3BgDR83msxGwVXVMfk+jNUkvBzlMPXxcVWZkDyyrqVJYUzgdQoogy1f1wx9wd5l8v/ODCZkUP3s1kNazOS2gpzCGzKwODtbVBH38Azlv3Uj26J69WOYp3LjGfFo//JknTpiyPO/QQ6cb9hNGyU6dmHhxpAnUun6XFXjXTv8/9ceQ/T7AEUcMRjQXDJlXHUJK9lowl3LLEJcq3XJklA4yRCC9MrKrCZHb5YTiTCa9nxlYqfikPKg6cyUQ1CDj0ZhIqbKkDhuhrHRi5zjs/3NNcZzRYLYWuQAszDgYlYEmVyWD5SaqAZqgFTlO+oAj0x2S9wYT28BlfbMESykg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?76uh6OIPBuvEBsqn3Hzl2t32ymIGny6HmFCTlh39c7snd824VepFMgwhO7ei?=
 =?us-ascii?Q?E4yZxMabffztwGVQ/4oWWXU6DiuEayIqDKTqlnbgcq9FgctX7BOSxt1d9wwQ?=
 =?us-ascii?Q?hqeGAS1PbSSKMAgvfoYc3yZ7Uw4SLGidwykC95RjBXOohisTsjGyuCbieSUq?=
 =?us-ascii?Q?ZQjEETWOcujKfbm0elTaO+kdWL7vPd13j4uYDUPnF4hyST5XplUuMSH3aVSo?=
 =?us-ascii?Q?hvEU8K1t5Hqcxn6Bp7LH8eV3srSoe4fJELx/206UBKXit0eW8nTGQeICUk4K?=
 =?us-ascii?Q?SjkXRhap8ACcRHO1qYa129Nvvr1ZtDmuBp/G5ZjMcp4rtDJ7QfsMS688ZJbi?=
 =?us-ascii?Q?afNQmOECjxHEA9QpkNaBju81Fn1v8S1Q0hBv9zCjYduMmtatyWuBaHIMWyD+?=
 =?us-ascii?Q?rs7J+S9tUs9Bc+jINxvIHKA2Ug9AdUVAOM9fyFJ47IOvTeiKENTi7gNK1tKU?=
 =?us-ascii?Q?2ziJ5UcHwBJWFf3SksxZFV37s37JbWq0UmvwuNriom0pvPVjTAYy0LLdbzri?=
 =?us-ascii?Q?wsnIi5QcSkghr7kQ3JXvo0X9FpgyQWCaXzsue9ScR871v9AGiYRcOiw5c5aY?=
 =?us-ascii?Q?oNi6qMiciri+RN8Oofe7mEJVWFmwWxEYHCxsFdz9527wIsyzHAN7dnT7fz4+?=
 =?us-ascii?Q?muMQr3FGpArJgJVb4w7+tcbYWQbxtKZ8/Kayp51cN2K/e9aH76NF1XyLDV/U?=
 =?us-ascii?Q?2sSFt9G+HQjzVHYZvUSMQHzsDhgtvUWAQ94Ax+0azpdBUZQq1WQbNEhEtI/Z?=
 =?us-ascii?Q?ZYq71ZlH4ZrN2F+ZKw9Wiax/QWf7jRleVeoxOk9giLjr1kUa8sL0aaQ2/lF6?=
 =?us-ascii?Q?+qieUuNtBMrk6S3A9MDLNmUcZwgSK76HVg6cyoGxl9ob2gW3uCZ5Tykc63a+?=
 =?us-ascii?Q?V0IDWYuALftx9aTf4MsOg8TD1XeYIjy68pLwzkXpsrujCMn3C+2dIf9yDl3a?=
 =?us-ascii?Q?TcHy5FtcNKNfGhrrImfRrtG+LHI1Ae0EtNNRKzm9eW6RKTvx3ScbupCd85BA?=
 =?us-ascii?Q?kfz6UiHFtMX2pe5VPMtMvGbt2iKesfjDmgJ3VkvcWo7rPESfjnMJyvi7w22E?=
 =?us-ascii?Q?uCTRPl63/H6h7c9OmNmGRvQkrJ8ldQCfUiMlgviYy3NCUQHR0dxNFjLZtH8i?=
 =?us-ascii?Q?NapYOI5jOCRLEMqOfLSpTQGYhCL0j750BKrt9NF8YAPjKu/95Fw+2Wlqrb+w?=
 =?us-ascii?Q?iM72sDoWm636huqugFdkoKYsLoHxdpbnd04LKt7FgjdUHp1N31VO82+oie/p?=
 =?us-ascii?Q?Te5bOJxbn4z6Vm8aI0RqFa2RJ8mIElliBpocxLxGBjXLPWlwwrEBRcqAKxtH?=
 =?us-ascii?Q?AaAZrS9DlAmUlxdSztAbFzQbuW730YLBk4gz0LZgd1lsqua/BXfvLyS69+jn?=
 =?us-ascii?Q?VX9Bioj7c+boYtTUiMUb16QjYZwJoQmtMKurI2QGRyJ1njY7P337Qo2wA8qW?=
 =?us-ascii?Q?CrfI3A2jUSdCo94GtgKoclFnvc8lM1RvzxNx+oqe4WWpav1OCX+4lm/+Tsqs?=
 =?us-ascii?Q?IgmnMF2FaOXsAPAt4f9eLWy+s0yuBgTBha7EjSRqkHAlJpHx/PH7SacQp7vh?=
 =?us-ascii?Q?pRCpTA12ouHrv5khXSc3ErppY/lVyjgwHOWkCuxD0wDM2tIlWVpagH+eeqYj?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecebdf43-e004-4fd4-446d-08dd01f5e74b
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:09:41.6466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncci156P+g7qxH1bAxVYb5E/m/4QmbrCNecCt1m03vsIYBu1Qfoil0uOL3WatdccPzvueuiRcrsHSrTN1oY4i0V7BQF8ZDpjYbT2/H1sgPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1307
X-Mailman-Approved-At: Mon, 11 Nov 2024 03:23:18 +0100
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

Enable OF_UPSTREAM to use upstream DT and add starfive/ prefix to
the DEFAULT_DEVICE_TREE. Rename jh7110-starfive-visionfive-2-u-boot.dtsi
to jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi and set
the v1.3b device tree as the default device tree.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/cpu/jh7110/Kconfig                                   | 1 +
 ...boot.dtsi => jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi} | 0
 configs/starfive_visionfive2_defconfig                          | 2 +-
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename arch/riscv/dts/{jh7110-starfive-visionfive-2-u-boot.dtsi => jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi} (100%)

diff --git a/arch/riscv/cpu/jh7110/Kconfig b/arch/riscv/cpu/jh7110/Kconfig
index e5549a01b8..9904a60ddd 100644
--- a/arch/riscv/cpu/jh7110/Kconfig
+++ b/arch/riscv/cpu/jh7110/Kconfig
@@ -19,6 +19,7 @@ config STARFIVE_JH7110
 	imply MMC
 	imply MMC_BROKEN_CD
 	imply MMC_SPI
+	imply OF_UPSTREAM
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
 	imply SIFIVE_CACHE
 	imply SIFIVE_CCACHE
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
similarity index 100%
rename from arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
rename to arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 11e1332f87..40f553816e 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -9,7 +9,7 @@ CONFIG_SF_DEFAULT_SPEED=100000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xf0000
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="jh7110-starfive-visionfive-2"
+CONFIG_DEFAULT_DEVICE_TREE="starfive/jh7110-starfive-visionfive-2-v1.3b"
 CONFIG_SPL_TEXT_BASE=0x8000000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
-- 
2.43.2

