Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026ACFEEF44
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 14:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 676618404A;
	Tue,  7 Apr 2026 16:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="JE0/nJuh";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="wST6PNW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2FA0840B0; Tue,  7 Apr 2026 16:25:42 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D62183A41
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 16:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: a4c75842328d11f19a16598d5ca7f8ec-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=PQhCLJUniBYPxk94UaU3DSk5w3ze1xAH7yYuJv4kr5U=; 
 b=JE0/nJuhaTJEs4vPcpiz04xLC0qcPJZfwDwaxGY3tUZz34OUGUDYlQV1f4OXIfgoGq+SdhY8ufIjoaXf867jfQAhhllY0kmnd28piQY/N5rmnEOP6HgW5CqgMIuN3eLlZA98hYzreItfZ4V39tR1+RoF2MQ4qINFpSUe0EQJsCY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:c4bdccf4-99a0-4bf2-85e8-bd1b08118a07, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:5042258f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS
 :nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
 C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a4c75842328d11f19a16598d5ca7f8ec-20260407
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 605085575; Tue, 07 Apr 2026 22:25:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 22:25:34 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 22:25:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RV8on+xyCG8awDhwvT5uofInbjJgq6CDT1oUgeeOf67jXwKbOnKAzO9V/cTcWpJVA0/9B1CTqV4ha9wTuEHDAYsBWJfeLj0X6DzSG3xVdZYOte19/3CiBobK9kpML3m9CHlgJh/z/oc9fLEcUxy5w5X0g+VU4oBsjo7nq3W2OauMglVyrcx1ubkZvsq+GnyivqNCMbgtFAT3hPWoXmxHKa003yGB06UgBDtNJGdJjMX0YFvvYwGTvKqkw9oeOpcXcD9TO9qWncuVsa5lFD2C3/V7D9xC3hSc3QDYMIVbJXTbunYw6r95hWupFKR8NWO04vhJ6G8/Y1Y5XLDiqj/26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQhCLJUniBYPxk94UaU3DSk5w3ze1xAH7yYuJv4kr5U=;
 b=pB/JXJVNdbUd+6qFQs+3d2a49zaJUEvIU84hjK0cna34y1reOsHetKI/uJABfuxYQV/2kOBlEQ/HBBw6BUB/OVhx1NcxRp743/Vq0WeX/Ts50pfxmOH8tFiEzRogCnJJ7wdxQMyzpK+zOtAUc78tMIlDDKSH/FlvZtlachVi0QneQgMlCFqFy9PWyZjLxcSnwRn+LuOWxXogm94I4i98NyvQ9OOM1uN2A4AfIx/U7CsqQUitLISfOSJGaOA43flhUgyJmNaLlvJzmlJLwxcI5yDtNeIln8SxohcmQegYTdw804pAOa03aZgRaCGsS1yVe05nTY68Ho3nezx+MtGtYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQhCLJUniBYPxk94UaU3DSk5w3ze1xAH7yYuJv4kr5U=;
 b=wST6PNW8y89mECSDYMEpFZgWCRSM4cCJouMU+pZdJitEp395Dl1PuYr8kDtlWVneI+kbAZSIzDRHf3rbVz2pwFouVZTpzVXGtq4+CN75TZlZeG8jfP0CEdIrorRSUBiOpyVE9wEUCX0yd56IXAW11ljio7nG0c+ivUWB6XVLlV8=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KL1PR03MB8288.apcprd03.prod.outlook.com (2603:1096:820:114::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Tue, 7 Apr
 2026 14:25:31 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 14:25:31 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "trini@konsulko.com" <trini@konsulko.com>, "David
 Lechner" <dlechner@baylibre.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?SHQgTGluICjmnpfngJrlrpcp?=
 <Ht.Lin@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>
Subject: Re: [PATCH 1/2] arm: dts: mediatek: add Genio 520/720 SNOR support
Thread-Topic: [PATCH 1/2] arm: dts: mediatek: add Genio 520/720 SNOR support
Thread-Index: AQHcxgVM2EJOFeQ53k6qsn+3x93JcrXTqLsA
Date: Tue, 7 Apr 2026 14:25:31 +0000
Message-ID: <ac29980706de120eded460ea3dd1e4e60fd6fa5e.camel@mediatek.com>
References: <20260406-mtk-genio-720-snor-v1-0-cbfd5fc4e59a@baylibre.com>
 <20260406-mtk-genio-720-snor-v1-1-cbfd5fc4e59a@baylibre.com>
In-Reply-To: <20260406-mtk-genio-720-snor-v1-1-cbfd5fc4e59a@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KL1PR03MB8288:EE_
x-ms-office365-filtering-correlation-id: da393c8a-3876-4d21-b01e-08de94b1865d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: xkr6h3NISt5SfB7+Lf4EnPvF6h2oCavPal6ixZqYnmH0uruXBQHWYSDQSawsJ5bYhLYnQw5pQUwG6S4bE3ArXxJWKiJtYlYEuCxDTnfz0T4NSfKRewXEIdalgbHE9wbZZwL1Y18/8kg9Dj5xfVaX9JYqunUgGg/JWR0Douqs8ZS+doOjJWAeT1TXL0HjUCE6Mxr/ZQ62W/n+9BvSXCGSL7gThxlBLwxrJzWIqtYGgCL4iBeGlm0MVK3PCeJ0148E8aelWmobskg1oPkNs8IbdjZYQds61x8txT7F4Sm32PZmLFzQQ+M8KontTKlVgDNeixfRckH+IDlwY3kZ2yhLpGeFrGoRCK8yZIu1QlqVovoeQRdR/PppV8uJwb9DRuNv9d3VruhfEdoNgJIOv9ddFYWXu8dydJiyYWGB2KkwezyY5hrQPvSlxVzJKSnhV3YH9FEwNI5oL2IO20D4wXX7aG/T8iGrwOZgzdQ0aa1FZc8IBec/KGMaXQREBnPtnvjj4cBfAs7aMdA1HO5z0ZLxDVjUSInmti5Ik4KRgKBbQdbZRC/Zcj2NDWoas6In6IqHDBM+y6OQf3hQNrmuUP6uDFo07Gdgr+H2enAefN6Bo0bkpCpWfKzbVjyAAKRNS8xNzRmk7OFifChe+4Kda6QGPzUg3b3eyBJy2WG37g7l9rt+K76sqrG8J6pxv2whH83xN6cS1PeZNO1ibbF/a2+3p/OhTogC4TnIiHqEjTvSqidVudWEZA4D8rFzD7oJYFOapMKMwVg8EOZGKf0jm2Np02gfa+q75Wm8K/+QSKp+Ah0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGhDN3I5a2xZNExpMXZZSHVCNVVremhJSHZZaGFTNGRsTkdSV2NYdktuVzI0?=
 =?utf-8?B?UDhQQVVMTTE0R1dkN1Z5aVNjTGpneXlPaUFoS1E5MUlnb3lRMThzeUdpTmx6?=
 =?utf-8?B?SVdiTm0wQzhBMkJMek4welRFWGhYTmZhTlEycDltNkxoS2FlMmpRd1RDdUFn?=
 =?utf-8?B?NTcwVzF2UDBzREFQdjIwQ3hEWFFNa2VkdWxGaFk2aU50ZkFpNEorQ09xYXBX?=
 =?utf-8?B?Snhob0RiV09DbXdqOXFzRHV2cVU3WjhyczFtSVBHY1B2R3ROTDJGZEJ2UVB6?=
 =?utf-8?B?YVp6RTlvRVhFaXRkMWFoQlkySmpheVNmR2hzYmNjYVZlQ0h1V25IU1ppM0Yz?=
 =?utf-8?B?USsrL2p2Tkx6Mm5ZMTNWeHBXNEV5eVFDNmh1bllJV3Q5WkJrRnhvbzlLTWJ3?=
 =?utf-8?B?eEJKZEN6N1dlSit5ejVOaS9GdzA5ZlZaQWZ3bTZLalpNdDA2a3NBTnQ0UXcy?=
 =?utf-8?B?YlJ4MW1FS0prdVRQbnNXekF2S2hIazQ1dTV3bjgvbWVUUGRxTEVvN0RweXVY?=
 =?utf-8?B?V2RmbVJna3JEbzhyZndublNwS3MrVzNtdUw5WVhNNEFNNjV4ODBJa1BsTmlN?=
 =?utf-8?B?NlpzRjYrdkpLT2FnOG1vZXAybnVYU2NhU0tQdmZhNFR5dlhrTUVKQzVSYnl1?=
 =?utf-8?B?RDcvRHpvMnJPcEdjZXZFU2d3VnlUMDZKYXUzWVVQSngxc1FZSVIvV0NiZmJ4?=
 =?utf-8?B?cTI4VUN4dEJxOHVhVlBJMmhVUnNIZWNxb3h2NkVNdkFYM0IwMDMwOXhPamNu?=
 =?utf-8?B?S1dHOTRjcCsvbUFDQjgxNTVCTUJkN2tJdHpkNEhaS250NzZ0QnhtUkNqOW5v?=
 =?utf-8?B?TTY4czlSakc5WC9tMkdEblJpRCs4MWEzTytoTlZLMG0zK2crNTdCOHlSTEdr?=
 =?utf-8?B?d1FBWEF3bXBCaml6YldvKzVRc0pMVnhVUUZKYmhMUGhMRjM4TUd0c1VENnc0?=
 =?utf-8?B?NnRvYTExSTQyU043VktGV0NNZlJEdkJaZzVCc2xNQWxkdzVMSXZCZWZ2d3NI?=
 =?utf-8?B?RER0YlNPYmFGWklkOENjN0ZycFhMM2prVlY1TmpYS0FxL3Z5TUdNYXBpeGlR?=
 =?utf-8?B?ZXpqSVRTekxWS2Jtci9PZjN0Qzk4cHhXbVh3VWROVVV6T0pzc2NweCtSZ1Nx?=
 =?utf-8?B?blkzanJBdFhFWTM1SkRyc0VMTE93SWNXdytJRis1VjhtUEhVUFA2RHRkcXhY?=
 =?utf-8?B?NEF4UC9IVUVMRnZRc1hLY2RFQWJ4emVTSUpqa0k0Z2FLZXkrakZvMmVMR0I1?=
 =?utf-8?B?NHprMFZYQWg5RDdndmN5cGhyV2VNMVhIWWtrcmltOHQ1dGs3RXo1c2pKOXBK?=
 =?utf-8?B?N0x0NjV3MTFpWFBrYnozZnFCQloybjR5ZXJGSDAyRXZuUUhQZkZrQzQzRXky?=
 =?utf-8?B?dzdwdnk5cnFZSGoweEJLRk1aUmE2WDkyZGsyMXZ1ZGhmZHYrLzdBYmFJVHhH?=
 =?utf-8?B?S1ozaHV0TlBoTDdVSWJxYkNGenJtM2NGeVZwdk51bHcxbkxEK3U3ZWpLekYr?=
 =?utf-8?B?c3hrVEl4MEZhYmlyQmF4RnFZMGMrcUlIOVZiU3hUSlVweDFJVUFWNXNZSDM4?=
 =?utf-8?B?aThMNFAvODJBeldKVHFXdnMzaXdvS3R0ei8rQmtoRDhkSDFMUUZIeVVzYmhI?=
 =?utf-8?B?RmRoZFEybVQ5WnJtRlU0cEdFengrb1hURjZTbElNRDMwK1A4end4QlRGdTUx?=
 =?utf-8?B?MGg5VFg2NStSNDBOVGlkeVNra2diNFAyYlQ4RkhwT2Y4RXJVbXVveC83VEc1?=
 =?utf-8?B?bHRDRzV4SVl3NUZjaXRoUXZSdCtZUUR5eEVFd2dLYkpLSXFuWU1kcTVGQ2FK?=
 =?utf-8?B?RURpOG9YeDl6WmQ4VFRsc21LR3RCaktoRG1lZ3loUkdFTS95SUM1T1VUNldE?=
 =?utf-8?B?cFphNElCSTJScEY2Tlp3MjFHNGk0eEllS29YZHd1UXJ0V2lhcG92bUtaemhh?=
 =?utf-8?B?R0FwYzRhODk3QVA2QlhOMmJCTlY1K0M3VlJCbExtdkZJMnNJMjVVK0VNNzdN?=
 =?utf-8?B?cUxhYlVza3dabGI1bUtNamxoL1FyZFBibkdWNTlvcitnYzh4ZWJqK21FSWxo?=
 =?utf-8?B?aVEwUmdrd0J3VWpXNkFVb3RyWDZtM1dkdkE0TSttdTlsdnFqZEl0c0svVjEr?=
 =?utf-8?B?UFliT3NHbTBJUi9uS0FoUVplR1RRZDFZbWdYczEveDZWOHdESWVrcjhWMFlE?=
 =?utf-8?B?VVNTWmp4bGljWmFUQ05lUC9LclJZSUpCK2cwSXdyR0JQTXNYaWxlaVUvVUJ4?=
 =?utf-8?B?dlRnVWVPZFpqQ0FUam53bXRzWUxmMzF6eGxVRWVaNFJaQ0NzMHpLVncwS3JF?=
 =?utf-8?B?OEFsWEVnVDJGRitzbUk0OXg0NmxVbFFSN1JOOEdxbXVvU0JLbk1jZEgwbXBy?=
 =?utf-8?Q?GfUl3lKPMCHiCjOg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FEA5EE4F9556C4FB194242489955C8A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tSpjfSzeB2aKoq+mrSEc8IZBgZSb5xBVEk1zygjODBcRWVWMUfSkxBV3c1zTZXtYX5Ruea6Pd2r+W7LNILHBG7vqHrdbczT62GC8ljY/STLoIq4V/gqBrPY+7cAmqh7U1opZ1ncxYR8UhI14BUzQtYMaUK+B2qr0c61E8IGiYTmFsigg9t5380QizELp5DjgqtEkiP1BR8WnaYD2qYKbEhHU51u+Gc11AKe3U70Co+VjRe5Z92eOk26KWWA9ftsRmeH5V70VaSvu4ucvsrVr6aeLoRz9KUeCbpjg1arav2ifvn0zEn+bdPHFxiZTH4cnjuZDkJk8Q1eCa9p1Bus5rA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da393c8a-3876-4d21-b01e-08de94b1865d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 14:25:31.7490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQnJDT/HuRg0uHO6Q3QgeDZJVjInyI3XmV69wATkP//ry06INHljudjM3kLug3Iv3gBYL13iCRg5k0fd3+Q56PpY8Mkz2kddj7JieBZkUp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8288
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

T24gTW9uLCAyMDI2LTA0LTA2IGF0IDE1OjM3IC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBBZGQgZGV2aWNldHJlZSBub2RlcyBuZWVkZWQgdG8gZW5hYmxlIFNOT1Igc3VwcG9ydCBvbiBH
ZW5pbyA1MjAgYW5kDQo+IDcyMA0KPiBFVktzLiBUaGlzIGlzIGNvcGllZCBmcm9tIHRoZSBtb3N0
IHJlY2VudCB1cHN0cmVhbSBzdWJtaXNzaW9uIFsxXSBvZg0KPiB0aGUNCj4gZGV2aWNldHJlZSBm
b3IgdGhlc2UgYm9hcmRzLCBzbyB0aGVyZSBzaG91bGQgYmUgbWluaW1hbCBkaWZmZXJlbmNlcw0K
PiB3aGVuDQo+IHdlIGV2ZW50dWFsbHkgc3dpdGNoIHRvIE9GX1VQU1RSRUFNLg0KPiANCj4gTGlu
azoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbWVkaWF0ZWsvMjAyNTExMTEwNzAw
MzEuMzA1MjgxLTEwLWpoLmhzdUBtZWRpYXRlay5jb20vDQo+IMKgWzFdDQo+IFNpZ25lZC1vZmYt
Ynk6IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gLS0tDQoNCltzbmlw
Li4uXQ0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNv
bT4NCg0KVGhhbmtzIQ0KTWFjcGF1bCBMaW4NCg==
