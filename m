Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928D7C02192
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 14:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FE0482887;
	Fri, 31 Jan 2025 15:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=tria-technologies.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tria-technologies.com header.i=@tria-technologies.com header.b="pB0M3RY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86BB080F0E; Fri, 31 Jan 2025 14:38:20 +0100 (CET)
Received: from smtp01.avnet.com (smtp01.avnet.com [12.9.139.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C937680107
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 14:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=tria-technologies.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Markus.Bauer2@tria-technologies.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tria-technologies.com; s=20240711; t=1738330694;
 bh=x4W7tpWpM4YTqedC4XT/ZajZKpIwScFKQVMABPk8u08=;
 h=From:To:CC:Subject:Date:References:In-Reply-To;
 b=pB0M3RY+NHLavjLPMfmeJ/fvlxkhXsPd0pYogKcGpNp2/h5lSCJu5SaQ6cIwjj5oR
 jMp6KvNi8crN6/xR2iQrIjFpp65qWm/1dTr4IlrBi0St85Hyoh/AoGqlvpRLJioj7K
 U/EzGqvQy9nS1QewvHOOYHqCbvUm/P4gRJSUIFZphp8D/zYpz0dePNguLZhh3gNRIm
 52tvgk+68W7buGfc1W7hNgvkuX96GwqDT7BT9/8alZc941150RAtrYHopsxvFNuExR
 6WpZCAnFbaEsZPC8tVsRlQ0QAB5eTU608Vm8kuxdZir77qBQ0qfWmaLa9Ph4/VEBKD
 g3C+lhw0TqXtg==
Received: from CMX2401EX1901.AVNET.COM (Not Verified[172.16.125.53]) by
 smtp01.avnet.com with Trustwave MailMarshal (v10, 2, 5,
 6043) (using TLS: TLSv1.2, ECDHE-RSA-AES256-GCM-SHA384)
 id <B679cd2460000>; Fri, 31 Jan 2025 06:38:14 -0700
Received: from CMX2401EX1901.AVNET.COM (172.16.125.53) by
 CMX2401EX1901.AVNET.COM (172.16.125.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.13; Fri, 31 Jan 2025 06:38:14 -0700
Received: from FR5P281CU006.outbound.protection.outlook.com (12.9.139.148) by
 CMX2401EX1901.AVNET.COM (172.16.125.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.13 via Frontend Transport; Fri, 31 Jan 2025 06:38:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U49N5p1xrqnBElZRG93YdeKNE+fpYsLATjvmAW1n9JykC3WKf1qXpLgn58xaMpmzH8+KMeO6ry6If5+Lu9C49SUqSdhpzL7a4swylGUTkOPXt/r1fQGQGb2a2L4n9wy76oY8uIlVPVtJzcypSxbFzlPibGXuhIthnL3HtIVvmtc/r7joVC+FRzJfGPBy4WRfy38YJwFYxMKiOkMzbm1H7b4xzD3h9lI4fdy3xTrJ72o1H00DuEAjIy/FVVXpsZahshQIPy72plzpgifAp73yxX/CEKWqYoxpHtA0MFgiem74HVediMBBNBOER707LZK0ailiKHaj2qjRWFHRtd/Z4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l13154zlK9Upa/gJK0wBDXLvm3eBz++Q1uuBiQwsae8=;
 b=EKKPox1kybM6r7vWyEtM+KN7QFx4iyx5dfFiUAqMovWWRPv88jd7LjTCTWnR6CavqbOZZgQqep+LqizgZ9iexHgnRcGDCtSdmwsg0mYRe6vbcNLHM5/mLRQiR3mjpXPeVSiZpj+TiaSaKF7hbr3I29FH0qM+qvp5zIXoVOQ2slDkKTkoHiyxPrhIC3mUr2iFQ9xEqu491t8GBWKmA8hRGKTD7NLI5R2IeYcvOwNXWhEksvMnCPEMheblYG6GUIMxEIxffaA4CzRtqiyaDAYvMjMWB+C+ieKpo7wUIp0l9M/3UEdzcT7ReMHdT2AYAV2detqXbgihIY3QKSo8zF6fqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tria-technologies.com; dmarc=pass action=none
 header.from=tria-technologies.com; dkim=pass header.d=tria-technologies.com;
 arc=none
Received: from BE0P281MB0211.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:11::12)
 by FR3P281MB2283.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:36::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 13:38:07 +0000
Received: from BE0P281MB0211.DEUP281.PROD.OUTLOOK.COM
 ([fe80::98bf:b8ad:bcbf:e2d2]) by BE0P281MB0211.DEUP281.PROD.OUTLOOK.COM
 ([fe80::98bf:b8ad:bcbf:e2d2%5]) with mapi id 15.20.8398.020; Fri, 31 Jan 2025
 13:38:07 +0000
From: "Bauer, Markus" <Markus.Bauer2@tria-technologies.com>
To: Alexey Minnekhanov <alexeymin@postmarketos.org>, "u-boot-qcom@groups.io"
 <u-boot-qcom@groups.io>, Tom Rini <trini@konsulko.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Re: [PATCH 1/2] pinctrl: qcom: add sc7280 pinctrl
 driver
Thread-Topic: [External]Re: [PATCH 1/2] pinctrl: qcom: add sc7280 pinctrl
 driver
Thread-Index: AQHbcVO/KqamYQcwlEeauaPG1HGGGrMw5w0b
Date: Fri, 31 Jan 2025 13:38:07 +0000
Message-ID: <BE0P281MB021118FBFBE367DE0EC0DD83F8E82@BE0P281MB0211.DEUP281.PROD.OUTLOOK.COM>
References: <20250122-pinctrl-sc7280-v1-0-8bdba72e6366@linaro.org>
 <20250122-pinctrl-sc7280-v1-1-8bdba72e6366@linaro.org>
 <f6fd2395-07b8-4171-b4df-a57b62d51ef8@postmarketos.org>
In-Reply-To: <f6fd2395-07b8-4171-b4df-a57b62d51ef8@postmarketos.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tria-technologies.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE0P281MB0211:EE_|FR3P281MB2283:EE_
x-ms-office365-filtering-correlation-id: 382a4b71-8244-451c-21af-08dd41fc7f34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?mzmoKuCIQjWdGJf5LfTKdzexy6Ma6owDrOY5UPOywmI7XJZKGmwJnK80I0?=
 =?iso-8859-1?Q?mgYbxFUJRSIWkVl6EdMVxuinhUXRJ8bxcKeHY0zXeHCmqWILKF0GhWA6W7?=
 =?iso-8859-1?Q?y7jUckLN0kbZ7GRVcPWGmSE840wBCTlhJKsrMySIEQfUS4h3Q9IJsQLwq2?=
 =?iso-8859-1?Q?byKJdQomNFt5Jprk8ORsXl1oALZoc7QHc1Am8A78mpSpuSqiiIsMUqeiMa?=
 =?iso-8859-1?Q?Ui+mnGrPwzGwE7Yb0AagHX61ebofAhlrf8rdMXTwfZ0YQue/R4lRjKna5o?=
 =?iso-8859-1?Q?lloGpC/sXc35M6vPVn5JeZ83T0NfqE7E3fgkgu4QqvIlG8rvJgen0LmoPx?=
 =?iso-8859-1?Q?Lkplm5loYQIv/hvXtsMvT7dXi5FT42NyDPbH3Iir+X09fIbQik6BPMo/UB?=
 =?iso-8859-1?Q?DbQIiIDkamB4HAnK9wIrtTG9fjJNuIhfAEQUdmsnlpzkkTc37hioIGPGwf?=
 =?iso-8859-1?Q?lU3/DWmLuWnF+coAzKVv2BqkmxG+cVTsk/AG7fagrSWPe1HR7KYB0SILd0?=
 =?iso-8859-1?Q?ikq53n4+m0oiHQU0qWfVOrmo3JD+YQwKJtxeBxVw92QJ3cyMVnXtOWSidp?=
 =?iso-8859-1?Q?NzD88RKn/i/fYshuAo4InRowUvuP9PGP4eqNf4ko4Hug/dD7XWf1mlW/uC?=
 =?iso-8859-1?Q?upvDLWnlzNa11BKgJpxgZZ939n5+8Z2497km6oFul6Q3hKo490n6f5qcaV?=
 =?iso-8859-1?Q?WTrjFJVrl5u79VGwyBnqAvoAN8EVNiyzpw6YdFJMp4rSO0ORR24s1q/EKQ?=
 =?iso-8859-1?Q?5yyGQczd1e8j0uMfooUwnHJtTIJ05BxpV8znTznTSeJK3ffrJd/sxdpbCi?=
 =?iso-8859-1?Q?rOdbUVNmXQxV+WIWhOCsM2QzV7Wc4WrQ8k6hvtwwKG2nVl7+VlLteKZngo?=
 =?iso-8859-1?Q?Y4gJP6sKy0PrhSyGgdmw5ENAFAhmlnYeUxb+SSFFDKARY+gyG0PRwjliYJ?=
 =?iso-8859-1?Q?IzWPINpmiwOWzahkb9SNZ4WCAV8hnbnZKeMVl+jdPZVDL9vYJXvN9RZJ7K?=
 =?iso-8859-1?Q?SgNSIhFuZ5TiDwOtSKW8W4lUTs6pbwS+FcYUdmgSGGieudU5Ld+WbEUrv6?=
 =?iso-8859-1?Q?Ltot61Jw9PI2DyxMWlIC9zoCqT8uXmzu8mY6ydpQ9hI5m+GfKvaNofAhE8?=
 =?iso-8859-1?Q?HKZBbqgA2w69a7J/15g9CzwG2N8MQzt8dkJl5eJw0dL1pSVr30Pp0/xK61?=
 =?iso-8859-1?Q?Df8cypptC5877VHHfUvo7cqNB8TYiwkbrdAch/S+m2aQUqhISoacJHws2X?=
 =?iso-8859-1?Q?2lCV9fOUPOVeNFPMziTqvA3PrsV//BLkEKBAxqaYiq62/mye+tFen0emdO?=
 =?iso-8859-1?Q?jqO/REoXKsDlw1XikaFyPVCWfTPjMoqiD78G0fY2KlseWz03mXbRQAJTvt?=
 =?iso-8859-1?Q?7tz4EnwL4TMNNHUYTu6rxZclqJyVNF2etMKrIkgaIyE52dZyoFIK49z4ND?=
 =?iso-8859-1?Q?YCGEeBRf9axb6HDI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BE0P281MB0211.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HKsfX0oXxRc7NMZMl8qu14+IteeK8nUwpQgLMdVRZ9mjcIKVZsXexl83qk?=
 =?iso-8859-1?Q?/gGCBW2RPU/ghtrY8DiUVWqYBnmAPVKYdw9VofOmiUTixbTukNGIT9W+tN?=
 =?iso-8859-1?Q?iC7pe2nBVyOBDOHQeqbuAHb0WO9vRPV5YO+NKRBNnMeobaaYQVZkoj7vNx?=
 =?iso-8859-1?Q?YGXhM7S2WSniUx3wtXQWQkIAkwICBQo4JiJrxmus2RvaisBELodubmMD+5?=
 =?iso-8859-1?Q?VcGbksSA2cxpyw7GwMiVp8CZ6BLNu0RwPtoL1K2qskED9+bIOV/zSTtAlk?=
 =?iso-8859-1?Q?wMtp9IV3h68IDMZ3J6V2i5WNccbBZXz+nHUA49YsfOPnllkGIgjbdVDS/U?=
 =?iso-8859-1?Q?uZcqjL8cOXayNY6PJSMuYbHLXrasaU5N7abuSH5IqIyj+VT4qa35voGtCD?=
 =?iso-8859-1?Q?d5CER8acHlmgUz+EcKIluNYqYllX81A9EXFpOXLfX3KFQzB/f/SA8XNJXO?=
 =?iso-8859-1?Q?Xf/otNxawc+PhlP90xKDlsgRSHtM7kSqv2Jf2OI/MAXKcXkbUol/+uXbwd?=
 =?iso-8859-1?Q?rI4FTxRS2g82/SBxKwxziz9twxpmjVBIFNKzC2qXD2Ke4/xVAiQDd3kBQQ?=
 =?iso-8859-1?Q?h18FTZWGTXi39XY2cJ4X1yWmp/2W6NMZrPOh+IpxNnP01h3GFpkVGwa2Mb?=
 =?iso-8859-1?Q?JHv1G+KBucLfGKRm5meSbcCzKuAxeiARiaR9JrQlWolfFo8b3x3fh3Lw4p?=
 =?iso-8859-1?Q?lyG+9/wmNLfjKI9F2imcPR+tfWt7HqIYS6IAzFFuYU4tQmG6tLnMOIK6Z/?=
 =?iso-8859-1?Q?RYzZdc+fh96hU6UFng5dElWso2OE6rgQ2RY25kSS+c5sk0PkaQNxVmM236?=
 =?iso-8859-1?Q?rzsx3/7M/DlY1zJggxhAvedB2n6H0MpFCo7ISHdn4SOWWYLO3fx3nL5STj?=
 =?iso-8859-1?Q?KLtOPZSv8bMsRAZC+JWRPQPBIQiW2MVrfmPhMSb+cFUgSk5WLRCg9l8sKn?=
 =?iso-8859-1?Q?L8+/Gg1DgzWpDsWz6H1q89gygVeq/TmXjpso6f83uXlAdurgodpv2E8uwL?=
 =?iso-8859-1?Q?ePPlXbyQ3JdTfOww2QOLkDaWQOloKEcpz1AnYL+0UhA8DwrR0paICPOU/a?=
 =?iso-8859-1?Q?qawumMIIMRCY4xMwRzlK5JTvmtHr9tQMQxUnXAZVpAYkh/UbsLGcC50ehp?=
 =?iso-8859-1?Q?4v/kZ4r4sfVWZD1z/zBWGA7EzJ3+FKjdePzIb8jcf+jBAqP7ltbKlk7zeB?=
 =?iso-8859-1?Q?bTlR7AK+pMNSOdlGv3Ti5oJyWo2ln4/y2iGYIbqFOqkiFzfbdaBrqg/uLw?=
 =?iso-8859-1?Q?Tq1DcfZ4YDCEKmKIU0I/a+M+5UEpYXPSv+FqRViLB5r64tkF6MrSPGe1TG?=
 =?iso-8859-1?Q?ZTCftBl+gznPVI3ZmPhX1P+NplI9jjWkKb+GX28O2Un4auw+NKqwXty7XF?=
 =?iso-8859-1?Q?D6L8xuH1LSPv4V18Ekp8DVblaLskGo/E5v4AcEoZeIeNDWHIats9YkuXaO?=
 =?iso-8859-1?Q?/n4BHhv+xvcBsdZr1qq9TtppMZxCXOndlbV0XwiMfO/cOAQldlZgiYFf9l?=
 =?iso-8859-1?Q?d21Fm5xAlI8OZm7XxHY59behYz/LSXjbSOrw9EXWVRZ/VKKPve260uGTaN?=
 =?iso-8859-1?Q?jbfSnZCY8IiZ8uE1Xiv+AK7KRmuwZ9zhuGgfJcdFJc2Ifj2daLG9u0MYeF?=
 =?iso-8859-1?Q?RH89UG99izjTLTmJYbRvYWXYB16rphQC7y?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE0P281MB0211.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 382a4b71-8244-451c-21af-08dd41fc7f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 13:38:07.7535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8820279b-c0be-4bde-83ed-fe6b6f9724d5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MDfS0Wyw01t0kD2nW1fRiPgvry0KMRnLuMJEsKA4AQuIhBCjKERxLg76TPDmc4D/HxvxrjF0n24bnp4qoQDeIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2283
X-OriginatorOrg: tria-technologies.com
X-SEG-SpamProfiler-Analysis: v=2.4 cv=IM5QCRvG c=1 sm=1 tr=0 ts=679cd246
 a=JbZTrLa7QSRrUmJ1dDNrwQ==:117 a=VQcKpEElZf7cIU4YjjT1Bg==:17
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=VdSt8ZQiCzkA:10 a=FL0PnS2wD4kA:10
 a=IDoUORj9AAAA:8 a=vux94l1ldzMUCyoCRyIA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=zgiPjhLxNE0A:10 a=3GNAIP-vjoKa_dZcoIoZ:22
X-SEG-SpamProfiler-Score: 0
X-Mailman-Approved-At: Fri, 31 Jan 2025 15:13:17 +0100
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

>>=A0=A0=0A>> +config PINCTRL_QCOM_SC7280=0A>> +=A0=A0=A0=A0 bool "Qualco=
mm SC7280/QCM6490 GCC"=0A>> +=A0=A0=A0=A0 select PINCTRL_QCOM=0A>=0A>Hi!=0A=
>=0A>And again, no, this is not GCC, this block is called TLMM.=0A>GCC is=
=20for clock controller.=0A=0AHi!=0A=0AThis is correct.=0AI tested the pi=
nctrl driver, it needed some changes but now I have SD-card support in my=
=20U-Boot - this also required some additional clock updates.=0ASince I h=
ave not contributed to U-Boot / Linux mailing list much, I have some ques=
tion how to proceed.=0A=0A1. Create whole new commit for this, or "rebase=
" original patch and update it?=0A2. Regarding the clock stuff, making th=
is an extra commit? I'd say yes...=0A=0Athank you,=0A=0A--=0AMarkus Bauer=
=0Awww.tria-technologies.com=0A=0A
We continuously commit to comply with the applicable data protection laws=
=20and ensure fair and transparent processing of your personal data.=20
Please read our privacy statement including an information notice and dat=
a protection policy for detailed information on our website.
