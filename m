Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF0BFEEF49
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 14:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 496F483F98;
	Tue,  7 Apr 2026 16:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="SJRWJMOG";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="iy+dRGkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D62F8406D; Tue,  7 Apr 2026 16:43:20 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C651983A41
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 16:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 1aab85f4329011f1ae70033691e9ac7d-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=vX0FVTZCCHase0cAp4/eXm+YQvRBAVjQHQQ2zZXKVns=; 
 b=SJRWJMOGHS1v/ITGP5H9I0OFIvtN6ETYceWFhJn6x34MoW+g86MNBk5Bh4hnpsSMRZsOjup1581HO8jIXFmf8uBEkVyW8HJEkxa1QOfDKAKmI79n0jJoGeytblIBnbHVc7DZ6ShrlnojJNKx7vKhbZIF2dCOYKf4PH6vdeQihKw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:a75952f0-e00f-4128-9173-8170085ce285, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:13289624-cb5c-4236-a89a-9a7fb20c9bc4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1aab85f4329011f1ae70033691e9ac7d-20260407
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1013189606; Tue, 07 Apr 2026 22:43:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 22:43:11 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 22:43:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZmFxXKfer5+RAk215XtY15ustbtlInQUrzlnHbKgPL1oscr25aQI16d1JaV4+jRFkEuzz0c0tLWVxKmS7vvPA5DoqwV8DpKVTdror0D3ZCfRYnh/Rbe7GDV5Uuq0U/HA0AoDPz35icFNWjTGZX56eB7wjT9JZQWHXgd97chRrpsFr8wVo32CWSoAFzwrbzgrud9Zf36U+iWDA9uALJKmoMraX/5+mvRO18eAIxzr49C6uGwacafv0gqLsyinqO6SfnBGfTw++an84b95zQyh0EX71v/uLnib0AQA3QccX9XqPdaQKFy0Vfs5gcViIVkX/QTGlMGLeOchr+29yHAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vX0FVTZCCHase0cAp4/eXm+YQvRBAVjQHQQ2zZXKVns=;
 b=eSnc+Gkyue+Elxg9o6v9NhNA4cnGKKdsLHhCAuk4hjtTIMgEH0QbsxOija9BXeIw2inBq11o09hgfCrkC0QEtOwfgo9qoMTdoyI6Ok3c2vmimptbg5cRU4y3KbWL3KzzKRt8Ffm1HPntuWsuRAavXPmYnMiYCwVKttQXOt87xvvEXHuBKayW/lACWwoOyvnVnkAfm6gzXEG7FWXIkJUD6sQrf9ub7bSbd+ZK6Wfq3nTZ+xu2NpbMXkDrX57oxx64CrMtcBCAmqYyxwNn1LQp+s8DsnGiP2U6FYquXDPaivD4O3S/+UNSuxsYW3T4csA2XrT5cv3Xov6BTKG4icSkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vX0FVTZCCHase0cAp4/eXm+YQvRBAVjQHQQ2zZXKVns=;
 b=iy+dRGkR93VsKZoWLGbdRrB729TEPxk/htIQi63Ugr/vH8tW17pufYnpNzLCkzjc3A1yoDy9PTMX0mSWtOQaWNcbUkyqfAahrv8gM5x0NpTAyfi8sPwyUgOuiDzYg8RMc58scWee5Jaelw3KU+W4eqG7IhksPV5I9bMB66skRbY=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SEZPR03MB6892.apcprd03.prod.outlook.com (2603:1096:101:a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Tue, 7 Apr
 2026 14:43:08 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 14:43:08 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "trini@konsulko.com" <trini@konsulko.com>, "David
 Lechner" <dlechner@baylibre.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?SmlsbCBDaGFuZyAo5by15paH5r2UKQ==?=
 <Jill.Chang@mediatek.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>, =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>
Subject: Re: [PATCH v2 3/4] pinctrl: mediatek: print bias info along with
 pinmux
Thread-Topic: [PATCH v2 3/4] pinctrl: mediatek: print bias info along with
 pinmux
Thread-Index: AQHcwF6n5MPAPWrmSUy1YV14Yr+0nrXTuPSA
Date: Tue, 7 Apr 2026 14:43:08 +0000
Message-ID: <b13c619f675d762d644f963ab71c1f4044c3bfa7.camel@mediatek.com>
References: <20260330-pinctrl-mtk-fix-mt8189-v2-0-05a737ec623d@baylibre.com>
 <20260330-pinctrl-mtk-fix-mt8189-v2-3-05a737ec623d@baylibre.com>
In-Reply-To: <20260330-pinctrl-mtk-fix-mt8189-v2-3-05a737ec623d@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SEZPR03MB6892:EE_
x-ms-office365-filtering-correlation-id: 7557925a-eea0-4fe5-96cf-08de94b3fc4f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: CXwiBhnpTdRcXgItavXn7aS5xS5uG2trhBd7gHhZsqOp6kEYlsjrdj7omxLdTqa7PNMcUzzE/XZu9Egp3OPKonFAYn18Lo2cLiH6x8sTNwrsHzAIx9OxZj1cAPAJ0CAAXLymmEetcumhi0fmmaQN66DTYCxFXJ5QGycrwNVyDVw6oL3RXyXFw8bpFx7++m38bkpKU/knLuw6QsVJAztUMqtQRAFRd/6Jc75b9vwCDVsu4mhh8nc6Shc221RpzFmNvBLA8nYhOEMXBnpKK3LgAn3bra4dQSxHiP/opAQB0m7QYIZiFMuimkIelMdHj+L38YfJpf2A75D6i5xp0KKZKiN4kAXWk9Z8WGeIwqW5eE++4h/CcJssLRU1muQM9BXFukKcO06AN8fjJU4Cris/AaI1twGowTlCViTuLJpGDOl1Ji9SeUI+Iaw9ThDrUvZbzPmDV9SOqW0KrldMRTPf8wRz2rw91A8cyPpTPx6JllIwAvbKIR0ZiirgnO1OebijbNxvFh6AeDurjHMUab3iC4ykig/z7T4S1xtUV+0Ake7IQ6kDSySq/QKA8E1nJyfLFxaaztZ2a/oHzex7qYruTwU5KV1/35cuKuqq44XwWTNszPUut/6tABCLJr4Fq0YpYTVftWDgNHbu8AqSnw6rWf1lRkq6LlQtpYTEWZdamXiQVUVXdH9kB8HJ2a5xMUlyL9LLb2RSk4cRQxjGyoMqbvrhVbrmW6WcX/ZL3CABpZA45XVSY4wKla0cdzwpwxj5r7CV5i7J3SrmnyQ/+hXqplNmd8xB+VMYR28xX4nWwt4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG1YQWVwaC9mZXVibDFxM210cHMzMWpPY3JUTnpYU05KUFdVWUE0NHlsRVpn?=
 =?utf-8?B?ZmFoMXZCWE00UXVsWlhVdXZVR1V1SHFvK2FUSm1JNk5lNXJKNGkxYTN4aEpH?=
 =?utf-8?B?Y0JoOStDYUhVcm5VcGRoWHhBNVA4WGh6bllYMElKUkVJbWtrbEp3S0JROVoy?=
 =?utf-8?B?N3dMWmxUa1FSeXo4amk5U3lOcGRrSUd0Mk13RDhEdUtVTXlneUpiR1hNSG9V?=
 =?utf-8?B?NlUrcVB5bzYvQS83dDFSM0dDK2RKU29RQ1VLT3FDNUptOS9GZEp5Nk5Bd0lh?=
 =?utf-8?B?WmFQc0xqSXgxdmhwNUdvUW5MZDFhWnlPK09TT1VVdkwycFRZRERRMVN5TEJz?=
 =?utf-8?B?SW5id3puQWpCOXNZbkhjZXBXMi9Vc0JlcEJXd3JpY3ZzZGJac0RuZE83MjdP?=
 =?utf-8?B?cFFvZ3NodWRXcFUzUXoxSkhrQTdSS0ZDVStTTVg2QmVkaEFoL1kreXJZaXlN?=
 =?utf-8?B?blljTTY1VFk4UjRLK3ZXZENlOTRhQWJBOStKRU55TW9NSWp6KzFJbWdNa2xh?=
 =?utf-8?B?RU9LVEtoeFhLd1Jsa2lkc1d1dVliWW0va2J4VTFVUHRaOHYxc29qdE5VSmZP?=
 =?utf-8?B?c0ExUlZtQWttbjhJT3FRbWJVaHFnNmlNNVpZdnpGaUhPQ1lsWGh2L1BkN1dP?=
 =?utf-8?B?VXQ1aFRVMGlrZGR4M1VTdWUrUC90Q1FHKzFjMlFSK3Z3dThjd3NCNGRZaW1p?=
 =?utf-8?B?NHRaOVQ5NEt6RmN5V3JLa08raFBjR2tNVFU5c0FRWGpjekxzTWdpcVl5bUFv?=
 =?utf-8?B?YTR4NEZxc3ZqUnAvRzljUDVicHlGK3kzeEIwNjhHYXIyNTFBRktkSURGWkp3?=
 =?utf-8?B?dGxnVGx5UjZjMFNFeW1GYTFscndSZTl3SWlwMUVNWTU2RXJrNHc2ODRDdkZM?=
 =?utf-8?B?bm02V3Y4UkU4dG4rWWt3QTQ3eU10dFh2TXRubWU5MjJSeC84UytORGl1T1VM?=
 =?utf-8?B?UG5Oa1gwZDFXQTI2K0NqZzhta29hWk1nOU1ENWNEYlJVV1daYjA0Z212V3FG?=
 =?utf-8?B?VHNiYjl0TTJSVmZoSU5nb1QrSCs0TVlYR2FFUXlYVGwyQTMrTXYxc3R4eGhl?=
 =?utf-8?B?SnZBNGJYVXRBci9UdU9zL0VZK1dBUlRodTNreXRkZU1JdlFDOEUxN3FhcFVF?=
 =?utf-8?B?RFd6V091VDd3MW42dXAvMytSeHowZXNDTTVHcm5yNUFYQWVHZThTd3I4VkhV?=
 =?utf-8?B?VWxDT3R0QmtacnJxQXVUZzBYMGx5WThBMHFOMnhabnVHSXY2cXpQK3Y3MDVY?=
 =?utf-8?B?bExzSzhQNlpvRHdkK3ppVTlRNVNDcFdqQklHWmdzWEx3MktzVWUycjI3dVk4?=
 =?utf-8?B?SVJiQjVLa0g3RnBJRXdQdE11cGRYRmxCQVN5ZFh3YVdQc2Z4TEg3SnRhaWgw?=
 =?utf-8?B?M2k0RTBxelpPSUgxUjgydEFzN1lFOFppa2hteVQvZTA3Y1RjWXpHM0FNMWhs?=
 =?utf-8?B?Ylk0MENjM1h2SHlzR1IzaFlGSkRYTjRCT3dRZ09xckg2SjdIbVZpemRaaTBs?=
 =?utf-8?B?bVFVc29HaFFUK21jSUZNUklwb0NZbGkyWm56KytHUlFKbU9HVWJkaHdQRGlz?=
 =?utf-8?B?cUY0elBNbXA0dnQvYjI1Z1FVTEYrQ3JXQzhYVjVNREtubGZGQklOT0hrdjR1?=
 =?utf-8?B?MHF6OFdNUmJ5aU55QlVzczhpK2YyWHllQ25OSmFtb2VHemlDRkxuZnBjWEU5?=
 =?utf-8?B?bEZlajVIUFFIcEJZUk1UUURQNk1ZWnVXMkVCZ3NXOSszKytFd0NQY084M09N?=
 =?utf-8?B?QTdHMkFJajhNSUtFcHdTc29Cb0lRejdhemhHeXhCc0VCYjRtZnJacWtqNTc4?=
 =?utf-8?B?RkRLdlVWbGh1Ri9Fa2l3TW1xLzMvOUYrZTVWdENqVkExT2xSRnNFTlgwZjJs?=
 =?utf-8?B?NmlCSmdxYzBZVERQa2RsYXdLaFdWRmFMc2pKcGMxdGJiMjgxNnZUajBMNkNY?=
 =?utf-8?B?bEdhY0RCL3ZNNTQxNEd3TFh3eFBmR29sNHlWWllOckRRR01KV3hFNjJPempu?=
 =?utf-8?B?dk1BYmdicDY5Zk9BUnFYdjQrWHBnanlLMEJRekdtMlcyeHVpM2YwcjBCdU8y?=
 =?utf-8?B?R2lYb2VZQ3dvcHl5Y0NXaXJyb3JITlRQZS8rWG1GVkxBOUFWYkdGZzJ6TTV1?=
 =?utf-8?B?TVZtK3JzaWExckV4bjdwZHA3cysyWHpKOGZBUmhONllYOFhNaG9ZTklLSmVy?=
 =?utf-8?B?VDZSQkd2NVJCckEyNWZxdVozZVBqWlNYQU82TW5HZUhmaHZuZnVWVll6QVMv?=
 =?utf-8?B?WGdQU3RIV1NIOXY2QzhPSWNYMmMvcUxWQ3VjMUZSMmJmckE2WTVsV3loTkRY?=
 =?utf-8?B?YmwyNU1mbjdMS2J6bjNSV2dNeGNlM0ZHRUVHSm1XVjJTN09zNlloZzMzQkwx?=
 =?utf-8?Q?O8ZvUwwOBawHQiMM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66F3C4CD264AC64FBED13B38539C00CA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SpXdMdBMAS/POgfd+xHH2DQ75wlCuWdrJZRBsoSq3gveJ5w4FCCglKs62D2YpIGlulekzz4BjruIRjX+u2X2dhg+jofhmq01fJvT+xBP9ixvxMLjHgz3FmxlRHFLLovPTSEw4BfG4xHxcMDk2u3J0At2h1j/HXWWOqSWkbX9lY73CCff/xJHkeNWc3QiBy8q9FJNBVpXT9uFAwsGmSgnxbWuQhjvR9KSux1JRAxqO5XYzZf9vOnLJqe5bZ5ZN3JRG7YlUoMpP7Bn4nRqXD1ff1/4BxZBoqDF10cg6QX36JsvMQB4zR091rnFDDNYQhMm2mh+seuWE1nmsEAFC60iAg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7557925a-eea0-4fe5-96cf-08de94b3fc4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 14:43:08.5701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3AMeTO3SoIL15qPXWB1JJs1sm+z5lV9D5MoIqXLC7xrvwipYOgaiy+9oyQSfPjrfYZ/IvaLH4H4yO/gfkA+4+pR+X8T4jQqsONKhzdySCyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6892
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

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDExOjAwIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBBZGQgZnVuY3Rpb25hbGl0eSB0byBiZSBhYmxlIHRvIHByaW50IHBpbiBiaWFzIHNldHRpbmdz
IGFsb25nIHdpdGgNCj4gdGhlDQo+IHBpbm11eCBzZXR0aW5nLg0KPiANCj4gVGhpcyBjYW4gYmUg
dXNlZnVsIHRvIGRlYnVnIHdoeSBwaW5zIG1pZ2h0IG5vdCBiZSB3b3JraW5nIGNvcnJlY3RseS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNv
bT4NCj4gLS0tDQo+IMKgZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1v
bi5jIHwgOTENCj4gKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+IMKgZHJpdmVycy9waW5j
dHJsL21lZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1vbi5oIHzCoCA0ICsrDQo+IMKgMiBmaWxlcyBj
aGFuZ2VkLCA5MyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ay1jb21tb24uYw0KPiBiL2Ry
aXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ay1jb21tb24uYw0KPiBpbmRleCAxMDI4
YjhhOTNmNS4uY2ZmZmJhZWVmODQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGluY3RybC9tZWRp
YXRlay9waW5jdHJsLW10ay1jb21tb24uYw0KPiArKysgYi9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0
ZWsvcGluY3RybC1tdGstY29tbW9uLmMNCj4gQEAgLTIzNyw5ICsyMzcsMzkgQEAgc3RhdGljIGlu
dCBtdGtfZ2V0X3Bpbl9pb190eXBlKHN0cnVjdCB1ZGV2aWNlDQo+ICpkZXYsIGludCBwaW4sDQo+
IMKgCWlvX3R5cGUtPmJpYXNfc2V0ID0gcHJpdi0+c29jLT5pb190eXBlW2lvX25dLmJpYXNfc2V0
Ow0KPiDCoAlpb190eXBlLT5kcml2ZV9zZXQgPSBwcml2LT5zb2MtPmlvX3R5cGVbaW9fbl0uZHJp
dmVfc2V0Ow0KPiDCoAlpb190eXBlLT5pbnB1dF9lbmFibGUgPSBwcml2LT5zb2MtDQo+ID5pb190
eXBlW2lvX25dLmlucHV0X2VuYWJsZTsNCj4gKwlpb190eXBlLT5nZXRfcGluY29uZiA9IHByaXYt
PnNvYy0+aW9fdHlwZVtpb19uXS5nZXRfcGluY29uZjsNCj4gwqANCj4gwqAJcmV0dXJuIDA7DQo+
IMKgfQ0KPiArDQo+ICtzdGF0aWMgaW50IG10a19waW5jb25mX2dldChzdHJ1Y3QgdWRldmljZSAq
ZGV2LCB1MzIgcGluLCBjaGFyICpidWYsDQo+IHNpemVfdCBzaXplKQ0KPiArew0KPiArCXN0cnVj
dCBtdGtfaW9fdHlwZV9kZXNjIGlvX3R5cGU7DQo+ICsJaW50IGVyciwgcG9zOw0KPiArDQo+ICsJ
LyogSWYgd2UgZmFpbCB0byBnZXQgdGhlIHR5cGUsIHRoZW4gd2UganVzdCBkb24ndCBhZGQgYW55
DQo+IG1vcmUgaW5mby4gKi8NCj4gKwlpZiAobXRrX2dldF9waW5faW9fdHlwZShkZXYsIHBpbiwg
JmlvX3R5cGUpKQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KPiArCXBvcyA9IHNucHJpbnRmKGJ1Ziwg
c2l6ZSwgIiAoJXMpIiwgaW9fdHlwZS5uYW1lKTsNCj4gKwlpZiAocG9zID49IHNpemUpDQo+ICsJ
CXJldHVybiBwb3M7DQo+ICsNCj4gKwlpZiAoaW9fdHlwZS5nZXRfcGluY29uZikgew0KPiArCQll
cnIgPSBpb190eXBlLmdldF9waW5jb25mKGRldiwgcGluLCBidWYgKyBwb3MsIHNpemUNCj4gLSBw
b3MpOw0KPiArCQlpZiAoZXJyIDwgMCkNCj4gKwkJCXJldHVybiBlcnI7DQo+ICsNCj4gKwkJcG9z
ICs9IGVycjsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gcG9zOw0KPiArfQ0KPiArI2Vsc2UNCj4g
K3N0YXRpYyBpbnQgbXRrX3BpbmNvbmZfZ2V0KHN0cnVjdCB1ZGV2aWNlICpkZXYsIHUzMiBwaW4s
IGNoYXIgKmJ1ZiwNCj4gc2l6ZV90IHNpemUpDQo+ICt7DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+
IMKgI2VuZGlmDQo+IMKgDQo+IMKgc3RhdGljIGludCBtdGtfZ2V0X2dyb3Vwc19jb3VudChzdHJ1
Y3QgdWRldmljZSAqZGV2KQ0KPiBAQCAtMjcwLDEyICszMDAsMjAgQEAgc3RhdGljIGludCBtdGtf
Z2V0X3BpbnNfY291bnQoc3RydWN0IHVkZXZpY2UNCj4gKmRldikNCj4gwqBzdGF0aWMgaW50IG10
a19nZXRfcGluX211eGluZyhzdHJ1Y3QgdWRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQNCj4gc2Vs
ZWN0b3IsDQo+IMKgCQkJwqDCoMKgwqDCoCBjaGFyICpidWYsIGludCBzaXplKQ0KPiDCoHsNCj4g
LQlpbnQgdmFsLCBlcnI7DQo+ICsJaW50IHZhbCwgZXJyLCBwb3M7DQo+ICsNCj4gwqAJZXJyID0g
bXRrX2h3X2dldF92YWx1ZShkZXYsIHNlbGVjdG9yLCBQSU5DVFJMX1BJTl9SRUdfTU9ERSwNCj4g
JnZhbCk7DQo+IMKgCWlmIChlcnIpDQo+IMKgCQlyZXR1cm4gZXJyOw0KPiDCoA0KPiAtCXNucHJp
bnRmKGJ1Ziwgc2l6ZSwgIkF1eCBGdW5jLiVkIiwgdmFsKTsNCj4gKwlwb3MgPSBzbnByaW50Zihi
dWYsIHNpemUsICJBdXggRnVuYy4lZCIsIHZhbCk7DQo+ICsJaWYgKHBvcyA+PSBzaXplKQ0KPiAr
CQlyZXR1cm4gMDsNCj4gKw0KPiArCWVyciA9IG10a19waW5jb25mX2dldChkZXYsIHNlbGVjdG9y
LCBidWYgKyBwb3MsIHNpemUgLSBwb3MpOw0KPiArCWlmIChlcnIgPCAwKQ0KPiArCQlyZXR1cm4g
ZXJyOw0KPiArDQo+IMKgCXJldHVybiAwOw0KPiDCoH0NCj4gwqANCj4gQEAgLTY3MCw2ICs3MDgs
NTUgQEAgc3RhdGljIGludCBtdGtfcGluY29uZl9ncm91cF9zZXQoc3RydWN0IHVkZXZpY2UNCj4g
KmRldiwNCj4gwqANCj4gwqAJcmV0dXJuIDA7DQo+IMKgfQ0KPiArDQo+ICtpbnQgbXRrX3BpbmNv
bmZfZ2V0X3B1X3BkKHN0cnVjdCB1ZGV2aWNlICpkZXYsIHUzMiBwaW4sIGNoYXIgKmJ1ZiwNCj4g
c2l6ZV90IHNpemUpDQo+ICt7DQo+ICsJaW50IGVyciwgcHUsIHBkOw0KPiArDQo+ICsJZXJyID0g
bXRrX2h3X2dldF92YWx1ZShkZXYsIHBpbiwgUElOQ1RSTF9QSU5fUkVHX1BVLCAmcHUpOw0KPiAr
CWlmIChlcnIpDQo+ICsJCXJldHVybiBlcnI7DQo+ICsNCj4gKwllcnIgPSBtdGtfaHdfZ2V0X3Zh
bHVlKGRldiwgcGluLCBQSU5DVFJMX1BJTl9SRUdfUEQsICZwZCk7DQo+ICsJaWYgKGVycikNCj4g
KwkJcmV0dXJuIGVycjsNCj4gKw0KPiArCXJldHVybiBzbnByaW50ZihidWYsIHNpemUsICIgUFU6
JWQgUEQ6JWQiLCBwdSwgcGQpOw0KPiArfQ0KPiArDQo+ICtpbnQgbXRrX3BpbmNvbmZfZ2V0X3B1
cGRfcjFfcjAoc3RydWN0IHVkZXZpY2UgKmRldiwgdTMyIHBpbiwgY2hhcg0KPiAqYnVmLCBzaXpl
X3Qgc2l6ZSkNCj4gK3sNCj4gKwlpbnQgZXJyLCByMCwgcjEsIHB1cGQ7DQo+ICsNCj4gKwllcnIg
PSBtdGtfaHdfZ2V0X3ZhbHVlKGRldiwgcGluLCBQSU5DVFJMX1BJTl9SRUdfUFVQRCwNCj4gJnB1
cGQpOw0KPiArCWlmIChlcnIpDQo+ICsJCXJldHVybiBlcnI7DQo+ICsNCj4gKwllcnIgPSBtdGtf
aHdfZ2V0X3ZhbHVlKGRldiwgcGluLCBQSU5DVFJMX1BJTl9SRUdfUjEsICZyMSk7DQo+ICsJaWYg
KGVycikNCj4gKwkJcmV0dXJuIGVycjsNCj4gKw0KPiArCWVyciA9IG10a19od19nZXRfdmFsdWUo
ZGV2LCBwaW4sIFBJTkNUUkxfUElOX1JFR19SMCwgJnIwKTsNCj4gKwlpZiAoZXJyKQ0KPiArCQly
ZXR1cm4gZXJyOw0KPiArDQo+ICsJcmV0dXJuIHNucHJpbnRmKGJ1Ziwgc2l6ZSwgIiBQVVBEOiVk
IFIxOiVkIFIwOiVkIiwgcHVwZCwgcjEsDQo+IHIwKTsNCj4gK30NCj4gKw0KPiAraW50IG10a19w
aW5jb25mX2dldF9wdV9wZF9yc2VsKHN0cnVjdCB1ZGV2aWNlICpkZXYsIHUzMiBwaW4sIGNoYXIN
Cj4gKmJ1Ziwgc2l6ZV90IHNpemUpDQo+ICt7DQo+ICsJaW50IHBvcywgZXJyLCByc2VsOw0KPiAr
DQo+ICsJcG9zID0gbXRrX3BpbmNvbmZfZ2V0X3B1X3BkKGRldiwgcGluLCBidWYsIHNpemUpOw0K
PiArCWlmIChwb3MgPCAwIHx8IHBvcyA+PSBzaXplKQ0KPiArCQlyZXR1cm4gcG9zOw0KPiArDQo+
ICsJZXJyID0gbXRrX2h3X2dldF92YWx1ZShkZXYsIHBpbiwgUElOQ1RSTF9QSU5fUkVHX1JTRUws
DQo+ICZyc2VsKTsNCj4gKwlpZiAoZXJyKQ0KPiArCQlyZXR1cm4gZXJyOw0KPiArDQo+ICsJcmV0
dXJuIHBvcyArIHNucHJpbnRmKGJ1ZiArIHBvcywgc2l6ZSAtIHBvcywgIiBSU0VMOiVkIiwNCj4g
cnNlbCk7DQo+ICt9DQo+IMKgI2VuZGlmDQo+IMKgDQo+IMKgc3RhdGljIGludCBtdGtfcGluY3Ry
bF9waW5tdXhfcHJvcGVydHlfc2V0KHN0cnVjdCB1ZGV2aWNlICpkZXYsIHUzMg0KPiBwaW5tdXhf
Z3JvdXApDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1t
dGstY29tbW9uLmgNCj4gYi9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdGstY29t
bW9uLmgNCj4gaW5kZXggMTIxNWZiNzA5NGIuLmJkMTc5NjQwOTBhIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdGstY29tbW9uLmgNCj4gKysrIGIvZHJp
dmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1vbi5oDQo+IEBAIC0yMDQsNiAr
MjA0LDcgQEAgc3RydWN0IG10a19pb190eXBlX2Rlc2Mgew0KPiDCoAkJCWJvb2wgcHVsbHVwLCB1
MzIgdmFsKTsNCj4gwqAJaW50ICgqZHJpdmVfc2V0KShzdHJ1Y3QgdWRldmljZSAqZGV2LCB1MzIg
cGluLCB1MzIgYXJnKTsNCj4gwqAJaW50ICgqaW5wdXRfZW5hYmxlKShzdHJ1Y3QgdWRldmljZSAq
ZGV2LCB1MzIgcGluLCB1MzIgYXJnKTsNCj4gKwlpbnQgKCpnZXRfcGluY29uZikoc3RydWN0IHVk
ZXZpY2UgKmRldiwgdTMyIHBpbiwgY2hhciAqYnVmLA0KPiBzaXplX3Qgc2l6ZSk7DQo+IMKgI2Vu
ZGlmDQo+IMKgfTsNCj4gwqANCj4gQEAgLTI2Myw2ICsyNjQsOSBAQCBpbnQgbXRrX3BpbmNvbmZf
Ymlhc19zZXRfdjEoc3RydWN0IHVkZXZpY2UgKmRldiwNCj4gdTMyIHBpbiwgYm9vbCBkaXNhYmxl
LA0KPiDCoGludCBtdGtfcGluY29uZl9pbnB1dF9lbmFibGVfdjEoc3RydWN0IHVkZXZpY2UgKmRl
diwgdTMyIHBpbiwgdTMyDQo+IGFyZyk7DQo+IMKgaW50IG10a19waW5jb25mX2RyaXZlX3NldF92
MChzdHJ1Y3QgdWRldmljZSAqZGV2LCB1MzIgcGluLCB1MzIgYXJnKTsNCj4gwqBpbnQgbXRrX3Bp
bmNvbmZfZHJpdmVfc2V0X3YxKHN0cnVjdCB1ZGV2aWNlICpkZXYsIHUzMiBwaW4sIHUzMiBhcmcp
Ow0KPiAraW50IG10a19waW5jb25mX2dldF9wdV9wZChzdHJ1Y3QgdWRldmljZSAqZGV2LCB1MzIg
cGluLCBjaGFyICpidWYsDQo+IHNpemVfdCBzaXplKTsNCj4gK2ludCBtdGtfcGluY29uZl9nZXRf
cHVwZF9yMV9yMChzdHJ1Y3QgdWRldmljZSAqZGV2LCB1MzIgcGluLCBjaGFyDQo+ICpidWYsIHNp
emVfdCBzaXplKTsNCj4gK2ludCBtdGtfcGluY29uZl9nZXRfcHVfcGRfcnNlbChzdHJ1Y3QgdWRl
dmljZSAqZGV2LCB1MzIgcGluLCBjaGFyDQo+ICpidWYsIHNpemVfdCBzaXplKTsNCj4gwqANCj4g
wqAjZW5kaWYNCj4gwqANCj4gDQoNCg0KUmV2aWV3ZWQtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVs
LmxpbkBtZWRpYXRlay5jb20+DQoNClRoYW5rcyENCk1hY3BhdWwgTGluDQo=
