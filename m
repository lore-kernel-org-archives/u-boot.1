Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9C7CCA476
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC5F783B07;
	Sat, 11 Oct 2025 20:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cvRO+TuW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FBE083E11; Sat, 11 Oct 2025 11:14:25 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DC9083C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rq78/9Y0P1OMtOgWopTeGEy8P5uCDzlGb264oGDCLnL0mux+7CHI9+TYiXXFZAUNY/4VIJBi92LTc6RmHue9xIt9g1Rfsg/CLuNvXWL75BWwTD6K2qqk2kbwmMPt+gbAQ5GUtlfsMqhk20NPtxUewQgWrtuHjwGGww57+jfnnTD8+kxfF5374lZ7A4eIx0rPRNeFa2SyHA3VBRgM+B8Ed6pgfVMhDmHdcED0KIVrSCDO5X7LQxPHic6JyfYnNMA4oWkN4VuvLiSJcEASiBVcebTo13qsJELygAljkIk3/KBTd3zCorRnlrFaOYi5y4YGQmrDuvoGiwUkiTsHTRyXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N23uWZeV2LThteEM7EcSE7zvhh0/3QCMqf1cKbx4KYY=;
 b=ODCypEeOnJ5NIZlrg8McIS1p7eCIlyn8dHaQ6I+gGm1mLHtHUiihn7bLuLxo3wALVq9ei7Nd/lIgABs8uBpW8CqdQEi+De8fBlevsWWhpK32ky7UIlFvP9kq3clsmBOOUn9PK1ebPa7pbImuXzKqKdva9Tzf2snPdjqKtf1v3VWxG1KRGcDBo7gABpAyTEf8ziksVf0VHddenCqnzep14kZgLgB9iQL6iW9Bqb4KzrRfTPgspaPwosfL/VFKL0aG/iCkRlHMPnXH3icSj6MBckSV41GLGYz/cxfrhEgiYleecfdyYhdD2PiwJVObKjkQVs4xKTmL/79WI3eg8rP2xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N23uWZeV2LThteEM7EcSE7zvhh0/3QCMqf1cKbx4KYY=;
 b=cvRO+TuWWR/1oqZnEXEGOKvOCFQ4Juf2shJX3ak5ngIs/t0jzdwZrI+gTrPKBmysSfrXPvdlWzJi2vetE0mW0FTjOgNBlGYrtUSfLR7tnaUp6gZgc3BJSxeRhiIH9oiOuNIGh0I3MNF8mWXOaYKT34M3BDGllHSZ6jAvHNyhaAcp2c5SbnTdzJkQfStcXI2O9ijmg6E4guRFME8pNAXMTgLQDqlGimYBftmAsuJIKhHqmi6UwhRX2QqWpGvdmH4gSv+wbKRLWX5mm269vIcb5mpa/tegtzNcQGU+RDEIUJk4QkuiDSk/oM6dNfkQgZkbFom5ePqFcPmVGjm9F+atNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7129.eurprd04.prod.outlook.com (2603:10a6:10:127::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 09:14:21 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:14:21 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 11 Oct 2025 17:12:54 +0800
Subject: [PATCH v2 06/10] phy: imx8mq-usb: Add SPL support for i.MX8MQ,
 i.MX8MP, i.MX95, and i.MX94 USB3.0 PHY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-imx943-v1-6-072b9ede2b4e@oss.nxp.com>
References: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
In-Reply-To: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 marek.vasut@mailbox.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 32143137-56bb-4be0-de88-08de08a6903a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rkp6b1B4dkdUNGF2YlRFRXpLbGwrUzZadEVIcmZsTkcrQ3BLYkM3TFJVRWQ5?=
 =?utf-8?B?Tm9JK1RjRmxvWWNSN0tZY3J3OTZZaU1rUTl1QWFMNkxjOFgwdWZIWWNBQmEz?=
 =?utf-8?B?N094Q0toT1A1U0I5MzZ3UmR4TFdKYjVqRjNTRXdoQkMxS3BOeFh4cWw4d3M3?=
 =?utf-8?B?QThzRENxaE15M0RMcU8xb2owMWcyZzQyanYwelJBQ3pRWFJEbXIxby9LMEk3?=
 =?utf-8?B?VzdZdHpkVGx2a2wwRVEyMVoxeWlmdGpPMGtkNjBtTEpXUXpzV1pMcHdkdVhr?=
 =?utf-8?B?K1dTdUgxUXJGaGhCMXlscnhCb3U3YzFnU21NaG1PM2o5UDd5SnAxVFFxQi8r?=
 =?utf-8?B?OVlWZnUzZFR4K0ozRGVEK2duczJITWpVcUFQT2RocS9EYm1weEFkZi80elJM?=
 =?utf-8?B?NUxRUWh3V3VnRjVrR1pwMHNFUmlBV1ZwMWQvYXMzOEM5dFVuMHZ2NzBtSGRr?=
 =?utf-8?B?dXhKc2JrQms4MWx0UGVUWGwxNG9NMDJuZVRDMlpGSHNkcVgxK2EvQlVqMHlJ?=
 =?utf-8?B?YUZDQ3F5NkJXTXY2aTNhM1FQSFlLVGE1NGRSSXQzNTRVRmt1VzVrellMNXFS?=
 =?utf-8?B?YjF5TVd2UzNHOGpsQ3JhM3lWdnlSZkN5MkN3MmdidW1kbGxYUXpkRHg3eFZa?=
 =?utf-8?B?UTEyOUxhdnYwY3NFS2FlZkludXJmU3lMbDFjc3hJNlJuYzM3c1lCWWN5eTVX?=
 =?utf-8?B?YmtORHVBM05tNmdORkZmeUpqQVY4S0VUdUtXK3dBZWwvcThGODA3WWo2VXR6?=
 =?utf-8?B?eFFaOW5lL3hZS1kzM3VKMkdjYzUyd0lvVUl4WVJxcnBOV0xCREJIa1pMR3Nh?=
 =?utf-8?B?UGJySCsvNHNMWjNud3BwVCtwbmxnbWV4UVF5b1JacjV2V2JYREtMS2x1MTAz?=
 =?utf-8?B?YmpDMWNxRko5UEREL0F0ZTAxZ0F0TlpGUEdnZkFjTlpYSWJmS1VjT3NkMlJy?=
 =?utf-8?B?M01PNSs1eWpKc2lmald0b0lpUHFzam51MElJdkRHRnc3UWtYM1F1d0RCVmhu?=
 =?utf-8?B?V0orRi8yUEVnZEUzMTBjT2FVOURSeDVoM2J5Q0tiZWNzQm9RYUdsYUxLYnZY?=
 =?utf-8?B?WTkzdWludEtIM1dWQzIrdUJJMHg2Q0JzTW8wWTAvdjlzMmtmYnlWNk4yV29M?=
 =?utf-8?B?SW8vdWZzeDh4YitLMEw4aHZJb3RVV0IrRGRSSytETVhOclFFVkxGNm8yNFNj?=
 =?utf-8?B?NDlpNkVWVFFGTmtEK2ppSHVrMlBQRVdBR0ttWk9Xb1dYdjZ6VGdaWnhkSll3?=
 =?utf-8?B?QzVEbnVCRUEvSURPOWtyek54YUVyTmc4aElZSWpSK05qS1BFY0JwUGpWdDM3?=
 =?utf-8?B?MmV2a0tqSlhUbjRFNDd2aEVsRnVGMk5MNmRiM0orT2Y4QUhaR1NPL01Hb3NV?=
 =?utf-8?B?UFpzRDAza3pab05Wa0QydHFuTkZnMEtjR1JWSFFMZnduektkYlBkRE9UWlRI?=
 =?utf-8?B?RnlndjVmUWhlakY3bkZKcGNzWWFwaS90RzUxdGZKWS9Udzk4Q0M3RHZXcEdq?=
 =?utf-8?B?MURXS2tnWUIwQU5BWXg1TGw3NXB4emhMT3prU3NhWGJaS3hHTTFCWndocEVl?=
 =?utf-8?B?NEFTRkJHMzhxdDljVnJHZ21IS01MY3JVUTYxT280NlVQNjYxS1c3eDYvYVRU?=
 =?utf-8?B?eHZVSEJmd2orNGNCd0ZJaGI3OFRNSWxHcHhGUnpxbFZNR25UUkZvUHBlUWE2?=
 =?utf-8?B?WEw1UlM1S3p3eStEK1I1Y0tWelhVd2ZnOEdkZVM5ckZRVEhGb2habGlkVFpv?=
 =?utf-8?B?SEFSYTJoeGdRSzdrZzkzSTFXcFM2c1BpVVQvTkZ6MGsvUWJ4MXZuaHQ5c0Z1?=
 =?utf-8?B?dlAxZXJEa0k4N09QY0ZhWGRCWGdIbFJqcUJlSElMYnBKUFNNMVdva2pJaWpu?=
 =?utf-8?B?dnM5Q1haSkI4a01Qa0FvbCtuRXRIenpYQmVLaDNXSHQ5UGRTKzd4bjdmWWg3?=
 =?utf-8?B?M0VsYm5HbitlVUkveVpCdm9LUjRZRWxpeEdvcE1EWkVqM2V2UWhKS3orYkRk?=
 =?utf-8?B?S2ZxeTQzRmptbjlTWUZvaWc4cHpVUytBd1UwNDJFcUF5L2hmNHpVMjNVVGFj?=
 =?utf-8?Q?tsrBuG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnhMaW1sM1g4T0VDRE1LL2lpSzF2Tm5tcHNJd0xSK2JBSVczUTdDVXhDMWtS?=
 =?utf-8?B?WWVNRDNXZm9lT0ZvQk85WFB1dG1sODl4TzU0TE8zdHF0aFdOb3BOYXNNQ3Jo?=
 =?utf-8?B?eGV5V1JvTnBCcVVUN2pkQm55MDNqenVRRTNLaU1idVlZZldtMFdIN2FFTGVR?=
 =?utf-8?B?TDI1YlVKSXRIbkpLdjBJaUJhUXdnQ25TZkFkdGsvOCtYdXhpS2F2LzZWQW5R?=
 =?utf-8?B?UnIvMFhIQWtaQ2MxeGQ0aCsrbGtxd3R2Q3V6Qm9tVHhsUGNEaUVkQTlGNkVW?=
 =?utf-8?B?blFHNnpwY01rRFp6TlAwZFpJck9mNVVmWGlXajc2bjl4eE9rSG1FZW9IWXl6?=
 =?utf-8?B?bmcyTHE3djQ0UXc4N0dXVlpKM3ArNldINUNRRlFoZCs2ODhHNGJNQU1GM1ho?=
 =?utf-8?B?Qys1blJTbWpOQlc5MkR5dDE4RkJ3SUJwdFB3N0l2N2NvTGxYQjRMUzBUNFRH?=
 =?utf-8?B?UW9seVM3TzdlbFozZEtocEFTYXpZdjJzM3drRHZIaTFoVkVRY1lyU2ZzczFW?=
 =?utf-8?B?dk5KNzkyVVhkRFlnRGtBWVdzakl4eWpUeHAvMnBUcHdJR1lDTTJXamZ1bE5R?=
 =?utf-8?B?eHBnSmdKYmY1ZnplZU1LMDBhUGFsWXVOQUc2Y01KSWVIbkRXYXhxSGZuUUZH?=
 =?utf-8?B?NnZQMXlkTWs3RWxsVFNXT2RBbklRVXNyU1lHQWFleU1WNXBwcjNPbHJveHNp?=
 =?utf-8?B?eDV2RzY1WFErbGU5Y0ExU1pCMytlUktZSHNBSk1kZ3E1cjlidHVsMklHYUhu?=
 =?utf-8?B?dytJVDk2cGdpb2VjMENrMGdIclFDbUdhZ3FrcmVBWU5FYjk4UnZUZnZKN2lD?=
 =?utf-8?B?eTMybWxTZGRycnE1Qm9DaHNkdHpCOTRNc1lYWkZ3ckJyeHhjazNBaDVORVVC?=
 =?utf-8?B?WWdDRjJ4TkdaRjU5TkRPdXhNamYxVEpHNVVoOWNOSTlhZEF5cEVFOXU5TnNK?=
 =?utf-8?B?NzZWeEp4WlVTTW1lSlNEMmpvWm9tdEg2OWtjUkk0MmxObmpJV0xwL3NEclh1?=
 =?utf-8?B?aWhLVStpVm5XaDh1aEhmL0hqaElnajNmdkh2NlpQZ2pSV3M5TWMwK0lwVUhZ?=
 =?utf-8?B?K2tWTmhpUEJ2VXBxejhrbFFWNW5mNDBXS3BjeGRHYVhvRkpLWTRnbDlOcXpF?=
 =?utf-8?B?Y1p5cmxjcCtMRk5xSkN5TGZ6REIzT2NsNmJjVVVabDdHQm5LMVBBTjQ3Vk1a?=
 =?utf-8?B?cmk2eHFFc2EwMEV1MFZ2R1R2UGFnUGRxeHhLNzZIbjlpdkthMVkvSHF3R2hp?=
 =?utf-8?B?OWlOU2VqR0NmdVJRREsxN3FMWTFRMGd1dXdLdk1wV3ZMVzFPcEhVZk9wWlRk?=
 =?utf-8?B?UDhmVXpBb1FuL2pXb2dGY3czTFhXcjVTT1p6TkdVLy9YNU5JRUovcFB0OEFS?=
 =?utf-8?B?bDRqVXh2UnJYL0ZNdmoxb2NWTVVVcnM0SnRxall4OWFoNHdJMUx1akVFSFJC?=
 =?utf-8?B?UXBBVENpckk0R1F6Snl5MkRKcmVJLzcrczhBTitoc2NzZlM2a1pKQWk5Zmk0?=
 =?utf-8?B?MHZyR2tpMGlKb0hUMXQ2bFFYZE5FeFFMcGpGSnFTRk9MckpJRU5KRzkrSWRs?=
 =?utf-8?B?ZXpTQVVTRlJQY3pHdjQ2NjFzM28wY1ZjUmdSTnorTFdqRUl1QzlaS1YzM09h?=
 =?utf-8?B?a3ZwOFA1bkYydER3RkNqa2d1RmozZHBnMGpKbTlLRmUvZzRacEtjUmdKV25m?=
 =?utf-8?B?ek4xNkZyYlJpc1dOcEhBa2NQOEV4UHNzVmtRYjZVeUZRNVRTcHR0YytDN04v?=
 =?utf-8?B?V0tnM3BDV0lwR1ZTUTRsTzVDWjF6dGgvM3JIUmIzTmhPZ1FPV0M1Wm5GSUNm?=
 =?utf-8?B?N0M2SGg2dDRjV2ZDcUFFS3NKODE4ZlBlME9CUlpwM2tjTU81Y0xsQ1dQb251?=
 =?utf-8?B?NkwrMG81RmlXZnhLT3dSaTVLSU5tbkxzYUpZWHpOZHh4NGo5U0lkWmxDU04z?=
 =?utf-8?B?akRZN0E3SFVCZHd3NzdkY1lRYUszTFdzbXNTejNtNTl0S041OUtLZUZWN2p4?=
 =?utf-8?B?MlBTVTdiOXlaMVdpb0tucVFCT0JqekZJdFlGUEIvS3lXSDNUeG0wc2tSbTRE?=
 =?utf-8?B?TWFvRDZNcTBQUE9zRER4dTI2VXhvU09CNEVkVkJtVVhyY0lVS2Q1b29EQ1A4?=
 =?utf-8?Q?qoDngjSTlgb0p9omsFFk142tO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32143137-56bb-4be0-de88-08de08a6903a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:14:21.1925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Gyf7Z2IRkIpu3hR8T0zh5n5mWVlANHATNt0ymBzF7GYefh3G9Qc9Y9EdOal+cWZO8KMGL7tolnysCWZZrwL1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7129
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:07:05 +0200
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

From: Alice Guo <alice.guo@nxp.com>

This patch adds SPL Kconfig option (SPL_PHY_IMX8MQ_USB) for the i.MX8MQ,
i.MX8MP, i.MX95, and i.MX94 USB3.0 PHY driver, allowing the driver to be
compiled and probed in SPL stage.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/phy/Kconfig  | 14 +++++++++++---
 drivers/phy/Makefile |  2 +-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index d36a5f00ef8..420d7c7a44d 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -289,11 +289,19 @@ config PHY_NPCM_USB
 	  Support the USB PHY in NPCM SoCs
 
 config PHY_IMX8MQ_USB
-	bool "NXP i.MX8MQ/i.MX8MP/i.MX95 USB PHY Driver"
+	bool "NXP i.MX8MQ/i.MX8MP/i.MX95/i.MX94 USB PHY Driver"
 	depends on PHY
-	depends on IMX8MQ || IMX8MP || IMX95
+	depends on IMX8MQ || IMX8MP || IMX95 || IMX94
 	help
-	  Support the USB3.0 PHY in NXP i.MX8MQ, i.MX8MP, and i.MX95 SoC
+	  Support the USB3.0 PHY in NXP i.MX8MQ, i.MX8MP, i.MX95, and i.MX94 SoCs.
+
+config SPL_PHY_IMX8MQ_USB
+	bool "Enable NXP i.MX8MQ/i.MX8MP/i.MX95/i.MX94 USB3.0 PHY Driver in SPL"
+	depends on SPL_PHY
+	depends on IMX8MQ || IMX8MP || IMX95 || IMX94
+	help
+	  Enable support for the USB3.0 PHY in NXP i.MX8MQ, i.MX8MP, i.MX95, and
+	  i.MX94 SoCs in SPL.
 
 config PHY_IMX8M_PCIE
 	bool "NXP i.MX8MM/i.MX8MP PCIe PHY Driver"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 98c1ef8683b..5a6df0ecfeb 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_PHY_DA8XX_USB) += phy-da8xx-usb.o
 obj-$(CONFIG_PHY_EXYNOS_USBDRD) += phy-exynos-usbdrd.o
 obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
 obj-$(CONFIG_PHY_NPCM_USB) += phy-npcm-usb.o
-obj-$(CONFIG_PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
+obj-$(CONFIG_$(PHASE_)PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
 obj-$(CONFIG_PHY_IMX8M_PCIE) += phy-imx8m-pcie.o
 obj-$(CONFIG_PHY_XILINX_ZYNQMP) += phy-zynqmp.o
 obj-y += cadence/

-- 
2.43.0

