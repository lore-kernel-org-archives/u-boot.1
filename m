Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967D5C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 22:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D429387FEE;
	Thu, 30 May 2024 00:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=shymega.org.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shymega.org.uk header.i=@shymega.org.uk header.b="pVGvM8KR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CF3F88667; Thu, 30 May 2024 00:40:24 +0200 (CEST)
Received: from GBR01-LO4-obe.outbound.protection.outlook.com
 (mail-lo4gbr01hn2249.outbound.protection.outlook.com [52.100.228.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C418B87F19
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 00:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=shymega.org.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shymega@shymega.org.uk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/dCWGXk99r0n27yS59v47O8Uv7qqnNz9WJMclcIQlSjpwnfVqsP2ZRMNTb0lOyZl5Xw63EmwZ3Sl6yd82U+Xp/DTWu63BX/nSkykqy/Z4eVb3KiqM8QtCeex+8B78uYzn/bqZp1JD3FJB09NUIx7TklsVrAsow9n4FQ/giP78UXfdgJ/OkcTcUFVE3wmO/u6jHSAVKhh03ZEaHR0ODdkte93bzEk8GyBOaS1H9BCNOUXfbo9/I8U34NbH6PU3Iqw0ueZi4sentGlJwV1vsOsRM6PC+bx1OfwWRnHcuPP+pGmqQN99tpZW1EBtgXNd4CNrx1y07eDdLva/OpZAoeJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw1F2ZP78bH78nUgTRKjfqTWg2Wv6wEbTVpakTdQS34=;
 b=I+XJrgiIqLatibkF33qNIP5fnDNUKTdddO+BR7ATjyXdaW7MBpyMlY3LSDFJhzmxS9TA7xyMJx+eHdL6cT+/wVgCP5L4wymw7O1I049ibRxhxNoBX7f60tKw2kzbGwEvERBxAK6OyT2SZMwc3T+P63szg0U9hkCoV/VM+gYUJh6DWAHd6L80IsMmzqBH65szo0cDW4MEC6quH87pdLGOigIFGRwROpIR9LJd8lde7j8K29moCJUQjkuNHMOlgD9vfF2eYyXWGaIEGvOdKtJ4RAV+sig3a7CSXfWbUb7cyo0Uju0/AgnvCz9hcTXqtMTyIeu/blG0cxF79Y9rU83O/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 62.210.214.198) smtp.rcpttodomain=arm.com smtp.mailfrom=shymega.org.uk;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=shymega.org.uk;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shymega.org.uk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw1F2ZP78bH78nUgTRKjfqTWg2Wv6wEbTVpakTdQS34=;
 b=pVGvM8KREieXIVz3Jq5xGGUjzLCaD4VT63Vsg+K6b4QcgeBYblfFI+n3QJUZQsQbx3IcKfQ1YJMLW+qZZvIaAs/1sS6plKp790GoIbw7U0DOCbtNhRNa5Edsbw+1ajUHlPpN3tpVu9zr4G2UoLBemh/LpM4wh7NbsYyaZ1wmEX9L+xeb5kuUTr06Jcg5LlLFcjVrQgnpmAeEGcL5ZGwZc2bkbL1sJOG8lD1s1aoKNQkgsypjPr5T8HyjLXoDZqX1zNW1tvaXNi/KnEcLDePvM6pZLxrONKudIZsZBzEKIP5RXhey1FK7WoYHlv2aokVhBD5JMlsYdfmxEz00e+NNDA==
Received: from CWLP265CA0545.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18d::10)
 by LO0P265MB6913.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2d7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 22:40:20 +0000
Received: from CW2PEPF000056C0.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:18d:cafe::58) by CWLP265CA0545.outlook.office365.com
 (2603:10a6:400:18d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Wed, 29 May 2024 22:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 62.210.214.198)
 smtp.mailfrom=shymega.org.uk; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=shymega.org.uk;
Received-SPF: Pass (protection.outlook.com: domain of shymega.org.uk
 designates 62.210.214.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=62.210.214.198;
 helo=oracle.rodriguez.org.uk; pr=C
Received: from oracle.rodriguez.org.uk (62.210.214.198) by
 CW2PEPF000056C0.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 22:40:20 +0000
Received: from NEO-LINUX.localdomain (10bsk.rnet.rodriguez.org.uk
 [217.155.6.253])
 by oracle.rodriguez.org.uk (Postfix) with ESMTPSA id E7BE9ACA002B;
 Wed, 29 May 2024 22:40:19 +0000 (UTC)
Received: from NEO-LINUX (localhost [IPv6:::1])
 by NEO-LINUX.localdomain (Postfix) with SMTP id 60A96201848;
 Wed, 29 May 2024 23:31:40 +0100 (BST)
Date: Wed, 29 May 2024 23:31:40 +0100
From: "Dom (shymega) Rodriguez" <shymega@shymega.org.uk>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 6/7] tools: add genguid tool
Message-ID: <auugb3zy7zcgxpspjjmfiz4znijcegomk7buss7ru33kohtpf7@6gkfy4joeb5u>
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
 <20240529-b4-dynamic-uuid-v2-6-c26f31057bbe@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6qwm34kryihn6jac"
Content-Disposition: inline
In-Reply-To: <20240529-b4-dynamic-uuid-v2-6-c26f31057bbe@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW2PEPF000056C0:EE_|LO0P265MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d52397-a59a-406a-eed1-08dc80305213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|7416005|376005|36860700004|11100799042; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TW9rUTFhTmdtUmxiT2lDdis5WWhCdm9FMHhLanUzRVZsTHNvdG5jYlVsTFhq?=
 =?utf-8?B?aUZXaFhjbk11YTNtTzRFNnlQcGtXRmZhY2lvQkxhSHNuSU9XSnZCS3IrSXJi?=
 =?utf-8?B?MHJXd0h2S0JUYWpRSnZlOUJkUjJnc3kwNFlJNGg0NURqMVQxT1pyQWpZVldz?=
 =?utf-8?B?NjRpTnJyNFVGYmszcG5GM2tCQ1NRR29wTlFncTBacEJIaUJWRVJEdENaWmdF?=
 =?utf-8?B?YlBXekhMaXhadHJjRkVJbENRanpNanlnZ0JZRFRIRDdMUDVuM3liWUpiUGJk?=
 =?utf-8?B?ZzZHR0RVYUh6REpBU3JVTWtZRFJuaTZReVNWclJ6OGgrSVEvL1JNamdXMTQ4?=
 =?utf-8?B?MXNJdDlGbVIyOVV6blJ2L0RaME01YlM3ZHFPYWFuWTVSZVkrZ012WUc4L1R0?=
 =?utf-8?B?Z2JZNW9PRHhHTkt4dm9NYkd3ZkJNTDBGNmhDT1NXL3VSYUE2LzF4QnBpUGFE?=
 =?utf-8?B?VGFoU0QrZmRha05zZnlhakNlTmhjQkpiNHVnZzh1d0RCZmlqa2tyUEU5TFAy?=
 =?utf-8?B?RGN1N1MrOXhLdkpEMERuQ0FGOXVVYmZ0aTFkeXlTZzluM1FBREFkZlpIUUJq?=
 =?utf-8?B?VWNmS1RrbVRlN3o1dTFBaEhYbzVud1M3SmpFdzduRElxcnRCZ0JMWHYwd2s0?=
 =?utf-8?B?clBYTy9Vay9OajJlcEk0ajVyMkhjS1hqUkdsRlM2N0FrSllZMklNdGFmMWxW?=
 =?utf-8?B?VWIra1kyTXVrQWhIWUVHTS9pWGE1dVIrNGcraGZCNDc1NWxndGtFSGZwQjdn?=
 =?utf-8?B?ZURVRkpqYjE1ZWlBSmQ1L0kxTVhIU3krQy8za2s1TE8xL24vbCtUR1c0TEpH?=
 =?utf-8?B?Q1JxbFh6QVRiOXJJam4wZFY2b1BlcUpZL2pGTnhEejY2OWlxVmsxK1JMelJP?=
 =?utf-8?B?MHRDSEJXUXhOWi83USsyNE5DK0tSSGwvY2ZSb2Erb0ZwYUhqcGZHZ0lXdGVi?=
 =?utf-8?B?YVA1eFBtbnU4QXJOWjVlakdWV3dRWitsbnlvZjBVcmcxTk5odGYzN3VKSXg5?=
 =?utf-8?B?ZnNCRjFtN2hlOUl0QWc0WHJjSXZDS3RBVDdNM0FXQUVNL2J1RHZZQnk2TW5X?=
 =?utf-8?B?OG52VERHVDdOQzMzUzVZYnZaK1pEVnZzbzgyeEptUzVaZE0rWkROdUI0Zk9J?=
 =?utf-8?B?M2IxZ0VhclA2bllOeWVaOVRDU2pOM2cvbC9aMHJLYjJVRVpkNXZSRENESDRn?=
 =?utf-8?B?OXFZZnJjWGZybXFGQVk3anpqVWZvaGFmbkxYZ3B1NDNmYm9kbVZCa2Q4STRP?=
 =?utf-8?B?ZGhDUVNnZGZLTXNnMFEyWm1NSnp3azI0Uk5CL3hBb0t0NXZ5OHBuVkQrYVVQ?=
 =?utf-8?B?R1h2T3BNMmFxVElpVWorb2srbkc3VC9xNnRKNENEYXRycTRTVDNGVHZXN2Fl?=
 =?utf-8?B?SUswVHpvWGpmcEZwQnRDK21Vd3ZYUS9lQmMyNVd3byttc1FBU0szbVQydTBh?=
 =?utf-8?B?SlArVXRvSGtldmZQblNURFBieHB0NjN2NHhhQmVYTmhWTC8wSUtQcTNQZmh0?=
 =?utf-8?B?MzVRQ29pbmp5amt6K3pVeTdqUGhZRktPWHc1MEd4RUF0S2djY25RNytsbWJE?=
 =?utf-8?B?amRITXFGWDdUMUFpRytzNlBaVWhlN1lzOW1UcEc5Y25UaDVLMDI5OXI5Wk9x?=
 =?utf-8?B?R3I1UnN5dklFY3hidlFSa3M1YzlZUzNOWWlsMEI5cVlMVlJEWWQ4d05TVk0r?=
 =?utf-8?B?VFFvenJhTXR3b2VhaXJTZUtDMTdmZjFTMU04VmE1U3Q2OXJZR0dDYS9idUxR?=
 =?utf-8?B?NWhBaU9yODJmR09UN1NNT2JSV0ZQQ1g2YTUxbm51aWZjajBKME16TFVFOWI2?=
 =?utf-8?B?TkVieVpXbVhQOGczU2EycjBEZGJFN3BDQkF4S0V0Yzd3a1ZPTkRlNjZyOXY2?=
 =?utf-8?Q?uPkSY75vMmisD?=
X-Forefront-Antispam-Report: CIP:62.210.214.198; CTRY:FR; LANG:; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oracle.rodriguez.org.uk; PTR:oracle.rodriguez.org.uk;
 CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(7416005)(376005)(36860700004)(11100799042);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: shymega.org.uk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 22:40:20.2810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d52397-a59a-406a-eed1-08dc80305213
X-MS-Exchange-CrossTenant-Id: 7e15dc52-0465-4028-b82a-3c894bbc5ba6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=7e15dc52-0465-4028-b82a-3c894bbc5ba6; Ip=[62.210.214.198];
 Helo=[oracle.rodriguez.org.uk]
X-MS-Exchange-CrossTenant-AuthSource: CW2PEPF000056C0.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6913
X-Mailman-Approved-At: Thu, 30 May 2024 00:54:27 +0200
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


--6qwm34kryihn6jac
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.05.2024 16:48, Caleb Connolly wrote:
>Add a tool that can generate GUIDs that match those generated internally
>by U-Boot for capsule update fw_images.
>
>Dynamic UUIDs in U-Boot work by taking a namespace UUID and hashing it
>with the board model, compatible, and fw_image name.
>
>This tool accepts the same inputs and will produce the same GUID as
>U-Boot would at runtime.
>
>Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>---
> tools/Makefile  |   3 ++
> tools/genguid.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
> 2 files changed, 157 insertions(+)
>
>diff --git a/tools/Makefile b/tools/Makefile
>index 6a4280e3668f..7db7723793d5 100644
>--- a/tools/Makefile
>+++ b/tools/Makefile
>@@ -253,8 +253,11 @@ HOSTLDLIBS_mkeficapsule +=3D \
> HOSTLDLIBS_mkeficapsule +=3D \
> 	$(shell pkg-config --libs uuid 2> /dev/null || echo "-luuid")
> hostprogs-$(CONFIG_TOOLS_MKEFICAPSULE) +=3D mkeficapsule
>
>+genguid-objs :=3D generated/lib/uuid.o generated/lib/sha1.o genguid.o
>+hostprogs-$(CONFIG_TOOLS_MKEFICAPSULE) +=3D genguid
>+
> mkfwumdata-objs :=3D mkfwumdata.o generated/lib/crc32.o
> HOSTLDLIBS_mkfwumdata +=3D -luuid
> hostprogs-$(CONFIG_TOOLS_MKFWUMDATA) +=3D mkfwumdata
>
>diff --git a/tools/genguid.c b/tools/genguid.c
>new file mode 100644
>index 000000000000..dbac65d42623
>--- /dev/null
>+++ b/tools/genguid.c
>@@ -0,0 +1,154 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * Copyright 2024 Linaro Ltd.
>+ *   Author: Caleb Connolly
>+ */
>+
>+#include <getopt.h>
>+#include <stdbool.h>
>+#include <stdint.h>
>+#include <stdio.h>
>+#include <stdlib.h>
>+#include <string.h>
>+#include <linux/types.h>
>+
>+#include <uuid.h>
>+
>+static struct option options[] =3D {
>+	{"dtb", required_argument, NULL, 'd'},
>+	{"compat", required_argument, NULL, 'c'},
>+	{"help", no_argument, NULL, 'h'},
>+	{"verbose", no_argument, NULL, 'v'},
>+	{"json", no_argument, NULL, 'j'},
>+	{NULL, 0, NULL, 0},
>+};
>+
>+static void usage(const char *progname)
>+{
>+	fprintf(stderr, "Usage: %s GUID [-v] -c COMPAT NAME...\n", progname);
>+	fprintf(stderr,
>+		"Generate a v5 GUID for one of more U-Boot fw_images the same way U-Boo=
t does at runtime.\n");
>+	fprintf(stderr,
>+		"\nOptions:\n"
>+		"  GUID                     namespace/salt GUID in 8-4-4-4-12 format\n"
>+		"  -h, --help               display this help and exit\n"
>+		"  -c, --compat=3DCOMPAT      first compatible property in the board de=
vicetree\n"
>+		"  -v, --verbose            print debug messages\n"
>+		"  -j, --json               output in JSON format\n"
>+		"  NAME...                  one or more names of fw_images to generate =
GUIDs for\n"
>+	);
>+	fprintf(stderr, "\nExample:\n");
>+	fprintf(stderr, "  %s 2a5aa852-b856-4d97-baa9-5c5f4421551f \\\n"
>+			"\t-c \"qcom,qrb4210-rb2\" \\\n"
>+			"\tQUALCOMM-UBOOT\n", progname);
>+}
>+
>+size_t u16_strsize(const uint16_t *in)
>+{
>+	size_t i =3D 0, count =3D UINT16_MAX;
>+
>+	while (count-- && in[i])
>+		i++;
>+
>+	return (i + 1) * sizeof(uint16_t);
>+}

Hi Caleb,

Consistency-wise, unless you wanted this function (`u16_strsize`) non-stati=
c,
it would be more consistent to make it static, like the `usage` function.=
=20

Otherwise LGTM.

>+
>+int main(int argc, char **argv)
>+{
>+	struct uuid namespace;
>+	char *namespace_str;
>+	char uuid_str[37];
>+	char **image_uuids;
>+	char *compatible =3D NULL;
>+	uint16_t **images_u16;
>+	char **images;
>+	int c, n_images;
>+	bool debug =3D false, json =3D false;
>+
>+	if (argc < 2) {
>+		usage(argv[0]);
>+		return 1;
>+	}
>+
>+	namespace_str =3D argv[1];
>+
>+	/* The first arg is the GUID so skip it */
>+	while ((c =3D getopt_long(argc, argv, "c:hvj", options, NULL)) !=3D -1) {
>+		switch (c) {
>+		case 'c':
>+			compatible =3D strdup(optarg);
>+			break;
>+		case 'h':
>+			usage(argv[0]);
>+			return 0;
>+		case 'v':
>+			debug =3D true;
>+			break;
>+		case 'j':
>+			json =3D true;
>+			break;
>+		default:
>+			usage(argv[0]);
>+			return 1;
>+		}
>+	}
>+
>+	if (!compatible) {
>+		fprintf(stderr, "ERROR: Please specify the compatible property.\n\n");
>+		usage(argv[0]);
>+		return 1;
>+	}
>+
>+	if (uuid_str_to_bin(namespace_str, (unsigned char *)&namespace, UUID_STR=
_FORMAT_GUID)) {
>+		fprintf(stderr, "ERROR: Check that your UUID is formatted correctly.\n"=
);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* This is probably not the best way to convert a string to a "u16" stri=
ng */
>+	n_images =3D argc - optind - 1;
>+	images =3D argv + optind + 1;
>+	images_u16 =3D calloc(n_images, sizeof(char *));
>+	for (int i =3D 0; i < n_images; i++) {
>+		images_u16[i] =3D calloc(1, strlen(images[i]) * 2 + 2);
>+		for (int j =3D 0; j < strlen(images[i]); j++)
>+			images_u16[i][j] =3D (uint16_t)images[i][j];
>+	}
>+
>+	if (debug) {
>+		fprintf(stderr, "GUID:         ");
>+		uuid_bin_to_str((uint8_t *)&namespace, uuid_str, UUID_STR_FORMAT_GUID);
>+		fprintf(stderr, "%s\n", uuid_str);
>+		fprintf(stderr, "Compatible:  \"%s\"\n", compatible);
>+		fprintf(stderr, "Images:      ");
>+		for (int i =3D 0; i < n_images; i++)
>+			fprintf(stderr, "\"%s\"%s", argv[optind + i + 1],
>+				i =3D=3D n_images - 1 ? "\n" : ", ");
>+	}
>+
>+	image_uuids =3D calloc(n_images, sizeof(char *));
>+	for (int i =3D 0; i < n_images; i++) {
>+		struct uuid image_type_id;
>+
>+		gen_uuid_v5(&namespace, &image_type_id,
>+			    compatible, strlen(compatible),
>+			    images_u16[i], u16_strsize(images_u16[i]) - sizeof(uint16_t),
>+			    NULL);
>+
>+		uuid_bin_to_str((uint8_t *)&image_type_id, uuid_str, UUID_STR_FORMAT_GU=
ID);
>+		image_uuids[i] =3D strdup(uuid_str);
>+	}
>+
>+	if (json) {
>+		printf("[\n");
>+		for (int i =3D 0; i < n_images; i++)
>+			printf("\t{\"name\": \"%s\", \"uuid\": \"%s\"}%s\n", images[i], image_=
uuids[i],
>+			       i =3D=3D n_images - 1 ? "" : ",");
>+		printf("]\n");
>+	} else {
>+		for (int i =3D 0; i < n_images; i++)
>+			printf("%-24s| %s\n", images[i], image_uuids[i]);
>+	}
>+
>+	return 0;
>+}
>+
>
>--=20
>2.45.0
>
Best wishes,
--
Dom Rodriguez
GPG Fingerprint: EB0D 45E6 D0DC 1BA1 A2B5  FC24 72DC F123 1E54 BD43

--6qwm34kryihn6jac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6w1F5tDcG6GitfwkctzxIx5UvUMFAmZXrMwACgkQctzxIx5U
vUOBfw/9GJVJI960Ypwe1jv0X+oAUWYvmDU0W9TVHHUOdueIi7VgD2d6tN5lZovp
ickm4mwVlPfejD/Y1AnInRBCKsxDMHipaDqKsIRDzBK+M/bkdXj+vrGro8bKNcLF
vkOmGDXnJAszFpBcUOa619ppJsHpVRfp0p1m5Nk7G45vOE4oxXs7QwgBhGjIrKHk
no0uAT0fNSJa6UcRB/v4lDUfBuFxkD0hV6DbfCIe9Z/Ipx47LMG1PFA3Jqtq4WS/
ae36jCJ9XhyVCpENuz1xfEdU/kBCdAYROsGowztBB3jiWPw3SADrKk0XIyvCG/ZP
E1VeIZSVGnp2wnleST3p+VMlTDZFBGC2TsT+2dHAHTxxabrCnohWquqggGCe/eXr
HIahkFvnEXjD0LIcMmjLj8rtJDGbQlxpwwChbsI4Zd7wrNCCEysLP9tlPbo/c3PW
r2xuupPVuMvijJzs9emTECxVP5LPznxOUkHvEj755gb/GaULm2v9Ky5kyKcNmBoX
UD49MLmrEkV9yr/H1JR1glff7MUHe8FE6ii0PMwkRaZ2gScKm+Zyo1sLcEMxX3vV
UIbKFxygoaByCm4igcVQ2xTgJDQxSU9aN8Ij613aDEHTBDHXiDfUXBYCOBMUZTed
LzEwu4//n5xJEllOYjfCgEsc+FyfBIE+ZNZk1EEmgfC8qc+K5Es=
=SrGa
-----END PGP SIGNATURE-----

--6qwm34kryihn6jac--
