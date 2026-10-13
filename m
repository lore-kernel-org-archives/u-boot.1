Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A571ECC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A5B580CA9;
	Tue, 13 Oct 2026 08:06:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8vF0ZXUdrizs; Tue, 13 Oct 2026 08:06:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9CB8580C98
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791878787;
	b=bx8KM+KWt8DijRZ54Lqx0gP4l0q2gek+ALMsix0qTJFnelfi5Qi/AQv1K08+CWeU+MGX
	 Zwc5Kjs/qDHMwxig8EP+ir553epw4SPO8LEZhI6W6GLem2smVwohDBYvOj61Xw6BeF0FL
	 3QeOB6nINFDkS6m/pup7mpELu1NHCSvxiaRf3qPrGLGHqC/Vpq5HB2KPnY4BMiq2yIHDw
	 kGXan+l9letFU0RT2A1J0l89uZ6Fikl1hwn4v4uVgi8xL81ds/oGaRXug8hUE4PKmjFwC
	 4zHxjIM66oj3oEPrq2ADkjjJLUBRYV8S2uv2LfrBBMvQ8J2hAfQaz65s1LEFcVwhRyA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791878787;
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
	bh=7yB791Qlio+TheTfQFC75rQRHiBlmrzm7WYYmEOPVIY=;
	b=Zh14UxTJ2rhGLdE/erFg8L6JVZijaCwl8rtaUCnYyZ0RMpgTxaSmxz2zmG9qPEfFMwtC
	 GRao1GrZkM7JzU3/M5J6JsGox79bPjSQmotXEZV5WhAryIk7PDYaE6mp6dAOaG+F8Q2E8
	 /W5/++LU0MTJSw6KgsNi0BVZUKQGUxsHgdvA17s8N49qaSPYFKAKjobw2P3tlc9khe+A0
	 VROE9QZm8BBn3qdAqIAa/OyQccQiygm5jaMxmcklzaoA8kp6UvWVRHDIlv6xbbL9tpf4G
	 aS3N0feyR5g1Qjzdj5M6rOM986Vv3musIXGh1ZLowsu05zsJigYZfepTg6Qo7NvUmRQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791878787;
	bh=7yB791Qlio+TheTfQFC75rQRHiBlmrzm7WYYmEOPVIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TOkd36S28IS1YthGP9HrkhpC4C8Wd9TnPZpZOJQdT9UYKIN4MopaKeAmgxN//MKTL
	 EwW3iM0t90nEL1JS25rW3TUB+/ug7YhGbEtk7Ivg53P05LAJBl5J7N9xralgD6GO/c
	 DFSF8c6wHQ4BUv41G5dPL9GnJZVc1Q4MsdXwx4aqcGpCrb3QUKH1fzLK54pYsSEyBq
	 84VuNI/6HS9RtkG8UTshXeJJmfDlhWoxlg/RsoR90g62+pkBYVhU2YghDKi8QAe3QW
	 JYwTO43sp/dXWgmy6u1UNFfsrFFWm64wxdEHz9UxpFAPlDqxR8S+zlpOW0w1tBAk6+
	 ZatrC1LGp/exw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CB8580C98;
	Tue, 13 Oct 2026 08:06:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7038A788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:06:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51EE060769
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:06:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tr28dhxo9R4Q for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:06:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 24C7F6075F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791878785;
 b=aTkG5qcZ1Y2EqNKyS0i1N1kzPSs3XfVKAJ/akJzoYsdS5PAvxd4a8bbBBZvwxWKiDREO
 +3tUiGMtQiijYuGuZ8VtVpvldxKmeMxFh1i/BwVQtBq6+cdYQ0ik95IPDAHKY1YkjU0Pt
 GD3KHEnXtjWNEFB8w7Q9MnLwxx6m2ksYQDCSSqKpJzgbCsDqFC+nSCkZHopPx3M/9S62/
 wcLhZNMnnK3sKqt6Yi1pn8KCJT3QIWpLUkdia46cGP1t8QbEbMS6BpNnoFpgnCAMpdMBw
 rG363epJ0XOFn4vPGtw5/GFtYv9I5UY1PhLUfnHg2ZNREUbcgeoPXp76JsN25ws7LxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791878785;
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
 bh=7yB791Qlio+TheTfQFC75rQRHiBlmrzm7WYYmEOPVIY=;
 b=l1OT6E4ybP0ZvS6RlvRI/A0Q0hEHX25GJRmX9YCUAcLBe+X+5RUXN8nuPD7Xr5Qjy2Tx
 5csGlvOfKr86qKs5VGpXdDOCXaOdQVGbYVA/WR/0foBpy44zsEl62dKv3y+jYXCFfjveL
 zvdz+LuWMGBfVLlPjdWAnPvu8iJqdHQuH8yANoNcxPCjfVnwwOwAjpVCSwWTCMQy6fYfw
 TVb1YII+XjpIOP+wWodFotN4CI+uo3EoiA4TEdf+O45kmEvHNe2fSHNuk4Bj7dQVi/5T/
 iDIuKc6hoFrmHSHcxsjUv4s8NyxYmauvmJ+pLz+fsvrwmRCqUyXlE10sEfHNTDcHBUg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="mfg/szb6"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mfg/szb6
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 24C7F6075F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:06:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ocnb52o3aEOntA3A90SJ43AtpJDR0GWWhk/1kp1F8L5MKa/ySLndnJXJ7OlzYfzOcAKKJP5yV60Jv8tsQUUbLhUokMbLcIZSGWM6P3A2O0trqPc7DwIvnqugBuHD48xB9i2RQ3rJhyfRdVyHqGjWUxfVTLp5l/dmtwMHA3XCl29azY9W0n6LQSj+FZk2jAD0sy0YVPPv0JOVU79iJ0YQZ4EusxGkbX4UhCSgaOw/qBU86dDUWLgEXv+eZYGp0y7AigKTRBG35cV6pZjHmMA+ai9gBrmwEyf9DTb58vSjiAFWBL1nbpczNZk//U578vqccM64oExV4CdBQCjpIHL3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yB791Qlio+TheTfQFC75rQRHiBlmrzm7WYYmEOPVIY=;
 b=Fb8d5wzzwR9Y9mlWK2qK7tdgnlyHxE63BV/2FIP83ytWgK2fpSeNBQuonfvEdO7c/O4fULflTVtXcWZybxJSiD0PC49As2iQgkhw4GJrs+HzwyjNlFS+HBXnLcZBakd9NvCJHPl2kTcPzNs728YMgtuzWYnQz2nGKtvv+4h2JSkUDZyrQ5XqKiLpA6eKli0i1t4TIFT0yUPtQeqXFPaUx8vb18vRSrzsFAVJr3djZhR/GSea6QQXKY9O5t2ATCjLxDyd4YqU1MvjrlFO/+/YMwCoDKBzga9li01+k6C6qXLOwvjvM8DTHwfY/UHLAgdeXP2rPZlyaI+ZC5e888J9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yB791Qlio+TheTfQFC75rQRHiBlmrzm7WYYmEOPVIY=;
 b=mfg/szb6DTY/zq6zp36KXPS+kkTAJkpRy4PJH0bX55IxP0J3gNrVvJZvzNfxWIFyD2fjp+8CAogvnumuhGksovymcfwiR7EIHZ+7V2RmdlwKEk8d2to7zCYAntQfPnbIp25RVLc1PweNVEfCQJt09TYDgvRr9EltNg1uPe+UZhg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Tue, 13 Oct
 2026 08:06:16 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 08:06:16 +0000
Message-ID: <1743b441-2bf2-49f4-b1c5-fb2da00b9aab@amd.com>
Date: Tue, 13 Oct 2026 10:06:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: versalpl: fix OOB write in versal_align_dma_buffer()
To: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.u-boot-project.org, 
 git@amd.com, trini@konsulko.co
Cc: padmarao.begari@amd.com, akshay.belsare@amd.com
References: <20260930125209.1030679-2-prasad.kummari@amd.com>
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
In-Reply-To: <20260930125209.1030679-2-prasad.kummari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0135.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34a::7) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdf87ee-d88d-4aef-cd86-08df2900db50
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WRRiyu8SnVSmy8EG2ZoZERDpYpK2YgrHgAdWQR+2i5/9IA2ihMt76e2/F4rfe4OKlIFOvjSN0uA334vwWU7fGwTdVNeRglGQlvcHrnK6xK1/zYLfNTnhS96L0hIka3eQGYcaiLjwD/DibR3T24tValz6oXGQBnS3ZDXgik6Jo4FqFADapR+bZsogK1+49q9uiSkfzcelKZIp83rm4rAQ3Y5igOYjDcPGLYgQiByvx2usD0tIkzit6JVw5bMq9FoVnc1zZQFtqi7vQOlGc1XJOF+wrDRrUZPCIGeM7UnTDuexR+uIMHDzh6l4GGlYcrAM/az1P1ZAl/p2u74h9+VCxKkRoSyPpSROypIXrvos65zP8rrWuH7DS2+HV3Dp8OumN04GP7m//qKI8DDXe9SKZrTzacMAdjToowOu/pON5vJiYZK3D61NvCWvzLC7XZ9Msg0vRn4R0FX/QpUnmp9SYkVEPYE2ZnRhDSlywcbaq2TGvKDXmjFJVOa4KviHnwlCyXNT2fPbT7AFx7DbSb4FiAVBm4N84AkmoBCv4w6LXst+8Nl8adySzsVwjuqKMgaM7PvxqiTHhau5Dxt1qkjrbxaSO2eiA2ayEJLgXCAPtusJGAs9EnkXqh118jNWWs5ICysS01s4uU0ZWOG02XjvBr5YU0gPt28yaNcIOiG083A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXRacXlpSExxelo1dUVYWXk5N2JONDY0clA4aE0vUUhFeFF2NDZLVHp0aW5S?=
 =?utf-8?B?Nk01S3hKZDF3TXdPRU92UFo4bGFrUWNqTWI0Q2JNamVkblh2bGx0dWsrUDFW?=
 =?utf-8?B?UUxZSWpZTml2VjNSSUtJK2FBdTZMaDRmYjJ1ZjNhTDJOdlBneWsyQnF3bXRP?=
 =?utf-8?B?Wnhmd0NpU3ZuMks5UUF3R2NtZHB6U0gwalNnVWdjZVhzcEtSSVZKNTZpazM0?=
 =?utf-8?B?WG1VeFRaVm1jVkZma05yRk95bkdCMGNjdzhhVEpRWS9wem5sMHpWL3JRQ0NY?=
 =?utf-8?B?U0Z1cTZmUmpPcTZ2d1ZwNnliWUFHY1h2dWZhVXU4RGRDMEFFODhPSXFyNisr?=
 =?utf-8?B?Rm85amVqa2tWOUMxNFp0VTkzT3FseDZnc3JTbElCK2VKNGtFcURFck1vcDQw?=
 =?utf-8?B?aEVyZlFSVDNOcXZVdDBXNWRYVklPOHVrQk84ZWg0VDZDcVErd2xQSDB4eVZs?=
 =?utf-8?B?NmxXKzhKR3FUNmIyNStmdlpUSEJseFJ4N0psZjhrbWlBcWdyT003amdYZk1r?=
 =?utf-8?B?V3B5MTZmMmpUMHR3ZDg2SGlpRmNSNWZzeFUvdzhBV3dsTjUxbmNYL1pOSFlX?=
 =?utf-8?B?b0xqNjhLSmkxOCt1MjNQdlpSbnlHbGNTOW9JcDJJaGlSV25vRFBJSWhsR3JX?=
 =?utf-8?B?Tnh2OGpKVkQzUmRxSCswNmpsMVU4dEVMZVlrbEhqdFo2d1VNRzlKdkZuZS9B?=
 =?utf-8?B?bkE0bTExUXVzMW4vdDdPQXNrck00eUpxRUFHK3Z1QmN6eE56bFFYYXVvdlAv?=
 =?utf-8?B?U1VnQkhKVm1Ed2V3OHcxOXdmNzdhaG1kblhJbWFUT3lTaEJ6NTFZbyt3WCta?=
 =?utf-8?B?ZStwYWlyMzN6SnJmMjNqb1lLbUZSRzBOdGg0T0VQZG1VcTBkYThYNDVtbzVi?=
 =?utf-8?B?TlFOTHRBajdwS1ZBTlZlcHdVdWRHaG5iSEFSMUxSOEMxa1lqZHN6bGp1d1li?=
 =?utf-8?B?YzJPN1lLN1NuNDVOVHhnc1ZhZ08za0xKMVZJWkdvSUE5ZC9USHg0c3FpY3py?=
 =?utf-8?B?ZXR1NDIxOVpWWDlaQ3VkMEhTcUZ6Y09BUkw5YUg4bDN5SUNMMjdOdFROT2tn?=
 =?utf-8?B?RU9XRTV3SnJmcTlLNmdCejhMNHRqUnJLeXlpSkY1eENJUGxXTDBvLzVTUGln?=
 =?utf-8?B?YU1tQ1hIUUdZL1k1UkhWUjA0WUJlamdxaTVuaXR1eldqU0RyUnFQTE1PdDJx?=
 =?utf-8?B?L3FPcFlmKzlpTjFWUTcwM1haZTJLWWM0M3QrOEpDYlJSYUZqZ3NHVXFjeDAz?=
 =?utf-8?B?bWxOcXdxNm93ZktZU2s1M1FuZXE4MHVSeWZJTmFOeXpGRmJFdCttNlRRMG9x?=
 =?utf-8?B?UWcxOEROb1BQQmw1TUlZandveVVzR3gva1ZYOU8wUlVGVFdGQ1g2VU5pMndr?=
 =?utf-8?B?SFVxUXBiazdFV2hrRlRIUE5GK1BuNTNBai9oWkduQzZ2SnB4akZLUzBFV0ZD?=
 =?utf-8?B?clhRZkJuWmxxa3p0SllGQk5ZdU05NGpjZkh4MUYxcThBaHdwaU1uT2dsVWxt?=
 =?utf-8?B?YStyZSt5UC9iZUVQTzkvM09GYXFXd082emgrREdyd0RReVRmdXROakgvZi9C?=
 =?utf-8?B?emN4bzR6OWV4TzFlOWxiSnZmN2dhRWMrUnZuNEZ4RDlSS09iR1hSNVBkMEdZ?=
 =?utf-8?B?V05GeW9PeWNMK2h6RzMrTWN5V3IrL08rNEFsQU9HMHNBZWtYTkFTL0dHOGMy?=
 =?utf-8?B?VHFYRTE5d2NxOUhqekFYS092WTRQQkFpUjY4cnowRnVEdHJoYkxCaytUNDhB?=
 =?utf-8?B?WWFJYnpoeWJGak9xWlkwM3ZhWCtoZ0VZdEQzeUFTNmtEaXpCZGg3NEtyelhx?=
 =?utf-8?B?bTQ3NUV4aTFBUGNBQmsvV21nd3QyalBULzZ4bEZjTXliTzNmZkJXb3RrdUVW?=
 =?utf-8?B?dHN6WlEyb3FJeStSRktvRUNINDBLdnhJa0dqNUE5VFQvYzg1NHhuYVhmenV0?=
 =?utf-8?B?OEhwQXlDUlBPMW9jSVora3ladUROTVdQQUIvSE9XMlIrUjVrN2VMSTM1b1k0?=
 =?utf-8?B?S0Y1YjdKdFAyTVl6YTN0Q21nRUZyNXJ6S1pteHYwZytSdlJnS2ozZnV2eXBF?=
 =?utf-8?B?SHdsZmNoSUk1ZW5wT1Jla2xLd042U3RnVW11VnMrVEVxOStsVmtsTm14ODhW?=
 =?utf-8?B?MTJieWZLWXMzNVNUUnZuUU9mTzhsUXlOU3QyVWNVRUYrZEdHWWpsb0ZFSXRh?=
 =?utf-8?B?eDNjS3lrYTdDNENsUTcvempVSDdNN3Z2RkZvY1FFdklSZ2t5Zm9Lbmsrd1dp?=
 =?utf-8?B?eHNVYXBuWGg4ZXhxMEdoK01aOHJ0amxSSndxYzAzVXl5ZFdheHFYeVNVL3dL?=
 =?utf-8?B?eUVnQVdTbU5zVEQwbmVoQmgySWxLQy9oZ2xpMFVzc2t4d0VwYzI5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdf87ee-d88d-4aef-cd86-08df2900db50
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:06:16.7867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMAdnOLiket96kQiUNbh8AgzvVzzHg2bOx1h7/svS6PTlJkvPT1oFaYYJGt8kyo1
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



On 9/30/26 14:52, Prasad Kummari wrote:
> versal_align_dma_buffer() rounds a misaligned pointer up with
> ALIGN() and memmove()s the full payload there, writing up to
> ARCH_DMA_MINALIGN-1 bytes past the end of the caller's buffer.
> 
> Allocate a separate cache-aligned bounce buffer via
> malloc_cache_aligned() and memcpy() into it instead, propagating
> -ENOMEM on allocation failure and freeing it after use.
> 
> A misaligned buffer larger than the available malloc pool now fails
> cleanly with -ENOMEM instead of silently corrupting adjacent memory
> as before an explicit, diagnosable failure is strictly preferable
> to undefined behavior that previously went unnoticed only because the
> caller's buffer happened to have trailing slack.
> 
> Fixes: 26e054c943a7 ("arm64: versal: fpga: Add PL bit stream load support")
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> ---
>   drivers/fpga/versalpl.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
Applied.
M
