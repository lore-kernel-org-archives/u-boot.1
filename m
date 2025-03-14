Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D30C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 05:37:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 110FD81CA4;
	Fri, 14 Mar 2025 06:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="u1CZgbBc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CE85808A2; Fri, 14 Mar 2025 05:10:03 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 090E380F4C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 05:10:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tiMcDH4J5RzdB2CRfxyfHT6WBMWpTphzpxuMpxVTNsqu8hOKHTIoY9jh2PNGIli8zZdTVav1L0ImDNVGFOaTbRLRI3y45vfCLaDhjpp3QLkbCBU7pUtxU0tTzr0ijdf69aNkpi8nbfzgMMaQazO47Z6W+cwXo38ogDDWtvWcOWkl9YfbrdGMhQcwyfX4TjOCVtPTpy8fa7afypPZ3dxbqKazW8iVkVzb5hvA9zG2nLL4MEIN29oVyaYXPSSt+3HJQT3aPfI+RJPVOqukq5fwchf4o5luZDXRaGCATlCEQhAOyK6m0fqOo61d+pPFg/TRCsy+jIh85dNDq/0wXHlJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtoaW3jVz/93IG/TnFM/gFl4Jb1iYJpnJr25cH5jPfQ=;
 b=VISJJ6ATdxIuQVTVN96myINxbs6fcPHf2updWgXvlchM2GoZy9dzJaiAVPNLzT7GcXlvfudpN8+mQUZB9H1ZJ1J0boeH4tgFgSf4l9538zQnrYzcL0aHn94dcMT1YhdIz8BtrD4sJF8bZ5c7b/TjM/9A4N1D+dEvRKXLXDGfk9qEycH0FCexaiSSD5j0ltgbyw/crDIG94lRkrNJtRydiCeunPBZEnUnctww7MYYFf38fxSykXIcCOGU46FcjYQbDrog6vMbcImDQi3BUEskFkvAzJgp/5K5nIRSCxvRRNCc4jM77MgdecS55L+hU6oqGm88LiwqXm5SE0x6mYAyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtoaW3jVz/93IG/TnFM/gFl4Jb1iYJpnJr25cH5jPfQ=;
 b=u1CZgbBcn6g0J86MkuJqSLVs4YrpfgsJ1khDCJGSnNhIytlcScVuR+lankZ3pzkiQiM7hehwKZy54FONFu2ixXy5Z1AW5NlP4NFd9b7UNHbAPnaJoT7HRCPWGymo3K1x3f9MQo41IBIYSI1wheyVNgz7exJzS8G/t/YD64rbcrDBF2Xm0gFjilfZiXXGRHh6C4o/6OGoyot061LHIsTLkCpguZN8VeKIk7TXOpCxAS4df4C8T4vGEwUQrNoRWW10rbcmXA5KyirDxcuXQazuhZMWc3uGKXI+LtSXRNJqLcpap1LsAwiK4k+D1s6G0GmBxWPriLmpb2hgr3IqN4kWrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB4387.namprd03.prod.outlook.com (2603:10b6:408:3b::30)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 04:09:59 +0000
Received: from BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874]) by BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 04:09:59 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v2 05/13] drivers: i3c: Enabled Kconfig and Makefile for DWI3C
Date: Fri, 14 Mar 2025 12:08:54 +0800
Message-Id: <20250314040902.43621-6-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250314040902.43621-1-dinesh.maniyam@altera.com>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To BN7PR03MB4387.namprd03.prod.outlook.com
 (2603:10b6:408:3b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB4387:EE_|SJ0PR03MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: d9016c6e-ffc3-470c-1765-08dd62ae15db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q3NtO5K9c5uO37ZX/GGA4sMY+i7CPUhKJhCMISLBvE26nUryDi/YzBwCra/p?=
 =?us-ascii?Q?+xM3mHN/XD5O/yIYSW5AxtEICRynshtVDcMb/u4cB+b5mFTcHVRnW485N98M?=
 =?us-ascii?Q?HIqmKCaBq/T8Y5/9SY4pn43XCG2rqVzKyQ9uXzkevNOsopDY3uFU9+hPQBcf?=
 =?us-ascii?Q?5lngW0WU8jB+2azdl1qmENwCyTriCPAw//WFjkpw8WBousVIJD7iWrPSZ2zP?=
 =?us-ascii?Q?kOxSzAvW2oavfi1S1lCw65RbsRQqorFQX15ut0F9WgnGwXAVyj9ZewBys+0I?=
 =?us-ascii?Q?bC7O8c5M8Yb5nvD6CaCYbNiFiveUQcMJ2GZptHDxQGEOQYWGnW6WeTD9r8CW?=
 =?us-ascii?Q?Gdy3+3f1gXE36UnrEnMVn9SoJiMGVN8TDXLihoxOsN1+q0qDeVHWxwnXQ295?=
 =?us-ascii?Q?xK0DlI4PLCg+vEKe15JZr62QGvkhhuz7Xj/TqvXLxNbBGKiYXtM4g2ji0CqX?=
 =?us-ascii?Q?fut8N/pczbEQg8N4HYGPvax/B3d3do+HoNAfRCa5K8UyfmPqsCIX0F/fNO+q?=
 =?us-ascii?Q?j9QB94+ptd39L7v51V62H5ax1N6A2XYv4jyumsaplRzo5ggDwnotC9u2rLij?=
 =?us-ascii?Q?xIj78AQ5bGmXIbmfEQ3UYPfyHhNcUMP86r+asfbqoTllcO9snjdshX6MdoHp?=
 =?us-ascii?Q?WN9DCyHMD1jE861kkLP6dwwDlSfy6DX6BjazVKDwu75OX2yx5BfkjJ55KGcm?=
 =?us-ascii?Q?OvpitCQk1LShIPmWRCuturpdo5rpHmi+eUioCg+HO9FifSfSzy3G3HN2eNWp?=
 =?us-ascii?Q?MYzXhDpBrkjTImN2NvvjFNH29CtROrDyefP92pnrcKDzqLmTdwvcO1NIQNIQ?=
 =?us-ascii?Q?HxC1dP4WI32RC4yqNSJQYg08q+23uA0jllSGId8FFo6e39WkePnySmQhxr6d?=
 =?us-ascii?Q?aZ8oblZDmUykTBXhb5FwFwVX+wtPXjySKebU003ytfyhj3FcKOMn/c4Ip/na?=
 =?us-ascii?Q?zgW2nL5z35I99bC2q+DGqa4UoL5IyGaiktimLib1WhTy6nAbOYrfVisxauqQ?=
 =?us-ascii?Q?NjVrWtZJLyEb0WAYt+kKsbf4WdLQ75jAK8xECcNXjGVq6Povlolfdktab7r8?=
 =?us-ascii?Q?jTXkHYE3MZ4ZAhtOdB9MY6hdkgdFa5bmIy90RGughfXaCcn9BCRmTfpq8eP7?=
 =?us-ascii?Q?vh0x2uXoVFTMMRkY0OU7N6GUpNfew6JQKuMNj586EYAPUUFGitntav0ThkYt?=
 =?us-ascii?Q?pgFOKeY17XAjBFnd1Aq4LIyEYr4AUOhF6firQicRhSLlxCH+Nedi5U1HAFRx?=
 =?us-ascii?Q?r+CYulINISnADFTB4YTO4dYzMTcJu15xFK5P8qSLsHZPKWDSVDgqc5T0Qtbu?=
 =?us-ascii?Q?C6XXEsBg7bfLKj9vosjDPAe1OktYBOglqrK+X7DRykMDoA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB4387.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RYHJUNlDZUre+XT8yVtyn3te/bsgJW+bBHO73NdVDy4mSJnU6ODWDrVnGJAz?=
 =?us-ascii?Q?xhNeKwCJ0FV+/NQrK3RR9tOMLzDqbsG2HSD3g9Bn4VoEMZ4TYDaIlQsajw1m?=
 =?us-ascii?Q?Tk86LFglDEy6dP3PgVLIB8Srrt5OoBPKAbZNp16qFY80zOcbeB1cHmdhH6YE?=
 =?us-ascii?Q?MbClD6IczT2Gg1RXtNZvlLAWluRU6Ub/S34uYr7R2KX/sHehjnDQUv6nR86C?=
 =?us-ascii?Q?b2DM+pNjcW+gMUT5ez674nVDMPm2uFKG0FWOK4jROeN/AjTfk8RTZJp5i/59?=
 =?us-ascii?Q?9uCjdopur1LJvUNNmReNSDRqA+vFToeRCOMWk+rZ5IZFTwyDMgnKIwvffMrM?=
 =?us-ascii?Q?mcQsMjIaL8kMKnb1216iaJTVfTQOPTAihHcGCoMWHcRZ2swzf4BUBUguNa0c?=
 =?us-ascii?Q?lnKpTToOtM92RYF3GGcX26VsQIMVJkYpEXenh8CoAvcDRQf44ZpsGX+wzqu1?=
 =?us-ascii?Q?c9vwEHw7YDeFIZ3w5ePDZ3xPjajAPc5m+SBX6A4VQFDS8tksVh2gdipOehze?=
 =?us-ascii?Q?FaWMTHof6lBp+4K/k3OezSjWvXByi4RWvPab3WsnZ5HMB9pJiXM6enS8HUyg?=
 =?us-ascii?Q?UGo7SJ3LKkzCYdP8uAkGbBNYsymW2EgRtmZ7LP9i62a2+jPMLDrpMumtJoXV?=
 =?us-ascii?Q?5GzXUED53toi1G/lPvyZws45tXC6sBQqP40z5qlHn1dqel9G+HqYyUolpKq1?=
 =?us-ascii?Q?o/HmblhgkG+vNM21qBm64dZHAgLF054gDeBrM0j8W0hqHD0vpk8FtOW9aLZk?=
 =?us-ascii?Q?mSpICU4widen99OQ6FEcuiGcJFHiSZ0QwjLSgc8vir9e7QCtJFZszsp10qf/?=
 =?us-ascii?Q?hc0Sqb2dJ0fr+kntYzfPaK9b8mJ4ybHkKOTrZ9cOZGuDCq0Xcw0+ZGrnEzKg?=
 =?us-ascii?Q?U1V6HwgDzAGPMAekzZ8pf9kLbUiToiYW83W5qdbEzqz5ncZcgiIpEd8dkHdy?=
 =?us-ascii?Q?gW9el/01EAT9N//BR6c1v2DgzbQ0SasZNMdue/Auw390OGFL3qD1hMx2GF+X?=
 =?us-ascii?Q?4Hr0FO4Awf4VbSfDQoScxiKMV5VJ1PzeXBXjoBO1B0q1dF/z5lzXrZyJwrQu?=
 =?us-ascii?Q?cOk+fd9mdbxUp40yUB9FeIb15lfjs9vfd3YtM0gydAuV8gHusTWlF9rBxiI1?=
 =?us-ascii?Q?bR95GTJGQJRMHRSjyXNVI/pVc5oaYqg1vqQvvbQDcUV9pt9Xyg4Hr4QARL1N?=
 =?us-ascii?Q?NfqZdtJkS9Zk9BjXoPibT0YMUJ4yZJSm7sRjp/ZMxHt0kjXm+J7hkJfnesH+?=
 =?us-ascii?Q?SNp6NO2bfnJGVCwEciT9mHmF0Maglr2bigZsjT7Mk7c2ldF01wWClUL1pBhh?=
 =?us-ascii?Q?SBJxozlSMj5NXT9cOBWZ8HrMSzpKN0EXg2WFCUp0K5EhXXTgkxyk+mgmZgfE?=
 =?us-ascii?Q?D0uQm3tb+FtaJWME3SGyAzfo2gD58m7FK1HNISf8T9qF8ZuFY0nM9pdmCU1f?=
 =?us-ascii?Q?qFeuUEysu4ZFo8bddCK9vJkDQVgN/GGmnRnCp928eMHjvCBPHIhC/7rUvSuz?=
 =?us-ascii?Q?JUnEShFtDwDE0EKpgKCt5n20OkRedQULwMK9tW8IQ31MldAPstzyd02FOMZm?=
 =?us-ascii?Q?8G4RH1CXPm1uDq5DsXB55OZRAKT0ddk+L6uI5n2KJGaYll0cycW+YGlSP+be?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9016c6e-ffc3-470c-1765-08dd62ae15db
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4387.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:09:58.9807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2yKEqc1TsHaOEpzuZpBxIvUFCAGU8Q9fdDgKmBIxVYPiIFYP1bKORPmgkBK90GIkGd+Buf90hf3zTofzGxIF9d6YxEDMoS/trrhfVdQl8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5757
X-Mailman-Approved-At: Fri, 14 Mar 2025 06:36:33 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Enable the Kconfig and Makefile for the MIPI DWI3C driver.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/i3c/Kconfig         |  3 +++
 drivers/i3c/Makefile        |  1 +
 drivers/i3c/master/Kconfig  | 11 +++++++++++
 drivers/i3c/master/Makefile |  3 +++
 4 files changed, 18 insertions(+)
 create mode 100755 drivers/i3c/master/Kconfig
 create mode 100755 drivers/i3c/master/Makefile

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index fa68612787b..8140b530bb5 100755
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -14,3 +14,6 @@ menuconfig I3C
 	  If you want I3C support, you should say Y here and also to the
 	  specific driver for your bus adapter(s) below.
 
+if I3C
+source "drivers/i3c/master/Kconfig"
+endif # I3C
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index 5bb44a8d64f..5ddc4743c86 100755
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y				:= i3c-uclass.o device.o master.o
+obj-y				+= master/
diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
new file mode 100755
index 00000000000..22bb7c21ea1
--- /dev/null
+++ b/drivers/i3c/master/Kconfig
@@ -0,0 +1,11 @@
+config DW_I3C_MASTER
+	tristate "Synospsys DesignWare I3C master driver"
+	depends on I3C
+	help
+	  Support for Synopsys DesignWare MIPI I3C Controller.
+
+	  For details please see
+	  https://www.synopsys.com/dw/ipdir.php?ds=mipi_i3c
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called dw-i3c-master.
diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
new file mode 100755
index 00000000000..c7562f1aa33
--- /dev/null
+++ b/drivers/i3c/master/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DW_I3C_MASTER) += dw-i3c-master.o
-- 
2.26.2

