Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B15CC021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3514380FDD;
	Wed, 19 Feb 2025 14:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="oczD4yjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2432809A4; Wed, 19 Feb 2025 08:23:46 +0100 (CET)
Received: from CY4PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AABBE800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8Qxvqux5njIzLtPW+TRpnjGxsE7lKz9Cm1jv2fYCEzZ9gyVeDibHRjjEnvI4J/fXXMF76HcXt7tiN4EEtEdFugkFv8z/nLU0M3ex9jQMlyWkqU1acyB/ZIjJm8ue8i/g63KHFavCS4V29uXhluwaHTGDlGhJt1W8AxxbU9xnPcUXLD5bc63XzXZTAGnaaapyhNeZKT0JY84pYC04dYRQuQfyCZN0fR+hoZd+4DhSDXIsE8QmsF1M9I6EY6X88DQ1ydG//u5fe0cHkUT1n4IsVDejLWhnehY/3RI3EaeIGiwQfLoMD16yZh6aFMBAmFQSYE5UxtyfF9f6KUBgpQgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5naXcCeiNME9YsWzgMUTbGMlHT8kkiipm/hXztf4qbM=;
 b=maV0iEmWl4yzXeQr3caOFKWW5dDxSodRTLnjgNNJrqfU5KeqF9W5VRUa2MXoGYy72ml0QRTCjqb9+RFmf1caF/k19MgyPtrlLP5MTUZMDzfqsWUx5LJsuwmGHcC98A5mJuwZtHzXHVXWGhqH4J4KX1nwIMMQfMx9jh7EnCVGA7j9PA1u52gzo9QNtEs9HbsjHMUQoAKXOgcaL9x39S6LtSPF7w3tC6IDwLvbjdaa33FG7gh5bj1UhoZy9nu7MQIX+Nrl6FsPxwDLZxW42laRzmKwVeji6YYqDCHUw+C/w1inD2cYG/GcIyGsHCyFroreNWbZLYFiVDPMHiAi06cDEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5naXcCeiNME9YsWzgMUTbGMlHT8kkiipm/hXztf4qbM=;
 b=oczD4yjnmdHM7HBRtSbJcgNg8l9Uc7+syZNuhOEyuecmTG7i6uktTnigYkBCDrIMe5XuVMaN0TEBOithin0R0lVhTGcLyQevFOrX2TMtIkSH3Vev8mXpQJSga6wwAfbx/WE5iJEqZ2PdeajQD2uaXADoGU9BXEZ/0+36moiHLGegENUYISwv95oHl6+Bi4RFv+A6Aj8BKHhGhIdAlQfpcc2A8LApWRXbBmYUfaa0R7Om0DhvySnoM6Fl0zaifzghDYrd+WeQ2GML+0yuysbO7Zr929gYeFncJ+OpBHd4KQLtdlFlL0QZ+0SAf1kud0Ht8gQbBLnte3wqOpRWpyay6g==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by PH0PR03MB6679.namprd03.prod.outlook.com (2603:10b6:510:be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:23:42 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:23:42 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: RE: [PATCH v2 16/26] arm: socfpga: Export board ID as U-Boot
 environment
Thread-Topic: [PATCH v2 16/26] arm: socfpga: Export board ID as U-Boot
 environment
Thread-Index: AQHbgeAkGUuLYQIQMUqje5Q6yX1Qh7NOOqBQ
Date: Wed, 19 Feb 2025 07:23:42 +0000
Message-ID: <SN6PR03MB3583BFCFB8511B80B96BE809A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-17-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-17-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|PH0PR03MB6679:EE_
x-ms-office365-filtering-correlation-id: 1711514f-795c-4216-f5c2-08dd50b65692
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?iW5WdbG5sfwgUftx8Dh+tli0O2JtfFq5KfnUtR1cMmJvCTQBzBOkd85WgLO5?=
 =?us-ascii?Q?gOvqbbGTENMXkU/e9+Jjvh0uX6rsq+i3aLxmkxbF6IYRbhFaCZKGGpCS0k+W?=
 =?us-ascii?Q?221MBtX+k7OLPV5TIzGmQ7PJKrT2DMVOlsSvLRQYApHuCs3lAEf6Xs8/xWI2?=
 =?us-ascii?Q?Thd+E9VVK6zXxMGGawisn88W31z46yHpWy1igd2F4yLwpv7vNLRzXH+12TJr?=
 =?us-ascii?Q?wDxUoHew9CiI6lpWqSO1+JmUhirj3rEv2DVTp3lLlURFyvlhwKrYJsax8A/o?=
 =?us-ascii?Q?J97EgMokLKXBZyh0jYZNFbLkCj4ln59kW1JyBS2JZ00HjuRPdCQG1YIeJr+I?=
 =?us-ascii?Q?71BIIWACL4TyI6iC4FVtV9dhwal0adEwH0BpPkMa+8jGTvOVQS3j/ksnLFYh?=
 =?us-ascii?Q?qIcxhfoG9CqYArBWcFavEqI3MOsqHJL/ksTG2VQ34V672nOweHkb6n9eof7J?=
 =?us-ascii?Q?Id5suz6c6K2/SlTpxXV2NxQ6cdbVWhy6jLfXpx4pT8b9NhAs7gZFJp2iAzeX?=
 =?us-ascii?Q?yR3G3shgogBdK1G9ep06fUhCs8H1Nce4nBRs6szsEOuxGHKFBUdRBTX2ht++?=
 =?us-ascii?Q?bS8oo/ficQUX/Pm9hYsGBkRWcqzE/8undt9DGMt96OYeKg2hiHnNiC4l7Jhj?=
 =?us-ascii?Q?ns4vEqn8X3hXuRnm2DEiLxWGMQLmPKEVXiR2ky6VoiLFCeFKXjAZboy9D7Ge?=
 =?us-ascii?Q?NgwNjtCmXLOxPWJFwCw7gb+hq6mhe2usXRRHTxNmREW6FgU9nIOEdMrnZpVK?=
 =?us-ascii?Q?2YOAIkmh7hLEDf9NcdBbVXybxrpUvbCb9fUJWM9IOhyfLy/TM2L9ycsMHxRu?=
 =?us-ascii?Q?N5iEFOzB+B67sPNKI9W+7VQtliw/f5aGakwndmx/Xn+SguIeXmxxWmqKeYjk?=
 =?us-ascii?Q?O1LrXUtyanlFHF0+Nt53y6HJubQnPPWL3JKo67dupKpDwecKPlr2YXZEPhSi?=
 =?us-ascii?Q?L7eaGh4qBl3ycD2O09SRRC/J26vlyLG8/dFwppNgJUrgk4+QEAY+DKHADwdW?=
 =?us-ascii?Q?9bfp2mcXzy2vm+ZrAfexvboBKCp49BuhIxL5TWU9TNx8yy/ILUvSXJtoHduA?=
 =?us-ascii?Q?KNJDYl/5mVZAeivhExgMA9CQ7xWPeU5JNL++SP9PMn6xMNZ0usHlBJaLHuZV?=
 =?us-ascii?Q?x4ai4S5jzlsKaxMM/egp/p6tiO4z4QQKi71gfDa8b6lzBskhaZZRZoHcb0ip?=
 =?us-ascii?Q?jD8lPTwDeuTmERsqDeReF2k2iCVMDfC/JofLilD4sVa1gCzIcr4I6KqPcH1J?=
 =?us-ascii?Q?fima2+FDWcRfvaaLh9hu5rMbAdyNWpVg6tTmnjB7s6DgNZne5d3GwywpSKIB?=
 =?us-ascii?Q?RVMeNQ1tRoJCBHioAyieK0GCtM+TqHzyVu3bkxttIYYXHI6XAISMqx3Vm/t0?=
 =?us-ascii?Q?w6JYUirXIc+U7F8ZvvPembVfUbgI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vdPQXgAydU+NDHCiQDn+Z64UuDiSNqJJIzdwmn5ihcGIMLu4n43JzDADjQfI?=
 =?us-ascii?Q?Hwauzqgtc6T7BxOHoIIdd9Lw7Sm1MqERPKD+EAKwaX4r0mmtC8VmAYHRdusj?=
 =?us-ascii?Q?Q9itBV+A6/0i2bF4j6TqdepX7XRlSFFT7DCL5u4QC8HeBaAWTMee8spz2flL?=
 =?us-ascii?Q?bQMQv5z6iRM91FJEJeddhvpPiOh/wHvTfswQ2ED8rWk7W1ORypcQQCM5mk4m?=
 =?us-ascii?Q?jWmCnGabQYP+n0ZlqLkIEncHFeqHBvJDG3HiRTVcPrUFJPuPVQ1oCIyQBL4f?=
 =?us-ascii?Q?U3yfZMFE6fHs7ucolc7ghG9GKXOUhzr15q/k8hBcRvAKb1Fi96d24Ap00+6C?=
 =?us-ascii?Q?h+O0CPVI2Pgwrn+CVhOjpcT2WzU/SRNqDj1Iy6drxWPX9fEmJXfLn2zBvHZg?=
 =?us-ascii?Q?LVyOxFsFnr5NN+BeBVHkOSbfIE5Uq1wSOuSmBa8SFC0LXYkbwXsd+AT3effc?=
 =?us-ascii?Q?gJk/hSKW6J3wCLFkgslfyNM3YU/baQ1lMj8u/0O+ecyWKS3uc7NWr2z1BbMF?=
 =?us-ascii?Q?qbaKTH11DSoCUZHTeI7IDOvf4+bEF5TYjT7JMgwjtfzKva5b3UZxsELsCWwz?=
 =?us-ascii?Q?6yFvL5XrwKs8BFZHLIrvrgfi0MSfhPKzAMWByCLOBVnWEWZLxmVGYo4Wp2iQ?=
 =?us-ascii?Q?pBe/daZYXwgLDvrUoG7N+srbZpL6dBfpSHvXFpqkKnrkUQK9EiqFlU78dON+?=
 =?us-ascii?Q?aGpNR0NGpzno3XyDcZFL+4O6s7TQjduV2loKUx4iL/7lNlQbC6pio74EUm50?=
 =?us-ascii?Q?vMXeQvehWKcD3eT2sITrl4228QMvhITCLUPgcXlwZGC7G9gscy1X1ddnJIc0?=
 =?us-ascii?Q?UpAFaWKJOQXWbnDkcqtAJ0ktKyblNiCMGEy3AVyaqA/8br3ozRDxof+yGdox?=
 =?us-ascii?Q?yuw0uPa+Gvc46glsTLzVqdr1ufDVTM3FJpwV4FJW/MXb3XH3TXeecBB1R3+s?=
 =?us-ascii?Q?U5oO84aGoucOZs9GJHp/ppInsaf84hCVQyvIRU4oZQ9k5p3apxsMbQnRBXhc?=
 =?us-ascii?Q?PW0UYMABJ2QqwOihWRluAHdL0F/5+Kat6yhMDtRYgOrlknQ0mszw7SHsKedm?=
 =?us-ascii?Q?wPRZnutaLzXUeS+vyY4K9Q+vGAO7rdbPGs2hEixB5kg1JdSfM39fkpGAFUkD?=
 =?us-ascii?Q?hpbPf0hwz2tHimrIRaemF3eBvhQlgZyS/ZiWO0LV8f8zXQoPj2NT+D0XSQAO?=
 =?us-ascii?Q?4EzBkjU4YdNqsUjjkMT34CZqTfOCon0RdPsv7XidkaciRXNCJX5WyN+STOSy?=
 =?us-ascii?Q?E8D9ezFzWd8iNtU+ZGOygYvZeXmQAQFg/Jok+5gT23bEc1PHOYLSB3tT3rRy?=
 =?us-ascii?Q?9XxGwsIOw4o8SNLWhFVqnVYHFpC6htQKD+4rRCENfpLipH27eJ/JuqZ1t9ai?=
 =?us-ascii?Q?21QK9ZRABxlEsownWMf7G+1QN9dTW4hJ4fYgue8fyUJ2vJ4pMZah2TcZGFne?=
 =?us-ascii?Q?TUcTjrcUtpt4opY3JK4aVmxPuNDRRDeMWUTnL8x42A7duI7bLbMFb1lqL9K/?=
 =?us-ascii?Q?0XrD/bMZMw4VA6CopIASQu0LpTlW2FBtvyM5llUsFWWMd5WRT2OkZl0c2erC?=
 =?us-ascii?Q?urKVF/9/CC10TxrXKYJjoOmBMeRd1Ts9RiYzBV/z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1711514f-795c-4216-f5c2-08dd50b65692
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:23:42.2605 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SnlPWCo1tcpwbrnBemdmJciMH9l00a/8FB+3cMRLwt4Qaa00rxHblXOoyDhXdnEwsyjUs0dHZOk+R7kFJbWazF3GrYp5mbjBcxa0pqFC9K0=
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
a@altera.com>; Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v2 16/26] arm: socfpga: Export board ID as U-Boot environme=
nt

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Board ID is exported as environment variable for use to boot Linux with FIT=
 configuration.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>

---

v1->v2
- use env_set_ulong() instead of env_set()
---
 arch/arm/mach-socfpga/board.c              |  1 +
 arch/arm/mach-socfpga/include/mach/board.h | 11 +++++++++++
 arch/arm/mach-socfpga/misc_soc64.c         |  6 ++++++
 3 files changed, 18 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/include/mach/board.h

diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c =
index 24a15f7903f..d07b3fc3618 100644
--- a/arch/arm/mach-socfpga/board.c
+++ b/arch/arm/mach-socfpga/board.c
@@ -6,6 +6,7 @@
  */
=20
 #include <config.h>
+#include <asm/arch/board.h>
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/misc.h>
diff --git a/arch/arm/mach-socfpga/include/mach/board.h b/arch/arm/mach-soc=
fpga/include/mach/board.h
new file mode 100644
index 00000000000..2c3127e629f
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/board.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>  */
+
+#ifndef BOARD_H_
+#define BOARD_H_
+
+u8 socfpga_get_board_id(void);
+
+#endif /* _BOARD_H_ */
diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-socfpga/mis=
c_soc64.c
index 573a8f79cae..793b8b8e390 100644
--- a/arch/arm/mach-socfpga/misc_soc64.c
+++ b/arch/arm/mach-socfpga/misc_soc64.c
@@ -6,6 +6,7 @@
  */
=20
 #include <altera.h>
+#include <asm/arch/board.h>
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
@@ -57,10 +58,15 @@ int print_cpuinfo(void)  int arch_misc_init(void)  {
 	char qspi_string[13];
+	unsigned long id;
=20
 	sprintf(qspi_string, "<0x%08x>", cm_get_qspi_controller_clk_hz());
 	env_set("qspi_clock", qspi_string);
=20
+	/* Export board_id as environment variable */
+	id =3D socfpga_get_board_id();
+	env_set_ulong("board_id", id);
+
 	return 0;
 }
 #endif
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
