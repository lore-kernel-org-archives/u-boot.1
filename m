Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FF7C982DE
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 17:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5E4D80EE1;
	Fri, 18 Sep 2026 17:57:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lPdg1BsBej3G; Fri, 18 Sep 2026 17:57:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 212CE80EBF
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789754271;
	b=bizz4UMdQXoMOsyriQ7h0bT0bXeUV2irXjXCA/sg8qb5lg0uXGcC7FO+cw2qjR9FpF4f
	 bLNVbi9oZU0shuWc5dUjhdyHvDTVaArWEblnqbiYHP4wuFUAvdz32643maP7ZMo6iCnai
	 SzEtNcESQ3A1VHL19fAJwq1dwWlWtkZQCfnk4CRUC8xwlGPeddgsjGCf/urzzt+YIS/3E
	 V2W01PueDGzXykUQQTfdzLswo8bze+JP3SiGz/c+Nhs4v26+WcEm20vd0K5gW1qSii0c8
	 7fxUqiG3vP1HR4Rpql/QQ9YBI6os3jumU/CHgmvFMh7qE1j9lQ1e2ArPkcZ20shC9Pw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789754271;
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
	bh=ik14wBie/cbyr9HJ6TfnApmyP8Jspn38Er1zW/vPUv8=;
	b=ZPlhwml8paMowlPXr6zdY2dayU/vrnFCQ/anhZ9j29ImyAYQr642r2YS08ltmbRfAU9J
	 VLfdXPJkTJwaAiyUmyV0C5rYpmxWqFlX1Xz8zsWwzItX8ZQXuqf1VvhZRj2p1Fm2lJGks
	 BSyU8ckmtYbUkcAdy7RWjkQO32+9Hy05mO45sOOKsK2xIrw6N0OIRUaEs6crO6KyQ+noU
	 JVwktxPlifGpfTw7BfBaz0dh2QMtnMU8AbAcMvlDlXgOcXaRw+RnLvybqA5Ok6ZExXnRB
	 0uarZe/beCWV+enniuAI5x9UdQmoPiz4JTlWi9T6Eg//+F4poxyXi37G2juilEOE5xA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789754271;
	bh=ik14wBie/cbyr9HJ6TfnApmyP8Jspn38Er1zW/vPUv8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iZAB7XEyRKVLnbTS9MWDxMeXjnxcAnZu5tt3FGeViDlRwgI7xGhjFnUQzY+etELXt
	 9rhklJBAsts3HyfbErFvgTxJ1y7Gc6yZ03u+kolizF1ejFaagOVBUxPd0ePOOhVpBG
	 Xwq9S6zwvZvz3WKJ6eFM0L0mNmDPQqTe8lguQfGT7uJqGbyI5J5C240S6D0x4gJfGq
	 wjArIVN4X1+up1Tu41eNllVgdb4J4R/ea9dY8LPp1u7AapXjOWAICs1FjmUgN1Zj0p
	 svfo/pwJ16/dQMS/IGL2MUCSoQDFvdZj5BB0XyXj5lbCmArdUSxps8K0QaI746ktSw
	 zuMtPNy/ICU7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 212CE80EBF;
	Fri, 18 Sep 2026 17:57:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 91CA1237
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F2E460D86
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:57:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HcP8RE1Pf2qb for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 17:57:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1389C6060E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789754268;
 b=CmEZaNnphraA/TAE6Z2SpsY9UXJ/GjzAXwMurxIqyP9xsXKppm/OxqlnDEmwDufdTJv2
 zocM6oQR0JlbWlWKSW+snZ8ycNFnPEJJnc251ZdF+8pdzUp8PRTAtTHFCWZ0SwBlS9jVp
 hJrQxWfmsP1dHeq8wdF8d/kuqtO/3c4blRXU1uXiOU1jw5YjzYXkjLpIJ7HK+hcfzRspu
 xiuxNlGiISLVZVsYXJpx30i4ay7DBvX58SsIug3crm0TSpp3j0CY3HGKz9/DiHxRLmQBB
 hVwz/KRB8F/2PddY8/YJs0RjyEh5yqLZXzZAQ4yfYr4+DIvmOmKfxWwE7SLpEwwYpkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789754268;
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
 bh=ik14wBie/cbyr9HJ6TfnApmyP8Jspn38Er1zW/vPUv8=;
 b=AL6A3kd2Cf3/HBDeUzOM56fEdp2qihtX8F6XRjitACwc74Qz8eh8xSS+nht3GTa9Npaa
 jcyszk7M2GadwN9qVJ9nSdInBiPqtDUTSa04++AgzoJ1EXyhMnfoPkC7ytxiLOeScZrhk
 a3GzjJanig2Vq/vq+rOU7FecVeYLL808R7+LuEeoE4eAKhzC/nNaJKLHaRnOi79LQVUnA
 FpT+xU68lYwsDOkDs1zUYnkNl21LAANMtJlXra63hVGuB59rrgY/wNYqtgz5Nm2kFtlnp
 4os8GLJfNlClHa1KQj03ZcgxE61FAVO/I4SETtoLxzphtWGe3UPsinJ7s/Sn4VHHWcg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b="Xn4GIY/I"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Xn4GIY/I
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1389C6060E
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmyQrLrcsE8OzkFVosWZCLQjUGrg3VyxjCDL21fWeja94ckyYKrmtmQ07sUurhfK2kR2+0E1I7CYjgeBcbsIlIhu39w6Y8TmtuXDo+8Z3mLeJkdcpkCnjqHzwpJTQLwP/5PhgHmndN6CU9Dl8pXUr2+Lk2C5eFDMQAHrGlDx2XUEGHgknQv/wQU86Hfb2R01tZFDTk6qGAMynmc6m4cudpkN2kUkcjVqcgxUonfL1kBHvM5h/ncyxPXuAnxNbwhRPvnRsMNcewQJV6KKKO70U1oxNY/LkF/iawm94yo0dRC0KwWCVtiLPEp0NxExFQP/3B1ASf9tFuex7X2ViQa4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ik14wBie/cbyr9HJ6TfnApmyP8Jspn38Er1zW/vPUv8=;
 b=tXBUmP+tQ29ojBIkiuvzYwSeJqVjfiUgnNRVvUfm+HzJAqIWBSL15Jl+VxBxUfxwrAmgNWEW0kV+37ddjQPeus0ZH7T20z0/NzrtMVTfjBcjd9XilYGva9F8D+SiREPktcYV76EmZqAV5uyXTOW1W/tUrI3Z9lxGiIUiQSCIkHXpURpdTWu8G81lq+m6T0ptUaPvMk66SW1YYtj8jnCUT592bzfwvqzyZyAXcLH5qZlFQGf/99YictzEfFDPVcbQB24UIREEHgtCG4tdb4Dm8IkfmHfjZCA5gJLWiDv9gM4i+WXCj/4Wey3+utN1NKdIZU8N+8TNIopMPPLycxB7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik14wBie/cbyr9HJ6TfnApmyP8Jspn38Er1zW/vPUv8=;
 b=Xn4GIY/IyMWXQNVrqosj3VTPm+VkqOHfHAiVcG9zgMCxUrSRsuV/xadTSsdeDdQ6LDRpopdav4uPUyhL6Qu/LRC/q2IGV5kLeGO187ebmoqzXqtIwP/ByovsmiqidHANxhIU6HdtSQA22JHH567MkhJGtSMCSFBdT2/69de4CYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM9PR04MB8292.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Fri, 18 Sep
 2026 17:57:42 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 17:57:41 +0000
Message-ID: <77f7c2c3-f038-4558-a1d9-8a69529c372e@cherry.de>
Date: Fri, 18 Sep 2026 19:57:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] rockchip: Choose FIT payload compression via
 Kconfig
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
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
 <20260918-spl-fit-compression-v2-11-28e946f57357@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260918-spl-fit-compression-v2-11-28e946f57357@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0029.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::19) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM9PR04MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 69434377-cd79-47ab-1739-08df15ae55c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info: 9/iZj4gCLWqASocQVWNqalX6Z+BqF4NtLMls46vkzjxRwE5RMJjT67lFmhfz2s6zY7LbaFvUlUtXeys6/3P/AOvul5QCU65nkfnv52H6sL6cF7cbjzw+S0BtQQOi6jHHNBGH7kENVhdG56WsiXheLK+r8FTdTBP3lteS5L3+10M2wavik/TNbw0UpmY0lZFwGF3He/VEdjW+FlTisVkh4cvk84YyGZHt2yvNW+rfsF+pL+ZWEtb0WAszpdeW/DULHfTIDLLSZH6a1gGhdD8LJeYD2CWghqr7CD765T0HrvoBOFePjL8dwupU1XgK4EXu/Mxj6wqLY9GQUw77btuhZ9A2ae8/vmKykaDVygvH+faU7Khf8PKyYmEjnR4uQUkW/1gckx/RIQAg2jkmRLvcx3lil1VV9RThB/cIOPl7aeEqOcvA4YmxYlereyAPqGKttvbS44I7flzCPVDaHOe/D/783Xk+zeU5SCK7TcyyV0XVa0JtTov5y1Tu76ruQ9zeWNy/o3hCcXJ+NnXDDJEFkAXwe2aYYpvcHozlQCcQ1PrTR0PgQBMMevIHIbW0LZFWp7dBN7jdLGnZkB0QrtQH6dauCU8HMzfI9LxGscsgoP9OZNDLACCvh4JGvi1ZYAIRG5qO7WO0T41jT29+SRJaTfX9imB5hvC68xfeeixDFv4X6kJqBbj94l7j+g2MiP1hnfHzQqptKp5VWuat4mm6VsVn51hi4HhiIj1lOJGhi3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z05BUEMrTFQwSy9rUWdKN2d3YlI0a0JvQXFoQlBuWklnOHI4T2xDalE2Y1lH?=
 =?utf-8?B?QndiaWJNSmREWmdTdTBUZVJ2T3UvOFBBeU1ncXNZZDdVdHlkOTZLNk42RUYr?=
 =?utf-8?B?cVRLRllMd0REY1h1ME0zR2Zlc1JhKzFsSTMwWHQxd0liYlp5bXcxRXc0cUQ3?=
 =?utf-8?B?cXV5VEcydFRTeERFWmJEeGhNaWp5VHc4WVF3LytZVXpEa1hSeGd5RUZqN3k2?=
 =?utf-8?B?aGppQUFyQzMyQ0tvUjRmcC83dnpma2NtUk9rTGNKbWN2MkxKVzB3Yi9xU0RW?=
 =?utf-8?B?ZHJCUllDVkY3N1czd1ZzdjJxNVZZa0doQzh6Wm42enBTWnVBTUs5OTFmU2VD?=
 =?utf-8?B?WldSenlZVDRjMlVKSG1nY2UwYmlSa3dpWDl6bUxoYjdneitwNGFqZ0M1UWpE?=
 =?utf-8?B?SHpSSXd5cTF3Ny9XdWM2dE5yLzE0QmhxTDFJZ3RtcmVQa0w1YlM2VlJ6WDBi?=
 =?utf-8?B?a25SejVPaWZPUzBiOUNhN213RFBqbk12RGgxandGcm5lNk02NkVjMDc2Mk5p?=
 =?utf-8?B?M01vNEZMemRiNzhGU1Y2Zm1Md3VmYXk0RTFPRjhJVy9taHp4RjJXa3VINXBI?=
 =?utf-8?B?aTV3cVk0YkFMaVFDQStxV3ZIQmhXZG5sYUJPbGdIVHF1dFZ2ME9WYlRHdFZm?=
 =?utf-8?B?S2d0WmV0a1lHa1B6aEV6Q1ZKendPbnBpTUs5eC9HNXl4WFZtanlGeHdIWU1O?=
 =?utf-8?B?aFdPWUlQaHdlT0hvUEFnM1pOcjg1Um52MDBtTm1wQk9oTHRYeFZMc1BoNndL?=
 =?utf-8?B?cm9wamZuamNGaEZBQ1ZYem9OazliR2F5b0diMElrWFBqalFPZzRMKzZwWURG?=
 =?utf-8?B?VmhoWm9IYUZMRk5HWVhkaDVSaGIrVEkxb2U1TmdmcHdhOUN4bU1GTWZLMVpP?=
 =?utf-8?B?ZElibmIzZ0dxV2ZhVDF0OWdlTFNmOWQ1WHF4TXBkbkVwWmoxU1oxVzgxYlhM?=
 =?utf-8?B?dS9EK2Y0eCtRSnIwVWk5RUxzMHJpWElwSWg2bWpyRzJSN2VrcWpTNVBWaC82?=
 =?utf-8?B?b2RCcmsrQkxKbU4wZENYbGlxZUROQ1BYU2lndURJV3B4WEExRmF6eC92WmN2?=
 =?utf-8?B?NHlXUUlDODFTRHY5bzJvTFJUOW52MnorRmZhUU0rNzJVOUh4bWVEU1E3eXQv?=
 =?utf-8?B?V294Z1ZISk42eTQxQU43TzRGRVdGZ2c0QjNDOTB5K3lHS3hwL3BvWmJmdi9X?=
 =?utf-8?B?VHh5QUJzRG90U0JqT3p0T2NvMU9IRFRiRjE4Z2IrcWcybEZIZWdaL2xkOFJq?=
 =?utf-8?B?MU85S2xZTmdjbks1V0lLNkpaNk9PNk9laWszUmJzL2ViRlZUa3dTUWUxOEda?=
 =?utf-8?B?a3B2ampLV2xFZGZRei9UVXU4WHRQRFFVNlRmbEFOQkprWG5YbVNwYzA5cC9M?=
 =?utf-8?B?UnQvOElwd3JvRmdMWTQyRERweEpDcVBxMkxkWTQzWUdzWndOT0JHWEo4L2R2?=
 =?utf-8?B?aUFPVnNaeWFtdUN1bEtnSk82dGFnellibnVXVTRUdk5xVnVleTVsbkExK3Ra?=
 =?utf-8?B?L28zbWNzSDVpUXBBSjg1VUdyd25MQW94bE4zWXExdVp4OFRiM3M0Mnd4V1JK?=
 =?utf-8?B?MkdURENDTlFLZXVNQ1EzMGt4K3ZtSzdROVlwclJYSHZ4OXpSd2FJall0Ry9P?=
 =?utf-8?B?WGlCWUx2eGk5bEpqa1V0SDJ4cnovWUZYVnphS2Z1NDQ5TVEySE9DenJwVThB?=
 =?utf-8?B?eUFBc3FGTlBPVmhnd3l2Tk5CSE11Z3A2UHdSSUt2RmJqTDlEaGJocGlsVTln?=
 =?utf-8?B?Ny9oOVZhRmkrZ3RZQTk5aUFhSEYwUW1CZ1FWaXovM2Z2dld0UGZTRTEvQTE2?=
 =?utf-8?B?bTRKSW5lK05RdHl2RG13R000OHdvdWoxV2ZPTjNUeVpsdmU5Tk9lV3BYMDdZ?=
 =?utf-8?B?TmdYNWdVNVE5dlRNakdpdnNoZzVxbWIwTWVqUDlvZXdhNmhWSWx3WWJZcGMw?=
 =?utf-8?B?RE4rbklzbjdkWk1tMko0bFNCWlZHRXM2ZjgveUpHbWJHd0Eyc1JTZHBmdng0?=
 =?utf-8?B?dXEveFJzSzZzUDZydDdHQmx0cFI3UGxDTVMvSDljbTZpazJRNXNGNXVIbVFM?=
 =?utf-8?B?amY1aE40M0I4UCtjVDdTdlc4YWVMbXNaOW0yKzQwL3VLeGZveHNoNHdPMTV3?=
 =?utf-8?B?U3p5SVp4MGFsaURaQzcybG9hTVZPaUlQM2YwMEhNZGxpWnl1Q3htNDFsNERm?=
 =?utf-8?B?OVBoWlVaWDNqVEtYVk5VUTVQcEhjenIzZWYrWFRGc3BBUHZBdzFmcGJNSXNy?=
 =?utf-8?B?M3ZNbUNzMnhRbDg2K1RmWVpmR3F3bm5tc0U2UEdlZ0U0UnozNmliS0M4UmRK?=
 =?utf-8?B?ZTI1cVI0bzNrNlNoOTY1b1lMRmlEb2JQQ1Jmc1FXbUdSNExHNkpQUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 69434377-cd79-47ab-1739-08df15ae55c7
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 17:57:41.8627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmShPVH5UuduaCzEii7t8dXHB2PBUXFJcBiUZKBpH2qBMuLlwgpaTZefX1k8FmlOtizA7Xn0A6vtAP4IaX+glTlxfSch/Sa/NRs19NtMiTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8292
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

On 9/18/26 12:52 PM, Alexey Charkov wrote:
> The dtsi infers how to compress from whichever SPL decompressor happens
> to be enabled, so there is no way to ask for one in particular, turning
> a decompressor on for something else silently changes the image, and the
> conditional has to be updated with every new algorithm.
> 

Thanks, this was something of an eye-sore to me for a while already :)

> Move the selection to Kconfig instead, with proper help texts and support
> for all available compression algorithms. Each choice enables the
> decompressor that provides it, and carries the compression level.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi | 16 +++-----
>   arch/arm/mach-rockchip/Kconfig    | 78 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 84 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 4ba6a87e78ab..a72b55cec05a 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -11,14 +11,6 @@
>   #define FIT_ARCH		"arm"
>   #endif
>   
> -#if defined(CONFIG_SPL_GZIP)
> -#define FIT_UBOOT_COMP		"gzip"
> -#elif defined(CONFIG_SPL_LZMA)
> -#define FIT_UBOOT_COMP		"lzma"
> -#else
> -#define FIT_UBOOT_COMP		"none"
> -#endif
> -
>   /*
>    * SHA256 should be enabled in SPL when signature validation is involved,
>    * CRC32 should only be used for basic checksum validation of FIT images.
> @@ -61,11 +53,15 @@
>   				type = "standalone";
>   				os = "u-boot";
>   				arch = FIT_ARCH;
> -				compression = FIT_UBOOT_COMP;
> +				compression = CONFIG_ROCKCHIP_UBOOT_COMP;
>   				load = <CONFIG_TEXT_BASE>;
>   				entry = <CONFIG_TEXT_BASE>;
>   				u-boot-nodtb {
> -					compress = FIT_UBOOT_COMP;
> +					compress = CONFIG_ROCKCHIP_UBOOT_COMP;
> +#if CONFIG_ROCKCHIP_UBOOT_COMP_LEVEL != 0
> +					compress-level =
> +						<CONFIG_ROCKCHIP_UBOOT_COMP_LEVEL>;
> +#endif

OK so the obvious question here is "why Rockchip-specific?". I 
appreciate you're mostly working with the RK3576 but I don't see why 
this (the kconfig symbol definition that happens later in this patch in 
arch/arm/mach-rockchip/Kconfig) needs to be Rockchip-specific, we have 
other architectures that are also building a FIT image with U-Boot 
proper in it, so I think it'd be nice to have this setting apply to all 
of them so that it's a more generic approach. I'm wondering whether a 
direct argument to binman would be more appropriate here instead of 
requiring all binman nodes to not forget to add these compression 
properties for the setting to actually apply. Of course this would still 
need some logic handling a binman argument and the compression 
properties both being set, and likely remove the properties from 
existing DTS.

>   				};
>   #ifdef FIT_HASH_ALGO
>   				hash {
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 1a2e7847c9e7..6e98534f28d7 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -758,6 +758,84 @@ config ROCKCHIP_MASKROM_IMAGE
>   	  Rockchip SoCs support maskrom mode boot over USB. Enable this
>   	  option to produce maskrom mode boot images containing U-Boot.
>   
> +choice
> +	prompt "Compression for U-Boot proper in the SPL FIT"

It's not the SPL FIT.

> +	depends on SPL_FIT

This only applies when we build a FIT image with binman for Rockchip, 
which happens only if HAS_FIT is defined, which is:

defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) || 
defined(CONFIG_SPL_OPTEE_IMAGE))

so you are missing:
depends on ARM64 || SPL_OPTEE_IMAGE
here.

> +	default ROCKCHIP_UBOOT_COMP_NONE

This diverges from the current state, instead do:

default ROCKCHIP_UBOOT_COMP_GZIP if SPL_GZIP
default ROCKCHIP_UBOOT_COMP_LZMA if SPL_LZMA
default ROCKCHIP_UBOOT_COMP_NONE

to keep the same behavior (not tested but I believe this should work).

> +	help
> +	  Pick how U-Boot proper is stored in the FIT which SPL loads it from.

Don't like "how [it] is stored in the fit", I would prefer to make it 
explicit we're talking about compression here.

Maybe:
Compression algorithm for U-Boot proper as stored in the FIT loaded by SPL.
?

> +
> +	  It is around a megabyte, so what SPL spends unpacking it is close to

Size depends on what you enable so I don't think it's relevant to put 
this in a help text.

> +	  what it saves reading a smaller image, and leaving it alone is a
> +	  reasonable answer. Compress it where the room it takes up matters
> +	  more than the time.
> +

I think what matters is the following:
- on space-constrained systems, enabling compression may help making 
sure the bootloader fits in the storage medium,
- compression could help with boot time if the storage medium is slow 
enough that reading a compressed image from it and uncompressing it is 
faster than reading the uncompressed image directly. Whether it's 
beneficial needs to be experimentally checked on each device as it 
depends on the SoC and selected storage medium.

> +config ROCKCHIP_UBOOT_COMP_NONE
> +	bool "none"
> +	help
> +	  Store it as it is. SPL copies it into place rather than unpacking
> +	  it, and the build needs no host tool.
> +

Please add a proper help text that is understandable on its own. It is 
not uncommon (I do it more often than not) that people will look up a 
symbol with the search function in menuconfig and will only get this 
information, it's therefore important to know what we're talking about 
here without having to look up the choice help text. Ditto for other 
help texts below.

> +config ROCKCHIP_UBOOT_COMP_GZIP
> +	bool "gzip"
> +	select SPL_GZIP
> +	help
> +	  Compress with gzip, run from the host 'gzip' binary. A middling
> +	  ratio, quick to unpack, and it needs no SPL heap.
> +
> +config ROCKCHIP_UBOOT_COMP_LZMA
> +	bool "lzma"
> +	select SPL_LZMA
> +	help
> +	  Compress with LZMA, run from the host 'lzma_alone' binary. The best

I'm not sure we need to specify the implementation detail of the tool 
used to generate the compressed binary? lzma_alone is also only 
available on Debian-based systems (e.g. Fedora doesn't have it), so I'm 
not entirely sure whether it'll stay this way forever (maybe we should 
switch to another implementation that is available on more/most 
distros?). I understand you probably did this because it's somewhat an 
important piece of information to then decide which level to use.

> +	  ratio on offer, and by far the slowest to unpack.
> +
> +config ROCKCHIP_UBOOT_COMP_LZO
> +	bool "lzo"
> +	select SPL_LZO
> +	help
> +	  Compress with LZO, run from the host 'lzop' binary. A poor ratio in
> +	  exchange for fast decompression.
> +
> +config ROCKCHIP_UBOOT_COMP_LZ4
> +	bool "lz4"
> +	select SPL_LZ4
> +	help
> +	  Compress with LZ4, run from the host 'lz4' binary. The fastest to
> +	  unpack and the worst ratio, so it suits a fast boot medium.
> +
> +config ROCKCHIP_UBOOT_COMP_ZSTD
> +	bool "zstd"
> +	select SPL_ZSTD
> +	help
> +	  Compress with Zstandard, run from the host 'zstd' binary. Close to
> +	  the LZMA ratio for a fraction of the time, but its decompressor
> +	  wants around 94KB of SPL heap - see SPL_ZSTD.

I don't like specifying numbers that aren't guaranteed to stay at that 
value. I understand the appeal to provide some number to give a rough 
idea of the size impact, so I don't think it needs to be a blocker, 
maybe Tom would have some opinion there, otherwise ignore this :)

> +
> +endchoice
> +
> +config ROCKCHIP_UBOOT_COMP
> +	string
> +	default "gzip" if ROCKCHIP_UBOOT_COMP_GZIP
> +	default "lzma" if ROCKCHIP_UBOOT_COMP_LZMA
> +	default "lzo" if ROCKCHIP_UBOOT_COMP_LZO
> +	default "lz4" if ROCKCHIP_UBOOT_COMP_LZ4
> +	default "zstd" if ROCKCHIP_UBOOT_COMP_ZSTD
> +	default "none"
> +

I'm tempted to say this is not the place for this and rather should be 
in rockchip-u-boot.dtsi for example as a series of #ifdef (but if we go 
for a generic implementation that applies to other architectures, then 
maybe it's fine like this).

> +config ROCKCHIP_UBOOT_COMP_LEVEL
> +	int "Compression level for U-Boot proper"
> +	depends on !ROCKCHIP_UBOOT_COMP_NONE && !ROCKCHIP_UBOOT_COMP_LZMA
> +	range 0 9 if ROCKCHIP_UBOOT_COMP_GZIP || ROCKCHIP_UBOOT_COMP_LZO
> +	range 0 12 if ROCKCHIP_UBOOT_COMP_LZ4
> +	range 0 19 if ROCKCHIP_UBOOT_COMP_ZSTD
> +	default 0
> +	help
> +	  How hard to compress, numbered the way the algorithm's own tool
> +	  numbers it. Leave it at 0 to take the tool's default.
> +
> +	  lzma has no such knob, so it is not offered there.

The option won't be shown anyway and it's clear from the dependencies 
that it's not supported so I don't think it makes sense to have it in 
the help text, however the commit log would be a very good place to have 
this piece of information.

Cheers,
Quentin
