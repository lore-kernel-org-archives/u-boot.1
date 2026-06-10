Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1FDCD98C6
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 02:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11611849D1;
	Thu, 11 Jun 2026 04:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="X+b72toY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBAD3848BC; Wed, 10 Jun 2026 16:25:59 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD26A8491C
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=mateusz.furdyna@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDxMj5ItuS7ePJd6rQ/CrUmK+I4MnunInZOKFgscEST89JUi4Nb88KzxhyWc7YhVLAovWnnPoFqqrOVv0WJyKmAI+zI+2uR4ZXECke8/3boo9LhfcRjVtEZwW7xzMOEqvw8QoiPI3YKt69Omh/jvKkQphZRTFaLbv1xupsO1qnObImemAN+Frh8DAGFX2nBR3/nShMDqy3+y2IK8Menc+NJd0JdJOHtg0VANlhVclzVwk3s5WgJ5IBI2nUs4JbkLXZM1lSNxrU5nZ/mZbkb9yNjWVz1dtyjVfz+ClFQf/bHZ7GCBum9eH2Vv8sAB79bIKufUHutkagr7muiXY5GAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LJlc4sLK3jS9kO4aVXS3A4lmMC22N0m1dnIBMRD8V4=;
 b=tcKF1fWZTnkJ4jz11yGszYxAbrPQe+k86+Vw6Vek+jdgz/lleUXbUm/5McqJOhQteqDOdbFH308o30Qv9pIZMGzd/dPFrmSI3mo7icVpvhdzFhwpvJzoZuePANfWhgcTp6G5ZVBvwxjB4Pzjlr8YAWCvBNWxxnz5BaVRYf9ikQ/vD81wJ//wAB8bD67/9iOz5phjUUKliWJmpuJ648ar/dnwIm9/NMLBB3uJZNeI6ZkYcgRdIfdfS0FZBQGnVuwcxT/cIF0oQqBRpwfdluSktW7CAlBRxBhuye1emii1mQj497VltOHu1z0k8mXoRUbP0OtkpMBLJjGdbILmf15wBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LJlc4sLK3jS9kO4aVXS3A4lmMC22N0m1dnIBMRD8V4=;
 b=X+b72toYdbqfmSNHwx9ly+wbZ87GJgIhB/8hBlUNkkXC3avqvrePLR0q++5qWjT8yomAtoEFfFnZPwyCQVqEWu8/aA47UTynSOkVSh9G/F9Zeybw/V57b3l00uRTRHiQMmVkxjAMdFeDVNoZUks8p4o9tbWvsyvv7HB15hLgU/qbRgf0pJgjPXXBFKNp7avDFgeI5fvL9ityBL53LkqrACqMHSV5v0EES+cVexGhEzHQ0oIO8DpdKP8ltbOBRF35YKf4I7QPlwAjweLRdU5/horx/KgHDTDZFE+oVDlqvZd3TJCFOG/rJkrGPMeglVR1rFSkaK7tHBeByHbvNdHnTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS8PR07MB7461.eurprd07.prod.outlook.com (2603:10a6:20b:2af::12)
 by AS4PR07MB8827.eurprd07.prod.outlook.com (2603:10a6:20b:4f5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 14:25:54 +0000
Received: from AS8PR07MB7461.eurprd07.prod.outlook.com
 ([fe80::8dc8:cbbd:e4cf:83bc]) by AS8PR07MB7461.eurprd07.prod.outlook.com
 ([fe80::8dc8:cbbd:e4cf:83bc%3]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 14:25:54 +0000
From: Mateusz Furdyna <mateusz.furdyna@nokia.com>
Date: Wed, 10 Jun 2026 16:25:34 +0200
Subject: [PATCH v2 2/2] test: net: add IP defragmentation
 duplicate-fragment regression test
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-ip_defrag-v2-2-060f6eeaeaa1@nokia.com>
References: <20260610-ip_defrag-v2-0-060f6eeaeaa1@nokia.com>
In-Reply-To: <20260610-ip_defrag-v2-0-060f6eeaeaa1@nokia.com>
To: Ben Warren <biggerbadderben@gmail.com>, 
 Alessandro Rubini <rubini-list@gnudd.com>, u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Mariusz Madej <mariusz.madej@nokia.com>, 
 Mikko Heinonen <mikko.heinonen@nokia.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alessandro Rubini <rubini@gnudd.com>, Simon Glass <sjg@chromium.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: WA2PEPF000008A1.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::64e) To AS8PR07MB7461.eurprd07.prod.outlook.com
 (2603:10a6:20b:2af::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR07MB7461:EE_|AS4PR07MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc9ce9e-3d71-4a68-5374-08dec6fc2e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: oAEppmi8YHzhNNSJG+3rW7C9huwptAGC00T0siNCj1gIpdriCCmc09HLpuiWntDGopLsfFtyXp39Td34XavE/M/VsO7/+26VX4iSg4wQekoEqOjBXuP4xbxhXgyqZknTvUcj+NvU0WRdkERR9A1g5mPMmytaUlI9/7JJX6W/uSKlSO64ZHcAbBFjUJoOsTIoxTd7NM1B0gY95tFo++PUM++secZw0WWzUrllq++eTVVmGgUm4bvRVfsnjTmdsHE6GPn6KFtE0gM+ob5J5b8lu3tCThwtKYeymaArztyBmigmMm6D+ITIBSM7RoOecWazPXVWzFAyI/SCRkdBGgqBh5lYW5ZNLNGR7yqv2m+5DuLoLgw7VsqTTw6d+w4rBhsr2U3JI58BMEeP7iLqARvs5I9IztcjMQYQvZaoPp6C9xdjJb2/P0vbo9rkyjYBET38a8jKvzV8D3xFAOhqaGSMR5ZsNcSwVO5s93Vv/8AXAg7VO4sF5ASytRmnmYw3r21ROUUKYqORZbpy12AoCz6VbnoFVU5vRJjsmNeTUbGoo7T/6F/YavyuEt8Eja4QvTK8x5d1Vi7W4ThjaDZ8ZU31gLFWMLe96NxbBGD6ObM/Wn/Bc4o7+hYbz9ejKD6GTZyQLI3AhCMpVzL/6PrqrEcQEvJw+fzplX9jhDlDd+QhGrXuRg2nkqzmQljUmRMlVS7c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR07MB7461.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTREVTJzM3R4c2NvU0t2NkozZlMxSEx6N1MvVTlXOFVOaHdFcFVuNktobk5X?=
 =?utf-8?B?MUNRRjlabGJ0YnZ0TXViWW1aTE5QT3lTRmVGQXFzWVYyeGVaTW5tOTlJTFhp?=
 =?utf-8?B?UEZqMUVnRVV3RVBDRGdyNFFMQ2Rsd3BzYkdwV0dVVElYZkNJUXRIT2VyOFRj?=
 =?utf-8?B?TDJaM1NmWXRnZHdRYTA1YTh3Q1VOeCthaC80MFdNRWhjb0VXU0hDbUx2Z3Jx?=
 =?utf-8?B?QXJ6ZGhLTWIyMDY3UFlRQWJlS25ENy9yVE41OERGbmVuRnRlNmdJTXZKdmRx?=
 =?utf-8?B?TEg4bW1JVFVrUjFPNHRhcnduaGxQMzJmTXNuczNySnI1MDcwLzJyTTl5Wnlx?=
 =?utf-8?B?bzRYeVh4QmdHSWNqTWR2aCtNUThnVUlVbWllcUdsYU4xakkrdUNLL0lmbXFr?=
 =?utf-8?B?RjBqdVJNRHRHM0szZHZ6dithblpzYUlsQVZHb1M2aHNqamkraSt4UDhNYmlo?=
 =?utf-8?B?TTByVmVWeUJGU241azl2citzcCsxWEV4UEhMWE1rU0VLTi8xZThHRHdzR21u?=
 =?utf-8?B?NEp5akhzWis1ellLcFpxb1VXendvMXM5eWNsTTloK0R0Z3lRaEkrQ3haMXRl?=
 =?utf-8?B?Umxpb29XUnIwRkdneEhqMlU1d3BtNm9xeXoyTWVPNFRSTU5YMUVOeDhUR21R?=
 =?utf-8?B?VktEMEpiOTN6ZXZucWdJMCtJbTRrdzlPR2NOaWxCY2JJRWQ0SGxaK1dGVysy?=
 =?utf-8?B?S2RwYXZETjhWU2g5c3I2Q2E1TDI4VEJmQ3IrcG9aR0JHcWF5TUtlVkZ1L0FJ?=
 =?utf-8?B?aWxRMHNjWEVTR1RwSmhJVERwcGtWTUwxVHNCS0VRbENxQS9XSjdSNzMwc1Ev?=
 =?utf-8?B?TEkvWmZlZ0V3TUlMazZrYy9oaDkyKytnSW0rZUFaNEQyL0NLWktWK2c3dkNm?=
 =?utf-8?B?Ny9FSmpjcGpLcUsrMVhhUVpJc3JyTU5memV2aHRHZW43dGZ0dUJ4eWlYdzFE?=
 =?utf-8?B?eEJyU2NGTlhHZlFENjg3YTRndDkrS2xFNitGbCtlMXVDc0h2bjJuNGZCdUp3?=
 =?utf-8?B?Uzc5amRKMXJSMFhoOEpDVml1ZGV3VUk3U3RKQTRKZ2dnYlpnVVcrTDBBS1pZ?=
 =?utf-8?B?aW1DMTBseVE0MnVOSEVGL090VElUc2pxd3p6OCtKYjBJS0VRdXhwY0JzbUpB?=
 =?utf-8?B?dWpQdFgrUHk4VHNtbzhoOXVDNUc1WXk4S0FKTEhDc1Z3VUVXdlJ6WCtud3p3?=
 =?utf-8?B?OCsxUG9HN3o2TC8rRWJpOHFVVTExN3NJTVJJc0hIWnQ0WmRqUnFhZzZDTWhn?=
 =?utf-8?B?Y0xieEI1WlBrc2tuU05PMWdPQ1NvMGVSRW84U25naC9LekR5V2ptUVhRaEwr?=
 =?utf-8?B?ejd3dXZESzl3NTFhVzZLY1RTM0ZlVVhDMzZFdFNQWjdWay9xNExNL21LV2tx?=
 =?utf-8?B?UDl4aVhLT3Zobnl1ZWdXSkl2cHlMdlRQTVdPd2xaMmViZi9sa3o4RkFTVVRL?=
 =?utf-8?B?SzV0RlZkY2xYQTNmQVIxTEI5TDVCZnAwMk90YlVBSC9CVjF1QUdWUGZpUU9R?=
 =?utf-8?B?UXdDVUZkOFBQemZCbzFhSXZXZ3NXSEd3dU5DK2JDYkhoakR1VU0zQXlDTDRn?=
 =?utf-8?B?VGttQk5ZMndVTHg1T3NRUlN3R2w0UGV2MGRLVUZma0RDd1ZmOCtvYkhVeUxD?=
 =?utf-8?B?THg3KzRlTGtrenpNMTZGMTkwQmdFT1RrUkwzUVUwcHNwWkRlc1o2a2FUVTVV?=
 =?utf-8?B?WW1HaVN2UTBmTU95OElvK3lCdHN1alJDVFBnOWJaQjJqUU5LRllmNXE0WWha?=
 =?utf-8?B?V1NGd2JrL3FsYVFOVUJ0MVdkS1FKR2dtN3JuaUFLN0VvcHlhS01xMXpPMkZS?=
 =?utf-8?B?U2ZaMG41ZW1oMUZJQzF6WWpHaW5xUnk2MzljdGZPNXZTamdiZCtoZjVBTWtV?=
 =?utf-8?B?UTQwOTRaRmU2eHlZUFdwMEp5SllYSVQ4cyt0Q0syQ0U3WjJEWDlBZUVuVFl3?=
 =?utf-8?B?WWJmckE1TlJ5Q2FRQmQxbDF3UkFXV3RVRFFMdnZWcDI0MXNueXBDRUhhN0xR?=
 =?utf-8?B?cDlhOGN5Wk9DVzBFTTVxTUw0QmdCd0dsUGdmNEt1MWk4aHVLMmFSeTNqZWtk?=
 =?utf-8?B?UUtHRE5CbENhSWViUG9DSGt6MzVQRmFGSGNNdi9LYzNQekJlMGtJOHF5UmVk?=
 =?utf-8?B?dzJtS0dZRmZHSHV5LzRHV2pmOGVhVVhJY3VxdzhDUWJSMEM3ZU9HSE02bkM4?=
 =?utf-8?B?ZnNiTUM4RGNxbUY2bGVsOG55K0dpemFIRFNObXhoblVheXJiSjR3RHdtNFB2?=
 =?utf-8?B?Smw4aUNuMjVFOGVpMUI1SE00bVYvNUpRZGEvUWQ1aWQ4Q01Ydmg2TVc1QjJk?=
 =?utf-8?B?NXRkTWZOYmFMUUtCV2Z5NFgrSURSOFpUSWwyUGZpOHJGakV4N3UrN1d6c3Ji?=
 =?utf-8?Q?yEoQYG88v5FY3Grw=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc9ce9e-3d71-4a68-5374-08dec6fc2e1d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7461.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 14:25:54.1955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXPhhrXHYSmNBGSikhzAjjK2S5DAUse0FhniuMVbjJ4AvGT963YlyDxTnsGRCoXggLpU/o6Kp+I5Jq8XUqcaR5AekbmyEvmB/jMNtoqd3Ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8827
X-Mailman-Approved-At: Thu, 11 Jun 2026 04:54:05 +0200
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

Add a unit test for the IP datagram reassembler (CONFIG_IP_DEFRAG) that
covers the duplicate-last-fragment scenario.

Without the fix the last fragment will re-trigger datagram delivery,
increasing udp_rx_count to 2 and effectively failing the test; with it
applied the test passes with udp_rx_count == 1.

Signed-off-by: Mateusz Furdyna <mateusz.furdyna@nokia.com>
---
 test/dm/Makefile     |  1 +
 test/dm/net_defrag.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/test/dm/Makefile b/test/dm/Makefile
index d69b0e08d66..0e3c63568dd 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_MULTIPLEXER) += mux-emul.o
 obj-$(CONFIG_MUX_MMIO) += mux-mmio.o
 obj-y += fdtdec.o
 obj-$(CONFIG_MTD_RAW_NAND) += nand.o
+obj-$(CONFIG_IP_DEFRAG) += net_defrag.o
 obj-$(CONFIG_UT_DM) += nop.o
 obj-y += ofnode.o
 obj-y += ofread.o
diff --git a/test/dm/net_defrag.c b/test/dm/net_defrag.c
new file mode 100644
index 00000000000..3fd40de90cd
--- /dev/null
+++ b/test/dm/net_defrag.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Regression test for IP fragment reassembly.
+ *
+ * The test drives the real RX path via net_process_received_packet(). Final IP
+ * fragment (MF=0) is duplicated, crafted payload triggers redelivery of the datagram,
+ * which fails the test for the unfixed code.
+ */
+
+#include <net.h>
+#include <string.h>
+#include <test/ut.h>
+#include <dm/test.h>
+
+#define FRAG_LEN (8)
+#define PAYLOAD_OFFSET (ETHER_HDR_SIZE + IP_HDR_SIZE)
+#define FRAME_LEN (PAYLOAD_OFFSET + FRAG_LEN)
+
+static int udp_rx_count;
+
+static void defrag_udp_handler(uchar *pkt, unsigned int dport,
+			       struct in_addr sip, unsigned int sport,
+			       unsigned int len)
+{
+	udp_rx_count++;
+}
+
+static int build_frag(uchar *buf, u16 off_flags, const u16 *payload)
+{
+	struct ethernet_hdr *et = (struct ethernet_hdr *)buf;
+	struct ip_udp_hdr *ip = (struct ip_udp_hdr *)(buf + ETHER_HDR_SIZE);
+
+	memset(buf, 0, FRAME_LEN);
+	et->et_protlen = htons(PROT_IP);
+
+	ip->ip_hl_v = 0x45;
+	ip->ip_len = htons(IP_HDR_SIZE + FRAG_LEN);
+	ip->ip_id = htons(0x4321);
+	ip->ip_off = htons(off_flags);
+	ip->ip_ttl = 64;
+	ip->ip_p = IPPROTO_UDP;
+	/* Broadcast destination is accepted regardless of net_ip. */
+	ip->ip_dst.s_addr = 0xffffffff;
+	ip->ip_sum = compute_ip_checksum(ip, IP_HDR_SIZE);
+
+	memcpy(buf + PAYLOAD_OFFSET, payload, FRAG_LEN);
+
+	return FRAME_LEN;
+}
+
+static int dm_test_net_ip_defrag_dup_last(struct unit_test_state *uts)
+{
+	rxhand_f *saved_handler = net_get_udp_handler();
+	uchar frame[FRAME_LEN];
+	/* UDP header, carried by first fragment. */
+	u16 udp_hdr[4] = { htons(5000), htons(5001),
+			   htons(UDP_HDR_SIZE + FRAG_LEN), 0 };
+	/*
+	 * Second fragment's payload doubles as a fake hole
+	 * {last_byte >= FRAG_LEN, next_hole = 0, prev_hole = 0}, so that the
+	 * buggy code re-reading it on a duplicate re-delivers the datagram.
+	 */
+	u16 frag_b[4] = { 2 * FRAG_LEN, 0, 0, 0 };
+
+	udp_rx_count = 0;
+	net_set_udp_handler(defrag_udp_handler);
+
+	/* UDP header, offset 0, MF=1; then data, offset 1, MF=0 */
+	net_process_received_packet(frame, build_frag(frame, IP_FLAGS_MFRAG, udp_hdr));
+	net_process_received_packet(frame, build_frag(frame, 1, frag_b));
+	ut_asserteq(1, udp_rx_count);
+
+	/* Duplicate the final fragment: UDP datagram must not be delivered again. */
+	net_process_received_packet(frame, build_frag(frame, 1, frag_b));
+	ut_asserteq(1, udp_rx_count);
+
+	net_set_udp_handler(saved_handler);
+
+	return 0;
+}
+
+DM_TEST(dm_test_net_ip_defrag_dup_last, 0);

-- 
2.53.0

