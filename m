Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF0F606A323
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 04:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TP5Nmimj;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=Za1ybA30;
	dkim=pass (1024-bit key, unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=knxsFOFu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F58781205;
	Fri, 27 Nov 2026 04:42:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zqec06UBKx02; Fri, 27 Nov 2026 04:42:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 53C4E81201
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795754540;
	b=QaaWTFt43DsDhPqwVcUGxvpuIB4Klob9PEG+ggdTumv2sR0SUA3QeOdxzpqBblVBpJZ4
	 xGsEWD6Q2T4a5mijDSkRQ/fMS7/RkYi3Dsc8pLlnesOY59qzosWzQAmVQnHIU+DMrWu/U
	 7o5kdRiXnlSglLD+EI+/aaQE+urALwg7x4mC8xxiIzkVCLxpPeUM/GVKoZA3JABsnf45V
	 eW1R3hT9l0Y3XCfa9xQT/eBC3Otknyk0hryPpbh/iDJjS7wABUWS9sgm5e+ZNu/creMoL
	 20CqKHTswE58c9KgYpmOYH0TVdhMTKauP1kzdujYtfU4CZwvdr/fTuZDKxul2jrsdNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795754540;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-traffictypediagnostic:
	 x-ms-publictraffictype:client-request-id:request-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-MTK:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fENegQqwdXo9xgPzPrw/FID/TAvprUIBj5YgJea+aUM=;
	b=c36ooziXlOAkSX8DhVz6F79uxH3n1UssZOr/xzOFfwPyRE+oFVjVSc0hlBLmr2Oy3LpP
	 O4bp4ZHkXbmqsgNqUMlLTcrNU7YC3aoyeVfS444q8ho+6RAA1+uTwfbdLyITKMPxLq+LI
	 7/twaf3bNiJSEVLr1modjbtHYGXo2JJYL93hTbyN/i+uODKbUSVO4k+1XHdNb+LoJQUH1
	 /GWevXaP8JsmD2PEKf8lh9SNxblwhbp0+rWD0dyusGJIwuX9qgPCtrtaofb6WifwM3ccP
	 ViDSNp+2BBuKOIAh9mzOkwn5uolPP+X6gmUkZz4aliwLPqMOGeIZuR70lNWIO+24ZXw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795754540;
	bh=fENegQqwdXo9xgPzPrw/FID/TAvprUIBj5YgJea+aUM=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TP5Nmimj4OmLdfepo4nq5H6YbGp2Am8y2uZDEL0O5lCTPZc8LJOcGbzMW+BbTJaAP
	 XdPDHNVACEqdB/EO5bF2Uqfa354JM+qnTFAIFNW5MV8+YU1XYCapTfYnmma3ZbXlxh
	 rmXPmXCozziSjMs5c0BDIEUo+UTTGciBflTSlH43cLpHCCUMK/3PHMrXSfY4LIA0eI
	 AgVFzFKyQWaKbKsxTn4WBXuig6Z8QYgA9UkbxneHzreeCnH/dES6CmxECROPXxiwBI
	 GHloyI4Vnjj9sv4dVeyfKWd6YYVHvJkyLEZeFtBXsheKgJAg2VRlDLOFNywEpxTIah
	 icO/NTMoxUVjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53C4E81201;
	Fri, 27 Nov 2026 04:42:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 93701266
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 03:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84DED40A20
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 03:07:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GvjOrGsg3Jcy for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 03:07:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DA503409F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=210.61.82.184
X-Greylist: delayed 962 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 27 Nov 2026 03:07:13 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=mediatek.com
 header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=Za1ybA30; 
 dkim=pass (1024-bit key,
 unprotected) header.d=mediateko365.onmicrosoft.com
 header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-mediateko365-onmicrosoft-com header.b=knxsFOFu
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=210.61.82.184;
 helo=mailgw02.mediatek.com; envelope-from=tim.kuo@mediatek.com;
 receiver=<UNKNOWN> 
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA503409F9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 03:07:12 +0000 (UTC)
X-UUID: 61cd02deea0d11f1a7aecdb2598be72c-20261127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From;
 bh=fENegQqwdXo9xgPzPrw/FID/TAvprUIBj5YgJea+aUM=; 
 b=Za1ybA30JRuCaxXHPm+D0D0X/sPRQYo7gDiW2nX29lUZ5vMUqhVer7ZpgchMteAu2punAQ0SALMwAwglDSbek1sd8J5xKsaI3GJPZsKkSBU2qhCOYUBMw/ak7T8km8n8mAdvoQGf50nYSgQ78w89Oy6/OQ+m5c1Cirj/ex2cAdc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:2ce52095-2a51-4e30-a7f0-964ce4d92367, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:4000f338-9467-41bf-ae42-d74f568cb3c0,
 B
 ulkID:nil,BulkQuantity:0,SF:80|83|102|110|111|136|836|865|888|898,TC:-5,Co
 ntent:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 61cd02deea0d11f1a7aecdb2598be72c-20261127
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <tim.kuo@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 91919903; Fri, 27 Nov 2026 10:51:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 27 Nov 2026 10:51:01 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Fri, 27 Nov 2026 10:51:00 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fENegQqwdXo9xgPzPrw/FID/TAvprUIBj5YgJea+aUM=;
 b=knxsFOFubV27uqPOaMMp9GVrqsI5Ck1tLKXDjJM2BWvnTx75ZPYOAIayBIoVWIYz6s2nCJ+XA63v2lf+2gLDVB2vBYqd32oPR4f0uaoM8fFfKwHX/IpCFiEVWOV2IAqUJv2UILHkg5FgVnuPx8ImlANRMkPfF0bV9FwlXsV+3Tc=
Received: from KL1PR03MB7285.apcprd03.prod.outlook.com (2603:1096:820:e2::12)
 by SE3PR03MB10463.apcprd03.prod.outlook.com with HTTP via P2P;
 Fri, 27 Nov 2026 02:50:58 +0000
Received: from KL1PR03MB7285.apcprd03.prod.outlook.com
 ([fe80::ba5c:7633:34e2:ef9a]) by KL1PR03MB7285.apcprd03.prod.outlook.com
 ([fe80::ba5c:7633:34e2:ef9a%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 02:50:57 +0000
From: =?utf-8?B?VGltIEt1byAo6YOt5bu356yZKQ==?= <Tim.Kuo@mediatek.com>
To: Heiko Schocher <hs@nabladev.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>
CC: =?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
 =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?= <SkyLake.Huang@mediatek.com>
Subject: Re: [PATCH] mtd: spinand: consume an mtd index only on successful
 probe
Thread-Topic: [PATCH] mtd: spinand: consume an mtd index only on successful
 probe
Thread-Index: AQHdfhog+o/ZFIP//UiCjKKRBK2Z2g==
Date: Fri, 27 Nov 2026 02:50:57 +0000
Message-ID: 09422e1e7d8dd6876a4e0eafec366aa9aa7bf8d0.camel@mediatek.com
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-traffictypediagnostic: KL1PR03MB7285:EE_|SE3PR03MB10463:EE_
x-ms-publictraffictype: Email
client-request-id: 9832dbf9-0485-45b5-afd1-2c8e18ef5cfb
request-id: c5359794-9cae-4618-85ed-08df4c31436d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10067099003|56012099006|261026140227099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003|11063799006|18002099003|3023799007;
x-microsoft-antispam-message-info: dL5IrP7vcbUlTms+iPIJ4rHbH5IoaW/AOKcjdQGUXX4J3YVw9hTS57BKty766QgGdanZ/TDwzqU6j4tAiKQyWAppvZgKMt5k5WPPlS1yT6nqDNReGW8NJVgtL0GkcbJzP5S/Q119oU14LAEiYJeeMT6zs5IQmLK/04B2Q8+faOgjizA+mzKAQz+8CGoRBE7uwFW3T/6sblBw+p3V15VIGkCXfLawKcQhvymprOeP0dbcLS11i+t/sijFXXQhjJSPL+t8+6IKyTtaX6zSVxj95bDD09bneakFfJ8hXx+meDgvty5z0HBfgQBEdAojSrFCSgpd6WcIT8lyFiXqjUh4HL/hMbhz5BUWuO5NLoZcHjSVKFm9t1dCx7CmrW3hkm6Kx1/xLso8xVFeTOOOH2GG1C8xohWnHKgFV1718H3W3MMHaShfZ/4HZg0g76IG0LR8ORdwYFqAoP1cgXAeXPODN2tonfOaZR/LBM6Zui3/ws5o040uflj3RpNW5dMSsc2ZmBU/pyn62HH2Xnd0wCpdO1ySYLCjE99PexiuIwreONI1LoLJm8XOjBUjiTar7J5xzdXpGFmJWOw5qRTDz+VR1dhHGEcC4vTGkLqXkIBF+zL5vYSdkvBxtCB8PD4qC4BoDImrPxa6bEQvbAnL6NvCgLrXlF6X7k/0CCJF68eFp1k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(11063799006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEhaYUlqdGxxQlVBYWNJOXJJVXBBTy9tS3BXSHZqUnJMYlJ6eG0wWlNBLzlU?=
 =?utf-8?B?TUFYekxMaXpkaUVtZWljSkZZZGN6Tk5mcEExRENERlVYcytjUmtBd2VFUVBG?=
 =?utf-8?B?RW1ET0F0RnZXWjhKZmlkT3VNaEdZZEZ5QS81US9WYi8vajBocmQrODVMUnFK?=
 =?utf-8?B?Ti91a1RFbGQvajB2SEtxa1JzTUN3ZkJ3ZXFWekNMVkRVVDNRZ3A4M2RtODVY?=
 =?utf-8?B?b29vVlUxZFFST3RUVjRBMTZtVzRsK050ZnhMazMraE5lN05DK1FzVmJiNms0?=
 =?utf-8?B?TTZ0Z3U4aDB2cEZqdWxxUzRQejR5d3d0WmJYeSsxblVyU0pRRHhzSlFqenJJ?=
 =?utf-8?B?bFVOdi9tV3BDZDFCVEJVWkN2eURnclR1VkJwQ0JBZ3lXMktncmFJY2wwQmZo?=
 =?utf-8?B?MVhwV3JqYzZ1cFZrQUFTM0FwbVdWWHZvc0tDdFJ0SWVNSEpHdFA0N0VzYkVG?=
 =?utf-8?B?bzduUkdPVjR1eVI0WVp4aXZTd2s0ZGdFZUg5R3JQL044RDU1NjBjOGVubzVq?=
 =?utf-8?B?eDVQQ1UrQ1gvdGl3RUN2Zk9DMkhoUTVsRTJhT0hReGpTNkFmdncvZDlualhh?=
 =?utf-8?B?U1g1amRIS0ZYdWtydlJLa3J5MDh0dUlHcEZsRnNQTHFWYUdrLzdxaEIwNVFH?=
 =?utf-8?B?N1UyTmlIM3Z0YWVhMmJZSnJobzdLNU9xWi9mTDB0a3Rrc1FXdDg3NWE0Nzly?=
 =?utf-8?B?N3lPelV1UEEwZHAxOVNrMWVTb0VJSTl0dU52cVJ2NTlwQUJyaGc3ZzdUelZM?=
 =?utf-8?B?Qjc5ZjNaZGhEYzJFL3NUMXRBTGI1NjFoc2k4NkFmYlRnaXY5d1VaV2NxUkxr?=
 =?utf-8?B?cTFERjdJcU9QVDE5TTdPckNVOC8reTNFUFpZbWFUVXYwczFrR3pTdTRENkVz?=
 =?utf-8?B?VHptNWI2S0tmT0JmaXJsK2RrbC9yb2FIMEEyTlAvNWhoL3J3QnF6ek90cXZZ?=
 =?utf-8?B?NndOYm5XSENCUVZzWGs2d1I4RGRrQ0VRWGw4eTRobC9ncHlINkZrRU16ZjA3?=
 =?utf-8?B?R0FwWXhEdlQ4bU9ZdzdZVnpLWlFNU0NCTFgzZk9mSDBwWi9samVMcit3ZGQ3?=
 =?utf-8?B?QjROaGxOajV0ZlJ3Q3dvZ2Voc1BuTGJmNVVkcDNYdHMvRGR3Y054MVJTOW44?=
 =?utf-8?B?a0lIN0lFaTJLY2RoNXRHVmVkMko3eXlzbG5SdnhpVzdvQ2F0VjY2QTU1bE94?=
 =?utf-8?B?NUtOL3dXREdtMWlUbVV2QnE5VFFnS0JPUW8xaEQzN0dpQ2YwcGg2ZUMyR2FH?=
 =?utf-8?B?aWo5N3RDdVFHcEFRT2dBVzdUeDIxT05hMmVNeFM1MUMxdDQrTG9idlJJUklI?=
 =?utf-8?B?WEs0S1NtZEJCdk5qSlNuNnoxY0ZWOFA2UVhFVVY3LytVR1hnaTQxTG11WlF5?=
 =?utf-8?B?cUVDcUNYMS9wQW9BQnczdCtRMlVGVXNhOHd0NjJ5MU5KV3BhcEl1WmExVW9G?=
 =?utf-8?B?Qk12NlNLaEVmY1BPRUVGaEJpaE1QSFVhd05lNlRKanhFT09POEovSmF1bis2?=
 =?utf-8?B?YWpMQ2NxQTU4U0tZbk1tYzNBYWNDZHhyTkp4dW80SVA5by9IbTZJdkJPNk54?=
 =?utf-8?B?QVBTaTJRWnljWnJ3M2VxcmN1TzZOUGhBTS9IUStqUjNYbGdZaTlURXF6bUk5?=
 =?utf-8?B?bmJlK3QxK1lHV0tHeHFSUE12LzJRY2F0VzRDbnJ4MndQMjNRU21wVlVkSUJs?=
 =?utf-8?B?KzN4d3J4a0JNVG9zbWYrck4zMFUxVFdVLzBDMGk1eG5hWFBNRjd0S1NBZ01T?=
 =?utf-8?B?eGgzWW9kS0dUcXJYUE1BS2ZlSkU3VEhBOGVpZW4zWFQwK1JsdHRCQjlxejc4?=
 =?utf-8?B?Z0F5K0lSYllmeFZRc2t2clZXS0NJTkFjNU1WaWltdTRnbG11K2hqNlQ2Y1di?=
 =?utf-8?B?d21UTkxLUVhqVHpXT2JHdGNvSkR2WUh6eHl3anp1UWJjVTVLNUJKUWxOUzAx?=
 =?utf-8?B?YWVTajZPNlVIVEo5UDFVaHgxZGU2NlFOSEY1S09DZ2QrMEd6SVI0RlRjY3FF?=
 =?utf-8?B?bUw4OEFmRXFNQWJ5T1NlSnNJVzZrdXlBanpuOVFZNzB1NXVCZlJCNld2dDI5?=
 =?utf-8?B?c1FPQ3ArbDJRVU9HOTB1cW9ud3BEanlvTnhLUWhOMnlRQms4WjNRV3Ewcm1N?=
 =?utf-8?B?cUpRYmVESG5UYmhJY0FTNzdFQjI5b3hJSE81bmtZUEZROE1xSWxNejRITkov?=
 =?utf-8?B?R2xVcmFDbldTMG5XWUx2T2thVGEvTG9LVmk3dFkxZGdzR3BSakhmVStiM2g1?=
 =?utf-8?B?K0l1T2hUVndZMWU1NjBUNEpXbXcvVEFqYk1HRlVjN0JpY3hnQldOS1lzUHRk?=
 =?utf-8?Q?hpky+fA+DutLFNttZp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SlXhWx6XqDZmpmWKzuU/w4Ol4b4IWmTTInk/funktIyDWbZgLYL4OUGFD2ZDlc+nlTQxWlXIsLTE2+FjxkJsytowhAX1cBtgqlWb+qQbW4bD13YXHZ84X/eyTVInyHZXHVYZpTSWoK0zQ24IUXdEA4pUmifyGXDQyvAEBYgDNGRxFYUm+h8t+277eMTxRqVYaq487aSVaPWuD6Td//ZUHO7ygMbBK/IpD+8uMzUpe7yZm4m0VtOyWOnIRzW6cHIVUs2hh/obm3SnN/ajHJsQgnTQ+CV3yCudubaxToiQKa4vRmNEmYHBCflkjSCOe10tCg7F8seJl/LUUaM2OoiiyA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7285.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5359794-9cae-4618-85ed-08df4c31436d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 02:50:57.7960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZT4TqRBmLgy1d/WbLsrZfS8fXsqLV7oa+0fsH4ERMoqyP6PlzImYGciHhy3FlDNi1d5pcx2uYFaMldh6BxInCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR03MB10463
X-MTK: N
X-Mailman-Approved-At: Fri, 27 Nov 2026 04:42:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,INVALID_MSGID,MAILING_LIST_MULTI,
	RDNS_NONE,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTA5LTE2IGF0IDA3OjAzICswMjAwLCBIZWlrbyBTY2hvY2hlciB3cm90ZToK
PiBIZWxsbyBUaW0sCj4gCj4gZHJvcHBlZCB1LWJvb3RAbGlzdHMuZGVueC5kZcKgYW5kIGFkZGVk
Cj4gdS1ib290QGxpc3RzLnUtYm9vdC1wcm9qZWN0Lm9yZwo+IAo+IFBsZWFzZSB1c3QgdGhlIG5l
dyBsaXN0IGZvciBmdXJ0aGVyIHBhdGNoZXMsIHRoYW5rcyEKPiAKPiBPbiAxNC4wOS4yNiAwNToz
MiwgVGltIEt1byB3cm90ZToKPiA+IEZyb206IFRpbSBLdW8gPFRpbS5rdW9AbWVkaWF0ZWsuY29t
Pgo+ID4gCj4gPiBzcGlfbmFuZF9pZHggbnVtYmVycyB0aGUgInNwaS1uYW5kTiIgTVREIG5hbWVz
IGFuZCB3YXMgaW5jcmVtZW50ZWQKPiA+IGluc2lkZQo+ID4gdGhlIHNwcmludGYoKSBiZWZvcmUg
Y2hpcCBoYWQgYmVlbiBpbml0aWFsaXplZCBhbmQgcmVnaXN0ZXJlZC4KPiA+IElmIHNwaW5hbmRf
aW5pdCgpIG9yIGFkZF9tdGRfZGV2aWNlKCkgc3Vic2VxdWVudGx5IGZhaWxzLCB0aGUgaW5kZXgK
PiA+IGlzCj4gPiBjb25zdW1lZCBhbnl3YXkgYW5kIHRoZSBudW1iZXJpbmcgZ2V0cyBhIGhvbGU6
IG9uIGEgYm9hcmQgd2hlcmUgdGhlCj4gPiBmaXJzdAo+ID4gU1BJIE5BTkQgZmFpbHMgdG8gcHJv
YmUsIHRoZSBzZWNvbmQgb25lIGNvbWVzIHVwIGFzICJzcGktbmFuZDEiIGFuZAo+ID4gbm8KPiA+
ICJzcGktbmFuZDAiIGV4aXN0cyBhdCBhbGwuCj4gPiAKPiA+IFRoaXMgcGF0Y2ggd2lsbCBwYXNz
IHRoZSBjdXJyZW50IHZhbHVlIHRvIHNwcmludGYoKSBhbmQgaW5jcmVtZW50Cj4gPiBvbmx5Cj4g
PiBhZnRlciBhZGRfbXRkX2RldmljZSgpIGhhcyBzdWNjZWVkZWQsIHNvIHNwaV9uYW5kX2lkeCBj
b3VudHMgdGhlCj4gPiBTUEkKPiA+IE5BTkQgZGV2aWNlcyBhY3R1YWxseSByZWdpc3RlcmVkIGFu
ZCB0aGUgbmFtZXMgc3RheSBjb250aWd1b3VzCj4gPiBzdGFydGluZwo+ID4gYXQgc3BpLW5hbmQw
Lgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBUaW0gS3VvIDxUaW0ua3VvQG1lZGlhdGVrLmNvbT4K
PiA+IC0tLQo+ID4gwqAgZHJpdmVycy9tdGQvbmFuZC9zcGkvY29yZS5jIHwgMyArKy0KPiA+IMKg
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+IAo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYwo+ID4gYi9kcml2ZXJzL210
ZC9uYW5kL3NwaS9jb3JlLmMKPiA+IGluZGV4IDE0YWY0MjY0NjEyLi4xZmE2NjlmM2RlZiAxMDA2
NDQKPiA+IC0tLSBhL2RyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYwo+ID4gKysrIGIvZHJpdmVy
cy9tdGQvbmFuZC9zcGkvY29yZS5jCj4gPiBAQCAtMTY5MSw3ICsxNjkxLDcgQEAgc3RhdGljIGlu
dCBzcGluYW5kX3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpkZXYpCj4gPiDCoMKgCW10ZC0+bmFtZSA9
IG1hbGxvYygyMCk7Cj4gPiDCoMKgCWlmICghbXRkLT5uYW1lKQo+ID4gwqDCoAkJcmV0dXJuIC1F
Tk9NRU07Cj4gPiAtCXNwcmludGYobXRkLT5uYW1lLCAic3BpLW5hbmQlZCIsIHNwaV9uYW5kX2lk
eCsrKTsKPiA+ICsJc3ByaW50ZihtdGQtPm5hbWUsICJzcGktbmFuZCVkIiwgc3BpX25hbmRfaWR4
KTsKPiA+IMKgwqAJc3BpbmFuZC0+c2xhdmUgPSBzbGF2ZTsKPiA+IMKgwqAJc3BpbmFuZF9zZXRf
b2Zub2RlKHNwaW5hbmQsIGRldl9vZm5vZGUoZGV2KSk7Cj4gPiDCoCAjZW5kaWYKPiA+IEBAIC0x
NzA5LDYgKzE3MDksNyBAQCBzdGF0aWMgaW50IHNwaW5hbmRfcHJvYmUoc3RydWN0IHVkZXZpY2Ug
KmRldikKPiA+IMKgwqAJCWdvdG8gZXJyX3NwaW5hbmRfY2xlYW51cDsKPiA+IMKgIAo+ID4gwqDC
oAlwbGF0LT5tdGQgPSBtdGQ7Cj4gPiArCXNwaV9uYW5kX2lkeCsrOwo+ID4gwqAgCj4gPiDCoMKg
CXJldHVybiAwOwo+ID4gwqAgCj4gPiAKPiAKPiBSZXZpZXdlZC1ieTogSGVpa28gU2Nob2NoZXIg
PGhzQG5hYmxhZGV2LmNvbT4KPiAKPiBieWUsCj4gSGVpa28KCkhpIGFsbCwKClRoaXMgYSBnZW50
bGUgcGluZy4KCkFueSBmdXJ0aGVyIHVwZGF0ZXMgb3IgY29tbWFuZHMgb24gaXQ/CgpCUnMsClRp
bSBLdW8K
