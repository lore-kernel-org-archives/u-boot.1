Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6DBC3600B
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 10:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20D2B808AF;
	Tue, 25 Mar 2025 11:20:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WBuGdcVU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28EA8810E8; Tue, 25 Mar 2025 11:20:42 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C753980107
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 11:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZ7IC79dSZ/O6yo1wZ7Im7QZjIDOT2Fb+uukRzyZAn66jxu4Ko4Kl22MNGXjsJ1D5fOOECHqLX2KdVlpPBAO156V7kRcZSo3rwY6vX+EIKIwFKrhub3VPNGULaRUz2l1aZyCD5puGY+sFY7OLB3XAW16Fe1/te21Na/7UJH4nuNdgpJ1wXrLHgpPrJ7axMsPMu+OwSV6No3KnSASiggCmGljEO6Vq06AELJfcNtdiJxtlfIWiXkzc+EghXQSLbL0Yi1p3q0vWjXk/UeNL3RjXVmZ/uVw/IhXAH1dyZEL8SWj9a/iclF8ysQJcyYKhiboDRFYzBE5k3xM5TpR590t2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUaQ3cOmb9jnjxgcU8lDGsXUNjZK/ncLeFfSf1v67jI=;
 b=tgid+RiMpFqyE0YxfBSGF+mugBvM1AImyfci+NMswaSWLSbOEir3GkyM+fvD0F+SDP1xCydSM2+46DEhJGTUzVihPsK1bEzkzXwo8lcnS3nTiMjmKcHhPIsub02YlC6PVRglzF9mg4nY5i8pj6hXFsjBTW6fM6W7GQ5Nll9FaESL4ZAXnoujsEnojfCyiNOFjCg/nAY3eppKFE2MzVBYZXjZpwzWYg8mrR1cP+jTbWnkevgh7lqxtB+umdpyBxdJrH7FCtxp1h1WqXaK5JPpEBX4JmxPp2U+fb/ppK6uHA2QXsQdyixhGwxh67B89qaEWjbQOGrSmiOYLN1T+Rmz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUaQ3cOmb9jnjxgcU8lDGsXUNjZK/ncLeFfSf1v67jI=;
 b=WBuGdcVUGFaMznD5ur9FvQKnmrHsS+G8URzFUdgpSWbf9jpC9eZ+6YNYAkGUNqsbOdAS+t0GhaeiLui1DcIJT02ffKd15XHSndkT5x7MFmbs7bLGaP0wBkwIJ952ZEWOxRT5Eqq6LFcrrQkqe4r7yxlG+rzRJKywntMM0IO8yNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VE1PR04MB7311.eurprd04.prod.outlook.com (2603:10a6:800:1ae::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 10:20:35 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 10:20:34 +0000
Message-ID: <ef183d5a-48d3-4068-be11-04edd55febf5@cherry.de>
Date: Tue, 25 Mar 2025 11:20:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] log: Add helpers for calling log_msg_ret() et al
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20250319114947.2188805-1-sjg@chromium.org>
 <0bdf2e32-80f3-415f-a3b8-eecf5a4edd5f@cherry.de>
 <CAFLszThmVOd2G2zSHy8mNHEQ=FW7c+KNTD_XLxiQgbMKM=AxXw@mail.gmail.com>
 <ad07a506-c7a4-43ed-93c1-24626974a2eb@cherry.de>
 <CAFLszTic6gt4fT4pVVthd-3rRy6JZ_28QLXWOYPak=ZJqYH5QQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTic6gt4fT4pVVthd-3rRy6JZ_28QLXWOYPak=ZJqYH5QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VE1PR04MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: edbafba7-19a4-467f-1d72-08dd6b86ae03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFBTczZXdWdwZ0w3S0toOUFSc1FQUkZoN1JEOWtsdGN6YXFjYW16TnlSNlhE?=
 =?utf-8?B?UUhvRzFRazNuUXJveUUwZlY2Mml1OWxPTHBHYzlTZW9sYm9MQUZ1UytTb1VB?=
 =?utf-8?B?S1ZUc3RkZ2daTFpRRW9kdWNRRFByOVE3aEVEcGlwdHpYcUFPVDRnYWhFdkpE?=
 =?utf-8?B?Q3pBNW5TMFMrVml3SlJIb2dyVUc5aFp5UDlSMkdkYUdYUzhjMXRJcVM1STYw?=
 =?utf-8?B?QU12aUtselNZUXZ6YXFNK1R2M1lEclRBclNmNU9HNzZGT1FPQ1M1dFpVOGo1?=
 =?utf-8?B?bDBnelYvamk3WUxsZUQrOUVKSDV4dndrNVV4VUVYZmIwWm1yZFV0d0N3VzVY?=
 =?utf-8?B?djVBNFFabGdjT2ZucHFLbDJsd2lyMjV4UjljbDZKTTc2bE1RTzBsbHdrWlZs?=
 =?utf-8?B?WlBjZHhOdkVEbkF4RlNLWG13cFBDU2MvZXBLellRNmlMSWpSNnJkamw2QVRC?=
 =?utf-8?B?Yks5eDhJZnB1dlMvKzkrQ2FqclZNdzlSYlZjYUFWckErZys1QmNaaEdoTHEy?=
 =?utf-8?B?OUlFNGQzNVcxN0M1d25oVXpqQ0p0cmg3TnZkK2JkSVBTSWlFbEtNL0x1R1ZP?=
 =?utf-8?B?Q0hzY1ZmVWI0NmNIcEpEZTFXeW5WdTNVSTNWNDk2Skx1TkNmR3lGSVUrcFh4?=
 =?utf-8?B?TnlqdDFZMXI2YnVpelBjSkN2bzNlRWJJenFBT1ZONHBtaXNBREt4Qk9Wck1t?=
 =?utf-8?B?R3J3OHlURUpUUE5ObHN5Z2hMZDF5L0ZvUXY0OTRJM3RhMHZkSWM3dlpoZXla?=
 =?utf-8?B?L0txeU9iVjhQVDgxNW1kV2VuMWpWa3FodHNqbzIvaVJQM3FzTWY5eGpHdmtx?=
 =?utf-8?B?dndqNUZyTmJ6aU9MMmdqNDNzbnNlb2dYc2V6RURYamkzdmJ6TWNaYmxNYkli?=
 =?utf-8?B?Q2dsalU3UjRlc0FaTkIvSFpCTnQ2OWc2TC9qL0NmZmhuakJJWmZwa0xLWXUy?=
 =?utf-8?B?UitpWkt6anRrQVNCODRiTFk0YXdOeDlwbWU4U1VBYzUwMGtlbUkvb3B6eTYx?=
 =?utf-8?B?WHBNU3dMQ1lnYVF0S0tkTzVlZE8rdnNWaEQ1Z1greEt1MmxxbjdoSitPcTFk?=
 =?utf-8?B?bFUrUVA5bjgzYzJ0U3oyMjBHQ0ltSkU1aERVRHVXSDJKTzZYYjJNY2g1LzRv?=
 =?utf-8?B?UU5pUTV2cGxHVVBxYklldFZpU0puUjQ0cHU2cDljaW93TUhoY2NndVlYQVhC?=
 =?utf-8?B?TjFiVGc0cHhGRjNReGFOLzJYZ0pNNGV5S3hkSkdaTHNRUVM2Y1RlcVlxdHMx?=
 =?utf-8?B?Q21CTVpUVU9ha3Y2TTF0eCsvbEJaTFh1SDZPUitqc01mVjRITlNvaG53RkNW?=
 =?utf-8?B?TVkwcTJMU2RMS1dNNk5iSTNoZitNM1ZVMkdHZWNlNGM0U1FYNTNLeitMZzg0?=
 =?utf-8?B?cGhENkQ5VVp2NUh3aE0wTXNudmRISm8wNlhwQzdCNExuVlliTDd4N2gvQklE?=
 =?utf-8?B?bWg2YllyZEY0MDJwelAzUzdzd1dzZ0hMMDZManN6SmlwVU1UOFVVbHhqMml1?=
 =?utf-8?B?L2ZPeGJ3YnVoL25NdWJyUGhqcEtXYnJtNDdzdzVqWDZyeGltR3FYakd6dmdL?=
 =?utf-8?B?MGdnT0RFd1RucDBvdG1memVLOWl5a3BBSXBGSUxyMjFxVVlZMm9vOFhkNnUv?=
 =?utf-8?B?VHVjUEh4TjEwaHQrc0xOR0FBdmc3N29zYTZwWmdKZEJNcnpKdjhFN2E0akp4?=
 =?utf-8?B?L0t5V3Nvd0pHZ3RSSG4rclRFUC9ydDdFTFNKeHZuRkZ0MEpFLzlDOHVXazhs?=
 =?utf-8?B?d0JIV0htc3JxeUZCbndoQUhJeFMwZjJydWdRdjhvTkl4YUI3aGg1UnZKQzdE?=
 =?utf-8?B?R2NVSVlxUUNTNWJTaHRmdWR1dTNoZk9xYTZzVDVMYk5hVnY5ZkIzM29jL1Nu?=
 =?utf-8?Q?DnVkg1lFx+Tbq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnlDdmxsdFpiL2JKa1ZFY3VyY1ZlUlc1RUQ2N3BaTmNWR3pmb1Rxb0lUc25a?=
 =?utf-8?B?Vk9sTTB0YmNBSHVDR1dhNFhVMzkwTkZYNjh1d3hURnhlRFFkVVI5Q09NdDF4?=
 =?utf-8?B?TEV1SitJS0NjTU5rRXpZcDI4eXJKNHkwYzFYempyWFo5UlNXbWd1TWdETjVl?=
 =?utf-8?B?M2hYSEVyK0c2MDk4M0FGTTJ2eFVLODBOd1hCU0I0TG40b0VGbGR4U0J5VWhu?=
 =?utf-8?B?UWJWNTBqaFFCZFBFSHd5bjJkdk4yK0hqYVd0NVBmenFoaElmRzRZZ2VXek9D?=
 =?utf-8?B?R2JEcFg2Y3Rxcy9iNWpOdmFuU1NMTmp2a0M2elREM2NQeWt4VjZrNVpOVSt4?=
 =?utf-8?B?YmMrdEZhcXUremNXazFnWk1lWUt2M3dOK29PTjlwZUpRT3QybkI5SXJsWG00?=
 =?utf-8?B?bkdydTR6OFdudUUxbFBnNDJ0RFhBSHpaTVI1ZkJKWnVpdTlsZkNnRkRmUTRy?=
 =?utf-8?B?UVk1WHQ3WVJENGU5ZUdkV3pwNVg0QWJGdWNFak5QREZuWDJyQmdGa1pJNEZa?=
 =?utf-8?B?aGthU1I2czBrREd0enJmdmI5VFU5dzZGdGVHM21oQWJZdXphcjhZNVNVcWRa?=
 =?utf-8?B?VUcvYkRPWHVxSzQ5cVA1OXFJN3FFQktPM0NUNVdFSFZVb1N3dmRXc2Q3UjNR?=
 =?utf-8?B?dUo3RUFKRDFQSk5CRTQyZlk3S1pWK1Job0dlZ0FaVTk4blptTzh2NlFxOVlp?=
 =?utf-8?B?QTVXK2F6MGw5MVQzUnJFVjNHSW43ZGVBVXc3ZS9mbWZBWjJyR1k2VDcyTDJl?=
 =?utf-8?B?TlRiVmJld3c5ZVUzR1h6am55RTdqdmZ6VmlySS9ybERNTjZBc1BSWHFpc09v?=
 =?utf-8?B?LzRUZGpJQ2dTYyszVGR2SDZOcnZzU2hDWmhYb240UERmZ3NWQjJSMjh1VU94?=
 =?utf-8?B?VW5PbWRWcnNjNzBLM3B3MWRGdjYrZ3F5eFQwQWtqVzFHY1dVb3NIaHpOZkxD?=
 =?utf-8?B?QmZGRzYzb3AxOXQ4RndjaWxYYVlSc1ZRUmlJa1F2Z1pKcldmenZlTkd3VC9N?=
 =?utf-8?B?NUsvQnlSWVdob1BucU1ZemQ2Z1IvMlFlZWhveHNHWFIyOFMyT1VQTUsyZkF4?=
 =?utf-8?B?SHdlMVJCWklCbmk0MHZITGpOMHJqbGcvSUZDUzEzSFRZYkh3a0doaitTVXcz?=
 =?utf-8?B?d09IbUhrWlVCemFzOVFWandFYkpJS2xieGNtQmhTSWlWazdkTG9tSG8vSUZ0?=
 =?utf-8?B?RThhRXc1Z0k1WERSR3dSRHMza2JWVjc4VXZrdjlEUTVNVElzNHQ0VEQwR2lK?=
 =?utf-8?B?S09pRmdtQ3Jrbkk3N3VBSC82R1NrQmZBelFrN2duSGZCQzByMTAxTU9UYWtp?=
 =?utf-8?B?VERwNkhZRTJMUlBOS3FmcjhES2Y2Umc4RWxiQXJaVmZUV3JQc2UvTVZJbHc2?=
 =?utf-8?B?Y3NaUGxJcVl4SllYc3BCNzJHOW9zK2JQKzFaT0NXOU8wZXdOT3dzTDBRMXFJ?=
 =?utf-8?B?K20xNzJFNjhnTC9ROUhlTWRDY3g2UUNWcURaT2w4Z2hhZHlGV3RUcGhycldq?=
 =?utf-8?B?RzUxUzNOVFYxN2tZVXFvU2VMcExTS3p6UE90c21KalFwQURmOWFINHN6eDFs?=
 =?utf-8?B?WnljZEYrVXg4NC9qYjdYbkZ0Mm5aTjVNSTJ4ZmdYckFtM2RYZmVoMEJveVhR?=
 =?utf-8?B?cFY5aEsyMlFSanBQLzBKbS9UUDVVcElDWUkya05SeDdrMU1NTGNQWUZYWUJJ?=
 =?utf-8?B?T0Y3YUNrNnVsVkNTRndJVFdFSzN3QkVLNTJ1VkZQQkRHVkFvbkxhQzQ5R1dB?=
 =?utf-8?B?MHpGWHJUUXg0bjh6REpqUmlvQTV1MEdEajNQS090dnR3WklVbXZtTFFuM28z?=
 =?utf-8?B?Y0dTV0FzWTlvZ2k2SmMyeGU5MDRaaVlkMXEwS1V6N1FsbmlFSW13dmxmdVMw?=
 =?utf-8?B?UGNoYWM2UDVxOS9NRmNJY0ZHZEhKMzB0WUZ0NVJwZGgyN2wvSDFaZHhMbW1W?=
 =?utf-8?B?RlNiRFc0aW14V0U4RzQxVnVBTmNBYlJFc1ZKcE4yR3RNYnJ4c04xejlrV0VQ?=
 =?utf-8?B?eStsQlI4UHNIQ3JGOE9CK21HdGROYStaSUREeE5TclM0T3NIUC9UWDhTYnlF?=
 =?utf-8?B?cFVxdzV5NkdtRitRbmxxaFpJaGQwcGVwRFE5UDcyOVBNQUhTU2l0b3FMRVlV?=
 =?utf-8?B?QjhQaHFZSDRzamtnaUl3R1lvZzZ1eUxxNG1VeGh6VkJma2tzRDQ2QVJkcGpX?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: edbafba7-19a4-467f-1d72-08dd6b86ae03
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 10:20:34.7293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7mxv2s1w7W0zC9Vk0C9TDasIScgqu0jYcxMJsVXh26gqB3JNiE9UaSXZxgaixf1ZGBRwdbQlGtFHiIUNCqudEU+C0G3fH6uRS6tKlTreSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7311
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

On 3/20/25 4:26 AM, Simon Glass wrote:
> Hi Quentin,
> 
> On Wed, 19 Mar 2025 at 16:31, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon
>>
>> On 3/19/25 4:03 PM, Simon Glass wrote:
>>> Hi Quentin,
>>>
>>> On Wed, 19 Mar 2025 at 13:04, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>
>>>> Hi Simon,
>>>>
>>>> On 3/19/25 12:49 PM, Simon Glass wrote:
>>>>> Logging of function return-values is used very frequently in U-Boot now.
>>>>> Add a few helper macros to make it less verbose to use.
>>>>>
>>>>> It turns out that the log_ret() variants are not so useful, since it is
>>>>> not obviously where the error is coming from. So only the log_msg_ret()
>>>>> variants are worthy of these macros.
>>>>>
>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>> ---
>>>>>
>>>>>     include/log.h | 26 ++++++++++++++++++++++++++
>>>>>     1 file changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/include/log.h b/include/log.h
>>>>> index 4f6d6a2c2cf..bdda7af570c 100644
>>>>> --- a/include/log.h
>>>>> +++ b/include/log.h
>>>>> @@ -380,6 +380,32 @@ void __assert_fail(const char *assertion, const char *file, unsigned int line,
>>>>>     #define log_msg_retz(_msg, _ret) ((void)(_msg), _ret)
>>>>>     #endif
>>>>>
>>>>> +/*
>>>>> + * LOGR() - helper macro for calling a function and logging error returns
>>>>> + *
>>>>> + * Logs if the function returns a negative value
>>>>> + *
>>>>> + * Usage:   LOGR("abc", my_function(...));
>>>>> + */
>>>>> +#define LOGR(_msg, _expr)    do {            \
>>>>> +     int _ret = _expr;                       \
>>>>> +     if (_ret < 0)                           \
>>>>> +             return log_msg_ret(_msg, _ret); \
>>>>> +     } while (0)
>>>>> +
>>>>> +/*
>>>>> + * LOGZ() - helper macro for calling a function and logging error returns
>>>>> + *
>>>>> + * Logs if the function returns a non-zero value
>>>>> + *
>>>>> + * Usage:   LOGZ("abc", my_function(...));
>>>>> + */
>>>>> +#define LOGZ(_msg, _expr)    do {            \
>>>>> +     int _ret = _expr;                       \
>>>>> +     if (_ret)                               \
>>>>> +             return log_msg_retz(_msg, _ret);        \
>>>>> +     } while (0)
>>>>> +
>>>>
>>>> Mmmm not sure this forced return call is a good idea, this would forbid
>>>> us from performing some unwinding for example.
>>>
>>> Yes, it is really only for simple cases. Without the return, there
>>> isn't much value and you may as well not use this macro.
>>>
>>>>
>>>> I don't really see how that is better than simply calling
>>>>
>>>> return log_msg_retz("abc", my_function());
>>>
>>> That's not the intention. It actually replaces:
>>>
>>> ret = my_function();
>>> if (ret)
>>>       return_log_msg_ret("abc", ret);
>>>
>>> I use this a lot in my code. You can't always just return, since there
>>> may not be an error.
>>>
>>
>> I see, I read too fast again. Only return if it's an error.
>>
>>>>
>>>> ?
>>>>
>>>> If we were to keep this, I would recommend to rename the macro and fix
>>>> the docstring because it does not only log if the function returns a
>>>> non-zero value. It does actually return.
>>>>
>>>> So something like
>>>>
>>>> LOGZ_AND_RETURN(_msg, _expr)
>>>>
>>>> maybe?
>>>
>>> Sure, longer names are easier to learn, but then it is so long I doubt
>>> anyone would use it.
>>>
>>> Perhaps LOG_RET() and LOG_RETZ() ? But they might get confused with
>>> log_ret() and log_retz(), which I am actually thinking of deleting.
>>>
>>> I would like the shortest possible name to avoid spilling functions
>>> onto the next line all the time.
>>>
>>
>> It should be absolutely obvious from the macro name that this can in
>> fact return because missing to unwind code is among the things
>> developers typically easily miss already, so with this macro it'll be
>> even easier to forget about undoing things.
>>
> 
> Yes that's true. We don't have a huge amount of tests for this 'undo'
> code either. I would bet that a code-coverage map would show that.
> 

Yeah but that's not a reason to make it even harder to spot issues in 
the undo code :)

> Subce the macro only returns if there is an error,that could be
> important if we are trying to have a descriptive name. Perhaps the
> logging bit is less important.
> 
> How about ERR_RET() or RET_ON_ERR() ? The last one is getting long too.
> 

RET_ON_ERR() would be better.

It doesn't really convey that a log message will be output. I'm 
wondering if we should have a variadic macro?

RET_ON_ERR(expr) would return on error but say nothing
RET_ON_ERR(expr, msg) would return on error but say msg on error too, 
maybe even RET_ON_ERR(expr, msg, vars) with vars to pass to variadic 
log/printf.

I assume we could extend that in the future if we need it. I would have 
the expr first and the msg second though, I'm more interested in what 
will run that the message that may be returned.

I'm personally not convinced the macro, function and variable names need 
to be really short, I would rather have them longer than confusing, but 
that's entering very subjective territory :)

Cheers,
Quentin
