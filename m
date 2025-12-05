Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCACD2F7D1
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 11:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 198858367F;
	Fri,  5 Dec 2025 12:02:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="nO9f8+yf";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="AN6pVl3x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBE98838A0; Fri,  5 Dec 2025 12:02:48 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EDA682BF2
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 12:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: e7eeeeded1c911f0b2bf0b349165d6e0-20251205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=uicgf/gd265GiOScsK8TLR6gmjKuSZz6H2Th6GnT2+M=; 
 b=nO9f8+yflPNUeYT20R0bnXiSmPcmGxpYRnanxVBUyS4+XkZpISm+lhAREFOcenVqLSHntempV4Nz4uNeg481mXQVt5MJAHFd8jxQWgMU06heKNZWhDwFvTjaVmW/EkFAtbkoIKE7YcyrR/9rgBIqc0K6ZRZPNbNyLXshZIY5XBc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6, REQID:3acbdbc8-6f97-4662-a995-fd4c27d51e1f, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:a9d874c, CLOUDID:91cbacb2-13de-4936-a6df-52eb9b61d285,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil
 ,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e7eeeeded1c911f0b2bf0b349165d6e0-20251205
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 36621911; Fri, 05 Dec 2025 19:02:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 5 Dec 2025 19:02:34 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 5 Dec 2025 19:02:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhtjXtWRLPc7UxJ4MiUdvH3XVhq2V36+fRb4i7SgK3T3IrbVS/CrMqAWH2UubcfB8i077useMOodgIMNK2bwwT4nC3zewiGZO+ybCaQMOIblzzgCsefd9LDsk6VDCnglYDJZ12rPPeKnTOBtX+3bigiG3YRSSBhbCPX0z3K13S9ueI8Uywd12L/9+Wi/YYQMMuSJXr6yRE58p3+NJcptr/LlEDsF4NYsbC8XP4aYK2xjl2kQZaRNekfTKyTHub9RYBzQqp24lNI5l41OYgspiJOpcPQwgfzASF9+sD105eC/eBAJczS/eBj+1DuuudU0Tb6zpxSTs9IGtDeS0hUZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wT8SdTMgcSVoIKSW4yUI74d2zFdJ5TdWiB0eiuMs/as=;
 b=a/e+oNmxYleGd9vAUZkhS74+nLSLygwufNIDqIaEadVtd56o90e1QbI9KCCdq/8XnBUdf1lzTZqanDVZXceauDQX59Adv5ejXzupgxBA+lMg1WXXbTjZTOXud5d8K6wW/P26KGiS+KvywNz68UBeKzxCI9d8tmydAgGNHZY9UrPRF+xsc22A+WC4sROkFCXLWO2eennQDNgynp9VqPrF/lqvOqWdyyZVAh8+AFhEw5BqvWfFIx8D2fVdZnAtY75fVYEFKpsXb4+fqkvAQ9subiSvf9auoCFmVroERc97Zzbbaz4WaYbCeFl7T+q1QNzOGQTiKEy4c0n64CDdw1PvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wT8SdTMgcSVoIKSW4yUI74d2zFdJ5TdWiB0eiuMs/as=;
 b=AN6pVl3x187+/V8PcADGWaRRLZ4P4ljgaccyUM8EvVY/+j2/svi0tyf7I61Cl3fuPe6FUCm/OVDk7ChpIOm9IhQLpFZjK6QfPkHJTzruVVMFxZ+rzyuIQ1Ov5NIBOLXRF4O9nAdmZIFcQt5qdls40Ep9E/3NgOCfwvKPGgQoMMk=
Received: from JH0PR03MB7806.apcprd03.prod.outlook.com (2603:1096:990:2c::12)
 by TY0PR03MB6449.apcprd03.prod.outlook.com (2603:1096:400:1ae::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 11:02:30 +0000
Received: from JH0PR03MB7806.apcprd03.prod.outlook.com
 ([fe80::d42b:4391:f865:71fb]) by JH0PR03MB7806.apcprd03.prod.outlook.com
 ([fe80::d42b:4391:f865:71fb%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 11:02:30 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?= <Chris-qj.Chen@mediatek.com>
CC: "mkorpershoek@kernel.org" <mkorpershoek@kernel.org>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "stefan.roese@mailbox.org" <stefan.roese@mailbox.org>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, "alif.zakuan.yuslaimi@altera.com"
 <alif.zakuan.yuslaimi@altera.com>, Julien Masson <jmasson@baylibre.com>,
 "nathan.morrison@timesys.com" <nathan.morrison@timesys.com>,
 "sumit.garg@kernel.org" <sumit.garg@kernel.org>,
 "vasileios.bimpikas@analog.com" <vasileios.bimpikas@analog.com>,
 "lukma@denx.de" <lukma@denx.de>, "kory.maincent@bootlin.com"
 <kory.maincent@bootlin.com>, "utsav.agarwal@analog.com"
 <utsav.agarwal@analog.com>, "ziyao@disroot.org" <ziyao@disroot.org>,
 =?utf-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?= <Sam.Shih@mediatek.com>,
 "Oliver.Gaskell@analog.com" <Oliver.Gaskell@analog.com>, "seanga2@gmail.com"
 <seanga2@gmail.com>, David Lechner <dlechner@baylibre.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "jerome.forissier@linaro.org"
 <jerome.forissier@linaro.org>, "arturs.artamonovs@analog.com"
 <arturs.artamonovs@analog.com>, "malysagreg@gmail.com" <malysagreg@gmail.com>
Subject: Re: [PATCH 1/2] arm: mediatek: add support for MediaTek MT8188 SoC
Thread-Topic: [PATCH 1/2] arm: mediatek: add support for MediaTek MT8188 SoC
Thread-Index: AQHcZGOxzz51nEZvL0WyoHInDGYZ07US4dYAgAACrAA=
Date: Fri, 5 Dec 2025 11:02:29 +0000
Message-ID: <a97aace29f126269401ef25e5d3e47d266cce22c.camel@mediatek.com>
References: <20251203-add-mt8188-support-v1-0-9a06ebb97734@baylibre.com>
 <20251203-add-mt8188-support-v1-1-9a06ebb97734@baylibre.com>
 <2130bf1ebe2e3684a3d1c7341249ce2ca524d0bb.camel@mediatek.com>
In-Reply-To: <2130bf1ebe2e3684a3d1c7341249ce2ca524d0bb.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7806:EE_|TY0PR03MB6449:EE_
x-ms-office365-filtering-correlation-id: fc416d5b-c391-4016-dc1b-08de33edc8af
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?QkZNZDd2R24zNHM4L3U3L3kxOFIzK1c2VHVBR3d5aG02eVpqU09IZTZjL1Nw?=
 =?utf-8?B?L1JZMmVXelZYcGlKd0J0ajZtcks5MkNQVGo4RjVkbnBEcWFPVWRLa1gvejJl?=
 =?utf-8?B?M1JtVkpNeS9QcWVNUWJlNFZOSDBKK3hrQ0pFRFh0aTFtaVNYdnh1aE1vMGRF?=
 =?utf-8?B?OXhpNlI4eXVzYlhscHNUNlhlcEhxS0M3UFVWTTBnWFZqaW93S2g2eGxheG9o?=
 =?utf-8?B?VzdhRVQ4bTlRNGRFVXRjYWQ4MnBpMDFJMUpjclZBdXpqM2xvWlZKRVgxd1ls?=
 =?utf-8?B?NVBJdnFreGJSOUh0eG5BL2E1TllzMUM2b0hDOC9xbUpUbEFDbDZMNVpjanN5?=
 =?utf-8?B?dFROdWxFVUtVMGxOTWpWT3VuUmM1SnhZRXI0SVZKQWl1K0RkS2thOGZwN2wv?=
 =?utf-8?B?TWQvQXpTUVZjYXhFRTdBREdKaW4yaS9QWXRKc3VwbWlCdWdRVk9Welo3a2U4?=
 =?utf-8?B?Z0trbk03dVZlSDVzRUtPWS9oWWREbFlyeWdNVnNudVFHcTJhWGp3OTVsa3Zo?=
 =?utf-8?B?cnlxZnFkVDZFaCtDckxpWFYrZk9BallWbzZWaHJUMTNPSnBHd0tod2tDYms0?=
 =?utf-8?B?Tk9zc1VyZi9tRlBlcmRWSEdCc0tCMmthMC9EMzNQWFNodU5SZktOV0hJU0N2?=
 =?utf-8?B?U1ZZemUwR0RxajBpSExWUVNndS8rc214NDBiRUFPOTRrNVcyS3MvcFhGSE4y?=
 =?utf-8?B?QWNqdjkzK3paN0hnQUJvdm1wK1dwMnFnRllpOXRodXVmMFJiaWVIamJYdTJU?=
 =?utf-8?B?UnlVS3lJWkNsdDRzMWV0S3gvNHNsWmJ0SDZrTTFOeU44WFdWNUJtWU9vQzFD?=
 =?utf-8?B?NUQyTndndVM0UGhvMmNWdGc5N1RNVDBuWVdVOUZISWlWWkpHUk56R0ROa1l6?=
 =?utf-8?B?Rlhta3dBRnNnMDdrTmV4NXJoT2lEZ1FxUEJvRkhvSFFhWTJ1UXluT0JoRTRq?=
 =?utf-8?B?Z2c4cmp2Ti9zVXZ0TmZHK1FBNkJOM0lBbE5ySG9wSUhrWTJKc1VMRmNoR1Mv?=
 =?utf-8?B?b2RaUWlJWisxYWs2Z2VETFJyd1VTcHNTbHpHMkVvVXlUd2czSFprZjZjNUYy?=
 =?utf-8?B?TWhRZDJGMUdxai9ETE5WaHZ3c3d4Yk1VU0JmKzE2N1hBRnQ3R3ZhTnVsUzBr?=
 =?utf-8?B?RUZaWEhBQ0dmVkY2SkhiMVk2Qy9EaHNLY1ZlQXVqamMrKzJWMmhTMjBPMkJi?=
 =?utf-8?B?Z0pFSHRGOUtiT3V0UmtubnhhSlVrY2RBSDJWdWNhOG96R0hiMk0vNURveGxY?=
 =?utf-8?B?aE9xS3NjaS9BdHVzemFlWEtjbzhHWWx1N0cxdVpiTGtVaXlHVUNLcCtTcFdo?=
 =?utf-8?B?R09CY0xtakorZkRRdC8zWTlqQ3pJZ0ZDNHRDeTBzQitjb2dMUWRyWkxvOUR1?=
 =?utf-8?B?cG5VK1puVWR0cWdNR0xFOTR1M1dmdUR3amNWaEtLY1dJb2JaOVovSXduV1VV?=
 =?utf-8?B?aFNUMk5KaWxoVm12Nkdlckx1dk5OcC84NHpTMTBGQ1k5ckQyK1BUeXB5S2p6?=
 =?utf-8?B?blU1RFpxVkllYnBodVQvaFIvNS9iR0k0YkRjU1BlaHBRSGhqY20zODcxaXQz?=
 =?utf-8?B?K3hPN3RzMTNTMnR5VXlIenpSanZsSXVRUTU4bG5pTHdGWElvclBIaVViU2Z2?=
 =?utf-8?B?OXkvNXBMOE5DT2NVN3ZCRlJ4ZXdBdUErNSsvWmptZmo5MllBRlYvQlBjUFQr?=
 =?utf-8?B?OVR6Vjh2T2E5SGppdFNpU2dZTFVod3MzTXMrbFJNTkFVaE9jeWp2ZzBYRlhu?=
 =?utf-8?B?YTlEV1hWcEl5UjlCblJaM3BzSmJmem5ZdDd2OVQxS3NUeE4xSXM0eXkwbnhx?=
 =?utf-8?B?MUt6b3p1TFVlVXhVRGNtbXZDUXVMYUIzZFE5V2E1dW00ZUl1Z1IvV3BoQ1Fr?=
 =?utf-8?B?ZmVpVWlIck0vcVg1QkpNVUcrSUl1eXVBMFRNcXBYbGo4Q0h1eXVkbDJ1N3RN?=
 =?utf-8?B?eEVJeDQ4dTVUeURaTk1YUXRybDQrYi9yangvN09vNW8wUjI5SEFhTGpNSFdR?=
 =?utf-8?B?cmJ2OERxRjNPRnVSbktLaEJWYWp1L2NjT0MybmMvdDlpYjJPYS9QNTRsVHRO?=
 =?utf-8?B?NERWNHA2K0E2blVJYzFPcjFNbEo4TTFSU2Z5M2VDbnpOMlpoV3ZiTkpJVitv?=
 =?utf-8?Q?JXHc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:JH0PR03MB7806.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUpXVHJmbkx0TldZWC9ndWk2Tk5IMGN0TE1WeG5pRElDNDY5cFNiR0hpQzNM?=
 =?utf-8?B?TEIvQUJLeTg0OFVPU3BuR0RoSWMrNFI0NmpxQmtEOURNRFozLzVXdWxjQ1Y5?=
 =?utf-8?B?aStpK2NjT0V6TkNHcGx3MWZldVJyanFkdUttZkNYc2p3SFBvYm1rUFJrando?=
 =?utf-8?B?OGxIejhHbDlSR1IyVWV4L2hHWU9uTkhBN21XZjVwK2pRUGN3Vk1qRWJzdEFG?=
 =?utf-8?B?cncwRWlKZTFUajkvYUEyZE95clVnU0RBOEgrUlBmN3V0Q0I2V0JNRitoZlNF?=
 =?utf-8?B?N1N2WTdjV2tsQStxTHYycWg4WC90eWo4YUV2eVFRakFYYXloa0FlMmt0NTNM?=
 =?utf-8?B?USt6WThwQjlnbmpyMEgzenZ5dy9uOVVwUW1EMCsxQ1pkZ1QxbTZkMnA3Q09w?=
 =?utf-8?B?L2FSa3ZsanNxUy9lV0txSVRHc3NtSERGb1NzWklVVWZNUy8wZE41a1Q5M1hI?=
 =?utf-8?B?UXFZWmV6cU14SENCbHdhQ1BSK01XYzEwNU9aSTdIUTg2dVhxaEk3d0hNbzJj?=
 =?utf-8?B?WEVKVFh3UDdFdm9WZTJEVlAzbWp2YzNNcFpCQ2hSNWdIaHYrcG5hWnpSODFF?=
 =?utf-8?B?U3dBQVEweEYybTB3SHlzNE4rQUxoejNZb0o1Vmh2NW9hSjZQN2RTWElKUXlR?=
 =?utf-8?B?STYyQUF5WU5zSFQwWXgvZG1aU3F0LzdDSFI1L0JlbVZDdEFrVm55QnBYNVdW?=
 =?utf-8?B?YTdVNW55Q3RrTHZsV0tPOVZ1OUtaNU5ZWENlbDZYZU1LTHVCVHBtUjNqR210?=
 =?utf-8?B?SmtLWU1mdHRJTnRaMW9OTmVhSUN4N0dhY3AvU0xadjFjY21aOTJXQy9uSzZJ?=
 =?utf-8?B?NXV0d3JtVUIxeU5UcE5USWpFcC94bnp0elhSRkxjZDNlY25pcU1VM3hHRnpX?=
 =?utf-8?B?cE1aOFhkTEhZUmUyOVM2YXJlVlpnMEI5RHNTcjAvOWdTYmc5RDF0TSs5S2Rn?=
 =?utf-8?B?THNuRUhuZlBOTDhqcGhRaUtRb01Ld1lVc2JGVmc5NmVEMVJBTnc1eERPdmtP?=
 =?utf-8?B?VkY0WkxCUmpaWFNMVWtLNzB0cWZaMkxhcHJlTjM4NUZFeUpTbFEzd3Bra2oz?=
 =?utf-8?B?RnRUZVY1MkRnM3JsYTl3OVJSZk9TVVZUcXJ1NHh2aFJ2UXNnYTVWdVppSVRw?=
 =?utf-8?B?VitIdjdySllwaFZyQzRHaG12UFZuS0Q0TmJCY0V6eVIvM2UvS3lhQkc2WEtC?=
 =?utf-8?B?YUJsWEYzMkM2M09nR0RhbDNyajlPMjVjRlRWSlovK1ZieW1vUTh1MzR2L1ly?=
 =?utf-8?B?UWNqZEZobUhSNUJKbURPeU56b3dUQjZDT0E0N2RJRmIyZlkweGxwQlVDSWhI?=
 =?utf-8?B?MGFydThWbDNkSmpYUEY3bWRySjJ2QXpXaWpGdTF1UjZBbTdMbkV6L1hlSHBB?=
 =?utf-8?B?VXBFNUNWWU1aMEFRZFVPNlVGUmZuMVZEaHZEclluNm5HMDY4bndHRzlOeGR1?=
 =?utf-8?B?ZW5BdExPMUVraU9DdXk4WjdFVGVaNGR4aVh1Ry9CQnFwRjAvaU5NZEZxMS9o?=
 =?utf-8?B?Vk41eCtocUI5SlJsZjNKT2JnYXY3NktDb3NYQXNqb3hwRlNrSDNoOC9QZHhP?=
 =?utf-8?B?VkdveGpHVytseXgvcHRQSDNPNk1iYnZnWDFUeTJCQW9lMmc4Vmh5WDljbi9Z?=
 =?utf-8?B?T0NTQ003c3RsQ0xzSDlmSGJ4Q0RBamhEeW9Pbjh0dE52V2lHdWp4ZUVHdUpW?=
 =?utf-8?B?bTVVaTQ2OU1pdXh6SU1pT1FXdVpZYVVIU0lLeStVb05RbU5tS1NnUWxpTWdU?=
 =?utf-8?B?TGZ1enZwVHdOajY5Zlc4T3BiK2ppeUs4ZjV2dXUwSGxteGI1ZWRQTVFydlU5?=
 =?utf-8?B?QTUxL0xqNUlSNnh5VitzWlBiWXZOc040WWdicEVyaXlKN05pQzBzcnN4Z3dR?=
 =?utf-8?B?MC9BNGFaQU5hKzhJK1JQV0tZK2xHbEZuSnN0bGYvNEpiMDRHenNCcUhycCtR?=
 =?utf-8?B?NUNISmtWN1ZJSWxTRjRjRjVSSmpPbURFU095WTlXK1RGS2Vacm9PY0NqNENz?=
 =?utf-8?B?OHo5QmM5aS9lS25Uc1ZkRU52UHoydjA5VGdjRnBUNktOd1FIYkJqYzhaclhv?=
 =?utf-8?B?eVJJc2Jjem9sdzJablY5SXNOcE5GcXcwcHpwdFllM0RPRGl1V3NEUnR2VlNT?=
 =?utf-8?B?bGJnWFdCd0JWeTBqUWtNc1R4SXJFSHd2cWgvREI0WEZHaHNnMTRjK01XK0hG?=
 =?utf-8?B?bFE9PQ==?=
Content-ID: <56F0F5CB0DA72043B9240AB38AB3563D@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7806.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc416d5b-c391-4016-dc1b-08de33edc8af
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 11:02:29.9741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nsx1sDJzXQtzTL0jpxygqAvpN5zYWzH0BfjjuDdE9l4gvU6yvkIXKNcfRUJkaTgnCIbDVutkv7fGkhO+yztoBfMRz3qBT7JY5dFVdRi3MMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6449
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

T24gRnJpLCAyMDI1LTEyLTA1IGF0IDE4OjUyICswODAwLCBNYWNwYXVsIExpbiB3cm90ZToNCj4g
T24gV2VkLCAyMDI1LTEyLTAzIGF0IDEwOjMxICswMTAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gPiANCj4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cw0KPiA+IHVudGlsDQo+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNl
bmRlciBvciB0aGUgY29udGVudC4NCj4gPiANCj4gPiANCj4gPiBGcm9tOiBKdWxpZW4gTWFzc29u
IDxqbWFzc29uQGJheWxpYnJlLmNvbT4NCj4gPiANCj4gPiBUaGlzIGFkZHMgYmFzaWMgc3VwcG9y
dCBmb3IgTWVkaWFUZWsgTVQ4MTg4IFNvQy4NCj4gPiANCj4gPiBBZGQgd2F0Y2hkb2cgc3VwcG9y
dCBieSBhZGRpbmcgdXBzdHJlYW0gY29tcGF0aWJsZSBzdHJpbmcuDQo+ID4gDQo+ID4gQWRkIHRw
aHkgc3VwcG9ydCBieSBhZGRpbmcgIm1lZGlhdGVrLGdlbmVyaWMtdHBoeS12MiIgY29tcGF0aWJs
ZQ0KPiA+IHN0cmluZw0KPiA+IGluIGFyY2gvYXJtL2R0cy9tdDgxODgtdS1ib290LmR0c2kNCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKdWxpZW4gTWFzc29uIDxqbWFzc29uQGJheWxpYnJlLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKdWxpZW4gU3RlcGhhbiA8anN0ZXBoYW5AYmF5bGlicmUu
Y29tPg0KPiA+IC0tLQ0KPiA+IMKgTUFJTlRBSU5FUlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiA+IMKgYXJjaC9hcm0vZHRz
L210ODE4OC11LWJvb3QuZHRzacKgwqDCoMKgwqDCoMKgIHwgMTAgKysrKysNCj4gDQo+IFdoZXJl
IGlzIG10ODE4OC5kdHNpPw0KPiBXb3VsZCB5b3UgcGxlYXNlIHRvIGtlZXAgdGhlIG10ODE4OC5k
dHNpDQo+IGFuZCB0aGVuIGNyZWF0ZSB0aGUgc2VwZXJhdGUgbXQ4MTg4LXUtYm9vdC5kdHNpPw0K
PiBQbGVhc2UgcmVmZXIgdG8gb3RoZXIgcGxhdGZvcm1zIGxpa2UgbXQ3NjIyIG9yIG10Nzk4Miwg
ZXRjLg0KPiANCj4gPiDCoGFyY2gvYXJtL21hY2gtbWVkaWF0ZWsvS2NvbmZpZ8KgwqDCoMKgwqDC
oMKgwqAgfCAxMSArKysrKy0NCj4gPiDCoGFyY2gvYXJtL21hY2gtbWVkaWF0ZWsvTWFrZWZpbGXC
oMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+ID4gwqBhcmNoL2FybS9tYWNoLW1lZGlhdGVrL210ODE4
OC9NYWtlZmlsZSB8wqAgMyArKw0KPiA+IMKgYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9tdDgxODgv
aW5pdC5jwqDCoCB8IDY5DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+IMKgZHJpdmVycy93YXRjaGRvZy9tdGtfd2R0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDEgKw0KPiA+IMKgNyBmaWxlcyBjaGFuZ2VkLCA5NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMN
Cj4gPiBpbmRleA0KPiA+IGI0M2RhZTg4MmIzZWEzM2MyY2Q3NDViZDM3NTllM2Y0ZDk3YWJjODAu
LjViNTJkMmZlMTc1MDZkMjY1OWJlOTAxNmENCj4gPiA3Yw0KPiA+IGE2MzkwNjIzMzJhZTkgMTAw
NjQ0DQo+ID4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gPiArKysgYi9NQUlOVEFJTkVSUw0KPiA+IEBA
IC00MTUsNiArNDE1LDcgQEAgTTrCoCBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRl
ay5jb20+DQo+ID4gwqBNOsKgwqDCoMKgIElnb3IgQmVsd29uIDxpZ29yLmJlbHdvbkBtZW50YWxs
eXNhbmVtYWlubGluZXJzLm9yZz4NCj4gPiDCoFI6wqDCoMKgwqAgR1NTX01US19VYm9vdF91cHN0
cmVhbQ0KPiA+IDxHU1NfTVRLX1Vib290X3Vwc3RyZWFtQG1lZGlhdGVrLmNvbT4NCj4gPiDCoFM6
wqDCoMKgwqAgTWFpbnRhaW5lZA0KPiA+ICtGOsKgwqDCoMKgIGFyY2gvYXJtL2R0cy9tdCoNCj4g
PiDCoEY6wqDCoMKgwqAgYXJjaC9hcm0vbWFjaC1tZWRpYXRlay8NCj4gPiDCoEY6wqDCoMKgwqAg
YXJjaC9hcm0vaW5jbHVkZS9hc20vYXJjaC1tZWRpYXRlay8NCj4gPiDCoEY6wqDCoMKgwqAgYm9h
cmQvbWVkaWF0ZWsvDQo+ID4gDQo+ID4gDQo+ID4gW3NuaXBdDQo+IA0KPiBUaGFua3MgZm9yIGhl
bHBpbmcgdXBzdHJlYW0gdGhlc2UgU09DIHRvIHUtYm9vdCB1cHN0cmVhbS4NCj4gSG93ZXZlciwg
SSd2ZSBmb3VuZCBpdCBzZWVtcyBsb3RzIG9mIGZvcm1hdHRpbmcgaXNzdWVzIChlcnJvcnMNCj4g
YW5kIHdhcm5pbmdzKSBpbiBjb2Rpbmcgc3R5bGUgd2hlbiBJIHJhbiBjaGVja3BhdGNoIHRocm91
Z2gNCj4gdGhlc2UgcGF0Y2hlcy4gDQo+IA0KPiBQbGVhc2UgaGVscCB0byBmaXggdGhlbSBhcyBj
b3VsZCBhcyBwb3NzaWJsZS4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0cy9tdDgx
ODgtdS1ib290LmR0c2kgYi9hcmNoL2FybS9kdHMvbXQ4MTg4LQ0KPiA+IHUtDQo+ID4gYm9vdC5k
dHNpDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleA0KPiA+IDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAuLjZkMWIyYWI4MmRhMWM5NWE0OWI4YTY5M2UN
Cj4gPiBiMA0KPiA+IGY4NTRhYjkxM2EyNmINCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIv
YXJjaC9hcm0vZHRzL210ODE4OC11LWJvb3QuZHRzaQ0KPiANCj4gW3NuaXBdDQo+IA0KPiANCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9tdDgxODgvaW5pdC5jIGIvYXJj
aC9hcm0vbWFjaC0NCj4gPiBtZWRpYXRlay9tdDgxODgvaW5pdC5jDQo+ID4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4gPiBpbmRleA0KPiA+IDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAuLjMzODljMDNiMDYwMDZlODEzMGI0Y2U0NDgNCj4gPiBkNQ0KPiA+IGRjZmI4ZjEw
M2MyOGYNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJjaC9hcm0vbWFjaC1tZWRpYXRl
ay9tdDgxODgvaW5pdC5jDQo+ID4gQEAgLTAsMCArMSw2OSBAQA0KPiA+ICsvLyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIw
MjUgTWVkaWFUZWsgSW5jLg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjUgQmF5TGlicmUsIFNB
Uw0KPiA+ICsgKiBBdXRob3I6IEp1bGllbiBNYXNzb24gPGptYXNzb25AYmF5bGlicmUuY29tPg0K
PiA+ICsgKi8NCj4gDQo+IA0KPiBXb3VsZCB5b3UgcGxlYXNlIGhlbHAgdG8ga2VlcCB0aGUgb3Jp
Z2luIGF1dGhvciBoZXJlIHRvZ2V0aGVyIHdpdGgNCj4geW91Pw0KPiBTaW5jZSB0aGlzIGZpbGUg
c2hvdWxkIGNvbWUgZnJvbSANCj4gDQo+IA0KPiBodHRwczovL2dpdGxhYi5jb20vbWVkaWF0ZWsv
YWlvdC9ic3AvdS1ib290Ly0vYmxvYi9tdGstdjIwMjIuMTAvYXJjaC9hcm0vbWFjaC1tZWRpYXRl
ay9tdDgxODgvaW5pdC5jP3JlZl90eXBlPWhlYWRzDQo+IEF1dGhvcjogQ2hyaXMtUUogQ2hlbiA8
Y2hyaXMtcWouY2hlbkBtZWRpYXRlay5jb20+DQo+IA0KPiBBbmQgcGxlYXNlIGhlbHAgdG8gZG8g
aXQgc28gd2hlbiB5b3UgYWRkaW5nIGJhY2sgbXQ4MTg4LmR0c2kuDQo+IA0KDQpPaC4gSSd2ZSBm
b3VuZCB0aGlzIHBhdGNoIHNlZW0gY29tZXMgZnJvbSB0aGlzIHZlcnNpb24uDQpodHRwczovL2dp
dGxhYi5jb20vbWVkaWF0ZWsvYWlvdC9ic3AvdS1ib290Ly0vYmxvYi9tdGstdjIwMjQuMTAvYXJj
aC9hcm0vbWFjaC1tZWRpYXRlay9tdDgxODgvaW5pdC5jP3JlZl90eXBlPWhlYWRzDQoNCkknbSBu
b3Qgc3VyZSBpZiBpdCBtaWdodCBiZSBkZXJpdmVkIGZyb20gdGhlIG10ay12MjAyMi4xMCBicmFu
Y2g/DQpJZiB5b3UgY291bGQgYWRkIENocmlzLVFKIENoZW4gd2l0aCB5b3VyIGRlcml2ZWQgd29y
ayB0b2dldGhlciB0aGF0DQp3aWxsIGJlIGdyZWF0ZnVsLiBUaGFua3MuDQoNCj4gVGhhbmtzIQ0K
PiBNYWNwYXVsIExpbg0KPiANCkJSDQpNYWNwYXVsIExpbg0K
