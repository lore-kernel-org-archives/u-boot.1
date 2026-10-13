Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23FBCC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:14:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B283B80C93;
	Tue, 13 Oct 2026 08:14:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6iPgR-e7fvWQ; Tue, 13 Oct 2026 08:14:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E3D7D80C98
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791879251;
	b=RLnM3YoFT2nwmDB3mDW5FSVmo3b69E01PTm/Pm5yzsWU1pai70eM5VDOWH2mlP66EGMh
	 kmWrsl0FhshRaNjffJVO0goqp7UczkB4J4iiBkx6KRfOFe6w1nSLKnFyuEytWVizjns1I
	 zYKHhaFCD/gqvTxJDXYX7+pV8vrz5eLdCyOjKscva1TcHJOdeieGhfog1yHXL1oUGxmUi
	 aVVAQ1u/UxPBmM71luZd3WQYc4oQVmgXH/zcZqWrD35lqFaW8uLj6jHk0/TqPrrykb/bf
	 cjmbzSvXRTTtfRsPUiRyjVQ3/0g8o+5jAdMCM30kkxoz2UxeO3Dq4miW/KL6CooTLSg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791879251;
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
	bh=6Bny+ICFvtIssagcSAuKNTK6niHxKPO39z4xgZe0xHk=;
	b=EWyFERJCg/91G8ZxWgPWdKHTlBsjyYYrTKnRCDITjOc+H9LXsOE4sDpMUbKXpn10mn+1
	 xCly3oW5Hw5f/nRoSlU3Cmbd2dxV875D61gIkIjEcbbLbWg3uyelhMdCHcm+vQvO6G5px
	 b6NJstFo/4m2IQvY7g9TF4Qt6nqB35mGqmJFMHHEGevcP3Fr6sbP0fXpIngiLyt6pwsbZ
	 f2rk67C4rjMROW6YMJgdT1YN5YY6d35gdnL59S2n10Xpk2WsFNspdXHJGl5O0BfCe2Mbk
	 taHg9jFMAAO9iOKumKTdlpbgcsyIylJGbu5TFzs/C/tkkPZTAbfwx+bP3J2wPQSYAzw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791879251;
	bh=6Bny+ICFvtIssagcSAuKNTK6niHxKPO39z4xgZe0xHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rthW8YfJmX+ejVgWweQyUq//I3f+klqmFjaNf+F/bPWZNHFRcXyT3QuyAuJm35uOz
	 E6+Z6AE+Pgcm5RrJoAps9LevCwc4sSUk///U3vCzv2ZZOfUVg/S9tcsLUtPgT1Jacq
	 I4qB4iA0cWmHYVc7oNPAcLRKp5t4bxClQmsyISwX+WtDbrd/WrMPxKyyoGd2EjArJb
	 9Lpl5B64gcp/mZuPeeWIK8LqmGJk0pFV6+iKClnvPQ5C3/UqAUgXRVbl5BzKkmN0ED
	 hs6PzB0XygxN4iQHt6quxHbA4e+N4OqKSPd7/taabH5T41f37Yrt08f7LfbesbOW1J
	 9/IqL6twui6SA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3D7D80C98;
	Tue, 13 Oct 2026 08:14:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 505BA105
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40AF06074D
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:14:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fZCjlq8D2S0d for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:14:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 13DF560755
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791879248;
 b=TDJs8LN1vrZrWlB6aN8R9QwKbHXq45Ht+nPXaWjmMZ9QMbrV6H+0HdeHaYgK/UzOHeXA
 FhEWsN6Jn3JgZRmbxFsVYeY1S5ZMfxuYeVTHz9I/JSKfXg8+vhRXaqsMFFGHaoBm+Bv3i
 zqAW6Z9bZ9pUEmy3GoKGpn7UGKmqttByjmXBh1BlKQKPRvZcVII8GSP2KjKgxpAlNKNsn
 YA3tjPEEhbzHDkIKVsQoO0vhEWjU6ZqOb5lHSqBNGGlANdD6PFYy14H+ngOuGV/GyZJSh
 sUM2EVJ2XijlCMNIjPpPda7hG16Q0sqJS+krMuId8sK+THZTRM7nGhPZ8CIOJxHxg0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791879248;
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
 bh=6Bny+ICFvtIssagcSAuKNTK6niHxKPO39z4xgZe0xHk=;
 b=dxmaWbQJt6pvlpDb0rWwvmzqqMnkcFQPYhXAD5orKiSua2qUewsdnr5JmRhVW27B9OTw
 aKxXzbqbAlfG0yX5QE4jg4dRlFe5IUILRtAkS1FglabIst1MrKr5aNQlTCxyvEKrV+Cy7
 skQ5uiiPrnRXozOzCyK4SiqaVHdU6TLrn7DAm9FR0lPhtYaqXbPIKIhP1LV/hkvSH8tEr
 hKwF4YFu3LRR8ZCMqxNvsQF6xF3fGi5fVVhNygm/Tf5VD8ssNGHL2JGwjhGnPQOvkkvcn
 /SIGxvJytDcXNOHL0UMPMEeLbjvMLeh+nCHtS5JUCTcYHdQs+zZ5bdRBTZn3mfhjqOg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=WB8SxipJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=WB8SxipJ
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 13DF560755
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzVTQW9BMKCgpvBQKiVLRJseuG09N1iqeLq9hRbcQ9Isa0qIQfhM6oG4boNOrr6QL0lXlLUjsiNDBfVygWBK1PySwbrBVY2mzkZCxf1244y4QP/K74lagAeLf4CjrcRke6VayQUbeJZJo5kaWvxQl/3obfZoKwfT8Bh8K+uB5ybNPXAo4svrK1HCkDJBNX8dVa5s464cC1OSn6TnnPQo7Ej8HAahhuNaGKpkgWstq3yxblAd/ONPK5aTIECZXdLr2D0wPab7HvwbYpN5MYlXSXOYE+SsZpdl1maHljqIIF8TB31x/YChkkZycEnxgmhj/L+b1l066K1BjMFXOaxZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Bny+ICFvtIssagcSAuKNTK6niHxKPO39z4xgZe0xHk=;
 b=AqTTAzN1+zQ7mnkACaSTQe7UYkcfxOxqLkbVn3hnkns5YYbOqa7WLIRQiLQRrILmM4xc3xffQRlB9ZvsJRj0kih82q9vGu8Hq4f2+2UCDd2fKtx7Fw/XIYCmmoVUh8oDxaef257JFdg2qyPECb2oQHGY9PwWsXIX51UPYiu8Ddz2jvA8XQ1PBKm2wTYpL0PGYiPZ3YzYqmIww3g7pQD/zLv6k2UAJ8WLmz+KxDn/u9eIWoztBbc1jJFNb+lSm/y9QaLxUtl2DE3Ggdbz5O9yKCu0ovU45PWTogvl2qg+1yNrN29oZp58ArOoF0LGPVKhguEC+hSjeG9CSbgeDp80IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Bny+ICFvtIssagcSAuKNTK6niHxKPO39z4xgZe0xHk=;
 b=WB8SxipJ1efeyQy8WcXyCb2xgT1oZylfQuQRKaoLc9Tqg459yHhUhD6X4ZKBUfzGfOt9MZl6Mpyn+9g79uzaRmXwIYGwPqkqgcv1LZcHk6qsjDz/r//Rfxe3khaTCMXTUK2tr3XeJUe6x0EufFaVOCTeiy98q3Zx5aCGryhYWb8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Tue, 13 Oct
 2026 08:14:02 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 08:14:02 +0000
Message-ID: <8c68a566-efec-4e66-bd22-8362cee41f05@amd.com>
Date: Tue, 13 Oct 2026 10:13:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: versalpl: move PDI load operation into firmware
 helper
To: Akshay Belsare <akshay.belsare@amd.com>, u-boot@lists.u-boot-project.org
Cc: git@amd.com, Padmarao.Begari@amd.com, Tom Rini <trini@konsulko.com>
References: <20260921185822.3493122-1-akshay.belsare@amd.com>
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
In-Reply-To: <20260921185822.3493122-1-akshay.belsare@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0118.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:358::12) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 9848c484-712b-4737-5e16-08df2901f0c4
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|10067099003|261009223027099003|56012099006|11063799006|260925021911599003|260925022911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: 9hpQkpN1ZW/lVJHQb+hns2HrJpmCRnbhRKEuT5hfhbFRR/SjmLA/qOYw17GDsxyxghdzBdRsNsaXuEDWKupkoDZZEznkuxmg5LhrBX4GTZMlmduyedfrcbi5yIlt9dw9cQM/fVUSmNpxalpbClhZxIuef+YnPO6gug766/5IxyaCAWWH/2hFLTP85jFMG01Qm5iPKXUdg4AFeSomc8nGnWS3jOKQRtOg6lk4plhp99QXaWi7Q8C2ZgY1WbEaC2Vi+5hAR0uzK4YaBrNMLRE1+IetBLkSnky2ONXP8Al3lbfZJKBR9ERo7BZ/F4ycOXlR2gXwuO8UBQCY9CYgtuYRwJnl+2jTQvyqozsrPMZA36Cczn5w+PQNeB/ZhwQ43nDdX+ul/7RI87mLbprwrcyfMeaev7zaoIUec7sVVI4meT0AAi9EbMudH8AmHXOmqpAtbf7+UbV00xFm2FNo/eB4H9MecKh/D4WFlphmsisZ9uDMpm4oJ39HBzH3QS458J8OuIJriIFT/1xxlZlLDR08Rrb7SrkYbE9AlobDP3bAF80RCMFST3n8nvwirr4PioNhAZkxi6KuQrEdXRJ/clGeMnQ+tfl7GOh+bnwL3T0TQITIVSQV+TxcIvi7QaEFTxrvt4cBKE29n6Ac5qc7fcUOwZ/MxjMen9r2h+Pd9Jqaqxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(261009223027099003)(56012099006)(11063799006)(260925021911599003)(260925022911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEpQQVYxZTVJc3hpa2V0L09xSFhTNEpaU2g3am8yYTFzYkJUQVcxWGp6YklP?=
 =?utf-8?B?UUFlOWxWSEJyTk1BZ0JmWUhDMHJBSFQxL0piT0Zsa0JMTElpdkhVVUdCZFZ3?=
 =?utf-8?B?WHVtd2NTRGVXTG1zSk0wNEJSYnNOUDlTdkhsTVFsR3BpR0FQczBFUTBkb0tT?=
 =?utf-8?B?aU1qd3JObUppTHVHY2ZPTzZndWVNWVd4SStWVTUzcWpHaWtCNmM1M2RGZ2hZ?=
 =?utf-8?B?dVNTNDdSY1R6TklWK1JJb2pQYnVKT3IzV0s4MitFZnZLWlovbXMzbDBtQ2FI?=
 =?utf-8?B?RmdUZlVLM2ZMK1ZubHFEbUlTb3NsUEV5NnY3NDI5MElVNFI3cFN4QWI1QXZX?=
 =?utf-8?B?NUdBa3R2MGRoT1l5d003ZVk0czBIUHRRNFdtOGpkMHRrOVNEQTdYSkJmYVpW?=
 =?utf-8?B?bVl5b0ZleXRhZFp6MEtZampiU241dnlMMlZQU1c3elVUYkgyS1BhZW5UTWo4?=
 =?utf-8?B?M2g3RU5RTjV1RkI5Q1BLNVcvNllONDlpQ3dOanAvbGxrcFo3dGIvNUZMd3hj?=
 =?utf-8?B?WVBlQUpuMW1Bd0U4VHg1eGFPbGMvNE9Uc0tIRzFWeDhmQURzdm1XMjBHRU5q?=
 =?utf-8?B?cy9oTXFCMWlUb09uRVE3WVhPRDZoRVdFeFpmK2k4blZHanBoSVdpcy90bThl?=
 =?utf-8?B?dmhtdUU1NjZKaGxEcW8wYkN1QndDbjl3Sm0yMlBGR0RMK3h1bU1YYUdBM3N4?=
 =?utf-8?B?dDJKUU1US0VBL010dThXRHN3TXRNNHlnZFpadmtIMFV4Yll6WEpDYUxYdVdC?=
 =?utf-8?B?WExhL05PdGVHUWJaNjIzcExFZTZRcDJOMkt2d01zMnp5SWtGZ0NBUWNVU205?=
 =?utf-8?B?NFRGbUxxMXUvM0huTXdKU0VCcm96RTFlYm10bUlqUXE5YTFZWkdxYzkzU3Nk?=
 =?utf-8?B?VjdQVTU0dUsrREpzeDg5WXplaHNUMG5JRTlTMncrQitnbVd5T3o5MXRUOFVR?=
 =?utf-8?B?bFR6VXZ3Qm9nYm14VWhPSytSZGdWMTZyUzlzQkF4elp1dGpxZ3FvNU1GT1VR?=
 =?utf-8?B?aUpkd1RSeHZSN3FtaUcvZzI4azFoQVM1MGFXWDRHSU9SU1FGNVNJWkhqVVRm?=
 =?utf-8?B?d3dkMUl5a2FmT1BUZWJLNVB0SmtrMzlzMllOQkd5S0lEZHYzRkE1Wm95OW1N?=
 =?utf-8?B?aHU5NVhwQ1BQczhsSzhUMTBZeGU4NTFicDRYWXRZVUVuc1FPRWtCUUxOODBr?=
 =?utf-8?B?OFNCTmp4anl1alpRNXArd21lK0E4WGFETGdOWDZ1ejJGTVpmVHNHL3R0NFc0?=
 =?utf-8?B?Y2RqZFROOWV0OGJtOEkxY3gwQWxlc3VBUlFIbE4vTzZaZElIQTZZZFE0U1k2?=
 =?utf-8?B?UHRaYkpIbExzeC9wZ2xHcS9XZXVEcEM1dTJ0S0dnV2dnNjNrWUdnWE53U2JP?=
 =?utf-8?B?Q1hCc0I1Y2dhc0Q2MUJrbUx1WDQ2ai9WTnlvMGZIZlhleHgxUUVPdmd3aWZS?=
 =?utf-8?B?NjBmZEs3VmtEWnBYRWlwZVozd05LVmxzYWxjSElXbEoxaisrYmdqVWdXRU5C?=
 =?utf-8?B?S0Z1VnFCS2JIaEJEV20wUWJkRDU0bkJ2ck0zUzFEZmVUQWtlMWNCeWFvRU9r?=
 =?utf-8?B?UjZ0WVEzR3Z2ZHlmU2tBVWVrWHVvNDQ5akx1TjNnZUwvRmVVRDVkZUFXMjg1?=
 =?utf-8?B?OFlrclJzTjRIWERYUnBjV1k4MGk2dURhdndSZC93MCs5Nk9HVTMvRGdmVmkv?=
 =?utf-8?B?K09TSCswdFZ0YTQ0d0hseTdaaHFIZmZseVlCSzNtYmhCMVBVME5LQ3RrTGVr?=
 =?utf-8?B?ZjlkaDk2UDE1aDZNZDM1bjBVWjdvemM0TFczZkJSdEdaZm5vSndOVlZsL0tB?=
 =?utf-8?B?UHpmdGgzdVl4QUZ5SjJTQWdlMkMxeWk1UDNVTEl5ZWdOT29NRXcwSEpGSUtm?=
 =?utf-8?B?ZkpUbjNidEhSYWFuWEhjN1BsRDZpUDdmeUgyZHVFUWh2RlhNZmNqTFNVNmFI?=
 =?utf-8?B?UGkybUpQZFl0WlNzaUhsSTZJSGNudVpuSXZoTXJra3N6Q2JpV3Rab09UTVoy?=
 =?utf-8?B?aWN0RjRRY1UrMEdMSU1RRmtoVnJBOHlrSDRzMmdtZjltazJ1aC90Ky9DQ1B0?=
 =?utf-8?B?V0x5b2NvODM1MEh3Y1lDSnhWdHM5K05rVzZKZVFNcVJDQ0t5aFdaaEtaUC9o?=
 =?utf-8?B?bGQvaVdibjhtMmdXUGZ3SWNnclhzK1hRQzZRaml4cGJKZTByMy95QWJsbkhW?=
 =?utf-8?B?VGRqeEdFbW5HeUFDM0hJVnBxYzl3aUZxaitHREY1eGQvNXN1eU5wSCtQVlg2?=
 =?utf-8?B?azBEc3E5T2hHNTRNOXpDN0Y1dmZNeFVVUklFdEFIbVJLWTNPUURFUGsvS2RQ?=
 =?utf-8?B?NGpzVHpPNDFuNnd6N0Yyci9nYVdqWThNREQwSmc4bit2WnpPK282dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9848c484-712b-4737-5e16-08df2901f0c4
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:14:02.2601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xevcn6FMYeNaD1Lp32jVFlU2/y38Ps9gNimBnz0hNnYtOq0mbJ2E+bpabUe9NO7i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
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



On 9/21/26 20:58, Akshay Belsare wrote:
> versal_load() calls xilinx_pm_request() directly for the PDI load
> IOCTL, including Versal Gen 2-specific buffer address handling.
> 
> Move it into zynqmp_pm_fpga_load() in firmware-zynqmp.c. The Gen 2
> buffer ordering now uses IS_ENABLED(CONFIG_ARCH_VERSAL2) instead of a
> runtime desc->family check, which is equivalent since U-Boot builds
> one board per image.
> 
> Also add a weak no-op default in versalpl.c so the driver still links
> when CONFIG_ZYNQMP_FIRMWARE is disabled.
> 
> Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
> ---
>   drivers/firmware/firmware-zynqmp.c | 15 +++++++++++++++
>   drivers/fpga/versalpl.c            | 20 +++++++-------------
>   include/zynqmp_firmware.h          |  1 +
>   3 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index fae66ccb3d8..ddfdb0cb195 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -14,6 +14,7 @@
>   #include <dm/device_compat.h>
>   #include <dm/lists.h>
>   #include <log.h>
> +#include <versalpl.h>
>   #include <zynqmp_firmware.h>
>   #include <asm/cache.h>
>   #include <asm/ptrace.h>
> @@ -175,6 +176,20 @@ unsigned int zynqmp_firmware_version(void)
>   	return pm_api_version;
>   };
>   
> +int zynqmp_pm_fpga_load(u64 address)
> +{
> +	u32 buf_lo = lower_32_bits(address);
> +	u32 buf_hi = upper_32_bits(address);
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	if (IS_ENABLED(CONFIG_ARCH_VERSAL2))
> +		return xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE,
> +					 buf_hi, buf_lo, 0, 0, 0, ret_payload);
> +
> +	return xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE,
> +				 buf_lo, buf_hi, 0, 0, 0, ret_payload);
> +}
> +
>   #if defined(CONFIG_ARCH_VERSAL2)
>   /*
>    * Poll the M-PHY TX/RX config-ready status until it settles or @timeout_us
> diff --git a/drivers/fpga/versalpl.c b/drivers/fpga/versalpl.c
> index 3cb56cc0dc9..29d2a389fd9 100644
> --- a/drivers/fpga/versalpl.c
> +++ b/drivers/fpga/versalpl.c
> @@ -10,6 +10,7 @@
>   #include <versalpl.h>
>   #include <zynqmp_firmware.h>
>   #include <asm/cache.h>
> +#include <linux/errno.h>
>   
>   static ulong versal_align_dma_buffer(ulong *buf, u32 len)
>   {
> @@ -24,30 +25,23 @@ static ulong versal_align_dma_buffer(ulong *buf, u32 len)
>   	return (ulong)buf;
>   }
>   
> +__weak int zynqmp_pm_fpga_load(u64 address)
> +{
> +	return -ENOSYS;
> +}
> +
>   static int versal_load(xilinx_desc *desc, const void *buf, size_t bsize,
>   		       bitstream_type bstype, int flags)
>   {
>   	ulong bin_buf;
>   	int ret;
> -	u32 buf_lo, buf_hi;
> -	u32 ret_payload[PAYLOAD_ARG_CNT];
>   
>   	bin_buf = versal_align_dma_buffer((ulong *)buf, bsize);
>   
>   	debug("%s called!\n", __func__);
>   	flush_dcache_range(bin_buf, bin_buf + bsize);
>   
> -	buf_lo = lower_32_bits(bin_buf);
> -	buf_hi = upper_32_bits(bin_buf);
> -
> -	if (desc->family == xilinx_versal2) {
> -		ret = xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE, buf_hi,
> -					buf_lo, 0, 0, 0, ret_payload);
> -	} else {
> -		ret = xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE, buf_lo,
> -					buf_hi, 0, 0, 0, ret_payload);
> -	}
> -
> +	ret = zynqmp_pm_fpga_load(bin_buf);
>   	if (ret)
>   		printf("PL FPGA LOAD failed with err: 0x%08x\n", ret);
>   
> diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
> index f753a67ac27..e0759359846 100644
> --- a/include/zynqmp_firmware.h
> +++ b/include/zynqmp_firmware.h
> @@ -467,6 +467,7 @@ int zynqmp_pm_feature(const u32 api_id);
>   u32 zynqmp_pm_get_bootmode_reg(void);
>   u32 zynqmp_pm_get_pmc_multi_boot_reg(void);
>   u32 zynqmp_pm_get_pmc_global_pggs_reg(u32 reg_addr);
> +int zynqmp_pm_fpga_load(u64 address);
>   
>   /* Type of Config Object */
>   #define PM_CONFIG_OBJECT_TYPE_BASE	0x1U

Applied.
M
