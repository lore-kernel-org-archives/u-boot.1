Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45E2C4167B
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 08:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FFD78078B;
	Tue, 12 Dec 2023 09:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="PGCm+3Wl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 903B9877E0; Tue, 12 Dec 2023 09:53:13 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B557877CC
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 09:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOwOlw5J0yB5hsmTf/Ul10tuqi7QqwwhclRyHu/9ICzOcYFWfyv/GYwWwqEnk0Aa8J5QCktuHV61qQP3aJhC9QDzvCv9KC9QrcoQ8SzkjpwvRMmEobdRPXWFtVKXVXNtOgIufWmVsOrKLoHxuAwHsupnL8JigC0cjwPuJ6tSnNz8ThxMmkzZ6+vMYlZkD2h4WK8TFNNkGmhqOtXaRzigj7KlU9M5b8CPYCV4wJA5w6ZpxjuMQTFMKjfcVmgx/+V4eJdeIT6d8zQr1qFT+y0JdXVihFbivT0CJl+grSajUwrkJIfMivaZ2fkvmxPuOzo4W2lc0039KJiRkqM6OEkh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n07+P3mwqVnl0WW4bgxwPNDemca/fFO3Junda8XW1mE=;
 b=oIAkrUkWEve+B5ezDsIYrdeaWTrEJ7QCh6IVIiKRkjHYmlylQJrrXnnWtt5Ks8WL5b2Ogt9do0pkQ9yG81CIrMfSnkUT/WiaJ4d6SGklM1Mvke+XKr+2LvRZlNo1biOv1beyCHRmDpW59QNSP9zJbL0KDWZDzEoFjZ0RLaU8zvgyHb6CHx/OZ6Df0RQEA/Dp+Q2tK7MysiQmgmCa4DOdzzrjgoW9LlvRy6RN2C8/Y5kwWe5xj/niqsT0P6Q/9bexL9yLetQZa8U5uNspJUtKTCuFIxJk1X2CTvFX5c+Wk+qMLH/Ee8dk/x0zNHD1DYGbwPZWz2BO+T5YTjAQT4EOnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n07+P3mwqVnl0WW4bgxwPNDemca/fFO3Junda8XW1mE=;
 b=PGCm+3Wlulzr7g/0+hZ0qYnA+NRxd1BAnkXHp70DxbrF+qm+qg9Do+50m7NquWXEfMKT43k6IWNi7980L0mctE/KSqAnXneve9bvQxXbhQhDjB92CMM+BrcVsjEKxT24w4N9K+oee9xm5CMvSgYENdWBs+iL0uj/Q/OXxAu6PMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM9PR08MB5940.eurprd08.prod.outlook.com (2603:10a6:20b:281::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 08:53:08 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7025.022; Tue, 12 Dec 2023
 08:53:08 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>
Subject: [PATCH v2 2/6] linux: bitmap.h: add 'for_each_set_bitrange' iteration
 macro
Date: Tue, 12 Dec 2023 09:52:32 +0100
Message-Id: <20231212085236.2730768-3-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
References: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::6) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM9PR08MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a88a22-1be7-418e-9997-08dbfaefc357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVSy1S6CSQ3oT4kv5JTgkHA1BZ24RloVR5DUq+LpEZNAFWb+/pB6LDZ6JpNm0M9X+7dqIYDWZd2GFKm7oGM91GMNBJtEdLZM6wsfQHu3wLCn/Z5Fmcr5kGdysa4RevZpgDtT51ZQfr8RvSUO/Tz3K+oM+h7B65naID8QsUVGR+Y3CtdddMHZwRx522X9VzONfURSnbxqQl/P5e+QcfoVmOAc4RM8yDV34jY0bbOPn1TfcKSPVW3bLKagwZvfFCFKEi73hqbo+38HhETg1JLSpxBdObZbCFpt0rwr36n2XQTaq6kxAF34E/5yrHZojp+JBO9vyD9stAmeKe5EqCgwi0UyF20avUxLVFup8Lj2dxlwpTGIIEIysiNBuskJisCtnarJN1E5otZMa/LgfccgcUj2h0gF+3jB7orXYfBDnUdKFzW6yYf3Va0GFcJDz3ixApBiviElXdG+jwfuRDU3KZtAVl+OSnURdDOJ4+32N2CBEbgoa5JDZYtC4LAtdap6lpS20WxjV2vYVDfGoonoSA7A8Pf/PHvQGC4lhUz56P3tafAAc3sA66TkZbzCRSUkWqPWWZ01x959FpDB8v4Aze4gxOhne0wZVPK1me/WrquaiwwKcERCCLkYAdmMatRT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(107886003)(83380400001)(52116002)(6506007)(6512007)(2616005)(1076003)(9686003)(5660300002)(4326008)(8676002)(41300700001)(6486002)(2906002)(6666004)(8936002)(316002)(478600001)(6916009)(66476007)(66556008)(66946007)(38100700002)(36756003)(86362001)(54906003)(38350700005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QM50hDcADeLo/zgSY1H34HjzB6wn3aGIxCE29GD/7a7Ofnt10DFm/EPxnXKH?=
 =?us-ascii?Q?MpbahnaZ+mhA3NOcpNYjfL5zV7iLjA57ItEPLI+r7lU6qPs05GNOI8YOzMGx?=
 =?us-ascii?Q?Ep8HRNtuEAQ064VLWLNMZ4zzZg1oHizhcrt4WLQhUz47touVY7F9V7FbgyC2?=
 =?us-ascii?Q?1XowNVLHzhRK/dHYGiXwCYBkqbVPtEY5TeBRnxu4KRZ6v3Lp/otFoVJS+gdM?=
 =?us-ascii?Q?cuHnvbY7wRnlS80k0jdTHQNZRQW3uEmnedYQGJ56QBTT5AwDJAzO80iJl7QS?=
 =?us-ascii?Q?RCuoL1QaBozFLRSO7XyX/Ab1f0seg5W+lbx7NNvV+L01+1XfzzgNR66KglhF?=
 =?us-ascii?Q?K+twXBXbh8yJ04gN9auzOECqkODiAVH8DhhDFtQmuQl2zZGZHkBD+GUvzWK0?=
 =?us-ascii?Q?UyHxj7HUO7CHWk9C4yTlOBVEkg0iFdRid18ijfCfp/+VaLkN3HwBM+dCaNnh?=
 =?us-ascii?Q?Y1OvKewslmAX2xPAKIMS0fytcheYVcUTY9ZFwSP8kZJfcjFwGHuHImdw/3EJ?=
 =?us-ascii?Q?apVjKHXB88NpFoMVdONybanTLsUMJT5DkKrdYWCwmG+9WfB7B8LAyAb5TbCg?=
 =?us-ascii?Q?fK+N+3hNUSfRrsjA7tO9qUmTLFSqgpR0kKRE3Yooa18BI7ZxpuDUwt2R+gzf?=
 =?us-ascii?Q?O/JNo91tnSYRXEhv2iNWguUsCvqlF0AEgIFLVtBrR7/bvCcQnTLUVYJshacx?=
 =?us-ascii?Q?iSY0AFLJdFmT9FVRcOzFHWgZF7KT/2LPKNRUIpuF3u9eHrv6zh/ArvnOApOp?=
 =?us-ascii?Q?YJuv7W1fyZ1M2sXpG5iMiYAIeQaRr4/8mq95XK3ceuNsyGAi1k4ij0j5b/m3?=
 =?us-ascii?Q?11dr+T0QnrVu16snwV6YpjdulruTnhf/8HnZJZxLJ57Ka6rbuo8yZbs1LayJ?=
 =?us-ascii?Q?mhiccKy8XphWk++PQmUNLn/qlYxAjWMsVLeWN78zXMxSgqzpxd9rOmUd7B8g?=
 =?us-ascii?Q?hJpuo7xbhpE2T6ToXN3k5iieYggFY4llTaSldL1aELolEy2g376VcsE2/j2c?=
 =?us-ascii?Q?OUAIVayRV0LRN8R/yvV8ghkRENRbvjMBl6OWujnWJ/b7nCPNadtOFQuIywUh?=
 =?us-ascii?Q?0DIfCNRoVd0HCKfxAIRh5n7zkUyVUaGBhiF1FI4Hecwe1TEUhxCzi4Xu/zad?=
 =?us-ascii?Q?x1bFdR5dayJy+RZDLraCQlFfvP/zxmRYwd+hNPCoRMxQJmZ5W39zYPB3VILc?=
 =?us-ascii?Q?cQ8UvYmgVG9SXEIeYo7qA5fcEvOGX0ffA9p2A7XDDT9/NaUHwpDXFHISPo3/?=
 =?us-ascii?Q?32vtkwGxAoOEHTi+A3YRTIK+HiOdAO0HXLHy1U0HKhkBbSbyTQ0koQHGL8zO?=
 =?us-ascii?Q?k/A5Nt30fGL4vY6IQaap49iuW7ZDaqZAS6ncKh/++T77If1XyxHfEfs1VJS7?=
 =?us-ascii?Q?ElCxqwcJNI5m5SDMJmezEutGXxIwe+y/9Z6hR0tGwhXh6dYFp3tJ8wxQCQlf?=
 =?us-ascii?Q?RrVWyG4wt0xMD6mtKGmFa6+xp1xv2kjO8RdZoenAmWrkKW1sJV3RaTz/bWjG?=
 =?us-ascii?Q?u13rDEyUD/6PbNYyTMZZ/oi+IQEJltiu3Oq2GzzUfxJgmC84HHLX07sWQm15?=
 =?us-ascii?Q?2xannBbdha94ssa21G6jtY+Co18mJWnQp4bKTjtuZA6TRhOtz1TyhF/9YiGG?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a88a22-1be7-418e-9997-08dbfaefc357
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:53:08.5581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bJRLoPvcdeyu2uXOje5P6VadWx14tgJqt2a+EODi8XVsur4eO5lsmnPn8m2MX583SaL+vGvpqd1Z+M3c0VHQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5940
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Add 'for_each_set_bitrange' (from Linux kernel) in order to iterate
over each set bitrange of a bitmap. This becomes handy if one wants
to generate a cpu list i.e. for isolcpu or nohz_full.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 include/linux/bitmap.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 0a8503af9f..9714533078 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -159,6 +159,13 @@ static inline unsigned long find_first_bit(const unsigned long *addr, unsigned l
 	     (bit) < (size);					\
 	     (bit) = find_next_bit((addr), (size), (bit) + 1))
 
+#define for_each_set_bitrange(b, e, addr, size)			\
+	for ((b) = 0;						\
+	     (b) = find_next_bit((addr), (size), b),		\
+	     (e) = find_next_zero_bit((addr), (size), (b) + 1),	\
+	     (b) < (size);					\
+	     (b) = (e) + 1)
+
 static inline unsigned long
 bitmap_find_next_zero_area(unsigned long *map,
 			   unsigned long size,
-- 
2.30.2

