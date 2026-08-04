Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF72C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 11:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BA5980C86;
	Tue,  4 Aug 2026 11:33:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2NCZY9tXfcLQ; Tue,  4 Aug 2026 11:33:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 222DF80A7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785843227;
	bh=QiN+flwHtNgX6pOPEX0pFjjLfQBlMiiy0YEOmugLKCg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uYDVrlC2Xa2wogUx9abrwekxjlYzJPb4NObcffeAT/VGMYBNF7pxmnt8UHVSVO6gR
	 iNY+MWOzaTS5s9lzDhvMnvWanC3cGkienay4Y4qZgBnNuaWL4lI90rhYUOg9nwHz5f
	 Az/Bf9BhVmccBoyDaLZwIbK+rzv2AQNVemgcl6GIUzO6vgqUy0TH82Ow8ajGOqJlKr
	 6aX185EAthQqgpz+Y8skZVQ4f/6T+yNHkFAhajZD92QUzzO7dxEvwRwsu9wCB1kGS3
	 W7x8XRVMibT9L3ih/Lqs3ES12uS/Eq80JWeUD0/0qEKgRCaZahv+szGjvMz8EK5TIk
	 srWyXz2b3ufiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 222DF80A7B;
	Tue,  4 Aug 2026 11:33:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1769A350
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1B5B80C2A
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:40:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vBvVou2Yex0B for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 10:40:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.231.156.173;
 helo=mx0b-0016f401.pphosted.com; envelope-from=akashn@marvell.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EEC7B80B96
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEC7B80B96
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEC7B80B96
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:40:17 +0000 (UTC)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6749c1w41328405; Tue, 4 Aug 2026 03:40:08 -0700
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022119.outbound.protection.outlook.com [40.107.209.119])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fu31d1yqn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 03:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AH+vI5SFsEli6bniQ4RZJIT1WG9VARv+AZpOjMvWpP9hSnNjE19vTHisZT0uL+6FOy1eW1W5SqllaeCShEP42vZ4wt/Wy4tAxCjefI+0WOskkOzXyHfgkXV4lLcCKMhOTVHfgfiBd+P+vkKJS4ZVvn7Rs9JGp2L+WvhfYvRDOTyLjDcZxmQnf4g6fs2sTI0kNg7Ee69q9qbsBbZLR9FmamrA6C2+Ku1C3EKr87Siw7dw/bgD5W9EuUgP7szJvZJG8gy54/PGCmETTLZzJogFajCVLnmTCTdm7kxxy8GP18vDQ0F/FPn16kEoaFcsuMm8YpWB8An7V8jJ90WL2tM74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkEl7CAGbKNdx9ggn4vGpPKxlSbYg4BJad04NE7LT+g=;
 b=A/cbiZi7YrLmpC7BPUXi9xZFFotgkxhPPpKINvS+uSDhjq32/aGe5VmTsZoUPTqyq3Hlr/kyRNrNQsD34VEVqxCkdZKN9JGnF/065A+ufKrEoXZXnZ7L9BsGBSyELHMahq991T2L9JLTTfbY2rpmyM0diBoQbcpYNPZjP/xXvwMBuOjJRZ/6RgfWTs/a39HqTOgvqYX8V0q9DboW8jKqm+OqG0vJSSSE+BZF/j57j/HSHeCIJNoP2sEa5G2KzAmmSBYBkl3DM6MS7w6YUESOx3/B1L/RJeOQID9RYaH3SfQCJY4QPNmszZybijGMvbK2yoZVXpAMnShflOsY2PxvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
Received: from BY5PR18MB3763.namprd18.prod.outlook.com (2603:10b6:a03:251::24)
 by CH3PR18MB6025.namprd18.prod.outlook.com (2603:10b6:610:1d7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 10:40:04 +0000
Received: from BY5PR18MB3763.namprd18.prod.outlook.com
 ([fe80::669a:f066:577d:6974]) by BY5PR18MB3763.namprd18.prod.outlook.com
 ([fe80::669a:f066:577d:6974%6]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 10:40:04 +0000
From: Akash Nair <akashn@marvell.com>
To: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "boon.khai.ng@altera.com" <boon.khai.ng@altera.com>,
 "jerome.forissier@arm.com" <jerome.forissier@arm.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "clamor95@gmail.com" <clamor95@gmail.com>,
 "marek.vasut+usb@mailbox.org" <marek.vasut+usb@mailbox.org>,
 "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Ratheesh Kannoth <rkannoth@marvell.com>, Akash Nair <akashn@marvell.com>
Subject: Re: [QUESTION] Architecture and roadmap for Synopsys XPCS driver with
 APB3 indirect access
Thread-Topic: [QUESTION] Architecture and roadmap for Synopsys XPCS driver
 with APB3 indirect access
Thread-Index: AQHdI9PqFiDrGrTKB0epmrqsf4oZKLaNspIr
Date: Tue, 4 Aug 2026 10:40:04 +0000
Message-ID: <BY5PR18MB3763EECE8032F6014F8F65FEC6D42@BY5PR18MB3763.namprd18.prod.outlook.com>
References: <5skppezbdkanp336d4nr2jv7yp24kngxs2wcewll6mrxgwdtug@mygftq2jjbjo>
In-Reply-To: <5skppezbdkanp336d4nr2jv7yp24kngxs2wcewll6mrxgwdtug@mygftq2jjbjo>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR18MB3763:EE_|CH3PR18MB6025:EE_
x-ms-office365-filtering-correlation-id: 6a2688a0-bce4-4490-6ea8-08def214becf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|38070700021|11063799006|5023799004|56012099006|22082099003|18002099003|6133799003|8096899003;
x-microsoft-antispam-message-info: zhkYRXuEXVz3i3Jz6TS5U4kPwaGkKGJ32HyhUpJssMzcRz3s3wsunA0CJnAPJ20GZ6wP/wZ1fmldncKX1gfU5PWpdA9V+YjA1C9+zZ46tTge6FTR6zygFCGY3llFEs6++GLKcwnhiWZvv59Y8VRUEvCkKSL24W0v+JxdSknVCcsJbRxvHHW8mgyt7f7IBLuh2mv5ZyG0tN/MIP/qxMRfwEcAw5Bth4tFZvcLrih4TLV55AK1zac6Ip99QTprofecQboRHIL7pttawGlnWSbDlSALDim/YQzVd+/fsAbzBKioEyG2CDuaQXZsuZigASLrGgaGWWYKoTz2i9mK/6AtKOkb8Ji/iaGgCP0xN+4ZEwNdWV090vEp4zdi3QZLf36atVLLEa8ABl4sNmDl9/SgRQXdMCKKkIYxy5kXgQCvOEWeXhaMK+paVXKZiPII1fUIikZdY6VUKupJkEzOvll6EI2rMcHNt7hKln0e++fddsg/AhRCYuaBCP58lh8jH/hv81Xki3co9w6U8iMCkAmf3c264GWRdBJxr+eXN8q8f5fUzXgcwDVrJTdqRZw2XMeg0H9AwAkQgE3qdu/VtWbuJTdBtz1Ke7fSazavNg3Zfc3xOKEWz6C8vN7p3M8MXxU4WAlH1rqIki1jSZB/F4eznxht+EMdQLmE2WxGe7Mpx1cDA5Hn6Nmvg3LpRhXueiObHtDD3Z94ngVwblAYcYW+bl1tlPyJt9pAwbs3kodlTvc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR18MB3763.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(38070700021)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003)(6133799003)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWtqR296b0dJbDJUZlN1NXhidWc3ZUZ1ekJxemFHT2xGWVhIWGFkUEMyWS9v?=
 =?utf-8?B?aUZTak1INHp6cUYwaWNhTGNlSkZ0MzY0V01sQ0pBRk1DZjRjWWR4cjlxdzZW?=
 =?utf-8?B?NnFCaWV3bWYrbUc3TTg2WWc1U3lpOElDdU9nUnNmOXlBM0dRWENZTDFMazlI?=
 =?utf-8?B?K0lPdTNtYXpOcXZGMFlwaXF1bHN1SklhS0k0SENpazMyN1d6cTRpN1VjSDVT?=
 =?utf-8?B?NDZXRDZ5WXRLMnEwaG5lRlpubmxpamNiajhFOGF3RFFNK0E1YlJYSVE3c0Y5?=
 =?utf-8?B?aUtKUDVDeWNkbk1wdHhYSS9hSmF6Q3pOck9ZZnhLc2RUdzh6TSt3TkVFVVBM?=
 =?utf-8?B?TXhQbG9rS0NVRWIrN1hKRmdPMlp0ODR2bkxlb3dacXNsalZ2TUVOY2g1ZDZz?=
 =?utf-8?B?QkZUOG5qR1BVNkc3ZVZYRlQrZElQOFU3ZytNSHk1Umx2V0xzdnc2SnhmWnhQ?=
 =?utf-8?B?ZFpLa0JIMXkrM0dOK3BGOVR0NXpYc3JzaEI0djVBS2RuSDhTZ2RoNDFPZ0pu?=
 =?utf-8?B?UEUzeURzQVdaa20vWFE1NkFKbGhLajRkcFJnWmhER1hSWXdWQTNKUzNsTUhs?=
 =?utf-8?B?cWdudnJMUTBYUkFPK3h5KzhkT1I3NmtmVXhxOHhOTFlTTU1PeVMrbENDbzdk?=
 =?utf-8?B?ckVZM2hMNE9GalNNUXpPdEpoeUVmYjBrVUF1UVZBMG1ZT3FVZG5NYkI1dEZH?=
 =?utf-8?B?ZWdKb2RkOWFFbzNyNncrb0F1L2FDa3pZNmJVNFg0R3g0MnovY3J6aUhEVDk3?=
 =?utf-8?B?TEt4Q2xac1NmSXlhUG9lMjZDUHRmNjZDbGw0clpRS245MnVJT0dKZXFObW5D?=
 =?utf-8?B?QW80WFA0cFk4NmJKRkxHc3Rka3BkMStBenIvOGpIckdzb0xsTFpDREpjZ2lZ?=
 =?utf-8?B?NVFGVDRYSTg5YWZpckl0dkxES3IySHJVc1VxVkZSTGw0U0V5YVRxQWU5MlJB?=
 =?utf-8?B?OHlmRnJZcEg1ZEJ4RXEyczByN0U3YWNxQ3NmL0tSdU5PM3VhYUpaN1dCME5m?=
 =?utf-8?B?ODF2MHR0SHcrd0hKR3dveXd5SGJzS1cwU3IrS1dGWUtaeTNrY1AwVk1zSHMx?=
 =?utf-8?B?V3p2TW1ZRGpMNW13L3JhaEl1NmpmbGUvS1pzejRvWDFiTzVoT2U0TFBJeEhS?=
 =?utf-8?B?UHY4NjdsWnZxRGpveFdkV0Z3enFCa2pBV2F6aThBa1Z1WnBtMmM5ay92VHg4?=
 =?utf-8?B?UHlrczVvWU9na2VPYS9yY09EK2QrTm5UUXU0VXE1dW51bmozZmdIVnVRZVRw?=
 =?utf-8?B?aC9UblFsbFB3SDVpTTFxVW1abTFhb1RQTmJRL3JpZjlKYUNDUys3c0hQUXk5?=
 =?utf-8?B?M0hMRVlET2NZZFQ4QXEzKzVONXl2VkVOT0t1MWVhR1JpSUZSaFI0amRudmp2?=
 =?utf-8?B?TGdIV0ttTlVSYXM0Smljekk0S2d6VHFKaXBiZExIQ2JlRUI3MHp1T0lDUE0z?=
 =?utf-8?B?UW1mMU5wbG1RR2oya1lJdGRFQzE2MDJlY3pKV01LZW5zUHVHci9YOGN1RDR1?=
 =?utf-8?B?Y0VTVkM2L2NkMFdqUFVsdTFDa2hpS2x5Ulh5NGJ6eFlIVSswNkl6Q29LK2lT?=
 =?utf-8?B?VU5HMGhhMVZUOTdUNU5KZWZYYjF6cFFhbDBXMHJ5bm9WL095T1BmclU0WlI2?=
 =?utf-8?B?dEVza0ZXL3RvZ1c2cHZUTkxjanB2aWh5d3JvK3RCTDZ3UUZkOEVWbkRCckNa?=
 =?utf-8?B?ZXV6TlMzQkZjdDZqVFVBMUdFNnM2ejdHa1pObG4xT1dWdG1KS2NJVy9BTmEv?=
 =?utf-8?B?NFk1STc3UlZZek96T1FPRXU1ckdsK2hSbU9QWlZSLzJzaFExc2ZnbStJY05F?=
 =?utf-8?B?MXJ2Y3FkaTJLdVp5SGkvOTN4ZXdqcGdZbjBRa3JXdHFPUUNNd2RvK1ZmSFpT?=
 =?utf-8?B?ZXlFTUJtWFVLSXFiU2N4eEhPRjAraytSUVBrQWxhNUhERk9uMXB0SjJSTGRq?=
 =?utf-8?B?YzR4VHFBbjBxcWdWL1R1b3owVm43WjJvck5PT2NTcGNLdlVzbGsyRTBIYjhO?=
 =?utf-8?B?aUMyVUttSWRWRG9hUk1Oc3kwODUyVEZqN3Q3eEp3SE9rbTd4OTNTMXFhcXJL?=
 =?utf-8?B?U3dqNHBNcjZqeHVsdklTdWlJV0lkUHdYejdhbXl4UUhJenFUTDAraVVxT2hz?=
 =?utf-8?B?VE9ISGh3ZmpLYjJYNUpaZWNIYTVhbHRtQlQxVjFHdUxXb01OM2x3eDQvSzND?=
 =?utf-8?B?TXZJT1VMeXdPT0VvckloNWsxeWp4ck9iMzZITXV5bk9mKzRSMEgvcnNFWnJv?=
 =?utf-8?B?YW9kVVV1RFdHa0dwR29XWE5sYVY0TWRweTNGNlp5czdYYmR1TG1VcCtzRlZO?=
 =?utf-8?B?UDdPalp1eTRWMGxDMUhReUkzdXZXRlgvb2Q1OGc3V0JkUEhKYytiUT09?=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HTTbX5Ux9aoBTWWxrBIphTddhF6x6rkBmb2VCSo9w5kOwcdvFCJaVGzxeUMi5gZzb5effbrInCGjycAoaPTCq7sHckMZVLIPmTgzixJHRe8ogyrUH6kRTi8me/f5OunUmvRjRsfXi+V8WtTGfYZE29iPIs6zlUYFRVJyanD9G1Cyc0CIaOaMjkgqvE/iIG58zi5rWOPpCxq+Fomvq4voDyNGDAvIvNtmqy4w1yV1NSIEZva/hoSZ5wirV6ZFin8d9UG08x2L28wMxbl2xPw3B1rRROIzw35mvgSAwqSvCUF8ChO+qiaDf74pWnimai7jo3D7KlXymfJy3LKmcdb3Og==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR18MB3763.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2688a0-bce4-4490-6ea8-08def214becf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 10:40:04.7222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yllttt6G9HR4nQfpFtgF1chCZPdd464HGD1cnzZJXFUQkhNsxp0QvqK/Pxt8qj2oNCWXkQ00fQgICVNPVbtG3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB6025
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4NCBTYWx0ZWRfX2HKXRr/7TfcI
 Peq+HeUa+wLV/nd6p//xTUQe374lOccfMSrfzYZSFIFUKUpf2Cm3DJ5EU/38mNNGTjW8337jvlf
 lzB4ZIDC0ReVv1pYZyAeDcFtfyToUcW0EwWo80h+em8ImHqMP+Fx9RnnsxfrbyT1/H3kPdNbAv+
 09yoJ0AsngTdiw/46lelg7UU0ZRmjFr6JIJwu/S2jOn435q/hMUSU1DN7vjilwngvbypO+CtIdV
 n9sjMUwzh9lAcQAb95mZmKnxpnQi4d9WgVL+pafCwYhKZn93EyDtREcuYDkFaQcY+FIpFNRjJZR
 B6oEwJCM6NgT91S4RqDdvQdzA9Heo/lyWuxiHxnTmh5tIxxwegN9EG1pmdPxWS+/RdTENFTL6BG
 zYAMlEEVo6UY1dOyl4e9Oj2w2Ek77Se8w56hvhH4moqpdPMFfPQGb7qo9YCsgHlbOL9tb9xFU8x
 Dgm2t5R1x7ZfFueln3A==
X-Authority-Analysis: v=2.4 cv=T9K8ifKQ c=1 sm=1 tr=0 ts=6a71c188 cx=c_pps
 a=VwLi847oaEgB1sxvCHvwEQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=1VxDqnHFAAAA:8 a=yBYpec10AAAA:8
 a=7CQSdrXTAAAA:8 a=k-42gJp3AAAA:8 a=pGLkceISAAAA:8 a=b3CbU_ItAAAA:8
 a=P-IC7800AAAA:8 a=XyMKXzpWnZQhOlZ_orcA:9 a=QEXdDO2ut3YA:10
 a=RNbJX_7t0267WtIo:21 a=_W_S_7VecoQA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=aZ5uHUMKh6B-zo3GvD48:22 a=zbxmTX4fiVD2UiCe4Dha:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=uCSXFHLys93vLW5PjgO_:22 a=Rv2g8BkzVjQTVhhssdqe:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: jMH7KB1tHq5PZ7c8XvypiR4pdIP3fXv0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4NCBTYWx0ZWRfX7DhSU+dPnbVc
 1JADrZIP6gVTH0jRiT/cs/K4gwW/JZWYN3vSrHrA15q+hkWvnnzWr0qPaqnJ12BxkFhBkxSk9PE
 xpiz0gs0kdocJWFdE4XoYu5sN+OKUnk=
X-Proofpoint-GUID: jMH7KB1tHq5PZ7c8XvypiR4pdIP3fXv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Mailman-Approved-At: Tue, 04 Aug 2026 11:33:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkEl7CAGbKNdx9ggn4vGpPKxlSbYg4BJad04NE7LT+g=;
 b=s+u6zqxJMM7wogDAANxPkSJPfzUukpMgsB7rP8VzoEtqVtNuh8/G3FRIRHnurz8za174uDoqG9c6GCOtQSYMRh9nNeGJEOXh7y73owWDhysvps/Ianeg2J3CvGg/OuUSpueJVmcNRGP3HyRTlzRrO6w93h1hWiBZAnftWaSVNs0=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=marvell.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256
 header.s=selector1 header.b=s+u6zqxJ
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

KysgdS1ib290QGxpc3RzLmRlbnguZGUNCg0KRnJvbTogQWthc2ggTmFpciA8YWthc2huQG1hcnZl
bGwuY29tPg0KRGF0ZTogVHVlc2RheSwgNCBBdWd1c3QgMjAyNiBhdCAxMToxMeKAr0FNDQpUbzog
dS1ib290QGxpc3RzLnUtYm9vdC1wcm9qZWN0Lm9yZyA8dS1ib290QGxpc3RzLnUtYm9vdC1wcm9q
ZWN0Lm9yZz47IGJvb24ua2hhaS5uZ0BhbHRlcmEuY29tIDxib29uLmtoYWkubmdAYWx0ZXJhLmNv
bT47IGplcm9tZS5mb3Jpc3NpZXJAYXJtLmNvbSA8amVyb21lLmZvcmlzc2llckBhcm0uY29tPjsg
dHJpbmlAa29uc3Vsa28uY29tIDx0cmluaUBrb25zdWxrby5jb20+OyBjbGFtb3I5NUBnbWFpbC5j
b20gPGNsYW1vcjk1QGdtYWlsLmNvbT47IG1hcmVrLnZhc3V0K3VzYkBtYWlsYm94Lm9yZyA8bWFy
ZWsudmFzdXQrdXNiQG1haWxib3gub3JnPjsgbWF4aW1lLmNoZXZhbGxpZXJAYm9vdGxpbi5jb20g
PG1heGltZS5jaGV2YWxsaWVyQGJvb3RsaW4uY29tPg0KQ2M6IEFrYXNoIE5haXIgPGFrYXNobkBt
YXJ2ZWxsLmNvbT47IFJhdGhlZXNoIEthbm5vdGggPHJrYW5ub3RoQG1hcnZlbGwuY29tPg0KU3Vi
amVjdDogW1FVRVNUSU9OXSBBcmNoaXRlY3R1cmUgYW5kIHJvYWRtYXAgZm9yIFN5bm9wc3lzIFhQ
Q1MgZHJpdmVyIHdpdGggQVBCMyBpbmRpcmVjdCBhY2Nlc3MNCg0KSGkgZXZlcnlvbmUsDQoNCkkg
YW0gY3VycmVudGx5IHdvcmtpbmcgb24gRXRoZXJuZXQgZHJpdmVyIGludGVncmF0aW9uIGZvciBT
eW5vcHN5cyBJUCBpbiBVLUJvb3QsIHNwZWNpZmljYWxseSBmb2N1c2luZyBvbiB0aGUgU3lub3Bz
eXMgWFBDUyAoUGh5c2ljYWwgQ29kaW5nIFN1YmxheWVyKSBibG9jay4NCg0KQWZ0ZXIgcmV2aWV3
aW5nIHRoZSBjdXJyZW50IGNvZGViYXNlLCBJIG5vdGljZWQgdGhhdCB3aGlsZSBMaW51eCBoYXMg
YSBkZWRpY2F0ZWQgWFBDUyBzdWJzeXN0ZW0gZHJpdmVyIChkcml2ZXJzL25ldC9wY3MvcGNzLXhw
Y3MuYyksIFUtQm9vdCBkb2VzIG5vdCBjdXJyZW50bHkgaGF2ZSBhIHN0YW5kYWxvbmUgZXF1aXZh
bGVudC4NCg0KQmVmb3JlIHN0YXJ0aW5nIGRldmVsb3BtZW50IG9uIGEgc3RhbmRhbG9uZSBkcml2
ZXIsIEkgd291bGQgYXBwcmVjaWF0ZSB5b3VyIGd1aWRhbmNlIG9uIGEgZmV3IGFyY2hpdGVjdHVy
YWwgcXVlc3Rpb25zOg0KDQoxLiBFeGlzdGluZyBSZWZlcmVuY2VzOg0KICAgSXMgdGhlcmUgYW55
IGV4aXN0aW5nL2luLWZsaWdodCB3b3JrIG9yIHJlZmVyZW5jZSBpbXBsZW1lbnRhdGlvbiBpbiBV
LUJvb3Qgb3IgdmVuZG9yIHRyZWVzIGZvciBTeW5vcHN5cyBYUENTIGhhbmRsaW5nPw0KDQoyLiBB
UEIzIEluZGlyZWN0IEFjY2VzcyB2cy4gQ2xhdXNlIDQ1IE1ESU86DQogICBNb3N0IHR5cGljYWwg
aW1wbGVtZW50YXRpb25zIGFjY2VzcyB0aGUgWFBDUyByZWdpc3RlcnMgb3ZlciBNRElPIENsYXVz
ZSA0NS4gSW4gb3VyIGhhcmR3YXJlIGFyY2hpdGVjdHVyZSwgdGhlIFhQQ1MgaXMgYWNjZXNzZWQg
dmlhIGFuIGluZGlyZWN0IGFjY2VzcyBtZWNoYW5pc20gdXNpbmcgYW4gQVBCMyBtYW5hZ2VtZW50
IGludGVyZmFjZSBpbnN0ZWFkIG9mIE1ESU8uIEFyZSB0aGVyZSBhbnkgZXhpc3RpbmcgZHJpdmVy
IHBhdHRlcm5zIG9yIGFic3RyYWN0aW9ucyBpbiBVLUJvb3QgaGFuZGxpbmcgWFBDUy9QQ1Mgb3Zl
ciBub24tTURJTyByZWdpc3RlciBidXNlcz8NCg0KMy4gRGVzaWduIENvbnRleHQ6DQogICBJcyB0
aGUgbGFjayBvZiBhIGRlZGljYXRlZCBYUENTIGRyaXZlciBpbiBVLUJvb3QgcHJpbWFyaWx5IGR1
ZSB0byBkZXNpZ24gcHJlZmVyZW5jZSAoZS5nLiwgcmVseWluZyBvbiBURi1BL0Jvb3RST00gcHJl
LWNvbmZpZ3VyYXRpb24sIG9yIGVtYmVkZGluZyBpbml0aWFsaXphdGlvbiBpbnRvIFNvQyBnbHVl
IGNvZGUpLCBvciBzaW1wbHkgdGhhdCBhIGdlbmVyaWMgZHJpdmVyIG1vZGVsIHBvcnQgaGFzIG5v
dCB5ZXQgYmVlbiBzdWJtaXR0ZWQ/DQoNCjQuIFVwc3RyZWFtIEludGVncmF0aW9uICYgR3VpZGVs
aW5lczoNCiAgIElzIHRoZXJlIGludGVyZXN0IGluIHVwc3RyZWFtaW5nIGEgc3RhbmRhbG9uZSBT
eW5vcHN5cyBYUENTIGRyaXZlcj8gSWYgd2UgaW1wbGVtZW50IHRoaXMgZHJpdmVyIHVuZGVyIFUt
Qm9vdCdzIERyaXZlciBNb2RlbCAoRE0pLCB3aGF0IGtleSByZXF1aXJlbWVudHMgb3IgZGVzaWdu
IHBvaW50cyBzaG91bGQgd2Uga2VlcCBpbiBtaW5kIHRvIGVuc3VyZSBpdCBhbGlnbnMgd2l0aCBj
dXJyZW50IG5ldHdvcmtpbmcgdWNsYXNzIHN0YW5kYXJkcz8NCg0KQW55IGluc2lnaHRzLCBoaXN0
b3JpY2FsIGNvbnRleHQsIG9yIHJlY29tbWVuZGF0aW9ucyBvbiBob3cgYmVzdCB0byBhcHByb2Fj
aCB0aGlzIHdpdGhpbiBVLUJvb3Qgd291bGQgYmUgZ3JlYXRseSBhcHByZWNpYXRlZC4NCg0KVGhh
bmtzLA0KQWthc2ggTmFpcg0K
