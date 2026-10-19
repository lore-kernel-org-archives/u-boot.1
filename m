Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9B9CCF2E3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D3184070F;
	Mon, 19 Oct 2026 10:29:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bFxGo_PFTudx; Mon, 19 Oct 2026 10:29:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 42BB4406AC
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792405765;
	b=Ro7a1OdE4hPplH/oVR8KrDZtwDKo7++yfO/rSI4kDCLwd/VS65BtIIT/DYcw3PQnAsQ1
	 ZTC1oSow2F7nMd5xTf2uc2cgIaMN0ioAb3vYL9L2QXCIBLCpnNZoXIh8Z3Gw8ot9wIDoK
	 qbLl+WqZ7dZlIVtER2ecAjg7DSvF/v2K+/wAknRb+F58bbtXVwEBeowWqkP1BfPrX7ebA
	 6bryYPRoNa3W+GwqOsKvCPcxTSWBCNlIeuY+mCLrVaUr53AQjAf+32oKmoM8H3RkCUAPJ
	 D6+AU+0B4MKx9XTKut6hUTR7Ot7noRaXOYo+XW1msH8Z3xb1/UA4Wwe7Osd0jE//bEw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792405765;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HuD5b8qkoErAS4sMALl4wCqZ0VC5kyucnDkliZEGGkg=;
	b=hOUHnpYy+h9nmy5JJ22n4DPDrM/gcl0LrZvpuai2zmy9Ng+Haju616xzvrWrK5qFY8MY
	 wdZMZ1naqyKds/oXT1XmHa+unvgSZyTbfIqpS4V0dl2+BoRlXqqmMyzTlf8v6dYPNBUp1
	 X0D+GFGkkfzn2BQHOlfgdNkKDRCAByOIa2NAJ5WCF/AgtruiB5g5UhaWpwvD2YOARHMI6
	 3jS4bQQ+b73WHIliSja3ipH33bvWHGftMJ7ciGti13up1z6+HyZWVzmEzdul3GbLFybSG
	 7ejAUqOwVAPH8rdtlk/rufSJum12z9RZumlbRbBB4gnib3xB6s7+ADfY6Y04nEMkPaA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792405765;
	bh=HuD5b8qkoErAS4sMALl4wCqZ0VC5kyucnDkliZEGGkg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GBD7MRKRyxtu644VSsOpXD2EwusnRVe5tPH/oHDncKkkXyXOfKfJjf7vWFvrkVNiV
	 DUwt8UEhZVQSlntlnb78vO73JYNplmhafFzGcHwRuPXIjYKw8pr+4NyQD6j35DOsVi
	 b0FhH5lCVV3ywpVOoNboNaaeroSmzKgX/RO8zlHiL/dD86Hp6qYDZdEEOqnJYFHfSG
	 0IoKIdAK0JQK5ILNNnJe55LPLxyNnmxtGTWW5K4+G6hzqGUjyBPcymGwLp/BKFNiD0
	 t+fg6nL0UyoIP5tD1mx5xnnreRy5CPYmNatzhctnDCB/nmnehncMOCeF3XwrDfHVLz
	 kChJNQy+pS1wQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42BB4406AC;
	Mon, 19 Oct 2026 10:29:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DE3C02A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:29:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D013760756
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:29:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aT_oWNRXX4_y for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:29:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 09DFB60722
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405763;
 b=W42htsx8xS26Y3Zcr1Wzklw+ZUZyAk7ixXxRVwDvu7pGsODuwyIMxek3KWrQgUsRJRhO
 ZzttrEnu3HIoFcImMTjZYGs53nPlteRCFN5fgCbqRdcvzNDnAVBldY+G1a/OF6uD3gPK/
 0igSxYyDzSN3oc7wHI/JYyAaLM+VjcDpYKZM1fW4oFiABW0hHa4iXWYzMW9jb02kNNvXc
 9JL5pLrpLsAnmNUnec78bVMH2iRkToxaeiyK1dHtT6ueerbO/af2p/qRMHk+VdC1eXFSz
 9cC505cEUlBjm5rUGwgcM6/RCQMuvt7WYDk+vXEMb6ClhT0l1pSi2lCXuavorWqfsIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792405763;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=HuD5b8qkoErAS4sMALl4wCqZ0VC5kyucnDkliZEGGkg=;
 b=tX1fjlAxdZXPp/J7l8u6lTOnIF2vic10P7TWMxtm7Lk9WrYgacWpbMMvPmi4v1RmVFx+
 4aQGJROZQRUSOERfh6CC/b0il5usYYj0aCid8HmKpytnzmelQ9Z49GBsHmWRIH9QjMTBZ
 yqYmeognNyl0J17MIdBTjkKe37GJQuPM38C8tJy31c1HTJscSwM303rNKpnMbNm7l0SUr
 Y1VKQgz/QNRXKJdWaZ/SEDv/TZNfiVXwEvNFwMPvy4WFHR98iSO/sDXncc6mJpW0HZ1TC
 Q57jf3eN8XDb6hlKO+0LdsN+Ff7aZcWAB/h/hE+tXFT/nBkGGPNAiGjmvmGw0DfOEew==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=none header.from=kontron.de;
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=vb3xAEUq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=vb3xAEUq
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 09DFB60722
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:29:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IowWkm7TyEx9KIa+UF8q6HJcruJDpZNxq+uuL4MOfkD62Nb7w28bDddr1dsdMm05iOVe1JAKX3nKrOlcmad/U+i7jXOQefCS1XRRREHYaWtSjUi1NoeAiznU8kc3k64ExbxzDnGRj4L7CDZkbL18wR+lua8cd6YiJZ0zQRLECevQe6/YRm5YknLC8ldBRkco+a+7uXKH7i7p3zpg5du1qM+A1Jc2Jw8jQog55VL11XgV9+iY8EB7KuP1wyZTvYgrTYzHF0wQUrK9woZxXvFlqDfYK48WIu7q0XRr+WPHSrytiwUzM8L4dgwuig/31vA4BYgmRa4Jehdow4WCivKRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuD5b8qkoErAS4sMALl4wCqZ0VC5kyucnDkliZEGGkg=;
 b=QeupGeSyVQSdyEyjGKea2wUjBY9bSB81RHD04cRcNarG3MGJrOn9tvet/3YZZxUClnWAG2soTa7PFN+ORuuKO/WyMat5ZDZEJF2jwXpM1cRhw2J493MZ8L7hTTguYYUoGVwWCo77q7VLUAEWd4IZ4H4P8uQGO04S8wzzhaPVDIOLowHGoymrgzIHuF52DKtAckAJY2FBfR7g8l7MQPE30HTEKLFd7MKxoZeyF5Vvp+SbTF3obEo0gG2taGOYy7SgeABhKA45lDSO1LvffHtJD6srXN7y6oEQL+iMoxIWVwxAsNcsjoK9vXc+XM8aVjByhYv0Ul2S/bi7f7PFReKFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuD5b8qkoErAS4sMALl4wCqZ0VC5kyucnDkliZEGGkg=;
 b=vb3xAEUq/6ZzaH2/DgJ810Mkv+sRQsxaEaTjgYOSUWoNVDuw0Tst0dOmQ68TH6KgeTVjPdwOvXf1ktQc+c12TOQfpJaR7lQcgUIFablcSDAEFXPriprn3bnF/3FoSqZsWjFhYp7ef6EmEvLMeUblWtIMbsWlQsSJLE9KOZks4HUU/ZRDH87mbNq3TN6N0adL/1utTTmEemJ1RgCz1GltjIPTTyZdv4+OWvDolG/zYYIaaeeqxF5bqkADDGSLDkMwWMkQYtD5KL9RxONtGsRCRsCp+NvgUm1HSuz8xHnINapsI46L+hc9MoI6lc9T8mvfuJuqjBvY6tLPZSwL3dV+iA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by GVSPR10MB027244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:719::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:29:14 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 10:29:13 +0000
Message-ID: <1796afa9-2aa1-4def-a95d-d2ead1c446fc@kontron.de>
Date: Mon, 19 Oct 2026 12:29:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ddr: imx: Fix repeating ddr_init() on i.MX8MM/MN/MP
To: Fabio Estevam <festevam@gmail.com>, Frieder Schrempf <frieder@fris.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20261015-feature-main-imx8m-ddr-reinit-v1-0-994706166ada@kontron.de>
 <CAOMZO5AsT=xrbuKWDf=kA2WPiBKtE5wc9rMpPfz5ib49N16Ebw@mail.gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAOMZO5AsT=xrbuKWDf=kA2WPiBKtE5wc9rMpPfz5ib49N16Ebw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::10) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|GVSPR10MB027244:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ba2da4-7ae5-4684-f012-08df2dcbd1f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|18002099003|10067099003|22082099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: vawClL8fEnX3EpntRyhbXaSA8hozgGkuI0ULkUonHmbb8IRjmTXprTd2bFtSWXy9uw3LxjWesF4zyOQbhw9mF62YL4f88VfnvevfcCm4zy5FunhxMmsdI8jW8ljJG+qZCf05Ny9QGBGMwXnquPCyZh5YFmBCcJljdV6m8Ys52ifLcNgyOVRqCC6JgJSTDB/AtVlCNbFaQJ3GW1NkaziMCUFGTHVycWIjJmmpuU4tBC9IRDv1U+EH0iTFUC3T3P9w+iLcWd57vrkOV4UW6fn8kbOCt+7W5hPnzsqeTjCYHpge1xY1gx1jjWgdbJfnMy6mu+rxfHYsbTyNiWtsju08/nNDAlqN/NPn913/8/BQV2AXAAbvJ2BnDuKg0NMDzHjpkU0fUP/dA/fpri92Es9UJVq5fRwNUuKOHiyo3xvHtd0IWdkHyDGgRHr51oXKaeGrar6PZlvpuRYEyt3S1/Q2FNUu5OMYTvvoYR8IRzUtQZ8XUSga6IW6mVnC1K9Bh0HiWvuv5BbiCaqB/3vLPYm1VSD9VHw+z0SimMfEV6Y8ho2G7sMdPLmkzMD94mG/9x4Yb/je6QN+UOt8sD3CSt5XH3GzGpFWtDiv9pFAygwp+egIx1vCthe/HP3nkbnyfSBAhiWuehfi1sBeVbb4NwjqQuCeffAuyRgMH0zPgz73IEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(10067099003)(22082099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWx2UlZWV3lCL01pTmxOOWNTUXF5RG9lWVhCcnVibUFyZXJDVEJQZXV0dGhI?=
 =?utf-8?B?UGVXZFphd21rQk1xcnFPa0lESUNyaXRaaXp6RmlmWjk1RjZqbE1HbWNocFZR?=
 =?utf-8?B?OERlVXdqRFdtUnlsNjNDRjk5U0VJS0s0UW9HODV3akxlaWNPYlFXUm83UEpX?=
 =?utf-8?B?T2dnV2ZXYUVFNE45djNLTDFpNVRNckVrTmFxY1hHdWgzSFBtN0JiY1RQb2k2?=
 =?utf-8?B?QXFwYkFGSHg4ZTRrUjNRK1ZWR0NqSkhxMjBBNUN0VlN5enRtR1dXWFREU2J2?=
 =?utf-8?B?NWZUTzlXUUdXZWQ1bkxkblNoa3VvSGh5RmhveDFUR3h6VEtUZzJ2MXpFQW5w?=
 =?utf-8?B?YVg4VldzWEpsT0p1bXVQRHdkUEFjSXZZOWRid3FQNDdmcnR3bjdTZm5zaWlV?=
 =?utf-8?B?Sk9QWGVCZ2tuRWcxdEYrN0VTSk5qSnIvdG5Sd056SW8ybW80SjEwdWdXbnR3?=
 =?utf-8?B?MXc2dmM0WTlKMGNGemVFOENxQW1zeEh0dEYzTU05K0hhbUFrTUtoaXA5MEpI?=
 =?utf-8?B?SXZOdEZSb1I3UENZQXFjVjFLbkYydWJlcFlSWGVENXN1dmVJMkZKQUIwUkYx?=
 =?utf-8?B?S094WEhuQ1NaMUtqTHVJaXJsK01DVFU5TWZUOEhuK1Q5aE12VlFDVGgwZ3JX?=
 =?utf-8?B?MDNydENNOGhOVjgvQnNEbGNxcjF3U01GY0RoYlFzS2lkSThCWjdEVFhOMWZz?=
 =?utf-8?B?SHNRc0grSmdNWTZVMndRNVQ5U1Y0MDdqd3pJUnJ2MGYwTERrcW9RS0s4cWU2?=
 =?utf-8?B?MVpnWHE3bWhDR01uTHVNcXkxTEJkVzZRZThnTTBwWXFJYklMUnpVS1JqK2Rn?=
 =?utf-8?B?QXpweWVmOXNOdUpVSDFuRmZiWlREOTRIc2NURjk0VzlKLzdNNjNONXkvWmoz?=
 =?utf-8?B?bGpMcGhta1BpUS9MMDYzZWkvbkE4UElNTFlSajlpODExV2ZWQ0o2TmtNc04r?=
 =?utf-8?B?T0wwZjhtbVUvMkltRU9vZmN3ZGhySWdlUEVvak8zUTJqM1RqaUEyVXg1NEcw?=
 =?utf-8?B?UGIwc082eGFscWUzZzZCU1NteHBad2t2STJkOGhuQTdJamI0Sitmc1RacGxa?=
 =?utf-8?B?eXdocEprMURHVG1IV2dhdGtacFk0TXhDZGk4MzVzQ3hlN1hDK0NKbUU2Vksw?=
 =?utf-8?B?ZmNONlhVcGxmQ3RzdTFvWCtmMWNidDV1dllzM2x0R01LTjJ5NFo5alIyZ3FP?=
 =?utf-8?B?SVB2UGNQeVBlWU5yUkI4elJtVllMS0NhN1IvVFJoUUxoalJobHFTSmZaSXNL?=
 =?utf-8?B?eHBaT0E2VVBTWmdtd1M3Y0VCL2xsa0Jqd3ZGWFhhRFRTZGN6NzFqeHhoNnd3?=
 =?utf-8?B?dlo4MWJrbUZodXBFSHVLN2hYZnFuTk9aRWgzVG4rOWY5OHd2aWEzWDdXT0p1?=
 =?utf-8?B?R1lKVis1ZjFGRnJlRkNCbkJHd2tyN2Ereko2KzRUVjA1ajdDdnY3ZlNITzRR?=
 =?utf-8?B?SnY1LzJ6VnVvY1ZURXRqQlhPa1NEZk5VU3pYekFPUHB0Q1MzUSswenJMd1Uw?=
 =?utf-8?B?VnE3Z1JLemFyU2JUNE5QTlZYWnFJZ25PYkwrTEkvQVhMVEdpY2d3My85ZHlV?=
 =?utf-8?B?VSsyd1IvMWg4QlJmdTJhMzF3VHR3TXpESUxSaVFLaWRyV2gvZGc4RXdkZURq?=
 =?utf-8?B?enhKYkx0d1BwbWRmNXQxNVdZU05FVnNIbml5OS8rREdrdW9BbDRSMW54TFY1?=
 =?utf-8?B?bTZyM3RkZGdLY3hLOGo5S3FIZXJheFNuMEE0MEttNCs2OGtkZkFJaWdIbzhX?=
 =?utf-8?B?VTQzQ2JRNXFiRndKMFRObStQR0g4SWVLOFovUlYwQ0NDY1NUYnZjWkRjamxo?=
 =?utf-8?B?N0V1MklYamlNYnpqdnVYS3YrRjdDMFNCaUt6N25wSC9zZXJzS2JQM2h3ZnNJ?=
 =?utf-8?B?UnZ4YWE1TWhJNmtEa1cxTGxpQzNaSHRwTzh0MVdvUDRjdllxSUZzM1NOTXFx?=
 =?utf-8?B?UmMzL2YyYjZQczg1c3JSUTh2UnV6RGN2R2lna0dMUXRGQi9uTkpuekFscWZC?=
 =?utf-8?B?ZW9hdXc3ZlJPaU50alJiVzM4cndUVmtWbDI4dTVFK0JUZWQ0N0NCUU5Oazd3?=
 =?utf-8?B?Qnlxa2FpRitCNnRORGc0NFlkSGxzUGloYmFVd1lpZ2ZKQ21uaWpVYmdheHZt?=
 =?utf-8?B?azZyU1dacGFaTnE4T0lCa3dZc0FFOHFIeVRSL1BuZE0zYm1WMzF2ekIrZkJj?=
 =?utf-8?B?c3JwSUcvQ0o1MlBJUGFWM0Npa3AxdGpSeE9IMnJLWDY1UERUNC8vaWt4a1I3?=
 =?utf-8?B?VXZHZmZOUm5MZ3BvOG1VT0kydzQ5Z1cxVEF2alI4RXVHaVFBeDJQUDhZV2Nu?=
 =?utf-8?B?aFB4TW5maVRDYkxqSmVza2NxeEk0c3ErbW0rZEEwVWtxc2FTeWJYQnRaOURz?=
 =?utf-8?Q?VLg0NXMr3INxgLZM=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ba2da4-7ae5-4684-f012-08df2dcbd1f4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:29:13.6447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpEFdjJfIonaXZL8dyCcz71/oMqmJ7xaTzBgC+YS0RjPJmDEhUiT/mdQ5dG8NWridb1HbvGgvhvLF6IbhOCRGCQhKO++hVEQ4cDQPci6sGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVSPR10MB027244
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

Hi Fabio,

On 16.10.26 16:47, Fabio Estevam wrote:
> On Thu, Oct 15, 2026 at 11:25 AM Frieder Schrempf <frieder@fris.de> wrote:
> 
>> Also tested on a Kontron SL i.MX8MM with 1GB LPDDR4 to make sure the DDR
>> probing there keeps working.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>> Frieder Schrempf (3):
>>       ddr: imx: Use the correct GPC registers for the i.MX8MP DDRMIX
>>       ddr: imx: Recreate the power-on state before repeating ddr_init()
>>       imx: kontron-osm-s-mx8mp: Remove DDR reinit workaround
> 
> This series does not pass CI. All imx8mq targets fail.
> 
> Try building imx8mq_evk_defconfig, for example:
> 
> drivers/ddr/imx/imx8m/ddr_init.c: In function ‘ddrmix_reset’:
> drivers/ddr/imx/imx8m/ddr_init.c:424:22: error: ‘CCGR_DDR1’ undeclared
> (first use in this function); did you mean ‘CCGR_HDMI’?
>   424 |         clock_enable(CCGR_DDR1, false);
>       |                      ^~~~~~~~~
>       |                      CCGR_HDMI
> drivers/ddr/imx/imx8m/ddr_init.c:424:22: note: each undeclared
> identifier is reported only once for each function it appears in
>   CC      spl/drivers/crypto/fsl/jobdesc.o
>   CC      spl/drivers/core/ofnode.o
>   CC      spl/lib/crc32.o

Sorry, I should have done a build test on i.MX8MQ. I fixed in v2 now.

Thanks
Frieder
