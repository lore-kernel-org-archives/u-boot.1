Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257B0C9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 20:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B435C40B6D;
	Fri, 25 Sep 2026 20:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Z8EmvCvRo-O; Fri, 25 Sep 2026 20:15:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E315740B9B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790367302;
	b=XXVWE9trom4oYX2XDhXMr6xtjzGVyiYishUF/ZmDsRFJasv1RYLAmeb+DWSyqHSHnA6X
	 OPE56fVG+ecKEnRYcY/BI2SF9vzsp2ZkCp1eSfKeaYVljgZbLmWbXjKSI0JAlEdNkAOtA
	 eRye+HJQBku6jjVNRdkMZNmMkUP2bqOsWRQeQfzgqHque5lh6zHyYHk2X/uf7sggjVkH8
	 vCvR+XpOFdCA0E7pBMN6HSB6T/cSENKNMU7Ou2tgXwT01ElJsqUknBhhq+2nJ4FvOp2Dh
	 dVpQCaoVc8wUjeGuAoC8ZAyMu+PAPz0k6MVqcbAhEztsg59dbgNTn/1yaffbOBO5h6Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790367302;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=OXNdEJAR8CVqqv0H+72zb+4sbmq1TmuJRHao1ggsWwg=;
	b=Syvi6FRPrVlcgNyXRQ8diKSRT0DwZnJZfYOJX4V+RFGVrFmAGYYQW7vVwVE4+Ccz9bbe
	 2f3owI48EjC5jtYPoD9DfKls0Vx4zeoNjdZoqYSzSL5TsqLPnHBJIz2XIBOQH6scQVAHl
	 LKQx1U8w0ZvOIyzerC40fBYCKfJpJrR+3aK3YDnq4O4WZICQ9TQrWi+IZVLxHiG1otS62
	 ZqAsJzAdcZWpZzZRMZ9YW89qVEXLtgCDQamMSjWVeCGIpWDfzX2zwO7ZZ0dUQ5She0s7h
	 snP+rhN/eJUyvkkLbp6l9cVi15UTiaEg1UtJP9Zh/RtyZF2lP+CVGAkwSVxEDHJfjuw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790367302;
	bh=OXNdEJAR8CVqqv0H+72zb+4sbmq1TmuJRHao1ggsWwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XOLS9id9oQCgW5dCty67v3NkEiuKeutRbtot/WFAZHE6Lnd0c7vZFxhZzXbwnQ+Do
	 RD87fNeLuUtaxQVacrLleZjNBSxY2ckYX088xnlHOWxde0gbXoc/RznupS6i04P7qf
	 EhohVZoTub+sI28nFQmSCHAsSaZ2zTnvA0sWloXIb5VtH2FSGZtlQI5+edXuzbLGTe
	 /cjyr2/8W0qhZdOmQR+T3xAlJr94Pf1AQOpJvsvzgiq+Oe/PAGXiyc1nn5dpLL54tz
	 eDvAEIHaZdB6iGRzSX0vaPsvyi7qaIEeoT/qwrOlzcievSgWv6Beiph4Z6Akw84e0D
	 Jmo9J4/ePIWnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E315740B9B;
	Fri, 25 Sep 2026 20:15:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E8C0F46
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 20:15:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1075D60707
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 20:15:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X8BTwn5oFhQx for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 20:15:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 10A4460B62
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790367300;
 b=aJ05UhUWLje2XLSJ0WqHZrtrjeRlucxFNx4yCqB1dHIeOcdvd/uXWL4j/2yqZ5X4Mrz8
 9MS9XhaFU3RlNDntWlXsD3pNFpqUDuRzwqSkljavZlmqypCfWbRQbPJwKQvtV32no0SNR
 F6FLRQQ0I2rohB88gEdr3CovZpLlgA4Ot849o9R82yehK61acyl3vX+eRHvYplN5ZGReW
 d7DowrEec+l241GQ73NS/WdkYJczBzaXAtgT4B2K/Dxf97fjIW82SRzmKWnF6B67M3EcB
 rWz+/tcY/8IYFAyQAoaDSz59/mdFH6QjrnfzFOOP0X21rUfUNqXoli71/yD6GMIrzxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790367300;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 bh=OXNdEJAR8CVqqv0H+72zb+4sbmq1TmuJRHao1ggsWwg=;
 b=SE8cj4hTYXmcenbDCOwFsxBIFfB96cbTjbI7PIYCsS9kPki1kdc/62MzX+BxPwYA289F
 4vpQ8f8y6cneSkOf6G7zwbrTdinNTdB2f8MGnsCRN/h2qNwIDY+Fw4v8ergymfqrAGEPY
 rkAH9+YAwXvWeRvTYulZPWeXCQsM6QXVWf8gzI5C2T+WGHncAlfPw4gwg96w1tGEpCibg
 n8ZDqkTMmJdQJVNL9rcXzEbRThNtn53njArYbEJp6BvlheKdjQjY+cY7KNak5nW3tsjQM
 lYBpQFEnGN1YhBQdaivZpvoSyZFTN06Cjxkl22WXyM9uttZgrtEv6di6EarCjIEkf1w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=dgs23Qqt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c001::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::2;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=dgs23Qqt
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 10A4460B62
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 20:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXSjpmFGrv2iHYxtROMyM2w/7PxYdHUWHVKLg656dlZIgjeVdHTF9d8oe5l59a0SlnlSDl7+MZvivoA88c23KVQBtBg21V99ctCdUeep6VWmVfmnhSUY1p4aWljocqYzFh4z9NSDtj/QbV30w9ALGDJ5Aqd4dOJLuz6edUW79jJYhLUf0trWAeokPDK6XZRQNXmIB2dssK9H8h+8jIGesykobngA3IXTRtwK6DKyJpKrgTRd1AgU9uiycXByP7JxhcMrJUpD6C75eh1v8ttZj9GSFpZN0PEhOabWNMcQM629GEyIeLDF2azkQLQG1LRQ1TefQ6begeozSufyGB0kIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXNdEJAR8CVqqv0H+72zb+4sbmq1TmuJRHao1ggsWwg=;
 b=c0I0opHFX9WsJoBvfF46tN28ebxU2u0mvW80xAkfQx2eiauEaJm28OYPfT2mZRao8tjX+aR+zSdD7OPgdFJ33GMtNFOaT+mErdUo07TPfb7qAeJ+fGETqj6LtMKp9HWYJFblmheicj8FkmHqlbXU7a6SToq63k9SDm/bhPZz5a8Q/+RHLD5bU7owFyj2VC0jsDZs7Xq8dqmiidUcO1EXSYyfallSV9XZi62DNvu5JAdTmhzV4mqU/ayZhaVTUekVx7piOEy9S/LT+ecu8osk3g5i1Zyz9KUidjH5Cxt0C213o5X4uGIUbf261pz6ZHx6aT6Baoe6K5uaLhXsNDwA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXNdEJAR8CVqqv0H+72zb+4sbmq1TmuJRHao1ggsWwg=;
 b=dgs23QqtgMRjedprOLxMfqzTexVa59YYmmXhKpHeFnwdkgPdruiEp36VOyKHqNHZb2yonxXJ8GR4yhhtvgSkByv6Uvev1zlUSFaEH7Flb47BnPWTLeumDTzS5zJZJ9UjmQcDHtvTeJ8uj+TyxgSe0XvJYIoYKk3N7IUo8nhP4xVm8JD1Qgme7NnJKjTvHxz5M2sQZ35BxtA4q1s7pqcdJGuP+IBDzP0zoBh97O7IHV+HfFrS6rGKcEssu7CRWzsEUUCo1W7UdMIA4h4BOiAMi7fASSJ8pNgHzwkQlqffU+7l5pPvroeY8ia3Y+1XBYTX2suyqRVpfPRh1rCRyyJMJg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH7PR03MB7954.namprd03.prod.outlook.com (2603:10b6:610:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 20:14:57 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 20:14:57 +0000
Message-ID: <4f9284f8-11a5-4e0f-b6f5-c7c6565cd0a8@altera.com>
Date: Sat, 26 Sep 2026 01:44:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: Add missing MMC_HS400_ES_SUPPORT to
 mmc_set_card_speed
To: "baozhu.liu" <lucas.liu@siengine.com>, u-boot@lists.u-boot-project.org
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 eric.chung@riscstar.com
References: <20260923054500.43150-1-lucas.liu@siengine.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260923054500.43150-1-lucas.liu@siengine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0285.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21b::6) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH7PR03MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 1848304f-7fb3-4593-c13a-08df1b41ab5a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UKXSoz5o1VIQpcAxGRql+BZYsXYa/mu7YLrf0Ctg6s7WnEvkE9Bw8nsWKarvUb4tY5pUh2UQCd7cjkB1WvE5lfNuZ0HcKLDqBQuf3y5jcC6OKGB/vv9SFFE6BdgCfUuTHFaqU/ViIwQHXYoy9C8uB8xhJMVkfSrtPy+1ZDiy4xd2oMeiIKuoOeUy9Ff0Sl6lrmqCCZtnp+iRAPLl7CkyZ12uB/OHwvFEYX190w6XH22g3c8o4f53dizhb6HgF5oNfI4kU7lHONjZd9agB+7T1XbtVR+RW2h3/fKD1p6WwxsN5ujVqM4WAzJ/9WpS4HBPSFFHCxNpZjq+brj5R94QeAthtXl7H/7fNiiIgYmyhclUqDktGkz8hjRChLkLGswuTvp/V8E/uP24h/RYQJcvpuo9fYK/4zTn3gwjcq1Vq3o0eL5xJKGfrW1JDjxVexL1kcll1I+dBB71/F0tPW6BiatsJvCieETboIUNspWCyHynXjNLHWnlTIZmd483Pp2E4Wq54N6KkIq4z+iEaOCzGQZQRcsvC8SalmQYYVmy25G8Rv4OkXrOCLYWs+oo6/TBASpx5mujvPMMjvL+CZW5uMDsIVQuENnWa/GvDZAXv9yO3KPIPAQQlul2b4VDJAfwJhNQGa35tE8yDTGkjbKAR8FW1shuEogpg5sn+o9ksfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(55112099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGRPOU8vTnJzWXo4c0RrMHA2TkxtV29qNFB5RGY4SUxyYnloNGNUSkdqM21L?=
 =?utf-8?B?cmtmSk02WkRuMW5leEVNcXRJNUR4S2NRaUt1a2ZZQ2tiMm1MVCtMWEc5cGI4?=
 =?utf-8?B?RHlUZWx1aW84ejAvRXFJclFXTGpLSVFvSFdhbk1jTXZDdjBCa2ZCa2ZIK0Qw?=
 =?utf-8?B?aUVaZE51QjhnSi9abGd1bXZYK3JLRksxbDlWS0lRUDV5MmlUNkcwQnN3TEhK?=
 =?utf-8?B?Um91Q1NlWmpRcTZxdWlKVFdGYlNEVzI5SzJ3ODZUeGhIM2pCcHFYSWRYeFEx?=
 =?utf-8?B?MlA1S0JteXlqVGtSQ2s0SHZZdDFCT2FQQWk3TjJzT09qZHdNRzYrT216dzdj?=
 =?utf-8?B?RFNicE1WeG1lQ2dtM1c0SHZTUS9yYW50dHR2aG5YY0lMN2dIUGpvZC9uSGRR?=
 =?utf-8?B?NmduM01Nanh6dXZwVjJxdlUvNEdZYnJDTFlzOEsxYldFU0VBd21ubXliTXFp?=
 =?utf-8?B?ZzY1NUpsVC9FL0JRUkRaZU9xQm5ETnVrc0ZidE1rbUVDYVhFL0MvMDhYYldY?=
 =?utf-8?B?VkdYajdiMjdWS2xHdWJUTUd0WDc2SXh3dEhzVUNjZWlsRlMxZEpGQ0lSWXh0?=
 =?utf-8?B?S2JSYW1MZDV6b0dwQXZieisrNkE5bW14cXhmOWJ5NUUrdUNIeTl2WG9pU3Yx?=
 =?utf-8?B?emgwQnp6bEt6SlpsNmkrcFg4SVNyVzhkb2xhWWNNVGNXMjFNUnpxM1VsOXJw?=
 =?utf-8?B?ZFFRTVlVdCtvT2R5N0NsTmwyeENIbmhiWjIyL1NaaDhPeDZuMlBmQitwNU9q?=
 =?utf-8?B?MWt6NVFRcmJYWW1OaWlKS1VWNmlQa1lCcEtIUFhHWnlWaHFPLzgwalR2Qi9r?=
 =?utf-8?B?K0Roai9sRGZvMlJVMStraC9uUzJmRUZ1UjFTRGZFQmNQMEpFNjRWVlN0ZHd2?=
 =?utf-8?B?MXU4ZWs0WXVhek92M1hFWFRrTXVpa0hFZjBoZWY2WkZqcFJKSGV1N2E1eFUr?=
 =?utf-8?B?TmwxOGluL2JnYWtFTGJIT2lYNzRWcnhWL3h6a1BabzA5UkFyRWNkM3krNWRl?=
 =?utf-8?B?MmcrM2J5TDh3ZTU2d29PcWl4UW9kSVhDVWREb25JQjNBcnNPYmx2R3pna1lZ?=
 =?utf-8?B?SHVpckJYU1lRaWpEdS9jYTJVWWxjekI2RnRGWUNFZXMxazVySU93NFJhU2xD?=
 =?utf-8?B?RzREcTZ0VS9wZlV5bFZaRTdMS3d3SG1hMVRyRXVkOWU4aktCZ2JUcUlRN0Nl?=
 =?utf-8?B?SjRTZFBJMllhbmRDRVNwbWZTSDk3RWdBOTBwLzRoRkJZZHA0MklveDBLc1VT?=
 =?utf-8?B?bDJUdlYvV3J4V2J5U3E3UllSL1JDNGFZSjJZTml5YWFxZlQ2M3lRUzZVWDha?=
 =?utf-8?B?SlFURXdqOU04ejhpSm5YYkNJY2JzVVBLL2ZRYmsxNldYMjF5amdZRGhIQzZ3?=
 =?utf-8?B?U0VEQmJQb3VFTHdKWjhnd1QvWUVQcnVEVk55VHJRaS91QUFMK3dNV2lKVTlz?=
 =?utf-8?B?cTYyYUhva2d1ZEUzSEhlWllVT3Bkc3VCa28rRko5UUNNVlZNQStXWW9yTm5v?=
 =?utf-8?B?S1VaVVhVZEVXaUdnSVVBYkRUdEdkWTZXVk1yS3BKYlYxYVU2RERlSVpWNXEx?=
 =?utf-8?B?MzBadWJFeEpNUG5KODUveVJiUGgwalpkSHpPeFNOVERjL2h3SitkWjVVakZm?=
 =?utf-8?B?b3F1a3RrbkFJTnRhT0tDd1hnUUp5ekJkQzBpTEJHbUdydURERHpDTk1iczMv?=
 =?utf-8?B?U0F4TEtId0NIUVVLVCtocTI5UzBSZjFKVkczR0N4OGJHZllnQnNGRzI4Ykw0?=
 =?utf-8?B?dzg2Q214aDNTVHBDOUhvQWVhVFcwcFRWWDZPV1RQbHBlNmlidjI1SzVQcWJK?=
 =?utf-8?B?TERoZ3RqWVpVMDdsNTJCQ2lzM29oQjZzUGV4VDRGYkhPMU5MY29hV2JiMWMv?=
 =?utf-8?B?N0FZM1dmOTljSll3SnFCWE1vTjFjRFRvWkk4Tm01a2wzWUE3YzB1UWlHYisx?=
 =?utf-8?B?OGdiRzBSM2ZQWVd3N25HMWhHYUN6RWdHbXRwQkE4c2t6U3dxd1piRk1kb2ZE?=
 =?utf-8?B?Q2JESTlPdDJRdzF3cWlPOUp0ZUM4N2ZFd0p6a3g0VDY5TXJtM0JSTzNOM3c4?=
 =?utf-8?B?WEJkWkdpRXg0cVdCWURjeGxJekFPdkZod3pic21sWlZHbnBZeS9Qb3FyZTBq?=
 =?utf-8?B?OERrZ016TnN1ZHZ4Ymh5bXpEMTJiRmZkdUJNbW0xRjY0eXpqZFgrOFJ4eDV1?=
 =?utf-8?B?Q0xvZWFOVmVwZDdoWjdsMElHdURSRVYyNHhlSG5XTWJYUG83eW1FUUtDc2lH?=
 =?utf-8?B?SDBZaDBWaW44VmxXS1Rsa3lHV0c0eHpOQ0hrbmFnMU1zRjc4dmJ5TzNScFdq?=
 =?utf-8?B?Q0cxY21BVHlrMjhjNkM5NFM1QVpvUDBYemw4aW1jZmxyWFA0bm1wRXhPK0JS?=
 =?utf-8?Q?pgdA/xWglRwNRbp4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1848304f-7fb3-4593-c13a-08df1b41ab5a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 20:14:57.5476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6Netkjv8LwEyhlqDQM8BRhzULdGg56m3SMHizc686jQ84q/z+AgyqxSpepW7beMfzKyanFh/A+fhweVFhSUoa3W2tsjYPZau8LjWGYdIRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7954
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

Hi Liu,

Thanks for incorporating the feedback. Also, you don't need to send
multiple patches; it takes some time for them to sync and show up
under Patchwork.

On 23-09-2026 11:15, baozhu.liu wrote:
> mmc_select_mode_and_width() already passes true for the hsdowngrade
> parameter when the bus mode is HS400-ES. However, mmc_set_card_speed()
> only checks MMC_HS400_SUPPORT in that branch, and if (hsdowngrade)
> never checks the mode itself. Add MMC_HS400_ES_SUPPORT so the
> downgrade path also applies to HS400-ES.
>
> Signed-off-by: baozhu.liu <lucas.liu@siengine.com>
> ---
> Changes for v2:
> - drop the dw_mmc: prefix; the change is in generic mmc.c
> - mention mmc_select_mode_and_width(), which already passes true for
>    HS400-ES
> - clarify that if (hsdowngrade) does not check the mode
>

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

