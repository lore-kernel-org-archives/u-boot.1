Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3E8C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 17:57:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E8E280D3D;
	Mon, 20 Jul 2026 17:57:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7th3M-sT-vyM; Mon, 20 Jul 2026 17:57:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BAF3780BA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784570237;
	bh=iOAUfPfX+HzP/afChSMid4pCg4BnO/Jmc8StCjGQBL8=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=gcwRJ0LsNOXsk8ypvHvJD9VlroRF/N4u7iMiMp0PxSs/Qh2NnWPsmaCWtaehuDpFr
	 cKNqZU/iR0V1guGMZZz2zfxbTr6+ColDBRcQLNqX1hPl09AFCJAtFO0mQxumFyXwJY
	 lH5/d2Pr7E4CJKL9trxxEwTeVcpKIrr9tSvTVb1Rh4ylSSah6NHIM/sCkfoulWyymR
	 II0DBR6bAaW8sn03u6cm673N14+ToTccLq/lKO/pFCsBQm+erbwFirVmc6IUatSmcx
	 cBsnWn12JSugI3FrDp3vWeTiV2V7pdqkVfXCWctnPnjC/i0HJSE6r/ppyM57oKtpX5
	 15qGQxNbUFGrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAF3780BA6;
	Mon, 20 Jul 2026 17:57:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 10CD7313
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 17:57:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E454140015
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 17:57:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ifBSIkifm1ca for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 17:57:15 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A7A8140081
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7A8140081
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7A8140081
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 17:57:14 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF416842FC; Mon, 20 Jul 2026 19:57:12 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB5B80433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 19:57:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAo9fhQWR4ato1a6Nx9DkilTKYbnSMQ0KqkwFymAhRlPajF3VIiLwez9h879LbmoeEtrm+DXLAzwAqubb7dYy4B+XDKsLZbNWCKgiKPC0kYFO6XW3hMLFQ42VwSBn4cVskpqXZB9bqZsgCP8gk6Wt5RLRJ7bR+JeFb1ZsOSASU+DU4nBXqxsZsqlmJl+S00lOex17CUSqADpRFfQytL9MCCAuw7gS4fepC5qBWFApRyg1pvDSHkuRTrwxLQ7ziswMQRe3eZBNlMsQE1EHOWsg10g2/z71VXKt9dWRiS4TXu6bhw8NUsANb3KB+OTVqAMkW0+KFUGsH8BUXuqU6AJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOAUfPfX+HzP/afChSMid4pCg4BnO/Jmc8StCjGQBL8=;
 b=GtMZ8QQybWP+fKabPt5rhKrIjhThx+qihdKgb4FWBJ/F2bCRhZE+9gZDNCAkcSiY92phkyPhZ0axQ+H/S0M7QmRiZSXdudQgEzx6/zCeSl+POLOk6ISyxDJai6GdV2FnTDHclC2aNHKtsA8arfKuy/NGHlrsahIb/gJhACFSBhitr4PF1UDzGaF+0cLzhpzBGqsvc8xFAxHf+HGlGRV7CD2kOkAQJq7pVrctYiPuV5xGrfNdCjXFS5lA4w3Wt4S0bEjHtWE2W4Jy0wDOCOrX7StXq17+Vak9SdUtQHaLxsdzwz7djHW0+G/BiHKc45dXh/uO8pdLydeE08wDQPvygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM7PR04MB6967.eurprd04.prod.outlook.com (2603:10a6:20b:108::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 17:57:08 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Mon, 20 Jul 2026
 17:57:08 +0000
Message-ID: <57e549ad-4472-4aff-bbe1-c2ad181bf8b1@cherry.de>
Date: Mon, 20 Jul 2026 19:57:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] roc-pc-rk3399: Enable redundant SPI flash
 environment
To: Fabio Estevam <festevam@gmail.com>, kever.yang@rock-chips.com
Cc: djw@t-chip.com.cn, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
References: <20260701175800.40141-1-festevam@gmail.com>
Content-Language: en-US
In-Reply-To: <20260701175800.40141-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0028.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::23) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM7PR04MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: d1fd080c-2128-4ef9-d679-08dee68850fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: VvX6gHz/AadDUQF9gsBxuS7tP16GPG393BgfTNZ0iYoDjy/quQJyfie8PcOsRHQm842RMXugRrtlnBlB8SI/EUB1F254/tUM19eKmYNcGdZZ5MRrbugu2Y6g8BP7nFRixETZft5GF2bE1oqdRmR7LSQoH5HwT5McBz8X7MklvvpWzyUwRAiN9bBs1qXQpjeFE3ZRqKUsv94F+dgSB4hRc5zVw9HawiaZJI7nm9Ec1PTLfjzBC4gq0XoZB3XJxUfNvS1gBL+GnahzTYIk8Dj2u5Gbq6QegQWIU1NdfstTfSi9K+huEl6kfY2wJQXH1MpGad2+WMZ2T4uLZe3jKUHTO589brFVhYOyCpQZYzx3aNmOKxf/X1hLupgzCyWg1zUugOlZYU7q9pEbuiW9NN7NLtb/XuVwOTSFymgMTL1/jbTxm1nTftrRqh44mfjVR9w4QLPmBEYtQGF4jiqJGldtfZiTX/tRtapVQFQBrawVJQs6E5xhui+dMFw5p0wz2wlAB/Bk4CxeAzSYhVGR+lQ9KiWntfG1y9IlBw5rQSlrYCX2y7lCtQiAZavLezEdH9Go3a5cwybz0lO5juQU6DcbpVEYn14utK3P7baML7ZlJ3j03tEYUz7x9WCzxjEK5wp3S0VFXtCqvCNRjuQeITHTJBtVNESWOEhYwE8+COtmhxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWFPUEJZK1h4TUprNVY4UU5NZk1lWXJ5TktqZklnbUFXVlp3YjlZTjJuNldM?=
 =?utf-8?B?a1dwWjN2c1VhS0R6OVpyMmpiRzVhYTN6cTNKa1RtWUpkMW1WK2NmTjg3dmNP?=
 =?utf-8?B?a3F1eXg0MTlPQ3QyaE4rYlZ2WFljY0JCZHRBQ041THcrdzZkNnFvSVpSMCtT?=
 =?utf-8?B?YlJHdEJqcERiN0ZzaUtESkJ3REc5UXpCMmRCejQ5Qm9SbjJPVEZFMXFEV3RN?=
 =?utf-8?B?Zy9NUjNnMENZSnRueTJnVEpoc2d5OVB3Qy9VTmRDODFHWEx2bDI5MVlEVnlk?=
 =?utf-8?B?SHF2NkxVY3k1RE5ORnA1NmlabXFqL0J1TFlhc2RuNFluRTlKRERPOEJZeXh1?=
 =?utf-8?B?Mjh2UjdZRE1oSUw3WVVyRTZpWUFqYVQwcXN5M3RYVVFMT1V1emREMjFMV0Rm?=
 =?utf-8?B?dXVnUzE3NnFnWFVudlRROVBnR3Y0bVdkNTYvVWRhK0FDWmFSaW5Xd0tzTUFm?=
 =?utf-8?B?bys2Q0k2L2RwZHEzalViYjIybk5DTGN0TEk2NmhnTy95WXpNaytMcFEwMHd4?=
 =?utf-8?B?dTVmcW1VWGZON3BSN3ExUzdUNUk0enBOMkwySm80bjJYdjFCSzVLb1ZlM0Q2?=
 =?utf-8?B?blZycHhqTERCeFlhdDJQZ0ZQNG92T3FiSW9LTVgweXJRbitXQUJ3b25YeW45?=
 =?utf-8?B?TmZhd3ppVUYyZFVxOGdYYXd0cHlnS0IyYU1USEZiQUlBeEFoUElKU2tMMGhx?=
 =?utf-8?B?NDU2c216cEN3QUZSZkhYSCs5aWE4TXlTQ3ZCaS8rTURMdFRnTmhUSXUzKy9P?=
 =?utf-8?B?THJibTdQc2xvSVl6VWV4SkJGSEJ6WktTL1V4Mm54M3VvNCsxUGgyVUcwVC84?=
 =?utf-8?B?YVFtOWl1ZHJxb2hIZWhIMFkzNnBVTUhnK2lLRTZiZXdJTzYybHVLMThpVTlD?=
 =?utf-8?B?cU9BckJrNHFBZHk4c2Y2RlFIQnNKRUkxZmRuRGZkWnIra1IraVB4R1phU2Vj?=
 =?utf-8?B?YmdnVytwTEYzTE04NWFRUEhHQk5PNjloUUs4M3hoODU2TWNzdnpFVEQxUDV4?=
 =?utf-8?B?dTR3SVFReUk1NUJIazdmKytmb0tsUHlhMmRyKzJwL3dkMFlCb1owYlB1NitJ?=
 =?utf-8?B?RVVRdldMVys0Y0xzTlJLaVBwMkR2MVdmTFFVOFdqWUFVbkxvUHREaDBZejR4?=
 =?utf-8?B?VE5PWEN2OXFFUG1meklRZmlsbWhDOU5WeVh3RExJTElYaW12U3JhK3hRd0lz?=
 =?utf-8?B?cjNjTzI1M0MyMzZjUXpmajdneDdqc3daMkFrSjFIS21MeGx2VHUyN3g2QWMy?=
 =?utf-8?B?UXhHK25ucENSMlQvejU1bW1tOGVmbGdBY01yanNFOVROczRHQW1JYXJGZmNn?=
 =?utf-8?B?QXJZeWVlYVpJRXhXSFJ5bXJWZ05BRlppeWtvV1NGb3NXOWpKTmhyaGVHZ1BJ?=
 =?utf-8?B?V2NkVGdiNkdOMDIrb1lPNGJ0bUc5blg2dk9KdHZvTldmZ1ZIMGtuZ1E4dVNH?=
 =?utf-8?B?U09rQ2pOUDFJVzF0MnYzS3ZlL1NidktDRDZqUS9NeWRqRzNBZDVOL2NzTGQ0?=
 =?utf-8?B?akQ3NTduNS9RY0pEVVNSa0p3Z1QwSERqRWZQSmExbUhxRWQ2cWdlc0dzRnRB?=
 =?utf-8?B?cnRTR1dkS0pUeEtYdmRFdWdsUy9nOENtV1pwU0lycWpYbm9nVFlIL1dFN3o3?=
 =?utf-8?B?ejNsN1BjU28vaDNnMkVIMzdJa1BFRE50dnFoQ0JBTlU2RmRUSVpPaUVscDho?=
 =?utf-8?B?RzVnZkxaM2QxTW5oWS8zNW9GOXEyV1RXaENrSkFXVUFJcUU2ek00Ym1MeUND?=
 =?utf-8?B?N3lKZXhhNVpwUW9aOXcxQWs3ZUlJaUV6YkhSaGVrVWpjTHJSNDUyZW53NVZv?=
 =?utf-8?B?a3JYbU44TVZIVjVFckZ5WERGSkFXbG1oZ1lLWkNNUkhKWnBwbVNGVHg5ZXNu?=
 =?utf-8?B?ZndTRXRaS3dSWFN0NW1RK2llcGVpcEFnNS9QOXV0UnZjNlBObk5Zc3NpUTBs?=
 =?utf-8?B?YTZLRStML0dnVEh2ZmZVTWxYV2ZzWXk2SU9aZHZHUTl0ZmR4aXdqTm1HRWlo?=
 =?utf-8?B?UWIvS2dZZ0JUVHhzWXZES05ZY3lrM3J3NU4yaG5RNjJVZElXNmNYRnJZdmJY?=
 =?utf-8?B?aTU2blo4MjZURnZHSyt4QUIxVXRuZWpHWnkrejc3eWJ6dDlDakhoUTI1UFls?=
 =?utf-8?B?NnprUFlNdGJ2MkR6Z2FJUFd5SEExS3BjY3lkWmwwRXJlUjRGUmE2ZVNxYnlm?=
 =?utf-8?B?TDlTL3d4T3RpQjJPckM0V1hVZGlzbWo1T1BnZm5FSW5jeFNxRm5NVThLeVFr?=
 =?utf-8?B?bEJaSENkNWJIdHM4eE9qSjRDaVVVQUt6V0pldzd4MEEwZ3RwU0d2QVNlaUly?=
 =?utf-8?B?d3ZKdGhHSmVnc0pNU0I5R1h4cjdHWnUrZTFRVVlFcXFOcTFhSWJsdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fd080c-2128-4ef9-d679-08dee68850fc
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 17:57:08.2483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88UMtU7qL5dGd2TNJ+YayQSb2MBPjcfNXwKwqg9YppB42zgcrV6dD7KfMvqKgoWfzTFe6hZDg/75mcV0v1ipf3tCvrJRuuV/qUjjvgeVGP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6967
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOAUfPfX+HzP/afChSMid4pCg4BnO/Jmc8StCjGQBL8=;
 b=KRWjoJj+eOxZUzsRre8JC52lU85VEhrTknzl4lLt906krTx81CpQwKCSJiT0zjCjWhwDWLRya01iQP+hZEXUyo/mwd0b/tWcN8eY6xjRsMuU3CrQUp7aw+TlCHRyu9RowZilA9WhHP/slvgNl++Y1dNy5bEZL+gGCHruwBJBPqY=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=KRWjoJj+
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="KRWjoJj+"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Fabio,

On 7/1/26 7:57 PM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> Enable redundant environment storage in the SPI NOR flash by enabling
> CONFIG_ENV_REDUNDANT and defining CONFIG_ENV_OFFSET_REDUND.
> 
> Move the primary environment to 0x3f0000 and place the redundant copy
> at 0x3f8000, matching the existing SPI NOR layout.
> 

Where is this layout defined?

Considering the env size is 0x1000, the same as the erase block size of 
the SPI NOR flash you add support for in patch 3... I would have 
imagined to simply use 0x3f7000 (or 0x3f9000) (or have them aligned with 
the ones you are trying to use for the ROC-PC-RK3588S, which is 0x40000).

Looks good to me otherwise.

Cheers,
Quentin
