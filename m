Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EF7C79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 06:54:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF6EC605C9;
	Mon,  7 Sep 2026 06:54:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K0r1Z4kM3ou2; Mon,  7 Sep 2026 06:54:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B71E1605D8
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788764091;
	b=taMhmoZ9LAjP9LZEBVAmxaiE/Lkhhp6PJwdb2F1ery+46ccEnHJd44xiTCtfS5gtEAvl
	 FGW5TX+1S4PYUqyPURyQw5SWxtCbUb+5WMKB9LORui5HOm3hNLOLSgA9yGwGLLQQmaMLo
	 BFozyxvkFwo73NZmfgSQHhoYo8tZEl0095Eb8JqCiltsZ1yjD7NAFCFTqKMXDPZiN2HfA
	 ouIBHgtapbaJctycnyX27P0/Nl/BJbtBzYAFtUgImoa+OR9mE9Rowg5XxDoSzA3Chkhuv
	 8gEajB4vdDrO1skGGiBmrqWXDUAAUvMdAvep3lCMeymR965GcHfWuA8s6ielIuESBXQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788764091;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=ZYRjqFY1OqHVIj2FA7cAct4HIa6wNQb9TFZhu/6HOqg=;
	b=kfJiKnX4liNr4MQkDpD3hF6c7yFHbbn5qDPUx1zmxdimweObOFNfEN+eyD0OI2vbGy7c
	 bNpDNwtsrmoDm5PM2q8ndYtd4qF87lS+SInaWrZtDTs9pZoFLQxwDwfiu/YNsFD24ZJUb
	 7D9anfFTy2GfYCM9JQVoWWSnIGSv75fWBDBrGP+qUpX8wxRfyCHWbIdcXtaQ9waelxIzL
	 kpOZbuu0OEQabLJFHNCRetDV+rba36ilWhUBtEIRaszugzAATocno6pYZMQVmke4Dxz8M
	 4dCHe/LnGmRuE5FaBH0JA5XOY0ZW8EltFpqLE6z2V7MFGRpXk0fAZ5WRAeoYlfFywag==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788764091;
	bh=ZYRjqFY1OqHVIj2FA7cAct4HIa6wNQb9TFZhu/6HOqg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mWG2Wxh6DzDUvxqeUwBxxowE4SPwnZugFkDNQal/exIF/+n5O8qmNN2hr1vYZxlR/
	 5qVSXPQIZD6957mxG/7N0+Hmqp62K3ywyp65yncYlHuqWR7jxDviXdbUW0ATZL2Rq7
	 wTtxJFgExsk/Ts0f4F0qJhK4SHv5lMDy9rasLFescNs5Gv16YZDb97sHyROkoesKrF
	 +2CJRsrRS84aJKOQOha4NtM3/pXJifplKjrYdB4zn0k+h4OztVeApTSW2EQ3V3DThP
	 EfaSihlTAsPKk/gdoM53ESPmTE5Q9y42YiQGwRhDNi/atj8J5fST5TXL/BRApjy1Co
	 zjikCcnyAJBxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B71E1605D8;
	Mon,  7 Sep 2026 06:54:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E3BB2C7
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 06:54:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1BB4B400AC
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 06:54:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tKVtwbnyaJqB for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 06:54:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 072F740068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c000::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788764090;
 b=UTrH0+x7hbjgkuvtQdmRLi7QPdXLNAfS1qxqG925sdiJQYVh+TrOwss34PlvWiWA8bal
 ertdxwXvEz1IZlZ+Deu5ogtr0rw/iU1/W496xdBAPdJm9tfSz5GDYsJAhgOro3rWmc3KM
 Wdhd5n9Dbyx03puKz9qMM8a8vzPgt9c1ZwzaccEkF8+UGLtIcQ8a7cZN9wYSh59AjPPkn
 nr8rGk7ijK41CgInZu0IZXdNg9yoVvVgUX1TNcJPIsXGS+bsExi4P5+GqcXeZYrJqqd7Z
 yZayTYmoG5psa/E70io0+lpW791gwgw/j/P8PqCksnK/ukRx4TmMR/5eYH5EPJzotYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788764090;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=ZYRjqFY1OqHVIj2FA7cAct4HIa6wNQb9TFZhu/6HOqg=;
 b=iCCEZjfOwBY/r2vfdralydwwhnXXnfOrB+erm2+GD3xL/+ElpF9SNnuaYnIYyvtSJ6GP
 ol8bKe+H9g9+hSYwUY7TtbMM61myjeG5vMUTrrRfKLpaKz0sMpn+FOM0RIHhIpvJ9RZ4h
 2FXN7juVjxBsDQZH8emY/g5TeqHHVg2oqLG83PiRLUHxjj4/FcwMXXR2UL63VVFOGByBw
 pQV5DYdRPgK5SjWtGAXLSaQzFQr233VqLXGZVJp0diCLXLcWjVWxDlmnz5UqkcYJhjQOA
 6gbRTuin7QaUPOMZq/c1au46Ak0lkjGD4r6h0bRQBfth/VVH7EsrkWKd2k/r6duDOQg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=C7BlcbWs; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c000::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c000::1;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=C7BlcbWs
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 072F740068
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 06:54:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uR3f5zQSKCcNK0ngsILaPOO8aHvCG1LVi10ro0B1+k2T59k6OVZRW3GKopdDTjmHZoaauI/29xsFmhYAFTcJDzyZNIi7T0eQw6fLxbNVycSNGWYlHK+W9d5gzOz92s8ggo46cvageYgehWYFxiNOkar4Jydlqob6Dl1UoRzfG37RAeQzDrPhQYSCMLIohzEyKjWMkhpMvSLwlq6cMFkB0jBAwk+R9IJ/RxH61O+HQoKK3WA3HCQlmrcUArO2sv7qQBgXybQ+xzizgRNzrt4q/r0NUzTlgHVNh2BJAQIvYsL18QmWmlFCEvOF+BrTUAZfu5yLenIwCs3bPuoT3/7hEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYRjqFY1OqHVIj2FA7cAct4HIa6wNQb9TFZhu/6HOqg=;
 b=j3Q+tUmD22pHbochD0AZ8O7MRLu/PaZeLRVsz3R2Ymv4jgNvieJDMBGWaOx9cstOGEAk3ugg9aQC0axFkOY+RszHfidj5kPi30zfUY3vviv14NDzX9I2KBp3nzdBgxHRE83P2nJ3yZKAx8AFNcEfe6kS+8FQRhZg9ddX949MpFQ+MB5/SloeHKYun9sxn99EfHBK2/e0Me0vISSKLaF9nR1R4SBrbqBtX5TsEygOPVMG9TALM2ySlq4BjSvkXi0/WYy0jJ54gAxKmF/z+Y+is7OroNAMZzNtLU0mA1NOd0V2d4XxnvVrvLzLj6h3f2zjg7zml/iheF3ZfRvW+gAWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYRjqFY1OqHVIj2FA7cAct4HIa6wNQb9TFZhu/6HOqg=;
 b=C7BlcbWs7w57ebCPp9sAKAPhBN4jhBUF2TG8ZMSa9pBtrRl5096a7BIS39pVEKN5AYxW0R6WhRG65pPaV8yfsoNvwPhRdMU9NsfaO/cldz9inghr2p76EM9UP0qbLapQA6RxtmuTEcI5268Wt/mzXRqu/aI0BMsn2nHRXWOZCMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 06:54:42 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 06:54:42 +0000
Message-ID: <46a40061-f855-4bcf-b76a-9329699e5b65@amd.com>
Date: Mon, 7 Sep 2026 08:54:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: versal: Add amd_versal_premium_2 config fragment
To: Pranav Sanwal <pranav.sanwal@amd.com>, u-boot@lists.u-boot-project.org
Cc: git@amd.com, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <72ffdb382f929e9d07e6ebf4e697ea473567b136.1787558907.git.pranav.sanwal@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <72ffdb382f929e9d07e6ebf4e697ea473567b136.1787558907.git.pranav.sanwal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::21) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2a0992-f349-48ac-e983-08df0cace4d8
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: QVEbA8AMe6eqemyJlRzTRG/wkbTnBRvtP0+E9OAoeMjXIW6zZvXBYHEFsHA62Rknd88QF+DHdi76JJwklSdw+9A3G7JE5YdwUjgYNsTECaP3gkkeUiojgYfYBlPHffefSY0+/01mubCor1FMggOnoVjFC7WNUHfBmVa9ZTTv2e/Q/zEeoRwrIXbp2Kg8H/U2rr7/asqR73QJXlwx4xHhSUkV8hlu3PmGYLekzMAnT16s+FaOmi4MfYuhWRzV16dVaS8xoGqZMX+NF6+o/QFHX9oQihq3Mt6OnFgRdEnUPgPGdllvwbA+3vT0Oz1P+5Mr2APDzj18jla9nSkvLVKFIwxK9jNFRKTS0jK5bZmt2QaSTgy2dQLIxPrUOj70HtG02G3TF8StA11+Ciw9GatDsUwYTwPTCrfRCAOZbh2oGPXlTAXChdQW53x7ivHI6+QlRlsZTZ5n0NGsStG4vRAVTh31W3G6AmIXSSZHVhRXsg66ai+uJA5cMGiuHg+YrgfSaUamRaYTbGQqCprEICO1x/XonmF51QKE3pDXsRUCicRHziAFyfnRLGXKArhWXSpRxO0YRQZWuKsWh4g5XHnOLRCOx3u6g4qR/UDvgUUxmCCvOs8o2KZWDrfkGppgBSNM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVA3ZWl1UE5LY0JlWnRKVE5odHFiYUV0QWZGeTdPc1VkQ3NlUGhrMmxCQ3NC?=
 =?utf-8?B?RUF5cXpRaTZZdG1yMlR6Uy9DYWlSUTJlazZoN1hScENSNFpqVysveXI5Uld2?=
 =?utf-8?B?NU9tMFJjd0tjanlwWk01aHdOcG9PTGpCV0JzL3Z0OXR4U1ZWb2IxL3RhMmdC?=
 =?utf-8?B?WUJwWnk5VlA1aXdZY3JjZ2VzQ3lHU3QwclpIdFp1L212N3gxYzIyb2hQaExw?=
 =?utf-8?B?SUR0c05QaHdpdEZHdnJMc2RzT3ZxREFBTThxeDJnSXhMM3I4b3BvczZKbjEr?=
 =?utf-8?B?eE9vODRIRmNVcGZwaTdjU1BleGE0OWdMV1d4aCsvL0Fkek05L3M5bnEyRGNB?=
 =?utf-8?B?cUdnbUFBTnY2NWhYSU8vN21mUEZBZWdWSk9pb3pXTFBUR25kYTFGM2JvL0xs?=
 =?utf-8?B?RWF0dzh0TVErSG5uc1hXekFlUTFGUnNjV1Y3eWFmWnBuOFRuQ1NyMmRsNlIz?=
 =?utf-8?B?Y09XbS9tdC8zY3dsdUIyRHJzTVBVWEZrdjdaMnZzSkFnSmJXOFUyVVM5R1Jp?=
 =?utf-8?B?MUNGWHMyanhoRURXT1Y4aElCaVA4d2tYcUIraGhJUWZrYi9iV0tBbXl3QmVH?=
 =?utf-8?B?NXpJTXE1NEx3eTJiRE1wdU8yK05hc2FXVWw0T1lxTWN6K2tZZmsxSVpzRUFJ?=
 =?utf-8?B?b0xhejZwNG45eU5lVUZqRTRBcDVlNGx4dXNIZHZnT1k0YWNVU1Rxdk5UUngx?=
 =?utf-8?B?VVE1anBDYzl2QUJLdnRjUWtINHZZejhhT2RPbDc5S0hwendxUnRlSXZOa0ox?=
 =?utf-8?B?MXIxa2RWOUU2VlpMajRnMnBWZHNDTkRIZE1FZ1lIekVVZGQ4dUlTbmRYWWR0?=
 =?utf-8?B?TGpOYnZVSWlBTmg0QnE5TStoeXRLdXllNjUwOHBscUpnL1hvQjJHQlhITHN1?=
 =?utf-8?B?YmRERVBjZzhncndJcjFVemtDRXdQRWVaVWxuVER3MVhpVStlYjdQTW1vMDJn?=
 =?utf-8?B?UE5EUFhNbkRPemZKOWtWZURSbjVDME02TG53eGFWa1VuVlZNOTh6OUJzN05i?=
 =?utf-8?B?bkJWN2JvcDUwWlF5OU1ybG83QXBFN0tLYVpEMEl2S2hNYncvbldxYys4aHpM?=
 =?utf-8?B?eWFmZndjZVhKUWxPdWNQeVR1Wldtckswd0tTUDRySVI3ckZGenBBVFA3VW5N?=
 =?utf-8?B?UEdvVEtqN0wza2dZQksvd2lwOGlkQ1R1cVpsM3N2N3B3Q0s0NG9jUkhOZXlo?=
 =?utf-8?B?cW1Oakx4V0tVRXkyN2Vld1krdkNPTjYzNGJySTVEdjJnTHhJd240SlFkNnYy?=
 =?utf-8?B?ODZHZmwxN2U1OTltcWlBcEtYdmJ3MkpCM25uUmtsZkNTNnhtTDdVOFQrYm0r?=
 =?utf-8?B?RXFrT3dsWVBVSXdNeVh0dE16ZFJrZVViUlFBem95TzVjaExlaW9UL1AwRW9r?=
 =?utf-8?B?YlV6R1pLczFBaTU3cXA3UWdlM1BuRmR5UVFlWjVLZXFXU3ZsTkRjTGlDeFZw?=
 =?utf-8?B?eW5Fb1BNRTQ4R2RFN2t4ZW1uMzdoM1FMZnJOWlNaMWFES2lzUzdIRkFFVEhO?=
 =?utf-8?B?Z2t6ZXM1TnNTM0ZnSjREU0xkcFMzbmdvZk1SQmw5TUJaZlY5QjZPV0FHeHRt?=
 =?utf-8?B?TEcxNmY0WTl5UVZXd0ZkanphelhoL3BHbVFDa0ovYkdyaG42c3M4VE90c1F6?=
 =?utf-8?B?ekJ3QjdjUjdNd2RVUDl0Nm9STWdsWGR0ZW1rVEdpTmhGWHduVE92ekg3S2FD?=
 =?utf-8?B?aTlxeWxDcmk5dmFZZm4wK3R1bkhEMWl5NmJQY1Z2V0dITDdyRDhNVC9GRnFR?=
 =?utf-8?B?cjB0bHQxd2drb25ReDVmV3c2bGVlUUwrTlFZVzFYT0V5OGxMdlJIL2xxWm1P?=
 =?utf-8?B?Tk9uTGI3NUVVaEZFTGQ5RVZHVXRnLzJlbFBBbGM3akRtejJ1VjE2aFR5aDJl?=
 =?utf-8?B?eEw1dXphWFBRd09lbjhkUHQyVGsyTi95N1cram9aOE5oSGt2L3hZdDJKa2Yy?=
 =?utf-8?B?TTRCZzY4RUhhMWswOHpEYTYvUWlEMjFvUGNIVm9saUVpeVU1S1RnYU1mcjQ5?=
 =?utf-8?B?ZmQ3UksvdGVEZzBtNWJlVHZXZVFjYzlNYkZIRUo1UERLWXV6N2VhellieGNF?=
 =?utf-8?B?eGlpRnFjVXh1NTdQTWM3aEppUCtLVjM1bWdQNnRBb0M2R0YxVzNhVjN0NEc4?=
 =?utf-8?B?cjY1azBNb2VXc21zZ09CL0dBN3hjaG9Ca1BRNHhwQnZmRU53SUZXcGNmUHZx?=
 =?utf-8?B?MkNDanhtQmpjSlJ6MU4vWEEzcmhwRkxMdEw3bHk1Yi9HTnF6RWpGbGZNM2h3?=
 =?utf-8?B?MnFKRk5pOTZXSzNDL3pQb1FMeVlUSnJhNjlLSHdYYUEvclNUaU81L0pqa3Bj?=
 =?utf-8?B?WnBvNHhUazFoMHZWWTZYZmVvZktNMVUzM1dUWTluNUNqNGVKRXdrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2a0992-f349-48ac-e983-08df0cace4d8
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:54:42.4502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+mJp05O24FytjUOTptXDT9qOSXr8+ekASzCBG7KtMsvxWCzgG7QeUQO632AVzpx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339
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



On 8/24/26 10:14, Pranav Sanwal wrote:
> Introduce a Kconfig fragment for the AMD Versal Premium Gen 2 platform.
> Premium Gen 2 uses a different memory map than the base Versal virt
> config: CONFIG_TEXT_BASE is 0x40000000 instead of 0x8000000, and the
> incoming device tree is placed at 0x1000000 via
> CONFIG_XILINX_OF_BOARD_DTB_ADDR instead of the ARCH_VERSAL default of
> 0x1000.
> 
> Build with:
> 
>    make xilinx_versal_virt_defconfig amd_versal_premium_2.config
> 
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
> ---
>   board/xilinx/versal/MAINTAINERS     | 1 +
>   configs/amd_versal_premium_2.config | 3 +++
>   2 files changed, 4 insertions(+)
>   create mode 100644 configs/amd_versal_premium_2.config
> 
> diff --git a/board/xilinx/versal/MAINTAINERS b/board/xilinx/versal/MAINTAINERS
> index 07173ee916f..9113249de8d 100644
> --- a/board/xilinx/versal/MAINTAINERS
> +++ b/board/xilinx/versal/MAINTAINERS
> @@ -5,4 +5,5 @@ T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
>   F:	arch/arm/dts/versal*
>   F:	board/xilinx/versal/
>   F:	include/configs/xilinx_versal*
> +F:	configs/amd_versal_premium_2*
>   F:	configs/xilinx_versal*
> diff --git a/configs/amd_versal_premium_2.config b/configs/amd_versal_premium_2.config
> new file mode 100644
> index 00000000000..26c5cfa536c
> --- /dev/null
> +++ b/configs/amd_versal_premium_2.config
> @@ -0,0 +1,3 @@
> +CONFIG_SYS_PROMPT="versalpremium2> "
> +CONFIG_TEXT_BASE=0x40000000
> +CONFIG_XILINX_OF_BOARD_DTB_ADDR=0x1000000

Applied.
M
