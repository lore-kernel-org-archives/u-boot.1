Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4B9606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OchbWccS;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OJx4NZnA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9113F40902;
	Wed, 11 Nov 2026 07:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J7Z2orv5TWzH; Wed, 11 Nov 2026 07:13:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB37C409A1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794381201;
	b=KhgJzDpIRRip1SzCH5Jb2dOc2FL8+hcgOIPtraku4oRzBNS1du4sqoaOVzH4mL3OfcBS
	 zIlUfNSro6WqqbABQR+CgiYGSYp1gGpy1GaX26g3ngK8hPxBhdpRzJHiTuTgIizbQ5y0b
	 Pe0vQOQ9n2mAlQsz7U3Cb6JAKTYoOH91QYM+JFhbmJCf+UI3PYOnbgucaMCIBGVHUF8b9
	 B+IF3mEXFAtBpNN4WC/HfeWVhJ0vDJ4DFQOGPuXiXcWLVqadQcnSXC2R/MWCPDLWII91X
	 52cgsyMEVdNjUA3LsnyFdLZ1VTgfNRSdsRO4TQUSUhDq8eS4EAWnJR3/0TP+YwOwmBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794381201;
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
	bh=Ywmbsts3sG1kOJAuqO3B7xdKO1SUlu4GF+fakx0rhv4=;
	b=Q2FQrXnBzwll2dYnmaJ8LBg8iG/xVyqUxIcoHOYeNLl2schyQqtv16BSIZG25jJX6pxX
	 UFJeaXExY4YhsqF/a4iAamM3Ykp5WOw8ALW8g62Fq4f1YVil0Z44ocj9bsqGsd3YN4bLv
	 CRMVdd5+nDuLJAwQzGZUElmyuyE1UvrryWyrlXVwSbUifUVUxfxIA6UnE10boTZbKQO/i
	 T4uVcv9owX0V9rucfitPcD0ZnE41lY+sD7dONWRRaxmMlc1xgVB/jZ2lseYmmHcpAjs+j
	 tGcHBZt+MU74+3bFVqRABhlFHMqCajOuEcaultaDBBpto/Zu+4sirdX/c0qwYmiAu1A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794381201;
	bh=Ywmbsts3sG1kOJAuqO3B7xdKO1SUlu4GF+fakx0rhv4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OchbWccSpJtpcNq0VhZXoShDhGWOoSbEVuoNq/Wx2tnw1sSvqiQHX1/UjahiJXzMf
	 9LZEWkrS0l5QoKxnMf3uCKOQmzxzWIjQKMbf0dqqc0+lRiwuwMWkvUexE1f3S+4JVw
	 jnHcaukolLnt1r4oaVOtTaIsQGOr4C2sNzWpe7nyeCtKwOf+2NdmG7fDfj43ollUoK
	 qDXBvid23n1ywi0SV7uWzCbEeN6ymXubN7JEYH7PtKx1NW0SO/xtR1zr4qrl6pPwcr
	 Zp86orLQI6wEekN+xIf2Y1KXTIlPfuBuMmIv++RndsUQRh2CkzUDanzso5C7XGGzKC
	 K8cyEURyrN9UA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB37C409A1;
	Wed, 11 Nov 2026 07:13:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EC9DE2FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 07:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D23AF6078E
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 07:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sAKtx6_9sSca for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 07:13:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0F280606C9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=OJx4NZnA
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F280606C9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 07:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ywmbsts3sG1kOJAuqO3B7xdKO1SUlu4GF+fakx0rhv4=;
 b=OJx4NZnA62vaflbrJ19YJ8ZMsqL9b0QIKxRvToZL0GIOq92UocXLB4pIkCBsXRhQzTpNi0PQccGn63Bwaz4wtWrUhnJAQJ7wiXv5xuzwoSkgA3Rs7kMgib4Fg+nIoPyJsa5aDQ7CZi/RjFFyYLOmyis1exmN5TA2Wkf1ki5FBsk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by IA0PPFA19DE7612.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:13:12 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 07:13:12 +0000
Message-ID: <0c28caab-496d-4114-8739-ae85be9aa031@amd.com>
Date: Wed, 11 Nov 2026 08:13:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/30] usb: dwc3: part 2, make the resynced code work
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, lukma@nabladev.com,
 alchark@flipper.net, jerome.forissier@arm.com, dlechner@baylibre.com,
 anshuld@ti.com, sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 mkorpershoek@kernel.org, love.kumar@amd.com, quentin.schulz@cherry.de,
 s-vadapalli@ti.com, Anders Roxell <anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
 <205058d0-f257-49ce-be85-19c44bc6c5a7@mailbox.org>
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
In-Reply-To: <205058d0-f257-49ce-be85-19c44bc6c5a7@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0204.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::29) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|IA0PPFA19DE7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 63243a91-e42e-404c-4dde-08df3fc33f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|6133799003|10067099003|261026140227099003|261102123227099003|261022105027099003|261021121427099003|261026121527099003|261028144727099003|3023799007;
X-Microsoft-Antispam-Message-Info: UPjrtO8eO+d5BLth981ozB2M2tC9fe5nD6mBWM9ww1RyRFEsWSAD3yWOQGtrce1n4lUM+sGVGSwvGemNrs45n5bQGaSBl7Iz17vBw+palru03UvLbgCem6Ui1DaEXuvkNjfCMfYZzpAGrUJrwCwbam9tFHSgfzsycjkGk5SYErDVZJpbCy9pnJ6nh+0A6TyaopjTyZmNI2+bLCMww/KPcpAYNYf0a1pqne9SLlIg/zsaiYdUhaZ0HaN+ynee/VHk6EJKY5UGspc+HJtcLjyV9zGBxQeVzJMuYQRutNNLuRaIDhFIvshuH+RkYxx/rinu0/uc0HNi6MdnkRUmZvFdoZcJoqCndgazpRazTizVLEDHiZkPa7m8nkORKID8ziK2GdFX4RlMoS73OfeZ5X8RKLCt0PJhSfCulXfI0ML2A8Tgqr3RsXLUsTT0/poA6+LatQGHrRVpxmKJwJSwpaDNn+1jGQ/louEN7Mj6wZ2Ys5Yff3GEAxJPT88OQ2LC4ERVdzR1shXPWljKCmYpkqmsVDnicoVfVcilN0Tq6YKP3Oy+1bz1F6iyitBbb746gPpw4HcVSzcBF7IzX4qRf/BKkqV6d0YhFVrgTRxjcxUTeBdVrtki12I+l8xiVLxqNESxwCu8dcLs/ClNzVg3g6RNWxtWO7nBbyUyCDEERXSDxGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(10067099003)(261026140227099003)(261102123227099003)(261022105027099003)(261021121427099003)(261026121527099003)(261028144727099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUZ1bXRHL3NzRHJLVzRnUnBMSFF4aFJ2T1JHeWpCeVorMVd2ZlRXOFVDSGFQ?=
 =?utf-8?B?Y1hBa3RBWkVTaDJ0c0Y2bHNkVys3a1VBRHVheFdtbno4Z1h3bDlNbW9FeWJ1?=
 =?utf-8?B?ZGZTelduMXBCSkl2dW01SGgzRmtMNE9pUGlLWFdMUW56dVkxWXJDdXo2T1NN?=
 =?utf-8?B?azk1MTBuTDllMVFPdCtlMXpjSVZzWXBkREFFTFdvc1pwNzFyNFdSYjlxZFVM?=
 =?utf-8?B?L1FCSU94WGoyTDdaNml6MUhONTY0Y1pkdW5BMXhnNjlyNW5XR2lrTVJRMVo4?=
 =?utf-8?B?RWNld1BzRGJNU1l2Ty9JdS9UZkNwOEllVzdUcTVENlNjcEpyRXozeFFTbHZ6?=
 =?utf-8?B?NUdCUElqMDgvd1ZvN3BESHdMR3ZGTEVCakl0Qklidmt5YTFBNklOTGFTalJB?=
 =?utf-8?B?MDJCWE8weDd5c2dXekVLa1ZoOVB5Y2UrU0x2SDZtdFJKV3gzcFdGZDZ4dzFE?=
 =?utf-8?B?LzVJTHZEZ1IyNnRHVDB2bDdHWnpQUi94cmUyN09hakNkdWtIamRISmFjYTg2?=
 =?utf-8?B?aE5mcXVsUzNzZVRIOEhaRG5IbHV5TC9vQTBDc1NHWi9rakVvcFRtU3V5OWJJ?=
 =?utf-8?B?N0hCSWRsOXdwaTZxTHg3YkRtc2hYTTRFckpCcWVwdGRkam1TdHhZbHVoWm5t?=
 =?utf-8?B?RGs3a0N1VXcrUmkwRklyWG5OUjFsd2ptVmJpNVRMbm5VQUVyNWFFRjVxY1BZ?=
 =?utf-8?B?Y3JCZTR3QWhYQ042UVZFeW9uSC9UWVgvUCs3SHpOWkwxRjBUTWNrWnpWb294?=
 =?utf-8?B?bnBSRWY4ZXlnOGtweVRzdnZoUW5zN0hSVE5nZGdoNzJ4SFRaSFpsS29BUVNG?=
 =?utf-8?B?KzYvdVluZ0RtdW9yMlFsZkMxdm9VWWdIODRaTUs4U0g4U0xPQUtsMGliK3By?=
 =?utf-8?B?a0FCa2Z6bUQzbmlCSjRFa2FlZ21hZ1ZPa1NkVHBNYSt2OVgrc0NXSnJCUEd5?=
 =?utf-8?B?MG5KMWczNmNqdEZtdXNEYUNUV2pQRDRjdHpsdkoyRHk4NGx4WjE1VElxNG1L?=
 =?utf-8?B?d1k1bXBaNGpacGswa2xEd21yY0pPaGs5RTl4Z0tzc2Q3SFpJWW55OFdSZVMv?=
 =?utf-8?B?aHZLT0FyOUZUZlRKUyt3RFhsRTIwbHQ3N2c2am5xTkt6OTJmWllPQ1dndEtD?=
 =?utf-8?B?UkJ4V3RYY3hhNXdRdUxuUENEUmFwZ3JJN1ZPY0xmMy95SWtDTm9xVDZialdT?=
 =?utf-8?B?SnFTa1dmRnc4d01IRE5MWlo1ams4MjVSN3VnWFZka1JtTjN6TEJOYjNSMVFT?=
 =?utf-8?B?QUJteHRUTEg0cFowVWlzZnlPTXZqMTBobldQOVRudElOVDRKR0g3U3dCUVMx?=
 =?utf-8?B?WXFUNWFqVnUwWXlNWWNXUG9IRGFoS2lLVEQrK2VoWVhML0dwNmlYQmI4NlE2?=
 =?utf-8?B?dXJpRThMNmRWR2FPekNBU1BwRFhsWmhNajFzSnNNNnNlb3NwZnNLUmRTenBx?=
 =?utf-8?B?V1g2Vys0Z3A4MjBYaStKTFBBOHNQMDRFYW00RTRQMlhYQm5KTEZOalltWVpz?=
 =?utf-8?B?VURQejdPbS9ETklsTzJ2V3JIS3NrQXYva1kxdExMUDI5YlY2KzZMUW0zdTJU?=
 =?utf-8?B?OUpEMEorOUxiNUhiMnlMY3V2S0dTR09iK2tkWHdSbENIc0JNbWNMSURZOVpQ?=
 =?utf-8?B?VjNZMkZKOW1ueVZhOW1QeGZpQ09tbTJXWEhzZ0tWU01RVndMNEY2cDcvdXlR?=
 =?utf-8?B?UWJkNzZnbVB1TFVacnVRNGVRWXBTMWh1SjArSm5leFBrbFpGOTQ5ZlRENGRx?=
 =?utf-8?B?WTcrRHRqQzNDNGFhOHpzTmhYcEZkNXFWNWRiWm1CWXNiZ0syMVRuaFZtT1lQ?=
 =?utf-8?B?S0ZacmphYkE2U1VDZTRleEQ1UVBjVFJxYldPWll4UEFaNVFOR1hSbC84RkFn?=
 =?utf-8?B?WFVkb1JlQzdJOFI0Q1pGd1VweWdyWm0xdmZGc0lIazZQczRnWGZKODFudGI4?=
 =?utf-8?B?T0hEZzQ2eUpla1I3T1NuMFNNbytaNlFpRS9hdXUzNjFWWkxJZ1cwdWF4MkNh?=
 =?utf-8?B?S2JrR2swOVVZczFRdUVlZzRTRWkrN3ByMUpSK1UxajhrYXcyb1U1SWk4MjBL?=
 =?utf-8?B?U2RCMEg5eWl1MDd4b2UzN0N2SDh0YVlXd0QwVlhoZ01RWTBZWHNPRnNZOVNE?=
 =?utf-8?B?b3NqOHZHbzJrTEVSa2w4Z3QyL0dHTmJ2WTBZd3M4OEY3RHBTVUpQZHdzaDZX?=
 =?utf-8?B?alJhUVpBeVp6dUVlcFBxQ1lXdk5kYWtUQVBpMG44TzNIbmNOZ1lYaWJnZ2Mw?=
 =?utf-8?B?VlFPQUp0bWRWL0F6b3lkNHhPd2pPMjdmSy9jM0hJQS9WdjNnSVNEK095Qk0x?=
 =?utf-8?Q?OsvraTRzUwm70pAjOO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63243a91-e42e-404c-4dde-08df3fc33f2d
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:13:12.3226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jP71mtR0nMuTKIlu/tf5rqqoI8XAp8ybkdStCvneJvgcZctFiLm5l4VhX4yhGOMr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA19DE7612
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/10/26 16:18, Marek Vasut wrote:
> On 11/7/26 8:21 AM, Anders Roxell wrote:
> 
> Hello everyone,
> 
>> This is part two of two. It applies on top of part one [1], which resets
>> the DWC3 driver and imports it up to Linux v6.16. Part one alone breaks
>> the build for every board that enables DWC3. This part adds back the
>> U-Boot glue, the XHCI and UDC updates and the build fixes, so the tree
>> builds and the gadget works again. It builds on Jerome's work [2].
>>
>> The two parts have to go in together. Part one did not change, so I do
>> not resend it. The v10 patches [1] still apply on ab4dc5aacf95.
>>
>> The resynced epautoconf matches endpoints on their caps field instead of
>> on their name. Five UDC drivers never filled that in, so each one gets a
>> patch next to its other fixup: at91_udc, atmel_usba_udc, ci_udc, musb-new
>> and mtu3. With those and dwc2, every UDC driver in the tree sets caps.
>>
>> Build tested one board per driver: every DWC3 glue layer in the tree,
>> dwc3 on riscv (spacemit_k1), RK3588 and RK3399, dwc2 with and without
>> DM_USB_GADGET, at91_udc, atmel_usba_udc, ci_udc with SPL SDP, musb-new
>> on sunxi and in the am335x_evm SPL, and mtu3. 24 boards, no warnings.
>>
>> Ilias found a few bisect gaps, so I built eight of the boards at every
>> patch. Gadget configs build again from patch 20, the other UDC drivers
>> from their own fixup patch.
>>
>> Tested on hardware with v10, per vendor:
>>
>> - AMD/Xilinx: Love tested and sent a Tested-by.
>> - TI: DFU and ums on BeagleBoard-X15 (me), and on AM62p and BeaglePlay
>>    (Anshul).
>> - NXP: ci_udc with ums on an i.MX93 board (me).
>> - Amlogic: gadget and host on Khadas VIM3 (Mattijs).
>> - Rockchip: host on RK3399 Puma, same as master (Quentin). RK3588
>>    Tiger had two regressions, see below.
>>
>> Tested on hardware with v11:
>>
>> - NXP: ci_udc with ums on i.MX93, chainloaded from the vendor U-Boot.
>>    Three ums rounds, the host read 64 MiB each time. It needs usbotg1 in
>>    peripheral mode.
>> - TI: dwc3 ums on BeagleBoard-X15, the host enumerates it at high
>>    speed. That is where I found the event buffer bug in patch 15.
>> - Rockchip: host on RK3399 Puma and RK3588 Tiger (Quentin). The two
>>    Tiger regressions from v10 are gone, and he sent a Tested-by:
>>
>>    Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3399 Puma 
>> usbdrd_dwc3_1
>>    Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger 
>> usb_host1_xhci + usb_host2_xhci
>> - Rockchip: host and gadget on RK3576, a Flipper One and an RK3576 EVB1
>>    (Alexey). No regressions against master, and he sent a Tested-by:
>>
>>    Tested-by: Alexey Charkov <alchark@flipper.net> # Rockchip RK3576
>>
>> The rest is build tested only.
> I would like to move this series forward, so let me get input on the status. 
> Below are the vendors which use DWC3 core that I could find in tree, can I get a 
> go/no-go on this series from each of you ? I hope the CC is complete, if not, 
> please add the missing people.
> 
> allwinner
> altera
> amlogic
> apple
> broadcom
> exynos
> freescale
> microchip
> qcom
> rockchip
> socionext
> st
> ti
> xilinx
Go from AMD/Xilinx side.

Thanks,
Michal

