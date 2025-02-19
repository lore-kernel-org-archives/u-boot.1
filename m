Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F63C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 20:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0F1080F32;
	Wed, 19 Feb 2025 21:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="ucfraK/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C9EA801CF; Wed, 19 Feb 2025 19:36:39 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F232800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 19:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkNAAvYPtTpuK++1TjLTqb5+YnvLqev1UIpzb4FWCTqOytkM4ps36UT5R/IfoiwbjKZqHg+MDRYj88o3qYFUoeUbh+yYkr/+SVQ02YRzMl51Mc55vfu8vaDHQnGZE+NJmvm5OIixUBGNDMZyu/3gs3Odf8FBTRWC8ca55ce2kA+e5ePeCG+3HypBCTHs/Lqe3fSvNZuyIzGmevVu/WtA9vzGM7Hw790ICpFtu0+/WxzVmQKa9mfdkxUeZ2RWD1swr22KRXb+8G99uJHSnmigP7To8635ptzWetfUzS6wnc9ayM4IEHkjOkG6x46+bbwqEiBkrMR8aZnlSv3TMTZqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnPUI1cu1H+4bq8t8ztsrntqIXZ+66pBMAE5CiGcsiY=;
 b=GJU7yfvfQL0sxeUNLP7NOohBGsIe6kwsH+K8uhFrfH1F5xQcX6bbCNijdnz/J8DEP7Vd3aeROo74i/KqwpZ+yzXj1gZEHc84mD6vj0+7b2yrmWMaRbgIPFAHsyU7kPWEYB0I1ficx6pE057mqZU6AmtnmIM4sG4MlO7Tu43VVkJYwVDenZOfBF9u9OZYgDXuNlww+nKIpu+8eqph7XJBrVhsb1XIf3Wab4EwTy6pqzOa3qLevUs3XmSKBoph84NRGbrYpzC7MiO6OQ4WyyArqt3nE18CPBGTdHZsV7AkVpEtNaRHGFk5YfNxkjFD18cB24yLtkvh9mXd7bOo2cXEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnPUI1cu1H+4bq8t8ztsrntqIXZ+66pBMAE5CiGcsiY=;
 b=ucfraK/fy7iT4vzyonBgF3b/ALW0W4WNvydON9NLleHxwh/SEuaijD6hw7gHKq2dIEeyNYqrUVZA47aEo5RjnUlEapA9y3/ml1Wr38RKfpFWRrkzxWJw1cMWjPMdGRD8tdQaw4LJ26Wk2WsSndTpjgm6ZPY2Zc+7V+tMTONwtGTUhrV67+WT3rVqRfT/jjSjhrdF4zAJDCgugX+jRw5fatIiNd4RonNZjEfhsBkB2UfVbegnAvv4Mtdd2iBONHe6w7IgvRsMvCiLoytu3moYUZenOqz/ZO6tj1EhLkrT9++nUEQ2vu9dBE0596cOcAA9rCf73WmvpunMBcVNrsS8gg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PA4PR10MB5586.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:260::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.11; Wed, 19 Feb
 2025 18:36:34 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8466.008; Wed, 19 Feb 2025
 18:36:34 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "c-vankar@ti.com"
 <c-vankar@ti.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "mwalle@kernel.org" <mwalle@kernel.org>, "dannenberg@ti.com"
 <dannenberg@ti.com>, "n-francis@ti.com" <n-francis@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "s-k6@ti.com" <s-k6@ti.com>,
 "afd@ti.com" <afd@ti.com>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>, 
 "mikhail.kshevetskiy@iopsys.eu" <mikhail.kshevetskiy@iopsys.eu>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "hnagalla@ti.com"
 <hnagalla@ti.com>, "m-chawdhry@ti.com" <m-chawdhry@ti.com>,
 "j-humphreys@ti.com" <j-humphreys@ti.com>, "sughosh.ganu@linaro.org"
 <sughosh.ganu@linaro.org>, "w.egorov@phytec.de" <w.egorov@phytec.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, "kishon@ti.com"
 <kishon@ti.com>, "bb@ti.com" <bb@ti.com>, "nm@ti.com" <nm@ti.com>,
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "rogerq@kernel.org" <rogerq@kernel.org>, "vigneshr@ti.com" <vigneshr@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 13/13] arch: arm: dts: k3-am62p5-sk-u-boot: Add
 bootph-all property to necessary nodes
Thread-Topic: [PATCH v2 13/13] arch: arm: dts: k3-am62p5-sk-u-boot: Add
 bootph-all property to necessary nodes
Thread-Index: AQHbgrvua104NIeonUCQIAAuHx/H1rNO9O2A
Date: Wed, 19 Feb 2025 18:36:34 +0000
Message-ID: <93a7462e30b4792d093252c256d182e9ee8a46f6.camel@siemens.com>
References: <20250219104831.2315464-1-c-vankar@ti.com>
 <20250219104831.2315464-14-c-vankar@ti.com>
In-Reply-To: <20250219104831.2315464-14-c-vankar@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PA4PR10MB5586:EE_
x-ms-office365-filtering-correlation-id: e3423e86-a88b-4e93-b4a9-08dd51145672
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dThMMmdIWXJhZ2dhaklKcGVlNlFvYTVHcE5YK0h4S2g5WG5zVnhCbG0rUC8z?=
 =?utf-8?B?Rk9vOVZVbDZxdkdoZWtnWG9GRkNodmErRVZzVXZQVjllS2ZXWFJSejJCeDZ1?=
 =?utf-8?B?Ui9IUEhQS1ZVV2poUFZSN0VSQlJBUWNhSHBwaU9yOXdvMzlHUVVFNzdmQ0Ft?=
 =?utf-8?B?NDFPWEp4QldXV2NTRDBXVTZrazlRU0NIUkIxRU1NYW1NVU1aeExhR1NVYklS?=
 =?utf-8?B?YlgxQmVGOTlIN3JrZDFMemIxWUpVMnM4TVJ0VVJLVTVHTi94Zk5zaHAwZ2Z2?=
 =?utf-8?B?Q2EvWjdaT0tHMlNjdW5zTXhib2JNenBWV3l6STFrQlVzRmxVa0xielFiSW5m?=
 =?utf-8?B?ZHUxekR4cHVCRDhGRTJQb2hpTHN2VnM0azdpc0hpSjFrZkswNjhmVW1BOUlk?=
 =?utf-8?B?Qk1IelVTSU9IQU4wMEZnLzlIcTd4N0FlNXV3OWlrQW9JdVZIL3dvb1dFMDJZ?=
 =?utf-8?B?WGhMWnAxOFE5NHZKSU9ydFZmSHQ2Nkhnb1p0SHZvTVpjemQ1TzB5MUU2dllU?=
 =?utf-8?B?UEpNZCtSMDd1V1lSbHNjYUFMd3ErOTI3Tm13TENCTVdqOTVpV2xWU2xvMUZh?=
 =?utf-8?B?STgzVVJRTlpPYUhGWnF0Y2xyZWdjK3ZBMHNYbm9yQkt6OGJSdk5vNFg3TDBk?=
 =?utf-8?B?c29kUlZyQ2Urc1lUa2hJbFE5UUNFSyt4RmtCSGFkRWpmeTdwUVhQZnNzRGJk?=
 =?utf-8?B?MXIwS1FNL1lxaGlRTE5vNE5EVUlLeDRGcjhCYjhjV3RTdlVoRFpYUXQ5R2VN?=
 =?utf-8?B?eCtTaG9saGloWVM4Ri9VYVdjK0lqc0VETlBWTlRiU2ZqTUpydlNHM09McVhv?=
 =?utf-8?B?d2pIeHF6aC92Y3VwNDkwRFRQcHlSMEhsYXk2b2o5L084NnR6R0NBaEdTbGRn?=
 =?utf-8?B?Zm02VUc2ajFuRklMUGFyOWV1YWFyV0c0bFY1dVpKdDAyV2xtKzdRWjhJNFlB?=
 =?utf-8?B?NGJuV0JHQ1VDbXdNdWcydmF4bHllSHBZM3VxL3FVcmtNa3V1OGRhR0dkdThK?=
 =?utf-8?B?SGZvNTdqMGI3U2szbVEwRXl3Vnd4ZHFhMU5aaEMzK2lWTFBNQnZwVlZHZ2RT?=
 =?utf-8?B?THAxa3pQRFpyaW15ZzlJN1pGUmdTREpUV2RFVHhsVEwxV0VXK0NiQjNiUHdR?=
 =?utf-8?B?Qk1mMU0xeWE1VmloNWFsR0kxNmFLRkQxNWlSNEFMWWd1TUUzY0hxcHJGcDAy?=
 =?utf-8?B?R3NnU3B5UmYxVUpIdGVRcm9MV0wrK0dSL2ovdUFqNjFnU1VtZWpWeHJzY1Jx?=
 =?utf-8?B?VHNXNFNZWWNSWmJLcjNHMVB0U1FRdFpQN2RjYm4xVU9CQ0Vpd21iUk4rRHZQ?=
 =?utf-8?B?RzhQZVUwNGNPYzBLaG5Scnh4aXNyTjRsVTdNbkQ3TUlORFFCK0FieEN5SFBt?=
 =?utf-8?B?UDRFY1VNOHNNZGtIbGk4NUN0Y3VjZXpzbHdPSlk5ZWVibTBCVlNucnE4MTBs?=
 =?utf-8?B?ZlpxNkt1TVhsbGF6TXpoa2JHd0NGaGV4TnZQM2Q4OXg4YjA3dW1OU2M0V29P?=
 =?utf-8?B?d1FWQmRUYWVpSEtmb1krVGNkNEtjMkFzRldOcTN3Y3JUOHhRckdyd3I5bERu?=
 =?utf-8?B?TmRhS0JMU2lEazZSUk9MeUlFcGNwd0JvVUQ3U0Y2LzVnSDRhSEJjYURpM3Vk?=
 =?utf-8?B?dTFQVkVzSS8xRlNFMVJvZ0hjL1JJRTdLWEg4WDBRR3JYOGJwOGM5QlAzT3pt?=
 =?utf-8?B?R1R1NXNuTkpablA4R0ZiVFQ3SUMvTUtxZkhDQVRVeitoNVB3bjFIQmQ2allM?=
 =?utf-8?B?TWxzRFdoRnNKK2NuLzcvanplZkMxaW5MWXFMMENlSFB0eTBHKzVGN0IySmVp?=
 =?utf-8?B?SjA5SWFWVmN1VUt4K3FCUVpkUS8zNExreUFCZFFSdGVCS2I3MHZyQjlpSlNr?=
 =?utf-8?B?WXFzeWZBV01hZ2FVZVhmblNEWmxSTDJkRElWOFIyeGVMVGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1lmb3k1V3ZmS3phQm9YeDE1UE04eXpXMVJ0ZTA5dktoblR1bmIvN2RLTzZU?=
 =?utf-8?B?RFExMnZEN1hUbTVyZk1TbmpOdDM0VllDZUt3Vk1LekNoNWRqMkJJME92aUww?=
 =?utf-8?B?ZlkxOTBZcm9iaTFtdEx0S0Fid0xMcjl2S21mRjZPdVZvdU4rSnJlNHR4ZWZT?=
 =?utf-8?B?cnhkU0RLZkRSaXhGdDN4QjJlOGJwRXRWdndTaEFxVzJ0c0lFNndnSGJFZEVW?=
 =?utf-8?B?U3lvTUliR2l1bWJ4OE1ZR1dXLzhudHdyZG9hTlQzY2dEK1djTmpGeFdhcTMy?=
 =?utf-8?B?MmtOV29XclZXQWEwSkZzNXF0WVlmN3VPQ1ppUnRHbnh3bzlkQXhCazZ3N1Vj?=
 =?utf-8?B?aGh4bXpjaTV2Q3NScU04dUJxRzFwSGhzWjZnZjZKQm9pWDBwZkpMV3BIV3ZJ?=
 =?utf-8?B?VGdBTkozOExpcnYycmVIMHVlQ1Q0NEw5MWRENWZiRXM3VXA1NXJWSUdqNGdT?=
 =?utf-8?B?Q2RjV3JBdFBsb2UvVHRhMkNIQ1J0SGtKZW5UUllySEc1dGRjckNkRGhvRzF3?=
 =?utf-8?B?N2RRd1JHa01xeVRQS1drcGdLNWdkZDA5Mmo4T0FrTXYwbjlBTC9nb3huT0w1?=
 =?utf-8?B?NWVvRzltU0RsZVU3aWhjMXVnMmRreGRpczFwRy80ZjhpZVNNalR4KzEyNlNz?=
 =?utf-8?B?NzNvUVZDcGs0KzZNQ3dvaVBKZFhRUTM4bUM1N2FNWTZIc1krdnNkdSticnk5?=
 =?utf-8?B?UUJ2Qnc4MW9UYlM4a3lNNURwSUwyNWR5OW5uVHBKdmV1ZThYdVJxOUdvVENT?=
 =?utf-8?B?M2VzcFNYc29KbnJLd3ZNQWd4QXo1RDBXM0Vlb05xQVNNZ3NMU1A2WUtUMTkz?=
 =?utf-8?B?bFdMZktmVGFHYjJKQy9IMittdTFQY3g2R1k3K3JONDhLM0FkdytGdThVMnFV?=
 =?utf-8?B?WWxXbUpVNDl3c2FkYlBlaHQyVjlCV1RIZ1NsbWg1Vm9UV1MyU3VlZXdvUElo?=
 =?utf-8?B?L1lYMVNMTmVGbkZpVTc2bHNuU2lwVHBCYWQvSlFpQUJKcXc4ZmZsTFh0MnRD?=
 =?utf-8?B?VXRYcDZqbXU0NmsydXpFcVh3YitGa3ZIMnFoaUozRmlibUc2WExibWJsQ1VM?=
 =?utf-8?B?TTFUWEptYk1TdzY3by9NTzNKNi9VSXViWUdGdXh4VUNJUnBVcEpuY2dnUGlY?=
 =?utf-8?B?djNsRHFCQko4a2RTZW44b0orYUpuUXV1TWErczQzcFc3UVA4cnJ4aGdWa3gv?=
 =?utf-8?B?TFNnQnQ0cFBPQURMeEtTUEI4eHc5KzNiNUY2Z2g1djg5QlRvK3E5VzVkc2g5?=
 =?utf-8?B?M2MrcGVvZC9admM0aDZGNWtPMnhFeUxBOXRVcVd1Rm9td283ZzEyaXBsMHpk?=
 =?utf-8?B?TGh2ZnpHaTZwU2pQYjJCb3hDS2RDcDZvOUttTkxrOHFVUU5JWFJycGwyU3Jn?=
 =?utf-8?B?TURiMVRleUprWTJmSksxcXU5L1RjdkZ4ZVVjVWMzUWkzN3BGWWVlV2tBNGhw?=
 =?utf-8?B?OE5jT3RPUCswNHNzWDZDQXpFcTA5V1c0anMyVy9ZZk9xcDYrT1EzeDhqaUZN?=
 =?utf-8?B?WmlmRkJhVXVSK1NSZmxTNGI1THdsYmZxa1ZOVU9SaGVxOGFFQVZOTUF6K1FR?=
 =?utf-8?B?OWt4QjdBWFRKWitDZFFyUTZPWmUzTDM1cjJJT1Y4YlNHQVFCWmhIeHNlS3Yx?=
 =?utf-8?B?MnN5TDlJc0ZwYVRnUVpHckJhYVpPQzlrTFRTYlJVZ0RGMGNGdFM1ZnBPZmxQ?=
 =?utf-8?B?dGI4ZU1jMVlHdkVBVVl1ZSsxenVPdUNZelVoRGR5bGg2bmxoa3hBNzlIL3hO?=
 =?utf-8?B?TWNpVVlrOEJ6bXZ3TzBiY1dIOWc1Q2xCS3N3alBCb1E1NDI2Wm92V085UVhZ?=
 =?utf-8?B?eElKS1NoNUZaSjBwVEJuSHpUWVQvRURGc05DMWI5STI3dklzNXNDM2ZWdHBM?=
 =?utf-8?B?bk5FVXFlYll0RndCeGVocTQ2dTVQNjk5a2FZMm5yQWxiMlpwOVN3cTJtYStx?=
 =?utf-8?B?KzdnMk5GR2NickdsNDFKVVlXVUI4RFhyZzQyQVY1TTVtSWJqclNIODNPdlBE?=
 =?utf-8?B?cG9admNiQjJqek5qT1A4dnhrenZsc0ZLRFN1a2VsNHZnZFNhekEyZnE0SXFW?=
 =?utf-8?B?ZmVOblRka3FocE10QkhtZEpMU3VESzJmNW1PaUU5Nk16RHg3RXR5Zmo5TUZo?=
 =?utf-8?B?bnpHN2JIRWNXS3lTY05wOFcyOUc2N0pOeW5NVTd5bVhJR0U1bko5K0VMYzIx?=
 =?utf-8?Q?Dr30gqs6a+d7MlHR/AIWr3E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C76276BD6CCEB4478A10D528B6CEA4C1@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e3423e86-a88b-4e93-b4a9-08dd51145672
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 18:36:34.7435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EixvRDfK625oiZ/14JnbTgvrZfXsuIgMGV6L+cgkP+JPDLyi1W3ne7bsN3XFsqDEO/RT5nnBt80EDx9Sl0UvvwIaGNzAgEHulxLn2rUKWxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5586
X-Mailman-Approved-At: Wed, 19 Feb 2025 21:04:12 +0100
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

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDE2OjE4ICswNTMwLCBDaGludGFuIFZhbmthciB3cm90ZToN
Cj4gQWRkICJib290cGgtYWxsIiBwcm9wZXJ0eSB0byBuZWNlc3Nhcnkgbm9kZXMgcmVxdWlyZWQg
Zm9yIEV0aGVybmV0IGJvb3QNCj4gc3RhcnRpbmcgZnJvbSBSNSBTUEwgc3RhZ2UuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBDaGludGFuIFZhbmthciA8Yy12YW5rYXJAdGkuY29tPg0KDQpSZXZpZXdl
ZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+
DQoNCj4gLS0tDQo+IA0KPiBMaW5rIHRvIHYxOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzIwMjUwMTA3MDkzODQwLjIyMTEzODEtMTQtYy12YW5rYXJAdGkuY29tLw0KPiANCj4gQ2hhbmdl
cyBmcm9tIHYxIHRvIHYyOg0KPiAtIE5vIGNoYW5nZXMuDQo+IA0KPiBUaGUgY2hhbmdlZCBtYWRl
IGJ5IHRoaXMgcGF0Y2ggY2FuIGJlIGRyb3BwZWQgaW4gdGhlIGZ1dHVyZSB3aGVuIHRoZQ0KPiBE
VC1zeW5jIGlzIHBlcmZvcm1lZCB3aXRoIHVwc3RyZWFtIGxpbnV4Lg0KPiANCj4gTGludXggcGF0
Y2ggZm9yIHRoZSBzYW1lIGlzIHBvc3RlZCBhdDoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
ci8yMDI1MDEwNjEyMzEyMi4zNTMxODQ1LTMtYy12YW5rYXJAdGkuY29tLw0KPiANCj4gwqBhcmNo
L2FybS9kdHMvazMtYW02MnA1LXNrLXUtYm9vdC5kdHNpIHwgMzIgKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvazMtYW02MnA1LXNrLXUtYm9vdC5kdHNpIGIvYXJjaC9h
cm0vZHRzL2szLWFtNjJwNS1zay11LWJvb3QuZHRzaQ0KPiBpbmRleCBjZjA4N2M2ZTM0My4uYmU2
MmNhYzc2OTQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2R0cy9rMy1hbTYycDUtc2stdS1ib290
LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vZHRzL2szLWFtNjJwNS1zay11LWJvb3QuZHRzaQ0KPiBA
QCAtMTYsMyArMTYsMzUgQEANCj4gwqAmZG1zYyB7DQo+IMKgCWJvb3RwaC1wcmUtcmFtOw0KPiDC
oH07DQo+ICsNCj4gKyZjcHN3X21hY19zeXNjb24gew0KPiArCWJvb3RwaC1hbGw7DQo+ICt9Ow0K
PiArDQo+ICsmY3Bzd19wb3J0MSB7DQo+ICsJYm9vdHBoLWFsbDsNCj4gK307DQo+ICsNCj4gKyZt
YWluX3BrdGRtYSB7DQo+ICsJYm9vdHBoLWFsbDsNCj4gK307DQo+ICsNCj4gKyZtYWluX3JnbWlp
MV9waW5zX2RlZmF1bHQgew0KPiArCWJvb3RwaC1hbGw7DQo+ICt9Ow0KPiArDQo+ICsmbWFpbl9t
ZGlvMV9waW5zX2RlZmF1bHQgew0KPiArCWJvb3RwaC1hbGw7DQo+ICt9Ow0KPiArDQo+ICsmY3Bz
dzNnX3BoeTAgew0KPiArCWJvb3RwaC1hbGw7DQo+ICt9Ow0KPiArDQo+ICsmY3BzdzNnX21kaW8g
ew0KPiArCWJvb3RwaC1hbGw7DQo+ICt9Ow0KPiArDQo+ICsmcGh5X2dtaWlfc2VsIHsNCj4gKwli
b290cGgtYWxsOw0KPiArfTsNCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcN
Cnd3dy5zaWVtZW5zLmNvbQ0K
