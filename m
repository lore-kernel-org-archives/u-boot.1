Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D1ACA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 04:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 222F6838C5;
	Thu, 14 Aug 2025 06:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="n+tfxrvn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A55F2837B6; Thu, 14 Aug 2025 05:18:13 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99AE783816
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 05:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPQKKjJxXbqIkHHcap+qZ5o9IV2Qzq9Mwvq1ilPDeqLnwtNfQrYQDg/+KN+156FFNLeDx4hewMv/AvY27vMJfGjuUaxgyieHW8bruwi8yUlV7uqSQLK7YugEHEvXUtzedl9Z2KCAgW9i8pRe8zL24CvPsp+hXt7vDN9xX7GSQjPmlFMfUZBuQtV5riSLZ0JWqCCZES+bqk66RO0R5qnJJ0uJ5OEQtu/hKyVXGemA/iv5w2g5BtlCN5lQ/XJNGRb08nv1gtOCM0zyHOygTlp+bo6mE4XKcNOCW3NSULpzQa02et4Y1fHNRIBoQ9gsMgwlGCf8Q+FH/fjQzFarXqmIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRewIh5T48O80VgjfNPHXGh+2YUtx2/16TXrN+x0hOo=;
 b=sOasDw8ITafHMVOTul3bl4nDx+w/8h3S1g4+Cx3cJlunng/dkSMWP3mGWt33hEXEf01vxvygBfN200HhpngijlXO7Dtqos3a7ID2GbU+xAZsQpykJFpaU6EOu6MnJWV+oJp/AKxn3Tpr8W5Y3Mmiblbhu1U/KviJpK3TRq0jWLwdS2iqglCeCku48vajkNiwVkyoRctiQ4kE+oOctE9O/l8wviBs1axjtYRHKkpC+phukD6rk8hRNZVWIIkTNZLASS0OW44cWsg4V27ebBMAk3gUgb/smAF/9j6IHoU50+rpqlDctGRBI4FP26qJAzePYfAP3Ix8mBpwN7R0Ca+cAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRewIh5T48O80VgjfNPHXGh+2YUtx2/16TXrN+x0hOo=;
 b=n+tfxrvn/llK+h/Qn6QlgFK9Kf+REp+vaDH8Y6lvlspGVCUP0dzWK7mYR43VHQP4dQxls/gqts1xfhQETyf2bsp1l9hPOO5CyonoAIlZIyfgGM7SEYoyQViCveMeoXjt+GkpD5h02XFx630rSFBFOJJkTeWI7uVcEasOAZH1mEAwwQgwzOxtvrR69PJ7c4+bEPIz770OgDRmUbxiquJ2ZDM8PYuUkDf59K1/lXH3fcF66xSOSArHpiF5e88HDBQxC9mSJEpQqLf8hpNUEMv9pSrcRfCQ7RCMHDy9ynBUnPZ22S6GN0S4HyouHrE5W9SSfEdHecjs9eqVl7XKcDnRyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SA0PR03MB5580.namprd03.prod.outlook.com (2603:10b6:806:b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 03:18:09 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%6]) with mapi id 15.20.9031.008; Thu, 14 Aug 2025
 03:18:09 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mahesh Rao <mahesh.rao@altera.com>
Subject: [PATCH v2 2/3] cache: Check dcache availability before calling cache
 functions
Date: Thu, 14 Aug 2025 11:17:40 +0800
Message-Id: <20250814031741.4887-3-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250814031741.4887-1-boon.khai.ng@altera.com>
References: <20250814031741.4887-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::17) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|SA0PR03MB5580:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f0a4cb-b1bb-4bc7-4833-08dddae131ad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BsFVwzyQ/kKqRcgAeUEd8BECd9VVu2tmpg6CBtEcRdVkjIUdfAHYGf6NOE2M?=
 =?us-ascii?Q?k0KCRdMsv7licMhlq27o90TIB+twem/W9QKK4vFhxYtOg2tx78xh30aAUE46?=
 =?us-ascii?Q?NqE/nOwdJHe6s4qoqmbv+LrXGTMHf4s99h3Ufj6n3lA+epOe81xWO1V91Cgu?=
 =?us-ascii?Q?GtckFUlYDcJVSK3UXoQCx/r1f8C9GAMye1QjF1o94YxxyXSyPrBdBVa78JaH?=
 =?us-ascii?Q?hhfDWbKQE461yYY6jR/D6qlb3/ZEXOgdn6OOH5Q3Gt8QTU+cbfRKruCrfnsI?=
 =?us-ascii?Q?gAWtBJDfi5pdj9+RVwgZva7lTcq+lQqCbTa4pFX9aDBZY7WtOcnDqXyy2x67?=
 =?us-ascii?Q?ucwHiRGCU3NyHvZxdniNy1pvtLulz4u2hVTIf002xtxPAb0BSGhm2UTqM4gm?=
 =?us-ascii?Q?XedCkKArGA5r/unE6PZ3+XCDTIN6+RhjbQiw72phVKVQa8L6EV+CrWsHZGlj?=
 =?us-ascii?Q?lPSs12j/OzmBMUBcYXUAOdBhVnZT8GDIdRhAiAx/BQqxl+crR1RoM92jdiPd?=
 =?us-ascii?Q?taIA8wG5aMI6535S0STpI88aqWmK8WYThTZtndAoRk1JvtxzB8PxcryIMX+/?=
 =?us-ascii?Q?mQsrhGHABBeR5RQnrD8sJ8SImNVoHfSsvFCcyXRK8ndKwLmjTDjgFt9rv6Yx?=
 =?us-ascii?Q?CBJtlrbZ3/JI90/8xte3evpmfLL5D8GGimxyKJ/CmIH7xxWfW9OKHEAcJ3fB?=
 =?us-ascii?Q?wQTcFM3YAiYvXeksjehZvDhgrH55S+10m388NHrnE9nbfeZ7JXAUGKRZxI8I?=
 =?us-ascii?Q?QP5wubZmaYUqW/SDtBmiApIKhrOIXUye3Pue5/Flhrtp8dlxinlQTD7TUte7?=
 =?us-ascii?Q?/WA7cFnO9Xm8A2h/mJE+bXrigtLKvstdGdEfu/h3n3BcTnG6mU95pJdPc4ZM?=
 =?us-ascii?Q?JwhwyzqWYJGvc2x7v3Eqo1JolHz8hHOblDnWZpYIG0D6GivKbfSQivNVs32x?=
 =?us-ascii?Q?0aEn4RrCserUbuN6XRv2Ygi/Qv0D87Pw9Az+KeD8jdkjUcqLqsLUEoImgDv4?=
 =?us-ascii?Q?OEtaK5U3wxYcugHC/+WffumTxrrXdcQ1WX7+eI8+cSFyLA1N63uQRNSr7Y8/?=
 =?us-ascii?Q?RUO3xB+uLhloa1ErINrRCTFhys5sk2KWUmXa5ll5t8bzap+R3kBPrKJWVJBY?=
 =?us-ascii?Q?h/5vCjiBxmV8jn8idiEM1crrt1XkFp8QI5PTvv25Wml7A42L7eNeLU8xm4Gr?=
 =?us-ascii?Q?6lF81s6lhLssMhJRwUI8XqUlIooY8bQJeLvKLeIpjgPLh/boOjAaajP9hwoL?=
 =?us-ascii?Q?ErAwCaZgmX14sVrxUSU2vP/B3+U/P+PFe+2atTYFTckvyNNcBsVVvTYQbeTy?=
 =?us-ascii?Q?E9uGnqxwCVdm5HsAbCyoKOXrQ3XnScipLY2n/CIOp8Y1cMrtax5xNrBnQq7d?=
 =?us-ascii?Q?K85EOhdpKncbMGOJitwwD0e26fMDX4k0MIMN/KbzW5h3NcKEUSTduao3IMzC?=
 =?us-ascii?Q?oSzN31+DxYw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p6P4wOm6BFnE1H0fL6A0r5B15RvfW0oCqGdf5pVaFZhriI5xoOsp5lA9WUQI?=
 =?us-ascii?Q?ixhOq98MUVI4suMJLmXyU3CYhxd/tIYIWapTb4WqHKTl4gebpGqwSGyUCXt/?=
 =?us-ascii?Q?eQl2BeMdkv45YR3zcraVeLiWxiQJsoFmQ65nEe9Jip+RSgcXJuVjyNZNr0Gx?=
 =?us-ascii?Q?DXfxtXh13AcNc7KjS1sSQrIYm+4AqikMzBAAvMMut9opTn51UeilDQXdUptC?=
 =?us-ascii?Q?OzoWHdrbdzF55Cx3Mm25qEUrGCL00LaUo0P4NGcxmA8lJQdJcGoGXaQug+w8?=
 =?us-ascii?Q?Cgt+51DQPJ66j0ylCiBB1kyNJ4bCBAY7PeVZYlfE05Hwfb1ko7ENsaKUpFqC?=
 =?us-ascii?Q?2F5HO3Q7y4DX9r0t+AHFb0mv60M7K7sD8Qo+nAE4uoYiDfqFNNyf3dX+WcGt?=
 =?us-ascii?Q?tVzjft3LltFYVGVNVLNiWuaeexAOq3DkyVFXiiqZdrXTvBuLfuSUzCdQgPNL?=
 =?us-ascii?Q?91ruFY/o5wKs3GesBRv79uh6MGtfBC9lXtsSnu3Eut9+Y5FosBa4XAdkT1AU?=
 =?us-ascii?Q?hJaNcoB1ZfNfLuHOj6HdSw4VxAHsQLwEUjMga+Y3do6tcCBcg6RJEsX8wjOX?=
 =?us-ascii?Q?gWOefYfx3It64T0eAIar8TLxUyVhZPI4Y2UVDRTaic9f5o75QE0yyaqkSSOw?=
 =?us-ascii?Q?zg7QMfhHExKSvsBIHM1TQgmcmutkP8gqdA6Q6++83hmYSlbpS6GrLOvx7X7Z?=
 =?us-ascii?Q?MtCe5zvwj+9u6WLbZDldaDM/GQgWvnJMgIXz4WyqMZehK3PCURlDymNpVL+z?=
 =?us-ascii?Q?LMjij1Wb/MZ7Qbd11Ty7CoZHhEhiFQmPRZcS0CtEVU0P4d9cSso7nujpFGgh?=
 =?us-ascii?Q?s2KDi3nX1dbvS7enyP29aiAFvBhxwCGuyjq16gXY7zHM+Ddcwe7kvVhLdw+C?=
 =?us-ascii?Q?aOdUN0kzHaQVDgYa4OfU3Zg2VsNdTRmhT1hB+uq5qeOLzJP6bf8PQSzAMOHv?=
 =?us-ascii?Q?v4Fle/C+u2op+7SZQXYc/BDBeXoDoHbSLFFQb2f+LJ4kkm9lKhL7Ky/FwEpt?=
 =?us-ascii?Q?70YiXZ5TQX/QRDWAALrjJQO6pOEpxwfKbA8mk6SMyJVMkH9xZgg0kGOlh/FF?=
 =?us-ascii?Q?NqWkqesFk6avvTyKZ2qnwFKmfscvrHGqz5oeGdJOHfUOu37rFYQ6BQDRvVDR?=
 =?us-ascii?Q?3cN8Nyw4yMi00Pd1JuyvGlEqJuSU/Kntp7oqczDPjcEaPH/qEHAeiX8ZiCwo?=
 =?us-ascii?Q?B8ejRdW9CASRdMjFQVk5kJgZeSDSk7EKYEb2iYvol218+cColO+rrZuVZs28?=
 =?us-ascii?Q?KFYXBtDhbitis/zy8a9wZ8lGGRxbzBlQVhnnmR4AgBaJybSWTorDsM2Cfp4W?=
 =?us-ascii?Q?jYs3s41KhTy2lCD7zWJYzCGD5sG6/YSLgfkQarrX51OUiLgIxdB8BpItl/Q0?=
 =?us-ascii?Q?l3Sp5c3JWCuQUwIT7LyaddxFhUQXHdGW59iuuZpvTm6jytKfCkiXvSFVFt/v?=
 =?us-ascii?Q?GDoStY8OnN6XP5jPGjX1IMOpERypd14h2xReNMyS0YRqSb8eKUtaQ9qIpGYQ?=
 =?us-ascii?Q?o0MneTL6UZ2k/yDPDCT+QzAOjNkzf7JLCWCb99g0OQixFVpTlG0DoRrDG73F?=
 =?us-ascii?Q?G0/fuApDX+au6kUrF0L8hEoQoUkr5mnl8uxnzm7Y?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f0a4cb-b1bb-4bc7-4833-08dddae131ad
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 03:18:09.5433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgr/GsrvzzMIbQDst3qws1detjwjt7y78PP9MUHq8q7Yd/d7QGFzE1IpwCLNojIEg4AOzJBHdKuJ4c4jCRbaxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5580
X-Mailman-Approved-At: Thu, 14 Aug 2025 06:34:12 +0200
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

When the data cache (dcache) is disabled, calling related
status functions can lead to compilation errors due to
undefined references.

Adding a !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) check before
invoking dcache_status() (used in common/memsize.c:get_ram_size())
and mmu_status() (from arch/arm/include/asm/io.h).

Without this check, builds with dcache disabled will fail to compile.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 arch/arm/include/asm/io.h | 28 ++++++++++++++++------------
 common/memsize.c          |  5 ++++-
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 85ec0e6937e..cebed7397d4 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -386,12 +386,14 @@ void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
 		count--;
 	}
 
-	if (mmu_status()) {
-		while (count >= 8) {
-			*(u64 *)to = __raw_readq(from);
-			from += 8;
-			to += 8;
-			count -= 8;
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
+		if (mmu_status()) {
+			while (count >= 8) {
+				*(u64 *)to = __raw_readq(from);
+				from += 8;
+				to += 8;
+				count -= 8;
+			}
 		}
 	}
 
@@ -416,12 +418,14 @@ void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
 		count--;
 	}
 
-	if (mmu_status()) {
-		while (count >= 8) {
-			__raw_writeq(*(u64 *)from, to);
-			from += 8;
-			to += 8;
-			count -= 8;
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
+		if (mmu_status()) {
+			while (count >= 8) {
+				__raw_writeq(*(u64 *)from, to);
+				from += 8;
+				to += 8;
+				count -= 8;
+			}
 		}
 	}
 
diff --git a/common/memsize.c b/common/memsize.c
index 86109579c95..3c3ae6f1eba 100644
--- a/common/memsize.c
+++ b/common/memsize.c
@@ -52,7 +52,10 @@ long get_ram_size(long *base, long maxsize)
 	long           val;
 	long           size;
 	int            i = 0;
-	int            dcache_en = dcache_status();
+	int            dcache_en = 0;
+
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		dcache_en = dcache_status();
 
 	for (cnt = (maxsize / sizeof(long)) >> 1; cnt > 0; cnt >>= 1) {
 		addr = base + cnt;	/* pointer arith! */
-- 
2.35.3

