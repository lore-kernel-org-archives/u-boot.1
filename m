Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B195D5B154
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 21:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C9B089137;
	Mon, 28 Oct 2024 22:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iris-sensing.com header.i=@iris-sensing.com header.b="VUBE8+xE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62EBE890C6; Mon, 28 Oct 2024 16:29:47 +0100 (CET)
Received: from FR6P281CU001.outbound.protection.outlook.com
 (mail-germanywestcentralazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20c::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C64890D1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 16:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=iris-sensing.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=erik.schumacher@iris-sensing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmbOtLQIwebDyqREMkoMYrwuSd4x2wRMK7n6fDXd6g/kIq4oICD82qHD/P3G1oCfwbJ16lUfITZc1FHb/xD0s3tylPT6hAeVgcW2jF+3kg+Xm09qDunU9o1rEUbtIKNz2jJLbMM0jSv/V+g+u3D7po8B8BfdIGbu7QJFXGkOpAy3rDg6rXDojqf+1WCKVWi56Lcmmg7CpPD/lNEqfavkllHx4DEdD8UBOM9uJQldpTBI/VQZtfmzVLtB29TcYdJblOLlck4HcOiqTOMHK8KbnM5Ntqghk11DuDijyvu5IGz2g0WRGky9K8C8WQpwU7LdGeVCFWibeV6qTW0N73NOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuzC4qYwyZzIR7DhL48wFsrmLffXQaVVZihruJlaNtU=;
 b=B2oBr4ywxK7NUURCtikPjBMC5/b71metDb9EiigC/Bgtra+sOhWhSAunsMzutbcV3MdndoFqpfNNfn6AJPEFXBsjBAfdn+EEsnFMSDcQv5ufdeXtay9L6pK7sxlZE4S3bAwddLJbSjGpE6EHF8NM/YbiOYb7cmJoSg2lHObtFOVLNdDg7INRaNPRhrvBeLF5RzC6eEuowH5Sl6MXTjYbddlIRbJ1yQF/+9neYCZO5eVErNM/yaVxS4Noxs1BmYmkgay2PlYZti1UupHpcGD2nFyrDnZs3zdw12Y1tWmwmwFr9MxPzWqP3QAzK1G55sQi39hUKuG3K4XWWVVXHxnUsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iris-sensing.com; dmarc=pass action=none
 header.from=iris-sensing.com; dkim=pass header.d=iris-sensing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iris-sensing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuzC4qYwyZzIR7DhL48wFsrmLffXQaVVZihruJlaNtU=;
 b=VUBE8+xEFzMiLANQ0fUvzeUQB+81FdD0Uogn94qCM0MAwBFAd9FFTkDKROMPZLMKPylGD5gc2Kv2a6fd68Vu9cqI0y4JJO8h/pgQBsZG+IFFWwbDicv2tLSvjhFhyWxyEPyKRjcLBT5aTjRR6CLIAijpbQJLxkMa00CnG8x4P9nPQ0hrUTLRyKgSLslO/UxRPFDubbdIX8EoiuNDwa4DRGM2beYq0wDCiy7qJQGFDQdjhKLO8YID+SnfzmmEq9Gj641CuSr2aNoGDiQmY1L1D3ryRN7Z8PhRvkp5eSBiucc3Vmonjy9vzVZjGwz1b/kAZSySbicpJQN6h1X++leECQ==
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:23::8) by
 BEZP281MB2597.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:2a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.27; Mon, 28 Oct 2024 15:29:42 +0000
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e]) by FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e%4]) with mapi id 15.20.8093.025; Mon, 28 Oct 2024
 15:29:42 +0000
From: Erik Schumacher <erik.schumacher@iris-sensing.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "pro@denx.de" <pro@denx.de>, "marex@denx.de" <marex@denx.de>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, Erik Schumacher <Erik.Schumacher@iris-sensing.com>
Subject: [PATCH 1/3] net: dwc_eth_qos: Add support for platform specific reset
Thread-Topic: [PATCH 1/3] net: dwc_eth_qos: Add support for platform specific
 reset
Thread-Index: AQHbKU41siQupLLIjEqVBYtz0svryA==
Date: Mon, 28 Oct 2024 15:29:42 +0000
Message-ID: <ad6c9edb5194d8fb5b61fd6cc1d36fbce09efc6e.camel@iris-sensing.com>
References: <0b4ebdf6a0219a871eb031fccd9aa6d8c9cb2348.camel@iris-sensing.com>
In-Reply-To: <0b4ebdf6a0219a871eb031fccd9aa6d8c9cb2348.camel@iris-sensing.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iris-sensing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB2809:EE_|BEZP281MB2597:EE_
x-ms-office365-filtering-correlation-id: 7d0f02be-d87d-4ae2-bd7a-08dcf7655880
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?L1BZRzhPam1xSW1HN1VSbXRBRWxWakpNdUQwUFgrbW83RW0rclFEckg5UVRI?=
 =?utf-8?B?RHFBSVJMZEQvVXpZZzlqYjg1YzZwYlVyL2U1ckFYNHgrUG93SExycmIvOHBW?=
 =?utf-8?B?TEF2RXBSTVg0SXZ6SWxJZ3VKd21vYzdodFlOS0V0cjJheFNBRE5TWU5uZE5H?=
 =?utf-8?B?UjVyOXVJSldMSERRM3FRZVZWS1lrTzNTeWxyRXdTNUZBVmVZeGhoaFJNWVJQ?=
 =?utf-8?B?S1BSWExxZmVuN3BZQ2JEd05hdHQrU0FXRFMyMzRyaEw2c2x1SVZwYW9xQnBD?=
 =?utf-8?B?anJPVGUyc05hWnhSVGJvV2xqZU5VWXRIY1RibEEwWDhCMVBPZmdZUStaZGFU?=
 =?utf-8?B?cUlkYkFtU3E3bGRpNE56M1E1QXVlMTB4dEtZb25ucmt0NjNSV2FtamFIN3JU?=
 =?utf-8?B?ZlFwdzFhOEdjc05IYlQ2eUFoMGkrQkJHdlRzVTJsazM0TEluQktlK1hrTVY3?=
 =?utf-8?B?eTJiK3pGdFBOcGl1NGNWanAxWThCcE9ucUhVNTlmRmZMUE5uZGZQc05jWEF0?=
 =?utf-8?B?cGpPMjZQc2Y1V1ZVZjhiMThkdFJSc0xiYWQ0Ukd2VmJqMkYzcjY1WmhpMEhS?=
 =?utf-8?B?Wkkrcm5zY3dvYmdBQ0IzSVYrQzZ6dUgzdStObVpkY2JMTG90YlFuNy94WDZZ?=
 =?utf-8?B?RDdEY0Jxek9yZGFPZkdSRGxic3RPRENpMGxzaVBMUEE3NVhaUGJ1NWdvSFpr?=
 =?utf-8?B?QUgzM2pNWWdVdENXRU5tcDlXbk1XNGlzdWtLTTlsbzVBeWlTazIycnV0WEpz?=
 =?utf-8?B?MkJWWTZzNmVkbmtPUE5vcnN1c05PQXE1aHlqWWxJZlpYcHZQQ0tpNDRGUXc5?=
 =?utf-8?B?QlR1Z0dmSXAxNU5jUXdsWnNOTjlwNlMwaC92N2lEcTFmbFk2VCsrWGJTN1I0?=
 =?utf-8?B?Y2xXbWZtT09mdGp2Q3B0VXNwb2RvUjhUMVFaUzBSMHd6RURzbG9FL2N4V0Jw?=
 =?utf-8?B?dktNdUthYXJHbjVLQTZKVVJKTjJXNEl1cjdjUS9meVRIM0tZQ2JFZTZRbkVB?=
 =?utf-8?B?M2NBS3FFNkVMQ25UeUhwd0ZmWmd3a3F4WG5ManNVYXhkUjhFeFM5NUw4c0ZP?=
 =?utf-8?B?Z2ZodUpnZThySXQvdCs5aEdIWDlhd0ttdUVKM0FtSTl5U0p3em1KZlo5dkw2?=
 =?utf-8?B?RTExWjlYaTRQT3lNcVpWV2Y5U0ZBTGNiczJHWno3YnhSNnZzbDFqVkMrSWNN?=
 =?utf-8?B?NzFpekVLcjVOdDVFZUxYZElrdDFnTFVleWRFVEtBTjJiaTNyNWJiU2RvWnQ0?=
 =?utf-8?B?THlDcFdKSFlmT0tDQk9kTGFwMVdaVmdaR1dFUHhCeFVzNlBPSExkUEQzaXMy?=
 =?utf-8?B?cVJrbnl6S0Z0TEtDK2h0amhqNGZoSlpIdThiMTVidjZ1RWR2c0dZQ0UrZTNt?=
 =?utf-8?B?aVJWaitaVk9tbi9ocUFMMThWY1orYVdzRlZSYmV4TzBLVXJDSVV3RlNOdk1q?=
 =?utf-8?B?ZDBVWHBXWHk4czRZV0xsUnZsUGxqVjlzbWZOcmoyVjFSSDFabTgvUURISWpu?=
 =?utf-8?B?cnhVdlhEdFNKMTY0NDNSVjhEaHJRQ2xTOVFvOWRlaUJybFZZbHFCTzRNV0pC?=
 =?utf-8?B?cGJ5SnBoUzBKcURWS0VyTVBIbjdOT0JrdVFGdVUzWVZqekRqSnZvVWVERXFM?=
 =?utf-8?B?Qis3MVIwTmpNZzZ4SVA0dDA1TUVGS1RrQXZwYTRxckQwSUE0Q2ltbHRyNEJE?=
 =?utf-8?B?WGhsTkJyYzNKZkF4b0xUc3BmcS9mcFQzVEpUY1k5SUMwV3RIdW9hc3U4anlF?=
 =?utf-8?B?QXNwa01hR2phY0phOUUrZFpxODZNeFhIY3QrbDFWTDdWZFRJUS80YXdHeThE?=
 =?utf-8?Q?DNXCiCxRmrPpfv0ktAhQBE10v/Y4FTCfPu3lo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmRJVWpDeFNpdnA0dFBJb0dqcm5ZRWV4Vlh6cEtEK3J2WW9VdndFSStBMmFG?=
 =?utf-8?B?dXR3UktSN3dhTFV2K0dHZ29tTFcweWdkYk94VHlZYzZaeWltVEo3Y21MbFEv?=
 =?utf-8?B?MmdQNFkveXhaczVZbmZNSEhENHppMVlxdjVyNWJibWlOOWVGQWZpS0Y1aDVB?=
 =?utf-8?B?MlMxYlhtYk1FRk1sK0VzdUh1Ty9kOS9QK0Jyay9xaDI4T0gzajNxdkNxbEg0?=
 =?utf-8?B?cGZsT0RVTmJyazFNdjh0ZXhhcjJWR2lyZGRHbVErMWhmZ0xXOUE5aElQbHJG?=
 =?utf-8?B?UWd1dU94WnRtN3dNcGlWV05WM0dTK21YWks3NU5DRi91ODM3WSt1TXV5ZEc3?=
 =?utf-8?B?dEVxMHdTMi9qQzgxZUxRWjVxRythOVQ3WGs5NDBRbE5uakxPdUl3WENWeHlw?=
 =?utf-8?B?dlI3WGx2TjBkby9HaXBrb2FTbU1KcE41T3A5b0x0em9PT0drZCsvbjZiSlNl?=
 =?utf-8?B?SXhybHVTOXNqTjBRdkZ6bnhXOHNDSXdRVGRtMHdkK3hUdjNMUmhHdys4b0pE?=
 =?utf-8?B?UnNCNExHaWQvL0FDb2xCRnNudTJWZlc2SFBQeUUrNGFIVkt0S3NsTGJGR1VP?=
 =?utf-8?B?bms1N2xJM1lQTDA4YlEzZWNIRWJ3ZVQ3amZ4Ym8rYUhFTExlNitYNzI2Sm1z?=
 =?utf-8?B?YXgySWZsRjcxcFVtbkhYYlF1SUJ1VC8yRTBHb2lSYzdkOGY3NHcydFo1STdQ?=
 =?utf-8?B?am92czYzVzZjcEx6ZnhLcGRVejZLVForZVoyVURlOHFLck1mT3d2UmtreDV3?=
 =?utf-8?B?Qno0STJBWWcxanQrRTRrTDhtK0dvUGtQRWR1dHQ4cEM4OUlLZXRoYlY0NlZp?=
 =?utf-8?B?eC9oYUVmeXI4L1pCdURHZjBsK1pqSWdSNS9tb1JXazlhdHN6NjArWmN6NWRS?=
 =?utf-8?B?bXdDcTRrMEhnUkhKeFNrUGppSGVkZG9JbWJEU3Y5R1diaWxzQlFvZTlGMGly?=
 =?utf-8?B?QWFBQzZIV2ZMTVUwZlhoWmRYQmtBdmlPcnZCQXkxVFZ6aisySTFaYzZ0WGFj?=
 =?utf-8?B?SlIvR2JHUGJLRW4rd1QrVmV2SjVJd1RaWmRTd1pNeEZLNGVaMGEvNGFYbmhW?=
 =?utf-8?B?VVg2NXVaNWJMb201L080Y1cydWdKWmlBdGlPUTZPRHRJeTRReVFqSXltRkNU?=
 =?utf-8?B?eWlWdUhqdG02ZE43Y3FUUlJiS2g1aTlzeFNQV25xY2ROUDlPK09KYkJ6MWg5?=
 =?utf-8?B?N3hYaDQ2eHg1Ty96aExUWW0rZTVtMjRxMkZRTWhDejMwSjJUbXBqb0dKTHhM?=
 =?utf-8?B?cmxqN1d5bkdKYkNzWU5lVDJUU3NTZm9PSnNSVTJZaTNFYlBSK1VIb3czM09W?=
 =?utf-8?B?RHpJRlhnZTJxNHp4Y2tkclVKcjVOeTVqL1ZnRW5QNDJCQStrOEkvTmNKVG4w?=
 =?utf-8?B?Zk4xRGU5VmttajFrRmpkdldmSEUyZitJL2J0bGh5YWpTem1kN1ZFcVJQcVVF?=
 =?utf-8?B?V01mYjJiYWNFQ1Vld3EzU0Z2MDBIbm1oM0xvTUlkSkhGRVNlOHJVNkZNTG1O?=
 =?utf-8?B?KzV4UExTZlFNemc3TUtFMkk5czFuM3pia0lXMm83Y3ZHSnBTRnhXeTIvTlIy?=
 =?utf-8?B?WFhoTlMvcEhiMGMxZXBObTlZNVpPV1pOUWgxdDJqb3BFZnU0dm0zcklwVUJl?=
 =?utf-8?B?czRYZXh3V1dZQW8ramVlcXUrSXZpdTZnMllPS1ZIMEVGQ3dWTThBVmJNYzdC?=
 =?utf-8?B?K0swUmpubzBJbW5ZOWg5ZzhtWXlWM2JFUWlmeWcwK0lFc1dKN0V3azB1Rm9N?=
 =?utf-8?B?K3hETUFnQ1lydnF3a2JqaWkyLzFZdTVUTmFPYUord2dvWW82aTg3aUFISWt5?=
 =?utf-8?B?UGdYUElwRnFUZW9jdFg0WEc1Z2FucVpXK2VPRGtmU2UxLzZkOFg0MU8zcXFy?=
 =?utf-8?B?d095SHZqMEFZVFJvTlp2R1J0UG9rdUNqS2R0L2NtZ00zd3NWaEhVTlhMYmFp?=
 =?utf-8?B?aDdwR1pDU2hQOEVVYlFLNFFBMFFobVRtemNnMmRXbHJYWlZVenJQRHhENGc4?=
 =?utf-8?B?WEpTcjhONU9sNlBTTHFUK2puOTg0TGRBZU43V0NWdS85d1ZpWENBZTVSUndU?=
 =?utf-8?B?bFVWSDlFSEFMK3FpeUpSNUhvY0lxVm1ONGIrSDdKTkFYWDJsNHhnbjZkSDFo?=
 =?utf-8?B?bXhIa0Z5a1RmWkVJeWsvZ0ZrS3lSTkxmWHlHazByQnNYNFlPRjdQTjZqdGtY?=
 =?utf-8?B?bEs3ci8xOGlzb1R6d2RNMHNuQ0FjeDNJMWRiTFdHLzR5cjJCMzRnME5MbHNx?=
 =?utf-8?Q?1MTI5dDerGlIo/ZC3Se0nI7X/TDy3NPBsC4G71IoMM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F8887230E78984D992BE9D5310302F2@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: iris-sensing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0f02be-d87d-4ae2-bd7a-08dcf7655880
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 15:29:42.7795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 963f3913-ffae-43fd-856b-2dfd3f6604e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rw/TnGoiJcXSsigwxZxC+hcxTnP17XiWw9qOajDNsYgaIEwwFEw0HGrtztFdBj6Bj/mSwmME7MkgA2b7xXhZAE1s5kwo5t9wem8wL4LQdXzguubCdTcQndp8LZe9LmFN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2597
X-Mailman-Approved-At: Mon, 28 Oct 2024 22:32:48 +0100
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

VGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIG9wdGlvbmFsIHBsYXRmb3JtIHNwZWNpZmljIHJl
c2V0IGxvZ2ljIGluDQp0aGUgZHdjX2V0aF9xb3MgZHJpdmVyLiBUaGlzIG5ldyBmdW5jdGlvbiAn
ZXFvc19maXhfc29jX3Jlc2V0JyBpcyBjYWxsZWQNCmFmdGVyIHRoZSBFUU9TX0RNQV9NT0RFX1NX
UiBpcyBzZXQgYW5kIGJlZm9yZSB0aGUgZHJpdmVyIHdhaXRzIGZvciB0aGlzDQpiaXQgdG8gY2xl
YXIuDQoNClNpZ25lZC1vZmYtYnk6IEVyaWsgU2NodW1hY2hlciA8ZXJpay5zY2h1bWFjaGVyQGly
aXMtc2Vuc2luZy5jb20+DQotLS0NCiBkcml2ZXJzL25ldC9kd2NfZXRoX3Fvcy5jIHwgMyArKysN
CiBkcml2ZXJzL25ldC9kd2NfZXRoX3Fvcy5oIHwgMSArDQogMiBmaWxlcyBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2R3Y19ldGhfcW9zLmMgYi9k
cml2ZXJzL25ldC9kd2NfZXRoX3Fvcy5jDQppbmRleCAzNDE1YzQxOGE5Li5hYjUxYTk4ZTlkIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvZHdjX2V0aF9xb3MuYw0KKysrIGIvZHJpdmVycy9uZXQv
ZHdjX2V0aF9xb3MuYw0KQEAgLTcxMiw2ICs3MTIsOSBAQCBzdGF0aWMgaW50IGVxb3Nfc3RhcnQo
c3RydWN0IHVkZXZpY2UgKmRldikNCiAJICovDQogCXNldGJpdHNfbGUzMigmZXFvcy0+ZG1hX3Jl
Z3MtPm1vZGUsIEVRT1NfRE1BX01PREVfU1dSKTsNCiANCisJaWYgKGVxb3MtPmNvbmZpZy0+b3Bz
LT5lcW9zX2ZpeF9zb2NfcmVzZXQpDQorCQllcW9zLT5jb25maWctPm9wcy0+ZXFvc19maXhfc29j
X3Jlc2V0KGRldik7DQorDQogCXJldCA9IHdhaXRfZm9yX2JpdF9sZTMyKCZlcW9zLT5kbWFfcmVn
cy0+bW9kZSwNCiAJCQkJRVFPU19ETUFfTU9ERV9TV1IsIGZhbHNlLA0KIAkJCQllcW9zLT5jb25m
aWctPnN3cl93YWl0LCBmYWxzZSk7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHdjX2V0aF9x
b3MuaCBiL2RyaXZlcnMvbmV0L2R3Y19ldGhfcW9zLmgNCmluZGV4IGNlNTdlMjJhODEuLjEyM2Y5
OGQ1ZDUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC9kd2NfZXRoX3Fvcy5oDQorKysgYi9kcml2
ZXJzL25ldC9kd2NfZXRoX3Fvcy5oDQpAQCAtMjQ4LDYgKzI0OCw3IEBAIHN0cnVjdCBlcW9zX29w
cyB7DQogCWludCAoKmVxb3Nfc2V0X3R4X2Nsa19zcGVlZCkoc3RydWN0IHVkZXZpY2UgKmRldik7
DQogCWludCAoKmVxb3NfZ2V0X2VuZXRhZGRyKShzdHJ1Y3QgdWRldmljZSAqZGV2KTsNCiAJdWxv
bmcgKCplcW9zX2dldF90aWNrX2Nsa19yYXRlKShzdHJ1Y3QgdWRldmljZSAqZGV2KTsNCisJdm9p
ZCAoKmVxb3NfZml4X3NvY19yZXNldCkoc3RydWN0IHVkZXZpY2UgKmRldik7DQogfTsNCiANCiBz
dHJ1Y3QgZXFvc19wcml2IHsNCi0tIA0KMi40Ny4wDQoNCg==
