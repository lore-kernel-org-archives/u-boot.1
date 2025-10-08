Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5FACAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 07:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA2083C70;
	Wed,  8 Oct 2025 09:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jy7Ud3+O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F1CD83A5D; Wed,  8 Oct 2025 09:32:05 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE8AE839E8
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 09:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXL/LtLzfuFaUKOQJ2VJkmdkxkj2rVBjHyWLb+mYDkeKQVW2iwT1127Qz6zhYc2EqZpOlgFFeZ9tPeaQUGXZ7XXagAah45U7sIC2Ge/rOAUg0T8pSlRMT5KADjqn40Y7Vd8qR0sqPdPDqzxjeyt7Lp5LvRlLel4bWUPIX2KIkRQjWEM2G6+2DerZjYabb49AVbPezi5k3lwHPswZapI1uHfV7axkdBk9NqftDXQsJuCKxJg9C8ps3hQbpuvH+JpCqnYedPjBcN3KBUL6/9BHZ4IIZGCHVSiu5fAMPinjK14dR8c40KWvd/rh/pe880bpauvK/IRLYAV0LIs4a/Pn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wo4C+wF+Ir1xLB/RrxNANtU3x45+8DpeVbRFdMeqVM=;
 b=uR1ygN1MMGqkdAXrMvln5CFuBC0979NjNULiAe4mQ6W0v/qus248RjHBnFeHJVR23Dr7JwbscI9cKta2iN6pLjIOf5xJyMFQ73dk9wun0CAzWBVMQ8gnsafpjFUIy/VAnrA7Ct3sfCXpRpx1Wi+E0oN5OadH/rKCSVaSDHTSRKHdzXYLxZFwm2jAwzBZVDgsA58NtqCLl2V0J6/O6fX9LEYRIDK7kCDrDp2TPiXd2LU7PUvubcxcg0at+j/1Mo6lPr2ATzFu0jne9v3oY0YncsoJt5NGTSBQnlES7MG0tu/z7dDZQ/h1UZ4huZjInxbvbpYB9LJlmrOSeqCuE976sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wo4C+wF+Ir1xLB/RrxNANtU3x45+8DpeVbRFdMeqVM=;
 b=jy7Ud3+OGINU9OoOYU1S0thCle9wlgAoTQ/JwVBXtpm0VfOOqGidlWZGiff4ds05RT7Zhetpe6v3P8bgOduGGQRtX1XeS9vY4BjqBn8zpMRgWdZnRXh059fHQ4S3qlXxiY7hPD/jT/vQJ2eLosCanmKWv7l8EGMPnnw+HeJeaxEiRr7EIBgjqWbYRwQnFMj9SfHuR0oX2rGY/4ek6urkbbJB2xUtIe15//V9J7YHEWx+AeXFqrrLYF/Tf8jtAWM96gfIuZ4cJzXYoGM8jjBxciSHk6tsknPfLea4bsz996VB8rt50t6zkWjf4fPWShJD39c00pFK6m+v+C8vfgZmkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6579.eurprd08.prod.outlook.com (2603:10a6:20b:356::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 07:31:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 07:31:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v2 2/2] net: airoha: increase the number of rx network buffers
Date: Wed,  8 Oct 2025 10:31:39 +0300
Message-ID: <20251008073139.373796-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008073139.373796-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251008073139.373796-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: e34d18d3-7055-4a63-e219-08de063cc23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vI3BNsuzuIt+3pc8HlT/CiL1xpFtVW+AH2jQ+vnbaChiSlwTFQFtdsigaEPE?=
 =?us-ascii?Q?xwaMZN1IpVVL0+iKDEDcFvrUhmPvNm3VBdxsY2NiCdfJKGhN3baNq+Q1LgBG?=
 =?us-ascii?Q?3QUQ+WRQmWUttLL+CxjzUJnmTimyuonAKkT+hNI9Nnw/85MBkXzJdOvS9to3?=
 =?us-ascii?Q?5OcLfqS67l2tHjgP4ypWX/3wuUGDVm5dcGaManlbw5Z+xkYvksBi1PRFcN8p?=
 =?us-ascii?Q?1lrVyGNRc00XwrBaMWvEfv4a7EougzydlhGjqsxNWSwxXigN3hK8q+gJ6/k/?=
 =?us-ascii?Q?aKkyai9O9dxPbFouvTH1k9eyAEW+ckPm5nHaGPD3Lh+QW9F5slBI1qz/iHJk?=
 =?us-ascii?Q?EaZXDwhlPkaC0fGdVev6sPbD2JdOlXrdBcXCdh8nBGVRgP4eyJJXP+lBNLUD?=
 =?us-ascii?Q?MEWtEfuCR2lmz2vECynKllsstEiE8HAIjuGwKNubb0oKkmFCMsFMB27yeqXr?=
 =?us-ascii?Q?/BPBpmyR/fzr2gFfthfVVQ0jfFVeHeLO0YIbIdYLgjWH4XO+952LGpxDHUOF?=
 =?us-ascii?Q?DYMe3hUD8/ot6S4fBgoY0JyQbyv/BW+Kp2vCPXkLKSCQ4OpnnUfHMZsTkAiO?=
 =?us-ascii?Q?IejGO+tHyWopNxj28dnvVuCH4nWeEHU94I/AMGIRoQiiGTkjZ5evI5M0o4+3?=
 =?us-ascii?Q?3n16SOs8yb91SGPE6ZQVDG3vNP1fFQ+0MGxLyGBqPpl/A5CMnuwu6SHFUN6s?=
 =?us-ascii?Q?qKPpwZJqaBaOiNXq0TUjQpAjbB46Jj0+bqesZjXSYEXaG5Xwxzha78AAH0Fc?=
 =?us-ascii?Q?k3O6m34FgvnfGN+jusc+HKB1vIqzSDvFNxgSnc5Wk0HdM2KYvauTNya9Zd61?=
 =?us-ascii?Q?ovBVMV30KJeoaervHbYhuYiOiTljc/EFTVEteOTSZlTsNe0/c9cOBU6s/Ped?=
 =?us-ascii?Q?xPWfwWitub4ToTODAVjl2vSZAux4MFTP4o0TXQ9C8Zj0w4JrqRMIKVPiKSox?=
 =?us-ascii?Q?Zq6f5RHsGGahtSDLJOCWPBVv07C/2DFefxMmhQ2DZXMHfEh0+vQdMg2mWRRP?=
 =?us-ascii?Q?g6dc1n9aFXY5kOJNdPZGSF7SGIV3Rl0C6FzfzTYVrVv6Nkqc3uP0AX1wMIQC?=
 =?us-ascii?Q?SGZy7SKbOpkhyqH61ZWoKyau0MSG/cOX/ygyROMk/53S5sFdW7DRB6dHwlwV?=
 =?us-ascii?Q?swpGN4T94xyKjznfq/u7SsYtwDyjug+rMh1gxrVQkd5NSuRR4CyoBrh8VonC?=
 =?us-ascii?Q?ZaHjej9Vq1ltP7MO9e4rMMuK9X3YqhTIPKsVaN64AdI38Fmu1+JcQD5lDFkk?=
 =?us-ascii?Q?5VaGSo+MnnrmjE9/hNF9vtp91AIoFUyonlC7IsUk/acWaLE2+61j3qwq7xNN?=
 =?us-ascii?Q?/m0yaWQyZ9kl0JhAYP18sTA+gqUvxJMD2UMTqES9Q5bFnjc5+LGfazbyNEaz?=
 =?us-ascii?Q?pcobVVpl/GDTY8zIKluF4XgnPTK1GOZv/Gsab2KokEvVtHoAYoIsQxvdwr4/?=
 =?us-ascii?Q?aKHuotcziaPu1XnTiiBYKEJT0wCP8i0nk43B+k4k17txEiKoq2swno/ZcIJh?=
 =?us-ascii?Q?yfD9FDwfBl8E/vam/R3MP5mGULClXVo2/W5W?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1/FRa/VQpGqzG/WXXzvjaZ8uSVLXFua7J1CP1RF4wHvnAoGcjUI+2eMH4nF5?=
 =?us-ascii?Q?9zyE+yyMqATSnpgT24AmXPGOfEDYa5ACTUBiRnmUC3aFN4LAggMq60lFSYno?=
 =?us-ascii?Q?0jZmYfxuL4dXqoYew1V6E6v4/5P4IbAH3IpF2gGsVEnk7VDW/Gjz64zn+w0L?=
 =?us-ascii?Q?+Tb4dA3SeL/Jeil89E2MsHSyCjdSS8nr6zg6RljGnAijYkMQHhpEZyDhOaUk?=
 =?us-ascii?Q?y1ysv2wHlonLKJ7z6uGdOs5PWbm1YVoZ8OX8d+KvYLG3tq6M/3Tug5B+LX6P?=
 =?us-ascii?Q?sE7qe9e03wYZsOJzj8q0S4VE0djbbHpuEnIc1iG/K7FN3OO3hDmD+1idB82a?=
 =?us-ascii?Q?dOy16PwPbVBxWAgz6VJf526fgZCcDB4GsJGlmeHPuNwgQ6zhfWX4deh/sf/J?=
 =?us-ascii?Q?Rlxe3uwtdATswR9PQ+hRyCQnK89zL9M1F8vylv0vW+zJ87tx4KNow7t06i+p?=
 =?us-ascii?Q?EphXAgMz2r4ndpoh/6BLqN4ijnk0KjyzqodNPltTeHKkxqeScEI44P+51O7h?=
 =?us-ascii?Q?URvs3XsELo17SiqiUnsSb3AW7015FxqK5QG9EdFjAh52U0+GtQ8Z+5xSfG1S?=
 =?us-ascii?Q?5rKHuNtM6hDXCGei2Mots5tMM4p+v5m4HY5nXS+/0keYKw+5DXFw+j7NX7GF?=
 =?us-ascii?Q?vbrxBgHvpV9cV+fkagAdqm7lRLu+UNfUe38zass+xLjuUu+ZVNfJPee0tJLp?=
 =?us-ascii?Q?8+ZVLmFYqXmspDajH+ivURPL6DlpRkKM0aU5lpFOll+SqewpPvm8dRPVkXaE?=
 =?us-ascii?Q?VDY+SY8si5T57FQ0K0KHqdN0MnhnpuE8ZaI/4VrAo0TfVeP1JyJhirIqBvWM?=
 =?us-ascii?Q?IlmOCLfgOFM54K1HdDjwaXxJ+snj9WoRf+1bvLRBhGjsVqGbPdn5h4EyRcma?=
 =?us-ascii?Q?IT+76fZJ4tkdPH2jRacvtVvZuoNVj8wFUAsQDfeCT7eTfR/Zu2H+PvML3FTK?=
 =?us-ascii?Q?ahche3iswuWlrrOu0XwTP9nVjChVuOg8/xaN9Ye1uvyy4i9jnBYp+n1+oX34?=
 =?us-ascii?Q?5uC6ai9/9L5B1gJcoYZx3xhGikTjfRxvMks0pyMQG96vkTuhw5IGMc5dwp3A?=
 =?us-ascii?Q?1ZMIL639diwYdpBsi4cknxKKT+F37bPOhDZpkk+o2/Pi+WK4oWVEmOqM/NtF?=
 =?us-ascii?Q?rnG/6HLz8QIBXdbeF7Yahdc5p5GrxV7fXb1pATiUjiEIZ9LZhAJKw75/SiIW?=
 =?us-ascii?Q?VRTON2pd2mazQ2yhDruMb4Typ9Y1tim5x1H6C3wR3EBLjCCocmUS6Wg5tKMN?=
 =?us-ascii?Q?Atn8vEUmYpGFGrPl/b65WZnHGHfPqXK4RGdrmStzbAbxrA9wd+2LYa0hYhqu?=
 =?us-ascii?Q?4uZrf52Ggo136OeDGTPjIag+aPgOKDiE/Y4BU7Qr/o1Jy2ynODMAmm2uU/Ox?=
 =?us-ascii?Q?Y93aieqj+hzoKEBmsZfiDh2OVXY4ylCGQ5MWJ380p41IJV5Yf6evNQbPH3BT?=
 =?us-ascii?Q?6L1hD5eAppac+GcNqZnCfwm4tiIg+QY8cClzMik3i5+fVjXcGGOoCpr1asKf?=
 =?us-ascii?Q?UskKt6PohQJIq5DOLVhgNYTBI3MnqBkb4qvUIE3d/aQ5Yq1WhIfj3jGBdM0J?=
 =?us-ascii?Q?2HqlgwYscncdl8KFi+nGeHOU81dSNU2/15UEw3gEymBLwqrtkQKelag+FMrg?=
 =?us-ascii?Q?q2X9xVDe0zb/bNW64RQxeEs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e34d18d3-7055-4a63-e219-08de063cc23e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 07:31:56.2622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: koIEGl+1sQjbLNPWsc8mRUlsCb9JrpZN1CuU/VcrVKIxk9DXvCPnV78Lt5oS1KHlTS+Y3rIEQYYbIndtRnbNPDc+GCUj3Bj3x/KKA851yuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6579
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

According to commit 997786bbf473 ("drivers/net/airoha_eth: fix stalling
in package receiving") the minimal possible value of SYS_RX_ETH_BUFFER
is 4. Unfortunately it's too small for reliable ping.

Observations shows that SYS_RX_ETH_BUFFER must be at least 8.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/an7581_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index 0ccab4f066f..baa3fc3f5de 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -43,6 +43,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
-- 
2.51.0

