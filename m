Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822B7C87FCA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0876B83F42;
	Mon,  4 Aug 2025 03:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="R9x2YiMp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 127D583E83; Mon,  4 Aug 2025 03:26:14 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8A9983E8E
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3XbP8FiANooHg+iLNYxbrbuNQH2V9RyoT5KyNWCprOJh2MyJWqUX6ZSLXWTS+7tCTad9t+9sRKlgbmNu0cugNNKdPrkGUdseFSx/Ly3moWVQRPdog8B11cb+0xVaVkjaiaZAfeku+7TzCj46St+Mv0n6QJwC44QUDXQCYgMP04Sf7Ur2YrFIlmv3RJTMAC3idlVj8we04ITWLy1155Yt4eLsccxAgIaKeer7fLVOMzOUtSJ1Bhg6+2KYLz+If9guVhPIZGnDktUJ4EFhPH9zD5Ct/GPef5RsdMkgptKdpurtEermYfyOoZQ5S7TIJmb2/gF3OSwaowCyGeDyWgGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NrjMRabZ9tUDVK2N9o/4Oubr8Z+qUxhy6DgPT6Iphw=;
 b=L/fmp5TPTfWHbcUJir473gP6o5Gz70iYVgnJGsoIvKH7JIMX/LBkjaK4bVuKqeYHS+ZUY+MRmmWd4hHC1ZlJAtDDBSsKVLkmVLVXAGtPXgvk5qZdDk8hpKyRXzezIK0oLNE//FM+YmugYbTh1S2AG10gJMhdIC1JWNWVshpt657co1vY403iAom15+Rtzpx+w2OYXaLSHkBDnATU3wZCpsFWwLGZXcqIN5qK1BAn7OeiJquWe4NO2OsGVm57lFEahLvWFUlVgDROCGXgDPc57gdHbaTfJTyx9MJI2p8+i/p74eMoy75SSRKTjPAQgaBAkCMcTGsejHbEyXgldaw7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NrjMRabZ9tUDVK2N9o/4Oubr8Z+qUxhy6DgPT6Iphw=;
 b=R9x2YiMpu60BElmh2Y/G1KLRID3sIsApVlKhAXPwr2EPdxL1VFq3YwSXswI8RSM+nLrNN2QN8A4H923jZPwTZhnZZ5fJOtOStPGJQ863ewWfKfOvywx1AEWsvZfolByGJaTuosf6koesJU5gqxVPJR6p5sD+LTov5Q6o+OEv7SUO6oBbmRS5NkMWGSVXzvoq7RHY006GHSRVnUqrG8ZI8TWZCI5C9sUieSa5Foc53EgMoljjAym8kD6FMuunICuwUWuxRoS7+QBOUa5xMxdeWZHQBwl6QCQ5VM2FZu4OObDmBOGannk4R1Csq/DsB9hmzpB2Yg14MpsuTiTX9Gn4jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB5613.namprd03.prod.outlook.com (2603:10b6:a03:28b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 01:26:06 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:26:06 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 33/34] arch: arm: dts: Update Makefile for new platform
 Agilex7 M-series
Date: Sun,  3 Aug 2025 18:25:00 -0700
Message-Id: <20250804012501.21811-34-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ0PR03MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6be696-890a-412d-1550-08ddd2f5d127
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?192rq24jubx/3/8rDEx6Z77picL8HGI7kjjfT1D5nKbj/PqkcLJKwnFXkDJS?=
 =?us-ascii?Q?NVgPUWl5/dg4NpvdFHZ/+WPE07IxrBjEtJ/ALgQzXrC1DhK899O2jw8aIH4m?=
 =?us-ascii?Q?RsTSx/5Nfkp4yoJM8KPPnz0hawjHNiqosd95u54e+fFy+9AgTjUynHigCmo9?=
 =?us-ascii?Q?Bq7TwAPVJu6f6yf4qV+I6+W1Djen4Ac+biARvfCRPJD+3wVXTTfsh4s6Mghu?=
 =?us-ascii?Q?T1xpFI48x5JIrU/RoJ7NGENZO1tqu+AQUE+reNMC2lcUlCM1Im/E2inwWv/e?=
 =?us-ascii?Q?QV12sAR09BMPADMERdlsPJizrSLVsBrNNG9R8wG6WJ00NxYDh6OJnqVyn0uQ?=
 =?us-ascii?Q?7f17sKP7ztXumMefRR3A1BX+YzE9EyZIxBAT5tOPw2jjhPUe/9v9tqHTI5vE?=
 =?us-ascii?Q?oqYjsHtE1sGLXFGpJUluKMfsR7a3UxM7QS2WeNLiYWNqBu5UnXzdH2ZxnwFp?=
 =?us-ascii?Q?NcxdJsUIMvCwIivXUdufWCLJfokVBhAKTuw9qrgI7jo8zPC83h5s/buefmKW?=
 =?us-ascii?Q?JbfYnRs5+mUCMYtkP7SFWBa/JEC0mQtWxokzBO7k0GhApat8j+X/2Qw5Kakb?=
 =?us-ascii?Q?61Q89cjZBNsJzEygSCIAMkezmWY94QlwGUeqEAtKLBP1eyuU4A7TnZVIlL66?=
 =?us-ascii?Q?uhX+W0olmixaDNytGxZxAUG0K+AH7H36F5JeVqNcagwg4vzuEGZ0YZEVJjRk?=
 =?us-ascii?Q?9pzA7d+zf9QqGZ3RYkYBa5CswCfnwmjP0vRjuVkOwEXwZg+CSuKIwReS7RTZ?=
 =?us-ascii?Q?TIcSuEit7mz3qXRCsuoEPHT80PxqURGTPbPd4sYtmV5azweLBquhNqOcpjK6?=
 =?us-ascii?Q?6ywvC3Ps/xcbCMyTTU3NERn3+QfrELn+JWXdh7In8/0C2NJH73A7c7SGFTas?=
 =?us-ascii?Q?cpIM4I4khPn92CvopLibXwZDXCKD2egXp9XblJm8kv/D0TbEdrvugbE1Eyjl?=
 =?us-ascii?Q?U5RSIFZ4tNpCHXgfcLZTBX/Swv68fFI5fo4OR/rp1TacDngp23POVpX6ye4H?=
 =?us-ascii?Q?fsKzqrb67gMJw0rfKtW7OxE/dBX7FxhouBHX0K90+l6OwWyFcf79Btuv7SKJ?=
 =?us-ascii?Q?xuJ3nTwIlPFXoWbxv5QrDwFPo9KAzT0xrF+xntHp7mnFX9ONFgkXJ3zMLhJC?=
 =?us-ascii?Q?p83QZsJDZn4/rtdLi8k/AvOx3HPkEO8FMe7WJKvg6pfq33dhs6lOvw55iLpI?=
 =?us-ascii?Q?2Xdt7qUjX/ow5TUhHYVaVFXSbZWBGGwwrZ1NTc/3ssOrDwwwYg8JcJSBp8/f?=
 =?us-ascii?Q?pdOU8zDj+9s5lk5fSBW4SjRczsk05ITfP039iVOaM34TVbsROot2TpjN5j/4?=
 =?us-ascii?Q?t8Gr1aLW5KHHR/z9qiUZk2BNgMKuNl+iC4q6z183OLYl7P27xHs/ldnBTnlX?=
 =?us-ascii?Q?/zN1e9YKe5Yj7Su0/+RMkQK6ybHRqh1JtSdJLU729uLgVtcXGPcFapV/7Nx1?=
 =?us-ascii?Q?CwuhTfHXnfw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ssucmRoOvYMRWO4DMR+jgkOSjhs1U7k5bfxWSYvgKb79QY7DFv6zZXl0YAkR?=
 =?us-ascii?Q?MzBQqT/0nedo6qbZgojNcFgsREtO2pQBuaR4dQDRXW2sXlP09vyPeMDdmrZ1?=
 =?us-ascii?Q?w3UTEBk60BHNVE9hiVbjP271LCxHGRL3XpBcUAz0AF6J3ZZfjxqGuKzJs4zR?=
 =?us-ascii?Q?7qkVkPflZEqUfGkqZxZNhV0PXWSWf0pl89N8Mg59Io8PTs5sFSilutdSA7XA?=
 =?us-ascii?Q?mMFGbdcPuCtiF5Zam/8nRgROMws8TzxmpVAx83+Y0yesEYyTdIFEq7JSt2+L?=
 =?us-ascii?Q?y0kX7Jv5M1hY1mFGfCQh5ENX3qQ1arb3k6yCSfucKQ3HFzU9Bqt7nUIylcsb?=
 =?us-ascii?Q?xAxk+v8v4hllZTYTnIUFifEsCYGJXcUOKNHB7tsL6c1GTex5/cOoBxHKLzkB?=
 =?us-ascii?Q?TssBQ5On1QeTJkfI1c0Mq9Rw67CycSv+hHoQe+w38Miu4VCGFIYUPkTIsdfU?=
 =?us-ascii?Q?xok4ioH30bdM5eIuxynLRE8O/tc7jJcMTfAhfNQ1cavkrRhHe7GEQ/+Pq/c8?=
 =?us-ascii?Q?GtO3Fk0uYZpFLwdl/ZT7YvYKhBo0tocfLpUiRinUgIZs7h5X3T+TSuKkV0jO?=
 =?us-ascii?Q?Dkolb5M2/qIfwX4JvlDrSHffcnmVl0syczeapCFYKrouTFmiYKf+Z4v8wqM7?=
 =?us-ascii?Q?76S03zMlfH2/oCflPaxGZ4ZBR/qhKnwVOva10ZPUoiCdDmTrauF2b22hc9le?=
 =?us-ascii?Q?K6q8FDi8A3ONoHCk/Lu7hb12oRHoxFKUH8FLwEDwBzSyJem55IFgjDc0B563?=
 =?us-ascii?Q?LeTtjcytB4OY49j1ioqEizUzFguzQRiICvxOyFdlv8PW/Ict+VfevTnWlUAX?=
 =?us-ascii?Q?StKrJDfhUCmxjh0yPB/lRRMUnAVGJWT8VxzbPNz8Ej80W+EnCKTKqoxFtwSu?=
 =?us-ascii?Q?J+DOMCqtCqU8KULV8w7Tmcw3oeL+MGS7D8jnu+RO8+dyBNXHxTgssyNyexig?=
 =?us-ascii?Q?PLD5NzWxwt/+BoVb+eSakLu7nvG81ckG9JlYkweY7PwzmvoDM689K7KMyqJK?=
 =?us-ascii?Q?QM3ugCYw8nt50SWrwpgTVRvwDM6z1T1Xu8EUcJgLcoIllqHTALPlqipGsyzD?=
 =?us-ascii?Q?1+XyN8fmkvvFi5iunQbRCguJ7ZHDzCqX66dPdYUfH9WW1qwju3l/+5uygTkr?=
 =?us-ascii?Q?tE6qrhVUxJAK+EyuT3H48B70VuZeUOUHlqgX9Duqky69Oz/ePWkFQlbCz+kr?=
 =?us-ascii?Q?dqCiynvP30Skcz6z2fiiEzfCwILO+lvAyQqYOFbj309Ba2bapr5XMd/x0VBk?=
 =?us-ascii?Q?OpjsGRhq+gx7JvXFgy3NG2G2ptoub2NSIh7dPn+gsPR/5dXce/JM19TRxZfd?=
 =?us-ascii?Q?RLt95ewOTGPHj9XXEdL9BNaGC7Kfe4htkJUE6rpm8a/48UrqkQ//ICI8ieHB?=
 =?us-ascii?Q?bhdeNSSSAh73LbyhalWBO4iHw5hyABmvtKH3eJGeqJBf2VifxvLEltcPGwyR?=
 =?us-ascii?Q?Ay2hSNRzThFZQcptfvhhd7M4UbpQnX8Uoucs3T09WzHp5VpOadSa7mFeSgbB?=
 =?us-ascii?Q?+b9P9z91Jf0jCS+famELBhFIYksuK7nsaHm8goS7h4IWATBDvwU2VG/8zm6+?=
 =?us-ascii?Q?Y2NHg6F5/x6rhLz0fH/RCU1H1nx06OsEcyGEa2HVVjyBS40jyMTWMF2yE8Cs?=
 =?us-ascii?Q?adNZoriNqJbD6dkKm5CiOJ8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6be696-890a-412d-1550-08ddd2f5d127
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:37.5706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3/8jZ/SwbGhAjYbRceKiDzSiHsx6b+QiB0qPg4jFUmfDzpH9P3/9gIOdCdKc3XdVSEnQZdqeUuRF9Kaiz3JrJqbJyJgU/uKGJaJ78NC2+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5613
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

From: Tingting Meng <tingting.meng@altera.com>

Update Makefile to support Agilex7 M-series platform enablement.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/Makefile      | 19 +++++++++++++++++++
 board/intel/agilex7m-socdk/Makefile |  7 +++++++
 2 files changed, 26 insertions(+)
 create mode 100644 board/intel/agilex7m-socdk/Makefile

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 7f53c249805..4e85bfb00d4 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -73,6 +73,22 @@ obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= vab.o
 endif
 
+ifdef CONFIG_TARGET_SOCFPGA_AGILEX7M
+obj-y	+= clock_manager_agilex.o
+obj-y	+= lowlevel_init_soc64.o
+obj-y	+= mailbox_s10.o
+obj-y	+= misc_soc64.o
+obj-y	+= mmu-arm64_s10.o
+obj-y	+= reset_manager_s10.o
+obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
+obj-y	+= system_manager_soc64.o
+obj-y	+= timer_s10.o
+obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= vab.o
+obj-y	+= wrap_handoff_soc64.o
+obj-y	+= wrap_pll_config_soc64.o
+obj-y	+= altera-sysmgr.o
+endif
+
 ifdef CONFIG_TARGET_SOCFPGA_N5X
 obj-y	+= clock_manager_n5x.o
 obj-y	+= lowlevel_init_soc64.o
@@ -116,6 +132,9 @@ ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
 obj-y	+= spl_soc64.o
 obj-y	+= spl_agilex5.o
 endif
+ifdef CONFIG_TARGET_SOCFPGA_AGILEX7M
+obj-y	+= spl_agilex7m.o
+endif
 else
 obj-$(CONFIG_SPL_ATF) += secure_reg_helper.o
 obj-$(CONFIG_SPL_ATF) += smc_api.o
diff --git a/board/intel/agilex7m-socdk/Makefile b/board/intel/agilex7m-socdk/Makefile
new file mode 100644
index 00000000000..306a8cf5f0b
--- /dev/null
+++ b/board/intel/agilex7m-socdk/Makefile
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2025 Altera Corporation <www.altera.com>
+#
+# SPDX-License-Identifier:	GPL-2.0
+#
+
+obj-y	:= socfpga.o
-- 
2.35.3

