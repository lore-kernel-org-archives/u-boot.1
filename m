Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58429E776F0
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 16:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29D68838A0;
	Wed, 24 Dec 2025 17:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="XiHO4zmY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7673184295; Wed, 24 Dec 2025 16:47:39 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3445D84261
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 16:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyTBkulAvPdU/1/JzmumAhWq+aUmbp5cT+n7Xnpno9tdlgXirYItXjTVI9QrOgIFpJbJtPYUQLg8/HGXLriRbhPFj+YWSyJ4aJQ3ulClFZkh3JWW/Xq8yfYQlH4H0rrYFOZuNkNKTTwUKQKir/I0F3GIXVDOzJerFfQmJ3vtNID4BA44Wc2B70oaVm7x/0XmfrC+ghi310yF+/4hgbpOHTL0tu2JmSjlBbHLxUmAMwyZr0rIboOQRrg0H3sdHchjABmHcrE7qmSkX/vnQGDx2nwGQIZ0jjhS69ygVgb1ae128uafS5ah+P+sGKEtaTwu+0SZa4LRn+cbPzWQxdaZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhjFl8EvmJKkxyYOIvLAYwDUeZ07nVl81fnEdtOZFMg=;
 b=RQ9pVRnmFvAnS+JqafVGZi1B60eVO4jRLjGMKexs/r/Gs8j3M7J/w2ID7lJlBiuXiXseQXws8974dEMGyH0oPHJsfIBhvtCbXsYVc82ToikqqGtCUjDuLw2XWOqWoUFlLhEyYTIWEoN4CBGIPxV0TfsEUGWzuYPjy9BF4XOAkUJpyrJHZjXhfjw4diIn3/z7Lvj/Bs/Hl6lu1LCLFGtiIGbQBfscI90aWpp9+ZeFp2iCniPJKV2HoKDLd6LHb0NKSUsfHoK6BJXyRG3NE7gM/DmGsjsdOXi7/THs6OSHGU15kaELOeePhMcfRNb85KBcZ3SnuuxmjtOEIBnaZbPcDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhjFl8EvmJKkxyYOIvLAYwDUeZ07nVl81fnEdtOZFMg=;
 b=XiHO4zmYROk22bYKY/wlFlYJYTM9TIsdc37mlUU2i/7sdj3i5adB4JO2Uw8UknTW4K8hQSnBubrbyYQ5vrQNgF1JmKZ6h0MQfNNZjClvufGJZMi5X9JNF4kpxSWwMYztJTHbWPFgi+LsIIyQFY7xmHjYrFXpdTzMvzMOZmHrdVbAoz8t5Nxo+7Q4IDfL/0116Y82ne/dFNA1aG+zLTHcsxRQxbuL+bdD73WuXYnBuyZ0kw/Bbbrkp389pXEa4esmNkzIusi/cpx8Z5l3kW4OxtL/V0/jmkZuu6N7cSYREiXC9trgHaTeh+n2ECGLbqT8l278/s6uqexkGqmTuje1Mg==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by PA3PR09MB8195.eurprd09.prod.outlook.com (2603:10a6:102:4ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Wed, 24 Dec
 2025 15:47:36 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 15:47:36 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v5 8/8] riscv: p8700: Add Coherence Manager (CM) and IOCU
 support
Thread-Topic: [PATCH v5 8/8] riscv: p8700: Add Coherence Manager (CM) and IOCU
 support
Thread-Index: AQHcdOygIkI59dBWmU+mP/IWRiuTZQ==
Date: Wed, 24 Dec 2025 15:47:36 +0000
Message-ID: <20251224154449.946780-9-uros.stajic@htecgroup.com>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
In-Reply-To: <20251224154449.946780-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|PA3PR09MB8195:EE_
x-ms-office365-filtering-correlation-id: 6c78006e-9c33-43b9-9611-08de4303c28b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?VLSvKJYu3MgxELWPBKQE0qgwe0sGiwNnznbLbjygwD1xgNKzPAYtvQjz1v?=
 =?iso-8859-1?Q?KQqwS9A1+su3NxxbdYMnOGBvwKG6I+Blee7vhWrtEiK2Ii/r9rtacrasSG?=
 =?iso-8859-1?Q?ZkVCrq4zZt8TVzZKRuAaMjCdRIU1wqMcgcZs3KhANVfbRC6Y3YyskHhMMS?=
 =?iso-8859-1?Q?3T6Fdv8h0v3RlkY2MwNyiRvCaIaOzjHV3wYysUezU7i86KTXPW464F5JtE?=
 =?iso-8859-1?Q?UbmyEZA5xsaCahfokzqwf895/3ESdezxZAQSujH0idbTAzea4TqSklAwTi?=
 =?iso-8859-1?Q?LMI4qa3ecxP0I5FQvrt61aT5MtnYN6iY8IQIBEeHW6OgXBZIG9WXp1pb/q?=
 =?iso-8859-1?Q?eea10Mnip0lweAJpzELM+kT1KDeZPxt716Hc1AxHNkd3h1Pz7rU8p24+k+?=
 =?iso-8859-1?Q?2B4scztfFAeBngubdlNkyMXDBf6tf0IfLVO6bP1dYr1eBRoDJD+WFBTCv2?=
 =?iso-8859-1?Q?89qJVq3LKWRnWsLgIb0gfDKdYVFVTSZm9B1AUx9xPpY+qG4ppBXQTmztfq?=
 =?iso-8859-1?Q?YfizfPdeEZHHs7YBa5B73bBayAI7kUAATzk1oKLVQrSfphl+cuSPJr85oW?=
 =?iso-8859-1?Q?OzP8BZPo0ariAdZq7oupm6kqKP4jrCEkBiLvWvwCtZcqnBfO5UYc7pdHax?=
 =?iso-8859-1?Q?1qXMBZSvsBxkPKrNlWumuX88squiHVpaIcmQdpeqmRm/g5ntcO6OBxwOkG?=
 =?iso-8859-1?Q?f2mArolkKw//F1Dcx2+gbAGyETaWK4arnWwGyk3VYTSCT8XnkyJEMVju6U?=
 =?iso-8859-1?Q?yo8lR9hwgfoc6qWLwKe3vrNk+lrfpFEayC0+m6JFIsFRIBPIC2yap/UpRE?=
 =?iso-8859-1?Q?aCvUFpvLuDy/MHYMcwu2DTVDHoj8OoRV77Em3F799fabPOgDsndoCLLQb/?=
 =?iso-8859-1?Q?F+XUgAKXUkKsrpRP21rJIGfxDE28D65U5J3SoYU/Wx+SLwY2SThs6prS4r?=
 =?iso-8859-1?Q?bDoo1yaCJqJS52aeAv9GIr3fdeCBLri1Izbrmw5aA+68ipwl61uhfbWEJs?=
 =?iso-8859-1?Q?wquop6FjpovTjlXugZRdqZJH+bDRooo8OueClGugQjRRGlsbxR5AgPt1Cx?=
 =?iso-8859-1?Q?Z3NZ23+kLZld5lMPKq713X5bGYib9ClZX5r0fQc2oH9dAX/vEB9V0tE0rN?=
 =?iso-8859-1?Q?2/xbWU0o8LE72k8L4n1Fqwjo81/ppOHsLbQsQ2v1y0mC2Ucgb3GXvHdump?=
 =?iso-8859-1?Q?X6LXLqYyxBpBpafvuMIgAHFb9j1kK4oGI0cYZKPVPkIlYVmltFf+oJZZVU?=
 =?iso-8859-1?Q?XcxDve1tYPWej+yy3FfqNeVFkCy9i+qMOpCt6jkD9K3cM3KC25oIZPp5Tz?=
 =?iso-8859-1?Q?XVCi99i+JFlMlyAkZs2md7qJbUscui2Y58d8PNz3CmiA155WiotCGNRLCj?=
 =?iso-8859-1?Q?HnRQAaQHUdSfAsrnlfJSTGpDcCehuzCKEJT0v89jDbEz/XylSX3U9Ldrxa?=
 =?iso-8859-1?Q?C+KvMUEzi+Atzcp/MhNoSQ+51tLgsUwBMDp/PMUO0Jv+t6reyTRwZgCHqW?=
 =?iso-8859-1?Q?84zCptVQ0B7dF97Qr59wKoV4ZjaI8fpfyNf73Gf6wrTCV9c3rZIr97U4l2?=
 =?iso-8859-1?Q?XbntPmPtHPIdua4RzyRZY1E1AZPu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?r4sAeF1POjtaoIEaK8Yf0QaW3+73vbKHtxatCL1LcTy5NBMsypbM+nyNAW?=
 =?iso-8859-1?Q?SbAI31IN3rsJrTmsILM3u7qku1GEZW8WQw8GZzc6i7QoO/tMnfXkKV+t6p?=
 =?iso-8859-1?Q?PQhWLmnOv85dYD/w0H3PoVsopzMXCNbqKeh52Tc+QZhK3bIdG9sc/MkMcw?=
 =?iso-8859-1?Q?sfzd8MnBwJv6/Tj+3WTJqa8q/mlIFSN53fmrnxF6tV8Sfg+2En4OI3oJN2?=
 =?iso-8859-1?Q?9PYvjhbyP+nQ+eKFFD5k/qCkr8l/KUK4sROmfz70g9LXpUOnZ6IIgYuFW4?=
 =?iso-8859-1?Q?n/qIN36Z0uw7tPkCSpTTuPPTIsyVUHTln6WocG5Z15lxut0vRFTu4Cgql8?=
 =?iso-8859-1?Q?CIp8hfvsSUCUth6r29finNbBKd2w9N8coXfw/my/LSNgGFb+psbxaCDUXk?=
 =?iso-8859-1?Q?VRHNZnh4GP3Bv0B8qieKcGDYfufkjgB3YDcOF8lMtlkYBoFWUR1hlHp3Kn?=
 =?iso-8859-1?Q?HjOjuXQfjiOqne4rlkT9jyfxg52xncVA3NIB/e1jTVAnCV5o+mcARNDfem?=
 =?iso-8859-1?Q?2NPcsanBT6S2BBTvGLfa3d64V8VVYaLBAwxpjZMiGEPMVohfreg0M6D/0l?=
 =?iso-8859-1?Q?tV0SjEzj7+mARCaUaxXD9vC065fYmt9NHzDdAKPYwAIFFGkSsTnQDVKodJ?=
 =?iso-8859-1?Q?6PHDwLef+AFmmC9MObgwmetQCKbXVEq4jmnUPQz+nY/aRSTv3SXPQQLeON?=
 =?iso-8859-1?Q?LTaSsg3oX5ds6aRSkiSmYzOpL8HNnwrYtYNEf0uzvPlVSsetzMS+G2PbIK?=
 =?iso-8859-1?Q?9a8+CT6bgtNAhR2mHHoES24fQBmfxjPjQ2nTvtHrvMLXeV10NYZshONsK1?=
 =?iso-8859-1?Q?pO1Wn0CAqRYZkUQAGE6vVp+UHbV9XWblwrRmCLxrs/gP5HNrj3hhzRqvXc?=
 =?iso-8859-1?Q?0KUsl0WvsczLgD5r/s93n56+5tlfZwwpWAxtfSifQrf4flIhy1eQpF+Ew1?=
 =?iso-8859-1?Q?tWts1fN2uxtlmkfzf1gfPCf80RRlVj14YFu+XT6U5WuAmAga9oASOyXk7B?=
 =?iso-8859-1?Q?dK8iwF3BxfbkataAntpTTm9T3znZAj+rF2vY3IOPZ868yKVvI9j7v/jnwf?=
 =?iso-8859-1?Q?QGzOHOUvpmx2oMM71h8hBIWTzSsKvl1vAubDXAL/yPXOAMk6iPien8t14t?=
 =?iso-8859-1?Q?SEFVpWdoKNH7F5wdndVBObohnPTOr3ZFGyymUaL9tRzu3scYpDd4hGWawa?=
 =?iso-8859-1?Q?X2KUW+RWyOeiiyXBVMVaX5tOT1X7KJ+cm+Iuq1xC1qZx5J3Xr2QF0CO+/k?=
 =?iso-8859-1?Q?e+XT7jRPGHkpm3fCQ+C6tD7h3EuFRgLyXIFVGlu6Q44EXOA/WdtBrypEhR?=
 =?iso-8859-1?Q?Euy45Y1TmRsHxm7WCd/wMOCFMowamXIjHpkAajHhlO8fhpa3BVwrbM387O?=
 =?iso-8859-1?Q?31OCSi9FeYfUWrnpYUEEeS2GBUF+NAjyISQkSDLgIPC/67OEL8Y13sKukR?=
 =?iso-8859-1?Q?mvNhkRbH1X/ezbKFw4/H9JqiGx7Wbj8zqST9llip0SFzOH1ZkpQFCTlDjQ?=
 =?iso-8859-1?Q?ge7/Hj0yKM/TS/G97Y8J/Yh9VVJpsSWBuPg6j3JT4ARjHOoh2phWdscs3D?=
 =?iso-8859-1?Q?LIgTCYijMtVIj+n9ymSkeGAQCZCahQk/FwGlXfXT9BPZGgh1GMBRQLiZDo?=
 =?iso-8859-1?Q?qHwHzwn+c7TSPa1I561ku/zSkM1cc4licGCb8mesr4B3JLekdJlfk2qptu?=
 =?iso-8859-1?Q?9OQDoIrqsmRajmeoI1n6jI48xSEQYNoW2mx2pFeYuvQhuv982mpdEMGnaO?=
 =?iso-8859-1?Q?+U7Vgof5LBUtsFWGF92iDEsbIO/NBITmHQfgdUneDtw973tYlAeJtY2qhE?=
 =?iso-8859-1?Q?SjOK1YkzhfuAARv1CMGHI1qTTgSL+7o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c78006e-9c33-43b9-9611-08de4303c28b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 15:47:36.0069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zc7rELeWWx41VWOzKHiPdx2TuXdDHHIoGdHRlyPFZY/FpVGSfs5eAFPwLEh+6+XUxs1gX9CdS3hMUdzThFvGHGJNQ/8n2M70fSU6fBgpHKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR09MB8195
X-Mailman-Approved-At: Wed, 24 Dec 2025 17:41:15 +0100
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

Add support for Coherence Manager (CM) and IOCU discovery and
configuration on the P8700 platform.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 arch/riscv/cpu/p8700/Makefile             |   3 +
 arch/riscv/cpu/p8700/cache.c              |   6 ++
 arch/riscv/cpu/p8700/cm-iocu.c            |  75 ++++++++++++++++
 arch/riscv/cpu/p8700/cm.c                 |  92 +++++++++++++++++++
 arch/riscv/cpu/p8700/p8700.c              |  21 +++++
 arch/riscv/include/asm/arch-p8700/cm.h    |  61 +++++++++++++
 arch/riscv/include/asm/arch-p8700/p8700.h |  35 ++++++++
 arch/riscv/include/asm/global_data.h      |   4 +
 board/mips/boston-riscv/Makefile          |   1 +
 board/mips/boston-riscv/iocu.c            | 102 ++++++++++++++++++++++
 10 files changed, 400 insertions(+)
 create mode 100644 arch/riscv/cpu/p8700/cm-iocu.c
 create mode 100644 arch/riscv/cpu/p8700/cm.c
 create mode 100644 arch/riscv/cpu/p8700/p8700.c
 create mode 100644 arch/riscv/include/asm/arch-p8700/cm.h
 create mode 100644 board/mips/boston-riscv/iocu.c

diff --git a/arch/riscv/cpu/p8700/Makefile b/arch/riscv/cpu/p8700/Makefile
index 32c5e2dce21..45f68bbda3d 100644
--- a/arch/riscv/cpu/p8700/Makefile
+++ b/arch/riscv/cpu/p8700/Makefile
@@ -3,5 +3,8 @@
 # Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
=20
 obj-y +=3D cache.o
+obj-y +=3D cm.o
+obj-y +=3D cm-iocu.o
 obj-y +=3D cpu.o
 obj-y +=3D dram.o
+obj-y +=3D p8700.o
diff --git a/arch/riscv/cpu/p8700/cache.c b/arch/riscv/cpu/p8700/cache.c
index 7559c688321..df6e6c9663e 100644
--- a/arch/riscv/cpu/p8700/cache.c
+++ b/arch/riscv/cpu/p8700/cache.c
@@ -48,6 +48,9 @@ static void probe_cache_config(void)
=20
 void flush_dcache_range(unsigned long start, unsigned long end)
 {
+	if (p8700_dma_is_coherent())
+		return;
+
 	if (lsize =3D=3D 0)
 		probe_cache_config();
=20
@@ -71,6 +74,9 @@ void flush_dcache_range(unsigned long start, unsigned lon=
g end)
=20
 void invalidate_dcache_range(unsigned long start, unsigned long end)
 {
+	if (p8700_dma_is_coherent())
+		return;
+
 	if (lsize =3D=3D 0)
 		probe_cache_config();
=20
diff --git a/arch/riscv/cpu/p8700/cm-iocu.c b/arch/riscv/cpu/p8700/cm-iocu.=
c
new file mode 100644
index 00000000000..5850647d20f
--- /dev/null
+++ b/arch/riscv/cpu/p8700/cm-iocu.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MIPS Coherence Manager (CM) Support
+ *
+ * Copyright (c) 2016 Imagination Technologies Ltd.
+ */
+#include <asm/io.h>
+#include <asm/global_data.h>
+#include <asm/arch-p8700/cm.h>
+
+__weak bool plat_iocu_usable(unsigned int cluster, unsigned int iocu)
+{
+	return true;
+}
+
+static int init_cluster_iocus(unsigned int cluster)
+{
+	DECLARE_GLOBAL_DATA_PTR;
+	void __iomem *global_gcrs;
+	u32 cfg, num_iocus, num_iocus_usable, local_cluster;
+	int i;
+
+	local_cluster =3D mips_cluster_id();
+
+	global_gcrs =3D mips_cm_base();
+	if (cluster !=3D local_cluster) {
+		// FIXME
+		return 1;
+	}
+
+	cfg =3D __raw_readl(global_gcrs + GCR_CONFIG);
+	num_iocus =3D cfg >> GCR_CONFIG_NUMIOCU_SHIFT;
+	num_iocus &=3D GCR_CONFIG_NUMIOCU_MASK;
+	gd->arch.num_iocus +=3D num_iocus;
+
+	/* Discover how many IOCUs are usable */
+	num_iocus_usable =3D num_iocus;
+	for (i =3D num_iocus - 1; i >=3D 0; i--) {
+		if (!plat_iocu_usable(cluster, i))
+			num_iocus_usable--;
+	}
+	gd->arch.num_iocus_usable +=3D num_iocus_usable;
+
+	/* If the cluster has no usable IOCUs there's nothing to do */
+	if (num_iocus_usable =3D=3D 0) {
+		if (cluster !=3D local_cluster)
+			power_down_cluster(cluster);
+
+		return 0;
+	}
+
+	/* If the IOCUs are in the local cluster we're good to go already */
+	if (cluster =3D=3D local_cluster)
+		return 0;
+
+	/* Ensure that the cluster's L2 cache is initialised */
+	return init_cluster_l2(cluster);
+}
+
+int mips_cm_init_iocus(void)
+{
+	DECLARE_GLOBAL_DATA_PTR;
+	unsigned int cluster;
+	int err;
+
+	for (cluster =3D 0; cluster < mips_cm_num_clusters(); cluster++) {
+		err =3D init_cluster_iocus(cluster);
+		if (err) {
+			gd->arch.num_iocus_usable =3D err;
+			return 0;
+		}
+	}
+
+	return 0;
+}
diff --git a/arch/riscv/cpu/p8700/cm.c b/arch/riscv/cpu/p8700/cm.c
new file mode 100644
index 00000000000..ce7485c564d
--- /dev/null
+++ b/arch/riscv/cpu/p8700/cm.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MIPS Coherence Manager (CM) Support
+ *
+ * Copyright (c) 2016 Imagination Technologies Ltd.
+ */
+
+#include <asm/io.h>
+#include <asm/arch-p8700/cm.h>
+#include <asm/arch-p8700/p8700.h>
+
+static void mips_cpc_init(void)
+{
+}
+
+__weak const struct mmio_region *get_mmio_regions(void)
+{
+	return NULL;
+}
+
+static void p8700_setup_mmio_limits(void)
+{
+	void __iomem *gcrs =3D mips_cm_base();
+	const struct mmio_region *rgn =3D get_mmio_regions();
+	unsigned int num_clusters =3D mips_cm_num_clusters();
+	unsigned int limit =3D MIPS_CM_MMIO_LIMIT / num_clusters;
+	unsigned int i, reg_off;
+
+	if (!rgn)
+		return;
+
+	if (num_clusters !=3D 1) {
+		// FIXME! Need to support multiple clusters.
+		return;
+	}
+
+	reg_off =3D GCR_MMIO0_BOTTOM;
+
+	for (i =3D 0; rgn[i].addr_high; i++) {
+		__raw_writeq(rgn[i].addr_high & GCR_MMIO0_TOP_ADDR,
+			     gcrs + reg_off + (GCR_MMIO0_TOP - GCR_MMIO0_BOTTOM));
+
+		__raw_writeq((rgn[i].addr_low & GCR_MMIO0_BOTTOM_ADDR) |
+			     (rgn[i].port << GCR_MMIO0_BOTTOM_PORT_SHIFT) |
+			     (rgn[i].enable ? GCR_MMIO0_BOTTOM_ENABLE : 0),
+			     gcrs + reg_off);
+		reg_off +=3D GCR_MMIO1_BOTTOM - GCR_MMIO0_BOTTOM;
+	}
+
+	__raw_writel(limit, gcrs + GCR_MMIO_REQ_LIMIT);
+}
+
+int power_up_cluster(unsigned int cluster)
+{
+	return 0;
+}
+
+int power_down_cluster(unsigned int cluster)
+{
+	return 0;
+}
+
+int init_cluster_l2(unsigned int cluster)
+{
+	return 0;
+}
+
+int mips_cm_init(void)
+{
+	int err;
+
+	mips_cpc_init();
+
+	err =3D mips_cm_init_iocus();
+	if (err)
+		return err;
+
+	p8700_setup_mmio_limits();
+
+	return 0;
+}
+
+int arch_cpu_init(void)
+{
+	int err;
+
+	err =3D mips_cm_init();
+	if (err)
+		return err;
+
+	return 0;
+}
diff --git a/arch/riscv/cpu/p8700/p8700.c b/arch/riscv/cpu/p8700/p8700.c
new file mode 100644
index 00000000000..18f30d10c19
--- /dev/null
+++ b/arch/riscv/cpu/p8700/p8700.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ */
+
+#include <asm/io.h>
+#include <linux/types.h>
+#include <asm/arch-p8700/p8700.h>
+
+#define BOSTON_IOCU_NOC_OFFSET	0x10
+
+bool p8700_dma_is_coherent(void)
+{
+	u32 pcie0_off =3D readl((void __iomem *)BOSTON_PLAT_NOCPCIE0ADDR);
+	u32 pcie1_off =3D readl((void __iomem *)BOSTON_PLAT_NOCPCIE1ADDR);
+	u32 pcie2_off =3D readl((void __iomem *)BOSTON_PLAT_NOCPCIE2ADDR);
+
+	return pcie0_off =3D=3D BOSTON_IOCU_NOC_OFFSET &&
+	       pcie1_off =3D=3D BOSTON_IOCU_NOC_OFFSET &&
+	       pcie2_off =3D=3D BOSTON_IOCU_NOC_OFFSET;
+}
diff --git a/arch/riscv/include/asm/arch-p8700/cm.h b/arch/riscv/include/as=
m/arch-p8700/cm.h
new file mode 100644
index 00000000000..ab5ea7385b2
--- /dev/null
+++ b/arch/riscv/include/asm/arch-p8700/cm.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ */
+
+#ifndef __P8700_CM_H__
+#define __P8700_CM_H__
+
+#include <asm/arch-p8700/p8700.h>
+
+struct mmio_region {
+	phys_addr_t addr_low;
+	phys_addr_t addr_high;
+	unsigned int port : 4;
+	unsigned int enable : 1;
+};
+
+const struct mmio_region *get_mmio_regions(void);
+
+void setup_redirect(unsigned int cluster, unsigned int core,
+		    unsigned int vp, unsigned int block);
+
+int mips_cm_init_iocus(void);
+
+int power_up_cluster(unsigned int cluster);
+int power_down_cluster(unsigned int cluster);
+int init_cluster_l2(unsigned int cluster);
+
+static inline void *mips_cm_base(void)
+{
+	return (void *)CM_BASE;
+}
+
+static inline void *mips_cpc_base(void)
+{
+	return (void *)CPC_BASE;
+}
+
+static inline unsigned int mips_cm_num_clusters(void)
+{
+	u32 cfg;
+
+	cfg =3D __raw_readl(mips_cm_base() + GCR_CONFIG);
+	cfg >>=3D GCR_CONFIG_NUMCLUSTERS_SHIFT;
+	cfg &=3D GCR_CONFIG_NUMCLUSTERS_MASK;
+
+	return cfg;
+}
+
+static inline unsigned int mips_cluster_id(void)
+{
+	u32 temp;
+
+	asm volatile("csrr %0, mhartid" : "=3Dr"(temp));
+	temp >>=3D MHARTID_CLUSTER_SHIFT;
+	temp &=3D MHARTID_CLUSTER_MASK;
+
+	return temp;
+}
+
+#endif /* __P8700_CM_H__ */
diff --git a/arch/riscv/include/asm/arch-p8700/p8700.h b/arch/riscv/include=
/asm/arch-p8700/p8700.h
index 5ca9b4b9497..0b864afb635 100644
--- a/arch/riscv/include/asm/arch-p8700/p8700.h
+++ b/arch/riscv/include/asm/arch-p8700/p8700.h
@@ -65,6 +65,10 @@
 #define CM_BASE			0x16100000
 #define CPC_BASE		(CM_BASE + 0x8000)
=20
+/* Block offsets */
+#define GCR_OFF_GLOBAL		0x0000
+#define GCR_OFF_LOCAL		0x2000
+
 /* CPC Block offsets */
 #define CPC_OFF_LOCAL		0x2000
=20
@@ -75,6 +79,33 @@
 #define CPC_Cx_CMD		0x0000
 #define CPC_Cx_CMD_RESET	0x4
=20
+/* GCR_CONFIG */
+#define GCR_CONFIG						0x0000
+#define GCR_REV							0x0030
+#define GCR_CONFIG_NUMCLUSTERS_SHIFT	23
+#define GCR_CONFIG_NUMCLUSTERS_MASK	    0x7f
+#define GCR_CONFIG_NUMIOCU_SHIFT	    8
+#define GCR_CONFIG_NUMIOCU_MASK		    0xf
+#define GCR_CONFIG_NUMCORES_SHIFT	    0
+#define GCR_CONFIG_NUMCORES_MASK	    0xff
+
+/* GCR_REV CM versions */
+#define GCR_REV_CM3			0x0800
+#define GCR_REV_CM3_5		0x0900
+
+#define GCR_MMIO_REQ_LIMIT				0x06f8
+#define GCR_MMIO0_BOTTOM				0x0700
+#define GCR_MMIO0_BOTTOM_ADDR			(0xffffffffull << 16)
+#define GCR_MMIO0_BOTTOM_PORT_SHIFT		2
+#define GCR_MMIO0_BOTTOM_PORT			(0xf << 2)
+#define GCR_MMIO0_BOTTOM_DISABLE_LIMIT	(0x1 << 1)
+#define GCR_MMIO0_BOTTOM_ENABLE			(0x1 << 0)
+#define GCR_MMIO0_TOP					0x0708
+#define GCR_MMIO0_TOP_ADDR				(0xffffffffull << 16)
+#define GCR_MMIO1_BOTTOM				0x0710
+
+#define MIPS_CM_MMIO_LIMIT	4
+
 #define P8700_GCR_C0_COH_EN	0x20f8
 #define P8700_GCR_C1_COH_EN	0x21f8
 #define P8700_GCR_C2_COH_EN	0x22f8
@@ -107,4 +138,8 @@
 #define BOSTON_PLAT_NOCPCIE1ADDR        (BOSTON_PLAT_BASE + 0x40)
 #define BOSTON_PLAT_NOCPCIE2ADDR        (BOSTON_PLAT_BASE + 0x44)
=20
+#ifndef __ASSEMBLY__
+bool p8700_dma_is_coherent(void);
+#endif /* __ASSEMBLY__ */
+
 #endif /* __P8700_H__ */
diff --git a/arch/riscv/include/asm/global_data.h b/arch/riscv/include/asm/=
global_data.h
index 33f2b5ec5c8..198eacd1e07 100644
--- a/arch/riscv/include/asm/global_data.h
+++ b/arch/riscv/include/asm/global_data.h
@@ -44,6 +44,10 @@ struct arch_global_data {
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
 	struct resume_data *resume;
+#if CONFIG_IS_ENABLED(P8700_RISCV)
+	int num_iocus;
+	int num_iocus_usable;
+#endif
 };
=20
 #include <asm-generic/global_data.h>
diff --git a/board/mips/boston-riscv/Makefile b/board/mips/boston-riscv/Mak=
efile
index 0615c677d23..c67c001d4e6 100644
--- a/board/mips/boston-riscv/Makefile
+++ b/board/mips/boston-riscv/Makefile
@@ -4,5 +4,6 @@
=20
 obj-y +=3D boston-riscv.o
 obj-y +=3D checkboard.o
+obj-y +=3D iocu.o
 obj-y +=3D lowlevel_init.o
 obj-y +=3D reset.o
diff --git a/board/mips/boston-riscv/iocu.c b/board/mips/boston-riscv/iocu.=
c
new file mode 100644
index 00000000000..807f09804a3
--- /dev/null
+++ b/board/mips/boston-riscv/iocu.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2016 Imagination Technologies Ltd.
+ */
+
+#include "boston-regs.h"
+#include <dm.h>
+#include <env_callback.h>
+#include <event.h>
+#include <asm/io.h>
+#include <asm/arch-p8700/cm.h>
+
+static const struct mmio_region mmio_regions[] =3D {
+	{ 0x10000000, 0x160f0000, .enable =3D 1 },
+	{ 0x17ff0000, 0x17ff0000, .enable =3D 1 },
+	{ 0 },
+};
+
+const struct mmio_region *get_mmio_regions(void)
+{
+	return mmio_regions;
+}
+
+static int set_io_coherent(bool coherent)
+{
+	DECLARE_GLOBAL_DATA_PTR;
+
+	if (!coherent) {
+		printf("I/O:   Non-Coherent (Forced by environment)\n");
+		goto noncoherent;
+	}
+
+	if (gd->arch.num_iocus_usable < 0) {
+		printf("I/O:   Non-Coherent (IOCU init error %d)\n",
+		       gd->arch.num_iocus_usable);
+		goto noncoherent;
+	}
+
+	if (gd->arch.num_iocus =3D=3D 0) {
+		printf("I/O:   Non-Coherent (No IOCU)\n");
+		goto noncoherent;
+	}
+
+	if (gd->arch.num_iocus_usable =3D=3D 0) {
+		printf("I/O:   Non-Coherent (IOCU not connected)\n");
+		goto noncoherent;
+	}
+
+	/*
+	 * We have some number of connected IOCUs. Map all PCIe DMA access to
+	 * hit the IOCU by offsetting the addresses as they pass from the PCIe
+	 * controller to the NoC.
+	 */
+	writel(0x10, (u32 *)BOSTON_PLAT_NOCPCIE0ADDR);
+	writel(0x10, (u32 *)BOSTON_PLAT_NOCPCIE1ADDR);
+	writel(0x10, (u32 *)BOSTON_PLAT_NOCPCIE2ADDR);
+
+	printf("I/O:   Coherent\n");
+	return 0;
+
+noncoherent:
+	/* Map all PCIe DMA access to its default, non-IOCU, target */
+	writel(0x00, (u32 *)BOSTON_PLAT_NOCPCIE0ADDR);
+	writel(0x00, (u32 *)BOSTON_PLAT_NOCPCIE1ADDR);
+	writel(0x00, (u32 *)BOSTON_PLAT_NOCPCIE2ADDR);
+=09
+	return 0;
+}
+
+static int on_io_coherent(const char *name, const char *value,
+			  enum env_op op, int flags)
+{
+	switch (op) {
+	case env_op_create:
+	case env_op_overwrite:
+		if (!strcmp(value, "0")) {
+			set_io_coherent(false);
+		} else if (!strcmp(value, "1")) {
+			set_io_coherent(true);
+		} else {
+			printf("### io.coherent must equal 0 or 1\n");
+			return -EINVAL;
+		}
+		return 0;
+
+	case env_op_delete:
+		set_io_coherent(true);
+		return 0;
+
+	default:
+		return 0;
+	}
+}
+
+U_BOOT_ENV_CALLBACK(io_coherent, on_io_coherent);
+
+static int p8700_misc_init_f(void)
+{
+	return set_io_coherent(env_get_yesno("io.coherent") !=3D 0);
+}
+
+EVENT_SPY_SIMPLE(EVT_MISC_INIT_F, p8700_misc_init_f);
--=20
2.34.1
