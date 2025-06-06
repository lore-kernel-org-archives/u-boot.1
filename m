Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB71C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 10:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C76AD81FEE;
	Fri,  6 Jun 2025 12:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="jsxxt/96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF8BD828F8; Fri,  6 Jun 2025 12:03:59 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::711])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B077E803DF
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 12:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dj/6ReoYo60ZVxD6MjIMig2F6FafCQi69r+qX5H8I1Skb8NCPh0UayMwbZLus/mlLsEGSydq5YSMWBGtww8RHs4mWR9BMPUvmPYwrUS5QYwVs3aG7fvPd8HsfA4reDpTlHM2F/3qLU2EjCWs3A+lSxMRAiU04rGVwXOxaPnzI8uqDFchbJq9ky7csdGfQ4BvA/mjHHs4uJSkUDdpLKYW4lHYvvlP10K8iPpgbKENsMsNKg86/zUgSEYFd2I9ngDtU6GAQ1bbaNmx/84iWCN7XGh4WqHldlI9QB23r55zsU7b/s86tQ3U3J3tqIHi/TJFNCxLA/3grgMQzitkhnNDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fc70+1zlAw4IWweXhpK5y9os9ghbHRL1VY6PHq/NeSw=;
 b=VJ+rjVmQS8ued9GxxcYMdkZzaFlgtJ9oAzsZbUolFX1/fKkX6yOwqUxqRSf1hIj3H2PoMBBGlj29/TS8i/n1WlTqQr0dFxzkUcxjecyhkwY5Lg0nNCkbOsHEhg6QzaYpqwZImFWYStxAkgkwR6YTILs4kQQRNeIN3m4G3quyL7ctavitZcy4CC8g70Zp9wS2P5GUcwzDKQ0176Xsn5e+BgT3AteefMoXJZJ3LPDNDYfesPaopXK7osg9b6dJeJAnw6dYan4L+AGg3d0tZbGmEWs6+8+xEApjGs4aEetvbDiEfcRFs0PXSNUFIcEYwl2udeH1Rt0q/4Y9tMG5iyBV4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc70+1zlAw4IWweXhpK5y9os9ghbHRL1VY6PHq/NeSw=;
 b=jsxxt/96tj0+U1jUM5kZmTmrlrxfl4cUwhxu10nSZKKkhh2NV3lCZVyV+keJprHVLkhF+FYr5ALgO032hZHMZjVWVZGzM+A/IvamAV9TpU7/sGZn8i0l+4pE6ea3OvymF/IpRUIL4LGRCwlcYyzoBIIHqzz/KKXO3cvGzFAb/ggnR3ZhspnfiyBLwiXOqvUqr4F/QyYoN3DjwhNPpcGd0lEv5/uZyjIoSj8t+UNOx9NFpeB6mVawRjKL3qykO22rWj2D6FMAIulnHxh/DTfp1yy4xMiQWWdy2iaGpQ/Nysx5GU7dWP6kDma/rHt/+Jd6UVxb5oK8ZWN8eX8L2rbHwg==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by GV1P195MB1927.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 10:03:54 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%5]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 10:03:53 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Simon Glass <sjg@chromium.org>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH RFC v2 3/8] tools: binman: mark optional missing blobs as
 absent
Thread-Topic: [PATCH RFC v2 3/8] tools: binman: mark optional missing blobs as
 absent
Thread-Index: AQHbzwqytUgw3yWnVkGcWfSx+uYjzLPrCwmAgArrfQA=
Date: Fri, 6 Jun 2025 10:03:52 +0000
Message-ID: <71eed70d54e42d50ea184cafd1f6915fb72d81ae.camel@phytec.de>
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
 <20250527-binman_faked_optional-v2-3-3362ab897581@phytec.de>
 <CAFLszTj26VDM0nQOscCwDzhB0LEJMF+OvdMEo_egPoCzgSg-SA@mail.gmail.com>
In-Reply-To: <CAFLszTj26VDM0nQOscCwDzhB0LEJMF+OvdMEo_egPoCzgSg-SA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|GV1P195MB1927:EE_
x-ms-office365-filtering-correlation-id: 77f14801-c351-41ed-aef3-08dda4e1712d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VEFBVkZGbUJaUjl1d3RqZU1VdHdyYnBjaGJDblJNRlFQZ1hvRWc0eEsvbnhk?=
 =?utf-8?B?WXBjUlVFdTRIamlucjZvZzJpSHh0WHdNdm9yb0V2dXFJY0p2UEJxV0k5aFdw?=
 =?utf-8?B?UEsxNDlxcUU4R09nVFFGaGNRaGIvc0VFaXduNzk5V1dKNTlyOTA3U3JtbnAx?=
 =?utf-8?B?OTI4THhzQWdrZkF6NTNxNU5DY0lxZEhpeDZIOW1xZU5PUDVjRHpKbWQwbUtK?=
 =?utf-8?B?ZjJCcUIrR2FadU5wc05qZU5IVFp1Q1N5eW90OTNNREdRL2wwN2RMVVNvbkhN?=
 =?utf-8?B?K2hwVW1TcEp6S0RnVFZ6aWx4TmZoQU4yeXZwUGhXdmpwZkd0ZDU2cC9NVjlC?=
 =?utf-8?B?a09iWk5jVFhWMTRiOW50MjFiUVcybmlEa1pmSmtMYWIwcHVocnRzN3duZi9h?=
 =?utf-8?B?U3ZmUlVmajlDekNIL1NQcW0zMXh3azJ1c3o4OFdKejhPVWg4R0xRZ1A5Tmth?=
 =?utf-8?B?eG5vZ1dZQnVKUzlUTjhiUlNSNU1NdDV6dU1JRFpqN2dscXBhd01Rd3dUajg4?=
 =?utf-8?B?d3JyQWczdENuR2prNE1pYW50azFsWHlNYk1aKzczRzZzOG5MZEtHZlBYWHZa?=
 =?utf-8?B?UkVZSWFLTWw3WkRhaG5jVXVwV3dkWTMyNkFTRHluTzV0bzN0bEZsdS9DdWZ1?=
 =?utf-8?B?K0d2VUdUWjJ1QWdCeUE4UmFZazNzeHNlaVV4NXRscW5LM0VhemVVMUh2cEFI?=
 =?utf-8?B?dFNaUWVQdGJoOXFlQ0lVWTI1VkVTRDhOc0p2OEhKcTlFSG9iMkE5OU8zYitm?=
 =?utf-8?B?bnU5dExHcnFrR1ZqNnlpaUVzYkFLUzlnZTJKQ0Rvc252UWlXZkVHVkJpNDA4?=
 =?utf-8?B?NDZkbVkrMlY2cnpjcTJDTXNSYVI0Nk4rQkpsVDFBMURMbmYzdUFiTWtMUTlI?=
 =?utf-8?B?SmlZQ2c5RTZoV3JSYXdKNitsTmZVK0w0M0lCbHBVeWwzaWJpUVhidTJrUER1?=
 =?utf-8?B?bkgzQUl2Y1h1TkhNNGtWVTB4SllVdWRqOHZDWlp5Y3RwK09ycW1FWERVSWlV?=
 =?utf-8?B?VkNhdm4yMm1FUFJ6QUtYUlZ0TWhOd3FiNGNSQm5USFZOTVdTaVJDQUxFTm12?=
 =?utf-8?B?Vmc2RkhncERVV09lVE4yd2JyMmxWMERIUjNTVExLdHd6VklBMlV3NTFIdVpu?=
 =?utf-8?B?NmwwOXhWRE45eFd5ajlTTUdPYTIzUHp0MEUzN1NIWWc1a2U3VWRmeTVLcS9B?=
 =?utf-8?B?bHhvbVl0bUg0M240YTFwdVVtbURjaUIwRGNac2w5SjIvR2ExVEZmUkgyckov?=
 =?utf-8?B?Zkw5Nk9hK2tqZXAvMHBTajVYem9jMUVmeUF5YXNwbVhNdUYreGFUcndOaVFY?=
 =?utf-8?B?VVFKKzZqWjBzTUw1YWczVDdBSmVWZEN0UStQbUpoVUJ0SUEyZG5CMU1NRDd5?=
 =?utf-8?B?Z1k4UjF0bGNmQnQ0NmluL3p5UlNPTGp5Z0lCUUI4eWEySDY3cjNJQ0RjQ2VB?=
 =?utf-8?B?QWZidU5ncSswUTVGVTdSNEthMlRpTitWVnQvdGp2WU1SUW51Nm1lMG1BeWs5?=
 =?utf-8?B?VmNobUdUZFpzVnRLVG9zWSs0YWNXWEtrdHpCWVArbUtKQWVsSzNnMEx4NWhq?=
 =?utf-8?B?Yk9BaEwwM3lpVjhCQ0dXdFA2TVZjeSsyR1EyZHZyWlMrbmJNeGZyelhzYTJs?=
 =?utf-8?B?dlVoOEgrdkd5UEFXMGF3Z29DdGdDdHVGcVpEUGVyNEh4SFBCTEdLa204WnZI?=
 =?utf-8?B?ZFlTN1A4dzU5YjhFYjZGWWQ3aFNYL29OTllMMXRDS2d2eEY0ZlgyS0E2MjBz?=
 =?utf-8?B?SnMrU1IrdGtSUEE5OVBqOXRCK29EcTN0enpJRjlSbzFtQ0R6eFd3UnMrUlZq?=
 =?utf-8?B?eFYycHlhelphbExUZjg4eVpCa2QvN0ZqYVIyNUV0d1hvdDlzUElDQTc0UFNB?=
 =?utf-8?B?Z1VWSXFuWVQySzVtZzNzZFRIcUcwa3RxVmppQlVhcUM0WVV2b3J0cGMvYVJj?=
 =?utf-8?B?K2JQYVljWkRYTXA1alpTejRuc3lkZGgyWlBVaStSSmhWM1dqaU5uRHNxZ2l0?=
 =?utf-8?Q?mJaeI4En9G28L0Xhnsa5VVjlNWTxAA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bld5L2dtSVNncHMxaDJ3dnN1Z24vZE1wUTgwM3ZXdDNvbGQ0UHorSDlwdVlu?=
 =?utf-8?B?d3IyTkxHRGFaMDRyWk5vUi9OK242NCtNNC94ekQ1K0pVWTJpcGU1RjVkY0Zk?=
 =?utf-8?B?WVV5S2N2VURnSld1Mk02bWRDbUl1REVMbjk4MVFuVnUrbmpNV0J4YW9TWk5i?=
 =?utf-8?B?c1Q4U2VaT0MxV3NsTGVsN29kVmQ0RFB2Sy9VR0RMU3NTb1JLNEJRbm1vaGlV?=
 =?utf-8?B?YzNyejJuVW85M2s1Yi9VaHpKb24rWGRjV2NHZ0wxY1Aya3Uvb0FYcWZGUWU2?=
 =?utf-8?B?aHNUaUh5U3NXL1hGQUI2TWRMSXUzOUd2MmxmSVByUHJzK3NvRXIxT2t1bGEr?=
 =?utf-8?B?b2ZDcWlBOFAydWhRMTQ3dkFCTG9sQThLbmdDaXIwMi84RG5MbmRWYU1rQXlO?=
 =?utf-8?B?RWlQTXYyNWp0NGxYdnYydUZ1YkFaeURKSkFJMEVIWVI2WmV5cnBNZWF2MVVh?=
 =?utf-8?B?U0NHVStvbGJ4SlZHYTBEM01rMWNZTlMrYUNCbERIQVMzd0htVkpnRnFYaURQ?=
 =?utf-8?B?QkVHRWluSS9udmxhUHZVNk1KdGEvVmg3OFdiQ2hLVU83SXhEc3V2NHF0NzNS?=
 =?utf-8?B?bE16SDhhUE1FSDB0ZEp0NitKb0dTRWVrMUZFSi91L3hRVEtSYURGdmdKOXJZ?=
 =?utf-8?B?UE5XRTlBQmllZHZaVHNHcGhuSFdEeG5tb0pDSkxJUkFnN3AxeG9mMXN1SEMv?=
 =?utf-8?B?dmdKMk5XWXlvUlk4OXAza2srYjdMcHR5Z0RxQVd1bmlQTHFOeE85cUZGTFZL?=
 =?utf-8?B?b2VMblFwZSttb2h0V2h1YjZBb01iazhGNEVha1FNVXFFcTk2T1RTK05hb2Zo?=
 =?utf-8?B?Tmtrb3dUNGp6VjJ2NHRGRkdrOCtUeWtzempuMkpLbTJRWmk3U1IzZ0Y3WEVt?=
 =?utf-8?B?Y0RwdlhmNlhielhZaVoxdzdJTWoweDBJaS9abUl1MEI0M1V3TTEvREZsK0Y4?=
 =?utf-8?B?elE3bG1EMUgrM1FPSmU3Q29pVlg1NUZFbGd1TUI1dVovTW03K1E3WThZWlh0?=
 =?utf-8?B?RjRzRTRvYWlNRzZ2enM4aXk2M1MzVVlSMEVzWmF5QVFrYStyUUhXcUlwcXBH?=
 =?utf-8?B?LzJwS3kwb3hGK3p4YzExSHcvVkFaeDdoQlh2aTRHanV5KzRRSkNOeU1ZRlJ3?=
 =?utf-8?B?czlVSjdWUUwxT3hPdzJXd0YwM2owL2prRmtJTGZiL0RUbFl5Sm80dDVFYWFQ?=
 =?utf-8?B?RzhieVB6RVFscFdVREpJY040NEtvWkxYbk9JZ0hwQmdWcGxrNmN5WDBYUXMz?=
 =?utf-8?B?eFpLbUNNWnJOcWdHTTNtL0ZCUzUzN0Qvc3JBdWovRnQ0Y3J5a21MNlJQbnVR?=
 =?utf-8?B?M3ZyWmNYZzMrclBGZTZLbWJPTWVzUW5ERUVhSmt6K0JSNURmcjY4STdrTE12?=
 =?utf-8?B?Ky9IdndGUjNkektxQ3BmR3U3b2wwdS84b1daZ2lDMVZUQzJDcjV4V2w2VGJX?=
 =?utf-8?B?aDY2V2tSaFU2ck5hb0R4WjR6QTI4WUx4L245TjZLejFOQVhGd0JsSGxLNk9a?=
 =?utf-8?B?U0hVc3UzNm5TMkh2YWlQN2x0VmZOWVZ4WFNyaldpYkpDRVZDQldTNFlqYVBv?=
 =?utf-8?B?b1huM1lJVEJDaHFpQVBoU2NYcDA1RnBhRVZrNjYzSjJWUlFCdUNEQ3hoM2Qy?=
 =?utf-8?B?NnBiSFBEZ3NUWkFsQ0doRm96NFR2eFlPa1ZRa1EvanJIV0xzcmdhc04zNnNU?=
 =?utf-8?B?Z0J0ZXlRT2ZRK2VhNVlaMExWN2tHbzV6VmU4QWNHVkFieU5idFhMZUNMZGcr?=
 =?utf-8?B?MVlFcURtSHovSndDSld1ODFhaHEzZWhOczVSUEcwcGdJQ1l0eUgxRU5tbVJj?=
 =?utf-8?B?Vi9UcGZoVXVvellVSE1DQWtCdDZJL29FNythNWZETlphQ3JYeW5IY3VILy83?=
 =?utf-8?B?TEhzREpjN0hQVGVhUWFXYXFNZVZaUnNmc0pJNkxrc0pod3NreS9YSFNJczdU?=
 =?utf-8?B?eFE1Z3pQQXZSVjBOcFF4OTVFTWVDd242elJnWmo5dGJFRGdKL29nZEduTGhM?=
 =?utf-8?B?NWZrVEJDOVArQVhWSmZCMmFOc2ZKTEhDemMwUkVCWnJZSCt6TmpWS0FiZFhk?=
 =?utf-8?B?MWw0T01rT1hPa3crSW1KR1gzemtaZE5ESWZtV2d0UThmVEREZllDOGRLUTFW?=
 =?utf-8?Q?XCIs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D565313E89AFC540B5A3971A1AD189ED@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f14801-c351-41ed-aef3-08dda4e1712d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 10:03:52.9433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ZCY3qciVqRZRagQNUBviDXbadiAINhyfG5+jDHMwh7Nx24IAGarTI47jcpkIMF4WF6rQH1ctKeh/vz7QZ9umA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1927
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

SGkgU2ltb24sCgpBbSBGcmVpdGFnLCBkZW0gMzAuMDUuMjAyNSB1bSAxMjoxOCArMDEwMCBzY2hy
aWViIFNpbW9uIEdsYXNzOgo+IEhpIFlhbm5pYywKPiAKPiBPbiBUdWUsIDI3IE1heSAyMDI1IGF0
IDE0OjI0LCBZYW5uaWMgTW9vZyA8eS5tb29nQHBoeXRlYy5kZT4gd3JvdGU6Cj4gPiAKPiA+IE9w
dGlvbmFsIGJsb2JzIHNob3VsZCBtYXJrIHRoZW1zZWx2ZXMgYXMgYWJzZW50IHRvIGF2b2lkIGJl
aW5nIHBhY2tlZAo+ID4gaW50byBhbiBpbWFnZS4KPiA+IEV4dGVuZCB0aGUgZG9jdW1lbnRhdGlv
biBvZiB0aGlzIGJlaGF2aW91ci4gQWx0aG91Z2ggdGhlIGRvY3VtZW50YXRpb24KPiA+IGltcGxp
ZWQgdGhpcyBiZWZvcmUsIHRoZSAib3B0aW9uYWwiIHByb3BlcnR5IGhhZCBub3QgYmVlbiBleHBs
YWluZWQKPiA+IHByb3Blcmx5IGJlZm9yZS4KPiA+IE5vdGUgdGhhdCB0aGUgaW50ZW5kZWQgYmVo
YXZpb3VyIGlzIHRoZSBzYW1lLCB0aGlzIHBhdGNoIGp1c3QgZG9jdW1lbnRzCj4gPiBpdC4KPiAK
PiBUaGlzIHNlZW1zIHRvIGluZGljYXRlIHRoYXQgaXQgaXMganVzdCBhIGRvYyBjaGFuZ2UKPiAK
PiA+IFRoZSBhY3R1YWwgYmVoYXZpb3VyIHdpbGwgY2hhbmdlIGFzIG5vdyBhYnNlbnQgZW50cmll
cyBhcmUgbm8gbG9uZ2VyCj4gPiBwYWNrZWQgaW50byBhbiBpbWFnZS4gVGhlIGltYWdlIG1hcCB3
aWxsIGFsc28gcmVmbGVjdCB0aGlzLgo+IAo+IEJ1dCB0aGlzIGluZGljYXRlcyB0aGF0IGl0IGNo
YW5nZXMgdGhlIGZ1bmN0aW9uYWxpdHkuIENhbiB5b3UgY2xhcmlmeQo+IHRoaXMgaW4geW91ciBj
b21taXQgbWVzc2FnZT8KCldpbGwgY2xhcmlmeS4gSSB3cm90ZSB0aGF0IHRoZSBpbnRlbmRlZCEg
YmVoYXZpb3VyIGlzIHRoZSBzYW1lLCBidXQgZHVlIHRvIGEKYnVnLCB0aGUgYWN0dWFsIGJlaGF2
aW91ciBjaGFuZ2VzIC4uLgoKVGhlIGJ1ZyBiZWluZyB0aGF0IGV2ZW4gdGhvdWdoIHRoZSBkb2N1
bWVudGF0aW9uIHNheXMgb3B0aW9uYWwgYmxvYnMgd2lsbCBiZQpyZW1vdmVkLCB0aGV5IGFyZSBu
b3QuCgo+IAo+ID4gQXMgYSByZXN1bHQsIHRoZSBDaGVja0ZvclByb2JsZW1zKCkgZnVuY3Rpb24g
d2lsbCBubyBsb25nZXIgYWxlcnQgb24KPiA+IG9wdGlvbmFsIChibG9iKSBlbnRyaWVzLiBUaGlz
IGlzIGJlY2F1c2UgdGhlIG1pc3Npbmcgb3B0aW9uYWwgaW1hZ2VzCj4gPiB3ZXJlIHJlbW92ZWQg
YmVmb3JlIENoZWNrRm9yUHJvYmxlbXMgaXMgY2FsbGVkLgo+ID4gVGhpcywgYXMgd2VsbCwgaXMg
aW50ZW5kZWQgYmVoYXZpb3VyLgo+IAo+IFRoaXMgYnJlYWtzIHRlc3RFeHRibG9iT3B0aW9uYWwo
KSBmb3IgbWUuCgouLi4gVGhhdCBpcyB3aHkgdGhpcyB0ZXN0IGZhaWxzIEkgYmVsaWV2ZS4gU2lu
Y2UgaXQgcmVsaWVzIG9uIHRoZSBidWcgdG8gYmUKcHJlc2VudCAoaS5lLiBhYnNlbnQgb3B0aW9u
YWwgYmxvYnMgc3RpbGwgaW5jbHVkZWQgaW4gdGhlIGltYWdlKS4KCj4gCj4gSSBhcHBsaWVkIHlv
dXIgcGF0Y2g6IHRvb2xzOiBiaW5tYW46IGRyb3AgImZha2VkIiByZXR1cm4gdmFsdWUgZnJvbQo+
IGNoZWNrX2Zha2VfZm5hbWUKPiAKPiBUaGVuIEkgYXBwbGllZCB0aGlzIG9uZSBhbmQgZ290IHRo
ZSBlcnJvci4KPiAKPiBJIGNvdWxkIG5vdCBhcHBseSBwYXRjaCAyIChvb2xzOiBiaW5tYW46IGZ0
ZXN0OiBwYXNzIGFsbG93X2Zha2VfYmxvYgo+IHRvIF9Eb1JlYWRGaWxlRHRiKSBhcyBpdCBicm9r
ZSBhIGxvdCBvZiB0ZXN0cy4KPiAKPiBGb3IgdGVzdEV4dGJsb2JPcHRpb25hbCgpIEkgc2VlIHRo
YXQgeW91IGhhdmUgZml4ZWQgaXQgYnkgdGhlIGVuZCBvZgo+IHRoZSBzZXJpZXMsIGJ1dCBJIGdl
dCAxMS8xMiB0ZXN0IGZhaWx1cmVzIC4gQXJlIHlvdSBhYmxlIHRvIG1ha2UgdGhlCj4gc2VyaWVz
IGJpc2VjdGFibGUsIHNvIHRoYXQgJ2Jpbm1hbiB0ZXN0JyB3b3JrcyBmb3IgZWFjaCBjb21taXQ/
IEl0J3MKPiBoYXJkIGZvciBtZSB0byBjb21tZW50IG9uIHRoZSBzZXJpZXMgaW4gdGhpcyBzdGF0
ZS4KClllcywgd2lsbCBkby4KCj4gCj4gQWxzbyB0aGVyZSdzIG5vIG5lZWQgdG8gcHV0IGFuICdS
RkMnIHRhZyBvbiB0aGlzIHNlcmllcy4gV2UgZG8gd2FudCB0bwo+IHJlc29sdmUgdGhpcywgb25l
IHdheSBvciBhbm90aGVyLgoKSSBwdXQgUkZDLCBiZWNhdXNlIGltbyBpdCBpcyBub3QgdG8gdGhl
IHF1YWxpdHkgc3RhbmRhcmRzIGV4cGVjdGVkIG9mIHBhdGNoZXMuCllvdSB3YW50ZWQgdG8gcmV2
aWV3IHRoZSBjdXJyZW50IHN0YXRlLCBidXQgSSBkaWRuJ3QgY2xlYW4gdXAgeWV0LCBzbyB0aGF0
IGlzCndoeSBJIHNlbnQgYXMgUkZDLgoKWWFubmljCgo+IAo+ID4gCj4gPiBSZXBvcnRlZC1ieTog
U2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5uaWMg
TW9vZyA8eS5tb29nQHBoeXRlYy5kZT4KPiA+IC0tLQo+ID4gwqB0b29scy9iaW5tYW4vYmlubWFu
LnJzdMKgwqDCoCB8IDcgKysrKysrKwo+ID4gwqB0b29scy9iaW5tYW4vZXR5cGUvYmxvYi5weSB8
IDIgKysKPiA+IMKgMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL2Jpbm1hbi9iaW5tYW4ucnN0IGIvdG9vbHMvYmlubWFuL2Jpbm1hbi5y
c3QKPiA+IGluZGV4Cj4gPiA4NGIxMzMxZGY1YzAwNmY3MjE2NzAxNmI3ZjMzZGU3M2Y0YTI2OWZh
Li4zOTJlNTA3ZDQ0OWM3NWVlYmE0NDMxZmUyZGIwMWQ4MjBiCj4gPiBjZThmNjEgMTAwNjQ0Cj4g
PiAtLS0gYS90b29scy9iaW5tYW4vYmlubWFuLnJzdAo+ID4gKysrIGIvdG9vbHMvYmlubWFuL2Jp
bm1hbi5yc3QKPiA+IEBAIC0xMTQzLDYgKzExNDMsMTMgQEAgT3B0aW9uYWwgZW50cmllcwo+ID4g
Cj4gPiDCoFNvbWUgZW50cmllcyBuZWVkIHRvIGV4aXN0IG9ubHkgaWYgY2VydGFpbiBjb25kaXRp
b25zIGFyZSBtZXQuIEZvciBleGFtcGxlLAo+ID4gYW4KPiA+IMKgZW50cnkgbWF5IHdhbnQgdG8g
YXBwZWFyIGluIHRoZSBpbWFnZSBvbmx5IGlmIGEgZmlsZSBoYXMgYSBwYXJ0aWN1bGFyCj4gPiBm
b3JtYXQuCj4gPiArQWxzbywgdGhlIGBgb3B0aW9uYWxgYCBwcm9wZXJ0eSBtYXkgYmUgdXNlZCB0
byBtYXJrIGVudHJpZXMgYXMgb3B0aW9uYWw6Ogo+ID4gKwo+ID4gK8KgwqDCoCB0ZWUtb3Mgewo+
ID4gK8KgwqDCoMKgwqDCoMKgIGZpbGVuYW1lID0gInRlZS5iaW4iOwo+ID4gK8KgwqDCoMKgwqDC
oMKgIG9wdGlvbmFsOwo+ID4gK8KgwqDCoCB9Owo+ID4gKwo+ID4gwqBPYnZpb3VzbHkgdGhlIGVu
dHJ5IG11c3QgZXhpc3QgaW4gdGhlIGltYWdlIGRlc2NyaXB0aW9uIGZvciBpdCB0byBiZQo+ID4g
cHJvY2Vzc2VkCj4gPiDCoGF0IGFsbCwgc28gYSB3YXkgbmVlZHMgdG8gYmUgZm91bmQgdG8gaGF2
ZSB0aGUgZW50cnkgcmVtb3ZlIGl0c2VsZi4KPiA+IAo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL2Jp
bm1hbi9ldHlwZS9ibG9iLnB5IGIvdG9vbHMvYmlubWFuL2V0eXBlL2Jsb2IucHkKPiA+IGluZGV4
Cj4gPiA5NzBmYWU5MWNkOWIyYTMxYjNmMzFkMmVjZGI3N2UyN2E4OWQ2OWZiLi5hY2Q5YWUzNDA3
NGU0YjRiOTc5MmIxMDdjYzgwNTE0ZGZkCj4gPiBkODhiM2IgMTAwNjQ0Cj4gPiAtLS0gYS90b29s
cy9iaW5tYW4vZXR5cGUvYmxvYi5weQo+ID4gKysrIGIvdG9vbHMvYmlubWFuL2V0eXBlL2Jsb2Iu
cHkKPiA+IEBAIC01Miw2ICs1Miw4IEBAIGNsYXNzIEVudHJ5X2Jsb2IoRW50cnkpOgo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmFrZV9zaXplID0gc2VsZi5hc3N1bWVfc2l6
ZQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuX3BhdGhuYW1lID0gc2VsZi5jaGVj
a19mYWtlX2ZuYW1lKHNlbGYuX2ZpbGVuYW1lLAo+ID4gZmFrZV9zaXplKQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHNlbGYubWlzc2luZyA9IFRydWUKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmIHNlbGYub3B0aW9uYWw6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNlbGYubWFya19hYnNlbnQoIm1pc3NpbmcgYnV0IG9wdGlvbmFsIikKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiBub3Qgc2VsZi5mYWtlZDoKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNvbnRlbnRfc2l6ZSA9IDAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlmIHNlbGYuYXNzdW1lX3NpemU6ICMgRW5zdXJlIHdlIGdldCB0ZXN0IGNv
dmVyYWdlIG9uIG5leHQKPiA+IGxpbmUKPiA+IAo+ID4gLS0KPiA+IDIuNDMuMAo+ID4gCj4gCj4g
UmVnYXJkcywKPiBTaW1vbgo=
