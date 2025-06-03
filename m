Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA68C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 11:55:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B9F82AAF;
	Tue,  3 Jun 2025 13:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="kBKaNQUy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 722A481E72; Tue,  3 Jun 2025 13:55:06 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDF53829B2
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 13:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acSutzE8G8jlIXT3AvDkENGpEnA1P58X0QVJS9LBnC3U5cZHPj+UWdNYZlmWIZTKmebIztfe+25yMjkINpkazyjlpml/OCgZTYykRGHOV4aK+4rMAp8+9QZGElFjuLHH/4yhN1oagqCE727/EIrYthCW8PNNT9T3YuayPBxo4ICUGefYCXVb6yp1hS8A3wd0xayEo4ZD9pnfVZ11493U7XbAk0T/cA5NfpvQZ6+F0N1Sk0is/XsQ4IvOei639NcWFjuUrvGQKety3WysSFXekP8hO4FznkU82lxwxYrtYNYjSWQ6rUzIcRhMe0r3PwZHleF/cbtaPqcDmu1i+aYNeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khz1IYuFbnBbplAnIoOnExnZo7NioYOfEwBTyp1u0+A=;
 b=abY195IwGLr+B5ATlxih63A5ZVoVsoLOz+6eRm7NbAliQmYuSIZlQD1PoeXVzXRRUWy06IceuUsWz8zBUPzYWgtp4CH5aa24u4K6iE0Qv7oPCfQ6toAiQRdxRCS34Fpyp/NOWW+/vijcswI9wLSAzUXnWpxNlI78tKL1vS0Mlk1TzizQR8k3JvorAqSq5v9uD6EvBwXcTPgJ2c/9WHArMyJZgiyCWm6h8E/qybN8AzTtjnXHSZAu46CW6dAO9jVGD50qAG61bvtplpWlN/abxYqxH1PC7yCBC6YzQlvPaDKH3gqAQ5R/690z7q2wb+vWQaW2xoJH6YZRJZ8AuxrU+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khz1IYuFbnBbplAnIoOnExnZo7NioYOfEwBTyp1u0+A=;
 b=kBKaNQUyM+Gr8XE915usFvKs98A3aw4IMJM1uuYJcixsYjNO9ez8UwNkqrapC/klxnzcVonvrJtLB/orPy9DI+sdmN8e44c3S16DlNwDfjKJFwmE4xU3+vbMEZYsTCJ05zYEjXvyki89Gax37Ih2Ra30xAb3G+AQIeRIJcBsuYHF9FXGI4PEUV/sYNGAot44qKjPEYHJ7apdZUvS+FRf9gMGX4roSB2VdJDFh6hFd+9DnDVn3V9MPSJMqlH2cO1VEgVgCBY4Hryz+PVqJD4hQQCn0zXOOv0vsVq0zWyOEc4fw1ifG500cRc58VSoeFNnQkpx3widE4BntRK1z13Peg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SN6PR03MB4288.namprd03.prod.outlook.com (2603:10b6:805:c6::21)
 by BY5PR03MB5000.namprd03.prod.outlook.com (2603:10b6:a03:1ee::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 11:55:01 +0000
Received: from SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55]) by SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55%5]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 11:55:01 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v3 7/7] drivers: ddr: altera: Fix Cylcone5 SPL boot loop issue
Date: Tue,  3 Jun 2025 04:54:42 -0700
Message-Id: <20250603115442.19971-8-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
References: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0036.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::49) To SN6PR03MB4288.namprd03.prod.outlook.com
 (2603:10b6:805:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR03MB4288:EE_|BY5PR03MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d13a28-590f-4e8c-e53e-08dda2957842
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vumK/CzlvAWNNOtmZqyCVV/Z2d4Q714Jr+Uzb/w5TCHd8r2xAGwY0hDe0QUr?=
 =?us-ascii?Q?hHZs6o+/fnEjHAzjunNtKxGc8fILr3tyBXDMFNUujp4pc4EtC2W3jQ35+nIW?=
 =?us-ascii?Q?Bk8VBYDbi3uCSn4qjeUkU3sgwOpucX6+PjrZdtrGdiGQ3WF3ljcDw/pvmXAW?=
 =?us-ascii?Q?Sba3g3k/bful/RaByHuScNwzx2GTorXE0D6Y1SkpZupFSak1bOuFxxxKwUMk?=
 =?us-ascii?Q?ZgNdzVTtdvq9hctMcMszNBQw5fV4VSVSnthXa4xZI/6cgpVd8pEEgPrvyV1r?=
 =?us-ascii?Q?nGZWCyauEDwV5BPjfY0rGzK62PjdiHq+0118iXbjgLARsN2NfU3QTU6dmbgX?=
 =?us-ascii?Q?uYF9wbl5ijnjVJY9CCPo7Mw6baTjcd0a7wopED6HuhiynuCC9I4SmyoDPYRt?=
 =?us-ascii?Q?1TYc/Tm1cxi+8bV8Zcw2F3NprnuZvvSHqSlKm6ZFGjyNvFHL3WBnE8O7V07A?=
 =?us-ascii?Q?t8Wjz2uz2vs0b5TQ4hlTeBxJbl9jZ6r9lQW/rNPA0N/S/qVM9yYJT4jW8oHf?=
 =?us-ascii?Q?D7z3JlatvA6mjKoPYwci1V2m3jLuKINASiim8MyKqRZo1JAR/4Noyl91A1uA?=
 =?us-ascii?Q?k0bTAum3N0N4qjgx4OKwSZU2iW+o0w9unst6c4tNH0YQjRymzzWp+oGz+a+N?=
 =?us-ascii?Q?lKZ2GzBaXUsCFqVYnDehIS7NCAarKpBv33aALN7KcaymF0tZfZMd304PNFlz?=
 =?us-ascii?Q?u0duE+h0joiSM/njjcbJ13QgPKjdRCUeCjAHS7fYBHsSoyUjG1pcKH8P9Hnq?=
 =?us-ascii?Q?uGqwtyXuf1A7MaNHbpfmhkw62RWhy80uTaP1aR72pHlQgulHOh5YSBrkvZKM?=
 =?us-ascii?Q?rW9jjWqcy63N9AdsfP1aLt4FT2tesabChiG47WWmXqey3xTL7WIU9r6MP0aN?=
 =?us-ascii?Q?CQ5Zk1EsIS42bAcF51G/kfVHp4J+vFivhDmhn2Y4CedxS0v8nYa4+9esR5Ae?=
 =?us-ascii?Q?jJ7x/woCP3hU/leJeuFSed5Sg+D71Wq3MwEa/N2/ZFXtqPEOiglk+wXKObRg?=
 =?us-ascii?Q?rera2W/T2Fzhy7O/KUez+7N5DKVFSdN/04qGm3SQwBtfiu7zEDn8vWotCsFF?=
 =?us-ascii?Q?UzlXF+c8iLG346Lzjyocxh2gfl10vEC2TwJArHnIhTTmUVVysMJSeJ5X9kES?=
 =?us-ascii?Q?HQM7QiU2DyND4+UOhWJkpXfka6Dbd6LZ4uE38A0HDWNDdauXGJSSk/HbRkI5?=
 =?us-ascii?Q?rEaJmJ+kp4RrTxhpk+zUa+AB0kiLoBym9VyLFVBEoKASgFnNj10Uw1a1NcfO?=
 =?us-ascii?Q?RSBY7n4U0DoI+gCXxpOEey3gl1A6vsB3hm/CjKDPGWLg3qiyY5nbNwfKvSp0?=
 =?us-ascii?Q?lH6NlHuzIeURj2wMShaLBuYWz5JO6+323ElLxRaAJSm5AcFO/D/1beJadbKz?=
 =?us-ascii?Q?CS+Q/gnuRylhqnjQbSoZkbSnXSiXMozRHt5t1wlmu2/EkwFLUWPvBUzYX+Lh?=
 =?us-ascii?Q?3JadyU1iYTk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB4288.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lbtEk2VPhf+e6D12TvgFzKm9iyhM9a62pvSdJUeNVVvPjGZ5hAEh7dxEyCFs?=
 =?us-ascii?Q?uJpcmpaKz9WSYfUuPiCPWyH8++59JJYJhB4trMhOStQAU6NNvJ/hCN1b4Tx3?=
 =?us-ascii?Q?VC9z54Me/OJ/7Gz1/1Kvwp7XqH0JcAMfKVUF7F3RjO2wlp9HyvioKhSURlYQ?=
 =?us-ascii?Q?mzYsT8dPd/qf0JJMUuB0xTtkr7TwZsbuI3fpmaOOktCWscPTwA/imaw88Ove?=
 =?us-ascii?Q?7juIyq10Nsyqfr+KX62sOwqQRcQZnONdCinpImv32tPqx57Jp8xt/I1/y/Bg?=
 =?us-ascii?Q?5ZIkf2W6lla9yWVkxeJ3nd43BM71UZKH6SCyRWXydwMXWdG9wiBCS6EoKeoL?=
 =?us-ascii?Q?VqP5aXSaZY6ZH5+n8SyhywvI4Zn9QbqG3KIcE6kb3E5+21AJV1AAei1GTGGY?=
 =?us-ascii?Q?VtMciTJu5OY/AeWcxQQHt40KlTDX9fwi7+eNjucd2pC+xnwKacuv1KEMMAf8?=
 =?us-ascii?Q?OcmQNRlPcBbbRO67uYgaJSAy7P27ljSAnrWhJIdBCc6cKztBuA/NHbCBXIci?=
 =?us-ascii?Q?NEr6Ok5QHeCDELJ+ognJx24qFo+k+KUGfjkzQh2R/sxQkLLQ8KsIU3OxI0nX?=
 =?us-ascii?Q?tWLBtE0oZC7fKZV37BYNgdJ5h7KhwPnw+5sP/10PpT/qcVVt7XE0RG9l/VQ2?=
 =?us-ascii?Q?4xluWVKKClHIbleGCUMNW/vopglqwidXw6ZPh4U/zddoHQC6XQ0i+RzdHPWG?=
 =?us-ascii?Q?d8iiveg5HXKl6iOjUC0cIo48chVtU9XeN26hrkFulmsJUnm7Dwxk+9dL8S5s?=
 =?us-ascii?Q?X5/hJkz4EuPAH7Aw9HXhrRE0+2l5hOjXNtimIwAsXneeGq0cdvCthT6x5T1w?=
 =?us-ascii?Q?LxkawJpgR+hhCuYLgWGmoDTNdLNy9RZth1ebfXH/vO9WwrzANjSxTc+98rUW?=
 =?us-ascii?Q?zbfM/P0yESONEuNoAe9EjE23fgqZJSmueUic7C4NcMzKIl6YYugqWH5Y4h2v?=
 =?us-ascii?Q?PHkAvpjQhP0PsL+w1CR1u2OA0BjRzYJObLrEiWvcqUPY06NXAOftmaO2Pyae?=
 =?us-ascii?Q?9Tq/7i0J+FbINlMr/PEJ3SCMXQxR9avt4etN84lTI/ft5i95Xhe4Ry2jiYU5?=
 =?us-ascii?Q?fx2oQ/+HaJ2iyOZ3tN8ITz2X3pp08YuzKTONXNjV4X7trbZa//ciE/lQ2Lgh?=
 =?us-ascii?Q?Qr/JAbZfqpR1J0b67ApbUlNb1o3+RjDaImuIDtD9eG0O5iysrKAAWSRYRty3?=
 =?us-ascii?Q?6eH93jSV0uGIGN4lUistrTI4lSSbTRv7h0JTiqngmB1mmoBc8Vj0xxcrmMI9?=
 =?us-ascii?Q?jVY4CPj29FKh8XNcMqwcNwvSsFvF/qyD2qp9+qzFrzmAQB70NcqVg5gNKbRa?=
 =?us-ascii?Q?05/TOAZWEQpKFACaDmpsc95wmcKH1oNt+vV+lAma9wbQJNxuu4pinEugsQGH?=
 =?us-ascii?Q?Ym9FV8Rcp5pnGjvHTjQ/D4aIH0EFYTGiop+ROtJrc3sO9NAxqPp4+HBTzdvx?=
 =?us-ascii?Q?BCICqNPwAL2xcV/tKbblxoS3Krjv0y+AY4d1ON2oFfE/rMHPsnqS/ZIvdV/m?=
 =?us-ascii?Q?GylG/LnuIz11HfCAcFQiybkXlLW2GfNBmo9cz7moOE3yfYeft3TlcfEyJHeP?=
 =?us-ascii?Q?JSLRznk00iFOz7g8ST14vvIQ+lG1Qri1ry2L1Oy7qpWkbxMVKNS+IcW+w2mZ?=
 =?us-ascii?Q?mkS0WFT+rT7MtqbnLaDdeFI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d13a28-590f-4e8c-e53e-08dda2957842
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4288.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 11:55:00.9437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wM7WlE8wDIyZ8QIy0Fd1g4wy7WPds6RNX3QSdlqqbVmptvS67oi2Tg0YAPaHNkJYgLa5GWNo0Y5XWkOGj61Gi+YDRgojDiF9AeSW2TWGDoIqWgC2dk5PuAVhCXZn5j1o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5000
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

Hardware watchdog configuration is handled correctly to resolve the
SPL boot loop issue on Cyclone5. When hardware watchdog is enabled,
it is reconfigured to make the defined timeout valid, else, making
sure it is not running even if it is enabled in the preloader.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/ddr/altera/sdram_soc32.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/sdram_soc32.c
index 5cdf48d2d01..f63360f17d8 100644
--- a/drivers/ddr/altera/sdram_soc32.c
+++ b/drivers/ddr/altera/sdram_soc32.c
@@ -8,6 +8,10 @@
 #include <linux/sizes.h>
 #include "sdram_soc32.h"
 #include <watchdog.h>
+#include <wait_bit.h>
+#if !defined(CONFIG_HW_WATCHDOG)
+#include <asm/arch/reset_manager.h>
+#endif
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -51,7 +55,26 @@ void sdram_init_ecc_bits(void)
 		memset((void *)start_addr, 0, size_init);
 		size -= size_init;
 		start_addr += size_init;
-		schedule();
+
+		if (IS_ENABLED(CONFIG_HW_WATCHDOG)) {
+			/*
+			 * In case the watchdog is enabled,
+			 * make sure to (re-)configure watchdog
+			 * so that the defined timeout is valid.
+			 */
+			debug("%s: %d\n", __func__, __LINE__);
+			hw_watchdog_init();
+		} else {
+			/*
+			 * If the HW watchdog is NOT enabled,
+			 * make sure it is not running, because
+			 * it is enabled in the preloader and
+			 * causing boot loop if is not handled.
+			 */
+			debug("%s: %d\n", __func__, __LINE__);
+			socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
+			socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
+		}
 	}
 
 	dcache_disable();
-- 
2.35.3

