Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D66AC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 931C987AE6;
	Wed, 10 Jan 2024 10:11:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="VFZhI8sV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6C5087A9B; Wed, 10 Jan 2024 10:10:55 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9DE087A7F
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYTWupMpRW9e8WVrYhWYnJa4gffWU1iTaayrAsPcakX07zN6d++xHMvEbjDvxaveSUfk5RK8p8jpmho+1Ay9qlkrXmR3seQgsLUsXiOkSK/iCKb3pBiiuQSb2xvVZB4w5IkOBS2nu3yfMjfwmL5CwdTie5RUf0z1q1DuNC1GGse+R4+i2iHPaHlZ3ZaoCyHPVPbLg9zmHrkGmCNX0dUUfX+iGKmTsrnAt6nf9rVuWa+vL+jDVbMeWGek92k/HqK5VIqzIfX+OZkizvK1VUoXQuEcWBTXuURyobKd7QGi1Z5ctrY6qmvQu0zI4qp9JCBGw486A0fElXC5/Y+v1/Pq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOWXRe4PvDckRIVUhj/uwWlfazwPv/8ABrGoHu1UDKc=;
 b=iCxAUvA7XnmLSDbH59a0R+DChh6O3eCJuFaWXXtD9mxLGaiAfBo51I8LvIqg38/kdcxt/8DioAqt6ENA6InTh0y0UhP+Sqw2kMYZIpjeETsgRZqYIGvQdh3e30lj/a9mXdltWEqcHnCnr1VSO3rwQvkQoqfvM780WsUz+3B8yWwrximhnD750e+fMk16Avk6yOF6a233H2h2+WxDSTNvij7pFq6G2iL6+A8JUGzpDpSj6au1oaozOeZgAxrX+Fasu9z5FxI+Lon8oNUJYv3TGgMeK/uFTyapqaKbZ7BhemKfPEWeqpcP9E+z4O82sr7TFXrsP6C1h8t+Yn244yi2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOWXRe4PvDckRIVUhj/uwWlfazwPv/8ABrGoHu1UDKc=;
 b=VFZhI8sVYzi0XAfFuKwfciZtgrEkuh+ErTQ8ETEbGPZDrOYK68F815x2lKFI4+bqPVQHbNb4ZiFcDqFhU1rFoblc4h+XGGcxXuGppqe0rnVkVe+mWjYEUVHQ3JeDZ0S1UaQNzpn85Nc4qq48ox4VE17en+NtJNSZ7HVf7Kav04w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GV1PR08MB8641.eurprd08.prod.outlook.com (2603:10a6:150:82::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 09:10:50 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 09:10:50 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 07/11] lib: vsprintf: enable '%pbl' format specifier
Date: Wed, 10 Jan 2024 10:10:33 +0100
Message-Id: <20240110091037.392520-8-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
References: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::11) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GV1PR08MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 333c20f3-26ff-4412-c63b-08dc11bc09fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KX4F7V4JjOsdDrkfbuIwEyEqOTJCjDygoLOxbXypDreM7glD+0gKLQ79y02ADEo/wxuwyNE5JzH2hk+/kwq8iwi+XvUyKPO6oUfkQl6YMx5pZUmOKrjItNPHOBxS23+4xwL3PDniPLJ3AYRQeiApxhmY/HEZPhddEJuauQ4aZPH/pW/AsEULWzL9UnuFNPIo6TNN19eZMhvBImBaUN6H0xsdmSdyCMwe5oR/3Lts/sbh7NEUi2b337zyNCYEhmhXLKljU2BStM6J16whzZ5Q7gflB85Grf4POdfYaXKfaEOJUr45MmaYWu/xzLPC2/+jb3Sy8qNqq/bNkiL5MMS5HRjeYUgCGWX/Cd6BeeE7RuTunIx0zkmpir3QeNltKmXGWT8sAEH/nS9vwulZG0mOTzjqKbdbszhOgt1uK8LVF7JZ7rMUIwGjCfPTr37LIU3fcTVLuUSqkZnq3dkxRt3VN4bGgteKeyT3XfEi4GK9pMtjOrsIdyzc0wE1/FVwO/jZUFd93EkkWLpPlOA0QvCc/Nw1//uQOMZ35dtk9mg4Jp7VCT9cWO+sajPIxsqEz8jfag3yYHtq2gTQk7MefozpMVTk9oNEW2FxTjx447ah5Q8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(86362001)(26005)(1076003)(2616005)(6666004)(478600001)(6506007)(9686003)(6512007)(52116002)(966005)(83380400001)(5660300002)(4326008)(2906002)(41300700001)(6486002)(8676002)(8936002)(6916009)(66556008)(66946007)(66476007)(54906003)(316002)(38100700002)(38350700005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?naUd48hBQKsHDs04L+s7J2CAYP2zub8Zdy8VawhF28P67gJRFjlO7uLCeS77?=
 =?us-ascii?Q?cjRBF/OVECgGE9kAoN2qKbKjphXbVSiTfvKOKRZMrRtsydTCkdvFIQlNSXms?=
 =?us-ascii?Q?+OTk6/pUitWiYV1WLcS7sgnGduxrhWxs4xFyXtIFg/3CSputJeY+AJMS4ImM?=
 =?us-ascii?Q?x/CgILEriPnxO4oqwPECbx8CkB0d+7eAje/fundwSnZTwg+8zFwoEAW/slrG?=
 =?us-ascii?Q?ozUKtt1YFsBShO4E3hhcJ0ONvI7l/AGUgf92cyo6i65tz5AbGANQ3JpxgBvm?=
 =?us-ascii?Q?BuhyylQSZwDvO0xlqVxHW728Trc7qfJF0KL3f4nyXO7UHPxu9xFaeD2MCW7Z?=
 =?us-ascii?Q?ZJhTSGHWJZog53uqigbMynQFLcELSOxMpZwKCtRZu+QC4qYSca/zv7Vh1QvJ?=
 =?us-ascii?Q?P8VkBAzRP21LkHnsotwvjlaQ64lvBcvlTCD8cLZwXFOKVfSmcVKt55/1O+qc?=
 =?us-ascii?Q?Sv8dLKzc+C178scW4nvKu22S7Myb0iEAKLlroyTr4VX4dNCz+XDhdBksGwZq?=
 =?us-ascii?Q?ozepY4ymrlguv+pUWNs8evCzbUd64or+FQZaaQ1+uLpmkarU0M9m9ZMJ3wP8?=
 =?us-ascii?Q?qSGV/W9IjOSU4SdYhhBtY7sbbCJ81QXUk//Cfov26xPgSzyiqd5Lfehb+MaG?=
 =?us-ascii?Q?opIEawtkR3sr1N6r5LKpUbgcsE1tQ2NV8vnrRfI51Peo8X2QVQ9+xVLpIsKQ?=
 =?us-ascii?Q?hEW8xQrjowEVvmrONKvyOa9OWjbfB/EBuv5DBXMYR0oDDYjUl42aS0F+StQ/?=
 =?us-ascii?Q?mWfu4HJSDzUTp6+cLg4qnV+nFDvlDMNcvPzDWwJfYyqA/LzAWP/ktvOSuBUu?=
 =?us-ascii?Q?MghZfTZU1kL9pfRBKIebthqVKaq58tBthRf+WADPF/S35VNA4w2emXMvxnQq?=
 =?us-ascii?Q?jLxcNeAJrwcYCfc9pVrDHmpqpdEZfPTZQT4XIABMqSAcS0QnQ/mpSY+HmS9P?=
 =?us-ascii?Q?oTn0kjPiDkvVqyJoJgv5EuFhi80GniFsVv2keOxfsOp1VGwBqnExLeogLH5+?=
 =?us-ascii?Q?beXbFFh39NAAkmHX+gK3uUaPKS0S6BIUWZd+6h/Sc28OztgbWLMq9212A6GL?=
 =?us-ascii?Q?UW0NYzwMlA10nEh7agxiFSVHR/omccSHxWT750Xy1E6bWBJ1fyiA/xpwYZJu?=
 =?us-ascii?Q?s4D9rctsnAB1HdLJtznpnDLC1GswcWViHoOogVRpNUw36/7lBXWSDvHcAqF/?=
 =?us-ascii?Q?HNndu6dMKqcdYoCFFVED7KN7g9dmRSv8LFQJK5jna9QYLFIktHCh1u8ud4oW?=
 =?us-ascii?Q?o+miN2MDWRl626lHLZonVk47eBJahYIr5j9Raa8lj71gWNFlMcT5X881yIVo?=
 =?us-ascii?Q?Pxo+p8xhZ8Qo+feUaiHI9fbXXGU3ONfTqXVQPAFDpDOC+Ejpu6x15SkVCLtu?=
 =?us-ascii?Q?aGtsLGlWFiZxcqPC4gJaD8rO050+9hnDl3qguenzT10HpR7amGYuDhRiL4As?=
 =?us-ascii?Q?gfrTJXKmt2qOuKiC9xuNMCHAbpovBEO0rtr1wa755NMN1vkElPgUfxlEhkWq?=
 =?us-ascii?Q?u72Xobr2cQAnOFp8q+Z8jlsa0/YUht/LwuHniOciGj9yRZuSp3Ub7HM0KMQS?=
 =?us-ascii?Q?a5TH4XTTDMpXt019mW5q9hiP6wlCOGAqsEdi9f9Y3cFr2TmgGvqAIU/TFfmB?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333c20f3-26ff-4412-c63b-08dc11bc09fc
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:10:49.9737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6H54BnJpJDXQwOgvW+Ww/oHvlCjDVKvGyZlqZ1VK6y+wx67K8syg/AG1CgV58PRDwcNNqNesUz6RCudGUetlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8641
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

The commit enables vsprintf() to handle the '%pbl' format specifier
in order to print bitmaps and its derivatives such as cpumask and
nodemask [1]. This can be used to derive kernel boot parameters from
bitmaks such as 'isolcpu' or 'nohz_full' [2].

[1] https://www.kernel.org/doc/Documentation/printk-formats.txt
[2] https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

Changes in v3:
- Remove bitmap_string() conversion function since the same function
  can be achieved using other format specifier

 lib/vsprintf.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 27ea9c907a..e1779d75f8 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/types.h>
 #include <linux/string.h>
+#include <linux/bitmap.h>
 
 /* we use this so that we can do without the ctype library */
 #define is_digit(c)	((c) >= '0' && (c) <= '9')
@@ -389,6 +390,33 @@ static char *ip4_addr_string(char *buf, char *end, u8 *addr, int field_width,
 		      flags & ~SPECIAL);
 }
 
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
@@ -502,6 +530,20 @@ static char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 					       precision, flags);
 		flags &= ~SPECIAL;
 		break;
+	case 'b':
+		switch (fmt[1]) {
+		case 'l':
+			/* if the field width is not a multiple of the underlying
+			 * datatype (ulong), we get incorrect results from the bit twiddle
+			 * macros. Thus, round up to a multiple of field width of ulong
+			 */
+			field_width = field_width % BITS_PER_LONG ?
+				ALIGN(field_width, BITS_PER_LONG) : field_width;
+			return bitmap_list_string(buf, end, ptr, field_width,
+							precision, flags);
+		default:
+			return ERR_PTR(-EINVAL);
+		}
 #ifdef CONFIG_LIB_UUID
 	case 'U':
 		return uuid_string(buf, end, ptr, field_width, precision,
-- 
2.30.2

