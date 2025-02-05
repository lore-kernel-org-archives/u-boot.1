Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD37C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA109808E6;
	Wed,  5 Feb 2025 14:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="WIJfp6EJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19B21805E7; Wed,  5 Feb 2025 11:15:52 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02693805E7
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYYbgEFWbesDjb6yYNEj82tecjd8lEWM9d4LSwMAble7UOZnJFvQMflD3Y4PjhQpV0OX/874CAgHzryL4iJXi8Segi8VJD8oloab5e0U4KSNw5S9GZCiat4X1FcQtZwKR31cXxwmizXgxdmzWsFcogEHbWLw/E5b51y8G7E6NkEQRJnXPAsQCVAz7fsl6YBwR9wZzewE7zjBCLhMjhP7fyVmDbq//qorIAWVHDXW7sdAd37h6SslEV4KdVPCXO4Eo5Z4DRF52qSB9Qyejopck2GJNFqn6dlHj4w9Hcii3mr8tmr2/LTAB+IF5PnRrPtKHh536Dmw+9PAvDcUMsemKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+jQM9nRT8Ckyts9mE2QaZi3YgLK7kZoGQk7BSOekeI=;
 b=MuDD+THHQ3vdxi5MGWPFP7noBxRVEKsPjCl2IWLTnX1mK/kgkBzi6Q7XL4EcdXbpM8Pm8ZT/mT5eyOnDyjGkwvMv3Cug8CqVP0Y6Ly5kABvbxiH9a1ZNqE3LdsNyDRVjecmpVTuuRl9NzYo8jv/kkYCBJOPzFDqTVrQZNW1/7X/qoFXpn1sGSIufovE4SOzx+ITpDEjN4x1HOdvhNRMr4QyuzVlATd/ORvox9mRpJwgywmzqzaPJDQ6b3Ge+oDM8iVrwgYfSB4OTbbIrYsxvp3fh50qdnnH5qnRTOCnOV8WXOnA6NZ7ckA+iEatCXkRyji/Lak4qH6YE+AC8/tCewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+jQM9nRT8Ckyts9mE2QaZi3YgLK7kZoGQk7BSOekeI=;
 b=WIJfp6EJVEZLK9MghsyKaWab+8UoumjDs3z9sqB7n6xo4nBUuNiedU5413dpdoJC9et5jerDpv2F+3IShqCqJAyuHosURtdJy+pPVbjO1+eRH/8pOfXsOasxHqftWhNpNYJHbMXuuQTIGBxK/lAiKfj8QVcfseqP6S2YemN/hkRNDB7Ur1fRDdvGdcQBAGhBigvPfSg0bC3tJy/NAK5hErFXyfh3eNUJoh325Q+vvhdBA/TV0sioG67wY4fSbILskyCux3pGU8xnYaDoHyT5hwajGHaR3bpVoGspUEyQfHgsZkXjlGG6cMTLvJMpNu1oCgdSUuvcM+Dve8/fRZpNrw==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB9635.eurprd03.prod.outlook.com (2603:10a6:10:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:44 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:41 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Tom Rini
 <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 01/20] include: dt-bindings: clk: introduce bindings
 for rp1 clock
Thread-Topic: [RFC PATCH v1 01/20] include: dt-bindings: clk: introduce
 bindings for rp1 clock
Thread-Index: AQHbd7bpD0KJdoQLqEOfnUnOXvc65A==
Date: Wed, 5 Feb 2025 10:15:41 +0000
Message-ID: <e6caf0dbfa861eb12e6298efa784a7184e2769c5.1738749764.git.oleksii_moisieiev@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1738749764.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|DU0PR03MB9635:EE_
x-ms-office365-filtering-correlation-id: adf684ec-d2e7-4075-85eb-08dd45ce0bad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?YsWVFn8xfHXc0hbhLAiWwLtLIiWIwsyZoSlq0kdqRf59E2T4tuVsZdVUK+?=
 =?iso-8859-1?Q?nKavNszWWPehZjicWIIffPNdPqW3NljLupfjpWTQOEVuHOhkKxaVZ32mzw?=
 =?iso-8859-1?Q?3JGa5zGKhEr/yokiWLjywdakpkMoxJjZa7S3QGNnvLEy3K5LDIp08U7hkS?=
 =?iso-8859-1?Q?oBsa15Wa688Wo/jN27vVekbr2M8Mza2l36oY1iO2eEeYdjUaZh5Kvhaowx?=
 =?iso-8859-1?Q?mi4KDSxZfn5MhZxKQpJt2OJ9TqqJTWczWs6NBxLB4F2asaEknA3YyOj5eQ?=
 =?iso-8859-1?Q?/kADXtue4halbOm7Y9r2ejfNuOsBhL69yJ5A9c9ePEsRzaPp/LWGhLLNfd?=
 =?iso-8859-1?Q?Ip8Lj+4GXXQ52fWeKVzyflRCnizRx1ndZ+wCB4Ww3ZEJYWp+ZOa1CzTJdk?=
 =?iso-8859-1?Q?OGm/TNV8qjok+xSIHiM2iQn0s2NIlBEpT2THMMgq4hlCdZvxqJ+puT6ibt?=
 =?iso-8859-1?Q?WDL984vgi967Nc2Jf84v83KehDzGSGDJcDrnJVGipHNnMqZ+bhWzPLVG9W?=
 =?iso-8859-1?Q?9Q9aX64ed4EvsovmjM4zPvN1cnwe/WOCX7OfwfNbMNqeY1Z5KoCGfZxAtM?=
 =?iso-8859-1?Q?2bCdbKPquXAqzDN7wKZK+PVubxhDeWQjV6hk+eRzxSRecPQW4nKN3OjfYH?=
 =?iso-8859-1?Q?yWb8bT289miTyyqFp5nSWiCeNUKWTe2MUYc48hMbRdQgMb5XJG6lUGzm7F?=
 =?iso-8859-1?Q?PejY2U/xIXbS6/bDxSoWOjm30z77zG/Yof7PtCHXQjXaxTdp2fvpL3LlpV?=
 =?iso-8859-1?Q?N3AwG1whD8FdGskySkUNkNA92HvOLtiK0B+yMNcqNyoZbdCAg8s5mTP1MN?=
 =?iso-8859-1?Q?j6PJ53u7tgjorKppGke7jsW1+kBkwkzSoL79qp7TrqSiIqNjL6ZtWKTa42?=
 =?iso-8859-1?Q?bJ3mcDLueH9QnoH6bi9goyUccwFuEHxQCVuh92ALnpJVdz4pV9hpVhqk03?=
 =?iso-8859-1?Q?EQ/xTRt5MA5sgmkpmCCP/kz/OjfN4dN9LgaECmx9a7xG+NVug4VDpNpR46?=
 =?iso-8859-1?Q?aG5wzL5ce0W54ayz0kNzbF48G1SZzjaETK+AUh6rfDRaPfgRzTqBHJLvXc?=
 =?iso-8859-1?Q?Q10IwtVbvASzGFXvTI+MP2W7jF849CBfzFIEFim2WnTSt568AOzYBbF/ry?=
 =?iso-8859-1?Q?EoUrXPhTDeN89Ws80jnJ98+BbkR4592PB2GUTk2Pct0CDZnB63YY5Tq5rV?=
 =?iso-8859-1?Q?0HrsZsao97+YrUeL1+NXnEIRl4QcFHk6dz9uahZjoHOV17pV1th72mOJrJ?=
 =?iso-8859-1?Q?eAWFpcg5FJyu3aQxpVrI85MiCHRUqly4wRCHLNlur1qIHLb0VV/YxGVEqj?=
 =?iso-8859-1?Q?bx40pbDp0UBm8HJW+JHlCw5TWb3Q6v1gY9i3gHe4JTfuZo0t/Ruvy+AiH4?=
 =?iso-8859-1?Q?Azj4flJvAvP4Lf18wwGPUdOGTkMVJgUhY741JaF0KO2h6E/wxDx8w8ad8a?=
 =?iso-8859-1?Q?wmvrmSftzO50jKdeEHeznV/C+pklCOg6mIphY+0Jp6H17JcDZgMr7peFpu?=
 =?iso-8859-1?Q?9zSETyJZM0ptfiYVnXkEMp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XUdQt6kyI1Lkyo/gQEmUrCtuItZqGniuHkQmu8iKK/sdUcC9DrdXRi6Hl9?=
 =?iso-8859-1?Q?P8BFN9MKHaiO6vJ/32wYJqMt1IPT6YZAIeFTkUViEdgBzNYR+4Q67ZD2Rf?=
 =?iso-8859-1?Q?UQ9WDjgq8LRYn3rFv8qe2OXPE85+G+wYmG7hOq46gEEaE8m6xqpxMOCuiP?=
 =?iso-8859-1?Q?tOjOGefuUHdNd5dm12XYv6lJZTM3smkTNeALfAeMVL88T3xWsqRsjv5URZ?=
 =?iso-8859-1?Q?dwCPMnOGIdkZjG6O6b3ORelsJ1RqzD/YoS++KWwnOSy0msgqkgzFXwVUEu?=
 =?iso-8859-1?Q?ouy186xOmdI86dD4H2z6xXBViXfOlKdycKbQfM1sIOiqmsM0JywBLtBGiB?=
 =?iso-8859-1?Q?at8tckOlby3DbToO+DTbutAa+d3QsEipFeveOfjveSPC1uEYComFPInXMD?=
 =?iso-8859-1?Q?cL3ZzmdOdVvAQVIVuOcTLYG9oaK8kdcYTW/bgjFPALdvkeLx5nrHNhph+A?=
 =?iso-8859-1?Q?ZBduXyp3G+ppDEp5q3ZFCB/xlS/Zr+3RhOPZfCnRF4LTN8109/+V0SMwgb?=
 =?iso-8859-1?Q?fWcb8a/4OWrEf1XWp6CgJRWwunDdQruiXaOlbA64dUGJtj5fhANo3FIL3A?=
 =?iso-8859-1?Q?YnbjgXmtJkso75aqPaEMOfgNSevmW1plLyoLO8KXuwmFcRa3WQQEK7o6Pd?=
 =?iso-8859-1?Q?5b5jARkzV7Uh2rTHyPl6dNvCAMjo2+FvsVAPa0cqL8KAnC/5xf9xbFhzpd?=
 =?iso-8859-1?Q?rqOZA/7XFMsNS1ysBR3aCMSH01hef7bw5rBXL79FgxtwJ3NDaCmUTP4N+Q?=
 =?iso-8859-1?Q?Rt0DW3WBrm72FNQ05WmT77iaV+zifzCuJ54GIw+/HZH0BG9svQbidO0M6x?=
 =?iso-8859-1?Q?LhM04IFqp4G1or93k6M6dAo8x1w5cbqdYk9YxuiIbvkBvOOvJUDTDPnYNR?=
 =?iso-8859-1?Q?4NRXfx0tm7lchfB9NiQbXVRvgCDiPHLxw3xqgYTWjhO1gf9Ph2iERqz3BK?=
 =?iso-8859-1?Q?Ixh5MiHLvVmVfoDpnpCg/NRIfkHnYNGgHsFiOKPEyP0TsBVqjUJHzWMoTn?=
 =?iso-8859-1?Q?8BYgTSLwBG6KjFDVQGa+19TqRiH9rbByJmlEgEw8AumfscRgsgf3Z8hBBx?=
 =?iso-8859-1?Q?ppTa1nwyT3wjQwzvGwKIiGrUwOMAR/gKZkGVPFWrrm1mkyF9CLL7cQFcau?=
 =?iso-8859-1?Q?OImncGYE0Ir5fFNyxxLXGPuPMebokDXHrq3dZbMCGu5oUGOms6vOrH/2Ub?=
 =?iso-8859-1?Q?4wb3JGPmvI/TQVJ9/lxKDMPEZxEHOei1Ko0Q9DAtVDFjQKZFWtuPyFmvaQ?=
 =?iso-8859-1?Q?y09mBEiNzC/OF4QuUrDWQLR33FG4cFd4j/Bm04h1cAkSUS5/OeywA2cv3W?=
 =?iso-8859-1?Q?gRa23C3JNzfIjk2oAo5LU9pzH4GxIwYcs9LV9RjiVtSPgwF4Q8Nde3UkWv?=
 =?iso-8859-1?Q?PKYvrPrm/yPncm6VrRG/pMcScc9/n/YWWdF0ilBvK6NYRUcVgUj9dWZ2tU?=
 =?iso-8859-1?Q?ZxM51qvwAvv/J11536rMhoBQNXdAJPvetw1NMaiYjmOKK2uJV5pU5yTF6+?=
 =?iso-8859-1?Q?Vep6cYRt/trW+ZmqBU1DF9soDZvFVeqXa3qpnYJqsPf7Q8zAzGxQvEki+w?=
 =?iso-8859-1?Q?p/a91Slg+/QXDtaQGGA8y0OTeN9zhxiWrFQdVZ/vPc7/UiwZq76Z2owsmy?=
 =?iso-8859-1?Q?wD0PZP0uMNu95ABDGGWnKevBNgz24QKrITMUv2xEXPSGLQ8f9M3j7Xzw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf684ec-d2e7-4075-85eb-08dd45ce0bad
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:41.7368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGxJoGo7bk+c7NmpeGnUw6S3PS5LdwRcK/hBcVuZ3IFxp0AePstv4gVodn+bhhJgKqLCC7LGoo1SLVLv3k2MSpjLYOe3vxxedM+Wr+M1bow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9635
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

Introducing device-tree bindings for the RP1 clocks.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 include/dt-bindings/clk/rp1.h | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 include/dt-bindings/clk/rp1.h

diff --git a/include/dt-bindings/clk/rp1.h b/include/dt-bindings/clk/rp1.h
new file mode 100644
index 0000000000..27cbb6e130
--- /dev/null
+++ b/include/dt-bindings/clk/rp1.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 Raspberry Pi Ltd.
+ */
+
+#define RP1_PLL_SYS_CORE		0
+#define RP1_PLL_AUDIO_CORE		1
+#define RP1_PLL_VIDEO_CORE		2
+
+#define RP1_PLL_SYS			3
+#define RP1_PLL_AUDIO			4
+#define RP1_PLL_VIDEO			5
+
+#define RP1_PLL_SYS_PRI_PH		6
+#define RP1_PLL_SYS_SEC_PH		7
+#define RP1_PLL_AUDIO_PRI_PH		8
+
+#define RP1_PLL_SYS_SEC			9
+#define RP1_PLL_AUDIO_SEC		10
+#define RP1_PLL_VIDEO_SEC		11
+
+#define RP1_CLK_SYS			12
+#define RP1_CLK_SLOW_SYS		13
+#define RP1_CLK_DMA			14
+#define RP1_CLK_UART			15
+#define RP1_CLK_ETH			16
+#define RP1_CLK_PWM0			17
+#define RP1_CLK_PWM1			18
+#define RP1_CLK_AUDIO_IN		19
+#define RP1_CLK_AUDIO_OUT		20
+#define RP1_CLK_I2S			21
+#define RP1_CLK_MIPI0_CFG		22
+#define RP1_CLK_MIPI1_CFG		23
+#define RP1_CLK_PCIE_AUX		24
+#define RP1_CLK_USBH0_MICROFRAME	25
+#define RP1_CLK_USBH1_MICROFRAME	26
+#define RP1_CLK_USBH0_SUSPEND		27
+#define RP1_CLK_USBH1_SUSPEND		28
+#define RP1_CLK_ETH_TSU			29
+#define RP1_CLK_ADC			30
+#define RP1_CLK_SDIO_TIMER		31
+#define RP1_CLK_SDIO_ALT_SRC		32
+#define RP1_CLK_GP0			33
+#define RP1_CLK_GP1			34
+#define RP1_CLK_GP2			35
+#define RP1_CLK_GP3			36
+#define RP1_CLK_GP4			37
+#define RP1_CLK_GP5			38
+#define RP1_CLK_VEC			39
+#define RP1_CLK_DPI			40
+#define RP1_CLK_MIPI0_DPI		41
+#define RP1_CLK_MIPI1_DPI		42
+
+/* Extra PLL output channels - RP1B0 only */
+#define RP1_PLL_VIDEO_PRI_PH		43
+#define RP1_PLL_AUDIO_TERN		44
--=20
2.34.1
