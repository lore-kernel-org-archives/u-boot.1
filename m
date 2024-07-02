Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFB9C3065C
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 06:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 006C588722;
	Tue,  2 Jul 2024 08:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=weidmueller.com header.i=@weidmueller.com header.b="AXhgbrcT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF3988714; Tue,  2 Jul 2024 08:49:04 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::727])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 072A388718
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 08:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVIQ7Efg3g5plM/JtJzqdRgiDmQcIMKCIJi+yN5MWaq3Lxf4rmBPd4NzlfNK460L8Vgi9rdrhG2zYyCRaNlKGjXU3YEX6InpJYiBt5PkAjTMcc4Rwlm8UWX5UVrovOEoasm5lA886T8A5MVRM3gOeUFMO4Lsgx35WuIfAuvEFC2Lj//kAvHoLwWEGbeltDiZ6qV07jo9EveP5kq9h9aa55KVJpf8NwfbzmyEjIV6NXUjI+DaUGgHijektIw2UPvfAYeHbE5oabHFXvJs7wkUa/1pl7oOvPQAixIMgtk5FmdNRr/GDUzTVoda4M9yTAblZP2BUYU8eMIWaMizXlfE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyYsmZO8UMwy6pWoV0fP/e1vazi5QueSmbpsBtBL2Kw=;
 b=TXQutU7QJtTQ3D2zkiZKOuPcEMDGPikvyRuk+eO+ZI7nqGehkX9wsyNduEuNSpRlVcE3G3Sev1dHiicZvUe3weUGVlUczo63mgJzP1JLDcc6aYQSCadK9vDqOJ1h9UWUa7ROM0fai1Ru+xt69n9SX9z5uKunEnEmW5jrCDT429nOgemf3z4dMOvXsqejCFVls9+U+aGH+gOXfB1dEXV7anx5Dezs9FRWcwRGg91AZeKpijViWzT4zpjw6iTk2kLjx8xBS/kJmwYhytBAs/vIqmUm3Gy9LmXuTjA6nyMIBNrv2OYl95Kxb3vnJHC/Q3vDg8Ej4PxCuG1dOAbcn+llkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyYsmZO8UMwy6pWoV0fP/e1vazi5QueSmbpsBtBL2Kw=;
 b=AXhgbrcTM0xc8hakNHA44Rzd2MTcuytTqBaytzC6chaLmFsFHYdu65tT0snAulYaGPbRyDqF2ebdSP+i3THw187upn/ye5OO3R6rZF4Z5FfD5bfsFLhGpxJQdeLZQ6GnrgctkYJmS34NNlVjead6KArBxbWVDUv72TtGPkhMa6PIPn4dX3ryq8qCdcbhIz5YqcknmrunubdHpS0fmFinV0fl2oRq9VIgZfiPJjkiNgefgLyZJ1eqGPeS60Vg34KbC1T3yKsVhoHL0enmpmfwJcXsCOC0NcbJmheEThWhKV+DpSgOKQLH1SwdBv71fm2Rl+ZLzf//Ys1NBoiI7hKc9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB6356.eurprd08.prod.outlook.com (2603:10a6:20b:36b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 06:48:59 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%2]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 06:48:59 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Niko Mauno <niko.mauno@vaisala.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joshua Watt <jpewhacker@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Piotr Kubik <piotr.kubik@iopsys.eu>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] test: fit: Add test to check environment extraction from
 FIT conf node
Date: Tue,  2 Jul 2024 08:48:34 +0200
Message-Id: <20240702064834.9543-3-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240702064834.9543-1-lukas.funke-oss@weidmueller.com>
References: <20240702064834.9543-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa3ea3e-c6da-486e-ab48-08dc9a630d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KZAIL0r3s2mah7I4a+7ryrjWEBmz+kARRmmdNf+zsHa6ZeRgU5F0ib8ixo66?=
 =?us-ascii?Q?bUBxk2yuvZYhATQSqWUFgv/qT7leupJ2BK5Gen6DTiB5VaAzE83MP9AKDIPG?=
 =?us-ascii?Q?8Z+HNxv0khDb6ao9bFbNBy9lTOr0jSvApHECZRYEXLiuTjxljKhGTRHGzfO4?=
 =?us-ascii?Q?mjWX6lzeyfhCK0sYZp8KRyxYsGc5BKZNV9MdPRNU4pRCzW7qw7RMkwe/O3bs?=
 =?us-ascii?Q?9GZTN/Icv1VKOIRSWUGSCvzzgxqbsnLxPLezWBKT1RKLJclUAVLiDlM+h91+?=
 =?us-ascii?Q?5B2U1ei6+ChqRgX1pcrUqFSaiCD36waIAf7CZlfsvMFr0QWW3HBedeF/S5iM?=
 =?us-ascii?Q?TW0e6shynYwcFhe1Fb7bbQYkufwyCv2lsCooZqvP4zuUbhZuq+l5yLyJ+tEd?=
 =?us-ascii?Q?kOcbtwvBQyz78mT39inhiQ/D+v8VllATfRIGuefMrJk/rZe72gFng8xN72JT?=
 =?us-ascii?Q?bVdi24NkWms5G0eOlE9NiIlVWD3kl6YRk0d4q08TGkBRgZLEsuok7TYul2lR?=
 =?us-ascii?Q?WZTgpMzkVzDjHsjQ9aTJHBwU/KG/+XsjwnRJXfj9cxR0FUdBrWPfWwEtGxtp?=
 =?us-ascii?Q?/DurLRfhfwi06NKeKX5M5OtvOYDnI8AVS1E29+a9as8NU45QG87+bUTTo5WK?=
 =?us-ascii?Q?BkAxaj5e6N461EYbRFJO2MS5ozpoku67jXzNuZOLbkNGLKD/UpPoXv4Hh7T0?=
 =?us-ascii?Q?8KNmJVfbKsuY8QKN20hdTzTMxVQ/VpUEAVjn1QOPfo7ODdLf6epEa/tXkdyX?=
 =?us-ascii?Q?kYzJIjQG1+mzIutPTNu5/RMqQmrJ67BG1G/03AtjtW0sreSrZb23XfXFc3CW?=
 =?us-ascii?Q?14fR5Kg9CYOWED1a4tniPDaDOCNopQR1U2Eq03lQGmPb+QmBbTQDTaIu7HPA?=
 =?us-ascii?Q?nJRsZ5tCaCDcbUXN7ocdndWMrhLFbdmot90M7WW7JOmcGwj/6k4hCeVyzAhi?=
 =?us-ascii?Q?1RXa1P48M+WYl3IjRQLEfSZi+DifryU+NoPceN5k87CIKkaRt8tPLVD98uL+?=
 =?us-ascii?Q?L4XVzH6MJCFsCqXbSPQOHCoo7NPcgt7YoyUpljDfHKyMP/A6nsCp5I8TQBeE?=
 =?us-ascii?Q?phJjwyM/9ySFE7emy2gTKoWf+f22kA6BQHZaB9vKdctah8cp5OCtn5kVo61r?=
 =?us-ascii?Q?yLP+iIHLFspbXWo6vtpo73vfZRCwZJiPmPEItm3MtlejU11QefqutvbO8oCH?=
 =?us-ascii?Q?vx+IAVWQ3RcbnPI++ctBkd+1d5/ys32mhueNk08O4RXhhiPhZlSASGU9xILr?=
 =?us-ascii?Q?A6GRo1OSHFHFDYpZ37IFEJpnfZOxlh/e28dR2KnvWWHwJNw4D2JTef4GMtCp?=
 =?us-ascii?Q?F/i8sg+6TQ/xzcezw9fUXM/2DX+aEDlneUHMoVFuc7NzUuQFdTXsvQ99Py/T?=
 =?us-ascii?Q?/FHRi4/Y94ViZh0VIbZg2tisOTDNMQEImjjdbL96wm9RcTT7gw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JlHgPMnTz2FElFRbDhN/74hCnkLoX6KGKHxJ4p8BJv9pV9HZeppmhsklhDXD?=
 =?us-ascii?Q?B8xqq2f0mjxN66xhHYP0est6Eu9UPlCKdrfZDh/F51y0FYVwemsr7UiT+kdR?=
 =?us-ascii?Q?mRnCr5oeHhv/7RIW2qfEZ5vuSn/VuwRngmTgt9ipOgpYS7qFwX6c4tdeNUMj?=
 =?us-ascii?Q?v0HUBjgoi13xXz54jjqEWjO9dBSCUOmxKyE/kBH/wLWCWIamRCLQcYKjqCCE?=
 =?us-ascii?Q?170PUcTPPBIh/7fcAzFkGn1Fv8kr4TOoDobp/jTaBdpuM0Qv7CF4HtG0dn18?=
 =?us-ascii?Q?lLV2wGjpn9/uFda68WQnOCkgKd7ZcT2/ySSQ1zbzqm1xYoKOQflNvhhTM7xW?=
 =?us-ascii?Q?7YcNLT8dv5TM6DeCq7dhrVSe+l6pSwqRIkD99ycf9DNWYmuyn6JPxg8l3CTL?=
 =?us-ascii?Q?iK5BQBFirQxDPUctzzecrRgNyKWLdh3f9VkY14akIikmfGKV/L8CycsNV8Dj?=
 =?us-ascii?Q?7tgI8GxxnKqpaKnNyXHUzkM9QmOIqjD+DoqR6cOmxKZrI90XOgTx09oOhLen?=
 =?us-ascii?Q?sobceKEPujoMdzhcMz+9pqJO56x+kobUyHNTuKSxe0mxfXtzTNxGGfAQcKNz?=
 =?us-ascii?Q?+rtugGJhkg4JEiLC4Ux7uetgtzB/2Ia8l+YU16YFri7ZU0/xcKKLE7JvSUCt?=
 =?us-ascii?Q?pMbeZDTfbskcpKGsrWFpDNuO8JaYnMabx895ZuYbw8rqvDPUYMKzQE5j3BUc?=
 =?us-ascii?Q?Wc/1k3dKosmeQu9+ehH/wVHjzUvhGEQFA4KA8uo9X26OAlpFbHORtJ+NQ/2Y?=
 =?us-ascii?Q?em8ahXJkqgs7jscWUlcRHFd3ZwrXVAl87gERkQpfOEkYJ/ziP2OR1Gua0zlr?=
 =?us-ascii?Q?+66iQlmeNLeInx8xWg5nqA+ra9wVNX3Elwm4amGQtgqpIHWBn7UzgwHseWWy?=
 =?us-ascii?Q?We57MmssjEkiVqxNrsYmFkDob9fk0IVQEalYqtH09lim+WMChxid4RoFComf?=
 =?us-ascii?Q?A1blnCjPtBD6imd4yIjOJ4QSqvMR95qpWjKV4fqGGcFZe6z147ADoTa3850J?=
 =?us-ascii?Q?z5m2IEtbXNxnykMCAgn0YSQa04CTv9BhhTWbbvSEJQDsvlRWwKxccCTCRq13?=
 =?us-ascii?Q?RV2RZ8EYwLgpP0/WCQ0j85DNUZfLiENm74XXFBIYMqHa3UClVxZhvbRoSwE1?=
 =?us-ascii?Q?xAYJLfgnV+a0rN2b9LLXVilqWQT8oe9jmlAw7nriRQTdil5DVu1cHxgwSG3Z?=
 =?us-ascii?Q?PNNu6dLvY5d9VAKLv3x1L6NXmQJ6+I2GvWA+4m6ksmZm+cpRS9xHYXxhV8L4?=
 =?us-ascii?Q?hErH3jMlMn1kpJocgaJmd9cYSM2PcytMAuNcZ4ZG7RIhWqrCd6+DmvsUDeg5?=
 =?us-ascii?Q?NL2VH14Y1rKO8TnEbSsHKBMmj3KoKinvCQO9PPFYBeM6rzB7xUCjnlFj9+ir?=
 =?us-ascii?Q?6G4OZFqooNKU5NRINxb/n0XOwuvp0qb9WHDtXlJI2e2fEz/bO5cMGvC4/Ne4?=
 =?us-ascii?Q?MPRWU6GL4CwkP1ernFS9ue+bayh0wqQs2N6ybWtR12RLhE0aaLFwy5qmtw1U?=
 =?us-ascii?Q?gALvU8CpTXfxXxvGIDkGM922rzS/p7dn38tUvmHkZLC18JchWGFhhixPX/El?=
 =?us-ascii?Q?E0qwn2dEQIOVidYMCHxpyTOGyV2Zl31MLoCesfsW++QqmUIrSaiVZoxJfHdZ?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa3ea3e-c6da-486e-ab48-08dc9a630d59
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 06:48:59.7369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6yt1DT1YJpRt2koaNpwEBq7cbSsUZudfj6y6xtX/quHyB4D3/ULID09IAxY8G81y/6/05Xf8ur54xH3lmauHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6356
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Add test which adds environment variables to the FIT configuration node
and checks whether they are exported to the runtime environment.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 configs/sandbox_defconfig |  1 +
 test/py/tests/test_fit.py | 45 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 93b52f2de5c..7431c8a910e 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -142,6 +142,7 @@ CONFIG_ENV_IS_IN_EXT4=y
 CONFIG_ENV_EXT4_INTERFACE="host"
 CONFIG_ENV_EXT4_DEVICE_AND_PART="0:0"
 CONFIG_ENV_IMPORT_FDT=y
+CONFIG_ENV_IMPORT_FIT_CONF=y
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_NETCONSOLE=y
 CONFIG_IP_DEFRAG=y
diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 8f9c4b26411..2a3aba74502 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -74,6 +74,8 @@ base_its = '''
                         fdt = "fdt-1";
                         %(ramdisk_config)s
                         %(loadables_config)s
+                        %(env_var0)s
+                        %(env_var1)s
                 };
         };
 };
@@ -308,6 +310,13 @@ def test_fit(u_boot_console):
 
             'loadables_config' : '',
             'compression' : 'none',
+
+            'env_var0': '',
+            'env_var0_name': 'foo',
+            'env_var0_value': 'somevalue',
+            'env_var1': '',
+            'env_var1_name': 'bar',
+            'env_var1_value': 'anothervalue',
         }
 
         # Make a basic FIT and a script to load it
@@ -396,6 +405,42 @@ def test_fit(u_boot_console):
             check_not_equal(ramdisk, ramdisk_out, 'Ramdisk got decompressed?')
             check_equal(ramdisk + '.gz', ramdisk_out, 'Ramdist not loaded')
 
+        # Now a kernel, FDT and environment variables
+        with cons.log.section('Kernel + FDT load + env'):
+            params['fdt_load'] = 'load = <%#x>;' % params['fdt_addr']
+            params['env_var0'] = ('env,%s = "%s";' %
+                                 (params['env_var0_name'],
+                                  params['env_var0_value']))
+            params['env_var1'] = ('env,%s = "%s";' %
+                                 (params['env_var1_name'],
+                                  params['env_var1_value']))
+            fit = fit_util.make_fit(cons, mkimage, base_its, params)
+            cons.restart_uboot()
+
+            output = cons.run_command_list(cmd.splitlines())
+            check_equal(kernel, kernel_out, 'Kernel not loaded')
+            check_equal(control_dtb, fdt_out, 'FDT not loaded')
+            check_not_equal(ramdisk, ramdisk_out,
+                            'Ramdisk loaded but should not be')
+
+            # Check if bootargs strings substitution works
+            output = cons.run_command_list([
+                'env set bootargs \\\"\'my_boot_var=${%s}\'\\\"' % params['env_var0_name'],
+                'bootm prep',
+                'env print %s' % params['env_var0_name'],
+                'env print %s' % params['env_var1_name'],
+                'env print bootargs'])
+            assert ('%s=%s' %
+                    (params['env_var0_name'],
+                     params['env_var0_value'])) \
+                in output, "Environment not loaded from configuration"
+            assert ('%s=%s' %
+                    (params['env_var1_name'],
+                     params['env_var1_value'])) \
+                in output, "Environment not loaded from configuration"
+            assert 'bootargs="my_boot_var=%s"' % params['env_var0_value'] \
+                in output, "Bootargs strings not substituted"
+
 
     cons = u_boot_console
     # We need to use our own device tree file. Remember to restore it
-- 
2.30.2

