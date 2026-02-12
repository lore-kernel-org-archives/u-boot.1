Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA8AEB48F8
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 10:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35C3683C4B;
	Thu, 12 Feb 2026 11:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="O9p7BwQk";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="c+HO6AEM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DD1C83A47; Thu, 12 Feb 2026 11:45:38 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3626E83A47
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: f4433c1407ff11f185319dbc3099e8fb-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=NUzO5UGdc6EK85Gr918ezvDoExFwRthQQK0kSWGEsqk=; 
 b=O9p7BwQkc99sI6nDdIDhRP2WX9z6u1jWWTOO1TXlWn/pAFtShFEnTFRvUwm8kFkseVUrg7ZfDubKNWd5b/t/uxmMasZf7tLgFknriG+pHaDxHsJ35DLFRUqTqSmBRi4TG26i6M5ehQVmMcMzJ1xWzrN+2OWqtHyBfCcRgtfUiMQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:905e1c3c-95be-4db1-a52b-93f72f2db9d2, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:d47a395b-a957-4259-bcca-d3af718d7034,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f4433c1407ff11f185319dbc3099e8fb-20260212
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1103261484; Thu, 12 Feb 2026 18:45:32 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 18:45:31 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 18:45:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZqTiZyhx7PSvg8lYMPR1EdMlfT2YiRbC+gKgtrfbf1QnJTv3rKAmenrtR1i1OfJIcGfFuRxzAs0qlIU0LaiaZnmT+gOH+VQUA23+2nQ19m9WhnwfEVBd6c2sl4+uisjZt561ZvbWWqjpvh12CAHMLvKCFXg8cQkRCHt7eIjnL6LVJQQbIL0N+U1uAA5IrHX4YkstPMdMs2mCNXi0ab9HTb70L5zhiA5xk7cIPEYkV8rvLU7oUAVuXmbHZW5RRg1iPzL+bA01MxQUWPshha4DQlX+7UQ+esFntn9+a7YW/pSf4QjOja7D9Ksn+CYw8V0zHR3uv18h6p9bbj9GLE33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUzO5UGdc6EK85Gr918ezvDoExFwRthQQK0kSWGEsqk=;
 b=U6Y4VApYipp4CHw4mQnMkxPDV8nUH0/WFHJ3cnW+ufBY5py/ZQ02DkStX9RU5pj/tyFUIYpViYq0mhxUI2gnFsUu5Cz8feYj4hTXaSLAJ1wn3Y2YkDbdIvadO303hN+1uUctDy0EEACY4I2v0STZuXcKOj2pkVIP//nH1xznF2fuDQPqge/A/cSp8S/1TryhLmPQKJHE6Iavql/W0Xq1yMAuf0H+EyRt5Oa4JeWbDmtieZdwW5Qnb95Ww+MYFe0tzrjJt67yeiAMvjWOk/EP4UnjaNUcX2WP2Ao9oU5oIb7DCtpvKngAfvw9cSkcvQCEAILLk+/WsbSTrcRxOoveSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUzO5UGdc6EK85Gr918ezvDoExFwRthQQK0kSWGEsqk=;
 b=c+HO6AEMk7qFFRUyPBElMG5UciMuhNEIXpgRM3SBu5XHEn8uxoVPKVqzYya9LDZX1zN9ydlA+GAqkEAsn1kU+xMVASy08mDShHl7oxyU0uP/m3fMz6dVirJf1wSeQvfpoSQ/xMvazIN33P4Dddox4iXpo+O/Q7UbgjxrkZtnMhI=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SEYPR03MB7296.apcprd03.prod.outlook.com (2603:1096:101:14a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 10:45:27 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 10:45:26 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH v2 3/7] arm: mediatek: mt8183: remove unused function
Thread-Topic: [PATCH v2 3/7] arm: mediatek: mt8183: remove unused function
Thread-Index: AQHcmeddfTHPZfVLyUe5vsDN9stNg7V+5ZSA
Date: Thu, 12 Feb 2026 10:45:26 +0000
Message-ID: <89a222f2480b69325ecf88ec0138589d62284a87.camel@mediatek.com>
References: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
 <20260209-mtk-mach-clean-up-duplicates-v2-3-e3b22282c74d@baylibre.com>
In-Reply-To: <20260209-mtk-mach-clean-up-duplicates-v2-3-e3b22282c74d@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SEYPR03MB7296:EE_
x-ms-office365-filtering-correlation-id: ba31f0a0-6e11-4283-d9e0-08de6a23d54f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MHhkUnVVSlQ3VTZZbitNUUVsTTNydFhUaVpQTWFiL2J6cjJ6NVFMSDl5OGxR?=
 =?utf-8?B?bytzVzdneGg3VzhaNm40WkVtclRNSjA1SGxCQ1V4R3pqbktlUUVrTHJRVzZw?=
 =?utf-8?B?SUxGSkViVjNxRUtoTmkwV2w2Ulp6Ym0xazZRcTJMbldMNXFHdHNzZzZldFRk?=
 =?utf-8?B?RVI1TStULzZMQlNBeEliQlVqamVFM3ZybkJjMHcyeVMyMkNSMk9HRWI0em1L?=
 =?utf-8?B?M0M5VmZtcDlNRWpjc0k1dmwwNmUvVGFxU0VidVhwZ1QvMkFQeDNRa3picm1K?=
 =?utf-8?B?Q1o3enM0bmhISTNlbDg3RWppOWMyOS9DRndhckpwbzJObGtmbDRPS3VrZEV4?=
 =?utf-8?B?M0ZVVUV5SzJpb1FLVXFtVEJJN1MvSHFGNUhIOXJDaVBoZk5GRzUwSmhtWHlD?=
 =?utf-8?B?ck5PeUxyczdMejhGMHkwRXdnQTh1cUVpb083ZHBJWVphMFd2OUhhYkZxNVI2?=
 =?utf-8?B?NUx4MmVYbFUyS0xQeEtTdGd1WkZ5YVpoVlFlOGVMNXBxZlhPck8rd3M3S2Yz?=
 =?utf-8?B?QnRXY2JWRE9lZkN0SmV1SW1lUk16SmJaemNxRWluWWtDZjF1MEJIWXJtMmE5?=
 =?utf-8?B?ckZBQ0xVbEd6SXJkcGsrUVIvdC93RXlGNUhzczhReFBhRVdKSjNNaWx1WFpM?=
 =?utf-8?B?a09kZnA3QmgralFTVUp0Tm9SdldUT1NWdmpJYU5jN3JQcmpDUW40MEtrWmFW?=
 =?utf-8?B?WkpoYmsvblNsdUhDbTN1KzlBaGZXbFNxeENWNXcrM0djVlVkSlkyaWFPNzgv?=
 =?utf-8?B?TjlyakMvemFYa0MrRThhSEh5a2NROE9kWXRKU0xyUE9CaUtPM1NyOUxqZ1Fn?=
 =?utf-8?B?SUVqVTJtdjFwK0dEYUdWc2hhbWNOd3RxOHlGTnFNcWNGYnZEV1RsNlRzMTlz?=
 =?utf-8?B?TGhKZHptMWRwd2pVUWwwNlVCYS8vN25KU2c5cmtLSGhpQTBUeE1jeXNNalcx?=
 =?utf-8?B?dlBCVjZoOWlBcndvSDFOWFQxT1JaUUZOakpHMXErSmxZbzFmaU9NdGxVM2Ux?=
 =?utf-8?B?N2d2TEJ5Zml6REhSTVB2NCtqYUFkaTVwOXRwN2RZRERBZllzY1BubkptWU81?=
 =?utf-8?B?a2dIMjMybldEVnRXL3VObU5xTms4bWlRK1dlV1J3QjRYaUdnb1ExU3QyOVBw?=
 =?utf-8?B?cUVxcGNoTEhldGh6Q1JFeVRhSEhIVGlZRFQ4MzVWVGdMU0F4Qnkzd2x1MVZO?=
 =?utf-8?B?WTBPNHNPcmhQUmxnZmVYZ1p4ZG1FR1JsY3B2WCtVN1Z0dlk4dkpvTFI2RnF5?=
 =?utf-8?B?SUVUdW5odkpSTEJ1a05lSjBlR1dvZUlPSTA5WldlMTh2elNEVTVYN25RS2FC?=
 =?utf-8?B?dUdheHhrWmdNYnBwSjRDM3ZpUVpoK0didlR2VEMxYVUwRll3eUtyUFRvTm5F?=
 =?utf-8?B?WGlDT0d6VnVLb0g3T094YVlXV2F0N0NmelZ0ZnJUYUpIMk1ycGp2UFJndFZw?=
 =?utf-8?B?NXFWdU8wWG93NDZhUG5kNXJBRytuZElOS3p0VzQ1Y2pkZC9aMllDS1V3cHBL?=
 =?utf-8?B?VU10ZjFxNndzV25WelBlNFRwZkJRNUN0Z2IvLytoQzNuWDNpblpPcERMNjky?=
 =?utf-8?B?VURHMTVidGVXdkdNNmpFN0FwOXE2eXNtdkoxUUJkT2VXQnVzZWlQM21Edith?=
 =?utf-8?B?Q2NENGxRbDIxbWt3YkdlbzlYb082aHVwUWdPMlRLSjFzTGExMmhEbFBjQ2dR?=
 =?utf-8?B?a3g2ZEZVckQ4a1lHY0JpT0h6TTU3eUYrUFl6TDZhNTdZS2k0RXplZmx1OVpH?=
 =?utf-8?B?b0ZVaTUrKyt0eS9VcTZLbnR6cElqelYvandUd216bURXWUdSRkxtYk1TVmNh?=
 =?utf-8?B?RHcrb2dRS3JKdjN4TlhaVllwNGZ5MXhEcHA5TENNVEhlNTNRK3VTWVV6SUtK?=
 =?utf-8?B?czFXUVMvSkhXTzl3R012YW5iWnk0elgxZHpjVnZFY0FCeEg4WFFrN2VDcnl5?=
 =?utf-8?B?aEJ4bFNCZXF0N2pSNjQ0YVlSVVpoU1lIVTdueHNURVYxbDIyMVFtTzNubTBQ?=
 =?utf-8?B?LzhSa0tlM0krZjBYalorVmNtcGgvNS9kYWI3bFJTMDBFR2VtN1BTQkpyNmFM?=
 =?utf-8?B?UndNVWJVV2ZkV3Q0aFArdmdDdlJvelFzeXNsU0FrVVV5SzBZL0p4ZWhiVHk4?=
 =?utf-8?B?bWxxamZTQkw3UUpKRFZ5NS91dEJramwxMDlzYkIrTzN3enNDVmRyVG5mY2Zu?=
 =?utf-8?Q?vUZpN4IOJJFTcGkBcGhj9WM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlBXaGM2VkpzdDg2V2dsejYwNWFwbjVUYmNiMHdiMzBSUHhQUVlrVktyVzd1?=
 =?utf-8?B?c1VhbUlpTFg0bTBvOWJiS0FyaHc1MEVvMTFYLytoQ2liSUFVTXlZV0dsaThp?=
 =?utf-8?B?L2EzNWtDTUJ4MEdGaURqTmI3QlFNdDJtUUJyK3NxakNoK3VDLzgxV3lZYzVl?=
 =?utf-8?B?RnpRZW9iUFhScDZQNE5FUnVvZ0tpWjBNcjBkUFZhTWNFbEcxV2NxNHhMVFFr?=
 =?utf-8?B?ZE5iMzBabHgzdVZzdzNLQVVaam1TZnRmeW9zakVrUVJmeldPUXo0d2xoQ3px?=
 =?utf-8?B?V2h0enNycmd5WlplTGRhaXFCL1FkU0x0OHRPRFFadDJjU3JqeDJwakVGcE8v?=
 =?utf-8?B?UU9EbDhaWDdnQm1GZU1LZGtGcGJCNWNGdGRncWN2a1liMHMzZDVLaEVYcnNs?=
 =?utf-8?B?Y01CTmE5dC9lMGZTOW4yS3I4TkljWFFVeTBWaStXdFhENWsvZmtZYzhuZE5v?=
 =?utf-8?B?K0dVMHJKTDVqV29nT05naGh2bUdYQXlpeUtlMzdQLzFOWVVZK21aUmxJYTNG?=
 =?utf-8?B?S2swNnd6Vys5UUsxQWVLVkpkV2dDMVBJbmRIdlZwMFUvOVV2UFYxbGRmTkQ0?=
 =?utf-8?B?OVd0czJ5YU1iNEtLUm1HcGUzNDJZZ0t3UVVHUk9WNTJKRVkzWVJIZVYrNXpB?=
 =?utf-8?B?eFVXR1k5ZDk4TWFvZmx6bi9yT2dhbDFuUmpGWkh5WGdabUp5QjJURm4yc09q?=
 =?utf-8?B?aTRKbzB5RFUza0UzOXY5QjNIM0kzQmgxUEd6aktmKzVjOTY5TjRlOVFEd3o2?=
 =?utf-8?B?QXphZnZrd2hiblhoRUkwQ1VkMlQ2MWZ6OTBQMjBBN1NPSG9ucVNmRHN4WXFq?=
 =?utf-8?B?b0lPZXMwbkMwY1ZhNytqTkxHNXBSWWdKY2srS2wyOVpQTUl2UFYwQkkxNnAw?=
 =?utf-8?B?Q0VDWEI3V3k4YkdTVisxMmtCMjRHdVN3Z0J1UVFkV1JqRUhQMldGdGZhZVQy?=
 =?utf-8?B?ckROV0xha21oenp3MHRMVVR3L3VmNXY5blBCZFZiYldkU0w3MUpNTDdlbmxE?=
 =?utf-8?B?RHRjSG9pZ2VMK3JyTWpHY1BmWVljc3VqR2lWdFFVZFA3QmdMclNoWDdtdEFH?=
 =?utf-8?B?VEhlMW51L09IUWVJcWZweU5PVFVQR2paNlFRRUM5VFRseTB2L2kvb3pwa0Q2?=
 =?utf-8?B?Z2YzdFp3ZzJ6Nm1mRWUzMm5zNm1qVGZVOE9meXYwTjRrbERuM01oclR5Zkcr?=
 =?utf-8?B?ZVp1VElMbkRkNVp4T1pBN296UWtIS2RPcFhSL1NlRGk4UmhzMllFeG9aYUhE?=
 =?utf-8?B?VFNNckJzSnlJWlRHd1VGNlJXaFhDYThwNXR5bUV5YlcxWUZweDhNRm1jZ1Zu?=
 =?utf-8?B?RjYrZGQzUDBVYXNIV2ZrTENmekRLQWpwRTk2S0ZoTytxUHJyVnZZdmN1Q215?=
 =?utf-8?B?UVk0ZDFPL3BkVllucjZHTWM5RjM2UDNZZmlCTTR6N3hwdXRkZ3VVTzlVbWhO?=
 =?utf-8?B?bHFRNEpFL1ZyeDNHVmYxTzR6MGpnTm5FMFJDZENGRXV1ZkFCMnJyVGlQaFM1?=
 =?utf-8?B?NWRRQW5iejJnU0ZpN213TUEyeU5VZXUwM3pyTmUvNkZDUmhYSFViRWwwejM3?=
 =?utf-8?B?SkU0QkxMNTdZMG0rVzdrRXJRSCtUL2c4UThxdlNOMkJqOUhCTkwwSFdmZUVM?=
 =?utf-8?B?ZEptd3RNMWxiZjRNVklLWHROVVJQMEZ0T1Q2WndHUWZIT0EyVVk4Mkp6Sjlz?=
 =?utf-8?B?akVQTTlaL3VSS3VmK01CTmpCcnF6SkVEc0E1MTNvT1FPTlFIODNkdmV0aElL?=
 =?utf-8?B?b2hsL1JwK3cvRzlOczFiM3dGMTVqWUs2QUtXYk5MVUV4WktXQ05HdG1Vbi91?=
 =?utf-8?B?SHk4MExhTTloQUR3bzBFZGhsMUp5a1dGa2xmYmVoWVVZMzB0bDFnRmZDaTMr?=
 =?utf-8?B?c3loQjhCMS8ycWI2TG5RU1gzVElhYTg3NTlkT0Z2akxDWnFFL0o3WXVmUUhi?=
 =?utf-8?B?SzhtZnI3MjcwaUJGMFRiUVdXZHhjNnVZaUpkd0htZnRFcVFKVXp3UjM2d1B0?=
 =?utf-8?B?R0o1YXAvSVRJZ1hPYjF3Y29EYjJjQ2l4OFphdGdHWFFQcDRDWUxXME8yRnU1?=
 =?utf-8?B?QnNYZisvS0Q4VzZidHdrTzllL3pIRkZ3Z3VCZm5qWWdaTjNCczhJcVNLdlF0?=
 =?utf-8?B?ZHY3SkYwYWtzNGJxbmtWR2N3UllDTDc1V2ZNQ1A1RC9JWmR3MUQ5SEhhaklH?=
 =?utf-8?B?TDhYdGhDQU04eE5ySGcxVll0RGNhSmwzZ0NieFNCZGt6WGwyN01IMWRuRllE?=
 =?utf-8?B?RG0xVG1qUHk1Z1JKWDNhSzlHTFp0TURDdTdaKzJUWnlDRUxjWStPNGFncVNr?=
 =?utf-8?B?NW53SGFBWTdMa3RRSWt6Uk9CVC8vNXViSWVENDhPMGMyZFhsT1RZbE82YVlO?=
 =?utf-8?Q?2VVvND13LKaOXszo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DC5A43019C0D74AA77A4CE3E38B3BE4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba31f0a0-6e11-4283-d9e0-08de6a23d54f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 10:45:26.7443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hezs+WzbNMo3049YU0ocPLQ0WWbxXCetnO9GdwKifcNrGKaTmprXgmEYtjJN/a5Cg/w1a3w5KA7s0sFXZP7VcKJD2MqzKMKvWo8hBIgvQiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7296
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
PiBSZW1vdmUgdGhlIG10a19wbGxfZWFybHlfaW5pdCgpIGZ1bmN0aW9uIGFzIGl0IGlzIG5vdCB1
c2VkIGFueXdoZXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTGVjaG5lciA8ZGxlY2hu
ZXJAYmF5bGlicmUuY29tPg0KPiAtLS0NCj4gwqBhcmNoL2FybS9tYWNoLW1lZGlhdGVrL210ODE4
My9pbml0LmMgfCA1IC0tLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDUgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9tdDgxODMvaW5pdC5jIGIv
YXJjaC9hcm0vbWFjaC0NCj4gbWVkaWF0ZWsvbXQ4MTgzL2luaXQuYw0KPiBpbmRleCAzOTA3MjYy
Mjc4OC4uYjQ0NWYzZWExZTMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL21hY2gtbWVkaWF0ZWsv
bXQ4MTgzL2luaXQuYw0KPiArKysgYi9hcmNoL2FybS9tYWNoLW1lZGlhdGVrL210ODE4My9pbml0
LmMNCj4gQEAgLTM3LDExICszNyw2IEBAIGludCBkcmFtX2luaXRfYmFua3NpemUodm9pZCkNCj4g
wqAJcmV0dXJuIDA7DQo+IMKgfQ0KPiDCoA0KPiAtaW50IG10a19wbGxfZWFybHlfaW5pdCh2b2lk
KQ0KPiAtew0KPiAtCXJldHVybiAwOw0KPiAtfQ0KPiAtDQo+IMKgdm9pZCByZXNldF9jcHUodm9p
ZCkNCj4gwqB7DQo+IMKgCXBzY2lfc3lzdGVtX3Jlc2V0KCk7DQo+IA0KDQpSZXZpZXdlZC1ieTog
TWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIQ0KTWFjcGF1
bCBMaW4NCg==
