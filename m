Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FCB606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jnrQqb4f;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=jXNeJzD8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A0F680F86;
	Thu, 19 Nov 2026 15:58:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xxzAx5S52dzO; Thu, 19 Nov 2026 15:58:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CBDEA80E69
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795103901;
	b=bLYIF3ZaYCJXNeF7x4fw58cT4ruHmgG7gdvRJ9IKsPsMJTDSQtLY5rD6gtxKP1uiAKpM
	 sIZmSvPg9rBX2e1Rt5LutsLtYvQAJYqfyeJy8VNfUTvg/TZmcRcLXfXXWNcaEkvriSPb7
	 lImz6seiW76b/ktCbg6vzuMohEJZ7phdErLrC9ZvHWgDYI1eEj+e3v7/NHYsnSJiF7u1j
	 4uhMxrJg9H1FabKsavE51DtQCyr/9YPxsChCgpCgE5EODcnXZULTgs4GWCL8P24/hyc/5
	 kHKkhc4eIXLYmXY42HZAwTbPb32RvUaaAIjqNO4q2Eoggf7WDdaW01xjewxUPpO4ZNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795103901;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LspwwNEJ/lbdGergVs9BC4iH+7axWaZ285NKaiD3T5s=;
	b=tQgG+h/VZfJxQ95nLLPcMUKi+cy9QSWHZiLbkP+puEhZeSaEElt0dHzQAHe4Akd+hoO7
	 prhD/6OwNbKZ6xiLEl1GqtiMqqiBIK/3PoA9Ryj1CXTeigAcbEp9rDQUFY+v6CsdFnIqN
	 8W23jvFFUvTCN3zI7ac7WK4058eSwXxpXsiF//JdfSts7vTRy01zMU5zBJd45fqEq47NU
	 AIOm7RUWigBI+9wXm4TQ51XnCzXVPBQtOGz+lPwzhpCjiqDj/HJrXGskkSJGhxzP0fCXR
	 1xkFM78MyjLqnYU8UaVhZSblgfYc1bgti5YC6eGaq0QAKrbAhnX7S48tabh6FQU5pHQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795103901;
	bh=LspwwNEJ/lbdGergVs9BC4iH+7axWaZ285NKaiD3T5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jnrQqb4fBia8F/jIFaBrNDD8EpIWadj3fA7aQwZl6cuomnGGiSWsFdTm7gfL//Vwz
	 /57tUunbeY0oqfT4fI9k+s63n1Teehh4Z1s11RDsfiLBthPPiWgylEK4tVe4bKnUr4
	 Qr3Oq32pZ4h7mAh6vUca+2P6MhelN7xfnhGQoQnuH3zOkDqFv+mWWOP8zkf5X1Pg/F
	 RiKTkrntre5FF2O41XjG26XzjAPmdxmVFn7ysYApcQWFTZZAtFDR/Id2YDob1VwiAJ
	 MCo1I+KZDo9sMf9HwruwmEWAV8Rq1W9YgzbROVvsaswvkWzrwAvJ+yfE3V+5FN7lE/
	 WltCYLXt849Gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBDEA80E69;
	Thu, 19 Nov 2026 15:58:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A24843A8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88D9F40D24
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:58:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D67XaB_oczjg for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:58:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8BC5F40D20
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=jXNeJzD8
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8BC5F40D20
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LspwwNEJ/lbdGergVs9BC4iH+7axWaZ285NKaiD3T5s=;
 b=jXNeJzD8kuNlOs/tjumag29XjzAZVg3ggH4HnP58LA9FU9y5Y1MInmrDGiv/Cvf0Zlz/le2cqihaKobMxYw/MvET+zeBj21bKHOIRfwmXaIyGIAcSIdf2h7kMbvOcUtlR7gAGb9Pr6M+oRQ1IyMnYI1PVe+kiVJJhKL/VPWkhec=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA3PPFA975A5D55.eurprd04.prod.outlook.com (2603:10a6:108:1::ae)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 15:58:14 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 15:58:14 +0000
Message-ID: <9eaff051-f45c-4a35-a7ec-1da8e4affd7a@cherry.de>
Date: Thu, 19 Nov 2026 16:58:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] binman: ti_secure: drop the redundant keyfile
 re-read
To: Sergio Prado <sergio.prado@e-labworks.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: trini@konsulko.com, alpernebiyasak@gmail.com,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 pbrobinson@gmail.com, sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com,
 xypron.glpk@gmx.de, jj251510319013@gmail.com, Wojciech.Dubowik@mt.com
References: <20260728113535.128601-1-sergio.prado@e-labworks.com>
 <20260728113535.128601-4-sergio.prado@e-labworks.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260728113535.128601-4-sergio.prado@e-labworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0066.eurprd04.prod.outlook.com
 (2603:10a6:802:2::37) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA3PPFA975A5D55:EE_
X-MS-Office365-Filtering-Correlation-Id: b20add9f-8c44-46e5-f459-08df4655eabc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|10070799003|261026121527099003|10067099003|4143699003|11063799006|56012099006|261022075727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: laserijERK7+dD/+WwuwqEOkkh0jsUaM342K+gJN97nbEVxMCk4uuNz3+UcgWMa3xhtaUBx01qRRMyTb13KGHub0TiSspzn8Hbux2WrP7HsSHeBB5UfRk4bgq7S6EwleWah9uKqqZFAZUJ6IKKeRS6VMbZj383xb828B8tI1suIUetGilMRwLI09JeOCV/qhRBb0ZTfWz+F1yTlLBnmtModHfJ/+NAZIk0kvmZZNeutk9YmtkusRVpvVmmaEj/jy7dF4I2r7rgZp8qzXDeQ++xxPu01nKsGSl2rMub3YwVkSF9ExZF5s+W0yEvyClJe0srkwiUI6PiIs6mZ/KGC0ueeZ4KTvhmZHUUxQZ933bIOZIIvJ9eSV9xwtR+im8wvhobWVB/wxXEBiJuVxBwy6iN5libEqXFdA+DswrZV6g6jHRShqzA/XeCb+TK0MEWmKIVR9ejKsu3B75FoRh5nqSwWpYVgob/XvHQO+CbsfomiPEZKE8nb3z2uw6BuBirhPjGQCJKL2tkcuFVpdsw5Szjmif6f5q91wOgxHfdKPnY2rBjbM8r2woQcrkwxrKr5f0khczs61mP3OwOGdzECP7S5npVUwHqYUiTPcS+Je+o/pIzGcd4TQRO6KI8lV1QrBKPOGE5QaQyYmPZAajl4sF1qapagkU3FIQ+KeOnfvWCE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10070799003)(261026121527099003)(10067099003)(4143699003)(11063799006)(56012099006)(261022075727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0F0OWVQOHgzS0hqajlDMG4zbGtsL0lteU5jVll5amp1a2I3TnhpRHIrNHl5?=
 =?utf-8?B?WlVJZlBha1o2L1hxM0xiblltVUU0N0czTHhoeTV2NGRwTjdkNGhKZjNOOWtv?=
 =?utf-8?B?d01VN2kzWFlEZ1I0NEEzUEsycmtLem04bDFqeUp3aVk5UGdUcFFQZ2ZxdEVq?=
 =?utf-8?B?S3YweDRRb1BraTRsamxxQlNMWlRFUDdya2FrVEkxWGRMZDFHdXRKK0d4cksr?=
 =?utf-8?B?SkJYTm1wUEdTM0lHTlhaSDhVTExTeVVnbExRWlUyY08xaE5ZR2Z4WVdaUXRs?=
 =?utf-8?B?V01lNEVBM2ZPTUQ3dHljUU5sWk9XczRWV25CMjRwV2xTajQzUXVlUmMzbDRl?=
 =?utf-8?B?VDlBMFlOWC95blg4eFNIQ0dlQTFiaTRZeHAvM09LYnR2U29HK2VtM3loMm9P?=
 =?utf-8?B?SWJQK2ZjZDNiRnRWOERBTWpsc2hadmZ4bXlpSExRNzJsb2FuUi9YNEExSDlz?=
 =?utf-8?B?MDBvOU1pRkZkZXQyUnF0OEhDQXNtMDdJbDIyZFBFemlaY2Yrd3RKMklHaUg0?=
 =?utf-8?B?SElvT0Qwa0E4a09iRlRHanZkYkw5cWNoWVE4VTRvVVRsbHliTlV2TGZYSkFh?=
 =?utf-8?B?ZVVCYlMxOGZOWjV5b1lSRGJGdGhUZXBuY3ZUamtMZHRpSzk1WFpFSDlFQUc5?=
 =?utf-8?B?QmxBZ2pNYUJiRjY5MExuSFNNYnlhT0pVQTFJQjBHMUpYM3F6OVJpd1BIKzRG?=
 =?utf-8?B?MndRZC9vc1FoK0pVa0tPNzhxZTR6VHZiaTFkblMyaTVCWXUzemNWckNiU2h2?=
 =?utf-8?B?czdXaER3WmxjTTdpWmZURmFRZVhiM2MxREdqdnNxU2dIdk04QkVOcEZ1UmEy?=
 =?utf-8?B?d1dnNDdzOXJzTjFhVDR6anlxZDB1TFV3eHRSN0o0Nkw4ckdZSlgyNEZvQzdB?=
 =?utf-8?B?Tm1HbWpieHZpSGZPd1VLMEd1WkwzRG9sL2dXaFhNdDZUZTFyTC9EWXlSajI3?=
 =?utf-8?B?c216VHp2by9Hc1hzRTAza3N0ZTZVaTIvUk0wM0JRU3pGc1FpaGNpcHFMNkZH?=
 =?utf-8?B?Q2sxeTB6SDZwNkxQT2FNeng4QURpa3JNckFWTDVxMEV3MVpnQng2dk54ZFBD?=
 =?utf-8?B?RDdqK215ckh2MW9OZnY1dE4vNWRucnY4M09MTk9qRHJuYkVRSUkzSjVSQ3ZB?=
 =?utf-8?B?QTBqT0ZTRy9Lb3F2YjZ4NE9mVEZmcUtLTGxxYnljcW5zZ2JLR2JnamVDWFIy?=
 =?utf-8?B?Z1JpS05mSUxmWXVXYVAxWVloSTZBS09oWHFaeGloRlZxV0VTcEt5VWlYRXph?=
 =?utf-8?B?bEphUTExRjdBVi8yYzFwNThZbm0wSWRHeS9sekVPTnBOZ2hXZHVPTDhIRjBy?=
 =?utf-8?B?NFplbHd4cmdjSkQvNCtHRnRFcGluZTRzWW1iRHJtYWM4VHN4QTY1b2lQeTlo?=
 =?utf-8?B?L2JPY1hRQ2poQW1LTzZUTndLVjYreEo1SHV4d1lseUl4VlB0UXBtRkhIYzl2?=
 =?utf-8?B?ZG15L3dOOWJCeUJOb2dEUHRNbkZFUXkvZEkyT1lGMjM4VUI2cDNKT1JmdGlj?=
 =?utf-8?B?WUVDdy8rc3RBL1FSWFU0RkEwNDJkS2VrbS9ORE5qVnZNa1gvaThOVklSc05q?=
 =?utf-8?B?U2E4VVNtODNIQm0xblNlMi9LTlZRZGVVRytvbFdOUC85RGlaU21HT1ZCOE5B?=
 =?utf-8?B?ZWw0dUR4b1I0TDBGa2RVTkFwVkJaUnNQdVlXL1E4NkVyR1B0T2U4eUIxdmVj?=
 =?utf-8?B?MXFPbldWNzF4aEZTd3Q5MG1mdzRVM1ZSa0hFYWFzdEFsUmRFbXcxeXRHNmcx?=
 =?utf-8?B?NlhCd0RQZlpYQXBTODVnbnFYM2xUMTVOUUF1NUlIanBZaE9lM3JZSHJFLzVZ?=
 =?utf-8?B?czVOWnJnckxGSmRDL0s3bThwL09jMndYQk9HaHdhVnBadHNQVGxreGV6STBG?=
 =?utf-8?B?S3dSSmZFOFpOeVpLbVZ6WjVTeUh3c1cybHFKN1VIVHYwOHRRMG9iczZvUmhx?=
 =?utf-8?B?WW1FanQxSEZPVWxoSEExYlpnNzAvMmdWRmUvWmxRbmpxZUdydEtqY2I5bkhI?=
 =?utf-8?B?YTBkaHRTamVjSTJJcDRCQXBOeXNFTUF4elNRd1NsZWNoVHpKc1MyL1NwQkMw?=
 =?utf-8?B?R0kvZSthVGRiaHh3ZVUxVnFza1FleDBURUJsV05yVDhqUkFvQVNCSGkwVW15?=
 =?utf-8?B?dkpoWml4LzRqYldrWUl5VEl2RnVRUVMxKzFUWXVibDgwUS9IMFg3emRINHpl?=
 =?utf-8?B?b3pMbHIyZ3E4eVpkdi9KN2d6REZlRmNxSnA4clc1cHN5QUZxbm1JQ3U3R1pO?=
 =?utf-8?B?WHIwNTc1OUU4L0xwMjdDODR4MG9EcHhtL3lxaWxaRGVHYk9Nay9mTUJNVjdP?=
 =?utf-8?B?aXFJVFoxOG1haTZjNmc0Tk4rLzRKYktWKys0L25HRG9nV1ZSY0ZXWkJqbGVl?=
 =?utf-8?Q?uuszbbKo7DvCW4RsH5+2cGNSZIL9uNit5ffo5FYcfYzi2?=
X-MS-Exchange-AntiSpam-MessageData-1: GHpb8nsYjCZq1cwdCjIg2fvpFmyxo5FnoZo=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b20add9f-8c44-46e5-f459-08df4655eabc
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:58:13.6343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swgC92R9KmDav6fCJoG+DWuHhl4j/Nm0uBkc+9zRXx5psUMcn2lfbvAelax5M8QoxxFMrkpXgjHXk9FgpgSRJBgIWMZBaaDry/tS374nDtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PPFA975A5D55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sergio,

On 7/28/26 1:35 PM, Sergio Prado wrote:
> Entry_ti_secure and Entry_ti_secure_rom both call super().ReadNode() and
> then read the 'keyfile' entry argument a second time, with exactly the
> call that Entry_x509_cert.ReadNode() has already made. The second read is
> pure duplication, and it means anything the parent does to
> self.key_fname is silently discarded.
> 
> Drop it, so that the subclasses use the value their parent decided on,
> and drop the EntryArg import which becomes unused.
> 
> No functional change.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
