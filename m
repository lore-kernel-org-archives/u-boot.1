Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5E3D60D0B
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 02:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73B4E894A8;
	Tue, 19 Nov 2024 03:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60DE58924B; Tue, 19 Nov 2024 03:06:12 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20725.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::725])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DCE189491
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 03:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9DwidyDxwxxajYXx9NxZMQxdukSRaWcZ7XZQoTUqu2aC5/7Rj7d+z8lM15HuAlvfbkusYBlZMskfHCJDEuiYs3fhJC06QoiWhH0B9bGQJAINuNRBISYqy33kJn0wMJcOev7509E8FSO+jE8n/3qplOJWtfQwIboTbOr6tGoI941MbOm7kBeSalVG9olhRpOQN8ny6nQdPiPwlirRmTCUsFagZn+Lj5zcghW43vgLvR4OabQFuygYii/8bibu/8G+x8LlA13cAuVYqcn8qoYCsYvmtDkuAkj1mMVNPmC96YMdODp8Ap73nLQmd1cOQBS8WStHczHmigTfk7FUS6a9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssGJyXBTj8knckUWPjTdbPNR7/UIHPElgv6DVU32Bz0=;
 b=YTf4q3WH7n8//DGDj1SVnIcmdNlm6jkKrgRrEmEVTmPGRxMh3kNmIy7fv0GvAhgVoIlAj+MsZDopv4uSLca346GydmLmD599PADoPFnQdn/2ETPGtjSBf0CRT/hYJw71SfLGxOYmnxCbAI4ER0omUJR5kzkOsOiyxtVVh5C+eFluAtVaKNIiNEwXXlcJPtuNQgjRAuQ5kqwZIkJ3l6dqIrFlSWAhEiGokw8wb2jG8zssyATwhT4rqMi68l3s3vtfQpU70v2qJ96IB2W8vQPe+tGpE2Ldo+MEU4zyYKxB/9KeGi5bSwMleNiVApnHe/I4QPwPZIuMBUHgFodno2UoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1164.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 02:06:12 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 02:06:12 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v5 11/11] riscv: cpu: jh7110: Sort the list of imply statements
Date: Tue, 19 Nov 2024 10:04:25 +0800
Message-ID: <20241119020425.51989-12-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241119020425.51989-1-hal.feng@starfivetech.com>
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::21) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1164:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6962f1-ebf9-4ee5-2c5f-08dd083ebda7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 5GaqSlM5F603HWlyJGvBEt+VnbFo6MOkVdbp6AuiAp08FXA0xjYHb6rPa8WyfzGdYMrgeL+ZpuzxwRxzu+Wwz3OaPwWTN6OwmnOdFqZyuKPBCy+KyhUndZkuDGkFx4FfALFKFwYxPn4nm9uhzVVxk8gPPsUrLmvlxdPW8ia6SDrMEap3D9IxCa6ssN8TZTsd/JNc6s7kEzYkNlI8aWkqrU4kbl1GqtCqWKZ1AVmXrtxUq5TgrWSL5PBCzPqoG3RKkKpnxZvVeODqVhGxLfC1MyMytW8E+ncuBd7r+IqdS6hvNq6fpBy+WzRvpcMjddUl9X9mbEBECobuMMditGgQoYi9t1PORdaRDEN6BRDgs4KYTBm2ZTc9Mg61DqoY8QSCkKLJ9zGSNe+LTTJDZBlq7/EGBiBAhKRIgJkiZyGeeK7mMyXhWWnl48jbF5bMOF/AEU4dKXd8lhkrrClSKiSq/GZ/maCearqxudCpZBjRZ1mFceolwtnmlMM8ADZgxE2XJ/x/Ue475MwcWnt347QCHJaarHcIbQlUPIpWlIkWX4GBwexpD2TH8dmnwn2A51kwlUP716EAui/sC+8ocHA+OnDglgFw4Fe3gRmHwROjbbh+wtuIAIPWjo9HnUH1xsyQJaH9wBky/Fa1PUVL3o4XrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gQejZ4RxCNDzJKph1YQ2oZ4aJMcRPxhxv8/xveN8QTe3YrC5RSGlU1AEswUR?=
 =?us-ascii?Q?zloQ8ysXMDIWtUEzb53yCD22oeEAWAK9E1zmXgrQM+1ihl8fQC8MPwxosPmN?=
 =?us-ascii?Q?9QKTpy8bKMNjS9/yJnaSq8U33aQzGLMBN1JEPfxph0zFQerIQlRIchj4o/b2?=
 =?us-ascii?Q?qpGSMTQKWyrJ/B5Cqsr8bOr92PvgsfSX4+YNZimDWko/Xua/uQCSdz5kIGWL?=
 =?us-ascii?Q?zbsxfGHtOk1L4P9PlOixvk0BWnWzEyLZT4WKy5tzGi0740xnQCb/C8hhpo6R?=
 =?us-ascii?Q?44cm5vgs8s7mRMjOmSIdq0Sum4JIeV32rJvPh8wM6NkEVhIYwAqfv5jh+nap?=
 =?us-ascii?Q?Azk6HS11+zX3Wl1LXa60+U7smGgV4AyHVbhv8O0bLf3GuqrckhWMO9DYx8+F?=
 =?us-ascii?Q?UIEJ5C7AWle7UJeC98qClj6xxPe3gy4ThIgWtYw14xtHYl46nCwhm9MVtR0w?=
 =?us-ascii?Q?k3rvMWzb3q7tukrrRiQBHrFbYxWMTPuzL2F8yuRe1/Cui1umU9lE4x8RZ/yv?=
 =?us-ascii?Q?Rj31cRNy3ORmnfNAVqPdrv/GdsN5aJkX61GQhxClbXjaHR3eGNOc1+0nFG3G?=
 =?us-ascii?Q?xE66SfR7zHJAwV/xH7Yw0y3paI3Kq1I7Xulse44b9bfQu3Uw/IX1RY5+HisD?=
 =?us-ascii?Q?r6U7feahjb8NkbmMqR+a3ZaH0I9SuT3tHGL+RizWNQ+TLAMUl4KFSs4sqUZS?=
 =?us-ascii?Q?xMufoD134506qMTXSF/t1NDu9bl1iT9j5qrtqwV77tyi/Nc83ky4rIdrVqw6?=
 =?us-ascii?Q?aGKzC7DKAERcZsMbiFrV2h28C/Bii+NFxhXMieGh1XwFR3JAl3zv4iItAXFa?=
 =?us-ascii?Q?4wXkAMDfcJkEVAcwG0S7LcuHn2CwZx975ZJEPlrt5aQw9ISiXW/TldGXHfRt?=
 =?us-ascii?Q?lzPPFMr2LFNF42/UbZgD3W16Jdnyz5+QKlQ2byFMrhban/X/YxDkpLSC3FT4?=
 =?us-ascii?Q?rYotqxRHWKPtza5/MjAT9a8XSfrQviiGTmqyV3bzmBcUKZ0V4Xcb63MvmzaT?=
 =?us-ascii?Q?4oQ99Q5uQWhSb53q3fI9od87+CCVUug7XZVZXhoj9I2pi5afT5KQ2gcfaLU5?=
 =?us-ascii?Q?ooohk3p6vDTPWIA+lveX96kMmn4gS7Uc6HhRwRgHlLqCwO0GJePIx5Gs2i7e?=
 =?us-ascii?Q?/tlpw12bBVpJk0peogWJWMPk2zezH8wUj5QkUPSdCVfeLI95Fu2J2AP4UeQz?=
 =?us-ascii?Q?ohqMrHkfaK2Duxu5euaTIJ8uyfGxrV+ixtWzsi+hVJsV7JV9eqcCUcYCbd9d?=
 =?us-ascii?Q?riKx3Qjjz4rkbWdnFaTGLASI8UucpAS5dEICYAxsdH+L75W4+8shWvpJi7sf?=
 =?us-ascii?Q?QBA3lMiB7LtrLR9jgUiUmtJT7iSv/J1RI2Rxvm1pWmE8JoEwBq51/MmQsbmn?=
 =?us-ascii?Q?t1kvo5rcrNPn6lUpyZHJbUepjVc/s8cM2Qgu2JulJTXUFMx0So+M9Pn0lj95?=
 =?us-ascii?Q?xwHPNE529lmjTkDI+AKAXlujJYu5qZD0aP5Gw2r0cczQtBeWdrHoqhe0bHGg?=
 =?us-ascii?Q?mOrl23LSJZC/xkuLkJqU5U4zsf20ADeJxdmQJkGsvb3TLNxJh4RsULo5p+3o?=
 =?us-ascii?Q?zC3U2e0YHBLPWjnP4s3eAq4s96hUCWPSthkeEFHUAmqMOvamdt0EQjm2ya2Y?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6962f1-ebf9-4ee5-2c5f-08dd083ebda7
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 02:06:12.0540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RlhSCOFvSUkj/YFkdrjwoFC1BFTE4sLmNEj8bsFmEZlCxPE8inKh/nE+5rFHD8Oat7RSezgNNRV0K/BcU9/Eal9fps8C8FSLMzAzjp4X5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1164
X-Mailman-Approved-At: Tue, 19 Nov 2024 03:08:50 +0100
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

The imply statements should be sorted in the sequence
of appearance in .config.

Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/cpu/jh7110/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/cpu/jh7110/Kconfig b/arch/riscv/cpu/jh7110/Kconfig
index 9904a60ddd..fa47e55226 100644
--- a/arch/riscv/cpu/jh7110/Kconfig
+++ b/arch/riscv/cpu/jh7110/Kconfig
@@ -16,17 +16,17 @@ config STARFIVE_JH7110
 	select SYS_CACHE_SHIFT_6
 	select SPL_ZERO_MEM_BEFORE_USE
 	select PINCTRL_STARFIVE_JH7110
+	imply SMP
+	imply SPL_RISCV_ACLINT
+	imply SIFIVE_CACHE
+	imply SPL_SYS_MALLOC_CLEAR_ON_INIT
+	imply SPL_LOAD_FIT
+	imply SPL_CPU
+	imply SPL_OPENSBI
+	imply OF_UPSTREAM
+	imply SIFIVE_CCACHE
 	imply MMC
 	imply MMC_BROKEN_CD
 	imply MMC_SPI
-	imply OF_UPSTREAM
-	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
-	imply SIFIVE_CACHE
-	imply SIFIVE_CCACHE
-	imply SMP
 	imply SPI
-	imply SPL_CPU
-	imply SPL_LOAD_FIT
-	imply SPL_OPENSBI
-	imply SPL_RISCV_ACLINT
-	imply SPL_SYS_MALLOC_CLEAR_ON_INIT
+	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
-- 
2.43.2

