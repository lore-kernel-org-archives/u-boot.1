Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC27BC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 08:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC593877EA;
	Tue, 12 Dec 2023 09:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="dBKukwQ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0157877C8; Tue, 12 Dec 2023 09:53:13 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C011B877D5
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 09:53:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nh/eBU3Z3K2vtCuASw45cbYcDwdwKoaExNzAUHPpTndGPgi17zB/aHBhMV4sznvFbvRvCXr/I9aLuG+qYxEwQBh6tF1/58S8teZjyldBIhlFI1IUePKOTbE8hhCo8nLExInTsfZHbZ4TnuFgVcb57DrIv6LH60NWyU0jfWqemW0Q1JSslOvwvpF2n3QXJuOoExythzk9GvchDOYxaBpXKmuolOXRk1G5qlqexQgTjqyP0foPw9+WHa7W1/AyWXXyfw2jz3kSx5betdERA6Uflor3nu/21CKltW9sp7Y12vUCN7YX6EsqHtcMawOXAdCqWsALZovz9XiMXYPkHshdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqY+R8W5h5qeaxaQeyk5mEjImN69Umfm/djuaP8u30g=;
 b=iFnyQ/gp0Cf8jcNuPL/h2vrE7KX35rLt3/WQFD99kwphJcefE65IPUgBS2j0pJHOXTKBWA6mCRcAOw9VCezFRpxa8+tcFLAhvt9/EhsY+LZqjvCxV35oQyV8CfFFR25WL6iaYx3LVYE03l+Tfl7Iqwnx9XdRMosu8areBnret36nO12mOR7zAHBGxDWwa9CpembWiP/CjW2AjOmc+JxOM7nzWTl1Mm80aC9aTVFowFuQq2o9GxEyTc4feqlzVJvjhf4yjQSuUcN2EtJThyZFyCdySsmetCjWf+lrT/Mf+lSspitRN2z4p0ZbQWVSQqzOaiHCGSH/yIpOc4a9WBBMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqY+R8W5h5qeaxaQeyk5mEjImN69Umfm/djuaP8u30g=;
 b=dBKukwQ6j+I8UxEL4trpiB3pulr/0KFiQ4l/DftOPg4DZRuSUF3nkk7c0bDacv3GCw1MZ+aKb3nnWo3Cmx3qep+0FILDQAKh0vkzkAzuctTuW8RlMPcNy3cg8g8FyFrzE4aqBcjsR8LycKKMpJ7zVW6BdVooxYZzh72g4OLNsnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM9PR08MB5940.eurprd08.prod.outlook.com (2603:10a6:20b:281::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 08:53:10 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7025.022; Tue, 12 Dec 2023
 08:53:10 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 5/6] lib: vsprintf: enable '%*pb[l]' format specifier
Date: Tue, 12 Dec 2023 09:52:35 +0100
Message-Id: <20231212085236.2730768-6-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
References: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::6) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM9PR08MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: b98d0503-0083-4b80-ee96-08dbfaefc48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +PTwArZ8XHi5pTkxxSD8xUB2kyCHcbKOCgDo+/Py+FLXwq+4MnS05jte6A9CeRyeqXXPM/dXpc7X7c7S9QgwFFwZ+UYHctsdHjgjvFJf7kajMWMK0864XJQqP7yE9yUAW9F7dxXGlljnEEcstphU1eEK9PIoQRurU8OVA8zOc2XAYq0Sj5uWtFXnaoqrQv9Q+gKgzwOCqi+lAwnel3jTJAV9JKAsjop3H80UA0PGROIvjXtk79qekQEjbziyVFQ+5yEhcVuYa2P/WkPvbkoLvHgxBnczcXw1G2aKArY1uSL0WmOvWgWH/sJiLDaMh3BCAot94m8hl6TzgRPdYKE2aGVkZo6pVmv3Yau2ZPXG+njlq1XGAy3gQABK/p8CBlRi6zZzA2lYcPhTBvarTPakIwvy3mCe4vWsnU/BGJR/QLeV+2GhyZ4TafhtqHAaS6kJiaRXI8tvmRefte5U/f1SzdoU+ZDgNthqLri2oLRBUf75II1vN6qCwabG67RkdM2AS16DZbL968SYqGlBaAGmaOq0wofIrtNo8bMXlFlMqEzP3Ac1LD3/XgH0aoGu0P60sSkclRcTuG87aOSWx4rkXm+lIKZ6j3kkqAKMPeHKkWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(52116002)(6506007)(6512007)(2616005)(1076003)(9686003)(5660300002)(4326008)(8676002)(41300700001)(6486002)(2906002)(6666004)(8936002)(316002)(966005)(478600001)(6916009)(66476007)(66556008)(66946007)(38100700002)(36756003)(86362001)(54906003)(38350700005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RvicQGtEpC/ymE5KPSmV/oabbmyCmuj/1N2a0R7J9EJ4w7I3LCPvirqt8R5s?=
 =?us-ascii?Q?maYwf5rr4U2vhii4REO649GNsIi/3aOFtd1f2lPM6jjUw3yLHDRM3uISWAZh?=
 =?us-ascii?Q?7z+7fANZ+6yuESwMNg466MiNzPxT1HT0IMV+c4MOQH4cGB8Xp8+xkAmAkhEc?=
 =?us-ascii?Q?7Q4RLqpb0cRgGVUewR5Y9KZOmBc3ER4LIwIi6F/wGlb/FNLGxXnCU/FWCt0M?=
 =?us-ascii?Q?SMIj7Vzg1yvAdvvfMhRYshcf208wTv0MyjP2gkC+dZddqho5NNuQ+DfJFAG1?=
 =?us-ascii?Q?Gmlp0Ewdb2euYfxsNoS4Vurf6rrnNgL8SSAWvNVTTBDdO8zmiBaL+epUhmtS?=
 =?us-ascii?Q?sLerAundOwrobZK5rLXv5Sb/yZbipppJ2he4a5pL9QI9FS0CKDEKPpC1vunt?=
 =?us-ascii?Q?FSRpNzacUr+WtkjfWmbUJ/K3J3pNolcKv4DGliNg7MrU/QVHd1Un/Pyn4A0d?=
 =?us-ascii?Q?+Yc84OFZBXX/wxRYbBib+4Kaye0KHVB72zb5vVoeCBlxKDoXm+dHm4qMZcxU?=
 =?us-ascii?Q?M48d15szf41FlRITC58j1ZLWzyBk+alCNqyBN2Tlz9oJPK5nW4aP2S2Ta94I?=
 =?us-ascii?Q?G6zD3EDx9zH7MIFba1LPjQ1jPm04j3ekbVgg+EIyGqPUpxgVHPnLtYdit+7X?=
 =?us-ascii?Q?7J9hPtkdN+B1mIKnKM7Sbps70rL+jPbNYJUTm+VwInmWWdinRFs9O6w3dtUd?=
 =?us-ascii?Q?Hw3MRgTWA1Tev0J2YA+ixlPtH0Cpi/Ph6XNvUYm5MRg+8EWgUzreqL873Ybo?=
 =?us-ascii?Q?NqyGRcm/c88tSi8IMAfkjm1HmK6jqqYp2F7aHIVafxTNKxYpnqdTFPS0Nd72?=
 =?us-ascii?Q?4k/Ami/cAj+SdoWFJeonLDSbXHJX6sXwmyzxXZiEiYrmuVQMcB9Rna8CWwOH?=
 =?us-ascii?Q?XjNUDVYu5hiqBURDUzeiCT9cYJBC+Dn5U/rEaoxZ9E1I+crf395prCZRfplM?=
 =?us-ascii?Q?qh5VhjnuzjJoOArIfmpIVot5ZxD0ybX909OnK2kDeWNb61LHc8iMEmPNDCTY?=
 =?us-ascii?Q?qRKI2FomtgF4QGFZp8DmFBZV9BX1MjHCy18Ao+Tf4+a1+/6B3VEo0eyEOUMb?=
 =?us-ascii?Q?IyUxdPijV/uZ6cEBwPuJClU35fsSg7nCsnrtKWQht2vdoRvgZq6UeyN+6iNt?=
 =?us-ascii?Q?LRLSlfrgxpbvKNeGGj6oBVLscdjU+AfeV0abjCtxJOuD29DnQAEFSE5pO8h7?=
 =?us-ascii?Q?NVG94NkhQZBmvjM8Fa2mHcRiZ9SYYUQRAZV2dsu38NFDNEPQa3/0tdrp2zz5?=
 =?us-ascii?Q?ijZ2/gVHFN28MZkkYPO/7Weh+K/y3XZDkAie9EH0MQpYRGzXwrMO6nZk2rlq?=
 =?us-ascii?Q?BUk6d9RzaMjpy1G6tY1H/r7FWkCjEC8OnsKHTtQDrxWu56T1ydDAi+DARI52?=
 =?us-ascii?Q?gbXdnTRj3Lx4i8HqLhTE/PzvLz8Rnlzs9HVmJHNUSHUJVZfEmiJ8qtPr9Vbk?=
 =?us-ascii?Q?YxT18qqNVQmlpiAu3PbX9D8he7i74uNMVz/f4x1jMzbFIg8a2RSK+sTgN3Nu?=
 =?us-ascii?Q?0O24ojJ2FzhQf1Nm9y6EW2AFE9vKrHyR2tMbgbhex11numS9WVmiE0wqXG0q?=
 =?us-ascii?Q?z0sjDwSzttw9CcDOBxlIiMFabS4BG4cQeOc55Wkz3cbVfIyGNO82+AYEc3Ij?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98d0503-0083-4b80-ee96-08dbfaefc48f
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:53:10.6027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JU3VpQPU0u8YDHBdbJwksW6mN7iUTMgT3RLlDkzaOQa+g4PsbWABvMPpOho9skZjpWz7dS8ZHRuyWIA41FGsWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5940
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

The commit enables vsprintf() to handle the '%*pb[l]' format specifier
in order to print bitmaps and its derivatives such as cpumask and
nodemask [1]. This can be used to derive kernel boot parameters from
bitmaks such as 'isolcpu' or 'nohz_full' [2].

[1] https://www.kernel.org/doc/Documentation/printk-formats.txt
[2] https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 lib/vsprintf.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index e14c6ca9f9..abbd80ea9c 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -25,6 +25,7 @@
 #include <linux/err.h>
 #include <linux/types.h>
 #include <linux/string.h>
+#include <linux/bitmap.h>
 
 /* we use this so that we can do without the ctype library */
 #define is_digit(c)	((c) >= '0' && (c) <= '9')
@@ -390,6 +391,71 @@ static char *ip4_addr_string(char *buf, char *end, u8 *addr, int field_width,
 		      flags & ~SPECIAL);
 }
 
+static char *bitmap_string(char *buf, char *end, const unsigned long *bitmap,
+			   int field_width, int precision, int flags)
+{
+	const int CHUNKSIZE = 32;
+	int nr_bits = max_t(int, field_width, 0);
+	int i, chunksz;
+	int first = 1;
+
+	chunksz = nr_bits & (CHUNKSIZE - 1);
+	if (chunksz == 0)
+		chunksz = CHUNKSIZE;
+
+	i = ALIGN(nr_bits, CHUNKSIZE) - CHUNKSIZE;
+	for (; i >= 0; i -= CHUNKSIZE) {
+		u32 chunkmask, val;
+		int word, bit;
+
+		chunkmask = ((1ULL << chunksz) - 1);
+		word = i / BITS_PER_LONG;
+		bit = i % BITS_PER_LONG;
+		val = (bitmap[word] >> bit) & chunkmask;
+
+		if (!first) {
+			if (buf < end)
+				*buf = ',';
+			buf++;
+		}
+		first = 0;
+
+		field_width = DIV_ROUND_UP(chunksz, 4);
+		buf = number(buf, end, val, 16, field_width, precision,
+			     (SMALL | ZEROPAD));
+
+		chunksz = CHUNKSIZE;
+	}
+	return buf;
+}
+
+static char *bitmap_list_string(char *buf, char *end, unsigned long *addr,
+				int field_width, int precision, int flags)
+{
+	int nr_bits = max_t(int, field_width, 0);
+	int first = 1;
+	int rbot, rtop;
+
+	for_each_set_bitrange(rbot, rtop, addr, nr_bits) {
+		if (!first) {
+			if (buf < end)
+				*buf = ',';
+			buf++;
+		}
+		first = 0;
+
+		buf = number(buf, end, rbot, 10, 0, -1, 0);
+		if (rtop == rbot + 1)
+			continue;
+
+		if (buf < end)
+			*buf = '-';
+		buf = number(++buf, end, rtop - 1, 10, 0, -1, 0);
+	}
+
+	return buf;
+}
+
 #ifdef CONFIG_LIB_UUID
 /*
  * This works (roughly) the same way as Linux's.
@@ -503,6 +569,15 @@ static char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 					       precision, flags);
 		flags &= ~SPECIAL;
 		break;
+	case 'b':
+		switch (fmt[1]) {
+		case 'l':
+			return bitmap_list_string(buf, end, ptr, field_width,
+							precision, flags);
+		default:
+			return bitmap_string(buf, end, ptr, field_width,
+						precision, flags);
+		}
 #ifdef CONFIG_LIB_UUID
 	case 'U':
 		return uuid_string(buf, end, ptr, field_width, precision,
-- 
2.30.2

