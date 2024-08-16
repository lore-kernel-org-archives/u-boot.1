Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB97C52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 13:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 057E788A99;
	Fri, 16 Aug 2024 15:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="UF9SysCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 702A588A75; Fri, 16 Aug 2024 15:08:26 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E7CA88AFF
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 15:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1Fjwd6JjWGAf6oIYYx2Tuo5rsDkUkjpR87TLX6qtXsoQml+ETrg0hZS/RjNXwC+lI9em1qHu4VX6ENmHx0lG8cG3TegqKWRTubwHhkKapdnFOInC8N3NObEmD6paUTUj8bj2rGYtIq2byRR2KsmtJe5pwiLcMFfdi32tCNkkZ7cf0Q60mb/4N2Twe25FfeXPZCDxhmpJbdW/2GXx44kGEWbcTgqgBBKhLgFfhqn/BX/k+Lp8A1OGQH3pIZA/7g88sh+tdatAoNGA1mgJpTVJVfLCdFTER32Se08s3faqcPeHv0znTYbdHPsVbwXOWwuc5d+tILw/5FykOUy1PdQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vRLHbr89QMDLGt6vPwGWDOGUyCyPNNxixtTx5k0i3I=;
 b=BcwfTYVnsN5OCjmJXZCswPYyJTOX0jlU6AbFf4IWUSz8k+UQScz7iFA2I53lZQm4faknhajs28MQs9JWqeaFgPSbXFdoqZvBDIN5s6yGxAatuknBEUt/S1+mZ1+ghnUB1fwNTmSVEWJay8c3ff0y+vPkzYtyvb9H9SNt+HI8ImfxVf1aY9Js0wKeoj2JpscwnWCUx8uvY3UbNZuM4ysotNuY2HL2AIBKbc41+u2SHPMIPrsQRrvncBX+OJLOVd8liDO0DFZYyB0DOMalv9HBfbaRyr+jJgKoV7cUC4thZPeDjZagXB4f2FHB4jE86bi9yyq4/fWEyFxAc1c4s+iNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vRLHbr89QMDLGt6vPwGWDOGUyCyPNNxixtTx5k0i3I=;
 b=UF9SysCqWPps+x/ugSV9adMvgEmXoeZVQko6kAFhXpNB4mW60k4uriOemNPP7CCZaWbDf+gEKToHz0lzMbsLSB67BrbBuLLfnyAVyT/Q8f7f6+1Qcnso8CblUvz8Y7IKBRLzPlCQwvUxy/vKypwP8rQkf2PbUOn/PIHgOTmczlBc1c54eq3W+ljwIfnj5VPSTiJyJ05g8fXVnYNcLAFaFAz0fRv9rICt5h2ZzZlAp6XQFxLA8+SYo717HxvUeYcDb7qIQmhw/FJhYsk/zbfdwET9SdReYpRsIS+O99IMJfR0liFGfnZcTIxllN9+xg9UdhmAVxqFpAKU0ROWoxGQAQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB8PR10MB3893.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 13:08:20 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7849.021; Fri, 16 Aug 2024
 13:08:19 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "sjg@chromium.org" <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "patrice.chotard@foss.st.com"
 <patrice.chotard@foss.st.com>, "vitor.soares@toradex.com"
 <vitor.soares@toradex.com>, "clamor95@gmail.com" <clamor95@gmail.com>,
 "sbabic@denx.de" <sbabic@denx.de>, "trini@konsulko.com" <trini@konsulko.com>, 
 "afd@ti.com" <afd@ti.com>, "ion@agorria.com" <ion@agorria.com>,
 "marex@denx.de" <marex@denx.de>, "r-gunasekaran@ti.com"
 <r-gunasekaran@ti.com>, "a-bhatia1@ti.com" <a-bhatia1@ti.com>,
 "sean.anderson@seco.com" <sean.anderson@seco.com>, "noreply@example.com"
 <noreply@example.com>, "Leto, Enrico" <enrico.leto@siemens.com>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>,
 "mk7.kang@samsung.com" <mk7.kang@samsung.com>, "devarsht@ti.com"
 <devarsht@ti.com>, "yangshiji66@outlook.com" <yangshiji66@outlook.com>,
 "jonas@kwiboo.se" <jonas@kwiboo.se>, "danishanwar@ti.com"
 <danishanwar@ti.com>, "francis.laniel@amarulasolutions.com"
 <francis.laniel@amarulasolutions.com>, "nm@ti.com" <nm@ti.com>,
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, "festevam@gmail.com"
 <festevam@gmail.com>, "raymond.mao@linaro.org" <raymond.mao@linaro.org>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>
Subject: Re: [PATCH 12/35] global_data: Convert have_console into a flag
Thread-Topic: [PATCH 12/35] global_data: Convert have_console into a flag
Thread-Index: AQHa3duHFxv8isDxrk2bc5q/C86SDbIp/wEA
Date: Fri, 16 Aug 2024 13:08:19 +0000
Message-ID: <c886cdcb395e842d179144e5fa1d8b0de41127d8.camel@siemens.com>
References: <20240724150922.2343249-1-sjg@chromium.org>
 <20240724150922.2343249-13-sjg@chromium.org>
In-Reply-To: <20240724150922.2343249-13-sjg@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB8PR10MB3893:EE_
x-ms-office365-filtering-correlation-id: 7a3fc8c2-352e-4e5e-73a7-08dcbdf48014
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?S1hJYjZjakU5bFI3c25XbFNlYWxydlpLUnNlOUFFbW1FakJwQ25vb3VLaWs4?=
 =?utf-8?B?WEFMSW5QVnQ1VDYxSVFPYnp5MStFKzhkMkZ0TkxrNTFlSTMvRFpDZ1B5QUJK?=
 =?utf-8?B?UHpEek5EcFlwMko4N0tnaUg1RDJjYXRhVEZ3cVN2MFRxYjJKa3RqcXpVZmlr?=
 =?utf-8?B?U241RjYvUGlWRVFvS2tjRHFERDlZRDFnQlAwU2NqY2lQQ05OTEg1L2hzZFk5?=
 =?utf-8?B?V2ROM01VblZ5SVprY2tibWttVFJpTW1yUGhqVVd0dUh4ck0wWS9mTEQ3dnV6?=
 =?utf-8?B?RzFXRmtkYVcwVjNMM1RPNmNhbEpzQm1FSkhXMHhtVFdKczF4RkZzaEhNTElY?=
 =?utf-8?B?UktlWWsrVndNV2hVbG9hbGFCRWVvb1dVY1EzOE5MMXU0YzhxUi9tSzR4OVBo?=
 =?utf-8?B?T0hwWDdLalBWa3o2Rk5aeWp3ZFVKUnpTSWo2RFkrT1p5M1pwTSsvcHFJYXU0?=
 =?utf-8?B?ZWJnN1MwWjVzUzVKekhhbW9rcGdwYUszcUJGbDVQT2t4TXFaT2ZQNTl6eWpE?=
 =?utf-8?B?d2xJOFV6RG51c2tvdU9LVDgwN3JzZk53TFpVRk9aVEdjYit6NWJsc1o5NVpw?=
 =?utf-8?B?LzVibTJ4Q0FpOFpOQjlXV2MvOW9tWHR5azltNnFYcUt4Q29FczB0TlFRZUhK?=
 =?utf-8?B?eS9TQXdzMEppb1UwMG40ZjFCK3UvbEZzZWZ3YTgyMTVQR05CRGZZVkJjcWFj?=
 =?utf-8?B?NUJKZUFtV1pjUzVPaUNtWXdocDFuU0hrL2xMSHpFMnFCYjlEYlRVcktFako4?=
 =?utf-8?B?RmZyc2VwQkFsU0hnU0hIQS9vT0pPTU1kRVRkMmpDOGp3V1Y0K1dqU1VmbWs2?=
 =?utf-8?B?Q05CdzhNS1RuS0xXbHZqM0lvSEVtWWZOTEpUdi94SU5nVjhNK294K2RwNTN1?=
 =?utf-8?B?aHB0V1ExTlROWFY5dk1rc0kxMUVBVDd1d0srd2RyZ1lja0QwSzYyYm90aStE?=
 =?utf-8?B?UEhSVGZxMmdQWXB3UkNyZEVQSnpNRmNLQzRsMWY2azBmVXNPZFhvTEJZd24r?=
 =?utf-8?B?OG5Mam1YZFU0Kzl4cU5MNDM1M2hOQVo4TElyYk9aRkhjVDM1dy9oUTkva0lK?=
 =?utf-8?B?bVVrc0g3anByTWlsVUpNRkh3WXI0Z2lsRFlNeERJTTdLb2VnK1NOQWphS0cr?=
 =?utf-8?B?TWhaNzJuUEgwamRIb25qTkFya0cra1JtUUIzSGJ6V1hCNng3cnNpa21lMXJm?=
 =?utf-8?B?MFNQQWZVU3JPY3ovZ2hYeWVGVFRCdU5HbE1yS0x2dVZXRVBPbFIyTjc5b2hv?=
 =?utf-8?B?RnRCMEhENklXSkY3UGdtOWh5VGhPUHJleEs3R3RTQUx0d1ZyOEdOUnhaVTI5?=
 =?utf-8?B?bDF6enJGQS9oVUM2ckxRUVROZDlUNURVQVpKSlNBNU0vWmRJRkYzY0o1eExU?=
 =?utf-8?B?dHF2SEErakdyWjB4SXFhVHpPNVZFMjJpRWFneThRdzNiSGxKT2NEZS9CMW1F?=
 =?utf-8?B?MWVrWjZ5Q0V3L01TaW9Nd21taHdSTzgwcG1CR05oamkzUUdYZ01Ud0Y1ZEx1?=
 =?utf-8?B?VFRyTkhjS3JpUHZ1b3kreXZyV0pGVGVsSzlhZ2ptUWxLYnJPVTdzdmhoMjJk?=
 =?utf-8?B?ME1QZkFuS1RnZTBJTVdSOU1GUjRWMDJjdkI1ZlJ4TDJGcTV3NStGYm4wd2N6?=
 =?utf-8?B?Z3dxMHdlcVBCRGNibndLd256U2ZQb3hNcUFmWHYvYXBXQjQ3S21mbGs4T1BV?=
 =?utf-8?B?dGpwVHNhaFBSd3Q1ZzRXeU50dGlpYVZTcWYyVFBlemsyS0Z2ekhqM0VoVVhQ?=
 =?utf-8?B?UndHQUlnVm1HSU44VTRYanRLV3dqSWhzUnlnd2J5dDljUk5pbkZEbSswNjhh?=
 =?utf-8?B?dVpmSDkxaUovR2g3WEZ2QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0RYbkQ3Z3pOTnVMQWlWd3VwbExBRFRFSGJTaGlyN2FMNDJ1bnNia3BOOFda?=
 =?utf-8?B?ci8yTE5MOWN1cjk5SzB2bVZMVFB0cUhYSHozRXQyR3ZXelhjcnJJWm02MFBM?=
 =?utf-8?B?a001T05KOU03VVlnWW43bkFRT2dheHYzaU8wNVNNQmpyblR1Ynp6VFZYMG0v?=
 =?utf-8?B?WDBYRFIrMVdHTHZ6dGQ0dWJYUnJJSTY4R2JibHA1d2VVR2RmL2ZhUWdnL2c5?=
 =?utf-8?B?ZWlIZjg0SXN5TGlXODhqOU5ncmpBSmFiaVIzWTFTbnprZzRKYkw1OVRIY2p1?=
 =?utf-8?B?U1I5UTRjRG43Mk0wdndtR0ZjaUdZK0JCTmU2M21LTU4wMVBYOGVaUTRIcjVM?=
 =?utf-8?B?MHRNOUV5R3NXVkZpTUNuOFZqM1NTNllBZHBrMXlYZFFMcmJ0ZzRFSGVwS1lh?=
 =?utf-8?B?cmtCMTFGNjZZd2NYcmV0RmY5aDBMMTVvcTBPUDZMcG9qOWNXZ0VSM05VN3Ba?=
 =?utf-8?B?Y2xIMVVYa0xvc3c3Wmg5clI5ZWU2QlpBbjhxSnY0RzhCcndialRyZnNSeEM2?=
 =?utf-8?B?dHhnVkQyOHpjRVJmNnA0SkVneEpSd1Q0ZWdDS1p6N3A1SjdKL3Jic2s0Wk12?=
 =?utf-8?B?V1FGR2FwNnZUN1BGN0NzMzJKb0ZuZEcxbk9KNFZMc09PMmNmRUpiU0czajZM?=
 =?utf-8?B?cUtPeGpjdFJ5NFAwbVg2T003N0VybXFIUVByd2hGN09mNnFWSnVzdU9ZZlhI?=
 =?utf-8?B?Q3pZd2NIOUN5YTVreWhMbU1PcUM4UUJRVXVKSHY1eVNISjdNa21aWEh3eWZi?=
 =?utf-8?B?ekJnc3VsbFFvVUllcTU1Wlk0dmowRkpGUE40VW84NjdTd3pDL1c3eEJQMEVq?=
 =?utf-8?B?V2I3TTNDVWtzSDdqUVFnZVV3U0kydzZHK2JFMzlobFplM0VmOGJ1SjFOdG81?=
 =?utf-8?B?d0g3SmN4dGE3L1EzWm9VZ0UrN0U0VGIrSmQwVVJ6aDVQTUphSXFIMGdZZGZt?=
 =?utf-8?B?RTIxMDV4ZmxKVzlTM1F5cUxIMVp5OFk4c0RidTlocnhpcFBsNWRGVWRpakJq?=
 =?utf-8?B?RFlUL0VIQ1JuZ2MyNjFHSEtqVzJhZFJ3RVE3MFgwdWt4QkVRVnAyUlFMSTZN?=
 =?utf-8?B?OGdwd0NPTnM2Sm9tVEdseDFDVThwY1k4UlJ2a0pkcFZZc3NpZHN5MVJLSCtO?=
 =?utf-8?B?OUptRGFMQzBJWFMrUVRWbkl6MndnZFBTS2lrVzZDbFNLT3lNOHpQaGlIT2VL?=
 =?utf-8?B?WENBT1RBWGxUZTVrczdveithOXVXS1plZUVIdCtVWklQQVA5MUNjYVNNRFdX?=
 =?utf-8?B?MHdHZXZnQkpWTFFncGRReU11MjNCai9id1c0YU9WZWZjSlFYNldOdlRyd1B1?=
 =?utf-8?B?OWYrZXYrYU94OWFoblFWSVl3UXBISjYyK0tISzVvOEcrVm55czJoUTVUeGFF?=
 =?utf-8?B?WnFSMitsWjFnRndFelFkdGdiSks1NjZGUDJ1YlI0RVJYRHFGWE1PSFNVem9U?=
 =?utf-8?B?UVNWYkszZ2k0dVdRRDVnSkk5b2RaT1RQRnhQMDNGb3hoZHp3UlpjS3RkcWlF?=
 =?utf-8?B?UExxWXZ6dWlWVzlUNWs1VlRSUnN2MnVzMEVZN1U5L0JUKzlEQk4zbW5SNHFF?=
 =?utf-8?B?eSs4Rzl6K3dOOUlPVmp6MldGdTArNzJSSVJXeTUyN21hQkE1NEZGdXdHUVFG?=
 =?utf-8?B?cVdLUkdjU0YwSDliam1QR2ttWUxEMExjdGFMRyt2VVhnd2M3V25zWW04Yy9r?=
 =?utf-8?B?Y2MxSzhtdmpyL0JnVEoxaXVvclNDMktmVCtkMXpQYnRqNG9aQ1JsODVuY2dC?=
 =?utf-8?B?akxjZHZJQVpYSGVHSUdCeWh3MjZGSGZOcjNBMVloZGVaZ1prUlVaMkZRZFF1?=
 =?utf-8?B?Kzd1dnlrUlRIdVJGaFkzRm5kNHZrN1BaZmUxcXI2OUYwZEtmblNvUWpnSWV5?=
 =?utf-8?B?ODNOOThJTjJNTXltZEdTTEY4aExjQVNqOGtpQ0NLT0lpcUt2RFFmd21qRXNB?=
 =?utf-8?B?eTdxM2VaVm9rL1VKbnhLNytkZjJ5MEh3WFU3Q2RPWUk0RGVEUG1nQ0RNRFhI?=
 =?utf-8?B?Y3dZemVhTlRwWG1QOTVST1ZnMzRxRFlsSHpMMm9IeEN4dEpVbW14UlpXZWlo?=
 =?utf-8?B?dHZEdkRCV2FrTTgvZUZpR1hkM1VZbk5LQ1B1bkNUNjJnODRMOGdKNzVKUEZa?=
 =?utf-8?B?QmpPb1ozejJHN3lkM1RlUy9rQTkrRnIybFp1bUdFNjNyQUcvRUhTOXVTUFdU?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A581760578649444847AE99E02732E2F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3fc8c2-352e-4e5e-73a7-08dcbdf48014
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 13:08:19.8060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8i62ySq/I/88dlo6KXR2F4Wd2tmpVAhjnfBB7m9QrbA4z2JME9lBNrDjqdkz0j3GWwNZ54dAiX1AHnZ0JNizpLX1dLDsjV93eaY8rSqDek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3893
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

SGkgU2ltb24sDQoNCk9uIFdlZCwgMjAyNC0wNy0yNCBhdCAwOTowOCAtMDYwMCwgU2ltb24gR2xh
c3Mgd3JvdGU6DQo+IFdlIGRvbid0IG5lZWQgYSBmdWxsIHdvcmQgZm9yIHRoaXMgYm9vbGVhbiB2
YWx1ZS4gQ29udmVydCBpdCBpbnRvIGEgZmxhZw0KPiB0byBzYXZlIHNwYWNlIGluIGdsb2JhbF9k
YXRhLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+
DQo+IC0tLQ0KPiANCj4gwqBhcmNoL2FybS9jcHUvYXJtOTI2ZWpzL214cy9zcGxfYm9vdC5jIHzC
oCAyICstDQo+IMKgYXJjaC9hcm0vbWFjaC1leHlub3Mvc3BsX2Jvb3QuY8KgwqDCoMKgwqDCoCB8
wqAgMiArLQ0KPiDCoGFyY2gvYXJtL21hY2gtazMvY29tbW9uLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDIgKy0NCj4gwqBhcmNoL2FybS9tYWNoLWszL3I1L3N5c2Z3LWxvYWRlci5jwqDC
oMKgIHzCoCAyICstDQo+IMKgYm9hcmQvc2llbWVucy9jb21tb24vYm9hcmRfYW0zMzV4LmPCoMKg
IHzCoCAyICstDQo+IMKgY29tbW9uL2JvYXJkX2YuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQ0KPiDCoGNvbW1vbi9jb25zb2xlLmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNCArKysrKysrLS0tLS0tLQ0KPiDC
oGNvbW1vbi9zcGwvc3BsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDIgKy0NCj4gwqBpbmNsdWRlL2FzbS1nZW5lcmljL2dsb2JhbF9kYXRhLmjCoMKgwqDC
oCB8IDE3ICsrKysrKystLS0tLS0tLS0tDQo+IMKgOSBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRp
b25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9jcHUv
YXJtOTI2ZWpzL214cy9zcGxfYm9vdC5jIGIvYXJjaC9hcm0vY3B1L2FybTkyNmVqcy9teHMvc3Bs
X2Jvb3QuYw0KPiBpbmRleCA3NmE2OWQ3Zjk1OC4uZGQ3NDgzMjgyOTMgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gvYXJtL2NwdS9hcm05MjZlanMvbXhzL3NwbF9ib290LmMNCj4gKysrIGIvYXJjaC9hcm0v
Y3B1L2FybTkyNmVqcy9teHMvc3BsX2Jvb3QuYw0KDQpbLi4uXQ0KDQo+IEBAIC0yMTksNyArMjEw
LDcgQEAgc3RydWN0IGdsb2JhbF9kYXRhIHsNCj4gwqAjZW5kaWYNCj4gwqAjaWZkZWYgQ09ORklH
X1RJTUVSDQo+IMKgCS8qKg0KPiAtCSAqIEB0aW1lcjogdGltZXIgaW5zdGFuY2UgZm9yIERyaXZl
ciBNb2RlbA0KPiArcwkgKiBAdGltZXI6IHRpbWVyIGluc3RhbmNlIGZvciBEcml2ZXIgTW9kZWwN
Cg0KYW4gdW5pbnRlbnRpb25hbCBjaGFuZ2U/DQoNCj4gwqAJICovDQo+IMKgCXN0cnVjdCB1ZGV2
aWNlICp0aW1lcjsNCj4gwqAjZW5kaWYNCg0KdGhlIHJlc3QgbG9va3MgZ29vZCB0byBtZSBhbmQg
eW91IGNhbiBhZGQgbXkNClJldmlld2VkLWJ5OiBpZiB5b3UgcmVtb3ZlIHRoZSBhYm92ZSBjaHVu
ay4NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNv
bQ0K
