Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53F4C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3885180F91;
	Wed, 19 Feb 2025 14:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="UQ3Jm6D5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7187080C98; Wed, 19 Feb 2025 08:20:38 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170110000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c102::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F70C801DE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Om5ucMoIMZxl324/VUM061maxs8P8h3Op+C/N+bIavmMr+K6vfV3SJV/ieUQUi/WYrIGtQVXZvULODa0DXb3WOb5kT3q23Ech3rMDSSBTtX9vC6v8ZiF0unxa+SA/eJ9OLgIgxTnK5Za2TmpUMkKmRBxuA9gJDJ7LAq73UcXmYKjnemd7Y1sXcr9SDeOv7YqmZaziUkmxAwR+or0D6ECqP862rlj4AXKU3YDwCqq7ly3VbP/rdTzUsPbE8UiadB6GN+fp2jS9rucwZpqw7uiG+MT21t8av7zZfkdmPKQnfCC/4S1H44F7tZxULkx0eJff7lmTO0Va56B21oF9mz9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNgZJ5nS4UfaCrmeW1kdJkfEo8qmZmk0qcheXROhzgw=;
 b=daL1Or5ibevgYHkzf5vAPnFa7PJQZYvGU3aVTfo4Ioeq5YIvFPER8k21H9Qip+7RrUdm5fqIjfyNTgdIO/vQn34r7CStXZ7/rUNc45jGy7IRQMtP1xgSZ//53UCGeUrVLymE1nOUdS+woMDscppddcVMq2Y57pPkdfRqmYtcCGr1DcbTINkENN03WSuCA20cq4ESIuuA2PPMlLi07xkeK1nmAB5yuvUgY+2pcr7kxm9kM7LPHY9hky+lcfKBrM2CeTNa+sYdqzE/+hEKBc5cBl9oBje1xDBNmtkq1Sejiazahzlxzx8/iJ2L+LXfm5vYdDBt37HMryxJdMLtJBY5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNgZJ5nS4UfaCrmeW1kdJkfEo8qmZmk0qcheXROhzgw=;
 b=UQ3Jm6D5LBokvLZ3Ct7+w32pFf4JleaoUdM32mHRdbgS6DMPg0jwE3HnyiJNWLkSfPvu0j70vBDDKoO/73ANnof7stxQanT+IZsyNKGOUeOkPlpu59Gt1sTiXUAGwSvWq38wUGwCETp5uDwHWSZ5vJGi2cv5ujkxkNlTDx5wAebJw7SifXFV94NaVblfH5qWKYUQe4qmbFsSZdXDRw7GX/8dNUMSkTJeoZiAeA5EZbnulYipFMDc3eo4BAlCsasLQDGGaTi8jjSwfiwfQgZkd/OG1bZTYqq5+6ZWdwhmBfLGUz4azxA4rNJNZcvMgPBD/xOdWBkWQ1tiBcvWaDE6hw==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by PH0PR03MB6679.namprd03.prod.outlook.com (2603:10b6:510:be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:20:33 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:20:33 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>, Tien Fong Chee
 <tien.fong.chee@intel.com>
Subject: RE: [PATCH v2 08/26] arm: socfpga: Add handoff data support for
 SoCFPGA Agilex5 device
Thread-Topic: [PATCH v2 08/26] arm: socfpga: Add handoff data support for
 SoCFPGA Agilex5 device
Thread-Index: AQHbgeAYw2BfriIUfU+hd2LB1r5WvLNOOb3g
Date: Wed, 19 Feb 2025 07:20:33 +0000
Message-ID: <SN6PR03MB35833E12B9C3A66EAAE5ED38A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-9-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-9-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|PH0PR03MB6679:EE_
x-ms-office365-filtering-correlation-id: 20d92543-901b-451b-9796-08dd50b5e5ca
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?S3rP2qicL0zi2ywsbBGVh3GPTjLAXFeWMf3C+80CIqPGzuiL0fXD8FvTf+Us?=
 =?us-ascii?Q?o49YY900l6I27514LirBJBmQyrPw0J+kttli0dd1ZIjy/1xHFv4XiZJScj/j?=
 =?us-ascii?Q?G2r9B3XPpqFMMgMGn4FONNCZ4cVHDllDOD2nBUgEhQbXQVYzVjUseSchaQxL?=
 =?us-ascii?Q?cmFxjQiVNNEpgVoWLftDhv7q3F/CnXSawLA1rTXz50BtqBi98FdIxXVBHxn5?=
 =?us-ascii?Q?c9U7fB+CBRcGB/gZ9i+GarAkXY/wfav+rIOdHAFrdy7H4wHYEI6p1DeAQw8q?=
 =?us-ascii?Q?SN3ckqsKpcDpBbgItps1SNWB+tqv7rGX619QKvJYx98zXvzXugkGkU0SJ+P0?=
 =?us-ascii?Q?gvghbmJRUmk8kFcX/IB8iftX6i51Pwqn1ePDgRrF3mjwHy2XjliADMkXR+GZ?=
 =?us-ascii?Q?+FzfobfcFbibUD3Y5yrYV5+Gv5q8JFHoQkSrBXuEG70lNyy4vMcqvv3E0Pej?=
 =?us-ascii?Q?RP4D/QXmCgkxZZ9FTbKM69Oa5Hq9tclrj30oF2R/POuKX/fA65leK36K3TPU?=
 =?us-ascii?Q?UYtQZOXkhLOcuKG3zvtWZfAGhNm78y1BKGka0C1nHZxoCF0ESX5zitSdUraT?=
 =?us-ascii?Q?6snG2+1EvbXF0DOAb3o2K4IDWIxYqI7zKFoFbR9CqsxLedLb42skfuMtsPDg?=
 =?us-ascii?Q?qyMDvm/BqNSyl51AFFUqrLcP7kUvtyZyGK0JdaY9sjTll3YpBZmeLZOPWtym?=
 =?us-ascii?Q?pp5I1XINnmVdLg0OeDM3gV81CQrXx5/n3pRn9KbX/RCm2LrAzGh/bzM8ZXqc?=
 =?us-ascii?Q?Q490QvBnkvJvPq+YUVQSq2VY8iWVHtrgAhn8q6rfNtl6a3B+FAp45w4q5XUC?=
 =?us-ascii?Q?RR3PQci1413FIPmGlaBZWlh6vPQffoghshO6Igno+srOWD6fd+Hn/CHWXxJb?=
 =?us-ascii?Q?TdNhtD3bSJf3n5RcAOT50eLciDZmoHwR+9qAKn+oV+6U+97E39iTlPY+/nBW?=
 =?us-ascii?Q?ZlalBvxoxpYiLt1tAj3FIMHULl5aXp/XUUK3scjnNmCZvuvVHn5HrtWJwBYY?=
 =?us-ascii?Q?p4nqy1NtkqexQKVnkiFGtsejuTy5Cac1AkIs5kkV1u8ZPTYv64Cm9vDESdje?=
 =?us-ascii?Q?vCxcv59WMk9gRi5yhgxopBIbAMUXn9mtAyCNJ5YmF7njQ/vwdnBk2jebCv0n?=
 =?us-ascii?Q?9KRuCWQrd/vC3K3GyVT7D4yHkaWT6+yd/wTaMWccC+WXd6D8vn2Fmry5+Epb?=
 =?us-ascii?Q?MlBnFlZQnnfVqUumuQb1W9QpcoYNcAMbMuQZeb2xCkqnv3tBt+WXuJ2D0PAM?=
 =?us-ascii?Q?BqH7GK71M3Fo3RsFElCgWYwD74CEWSGQWTRYBDLnCIw7P1OkgMBMY2w4f6Jj?=
 =?us-ascii?Q?09QSrTrRWPy2MhvHoIkKalNs7NmWX4MRndLTNp5ZKT86rbEYksg5CgE6mBUS?=
 =?us-ascii?Q?oHNI7gQEHWcaSd9riWyS9zPMIBCl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9OtYCGmXrsxUPQGWl1H2h//o765buBrwxRATtEF6zGctwsxlY2FvBbj8tKpa?=
 =?us-ascii?Q?ajBwrvSLi9WNh2BrmpTtjZPcrwl2xaar+oVfGrEu9PsUZ6kunEvR7Syh1n4o?=
 =?us-ascii?Q?k9f8+WJ9sN2ZRG7ZlK9L1jqBDcpVXqUlxgwZ6/n94SzcgPbmmTkPgrX5L9sn?=
 =?us-ascii?Q?vA+OvJIJHCLL/S6IotxdZV6gEG5LzWbUM2apsYWmTdYOnhbtSgqrojpkTO0c?=
 =?us-ascii?Q?Gvgmzf5/byQkeEuh4w6iD14YA1LPnj1lKOWrVdJ4nDJT5njE9R2HxTNkd6Fx?=
 =?us-ascii?Q?mfFMXIrI/kjBfi4k9fyWag1aDPTUXlBJn/0QBr2lUkzOOdGZrSCFu9ir74U4?=
 =?us-ascii?Q?rgd4i8H6THMbh5aXcp0aRfOxCntp45llibB0sAyVkn42V+IWOp9OhQo3iDJL?=
 =?us-ascii?Q?q2Mko1mVvDgX+dqfEHzSh4+LLYAMWc2SEjVjxYaq4dmEF6OShzEVaCrHk8tC?=
 =?us-ascii?Q?JdXuw08h6ra9xPPqvEcw/DcPObtWi83oMKgAHfAO29lT+ykJsSjyBjOlpPxi?=
 =?us-ascii?Q?onFsQ+MAxU6+vrc5Kq4ewSDCx7rYgfdVUuH71k7NLZ4aQD8BQN9zkJu66ggc?=
 =?us-ascii?Q?Sd41SUiebABZkFh1ibw817shp2L/aZNN9N8pCfh3pmIoKb0E8pigUSYMswtv?=
 =?us-ascii?Q?c5U4I2WSESC9Tf65W1wF8cKA4T3y5+WSkl4q+0+bjJE97jMvqzc0Tn+Unoiy?=
 =?us-ascii?Q?E6W61EuZZ6cO+KCEShVyCN8kj9PeB+G7iRCuMs3AAkEetcSt6ihGjHN8HLm9?=
 =?us-ascii?Q?GCaSzDqbJhbxYwWX+insiGtaaGyRqo0d+rT4RXisJHdbZOsdLSTGqHolng+x?=
 =?us-ascii?Q?n9UcR81PzV+g3SfLNlSGl7sa8mDyyDavgEUfHha96yZLwi2BIwtzJ5QTFXtR?=
 =?us-ascii?Q?3nw1MlMQqfyA3JYH3rITW5kjAkVUM77T2wqASUjixFVjXtJxYZuyhWnB/Hbz?=
 =?us-ascii?Q?zOzWbpq4sWWEC0A3f3kERt4dlMS6iCFD4HY1k6pQnucIMhph6mWUzmzifeCN?=
 =?us-ascii?Q?FaiZqGjDaSbNJCtWUvk5L1vZnUILw8ztajB6u8834QvVZQ/mJsQBBp8LjSoK?=
 =?us-ascii?Q?69Rx5nl48uZeWWoOPdAfrXuB0Noi7uODLyttQg0FRZhGjauXDO1e24AQGgT7?=
 =?us-ascii?Q?X6WBh+rqS4Y9q2hRgAiwGfMAFXMLBJE1b5d0oWHpCINqjGlY10JdISHrYu1S?=
 =?us-ascii?Q?mu2dc7riEK8CKik9KnFDxoleNJQyw6dLojd5jIa7nxLjz6EucmCvPb00E4ST?=
 =?us-ascii?Q?6UwxbGZPEav5YbIjkGAxHwL3p222zQrUmSn5AykRQhYuJz8Ngfy08orR2BEY?=
 =?us-ascii?Q?aCgKR56FonT8fL/cKA/uBeXgiTjYnh/daNTaz3yICkWYhdHunG01o1BR2eMt?=
 =?us-ascii?Q?E92mDcpDuFMRcGJS2DIntG04J+79/IrBElgNnsdV2nvkgovNsJC3kJ0UvmVe?=
 =?us-ascii?Q?gTAloJpygpqdkdGHXCOOfFhWzJ2GDPC+ENq52Dyc/s6HyE7TRVpHnZVpO3hZ?=
 =?us-ascii?Q?UlW5BdEQagL+QF3iLYCz7gvgbme+JzdPc+ldNVsbQtwQfAOHlAfq/XR+h3Pd?=
 =?us-ascii?Q?8dEaezGTfQVs9+71U0pN1wH90jG5L+g5GgAUdoFg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d92543-901b-451b-9796-08dd50b5e5ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:20:33.0611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EHCtb0NO1SAvOI0DeDoSFq5+pxLvtq+FA/zj/eVl9cjZgZ+d+nMXoTPdt7eLZZsxzwkhl/a9L8qnuEc3t7LkGC01ExsdEoJNi2lrod+PEww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6679
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
a@altera.com>; Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2 08/26] arm: socfpga: Add handoff data support for SoCFPG=
A Agilex5 device

From: Tien Fong Chee <tien.fong.chee@intel.com>

Agilex5 supports both HPS handoff data and DDR handoff data.
Existing HPS handoff functions are restructured to support both existing de=
vices and Agilex5 device.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/mach-socfpga/Makefile                     | 1 +
 arch/arm/mach-socfpga/include/mach/handoff_soc64.h | 5 +++--
 arch/arm/mach-socfpga/wrap_handoff_soc64.c         | 9 ++++++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefil=
e index edf2356c411..cd9e9272024 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -63,6 +63,7 @@ obj-y	+=3D mailbox_s10.o
 obj-y	+=3D misc_soc64.o
 obj-y	+=3D mmu-arm64_s10.o
 obj-y	+=3D reset_manager_s10.o
+obj-y	+=3D wrap_handoff_soc64.o
 obj-y	+=3D wrap_pll_config_soc64.o
 endif
=20
diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h b/arch/arm/=
mach-socfpga/include/mach/handoff_soc64.h
index d839f288411..763b077d8c1 100644
--- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
  * Copyright (C) 2016-2024 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
=20
@@ -17,9 +18,9 @@
 #define SOC64_HANDOFF_MAGIC_FPGA	0x46504741
 #define SOC64_HANDOFF_MAGIC_DELAY	0x444C4159
 #define SOC64_HANDOFF_MAGIC_CLOCK	0x434C4B53
+#define SOC64_HANDOFF_MAGIC_SDRAM	0x5344524d
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
 #define SOC64_HANDOFF_MAGIC_PERI	0x50455249
-#define SOC64_HANDOFF_MAGIC_SDRAM	0x5344524d
 #else
 #define SOC64_HANDOFF_MAGIC_MISC	0x4D495343
 #endif
@@ -68,7 +69,7 @@
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
 #define SOC64_HANDOFF_PERI		(SOC64_HANDOFF_BASE + 0x620)
 #define SOC64_HANDOFF_SDRAM		(SOC64_HANDOFF_BASE + 0x634)
-#define SOC64_HANDOFF_SDRAM_LEN		1
+#define SOC64_HANDOFF_SDRAM_LEN		5
 #endif
=20
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
diff --git a/arch/arm/mach-socfpga/wrap_handoff_soc64.c b/arch/arm/mach-soc=
fpga/wrap_handoff_soc64.c
index 92051d19b73..7105cdc4905 100644
--- a/arch/arm/mach-socfpga/wrap_handoff_soc64.c
+++ b/arch/arm/mach-socfpga/wrap_handoff_soc64.c
@@ -1,15 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2020-2021 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
=20
+#include <errno.h>
 #include <asm/arch/handoff_soc64.h>
 #include <asm/io.h>
-#include <errno.h>
 #include "log.h"
=20
 #ifndef __ASSEMBLY__
+#include <asm/types.h>
 enum endianness {
 	LITTLE_ENDIAN =3D 0,
 	BIG_ENDIAN,
@@ -26,7 +28,12 @@ static enum endianness check_endianness(u32 handoff)
 	case SOC64_HANDOFF_MAGIC_FPGA:
 	case SOC64_HANDOFF_MAGIC_DELAY:
 	case SOC64_HANDOFF_MAGIC_CLOCK:
+	case SOC64_HANDOFF_MAGIC_SDRAM:
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+	case SOC64_HANDOFF_MAGIC_PERI:
+#else
 	case SOC64_HANDOFF_MAGIC_MISC:
+#endif
 		return BIG_ENDIAN;
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
 	case SOC64_HANDOFF_DDR_UMCTL2_MAGIC:
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
