Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0ECCC88E4A
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:40:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FC7E81208;
	Fri, 11 Sep 2026 10:40:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xt0wJEQpBQcv; Fri, 11 Sep 2026 10:40:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2C66F811E0
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789123204;
	b=fAGw4QS64Br+EhZpEXTyHp5inVkgjhTmAGIq5ep2uz2/6c0ram6sROXX3teJoWQNV8bU
	 t03RsXRQfQhj9d0hBQkOh32RBgZtSOk7REFJZMex+WjEiOAi9TtQaUWRbegpgEa1DNJkq
	 wnWUWwEE38oaDgWZckulT8UKh8lm+k/FWZFMWt8DaG3Z63fIk9kWQTPjMlIHIfkemFMvH
	 HQCq1By/VHiqnox8z8fxRIvQ5rJXR1IR7l3cPUAqA0wCd+Lpk7CZpMRo1uwvnQP8JGnj0
	 MQDZnayGwkfKUWTPhNJCmMGwOGb0BZsf0ubq5oYO3j56T9duPWF2yRKk9LyoH4xLyzg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789123204;
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
	bh=xqVkieh0IBVIC2BazliHMt2RdDvlPgRYYKG5bTlzlCU=;
	b=lFPCh6LMsain4Ilc+4A5SwW+ArksHibohUvhuuZ0Bun8/Y2RU8z99aYgrU1RE/5mTGC9
	 H3qzGN761AdJ6y0MZ1J/dckikQq5RD1qG9qT6Mw+sz3BhvGfAjn6bzfDHi6j5w1d5UXXq
	 aiFA7TdEtZkHbNcPVnuJd7f/8pyMzbmaeACr+436CWV9FNyp7kUy9lktN9o2LLRtkQFVi
	 detn76W5xgCxny2oLMcVIBAXWtAMLVHSSR0MDKKrEaqPHpncGxNupXk0FhO/0D2MT3HbO
	 FDHQnUf8SOENM7/iwYeD6YVJ4aXM+czH+PZpsIjJ5Nx87rwXxu+9VqGw+kfeWU2IneA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789123204;
	bh=xqVkieh0IBVIC2BazliHMt2RdDvlPgRYYKG5bTlzlCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pJj37ty1Qp5SiM2mO21T7eLEaddejLxNazEl/fqSmrgu2nJJHFUBL97as/DbJ7916
	 xcbZ/JW2AQGTTVPu6hfseqTwBblmAqF3uQGRte9oGbr6Ee7LaprzYTSDWhrhGLRjJw
	 siIEb+0/jWRenB1broNY5dyL5+WmtBcc4vzH+Z2xldKnEbobbKCX2KqMaBelRE4zHi
	 zeM2ePgdW71QO6gYbcqBvzuofNrH1Spl71IjwloqKXlv5CSec4j5E3xtmGhilslTWt
	 loLzB3un4qcIHLOdwRlRZkagUX1qsAcnyLS1wD9xg8KDeiER37gwroS9AB7zTOAdAH
	 xSLVELQEE/7Mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C66F811E0;
	Fri, 11 Sep 2026 10:40:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CE68032F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:40:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B441840452
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:40:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nWXTaF6pPUvQ for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:40:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EC58B4044D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123201;
 b=p3hXu16Bw1M7S5DIN2dPzBScSG75ELz1u72pMzucF4AUn3SjJlSyndfQdD1/qKN995H+
 IOSqAI+VW1FTl9+wHij//QUjJex5MMbvNX4mcnIfzzvrW8Q+O2lTdCAQoAUT8P7YfIGar
 4b651mwezYCbO3qGcjHLFbuqmowH6aq82GsDYcYy0Oykt99SDzLRQpbcnfS9N+Me9urpp
 EZFnYTdVFHqBFq06y90oPtYmMH4Dqfz1GUJUWdhmYsVphdvva6xPVT/sSBaYbgl7p+YPj
 ymnb+y7JU0raRr0OUkCs/CM5AAopIvAY3wcNr2DHjU58h7vDznZzIRPPE37lD80qQCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789123201;
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
 bh=xqVkieh0IBVIC2BazliHMt2RdDvlPgRYYKG5bTlzlCU=;
 b=WlgtEZCF8aqxLyMV+Tjj2HyYca5FXXOzUWlKZYhTDBizEaZmj7pJCCLLMd5MZGLdrJ91
 eOXzLloxqwDaRL+IQheNZ/MY2WJ4pnPrGYNhh6uKbsih3+bewGQ6J/F8nnHPfxE0HpTPp
 BCdWT5nIYVd3YqIJS+KD98TbLJ6vyHMPCmNQFpB3FXwoZefmLFWPW8SOwfPIvnVretyZU
 OTi582j07Bda5RR7Y/Hr5En3bdIfbrZZr1x2WdAUZk/p51jP0lI39w8C66z1t8B2h42Bu
 jDjLowNZk7EXfZSCK2tExqtgcjJIXQC47j6p0nl1KiyVUFh+qapnsbl3xtVYyp6ENlw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=EHpAUXNV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=love.kumar@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=EHpAUXNV
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC58B4044D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:39:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HH7jrBXPIURk8cwBZyxrmdzwQeCK2407cUjPEOUVByv76VZ4FdlgVX+KEhBYRXWJWg9BIAPzbj3CYFGSxI1rCsyUHu+qGuHC5Uy5MA1kU3RnzTgMD1o9DVSLTcBpIk8fU835szAzrz69HoVW4RaGfPtZD9ki/1qb4dj96C3xvnub0JMndnTAuhmWLAuus5CnnlKpHGqXkblhKixG4k0ZYD3uPHtpiXO5xckkJFQ29kMf92fsY+TgH79SUVDLNGamWoV2DjMBGrd2hGOGxZ22afFv29k95SPyT+7gkOL6ZRhplytQhueZX9McHU1l8Hh3IbbErAA7/JsR+b+MVJrA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqVkieh0IBVIC2BazliHMt2RdDvlPgRYYKG5bTlzlCU=;
 b=LG2zRlPDlsLM6uEBfTd1BF4az/3vlhUH87gnlac6f7cnwLk0SRmPWbhfhTwp21N4Za8wHIDNWiEFJewsXq2bS5UGJyL7DncgvOsyA3AO62ac5+KO6vjw3nRo5mVFJFhTmVN8hkregsfvMDokQij/BlGVgStPSNE8WW5OKuv0XqOy2RRZOFTjYc8H1KAI1i0qgCV+FYt7ks8Qy7JNCEnZiddFelsCH3yztA9QFOGXQrnO8vNJbG5HIORewGxyIsCiJlnI6iEN3y9lVPkuIotxijV0+RPIDVX36mNlSIzDG+r+P6ibR9SG9oT3SYZUnwNNkXfi2BNoPORtBOOWcXvxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqVkieh0IBVIC2BazliHMt2RdDvlPgRYYKG5bTlzlCU=;
 b=EHpAUXNVUNxyxmTNnW/ekQZshk+uFIcCBGbk8kxaEM/Wqm0BPGxqMWvgPxkEj5o1hQF9iGAsRIpHl5tkYVDLNlb1152XvrfLotiqFAJ4b9e7/axSsuiWCh3UsXwprUZVl+oihu5aFvbE4v6vbGbACbhscxYJHItpSx8MquBevfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11)
 by CH1PR12MB9645.namprd12.prod.outlook.com (2603:10b6:610:2af::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 10:39:56 +0000
Received: from BN9PR12MB5367.namprd12.prod.outlook.com
 ([fe80::68ac:2185:bb07:ae24]) by BN9PR12MB5367.namprd12.prod.outlook.com
 ([fe80::68ac:2185:bb07:ae24%3]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 10:39:55 +0000
Message-ID: <9fa15c90-b725-4ac2-b4c5-f388d5319fd8@amd.com>
Date: Fri, 11 Sep 2026 16:09:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/63] usb: dwc3: part 1, reset and import from Linux
 v6.16
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org, 
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com
References: <20260824152734.159794-1-anders.roxell@linaro.org>
Content-Language: en-US
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20260824152734.159794-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To BN9PR12MB5367.namprd12.prod.outlook.com
 (2603:10b6:408:104::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5367:EE_|CH1PR12MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f9f4eb-d0bf-44d8-a9f3-08df0ff1052c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|5023799004|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nsyMVJB4aTgYwreOhDvNWQz86FJnh5I5AZdRYCLZJIvHHdi0tCfhAVN2/FamQCWonAnLdJt6KlmG8iQLmVkM88IMAAn69fmVxpsS5AtgIlszxp8ZFp17jRYw/3u+Qi9UgB0BRiFt+E5U+OrcW2YcGEmfNlfbdIoHx4f0s+h8z5jdCDz83yQD4fT7lDoSrcPlquvGOhpPTOocEj2++z4mRnFtSfg5AIC3RTMMYWm6g+qihEeMLT5PffneCUeDlNM4no5xRRWnGc6hdFJXYc5KfddKDLJx2L4WHRUv4i8k0FVxOazUvAvXgVKSNFXBQ1071ThyJc4eMSzFhDMBk6NOrj4t5hceYFcas9ihmFVq6tlHn1cna+fXr31IfMvO+sU+JdbUFpVaIBYZO6Ncbn4RS55dJs8au/LhlKUpsXDmQB0OYjeLEZeJP0uzaHEEY8Y5rPSt8uI7FIcRsf+jzcxg++oGMec1PlLZESvsvKhLR+0AC5iYEjPzC94ifl8hR1sqZy1Tvz9IU+5YjkQ/m0le0ilPpp95c0NfOtls+M6yBLVxwjBplMVCQMFO4aPHVO2M3Acb2v1jel5J0HorZGBut/SB6y4FDoUYY7fAtcWrmIPr8YEmHTyTCHF8iFFYjvXGn9y0croJue1mEsI8RJtrA3VtPGu49Vk94OeQ6wa2bwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5367.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(5023799004)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1JGOStQUXpWcVpDTmRQYzlka3RlempGOFBqRTR5SzVRVFM0L2RNQlhEa1Vw?=
 =?utf-8?B?NUNtKzZudGxrUU9xbFR3K2pNZG16WXMzUXJYU2srWFhjWWtucERaUlQ3aGl0?=
 =?utf-8?B?eWNsYk9CNzdMOElzZEdpNXFQS01XWjQrZVlqN2R4QlpkcjRST3BaR2R3aCt5?=
 =?utf-8?B?Y2tNV2NVeXQ4T3NjY2t1d1FhNW1SeXhwUFc4dU1kS2p2R0dYNmxDemJpaFFt?=
 =?utf-8?B?SzFOczEyQ0FCY1dXcnZqZlpkTi9xKzUyR0NKSU5wTzZUNi9kdmlOelZUTXlS?=
 =?utf-8?B?ZW5RcG53bmQ0ai9Gc0MrUGRrWG0vQzUyaHNON1dMdEhWd3hTekRlR2ZYbVhu?=
 =?utf-8?B?Y3hwTTRhRmJicktLVmJpblhuV1JhR2cvbVlDM3VjaEhtY1dGQ0E2K200aTF2?=
 =?utf-8?B?OWZxdnRObkJSVzR4UjEzeEF0dFhOTUlEUjFndytldy9Rd1IrZjUwdFdxUUJn?=
 =?utf-8?B?VW90dlZiL2hiQzZyTTcyM05vdmJ2UVdMWXhLcGFBM3UzTDZVUmVTTWd0eFA4?=
 =?utf-8?B?b25ZRUtTWHhWbXJqVGFLa3UvMTZaSXM5UUttODJsb0RuNWRGL2VCcWovTm4x?=
 =?utf-8?B?S0dxQ3crcGZqSDhQOTZudnZwTnNWY0pwUzJtL0tDdklLYlhnQ0YxWUgyVjhZ?=
 =?utf-8?B?L3h2YWFSRUdaK0Y2ZlNiWnpsRnJPWlBEYzR1VDQzTFM2bkN5OStWOWszaS9Q?=
 =?utf-8?B?M1Y3RCtZQUtZMllXcWVaS1dsNUFsYUgrTG5zRzl0UGJXWEtGZXVXSGpjNHFm?=
 =?utf-8?B?OWVTeDBCVWxCMFBPaUdKVlN1QWhSUUJVdFFJekN2WkFBbGsxRTdxdDlNUldi?=
 =?utf-8?B?U05pSjBBU2JmMVZwaHZaYlNUN0pyZUZqRUNXRXUzazJxNDd4WVhxVlI2dUJn?=
 =?utf-8?B?aDUwMU95ZEs5bE9pYzJXZzkwQ2hvVnFmOVc3Yk1LWi91U1RZRkNmaytxWWNh?=
 =?utf-8?B?SUdYUVlxWDUwWU5MK0tCV0txOGxVL1pNVll1bWxlcTA4RVdXd0pRd2ZJUjhh?=
 =?utf-8?B?TmZMUzRaNkJ3bkp2TS8vV2lkR2ZweGVFcTZUMDdvSnRqbWlJVlo3ZE1ZaTJn?=
 =?utf-8?B?aUQ0SFppUmZLOTJ4c1NoN0dRZm5IUlc2b2NLRFVtcTNRT0pzdUVRYUhnU0sz?=
 =?utf-8?B?eTZmQWZQdUpGbjc3akhDN2REVzVtRHhiQS83YWRQUjNVeDBBUzJNWEVMNGtF?=
 =?utf-8?B?Q2VNN29zVkJ5WllJVE5FbWx5cmVQaERnQmtvUlhMS0J6VGc0MlZMcjFLTmlV?=
 =?utf-8?B?VC9nSjZTK3RISmNWdE4vUGs0aHZhQnRENm1pWjZYRGJFYmsrc3NzYTFSV3Vu?=
 =?utf-8?B?SGlRMzRNZUpoUXZyWm1rQlFnb2V2QTJUSytFWnJzUkdxSktNbUJVWU9xS08r?=
 =?utf-8?B?UnNXQy93djlraDd6aUoyUjVnVFJpUHQ4QjN4V25aSmVOcm5VME1aU01jUkFZ?=
 =?utf-8?B?UzlZVHZvL3BLeFlzeVR6YmpHSUF1U2tSOTVuWDZNdDhXa1NHTGRuT0pnek4x?=
 =?utf-8?B?ditZQkF4ZDV0NG5TMENwd29yUW5vZ0FyV3QyQjEvMC9JZXF1VHdRbVRZTWlv?=
 =?utf-8?B?T0NIQkJPdTJxRUhzTkpBSHNFZk81K0c2WXkvSGpDU0ZUUWtlV29tRkRsajNh?=
 =?utf-8?B?RlBXb1ozdVNMVWxMMFBINXdPVis1ak9VQTdjS0VhNUNJWjI1ZSsra01rcFYx?=
 =?utf-8?B?Z0RFSm9xWTIwYmw1M3gydUF5b1NGYUFlVGt6bUhrb3dJTnIzQTE5OUNSUVd2?=
 =?utf-8?B?YlVVVDdlWFdsd2wzSjRkQzBuSlg0Tm82NHVQbGlheDE1S28zSURXZ01UcWda?=
 =?utf-8?B?bGFkZGdtUTFIMkVzK0VDZ1pSWnpackc1WFNMVlY5dkhKbUxaM0tIVGRGSjZm?=
 =?utf-8?B?VmM2QThRaVBKN0JDN3RIUkREU1JSajhGbExodkYyQXJRTCs2WER0NjlLa1o4?=
 =?utf-8?B?S2VnZjBpbDQxcVBoc3RTaGFDbUVCNWR4dmRkazlBNDZKcVNwMHBNWjBoYmtz?=
 =?utf-8?B?dzEvNnIwNnJjUnlaWXpiSjBpNjc5cU5TYkVmTnliRTFvc0pkSnZ6T0VLOEs2?=
 =?utf-8?B?QlNQbmVBekRnNWFCdzh6MzR5RmJLZmFIMWhGYU80Q0Y0ZXBDQklHWXhTN1Mz?=
 =?utf-8?B?QjhXaDQ3UDdTNU9WT0QycE1tc09XMXdPU3BpNnlpUUltWWoxRHpvMitLaCtS?=
 =?utf-8?B?bUdjRnQ4V2V4S1BTM3hnU29sMUI5UkJsU0IxSzNEUDdWc2xHWHRlS0JTVDNl?=
 =?utf-8?B?TnFZNWQwN3VZdExOcEVsbE9DdmpvZ3pYMSswbmZDQjQ0UlZyZmVJREwwbkhD?=
 =?utf-8?Q?Yq/M4+iDZ0k66ra2/T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f9f4eb-d0bf-44d8-a9f3-08df0ff1052c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5367.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 10:39:55.9224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkbHVAywWF/TuMQ4Wo3P/Hb282At12rLZqAa2Yb+2cbUkvkwUP56KvQYnYP/tDW9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9645
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

On 8/24/26 8:56 PM, Anders Roxell wrote:
> Hi,
> 
> This is part one of two. It resets the DWC3 driver and imports it up to
> Linux v6.16. Part two [3] follows right after this one, it makes the
> tree build and work again.
> 
> Part one on its own breaks the build for every board that enables DWC3,
> and USB gadget stops working. That is expected. The two parts have to go
> in together.
> 
> The driver was forked from the kernel v3.19-rc1 eleven years ago, in
> commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel to
> u-boot"). After that almost no kernel changes came back to U-Boot.
> 
> Part one is three steps:
> 
> 1. Re-import xhci-ext-caps.h from v6.16. Marek asked for this one to come
>     first, since the dwc3 imports build on it.
> 
> 2. Restore drivers/usb/dwc3 to a clean v3.19-rc1 state.
> 
> 3. Import the dwc3 directory once per major kernel version, from v3.19
>     up to v6.16. Each commit is a raw snapshot from that kernel. The last
>     two patches re-import epautoconf.c and udc-core.c the same way.
> 
> The import commits are raw kernel snapshots. This is on purpose. It
> makes it easy to see what comes from which kernel version, and to
> compare each import with the matching kernel release. The commit
> messages say this too.
> 
> The branch has both parts [2].
> 
> [1] v5: https://lore.kernel.org/u-boot/20260716134305.614278-1-anders.roxell@linaro.org/
> [2] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v7
> [3] part two, subject: [PATCH v7 00/24] usb: dwc3: part 2, make the
>      resynced code work
> 
> v6 -> v7:
> - Split the series in two. Tom asked for this, so review and iteration
>    gets easier. Part one is the reset and the imports, part two makes it
>    work.
> - Collected Mattijs' Reviewed-by on 18, 27, 33 and 34. Those were the
>    four imports he had questions on. Every patch in this part has his tag
>    now.
> - No code changes in these 63 patches.
> - v6 never reached the list in full. My send died in the middle, so the
>    cover letter and the last patches went missing.
> 
> v5 -> v6:
> - Dropped the commits that only touch skipped or preserved files from
>    the "Commits imported" lists. Mattijs asked for this on many patches,
>    Marek on the v6.0 import.
> - Removed a stray "Fixes: b1a3ed068869 (spl: make args file optional in
>    falcon mode)" tag from the v4.14 import. Mattijs found it.
> - Fixed the "accross" typo in the import commit messages.
> - Collected the Reviewed-by tags, 59 from Mattijs and 24 from Simon. The
>    code is unchanged on all of them, only the commit messages differ.
> - Four imports had no tag from Mattijs: 18, 27, 33 and 34, which were
>    17, 26, 32 and 33 in v5. He was right on all four, and what he pointed
>    at is gone.
> - Moved the xhci-ext-caps.h re-import to the front, Marek asked for that
>    on 61/64 in v4. The epautoconf.c and udc-core.c re-imports stayed where
>    they were, he did not ask about those. Say if you want them moved too.
> 
> Older changes are listed in v5 [1].
> 
> Cheers,
> Anders
> Jens Wiklander (60):
>    usb: dwc3: restore to original v3.19-rc1 kernel import
>    usb: dwc3: import from kernel v3.19
>    usb: dwc3: import from kernel v4.0
>    usb: dwc3: import from kernel v4.1
>    usb: dwc3: import from kernel v4.2
>    usb: dwc3: import from kernel v4.3
>    usb: dwc3: import from kernel v4.4
>    usb: dwc3: import from kernel v4.5
>    usb: dwc3: import from kernel v4.6
>    usb: dwc3: import from kernel v4.7
>    usb: dwc3: import from kernel v4.8
>    usb: dwc3: import from kernel v4.9
>    usb: dwc3: import from kernel v4.10
>    usb: dwc3: import from kernel v4.11
>    usb: dwc3: import from kernel v4.12
>    usb: dwc3: import from kernel v4.13
>    usb: dwc3: import from kernel v4.14
>    usb: dwc3: import from kernel v4.15
>    usb: dwc3: import from kernel v4.16
>    usb: dwc3: import from kernel v4.17
>    usb: dwc3: import from kernel v4.18
>    usb: dwc3: import from kernel v4.19
>    usb: dwc3: import from kernel v4.20
>    usb: dwc3: import from kernel v5.0
>    usb: dwc3: import from kernel v5.1
>    usb: dwc3: import from kernel v5.2
>    usb: dwc3: import from kernel v5.3
>    usb: dwc3: import from kernel v5.4
>    usb: dwc3: import from kernel v5.5
>    usb: dwc3: import from kernel v5.6
>    usb: dwc3: import from kernel v5.7
>    usb: dwc3: import from kernel v5.8
>    usb: dwc3: import from kernel v5.9
>    usb: dwc3: import from kernel v5.10
>    usb: dwc3: import from kernel v5.11
>    usb: dwc3: import from kernel v5.12
>    usb: dwc3: import from kernel v5.13
>    usb: dwc3: import from kernel v5.14
>    usb: dwc3: import from kernel v5.15
>    usb: dwc3: import from kernel v5.16
>    usb: dwc3: import from kernel v5.17
>    usb: dwc3: import from kernel v5.18
>    usb: dwc3: import from kernel v5.19
>    usb: dwc3: import from kernel v6.0
>    usb: dwc3: import from kernel v6.1
>    usb: dwc3: import from kernel v6.2
>    usb: dwc3: import from kernel v6.3
>    usb: dwc3: import from kernel v6.4
>    usb: dwc3: import from kernel v6.5
>    usb: dwc3: import from kernel v6.6
>    usb: dwc3: import from kernel v6.7
>    usb: dwc3: import from kernel v6.8
>    usb: dwc3: import from kernel v6.9
>    usb: dwc3: import from kernel v6.10
>    usb: dwc3: import from kernel v6.11
>    usb: dwc3: import from kernel v6.12
>    usb: dwc3: import from kernel v6.13
>    usb: dwc3: import from kernel v6.14
>    usb: dwc3: import from kernel v6.15
>    usb: dwc3: import from kernel v6.16
> 
> Jerome Forissier (3):
>    usb: host: re-import xhci-ext-caps.h from kernel v6.16
>    usb: gadget: re-import epautoconf.c from kernel v6.16
>    usb: udc: re-import udc-core.c from kernel v6.16
> 
>   drivers/usb/dwc3/core.c            | 2961 +++++++++++++----
>   drivers/usb/dwc3/core.h            | 1087 +++++--
>   drivers/usb/dwc3/debug.h           |  432 +++
>   drivers/usb/dwc3/dwc3-am62.c       |  424 ++-
>   drivers/usb/dwc3/ep0.c             |  763 +++--
>   drivers/usb/dwc3/gadget.c          | 4776 ++++++++++++++++++++--------
>   drivers/usb/dwc3/gadget.h          |  114 +-
>   drivers/usb/dwc3/glue.h            |   36 +
>   drivers/usb/dwc3/io.h              |   51 +-
>   drivers/usb/dwc3/linux-compat.h    |   16 -
>   drivers/usb/dwc3/samsung_usb_phy.c |   77 -
>   drivers/usb/gadget/epautoconf.c    |  292 +-
>   drivers/usb/gadget/udc/udc-core.c  | 1890 ++++++++++-
>   drivers/usb/host/xhci-ext-caps.h   |  158 +
>   14 files changed, 9864 insertions(+), 3213 deletions(-)
>   create mode 100644 drivers/usb/dwc3/debug.h
>   create mode 100644 drivers/usb/dwc3/glue.h
>   delete mode 100644 drivers/usb/dwc3/linux-compat.h
>   delete mode 100644 drivers/usb/dwc3/samsung_usb_phy.c
>   create mode 100644 drivers/usb/host/xhci-ext-caps.h
> 

I tested this on AMD/Xilinx boards and didn't observe any issues. So:

Tested-by: Love Kumar <love.kumar@amd.com>

Regards,
Love Kumar

