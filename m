Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4247DC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 10:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FC3081F44;
	Thu,  3 Apr 2025 12:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29B5E81FC6; Thu,  3 Apr 2025 12:28:54 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070d.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 501A381CF0
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 12:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwVrfDEEn9kAFzun+YPF5q0Ag4leu5uUJ1WMZKVp7n9vQ7KsxSWQOdsXkt2Rf5iy4TV3HhDYCD8Kcprst7vWLUC87KqxDs0e6NaWXdJ4imvaq3lnCHRx6oWDIo0BG8gN67cUmdIDzr+fZN4+SfBfhK4wvpvor2qOX6SeOKf0mjGIj01PVcYXHRnzOrqiGkPUnV9zQpJRt7A/7EiYUwASaz5dcCWjXXkvyWF8dCwwEgQl5xkTDRbbAQJNume4BSzTT6tTrAqGM+TzZKn7sALneC/SxUIQz4DwGN/GTXnmdrC1I6NAyZTps+a6YveHnqBMRsJ1fjYbjmAqsvhTbmZCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEmcqJ4ey9FDgvvgqpCSStBE+sO95DIia/FXsfGbH9o=;
 b=nUIVTTDmT8tTxHMPuznPtzUDq+ggyblt+ismAgqqMbD9pSez8Fkw8QDsDbfEK0/CdLu4QDASHnqwpNU0lvCEqWXf7ZEoOecvx1KF2uTlr5SCvVDF/iVAFt5ET6j1XUzsWo5SGmpY40LWB2A2HpjOL2jY9p/xZMl4+QTbx5SNgE/U0gWPH0ZV8N4vKgMD8Czg9lljSlth+EY9WMRtP88y/EfdBLLf2VFPRes43gvW2rjbzbsaOMgvlMTcfNwR+Kee412lAMeASUID+C9UMs3T0ArbMlfDwCjjhyadDjlf18qCOfWB4kyMM7/lb+uv4TJIZX0HQFTDgzsoV8uXvNrpUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0456.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:13::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Thu, 3 Apr
 2025 10:28:44 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::f06:366f:7b4b:4c9]) by BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::f06:366f:7b4b:4c9%3]) with mapi id 15.20.8398.013; Thu, 3 Apr 2025
 10:28:44 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Subject: [PATCH v2] MAINTAINERS: visionfive2: Add match N: starfive pattern
Date: Thu,  3 Apr 2025 18:28:37 +0800
Message-Id: <20250403102837.2877-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::16) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0456:EE_
X-MS-Office365-Filtering-Correlation-Id: a4671128-e690-4560-8376-08dd729a4fdd
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|41320700013|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: RMaunWZJxCugxfUs5nqF8R7dZ6KaJB6YQCQUcrBtOixWkv6bJaNCFE1PQpW2XeQJW6MYTIwhvr67N4SrQ2xQ1nCUu1GiHZSkYPRjNvAmm0slMOqh3g7i0TkrVVQGZJhMh6PqbN5JcyUnx1mZSVzcqQyg3UyG9cWkqnR235GsmiHQ3+jebKj0lvWMMjblrMQb/olPlF0qg5baCoIcMjJxalv+OWnIbvojPkZ6QJVmYtToYMBelwOL/85thvdJEPv1oTiejlEWS/jSLY8QX8l4ZU/No2AE9G7FeD7+euDmyg0wnFBjgVLDxp8Nx93LlSaJBVrkKZ+S65gTKLmof2ZsJWAjF0iKg8WArm+dXengN37VRR3CC9wnRDxi1Wn7q2zjdMw5mZLRowPH50wfjEynQmkJgX3nrz+Q8KRDUbgnuDSPWCb+u6/VbRttQqM/nQVmMEqPDe8CPOkZ7sMuS59zIbSAWt9j00OZOM1yagEZpK57/afmUSQDAPw/enLFaPHoo+1ELMiOBZ5OxYx6cOtT8hJDXDFImBZP8uDQpMddos+1ewfeZs/hB7bs8TvPaKDNaOJZN1tYiw9fwFp1WEOA0EnjvorvarHl5YYDwYa6Hq4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(366016)(41320700013)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gyXCD9q1xpVtiMZX3BgAaiuFz5nVeCN5S0Lrdd/5seQRcb/AgbY6GOb+fMtE?=
 =?us-ascii?Q?9sdJ7dGcByawAmYrCjrXptYsi226c2muMb5bKkwNu8YiegCYxE/eFaEIwlIo?=
 =?us-ascii?Q?ldkVHrDNMFYA8hxB1+NPUPkXYqZsL2qaVTm97upjswbiBmSHQwtKeluVbYYG?=
 =?us-ascii?Q?6KriXWBXNpi8gROcjACE4NlmJh56/FEIROELm/0nC+lNHqH7cWLDkvYvlfGz?=
 =?us-ascii?Q?FbQlozZpHZkaMy/zQSgXZI5xadaIBXiBqDaGy7qi5qCs0pJ30KgH2Cm3CCjb?=
 =?us-ascii?Q?e2a42ZT7c8ypSgwh9CRU+0Ma1+Q9mc9KRMc7bDo6Zy7uQSyxaW+M9vuG5sYt?=
 =?us-ascii?Q?Y+bDxNMtyrsGnM4myMaoo1RnqFszAoxBU2AvuEur7rDNb/RM9e8HJ8fk5tdq?=
 =?us-ascii?Q?ZSqknnnY92+CTC7dMfgE5GsWmul1UIm+lxKaLOZ8o2pNQrIWhtMotp8EWSqr?=
 =?us-ascii?Q?Kn5xPlTwS50HRP+LI1EXmnAs6m6G1j9NhocCs1nB7xeXe7r+fccuB/4o0ej8?=
 =?us-ascii?Q?429hNwMzIRmQ60w/kcSAjHAn0pvk3f8mfLBqJJdQv8Tvluz0HY7SHdFp7Wol?=
 =?us-ascii?Q?v7QXEYG71pFtKydZlxITgs5eeoXpqnEK87Qv3eX4s0VYD5/plWDxJ+9J6ONl?=
 =?us-ascii?Q?My6wvEZ6DLaI5rnipdD4okMGC45l/zl2Q4y6iW9xwq1I2MEI3tskmebOT1EC?=
 =?us-ascii?Q?Yn08xc1p8HGZIvxpoizMKzoCBT1wU6AQL6YAoPUzMxQFdNnqy8heyE2n5eCr?=
 =?us-ascii?Q?wpxoUEMOUElwC+zAS9xfys4Nf0g4WKBgXe11vyAY6Yy1pZR660crAKmJEhWQ?=
 =?us-ascii?Q?BlkSReIEmBWG0UYNsFQnosMq7X9mynca2jfGUtTwLpwvZoE53yQo1gnAemJx?=
 =?us-ascii?Q?X47qahk4vgkCTToQoL+3VhK9WOjL74rjO2A4aoiTub9/BWDhn3npfzNmmBGB?=
 =?us-ascii?Q?yHkoHJjrMStD7dFXckQQFG/jBD90yfzkBJ6sJ8wLl4KWNpFdZtrMUwhu0yAM?=
 =?us-ascii?Q?rO4zxaHcjMPvU0uc2Tjo2Pb+nmxi2snKXAzdV2FOJYi+12cbZ7/FgPw28o69?=
 =?us-ascii?Q?Wv+NmhLsmCHJueqjb90GCnYkKe2TyQaGAeB1qffUgexwxTJ+SYDYxV6YYu94?=
 =?us-ascii?Q?iGPz3SpgOd0zr5WJG6LpWXaU1c3fHkPYUG3uGuKDMXrV51EVyI6QveEwqsZT?=
 =?us-ascii?Q?Tt/98hN55fVi0YlKX9iR1iokDu8S7GOZX+HIN+xHCg//RieyWo7NfsJmsOAG?=
 =?us-ascii?Q?wacwchKzd0BAPGAt8IslQhmmmVKcvgnjmIO24mzvX4grOUQRGku+uVsom8vd?=
 =?us-ascii?Q?6UCc3RBiD3/SPBkNEju1F+H/2OFEYk23vIjfJnF6gmZoVk2GZYhKPP7GxwAJ?=
 =?us-ascii?Q?A0giXd2JN04XTrxCDnn2mt/ht0ZYcB7SkPdpu7Ab/A2LhDTLUWTPrWJ6vXpZ?=
 =?us-ascii?Q?FmC2Rb5hhEEYjRUeJai5k0zHJriK9fgdYANX8wNTnKSTJMsjw6AI0QMxz2Is?=
 =?us-ascii?Q?1kEKwchoT8MBHMxj3JLWoz3FjAgovW4ZpgmjzQEyWvEzTs4JrqP2TzmYmcvQ?=
 =?us-ascii?Q?3s9VVgq8PFTwBzD6tBCd1HcotnJTdG181CriTuNmeA+cDBRqPZH5y68I+k57?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4671128-e690-4560-8376-08dd729a4fdd
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 10:28:44.8813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zav9sm1A6tCFZ60d7y41dHd98miVsFYT+B/dxcFXyxk3VE2xWrjkhzqbXN78+NiGt/A3BM/ie94ew2DiL4YvoP4lDFZkQk4EBFDMDk5ido=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0456
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

Add match N:starfive pattern to visionfive2 board. Now
starfive pattern just related to JH7110 IC.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 board/starfive/visionfive2/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visionfive2/MAINTAINERS
index 898e284ce2c..9d348c4b067 100644
--- a/board/starfive/visionfive2/MAINTAINERS
+++ b/board/starfive/visionfive2/MAINTAINERS
@@ -2,6 +2,6 @@ STARFIVE JH7110 VISIONFIVE2 BOARD
 M:	Minda Chen <minda.chen@starfivetech.com>
 M:	Hal Feng <hal.feng@starfivetech.com>
 S:	Maintained
-F:	drivers/ram/starfive/
+N:	starfive
 N:	jh7110
 N:	visionfive2
-- 
2.17.1

