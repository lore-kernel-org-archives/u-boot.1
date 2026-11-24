Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488D606A33C
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vru+uq6V;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=28SHWXN2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B182607CE;
	Tue, 24 Nov 2026 09:26:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JIWYTwbrK3KF; Tue, 24 Nov 2026 09:26:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D20756067D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795512361;
	b=K4yYmD08kPzjLE3YPNJvCM3yOYduCaOxPz4Zu+W1UbE4In1WXkVUTFw/dZ64hit6mWwQ
	 ZpV9oZAaNp70pA0piJAPzzeSWIHo+BlpH6OnrmUMHaELMXslPnaFCGERqwruLCbEOPYqa
	 D3i0FVFpN05lIexsoOeweEoJWlDoq3qQFTMr5HQNvkqk0IMDFc79fwdetL9ywaR9NG778
	 miYIHUhVymPe8vEGQxQoiRJk5XpsgNw99D4ZjL+MYjk3uQ9pznkDs42VFVFLScBiFanfG
	 SjfWtYxSV7SBTf/0KjNVlGdQTWWc07xEcqsWibwpu68PZJ8uTf2qIXHxyc1U/7tVpFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795512361;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5gWbSaeSB+b5n6cjXfNXQTFw+Y7UNyoSUy0K1X+Vyew=;
	b=GTAPDevClRqCL+ysSwhXn4NeRqkSHpp1/5JPcwnQPDb3pmDzLboySN5NOP/jKhZ5dwb8
	 Y/sXHrWvDMn21UwBPItTioPrIsxVfsYaYeaTlt5nIJX9T/bl+icLFB2p7c66EMxI+lBKq
	 Iz91amxUdMyiybJeERUHBv0fze+zBDWXfOr2pNq6mr1HozqcM6OLwamudSsOl4w7xqjdM
	 TPkK7m5TShPwJBChYNsnC64sZikiO7lDfpHS7tF8oXrL5rDjacDT6hWHaFbTVoFMuc27s
	 8Fnlm5cQ0Uu53uYiu2++02ojejGtt0M5mPGutQu/yQW7IDgiQvzrOitF02by063nLGQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795512361;
	bh=5gWbSaeSB+b5n6cjXfNXQTFw+Y7UNyoSUy0K1X+Vyew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vru+uq6VLJAnYr5TNRXmBBdIYJNawKemLttcC42nhT8T0gjw4xUunsDAeltZfRz8m
	 dgzX+ZqmF9cs+80QPIkhcZcSveIjGyknMAWG7eKp84JJNp4gh8tudiUcN44tG089rs
	 q81rLmb40CsRciqRgi5UZPTVkLwR83zwiQxHKKEAgf1532o1ZdQDUQ01nlSNX9g9Pm
	 Nl5rAqB2tgxMRJEe0KLKYdv9IM72M4zLIEBsNX2pNsBny79YnnE8NweWFEXUtrVOs/
	 GaSB+IA09AfIwT2upBKZyCpnnrP7mJWWuIfFcrl9j2/oS4sCgVb4XHwkgS9oGq323M
	 qavshmfhkqcZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D20756067D;
	Tue, 24 Nov 2026 09:26:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FF5DFBB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7559680F46
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:25:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DA1KCaJUPQ9q for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 09:25:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9D0A580F42
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c101::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c101::7;
 helo=bl0pr03cu003.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=28SHWXN2
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D0A580F42
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gWbSaeSB+b5n6cjXfNXQTFw+Y7UNyoSUy0K1X+Vyew=;
 b=28SHWXN2MyoKv6/NRH1Svzlz5IWXtpal4cQDXWsTbMqMD5RfgzpeefqVhZMeTvLPkaXV5r56MTylvuERjiYXC7tsHj565EsRxnpS3uPtA8XNFi8sUrgW9iZvMgcHDrN1OEIRQzWF3fjmkQrp7tc8rE/qUiRJ4vRIAmIPt/R6mRE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PR12MB052986.namprd12.prod.outlook.com (2603:10b6:8:47e::11)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 09:25:50 +0000
Received: from DS5PR12MB052986.namprd12.prod.outlook.com
 ([fe80::4e51:5777:a687:af48]) by DS5PR12MB052986.namprd12.prod.outlook.com
 ([fe80::4e51:5777:a687:af48%3]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 09:25:50 +0000
Message-ID: <38bbc8d5-8461-47e8-ac9f-8b695139e199@amd.com>
Date: Tue, 24 Nov 2026 10:25:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] usb: onboard-hub: update supported hubs on stm32
 boards
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>
References: <20261124-usb-onboard-hub-v2-0-ec527e27994a@foss.st.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20261124-usb-onboard-hub-v2-0-ec527e27994a@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::12) To DS5PR12MB052986.namprd12.prod.outlook.com
 (2603:10b6:8:47e::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PR12MB052986:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 226191d1-a0e0-4daf-3ef5-08df4a0cedf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|10067099003|11063799006|56012099006|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kCNEK2tJI1f8DRVt01vYL1aJrELuixv3fEqiao6WhoDRFWLOE+7omreUrj6YtbWlKP+c0VigNMCA+ih0mqPHo3tO+J7eMP9SjSLl/j5OxABxmrFh0ELZkP70MwljW1Ax3+ENlPtt33epojpR/rp+ffUiGsKyM5VPMZhNENEvFr8GU/v4ym9eHdv9gawkzzSKoW7pNDMP7fkiaeSEVa1GfTp8nq43P9AZYeMKvOqQZygW1zJ04CacdbF+FjxiXXF7vTyepKIv92GFlJwEBchL8G6pzeS+bdq+RmrsUXdH1YVWYY+oKdkqsiYg22WMUVv91ooELt+WggCp5lhXE7369lj7P+hqK4ohtaBw3haUvctralkJ/cHGu1I5/XkeOu5obLORgxQaa0bjalcdcJwS5vYae5rrn3/waEqI4U9rZtPye9Uk4bRL5CiE6rMXTyX5ZOOXkKGTXj52urPOLZqiMqOp5gnmkBannbA5443zL/iJq1F+u13Rs36jvun8M9WLVneC0/cNmcz5uQxbPq0V9VUMixVfK/DnqXyzbINx880trm10vEV3DYdxSbvfHEy4xXlV0jNFaqUf8gjo4oN4SSiw8hdwkkLlzsa8/VHfHnwwqbtoxg/5RH0o27uE7wDC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PR12MB052986.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3FTNEpyZG0wK0FDWlQzRFVWNmFlbHZ3Uy9jV3JxWk9TR25FSkNVZ3JCQWFU?=
 =?utf-8?B?TTJpaTI0QXl0NjZxcnU4YXBzR21ZWWtOQXFEbVV4SVZPOUJWaHRHVGVCaXVB?=
 =?utf-8?B?NVVIUmlMQTJGaldSeUNJbWpzcEJJV1RTUWpCL0xqRnN1ak9LRDBjOHhCdFh0?=
 =?utf-8?B?UDVzMFpVdkZIZ2FVS0d5Snp0MDdZT3lrS0xBaW5rNHRyQ0xjUVVNUHZpLzNN?=
 =?utf-8?B?NmpWaEtnSjFPblYyN3RmNkZ6NDZIaXl0NDhTQ1UrMkpVSnFabU1ERGFZSEF1?=
 =?utf-8?B?U0k5ZG10MzFwRWI0U0ltdE1CamhPZWtPMDhST29hQU5LcDFxN25TVm5ERlRS?=
 =?utf-8?B?SXFmaS9SYVV5SWc2Z3VHTUpVWXlzRWZYM3dUdWkrc0I4N2hwQ1czZGlzMnFG?=
 =?utf-8?B?MDBuSEtzVU9SNVJuTHZDNncvYjBNQm1XSG1xNmpmdE42dXErVjRoZlhwZ0hz?=
 =?utf-8?B?eWFPUWVLbHhvYytkbDR1UmFsb3UzSHZVZWJTQ0gydmx3T2lnYUtLODlTTk4y?=
 =?utf-8?B?b0NYSllIWkxWRmtXWlFhZldBRXFSVk04OGRQcnpWeTlyZEZuaGQ1WGQwUlVw?=
 =?utf-8?B?cWc5T04yeFVCMkpyT2lZOHFueHRJMk83NkVOK3pEK0Mvdkd3bWhjSW5lZlNs?=
 =?utf-8?B?QURVK09mcEZId1NwZUNWTHhOa0RWME1NRVN2bEQvU2l3UE9LYSs2cGVxc0xV?=
 =?utf-8?B?TGltZzNnbXJhZ0FQd3FRN0pQQ1NBV0htcmZMWG04a0xWS1ZYTndEeWMvVWVX?=
 =?utf-8?B?M2FKOWFkN2h1K2RDanhxcUgybUE5VVEzZXhOSFdVNk5tT2FZSW11SGlKK2dm?=
 =?utf-8?B?bmdMc1BYdGhpTm9GWjBKL05jd1hsb3hhb2JBbEtTTDBzcDhOdFNKUFFPVEN1?=
 =?utf-8?B?QWJsaUgrRFI2VkRpYVRuUDZzWlBhcnIwRGJvK2w2MFVhY0Y2YWxLM3ZtSk41?=
 =?utf-8?B?cC9CSTJzU1ZjamMzMzlhWVNwNDVTKzJjTmFqMzVWc0taRVBPd1g1bFM2dkFN?=
 =?utf-8?B?bk5ESnV1ZndNalBjRFVVRGM1Q0o5aEJheG53cVJxdWhOUmpJVGcrMkhyQUVp?=
 =?utf-8?B?SG1xbkZSUWs5bmNxemU5WDIrQnJlOHA4em9YMDJEMi81RWc0ME93VFNIYmFU?=
 =?utf-8?B?NFIyQkpacU5RR0Vybm1kTXZUNTNlTkZjR1BTZ2hoS08xRVRSVFh6ZTUyQ0h4?=
 =?utf-8?B?eFpSblowSjZsOGgzbDNNdGpUUkh6NmpxVHc1Q2tNUlZqNmtjQ3IyMkFrMEtv?=
 =?utf-8?B?WnBWdWNlT3ZJdWk5cHJzWkxYcklwei9SdHBPczM3YUZ3UTlOT25FZVRzU0h0?=
 =?utf-8?B?dGl1U1JpMm9zLzRoc3lXR3diQXlMMU5vOXZFMFZQeDQyajAraENMMjhOUEx0?=
 =?utf-8?B?YjV2TGdqajU5djJQck1yNWlMZlFjaXpROTZzYWs4RW9WRjU3Tjh3eTFiNjNR?=
 =?utf-8?B?SCsxTFhmVzdPeXk5Y2h1MWpLelRUVm1ZQlhobHgwQzA3SlZWRllKaTV3OXc1?=
 =?utf-8?B?cGMyWVZEOElvMHR5eXZmOGQ2c0pFbzhUeTJBYzdxNmhkY1MyeE9HcDlpQnhL?=
 =?utf-8?B?SWJLdDEzeUZoaks2MEFDK2ZySThmdnV5WnRuR1N2SE4xTldpclN1N0U0WUpw?=
 =?utf-8?B?Q1l2bTJpRUFoN1pIWEhNeEI4dlN2SmxGZ2VUbzBaU3JMNFh6bEUzUFAzRDVK?=
 =?utf-8?B?SFMrZjB0bjVEVDJWYlNyYW55VnVWNDdvYmdmbEt4cTArUkgydmJSeUpTWGln?=
 =?utf-8?B?S3NUQ2c0T0RSajVKQVQrKzBmYjlPZkVJaWxzVk9qV0pvNkYxWFNNRjFpTGlG?=
 =?utf-8?B?QnN4WCt0T292WlpHTjgvSW1TWHZ2cXhWVWc2T0dnYklUeDl2RklYckxTb2h1?=
 =?utf-8?B?alNlNnp3TEF0S3ZrcjNjS3VSNWYxNElBVldtcjZ5RmJwTDgvMXRuU0VLQkNu?=
 =?utf-8?B?Ly9JVWdsRG84eHZuTjQ0MkV6dURZS095MDBJdUlrN3N0WTVxSUJlQkhwR002?=
 =?utf-8?B?b2svYkN0VHo1RUtwMVlGbEtRSTNlTVBCMGRGTmFGUVFFZU5mZW5UdTJsY25P?=
 =?utf-8?B?dlRBMnpCaEdib2NGQnNzVFVXYjk2LzY4TXRJL1IrVVFteFUrcDFxNHdpZTJk?=
 =?utf-8?B?Yk8vK2x6enJKcThqUkZ1VFc4VnNGTENHZzEwTFRXTDJIeXphdGprbitiSGEw?=
 =?utf-8?B?enJMRW40MndPUTlCUWtjWWRCSWdMc1VVcklLSVpTZ1YwOUx5ZjBtOGZLVzM5?=
 =?utf-8?B?dzJYUG5FdFA4NFJLL3pTNkpKSWlsZEh4Q0dIVG5yZXI2YWRnSTFqdVRVdGJx?=
 =?utf-8?B?M2I5eGQzWHJEcEhRVTc2NWZXQjdqNEErWkcxc21KTWJzazdYR2VSdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226191d1-a0e0-4daf-3ef5-08df4a0cedf2
X-MS-Exchange-CrossTenant-AuthSource: DS5PR12MB052986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:25:50.3418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XvDzgRi4n7mTO57iygRba1IyfkaYkzZjILktSku/M5B4qlOm5HLBwqEEE4oHXn9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/24/26 10:10, Fabrice Gasnier wrote:
> STM32MP1/STM32MP2 boards use Microchip USB2514 HUB or USB2422 HUB.
> The USB2514 HUB can take two supplies. The USB2422 isn't yet supported,
> so add support for it.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in v2:
> - Rebased on usb/main.
> - Updated commit message on the 2nd patch.
> - Link to v1: https://patch.msgid.link/20261119-usb-onboard-hub-v1-0-22aa6ef1d9c8@foss.st.com
> 
> ---
> Fabrice Gasnier (2):
>        usb: onboard-hub: add support for Microchip USB2422
>        usb: onboard-hub: add vdda support for Microchip USB2514
> 
>   common/usb_onboard_hub.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> ---
> base-commit: 357ffe9ded8988c8a31e95e5305bb766b2625236
> change-id: 20261118-usb-onboard-hub-dcc8d830c04e
> 
> Best regards,
> --
> Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> 


Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
