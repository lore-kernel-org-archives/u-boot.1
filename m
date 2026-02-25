Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987E5F55454
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 04:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84BDE83E61;
	Wed, 25 Feb 2026 05:19:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Mmq4d0lj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C28783D8A; Wed, 25 Feb 2026 04:22:05 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0D3683E63
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 04:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+pK3xzI6EfIZXcNOKeWKEIK4sog3Oky2eYDqY5diQM/QPQbeJIv6TzT1JzTbbdnc2KThzlF9JqScYM7eN7uQeD/8zdXM7U55aSTfOQw6uOuuvuZXAa7YeTuJRHGejD6ZnzRbCvYt6/3Gp7Z0Bo94yjNMmAmwhK+AdMtmId14vV9IgZhaoCNOTxSIyI72rG5Bc/3SUI6a/v7FjYgBHVxikOj5YLNN5ft3KwOZ4EhFwBwKzPjrv/gpDsPSjVtdU+7uB/ZmM0S14xVlNiLPLp/GLZVnybPdNh0U5qcqFmzrQ7UlgXYVi+I9GXn43/ZJC+0BgbXoRsbfu11OEzzQ3xF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFmGeog+aJ7Z/3RXGfLogVOmxAl87FJF7lcc4PsUoHg=;
 b=kaAQUa3qveZpyFlgqDRq33GFb88yzZc1txBmQKXlRV738LfZCldhykUUmISXhHiL2FaDaT7zAM8/pyhBjx6Yv7wRr7/cNGe5+hcWi25rGyYOGfFAQW2JJobbXMmM/QxISV6wm/cYo9oYrnlI1NU4GtehiNnxXfALKMp1l83GOYgIevKganuMKmWlR+lrk3gZNkdfYl9zGfTS4gtKUVQeY5FRP29NSVyoGW+a7lPW+bNEwEQ1sz8E3uHewiC2cexiYF8ximvPQNJZlcfhX83pVoqbUwu2xQUI0SwNQVdnIOwh65kPOmGC49BY5zlk+Yf/QiuR2gRflop4KIOwnlvGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFmGeog+aJ7Z/3RXGfLogVOmxAl87FJF7lcc4PsUoHg=;
 b=Mmq4d0ljEWr0donkJ55klqUJ2wtlKdsLF60lJcPxVRiynXQRk9JVQWc5QXVMgPa+mQnAg8cB7uJqyXhgzCMnD0G5kAA9UAqDFLAt2xXBxG5G3V62vKWGLjKRUExa8hLZJePFeT3xTMKiz2Ozg4jQVvCMhx6htuxSLnRVCo9ATmBbTbg83b76ImWjy/DvB8OqP21JuHSyg+8fAVtVyyU92Yi0js0T4pdVjuJNmCwjhKCSHpAAiTT02TJ/zqXmoAX9g9kvAdPmPc0BTk5MCCqo8ScJnFk1ZEke8QXGViZo59x6wi3zSzlxo/5zK2ogSVI6yn6JCerkhhR9AsXO7wJFrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SJ0PR03MB5855.namprd03.prod.outlook.com (2603:10b6:a03:2d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 25 Feb
 2026 03:21:59 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9632.010; Wed, 25 Feb 2026
 03:21:59 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Lok Chen Huei <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1 1/2] arch: arm: dts: socfpga: Update L4_SYS Security
 Control Register size
Date: Wed, 25 Feb 2026 11:21:48 +0800
Message-ID: <20260225032149.1342-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::42) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|SJ0PR03MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: 132a6d69-4367-401c-43c7-08de741d090a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UMdqoXvqEOLFaLHMeblP4vN06Ofrab1PN+A8N2bPIgVBuB98/Dm5d5jyEQbt?=
 =?us-ascii?Q?+iE+Wz0SDfWc3bcZMfaiOstU6RGDVAcvZCbhX3QHITMxSOxU+wL/aFc3DnVG?=
 =?us-ascii?Q?XkL9LUnHc0deHp4QuQT7iLzBKNumVKJtgIvN6cUczkPf3MuvfZ4FmzfSMhbo?=
 =?us-ascii?Q?plIznPNHURt+u5Oq+5RgzC7UXnqmt7EZ25bAzXQyecfKPYv4SASBD9MYmhug?=
 =?us-ascii?Q?fBhNlHx2CE+4gW2NvvsCUS3GjeCsKXX6aySQtX6sIPnB9u1nrxb/jBIdtFfZ?=
 =?us-ascii?Q?OYweA3oe0JibbZqpCVxZ3iH8BpKRVcDmfhnD1sHPjTdVTfKZmSAGagwndQ3R?=
 =?us-ascii?Q?SocmCsOsG1GwNSHt/iAD5wJWf7SUgKHK+3Y5eIZVmmYF3i3Ca40v71RaGgO4?=
 =?us-ascii?Q?aqtobiuSbAi4Vr+O5IfhglZ0A1zYi9kcLT+3dQWc+IGU46tB8wL+przQW2vH?=
 =?us-ascii?Q?T5hOvnAZlUjxM8hkqF0pl4GCVmSHvcDTlj7Ad9HDNCn39zA0hbZjPZp/F54Z?=
 =?us-ascii?Q?auNttQ9LVgd0xcwWTBSmdX5IIWr3x/EaUjGbWPcndVe6LokcfnpJkMz8WI8e?=
 =?us-ascii?Q?2K2YeswA4ZxDj42jUmNWPA4QllIGulXvbXedt5UGzK2bf4wFUZx5Vf4jfp0U?=
 =?us-ascii?Q?rI5l7wi2R1G0HvuG3+oyjzqWrjINGvHQoCEv2lWXPnoCk6ruk49iqKyOg5RH?=
 =?us-ascii?Q?T0e6rDHupsTnHVS6fpIh2eXO4YPAM4s5vBU59x4MIzS48CwQZb0Dvh6S3vYk?=
 =?us-ascii?Q?zCnjS6gXgFH0yUJgl9cx80WQmfn8W6DIasCu0t2fuUmB0M9SnrHplEJn3KBB?=
 =?us-ascii?Q?jI6gCfRk3d+aFymrvd4GFUEwvFkinarP3Tr4834Px7+mlrpbcSM0bq3MlWXw?=
 =?us-ascii?Q?KZx7Vf0YKfWV4mFw6V+zHghCL1uYaRzBPnOw+DXEieHeagH0gTZBbp7uEFPa?=
 =?us-ascii?Q?F/Sw9LeHsb+pgqzref69e5F63tJCrrhVeTRvyfuUreipKiAFJouB3BoopApQ?=
 =?us-ascii?Q?W8GqQedDXFNlqIK9fGRSq7wAFqQCjLw6ULcX/cnuCpECdr3UIUwMyUcMC+OE?=
 =?us-ascii?Q?2Daw2rAWopCKFruVWoDTU0Qy4vFZo2T8GLY7rbt+elAN/FpJPaKzw7bOCbWt?=
 =?us-ascii?Q?nuuLXzfM0NdmBlEoWba4vP/DrJM+HGFMhZBWskSdNZtWB1XdDfnAIPBwIpe3?=
 =?us-ascii?Q?0oHmFdWCsuIdGT4QSwmS5Gt+lTJ4lZEnKx5cYzZUv3bllqargoyFNF04phxt?=
 =?us-ascii?Q?nqYvJsGJqDr4dgiW02TI0Bw/MSoO46sVHvrSSQ61V6TpmTvwZlszhKDmTpMf?=
 =?us-ascii?Q?5CD8yCBXyWLElkRW0aK4uYU2jIr6bT/StCYxJfNbQD+GX5iPYFXr8WY+j4q3?=
 =?us-ascii?Q?2PZJaJXUq/dckr0jySP9vUNAKhkO9XMi3H4dVNdeDwA524lEVPYO2huzehwQ?=
 =?us-ascii?Q?AKA6Ykx7WDvSR5C58n5kNIU0onezhyZ5s76tVOyC3sxW3f1MIt0mvl6EJCUT?=
 =?us-ascii?Q?OPW18SsCNuyVsyiRc08fZYQ0crjZmz9qLoyv5LsjktEDtd/OQ9LGbImVigEQ?=
 =?us-ascii?Q?mgkuiBcZm0oRytfyHYQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?34XzMvMC0/E3rVC3dcJj7BXU6n1WYnjKm/4hklr4ec3efl3WNAir/FXxjKzO?=
 =?us-ascii?Q?aDSO+q41+TtEEB6k2MZPvaPFSs7rkB7o68qUmrjTEg2+FXs2F5dzFiawQa1E?=
 =?us-ascii?Q?Kh2gT02w29F5voOlUs8DEUXyxtJeavPYfhdcs8udycFMa8qVCFi1KKloOzA6?=
 =?us-ascii?Q?cMyiiMeQKKAb3f+EmtqsaAvDbw8VSPNNQ/jfQEiIp1z34gyNaG+E7yUoQMVC?=
 =?us-ascii?Q?A87QZc70ljOpNMDpVfyw3egBewgscH2zT2TAIXOXiBT+Y0gOUKXxI1acukqY?=
 =?us-ascii?Q?9M9TEn+W3nMvf8e2Jg9HWveYywQRjNwqG2NSArlUjOA9exDZ4XHYSFWjWlkp?=
 =?us-ascii?Q?xCj2xmNKS3kg7dPU4neeRbwQn1AITtuHWSuS8Z1WZGYjKrZcfa0CRMn/b1T4?=
 =?us-ascii?Q?dsDVSTuL+7zKnHh8DqoF7ICtK8TV0JjVchfvfs8V4B3mbDm5yG3o/W1F1apv?=
 =?us-ascii?Q?CcezD0wzVKlHeHXHVNX31omVjcZ6R5exK/ZF1KtGHwBcxov38yTMnhXhrjbQ?=
 =?us-ascii?Q?NcW4Abj6Y3SPKJ9v6rd8X3SAXc+usUyp8edOsYd8NlFMH/UagYgQFq6B8noV?=
 =?us-ascii?Q?QbOzjeUfyjdEFGHXzGtmXzXLqlj09f+GJhjELQVTgFFXnwQP4r32uNoRGpvN?=
 =?us-ascii?Q?Jd9jCty54Xzdiwg5i6t40sVGT+UzIix6sXm2K9t/Fwt2BMsqsvUhsT04zYJQ?=
 =?us-ascii?Q?C+LJoKBy7TGQIS40t5A2L4x0AKi6WmYw8btVBoGtb+lFMjbpN8g9Ays97oST?=
 =?us-ascii?Q?HL/QOkv7o01sc5iBKcROYudHgzuN7dZxUQ9hJBWVvhfP418OlWq5f73ix7b6?=
 =?us-ascii?Q?wWcAOOg2uZJVojkUNfORj3L+DHAdScm2KosexQX8EPfZTnbrGcxT2WXoq42q?=
 =?us-ascii?Q?yXOAtWMcA8d63T/34ykmof2lwzPcnumgKON0ChbevMFEy5nMCuGxrAP+trr0?=
 =?us-ascii?Q?MwPYzEEt8CeGRz4gRIEVr9AX8GoFz0NmvKH0elInjFbxylJNO5v5a9PbEmO3?=
 =?us-ascii?Q?HwJF6XpDP4PUfY8UMXGCw9Luxt5uXLVQ6Fr3FPhNiP3z3V/CLJc3UpYlY+ma?=
 =?us-ascii?Q?C8Yqyz/DAflrIgPmUMdhfONHwAejBcRjRdciPF5uk7UY1iLsBHI7CX1a8Jqr?=
 =?us-ascii?Q?RhQ/erQt+JlpzBlsBxMCr8XrS3JTQ2MgM8BR/92NoDW9sVrdI66jCaUPpJPj?=
 =?us-ascii?Q?i2LqVCLLr7a45hvPzzumbIAOnqIgN4QT09SXYDKJoOy4odXrmg1l9NN20nGq?=
 =?us-ascii?Q?R0H9hl885U8MTbMmifx+TWRlNkAiYXyjgcx2SvB6hF3XoiKrkUYVyRGGWYLh?=
 =?us-ascii?Q?MWyQZD8qMV95rVrq8mr606jYOCZ56H2GAscjkxBHX55sdzGo8dOsYEDvah2P?=
 =?us-ascii?Q?s2kd+Ehyf1IuylBSJg5X5yi7EFZpaCjTf6ZmD6j77XBCwDbm4diWdinxP2sy?=
 =?us-ascii?Q?ubImrRvahv5QgOs9/bD/TF+JTz8MH+ybqNS3+umd8NbRYSDpI/S0myLBmng7?=
 =?us-ascii?Q?gNdaqTFvQOf3qyg2qhXsIfNVWZrYhldh/cxV/X9IsbEyiUZbO8rcEl7r0TY6?=
 =?us-ascii?Q?TiF1/VUAHDrw2YFHyaemgEV0ao4XYd9FcZKnyb450xzVunrWVmNJVqvrUE2l?=
 =?us-ascii?Q?ZurU1jFkc1epW/YuaJ/a5zq6vQVBO3hDxDd/JC/aXjrw4bJWPIcx6m0cGS+K?=
 =?us-ascii?Q?eoIwJbtSOSQMIZ3u0Xpj5CoaFGO9ZYZlfQMHZqUa2VMgIs86KGaR+LrfmVNU?=
 =?us-ascii?Q?pVRt6iqEAA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132a6d69-4367-401c-43c7-08de741d090a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 03:21:59.1374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRuAhhEJeuuQhj+2Hzj2GNDPsvFjC57Bt3QpkHDz4YyH4vEJfGlXvOAEC3do54at2fIW0m1PW+nXt7rwZ+dHWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5855
X-Mailman-Approved-At: Wed, 25 Feb 2026 05:19:00 +0100
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

noc_fw_tcu_tcu_scr register has a base address of 0xFFD21400 and an end
address of 0xFFD214FF for Agilex7/7M and Stratix10, which makes the size of
the register a total of 256 bytes.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 arch/arm/dts/socfpga_soc64_u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_soc64_u-boot.dtsi b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
index ce5b37ef547..a6e0b615717 100644
--- a/arch/arm/dts/socfpga_soc64_u-boot.dtsi
+++ b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
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

