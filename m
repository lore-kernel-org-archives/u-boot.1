Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C61C83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 08:35:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D93F83394;
	Wed,  9 Jul 2025 10:35:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="PDeKHLj5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 211F083426; Wed,  9 Jul 2025 10:34:59 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7966A83390
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 10:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ij4LmjbFWxBRSJOkgofwlsui4hEx8Zqi/6VUDk7wkUFJf4p15tYFBwvi84poXYh3A0rbDe7MY+BI2MFkCH1U0ZWEV2PguWtNCTACvoZJIV9iA+mABhXqwFY+oAUtd1XJ9NkqPBB/GC+w3h22Njn3ykbiZQbaCBnG7OXSSfiNmFP5jlyQbYQ5YLxECQkJxqzcoLOZZVnohTWtZPJ7P0kmJqvBoSq3A3sKIDB8HxY/Js2mlMaoVbIWmHM/BE0xVycN+zekiyh8+muuG9ERECfp+xskl60k175Ifs95PTPeqGgGb5chZrn7P0u9szh03CMXkwWvJvjx8hKPCrdr6Qw3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lK6ZU7RW9Yvr2+TXvAwqtsJdI2AzchNm5jx9/jruFJg=;
 b=XONpOblNirOZiMv2RyLutAHs0cHrU5SSfOtZqfnAHRdsBMtPgCoT56phpklk5kmNxo7c5mgW7eVTm4kzKpjn1Xdq9/FDeSBV+9xuxGxrqcs9RoVq2/1ZGM2+Psk/7ATCXOAVyRF4wrOMlBPr6lceSB4pGgC7TJlC/NpO3OzM7y6JgWosLzJWR7auCVZDq7QPcfc+b2zbQT48s1eKa7UgF1GdkdDBNDDkmdp0b7csJgygOm4mvKjODqR6XSxc8wBPIn9aMgh9FwUfS5IrQLo3QNIQ5pMyK4j5aO0THyZnWcP7xXWVZIaQMb9qhM/Kp5U7okFK+TTWYmiPgybTVf7+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK6ZU7RW9Yvr2+TXvAwqtsJdI2AzchNm5jx9/jruFJg=;
 b=PDeKHLj51OLsaYEzG0eyR2l3zOT95FVEP6e8tgIZT+SU+oKBeqwZ3+UQ1g41MjaKORg0B7C1OHF4iKIa3FiFNrv6lqLzyJVr5x+njTfZuz3SrjDl5yQ33QE/3OQyum5NHxLjuGqae1g+y0CX8OJ6ced4P4V/DcpfgnqA6DLzy9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PR3PR10MB3771.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:47::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 08:34:54 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8880.029; Wed, 9 Jul 2025
 08:34:53 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] tools: mkimage: make size_inc a signed type
Date: Wed,  9 Jul 2025 10:34:49 +0200
Message-ID: <20250709083449.656724-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0098.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::30) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PR3PR10MB3771:EE_
X-MS-Office365-Filtering-Correlation-Id: 251ef782-fc7d-4de5-c4a2-08ddbec37a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RzcKSVKJkHl/dETTjLKZ+3oXIwa9V5UJXLsgT6d8vs0mxKzmDT8EBP1R0D0P?=
 =?us-ascii?Q?dHUzb0y0qMLnxesU1RIx2tnzRcklQ+HW48B+noE9rA9cXpFo77pk0hnVkWTC?=
 =?us-ascii?Q?wknPz//i/LQbbUNrWNBc2FUo2alrzk83FscCfe+M68rTZSL5JbwcZfesBnYD?=
 =?us-ascii?Q?njUDe3goJcQUUYAhU/fuEDU6Miv8PbbOnNQcVvLLrWnXr6kSS+YzgPtNhn/U?=
 =?us-ascii?Q?1JpSi45w1SYi4DlH/LWvDc2daWpLxObGVmPQmP8kDVWP9KpU+3LcDwbCpoZj?=
 =?us-ascii?Q?xb6VtgHZ4LXbdAtT3OElhxf2c8xe+cepjr0pGdN/bqltebVdp+1CMZ++NL2P?=
 =?us-ascii?Q?TB2uA9m0Vz1X0t2MFpVa9m56sj0jBTD/HpFtwjstTIF1PrlFZdAdzlWgutKm?=
 =?us-ascii?Q?7bR1TXBYgYFPJgoFmIQb7xsASS7bI369epk8xJE+vZKwzpKXV079YNjzVqoF?=
 =?us-ascii?Q?8fr7HUk5vphma4s6ehhkr13Epse1rOmLmvNqv7Kg6owEk9jzCcJY4mGQoult?=
 =?us-ascii?Q?N/C1dCY0iL4ch0d0xvtEGLojWI6j632dtc5Hw1CzOXF5bep7MCy8+FdJQehZ?=
 =?us-ascii?Q?M+IJ2O5ogCYup2nbfgb4pxaFLxvbacFd2zOPLb9zU/8+oLpEH3rdMPRy9VHL?=
 =?us-ascii?Q?nSBChOSMiW0CzLZLvt2CYHvb0jdgfCcOhlN9vnHKUPio2RHDLBAD8lqeLC1d?=
 =?us-ascii?Q?lKM7i634i9kyK2R3VPO1HlF9dvmeiwQvloftHsvI733E5SmJc6786DrMItX7?=
 =?us-ascii?Q?xSQmpY77ulWdNCouZxjbkBHfDLvY7Ke4eDWpUCS71b+UmFUTmbmLjFcmWsu0?=
 =?us-ascii?Q?4V067MLzj30UjydtOzfPQiYFcIK1DgUXxCVSiWrpxTgHkqr148Gi4ThGIWNd?=
 =?us-ascii?Q?f5t3+Q8j/BCLaASmUj+kYZt2f1Ks6YfTORyRee2WCQKr27HGScN64iSlCI/Q?=
 =?us-ascii?Q?sf9fAmEVOroqCcw79F+39HJRoUeOAnA0ra1emOKInsLU1o32kqLz4UgCZihh?=
 =?us-ascii?Q?ZeyYHHT7Ed62ERNBXsr/3F5Dc3IFsgovoN5mQwabITJ+4tbjViof+n9sdtFw?=
 =?us-ascii?Q?3GkGlXsbXN6GOv9LAwmg7E1mtzBe2nW42pZRnAmU3zn4u9WP8f9P80AZShk+?=
 =?us-ascii?Q?LZ69ryQ7WOJi1TBn3b1fSYNmcJJqHHDy36DrhH75F722YHyzXXh+l7TPouGj?=
 =?us-ascii?Q?4p56TPrFXwvqsTdix6DV27MTM/SjZtYRHkdk8GJ4gfToE5qmFWAnq+AB0d0/?=
 =?us-ascii?Q?3l8FvyMU8TR+pck0PMYA3Cz/lUHMl/tfWwLUGFhHPPAhoCBdIkwSlakFcs7Y?=
 =?us-ascii?Q?dMd3gtAvjJBoBhy0DQMAOiNO5BFL39JN5nS/uRB53QocqMiv6NeLvR1FCUmO?=
 =?us-ascii?Q?XmjG6UIpD9DPXEOwfmtHLWm5zKV2bs5ktT+Ud2rrr2bTkZ8xdGCfzPkbjMGP?=
 =?us-ascii?Q?KaKlcwtCfH+C6orKyuVUvl3j+vK1Kip7TA9xQ2EoEydrxz24LHM/CA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?22O7wxnKSU+sqqyZrdaMxHhlWDbw0ySopUZwL8i7Qf0JsqjhE8g+3ovgQSvk?=
 =?us-ascii?Q?Yh3SY2NtjCm4VNYc1dsX6X3P0TSrLNmeG3MrA+JmUujThZYA65pF4zI6qmzo?=
 =?us-ascii?Q?tcnFEzok50C+jpvKyIRhRdx0YdpM0GQ4hPd9kzszDZN5S8gV+uWNvokeT2Sl?=
 =?us-ascii?Q?zmHlFdCSXM3dlvOB3xKkjBZaGvIXNnLeECaqOKAX9X+sCOlj/0//Gutst9+o?=
 =?us-ascii?Q?T33R6cJNB+4z7Ng0W0DNrd/FjiP2b2TGiWyxlSQA5a1Ntnllj7wLNbpLpDB5?=
 =?us-ascii?Q?ELACPX3B/qFW0OSWPNYefCfLfsVgobn5CRQiCs/jO0+NuimvcFGEY+Om6VtI?=
 =?us-ascii?Q?K7KULDLD+WXvnUiqmZ4gIOwJANvp0hLqmdNy4sI52wtR1Q2O3OtSJTNwJMAD?=
 =?us-ascii?Q?ig/Yp+KpZpS9suQiM4fAOdYi206EWIXiKCyF9U3Ojc57U8HXgQUQZdmj0eFy?=
 =?us-ascii?Q?5UbEHR2+F+G1vBiIIP847LHNwuPG1oc30wuU6m1chbiT4Hp/OP7zXgmQTCDv?=
 =?us-ascii?Q?2UXiUcSMa7S61+WSB5dZC/ZBJyQBa33djg38VOVVMM0HNBrpnoMG8TPdRjhy?=
 =?us-ascii?Q?ZU1I/rtwkYu+gf0Sl07SycrPz39RWt2Yys/gWf0VQ45k9GxMeTcJwvfUet/3?=
 =?us-ascii?Q?bhENkpBDJiskEsVtyJFsPYqVafxZ6/ZfDSkVoSp4UCFCjhf6YIDciQn7YShq?=
 =?us-ascii?Q?gJMQbM1cDIvs5PlDQTCPF+rDvf6SvBiwSNzVpY5RIsgOCblRqu1KOXGAOLVz?=
 =?us-ascii?Q?D/hLebnl4DbY8eWfT3XNTQco57nN8A5XLPKp8tbFPGoKPsz/NZcc8bdL6Sjf?=
 =?us-ascii?Q?WLOW8IK1BDx76pjnw5zsL5aftOe0C3fS6IP5S/6ziBktgWRDouOUna6cr3d9?=
 =?us-ascii?Q?sbTaqvOyyr2X2YClRT31Pl/rOCYHYrbEmJqZ2WfyKcIo+TpDypnlblCncT8e?=
 =?us-ascii?Q?Do+w32EvzxduwCr8bzCrmFK5QZVCkHlSlBRV40VoAdxVvjxxDVIIAhdPqBK5?=
 =?us-ascii?Q?p+EksbZokFSRZG7iSC0mAhKnL9FW90orkciFoFD15KrP+GHzjLVn+1fvNCSQ?=
 =?us-ascii?Q?y9E4oyKzgjNIAwCcx3TLtVW54fb9bKJh581TRJ6b9CYxmusZgGr3EJ1mrAqs?=
 =?us-ascii?Q?+S01zldbNHR+rCMvkBQOA8K/24ahiK9OX+OhfXL/rXVZGTrFqpUwd/nzMOeH?=
 =?us-ascii?Q?InUAmmpQ2SCMUz5MvuW8DzjWmcR9mNMNM/smqpLzJRzztrneM6EQ1R1NX4Gk?=
 =?us-ascii?Q?pXWQD/nYsSgvPRannT7GWDxDlOCWKN2E0U4gI198+7txfbEz5KLf2i9t4BmQ?=
 =?us-ascii?Q?bzbJwrLAacCL7HrZXI6Kqa17Isw36go+KydYO43Rfu9xEdzNKAsWRTyk8/eL?=
 =?us-ascii?Q?OWYy3cnyif/3+1+biw4bY8PqNvvwGWhT8uhoFzwME0PEiJ034uUFwMx88sZH?=
 =?us-ascii?Q?2OgD5kPCIwEPs8vAObcJYQGMFcRLi03OLuSSYkBEZWJqzz3bOeJYYEtPkiqv?=
 =?us-ascii?Q?3ZQeLSTX9sB/C6eAli2ECs0XceVjmVPMqxGiBSZpdiq2cQxoOKYyBF5zE8Uy?=
 =?us-ascii?Q?sth1IxwLSeqXVF8mObJ7NqcMVg5KbAKaLRi1gqFmxmKZA/zPwgUsc9Gjkv90?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 251ef782-fc7d-4de5-c4a2-08ddbec37a4a
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 08:34:53.7830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOvUSU+Oi14qaON3rC2ar+UJD7+1oe/aAr3r2FwQxC27R6ift6bcVDPRypFeNi9mzVRz5Q79dAOx7JHDnsjvcKjDJrXe+RfgRBlAHaocu2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3771
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

In the Fixes commit, I initialized size_inc from the return value of
the new fit_estimate_hash_sig_size() helper. That helper may fail and
report that by returning a negative value, but I overlooked that
size_inc had type size_t, and hence the error check doesn't work.

Change size_inc to have type int so the error check works.  Inside the
loop, it is passed to another function as a size_t parameter, but
that's fine, because we know it is non-negative, and its value may be
incremented in steps of 1024 and is capped at ~64K, so it will
certainly never overflow an int.

Fixes: 7d4eacb0e68 ("mkimage: do a rough estimate for the size needed for hashes/signatures")
Addresses-Coverity-ID: 569495: Integer handling issues  (NEGATIVE_RETURNS)
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---

I'm a little puzzled by the report

919     			break;
920     		}
>>>     CID 569495:         Integer handling issues  (NEGATIVE_RETURNS)
>>>     "size_inc" is passed to a parameter that cannot be negative.
921     		ret = fit_add_file_data(params, size_inc, tmpfile);
922     		if (!ret || ret != -ENOSPC)

I would instead expect it to point out the lines

	size_inc = fit_estimate_hash_sig_size(params, bakfile);
	if (size_inc < 0)
		goto err_system;

where that < 0 test is currently dead code.

Nevertheless, there is obviously an issue, and I do think this should
make Coverity happy as well.

 tools/fit_image.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 8717dc9a3b1..ad0ffa39c6a 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -846,7 +846,7 @@ static int fit_handle_file(struct image_tool_params *params)
 	char tmpfile[MKIMAGE_MAX_TMPFILE_LEN];
 	char bakfile[MKIMAGE_MAX_TMPFILE_LEN + 4] = {0};
 	char cmd[MKIMAGE_MAX_DTC_CMDLINE_LEN];
-	size_t size_inc;
+	int size_inc;
 	int ret = EXIT_FAILURE;
 
 	/* Flattened Image Tree (FIT) format  handling */
-- 
2.50.0

