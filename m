Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B436D29DE2
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 08:43:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63D5783979;
	Tue, 13 Jan 2026 09:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="gHhuruL4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC1AF82C7F; Tue, 13 Jan 2026 09:19:23 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B0E803F5
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 09:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kx1egU32uQqJrZeOmGxBMiycMsiazxkfqo45LxlM9hoKs8wFH4hNPtHWG4mbzNjLxG3sVNMF3CHQcsm7sAf9dZkUv0q40/dtE+rMaCpxYpPHsEJMUTFO4bApQ4jNEvOHk164sSRW8jARa3iVm6rDtagI08dHy+hKy9kLlxvGFiUgFvZv0zloQYBUI0Cc8kBIjshyHQmp7iXtvSTAGjGcaBnkjk8653scMpE6lD1xHmbTfp0ySNWPIiVXrRi9ddPjhvQltd6VpCOBs60ploOvPelgcbyy7yfb3iUFaz/20y1Ug24mpOWUO79O8o46ubwh2l4Z2g6bLOUDDaH0ysIwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYNX6yoFFARn1JRM6RFdwRnXQNBDFUaEdDrsNI7iOXc=;
 b=H3GsMFLHqt/X55cdAoDEzvox7Zq0omdh1vaOrkCF7257WQagmPfZB2vsBuUfUDmZL0N3kSM5huFOCoQ4N9RIQoWVN39ml7KcM4npAIVNjVnBy2bkWHRN9w9tfAHVj9qgyfufg/hBd41d5cexMcJ8wHqJu1bPZnMDyGstJNT0xdYYzJAschXOp9lylHScvB3zySAAMvfj9Mlrjw+jtREYKqOAW5ZIvH1x9Yj8XT5iJySsfmjc4SW8HDkj1E8kEVjY9z4Y9JunczKXRHHpZuCCRrSiNGfZZw+6M4igKZtcIC8qKIlm4zJpk5STyh0biXtnpPOKa8FGzUxnuTFYdaCSnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYNX6yoFFARn1JRM6RFdwRnXQNBDFUaEdDrsNI7iOXc=;
 b=gHhuruL4HdJwpLNvYR56LRd8felforOBpLBwfQt1dT1dhqQUlsU8glCHG8v1c+Usiky1KmbfKDlUrzn6IVZ+dKW5KFy3zyI3xC/8HdvrquZZPbE1hLJEbYOaUgHQi2kuduwfjkWFAhkryORvMYoVrE6QTij02mfXwkkrR+cQbp+A+WTLlohGj/38a8KwEeVLI2/3T2SZAy70hIsYsbG7hLNfRE0UNXJKpR/lbYlNcTpWgl747V1w1dYQldbAW5CukJO+kos+FqCBLEaeX+klzI2YKMv2YZEKQcge13BrpoqKiBued/BKH3O4jguSNzg4r6HYTOXowZD6zk4yzSIy3w==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by PA4PR09MB6514.eurprd09.prod.outlook.com (2603:10a6:102:26b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 08:19:19 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 08:19:18 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: Yao Zi <ziyao@disroot.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 09/10] riscv: boston: Add support for LED character
 display command
Thread-Topic: [PATCH v4 09/10] riscv: boston: Add support for LED character
 display command
Thread-Index: AQHcEPTHlbhKd/LjnEqPAfjGwK+3LrS5+kGAgJauc4A=
Date: Tue, 13 Jan 2026 08:19:18 +0000
Message-ID: <c437079d-c190-4c69-9600-de49439f5131@htecgroup.com>
References: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
 <20250819103021.1518687-10-uros.stajic@htecgroup.com> <aOeZbQ_Ew64f1ohn@pie>
In-Reply-To: <aOeZbQ_Ew64f1ohn@pie>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|PA4PR09MB6514:EE_
x-ms-office365-filtering-correlation-id: cac70f7b-9931-4422-cbad-08de527c72a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cmR4MzU4TnRNVWdzKzNDMmtrZk1zbTc0WDJ4SnZKSTUzbDg2Y1ZPMFVhMWRK?=
 =?utf-8?B?UG96K1c2SHd0aFh0alFGbUJwekFHWUxrN29qdWlEZUlHTW9hMWlhZmgrc0pp?=
 =?utf-8?B?dlVwYnJnV1E0eWkvRTVyZ2pBaTJ1aHdLWDUrTFpuZUcvMHF6K2xOZzdJaENy?=
 =?utf-8?B?Z2x5NjZJS3Vha3BaY1ZmRjlmdk5jSWpMeFVRd0NEelFEVkdPSHlIZEF2SFBH?=
 =?utf-8?B?WHowZDltWWl1QnBXQ0pOcU9KMGZLRjAveC9oYVB2czNhTXpBOUwwSmI2ZEcv?=
 =?utf-8?B?QWNWdXI0R0FKWnZ3bDhsQkR3R2JZMnNNalhtNzZ5eUs4Y01keWFwWGpXRVRQ?=
 =?utf-8?B?N3ZnYm9WNUJ1dldvNThZYlJFMi9wZzR1dGVOUDk1RDRqdk5vSEJlZXBVUVk0?=
 =?utf-8?B?YldzR0R5WS9rWkZLSGpZUXR1MDBnTjhtMEhBNVorTnM3Zzl1TEpORnB4ZExk?=
 =?utf-8?B?U0FYenovc3NUcTdTcUFuMTF3dE93NUpDckg0WUc2cDlXWDRvK0hzVnE4Y3FM?=
 =?utf-8?B?cHZoMUVqUGhzVkpQQXV5aklSVWpRa3hXTWpTbUxEWjV1N2hYV1pidURrNlhi?=
 =?utf-8?B?cjFIZ2x5SUFTMEh0aGpFb0hQbjJSa0JQM1hWRmpPWWdUeE9lQWMvS1BucHox?=
 =?utf-8?B?K0QzSTMzTVpRNUMxNnVvTEFoSlM1NlR1dFduWnNJdHRNWi9ZYlhBSVMzL1dm?=
 =?utf-8?B?ZXM1WXlBb3RXK2Q2VzBKSjQxSXFtSHJyTituYzYvNitPWkRXWkdLQmhsMVlM?=
 =?utf-8?B?dXZ6OG90dlVzVCtsSkhUZFQ3RklRUy84bDJ3ZXorUkxQYzZnNEZnQ2hONkhF?=
 =?utf-8?B?NmlkTk5sKzE1Mk02aUlKVmVPSStpaisvV09kOE9pT1ZsSEQ3bks2QUh2djlY?=
 =?utf-8?B?YXBsbkZLYVZwWE9pMFpDTU15b3VrSHlZaEx5TGJQZVBtaHpNa1MzL3Y4Mnpq?=
 =?utf-8?B?SlpKZVBwUXNtd0ZxUWxwMTlzdm1mT1Z4dzBXdU1oWDlIcEkrN0o3VWNRQnIz?=
 =?utf-8?B?U1IyOVBvMHAyZlF4UEVWVXc2T1ZqUDRET0ZMWTVhUmFPcTlyZ2JNQXR3cVhj?=
 =?utf-8?B?THg1VGw5d1hRc01tSWViQTFBdys5cEtycnpYRE9yclV1dHRhRGNaTlljQ0oz?=
 =?utf-8?B?Z3J1NXgrV3ErWjJuQmpNb1Z0K1ZkZTNEODZRMFFCVUFKNGhkeUl4SmpzRVZM?=
 =?utf-8?B?ZElnTnNHcXNwRXlmZ1dkZXBOWmVJMXlodXNwWFhobjF2MmloYUZiTi9paHlE?=
 =?utf-8?B?ZEtSMnFGQWpKRlZjTUZGZmNUa2YxM0plMUxWT05jaHhQNlBOSGR5dm1LeVJW?=
 =?utf-8?B?MGVmRzBwNW43YXJ4NTAzN3FMZE1mSnFGb2hqYUcxaXRla0pYVjh6aEZ1MGto?=
 =?utf-8?B?M2lQTHA3bWluOU11VzRpdWxncElvdWZKV2pVQkdDZlA4NDc5eW5YV0Z4RHNy?=
 =?utf-8?B?bk5LSzVQcXdLTDh4YjRxZmtTVERyMmdFdElIY2lYdjRzKzVhNXZJRGpqelJE?=
 =?utf-8?B?YXVZRGpUQ0tsa2RER29wMGdkSi94c3dhMVJTWHA2WkF0Nm96ZithWWkydGd3?=
 =?utf-8?B?bUNFbVNrUXZrNUhYR3NDMXcvYUkvVVJ3Q2lxVmwyaG91SStZbnVhK2hvR0Fv?=
 =?utf-8?B?cW1paXk1NWsxampUa05SNUlwM09nYi9VZDJOTEV4R1p6dS9oVXEvc3ZkMWt0?=
 =?utf-8?B?QWk0QW1ydXNwT2tIbG1pWnZCNGM3QVk5SldXMWZBa0NLVHVPalNUMWd6RmlP?=
 =?utf-8?B?dWpvZTdyeW1HT2U1MUw5STY0aGV0L3dzTWlVaXlDT2tXRWFOL1YxUUsxSURm?=
 =?utf-8?B?c0xtejdaZGhSU2lBOStoR2drYmFPQ21ISGRwSGhmOThSMGtOelFWb3pQZTlH?=
 =?utf-8?B?MzFYeFgrN3JZcHJ0Nk1WbDVBWUlWTEljajhBREdjSmo3UnV6aTRlTUlLdExR?=
 =?utf-8?B?VHljMjlYVER6cTByZzVhWGRoL3pXeWJVM2xPWFkwTEI0YjJmQVhmRXRkK0JX?=
 =?utf-8?B?SVBSM3ROSzEyVkF4YlpPNVN2Ti9mMXNITnhFUnkyc1F3UDQrWGZCci9NaExl?=
 =?utf-8?Q?dGjIUj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkNoalZFQ1Zta25XNzVxWTlLbE1SNlY0cmNRRUNsbzIrWnM5aE1TYXd3N0RI?=
 =?utf-8?B?QkNSa1dhazRkd2kvOCtVUHNWTDNxU2FhMTFpY0VMNjI4ZG1hZG9jMEd1cEUz?=
 =?utf-8?B?eGwzbFp1NUNzU1dDdVdJTzFyS3hmT3dva1hqVlU1ZVFJdE9DemV6UGR2QjlM?=
 =?utf-8?B?c3ZWSzBKNlJXRGttd25ZZGJXeFA4RnpqZFVwN0NlMndjWGZLbEROUzRVVGVL?=
 =?utf-8?B?WnpoM1ZYNEtzTU93ak1Xa1FGOTNDM0ZCdWI4M2NRaFh5aEZCVmdXZ2VYL2c4?=
 =?utf-8?B?aVpsTWdFSVZwenByeC9uYitNVTVUbVFqN3kzeGNma3p1QVg2cWNjMEY3cjEz?=
 =?utf-8?B?c0ZhdjBMbnJsSzlML0ZGY1dvVFpWUXc0V2JwVVh0Tk9DWEFRKzBCZTdOZzJ2?=
 =?utf-8?B?eEJiYzI1UW9pUDVpL3R2bmNzbmNKYmNyUjhHaHdDNjZUNXc2VEdYbkl5VTZF?=
 =?utf-8?B?WW45MGpNMjcvMVdaS3FZdFpGOU03TFRvUmpwYUFWbWNxOXpjZXkybC8xaVFz?=
 =?utf-8?B?UVQ4Vlg2Ykhya0lTNCtJcWc5SnVFcHBKWDF5MWo1dFVFdGpzZkk5QXZzclhP?=
 =?utf-8?B?Ym5UNXFGb0pDaFJPUTVoM3Y2SFFIdnpac0YzZE1RNmR0Tk9SL3IyK1dWNWFL?=
 =?utf-8?B?TEtJMDMwRWozYnplLzhCeEtBenNHQTlUamovcVp3VXdUU2UwNWM0ZVRMMTNQ?=
 =?utf-8?B?YTNJRmFBaWNiTWVVWmE1S0xYb2Fwcng4Z2lwa1M1Q3hUcEs4L3JCVktGRDJL?=
 =?utf-8?B?ZFZyVWxwRVpieGZSenNGZkFtdjdGQ1FIWmM1Ny9OYmZVd1FvcUluMWJMeTRF?=
 =?utf-8?B?MGRBQ2xzNVFDZGZvWmhqUDB6eGpqcXpnRnY0MXcybkFwNGJxcDJ6ajVxRi93?=
 =?utf-8?B?SUtrVWdudlV1VSs4bTkvVkE5ZjhXMmFmL3p5R1dBS0syWHZsOUdHWGIvYXNS?=
 =?utf-8?B?VFdrejRqMUVrVVliZGFXZ3lpcEIxaXZmVEVGSHZvTnFaUERORFR0TGs4QkZZ?=
 =?utf-8?B?RlMrd3lwdnU5bnVZdDN0cmFEbTVLYWVzL2xoby9QcGpOemNlMkRjU2lQNmRV?=
 =?utf-8?B?L1ZGb1MzSjJyK1VMenl4SnhlV1hkSjl4YmVVVXdkUVBVNDJrL0Q5Z0pKMTFp?=
 =?utf-8?B?MUxha2dhcDZrUDl3NzlCTUoybUJIc1UzajNlMDVBcUloUlAxbW9Vejc0N3Fi?=
 =?utf-8?B?dnYvNVNmV09qTWFkUFZwVWJFbTFld3NUTFVHZWg3alJqeVArZDRDM2dTQlFZ?=
 =?utf-8?B?V1o4eE1iS2I0L3MyMlVObXE5d3A0RGxuY3FuZEl4eE1WWFpZdnlSTG9LaEZK?=
 =?utf-8?B?S3hxZkFHN2RNSWlMVTZoTStPZ1JTaWdWNHZReWtIQnRta3hObGtOaGRhWERI?=
 =?utf-8?B?b0lUTUtGYThDWmJPdldFMXAvdkdBRW9ZUEVCMEpLOWlES1FTczlQeFFpZEZW?=
 =?utf-8?B?NkdxeG1pcHprYWJUTUJ0T2greEJLb0hJOSs1RXpiWjYrbEh3WHlBaDJHdEEv?=
 =?utf-8?B?Ry9zV0VJclJNVmw1TG9vU0VjRnFiMmpKVTA3dnU2R3oyWC9SL1oyc2FESTYz?=
 =?utf-8?B?QkVTbkNYUHA1YStGUlJLTWF6dFg2M2NjK09OdmN0UklzMnc4NnlmNWxXSTNB?=
 =?utf-8?B?OXRycGR2ejlHbTFPUUpncm9PeWw5MlJrSjd0N1pDQ0w2QzE0V0xERWh6Q1pl?=
 =?utf-8?B?YlJBS1UvNG5GR1FJaGxDSGF3R1B3c1FSN0tKaXRjWnB5QzlYaXZWZHFuRTc5?=
 =?utf-8?B?RjgrOXh0VDhkZzFkRVgvYnFtcmtVeFJucHBvQkF5L0VIdlJBVWxQVVpWUXp3?=
 =?utf-8?B?aTlvcFpGUWFtOTFyZlNNNjk5UUNsU21BcE5vdFJsck0rOVlzSzFiRnphQm4r?=
 =?utf-8?B?ZjlMek55MFJBaW5pS2pRMFJTS2FHNDJXbFVSNHBLNldiV0F3NlFaTExDUmE5?=
 =?utf-8?B?NGFNTjRqTTdwUW9BeUFXWmhOY0tFQWFGcERrMERDQ3ZubGlGSTE2RE5hUDBx?=
 =?utf-8?B?cW90OUgyKzN4K3dqQ3gxTnZORTRjRi95QWFRQXFVVFNFVWgzSG9PVytFRFo5?=
 =?utf-8?B?K2VrS2x4Q3U0T2c3TngvdTNJaEhTSG12cmR6V2luT25RUW5odFpUalgxYzNO?=
 =?utf-8?B?MXR6SDMvUm8rcVd4ZDZ6L01rTm1XOFlycjZ5bTdnYlV1blRFZzVienY2M3dt?=
 =?utf-8?B?WElLSUoxT3RaNFgxakVGR1l6REE2UjcvK1ZmVTFrbGg0anZuNEFBdE51aFFt?=
 =?utf-8?B?ZUxLVStjb2grNm5TRFVBa2hYTlNINktUbjZYLzRpRUt2TCtRNk91aVBrR0lE?=
 =?utf-8?B?NStpbGVITDJNUENXVnE0a0RDN1RYU1BINEtHVTJicTRwVTJXRWJFckYvL1FW?=
 =?utf-8?Q?HrxqnX4BzD1ScouA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <525B19001313A54FADEC3524960D900B@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac70f7b-9931-4422-cbad-08de527c72a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 08:19:18.4613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0LmN/cEWpJrIdAF03TXgu3gA9cZxYwRZOzJdrWuac+07E4WjKyfgTo6mZJn0nNCBR6TUuQpfWnfMxd6uxCZy9pi3q2PaK+T0VYRWUnz3ESE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR09MB6514
X-Mailman-Approved-At: Tue, 13 Jan 2026 09:42:06 +0100
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

DQoNCk9uIDkuIDEwLiAyNS4gMTM6MTUsIFlhbyBaaSB3cm90ZToNCj4gQ0FVVElPTjogVGhpcyBl
bWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUg
c2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gT24gVHVlLCBB
dWcgMTksIDIwMjUgYXQgMTA6MzQ6MDFBTSArMDAwMCwgVXJvcyBTdGFqaWMgd3JvdGU6DQo+PiBG
cm9tOiBDaGFvLXlpbmcgRnUgPGNmdUBtaXBzLmNvbT4NCj4+DQo+PiBBZGQgYmFzaWMgc3VwcG9y
dCBmb3IgdGhlIDgtY2hhciBMRUQgZGlzcGxheSBvbiBQODcwMC1iYXNlZCBCb3N0b24NCj4+IEJv
YXJkIHVzaW5nIGRpc3BsYXlfc2V0KCkgYW5kIGRpc3BsYXlfcHV0YygpLCBlbmFibGluZyB0aGUg
Z2VuZXJpYw0KPj4gJ2Rpc3BsYXknIGNvbW1hbmQgd2l0aCBjbGVhciBhbmQgaG9tZSBzdXBwb3J0
Lg0KPiANCj4gSSBub3RpY2VkIHRoZSBzaW1pbGFyICJkaXNwbGF5IiBjb21tYW5kIGhhcyBiZWVu
IHJlbW92ZWQgYmFjayB0byAyMDE5DQo+IGluIGNvbW1pdCAwMDVhODA0ZDBmMyAoY21kOiByZW1v
dmUgdW51c2VkIGBkaXNwbGF5YCBjb21tYW5kLA0KPiAyMDE5LTA1LTIxKS4NCj4gDQo+IFRvIG1l
LCBJdCBkb2Vzbid0IHNlZW0gYSBnb29kIGlkZWEgdG8gYWRkIGl0IGJhY2ssIGF0IGxlYXN0IG1v
cmUNCj4gZGlzY3Vzc2lvbiBpcyBuZWNlc3NhcnkgZm9yIGl0Lg0KPiANCj4gQ291bGQgdGhlIGRy
aXZlciBiZSBpbXBsZW1lbnRlZCBhcyBhIHN0ZGlvIGRldmljZSBpbnN0ZWFkPyBBbmQgY291bGQg
aXQNCj4gYmUgZGVzY3JpYmVkIGluIGRldmljZXRyZWUgdG8gYXZvaWQgbm9uLURNIGNvZGUgYXMg
bXVjaCBhcyBwb3NzaWJsZT8NCj4gDQo+IFJlZ2FyZHMsDQo+IFlhbyBaaQ0KPiANCj4+IFNpZ25l
ZC1vZmYtYnk6IENoYW8teWluZyBGdSA8Y2Z1QG1pcHMuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTog
VXJvcyBTdGFqaWMgPHVyb3Muc3RhamljQGh0ZWNncm91cC5jb20+DQo+PiAtLS0NCj4+ICAgYm9h
cmQvbWlwcy9ib3N0b24tcmlzY3YvS2NvbmZpZyAgICAgICAgIHwgIDQgKysNCj4+ICAgYm9hcmQv
bWlwcy9ib3N0b24tcmlzY3YvTUFJTlRBSU5FUlMgICAgIHwgIDMgKysNCj4+ICAgYm9hcmQvbWlw
cy9ib3N0b24tcmlzY3YvTWFrZWZpbGUgICAgICAgIHwgIDEgKw0KPj4gICBib2FyZC9taXBzL2Jv
c3Rvbi1yaXNjdi9kaXNwbGF5LmMgICAgICAgfCAzMyArKysrKysrKysrKysrKysrDQo+PiAgIGJv
YXJkL21pcHMvYm9zdG9uLXJpc2N2L2xvd2xldmVsX2luaXQuUyB8ICAyICsNCj4+ICAgY21kL0tj
b25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDggKysrKw0KPj4gICBjbWQvTWFr
ZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArDQo+PiAgIGNtZC9kaXNwbGF5
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDUxICsrKysrKysrKysrKysrKysrKysrKysr
KysNCj4+ICAgZG9jL1JFQURNRS5MRURfZGlzcGxheSAgICAgICAgICAgICAgICAgIHwgMjYgKysr
KysrKysrKysrKw0KPj4gICBpbmNsdWRlL2xlZC1kaXNwbGF5LmggICAgICAgICAgICAgICAgICAg
fCAzMyArKysrKysrKysrKysrKysrDQo+PiAgIDEwIGZpbGVzIGNoYW5nZWQsIDE2MiBpbnNlcnRp
b25zKCspDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBib2FyZC9taXBzL2Jvc3Rvbi1yaXNjdi9k
aXNwbGF5LmMNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGNtZC9kaXNwbGF5LmMNCj4+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRvYy9SRUFETUUuTEVEX2Rpc3BsYXkNCj4+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGluY2x1ZGUvbGVkLWRpc3BsYXkuaA0KDQpIaSBZYW8gWmksDQoNClRoYW5rIHlvdSBm
b3IgdGhlIGZlZWRiYWNrISBXZSBhZ3JlZSB0aGF0IHJlaW50cm9kdWNpbmcgdGhlIGRpc3BsYXkg
DQpjb21tYW5kIGlzIG5vdCBhcHByb3ByaWF0ZS4gVGhpcyBoYXMgYmVlbiBhZGRyZXNzZWQgaW4g
djUsIHRoZSBkaXNwbGF5IA0KY29tbWFuZCBjaGFuZ2VzIHdlcmUgZHJvcHBlZC4NCg0KQmVzdCBy
ZWdhcmRzLA0KVXJvcw0K
