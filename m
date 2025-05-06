Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC22C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C99E98056A;
	Tue,  6 May 2025 16:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="uJvi9WQS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03DF482076; Tue,  6 May 2025 16:13:05 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8A6E800C1
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBt79heJQgMGQg67FjTSfwe+Lhrtx3LUffOKe1SDgd1wLsUyqbqPfnzMvhcAR8H/YivaxatlJAO/40TV0JWLgKoHtSv4US6vV+zywxFgbHYF827ihwqdRbQwFQnDzTNm/T9N0X5ye8SfZn7y3pbILSmo/fU21UEubbWqlKJ1mkU1t1CMY44duCpZvLGIxlPrHhfQO1a3vcx5c0yHylMNYPY53VVsqvMV/whuQ8pDQCZ7NiW2oGHq+c3EegvpqKfOXSloChsS9gvH1FvOomkiC8K0+JRtNzu842Tosi57lEFrI0Dq/68P74rUtwhJVk1fmIXXEiIgQQnsIy9rcOPrgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cONFlK1Y3BwjQ7jCOQSUvJvdikVf9w8W9AhzXc6RgHM=;
 b=TKSpL+9mHBE1Wk3R2cmh3dai8mcHs+IXf4PDh+m07zEHG9719H3LfjOFDcu78ZPj6jyt3miJ/uY10m5HBDBkvlDNsS8preHx7B1LC1QCqlclPGi9C4hGGfdCz+g/vtbEUBzAE+XTtbXVpSN2gymulHKXMqCyv4TP5WPzq4Edk5qAcyaEkTggIPzXZe7GjZKZBz7KsXtm1mSVekgdJiFybEpeHD6Wb3s1yAiy+3mIRsl91NI2tyHlC32yCrTwQvgi8IBjCo6WyatHDC90HsvW3iCe9CtUv4AgwR+GH+aCG87sLAVgtS5BqlVod1BlGikdDhiuSQLVbrR9sozLpm5lPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cONFlK1Y3BwjQ7jCOQSUvJvdikVf9w8W9AhzXc6RgHM=;
 b=uJvi9WQSS8Cv3tYPqKzioaYLwxTOg7AKvyXURj2nh6vAxjtuLlhsoJN33oJsPypz6UNsbJ4akYrJAr3eQLeYAxXHB2Y0lwsEv7sgjPoS6dt+G1cMOD2S+Vq9rcF144iV2HLv6v31JOzT9rN+JcGnZEE8KUw9/Y9mCAVRCdoosCA0wtEzvEKkSvFtGXVovEOd2DRfGftBOGZ0mZejwCSUSThuoJdCXQpICTJaw59Te78axHcuWqB4GM/3wIkIDiL0eD+A2yowDeUcn+evd0eNYXMW8mggQk+qS4dI6OnJJ2wuWHJJZwONpCi+NJcb37V7Fabrit0Rkx4A6wDhh3uyqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by MN6PR03MB7742.namprd03.prod.outlook.com (2603:10b6:208:4f4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 14:12:56 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8678.025; Tue, 6 May 2025
 14:12:56 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 0/5] Enhance DDR support for Arria10 SoCFPGA
Date: Tue,  6 May 2025 07:12:41 -0700
Message-Id: <20250506141246.6672-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|MN6PR03MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5cf1ff-ef9a-4c6c-0475-08dd8ca81913
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j1YUsxG1HC6goW8QDfiU5NqNNjDWwoiiSWcfY0sAbytyI7LlsKQFRDQT3uTo?=
 =?us-ascii?Q?/NNZf3wtp0jtpbP5n+4K7VothXMpQPkgQukAJq/k8MB0lyjnDp0/PWAC9vpX?=
 =?us-ascii?Q?I3PJ0aoGz7x7vHM3dSkoKy2iNphml1Md19sdm34BI+wmsVfG88+5pBFFZrLg?=
 =?us-ascii?Q?qWiNWULGUHZOQ5yRCOmFRiUyjAaoH1cncfvd31Jd1vE/szewpJBTURmPaICL?=
 =?us-ascii?Q?swHZlmX+94xB1pOXfr7o4s/PjhsIY8r6W0CCtTrbEsMy3FTgVU5MGNii07rg?=
 =?us-ascii?Q?+FZLUwkJvUuCShalAga5yYSgKe5QSg3bTBjKMKJeFVXlLqTm+nHhfy0jHM7m?=
 =?us-ascii?Q?ud6W5Aex9Legl+K+cuOmT3CgoKPYw6ss7fxUeRyp7CUZwk50jZjB/cTGdo1T?=
 =?us-ascii?Q?WcjVfL8NIjwjbT20iLYtqT5TUv25jLWzvgPxviaxywOBAVHT8USqzSEZAKhd?=
 =?us-ascii?Q?8VeJnFbpkesT92lozcjZo71M39FBnYtOjZC84MN4R1KLht2DQG0aMRJpTNh8?=
 =?us-ascii?Q?Q/bC/pliS8FatOel5/7eaQ2eunabfrsHIl2yLhvtNp9FM+KECIiqeOnbcTBl?=
 =?us-ascii?Q?11p5Ze/rExqjzn2K8Lhy1PqkKjA7qyxrWPvvLuvS4eIcb1wFpinR+ZvtO7nl?=
 =?us-ascii?Q?S/4Ye4awpSS/5EN2op9zgvK6bPr0yPaTuErnOp6xHFoGJ/ZiD13zCgJu2Q9m?=
 =?us-ascii?Q?DDrXSJT7vD/eYVZ1G2YcZKFW9DiNVXii+L7ZaKfAegLXPpE355ezlvgIDWC2?=
 =?us-ascii?Q?+iGWOu8nl5qD22UJPsNa7TMtp1lZ8GxUI2r9XaR9k548YuG/bdjE022CDjuk?=
 =?us-ascii?Q?ETMf0JInLIzMKOsfMgTCy1xNTgq5a4ieJ7S4zh+0UbHB3WVqZmedxUadpMpW?=
 =?us-ascii?Q?IjTfn7KK0CXjrc9C4lNbXYQWA5xU3VD7s7MxZqoeZ7t46Zy2RlrxNXdvNuWl?=
 =?us-ascii?Q?fHkFjJGazJ7Muob5FgQUrn+u6sJvr0Ile3g91132wj0tnJNyTHXS6+2e2ctq?=
 =?us-ascii?Q?o8+ZHk4GdWQUzTDJ2X6bzO9kYWN0Pcf/WLIbADiw2CvuaQe5ncVvB4Fx/nGB?=
 =?us-ascii?Q?KUgzol95ZthOY6Wt4NPyLbR54ypEuLry5k4lhJbOwHNUBaiSmGySaIcnys50?=
 =?us-ascii?Q?eQYJLrtf0lJD5P6EZDyaMZaSYoELbbkDW+At3BXdiakeZTIfQsxemqhDye4b?=
 =?us-ascii?Q?AQnxjHipE8Wrfwy35InckiNrAlTy00P0NfRQdb0CZM8oEL5S0sieBJ9WDLIt?=
 =?us-ascii?Q?6ZNOVbgdvkzZvylEqJblXIZ7GqdH6QrbcJ1dvPefakCWKVB2dfKmvG4C3VvK?=
 =?us-ascii?Q?P0rGq5pk3pY4P2WaPTa0/pv4Vbwx1jwlbMcHn/m9yrxQqodwdSopTSEQ/QX9?=
 =?us-ascii?Q?+CGEAa+C5ka/GLU0Gfji9L5kY6w2hoK4QVuEJR3eg7e6nUFwM5MXQnaItIr2?=
 =?us-ascii?Q?JmktCplSE5Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QEtcDF4zbx5rAtaOE4ydKr9TKvdjMQJrcHEIlrt+7q8f7LtmxLZ2h0UnQLAx?=
 =?us-ascii?Q?WKZeq/zSRjYkqzTCXnN/cvKqQYgEz3cr3SJbHLLxAa5sAMCVvAizEgcTCw3C?=
 =?us-ascii?Q?dASoR4o99OqNn1Dn85IyNYbXQwLqi+lpgSgvJmYAjwjIUD2/khWhcG7m6pyE?=
 =?us-ascii?Q?omKN1dTg1/qCgx9WryvEapn5eYd9en16NQbGMd6ShZ9De7dNqAfK8qsEX6zq?=
 =?us-ascii?Q?6mOOMag5UAX9Ur50yabFhQtYZbmQ5LxWbNLumtTFHGIESskAkKymbfpG+5+5?=
 =?us-ascii?Q?f7LRY51lWtqPkCwumxT9iIdl1oKH6KCiKG7IXBCinuu8Bi64lbADT24wUxWc?=
 =?us-ascii?Q?cx9rZOMLUsUJSChkLjSp0t5O3K+fk5qC0O+7K2B0plJYOPDEt+VwdpmZkQo9?=
 =?us-ascii?Q?AF50+t1wGU9ZKoK/g8miJ0qicM1mWjYmv2cZsQ0M39g3Pl1Cs9uGmwvYlLw4?=
 =?us-ascii?Q?MUyQ3cgiECRDFJXsUYQvqptwWGPUbdViHNPcTyzCUUKJ7df2S7VWpb8njCN8?=
 =?us-ascii?Q?k9XLWJEvNqMzFyVJyHflwEq8xnkEQWoKHGzjEQhM6umKG0S3sD7EH5niQKyz?=
 =?us-ascii?Q?7Fy3A4ifkVBkcpVJl4p8AjCMQlulTlpLq0DwdFyD9udm/4TwlHzFiaup5Yw+?=
 =?us-ascii?Q?4sZKIenSsKGb1x/AmDc3s1i/F2BsS6Mci5bgyABGGZb2PwQvLyEReqIwP8bB?=
 =?us-ascii?Q?Ai0vGARJo/oFBMn8OLPKHbNLYOyu95aqPDb2nB6TlTil/3kMcBeiE+he8tnh?=
 =?us-ascii?Q?hLvKbbWx42h//H03bgj9FmMmqBXp1p+tYVsblNzKYwPiISqW47Fzx32j3QfN?=
 =?us-ascii?Q?kefdnxKrF7WN3uEQshw843Sfq0XtZuV8AY2I91sh0BW+pgPzSCBbblJuOzim?=
 =?us-ascii?Q?HwKrdkkO8aEi1CvOnYrE5QE7CsYlJxFBOo8ZfolbSmI3YJkT/UsiFEaFkNWm?=
 =?us-ascii?Q?oACmzEIPGqreCCx3nlxI91te7s1cwn1Pu1wY8ZtpNlXPvJ63IG2Ou6Gj/LFt?=
 =?us-ascii?Q?3T+vJkWumzXcZWw2HjhbldrB69vSDxGpA4ogE1zUH7Ihsu0UG7PALPyg6QVB?=
 =?us-ascii?Q?T4mHGcoizUVz6SpABcUllcTBlbv4yOBNpglUeCcllebNvN3p7tpOKv+eQhis?=
 =?us-ascii?Q?V1FKPj0mC6HeJWJ9rw1WLzriTPGiuFHL951a1rpYGjJnAavWd+qdHfzG6yug?=
 =?us-ascii?Q?zmbg9f5RrtK/Jl+E3iC1IZKkB/Pcj1rJ98X0fF5q3I/kRDN+SpWJdA7Op53H?=
 =?us-ascii?Q?GKkwFlb6rWxzTTNa6p+c6nVeDY6Xg6l3F1rtkmqMUzvbkNjmvyXx6J5NBlOJ?=
 =?us-ascii?Q?OEeODeqCI2IBFaVX9FLsvOcnC2NppIy4du5nNJ75yNRTiYOjW1St4y18Ve1a?=
 =?us-ascii?Q?TSNF6mos3juyYBslrLJnEnmDxAxwN0a998G17QiYIdRTiV+qjTf88s2CdQPt?=
 =?us-ascii?Q?fjQ7ReD6+/ES2fVG2Al5el/yNV3tFUR5Kqo3UbJolpOpPjMZexadP3iThCcS?=
 =?us-ascii?Q?vf2cqbGmMul4xPZlACKadZ4ToX8iGLl2YoWr/EQZER6N2lR7T7ZB23k92Dlk?=
 =?us-ascii?Q?nz1DN2s3bfmbI6b1u/WdgtIjxirHCNOKnjnodmkNNl9T8WJKonjj7B+Hetm5?=
 =?us-ascii?Q?aOHHRIhruaP1BzB8xuvdN1w=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5cf1ff-ef9a-4c6c-0475-08dd8ca81913
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:12:56.4297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+dfU/okRCNIzEpXuNIiXrW0LrUmalxyGRzQbQ3pHKjEATNnt7JbVP+hR0t5da+HpnHsSQWXNfZjGrhqdZeTdUGNSAAx8KN0LsAxvd0sh6Htf/iOfwtuaWqXy4TNNXRd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7742
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

DDR driver of Arria10 SoCFPGA is enhanced in below ways:
a) Check DRAM size from device tree and actual hardware,
   mismatch is notified to the user
b) Fix a bug during computation of mpu1 address
c) Move common code specifically, initializing SDRAM ECC bits to a
   common sdram_soc32 file. This allows using the same code for
   future devices.
d) ECC scrubbing is sped up by enabling Dcache

Naresh Kumar Ravulapalli (5):
  drivers: ddr: altera: arria10: Add DRAM size checking
  drivers: ddr: altera: arria10: Add valid RAM size check
  drivers: ddr: altera: arria10: Fix incorrect address for mpu1
  drivers: ddr: altera: arria10: Move common code to common file
  drivers: ddr: altera: Add ECC scrubbing with Dcache enabled

 drivers/ddr/altera/Makefile        |   2 +-
 drivers/ddr/altera/sdram_arria10.c | 115 +++++++++++++++++------------
 drivers/ddr/altera/sdram_soc32.c   |  88 ++++++++++++++++++++++
 drivers/ddr/altera/sdram_soc32.h   |  11 +++
 4 files changed, 166 insertions(+), 50 deletions(-)
 create mode 100644 drivers/ddr/altera/sdram_soc32.c
 create mode 100644 drivers/ddr/altera/sdram_soc32.h

-- 
2.35.3

