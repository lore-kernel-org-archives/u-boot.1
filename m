Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE94C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 01:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C3DD84A0A;
	Fri, 10 Jul 2026 03:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lSZU31QU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5616E843B6; Fri, 10 Jul 2026 03:10:08 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 644E684994
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 03:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJFCo2TClA1YSMumFKTWM+mfgY/jSTi2bFcelyAb2ddSsNdEfp4EYbQ2TP6arju7rTycn1QoZVt+adEHtGzohWF3/oW70W59pwr6Fs+VbfJIStkM+t0ynCRnFM4dS2DDZ5Vh3KEpqcknFp2R8n1dq9HdPKAt/gSEsVF/DHzkZhTphr/eTHn0zSwWiFg2Z6N+ZexON/hvLL/HB7uuDOPPpKi9I3DL9lsQRAFMqtfrP77Vh2fmSn9ES9B+B3uI2fdudNcGRg11pwB/bj1PyhtXjSnSudXSK2pzZVuobqsvMcMHa0B54oCqXfVDFZ7MXfLinBTYYvcBDGcM2Xf18sSXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1Z3r7bI3oF0IgQV9bd9+gm3Nq/zEllm0tPYZJJnP/M=;
 b=mnygHrat0ADpJ5Fr2WAWgrgAl9XIDSpNRPz13UFFi/0YxUhxX1ELe04UKYlt9laZnRhTNWvJkodMJ80nWcIWjW8zsN47HXyHfEUlBo8dFlYAwR0a93kq8RzI7zrmVer4i0n6iUCZJq8tOmEIVHbe+e/s9lf4UKfU2ZF8feMIrXaphHe4Wi4WH54Xtpo+8rlv9q3IO5mNzCRyF8TOgDAufH5aM7MiMT6eJRPIuQ7o2jx6s5EIgDu8KUKQqUzBZvusw8naVxvHU9DrejDmHsZ8n7oy++a1heaGwjGeKTlBlmAb2FY3FsEPpznrOLVpploqzufyZlKhG8+qCJ9ZKkYTeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1Z3r7bI3oF0IgQV9bd9+gm3Nq/zEllm0tPYZJJnP/M=;
 b=lSZU31QUF5jzBZWe4WP+D044un65SrmNwCMSpVQ84UVQHdinaCj3JFO0qR4wffni/5jmmtNsnTxTmKP8jaDO2hkIhPZT1AzBvpCXiEM+ItEltiWfrkXp3b16160Zuk07M9Dn+O1nVVjkHr/mVGB+obOhT3NDDmJ60ccT3uD/hFz6am2UH41KDqKfObCCWIxNfOvnksJKTVAK8JRvDBEbM1dGL2HYXf9EtQs0AeYezikcHK0FyfOw1ceusMGP28t1wvnUrbaYAuMyTQC02C32o3u8QwjBuLJUEzGsayZGzsT3V4I64mN1xOEPmtV33nAk0znkU2Gr5rD604QPEBueRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by DS3PR03MB989146.namprd03.prod.outlook.com (2603:10b6:8:39c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 10 Jul
 2026 01:10:00 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 01:09:59 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v2 1/2] arch: arm: dts: socfpga: Update L4_SYS Security
 Control Register size
Date: Fri, 10 Jul 2026 09:08:28 +0800
Message-ID: <20260710010830.5423-2-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260710010830.5423-1-boon.khai.ng@altera.com>
References: <20260710010830.5423-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:254::8) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|DS3PR03MB989146:EE_
X-MS-Office365-Filtering-Correlation-Id: c21b9e68-017d-400d-dacf-08dede1ff694
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: LyzLhASc1pnyBPfmmg4Wl+C/CBR1dtwr4EKCCTbShtIxuPqLp/cvWUIcVaO0z2mZwOC4mI9cBS7aKEiHALKS3hL0t2/UdGAVk4ptkS+m9aLv/ArXdVf5duMT/Fsq8iQDtPfynhwTMwHgoF5Hv5cw9sSQl80X5pXcZKE6aeDdLlL7+k7OgkeX87efUgjQvzGUnIXnpVX78edKCMYC1dqNohvfMdz2QJT+vsNYIbrhJgQQ4HIdoE8+GD/A+G1RKZTInCqMDtL6HXdOIBgaH1a0Whf1P22z3JGFPC9h92eE+dMOn4A5jy7VjtHZsjqtUPye2YfdUFgGIz5DK/3npQNQxs+0D1qwKVP6jBQixdn6+H2tl6s8dJj+mrdSqMzyhY8xAY38oiRXHJAfweGbJkB6rHe4cmOYXx89MdYaCcNKj7WVe7WWYSOxsnh3aMxEPfFSDgJZRnzTTfAZnHp8JpJitx53xmk8UL0nWEOiK4vo2MLyRVIBalUjrKCNfpXZ0dB6sZXFI05iLNxb3rRf4XCUa+i1TX8BSr1Y5lYigOytUOY2bYAXNjlFxv1mlMZovfSS6cOHqH9ASUS1+XwzYZZGBMuVnIzsozfK2NAzd+C1B3gJso+/mUTtG6OzrMjt/saIs4nZzVdqQzd0xMkBKFYq75ZB27pp0YpYIhzXB4DhPsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(55112099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ZdSb5RkDST9JYjK7dIT30h6Z4VpzFHPiSd5MuvPFQOkloaCtRKInz/zkem8?=
 =?us-ascii?Q?kmWucPRWW+/bI8XoDD6IPKYywYC4asaBlc1GlxiOKrSo1gebmMeVrfBAAs7Q?=
 =?us-ascii?Q?c+J2/Y2lIlTyDCi9Vc6I/dO7QkORFlg2LaX0NfpsAinn+kVeyLLCA/Bc1w3G?=
 =?us-ascii?Q?fv+NyWQKNkrhCbc3pzkLYhGFZULdsZbfNgtfJQRhW6hNeHvP0E0j8zPRkoQh?=
 =?us-ascii?Q?02TB1CGGxG0ZATHqxWQHMsN+DM5yJW0eUwPsLjsEbkBthvhpLtkCNrsqTegD?=
 =?us-ascii?Q?hFzEDlsa1WgUyFno3bG78jZETl16qibaEXZqzsDoe7uvxFmp1gDAY6EtWqdw?=
 =?us-ascii?Q?6/XJSt8/olrGhl70r2QJ4dYj0hHi3yg2AB3iZg6/QoPZVnASFNlWzuAqHCUH?=
 =?us-ascii?Q?Z7MhZfK8nlC/QnRwLEj2qQtkVSslSmneh+JWpeWB4WPnQ4I7QmZh0UZybgql?=
 =?us-ascii?Q?KK/mkFUqb+Q3w+ml8eDg8ajHBdN2bnRYl/+1ig0Da9aiG675w6JZltqAbaT3?=
 =?us-ascii?Q?tQ/nlnab4OBefm6lcRzY4YLfzkhXCQC48QJ2j05sDmo37M4EwADol59u/91D?=
 =?us-ascii?Q?4x57GBhGPPiws3eGYOSD5YdWml3ho+qXTMaaZlE7g7Dxq2pqJ3YG+bQXnM4C?=
 =?us-ascii?Q?u0ROabO6w4X3jAK94yT7wlGExAJrmGxGa5KYElqIAyLNmrXLjN4WRWgvyjeN?=
 =?us-ascii?Q?4zq3ZBvXKt2yWru62qhyIQiyIHzhKq4P2CWTLD1vqr5d0W+AVtmG46DqXOr9?=
 =?us-ascii?Q?eKVDoaUbhDQfb/eLLJ+SeBImrehL0/eqtlVVOru0zLaE3h/T/zY+LA2gPxtG?=
 =?us-ascii?Q?wjdN4ztTmfb7bPjKVhii7gHiNTl3G7U0g0dk0dinp9BXHXLbf3KszvnWtlF2?=
 =?us-ascii?Q?ITALdOnVpSM3+Gy24SZluMzc6sBewWCHEpnleS2AdqQ34LKCvA1yT7RMQSFK?=
 =?us-ascii?Q?onTKwYXv1iSfprv19BMpG7NmTdwkk0IvIX9FYQS4mYe0sJRBbX2WShY1XmV2?=
 =?us-ascii?Q?V/+uP8vn8sPuViUB972eflNC6ZqDrbD2UhobXIBdBdfWUM6MyskgI8KlDm4e?=
 =?us-ascii?Q?MQ51+meDjD9KIKaxa+s4wxukgqr0SLX3H/FVuhvtZ6+xlPOF7R/UUFRDxU2j?=
 =?us-ascii?Q?RwueLXwvUWvNGvIUXxmxPDcVhR31q2eH9u1h4+iD6WIlXjgVbR8Nl682FhuV?=
 =?us-ascii?Q?TVlMjdx3CkluahKPBltyT8LdaAzMKTS9UqkZ0p0/DpLXWddTYMmRioLtp5Z/?=
 =?us-ascii?Q?mO45MC7DMWS8r7MDcPbcjL9mfD4zeuqs1g/bWADQelbLYIY3GxEjDNRUlEiu?=
 =?us-ascii?Q?Ll00EFanwG5hEsGlqeg1GMg/Ephe8617Cqp83rRvpwIuEThJdB8mNMPcmggZ?=
 =?us-ascii?Q?4SrGssQ1dIzA18P97/Y/Gn7wtHpDiFBAEB1JCJr5l94mz664+nxOeZ21jRWd?=
 =?us-ascii?Q?v0aA697lKHFg5STiZqq1B6p5XcPRBxge/8AtwofVqut137Tiowduse9owMS6?=
 =?us-ascii?Q?0ZPH5EerIlF0DwlD4258P4rI61I8Rmjt75q5L+UTzQcUz3vsEu9dUl2xuZOg?=
 =?us-ascii?Q?KEmQJaJdefbnVPiXPnDUjuLx+VtsODV+Uh9Av9MtZpFuHbGrINPWHg+4GEiZ?=
 =?us-ascii?Q?KOuHyN9J/1EUYpMcEbHOPXuOHXq0kS+Oc2YCjuJKeDwMGHGjXo+sFBaJGrJ+?=
 =?us-ascii?Q?ZgHh+PMQlhKTK3E5I/W8NmA5or8Ss7d4equFzALC2Weab3bwgnP+l6wjQvTl?=
 =?us-ascii?Q?pGlN5pn/iw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21b9e68-017d-400d-dacf-08dede1ff694
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 01:09:59.8303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/gEA+TROwGARAIQ8OCW6X1DBAGt2wx7NZQoRPvM6B0Oc5pRfQpoUg14vW8qLhgATt3xLFTlChPRjV0SYGAvcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR03MB989146
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

The noc_fw_tcu_tcu_scr register has a base address of 0xFFD21400 and an
end address of 0xFFD214FF for Agilex7/7M and Stratix10, i.e. a 256-byte
address block per the HPS address map.

This register appears in two intel,socfpga-dtreg nodes
(socfpga-l3interconnect-firewall and socfpga-smmu-secure-config). Update
the reg span from 0x4 to 0x100 in both nodes so the described decode
window matches hardware and the two nodes stay consistent.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 arch/arm/dts/socfpga_soc64_u-boot.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/socfpga_soc64_u-boot.dtsi b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
index ce5b37ef547..09506718d83 100644
--- a/arch/arm/dts/socfpga_soc64_u-boot.dtsi
+++ b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
@@ -109,7 +109,7 @@
 			};
 
 			noc_fw_tcu_tcu_scr@ffd21400 {
-				reg = <0xffd21400 0x00000004>;
+				reg = <0xffd21400 0x00000100>;
 				/* Disable DMA ECC security access, for SMMU use */
 				intel,offset-settings = <0x00000000 0x01010001 0x01010001>;
 				bootph-all;
@@ -132,7 +132,7 @@
 
 			/* TCU */
 			noc_fw_tcu_tcu_scr@ffd21400 {
-				reg = <0xffd21400 0x00000004>;
+				reg = <0xffd21400 0x00000100>;
 				intel,offset-settings =
 					<0x00000000 0x01010001 0x01010001>;
 				bootph-all;
-- 
2.43.7

