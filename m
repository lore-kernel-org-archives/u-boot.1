Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B8ED3566B
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 05:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0AC883B64;
	Thu, 29 Jan 2026 06:31:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="FJ3cALgf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 964F783C51; Thu, 29 Jan 2026 06:06:10 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D89E683BB1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 06:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANKFm/vtBOe5ScEWoAR/wICm4aZOlFmS/+sgy+gpXs9EcdLO89clM729IM5dA3/5ns35IVvmlc6Vd3elFdhthNphRT5w2xiCJ3zRsGPU/1LgMzarneDBdd/u70eyxMjZMGIJJMarXhvaIFCXRTpFkwOOXR1+2EO1bpLzzD9GW2ov2/fQhAYrJaHwqW46chS+G7CKVFPE9URF2AmYWGi65pzlrQeF+tk6P1HYVKCeKZva+H/27lclppYLFJO6yUUrxw2BBvMErmvLaR0baFyCAt+qJK5wmDoIKQP0VYu7qf9uGoSTr8OVwTfMRalTcVZCd4NVArJmPy8PYSpNNDLq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKlrQzFmXxeYE2kiCDoA1l09qGjAHJAb8YYZJ1E3C4o=;
 b=WBVrwSo14+ebEpBOAh5y/3sGFIyRi7792rx6K0UZFRgfEqoptTfF1sSp0B1PVzT/fxwkNJgpDSRRbUoFODFUbjeHQIMOMkOsKIMf7t5UBqmALH/P2INcIJAcTjLq0cNjhSSohoLaFUjsHpdkcccJfx4X9c1y/a6UK+gXTJ02F0H9lMnvYGcwMqk+spguqHwwKclquWZU4EccrhpGNXTRKE2HajTEYGa845prUn0Dc1AgDYd36jz8eWV3ZnCVmIft3eSGZwVfz2+G2M5gC8vVed4pzl1eUyz8yjMp2+0YGCJuTY714MIKEKgm1NUe5b80Vz5YofXfeWU10/LxQNbzvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKlrQzFmXxeYE2kiCDoA1l09qGjAHJAb8YYZJ1E3C4o=;
 b=FJ3cALgfSipPQhpvtGG/okQtzSDBFdr5bwGCHyjP8AnfVF8Y+uGpV83+84V8QfNCvK3eShLTA6GhHifP9orbJKD/bMRqHFJhwA/a5gt3CdfJalnVKQI7XBf+j9EVl4lHFLUdTN0W9CqJ2J3sAIVLnF1AvXreBDNPAySDisvvRa5s8P6/xzbuXIxztZfIdFIUXw57l7qcxhxXqcLhgxbYGdw4jpa7ta6W8zS6dV3E8Suk1q3B0Zbmu14XF99NbGw8swoxCUabl7OLrCbHz68Zy/P/Q02SxeeKU67woOGD7t6LmRhPi9ybytaItoT4pdcbng4Z8X2ZIlr6fO43LHcrmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DS4PR03MB8422.namprd03.prod.outlook.com (2603:10b6:8:325::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Thu, 29 Jan
 2026 05:06:00 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%7]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 05:06:00 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH 4/5] arm: socfpga: imply SPL_NAND_FRAMEWORK_CAPABLE for Agilex
 platforms
Date: Thu, 29 Jan 2026 13:04:45 +0800
Message-ID: <20260129050446.8858-5-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260129050446.8858-1-dinesh.maniyam@altera.com>
References: <20260129050446.8858-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::13) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DS4PR03MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 11eee8ed-d017-4e3d-80b2-08de5ef417e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oF461vjBUbx2YRh7a2xTnHgV99hXt1xUPdaMjP77BUiryGHbwOVj9pqoBpA/?=
 =?us-ascii?Q?AqAk4/Apr8dBp1qLrN/KraQylQZYG2avUvCasS5Uk4ApeygK2uviH6x/C4Wo?=
 =?us-ascii?Q?Vck8lPqoQHV8l6Jf/PAOl/b+o4dNStB+TK/kULrSnWKns03h4N6xKOND1NJT?=
 =?us-ascii?Q?Z+VR9JiVk6/NijOupp0N0FKNy+vx6dFpjP+J7B6PFD39GoFFSHjIhow1MaNC?=
 =?us-ascii?Q?I3y7+CUzYpoj03bYR2QZ4s+m6VL89IUwlbEu4E3hK5gItDEytFSLVizx6Rs8?=
 =?us-ascii?Q?pP12ic3+orLpEeBF7Zh1ml15w5r/7sEATRllj4/FJQCJLZ9QIkhD+CMFuigE?=
 =?us-ascii?Q?aQVRS3URT4TlH5uUf7Tcotqi+7y/1s1qH2nwQlo/3jOEt8A4p1IW1cEgAakP?=
 =?us-ascii?Q?QFNF/kAlY286JGv6Xo9oxiHU49T3qAvjVkgcY8LS72LkcRNclVY/PluUPK+h?=
 =?us-ascii?Q?flayTGVQFGpGCS5dcbUuwo4ZQc7Kw+TNrKeQbkU+EjUQmcch1FvAcp/IggnT?=
 =?us-ascii?Q?qbu6XrRkLwq90ORKwNT2iiLxu5clipfseK97xGZxZYmgHgrnp4i9KEY6kANb?=
 =?us-ascii?Q?YahRG/0Bp1605zRr6rd8Mdia/xxtGjzEbb0DLCDKgHgpnwvlfLw4rDVLMpIm?=
 =?us-ascii?Q?rA8g5D/unWr0cJs3FCvGiorsugU1X24LEYMICppcqpRF6H3uFAwUEdYZue4I?=
 =?us-ascii?Q?1T1+63FWa+IJe5q2YEk2I9RNV3MF1qgTivmYKsWvJuCVY2n32aaPm67PJMym?=
 =?us-ascii?Q?S4x8R7bdxurNbW6SyXCJ6ENY7KKagBVn3EitbD+6h8k0dq+Pi09N/tnQVGpn?=
 =?us-ascii?Q?/CJyJ2ZCDVQ9sFrO2eTaC2Kkio9vCZtFuEhvPAFTrIcE2xniynOE4U63c52V?=
 =?us-ascii?Q?c5kX3uP6G2gdrelYvQCdBHMVbO38rnEHuj9rxMRhccyAbAGCQVTv3kmBjP31?=
 =?us-ascii?Q?OKsxCN/7xNvdPu3BR8+bFTV5bm6Li37qUNATiWdyv3pjGlpMXo/bWv/+e8+g?=
 =?us-ascii?Q?Vvcy//f9yA2hEHdYsVwKssshOxhClu9NLfOe0C0cehhebc/wZmBygRvFVI4x?=
 =?us-ascii?Q?2XPb+2xV0S5eM4dZjv+OunzXFeRQ088eqxp+u2HK0V3zQzGE6rsGBfOmGZfK?=
 =?us-ascii?Q?q1oO1zNDMuBtCLQxei86WJCggRsje0HbxxUR3KTEAG7mNF0Gu6568yhIiZbV?=
 =?us-ascii?Q?QDpGU9vnHGAnoo1wxM4yHLQ+5q/PkXVH6PIKrfFgM5+juo2ydYSyTw4gz9lx?=
 =?us-ascii?Q?fkzXswTyKDIgCHLj7IR4Hiv8nGq57z2zNl3e8AV+8WZpvcnH/4UbwagCi/54?=
 =?us-ascii?Q?OqjAGfDHyM/2BZFsBOZlsavbI+CqNVtr9r6jqice/sKnHuZUMC81BpVKuzkB?=
 =?us-ascii?Q?ZCVOS1W5rL9UegQ0iIEC5ZW5ACsMN6zK9A0/DRnXPsUw9d41N/3rtQL3uEhb?=
 =?us-ascii?Q?LELZwmqs2MVL/1fHEcHwISv11wYNVTmnY4XXDbmeNQus0zcoweNVxRzdvwL/?=
 =?us-ascii?Q?BMXjEMz0QqrpETMg1w+jr2YVThGS7nw1lBy8Uf3o2RSItsGM+x+DkMFfKM6q?=
 =?us-ascii?Q?hVSF/8lrRD5gRM/Z9mg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ijNaxSKmWj544Z4PkhEhEMJvUaHfgqWmWaRxuhHN1X5tRDWWB2ybb5Y0QZp?=
 =?us-ascii?Q?cc0FMdgsRIyea1QBglCJBJk4z4JHpV6YmH1PqiDoab9k0urSjtubKtNtpj0p?=
 =?us-ascii?Q?7ouW71I0c2rjn3rrz4yjgZOWbcbD6f2Ew/uapHbpfmhFtFyH1LVbm3jU9xzi?=
 =?us-ascii?Q?qykLh764zEnH0Mry3PRBzZSw5lz/wk3hy5FLlz2iMZlbcIKQGSaTtCV9OoUI?=
 =?us-ascii?Q?CA12BuATs2aBiI7Jz5WRoFZjxD5brNHBbkRa8slEy7P5ZwqNmxquzSrEi4rk?=
 =?us-ascii?Q?dHxPxi+pHkqFhOajm6zT8qPViN05w8kQWulK2luFRDfLP32K7wyN8wudhD9x?=
 =?us-ascii?Q?tdJpDviX0PTOTAJGy7qKvPT7yAievgvWJZQETV8YeSvnoIUzhCU8iJBU4k2Y?=
 =?us-ascii?Q?bpNbSiihJcSiREvqADW60KdZd8cX3LGi6JCYArPCu4aI22H4N7R8vngnc6SX?=
 =?us-ascii?Q?W/lbzWXlueyBhGoshV/7r1mTM6EudbM9mLXHPbrLLRJtEV81W/XtCliJgeAR?=
 =?us-ascii?Q?963Y0jNDS5h65lunc7Yig0NtW1WUdrSOspqlFJAi4yVehVcs9nP26uF7sITP?=
 =?us-ascii?Q?OWxofacjHXRAfTG/atqV/WFbjtq3Vp/D85FACcPhyny+W7Kc+HutJCD1dyZh?=
 =?us-ascii?Q?LMs4A21YYKnJnh/B4Z9bo4dioZIbf3F9Bb6b1lBT/Fj5B9ykvgddubETCDvT?=
 =?us-ascii?Q?+e+UGHdBwOBW+YJmQ9EAynPEZqWxjou9icDAOyE6OfUjR3VXx1C2/CtVkMRw?=
 =?us-ascii?Q?nHgd+4v5xCLbYlp4HHbUD7ao2AjNlxo94mkgZ9yzPT/7a43UeXdCH+b18Io2?=
 =?us-ascii?Q?NhKYCq+p1nBkTmnUNJcBohOecqogM3fsiJDu4kpgIa1vhkcHCCvPMlGQ6UOc?=
 =?us-ascii?Q?Ysgo2/efEwcqe0aIKBDJte7XnA4ZZl4k9A8+pnxkGDI2cYhOkWNeCdok2yV4?=
 =?us-ascii?Q?60KfEpP2pF/MGYcX7eL1osXBAWBoepwIE82ICB/U5SFGlIHqaUXzVXru242X?=
 =?us-ascii?Q?k6SXlSkHM5jKvcYoGTKH9rgwgg+XnrAeR3dw/eq481vFPknsUJLIj2T0daGY?=
 =?us-ascii?Q?mtpO8sUcP5JX9AYB6Gt3IcnbSBPJggIu5uPJ3wxRU1KGU34Pbds/fJ77GO8r?=
 =?us-ascii?Q?yfL2rLAa8b2RqpefUtOj4PzT3cfosr5h1RuTxVilgh6BCr7ZSdho4pfZ2+dC?=
 =?us-ascii?Q?jGE0ZMumP9kA/ysK8MPzV/SAbALcg87DsRyqTZjr/+wyUKDW0k6OGz7VyKoy?=
 =?us-ascii?Q?e0kbEIyWUAsE/ezb0OjshCXhn51lODlNlSYsqBnMTCidh3CdakGyfgna7+jq?=
 =?us-ascii?Q?X/zxdBFQOLXyjll2qUX1anA6K82k8hbir8bVU7155Pl4uGpUR9RZc0Pn12Pk?=
 =?us-ascii?Q?FUks4GOWfTCYdTIie3vWc6bsdjunhntt3s06tPzZH59P6hXjKamCYvOc9Ymp?=
 =?us-ascii?Q?QANG17M8+xSyjimlB+ibzybo78UIJa0Y/Zcz2M2BZYch1PaYtfcCa55JWqqx?=
 =?us-ascii?Q?oMI6HQdpOnaGL/wCX2PC9lvURZtNbCpXYJJ/qm9wal/dU930nXo12i6CPzgM?=
 =?us-ascii?Q?sFj+x4XDv7zS8xrM/kAhltVMxy2fo96nACezkU+nUrToRyDFEvZMiqF2OKv7?=
 =?us-ascii?Q?TBE9k9crcuVD2CHYrpdPHJ1T2B/eSmielA7WciZW8X+DWrWCc+xhtmC8hTV8?=
 =?us-ascii?Q?q3kgSdUaBzXsivsymcAEBsYer3T7rYJ+RwrUp23vm/XSFgqp+AQC2Xig3SOc?=
 =?us-ascii?Q?/BxaND1hShSA5LZODCn7g5Z2ANEyuXc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11eee8ed-d017-4e3d-80b2-08de5ef417e3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 05:06:00.2906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tqnba2TK4ViDhBjrz49ui8PjBvAuh4pQQ93v8FUOQxOqeAdd078pB6+JtpmYCRNLii9Yek+fLCo+fb0zzCq99uEl2yQkCIY2RpLfdyUu3iQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR03MB8422
X-Mailman-Approved-At: Thu, 29 Jan 2026 06:31:37 +0100
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

Use imply instead of select for SPL_NAND_FRAMEWORK_CAPABLE on
SoCFPGA Agilex and Agilex7M platforms.

SPL_NAND_FRAMEWORK_CAPABLE is a platform capability hint and should
not be forced when its functional dependencies are not enabled.
Using imply avoids Kconfig dependency warnings while allowing the
feature to be enabled when appropriate.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index f2e959b5662..3b56209c3f8 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -59,6 +59,7 @@ config TARGET_SOCFPGA_AGILEX
 	select NCORE_CACHE
 	select SPL_CLK if SPL
 	select TARGET_SOCFPGA_SOC64
+	imply SPL_NAND_FRAMEWORK_CAPABLE
 
 config TARGET_SOCFPGA_AGILEX7M
 	bool
@@ -71,6 +72,7 @@ config TARGET_SOCFPGA_AGILEX7M
 	select NCORE_CACHE
 	select SPL_CLK if SPL
 	select TARGET_SOCFPGA_SOC64
+	imply SPL_NAND_FRAMEWORK_CAPABLE
 
 config TARGET_SOCFPGA_AGILEX5
 	bool
-- 
2.43.7

