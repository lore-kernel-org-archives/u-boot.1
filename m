Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD51AC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 10:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12161884A9;
	Mon, 10 Jun 2024 12:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="x2N1pqvK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7AFF884B5; Mon, 10 Jun 2024 12:10:52 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 226BC884A9
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 12:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cj0PLeh5Vi1RcBNeZPevoN0voBjI+8YyRxSovExednmwcVC9zwhjH359r0fKEWDtAjkttUVCabM0OApPkRBUAqr9QQ4k5LcUqhJcV4ZV17qYptJ7zDTUgfIGf+7xrrakBojlwX2x1epbgT1Oh/i8hsnh8YyYz3Ew5Y2iuDqm5DUR00eXiipRdUztqlaNJh9UU2pAzqFEGI8042I3lhBQJjsgbZrOTuxMpigKEeFNlMBSHZDMIsPCQJOC7yi1DmY4Q6/IqfS9hrIZ6C4h9JDN6XWWpqPqR08XbuzGU0LC1uYml1UDXM1+pyfz2ui59iGNd1wCvDKouERzYnmNO5Gkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gYAJZ6s0AKFuX6dxWEmE2ueClr3L8+5TAYQyoXyPzU=;
 b=H494dzSzfjZE7N3NvzlAir80XxxszcOqtUfeb4IqaaBwxtMcFJpDmfdqmihze0tMd9eLu8GHEXAQhOi3nYI831be2ZMJUErAHyLWYbMfr4vTBNh/p11rww8FpfCsdDifKRTJCIk+Zn+yXhEZgzIoIhA3UMxACtr+04uskRgPkfRLxYuFh4iqNmZR6ulaLpxnz53voJ/XpAenRSaKM6X4PZ43lgBgIx1457Ore+w/IfOzrEnY2lgtw7zy20fGT3e2sRy36fwxTIG8Znz5OfgoRQn5Sm6EWlMGJVNnbFk6l7yWjH/Dw9pKwinsqmf/TGV+ou+cnaIIYgUHbx3cEjGKoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gYAJZ6s0AKFuX6dxWEmE2ueClr3L8+5TAYQyoXyPzU=;
 b=x2N1pqvKwmq72GkC3nKV5LQNAHuLLLrQ6/+/gMkF4ZXjwA5xh+s/WgRpTLa4pQvAI0my1GKrfjAELadoQeiaZhwTRvr+LRwSWlIdUmErRvrAr19JW+rQNKlhljzBvyLEif7h55HQBfNdtMLYYI1CpoyVA/l9DXw98fK3w2pOI65vH85dmDkk0XN/0eNSBN1PU2SZEGUUh94lUyQXX2atobAL0spB/Sq9/1+9pVS+l6vapvEuci3ZmWyQJLLOJ5d01IHUOMwLf5FydIoUKJ0AjEtbsz4ePM0aGlNe42eKfSrIim66SdIfpwz2u4orgMObVCYcGdry6fhO3QYbGn+w5g==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB5595.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 10:10:48 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 10:10:48 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>, "nm@ti.com"
 <nm@ti.com>, "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "lukma@denx.de" <lukma@denx.de>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH 6/6] usb: dwc3: gadget: Convert epautoconf workaround to
 match_ep callback
Thread-Topic: [PATCH 6/6] usb: dwc3: gadget: Convert epautoconf workaround to
 match_ep callback
Thread-Index: AQHaurTvrEa2e9NpwEKYYys710hyjLHAx4KA
Date: Mon, 10 Jun 2024 10:10:48 +0000
Message-ID: <82ab92847b82428b9becc92a847a1300c0c99022.camel@siemens.com>
References: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
 <20240609213449.194762-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240609213449.194762-6-marek.vasut+renesas@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB5595:EE_
x-ms-office365-filtering-correlation-id: 921d842f-36aa-4c03-7747-08dc89359981
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Q0Y3Z3lpTlovZUdmYTc4aFdVL2N6VWprTVNqakFBbEdKQTBlMUJ5SzBtb0Er?=
 =?utf-8?B?L2Exa0d2b1k1RmtMMDFOcjRTVzlCdFgyUG5nSEVjemJHRStrN08rMlozQTVI?=
 =?utf-8?B?MEF2YUUwRHA3OS80TXREcGpleUVFc0ZGZklaWVlpSkc0ZkJPVUc4MWNET3Rz?=
 =?utf-8?B?U3Q5a01rZE9FZE1uZGVGbTYxc2pzdEkzNnhYOHo5bmRSbEhpSUI5emVWMWNH?=
 =?utf-8?B?ekxqRjFNSm5tVzZ3MEVwaHFYQjRGRlRpeWdRbTJlWnBWa3BsNS9YWnVZc1Nv?=
 =?utf-8?B?SXFqSlFFaUZZOFkwOUhYR3pIYkljd0FUNGtHclJiV2VmQXhZRG1SOUpmT0Vp?=
 =?utf-8?B?Z05mbENZY09Wcytwb0lUMFk0RnI3QWdvNjJJVFZYYklLcEw1U1JDNTU3VGha?=
 =?utf-8?B?bmg4aVNvMTZsM1R0U2RuMzNiM1VmM1ZtTFhvU0FTL25tOXh3YUxwZWExbms5?=
 =?utf-8?B?cTJXN0xUdEJqL3lTM2N6K21SZFl5bElQYXBNYitKQUw0THd3U05nNGthbndI?=
 =?utf-8?B?eThJdmkvSE9UZUYzZjl6bDhwN0l5QXJyekVld3dIam8wL25KK0t1WEM4YlY1?=
 =?utf-8?B?M3Q3QkJNd01hbzZ1cHlVYnhjdVd4VTVwRzdVTzRDWEkzbCtaL0FTNnZsMTBy?=
 =?utf-8?B?MXcybG1SQUxOL1Z6bWlWYkRQcTl4RXhFQm1JYVQ5bmhxY1Z1UlhmenhvSVZJ?=
 =?utf-8?B?TGxFbGplN0NhN1UwbWpyaFpvM20zUXZQWndnWDFCdWd4alJKT05zaEN0eFA1?=
 =?utf-8?B?VFlpSkcxVkdrNkpzNXQ3WTM4OEdHK1ozSDlsYThHbWsyVUtObEhDRGczUU42?=
 =?utf-8?B?dnBaMHFMZDNwdmtvQ2hkUStKQnMyNVhvRnh2WlQyTjNWcDVxbUN6SStqeGRu?=
 =?utf-8?B?TlRHUVdUZ2k3RCtmcjZra0toMWJ2czh6TXNVNGdWelArVjJwZk1qVEJiUHpT?=
 =?utf-8?B?WGZncXlsbDV5bFFTdVJ0aFJZYjVrK3h2UjRRRWh6REdjbTBIaU0yWmNuc1dJ?=
 =?utf-8?B?dDlJSG9wOFlTMlVLMWltNHVBUDFwYXAvZUY2ZUk2NnRHd1pKaU1kanp6SjBn?=
 =?utf-8?B?L1lLcndwa0lCR1pLRjV4Y0V3Qk9Zd0p4QmZ3cFFTVnMwMndBSE56VklFMyts?=
 =?utf-8?B?RFc2dnV2UVNNL005U1kyOUordVVkeGwzQ2FiTlBacncreFdOdlFhdm9WYXJp?=
 =?utf-8?B?cXlmUlppUlF3b0NDR1k3czNoN24zbXZISkxVcjU3NklxQm9MQ25JQWwxYUNC?=
 =?utf-8?B?ajAyT0ZpUDZmVVBGbC92U2psRXlaS25SdmlsTm96eGZOaHJkK2Z5WE5LTkZs?=
 =?utf-8?B?TzVtWm1vY0MzWEFPYUwwZjZsZEp5QjV2eGFpanlONGNHWGJidUlpV3JLSXQz?=
 =?utf-8?B?VlhHaGplc3g5Q1BvbkFVd2RxZDhIQ21jTjd4YnZ6QytsN2t6MXg3MTd3MkV6?=
 =?utf-8?B?eVoxVTlOLzRiQTJsZ0kyRDYvei9PZ0NoWDRxT1YxcDhDMDgwakU5WHpSc2hR?=
 =?utf-8?B?cVJwanhld0hjc1BzbnJRVCswc21ILzIxZFE3N01kRS9FWGZyakd1ZXVKUkYw?=
 =?utf-8?B?Tjlpei9kVGxVQUltbEVZUkNYQjBOY3d5dkdWOG1Pcll1SmVVK2tuMktJdUYr?=
 =?utf-8?B?Zko2L1oraTBQcC82QWN2N3hOWFpMQjhGbkZ6cEREdHNwYzA0N2NablpLenpt?=
 =?utf-8?B?dG0xRHZ0ZnZRRzZzRFJNTzhvMlBZYmkzeVBleHJKYjJ1Y2pCMWU1QnZIcTNP?=
 =?utf-8?Q?w2cMHPtPC9k+tZzbRQL4ZkCLg9ClWl/0x9OjVGA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0JNUExFaTF1QS9aMkZWeWlLMkRVUjFSN1A3UzFxblNCOVUwOWk2N09KazE2?=
 =?utf-8?B?RG9Scm1sajBtUHN0dGRaQTRkemdFVkFFT2Rxb01wSmZXRVg5T1lMdm1nOEtV?=
 =?utf-8?B?em5pemlRTHJaNFdRSVdQQkJGT0xpMnhuUjFkQVRUbHV6Z3ZzWkNiSWt1M2Zz?=
 =?utf-8?B?cmpHMU1Dc3JiMWttN0VSQU5ZVndVVUhWREttSW9YY3dDcEhiSzlVblFJdE1C?=
 =?utf-8?B?bDR6Tyt4UERGaElUZ1V6eEZEdzZCV3NYRkNZZkc4SStmdWgwTERDY202UFpM?=
 =?utf-8?B?N0tKSGFWazdOb2FSdHpoeDdBRzgwUE9nUXAvTG9jNldGdmJsa2FLYXQxMG9K?=
 =?utf-8?B?YWJoN0d3Q29IQk1vYVUvS2lwNW00Zmt5OTNjaFQ0S2xHbFZLeFMzY3FPQWZk?=
 =?utf-8?B?M3B4QWdpWk5UWmlxdWlDelAxazJLWHRiVnhmN3NVMWtJN1ZRWlhaekZuazJL?=
 =?utf-8?B?Nk5Cc0ZPZnEyaDJQUUFpS004dTMzdDRGN3dwSnAyV0RuWGJLOXlPN1B1NzZJ?=
 =?utf-8?B?ZllTcjNMRHo1VEdLMEd2RFBKaEF1dEQ1WXpJWU5rUS9xT1g4SExDMDMyOXlr?=
 =?utf-8?B?M1dZKzQ2cXZZckxzS1AxWnRuaFNCV2Mvam1qaXRqR0R3N2x6ZkZhamFxbTZ1?=
 =?utf-8?B?ekViZDZBQ2ZBR2pZMG01eUZHYzBSZEEwcG9sU21GN2pIdWdyR01YSnlDMjYr?=
 =?utf-8?B?bnJLMzZsemhoRW55L04yQS9oaVRyZmx2OWN2ZlVZei84UmpRNmhMTXBSclNq?=
 =?utf-8?B?Z3k3UlQwdUtVbnYyOEZmU1p1eldBbEF1aS9BTGprS1pvelhyRXR1WTEvZm01?=
 =?utf-8?B?ZkY5Mi9iM3BrbTc2YklPbXhhemV2YWsycE1hN001SVVhNFlKU09veXJ0RHhV?=
 =?utf-8?B?UVAvczVtbXFDRGZnc0JwK2lSSGROb01Mdk1HaDBYV0NydnpFd2gyeE9KSm1G?=
 =?utf-8?B?ME9rOUpDbitmRlJhcGRadzIxRkY3VzhHYVZVTjhVamg3WDZBbEVRclpUbWpB?=
 =?utf-8?B?aUxYUW5NRWUzZ3JjVTRMS0crbm55cTJWdW5ib3Y0OFpzbEcxcWZZWkFDN1lt?=
 =?utf-8?B?VWwwMFlvSjNNS0NyK0hYK2owbWdwaitPcFVoRmFMcTl4K1JETWhEb24zaWNr?=
 =?utf-8?B?UkJ6U3lNYUZZNGxteVZWYkhtZ1QvT3N2MGdTQXdXMmRnWkN5eUR3VVRMZURN?=
 =?utf-8?B?VWVsS3EyK0ZGWlNlNTlZWnp0N0s2dnpFYkpuR09lY2FWdTBMYkZ4U2VCaXRo?=
 =?utf-8?B?R0c5NjZVUFNnbFFaNzY5K3EwMEYyTHlZeDJ5VjFoMlN5RmpjOWk4aHZmREc4?=
 =?utf-8?B?OFFwVngyTFFoNXZ6NVgycE82YVd0SEh6RHBVTUZwUkppOWtNTjRFM3I1NjZJ?=
 =?utf-8?B?dlNudkFpSktWUXQrMFVFQ0Y1L1B4VzdweU1UcUUwcWRrT3J0Ly9ZMWRqVlJF?=
 =?utf-8?B?cUUvb3Z3RjRDSjFoR0hBODJwTlo2eldVanhhRDcvRlN6UHEyOWFBajRHbjFB?=
 =?utf-8?B?ZkQzbGhCaW14T0RvMFVZK2IxekxnL3d4ZFliZHZMa0FnRndqZFB3ZHoxcndj?=
 =?utf-8?B?a1E5THdvM3lMZHJpVGpXNGk1ZndWbUtmekhHa1EwTnI2RlJWZFBDd2d1RlNm?=
 =?utf-8?B?YjBPa3orY0FLTEFGMjdjaHBhZGY4ajVMb3d0TXB1dVAzVHlUOUN6VGdnbE9j?=
 =?utf-8?B?Y29JOG1URXJjd0M4Zm1YZlJEVFZ6RDIyTDJ1L3c2QnBNNHZRc2owa283U0FS?=
 =?utf-8?B?bFBueUZ1MmRhNmMvcjhJU0ExazF5MGFtYm1nNnAzRHV0c0ZSaGxzKzVsa1Rw?=
 =?utf-8?B?TUYwaGJ6OW9IVGlzSHZsdGMxOUNULzVmM2FhK2JIZnFIcG9JdnNQK1Z3ckFX?=
 =?utf-8?B?SStzcnBKUHV0M3l1SkduQ0JYY2Q4WG5VVnNkVmw1MkVtdEhsamxPb3Nsb2k2?=
 =?utf-8?B?d3pSWkJOS2kreHBBUEhidlUwWW41ZUc5cW9GOUhzUXJCL2ZOazllZ0VtOEJz?=
 =?utf-8?B?TTRzZytMRU4vTVg2a0dMMEh0MXdQVG11MlM4MFBrSlJNNVVIMmw1UWlXTlJu?=
 =?utf-8?B?NncxcXJySlYwWmJ0bTl3QmhWSFdjajFLdU1NTlgyc1VUOWFqWkxZQmFzL2VK?=
 =?utf-8?B?ZEk3Rk9XaE9LNVYzdG9KMmtTYXI5UDYzU2h2T2NxRHdIVENxNjQ5MlBoR2xm?=
 =?utf-8?Q?K0qE4PKEe3+9aCTmNqgMQtw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22B44B2B57E4094C8CB0349778E13EE0@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 921d842f-36aa-4c03-7747-08dc89359981
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 10:10:48.1346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sT/VOqtzH7I+ep1b1djzgRy2FiR0lwNuyKH88vNL63Avm8OK2o/+AF9gZhFRF3y2TvAmTy0GqW+AZitY/IBAIUekdtV5hEYZDhRB93S+gOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5595
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

SGVsbG8gTWFyZWshDQoNCk9uIFN1biwgMjAyNC0wNi0wOSBhdCAyMzozMiArMDIwMCwgTWFyZWsg
VmFzdXQgd3JvdGU6DQo+IFVzZSB0aGUgLm1hdGNoX2VwKCkgY2FsbGJhY2sgaW5zdGVhZCBvZiB3
b3JrYXJvdW5kIGluIGNvcmUgY29kZS4NCj4gUmVwbGFjZSBkZXNjcmlwdG9yIHBhcnNpbmcgd2l0
aCBjaDkgbWFjcm9zIHdpdGggdGhlIHNhbWUgZWZmZWN0Lg0KPiBEcm9wIHRoZSBTUEwgc3BlY2lm
aWMgYmVoYXZpb3IsIGl0IGlzIHVuY2xlYXIgd2h5IFNQTCBzaG91bGQgZXZlbg0KPiBiZSBzcGVj
aWFsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0K3JlbmVz
YXNAbWFpbGJveC5vcmc+DQoNCkkndmUgdGVzdGVkIHRoZSB3aG9sZSBzZXJpZXMgb24gVEkgQU02
MiwgYm9vdGluZyBvdmVyIFVTQiBERlUNCihib3RoIFNQTCBhbmQgVS1Cb290IHByb3BlciksIGxv
b2tzIGdvb2Q6DQoNClRlc3RlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3Zl
cmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IENjOiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFs
ZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCj4gQ2M6IEZlbGlwZSBCYWxiaSA8ZmVsaXBl
LmJhbGJpQGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IEx1a2FzeiBNYWpld3NraSA8bHVrbWFAZGVu
eC5kZT4NCj4gQ2M6IE1hdHRpanMgS29ycGVyc2hvZWsgPG1rb3JwZXJzaG9la0BiYXlsaWJyZS5j
b20+DQo+IENjOiBOaXNoYW50aCBNZW5vbiA8bm1AdGkuY29tPg0KPiBDYzogU2ltb24gR2xhc3Mg
PHNqZ0BjaHJvbWl1bS5vcmc+DQo+IENjOiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5v
cHN5cy5jb20+DQo+IENjOiBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPg0KPiBDYzogdS1i
b290QGxpc3RzLmRlbnguZGUNCj4gLS0tDQo+IMKgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuY8Kg
wqDCoMKgwqDCoCB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrDQo+IMKgZHJpdmVycy91c2Iv
Z2FkZ2V0L2VwYXV0b2NvbmYuYyB8IDQ2ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgNDUgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggZmFiMzI1NzU2NDcuLjNlZjJmMDE2YTYwIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTE2MDYsNiArMTYwNiwzOCBAQCBzdGF0aWMgaW50IGR3YzNf
Z2FkZ2V0X3N0b3Aoc3RydWN0IHVzYl9nYWRnZXQgKmcpDQo+IMKgCXJldHVybiAwOw0KPiDCoH0N
Cj4gwqANCj4gK3N0YXRpYyBzdHJ1Y3QgdXNiX2VwICpkd2MzX2ZpbmRfZXAoc3RydWN0IHVzYl9n
YWRnZXQgKmdhZGdldCwgY29uc3QgY2hhciAqbmFtZSkNCj4gK3sNCj4gKwlzdHJ1Y3QgdXNiX2Vw
ICplcDsNCj4gKw0KPiArCWxpc3RfZm9yX2VhY2hfZW50cnkoZXAsICZnYWRnZXQtPmVwX2xpc3Qs
IGVwX2xpc3QpDQo+ICsJCWlmICghc3RyY21wKGVwLT5uYW1lLCBuYW1lKSkNCj4gKwkJCXJldHVy
biBlcDsNCj4gKw0KPiArCXJldHVybiBOVUxMOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgc3RydWN0
DQo+ICt1c2JfZXAgKmR3YzNfZ2FkZ2V0X21hdGNoX2VwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRn
ZXQsDQo+ICsJCQnCoMKgwqDCoCBzdHJ1Y3QgdXNiX2VuZHBvaW50X2Rlc2NyaXB0b3IgKmRlc2Ms
DQo+ICsJCQnCoMKgwqDCoCBzdHJ1Y3QgdXNiX3NzX2VwX2NvbXBfZGVzY3JpcHRvciAqY29tcF9k
ZXNjKQ0KPiArew0KPiArCS8qDQo+ICsJICogRmlyc3QgdHJ5IHN0YW5kYXJkLCBjb21tb24gY29u
ZmlndXJhdGlvbjogZXAxaW4tYnVsaywNCj4gKwkgKiBlcDJvdXQtYnVsaywgZXAzaW4taW50IHRv
IG1hdGNoIG90aGVyIHVkYyBkcml2ZXJzIHRvIGF2b2lkDQo+ICsJICogY29uZnVzaW9uIGluIGFs
cmVhZHkgZGVwbG95ZWQgc29mdHdhcmUgKGVuZHBvaW50IG51bWJlcnMNCj4gKwkgKiBoYXJkY29k
ZWQgaW4gdXNlcnNwYWNlIHNvZnR3YXJlL2RyaXZlcnMpDQo+ICsJICovDQo+ICsJaWYgKHVzYl9l
bmRwb2ludF9pc19idWxrX2luKGRlc2MpKQ0KPiArCQlyZXR1cm4gZHdjM19maW5kX2VwKGdhZGdl
dCwgImVwMWluIik7DQo+ICsJaWYgKHVzYl9lbmRwb2ludF9pc19idWxrX291dChkZXNjKSkNCj4g
KwkJcmV0dXJuIGR3YzNfZmluZF9lcChnYWRnZXQsICJlcDJvdXQiKTsNCj4gKwlpZiAodXNiX2Vu
ZHBvaW50X2lzX2ludF9pbihkZXNjKSkNCj4gKwkJcmV0dXJuIGR3YzNfZmluZF9lcChnYWRnZXQs
ICJlcDNpbiIpOw0KPiArDQo+ICsJcmV0dXJuIE5VTEw7DQo+ICt9DQo+ICsNCj4gwqBzdGF0aWMg
Y29uc3Qgc3RydWN0IHVzYl9nYWRnZXRfb3BzIGR3YzNfZ2FkZ2V0X29wcyA9IHsNCj4gwqAJLmdl
dF9mcmFtZQkJPSBkd2MzX2dhZGdldF9nZXRfZnJhbWUsDQo+IMKgCS53YWtldXAJCQk9IGR3YzNf
Z2FkZ2V0X3dha2V1cCwNCj4gQEAgLTE2MTMsNiArMTY0NSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgdXNiX2dhZGdldF9vcHMgZHdjM19nYWRnZXRfb3BzID0gew0KPiDCoAkucHVsbHVwCQkJPSBk
d2MzX2dhZGdldF9wdWxsdXAsDQo+IMKgCS51ZGNfc3RhcnQJCT0gZHdjM19nYWRnZXRfc3RhcnQs
DQo+IMKgCS51ZGNfc3RvcAkJPSBkd2MzX2dhZGdldF9zdG9wLA0KPiArCS5tYXRjaF9lcAkJPSBk
d2MzX2dhZGdldF9tYXRjaF9lcCwNCj4gwqB9Ow0KPiDCoA0KPiDCoC8qIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tICovDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZXBhdXRvY29uZi5jIGIv
ZHJpdmVycy91c2IvZ2FkZ2V0L2VwYXV0b2NvbmYuYw0KPiBpbmRleCA2NjU5OWNlOGVmYS4uYTRk
YTRmNzJkZTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9lcGF1dG9jb25mLmMN
Cj4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2VwYXV0b2NvbmYuYw0KPiBAQCAtMTY2LDE4ICsx
NjYsNiBAQCBzdGF0aWMgaW50IGVwX21hdGNoZXMoDQo+IMKgCXJldHVybiAxOw0KPiDCoH0NCj4g
wqANCj4gLXN0YXRpYyBzdHJ1Y3QgdXNiX2VwICoNCj4gLWZpbmRfZXAoc3RydWN0IHVzYl9nYWRn
ZXQgKmdhZGdldCwgY29uc3QgY2hhciAqbmFtZSkNCj4gLXsNCj4gLQlzdHJ1Y3QgdXNiX2VwCSpl
cDsNCj4gLQ0KPiAtCWxpc3RfZm9yX2VhY2hfZW50cnkoZXAsICZnYWRnZXQtPmVwX2xpc3QsIGVw
X2xpc3QpIHsNCj4gLQkJaWYgKDAgPT0gc3RyY21wKGVwLT5uYW1lLCBuYW1lKSkNCj4gLQkJCXJl
dHVybiBlcDsNCj4gLQl9DQo+IC0JcmV0dXJuIE5VTEw7DQo+IC19DQo+IC0NCj4gwqAvKioNCj4g
wqAgKiB1c2JfZXBfYXV0b2NvbmZpZyAtIGNob29zZSBhbiBlbmRwb2ludCBtYXRjaGluZyB0aGUg
ZGVzY3JpcHRvcg0KPiDCoCAqIEBnYWRnZXQ6IFRoZSBkZXZpY2UgdG8gd2hpY2ggdGhlIGVuZHBv
aW50IG11c3QgYmVsb25nLg0KPiBAQCAtMjEzLDM5ICsyMDEsNyBAQCBzdHJ1Y3QgdXNiX2VwICp1
c2JfZXBfYXV0b2NvbmZpZygNCj4gwqAJc3RydWN0IHVzYl9lbmRwb2ludF9kZXNjcmlwdG9yCSpk
ZXNjDQo+IMKgKQ0KPiDCoHsNCj4gLQlzdHJ1Y3QgdXNiX2VwCSplcCA9IE5VTEw7DQo+IC0JdTgJ
CXR5cGU7DQo+IC0NCj4gLQl0eXBlID0gZGVzYy0+Ym1BdHRyaWJ1dGVzICYgVVNCX0VORFBPSU5U
X1hGRVJUWVBFX01BU0s7DQo+IC0NCj4gLQkvKiBGaXJzdCwgYXBwbHkgY2hpcC1zcGVjaWZpYyAi
YmVzdCB1c2FnZSIga25vd2xlZGdlLg0KPiAtCSAqIFRoaXMgbWlnaHQgbWFrZSBhIGdvb2QgdXNi
X2dhZGdldF9vcHMgaG9vayAuLi4NCj4gLQkgKi8NCj4gLQlpZiAoIUlTX0VOQUJMRUQoQ09ORklH
X1NQTF9CVUlMRCkgJiYNCj4gLQnCoMKgwqAgSVNfRU5BQkxFRChDT05GSUdfVVNCX0RXQzNfR0FE
R0VUKSAmJg0KPiAtCcKgwqDCoCAhc3RyY21wKCJkd2MzLWdhZGdldCIsIGdhZGdldC0+bmFtZSkp
IHsNCj4gLQkJY29uc3QgY2hhciAqbmFtZSA9IE5VTEw7DQo+IC0JCS8qDQo+IC0JCSAqIEZpcnN0
IHRyeSBzdGFuZGFyZCwgY29tbW9uIGNvbmZpZ3VyYXRpb246IGVwMWluLWJ1bGssDQo+IC0JCSAq
IGVwMm91dC1idWxrLCBlcDNpbi1pbnQgdG8gbWF0Y2ggb3RoZXIgdWRjIGRyaXZlcnMgdG8gYXZv
aWQNCj4gLQkJICogY29uZnVzaW9uIGluIGFscmVhZHkgZGVwbG95ZWQgc29mdHdhcmUgKGVuZHBv
aW50IG51bWJlcnMNCj4gLQkJICogaGFyZGNvZGVkIGluIHVzZXJzcGFjZSBzb2Z0d2FyZS9kcml2
ZXJzKQ0KPiAtCQkgKi8NCj4gLQkJaWYgKChkZXNjLT5iRW5kcG9pbnRBZGRyZXNzICYgVVNCX0RJ
Ul9JTikgJiYNCj4gLQkJwqDCoMKgIHR5cGUgPT0gVVNCX0VORFBPSU5UX1hGRVJfQlVMSykNCj4g
LQkJCW5hbWUgPSAiZXAxaW4iOw0KPiAtCQllbHNlIGlmICgoZGVzYy0+YkVuZHBvaW50QWRkcmVz
cyAmIFVTQl9ESVJfSU4pID09IDAgJiYNCj4gLQkJCSB0eXBlID09IFVTQl9FTkRQT0lOVF9YRkVS
X0JVTEspDQo+IC0JCQluYW1lID0gImVwMm91dCI7DQo+IC0JCWVsc2UgaWYgKChkZXNjLT5iRW5k
cG9pbnRBZGRyZXNzICYgVVNCX0RJUl9JTikgJiYNCj4gLQkJCSB0eXBlID09IFVTQl9FTkRQT0lO
VF9YRkVSX0lOVCkNCj4gLQkJCW5hbWUgPSAiZXAzaW4iOw0KPiAtDQo+IC0JCWlmIChuYW1lKQ0K
PiAtCQkJZXAgPSBmaW5kX2VwKGdhZGdldCwgbmFtZSk7DQo+IC0JCWlmIChlcCAmJiBlcF9tYXRj
aGVzKGdhZGdldCwgZXAsIGRlc2MpKQ0KPiAtCQkJcmV0dXJuIGVwOw0KPiAtCX0NCj4gKwlzdHJ1
Y3QgdXNiX2VwICplcDsNCj4gwqANCj4gwqAJaWYgKGdhZGdldC0+b3BzLT5tYXRjaF9lcCkgew0K
PiDCoAkJZXAgPSBnYWRnZXQtPm9wcy0+bWF0Y2hfZXAoZ2FkZ2V0LCBkZXNjLCBOVUxMKTsNCg0K
LS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
