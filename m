Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373E2CA0FE8
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 02:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 131098328F;
	Mon,  1 Sep 2025 04:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="O34WZ6FW";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Kv+bv24m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 503238328F; Mon,  1 Sep 2025 04:24:22 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBBF7831B4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 04:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: ba88feb086da11f0bd5779446731db89-20250901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=sKq+iXAiCs0NFPu6AZYcQxlRjbYrEeQUPDWjy+pBYnQ=; 
 b=O34WZ6FWGCM4lff0Zuylq69f3Uyqxnhcn96B6ERb3Q4SZBZAIvolnK+DdCBaP6QRv6DBGqburKPDWU6cIPMNLVoH/F3rdqBOOtP0N7Og3d/QtPg4D0VJ3mWz1Z7xMJorsdKDm6NBJ/tvP0SoAoP3uxNKSB0+SqlkF1t9eLgXSyw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3, REQID:2fb9fb41-7b8b-45d7-bf7c-f6a931be8680, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:f1326cf, CLOUDID:7b390e6c-8443-424b-b119-dc42e68239b0,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
 t:0|15|50,EDM:-3,IP:nil,URL:80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
 OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ba88feb086da11f0bd5779446731db89-20250901
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1239016884; Mon, 01 Sep 2025 10:24:03 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 1 Sep 2025 10:24:01 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 1 Sep 2025 10:24:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8v/8nqxqEjQJmei8JFZcyb4Ov1RbKavJ9Aa+2gnMZg9udJDu5jY2s7lQZPsowgu90fUyPP+sfH6XKlEeTxsl7QlO0DVMbEZcQ/nC5yGHvC+B9F9J/YPBsP0T54tXOko4G9jCpdDXN3p6XoYFzmkIclr/L0rLUNt8FD/pVA44gPryNFEA+vQI5gk8TzvQWhbKpEKe10m4lvAA/QUQn07dtws1Qxo5Ha7WnsITfFK6Mfkan6tefDAD+h2lBFlXzOKMMcQ7sZWHQil77ohromAG5NrGayFogfXP9RayaMHDvPGUujom/vpILIo+MFjaYyqHUJPpj0Opjfl1XLY6ESNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jv5leuJWsJgmpCBzEisHnM75Fn6hIpyeTxUvyCviA0g=;
 b=OYRSk2UNtPL+5YXUl0CZSYUPn8dCWeqvkowoJwIoCvTk9RnudDQNp9OB+B8iljPLsh4fo9zmYkWWLVqWTPzaw4LNzJZZb6NbsNUOUzJPaznDjCeY0QiV9eYuuu1t31yhXljO8HzuqNvPIC01RzbXxnbXnqqR95Bq+b4zZkh/y3vJCZpZFBX36dr/LPg3uGudezag1fFGMpPi6mm2oYzmaDutOHkzwsKfcPAwZLjpWUpIwkFWBXlriggiO+uhEMANS8vtuIEbq8PPsGONNoO52rvnc+LUKn32JBoBiKBNi39g1mNcwYTCRaM2asrT7P9JGdL2D2jmffph6jVyjWJdyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jv5leuJWsJgmpCBzEisHnM75Fn6hIpyeTxUvyCviA0g=;
 b=Kv+bv24mQbARnU/3vsdYoMmlgcS36YX+pSb7t3RPzGyf4PzaQdmvwC31727rdhULzAZop3x11bNQGpz9QQCLjqjUHOyKEK6zy4Rg43o18T3iquv+oNh6ftTY7LuZf8P0nIySXKXnuaMVfe0x9GquDP45RnB+uuQPEUH3wCMD5NU=
Received: from SI6PR03MB9045.apcprd03.prod.outlook.com (2603:1096:4:23d::10)
 by SEYPR03MB7663.apcprd03.prod.outlook.com (2603:1096:101:139::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 02:23:58 +0000
Received: from SI6PR03MB9045.apcprd03.prod.outlook.com
 ([fe80::53c9:58ef:a15f:6183]) by SI6PR03MB9045.apcprd03.prod.outlook.com
 ([fe80::53c9:58ef:a15f:6183%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 02:23:58 +0000
From: =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>
To: "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>,
 "mikhail.kshevetskiy@iopsys.eu" <mikhail.kshevetskiy@iopsys.eu>
CC: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Ryder Lee <Ryder.Lee@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "emanuele.ghidoli@toradex.com" <emanuele.ghidoli@toradex.com>
Subject: Re: [PATCH] airoha: rework RAM size handling to support multiple RAM
 size
Thread-Topic: [PATCH] airoha: rework RAM size handling to support multiple RAM
 size
Thread-Index: AQHb+zjLofzzXdwBeUOpwxSP1aZdmbRBFZWAgATPZgCAAAGCAIAqhgiAgA0D3gCAAGgZgA==
Date: Mon, 1 Sep 2025 02:23:58 +0000
Message-ID: <67e015afbc3a72da271c008e09303e70934f7f93.camel@mediatek.com>
References: <20250722184426.6964-1-ansuelsmth@gmail.com>
 <a374f7d9-b658-456c-bcce-30fa501f505e@iopsys.eu>
 <68861451.050a0220.a546a.2ace@mx.google.com>
 <2c6a55c7-e4b0-4af9-ba66-ff5cada14de0@iopsys.eu>
 <68a9c171.5d0a0220.2720d2.b8b7@mx.google.com>
 <329a2055-3dc4-45a3-9d24-0ded3d4b8527@iopsys.eu>
In-Reply-To: <329a2055-3dc4-45a3-9d24-0ded3d4b8527@iopsys.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR03MB9045:EE_|SEYPR03MB7663:EE_
x-ms-office365-filtering-correlation-id: 6219581f-ef7b-43ee-be7b-08dde8fe9b9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WXRQMm9XK1Z2dzIweWYzQ0hyL0xzTm1pZjlSS2plUlVuMWlKYmxFZWFlNzdO?=
 =?utf-8?B?cmlpd0RVeDZpMW43TW94bjNGT1o3L3Z2dHFMWDZCV0FTcnJ5NW5lVHNlUmxv?=
 =?utf-8?B?ZDl3Sy9WWXlVY05IZ3NRRHBiQXhTUmN4b2llOGZ3Yy9telBsRW54VG12RVlz?=
 =?utf-8?B?dDRqMWdva2dXcWxiTFJGbUtKei94T3lSaWVleTdPeDNVL2JhU0pLVUhCdGxP?=
 =?utf-8?B?NUlGcVJ5d0dqSDIzUVNxWHRHUWlCeGpycFd5WUVycUZVL2JUc3hIQ01kQnJJ?=
 =?utf-8?B?b1E4MVNPemQzSnhiWHg1SWkxL3JsN0IzRW5JOHpCQlh5NElOR0pIZXg5Sm5O?=
 =?utf-8?B?VG1KTGRuUFVVOVZXckVVcmJSS1JIdTlLbFBaZDVQUEVlY0tvRi9ZZy9Oc2k1?=
 =?utf-8?B?YjBrQVEyTENEQVU5UFV3Y0lCK0RQOXVHYkJmNWJ5TWVLZW94YU9ieGJpVWJs?=
 =?utf-8?B?NHc1VjJHSm9pcm0zZ3JRNytObml1OEpDSHZwL0tiNDVCa0RhOUFPenRNQzFZ?=
 =?utf-8?B?ZTd2Njc5Z0licU9qRkw1Z2hiWDRUYnFmZEFiZERyemdJOTM5aDBsVG9DQ2d1?=
 =?utf-8?B?a3RtVU90bVZXY3RleFRzS2ZFZDZlY2xOTlBveHluM0FwQ2hjWm5la2JDOVBZ?=
 =?utf-8?B?M1kyQithRWVZOGo1dWFFNXVUTlhyMHJBVVBGWktBY2NTSTA3SmxYbi96ZGJ1?=
 =?utf-8?B?eTI2dnkxcHpacUhjbjZIamhtemlsTzAxTFJxdTJMVEVkK01BYW9qUFhMTlRt?=
 =?utf-8?B?TXY3TXVwYmxJeUp6SkRjNHU1OUtrdVcvS29RWHVyTkc5Qm5mUnd5ckZSOUlZ?=
 =?utf-8?B?OVRhbU5HWXlQVmVxQmRqWjdtTnNxdHFzYklRclcyblJkS2R2OVVuNWplOHY2?=
 =?utf-8?B?NWNCMDlrZXhIZ0NNQ0Joa0p3Szg0MU1NSEdpNU9XS0ZKTzE4ZG9mOHgxK1Vt?=
 =?utf-8?B?QkZMZkpHSGxJYkJMekJVYmcyNmgvMnVBRml1QUhpajU1V1lOWkRZQkxzU2NY?=
 =?utf-8?B?WW1Qc3orZW1Fc203Vk5sbHRwQ0V5Zkl3dFdmQWpDNkh1TVJuK2QxZ1F0VHlq?=
 =?utf-8?B?U3JQakdsNlUyZEhrdWdJZ1cvSlhOUklMTkdEVU9qOHppVWpGUjVEK0pSbWVw?=
 =?utf-8?B?ejl4b3dYcUxPblhMUDhxUVBRVXF0Q285RWlSOXowUFloendFei9wT0VzM0ln?=
 =?utf-8?B?cmh4aVd0Z2pUZHRPTkpzWU9maHYvbG9jZDhIZmpLZVdiQXU4WGNqeFZnNHht?=
 =?utf-8?B?V1ZFUys2V1k3UWVGRFh4cnovbkVRU2VMZWtOZmdWMUh5azNaTFhMU3V2dDIw?=
 =?utf-8?B?dDVrOUIxS05Wa2xiQ20xcUp1L1NIUC9lb01jcTI5SUtsTjdoeFA1UTVXMS9K?=
 =?utf-8?B?K085N1YwblhzaW9ZbVR4SlNqYzBDQ1UxdWRtN2kzYXlSRmk2ak1aWXRpQVAw?=
 =?utf-8?B?ZlFUaUQwMGFSQndhOHhEWUpFWW1XWWM1YW5ZSEdUMWtqMTJLTnJtU3dUejQ1?=
 =?utf-8?B?aTlLU0w0bEZWdFBMV1MrdlNWTTJTVVVHcUI1czRsTFFoQ2NQNGhIRk9LZjFN?=
 =?utf-8?B?RFg2K0hxby85VEMxblN2eVloamkxc3lybm9ubVR6WDZiQ3U2RkZrMHZUbExH?=
 =?utf-8?B?Y29Vdjk1dFNJd2J0UkJmQWdNTldrT2dxWUJ6SW4wQUFDWi9mTEx2SFlKUmtk?=
 =?utf-8?B?TlBaMkFoaWdFTkoxa0N4Rjk4dTUxeDhoRFkvV0dibjYzRjJqYURDUFJIYUpP?=
 =?utf-8?B?ajBiZ2dCVTBhUmhyRHlFVjk1Ti90c1FQSzJyN2xsdHdiSWo4anpORWxPS0pu?=
 =?utf-8?B?UTZCZTB1Nnh4S1VaNERDbFlXVVU1Y2tLQVZ0MXNkVTBVRm1wSGJYSEVFM3p4?=
 =?utf-8?B?cjdNNDc1ZGpLbzFqYWhHTjNHM05OQ3puVEE0RUhSa2NoTlM5WkI1WnNDd1Fq?=
 =?utf-8?Q?G9qXMM0e0Wg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR03MB9045.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzE1bWVXWlpXSWZKalFBalZ6WXVSWEUxSE92QkgrdkljbTJhL1Y3bEdiYXVh?=
 =?utf-8?B?WVBYWjFYY2ttSXVMVUdrVFQ2UGlDRHB1YmljL1l1WmpId3R1eHBnbGNiVFpU?=
 =?utf-8?B?eklLOG84dTJOS3lET0IrSkZoSUgxMEhVZU1WanlzbDlMYSs5c3ErMS9sUjhn?=
 =?utf-8?B?SUFaYXc2bmg3WHY5bi9tZ2grRmFRck95Z1lZU05RZnBlZnk5Nkh2Z256czJU?=
 =?utf-8?B?VkVPZHFWSUF3SzZzVVE0bUNoYlNMNU1jbmRxRDZ5VkQ1SE9xdmh0RngrMG5w?=
 =?utf-8?B?ZFlYQzNMdytLci84STJaaHJjb0puWG9Qdjg2aENINnlhcUxkOE9nNG0zNXg4?=
 =?utf-8?B?cE9FOXF0SWFoeDU0UmF2UmdZLzlQUHFxY0NMd3NPZWs3bXl6c0VvUWZEcjRs?=
 =?utf-8?B?b2JKbXc0MVZhV3JQdkhoLzRhOC9DVGJYSlQvTDhnbXlXaS9LWk9BTVg5WXQ3?=
 =?utf-8?B?Rk5aSnAyUTBJL2xrKzFvMHhpeC8rZit6VXlCTUR2Z1dSTEg2eWVKcVd3K0Fa?=
 =?utf-8?B?bE5ZTTdwdS85MEhteUJXcVBmT1dLazZna2kzSDNsZzRMb0ptSFBTbERkT2d5?=
 =?utf-8?B?bG5ybll0VFYrQkYrNkFKazY1b2tyM3JXc0R1SThLckZnU1FRNEZieTU1MUdy?=
 =?utf-8?B?TWJiNmZGeWROaEhSOUNiUXVHeFVLbnVvRkc2Zml0ZmRQSXkrZmtSMlFmeEg2?=
 =?utf-8?B?QVVvblM5ZkNQQy9PZUthdU1QNXhNb0U5czB2MFhxTWRBK2RlZCtLdGErMVdQ?=
 =?utf-8?B?N0l3TzJsMVJIWmMrYlF6TzQ4MUV6VDV6NW5WRVhHcnBGMHllQk5tZVdaQ2lU?=
 =?utf-8?B?b3N1cTVQZWZuZ0IweWcyS3ZCNWtPVDVvYVNOZ2pRdkhEMmVIQnIwdVlGc2lF?=
 =?utf-8?B?ZWNCS3ltM1ZLNXNOaXFUUHl2ZFB5S3U3NWpETjN4V01aQzZNa1pLRHhtSmNv?=
 =?utf-8?B?d2RGOTRuYU9RZWIxUDc5Q3NWRmRvRWJGWGhHcHRNMlpNd2pzMnAzRGJGcGxi?=
 =?utf-8?B?TFlQUjFyNEZqcWZBZjRzYmVCNy9WbGVSQjBxL0w0YXBDZE1QVnhxVTR2VFJi?=
 =?utf-8?B?TjJBYUYvUm1pL3c0MTQ2MWE2Y3FrWnNsUWJteHRSSXBpeFQvMTYraXJEM1lB?=
 =?utf-8?B?MmYyTWVHbm9hNTYycWd5eTZqMFh3TWRrT1A3bVlBQlEra0xIVE8zRzRvR01y?=
 =?utf-8?B?dE9yQlg1MDZaczg3MWRqbEZuSGJEUEpuWUdEaUtzeHZublNYemFuUnUyeEJS?=
 =?utf-8?B?cW1nWHVlZkhOVGpqZXJVSjRSRHpVZmNJU1lnMEE1MVcwWUQzakJDRVVERzFm?=
 =?utf-8?B?RXpCSlJTR2VmV0RDTWFUS1BFc3Y4dkU1TzNuYjVUWDNaYTJLVFFOQzU3Y2Vo?=
 =?utf-8?B?ZHpVQnBRYi9SUThTZlpmOWJRVERRd1hROTFWSUFEV0NqMUFpZW5SU0NteFhx?=
 =?utf-8?B?UFJDZXV6ZnlWaHpWYk9lTWJzcHVBZll5UUs4ZmJaVy82aDFHRkVwTnhrdXM4?=
 =?utf-8?B?cnhIRTFiUlJZNGx2ZEUwQmpzZmtyNnJoQjBhVWMzdzhyNE1GU25qRWcveXl6?=
 =?utf-8?B?TjRVUzd0NlpxbWliUjMrcTJsOVZobzBheU10TWJuNy9vb1JGamwyWEc3TFRK?=
 =?utf-8?B?bGNmMit0bDZnb3dyY3hJUGRKSExaTXRvSmZzdmg1dFBjcHp3cGdZc21EY3NV?=
 =?utf-8?B?ci9yV2gwRXBpT01oS08vR29ESlM3SnZIaUpRQk5MeEFRd1VsKzJ0TTNHeEFy?=
 =?utf-8?B?UW9PalMvYkt3elE3VjZLQklGSGt5RncwSlFnaThtVWRUWEdweGYyMlZZeVJk?=
 =?utf-8?B?bHNEVnJ4dERYK1ZWUXBpMzdZdndUblhYSzZFY1ZOSFdIaG1aZE83aXpJZldY?=
 =?utf-8?B?OEkxcWUvMGxJWXk0aHowU0NzRHk0SkV4WU9TSWRWZ09qRVMzTjFCNzBYWkJT?=
 =?utf-8?B?VllQZkdkQnlUdkt6K2I5VnZsSWYwY2d6U0ErOERLbWRiWk5WZm9jazR3c1du?=
 =?utf-8?B?QlN6ZDRScHRab1ZhbFFLanhMaldxdmI2c3pKQjJhT2JzRXNocTM0UmNzSGRq?=
 =?utf-8?B?Mk1XYTdCN0h5YlhkVW9RWUFzL3BuVGNkMlpUQU9aSW9GWm5vVnRxZjdoMzc4?=
 =?utf-8?B?ejVBbjZoZVFjc0p6VmF5RUlsT1kwUEhWZXZYYUd3TnB6OElZZlk1TVpaanlv?=
 =?utf-8?B?Tnc9PQ==?=
Content-ID: <AA1C3AE25FC54C43AD267343B5BCC304@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR03MB9045.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6219581f-ef7b-43ee-be7b-08dde8fe9b9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 02:23:58.6159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aqS4gduhcCWz6unZl+CvJAo2NQILGcpgimOj1F9wDNnN2PaOfnLjR0k/KJWCEAM7O+/4wzaqAIUPsCztPh2VXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7663
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

T24gU3VuLCAyMDI1LTA4LTMxIGF0IDIzOjExICswMzAwLCBNaWtoYWlsIEtzaGV2ZXRza2l5IHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IHBsZWFzZSBzZWUgMHgwMF84MDAwXzAwMDAgLS0gMHgwMF9G
RkZGX0ZGRkYgcmVnaW9uIG9mIG1lbW9yeSBmcm9tDQo+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNv
bS92My9fX2h0dHBzOi8vZGV2ZWxvcGVyLmFybS5jb20vZG9jdW1lbnRhdGlvbi8xMDA5NjEvMTEw
MC0wMC9Qcm9ncmFtbWluZy1SZWZlcmVuY2UvQVJNdjgtQS1Gb3VuZGF0aW9uLVBsYXRmb3JtLW1l
bW9yeS1tYXBfXzshIUNUUk5LQTl3TWcwQVJidyFnWnpqTnppV0pLLWViR2dvTWlWd1hLeGxYSUUt
REo2OF8waENENHk4ZzVWNnVDc2tTRklHc1VwQnNJYXBOMUZtcW9kOXlXeWd4b0x3RVRPX2VBV3N2
QWNHVUZhWTBuVDQkDQo+IA0KPiBBY2NvcmRpbmcgdG8gaXQgd2Ugd2lsbCBoYXZlIG9ubHkgMiBH
YiBvZiBtZW1vcnkgc3RhcnRlZCBmcm9tDQo+IDB4MDBfODAwMF8wMDAwLg0KDQpUaGUgQVJNdjgt
QSBGb3VuZGF0aW9uIFBsYXRmb3JtIGZyb20gdGhlIGxpbmsgaXMgYSBzaW11bGF0aW9uIG1vZGVs
LA0Kbm90IGFuIGFyY2hpdGVjdHVyZSB0aGF0IG11c3QgYmUgYXBwbGllZCB0byBhbGwgcmVhbCBh
cm12OCBJQ3MuDQoNCj4gDQo+IE1pa2hhaWwNCj4gDQo+IE9uIDIzLjA4LjIwMjUgMTY6MjYsIENo
cmlzdGlhbiBNYXJhbmdpIHdyb3RlOg0KPiA+IE9uIFN1biwgSnVsIDI3LCAyMDI1IGF0IDAzOjAz
OjMwUE0gKzAzMDAsIE1pa2hhaWwgS3NoZXZldHNraXkNCj4gPiB3cm90ZToNCj4gPiA+IE9uIDI3
LjA3LjIwMjUgMTQ6NTgsIENocmlzdGlhbiBNYXJhbmdpIHdyb3RlOg0KPiA+ID4gPiBPbiBUaHUs
IEp1bCAyNCwgMjAyNSBhdCAwMTozMDo0NVBNICswMzAwLCBNaWtoYWlsIEtzaGV2ZXRza2l5DQo+
ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+IE9uIDIyLjA3LjIwMjUgMjE6NDQsIENocmlzdGlhbiBN
YXJhbmdpIHdyb3RlOg0KPiA+ID4gPiA+ID4gVGhlcmUgYXJlIG11bHRpcGxlIHZlcnNpb24gb2Yg
dGhlIHNhbWUgcmVmZXJlbmNlIGJvYXJkIHdpdGgNCj4gPiA+ID4gPiA+IGRpZmZlcmVudA0KPiA+
ID4gPiA+ID4gUkFNIHNpemUgYW5kIGl0J3Mgbm90IGVub3VnaCB0byBiYXNlIHRoZSBSQU0gc2l6
ZSBlbnRpcmVseQ0KPiA+ID4gPiA+ID4gZnJvbSBEVC4gVG8NCj4gPiA+ID4gPiA+IGJldHRlciBz
dXBwb3J0IGl0IHVzZSB0aGUgZ2V0X3JhbV9zaXplIHdheSB0byBzY2FuIGZvciB0aGUNCj4gPiA+
ID4gPiA+IGFjdHVhbCBSQU0NCj4gPiA+ID4gPiA+IHNpemUgb2YgQWlyb2hhIFNvQyBhbmQgaW5j
cmVhc2UgdGhlIHNpemUgb2YgdGhlIG1lbW9yeSBtYXAuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBNYXJhbmdpIDxhbnN1ZWxzbXRoQGdtYWlsLmNv
bT4NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gIGFyY2gvYXJtL21hY2gtYWlyb2hhL2Fu
NzU4MS9pbml0LmMgfCAyMw0KPiA+ID4gPiA+ID4gKysrKysrKysrKysrKysrKysrKy0tLS0NCj4g
PiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gt
YWlyb2hhL2FuNzU4MS9pbml0LmMNCj4gPiA+ID4gPiA+IGIvYXJjaC9hcm0vbWFjaC1haXJvaGEv
YW43NTgxL2luaXQuYw0KPiA+ID4gPiA+ID4gaW5kZXggZDE0OWUwZWUzYzguLjBmNzIzNjVjNGFi
IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvYXJjaC9hcm0vbWFjaC1haXJvaGEvYW43NTgxL2lu
aXQuYw0KPiA+ID4gPiA+ID4gKysrIGIvYXJjaC9hcm0vbWFjaC1haXJvaGEvYW43NTgxL2luaXQu
Yw0KPiA+ID4gPiA+ID4gQEAgLTIsMTAgKzIsMTQgQEANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gICNpbmNsdWRlIDxmZHRkZWMuaD4NCj4gPiA+ID4gPiA+ICAjaW5jbHVkZSA8aW5pdC5oPg0K
PiA+ID4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9zaXplcy5oPg0KPiA+ID4gPiA+ID4gICNpbmNs
dWRlIDxzeXNyZXNldC5oPg0KPiA+ID4gPiA+ID4gICNpbmNsdWRlIDxhc20vYXJtdjgvbW11Lmg+
DQo+ID4gPiA+ID4gPiArI2luY2x1ZGUgPGFzbS9nbG9iYWxfZGF0YS5oPg0KPiA+ID4gPiA+ID4g
ICNpbmNsdWRlIDxhc20vc3lzdGVtLmg+DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICtERUNM
QVJFX0dMT0JBTF9EQVRBX1BUUjsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICBpbnQgcHJp
bnRfY3B1aW5mbyh2b2lkKQ0KPiA+ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiA+ICAgcHJpbnRmKCJD
UFU6ICAgQWlyb2hhIEFONzU4MVxuIik7DQo+ID4gPiA+ID4gPiBAQCAtMTQsMTIgKzE4LDIzIEBA
IGludCBwcmludF9jcHVpbmZvKHZvaWQpDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICBpbnQg
ZHJhbV9pbml0KHZvaWQpDQo+ID4gPiA+ID4gPiAgew0KPiA+ID4gPiA+ID4gLSByZXR1cm4gZmR0
ZGVjX3NldHVwX21lbV9zaXplX2Jhc2UoKTsNCj4gPiA+ID4gPiA+ICsgaW50IHJldDsNCj4gPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsgcmV0ID0gZmR0ZGVjX3NldHVwX21lbV9zaXplX2Jhc2Uo
KTsNCj4gPiA+ID4gPiA+ICsgaWYgKHJldCkNCj4gPiA+ID4gPiA+ICsgICAgICAgICByZXR1cm4g
cmV0Ow0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyBnZC0+cmFtX3NpemUgPSBnZXRfcmFt
X3NpemUoKHZvaWQgKilnZC0+cmFtX2Jhc2UsIFNaXzhHKTsNCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBDYW4gd2UgdXNlIGEgbWVtb3J5IHNpemUgcGFzc2VkIGJ5IGFpcm9oYSB0cnVzdGVkIGZpcm13
YXJlDQo+ID4gPiA+ID4gaW5zdGVhZCBvZg0KPiA+ID4gPiA+IHBsYXlpbmcgd2l0aCAgZ2V0X3Jh
bV9zaXplKCk/DQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBIaSBJIHJlY2VpdmVkIHNv
bWUgZmVlZGJhY2sgZnJvbSBBaXJvaGEgYWJvdXQgdGhpcyBhbmQgc2FkbHkNCj4gPiA+ID4gaXQn
cyBub3QNCj4gPiA+ID4gcG9zc2libGUuIFRoZXJlIGFyZSB0b28gbXVjaCB2ZXJzaW9uIG9mIEFU
RiBhbmQgb25seSBzb21lIG9mDQo+ID4gPiA+IHRoZW0NCj4gPiA+ID4gcHJvdmlkZSBSQU0gc2l6
ZSBpbiBzb21lIHdheSBvciBhbm90aGVyLiBBbHNvIHRoZXJlIGlzbid0IGFuDQo+ID4gPiA+IGV4
YWN0IEhXDQo+ID4gPiA+IHRyYXAgdG8gcmVhZCB0byBrbm93IHRoZSBSQU0gc2l6ZSBoZW5jZSBy
YXcgdGVzdGluZyB0aGUgcmFtIGFuZA0KPiA+ID4gPiBub3QNCj4gPiA+ID4gZGVwZW5kaW5nIGV4
dGVybmFsbHkgaXMgdGhlIG9ubHkgc29sdXRpb24gOigNCj4gPiA+ID4gDQo+ID4gPiA+IEkgd2ls
bCBhZGRyZXNzIGFsbCB0aGUgb3RoZXIgY29tbWVudHMuDQo+ID4gPiANCj4gPiA+IGdyZWF0Lg0K
PiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyByZXR1cm4gMDsNCj4gPiA+ID4gPiA+ICB9DQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICBpbnQgZHJhbV9pbml0X2JhbmtzaXplKHZvaWQpDQo+
ID4gPiA+ID4gPiAgew0KPiA+ID4gPiA+ID4gLSByZXR1cm4gZmR0ZGVjX3NldHVwX21lbW9yeV9i
YW5rc2l6ZSgpOw0KPiA+ID4gPiA+ID4gKyBnZC0+YmQtPmJpX2RyYW1bMF0uc3RhcnQgPSBnZC0+
cmFtX2Jhc2U7DQo+ID4gPiA+ID4gPiArIGdkLT5iZC0+YmlfZHJhbVswXS5zaXplID0gZ2QtPnJh
bV9zaXplOw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGFzIEkga25vdyB1LWJvb3QgY2FuIHNhZmVs
eSB1c2Ugb25seSAyR2Igb2YgbWVtb3J5LCB0aHVzIGl0J3MNCj4gPiA+ID4gPiBiZXR0ZXINCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiAgICAgICAgICNkZWZpbmUgQ0ZHX01BWF9NRU1fTUFQUEVEICBT
Wl8yRw0KPiA+ID4gPiA+IA0KPiA+IA0KPiA+IFNvcnJ5IGZvciBjb21pbmcgYmFjayBvbiB0aGlz
IGJ1dCBieSBkZWNsYXJpbmcgQ0ZHX01BWF9NRU1fTUFQUEVEDQo+ID4gYXJlbid0IHdlIGxpbWl0
aW5nIHRoZSBtZW1vcnkgdG8gMmdiPyBBbHNvIHRoZXNlIGluZm8gYXJlIHBhc3NlZCB0bw0KPiA+
IHRoZQ0KPiA+IGtlcm5lbCBzbyB3ZSBhcmUgbGltaXRpbmcgdGhlIFJBTSBhbHNvIHRoZXJlLiBB
bSBJIHdyb25nPw0KPiA+IA0KPiA+IEFsc28gSSBub3RpY2UgdGhlIHdlYWsgZnVuY3Rpb24gZHJh
bV9pbml0X2JhbmtzaXplIGlzIGV4YWN0bHkgdGhlDQo+ID4gY3VycmVudCBvbmUgd2l0aCB0aGUg
dXNhZ2Ugb2YgZWZmZWN0aXZlIHJhbSBzbyBJIGd1ZXNzIEkgY2FuIGRyb3ANCj4gPiBpdA0KPiA+
IGVudGlyZWx5Pw0KPiA+IA0KPiA+IENhbiB5b3UgaGVscCBtZSB1bmRlcnN0YW5kIHRoZSB1c2Fn
ZSBvZiBNQVhfTUVNX01BUFBFRCBhbmQgY29uZmlybQ0KPiA+IHRoaXMNCj4gPiBkb2Vzbid0IGxp
bWl0IHRoZSB0b3RhbCBSQU0gd2hlbiBsb2FkaW5nIHRoZSBrZXJuZWw/ICh3ZSBkb24ndCB1c2UN
Cj4gPiBBVEFHUw0KPiA+IGFzIHdlIHVzZSBGRFQpDQo+ID4gDQo+ID4gPiA+ID4gYW5kIHJlcGxh
Y2UgYWJvdmUgbGluZSB3aXRoDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gICAgICAgICBnZC0+YmQt
PmJpX2RyYW1bMF0uc2l6ZSA9IGdldF9lZmZlY3RpdmVfbWVtc2l6ZSgpOw0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyByZXR1cm4gMDsNCj4gPiA+ID4gPiA+ICB9DQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICB2b2lkIHJlc2V0X2NwdSh2b2lkKQ0KPiA+ID4gPiA+
ID4gQEAgLTMyLDEyICs0NywxMiBAQCBzdGF0aWMgc3RydWN0IG1tX3JlZ2lvbg0KPiA+ID4gPiA+
ID4gYW43NTgxX21lbV9tYXBbXSA9IHsNCj4gPiA+ID4gPiA+ICAgICAgICAgICAvKiBERFIgKi8N
Cj4gPiA+ID4gPiA+ICAgICAgICAgICAudmlydCA9IDB4ODAwMDAwMDBVTCwNCj4gPiA+ID4gPiA+
ICAgICAgICAgICAucGh5cyA9IDB4ODAwMDAwMDBVTCwNCj4gPiA+ID4gPiA+IC0gICAgICAgICAu
c2l6ZSA9IDB4ODAwMDAwMDBVTCwNCj4gPiA+ID4gPiA+ICsgICAgICAgICAuc2l6ZSA9IDB4MjAw
MDAwMDAwVUxMLA0KPiA+ID4gPiA+ID4gICAgICAgICAgIC5hdHRycyA9IFBURV9CTE9DS19NRU1U
WVBFKE1UX05PUk1BTCkgfA0KPiA+ID4gPiA+ID4gUFRFX0JMT0NLX09VVEVSX1NIQVJFLA0KPiA+
ID4gPiA+ID4gICB9LCB7DQo+ID4gPiA+ID4gPiAgICAgICAgICAgLnZpcnQgPSAweDAwMDAwMDAw
VUwsDQo+ID4gPiA+ID4gPiAgICAgICAgICAgLnBoeXMgPSAweDAwMDAwMDAwVUwsDQo+ID4gPiA+
ID4gPiAtICAgICAgICAgLnNpemUgPSAweDIwMDAwMDAwVUwsDQo+ID4gPiA+ID4gPiArICAgICAg
ICAgLnNpemUgPSAweDQwMDAwMDAwVUwsDQo+ID4gPiA+ID4gPiAgICAgICAgICAgLmF0dHJzID0g
UFRFX0JMT0NLX01FTVRZUEUoTVRfREVWSUNFX05HTlJORSkgfA0KPiA+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgIFBURV9CTE9DS19OT05fU0hBUkUgfA0KPiA+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgICAgIFBURV9CTE9DS19QWE4gfCBQVEVfQkxPQ0tfVVhODQo=
