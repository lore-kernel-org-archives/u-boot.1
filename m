Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7371D2CE17
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 05:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A17D383A35;
	Wed, 10 Dec 2025 06:00:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="YrDKvZvZ";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Qvcv32gW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 650C683BFE; Wed, 10 Dec 2025 04:24:53 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 768A283AEF
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 04:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: c54995eed57711f0b2bf0b349165d6e0-20251210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=CfD+IkB5APcfyN/5JAXr4G/V5w3qX5ryHgUOrYv6FT0=; 
 b=YrDKvZvZc6CrfLE7ZHLGTYcir3LZUAt0m0xa6XS5oD/5JF2cMJ6f4gKe7YW3XMmjnPUAjXo0/nTJO3XfyfxxWUub54DMH555gWOwrw1ndaoTTO49xQBE16gMEegMVT+V90n+RWYf5zIjlk+nRdcUtMutPQHKIFS2Uj0JB4K1mos=;
X-CID-CACHE: Type:Local,Time:202512101124+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6, REQID:6bd76a36-6fea-4a20-b1f8-5dd33d116810, IP:0,
 UR
 L:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:3
X-CID-META: VersionHash:a9d874c, CLOUDID:0f2b05aa-6421-45b1-b8b8-e73e3dc9a90f,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:4|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c54995eed57711f0b2bf0b349165d6e0-20251210
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 272524434; Wed, 10 Dec 2025 11:24:43 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 10 Dec 2025 11:24:42 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 10 Dec 2025 11:24:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDiwDty/ARm3ZOrsZ3o94GzVG96FO73xktNfPxjnh2VlaxQougu8M79ag7kii5SGIWHzN72vbYbEOJXBbCiqD49Wg+dZcDvOciU/ziaF1OObne+zKDU3+s8DCVyXRTB3R+bXKCiwzY5atQDwx1biDH8QqTvfT+qDZLPHqI44HjAROxFHyaZKynre12xVdfpwlJijkFWarQJUncRRNZpQTAoVnLJWBoi1pBsrYJXtPypRWvdQIMNoqRExIc6sx0OT+mywVEOefNgAlHc7CBjbJg5EvgnbXVKfIKaUp9KNKrtRCmAP/XMl3a6LAoFgiu7ChG1ECO4XE6dQfX5Xv4z42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu6EQD4kHRXaCPeuHzs6SsCVKuUcS/mxKVh8GnnwGyA=;
 b=T2F32IXRiXqxQKfsqdMrOkRmRwAskQX6BzloXjZ/vaOfFt+rEJPaPN5Yf5Iiw/EHG74k/uBw+WqrFdEpPKBmLnvSXbCLezjukEdqxftQ6UMRebIahYkpjCrB2T33UX6eMbj74Lo4QAmco7acXKMYy4QMMSZ9hXsI9isAUqW3fVb0KZXC2bzKphg7zqzYlyEXspDHVPVZs5lb8Gc6k9M2GYcHfJ2EeR9be7cbYznsHyo2k1qQJ2VeHz82/qPedOZWw/FAqWIlTq/ahifRQwN5ySeE2lxtPwhcTEMMu5e43HhJlr5d3FZH/kCG0OTVnPym8XQI78V2gPjcXADCE44KrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu6EQD4kHRXaCPeuHzs6SsCVKuUcS/mxKVh8GnnwGyA=;
 b=Qvcv32gWmtT4/LGCfj8ygvyF6CUpEaZqDbjNcJ5CSKyf+4fJGLUUHc5Y/+aLU+uIpj3FvisgJsc4hPHS0aRjBiE/bDFUjgUEQaCBIs7VKqefiOaxRjXHIKAcjm6AUuGo3Uj5090ozacsE7OkDKvch5VF8cthj0u6oiFuoN6oy5U=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TY1PPF538CF1BBD.apcprd03.prod.outlook.com (2603:1096:408::a57)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 03:24:38 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 03:24:38 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "patrice.chotard@foss.st.com" <patrice.chotard@foss.st.com>,
 "mkorpershoek@kernel.org" <mkorpershoek@kernel.org>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
 <Chunfeng.Yun@mediatek.com>, "stefan.roese@mailbox.org"
 <stefan.roese@mailbox.org>, "ian.roberts@timesys.com"
 <ian.roberts@timesys.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, "alif.zakuan.yuslaimi@altera.com"
 <alif.zakuan.yuslaimi@altera.com>, Julien Masson <jmasson@baylibre.com>,
 "nathan.morrison@timesys.com" <nathan.morrison@timesys.com>,
 "vasileios.bimpikas@analog.com" <vasileios.bimpikas@analog.com>,
 "sumit.garg@kernel.org" <sumit.garg@kernel.org>, "lukma@denx.de"
 <lukma@denx.de>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
 "utsav.agarwal@analog.com" <utsav.agarwal@analog.com>, "hs@nabladev.com"
 <hs@nabladev.com>, "ziyao@disroot.org" <ziyao@disroot.org>,
 =?utf-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?= <Sam.Shih@mediatek.com>,
 "duje@dujemihanovic.xyz" <duje@dujemihanovic.xyz>, David Lechner
 <dlechner@baylibre.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "jerome.forissier@linaro.org"
 <jerome.forissier@linaro.org>, "arturs.artamonovs@analog.com"
 <arturs.artamonovs@analog.com>, "malysagreg@gmail.com" <malysagreg@gmail.com>
Subject: Re: [PATCH v2 1/2] arm: mediatek: add support for MediaTek MT8188 SoC
Thread-Topic: [PATCH v2 1/2] arm: mediatek: add support for MediaTek MT8188 SoC
Thread-Index: AQHcaPX+uu0TnLV0y0GEKi+HJ/uY+LUaNxqA
Date: Wed, 10 Dec 2025 03:24:38 +0000
Message-ID: <3b68f4b342c50fd97f0601f7a02266c362a1db81.camel@mediatek.com>
References: <20251209-add-mt8188-support-v2-0-31dbfcf7303c@baylibre.com>
 <20251209-add-mt8188-support-v2-1-31dbfcf7303c@baylibre.com>
In-Reply-To: <20251209-add-mt8188-support-v2-1-31dbfcf7303c@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TY1PPF538CF1BBD:EE_
x-ms-office365-filtering-correlation-id: 3486e8e5-1058-40b2-feff-08de379ba65e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?RXdiRVBYQ2lGalhJRjdCalhkSDhJdHdkRzF2ekhvK205UE9YZWoxbDBjcGRL?=
 =?utf-8?B?SFI4Y3R2a2lKOS9NcVMrckxBSWhjbDZ1bTBNUTN2NENEVVptM1JleVk2UThJ?=
 =?utf-8?B?VGVkMDJkdlRFY3VxbnA2RUZqOXF6RjZ0VFd2dnpjOWpqckxkck4vMVZBNmln?=
 =?utf-8?B?NUh5d2lUdE81VDNNbEx4endYRG1GSE9YTU5DT2VtejlHRXYydXd3dkd5aU1B?=
 =?utf-8?B?bUpDQ05hblc5VGl4VUNsUWFpSnRUdW1pN0lYb2ZncWpJaHdJY2ZXd3hKUmZY?=
 =?utf-8?B?SWFzclcxQ3dnWkp4UGpPUVdEK3Nqa1pEaWtybjl4cXp0Nzl1RzQ3WVVCKy92?=
 =?utf-8?B?ems5V3RNSmJJWnRSR0M5aHcydlpDcm1WQW1EMFhRMVk3QWE0K2Vld1J2UE5R?=
 =?utf-8?B?MGVLUlpZL2pFRjcvR2dGWnA2Yk5IS09SM21ObmhsYi9LRitnNEZ4bWpXTWFv?=
 =?utf-8?B?TCthcUttZWphWTNvM2RVTXpIQ3MrQWVsNDlYN01IM3FHRGpSMjRqRi9yMGtt?=
 =?utf-8?B?aGp6OHkxTTNJTlVnNE8vWUN1WVBGNEVPWHFWY2RQbkc5d1pPcGNIME9PUEZq?=
 =?utf-8?B?dmRBdUZWR3RJLytMZExFbWlmdVBNdkZSMDJoTFNLa3luWUViamY1M1lHaDc2?=
 =?utf-8?B?N3I3SCtFQUc4RGt2ZEtybUZxdEg1NFUyM0c4SnBqdXZLVFpFU2tXVk9nME9W?=
 =?utf-8?B?UVdtY3JZVmFrTWtwa0VwWDg0NnUwa2tyQnVWRnc0NkZCdFlacEk5cG5mVDRh?=
 =?utf-8?B?eFJXUHh4dnBLNGlYMmFYaUZUbVlZa002d2VZTVJnalMvaEdpVmNLMUp4Zk1u?=
 =?utf-8?B?dng5dXJGQXhQbDNrVmxtNXFTSndrUlFidlc2TTU4SGZqbzN5cnJFVEp4bXR1?=
 =?utf-8?B?UUtsdWlIcEVWS1ZhMW1nZHJ1THl4UFhMaWhidStVWUk5L0dnZ0QvQVN4a2hj?=
 =?utf-8?B?YjBZZUphcU1PMEt5c09ZMG9hbDUrYm5iUytHQlVWV2FibFp2bStJV1MyTW83?=
 =?utf-8?B?Y205NGxJYjJTaU4rd1JET2dESFd0ZUpZMVZmTUp3aDBLcDU1elZ5MWpyK1Q0?=
 =?utf-8?B?bEUwVFhSQ1ZhdzR3VW52M1FDQWQ3S2JDQ1B2bC9PYUZKK1BOZXVXZldTREVi?=
 =?utf-8?B?M25ZUGVsbWNQUWlEUVZQam9kRDR0YzdBSCtlRUJBajNHRHFkaTl1RVp6TTVV?=
 =?utf-8?B?WC9IeHJrZ3YyTzZjL2lDaWxyZjB5NkNrSGUrOGJGcmVVU0tmRFBkV09yMGpB?=
 =?utf-8?B?UWdGNlVqSGM4ZUdCaDNqU0E1T1FYT3RVL0d0Qm1TK0JuWXBvT3gxWWMrd2dC?=
 =?utf-8?B?czdadTJ2aEw4N0xJWVhsaWpqUmlwN0ZKc2hRZ05lMjZsR3ArWXZ3bWRFd0V6?=
 =?utf-8?B?cHJqWWk4V1BKaHMwYVVHYUN4TFZFQ0hTN2tPMmVNcC9oNThmY1JVM2FIZ1Ax?=
 =?utf-8?B?bFVXaWVXRkUzZThpcXFkSWtpa1JwWVhuRE44WUNsL1ZydDdwWmYxWkRHRGJW?=
 =?utf-8?B?empicE4rK2wrNzJjUERTengxVnRKWGdIZDErVTh0M2pnYjArUGhGVzlHaU45?=
 =?utf-8?B?cElpK1V1ZjQvUDZMTzlWUDZqN1VwT25EcGJXT2g2S2hDQmtDdnZNVzhNRlNk?=
 =?utf-8?B?V2hMZ3BkZTJKU3B3Y2t2enZpVW16UjlLR3RDdU1qS2ZmZlp5ZWhEckprRGZp?=
 =?utf-8?B?emMxWGRiMG5RSS9adFlweEdvazloeVpnUG55MS94SDk4VnJQU09iS2RaYzNq?=
 =?utf-8?B?MklCN1pGekpLUWF4cUMzNE50eS85R2VyaEsyZjBCcFZmTEh5dXFiZmtiVzdF?=
 =?utf-8?B?MTVuY2VWckJ2YXk1a2FHNU9vWVFxSjI1bXRELzl0bmM5eEJiOHV6MzRjbk1r?=
 =?utf-8?B?VC9idjQySzU3c0lKdXl5ZGYvbUxxQ1RkR3VKaDhIU1lEelpUSzRzbWtDazFU?=
 =?utf-8?B?K3dFOHBBNERGUGdDa3RaMHhOeEd6WDh0eDNYQ1pMSzNoUW1kN1U5dWFyR1Y4?=
 =?utf-8?B?TzNXRHNwU1dYQmFSVHZsRy9WQ2NEcFltcmJJVkRHQnlzeDV5Y0owU05rYUpO?=
 =?utf-8?Q?XGBnSq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGlEVVBRdDJ2MXo1cGpxR1V3ZnJMaFYxc3Job250NCtKUHhySzN0YytCOHU5?=
 =?utf-8?B?QVJkNzNzRERnN0hjOStpQ3VKY2RkTmVXV1lBVTRlSTRKczlSQ3E2WXlPemxM?=
 =?utf-8?B?WVY0aVNnZEFzalR1QmxxNi9OeTdXRzNYbzZOOFVNRVBwUjdwTllFUTJUYWlz?=
 =?utf-8?B?d2FHejdkZy9INWNRakc0clVCdW9ya1o1U3JkeEdzWHphMXRLSTRYeDMxcDUw?=
 =?utf-8?B?RGZ1Y09TZkZtaDBmOTk3blhVREp1Zk5VcGFOaVZ6YUMybGJBYUhJUVRSQzhH?=
 =?utf-8?B?SUdiV0NiYzBDSGJ0VjZ0L0NHRHZGZzErRUxEMmRHMjZhZ1ZqOHNMQjdsWVpV?=
 =?utf-8?B?Yzd0N0tQOEwvdmpaWWlLaWxma29ib0UzUkR6U0phVW9RaHVOWUZuWWdTZzFa?=
 =?utf-8?B?OS9NT3FxVXMvME1LQWpYUndvVWhOZXExVXVpRHg2ZkpHQ3dSL1R2ZzZLUUZW?=
 =?utf-8?B?ZEFhWk5yZkxJREJmY0lwN2plaHhFVmdLNWpxK0xaeVdzeSsvNDFxL0VVVzZT?=
 =?utf-8?B?elRuNEZUajVvazFZMURMdnMzTUZQTlorcmxxZ0JpU1M4YWFJa3NJZDd1TVk2?=
 =?utf-8?B?OENZUHJJekhvWTF5RTJFZ3Juc2N5NTZsZzVXckxneWNPbzR5N3pSazBwaE1C?=
 =?utf-8?B?RVl2Y2NGb09naE1tT29CK0hFQTlzZXhvQnJNSm9Vd2RxczVaOUNHRExyZ2J1?=
 =?utf-8?B?dUFJdGZ1WndTL1Bnd2pwempZNzRoSjBFbmVpaUI3d2pPbUVUdlpvYitobmtN?=
 =?utf-8?B?RDV3YXRXWWR1enN5b3pMOXlGZnUzN0VqMHFIdGNydFZQazFISUpyQnpueW5m?=
 =?utf-8?B?U2orY1MzcnpUdWJSb1JFZmdlWXB3anpJRkZZMmh4Y2xqTUFVS2N4K1kvT1Fo?=
 =?utf-8?B?TzhxTnQxZXhKenYySkI3Qm1SdjlXaFc2b2sxWkNsaGUwZnZBUHlUMm9KY0Vz?=
 =?utf-8?B?TGRQS0Z6c21EU21NUU9kUVk2cGFhRlFPaEEvc3dOVjZZUjNQTmxpOVhJd3J1?=
 =?utf-8?B?ckd3L1lZVlhMcGp4UEhDbXJtSnQ2UWFZMzBoUnl2c3VvcjRPVURGSlVndFN4?=
 =?utf-8?B?ZTdWTHBkQ05lcFE4UnQyYmhsd0NoRlh6Y01mWjRVVTVyeXVPS1U1Y3ZvZkx6?=
 =?utf-8?B?MTV2ZVdHc0JYaW9HeStvVzRVSE5sYTVPOEhOTk41V2M3NWpnaG4zYXNvUGxv?=
 =?utf-8?B?bGQ5Z1A5NzAzUUhISis0TXZWb0dFKzFveCtnQ1JnSDdWekNMOVhKeXBjUTA5?=
 =?utf-8?B?VXIrOWdnS0t5NTA4YzhFTFlDbktFRzhiQk5rVVFtSndtb09GRzZDNDEvditD?=
 =?utf-8?B?NW11aG1vZnM1RTA3VUpRZUY1MXlyczBmc01FM2RPK1l6SWJWYlJOSFErazN3?=
 =?utf-8?B?TWEzazBFbnIvUm8yZDNZN3NLdVBHMEozbFNxV2NsS1V6bzhZOGVSOHV1NWhl?=
 =?utf-8?B?MDV5UVpqRWZxOEdFeVVwaVI5U1EyeEdRTGtTSnlYNjlXN3kxbGRxU21XaFdv?=
 =?utf-8?B?MEk0UGVSekxld1BmMlkyRkY1VjNPTFR2QUhRbDNYelhlbkIvcE9hZ2RSency?=
 =?utf-8?B?SHF6aTRPUDh3YjJOU3R1RHh1c0hsNkhjKyt0Skg3UVowak5TMUhjbktlK052?=
 =?utf-8?B?NTdZaGo0dDFDRmJRa3pOQ3hxOW40Um5BcEtWRFh1TEJnSEJCUFV5SGdoeUJX?=
 =?utf-8?B?VUFKZ3JuWUp6SHF5ejhDNzNXenZGQldxVTdZaFl5ZnlJR0xxMktNUEV5TUlI?=
 =?utf-8?B?OUF4Q1M2VnNZYjZURk9HUXdYUkNGRlQxcVkvUmprd3JjNEhJREpGMXlTRVFs?=
 =?utf-8?B?bzQvUDV6YXFMZmtSUENERU00aS9nQzVkRTlRWmNUTG1QdEM4cXYvUGNDN2U4?=
 =?utf-8?B?amlLUUo4L3RaK0lNMkVUbHQzVDc0TWJPWGNSeEs4bGk1bm5qK0ZJQ0ZYSkxQ?=
 =?utf-8?B?dmEyelZqTGcwa0NWZXl1ZEJUVVdsMG1ZN04rWGFUNUFkbjFhV0tYMHo2N3Fo?=
 =?utf-8?B?dFpwVklpT21lZCt4K2JTU3NVY0lzWkxOMmJtVHB1bzBEVTJqMWdaL0cwS0tm?=
 =?utf-8?B?clYrZUF2a2xKbFViVCtFblBpOFc1NmMzNjFaQWsyeTFReGtLWXE2SmVtYjQv?=
 =?utf-8?B?Z3ZpUDJrTFlYeWIxaVJzaFZrQnNEaVJSUk56eVJPeVRpbHJQWURBM01CNzVj?=
 =?utf-8?B?NGc9PQ==?=
Content-ID: <4F8617045A681D458683F5C41A7CFF06@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3486e8e5-1058-40b2-feff-08de379ba65e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 03:24:38.2933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+Zb+JR+Y4V4B7ngxXn+wHL/afUe/ug2v/3aKOwJW4hWrU5Mk8vENqi+qxS/8YqdTYuVL5hIsHdA4SuixHWr7icmc8MYWbLsSLTLGm3dBSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF538CF1BBD
X-Mailman-Approved-At: Wed, 10 Dec 2025 06:00:24 +0100
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

T24gVHVlLCAyMDI1LTEyLTA5IGF0IDExOjIyICswMTAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gRnJvbTogSnVsaWVuIE1hc3NvbiA8am1hc3NvbkBiYXlsaWJyZS5jb20+DQo+IA0KPiBUaGlz
IGFkZHMgYmFzaWMgc3VwcG9ydCBmb3IgTWVkaWFUZWsgTVQ4MTg4IFNvQy4NCj4gDQo+IEFkZCB3
YXRjaGRvZyBzdXBwb3J0IGJ5IGFkZGluZyB1cHN0cmVhbSBjb21wYXRpYmxlIHN0cmluZy4NCj4g
DQo+IEFkZCB0cGh5IHN1cHBvcnQgYnkgYWRkaW5nICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjIi
IGNvbXBhdGlibGUNCj4gc3RyaW5nDQo+IGluIGFyY2gvYXJtL2R0cy9tdDgxODgtdS1ib290LmR0
c2kNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBNYXNzb24gPGptYXNzb25AYmF5bGlicmUu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKdWxpZW4gU3RlcGhhbiA8anN0ZXBoYW5AYmF5bGlicmUu
Y29tPg0KPiAtLS0NCj4gwqBNQUlOVEFJTkVSU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+IMKgYXJjaC9hcm0vZHRzL210ODE4
OC11LWJvb3QuZHRzacKgwqDCoMKgwqDCoMKgIHwgMTAgKysrKysNCj4gwqBhcmNoL2FybS9tYWNo
LW1lZGlhdGVrL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgIHwgMTEgKysrKystDQo+IMKgYXJjaC9h
cm0vbWFjaC1tZWRpYXRlay9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gwqBhcmNo
L2FybS9tYWNoLW1lZGlhdGVrL210ODE4OC9NYWtlZmlsZSB8wqAgMyArKw0KPiDCoGFyY2gvYXJt
L21hY2gtbWVkaWF0ZWsvbXQ4MTg4L2luaXQuY8KgwqAgfCA3MA0KPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+IMKgZHJpdmVycy93YXRjaGRvZy9tdGtfd2R0LmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiDCoDcgZmlsZXMgY2hhbmdlZCwgOTYgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIv
TUFJTlRBSU5FUlMNCj4gaW5kZXgNCj4gYjQzZGFlODgyYjNlYTMzYzJjZDc0NWJkMzc1OWUzZjRk
OTdhYmM4MC4uNWI1MmQyZmUxNzUwNmQyNjU5YmU5MDE2YTdjDQo+IGE2MzkwNjIzMzJhZTkgMTAw
NjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC00MTUs
NiArNDE1LDcgQEAgTTrCoCBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+
DQo+IMKgTTrCoMKgwqDCoCBJZ29yIEJlbHdvbiA8aWdvci5iZWx3b25AbWVudGFsbHlzYW5lbWFp
bmxpbmVycy5vcmc+DQo+IMKgUjrCoMKgwqDCoCBHU1NfTVRLX1Vib290X3Vwc3RyZWFtIDxHU1Nf
TVRLX1Vib290X3Vwc3RyZWFtQG1lZGlhdGVrLmNvbT4NCj4gwqBTOsKgwqDCoMKgIE1haW50YWlu
ZWQNCj4gK0Y6wqDCoMKgwqAgYXJjaC9hcm0vZHRzL210Kg0KPiDCoEY6wqDCoMKgwqAgYXJjaC9h
cm0vbWFjaC1tZWRpYXRlay8NCj4gwqBGOsKgwqDCoMKgIGFyY2gvYXJtL2luY2x1ZGUvYXNtL2Fy
Y2gtbWVkaWF0ZWsvDQo+IMKgRjrCoMKgwqDCoCBib2FyZC9tZWRpYXRlay8NCj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2R0cy9tdDgxODgtdS1ib290LmR0c2kgYi9hcmNoL2FybS9kdHMvbXQ4MTg4
LXUtDQo+IGJvb3QuZHRzaQ0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleA0KPiAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLi42ZDFiMmFiODJkYTFjOTVhNDli
OGE2OTNlYjANCj4gZjg1NGFiOTEzYTI2Yg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2FyY2gv
YXJtL2R0cy9tdDgxODgtdS1ib290LmR0c2kNCj4gQEAgLTAsMCArMSwxMCBAQA0KPiArLy8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIE1JVCkNCj4gKy8qDQo+ICsgKiBDb3B5
cmlnaHQgKGMpIDIwMjUgQmF5bGlicmUgU0FTLg0KPiArICogQXV0aG9yOiBKdWxpZW4gTWFzc29u
IDxqbWFzc29uQGJheWxpYnJlLmNvbT4NCj4gKyAqLw0KPiArDQo+ICsmdTNwaHkwIHsNCj4gK8Kg
wqDCoMKgwqDCoCBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OC10cGh5IiwgIm1lZGlhdGVr
LGdlbmVyaWMtdHBoeS0NCj4gdjMiLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgIm1lZGlhdGVrLGdlbmVyaWMtdHBoeS12MiI7DQo+ICt9Ow0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9LY29uZmlnIGIvYXJjaC9hcm0vbWFjaC0NCj4gbWVk
aWF0ZWsvS2NvbmZpZw0KPiBpbmRleA0KPiBlNTRjNDU2YWVjMGJkYTNiYzFjMDZkMDc4MGQ3NGU5
NmE2NTk1MzFkLi5mN2VmMTdlMDIwM2M3NGE1YzE4NjMwNjM2ZjkNCj4gNzhjYmNmYjk0ODA4OSAx
MDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9LY29uZmlnDQo+ICsrKyBiL2Fy
Y2gvYXJtL21hY2gtbWVkaWF0ZWsvS2NvbmZpZw0KPiBAQCAtODQsNiArODQsMTUgQEAgY29uZmln
IFRBUkdFVF9NVDgxODMNCj4gwqDCoMKgwqDCoMKgwqDCoMKgIFNEIGFuZCBNTUMgY2FyZHMsIFVG
UywgUFdNLCBJMkMsIEkyUywgUy9QRElGLCBhbmQgc2V2ZXJhbA0KPiBMUEREUjMNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGFuZCBMUEREUjQgb3B0aW9ucy4NCj4gDQo+ICtjb25maWcgVEFSR0VUX01U
ODE4OA0KPiArwqDCoMKgwqDCoMKgIGJvb2wgIk1lZGlhVGVrIE1UODE4OCBTb0MiDQo+ICvCoMKg
wqDCoMKgwqAgc2VsZWN0IEFSTTY0DQo+ICvCoMKgwqDCoMKgwqAgaGVscA0KPiArwqDCoMKgwqDC
oMKgwqDCoCBUaGUgTWVkaWFUZWsgTVQ4MTg4IGlzIGEgQVJNNjQtYmFzZWQgU29DIHdpdGggYSBk
dWFsLWNvcmUNCj4gQ29ydGV4LUE3OA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgIGNsdXN0ZXIgYW5k
IGEgc2l4LWNvcmUgQ29ydGV4LUE1NSBjbHVzdGVyLiBJdCBpbmNsdWRlcw0KPiBVQVJULCBTUEks
DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqAgVVNCMy4wIGR1YWwgcm9sZSwgU0QgYW5kIE1NQyBjYXJk
cywgVUZTLCBQV00sIEkyQywgSTJTLA0KPiBTL1BESUYsIGFuZA0KPiArwqDCoMKgwqDCoMKgwqDC
oMKgIHNldmVyYWwgTFBERFIzIGFuZCBMUEREUjQgb3B0aW9ucy4NCj4gKw0KPiDCoGNvbmZpZyBU
QVJHRVRfTVQ4MzY1DQo+IMKgwqDCoMKgwqDCoMKgIGJvb2wgIk1lZGlhVGVrIE1UODM2NSBTb0Mi
DQo+IMKgwqDCoMKgwqDCoMKgIHNlbGVjdCBBUk02NA0KPiBAQCAtMTU3LDcgKzE2Niw3IEBAIGNv
bmZpZyBTWVNfQ09ORklHX05BTUUNCj4gwqBjb25maWcgTVRLX0JST01fSEVBREVSX0lORk8NCj4g
wqDCoMKgwqDCoMKgwqAgc3RyaW5nDQo+IMKgwqDCoMKgwqDCoMKgIGRlZmF1bHQgIm1lZGlhPW5v
ciIgaWYgVEFSR0VUX01UODUxOCB8fCBUQVJHRVRfTVQ4NTEyIHx8DQo+IFRBUkdFVF9NVDc2MjkN
Cj4gLcKgwqDCoMKgwqDCoCBkZWZhdWx0ICJtZWRpYT1lbW1jIiBpZiBUQVJHRVRfTVQ4NTE2IHx8
IFRBUkdFVF9NVDgzNjUgfHwNCj4gVEFSR0VUX01UODE4Mw0KPiArwqDCoMKgwqDCoMKgIGRlZmF1
bHQgIm1lZGlhPWVtbWMiIGlmIFRBUkdFVF9NVDg1MTYgfHwgVEFSR0VUX01UODM2NSB8fA0KPiBU
QVJHRVRfTVQ4MTgzIHx8IFRBUkdFVF9NVDgxODgNCj4gwqDCoMKgwqDCoMKgwqAgZGVmYXVsdCAi
bGs9MSIgaWYgVEFSR0VUX01UNzYyMw0KPiANCj4gwqBjb25maWcgTVRLX1RaX01PVkFCTEUNCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtbWVkaWF0ZWsvTWFrZWZpbGUgYi9hcmNoL2FybS9t
YWNoLQ0KPiBtZWRpYXRlay9NYWtlZmlsZQ0KPiBpbmRleA0KPiBjMTFkNmFkOGFlZDZlNDExNjM2
ZmQ4YWVhMWIxZWNhNmJhNDc4MGE4Li40NDU5MWJlZDZmYTBjNTdhMDI2ZmEwYjcxZjUNCj4gZTQ2
OTExY2ExOGE1MCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9NYWtlZmls
ZQ0KPiArKysgYi9hcmNoL2FybS9tYWNoLW1lZGlhdGVrL01ha2VmaWxlDQo+IEBAIC0xMiw2ICsx
Miw3IEBAIG9iai0kKENPTkZJR19UQVJHRVRfTVQ3OTg2KSArPSBtdDc5ODYvDQo+IMKgb2JqLSQo
Q09ORklHX1RBUkdFVF9NVDc5ODcpICs9IG10Nzk4Ny8NCj4gwqBvYmotJChDT05GSUdfVEFSR0VU
X01UNzk4OCkgKz0gbXQ3OTg4Lw0KPiDCoG9iai0kKENPTkZJR19UQVJHRVRfTVQ4MTgzKSArPSBt
dDgxODMvDQo+ICtvYmotJChDT05GSUdfVEFSR0VUX01UODE4OCkgKz0gbXQ4MTg4Lw0KPiDCoG9i
ai0kKENPTkZJR19UQVJHRVRfTVQ4MzY1KSArPSBtdDgzNjUvDQo+IMKgb2JqLSQoQ09ORklHX1RB
UkdFVF9NVDg1MTIpICs9IG10ODUxMi8NCj4gwqBvYmotJChDT05GSUdfVEFSR0VUX01UODUxNikg
Kz0gbXQ4NTE2Lw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9tdDgxODgv
TWFrZWZpbGUgYi9hcmNoL2FybS9tYWNoLQ0KPiBtZWRpYXRlay9tdDgxODgvTWFrZWZpbGUNCj4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXgNCj4gMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMC4uODg2YWI3ZTRlYjlmYTQ1MzNkNTE5OTViMTA0DQo+IDJmZTJmMWZl
YmRjMzMNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9hcmNoL2FybS9tYWNoLW1lZGlhdGVrL210
ODE4OC9NYWtlZmlsZQ0KPiBAQCAtMCwwICsxLDMgQEANCj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6wqDCoMKgwqAgR1BMLTIuMA0KPiArDQo+ICtvYmoteSArPSBpbml0Lm8NCj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL21hY2gtbWVkaWF0ZWsvbXQ4MTg4L2luaXQuYyBiL2FyY2gvYXJtL21h
Y2gtDQo+IG1lZGlhdGVrL210ODE4OC9pbml0LmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
aW5kZXgNCj4gMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMC4uZWQ2NzE1
MGU2MTE5MmQ4OTg3NWExNDU0MDQ0DQo+IDQwYTk3MDM2ZWQzNGINCj4gLS0tIC9kZXYvbnVsbA0K
PiArKysgYi9hcmNoL2FybS9tYWNoLW1lZGlhdGVrL210ODE4OC9pbml0LmMNCj4gQEAgLTAsMCAr
MSw3MCBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gKy8qDQo+
ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjUgTWVkaWFUZWsgSW5jLg0KPiArICogQ29weXJpZ2h0IChD
KSAyMDI1IEJheUxpYnJlLCBTQVMNCj4gKyAqIEF1dGhvcjogSnVsaWVuIE1hc3NvbiA8am1hc3Nv
bkBiYXlsaWJyZS5jb20+DQo+ICsgKsKgwqDCoMKgwqDCoMKgwqAgQ2hyaXMtUUogQ2hlbiA8Y2hy
aXMtcWouY2hlbkBtZWRpYXRlay5jb20+DQo+ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgPGFzbS9n
bG9iYWxfZGF0YS5oPg0KPiArI2luY2x1ZGUgPGFzbS9zeXN0ZW0uaD4NCj4gKyNpbmNsdWRlIDxk
bS91Y2xhc3MuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9zaXplcy5oPg0KPiArI2luY2x1ZGUgPHdk
dC5oPg0KPiArDQo+ICtERUNMQVJFX0dMT0JBTF9EQVRBX1BUUjsNCj4gKw0KPiAraW50IGRyYW1f
aW5pdCh2b2lkKQ0KPiArew0KPiArwqDCoMKgwqDCoMKgIGludCByZXQ7DQo+ICsNCj4gK8KgwqDC
oMKgwqDCoCByZXQgPSBmZHRkZWNfc2V0dXBfbWVtb3J5X2JhbmtzaXplKCk7DQo+ICvCoMKgwqDC
oMKgwqAgaWYgKHJldCkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJl
dDsNCj4gKw0KPiArwqDCoMKgwqDCoMKgIGZkdGRlY19zZXR1cF9tZW1fc2l6ZV9iYXNlKCk7DQo+
ICsNCj4gK8KgwqDCoMKgwqDCoCAvKg0KPiArwqDCoMKgwqDCoMKgwqAgKiBMaW1pdCBnZC0+cmFt
X3RvcCBub3QgZXhjZWVkaW5nIFNaXzRHLsKgIFNvbWUgcGVyaXBoYWxzDQo+IGxpa2UgbW1jDQo+
ICvCoMKgwqDCoMKgwqDCoCAqIHJlcXVpcmVzIERNQSBidWZmZXIgYWxsb2NhdGVkIGJlbG93IFNa
XzRHLg0KPiArwqDCoMKgwqDCoMKgwqAgKg0KPiArwqDCoMKgwqDCoMKgwqAgKiBOb3RlOiBTWl8x
TSBpcyBmb3IgYWRqdXN0aW5nIGdkLT5yZWxvY2FkZHIsIHRoZSByZXNlcnZlZA0KPiBtZW1vcnkg
Zm9yDQo+ICvCoMKgwqDCoMKgwqDCoCAqIHUtYm9vdCBpdHNlbGYuDQo+ICvCoMKgwqDCoMKgwqDC
oCAqLw0KPiArwqDCoMKgwqDCoMKgIGlmIChnZC0+cmFtX2Jhc2UgKyBnZC0+cmFtX3NpemUgPj0g
U1pfNEcpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdkLT5tb25fbGVuID0gKGdk
LT5yYW1fYmFzZSArIGdkLT5yYW1fc2l6ZSArIFNaXzFNKSAtDQo+IFNaXzRHOw0KPiArDQo+ICvC
oMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK2ludCBkcmFtX2luaXRfYmFua3Np
emUodm9pZCkNCj4gK3sNCj4gK8KgwqDCoMKgwqDCoCBnZC0+YmQtPmJpX2RyYW1bMF0uc3RhcnQg
PSBnZC0+cmFtX2Jhc2U7DQo+ICvCoMKgwqDCoMKgwqAgZ2QtPmJkLT5iaV9kcmFtWzBdLnNpemUg
PSBnZC0+cmFtX3NpemU7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gK30NCj4g
Kw0KPiAraW50IG10a19zb2NfZWFybHlfaW5pdCh2b2lkKQ0KPiArew0KPiArwqDCoMKgwqDCoMKg
IHJldHVybiAwOw0KPiArfQ0KPiArDQo+ICt2b2lkIHJlc2V0X2NwdSh2b2lkKQ0KPiArew0KPiAr
wqDCoMKgwqDCoMKgIHN0cnVjdCB1ZGV2aWNlICp3ZHQ7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoCBp
ZiAoSVNfRU5BQkxFRChDT05GSUdfUFNDSV9SRVNFVCkpIHsNCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcHNjaV9zeXN0ZW1fcmVzZXQoKTsNCj4gK8KgwqDCoMKgwqDCoCB9IGVsc2Ug
ew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1Y2xhc3NfZmlyc3RfZGV2aWNlKFVD
TEFTU19XRFQsICZ3ZHQpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAod2R0
KQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd2R0X2V4
cGlyZV9ub3cod2R0LCAwKTsNCj4gK8KgwqDCoMKgwqDCoCB9DQo+ICt9DQo+ICsNCj4gK2ludCBw
cmludF9jcHVpbmZvKHZvaWQpDQo+ICt7DQo+ICvCoMKgwqDCoMKgwqAgcHJpbnRmKCJDUFU6wqDC
oCBNZWRpYVRlayBNVDgxODhcbiIpOw0KPiArwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPiArfQ0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy93YXRjaGRvZy9tdGtfd2R0LmMgYi9kcml2ZXJzL3dhdGNo
ZG9nL210a193ZHQuYw0KPiBpbmRleA0KPiA3MDZkZWI5ZGE4NDYyNmQ4OTM1YTMwZDljZjY4MzEy
ODk4MDRkOTlkLi40ZDRhYjRjYmU5MDNlODY3ZjgzNDQyN2RiZmYNCj4gNGQ5Y2U0NGVmZTc4NCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy93YXRjaGRvZy9tdGtfd2R0LmMNCj4gKysrIGIvZHJpdmVy
cy93YXRjaGRvZy9tdGtfd2R0LmMNCj4gQEAgLTE0NSw2ICsxNDUsNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHVkZXZpY2VfaWQgbXRrX3dkdF9pZHNbXSA9IHsNCj4gwqDCoMKgwqDCoMKgwqAgeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayx3ZHQifSwNCj4gwqDCoMKgwqDCoMKgwqAgeyAuY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDY1ODktd2R0In0sDQo+IMKgwqDCoMKgwqDCoMKgIHsgLmNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ3OTg2LXdkdCIgfSwNCj4gK8KgwqDCoMKgwqDCoCB7IC5jb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OC13ZHQiIH0sDQo+IMKgwqDCoMKgwqDCoMKgIHt9DQo+
IMKgfTsNCj4gDQo+IA0KPiAtLQ0KPiAyLjUwLjENCj4gDQoNClJldmlld2VkLWJ5OiBNYWNwYXVs
IExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KDQpCZXN0IHJlZ2FyZHMsDQpNYWNwYXVs
IExpbg0K
