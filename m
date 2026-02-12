Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4806AEB4901
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 11:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A326683CB5;
	Thu, 12 Feb 2026 12:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="CvsKy/vL";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="TU5NEDgT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A175983CE3; Thu, 12 Feb 2026 12:02:08 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAE2083CB5
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 12:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 3bcbe0c0080211f185319dbc3099e8fb-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=kKT2dYlB+KfmvjbCxJMPFyhBATKqNOEGAiUB37Ez4Gk=; 
 b=CvsKy/vLkuMHvMUnROTc6dyGpxghpg20rwzEqWryWMKs3DVi73qEcAwJ4GIPlYe/i/TwFzMB+topZC2SFCIFHYAX0JG5+vn6g8kwYodcMlffpJKyoaTGLZLlzc5OSmAntuFWUbsurs/zDEASoSO1cwa1HR62HZRwHUtmTKvYL0A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:ce9bd438-51ff-4540-8510-db0d3830ecae, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:01f99ff0-16bd-4243-b4ca-b08ca08ab1d8,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3bcbe0c0080211f185319dbc3099e8fb-20260212
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1826292446; Thu, 12 Feb 2026 19:01:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 19:01:49 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 19:01:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Plhn7E/qucA3KUc3Jq7t8lYV2mAcic+5eslgt87lWE5JdYRpYOKkwuHua5BlrVKm7xiGkSbK1QBRwxbHo123rd9RG95/tViKOKh5i+Vt4H9Xw3VE5Lj3IwsSTLtm1Zl3J4Cewa9EMosMTjEpI8OOT5H25lvVIxBdLcu5nLuJip3317prpXyhT5QR3E8bdvvwArRvpKTaJPrKss3hItQtJ4A0fkeU1/+ALFDV4K6+BXFWraL+coIkXx9DM6/XVGb/j8yFmayhCk4KeTDIFCu8573hGXehpRzfCEBOUzqJDzw2gJhrLgTDzCWU0BHbgDtW5zi9OMNnGlTs1SZqKeTZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKT2dYlB+KfmvjbCxJMPFyhBATKqNOEGAiUB37Ez4Gk=;
 b=oluJO926M3Su5Jnto8/+f7SBIytenDAgitInIOiHNtbF4xehHir0H8yAmpZ6UFOTeay1UmrP5ULikvKtLq/3nZy/rVR+RPlTcuU+9HFw5Rxii4PZelogxuRtv56L6pJWw1DiSxyh5fLbVYj+YVL13KcJIK50v3MfqzbXsvCewxa3G92Ixf7vi1lNqM2XTpsni085+lLzFmkF/qVytkgSDBXCEt7/4T2KXAPsUQsaqUdRs4R+xJSykfJuv9rTTQh2tiVSn8/Y8n8K4ysPPNu8DOf0YLZUtrWMH2c6cSgPzUbl+/arIMm28tJpe0OtZEQja5rRty0Z6fKvyGZTpz78NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKT2dYlB+KfmvjbCxJMPFyhBATKqNOEGAiUB37Ez4Gk=;
 b=TU5NEDgTOufZdCZZ4FpjLsX3ULYYtPpcFFRBGjZ++UVl8L4XUsTRO6vybVd+8Le9yJek35R9m8auS2EJrSPEblMneUTuf8z7yRg8guGIf4Z1qKmuw9FoOsldAysj3rL+YBptBUTYklZezbKcGO3Ks8rq7tdsAaRuBN1sY5frzpI=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYSPR03MB7739.apcprd03.prod.outlook.com (2603:1096:400:42e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 11:01:45 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 11:01:45 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Ariel D'Alessandro
 <ariel.dalessandro@collabora.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Julien Massot
 <julien.massot@collabora.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH v2 5/7] board/mediatek: move EVK MAINTAINERS to common file
Thread-Topic: [PATCH v2 5/7] board/mediatek: move EVK MAINTAINERS to common
 file
Thread-Index: AQHcmeeJMr/NR2gu1Uay58vO8BGiFLV+6iMA
Date: Thu, 12 Feb 2026 11:01:45 +0000
Message-ID: <fe573dd30940764bc8e9d2b683fe11f573843288.camel@mediatek.com>
References: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
 <20260209-mtk-mach-clean-up-duplicates-v2-5-e3b22282c74d@baylibre.com>
In-Reply-To: <20260209-mtk-mach-clean-up-duplicates-v2-5-e3b22282c74d@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYSPR03MB7739:EE_
x-ms-office365-filtering-correlation-id: bf62fa6a-ee5d-4fe9-05ec-08de6a261c71
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?NFNiMFVRNm5IdWp5d1RsV2pKdGR0RER2bWc1ZG1MYSszV0NnTy9oZmszUlJM?=
 =?utf-8?B?VVYwU202b2FUMFB0YjEzY2RJWkYweDJoMnplZ2pBR1dpUFFZQUk0U3BUQ1FN?=
 =?utf-8?B?ZHVXUTljUllxZVZxMkV3NUdBeTgyLzhJcEJ5dlhFRkI4Zk1kT2VVN1NqWUlZ?=
 =?utf-8?B?aFhyVXhxWFRFYThXZndKemFlRTlnYlpCSHB1REl0YnovbFJBOFo5YnpicC8w?=
 =?utf-8?B?cXh6dHMvbWlLYkQyaFRpSS9tRklvMDNnUlFvU0JybFF5WjRwbGY0TG9td3A1?=
 =?utf-8?B?RXpLbzRHM1pQYXd6azhjd0dXMUJKaXJ4bTJDWlg3LzFFQ1FheFBVYnFWdkpx?=
 =?utf-8?B?MzgzSS9VSEk4QjkxdmQ3WWpEN1dDajlzcHJobXNLb0lyUWxTeHNSMWNJREZl?=
 =?utf-8?B?bDlVWG9GTWg5TXd6aW1OM1Ryc1dXU0gvLzcrVGhtRHZTdzJJdEUrL1diQ293?=
 =?utf-8?B?UjhtQWhPVXhCeXJlY0ZaVGlJZ01DRjYyeXRDUFg4NStCUEVxVEF0RVZhdlNO?=
 =?utf-8?B?bnRkTFpyWmo5THVnbWZPYU4xRGluTFFHTW1WNGpsVW9pcWtvM3hDMitFbnhq?=
 =?utf-8?B?U3RiSEZtMjVpVmdtR2dLQmx6RHhIMksxTHF5eS9mMmFKczhvSS9KWEsrY2tR?=
 =?utf-8?B?K0c5OURsWXRETmlkQWZsUm5RNEIzcE1aOHdSMW5xNGRHZEx5YUhaOFhzMW9h?=
 =?utf-8?B?SzQ1NjBTNHVucWJZdVhCUy80TEVyY05YaDQvNGxEOTRqMjdBOU0rc3BnVENo?=
 =?utf-8?B?RnVwcnpsTE8xSmMvdjd2RUgzM1NCNml1SEdhNkQzdytkbks2YnBxcFNRUWVm?=
 =?utf-8?B?MWdMcitvN0RLaTNIaUtzSFE4MEd6aXpJSlN2UGJXaUQzS1VMRXFwMTBGU3J0?=
 =?utf-8?B?T051SkxhcDl1bkZ5d0V6OUNEaDR6OVNOajM5RjBLeUx0NWZJa1RGeTI2cXc4?=
 =?utf-8?B?R1RGc3NzL2lmQTBTYmxpVlAwbkNZNG0vYS9IYk1KRzkyWFhITW90S1BTWmVL?=
 =?utf-8?B?Q1c5RUoyVi9YZEFTbXRPcHA1ZFR3QnBuVEt5UlkzeG1Sd0xvOXhKbjhPY2I5?=
 =?utf-8?B?Q2R5OHR1WXRjdWNxU2VDd2xWMmx4MHhzOUhlR3NWbThJQi9uU3VNNUdsWTJs?=
 =?utf-8?B?T2xxbkZxRERwb3ZJclhENHdVVTBPU3ZLdUtBa3BVUVdPSWtTTkZpRTgxN01Q?=
 =?utf-8?B?NEZzbld4RTQ4UTVZVjhSNm1BRmM2YWVNUytiUjlqS3hjMUlDWXB1WXpUTk9U?=
 =?utf-8?B?d0RLRXFlYWVjMzdFcnVvWmpocmNUVWhjRXViQTFtaG55R1FFT2d5WjR6VjRl?=
 =?utf-8?B?RnZhOTFraVpFYlpQdGYrN2RadlVOaFVnNHpoWkNLaW1VV0VXYXF2Vy9mNnJR?=
 =?utf-8?B?aVZFOHdkMEc3WWlTTHdSV1dVeS80V0dqTDRpU3cyWFR1T1BxNm1FSzdUNng4?=
 =?utf-8?B?dUNDSW5INXRwKzBOR1B3QTV3UFNqRjVoLy9RM3ROQzFXbUpaNXdQYzZ1RVVt?=
 =?utf-8?B?UjRhcGd1SzVCSktyekU5Mk54TUlJOXZGUFM0cEN3VjE4VWM0TGF2UXJYdTJS?=
 =?utf-8?B?c09rK0xBQ2djRDdIcGxIUlppRUlIaWdRM0hGSGlkd1NZRHV1K1hXcE82c3U0?=
 =?utf-8?B?Z29aVVRjZTdsMERaMFFuc1VUY2ltZXVHN1hSQW9IakcwbmxEMC93d1RZMWdR?=
 =?utf-8?B?cWVaeE4wbjJIcGduckRGRm0rSzVsd0gybnVRK0R6cDZoN3NYR3JPWm44R2pm?=
 =?utf-8?B?S2JvdVlDSFNoSldoakZ5NDRLbVRGOGhVaHdvZGJPM3lXdlZDUUNtZm9Iazk3?=
 =?utf-8?B?VlFyTi9FV1hJUjZKdXpqVUZlQSs2dnBIUEpsZzFCUFZrdjVTNkFJR2tuTU5V?=
 =?utf-8?B?VUExSW8rTCtKVEZ3eDlsWDMvanhScHBLUUcxN1lVZVRVNGZvUEhya0lrS0xW?=
 =?utf-8?B?K1NOaG9HZEJGSENDVTFLS3RJRkpZMGE2UlpaUkdpTDFNRlRBTVBSQThXVUs5?=
 =?utf-8?B?VVFvYU5hYVJZT1ZwVTdVT2hBaWNqb09kcVVnVDV1YUNKMStUN0hiWEd1b3JT?=
 =?utf-8?B?T3VQSnVNV2dqYndEalcxT0RGN1ZQZi9HZDNSSE9mY2xFeWVDTDdQdnI5Kzk3?=
 =?utf-8?B?MDVKTXNGMnBMS0RuVHI0dHZPR20yRll6eERTS0FDb3FOZGNVZ2ozK3Nmb1Y4?=
 =?utf-8?Q?3ZMNJmnjw810FSfIRIVsivKrHZ5CeebXinPyHbeSG/W/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2M0SzFHMDE4RE42Zi8wSm43T0xmWFQ5NWdCemJhVTdOd2RsWDliSEIxWE5i?=
 =?utf-8?B?OHgrd09WSWRMdFNHV3d4Y3p5cC8rdEU0QVJGWDBqbEM2U0hndVJQV2M4N2tw?=
 =?utf-8?B?YmcxTUl0UjRJNHBaaFNnbzNxME93clV3S3U5OGUwTkRQWkFQUTFlSXc1UUxy?=
 =?utf-8?B?NFB0MDFsRWRjL0k5dys3QWtTTWRtTnFEWlRRVjk5eXRQblg3blA3Z1pSVXV1?=
 =?utf-8?B?bk91K09tQVBVa2pzamJObkEwU09PVC9zL0duamVDL3lCY2szMFVFeENYd1pT?=
 =?utf-8?B?UEVEcXJIb2I3aXNZUHhNQzdBbnlqeG00VGk4cm50Qjdvb0ttalBSdzdvZkJy?=
 =?utf-8?B?QkxseXlQcnV6bDlDZHFaTytmUnVqTHpGeTgwVFJYWW1wK1F0cDdaaHNmK3lu?=
 =?utf-8?B?RXUrcjRHR3FNaGhMRWJscXVzMXRrV0kyalNVRFRQTS9sUFN3VWFyRGdWd0ZE?=
 =?utf-8?B?YmI5ejdQR0ZoM21zN1V0dXdoY0FTSGxNYlp3dzFyWHlobWxwTU1vWi8zTU1r?=
 =?utf-8?B?N1VPdy9DemVOeG85S214QzhCWDhxZEhGeDY3NVFIZEpJdk9HRHdJbTNydkdl?=
 =?utf-8?B?eUhuTU9LeVFQbXdEMnA0ZU02K2Evc29na0dqeC9oRFBFVldQYTZXek5Ua3k2?=
 =?utf-8?B?cVQ3N2I1VTd3RFhway9CaTBXZEhYWTZMdWpUZ3dOYVF6Y1g4clVjQVBlRVhv?=
 =?utf-8?B?eVJNNzB2dmtyR3FtWDlYL0JiMm1UdzVaUE9mWm5acGlFRjQ3RVlpZjM3N2h6?=
 =?utf-8?B?b3M1RlNUcVJaK1FvWXdHSlEyN0dFY05oSk1XdSsvMHFFY0pCbFJCUXFwNVQ2?=
 =?utf-8?B?WlNsbFUrbmtVM2p6VGdoWUJReDNBTSsrRVY1VTJvSEZyTjhoVzNBTUVxUnRG?=
 =?utf-8?B?aDM2Vkc0MldldzIxY0o5UHpTS0oyN1NmM2ErWlFDUEg3NGIxUG4yNzR0bHpl?=
 =?utf-8?B?NmdOeFYzeitIMFltVzZqK3B6T3ZWY2VyNUZLZFFZUG94TVh3OTY1S2UwUkFY?=
 =?utf-8?B?MUpCdWhjSmZoRElVL2dGMnBJdFVSVUVMcFI4ck1WdVNvTXRraXljV01WUnBm?=
 =?utf-8?B?d0FIN0VrWVdBaGt4b04yRmkyd1VFUFF2Tmt5T3Z5dzhnbXN0dk5OeDhZQWZu?=
 =?utf-8?B?NlZ4eUZpNnVBTDJrdmVtUHdhaUpqKzl1bXhUQjFMWFV0Y0c0dURHbVVMNlls?=
 =?utf-8?B?YU5IZG9XazMwWGpsZ0hRbWsvM3c4bDd4RWtGR2pTOEhBQ3JGS1VrYlUxZ2FH?=
 =?utf-8?B?N2paQjhQWVVEUkV6REdEbStOSnRBZGZTN1M5VnhVbEEzbWYzcWs1TEJrWFRB?=
 =?utf-8?B?YW83QndsS2swd0VBT0UwV3hxbmFrYXFqbXR6S2tTZXdsckdJcDZ3YUtzL0dh?=
 =?utf-8?B?YU1jYUhaTVpHbEFzdzVNUFJsSERpL1MzakhTL2M5UUNXS00rOHdCNytybDRL?=
 =?utf-8?B?VHpJRk1sQVUxOTFVdm1VNWRtR0dqeUx4ZW00b0tINlZCN2hzSFhQK3RvVmtW?=
 =?utf-8?B?Ykh1NWp0MmFyY0tPV1laV05iSjVPelExYWdpc2RxQWc5Ym5vWHdEejFhUkFP?=
 =?utf-8?B?WTdsRUNoaW04NHlxcWJTWXpuN0pTZEkyaHNXekR2Sk1GOElNRU1Tb1czTXRZ?=
 =?utf-8?B?RWdndi95bkJyU3VuOGRPZzVkQ0ZPRjE1c2RxNE9ya1F6aWJmcEp5T2N3WHdS?=
 =?utf-8?B?VFZhK0oweTU5Z3VjWGFORGZuRFk1eGMwN1BwNGF0ckZxc1NpSk1YeVlkcnFL?=
 =?utf-8?B?Z1lxRG5YZ01SdysvZGZRR1lMK0lpclhHcmdLdkJiUDAySElGaVpsSEJ5dTgx?=
 =?utf-8?B?aUIyUnZad29zcU1hNEw3TGx1cFA4ZlVMaWxpT01TSDJTYkU5dXcxOWxWTEUr?=
 =?utf-8?B?ODVkYmJIbDV2dVNvVmh3aytKd3lZK3NET1NPNTdGVkd1TEJsSEprMjNoU0Yy?=
 =?utf-8?B?bUthemlMOE9VbHI2UDlIdkJ5YmdsQnRDbzBiUWxhV2RJUXY2M1BkUS9RRi84?=
 =?utf-8?B?S2xheDkwTUc5MkVwWU1aSDZwRnhQK1cvVUJOVTVQbHd1a2dVZHhkSnJmcWtM?=
 =?utf-8?B?UXppWDJpUnJvWkhuOUEwcy85TFdwc0VyYXhEZGluRHRJYUFULy8xcjR2bTE0?=
 =?utf-8?B?SHVCTHEzTXdzNXAxazU2MGtxZjhlSnB0TWFzalMvN0w0czdORWhXclNPUFFT?=
 =?utf-8?B?ZGQwYmJRQzhRYkIrekJqcUxOWEJQR1RmS25LTnNFZVBVZ2g0WktMV2JyVkZV?=
 =?utf-8?B?QlZpTHJnTUZYQXVlTnZzZHROMkdFYlJmY0ZBaGVlSGR5eXFnak9nMmxyOHIv?=
 =?utf-8?B?N2gxRDRmbSs5S2E3c1FKMGRQNlh3YWNKdjlYdEU0cU5kZFZlY1h0c2ZqV3F0?=
 =?utf-8?Q?B8jqu11skkopM2Po=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00364F3C196A864BACDA102C749EF989@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf62fa6a-ee5d-4fe9-05ec-08de6a261c71
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 11:01:45.1500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n49ygDb0RDkj+SMNHBWdyYNjXiAUtyhz/UBJ8f2PDXF3QD66uYN2lYFJAwMsbGpRQ1y16RQiYTvef3Wf6TpQecyGOs5CLVmMINIWg9tfb3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7739
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

T24gTW9uLCAyMDI2LTAyLTA5IGF0IDEwOjM5IC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBNb3ZlIHRoZSBtdDgzNjVfZXZrIGFuZCBtdDgzOTBfZXZrIE1BSU5UQUlORVJTIGZpbGVzIHRv
IGEgY29tbW9uDQo+IE1BSU5UQUlORVJTIGZpbGUuIFdlIHdpbGwgYmUgZGVsZXRpbmcgdGhlIGJv
YXJkLXNwZWNpZmljIGRpcmVjdG9yaWVzDQo+IHNvb24gYnV0IHdlIG5lZWQgdG8ga2VlcCB0aGUg
TUFJTlRBSU5FUlMgZm9yIHRoZSBkZWZjb25maWcgZW50cmllcy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+IHYyIGNo
YW5nZXM6IG5ldyBwYXRjaCBpbiB2Mg0KPiAtLS0NCj4gwqBib2FyZC9tZWRpYXRlay97bXQ4Mzkw
X2V2ayA9PiB9L01BSU5UQUlORVJTIHwgNiArKysrKysNCj4gwqBib2FyZC9tZWRpYXRlay9tdDgz
NjVfZXZrL01BSU5UQUlORVJTwqDCoMKgwqDCoMKgIHwgNSAtLS0tLQ0KPiDCoDIgZmlsZXMgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2JvYXJkL21lZGlhdGVrL210ODM5MF9ldmsvTUFJTlRBSU5FUlMNCj4gYi9ib2FyZC9tZWRpYXRl
ay9NQUlOVEFJTkVSUw0KPiBzaW1pbGFyaXR5IGluZGV4IDU2JQ0KPiByZW5hbWUgZnJvbSBib2Fy
ZC9tZWRpYXRlay9tdDgzOTBfZXZrL01BSU5UQUlORVJTDQo+IHJlbmFtZSB0byBib2FyZC9tZWRp
YXRlay9NQUlOVEFJTkVSUw0KPiBpbmRleCBkNDZiOGIyZTE1Ni4uMzM0NWM4N2QzMGIgMTAwNjQ0
DQo+IC0tLSBhL2JvYXJkL21lZGlhdGVrL210ODM5MF9ldmsvTUFJTlRBSU5FUlMNCj4gKysrIGIv
Ym9hcmQvbWVkaWF0ZWsvTUFJTlRBSU5FUlMNCj4gQEAgLTEsMyArMSw5IEBADQo+ICtNVDgzNjUg
RVZLDQo+ICtNOglKdWxpZW4gTWFzc29uIDxqbWFzc29uQGJheWxpYnJlLmNvbT4NCj4gK1M6CU1h
aW50YWluZWQNCj4gK0Y6CWJvYXJkL21lZGlhdGVrL210ODM2NV9ldmsvDQo+ICtGOgljb25maWdz
L210ODM2NV9ldmtfZGVmY29uZmlnDQo+ICsNCj4gwqBNVDgzOTAgRVZLDQo+IMKgTToJSnVsaWVu
IE1hc3NvbiA8am1hc3NvbkBiYXlsaWJyZS5jb20+DQo+IMKgTToJTWFjcGF1bCBMaW4gPE1hY3Bh
dWwuTGluQG1lZGlhdGVrLmNvbT4NCj4gZGlmZiAtLWdpdCBhL2JvYXJkL21lZGlhdGVrL210ODM2
NV9ldmsvTUFJTlRBSU5FUlMNCj4gYi9ib2FyZC9tZWRpYXRlay9tdDgzNjVfZXZrL01BSU5UQUlO
RVJTDQo+IGRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCBlMGQ2NWVmZTgxMi4uMDAw
MDAwMDAwMDANCj4gLS0tIGEvYm9hcmQvbWVkaWF0ZWsvbXQ4MzY1X2V2ay9NQUlOVEFJTkVSUw0K
PiArKysgL2Rldi9udWxsDQo+IEBAIC0xLDUgKzAsMCBAQA0KPiAtTVQ4MzY1IEVWSw0KPiAtTToJ
SnVsaWVuIE1hc3NvbiA8am1hc3NvbkBiYXlsaWJyZS5jb20+DQo+IC1TOglNYWludGFpbmVkDQo+
IC1GOglib2FyZC9tZWRpYXRlay9tdDgzNjVfZXZrLw0KPiAtRjoJY29uZmlncy9tdDgzNjVfZXZr
X2RlZmNvbmZpZw0KPiANCg0KTGV0J3MgbG9vcCBKdWxpZW4gYW5kIEFyaWVsIGZyb20gQ29sbGFi
b3JhLg0KDQpDdXJyZW50bHkgd2UgZG8gaGF2ZSBjdXN0b21lcidzIGJvYXJkcyB3YWl0aW5nIGZv
ciB1cHN0cmVhbS4NCkknbSBub3Qgc3VyZSBpZiB0aG9zZSBib2FyZHMgYWxsIGZvbGxvd3MgdGhl
IHNhbWUgYm9vdCBmbG93IGFzIEdlbmlvDQpFVktzLg0KU28gSSdtIG5vdCBzdXJlIHRoZSBib2Fy
ZCBmb2xkZXIgY291bGQgYmUgYWN0dWFsbHkgcmVtb3ZlZC4NCg0KQ291bGQgZnJpZW5kcyBmcm9t
IENvbGxhYm9yYSBsZWF2ZSBjb21tZW50cyBoZXJlPw0KDQpUaGFua3MNCk1hY3BhdWwgTGluDQo=
