Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04C6CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 04:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4FAF8389A;
	Thu, 14 Aug 2025 06:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="bA+HCJLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77AE283816; Thu, 14 Aug 2025 05:18:08 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FE6A8382F
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 05:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmplponrFTtpgcM0jSB2FeZWPLjiyuaBZp3DwkU8sY9dbclH9+pOusP+ACgjJUs6vdkkFfI974d4LjbQMyG3QE7Qz+aEs4Bi4QgvNAk5Tn9OfIP+ltfSEitSVn282yThJzuYn3GuYYIevCNqcc5/qJerjgnJCM8YJRdU62rpOJgfrkpSa62rBS+suqCNuj8xcQ9vRW/C/eM18EJ3KKgKgHsJAuLYOabBfcWEgOk2GDqLsuwQQga5co1iQ8My+4d6Dx6hp5ky61NVkEb9G5YzcRK/0RBxecZ/dcuQQYoFsk8FJajmUNsbz+JXqGqUberZ6qP8V3JP33NPpA/SAhbYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPv1iX8m3cMdkpAjzGGbXqSdj1OONLXuhPb9m6MZSJU=;
 b=nc+1KvLjCp29mk0Wt5EXAinmX400D2qq+3Jg4LoPjqPV8nSO22FgL2M9hMtRKlnHjELe3DxQZwNecS44+9KLWpopfFXMnxtPqxYm6rOuqVcSop48xKM4grgaL8mPMiUB5rRhQ91KDDmAb214tEkLCiqgD4Kyu1UD1tRFUV61dimtr3w8U5VQMxKLVUTjkmcQmp+LSyPZsW15BFA1IwE4SYAYFZs0o/kOm6Pyrd667YymOjf28jkP77utjd55ulTrUwvBtmGQhkpyRba3b+ga2BNTDeYhYFeAKGUydDXY0ypF4xQINtrILri71bbbj9LeFIFsSwplqU9YxumfnMDmsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPv1iX8m3cMdkpAjzGGbXqSdj1OONLXuhPb9m6MZSJU=;
 b=bA+HCJLTmU9sL9/7cJOIf/vyxDGMZM1vyenkTpLtnWZYLpxN9ugyDQ1jlFjJiV6oMwBjZARYyvclxccQoUvRrEyTrKpb7qdt0WDj6KsFebMlqBf87dp+HAODnNu7TyeI3jBmhiEk6mxC01qHy4fwaR+ml1dyh9HcGgWPX093kCqLQeu8iu3aB0lTORnkLC1UaRG98VjPHJpzRYk7mrQzo4veQ3HZUokF5S7lMOr0mQdCcUlX9jozWq25jUOzpvp/LlvvZAKUcFQkoBMXxoYWaKGVwJEcGRDwmKK/0/JfsZ9FM47TSJZCk5kZHDvCDmsrfanVW2JCDT6j2djx+pgOag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SA0PR03MB5580.namprd03.prod.outlook.com (2603:10b6:806:b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 03:18:04 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%6]) with mapi id 15.20.9031.008; Thu, 14 Aug 2025
 03:18:04 +0000
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
Subject: [PATCH v2 1/3] arch: arm: mach-socfpga: smc: Add dcache flushing and
 invalidation in smc_send_mailbox()
Date: Thu, 14 Aug 2025 11:17:39 +0800
Message-Id: <20250814031741.4887-2-boon.khai.ng@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8b6d5e01-b0c7-44b9-d2d3-08dddae12e55
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bypJKIAHMQK6vQWMlaKLYIh+uZKKkhR/L/pAPL2fHO3lzv7O/ltDk7U0gha/?=
 =?us-ascii?Q?tSCgV0054DBRJvAfanzPYkg4lh3RhGdhkiHQdT95IdDCGokPEhvDklFaUCHV?=
 =?us-ascii?Q?NV7UrEx9gPG10Fr4wgMw6TR/aU9botcImqqmfAi+Qe+1zUxjIMQ9y467eqoy?=
 =?us-ascii?Q?L9x/yrBRa59fASDwlQmatevtJOfnLf+awYu9i83uc28vefeSDzk47pUQn9c2?=
 =?us-ascii?Q?u/v76zkL2CsIRL+CqzLBokH7H/GElsQSmzUFrD1FYrImX1ntguBmMpxRgsyu?=
 =?us-ascii?Q?nvd5NGvHJ7lZXC/eY7xeJs07gg/UsCi3pBvao3G+aVluIK5gODRBTdBcTI1Q?=
 =?us-ascii?Q?5x3ueAZN89QgcjGKp4XY5O3yyNAfgdM7gOqKmS+Xfxs948Bi4XWpQO4r/eUW?=
 =?us-ascii?Q?iQcPKo0J+8hj6/zb3/i4+XwJMVOfdzuk8vg0kHHMmAoHv5nh+zyISncfDDCi?=
 =?us-ascii?Q?aj0s3YKG0WDnvKTT1y4/pDmPrcwbLJRiBNP/sxN7mVFXJyLOigdizpXYEjvk?=
 =?us-ascii?Q?KNlDhrqLSxNLDEcKd3IOYmwYFlf/YlWwJOhhAxSjOGOl3LrAQ48wp4hoG/bU?=
 =?us-ascii?Q?Ix6wD6PmSnp6irlA1KCZQwYfXTu265QcjGRjk+zMa2sDAl3coQY5/VC7mU/P?=
 =?us-ascii?Q?VIhy1M8PY022mWkEIePzxzOLUo0uAHWpjULoyAsMI6i5niPRtTfQ1JsP+W3a?=
 =?us-ascii?Q?V/YtIhZqrWnJQ4THshG43WG8EhvwGgBpipUOEBz8pumL4p9bn3/JYPBnb7TR?=
 =?us-ascii?Q?5nRjFSxeQPPOgW655uoC84CxhJTEaNGrFi3PN4bO5Wu44JMJ8QMmoF8a+8Si?=
 =?us-ascii?Q?Wf9KIt8eUQm74Tkh39TFxFDwbV1UhfuWPNHpEa1YjFXg26at1v0itJ+60GuV?=
 =?us-ascii?Q?Hf3cewGEfiO2m+44m5IfyHap1uCDqmTSFGuUynzswVf3tfyLg7zm8p3YEIUf?=
 =?us-ascii?Q?Spa4UD9If+ac/8DrbAIcZq8j0X/ByDTznzA9+XjFV54pLedyIIzeFezLqLhA?=
 =?us-ascii?Q?ueuEX4tzAetmPXtKKa68YEcqwFtRWy8Pq4RjlAuIyI+OVUTb8BgTnDqgUtjy?=
 =?us-ascii?Q?g8r7aS5ukIzn6yxmm66NGZLkddjECS0yknDC+xAsgUZxRjblV7I2IlpsWE7p?=
 =?us-ascii?Q?f6m39rKPWj5iQDiuqIPm4j0DK5i8yG3krG9u0wvmdu+Dj3x0DBycb6bToYDh?=
 =?us-ascii?Q?rVg88rF5Z6qJchOKCKQSXjJx3+QGMCFKaoAN/6j/9mrVf7TeduqXq8aDI4eY?=
 =?us-ascii?Q?EBMQCvvvMKusL0d8CE9JbS7YeeDLnYTlzAfPRzp2adcoNK1PJ2Vg1YOvk2ZM?=
 =?us-ascii?Q?+SBDDoeTSVSIgzcxVbkVCQIjd29XoK0FLfkvCfl3+Svgbm7isXs/iUQGOtA7?=
 =?us-ascii?Q?mMvqwSH7phIFfZ1PJCMn9IlSSeBShRqiBJxiBwKJzp5f26GcCENybi80ylg6?=
 =?us-ascii?Q?RC1xnTObb1Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PvVCVCi00eHJ141D/r6MQpraUhqktl+XwylxyduFfx2Bwo17ppstlNPiIkZn?=
 =?us-ascii?Q?Fitm/7e4wMzRLdRzh3dMuFBxwJtsvPcQq3rAFX7b9i3MHu+Cil+QE6MD82pD?=
 =?us-ascii?Q?ejDChaFcqkqUmv78r7SOBLwfJTRPGutK9ghZdfTyw0rBELLNgZxHwMQPhH8D?=
 =?us-ascii?Q?dpqZnp/fzuzju35uhg4pKQ5yKwHAEuTESaAn3BLi5BuYRrL10fjEoE0yOUb2?=
 =?us-ascii?Q?MyGacR/f2YDtNHCE9zm5fdZt8rk76c6G9W5Ua4hWq4ytk6jFkKyL1b2ywKBK?=
 =?us-ascii?Q?tvzuZoj+SsFFPUZqKtIzNCOcOGxuG/E8nu2RAOB8phq7b780iEPhoOc2kDG8?=
 =?us-ascii?Q?lecqiebMj5NtaEeDYjSve5XQCgz8IUB+IftVntIivvv9FLm7v03zUmnPPlAx?=
 =?us-ascii?Q?XWa1udP+WVADk6lSCpNBWf8oh+C3ByioyJoteEIjaYOHVN57NaVrfJF09JWR?=
 =?us-ascii?Q?GenZn3PyLOZg+T7nrN2FrA939CTchc4j4cdkTiDmKtmUmAuPyzgP+/sULYZe?=
 =?us-ascii?Q?Le8TmG4QaBKI6uYyKiIDbOmUNkWLXgPBZlLxrzlVfs5Hw/GiTKOXEudNCWnP?=
 =?us-ascii?Q?V+wztMPpbUSl+awTlS3EpX46X3u1gmdk+9j/fnmWV0A/1cCuuSTJwHaBvyrD?=
 =?us-ascii?Q?KsOpxt3TEKLygVsKbNxKZ5XGLr4IHVkVuK0IGygYA0amD/pSuUPSyLIanMWJ?=
 =?us-ascii?Q?ol+aJVZW3Tkdf6OCenKRlis1yOOIcwsahhp8bZoMOl4mLt+mKbE7fHuuo0Lc?=
 =?us-ascii?Q?d8rY/ef6WGRbYqmrIyyGUpT7dyYR7zYik+BU6RctztnyPHH52rJTukSYBJoD?=
 =?us-ascii?Q?1Gk88nOqLSoVPjMzfEZwaaPh+J+u78awHtPmL/aKciAPDD2pVf9aXxTsXB+2?=
 =?us-ascii?Q?A3gwsNi+qcSy49rrloYGZY9vdD6Ccu9K+SKiU440hAGTG5S0N1+mkJVwneAA?=
 =?us-ascii?Q?UDbZxAmhSewNOmySpJWEwEgWQkKQnzvRNpIP+7FPfEL2cpDhw7u7TZ3I2vDO?=
 =?us-ascii?Q?oLbzjD9135W/wKB/XuBrZzA4Tt39F2Akc+GdmCGo0mJh3GaLUy71SCDnO9FP?=
 =?us-ascii?Q?zlxGfu5CahstLQ/IfkUpfcmK1UhO3rcKIUUu+q10PLuJWAnyTu9ZfG/GI0rN?=
 =?us-ascii?Q?Ql1IEoRHckkcQX4NVU93EQ9m3QXE9tZt9PXb4MUJJxAYMVK358iZ4DPrtWQu?=
 =?us-ascii?Q?42q+ZDS/NoV2nnQble8ZDGVzgFMTZJrq7MOmCblmhTpyoONk5UzU9MKkI1+f?=
 =?us-ascii?Q?A/7PvnonQ57TAMuyoLPXwOVWgvOXKWJSuwCZqtRT0jXFZkA+dwxBmilBLTYR?=
 =?us-ascii?Q?O+b6Wz2gCVEeuqYC9B/OcGDgy2SQcdflP4wDIjIJcxGDwc9/ZrpLh+aYD+Ak?=
 =?us-ascii?Q?IE7f+c8PiA2qfDzKZjh5jpuErcgGPJxB9WtDHhS3nzgplNmHVFA2tphrVPIF?=
 =?us-ascii?Q?99lNcd+oYgxf3upyurs7FyDfJEDfI3dW1va5805+b95ktFL54pKR5twJQ9pk?=
 =?us-ascii?Q?6TaoVn3IlatL4RmJR90lyH75YuTFmH3vuYzfrnrjfqTzR/ajNrnsZYQ57k1r?=
 =?us-ascii?Q?WK9ogYP0ELtEZS9ilJecgjtat3V4BxqLxcv09VfR?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6d5e01-b0c7-44b9-d2d3-08dddae12e55
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 03:18:03.9533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sq3ffvewaDdOMjQuifVwwCW/nB+SboY9/NoBujIHN1ERp2VYM7+ydjJtAnWwX/f2NUCI17f1VqFlHH7jCh+7kw==
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

Adding the dcache flushing and invalidation in the smc_send_mailbox()
At the same time replace the use of u64 with uintptr_t to ensure
compatibility across different architectures and correct the
pointer arithmetic for buffer end address calculation.

Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 arch/arm/mach-socfpga/smc_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-socfpga/smc_api.c b/arch/arm/mach-socfpga/smc_api.c
index b212a94b321..a531030f5be 100644
--- a/arch/arm/mach-socfpga/smc_api.c
+++ b/arch/arm/mach-socfpga/smc_api.c
@@ -57,6 +57,7 @@ int smc_send_mailbox(u32 cmd, u32 len, u32 *arg, u8 urgent, u32 *resp_buf_len,
 			 resp, ARRAY_SIZE(resp));
 
 	if (ret == INTEL_SIP_SMC_STATUS_OK && resp_buf && resp_buf_len) {
+		invalidate_dcache_range((uintptr_t)resp_buf, (uintptr_t)(resp_buf + *resp_buf_len));
 		if (!resp[0])
 			*resp_buf_len = resp[1];
 	}
-- 
2.35.3

