Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB32F33A61
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 13:52:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D078382A;
	Thu,  5 Mar 2026 14:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Hz0i/5sy";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pbtGOQ6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82D06839A8; Thu,  5 Mar 2026 14:52:10 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD59F81E18
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 14:52:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 79a3adee189a11f1a39cd589f645bc18-20260305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=OUXK3xEyZloqHaUHcnGeYmVGg1IBqUJ8la75+spxseI=; 
 b=Hz0i/5syBpZv6iPUTtIr5SACvBwz0eGu2yDDiK8u6imAfI4Uq2wUSjtrG4TXu2peSaUZj/SlBBIrofgV1cyP+PA+56mBI0hBu/x9h/CrCBxsYBPwVFm1IG9LKaYJ4ATH53g4Vy3FWtwB9cdLzJjghs0sl923V2agwFKEDCXj9G8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:d1eb947a-483c-4c27-a0a4-16a0ea62a6f6, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:fe528f7b-8c8a-4fc4-88c0-3556e7711556,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 79a3adee189a11f1a39cd589f645bc18-20260305
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1803858315; Thu, 05 Mar 2026 21:51:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Mar 2026 21:51:56 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 5 Mar 2026 21:51:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLXN1aRv9fzVJJ5h5xq8Im5DFI390WXO71uacA7/LP8Jz5BkSYKfs8solbTKObXS9NYkf1akMr+HVY4uBJoQ967REasbPNK889T9etN8Mrwt0wF97VzaqQ1LLEzPgrRkK+c2uYY4vkg6xnXMHMNWpV8knGWuGpjrOiZa5/yBhqyKqssopqMjE98OTUtktmryD1E0OZdYNAY30IaKrg2leJY99xEAHP53ii1gjHkGcR3xTQ3J+anLER5ZrzZIcz0Qi9jCEBqJxo4YV1Y7UFim2OvDm2tx0XRPFf+bDUEvSv+Hp0EKui8ikR48yVSHwA2HOQxPTgKyV/WG0FLSJD7FgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUXK3xEyZloqHaUHcnGeYmVGg1IBqUJ8la75+spxseI=;
 b=naTcu6JyU1o9gLBWzXdOViX0C0MpjuVCSiCapCyHghbuCIdL2+d5eq0MNnKz8Uawjb5u0BoseMNCU1v9Z/M4dL5Jz2Eu9TwzwmKHGLWC1BLFdESESpsiQtJBZxgxxKjzWUuBxrhsO8zHvmyLh0VuXILwaIp5W1cCYe1c/6xHfb2ykLHYVJ0qPEoRqnJnpik6ZSF77krT0pZZlGg23SeyAAk7WjHe8g2oIxwzrd/JJpARSIl1JkRwENP9IqD7dYkJ1BqDwfwt7xG9UQx5udYxICE3TFBAVERUsBLyx5DvN8DNqxL23UIRMiBoXpjS15F5rwSoQ4W76vJ4dHsaQRSOOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUXK3xEyZloqHaUHcnGeYmVGg1IBqUJ8la75+spxseI=;
 b=pbtGOQ6vtJD2noRoh/bhM2UdavoYU207mvUO+WRQJ1PD8Bb4+fJyHo5lPo1amLykCfksOKPaJ+8Tot7l0+nZJ30ktxbzE6Dip9uVckK5IbhB/qoOsgdBNfVbMFJ35OuiLsonY8cc2aW3WSK00URdMPkHGOAOgQ0mTmK9I3N3NJs=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KUZPR03MB9734.apcprd03.prod.outlook.com (2603:1096:d10:61::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 13:51:52 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 13:51:51 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "lukma@denx.de" <lukma@denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Ryder Lee <Ryder.Lee@mediatek.com>, 
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 02/14] clk: mediatek: mt7622: convert to struct mtk_parent
Thread-Topic: [PATCH 02/14] clk: mediatek: mt7622: convert to struct mtk_parent
Thread-Index: AQHcqqGGdqdRM/1d0EmYWhOCqnSXBbWf+SsA
Date: Thu, 5 Mar 2026 13:51:51 +0000
Message-ID: <1bf42a43858b8617e1e39c4c5464610ca7e56e6e.camel@mediatek.com>
References: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
 <20260302-clk-mtk-unify-mux-parents-v1-2-32f45085f4d0@baylibre.com>
In-Reply-To: <20260302-clk-mtk-unify-mux-parents-v1-2-32f45085f4d0@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KUZPR03MB9734:EE_
x-ms-office365-filtering-correlation-id: dd38ffd0-d401-4a90-c932-08de7abe5aa2
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: lq0Q+bBqw/4trXhJFQjJkSMq2RDyYIVOSJsdlcx1in4PV09Xi/eb+u2oq3mSvyYheIVqHeMLwMJxaS7QNGW1drjJukwZXZhVmaxNoA1Kjy05HhJ99IWzRYu8nI3BhGPhbuuxpcUQTXX+p7Q837OfEcsIo/qhw+ok9vlWWAP3N2DQ1CpfkdPXOE7V3CmU+UoJdeQsSs9VXw0bzkQbKvvVlB4WJc9wFC4jGt4vvr+4wxP29ROZ/9Y0/+rxKPOEZk6sH5W/z8qAkRCmGXUqdU3JV2vB/z3B7HTCsKaj1dOEhZPctwMfUXHFFcb/EJfOM2Wm1wpirW3Chh3lDKgxQqV2L4Jt8FG0KKAtDHmzxtqSm+8aZDDGxFBI2KxXjeO+HNy8ALDBc3qlE5cCd/f9U1K7/dQRhvW1k1ypPQ3jMTPKk7QCVN61NVrOHcvn3BCQbwPmpANfH0Z3NGrzyTkTWTaiXYmyjtMuJgyAkYYX+uJ6LU6MpKFrYRSbaIXr5BG6/WGB9fFJIn1OW6p44gQLf5+72FgNf7HTJVWvqvu/LOpUprfY/fF6HSgGEaQ2ialRY0Rqpol8XXUGqm/5Vvwd+gZmj6XS3T4tW1drBXrs4A8VCdAzR8eI/yxyb66bOS9WaHYheKvOHvmVo7b3dAWiuMZFU9BGnJ+KkK1U+PXfyNGM6tetaSolV3eq58EhhkAXqVuGCuF4QjOa+sblRIOqwyD/91+17fjc8GB6+BITb6UDwD2mM7Lj8lzqBSsEsqF1TI6qRT6txbo7C34KQxVMW7orS3EXFkLc0iMUXTPH00cwRfq0k0zkAGuUvBlN7D1cBZ4N
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b00zK0RpdlFSeFdYY1NEaHBaekdsNlVkZGY1TFNsMmtjUG1KMnc4bGJCbjFW?=
 =?utf-8?B?TERjbU5lYTNraktEVW5Wc1QwMUF0VEpHZk5HTWRYcFJFdmhzYk9Ed01OVmZS?=
 =?utf-8?B?cC96TE5GSXJoeWtFbmJPZ0NCdExyQ0NEMFhYcVpMM1VsbnJ3dERWWWYzR002?=
 =?utf-8?B?RHBTcUQraTkweElweVJPeUZsQndvaVVBWEpDcm84dUpzMGVvZW55K2JsNHR6?=
 =?utf-8?B?MkFZdk9RSktYNEtHdU9DVGhGMjVjR09KMVZkNGtsMEd1SnM0M0xSU0xpSG1q?=
 =?utf-8?B?UkR5V3N2NUFPOFBZaEYwRVloSGhTczJ2SnBHTEh2KzJiWStBU0tRNWo1S2pU?=
 =?utf-8?B?M3NTMTV6elhtUCtFTlNGTWRsWWoreHBGdmgxMjlTK2g5VzIrQWp3VUJzeUFP?=
 =?utf-8?B?SGdCMXJsN1RaVERPUzBjZ1JPem02TzBoQy9xUlA2OGQ0K1JOL1FnNmJtWjIz?=
 =?utf-8?B?S0w3UXcrNGRqeFNCUlF1ZS9Xalp0MmVZdzU4ODBOU200bUwzRGFoZW5KSmxl?=
 =?utf-8?B?U0xhV2JiMWt0NTB5OXloVlB4cStaZFQxSEVrYzArVmJSNmU3WDExTlIvRnVv?=
 =?utf-8?B?MzRJSTZmS0lBekZXYy9tb3hnWXEwTi85R2ZMVHErNW9leWV0K1NReEltQVFi?=
 =?utf-8?B?aXJhWS9MZDNoQXFMWHhjOTltcWRtOTVteG5xRjNpSms5dzViWElkTVEzcDcr?=
 =?utf-8?B?ZnpYZnFmUWY2WEJXSzBlN0RkQ3JQa2NwZlZ2aGxoS1BZeXAwdEhwZHQ2ejQ4?=
 =?utf-8?B?Mm9NdjBZOURIQWpUbllsMWxDMzNFRGFBZ3hDL3V4MkhMMXNORE5CdHdoSnBl?=
 =?utf-8?B?RlFob1FOdVFtVGd1WVFTQlRwTkV3NDI1VDFRblFsOGNUbWhzVEJEdnJyeGZZ?=
 =?utf-8?B?WTBCVURuM04ybU1yNUJQK1lHK2Z1NnFBSitSY3lHMldoVUVDTHg1ZHBMWTVT?=
 =?utf-8?B?N0p1Vjl0bWswRnBld3E4eEVwazhEOGdXcDZDSGtaQVptZnpSTGlpZDlzbDMz?=
 =?utf-8?B?RVZXb0V1bGdIU0JNY0JoK3R4L2pON2FKSnlpejR2eDNqSlcycUtsRStSYmd3?=
 =?utf-8?B?ekl0WFQwYVpIaUxiNGdqVTEydGp2WFJZNVZUaHRnbE1MWXVHbW5vL1JFWUxI?=
 =?utf-8?B?S0oyOVgyNEx3eEFjSzFaYWNmT0R3YnRtR0tZTjQxQ2I1YkNoeWdSUzJ0WFV2?=
 =?utf-8?B?UXNUeS8zbVVIcXlzODY4Qi9SQS8xbUczV2MxemJocFFMNnc2aVJqd0NLS0Nw?=
 =?utf-8?B?WjQzY0pDK0RUMlJ3TGJoMTNGdVZlcUNubDNjQU9HbHRJSURCVGNDK3lPdXg2?=
 =?utf-8?B?NW9NOStOV25OZmdXQUk1U1JGR3duREtWUitkL3BBODlQNDRub1FkTFJqVUk4?=
 =?utf-8?B?VDdDWUJ3R3cxcHR6WUxXR1BXUFFCeFJVWldSNkZrNEQwY2t4d01tMzBiVnFl?=
 =?utf-8?B?K2ZDQy9qNllkQXhnUnBERFV1Y0FwZ1FTTnMzT3R2Y1M1NDFUM0VpWFNqbnlu?=
 =?utf-8?B?OHF2NmltSXdOOVRoa0svS1YycjFCbi9sQkFGMHRhVWpjK3YxZkp6QkltTGFD?=
 =?utf-8?B?eHBtWDdwM1dpV2dzcExGV1hsZGpjQnYwb21vYTBiN0tXOXc3REJMSExoNThn?=
 =?utf-8?B?UnZ0NC9SZVUramxhWWRackI4Z1lXRWhibFYvU2w5TTNhVFM5d3FUT2hQa3Ay?=
 =?utf-8?B?US9LKzBCbGhzejVZUDhjeERTZjEvRjZwNHpKOFBRTU9yN1pRdEJId2tyTWg0?=
 =?utf-8?B?OUhlWE1jNXRxOFJVVlB0c1hjNFpOSWJnT3RtcUNsNyttQlJNRUJvRVJ1TUtV?=
 =?utf-8?B?UmVuZWFqd3JTUzBjOVljcGh3bkIwTVNhMTJsYTFIMGhKVFZ4d3BDam5kSGZ6?=
 =?utf-8?B?RlpjS3M0b1VmUktGOC9DbEFRVnBjLzFHOW9qSEIxb3dFSVU3VGd1WWg3d29G?=
 =?utf-8?B?c2J6cUFLTzNTQS9VK01lblNZL0FvOTlmTkNVUFpBSWlJL0x3OXYrWTFnN2k1?=
 =?utf-8?B?dFYwN2JqM3N2eXdTSWl4R3BkanNVTUVOS2t3eTY0TWJocjVHaDhiTXN1Vmti?=
 =?utf-8?B?dHZweWt3WVlHdGVUck1CTHZ1WXArV1hkVDgweWcyQ0YrYVhlSFdqeGZ1SS82?=
 =?utf-8?B?bnhWd3NodWd3SzJSZ2grTUxhRnptQTNJMUtEc2dkbHExbndsZFhDRnhOK3o0?=
 =?utf-8?B?Zkx0NmhTenpLUzQyNTZjQlBhYkRTNnpBL2VWa21aSHRxaXV6NFpsbTVQWlZ5?=
 =?utf-8?B?emxONFh0dHJWN3dROHJtR1hKWHJIK1FySmZMM2puUWFPUDJyTHByL1VCcFJI?=
 =?utf-8?B?UFpLSlhvbVhNQzFpWVFhbVZpYUhCTjBMekR2WDRGMGNHYlV3dnozT0hiVzNm?=
 =?utf-8?Q?37+6OlP1brv9IusY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E67E1A0CE01804A895FBC013EE3D07A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kaC+++jw5+zp17Wx3gWOrYVNYjirgNS77T5ons1caGCH3FQdXYvFrPs/FEioTv8Xfhz/qYwPnE7fvopHcDdiN2gwGKWotcVNvajZ5yVII8zhlEG3PnJwjUODxOoTZkp77TJJrTvUgzJzxulYmSTvBPEqgBqq/t7eL0kE71eqvApr64UcYn/osrJty01X9OXuoDCjTTHRZHY39tr19ADk5xAX+6gwTkFnK9HkFOGHI89X8xRsQyJ563k4WwY7c3nfNZwBCaHLvqR1QGKvAOzuwxkdfDgGVBffti3uBrFpI/M29hPPQWDjHxL12k+AYXbQysIlXOJZO6NQyDP+uiu83A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd38ffd0-d401-4a90-c932-08de7abe5aa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 13:51:51.6015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdbW9UN4bq2AksJga/Vri2gOyhYyA5zwLHIw4wQ5/zHQPNFwZCONq/L3WbDDOPRwmqzxxMRDkTwHgRTNDOYhhFSxfWNg5sXsoc2XmKXMjsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9734
X-MTK: N
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

T24gTW9uLCAyMDI2LTAzLTAyIGF0IDE4OjAzIC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBDb252ZXJ0IGFsbCBwYXJlbnQgY2xvY2sgYXJyYXlzIHRvIHVzZSBzdHJ1Y3QgbXRrX3BhcmVu
dC4gVGhpcyB3aWxsDQo+IGFsbG93IHVzIHRvIHNpbXBsaWZ5IGNvcmUgY29kZSBsYXRlciBieSBo
YXZpbmcgb25seSBvbmUgcG9zc2libGUgZGF0YQ0KPiB0eXBlIGZvciBtdXggcGFyZW50IGFycmF5
cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJl
LmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10NzYyMi5jIHwgMTEg
KysrKy0tLS0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA3IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDc2
MjIuYw0KPiBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDc2MjIuYw0KPiBpbmRleCA4OGNj
YjRjYjhlYS4uYmMxYmFmOGM0ZTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVr
L2Nsay1tdDc2MjIuYw0KPiArKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ3NjIyLmMN
Cj4gQEAgLTQyMSwxNiArNDIxLDEzIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGUgaW5m
cmFfY2dzW10gPSB7DQo+IMKgfTsNCj4gwqANCj4gwqAvKiBwZXJpY2ZnICovDQo+IC1zdGF0aWMg
Y29uc3QgaW50IHBlcmlidXNfY2tfcGFyZW50c1tdID0gew0KPiAtCUNMS19UT1BfU1lTUExMMV9E
OCwNCj4gLQlDTEtfVE9QX1NZU1BMTDFfRDQsDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19w
YXJlbnQgcGVyaWJ1c19ja19wYXJlbnRzW10gPSB7DQo+ICsJVE9QX1BBUkVOVChDTEtfVE9QX1NZ
U1BMTDFfRDgpLA0KPiArCVRPUF9QQVJFTlQoQ0xLX1RPUF9TWVNQTEwxX0Q0KSwNCj4gwqB9Ow0K
PiDCoA0KPiAtI2RlZmluZSBQRVJJX01VWChfaWQsIF9wYXJlbnRzLCBfcmVnLCBfc2hpZnQsIF93
aWR0aCkgXA0KPiAtCU1VWF9GTEFHUyhfaWQsIF9wYXJlbnRzLCBfcmVnLCBfc2hpZnQsIF93aWR0
aCwNCj4gQ0xLX1BBUkVOVF9UT1BDS0dFTikNCj4gLQ0KPiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
bXRrX2NvbXBvc2l0ZSBwZXJpX211eGVzW10gPSB7DQo+IC0JUEVSSV9NVVgoQ0xLX1BFUklCVVNf
U0VMLCBwZXJpYnVzX2NrX3BhcmVudHMsIDB4MDVjLCAwLCAxKSwNCj4gKwlNVVhfTUlYRUQoQ0xL
X1BFUklCVVNfU0VMLCBwZXJpYnVzX2NrX3BhcmVudHMsIDB4MDVjLCAwLCAxKSwNCj4gwqB9Ow0K
PiDCoA0KPiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGVfcmVncyBwZXJpMF9jZ19yZWdz
ID0gew0KPiANCg0KUmV2aWV3ZWQtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRl
ay5jb20+DQoNClRoYW5rcywNCk1hY3BhdWwgTGluDQo=
