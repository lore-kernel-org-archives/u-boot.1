Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C233C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 15:42:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D889F80C86;
	Mon, 21 Sep 2026 15:42:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XIrsWBeZ5zRz; Mon, 21 Sep 2026 15:42:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9A74B80C87
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790005377;
	b=IporL/1XxssJ9+DIAUEpKL1Rd1xK/rEbDiIkOE1XIyOPOyWoqYuoQczrap6KwatAonzM
	 sydgTOm91GUL31A926bH9eulJRdpuyvQkJHN1bu7i7vHIknb8paIhlwbq3E6VncxcuJsT
	 nXqbRwAp2mEZtG5Y5kMdm+1Ryjpu+IxzFClT8GKy9un/rFdHydAD/hWmKiBWykytkZ3js
	 1AFMk2Y+fO28yssfBTlYba94yh4MtOj7O29lnUr5zJ/TBInSxKNGfftpn/4YhF6d42qjG
	 5DapzlIUgc6FnQBQErXwqczL/RXRk22o2H/dDUlJ44TOFpLxaUp6azWQ8P8X7og8jSg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790005377;
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
	bh=2fj5K8qhlMys7EfJLxbzhhlIqrNgjb1CqMadX+DrSYA=;
	b=ILN7pSVhCU3/etQepGLmOimW/5LaSTlnEzg5553AKfpWc7zt/tGmFJPJSv65p9s5KMnB
	 N8VnqMb7EehDOk2ukkZwZXpYvfKjtJveIMNANKUxxnbSG5htIaqjlmh6h4FcTngbYwAQO
	 sQOBpxFDdazFQyKT7nYYae9qoQQMW5DJz9EOee0eHw2jp6PGyJJJ2rZZA7tF73d+nEkww
	 7IGQDFXnylQ9r4SE3daNXvUyvpqK5qe4EOUSClWdUaTquU3hURmCcqzLlXVc1LpYj9Gta
	 KiK6PETI4CFbdG4ztpkqGWTm+3ULUM7AxBnfDNRFPA15w/BaqNDCiXZykiiVpzVBBEw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790005377;
	bh=2fj5K8qhlMys7EfJLxbzhhlIqrNgjb1CqMadX+DrSYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iCvilk6u7es1z4D5e3wwDlnd9ryjJsK57hw65dE/kFGflzhlweqM8q+4kfdfbu4om
	 LLog5bD5R/dETe7IJDpkHtbQ7HswUhy8Wv5i2HGqBpvCPMsJSzjKOoKlYrqRK5yn7f
	 A22QBmKGER294QpEaV5MtB8KTVdnyRHDjxt4tCqxyX5zVl27XgtCG5aRjZ6GJc4pXM
	 WFsaDAh65AGWt+MGqvLZJtLfH3e6ZKmdoZwAIc5yLAGBEsMrCJtpOSMn9Hm7T1vdRh
	 QJRw0yNjJRbilQpGohqR911bwsb+I11RtpLMKAu1h49Yc4mcJYpc4Qzt1mJsVJkmx5
	 z0PyQkZvXOX+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A74B80C87;
	Mon, 21 Sep 2026 15:42:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 984A213D
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A3AB60680
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:42:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jCNygcX9Nrx5 for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 15:42:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A7AA86066C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790005375;
 b=K4rtuKokY1Q4mZnXrdOMqsFUo9l0jwJDsJf+4gV544dk7BHs8L9eCFQr9zvXwZ8m9o0x
 8fRomg/+84kX8pF2Ac4giAhA10FaJM3GYJxtI/Ptigp5DuekYuQiSOTJsMzoBEwxLd0cF
 UmJg5ThsuowXnHXdGdyG60qRubl7VlWVXfCBE8S4Rz++IbuXrE9hglOpDKVq9+g0HK8QF
 Nf66ALCAHsbO7o9A4OqWL3+2Oh3uFHxWLf+P8Zv7zCGOhJJuf+DWk/NfVrqnKNaHLF5+B
 N46mB001skuLriND+DMMRn5EqFnkWLpkYZlZZYLxDBIhxutaiRFZWvV5ZqAxpiMRz7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790005375;
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
 bh=2fj5K8qhlMys7EfJLxbzhhlIqrNgjb1CqMadX+DrSYA=;
 b=JI1+SDXnM3iYQwq2SAdAAqKF2VE7f4tK18U/pDuijNIjs+NtF/W9sRBFlOXOswQ+/mCU
 N2TjDQDq8YoZw4Mrwk3K1mJofeZ7+QH3nrzzuZMB5V2Kot7Fo4qlRczJkeUnLUNZdaWnk
 3DnEQs+O1F5z8dar/d1J1gd12kM8LRvmxsoDoSg6BHHl3aJ8mAunWIn6wefmk8MAW4RJ/
 lbuyQj2XCCuAdCytuKVkrblilKHlCiITEBEpJWQnwZYe3gKKTyInKrla3Ri5sU0Rnsf+D
 oby2tARjt9WtGFncR8elxlDZTiph/GnTgWB4JuAfecHJ6e9m2OQn8X09fCJuY5XHfdg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=esmsAVNG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=esmsAVNG
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7AA86066C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:42:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZ5T+6yObHxxtPFKdW9XjvjolZ9AWZtJriSA9CSp1Ry3YDglWBj7PGJpnY67nOi15F86KDe9GjciGVUHh0DagIhdF8cKhNzh/lFUosohR3zJgChRE1CQQw5CLS7ufGncYqqL9LWFhxkDyfGA/9q2WkP0XUXFFnCnf4rd2bb3aTX/pipfMq1u8L6hUzoxi+ad6ZNx2Kut8akUznc3EMe0v7ALdqXFb6qwFlfDPoFM8iy84WGash1GouIw0dH/nGdWEt+NGpWtWy4qg+brr7mkGBuSVU23ffdcg/FCLukhspvT1riRlcaya7g1Io4jE5lFYHSWQbD/tK/Re1Eot94RQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fj5K8qhlMys7EfJLxbzhhlIqrNgjb1CqMadX+DrSYA=;
 b=VnQCxBF4KSTGCzv6K9poHORO0Njk/0cs2LRg0rwTztUrzZj/pmbYEuQUyV/NM7E6q+S87p1T//IgUNRoC3w60lf6nrAATQZjLi3EgZUPbfIoyOndxhxTM9UBzVjQ66V9bOS9+NA9Ao7D+4yN9bDsGa0sq6eqjcmjBsT+jGguxrpivUDm4LYepWxF7oVvZBwmWB7X9ac+fSgVp+vndK9JwgzA/LIg7ZgwqClfKpUEN/XtxqmrqRdg4TsFW8Jg6WVG5R4MgSEyGmUY7/BrzAXxXGaERTm0+r7U+5vYvicdYT6HGOq2XVgh53vVFkQzJPxUfjLgxzyMv4tcm1E0qjHCMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fj5K8qhlMys7EfJLxbzhhlIqrNgjb1CqMadX+DrSYA=;
 b=esmsAVNGHBsqBh3NUV/blwfpRU/0dqrxCQS7erekweiFUlu3UhoNues3IU0xAk4TnaMqy0Z1eKGonXeVmwGSjChIVn5mrG1yRdQkWhuRzGTwOI2SLWLYDq0Hc9Ot3W2QjGtpER8DnCyAHzuvOKwmpBfjgp3n2UE7wXPTN1xHoXU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI0PR04MB10212.eurprd04.prod.outlook.com (2603:10a6:800:243::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 21 Sep
 2026 15:42:43 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:42:43 +0000
Message-ID: <31ec2b30-32cf-44bb-991c-476e78e52947@cherry.de>
Date: Mon, 21 Sep 2026 17:42:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] spl: fit: Generalize compression support
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <30490adf-01dc-492f-aaf8-e280bc526a24@cherry.de>
 <CAKTNdwFVtH0-p9LmeXzFkUXi_uQ6f64om3rKCguMK5M_GHg=dA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAKTNdwFVtH0-p9LmeXzFkUXi_uQ6f64om3rKCguMK5M_GHg=dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0012.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::18) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI0PR04MB10212:EE_
X-MS-Office365-Filtering-Correlation-Id: 006188bd-4411-465c-46f5-08df17f6f9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|4133799003|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003|6133799003|41080700001;
X-Microsoft-Antispam-Message-Info: oSg9icokMRISUcESwYiTXD+PGKjUM6arqiEFzmQpTZj08vJ8tyn6giJrs4mOPMVLKc4KRL8CcLGFrjfjcEmfIYQ2ks/v/sCYf3Jhc0huH/ge1HjId7L35jb87FM8KUnJCyO5g42KW7m8xcRalDubfIUuWWRQXgf3g+oqw6ZK/rhNL6gzK1ii8SakUaLBxwyEXiD14b/aUhWkhpPWcQNEoeNz2ffFyyqhV16gV5hVF1t4LCH2bQV+fOI2xo5crACuiimP+3OO5YMaBN+TftkNaoMXbaGGCwVBHtO6fT4SCk1AItjEDxJOLcF0SeNc/LC7L5SCjLoEtZJDqXXGfSjQ2K3MEne7F+Plcznr64Sw0AAKQ1iwhTPOHpjzdLuH9JB44BKrvSMxdT7oRSLdCt/xE0/Ps5yUAIkmbgXcUZBSNGvRa/hEoHQfHGl3pKTJdKyVCcBKx7kvDyRkLO+x7IWoOjmw5m/y+vz3AdYez2SVpzdOjuO6JyrPcROBQim7UDxDyOekzf9fyMQdZFV3kzVY/2wzeA9GD9urDPeJggy0DhIdZfGqTlRvjEvHrsp0BmIDRAWBnd+nlrT2eDacybhISKNxXeHsMtT8AoA33ZxdPyG7Tt33O+SS7romULQ8kMOvpVwx8iznSs2e9Ku6kSYQjOwvtf+ezucOUeYMA1UKL5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(4133799003)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dno5cktoNFZSQXZFcnFJckxyeGdYQjRjMzJ3VmpoRDZXUXE5K09pNVRvajJR?=
 =?utf-8?B?bkxWMjZLWFZRV2x3Z3BRMGdzVGJrMVl5Zm9LTS9yL1Z6UFd0d3RyUGNhRlJk?=
 =?utf-8?B?WDg0TEJZMDYzeTBmTkdJUXBHc2l6VXZaUzdFbWk0emx1cTlwRUVSeUVVYk1B?=
 =?utf-8?B?Tlo3N2RKQlBrME4wODcrWXZMRDkrZ0tMRjk2VTRDNGI5MHdkcFlPRlBJK2x4?=
 =?utf-8?B?VEdPaHRnUVFlQ3BwMmUyamxjN1hvQ01yWXJSRnJNUkRBVjM0aktOc1dXUVpq?=
 =?utf-8?B?NVB2R2ZjckM5WGxuQys5M0dTdzVrd21sekt0YmNQZjd0WHNERU9IMWlBaHli?=
 =?utf-8?B?RVZ5WlVIZkMybEM4d2JuUkZXQlVnQkg3ZExvdzlrTFVOV1hGWmtHLzRDS2I5?=
 =?utf-8?B?QVhsU1VkYzFzK1NDSk56K01wbVN2WW9UR2pwc0tPSnp0SGFaRVU4eVFJcGdD?=
 =?utf-8?B?Y2RLajh0cDF4UGVLWXdTTXJ5U3NLWDMreGJFRFBONGdyY2E1VFFGekJXTXpp?=
 =?utf-8?B?MnRSeEVvV1h3SXllTlNvYXp2TUlqak1oS2tLQ2NiQ0wxUGVkTG9keXlQWE1z?=
 =?utf-8?B?NGVqSUczV3hkTHJvTlVyOU1PM2NVZXliQThKN3drQXQvd1NFOWRNTHZCNG5O?=
 =?utf-8?B?cmtMNHo0Y0o0UmNXaXlLTjQybWN3WUdZSTZMWm01TjlNSlNWVU5meWdjL0pR?=
 =?utf-8?B?NnJLaGpXbUNoaGkrSkpxZFk1dmFGWXFFRnk5WkNJUHdBbzBBM2pVRFBYYW5W?=
 =?utf-8?B?VXovcGlyN0lvUzlIOVFSU2tINFRvNDljck8vVFMxdXhubWxkQ2tFb0dLd3hr?=
 =?utf-8?B?WllJTXhOT28yT3N3bEJyQTBEL0N2Zm4rVHFoaVNqL2dSMlRxZjZEcmxyYnFo?=
 =?utf-8?B?bHAyL0FxdnQ2dW92NVptd2JsSnMxekNNdDAvMmowL3JxaXlyd05pNnFDdEJU?=
 =?utf-8?B?R2hkSE1TSFZvRVdxakFQeFZNQ2F6TWw5OU5NZmo3TkQzSitIeWE3U0ZwSHVq?=
 =?utf-8?B?d3FHN2V3RlRuZkptaGJGeVk3b3BoRm56Smpac3RFWUNOd2d4SDF4S0VuWXB2?=
 =?utf-8?B?Z0o4QzhrS01abWxUQ29Wc0doeWZ2ZVk5K2k0T3hJV3ZxbndOMThpOGVnSHNl?=
 =?utf-8?B?MmEvNHpBUHlxdWUyWnJpd3EvSmwzejl4Wk4yNWhQUkI5U3JCWnMxMnNwaXdh?=
 =?utf-8?B?NFQ5QlFaQitRcmpHc2IrMVQ4bXUxUDQ5TUxadHBFQWFxVSswWEcwTFVqYmFS?=
 =?utf-8?B?RlFOdHhnelhVVDNtU0o2N29TaEtUNnNkWmxEcm9xR3p1SWlwZkZ0R3JCRXk5?=
 =?utf-8?B?bldCWUJkblVGRmpVMUw3Q3FtMkNuWEQ0UUZBMFpCU3k0aHp0SmwxdFZxNGpP?=
 =?utf-8?B?UmtkRStsS0M4bk9CR0hoWHo0SnBmUnZwWTVoUUppRGg1V25IRWpacGQ4bEFD?=
 =?utf-8?B?Wk81U2hieHBlcUZaN0tSdzVmM2h4UjVKelozMm9CUk9QbHNvYWdWbE9oYjYz?=
 =?utf-8?B?L0taaVpHenMvNFYyVStvTlNLcGZZdkR5NEpDNXllZldVSWwvNzQ0OTROR25J?=
 =?utf-8?B?dFF0Q3hKNktCTEgyWjl0N2VNSDcwM2RKTzhjbVVBSG5ncDczZXh3RDZsTTMz?=
 =?utf-8?B?Z0JLdjdmWUZ6U1dYMzhkWU1aUXNLRnB2UEw5UHN6K25Iam44SG00bERDRXFu?=
 =?utf-8?B?MG1aa2w2aTRSdTkyRy9uakxOS0xFb2hJRVkxek9pZkhYLzJiUmo2RHJ2aU1T?=
 =?utf-8?B?NTJpOVlzTHdDUTIwMHJyRlQxQjkrQTlYNGk2ZFJVeldOdDI4VzB4bFk2Tms0?=
 =?utf-8?B?WDdzelF1dmh1RDU0ZWRvbVdNdExyRmEvZVN4eWtyVjl1cU5mSHpSTFZlQ1Nq?=
 =?utf-8?B?M3VURmtYa3pzMmNyeW5IUk93N3hpRko3S0twT1NoTnZBajdsTHZEQ1RnS1N0?=
 =?utf-8?B?OHV3M1JJcFlsYjVoRnFBK1d2b2UzWEtIbjB4Z291aDhhenNneEJNa3ZXYmJG?=
 =?utf-8?B?b3RPYTVPb0JUcVl6RWE2eW9zOTNBZU14allMWStuM3R1SWtXdnZaL1VqQnVr?=
 =?utf-8?B?bEVSaUR4SnptRlNrcSttNndwRjVpeEd1MmtNMFBLWmNoN1M0b0R0cjNQaHNw?=
 =?utf-8?B?d3ZkU0JSS0tRak9mR3hXNTRZcUtHalJKY21KSTE2TUM0a0s4eFZrVnlIWjhv?=
 =?utf-8?B?Z0IxLzF6eEdhdHAxWmVNdndtdUxjc2Y0c2tQdUU2OGppcVJLdytWS3doSERE?=
 =?utf-8?B?NjJ5RExWQ09RZ0VzMHI3ck1EQ2k2d0xKT1gydzdzN3QvUWROUGpaTnc4MURz?=
 =?utf-8?B?TGZUS3M0aXVpTm9CNDBLNDdhdExpUTZwMWVUelF4SFlSM1FzaVJrdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 006188bd-4411-465c-46f5-08df17f6f9ee
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 15:42:43.3611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbc56yrJL8uC/K7D410AImFnbaKEPCwtQbg6gatQH2WKXBDkzZNWCZ8s5X16Cz6qDGk8Tesi795vDAy0I3f5q0aYWKn3tNzEjvCpgOJ5nxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10212
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

Hi Alexey,

On 9/21/26 4:27 PM, Alexey Charkov wrote:
> Hi Quentin,
> 
> On Mon, Sep 21, 2026 at 5:14 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Alexey,
>>
>> On 9/18/26 12:52 PM, Alexey Charkov wrote:
>>> SPL knows about multiple compression algorithms, but only two are
>>> hand-rolled into the simple FIT loading code, in spite of a nice ready
>>> made helper already being available right there.
>>>
>>> Generalize the compressed FIT handling code to accept any compression
>>> algorithm compiled into the SPL, and fix up the SPL_ZSTD linkage which
>>> requires xxhash in the SPL but which was absent to date.
>>>
>>> While here, also extend binman to support passing a compression level via
>>> its image templates, which helps squeeze additional ~15% size savings in
>>> my testing with Zstd level 19 without impacting decompression speed.
>>>
>>> This is done with Rockchip RK3576 in mind, so a small Rockchip image
>>> template refactor is included.
>>>
>>> CI passes all green: https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1319
>>>
>>
>> Doesn't work on my PX30 Ringneck for any of the supported compression
>> algorithms (didn't check lzma as I'm daily driving Fedora and it doesn't
>> have lzma_alone binary).
>>
>> Doesn't work on my RK3399 Puma as well (couldn't check zstd, SPL was too
>> big and overlapped with U-Boot FIT, note that Puma is special in that it
>> only allows (256-32)KiB for SPL, due to backward compatibility with
>> older versions of U-Boot that had U-Boot FIT located at offset 256KiB).
> 
> That's interesting. Does it work without my series though? With Gzip.
> 

It also doesn't work without your series.

> If it doesn't, the first thing I'd check is overlapping memory regions
> for the compressed data and the ultimate load address of any of the
> binaries involved.
> 
> Would you mind sharing your resulting FIT structure that binman
> produced for the failing boards, including all the ATF segments?
> 

BL31 for both come from upstream TF-A, seemingly from v2.13.0 (according 
to strings build/rk3399/release/bl31/bl31.elf | grep -E '^v').

ringneck-px30_defconfig + CONFIG_ROCKCHIP_UBOOT_COMP_GZIP=y

$ mkimage -l build/ringneck/u-boot.itb
Truncated file
FIT description: FIT image for U-Boot with bl31 (TF-A)
Created:         Mon Sep 21 17:29:13 2026
  Image 0 (u-boot)
   Description:  U-Boot
   Created:      Mon Sep 21 17:29:13 2026
   Type:         Standalone Program
   Compression:  gzip compressed
   Data Size:    315656 Bytes = 308.26 KiB = 0.30 MiB
   Architecture: AArch64
   Load Address: 0x00800000
   Entry Point:  0x00800000
   Hash algo:    sha256
   Hash value: 
1ab3cad555db60bcb81aa670798449758553a93100dccf0c08a4f9e426bb704c
  Image 1 (atf-1)
   Description:  ARM Trusted Firmware
   Created:      Mon Sep 21 17:29:13 2026
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    106496 Bytes = 104.00 KiB = 0.10 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0x00040000
   Hash algo:    sha256
   Hash value: 
8ffbc6cfd2fe46ea218e5afaf76c3a4b57d80adacedd3e6d793e67f8433c5936
  Image 2 (atf-2)
   Description:  ARM Trusted Firmware
   Created:      Mon Sep 21 17:29:13 2026
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    126 Bytes = 0.12 KiB = 0.00 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0x0005a000
   Hash algo:    sha256
   Hash value: 
b108492f1fc2fb0046ace3f683cdfb5f4dae3df7cc3b4ec9ba2a06ad3b194f4e
  Image 3 (atf-3)
   Description:  ARM Trusted Firmware
   Created:      Mon Sep 21 17:29:13 2026
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    112 Bytes = 0.11 KiB = 0.00 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0xff020000
   Hash algo:    sha256
   Hash value: 
324fe45d21d49d4eef66d2edc3f69d15f3285c790e470db953976abc46ba6f94
  Image 4 (fdt-1)
   Description:  fdt-rockchip/px30-ringneck-haikou
   Created:      Mon Sep 21 17:29:13 2026
   Type:         Flat Device Tree
   Compression:  uncompressed
   Data Size:    73216 Bytes = 71.50 KiB = 0.07 MiB
   Architecture: Unknown Architecture
   Hash algo:    sha256
   Hash value: 
5a17c482bc2f993bc8f971086cd4a173006236be79424dcec390a743580bcfdd
  Default Configuration: 'config-1'
  Configuration 0 (config-1)
   Description:  rockchip/px30-ringneck-haikou.dtb
   Kernel:       unavailable
   Firmware:     atf-1
   FDT:          fdt-1
   Compatible:   tsd,px30-ringneck-haikou
                 rockchip,px30
   Loadables:    u-boot
                 atf-2
                 atf-3

Boot log:

U-Boot TPL board init
DDR4, 333MHz
BW=32 Col=10 Bk=4 BG=2 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
out

U-Boot SPL 2026.10-rc4-00496-gf94e3597ec41 (Sep 21 2026 - 17:29:10 +0200)
Trying to boot from MMC1
## Checking hash(es) for config config-1 ... OK
## Checking hash(es) for Image atf-1 ... sha256+ OK
## Checking hash(es) for Image u-boot ... sha256+ OK
    Uncompressing Invalid Image to 800000
Error: inflate() returned -3
Uncompressing error
spl_load_simple_fit: can't load image loadables index 0 (ret = -5)
mmc_load_image_raw_sector: mmc block read error
Error: -38
SPL: Unsupported Boot Device!

puma-rk3399_defconfig + CONFIG_ROCKCHIP_UBOOT_COMP_GZIP=y

$ mkimage -l build/puma/u-boot.itb
Truncated file
FIT description: FIT image for U-Boot with bl31 (TF-A)
Created:         Mon Sep 21 17:36:47 2026
  Image 0 (u-boot)
   Description:  U-Boot
   Created:      Mon Sep 21 17:36:47 2026
   Type:         Standalone Program
   Compression:  gzip compressed
   Data Size:    433877 Bytes = 423.71 KiB = 0.41 MiB
   Architecture: AArch64
   Load Address: 0x00800000
   Entry Point:  0x00800000
   Hash algo:    sha256
   Hash value: 
2c24443bce4cffa899eb4e45e9903433f2cbc59b96d4b3dc98bf827544f2b252
  Image 1 (atf-1)
   Description:  ARM Trusted Firmware
   Created:      Mon Sep 21 17:36:47 2026
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    147456 Bytes = 144.00 KiB = 0.14 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0x00040000
   Hash algo:    sha256
   Hash value: 
d737d2efb49d780d6cd72eb7e6c34c0cc5294753e6ac45f4495bab12f44b5a93
  Image 2 (atf-2)
   Description:  ARM Trusted Firmware
   Created:      Mon Sep 21 17:36:47 2026
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    78 Bytes = 0.08 KiB = 0.00 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0x00064000
   Hash algo:    sha256
   Hash value: 
f59dc67a835f14d92d5bfee57920f5a8a68d06609481b5ede9492f4e2d379a21
  Image 3 (atf-3)
   Description:  ARM Trusted Firmware
   Created:      Mon Sep 21 17:36:47 2026
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    8024 Bytes = 7.84 KiB = 0.01 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0xff3b0000
   Hash algo:    sha256
   Hash value: 
256c48c2a37faf72304b91d09daeee8442e70f06b2aae7c693e85f3d87662855
  Image 4 (atf-4)
   Description:  ARM Trusted Firmware
   Created:      Mon Sep 21 17:36:47 2026
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    8192 Bytes = 8.00 KiB = 0.01 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0xff8c0000
   Hash algo:    sha256
   Hash value: 
c70fdb94f7bf6d48fb04ebd4f04b386323c41a6a796e0756beca23345ad3537f
  Image 5 (atf-5)
   Description:  ARM Trusted Firmware
   Created:      Mon Sep 21 17:36:47 2026
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    0 Bytes = 0.00 KiB = 0.00 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0xff8c2000
   Hash algo:    sha256
   Hash value: 
e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
  Image 6 (fdt-1)
   Description:  fdt-rockchip/rk3399-puma-haikou
   Created:      Mon Sep 21 17:36:47 2026
   Type:         Flat Device Tree
   Compression:  uncompressed
   Data Size:    97768 Bytes = 95.48 KiB = 0.09 MiB
   Architecture: Unknown Architecture
   Hash algo:    sha256
   Hash value: 
70793f8f952644970f5e6b08f18a710276781023228ba9014b9a138ea8ceef18
  Default Configuration: 'config-1'
  Configuration 0 (config-1)
   Description:  rockchip/rk3399-puma-haikou.dtb
   Kernel:       unavailable
   Firmware:     atf-1
   FDT:          fdt-1
   Compatible:   tsd,rk3399-puma-haikou
                 rockchip,rk3399
   Loadables:    u-boot
                 atf-2
                 atf-3
                 atf-4
                 atf-5

Boot log:

U-Boot TPL 2026.10-rc4-00496-gf94e3597ec41 (Sep 21 2026 - 17:36:45)

U-Boot TPL 2026.10-rc4-00496-gf94e3597ec41 (Sep 21 2026 - 17:36:45)
Channel 0: DDR3, 666MHz
BW=32 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
Channel 1: DDR3, 666MHz
BW=32 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
256B stride
Trying to boot from BOOTROM
Returning to boot ROM...

U-Boot SPL 2026.10-rc4-00496-gf94e3597ec41 (Sep 21 2026 - 17:36:45 +0200)
Trying to boot from MMC1
## Checking hash(es) for config config-1 ... OK
## Checking hash(es) for Image atf-1 ... sha256+ OK
## Checking hash(es) for Image u-boot ... sha256+ OK
    Uncompressing Invalid Image to 800000
Error: inflate() returned -3
Uncompressing error
spl_load_simple_fit: can't load image loadables index 0 (ret = -5)
mmc_load_image_raw_sector: mmc block read error
Error: -38
SPL: Unsupported Boot Device!

Cheers,
Quentin
