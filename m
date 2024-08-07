Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC7AC52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 13:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1432A88BC2;
	Wed,  7 Aug 2024 15:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.b="kTafUxMj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25F4988B67; Wed,  7 Aug 2024 04:20:35 +0200 (CEST)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com
 [185.183.30.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCF9988599
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 04:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=JianfengA.Zhu@sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47720OBC012887;
 Wed, 7 Aug 2024 02:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=S1; bh=V7oKSov2VZMBwR9zM4pSc2VDiKEoM
 kZ1RGzCCjc9Z2I=; b=kTafUxMjdU7x0Dg8H4Z8F36OeMxP2V31fnkZBVYE4j/Sq
 IpvNV7aso8sJ6+LzVW/qqeAkue8vAa5eEgpNNfLvWaM3y7VdeVhHqZplOGXSN+gE
 Zcu2Sf/AdbWelrZbF6YfLQsU3pruVAtE6uT/fAcVX3otfJL6b3+SZAypGxaiFHib
 Ju2/IsytXsZHbKxOz/FXHanrv/qdbTiQNphuhCmRDYrJz6HulVCPspW+xJzwZ86k
 4uB65jy43vqbBoZGysskd8gA5jMas8FmngMCc7XCCaDtP6Yml905Vi71Pjh+97ZX
 kb1vdx6fdCSn4kpZHDhafqRKqiqS0XviWpC6Xjdcg==
Received: from apc01-sg2-obe.outbound.protection.outlook.com
 (mail-sgaapc01lp2112.outbound.protection.outlook.com [104.47.26.112])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 40sbvxk2jp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Aug 2024 02:20:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8OC6PLGNxWvkTqeYiewe4ii4KLLEHvhAFiAMsa2pPim2iqklL1GthhuCqJDJtSBT0jksDdUz57j45MdJ6YK5ZfIK3yW8IuvT2zzXH92iThv8lfE28g67Z2T6XoXmaE+QyaoFuAmgESkob59cXpTDgRSeAFAeGuGnnaHvhzUeTSb34rPiQSCE75OF8hdrEIK5gfD/jm/mCLLjztXS2kZDeM+g3A+d2CufN26+3s/Gq/z7on4mHjRIjIIhwVmjUAUNKrvQWGsWqaYulg6alzO+Ru6jLJXwMR5DE9c0KOYmoVI92BHxnl1iWoGhRTANjWw0Gw2zC2rubxUuxen+bwahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7oKSov2VZMBwR9zM4pSc2VDiKEoMkZ1RGzCCjc9Z2I=;
 b=mr0hdO95CaYDxwvtdIH2mowTJ6Nz6zJNcfE3aMa6cXWoapuGQBMW6j0YRgpTcqJxpcTrbHQNK3pjpqOka6gTTEJGEgbMERRt38PLR4trrV3l9H3L1KptStXyt5TTtTi31AOraAq2chUQqSB6Phoc5OihAKOPMPzEVQHBwz0Grmx8PV4Gk3Dzr/YKb95i4hDeLnK6am9YdvL7BlrXRkJPGx7tDCRzAsoVQvGOyZ6OxaKhN37MvHsN9+6Gz+QlApds8RDrM1t/xSm2531noDBC/UKgdBzNbZIdTAxi9humAttmHtSWCzvhMZOf3WHK4Ogo5Y1azmHsSn9A5x5FE5go4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from OSQPR04MB7740.apcprd04.prod.outlook.com (2603:1096:604:283::6)
 by SEYPR04MB7756.apcprd04.prod.outlook.com (2603:1096:101:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.9; Wed, 7 Aug
 2024 02:20:07 +0000
Received: from OSQPR04MB7740.apcprd04.prod.outlook.com
 ([fe80::7c06:41d9:f38c:e1bd]) by OSQPR04MB7740.apcprd04.prod.outlook.com
 ([fe80::7c06:41d9:f38c:e1bd%4]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 02:20:07 +0000
From: "JianfengA.Zhu@sony.com" <JianfengA.Zhu@sony.com>
To: "trini@konsulko.com" <trini@konsulko.com>, "sjg@chromium.org"
 <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Jacky.Cao@sony.com"
 <Jacky.Cao@sony.com>
Subject: [PATCH v1] lib: elf: Fix bootelf -p crash issue
Thread-Topic: [PATCH v1] lib: elf: Fix bootelf -p crash issue
Thread-Index: AQHa6G8GmkxDiaMvaUS03NMM82wulA==
Date: Wed, 7 Aug 2024 02:20:07 +0000
Message-ID: <OSQPR04MB7740E04121473281459069CB90B82@OSQPR04MB7740.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR04MB7740:EE_|SEYPR04MB7756:EE_
x-ms-office365-filtering-correlation-id: e07ef519-43c8-4354-9930-08dcb6877495
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?gb2312?B?UEIzMU1jaFlJTk91TFI2czRESlVMUmFydWlwaGsrM2RjQTZsSSs5Q1c1OGV4?=
 =?gb2312?B?OUF6WDQzVEEzZExJaU1vdXRoaCtQcEs0Z3lOVUVUWFFqaCtad2laQU15eDVR?=
 =?gb2312?B?L3g2V2s3WlV4YW54elBudytUdFJxRW81cXRtQm1HVWt2LzUvbzd6cEI3MlNp?=
 =?gb2312?B?V3B5aldCWWtqYkw3SFJsOTVuMHF1OWxiYkZqdkhHQXhxaElSc1lrRllLK0or?=
 =?gb2312?B?WkhCUnRsMk8yZ1pva1hKSkRBNjh0dDdQQkdhNTcycmZQTDJMN3k3THluVFkz?=
 =?gb2312?B?eXJZZW9BclJubzhvejJwT3BnaGU2N05uVU4zRzFMRThVQkJCSEVsaWJCZFJS?=
 =?gb2312?B?UzJ3bGgxT2dsYU94MURTeTQvdmNwSER2TTF6K0NFc3NlWTRBaHZHMFpzendP?=
 =?gb2312?B?Zm9vRCtyb0dDa0VTcHU4OWJvZUJTdVhtQ2kvWW12TXVOYmNWZmlQS3VMMkc0?=
 =?gb2312?B?RFIyM1oxbmpRQzluak1yd0hDWnZxS1VSbEtOSitBS2tXY3JVOXo2MVdiS1ZC?=
 =?gb2312?B?bDlyTHFuc09NSFpvdnBhQWpTMUc3dkprNzc5bURJNXI0SXkxb2JqN1FzUFo3?=
 =?gb2312?B?dEdnQisvVEgvRXRBRzNhRE5MakJUUENCKzVnc1dWQ1V5VWRlRUt3OFF2RTNJ?=
 =?gb2312?B?TGh4S1hQQmVyRWl4ZEdXTjM4bk05NkhFZVZHeGZOMVZOZGpWNGRpMXZEbDE1?=
 =?gb2312?B?cUUzWHp0OTBqOXNnc2FBKzBpWXpVR2JQT0RqRjVzekcyR0tEZEpuM09xaEsw?=
 =?gb2312?B?MG40cVFsMCt5bEtNb2hZRVNMd2VaZDFXL1M2U1lkUkpQMDhjYk1ScnlTTmdC?=
 =?gb2312?B?SnBmb2YrTWdnMnJ4Y1RmS0p1WW0wNU0wNE96eTA4Ynd2YnAvcVE1MHE5Q2l4?=
 =?gb2312?B?WnUxbkV6MG1wYlYvczRTaVFaOFk5dzZEb2Q1MUp0dnJ5VFJVN1lwVlAzZGs1?=
 =?gb2312?B?NlV1NTV6anhTYm5YNVBJVTNKVnlJUkV1ZHJzL0E1NE5PSE9rUHVaSkFLeGg0?=
 =?gb2312?B?aWRrSWhnK2dGSHBrUUVmVzlwQStYWW14N2NrQk5lbkREK3Q0WUxUL1RnRG1J?=
 =?gb2312?B?Sk13b1EwU0sxNHVJVmp0SnM0am5JUVB2NW5BQU5VQkphck1VdGh6SDhxQXFZ?=
 =?gb2312?B?OEFFUytGL3h4SmFZS29XMnBQMlJPSkFET2ZuSUZuL1JIM1JvY09FTXdGVDlx?=
 =?gb2312?B?MEJQak80aW1wU3dNbXppVk9hOWcvcHlDbkFPSFU0eUxiZDAwNWdMZVI1ZzdE?=
 =?gb2312?B?OWVSMXdhelNWanJLRnl1K2NQYkRoMUNWOEtocHlpSDhzRHk4bTRZeWJkSlhL?=
 =?gb2312?B?dlorRHk1THVITW94YUZVeXBPeFBQR3EyMlJxa2w2L3JXbzdMWmdrNWNIUTdz?=
 =?gb2312?B?bmxWQmdkRnhnN0I4U010V205R0s1Q3MrN096cURFeHVQTHhzb1RrZGFPUjh6?=
 =?gb2312?B?TEd4NGIyK3ZMQUxuSjUwaGlyY1puaWtZT3BtbXNnTDVjVjZTYVNyWHZIVWU5?=
 =?gb2312?B?aDV1UHlsY1A5R3c3SnNvZDA0bmR2MjZ0dCs1a2txNkhLMjlPMUYxUDYyMkp5?=
 =?gb2312?B?TnJibXA2VHNPNFpQQWc1QnJrKzBVOTZVdlZkaTRtd0xRaVFMbkh3ZEVjVVgy?=
 =?gb2312?B?ZlF5VnhOM044Wk9kKzJOQnUyRWtERVFYUUNqeDFqNjdRZWNrVzJid3U5NXFl?=
 =?gb2312?B?ajhQL05SUEdBMjVBQzdXN2RIbENTWElFYitaRnlJckJXd0lCZEhYYWMrUExv?=
 =?gb2312?B?dXJoSVppK0cvUEgzeCtPd1QwUjgyUlZxNDRPa0ZvVytkenJzdzhZWE9JOEpL?=
 =?gb2312?B?bFdITW5vYWxTVkdWbHlneldmbDBhc1dyMDhWUzU5bzN6dmlaODJYU0pkNlNN?=
 =?gb2312?B?QlpDUjNxdTBheDYwNlNwaTF6YXA2NWZwM3NMVW16QllHV1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSQPR04MB7740.apcprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VVM3QWlVZElaVW1ZM2JKODAyc2VUYk96YXNIVmM0LzBJek5mQ3BZYjNaSS9W?=
 =?gb2312?B?MEo2Yk9zZy82cFBmM1FVTUlhMDFlQnFyR1RmUVgwWlZSOHZaQi84Um1oOGVO?=
 =?gb2312?B?R0x1VXNJdmZDMlF0UmU0Mk0yVG9CdjVMY2pJSnhhclhFSlVUMDhlTmdDUCtM?=
 =?gb2312?B?NXRPc1ZQVlhhamFuNkpPc3I1dlZ2Vk1lRC9tVnpveFNoeXF2bUxwRFlmNUto?=
 =?gb2312?B?L0U0UTk4UjZJNzMrWC92cjhhWmVqOHU1a1lnY1QwVWhpTHl2dlFGZW1Eckdy?=
 =?gb2312?B?Q1kvR0ZQY2RoU3BEWHBsaUhPUS94SzF0dTh0K2hkamxXOEc0ei9HTDJSMUdx?=
 =?gb2312?B?L2tpZHQyaXNnK3VKYVEyVCsxMUFmU1kwTXNvT2xCNWVLdFBPQzhwakpFNU9t?=
 =?gb2312?B?anFWNzVia2tkSlJPZGhXT2M1SWV5c1VJUVdxZFZydnZnVFNON0JKNkpSVDNO?=
 =?gb2312?B?dy9RdjJwUmhNTkVhbWJLVU5KcTdVZXhrQWozNzA5NmNKaWtVWFVoaExNTngr?=
 =?gb2312?B?VWhPK0pQeDBRZisybW9leXhrT3dFajhzZmU0U3N0K1hZamttanlCS3pYSERG?=
 =?gb2312?B?d1dYUS9VV1gvTVNwQ3dYU2cwVEdnSW9rYU1qQ091TXJPK1dxRDZaSG01NGJH?=
 =?gb2312?B?ZGFuK2ZLSVdOVHkyTUgrUmlPQVVRMFFHM0U2MEQ5eUhjckZNWXdGNU1aMElN?=
 =?gb2312?B?THcxTzdvNXQxbXZLQ2MrQ1JrbGF2OSsxYUx5cWZ3dGdaWHdoVVc1N0xGT0k3?=
 =?gb2312?B?S1BZRSt3NnJ3andBeEg2eWJxdDM4YlJXRDFmaDM2L1ArZWVBNDJqUHNUUGFV?=
 =?gb2312?B?WHc3T0NqUDc3YXdQcUNqazBtYzEra3RhSVErS0hpalJTV2tQanlHUEEvanZO?=
 =?gb2312?B?OVFXUCtFU21OWE1VK2NodURhd05BRmJpTnl2VjBSOGhRTmdaTHdPY3kvNy8x?=
 =?gb2312?B?TEJ2b3FwdC9UVTVyODNxb1l0Zy9SaXowUWdsMko3eVRBMER4MXZjTlM4OGV4?=
 =?gb2312?B?ejNFR2drdEtRdERCaGR4TU5vbExxOHVGUVlvdmkxcVhBTmZHSWo1a0gxbFBX?=
 =?gb2312?B?U0VHek81azdONHA3R2VGdEZBN1lrNUpsaVFzbXVMS2VSZzJxb09xNkNVa1Bh?=
 =?gb2312?B?aGhNZ21WdURBSkNXclVPa3lNbTMvTkdFNERoN3ZHM043N3ZrNldIVEF4d2Vu?=
 =?gb2312?B?Y0pDNk5heTA4d2ZwQUxaUHVoelZja2VpNEdkaENTNVFmY0k0aGdKZXhHR0dZ?=
 =?gb2312?B?bG1aaEJVaFZSaUFhU3VWbk5HS2RBTDFCR0Z0blYxVWgrWUxCV2lMckpZYXZj?=
 =?gb2312?B?ZXRkT1RuRHdXZW1qRm5mQlgvZ0o5QkloOXN1TlBwbnpKTzVhQXNNU1V3Z3Ay?=
 =?gb2312?B?V0VEZzFWZ3NoaEtMMTRKZVo2QzYyeVA0bWFHRkxVdmNoK0FUeGZZZWJNNm9z?=
 =?gb2312?B?Nm5BTE5JSzYrMEszS1FuSU54d3Q0ZkVjWFFkMUVHQlN5SXYwSFo1SFJ4MnZH?=
 =?gb2312?B?TVpDVk8xVm1waXBrVlNVMUJBcTBPWXhYK2dPTENvZ0NWVXZIOHN5RDFZL1oz?=
 =?gb2312?B?NlJwM05jdW1FN2krTjhNU2lQZWx4dmV2QWYvTG0xb3haSTY0UW1PU20ybFdL?=
 =?gb2312?B?WXJQa0xKSUNSU1YxYVc0YnJFZVFyYlRhYmNGMitpQ1hkbVF6ZTVBM0IyNkFM?=
 =?gb2312?B?ekpHa1ZtcVEvRjFpdzQxVWQ3Z2JNU29uVWtQRlM4Vml2dXBmTk5ZU2tUMTVT?=
 =?gb2312?B?RlUwWk9meFpZMVVKRVlJNVdNVzltREJ2OWlzdnZnZVBXa2F0QzdzRExBT3kr?=
 =?gb2312?B?SzV0VVZwaTVmZE5yakJCbGEyVXE5VEFKTFlpZjhkdUtQOSt3OFlCZWRMRW0w?=
 =?gb2312?B?c2I3K3Jic1JPeFVHUEJTRXUwZHd4U3QxSzlBc1hWanBjRmFmYzBpV0t6VXNF?=
 =?gb2312?B?bjRrZm1yRDdkNkUyZkUxcnJmQUpIOVlhUjRwYjFTVDI2UmU1SFEwK3RmTWZ3?=
 =?gb2312?B?d1MyeGdEbHdmcEJPbHVKTDRRMnpoY3JTQmY0Tk1ZOFRLNzFxcHdtYXhveWVR?=
 =?gb2312?B?Y1JGV2MrT2FWNnIrTTY5ZEhCOUlMbGRKNjlRUExzZGJZUXRTbm54b1hxT3lH?=
 =?gb2312?B?R1NpSjhhTXpKeTllT1Z0WmQzVWt3MVpBTDFLQXNVUXJDb2RYVnUrRFNXZ1dm?=
 =?gb2312?Q?ww4Gh9W0sg82Sbzg+T0jP1k=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Wef+FKJFlu2EADYX3kyBBO7eKIWPE6YgsZYHBTaF0QLrgERgKlx94voCQvkSe3ubBqeQkwItq90GvUJgQw9yxsl3SIMULoVietb/UhW6d8h4Utny2ElrgD09ZFXegSg/MxNlCKY/h7v/kuE6bE9PFGLirIwUCPcFl1u5Ka45sC75OGaH0ymstaMXnOfxb82dac8Gwd4JbvVQNq7Iowfo+Y8JO7pxH8gfZX/iWGohBuLCDi3Xjuk9AGY22l37U06OJfHkwoJtBZ6URft3gD3tYT/qypTlCgnA+hxo2D8dbJCtnj1KXqLOHwwavAoHwG7jtJRNmV7VIW/q1WTEldUw+83fTxi+BqneR0B+AGydIppqECVfZd+EfNj8uGIILAEHcCz9Xs2g0+/13Y4bsmOHumOIHaokQdbKF0rn78jz0dvqxwPgTinfCdyotth2TuAJ1DSlhM56I3dHIJdApj3b+g2wVpVE6AR9CfIeMYd7T2TbpRMzusEiHgeh8Uaq1WXwWPcc14aKj78IxV+zngF6pJ0VtPKc3O7MqVeS2Km4e31o6UxEmXfNJajEaGZNj47iOfRYRlNXTYzJ2LNMyvDDIA6Jvim0BMLQOxXpnk1tjtEUT+e/04uuY7dA1qg7Rp5m
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR04MB7740.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07ef519-43c8-4354-9930-08dcb6877495
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 02:20:07.2506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chge23k3OiReSZi65ihq8d1MzDTTaBjNrpjpXh8fe0sN1zWu15vVbM5eZTAcauCe8Ww+Y6YLYmhX6MHizAkeAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7756
X-Proofpoint-GUID: D_tOd7VpytdmdXB5Ub2IDxeO_DdcIjVJ
X-Proofpoint-ORIG-GUID: D_tOd7VpytdmdXB5Ub2IDxeO_DdcIjVJ
X-Sony-Outbound-GUID: D_tOd7VpytdmdXB5Ub2IDxeO_DdcIjVJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_20,2024-08-06_01,2024-05-17_01
X-Mailman-Approved-At: Wed, 07 Aug 2024 15:44:15 +0200
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

RG8gbm90IGxvYWQgYW5kIGZsdXNoIHNlZ21lbnRzIHdob3NlIHByb2dyYW0gaGVhZGVyIHR5cGUg
aXMgbm90ClBUX0xPQUQgdG8gYXZvaWQgY3Jhc2ggaGFwcGVuLgoKYm9vdGVsZiB3aWxsIGxvYWQg
YWxsIHByb2dyYW0gaGVhZGVycyBhbmQgdGhlbiBmbHVzaCBjYWNoZS4KU2luY2UgUFRfR05VX1NU
QUNLIHN0YXJ0IGFkZHJlc3MgaXMgMHgwLCBjcmFzaCBoYXBwZW5zIHdoZW4KaXQgZmx1c2hlcyBQ
VF9HTlVfU1RBQ0sgYXJlYSBmb3IgdGFyZ2V0IHRoYXQgbWVtb3J5IGNhbm5vdCBiZQphY2Nlc3Nl
ZCBmcm9tIGFkZHJlc3MgMHgwLgoKY3Jhc2ggY2FsbCBzdGFjazoKPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KYm9vdGVs
ZiAtcAp8LT4gZG9fYm9vdGVsZiAoY21kL2VsZi5jKQogfC0+IGxvYWRfZWxmX2ltYWdlX3BoZHIg
KGxpYi9lbGYuYykgLyogTG9hZCBlYWNoIHByb2dyYW0gaGVhZGVyICovCiAgfC0+IGZvciAoaSA9
IDA7IGkgPCBlaGRyLT5lX3BobnVtOyArK2kpIHsgLyogZV9waG51bSBpcyAyICovCiAgIHwtPiBm
bHVzaF9jYWNoZShzdGFydD0wLCBzaXplPTApIChhcmNoL2FybS9saWIvY2FjaGUuYykgo6gqMaOp
CiAgICB8LT4gZmx1c2hfZGNhY2hlX3JhbmdlKHN0YXJ0PTAsIDApOyAoYXJjaC9hcm0vY3B1L2Fy
bXY4L2NhY2hlX3Y4LmMpCiAgICAgfC0+IF9fYXNtX2ZsdXNoX2RjYWNoZV9yYW5nZShzdGFydD0w
LCAwKSAoYXJjaC9hcm0vY3B1L2FybXY4L2NhY2hlLlMpCiAgICAgIHwtPiAvKiBjbGVhbiAmIGlu
dmFsaWRhdGUgZGF0YSBvciB1bmlmaWVkIGNhY2hlICovCiAgICAgIHwtPiBkYyAgICAgIGNpdmFj
LCB4MCAgICAgICA8PD09IGNyYXNoIGhhcHBlbiB4MDpzdGFydD0wCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CioxIEhl
cmUgdGhlIHBfcGFkZHIgYW5kIHBfZmlsZXN6IG9mIHRoZSBHTlVfU1RBQ0sgcHJvZ3JhbSBhcmUg
MC4KCmhlbGxvX3dvcmxkIGVsZiBpbWFnZSBwcm9ncmFtIGhlYWRlcnMKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUHJv
Z3JhbSBIZWFkZXJzOgogIFR5cGUgICAgICAgICAgIE9mZnNldCAgICAgICAgICAgICBWaXJ0QWRk
ciAgICAgICAgICAgUGh5c0FkZHIKICAgICAgICAgICAgICAgICBGaWxlU2l6ICAgICAgICAgICAg
TWVtU2l6ICAgICAgICAgICAgICBGbGFncyAgQWxpZ24KICBMT0FEICAgICAgICAgICAweDAwMDAw
MDAwMDAwMDAwMDAgMHgwMDAwMDAwMDgwZmYwMDAwIDB4MDAwMDAwMDA4MGZmMDAwMAogICAgICAg
ICAgICAgICAgIDB4MDAwMDAwMDAwMDAxMDM5MCAweDAwMDAwMDAwMDAwMTAzOTAgIFIgRSAgICAw
eDEwMDAwCiAgR05VX1NUQUNLICAgICAgMHgwMDAwMDAwMDAwMDAwMDAwIDB4MDAwMDAwMDAwMDAw
MDAwMCAweDAwMDAwMDAwMDAwMDAwMDAKICAgICAgICAgICAgICAgICAweDAwMDAwMDAwMDAwMDAw
MDAgMHgwMDAwMDAwMDAwMDAwMDAwICBSVyAgICAgMHgxMAoKIFNlY3Rpb24gdG8gU2VnbWVudCBt
YXBwaW5nOgogIFNlZ21lbnQgU2VjdGlvbnMuLi4KICAgMDAgICAgIC50ZXh0IC5yb2RhdGEgLmVo
X2ZyYW1lCiAgIDAxCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Cgpib290ZWxmIC1wIGNyYXNoIGVycm9yIGxvZwo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQpib290ZWxmIC1wIDB4ODBmMDAwMDAKIlN5bmNocm9ub3VzIEFib3J0IiBoYW5kbGVy
LCBlc3IgMHg5NjAwMDE0NywgZmFyIDB4MAplbHI6IDAwMDAwMDAwOGY2MDM1YmMgbHIgOiAwMDAw
MDAwMDhmNjZmZjU0IChyZWxvYykKZWxyOiAwMDAwMDAwMGJkOTQ3NWJjIGxyIDogMDAwMDAwMDBi
ZDliM2Y1NAp4MCA6IDAwMDAwMDAwMDAwMDAwMDAgeDEgOiAwMDAwMDAwMDAwMDAwMDAwCngyIDog
MDAwMDAwMDAwMDAwMDA0MCB4MyA6IDAwMDAwMDAwMDAwMDAwM2YKeDQgOiAwMDAwMDAwMDgxMDAw
MzkwIHg1IDogMDAwMDAwMDBiZDEyZGE5OAp4NiA6IDAwMDAwMDAwMDAwMDAwMTAgeDcgOiAwMDAw
MDAwMDAwMDAwMDEwCng4IDogMDAwMDAwMDAwMDAwMDAwYSB4OSA6IDAwMDAwMDAwYmQxNTZiMzAK
eDEwOiAwMDAwMDAwMGJkMTUyNmUwIHgxMTogMDAwMDAwMDAwMDAwMDAwMAp4MTI6IDAwMDAwMDAw
MDAwMDAwMDQgeDEzOiAwMDAwMDAwMGJkYTAwMDAwCngxNDogMDAwMDAwMDBmZmZmZmZmZiB4MTU6
IDAwMDAwMDAwYmQxMmRhYjcKeDE2OiAwMDAwMDAwMGJkOTU3YjE0IHgxNzogMDAwMDAwMDAwMDAw
MDAwMAp4MTg6IDAwMDAwMDAwYmQxM2ZkOTAgeDE5OiAwMDAwMDAwMDgwZjAwMGIwCngyMDogMDAw
MDAwMDA4MGYwMDAwMCB4MjE6IDAwMDAwMDAwMDAwMDAwMDIKeDIyOiAwMDAwMDAwMDAwMDAwMDAw
IHgyMzogMDAwMDAwMDAwMDAwMDAwMwp4MjQ6IDAwMDAwMDAwYmQ5ZWFjYzAgeDI1OiAwMDAwMDAw
MDAwMDAwMDAwCngyNjogMDAwMDAwMDAwMDAwMDAwMCB4Mjc6IDAwMDAwMDAwMDAwMDAwMDAKeDI4
OiAwMDAwMDAwMGJkMTU0YzgwIHgyOTogMDAwMDAwMDBiZDEyZGE3MAoKQ29kZTogZDI4MDAwODIg
OWFjMzIwNDIgZDEwMDA0NDMgOGEyMzAwMDAgKGQ1MGI3ZTIwKQo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQoKU2lnbmVk
LW9mZi1ieTogSmlhbmZlbmcgWmh1IDxKaWFuZmVuZ0EuWmh1QHNvbnkuY29tPgpSZXZpZXdlZC1i
eTogSmFja3kgQ2FvIDxKYWNreS5DYW9Ac29ueS5jb20+ClJldmlld2VkLWJ5OiBUb3lhbWEsIFlv
c2hpaGlybyA8WW9zaGloaXJvLlRveWFtYUBzb255LmNvbT4KLS0tCiBsaWIvZWxmLmMgfCA4ICsr
KysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvbGli
L2VsZi5jIGIvbGliL2VsZi5jCmluZGV4IGRjMTM5MzVlMTAuLjI4ZWM4N2I4ZTQgMTAwNjQ0Ci0t
LSBhL2xpYi9lbGYuYworKysgYi9saWIvZWxmLmMKQEAgLTkwLDYgKzkwLDEwIEBAIHVuc2lnbmVk
IGxvbmcgbG9hZF9lbGY2NF9pbWFnZV9waGRyKHVuc2lnbmVkIGxvbmcgYWRkcikKIAkJdm9pZCAq
ZHN0ID0gKHZvaWQgKikodWxvbmcpcGhkci0+cF9wYWRkcjsKIAkJdm9pZCAqc3JjID0gKHZvaWQg
KilhZGRyICsgcGhkci0+cF9vZmZzZXQ7CiAKKwkJLyogT25seSBsb2FkIFBUX0xPQUQgcHJvZ3Jh
bSBoZWFkZXIgKi8KKwkJaWYgKHBoZHItPnBfdHlwZSAhPSBQVF9MT0FEKQorCQkJY29udGludWU7
CisKIAkJZGVidWcoIkxvYWRpbmcgcGhkciAlaSB0byAweCVwICglbHUgYnl0ZXMpXG4iLAogCQkg
ICAgICBpLCBkc3QsICh1bG9uZylwaGRyLT5wX2ZpbGVzeik7CiAJCWlmIChwaGRyLT5wX2ZpbGVz
eikKQEAgLTIwNSw2ICsyMDksMTAgQEAgdW5zaWduZWQgbG9uZyBsb2FkX2VsZl9pbWFnZV9waGRy
KHVuc2lnbmVkIGxvbmcgYWRkcikKIAkJdm9pZCAqZHN0ID0gKHZvaWQgKikodWludHB0cl90KXBo
ZHItPnBfcGFkZHI7CiAJCXZvaWQgKnNyYyA9ICh2b2lkICopYWRkciArIHBoZHItPnBfb2Zmc2V0
OwogCisJCS8qIE9ubHkgbG9hZCBQVF9MT0FEIHByb2dyYW0gaGVhZGVyICovCisJCWlmIChwaGRy
LT5wX3R5cGUgIT0gUFRfTE9BRCkKKwkJCWNvbnRpbnVlOworCiAJCWRlYnVnKCJMb2FkaW5nIHBo
ZHIgJWkgdG8gMHglcCAoJWkgYnl0ZXMpXG4iLAogCQkgICAgICBpLCBkc3QsIHBoZHItPnBfZmls
ZXN6KTsKIAkJaWYgKHBoZHItPnBfZmlsZXN6KQotLSAKMi4yNS4x
