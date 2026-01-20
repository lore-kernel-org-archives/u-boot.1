Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBB1D2ED0F
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 08:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CB7D83B03;
	Tue, 20 Jan 2026 09:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="orc4dbpr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AD7F83A91; Tue, 20 Jan 2026 09:12:27 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9D6B83AA0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 09:12:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyW9Wipe3ynVOfnKZRnWPNR/oT6xEr9XwjNs8p4X/jWlEAXfWPU+Ui7qPljsuyVLG7vGgZCZ0UsTtI1f74AKIM4BTk0lYQad7Q8/0BXWScRWHX1CUNhcl4BlvyL/NRfjqjxGXAe+RO+yI3jXdIGCEjbvb6zk9c49QVkiQ5UIUYThzzwhZk8HOChTJLVOtYEewx6fWAOS2RqluiyU0I9fkaF9C+YPT4pwXoamSDn0y3493aPLAzb5o5AsSsiSyzy+1GGT34pp7gseNgcH14DGFLcVzWnMUnrV4OD28V0WT8Uxukwz2gORQEu9tFpJmIycx2VjqxMVXeI6SL+6o0PnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdZGySi2jEEXOX9IqHsBO55uqyMekKbTan8KwiqyQTg=;
 b=L5u/y6A6ZwGxdFEUvb4qtnFbDyNJdPNsJQxgkmkTe9X3cNUHhkEJaJsl+0UdivtbAhghlOcc1aD2p+WFcePPYTCB4zMWEU2KbyP1+Ejt92x6zoiE01UAfhD6wSevNi9wXUGlZgiN5/OeRf/n7E6D8bIgOb5WVC1DC91tjp+/p4CnglJrlxqC1wpaRLpkWlB8nZ294QlZEKsX90pMbVntaS/H5ovv6N7RCAl0guEkeM8h4+AeQSZAKVwHWloKuFz0+MI4vBMmSagXFj14yC3z1Wi+UIQst8OWVuXOcwb0byXc2mqjFGCMfBQVnrT6Tm9IquRz4fm+4EJcf/kP9Il/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdZGySi2jEEXOX9IqHsBO55uqyMekKbTan8KwiqyQTg=;
 b=orc4dbprjvN/dKrJ/EKlKSF5ktlEdrGnqFc6BR896CzShtzHRERn8InFcsS3UVWx965kHfvDxiY8eNOzDqlaQMVL34I8W1eVr02wBT+6H0K9aTNwsNtfQVPj7lsJNXMbX789mqAwdjECy5b3uRv0O6hfW13olsGdJk9vh6zoZOLAXlUYwcysg//X9d7bVUMiPdTswanZ4nEpU5riW8FZX7x4MkFNP8QxCkmWH6tAjHYl7AbA+ZTsatNGnKlHpes8j8kDP+L3Ly1mOXGV7L/P7QUFO4cHU4DF9BkiDRqkxmYasfKZE4uEgVVbUTzOJ3tOBRIZJN3yUIuXJmK2pW3bQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by PA4PR03MB6750.eurprd03.prod.outlook.com (2603:10a6:102:ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 20 Jan
 2026 08:12:24 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9520.009; Tue, 20 Jan 2026
 08:12:24 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v4 4/6] binman: Add dump signarture option to mkeficapsule
Date: Tue, 20 Jan 2026 09:12:01 +0100
Message-ID: <20260120081206.251544-5-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::12) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|PA4PR03MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 779bbb0a-5182-421c-af73-08de57fb9e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ifh85Xv1LgnL7DMF+qvr4qMmiCizeSo02CFzstVYYr8dF/J9l+MmFzDRwILF?=
 =?us-ascii?Q?IWtbALA3aSPglYSSdRz4qPBgMKNt6MPOlthnrnlW94jMHLBS1ylquuQuOhxJ?=
 =?us-ascii?Q?qp5dMcMKlMQdFobuVg3AReGYOkwXFfYej7LGGxWU8F+oodtNdfDf0GPR2RB1?=
 =?us-ascii?Q?68SzmNU9u5IVVB4eIw7X1LCCc4jc7IjyiT8RKuplkX7AQ65O5gX60QN+gDq0?=
 =?us-ascii?Q?CR29mhniaf3QhA0MbcYtlCGqvxT6x6dNJsjYcKAoud0b2UG5hKgIBjhmqJ00?=
 =?us-ascii?Q?arigHjzfDSHqwmFu6URImoY3nlMWNHi/UEl5mU5Te5EjKERs7z/sPZ7kV+uL?=
 =?us-ascii?Q?CUdjcrbOqzdCKglbBaIPxuIRmybW4iIwhce1j8/owA1ScQeklKYk9WsFPm5j?=
 =?us-ascii?Q?JvRicCpjZJ4kNhfm/8LEkTgAzPkEjFWcBpHYe6VTsxdRbojwtdTPZ8ijUxPX?=
 =?us-ascii?Q?6m6vNzOyGgtfVJoSMHJBMod1UUliA8XZd6/GWSPp93kFF4S+7+kmMQwlJIyt?=
 =?us-ascii?Q?3dUYJ2G+LXmM03LrOxhxcTsegT+L+FZXBm0GUJBDDLmc+DSd4WBpPbnZCDxs?=
 =?us-ascii?Q?JNlpcdQ2xQthOOqT6J0FSUxBeKwFDGt/LBuQ+iGp0Jj9yZISWrZwskQWxg5d?=
 =?us-ascii?Q?bdAssQpngTK3o1K9x20ZDfTGDVqpCEBWkHaInYReeMPAyDc7z2PjcZJJhR+E?=
 =?us-ascii?Q?W5rlPJ1gTQif7hFGcG/5wuHt829l8XMvDMTpWnWa2NpCRwhtaQMeGIxDWFha?=
 =?us-ascii?Q?+Vd6yqHmCxv93fGaGxpKbE4aXrm0LZeOVrVxTXcPZ0mfCYE0ajeO8er6Ossq?=
 =?us-ascii?Q?cCZIqqYja/YMDhfkcrPqK5B2rLLZpLzv2YmzTgwe/B1fR81xesa8N8wHpjYA?=
 =?us-ascii?Q?GQOvJr4PEJURM4HjytFQbotBedAURoizU9kDZyUlUTsbEBHAaMQEJZznPEca?=
 =?us-ascii?Q?1NvioR+7/20YHmybIEwGeY9cLbPvWvWJbaNwQQi+ZqkqRH/U+gVgEHzS8j9P?=
 =?us-ascii?Q?bEAdvwS2r1IiZPbDdp4wbfHQ9mXx5ch9AnudpRpjPNY9UA3pXJonrsaMKS7U?=
 =?us-ascii?Q?p/bSy4KL3TsD6muvzp4J0c9L81iZpRvZHCewLtnQ4TzwsD+CPwTAhTfPhH8C?=
 =?us-ascii?Q?k1htxz7jfuC8hJtaH6MdXlQFK/MiKlK9Rye0zx87A2jKSWQ0WrbyG2fBdBWR?=
 =?us-ascii?Q?5fcjm4D6P9UI+WWyI7R1uuGDltwoOweB3mg00kpsHZeCsR6wd5EVM5muQmOO?=
 =?us-ascii?Q?izphPDFZ5szL85hxGwWffOOXIRHt0pcF5rEpl+p6dIZdBzN6ngOMeo/jtMIN?=
 =?us-ascii?Q?Qr06UikYPqNubtuyXLIVfmQY8o6Qiva7tftQZTeeXdw7UP+EiU9pEupjemBv?=
 =?us-ascii?Q?t8qzzaN8543H64hDD72cZAMdw40pHKE5Nfy7lgR92M76K580IlE5PmuPzCG8?=
 =?us-ascii?Q?eXbeqnjZdSiTcibp/nk+dRckLI6xtlQoei1dlGMuPO3O+vqVjmH5i/+XQtlw?=
 =?us-ascii?Q?T7tjlf21TOzrCUD5mSOFAbtvUudRwu9UenDo2eDdy1RRMI7MJ2rrf1KHxBQ5?=
 =?us-ascii?Q?2lFA/7PNqcnnwlWopUeTqepiQhHMbQr540l7EVyhEPCrTGmAoKfV6wpkzYzK?=
 =?us-ascii?Q?9jYibm+TG/5RAVAY9Mdxkzg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(52116014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LDPCNdo6BHQWbNc32o7DDEL+R4TZgN+9vdQo2bmOfh77xDrMxnRXWpPlMC9U?=
 =?us-ascii?Q?ycY5zGvny14cbf5ESH2gvwPql92Tn/Sup2ks+EjVQlA2DWnRhxGAnQyglDiR?=
 =?us-ascii?Q?khWs/nJwgXbNxnjJ5OdVyLN19FN5NFLk2q6+pYqfoBRU80pKrJRpLrRK9qq3?=
 =?us-ascii?Q?xcntB7G0FxP8p+ViuILQdNojwA7CH5Fj0uItMCY19zMbmZYAoTg3L6eRwjNH?=
 =?us-ascii?Q?ap8O+HfExNt+gnIpsVTl5zkzzM8nRyxP5htBFKUUUAwpOgYTpMQ4zOCarIbw?=
 =?us-ascii?Q?R3UAdw5icPB/jG3HKGrHt0+KXm+cb6yoUurkozPL4y2F/0PShiR088lkGJgo?=
 =?us-ascii?Q?49bKrNGNYKTClzh34GRtNiWNWnWFpJ8+fDZ/m9GlRYVm1NcNgvP/y2/PXcES?=
 =?us-ascii?Q?fPM0SEAkyWOiJYi+V+a0Xj1fLmHdZOiRSzitmIQd33PEnclgR2FU/wonQ/Hx?=
 =?us-ascii?Q?mzdZ7RdL5eN/0wPh5tbhj42qwYDybCxlljl4ysbzbVF/YjZ5DpsH/T+vPNri?=
 =?us-ascii?Q?tdK+QAkogX5swEYv29ffHlFkTjxh3e2b+J9AeBMBpQvyJVp6VEbpdQSC+olC?=
 =?us-ascii?Q?Am/wS2SDg7UgJu60pADomCkJbtYUF9ct0wWUA4496pjmFj5XfXXFyc5KMbLG?=
 =?us-ascii?Q?03cpreIah/wFV7nMWXxOTYmqi8nfUmV6b1Hepw0U87qjTpOcxweA3UqPFuEm?=
 =?us-ascii?Q?5HmnQTBzl0binBoBqgwVJtdy+BG2+huM2EJwXQGTcCeYPtZT5hE7YsLnQM0b?=
 =?us-ascii?Q?ZgeTLdgBuoV5kgBdvtBb0BJUsEi3DC0K/H8C6nwud9YYUTxICQeQAk4OlgwV?=
 =?us-ascii?Q?PnbBlONyD+ZTQXsRiGPIQNxTeenLK+daVclkre//dJJaWubIlN5oDA7ZbhHI?=
 =?us-ascii?Q?mnoOhU2Q+CXFNXCQyxL36Dmo98WffAgDxhm8Ljrvj8I9y2M834pZEE7+3PCF?=
 =?us-ascii?Q?8cN7fYwwQ3E80lz6v4OLySJrsQrpI6HG2D+16KNWQDQbFw1Yr+Bo4ipQRuiC?=
 =?us-ascii?Q?/MuHyLV4LfZCgqSMI7mQKVRpuDZHE6FZlSC0QxfSFDiBhu6IE094o551BLUM?=
 =?us-ascii?Q?5/vBY2e6q6H03R/S7ykpf945kPKJhdH29HPC5ZtU//ofKlpJPlTedL7NsUQX?=
 =?us-ascii?Q?sgoysYTiP3+j8fev7UHGal1Cx39wMWDukto27qnMctCvdocH821tBY4EJRdM?=
 =?us-ascii?Q?YzjmBgjJujBfs4L8V/z01nyvs1adZpdLa0xEHKfdbHOoc0UFraTiUsyFHX45?=
 =?us-ascii?Q?5G78AXigFW86uE9c5gefvyZ7tZdjFaKqaxhlDeO19903AFvx2v4+D0yfBxPV?=
 =?us-ascii?Q?S9pLiGEX955ZfqkHt5nqiZprjv4uVMttjQWNzEc6NucpwLXV/M5qr8jvhGjV?=
 =?us-ascii?Q?BXz18FOm5l+Qr2nbsyerxwdny9YCX+4CsRBP13V2yRXeA8zeiOD4pEApiVDJ?=
 =?us-ascii?Q?p420Xd0drNj/P8E3ob76FK+tBUow94sa9mSRFGsdTikZh48I1eBzGHiPpzh+?=
 =?us-ascii?Q?zfKvK7leAxl/zKMYptoIHIwTkF4G6swSFkEkFQPnxMxduk7NHi8npH4Fu9cU?=
 =?us-ascii?Q?3YIbyGMYduUM9+biMaq7LaNLLgcW6vp3kwXLSPTHyqoM7pX1Wsg09nataLU8?=
 =?us-ascii?Q?ZEi0vhXjbDuy2tl8sa+gF5fcZzX69Jb431EMneKU9zdBNuZysZSbQQPqK5vP?=
 =?us-ascii?Q?7y5efO8DXaca4LSsISdfgAiH1CgYIzFbe/P6Kq5SlhkuOaB+w0NNmw2K9TLV?=
 =?us-ascii?Q?z/zEsCdasQ=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779bbb0a-5182-421c-af73-08de57fb9e35
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:12:13.6644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryS6vq6lGzd2eWOAuVyTeMXQiw0PJDSltbH1+6yTz2Te7X2U01EBCQy2Wpw4xnf/TJ88jPx73SSd2YtvaStUdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6750
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
index f7e5a8868495..f4b594b3faef 100644
--- a/tools/binman/btool/mkeficapsule.py
+++ b/tools/binman/btool/mkeficapsule.py
@@ -38,7 +38,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
 
     def generate_capsule(self, image_index, image_guid, hardware_instance,
                          payload, output_fname, priv_key, pub_key,
-                         monotonic_count=0, version=0, oemflags=0):
+                         monotonic_count=0, version=0, oemflags=0,
+                         dump_sig=0):
         """Generate a capsule through commandline-provided parameters
 
         Args:
@@ -53,6 +54,7 @@ class Bintoolmkeficapsule(bintool.Bintool):
             monotonic_count (int): Count used when signing an image
             version (int): Image version (Optional)
             oemflags (int): Optional 16 bit OEM flags
+            dump_sig (int): Dump signature to a file (Optional)
 
         Returns:
             str: Tool output
@@ -73,6 +75,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
                 f'--private-key={priv_key}',
                 f'--certificate={pub_key}'
             ]
+        if dump_sig:
+            args += [f'--dump_sig']
 
         args += [
             payload,
-- 
2.47.3

