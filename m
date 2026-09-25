Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B70C9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:46:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3811E8137A;
	Fri, 25 Sep 2026 13:46:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W-NePM5AmvFO; Fri, 25 Sep 2026 13:46:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1644381365
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790344006;
	b=bTVATYd6XoWafZsK8whlTlWHkZE00gXmzuY94msPbtnOe192vP/4aE9IDhbWSYn7qKH4
	 6ye2GtPufBknj9Hh64CGoFdEBJftcWQPfGs7TtrIbLexe3SKpuRCFPbKyE3X3aA9pJ1sq
	 tJsTB18jwCORxAdl5lhLwlMvEUwINAWhjTLmdxZvSmOoKNxEutUXDByiFcjctpwSng5+k
	 ZCsSuJ3Uebnwfl6iX6+kCIDkYXAFmAnU/ZVC+a5Bdhnp1IKVyQUAkllm4/yI94gnPXh9H
	 jbrI7Kwm2SipqbjnmN46qfLtvYt+26+t/sl/z9VeSAoefMNcD8GIasYVl3DOZb/Jpkg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790344006;
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
	bh=s5hA52tv5wUyu7z3Zy0V+xCLjQD7AHWwb7g157Q1Z8M=;
	b=aZoOwbd7ivODVpbBQvCiKDYlcDQF9xZQlWIsIqQUQaGi5akGDUyVQoJtaCIVONMzwBsI
	 ybJAH/NhW+p08Dbis5auioMeNnAT8AkLmrfwrYd5/36tCzJRj6pm34v2pLb2Yq28vZcip
	 j9lTJsM0yK48Ns7XjDUisaOatMQmKfa4q34UJPgXs77Jn2+44ldubSytbLqTSCOkp/MV9
	 Oq3Ohmb6a1M8G5wY/zsFsJTLTonym7T0nzEYnZ+WcACmXO+0aIO65cJpjaR+c0X6j8AzT
	 Pspa5LJanctKZ+t9T7wEXtuNYuTK45yob8T1RNBnXx7vpkqEJBjUTKQ8YQQcc7p384A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790344006;
	bh=s5hA52tv5wUyu7z3Zy0V+xCLjQD7AHWwb7g157Q1Z8M=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i6q8Iukt3/brFIDbuqYyuaI2NFrAnGR9kqI6nmO4gB0c7aQcMywQ8jgicgsgTnXCn
	 LCSG+m1pCfNvLomCnYE8gQN7iAylqYFEX/he5OYkUMf6TgsZQP+7qwRyMUDpF3OxgU
	 xSAVjx32ldexU0uaTxahaWF5r7QhqpxogyKKR5vNm428BOZIqvnj0LK/wZBIc9rMmi
	 RwgGvMuaCeIzxeICzbtP2RlS5YruJeKXjN03p4N61H0cdgRqnOZE5W91TvL8yRS/uf
	 4MartmtvVPv4WKfPH+rWxrp05gK0CU6AnOFN3WZE3l8xSwCvtJDvzO6XWylQev1313
	 +iVZYf5k0rG0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1644381365;
	Fri, 25 Sep 2026 13:46:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BC1A0332
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:46:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD80B60C09
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:46:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X2-A0bMrw15v for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:46:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D70D360BED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790344003;
 b=VnUzxE78SO6R/1Oc/xR6y00JQv15nRtPFLfNpo980pIduDDa12m0srSFxsTyy0S1k4zf
 Ji0tbNVShnVbJhVXDz/pVNNJBeevweO3tsaIL12oLDhF5NXjQRf58sWYUOoc2RVwdUCGY
 CUKJpNHFD3fHjgXK5/07eaaq/Qc5IvluE7gP/exLZk1mUW3wsYzc5v5TkcurIs3815wDo
 sIsu7WIXrIxogwiijx5jB3MGZZyAMge0TIoPR3gazMZAGxZ4Wo30kiun1SxXPztCPaqyk
 TPzKziDeCW8/STf/KtbpdaaEV6N7ymxFc8VtRD7PramWTFpT4QcoLFFm3B9bpctKPUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790344003;
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
 bh=s5hA52tv5wUyu7z3Zy0V+xCLjQD7AHWwb7g157Q1Z8M=;
 b=pxw1KHE25eCvLZ2e9Ak4gzgM3mSUOArQ9L4uzgtjpbod9f57UT+2DpNghjRBLYn2skx7
 DIKhnqB7QBLZuiU7P8SSCDXPZ5pN3/n1u+xvuyp0Y4rAmNXunxGb1YDTkbelNEe4WEuJU
 DR14hbo4P5vmLkcCSwH99uajL3EmIs3rWqLy+e4yjmfMuqiTtk8OSqZMc7zf1VPExJasG
 AXBgsECj7cusxdr3GSU6W8PM3hp/chizy6Fa+nhzHONIxNBnjMse5FBaVgw/rjz+eIzqj
 AdwCjJ/D0xG2p4mkBVxLZVA6KtVeZ76UbVXnI7HEh1dTTLZcmCln+ZFG62vZxlojeMw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=hGHo9XSZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=hGHo9XSZ
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D70D360BED
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWr7s60TO40cU+9HwSyszvl/WGF6Y5ncjm6kMzN+pyyy4M/jE1y36qSiiO/GdpthizuQ0ytwFUbe9KdTEsjRwmqjcEc+dO6/rELfQPtwUV0OzQXEnwqEQB7bnnA4gMInO0JimlEGIo2RxQRsdUk7sUXhNxSR9UKAcFcEVkpyJso1FZ8E0+6J7LcDdkqgh7yw6hkrgmjAvaUo8X8lREoSUqFI1/J248WC1JJgrXp+AH2DY8IwJQU607f4Ifpf3IN9ek9PqiEo8vwdnrRGJAFpbAWu2+NSVWtWt0JbbN6SCahvP+Mu4OgfSKQAmH4h4L5qHfIybaosCppvpmThnogXZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5hA52tv5wUyu7z3Zy0V+xCLjQD7AHWwb7g157Q1Z8M=;
 b=I5qIzhmY7qKMfs3+IV7jQfXJk1+2pNZu8Mv6CTHVg0xGTDryT7P+1V3s1J7saUlISQ1ydoPHxNFY3VMf3af+5vGEhFev2XQcXDvceDatqrxlj6G3aAWAjYeBFFAasUZl9oLxW+diIx8PVGp6IjHdf5/nYR+BNEBU4TlihSJKDXnxxuLBflR+TMyA0wv6GKPNTm8kW0udnqcUUoDPVRCvfITrr7AyMULhslCy4pY9N/mLFZT1d829YG6zTo9Ou54bO+AegfdWsVnj/hr/4HVKJhUwr2RxXHxN8dGUsFwkVInyeMNkAfF8klxWrBEVX9inHp66QJ9uaJsXOu0crsr3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5hA52tv5wUyu7z3Zy0V+xCLjQD7AHWwb7g157Q1Z8M=;
 b=hGHo9XSZ5+/Jor6abaqCEXjh3jYZsLvkDOBug0mpsxGE1OOzBJ6s19z07p0WrOijV8fVAiQocniVBc/q1eCrVqmcID6dZbEMybSYp0n0N064RsicYnCUrEjpcmBLlZ19cHV4Pgd/W2OeMYGQACmUP1JI30VoDLX7m1lriW6NNic=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:46:36 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:46:36 +0000
Message-ID: <616e69fd-faf8-4eb0-8180-b1642f5a9cda@amd.com>
Date: Fri, 25 Sep 2026 15:46:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: zynqmp: Reduce CONFIG_ZYNQMP_IPI dependency
 scope
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Akshay Belsare <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>
References: <3d6ae0bf41bbab265dccf1db4475a199f78298dc.1789042623.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <3d6ae0bf41bbab265dccf1db4475a199f78298dc.1789042623.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::11) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: f009e8c5-5e85-41f3-4338-08df1b0b6b2d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4gJY+RzWV1EiHq3w0Gj2Yj+53z4NlvzgZ+noHVZw3NiA7NjWjvL4M1IRDc3n41wvfu8NW3181A8XixkapAc2imKws++lB3+f12g8lbdylNL94PnuQLCbMTixRpEaT3Mf9cYpXtNsJLGpltO3HpfBqzcfgfH0Nr6kk4peh9QJ9aUulf1oPZej689PAxR1aA+zbFDR33alJX60MqBu26M/pih4P5L8cNILp0RXgW26Ka4gHF5RXZ2j7U3Mg1JUucxM0d9ZT71pGmqYvIayEA1zq8fGHdaE3oOaQoxmBpV0x5vkKVDY3/nCmmlW4ydncDx2aYvHGs5FSPIcgtVPtyJS8wo2qnbVvXUfHYM3S4m15KWe2aHpYFW+s3G7U+rcAExQgVfKXjKSjO2yhyWYFIXVN4JtDztZy1cDYnc+n7ZzMVy98+QFj5uW0UtRTy/DBYL0tYXENpZNS9i6jL/eQuRCKPjTpwKppDW/vEWytNgwxHLYZEhp7IjRfNpRgaSryYkg9N/WfrTiuyQw80XgItlSrrOH/K9h0Hba/T6DZ3xFn9Oi42RqJLOoP0NloYFVPtMI/0zPHZTUucX8KtNgpQcIql9UWo8UqeOBniC8ZXw9gsMhkh+GGNZPWoVTzfmOC3zISzYFO8T/MQd6UwvJi/zn4pi5G3ztifPLJP4SfjPCfqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU1Ka1J6ZXl4c2NvOVpHZ3dwek5xSU5vSXo4WS8wZHhFRFMrUzJtUWVFWnU1?=
 =?utf-8?B?MmxycXdKZ1RnY2w5dkxlUE5HN2JKaUpaYWdaZ3U5bWlwc0tsRmR2aHN6VGVN?=
 =?utf-8?B?RDdlbU56SDYvYWJaWWFDK0dFYWFUUitjamNvQzJzSXQwMzJ1ZDZNVFhjY3ds?=
 =?utf-8?B?eFRBZitmRHVoUUNPbGUxRnREaVBDQUErMGRIUVVzWkJJK2RzN2FsOERtUWZy?=
 =?utf-8?B?WnRtbHBSSTZCTUg4L1RIdjMvaWtVMThjY005bkNZMnpiLzBDS3c5MVVGbld3?=
 =?utf-8?B?dnhzNHloMmkzOEVUWEhWckFGRFZkb3E1U29NZTY3MXViOXFaSzErR3FwdlJ3?=
 =?utf-8?B?UDBnampNLzlxaE9lemo5NnpINmZTYjVSdFRESjdWTWNtSjBIQnRkTVkyYnkv?=
 =?utf-8?B?NGF1S1dndGNVQlNxVlQxZk1LczJTYUpXVGpRak1HbEIwMXRwUlI1bU9rRGw4?=
 =?utf-8?B?aHJzSGFhSzh2MnV5T3d6WVJmb2ZvTStIdmFyditFdm9LcVQ3cUQ0alFES2F4?=
 =?utf-8?B?bVhVYUQrY0YwQWM4dUExL1E2cTRya2hFNTBlcVZnaXJ2L1FTbGNJdVJvQnp0?=
 =?utf-8?B?VXNPSlVuRkZyN0RrOTlSVHRkSlNUMEhJejVjY2QvKzlNeENwWjVqU0o3dkg4?=
 =?utf-8?B?TlY3SjkxUjdIQ29RazZHeG5nVjhaRnAxNFA2bEw2N0JJVEFrTG1EdllQcUgw?=
 =?utf-8?B?Mm1Kbm51TGI5K0tXNEVCMmVTSG5HaU04K2VmcWhKTktGZFlITFBhbDIxUUha?=
 =?utf-8?B?ZzUxYjd1TGpKRHorSStHWnRDaFVpWFJjdVkwU05oS0FBSFVLbFg4c011NWd2?=
 =?utf-8?B?Q3ZUUkZXcWdXS3NQVi9vRWJXY3JoN2c2cXBqM3VBODBjNUxUVGNsc2NrVnF4?=
 =?utf-8?B?SEZmd3MxZlVEdDJYL2JKWGFVSHc5QlM0dVZZTmdVR0x5cWZJYXkyMjBlTkVl?=
 =?utf-8?B?QlpYSUc0MFMxNVRpN2lrUE11MVNlci9YcFFFYUlGcFp0NHpNSnR2YWttLzZk?=
 =?utf-8?B?NDdIalZBQnUxQ04waCtNdkhoTzBRRTFTSm56ZXA5aFp4cUJxbGY2Z0RFTXNh?=
 =?utf-8?B?NFNJVVF1alhYczFHaWY4djY1ZDN3QzZNM21ESmY0aWErVkxSS2pXczIvNkpL?=
 =?utf-8?B?L3IxSEJLN0p3dFBnUzhReXAvZ3gvNWFrREdDaVYzQWlPc1plV0JFaTJ0OXVl?=
 =?utf-8?B?S2RoZldPUXBNU2s4bjB4Tm1TY0pUUktiNnhFVDdsZWRYK2NhNEtBVXdJZ2ZT?=
 =?utf-8?B?a1VwT3dWZWwyTjBITHNyRGRSWXhZVVlsN0YyNmRsdm12cXNWUW5GbGdjU3c0?=
 =?utf-8?B?QUlHMG85NUtZTG1lZndOTnBJbUZUUHY5U0szeVNDckRRcWtKWG9YN2MwS0VV?=
 =?utf-8?B?Nk1HUHVJYW9hUHZybjU2MHVGWDQ2ckpFT2tOWDYvRi83ZHhXeXltYUl4KzV5?=
 =?utf-8?B?SEdnTHBPVXBNNTFDZXhZSEV0OWJQNnpRK1B0R0prNy9aOGVYbURTMnJWRDV3?=
 =?utf-8?B?SWdTMFVyclFLQkF5QXdFbTFocFp3eHpzL2lidUFkVGJZVUQzMy9PS29HRUpC?=
 =?utf-8?B?ZVp0T1lmRldNT0RzczVuQjdGR2xINDdjcGVoT3dwNktOYWZVcWpueHdQSzVY?=
 =?utf-8?B?Vkpza2VzWWQ4R2YrS3dYSG9JTVd3RTNMU0k3WGhFU2NBTjhDVnVKWU90UWxs?=
 =?utf-8?B?R0NFcjgvYWQ0R2FMOW4xTTl2eUZxMkZDbGErTHhXMDZBYXdFMWZlZjdMK2hX?=
 =?utf-8?B?am96ODFEQk9ISDRNaGJXRXIyWW1CYnIwVjdjWTRDT3lvaWtIU2JoUktDb0k5?=
 =?utf-8?B?d1Nyc3kxMkppa1FmaDQzRnJQZ05jVW1lZXYrRk13V2NQY0lXaXVnUjhlZmhq?=
 =?utf-8?B?MEZjRkRvL3oxU2ZSK2QzdXhab3BDekpXdnVCcHZEWGRWQXByaFZWSmljT0wr?=
 =?utf-8?B?aTBRWjFCYWtjZnE2enZXejNGZ0t4aE9tN09LMHl4WnhzbWRQcHppemExZ3Az?=
 =?utf-8?B?NE0yZC85azVuQzJTNlpPcXJjNXQyWkd2OUx2ZVBqb3RqN2szOUtzQ2swRGND?=
 =?utf-8?B?VElsQlg4U0EwM3ZJc1lCQyt2aE8zMDBLaEYxM1NLc0Y1NkJuMUMwTzVJbytv?=
 =?utf-8?B?UzlBVVZ6ZUlCbG9tZUtYWVRYdEp6NXh0MXlkblZxWlZ3ZTVQZ2wwR2IwOVJz?=
 =?utf-8?B?QkYvR0xKTDBHRHlnREJQb3ZBOXhpRHF6aXZFZzBFK0oxM3NDVFlpeVhNUm9P?=
 =?utf-8?B?ZkNneWljR2tmRFhCdHA0ZXVSRDFHS3hwajA2YzNRMzNlN2hSUDl2WW9JdFNP?=
 =?utf-8?B?RkpHUXV4TlNBbVV6YXhYdDdoVmVSeXVwWEdsSkMvL1JHYXkzWVkvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f009e8c5-5e85-41f3-4338-08df1b0b6b2d
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:46:36.7401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAivy1EmIF5/G3j9/oycmoIq6BvsDSUYERMPQGP0M8ALAI/AQJoM2Zww+mnySlhi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882
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



On 9/10/26 14:17, Michal Simek wrote:
> The CONFIG_ZYNQMP_IPI #ifdef used to guard a large portion of the file,
> including the generic firmware/PM helpers such as
> zynqmp_firmware_version(), zynqmp_pm_reset_assert(),
> xilinx_pm_get_chipid() and the whole Versal/Versal NET/Versal Gen 2 PM
> API. Those functions only rely on xilinx_pm_request() (SMC based) and
> have nothing to do with the IPI mailbox transport. Because they were
> compiled out when CONFIG_ZYNQMP_IPI was disabled, the Versal family
> could not be built without it - for example reset-zynqmp.c failed to
> link with an undefined reference to zynqmp_pm_reset_assert().
> 
> Move the only code that genuinely needs the mailbox/IPI channel, namely
> zynqmp_pmufw_load_config_object() and the zynqmp_power device probe and
> driver, right after ipi_req() and close the #if there. This narrows the
> CONFIG_ZYNQMP_IPI guard to the mailbox transport code only and leaves
> the generic PM helpers always compiled in.
> 
> With this change the Xilinx/AMD arm64 Versal, Versal NET and Versal
> Gen 2 platforms can be built both with and without CONFIG_ZYNQMP_IPI.
> This is pure code motion, so there is no functional change and no size
> impact for configurations that enable CONFIG_ZYNQMP_IPI.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/firmware/firmware-zynqmp.c | 200 ++++++++++++++---------------
>   1 file changed, 100 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index ef1852cc35df..27bea8b18579 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -148,6 +148,106 @@ static int ipi_req(const u32 *req, size_t req_len, u32 *res, size_t res_maxlen)
>   	return ret;
>   }
>   
> +/**
> + * Send a configuration object to the PMU firmware.
> + *
> + * @cfg_obj: Pointer to the configuration object
> + * @size:    Size of @cfg_obj in bytes
> + * Return:   0 on success otherwise negative errno.
> + */
> +int zynqmp_pmufw_load_config_object(const void *cfg_obj, size_t size)
> +{
> +	int err;
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	if (IS_ENABLED(CONFIG_XPL_BUILD))
> +		printf("Loading new PMUFW cfg obj (%ld bytes)\n", size);
> +
> +	flush_dcache_range((ulong)cfg_obj, (ulong)(cfg_obj + size));
> +
> +	err = xilinx_pm_request(PM_SET_CONFIGURATION, (u32)(u64)cfg_obj, 0, 0,
> +				0, 0, 0, ret_payload);
> +	if (err == XST_PM_NO_ACCESS) {
> +		return -EACCES;
> +	}
> +
> +	if (err == XST_PM_ALREADY_CONFIGURED) {
> +		debug("PMUFW Node is already configured\n");
> +		return -ENODEV;
> +	}
> +
> +	if (err)
> +		printf("Cannot load PMUFW configuration object (%d)\n", err);
> +
> +	if (ret_payload[0])
> +		printf("PMUFW returned 0x%08x status!\n", ret_payload[0]);
> +
> +	if ((err || ret_payload[0]) && IS_ENABLED(CONFIG_XPL_BUILD))
> +		panic("PMUFW config object loading failed in EL3\n");
> +
> +	return 0;
> +}
> +
> +static int zynqmp_power_probe(struct udevice *dev)
> +{
> +	struct udevice *ipi_dev;
> +	ofnode ipi_node;
> +	int ret;
> +
> +	debug("%s, (dev=%p)\n", __func__, dev);
> +
> +	/*
> +	 * Probe all IPI parent node driver. It is important to have IPI
> +	 * devices available when requested by mbox_get_by* API.
> +	 * If IPI device isn't available, then mailbox request fails and
> +	 * that causes system boot failure.
> +	 * To avoid this make sure all IPI parent drivers are probed here,
> +	 * and IPI parent driver binds each child node to mailbox driver.
> +	 * This way mbox_get_by_* API will have correct mailbox device
> +	 * driver probed.
> +	 */
> +	ofnode_for_each_compatible_node(ipi_node, "xlnx,zynqmp-ipi-mailbox") {
> +		ret = uclass_get_device_by_ofnode(UCLASS_NOP, ipi_node, &ipi_dev);
> +		if (ret) {
> +			dev_err(dev, "failed to get IPI device from node %s\n",
> +				ofnode_get_name(ipi_node));
> +			return ret;
> +		}
> +	}
> +
> +	ret = mbox_get_by_name(dev, "tx", &zynqmp_power.tx_chan);
> +	if (ret) {
> +		debug("%s: Cannot find tx mailbox\n", __func__);
> +		return ret;
> +	}
> +
> +	ret = mbox_get_by_name(dev, "rx", &zynqmp_power.rx_chan);
> +	if (ret) {
> +		debug("%s: Cannot find rx mailbox\n", __func__);
> +		return ret;
> +	}
> +
> +	ret = zynqmp_firmware_version();
> +	printf("PMUFW:\tv%d.%d\n",
> +	       ret >> ZYNQMP_PM_VERSION_MAJOR_SHIFT,
> +	       ret & ZYNQMP_PM_VERSION_MINOR_MASK);
> +
> +	return 0;
> +};
> +
> +static const struct udevice_id zynqmp_power_ids[] = {
> +	{ .compatible = "xlnx,zynqmp-power" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(zynqmp_power) = {
> +	.name = "zynqmp_power",
> +	.id = UCLASS_FIRMWARE,
> +	.of_match = zynqmp_power_ids,
> +	.probe = zynqmp_power_probe,
> +};
> +#endif
> +
>   unsigned int zynqmp_firmware_version(void)
>   {
>   	int ret;
> @@ -610,106 +710,6 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
>   	return 0;
>   }
>   
> -/**
> - * Send a configuration object to the PMU firmware.
> - *
> - * @cfg_obj: Pointer to the configuration object
> - * @size:    Size of @cfg_obj in bytes
> - * Return:   0 on success otherwise negative errno.
> - */
> -int zynqmp_pmufw_load_config_object(const void *cfg_obj, size_t size)
> -{
> -	int err;
> -	u32 ret_payload[PAYLOAD_ARG_CNT];
> -
> -	if (IS_ENABLED(CONFIG_XPL_BUILD))
> -		printf("Loading new PMUFW cfg obj (%ld bytes)\n", size);
> -
> -	flush_dcache_range((ulong)cfg_obj, (ulong)(cfg_obj + size));
> -
> -	err = xilinx_pm_request(PM_SET_CONFIGURATION, (u32)(u64)cfg_obj, 0, 0,
> -				0, 0, 0, ret_payload);
> -	if (err == XST_PM_NO_ACCESS) {
> -		return -EACCES;
> -	}
> -
> -	if (err == XST_PM_ALREADY_CONFIGURED) {
> -		debug("PMUFW Node is already configured\n");
> -		return -ENODEV;
> -	}
> -
> -	if (err)
> -		printf("Cannot load PMUFW configuration object (%d)\n", err);
> -
> -	if (ret_payload[0])
> -		printf("PMUFW returned 0x%08x status!\n", ret_payload[0]);
> -
> -	if ((err || ret_payload[0]) && IS_ENABLED(CONFIG_XPL_BUILD))
> -		panic("PMUFW config object loading failed in EL3\n");
> -
> -	return 0;
> -}
> -
> -static int zynqmp_power_probe(struct udevice *dev)
> -{
> -	struct udevice *ipi_dev;
> -	ofnode ipi_node;
> -	int ret;
> -
> -	debug("%s, (dev=%p)\n", __func__, dev);
> -
> -	/*
> -	 * Probe all IPI parent node driver. It is important to have IPI
> -	 * devices available when requested by mbox_get_by* API.
> -	 * If IPI device isn't available, then mailbox request fails and
> -	 * that causes system boot failure.
> -	 * To avoid this make sure all IPI parent drivers are probed here,
> -	 * and IPI parent driver binds each child node to mailbox driver.
> -	 * This way mbox_get_by_* API will have correct mailbox device
> -	 * driver probed.
> -	 */
> -	ofnode_for_each_compatible_node(ipi_node, "xlnx,zynqmp-ipi-mailbox") {
> -		ret = uclass_get_device_by_ofnode(UCLASS_NOP, ipi_node, &ipi_dev);
> -		if (ret) {
> -			dev_err(dev, "failed to get IPI device from node %s\n",
> -				ofnode_get_name(ipi_node));
> -			return ret;
> -		}
> -	}
> -
> -	ret = mbox_get_by_name(dev, "tx", &zynqmp_power.tx_chan);
> -	if (ret) {
> -		debug("%s: Cannot find tx mailbox\n", __func__);
> -		return ret;
> -	}
> -
> -	ret = mbox_get_by_name(dev, "rx", &zynqmp_power.rx_chan);
> -	if (ret) {
> -		debug("%s: Cannot find rx mailbox\n", __func__);
> -		return ret;
> -	}
> -
> -	ret = zynqmp_firmware_version();
> -	printf("PMUFW:\tv%d.%d\n",
> -	       ret >> ZYNQMP_PM_VERSION_MAJOR_SHIFT,
> -	       ret & ZYNQMP_PM_VERSION_MINOR_MASK);
> -
> -	return 0;
> -};
> -
> -static const struct udevice_id zynqmp_power_ids[] = {
> -	{ .compatible = "xlnx,zynqmp-power" },
> -	{ }
> -};
> -
> -U_BOOT_DRIVER(zynqmp_power) = {
> -	.name = "zynqmp_power",
> -	.id = UCLASS_FIRMWARE,
> -	.of_match = zynqmp_power_ids,
> -	.probe = zynqmp_power_probe,
> -};
> -#endif
> -
>   static const char *const pinctrl_functions[] = {
>   	"can0",
>   	"can1",
> ---
> 

Applied.
M
