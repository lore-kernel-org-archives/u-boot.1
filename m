Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A81CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 23:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A250863E5;
	Sun, 24 Sep 2023 01:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="FHUBJBHQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C19D86A24; Sat, 23 Sep 2023 20:34:46 +0200 (CEST)
Received: from IND01-BMX-obe.outbound.protection.outlook.com
 (mail-bmxind01olkn20812.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7011::812])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4204686996
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tjjh89017@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4Nl31qjNtSUzM7WKhbidLQfeawiKc5hi/ez0JE8uW/CgY800tIVIcaHYVwe5k0cWzPFbe+1hknqsNpD5KdJRXbMekOhQ/t3Jp0bQPJTZgmnXjgn3Ymh2AMl9qhq+hIvjGY9nohINYKcej7UAT/ecO2DO26XeyxU8XDVWbfVgON8gGqEXF8Tg+Th/m2yIBy2/68vR42nHIE4RCNVV5wuQuE2HEbxgCUdGU+PDDPSpCBvLVUTEiA7J0gRLZ3yLQNssKqY4cN3JWir7rdRg4Llfiq48kKLzrLSHjF8H9QtwlVDWs6Z+X2i4Ri+T5jd3VcIjYiLXVOO8ZpTLPGOiihyvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46r2Uh4bEB8BnXtE3LIL9uJfJwQ/aosHNxSPbP4uQ2I=;
 b=ArjFDOA0IqNZhKE0SGjzD7bEB20MQIcfbmidcT3iLMUN/KCG8lWIxbBZjtwRGa9gFUtfbDld3k8gdf/V+fgXG6brv8vHIF0BQ2Dr+7+dkUzu8t68hHu8chlzVOqQVs7hMfVDlnTYfED9LzpNLXwbri8L+189nMHTFGaS/OWVrJug2pgRE/qhxih4+Td2qBvFJLB3sCzAiB609C0NCTtsWyyW86xnfjwneoTSTop5pi+tpr+UmCtd46VXPgEuy4l4SJpkVP8YAYvSj+Ast3zR85yCXn+uUpyuUS4whZ/QXM5bvsLh51fciX2Q4EX7cFl00t1cP/Y/c5HTHZjPpmFDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46r2Uh4bEB8BnXtE3LIL9uJfJwQ/aosHNxSPbP4uQ2I=;
 b=FHUBJBHQ/1kwWAb7HsyjV2mT2DgZkz8kTj5NlQPXSrhU8MMcxw0aejEbyQAR3+lxVUQ/0d7TtFf5ENbVd8ccZYjrT8NQOpnfvbUPNPyZR5lpr+GekhfvpNvmxwRMIaIfPEZl8vYi/ofNjEKUxkeu7NIPV9QSAotTOKsjGeFT6k/SVxRu/0ZwdN+dsjncaY26gtROT+bhV7cbzLEWbQPYq5NUZ6HVhP9nuZDR8Dmsqoj8WB/qEgoSFI0Vtx3XhV1oE4l/cw0pnC87Ks1RXufASPQ6v3S7PzppMlV05glWGXENf12vcfta2hkxrpEehI64oef3MdTrz3z0/pKUXqr2iA==
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::8) by
 PN3P287MB0114.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:d9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.25; Sat, 23 Sep 2023 18:34:39 +0000
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::43b3:9c7e:61b9:5278]) by MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::43b3:9c7e:61b9:5278%7]) with mapi id 15.20.6813.017; Sat, 23 Sep 2023
 18:34:39 +0000
From: Date Huang <tjjh89017@hotmail.com>
To: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, tjjh89017@hotmail.com
Subject: [PATCH] arm: rpi: set boot_targets with correct macro expansion
Date: Sun, 24 Sep 2023 02:34:22 +0800
Message-ID: <MAZP287MB050324B04DDD0AA9C6DD905CE4FEA@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [gvxXqNK+ygkBMiV4l4tvc8xN8sI6478BIKCnqZcn+IErgFevjo05sW1lu2LN42yz]
X-ClientProxiedBy: PU1PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:803:2a::31) To MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d3::8)
X-Microsoft-Original-Message-ID: <20230923183422.26504-1-tjjh89017@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZP287MB0503:EE_|PN3P287MB0114:EE_
X-MS-Office365-Filtering-Correlation-Id: df497bb2-f502-422a-9aea-08dbbc63be87
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1zEuSjv8m8nSOSc5dimEDU0uzoXN0x8zegvgVzSurIVxrlLRwL7kBvaGOt7/yo1ZlcOGa9rn1DSqamBf3cinj+72HbArD95p/myZW6PzucM3byxCOm7ZenEHlFpglbUOo+4+lSymsyEMgSUcZFH06fLLCEp83F6udcM9OpaFSk/n2B8IjykFY2kJDh0ErqgnqnxjH2I0q5oTQjOEnnZhAlCwjaaml8wCMCsjoHxdKtRYh+tO1FpDjLwiGvSLwOel6dXaLaQhAEERRqO9Hi2DhEUMv1yD7HJ+zQbeNMZGsUP7hdL6jmXXnCOPvmI8FQ5sDW+qw2bdxpGOPCBhfVefSbQMC3sU29FuBtX8Ho+XwF78TwImIXbas2H+QMZWZ6l5LQB4cZfA5NUNbz53RlmU7rs57Upjxjs/7gehekdQlIlq07yQML3MVc5HwYBhi2v3GfkOG6ozNc4+3l97Qlv/xJh8uE+lwvpCLIM6XLQHQc18JRDj+0uiFJNLMo2hgxpVxvkph6P/8CCubexaFgi0ingt+91/2K1CegkPqPWxSRgCAGaKYtFA0IsQ1moS36P1bkrO7LUqEp0rKFpnyfjZ0XA/xb5TpmqMcbcKQP20Mtl0YbszOU6pK01ULq50/2g
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?151IlDffXjb+6+X8XBMfAx5RnJkiWAdtdJZ2DpUp6VtvTQAKUCxJ1R0wPY5i?=
 =?us-ascii?Q?R/KQebT2jHXGUJ7D17zxRdO6EtfgYW1GrN+/Q8MXLXnWVNXbOO8s3ROGIlVk?=
 =?us-ascii?Q?imXqxpgVGA44ScA97gFkOdrcze6osfrdQaXsPN1XK3iQpywfILCOyI9q9Ykn?=
 =?us-ascii?Q?wakScg3d2oimqMtIfgAN+WmZF/nwgpPe45DfjMuMPyQfdxsxi89fN4Q7kohr?=
 =?us-ascii?Q?C52N05pUh2eFwCVJurMtIBHRgae1ESalrmrZ5LpmF8tcIJXwURQofLQtYoN1?=
 =?us-ascii?Q?KAC4Taoly+EL1OB5+vWwp8UgsxOmdQ4a9hx84uWSZeNHoDmNPPZHjtAfv4Q/?=
 =?us-ascii?Q?wNawldWXUm7NTsEia5HMGI6oLivlMDlL+J/ln2CIXL55uVn19/2Ron8YSBCr?=
 =?us-ascii?Q?Qyh/3Sw/d1OTWTm25q6eXpiv50iixAzC8YQgk8Dh2ftCy5dDlvSIFgiqhwOm?=
 =?us-ascii?Q?61hkUkgUwQbZNgO9oDEuMlMJXmy7tWMCfILxKWr69QfnNFma/o0x0TSA/oBv?=
 =?us-ascii?Q?RZq6SwnhonarFp5+CAkWkNYSQ5bRcrRnADVueTp9Wiz3fW4DFMvHhvnLFdl6?=
 =?us-ascii?Q?R+ywUy879c/3YN02UkAh2GXC+IZHxRlT13Z8slv7k0+zMkJV4zf+JVixuZkc?=
 =?us-ascii?Q?uSNmPFuu1Hrb4rGalKc++RNI2Q24Qo6SvUlw57GDOAVwAZxWazgKevQYTych?=
 =?us-ascii?Q?fr3EprRFQv/8w4PDAptxHmoBmKXZ/vob4FNp1KCeSgx2Dm4ZI2IpcbZNW1Wt?=
 =?us-ascii?Q?P74r6SfeQ2UHJkNdYf6ttmY5jL9jFZ4ryVHtDKxaHjLCaRzfIas/X2KBgS+r?=
 =?us-ascii?Q?c3Z8dqELzEKzxRhYHA7Ur8S/0zD4JjxsNN1yL4yPJIWp0uTu7uExDg893AgT?=
 =?us-ascii?Q?oplKSMMJ/imGHiUnsiFGNx7KeOqD+8VEi6KyOGrHw/wnzXP8i+q/FDlgdSdi?=
 =?us-ascii?Q?aLDc/71JV97+o3FTIwCXCJp44NJ8hXPAUShjcg7w2j6HJgjgRnB+XHywHsem?=
 =?us-ascii?Q?4yemlfzqhVjppPHDbF+PiVAne+VKDXFjfGbiwEDgOC8gErocXTuuElGHcuTP?=
 =?us-ascii?Q?DevY9r5EgJsekUSFZvTVvZQgF7T00Iqky0wnf3/TdXrf6cxOZX9+Aej6oOX+?=
 =?us-ascii?Q?uR2cVSqwiBrhZJv/l/s8Dh9cd8zQCXorXcuVfW8e1sofuZi6q11oUWIiV+s2?=
 =?us-ascii?Q?n8cP6tNX83LBKd4th+mQ3HSQhiJ8dz2CnD0tzUINjcsNL+MH3g2OE15aOxf5?=
 =?us-ascii?Q?K3Mk+inAmyBPWlxp96PU6fY9HSFlaYuCnkofcUwx0w=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: df497bb2-f502-422a-9aea-08dbbc63be87
X-MS-Exchange-CrossTenant-AuthSource: MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 18:34:39.2034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0114
X-Mailman-Approved-At: Sun, 24 Sep 2023 01:07:11 +0200
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

rpi uboot will only try to load mmcnr@7e300000.bootdev
which is wlan interface if boot_targets only has `mmc`
Change it to `mmc0 mmc1 mmc2 usb0 pxe dhcp`

Signed-off-by: Date Huang <tjjh89017@hotmail.com>
---
 board/raspberrypi/rpi/rpi.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
index 30228285ed..08a3648838 100644
--- a/board/raspberrypi/rpi/rpi.env
+++ b/board/raspberrypi/rpi/rpi.env
@@ -74,4 +74,4 @@ pxefile_addr_r=0x02500000
 fdt_addr_r=0x02600000
 ramdisk_addr_r=0x02700000
 
-boot_targets=mmc usb pxe dhcp
+boot_targets=mmc0 mmc1 mmc2 usb0 pxe dhcp
-- 
2.34.1

