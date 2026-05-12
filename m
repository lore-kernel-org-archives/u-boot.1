Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E863BCD4F24
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 16:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9328383DBF;
	Tue, 12 May 2026 18:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="AFHAQiqC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42DEC83FEC; Tue, 12 May 2026 18:16:41 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B9E283CD3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 18:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9g3oZ3hUp6o7Oh4ryLi0/nNIpVSlG+DjlKULVC/lavT8zjp2VuOLOxORPTJP83CW7uG7Xqj0RO6Z+NrnROfVD+niykgm/kIRCTZAvgaNRtHcjXgu/ezVqYePngYBnQb3+zXWCXNlhwZKZU39+m15BQ9D6Q7MC/uOHuLahbM/XOIKwFTiAJ63M4yywFvmIBWBt6K0/0EdXTwPn/dGfDhvH9QeCmI0c3qjsoMi95H9BcIRv9+u7f0zJqTNQO6AwZOmDGRMHKSwaM47kfKIr/fAlPfcITaHHI3gguBLBa221NICU/nWJtHiX9iaWI/hxz4xpDMnNwm6AzFkwonlIRifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAqjrWpwfqUVDI+RnxOBzXxZ8WSTh3Zh/C41sBNSwwY=;
 b=e343jxRu4wK1K1vQwlkqCI41lr4Xe7xStPXqOHUThwYi5BqekRCn25202WCpXl2lMBV9kOL2Nqgu0BoHuqNI4YKIw6SzJd6QtpQnAc9kj3z5WoNW4DrYAGPXtlBqj0/erBqeWfnrWR0QErzVL9TUUn5ls5f251FxgTdhfFC22IgfR5/R286grVRhgKCPhw57NwcPpaX8Tyc7xNv4bruof5RiuYIYsoX4jaQUvyTH2Z/sWtlvavykLaZoBvOJvWE2Cbj2LDb/Y+COTuzLAsURlvrGxGhRBapNPRTjyN4QvHgM9wYf+Ni0LDt74RX6pEfmTQxHtiOqn0Q41QXsSKf2/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAqjrWpwfqUVDI+RnxOBzXxZ8WSTh3Zh/C41sBNSwwY=;
 b=AFHAQiqCCVgDlhAwxIOQMtjdzQ2HH4xtP8ZWF2KTxeksUAd6QOVnoQUtqAnxVSVCzlo8R6DmRAj6RBHNzryE+S7zxrxTOmFlsAmOI9Z5xM+tC8ZP1HQ77btLt7GRBP0dZZ487+nm+vSZclisSt1D7d8mLjs4SS7BJRfUXMel6do=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM0PR10MB3668.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 16:16:35 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 16:16:35 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 1/2] image-board.c: exempt gd->fdt_blob from
 fit_check_format() check
Date: Tue, 12 May 2026 18:16:30 +0200
Message-ID: <20260512161631.284143-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512161631.284143-1-ravi@prevas.dk>
References: <20260512161631.284143-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0010.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:3::9)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM0PR10MB3668:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9839b5-0fba-4c76-b555-08deb041d68a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|3023799003|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: q8P1mzlP+eHH/qjSXw4paQ4RaTPAuTckf6hwaTC31la7P2SyYPjRClNoTaDPdt9/mq4cxK28c+I5lum40XAyc6bFePnaXmM+E+gHW3zeCVpiVFZZDABDagcREVh1emRWjNZDi+hNxPfecTt+T5Ea1G4dwk7uOCg8Vny6mW8liOQEx82cdBsWhwA0Ym9yi6KWxDy1F7ZNwxB8R/mAYQyNO5IYi9FLVl8CXXFboEqKzMAs1ULaZV0nj8SscXj9fPIyarsS9HqKizn+u3ygA6IfqMh1+U0mTDeyFwn/QwnyU0k9kiS83cVyX1ZaypJ/ThrGARuxWyudVvDAD71vC7RGWSGYJKf0T86xKaM+ArINzcW3xmLxBCUa//ys7DKuHShZstmIEJENv3yoeeU1wIHKK4zaq9uEr2IVzELPKMLWl7CXgiBzYaJd9RSQXA5xCYNPwVpR2iXiWHs4xxoA0Ka8X+RZf1a6uH2NLIcCPVD2jdQ22sHLPzILeAhu8AY4uMYlZtvb9b7JY+/ZM3IlHFpoY5VUFf/aGveH3eWx3QriRSr/kSy6WAgN74GRsFPrRyRP/IsILCKeoD5p5NeEq8/tpv3irE0Bl1Uns9EjXE7MG8XugsHwYjnwoAa6ylUK5m+QwR+ol/uebq9e7MIOKQ/t5ElpHy9c9gqSAcUNByL6cRB95EeGm5q1sNYVceMnm3XY1GvYrtqON83+1R8CsOaXjYMvJhp3GwzFp1s26umvYYhd7zLHsuBCVs2UpmjTNEyH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(3023799003)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CQkjwnT984hRXShCPeZFQhpFwcLop6WzcC1ykVo1Tx1k4myjWiZs+FpETJM/?=
 =?us-ascii?Q?AcXnVsqn1fbgvlU5/d/MOF4ZJdTK5k99TANRjUvrQD9jtdyTwMX92xbSPu0p?=
 =?us-ascii?Q?MEt9lwQGh8NTpf13MRP3f3/10XOP7tlDzzbD0OKFZA9sOEAyTdvDLXMGUxS5?=
 =?us-ascii?Q?/eRQ0W1tXiRzEBzivoJGRBQxKY9zDfLJ8wkpfOzTR5jxnNliat1lVKg0J3Vz?=
 =?us-ascii?Q?ACYB/I5H0zkjOqi5S4oyLhxW1lZAfT5nCmv5351MCvVxqSo90JZ3nIJ0mScc?=
 =?us-ascii?Q?x/g4dPw2/EoFm78i4qBaG3oYBvNkQlEEVujrB++aNeJHoFh237DQO8N8FumF?=
 =?us-ascii?Q?Ewf+K0ZrDPwHDo88NAlRPqj0C+cxY3ZdHlnHunzyBL2DOjfvFV2fsBfy6qxT?=
 =?us-ascii?Q?ene6LwnZyg2H+8SwS2YMk4/TefYohxSCqLtwq/6o/e6FJzo2Z3FazefUv53r?=
 =?us-ascii?Q?NQi3xLfpNi2yuUFPsAhIq5NtHs5yqVFCa+5iXXooeW8AXGX7l8IAE4Vc1dmh?=
 =?us-ascii?Q?0C/PWHDOtCMG+sOCNjx+iYvhD+ceOPJUBNiYtq8kSzT6tAWhZjy9/+3H9faN?=
 =?us-ascii?Q?SznLFcjJZXOWCNzpyq2RnAjtc0ZQjP9ySaB+V4n6Rj26JXBuTIuWJgKwzOFE?=
 =?us-ascii?Q?+AmYOWoGKuXuI2yNPS/55fKHRIo2PG1FYjTuZjvWI9kYRWb1ir/C7v60eZ93?=
 =?us-ascii?Q?PnsICJTASEF5evJcYBQrA3g/xE0bzx0uO1nfOvyYDUVAZi04VyyIEqbSvo7b?=
 =?us-ascii?Q?xIC8pAaGjPqP4W6YepKVusr9UB89uFvJcjn1KOXCCiKhhp3/MPqXiga5UaaN?=
 =?us-ascii?Q?NCwSm3Qx9DU5ZMknqV3Ga+lzJMuJq8tIdOa6Obb/xr0lntBK+s4+Ljcoa8IH?=
 =?us-ascii?Q?z4s9/l2vK4ur1D+75TIdBWaj6irr94KiR9Xcbj5T+fWQ8c/ks6gfWk5o6E+z?=
 =?us-ascii?Q?Q3mymji82D1tJVmurHLkjQnYiwm12KDglZryJkorQixPnfXlpnP0ZA9bD+Dh?=
 =?us-ascii?Q?YrNP+4GEoPSyRDHc9DH0WqK15b3g30ZcFF7I7H/4Vh7OunuuUrVVSuYj9Svg?=
 =?us-ascii?Q?1aGOWpuARC8FID85BjAn6mvjOZM9fPLq9s4oHy03C7Ew/X9dhk0hrf0qHa9B?=
 =?us-ascii?Q?0rCqeqllt7E8hl5OLCglLj52XkeDYvDDKQB41M0+n9b3KAaex8BasbcwQUAF?=
 =?us-ascii?Q?icVrVMiOTnhaVMgI7HMwC4LfjFsiAEskcfqh8E6mRRd7WEMH5DPtItb+mpya?=
 =?us-ascii?Q?0iVtdLbumgtkPX2FgPxXpptV2a0lI8ovF5zlfiM9hJyPOK+lnakBsJCyBtaU?=
 =?us-ascii?Q?zhBDg8/eMsrBPl/WpAlmITj12aWxhgy7PGxbJMuKeE57mTzWdBuf06SKo26p?=
 =?us-ascii?Q?hWr19G4FM+hk6Sbx4SCdqLOmOz69gHmZOu1O6C7Raa3Gi7qr+YkJcheIIXE/?=
 =?us-ascii?Q?BOYei2YC8nO9W5BGGV2YXPlL1XJ3FaA25+LIuCAbM1mEGqnT7OiFrvdt/ANl?=
 =?us-ascii?Q?3h9mFCwiZ4bDrifN+bKPecZuzIBcHl3slKoHCsbOG9Ju0GC7uOTUtPZfabvk?=
 =?us-ascii?Q?qNtaFwM8s3OhxvLMsD9sPEPl5YCJB6H6Ad+2PFamBl/vnM+9JHL2WBSrzh2f?=
 =?us-ascii?Q?PYbK+oBETZHGTZWUPyqdm25bp85wnSCx8LX17L7p1zdxQfdStRiwWqnoxCBz?=
 =?us-ascii?Q?lyB0hFeuryIGFZQ6sa2xNFaBNVUNVifQR3/RmX9XJuwWPc/MjtuPpIdUCKEK?=
 =?us-ascii?Q?3iRQPwufjYMNI4LlrWPaMsapUXQ3xyI=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9839b5-0fba-4c76-b555-08deb041d68a
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:16:35.3217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLi6p61kcGaAzXhh+IHvk7MnQsGJL2CNjnsXvkeX151CN+UkplARHkeOMJW02mgEgbeFVo3lBiiOrpU7h8SJzHsfEZAYYIjg+QWyCdz6d+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3668
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

Having scripts embedded one way or the other in the U-Boot binary
means they are automatically verified/trusted by whatever mechanism
verifies U-Boot.

Writing those scripts in the built-in environment leads to
backslatitis and missing or wrong quoting and is generally not very
readable or maintainable.

Maintaining scripts in external files allows one
to have both syntax highlighting and to some extent apply shellcheck
on it (though U-Boot's shell is of course not quite POSIX sh, so some
'#shellcheck disable' directives are needed). Getting those into the
U-Boot binary is then a matter of having a suitable .dtsi file such as

/ {
	images {
		default = "boot";
		boot {
			description = "Bootscript";
			data = /incbin/("boot.sh");
			type = "script";
			compression = "none";
		};
		factory-reset {
			description = "Script for performing factory reset";
			data = /incbin/("factory-reset.sh");
			type = "script";
			compression = "none";
		};
	};
};

and making that part of CONFIG_DEVICE_TREE_INCLUDES, so that U-Boot's
control DTB effectively doubles as a FIT image containing a few
"script" entries. At run-time, one's default bootcommand can then
simply be

  source ${fdtcontroladdr}:boot

Except of course that the control DTB is in fact not quite a FIT
image. The lack of timestamp and description properties could
potentially be worked around, but the no-@ check is not possible to
get around. But since the control dtb is by definition trusted, we can
just excempt that particular address from the strict check.

One can of course build an ordinary FIT image with those
scripts. However, that requires extra steps in the boot command for
loading that script from storage, requires one to use "configurations"
for pointing at a single script to run, and signing the FIT image
using the same key used for verifying the kernel. Moreover, in certain
situations, such as bootstrapping/production, there is no place to
load that FIT image from, and it is much simpler to just have the
necessary scripts be part of the U-Boot image itself.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 boot/image-board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index 005d60caf5c..6cbc489be01 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -1037,7 +1037,7 @@ int image_locate_script(void *buf, int size, const char *fit_uname,
 			goto exit_image_format;
 		} else {
 			fit_hdr = buf;
-			if (fit_check_format(fit_hdr, IMAGE_SIZE_INVAL)) {
+			if (fit_hdr != gd->fdt_blob && fit_check_format(fit_hdr, IMAGE_SIZE_INVAL)) {
 				puts("Bad FIT image format\n");
 				return 1;
 			}
-- 
2.54.0

