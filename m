Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500CEC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 11:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A812606E1;
	Thu, 20 Aug 2026 11:19:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id prLgIryIIchX; Thu, 20 Aug 2026 11:18:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787224739;
	bh=1cXmeRqxdFyD7jyMo6S/3jMdRUWgwkcgy5Y3pASv678=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gbHlKQJI+pVG6JLkWIm3gSYmLoEtV+5LwUxoElKCPUcKDn17NHsdvc2DdhgZCXsP7
	 ZOnMTN0naX630VJ56HbQwS/mUBPt/V0pne3LA8JmVRMu/O/hi/4osTKbkTcGGlZYvk
	 1U3qWWBMfVrUzcXUGJhkaQGw4hJxl8RJWVuBraX5U0V+xHj1JD3x/9o7wOtIr0sQiA
	 Ij6m6YB66pjDiSN0QNO7+diCIj258cnTseLcoZ4TlDBtKcmKZ2SfX2ffkRuOu8DBdK
	 r4pNxxRUVn1TIBEQV35W6HPoz6QyDf/ccVToKfDsYCLjQB0xpPF8312tFULitfUZ8Q
	 cjZbKFUpYETaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 702F760739;
	Thu, 20 Aug 2026 11:18:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 22B8E29D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1411260739
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:18:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UjucRFF1f4ue for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 11:18:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=BW6netuf
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B0BBB606E1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:18:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aB70N8MR2gH2Zg9Eok5bWprY5ZczWrseB+7mMOB+EhxYxvr3iiYCEVPxtB3fLYwlD1JYFXBzP8zAyI2FMC9VCD0m4zTa46vBJ0oZLfdBJ84fF95VR8laRkawdL9QcwWpzMyZ8dIc3O/98wb8mokR9HSYj60sAXEnF9m/5oFC/As6SiKWfl0E4Su6lwd8BGMQ9pYBpvx7ol7O+B0+El96nQ262AyCSivu4QCQxs4w5J2RCwHokDGbBRnh/g7gyuBJZFVnWg88+/oAYyrpJkDQY8p6pIhJeMekmZind3RyN4zfNnWy0gfIaV1Hmg8wLU1sa3gcZjI3abddo5LXG4RTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cXmeRqxdFyD7jyMo6S/3jMdRUWgwkcgy5Y3pASv678=;
 b=rdZhGN0wom1f/0YRGGGiXy4YOVYsSJOIETGZyUfzHn2s1Cy3yLOFuc/hjtuxXzLTDWnN6ThQqawe+tn1AN9mxFoujxpnBHXxwML68sMTWKRA/s+bqIKdM1ArHuKEFP+CW+lER9FuhNfcZifnt0eht34z9LF9y9RcexzbBvO/AN9NtcxYS8IztnQzWbrm/ktL2l2ogVRZouAkZfLSJgMlVKKeXcx8MLMDVwHuYViWb1hjiE+H4p/C64FGN4IMeGyOX+RyjS4ey/MkjdwFHJqP7aSEfbxCoUPyidiOrVS1mfcLgWcKsV9VJnIvue1rP+nJ9bNxQEWzV9o4EsfdJg0YEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cXmeRqxdFyD7jyMo6S/3jMdRUWgwkcgy5Y3pASv678=;
 b=BW6netuftRkf7eZi38618OiRrL0iLMVMq97WYh9ujBW+eVWCrmavgfY1dOqWhQNSJywOvXSiHZcJaozXX+LAzXvg+z9uFkjlNr9TpA040Ms99gYAY/KzPekIXlQjA45MFQ9LISf61cPtJTOt//VKJzyzryhHUrO9WKNpoYESq6Q=
Received: from PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 11:17:45 +0000
Received: from PH0PR12MB7470.namprd12.prod.outlook.com
 ([fe80::c3e8:ee3e:aae:e211]) by PH0PR12MB7470.namprd12.prod.outlook.com
 ([fe80::c3e8:ee3e:aae:e211%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 11:17:45 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: Peter Robinson <pbrobinson@gmail.com>
CC: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "Simek, Michal" <michal.simek@amd.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 0/8] net: mrmac: Fix Rx packet loss on back-to-back frames
Thread-Topic: [PATCH 0/8] net: mrmac: Fix Rx packet loss on back-to-back frames
Thread-Index: AQHdMIYQ9GlLlPpDfkev4BbWRo1ChramvF2AgAAMz3A=
Date: Thu, 20 Aug 2026 11:17:44 +0000
Message-ID: <PH0PR12MB747094D9C3D0C7B5854FA9E8ECA42@PH0PR12MB7470.namprd12.prod.outlook.com>
References: <20260820092623.1647844-1-padmarao.begari@amd.com>
 <CALeDE9NAGVvWm4Gt6rK9h__f6o4_TuV0fGjoB1WdWd5=7pQHhA@mail.gmail.com>
In-Reply-To: <CALeDE9NAGVvWm4Gt6rK9h__f6o4_TuV0fGjoB1WdWd5=7pQHhA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-20T11:15:03.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7470:EE_|CY5PR12MB6297:EE_
x-ms-office365-filtering-correlation-id: 478c5293-f3ea-4aef-f0bc-08defeaca8a5
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|10067099003|5023799004|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: wudJO6IbxJK7E4tiv5w7GinV1Ya++qIUxQDIRkW0ESsqZ4jhcMp0/N6tu2Jwz0fVtnvaek+Jfm+sNkMgQtcPLan4mn2zEVZWt4MFMVvPE4a/uJWR6pDO8QRTNafu2C3jzyebpfWNUZ7b1Kd2pKkFzJ4PeoPNV1crgpeK0xQ4sbfHloKJL6QVR/FEOTYkPXBMng9L8RmtdzMpQw5I1AuggGVpni3O6F3RaQYp3rBS1XvJGbtAv0EWDVaQCcqekAdxPx/OwipH39zOh75RarYmvzD+RKJFigMs9i8vtwm0TwdsVb+YyxdfaBO2ucINFJIJdau8weXdBs7oD2uyGXJlidnJaMWZ4/mXyu0hWz94lJpR7c6QFjmqDDcC9YvuAxLgLfpT09sRRQ2rAO/5U+R6I+yo0jSwFP9J1sDwASkCZHUaKVTleRTRXfBPOAaYTl4Y3M0qf1pUtGyYTkA9ZtHsEnEnrmvjupshUwxXKHuktY+cm3dQRMzzhA9i/eNyk5xWZNd992XlGCqV1tuGSjr/PBmCH73HcxHqWS7GK9CRTkmXd1gi1cD37pMxFDzGXW8w6akwqvoRUx4g1GAeaiPVzYESyOPO+RwfK+zl3lmMGk9bNj2htuHMc5RDeH5oiopJdUkuEbQXjurCOaDcfdUifmWAXQ0dlOhGnVI2+s8Yh+Z4SlFYYvTb1C8UDL/+sjBWF7SGADzHFJyKurk4+9gwA6wHgW0TWS2owm9JATKx1Yc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7470.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDdhakhQTDU0MkozNlkrZVBuR3JzZkRSNmtCbzFmOGJTT0N1bmZGQVJFbFlS?=
 =?utf-8?B?dFJLMTgvQVlSa3NxbVIxUFprNlZpTWduV1ZweWJRNUF0WTF5SkdsOGdFa3NL?=
 =?utf-8?B?WUQwL3pNL0U1VGdmVExBNlNSNkNRckdwZ3dvYWFCbnZUU2w5cS9vR244bjlN?=
 =?utf-8?B?N2FJeDZzVDZKbUplcUNLN1gxMGFoVHhSQ0lyeU84clVVd1BGYTdxcXNpeWNq?=
 =?utf-8?B?dTdUaGozcmFCSlNzVXdKODE4cmtKck8zZXArbkptN0JuRnRGdmF2VWw5VDIw?=
 =?utf-8?B?aGprbDNQdHNDOTQ2N2pYdkNOVlVSQ3Z3OHdJcUx2QWYwS3h1QWtKVGxUT1VZ?=
 =?utf-8?B?aUxlYW93OEpSRXROaWY3NHZkRXAzZE50SE1LWm1YWlBOb3BIQm1XWFU4SURx?=
 =?utf-8?B?TFVzam9VZWxLd2Uvak16blJYR2VoT01sVmZjRENYbG50OTJtczdHOE91UFdF?=
 =?utf-8?B?dlFLQW1DcTZMZ2RPaWtYTE12NGcrN1ArMkU2NzhId3dJWTBnY3I5WHI1NjBV?=
 =?utf-8?B?SSt0V3p6ZGFneUYzVTVnVC9vUUNiamZKVFBvVHpzc3V3WHhtcTN4Q085cHVP?=
 =?utf-8?B?UCtBZFRxdEFBa1FCWGJlczhhYThDK3VaL0wrRXZFSnM1WUhPV0RURFZiOVR5?=
 =?utf-8?B?ZlZIM3J2VWNVWllFRWwvc3B0NU5CNjgwTlZvZDBKd0NXV1ZkNTlqSlZwbFhC?=
 =?utf-8?B?djk1N2F6cDRxc05JS2syZDU5UW5MZWg1WDJVcTJDNlU5dEFFd0w3Sk53b1hR?=
 =?utf-8?B?RTh0QU5MRlJ4SUp0T0ZxWkYzZlZYZ2t0cFBRekQ1cm1UR2VsQlllUzRIcCtQ?=
 =?utf-8?B?SUJpcmR0NzBlVHc0L3pGTkZQVzVNN0pHQk5wSnVuMWFKRlB6WWF0eHBLbnNH?=
 =?utf-8?B?aWVVYnRaVHgvUUQ0Kzl5bTBTdGgrZ251dVN4c0FJNGwvQjMrM1pjZGZadjZB?=
 =?utf-8?B?TDk4SnB2TTd2czlVeEtqSzM3NWtQN1hZRFNsbnZEeHpxV21zS09mOVprTHpu?=
 =?utf-8?B?WjRvS0Nwc25XSVgzQ1hzMnlLSjV2c2d0VHhqZ3VuN1VEUW1FZzhqTlc4dGNF?=
 =?utf-8?B?RUpQejZWN1BEeTJNM0pQVE1xaUlSYlhBTlI2M2o3TWJlY0lLQWNCUml3Wk5L?=
 =?utf-8?B?OUpjZVlpQ0RoL3UrVFJndnZPYWhaRmFvRVhjeE9VekJvMTR1dHpHZ0I2UGdp?=
 =?utf-8?B?a0hFRGQweVhzRVVFaEpVVHBERmx3YjRCTDgxUHF0Q2ZUWXBRK3dzcWd4Y01Y?=
 =?utf-8?B?bElLR3NrbzIvb1hVMlVMb3JkUHp5MVg5b09HNllWYTNqQ2c1WTg4R3Y0Mjgv?=
 =?utf-8?B?L283em9JWEhIYjFMbTJrT2NqT3IzNWxQYU4xZ25BakxHbUF6eUhNOEp5Q3pG?=
 =?utf-8?B?MXNMenA4d1BMdSs2SGNzNEppZ1ZPdGRnYlNsT2ZXYm5RT0RCSjdJNzNydjF3?=
 =?utf-8?B?dS9HVzBmcFJqRjRiV1B1Rkh3aXZxQjdqQXRiTEhKclFVWWFJUEtBSEpBRitv?=
 =?utf-8?B?dnFab21Gb3oyNjRHQndDRFI5MTBaMWNjT2V5Q2hUQ2x1dGFqcytEYm1Wa1dh?=
 =?utf-8?B?elpNZEZGZ3FhN3dXSWtpeG00bXo1L3RYVVZMR0ZZV1VrMDIzWlNVVFNaNzRn?=
 =?utf-8?B?ZkhsZ3BidmVvTVByQURsdXdWZGFOSjBJQ1ovQVpzVlNqdG9iQWY5a0sreUtl?=
 =?utf-8?B?L2VhNzVtM0tKVzlQcTdqMWo5aFlCYnNPVUQ2Q2NURC95eVViS1Z2a1VvMVRF?=
 =?utf-8?B?YituMWN0ZlF5Qk5LcTc3ZmQ1eUlnWEpQOTRUenRaK0lxNnJxeXNhQjNVaWtW?=
 =?utf-8?B?MVBNbml6V3gwVE5uemsxc3hyUW1JSi9ZVlFMSXlmK21Nb0Q2Umdub2Vnbk1s?=
 =?utf-8?B?WmtMZ3ZQQU9zWDVsd0lJcWZrUU9adUZMVXIrdnNBY2pJL2dkVG8xR3VlSjhC?=
 =?utf-8?B?U3kxbGRZZ1d2UG1JU0lLS010SEpQVHRIa2RLdkIxeXBkbzZKZjV1MUtaTHVL?=
 =?utf-8?B?TEc2NEliYytZbThtTzEvNnVIRXVsYmc0TFR3NWExY2dxUHBRa2gxb2w1d0dz?=
 =?utf-8?B?RWhRbFMyVWF6dHlVZVVGRVhIZkcwQnhZcXRLdmVRclFweXpHQXNRZGtTSit4?=
 =?utf-8?B?cjJOK3V6NG9GcWlVa29wc0tLQ3JJMEtBdldudUF2SDhwTm52em1CMEx2NFVG?=
 =?utf-8?B?dWVqaWY3MENmWmwyZHQ3UXZhbXQvNTZEVHBTcE9BRUtHVkNqbDgvcjd0YVJE?=
 =?utf-8?B?SHY2WnhxVEFDWHMwaWxaWWV1LzhlOHVhTzd6RkNJc2pxWjBnZU9HdUdqa2J6?=
 =?utf-8?Q?UaXu7l+epdA/HQCCqi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7470.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478c5293-f3ea-4aef-f0bc-08defeaca8a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 11:17:45.0084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIdkxq6uZuslWJQpISXT0jPPvx/wQ+IipFToPyEEX/Ox3HxhIWvJwu54hDExFlSIrNce/g8NKlKSQ/sryBpPNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

UHVibGljDQoNCkhpIFBldGVyLA0KDQo+IEZyb206IFBldGVyIFJvYmluc29uIDxwYnJvYmluc29u
QGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAyMCwgMjAyNiAzOjU5IFBNDQo+
IFRvOiBCZWdhcmksIFBhZG1hcmFvIDxQYWRtYXJhby5CZWdhcmlAYW1kLmNvbT4NCj4gQ2M6IHUt
Ym9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc7IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1l
a0BhbWQuY29tPjsgZ2l0DQo+IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMC84XSBuZXQ6IG1ybWFjOiBGaXggUnggcGFja2V0IGxvc3Mgb24gYmFjay10
by1iYWNrIGZyYW1lcw0KPg0KPiBPbiBUaHUsIDIwIEF1ZyAyMDI2IGF0IDEwOjI2LCBQYWRtYXJh
byBCZWdhcmkgPHBhZG1hcmFvLmJlZ2FyaUBhbWQuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFRo
ZSBNUk1BQyBSeCBwYXRoIGRyb3BzIGZyYW1lcyB3aGVuIHR3byBhcnJpdmUgYmFjayB0byBiYWNr
LiByZWN2KCkNCj4gPiBhbHdheXMgc3RhcnRzIGF0IHJ4X2JkWzBdIGFuZCBjbGVhcnMgdGhlIHN0
YXR1cyBvZiBib3RoIGRlc2NyaXB0b3JzLA0KPiA+IGFuZCB0aGUgc3RhdHVzIGZpZWxkIGlzIHRo
ZSBvbmx5IHJlY29yZCB0aGF0IGEgZnJhbWUgYXJyaXZlZCwgc28gdGhlDQo+ID4gc2Vjb25kIGZy
YW1lIGlzIGxvc3Qgd2l0aG91dCBhbnkgZXJyb3IgYmVpbmcgcmVwb3J0ZWQuIFRoaXMgc2hvd3Mg
dXANCj4gPiB3aXRoIG11bHRpcGxlIGJvYXJkcyBvbiBhIHN3aXRjaCwgd2hlcmUgdGhlIGV4dHJh
IHRyYWZmaWMgbWFrZXMNCj4gPiBiYWNrLXRvLWJhY2sgYXJyaXZhbHMgY29tbW9uIGFuZCBuZXR3
b3JrIHRyYW5zZmVycyB0aW1lIG91dC4NCj4NCj4gT3V0IG9mIGludGVyZXN0IGlzIHRoaXMgdXNp
bmcgdGhlIGxlZ2FjeSBJUCBvciBMV0lQIHN0YWNrPw0KDQpQcmVzZW50bHkgdXNpbmcgTFdJUCBi
dXQgd2UgdGVzdGVkIGl0IG9uIGJvdGguDQoNClJlZ2FyZHMNClBhZG1hcmFvDQo+DQo+ID4gRml4
aW5nIHRoYXQgbmVlZHMgYW4gUnggcmluZyB0aGUgZHJpdmVyIGNhbiBpbmRleCwgc28gdGhlIHNl
cmllcyBmaXJzdA0KPiA+IG1ha2VzIHRoZSByaW5nIHNjYWxhYmxlIGFuZCB0aGVuIGZpeGVzIHRo
ZSBidWc6DQo+ID4NCj4gPiAgIDEtMyAgSW5kZXBlbmRlbnQgY2xlYW51cHM6IGNoZWNrIG1lbWFs
aWduKCkgZmFpbHVyZXMsIGdpdmUgdGhlDQo+ID4gICAgICAgIGRyaXZlciBpdHMgb3duIFJ4IGJ1
ZmZlciBwb29sIGluc3RlYWQgb2YgYm9ycm93aW5nIHRoZSBzaGFyZWQNCj4gPiAgICAgICAgbmV0
X3J4X3BhY2tldHNbXSwgYW5kIHJlYWQgdGhlIGxpbmsgc3BlZWQgZnJvbSB0aGUgc3RhbmRhcmQN
Cj4gPiAgICAgICAgbWF4LXNwZWVkIHByb3BlcnR5Lg0KPiA+DQo+ID4gICA0LTYgIE1ha2UgdGhl
IGRlc2NyaXB0b3IgcmluZyBzY2FsZTogaW5kZXggdGhlIGNvbnRpZ3VvdXMgQkQgYmxvY2tzDQo+
ID4gICAgICAgIGRpcmVjdGx5LCBidWlsZCB0aGUgUnggY2hhaW4gaW4gYSBsb29wIG92ZXIgUlhf
REVTQywgYW5kDQo+ID4gICAgICAgIHByb2dyYW0gQ1VSREVTQyBvbmx5IG9uY2UgdGhlIHJpbmcg
aXMgY29tcGxldGUgaW4gbWVtb3J5Lg0KPiA+DQo+ID4gICA3ICAgIFRyYWNrIHRoZSBkZXNjcmlw
dG9yIHRvIGNvbnN1bWUgbmV4dCBpbiByeF9iZF9pZHggYW5kIHRha2UNCj4gPiAgICAgICAgY29t
cGxldGlvbiBmcm9tIHRoZSBwZXItZGVzY3JpcHRvciBDT01QTEVURSBiaXQsIHNvIGENCj4gPiAg
ICAgICAgZGVzY3JpcHRvciBnb2VzIGJhY2sgdG8gaGFyZHdhcmUgb25seSBhZnRlciB0aGUgbmV0
d29yayBzdGFjaw0KPiA+ICAgICAgICBoYXMgcmVhZCBpdC4NCj4gPg0KPiA+ICAgOCAgICBTaXpl
IHRoZSBSeCByaW5nIGZyb20gRVRIX1BBQ0tFVFNfQkFUQ0hfUkVDViwgc28gYSBmdWxsDQo+ID4g
ICAgICAgIGV0aF9yeCgpIGNhbGwgY2FuIGJlIHNlcnZlZCB3aXRob3V0IGhhcmR3YXJlIHJ1bm5p
bmcgb3V0IG9mDQo+ID4gICAgICAgIGRlc2NyaXB0b3JzLg0KPiA+DQo+ID4gUGFkbWFyYW8gQmVn
YXJpICg4KToNCj4gPiAgIG5ldDogbXJtYWM6IGNoZWNrIG1lbWFsaWduKCkgcmV0dXJuIHZhbHVl
cw0KPiA+ICAgbmV0OiBtcm1hYzogdXNlIGEgZHJpdmVyLW93bmVkIFJYIGJ1ZmZlciBwb29sDQo+
ID4gICBuZXQ6IG1ybWFjOiBzd2l0Y2ggdG8gbWF4LXNwZWVkIHByb3BlcnR5DQo+ID4gICBuZXQ6
IG1ybWFjOiB1c2UgY29udGlndW91cyBCRCBhcnJheXMNCj4gPiAgIG5ldDogbXJtYWM6IGluaXRp
YWxpemUgdGhlIFJ4IEJEIHJpbmcgaW4gYSBsb29wDQo+ID4gICBuZXQ6IG1ybWFjOiB3cml0ZSBD
VVJERVNDIGFmdGVyIHJpbmcgc2V0dXANCj4gPiAgIG5ldDogbXJtYWM6IGZpeCBSeCBwYWNrZXQg
bG9zcyBvbiBiYWNrLXRvLWJhY2sgZnJhbWVzDQo+ID4gICBuZXQ6IG1ybWFjOiBpbmNyZWFzZSB0
aGUgUnggQkQgcmluZw0KPiA+DQo+ID4gIGRyaXZlcnMvbmV0L3hpbGlueF9heGlfbXJtYWMuYyB8
IDIzNQ0KPiA+ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLSAgZHJpdmVycy9uZXQv
eGlsaW54X2F4aV9tcm1hYy5oIHwNCj4gPiAyMCArKy0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAx
MzcgaW5zZXJ0aW9ucygrKSwgMTE4IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjM0
LjENCj4gPg0K
