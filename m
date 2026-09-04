Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547AFC624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:46:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA4AA60BBA;
	Fri,  4 Sep 2026 08:46:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0fczudQb252O; Fri,  4 Sep 2026 08:46:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E6AFB606B0
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788511564;
	b=KP1LmmgYeAbYeovo77RTJGM4nHu/CEbBmTe11MJX/6dGdk7wtbE3FJ+6CIAXybrribf0
	 LKsCiXXdwxuY1gxtISZAz2R/A4UPXutpog1HAeUdHJa9V4Y3c4PF/Pdxw1abzrYSPPP5c
	 dWdVSbg30CiGJJOAEXeGNNEXbb/sQVD65WJ9EWmTWwKmiljKEKKXEyPjxaMV/U0WyEtPv
	 DjqHnZBzT6as++9B4Ul3qFntAxGRkrN4MtiwtJ/1cdgiUEMmKNIFKZjBF5JzsZ27+Hh7r
	 SFWjZHKJ7TZho1W9zxPkd7vgRbmHIqMORGMScNM5maXdVqhRSWTkzB+OwNi8cIzNkKw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788511564;
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
	bh=xxBsXNuGadQv3/xH+1UrOzHNWhSWtnl8Y6XT1zs0XMY=;
	b=Yi+Rd2u0i1hJkQ2JviZtTPYGDTuJaKEwjN+ipFIvRaYiSbNs0uyt1re8yCxYpFu7TUkZ
	 l+Jp3do4FL8iPlCuXOLQCeVVuY/1saVhlDrRUoO6yALFhhXOBu5r/aI7eI0pxpwfpgMW5
	 AkKC1Me+fXBn8ADK2CXb0RqHmsw1Q3OAAWWOHtIe1jQOYmJByCutIbdvhPu5HdnPGiieM
	 xG0io7Q9xDZ2ye5bKO+Mj3jQ2mV6C8xNU1UejsDs62yr3XGjrpsa7ETT5D8gMBsNgze/F
	 tdROq03nz0qB6S9Qs9xaNdqjAobML7EMWKwrkiiu1aIJBU935Uuz8YGRuN4lHGMS/7w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0VFyMwLs;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788511564;
	bh=xxBsXNuGadQv3/xH+1UrOzHNWhSWtnl8Y6XT1zs0XMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OF4ZZoa85Lc/99Z85PK8p8Ls5M/ZMSCNT5NvDUP/oT29IMgup8II/bzdDFM58cKIB
	 M2pCqguFnga2dTjlAOcxTsqjD2+4rAglxVgNzmxWFzIy8jXjhCQ4SSe1l8LUNTdoL/
	 njtNBkHrKZ0F06UsMDyLzm2fkfGSftZRsW2ALf/hmdbHVcYGC9mQLNFEYWbDCFiPED
	 ajCR2lTcX4xTl/w/f8NsXWgb0+zeorVxCvOV9CIHGRfEIO1cLvifQ1P6qsf6SGGTD0
	 bY4epluuVdLRJuxr64FhjHMv4ps88XQc5Vvdg6gkD6/ATpcgcUZoFb4O6xaXV8vp8h
	 VxVIGfuGEZsfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6AFB606B0;
	Fri,  4 Sep 2026 08:46:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A09A3AF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:46:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B79F6070F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:46:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u3jCUqu0IfeL for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:46:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0158560616
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c110::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788511561;
 b=q307Nu2csEoqCXEVzgBjtnQHrNB/eUUWMyKVRNNkFfZhXfa7mNzWvkbMI1JuobPdMSll
 KAJZZTGCFTZ+EQR6AixBzxGHloPRGQL9IHEXWqoyQhFWkxwwvnv/s//fZZAvHxbVWd2rr
 O+1EYB9iP8q0rUdX2pCBSK9vkI4eT78iQBLQl/AjpiKSQ1XY2j0T19HfRpeSP4n0eituk
 aaSuihMZxn7j+W+6pC6n2sFOPTsr3+aduaskbtaHLAKjqK1GZQbskIDv4cMvBsO/ytrAL
 L06XsXsxAVsQILkn/H1VAtaVJF42QZILJkZNLV8kEk+aX1nKHetmqyxfTuwGwVD8O4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788511561;
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
 bh=xxBsXNuGadQv3/xH+1UrOzHNWhSWtnl8Y6XT1zs0XMY=;
 b=V9lsHyi2Ke4bCvAxO7MqpBFRUnumWxNDPk+LMzQlwD3MBiz7hJc9NmKGBRYTDDSCLXAR
 34hapU4iEeXewCEDlbKb6fJueRLk9W1O/dqkCBoFCk0LKwCyCXE/fYbOfS73dzPGmjjw2
 PRakseSjtMijvjQKG1WX69ybls4Y4n2xxaUlbh58o5/slZ8R2AOlg1RldRaU1c7DKsDNE
 6LidWJ/zbz9cVABD0aY1Xk+PMZAeOHkxcCvviRLA1LerS3fCOypFFmuggsSWjTCwF67f+
 pM+U/J8TQjiqz4KoqG5HqQ207VzGYuZPSioVhxtqiH4laASDUVYbL9NTE+XJCI6L4wA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=0VFyMwLs; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c110::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=0VFyMwLs
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0158560616
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:45:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a92mGyQtdXJdbsjd0NYKSq5IW2FVHelDhz5xBQoW9CyA/OhNuUeFm07idQvLyrDnf9b02Hk4BsRKbrWI9Sds517OzpOY1Ce63QBVTjmEv/ZVOOgsLLWlpQmbAopTJfMLGVxGyGMRgE4ICSC4PLOeYwK6oZ2v5PgBbJFbrcXqZsEa2sHmhiKVvY7k9n+UU/IW7cywQv8EIaNXXUsqDkyn2WMhS4MDfCwYQisR4E2HQ/qjJKDe4lSZBpjN6l+Gr8PBV9hgALICjx4PmsgrpM//UeBIvJnwqryLn9oSzMsY8OWnVxXDxZH1BljU3uIb2X7y5HcmGLS7ht4qRhWnFqtS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxBsXNuGadQv3/xH+1UrOzHNWhSWtnl8Y6XT1zs0XMY=;
 b=b2oJC1VT6pCK8Mgo5vfKgVEQReLz/HLMIdo+DoZ0ZaeAk7l2H3ef3bTYKKog2pBvN9UGSrM8njRHFSGGd2GUpvdOKnrhnBdxcsEYjC2tJElDJQodOkfExYh+nJv14/L3C3QgTK1NVj8sMsseYDpFFtodOqiWe2UM2trKrOou2JtbFu/wIjS7vlPnvkFUNjVlJQrMHDBhVjna1NfGLjebinT8YxpJ53Ui9+g1Y+inSMIWJA4cCT/ItSrmOdpOoWiLIA5pQopJr2ayw4gAHLeFH9RbZC7eIhD3dpsyBfHxaUfebCbGv3KvuvgexRa6rzPDXtVbcXk/D8jNfDx3WgtTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxBsXNuGadQv3/xH+1UrOzHNWhSWtnl8Y6XT1zs0XMY=;
 b=0VFyMwLsiYXN2ShUt7aJuOLbroIR4wmoqNw11ZZd5vFfCG66QaWzBA82RIR7pX8JKpYQ7YMQPNTbFgrK3lQ9HYnQrImN+Hte9GEXFhPFvGALCIFkDrXPL8bM8N0w0qwxp1Mk8B0j7cGMlElAMseCI+sAyvLOmWceueUQTtvDAp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH1PPF2EB7CF87B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:45:53 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 08:45:53 +0000
Message-ID: <301c1635-fcd7-4fd7-9a70-bb1c2e230e64@amd.com>
Date: Fri, 4 Sep 2026 10:45:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] soc/board: decouple SoC identification reads from
 firmware calls
To: Akshay Belsare <akshay.belsare@amd.com>, u-boot@lists.u-boot-project.org
Cc: git@amd.com, padmarao.begari@amd.com
References: <20260820145459.246717-1-akshay.belsare@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260820145459.246717-1-akshay.belsare@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH5P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::7) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH1PPF2EB7CF87B:EE_
X-MS-Office365-Filtering-Correlation-Id: 103a4498-57ca-47ba-2e70-08df0a60ed92
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|10067099003|6133799003|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: TIPxqIfwlaj01ARLeQNTZuP5swNFg2pRxCFOmLCT5GUqhnLKeB7XivBVnPyuAgI6raHfs2svPI+EAlccOF/GnaLNGx/MBJYQAFWtJO80ErBiciyn4WLgEN0mHZTMkKdgRq5M9c67kFrVbpgJxjq+cgF2qUtKhgcQdL8+Zgknmg2H+SvRyyD1DrPECl1JgrIQrOdU9Gd4NJQ5B7GUZ4yPUaoiP8yJBJoB1CNIGtXpOw03Ac473AS49K2trjv7X9QkSoJkYKbf66cKtgkCE9+B2KDbQlHJJZPtnkxDsPPjRUG2l5dXNzHxYRocNKcA/ek65abcHaQYiP5TDxvkHDjciDjDVx1wBzEN+osHyVoUsP83hSDSqk8LscN10LWAgRx7S9fOR/I9q//8q7YFT7Umd+H74tJ0925ScqRRb9dEiqak6CCvThwXgsYqMcnODMC6P1b0SLlOH5pUOOdZyLzl+KkMa2fqL/x89QIQy1Ng/fCpRj3oLFIxy/NSzFXDEksF0mEhddow3WsiYedgotpr9vzZ0OL8G63C/BDuOwz8CYMZHpqPG7/Zn8KoKjSzOrIjRs2zvEFAGeBSv+Zv6tdS0LrL661N0dw8meiUTYfuhVzEUTTTGsV4YqA+apz7iiM07fVDrLb7qfkBorXzb4H9BYOnGHTRvHFLqDm65ON1ZEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW5BZzZrZmw1K1dKczhyWlFDbVNnZDlVTFhocFh6NlZXR0NLaDJkTzJTU25Z?=
 =?utf-8?B?a0FJc2E3Tjh0c3lHWFAvNjhadDF0WDVUclV6NFphOTAvdGV4QWwvUVUzMWFy?=
 =?utf-8?B?ejhXZjd2WHNXVTBMRFBUclBDM3hGUS9Wc3F2RFQyMkZFUnBWazdlOHNob0hK?=
 =?utf-8?B?aW4zSWN6dUtPdmpraWtLQThKRVBsSHgxZ2MzRGxHR1BjVWlEUDBXLzdIcDhm?=
 =?utf-8?B?QndxaE0wbm54aHkvSkVqYnhSZE9td3pidVJLQnl2VEFRdStqU3o3S1JRZlhO?=
 =?utf-8?B?ZnJxOVJEODZVbXQ3RzVsc2I5S3ROSytYRlJRc3V6emdsK0duSUZscmVHdURE?=
 =?utf-8?B?bmE3STIrL0Y1aUpmekpJU2xYcVI2VzU2WURpQWtacytmQUN0MUFmcFduWWFG?=
 =?utf-8?B?MkJpbTR6ZXF2c2VHSFhDMkpCSGhkOHRFQ0ZEUExYWHhhM1I3QUFDWFRkRHVH?=
 =?utf-8?B?NW5tWER1Q0F2TnZtV0E4bmsyNkt5OW41OEhZWFlpdXg4b0E1VVlPamhRdUdn?=
 =?utf-8?B?OXRrSHBvTnBrQkUxMXYzRUdNSHlheWM2em5IN29mL3M5SmRGeXIxNzBLaDRT?=
 =?utf-8?B?WWxwcWZ5c2g3UEd1Y0MvMy9oR0NmM1BQTUlNUEcxcDNCTmhjbVBabHg0LytV?=
 =?utf-8?B?QUIrT0hqb0YwNEVudWF0Ly9pTUVhL3ZaYWFJUU4vQjlZWkIwNVBnOXdkVkk4?=
 =?utf-8?B?eWpVenJySjBXNjZZM0o0NHltZm85andkVDYxRFZRT09OUmE5WGFmM3F3R0pP?=
 =?utf-8?B?N1J4Q1I0cXlOK25tNHVDaFQ3WXFoanA3eEdDZitOeWVwWmcvVDdvdUNoZWx0?=
 =?utf-8?B?bnhUakVNTWs1T1o2elJSNjRKZTAvRjNwTEcxK3RtR1VPd2FORlJMQ2tSK05F?=
 =?utf-8?B?RHBwYjl0TXdnU2liQ05EUUI1eTEvR1pMeXJyNzlOY09WblFROG9GOXo3amNk?=
 =?utf-8?B?ZUJlUzJCczFvVVIrY0JtRFEwbFcvdkNpc3kzZ004Uk0vQUpGNUpGMEJpL3BY?=
 =?utf-8?B?NURabk4wMlZGeUhmZ1FUSVVRZ3VlbHEzem9iMnEySjJmcXQ0YVpWQkYxWVFX?=
 =?utf-8?B?UGU3bEQ2N05JZVZUaUVaU3BaMi93YzBUcUlGTE5xWmxBQVlaRlBVRGl5YjNQ?=
 =?utf-8?B?SytBVGtWd0NNazZMN2FrQzhJVW5CQitEaUhUd3FiaHdzajJrbGg0aTZpNlZL?=
 =?utf-8?B?NUNJV1VoYlkwcXdOYTZlcnlSTXZHUVdxNkdhZ2p5M3ptcVd1OWxFbm84UnZj?=
 =?utf-8?B?bDk4WG8yeTJtMVkxeEFLck4xTXdsT2JEb1ZkL0swV3pZcXREblpFdGVKUW9h?=
 =?utf-8?B?MVR0VWVsZko4M2RtMTM3MEc4aWQyeWtmckpoZUFhZDRXRjNmT1Z1MllTT3JP?=
 =?utf-8?B?SzRVZWFKUGFOMno1QllXR1FrYjBsci9iVTBwYkFMeWE4V2JGby93NE1tTWtr?=
 =?utf-8?B?d0ozYmJwM2VmK1VZM2x2WVV5cGVMUkI2bC9KZ1hVcXp2Vk81bkp5Q0RPUjhI?=
 =?utf-8?B?a0V4cTVQeDFyZHNObmhXZ2JqeXRkeXBYdDU2R1dpY2RKMFVxc05HemJ4ZDZ2?=
 =?utf-8?B?ZUYwZ3JUQzQyTzhoRmdqWGZXTUcxTHczaW9vUGdaVU80dUxpNEc1STFVSVpH?=
 =?utf-8?B?N2tOYXhWQVEybTJXejNmcmR5Y2svL010dGIxNFVPc3VxckNFY3YvU1JGdkRS?=
 =?utf-8?B?UzhHNUtuMGR4bFFWOXcrVUoxcHhMWGI5SG5sVTdiZ3FHdnZTQzc4ZzdxeEhk?=
 =?utf-8?B?aVdxM3htOUtNVW9pOXFwcGdKaDgxRGgrMjVodFV0QUo0Nm90K1EvSlNKTzVv?=
 =?utf-8?B?ai9kOXUvczYrWk1CTUIyMnduajZMLzJydTlrcGdSdEF4Q09vd1U3YlBtbXo0?=
 =?utf-8?B?Vis3YUpXR0tBK3luQnA4STA3ZVViMTR2a2FIQUJrYXdLTWZyTjBvNzhpcU9l?=
 =?utf-8?B?OE1wYVdkZ2hDc3U4UTR4QWYwM2VuaXJSTE9yMDdaNE1DU0h5WjBMSmk4c3p4?=
 =?utf-8?B?M0NNOUJabEM4SS9Wa2lMOFdhSHpLQUdvMm9vK090cklVL1FGNWtVNURlQWIz?=
 =?utf-8?B?QzdxUmtmazN5UVY4cUtuTzdTTnhKcU45VzVtQzVlUUhIekJoZlY1RS9zM2dr?=
 =?utf-8?B?cG1qbFdZajhzSUFEbDVnQjVtbWlkejY0V3dYclBnKzhFekY5dW94K1laVnJF?=
 =?utf-8?B?M0g2SWJrYmRtSTJlVkRHTEdwRys2UzZpNmVuSWRoamJrajlNSEREdEhza0t1?=
 =?utf-8?B?L2hySEpYOUw3ZVVpd0hGLzBpUUgyQzUrNW5ZZThWOWpJYVRxQzJjWVkyTG8z?=
 =?utf-8?B?U3VqcTVyVkdINTJuV1hhczZDYUh3MDdtNnRWUFVMWTZKcDVBSEFDZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103a4498-57ca-47ba-2e70-08df0a60ed92
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:45:53.0078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwY26o3+B6WMRDm7LP6g/hP91Jr9q+/VrFfIZRckcRGV2ubWLB0Ik++bMu3Iudhg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2EB7CF87B
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



On 8/20/26 16:54, Akshay Belsare wrote:
> Chip ID, PMC TAP IDCODE/VERSION/USERCODE, and the PGGS boot index are
> currently read either directly through MMIO or via firmware, depending
> on the platform and configuration. This series introduces common helper
> APIs with weak MMIO-based defaults for each platform and firmware-backed
> overrides in firmware-zynqmp.c when CONFIG_ZYNQMP_FIRMWARE is enabled.
>   
> This removes firmware-specific conditionals from callers, centralizes
> the access mechanism, and provides a consistent interface across
> ZynqMP, Versal, Versal Net, and Versal Gen 2 platforms.
> 
> Akshay Belsare (3):
>    soc: xilinx: decouple chip ID retrieval from direct firmware calls
>    soc: xilinx: route PMC TAP register access through firmware
>    board: xilinx: decouple PGGS boot index read from firmware
> 
>   arch/arm/mach-versal-net/cpu.c                | 34 ++++++++++-
>   .../mach-versal-net/include/mach/sys_proto.h  |  6 ++
>   arch/arm/mach-versal/cpu.c                    | 18 ++++++
>   arch/arm/mach-versal/include/mach/sys_proto.h |  4 ++
>   arch/arm/mach-versal2/cpu.c                   | 39 ++++++++++++-
>   .../arm/mach-versal2/include/mach/sys_proto.h |  8 +++
>   arch/arm/mach-zynqmp/cpu.c                    |  8 +++
>   arch/arm/mach-zynqmp/include/mach/sys_proto.h |  2 +
>   board/xilinx/common/board.c                   |  6 +-
>   drivers/firmware/firmware-zynqmp.c            | 57 +++++++++++++++++++
>   drivers/soc/soc_amd_versal2.c                 | 23 +++-----
>   drivers/soc/soc_xilinx_versal.c               | 23 +++-----
>   drivers/soc/soc_xilinx_versal_net.c           | 23 +++-----
>   drivers/soc/soc_xilinx_zynqmp.c               | 21 +++----
>   include/zynqmp_firmware.h                     |  5 +-
>   15 files changed, 204 insertions(+), 73 deletions(-)
> 

Applied.
M
