Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D296FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 05:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 855A8846EA;
	Wed, 29 Apr 2026 07:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vxSrUOJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CE1D846CB; Wed, 29 Apr 2026 07:12:14 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FF8E846D7
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPntxlCWBqzW4B+Y+brInwMydz76hQ7J3za6WCZrltLZQhGVUxdjNvGXmGJ/qD+k5hwGU5oXvbQ2XAXnlSzoFDtvgoP2WbgYB2LobdTJwE17yUn/ddDPAblYwOi0XrV029Yg4nkaY4KC0Nf7WpExaVgtsuvElyx8zOlxMR//6SpDFl68SK/1+cA4wwhjmZEI5mxHKiEjZ/o8/D6BmBuoB50gRgNc8C6KgmtpDPYhCiraJl46Vge3UEYPy4o0L5G2y50MwwZfTAygpkmstmDhYs1A9waNVk+eRvISvSioSPTHrnbbK6OPsdSMHgwCH6bBmzKScvrLrmj2ydwkhR7Fiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7oE/+qr4lgbEkGZmDn+ned3nzFQ+5zasc/BYmtUyHw=;
 b=elF1joYINE+FDqW2RMnZtwIMGuNdmrpjyujWri/mOieazWlHFzc2FtV32yU3Rdtc+4xBCMdg4bj3CalKQByg+7ndhn0vzviLwTOzNr/HCXPOcf3Po2x2+oghd8CY/yKGDtzgHtrjAZmb5eHnnA3v3PdIW/vcHQw+6z5Mw2N8V5Ulo5hRfR2S8j/pg6katx3SUP7tmtD/dqjqe31ABELM0LNBsYNZlyJw50uoaJGYJ91eXSGUCd0sjS5ttYZTKVGkFLquSL+KtmObDjNhC0jcId0fB9LO4hx8A4qFIDurKLsYrfjNflVaVTpPDwRLOBL122A/hbohFnysACfORDFvXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7oE/+qr4lgbEkGZmDn+ned3nzFQ+5zasc/BYmtUyHw=;
 b=vxSrUOJr9+xco1dppNztSgz2nY0yKZZlqSqHzhkZOeWCREe7//e/RXmiXS2xvLMwaKWckTSmX+hJMWv8vK71U1s0M4kHj0gTSO9hUvKHZuF9WSL5ID+chNTUJf+oTY9814i+t3SfZXrZ2FQnA8tkw9fQqs8t/nKyXxHRMdNjrVjDMGMzk4CWkAbsgHUQigjc5/L7FXMwRfhI1Xh7m+gdDEbYrcPslNqEMAllYW71+3WSPObLYyAt+BoiFdr4cOxvqKR6Pf+w6cae/S5nKYnBNXr7VSlA//SVPyBrNdUG4vKw23LCCTPDRMixVWNlwmZ2FQIl6zsdE3X9fNkez22mLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM6PR03MB5259.namprd03.prod.outlook.com (2603:10b6:5:245::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 05:12:10 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 05:12:09 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Heiko Schocher <hs@nabladev.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peng Fan <peng.fan@nxp.com>,
 Wojciech Szamocki <wojciech.szamocki@nokia.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
Subject: [PATCH 1/3] arm: dts: a10: Correct i2c scl falling time
Date: Wed, 29 Apr 2026 13:11:16 +0800
Message-ID: <11ad4489fcd6747099ee82feac2e4613df26192c.1777439293.git.dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1777439293.git.dinesh.maniyam@altera.com>
References: <cover.1777439293.git.dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:a03:331::9) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DM6PR03MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a54a22c-8144-4bd2-e5dd-08dea5addd34
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: rJ6DrmgeBLXgFLdONRlCmavyhMMabyVmwAE3S6XLnl2A0N4TzYPBkNsCXmchvCm6MySO/r5hA6/Ov9POoYtBhXbSRAfo/yTsFUN2uy7OUxFB3DNs3/nTDBKcdAi4ZQXuiEAN4dkrtaH6DTY5NAMbMo70NKX3aPnAuW/H5es84k2M17R4tfslZ2L1N7ja7OYW+ukgPlU4pU5UgUb34bnQkXe2izZ2Nw9UWY1H8AITBMjA1za/nV2BmyFgWZwT0+UJO2Qbe+DexcEB8hjd6C8ALcxnPuPOngTW61rDZG6U0dK8OvT3idWC25xC9lV8cwgihpxda1TXnxumopd9Ue2lmR0KBpOVwW+fFkXx+d+UTUsxo9JKlLCarYpRNuz7aKClQJ3Cz+9pW+bkyuwm0X5EBpbpzWrq4Ld3sKAAU2bMJGn7i9VPn2kHQLLpRWdzvBai4XfKH5HA/7OCI7eW2PeuyI8FqXvZkjQ3y8tZWNzRpyFbf7F+GEC+G2n6Xm4np4bBY06mp5qN14EpS/VVbwkZjm3VAjtfCdTZUYAvaYTewy61/R/zsN/WwyIMgWW46GeJxuwaUkdJvVQDzk2bt8QO1oE4Dr6p86KQKN6zjfN7fVRP599WA7QUiECe4KgywqLRrJ11gKeLohpl7W0K8S+N0q4n5m+BAMPlf1fwiWWv83vZNhmmx0i13wDnh7fXB7bqZcnE0W+EnbscfUH7NqqXD76NAqtthid0MA/7TqwEBpU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r782P3HPs3hd7DvQ0l+xtEpnO6XES3UQ4ZaEsyWnkp9ze8GJGdHS1rV7PWrP?=
 =?us-ascii?Q?S0tV//cgfZ4sgWg5NZ+RWrlXZpYBkRyQrdA4M4rqCGu30NZu4BpKxtv7Wl+o?=
 =?us-ascii?Q?aDfEHBTaydmDsz6ndzeu3rtqQbxZSKiOa+SONNWmh+Ip2dByd0niMnn6GQRb?=
 =?us-ascii?Q?fTNgLsAEbedfmYhw3Pc1gwffvrhE8USRzZgAMPvoydP9e2etkePCYBK9wR11?=
 =?us-ascii?Q?3eIqt3TxK1mB3izsgA2pB4yVlt9PnClOywjjaOEvDSwD7EgDjXtQimVKoAbD?=
 =?us-ascii?Q?iMbTHo+SUdgyDAt+hby49V32r5Gyy/pyS3XFp6Heu8MhirCpiN8z1FiCTgiz?=
 =?us-ascii?Q?xP5t4Reebp6DmVdijNb/PqJsGlPgAeIjuc8RQnD2seXS5CRx0sDTnW6wOLXm?=
 =?us-ascii?Q?xGNu29imhMyJFlOpegGD7yVjRkGEFNtpfCTMBICF5+pIqDX09tjCQz9+33Mo?=
 =?us-ascii?Q?mbxiO0wMnK6ZQpdVwd4YzJARrH//sZX3fSCi+Wqzr5KQYAqipYk85IKkblrH?=
 =?us-ascii?Q?jboln3jAlbY6rI1/CHNiKme06UZwPunBzEjoR/Dh0cg3uC1PStDg9dgRtW++?=
 =?us-ascii?Q?4GMAJ2LvIM968xRmhoeY6vJ3izQcVU0tW4y1vBbEUTnTw+DluZ2jO2O1tkR5?=
 =?us-ascii?Q?FJNr8CblUARDM1wgAQ6FaZOguh2RckXwSPyQwlXJ0xuADyJKd3g71rOpL9ZL?=
 =?us-ascii?Q?Uem0uTrAmGhDYV5Uzd2Nbog9/qNmxYTM2F6ME1SqAgxU8ZvwADDhV0hlRsHK?=
 =?us-ascii?Q?7iFddM0/CWP0qT8f8VxrUcJ7ZZp0SSE46jMVmLt0tVtWN3+0SjWpSzrwC6ML?=
 =?us-ascii?Q?GzKpVEgIxUwU5di8gWkyDbfrhOrOtp9nd7j2Y5bQE04I/hs+0UDFLHg2IjD4?=
 =?us-ascii?Q?0q2UZSJP2Wc3T91K8xeXL1moZ5ZrnJDcEzJIG2jMrcfz6U3PgmOijFNEI+x4?=
 =?us-ascii?Q?hLiGKq1klg6Ka4FchMvoZbpg/NIdjkaCfI2kHJIkYZrd2I+9Fp5d37eHujdJ?=
 =?us-ascii?Q?fDu4lEAZcp49v0ugqQk9YwHIDKB+IqqhpW3jDQczVQ6+pIu7mh6CKXTVrbnz?=
 =?us-ascii?Q?I0MVhLiOAdPRIB/SEZ7/cnNV0po9RqcDFrHsOygewxGwA6/znHSc4ZNaVnUH?=
 =?us-ascii?Q?K9H47pEB5rrOkm3UCI5rVglIqwCeNiWWusMmHrA9cHMT0WHKrk77oxSRrCWB?=
 =?us-ascii?Q?OoS/xbhJeYux4YSb4o61KQEVeixbTVQDUN8Wur3GmVzUxfo3ZhiEitOF1dUm?=
 =?us-ascii?Q?HFKzxeFCsUg2OsQ6Nv7/M6nKItH5YdXh5thhdv+Dsg0+LRaWnIpQIzxvew+/?=
 =?us-ascii?Q?7Hpb+JOHuorK4ZLRIE2msrnPp5rOt5NMkZ/ZxciJeOKi6TU/sEg0u3TBDOAc?=
 =?us-ascii?Q?ZrwXS2pCDNKw5CNQhU0I0gY98FJjMkgiyLNAuQynp9xTDuNLgJxhTM2BBR+V?=
 =?us-ascii?Q?+rfrCux00TLm4dlugnQC5qNz8U6xwSq+tojBkyXwD9dPq5TmRIemkZq1q22d?=
 =?us-ascii?Q?AdDyjA0N7eKbMwESXa4yubSKwQStHL3bpEPEIqZZmHa+kmUsfstrwzFLf7G0?=
 =?us-ascii?Q?fMWeFIdDb9MXu3MIKEviD6gvnac/YmYTJM5zxX3OuiK7qZUNddQt4y5kpM/a?=
 =?us-ascii?Q?f8wa9cSpkAIhfRH0Z9YxZhTk6RzaPDczbUGMyFG02HCkjim9ownub0U4fQ/Q?=
 =?us-ascii?Q?9IF2GG6cMhtVrok3t5yfleDOUxGhoBqu9MPHxxa15BnbvRaFW3wS17ZLEx7A?=
 =?us-ascii?Q?Lg252xOjrW11YuXraT5xQCIbSsSOVgY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a54a22c-8144-4bd2-e5dd-08dea5addd34
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 05:12:09.7120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVzNX3JTapATSNO+YFJqly5eHTBAzcHlclCbHt2sro3rkA7jEshypoyaWqx/N2FdfQCJEY9p/uX7rg/OgIjU9geHHT+bJAlBkRqayw9KcZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5259
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

The value set for i2c-scl-falling-time-ns in Linux DTS is not
compatible for the i2c driver in U-Boot. The value is updated
to the max value specified in the HW spec.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/dts/socfpga_arria10_socdk-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/socfpga_arria10_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_arria10_socdk-u-boot.dtsi
index 56d50ecee30..4857939ce1a 100644
--- a/arch/arm/dts/socfpga_arria10_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_arria10_socdk-u-boot.dtsi
@@ -12,6 +12,11 @@
 	};
 };
 
+&i2c1 {
+	/* Max value set according to HW spec */
+	i2c-scl-falling-time-ns = <300>;
+};
+
 &uart1 {
 	bootph-all;
 };
-- 
2.43.7

