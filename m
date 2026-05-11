Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4110CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 14:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7738984659;
	Mon, 11 May 2026 16:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="kAvax05l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6177083CD3; Mon, 11 May 2026 16:07:44 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED7B5838D7
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 16:07:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqEJCzGwlcSL4bDqq7bucxTiPunERFt2lObnT+irdHUI3SErhhuOUgkI+59ax5MTRXJq0lXJ6H9T7tK3sJR5vq0iRqQcYA9CXtICVwIQwyFG9FNyLJorlPsDZp5f4IxrovHSOMfrpVen+eAuRyf/QW3No+74P4LVtES6Odx9h1Jnpzqdca+OYdHt/TYjNx4R1GxgJOJc8KrkBbv5u4D/+rzbvXgEC6GV5e7flvCmtXY2NqVMg9sNNMUtU9m+obxtkss9nkc1GazHxiDk5mb+rDD6oeeMISNzqJ0VG2O4gxbJ70cqRQKXF13Wwm1pB5uA727xEVB4+lab3KNFGAOMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBL2lHBNbTKVlPX/V9mm/bCkUIQq/5zYnLo6llwKZUw=;
 b=wTd6MiIj3Mm7FEnuwHfk/oSmNEvJtGfpam9oZD9834C4cu8p9vdQHuJn01vBMAbwcmAxIBwqWsmpdQELvkWz+j5pD8halbbptZZ0Hj3fDSexnJ/8SA4GVyD44AP2x2xuNJJg4EcoDqcYZvs/4UXxjnfHrMS1C9Yyfo87wXyPMdV4ij8kXQqS2/PbFYxKORva08+V/vZ823S+C1XbAxrwT1b5DlMVGmVmGx1255JAP3S1EsfxYi8sxqmIiGpxV5PNa8LgK30Y5ox+l5d14ucsrQ1XhFU6+6uVhqSaV3/8/Z0Fgolc4smuDl4TLca3QahOWzwwHR8G04fdKHLEd0HOVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBL2lHBNbTKVlPX/V9mm/bCkUIQq/5zYnLo6llwKZUw=;
 b=kAvax05lpVh7TCrXKTicV1Wiv5e2Tsq0/G1yAbtZoMCupl1+M6ALD7kEeOEiVxdkmuRF+VNd9lsVHOIObqSrc8Z2BoQjkZXjACv3gx7HcCBloJX+jtGlDSCp3Ry/ptJG7Erl3AaCPjUDSPoHAThoyvd0R5tEUafbE8Yimra1cMrl14JLZ0gXn+GRRtvtJkyASMhFhsklQ+jCWtEyetOe8hMEpWm8ekf0/Rtkjy6fq+feECBXUrup6IC/4EdXNmbsPOoLX7x5NM8uqujY9AKffrNags5LrnDOvvBWa+2xe5IsaZgksM+WCgY92Xx5r48PV4VDRSyn65exUFmbwnXeUA==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by GV4PR09MB8460.eurprd09.prod.outlook.com (2603:10a6:150:2dc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 11 May
 2026 14:07:35 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%2]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 14:07:35 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Leo Liang
 <ycliang@andestech.com>, "rick@andestech.com" <rick@andestech.com>
Subject: [PATCH v7 00/07] riscv: Add support for P8700 platform on Boston board
Thread-Topic: [PATCH v7 00/07] riscv: Add support for P8700 platform on Boston
 board
Thread-Index: AQHc4U+EZIWzaSlRkUShhBzLrpDHTQ==
Date: Mon, 11 May 2026 14:07:35 +0000
Message-ID: <f6d5c3bc-109b-4b4d-b488-7748ca7988e6@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|GV4PR09MB8460:EE_
x-ms-office365-filtering-correlation-id: 16a738be-a39e-4c87-4638-08deaf66a6b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|11063799003|56012099003|18002099003;
x-microsoft-antispam-message-info: vI+zlnmOjujZTC4nqAffIfgu/ERca/SHjKZuJJCuGL6aRnR0WGz58NV3odtdezs2PZ2oQuqFKFFgFNzsLE2Nv3NQhPqhOySFqj1gI34vny2KGzJso4s9W+NHRiBFrsihlC8XX7wDsQCj6UCc0CYIzrPqHT+Vy+uXVmASm/oc/zUJsoJp+VNHksPWN9klnSZCCX3hWcbOFH7JLnWOa2jPz4CcyEButPgQMR6gmhJHU31BhQoBtvpgA+tra4t0oD1AAzXCf63Gk6S/LwLSmEUHriVPSiCwYG7p/+UzYXBbt0Ppe+jA378jrsERTsB3VZPDNbEpg2Q+jZVK6qA0dYP4ixztzo4rGErWfaCHgPbRqlMwYNoJA3+6VepwgDhHRm8Zd/AFJhNIpZBBDQ4cFRjcm4oWx2w1JLiVTaqCmzgePe/6RudyU8IT378dFpejHvnVdyPcrTDhNdaWz3+Iwm2Mp+xyF9QQNOOg5tTbdiGEUlVIgp1xb43XUFCRKuSSTxL/8djRMQweldHCtbUOovgzxvhc2gv2afpQ6HDODLTnscsaAi6XJiD0ZFKLHJ+F2jBNuokGWcmohwtWLs8+pRjxgkMEOIHDrSO0ks8cvRSYZ1ZXnOSivFcoWvvbDL+P5UAoCt3u8HHuWQYK/M5yr8JGNiyYJPUydsrJTEvTYIYRDpw4N2NPMcFqdYZXkD3W0FqrClOcMcEgWRAMc9Mt/gfFYsPmtUYxkwxfwTgkRi82nsw5N9YZYT/DoDd+xy3X6RZ8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEoza0R1L3dQTm9TU2ltNlV0bzVodTFXVVlKWW0rZXVWL3A4djBpYmc1SThG?=
 =?utf-8?B?K2k5TUM4c2ZwWEhpOVg2b2lQdzFnN1FPaGpzSURQSlE3dVpDWXFwV2haQlRs?=
 =?utf-8?B?Lzd5ZlgwU3dubkR6QWR4V0hrSHRuMGxWUlBubHR0R0NFOGJLYUZFL0x6QitZ?=
 =?utf-8?B?djRzT2Vob2ZObTQrc3ZBZ0lWVXV0T2F2T0tNa2FVZlc0ZDY0WDNJY3MrUFJi?=
 =?utf-8?B?VTFFLzNZaEhCQ2YyT0lESExvR2p5dC96dFFaVkNUaUloa3pscHhzY3Z4cU5q?=
 =?utf-8?B?MzZSaHp4Yk9RWk1pMUZyaEtncG9rRFM5bzdFR0dSZFd3azBYMjEwR1pmK2JY?=
 =?utf-8?B?ZWN0bWljMmNoS2xHOEhUYlF1TUJtV1dLQnI0NFpmWFdjdjNXY3ppWng4SjEz?=
 =?utf-8?B?U294ai9wcUxkcVkvMXUvUWxmRk9KNGIxOWxwT2lUZ3A0aFExVDJJQ003ZUlK?=
 =?utf-8?B?TCtxaHhFYjFCQlhUL01jZ2NZZC9QTis2c3NmcXlOQmhHNTZOT3pyQXcrOXZ4?=
 =?utf-8?B?dlFYKzUrNmlWYlBsTC9YcUVxYUZQcFZ4Z1hMeGFEYUhNcHFOb2tXdDROeWh3?=
 =?utf-8?B?NTloTlhob1RYc2h6N283V01qSW42ck9iWkVGN1Rxc2VUSnBMRmQ2ZmpKUnJl?=
 =?utf-8?B?cHp2aDc2bXg5Wk11ZEpMMXd0YUpKZ0xVSGFrRXR2NHdTekVoczRJOG5sVmln?=
 =?utf-8?B?QzFpN25OOVdYMHVGTW85a2RXNy9HK3FJL0NHQzRhanRXeVRpUnRVaHRpSTFl?=
 =?utf-8?B?WUFhbG1FbnhaTzNkbWp6UTdPTEd2T1o5VmY3WnFBVldzNGNMRlhzdWpud2cx?=
 =?utf-8?B?Q2JvaEMvV0Z3WFRNVjhpSXduUWJrNExxcmZNdlJuWlJ4ZzNXWEcwSkFyWU1X?=
 =?utf-8?B?Z09JQzUwWWR6dy80TXFrZXFIOWkxcHo4RmtBdHFRSkpwaXE5VElDNDNuWGlX?=
 =?utf-8?B?dXpHdDJ5eVh1ZXhCTyt1VjQ4ZXgxaUtJRjNiOTA1Mk9KQ1FWLzVFMWpCS3Zz?=
 =?utf-8?B?VzhoYmx5ZUhYWG5nbTBWY3IrbVZQc2lLN2IwUTFoZ3B4Zkg3cG94WlpsbTdl?=
 =?utf-8?B?NXlOOFVsSmRuVjVoYWtTQ0FLK2RrNEhnZ29ud2lmOW5XS1JwMCtjSWNtWktO?=
 =?utf-8?B?dDhnQVFGbENvakdhWmNsVVUrTit3WVZzV3djdGdOdnd4S29Rci85MmJxeGgz?=
 =?utf-8?B?WDc5RDVvT2hjWFNNSlJ5MWRPMm4ycURXcGFoMTE2cS81cFlSVzZ6a3ovbjhS?=
 =?utf-8?B?cDhlK2RsdUkxMXBrY1REZW55ekdITGUzL2pleU1JcVREbzdLZFFqaDVrZ2tB?=
 =?utf-8?B?alFCN3FFRllVd0dhRHppSnk2OTY3Sk5ZL1VRZGtMaDBPa09XUE9CanJnN1dC?=
 =?utf-8?B?SVRKb3ROTXVZaHVMREJMUXBvZ25wbGpMU2pIQXBjOXE1TDQwMTgxYjhMNHNi?=
 =?utf-8?B?QzZWbTNZakkwNitXVjJqMHNkZjhlV0pDQnNpVWhVZFV3RUU3YzFIZXVSdlJT?=
 =?utf-8?B?QTMveWpCN3R5K3VVeTMzb1dhci91WFFScnVSUmJ6MUw1dk1Ca28vT2hWRjhS?=
 =?utf-8?B?bkxEdEt3QmJ1V1U4akRCRTcvUFdWWkx3U24vVXZIVmJqS3BkVDREZjFLelln?=
 =?utf-8?B?TTVuV1dxV2dYb0NZMGpLbkF2Q2FVcUJDK2ErMmwxbndsdG1ENnFCZ2JVOUVh?=
 =?utf-8?B?N3ZZTXJnRmx4bEljVFRKT0ZQN3JsQ3FzUjZPNGRySEhubzNCU082Vng5WmRP?=
 =?utf-8?B?eEFXMW1hUDJKdHVsSGtzSnJrSEhKQUk0a3dVQTZwenBaUEFObzMvTXQ2SnBh?=
 =?utf-8?B?OVJBWnZ1YlhZdkovcjM0SklHUTcwRFZLZE9BbE0xek5yaklQeTBZL2tKMHp4?=
 =?utf-8?B?b2I3UTVPZ1NqMktUNktDenM0MUh6aGVWcUV3bEp4MjlaL3pYckI5OUdWV2pK?=
 =?utf-8?B?ZENJTUg4K1ZEZFdta0lNdXBLa1V1KzNiWnhCWUZqaGdwSGdOU2haNm92ZXlR?=
 =?utf-8?B?TVBNWitOc1d1aFBzOVI2Z3ZGaW1XYTh6WURWSG5SenJyeHp0cTVnS1paOWtw?=
 =?utf-8?B?Wk05d1ZRQ1RTSzVoemFqc1E0VkpKTVVvdDFjVW5xaHV1cHZsUHBoTXh3Sm92?=
 =?utf-8?B?MDNMTVRkQVpYRU1UZ1NmVFVSNzJPeG1Xbk1XRWV4YTg2UEZBRUs3alZSNWRt?=
 =?utf-8?B?WW9EdVhtWGU2U0ltc0k4cjdoY2N1QUQ2N0MvbGVRUXBBRm85ZDlZKy9vRXI4?=
 =?utf-8?B?OHp6WVBYclRWMVB1QnZMb1VEdmhpU3ZZdVN2UkJ1UG5FQ1pNMGlrWXVHL3JE?=
 =?utf-8?B?ZGNiQ290SU1iRGc1ektHcVlQbnVRclFSTFdYQ2RmUHVCUEQwSmtxaGFYMDBa?=
 =?utf-8?Q?yCP7DA0u43dXijp8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8257FCC4FF04BE4C9CB6A1362EA948B9@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a738be-a39e-4c87-4638-08deaf66a6b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 14:07:35.0868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYr6Wp0iBJh+hHpeSQlAvws7pJ0KZEgbUz9Xf5Qut0KUT4Q/5WUguPanCoeXvKP+2Khq2s/hWDzgh3ELMokP1yxo0mcdWioBXqhjYEv/z7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR09MB8460
X-Mailman-Approved-At: Mon, 11 May 2026 16:21:38 +0200
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

SGVsbG8sDQoNCkkgYW0gZm9sbG93aW5nIHVwIG9uY2UgbW9yZSBvbiB0aGUgcGF0Y2ggc2VyaWVz
IGJlbG93LiBJIHdvdWxkIHJlYWxseSANCmxpa2UgdG8gbWFrZSBwcm9ncmVzcyBvbiB0aGlzIHBh
dGNoIHNlcmllcyBhbmQgbW92ZSBpdCBmb3J3YXJkLiBDb3VsZCANCnlvdSBwbGVhc2Ugc2hhcmUg
YW55IGZlZWRiYWNrIHlvdSBtaWdodCBoYXZlPw0KDQpodHRwczovL3BhdGNod29yay5vemxhYnMu
b3JnL3Byb2plY3QvdWJvb3QvbGlzdC8/c2VyaWVzPTUwMDMyOQ0KDQpUaGFua3MgaW4gYWR2YW5j
ZSBmb3IgeW91ciB0aW1lIQ0KDQpCZXN0IHJlZ2FyZHMsDQpVcm9z
