Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293C6C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 06:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E88E9605FC;
	Mon,  7 Sep 2026 06:59:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W1olzbNXD7rr; Mon,  7 Sep 2026 06:59:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3AA1B6061C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788764397;
	b=MPMBa0bVACbfHXTAn0+LaS3rSppc8sg+oxSZ27ApocwqYl7iB3J/phjILjvB8PNbUTld
	 J3h55Y9htXqaaVnZRqCAmBzqVGGd1irRuosu9Y/AXga0ppCj75uQ7uIzmko+Tj+Jb9Ma8
	 Lzxm7NaRuhi9c+s7onKNkiu1f3mk71hy14vt4LFyBfqOH/prqsYB2mu0P8mjaaGSEmDhI
	 frbFMwyiMgvaxRFQ1QppgDpuIdeD9c5bdYcdt3GsraAYSSRoHZcUyfBUYsbyOF811SkpP
	 mDDgKEP6FV2p3zYjBR1/7R00sx14lLRLvbQ30dDT3IwIU4L2XQvH3xZDKNPJVFRbwzA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788764397;
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
	bh=wtJ+YjvCjku8QKsVWbUkKpWbGohU4O9QUJSdSEqhAmA=;
	b=L359rA10qOuy2t+0DNwulMGGew3qYUvEzlkVxy/mB8JK8WVY4dN6YtRjSWoN+1HmMmsv
	 hwFVL+9npsRJ2KaM+J6+vUoP7Y/DRXlDaD65Hk5ZctEBe3UuSdlRfkO80G0NXC2rxdg+k
	 vV0pxctZuFyRjmiU+mutzHoJnM945XWzUBQe7shHd/II3OIiNRnZuYZ5UJs+GDDIDofn1
	 g/YgRte2Q9lcXpKNssf9CblvVh8ExivoyNoAIgOEL1IxcD2iyWPJQg2j2XVLOS9W/l94K
	 xH0oQ4QzmqNtvbtRUK5DqEHLHDu57g0IdfW1ABU3449PlbZ25vuP5+mfvtSAzUztOjA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788764397;
	bh=wtJ+YjvCjku8QKsVWbUkKpWbGohU4O9QUJSdSEqhAmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HGNMzyvuQow82+rvwPRpbJfT5cb4ZbiHvxzMyYz1z3Dwt0UDQaH8aPhATX++OzoQP
	 oNFLDeE71vmhpZ7USeW4MEFV7jgFXvGKOvEJ/LczrHiODbYb0PJEdUBnamsT/hhgad
	 /pgkz759NTw/VtFRvS1JwPkC+sobP29ureXteb/KIbRBz5ItvSCkHONJLVFGW1eDPX
	 qUM25/Q8ar2jkRhsE238d9um3wIKhKrBcfCtHjzxXpSUqVt5Hzo2DXXn6db7ikcmq4
	 T+KBwlyqGIetvzkLJQNSlFIktTxymUoLqryZokwW3RK7iUskK+yc32csEzikwFYtb1
	 O0c08FEGy28vA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AA1B6061C;
	Mon,  7 Sep 2026 06:59:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 029B872C
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 06:59:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCF04400EA
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 06:59:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vLNYZDze5K4m for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 06:59:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0BBB140068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c007::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788764395;
 b=gi1lnJkI2r22HFETEtXBYjiVE+P0IfqeKCjFaMfTurms36VvXalM9nqpygruQg+vkUJw
 NWYWli3ZOcsJVYL2CWY1lfU/ex3ICrzxvL4vC1fPYJmMP6EM5Ml0NJZ4XdvCYyFJu88UN
 LaR591HZlGgy6kg3BABhlO0LU2n1Ng9NHzsCJ9rRQI9aAxtGsLoeTqLgEJGntSC5kf60y
 g31god6NkCqsK89V1/Jlo/iMbLKAOAv7e6lsNhoEaxHvrpy0oX7mPWAaWUxOzyv93TpHe
 z34cWwSb88BZtj+ibTWYq2aNYdDW7yX26xv9/K7/LVyVWQMdzBYW+G+RM91JhKj+3rw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788764395;
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
 bh=wtJ+YjvCjku8QKsVWbUkKpWbGohU4O9QUJSdSEqhAmA=;
 b=WblVaijYZUgiSnrF+W/qCPugfBO66fxBwJan5Q3cvhvWxm/KLxPC7+wO9evp1m7z+rh0
 P7l+vA9HIwdjqpgrvvZXTKSc/4RYUUhB33gX1OxLInMaV3xcvjlrh3eOcF18of+RYJvue
 IrW5ZSqSefJS0FZ43/0hLGzcPXOwRscrMHWrSDYyNLQriW50CQNI6/83Q7AIKx+pnoFIe
 XCd4rwckR62J1iXR3UMMYWNtMGSaJ+uc41mq3ypuSGrCx1HdyI5YxFZMH2Y8SqgW7ZAeU
 Z07Ci3qfDZbc3WgR2xHJrnmi94fpgKu2G5Hb1Y/2CfWx3c1b5E5X4OZvsT9Hv4kbYRw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=yIyD6enm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c007::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=yIyD6enm
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0BBB140068
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 06:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqVf51NSyYKm1646KjB5ZWtRbCbW/JrD1rnqQmwjp5nKLg4c6F8PN+5dreVwHlRCb2r6cB35yFFtRjcGmPnuwdb81ZmIGP0WhmBDKKna0OxYxuICsy0gjQ2brDyhj1SdegtZ0f6e1GmDZAF9HhtoZ/VYghJU9p9ZV4i0yk6n5MlB4rVU4VZSRnqlVA+HddlJL4L2hQPRv3YqCXmGWBpawVh84xJEHDLzRPlKO/D9VCtDaURsZ6LdR3f3NbpG+05LgM5sIPzPxv8lj2d0v/4pUieAeQ6BkjNoEJbAATn0UYTl7dlWz80raR28MrgM2irjTPDNYrCK9wylg4XbR1iHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtJ+YjvCjku8QKsVWbUkKpWbGohU4O9QUJSdSEqhAmA=;
 b=WKtD1Uj4kujIc6j9gJ9NpizBpP6fVGqPMdNuVmhBSVumq7b/zhcrEzVQguzMqiiYjVkd/p673PuQtH8BwIIKy9/Xktq1TnfcK0oxxGbXKiQl06AfNWrSEkLC0ajQ90ExEFGmda108GRXZWXLWnSxhH2hHyz8+iDTo+HF2y+kwyop2FCl+xJTLC/aRig492enkh05ykkpWgslbTl4OBfsPSTUw0jQAdafONODw68pwMDVboGuk6DtGexfYLzisiZcRRoW0viFyPmHVDUjo+ZMEFSUo37xubkuNinChadZ6uT+8gPLcRHZCyX6tqBtiu9s0Qs4ESh+fcsm3wfOPab/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtJ+YjvCjku8QKsVWbUkKpWbGohU4O9QUJSdSEqhAmA=;
 b=yIyD6enmXZUTI00pkFE3Kj5zmY5UsWGaZZFl5dEet8KOhHo99rvdJcExD+KqNPzMXCP6wJaIvzzQsAg7mH+sod2aXXId7reZVBGjqROmMP+ZlDlNiIMmu0aSfnSkP++xdI6CGKcZSsHmho3xoE5pzfD3ZJpG9X0J0DfanulD49E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Mon, 7 Sep
 2026 06:59:48 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 06:59:48 +0000
Message-ID: <bacb72d9-cb5c-4883-90d3-b15073a7ea22@amd.com>
Date: Mon, 7 Sep 2026 08:59:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add AMD Versal CPM/QDMA PCIe support
To: Pranav Sanwal <pranav.sanwal@amd.com>, u-boot@lists.u-boot-project.org
Cc: git@amd.com
References: <cover.1787554549.git.pranav.sanwal@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cover.1787554549.git.pranav.sanwal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0195.namprd05.prod.outlook.com
 (2603:10b6:a03:330::20) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a94c33-6ec6-4540-c264-08df0cad9b1d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /gu9Tn8wr1LtbW2lyeNZR+xL38CNZVk3iXHF0TAlzKKO1DDpm1RUvvMQly1Kxt22ubsLHecDnOl5J+fZanWdhmYMq0n3q9O1D43NHVgKnfuWz2wvNF9CfrH/tTAQjCZY6cnhT1w7ljJq5JOgK0uOe5bC4ufEeQkUA6dhvnT/irWsnb4ht2UhccJqOOoee3fDbFL7JKQepHvEveFYuoH8AHhVQrnZ+tgJIM63sTYENQp/48d1Ihydr6AGP9SJ54vg9r9/oOtBFx3x+3cb4Kt5J4M1F+4oZ40CKQAkCyPpuPNqvEg2r0Q09zfzhxnFTG1PKFGCw5EHHkzHaVxkRxqupZdFfoZfWCAQPL4zw2WCa48g5x2kAor6Znv8XwJAJqMP8KlFG8TAmLkjUUf4kP8dzrPEjvTqf2F0I23bB6ePbT8oKEOMDB9gAk5v7WN7neUqz8TlBE26ULEE5WfVvnxD5jMObDBfths15h1IcEZ1wH34hP6Z3pEuvAcqrxP1KhoRAOLGsunZj1R4S1givL1airtfi5pKE0By1m47dvp1lW669bpv4tBwPkGsZY19o0dwtxrPDOZXABuwYm5S4+4UsifEyR36JGNUeelBl2xTun9Omhex3yx7RaIDOrMkucc17dY0AlKT5PuCEgbS3OCvO5Vx7XUtFYQiWEO8HOAjyP8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW83WVVSVjFjTnI5cGhUTXRlTDFkSGVUYTZFNW43TVN2OHNNTnFrNnpQbGpr?=
 =?utf-8?B?VEdSamNmRFVqZ25UQkpMYmxudFN5UGR6aHd0TXllQmJVVEtTcGk0QlBrbmtG?=
 =?utf-8?B?MXBuNzh4WGdsOW5qalRTcG1FR09aN3lkVitYNmpRSjJLZUhmVzFzY0tlS3p1?=
 =?utf-8?B?Nmc2YmpiSEhWdk1XcWZ1dE94K0xyUDNSMW9zbkFlRm9GQVhRWHU0YThoelNX?=
 =?utf-8?B?b2JpMi9sNTZ0aEpDNmtUUzluQ3BEQWRWeG1UUGR6SnM1WGoxa0lrMm15akNk?=
 =?utf-8?B?YVN6dXBBZGJ3WlFVQVI1TGF1VXg5WVlJdmFRTzR6Z0o2QTVuYUFJS2cvQ3Na?=
 =?utf-8?B?V1h6YTV1VWxaVndTVGpYb2Y4YzFxT0xlS0RZbXRjSlkzTmFad3hYMldQYmtV?=
 =?utf-8?B?QWZPNEk2ZGNlK2U4RGtob3kzWGlkckN0ZHJNUGtyVFBLVldPbDlrb0lPa2ZV?=
 =?utf-8?B?R0NtR0ozdWVMN0JIVVBCcm5DSlhlNlJUa0pZaWE5bE5PTEwrR1dYZ3pHckNU?=
 =?utf-8?B?eUpzK1dLOVpzRnpOZ0hmcEhvblVJeVFnWFgwKzNNWGd4SjV5OUNEMTkwdHdm?=
 =?utf-8?B?YXhESXJrWDJYQ1dzeEliaTEvY1doOWUwNHBIRlhiMm9nZEdiakI4K3FNZDlC?=
 =?utf-8?B?dXNJQVpUZXRIMWdzbTZjU1JDbHpnMXcwZjJtZ0g4d3hZdmxnbUdNN3FCSldJ?=
 =?utf-8?B?UTQ1Mi83M1F1THd3Y1hrRXRnNEIwSWhJb1o3ZG14RllYV1pTdlV6eTI3YTNH?=
 =?utf-8?B?WW1zcGtYS3RrZUg1TEF5TWpJM2h3YkF6WkJpMWJLdS9BeGk1cWxITWdvblVv?=
 =?utf-8?B?d1phRVozSTJ0MTlHdHBxQ1ljWExIYlBPekpmcUVvanFXVVJEV2RTaFJQQ2dw?=
 =?utf-8?B?d0hpSEJlclJmNlNBSmxSWWd3RjNaS0UwTm5hVEtXU3lFbkhHZm93cEQvU3BH?=
 =?utf-8?B?b3NORWloSUxQWlM4M0V0QnRyWVpmOWo5YzlCNmhHbTdvVnE2YkZ1dXNYcWFt?=
 =?utf-8?B?NVkrUFMrTWVWcEduUU5WOWhQWjFKZnlPMmIvVGtYbzdDWThIU05EV0lVWmRG?=
 =?utf-8?B?STJtakZSMlkyUnNvaGQzSzh3NUtwcDd5MmphanVwczFGNUtLb0hBcW9UNVd3?=
 =?utf-8?B?OWJ5Q01oK2VpT3ltTjkzSHB4MmdWTlo1dGJYbERERjMwNnVYbFdKV250VHNk?=
 =?utf-8?B?YURHS0R3c3lJVloxZU1Dc04wOHNZZGdOYWkvM0VVTHd0N1RYbkx0VGxobUM5?=
 =?utf-8?B?MFNIK2pjVEs0eTFQY2hLRVdvWmJiTXJXZWRRN2tiZWt6QTFDUnVsRzBWUDk1?=
 =?utf-8?B?eWwvelpXMS9iRjY4bDNwYllRcnRZNWRsTHVPRC8weHBBMHR3RVR0MzF0TXlj?=
 =?utf-8?B?NjV5d0FBaW5lbFhNVTJhRmxtQXBZbU9KMjZiSlE1R0dUK0l3aHduUndVRXZp?=
 =?utf-8?B?T1c4OTdjMlJUZjNBRGtLT0hmOGFZWWt1dXY5a2traHB6NWRIb0lCd0Ftbjcy?=
 =?utf-8?B?ZXdRZU5mMmhHQjA0QTEzRS9QTGU3L3VtV2ZOcDk4NHhNUmdRU1kwMW5vb0VE?=
 =?utf-8?B?VTlLOTZkQjRvY3Z6VU1sdVhTWDlOWnlXMW9tRUtTTVk1ZnJSQS9FOWVieWdm?=
 =?utf-8?B?eFBsaWJEdkdXZ1R1amhRRUdlOUNheHIrK3gzeWltN2RDZTdjblZTMTAzWkI0?=
 =?utf-8?B?eElvb1ZlY0ZQS2dUREU3N2twZTZaL0FyUEdPZ3JVOWljNDV3aHBsbmhhVjVO?=
 =?utf-8?B?bE44aUxpbzBOaTNOT1k3Tm9DZGhCSkkxZC9Gc3NtWFdtM3hDVlBTSVF5Y0h2?=
 =?utf-8?B?QU9reFl4a1NJa0FBSEowTncwOXVrWVlINFFFVU5sWUVkcE1JZC94YmRONWVr?=
 =?utf-8?B?ODY3WFBMa0o2SktZY29TWGxDSlBKUEZ5UlNTOXVHdVNOVGl2L2VQVHd0dGQx?=
 =?utf-8?B?d0RkbFh5ZGJzSWNrUmljaXR1NEdQL25waUhidWFiTTVzZkNmNTc1ZWRnRmVo?=
 =?utf-8?B?d2R6WnR0S2lBQ013ak5aODMwSHkySWxIWWVhQlhPUnJUa0hRbUc5Sk90RnRz?=
 =?utf-8?B?WHBtamlwc3ZrY2ZFMnhiK3BwbW5hc2VZNmEwd2YwdUlpdUpXZWlRK2FPZS9m?=
 =?utf-8?B?NE9Qbk55NEkrK2pwZXhsWklkSmlmMDJWNzFkdWhqWmRQYTVNMno4ZjUvYitk?=
 =?utf-8?B?eXc3c24vNm15OVlqeFRjQ2dwaEk2VkZySWZ4SHViZnRDU1lwazNySUVEbk0v?=
 =?utf-8?B?dEtVbncrbjM4NVJ6MEI3a3FXTENoQnhkaVhZMkcrTHp5WGdpcHFVbmhxUTBS?=
 =?utf-8?B?NVQ5c0pRQ0VoNkpTMDkyZXJDd2dRT29qTGMxZmsrRTJCSm53Sk9FZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a94c33-6ec6-4540-c264-08df0cad9b1d
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:59:48.2462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLiemJqW2Zs6w1q3avWpj37ImOjwV17O6u3GtVdmgzSNP2k4FzWUW3wjvNEP0bI3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218
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



On 8/24/26 09:21, Pranav Sanwal wrote:
> This series adds PCIe root port support for the AMD Versal CPM4, CPM5
> and QDMA PL (soft IP) host bridges, and enables it along with NVMe
> storage on the xilinx_versal_virt platform.
> 
> Patch 1 adds a generic mmap config-space write helper for host bridges
> that only decode 32-bit accesses.
> Patches 2 and 3 add the QDMA PL and CPM4/CPM5 host bridge drivers,
> respectively.
> Patch 4 maps the CPM5 ECAM windows as device memory so config space
> accesses are not cached or reordered.
> Patch 5 wires everything up in the versal_virt defconfig and adds NVMe
> as a distro boot target.
> 
> Pranav Sanwal (5):
>    pci: Add pci_generic_mmap_write_config32() helper
>    pci: Add support for AMD QDMA PL PCIe root port
>    pci: Add support for CPM4 and CPM5 PCIe controllers
>    arm64: versal: Add MMU mappings for CPM5 ECAM config space
>    arm64: versal: Enable PCIe/NVMe support and add NVMe boot target
> 
>   MAINTAINERS                          |  10 +
>   arch/arm/mach-versal/cpu.c           |  20 ++
>   configs/xilinx_versal_virt_defconfig |   6 +
>   drivers/pci/Kconfig                  |  19 ++
>   drivers/pci/Makefile                 |   2 +
>   drivers/pci/pci-uclass.c             |  42 ++++
>   drivers/pci/pcie_amd_cpm.c           | 363 +++++++++++++++++++++++++++
>   drivers/pci/pcie_amd_qdma_pl.c       | 205 +++++++++++++++
>   include/configs/xilinx_versal.h      |   7 +
>   include/pci.h                        |  26 ++
>   10 files changed, 700 insertions(+)
>   create mode 100644 drivers/pci/pcie_amd_cpm.c
>   create mode 100644 drivers/pci/pcie_amd_qdma_pl.c
> 

Applied.
M
