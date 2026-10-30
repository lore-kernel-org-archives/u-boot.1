Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596F606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s//oRajO;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=Zgkc4obS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D374F40CC1;
	Fri, 30 Oct 2026 14:12:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HS08I4_UQo3X; Fri, 30 Oct 2026 14:12:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 187A240CB5
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793369578;
	b=Y/IZ8IOgM2UX39YabsYvaUC4GC8t6y5SAft+jgAtXyO3QPcWPdxJuho7lu6gXJN66hKc
	 G6iWvekyoIoY6C2BkSUuRm3aAOpFJNwezoa1Uj0H8359plx1u0/TZ4/J9TVe+f2Qv8A+2
	 f3e315K0k8E/F9nN7xQfMpEQBTgOfE9jstqt/WBhsYzUP/+LXa7viBwtKVjkiPKyn7LnD
	 +DJ+E0eUAveFXFQfAc94vUUc6SRIH2pgFmky/EL9duxp/dKolEZkY2qhq2TIf/Cf/luuP
	 zdWggR4G1fd8GbkrritZIqXzrpukIeaYwf9bu4HJwP/9bq5RVe2BWxLggjxraWKH9iw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793369578;
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
	bh=rzd2R1xHNQtIXjgX1A30+uDzCqgiApRHX0eeSR+IaKY=;
	b=VH1dtgTMGjO8egZi4XTv4SMZ8Al0UMlYMl79X2umv+mr03gHVIdAK6T21i/E3BPG5z14
	 9O3K7KopohU6pBXy0La6J/JH5hE6CAd4gG/W7ZTEHXt44w/4eVpDq359EF+ipb7ugypux
	 ygo3X13Cmt6Rr1TplD6duRpnqY4S3jMAKf8zfNI2E5NjjbQ5iDShvDBMGTW6F+imuNe5H
	 eNwIJ0prpeHfc4dkBK8e9KprXmjE6ePZ5f1upfnB8X68uZX2ZLDDFxrJajCnBAE2lWmVi
	 RGyyz/H84IQseOiXs2Tr1jdXvHbPRVPDQI8Km/vg/iJlSqYmKcP4AvIB77JmrsoFc+A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793369578;
	bh=rzd2R1xHNQtIXjgX1A30+uDzCqgiApRHX0eeSR+IaKY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s//oRajOUOQkGlJFEeypLsyQIdj7biEJ2Z/Boq1evOtsoIb0/EENzRJbfiaTmX5YX
	 SLnNkNBiFzDeRPRdAVg9dZLbiSL+kBrxXV9D6WId63Hs6avqwpK16ulmKZ0EIoSd+T
	 GJbM5UaJxj3Few0p7yk/2tQgygVr1IbPqyEI+nJAgeueyj2yl20VpidCMDsKosfXpZ
	 4FV6TCuesEpBqYH5GX2oA5t+syl4qLBOGwpc4uddTfCGtsMF/Gdn5YZPsQnAQV+hl8
	 YipQRnngwJQW5bO+myzQgFDGe27sbnZjDDOI8J/tylR4FP9JJkrh9mMx3hyHSkByHu
	 9MeaDZlCzA4Hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 187A240CB5;
	Fri, 30 Oct 2026 14:12:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 86FB2529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 782F28148F
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:12:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wmC8DAugt1ca for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:12:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 54F1881274
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793369575;
 b=oAlEbAwSw5vWPIs8gIr+ONRZfhYs7cfcfc19k1xcVcPWRKUw8oHZ9irxna6c15co9qeU
 Y5unJVqDhH0qhZpEAW0c07IZlJ7CbAbBKQMEKiGfma1X6kH8Iz8TFZmcVIZh9biL1Jzk0
 LnM4ngi3HUYhNhbZb9Xk0WTQB3oiy0fxNIm12cIBqdfwHmS7t6zKFOxG1qwxXR+icU2XP
 ysvVpKEpD1j/2ziHQX9bL1gMa5vlDRliKC0JKGb/aK4Bxp2+r6US0RyPGcwKEeQ3XhyTP
 UtQeQRoLSMA3EJWgAVJka4etvN9RFRkQX9D4RlFrzA700us4kX0FeBrlbEZTeSb4uBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793369575;
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
 bh=rzd2R1xHNQtIXjgX1A30+uDzCqgiApRHX0eeSR+IaKY=;
 b=MjI6xhq1lr0kZDfst4kj2AX9/etWV+CRIBdLOABi4iplmseexx2CDtFomoVAxxEPQkHh
 12KB0Ed9riBLYr38FeAbzQd0E4hdEo/d7s48eG8C/28DMHEssiYGCQ0gjAtsvTyEGBin6
 uErJ5BU6hLxUH/pIT388vUGb8Cn+7RkRvKNCKOkuGtx9FhMZzXDA/s5HvbrXVqxwee1VR
 /rBAR7HIsoWIwGpr2ShEncwu/nI9BCa3BYZ6Dx0+jqKOq3lryHbGOta3VOIGJ89V0isfN
 /b/NUUPQJfgG1oSjLAplZiBRVpjyYEW6Ssos7sZAzRjPAVCKghEeirCnrlLi9DlPAQQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Zgkc4obS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Zgkc4obS
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 54F1881274
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3sLwJyiKlAbzK6hjN6C7fvgrzZP+D/SQAOKkt0ZeZLG6FzYzV5TQAi9P4D5CmlDAMvZi0l02iU1Pj/P3iDRzZquVIEAGGk8BcGbIVGX7RTrCIOrvMQW15DCXFOxGdZED6Tqa6AWsD4kkaY/ZSzS3E2E0W8V4Mi1rFpTvtBmPypkJGpw2tdp5il8Ksb2VgWHm1U0V5ob7+nO/B9zzpxZui8tQ/nqIF4gycpK++9Lr6Api7vM+xADeLcTkEm+RjY4O4I4eNanXsKyAgh+8EgI9RPk0C87O/ulXNkouDNjirPpliJJwsF8vFY0cGgbGBduq/asEoyUJO7Fmgi9nITwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzd2R1xHNQtIXjgX1A30+uDzCqgiApRHX0eeSR+IaKY=;
 b=muj3uxnjPPpEbyFEfszv5ErdyQiVIEg0uKxGSBQKduC4SWIFakheCUGlMbUAiHH8WwmA9Z4FiO8EfIf2HkpsZJ5nzBeX2cEB9Y6XeiYXhvO1GoNReJ2F4SQ9hfDZs+D0L4pAQ28pAWAoEEiHR78rMI5GO9M2fgNnksiHFdpUg7/dohETS2CrlSM+RlAF1cju7OZAIneaLGHHH/XoZVY6h8hldDVKB0vZRkucQ6aR+Crimp+a+g03wawRSwVqOcbkFycedrGhXFHtQShyw+UqHo+0L9YVswJKIhHlzWp2xNfdNiNJ/1VccrTZ90Y/mooRmAySrHMB4wqM0gdNfhFYUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzd2R1xHNQtIXjgX1A30+uDzCqgiApRHX0eeSR+IaKY=;
 b=Zgkc4obSLk5Gn1NLKU5fUzrEKHN4Jbg3tfHbzvPxsFnJosiXFoAu/y92D6xkG3sjJxxgTxRTs3GoTyB8V+iF4y+9ECo2Kn8qZG8D2NvEiGygKjNFTppZnwyxtf0oWiA/MsYiLjRUt7O+BxmpLOADDl07ek+QVkcyytg8W6VsQwI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DUZPR04MB10040.eurprd04.prod.outlook.com (2603:10a6:10:4dd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 14:12:49 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 14:12:48 +0000
Message-ID: <d0501fec-0518-49a2-8933-0a44a29b5586@cherry.de>
Date: Fri, 30 Oct 2026 15:12:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/26] usb: dwc3: part 2, make the resynced code work
To: Anders Roxell <anders.roxell@linaro.org>
Cc: u-boot@lists.u-boot-project.org, marek.vasut@mailbox.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org, michal.simek@amd.com,
 lukma@denx.de, alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <80e9e892-24de-4cba-b84a-35bdcb6a903c@cherry.de> <as4r8p_70JTOl068@monster>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <as4r8p_70JTOl068@monster>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0028.eurprd02.prod.outlook.com
 (2603:10a6:803:14::41) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DUZPR04MB10040:EE_
X-MS-Office365-Filtering-Correlation-Id: 13abe13d-8b47-4a3e-3cf5-08df368fe030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|6133799003|3023799007|56012099006|4143699003|11063799006|10067099003|261021135927099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: cKLviPYJrRXCDtb3TKxKv0A/JS1dym9SgQZK/fBobQ0yMEcBSg/V3RoJOM1WtNsrTtOcQYC4tzUt4kTOvxhFtjNG2UI8pYR5bFjIifoWQn7rVTmOtSup0tWJJpYrGFYiz3FpkJi4kcobrJDJHOlj7UiYBub3t2E5zUNZLR2TitSU484EXOjhBmSZrxQdZEsZXnVGjqaJVLWXh5AIyMjUp/HuRQa3uqrSTF5RLYrPUuFrrisB+4bwO6PIfp4zCf/0p/qMBaMpDdpOH90mYuUWyOG5F7WCyUHhn+iyWfUgVk/fnfAkcPh1Q/B2cqcaXPLCUSX3LKGKoKngwmswy/J7tCINsbxtXJSYFi1HATTFkPV9UvCiRdpID3tWJIsJzAtJ8IXPwHTFNLVeECnO0sXGtBKaDK/9VEWrk7sy0cjffYOL6cVVZyHFErRoqiQ5J4LWQE6XnodW4Zj+9+jgbbIzgqzrucaggQVszh7YV0VGy2oLFrW6Abct6PqSn9Cdsx71UdZ903+a5k1LwDADD5o9DRGTB3XRZJbJrQzriwZz+QSf1tkbEHMONpWB2neiaBprIfEd2RqbQh9BIHyZSQbKRAB+kf/NR0tef2gaGTdg5ti1Fcf88A3ITRVDzjlfYXpJv06v7nXEX6i+QROtxYJeu8lqcSHyqSVfUJHXIZQxrss=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(4143699003)(11063799006)(10067099003)(261021135927099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFA3bVJuQW1IZW45UVFqN1NJMmdvbjBaQUx4REpCTHBtZkZSWW5nSVc4bGgv?=
 =?utf-8?B?R1RHQVZCYkI1TXlJVENWRDZ3SWtNZHlVakhmcWNwOTQyQzdUM29CTHZmV25E?=
 =?utf-8?B?Sm4xZm9GcDloYTdnZEVVRUpwNnY0a2VWRGtoWkF3bHhNdU5tZ1l0VzB4blVq?=
 =?utf-8?B?blJOd3kxbWFvVTVyamxwa0VDT3oxUndMZFpjbGdZekl0NzBOZjdNWXNILzI1?=
 =?utf-8?B?clc4VHZBSTdqNVN4cExMUUhPZjRwblJNYTFJM0FKVGkvY3JxaUprNEk0YTgz?=
 =?utf-8?B?cWhjMlNCWGhLYnB1a3VMcmZpTUNZaDRHOUtGUExSU21DZnFKNzZSaG01MzFs?=
 =?utf-8?B?U2lxOVVsRGVqTWtEZkVsK3JLSlVLSmp5NGFac3NlZmIwNjJFTGdFUzFaME5L?=
 =?utf-8?B?enQycGlwdmVJMmZ5RG81eDlwM2U4aXdSZWJHK2ZvNzBuZ1FBR1dsKzJ1SWhy?=
 =?utf-8?B?bEtJT0VYd2ZJRUo3VGREVk4zTDFoY2hsY2JNQll0M09XOFpXb3VRU3kxa0Ur?=
 =?utf-8?B?bk8wVFlTTkk2M2lPOGdHU3daOUt0VDlaRWhMMjMrMnZWYUd6UVMrcDdSNHU0?=
 =?utf-8?B?SDJkY1VuM0M4MnVnb1hsL2lRSmgwcHhlbkx5bDM4dGE3dTdDOE9Sb05iQTQr?=
 =?utf-8?B?VzJWbjFQcjdoSXNFaDdFNFoxYVNqQ2J6Unc1V1FLSkQyZFVaclUwaENsL01w?=
 =?utf-8?B?NVRCMFVNNGhrNTBlK3l6VHgxZnU4d3FSTExlK0FUZ3RjZC95Tk0wMGZWUUt4?=
 =?utf-8?B?bWpMSVN6YUpzaDZmVCtBUHVzditWN0xvOUttNEd2bTFLNE92Tzk3WTlUOUlS?=
 =?utf-8?B?WnJkdE5PaUdHZ21FTnJMVGQzb1l4Tk9POEpOd1ZuVXhCRWhrZWJxcDcvd21o?=
 =?utf-8?B?cm03V2hpWXZWMnVLYjkwUmxJMjFMZzFGZ0ZhUU5hZmhoeTlqUlZwSWtxcy8y?=
 =?utf-8?B?U0h1alhscGtVZVFWZ29XQ2NsKzk1Y1NtdFMzcE16YTQwNnVoY0hvdjUwK2ZS?=
 =?utf-8?B?QVpzUEhjbHM2eGNBQ0dTTnpZdExuMVo1bkhkc1RmNmRIMmhrS0EvRXAzUmF1?=
 =?utf-8?B?R0pMTHJUY3JsQmkrenRwbzJEck5YaUd5OHVBQ0VyYVRBK2lkTnZGZ0k5eXZG?=
 =?utf-8?B?Vmx2Y1piUkZGdmpZWTZhaHVzWVlIc3l3QjNnV2M1eHI3cjZwY1ZiY1h4ZmhQ?=
 =?utf-8?B?NU9maE80OFNlKzNRblFLWmNNQ01VQXRIUFFZU2Y5U1hPTDZWbnZVREk1MGtk?=
 =?utf-8?B?ZzlSdzNrZUhNVXBRU1NvK2s4RnF0NFNYUmQ5YjYwdFo4RDdzN0hwRFdZbXZq?=
 =?utf-8?B?bGw3TUxGQXRyZU1WVm51RytBVnlMVDl3K1dyeDdUZlF3SlF5cXFWM3N0RlZM?=
 =?utf-8?B?aHVBMjErMHNhaHBhM1BhNzJOT0hJLzhCUHJiN2E0WmNCVGh3ejZLam5CUktj?=
 =?utf-8?B?NUg0aXEwRGx4Y2VZa1A3R1IyT1pZeWY4L0I1UXpGekROYmJYOHZHa1hhcW1w?=
 =?utf-8?B?alhZK25TZkNVcU03bFVlUmE5UFl0YVhBcitDTWcyVUxlNFVjT09seCtTcys3?=
 =?utf-8?B?eklqN0Jic00vNTU1aXNFMXRLU1RoOHY1Vmk3blp6N1g5WnhBRWw4S1FWTVVa?=
 =?utf-8?B?ZG95T2thNVArcDFYR2xsQU14aVoxdmJvZXNrUWI1Q1Q2aDRSWUJrK3hjaXkz?=
 =?utf-8?B?RlVpaHZQVjc3VFQ1dmFLeGxOWTlzeVZLTjJpYksxY1pmQVJsdDJqSStvYk5z?=
 =?utf-8?B?emdDSUZZVGh2N3YvQzhKRFVMTFVlNUVQTUhhaTQrbnhVcE1nQ3FhQlJ3b0hO?=
 =?utf-8?B?SUpXM3A4anMwMk4yNW9KZ0tYQ3pFNldsVEl0UHJOQTRidWxQRzgrdzVjbkE5?=
 =?utf-8?B?L3UzeFVNWkNmZkNKNXBaYmp3RmhyOVl3d1U0NkZsdkRoZklJeFRxNzlkVHd4?=
 =?utf-8?B?azRFNWIzZU5wZVlnNFV3cjlpQVJmMGVQQ3kwcTVjc3k5a2puQTdWK2duRUEv?=
 =?utf-8?B?eFZXaGgxRitFcVNvdXpRdTBZMVNCRXpLbWpsVkN2K1k0U3NlZGMzRXYrSXNj?=
 =?utf-8?B?TFBUQlJYVVdLVHJZL01wSzF6dHl2ajlGTnMvemZBU3premVxWWNpanhIOG5H?=
 =?utf-8?B?Z1NIZ0x0WlFHbE4yUm80a0R5R0ZmUlREeFpIRGhEV1ZsVzlrRVZIczg5QVdZ?=
 =?utf-8?B?Nm9BUDBFYzMzczJHNW9uY0ZmZDg3QTNSbmVVTUhjVGlvVjNjVnAyR1c1MW9Y?=
 =?utf-8?B?QkhBYVhoTndrQTBub3MvRFQvRzBoOW9QeUJ3Z1RoRXdsYitqZExCNnpyU3k1?=
 =?utf-8?B?cEZXeG1lemE2ejRzaGI1cnl4ZDc5VnpsdEJwYnBjTG1vcnFiWmVmUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 13abe13d-8b47-4a3e-3cf5-08df368fe030
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:12:48.0404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5i3AHAvbFgM+s8zDwCVEb9GaGRg/svv6O1HoN1rmadgmGmvmLIFL58mnKwWokzfnD8suDM8Th6S35wDPsmf8aiV1rvpFq8eoZyThR/QCWdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10040
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anders,

On 10/13/26 3:02 PM, Anders Roxell wrote:
> On 2026-10-02 16:17, Quentin Schulz wrote:
>> Hi Anders,
> 
> Hi Quentin,
> 
>>
>> On 9/16/26 2:38 PM, Anders Roxell wrote:
>>> Hi,
>>>
> 
> [ ... ]
> 
>>>
>>> Older changes are listed in v7 [6] and v5 [1].
>>>
>>
>> I applied both series on top of current main (c92d8c3c431e "board: beacon:
>> Remove i.MX8MP Beacon EmbeddedWorks Devkit support") and tested on RK3588
>> Tiger (three DWC3 controllers exposed) and RK3399 Puma (two DWC3 controllers
>> exposed). For each board, one of the DWC3 is routed to a micro-USB OTG port
>> which doesn't seem to work (before or after your patch). Considering it's
>> historically finicky in Linux, I wouldn't read too much into this. For
>> RK3588 Tiger, the third controller doesn't even appear in the usb tree
>> output. On RK3399 Puma, it does but no USB stick detected (either via a
>> micro USB-OTG USB2 or USB3 adapter).
> 
> Thanks for testing on both boards, the logs help a lot.
> 
> You say the OTG port fails with and without my patches, so I will
> leave that one out of this series.
> 
> With the defconfigs the OTG controller is not bound on either board.
> dr_mode is "otg" and there is no gadget support, so dwc3-generic skips
> it. That fits Tiger, but you say it shows up on Puma. Did you use
> another config there?
> 
Phew, I don't remember anymore. I think at some point I tried to enable 
USB OTG support on Tiger. My notes for when I was testing v2024.07 (and 
thus, likely v2025.07 since I reused them for our latest release) was 
that the micro-USB OTG connector was not supported on Ringneck and 
Tiger, implying it was working on Puma. That's the only thing I can tell 
you now. I'm not particularly interested to make this "work" (our old 
Linux kernel regularly doesn't detect anything connected to that port, 
or at the wrong speed), so tell me if you want me to spend more time on 
this, otherwise I won't.

I'll post new tests results on the v10 for the other questions.

Cheers,
Quentin
