Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1771DC98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5DD08130B;
	Fri, 25 Sep 2026 13:51:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id moKxzdPrOZNE; Fri, 25 Sep 2026 13:51:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1591E81307
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790344265;
	b=WNjfwyMaBsrTAhkO9RltvsiglN3IXjaVciDLoguJHlvmAgPlZhLCGfRkGBbvxpIBT6ey
	 ehXbX14U4hc/oYZPcxyaR01C2ZKmYCuoEOGhyyx0XxvyaM/zUbh/jTDssy37WxL1CgOS1
	 CA/Y6EOPNAkvbO0pR3Ox5Bc43yw7Fu3ovolRHqBZKmklQAk9kHcEKB47G+dtB5RQopXlD
	 tXQI/pSrLfJYRag6tdJehfOOnUNdjZwhwfWXnVT3j6nmmHIDVWBVZvrztOMo+shCN3j6P
	 1Y6WIrtuuQyQjNySafe5IAvqnt3OwiRf//oV1FK8C+yVSyLhewTrV5SnPzqb9+6Hc6g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790344265;
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
	bh=e1eVEiTcawr5wAgDPvEedv4CMzbLYzgFV0cE/RuFgWY=;
	b=pLC4LUX3qseXjMBwiFYz2tatiT8IlUsWfziqAdwbAwWzKCBzEpO6WD631wew3do7rf4C
	 mnlsxdD1ShZsbJRnyJej+qg5Hkx0iOoca84jHxZjdcFpbKm76MFGgPLqMg6bSazqV+esW
	 KHm3H/kmFz1iOR3JGnKqqwnPdrceBt8jdESkcAv2VRALnuoLP1ubIhAQjfkHEDAb7JJ7+
	 /UQVsjG9tuG7nxV6C20zuKoIOyROETkelw0/q8+LgCZ+MUZhze2SsciO9Z4WrZ77rpXjK
	 2TAdBWLNxEMJ9uI24R1kgz2btqrwxD5Gy+IdEKh1tBGPgNvXoa4QC6pmjgEn1K253xQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hIgn2qjf;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790344265;
	bh=e1eVEiTcawr5wAgDPvEedv4CMzbLYzgFV0cE/RuFgWY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qVH6619xveXeodJsx79FpDvyOrETmNVyP6nfrQIBI958rpilui1DUaZ3Q81XmX3Ai
	 pj4iM+ckMGxdwRDICb9ZE8Kqr7JGMeJYdo+XvrQyBmmJkKtRJXGEysx2NR5s6DX1Wq
	 duGm00kP5LWQuHsdO9mFmLzi0tXBkBc5GEI5QxVNPCffdHs7IzUX05Rj3Q+13LLVdU
	 NyRI5dTbL9v0ryyTYh0tEY7R87i4xpZEtQB2Zu/TrFkAffqpO/z32aM5jawqnhi29M
	 M/JIWqOOfnSOoGTtMZkHc+YtYEmN1lneyYs/NhM/5N6KK8knpf1FsmIM+K/XUJCi9v
	 iab+h/Cvemfzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1591E81307;
	Fri, 25 Sep 2026 13:51:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 71AE4355
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6344581307
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:51:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XlwLeAu0swM2 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:51:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D9B7D81304
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c005::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790344262;
 b=BfK2DaNRu0nldeFErvI57t+DbnN4s4oDTkcLsAlHs8HTVsra9Re2r3eBeWycxjUE4nqr
 94KKzTFQf53mWdLpnCDHlItfKVttRQ3dJuEyzmKYfwD4U2wkmMeEaByCUf1dhb0bf3eBo
 ORm+TAFbgTXLsOYt7PCSrqfY+S60BD4C0z7FA0cBOE1/J3dWMKO42wHvhu481PlMGdyA6
 tEtZt63OzB/nYJLVvXSroW5Nni57UhRyex95+aRw/Uod2NN9KNq+/3o0qFoL60HHBUUxY
 zexQk/eVD+/T7Va2fvaakLKfecmxmT/ys/zUUQW9a42CR2dmJJuw91PHBfgWSiP9b8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790344262;
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
 bh=e1eVEiTcawr5wAgDPvEedv4CMzbLYzgFV0cE/RuFgWY=;
 b=CeSIm13BU/tephDg0YVqRWKFm+9CnIxieKxYQ5xXRVb5hwuYGBMgUh7vFJxK61dukAl/
 HSREhyf6tXpjFC8KSYl2DeI8Z2C1LoBFe3qJH9ZI/Dw2kJcnCLbVLdwy2E5zJv4ITy0ya
 dFn/g573mviP6HEVgFh4q+Df6Xp1i3TbaXl5mY6UEGju1jT1u2Y3YwSCrHumd+rqsKEus
 XXRMgF3l0BQ5Py0pzhS7vvD07qJQSQ8q9GITTPI5vm2bPBHYTtREdvz9B7mdpzpK3WMZY
 inZptU0oWqMVo8LPdwQzzdDAAuwi8+RCVWWCkAnBYu+B+CdVpqT7ssiFGpklx7ii6+g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=hIgn2qjf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c005::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=hIgn2qjf
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9B7D81304
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvLxjBhdQNX5XSfeOsuIL6Tdp1xySwS+2bstOCH3ZoEr06cxc22jPxABcCnR0SL7y17o6CrJVYNcbruvaGo8M0LHFOxerqsaO/DzEJUNc2dx+DEoO9EnGoB9mwDTqXmpsH2o6+oClqbzKQvPw9nTAnH7L9O87soGZKkLOz0EAAzh4X9UFQW32PNNWEVqqPSCnsvx5xKyFpwLSRONrxnRmsmecrZBjN/cbF644MFX3aZcd5+xiA6fxQWc+YyoOzydXd1hn8v2bNdvX1itIa0reoFZh2X6EHuT7c52NkSTvSQGnuUKGJ7iWtTJffBH+tjdiYvBtj1HCc/kDE8OaLe9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1eVEiTcawr5wAgDPvEedv4CMzbLYzgFV0cE/RuFgWY=;
 b=I5Q1KvudFcj7vSgDzOBgdnI5qXrAi03MbKz5vo6KlOXFhehaXhU7fw7UepwlRJmE2rlQ1bwDJmmdbE6kI17Z3sZ6tKvfX8+vQp3NOJoMsLtui23P3oKPJpVSdNNykslWVDc7VeQtrpveFJ35S+enZbfj3/FmuNrbvc++vv0H+BINuZDc7zRcwz1XTR2PYF1CL04YW1tT2DKJppyXvfMu/0LLjr5E5XC1YI41pBqt0WQarB5EmMPTi2I8I+oX6am98IZ3CddloNtj+TmgpofODOwux3Ka+ohqc3pS63MeoKag82vGNnrYcqMmPq6z3MIQtucCpJk36erzFWEkmdEu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1eVEiTcawr5wAgDPvEedv4CMzbLYzgFV0cE/RuFgWY=;
 b=hIgn2qjfvn4VoCObix1LLqoW74Zb2/Drzzd3NSmkwc0irpSGx4dTTvyLyTDtK4Np9kCF4xwBj7cdgOxKXrqqkK81kCsIdvtuEF2E1kebD2V43LyGLAbxhAcjLTGkzdIJHQMEBSFgS2qCnJdDXW286fIM0Ysu/52T2MQlcigy/Z0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SJ0PR12MB6965.namprd12.prod.outlook.com (2603:10b6:a03:448::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:50:57 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:50:57 +0000
Message-ID: <b4c696e4-4c45-42b1-88b9-c86b65ea3c9f@amd.com>
Date: Fri, 25 Sep 2026 15:50:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: xilinx: cpu-info: Fix inverted soc_get_* return
 value check
To: Pranav Sanwal <pranav.sanwal@amd.com>, u-boot@lists.u-boot-project.org
Cc: git@amd.com
References: <20260915041949.1957388-1-pranav.sanwal@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <20260915041949.1957388-1-pranav.sanwal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0053.eurprd03.prod.outlook.com
 (2603:10a6:803:118::42) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SJ0PR12MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c76736b-6514-4acb-f6ac-08df1b0c065f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|3023799007|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: si4prKWS2f8baaWWQ6Y1gSJbPm4D4rPfB3GLjlDsfKRxcjSOhGWv9srPbsT5AntKPOpaPYWYRkaN+WHg7JfQSHde9Rbb51acCESv7no3Mokf9wqwn/2CcK5hphxjBUrgHbkudy/5oetmMVcqBrSuEBw4Wc3VphLWtY/ytC51M2pRaKXSolcvCJXQoFRHNSo5LnjSh8EE8rngQJUtc+vHevVxevtCKGHvspRPYuZrztlt3kbL12MX8Qsj0OH7VsebotTH08V+DMq42MEM0XmJeKhzaxro87h5n7N1QQG+Q7r2rAhoH8daiK5LqwbouxWo7PlfHxTmTjNbZWijfFT3F3Jmr7GOAmzanwLVlaLwNXeW2he+GXqmGyQZ0cW6HFEcqXX7UjG8/ESAMzaUa6q18cqtDyJtNa9Bzn53IpKPBuzS4qAEG8cATt2V099rG+WhvVv6rGwrSq9HvoVh1OSF381881iq4a8DmrYEoLsZ7+WXVcfHA2LiYW8Nkig5hUkNH8KochJeLuJRnYcStTGMEcvyINCRXdHKyx6u+cGMniNzvD32ffqKBDGlHGAenwVf92HCRwFM+ZxYqeO0spz8SjVOiyECcEuCmOTFps2La+dUsDQDGYJbJf8RZU9XlVKCmozLEcdO3NoEUkFS8bZb8fI5UUzWA6BW9XyP/Dc+NUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEdlaWJQNVo0SkVoeEZBU0pETitKNXNKbkgxWXdxN2hwdEc5VWNXNFNNM3I4?=
 =?utf-8?B?bkRMMGxLMjRTZWhlNVh3UXlaLzFmNnowSmxVMWEzZ0hreW5QSUdGbmpkejhi?=
 =?utf-8?B?dEE1NHJ4bGlGRHBQV01rWmhoWEx4eGdPRjlLb0NFcUZKOEs5NU5QdVpwVEla?=
 =?utf-8?B?aTFySW9kNmdZZ0Z0eWZNK095MHg2bTBadDJsWUlIb09NaThteklqZWtKNHJs?=
 =?utf-8?B?dncyWG1tZmdUbHNEcnZxdHZIb2Zlc3QzZElDR1ZiQ3V6czJvbno1ZjBZNGVZ?=
 =?utf-8?B?cTdkSWpyd2RERGFOSEppdkQrRkllUktpTHJGWnAwUmVjTERzTzdPQW9FRjNM?=
 =?utf-8?B?VThpM0tPU2ovdkYzV1hTSVgwUmtvaXJ4c1VWcHNEMEM5b1BBNkNwYkovMURs?=
 =?utf-8?B?OHlVQzB4RC94T0laVyt1RHJ1dmxCYllHVXM1Yjk2YjhZS2c4NW5LUjlycjJV?=
 =?utf-8?B?K21MMytqTzNySVJZWTc1Q0ZrQjY1ZERXaXFRNWJrc2pRT1BwMmpBYW1nNzE2?=
 =?utf-8?B?dkE1TDNyeHErSkZvY2RaTERqZ3graFpRc1luKy9oZ3p4Ny9neGk5TGZmSTNo?=
 =?utf-8?B?OFZhSnEySjhFV0toTG9kVDMyODZtRFNYN2ZRcE1xaTFWOWs3QXlHd3Z1NUdO?=
 =?utf-8?B?ZHVkVjNjVDh0clVYSTRSL2dFTUtFcWFIUWVTUGdpUWlnU0U2Q3dWNWtsdFFV?=
 =?utf-8?B?aFlkN2hGM1pURmluOWp1a2J5alFiTFJvWG12ZGpJN0JVVXFyUlh6Y25uUWFN?=
 =?utf-8?B?N0tJWVhNSFBFVGV5bEh3Y1E1MzFOMlVuamdXb1ViZFdyeWo1MHRBTjYrVjlM?=
 =?utf-8?B?dUpDWE5yMGx4MXRDQkIySGUwOWNldmF6eElRbCtVWjliTDdSc0FrRWFyRk9G?=
 =?utf-8?B?TUIwd3VVNUdlNDFTYUFmMHRJcC9haFU4SCtSWjg5ZUhuTW9FYnNKY1JYdjRQ?=
 =?utf-8?B?UCtuMWo5U1ZwTkZlM1FqRlBidFU0TDdGd29uTU4vdjBWSXBQREUzYWR1dWJy?=
 =?utf-8?B?bmoxYzZpUnFaNWR6R3FEYjJpV1p6UFA3d0Y5VlpROWRjUjQ5eHkycDgzaUw0?=
 =?utf-8?B?Z0tHSHBwUWcvZHRmMVFEWlZYaWR2VVpFTzFwRzBIOS9yQ095NUZoTkNsWkU0?=
 =?utf-8?B?Rzc3eFBubHZ0Z1JSY0xCUEhYNmhiM3hBUnJ2d1J3T0JodW40K3RrZmlHR0Ji?=
 =?utf-8?B?SmRYejU4eE9zdzhLc1QvRzJ1bnFBNWYvdEFlb1RWbitqUzNONW1nV3ZmT1J6?=
 =?utf-8?B?VGNwRkw5VDhYNk1qNUlYUzIvMGJhWnBrRGd5SmsyNUUzOTR5TjRLOU11Sngw?=
 =?utf-8?B?VzBiRnRrTWVZWG8xNzlmM0JjSUpySUdENnNQOFRGQVNjT0dYMzY4bDBseXdk?=
 =?utf-8?B?a2pybGU2NDJnbU54cW5mcVhwNGhhZkV0Z2JTdlZTeHptQzhwd2gvUnhiZEUx?=
 =?utf-8?B?SzVxcHVtdm4wTk9mUUxUcTdiYlUvT0NhTzl2ZUE0UHFBQWNpa3lNTHlTQ05G?=
 =?utf-8?B?cEdtRjFhNGtlZm5IeExNUDhPcjdoa0c5M05CM0hHd1JxUkQzTTdNMURtd2tq?=
 =?utf-8?B?anRocGRZbFg0MVI1YUhGS2J2VVo1eXcrUklOSEEvL1VNemdTWjBBZ2pKdVBR?=
 =?utf-8?B?cHV2cVo3RCtzdUZ1S2JkQmZWN050NXFYL3dvRGM2YjU1Wm05RUYvL1hIeDZn?=
 =?utf-8?B?YU15Qm1ZUHVTRWo2eE03Z3QzT3FUMnhxQ0dZVFZ4N0FnZ1dNRkpoTFZIKzVM?=
 =?utf-8?B?UGV5bmZGZVBubTN1cUh5SjBhM2FyS2s5NGFFMFkwMkZuM1hRUXFZK2JWRXh0?=
 =?utf-8?B?amFiemtxY1hTdjVlaGpUV1E4UzhOZFVJeHI0OWd4WnVOTEFESU8wT2N0bTJx?=
 =?utf-8?B?SmhyTUxBeDBGK3pQTEhZaXFRdUM1S1NJSkZmK3FJMTZuTHg5WXR2ZmF0NHNW?=
 =?utf-8?B?NzhDVU1tM3djRG84UU8vTFpta0lqaXQwbFp5UUlhdlVuNnBmM0pBRXB4c1hr?=
 =?utf-8?B?ZjdEdWd3ZHp3U0V1ZnBKMXNndW91ckh2dVMrU0FFZEMzSDFnc2pSVGs1em85?=
 =?utf-8?B?VHpFUGZ3TFdLWmdTd0dNQ2FiV01yeThkQ25acHZaMmNMelQ1Znp3Qjd4YWFu?=
 =?utf-8?B?eElYTS9Zdk9KNGY5Vzh6MXpDL2Jxbk8wbXp4TEZRY0ZXenJhUGNYcFJ4V2lr?=
 =?utf-8?B?MlAwY3h1NXg0eEw1cWRCSVdObXZDTzFOTWE5VTBaZzN1WE8xQjREUWVuMjIy?=
 =?utf-8?B?VSt6V3RHZ0pzMmlzKzltTERMVE15VHYrNzhuQ0FIR3FnSW5kYkZmZlRLU09C?=
 =?utf-8?B?ZFFRb2crcHZhYnVualpZcmVRNHFQL0hiS0kzWlJpOFc0NU0xOE50QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c76736b-6514-4acb-f6ac-08df1b0c065f
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:50:57.2088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6KS39Mre/1QQk2BIUnlOHwDtgB8UGkM94jZdwEcGwPsi2+CGjXt9bvHpfHbOUib
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6965
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



On 9/15/26 06:19, Pranav Sanwal wrote:
> soc_get_family/revision/machine() return 0 on success, negative on
> error. print_cpuinfo() checked "if (ret)", so a failed call (e.g.
> -ENOSYS) was treated as success and printed name[] unpopulated or
> stale. Fix the checks to "if (!ret)".
> 
> This alone would drop CPU:/Silicon:/Chip: output on Xilinx/AMD
> boards: soc_xilinx_versal.c, soc_xilinx_versal_net.c,
> soc_xilinx_zynqmp.c and soc_amd_versal2.c return snprintf()'s byte
> count instead of 0, which the old inverted check happened to mask.
> Fix all four to return 0 on success / -ENOSPC on truncation, per the
> documented soc_ops contract.
> 
> The wrong return values also affected soc_device_match(), which expects
> 0 from these ops. With a nonzero byte count returned its strcmp()
> comparisons were skipped, so any Versal revision matched the
> { .family = "Versal", .revision = "v2" } entry in cadence_ospi_versal.c
> and took the CQSPI_DLL_MODE_MASTER path. After this fix family and
> revision are actually compared; production "v2" silicon is unaffected,
> while ES1/v1 parts now correctly fall through to -ENOTSUPP.
> 
> Fixes: 86ceedd84e2 ("xilinx: common: Separate display cpu info function")
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
> Message-ID: <20260912111037.767370-1-pranav.sanwal@amd.com>
Applied but next time remove this Message-ID.

Thanks,
Michal
