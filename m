Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894A7D26D81
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 18:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2206684390;
	Fri,  9 Jan 2026 19:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="idn61xho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 574D8843A9; Fri,  9 Jan 2026 19:08:58 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8970D8438A
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 19:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgiWA5f1eVc1JpN+WIIbSHT2e44LbvERD8nSYB6zn+SkOqZTQFCgqkt9dAnYTqIDMpGjoxY4cTtSi7++0/5LMmI5xrb/qRJ2kBGpskQeJMNaM1tSJzRDFi3KY1g1EGUJmeYFAoKkx31L00MJd1RPztwzH9V2G2vBxuRAsFXfSgtsTrDKeLl0TLdmhzcDvYYi0pqrCqgeG+czCPflYdVzyLxHIOT8nyDc6vjvhmO1INOMqFw3K7Bdi+vTKaElZdnLnOL52dVxcouxZeq1O+A8anXiJbv/i49WCOb+N5XCLp9oGs0eB0s9wRb4mjhNpk/7wJmmnTnyJh8aCwjPkecy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7SMPp+m8nmwzIyRgGhcgWW6AVBEWOHuQesGIKH0AnY=;
 b=LCcR+vjSLOHyBB/3/skktF6JDRaXBx0P4Cid34zsztNFbNKCXgfiIVVZjUnsCUxWFU/n6xS/XmbWzFqHBphezmSZm3tlmEUDHmb2WIhXpgK5lMoxKu6F+3QdV70mPKGpQzKUeBhnpszvkLM8JDZN/hv+oqttNl0WRBte5VtdMMLdYw/tzKdaKY2l/iYBTbvvFylOFIJeTN9at8pX/JpQkbmbLvqPj16goEkV88RGhhe/Jl5jzJ/+Q4I6L5IhpVPT9UviZGg2TJWn6fQ1lyxgjdS0/HgSJt2eQ+dQGz7oYIps02+giv+WQAGbPB/sQT9iOrXojP2ymxNFEf/fgIoH3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7SMPp+m8nmwzIyRgGhcgWW6AVBEWOHuQesGIKH0AnY=;
 b=idn61xho6MMMjwVLgeZ/jddwKZuhhe6fub6YXooKVwJlfjuGnlxCJk+AEQegQQXGohW7bL6c5V8Ech0BSAyRtGM6PSyOPHoL8yxWZH4R5asWsViWgIr8d8CnTpEbaNKpEGHllboG7GUPXGqUiq+UroVyshyC+grM4MbWeg4C958=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI1PR04MB7040.eurprd04.prod.outlook.com (2603:10a6:800:121::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 18:08:46 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 18:08:46 +0000
Message-ID: <35fe875d-0bcc-452b-bb66-a2158b96629e@cherry.de>
Date: Fri, 9 Jan 2026 19:08:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc/develop/process.rst: Expand on the Custodian workflow
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: E Shattow <e@freeshell.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20260109172905.1446923-1-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260109172905.1446923-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::16) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI1PR04MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e77a26c-3ee9-490d-3957-08de4faa21bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXVHbkRhNDA2L0lQa012aUtMRlBiVlBnMEpYcnl6NE5VMXZ2dmt6MnViZCtM?=
 =?utf-8?B?VVVhWUZWUGx2cjlzQ08wbDJoZTdhR1Bka3k3QzV3bWtSME9aNkoyUHE3QVdK?=
 =?utf-8?B?UGdMOTJ5UGNmb1o5dmFzWDUxTjNxcmxNV3pybzhXdkVPNlkxdHJFaDJlU2JE?=
 =?utf-8?B?SVphaVF0Nk9UVXdIVzlaSitKT2M2cEVUTTFTMUVBdkh3TCtnQmNLeVRMMVpS?=
 =?utf-8?B?SndURXhleVp3QXNrd1lodE1ZcU9kMXRTclM0WDc3dmIxT2F2bjAxTWgwQTQ2?=
 =?utf-8?B?VEpEY2tTa3VBMkdMUHVZUnF2YXZCRjE2VHlCSE5zeGlkbFhUZmsrVFRwdjUx?=
 =?utf-8?B?ME5Eb0pvc25uazdoNHJRUnlFT3hNcnJHdjBBR1hKeDlBdXZkUVczKzR2ME9a?=
 =?utf-8?B?OHkySlI3dm9ONTVaVElkS25KNHVza3FybG1lS1ljdkFWRTVOd1BaaGJXbVNz?=
 =?utf-8?B?Q3lkbGFaWEh1YzZWTUVTNndnQU8rRFJIeU5IRnlhTTg5a0ZvdnRHcFZYdnBr?=
 =?utf-8?B?VEtoUXNIU0Z4SitKcGY0QnJxdFQySHhHYjNEcWdpc2RhZ1FWRHl5QjVmSDZ1?=
 =?utf-8?B?NEFvUnFIWW9GTUcvS1NSa2o1TEZTMEV4OUZVQVF4SkYzV0ZtazVlTlhXM1Jo?=
 =?utf-8?B?NDlMNUNza1A3RWVjV1krdks3eW01OCt4ang1Y09ob0M0Y0F4TUMrbUZQdER1?=
 =?utf-8?B?eTQxc1FubjNhQUZocmJta1FVTEh3c1M4V2xVT2crVHBrTDFabTdHUncvSHZ2?=
 =?utf-8?B?bzNTeW1DL2J5OCtmeHpuc2RoTXEvM3MvZXZkU2luYmNabFEwRHQ5TkQ4cXZU?=
 =?utf-8?B?T0t6T2doYzhhcWl1eUlmSXA5aGthVVJKVVdaTXAxajV6ZStYNlpVWVBYTjJU?=
 =?utf-8?B?QVZSK01jN3lQZFFkNkVqaDBYQkFaNXp1cmhyVDJJdWkxb2tIVUtUZ1UwZmk4?=
 =?utf-8?B?STRuQ2JNRzNIeS9vMy95SjJEMFRWYUdlSGVnL05qeWFsVXZYV1R6R0tzSGI4?=
 =?utf-8?B?VDAyajBXcFBBOTFlNjVybStDQy81SXhhbXNhNGJFQkFVR1hWQ2JONXBWalFE?=
 =?utf-8?B?Y3ExWHI2dmdmVXVEdDRFNlI2VDhZQ1ZGVFdwbHJOQU9CRVdvVEJHS3Q1aFo1?=
 =?utf-8?B?R0FGLzl6Vy8za29LSDBmK1prOEtuNE9EbzBrNVVrUERxNmNXRHBwYVpBaHc0?=
 =?utf-8?B?Y1FwRkFKTm9FT3h5N01LS0pzRjE2VnozcFNLbVE0b1QrWXJJTGxGUlFXUEVT?=
 =?utf-8?B?S1RtQWFnRG1YTGJhTjZmZGFZMDJTZW1KZGhqVmR4dzU5U1ZOU2c4RlZ4YWcy?=
 =?utf-8?B?SGg4NDhTeG1lUURQc3AyVXlOYlpWUFZxYmNsM3RNbUZMNlprVnFJL2JxSGx1?=
 =?utf-8?B?Tm5DdU02c1ZuRVQzL1RCOFJNdjlWQXJpcExicGc5TTJ3TXhFSU0zWjdvMEJL?=
 =?utf-8?B?bVhMQmYxRDhrOHg1OTV5cVdON09BR0luZ3dML0RKdjdJYXorNGFSRDhWcTAy?=
 =?utf-8?B?TVlKa2ZGeFZHaUtpK3huUytFdlJESFhENy9qVkhrQVg4Y1FaZEc3WFNKSzlD?=
 =?utf-8?B?bTZkWENJK1cwd3RVM1hqandRZmU4cFJxaEVhejRmM25tNXBhY0pxZ3dwcGhE?=
 =?utf-8?B?TGpYeTNvZ1pJaC9EZ1kvSFVUeEk1Mi8xekpWY1pRQU5udDVBbHN4aktGS2hH?=
 =?utf-8?B?dmNhRS9pbHF5dHNCMjNJK2pLLzFsZDNYeVJrOWtaMXhJdnQrdEtqNHg2c3Zx?=
 =?utf-8?B?RlBxTFBkZEMrVlhlNlBNMDkzQ2dtWHQvbHRqYU5pT2VPcC9waUxFOWt5cHdQ?=
 =?utf-8?B?TDJ1UlE2dTYzOHBNNjNQYTVJcDVrY0N0MHpCaldqNmFqcThjeVVTbjlGTURX?=
 =?utf-8?B?ejJlK0xyZkFpdk5FZXE1Yis0dG5EZmhuSVg3MGVEMWUrNlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDNYODlsYkRnak05Q0t4dVAxd0I1TTNSNkJla0RXN003L091THhYemhmamRZ?=
 =?utf-8?B?UVJsK1NUdVBLOTVyRWRGVXJqdnA1NitaZHBOTmpKL0VXZVFiZnl6aExPWW1S?=
 =?utf-8?B?MXVBTHQwUnEvclhBVmc5dDUrRHE0a1BOS3l3cXlqbmZWYmdJRUR1WHhQZjlo?=
 =?utf-8?B?dS9lSEtGYVE4MS9NSUt1Y0RFWUlrV2lpMVNpVkZGVDdseEx3aDNmYkNDSFNI?=
 =?utf-8?B?SWRDWlBIV0RmN2lqSTM1bFBDa2JxdDl6eXdFQUJ5Ri9xS0p3WVRVVE5GYXJn?=
 =?utf-8?B?Mzk5Qk5RamxLaDUyQmgrU1hOc0NzcnpObHM3ZmZjMXdxeHdPTEM3dnFsbmlD?=
 =?utf-8?B?ZEVYS1R0M0VUVERQZ2ZNTU9OeXpLTUE4cVpmZjQrK3VVT1ZPWXFhSlcyU2ZL?=
 =?utf-8?B?NEhHWVB5Y1Y3OWhlZ3F1cjhhMVkwem5xb0lsRnFOb01WcmRMMExkMTRhbnVy?=
 =?utf-8?B?bStFeG82Qm43emF5ZkNQQjBZTUtEeVB6ejRrUm1JaWZzaCtUZzQ0RGpoeUVR?=
 =?utf-8?B?dTU1eUNHSDJWUEU4UHB1dE1mNXBGVDNvQVRESjQwZXo4cTgwNkM5amhOR1Nr?=
 =?utf-8?B?aXBORDlxYmVYZTBDaC8yVWdKYnE1OHNKN0FrcEw4bW9hbUpSc3YzSEhUa2gx?=
 =?utf-8?B?cTVvdzhwd0lSb0doa09pRGgzd3M2bVBxZXUxejJaWUsxNy9IWGt0cjd0aWs1?=
 =?utf-8?B?US9BZnltaTF1alRwcFRLRmJGVGwyTFZjcnRDTWFPTCs0VUhtbHJNM2lhLzlP?=
 =?utf-8?B?TFRYUjM3WUhBMFNVSWNWblJ3eHgrTkViS1p0d2dsSlJqZi8rQXcrR1lrOElD?=
 =?utf-8?B?M0JNbDMvSWt0WFZaNzVWempzZkh4MlNTaUZJNmZpVTkwaHpxaXVYT1gyN1Vk?=
 =?utf-8?B?SXNhYTJ0TWQya2RQUTFMRzE1N3paWUFYZjNGV2RwS0QzVCt5QUdwWDRod3Ey?=
 =?utf-8?B?R3NtQ1g4WXpzQmpMemtoQWxaQ3dEUmRDblFBZWtsTmRDV3Z2WWdSQjFyMVFX?=
 =?utf-8?B?SWRtYW4vR3lHdWxwU3lZZWdTcEo2c2ExL2tad0VETUxQUkxlZHB6ZjBFN2cz?=
 =?utf-8?B?MzVaNjNwckVPVDJUT2UwUEhZZ2cvaUZuQWhmK1J2S0N0MmtVUmFyalY5YzlR?=
 =?utf-8?B?ODVXdUV6T2VuZGh5a1dqZjZ6ZFRxcTRhU2NJc0JlZk1iM1Bib2ozcE96Q1FP?=
 =?utf-8?B?c3FFV1paVVc0YituTXA3dU9uQ3JPaUp0SGdFOXlmTVlFN0Y4NEdCQzk0SUdT?=
 =?utf-8?B?d3FNZXlSWTRTMzVPcExlakJLWnFPUE8vTndGemdkNE9YeklGVTBSdmpBVmlY?=
 =?utf-8?B?SDNCMkFyM0grWEprUDQ4OVV3OVliVHpuU1JBaEt6K1hma3BuZndmSzhVeUZ1?=
 =?utf-8?B?dlRoSEV2cytzeEwwemJtM1pXYldTc2NzMFl5Z2hPcitYN0d4cHVqV213c1Nu?=
 =?utf-8?B?RWRzRER0RTY4TVA3VXVqZzdYMmoxMzBWL0FkclZSUUNBSTV3ektyK3FIbUFF?=
 =?utf-8?B?U1pGZHlyVVVFajRNTjMrZ1hnUGJSdkFUUENKZ0owU3VrNWgrZ1gxZXd2bmgr?=
 =?utf-8?B?cnNBYmtDdGhuNldsMkljcjBTdzhnM3hBMkQrMzczT2ZWR2w4NlN3RERyZjdw?=
 =?utf-8?B?VmZyUFpHYmtSa2d1amtJWnYyTEVCRUcwVFQ4ZER0V2xacWpQRzNOV3JOVzkz?=
 =?utf-8?B?UUhRUDNUT3lGM0tyUDREWmNrdy8vV2FrWjdyd0hLb0g3QTVaK09BeDVmNzhD?=
 =?utf-8?B?WnNOcGtmeXRObytWY29HNXFhUHVHN2lNc2g2M3o2YnMwNjdLemZablIzTjFx?=
 =?utf-8?B?eThCcThUTk5XUC95RXpXQkVyS0JKQ1VoYnNnVS9oUUMyOGFiTXRtV1JLbGh4?=
 =?utf-8?B?a0pORWRqWXRWOFg2UnRXbzFvYkNXM2cra1dlSUhCY2RCdDFGWjkwcTJBSWtD?=
 =?utf-8?B?TzdqSTFCWm1IN1pFSU9iczI2Qm1aWU9JNGpzZjlvcFZ4c1F4d2grd0czd0Fs?=
 =?utf-8?B?aGxmQnlKT3ArMHd3clJIeFR0azI2TWN5ZTd5b3ExYWsrd2FLM1NSUzVRMHFK?=
 =?utf-8?B?OEt6K0VWaGVZOTB6VzllNmRRZC9EUzY2bjVXUkRIMnRjaVhhbjA2aEo5ZGRi?=
 =?utf-8?B?MncxWjN1dktUZW5XRC91QkN5NEpWcGVnZkRVYU5RUVZ3RE1NdEcrTkRVNEtn?=
 =?utf-8?B?T1lZN0NhTmpjeVFQK0I1N2M2SmJ0ZUppbHorYkdzbjNnUHdrZ0xia2tFb2RS?=
 =?utf-8?B?VmEzTGc0OTIzYWFlVG5wdnpqZVAyd3JkTlVIdXVXZkJJY2pSbTV1WThUTUkz?=
 =?utf-8?B?UHpqMjZXMkVNZkdrVTlxaEs3SlJUd1BaZGNmRDU3SnlFaGUzOXN3dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e77a26c-3ee9-490d-3957-08de4faa21bd
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 18:08:46.3516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eUhqwaH2KmwdNov45ONNaONbf/zG5AsSaU/CN0xnAyyxAtXO8Cf4RUBBTHlG8xXP3XI2Y7OTPXxKEtdMafSmejxf+fUBOHuG8pd9rx7r1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7040
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

Hi Tom,

On 1/9/26 6:29 PM, Tom Rini wrote:
> As seen with a recent pull request, there have been implicit assumptions
> about how much custodians can change patches before applying and merging
> them. This has lead to an unfortunate situation with a contributor being
> understandably upset about the changes.
> 
> To avoid this in the future, document a few things:
> - Non-trivial changes to make something apply need to have at least
>    [name: what] in the commit message.
> - Only trivial and obviously correct changes can be made by the
>    custodian, and ideally this is done in a merge commit and not the
>    patch itself.
> - It is the responsibility of the custodian to gather relevant tags that
>    have been provided by the community.
> 
> Link: https://lore.kernel.org/u-boot/1faefbf2-e8b0-4c94-85f5-025355915e0d@gmx.de/
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> With this, Heinrich, per E Shattow's comment on IRC, can you please
> revert the commit in question, then apply his patch as-is, and then your
> changes as a new patch in order to show correct history?
> 
> And I realize at this point the subsection of this document is a bit
> wordy. Maybe a follow-up of restructuring this part of the document
> would be helpful? I'm not sure what would flow better however.
> 
> Cc: E Shattow <e@freeshell.de>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/develop/process.rst | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> index 4bfbf0eb9c63..84ab09132a0b 100644
> --- a/doc/develop/process.rst
> +++ b/doc/develop/process.rst
> @@ -244,7 +244,12 @@ like this:
>         custodian can also accept patches against older code.  It can be
>         difficult to find the correct balance between putting too much work on
>         the custodian or too much work on an individual submitting a patch when
> -      something does not apply cleanly.
> +      something does not apply cleanly. If non-trivial changes need to be made
> +      for it to apply the custodian is expected to annotate the commit message
> +      with ``[name: note about changes made]``. Furthermore, only trivial and

We should provide an example, I think.

commit 66be03b7ee19444b23aae3990a434a7470fc1641
Author: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
Date:   Fri Nov 28 12:03:04 2025 +0100

     binman: blob_dtb: improve error message when SPL is not found

     When using binman with the '-a spl-dtb=y' flag, if the SPL blob is not
     found, binman throws a cryptic error message:
     binman: 'NoneType' object has no attribute 'startswith'

     Let's improve the error message to explicitly state which SPL blob is
     missing.
     This is particularly useful when binman is used as a standalone tool
     outside the U-Boot source tree.

     Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
     [trini: Add '# pragma: no cover' because coverage doesn't seem to like
     the documentation about this error]
     Signed-off-by: Tom Rini <trini@konsulko.com>

is a good one I think.

You also added your SoB which isn't mentioned as a requirement here. I 
believe it must, because whatever you added/changed, you must comply 
with DCO to do it.

I'm tempted to say we maybe should add a link to the original (unmerged) 
commit so that people can actually do the diff themselves if they want to?

For the above example, have

Link: 
https://lore.kernel.org/u-boot/20251128110304.63138-1-jeremie.dautheribes@bootlin.com/

Maybe? Not sure how much friction we want to put on custodians. There's 
probably already a lot to do :)

I would really like also that custodians *tell* people that they have 
merged the commits with changes. 
https://docs.u-boot.org/en/latest/develop/process.html#work-flow-of-a-custodian 
says it's only "ideally" they do for merged patches, but I really think 
we should tell people when changes are made to their patches.

> +      obviously correct changes can be made, no other changes should be made to
> +      the patch itself. Ideally all of these changes will be in a merge commit,
> +      and not the commit itself, but that is not always possible.
>   

I have never been a maintainer in public spaces, and in private spaces I 
enforce a strict rebase policy so I don't have merge commits ever. I 
wouldn't know what this means (but maybe custodians do, and that's the 
most important as this isn't something contributors need to know?). How 
are we supposed to do that? Note also that not everybody know that git 
log -c (or --cc? I use -c but it seems to be showing the diff of the 
whole merge and not necessarily the conflicts?) needs to be used to see 
the content of a git merge commit (it won't show with git log -p).

Can we provide an example here of a good merge commit that highlights 
what is expected from custodians?

I cannot really comment on whether this will help custodians do the 
right thing as I am no custodian.

We need to set the expectations for contributors as well.

"""
Trivial fixes may be applied by custodians when merging your patches, 
sometimes without public notice. The operated changes are explicitly 
listed at the end of the commit log or in a merge commit by the custodian.
"""

or something like that? I'm wondering where we should put this though. 
https://docs.u-boot.org/en/latest/develop/process.html#review-process-git-tags 
or https://docs.u-boot.org/en/latest/develop/sending_patches.html? I 
think this kind of change should be in the same commit (or one that 
follows after, but is done now).

We can have some words about proper etiquette too? Like avoiding big 
series, waiting a bit between versions, not silently ignoring previous 
reviews for newer versions (you can disagree but you need to speak your 
mind publicly and "resolve the conflict" before sending a newer version 
(or at the very least say why something wasn't done in the cover-letter 
or under the --- section in a patch), waiting at least a week (more?) to 
send a ping on yet unreviewed patches, ... That's what's coming to mind 
right now, there's probably more to add? This is a separate topic and I 
don't want this to be a blocker for this here.

Thanks,
Quentin
