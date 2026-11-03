Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8AF606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XM3gV7w2;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=L1PPjtuu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4A9C607C2;
	Tue,  3 Nov 2026 14:38:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zZilzXCRcnZT; Tue,  3 Nov 2026 14:38:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EC3C66066C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793716694;
	b=jHJgPtReoQ6ixc1YHUscDTrG6BNNiv8ieIzFp7i/1PJUNvyAvvcFXkvfrq4bkPIJAxDX
	 BtuCDZVXOo9op5rrB7jFCouu2Ebtc7ACytWvSECOd9miRPOrHMwyWX6gPAspE5lNk/6OI
	 s4MBP7hk8Lji63LwEvDjWChyIIXvc494P7ruEe+X/cE/qpfPqGw1A6L/lydvohCgJs5LA
	 oYzD+GImBPxp5+GLxX6GWXaMSTHntyrIPONKDSwyi3WZVqeB3HCk89UYu4wWoF1Go8YcS
	 XaoGJJrhZN1er0+tJrtd5fo/j/EarxhzJBwqW9z/8GxyiJQWfNzTrfTXbW1HMJZVYTA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793716694;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=o4Wv7Wrd7x2nFxgMXtaajyNB/FtfrPK7JbF8DrK6PlU=;
	b=afN4gurnm0BMLwneHqM1vzsOc1trAM6kyk0uz4s6rBSwCDa+wQMYeKOcnt8kQdi0uAdS
	 Nuga0gVTE4BG+4jUOzLN0VdpLa6ce+mTRAEjy+BuPiMOc39FQjmEoYZuB2Fnyf8gA8uVA
	 mKGyXh3V6fXrHvlBvaUHST9R6cVTZLEjQ9nYh9Fa1QYnzyCNZA/jDGoW584FJvfBVt75y
	 C2Fmy5ievswPcz+tsth4/zQR+1sFZvbBQBeDuiW3aOd1vYs1m8jzaVQrQGxT+wUrlCgKt
	 e6N5bMNq1vMCpa5ghtAVhCEGaOJbUUMcvVfSfGigmI04YK5ZsUgwGV1zrNKN5fBE1yQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793716694;
	bh=o4Wv7Wrd7x2nFxgMXtaajyNB/FtfrPK7JbF8DrK6PlU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XM3gV7w2Wgj/zhEfJTIhAAfq4+lc0ACNyGZyAL22rEU5B24471MeGXT7sGs5qdO43
	 0o5lW0317OMrvHZOOPGuQNA9DEDbvskRFqw3VfAM9QwqZMhhv+wDvvJtVSFa9ferCc
	 EgzjCjnAgDd89MzF6lE0asUwbtj6j8KoCRa32Mh0zbcUr7PyS1uw0vTaSOxj3+xqeU
	 7n2N5wavt489/BTBdkNvbfZe7NJmLtq3dNIFKlaa8UmiK9V/gfqOI5oc8XkIpvzpOX
	 u7dXth2WAqhcC8XhvVZfp52kNdgYhNh9d1cZLylC2XRvKCmPbMJe5DDCAal/jq2zrQ
	 ifR7adpx1YDmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC3C66066C;
	Tue,  3 Nov 2026 14:38:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DABB311CA
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CCA5F406FA
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:38:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 98fXWd_dlRDZ for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 14:38:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1093F406F6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793716690;
 b=SQvKKlkDzgCsUhP4ThfAmrFvZJFpBzcsB496aaGr2BrYf92WwPimt69u35M0fPmsRbdV
 8ekSQVoMTh6KxNfZbV2ffhmfvsUwaF1FdvWI1KjbY0jTbwXxBpbxdvl+5Xr5YD3K4uwzW
 RQOeewlyVdcjlB9bA9QNkvX3xD3Bw610ehK4rKAltZqK2tQTQpbL5KKjdFtlDaQcPE3Aq
 JFqx6EOOpej7BGB0l7zZtPRSjaGCFLYt5MPy1IKOB+ljabzAuKEDRZ5cJs7neu7Cd6DAc
 scpiBXf3+VruaOIbxS92+YtycqOlQaJSwcPDtVcvZMA0oINSmAdPOG8CnxMPYFVDzqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793716690;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=o4Wv7Wrd7x2nFxgMXtaajyNB/FtfrPK7JbF8DrK6PlU=;
 b=dwuZfXrWYGieSZNDMUimodQEKwknpR22+R9PVPozIxHkffsqNrXfAVVILiEtuKMvpb21
 kfvXLjtMwaDKET0Bn4AK8DAY51Szbc1t61h7t/fvk8b6aqsxclXSJxKH15YcRyIjyJ4Sg
 9MDgHtFdyrhdwtOOh4l0Aal8IB7+smRAsvLdjn2yUiqdcgL38KucFkWbJyGskSThsLgrD
 AbOqzWu0uiQPyJuKLehHU8byCva9nlPZr9EbvBaR/Y6B3iM8O9sh5n3C+doIucnr8SrPq
 L9/iB7THZ6JTr0RmDaX4e+F/ZDpmrzg7t2LbYWCM85gZzB1bKDNkXadRP4vr/PMsMIA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 spf=fail smtp.mailfrom=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=L1PPjtuu; 
 arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=L1PPjtuu
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1093F406F6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:38:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0005484821; Tue,  3 Nov 2026 15:38:04 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9368483108
 for <u-boot@lists.denx.de>; Tue,  3 Nov 2026 15:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imlS0XfgPtcIa9bAw3dyfYVIAgafKudI/vUqqWEiv1iGVS4AukISyGPBwkqZbU1MseA4LYPnYu0MLFXqLGZ/p8eiWI6BBEOp94Cr8qCejANtevlg3tn6TPGC3tlyblF/zRZJcj5rx2tAYXD2zehRwQKak9FmcJ3fZGSJ53XB/nDZ32yY5/vU/KaVlKbf3TPOia1uPGEUtLTUOZNSdvPkaFOQOzA2XggDYTX+9PfblOPIejlQbUCB1BiplHhEpjb7U2mL9KYkYoYiLF/coUGRBtbGfbwJ6a3VnpmWze6XBqd04OfBD17a1wQDOWgNe6xW/cjY+ZhcT02eZfJ2SYDAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4Wv7Wrd7x2nFxgMXtaajyNB/FtfrPK7JbF8DrK6PlU=;
 b=o0y6SpwV1pKIEatQB8EwapeVYShkLa7zslkS40n+Q7fw6s9ISHJl+Y29Omgf61uCW3i2F+7I01D4LKHAdn0MRlN67oXWyqpLBoWPgCQvsKIdZjK/DsK8HbMeWpq/ERixHu9K22yx3BXRlf29ymzQXAeMItkQSKIlR8h0zv/hj2JmcP+jGJpw8x+gm9T1HqAxj33TrWHakkonfkZr0dUNnVcfiM0SDV+mUfFUpMDTXzSFyTyJqx+j04UyO02y/vnIKnqvvcPWOl8RaiccwlRKNGxvaWnXwDTC6HI7kmuL5ipb7JeW9WuVfUxmNI89RUXcGKd23NrSYHbd2CX73qViWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4Wv7Wrd7x2nFxgMXtaajyNB/FtfrPK7JbF8DrK6PlU=;
 b=L1PPjtuu/FCvykRdCgBsIwbP6Ikhk1N9/xYCddvHs0yacxFzccxJSv0Dqvnh+uMaSVAzsFFp83XDKWgxjjaq+xLOJ7BxtxCIi/kGjGvDEd5ukJkuFrT575pHnGsDO0iIZVRPPEurZC5x+Nxlhwl5SztT73OcY9Dy/h/5eo+S3pc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 14:37:49 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 14:37:47 +0000
Message-ID: <073c9959-2b6a-4547-a025-451d0a753b0a@amd.com>
Date: Tue, 3 Nov 2026 15:37:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] net: eth-phy: release the reset GPIO on device
 removal
To: Graeme Smecher <gsmecher@t0.technology>, u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20260820235850.341023-1-gsmecher@t0.technology>
 <20260909171839.3079338-1-gsmecher@t0.technology>
 <20260909171839.3079338-3-gsmecher@t0.technology>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260909171839.3079338-3-gsmecher@t0.technology>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0034.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36e::19) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bdb6f86-9969-4206-ea5f-08df39b80772
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|5023799004|11063799006|4143699003|56012099006|261009223027099003|261028144727099003|261021121427099003|261026140227099003|261026121527099003|261022105027099003|10067099003|18002099003|22082099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: NVH3GkFDjw4qpqH470d8V9stIltN9uftOMKP0qzmzH6MCvmRF7gMLIxaWmhNJ/VjhOaSFC19Xs1njY9CMJGc+7vxBCp2+WtWivaZ3w2d9iGqJJL782FaXXk6SI4yz1QW7/qpNL4Wp7d4qkVGf13cF1AywYdr+lezABFQ2NTl3LF3aj7C4DDvAUsvCJ5HEGGHCoSp61VUdC24iHy4TPITjmZg23rn86O9oFkr6vk+zXEF3fJ49VQXAjIn7U0GwgiDiB2JN0P5NWAVC8e9YaGPp/AGkOmXDJxh/21FgMiX4i1zKc9Nt1aaaQnmudz3pgEeInR0F/20ndQlJ0eXouJlR6sGsDPA3M8NEVO/+rRZintpiftDnvC1WTs6PQJSVgUWNnRMmYTA7xT75PFf4UKmnoylCztuXNHlMk9LyG6e/CG7fE0jJg4dpAm0GaPxT+RvCCcWeJYh28VmgXPS2OvUyrFEUbatW6AwChdwsWCiMxpbuoAi/AKQe5VZzB+kfotJIiIXGELsqX5dXKJFmkmkaFhaXrDbciSs2cRHszO8sIgBBCaUIHArjKRmDv0nn7W48uGqoPIlnvRitCDEOYxnJP888AYp+CCcRBg3WzOAgM+tPJRkUzBUVXNLVmX1sluJb5GjOTbFUjrFPtq36VbEV7arGGsm5D4b1oTZy9eNKIE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(5023799004)(11063799006)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261026140227099003)(261026121527099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWRJc1N0Zk9GbSthcWM1dW52blJJUUtHVk1mSjlXenFWYjJOMWlBbTBMTmlX?=
 =?utf-8?B?cWlvSjlHTkN1V3dNeUxTaFlITVdGQjR4ay9oL3RBY2VyWHNpNXNKNUZySFpx?=
 =?utf-8?B?a052RFQyNUkxMmhPNmEzN3RXZFJiamtIRmVIeWxkekhsbGJ5c1NYT1pGd3Ez?=
 =?utf-8?B?ZGFlajErVHVONWZLaUFueEJPZTBjVnljSDNjYU5GSUt0bm5EbWVBOWZUNmxH?=
 =?utf-8?B?aFdaM3JhVStrb2duU0s4M211cUovenZmRng4NEErZWc5NGM5Z0VBZENFVXBG?=
 =?utf-8?B?R1BmeDBLRmwyK1JobnptWkV5US82Vm5DZHFEVnNQdmhqcjZJTmlVM1ozb0hC?=
 =?utf-8?B?M0VOSVFEMExBcTJMODk2NEUyYm1LUXB4QzIvcHEzME1aZVRBamdMb1kwZ1lX?=
 =?utf-8?B?SmZjR0tWOXRxNkh6TWN1THViYUI0RFEwUGIrdUN3eGJ3K1VEdGI5ME96Z0tB?=
 =?utf-8?B?MjZjRzRVRWt1UUs4Z2J0dTFWc3plQy8wUUxhSFV6OG43S1llVzg1NDBscnVp?=
 =?utf-8?B?aG11RE9QcnhHZzN6OHRHallVbVAycmR1dWlSYk9IUyt4N0svbXlORTNOVzhX?=
 =?utf-8?B?cG8wMmRxaGFINzh2V1hncllrREFYWVNueVk1SmdDTGhNdWxsQmpXNEZLL1pW?=
 =?utf-8?B?ZFVZVzNHQjZaNXdNYlVJVjdRcnRiM3ZaK2EwYWF4M29uVHdUZiszY0RZeHRn?=
 =?utf-8?B?M0VPWk5EVm0xQmxNRHBBZFM5UG9zc2VCMjd4VGlmMlpTRGRRZUNDdXhOZ0FQ?=
 =?utf-8?B?cDEyMzgwZjJGNXpBY1FhYnVTY1ZKME9rVnZyWEhvSUVWQzRSZENHSElYdkZB?=
 =?utf-8?B?N2wrSytvTFBwQ2VtSEg0Y3hCb2FCQS9lSXZmL2k4UDdmRjFxZEZodG5ZbFc3?=
 =?utf-8?B?UnIwV1hrcDMzV3I1U3doUVNXdmF1SzhxVzdvWXk5WVZHZUh3Y2xzNlBrSFda?=
 =?utf-8?B?WHQwN2N3RUpubTVKWmRnemZ5SVE0aVBwWWVySnd3Qyt6T2xjQWdRUHkweTUz?=
 =?utf-8?B?SEUraWhNRER5UVhVYU9PNzdXRjZyaTNNME9Qd3NONFdKa3lMMm1pVCtNU0Nx?=
 =?utf-8?B?VjBBbHFKSVU5Qkl0aG5hVXo2V3hDR21FUUhIZW1RTHBqQjRqM3dsMk5pQmxL?=
 =?utf-8?B?NVp6bTVRZ2pZMDg0WE1QRmJXelZ0WDdDb1dDM0UyN2tQcHhCMnJ5ZzQ1SGJa?=
 =?utf-8?B?RjYzS2YvVkVsekZmRmZiYndyNTI5YWM1aTU2aklna2dseHg2SEdwWG5yOGhI?=
 =?utf-8?B?bjJzV0VTYU9LY3RRUjlISmJ2cDEvaXNqNithY0dOVVpsY0lXWk5DUDBRY2Ji?=
 =?utf-8?B?RGVrdHdMb0hweUR1T05tRkFodVhwVkFvNFo0QXBzY3h4L0F2emMxTm9YekNH?=
 =?utf-8?B?NTV5azNHSFpRTDFoRWY5bGZ4T1hIU09BcUx3TTdIMGpiMEtodi9JcmdwNG1L?=
 =?utf-8?B?V2xWY3BsZVlBT0FJcEs1bmp2RDJPNG51eS9HZGpsWFhla0FoeTRkb0JvZlFW?=
 =?utf-8?B?bElqOWJkdmNTeEJNeWQvNHdybDFGditlMjZGd2FsQnFhZm8xcTJPTU13dmdr?=
 =?utf-8?B?UWpvb09TckppcnM1Y0hYYVZEWGxiU21lMnZ0b1NQaUw0U1NUVGMxLzJqd1Za?=
 =?utf-8?B?dHRHV21KM2FGNGQzQ3FUazExRzBCenRVYk9XV1BCVXM5R0tzUjZXaUxnN2Vj?=
 =?utf-8?B?dWZ1bXN5dGxDSFhWb3B4RFFuY09jbERWcnYwQklrdStxRHNuSjQvaEZGWWpp?=
 =?utf-8?B?U05qSzBXdFJLbWFMU1ZPUUFObmxnVUVXT3NmWkNFdnRadzQ2b2YvNW0wRWFH?=
 =?utf-8?B?MXU3S2dWTFdZVDRnZk9XTTNLZ2YrOS82ZTJVUUQzaEVHb1A2VHlKNnhCdEsw?=
 =?utf-8?B?c0FSTm02bjRnQVZROWtjdmNlOVVpcGFYd3BwMTNCbldsSkJrSjFBanJFcjVk?=
 =?utf-8?B?bnZIQ1M0dGlnTU9SSlkwTUJDeS9IN1NVM0V5aXZSTG9NK2JXbUVoZlA0SG9U?=
 =?utf-8?B?UE9uYWRhM0NPNmVuRnpwTWhZcTNQREtORnBPZThKQThTVnF4cjI3ditHVm5I?=
 =?utf-8?B?V2VQbUhJaGJYQWZEWklXbjNXNm1uV2VWODFRR09qM0VpclNOS3Q5NDVUQWxO?=
 =?utf-8?B?T3B1WS9jbzFiQWN1cGxHaEpwWS9lZlMzd01uUUhVb3ptOXVmWHJ5ZWwyU0Jq?=
 =?utf-8?B?ZWRiTFZ4VXIvZ2ZxZG00SElBWVNiS3dMVVgxeGxBb09iVVg3ZE1YT2EyTnNG?=
 =?utf-8?B?MGxPMGhXQ3JoVjFqdWhSc0hoOHUrRkxEMG5QcUcxbkdkNjQ3Q2JNTHpvdUlR?=
 =?utf-8?B?Mm5sTGd6NWZGSXNDSnk5RzAySHc0ZHBMazA4K2k5ZEtZb1NLeEp4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdb6f86-9969-4206-ea5f-08df39b80772
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 14:37:47.3433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlcOtT1XmtaF9nzc5TtcexttQ+aMuCXoUuCQ+QwuyUlyDMrmixIuMRZMu3FewWNn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 9/9/26 19:18, Graeme Smecher wrote:
> eth_phy_of_to_plat() claims the PHY reset GPIO with
> gpio_request_by_name(), but nothing releases the claim when the device
> is removed. When retrying a wedged PHY, any follow-up probes fail
> because the GPIO has already been claimed.
> 
> Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
> ---
> Changes in v2:
> - None
> 
>   drivers/net/eth-phy-uclass.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/eth-phy-uclass.c b/drivers/net/eth-phy-uclass.c
> index 1dae26878e6..e93a358a2a6 100644
> --- a/drivers/net/eth-phy-uclass.c
> +++ b/drivers/net/eth-phy-uclass.c
> @@ -181,11 +181,25 @@ static int eth_phy_pre_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> +static int eth_phy_pre_remove(struct udevice *dev)
> +{
> +	struct eth_phy_device_priv *uc_priv = dev_get_uclass_priv(dev);
> +
> +	if (!CONFIG_IS_ENABLED(DM_GPIO))
> +		return 0;
> +
> +	if (dm_gpio_is_valid(&uc_priv->reset_gpio))
> +		dm_gpio_free(dev, &uc_priv->reset_gpio);
> +

don't you also want to call reset_free() when you are touching this?

M
