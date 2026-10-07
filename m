Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6778FCA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 08:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27A19406CF;
	Wed,  7 Oct 2026 08:05:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FYBWOEJ-gu8O; Wed,  7 Oct 2026 08:05:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6D17A40735
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791360343;
	b=h+Odta0QzkrVre7E4W94Be8VQywwLWQkerYSn85S0wWJnnWdVsgEXPgH1rQxyvm9nT94
	 Tp9w4mnSl/Jtnl+0ZmgmwjupT6it6x05nObU2ACtHRa9PaZCQvlWKthX0N6vmOzF+NPEf
	 qzaDuGVXlw5ruSZi62LHTrRWezNdsGoslDVh0Sa438iHRwQi1U+MterQVAzPuGfDCf7wc
	 Q7R2XNSXJ/z/QW72hl7VpNgBhPj9x/SeUgx/i25YiN6CHly7ztMhdLi81L86mnXWlTN0w
	 /gfQjX4G7zEv8RNH8n4zZLop8bnWuwKvLrVU87i1X1TtZcTn1RyYnY36Iw9EQRZq7gA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791360343;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=YgmQg2RXH3UqCY/I+kFR5eWhV8CP73gUxeOQSFNTb/I=;
	b=BwtIf3zXEuZaNFhXm3ZLdEhOknRufWb8ml5t19npJBx6El818VZyGAANP6zEe0Jyt1zi
	 utKvHxtbuueL//thDCUtHXQCxcHhEMM14JStqe4B+AWB+BFunjWXpxi1S+9B+DOq/R3Mc
	 MSZHOzDSl4YMg9Pv93kMdQsO6+U5m8rauexkU8mDoPqFtKyzNBuoJzhg6mshB3Zm6AGKH
	 NDgXrHIB9jabrzDbnPMRW66Mi+b5bP2RtUhnybTG/veTbpH2Lfwe6V2oPhKaPkOkDguBN
	 56M6T2+wQJmgac5Aw7g7+B9D2CDUx3s1ammQJjlSAcCZ7PeaOxPqy7z1e2X5aOkahrg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791360343;
	bh=YgmQg2RXH3UqCY/I+kFR5eWhV8CP73gUxeOQSFNTb/I=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R55yiOn0E84I8HgNEc1l/RAchp0ixtf+5RHhdPRzD20aok+cQ2YU57+3JWyJaQVM+
	 Sqz71FDogV5hIsq29XgMismUTOIOJXkOJTuRJ5ljq/QY0XHseA4Tn/C4xWJjMjPwQb
	 mO2keWUXeqHzOJj/KO/uzGbX+C7qYtCYt80ryD0KOm4Jj/LIzb0I9/V3Ek1z6u/WKQ
	 vm5GsxuBFaEm4zcAPjccRGWpPvugiXlvtaDReQaa90V1yFpiE0TEpH/CmwfXxJhpAB
	 eXYm1GftRGn6KmdEnFDArQ6Xybb/XY6DQqmK/6Px4hZYs5AKYw+AKHRefNJdPosePC
	 vXSuNduFlz0jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D17A40735;
	Wed,  7 Oct 2026 08:05:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AE747317
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A01BA606B0
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:57:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Gcjjw-aAVYC for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 07:57:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5C4CC60670
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791359877;
 b=RWVvXYCZw6emo6kGHQtkPsxxe//1PiEqzzpZspf/1tUNDodXuAyNCamlPKbrc6icxLEo
 ojxIGn58Am/LqxJItiJvNQouLdobP1C37KanpDwIo/vv3nLR176ukSXkNuvz6J0girgXu
 g9aGFXRXl5SnKT6nUDG3a3QhCfAXstyE7BvZ9dy325qb8xKFRClY1Q1F05ReeQwY+5Owo
 0zypHf2MHapsyXig7TUfm4UFg/MSlhEGfQwZlNLgTLd1DkcyqchHRSFVKhb2OQxmpGO5q
 NdHRq9FpEqO8Ej9YjTwid1QVFIgc//5Sq/ObO7/5tPzUqF7VGl+RhpUOxMy8n2BY3/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791359877;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
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
 bh=YgmQg2RXH3UqCY/I+kFR5eWhV8CP73gUxeOQSFNTb/I=;
 b=YSwayI1iMS1JRW88mnvX9l37DN9HEHOqEhB7LYyruvWuHShlnw88LAL2bJZ6fj3sCQxN
 wqIRTwhg7h6KbgefzeVoehAV8HQxbOe1wlbyTqXuOgP7wzfJxs46fRegFmda2birfy/CP
 l2Hv3nLL71ykrRumgdANcPrl9DX5/Vxt2tfmhg6FU7JxdDzA0DPeZP0r+dSjDsoQDroQn
 GGx4rrOa46ARhTjjSQgsErdeso+N7zIm661xH/d1UX+efLBnbjFRcIgMwE0ZofPFZIGn/
 ATAU9lqevUbxQrm/KQ58EGYCnjJ/aGsxV6KeV9y+WNhmhuXp6VFUSCqpQ+bnd/j6fug==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=none header.from=kontron.de; 
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=mnRYll7W; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=mnRYll7W
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C4CC60670
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPGQLVSMQ9sQDhsopHWmrEPJa8dLU1l2jZsj3jLvBv9gGvClI+6KcHzKl2Tn5Pv3o5RI6FKrbGN1Y+f7Ji2nRIQFW4CvMxRZrmSMPyLMVe4a158bEZyAVyjKlEsQcnfe0ndG4o9w9bPxS1G3ADGg778t7V1Xwj9FJzidMY0RXErRg+dowMxXwchkozEZdqmyNT3rkw+4mKruFhQtQR5UTTsqOYg7H7JNiqwddJb22q2574192rkmov7BX1deZV3OtwQ7AviVNqlNlX7cTlKnX4MlJ97UD8jtR8W6KI1bIAOauRVza+LLnDqcGgUeSFvHZtMLl3jjPRJwroZydtDuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgmQg2RXH3UqCY/I+kFR5eWhV8CP73gUxeOQSFNTb/I=;
 b=LUOD5NreV0/A5Cch14mJ6ZYU4TwLHzoLY2Je02tc+ixBAez+swNlTO2WJHneQe/iPeTKczZ4QKu01VGgl0GadzT0CMTuHe8/MuPFWjla8ALPmoX/AQrq3enybZt+UgXWm7CYskLN0LFunPTiXgU0KXGeg9yOiJ1pvPhL/KbK63XuL+QzQ7p1WwwJ06qgnkvBsGksBlhjfya+2wLRiqZ6Tfztt7qvVq7wjJr1TYtJrA1eyZTD55FomTXGSvfWRp8Uoxr/AKCP8qxUq8yvTptPXP4zWAtexXus8yR7f/w9Fyg7oxHyw+kFLWhDisYtotDRVIhGc43b/SrWU+x48mWNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgmQg2RXH3UqCY/I+kFR5eWhV8CP73gUxeOQSFNTb/I=;
 b=mnRYll7WnZNTZrZyidtqwU7MPgNl9Jv2UXGCIGAqaNYKe9X0Q0hBXEJ2IBiwyJ6z+oeJZHxa/Y+0J31DyRagIPFzH81pdTysAK1arRnyRs+fhz7RXoEE+hJFL+a2Smp2lasw9puXGc+vKesdi1r4GV4gMncjNk7SP61c2P2d8KLcHmEAs17W6WAknTPhp/TtwD0TMtgkUiN2ZIFzoXqBzvLIlAW5c2j7yDIFpVIo44oEJaj7sgobEowxCF7GjwP98ciGZHAGDGUqSbeHLQjV3U2aFcMiqXWEN7nsqQ96q44cg9aj9wk3Fp19v1FqN+CPGqEYApxV5SfG0ov9b35axw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e4::18)
 by DB4PR10MB7421.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 07:57:47 +0000
Received: from AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fec3:eb34:f163:4536]) by AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fec3:eb34:f163:4536%6]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 07:57:47 +0000
Message-ID: <c528bdd7-8f87-45cf-9ff9-dcef2109e99b@kontron.de>
Date: Wed, 7 Oct 2026 09:57:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] spi: spi-mem: sync code and behavior with linux
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Vignesh R
 <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Eugen Hristev
 <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, u-boot@lists.u-boot-project.org
References: <20260927235716.1872707-1-mikhail.kshevetskiy@iopsys.eu>
 <20260927235716.1872707-5-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260927235716.1872707-5-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1e4::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR10MB4273:EE_|DB4PR10MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 8916803f-3dc2-46ce-d1b9-08df2448ad62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|7416014|921020|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DxrTS0excqH3/8W00rLrAmq1xuHsqL55SD1ShTTdXRFqZgVqQU0OYak2NlBu0Cy+Sd4ZQEsiW4o7Jl1tsSgPBrT7CGQnGYIJyvcct4jNH0K4GnLElj8upR7sI3DS4IJCCuW9Qou9dl1pw09kXi4GziJ2avEoCbQsrejaqk2JVPYV6fOOKRZ4S4ozljmy8UUjsIifZ2whYptjBkpyQvC218pGwdwGzp7kvDRLPXmpKNjHtHZhLlTJGti8iAyjwuWdXfzVFkYu4FfEV3yMRIfUWHqd1GWqNfBTVSZhOpRf/EbqM5GtHckXFQcQmzQhTJ0IWlFfaPEBoUoTZ0DUHrd0myO76jhbmx3JFzkfZ3tYRTbPeBWX3mdLfCtBMwUd6x/6ZXcg9y1cKsyahDgSLVnUJw89wZi06HWVWFc9k6jTzVyVfn0kOaZ3ZVeyIEW77EL+dKCsGbg8O/3sRSuzDzTgYnDQajnMGXFvsj6TO03sfxA1Y1AEJQI15qE0juBYoTV/aBBWz+hDhHz6q21LYN3UMrny2HsMCOVM+prLSleBeKkRJiVyR2HUM6JiZX+w6E/adp1ZO620Kx8MnI8Ebfo4rqruj5oMKb8uFpNMpi56YslS0titNkEH7Q0FUpXNcQ5+NhWaxArGyFB7ZxVECXcHOqtFbPFP+3x5zzA1YzA02hJTm5SmWZent5+i1P81MNb9EKXXnJJioEzMyF0EJirLNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(921020)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1RJbW1hYWs0c0I0M0l6NkVRZFlYOFVNKzVjNHFVd1ZwUTRnYnFDcnNNRkVU?=
 =?utf-8?B?MUgzRFd2MmczRzdIUzkrbUlQNDZDdHhFZnNwQWJhL1psUWRWbGxSMFRVTGlz?=
 =?utf-8?B?bTV3ZzZ6M1luS0c5OTM5d1B6RWt6Qk1XOWNzMVZheVNSTWV0SlpkTitIcmhQ?=
 =?utf-8?B?RnY1QWEwdW0yOStqcUpCOGNWWmVlSVpmU0RRTFZhcDc4Z1B4b1NnSGU4UVRv?=
 =?utf-8?B?REl3YWZSYnhvMldmUUJSbi9EWERaR3V1YVFJam9EdldIV0xETWwxcm9IQWtS?=
 =?utf-8?B?bWpjZWdWTzdYWXAweXpjMHBLYXFGaGNWc1RSejFOVUxNK3RvK0g1eDBRbWJk?=
 =?utf-8?B?akpSVWtxNittczZ5Tm9tU2k2TWtmK2VhMTZpOFhWMUc3V2tmOE9TVXNRTnpS?=
 =?utf-8?B?NDBOaDhvamVpcEdLQzJkVHhxT3FFRWpnWDF0TlNGdG41a3N2NXpvVWFpbUth?=
 =?utf-8?B?dWVWMlZ0L0h4U05oa3FCVFpyOCtZVXhjV3dlcklBd0dMTFBESGhCYjFIUGVX?=
 =?utf-8?B?TENTZDRGeWFDVjJsdGl1QXJ3akQvbzBuZ3RncURka0RuekhhOXhLL1JBSkJw?=
 =?utf-8?B?bm9udjBUeENYZnh4VDU4MnlrNlFMOFRyV1VpNVNFc2Q3cVVBVCtybkFHYlBL?=
 =?utf-8?B?SWVMYWc3Zk56dXE5Yjduc1BMTWl3WkFzUDBWT1VMTHhsbFVSR2prb2FUTEhN?=
 =?utf-8?B?YUR6SVdwTjRwWEhaSkdjSEdJbHBPTHFmZ2plZk85SDlpTTBadTFMQXBzQjI5?=
 =?utf-8?B?RmpaaTFLMVRDTzRVZThUdXpvY01vbGFyWFZFNmdsN2w2cVFOUXlnR0FNbUdz?=
 =?utf-8?B?OUVDYWx0dlpqeGlpUXJRNVBIaUpiaDJNajlmSEhSMWNtNGovMDRia0haWjQ1?=
 =?utf-8?B?RXErZW8yTU1uUEhOWTFPbUs1UEdoeFlXVWVKYS92UmRkMWI5NzBFMjFLSGxP?=
 =?utf-8?B?aWxzdldpY0tmNVE5dFp6akRPT0xPdGs2d2UrOWEyT3BFbjFLUEpzVnc0R3FL?=
 =?utf-8?B?N2l1SHVEWXNzL3c4M3h2VTRvUGNPRDlIazhZYis2Y0dieUIybzFnc1YvQzlq?=
 =?utf-8?B?UlNId0ZYMUxrUGhBY1EzNCtVNUNPMzNnZE1jSFBITTR5a0FaUWNvcFdJOS9p?=
 =?utf-8?B?N3F5bGFoSVRDaUNsdmhYWXhHaVpWUWtZcHQydjB4TGYyb1VqMmlMRExZL0xM?=
 =?utf-8?B?NkdoVm9sSVIzKzBQUnpyWSs2bkVNcENGYVAyODkzRDN2Rkxack8rNmV4aU5j?=
 =?utf-8?B?OWE4eHRmOW0wWVJXQU5pRW11dGVFNitxSmliVGFvZ3o1RlJHRC8zK1gyVnpa?=
 =?utf-8?B?UVBNSWRmOWd6YWpBRmxNMUkwMmJPUW5VRVlFSFJ6cE16cFRTYVNoVUtPTzdM?=
 =?utf-8?B?ekdSbVlZeUZucHM4eW9oMDRFQXRyQ3Z1Y3lsV0Y3MEl0MmtDQ0ZhNjQvU0lz?=
 =?utf-8?B?S0tDOGtQaXk2THh3VWZaRWRJWDIzNlhZV0NCZGFtTjNBUTJQVUFJSVlZVXMz?=
 =?utf-8?B?M2tEbEptVDYrN0lmcG12MFJkUDFieHpOUG94RG0xSnovQkNJNGdGZ202N2JZ?=
 =?utf-8?B?VmRwWXV0d2IwY0VaODNITFhWQXZDUnNjNmMvS0c3VEZEQVRnQW5NTjVuTm1r?=
 =?utf-8?B?OEI4Q0tpc2hVOCtqM3VTaXVlMTdMZTNCRmYxN0NBN01TaXVsUWRINHJIaG5m?=
 =?utf-8?B?UGQ3VWlrWGRzVzhJNXJuaytReTgwMkhBZnJkZTVTOGtBaFJwMXlOZ2JSMTJB?=
 =?utf-8?B?Nlo4Wk11ajJEM0ZFcU1JbklLcDJnZmRXaGJjUk9ZSytIWWxBOHRsZ2dJRWda?=
 =?utf-8?B?UUl2K29YREtxL2ViYWNaM2JPSHhaaTRoVU5FUHQ2ZGxDQ2VHdVEwalBpaVkz?=
 =?utf-8?B?eEhOMnlYQnNlWGNRa2Q4eGo1azgrK3NoUElCa3psL1IvOUVlZ01VSWJpWEdt?=
 =?utf-8?B?ZVEzaXhqRm5NS09kaElQZ0FsczBuT3JPRWtKUVJ1TmlxeEhjN0h5TnZ2Ujlt?=
 =?utf-8?B?cXFiYmFEdkcxUlNKMk05YUlFWUQwQXcybW4vYlRWRUpmdWc5TGdqWWxoaTdp?=
 =?utf-8?B?bWFJOVo5bUdoa1BLWlRDbnQyblRMMFVpTHJMSmZGMWNHT0xSZlFGMHZxQi9k?=
 =?utf-8?B?b1o4c1M1b1VHWkdlY0VtZjdDR1pmc2lzcDhzY0pQUk4xdGw5Tk1hUlR4ckx0?=
 =?utf-8?B?TFF2T0RFZUhkVllJSHdLMUQ0cEpFZVdQSEs4NU9CTDBxOFRVTkI2bmpEWW44?=
 =?utf-8?B?ZnJQYkxsWldPY1U5R1F5bS9ydWMxcENPdWpNUjZPRG9MY0prK1VFQmM0NGV0?=
 =?utf-8?B?SnNZNjhKeHdURVZmSEV6VTJuQ3hlVnJOUUFiQlB1NWJkS2dNRlVPVmRMV2Nn?=
 =?utf-8?Q?jiRPi5opPzqvkRDc=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8916803f-3dc2-46ce-d1b9-08df2448ad62
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 07:57:47.6951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AYrLgsIl1P8dz1mCI+MzatklOTXXeIsgyJGuytNcM6C3VuMWtG+C8wsQDzszNTSLBupch5pDF8bo5mZTa4TfW5iNVuWFJioTQz5JtzOJA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7421
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

On 28.09.26 01:57, Mikhail Kshevetskiy wrote:
> Align code and behavior with linux-7.3.

Better mention the exact release (Linux v7.3-rc6), and if possible
mention the upstream commits or pick them directly.

> 
> Changes:
>  * add comments
>  * use the same error codes as used in linux
>  * add more checks for spi_mem_op
>  * add macros necessary for spinand dtr support
>  * remove unused macros
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/spi/spi-mem.c | 65 +++++++++++++++++++++++++++++++++++--------
>  include/spi-mem.h     | 26 +++++++++++++++--
>  2 files changed, 77 insertions(+), 14 deletions(-)
> 

[...]

