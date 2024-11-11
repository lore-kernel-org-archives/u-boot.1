Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA55D5E39A
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 08:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A7488C0F;
	Mon, 11 Nov 2024 09:34:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="fynlXGFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90EB688AE8; Mon, 11 Nov 2024 09:34:54 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A031888E17
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 09:34:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2A4UposaTr865MhaPt94jj0uN7ei3Ly5lg4j/VKLksepsDoPp+JpKyJUhzbzQxDhKGHSHlc+1HQNEkoQrvd10dVVAzMOXIom41W3LRoRGlzEiAWU9W+2LYSBpLv+aqYbnzrhi1QcHerRp6MBMEciiP8Y8QG2aYTYVPBei9i72nlz/odDrthsGOnLX+sFz282FaFoe1LfV1Vnin/v0W7nz39HymfiWoIOIJ883LhxI5x0ylZkIlyCQpPRTJZmA3eChSU+9R5oPU9qnoUjFUTtkRizmm432tW35gcVEkXYKkhksrAzkEQ0j6+NrgthNb/I7vSZgYhFWR3nNeIlU07yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9D+/fSP2vqIplivD1OP/mZhJHmh7JiYtcMmb1wNWD98=;
 b=njGzjOi6Y0UqWps3ta+pfNvToir+/VaWk4w64hQVAnRnqLkx2VfWP8WtpfZurV5tJgI3YKN/3VVff8ss3XaXCAZfyO4ju7Ws9OjDQkL9XU7IGZqVcrdxpilQjwZUXqDUwwVPBmcFzrwb53xwj6UkbZxINxyTyOHXi9PMEOR3Jf+GTZ9MeOiBg/ydXSFuAyfVrvdo+Hl1XVzYDWLVA5vq2Z9CbAhvuHMJlOxHYF8FfyVTLuE8nCvI5M60IwzaZG3VZ07o7dLF8r0sCqAlZvCAyZIVe2JzghIc0GLUPoxlwTeyWCHqW1lOvwX55VJasTp/73exgQhPLZa4XUYjVyn8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9D+/fSP2vqIplivD1OP/mZhJHmh7JiYtcMmb1wNWD98=;
 b=fynlXGFsXaPgTme4USTG4ooRyfx+bg6MFDKOLTGL0VKVFS+DkBQpdU/kg1IbVPdy+viJfFQIwf1J5M1yEYczDT9YYtxDlLmxWXeoZYgsLCfyIGk98knmr0q2is9y9V0nHby50kPMNT5lwvXoNKS5bnAltSjjFym82ErfxcZ7apqyCEgWljZ+zr1mpV9ogzI+jzGKpwmJO1/q70db0CPqCBA4cEGBCgJy3lgV85vPmYsdynZ/HqqNyyabtuZ+nAj8PAvfkdwl7qvYaqk02GZUkfvS6cLNcHMYzcGhLeL5llQxkupt/W3LtdScxr2pD2GdFvRU3gN+klvo97lkfDrCDg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM7PR10MB3746.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:172::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15; Mon, 11 Nov
 2024 08:34:50 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8158.013; Mon, 11 Nov 2024
 08:34:50 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "hs@denx.de" <hs@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "agust@denx.de" <agust@denx.de>, "festevam@gmail.com"
 <festevam@gmail.com>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "sbabic@denx.de" <sbabic@denx.de>, "Schweizer, Walter"
 <walter.schweizer@siemens.com>, "Leto, Enrico" <enrico.leto@siemens.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: [PATCH v1 07/22] siemens: imx8qxp-capricorn-u-boot.dtsi: fix boot
Thread-Topic: [PATCH v1 07/22] siemens: imx8qxp-capricorn-u-boot.dtsi: fix boot
Thread-Index: AQHbMZ4jpO59JuRDrk2gztNwuW+ANbKxxeeA
Date: Mon, 11 Nov 2024 08:34:50 +0000
Message-ID: <0717eeb0b3bed98b4195542e9495f634162ca08d.camel@siemens.com>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-8-hs@denx.de>
In-Reply-To: <20241108052143.26874-8-hs@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM7PR10MB3746:EE_
x-ms-office365-filtering-correlation-id: a7467965-0bc7-4533-fcb1-08dd022bb589
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OFNGdDhjcy8rcWQ0NCs3ell2ZHhoVXVCTjk5c2ZoT2tIRGVndmVpSHZieGhX?=
 =?utf-8?B?MVlReGpQODFrc0lLZmFydFFtTnFwbmx6cmUzaXdiK2dIWGFsSjhNY2orTTJn?=
 =?utf-8?B?bVNEWWJ5dU1Qa3BEdGNCTnJuSFQwOCtpV2l4Z1B6ekY1c0xpV3dwZnFRM2Rk?=
 =?utf-8?B?RndlV3ZMbkt1OEd2czJNMmdIdXlzVXFRUWJackppT1dEcE5lSUJaVlZZbDZG?=
 =?utf-8?B?em02WXVFWVJrTzlmK1lzMXNLRzBjS3B4S1lUd3QrSlRpV2ZBejlPdWd3SmtZ?=
 =?utf-8?B?KzhXSS9WS2xnL0lwOTBXSk5tWGE3TWtmMkdVak0xR1JkYWUyb2IvWEZzbG05?=
 =?utf-8?B?eCtyNFc3M2VCL1lCdEhEZnJUN0hNMUdweDZZWExDT2FIWFo3V3JBM3ZCdW9R?=
 =?utf-8?B?R2FCa0FFcTc4OVcrNGlGSGJGcEFWbFNtL0FqWjg3azBoRy9YNGtib3dDOVBH?=
 =?utf-8?B?Tnk3QjZtVHdmNEE2Ui93NUtEaDFmRzdQTWhuUGJ2TWEvb1ErUmkxamdHQnhZ?=
 =?utf-8?B?ZCtTa0ZaVFFWdDZVZE5xT29JRTROZDBIN3I2aUlsYjBOeW9uMXpRT3h2ZGlX?=
 =?utf-8?B?SFFaT3l4MUxSc25yK1ZScFh1eHY3YndqcmxpL0Y3bloxMVVoeDR6WDdEZjlK?=
 =?utf-8?B?eXFRaGVsN2JURncyVmxYSlpIL1Z3K2NuTGVuNXZyRlN3MUdxM2JCUzVFcTVO?=
 =?utf-8?B?Z1RCcHo4NXJ1ZW9SRDQ5M1liZzEveGs4UjNwOEZmR2JtWHVUSnRTb291V0JL?=
 =?utf-8?B?V1FNZzkyS1V5TGhoTWJnQVRyZEY1b2pYU1ZsZVZ3Z1ErRVRISmdJelVaR3kv?=
 =?utf-8?B?ek85VFN5OGh2aUYvS2l4ZVZRSU11NzlxVGVsQTVUd0xWNDY5Q3h0WTBHT2s2?=
 =?utf-8?B?OHN1Z09nSjJDOGp0bUZqaEludVdGTzBoQ1R3MTFDdGQyMjFoeWdrYktQUkhO?=
 =?utf-8?B?Z29YRWN4cGdHdzNQbnBnaXh1bkM1MVdDbmc1dTkyK1FTQnJXemFiVU13UHJQ?=
 =?utf-8?B?YkRIMisrcHpDMHh5Vk8vUEFERXhHc3dzcHBWdDRRYWtPVXN3bVRCd1VvVEdW?=
 =?utf-8?B?eGtRVnN2d0s3b1RDNjd6VWUvZUt6SWV0NE5HQ1d2N0NOWXVtalRoS3c4WEh1?=
 =?utf-8?B?b1dxSlBhTy9hVm1DSFF1NHR4SC9BdWFFWWF4d05PNHFjMmJjMmczaVk2MzZ5?=
 =?utf-8?B?bVE4bEpaaUNOeWxWcGpmUnpUbHlSWEpxRU1pZTdQOXo1U2N5MzlBUnJ4V1Fv?=
 =?utf-8?B?dlkrTmhpZnNDbEt3Z04xbjV4WjF1elBLTmFnWm02VWdtRWJyVm82bVNSTk5m?=
 =?utf-8?B?NVFqSGJLTGZyZ0RLVHQrdW0vTHNqRjQwdTZ5M05YeWJjbEQ0ZGx1d2NtM3Fx?=
 =?utf-8?B?bXRaU1BaRmx4NlNZSUxkZVBrbFl5NWtGdG5iS3ZSeVdoMkh5UmtLbkl4Zmhz?=
 =?utf-8?B?UTdObDFhQWxpQ0RTazVzTjdXelRISmUzd3lROGJIZHU3OUcrcUloQTQ5K1Er?=
 =?utf-8?B?TlVteVFERDk5bG9kYjgvaVhVRW54TlZ5alBhZldYMkVwd2poVk5mSC95dzho?=
 =?utf-8?B?QitPUU5Rb1BKMjVIa2V3R2RmZzE3eTFKVWdxUVFQeHNlVmdGYS8xOG5xTitL?=
 =?utf-8?B?dzI5Nnd3MDBDRVBrMWZ1bU04VXJpQ2x1QS9QMnA4eVVCK1hDd0RNRWZkeXJi?=
 =?utf-8?B?TW9IWjUybkt2RHRIYzBHRTJOUGRwQURCK3B2RXVXQUNQQWc5M3BuRklRcDBt?=
 =?utf-8?Q?0Ic0IzEYRNhpS0oWK+HwU6acUyCxuj01CaC1Xcz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1pWZjdnb0FNdkc2YWl0SHlBOGRqT0VKWWF5WHZIT2ZTK01CZnJpZWJFSnlu?=
 =?utf-8?B?ZU41eTFCem9SNDlMeXIzZENwK3VpRzVFVUxTYWJnc0lkTUpWK1UyUHlFamJj?=
 =?utf-8?B?a29CNSs4bGpTek1rS2ZJU3NHRWZQNkdSaXE1d0xtd21RU1ZFcVlab1VQV1c5?=
 =?utf-8?B?eWZYN3JoNG4vd1VQOEJMKzkvRzFFWWsvUWRPYmFiVzExNDQ3RmJrM0pJd0tl?=
 =?utf-8?B?MTg5UnVqdzFkL3dOWFdZZnNqaWxYaG9ERXQ4dEM3UGFrY3hQT0xPUzVXWlhU?=
 =?utf-8?B?YVBkNGc0YVRqbGJldkU3WFU5aDJhUEJDb3hCTkp2b0p0SWRrSTlvTU5jL3g3?=
 =?utf-8?B?ak8vOUF2dTNZdEF1VVB6NVA0M3d0VVUzU3E0V1RudVJhcHNpTERsVkU0R1VH?=
 =?utf-8?B?MnV4MUNrbHlVbHE3NjlNVElHQ2w4YVF3OHM1clI5aXhGNTV4TDErdWtaZCs2?=
 =?utf-8?B?NmhiSUdhTmlVaUhnMzhyMUhhaXd3UVNJdWU3ZU5DTWxIVWRadzMvSGZLSWtT?=
 =?utf-8?B?L3FBb21ISmtOUGE5ZnZkM09pRTV4UkxNVlhFMkM4NTBrTXZmRlozbkI1N2VS?=
 =?utf-8?B?cFJmc1FSM1dqbmhjME12ejhvdlpQVEtsYnR2R2ZPRFRxZGZHS0JmS2E3Q2FF?=
 =?utf-8?B?TU50RWYrOG1yQ1BtOXJhUUU0S1l5czhRRExML0Z1VVdId3BlQWJDRVJVYnlv?=
 =?utf-8?B?TFVlU0tCelU2OHAvaWp5MEgxQm8zOXNtV0w3MHVya1VoYUw0ejJOaFVNdUZi?=
 =?utf-8?B?c2N0WlUyVjduaGhlVUN3ZlhFcllRb0JEblVFT2dYc3hlZEk0WDJhRmVNYitG?=
 =?utf-8?B?WHArK1pUMjc2Wmo2eGhYcWN0UUt2dDhLejdvMWZqSmlKVzZvMmJUZTVVbFVD?=
 =?utf-8?B?TkY4OGcvUE4yV2diayt4NjRGK3RRelhEYzJCTDBNYW1JOXpDQThibFFlUHRX?=
 =?utf-8?B?Z0JHdTdGa2ZLOHkrQTBNNlVSdk5vS2ZVdkVPUEV6NHNNZTFSajM3cTZxNnpo?=
 =?utf-8?B?RFlTcktkMlZsckRYTmVta2tTdWhVek5BdUw4b1pGTkhXMysyM2RqbDBHMnRo?=
 =?utf-8?B?QlljRThCRkl1QmFxaTBoemo2cEN3S2dZcEhIV05LYTloSnNQZnl5NW5tb0FW?=
 =?utf-8?B?OWpDa0ZtOWNJQ25EZ0Ryb3dwcDVoQlhzalNaSVhvUllYVGVzWFUzRUx3Ymt4?=
 =?utf-8?B?K0JOQzJZakJaaDZNZXFtS0NFWXJuYjdwZldoR1VlY2RDOWx6c2ZqMG52b2FT?=
 =?utf-8?B?YjlXeE5KU3U1MTFCQ3RCMFlNdFhwWXFTb0kvcXpGc0ZUQ3ZnYlZKVlRDaU4y?=
 =?utf-8?B?SnRtcHpLOXA0a1dWcHg4WEg4bEZNRXNiWWtZekx2TUdmQmw1RjhPR0dMdW5a?=
 =?utf-8?B?SHJCSXQzcXpKNm81ZlUwalJTOWZFM205bEVZOWQzcjd3UElxZHloZkw0a3Bk?=
 =?utf-8?B?UCs2Skk1MkFDSmZlMzRnTmNtOE45b0xUbGxSOTNLck0yMHFFMitEOURtZUFS?=
 =?utf-8?B?d2N3c0tVeXVHVmwzcWd2MkVWWVBjQjVGbThZeUdSd3l0R0xaeDIwVlMzN1Nu?=
 =?utf-8?B?QkZFdVNFc0pkdTRzeUREcTR0OUl4UjJ4d1cvWVJqZk1mZmtuVXk2MWFjajFR?=
 =?utf-8?B?ZCtra0FMSlZZQUZUZ3JLNzB0NUZXVjVRS2xzQ3MzeGdIa3c4b1ByZnJXT2s4?=
 =?utf-8?B?MDc0SzhDQVFMdWdvUXU0RGpPaTlZQiswMHFPR01rSVlZZjQyQjFSd0hWbHpJ?=
 =?utf-8?B?SEFtZytSbjRhaWZ5a05uM0dweTNWQkF0REtDcUI4VS93QlFsbW9kMFJiY0tP?=
 =?utf-8?B?WUJwT0J5dFFoaHVwdHd3R29meFE0QzcxRSsrTm1YOUo5eUJ5N21mVmJxb21I?=
 =?utf-8?B?RkpocGkyMkhLeXFRTy85UU1JekRadlgwaTFGSlNSVWJCY0VQNjFXZmxJVnNP?=
 =?utf-8?B?OGE2d09YQmVKd1hWa0xuRDFBeW51SjIzVzMwSWpLYUxsbitCRWdMNklFRTlU?=
 =?utf-8?B?cDNWZGNtWXc0Yk80aVp6Z3JrQkNLd1BMbnkvbjBHdUpUbkZXeXpaenUwKzdn?=
 =?utf-8?B?V3p2cVRxUjNZckpteE4zSUdWbGVtcDlPcEd4Wlk2YkZFUXNjcSs3d094TVpY?=
 =?utf-8?B?amc2disraGhPV2kxVW5ENDlnZ3RKeGhFVWhCMmIwcWJSR1RuM29IUTVjSzdh?=
 =?utf-8?Q?yjZP+yzozmwNJCcFjzb+0rc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F40F971A80E4C44693BD06068C17548D@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a7467965-0bc7-4533-fcb1-08dd022bb589
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 08:34:50.8650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YyyXVtGLVykEfMa/CuAnlMzysZ8fHUy/fRNwfQb8OOaeDT7ZZVSfBAL7HgcbIDZUacAW5krGDtKQWmA6BQ23OxYz3VZD3QtY46mPZzDL/W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3746
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

T24gRnJpLCAyMDI0LTExLTA4IGF0IDA2OjIxICswMTAwLCBIZWlrbyBTY2hvY2hlciB3cm90ZToN
Cj4gY3VycmVudCBnZW5lcmF0ZWQgZmxhc2guYmluIGltYWdlIGRvZXMgbm90IGxvbmdlcg0KPiBi
b290IG9uIGN4ZzMgYm9hcmQuDQo+IA0KPiBSZW5hbWUgYm9vdHBoLXByZS1yYW0gdG8gYm9vdHBo
LWFsbCBzbyBmbGFzaC5iaW4NCj4gYm9vdHMgYWdhaW4hDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBI
ZWlrbyBTY2hvY2hlciA8aHNAZGVueC5kZT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBTdmVy
ZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiANCj4gwqBh
cmNoL2FybS9kdHMvaW14OC1jYXByaWNvcm4tdS1ib290LmR0c2kgfCA2NSArKysrKysrKysrKyst
LS0tLS0tLS0tLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDMzIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0cy9pbXg4LWNhcHJpY29y
bi11LWJvb3QuZHRzaSBiL2FyY2gvYXJtL2R0cy9pbXg4LWNhcHJpY29ybi11LWJvb3QuZHRzaQ0K
PiBpbmRleCBjYmE1NjE4OGY4Ni4uYTEwNThhMDlhOWEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJt
L2R0cy9pbXg4LWNhcHJpY29ybi11LWJvb3QuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9kdHMvaW14
OC1jYXByaWNvcm4tdS1ib290LmR0c2kNCj4gQEAgLTYsMTMwICs2LDEyOSBAQA0KPiDCoCNpbmNs
dWRlICJpbXg4cXhwLXUtYm9vdC5kdHNpIg0KPiDCoA0KPiDCoCZ7L2lteDhxeC1wbX0gew0KPiAt
DQo+IC0JYm9vdHBoLXByZS1yYW07DQo+ICsJYm9vdHBoLWFsbDsNCj4gwqB9Ow0KPiDCoA0KPiDC
oCZtdSB7DQo+IC0JYm9vdHBoLXByZS1yYW07DQo+ICsJYm9vdHBoLWFsbDsNCj4gwqB9Ow0KPiDC
oA0KPiDCoCZjbGsgew0KPiAtCWJvb3RwaC1wcmUtcmFtOw0KPiArCWJvb3RwaC1hbGw7DQo+IMKg
fTsNCj4gwqANCj4gwqAmaW9tdXhjIHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgt
YWxsOw0KPiDCoH07DQo+IMKgDQo+IMKgJnBkX2xzaW8gew0KPiAtCWJvb3RwaC1wcmUtcmFtOw0K
PiArCWJvb3RwaC1hbGw7DQo+IMKgfTsNCj4gwqANCj4gwqAmcGRfbHNpb19ncGlvMCB7DQo+IC0J
Ym9vdHBoLXByZS1yYW07DQo+ICsJYm9vdHBoLWFsbDsNCj4gwqB9Ow0KPiDCoA0KPiDCoCZwZF9s
c2lvX2dwaW8xIHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0KPiDCoH07
DQo+IMKgDQo+IMKgJnBkX2xzaW9fZ3BpbzIgew0KPiAtCWJvb3RwaC1wcmUtcmFtOw0KPiArCWJv
b3RwaC1hbGw7DQo+IMKgfTsNCj4gwqANCj4gwqAmcGRfbHNpb19ncGlvMyB7DQo+IC0JYm9vdHBo
LXByZS1yYW07DQo+ICsJYm9vdHBoLWFsbDsNCj4gwqB9Ow0KPiDCoA0KPiDCoCZwZF9sc2lvX2dw
aW80IHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0KPiDCoH07DQo+IMKg
DQo+IMKgJnBkX2xzaW9fZ3BpbzUgew0KPiAtCWJvb3RwaC1wcmUtcmFtOw0KPiArCWJvb3RwaC1h
bGw7DQo+IMKgfTsNCj4gwqANCj4gwqAmcGRfbHNpb19ncGlvNiB7DQo+IC0JYm9vdHBoLXByZS1y
YW07DQo+ICsJYm9vdHBoLWFsbDsNCj4gwqB9Ow0KPiDCoA0KPiDCoCZwZF9sc2lvX2dwaW83IHsN
Cj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0KPiDCoH07DQo+IMKgDQo+IMKg
JnBkX2RtYSB7DQo+IC0JYm9vdHBoLXByZS1yYW07DQo+ICsJYm9vdHBoLWFsbDsNCj4gwqB9Ow0K
PiDCoA0KPiDCoCZwZF9kbWFfbHB1YXJ0MCB7DQo+IC0JYm9vdHBoLXByZS1yYW07DQo+ICsJYm9v
dHBoLWFsbDsNCj4gwqB9Ow0KPiDCoA0KPiDCoCZwZF9kbWFfbHB1YXJ0MiB7DQo+IC0JYm9vdHBo
LXByZS1yYW07DQo+ICsJYm9vdHBoLWFsbDsNCj4gwqB9Ow0KPiDCoA0KPiDCoCZwZF9jb25uIHsN
Cj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0KPiDCoH07DQo+IMKgDQo+IMKg
JnBkX2Nvbm5fc2RjaDAgew0KPiAtCWJvb3RwaC1wcmUtcmFtOw0KPiArCWJvb3RwaC1hbGw7DQo+
IMKgfTsNCj4gwqANCj4gwqAmcGRfY29ubl9zZGNoMSB7DQo+IC0JYm9vdHBoLXByZS1yYW07DQo+
ICsJYm9vdHBoLWFsbDsNCj4gwqB9Ow0KPiDCoA0KPiDCoCZwZF9jb25uX3NkY2gyIHsNCj4gLQli
b290cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0KPiDCoH07DQo+IMKgDQo+IMKgJmdwaW8w
IHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0KPiDCoH07DQo+IMKgDQo+
IMKgJmdwaW8xIHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0KPiDCoH07
DQo+IMKgDQo+IMKgJmdwaW8yIHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxs
Ow0KPiDCoH07DQo+IMKgDQo+IMKgJmdwaW8zIHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwli
b290cGgtYWxsOw0KPiDCoH07DQo+IMKgDQo+IMKgJmdwaW80IHsNCj4gLQlib290cGgtcHJlLXJh
bTsNCj4gKwlib290cGgtYWxsOw0KPiDCoH07DQo+IMKgDQo+IMKgJmdwaW81IHsNCj4gLQlib290
cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0KPiDCoH07DQo+IMKgDQo+IMKgJmdwaW82IHsN
Cj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0KPiDCoH07DQo+IMKgDQo+IMKg
JmdwaW83IHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0KPiDCoH07DQo+
IMKgDQo+IMKgJmxwdWFydDAgew0KPiAtCWJvb3RwaC1wcmUtcmFtOw0KPiArCWJvb3RwaC1hbGw7
DQo+IMKgfTsNCj4gwqANCj4gwqAmbHB1YXJ0MiB7DQo+IC0JYm9vdHBoLXByZS1yYW07DQo+ICsJ
Ym9vdHBoLWFsbDsNCj4gwqB9Ow0KPiDCoA0KPiDCoCZ1c2RoYzEgew0KPiAtCWJvb3RwaC1wcmUt
cmFtOw0KPiArCWJvb3RwaC1hbGw7DQo+IMKgfTsNCj4gwqANCj4gwqAmdXNkaGMyIHsNCj4gLQli
b290cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0KPiDCoH07DQoNCi0tIA0KQWxleGFuZGVy
IFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
