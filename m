Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D469CCCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 09:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3496F83B55;
	Tue, 11 Nov 2025 10:56:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FP2PO62d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD24283B56; Tue, 11 Nov 2025 10:56:35 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 811E983A94
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 10:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.remmet@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5VLr3Qy5VwJOF6pFIQKYRPMXtLalAPXGJgm2RNRuRTtRAeGkoF4FimCP5uG3kDZsXGwjbrFuOFgL2ZoRiQOlRahCQWXxQtKzN4OWyZ5y1cVMEI8smpibTSOz2/TxFAGKA9uh/RFPiiGV1psSzsBVq145S1wsNMUVv3SngVjwIiIOQu5+cMqFnHc89f9wvfW+0qyuR+oiFMYwsAZhTmNhWtSEhu7pZidX7QOKLR4UHxOwW8v+H0DJaA3LmJSvmopLwaHp+9hqHXD8l8vRkLRovgaTOd6N2fqiPYgrKQM699yEFuhpJDKVFFiNWcDl3g4Q8+lIid0T5+4qbXbFrJ2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p+RTiVxnnFx9bDAt+JHtLGFyfc74drcs49n7mDm5Y4=;
 b=cUq6LKbIIuywRzgHiaELbDqHd+wEtWgPsxdjXEMheNSti8p7aJEebDQXdDvxRs5S6ilu0WZC0rTcvB/ktiapwrfT/qf+ln1DnrngW57iS0gE5o4Ok0/lrv4d0iFoMtCG7ZArqj5CK6qSPdzRq4potjuhfBBMDqsBTJwcY2dIoAspEQhGoxRDZvCScFWaTtA64dxZq4mMojHsoABOdTz8N6ZCk4zZs5GEmQbWpW8QwCGeem4slCN25Kryr23325q58YJ+aX/TOB7JhKVM+RVOdFhtK+2zeQL21ZauOqRjJWUp6Fk1+V5Dt590QyB75d8LraJYsEOd1QYufmgBuHPqkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p+RTiVxnnFx9bDAt+JHtLGFyfc74drcs49n7mDm5Y4=;
 b=FP2PO62d/tya6S61UXl9K77X1blhjFjXGqff8GSg29WQzAaXwma2d8/M2YZZH4CzWCgtBvhh1EeHMpoL9r4Vulz1UDxFKRtKKjlVeblZmb7e0qgZp5CWHBm1g+IhB+kWH3LyWULxbu+8718vq/lwVvcdEeF9UwrqqXrk+csj1pCCcYM4yzfKfoakyPbW/NIpJa/YLcKQhvXpnScRgj1qA5NIMN5+gCgy5LVI5+SdSf5QaL69cb7pPUd91kaO+w3GCJXHB6YMeR1Z4c7WjH+nbs8XkhHcPCwbXg/QbZ08aroCX7XoSFJSlLWUbF50uKYCWFB5riFPBctCX6xcgBpTWw==
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:297::14)
 by AM7PPF8841B0D4B.EURP195.PROD.OUTLOOK.COM (2603:10a6:20f:fff1::757) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 09:56:31 +0000
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::389e:cc69:1eab:3c56]) by DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::389e:cc69:1eab:3c56%4]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 09:56:31 +0000
From: Teresa Remmet <t.remmet@phytec.de>
To: "trini@konsulko.com" <trini@konsulko.com>, Daniel Schultz
 <d.schultz@phytec.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [Upstream] [PATCH 2/2] board: phytec: phytec_som_detection: Add
 support for phyFLEX
Thread-Topic: [Upstream] [PATCH 2/2] board: phytec: phytec_som_detection: Add
 support for phyFLEX
Thread-Index: AQHcUklTZXptmjtFP0GMrIcQgDIdorTtPlUA
Date: Tue, 11 Nov 2025 09:56:31 +0000
Message-ID: <ae2a1c89dfc8281375015d206d0f1ef2336a79bc.camel@phytec.de>
References: <20251110135228.1357377-1-d.schultz@phytec.de>
 <20251110135228.1357377-2-d.schultz@phytec.de>
In-Reply-To: <20251110135228.1357377-2-d.schultz@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB1228:EE_|AM7PPF8841B0D4B:EE_
x-ms-office365-filtering-correlation-id: 969341a8-717a-448f-91bd-08de21089741
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TFFGU0FPR2tlbURMRCtYazdCKzZwU1FYNTd6V09HYW1RcVBrTUFaa2NyNXFt?=
 =?utf-8?B?Sy9CcFluMzFyczhyNUN2ZVFPaVRaWE9LeFkxc0l6VzJKZU5NMWxWNE11OEtv?=
 =?utf-8?B?RkZnc1pMQ1ZEVmRaYTM2MFNWUHU2NHVFWWZCTE9KQWZoNFZZanBTSXE0azly?=
 =?utf-8?B?UERhTTdNbkU1azBhRTREUWRvV3Vxb0VCWWczMzVVMlpTb1VSMkxpV2hXTjZs?=
 =?utf-8?B?RFlHcEVMdzc5cDA2N1FxbjhlM3dtTXpSSFpjZWdneWdzVXVUaitsbWhLYXhX?=
 =?utf-8?B?SWRBcnIvMCtSaDB6V0RPOEdWc05BYzBiMURkNVZYUE5Eb01pUk1iRi9GMGdH?=
 =?utf-8?B?cHUzdmtuWWtUTDFVQ2pzSkRIT3pFdWI3Q2Jjbk1JNlVGbmVSYUZjYnBjbzNk?=
 =?utf-8?B?RFVQTGM4VmVYMzgwZXRDVklPK05FMml4c2JRMUtQdG9YUXhreDk1Wlhjd3da?=
 =?utf-8?B?VzJiZHI4bm1jR1NPQWFDQlpyL25CQnZIdGpMZ0hObVJDV3FvaU1xa0pTNi9t?=
 =?utf-8?B?eWV2UmY2b1M4aHByVmJER1VGMEVpTXRod29ObUN6WmxJM2tpSEpUcjc0bHlN?=
 =?utf-8?B?K3RheWsxSG9vaVAyK1ZLWFc3S2F6aFFUY1E2Z3ErY0hWU3lTcXBOQXhvUU85?=
 =?utf-8?B?ZEE2SFg1MDVGVEJKemNTZno3cFFIWkRCQnRuWEpHbjhHMWdnNXJrWUoxQzVh?=
 =?utf-8?B?b3EwM3ZCQnZhdnpZbnFtRUhOYVV0K3dIUTdRU0QyMFNIZ20vNnVSelJod0hP?=
 =?utf-8?B?RVJtSll0d0s4NDFud2R5aWFicjd3RTZKRjY5dzQxdEZHOCt3YnFXMk5rSTI2?=
 =?utf-8?B?UmR5eW4xYTkrK3M0OG5idCtBVlo0MEVGZEh5SDZKUGZHbkFJbG1vTndTRXF6?=
 =?utf-8?B?RFZIYlJmMm1XR2pFeERoMlp3MU1SNUNGbURGUWdVWTV4eTVhRmc3SlhnRmlU?=
 =?utf-8?B?NzhwVlhaRXJVZmJvKzVqVmgrQ2FrOUVyNXg0MHY2MEVnS3ZZYkU3b25aeXFJ?=
 =?utf-8?B?SDBhamw5enBpdlh6WTZyS1FwNjhoUGNDU004YzBheHpkcG1aSW9WKzdsS3Zq?=
 =?utf-8?B?ZEVkRW9SSVdZVzNRbzNENlZrRXBuSUxjb1dXWjY5cEU3NVBCcThRUXNJNWNn?=
 =?utf-8?B?b3ZvK2VFMW1WbklCeVlvVjBScHprMnc5bnh3a0Z3MFBjY1lnNm9zcnhoK1Jh?=
 =?utf-8?B?TVFFRXZzSEdmcG0xWEZUNmNSdHpFRnZBQWZEeGo3M1kxWmhNVVpPRUVqRlAw?=
 =?utf-8?B?TFBUM0lrRWhqcVdMeWhUcnlUdE5STFFVSDZUWS9RNUc3K3h0ekF6aTBxS09n?=
 =?utf-8?B?Ny80TEw2dE5iN0p5WFhPM1ExTnJ4VWpPcHlDeXBzMHRZd0l3amJqMHI3MmNq?=
 =?utf-8?B?NkVRRWdtS3Z3cEJibDRjUWFRcVFmWTVTcUJNR08weEV6TkczMkp6a3hBSEdh?=
 =?utf-8?B?cWpRNWVSWEU0elN3L2FZdjIwMEpTQ3FGU3RQQnpmaXlLME14WTlIRGNSV2Ft?=
 =?utf-8?B?b2RmbGRZd1VFRVVienR5UkhUaHVqNFp1b0ZEeG9mQUg0K3JDQlMyVFV2dE52?=
 =?utf-8?B?STFKSjBiSGprakpWMUpmQWhFVkhOR1k3WExyNTJicXRWcG5XWitsSTBtSDdE?=
 =?utf-8?B?OVo2UGlMRzdxTmtLOXdRZ1Z2YjN4cWYxUloyN1V0VUNxMVZIQlVWUEgzRFR1?=
 =?utf-8?B?ZHRlYW1iY3ZWTGY3a2FIckNJanFyZXhXM2FGdjdPd21PNlU2b2k2TXkvdjMv?=
 =?utf-8?B?ZE1HMnNiZXZUSUNhTTZQOUFxRThXRndobHBkaTNJZDVjTHRBbnRsZFNTYndi?=
 =?utf-8?B?dGMwbm9ncDdMMHpkNzY0Qkpwenc3N3B1aDBrbUxXb09aais2UG1LN2NkYzNV?=
 =?utf-8?B?YlN6eVVkWGpad0xmb2xYMnZCMitpUUw4YTNjbk0zTDVQZXo4ODlwRTR1cXVN?=
 =?utf-8?B?RWhkZEtaWndmdmlRTlZYSkZVSW0vRGNJZzlJZWJwYVBvWlhsWUxUVmJPZmQ2?=
 =?utf-8?B?SDdQSjJVSzdFV3gyVWp1dDBmRlh4UGxJZUxYZk92djVPZlVrUFg0MFBQbVNO?=
 =?utf-8?Q?qO6zYB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1228.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clBuVTY1UldCV0Y2M09TZktQU3ZaWEVLY0JnZmZHemdacUZtQy8vWVNhOENI?=
 =?utf-8?B?MkxYeUgzWmNaWFpuT05Zcis1eldKRWR4RlVvMDNBNWp1V2tFUWp0bjJqeUtV?=
 =?utf-8?B?eC9hNE5oZ29xZm5jMnVuanJ0S2FKelpndDA3ZGRoTkh6R3ZSbFVOc3RJY0ts?=
 =?utf-8?B?bWk3U21FMVZ1eHN4MkMxMmZFNVRaSUpzVnFNSFpSOEZPWVRkWUxUMERKSWtM?=
 =?utf-8?B?WHVVS0VOTzNBSU5leDFFVWtwMDRZQzVsSXNoVmxmUVVnRmR3WEhJL0JTLy9M?=
 =?utf-8?B?M2dVZW84cnE5ZWFBV0hqTzNFNWtUMWpYV2xrbEZ3RlVVU3ljRGlkQUxxVEhJ?=
 =?utf-8?B?dUd5cFZWVFVlR3RXbWJNU1F1NWRvR1dEV2xEREg3emRnWDJPeG91aFpZMGZr?=
 =?utf-8?B?WUQwZElZMVlrY0ZCNGJNMUF0MW01UUlXTEtVMFZuZTFDWitNTzhoSTU0aGFt?=
 =?utf-8?B?dUZyVFVUWHV2Q3Bpd0Jyd3JDdWxnMDhvc2k0SlRUL050TlFXb1FDWll5Vkpw?=
 =?utf-8?B?dWRPbWxJLytjS0xVZFptdFpDbVJuRHdKRDc3VjdaZjFQRUNvRUFBcWw1bFZz?=
 =?utf-8?B?NXN4S0NMeGlMa1VwWDdhelFBclF5OXFTRCttQjIrcFZIVUcwMkx1WG1FQ0VJ?=
 =?utf-8?B?TzZuZ0pzOFpobUNJWXFXUTNLQmlUNzVZaTdqejJNUXlzNmt5bmhpSU5VWDlO?=
 =?utf-8?B?OEpKTER3S3dwd2NoSUpkN0lueW1jVkNOTzRSYkljNkd0Y2dwcUk4c2h5MEZa?=
 =?utf-8?B?QlBLcU1MOE8vYVZjaUJCRXZSK0YxdlBOTUV5L2l0WktuOUs4NzNncFFIaUsr?=
 =?utf-8?B?by9PYzNOT090TGJKRnhjSFhGT0Y1VEUvT0VLOWtTWWtpQ0lkeXN1aXZpMURs?=
 =?utf-8?B?bDhiT01KS2FsS3hsbmVWR2JZYWphOGxscUZvemo4K0RiaXFPbDBhMjZoNFFD?=
 =?utf-8?B?cWF6eXJUZy84K05hL0hUVVpEM1Y4ZEpyZzZCS2t5L2lPRmV4WFdrNm53S1hR?=
 =?utf-8?B?WHZjM2dseDdCeXgvV29JaCtscjBZYlhTNlZTQW1SUDhtN2xqa3RIdjBOemJs?=
 =?utf-8?B?YVdRMzJJVUNIZWpwNERua3VQVlV4UXlrU05DZFlpellBK2tNNklSTjVLcGR1?=
 =?utf-8?B?MnhZVHgxRTdOWjNqa1JXMDgwNmcyQTRnVHNybHhQOGlQZGs2NC90cUs4RzVX?=
 =?utf-8?B?Q2JpMnNzS2xqdXdIcUdsc2dFY1c2TS9xK0IvczVTdWxxWWR5RndYeW8ybmZ0?=
 =?utf-8?B?eVZ6Y2hzQUdpVXJTQVVCQnYyMjVQQzZkT1RCM1lxSzl3UG1sUVRWSXVaVnZk?=
 =?utf-8?B?MDV1dE9Yb1dVclg0OFd5bWtzNnRTcE9QMEdxckdKbDlhNWRNQS8xYndQcGp5?=
 =?utf-8?B?VWR4YVBEKzF0VjdCdnQrL0trK0Q3MjdVSGUzMHpGNGlCK1huNDNyNVFQWjB2?=
 =?utf-8?B?MnRBaDBOdDVwbi96Q2psTTFjU09rTE53ak5EMEZacit6RDRGYTVMRGxUUEdz?=
 =?utf-8?B?V2JyajYvSEsrSzNVaHVydHVuQitKL3VWbkk2YmxISXBDTXE1RHRGKzQ3V1Rm?=
 =?utf-8?B?VmJ4WStsN0dVYVB4UXc5ZHE0aTdlb01vTUtwSWU5QStVU3BEb3hxMlgzblVn?=
 =?utf-8?B?Um52UENSWGhsY0s5TFUyUitvVUZiUFBsNHJOQUdTd25FM3VzVHh2M3JqZEVT?=
 =?utf-8?B?bysrM1NhRXlseG9nRUFDTDBycTZHNnlJOFQvWWt6b1FsR2lOSXlEVW1UczFS?=
 =?utf-8?B?NjRBVWh0bHFjMnQvVkwyb3d2OXFYazljODlnNnpEcDVnVnJIRDByUC9zL013?=
 =?utf-8?B?RFo5SUNSRzR1OTZPQWVuVVh1WE83eVhyRnJpL2tNRWJtampEc2hTN3hJQXdx?=
 =?utf-8?B?TDl1M1BkenVkbGhoNkJrMmpiemNUL3ZuQnl2cC9MS01yVTJ0U1hjS1grRFFl?=
 =?utf-8?B?bHhqcCtSQi81MGpyZVJFUXRxZzBzemIxTG5iZTZTVXlMbURyN2REOG9FUFVh?=
 =?utf-8?B?a3V6cEsxRFlMQlVHTTI4b2tyQlB3SVdhak1WbHdPcFJlSkZ3dk1UT1dyZldW?=
 =?utf-8?B?VGlpOXlPcVVyMS93RWpqajJzRHVZRUJRMDVnR0FQbVRwY3ZJN2NVWldkdFFa?=
 =?utf-8?Q?q3u9PEoN4sV3at9H6SwG+p/7H?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <262FF484BC516C43A7E92FA1BC25A301@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 969341a8-717a-448f-91bd-08de21089741
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 09:56:31.4106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DhH4bWneqEyMUSxaelP5hNEMQNS6y7tk66IaVnD+vMMqMv0myOal5JLm7L/EgLScTBIwQxZK9IrvyOucvOy14A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPF8841B0D4B
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

SGVsbG8gRGFuaWVsLAoKQW0gTW9udGFnLCBkZW0gMTAuMTEuMjAyNSB1bSAwNTo1MiAtMDgwMCBz
Y2hyaWViIERhbmllbCBTY2h1bHR6Ogo+IHBoeUZMRVggYXJlIFNvTXMgYmFzZWQgb24gdGhlIEZQ
U0Mgc3RhbmRhcmQuCj4gCj4gQWRkIGFkZGl0aW9uICJTT00gdHlwZXMiIGZvciB0aGUgcGh5RkxF
WCBtb2R1bGVzIGJhc2Ugb24gdGhlCj4gRlBTQyBHYW1tYSBzcGVjaWZpY3Rpb24uIFRoZXNlIG1v
ZHVsZXMgY29tZSBpbiBmb3VyIGRpZmZlcm50CgpoZXJlIGFyZSB0eXBvcyBpbiB0aGUgY29tbWl0
IG1lc3NhZ2UKcy9zcGVjaWZpY3Rpb24vc3BlY2lmaWNhdGlvbiBhbmQgcy9kaWZmZXJudC9kaWZm
ZXJlbnQKCmJlc2lkZXMgdGhhdCBpdCBsb29rcyBnb29kLgoKUmV2aWV3ZWQtYnk6IFRlcmVzYSBS
ZW1tZXQgPHQucmVtbWV0QHBoeXRlYy5kZT4KCgo+IHZhcmlhbnRzOyBwcm90b3R5cGVzIChQVCks
IHN0YW5kYXJkIHByb2R1Y3QgKFNQKSwgS1NQIChLUCkgYW5kCj4gS1NNIChLTSkuCj4gCj4gU2ln
bmVkLW9mZi1ieTogRGFuaWVsIFNjaHVsdHogPGQuc2NodWx0ekBwaHl0ZWMuZGU+Cj4gLS0tCj4g
wqBib2FyZC9waHl0ZWMvY29tbW9uL3BoeXRlY19zb21fZGV0ZWN0aW9uLmMgfCAzOAo+ICsrKysr
KysrKysrKysrKysrKysrLS0KPiDCoGJvYXJkL3BoeXRlYy9jb21tb24vcGh5dGVjX3NvbV9kZXRl
Y3Rpb24uaCB8wqAgOCArKystLQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9ib2FyZC9waHl0ZWMvY29tbW9uL3Bo
eXRlY19zb21fZGV0ZWN0aW9uLmMKPiBiL2JvYXJkL3BoeXRlYy9jb21tb24vcGh5dGVjX3NvbV9k
ZXRlY3Rpb24uYwo+IGluZGV4IGZmMTcxMWMyNGI0Li4wZTMwZWQ5YjFiYiAxMDA2NDQKPiAtLS0g
YS9ib2FyZC9waHl0ZWMvY29tbW9uL3BoeXRlY19zb21fZGV0ZWN0aW9uLmMKPiArKysgYi9ib2Fy
ZC9waHl0ZWMvY29tbW9uL3BoeXRlY19zb21fZGV0ZWN0aW9uLmMKPiBAQCAtMzA4LDE0ICszMDgs
MjQgQEAgc3RhdGljIGludCBwaHl0ZWNfZ2V0X3Byb2R1Y3RfbmFtZShzdHJ1Y3QKPiBwaHl0ZWNf
ZWVwcm9tX2RhdGEgKmRhdGEsCj4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgNzoKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNvbV90eXBlID0gMTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGJyZWFrOwo+ICvCoMKgwqDCoMKgwqDCoGNhc2UgODoKPiArwqDCoMKgwqDC
oMKgwqBjYXNlIDk6Cj4gK8KgwqDCoMKgwqDCoMKgY2FzZSAxMDoKPiArwqDCoMKgwqDCoMKgwqBj
YXNlIDExOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzb21fdHlwZSA9IFNPTV9U
WVBFX1BGTF9HOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiDCoMKg
wqDCoMKgwqDCoMKgZGVmYXVsdDoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBy
X2VycigiJXM6IEludmFsaWQgU09NIHR5cGU6ICVpXG4iLCBfX2Z1bmNfXywgYXBpMi0KPiA+c29t
X3R5cGUpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7
Cj4gwqDCoMKgwqDCoMKgwqDCoH07Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBsZW4gPSBzbnByaW50
Zihwcm9kdWN0LCBQSFlURUNfUFJPRFVDVF9OQU1FX01BWF9MRU4gKyAxLCAiJXMtCj4gJTAzdSIs
Cj4gK8KgwqDCoMKgwqDCoMKgY29uc3QgY2hhciAqZm10ID0gKHNvbV90eXBlID09IFNPTV9UWVBF
X1BGTF9HKSA/ICIlcy0lMDJ1IiA6Cj4gIiVzLSUwM3UiOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBs
ZW4gPSBzbnByaW50Zihwcm9kdWN0LCBQSFlURUNfUFJPRFVDVF9OQU1FX01BWF9MRU4gKyAxLCBm
bXQsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGh5dGVj
X3NvbV90eXBlX3N0cltzb21fdHlwZV0sIGFwaTItPnNvbV9ubyk7Cj4gLcKgwqDCoMKgwqDCoMKg
aWYgKGxlbiAhPSBQSFlURUNfUFJPRFVDVF9OQU1FX1NURF9MRU4pCj4gK8KgwqDCoMKgwqDCoMKg
aWYgKHNvbV90eXBlICE9IFNPTV9UWVBFX1BGTF9HICYmIGxlbiAhPQo+IFBIWVRFQ19QUk9EVUNU
X05BTUVfUENYX0xFTikKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1F
SU5WQUw7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHNvbV90eXBlID09IFNPTV9UWVBFX1BGTF9HICYm
IGxlbiAhPQo+IFBIWVRFQ19QUk9EVUNUX05BTUVfUEZMX0xFTikKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOwo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
MDsKPiDCoH0KPiBAQCAtMzI3LDYgKzMzNyw3IEBAIHN0YXRpYyBpbnQgcGh5dGVjX2dldF9wYXJ0
X251bWJlcihzdHJ1Y3QKPiBwaHl0ZWNfZWVwcm9tX2RhdGEgKmRhdGEsCj4gwqDCoMKgwqDCoMKg
wqDCoHN0cnVjdCBwaHl0ZWNfYXBpMl9kYXRhICphcGkyOwo+IMKgwqDCoMKgwqDCoMKgwqB1bnNp
Z25lZCBpbnQga3NwX3R5cGU7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCByZXMsIGxlbjsKPiArwqDC
oMKgwqDCoMKgwqBjaGFyICp2YXJpYW50ID0gIlNQIjsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBp
ZiAoIWRhdGEtPnZhbGlkIHx8IGRhdGEtPnBheWxvYWQuYXBpX3JldiA8IFBIWVRFQ19BUElfUkVW
MikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOwo+IEBA
IC0zNDEsNyArMzUyLDcgQEAgc3RhdGljIGludCBwaHl0ZWNfZ2V0X3BhcnRfbnVtYmVyKHN0cnVj
dAo+IHBoeXRlY19lZXByb21fZGF0YSAqZGF0YSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGxlbiA9IHNucHJpbnRmKHBhcnQsIFBIWVRFQ19QQVJUX05VTUJFUl9NQVhfTEVOICsg
MSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgIiVzLSVzLiVzIiwgcHJvZHVjdF9uYW1lLCBhcGkyLT5vcHQsCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFwaTIt
PmJvbV9yZXYpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAobGVuIDwgUEhZ
VEVDX1BBUlRfTlVNQkVSX1NURF9MRU4pCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGlmIChsZW4gPCBQSFlURUNfUEFSVF9OVU1CRVJfUENYX0xFTikKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4g
QEAgLTM1Myw2ICszNjQsMjcgQEAgc3RhdGljIGludCBwaHl0ZWNfZ2V0X3BhcnRfbnVtYmVyKHN0
cnVjdAo+IHBoeXRlY19lZXByb21fZGF0YSAqZGF0YSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiAwOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiArwqDCoMKgwqDC
oMKgwqBpZiAoYXBpMi0+c29tX3R5cGUgPj0gOCAmJiBhcGkyLT5zb21fdHlwZSA8PSAxMSkgewo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzd2l0Y2ggKGFwaTItPnNvbV90eXBlKSB7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNhc2UgODoKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHZhcmlhbnQgPSAiUFQiOwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNhc2UgMTA6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB2YXJpYW50ID0gIktQIjsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBjYXNlIDExOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgdmFyaWFudCA9ICJLTSI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgfQo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbGVuID0gc25w
cmludGYocGFydCwgUEhZVEVDX1BBUlRfTlVNQkVSX01BWF9MRU4gKyAxLAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICIlcy0lcyUw
M3UuJXMiLCBwcm9kdWN0X25hbWUsIHZhcmlhbnQsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXBpMi0+a3NwX25vLCBhcGkyLT5i
b21fcmV2KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGxlbiAhPSBQSFlU
RUNfUEFSVF9OVU1CRVJfUEZMX0xFTikKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gMDsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gKwo+IMKgwqDCoMKgwqDCoMKg
wqBzd2l0Y2ggKGFwaTItPnNvbV90eXBlKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgNDoKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGtzcF90eXBlID0gMzsKPiBkaWZmIC0tZ2l0
IGEvYm9hcmQvcGh5dGVjL2NvbW1vbi9waHl0ZWNfc29tX2RldGVjdGlvbi5oCj4gYi9ib2FyZC9w
aHl0ZWMvY29tbW9uL3BoeXRlY19zb21fZGV0ZWN0aW9uLmgKPiBpbmRleCAxODc0MjRhMmI0NC4u
ZmRmZDNjOTY5ZmYgMTAwNjQ0Cj4gLS0tIGEvYm9hcmQvcGh5dGVjL2NvbW1vbi9waHl0ZWNfc29t
X2RldGVjdGlvbi5oCj4gKysrIGIvYm9hcmQvcGh5dGVjL2NvbW1vbi9waHl0ZWNfc29tX2RldGVj
dGlvbi5oCj4gQEAgLTE4LDEwICsxOCwxMiBAQAo+IMKgI2RlZmluZSBQSFlURUNfR0VUX09QVElP
TihvcHRpb24pIFwKPiDCoMKgwqDCoMKgwqDCoMKgKCgob3B0aW9uKSA+ICc5JykgPyAob3B0aW9u
KSAtICdBJyArIDEwIDogKG9wdGlvbikgLSAnMCcpCj4gwqAKPiAtI2RlZmluZSBQSFlURUNfUFJP
RFVDVF9OQU1FX1NURF9MRU7CoMKgwqDCoDfCoMKgwqDCoMKgwqDCoC8vIFBDeC0wMDAKPiArI2Rl
ZmluZSBQSFlURUNfUFJPRFVDVF9OQU1FX1BDWF9MRU7CoMKgwqDCoDfCoMKgwqDCoMKgwqDCoC8v
IFBDeC0wMDAKPiArI2RlZmluZSBQSFlURUNfUFJPRFVDVF9OQU1FX1BGTF9MRU7CoMKgwqDCoDjC
oMKgwqDCoMKgwqDCoC8vIFBGTC14LTAwCj4gwqAjZGVmaW5lIFBIWVRFQ19QUk9EVUNUX05BTUVf
S1NQX0xFTsKgwqDCoMKgOMKgwqDCoMKgwqDCoMKgLy8gS1NQLTAwMDAKPiDCoCNkZWZpbmUgUEhZ
VEVDX1BST0RVQ1RfTkFNRV9NQVhfTEVOwqDCoMKgwqBQSFlURUNfUFJPRFVDVF9OQU1FX0tTUF9M
RU4KPiAtI2RlZmluZSBQSFlURUNfUEFSVF9OVU1CRVJfU1REX0xFTsKgwqDCoMKgwqAxMcKgwqDC
oMKgwqDCoC8vIFBDeC0wMDAtCj4gXHd7MSwxN30uQXgKPiArI2RlZmluZSBQSFlURUNfUEFSVF9O
VU1CRVJfUENYX0xFTsKgwqDCoMKgwqAxMcKgwqDCoMKgwqDCoC8vIFBDeC0wMDAtCj4gXHd7MSwx
N30uQXgKPiArI2RlZmluZSBQSFlURUNfUEFSVF9OVU1CRVJfUEZMX0xFTsKgwqDCoMKgwqAxN8Kg
wqDCoMKgwqDCoC8vIFBGTC14LTAwLXh4MDAwLkF4Cj4gwqAjZGVmaW5lIFBIWVRFQ19QQVJUX05V
TUJFUl9LU1BfTEVOwqDCoMKgwqDCoDExwqDCoMKgwqDCoMKgLy8gS1NQLTAwMDAuQXgKPiDCoCNk
ZWZpbmUgUEhZVEVDX1BBUlRfTlVNQkVSX1NURF9LU1BfTEVOwqAxNsKgwqDCoMKgwqDCoC8vIFBD
eC0wMDAtS1N4MDAuQXgKPiDCoCNkZWZpbmUgUEhZVEVDX1BBUlRfTlVNQkVSX01BWF9MRU7CoMKg
wqDCoMKgUEhZVEVDX1BST0RVQ1RfTkFNRV9NQVhfTEVOICsKPiAyMQo+IEBAIC0zOCw2ICs0MCw3
IEBAIGVudW0gcGh5dGVjX3NvbV90eXBlX3N0ciB7Cj4gwqDCoMKgwqDCoMKgwqDCoFNPTV9UWVBF
X1BDTCwKPiDCoMKgwqDCoMKgwqDCoMKgU09NX1RZUEVfS1NNLAo+IMKgwqDCoMKgwqDCoMKgwqBT
T01fVFlQRV9LU1AsCj4gK8KgwqDCoMKgwqDCoMKgU09NX1RZUEVfUEZMX0csCj4gwqB9Owo+IMKg
Cj4gwqBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IHBoeXRlY19zb21fdHlwZV9zdHJbXSA9IHsK
PiBAQCAtNDUsNiArNDgsNyBAQCBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IHBoeXRlY19zb21f
dHlwZV9zdHJbXSA9IHsKPiDCoMKgwqDCoMKgwqDCoMKgIlBDTCIsCj4gwqDCoMKgwqDCoMKgwqDC
oCJLU00iLAo+IMKgwqDCoMKgwqDCoMKgwqAiS1NQIiwKPiArwqDCoMKgwqDCoMKgwqAiUEZMLUci
LAo+IMKgfTsKPiDCoAo+IMKgc3RydWN0IHBoeXRlY19hcGkwX2RhdGEgewoKLS0gClBIWVRFQyBN
ZXNzdGVjaG5payBHbWJIIHwgQmFyY2Vsb25hLUFsbGVlIDEgfCA1NTEyOSBNYWlueiwgR2VybWFu
eQoKR2VzY2jDpGZ0c2bDvGhyZXI6IERpcGwuLUluZy4gTWljaGFlbCBNaXRlemtpLCBEaXBsLi1J
bmcuIEJvZG8gSHViZXIsCkRpcGwuLUluZy4gKEZIKSBNYXJrdXMgTGlja2VzIHwgSGFuZGVsc3Jl
Z2lzdGVyIE1haW56IEhSQiA0NjU2IHwKRmluYW56YW10IE1haW56IHwgU3QuTnIuIDI2LzY2NS8w
MDYwOCwgREUgMTQ5MDU5ODU1Cg==
