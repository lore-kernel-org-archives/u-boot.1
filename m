Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB45C4167D
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 17:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04E16871A1;
	Mon,  6 Nov 2023 18:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sachsensolar.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F07D686FFD; Mon,  6 Nov 2023 17:47:24 +0100 (CET)
Received: from DEU01-BE0-obe.outbound.protection.outlook.com
 (mail-be0deu01on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e23::70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2537A86335
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=sachsensolar.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=verkauf@sachsensolar.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FquUHLjikfMl0GZRdmxHZDkjBUFmFjOHV3ttA2CYhtBx3kW1NNM10xtEvTl7OP+5581aCZAZYvWfKU+9lzNFDnB7eAoSZO71PGQKjEcXZ+fLaJzz3JRzSX1rufJ+T4g/LmoYdWDhgrIRvWAkz6ZDPctSCI2lxVpg9wsa1IBqY8NWY86j8QDU/IOMtb5Ap5RENyeq7Ro7/JocU8Ywpz9R7HmDSBnPvOIZ4aOsg6Ia1cG869A326b4h69FWzVu+mfiIl8JHnahkkGCCnWyfXukHfLdRJoE96qN4pC1X69pJgS97AVrxVKmM3kQV/lTUgPleFI7l+OTYPYH0OKv+l4R9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fd3jwPCqgwA8prXs7k5nvHB/z/tLvqDtDEF1Dlg+HCg=;
 b=cHeernLHIl76fEV9D7FZ+RiOnmGxgY7IACkjOXFoHAvoqubim8fT6ZNrkfYld4kpnCE+BNICFM6FMqk9ikuFhWw4gRQ2NGMt1I2fXABWGPKItdmOmhPSIEPIGedE4sm3hZAEsbf6C8naekCeBD9ZZlSf6e/+cw6+GTfJuQtVL8AA1iUWMR2JW7zr2r8a0rR3KNcxzBT/Wcpq1X98zdlpu1DrCR2aBtc82AinLfEtHHDSuQkHUwOalIOgl/ip2R/PF+rbs0Zg/gw1isYu4jDfPi7sK7EY93w9755UUGNdSUwpKlJkgIuH9Au155FrxI2b/3VPqCDLA6pac3oD4K7jVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sachsensolar.de; dmarc=pass action=none
 header.from=sachsensolar.de; dkim=pass header.d=sachsensolar.de; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sachsensolar.de;
Received: from BE1P281MB1602.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::7) by
 BEVP281MB3507.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:96::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Mon, 6 Nov 2023 16:47:20 +0000
Received: from BE1P281MB1602.DEUP281.PROD.OUTLOOK.COM
 ([fe80::cf6e:ba41:12d0:25e9]) by BE1P281MB1602.DEUP281.PROD.OUTLOOK.COM
 ([fe80::cf6e:ba41:12d0:25e9%3]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 16:47:20 +0000
From: Sachsensolar GmbH <verkauf@sachsensolar.de>
To: u-boot@lists.denx.de
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [PATCH] mips: implement __udivdi3
Date: Mon,  6 Nov 2023 17:47:05 +0100
Message-ID: <20231106164712.297907-1-verkauf@sachsensolar.de>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::11) To BE1P281MB1602.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:19::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB1602:EE_|BEVP281MB3507:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e824eb3-de53-4d0e-7fd5-08dbdee80b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kzCL7TVkEzsbKFTHBU+ChohiMuX+jCj54nYVU0E1AtJ9RoJpjkiWsxrhRTrqcVDCqfP3tk60FMTJioWTvvksn9CNcvgKbn5kCvxRdX+9b7CjS7Jx9nujN80KL5ODVz/QSCvo6JkqPkc+aceN13x+429kzBppEt10biIg0dwK6YZKN5TK5y/3iSeWDyQo40vn2yIe7xZkK4T8Omo37OajfkwnIFPAxRdbshVYJvO3x+mRw1mqpDiGoNf9dIa7vsV8ApeAEGmb+ADG5cVe+i3Yr70UVOgVf3dIvd96+hT+XbFWADdXtEEVDMHJ9eNjPZUYgKomELFB971Yg0kTkpOE04HrLGeijV0eiqNT8Nvg7bKriV9Qgp7aLxb0XbrsFPzAH4qQWQgSy3YE9Eacbsm/Xk4d9pi8FoHw4+zepzDGqYr9ba8QtWP/ozgNjzxNwDUE6UdOmXUKOgpEQukIQ9pDgte/DSgla6FR17rmtMl807TxGwBrpXmc4RK8Gwmx1WrjTKmrbzZOIdiqZrPvpgJLh8u6yDKFkaDnbsI5quEUTXpPqM10es6AKdXQyWzKGI84Vb9R6eOLEEfokt7wjqfc5CYCLT+r887pHYVZxzTnNwWB0Uyo+U5NykoRCfa8mqLT42erRZUgCnwe2/UqL7JA5m5+UnksM3jNJpX7mf/1N2p04foEMVwsIdt0ciFRcFAr8Vmqj+nlQ5oIeAoDgrzj5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BE1P281MB1602.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39830400003)(136003)(376002)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2616005)(1076003)(6512007)(66946007)(26005)(6486002)(478600001)(36756003)(6916009)(54906003)(66476007)(66556008)(38350700005)(316002)(6666004)(52116002)(6506007)(8936002)(8676002)(4326008)(2906002)(38100700002)(83380400001)(5660300002)(41300700001)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DJ0g2okq8XsehcXf4MH7J30qc5GOWYdvbobL6nWfqgJJHL0u88SOOZFREVzv?=
 =?us-ascii?Q?OgdEtTs2sc+stEmim7nxmDMQRwP9yxKhjKtyEE/RypQdRmHBBz5N2NPQlMXl?=
 =?us-ascii?Q?XcuwhgRwbbaQoNx/b4FD3z4g/7gilYOQl2dWxZDAXuc178m8VJ7c1fWb1HvZ?=
 =?us-ascii?Q?F99SVdOv6gXKYkcc2qKbSjRvYhyT4mUaioM5YfLrpz7MAXTcxU8od0w0+snI?=
 =?us-ascii?Q?FVS3AH559i4lOUSDCW5NswNkfwCqEL2uzP4X5cUPr1CWmxWWTaLuensqU81x?=
 =?us-ascii?Q?oZYbdHHET2n/i2B7q5G67h8YkpMMtEptANt1zfboz+6Z353VUUHZFKnAkjMB?=
 =?us-ascii?Q?kx+H65EPw8+kXvhKhOhDX/1wqXAzJ2pH25Kn+G7KSc1+WPYy5HtqQ8tT3EDT?=
 =?us-ascii?Q?68iTvb5iT0NNRD4xsgqT+/OoIssNyCDMGMSGC9SqJzyectb5zAOaQIVuYogr?=
 =?us-ascii?Q?IU/yxYDTJbOCQig5QD9Z9UijOoPVuZqQDZ1k6XAMeWpJNiB+e8AtS+aO6KIl?=
 =?us-ascii?Q?VcxXStpsBeHk69wCA8OG6L8M0rjkwmnl8c/ievR5Zq6fTaDFtm+FItjPnAwh?=
 =?us-ascii?Q?FnAbODjELHbsdi/AqUoPeJmoN5PF42qBnOtdbnJMw5h906MkSykNfZn93vX8?=
 =?us-ascii?Q?o9ZNS99ujmmjAeKzUXDorHUfbieegW3v/Gxm321sXCqMa5esF6dqFw5YbrMs?=
 =?us-ascii?Q?Orv57OX3/jT2s7VCp/bdA9Bdg/9YyTc5dpfSo+ryCnZnBhusyIa7Y998cJHY?=
 =?us-ascii?Q?oHuOWezNLjvqYyhDsbsJ66bxz5MQoSgfeOtiptNGAEeaNFyfjm86gTntV0sF?=
 =?us-ascii?Q?m7u7d/6TVAEembLwuiRb1Be1lMUDHr6hxRsv1GElmY/VAKsnxbbU8cR5IvUp?=
 =?us-ascii?Q?04QJOaAwAnZb2WMSL+i4jUunPeYJlHVQdAFiQLYNMCOCZa/RErUlqU3x1PRC?=
 =?us-ascii?Q?m7HouCNr7p05Gquz5LwLurKHB+GAMOnAaAaPFTMAH7VOholwowxzmIWcM44n?=
 =?us-ascii?Q?a6/J/0zfajNvdi/g+25GR/Y1ecEmIuTNNVLXdahU4mxSpGC3RbphHwtALrI1?=
 =?us-ascii?Q?m5WtuhcN9Ofc/ISk/uoG3mgCsBiTTFzA+iefTldFO2/nR+X+0umxH9PQ9ryz?=
 =?us-ascii?Q?hl9601Y1R+gSMJkgcj4ITyPaFj8LYOKLdEUSI3h8sAA3bj+26tSxuNRNdbdp?=
 =?us-ascii?Q?aLuEorLjIZ0qYmNbZz7xSyGHmR2pM4VjI+tDB3gZYBJ0IEOy7lMZOHiXs/T4?=
 =?us-ascii?Q?VrFz6OFYUoAf4fFKEIQtoaaiz9niGoPVKehYfz7zxtg/tmOQP5KacuqHXKGZ?=
 =?us-ascii?Q?KEI/xb25vVJUtRROV2ZDBZzXsboGOFeidTAvz6dey1X/y+bQShKJZA+Zwog2?=
 =?us-ascii?Q?gOZu9K3IEfmrTB2483vUzIafqEItbZF5ncNdAMOZbLYr5znI/RcHfcMwHpng?=
 =?us-ascii?Q?zeAp3AqjxknyKCiMUU3mz2BdijKcHF6ULbZRFtuo6pdb9ar3NFiTkGPVcd0o?=
 =?us-ascii?Q?D1ZVYULcUr0iyzJ1gP5w4eym8LkCTfc44KlsqF5B4VTBScZAWujc15xKQdZW?=
 =?us-ascii?Q?z/BqSKXJeqO6OeWbKREj2AS6pD2lfSIJrwnkDrD2xAhFSGLOH0Anomlq0szK?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: sachsensolar.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e824eb3-de53-4d0e-7fd5-08dbdee80b52
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1602.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 16:47:20.7912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0f3a0975-10d3-4ef6-8a35-d1ecb2505887
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9TgydCg5qU7AK1ky60YqcmrWdcmQUswVShg7lnb75A6l4k2M7aBHS1zAoOuG/0j6xkyaAkgDS+J9dasTWX7r4D7Cobf2yTDSo+qPubNbyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEVP281MB3507
X-Mailman-Approved-At: Mon, 06 Nov 2023 18:11:24 +0100
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

From: Linus Walleij <linus.walleij@linaro.org>

Squashfs wasn't compiling because the lldiv() directives
turn into __udivdi3 and we are using private libgcc.

After this squashfs compiles for MIPS.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

---
Linus, this is the updated and optimized version of your initial patch.
Sorry for the long delay ;)

 arch/mips/lib/Makefile  |  2 +-
 arch/mips/lib/udivdi3.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/lib/udivdi3.c

diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 9ee1fcb5c7..1621cc9a1f 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -14,4 +14,4 @@ obj-$(CONFIG_CMD_BOOTM) += bootm.o
 obj-$(CONFIG_CMD_GO) += boot.o
 obj-$(CONFIG_SPL_BUILD) += spl.o
 
-lib-$(CONFIG_USE_PRIVATE_LIBGCC) += ashldi3.o ashrdi3.o lshrdi3.o
+lib-$(CONFIG_USE_PRIVATE_LIBGCC) += ashldi3.o ashrdi3.o lshrdi3.o udivdi3.o
diff --git a/arch/mips/lib/udivdi3.c b/arch/mips/lib/udivdi3.c
new file mode 100644
index 0000000000..4d780117cf
--- /dev/null
+++ b/arch/mips/lib/udivdi3.c
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "libgcc.h"
+
+#if BITS_PER_LONG == 32
+
+#include <div64.h>
+
+long long __udivdi3(long long u, word_type b)
+{
+	long long ret = u;
+
+	__div64_32(&ret, b);
+	return ret;
+}
+
+#endif /* BITS_PER_LONG == 32 */
-- 
2.41.0

