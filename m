Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627B9C47BE2
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 11:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D532483F6D;
	Tue,  6 Jan 2026 12:11:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="rHv82HGm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A883683F5B; Tue,  6 Jan 2026 12:11:16 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD72483F5D
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 12:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hq8DVjLaGB2lpOHmGT9+04XEYvHm+DSoVvm4Fp8MEl6Kl544NWXodRAUcS1ECxP4yXSiQXA4I4Eudc445Z3XCPpPrpVhkLEXP3974AY1bk7Za9AK2CWPdhEp7B6PzaI6sz2hiv9aOEI5wnUY+DcsyefMMSsVe4aFc9k9S1kXkw1PYE5eSqPhLBgEYGY4rhG1OIClOG3IqPI3GftVO4swCHsXSc/a1k2vPjOhwA6egP1Cc0d0OlmVuBEajD/9HpMycfuSligTqbIlIvtKGh3m/Ux9fA6rlwjLf12JMHBfG53ma88z32rXc9oRHB5tH8H11kPnQukyz3URA5P44Fi44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37dpBE66XkwrqWOAYTn9Qfj3xU/Lq1grJVgYr3dottA=;
 b=ZN0RgvEvvc5ft/gAhqgizTuwIFzsdIkIPy8aV0wYwgYFFKEIl36nmIzozyK5dnRYUL3RqkTCcA7mn7akh1jYEM6MIVcDAOFe1md31jM1L7VF3UnWz7YxppcNSUip+rIZyoZEWmtdFc0GtlExv/eX11FXzaCc/5RbAPZI0kaC2+b4zziIMabrY1h1nsBkx5kJQggkgW+zIrc7VfbZ7nCi1boJM1Iat0zl9YfBB1hL3bWe9FKQDJUjFVM/aHWOwx0ScYcXhJgZT74wPZvkvUuOoV/exAJ3Yq8We8toThDo0g3M00HjD9b96YuT2ejbL/myR5VOO2wRZ6+9W7mClXnnrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37dpBE66XkwrqWOAYTn9Qfj3xU/Lq1grJVgYr3dottA=;
 b=rHv82HGmtWBxxpkbJXpChhopFnu8lTJtLfW2EBLMCbgMtzVMc8nkKIZ/rrWtp9xiqBMKFq69GF17rBZzRPceNL0BqpYN2uD8bnbIfpAa+XwnKflZTbab7ATIfMb8o23nl4RZ0+DmEgnB7a3Wb3uq9/aEuJj3Epdb9dITR8nLFz++z1cAAwMZHkpFgLUD9BiFb7IWWzItGv4r6/V5hmJqtkTYUUB0lLELaXmm1gZecaIAwlg5hsGCS8E5e/bY5eNJPl4p2s36yik6EHimLrWUCJmQBwJLzSKdHjuREQNf/PFgoU5i6u/th5sL7XByuKViP2JcdMtZwebmWph6Atgagg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AS8PR03MB7302.eurprd03.prod.outlook.com (2603:10a6:20b:2ec::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 11:11:08 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466%2]) with mapi id 15.20.9499.001; Tue, 6 Jan 2026
 11:11:08 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	trini@konsulko.com
Subject: [PATCH v2 3/3] test: binman: Add test for pkcs11 signed capsule
Date: Tue,  6 Jan 2026 12:09:59 +0100
Message-ID: <20260106111034.889964-4-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106111034.889964-1-Wojciech.Dubowik@mt.com>
References: <20260106111034.889964-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0060.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::20) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AS8PR03MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa61e6a-cbc5-4e86-a7dc-08de4d144ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|7142099003|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pWW9+toaxBpCXCP2jNMDTXWb5kH86KBYEhfbMpYubjeelxXI6wEwg5uybkRC?=
 =?us-ascii?Q?0KgLnN0YJwLDVHlg2bn13qMe3fFBZDGcrhL//OWoip1JXMg6Wf+lzvkzcQwZ?=
 =?us-ascii?Q?WiUAK9/HiiL/fgdFrhmlEsrlmqoHijAN+6bGyYiup+Fzc9mM6QlKHaAbs3lv?=
 =?us-ascii?Q?fI7BBITUmgVercLAo5zJYRCuV78+7wrjjUboi63D1g/pel1n2b3QhpXEj+uT?=
 =?us-ascii?Q?va+U4+ncuk76hV0utGIlLOgmowAfq3xc44SsvUoplWmz7WuzSty9TfQGUXHq?=
 =?us-ascii?Q?+Wk6p/zQxL/tn1pynEkAWFgCDEqXBH8kT2nT9IEnaaeYyY7F/g7Y1NrZt9Z8?=
 =?us-ascii?Q?Dxixb6gABt9u50YCnDsOa1VKphSFZBk//hQCw1MjsXgoA8Z/ZFhtR5E12Zik?=
 =?us-ascii?Q?rePEFfzboTfIIFzBhv2nyhHSLhrc5lv1LMGhnXN4H1P4mnomIx2AmEbHEBqL?=
 =?us-ascii?Q?2QckeLZ94XFFL0aLn7KMX4lOqNeansw3GyWbempJMzfV8FeUtUtqnZZstIN3?=
 =?us-ascii?Q?WTbPvMprCSoTn44aPWItC/c6/lcyPDlM0RXB42KoAQcKfRgiySkrqar5KnJe?=
 =?us-ascii?Q?O9NgrHIN0FTgUiL/b4C3M29f46gvpUBkAZ1DNcmx7wk0gfejytOaIkskjZ3E?=
 =?us-ascii?Q?0iHLoA8OBVwclP+gbuMnD7UxnWJtSEiiCH1SFmBNuPfbBdYc/E5cyaHApTGP?=
 =?us-ascii?Q?ggkP2uE0eTkWAUMH5aj0Ew7dmFkdqbEr+NAXZXM5oWcUThnHloNORHSFG7CY?=
 =?us-ascii?Q?zd4pNusaSKG1Fm2pWQQNTAq/xU6RWbA1QSOmHoVtiFT/D4TMlX8Ekbo/Vry4?=
 =?us-ascii?Q?w2mI0Q+TWj3U1VnhBicnqvdAFO07W9eAT6rhkyCDitygYqNVD1hrnBdeJUF4?=
 =?us-ascii?Q?YrBM/LlUgX4i636+K+iZdNG/xVLHbd0ECgpYW5sZ6CcxUdLKz5dWPgLyBbII?=
 =?us-ascii?Q?oMJrlWKLoPbAzfZW/jjxs6RawNTEduzY2qeMmGuJoeYu5moOeQU9/4Fpq394?=
 =?us-ascii?Q?RqqRgAi4XJfWauUedTaFFYvAO5sndUtvKJtZZu6NgI0XX9nrkHLzV392h6OK?=
 =?us-ascii?Q?70pjsv0Irdlku8X0gUcWaSwKhHBOFI0CGMdpaLkNAIU5/gS8p4uBqJ20nNkq?=
 =?us-ascii?Q?tkTTFUwEN36zrfZ2nXCSkYxbUhe5nQM2cOlPvxpAMXqJcJVU7IIbi5OGvWMQ?=
 =?us-ascii?Q?Te6OPyHF+aj26ujdN6dwYh8Plw+0E2TRv0FgVgfqPTR7qhZudzT9/Epy8PIc?=
 =?us-ascii?Q?lF5xXPDPeihSrtm3YpEfD6IzvsGM81sPaUG9sGvTVycMC31sYmxfViwBh3UK?=
 =?us-ascii?Q?y2jPTDZ/NBMVS8VHkapO7O/L++nHkcba6tnRw3i8XhU2z1+wjJbb4SfPTME2?=
 =?us-ascii?Q?Vp1741AQf6KdPUCtQrc3pDbbd9PBaoAt9XWXLIPDrlNJT4OpUasP6hINdJlD?=
 =?us-ascii?Q?NhRb1zmM6Ndsb/h8jRZZKLDDGU8NwlSzq2WRAiftiTRN3CuHiGV8BekCruEi?=
 =?us-ascii?Q?VXaLVD+66HpqGmzvBvcdWbUUAIyorskny+Y3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(7142099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lnJiG5BQ4K2ac4aKDfV2EXSAuGtf+26pfsRoKvp/9Q3FWexCqRRTixGwvPAe?=
 =?us-ascii?Q?6GR99upUbJpzaX1wmeUSC1MvdFvLKoc99pPua4glogKA47AkxZbM89wlNSfG?=
 =?us-ascii?Q?kUMJqCoQPSxvuGvcP0cyt5Z2LjvCdP1N5YYH/arkbty6Kr1QaiY2WsjDk90J?=
 =?us-ascii?Q?hRCZ4I+b4fhpe0Qb1ybI8bHUG+r7nq9q1Y/AlcpMYhJmsvRAiZhDAu1imqq4?=
 =?us-ascii?Q?RNAHRhUgWxd8Bmy0IwXCzrEThpHAeJ1/6ZI/rTGzK744Xj1R0ZMhPXi9Cv4p?=
 =?us-ascii?Q?9A6kA5VHWH7xS2/ni+Y3pV2TFG6l0MKEq0U5PgJZ5DbvNQSQNA08VusZ1Nv1?=
 =?us-ascii?Q?uw+GaneWfETmNnun1gdpA0JvMSMTTGe5i+GMiMq6XZBsjVi9f3koK3ozqmBA?=
 =?us-ascii?Q?QQ33DgjsgLfyo9IMTAshQ6pefd4nD1D+Fv2TsE4VRo4aEKrmZ5dWXfyYQJQE?=
 =?us-ascii?Q?/2LYFgyiSYt6srn42sDJYX5sM8E+bmOA6BJDuRyGkpfb3jBnu2b4y8+AZusV?=
 =?us-ascii?Q?nYU+iaQwZrssMTwIVxoGQfRpKZCZxlOTJ/pdw/3TOV9pU8093BSbZ/4qWvVp?=
 =?us-ascii?Q?ZUWkQ++vtAP+74/wgflHzLexZfGEHF8mt5WXmJpOl05MDMZ/+Eca4Nbut/6A?=
 =?us-ascii?Q?JdRf+2V71dNEscE7xvCxYBn1jD8QZQuQIqjFG9t/1o+KPaOgoOjg9FYCRm04?=
 =?us-ascii?Q?Z7/hWBFpjZLhIAELavI3IkSdsH2I0auYwkIYLZyR/fUB4dvFa810JaXy5bUv?=
 =?us-ascii?Q?KhYXAc1qDznZo7sL8WzgKMXMHLmOQn/g93XShMXsYl+5eQG3rwbUjuhWdzdT?=
 =?us-ascii?Q?97uNaS6HfmIuyw9SU6cyI/4PlyYiv5mTELlvp/PI1O/0KIfUuCj+x/1xielL?=
 =?us-ascii?Q?XWz4HefbKiMJPISxhC4wTRa7cTKCLgk54R3eV24oShzbo0b+6hzjUVE0kCTJ?=
 =?us-ascii?Q?ejBtw3mfx58tyB8IpgNxkZDDmggioaHNXUQnggeV3Zph5Mzo7po2KDtWNqGD?=
 =?us-ascii?Q?2sxCKdJUN7lcz2jOfmzZfXuKn/nOXwSM+GuWuy5NH5kcO7QbDKdg5+hq/UVy?=
 =?us-ascii?Q?qgiqsG9mdEx83ofpy8HL/AbPOcNOOy05YgB/6PwPVU8RLojymgHzdPSLTQiF?=
 =?us-ascii?Q?iJhViGOAmv6jjrob2sKxOOPmGMG4xmRzxCgLjNAFh4+Rq3xX27jQZuGG1eoy?=
 =?us-ascii?Q?z7dVo6o+hRzBkZT2ds118XjeiFufv5fq+f36wzXxOt2CkMheDJuuP7q+d2vC?=
 =?us-ascii?Q?jDEreqDrHzPHSIzwVilobO2+S8OUr/h1sdxaiogn74Z0ShCPQ48X+V+A0SAp?=
 =?us-ascii?Q?kDKFoiEAEtXfxr/xzKzWkBykT9xiaU323T4KGatfO5Nb/jwM0BilI2TvkWT/?=
 =?us-ascii?Q?Fys5vaK0gOiMxpH2ifE3uQ6M8hpAhekV78fPVxtpolH2jp1oOdkBzeRhTqdl?=
 =?us-ascii?Q?OvzwnisebP1hJGD28Vo9LUqR3xSqLcPpN7zzREdSGaPEtnB5KsDZJOPOgwqW?=
 =?us-ascii?Q?2/5nVriVh+IRnurdUBzfnMHHaZ5IneF5qTsm2LXDY8qIPyipNlwKyv5U2zL3?=
 =?us-ascii?Q?KILomcWky83jmF1BgsDORCEy5XqK77Lz49NZqcjJM3iRRNdYqE18q89otYPZ?=
 =?us-ascii?Q?CthdM3e8guXaKw/0OBYwb6nY6uT7YIjmCyw9l2Oc1EHMBUUq8yQqRZhb5pTA?=
 =?us-ascii?Q?IC9vm3Jhlhus/DXK2mxsM6naK05ALmpDifd7vNtMjTKPCxjpXwH5/6hDR49Q?=
 =?us-ascii?Q?OGxJhq2XZw=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa61e6a-cbc5-4e86-a7dc-08de4d144ac2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 11:11:08.3087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqf3B7DTM1iwQFMFi5IaqJ6IHMU9xrxAtTEFbl/ZqEE4Nxh7VIQlSf6CYa+x7L/dZ30a+Z8XIpPDUAlY4XIu6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7302
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

Test pkcs11 URI support for UEFI capsule generation. For
simplicity only private key is defined in binman section
as softhsm tool doesn't support certificate import (yet).

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 tools/binman/ftest.py                         | 46 +++++++++++++++++++
 .../binman/test/351_capsule_signed_pkcs11.dts | 20 ++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 21ec48d86fd1..cb5d69982772 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7532,6 +7532,52 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         self._CheckCapsule(data, signed_capsule=True)
 
+    def testPkcs11SignedCapsuleGen(self):
+        """Test generation of EFI capsule (with PKCS11)"""
+        data = tools.read_file(self.TestFile("key.key"))
+        private_key = self._MakeInputFile("key.key", data)
+        data = tools.read_file(self.TestFile("key.pem"))
+        self._MakeInputFile("key.crt", data)
+
+        softhsm2_util = bintool.Bintool.create('softhsm2_util')
+        self._CheckBintool(softhsm2_util)
+
+        prefix = "testPkcs11SignedCapsuleGen."
+        # Configure SoftHSMv2
+        data = tools.read_file(self.TestFile('340_softhsm2.conf'))
+        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
+        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
+
+        softhsm_paths="/usr/local/lib/softhsm/libsofthsm2.so \
+                /usr/lib/softhsm/libsofthsm2.so \
+                /usr/lib64/pkcs11/libsofthsm2.so \
+                /usr/lib/i386-linux-gnu/softhsm/libsofthsm2.so \
+                /usr/lib/x86_64-linux-gnu/softhsm/libsofthsm2.so"
+
+        for softhsm2_lib_loc in softhsm_paths.split():
+                if os.path.exists(softhsm2_lib_loc):
+                        softhsm2_lib = softhsm2_lib_loc
+
+        with open(softhsm2_conf, 'a') as f:
+            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
+
+        with unittest.mock.patch.dict('os.environ',
+                                      {'SOFTHSM2_CONF': softhsm2_conf}):
+            tools.run('softhsm2-util', '--init-token', '--free', '--label',
+                      'U-Boot token', '--pin', '1111', '--so-pin',
+                      '222222')
+            tools.run('softhsm2-util', '--import', private_key, '--token',
+                      'U-Boot token', '--label', 'test_key', '--id', '999999',
+                      '--pin', '1111')
+
+        with unittest.mock.patch.dict('os.environ',
+                                      {'PKCS11_MODULE_PATH': softhsm2_lib,
+                                       'SOFTHSM2_CONF': softhsm2_conf}):
+                data = self._DoReadFile('351_capsule_signed_pkcs11.dts')
+
+
+        self._CheckCapsule(data, signed_capsule=True)
+
     def testCapsuleGenVersionSupport(self):
         """Test generation of EFI capsule with version support"""
         data = self._DoReadFile('313_capsule_version.dts')
diff --git a/tools/binman/test/351_capsule_signed_pkcs11.dts b/tools/binman/test/351_capsule_signed_pkcs11.dts
new file mode 100644
index 000000000000..c8c06805daf9
--- /dev/null
+++ b/tools/binman/test/351_capsule_signed_pkcs11.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	binman {
+		efi-capsule {
+			image-index = <0x1>;
+			/* Image GUID for testing capsule update */
+			image-guid = "binman-test";
+			hardware-instance = <0x0>;
+			private-key = "pkcs11:token=U-Boot%20token;object=test_key;type=private;pin-value=1111";
+			public-key-cert = "key.crt";
+
+			blob {
+				filename = "capsule_input.bin";
+			};
+		};
+	};
+};
-- 
2.47.3

