Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DE9CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 07:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E30683981;
	Wed,  8 Oct 2025 09:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wSjhRdIP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C557F839FB; Wed,  8 Oct 2025 09:27:50 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F08A7839AF
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 09:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Is9t9/nCeIK+xi/6iw1tYgWSdwxvpQxI2MN+abYeqSBwA8W4+ZsxUSBtYt6JF89fY60haPv8FMcp8pCNv3BJyvmnct6uhDsYddY/SZDq4DMEwGkPkKLYNHXYwChrjVk5LmnnkwkanFarwl/4wGr71ioN5MvgLCdvIJVPrqO704wUNbG5GtzRovU0X/lGIUSZBjOVCWyfH4Tng/LAceq+qOwCzYAiknmp76UO5yAgrQkXHpyWx5sziP1sIeVTUuQKEAxU5KuE+5txZ+5tecasttaa1tX7VPmCnaVnYsvGKmg/s2sLLqM/wrApYtGCVwxvFUnYrPbkcPJWd0N55GTn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j45hzRoN/y1fuPScnC4SInZix7FcZWyWJ8PfMdDW6lM=;
 b=GPtWgVKFWxzJFL2AZ362OabkmVP/Q5lYb2IDdRZ3ej6M90tzxoxAfmlrpFPXSAYi0mazfw3Ox5P+TpxtI7Y6KYQ6uyrObBZnFDVNaZQBJmWdc9/qNXfwvKm5AUF2serNkwaIa2BMyR5UYdJTFnbH60ZKQkwEtVHPI7rzr05MdNTbYovR6V9L8STtK9EahI9EOe9Eqj4dNkllaFZXupF0RdvSdRAYbevuLQxS6L2KbwMrbPwZRnBHYA5tODDmM54fqbcEFBokinPzYx9eSEXuiFMtlKnmP+31Gsj/J6HFjqzSW9+EuhVyZSZ8rhmv4u1O/IquZj4S4qUKIlLl65bdjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j45hzRoN/y1fuPScnC4SInZix7FcZWyWJ8PfMdDW6lM=;
 b=wSjhRdIPAbDgI/7yputQqXO9l2lsufnMb59gqLkpnFn4tcGWyfbeAYi2OoFY7RJZcDox3kBqKaoSt8gZ5kRIAgtTvGiPp3m/oTMC+X1d5pvKZbbLTA79knxG5+bYExHi0SF33ywJsSjAYK0XCHWGHO1KLg+tAOx0Ns9Tgu7dWL0I6J/nUvpo/epy6FY9Xm2q1e1fCABMvecHq9FlGbsWubwDKIZ43QFG7maRFB8/IsKkdX8Hp7JPCPL4cq6LAFdXIW9OB3p6v2YiUO+s2efH3wm62P1ns7XJH8Vl3TehOq3cyO9BNUT4plUk0TIekn+HLtnGPmgqy5Z1by6w6biPgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6097.eurprd08.prod.outlook.com (2603:10a6:20b:280::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 07:27:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 07:27:41 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v2 0/2] net: airoha: improvements
Date: Wed,  8 Oct 2025 10:27:31 +0300
Message-ID: <20251008072733.373173-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF0000384C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:e) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: b68ab51a-d4d6-4b5a-7090-08de063c2a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dIxdldwZk5PXXk1KsY3UF3mrQVCb1ODNylZn1uCCjJ81yYlbox5PcYq3vcls?=
 =?us-ascii?Q?k/9l14msMxuizK7XACzaQIwGNHkvDskohePWm9c0P/KI5nt6xqugThikGoAx?=
 =?us-ascii?Q?TyCdMe8hlGuMzmkyhe5IunypFhkPwqJPL8CKpDIHWz1AgZ6Kryq6LNxzBLx5?=
 =?us-ascii?Q?i7tYCF2nJ9a+t+pNu91lQwYQJ5RARM7/kgKX9iP24KcMVxuRY7k9Hj8U+lr1?=
 =?us-ascii?Q?5R+o2GpJ7ppUgNB/O7rzv4OeO5vITgaJmx//hbqg49z9pfZFx/15UpmNri5C?=
 =?us-ascii?Q?qkC1DpBTiBmPa4O92vcKT2mAzjp6WzYaQ3eKT+YiHJAJqwUeTnmHjFiUb5vd?=
 =?us-ascii?Q?yu8131auDAKNxfzZL0Nk5kOUJGDcRv0gxh/SOCMS/C7tdE7ylcua75PCw+ws?=
 =?us-ascii?Q?N9ps1UqgwQY+IFVUWH21hQm9tS3YgLXZkFxhEYlf2cQVELMzpMkF4gnP+RH8?=
 =?us-ascii?Q?x2D0HxPvdiADBBKTRNj3D/zCubTjGHZiifTlF2s8hk6Ra5PiY5uPpVkOTxUc?=
 =?us-ascii?Q?tBnVm39xvIYNRI2N0lUQvVsfm9tm39klbn4hBlAOJzcw7UfTqTFODSp4KJMe?=
 =?us-ascii?Q?9D5Fld3qwYN6MTvW9dBD0L3fK0NCaN+/l/Yhu7XO4msPDvLl33K7D/0nrpBT?=
 =?us-ascii?Q?iVY+tJypWTyD0qQ4N0WwO4rJEW6gvq/X9dnB3K1flREbj8s3X8Z8H22ZscwI?=
 =?us-ascii?Q?ADJUdxozIAWFXqqReQnA0kvU4wObBZKYIEhDyAFn+L4cgf5yvJs/QoAy1jDD?=
 =?us-ascii?Q?bBUAMZ7HZyjNmnIaQftnnGJzFp3nGhwoBo9E0zZ9LTifIJI+NTvD9ovqWkqS?=
 =?us-ascii?Q?MOp+GVa7ujz3+nF+EUVIsWhCQuvYXVmnNFotF/xYPUtofNRyvdauXlBo5DJL?=
 =?us-ascii?Q?IUln5ksb3qh2JMvtXA/ZFiXNc6WXwGotSCSscIiLg1LJ4a0MM8Nv4B671pk3?=
 =?us-ascii?Q?qM3Qz47kqlBF+u2eeOBiwXFgnNYis+rd4wQ54sFsT/wETGPGem2A+DGYFXVX?=
 =?us-ascii?Q?PwMLhZKbiXrlWiEUeU9tRzmFV9KoEVwOUswZJl+Gbjy4hj6LcWVVXMat9Quw?=
 =?us-ascii?Q?mQmQAcHt/NyO+VLpa+8HdvlZWRagJkS07Zhb5fseijYvk7ihdZPtV+J4bZss?=
 =?us-ascii?Q?QlbpqD6FojoIRI9j1/yg84Zgc11hY/6h/RzTc4PBpUUCoeWDVnGhWCF5qobq?=
 =?us-ascii?Q?MjRUqHrw+1p7dZeOCmV/p+wqAE/lsbzovovHV3xyO2nltPVfdpOaj7aS2y2c?=
 =?us-ascii?Q?Dd1PZj9dMkCjvTm/48xzO0P/bltQapr3EkajHOcFVWdFY7vuSL2K9+OfZUeX?=
 =?us-ascii?Q?kpHrCit6zOmZh7IruCTex4Y62CEi0+EUG2WVvg454Yng0X6NQFUP4LtqP1De?=
 =?us-ascii?Q?CqB/5qw1T7uSUe+Dt330NBi+wt2IjHbq64qlwJdgUA6dgKW1lwIp7ndVdm/E?=
 =?us-ascii?Q?29+OBhkaDl8oBvVdT2QSH6qyHgaRbYwPMcnckCS7hB2d+rkNYehbUSSsW9/d?=
 =?us-ascii?Q?45M9s3ee/a43vuUvk7psTfXr5uFluOAcAshy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9AdI/dREOtbQFhKttgahgOT/wNTUtNdCcuG7thdiceKDyTMh9lzhUTL5qtfW?=
 =?us-ascii?Q?i2980Khz0dhKdP1xofJ9+wL681osGLw5Idelfm9+wZonjYcOOXk3F9uR5OSn?=
 =?us-ascii?Q?epOnkBSKvk5wWdTn7WtVW/Ql+AV5xFX40yns7GaIJ8QACDGHPMWibd2ZXQwV?=
 =?us-ascii?Q?2Pl7OVf4pDVXM31TtOPow86TihZNtxe0r42xFoqQf2/sw3IhsKEmr99yT58I?=
 =?us-ascii?Q?VbTc0LSlE9IJdFbRtbc6nS3Ww5yNY5dMIWRVtmEE1TTXuylYvwL35TTRQlcy?=
 =?us-ascii?Q?Qhq8UczH2UEFNn4+6YkN+8CJTJ/INkQo8ePInTVb8AwZLQ1nAKUQfitKjpYG?=
 =?us-ascii?Q?U+Yk4eU7GUI4PS7yFCTrSWTKsEefH3SqGbhVP6kZfCgCO6/BLV12PBbtDaQ+?=
 =?us-ascii?Q?x97h2QOnOtCx+hceEAB4uh7LWZ5teww/CqODzz1noZhmJkAcGSqFyOu8WQfl?=
 =?us-ascii?Q?OhY23SpLA8zgpqUEOLuNorxknnAkoYXikDua0e5TCS/SvVKEEukVedW9U2d2?=
 =?us-ascii?Q?rNSrpFA3h/UfLSXZM/58Ueh1NH5ls8ZdIhqqtzsagBjTpHUth+9hl/3jR/AR?=
 =?us-ascii?Q?OR00xoKqDtWHgrN3uYGYhGfJZlXVPGQn9WnIhygLQe4vJMij5KQpFHnJhhF0?=
 =?us-ascii?Q?bSt3IoDSeVOff9IxfHG0fBhqoSHWct33cvXNMhRwq9nHHMPy69v9p0QuM/Qk?=
 =?us-ascii?Q?5R0kPOUFLZ7FsVwnBboEzBTEeoYT24erDGgRPPHGX02vVv/A/0l7JV+c++pL?=
 =?us-ascii?Q?8TXOyihviWSNogdhaJbtBB0T1u0R/+KzvmHrLpR4wWss5wnYs4/K7YKdnqKL?=
 =?us-ascii?Q?5QwB0VBKHMWjJ6YEubv4ysdY4e51/SVgm8aZ7lMbentOp5+Y/mt/n3aLD9Pt?=
 =?us-ascii?Q?K1Snp61dFn45oe4BkpLORty+JvyA4E5biKs0KK1yrBSWMg7i5Ty/xQ1CSCa3?=
 =?us-ascii?Q?zldkap1BJNqCe0BADXynxwMDLTYQV2Z5dFKv0HXmV65X1p+mwakRjGjCx2AN?=
 =?us-ascii?Q?TRGLrrbK8SKZ2HdraIqY56/3ODvq33Y4yIa0RI/jFH/SgZvKtkQdr8Spnu16?=
 =?us-ascii?Q?tCpqIC/xu2GRn6v4I8TksK1FhpKwYisJ8zXsTkPpaIwuNXh/8vnVc4I6QR15?=
 =?us-ascii?Q?HkD7Ls/2c8aRXhT6YTwcX9XvIxxKBXWZlPAK8N+wjizrcDIt3BuxcTBYWo1X?=
 =?us-ascii?Q?dR8s6u2hRZP5s3c+WJxo4vAFAnS8sRd+CGVb5DZC6Y+jdOyYGL+dZEn16j3b?=
 =?us-ascii?Q?gqknS5MFCenrqXn/avWyYh4uSw/uZQOhWPx7ILp2AScPerrcZ/GMscjQ6ov7?=
 =?us-ascii?Q?M47CR00C/7+6HViC1E7mw1VQHQXJ4N9XpdT7ueXBHsUquVp9RNwGlNWZlWhq?=
 =?us-ascii?Q?Hh1GBNrIhmVLbfxLZUwHCkL16NV+1M4FtfnHaFHKQnwa2UVDtkFCT3nucH4W?=
 =?us-ascii?Q?nGjAiHX1rqk7+DuEb9+yoUIRKSTc+sKhmE/AIyaNHewAIkKE2CDZe4kFDV1t?=
 =?us-ascii?Q?raTNogvR6ENz4TRwZCKAgBc9LfTWsm0AKflBiCJLYL/EYrXw9n1YkvYCrpYc?=
 =?us-ascii?Q?/Y9QVvr2b6ObGt0H1dCthAdK9oyNwvODfi3skWvyjZQpFv3QtnOO1VymrOZD?=
 =?us-ascii?Q?xg16UT/s+75lYjFt4WArgvs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b68ab51a-d4d6-4b5a-7090-08de063c2a16
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 07:27:41.0253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKYNqQdfmaENz7DrYdDW7cyBWSCDQlT0O/l6+p5Q5MnHSBXhdjW2UdDOC1+DVXsr0d/AhgHDKKjOcGt+h74KL6sjBr82mqHn2BwapYtsRYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6097
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

This patch series:
* improve logic of rx packets freeing
* increase the number of rx network buffers to make ping stable

Mikhail Kshevetskiy (2):
  net: airoha: simplify rx/free packet logic a bit
  net: airoha: increase the number of rx network buffers

 configs/an7581_evb_defconfig |  1 +
 drivers/net/airoha_eth.c     | 40 +++++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 19 deletions(-)

-- 
2.51.0

