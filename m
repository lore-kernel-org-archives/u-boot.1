Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0215C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE61680FED;
	Wed, 19 Feb 2025 14:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NuJQlJ5L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A0B809A4; Wed, 19 Feb 2025 08:24:16 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98BBB800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+bwePvCSX6ONibOvoJHapcRUOr+JKCdpjO+YokTzXU4PxygidlgYsVARCuR5H+yv6Zewu3JdrHDFWEV5cjrOhOLoFAAay33qA9icA+AS3bvvEifyVVoo1o4jy1vNEkjW4UmhPvcPsRaN884kS0YEpzPkUPrfiOUM5egcConuBevPw+maj1pbnRE9ZSs4YaWyyUhsJwKdY0cJ2f/JSAzpI7xSmQxYwHJ/L4aBrcveZ/NW0AZdTLF9eXLN2eOVuB7Usr64uj8BDHu6pzPsSqfJcZB79RkodpijWd7eQCkIYZ2qKFdP6EsQVFXuq0o8Xr0lpyDUJk6n5I9puNMBsEM5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKCL5e1pvmagFUsLxeG8zv7le1ijlordyjZs6+hgRV0=;
 b=AFCporPuAaT+u/SlDr8CsQc+bu8lIcQz7bABq9Rcxo4+v9BVqFFebVPS3xBOcLiZ467h24ZFZYzwQfrCBGjpIh5RzX+hd3Quevm6E8cI3p4XU6TyUwkj1aKz4D/rcolS8KIQWqEbOM0JFCJJo2gpPWL3+p9d+jmYLSJ+BUDottM48853KsILdS4Gv88fiTB8M12e7U5164MBbbU+eEqyQp7kWf5WSsZ7DbXpp9mXKjomI0g5wnPaj/2TaJ2mqeh3MYoLtXKsX79x+EVaJRLEBZM+pJyzhwsyALxJUebT7P7CTw9Mf0mSx5XQCxI7PrX0OXi0chkKgd0ssE5bmvHiSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKCL5e1pvmagFUsLxeG8zv7le1ijlordyjZs6+hgRV0=;
 b=NuJQlJ5LZNg1MwHviVEEoQAQmuc0yExFhI0sAFmePw9XbrnNwHNMlcPIlUH4uqawaxw49ggwEVN0ji6JVqtzqB6RVBwZYrWcK7l8+p/KgeZMk3VtzWSRmS1y+ieh8FEJaY5wzOnc9pPWBCO117DSiAJ8KQvTuNHZCB9sR30hw0WE6AOSguni+wQRruoT8i7gyTuCtWHHXhXydzish8gDbO6lmD53vE6eBml0+usWd89fN9b9rEpvmSQzQQVj1xefmUXIyPOQri02DTuhuNmdLTNHo4v4F0qw4ARDv2V0OW15RFWfBhdb962mPVrM2DGrscZPfLIvE5S3fEIozvk1xg==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by SA3PR03MB7253.namprd03.prod.outlook.com (2603:10b6:806:2fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:24:10 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:24:10 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>, "Rao, Mahesh" <mahesh.rao@altera.com>
Subject: RE: [PATCH v2 18/26] arm: socfpga: smc: Add memory coherency support
 to mailbox command
Thread-Topic: [PATCH v2 18/26] arm: socfpga: smc: Add memory coherency support
 to mailbox command
Thread-Index: AQHbgeAo3//aKvRvjkO1AlbBWQFvybNOOsLA
Date: Wed, 19 Feb 2025 07:24:10 +0000
Message-ID: <SN6PR03MB35838D28883A8BFA551481FCA7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-19-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-19-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|SA3PR03MB7253:EE_
x-ms-office365-filtering-correlation-id: 7e5a02c1-29d3-4cfb-cfc5-08dd50b66777
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?n0VSDu7W33emnzwm/CTfIU0YGQbcZ6SyK3wZde76qHe7lTBsRIL/NRfHO9oe?=
 =?us-ascii?Q?UuzLMuA1iz9FSDCsbC8QPp2i8EwnMVyjDmzZlWd3aEmNfCi+qdqixBO2W4x6?=
 =?us-ascii?Q?NRZwqVA5JRi4hmYYOckSYPyJ6Yrn4vI2FowfxvH1DN8izGB2xyv9hNHbLnvk?=
 =?us-ascii?Q?bVAYHpFC80gBIVB43XEVwSwJN855hVvkQbHlZZtMUNxMdHhHcHF+6ilf6yNf?=
 =?us-ascii?Q?xxPmQoL42abx0nyNJvs2T4JRL/XT752YjPkaayouotTrdvqEoHKfVjlFNTzr?=
 =?us-ascii?Q?3in4AfHpWybBd/LaW9ZmcBFsaXvM2o62Lals/w/Q5lj1Abt8pNnINP8vICgX?=
 =?us-ascii?Q?BXNdWPTGuoJoaymhH3CtyZ2OOf3Ekx2ci7ibYEp3kyV751pELFTNTGkSmsBZ?=
 =?us-ascii?Q?d3NfJEcCYLupBYxA3uWnFT1RnvvJcYRgnLpH4r2P5zoByNZOI3vfV2rgvw7u?=
 =?us-ascii?Q?I10Sj6WN3AfimTp8eL/MJorj7iz4vANAWRBqk/0TWfQ4p8HQ37+FeC7Qhx34?=
 =?us-ascii?Q?Y+uG2Rnq3fZZBRgvTIpk+f2wzRA04OckjNUAvVa41H9lUQkAeKIn7f4c1CCi?=
 =?us-ascii?Q?4w/143XROuBJ8Txv0Z5hooROdzNGmGqR8i0OREZXSXFB8A4vjUA7P2OCSzdo?=
 =?us-ascii?Q?KhiAyqSbbI+mVROA5uMNY/Mj4DFYUzKUW7PeBI2pVOfSQwVsmpo36toHCBiy?=
 =?us-ascii?Q?rv6fJXlUUTRPItmicdNcS94IVPaCVKWUwi720boMhxGkFuwmwYF+JxRRTbd7?=
 =?us-ascii?Q?t27rkR1BDmXcAhPFMOERII+nb214fKPwJLUe+60ohJbQSte3uLQZwZ06FjLy?=
 =?us-ascii?Q?szsv4J99TB+z+vxaf0uRT8qD0s1o5e10aMs/Z+3n5GD454QGiHL3fHVjH7Q7?=
 =?us-ascii?Q?PXY+GTiK1vHR1xT4R2qBypTPCVhAMPDNIaIsXpdK5sVK8/2zec0Cyv/STwby?=
 =?us-ascii?Q?mmRPmNfVtM8yRKWx9UlHe+LRKFHcdAsRcPr0uCzfn5MPsOIJYlVaMOdjLgWk?=
 =?us-ascii?Q?u9a+WObOGr12ciNpnBD4QriGIHfI6uuKIdq1Ggal9XTOSrdu1PIr72aYj5gd?=
 =?us-ascii?Q?uixTJ9TZ8uLcy7sOKx51+JMujKRck2WUKV0VVNbAyQQt2Nl6zNFdIfWYC9w7?=
 =?us-ascii?Q?gojR+hpnV9KmGm90vqH4KVBpVDOStiyv/PSD2VJ3OffKWPEujF9pdIkhPVjl?=
 =?us-ascii?Q?UCgIIivWy7YyUp5eGuFX4AEMdXPN7AMKTPW8Dgkz44UEHmd6u90U51upPUka?=
 =?us-ascii?Q?OPoFWLb8by4jps8jX559B7mFDBDCVdZwReGQOox0b3kqVpDaiFzpQT1OU3+Q?=
 =?us-ascii?Q?+x4J+71Fgr0T9UYsScYRpuLn3t5n+qNnvWTQJho+5mQuGY47gSYNeJhRGrzN?=
 =?us-ascii?Q?530QgTLCvfdUZCRYf1VbVby7UuWl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WD0RoxHbIRbhFtdYRqiA5yg7dC3mSb/fXTOqmy+WrGtVmoHbCi5AEy8Ghloz?=
 =?us-ascii?Q?2srSmtwlRnydTD8bSqYgm7C21Hk9kn1PQATK4OJ3O+InKf5gwtuNx/uTRqwW?=
 =?us-ascii?Q?WbQpAjKdu9IZF0iJIb1wMxkuOxibJV0UEeu+P3/GdNIq4feBRnquo7x7u7No?=
 =?us-ascii?Q?fnMpxN8Q7jMo2vQmTUyS497ta/KegLPK4t6874ifA3Hp85Uy2dtlolyOXYXn?=
 =?us-ascii?Q?JFyG1T6rhQPGNbhsd6XtorP2PPzaowgqEmp+J/zCJarjKyiToSrKOxRy3Qyh?=
 =?us-ascii?Q?Dz8yioDFUQJNAlIFwF7cCMWOc4lAm0ihFolbr9I4hPbGNAanyUKc5sTjdsSj?=
 =?us-ascii?Q?j2Z5ZDiXhQ/nZQpr1OJu/gpFo3TYneEL8sq2TfhUkPxWsqt4OBT1ylXN8daU?=
 =?us-ascii?Q?J5op7R3jyp+nbMXUxBzuo1hMN7gBqCBY1ckg3ZXkmW2OrQKuu4eJ7PEhjXDT?=
 =?us-ascii?Q?Tmou6OGnfZBxxxI+v8LAFdWbyUeToe9SL9n4ElKqVgH6hjs/fCyzkVyUnkxy?=
 =?us-ascii?Q?Guzz4Vge9dWsP7F4f7IJMPygPcF4eF8um9H48ZU1hrQxLxnEnijrXMSPbWji?=
 =?us-ascii?Q?XLlGrKD2fQ7eg8Wr/9WRkeZNLkH9zQO1A71wp5WnzgCUFmrxo+1MBUBWVb+s?=
 =?us-ascii?Q?cCCYbj5g3SA9mWGKyuraDRf/j1Dbm8T2nxU1R/NMI+yBb3UajTlghKdEG/6K?=
 =?us-ascii?Q?OP6bF6buMv29qMa1b9QgXDGC25C8sicAy4XnTeZttQ0tiqYqLRqtn1TjuJvX?=
 =?us-ascii?Q?iqJpiOzsnNhCsWRbzi/Tu+CBgrX8tx+TNcde0Z2x58JclldKhxgLAlFMCLgY?=
 =?us-ascii?Q?sC2j/SzadD2cDnS8yQbkwlrWP9x1rJcvhg3lrQ8Y1yQ/bW+4wM/tHhIX72Dk?=
 =?us-ascii?Q?4R9XMRCQzOTBxfVvsx0fsxFz7jz1hLr8PSkOjxPpm/NM6ybWexpY7AdHfSn9?=
 =?us-ascii?Q?fuVq4IeMYUubdmLNg2OJaAXTSr5PXEgLDYgmVRTlcx58hzDrHnz2fiEq0a4C?=
 =?us-ascii?Q?qemepVsFJToHlsNy1GZLCXBO/BWQFPphcHettzxhsjkIL0Ype/vMTOBUQTmB?=
 =?us-ascii?Q?Plfk0iC+98FemGBfPUPiwOJUH4WOxV9WPyad9ga/lIIN8rh8Zo22HksU3cQG?=
 =?us-ascii?Q?ehie+GaSVB+xvBXwQehgS8w8twXcF7OgCk6EOXiSe+/wS1MR6Voj5PAjfPHX?=
 =?us-ascii?Q?Pgg6DfeWXnPDMO4O7QtcXcOiq950s7zrZbpLrB5W4AB0VOb5SlUGJ1LMGBzK?=
 =?us-ascii?Q?mR3KyOJXK7elGXTCg5PyAZB1GjqDvZIE+/ijTJiyJoG96Pdi2SlPG3sFsU0k?=
 =?us-ascii?Q?YWHv10iPj0gPuFMw+8sH1CGicO2hscijqd7cV/mi10GZgRMQji27DI0LVX+F?=
 =?us-ascii?Q?/Xx0srNhFxbMOhc75sbzOJZwADw8wHaJhKLktJZCBHG5xiy8raSjC62Px54e?=
 =?us-ascii?Q?rs5p0O5FhS9e0hfF+jiK22mDd/4+zK5BaMOPPfHywZTgUkZ0JRqwdCTtiOC8?=
 =?us-ascii?Q?Cscpiji4X1crcNHpSvB+8kUpCQmAm8WKm6e6au3SgzNxmTP2NR4aTMzBTV20?=
 =?us-ascii?Q?eFML9YPqLw686dKvHy1kwQ3LTYFUx9OrgoH5R6fZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5a02c1-29d3-4cfb-cfc5-08dd50b66777
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:24:10.6386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NboetKcsAKS6wE/yfTjBMbzq3ArVodMQ+aGL8nVAx7/4MYikBKqPxkKm1nLuJbc4GLwzmkwBdsuvYgpQlhJkE8u7lSjyjL1/WsO65cOTCt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7253
X-Mailman-Approved-At: Wed, 19 Feb 2025 14:04:13 +0100
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



-----Original Message-----
From: alif.zakuan.yuslaimi@intel.com <alif.zakuan.yuslaimi@intel.com>=20
Sent: Tuesday, February 18, 2025 4:35 PM
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@g=
mail.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Yuslaimi, Alif Zaku=
an <alif.zakuan.yuslaimi@altera.com>; Meng, Tingting <tingting.meng@altera.=
com>; Ng, Boon Khai <boon.khai.ng@altera.com>; Hea, Kok Kiang <kok.kiang.he=
a@altera.com>; Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>; Rao, =
Mahesh <mahesh.rao@altera.com>
Subject: [PATCH v2 18/26] arm: socfpga: smc: Add memory coherency support t=
o mailbox command

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

As cache is enabled in U-Boot and disabled in ATF(BL31). We need to perform=
 cache flush of buffers that are shared between U-Boot and ATF using secure=
 monitor calls.

Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

---

v1->v2
- cast as uintptr_t instead of u64
---
 arch/arm/mach-socfpga/smc_api.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/smc_api.c b/arch/arm/mach-socfpga/smc_ap=
i.c index ebaa0b8fa17..b212a94b321 100644
--- a/arch/arm/mach-socfpga/smc_api.c
+++ b/arch/arm/mach-socfpga/smc_api.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2020 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
=20
+#include <cpu_func.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <linux/errno.h>
@@ -40,10 +42,16 @@ int smc_send_mailbox(u32 cmd, u32 len, u32 *arg, u8 urg=
ent, u32 *resp_buf_len,
 	args[2] =3D len;
 	args[3] =3D urgent;
 	args[4] =3D (u64)resp_buf;
-	if (resp_buf_len)
+
+	if (arg && len > 0)
+		flush_dcache_range((uintptr_t)arg, (uintptr_t)arg + len);
+
+	if (resp_buf && resp_buf_len && *resp_buf_len > 0) {
 		args[5] =3D *resp_buf_len;
-	else
+		flush_dcache_range((uintptr_t)resp_buf, (uintptr_t)resp_buf + *resp_buf_=
len);
+	} else {
 		args[5] =3D 0;
+	}
=20
 	ret =3D invoke_smc(INTEL_SIP_SMC_MBOX_SEND_CMD, args, ARRAY_SIZE(args),
 			 resp, ARRAY_SIZE(resp));
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
