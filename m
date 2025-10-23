Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91410CCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 08:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9DF78323A;
	Thu, 23 Oct 2025 10:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="XqUVYTtt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 399F783303; Thu, 23 Oct 2025 10:51:40 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B7E08006D
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 10:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oasEIPJbHqPL+HSfyB05+HKZ6mUJZgW6nWWv6rksjQiAWYpSD+kDAUPPjgyYUYGQPAnzSyyhmydCyT9xTYLuCRiU46KquuaHsTeOTg7bRypcHMuWcwPugFDQqW30OLyfj35hWeOBIBYREdd0c0IW+3F7BAn7mybPGy9T7xLg2QyoWO1EJWv7EQt4hCsDhfULVdKEkQl0mgIkIl+SnFR3SKncy2Y/o/Acoy5t+vn0VjZSDIFmehvQ6mqRtWlmFtFooDM8b+Lh+m0yqu9uWvsp21yIVxiX4nGNtE41wjYCRbpgEZmLCUcTXjSfLjmykXsPCs6ixpjKFwJ9I0AFEkYPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7hrFKvfKET2gBzwXh8OW7Fjq5zO2ApIxCZ6vZAxLG8=;
 b=tJXnX9AraOlk6P6FwwAI/wF/a2QsxJYqcMVv7RbI8pYjRZUc27L0lVPQwhVKBGYgQgcEDoRR1wdL4vSdgUL9Mb1TMHsASam3m/8Hyk2TR01GRwOCaje/vXsK3bl7SSsVyvJrYvcrofSkckJOSaBX4SfYEAGmzhreTUKNp655nGn9vaQFmT7EiEIpxMoo5LbA9kxcXCYsa6noUj6maclzY9vV2q7rQi76LcW0g4Hnf5HvUqgtnvCbLZE4Jp77/okdvLzuA/GgnV8y9GBAj/7VuFhK5ys4KlcEzoISt//c2SWWynwUZAl2UK2n3pGTU6Ee/y4ZKxL1pkZt80g3oUZp/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7hrFKvfKET2gBzwXh8OW7Fjq5zO2ApIxCZ6vZAxLG8=;
 b=XqUVYTttb69MjOAcpFSupbz4rzMrbP5oMw5eOjxECm+7Zcbdo6fDrrGb70I2Uvbm5uRGvuMl42AK+GGW/30uLOj3Ij/xO1GYMz8MLBNT7VAwBFry4agQ/UIpfVU1bWBVKC/zSmpeyKqVlK5nvr48oDpHpXHdpyOpV3XIxnuClQLA9FBDXNGx1n/pkDMzujZlbg5eG1N8li1NfeKnQsDtTRAwHIcEA1ym2CHe2gd+0ugCQR7HFH7LceH9oVzUUmQ4dUg7EE93uc+iO661iLEzhTHzzwYlVG4AKRBcNAsrvjEFWG5lHCWW6SFIFhzUXvPbz6YN3sN+8YcbnE2xGzTbfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by SA1PR03MB6433.namprd03.prod.outlook.com (2603:10b6:806:1ce::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 08:51:35 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 08:51:35 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1] configs: agilex5: Enable FAT-based environment storage in
 defconfig
Date: Thu, 23 Oct 2025 01:51:22 -0700
Message-ID: <20251023085122.23607-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::15) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|SA1PR03MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: b0cf6c13-b4a5-47a6-3fb5-08de12115f1c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e5gssthUdBKarORN64ZFIYi2ZvA9Je5c095inHo3RxCu8MXp6XwQ2Fo7f6zZ?=
 =?us-ascii?Q?iW/LB0mUDh9Rewi8EMf40PL9ZKtz0L02G9O9i5q/G0qSGRXQRfSsIVq/nMRn?=
 =?us-ascii?Q?vvSSq/hPNZ+xA4tbjmpgWuqiJrgW7IhdAtuDPeWCQgfdjRYhOWO7aicfhZkz?=
 =?us-ascii?Q?Bsd6hFQUlNtC85NF2ecswxpyJtImnGNPXh8AIbSHC1hIfXA/pq1O/F2hN+Qe?=
 =?us-ascii?Q?d3/YslrOfD2IJihLHBWFJ1KifV5lnbtaFciUcPIfTAia8AIq0RE+5c69/M2a?=
 =?us-ascii?Q?2TTb3ZwPeBV1W1Tjr4OkV0rbCqaCVNE4ILMnftzPMCvuzPDbRaZJ8e4zqZ3Y?=
 =?us-ascii?Q?orTtDkD8C55EgvkDciqtBe5d8roRK+rw3NInIuGV+yfF8xFP0eI6HuoVeAPM?=
 =?us-ascii?Q?U8doGCK5UpbmYuxeHrKoan/e2Gxokllqnza3clW7FWbuoCVXmF9yW1M2R9+U?=
 =?us-ascii?Q?qQMPA83tmNfKE1+c2dLEjYBpgo8QpmQRHsf9cDbdEOmI3FnnGe4N2cCWHgmA?=
 =?us-ascii?Q?YA4jfwuPpa2+X38+7WMmVQiyAcYfh3fPPRr6kARhyacl0EQNtmgSn0v7TUIE?=
 =?us-ascii?Q?HnAfc84sbIbeTr3JAZCRWuoVHYcjVm2yj9fhSv3iPnyHQfKw9QYuk1Zeu7Sy?=
 =?us-ascii?Q?Q3qQX6698d7jXcLz/mdZ+8T0aQcCyrEbsL3+D930ruSRfdGm2Q1OmGCN2KVo?=
 =?us-ascii?Q?Pyfw1mU4cVZEXt/4TTk3ZPNYG67UsJp9OqIXfmm7eh8GddYU62htKc0etnFv?=
 =?us-ascii?Q?4ZKi/GIHKPLv5J1AJVVGJX2GgTfwQqPAim6pEPhA9AwCziWreFwJqOLtd11C?=
 =?us-ascii?Q?IQhcU5PdSn86PtoIBxMlcWhrArvmWWrR2HufnK9ZQ8KsYCx1noU6YFTaHDIC?=
 =?us-ascii?Q?XPL6jIk19hlFxOcMZdc3hLuifFmB2KXSmYviuXsrx0MzeSHl9RYL+C7ma4Ra?=
 =?us-ascii?Q?kTEkTodClHGF3SotDei9G/NsozMCOPX9YSE6EiSe/61LWpwPVz2rwz5WZoW8?=
 =?us-ascii?Q?vkRO7w2Q0oFXyX3SZbbWkNmeFaho7kKA8I/lc+xxKtZlCHMM65daL3tZhfYv?=
 =?us-ascii?Q?GWHb6q2G4q4zLNDTCZFfrlEI7v4V2VbpWx2efgj+N9ZgJ6tZfEeqXWZ6x4y+?=
 =?us-ascii?Q?QK0nunsjGEFreDCjKJXQXwFxxE+D4d5xRuxu0dLMdQDxYLTisr03n/bkoss2?=
 =?us-ascii?Q?vorLth+eacJCMKQufE/+s98D49Ff+snYZWFEzvitbUzo6O6I5mxVDZOa0pX7?=
 =?us-ascii?Q?tc1BjPa/7BeXu5yQrvvjATeXZ0z4xV7V/XXy1bv5nQLZ6It+UFGVcmpCccrD?=
 =?us-ascii?Q?dhtHlSes3e6dRXZxjLLu/Saz9vdJt2uNsT8/dhy3dx6uXVZj75LaZf29UDWz?=
 =?us-ascii?Q?muwyakwndfO+5ZnH6/NkAtxTzFvvDnhu4UUJxMYvGb682itlWOCHFRSB/+hL?=
 =?us-ascii?Q?s+eprFiuyUMQE5/XxLFg+H+FK7gXDzuR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3PnK+Hn8dcLi3IRTIJodTeaabB8NrC5uW4YYjx/+b6+H0Cp2n5ITP+lEzqnY?=
 =?us-ascii?Q?sS2bRfgx9BnvVi0iXyFzhvkq76XEu1g9mpxGwPvZcjb6+irXAqQJx5ZOoar1?=
 =?us-ascii?Q?fEYRQbbl2R/OovjZhFbDs2kkinAna4FORO7SATOWKyuChLCygwFf9haI/r2v?=
 =?us-ascii?Q?uLta61PCYKVWPeUIR/FrcGO+naqoEh4Jp0wN4WEJfCIMtsWGOaKv4xaO14sF?=
 =?us-ascii?Q?tBjGOa55xqermavgcMs9bkKPjQc0LSA9loe0p4xgrnNJhdCS4IWWb/iHL/hP?=
 =?us-ascii?Q?z+D23rj09UnJcA4g+o34QuSz7uIX3zQbz8lDDWz9DHUw8PjAzc9nl2ZC9J3I?=
 =?us-ascii?Q?IcW0IY2Ms+TnA0HgiHXMByH/TDD7PyVvpzHDEEg7pUyw6xnTES2cipk94n/n?=
 =?us-ascii?Q?YyvGEH3ImAh2Z9i2/HsJvhv1fQODkouAe0VIp2F5HVI4zQFth5eP4XlOZUW0?=
 =?us-ascii?Q?aa9QxkmePGZBNIe3iqs6kryqzyhwtQ/Pk+62mHHmB811PB1Yv1AN8qSM7XfP?=
 =?us-ascii?Q?vdxYfmWvUf/Z8mqDC4jchFDMhdvgsM4BHXSa7xYJxbsIKDVQKa7AQPRXDMwQ?=
 =?us-ascii?Q?29ujY1fjxN/yaJ0KDHHeckE5dyQeMLSG9MvOZCs2A4Atfw3vfftBV0VQoVcY?=
 =?us-ascii?Q?+GipTeZygo+yCwT8OWFDD9qUUd1wdzCqAVgMv5ux9KMiDqLESAZaLQqJgrTT?=
 =?us-ascii?Q?2jxrWQPfxC1/48q/K8yETO+WqsEYVawLySZoBg8k6WpSwMFOVxjOg8GwE6ZS?=
 =?us-ascii?Q?2+jM42uYeTNKSwFv+4c6yn563R1GKtXdTvMii9S1T79/Oc3nRliUwYYwKVLt?=
 =?us-ascii?Q?6hMHki2hE5o9TGZpwwiE2OtKKWzAELMF0pzl7cXT0L4ZlpsNCKlmoHm1ZYGQ?=
 =?us-ascii?Q?CLLmkmq4E6ABtyslMy+a6WqtJF1DjRjh6MZQIvP+0FIaTdamZlRhEvQbzGTI?=
 =?us-ascii?Q?LoRdxmwBwh4GEhf6o7kJQ4EKBSvV6Q5CflSDJaBBl8SOCs2vsIcZoQNxkH/g?=
 =?us-ascii?Q?WcDiDM3NxyJzj+PBfMLbQlQSWf4IymFPh5Az6Twsg3Vl7uf5L3UJxc3UNv4F?=
 =?us-ascii?Q?OZg5XytLaqRkRLGeSyv/jCInCeHvaYVvObEe5R093Jvp76iCofmIjANLhz2S?=
 =?us-ascii?Q?JQUuoKwHULRA1OND5WTkTLT1VTFZ+FuBZuUAmZHTGnnbrARIBHT5RUbzui/w?=
 =?us-ascii?Q?nVTvYb4fEXLE2vGSmwAoovo/xeGa88wSXuHB8PN/0CWspdNXcww+u1MrHPg5?=
 =?us-ascii?Q?0zmUBpCHC9XhOdkPSwPyAMMUuh8BW0Nb/w4CxaBzUBq1jCxGZVtISNA2KyBi?=
 =?us-ascii?Q?i/2cPSaCi7YZZ6tV2MVaYiKjsczJwu74ZXZmYV5MliM72NB+qb1S+/MZc1i3?=
 =?us-ascii?Q?aCCq88YshBjyu+ETxfl/8BpVZloMw4HRg3Hk8iuZLcrLrkFyJY61hj5o7LdP?=
 =?us-ascii?Q?lDDD6MklI+u2zlutcWsDLRaE8zuG3F1yeZSiJ+fcCtovbksaJ/4bSmN5gm4j?=
 =?us-ascii?Q?RJzu86/R9c5MiiSvVYrCR60NQDUHwr7gEPKXs4HHrwk6ZOY7fHhep9JdVsql?=
 =?us-ascii?Q?Oe6t8GXl7ZQnDLFgslyLLV55un+yIUFb38fOKRWoSiluo7+ulOxhoLiF9ETD?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cf6c13-b4a5-47a6-3fb5-08de12115f1c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 08:51:35.5362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcr77taVCRfOTpieU/iEqDz9/zxP7U/Tio4nF3Lu2CPOQQzeTLTMnpVC/rGqmmGXnIA22tEaBRL95sbxQkEbEtGFU1z3pv6h7fhYgnM7stg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6433
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Enable storing the U-Boot environment in a FAT filesystem for Agilex5.

This allows the board to read and write environment variables from the
first partition of the first device formatted with FAT, in addition to the
existing UBI-based environment configuration.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 configs/socfpga_agilex5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 9ca1910d53f..1068957c2c8 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -71,7 +71,9 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 CONFIG_OF_LIST=""
+CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_UBI=y
+CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_ENV_UBI_PART="root"
 CONFIG_ENV_UBI_VOLUME="env"
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-- 
2.43.7

