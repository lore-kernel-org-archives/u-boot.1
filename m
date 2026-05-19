Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC73CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 22:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD4578483C;
	Wed, 20 May 2026 00:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="EsJP8em3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95E8484859; Wed, 20 May 2026 00:55:10 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1C3084869
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 00:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKexIZPFq3y5nRB8sfazlpovSrSb0mwcRcZZA6mJeU2BmoUS7Tr87ZCPNrx7qDvjc2qhQ+OGXUlCElkupMKizlDYjMYU33IoPVXn3hcfBxUkP+1oUXDhtkIA1mWE+suHONcqU30tLyfzbEEsqNtZAqFPfaVnYgvRURAtNUeecOpaHn3+qIwYKFcaI8hMcqHBbicyY9IImMd1v2KYJKm7NS89Whg0VidpZyKBVFX91q6ngayzNCCHfb3gaL83uU+SddMV1rTrPaDYw9nHccqqsjD+yLG+4PFVwsSftw2tVFni+KY+Bm/WXPxPNqW8HurFVqNZEuLUNthSFgbJTcpuhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjEWvG/0VtgapGiIapU6b9jS2k02eUfk4jbA6xGpOZU=;
 b=DXYgdhgeje07rH+UmeD5BXF33bAdlALWWLSVIwUjte3lI1FZXHv4Ag8o0jZ9E6lG47f9CuzcVBFVMxSsFMame/9ihFtRfoNXx+tBvbRs63cTcEqjxPkq6LLvlzqCVOm2b11QcuYq8s9YQ1xBkO+iGk7GPEkv/NbwLYWg/WXXAgHFBjHUl7BNmMGEJE6JZ+chUo7L9NHx6hgCAaN25mSD8JH+jFSfJPyyAx4bmNSdJqvK6H9pCnn5DPfMw8NWzpybVH5pgldO2SsEfJfnSMeagpMXU7j6zFFbdQiId22a6fTfaqz+gNYc62aIO/qet6aQhPoeaHWpGBFx9PQIpQZk0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjEWvG/0VtgapGiIapU6b9jS2k02eUfk4jbA6xGpOZU=;
 b=EsJP8em3PoRHQQdbMkzGmwg583U+biWfB19pOSJRmwUHp3J+nJK5S9sAQbmRlG6fkNZJ9H+aDD+y0UQEbyumrlXAsJyCaCfytPoZysTAsmAGcmeB8BJmx1XcFzwS4GRYHOX4cjGzs16iqHLje/hX9ETQdBMfJ01nJ6n455GGJw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM4PR10MB9424.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 22:55:03 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 22:55:03 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 1/3] image-fit.c: introduce CONTROL_DTB_AS_FIT config knob
Date: Wed, 20 May 2026 00:54:56 +0200
Message-ID: <20260519225458.5587-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519225458.5587-1-ravi@prevas.dk>
References: <20260519225458.5587-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0005.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::13) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM4PR10MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 7956bfd4-4ea9-4a13-8ce9-08deb5f9a9c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|11063799006|56012099003|22082099003|5023799004|38350700014|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: GSmRqaL9NHiTieNE1b3IYNFvoG51/ofJZQZ2KX4Xv6kcwohH+F5JRV9Jj0HRhE6gRPZ4FKFh+upVMepYYJL8zn+hQWYC/+FkFSfgd0j4XV6TV8oEIY4zB1rKSVcIynDKEhyPNikCTSWMg7kHX8Rc/uTurWhEWPx3gq7WxZ88sMi9GFQDL9cTS63hnJuJ15KjTen6G+6DqYgPK21kqxBGYHosDzX4EAzGpzvBpY+izFuH37ZcjZS17rkp6VAIOrI7GNxVvfNDp+m+06D/Hy5fRoHur3E/GEVbu/aQSAMdt41I0DVSBvu2opbdfDOayM7IY2SRJI3eF2S5/e5P/zlfABGbQovnavzzfd0yMscQGZpBZrGirkgP3lfgoEWBuLbtXd4VZJuJ9nPGZi0MS3sDbZdqsAEFtUZIhNHrlKi7MJM+mTvkCDrpWcUs8uOVuvzvSie/hZDLmMIZpOMZC6ya4Hhhm97yZubkT/v6AxxxTgxiGe08zbf/tcITuXgGDAIxP5doZCGrhg5+at43iWf9NiY1uU8Npkecw60TKaxo+cV+2u0TYeNthjFjKdQ5vXTNVh1LfEWGNYoIoVHKIN63K2SDHID4S6frKgkkaNsninfyBkdfLcZ/9sROH8M9bUigre3Dj8a0mFk1Vd1Ho3A3xZcV/cJ9S9Vz7w2fxNgpZGy2gpf4UUbCF7JsHSGFijZBoUtQZ9TrvXmyqgV7RmoHfBYq96yZ/ijkfebiO7yZ9UjB/j996Fuw4AJxTFSTdmd9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(11063799006)(56012099003)(22082099003)(5023799004)(38350700014)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9uo5hmyl5xOEUNwVnAFwd3sF0tOS0a0YSC5nwDfGh3IRGViDPppCU5SBR4oV?=
 =?us-ascii?Q?AbbX7SJAibomuvf41DAd00p6PHxq7ZuMfAAQip1sZJ9cldCA1qo2iHrwdxef?=
 =?us-ascii?Q?cQ3WLVzP0TSk05TFZ5KYkw8bT+2qgQHKEVN0p3w17ONx11Dl6TlTwN7q2uSR?=
 =?us-ascii?Q?Zp5v6iXyV9+t+Rb/zfFPgJwolrELs3fzaH987wyKTO/xwKrfgSgv5f1gaRof?=
 =?us-ascii?Q?pr0vgtLDria2J86hA72o/TkDst+cBb1vZaayTA28N7X7NYn1AJqrLjfuqC57?=
 =?us-ascii?Q?f3FFlV40+vUilgzGSyLj8x+O202KYyBMmMcP6X6IjhSQim1o4D6+ru/wKFdz?=
 =?us-ascii?Q?E7HzgqzFtmRCcyX7sHMpR7jz6bRyvC+KUK+HUjFMsDHFqb3Eg8wGY0CicUWU?=
 =?us-ascii?Q?PQtLRQLqferaJlTXg0mPGRjhbdtYaff3ndOCdgvdHyVePcSnT8ZXLGbBIGve?=
 =?us-ascii?Q?C/exXtfIpk+MR+AtL9052rgRofwEwaLXE6/8lnEnAwtVjbVKNbbrgvm5oT1o?=
 =?us-ascii?Q?EMHbA8QaS+rT3PadS/02uSG7YPnSqJwoRmB2hifhKHQv3+X3mXWl/KYYWxgy?=
 =?us-ascii?Q?sXRSKUUd6z5Ly56g5qmh8V2jj/gKsgTMn8JdOlX7crCNfZ+KdmVq9Oc5H/rY?=
 =?us-ascii?Q?vs5xN8KM0VYjlaD+IGj38KtVFfEKBFRSU22p/8XL5rMgpkjSIy248mjFcVhH?=
 =?us-ascii?Q?nmE44qNPNaA80Al7611vic4RQR2PAFcSzKn5z/4hQJiW/1hwFnimwo0fPJKj?=
 =?us-ascii?Q?TLTuaqS3oovI8X5Khsv+CFmcr0awW4FUPNB1unUSyFyAq4pBUl1SucLqCrB+?=
 =?us-ascii?Q?F8C8GFTr7lmelOJRRoZHm7LNOaj9xGsKIH0EhhvioTDhN24EFRnVyMmQUxQ4?=
 =?us-ascii?Q?F/WRA2vCP4GxGG0V6YlRP64C9STSQMxDqRqDCBfAwF6jEd63CPDwUqkvysWI?=
 =?us-ascii?Q?RHTMvFmx40RFK9XZ6Reo/R0D+GXwnGi5NrfY/2St85/6tWllAqwTIwAWs4KA?=
 =?us-ascii?Q?Q/HiEOItGbzWzncH4oKeNPKulSIoFLlch9YDrRKCTAq7p2rUIJj4oEkDXjnN?=
 =?us-ascii?Q?v2iqNtPmYX0ZpcHKhmMGN92ZQnkWZa5g04mXJAYetl3qTs0tVZIhV47rhiua?=
 =?us-ascii?Q?OKnlmaFecx80pbvIWtV2Md6GX5S5LkdgZZ/o7zElCTUXNZm1gC7X8ZwXNkLF?=
 =?us-ascii?Q?ACKMCxVWVeivK+OwjWtnzdBo7tRWTJ1dOxSl1IU+7Vs3snohBJnxSlrChYio?=
 =?us-ascii?Q?CKtjVFk7HIssTHv07cqLboDxZBIqXnGw4YHDZ7rw7DuJnAmWWiR2ihDx4hsZ?=
 =?us-ascii?Q?rqy4XyuwMhCHsTEHDceyAdpvvvu3dgnKu3JcAWYk+1BiH3ahaGh0w5qoBxh2?=
 =?us-ascii?Q?Qt6PBCqMbpPiBR87ddMHU1DnLSBTBG36r2M75ICx22NPP8hWrMUzqcw1qKyO?=
 =?us-ascii?Q?3VRywpf7vYgmEtsSCSAtBTMhLNdL4qe1HmZWxwXcDJ4igLPOYNuRyYZVMuc1?=
 =?us-ascii?Q?4ZdrwJiA/h31j32g4a8jQNPBpwzBOG6gkFxLCz3YZNjpkdss0aVY4f2kLFr9?=
 =?us-ascii?Q?dMCXEnFV5DVz1MbkjCx24TJ7Hj0Z3TnQYB72oZXtUh8o47E2kTbR0AfGliaw?=
 =?us-ascii?Q?8/5F9/X9b7BHJY1DEjFAV0KezfLwYSUVBmjc/po3oay68yPjEUxFzftdnWh1?=
 =?us-ascii?Q?TExnug8B0G9b+aHU+/vHx/HjUrxibWuG05Y/9PQnJ5V1/caRIcbrCFpe1MXh?=
 =?us-ascii?Q?yIVJ7pXrxRMLBxoPsJvnrdp+IKzIJDE=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7956bfd4-4ea9-4a13-8ce9-08deb5f9a9c5
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 22:55:03.3917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDuEBgR3lMqotqVuegM5Qyik3tQ4Oroi2vb7RpWLbzAJyBOBl9OHVkb5IJxqf1TRxozxuOr7xNWMP3F9f52GPrW1zh9d8Cb6iZ2tAV05/G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9424
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
potentially be worked around (by just adding those via that same
.dtsi), but the no-@ check is not possible to get around. But since
the control dtb is by definition trusted, we can make an exception for
that particular address, if the new CONTROL_DTB_AS_FIT config option
is enabled.

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
 boot/Kconfig     | 9 +++++++++
 boot/image-fit.c | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index ae6f09a6ede..7490afe73b5 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -103,6 +103,15 @@ config FIT_FULL_CHECK
 	  of bugs or omissions in the code. This includes a bad structure,
 	  multiple root nodes and the like.
 
+config CONTROL_DTB_AS_FIT
+	bool "Allow U-Boot's control DTB to act as FIT image"
+	help
+	  Enable this to exempt U-Boot's control DTB from the sanity
+	  checks done to ensure FIT images are valid. This can for
+	  example be used to embed whole scripts in the control DTB,
+	  that can then be invoked using 'source ${fdtcontroladdr}'.
+	  See doc/develop/devicetree/control.rst for details.
+
 config FIT_SIGNATURE
 	bool "Enable signature verification of FIT uImages"
 	depends on DM
diff --git a/boot/image-fit.c b/boot/image-fit.c
index b0fcaf6e17f..a182320b9c6 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1676,6 +1676,10 @@ int fit_check_format(const void *fit, ulong size)
 		return -ENOEXEC;
 	}
 
+	/* For the control DTB to act as a FIT image, we only require an /images node. */
+	if (CONFIG_IS_ENABLED(CONTROL_DTB_AS_FIT) && fit == gd_fdt_blob())
+		goto check_images_node;
+
 	if (CONFIG_IS_ENABLED(FIT_FULL_CHECK)) {
 		/*
 		 * If we are not given the size, make do with calculating it.
@@ -1724,6 +1728,7 @@ int fit_check_format(const void *fit, ulong size)
 	}
 
 	/* mandatory subimages parent '/images' node */
+check_images_node:
 	if (fdt_path_offset(fit, FIT_IMAGES_PATH) < 0) {
 		log_debug("Wrong FIT format: no images parent node\n");
 		return -ENOENT;
-- 
2.54.0

