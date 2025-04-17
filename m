Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66D2C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 04:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7969C83020;
	Thu, 17 Apr 2025 06:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ukrhC1DC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0AA982F75; Thu, 17 Apr 2025 04:20:37 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E477182CBC
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 04:20:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0jKZeYQGO6EBxMaw/Iio3LCPUHYEjfutL+Q0mq8DrzuUL7zBIuRDiZK3JQGnuQNlTe1S95/VXNrpVcusVB2XjKjhBe1jrCCCrbTuf5QCMlHrZW3P3WgSVtr1ldUlWUyYz2Kf5U+rXEVr+kC8uo2UXGTUltGoI61lkMyF5RvuaLGXIT/vLFn9jnMNDK4FuQhto6AwzwKHHwbV+NW6/2kg+C0ijpLC8o1VGLTm1zxk6gQmCZJbHMEb9tnQquAHfnSsBFjIysXJB47DU7kCCP1wUwdHceTnXUO7OcwdLBVMVEkD3WM430Ep+/rF968GzrnVqy9HGjp2aqY67c3WVgJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7s63xP/tdrE890uCX/RPel4dafoi7S8Mb6KaimpScSo=;
 b=xCZ3VpNiv4MC8T34Gvf/7gRSS5FQa6jKE35Iqo9kithrUPkqqtEbq6XlAe6t4wz7GRKea3J9D3YWE8ItntQ4BaDyt95oP5FySTZcPBvI+bDb2rRSPUCxKPIFcJYtgdVAcAajGiXxqCg8d3DNn6dCoHlDCjcz90vPi+CriNEZDX4LEjV5QbHzCp4Poh4jxLrE7TVMfcwLSDsSHcHcsYSWY1z42yz0j9mvZTtFp+rPP59r7AyQynJWDPbfO7bV1VuuduJHAPO+tjoK4emnLM1Thfvc597HPt1dRW1Tfwb8xeDyts2rpc+C4zBkvTBpZi2wHymPa3uLHu6i984s24p3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7s63xP/tdrE890uCX/RPel4dafoi7S8Mb6KaimpScSo=;
 b=ukrhC1DCtDUHpbHkW+UPO42/+ZdeBAZEMHGY2E2qEUTFZa2/GMXrUeU2et064hWIToxu/kUhulYmoh7uI9JPo8jKnkxbgM4ahTsa77+kC2LXRm0p2i2oNweCyKnwaEbClXWm4zHlMnz3wS6PYYTyyKb1ZVjzyUKYC7CzRKBSR9Uw5LuxGNiNpOjNmZ1i3P1IftR49Pwx4KRXkh5qXI4sUVUrQIxw39zAs4Zut5nHtv+0jZo02vvbOujlcmyg4p1qXSR42HHe9qQb7T3Rw5Et7newaAZXYd4coVQCQWLB75fGHiianBvEvMFSCrCXksdMSP5aVFp6i8936+nFtfTdXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by PH7PR03MB7414.namprd03.prod.outlook.com (2603:10b6:510:2ef::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 02:20:32 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 02:20:32 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v4 09/12] cmd: Add i3c command support.
Date: Thu, 17 Apr 2025 10:18:37 +0800
Message-Id: <20250417021840.6212-10-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250417021840.6212-1-dinesh.maniyam@altera.com>
References: <20250417021840.6212-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|PH7PR03MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 1267090c-5e28-4e1e-a024-08dd7d566db6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QfNW4CGMXnclhrS6xLAFPKtnpZcm4jfq1Mfiw2OxRR3qvYUO95yBLk28KFvE?=
 =?us-ascii?Q?3KekpkFR8bPOyph5GC0fgBNHx7NvPK9u9Z9eo89pD1IhztsmWeBO3YSiAPjS?=
 =?us-ascii?Q?CXebg3U1csh8AJa7IIhDhadKtqR1LrOEZDLUjJ5a6ukL8veNh3gHIc3unoXk?=
 =?us-ascii?Q?Dftv3CynTC+xuyiGBCPu8NJQAnnRx8CiIx9vfI//bjZvMvsqJY3aIKiR630f?=
 =?us-ascii?Q?w98IHPOjZlNYwa1EjnBzT2H3mClu7eCmJqjpNT6lbuwLlFlswliWinzPXERb?=
 =?us-ascii?Q?3C6VKuKeShGKqtO5Uyw6LLP9iaCQuOV50qoSlNTEV+baGX+oapZ6AKEzldvo?=
 =?us-ascii?Q?zEA0G3qfeMNLxxSOBOL+1vGPWKz9/mtwW6ss7it95TJ+jboB6Su5+RQGpxb7?=
 =?us-ascii?Q?OIdeTghMABmHOqtfSSAbMRBlb5XKY9AUDM446d6DipVdnMk48bbtqnDaVbDO?=
 =?us-ascii?Q?bJ2+iB6N/LJxY3vybv1CctUGZVk6/+ApjWWnoAKU9775IjVEQcp87IPKHhZp?=
 =?us-ascii?Q?o9mKyb91B6JIyS3qvqa13Z9t73Rvs+/+GqsLKZv117VV1sNQl7cBZj2uvGxV?=
 =?us-ascii?Q?i6T5A0eeV3wxlKppNwUXXpsREj9owr5Knl1WiZaQmLMhtT3MAypZA7l72+Vc?=
 =?us-ascii?Q?9THhDJYMl2d5tVdt53KSRz17WESkUIMkA4Z0CIe4eSeuOt60o2vr0/LYzMPD?=
 =?us-ascii?Q?7z8kSGdzzXPQyINJq4bPXbFACUbTprXKsnI+d7WuzVfIWhRVJGPw5j1t9buK?=
 =?us-ascii?Q?50qkwLhYViF9PeDdyJgNkzCA9xZTSkuWyO7AaW+So+s2IUIgqmLrkI19sZts?=
 =?us-ascii?Q?1cfWPTtkVmpNt/4VXZ9UJDaOiiBMQZDOz2ITcXFShY0PxeuAdmD5dtjBmEqX?=
 =?us-ascii?Q?flv0Gytg3//G81ZLkOBre6Pd83J3N6iyYXV2Hpo4EDZXVX1cfx3T/xQyOm1D?=
 =?us-ascii?Q?r3UfnpoZvnQPFU7oMG8FXsL+0HosdEgrr97hzRa6T7+Qu3jedA9eaYMofSgV?=
 =?us-ascii?Q?HFW+rB5dBMZx5kRlqIYj/Sb0a39WA/JWUbO7KswFXOEY/dHLsL62Yg8WeCqN?=
 =?us-ascii?Q?0S0/O4bp5Ehyi0jMBo97goyr3vkP1Se/vyUpjd+53K/r/GnLHfM+mw4Bc+7k?=
 =?us-ascii?Q?xJfbQah83a2VNy7+Fs1I6DtgS9g2o/UXJFMV5TEUEp2VTtdtbnvsNbGrhCoE?=
 =?us-ascii?Q?xfc+yWoDcQOmOtvlQXM8QCdb0HXoDWF2h2zKwnm+3jbay17u5xnBE3TBEjgV?=
 =?us-ascii?Q?7MpkBEqUGKtvpM2krCo+Y61dbFDGJf8kcQu81KXKd+Bp/KO252UUuJrs0TYT?=
 =?us-ascii?Q?YO6kScTyUzMRXC1UtLpzkMY1RDBLlGt7EHSTl7l0jBf0QQ0iMfr+0myDLkiq?=
 =?us-ascii?Q?H+pJta/ryz34vCtUXi1tCHoTG4FWtU2CXlA/1De9q9KnqXZkl8z8EqL8h2ct?=
 =?us-ascii?Q?tKFJT6k/EE0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4u5J73PYUiCVT7sOfjnAxI7/zRggO9Y3NHlYRvyafrt7dNdYxeYUME2UuDn6?=
 =?us-ascii?Q?TtJtRrFCOff3QjCVpaq1QZH/TvUbEOvL1rC/ucDXw/swCWnMDV93mP3fL4ZG?=
 =?us-ascii?Q?NDbUjeT3Y1yhpsvGQr6RPGV0NwX3rkVTudgqrax/R2uVxrXfL6oa+NoSFaVx?=
 =?us-ascii?Q?UvmGvWlvqDqc3pFnJ4EG9UnBjs8HQq4W6GsmhZuwzPPq1nAZ7tt+sG8Rf4Sg?=
 =?us-ascii?Q?G5hbgRpfibNJ0OhQNDFja27WOrE7p+K91SvUgl+3lMtzDpFmqY1j4iyf75v6?=
 =?us-ascii?Q?+uc00Iww5Z2p+ZTTJTQ+lh4DN6XmGtgUOQt9yBFvCIy19uIkcuxx0//eov98?=
 =?us-ascii?Q?07t7Jicn8Iqs8DJdpIKGQxi0lzbNzQ4fgB1YdjHNgWD2ZVkMGmna4WL51f57?=
 =?us-ascii?Q?iT2IMFB0+lfA3dLB8iSv0dGLJah49uosRtQRzel05IBvfh11YAKBJENFer/z?=
 =?us-ascii?Q?cvfrAFs/C0r3MkaWZReFNiFMNMYBPf4OiZ5hf4vNd8WMzkjLw2i+n2vq/DpG?=
 =?us-ascii?Q?6NBJR6QDz6/uhNqcN5N36pCINK6u8lJUA8QqNpmfEt6EVKbdYI61D0UG0oo9?=
 =?us-ascii?Q?7yqqvQeuBc2YHpmcLMFEbr+Z7RDTtUVffV7xLox+GECcOnFew+XoNulGMZoS?=
 =?us-ascii?Q?Kryt4VPzsfbYYzmP2/si4lzOtoVFz5rLEBlj/xRBpGxh09Lu2AS2oz5BIpmu?=
 =?us-ascii?Q?lpvvY6JiqOPgL6biA9Zy9BI1jVpYNyzVNNg1LirXEGH+Xr/djrUZrSuvomix?=
 =?us-ascii?Q?UmEk7yAp94hBQEWfS9cCapnmhiFuYszbt30CPTB00j3vGUxd3ZZFSl0Vuzjc?=
 =?us-ascii?Q?gXf7p3vBugiI3vLgBsq+OxL4f8VNy6GvwdWzz8nB32oyRhIFIvHh5Y7qw8Mh?=
 =?us-ascii?Q?tA0lisuYuGUZtGoTcoYdAuUwrPbjrXymwzVKTCPs079cX+JaA3oqGEdy6DuR?=
 =?us-ascii?Q?YXrr1kZ9M6ENjhMVFQzcnVYCcud3ZlrdRb9wLKyOmue+0fTfbg+nDHqtGpwb?=
 =?us-ascii?Q?AZQihA+pYuwS21eSske+apkcWfYTCf1BGraGGvVJCGBIP6BkLW13YMRLpRZO?=
 =?us-ascii?Q?ofFkjTTIB1qgsswHZUD2ME3+mvGANXnP43HT+XVpl1if312uzKhLr4yA+9aY?=
 =?us-ascii?Q?QoAyiw81JyHnYxMWehrauGAgli/xweTlERoQbIExDihIxfi0n/3vmOKp7ns/?=
 =?us-ascii?Q?HyZvSuVVi0sRyrLXFbFToMuwWW0wAKv9SyaBOJH8idwThc4kv4S3pL9mvita?=
 =?us-ascii?Q?niYyE+i32LIjV42Giitb6vWHh5UnDvom400MydetyqgljlCyuaM2QMDLdQOY?=
 =?us-ascii?Q?0MX+qFvgE1MqtCLwqOiZUME8oE3fMg3DHIK2F6wdU/sv5HdA90EqFUQGuMhB?=
 =?us-ascii?Q?WiqWDdZpu0akW5HTq4+6lPQSNAGP0DeW1noOjhPLnITwf2Rug+DIji6zr+tu?=
 =?us-ascii?Q?riCwBKIvpTnYdnWX6S7mEuNiCAT+QjE9iWdBKrWJYHqzCgfebErwpFHXsi4V?=
 =?us-ascii?Q?ioX32ma+suwtfMmJJrAOsCx4caH2awUAOeqVbNq5SikYnhZvR5EgQFt4NJNI?=
 =?us-ascii?Q?Mqwk0hcos9XVQu0SsSTXv1cLLxMwDGyMitVSdz9bBYASD97OHXhtHE1DGu5N?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1267090c-5e28-4e1e-a024-08dd7d566db6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 02:20:32.0630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDuMfMD0nACk3MPyMJ/5A7kv9RORE7qnXVoeyKmVOKOXL1lhAb90fBoB8626lpFru1szdoeYDJYD/OZU9sqFEQjQBqdCblEwpNhjNl5TjNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7414
X-Mailman-Approved-At: Thu, 17 Apr 2025 06:57:49 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add i3c command file to support select, get i3c device
target list, read and write operation.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 cmd/Kconfig                        |   6 +
 cmd/Makefile                       |   1 +
 cmd/i3c.c                          | 193 +++++++++++++++++++++++++++++
 doc/usage/cmd/i3c.rst              |  98 +++++++++++++++
 doc/usage/index.rst                |   1 +
 drivers/i3c/master/dw-i3c-master.c |  35 +++++-
 include/dw-i3c.h                   |   2 +
 include/i3c.h                      |   4 +
 8 files changed, 339 insertions(+), 1 deletion(-)
 create mode 100644 cmd/i3c.c
 create mode 100644 doc/usage/cmd/i3c.rst

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 642cc1116e8..551959731f0 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1327,6 +1327,12 @@ config CMD_I2C
 	help
 	  I2C support.
 
+config CMD_I3C
+	bool "i3c"
+	help
+	  Enable command to list i3c devices connected to the i3c controller
+	  and perform read and write on the connected i3c devices.
+
 config CMD_W1
 	depends on W1
 	default y if W1
diff --git a/cmd/Makefile b/cmd/Makefile
index 8410be576bb..082470fa104 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_CMD_GPIO) += gpio.o
 obj-$(CONFIG_CMD_HISTORY) += history.o
 obj-$(CONFIG_CMD_HVC) += smccc.o
 obj-$(CONFIG_CMD_I2C) += i2c.o
+obj-$(CONFIG_CMD_I3C) += i3c.o
 obj-$(CONFIG_CMD_IOTRACE) += iotrace.o
 obj-$(CONFIG_CMD_HASH) += hash.o
 obj-$(CONFIG_CMD_IDE) += ide.o disk.o
diff --git a/cmd/i3c.c b/cmd/i3c.c
new file mode 100644
index 00000000000..5631f487cc2
--- /dev/null
+++ b/cmd/i3c.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Intel Coporation.
+ */
+
+#include <bootretry.h>
+#include <cli.h>
+#include <command.h>
+#include <console.h>
+#include <dm.h>
+#include <dw-i3c.h>
+#include <edid.h>
+#include <errno.h>
+#include <log.h>
+#include <malloc.h>
+#include <asm/byteorder.h>
+#include <linux/compiler.h>
+#include <linux/delay.h>
+#include <u-boot/crc.h>
+#include <linux/i3c/master.h>
+
+static struct udevice *currdev;
+static struct udevice *prevdev;
+static struct dw_i3c_master *master;
+
+void low_to_high_bytes(void *data, size_t size)
+{
+	unsigned char *byte_data = (unsigned char *)data;
+	size_t start = 0;
+	size_t end = size - 1;
+
+	while (start < end) {
+		unsigned char temp = byte_data[start];
+
+		byte_data[start] = byte_data[end];
+		byte_data[end] = temp;
+		start++;
+		end--;
+	}
+}
+
+/**
+ * do_i3c() - Handle the "i3c" command-line command
+ * @cmdtp:    Command data struct pointer
+ * @flag:    Command flag
+ * @argc:    Command-line argument count
+ * @argv:    Array of command-line arguments
+ *
+ * Returns zero on success, CMD_RET_USAGE in case of misuse and negative
+ * on error.
+ */
+static int do_i3c(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	struct uclass *uc;
+	int ret;
+	struct udevice *dev_list;
+	u32 length, bytes;
+	u8 *data;
+	u8 *rdata;
+	u8 device_num;
+
+	if (argc > 1) {
+		ret = uclass_get_device_by_name(UCLASS_I3C, argv[1], &currdev);
+		if (ret) {
+			if (!strcmp(argv[1], "help"))
+				return CMD_RET_USAGE;
+
+			currdev = prevdev;
+			if (!currdev) {
+				ret = uclass_get(UCLASS_I3C, &uc);
+				if (ret)
+					return CMD_RET_FAILURE;
+
+				uclass_foreach_dev(dev_list, uc)
+					printf("%s (%s)\n", dev_list->name, dev_list->driver->name);
+
+				printf("i3c master controller is not initialized: %s\n", argv[1]);
+				return CMD_RET_FAILURE;
+			}
+		} else {
+			master = dev_get_priv(currdev);
+			printf("current dev: %s\n", currdev->name);
+			prevdev = currdev;
+		}
+	} else {
+		if (!currdev) {
+			printf("No i3c device set!\n");
+			return CMD_RET_FAILURE;
+		}
+		printf("dev: %s\n", currdev->name);
+	}
+
+	if (!strcmp(argv[1], "list")) {
+		ret = uclass_get(UCLASS_I3C, &uc);
+		if (ret)
+			return CMD_RET_FAILURE;
+
+		uclass_foreach_dev(dev_list, uc)
+		printf("%s (%s)\n", dev_list->name, dev_list->driver->name);
+	}
+
+	if (!strcmp(argv[1], "current")) {
+		if (!currdev)
+			printf("no current dev!\n");
+		else
+			printf("current dev: %s\n", currdev->name);
+	}
+
+	if ((!strcmp(argv[1], "write")) && !(argv[2] == NULL) && !(argv[3] == NULL) &&
+	    !(argv[4] == NULL)) {
+		length = hextoul(argv[3], NULL);
+
+		data = (u8 *)malloc(sizeof(u8) * length);
+		if (!data) {
+			debug("Memory allocation for data failed\n");
+			return -ENOMEM;
+		}
+
+		device_num = hextoul(argv[4], NULL);
+		bytes = hextoul(argv[2], NULL);
+
+		for (int i = 0; i < length; i++)
+			data[i] = (u8)((bytes >> (8 * i)) & 0xFF);
+
+		low_to_high_bytes(data, length);
+		ret = dm_i3c_write(currdev, device_num, data, length);
+		if (ret) {
+			ret = CMD_RET_FAILURE;
+			goto write_out;
+		}
+	}
+
+	if (!strcmp(argv[1], "read") && !(argv[2] == NULL) && !(argv[3] == NULL)) {
+		length = hextoul(argv[2], NULL);
+
+		rdata = (u8 *) malloc(sizeof(u8) * length);
+		if (!rdata) {
+			debug("Memory allocation for rdata failed\n");
+			return -ENOMEM;
+		}
+
+		device_num = hextoul(argv[3], NULL);
+
+		ret = dm_i3c_read(currdev, device_num, rdata, length);
+		if (ret) {
+			ret =  CMD_RET_FAILURE;
+		} else {
+			printf("Read buff: ");
+			for (size_t i = 0; i < length; ++i)
+				printf("%02x", rdata[i]);
+
+			printf("\n");
+		}
+
+		goto read_out;
+	}
+
+	if (!strcmp(argv[1], "device_list")) {
+		if (master) {
+			for (int i = 0; i < master->num_i3cdevs; i++) {
+				printf("device:%d\n", i);
+				printf("dynamic address:0x%X\n", master->i3cdev[i]->info.dyn_addr);
+				printf("PID:%llx\n", master->i3cdev[i]->info.pid);
+				printf("BCR:%X\n", master->i3cdev[i]->info.bcr);
+				printf("DCR:%X\n", master->i3cdev[i]->info.dcr);
+				printf("Max Read DS:%X\n", master->i3cdev[i]->info.max_read_ds);
+				printf("Max Write DS:%X\n", master->i3cdev[i]->info.max_write_ds);
+				printf("\n");
+			}
+		}
+	}
+
+	return CMD_RET_SUCCESS;
+
+read_out:
+	free(rdata);
+	return ret;
+
+write_out:
+	free(data);
+	return ret;
+}
+
+U_BOOT_CMD(
+	i3c,    5,    1,     do_i3c,
+	"access the system i3c\n",
+	"i3c write<data><length><device_number> - write to device.\n"
+	"i3c read<length><device_number> - read from device.\n"
+	"i3c device_list   - List valid target devices\n"
+	"i3c <i3c name>   - Select i3c controller.\n"
+	"i3c list   - List all the available i3c controller.\n"
+	"i3c current   - print current i3c controller.\n"
+);
diff --git a/doc/usage/cmd/i3c.rst b/doc/usage/cmd/i3c.rst
new file mode 100644
index 00000000000..ade7b5c7fc4
--- /dev/null
+++ b/doc/usage/cmd/i3c.rst
@@ -0,0 +1,98 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. index::
+   single: i3c (command)
+
+i3c command
+===========
+
+Synopsis
+--------
+
+::
+
+    i3c <i3c name>
+    i3c current
+    i3c list
+    i3c device_list
+    i3c write <data> <length> <device_number>
+    i3c read <length> <device_number>
+
+
+Description
+-----------
+
+The ``i3c`` command is used to probe i3c master controller and perform read
+and write on the i3c devices.
+
+i3c current
+------------
+
+* Display the current probed i3c controller.
+
+i3c list
+----------
+
+List all the i3c controllers defined in the DT.
+
+i3c device_list
+----------------
+
+List all the i3c devices' device number, dynamic address, PID, BCR, DCR,
+Max Write Speed and Max Read Speed of the probed i3c controller.
+
+i3c write
+-----------
+
+Perform write to the i3c device.
+
+i3c read
+-----------
+
+Perform read from the i3c device.
+
+i3c name
+    i3c name defined in DT
+
+length
+    Size of the data.
+
+device_number
+    device number that connected to i3c controller.
+
+data
+    Bytes to be written to device.
+
+Examples
+--------
+
+Probe i3c0::
+
+    => i3c i3c0
+
+Check cuurent i3c controller::
+
+    => i3c current
+
+Check the device number and PID of the connected devices::
+
+    => i3c device_list
+
+Perform write AA byte to a device 0::
+
+    => i3c write AA 1 0
+
+Perform read from a device 0::
+
+    => i3c read 1 0
+
+Configuration
+-------------
+
+The ``i3c`` command is only available if CONFIG_CMD_I3C=y.
+
+Return value
+------------
+
+If the command succeeds, the return value ``$?`` is set to 0. If an error occurs, the
+return value ``$?`` is set to 1.
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index bf2335dc8f0..718b606b162 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -80,6 +80,7 @@ Shell commands
    cmd/if
    cmd/itest
    cmd/imxtract
+   cmd/i3c
    cmd/load
    cmd/loadb
    cmd/loadm
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index bf5d57937c7..623f5b01dbb 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -674,8 +674,11 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	newdevs &= ~olddevs;
 
 	for (pos = 0; pos < master->maxdevs; pos++) {
-		if (newdevs & BIT(pos))
+		if (newdevs & BIT(pos)) {
 			i3c_master_add_i3c_dev_locked(m, master->addrs[pos]);
+			master->i3cdev[pos] = m->this;
+			master->num_i3cdevs++;
+		}
 	}
 
 	dw_i3c_master_free_xfer(xfer);
@@ -1010,8 +1013,38 @@ err_assert_rst:
 	return ret;
 }
 
+static int dw_i3c_master_priv_read(struct udevice *dev, u8 dev_number,
+				   u8 *buf, int buf_size)
+{
+	struct dw_i3c_master *master = dev_get_priv(dev);
+	struct i3c_dev_desc *i3cdev = master->i3cdev[dev_number];
+	struct i3c_priv_xfer i3c_xfers;
+
+	i3c_xfers.data.in = buf;
+	i3c_xfers.len = buf_size;
+	i3c_xfers.rnw = I3C_MSG_READ;
+
+	return dw_i3c_master_priv_xfers(i3cdev, &i3c_xfers, 1);
+}
+
+static int dw_i3c_master_priv_write(struct udevice *dev, u8 dev_number,
+				    u8 *buf, int buf_size)
+{
+	struct dw_i3c_master *master = dev_get_priv(dev);
+	struct i3c_dev_desc *i3cdev = master->i3cdev[dev_number];
+	struct i3c_priv_xfer i3c_xfers;
+
+	i3c_xfers.data.out = buf;
+	i3c_xfers.len = buf_size;
+	i3c_xfers.rnw = I3C_MSG_WRITE;
+
+	return dw_i3c_master_priv_xfers(i3cdev, &i3c_xfers, 1);
+}
+
 static const struct dm_i3c_ops dw_i3c_ops = {
 	.i3c_xfers = dw_i3c_master_priv_xfers,
+	.read = dw_i3c_master_priv_read,
+	.write = dw_i3c_master_priv_write,
 };
 
 static const struct udevice_id dw_i3c_ids[] = {
diff --git a/include/dw-i3c.h b/include/dw-i3c.h
index 42c37d6dfa2..c652de77404 100644
--- a/include/dw-i3c.h
+++ b/include/dw-i3c.h
@@ -241,6 +241,8 @@ struct dw_i3c_master {
 	char type[5];
 	u8 addrs[MAX_DEVS];
 	bool first_broadcast;
+	struct i3c_dev_desc *i3cdev[I3C_BUS_MAX_DEVS];
+	u16 num_i3cdevs;
 };
 
 struct dw_i3c_i2c_dev_data {
diff --git a/include/i3c.h b/include/i3c.h
index 6ef4982dcf6..969753ae49d 100644
--- a/include/i3c.h
+++ b/include/i3c.h
@@ -28,6 +28,10 @@ struct dm_i3c_ops {
 	int (*i3c_xfers)(struct i3c_dev_desc *dev,
 			 struct i3c_priv_xfer *i3c_xfers,
 			 int i3c_nxfers);
+	int (*read)(struct udevice *dev, u8 dev_number,
+		    u8 *buf, int num_bytes);
+	int (*write)(struct udevice *dev, u8 dev_number,
+		     u8 *buf, int num_bytes);
 };
 
 #define i3c_get_ops(dev)	((struct dm_i3c_ops *)(dev)->driver->ops)
-- 
2.35.3

