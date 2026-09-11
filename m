Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6229EC88E4C
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04EE1402A2;
	Fri, 11 Sep 2026 10:34:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qcju7YZz8dHg; Fri, 11 Sep 2026 10:34:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CF6AC40302
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789122878;
	b=aRKnEvNd8XRlGellpdpsbhpGx0DBlyeiHeok0l9SNBQcWmYtX+pSGNRaV79fkT/S6xDt
	 3FZ8gFNOtsfmOD+0+2XihP0eiinxZFIj/+gQxDILZjuVsba1nJ8Fha3JJe9FxTdniRRU1
	 Ax1XakqAFUitNCl3Be/8QFSJd4Btf6Mdk7jkeqClcZjJS70MntJvbffE2c5K4AMuxp2Zw
	 MXSHLazQKXmNXYxt8M8D2jVHcxoLJ7pdGO5xLH0AFZOyFQeoLAez10J9ZFx4tU5QlR/Xt
	 2RPbQCxliPLMo4paxvGRkaCCS5RFQ+RoAqawmvj+t1J0ImOOlaErlfu31+TIDFxr4iA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789122878;
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
	bh=jhNa2k2GCMdJ/2K0U+l1Cq86fgljwX3KZDrGtktNAu4=;
	b=oj9b2Leovfeo5rarsIbFQTUoF9/LJdUg1XlFNpmIx8Fe1xxFt9QSQaSTqloWj1TSt7Ay
	 ZJ9Z8NSx8u+2iNjBeHDd3OXgHqCzStA67iihvKRCVfq+XapEVi3AMTCiToUoQWKfgd/FT
	 VL8T/LGs8APSNYklan2MtZX2xjlT+5NBVVXKaBBPoE+XoO6qkMZldHrLyL0Yr7EcP+8+i
	 JDv6B2LQnEsD6B87WkIoI/OQNXptkIAvkGavMRC55fzVtUDG8a5dBbNlrueMP3Tl0f7qY
	 im2w6f0FgYyVBucYRpx0s210n8066VFfGw3MnHKunPKcVHZif/BvDxGXrzkqZVD5UPw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QsbPXdPf;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789122877;
	bh=jhNa2k2GCMdJ/2K0U+l1Cq86fgljwX3KZDrGtktNAu4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FHeMNNFlkM9NPaVeABGEdlKuAgyMiyBNty+l2ElTmtVv79PmsEvEfVa14sHqoNQuW
	 ptvhT9XkdJLHL4DzQT23dCvjUQXyyWdNPEem1V0WVNdxrYjO4rASvqfqrNaMPChv2c
	 rwnsIxjJvSwJPjZUAsILET+HWirAU1t6qTBRg8mSN3h1VhB8tEA0YlsjkrDuHUrOAM
	 x7SwKZy7EoA4TxpIw706K2aB4Bz5uyQwd7TR8AHrrme43B/tm0Gq80i88J1qJEXbV/
	 ITM9bca6f2AHrmbe7Dylg0FLMKBOrhAa0pFhfxsFT6bvzXXoSmzBrFYArAECvLyz3n
	 Xoi1FkWO8oPFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF6AC40302;
	Fri, 11 Sep 2026 10:34:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 254FA32F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 16EA940322
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:34:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KO0McVfnn0U1 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:34:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 64194402A2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c007::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789122874;
 b=E8Lc/NIMCxE3n42ovLgp7D1ahIHLgM3NEZcsTvGD8oB2BQGJKWwIZVcqPx6bqVNva2xT
 Qv85VajbzTys3IknNjTfym9mgm07iIh633ZFob8RNjyCDZc9gaDZmLUt/QRJFEQ8N8Luq
 GCExNzbr4tYmVbqQfdQyIEtzCpglDMiTWVn1dJMT7DE+0PzIxI1USpXmO0mbq52/JsCPm
 7u2i8/vdEVsotImkoe1rUiroRaGta5RG6m0eGxb9z3qToNvaY3vcMfBq04FSz6e0om70K
 HT5ZGiUXlbqL50xks4V9Ok5xkOuVaT86vUo2e1t48oSs27z1go2EMZ/Y7jqZ0VKrkMg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789122874;
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
 bh=jhNa2k2GCMdJ/2K0U+l1Cq86fgljwX3KZDrGtktNAu4=;
 b=U53ShTW3oqZa/OXRTcA9CrQlg4zcnpFMDRlTYifoOTHq2NzXoINH0GxcHh5NzMUTU2Y3
 1YSDjAx73tJK0q0tYCaXGUP6rgVb1jvXQ0ASAyhjEYPQutDQQMieKNFf8WSPgIrtUDJTT
 4Je/nN/pPti9uUo6GgUQfxiLpJ7KYiLV2/ql0SFSRv79Cl26bENzlvHgGDVXVBZZYmGEm
 mcGORH39kTomz8UC7cARjMYwvDWjFOKmcncFSq+uXD5PGf5bvOgmipp638bDEWqGVoJ6i
 C8GQtyvhIcxUZLMi5h3Vkq5AmXd+bZnNDthvoaExy3at2CCD9CELmEwgzJv3dWgAogA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=QsbPXdPf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c007::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=love.kumar@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=QsbPXdPf
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 64194402A2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoh4UUqtD3gQl+TfKv5abwkibBK5/gNWEIj8GBWcqDQeXpJ3sjaUl+Tx7IEQSZqAM/mLc/WC4Li5mdp9XOaWa6QjJboEJ97YOnjRf8kmDEpW/zpEK93bGvVlLtbmv2Ua0bZ9aJskGkt41UwgyxwzlGogp0vZsmvV1QHVNma8ru54hW8kUVWEHDXzTfCbhCrJdz4MGzffUDZGnjeX+pbBMwVcbgIZjpx0ajFsfNBP7oAswHip2E/vC1J3c6QU3tU/OUIig3uz6/QFHmCtMm6828AmhVCXYcXPAf9Agp5fFN0w4cw4XJv89YMZ+Afc7BDon1T8fkBr21BDqunokgEDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhNa2k2GCMdJ/2K0U+l1Cq86fgljwX3KZDrGtktNAu4=;
 b=yemjxSZJn5ojztHFAhdk8In0C6/1Vrl1lmwpczLZtTIoja2foL/qtDXXW1HpfJtPgYWARq0hYrRUgzNoP2XdpV+Ik7Ekcnga7AEMKCWfRgLcRc8jaWbr47jUnfVpOPWq2Kw6nlJZ0HjnPx6TmFo7IarGtHhDpliLcXwzRlSe7zly4EBpLQ+HkT9L6shBEbZfkBBaOuRf2J9Av5LAvDocTnqzD/F22I/+cqWDXI4cPTdSMYpOEmWvtqtCMC097Oe5+r9IZjgG2fS9kosYlQMkZaSxHhc0La0vZelY5V1ecMSP4n4kofkDA1hoQ9ePKfX0FRB5yKqZQsLPy574pkZSjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhNa2k2GCMdJ/2K0U+l1Cq86fgljwX3KZDrGtktNAu4=;
 b=QsbPXdPfd80Hzuv+JmO+zmTLbTNMWl7/fcgZLy3GhV7oZSga7ySmYk+m7ixG0OC8879punk+AOePfXuJAcIrIiOjLcdJk5KuhOwjb1i7IQPKMaUf0LREhVaUI1jLnAV5WV3w9LL3MROL2PAA3SN+sfNHfocTIXynCZxv7QFfz2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 10:34:26 +0000
Received: from BN9PR12MB5367.namprd12.prod.outlook.com
 ([fe80::68ac:2185:bb07:ae24]) by BN9PR12MB5367.namprd12.prod.outlook.com
 ([fe80::68ac:2185:bb07:ae24%3]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 10:34:26 +0000
Message-ID: <140c9bb9-756a-4000-acd8-a1893cb98801@amd.com>
Date: Fri, 11 Sep 2026 16:03:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/24] usb: dwc3: part 2, make the resynced code work
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org, 
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org
References: <20260824154133.217744-1-anders.roxell@linaro.org>
Content-Language: en-US
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20260824154133.217744-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::22) To BN9PR12MB5367.namprd12.prod.outlook.com
 (2603:10b6:408:104::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5367:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d71f7e-5dc7-4444-056f-08df0ff040a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|6133799003|11063799006|3023799007|10067099003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QjFV4VV6VH+HJk3TS70Y97ot0DXwlKUkTYD09lYyP+VLt/oe6wEMQdq5esRnaU2JhgG1f7WMrk2VCls69qY8/s+s2HsrrX7G6+yIsOiCjvHkZU+2Lpc76Zo8jXaXmF6ACtl+u124zAGwQK52kVjY0NlmxlTXPMi4Ol5h6fl/L1H7HX3oVpd3+OZaFJP2PwsEXCoEPaL5VIdfwsHdDpsCcQk1CoNl0lGwfOMR1CsNA5XXcMofxS2M9dbOGHqvgodRJg+HtuShsXdpgLcOT6gecSUe12kUM4Cuanb0HfBzA0eS4+MZemeuqnzhPl0nTI70Ml8xn8dUOM6NDYpq3ssKYjw+6radRj6DkFQXsChbK0HM21yfHJL/63IaWJxd8IrhpiT4DvPngX6U1EEpWsqGM53Baz+AgC+PaJYh42JHll5qAb0ZuOrIvBHRQZwWzufb8eI04XeQ0iRbeef+TN18VF1KWbOOHLf1BFb1XVPCodPLVWr6AuL7pORqUmLllp3nf3UANifIILHqi3e5761j2tJUV5vPLzheuYGynB8Ces1jD3MqArZOvxa3ln47RlynK93tj+Km9TyOQsUs8xcbGkfXBQRQfcLeUU877RJunmqm57Tn2GK7XAXTjq/o+trWqjU/NLO7It0FimP3BEScg/7vp1Jmke+smaRBOtNH52s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5367.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(6133799003)(11063799006)(3023799007)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekNsZGlyT2pBd2dqcHVnSDl5ODFVRmNpandPeENMSjV3SGhzbTJDSGZxVUdI?=
 =?utf-8?B?YUdaT2RYdU5MUlBMNVQ4clU3dDk2SDRsSFo1NEFkRkE0SGhGMk01bFU3dzNR?=
 =?utf-8?B?QmNUbnVDSldkZUVEdHNsY2NSYWI2K2FFaWJOREtnaTM3SzlPWjVMZTBMMXVK?=
 =?utf-8?B?bldjZEtJSFhlMDFVdXdnbm5LYmFOZ1FqelFwblhzamkvaXdhVU5WbWJYVkti?=
 =?utf-8?B?RnF5RWFWbExFbkU1aXQzQjdYMUFyQU1OajJkRjBIU3F2enhCek9zUW1wb0lH?=
 =?utf-8?B?VE9pQ3VnZnZUVzJsSGQvSDZEOEVvS2kwOHU1WnQ1dVg5RnQ5eTdURTJBUXo5?=
 =?utf-8?B?RGtZNTYwem40Z0JzVWN3TUpOVkNWRGlOUVpMa2R2TmNNS3QvdlBKSFJvaHo0?=
 =?utf-8?B?VCtZSTVRSStMUlM0MDZiSHR4VXQ0NWZnNzk5SGwrRTJ4VDltdmNhMFpyWm0z?=
 =?utf-8?B?OHRVb1NRTmt4THFXZlN3OXI4TnlwY2h2anY5WnFVNXBwMkl3a1M0M0ZpM0cr?=
 =?utf-8?B?R3FBV1M5WW5ERzY0eEtGeVhrYnZleXNvVWFOWVRCRFpDUlg0cU1jaGFORjhS?=
 =?utf-8?B?R0Qxa3VycjVMMzBtZElyNFBuMGEySnZpdFJzQjREdUhlbTNtOVVLbEVHTHZp?=
 =?utf-8?B?VHVBam50UzFsL1NwK0hSQmNMajYreUlkWnM0aVBRanVzSy9ISC9lQTlqRnM2?=
 =?utf-8?B?U0RZSlg5OWhCVjJZb2ZkNmV3Vk1veHlISU9WQkdKS2h4L1hkdnoySUtuSS9w?=
 =?utf-8?B?QUplR3FRTElRcThobXlyekhPNTJ3bDdnT0tLc0lINE9PZStIU2V2eFVQcGcx?=
 =?utf-8?B?VENFY3lYVGtLanBTZUduYTVNenZ6eGYyMGhWQkpua3diMkZDTFhBd3I2ZStG?=
 =?utf-8?B?UmJUbFNEVFMzaVpuRWUzRWZYQWtYL1F0NmY0UHhjWFFFZkJzWjhqQXRMcmxn?=
 =?utf-8?B?Q1MwNDZnYTNWUkJXcXUydEQ3d3hZU2ljOGtKTDJHY2JYV3dFd0V5NnIxeU44?=
 =?utf-8?B?cU4zeGFXaTJENFZNb1AyZmpGa3dwWmdHZlVaR0dmdFlNSFMxS0t2akpqU3NU?=
 =?utf-8?B?TWZmak16TTdjQkYrbFRwY2doR0hXdWZTeUY3UmZDQzhOOUQzVmJ0OWNhYTY0?=
 =?utf-8?B?OTFMTWlCQTlNeTQwa0VpNHhLTHR3Qlk0SFh2eUVibDdkRm5meDFiL3psZFl5?=
 =?utf-8?B?aFExNUd6N1ZiU2htTCtrL3krVE4zdWZpM0VaUmE0dHN3SVUwRW85WEhHTWZy?=
 =?utf-8?B?QWJqeThmYWo0aXVhaTNIUHlOUXVVOTRqS0NBV2pKT2phSmlYT1pVRDBUTnl6?=
 =?utf-8?B?NnBjWEVGcSttOWFvNTRqS1ZraVpoTHIwOUZSTSs2b2hCL2tLRHZHbUw1UDNm?=
 =?utf-8?B?THFlWURnejIxb3d2QktLNnJ0WG16NHVzbzJqYTBYN3JmV0xGZEduYXNrYzkr?=
 =?utf-8?B?TUFxUThsdE9SaWR6dlNZMXc0cnRycFVqUTB2TTg4TWJnQitaQWFWeHM4Q2ZE?=
 =?utf-8?B?Q3R2eG1oNi94SkFQNlZObUsvaG5wMkYybHpQSlJrQmkyelJNQmhQVStYWXV6?=
 =?utf-8?B?bTlZNFhYRzA0cG5oemRyb1V1NXAwM1M3SmoveWNaZ1JJdUZBWmFER2hkdGI4?=
 =?utf-8?B?VVFpYjc5SU11K2s0blZIR1g5UithbWM5VFpqeTRIM1l1bng0cGZMdU5vTlB1?=
 =?utf-8?B?eTVQeDNZRWZvc3lLZE8wN0NHbTNRSFZLcUVKMElVajc4QS9yeGc3bHJSYXpo?=
 =?utf-8?B?bVdtVlY0cnMzanZmekV2RGxTY042Qm9SRGNieHdtWmx6cWVsYWtTQ2owb1By?=
 =?utf-8?B?dlh5WDMvcjhoZ2hCKzZkL3Urb0JuSFRqQU9SbUU0aWphbjRROE9qNThORGkv?=
 =?utf-8?B?YUYyT2o5aS96UDlwNU1KZ2ZwMjZST0poV1VMaTYvVkxiNUdBb24vekJIWUg3?=
 =?utf-8?B?dE9CU0FteHBQQjVsTXRqblBEaDdUL2lKRE8vYVBPbmxZOWxFSlR1bFZ1WGxN?=
 =?utf-8?B?aTI4aExlYlMxOXVDS0FacHNmTVAwVERxWVZNcWtNTGRveDRlaE9zbG9aaUd3?=
 =?utf-8?B?U1lPTjM5MEhkZ2daejRPV2tRbmJvMjBWODdqUXNJd0M0djZrcVRjdWs1WFNC?=
 =?utf-8?B?Wmc5c0JndlFiSHRwUTY0V1ZmTjBoeEw4enBIcWR6TFZDaXNlUDd4L29ibWZ5?=
 =?utf-8?B?Uk5xL0FCcUFlRHpnYzlZamZhdk80cU1tUVRkM2xOdEJIbTBVWUFreFkyS2Jk?=
 =?utf-8?B?d2dSM0FvTmRIYzZmSXJWNTcrWTJiaGM5Q1pFQnpMZDY1TXZkOHppd0hrVkd2?=
 =?utf-8?Q?vQVs1JubQRqT5EafQt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d71f7e-5dc7-4444-056f-08df0ff040a0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5367.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 10:34:26.1807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTZR03JH8LXRbLWMtrcuEx2yAtxPGtMCY5bSQqpI91Aw/sJql8m9FXgf7vnXj7Dk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
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

Hi,

On 8/24/26 9:11 PM, Anders Roxell wrote:
> Hi,
> 
> This is part two of two. It applies on top of part one [5], which resets
> the DWC3 driver and imports it up to Linux v6.16. Part one alone breaks
> the build for every board that enables DWC3. This part adds back the
> U-Boot glue, the XHCI and UDC updates and the build fixes, so the tree
> builds and the gadget works again. It builds on Jerome's work [2].
> 
> The two parts have to go in together.
> 
> The resynced epautoconf matches endpoints on their caps field instead of
> on their name. Five UDC drivers never filled that in, so each one gets a
> patch next to its other fixup: at91_udc, atmel_usba_udc, ci_udc, musb-new
> and mtu3. With those and dwc2, every UDC driver in the tree sets caps.
> 
> Build tested one board per driver: every DWC3 glue layer in the tree,
> dwc2 with and without DM_USB_GADGET, at91_udc, atmel_usba_udc, ci_udc,
> musb-new and mtu3. 17 boards in total.
> 
> DFU is tested on hardware on BeagleBoard-X15, and on BeaglePlay by
> Anshul. ci_udc is tested on an i.MX93 board with ums. The rest is build
> tested only.
> 
> The branch has both parts [4].
> 
> [1] v5: https://lore.kernel.org/u-boot/20260716134305.614278-1-anders.roxell@linaro.org/
> [2] Jerome's adaptation work: https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
> [3] dwc2 prep: https://lore.kernel.org/all/20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org/
> [4] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v7
> [5] part one, subject: [PATCH v7 00/63] usb: dwc3: part 1, reset and
>      import from Linux v6.16
> 
> v6 -> v7:
> - Split the series in two. Tom asked for this, so review and iteration
>    gets easier. Part one is the reset and the imports, part two makes it
>    work.
> - No code changes in these 24 patches.
> - v6 never reached the list in full. My send died in the middle, so the
>    cover letter and the last patches went missing.
> 
> v5 -> v6:
> - Split the "add helpers" patch into a dm patch and a usb phy patch.
>    Mattijs asked for this.
> - Kept the U-Boot dwc3 Makefile instead of the kernel one. This is what
>    Marek meant with glue drivers that are never compiled or used.
> - Brought back samsung_usb_phy.c in an own commit. The restore commit
>    deleted it and nothing added it back, so odroid-xu3 lost its USB 3.0
>    phy setup.
> - Stopped moving functions around in dwc3 gadget.c. Where a function
>    still had to move, the commit message now says why. Mattijs said the
>    last patches were hard to review because of this.
> - Split "fix up musb-new and mtu3" and "fix up xhci and cdns3" into one
>    patch per controller. David asked for this.
> - Set endpoint capabilities in at91_udc, atmel_usba_udc, ci_udc, musb-new
>    and mtu3. Mattijs asked for this on v4, after the VIM3 fastboot
>    regression. Each patch sits next to the other fixup for that driver.
> - at91_udc now calls usb_add_gadget_udc(). Without it udc-core never sees
>    the controller.
> - Enabled async callbacks on bind, and added a cache flush and invalidate
>    around ep0 transfers. Without these no dwc3 gadget enumerates. Anshul
>    found them on BeaglePlay, I hit them on BeagleBoard-X15. DFU works on
>    both now.
> - ci_udc got udc_start() and udc_stop(). udc-core calls udc_start() on
>    bind, ci_udc did not have it, so the board crashed with a synchronous
>    abort when ums started. Found on i.MX93, ums works there now.
> - udc-core got two more fixes while I looked at that. It checks
>    udc_start(), udc_stop() and get_frame() before calling them, they are
>    mandatory in the kernel but not in u-boot. And it reports what
>    usb_gadget_udc_bringup() returned, before it only said "No UDC
>    available".
> - Rebased on current mainline. The ci_udc patch shrank a lot: mainline
>    gained three ci_udc fixes and the old patch deleted the functions they
>    touch.
> - Mattijs' dwc2 endpoint fixes [3] are in mainline now, so this series
>    has no dependencies left.
> 
> Older changes are listed in v5 [1].
> 
> Cheers,
> Anders
> Anders Roxell (24):
>    dm: add helpers needed by the resynced DWC3 code
>    usb: phy: add the usb_phy helpers needed by the resynced DWC3 code
>    usb: gadget: adapt the gadget API after the resync
>    usb: gadget: udc: make udc-core build in u-boot
>    usb: dwc3: make the core driver build in u-boot
>    usb: dwc3: bring back the samsung usb phy driver
>    usb: dwc3: make gadget and ep0 build in u-boot
>    usb: gadget: udc: enable async callbacks on bind
>    usb: dwc3: ep0: flush and invalidate cache around ep0 transfers
>    usb: dwc3: make the am62 glue build in u-boot
>    usb: gadget: ci_udc: move to the udc-core registration
>    usb: gadget: ci_udc: set endpoint capabilities
>    usb: gadget: dwc2_udc_otg: fix up after the resync
>    usb: gadget: fix up the function drivers after the resync
>    usb: gadget: fix up the last UDC drivers after the resync
>    usb: gadget: atmel_usba_udc: set endpoint capabilities
>    usb: gadget: at91_udc: register with udc-core
>    usb: gadget: at91_udc: set endpoint capabilities
>    usb: musb-new: fix up after the resync
>    usb: musb-new: set endpoint capabilities
>    usb: mtu3: fix up after the resync
>    usb: mtu3: set endpoint capabilities
>    usb: host: xhci: fix up after the resync
>    usb: cdns3: fix up after the resync
> 
>   drivers/usb/cdns3/ep0.c                |    8 +-
>   drivers/usb/dwc3/Makefile              |   16 +-
>   drivers/usb/dwc3/core.c                | 1761 ++++++------------------
>   drivers/usb/dwc3/core.h                |   39 +-
>   drivers/usb/dwc3/dwc3-am62.c           |  424 +-----
>   drivers/usb/dwc3/dwc3-omap.c           |    2 -
>   drivers/usb/dwc3/ep0.c                 |  117 +-
>   drivers/usb/dwc3/gadget.c              |  719 ++--------
>   drivers/usb/dwc3/gadget.h              |    4 +-
>   drivers/usb/dwc3/io.h                  |   36 +-
>   drivers/usb/dwc3/samsung_usb_phy.c     |   77 ++
>   drivers/usb/dwc3/ti_usb_phy.c          |    2 -
>   drivers/usb/gadget/at91_udc.c          |   83 +-
>   drivers/usb/gadget/atmel_usba_udc.c    |  114 +-
>   drivers/usb/gadget/ci_udc.c            |   86 +-
>   drivers/usb/gadget/composite.c         |    2 +-
>   drivers/usb/gadget/dwc2_udc_otg.c      |   86 +-
>   drivers/usb/gadget/epautoconf.c        |    2 -
>   drivers/usb/gadget/ether.c             |   21 +-
>   drivers/usb/gadget/f_acm.c             |   20 +-
>   drivers/usb/gadget/f_fastboot.c        |   10 +-
>   drivers/usb/gadget/f_mass_storage.c    |    5 +-
>   drivers/usb/gadget/f_rockusb.c         |   11 +-
>   drivers/usb/gadget/f_sdp.c             |   12 +-
>   drivers/usb/gadget/f_thor.c            |   19 +-
>   drivers/usb/gadget/udc/Makefile        |    1 +
>   drivers/usb/gadget/udc/udc-core.c      |  933 ++-----------
>   drivers/usb/host/xhci-dwc3.c           |    4 +-
>   drivers/usb/mtu3/mtu3_gadget.c         |   10 +
>   drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
>   drivers/usb/musb-new/musb_gadget.c     |   21 +-
>   drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
>   drivers/usb/musb-new/musb_uboot.c      |   39 -
>   include/dm/device_compat.h             |   13 +
>   include/dm/read.h                      |   51 +
>   include/linux/compat.h                 |   15 +
>   include/linux/usb/ch9.h                |   25 +-
>   include/linux/usb/gadget.h             |  529 ++-----
>   include/linux/usb/phy.h                |   56 +
>   39 files changed, 1406 insertions(+), 4007 deletions(-)
>   create mode 100644 drivers/usb/dwc3/samsung_usb_phy.c
> 

I tested this on AMD/Xilinx boards and didn't observe any issues. So:

Tested-by: Love Kumar <love.kumar@amd.com>

Regards,
Love Kumar


