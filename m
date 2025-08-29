Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3A6CA0FF6
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 01:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28BB78340A;
	Fri, 29 Aug 2025 03:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="f/ya589v";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="M7wbg4+N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC1A8341A; Fri, 29 Aug 2025 03:45:06 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC7548328F
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 03:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: c0aae08c847911f0b33aeb1e7f16c2b6-20250829
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=z3etEmJls3WDfmnLoDJTNnHqj30sBefkbcdBBG0bml4=; 
 b=f/ya589vo8CSnVCTyDfIaOsc4paSAZkzKyV6YKx7XEmeM1K35jwvdCFl0Mbp2X5hfTcjCzXTjAwZ1xNoacfPihDRZiAYoIYIE55HB+ueCl+YaK6bSWGpwJiWE/A8YZfoWEQmhZD5tyFfZyAc0N345MKiyoctYkMO7oedMBSIPJY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3, REQID:45167c5d-85ff-4437-9f79-39815af6bc78, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:f1326cf, CLOUDID:197f3584-5317-4626-9d82-238d715c253f,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
 t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
 0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c0aae08c847911f0b33aeb1e7f16c2b6-20250829
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1326286607; Fri, 29 Aug 2025 09:44:50 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 29 Aug 2025 09:44:49 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 29 Aug 2025 09:44:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=en+/Knl84+eobqMJSX+hqYmg71fK2yg0tB7xFRAN5LYfWJBU+B3/wxy3Du8/PDqSGAZlMKQo4h9uwXMBqh+qmxMCBWvTcmrzFFxdBvdJGcotXeh7+U7u+JFQo37JbL+aGkwV9kXoECnPDaAx8+38RQ7kbtGGOTBZfwT8bE5BMP/eHo7HT6vd9FXsb34qEcWxnTLPtCBSFgYHA4Ko76O7hiUB7TFuOZOu3v6trlLBdDw4chFm2HQRTA5Bys5u0nB734jktrN0nvswBE64aJA6xGrUnHtdJU+cRmC3zXVlnhrJiQ7OVWYHoWosuOBYl5sG6V/dgVOBsk9+BE1jTvn/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3V8hZpD59UV6+uWun/R9Vzfb2T9JvosB9cbvVTtOOr8=;
 b=UymIDtUT0XNxWOFpsxOSAMz2qSI5ncs+bANJ9O5x+9VIVXsaUxj0Ko9aqKD4Cpnl7dlxWKOafU6Efb8ARupuGahtNPj3ecDJVtIqnTQIpLRbaYkR34rHDAiFfWc67/YQsKBEnhH1OGndZ8ZH1gKbtGNrOELRFT6GJmCl2Zyoqy35aIDC+OSOlsnbq0V7tnpN2w6/SqHur1VMRIw4v3I+EwOaXm2BzsMdrJ6DgFEwqkngBFXW0fQBPOCUs2VUAi041AW5N0lc3wmy7qsqkbd6GBIPfEj8wQm/T36eFCvf/xPX9A1mtC2p58XhqZY+GmcP6YljuGGB2YsH25qu6+B1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3V8hZpD59UV6+uWun/R9Vzfb2T9JvosB9cbvVTtOOr8=;
 b=M7wbg4+Ndep5RIIFsJOCTtSRlhrDyHOgly6aDBz3w35pipIzWfGsG2ecmRt8xT/7vr+I8X0++gQJ31vut/H/3ls5bOkru+fAp4TibTpdlzYUjQQ4M87N0wkYFAyrT4UPkK2Vh7cJBxFKLovFToj+q1F4eaq7JloReTR292FNZxU=
Received: from SI6PR03MB9045.apcprd03.prod.outlook.com (2603:1096:4:23d::10)
 by SEYPR03MB7313.apcprd03.prod.outlook.com (2603:1096:101:148::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Fri, 29 Aug
 2025 01:44:45 +0000
Received: from SI6PR03MB9045.apcprd03.prod.outlook.com
 ([fe80::53c9:58ef:a15f:6183]) by SI6PR03MB9045.apcprd03.prod.outlook.com
 ([fe80::53c9:58ef:a15f:6183%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 01:44:45 +0000
From: =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>
To: "trini@konsulko.com" <trini@konsulko.com>
CC: "rfried.dev@gmail.com" <rfried.dev@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?= <SkyLake.Huang@mediatek.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mediatek: add doc for MediaTek
 MT7987/MT7988 2.5Gb ethernrt PHY
Thread-Topic: [PATCH v2 3/4] dt-bindings: mediatek: add doc for MediaTek
 MT7987/MT7988 2.5Gb ethernrt PHY
Thread-Index: AQHcFzBssJ/do+bz8UKIpacQ20YLvbR20lsAgADYOACAAG0LgIAAxv4A
Date: Fri, 29 Aug 2025 01:44:45 +0000
Message-ID: <d2a5263ad99060c90f8b414db96d45f192c6f6db.camel@mediatek.com>
References: <cover.1756283872.git.weijie.gao@mediatek.com>
 <8c0d6997255a2bbc2e761ed457c51de653cc96c5.1756283872.git.weijie.gao@mediatek.com>
 <20250827182822.GJ124814@bill-the-cat>
 <e13e0dabf7b4adee9b987557c2c54803dcc6075e.camel@mediatek.com>
 <20250828135231.GO124814@bill-the-cat>
In-Reply-To: <20250828135231.GO124814@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR03MB9045:EE_|SEYPR03MB7313:EE_
x-ms-office365-filtering-correlation-id: 858d9795-19ec-46eb-7a74-08dde69da1ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZmtlN1RkbjdERnB5Y25jZGFDYlNyaEgzcjBnTEdKSTBYZVY3RG5tSnpacnhL?=
 =?utf-8?B?YjZwRmk4b0tUdDY3dVlFNWhKSERheVhxalV6TVUxN1A1TS9ETDByNHJqN0cx?=
 =?utf-8?B?VERrRXk1NnZlYjRHL2JoTzdwSDlpZUJ6aXFYQVRaVDh3clBBU1J4QjNjaWRt?=
 =?utf-8?B?aTI4QmZWcEEvQWRLbUQzTHROc3NRSnpMejFXQ3VydkNURE9XYzE3SC9UZjNX?=
 =?utf-8?B?UmlSYlRkUkVVQXpDejQ0RFNyZmwxRzJCTWE4eENibjBHZ2lsSzlyb20yYmVS?=
 =?utf-8?B?Y0YxWEpxOFJZaU9wMjRjRGhRamlabzhPT01tcGFpcWtNYmRjazdKN3dlR1pa?=
 =?utf-8?B?KzkwMnBOemp3dGJiSXE0SU5jVEplRU1qN0RFYURIR3R5ejhzRWFtL0hpQmN0?=
 =?utf-8?B?SjNtUlhQaTZGU0daQjZWdXZ3RWw3bmxuNmtwK0E0U0MyZ0hoMStSNVMxVUxK?=
 =?utf-8?B?ZElNMlVNNkhZeWFTRVNXQVZMVGFlNXZhSld4VWZ3czQwTjQwZ0cyUXFvVHIz?=
 =?utf-8?B?M3VGdXBKcFVIVWxTVjVPeGh5WHpER3UyalFVTkJyR0k5RFBtbEhhdGxVS0Uw?=
 =?utf-8?B?MU83K1ZhZDhReklIc2N2MHZGeTB2VUF0eDE3RlR1NzNSYVJkbjV3U0NSbXJa?=
 =?utf-8?B?SXVFTGM0SlhCTG5JbEdVMkQzQThXZTZrOGE3YnF4SWsrL3k1bjRyNnVWYjJQ?=
 =?utf-8?B?TVRzWjZLWjM1VkdadDFLb1AwQUpvMm92YzMrQStCQmg5cmZJcjlvWi9yRzFy?=
 =?utf-8?B?QWpKV2YzSjl0OGZNVkwvZTFCbG1WY3BqVElHODlsQXE0NkZJdEdGdEMvdmNZ?=
 =?utf-8?B?dXFmY3gwRGFvcnVKNk9EOGpWZ3pPQWRVdlI4bkV5eEo0WnpPMStYdURtMmdP?=
 =?utf-8?B?RlFiUGxDQXV3TzF6eCtXTTNlWTdTOXljRnRhZEEza3RyRFJqcUIzN3ZpeDNV?=
 =?utf-8?B?amhWN09GbDdDeDArVkNZTFRUZ2puRGl2ODFPNHhyVFhYNlNIa0RqRXdLbzgx?=
 =?utf-8?B?a25XSElXb0RlcWxIQXdLcm5wb0RhNGFkeFZVOWJieW5kcVZOWTVFK0IyUjND?=
 =?utf-8?B?Vy8wQzBJWEF4QUVZMUt6c0FUN1QyOGJqWUFodzF2RCtqSldoNkN0REN3VHhl?=
 =?utf-8?B?dmwvRlBSUWx5ZUs4SVJtbHpwSHBERDJTN2hKYWU2QWxUeHZabkFiQ2s3UnZh?=
 =?utf-8?B?OUlIWms5VDJtV1pmNkQrOGhwMGNRWnlzZXZESVRYQWFqbVhrclRUbm1LWVNq?=
 =?utf-8?B?TTM5OGJ3WTBXMGNJRmFLN1J5Z3hjYzlPU3Q4eWxpL0tGMXQ0clFKWW51ZGh1?=
 =?utf-8?B?cXhVNy9POE5SMllXejljRWdSS2ZaOWFSais0Z1E3bGdqM1h1bGVjdmhoSXhP?=
 =?utf-8?B?NFM1MzZzYmV0YUlxVkU5VzJWN01EQWtrWGNYZkxoNU5aaW1TQlppRm1wR2la?=
 =?utf-8?B?UStaV2o1V2s0VHpJRmxSTi9iMXk2bk9tM2RiWHZTdDJPRHd6QTlHcmxiZjlu?=
 =?utf-8?B?ampMbWM5anVvenpCYjdTRmlGRFk0b3Y1YS9XRGpLdTZZQ29MTjZVRGZYNEQ5?=
 =?utf-8?B?QWI0L0RmdlFrdVpsb2tSQkkyT2F1Qmx4OUR3V0xFN29GRzhVZTdkSW1nVU5V?=
 =?utf-8?B?SWZqcE04aDA4d3hiM2pXYUVtT0NET2IvZ1dMYlVWOXNCc20vQ3NKSEppYmtp?=
 =?utf-8?B?cnhjZ3N2OWkvZDJuNVY5dmVxZ1dVZXM2UUhqMWJYRlhyZlJHeTlXR1ExUHVY?=
 =?utf-8?B?YkkrS2ZVbWJJdHVubVNMTlJDbnRsamR6ZVcvcHIzZHdQaXlIUGIvc0thSEtS?=
 =?utf-8?B?S2lqczJKaFZYb3VWdE9ISDRrSXR5REhQb1MwKzg4UmgyMTlHTnoyWktLdDlZ?=
 =?utf-8?B?Lyt2RnRkbUhabnZzK2w5TWdIVGpkQ0hJMldPSWt5dFNHY24yNlZENzlNTnFU?=
 =?utf-8?B?YVd3eUJlbkE0SUgwbWt0alVLU3NpRXdTcGVOb0ZxYWt2b2E1c2o1K1JYZUVh?=
 =?utf-8?B?bm5kYmptYTBnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR03MB9045.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnJwUkQrREF4TFpwWkJzdHVMNHpPZ3NuaTBYdFQ2TG1KQ1JFWHlTM29XY0pl?=
 =?utf-8?B?dXJGYjRtanN2QlYwa2FPSjVpMlJ4MEFkQisxcWlCa2Z2a0JuSngwVWIreXp0?=
 =?utf-8?B?YzB0MmdQM0RFV2J3Zkg1L1J0QmpPUEVoSy96TkNoUDBmbjNVK01uRHhtWWpm?=
 =?utf-8?B?UVJlZFltQlN4dnQ1aVl0WnhaeW5JKzdCK1dzRnBBVHg1ZzEyL1RXeVdyay8w?=
 =?utf-8?B?bUFBbjdkTy90S0VLbWFyWndkcmF0S3c1OW1ZSWIyaC9oSVFVU3NLTTFMNHRq?=
 =?utf-8?B?emxNbmZEOWRKVkJSbjc2dnluVzVweklqdVhIcjgvd3I1QSsvZGhSZm0zeFhI?=
 =?utf-8?B?N0sxdUxKR09LMjJrZnpkd1NJS1JvbkNqS2JsUFpIYWJLT3libnV2cm1mWlI2?=
 =?utf-8?B?WWFrSnVTZmpvTjloL3BPNnBmcVVDcWRaR0dqUXJndWhKd1IvY3ZrVkp3QkFt?=
 =?utf-8?B?aHdWNkhSLzJLTmh6Y2l1dE12S3NXOG5ya3pCN2JzN1Z0c3N6eVBlMjdkUWdW?=
 =?utf-8?B?MVM3bmt1RjU0QkRtdktwZXdhSitTRXRCeng2WGpBY3NXUzlxbEpkTncxZXlu?=
 =?utf-8?B?THVqQjFRRTNOeFJ3Ulp3clVaR1M1ZS96SE4rd0ljbHlpNUp4TjFWZ09oMVdX?=
 =?utf-8?B?MjQ2anU0ejlqOExCNktycWxXSjlialpRV1VuTVFxN28wMUs3SCtJMFVzdVVV?=
 =?utf-8?B?dU1kSVVSc3hhSUpDS1NudGFPY0dQMTEwSCtBRE5GSzRuemF2ay8vRWJicjd0?=
 =?utf-8?B?SnFxRXYvc2FlMjE1UWZMdEx2dzlpaGZQcGpNamVOZGNqVzVodXA4VTc0Q0hw?=
 =?utf-8?B?QzgvdHU5S0E3YW4vOUFtUzEyblR3eERYakZyeUpadWQxeE5ZM3FRU1lYTXpo?=
 =?utf-8?B?eUQ0aGpPc09qMVFwcXFiaGZvN3dxdVcrSW1pTFU5c08zNkM0NThET1pqNTIw?=
 =?utf-8?B?L0paSSt3SG95ME5pTUZUL2lKV2FDMzVlaXVVRWw0STVwUkozYzJJazk4QkZO?=
 =?utf-8?B?K1padnBKS1A0bmVJdDFqWHF6aW90UXBlN1BTQUo1Um9rTVZySlVmbE5wV2lE?=
 =?utf-8?B?ekhDVDVtUlRKTHltdHhSdHpHOGNQZ24xRTNCTTVRTUhUSWJRdmN0RnhRTGkr?=
 =?utf-8?B?YnFLcTI1Nzd4ekZvcEhkamtFSmRsQ2NEOUYzV3o2SmxjOWFKTFp5SGhHOS9s?=
 =?utf-8?B?TEQ1bW9pcGNISTF2eTRsNExJUjdSQmpiclBDWXZqVWc2emFjcS9uSW51ekhT?=
 =?utf-8?B?YkxtUzlxcmJCVk9zY0hTS3ZIU0FmalAyWkhiT0FqWGs2djEvYlY3ZnpiQWxO?=
 =?utf-8?B?VHBQaTRBcnA2RVNXUitSMmhPUXZadUM5VXFRdWkzckJ1cmZmOU0xaWFvMnZZ?=
 =?utf-8?B?cUIvcmgwYllQc040VnZ4QUlUT3ByTTVTRkpXcXF4V1E3SHRoSEpkdVV4Q0pN?=
 =?utf-8?B?VjFablo2cVNuUGx2RFoxVXBUQ00zU1lHY2FaWVBDZ0lzWGNadWxkOG9ZQng2?=
 =?utf-8?B?Tm5aWnJvbjhmVzBsdDBhMWhadnNndG9yRzduT0lJd0lGNTRxcm1NWjh0Qytj?=
 =?utf-8?B?ek5jZ1k0aEpqVno5UWE4V3h5UzVBUWk2SWExK2N5bG1NYWZNZHJqcHlZZ1da?=
 =?utf-8?B?V3F2bERpRGdrRXcwT3ltbTd1cDJXUkh2T1JoMmU4VUZxbXQ2a3NuM1U4aVQw?=
 =?utf-8?B?NXNZbmdqaDIwMVN2U2RBUm5zZE42L25QQTR6dXRvanAxd0VWakxXNDVkQTZE?=
 =?utf-8?B?VWVZWDRNMnI0aUYrOEFkRktNdCtDY2VXZ2ozeXhGcmZMYWpxNm44QTU5WVhQ?=
 =?utf-8?B?NDh0N2c0QWs3eDRSWExBSWdVZTFRcVN1ajNDMkFTeFlia0FoME55V2wyL0VV?=
 =?utf-8?B?SXF2ejUyVFdUQ2pyeS91a2tEZ01rVTlRV1ZKVXRtakxnZk9nUzJ4ZittQ3U4?=
 =?utf-8?B?L0dZRFViL0lPQkd4SkN5aHZoeVJsU2pwb0pTODRwMUVKVG9qb0RKV3c2aGdm?=
 =?utf-8?B?Zm5XZExMSmVvQS9aMGVwNHRMeXlRbWp2eVhiR1Z0SFk3dFRwYlNpU2RSbDlK?=
 =?utf-8?B?K2Q1dEZ1M0pBaE1VSEExR3RTekQ0ZWpaUU1oNCtwQjR0dFkrTE5Bek9MTmRD?=
 =?utf-8?B?SzBGNy8zZ2pDYkpRVm9tUWphVHpFMzFaTTZ2TTBPRmcwSjNMR0ZzdkVEaVoy?=
 =?utf-8?B?cWc9PQ==?=
Content-ID: <CD180B069726E340ACC5F28392FD9D5B@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR03MB9045.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858d9795-19ec-46eb-7a74-08dde69da1ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 01:44:45.7256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jh/ZlO1raoDV+Fiqh8yUIjIw1yHb8xP9e2G/B+/HFEBjAjlDtqt8r8PWoGLnGlnzQNGSyfTaXPl2pX8hwMWgYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7313
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

T24gVGh1LCAyMDI1LTA4LTI4IGF0IDA3OjUyIC0wNjAwLCBUb20gUmluaSB3cm90ZToNCj4gT24g
VGh1LCBBdWcgMjgsIDIwMjUgYXQgMDM6MjI6MTRQTSArMDgwMCwgV2VpamllIEdhbyB3cm90ZToN
Cj4gPiBPbiBXZWQsIDIwMjUtMDgtMjcgYXQgMTI6MjggLTA2MDAsIFRvbSBSaW5pIHdyb3RlOg0K
PiA+ID4gT24gV2VkLCBBdWcgMjcsIDIwMjUgYXQgMDQ6NTU6NTRQTSArMDgwMCwgV2VpamllIEdh
byB3cm90ZToNCj4gPiA+ID4gVGhlIE1lZGlhVGVrIE1UNzk4NyBhbmQgTVQ3OTg4IHBsYXRmb3Jt
cyBzdXBwb3J0cyBvbmUgYnVpbHQtaW4NCj4gPiA+ID4gMi41R2INCj4gPiA+ID4gZXRoZXJuZXQg
UEhZIHRocm91Z2ggZXRoMSBpbnRlcmZhY2UuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIHBhdGNo
IGFkZCBkb2N1bWVudGF0aW9uIGZvciBjb25maWd1cmluZyB0aGVzZSBQSFlzLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU2t5IEh1YW5nIDxTa3lMYWtlLkh1YW5nQG1lZGlhdGVr
LmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogV2VpamllIEdhbyA8d2VpamllLmdhb0BtZWRp
YXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+ID4gPiAx
LiByZW5hbWUgInBkLWRpc2FibGUiIHByb3BlcnR5IHRvICJoYWxmLWVuIg0KPiA+ID4gPiAyLiBy
ZW5hbWUgImdiZS1taW4taXBnLTExLWJ5dGVzIiBwcm9wZXJ0eSB0byAiZ2JlLW1pbi1pcGctMTEt
DQo+ID4gPiA+IGJ5dGVzLQ0KPiA+ID4gPiBlbiINCj4gPiA+ID4gMy4gcmVuYW1lICJhdXRvLWRv
d25zaGlmdC1kaXNhYmxlIiBwcm9wZXJ0eSB0byAiYXV0by1kb3duc2hpZnQtDQo+ID4gPiA+IGRp
cyINCj4gPiA+ID4gNC4gYWRkIG5vdGUgZm9yICJyZXRyYWluLWRpcyIgcHJvcGVydHkNCj4gPiA+
ID4gLS0tDQo+ID4gPiA+ICAuLi4vbmV0L3BoeS9tZWRpYXRlayxtdDc5OHgtaTJwNWdlLXBoeS50
eHQgICAgfCA2OA0KPiA+ID4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRv
Yy9kZXZpY2UtdHJlZS0NCj4gPiA+ID4gYmluZGluZ3MvbmV0L3BoeS9tZWRpYXRlayxtdDc5OHgt
aTJwNWdlLXBoeS50eHQNCj4gPiA+IA0KPiA+ID4gV2hhdCBpcyB0aGUgc3RhdHVzIG9mIHRoaXMg
YmluZGluZyBpbiBMaW51eD8gVGhhbmtzLg0KPiA+ID4gDQo+ID4gDQo+ID4gVGhlIGRyaXZlciBp
biBsaW51eCBrZXJuZWwgaXMganVzdCBhIGJhc2ljIHZlcnNpb24gc3VwcG9ydGluZyBvbmx5DQo+
ID4gbXQ3OTg4LCBhbmQgb2YgY291cnNlIG5vbmUgb2YgdGhlc2UgYmluZGluZ3MgYXJlIHN1cHBv
cnRlZC4gVGhlIHUtDQo+ID4gYm9vdA0KPiA+IGRyaXZlciBpcyBhY3R1YWxseSB0aGUgY29tcGxl
dGUgdmVyc2lvbi4gV2UgYWxzbyBwbGFuIHRvIHVwZGF0ZSB0aGUNCj4gPiBsaW51eCBkcml2ZXIg
bGF0ZXIuDQo+IA0KPiBUbyBtYWtlIHVzaW5nIE9GX1VQU1RSRUFNIGVhc2llciwgYW1vbmcgb3Ro
ZXIgdGhpbmdzLCBJIHdvdWxkIHByZWZlcg0KPiB0bw0KPiBnZXQgdGhlIGJpbmRpbmcgZmluYWxp
emVkIGluIHRoZSBrZXJuZWwgYW5kIHRoZW4gaW1wbGVtZW50IHRoaW5ncyBpbg0KPiBVLUJvb3Qg
c28gdGhhdCB3ZSBkb24ndCBlbmQgdXAgaGF2aW5nIHRvIGRlYWwgd2l0aCBpbmNvbXBhdGliaWxp
dGllcw0KPiBoZXJlLiBUaGFua3MuDQo+IA0KDQpJIGNhbiByZXNlbmQgdGhpcyBkcml2ZXIgd2l0
aCBhbGwgZHQtYmluZGluZyByZWxhdGVkIGNvZGUgcmVtb3ZlZCBhcw0KdGhleSBhcmUgbm90IHJl
YWxseSB1c2VkIGluIG5vcm1hbCBjYXNlLiBObyBpbmNvbXBhdGliaWxpdGllIHdpbGwgYmUNCmlu
dHJvZHVjZSBpbiB0aGlzIGNhc2UuDQo=
