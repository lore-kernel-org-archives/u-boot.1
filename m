Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780EBC98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F87981329;
	Fri, 25 Sep 2026 13:59:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6YWIZ1elwBhi; Fri, 25 Sep 2026 13:59:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 871D481327
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790344754;
	b=lJ1ii631Hw1t1WMt1TvU0LP3kGGPglueljIPXtCGNMJ9Eyh4HrECQjsGIH98feq7aDk+
	 Z6wP5DXq/MFscekPIHFNLCtrdce9gY6rQMSVJAcWxoE5r+xqz1v6iIsv13jxT7ZJY//6n
	 mfzpBUSILIDnhGFHWJQ26eMLsz3QFyVZI8uRPmF6Xv3I57jhfrct++DcszPmLHwLGyPiF
	 Elw0RhHSx223mORoWiL9+w+FYZvRCeNSE10c837Y/z636GQRLss2nfepm49+XejEJYgUp
	 NrVRpMhp2MkwLj0nTOs63iUmowtZLNJAQctYCaRiayIBZ/bchQVBgIG+fjdw6pTw1iA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790344754;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
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
	bh=ZYiNY+i3n1au4pwqGUWnoNYJEdHD6QMTEicVstwbmW0=;
	b=LHgEK11apuqYNLmAxVHJ4Urcq93BH6vYKBbMmxUJ4HeJYGhYBbCr+gNEnV2DsLoAYDtq
	 6GKCVzRHXtnBAqLqQxv4FQHkanxlsg7ZUN9ZnogCoFe/McuL5QTKINWppU7Lh+VGCF1gK
	 PGWlHLeSEqzs6WuaiWYMuvCU1QacKInRAzCTTrzUEhcna78iGaMEfohTvjQTTg9aZQ11G
	 Lc9s29AOTkOUHtNOXzRJeffozXm+Sww+/4I6qcmGw7UFLU+fWWIMQJAV8R2BKzP45ewJG
	 W8VbSXMdKBnjCL8Cl+YrxwCMASksaDo218Q0JZVA5RL8LF9riKujNfuDqr/WLyX1BXA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790344754;
	bh=ZYiNY+i3n1au4pwqGUWnoNYJEdHD6QMTEicVstwbmW0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nj/hceELIncmrjt4FKyMHrgzUP6kfLnwlNOJlerwOcVaifLKUZSCWOBG7/jUk5y+/
	 F9FwIDXSkTlfDX/7uadFImgBmrPqb6DJim05xPAgpopJDD1ic/WnyYjLFwv2CpMDQ9
	 LHe3tIofSyEx7rZFmuD3c05vHl3c7c2K0Za4YyXhLRCWgJ2kZoMV4Iqq3wdCm18riv
	 jBMyvK/GAcAI93PAR9crsBMTZyod9gu1LWiUY31snasx4MdQ7aZs8hggs+C2jQbk9K
	 BrJULr+11XeS404rrM8NsY7oB2wbJ+FlRUW2SPrG9ywiRgpeRRQQriJeO9Dx/mV+rD
	 S/6Di61dbg4oA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 871D481327;
	Fri, 25 Sep 2026 13:59:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 08898332
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:59:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05D3240CBA
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:59:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XhzNviar5JCc for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:59:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E460C40BAA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c110::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790344752;
 b=Gkkcvm9XbqGo3ZILTxvLFlrXivWjJO0WmcCTtH2AxmPh6gE1b7QFIZTY9+0nFmOAZg2k
 stDYVqz1l0xQ7V5AVhcMgSQAC6r3PuhWqsqQcvY+I5kCjJ9N3Xg+b+qP45Xkoyn8f0ru0
 Haiqak+xsRHbnN0oS5yCnyFgD8UdqpUIMyj4HeTpoIgWpK14W60rFacifo8HUx01GDFy4
 D+nMDP1goAmXkk0bFPdgsRVe8gBZDr2oKmIYtUxCZ2IjeZ1xzv6HKdlrN0KRrR9lSR+EU
 QK6SvFFvDMk78dUZQX1eGhyT/Qt//h6rs1ovhj1jSS8AvdRBSFkKICykHe9yvx1aPyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790344752;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:From:To:Cc:References:Content-Language:Autocrypt:
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
 bh=ZYiNY+i3n1au4pwqGUWnoNYJEdHD6QMTEicVstwbmW0=;
 b=UOpWsUtFbyAh6U3hMjb59iUjZb83Veyj4tIpu61E/nk8wFlk5TZ3FjHtWd+UVe2cbOyO
 ulXtKyRQXvaVmxI7Z3z1EmJFo5hnSazFOeQ+AC9bPoQm2xQwDpD9PJpE0b3cT3Sbkm97r
 vTNvgP9QxRNN1RR0QppgvV7qD8OnO/86hbG8h5RmhNVHCNnX6KFy9K2DAmqGvKgrogt9g
 l2UD/Ra0IucyEjskxV4BEN3ynms4/aq2wfZ1qpA6wCeuJLjdJWxAf6PJq3adkDFsKe0RA
 mvPj88cy9HwM3tx8uOo7lXutcnhbKSYeHV1FGPGtMg9G0ERa0FmkjaFcSRxCJip9+Pw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=YfVDV+fQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c110::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=YfVDV+fQ
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E460C40BAA
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXzBk9o1lrm0Lpfb7EPi5pIn6t5yloUv1aBPcQMo4S2YlFP86wUH0TPoJm8qfKmSJA1tCWC8IzPxCdZupw0fmj2ExmyWnzhw6QduC+3IlU6JLilcLSh71Gjnvyy4l5oHUl6MyWSJkNA2oyIiHieCK6YRisJgLepjUgxsECz5iAddyfDuadUo0yOseoL06TDmhzlFcwItNBdkTHPln8vcyqrLHgGUH4E+OB1sj2WGixKvGvQXNBbBHr7izMFcHt2JJk+S3qYZAl2v86W8GuHo9imUYIqhTqtjzptF3iRqpAiXHNKGxUqpmiFgrg7hXGJ5CYQN3Ja5d5LOmT1sh42H3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYiNY+i3n1au4pwqGUWnoNYJEdHD6QMTEicVstwbmW0=;
 b=ZUSp1/tBH+2FT22SOLyzLRTEIi04fL3io/bDXbhaCuyCnStU+5T1sC7BP8a8/vDluuQLTffjQELzeGWMr8lexZ3O/AhhMl9VOS9qPIZ5oGBd4PyA6SWFwzhn/7UJsHeGRl7kQBmdOkHzWb8LYsAS10dYolzbg9/BJ1ZJrhyc/ZrVgU21N4T5wQiKbTG4lUxZMwvB203YkxaMXg/Xi7adww7C2JrSqnvbHZUqEVdjbFQrgUvhsMEueXfy6xZQTrosKzP6QRl6ixxx4TvWp92yd/JYfTshBUuMbvqAXQleWf6zBILu6sAUDWYWGz4/s3Ql7MDD+zYcm6LOTkmryb6CJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYiNY+i3n1au4pwqGUWnoNYJEdHD6QMTEicVstwbmW0=;
 b=YfVDV+fQZ5LbL0eBt5IkgP8al8xtvyccQ36Y62nKnPKu6m4986UHm9AUX2eTx+WrvXd0VhO6bov+d2K3F3wWix3wNv1QkD5DKwec4cDseWo8fGFmNAcHOH4pGMgS9Z0Vf2HB9CzlrIsNMURnfKBPkMFU3e48oBTfKWlNhVvMPdk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:59:05 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:59:05 +0000
Message-ID: <517e7127-496b-4485-944a-37afa235f0f7@amd.com>
Date: Fri, 25 Sep 2026 15:58:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: zynqmp: Remove fastboot support from SC defconfig
From: Michal Simek <michal.simek@amd.com>
To: Pranav Sanwal <pranav.sanwal@amd.com>, u-boot@lists.u-boot-project.org
Cc: git@amd.com
References: <20260915041855.1957186-1-pranav.sanwal@amd.com>
 <442312ab-f612-4227-97b8-fd0e740117ac@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <442312ab-f612-4227-97b8-fd0e740117ac@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI5PEPF00000917.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::925) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 82dcdea9-0cae-4709-36e3-08df1b0d294d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dRUkGW2T6LtLKjBuExOjMxDx1hNm/f6ptTeDYsOyu89jOZar54PqIWIBCGSjNSghYVkPLUC5QM804vwJL5LQSPLIpczk6ZZMQAGQsREHvGSyF4MagJrtVmzslNJyEWUYgQxiE0Rj4cOAcnqxBBZpmn+pcQGNyhMdf/LkDy+DmDX19U46o9VsLxsc3yIAR1Ucyo5ZvPVmF63EImJyVWA0BhHEJ8ueZebf6M5n4CXnESXPVYf3vZj9QLgG7YD2ZR36HHg5d/0//JtJsRrKoZR78C7B2EUdFcExWKGxeGu0hy9O51cl2ajVuESHtRlUzc7X9VpR2Rr0AwXnPfWXDAlQaTHY3w6EH1Eso0kUr4AKZnjcy1brCiwl/1H4xEybtRCQYwyoW9kPaikBRDcr8rvC8WERkgvEJuvjaYxyQXe1U18QV7PPyOhW/GQSPhIeC3rIHla7DmhqQJObmP8duudNqs6RKsbqYLdtS8MMri8T6vWj3Ne3exYO5GEDMzwXlLCNjEuvlfFDOh+PRgHpjRJOz08hQPJkemKSdH6cqCKhRNCXsMVgrQWZme59fhHZ2byrZQBLUKmya3rSwmVw8r+ZJwMf8palSvgAys2zb6/zOfdbz9Eu894oneb7RQSboRqdqjK8hsi3z2N4WaFR+ryodoDetSITu4QhMgT1as8ldig=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eERVbHZNU1dVdUNFTzRSZjYyTys2cEMyeHFmWFpjNTNLcThlQXQyYkNYVEJX?=
 =?utf-8?B?MVJ3NW1TbFpzQjhLVW9oZDJzTFNyVWVOTERHY0hyMFl0WHNWRndZSXNMalFu?=
 =?utf-8?B?OTZ1QXdXUm5Yb2p0WFZSY3pCbk9ocURPWFdKVk94STZiU3VlZCtOaSt0aFgr?=
 =?utf-8?B?MDBNK055TnRYbVk2TFdEK3pRMEd3RDBJMW9WOXpRUS9Ca05QQnpkTSt1T1I5?=
 =?utf-8?B?cDhVVUtwdENyK3VhUThnbEh6eGNLY2haSk9zSnFZcXNTYys4V0dya0hwb2t4?=
 =?utf-8?B?THdZeVpuamlQbld6QnZ4QlZFS1pEa0wwTU1lOGlZVk9ZeDdWVDhxbFRSNUJi?=
 =?utf-8?B?L3V5NU5WSm5SNU1EbEJSWUFNTHkxeHB4cStGYTB1U2NIbEZLNjlFSzg0M0Zr?=
 =?utf-8?B?bThpWnQyWFpXQStkeWxkdVdlYk9BRlBRSEJHeWJFOGpSYUZjcVJpRWp6eWZG?=
 =?utf-8?B?V012TGFjdUxLZExybURNN1V6a1oybmYzcENTM0xUb0hScUZvcHRNUTd5N2wv?=
 =?utf-8?B?MXR6M2pJWGhmeVFQMHJrSk5CeTVTcHN0c1g4cDVPWUx3cDhIcHA5bXpvRWlw?=
 =?utf-8?B?Zy81anJWWGxsVWkwaEVYNlE5ZFBjYjdhZm5DcjF1aGpXSWFBWXptVVFPT2pR?=
 =?utf-8?B?SHpNYXU4VnRDNXJReGtTSGRlcGxPR3BjUDRLSVBnc0swdmJGYlUzVkkyWlRi?=
 =?utf-8?B?KzMzN3IrS3hxdE9HU1NrdUg4UTRqb0cwV1RVb2pZcXpGN29tQURTZWhQbFo5?=
 =?utf-8?B?YllDVmIrUGlYTmFhQ3JRN2NoU0RKZDVIUC9PZ2w5T1pFUnhaMlVkUXY3bFFu?=
 =?utf-8?B?TThDWDNpTkxVWXJ5T2VORmRaVk9nejdtaVV5QVNRT3pKYW1CeWF0WlVwK0NJ?=
 =?utf-8?B?dmE1U3ZTem1oTjFUN29NcEg5bURLeVJWV2lrenhvMkFrVnlkQk5HeW85NDhW?=
 =?utf-8?B?REZYOGVTSkdQdDF3ZkwxMHhkYk92WmRQSmU5MWlnYUhnd2VrZnJHb3VSeHBU?=
 =?utf-8?B?dG1KNFE3Y0ZXV21GRTdwbktKamZleUxtR3hBa3pNLzBCK3BTK1lvRUZodHV4?=
 =?utf-8?B?SFE5dnlmRklqRG5ldEl2cHRHc3ZzYlVScDBWb1cydGUwVnpYd3Z4dXNIU0to?=
 =?utf-8?B?Wm9WMVBZMzF3UVF5S0JQTG1vZTVrNE95RzBUNS8vNTVRWjlQNTdGMlBVcVpI?=
 =?utf-8?B?RWtqbXpQTkhVWUVqa3hoSHVhcTdnOHIzczY5bXErTWNIWmJKMmZIVDNYU0la?=
 =?utf-8?B?YUVNVEhXcDlvNm0yMVl6bFZxRDBzODA4R0FWazZsVlVUMXNaUUJHWHBmSFUy?=
 =?utf-8?B?Rys5U2p5NGsvT2tmc0JMTHR1eDlZVitNYjByalV2WWVCVXhrTHl2T0p5Smgv?=
 =?utf-8?B?ZWs4OWdSQWpxTytOUUdtc3dQOExGTzNSLzMvM1dDbGU0TytCQ25pZ0NsVmVX?=
 =?utf-8?B?dm9mT0ZXNnA5ektkRlppV2I4U0Exdzg5NFptcVBUbkdiSEowS3lITjdPT2pM?=
 =?utf-8?B?alJLSTV2WkE4K203eloxc0RNYkJzRWlVcDFidGlIUmt5Ui80N1pCMElVdXlX?=
 =?utf-8?B?L2lza01lNExNNlZzR0RTbXAwVCtPLzhJRnB5cnhtSWo2NklXZU1RRXAzOU1K?=
 =?utf-8?B?NGN6c1UvRWZHRlNvdEMrejIvblZFaUZ3L3FBUFdnQ3p2Z2tSMlk4V0txVDYy?=
 =?utf-8?B?K2RBamJNdWVLMU1rU1ZXaUtIT2dOMjJ1RVBsZ1N3cFRqbTNwQ25wWTdGUzVE?=
 =?utf-8?B?cmcvd3pJWUdMQ1EzVFUwaW55dHpvRGYzQ2oxL1FVS3hZWXRKZTc0d3V0eEsz?=
 =?utf-8?B?b0ZOc2NtMi9qTjdUY3FMYndkNk9JY0YvS0QveDk3Y1BuOGt3T3pEbnl2OXpv?=
 =?utf-8?B?eWpoY2dnYWZUMkFMc0J3Zk00RHFBc3FnMUlqaDNwM01wRjZrZlJkL2kzNVJL?=
 =?utf-8?B?K0U3YzN4dmpUVksyNE5mb2dEQ21QbFIwNjlIWEROQWtuR3ExbmVPckQwNG9E?=
 =?utf-8?B?ODhYczRFOXpzTVo2clRoZjhhYXJLOVB5Zk40U2NGWUxDUWd1R0pwbU1ISlln?=
 =?utf-8?B?MDM5R3RZTEVjNWU4MzNSQ043OW96VEd4SjJHN1BsUDBaTEl3Z0JkMzZLRXd0?=
 =?utf-8?B?TG5rd0N2SXdkdnQrQUtheGg0cVhYSklNVkJjc3VRbGxlRExzc1RMbU1YOGhm?=
 =?utf-8?B?Sm44TUFJZkZVQ2drbnRrRXo1V1BXZ09FN1dxQ1Ryb1h3aWFQdlJjd3hzSnUz?=
 =?utf-8?B?VVZoMURwcFRTSzAwKzJ2RlUvOUVIdXd5ZHdPVTI2OGFYbFJVL1FraDBOVWl1?=
 =?utf-8?B?ZjlVNjFNbk95bWVjUk84bWV1T0lYZ3BXWkpBUVd0ZVhCZUM0WCtGQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82dcdea9-0cae-4709-36e3-08df1b0d294d
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:59:05.2221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkYXprDdgMJUU2+Zfwtk8Mn1ONPK98UlHzP01pp+5iFJsAe+0Db3A7x1vHGvURY6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA
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



On 9/25/26 15:55, Michal Simek wrote:
> 
> 
> On 9/15/26 06:18, Pranav Sanwal wrote:
>> Fastboot is not used on the SC platform, drop it. Remove the
>> USB fastboot function along with its MMC flash target and OEM
>> format command support.
>>
>> Fastboot was the only user of CONFIG_USB_GADGET_DOWNLOAD on this
>> platform, so USB mass storage (CONFIG_CMD_USB_MASS_STORAGE) can no
>> longer be enabled either. Drop it too since it is unused on SC.
>>
>> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
>> Message-ID: <20260912100752.743411-1-pranav.sanwal@amd.com>
>> ---
>>   configs/xilinx_zynqmp_sc_defconfig | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/configs/xilinx_zynqmp_sc_defconfig b/configs/ 
>> xilinx_zynqmp_sc_defconfig
>> index 0a05cbb3f76..554cc8808d1 100644
>> --- a/configs/xilinx_zynqmp_sc_defconfig
>> +++ b/configs/xilinx_zynqmp_sc_defconfig
>> @@ -77,7 +77,6 @@ CONFIG_CMD_SDRAM=y
>>   CONFIG_CMD_SF_TEST=y
>>   CONFIG_CMD_SPI=y
>>   CONFIG_CMD_USB=y
>> -CONFIG_CMD_USB_MASS_STORAGE=y
>>   CONFIG_BOOTP_MAY_FAIL=y
>>   CONFIG_BOOTP_BOOTFILESIZE=y
>>   CONFIG_CMD_TFTPPUT=y
>> @@ -123,10 +122,6 @@ CONFIG_DFU_RAM=y
>>   CONFIG_DFU_SF=y
>>   CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
>>   CONFIG_DMA=y
>> -CONFIG_USB_FUNCTION_FASTBOOT=y
>> -CONFIG_FASTBOOT_FLASH=y
>> -CONFIG_FASTBOOT_FLASH_MMC_DEV=0
>> -CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>   CONFIG_FPGA_XILINX=y
>>   CONFIG_FPGA_ZYNQMPPL=y
>>   CONFIG_GPIO_HOG=y
> 
> Applied.
> M

Actually no. This defconfig is in upstream that's why don't understand how you 
should create this patch.

Thanks,
Michal
