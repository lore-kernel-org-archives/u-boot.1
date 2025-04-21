Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEECAC369D3
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C9E981F69;
	Mon, 21 Apr 2025 18:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rraqydvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AA2981F0D; Mon, 21 Apr 2025 07:14:26 +0200 (CEST)
Received: from CY4PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E727E81DE3
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 07:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJCYnBq8Xh7SMiU8WPf8wfz/yGeWjawOnzieJwuS6kje+wvVlYFPKTINKc/2GUk5orJNYToi2oWhPKiQWe1hvy8cASwsFguMI29IG3HnU1+fMzKc1m9wqSRCJ0lFxOu17SLEahS/Z6P8MTY5VqEWnrhamCGcAuJinCSdhbG8hkXixsQH76udlxCsYZ9Q6SAgLhrlVGnK1bMCephByw6MrI8pkl8qKwMsl9d86f/3KXrkdVhm8V/oGAwQeA+TjHEXGRZXqE970/1eOBnaECFew58YioLP3NORzKzJFWVFtNZKws1SFFI1epUrVB+ThjR+ZnvH77PcABtGZMeH218p9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulY7Wx76VKx3+u6MPO52F6S+JKK8vYAquaCpAOtyZTk=;
 b=DZUfz/tCZEYBQsvrPD+0efLnNOWn5XrYxpgaYGlGNJ+28l9jGTLZbeZARnT7nRTVUmrPBepzRgNAlR903luaxTwnSU219Bt6f1G0vGcdpkexARC/1FCygvseSQiWYpdJ9fKy/aAJNIeGorWUJfHA/59e5nPRJ3oP7JWycocDB5XKTCscXlu454bZccbjpZL8qhZ0wf1DFZWcczPdixW5qMy60YP7MNh6ROze5jruT2qhBJArnRZje4uWvSdG6LlFHFMyqd6Hhohkjviz8ZnEV1V0qTVSnuG6u+qEWJAw4EmTfXiVd1wN2IBr8DniuS09kNIldBkwGuGHbvRedohbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulY7Wx76VKx3+u6MPO52F6S+JKK8vYAquaCpAOtyZTk=;
 b=rraqydvfOZuu/v7QeNntT8KMV1nsikFWtowfmRcXNSa7RZgobPpAmeNZENq47XxhMjxyjzfUvt+oV7EZBR3u8pDd/5AVXjje7zOsReVW+QBK1t0WtrbxHxLAgbPQMKB/4L3Egj5hxv3RHOK9icD7PLqGJBesKDBmgLxUgP1eDv+lfXJXxkKwd75H2nECVVJ/nM388xp0P8nQIXHuKQR3MW9yb0Whjxk8kiuX5Mrw/j2MOjU4Rgr4SvYXkYzf1PTwf/JViqgEJDLscxyevm09MkDLZbs7CnnnAzMftUPjnfHP8rzTq8FP/4BSlLqIglDPVqEefT4zlbIie1nOx9Nv7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5621.namprd03.prod.outlook.com (2603:10b6:5:2c8::21)
 by SA1PR03MB7099.namprd03.prod.outlook.com (2603:10b6:806:330::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.30; Mon, 21 Apr
 2025 05:14:21 +0000
Received: from DS7PR03MB5621.namprd03.prod.outlook.com
 ([fe80::5337:db99:bde7:e33b]) by DS7PR03MB5621.namprd03.prod.outlook.com
 ([fe80::5337:db99:bde7:e33b%5]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 05:14:21 +0000
From: tingting.meng@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Danish <danish.ahmad.rosdi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v1 3/5] arm: dts: agilex5: Update CCU configuration
Date: Sun, 20 Apr 2025 22:14:10 -0700
Message-Id: <20250421051410.27615-1-tingting.meng@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0081.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::22) To DS7PR03MB5621.namprd03.prod.outlook.com
 (2603:10b6:5:2c8::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5621:EE_|SA1PR03MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c2216b-147f-439d-4f89-08dd80935f9c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SfJDFQRTwSTPT1FV7YnIDXAvwDmZaJueEUu8DYxvSewSNmO395B6qKy+lY2P?=
 =?us-ascii?Q?pKy47NO5ooAfS+fObJkzRoEgRT7dgraVIY+6GsxbTf7YTP2TqrhDhY8Ht5Ay?=
 =?us-ascii?Q?PbjQkVHIZb0HMY/XWd8f7Uty64fdBDCrs9AL3i0MqXapPCm6V68MajGOQpof?=
 =?us-ascii?Q?1DoEHeEm0blEo9CAta+zTnQ8PUieS/EfTlEx3mLnkapxv9C1XOntrgBo6Phd?=
 =?us-ascii?Q?5919/q6lWCyBSFWWO4Y9B0ChKy08B9CSksiFcXGyEB33n5v0Wvj2HaCZdfsU?=
 =?us-ascii?Q?FA7E0JCurvFf59MRHM33WMzWgUJKEtp8Pk5PRrHwjfROYbI1493UtY/QYaV8?=
 =?us-ascii?Q?sOueP0+dBWJag+r6ih2oLQvv1gSakzQyKoWQLTJXJXxuWs8NVe/NqhS9mrdm?=
 =?us-ascii?Q?+PnWuBytR/rX1cOWwIt/QC/SPJDYdmjl0FMNLtEYhiaJKbJtBoyeAnN7vsO2?=
 =?us-ascii?Q?s3apO79QZv6cO1LdLUY4B9C6gPxH0QVSd12G6ViikDJzj/n6jgsof/KIsy9R?=
 =?us-ascii?Q?MP86lfVfpytuPteU06gLxukHE48rAGTr35UCEcrmAUYNuWYsm5hRgS0rCvZt?=
 =?us-ascii?Q?ogAc/x43srg9W0f6+LHvtV6D48ckWUeCjPxo1nDGthr6DWh2yGZQHW4zmCCW?=
 =?us-ascii?Q?amQMMPnrz9LGEXZZSomS73tjhhyswVUmMjIC2CiEEJnSWsCz5wKxXe58w1Qg?=
 =?us-ascii?Q?fNsrDWBplWngwvJTu0LkLdZ6nJEAown14xJWPrN4aMQKXZiLaXnQtSVP2evC?=
 =?us-ascii?Q?XS1g5UzTmW3rRriuBBWa0fp2IIQuN09u/nCrL/mdaqXdsXTqPVzP0Ebmlq9d?=
 =?us-ascii?Q?pETqc/j2pOTBjZi5Rnjd5eD26DZ3H5sNdCPqjEaHnVcL1i+YWb67OWwGmQOQ?=
 =?us-ascii?Q?Q0ALRrcCMnoJNEMYtblq42WfdXSZBFnduQ1EqqyytJfjTSzUsAIGXoDCSQlg?=
 =?us-ascii?Q?uq1eB9X9UeSdTwMkjV011dACMv2zSbh1IqF6IF6Ckfy5R+2qazG4cK8QYVtJ?=
 =?us-ascii?Q?2pg+rb8H05Zg532OyuPQiHqfvHtUxN+jtXw7DFGZahaflY7uU1ClfK9kMgeH?=
 =?us-ascii?Q?5lCtmBzVvBgbg+yIz8xUL9fKBEblyViSw9QWFeO6nFkDPvpDY4oQNkNecDhH?=
 =?us-ascii?Q?uW6DRYZo/DWTcxbQCjYFHsWmlfKFenJ11l7BXstw372utw9F54z6BvlaZZln?=
 =?us-ascii?Q?x+KCJ0D4aJyM4lZZ62XA1IqWH282hUBGcOa02+ln7tgGmlv35rgZ9AP3UROI?=
 =?us-ascii?Q?jlbhe2wUMInWb6GOFa9pXxYVVYdHBtTziKCVIf3tvyA21++WkohxyGMAvkS9?=
 =?us-ascii?Q?dFqqxk5vyjVZFIusPWy8/YH+bgjI8uiYkjRehZaC9mFra6Q8wMw8a2179vgH?=
 =?us-ascii?Q?y/mt2FHuDI7xNrVgwUJvR7AKt1NPPXphNz889NwWbm1LXHPYfK2qrU5Z7JSG?=
 =?us-ascii?Q?PfFSLfMj/xU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5621.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q8EThjT6alVFNtcY9C2+pa/AW2r5Bn25l7rr7gxJspH0HhfevrNQlq/IROHp?=
 =?us-ascii?Q?/8tTwuim2/d3e78p7nbDteN7fA21NLpMA+TilCpDWSadtBDY3fmLGvvHiTfz?=
 =?us-ascii?Q?9zfu5F/3Cf+CqVj9NyzEgNdJEqqPB2tBJmeU0rLhwsn3/jVBwvS7iLC7yoDl?=
 =?us-ascii?Q?UJbKu+xDGp3EH40bl6SvI4fX+yz6uJpVxzLSbKMY2Cp+/2hEjghuPW7Ld9Pr?=
 =?us-ascii?Q?gCg9cLhzx+YyrpS8ZLpXdN5lGfKRP5MqQSd964vMhOG8WquZZjbOOC6GTHz+?=
 =?us-ascii?Q?M0ZFjcwhyEHngOo2H83IwXZKpoVbFx6OUL1+mxcXblo6b+gDIhPqwriHPMxp?=
 =?us-ascii?Q?UDWqxrW6N8lyND5OmuQ8T+vPy6O9B815iuRG3zy+eE46ixh+ljAuQLp68JxD?=
 =?us-ascii?Q?Udle3NoFLW2MdnGCsaIme5WC0WZ3boUx2+vHPQoo9na3a/GsCdHRBqaYw81r?=
 =?us-ascii?Q?oTdpQd+XsP/DhwKWbkVwS4XRLlB0Ft4xNyR7kzIWbPJzUGviKKBInpEOVw0N?=
 =?us-ascii?Q?R8JPpXQYJ2U6ffV5wqtOvaE5UOJEhV5stHf4wARhtCVZEFUjQP4crRtlYs5N?=
 =?us-ascii?Q?gyGiLgkN+TV3igXTuxcEeyyAGtiriyMqJJY8fBVrPGhC/lcifhqI73/dSQxs?=
 =?us-ascii?Q?+BOKof0gtuFTRof7SNE1R0EOROxzKa4EreyzWHy/mx7xuBl05PSUpM1etxBX?=
 =?us-ascii?Q?RyHlQ0Iz41Ml925+hrKzZI3waxx3H5wimt9Sp4OTAqiTwEaKXPPhkCucUiXh?=
 =?us-ascii?Q?ZDEZ+pdJMQRElnmV4jUPseMbFAyutjRFvIeNhzq8n2UE3H0/58PKo3kRDnEW?=
 =?us-ascii?Q?Sv+TXDyyW73ynpYUytxZgC0n8dS/Kq0QWIdgI/kaDd1Zz9g8PyJY/GybSRr+?=
 =?us-ascii?Q?L8r49j4j+WOv1l5F6up1wJ0z3GPEqRTy+c+VdSOQJasOW1pI1vm22UO/SO6f?=
 =?us-ascii?Q?TT8D/pRhGEe7G6mghV2+dQlwTER63Gju2RDDZCLZ9qA6ka5YIAYo/t0PtZ2P?=
 =?us-ascii?Q?ViRACNdSl2QG8Aou9S5sRCp7DIzmY9z7ciwJERdaglN7YHR+2Mx7gWFrp8VZ?=
 =?us-ascii?Q?i1ocL4HWZwkLMjVHy8oBtRd3lY4WKJSG3t7qJNXe5lvipyTYNeXuEJjpbeML?=
 =?us-ascii?Q?3sJk1/RyH++bFKuwLoZ5Xkahoc+0wooc486ZI0xeSgiNylr7e5lkYDF/0Jua?=
 =?us-ascii?Q?k7rLdXtDwUdg0zWip0SROiYiFlmHeWIHD/gh8FT3CgUoEEOkqC/ClNz2YL+C?=
 =?us-ascii?Q?VBg5M9GBNl1HiU3uOCfOlUQLn9aJCNBC99PRMP7ztWdqs0aZPUaFWGbpdaO2?=
 =?us-ascii?Q?w9tL+Eq3TBaqstlcZpK+G/QwnIvUNeohOZSJPezZMltHyvIz4zOZXHYIwxio?=
 =?us-ascii?Q?5nzLD9y/ocpcbneWtO5dLgY9BS46i2e54cBCYLU3WZpcvAaMLBlEIdd8zZjH?=
 =?us-ascii?Q?72Yfo7gxEAPo9e2C9oDmv57nUS4gLFn5Q5ETfKnQnapSkXhnTjAnGIQUZ5c6?=
 =?us-ascii?Q?ckFOESj/lx/i3kG2DOXlImnebRPttzu6LitIdQXnHLqzyucuPGGA4D7WyouC?=
 =?us-ascii?Q?OJfqGaZl3UemzIggoW8Ar3GIhAlBVow8hyoF5xLsNnko6Cj4rR40kv0wxwk4?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c2216b-147f-439d-4f89-08dd80935f9c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5621.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 05:14:21.0744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oQ0OxHHwO4E2xJPxfa5ljMicS9vvNP9msdEekP4pUv8O6Af1w343n9w8PR+sHqfMkCLkcWMJ4yBhpQCng+oad7a0IMW6Kzmr/ertinI0v8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7099
X-Mailman-Approved-At: Mon, 21 Apr 2025 18:51:44 +0200
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

From: Tingting Meng <tingting.meng@altera.com>

Cache allocation for dirty writes in the CCU system cache was disabled
for performance optimization.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
---
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
index 8d6503dd091..dd6cb558f82 100644
--- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -208,7 +208,8 @@
 				intel,offset-settings =
 					/* DMIUSMCTCR */
 					<0x00000300 0x00000001 0x00000003>,
-					<0x00000300 0x00000003 0x00000003>;
+					<0x00000300 0x00000003 0x00000003>,
+					<0x00000308 0x00000004 0x0000001F>;
 				bootph-all;
 			};
 
@@ -218,7 +219,8 @@
 				intel,offset-settings =
 					/* DMIUSMCTCR */
 					<0x00000300 0x00000001 0x00000003>,
-					<0x00000300 0x00000003 0x00000003>;
+					<0x00000300 0x00000003 0x00000003>,
+					<0x00000308 0x00000004 0x0000001F>;
 				bootph-all;
 			};
 		};
-- 
2.25.1

