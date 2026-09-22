Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6F2C982F1
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 06:03:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3632640718;
	Tue, 22 Sep 2026 06:03:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iq7lute9Y19I; Tue, 22 Sep 2026 06:03:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 44148406E0
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790057005;
	b=UheAb5gOUwQB2FGsWNxsvk9UStucpagGVUFV6zFE59OXIUqDRDWOzxjnQxFBVdMd+Nag
	 +e64xSX1ExQbqdxnzA3HhKxwB3qYgEFPtkdqzc11wiPooM07tdKKc/HT4VFPyrLfi3fnk
	 wOj+0iRpdYWqVg2e7nIXQgQsanyqPSQ2IfxZQkSh3EWn8k7zAaM2RYtAL2jXqhXSR3IM9
	 M2HhmpXXkrUlwHdiyGdZZiAleRMkd+7ov+FrWQo1t4zJUW45LsjE/CiD0RpmHtqglB1qu
	 PbmLdBL1PtE+x9iM8yVVuTzuqZovDaMZu/4S2+qNKaCp/sS6tuvCppRSIZX2mmC03kA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790057005;
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
	bh=9wUWp7cPxT0DvFDSiFb/Wjtim+/7+NsRLK6ao7waOSU=;
	b=KhrKa8Rix4fQTUOTHOyNwQeAyHnBWI/j68MInq0OyNMHsdzVyPv41mVVFCna77G07vVk
	 UoCzLOgkNNwy4jYr/yyUnQUOcVzrnhTK7nrn/3c279QhRn7Gp7gi5mSW4HFd0/mM1hQQN
	 zwfabsso9rw+kAc4xCWWFdNpA/c8ujvSkmlc//aX7PhWA0K3FJv8R8rzwms1Nz4dQAbah
	 suBQsVVt4E4jW/JI0jcRh1AQITMSfRSxJAaQUgYLBKrbR5CG6yDyaxfdE2EYi/Tj2RrTM
	 lxdyxpmpRYwFQQvPXafundA57yMbkdOUMmE5NHQhMdyGzHId2ISYbAHIzNmDxjqJqwg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790057005;
	bh=9wUWp7cPxT0DvFDSiFb/Wjtim+/7+NsRLK6ao7waOSU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YVBe8H+pHcdB4HVv8/84bH2PytIAYPoNrwPhrbyodzJK3HpB0eCsgy2wPHWs7Eok6
	 gAepXIIGM3vlrdqqE0c2m28KCih1ePQDGAg90bTAUMUwRup6lxy9lIeMaciQL9PNuF
	 WvkW+Fs8cw719r7KsRDvwk7Pa4lq+yN1gHeaMUWq9+P/aeeqkq8nPjl25KFj2GZ5kY
	 Kf6RtVHR1oLfQGskx6ySVo42qO5SQ7QF+9W7wbC98vNz34DjGVG5nlSkWD4hwRiWlS
	 i39cxv2ZMvp7y+1lLpfBXJcdKd7AtmXf2rAgk28bObaR5sJDBZM6wuCNrfkZAuQ+v+
	 LVc3iBLo3Mllg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44148406E0;
	Tue, 22 Sep 2026 06:03:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 76FA5472
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6884360662
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wnbzEe5VzuIs for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 06:03:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 400616064B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790057002;
 b=SFttpUQEwaQHrIGMLyqOzkB5dSlmb922P75TZ4+woecpG7ycmZrNac+fJW5TIu3TdmkM
 riVt9oTxQehsOCmbGRMYiofBsRECC61VDp215TOCo3WMdcI0YkauTCIoYXoxCq8AzTKyC
 mMljChxCcYORTTPRkeKUCXUuLKsGSol73rNAkWd958Obx91a8/x4VSZBS75/G1Bk9uU5w
 AC9yQnbln9LLatp4Vjj0bE4hOcUNbZUydNS7yxncQhGnhnvjGUtSDuodyx5G2qjAudVcl
 /a13+ChA/IEaf2LkyvrzRWF+3Q+PDYxBelw2g9xadMCK5E+HjeARJJTzQk9LneQbrDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790057002;
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
 bh=9wUWp7cPxT0DvFDSiFb/Wjtim+/7+NsRLK6ao7waOSU=;
 b=ccZJ8hkOy4o/zR0oNXKQ6kvdjB/FrDH3tI1itQZNfQZW5dXFyZKg5DAHAmJlMIt2FDsU
 i9PT1zs57W/ysLnBkLuCQbLFzaVsBVVY8wT9K4wS8QG477yXL7brghiuta8a1OFJz6FkS
 dOkdib7K55aFB119iSSc4iwgb/WieAfijrcZw/lCAKEBTRk07wIOLzy/h5TsUh3wasJ+p
 PAMC8a7ppajyXhCQH3B/idbJjPLqgkA2fmguJdRhNLirKUi21i3kvPiJlLlKMLtrEz6Yv
 wyKuQkj/4Hb/H2covUqZ2GYK9pYCvYPnmrKYzEOPWteL2w4pumkmWs4521J5wV8VneA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=VCBadWed; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=VCBadWed
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 400616064B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:03:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syiXcCi7+PsDh5s/W4cT8l7CJ63NoIIZERxwJBjtcClXMAXCPFhQdf4jz86pq5ojCi7Ccca1nOYXqF5fRk5wiEpERp+DIMbyIArcnTEzvpaAHcOY72ZbCJwQuiAiit66Mwg/634Eo7KmGMm1vn0Wio39Dg7YC3qO5BriJ/eRKGqpmfDQetiDXnZ90Hh5q0hH9Nl2Umo0gnSPl68lLjFrpxXglBgoKrpP22yAu7tdW3bwAtcsD1RoWMq0mwFiTS/qBOC5nodZwhw5rLJHf/FcXFLXHWv21fif0AkvI8POjvWAIvvy7G++tU3QZz5EKAmtbfYJ/lLZEzPDMjzAAGjEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wUWp7cPxT0DvFDSiFb/Wjtim+/7+NsRLK6ao7waOSU=;
 b=nNRrGAtu1hNifOV+HhrKa6CwnT2EMinxnCvUN4PCMHE0WO7AlthLdte3L7Ek4kxA5t6ZTvHSYg8B7dx8kqgbs5miNCd6NHnZcKYnYcCMl6m6zD5U0kvPYwupb9Rs2AStd33l3HBSntwimMKpmxsPqksIwVrFIxwjcZ0StVR0TIWYOWwHdefzgwSqFXfEwJpfVjfhteg9NGiVY6WX2sXqRDANYG9L4sBEsuZlOLyMnevWNML2BhK2B/QHTEFO9jx+kPoqEcwTsAweAMKzXk/tN21GXTCNDrOS8psfcu6q9bYlC+8Qvg7w+6JjlRiYCgJ82vT6ZJ+H7jmIczReNgbRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wUWp7cPxT0DvFDSiFb/Wjtim+/7+NsRLK6ao7waOSU=;
 b=VCBadWedxbRA4rCWnqhSHtREfpRK2rSbBxMAE+ZPLxICBdR6sELQ892dFB/xDBLfQFTzPv82uej2XrZwOKLLWznTllDXTwRwKK/5c7pxRX4UGjYZ6uqiFQVaAKX7Z40JYREybu29l1QjSOgEJIoZe+cQigkpe4ALNCLUzXZUvR1bCQTFd9kHfni/nsSoLQFHjcr1ekbJT6TKqGnB1BZ7DVelM7wq6DjWQWHJWXo/HPOO6I9eB7cvXGW4yW0gsXIls4+pWciWpNloZNzoEAaZGCvG19nIIAGrbLKyVdoao6OcKUQ8hb7eyxlLgWMvhpqiXEOCpO1/1BQPEgMfLXqLRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA2PR03MB5804.namprd03.prod.outlook.com (2603:10b6:806:fb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 06:03:17 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 06:03:16 +0000
Message-ID: <e8cfb6a0-37d5-4e7e-a1ea-101b70ec9b95@altera.com>
Date: Tue, 22 Sep 2026 14:03:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: dts: socfpga: Add MDK support with external GPIO
 expander
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>, Tze Yee Ng <tze.yee.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>
References: <20260609014817.16401-1-alif.zakuan.yuslaimi@altera.com>
 <9f2963f6-8a3b-4ea1-a9cd-41cf8fd6f345@altera.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <9f2963f6-8a3b-4ea1-a9cd-41cf8fd6f345@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA2PR03MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: da2e161c-6655-4639-0457-08df186f314d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|3023799007|4143699003|10067099003|18002099003|6133799003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: hdld7DpNGhQED9bd2uEe7L/LXa9JQD2gfNxLqIQ+Ky87yavZvKcmRNjqQ/Bc573BgVobniKNyC93NURQ3odcv77swQRTQK5snwcWT0u63FFTLelEpcSx196uboICjjPDGvNH7FBl6pc8vrHYJ5D7AYNwNKNopiw2rrmr5ih/sYy4+EJqPzDd9Li5twjcXHWEavlWpIHWU3XYVe8K0SH3O62ennI8R5d1h/Nd4bSkytXjUHXKyDX0Aszde0kHj5Yl65zozeUFn8a7I9T6rZI7AtN83wCKPGt6fSkmQX2tiFRUCc6pEXlasz7ZFyH9xJcGxePpHxoolH0kGlp2aeNnnsqdQ0ZF/RV+ErACUdlhktPHgLhv7ORilnz2zlGFI4yA8jxypx9vRVZPDZg0NYSQbXhc1MnF7Aqj7NZu7QEQrxflIq12zy+PIyiRtVLYR6tkpAKNJzyjDe7eh0xi/p2lRmOlYa/kOkDsyE8wchXyjJFk6eHd6Jr3O4erHkd7a7mBoGA2lfNqu4scTiEr5hY1Obook/TSPH0kdnCFPPsYg1jUHZlH4RC2xuvd2Adsto7R2KaRsNDpbBTVvBYMuh4kPVN7Qow6+mUKYIyjneBXlat1t0fgiV1ll4JD+RVLdpFou1rwyy32UG6xLJyJNWd/zF5VpD85NrPUy+SPn9ltzLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(3023799007)(4143699003)(10067099003)(18002099003)(6133799003)(55112099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2NoZ2dxMjZwQXl1bDU4cnN5T0hQN1NWT1g1eXpmbG1SWHF4bXZCUnhIZmNT?=
 =?utf-8?B?QkwwR2hIRzlnMEp5M1dNODlGU2dkR0swcGlyOEdsa0lmcXVBMDk3dFJUQms2?=
 =?utf-8?B?Qll2YTJwUHRYSllBTk5zVDhqOUFmR1lVTThJSTN3RGg5OXoxNzJpaDJOVmZa?=
 =?utf-8?B?K2M1NHI4dDhMYWh1V1prcFQwOVVMWUFqSlp5ekl3aFdEcVBRREYvRWQ5VHdy?=
 =?utf-8?B?dnd0SkF6VnU5d2N5TFlONmdCYTVsaVl2NWpBQ1BCOVlYendzVlpRdnV2UVhI?=
 =?utf-8?B?Mi9TR3BOekR0UVlUOGl3cm9Gc2cvTlE1VHY3ZEQ1S0hGNGw4OWl5VkdZNDFG?=
 =?utf-8?B?ckdGc1RRT3VGSDVrKzNYeTZlZ2oxUkdDOG01UWNRSzlNVUl2MUY3Y3gyYUEx?=
 =?utf-8?B?TTdHQmtLb05pRTg1MFFHMkRCcUZ1K3RzWmZFb1RVc3IzSVZPaUJzQ1haby9X?=
 =?utf-8?B?OG0zb0JEWkt2SEdzM0RzVy9PNnBvM3lleVczQTd6WEVjYUpQYlY0eWxtSktR?=
 =?utf-8?B?Lzd2TU9hWDFOaWFJck1MT0pRQVlrRW9vT1lHRHhZL2ZqMjl4bytuYmh6eDlN?=
 =?utf-8?B?Z0tsdnV0aDM2YWpEWk53OVpvYTlhSjNDOFBiQTA2a1k2SnBWRWZFRkZLMFp2?=
 =?utf-8?B?YXVCOWNUeGVSbnB6ZXoyZVNzUW1YVGZ1M21xSTl5L09oRitkUHVVSUNRVzFm?=
 =?utf-8?B?cDA4UjZGTFBNU2NIcFU3eDFSQVF6QTUzQ2FQczZrdkx4OENoR3cyZG55SmlC?=
 =?utf-8?B?T2w3NUE4SHNvaUJBNnZYQTdDVGNhMWtiRzIvSERaS0FjZy84Tk5xVUcvQlpw?=
 =?utf-8?B?SWJJRmFZblJCQWdqMHpnUndrOS9LVVc1Rk9tYmZ0Q09rdm1GRENsKzVBOURh?=
 =?utf-8?B?emFMdG1sYVkxYjhTbHpkOFN6V0pSMDlXMUhoeVJRV3NLKzdIYzJsN3VQTC9U?=
 =?utf-8?B?MThrbWE3RnJCWG9oQzdCVUhJdC9BcWxJWEJCekt5VnhzV3pTMUVvT1Y3N09I?=
 =?utf-8?B?U2hXTXozSlFXTmJPQWFYaElWSCswNlBnRW1zbmZFbXNTakpYMHZIZ1FpdTRZ?=
 =?utf-8?B?NFJPckJYNitmeFJiWnY0aTNJRzVaZ0xOTCtZU3RLdjBTYjJjS0cvcmxwS0Yz?=
 =?utf-8?B?ekVvbEVTa0YyTVdXVTlCR1JtNWhFR3F4eTdYZjBhYWVDZ1dxd29FNkpUMUp2?=
 =?utf-8?B?eWdwU0kweHlWa21WeVhRWFc4ZXZDb1VLUHNHTG9ISm5pMUxxZzFYeW5PZVY1?=
 =?utf-8?B?c3NXNWwvUGkwOEhzQlBXdEQzRG5QT1JNQ1BsbWRMVkkreExtWlV3elArR0c5?=
 =?utf-8?B?djQ2bjJjbFNrclpQQzRYVGlTTlVBeXdDQVNCWjdIVmRJNTQrY3pkWmk4cWRU?=
 =?utf-8?B?Z2ZWMjl3QzVETGg3dC9zOXBJVXhJUk9aUS9BNXJvTmVwQUEzMXZ3ejdpcFND?=
 =?utf-8?B?V1gvQVczQy9zZGw2amVrOTlIM2J2SHpjc2ZMTk1RR0pDbHN5dkZvdFFKdmZR?=
 =?utf-8?B?MUZ4b29Vc0tSMUttQ2l5VUJYTnNrMVhOZmc0V0tIVkxwL1ZEN0F0dDEzSFAv?=
 =?utf-8?B?amtrTjVJOWZUaVhwZ2dLeTZoSWorcFpyVXpOb0kyM1J1ZGxZdjdST3NCMU1T?=
 =?utf-8?B?bTBYbGNESnYzTUFERmZYMFNnWktWYzdOZmVqL1hTNGh0VGxwT1BNaTJiTWtI?=
 =?utf-8?B?M2o0d3JTOEt0NFJZMG83eng0OW4vNGZEMy8rd296clhMbzJ6cTR6OGgzYTFu?=
 =?utf-8?B?YTdTcXVEcGJCVnZuVmsyYUFVM1JIY1dOOUI5MW5WUlkydkJTdXUvalpWd09K?=
 =?utf-8?B?ckNLdlg0ZUw2RXRFQWZFZ3BuZFVKOHdTWUNtdHo2V29VMjBTaCtvc2ludWsr?=
 =?utf-8?B?T0Q0eHlTSE1WMUlqR3QxdHp3b2N2cnVOdWVFcGN1WEZKS1c2NURDWWNXSXBX?=
 =?utf-8?B?Y2hvTE4xdXdBYUNLODRzOWtkeml1SU1MVWU1OWNHTnlKSHFtV0VnSDZlSWNm?=
 =?utf-8?B?RU8rS1JlNW9GYmZaS3R5SVFXWGRPQi95VU5CcUVKZElldnR5Z3F5QkFTdXE4?=
 =?utf-8?B?ZVg0dTlnQi81RlBnclhmajh2UVB4V3FZL3VBSEFSQzRBa2Q1VTV4Wmk3MTRt?=
 =?utf-8?B?ZVdYMllZZkY5ZnViRXVmUGhYUXcxeVdaVjZJUEV1Nm5iLyswaTZSdCtXRjht?=
 =?utf-8?B?aXlKamViNkg3VVNTZ2svT0U3ZGtSWFVvUFlZdHN5N1NGT2ZMamRiOWQ0STlU?=
 =?utf-8?B?V0R5T2dwblgwTDZFWVNkb3JMSHB1VHMzd2dKbzV1Y3pZZ2xBaU1BaEtGOFp4?=
 =?utf-8?B?bG05bWU5WThPTUxHUHhFTkhuZDhDV080T3VGU0JNUkkrUTBGMEZ6eURWbkdW?=
 =?utf-8?Q?RLZMxyVHsG19PENo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2e161c-6655-4639-0457-08df186f314d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 06:03:16.4229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9kyZ7XI7clGhcYuIQ/zHn84Wf4x5poEZ/8bQlblwErCvq+FmyxbTmjGMu7X21AhAlEI2nvYj/tnHio9xzIJVq+grNG99QhAmL6rspnld9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5804
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

Hi Tien Fong,

On 18/9/2026 1:50 pm, Chee, Tien Fong wrote:
> Hi Alif,
> 
> On Tue, 09 Jun 2026 09:48:17 +0800, alif.zakuan.yuslaimi@altera.com wrote:
> 
>> +&mmc {
>> +    status = "okay";
>> +
>> +    no-mmc;
>> +    disable-wp;
>> +    cap-sd-highspeed;
>> +    vmmc-supply = <&sd_emmc_power>;
>> +    vqmmc-supply = <&sd_io_1v8_reg>;
>> +    max-frequency = <200000000>;
>> +    sdhci-caps = <0x00000000 0x0000c800>;
> 
> Please also add the Premium SoCDK UHS capability flags next to
> cap-sd-highspeed, matching socfpga_agilex5_socdk-u-boot.dtsi:
> 
>      sd-uhs-sdr50;
>      sd-uhs-sdr104;
>      sdhci-caps-mask = <0x00002000 0x0000ff00>;
> 
> The Cadence PHY timing properties alone do not advertise UHS modes to
> the MMC stack. Without these, MDK will not match the Premium UHS path
> despite the commit claiming the same SD timing / UHS-I support. Please
> re-test SD UHS on MDK after the change.
> 
> 
>> +#include "socfpga_agilex5_socdk.dts"
>> +
>> +&i2c3 {
> 
> Please override the board model in the leaf DTS. As written it still
> inherits "SoCFPGA Agilex5 SoCDK" from the Premium include, which is
> confusing for UART/boot triage. Something like:
> 
> / {
>      model = "SoCFPGA Agilex5 Modular DevKit";
> };
> 
> 
>> New files added:
>> - socfpga_agilex5_socdk_modular.dts: Main device tree for modular board
>> - socfpga_agilex5_socdk_modular-u-boot.dtsi: U-Boot specific additions
>> - configs/socfpga_agilex5_modular_defconfig: Modular board configuration
> 
> checkpatch warns that new files may need a MAINTAINERS update. If the
> existing Agilex5 SoCDK wildcards already cover these paths, a short note
> in the cover is enough; otherwise please add F: entries.
> 
> Please send a v3 with the UHS flags(and preferably the model string) 
> addressed.
> 
> Best regards,
> Tien Fong

Thanks for the review, I will test these suggested changes and submit v3.

Alif
