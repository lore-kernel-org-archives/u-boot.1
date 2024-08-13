Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C16CC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 12:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2916A88986;
	Tue, 13 Aug 2024 14:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NNvpC8fF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BCD488997; Tue, 13 Aug 2024 14:29:40 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F60988842
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 14:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yj2rlkVMIbEhNfa/FI2FdUnb6//vg4LqPK3tgPNAR02TSWXWTGZ6S3ikUj/YDTByb/D48e67XshMcNisJxEG/i52wI0eaXMKTO82+zdJBUgdP3n+py9rh8qTl6avUfIpBBLYWl8ET7ZQ8dRem0dKji2VaGtuei2m1rZ+oGmf6r5r7ORgdbLY4Ra8bCbKJv/pxBJNqFhgd2N6ERi+E6C4VEDrbVubH7lnjBcCnKDFUvEOuwEajvC6wsrwMTtMqcQ742ACw0fAc52PNHrS7BJfFuNQRUcNyu5dOmoVRg5kRL5czXpTmfElNcMqo8SkFMgR2mDlm+KHWwOO+W9Tsq7B8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWZdomhDjO4JzSgO2phryfc+ARRsGoa6HIswDxkG6jE=;
 b=yjwGvfTPo5aYI3cFobg89WQaEmjW4d45OFAWtpC7VXuk7xO2LwnMue9UP4J/ROSw/nLy8aZyYzAs/Iy77ktuuVt56lZtX+yGbVjg3E5G8utuC7lpyJ0JSFufEOxNmED0t1Iz2XRhK8AK8ASXjtA08Pt9FhDwgyqke4YNpiy1g4/ixPC9n2/UvZfZBvLWBu2VvflV37iHFezKPdVqzT01wBQGIQ480tka6lcS3JffFEhESyFdXKnQWhY4MjMrirReyQ5s4XRamr9MkHqjQyazqZKjdfpFpe2ab3ts4ZC4RevlkRE1to82pOZ2DNcx02lw/GJQKwgoxJy+aJ+r/qkjzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWZdomhDjO4JzSgO2phryfc+ARRsGoa6HIswDxkG6jE=;
 b=NNvpC8fF6JUVR5RNCgPDBkIuIYq198IvjxsgkBwFscHozDYFPSQ9gZCY9sOtz+H9/963RIhRjqRxN6jENBuoOHlI+TRwTCxyCM5u4F1bG71gzfPB5C+whyvNnONiva79ltOKFKtpibCvTA/xLze2fUL+tJlMiRVGRq1h1/5tF5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PR3PR04MB7353.eurprd04.prod.outlook.com (2603:10a6:102:82::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 12:29:36 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 12:29:36 +0000
Message-ID: <6ac92261-8515-4884-8cf6-357e8356bb4b@cherry.de>
Date: Tue, 13 Aug 2024 14:29:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] mmc: Use logging instead of pr_err()
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-7-sjg@chromium.org>
 <4d3f9b1c-5be6-454d-8cd4-28bd67ded364@cherry.de>
 <CAFLszTj-szBqxPVi8CiWb2jDnKdcx128C8Xk7XUL0a2QoccWbA@mail.gmail.com>
 <c7483e63-f51d-4b8c-9340-acf75e1f04b8@cherry.de>
 <CAFLszTjjKkJdTE90AYJN1S05xsf3Bso_fDiQN-4UcQuJNR4aYA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTjjKkJdTE90AYJN1S05xsf3Bso_fDiQN-4UcQuJNR4aYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::23) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PR3PR04MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 003ff247-0ddc-4c80-1bec-08dcbb9397f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2prT1J1bEFjdXRpN3ZJOXErQS9NeldGU0tlblRHZ0RwS01HNzVEUE80UTVw?=
 =?utf-8?B?N01meEZzRkl3VEFNZ3BkdkZRRHN4bnpPY1VvbGFCcXRNWVBseE1neGZCQU9F?=
 =?utf-8?B?UEMzbGo1Vitjc2VTV096OVp0dksxdmRGNXBUZWtxME42eUhUM1VLZHk1Smsy?=
 =?utf-8?B?Y21rUVVsMUhHK0xVcW5zcFA5UStZeW1jV0FkeFNYd2ZLMHdiUW1wdWZvSXpH?=
 =?utf-8?B?L3IwUnlGZ1JtSVp6UTNoWjRpaHN0VHY3QTFDZytkckdjTTBrallXRkxGWTd1?=
 =?utf-8?B?cXNneU9JamkzL0xabkFmZXBMQXVSVzVBQUZaU1JFRjA1QkRzNDFKRWpCaXZz?=
 =?utf-8?B?REMyTUhLUDJidjdpMVYyNVhlMHc2Uy9OcCtTZklTZ2NkRFdDWUYvNFJ1b3hq?=
 =?utf-8?B?cXdqTDNmdUFMMzlwWENPSDN3ZDR4Sk9PM3JXZnZ6aHVPblFlWFlQU0FZVG5x?=
 =?utf-8?B?Y2dvSmVoOFhIZzZyYlU0L212d3p4amNEWWFtQXcwZUwyakFaajJWTGMvbmdP?=
 =?utf-8?B?blVIUUFSU1NzeW5HWVhRMEVTQ1Jlc0Y3dkxkVWxBVGVzUWlZQ05pMVBLbXVW?=
 =?utf-8?B?VHBvMWR5T3pxU28rdFNBeVRoRmsreTFGTEtHNHZIa0w3T1czdzEyZzhwQ3FU?=
 =?utf-8?B?NzczcTJ3bEJuQ3pwTXAzS2VPV2tZbTltR0FqSUx0RlVuTmRMZ3p0d1luY0RM?=
 =?utf-8?B?bWhYdW9NOUpBbHVlcDQrWFlHbU5iaDJkZjMwNjZtQkh6QlBTNGZkUFc5K04r?=
 =?utf-8?B?M1VDUXhZc1IxbVd4TjJabUpPdUtOUmlDbWQ2WURKekhpSzFneHFlZXlURXc4?=
 =?utf-8?B?QzAxOFJtUXdHejYxd3FpWGU3Zll1amMrVmVZOExRK1BlM2swT1MxaUN6RFB0?=
 =?utf-8?B?ampiclNHbUxGTGdqdzY3UkNhekJ5ZjE1VlI4UkRTRDNaUHFmRDFydDVCa2c3?=
 =?utf-8?B?eWErTjdsTUJzUEExRjNRVit4d2VkWlNDT05QSUUyUHlSbFdTOEkrOXhNUkIv?=
 =?utf-8?B?cUtrRVpGWjRHQ296SDUzWUQ4QjBkWmQwTlAzRXltOTMvUkJrODJYa3o1Tm1v?=
 =?utf-8?B?dnZPL2wzMUJCVlpSVUkyTlpKbFlDRjhCVlZIQzQ2eXVGazRjbitIL0FtdHdw?=
 =?utf-8?B?SEtvYzV0andwanFGbm9tZktvT2pEbXdRRE5BTUt4NWZPKzlRTTlRVkpTVXM4?=
 =?utf-8?B?dE1OUlhKM3Z2emhGS3NicStvK1dEdUl6Z0Q3czNQbjE0K2IzZGRIbnN2eXdw?=
 =?utf-8?B?V0FEZnd6VUhnM3UzZHJvL3pobnc2YmZKL3JnSUVRcEFhRHZEQ2FianJmWXhQ?=
 =?utf-8?B?WHJCMGVWYkszUGxNYW5BWW1oQTJlS0VaM1dyREx6ZnhWRGV0UStBRjg0clg1?=
 =?utf-8?B?QXVLRDhNNnI1RzRJdURTWVhNZzk5N0Y5ZGdzOXd2ZnBUNWxiOUpwU1dGckpU?=
 =?utf-8?B?dm0raE4xd1dicVh3UTBvK3doSC91RkNMOXVOTWF6b2hYSUhCbzRrczV3SHh1?=
 =?utf-8?B?SCtueG90OGtwTlB5TGJudW54Smp1Y0M0SkdKWTFwVHVYc0ZNSXJyVHlNaXZG?=
 =?utf-8?B?NmJHYko3Tld6QjlJcHJhd1NCNENkaUduSHZpSEcwbTJVVE9QN1IxMzRKa3lK?=
 =?utf-8?B?Umd4SVFSZVRhS1pzUW1Wc2VabHRpcmYxZ2VOZEFXREd0L09WNnB6WkpqcjBk?=
 =?utf-8?B?ZHNsMDRUcW15eUl6a3kvNlRGOFVhVkFzYnhZRlZNSHlzY2pEeThzZm9XR0xn?=
 =?utf-8?B?YzkzdTdBMjlyWm4yd0Iyc1A5bm1lbEFuWGtjbjFnRFdLMUtpUGhFNVpaK1VX?=
 =?utf-8?B?UXFMZkgwc1ZJTFh6UHJVQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czBiRElBSE01SFpxQ20xSDZEeEJRRUhhN2tCcXA1czZKd2hZZ3JaS2k3UG1Z?=
 =?utf-8?B?ejlhUXRBREhlNDlEYmpudm5uaWI3MEowVU1Ya0xBbGhBUEF6dFFadWpHeU8x?=
 =?utf-8?B?WENaZ0F2RTVlbXYzWDFRUys1ODV6K2dMWC9SMTZlSDNoR3RZUTQ4RjRLZE5C?=
 =?utf-8?B?VjNHK1pSVUdQaXpTUGZSTVptR3RYV1JVWlJJNnZCTTJIZkROT3dOWmYwUGI3?=
 =?utf-8?B?YmMvVUdnNkpDd3dTR0V6QTBmdStLWHVteUcvaVhnUXJ2QUJqN3BmcGhoMTY1?=
 =?utf-8?B?YnNTL0pCK3d1MzMxQkY0QUdqWlNOWmZsZ05HNVUzdUNUbm5aa0ZoQWU1d0ht?=
 =?utf-8?B?QnZ1SG1BRmRpVm93VEExYUNoZExTR21ZUkVNQW9ZbnBwWU4yNVllVVRjd0to?=
 =?utf-8?B?QXl5a21RNWsvK1ZISk4yOG5oa0Flanp6TktEVFJvTzNrSEJkckVvOW91cndz?=
 =?utf-8?B?c1ZzNEJuQjRRaytPSllCRDNEQjhMRXh1QUN5ZjZ2SHVtVUJOYlRnMGdJUmZr?=
 =?utf-8?B?cGsvU3BLbDNCUys0Qm1zRFZLcnJkNkVoZi9KZm9CZ0NmdkR6K1dJWWFpaks1?=
 =?utf-8?B?MDhxTkl0QlJidGVJaEtSR3ZZMEl3ZWw2a3hneDBHKzJtNnF3UHVxdUM1bVla?=
 =?utf-8?B?MWVOcEtiR0tUNW5xREJHQkxVNXVLdWVoZ0dtSWkzbCtFMVlrYTc1OEdyUHhG?=
 =?utf-8?B?WGhHa0xJSjBBTzZZSUFIOFMvS1JRbTlwRGdtanZaTklCdVJVVU5zbGNLc2NY?=
 =?utf-8?B?VXBmTFNxVURMankyemEzWldLRXVNWjBwMWZrOE9CNEk0Rm55K0JtQ1FwUUQx?=
 =?utf-8?B?b2xHYXlkU2llaHJOOEkwekhwK3hYT2xvN2crOEhOVGt3cFVCUFlRWmpmN2JD?=
 =?utf-8?B?SGN0WStib2E5bE1nTXQvUEhqNksvMmVFNVRpU21RbXNRWVZVbVV1NTd6RDY1?=
 =?utf-8?B?ZGE4Wm94RjBQek1QTGQzM2xROC9NdXE2R2tlNDd5K0Fpb0FSWHJZOWR2amJ0?=
 =?utf-8?B?ais0c1pselg1ekFMTnRvek1hZWQ5N2FaaithLy81TGRUMXBwVGpWMHU2cnow?=
 =?utf-8?B?K041TUV1VUhDNHh4WTU5UEk4SzJhTUI3eCtDLzdaak1SYkJDeHRFaDlZN09D?=
 =?utf-8?B?WnM3VW45YzJpQmlxY1hNM0VBQXQ1amNSUmVwNm9GT2ROZVc3am5OTUdlYitM?=
 =?utf-8?B?clVROHQ4dUlMYWhiT1VsVnZJSVJaZ3hXRnVFSkt2OGpoNk5idEpUMzVxU05I?=
 =?utf-8?B?SlhISTUrNHR6eE9QSFJPOEw2TGlRM0s5YXdHdkhqQUU1dzFIZ2RMQ01yUGtO?=
 =?utf-8?B?OUxzcWlrazZGbHowM1dBci9xdDFxcmRzamFEcGs2OUFPdjNNTmpTQnVWVjdZ?=
 =?utf-8?B?TzdHdHNmdmhNVFp4dkpTU05JZTdNdEgyVDdFQVRJczRMZ24xdks2NjRUZEdG?=
 =?utf-8?B?VnFMdEdlVEE3NGFCcU11MmgyWmpTdzdtWDI1Q2F1YkhuQ25CTDE5eE8vWWxo?=
 =?utf-8?B?aXU4c0lybGFVZjFKMCtId2l3dGw5eFlXcnBqdmRsSll6RUVMaGhla01MVjk1?=
 =?utf-8?B?bmc5RWZ4ckJYUW1JY1ZtU01QbVRxN3RZYUd0Z3lZQnFHWkR2V3pkRlFKSWc4?=
 =?utf-8?B?Zk83Ny9HUnZROEdSK3Btc25ZZmFZYlVKZkZmNEl0VFY4aHZ6UDhZNWlXNExs?=
 =?utf-8?B?cVNONXlwamkvc2VhdWwwT1YzQUs2Y1cxeUJzV0c5ZlNMeldKbERhNzVNNndh?=
 =?utf-8?B?eS9RNVMyOForalEzamFMYUdUQ1dRc1YyNm9ta3FIdXRHR0hoUkk5dmJmbDd5?=
 =?utf-8?B?Skd1aVRNdHp4N1BzNHZuT0g3bzhLWWdOVHRnOG8wVzNVS0NiQmR1ZlNUUzNj?=
 =?utf-8?B?M2t1bEhiS1VoYlR3cHVFUko0V3NzRmpBWThaamx2L0RyT0IrTko1ZldOM2Q3?=
 =?utf-8?B?Yzc1VDZpYUxra0JHMGQ4SU5hak81eEcvVTE2dGRidDZYM3RFME1YdVRRS0da?=
 =?utf-8?B?dEJZM2o0aEZaTmdkRkJaNDFUdjBuWEUxNElidUN5bTgwb0NnNEpTM0ZUYkRR?=
 =?utf-8?B?dHZ4SW1zWlRla3lTNHpaR3RQcHBEaEQrZ1paT0lvZjNPay9YMm5yaWVBTFZ3?=
 =?utf-8?B?aWVoRS9RczV0YWVIdVZFcDd6eHprelRBN3E2RVJudnZ3eHRNbGxYa3BmSUU3?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 003ff247-0ddc-4c80-1bec-08dcbb9397f3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 12:29:36.4661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMKOnViooMamsg7TkuR4L++M9zKrHQBMUxMZzYX6lvG6IB5phzgHDfKauoEq+5S9eT+2jIwckbOLtne8MDGwEZKANEfp6UmrJ3OxsR2+y3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7353
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

Hi Simon,

On 8/13/24 2:16 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Mon, 12 Aug 2024 at 02:58, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon,
>>
>> On 8/11/24 4:50 PM, Simon Glass wrote:
>>> Hi Quentin,
>>>
>>> On Tue, 6 Aug 2024 at 08:10, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>
>>>> Hi Simon,
>>>>
>>>> On 7/21/24 5:25 PM, Simon Glass wrote:
>>>>> Use the log subsystem instead of dev, to avoid including function names
>>>>> in the code.
>>>>>
>>>>> The CONFIG_LOGF_FUNC option can be used to enable the function name.
>>>>>
>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>> Reviewed-by: Sean Anderson <seanga2@gmail.com>
>>>>> ---
>>>>>
>>>>> (no changes since v1)
>>>>>
>>>>>     drivers/mmc/mmc.c | 49 ++++++++++++++++++++++++-----------------------
>>>>>     1 file changed, 25 insertions(+), 24 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>>>>> index b18dc331f78..b0105afe5d6 100644
>>>>> --- a/drivers/mmc/mmc.c
>>>>> +++ b/drivers/mmc/mmc.c
>>>>> @@ -294,7 +294,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
>>>>>
>>>>>                 if (status & MMC_STATUS_MASK) {
>>>>>     #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
>>>>> -                     pr_err("Status Error: 0x%08x\n", status);
>>>>> +                     log_err("Status Error: %08x\n", status);
>>>>
>>>> Please don't remove the 0x prefix (will not comment on other patches in
>>>> this series if it happens again, please check :) ).
>>>
>>> OK...hex is the default though.
>>>
>>
>> Can you please clarify what you meant by "it's the default though"?
> 
> U-Boot uses hex by default, so anything printed out or entered is
> normally in hex. There are a few exceptions, not all of them correct.

Gotcha. This actually has been painful to me and I've made the mistake a 
few times already, e.g. writing 256 blocks instead of 100 (100 aka 0x100 
instead of base10 100). Are you aware whether this is made explicit in 
the docs somewhere? So I could refer to it if I ever need to explain stuff?

> I did send a series to allow decimal numbers but it has been deferred
> for a while now[1].
> 

Interesting :)

Cheers,
Quentin
