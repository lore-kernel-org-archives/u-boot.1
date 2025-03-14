Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EBFC28B30
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 05:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE70681D5D;
	Fri, 14 Mar 2025 06:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="aSs4ofpf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E898980F9C; Fri, 14 Mar 2025 05:10:32 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74E0B808A2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 05:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzgeZyPr/q978YoE84yYGDxIxJZkDLOo+8EPdPyl0vxzIiOm6zxrZaRTNfAH1IPAN01dnnkECiEBsWJuzhquJfGmItVdl3MBbRxbnnMNx72/L2ceHfHj9NWQnJB0vkpmjVe6KQ0HZ/HbonEwlVbLlKZPuTuQZqm3TgFUqHAYB0lE+/jpr0bfWwF5ceqtLR0bH2Mu2aLNLJV2cbhtiwpWZ1UJ94NSyKCmTDjaYo9GwsnugL8FbdEvZp0Nb5xmrJnomsyVXs8pW3TyCLciYTMV8+Hd53sy/j0Rqi0LILevcMdj79Q7ibhfqDAI4X1ffMALSvBq76h7tNr3wxc2/TAm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVlFMqYplIjz6Sz9htxZGt+UrjhRkt82Bg/auvEaJOo=;
 b=iD4QUUNEQw1KJKZGWURvroG6rmOL9CiM1Q2tlwTFo1EeBaGWNWnjJdAmrro9VzfMaXRr3L6ZTzlfIIz4WjAiQRbqbjeDf5WF0mvI8OuPPlkBuN+8r0BGZJsGXJRzp2dy//IqlDW+9Yp84LIVCUvPDr7RsDUe1plZBhNjHtSclASyQOhkN2cjWmUL/aRihlZsZrzXma1DoI4dZnSj/9VJJ+H4XzM5zVMKRtBLn/B2IZZ8KOmGUOeUQvfnEIAIkzrDRDzGRg38ABrw8x4ZNGlmM/A0sZ/Iw6VJw+LFaDO+TwMw+GLit2Yr6ZUw1SnHtv7qBkLWp+TORA5QdJrRHCiToQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVlFMqYplIjz6Sz9htxZGt+UrjhRkt82Bg/auvEaJOo=;
 b=aSs4ofpf4KsLjUhAm6rE3l7+FMaZOuacpPzq+lnGpta4jWss4ju2IZ6mcvmXL/GcBhj1svcG3FKsHRsffLMNx3po1QTbliR6NU7ldk1ayoUGR9d2Cx5+y4vtwdlPE/KCJc29L7NQvs5UP3HSKwwI8m3t5WR81Qsjjp17427HmDU8cFFUu5qLEz0VwEFcjatbZvGr46Wfxn8ZU4iUhkL+BNAD/w65k2/MlCK8c/K0Ighrt1UKggx1KgdjNWVaIqPAkzXCxWO+RN+vnLqfXmb4/Y3mQqr6+e3khIYNY6bpmi9daB+iHzpKQsLdYQEgka0UEqiwCqJCd3venFOEvVodkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB4387.namprd03.prod.outlook.com (2603:10b6:408:3b::30)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 04:10:28 +0000
Received: from BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874]) by BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 04:10:28 +0000
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
Subject: [resend v2 09/13] cmd: Add i3c command support.
Date: Fri, 14 Mar 2025 12:08:58 +0800
Message-Id: <20250314040902.43621-10-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250314040902.43621-1-dinesh.maniyam@altera.com>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To BN7PR03MB4387.namprd03.prod.outlook.com
 (2603:10b6:408:3b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB4387:EE_|SJ0PR03MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e750e3-e936-4a1d-ba1f-08dd62ae272f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IRXknpx7Zs1CbEmGoP23jVnWZcFB4ZS50G1aqRwNyMdTS871x52c1o/5wmVf?=
 =?us-ascii?Q?ZF2xaAAEjz3njZLo9Jxi2m/Z8eLragRu1CBLscsdi0J3Dc5Z1P4M1vXM0Ig7?=
 =?us-ascii?Q?ZgXeiZAWwXye1dyR5xtAxU7w3yBG3s8xllrUGeoKy+xj9HAxBTS6icScU0k+?=
 =?us-ascii?Q?M+/eFoaLcMD/MEUFBkEGy8XOirp/0Yq+k8Ex2FKuLPK29hiMsp1p7jadDtOn?=
 =?us-ascii?Q?8G1Y1IMkaKaAMOxgJWWsyv86ekz4aQCue8FDaRZXtlkq3BRCprBSTE16ZV5I?=
 =?us-ascii?Q?R3AWyCCTFXtRHatjfgW5QjV5ok1aQD3MrmYRX5uOVcdj0TSljxx4A75HklKX?=
 =?us-ascii?Q?t2L1wom1GmRJdO4UK4gjI4V+J7TLmHBKOpFSrrWjGJT/eipNtI+uPigKw6Bk?=
 =?us-ascii?Q?3MyhBmiqiVP/8675vinwEtKVEdQB6YxYruzGhTir6E8KGt4ERR9k/U91RVuO?=
 =?us-ascii?Q?oqz2nzZboiqmxYEJMjIj3KUHvI4xibe9vbLOA9XYhfSL+dReVr0PhHSX5n+o?=
 =?us-ascii?Q?Vsu1r6JxdxjcKvC8IYwx1Puat9rvZYZW3dyGJRWuh2hS7A+7QZvrCXy6SI7D?=
 =?us-ascii?Q?RqA/UdyD5Icvj7+0EoNlGopw5Lzj4b/U6cTpHuSeIpy2mGvretVHV8PXHVx6?=
 =?us-ascii?Q?rkqKLB/CsXB4+Af167fflawwla+9t9aOr1AuEKG4mpY204VjtaIb5drtouRa?=
 =?us-ascii?Q?1vWJg2bb4ImI70JeO1UQmLN/lkNFkSASvKloSDGfk638Iop04yNbcddTgEk/?=
 =?us-ascii?Q?yjtUA/A3P5rI98mGUzM4LAyhPH+zEDD4+P/8LSIrqXs5EJDvN4F/Ucs1RWNF?=
 =?us-ascii?Q?uo2Ur+sc9JGl6sU1gskenRxM0hSYaoxcexZ1hp1z5Okv7dxxmnJwhhvmG0bu?=
 =?us-ascii?Q?ygLVTlXNeASbBTRIi+xTTRq9xEneW7dQ3AfflFq0iTngWpomqmt3bOEpdw3r?=
 =?us-ascii?Q?zeYPUZfs6rEwo45G8Cntexn7N+P9viGQw1lvKcJ2OrowPZ6j/SMexzK9GGu4?=
 =?us-ascii?Q?NTYqLPjGxLElB2byONa/PWbC09IpLOetwDadcD/ZfsPWS2YGgnU/79DB0und?=
 =?us-ascii?Q?vmDDm6q+6WiWCd2SQ2oVmVVSy/B7Ki9Qgue1mR7KYjamfsmvlwqla1MZP3C+?=
 =?us-ascii?Q?AFssip8vAN1DLIrG/OKEsBr8IA/g7ZzvDXQOdh7ql7Vz1IVfRtRl+KXRS8gF?=
 =?us-ascii?Q?sf5RM76uWGQko+6dl76Lp9Ac5052lUqGpyezUusylXdVy6fAWirPERA7buRo?=
 =?us-ascii?Q?W2ODM09EHJQQh5NyR/1x0kjVrhGcSUrLtw5SnEvM6w514nFo8dpHWLEPAobp?=
 =?us-ascii?Q?KzycS0MEQsP4ZffgZiu1wct0IvaNVIcGZuN2XCdeX3+j/eWS/Feyu3fol+T+?=
 =?us-ascii?Q?0/IRddK3QW3lb93s9URLjI55seRx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB4387.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7pb2tc3ShyqbVq+QgqGJzovoxIshlKG9HCECg3nRqATVh9JBTXEaTjCPmndW?=
 =?us-ascii?Q?HIUacewaQJqP3hCLRFfcvzfxFbFT8a5YtzasJkpLOKsMCBPGg3ulsCHyW96w?=
 =?us-ascii?Q?bQRnPNw7WtYSY3jCw0AOmbOGp2bfCjq9H5d85cJxpD/pDlzWmntgIUDPP3Hw?=
 =?us-ascii?Q?1gwdp9zdu2UnAdRA7FHrLb9yX+jMRXUp4dAFc7PnsBgqhK2ykbpgIRTGDF/X?=
 =?us-ascii?Q?L6gHPFBl0PaHqcVJiDjX+5+TLiVjMeKLhB+OBpJ9TxqnaiW6s09W/AoWvu14?=
 =?us-ascii?Q?Gm8f8UDSXillFtYJuKx0l2K2Ke/z/SjGvNNeBP2NVKnfkRxKvBiJyStMlC8b?=
 =?us-ascii?Q?UWc/YVwCO9E6TJMObxhWoPy473/Tk5RsMN6LBK5dQkfQzhokmV9PVMDAAqKV?=
 =?us-ascii?Q?73PhtFfGLR5O8ktxvD4fk8ozjL6nApaXiVTwvh0oPzd9fdnaWMq5Nm2rfcFP?=
 =?us-ascii?Q?W3p2IL2fWG6NpFL6H95p2mrHnUZt+knDPXn6d+OrOV7oydFzUaXrAdyUeNoS?=
 =?us-ascii?Q?UAMigpLawITQ6iVr1RlGnaligqwvBlzF2A3vaTyNdVpMgnyaa/W7vb3aJcJ6?=
 =?us-ascii?Q?rvmxWLtxKdfDRZvY2KtvnB4zPvk1KrXjKWY5tn1BU28JQz5AmKVpgQkFT+SA?=
 =?us-ascii?Q?+qYmp2nhJqcW4EL0nZI+ih1yPPTA2NOJgKw9Qq0KngRJUSOd45CtqUlJkm7d?=
 =?us-ascii?Q?3K9Icq+D0AAPHPwS+En/y/+8Sm1zRHWvgxyiDCO49TUBsugmikBpVDPoKvEI?=
 =?us-ascii?Q?7aIodPmBoUwlIr661GeL/cDbqukZYKAtiBX900hOe+SIP8Zamiqaklyx8SG0?=
 =?us-ascii?Q?5jmaW2eBcauRcUb5kN6RVIQ+4OavleNFlqZQayRXanTr9AMUN7/1NvZAxTUN?=
 =?us-ascii?Q?5t8lLJMzS2pTA6JSvQNim9V7EMf8FBT/Beg3q67Xt+4NnbyVlMKt7WDU3lAs?=
 =?us-ascii?Q?qcXXLzd2vbQGYjvAcx+drpw/My2hORpjE2HF/lM3y+J26fbzOfCVjkuKmSZ8?=
 =?us-ascii?Q?9VcryYcOo0tCPRyh988Le6GncpcRbGAed/VGkM11wZzpy6rzIUNwOK6ipR2C?=
 =?us-ascii?Q?r8E0nJigKtTGcn7x/UCgFwUzvEgRX7u89B43VrWW2n9lL1b8nc7LF+2xYCgv?=
 =?us-ascii?Q?U0vXXamDAB5dII1nCmBlKp87A/ulfaRiUYQnGT4b/TJh+odxp7zeB9ZGGsEI?=
 =?us-ascii?Q?+yghSmRJ+c3ege0GzQe966KxEFH20Q0nclgJju4J9NTY4VZqIj+hYwcFgqyN?=
 =?us-ascii?Q?BpaeY1sG9SWSZKyBVwXPe6jxlRlLcpK18tWGAjXN/22vO9TiIjIiTWtua65p?=
 =?us-ascii?Q?Ei5SMcTAqiLHTGc3Ol1RusImaPvLUVJ3v/nfepCk6+4dWVf2SkMI6b5B2c0/?=
 =?us-ascii?Q?ukzy3NvqtUvCYYMqmGw5hXtWvuG5wT4K96EA0cUfFAFNbJZo32Wdzsj3oeE8?=
 =?us-ascii?Q?FKN8XbCMsJXE70tBmD5QGZ6NOYHI3hj77H9d14I+Lhcu3oRUoV/VWLdQ7m1w?=
 =?us-ascii?Q?6fVFUOCfT9LoI0F5+rKdidETzjAKlYKv3QAOalXcWuGHjuu0+uj8vppHwHoU?=
 =?us-ascii?Q?sn0y9HyhuZkm7ul7FuvOQKt4s+kNZyVMM79A7ufhSrY9IdlXqi/TOXijHotB?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e750e3-e936-4a1d-ba1f-08dd62ae272f
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4387.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:10:28.0992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSRVwmbcW/v+GAhID1HIKBC++YmxxNRhNzD7glci+uQ/vsw30pzQ2uduOMZGB8TZz90au3qeEx45pyjGXyPKC1vrPH8J48ZqLrQ0y3c0RJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5757
X-Mailman-Approved-At: Fri, 14 Mar 2025 06:36:33 +0100
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
 cmd/i3c.c                          | 193 +++++++++++++++++++++++++++++
 doc/usage/cmd/i3c.rst              |  98 +++++++++++++++
 drivers/i3c/master/dw-i3c-master.c |  35 +++++-
 include/dw-i3c.h                   |   2 +
 include/i3c.h                      |   4 +
 5 files changed, 331 insertions(+), 1 deletion(-)
 create mode 100644 cmd/i3c.c
 create mode 100755 doc/usage/cmd/i3c.rst

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
new file mode 100755
index 00000000000..cd5ce3b5800
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
+----------
+
+* Display the current probed i3c controller.
+
+i3c list
+----------
+
+List all the i3c controllers defined in the DT.
+
+i3c device_list
+----------
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
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index af6e472f232..98bf8947010 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -670,8 +670,11 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
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
@@ -1006,8 +1009,38 @@ err_assert_rst:
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
2.26.2

