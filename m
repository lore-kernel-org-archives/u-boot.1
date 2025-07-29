Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F38C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF14E8313B;
	Wed, 30 Jul 2025 07:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="Coa6wdKG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 420A983045; Tue, 29 Jul 2025 18:23:33 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D54682BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkQafiI4/8zmHj031W/02i/Qn/e/rqJdB4bRVJNJpURZZk/WmzQ85X02fiLGe/yTPp+X1D8chX7ZW4wZFO8j8U6AYocYX2b7+gmYaghUbHI8Zj8+8SAYV7W5K5/6dzrOz1a1xZzgWNC3RQYy+XjVJ6ppXV4pZC6bAz9kh0m9TX04aGtqJJjLvdppX7jQ3M8/KAnCSNx/cDxoF6IxaD8dMqOQvEoe7yU85WVQUB+9BQPvf4UCMkq90z9iPc18bmar/40GmdOSAhxnyjdo/q3FtYBCf6ZpdzzM9zJmhwAiITRf0U/oEQ8lzexu1M7YQKg1/Pq7AybMu6KRVWKPolhePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxaznrnMJMfKZhNrxTRwZFLNHpIo4UNax96dmcWNK8I=;
 b=Tu0JgnDZpbvkdoj+8a3qsfyFS4nvBQy4wg/vymJ2JBGSQBnD8KR72EI9rQrEEPIQuESPsdNaTufi+hapeIhZjoqRDK0tQgH+HRtfMB/Lo1CWQZe/HLmX0w55Hw1UYKhy8CYrq9BM3geoHNXXpRfbQBI8OlZYdIsbHK8hH1X0E9BWneVdTqKq59V38kHzubxYVwanP3DbgVGqwHncRpD5lwQm2di+80nqBHTTnOei7gW54ZsaIuldyk4IkDgTh9cx8RQ8V45D6PRxnnSOfPjjRn4OM4WWpu0hEF0feSF1EYNTLbjU3lLmAIcKNXU0m2i4UmyCIy9CGIok+9KuX3zMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxaznrnMJMfKZhNrxTRwZFLNHpIo4UNax96dmcWNK8I=;
 b=Coa6wdKG2XM0XTaIJakakjAJaj6tQMcMWfqz+wfxAzT7Ml9uHxFUd2WY26etBvJ8AzxcfaQPeITHJlmtYkP9YVapg8xu7dm+qR3Fp/0Dv0CyfrVZRv6CbpaPlqdbhVXEgxMOd6HgtmOr6ZlfYKd+1Ar6DfAz1moyeGisrMtcvM99RmZoRnPGXBhN4zN2awBF97Flx/Y6L8cgBmBXRvz5C9eHHVbelG6K39Wro/ztZ+f9RvBJyUxRrSqEX+U6slEWXytPhc9gcgr+XfWk9dXFRYGIiBIx6vh94qQsEF3CPDhVpMpJWy4rinl/YeBMQX18+OXcrHKp02ATbeUhP7hSXg==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by VI0PR09MB8338.eurprd09.prod.outlook.com (2603:10a6:800:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Tue, 29 Jul
 2025 16:23:28 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 16:23:28 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v3 05/12] riscv: Add support for MIPS GIC syscon on RISC-V SoCs
Thread-Topic: [PATCH v3 05/12] riscv: Add support for MIPS GIC syscon on
 RISC-V SoCs
Thread-Index: AQHcAKUdX1DpbX/RZ0ibMsQDF9K8qg==
Date: Tue, 29 Jul 2025 16:23:28 +0000
Message-ID: <20250729162035.209849-6-uros.stajic@htecgroup.com>
References: <20250729162035.209849-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250729162035.209849-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|VI0PR09MB8338:EE_
x-ms-office365-filtering-correlation-id: a7515a35-d93d-4d5c-4f88-08ddcebc4063
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?1qxzmu+cjTgyZdefUg8Gcygecodx9VMw1/8q3mnIn+LldjCBVVETk0G8XF?=
 =?iso-8859-1?Q?QT9lUmK0ikao6s135BJl5jZwbX8uGlATf+giY7UxGpN0it6PAGTpi2pIEh?=
 =?iso-8859-1?Q?W6MEcf8jv7nDKF3n2N+1RPcztqzQekgYs8SCkPg3nYpB5ckriR0uvVd5Tn?=
 =?iso-8859-1?Q?8436GJT8gVqObVVcKZz4fj0eJAEcWcE5I0wmJ8/dPUwOWNv9XFxNuaKLVQ?=
 =?iso-8859-1?Q?os5ps04OSVUMrc+TYqyejJ982y7N8q6zzCJQtkdpKeskjLrifG12neNgtm?=
 =?iso-8859-1?Q?059rSTw95cL8bViK7s/OacCFld+sPHMovh/txGlToeifJbwF5BGaALP074?=
 =?iso-8859-1?Q?ethZLFamZa9Y8KqobCQsoMKbmQZflDXB2J27TQI92ilueNNz1UxGqL7Heu?=
 =?iso-8859-1?Q?8Ly6QNytSDqLd/iMAlJPZqrBrB8yNgcF5sELp9ceWSU5mfRh3NOiOlKVNP?=
 =?iso-8859-1?Q?ikZrFaFfM2GrXBJyW03DVNQ7r4TS0G7gNN3ySWZV/iT4sG4+qvEiODhmQM?=
 =?iso-8859-1?Q?mv1Bw9GvsXAnOuwRB119S9d3ll6qvYQajwYWgBaSvYgnrIxQ1FjRN5UKn3?=
 =?iso-8859-1?Q?rq+Hbn0Z3ao1VHux4muPQcXcj/kdGk9MkKLkRw1RpGxl3woDFcCJoADpwK?=
 =?iso-8859-1?Q?mdQXFQ6HJUnJ8603JDwSoVfx5nbt39/MBSkCOzUNRIkfrAgIOtFoEmHrpU?=
 =?iso-8859-1?Q?0KYq+xNFW0BfdDcgkWLm89qrj8aVtGUiIsUUiHKB67E3xv74q2uGVO5wqI?=
 =?iso-8859-1?Q?kaPBt6JDrY8ImCMOAJlX1VaZ/0EeWE1z/mLOV6daoXbPCzGU1E/Mr1SFEH?=
 =?iso-8859-1?Q?eWsJlfv8goWG+8VzB0mX6Qgk1uuh9FE4S29TIVjSZJdDo3KIyIfOFdNjXc?=
 =?iso-8859-1?Q?ogOMkaPqjc78WDFHU51PsA8ikP1Z/JzuWeupsvl5U7LzE4zQi4FoiJGGj+?=
 =?iso-8859-1?Q?dlxOhc3nUrdBENiq5F0eFE7LDgtRrc5PUeg6N0SNzkmu72k9lfi3v/PENO?=
 =?iso-8859-1?Q?+pttDidKwm8pMDyDVi4rqD9i2fqs8GldTLaBSQSCqA/l12gPwNKWLgAsJ3?=
 =?iso-8859-1?Q?mVh+cwdrsAwBXZCrFcyO4kkDO1jLT0jTLprAbW1lbsQfG6F/QhvuHCsDvW?=
 =?iso-8859-1?Q?IvR6lspA5SY0BP2hgXjksqz6EUS0q8GHvov5jHs7rouZz/CD2L9DG6g0ss?=
 =?iso-8859-1?Q?Vrt/qi+sGr+fh9z1Y6wjf73iUM4oP/PH9RlROm4iwcEHXDpK3lYDbxMhgW?=
 =?iso-8859-1?Q?J4cxDFygPaDPJDvrbYWOgDrHulfiAA6y42NQWf+UmgGpmZTTWyaTP6yCqj?=
 =?iso-8859-1?Q?VIwkR3vu6Nd7iQKw/dE/cYZQ11YnZ7Or+WAI8/1hkDY0CquSTXAaxbLpA9?=
 =?iso-8859-1?Q?hHniHhTNt3r8NtImjOJTVZDfRp8kRvuQq6jzcie60pV+7kppdCfzXj8PTb?=
 =?iso-8859-1?Q?qv5YW4X0CBkCq8v0s5LIm67fVhuoFVy6LZtyLTyLCerHbfEmcW1OjBkcC5?=
 =?iso-8859-1?Q?SzfPRieu17RJqkckyTb+h+dyqVcIW4293PH45YEw9CLA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FJEbKg4Pr+tBLYhcXjat8gXY6F+gwN0O2ORk4BJPGvCe1Z5eAW/+gY4bm/?=
 =?iso-8859-1?Q?9z1XtTAwHMe9vFvb6Dm2hYr5PaKIo9izsx3eu2nxk1qz+sizSYxFOw3PAi?=
 =?iso-8859-1?Q?+qQFSyCRkNnITnRoakDfs9fB9WW/zIKWy63uDiV56jdXIve5dhuhMnGJIh?=
 =?iso-8859-1?Q?ecfMzTS0Z4qUo+gwFhVewbzBnmxQOiBUrYP1DTTl0ypt18MXmUb9joGpQ3?=
 =?iso-8859-1?Q?6F3ptXhdj87GAKJuSp15w76WSPWdlv6MZAFTSfibWq+SNeU/W9fiT0/Rcu?=
 =?iso-8859-1?Q?22n8ynPXj79Xaz829RvJr1JzmkLxQ78dWcKmi1DSoxYHqwX5EbfRxZeaR8?=
 =?iso-8859-1?Q?LAsK0Uqe2z32sjuy5qIwC5KXCHq6Zfsk8jlkc3Tzn/ReAk+9pq2CySLrT7?=
 =?iso-8859-1?Q?U8wSWNWDnzPya9BIR+t4Ycox1FoEicMUdfmgWlwYXj3tG1ehQexfyT9s6y?=
 =?iso-8859-1?Q?YMOAoeoRwuuzwsqhZsuhupOzm/skYfubDmSOGJ1LEOakSB8Vl3uWHlzsNt?=
 =?iso-8859-1?Q?3Iq/bMPCx1S4syQaRXrU80OCLYSAHifJucyboaDHoqCuWneAXTP1x7QeVV?=
 =?iso-8859-1?Q?dEbaSRcs/wwt5JSoTnNMcwP2iCmBkCKP5PUVwzm3/yeiJKtWhbEotaIVpT?=
 =?iso-8859-1?Q?XixH/u1kxvrK0kUpYQ9YeqvsTmdYhnmEHDhaL5nTbpk4N0USEmSA98bxzV?=
 =?iso-8859-1?Q?SD7HfX5hFrAoAYHTuiwjr2CvY068abM2Mq8FvCnlb24lnd8p09Y/OiF8mu?=
 =?iso-8859-1?Q?Sm/v5P11G9+RzcfoaJY2Szgt1tTI+aduS8zIrfJLQ+qHPsc1OaIGShC8zZ?=
 =?iso-8859-1?Q?HUg+QW3j7OcCbPjXqTs5MDmfiHwzE2ytstVWJnxpTC03ccqiEJSSOQ/+db?=
 =?iso-8859-1?Q?5dzX/3jYfBeasSjb8bIez7MJQ2CGYoWRRzrg5EGNiaq8Q4BegX1D7oMYvo?=
 =?iso-8859-1?Q?vLApmyag/0he8uMBooe3YN8eVtYXvW5bahKxOOaJXWc9+5XHQetWpadYQ5?=
 =?iso-8859-1?Q?U5cT4jAqqCh4RljyBPRTtBBAPYx/1bywDNvbXdCeryYjIiw1ZCtIjQ0k2w?=
 =?iso-8859-1?Q?VM4w24p/ScT4vkya87x1MOPQ7qjNDcNSrtbqRDKOn4irPnX7FCean+bP3N?=
 =?iso-8859-1?Q?D3aHQkEDgFm6+ZY1HOXcn5WpHTrepT83os8ZbC8+7GG+3xrvWTrkAkYfk6?=
 =?iso-8859-1?Q?iWfR+jSm0TxAdQOyEktPW4gt1Tw/MRs2H0H+qerjzfdwb3+tH0ATQpXxsD?=
 =?iso-8859-1?Q?GsrpZ8tDSsM7hpouYEvTeT79azWc5gVhh8kRWYA6ik2OrqBNyjVExPGuCX?=
 =?iso-8859-1?Q?PJjBH018KDAx7yuKJ3k8m74jGNY2VFrsf8ykvAsSBFSbsewWlNxoxjfISz?=
 =?iso-8859-1?Q?ODWmtNBXyCZ5n+rTbWBbK+fgaaEK1zCKcWqt7tMIyE2OVYkoEwdbCFgMkc?=
 =?iso-8859-1?Q?Lc9mXrVSs41zV5aeN9jr+00jdqkCmlAvQwzL1S40m2DB0sMj6Sy0W1qO/z?=
 =?iso-8859-1?Q?f2Es640vru8uR5fu2iAzkI+2YtYcWMrQ0Ns3k1QbL3x5GchcfnjrFgrrQl?=
 =?iso-8859-1?Q?758IDGSJ5w7fyIDh4hG48KQIMwIU8uVP2JviCaj7N5EzYVu+gZQQz3VPcf?=
 =?iso-8859-1?Q?rINwWQ/bHIgTQie7X2eycKrvst+lfFCfVVFbTDKR1QtmTnD7HJbI204Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7515a35-d93d-4d5c-4f88-08ddcebc4063
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 16:23:28.5705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owqpyd6cKtWkc9rRA/HktzHfMGh16bpqcATTMm+z1bPZ56Iq/gR0jlbrqcmAwhJZl+LZ0N2eCaTSuNyummAVaRklQqvooNdZVG+nAp1NfEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB8338
X-Mailman-Approved-At: Wed, 30 Jul 2025 07:10:08 +0200
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

From: Chao-ying Fu <cfu@mips.com>

Add basic support for the MIPS GIC syscon used on the P8700 SoC.
Enables access to interrupt control via device tree matching.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 arch/riscv/Kconfig                  | 11 +++++++
 arch/riscv/cpu/p8700/Kconfig        |  2 +-
 arch/riscv/lib/Makefile             |  1 +
 arch/riscv/lib/mips_gic.c           | 47 +++++++++++++++++++++++++++++
 board/mips/boston-riscv/MAINTAINERS |  1 +
 5 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/mips_gic.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b05e0622908..aada4f4061e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -385,6 +385,17 @@ config SIFIVE_CACHE
 	help
 	  This enables the operations to configure SiFive cache
=20
+config MIPS_GIC
+	bool
+	depends on RISCV_MMODE || SPL_RISCV_MMODE
+	select REGMAP
+	select SYSCON
+	select SPL_REGMAP if SPL
+	select SPL_SYSCON if SPL
+	help
+	  The MIPS GIC block holds memory-mapped control and status registers
+	  associated with software and timer interrupts.
+
 config ANDES_PLICSW
 	bool
 	depends on RISCV_MMODE || SPL_RISCV_MMODE
diff --git a/arch/riscv/cpu/p8700/Kconfig b/arch/riscv/cpu/p8700/Kconfig
index 0e5e4c9eda6..223130d5443 100644
--- a/arch/riscv/cpu/p8700/Kconfig
+++ b/arch/riscv/cpu/p8700/Kconfig
@@ -8,7 +8,7 @@ config P8700_RISCV
 	imply CPU
 	imply CPU_RISCV
 	imply RISCV_TIMER
-	imply SIFIVE_CLINT if (RISCV_MMODE || SPL_RISCV_MMODE)
+	imply MIPS_GIC if (RISCV_MMODE || SPL_RISCV_MMODE)
 	imply CMD_CPU
 	imply SPL_CPU_SUPPORT
 	imply SPL_OPENSBI
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index db8d235c699..692b56cc3f0 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SYS_CACHE_THEAD_CMO) +=3D thead_cmo.o
 ifeq ($(CONFIG_$(PHASE_)RISCV_MMODE),y)
 obj-$(CONFIG_$(PHASE_)RISCV_ACLINT) +=3D aclint_ipi.o
 obj-$(CONFIG_ANDES_PLICSW) +=3D andes_plicsw.o
+obj-$(CONFIG_MIPS_GIC) +=3D mips_gic.o
 else
 obj-$(CONFIG_SBI) +=3D sbi.o
 obj-$(CONFIG_SBI_IPI) +=3D sbi_ipi.o
diff --git a/arch/riscv/lib/mips_gic.c b/arch/riscv/lib/mips_gic.c
new file mode 100644
index 00000000000..7d761c58e74
--- /dev/null
+++ b/arch/riscv/lib/mips_gic.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ *
+ * U-Boot syscon driver for MIPS GIC.
+ */
+
+#include <dm.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <asm/io.h>
+#include <asm/syscon.h>
+#include <linux/err.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int riscv_init_ipi(void)
+{
+	return 0;
+}
+
+int riscv_send_ipi(int hart)
+{
+	return 0;
+}
+
+int riscv_clear_ipi(int hart)
+{
+	return 0;
+}
+
+int riscv_get_ipi(int hart, int *pending)
+{
+	return 0;
+}
+
+static const struct udevice_id mips_gic_ids[] =3D {
+	{ .compatible =3D "mips,gic0", .data =3D RISCV_SYSCON_PLICSW },
+	{ }
+};
+
+U_BOOT_DRIVER(mips_gic) =3D {
+	.name		=3D "mips_gic",
+	.id		=3D UCLASS_SYSCON,
+	.of_match	=3D mips_gic_ids,
+	.flags		=3D DM_FLAG_PRE_RELOC,
+};
diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
index bc59a628c79..0d9a951441f 100644
--- a/board/mips/boston-riscv/MAINTAINERS
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -8,3 +8,4 @@ F:  arch/riscv/include/asm/arch-p8700/
 F:  configs/boston-p8700_defconfig
 F:  arch/riscv/dts/boston-p8700.dts
 F:  drivers/gpio/eg20t-gpio.c
+F:  arch/riscv/lib/mips_gic.c
--=20
2.34.1
