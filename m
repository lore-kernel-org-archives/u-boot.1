Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA60CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 06:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FDBB807B1;
	Mon,  6 Oct 2025 08:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="GQxsxp9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 524FB8206E; Mon,  6 Oct 2025 08:01:41 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ECC6800D7
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 08:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWaX06z+/BMMrNsf/Gqblb4RcVTuWqSPIoVQquJiGeUgpvzBaIyG2ERnTdF8iNb9Z+SS0NwnSyDIY/78UmQD4A9YEMSHVtqC7nHLDvqwm9TacL4hbpWGoAGCY2Vbk2Bgd7Ka+n6mEJRH/jLZpbz6jJUCzaAb90ihl37xgHlsycqYZW1tj5ucWxzNmIPH1lh3zHtRfAeR7qXSwrW/zkJX+gnLyxurPfBPoPeoCDreN/JaQbPczS/4cl94qaaYtXQ1Ya6RvK4MkO9PPaTAYFudmDglEtkFy7OZKB3+FyE5TJcxeNCZmksvwrWOZaGvGJPy3nXGhlcl1DiGR4Shwzcr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxlR++RrO82kb46nYzMMcuKmgomSHAj4/xKJgtF3ypc=;
 b=rwoVMPomfPTSGK/2WTcuE9GeMOPsxWDZ6DMqDOwsbB0tdWBJExwFXX67ShvMIZt46B6qcAX4UY89tJse8t1SIzxcecisTtCQZmWE7wZfaDM1vJUgYjb5ricfzKTkwWUXIYULvQRRDrvBiHAqP/vBeVo7uxYkMJj53QGPvVs5hOOs8RSju+5XhKAJpi/CHFwxyXZofeYdhK/2xQwvKGfq6ezqzjsENqDFkNWzOJb1UaBzM5WaSNoMUwQnNv9Kqx990gfWe5HbPkYYdIGmdAO9KQoXIvVz6j0CWwbns4zCcw32z+DS1s674bvumVRgXzVpijA/pil1ofLPPBysqFS71g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxlR++RrO82kb46nYzMMcuKmgomSHAj4/xKJgtF3ypc=;
 b=GQxsxp9WUsGQSa17QLqzZa7Vs+x/eEZEV7EGf7qgFdBVk7tccSMryPUkokMmS7TkMFS44gm41O9iNhn7WJVj12mixtHha1pAoR9cH1+CA5iODJUXl/qzYge1O74NST/HsuOAn2lVmipCdLXfV9frufXxJJhdO1hO8iP0S8wk7E5TD6hk+recX/8PIpdpQt9tf1bEy8l2MGQUuSh7/C97k9LioFoM67FmHeVBVRMCjKCwO8PNqxEn6IOplmk5RKCidm1qX5D09WNw9RNV6RlUw11iiA9GTKnsTm0XxKuMps/WOFwsNnSamstten+sUGFxxbeX3ubeGY3jcbqTNMXfOw==
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::12)
 by AS8P195MB1255.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3c2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 06:01:37 +0000
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582]) by VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 06:01:36 +0000
From: Martin Schwan <M.Schwan@phytec.de>
To: Andreas Pretzsch <apr@cn-eng.de>, Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/2] bootstd: rauc: fix doc and info msg to reflect real
 flow - test cases
Thread-Topic: [PATCH 0/2] bootstd: rauc: fix doc and info msg to reflect real
 flow - test cases
Thread-Index: AQHcM8Gg/UN8Ew1woEmBIobC3LKkZrS0pdUA
Date: Mon, 6 Oct 2025 06:01:36 +0000
Message-ID: <cdcde4cd10945f2a686e1f191797a4d2fface36c.camel@phytec.de>
References: <20251001232259.3599563-1-apr@cn-eng.de>
 <CAFLszThMci29aiyCUfEwUpWjdncQ=KQZfvBsSz961=KYjy2u1A@mail.gmail.com>
 <a47c21cc55ee6856a2c69ce20649e273ff32ef06.camel@cn-eng.de>
In-Reply-To: <a47c21cc55ee6856a2c69ce20649e273ff32ef06.camel@cn-eng.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2489:EE_|AS8P195MB1255:EE_
x-ms-office365-filtering-correlation-id: 643b0555-5880-4037-0762-08de049dcf51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MnpsYi9SY0tqRkp6ejRON0pyamoyMzUwUWN0VElnczNnOWFIZmJkWFVuUDhX?=
 =?utf-8?B?UThIeWREckR5bGl4WmtxMm5EeVdTcm1HNExCdGZwT21pOEZOeUlYY3M5SHF4?=
 =?utf-8?B?ekhGNWVqQ0JpdEE5ejl3M0JyQVNtei9RdEd4YUV2dG5nMVUyMFNpbWV3S1N3?=
 =?utf-8?B?UVFWV1laQVBKL3IxamVJejRhQy9JUGdNR1hybFVpYUhwSkUrNGREak9uY2JE?=
 =?utf-8?B?Zy8vdmNiYVl5N1l0TmNOaEdFUXk5UmhyakR0N3U3WHpNT2NkWFk1Qlc4L0hv?=
 =?utf-8?B?M0RHV0tSTGR4UlpmMUZ1d2hOdmVPUCtEMVROQ0w5bkhrRCtQTFNtb2NYOHdk?=
 =?utf-8?B?NHNZa1VaV0JjMXBybmFUZGFMRFZ1SDZ5cy9yS3BYRWVsK2c3amRlWXl0bnNj?=
 =?utf-8?B?ME5EQmE0TFV4dk9OZ0wxTFN5RXpRV3hURlpWdFVPMkpyR3F2K1BRREJRQ2Rk?=
 =?utf-8?B?WXRGeWdqS1ExVXdPbUNVcFdWTXV2eGM5TkV2MWFUVUNWanlMUi9WMCtpNlY5?=
 =?utf-8?B?bzdEcnNJQlB5NWVnWk9YOEFFemp4bS9uV0NlZzJTOEI4WGNFcUZFeW5SNW5K?=
 =?utf-8?B?RURuMlBJWTlpSzVudlE1N3FmUGFaVHk4bHlPWEJvUXp2dlJrM1NjaW90R01P?=
 =?utf-8?B?Y25vOXlSR05jcklrNnZhdUJ2eGJDZkJxam5sRm9rMnVYQ01RRDh6cUJKeHg2?=
 =?utf-8?B?UkphRjlSQUZNNlIwOXlJckt2UWZ2eUZSaTlFRG1obG1VTWplTDdxYm5FN1p1?=
 =?utf-8?B?bEt3U2tqcG1sQWxvYisvbm4xc2l3dm1xWTc1cFRjNlJQQmxVbUd2ZlNieWt6?=
 =?utf-8?B?bUsyZkhlenR0KzBRc2sxdTcrR1N5M0djZXBoUU55OTI2a3lFTUlUZEdSYjV1?=
 =?utf-8?B?cE5IdW1SM0YzZnB0ajBjUHJzblhhOXdpVks4U1EzQWhjQjR6ZGlLUkJKUzhv?=
 =?utf-8?B?YWtYeE5kT2taQmJxbGJkY2s3L3VYVFhnT2tXUjZBbCtRbmU5eXU1M0R5ZFpX?=
 =?utf-8?B?TjNYMlU0Nmd4ZGJPYlM4Q1llNUdxeThDWTVuRUtjcFhJY211OFZQbWw0N2c2?=
 =?utf-8?B?b0kzdTRyQSs4c0YwQngzM3l0dEFoRlJBemI1djMwb1h6SlYyZ0docDR5U0lG?=
 =?utf-8?B?MVViWldNTUR0aGljVTNQNzUwUFlWUy9ZZzh5K3F1QUhsdGtXaDlsQjd0QWEv?=
 =?utf-8?B?ZFdQYy9CbHV4QlhFdVNzVWJESGMwYnVCejNhcjMvOWFSYzhrVXUweXZpWFVk?=
 =?utf-8?B?ZUFsTjdsSktzMkRDcHN0R0MwZGs1bStpOUNwQW1IczltQ1VJSDI4bFlTcmg2?=
 =?utf-8?B?MFpaV1FCTHdHYnVGV05STDRMdFBNNjI3a0JQS1lockNOc2FqM3ltTzNoSExR?=
 =?utf-8?B?eHNpeVhiN2NxRjBQSkt4ajBuVUkwV05SQlk2a3BQWnhBT1JBeDIrZTJ6VHZF?=
 =?utf-8?B?b1RvcEhNdFZMSmJrUEFwWEFPRElzN0NhMXNlcnY3dW45L1h6Y3RDRDRGM3A5?=
 =?utf-8?B?MU1iV1ZXUmVCL3VoRlVXVFA0alNpNGZJaDZxVlJraWJPZTJnYmQ2Tjc2ZE1M?=
 =?utf-8?B?dzUzSE9HZFExZ3RtZVVOWEFubVV3Y2VqVHdUR1ZBWjluTlJpc08wZnQxQlFl?=
 =?utf-8?B?bS9McGtrT24rZmdZNWRsczB0aHNFbmkyeFh6RlFtZVo3d0V2MUpOTmdBUmo5?=
 =?utf-8?B?RXQwZDhtUGYxd2k5b2R6N3NmdGVLOWxGaFVOem4vbThuUjNIenBiKzNmVU52?=
 =?utf-8?B?Y0M1Mm9qYTFiTWthTXhZc2VIOXNENlV4MTVvd2FsNVlHQU1QK09Wa282Tyt3?=
 =?utf-8?B?cS8wZkJjVWV6MWpCTEFBY2xOaFVESXg0VklrYWdOOEVkSldUc2ZzTkpzZEti?=
 =?utf-8?B?Z0w5WGF1WnQxZGF4UWZ4VloyZWcrZVVLR2FGOTFZSWxhS0hWbG1MT3UvREZT?=
 =?utf-8?B?eEE0YkFPUm56dUtWeDBMWHd4OVZSRUFPdDBCandraGRkdGtjaFYrMHFyZlBC?=
 =?utf-8?B?Um9BSlRWR0JvRTVpdTVBV3h2c3Fyc2ZrVTJpTDhERVU1N2NDdUJ4dDlzTDQz?=
 =?utf-8?Q?S3bZg9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2489.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzRuWWdYQVQwajFGUHdPMmRyVnlHSGRvWHNwWCtkdXhIOFZRZThjSHVOa3c2?=
 =?utf-8?B?ZVk5c045TTVMZ1RFek1MYWZ4Sy9sVzR0ZHpScHlJMWhmVldtQVJoM1JNL3FS?=
 =?utf-8?B?Yk5wK1ROeTFRSkVoeWhCVE9JM0gwOTF0ZHZaTmxvRmpTYkFnbSs3TDRlQ3ZB?=
 =?utf-8?B?aTMzeFRjaWtqUTllRFMzMXROQzkzODQ4cEVmZ2ovQXFzSWpKNE5kNkVqYldR?=
 =?utf-8?B?dVpPTGo4TW9ONlRRZDFRVk9zd1hlcnJDZG02ZytPQjUydTI2NmZKM0pDRkEz?=
 =?utf-8?B?Ry85dHl1ZUE1eUs0UFI1aHgwQXlMSFhqYnB5Y0ZZNTN3MjJjMGVLTTFtVTFt?=
 =?utf-8?B?MllsRC8vZ1NKRDdqaXVIQ2kraEs0V3FqZjB5cFJ4akY0TUk5d3d2QTdVRmdx?=
 =?utf-8?B?RFFENlVUSWFWT2pSRkJKYU54M0J3N3NwczJUclg1a3FKNTZiR2tNNU1Ldzd5?=
 =?utf-8?B?SXVjWElseFQ5TmJqS1JCUHh5bjJNd1Q3MlpPeW90c1BJMmZITXg2KzVZM1ZW?=
 =?utf-8?B?MVVLMUtndXBmSEVhampESk01amN6K3ZYWmZCRFZDbk1ldElnbjB3a05RVEZz?=
 =?utf-8?B?Q2ZEQzdvY283dVAzcnMrSEhJeXRxNlpFTit6UmUyZEpnV0tvQklkWnlaV2RG?=
 =?utf-8?B?VWN0MWdmSWJ4R1k5YXJZL1o4L1lYdjhsSXF5LzMxRzNrMnRCTWRqRk5PNFpi?=
 =?utf-8?B?ejk2L0VzK05IM3hnTmNSUFV3VXRjckVtN3IzRGF2MjNpeUhzNkhaVXdpcmEy?=
 =?utf-8?B?TGF2M3dUaElHcXB5a0lKV2kxb3J2S21Eb0dxRG1nTG9wREllY1JyL0paQnRi?=
 =?utf-8?B?ZmpWWlhkYkJsRnVLM1VwdFovTlBrRkE3dzcvS2ErRVhMcFdZR1VqZmxQNVUw?=
 =?utf-8?B?REM2NFNXdmF5QWl6WHl1YUlIRXo4dHhZWGowQjVzbFJSODRFOHVUeERpKzk5?=
 =?utf-8?B?OGpWS2xWRVc4YTNQSWxTZkZhdzlKcG5XVmRibjFUMlBUYU1JeG9XSkxvNEZL?=
 =?utf-8?B?RGZvRFFSelNxeFVRYWdkT2xmdFBsTDduelZBWE5udWFGOE5WVysrcTRRbUhG?=
 =?utf-8?B?SThUV2YyR3Ivdkc5NHd3T0pKMEViL2ZEaUZSMHJ3NHpkN3U3SFZzUUtSYmRl?=
 =?utf-8?B?OXpYakp1S2pzdWluTUc4V0NaRjNITkVFU09Jc2tuVEFwOFgySFhzSEpKbjcv?=
 =?utf-8?B?NXRRekI0RGI5Qkp4Nmd6NGVUMWtQNk92RjJLYjV6dm9nbzhESElnL3NDdHY4?=
 =?utf-8?B?c0RZVTM3OXJPKzJBaGVFU0MyVDBiM05Va1lyaVN2R3FBbjlTOXdxOXdHWDVx?=
 =?utf-8?B?Y1Z2a1J0SmRib1ZPc2RBSXB3UElqRUdqbStmZUpyYzVvcmJlRTl2OTZMVEdD?=
 =?utf-8?B?YzdrVnNiWTMvL2dJK2s4MEI4STc2T0ZzK2VVblFLWVp1N0NST1ZkWGZWRklh?=
 =?utf-8?B?MzVwUjlkaDdjRVA2VmlNSmd0ZEo2WlRBc1VIWldCV0xWR1hreEdZMTg1Vjgr?=
 =?utf-8?B?ZThDRFRXRVF3bWFzdXdkQlRFMmVhRzRIdHRBRDQ4MVBrZzh4OUcyWlp0aVdT?=
 =?utf-8?B?YWlOSnhaRDlQSEZDQnFLVjh2MVpRZFBpSHhzeE1XbCtWUEZMdi9UWFM3TUFo?=
 =?utf-8?B?ZWRlbVZsR0szd000R1drSlkxOHZiS2ptaTg1Vmpid3R4QTc5elZuVElYU3pW?=
 =?utf-8?B?MGlUejQvbU5tZWRnT3ZUZUNNMUR4Y3dFUVVxN1piUmp6cHdUeUR4RkplUlB4?=
 =?utf-8?B?dmRiSjRkcEtSOWpudytERWFPd1JHcCtVb1Vod1dGTVVaeUFFa3c1Z0w4bHlN?=
 =?utf-8?B?and4Rk5qU3BmQW9TOXM0NlJUN29Yd3VTeUcvNXlFbUZJcWVIY2d0ZXZlTGw4?=
 =?utf-8?B?SWpiQkJ1a2MrVld6SzNvdzN4bU9Eb1BiSFJXL25jbVlLeVd1cUhnZFZmcmoy?=
 =?utf-8?B?Q25FWXFwV2ROYjRkTjJ6RXp6MVQvd0JscUFuTlZTUklVR21YSzBzVGJ6d1Ft?=
 =?utf-8?B?aFU1bG00MEpyZEVYSTlRZXd6Y29WYjhYZzJGZ3lYdkRDNWRGakErMjdTSC9T?=
 =?utf-8?B?RmVVRFlyeHYyTTFKT1ppU3g4N2crV096UVkxN1Y5WXNyU0wwZTdsdCsrRmoz?=
 =?utf-8?Q?MsLS/n9xqse+YANDOV1O08c/6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A308AA1FE2C7C41A5FC13F1A60644CC@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 643b0555-5880-4037-0762-08de049dcf51
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 06:01:36.7052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3xXCeEuc+QtSdP+PRbEPmVc+ZbjWjp1vZ29Q4UOKwStWCEa8qHepbsvU/eJskIG6L6GBCyq86buZXrNoFUdAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1255
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

SGkgU2ltb24sCgpzb3JyeSwgdGhhdCBJIGRpZG4ndCByZXBseSB0byB5b3VyIHBlcnNvbmFsIG1l
c3NhZ2UuCgpJIGhhZCB0aGUgdGVzdHMgZm9yIGJvb3RtZXRoX3JhdWMgb24gbXkgdG8tZG8gbGlz
dCBhbmQgSSBhbSB3b3JraW5nIG9uCml0IHJpZ2h0IG5vdy4gSXQgdG9vayBtZSBzb21lIHRpbWUg
dG8gZ2V0IHRoZSBleGlzdGluZyB0ZXN0cyBpbgp0ZXN0L2Jvb3QvIHRvIHdvcmsgKHRlc3QgaW5z
dHJ1Y3Rpb25zIGFuZCBlbnZpcm9ubWVudCBhcmUgbm90IGVhc3kgdG8KdW5kZXJzdGFuZCBmcm9t
IHRoZSBkb2N1bWVudGF0aW9uKS4gSSBob3BlIHRvIGhhdmUgc29tZSBwYXRjaGVzIHNvb24uCgpS
ZWdhcmRzLApNYXJ0aW4gU2Nod2FuCgpPbiBUaHUsIDIwMjUtMTAtMDIgYXQgMTk6MjUgKzAyMDAs
IEFuZHJlYXMgUHJldHpzY2ggd3JvdGU6Cj4gT24gVGh1LCAyMDI1LTEwLTAyIGF0IDEwOjMwIC0w
NjAwLCBTaW1vbiBHbGFzcyB3cm90ZToKPiA+IEhpLAo+ID4gCj4gPiBPbiBXZWQsIDEgT2N0IDIw
MjUgYXQgMTc6MjIsIEFuZHJlYXMgUHJldHpzY2ggPGFwckBjbi1lbmcuZGU+Cj4gPiB3cm90ZToK
PiA+ID4gRm9yIHRoZSBSQVVDIGJvb3RtZXRob2QsIG5ld2x5IGludHJvZHVjZWQgaW4gVS1Cb290
IDIwMjUuMTAKPiA+ID4gWy4uLl0KPiA+ID4gCj4gPiBXaGlsZSB3ZSBhcmUgdGFsa2luZyBhYm91
dCB0aGlzIGJvb3RtZXRoLCBkb2VzIGFueW9uZSBrbm93IHdoYXQKPiA+IGhhcHBlbmVkIHJlIGEg
dGVzdCBmb3IgaXQ/Cj4gCj4gR3Vlc3MgeW91IHJlZmVyIHRvIHRlc3QgY29kZSBmb3IgYm9vdG1l
dGgtcmF1Yy4gSG9uZXN0bHksIG5vIGlkZWEuCj4gCj4gSSBqdXN0IGNhbWUgdG8gbm90aWNlIHRo
YXQgdGhlcmUgbm93IGlzIGFuIG9mZmljaWFsIHdheSwgc28gYnVtcGVkCj4gdGhlCj4gVS1Cb290
IHZlcnNpb24gdG8gMjAyNS4xMCBpbiBhIGN1c3RvbWVyIHByb2plY3QuIEFuZCBzdHVtYmxlZCB1
cG9uCj4gc29tZQo+IGRldGFpbHMsIGhlbmNlIHRoZSBmaXhlcy4gSSd2ZSBnb3Qgc29tZSBtb3Jl
IGluIHRoZSB3b3JrcXVldWUgKG1vc3RseQo+IGltcHJvdmUgcHJpbnRvdXRzIHdoYXQgd2VudCB3
cm9uZyBhbmQgZXh0ZW5kaW5nIGRvY3VtZW50YXRpb24gYSBiaXQpLAo+IGJ1dCBub25lIG9mIGl0
IHdpbGwgYmUgcmVhZHkgYmVmb3JlIDIwMjUuMTAgcmVsZWFzZS4gTmVlZHMgcG9saXNoIGFuZAo+
IHRlc3RpbmcuIEknbGwgc2VuZCB0aGVtIGluIGhvcGVmdWxseSBpbiB0aW1lIGZvciAyMDI1LjEx
IG1lcmdlCj4gd2luZG93Lgo+IAo+IEEgcXVpY2sgbG9vayBpbiB0ZXN0L2Jvb3QvYm9vdG1ldGgu
YyBzaG93cyBzb21lIHRlc3RzIGZvciBleHRsaW51eCwKPiBlZmksIHZiZSBzaW1wbGUuIEkgZ3Vl
c3MgdGhlIGxpc3QgY2hlY2sgd291bGQgYmUgZXhwYW5kYWJsZSBmb3IgcmF1YywKPiB0b28uIFRo
ZSBmaXhlZCBudW1iZXJpbmcgbWlnaHQgbmVlZCBzb21lIG1hc3NhZ2UsIGJ1dCBzdXJlbHkgZG9h
YmxlLgo+IAo+IEJ1dCB0aGUgcmVhbCB0aGluZyBpcyB0byB0ZXN0IHRoZSBib290IGZsb3cgaXRz
ZWxmLCBhbmQgZXNwZWNpYWxseQo+IHRoZQo+IHN3aXRjaG92ZXIgYW5kIGZhbGxiYWNrIGhhbmRs
aW5nLiBXaGljaCBpbiBwcmluY2lwbGUgaXMgY29tcGFyYWJsZQo+IGZvcgo+IGFsbCBtZXRob2Rz
LCBidXQgZGlmZmVyIGluIGRldGFpbC4gSSBjYW4gc2VlIHlvdSBhbHJlYWR5IHdyb3RlIHF1aXRl
Cj4gZXh0ZW5zaXZlIHRlc3QgY2FzZXMgaGVyZSwgcmVzcGVjdCBmb3IgdGhhdCEgSG93ZXZlciBJ
IGhhdmVuJ3QgbG9va2VkCj4gaW50byB0aGVtIHlldC4gQnV0IHByZXR0eSBzdXJlIHRoaXMgd2ls
bCBiZSBhIHRhc2sgb2YgZGF5cywgbm90Cj4gaG91cnMuCj4gCj4gV2hpbGUgSSdtIGhhcHB5IHRv
IGFzc2lzdCBoZXJlLCBJIHJlYWxpc3RpY2FsbHkgd29uJ3QgZmluZCB0aGUgdGltZQo+IHRvCj4g
YWN0IGFzIHRoZSBtYWluIGltcGxlbWVudG9yLgo+IEJ1dCBtYXliZSBNYXJ0aW4gU2Nod2FuIGFs
cmVhZHkgaGFzIHNvbWUgc25pcHBldHMgcHJlcGFyZWQgaGVyZSA/Cj4gT3Igd2UgZXZlbiBtaWdo
dCBwdWxsIGluIHRoZSBSQVVDIGRldmVsb3BlcnMsIHRvIHNvbWUgZXh0ZW50IGF0IGxlYXN0Cj4g
Pwo+IEkga25vdyB0aGVpciBjb2RlYmFzZSBpbmNsdWRlcyBhbiBvdXRzdGFuZGluZyBhbW91bnQg
b2YgdGVzdAo+IGNvdmVyYWdlLAo+IHNvIHRoZXJlIGlzIGFwcHJlY2lhdGlvbiBmb3IgdGVzdGlu
ZyBhdCBsZWFzdC4KPiAKPiBCZXN0IHJlZ2FyZHMsCj4gwqAgQW5kcmVhcwo=
