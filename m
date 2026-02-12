Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964F7EDF057
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 08:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 960B483A47;
	Thu, 12 Feb 2026 09:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="lNBnXr0n";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="FOSxFwDc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A74583B64; Thu, 12 Feb 2026 09:21:24 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B33948367F
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 09:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: c9a3d3a607eb11f1b7fc4fdb8733b2bc-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=155Hh14O08qTNDRjdXxGUbwneMJCs3NjtENVobqv8JM=; 
 b=lNBnXr0nF/8JYViQPwKz/fn9ACSXIo2TotpFHpZq1Mu48n7MYfkyo5dqZO9GfD/Dc5dEQh438bwTJMdghTEx5T43Q/WE8tM0pJtfA7ryT297KkM56M7Qpjxm+2ZV5jTuh6os3gwhpfORdZLhcSznAT5uZgzijXErq9d+K1Xxn3M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:7d6b1d2f-f4c8-4d33-850f-7d6b45b5d79a, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:3012385b-a957-4259-bcca-d3af718d7034,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c9a3d3a607eb11f1b7fc4fdb8733b2bc-20260212
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1452267122; Thu, 12 Feb 2026 16:21:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 16:21:09 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 16:21:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZPRI6um0RsGXetLHAJo7JIJgmYBKZInYynla+pu8ZWOp94dx6Lzpup5Olie1+OQAP8jALLVqFSqjkxFVOcpxucdznhj0AujHbhOgfDwyJNZD12rjLxBr0Fy5o71bDLPdQLnO3BbyE6RWZy86rQlKw9DU5F4a22K6RYONIQRri0qWcAFHuH8rOsRCKlWiA9wI5MgALXEcHj2d4NVtZbUUm5NbqwH+6CnScJH9FKrhixGRNAmEZ5b7cwho9Yr2OClVc/GqPNigVNrd8qaIandRIXlgIjAZVg35J5u7LEykpB+vK0DwGneysAowQjISgArEZKSvz+zufXBAzy0hzOFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=155Hh14O08qTNDRjdXxGUbwneMJCs3NjtENVobqv8JM=;
 b=aS9GI8gbmyLGiwAOqOYnpfbZvYUV//5EOxOYbtRvhfDVKzYz+Hc/ICTQO90m0euEZP1PjC5A2PzD5laT8sOTSjfx0XJQsWmciA+SpMyw6ioGQvzyb9Uugvg79hPEOg6yPY6DOZMxpok896zsvuuskoCDFicY6/f1a0kd2ol7WgZJyzS1V1q5XE7EsePjMJklYKULI6GhA1HwEF9RN57A5e2FDpP+IpKkDJhFT4uU3VJQK1SHPft01L8hj31QhvthpyTfzYOEEJ83HR6zOmH37kDVTIJVGzNxPo1rtOkYS8woGtti137rTx98VBta58SvBxRWpfv4W8JQxI54sikYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=155Hh14O08qTNDRjdXxGUbwneMJCs3NjtENVobqv8JM=;
 b=FOSxFwDcBhObdfLNc+E5Yqygd5J1fID7FurPxINwi2qAemkPbckVCqHfkDOngzNkmvlQYSAT3tgdtc8Cz8NbKuJeBBNxzfGTClCevmkBQWUkmYsZ2atsLJ41dZD5vfJUZaS13L7DI1E4o4CI2F3eCu6tfuoKfiDZcNUyjoDVsoY=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYSPR03MB8129.apcprd03.prod.outlook.com (2603:1096:400:476::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 08:21:06 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 08:21:06 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, =?utf-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?=
 <Sam.Shih@mediatek.com>, =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>, "aouledameur@baylibre.com"
 <aouledameur@baylibre.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "quic_varada@quicinc.com" <quic_varada@quicinc.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "andrew.goodbody@linaro.org" <andrew.goodbody@linaro.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>, "macpaul@gmail.com"
 <macpaul@gmail.com>, =?utf-8?B?UmFtYXggTG8gKOe+heaYjumBoCk=?=
 <Ramax.Lo@mediatek.com>, "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 "marex@denx.de" <marex@denx.de>, "sjg@chromium.org" <sjg@chromium.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "balaji.selvanathan@oss.qualcomm.com" <balaji.selvanathan@oss.qualcomm.com>,
 "casey.connolly@linaro.org" <casey.connolly@linaro.org>,
 =?utf-8?B?SHQgTGluICjmnpfngJrlrpcp?= <Ht.Lin@mediatek.com>
Subject: Re: [PATCH] scsi: Adjust SCSI inquiry command data length
Thread-Topic: [PATCH] scsi: Adjust SCSI inquiry command data length
Thread-Index: AQHcm0MNZ/Puxtjb1kSwtCbOGje54rV9VoQAgAFkBYA=
Date: Thu, 12 Feb 2026 08:21:05 +0000
Message-ID: <cc89f88aa46ee7f260b8182484701f0ce02f60bc.camel@mediatek.com>
References: <20260211104043.2445588-1-macpaul.lin@mediatek.com>
 <52bb5837-ed36-4749-824b-e1215bedfce4@mailbox.org>
In-Reply-To: <52bb5837-ed36-4749-824b-e1215bedfce4@mailbox.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYSPR03MB8129:EE_
x-ms-office365-filtering-correlation-id: 24b37e35-d632-4612-e949-08de6a0fab12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|3613699012; 
x-microsoft-antispam-message-info: =?utf-8?B?empMNyt1TFdlNFFXdUFZRjB4UG5uUEtTa1NlUFJKa1dCa1ZubXJYbUFqakxB?=
 =?utf-8?B?bWZrSllPcHdUM2M3UmI1THhUOEs0NnBQUVRhdVl6NFRyZkVHMTBUYWFZZk9X?=
 =?utf-8?B?U2JQNEFlNE9sclpQZXdhTTRScXM5RG9aam1YT1RQVE1aRjk1LzVFZGZrTFcx?=
 =?utf-8?B?YURGckI4ZllzcXNqZHVvMWxCeHo3VzJ3UFEyU0ZwSHE5dVJRSE4yZkhIRHc4?=
 =?utf-8?B?ZEpUaWJUUXlYNXBWcXphWWc1RndMTzRoeTROalFVcHZIYjd1dDF6aFdVR0Vh?=
 =?utf-8?B?VlB1VUplUGQvTmlhRGsrWW1Ucys2dXdEelhXM1F2QXlmanJCNXBDbmVLOHZp?=
 =?utf-8?B?VGtubjRBcjBwZmhWQU5TYTRmT3ZJcU9yVmlpRUpRTlU3S2thY1lIY0FCUGxx?=
 =?utf-8?B?NDFQNzBVM0ZtaWpqMmJYcjEzQk0yeTFOWFR0c1pnTVlmaTNXYW5aQmp1R1Bz?=
 =?utf-8?B?NEJFQW5NWFdlZkZGazA4dVVWNWVqZmlXVHcrMzh6TmVXc1RXNHRyK3lsZnhp?=
 =?utf-8?B?dklXS2J4VlM2b2FuWXBUVmFrYWFITEwzKzZqS1daOTBUcHRaYjZHdjZKUkhZ?=
 =?utf-8?B?c2hMbk5vOHIwK09SYWpKUjJUUXpiUlllczFCVHN3UklVNzZKZkxwV21kR3Jy?=
 =?utf-8?B?QmFQeW4xQTE4ejNDSnIycU9JZ1pybnhDZlBkWGpJeGNnc2NLK25TRndDc2JJ?=
 =?utf-8?B?NzZlakhybkt2MmlCdlJ4dVNheEIxYnNaN2hRZnJmNkZDKzVRVE5HRzYzN083?=
 =?utf-8?B?U1dwRjdyRUxNOGdvWnc1RE1qYjZUNWFQQTM4RFFDdmQzaXhjdzR4TFlwZEVu?=
 =?utf-8?B?U1hnbWpBZVJSNzlNeXRwbmFrVFFzUGlXcDFuTHZ5UWljU2ZDY2hkTFIzWXpQ?=
 =?utf-8?B?a2swMzhUWnJydy9oTDU1T25vakRDV0x1WWtSdmlnY1VLTmh2ekFBZ3crNC9P?=
 =?utf-8?B?NTZoU0xDamg0cTQ0a3liczZhZFNaNGdaYnkvL1ZJU3BZa1U2RmlFcTk0ZUVR?=
 =?utf-8?B?SUc2LzRZZnhtM3pSMFNQMnpHNXJZYkQvRGlUTDhRTlVEblVtU09qem5NUUZK?=
 =?utf-8?B?U0QwYUdWcTRvSFNDc0h4MllYRDZLek1TOUdiNm1BNi9pelZoa3NibTAzVmtN?=
 =?utf-8?B?YUV3TzJlT0Z0cmNyOE5ZNGJKMTRZUjhoQmNIalZSMFBBSHdjcE9lbWFyQVc4?=
 =?utf-8?B?QUJ6SEwxWjlBb0lRR0xCeVZKcHpjOU1LTlBMd09RbmNwMGVoOXlBdnh5Tmdl?=
 =?utf-8?B?cXRtNW5zOG0wTkNLMm9rcUd6cjB6QXFwb29QQzJjWG9OSU9TcUt1VjkzSnF5?=
 =?utf-8?B?MWh1OWdzZmZncFpoN3VDN0tGdDB0WDFxeExtOTNCSE5NWHpPS2ZncFBVYWVk?=
 =?utf-8?B?TE1VNm93dVFxaFhZNENpaVFXbTJtbE43SkJadG9Jc1RSdXorZTVxVHNBMUs2?=
 =?utf-8?B?ekV2UUF0ZU9qNjFBMnJ0cllNVEs2NGkrRWRCcGtLZG10WUNpUzJESDZ1OGxI?=
 =?utf-8?B?VmtML0tuVFlJM3grODdLUmtpOHdpQWtaTXlkWWZqSGpFVWJ1UW9nVWg5TDNv?=
 =?utf-8?B?K01RdS9QcnB5T3g2enFLMTVzWTBCRlp4RVN2aUEySXVnLzNpM0JmYytaUTBU?=
 =?utf-8?B?V2hUTWx2QXA5YjRmcmhmVDMvaVFKOGRiOVpzVkdxNVpQK3ZIRyt1K1hVWnkr?=
 =?utf-8?B?WGErdTlFMC8yTlBUSXRKUjQwdUZHWHJyYkJqNGFVVTZ0QUFST3VHUU00RHlF?=
 =?utf-8?B?Sko4MWY1c3FRUUJMWU1hWmIrUDVzRGdmWnhBeGRiVjNzMzRGb1hoZ1ovQThk?=
 =?utf-8?B?cklaeDg3Ujk1bUc1Zy9mZDhnaWx4MXdyek1EcktqQ05zTFl2amN3S2J1aC92?=
 =?utf-8?B?WEkvdzk3R295TTdCUVRwVXZ6bm1Pbm5qa0sxZkxrK3N2aHc0N1NiNGFsaUk1?=
 =?utf-8?B?T3hWN0owVkVQRmhER3IvcXFERG5PQUtPQnNFQjV4NnVjU0RGZXZ2cXJCUkxp?=
 =?utf-8?B?WlNBbzlEUmRZb1lib0wrVTI4QW91d2VyS1E0dVRTb2VwTlJ1VWVDSlZmZ1Av?=
 =?utf-8?B?T2tZNW1OT1VIMUcvZ3M1L0lUK3JyaU1Lb25EVXdTV0NhUzNaV0Nsbks3UXVn?=
 =?utf-8?B?L1ZGTkRlRWV1ckZPWU1wSWZqbHFjdHc2b3orZ3RqMlFzMVVVWm91a2cwanJE?=
 =?utf-8?Q?va/luBzBQAQ24kzBwZGmQ5no216/+XBFg3tzo3DbrqAa?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(3613699012);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djYyeXoxUzdjTTA1L1h4NmdiRmhFN296TFRaUkJtVDRYREhxTGdhV3ZpdXdV?=
 =?utf-8?B?TzV1SlEvNkw3R054YUFsNUFNRmRIZDNSa2NPc1dNc2h1dk9Sb1RPUWdRak5m?=
 =?utf-8?B?d2gxRFFPN1VPdlFNdVUxUEJtMHlqZWVWaGxGcXgwaGZZb3lITUozYjcxK3pR?=
 =?utf-8?B?RnBHbmU0YXZvY0h4YkxSK1c2amM4d1UzUklqYVVVdWN4dnFFdW9GMmhqQzVk?=
 =?utf-8?B?S1JRUXFmbHJ6dFVIODEzQ1BXcHlzS00vWnhpdUdIVlBMeFNOZjhTRENGWGQ4?=
 =?utf-8?B?cmF6SWdZNk0va0w4VG9CdnBRdDJBWTRDWjRLS2JYazFPMVlxSm1vZDB3SkpW?=
 =?utf-8?B?Vk1MWml3eG5jeWU1aTZIUU56WHVsMVlZdHhsUFFKODlaMkNWRk9TWGVwVVdR?=
 =?utf-8?B?R3JnN2h4ZEdYYXNEN1ZmcDFRc2V2YWtxR2Z4dDNqZWY2M3N5cDd5ekhpVCta?=
 =?utf-8?B?VWdWOFQwdm1xUWVNaXF4aDZ5bGZ4eHoreDJyRUk1RkczY0FkN1pGdnA0YnFi?=
 =?utf-8?B?MXZPa0FTNE9RTFlDbDJDWW5ocHZ6UzBiWThsYXhFNzdCZ3k5VjRMamFkbU1E?=
 =?utf-8?B?cVJ6MkVjWm9CTTNDeXFDMy9TeWZRUE5VcmppeVdjR2hIQjdLZ2FxNHlhbmFP?=
 =?utf-8?B?YTRVejIwdmp5Yjg4SFIwbmVZcnd1U3pTWW9sTDREalIxNVF6N25TSUp0bGtC?=
 =?utf-8?B?NGttaDFYU3dMb3NsaWhMR1BlV0RNODgwci9tMVpHdkZ2NElyMnJwQnMxMEtm?=
 =?utf-8?B?eFlKM1ZKaUZpQ0JHUGYzUG5JRG5qK2toa1dEOVJ4eThzT0svQW5BZUZiUTBX?=
 =?utf-8?B?VVJTWTlzakozU1dPMkxVTmIzZDIvUnBNaXp6YUpTMXJPMjhDK0NqTmhkNGlX?=
 =?utf-8?B?SG9TODZnbjExZlNJb0NpM05kRkJqbmNGQXpBWTJ5MmR1cXhQVEJzYzBlZ3ps?=
 =?utf-8?B?N05SdVdVaU1OWTVIRzg3S3BkZUp5YWxyTDV0RG9tWlRKQzQ1TU9jS3VOM3Nz?=
 =?utf-8?B?ZnNsY2ZJa250R1Z6SjhEWXQ5R3Q1M0VVem9lTUJTQkR1QXBDSTQvUVg4enJJ?=
 =?utf-8?B?ckJkZDNqMWozOStEM2g4cUZiVmRYY2ljb2x4eTB3RDVhTHp1Y0QvTDNPeTlQ?=
 =?utf-8?B?WnFUdTdQUUpleHJKajVNWmRXQWZOUFN0VW5ja1BOTXQ2SjNqZy9RRURwUU1I?=
 =?utf-8?B?MFRodGJ3WWI5OWJpZC80M1FYaTlySGgyTVpzZWZTUjROaUtjWkNuMm8rUXFh?=
 =?utf-8?B?WHQxQWpaU3UxMHFjUnNqY2JTUGRsSUsxdmRWV25xTkJEN0FsRXArOFhoblVB?=
 =?utf-8?B?TXVzeHNOVzJEYXdSRkkrS2lSaGpSTytUb2lya0hJSldxTDVYTDBNUlNZcVps?=
 =?utf-8?B?OE5OQWE0dE44Qjd2V0F4ZFV5a1k1NWM5b2Z3NVFtVlZvUWMzK0tXaWFmRW15?=
 =?utf-8?B?bkxpRzJkajFuZW5kb0t1SEdzRkgrWXZaaEp6MnRhRjljYk5FN2tuTlpBbG1r?=
 =?utf-8?B?YkhVVnlUNkxDdlhtL0pMYXd1T3YxYVN2SGpaMkVwRVA1L055NWFyVHBHYjZi?=
 =?utf-8?B?YTRiMFlYWnNiSUJZMUtWT256UzBlVFpBNzdTM0VrTFZ5M1FLckp1ZUdZZmVl?=
 =?utf-8?B?blNNQ3JSNVFOOXZUTDNRM0grUVk4T2h4NEVZdkVMbXdveVFqbDlHWmxUZ3E0?=
 =?utf-8?B?SVRSaUo4NHVZemhFaHB4K1Fic2gxcWdCNmJ3RG8rWnVHbFVNb3pOZFVqQ3JP?=
 =?utf-8?B?RGo3Vk1yMkdBZGJsYXNNRDI1UEFiUTRBelFhUXU5RXArZ0d2Y01PK0E3RjNs?=
 =?utf-8?B?UlBOZERNN2NGNitMUzFoV0JCZUswOXJaWDZERHJEdkpwK2RXQnpnS1lKMFRz?=
 =?utf-8?B?NW9TMDRpYmVGSGZKZkVia0dLcTFHSVlpQ1lRenY4R3VSTUpzSzJUT1BsRXBX?=
 =?utf-8?B?OVBKS1NFVDFybWxvQ2FKVmdSbk0rS2NucXZxSUs0VDhGQXZGOXVaMnRlRmNT?=
 =?utf-8?B?bUNidnFYQ1FnNXVzWTRpekFsU1VNOFBnTEZHOHhGSlUwK2Z1MzladnZMYlc3?=
 =?utf-8?B?Q0wybjJEYkxHRFdIUy8rMnhOdllhUldpTkwyeEtKRGZwaDBjT0ZiQnJJbHZS?=
 =?utf-8?B?UDQrMlFYM1FlMUlPV21SRGxuSVNoS0Y0cURKdHJCdGYxTUlVYVlKNmhnNkl6?=
 =?utf-8?B?RitoNDRVVDQvbi9xc2FwTDhwakRHc0FQbnhmQWZVZW4rMW5qbjdsWXk5TE9U?=
 =?utf-8?B?YS9BOFZsRHFrTzF6c2VERUs2R1dVK2c0TmNXVnpPUWZGUnpVT2ZtcmVuUVYy?=
 =?utf-8?B?ZnJqMDhTOG1nZ1ZyTC9BV0J0ZzM3QWxWclR1QjFIamxSVVZ6UFhuQks1NnZw?=
 =?utf-8?Q?7hPqi7WiaDsCiLTY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91E2A7F33442E94FBE6B68E4BA5FA4B1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b37e35-d632-4612-e949-08de6a0fab12
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 08:21:05.9987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HuIE/XF1/dPujtE+aPjkAmbfShAAM/6MuBWD0AcWo8DhdPv4E+1ArmA9cyyXEdb2I9KcgaY6TwHdl4cPK78J/KthN/OlyM3iIC7lVZ8nQeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8129
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

T24gV2VkLCAyMDI2LTAyLTExIGF0IDEyOjA2ICswMTAwLCBNYXJlayBWYXN1dCB3cm90ZToNCj4g
DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+IA0KPiANCj4gT24gMi8xMS8yNiAxMTo0MCBBTSwgTWFjcGF1bCBMaW4gd3JvdGU6
DQo+ID4gQWRqdXN0IHRoZSBkYXRhIGxlbmd0aCBvZiB0aGUgU0NTSSBpbnF1aXJ5IGNvbW1hbmQg
dG8gYWNjb21tb2RhdGUNCj4gPiB2YXJpb3VzDQo+ID4gVUZTIGRldmljZSB2ZW5kb3JzLiBUaGlz
IHByZXZlbnRzIFNDU0kgZGV0ZWN0aW9uIGZhaWx1cmVzIG9uDQo+ID4gTG9uZ3N5cyBVRlMNCj4g
PiBkZXZpY2VzLiBWZXJpZmllZCB3aXRoIEh5bml4LCBTRCwgYW5kIExvbmdzeXMgVUZTIGRldmlj
ZXMuDQo+IENhbiB0aGlzIGJlIHF1aXJrZWQgdXNpbmcgc29tZSB2ZW5kb3IvZGV2aWNlIElEIG1h
dGNoICwgc28gb25seSB0aGUNCj4gcHJvYmxlbWF0aWMgZGV2aWNlcyBzdWZmZXIgdGhlIGNvbnNl
cXVlbmNlcyA/IFRoYW5rIHlvdQ0KDQpEdXJpbmcgdGhlIHBhdGNoIHJldmlld2luZyBsYXN0IHRp
bWUsIEVyaWMgKEhUIExpbikgY29tbWVudGVkDQp0aGUgbGVuZ3RoIG9mIDUxMiBieXRlcyBpcyBu
b3QgZm9sbG93IHRoZSBzcGVjaWZpY2F0aW9uIG9mIFVGUyBzdG9yYWdlOw0KaXQgc2hvdWxkIGJl
IDM2IGJ5dGVzLiBTbyB0aGVzZSBhcmUgbm90IHByb2JsZW1hdGljIGRldmljZXMgYWN0dWFsbHku
DQpIb3dldmVyLCBJJ20gd29uZGVyaW5nIGhvdyB0aGUgcGFyYW1ldGVyIHNob3VsZCBhcHBseSB0
byB0aGUNCnRyYWRpdGlvbmFsIFNDU0kgZGV2aWNlcyBsaWtlIGhhcmRkcml2ZSAgb3IgVVNCIGRp
c2suDQoNCkknbGwgZG91YmxlIGNoZWNrIGl0IHdpdGggRXJpYyB0aGVuIHVwZGF0ZSBuZXcgcGF0
Y2ggYXJvdW5kIHRoZSBlbmQgb2YNCkZlYnJ1YXJ5Lg0KDQpUaGFua3MhDQpNYWNwYXVsIExpbg0K
DQoNCg0K
