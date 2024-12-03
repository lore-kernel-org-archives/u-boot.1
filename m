Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC706E6C5F5
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 03:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C2AB8967E;
	Tue,  3 Dec 2024 04:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D6C68961F; Tue,  3 Dec 2024 04:06:09 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2071a.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::71a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE720895F2
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 04:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEvNZJyn6j8O1SVhZp9sEcQlyqGC7qd4e+zFsD3bYto2qlOZVNk8tSw5p27Ms4ASzFDSIRkEbMUL2HyQWhOnIrb/JrgAvbRNqJ5w1tuxScJB4XXrl/vPB2O6/lCx49ygPnJZLOkt3Ca+GGlyNMQqlThLZhis/H55e29dCPnd53TQzLMQi3d60pAe7YsXzfCIwHHe08u0H004dabSSY7pSBo51GrZo6IVH/1xmKt9+l5T31aXUDCFtGocqrWXDZvNgCBeDmW1dGSoRGyE2GEoCh/PRDHLqiu8qeY2t1rzuJVtL0J5Sj7Q4ydg9g+8uX+YTfGXZDDvEmCG4r7Ra3kvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpPejiiLjHxv9Rcx0mbLmTc7fjIK3AHzaReEZeJzXiY=;
 b=Mxv5jzN/Q5JJYdSo5v7gt1Jj/NBbKkxpOC+DX+vnxZPC0z9IRopXJif13c2YiQO16hDMF9hwToNfTE/BD5rtAQwFE48J1eEsv4BAchKyVSFYZ0iELdLuzIck+J7W8w6h4cTxYSpITHLJRPaFAeBoRP4fnz0ZPWDcH8j3lvVucVRk3BkSJqhKsgk3NkC0SjoH0jm5HMmOQryGxEAEnVWaS1K8t5urXtvQRtNJyHxNv7pDTCWMXKtaDv0oVGSwXZJZg5/wkiXE3DmYgUZs/5eeELXTnZSfyxk9uF3GezhAHl3m4fFk2EeSxFirAMdEkIFjaSdiyqfInb7NchyaOtTvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1180.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Tue, 3 Dec
 2024 03:06:30 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 03:06:30 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v7 11/12] board: starfive: spl: Support multiple DTBs for
 JH7110 based boards
Date: Tue,  3 Dec 2024 11:04:29 +0800
Message-ID: <20241203030430.26089-12-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241203030430.26089-1-hal.feng@starfivetech.com>
References: <20241203030430.26089-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::8) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1180:EE_
X-MS-Office365-Filtering-Correlation-Id: 992a7a91-04ff-449e-17c3-08dd13477be7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|41320700013|921020|38350700014;
X-Microsoft-Antispam-Message-Info: 9thWUnYBehHTgZwraMCg0TzWY2PJQlIl2UCO0zp/q9EY+Pi9rbt3MYvf6edw7JqnuH3OdmkRsjFYgm/MKYrP+eWDUvGlx/Lc4Dk7gCp4HzGP17sYsSq+NM3iOkw5kjLsy3M0Wn6AkVIQFFIX68Ez7+o+L8+Y59hSPwLLatqdNOpqMTHHomKqwTUPs7By6ecMsGIUIPEbEzielq0nhn70Jg5iwRi8QurNu6uyY6wIdoGZs3gNES2NKMJ/FjX4j+8/l7eu/smTExCVyg+nHvz6NHsvV0hMgUin4tN7qf1LuzRYs0/LCZ1rUeaP37bqMVxJZ9PIWJ7blGsclquLfbZITdd1NIXc6+hUw5LGbEpAf0e2x/ybcH1piEf0oWP0W/KQH1s0Q0+9KVskGVAzgriAPiayi8t3O5OuCBfmKJO65rZp0+FurVoJpcdMfYJae0tdzLC7/5IBlUiBiKAvG9tCKlCs+mIJepZqNzCqqjXCY84N/kZfi/axuf+7Fxs2nFqjpDFuFGlnBOow8Q9CDFMvVfLvZllyCZ25AwFuPgfXE+K2J1PxNJJXBXbui2eHbKMusgR5IT6ELURxI1k+dYvUhJ59wqe//r0CGsA+3Ui1FaW5cWFz7yhsRj3WR2C/tacVWTe29yp5OOKHGR+rojkAZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(41320700013)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3KevpXBIKC31Uwu6TXeKH58NH2dBBLGqlstRNtbf8hBPOc9mFpAkeL7i0C+N?=
 =?us-ascii?Q?Sn9zSyNRPQIfWEa7hEZbHBBnRByVgPRTwK6kVCaOOGy0S28YUtd0iomDjmoI?=
 =?us-ascii?Q?VmCF/US098LwR8zkN0RUBpWZGD6hdg05B38xF88tpSsdJY8xT3iRfOAyVz/g?=
 =?us-ascii?Q?zmM94CKdLASk06tqXU2sVIemi79hbznJy2pP3RSwcGhBbhSciNonz3dnHxws?=
 =?us-ascii?Q?DrG0uRcNG4DUE/YcxpyWWtdnxiXijaI6fgIWkrosIDhmxcHm6di/tB4zWHnM?=
 =?us-ascii?Q?R68EA3ouk+eq/uHi02OHY+qyGcRU+51c/vUtA+yy/eCCFLzRJwWATBc4VEEI?=
 =?us-ascii?Q?vsV2nFebrEDFjq/Lha7heOXF8+2+ph5ObYBlocm09cqVGwkmeDwB/B0vdCev?=
 =?us-ascii?Q?0mInDC63aulR+Jx8pIfNiV11ZgFgtyUqlyXAcbjFtOV8g0roTXBnW7bDbtf1?=
 =?us-ascii?Q?K+Texf4nqV5cyhOGFDYX2WQgxwxbhKNV1iGKMCqZbFVMyVqLbOgr3E62v5cS?=
 =?us-ascii?Q?VGiw+lNpi/uWyrTCnfyQL21edqlWrZv5mm6a3Sk96L4L8Evctnjdhiae38WN?=
 =?us-ascii?Q?7RFQD8sjD8IaCJKftljyx3YzYHxRCUDhZIojzhoe8m23welu7mh+HcOghtwP?=
 =?us-ascii?Q?APX1dEOE+nPwahDN2NYBahJvmXxYOlA6b4pGzTqDHCu1XP68Y3AAIv0tTHtH?=
 =?us-ascii?Q?G9Q+/YbUfcTJOWptHzKumMgP+era6VAtU6QissNqAUtPXZsFCgqibZUT7Lp8?=
 =?us-ascii?Q?dCD6rePWxmjFMRULSbh9B5sWsdfG1jyk6HO4lc2ksDl0TgsptVWqh/n3zgom?=
 =?us-ascii?Q?+d4ETHOLCc1JsrjXalmFsy/gU1ErCx6T7tJ0+LW/D+sNo5yZFniP1A+BAd/B?=
 =?us-ascii?Q?98b3sR5QjaJiTgoIhG7dCAqIfAsHRWZG+A4IzpLibLGUIPx2hnIsmhKHFaRc?=
 =?us-ascii?Q?jeYNClL4jiwDSBFdphhgM1Vb3EIu7C7MXd2EkpwqkVkRl8P3awpf2Eis7yoQ?=
 =?us-ascii?Q?BVnlKOPeqmFTyJisuyHHa4xRdE2hEhEkb6x8QY+/SmH20DDW3xoo6e++cau2?=
 =?us-ascii?Q?J+vaFptPeCCKAxYg7z38wNZfOZW9kWI00BQZp3Sb7oHPIaLcZ5kt2r4ATYEq?=
 =?us-ascii?Q?LEJ/cORvxf1hppS3CGPzAbuyjIajZpkKIkcSa2cfcZjBiNWmAw95/UhftRMZ?=
 =?us-ascii?Q?0DU0d9t5pACMkrBvwH0qU0Hi9ukCbYBNAH1zJzYDUnRqqj9Um7tnOADT7tDs?=
 =?us-ascii?Q?C9u6Oo2sd1lVCY5NaOh5GyiM0faSbH4MPwTmM/Q/DjuZyj2tLPlzWGb4mxLA?=
 =?us-ascii?Q?ZYl0tjhEkLpuWCycip7sn0LVKRMGjeYt4e68hJYksReIsVzxnth19rzm3ZdJ?=
 =?us-ascii?Q?lLEG6mb8DYBccO8V2/1uRaubhAQwKV7oPoBWuiL4f7euq+n5kjjZKM6QBCK1?=
 =?us-ascii?Q?YovDQLOUevHgJGjFJHUCwJRt9jtYXn8pdWAwimmSHkRVePc1+arIUrjKEG8U?=
 =?us-ascii?Q?Kq5AXswzZ7Eh0Y7fcL+19ZPGUG/Jd8qHvwjAVvMJuvHQ2ez7wtoRUSPp51gK?=
 =?us-ascii?Q?8vU3bq46RYX5srfLU201qigK5oaLEdt/DWG848WA/fmWhEIYmYn5Fmb1Hoc2?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992a7a91-04ff-449e-17c3-08dd13477be7
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 03:06:29.9802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7k5YvhD4JqfBr770B4L+y+ywMmmbDtA1QzSJ/B3CH9wEYL7C4Kn/SZyXDNCR6IzVhc02O4ZwSTKQviifCMIqWWcr/jPEBmlQjs8XaQOT1r4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1180
X-Mailman-Approved-At: Tue, 03 Dec 2024 04:11:50 +0100
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

Get product ID and the other information from EEPROM, use them to select
the correct DTB.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 33 ++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index cf7f39d5c5..22afd76c6b 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -113,7 +113,36 @@ void board_init_f(ulong dummy)
 #if CONFIG_IS_ENABLED(LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
-	/* boot using first FIT config */
-	return 0;
+	const char *product_id;
+	u8 version;
+
+	product_id = get_product_id_from_eeprom();
+
+	if (!strncmp(product_id, "VF7110", 6)) {
+		version = get_pcb_revision_from_eeprom();
+		if ((version == 'b' || version == 'B') &&
+		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))
+			return 0;
+
+		if ((version == 'a' || version == 'A') &&
+		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.2a"))
+			return 0;
+	} else if (!strncmp(product_id, "MARS", 4) &&
+		   !strcmp(name, "jh7110-milkv-mars")) {
+		return 0;
+	} else if (!strncmp(product_id, "MARC", 4)) {
+		if (!get_mmc_size_from_eeprom()) {
+			if (!strcmp(name, "jh7110-milkv-mars-cm-lite"))
+				return 0;
+		} else {
+			if (!strcmp(name, "jh7110-milkv-mars-cm"))
+				return 0;
+		}
+	} else if (!strncmp(product_id, "STAR64", 6) &&
+		   !strcmp(name, "jh7110-pine64-star64")) {
+		return 0;
+	}
+
+	return -EINVAL;
 }
 #endif
-- 
2.43.2

