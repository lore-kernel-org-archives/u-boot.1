Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEB6C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 06:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B94AE87FA7;
	Mon, 26 Aug 2024 08:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="x+f/JJ5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE66288001; Mon, 26 Aug 2024 08:49:12 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2DD187702
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 08:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjnAtEc7ne2c0vhHyQDKMqcjURBMHAZxWSeaBqU81vaW1VBe1IZDy/x5+dUdQE2Q8El3amckHjRCI9uMEi1VizlC8PCRf+I+Wiv3OvLhoIoF1CRRb4d2NmY+mmVO3/YMSGKeZbe5pQIFo0abz41SSfySmedKd+MCTlbRS50s0WEGACDscCMy/GxEzl6tydiRsGOWQbRD0Hvgfj4JN/UBI2u0ooqzarAejxu2UzJmQM1ZSeqCpGYC0Y1ZBG65Gxxh5L2CSWEOeDJlfUx3WvJteqeS0jV9QPII3/u1zqpivtLNlzNp3gOP3QMWnUgHOZmsYHKLE8qRday0Bf90rvFn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Akg40gMcVR/sQ+JVyShPmQ+9PplTer21Ix/o0MGdVE=;
 b=IiEQ5V0+84GOERqnz6P1EEumTOvypiYDy5SO0hlO5j/htRT7/5nVK85h/JF8WCLTDww+ICgW7qHX1eIrhXcnAz1hq8ueYdghJZeXORMxZRm0dRh1QZwKe/Cs+eSf1LFzcZ2CMyzPa3/INyElmk8oR5wp1f+jCykMPcMDXsN/176P90Zcm4/H9sJA9k8TOGvV5FpnpbvV8n9aFxY7Nxsuvu7CkMs2+S/eNTQ1G/rontCUGVCnYNpTzHo1qzwleoon4c4ID1cW/dm508cFXSLCEE3FqyZX4QXNaXvt1YoSwbsWSPS/ZG28bOFCF1cr0AHdW7aWF1J2l9lJcoc9NhZlgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Akg40gMcVR/sQ+JVyShPmQ+9PplTer21Ix/o0MGdVE=;
 b=x+f/JJ5Xtauq8bEM5Xs2QhC+lHc0gkM1GggK8A5U9mcw5XrMDTqPPyPBTtGygqrVY/Ci1vkDER+FYwQe1rfXdzzSlOBYgspGxv2U6Hn1jSWMzjvwjJB+yWrXcTJncYQlQVDJAMit9nd/81mkkBHReXOwO0hXE8U1INWZM0W4X8iaE72eScSgGgkgeBO9kTy/eNRA0Wek+lkgyH8pEjZ7L9lehay4hpLznbBAA/jSpjEUDgBg91/P7/cFrL2+zxyhU2aPcZ9twu4itdFP0ErXUXLEt26MSovH8DDMAVIhVjrC4SVeq/1dHs18x9+9yah8p8Mbxwar9W4DNuzdloZJ5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3676.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:49:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 06:49:09 +0000
Message-ID: <4576b818-9732-45ff-a4ab-b98fc0ecf4c9@siemens.com>
Date: Mon, 26 Aug 2024 08:49:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: OF_UPSTREAM vs. additional dtbs
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
 <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
 <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
 <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3676:EE_
X-MS-Office365-Filtering-Correlation-Id: df33d54a-bbe0-4969-2b1c-08dcc59b2fcc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEhTYkoxc1QrcnpldUlVV2ZUYmJpMjAzRTJjY3NMUCtSbFlRcHlTbzd2UVU5?=
 =?utf-8?B?UUlpUVJTcHdpblgwR3cxTUN5MTBRYTNsdWQreWFlY1ByaFZmZktNWkhzK2x2?=
 =?utf-8?B?Q2liOXhNd3NtZTFWMGs4ZXhoeHE5bitkb3BCMWhTSVFyU0x5ZERRck1OWkdU?=
 =?utf-8?B?Y3J3QWhtS1BnZXZrZGFjempIdm5YV0FFb2JZRS94amtWZFc1Mks4YVJUQmNI?=
 =?utf-8?B?MCtOZkdCWXpBSFJRZWpGWERTbEFLTVh3YmgvRmwvN0FJMmYxcElyOUtqNFhs?=
 =?utf-8?B?elhSNVhmckxGZmF1RnMvR3V1UHljUjFYOXluaWtvY3h1bmJ2NUFLOEVoZjRU?=
 =?utf-8?B?N2hNNktSTmVHdnJRR0p6Ym43QUdSclZNTXVBbXpVc0tRbWhhOWM4cFNFZytJ?=
 =?utf-8?B?dGJ6dThMVHBLbUp2eVgzSDY3Nkl2MGV2Y2NWbHBtcXh6KzFMVVVmOXQ1ZEVr?=
 =?utf-8?B?SWxjMnJlOEpGK0FCYUZwK0JKRDhwaHppNG5sYzhOYTJCdEoxRmJlUXZScHV3?=
 =?utf-8?B?OG1WUUdlUFRYY0RwK2t6bnc2T3Z1bEdGMEZGaURjczNiclk0MmdaQU9HcUlP?=
 =?utf-8?B?Z3NweGR3M3R1amtQdVlMY1U1eFFRR3pzQk9BV3RGdGc2OXh6YnhTQmhWcWQ0?=
 =?utf-8?B?enR1aGhsalliaFFadFNGTUhMRC9QRG1zTEIvSjFYc1AyVExxTlRxeVdNQWtL?=
 =?utf-8?B?WUpuYVpmOVFJMVpXMk81SWRpY1B1UTluOUZLdldIaWRkMmd3dkpDdTByWEMz?=
 =?utf-8?B?R2Nhd2hlMDFGSnVFS1RGV2R0SldLbnk4MlVTaHF3NFVObHpFTnVhUVhDY0wy?=
 =?utf-8?B?RWpYRjlpN0Z4MmF3YUJmaXhNNllLM0UwRnBNRUM5V011WDZheFIrRVNNREg1?=
 =?utf-8?B?VGRab0NqUE1ST0F1OFBuVmdXT1pIYVg5VGRUaDlxYngxUFNyUTdQUmtMejU2?=
 =?utf-8?B?SzZaN1pzS2VMMVQrK0VWWkZoSmF0eTljblNPMi93Wkt3RjFxL2IyR1ZESi9y?=
 =?utf-8?B?RkhHcHNkMFU2c0tJbkZGbG9PV25nNmp0TVJWQkxrRUdlRFVJbVFjeG9zeTJx?=
 =?utf-8?B?TXRYaWZVKzRhbTZOZy9RYkozcWdRWUx4M0NDY0FuNWxnT0l6MGdQM000RGRW?=
 =?utf-8?B?N0NOTTZFc3E3Y1U5dUU3S3R2alNlTVArY040clZzR0EwTy9tOHpPamROUEM3?=
 =?utf-8?B?cDhXTXlDcDlRNEkyNlNETC81MEJvdGowWDQ1L3NQSXVYU3pBbGN6Q0lpeWlj?=
 =?utf-8?B?ZlVTWC8wbkdoYTVHRXFOc3g5MmtUdFJScTQrT0RtQytJL29HTGh2NXRBQ2FW?=
 =?utf-8?B?ZnYwNDVQdGx3Q0lBTDBVeFhYZzROR2RhenZ5SDRoMjJMV3NzN0hsdFpxVmJw?=
 =?utf-8?B?NjBSRk9rcmtpYnhnTW1id3VpR1pnWnJQamMzdW14NThTeEJDVmpva3M1Vmhq?=
 =?utf-8?B?L25rWkRaandRZC9EcExzYnFuQ3IvMWhRMmtSaXBJRG9nT2RHTzdmVGlqVzRz?=
 =?utf-8?B?MEhJYXl2SmNyNzNUdGVVNnhOd205QWZRM1laTXVyTTB0MEVRVXdRdHFDTnc2?=
 =?utf-8?B?QTJLTFg4Z3JpeFg1NmliY0F6WHZWZDJ0Qm9NUDhQMEFlTzJyOFdvVk1NaWxi?=
 =?utf-8?B?OFlvYWFoVkgzb3FJTllxK05TYnI0NTZnQndjV1RUai84T0hkTXVUamcvU0xW?=
 =?utf-8?B?RzNrZjlkdnQ5WlQzd1JtRERKUFo5UlZQVjVaY1FXb2NHODdRUDZzNWlBb3JP?=
 =?utf-8?B?Nm1RUnVWSXJGUzB0cWlMTDZ2MzYxU3FHQnFqWGRVenY3aE9JRTNWSC9QcURl?=
 =?utf-8?B?R1c3Y2xaWm5TbTdrNnRWZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlV3UVBtVU11S2UvVyt0R2JsOEUyZmNqZEJDM1JteTdjeXRuVE9mcVhNQm1H?=
 =?utf-8?B?bjBIWFIrQzlnbTRmSVdTQmR6YVZGRzNzYm92bU52V0ROT0JTd08ybXNtSUFP?=
 =?utf-8?B?OHc4MzEzUXZFNkVtUUwwb05iVTNVYlVZaDFucFVWTHJjaXlHZjVZZFBFV05H?=
 =?utf-8?B?QzVKQWxMa0h0QVVUNStIUWFleEZTMStLS2JEa0pZQ0c0U2dpVmpaR1hXZkdh?=
 =?utf-8?B?QjNwa3haWkwrZ1FHQXJPVjlRNE1jUXVJNUdXREd4Wm1DV053cVkrOC9tZFY0?=
 =?utf-8?B?ZUMwbjRHdHZBby8rMC9QZms5d0kvb21MTGlwMmdvdVZXY09mbzBBc2pZZmZx?=
 =?utf-8?B?NzJjbW9wdkpqR200WTVlK3J3ZjNKdWl5WkJ1eFJwMjBoRGs5bm0zZ0NlL0ky?=
 =?utf-8?B?VnZuVlZBTjlRTWtOc1cwUWhUeDk4Z2Evb3F4U2tranR5WWdXZGJGZ3RnTUpi?=
 =?utf-8?B?azVoVk9OSTM0aXA3S2pCRzFDT3MvWnF4TVZYTnQwNm9SMGJZTmZvSmtUdmt2?=
 =?utf-8?B?WTUwS005QlJzK2F4QWlPSjZBVEZJR1JSOFR4VWwwT0JJaEpyc2pBK1Q2RTdQ?=
 =?utf-8?B?WXRmcGRXNkMzaHdvVys0ZTh1d3BkRDFaaHlQajArZy94ekNaVE9kQ1JvWWFx?=
 =?utf-8?B?Y1AyZDkyT1NCc0dTa3ozeFVFd2ZTdEFGTGgxTVo4UFFrY1lhdHJobSt6R0wy?=
 =?utf-8?B?cXpGbjFYQUZlK2JBci9YNUtuV0poUG10VVIvVm9IdzNZdHg3dk5LQWZzeE51?=
 =?utf-8?B?ZGZzT0UzV0lLS2ZOYlJtQXBXTHBoMDZqVUtydDZvdHh0RTUwNUVid00vaHo0?=
 =?utf-8?B?OFV5cHh1TWVYYnBSWHl1eWNZckYrdkRtbWx1QVpzeldMNDBmbWpmVTZTYzZx?=
 =?utf-8?B?MWZKTGMrL2pSSDVleTRwQW51UlZlMDRrZ3ZxSzhScVI4MEVqODFZWHlxRkhR?=
 =?utf-8?B?MEpRQXhiWWhydTJXMkZFWXZvenZWTlEwcEsxL0xZd1hWNTRHdGd4OVI3Sitj?=
 =?utf-8?B?VTFLNm5DMmttUXQzOForcVMwNldPcDJuWUd5QWJUUCtoR2JNczBHOVh6bjNC?=
 =?utf-8?B?NnlRT2FsZElTV0RRY3RzQXdmSjBrSVdUeXdxVE1HMEJSMGFRclNoWWdQeDNR?=
 =?utf-8?B?SjB6S2JXc2xkVEFOZUQ0RTIwcUd6enNoWW5jb3hQVEwvZDZIaS8wOFZWWXRM?=
 =?utf-8?B?M25RZU5pUGFxeUZlOE5BbTdTa014OWRVMGRiUEtlTFkwVExwbHpCYmxDbi9w?=
 =?utf-8?B?ZzdFMlFiaXplOXFpRE9ueGZSYWI1cDdEQlAwdm9UMW8yY2MxVU50MExqVWE5?=
 =?utf-8?B?cVJ4TVNsY0gwMVNqeUUwK0twbVR6UktJVGpTT3BZRkYxVk5OTXZGWWEvWjZq?=
 =?utf-8?B?TG4zN2FEU1NjdHBFdENNeml1bS94RW0zYURKckdUc0l1MGt3d24zZlgyTFlI?=
 =?utf-8?B?VUFhWXA5N0luTGhsNDZTV3ZEWjFoZkt4ZHNDYk5WLzM1SWsxQjZES085Z2Fu?=
 =?utf-8?B?Zk9QQ3hlZysvRUZZNDJyWmZhZDdqdzc0WmJiRlhkNFdQc2pNQllxdFBRdHN3?=
 =?utf-8?B?S1lTbGVBY1RBVzZwMkpWR2Nwd3RLZWRSUmZFOUwzUkpmU1dyb2JZakJwK1ZJ?=
 =?utf-8?B?THlRU0UyV3ZIcnlhVWVlMExTVnBRL0Zzb0liQ0h6dnpEWjMwYlc4RmxnOTBX?=
 =?utf-8?B?Y2N4VDJQR2ZHU3FyZDFML3IwT1ByQURzZFdPdVEwOGMxU2haaFM2a2FSZ2or?=
 =?utf-8?B?RVZuVHR2SHpYdjg1V0hUSWxLY3c2RERpaGtqQ0Y5RHlXVU5PVWcwL3pxd1FI?=
 =?utf-8?B?MFBpVUtMaEdic3J0UU9MRTVRa0hqa01PZW9YbkdKbUQ4aDN0N3VVSWJoeVd0?=
 =?utf-8?B?OEZHT3ZxRHArSWFvOGJDd2grMFdxbVZvbVUvSFRSMWUxdmJGSmYrQ1l5dTNR?=
 =?utf-8?B?ejF6dFZidWF2VFNHbnNPZVMwd09XSS9iVEw5RkE3U01hYXl1MUtlWlpqVEFq?=
 =?utf-8?B?VVRGUzJTeTN3ZnhSd1AxV0V6YmFTN0ZGWklSdkFYUEZna0YrTVhpdFVveWJK?=
 =?utf-8?B?Vk9oQU1rZm5rYlp4SGgzNVI3eFNET21wR1JOUUsyOWdObUMrMFY4Z3I2Q3Nw?=
 =?utf-8?Q?lufO3GkUzQ5GnT8DylRK1qEk7?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df33d54a-bbe0-4969-2b1c-08dcc59b2fcc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:49:09.3119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRbjOuszTul90+gW2nwaE9zvL6aTWlzVzV1DRFyH258vku6v49DZbXcQKRjYuR4ibgA5DARQkyuEP2McytyGEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3676
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

On 26.08.24 08:44, Sumit Garg wrote:
> Hi,
> 
> On Wed, 14 Aug 2024 at 22:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 14.08.24 11:41, Jan Kiszka wrote:
>>> On 13.08.24 14:52, Nishanth Menon wrote:
>>>> On 11:16-20240813, Jan Kiszka wrote:
>>>>> Hi all,
>>>>>
>>>>> I'm trying to migrate the TI AM65x IOT2050 boards to OF_UPSTREAM but I'm
>>>>> facing issues because I need to still build the u-boot-only overlays. It
>>>>> is also a bit weird (but works) having to specify
>>>>>
>>>>> CONFIG_SPL_OF_LIST="../../../../arch/arm/dts/k3-am65-iot2050-spl"
>>>>>
>>>
>>> Actually, this does NOT work: I just had a long morning debugging SPL
>>> which no longer started because it picked the non-filtered dtb. The
>>> filtered one ended up in a folder outside of the u-boot sources because
>>> of all those ../ and hard-wiring to dts/upstream.
>>>
>>>>> for our spl dtb.
>>>>>
>>>>> Are there means to still build certain dtb[o] files in arch/<arch>/dts?
>>>>> I'm a bit lost in the Makefile forest.
>>>>>
>>>>
>>>> Sumit: Any suggestions?
>>>>
> 
> Apologies for the delayed reply. I was a bit busy with other high
> priority stuff.
> 
>>>
>>> I would really like to hear some better proposals than my local
>>> workarounds to far. They don't converge although I already patched some
>>> core Makefile (overlays are building now).
>>>
>>
>> OK, I side-stepped the spl issue by using one of our variant DTBs for
>> spl as well - happens to work.
> 
> That's good to know.
> 
>>
>> For the overlays, I need to add
>>
>> --- a/scripts/Makefile.dts
>> +++ b/scripts/Makefile.dts
>> @@ -1,5 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0+
>>
>> +include $(srctree)/config.mk
>> +
>>  dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
>>
>>  ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
>>
>>
>> in order to then be able to do
>>
>> --- a/board/siemens/iot2050/config.mk
>> +++ b/board/siemens/iot2050/config.mk
>> @@ -5,4 +5,12 @@
>>  # Authors:
>>  #   Jan Kiszka <jan.kiszka@siemens.com>
>>
>> +ifneq ($(CONFIG_SPL_BUILD),y)
>> +dtbo-list = \
>> +       k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay \
>> +       k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay
>> +
>> +dtb-y += $(patsubst %,../../../../arch/arm/dts/%.dtbo,$(dtbo-list))
>> +endif
>> +
>>  flash.bin: all
>>
>>
>> Does that make sense?
> 
> A switch to OF_UPSTREAM means that we build all the DT artifacts from
> dts/upstream/src/ directory with the only exception that we include
> U-Boot specific overrides via *-u-boot.dtsi from arch/<arch>/dts. In
> case of overlays, is there any reason for IOT2050 board overlays not
> being pushed into Linux kernel repo? AFAIU, overlays are also
> describing puggable hardware so they shouldn't be referred to as
> "u-boot-only" overlays.

We are using the overlay to massage the DT presented to the OS based on
firmware configuration. So, those two belong to the firmware logically,
but - with some disclaimers, we could also try to upstream them.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

