Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50F1C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 03:45:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED90060789;
	Fri, 31 Jul 2026 03:45:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IwSAIpSqbESx; Fri, 31 Jul 2026 03:45:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB876606C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785469537;
	bh=tUckKXZoz8V6b3scVypZTd/Fuc6ehhYQevPDKhJgOe4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cOx+q5Sgt+3DT2mN8nv3v4JkFNwjWfxxJ+wdx5I3wMXFucVUjGRNmgIIldOzK9rKE
	 5nPYw5dQWDEAPloJvVgCGUZGqAPGrck1DrIsMCxEyGUAAOvKQrDC23djbhJgYdqX9p
	 tuurSW65+3cY5AQPHTGOF0anlw5e+w3KelqX/7bJDTyfEnE7qplH4jiawZc+2HZBS7
	 lQuRU0FMoWpsGWfz9oQyK1xkM+wQyqKAyOGwaf9GbIuRk4lS1dvJ88J31oimJ35WyU
	 nxS7yVit86o75zOpTISGlA+j2WEL1KVZYje9jElvqpryJWEwEEbGglHkJOrvCygMBA
	 qz9K8LfVKXzSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB876606C6;
	Fri, 31 Jul 2026 03:45:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 32C1E218
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1835580EE1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:45:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F2g0G9X9bT48 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 03:45:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=210.61.82.184;
 helo=mailgw02.mediatek.com; envelope-from=macpaul.lin@mediatek.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A80EF80E83
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A80EF80E83
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A80EF80E83
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:45:35 +0000 (UTC)
X-UUID: 2c68d2e28c9011f18dc8c9802ae25ab1-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18, REQID:7f49f8fd-8230-4a57-95d2-e11e2282f949, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:8a735a6, CLOUDID:7b15c38a-2e92-4dcd-8f3b-8af1b16bdb04,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2c68d2e28c9011f18dc8c9802ae25ab1-20260731
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2098981836; Fri, 31 Jul 2026 11:30:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 31 Jul 2026 11:30:26 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 31 Jul 2026 11:30:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4Pd3/FJ/plz7+OTpxtjgUhLMvai3oeS4Gy+0ruRmqz1FDf9c5dIfOgkNlLZQmGCZuPz8OpbYfO/0RSN54NWnSemeGQmrhEfjtcIQkAMH04Dlzj4+mCeaTZPjBNGmsGgRlYXAwT7MaKL5fQZtaXhXaoQ0a8I6b80AcvjnKbOdUm0iIIh2HdPhjHaU96+i0QCPgvVW7GP0lMyHfzetYbjUmM1+65NS3oF9P9dkOJvD2kzXvkA5OVQhT+e4FKeBJod1iB7/e6s8Ee4Zoxi0tG1BwSawEv7K3bBeofH7e56RGd+R8rU2OTFqULb2eHYhO4mFWIo6TXfqRu3onEJUMis5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUckKXZoz8V6b3scVypZTd/Fuc6ehhYQevPDKhJgOe4=;
 b=PVO3fL3KsGGJnC3huYwks9aK9j5ZG7Ad4exQVvarzrnwlvXmHBuYgN9AcUXutzbFqfN4VVS0P3V9EIE6a9VcXVDnFl0mAfRT/0VP6ibyLOp5hD4A3hpP1r1PqXKL8ey6OvIhJRakQwpxn5VlrXzWr19AmuHnRMCt1RsJ61C3L2fzD/MxWTx5Ud4HkKij4PuNGXLrvP6P4dw3Yt0V/RYhpczDeDUPK22D6Yj+OCNK3eCY0taPK9Rp1LfWCNvSN0AH1bFdv8GJgNqTG+v+Wy7Oihf/mA4SMjo5acfSASrRPBYnJ0Q4exV8NjBmfu3l59rAc2AN1BFVzQKPg2UL7OEYRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by JH0PR03MB8349.apcprd03.prod.outlook.com (2603:1096:990:4a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 03:30:23 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 03:30:23 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Julien Stephan <jstephan@baylibre.com>,
 =?utf-8?B?VG9tbXlZTCBDaGVuICjpmbPlvaXoia8p?= <TommyYL.Chen@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 =?utf-8?B?UmFtYXggTG8gKOe+heaYjumBoCk=?= <Ramax.Lo@mediatek.com>
CC: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Julien Masson
 <jmasson@baylibre.com>, "ravi@prevas.dk" <ravi@prevas.dk>, "lukma@denx.de"
 <lukma@denx.de>, "dario.binacchi@amarulasolutions.com"
 <dario.binacchi@amarulasolutions.com>, Carlo Caione <ccaione@baylibre.com>,
 David Lechner <dlechner@baylibre.com>, "ag.dev.uboot@gmail.com"
 <ag.dev.uboot@gmail.com>, "jbx6244@gmail.com" <jbx6244@gmail.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "patrice.chotard@foss.st.com"
 <patrice.chotard@foss.st.com>, "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>, Ryder
 Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH 02/13] video: mediatek: add mixer component
Thread-Topic: [PATCH 02/13] video: mediatek: add mixer component
Thread-Index: AQHdHozjANzM+SRU3EeNkc62DDDybLaG/LqA
Date: Fri, 31 Jul 2026 03:30:22 +0000
Message-ID: <ee05f877bc60c0c613afe02e75d18120c09a23d9.camel@mediatek.com>
References: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
 <20260728-add-genio-510-and-genio-700-hdmi-v1-2-ac54bd75f960@baylibre.com>
In-Reply-To: <20260728-add-genio-510-and-genio-700-hdmi-v1-2-ac54bd75f960@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|JH0PR03MB8349:EE_
x-ms-office365-filtering-correlation-id: 76a0e46f-e3ee-4b06-a1c2-08deeeb40dee
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: V457R174PXbMR5Mb/iM5kUL3trfl6P8SY8WCqSoEFaQniGF/YHCqsgrYxcVetxya1VI1YFqAIJonQrId8oRklUXBv5CUS3mv3AbECUvDOYuqV3kFtog0VbfC/eqISnpoIKRmC+Tj7ygsn3z7unFFpbBDku0GCILlD2waYAOYBCHi/QFx+G/XK8ou+53bZD6xg9VYLjBazDrK4VesauSJ9yU4KjHnY3Jk4rG14SD4EQyWz9LNhZymo5m8eseRGxoQ+nzjqkAV5vXIMECO5mkTFbEtJAr2yuxuQr0Y+xK70QOF4pL2LATwGbVVqapfv0rC4TIOpX7YslQ66QCyClPIyYcMdYqvHdcV8eQwkRPCyTNj9TZB6GM+mti5AYxE/p+Dwbt6lJU6iZ/8LHhVrjatgxJD5HRIYDyW8ovlQDCeC21vvOTKrm1DnjCYqunTGO0GZns0XEeQUj5ea00hkshgLI4iBvWXVSJcSBQUu2dK3nUR3ZjOQ3MuC5ewOio3DJVfcwClaSKZg96os8zxOx+CNxSlV5bGuqvEDkkzF0qHPnQYzGli9TDpwN3cg4fiBySMD/PY1u0FN9LscNaaXGK6Fjs4GFyJPFcSLu2xOwYH9Ayy5xuEMtT980m3mTzP5uHvFHmgWX68QUY6slrPKdtePAA+zsPwiFrh/kT7ST6/R2ISX8EPFuzIl4tnIWbU2df68Q1G+11Ho+Ph4Yoer/NFARYffb8uEeMbzBSW9UU/ge0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHNTSEQvN1h6YmYzWFkrY0E1NXBWWmJuUmJ6R3kvOUUyOVhHSGNZdndaVEpB?=
 =?utf-8?B?YS9KeFBsbHV4RVdIM2g5UTBSNHlhZDdzUGE5WDNYdm1wNHQ5c01VUFIydzkr?=
 =?utf-8?B?d0Iyb0NOUG53a0pISGJzSHhuTlFpbUJSWDVUbGxMZnhsY200RFBYUlRDd01O?=
 =?utf-8?B?dFRmbHQraFBjQWxOMFF6SkM4WW5HS3ozYjg1RERudWl1WHROUkJub3lFREp0?=
 =?utf-8?B?MmhTWExlRVRKZForQ2lmLzMxRjZadmZDQnVySDc1KzBkd0J6eW9uWUY4U2VT?=
 =?utf-8?B?WTNLeWd4eFhlN3ErOFByekprYlNvdHdOTElzMWYwa1dyU0pSOFhkNjRzbmFw?=
 =?utf-8?B?by9oTEhDYk5RTFlTZUtkTGVGTk1ZQU9mQ2t4UExSMlJJRHMxWE5KbEo1czRh?=
 =?utf-8?B?amI0Q3hobElIWjNxZUhLMUIrR04vRDRzby9TaExERE42S2hSZTlUcjRSSTRy?=
 =?utf-8?B?bllCdW5tUmpxZWxvNDJQMGdqelVNY082bmI3cXNCUEtjQ2pwVzN3aExMSm16?=
 =?utf-8?B?QzZ1S0pOT3ZEVnIvN0U0aTJpbHJ2ekVaSzdWdnRKV2N1bnhRTDV4VWx6VHBD?=
 =?utf-8?B?c0doL01NNytPVVlKSWFQbmxrblRyazZiU1VWcFhodlMyRU45MXRkMTAwMUkv?=
 =?utf-8?B?Tk50VERpaDMwdTFDOWpWelZMZGdQSkpKVndpMlk5TGQvdEc4QW44dytqc1pi?=
 =?utf-8?B?MTNDK3JUY1RUaUhEUGMzVVkycXZXUU1EbnJ4Ykh0eEF3VHlwM3AyNnNPaDZm?=
 =?utf-8?B?Y1cyTkp0RkVleGx2emlRZnQ2RkxCMVVQZkFRT3JpTDVuQkZYNVUzbHB0Zml3?=
 =?utf-8?B?QUNkZzdkOUlLa2dDNmt0MCs1Y0QwRWVzQlN4VERMK241bXlIeEFaL3BUeGJ5?=
 =?utf-8?B?eTR1eXgvUGQ3amp6Y2FPaHRKbE5nNU9UOFRhWkdqK2RmSjZCMlBrS3N4RjZv?=
 =?utf-8?B?d2dVVGJvbklTdEEvdXVJMDhVdHNzc1oza1JXdWhvejdIcWdHRUppd0FBR0Zk?=
 =?utf-8?B?VUoxOXFkeEpidmFEY1ZSVUhHeEk1WXpJcnNMcjFCUWMyYVFzWTMwMGxMZzFq?=
 =?utf-8?B?MnNHOWRMUGN1bTJRa0pnTHhHcDRneExuaFVtOXdzc0sxNHMvUzRMVS9sZ1JV?=
 =?utf-8?B?ZHJhNEhxcS9OcXYwemJLREJxR3VkakNGQTFTVkFseDRsWi85Qy9hcnlpd3pk?=
 =?utf-8?B?MDROQWNYUGdZQU9vdTFvUWFyVW1PUGZKd3FURkNZQ0tvNVRCbE1OQTVqSHFz?=
 =?utf-8?B?ZjdCT3hKK21aNW5aNDBDUXQ2bm1KdlcwQUcveDdqWmJSMkdINndHNUZSNmRs?=
 =?utf-8?B?TXArN1FiZktwTE5Ba0htSnByMm5WQ1N2YUpsaWdIbDNxcWtlWTh2cE9GQUxP?=
 =?utf-8?B?cERabVo4d1Q2M3BSQ25vRFVQaHkyYjFHa3R6TzI2YWdMVDdSZGFnR0s1bVRX?=
 =?utf-8?B?WDFTZGdjSUJ2dWU0dnA4bVVxRG9Idm1BSUlyL0l0WHg5RVJqTlQxVm5IR0VV?=
 =?utf-8?B?VzJQcElXSmF0TEZWc3ZJZGlvSXZYcGRCNHU2UnJiTEppNG40eFErZ3U4T0Yz?=
 =?utf-8?B?SUZRcWsyUEZIdXpQY1pqcXVKaHJ0TWQ4TmxiZkE1SGgzS2FFL0FsTkZ4WVdD?=
 =?utf-8?B?K3pTM0lVTzBCVE53VzE0QVRzTXZVY05zR2g2cHZuSWZrQmkzc3JITzVERllO?=
 =?utf-8?B?Q1FNYk01dlIzcDErSnB6NStOUUxSUVl5WWpiS2hOQldydE5ORUlhME9mZ3RV?=
 =?utf-8?B?MmIyeHExNUVDTjdWOTllRzIxNjdVNFBkaEQ2UUZmcjd1Nng4T2k0YUhmTmo1?=
 =?utf-8?B?NjRBc3VGdGZIV0RYUHNMNUcyVkpvRmQvUTVXZG1GQVZvbXowdys5S1RoMFRn?=
 =?utf-8?B?VmFwcHlCalV1UDVmaDJJZWVyUFAvL0o0eVRjU0YwOTUvdlBubUQxYk93ejRi?=
 =?utf-8?B?U0sxTHY5WWtIRytPVVo3V2NKY2Z2dXRaZTNBQkVKclEyMXhRL1o2S05kSmtB?=
 =?utf-8?B?WUhVRHVNTFZDd1cvRHY5cFphekRCanZDdlRVdC85K01yalp0OEc1eU91dm52?=
 =?utf-8?B?UnY4eDlkVmpQVUNGZDhvMEcydWRHUVBTYmFQRjJWMDVRRE9uekxWcWs4TXht?=
 =?utf-8?B?ZUxxUG1PWkxudjFGb0F6TkZKMStOSVJPdzZ3Yk5iY2lSanp2bm5aUFViOHRG?=
 =?utf-8?B?dTZINEUrQnhWeUErU2tMYXJZcXcxSUxTYVZKK1ZZZzdRSHpSK2Uvc1lLTHNt?=
 =?utf-8?B?djFYSWdzeFA1YytNWEpBTEtCOTVSWWJuSnJJWHdPeWY3YUFMdy8rdUc1c1JW?=
 =?utf-8?B?Sk16NU5XS2hpZ0NrMWR6R3JmWUpzWFRKZ0pmYTh0T0VmZkp4Ym43MHpoVE5H?=
 =?utf-8?Q?5Oc9jPmXfmIvEFUA=3D?=
Content-ID: <7ABC001D01048C429DDD41D74FF3C273@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oHaHkGO+jyH8Cyf06F53THiEmEJLWdnvL3NA8pGeRCoJ/4wX8BAFhAeBxD722nCVBeJ00ZxdA4clz3e8xWJz5MXR13+qOMaS31t2RrhIA+Ty9xHxSamvgsFBCAAfmUUz56hBMIhdE4r3rtaqGIPCzIClPNBu187D+cmWZYhP0aIeIdrJt7UCgdvAVE3DyAbsJM8tTeNxVLKC2KkIQChOzcXegDQEQ75b5TH6+T89UrCPVnj/Hw8quqTzi0MVD/8wAUK6paow1x+6oZ0SeH1p5Hz5ouZkX6Z7wpDmgpIkcdKv0v1Ce82QKw67G5ghpMx3lrn0/aGhcZjmZgWuuBaaaQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a0e46f-e3ee-4b06-a1c2-08deeeb40dee
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 03:30:22.7947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLkAa1UZ2maD0Av1fYtPaZc0hrFjaVssnxpyF1y9/FAtLmHu3/5sswlTWEoMH+KFaqokWfv1Ic4zFCpIERGajkCTqjeXROXy5+3Kn6kb1R0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8349
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=mediatek.com; s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=y2knlyypGz8FhEvCnFAMhfxEoynHZxAHOweCYQwsmbs=; 
 b=a0X0OpVeE+CepzBmkSRDM2gVTnHZu4+aS25N0yBi8+OCSvo5MhBJZSFJAfgPYXbUQqIXw/4G1Be+YYG2v/sm6pxDNFIVxZ6i0ZYv1yFxL7EAiz+wtojyYnunuSAbQWeu9xKMRTc/6ee1KuOvXsVY4Z0FZXXEkvXojphOj1t5La4=;
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUckKXZoz8V6b3scVypZTd/Fuc6ehhYQevPDKhJgOe4=;
 b=Co2UCX4mxhHZyVdL/qKQiBMgHq41vwhQJe7IGkORU3vG+2/hXzsmAR3eLBLImLLLdKciN2K6C0MQxu29PdXYSwSS3soC7XFpMzZ3/7wkgJL8Dmv89qfX6mX6RsPqVNn3iDnUiZzxmVbzFTA5B90OxR1XhO3NBIORkDn0p5IvVlw=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.a=rsa-sha256 header.s=dk header.b=a0X0OpVe; 
 dkim=fail reason="signature verification failed" (1024-bit key)
 header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com
 header.b=Co2UCX4m
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

T24gVHVlLCAyMDI2LTA3LTI4IGF0IDE0OjI5ICswMjAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gVGhlIChFVEhEUikgbWl4ZXIgaXMgb25lIG9mIHRoZSBjb21wb25lbnRzIG9mIHRoZSB2aWRl
byBwaXBlbGluZSBvbg0KPiBzb21lIE1lZGlhVGVrIFNvQ3MsIHN1Y2ggYXMgdGhlIE1UODE4OC4g
T25seSB0aGUgbWl4ZXIgc3ViLWJsb2NrIG9mDQo+IHRoZSBldGhkciBpcyB1c2VkLCB3aGljaCBp
cyBpdHMgZmlyc3QgcmVnaXN0ZXIgd2luZG93Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSnVsaWVu
IFN0ZXBoYW4gPGpzdGVwaGFuQGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy92aWRl
by9tZWRpYXRlay9tdGtfZGlzcF9taXhlcl9tdDgxODguYyB8IDc2DQo+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+IMKgZHJpdmVycy92aWRlby9tZWRpYXRlay9tdGtfZGlzcF9taXhlcl9t
dDgxODguaCB8IDE2ICsrKysrKw0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgOTIgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gDQo+IFtzbmlwXQ0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwu
bGluQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIQ0KTWFjcGF1bCBMaW4NCg==
