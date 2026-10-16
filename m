Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAABCCA490
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 15:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6D1E80FA6;
	Fri, 16 Oct 2026 15:59:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5K9YbTBvT0ko; Fri, 16 Oct 2026 15:59:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E3BBF810DB
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792166397;
	b=mp6Jl90i6NGRpW3M9eu5CQof9jw5OrRSd4couWxRPmZqZQ2pk5TlFiVuXuh+EJgkazdG
	 LL004Z79WPwMBKlmyn9QDhC8Afa2Z7UMNMefLscHEmn7lggMiKi8V1ykkimgYkDyCAxof
	 yiCCYzZK25dCLhr/4JUXtdxz5wXWTNfmlhVpdEUsUAoPHx6nRBj1pjClJz+x9uMhUH2tm
	 wDj3Apg6znTOroH3lxWWigi1Mbhy5G2CXcz933gTwbp/khiE6IEzqV/z8bwTiHctHK5dm
	 laboQNUsUZfJRhAqIj+yw/NmfWblKO9TlBRZEkLnAhUnF7ycQ7VxvReyRtzSVxad1jQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792166397;
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
	bh=VkBJmyTLh8B6UQfRRaP0i79VVNELD5e6CdnoDmRq29E=;
	b=obpPl7kaRTi+bsOUapcoSztr/kgFTG/nqn6dVPklo8OilYXRWS9lQ5Qjv74q1U+vjnU0
	 SQRQd3wDQ5t52NbIDbN5ZJoXyNRmAO27mQjmn46TRWhAk4bGK/fOaX1iW2Pjx1JwFwhVS
	 nhxUMFfDmmM7IktLYDdUxYLxNo8pPoJtNaPzjPJKsBHdH4vShySM2xirLrgH9ViVANqDD
	 WMytAVeBsDImFDeiV3rL6YSyI9n/swrkfun6xtPsxgC8ntUBj6chlkmqWZwzG+dmPuseY
	 25/1OX5iBBQj+kkWf0e/fT2mDBxY/1d3klr76T2L3O38XEYeV7P4PtCQ3MEA0fSm2bQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792166397;
	bh=VkBJmyTLh8B6UQfRRaP0i79VVNELD5e6CdnoDmRq29E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xb+dPo/RoVGUiHVPip851F1HTRfA5gPrDjPRcBySW23ce+iF0pbVYNrzeSj2AuVuy
	 kcyZSabBYWHkE6eCY6f6DPlCEU2F+kUU2gEb9P3Mm2cwIy4cgwqPTppHfcsUUDxZ22
	 653hk/yD1pEekRkFiQAeHKjX2BzUUo2o3xMkFPWOobwpdosmbM0lDLcOaisWFLRYTc
	 +hjFC9E57jcvTMwEZouNkHQQBe80dew6dHSrYCXXf/52clZA0xrqgLPftfBQxITj1n
	 +wyYGsexp8qoQ9mLKIVq8LedJ7/lxz+Q/tVBslPPwTRDuQHLFh+IfVNY8sRomfNorz
	 kutDQnPIhSm1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3BBF810DB;
	Fri, 16 Oct 2026 15:59:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 290F975
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 15:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1AA4260B22
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 15:59:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oPZXlYa-FRJX for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 15:59:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BF6CE60B0D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792166394;
 b=IZXQGQW1MJe5brByYEfseq767/iWKs63EkIgFSBxIFn4YtyudKurzDB4lRfL8C8wDOsv
 2VLBvd8/jsEDI2sCErzZcSCmiGRKXMrJNiDRMVBj6yX+37BH6vCESbLJS7zys6gm9wpMw
 0vKEDodRzqRqokbzU57MZIXbUB2nMQIaNDTjoRXfMbjRuko5h3j1QvMFZFOMuItYFsqle
 0yCYQJbNdO3Qm/DDt2zlTB0kjxq6ARDEI9pOMpti4ItluHmpSFuTJV2xzMKCVDjNKpZNf
 Mg+daPPVWp23kFI3YsIZs7IwvWXj+0kbqwAPiD4noz/6shYHaEr2Sso3W8XKpWpKyOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792166394;
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
 bh=VkBJmyTLh8B6UQfRRaP0i79VVNELD5e6CdnoDmRq29E=;
 b=W6xx/qId7/WYiTQKDBqbAs4EU+cT69XLJteGh2dVkfIdr/ylt/xsyVzyifNF6MIjjrby
 p+EBSdYU46o8i4Mk56TFrIdLpBd0c5X1o4spdVgIcWAhlzH7PlBITu1IrrdVUcV2niYXS
 urgFcy0IikCKO3DchHkpW0TWvAcn2cdS8VTd1cexYbjuLuFHgC+p36IRWoG8j2vmlNrET
 +F+kZS3WqiLgqxTGDKWWpwQuVC1k7FxulK5woqOCMfX79STcyUAhwn2KilDz/L7PHrWKY
 NWWzZf/CxR7jtSuLob9X9J/TUjFAgTLxkjxG1m79zyfZ3xrBM8KebxT45Lwz1ARAX6g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b="SOXbhBn/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=SOXbhBn/
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF6CE60B0D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 15:59:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQVx+3veSiS3LfrIRqCQk0BzU5bvQmhhnC7iOFbBfRXiNcbdysxze3lpEyn4a5wH75Mwmb8QTC7u4MWAeXjV6XYK/MfzXS4zYhHRCZj97ikD6v1epVDqBEsZ1RGOzK8kwxjMjXyRENpvhl5oL1wiLHxk/i/MXvi5PxBNAPSV9j2AwtsGjRAPDSUHscz7d1B7fb5JkNzcMT4d83XygfWRPrH9xbVKdlJ4KqKHSsL0+aRaEOZCIF7pwGVRHeoSa4nSeBxzknOGlmjiSoXoZk1uPKud9JRmCGev5Mp7CqeRq4tnDYOnG26BLLRhq49/LoHuhpv7n4S5oHYR/lgT8E9nPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkBJmyTLh8B6UQfRRaP0i79VVNELD5e6CdnoDmRq29E=;
 b=Uc9vX53mALowEmMQWojlaHfSXKtqIVAeZSCllHHpCgpLJLJEEyBAM3q9tRzwKaUpa7grcQYjaNimu8GeiOkwcV8LWFrbm+We+0QHAwOZNDVMsshJpfxtMungXGMAwf8jJHc+Em17kGerhHU4n7KGujOfZ/L54tjWRPgo6T/RAo6cDJmgSVB8/TJvF+1joO+pUqUvT5G7MYRs01/u0BXp5XGjisyS6WtFFCN0gOIEyR5rc3OhoyqJfLcB5wkYjhMotysoSOHMXq6IBt72URhgPG9IUTeRLGawJ36/e5xbRtei0of6nhHRq3YJODNVf1t42rPTw5y3YtsVmbCULl20Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkBJmyTLh8B6UQfRRaP0i79VVNELD5e6CdnoDmRq29E=;
 b=SOXbhBn/ia3Tbqlc35gw+vQC7wO56xPfSuH00hXR2aEYnuWCHN4STH3HZMmFz+956z9r7tHCuaAk26VO2livajWonLrxPVH2ak+RiY5jzmIqeAnJa7OwqHYX7eyQZ7oS/c3Th8isBsS33LqPAJ1xcINT7jK3KFSZkhm2LzB5FcM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI0PR04MB11547.eurprd04.prod.outlook.com (2603:10a6:800:2ff::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 15:59:46 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 15:59:46 +0000
Message-ID: <6009c6e9-2e59-483c-ba08-d7acc6e6fe03@cherry.de>
Date: Fri, 16 Oct 2026 17:59:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] board: rockchip: Add FriendlyElec NanoPi R28S
To: HystericalDragons@proton.me, u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20261012-nanopi-r28s-v2-0-3d162759dd3d@proton.me>
 <20261012-nanopi-r28s-v2-3-3d162759dd3d@proton.me>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261012-nanopi-r28s-v2-3-3d162759dd3d@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0902CA0043.eurprd09.prod.outlook.com
 (2603:10a6:802:1::32) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI0PR04MB11547:EE_
X-MS-Office365-Filtering-Correlation-Id: ea260463-26c3-4618-41e5-08df2b9e8026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|18002099003|22082099003|10067099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: klYWR/B/RpBep85JwdF6AdNS40jbgid3MgI9kQlsgq4+8916pGmMhicnOxACfM/mPmavDfYHddXG3K/Rb8JvMf4hos3gLf1bwZvK8U3UdUnsgjRq59VMRzh8NspLpoQlaaqowD5RavFoPpXdz9nWpiHY8dbZv9JKsm+fLAaqntYGHnYxov6dEdRHxcQME4NWcml8Ti1V2Aeyclhj7KH/kRJtbbY008sA7k8lC5IiW/JnrM24WHBmqwCmcnCXIXJOq7uEPyPTO7Tw+Fua7YZPlIsU2WSQ9cSoBjjKKbsaf5Z6lfbGOIF3295KQo9WblTQvVDspKA0BhxcgCXmhSQcSs0vWoVO5OCT4Yq9gefoihv9S9DarkzNvghXsXo3En2pvi1HsqKFFSWMvNjZznETpFVaxO1HYfKyrjXWMPNiX9f555gD6qZ1nVBOV2hzqn9xAE4j4hBEuTMnBGPLtEQfBjq33bbsXyfKvfUq+90n6CplxySxVKUUF5F3uu/89djs925bRJ4NU/gucs3CPdS2LSGe17POR0ErhRr12zTFDa4tqVKuGRemZ3AquSydyf8C/rKmUs3GGJdNEMpL/EPlHQ205kBfSmPft0Cl0DL5VnzZdzUurdJ+IckJjCPZsbpFBOb6TvTDCW8jbzEjlR3PejtsGvQfOrPlnDmGqgJzTGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUJJUDdnR2JObjVTdW1IdHNnaytVVVJUeFlKODVzOFk2b09kUEhwSXdQcEFv?=
 =?utf-8?B?OEUzM1E3TXU4WmdxN0FSblc4MnBubHBwRnlEUXFHUXdkUkNWZmxFekhYTVdR?=
 =?utf-8?B?WHZkeW52VDdwQ09zNzRMZGpUMXJ1N1RVN3ZTV1ZsRlVJbXBob1BvMEF4U3pK?=
 =?utf-8?B?Rjg4VEpzK3J2bXBNSUUwUUh5dTgrZ2laTGhLb3h3Yzk1RVo2ZlZaS0hyUUtK?=
 =?utf-8?B?Z0k4NXhXY2tYOXVROEdlTVlTQ2dJTUFiRWk2OU41Mms2MEREVEdTRmhxMVl0?=
 =?utf-8?B?MUxjVXJ3YUt0YUtralZmV1VOSjFXWGFlejdTVXdvekZ4bXowc2s0TENXN3o3?=
 =?utf-8?B?dVZIM0VKVkhDWVYzRGdaTEVkSnNBN1FtbHFGeGJIZVh4WWdWdkRUQXlCTmN0?=
 =?utf-8?B?QkRpRTBtSHpWUnp6Q0FLenJIZEJpZnp2clREY3RSY21tQ245OUQ5TTRvYWxN?=
 =?utf-8?B?TXh0VnhVUjZ2a1FRY3gxMXdRMTRvYmxnWmJyRFc3anUxWElTNjBOT1dpSmoz?=
 =?utf-8?B?WDhYQzIvdUVOVTIxeEpxMlNraFZCSnBsUUUrazc2SDVnQlpoTzNWdWNtSDVV?=
 =?utf-8?B?dXVudysxWGQrcG13TkloTTdnbmlGT3BiMW9hSVc5eFNvd0Mrd2krZzhxdmpK?=
 =?utf-8?B?UEtqeTR5RDYrVk1UT0dWcjNrTXk1YVBhanFiQU05Nk4xbVdzWHRxUWhQUVlY?=
 =?utf-8?B?R21lMFg3TGJsZ2lVNmFjVE5OY2tQUG83bHJhOVQyTlhuNHVJY0RHdU1nVUJC?=
 =?utf-8?B?d3JwOGRKS2M2ZW9Yck93WUE5MW9iRThpcnJla2ZvRURXS3J1N3ROL3UwS2Uy?=
 =?utf-8?B?Nmk2WXJRV05SRGRjb05GZW5FOXFyRlNCdG5vN2pWaVZxOHEyYW5jNCs4M1My?=
 =?utf-8?B?MEV1TXNjNXhvbEtiRjNFNjVPSVRTTStnRzFhTnpwUVZLK0l4MEtlWkFvSWlL?=
 =?utf-8?B?R2U2N1A0ODc3dXFFTlZEcWZSdkdzMzFnQmsrVGdLY3VZem1DdGZJUk10bjBp?=
 =?utf-8?B?KytlTTgrL3NDaThodjhvWmExY2Nua3pKY2ZBbXkyNUxGU1pmTnlwTnBNWWNm?=
 =?utf-8?B?WWFZVCtySnl2Y0paZC91bTltNHBjNnd6cUlMK3NKRjJQd09CNVRIblFYWnUr?=
 =?utf-8?B?T0I2ODVUVkRqOGhuRXhjK09zenFlSlZ4eXFpUkhMdXlWeUxYRnd0QWUvelN0?=
 =?utf-8?B?UjVTbzNFMVVPUytwWFZUVzA0dzZHVUlTcTlma1NETTZCQ1dtcGUzNWk5YitP?=
 =?utf-8?B?dGJoUTNvU3d4QzJSM1hDVjdqS1Bqc05wTHl1dlozZVEveFR6b1JnakNpckJo?=
 =?utf-8?B?R1lZdVQzUjJoT2dUUkVCSVBhUlNBdG8yQS9KY3BWN2Z2dDFhQXFjOEprTXY2?=
 =?utf-8?B?L1RpU21VeVVDc3dra3FFQVVIU1dGZUtDZEg3SFNxOVpLZGwyMDBsUkRwb3Y2?=
 =?utf-8?B?d21Yb3RlWVA1cWpIeEUrVU8zdkR1OE9wbTZyTHZHWkZFLzRHV0pkWDR0RUF1?=
 =?utf-8?B?L3Zkd2FNZSt2OVpLbWppNTJwaU1sTmNSeDlIK1k2S0FMOGNBVXhCV3B1NXhG?=
 =?utf-8?B?ZWxnQjNGclRMSTVPdFFMYnVDeTBzaDc4cTdmYjJGaTJlN0xuNGMwcWhaS3V0?=
 =?utf-8?B?Y29GTGR1V1NtNXkzcVBac2hvZWg3V1FzUHBScldwcjBES1A0RG1ZejNrREhu?=
 =?utf-8?B?ZGNqNHNxbGtmUlBxdFg4eW45ZnR0L25oSm5ZU1UwQ3RZSFNMdnJUQ3I3WGYw?=
 =?utf-8?B?MlJPZFlQbVZwSS9oWHZINldUVCttM0czSituSWZBRDN3d25QV1FCdTBtS1hD?=
 =?utf-8?B?S0dkZTI1S1cwUkwvYXNDTk1BREV2a2kreUc5RkR0dkcwSER6cmE1MmpUcnYy?=
 =?utf-8?B?U0JiSEtFdlV4UUFNQ1dUZ1plQWNxQ1N6ZXNBVWpQVWFzL05WRWRRSUNTSmlt?=
 =?utf-8?B?U1Q2cDMycGVVQ2RnUWVFc09OdWl5OE5LUnN3M0NYNmZGVXkyMHE0UUZvQ3c4?=
 =?utf-8?B?TlByblRVa25aTmVtUEFrMG5QSjlnVlgwdjlJNUp2MSs5V3dPclg4NUhjb1A5?=
 =?utf-8?B?QklmOWRjUEYwWENmclpIVGNwMzFENDgvbUlzbjY0ajdmcXlETjFzSWZ0bE5N?=
 =?utf-8?B?L0dlSVowbUtqTXBGYlB5ZWhNMktpRlB0eUJibUZMOWxpMmRwcGNsRnhCQU5M?=
 =?utf-8?B?NUhVQldDOFliaDBseHdMZE1BdHo1b1Y5aU1GN2EzNjRtV2VxT2diSEtDdDNw?=
 =?utf-8?B?eGtHZVF3dzEvdXNjMjBxWmprWXZaaGt5TDBBaHZTMHFPUW40MXdPZVU1ZkVR?=
 =?utf-8?B?Mk1Qbnk3SDI1cEJXZDg1YUZZQ1kvL0NvUm5ucXJxSkFxR245aW5uUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ea260463-26c3-4618-41e5-08df2b9e8026
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 15:59:46.6498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzE8pWLdGvYakF5UBazajI1hBd5UzVrzTaTluCqL9AR/slKMonAIWIpPiF6WQAh7FAlRIc2iOk+bASBt7IYIiEY9kXcoOunq/hBo6zqUXME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11547
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

Hi 安容,

On 10/12/26 3:22 PM, 安容 via B4 Relay wrote:
> From: 安容 <HystericalDragons@proton.me>
> 
> The FriendlyElec NanoPi R28S is a dual gigabit Ethernet router board
> based on the Rockchip RK3528 SoC. It shares most of its design with the
> NanoPi Zero2.
> 
> Specifications:
> - SoC: Rockchip RK3528, quad-core Cortex-A53 @ 2.0 GHz
> - RAM: 1 GB LPDDR4
> - Storage: microSD slot, optional onboard eMMC
> - Ethernet: 1x GbE (GMAC1 + Realtek RTL8211F),
>              1x GbE (Realtek RTL8111H over PCIe)
> - WiFi: AICSemi AIC8800D80 over SDIO
> - USB: 1x USB 2.0 Type-C (power input and OTG)
> - UART: USB Type-C debug console (onboard WCH CH340E), 1500000 8N1
> - Buttons: user (GPIO), MaskROM (SARADC)
> 
> Add the board to the NanoPi RK3528 board target, which selects the
> R28S FDT based on its HW_ID, and enable CONFIG_BUTTON_GPIO for the user
> button.
> 
> Features tested on NanoPi R28S:
> - SD-card boot
> - Ethernet
> 

Considering we only have very little enabled in SPL DTB, and the things 
that are are identical for both boards, this seems safe to do.

[...]

> diff --git a/board/friendlyelec/nanopi-rk3528/MAINTAINERS b/board/friendlyelec/nanopi-rk3528/MAINTAINERS
> index 67f14661087..6665e35309a 100644
> --- a/board/friendlyelec/nanopi-rk3528/MAINTAINERS
> +++ b/board/friendlyelec/nanopi-rk3528/MAINTAINERS
> @@ -5,3 +5,9 @@ F:	board/friendlyelec/nanopi-rk3528
>   F:	arch/arm/dts/rk3528-nanopi-u-boot.dtsi
>   F:	arch/arm/dts/rk3528-nanopi-zero2*
>   F:	configs/nanopi-zero2-rk3528_defconfig
> +
> +NANOPI-R28S-RK3528
> +M:	安容 <HystericalDragons@proton.me>
> +R:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	arch/arm/dts/rk3528-nanopi-r28s*

This means you'll only get Cc'ed on mails touching this file, even 
though changes made to all other nanopi rk3528-related files will impact 
the R28S as well, maybe just merge the two entries together?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

I will likely forget to pick this once the 7.4 devicetree-rebasing tree 
is synced in a few months, so feel free to send a v3 series once the 
commits are available in 7.4-rc1, or to ping me once we have synced with 
7.4 (likely for 2027.04 but I'm assuming you won't wait that long :) )

Cheers,
Quentin
