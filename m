Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842E5C38150
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 07:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B523788715;
	Wed, 10 Jul 2024 09:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="TXijItGb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0B8688715; Wed, 10 Jul 2024 09:17:43 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94F2E8871B
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 09:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Omd1AZsLqztmKMEulMtGj2m4D8sX7TuwDbFHuWKl5M25+GIjcahszoRTy8f6k8EV89/77CAvvOIWvsNcy/b9LvoxtX7LkmQzRtzEoLFI0k2df/CVBO8qs+LFGG6i0l4Ml7SgiOPLPLRBwsJehuksMLFx78sIqQJ4oGMvN+69Xan5MkmbXE4K7sy6tdpW+eTF57BVSrsKaBes7byD9Z3DolSi8M4fSRoIOZrzhNbPgMgtUN9B+KpZ642P63dDkltwBzlcwsFWXTba4BTJSwAHRtR9O5NrKNKRq4hfZzS5mszrh3Re+gXDZe2sQpFiksi2jzDdOH05JLA9uCdmoEFGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HkmnCU9ax2nIbZD47/0VID8guvEFzBgl8JoFoTq+Yo=;
 b=oOnXdIjX+Vt8COgH4g6FysZr5nRpvpA/yScgjAmqyQhS6hysoiZ9nGtkPU+1tI/4DKVgnLT1fkrRzz56xxsquotgKVIB3vcgzk4H2S/5DmzPnAhAgsNogQrK3RDoxNbRnp+wm9IWW3ksBC4k2HADwB9upDABHiaFWLEtgKMvv6StkePQActzHZU1gRl7z7xjgsuV71yfqb8Xp63WGRyMlTUqIhq6XWy54BBnpKupiwmI+iIZryQdtlmbM9VVT1Mhz/opv+soXdCYrbUqyHklz53bf6szUU2FUq1mSlecUOskhcrksoYdVHIduIatOCRzTSmoQ+b+UcswkzhY5w3Qzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HkmnCU9ax2nIbZD47/0VID8guvEFzBgl8JoFoTq+Yo=;
 b=TXijItGby5DDz1dKuZf7YMCYYsUsWLZcP89BzQQ4Dal9g+MZTvI4rHGhh6awnE2K6r/078E51FSAcMxxPhCt+sqpKHusIdwztWeC95J/prBJ+NcDLXX4t6DiwA77y81xEltughpfBiQBFbuQYmzJpFfiPZ+1UJNVVfElsQQGXAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GVXPR10MB5885.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:68::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 07:17:33 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 07:17:33 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 4/5] test/py: efi_capsule: rename device tree overlay
 source to .dtso
Date: Wed, 10 Jul 2024 09:16:11 +0200
Message-ID: <20240710071612.1717460-5-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
References: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0084.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::17) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GVXPR10MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 92162d1d-ad67-419f-8883-08dca0b05e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BEg6vsokXKx0VyQbzlHVLfEeKFeyBY8ukcAxkWFSelGQCjnsntIvV7o8uYH1?=
 =?us-ascii?Q?ovga9KAuA89SCpWnlPmwfXdrefxAV76DpQy3R89fvHzRzGRthYjXk7tEfbXH?=
 =?us-ascii?Q?U36KnvjumoKWtHPk/xWeBMcwEVop4ffisUMpsCmxxKiZyi5OZeFH6XluvXrW?=
 =?us-ascii?Q?+J6uq6IO+6lzCqoEvDvNxZYf5lwgtmHaqZ7A9x4RBFxmF+ReuTooa2TBa/N4?=
 =?us-ascii?Q?wtugNdvgql8PQ9ILkTaFyav31s5OzKWZqnaUtmkjX5742UOOuOF/48vtsnFm?=
 =?us-ascii?Q?53lQCUlzTxRKiPp0J2qmOL1VyL3mwbBn/58tjA0nhR7GgEsPKvbkZDm79pHL?=
 =?us-ascii?Q?u2b40KNRdC+5kMsYIUTCvzy6aB8XtLEvux6cYGjJiQzGowMrENc9w1PWZrFT?=
 =?us-ascii?Q?N+cUp+RlqwlYJIidZejsAIBEnBxJSKZeD3fkeYPhzYGDdu7MCToZ6cewT7HW?=
 =?us-ascii?Q?vuPGM2KayvQj0yTGrA23vANkUPf3ix17s9bOeZ6n2Akg3O47apvD5udt0YiH?=
 =?us-ascii?Q?fnKr+PoSH4pyI8hRu+9ofoARyPpX/4Z9E1Dw6dYq5oEE+C4pX+NZg1shkaWo?=
 =?us-ascii?Q?p9QuyeLzvC0vTUu/cgympZBSLJREkjasdD9kqY/YzniKTFhmIuF812KDJEw5?=
 =?us-ascii?Q?nreSlGhupJiVIvtnYocXHhIn763wTXuZPu1E3HwWfHkCCk67wFblTeO3U+2Y?=
 =?us-ascii?Q?yjFcfqKNb5VTTXAwTC61t68U8jpDZ+gfnEfc7tJJtWfE5AsP2yGr9FsqWbg9?=
 =?us-ascii?Q?e/iyMSrXaRqUPWxjBsiMQCwcG4BKPucvELAP5yKb0LaWZe2iqqwd7VjyJvxZ?=
 =?us-ascii?Q?fhJJ9JsUgkBNYFpt0OkzpXADi0P950PcDsbAzesZOLxEkABscaqlLS6Kb+6z?=
 =?us-ascii?Q?QV/pOrDLQzuAoZZb6/48oVC9pANYFTWESgPIAWPrennYIYFmfbCo3yjrYI6B?=
 =?us-ascii?Q?5aua+fsKqv3u4x8MUGByi909Sz/C34vU7rYSOkmUg2gRT5x5ioq8siirHS3E?=
 =?us-ascii?Q?bgsm0x/hDUF5quAsLyHonFVPjvdv3zBkl5WKU9vjzxF1usOzrCP6+0SV5wEm?=
 =?us-ascii?Q?aQDmYjxRqhhb1rFKVW/6Of5QU2mG1szZCpbqYwMgIwCqki00yFAQJ1XPqL1q?=
 =?us-ascii?Q?Vm1DqHmcBQ2v6D20cWMf1EbQwllcGIvp8Uv2+SQO0ALmbHrM7kZHmiat3kFL?=
 =?us-ascii?Q?GEgxg5Cx+YXdnmtptMaqjGEr2zwxSkqU8RGceKtrVM8SbMI5ayRA/IImocQC?=
 =?us-ascii?Q?6lJ/qs3A70nPAIWiIL6/c6lbx3U6vMXf770/yOoarVt8Ys2udgVC/Jli9B52?=
 =?us-ascii?Q?EG/YZLf2Cdp+NpFOP+I+CjkN3v2ApnbQxcwA6mDAo47hdHKdDtbpiyo6Z33U?=
 =?us-ascii?Q?05LzOkeCs4VPDn90XEgBaQ1pJ+fP+tK8r0udA/XjOYj+kPAxTg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HraNjNHgPA50G0ljOZ7A/R/Yb8Dmz2gSgrfPbwbpYUr9EiTRrW5v+kyY9u7V?=
 =?us-ascii?Q?FrW/+T4xheI0kwNbxpDPaHM+MzSNBZGsGp2R9+fTa1KXCIgmd0hKtLjGM4g2?=
 =?us-ascii?Q?ID9wqYn+/35ILRxaeGJAfXuO8LYn6YtlQGpLTU54aw2XenxeWMpbhAv4jKAH?=
 =?us-ascii?Q?HxBvMDugIgm1JySfHgvHR3wLyG+A/Qp/baAPCZfX6BwZI2FbcimQo8CkchVH?=
 =?us-ascii?Q?dvSdN+0jqQS/+I/wsjCMw4cjvOgWkd/9f9ErtsIvhHULKvctiGO0K9gTqEuV?=
 =?us-ascii?Q?1+5+AqsR5BVWUF9sDFUmmFM/VU4PSWHlwp4ak+mHEM85qaEGwE85lFpPPhcM?=
 =?us-ascii?Q?OPXm6dTONJkGDY1rikfsiOOQPTWF5JqrE7pAKRvZtGQSMa47d0in5KOz5ut6?=
 =?us-ascii?Q?5d8kH1AJv8GN2pnuGN2P2ITb4ucEPs/T/8EKJJ53p81Ffi3uxLTtRwaArdwf?=
 =?us-ascii?Q?3ym6ggHPHaaEgx5t5KATi18WGxBKmkK9lMhn0cIHFbcPVFHRiuEZIFyNR6hn?=
 =?us-ascii?Q?OiDjcIWRDcYLuiMxWwP0BKgNQGdThThaYo3/XYbly1YtoEmMVEWVchhexo5h?=
 =?us-ascii?Q?78nLtkqbQN0oM9LXos1zPHIGVZDCWX5JzkTDOKS1ls5z0HHwFzYEhMxY9TN/?=
 =?us-ascii?Q?1olDxsHGEhGPMIPdP8kJyXh4ZfVwKfXSR4BoNOVEbcJy9+JPqhoKS9wuEo1F?=
 =?us-ascii?Q?aFt3f+rcmYG1L5DpuNUrpMC3FZ1xGhkANH/e5j5RIV7yERPMpl69Fi4h69Gq?=
 =?us-ascii?Q?cylbGTCPyk1x8Pkf809BeSp2i+Q2eOYf6Vs0g+H3hDmJB5Kqh9eK1/SXf2W9?=
 =?us-ascii?Q?rX1GpSkTEbaPcWpOd71csgs9Di8JpgWNwYtMiJt/VyE2Kb9IT+vPX6He8viz?=
 =?us-ascii?Q?STtWDKmMF8yzl8XrL8PtUkNvlWXUSWjTM3YtZPC6VbJOzLKs4fK2mLttcGdA?=
 =?us-ascii?Q?O6yjRDidGY/z0CDR3OnPt8ByVSKxnAwGBGHDT2BFv/dezAEn6UXx9wtwdr8d?=
 =?us-ascii?Q?vjNW3C1JbIIUUawsPLd7ndGBESO08GJQZX27y1ICPBUazhypTgU2Wzjk9eyh?=
 =?us-ascii?Q?vF7GCYVoPczH12Ey6GEp/f1YMRDeArk3kWp1TKI2v/l3gRtKZGGw6X98riHH?=
 =?us-ascii?Q?PLRTUKguLo496yqAFtrEthOFZvKBGf3vtLPvWCclZZiJAw4DbZKx44aQcs4h?=
 =?us-ascii?Q?ples7t2NjyD3ln7AamVg+fKJ07AYUCy4UIr9ZQRQNW5dd0NZh4Q5lsJbIoQI?=
 =?us-ascii?Q?AdRe2AupI+PHn8ju/pYk3fJhCQwimxexJvoxO0ALO//Cs/Gak7XgtJ/0BOSN?=
 =?us-ascii?Q?sm9ISXZZJnvhQ/hi/mhUBrEWAUgfZSCmD8Yk4NrZ9rPRxKVYivcckQ2DF0c0?=
 =?us-ascii?Q?UNkvzejjJoHN8NliKuoji53qCWzyyf0fxZ3P6MtMT7dvLBOJdj9xnif/2D9i?=
 =?us-ascii?Q?o7qT73cZ+GbZtyS/ghlQJA7nC++HGm4c93V/GSHW532N53nam/xW6gVKk7pV?=
 =?us-ascii?Q?DFXEnxc+xjtSa/RMzpRbJ2H6YpdxyypE/CRoIlESUxgdfBlVM0/mQxFh+Jbb?=
 =?us-ascii?Q?ArC7OZuDmUCp5wqhYMzJaIYBjL9vdMRA2CGnsIRx2rESK6GnK37s6+CI/0Z3?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 92162d1d-ad67-419f-8883-08dca0b05e3e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 07:17:33.6940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETKS/mDB0qDPw3PIYpszl4vOLJ74+duS2cIaD54EIM1z41pFDRWm+Fuudp2sopdfhF81qJo4td67HcLZ7nlwNBOHDyByfbkOkbf/gF9Hly4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5885
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

Distinguish more clearly between source files meant for producing .dtb
from those meant for producing .dtbo.

Note that in the linux tree, all device tree overlay sources have been
renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
81d362732bac). So this is also a step towards staying closer to linux
with respect to both Kbuild and device tree sources, and eventually
eliminating all .dts -> .dtbo instances.

This also matches the documentation update done in commit 4fb7e570d6b.

Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 test/py/tests/test_efi_capsule/conftest.py                  | 6 +++---
 .../py/tests/test_efi_capsule/{version.dts => version.dtso} | 0
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename test/py/tests/test_efi_capsule/{version.dts => version.dtso} (100%)

diff --git a/test/py/tests/test_efi_capsule/conftest.py b/test/py/tests/test_efi_capsule/conftest.py
index 80b12977d6f..61eab5112a1 100644
--- a/test/py/tests/test_efi_capsule/conftest.py
+++ b/test/py/tests/test_efi_capsule/conftest.py
@@ -53,7 +53,7 @@ def efi_capsule_data(request, u_boot_config):
 
         # Update dtb to add the version information
         check_call('cd %s; '
-                   'cp %s/test/py/tests/test_efi_capsule/version.dts .'
+                   'cp %s/test/py/tests/test_efi_capsule/version.dtso .'
                    % (data_dir, u_boot_config.source_dir), shell=True)
 
         if capsule_auth_enabled:
@@ -61,13 +61,13 @@ def efi_capsule_data(request, u_boot_config):
                        'cp %s/arch/sandbox/dts/test.dtb test_sig.dtb'
                        % (data_dir, u_boot_config.build_dir), shell=True)
             check_call('cd %s; '
-                       'dtc -@ -I dts -O dtb -o version.dtbo version.dts; '
+                       'dtc -@ -I dts -O dtb -o version.dtbo version.dtso; '
                        'fdtoverlay -i test_sig.dtb '
                             '-o test_ver.dtb version.dtbo'
                        % (data_dir), shell=True)
         else:
             check_call('cd %s; '
-                       'dtc -@ -I dts -O dtb -o version.dtbo version.dts; '
+                       'dtc -@ -I dts -O dtb -o version.dtbo version.dtso; '
                        'fdtoverlay -i %s/arch/sandbox/dts/test.dtb '
                             '-o test_ver.dtb version.dtbo'
                        % (data_dir, u_boot_config.build_dir), shell=True)
diff --git a/test/py/tests/test_efi_capsule/version.dts b/test/py/tests/test_efi_capsule/version.dtso
similarity index 100%
rename from test/py/tests/test_efi_capsule/version.dts
rename to test/py/tests/test_efi_capsule/version.dtso
-- 
2.45.2

