Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64552D35662
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 08:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D2F684280;
	Wed, 28 Jan 2026 09:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="om/PsHG9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24A7F84277; Wed, 28 Jan 2026 09:05:33 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 116FC83B87
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 09:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecUPx/R/Vr8yuxeT1msGxhV7enQ6XGJ4nTgOJTnEl6RhcLA9QlBtPfdI5FSyhJwD/bSLSjQ19XUnfDAxDd+SdE1ZSXjxp36DMdGx+PouVnRO0CNVmbLubQ45GExJSRIWKomq87bxe0MXermndJfZOBOgBq7KFeYDXMraVV3m7ce7Mk56xinzjqsAp0JN5XsLOzWRuSQ8WeY/5bujEkKlwmf8dInSq3nxjuWATM7PVm2u0my5tg83IyARH81CbK+d5MzklZK5xzaIq6k0f1xBJzVtts6dhLHjaXtZvO3PZnxFnziyax9wcaEGAnFKP7+0fQaQDJg6P/nMLuTonxvZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbZFX5FWOcAUQK3Y+2aF374THyiWyOztaMIW0orcmvo=;
 b=wDL4H2YgnxNflGn1kEqeS+v9Z+MePralbUxf2m/7TfwgWzzVQQOqWIUGYhUUZ4qdKBTLE70mEjUJE6LmqKyQ71fVkS6fP/KJPYFQzKb3QygekjbuU9V1NiBfoxaAY4gKwSPYHUfyJQ/UZdjNqtAEUxlxULEXbB4IMnJ7pPy98vW9VUUi1CjJMZWS+N0mryi+AYCazlWSoYLC65RAFsgglxOV9lS4hM6QbbO6bkKHKfNW2Nu+1tL+yxozDQcAsQjyQb98F1NBXOjrhkY+50Zn5u/SM9lniL9Tw05b1OdyUeToJm123oA6iPao52N3rYy7nfKJiCahVey+4ZqV5/tCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbZFX5FWOcAUQK3Y+2aF374THyiWyOztaMIW0orcmvo=;
 b=om/PsHG946YuhCVh+/LHRzbYVV24Boz3nVQU8GkzjijuJuf5aJEeggCGDClXn3yboAWdhZJyJX0TSl6G74RM1zkbmFMz1lo/3Gl5Xzhu/d2BuXNTKASAFd8ayymeap5X8yG8Da7GjE41Arm6Qp8b1XaX9I6POOI+TIURhYn2BotzBUNQgsQSfJGbLfzZZMUb9dCAExyuiLChoCWA7BtNo8kkUVZfr+CHIXszXvoTYim0dNoGyFw+ApPJtDJhygwhuVbQ+iFs8nZ+iCG1z40AUJEltKikimrQPjOec6EcNloE36gQnMC+F844vdGRaIKB2YcNTPs/s6zBqftx6Z9TMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by VI0PR03MB11456.eurprd03.prod.outlook.com (2603:10a6:800:321::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 28 Jan
 2026 08:05:29 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 08:05:29 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v5 4/6] binman: Add dump signature option to mkeficapsule
Date: Wed, 28 Jan 2026 09:05:11 +0100
Message-ID: <20260128080515.1275941-5-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
References: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|VI0PR03MB11456:EE_
X-MS-Office365-Filtering-Correlation-Id: 993662ae-8041-4f57-71ae-08de5e4400a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uyGCkX8dRRkMg/VS/UlLW3X51d+pr6k9SoLdq7BrvoDdbt5tn0QhVdGNARou?=
 =?us-ascii?Q?a3+RyO0PsAaF/Ve3pQIKVHmQt14Lhwwo5q9Tn3Jx6JpYNKHBtljCiaUau1RT?=
 =?us-ascii?Q?cWzisQ47Ccn8xsl5n+u4R8fcFCcjCLENrFxHsTlMNiXzmu5hYFnqR7eKDiNd?=
 =?us-ascii?Q?h3YkVWzz/uIqvg/b90ar2GyC1XoF5LPlT0AANSMCmTQWa6mENNEz0V1//BLj?=
 =?us-ascii?Q?tbk4U6mRq0BeaqE3OhSi/pB/ugoqkuDcFZQSvIh783r1w/p22sK5mC2GmQv7?=
 =?us-ascii?Q?z1aP7fSCjoNXBLh1UcTqdbIh4oAGjW5IszYivgqvZNZ3n9T2FkzF9fUA6XSI?=
 =?us-ascii?Q?3UrOzpJkBPc0p3weU8/Jv6J/zR+4MCBQDQ8uYeGGNfToAmyvoSX9FdVobayw?=
 =?us-ascii?Q?IL+OLvat32U79NdOe0NIgbMD2buC94gEdbbQDF/p0bG54bpBFr0b5jCaBKqQ?=
 =?us-ascii?Q?esOAa7N5MiP8ihsXzAtaWiXLfE2LuwS85r36Vd+y/Nu2DkrD7mL9NgrUCt0o?=
 =?us-ascii?Q?G/p8YV9/jUEcEAQm4blgFRDSUkJPn8x5b09toO2ogSCuYbvpw2nWjIlyTp0u?=
 =?us-ascii?Q?CWVBh401X0MJu6p/R2P6tDb5UBB9dbzD8quyOeWqjsITCv4LL9DaclJ1GNEo?=
 =?us-ascii?Q?6is5jM5VxWSJ1mzTa/pxCZv/DAIkh4tXSVJ9SBoRe6Hz6n0nWRNqFmk4+HWs?=
 =?us-ascii?Q?587P5xWu+SFoZXwiYy/L1R2KVkn6FreslC8GhDAfSAywAIQ3/YnPUJJappRU?=
 =?us-ascii?Q?xgiFJmZWROoDVjsvKr0d5PwKkgGRyRJlsl4hdXZSj0ACV50H/PK2lEIxlzIu?=
 =?us-ascii?Q?y11CIpbgQKZL49BSt7P+IsON3SZS2nWVB8QUun/+8d2Sln5CUgv4/lZfItfJ?=
 =?us-ascii?Q?St5nJTAexrsRW4kLaaQESkN/PorL2JLDOIFbsAiJQxxr6CyQeoPRsczomCnS?=
 =?us-ascii?Q?os1GHJ3HECoAiRppYwzrMc0UI1yTH2hkbSUmD4gKGZu0L75LsL3SfGnvwCd9?=
 =?us-ascii?Q?itDyNRlKrlsCBEppzaKB+2mBsa8vIpGaFMY4Crmv5x9wC0eZN3g4mZi4o0DZ?=
 =?us-ascii?Q?oEeJs1iDjlTlkcaLaZOxLgfq2yRfx4xvo0HrlMep9lWL8qbWUIl4KUVuASvc?=
 =?us-ascii?Q?YU4BmqmhOhBPt5hHRvK9KE3EA3yjQ5iyisaZ2G9j7txLDBaX6T7c/EuNZdIU?=
 =?us-ascii?Q?7tAAYCh2IjcGgnZs5/cD+MJLmig/cr1pfrYUCnWFVrCf7s0vg+u2lfuTbw6i?=
 =?us-ascii?Q?ugEV28mjKM033FYtyQWurtPNRMljbMlzUR0HmNhVH1CP0n65PE36XA28NDFV?=
 =?us-ascii?Q?w0RUEIq3t7OUJhDjwQbwA9ZTm2NJN95zJ/tefUeE1ugt/sSeGwlGtVxM3Urd?=
 =?us-ascii?Q?4vgOKIx9xf7eO2evJ3/QcboVnkL2UE6mWIT1uskHHciRCSONRlS3DULEnAwM?=
 =?us-ascii?Q?l8yRkFmTVRlP56cxw5JmOpcULH3vsIVBG8/4rdlr0bXRjQm9lpcbB93iu00V?=
 =?us-ascii?Q?LcieUGff4LRdT5oFaNRzoO9RaW3ZSdLVPS1UDTCP8hLkV31vMikLt+sosiFF?=
 =?us-ascii?Q?5jh63QZpnTbOauMEl5VrSdW7cx/pefX3MAwYKUeMOcafgKXdh1Ma278i4JrZ?=
 =?us-ascii?Q?89OalNUsB8bNhqLcwx8OEtY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AeMTxmilTdsaeZoD1+/9wW9nvbTJG4F4uxfcNdECimrYSpxP0v9QqSN6oLZ3?=
 =?us-ascii?Q?T1L6KSYESffIYv/4HBdkOCDc9503fappd9qss1c6hwkayCqR44OsLgJg/go2?=
 =?us-ascii?Q?Y4qyq2wOrSM+X2ZozKv7u9RX0qZFZwZsEgzEHSoRty6C8v6kzsF32W6GehhX?=
 =?us-ascii?Q?qPUE8CJtbqrm0TWzUDfANf+EK4vu2oaFhOmBxcR2mAFfdu3bfHndxHfOMSXz?=
 =?us-ascii?Q?+9jHE9gIP+Depx1X2lZmG+I52cf3gNPY9jBBV3pbLLjExyZPO16Hkm33gCDo?=
 =?us-ascii?Q?LuEHAkR2cjI7g8i/w0pjyKSl6JPqOrH74BWwiZSQB9vO8O12eNvnp9uc3bGM?=
 =?us-ascii?Q?ox1wEf1CzpYuHoNv3NjjcX78E4o9sKRCx2+iyJtfMdpimtMuJOuvUBokuzP6?=
 =?us-ascii?Q?2+PDtE3FCU2vJT4NeTeGujnQsJ76nuwjvQfRDClBG8hMuHOwp9P4EbRjkTwN?=
 =?us-ascii?Q?jHl3UoqB4vJB0icV00LReU2Bp/wQjmncMTdX/IJ7HuNjh1xa152wczOgsIOI?=
 =?us-ascii?Q?3NpDUcVpW/D4Obgh1g1neUj8s40AVqplxGd3zupphJhvGMVI7cFaqjrqyh9V?=
 =?us-ascii?Q?W+5tbIPXYaSasATQC/nZrVeaC3AZLWG2KKsCNxEiYEBx1Jq2HthrWwavDYb8?=
 =?us-ascii?Q?D2hsGWd5/pafC9sPxK5ncN0px+2M1zaOya9GGIfQSfqJHHBy4w7bZq+ZXg9K?=
 =?us-ascii?Q?iSki1G4UslhEX0WesBotNyFJ/IEhttnaZvUyl7xRDWfOGZSARCEL5H2+4v1z?=
 =?us-ascii?Q?0KwGRv3BJZas8TqX49ZEQlUIAYUokeJk6ucN99PuKLf3SQFUAKPgaDpUOE3S?=
 =?us-ascii?Q?f4wPK6KUDscLX+8Ck63vfrTJGoqc2weGbXwxiQEFXghgWyo9xjSNLMME6EtH?=
 =?us-ascii?Q?lu5WHFIdN9p5s7DyvxD75rko3evkZoLMoelM5aPSB/O2BePSvdKiM8W7gIsm?=
 =?us-ascii?Q?7ye4Wvq9KNxsb35qgVCpNTHuxxzmDEV62zTR4G32CBOQ0vTWygHt3Vy/xifH?=
 =?us-ascii?Q?Vp7eFiksaaz16bkZnb5TQ3qD41wDrkhBijNRnSJKe+uXuSGqvxppiWd/Rqay?=
 =?us-ascii?Q?YN5RQuja9j7NfqwICAufDt+AbZtLCRwS59tku28+7ALhPJ2rEvu1Vw7gI5DU?=
 =?us-ascii?Q?1DN/oTPEpG0zWU1/9uwLgJ77H3g75epZKuOVzuMT9ppziYbYoCpHzf71atFo?=
 =?us-ascii?Q?1jaBUsoiiPAKSNa6PK4JeJ8NU4Cfn378s3G9DHLZf6Yw7l/4RoLLLmHVkV4T?=
 =?us-ascii?Q?SLtgKdPq4sBHbQjyZ7cK81slapbAVv6+idQAdVUAH+P3jibnDXpSNs3RfEuY?=
 =?us-ascii?Q?3tQ7otGlli7rc/3/Td8JjYid3vmLF4U2le9IIpxaOhjnJ8YQ2QfOjFJOWzLB?=
 =?us-ascii?Q?oQ3NW4hwZAlTrbM0TQkaiXD3Qtu4K7AEM2mwydr8Rv6zoMf1KcaN25OphJHp?=
 =?us-ascii?Q?qy8M6wikGPqx8LjzqS6voA1JT9fEuyr+6yBjFSTxLsUZgO6BdeG03JqvX4oV?=
 =?us-ascii?Q?myQt5YxrINJIE7Adxw9q4CPu6ig3xKPcalhvffmhIz/l4Fe5jEBEyS2pdaFz?=
 =?us-ascii?Q?YLVtfI38PzT08o9cg8Ub6hJ02y4CaU+iaOba7BjpdjDvhecPUCKq1EVPBmli?=
 =?us-ascii?Q?n3oAmOFggbNEwXCvCzeCsuKwWQ7p806ldJH2p9q66MyyvZMbGFaoiIvGyF+W?=
 =?us-ascii?Q?BuPHa+k0qPC2lkasIaWqmTFgPOPoOkPxnTt92MduPaFmsLRNMxCZXlK5oi4E?=
 =?us-ascii?Q?/m09x2d17w=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993662ae-8041-4f57-71ae-08de5e4400a0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 08:05:29.5360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hNTAxHZsa+etfeB5JidHwdn/odd8YXbtxii6wzEyTk/sNLvjCk67Grp3cXxWqMhl5uxNr8c5OoFNJO0i7zHcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB11456
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

It will be used to capsule signature verification.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 tools/binman/btool/mkeficapsule.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
index f2ac654db81e..7638c941a8ee 100644
--- a/tools/binman/btool/mkeficapsule.py
+++ b/tools/binman/btool/mkeficapsule.py
@@ -38,7 +38,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
 
     def generate_capsule(self, image_index, image_guid, hardware_instance,
                          payload, output_fname, priv_key, pub_key,
-                         monotonic_count=0, version=0, oemflags=0):
+                         monotonic_count=0, version=0, oemflags=0,
+                         dump_sig=False):
         """Generate a capsule through commandline-provided parameters
 
         Args:
@@ -53,6 +54,7 @@ class Bintoolmkeficapsule(bintool.Bintool):
             monotonic_count (int): Count used when signing an image
             version (int): Image version (Optional)
             oemflags (int): Optional 16 bit OEM flags
+            dump_sig (bool): Dump signature to a file (Optional). Default no.
 
         Returns:
             str: Tool output
@@ -73,6 +75,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
                 f'--private-key={priv_key}',
                 f'--certificate={pub_key}'
             ]
+        if dump_sig:
+            args += [f'--dump-sig']
 
         args += [
             payload,
-- 
2.47.3

