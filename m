Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BBE606A327
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MiqH47bj;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hTwkAS/H
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3737B40687;
	Mon, 23 Nov 2026 09:21:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id od5QCgw83t-0; Mon, 23 Nov 2026 09:21:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2F9CA40688
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795425711;
	b=POgIYf69Dz8VnvsINqbgaeSk/tz47wbW3l3UXP4PadPt8BFO3z0c6vkz4Jn4Gx63CCG7
	 SKmlFVz99Z/Q2rOq1MGIAFpOaSeyL70qKSacYmHYjkB5X12vLh7iG5G6Bg/w7vVBu8p5/
	 1yGx8/iEROHqFqka7djCSy2jUxBQK4+CS8i5ePk+spyFsLDRCIopCHEs4RViHArUgyN93
	 Y+WfjfoHwSvR7Uc//49mfIlg4dSULh2W6pqgLGqPhePmEscgTzbx7oIAdpry3I6xQjvHM
	 0AO3GtqLGIiyOvkAUhrzL9KBWA71IeYxP70h/s8WqHBsEitL5urX0n0sNqSInsupDZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795425711;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-exchange-messagesentrepresentingtype:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-sharedmailbox-routingagent-processed:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=r4+187S2LRtv5vmMfbxjB4ysl7jTJhC6b2i/FKmba9o=;
	b=COr09UDBXwbHHM71mfaqvGwVcuZG8ELkaYEwQZMrFv4FWo5mbkG8pZ45blO6vLtXFOyv
	 k/NaINR8/jcRTlsGgYaolJ3AEqOYfwfkL4l0N/eBaGWJn9z4T4BmGi5yjjSNyMg7uNuqa
	 BVKj7xSfBUcMDTj6fVdm/N5MqqqB2CwusI3fd3EdINFU+ze3SHOES32hfNV6FTWpAygQu
	 0Ll5NcOqSDsY2pHpmgJeIsguRTW2P/dBN7mkkAuYn9VUgXAFabROFsI1U7GkLBB3FmGDI
	 /JHNOEVMylyVKj8AnuK3OR4UiMBx2h/QDT1OnxaymU+0Ln8hc/PXB6NeL3hhnKpGMfg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795425711;
	bh=r4+187S2LRtv5vmMfbxjB4ysl7jTJhC6b2i/FKmba9o=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MiqH47bjKowUoRDWXOFGV3peLz/6Bg2vrGOaq9aaVLciMR7biXxJf/iJulG+BniM2
	 5Adn8OiSwzWVY2e3RVFsWRLkjjnajBkj2kcqi+MEOxZ00vmprzKEO6zzPXns9HZ48v
	 Uxjv+r6fmWLmo+RDv8INEnOkuFXTu+w4WWXI95F5yCES0/emb7oBHYVeJxqDQ9L9qr
	 HriyMDW4jljm9FiQ8/SnYqT70hdAxVQs80SetPqDtBmtz4zV6DR0878JRs3ZPsvKWZ
	 EG4Mj+igSoEfRKOeQbI0H4Nu9o1zCTjaOcFoAOy+jokE+O+riVG/4aZlm0sw5/dURM
	 2lRnHydfknKKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F9CA40688;
	Mon, 23 Nov 2026 09:21:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BA6671AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ABE15401BE
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wrW17Vo7vDBv for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 09:21:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 98B344005D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hTwkAS/H
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98B344005D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4+187S2LRtv5vmMfbxjB4ysl7jTJhC6b2i/FKmba9o=;
 b=hTwkAS/HBAhlPpRFz/IMj18tgTOpz9BGD35qh7cMnSebFc++4Hkaom18i3UJ+2yJKNkbBHNz7sQA2T7RcEmLq5a4kCOR0etKzl8U/5bZFC9vbD+C5Rve/1gsQNY9OdT/Ntowgp8eM8nvrpa9XJOVxF7ZcBkn5XtWP0xCG1qfExlFaXpMHkuF8YRA1EIJUvIxNelMD+d81wR2XQ714CrDdhwVG25ZlyLuLJRs5zL3eASbJVd5HOISgi35Wz1lNKGl7fCBwxssQgZ2+wPw83UlDzxgWpCaKl0SPeuVJVRLeowJl/R9jmTqQjEh4kCqpymz0pOxRaV97HZEXQUvJOKH+Q==
Received: from AS8PR04MB8721.eurprd04.prod.outlook.com (2603:10a6:20b:428::10)
 by VI0PR04MB11481.eurprd04.prod.outlook.com (2603:10a6:800:2c8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 09:21:37 +0000
Received: from AS8PR04MB8721.eurprd04.prod.outlook.com
 ([fe80::ca16:532c:71dd:39a5]) by AS8PR04MB8721.eurprd04.prod.outlook.com
 ([fe80::ca16:532c:71dd:39a5%2]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 09:21:37 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 dl-uboot-imx <uboot-imx@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, krzysztof
 <krzysztof@kd-solutions.pl>, Joy Zou <joy.zou@nxp.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Stefano Babic <sbabic@nabladev.com>, Ye Li
 <ye.li@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, Johan Jonker
 <jbx6244@gmail.com>, Vincent Jardin <vjardin@free.fr>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYyIDIvM10gYXJtOiBkdHM6IGlt?=
 =?utf-8?Q?x91-9x9-qsb:_add_U-Boot_specific_dtsi?=
Thread-Topic: [EXT] Re: [PATCH v2 2/3] arm: dts: imx91-9x9-qsb: add U-Boot
 specific dtsi
Thread-Index: AQHdc/G40MLSyT0P+k+5Pf0vwcKmnrc6BMeAgAFrSbA=
Date: Mon, 23 Nov 2026 09:21:37 +0000
Message-ID: <AS8PR04MB8721F0020B024C6608C35ACAE2452@AS8PR04MB8721.eurprd04.prod.outlook.com>
References: <20261114-91qsb-v1-0-046293559467@nxp.com>
 <20261114-91qsb-v1-2-046293559467@nxp.com>
 <CAOMZO5Be6ZrFPJJEg=oQeXb-Erh0G=KUsUdnVjptu+36W7PKgA@mail.gmail.com>
In-Reply-To: <CAOMZO5Be6ZrFPJJEg=oQeXb-Erh0G=KUsUdnVjptu+36W7PKgA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-11-23T09:21:09.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8721:EE_|VI0PR04MB11481:EE_
x-ms-office365-filtering-correlation-id: c8fbf3b8-ae11-4ee0-d433-08df49432d08
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|19092799006|23010399003|366016|38070700021|10067099003|56012099006|11063799006|4143699003|261022105027099003|261026121527099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261102123227099003|261009221727099003|261009221227099003|261009223327099003|261009223027099003|261009220027099003|18002099003|22082099003|3023799007|41080700001|15866825006;
x-microsoft-antispam-message-info: RcBop7OLNQnpLSfvyko9/ft/tbJzlt1j5QBUKirHzkxHJp0sME7luawpp9a+5Y6LAL/nrulOxUFo/BIiwyTLVbX0PkfkA39zDdZqohUpBhlgR03FvSw1OCaEYvHXUByRrUcWBO5SOcS28wa+fJU4dWy/g/hRfmT6wmPjnqYknagPpk7FueorsxVibGz0cvVcmzkSb2g6+BJLg34e9pZd4t/Rr+jy8dTfO2J11zHRysWdDJIuXvZclXgDZX5hts6swF8WAMstu2AsQpo7oRadKCQDPiYd3a1KDhVYOxSL9M4H0CjHv8d3ZRNmn2Hs46p46GkJQHCuHKcCi0R8MupXMFKZFVqvf+42OtVI0iJzlgNUHeBcYOfFWIfeffonqwlCO1E9WICFadNSSmt/+sQyQbWopAaJ9H2U3JlG5XOFKyZlkWVc2E9q+j2LDWSgdvF0KrhztVZlVNXTgw3tGM5SJFlr7NRRnta/HZpMKaWVq0VwNsYPqv7FBeGnvT00irsbSphYcoTn1j7dVltFBi5BgORTaqi6zFgDjE0l6iqaZoE3ejnLx1ATFq+fWhvbJg4V3zvdGZM20vO5Cllp9wydqCuViR2fT9YDYdLhYaHSotelA8oRtXq7hQILgsdb6Q/R4Jeo4fYQPr45N4ySo/B9j12JH3ImDVQyqObFRs32kLKgUiabhOQwTa6JV72o3B/EKU7DT64e/UdTzOUo9DRnl5uIM77WIL+XCGNpUedw0bWVymKEldsHcQykn9IPXtHGQEo3bUAKqNF4KiyleQjPl1+3XYUE1oASG6krTp+svlA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8721.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(19092799006)(23010399003)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009221727099003)(261009221227099003)(261009223327099003)(261009223027099003)(261009220027099003)(18002099003)(22082099003)(3023799007)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHVkU2VVVXB0M2pPSGJaUFRuSU9MeEdNRzdPai9wUnpSSDJ1N3BFTi8rQzZ6?=
 =?utf-8?B?QngyeDVoQlFtSEpuT3ZyZW1NNGpsYmVxL0VubzJNazRGb2FvVDU5U05XQzBF?=
 =?utf-8?B?N3ZSSGRReTgySlZzODA0OG54VVd0bjZhNGpsMi9SOUZuY2ZsdU1xOExHUVBE?=
 =?utf-8?B?bEtCVnczMTFEYjRubzFFNXF1WTl5L2JaYjlJQVdkYThoaUU5cThiUnFYaVlL?=
 =?utf-8?B?VWRJUTVVcmVock9wSHdWUVhlM3RhN3FvQ3RQY3lNeGJHQkRTbFVMNUlhK2sx?=
 =?utf-8?B?MXJCYU1TVEZQM09PcWl4ZC9waFBlOUFnL05FZU5VSVBNOHgwWVVrSUxGWHlz?=
 =?utf-8?B?TFVOYnA4N1dSN0FDMFhyNHNFZ2pNUm5aeXJtYTE3VTBXK1FEdy9URTBaRTlh?=
 =?utf-8?B?R0NYT0p6b3ZRWGZEVWFoZU41OFNJeUNpQlFaWDltSHNZMkNFZjZWbGJDMWR1?=
 =?utf-8?B?TEdDdkdiZDJkOVRyeFIyU3MreXV0TzZpSjVCT2c3akY2MCtYTTZKVlBvTG5z?=
 =?utf-8?B?OUlNcFVPVURGUTRMa3Qwc01YbDAzQ0g5dkxpNWg1NXZYZ1AxelY2d1l4RjM3?=
 =?utf-8?B?bVV2bklOU1hpMWFRSXIvQ2ZlcWEvTWR6N3FKckEwdHBaaFQ5cFI1RmEwNmN5?=
 =?utf-8?B?ZHp2RHhOeFJ0U0Z2eHZSSlBNeWpvZjlyU0pyMGpGZkZPU1FlRTRNNkFEbmtN?=
 =?utf-8?B?TzBYR1hRODNLbFZHK3FOZUhWWTZSRmx4andjM2JyZG5sR00vRDYxRk10dW5L?=
 =?utf-8?B?L1lHZ3BnQ2Z3YlBvL3NSR2l2VWxmWkNoWE5DZDN4ejN4RElJQlBWMG9TK0RT?=
 =?utf-8?B?UEExZEJuSnFHM0QzSlI4aDVCV0dZaFhtQitTSDBSVnNBNmJoaUtQOTc5d2xL?=
 =?utf-8?B?YWplVzN2U1JOeHA2MnNWV0ZVcFdPekJMcm1xZzdhaXkwVzlSVFc1SWt1eDZw?=
 =?utf-8?B?eWF2QnNkbEdNMVZFWUtrNjNGenVWQW14YXFZOXFwSkdNR1h1UVVldlVwMWdy?=
 =?utf-8?B?MHNzWVpHUkl4eFpCdThlM3hnTjNFV3pod1VQNWcrbDRkYVZQb21GOWRkTlNP?=
 =?utf-8?B?S09NUlAxQ1lCc3pTZjFwWXpobWF0emlNSHFtbi80bTRkeU9YNDIveUJPTGlS?=
 =?utf-8?B?TFhEZzRXendMV00rNm9xdmtaVmpkTUNTODJNN05mM0pRSk12eXJ4KzFmNE5M?=
 =?utf-8?B?bjVocGcxMVhIZmIzU0FPc28yNGdFRTBrQzRsL0VLU2w1WmtJY2tjcEdqMGFS?=
 =?utf-8?B?QnFKdGZsUnJYekZsMVJIbGMyOExvWW1QVnFZSEpha2kxMXdDdE1OcjNDN3pO?=
 =?utf-8?B?cWFlR1p3MEZvZWZLUXdNVVZ2TnJGRXE3MHlwWG54T0VsYU9oMmxWcUtmYnEr?=
 =?utf-8?B?N1p3UDQ2dXZnUitlYTRaSUJNNUFQTUVLUmZsNDk1MXJTdnlNTG1UaTNNYnVQ?=
 =?utf-8?B?NStwcUwwamg5dVg5SjhIWHhLQWlEdjZzdmJTWGlyczNiN2F1RFA1bnlaUTNP?=
 =?utf-8?B?OVlBQm41TlFhMHZiRnUvZEVmQmpYa0RUbTlqK256L1pLTHdFK3VpV3pDcHpO?=
 =?utf-8?B?alNBQ2UxSmtrb2lVMFFiUzBZL1UxYTk1WkV4YkE0U0h3YkpaVTc4ZjZueVBr?=
 =?utf-8?B?dEp4MXJRZ3FDYjg0VUdXRy9tM3hnWXZHSXRPdWhEQUNwaEE3RGhGYTJpQnVi?=
 =?utf-8?B?eVRzcXpyZ0NTUkg4UTJHbE9wOXZnQndPaVVlVjRPSUhQNmtITjd4MldHYWkw?=
 =?utf-8?B?N3kyVWtDRUF6NWE3d2JXakl3Q0FRRkZkWEIrQUZBbWRMNmVRMjdFZEx3dEcw?=
 =?utf-8?B?ZTNUYW50UEZaTExNemJRLzZTTTVTQzZWYkhHYWNLZUI4NjZpVEhkY0lDaWpl?=
 =?utf-8?B?ZUVFajZtd1NDWWs2T091WmNEbXRHTWZGQXFweC92L2I0anJqUFlvVWhINElX?=
 =?utf-8?B?SXVYb0pvYnhMRCtDOFBWcmZpUVQwckRsQmNDeHdnOTVtZmNvTFhUcllYSXZI?=
 =?utf-8?B?ZnphUkZkYm5kZDdOWi9MTFBKV1BJYUtOMWZKUlhHNnovSk04USsvaXhONjlG?=
 =?utf-8?B?Ym5LM0pzWGlMWkQyaksxNUZhZDFxK2daRHNjOTNtZzdDMDJNdGt5TzUxK3NU?=
 =?utf-8?B?d09lSnVqY3dMZW9KOFRPc3B4c0JZUkVaNXZxZUhSL3NnYTlnQkdxZWw0cXNE?=
 =?utf-8?B?RlIzTkl3M1BjMjdSYTZIOUs1QXQzTVBNWGMweXV5d1ZxM0JHbFRreGVkdVhj?=
 =?utf-8?B?TE9PMk1OMWVqVzY2dmVQdHc5WW5hbm1GVXhrUkoyekFEZGZQb2NFUEtyWnRZ?=
 =?utf-8?Q?+bPB0Ft6dPdfp5CyAB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8721.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fbf3b8-ae11-4ee0-d433-08df49432d08
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 09:21:37.7047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mHHyhjNrJMSNfdm2vQ3jyz8j3AF4QCb3P46LKTXiW4aDFYzN2+7n2t92eIZmjrL8EFHtn3zeL5p3I3MJpeQ1ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11481
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQpOWFAgQ29uZmlkZW50aWFsDQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6
OiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IOWPkemAgeaXtumXtDogMjAy
NuW5tDEx5pyIMjLml6UgMTk6NDENCj4g5pS25Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNl
Lmd1b0Bvc3MubnhwLmNvbT4NCj4g5oqE6YCBOiB1LWJvb3RAbGlzdHMudS1ib290LXByb2plY3Qu
b3JnOyBkbC11Ym9vdC1pbXggPHVib290LWlteEBueHAuY29tPjsNCj4gSmFlaG9vbiBDaHVuZyA8
amg4MC5jaHVuZ0BzYW1zdW5nLmNvbT47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsNCj4g
VG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47IGtyenlzenRvZiA8a3J6eXN6dG9mQGtkLXNv
bHV0aW9ucy5wbD47IEpveSBab3UNCj4gPGpveS56b3VAbnhwLmNvbT47IElsaWFzIEFwYWxvZGlt
YXMgPGlsaWFzLmFwYWxvZGltYXNAbGluYXJvLm9yZz47IFN0ZWZhbm8NCj4gQmFiaWMgPHNiYWJp
Y0BuYWJsYWRldi5jb20+OyBZZSBMaSA8eWUubGlAbnhwLmNvbT47IEpvc2VwaCBHdW8NCj4gPHFp
amlhbi5ndW9AbnhwLmNvbT47IEpvaGFuIEpvbmtlciA8amJ4NjI0NEBnbWFpbC5jb20+OyBWaW5j
ZW50IEphcmRpbg0KPiA8dmphcmRpbkBmcmVlLmZyPjsgQWxpY2UgR3VvIDxhbGljZS5ndW9Abnhw
LmNvbT4NCj4g5Li76aKYOiBbRVhUXSBSZTogW1BBVENIIHYyIDIvM10gYXJtOiBkdHM6IGlteDkx
LTl4OS1xc2I6IGFkZCBVLUJvb3Qgc3BlY2lmaWMNCj4gZHRzaQ0KPg0KPiBDYXV0aW9uOiBUaGlz
IGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlu
a3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBt
ZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPg0KPg0KPiBI
aSBBbGljZSwNCj4NCj4gT24gU2F0LCBOb3YgMTQsIDIwMjYgYXQgMTozNuKAr0FNIDxhbGljZS5n
dW9Ab3NzLm54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogSm95IFpvdSA8am95LnpvdUBu
eHAuY29tPg0KPiA+DQo+ID4gQWRkIHRoZSBVLUJvb3Qgc3BlY2lmaWMgZGV2aWNlIHRyZWUgb3Zl
cmxheSBmb3IgdGhlIGkuTVg5MSA5eDkgUXVpY2sNCj4gPiBTdGFydCBCb2FyZC4NCj4NCj4gV2h5
IGFyZSBhbGwgdGhlc2UgcHJvcGVydGllcyBVLUJvb3Qgc3BlY2lmaWM/DQo+DQo+IEl0IHNlZW1z
IHRoZXkgY2FuIGJlIHBhcnQgb2YgdGhlIG1haW5saW5lIExpbnV4IERUUy4NCj4NCj4gUGxlYXNl
IGV4cGxhaW4uDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KQmVsb3cgaXMgZXhwbGFuYXRp
b24gZm9yIGVhY2ggaXRlbToNCi0gd2R0LXJlYm9vdA0KICAgICAgICBJdHMgY29tcGF0aWJsZSAi
d2R0LXJlYm9vdCIgZXhpc3RzIG9ubHkgaW4gVS1Cb290Lg0KLSB1c2JnMQ0KICAgICAgICBJdHMg
Y29tcGF0aWJsZSAiIGZzbCxpbXgyNy11c2ItZ2FkZ2V0IiBleGlzdHMgb25seSBpbiBVLUJvb3Qu
DQotIGZpcm13YXJlL29wdGVlDQogICAgICAgIFRoZSBjdXJyZW50IGRlZmNvbmZpZyBkb2VzIG5v
dCBlbmFibGUgT1AtVEVFIHN1cHBvcnQsIHNvIEkgd2lsbCByZW1vdmUgaXQgaW4gdGhlIG5leHQg
cmV2aXNpb24uDQotICZBNTVfMA0KICAgICAgICBUaGlzIGNsb2NrIGFzc2lnbm1lbnQgYWxyZWFk
eSBleGlzdHMgaW4gYXJjaC9hcm0vZHRzL2lteDkxLXUtYm9vdC5kdHNpLCBzbyBJIHdpbGwgcmVt
b3ZlIGl0IGluIHRoZSBuZXh0IHJldmlzaW9uLg0KLSBFWFQxX1BXUkVODQogICAgICAgIFRoaXMg
R1BJTyBpcyB1c2VkIHRvIGVuYWJsZSBNUDIxNDdHRCBvdXRwdXQgdG8gcHJvdmlkZSAzLjNWIHBv
d2VyLiBJIHdpbGwgbW92ZSBpdCB0byB0aGUgTGludXggRFRTIGluIHRoZSBuZXh0IHJldmlzaW9u
Lg0KLSBTRDNfblJTVA0KICAgICAgICBMaW51eCB1c2VzIHRoaXMgc2lnbmFsIGluIHRoZSBmb2xs
b3dpbmcgd2F5Og0KICAgICAgICAgICAgICAgIHVzZGhjM19wd3JzZXE6IHVzZGhjM19wd3JzZXEg
ew0KICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtbWMtcHdyc2VxLXNpbXBs
ZSI7DQogICAgICAgICAgICAgICAgICAgICAgICByZXNldC1ncGlvcyA9IDwmcGNhbDY1MjQgMTIg
R1BJT19BQ1RJVkVfTE9XPjsNCiAgICAgICAgICAgICAgICB9Ow0KICAgICAgICBVLUJvb3QgZG9l
cyBub3Qgc3VwcG9ydCB0aGUgbW1jLXB3cnNlcS1zaW1wbGUuDQotIHUtYm9vdCxvZmYtb24tZGVs
YXktdXMNCiAgICAgICAgVGhpcyBwcm9wZXJ0eSBpcyBvbmx5IHVzZWQgaW4gVS1Cb290Lg0KLSBm
c2wsc2lnbmFsLXZvbHRhZ2Utc3dpdGNoLWV4dHJhLWRlbGF5LW1zDQogICAgICAgIFRoaXMgcHJv
cGVydHkgaXMgb25seSB1c2VkIGluIFUtQm9vdC4NCi0gZXh0Y29uID0gPCZwdG41MTEwPg0KICAg
ICAgICBUaGlzIHByb3BlcnR5IGlzIHVzZWQgYnkgdGhlIFVTQiBnYWRnZXQgZHJpdmVyIGluIE5Y
UCBkb3duc3RyZWFtIFUtQm9vdC4NCi0gJmNsaw0KICAgICAgICBUaGUgZGVsZXRlZCBjbG9jayBw
cm9wZXJ0aWVzIGFyZSBVLUJvb3Qtc3BlY2lmaWMgYWRqdXN0bWVudHMuDQoNClBsZWFzZSBsZXQg
bWUga25vdyBpZiB5b3UgdGhpbmsgYW55IG9mIHRoZSByZW1haW5pbmcgZW50cmllcyBzaG91bGQg
YWxzbyBiZSBtb3ZlZCB0byB0aGUgTGludXggRFRTLg0K
