Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE288C88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 12:40:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C01F405C2;
	Tue, 15 Sep 2026 12:40:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 18o6lt4hk0YO; Tue, 15 Sep 2026 12:40:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4871E405A3
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789476013;
	b=YZF7hPHY/RYqo1d3JWMOYc0Mg6bO4wJd3I2zYbhrHUng29CxPWxm1wWYhMD0iBv3CLIa
	 4dWfG1AztilOZsosMIljr+zV8wlDK0NK1CHCbgy5s9jyfrlGLKyvxMf0BpFYTTP0HW5lo
	 Ofrbm4lEpajYTE6XHVeXNIeP39CIKc5e2n5fOLCpSasZNY7yaA79XwFyMIpJc/0mgjCpT
	 NCJ4Oj9X6XsmlL3/Y6a1lb+tAXppQulgrw31sMBWMloAG3QWVO3DJoaXi1pXSI8ZQ2eOA
	 Qrh7nkNGkTe0vMSFompZ74uqp0Hfbz0MwLpjIpmujhSgyqO40XeLqJmsCc9k8Y+JLOQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476013;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:From:Autocrypt:In-Reply-To:
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
	bh=64z1ePNPpWfh/HXwX3ShRHIE4X8ZBHXns/S0QOJS5fA=;
	b=lIwDU1HX3dAzvU/GnVHfxFmF9zoGJFeDuOYBp5d7qt0Kt9EamfSFwUUjjmVYhZLj8fnO
	 FNUuTPfq8byHpTDuC0DgDlnVZXlGbW/7y/jPheJ6qU7T/6wJsp6KO9psAMJtm7P68S30O
	 CTiofFxlzjSX3I4hkB4XvDbZs+wapxDEXi+UD3nDfGMgeO3X7K5KJ54T1rHnreGs9J+Wu
	 ocvIZq45zZMUhLJMMvfi5fBjpaKVxbmjn2aujipB832tV4N5mGrkn+jRaP3r6DxaKg9zi
	 /HyjvFz2FrT9uJae6+PWthCRD4TBz3nc6lHn77H8fmGdbdTPH8/kMmEEyOzvm50vJlQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789476013;
	bh=64z1ePNPpWfh/HXwX3ShRHIE4X8ZBHXns/S0QOJS5fA=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jhwXP7Scr0w3ABlBoezv8WmebSlGFajNlgq2QK9JHPxtiRiceQYA0RjL7Lju/58wl
	 L8r6NR07DTWu/Czij/qVBcskh2W9uRoPJ32wosd0irhimrIqHe+/QVo0TKDJJp4yR0
	 xlw33NP5hY4/gzc5MVYHtvpZYRacpJeG0QhLU2hWXIOznh2ui+9LWAn2wybBSe0owE
	 Mcm66EZU34tP1oOGnzd/+vh8JAv8HwAEkIzpZOzYVT3LJ/xCZWlsR/4blcc6v6SkyF
	 FrraTuA75nlJwaLNlwmMGwgXVVsTbgmDQxExHh9DN0ky6V1FcY9B2f7CINFbT3MXZC
	 Lflu+GLj0Lkaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4871E405A3;
	Tue, 15 Sep 2026 12:40:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C9F62E3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5DC796074D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:40:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZiIFJjGyWDHt for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 12:40:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 69C15605E5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476010;
 b=byKtFWA8YzxaNa0p5ZYUNiaWKdnRIbF4oEWhwksl1Un7VSL8oZigyY4NKb5Kzu+HTV3R
 UFPaByqPxD5Tr4wNWlIDmmE8UzoE3FbhtmzUXh5ADF6vetgd48Zw2iFHvsaHU2X1uTyDE
 o1ZL/tLo2SHEG+wPdIJTCR8t9aX+1pjJRgCSJnJbw4XmXh8LPmKoVaoZJQSu1BdNasu4Z
 8VVi/n76dnNt840H1FwBbmEgcyknU1te+zStVeRI9oG7xA+Iudh2u5X7fVZPkbTQyZhLV
 uUFSaqJ9yPiqLV4Oz/VtQRHaHoTUT6+KlxBmTHPq4oG0Kd91+FMgRyn5/u1x8CjltMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476010;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=64z1ePNPpWfh/HXwX3ShRHIE4X8ZBHXns/S0QOJS5fA=;
 b=bHqPBY0Df5gRbUt8wdIekZ3YNW7gheqCvyccghCUFnZ/OpOhn6pKr4l4k1kigWB7ix+3
 FsekgkayJXFSd1b2fwORid/FAgO3XwLSX4nwRR0QU07I+uCO/VME2HbOqwIjjsA9v5odp
 3m/gwZE4gBAvtagmXQ8gHacqzKuCFA7fGSgAolCgCECcjHx84vf6N5ndNUZ9W+EGKhBbw
 UsRPOIMHI3zYxuBuhyarbUYYgjpL5PO+K6tAr2WqfuyQmmoJVyl1YMp5elVg9dPePqJt/
 3PbI2bwobJZKtLbA3w9yGQVyfq3cAQuoXmR60yd93f7p82U7o1Mk80KWlWIps59dz4w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=AJ6y+aGs; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=AJ6y+aGs
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69C15605E5
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:40:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFzCb437Ef904c4A2Sd4mGF3YqOYr+O+jVVYVEImrERBrA38QG0k1gzeGaItMvb0EbHoqeBffXyYLhceqaHABxjgvsZB+Ps9wnsqZq679xD1HU5OHlaWPg17cT3n5j9GAb73xGf7aD/3+u4xowtwQhpen/hN3fZzqEKp9TNoBS8h9Ao16pLe9hGgFM8DHliNscS9rxZzklCYs0TtJDR39bMA9iZRcFkcY7mFm4DBJf9A+/a6tNwUouLtQOntmpbsiN4bOX/XjFHG/JW+G65692bAGOSD6W7g2VE93pKq/XtJNBxoBcWss4xl53kr9pPrM2QwE3UHriyfKWFIB4V3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64z1ePNPpWfh/HXwX3ShRHIE4X8ZBHXns/S0QOJS5fA=;
 b=jFX6XuYuOfO5u/xWE+uPr7QzkWE8l8ujWc5g4ZUk/+d8y2GNOM9eOOSNsTnCW0CCmpQd77rlhu7HYRx4NyGvKILDBJeWx8yVmhWUA3W+jZIIo7kl9LXh7Usm0QPp11mPgfSzP09VwKbu2WdQJA+4uPddaNud8L27t4pzTLRfl8bMtj4bVsDry79n+Ef/wbIMmufV+8biveejE7XLvScu2ywY7XG4ycGe2QzWjocW94T1MZiKgOb4f/v93UqiGxvhKdJqpAgxBWEllDFTXJL0oaknZuIYjoVviKJHsvLhLSNag3GCvRxQKZIuo325NNamqBac1l0uUgs0EisPxItVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64z1ePNPpWfh/HXwX3ShRHIE4X8ZBHXns/S0QOJS5fA=;
 b=AJ6y+aGskX1E+9Vko63cI1mVVQ+xwTg5FEYns5NKGFmQYfHX8G85jTJdEAjPIjNwC+xwd+vz/7+v3gwIJ09vLdTD26uZnB7EdcnP5LfttgP3O4mXy9E5DyBbTjVRtSTAGZT8mR8sRXvWu7tZ4lDJX8mzsNF47R7Wh9yyxNu5k+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV9PR12MB9831.namprd12.prod.outlook.com (2603:10b6:408:2e7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 12:40:05 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 12:40:05 +0000
Message-ID: <02180985-1ad0-4b3e-a97a-5742448dfe9a@amd.com>
Date: Tue, 15 Sep 2026 14:40:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mach-zynq: Support SPL boot from QSPI in memory-mapped
 mode
To: Mike Looijmans <mike.looijmans@topic.nl>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.dbc3adc1-d306-4fa6-89c4-2074e3ea28d1@emailsignatures365.codetwo.com>
 <20260915080242.81591-1-mike.looijmans@topic.nl>
 <dde2ebd2-fc2a-4ec3-9d94-67c6e199585c@amd.com>
 <98c77671-1507-481c-810f-c662573c8d8c@topic.nl>
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
In-Reply-To: <98c77671-1507-481c-810f-c662573c8d8c@topic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:332::18) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV9PR12MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: 9918f80b-9972-41cf-0164-08df132677c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: fX+PwngMrzZQIksezrGBCzGw+li5FNLZgHXm1D13lUyeGT71XR90d5vXiIvw4nIyQnKrYU3KtxiPgkfhTJL1GMZzqQ75clmkBc+G+wuXdf7wxmXcwTVEs6phMDhdczqO2DUVbFcvX3B3NOO3v1JUzbiEBSxE/f73tp9VKu5XUIGCcBISkSiWjepx5rS+Iq7X0qpq2lSTyN0t07lYwjbJWfjB7WNUBhKusxPmjHvYYcBZGrBj/9L4t+XwfROHas+dXQ2FRdSw26mRjiiwjTkFn4G00XwRLuNVnS+bR8mjqi7FtX3ihGaZygHoxhj3t39g/cTRk9TMbspW5nB+CJkA0yRTkQ9fL/mDBtergx6et/n8kjV9YwkekA//4NOfsFbbdW6K4A3k3kc7QZTFHLjv0jF58AxAoheNPDGFlGNUzVdjKFKH8h0tcISADkPeO/vVUjRxKrlnnVsBHyk/k1/5ez2jFATICm3LhqdS32y/qe2+4z4je2RXTwyIIH0kIeiZS0sIfn5zWKFCrGo3D5z8aMYw/QmIW22LxPr/+lHs7FGPu1f1lGSACE3nFLQACWcauAab9+sG6OmjZ9/YdFiSRIaMkkMQIGPvox7tRKXewf/Z+le4ZmSsIKYA6Ds8EpkuIrnHpIQHRylBr9LsRf0PYL14JBSnkalgPGDbzM9XTy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0xkTk84OXN5SzVSS29Ga1ZNYVlhdDhUTlVkZ2FoK0JnT2pXNDVjVVJKV3Nt?=
 =?utf-8?B?ZmhiTWZBS2UrRUgwZnpsR1g1bGYxbVlabS9FQmZzVzRnMVFvaVpESngzUVI2?=
 =?utf-8?B?aEhwVVRUMHlJQ1NiV1V4UGlXQmJGNWFxS3JLWEZuem1DV05mVnh6MDRLL1Jz?=
 =?utf-8?B?b2lQN0h1UzVJZ202RU5yS0s0T1lLQWhKRlB5TkttQ2IxallGVSsrQ0grVzFV?=
 =?utf-8?B?SzBpcEZ0K2lzWnhNN3docXl5NnVscHhkRjBlcUxtUFdEYkoxWDdzV2Vud01V?=
 =?utf-8?B?RldXRHdMUEF4OGw5emhBZFRKQWdxVzc0Y2V1OXBJMEFXMXBrekhmWG5YM0tt?=
 =?utf-8?B?ODYyRnlFSUpld2JFRHY2MzlkK2lhUTFaNWtIS21WNjl4OEtqSHZPSlNJQkFL?=
 =?utf-8?B?WEErOUpNTkhxb0JVTE1tM0s2OVFSQXg5STg3a1VSYlExOW1pbnFodk1TL0lz?=
 =?utf-8?B?RVkybXY0STlUcEpjNkl1Uk9TcVJ2N0Ntd2ZXK01EQzA2S3pTL2N6UU1OZUFS?=
 =?utf-8?B?akFDeEx4YVFENkF2UCtUU1BKWG1CaHdKdk5PUW1lQ05EQWJHT2RseTM3TzZE?=
 =?utf-8?B?bmFPbkhyRzJOZ1BHNXpvOHRrUi9qRU4rS2tTRlF6N1g3WXdwZEVVV0haU1pm?=
 =?utf-8?B?REhUS3duMGdPb0huZFMxN0pLVllxeHBFS0Jpa3JxbkdyRmEzN0xOWDcvZUxO?=
 =?utf-8?B?ZEJwTXhqRHp1LytyTHB3MWVybWphdE1lLytRdWR3WEU0cjRtdFBKQWpYcVlH?=
 =?utf-8?B?VnoxQ2c4RXpKdjVJWXhzOEROVFN0SmU2dnF0L2tTUFRyRERTWTViZldIS1NJ?=
 =?utf-8?B?aG5VUnJ2U3k2dmdqK0NOeDRTMDl4bVFDbkVJb1VEODY5UVNRejFObUJRSUFw?=
 =?utf-8?B?Rm4yZWZGdzI3aGlWQk13cTJReVcxSy9CUXdjNjFjb1BqaEEvNjBFdndMYUNL?=
 =?utf-8?B?OGRya2hLLy80WFZaWHNPamZiMW1YODFpNy9xNDlOM3hMQ2VSRVcxelFRejVq?=
 =?utf-8?B?bWg2Q3kzbjBic1doei9hL0FtR0NVN0pnM3ZUYy9ZS0hvU1hwR0g1bVhzN1d0?=
 =?utf-8?B?S21OaHViLzhnSlZvMlNjNWxlWFcvUVpwOFJjYzBOajJBZXM4MjFiaFc3N2ZJ?=
 =?utf-8?B?RHVJK2RpMTNlc29IYmx4N0F5eHFpNTVib21sZ0VlRjFJaXZ2TGQ0aFVuSC9Q?=
 =?utf-8?B?ejB4QytEMUVRUFJqaUptMnZ3ZXBMak5oUmh5Zy9HZVRFRW55eGVwM0hqUXJj?=
 =?utf-8?B?LzdPOGRqZnZFOHNDcmpwZlhPYmxjUk0vN3lOZTlBZi9XRlZXTzNBa25zTk0y?=
 =?utf-8?B?S3hCM3ZvWmlQQVhrRjNZd0Fpc2VlTWlYVFkvRUsxcW1ERldWWEdZUk9VbnBR?=
 =?utf-8?B?T1ZUT1l6UWVBOCsreFNiM0FhYVB4Z0JSdmhoZTJ4RUdlUW93bzlDNVQ2NHpt?=
 =?utf-8?B?VjZhRFk5RVoxeW02TFBzc1NDa2lqVjVtVUlpQlBsR3JlMmtKNFhlN0JXY0hs?=
 =?utf-8?B?cWpiK2hhQ1hkQ3Mzc1BnUVlCcnJZdVZWZ1FMVHI1cjI2QjV6RFdIcVZiUTlF?=
 =?utf-8?B?VUZuRDZsV3lkWmYxck4zTVE5QW5IdDFDak5hVDdGUzU1V25oSDVzMDYxaUNj?=
 =?utf-8?B?MDg2Yi9KT2tZeDFSNGQ2ZnBSSEh2bXVHQWt0WnhRYUJ4NjRFVXQ0MTZyb1hv?=
 =?utf-8?B?SGlEdWU5WkZ3bmVZQ1hkSm9Gb1ZEbEN6MW1VTVA0OWY0ZzBXcHVsbDcvakYx?=
 =?utf-8?B?Z2xkTVlnc2VwaGZISktmWi82d1RCT3ZYZUlrTnViRXZIQkVoZ2FWaXJTL0J5?=
 =?utf-8?B?WW8zUGFsT2FCNktMSGNOSnpoeG9TS21UTFJTbjNzRTFkazRWTzlMSnBnOHd4?=
 =?utf-8?B?MWkzZml6QXIwRm01NkZhanNld3I3QU9PZnFENEJtMVpvWG9PNXJBSkFRZkRw?=
 =?utf-8?B?VTRtbVpvK1kxWENIYzRtSjNTb0dSa0dsbmJNbUxCNEhmdStvdFRlT1Q0Wmdv?=
 =?utf-8?B?d05yVjB4RzUwckFKZFJsSE55dlJhMElYMVM1OXpnekY0cThyTGdJVlVpbSsw?=
 =?utf-8?B?SjRDZnhqaVIyRitMcXltdlVYbnBzYWxqZ1NYbHRIUkp5UUhRZ1kxdWNPakY5?=
 =?utf-8?B?UGh0UTRXZzBPc0gxa1hRYmF6NmtYcmN3SksrbXgrbE54VjlzZXY3QjhJRjFh?=
 =?utf-8?B?WjNBaTQ4ZGJvU090c2U0cnViaWo1OFJueHJEVWxPWjR5QmJUODI4eGVZMDZk?=
 =?utf-8?B?NGVvaTZxeU54LzJrK3ZHalVrZzEyOGlZQ0FYTG1jb2dSNzFSaThkQnBQdXBH?=
 =?utf-8?Q?VqCAtdyIq+e9Z1juRD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9918f80b-9972-41cf-0164-08df132677c5
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 12:40:04.9779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OoX43fu2kuDR+L7LnehwqlhRzbJjDtKQ+68/6J07xlqyn5DorPeYiwD8VWXjotu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9831
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



On 9/15/26 14:25, Mike Looijmans wrote:
> On 15-09-2026 12:10, Michal Simek wrote:
>> Hi Mike,
>>
>> you are sending email to
>> u-boot@lists.denx.de
>>
>> but you should be sending it here.
>> u-boot@lists.u-boot-project.org
> 
> Hmm, must be some "patman" configuration thing, I'll look into it. I'm just 
> using "patman send -c 1" to submit the patch.

Check your .patman  settings.

> 
> 
>>
>> On 9/15/26 10:02, Mike Looijmans wrote:
>>> When the Zynq boots from QSPI NOR flash, the ROM will have set up the
>>> QSPI NOR in linear mode, and the contents are now memory mapped (the first
>>> 16MB/32MB at least). All that needs to be done at this stage is to memcpy
>>> the u-boot code into DDR RAM. This is not only extremely simple, it's also
>>> the fastest method to read QSPI flash on this platform.
>>> This corresponds to a standard NOR boot, hence this mode is selected as
>>> SPL_NOR_SUPPORT.
>>>
>>> Add a menu choice to select which method to use.
>>>
>>> To boot from QSPI NOR, write "boot.bin" to offset 0 and write "u-boot.img"
>>> to offset CONFIG_SPL_PAD_TO in the flash. Usually CONFIG_SPL_PAD_TO will
>>> be 0x20000 as the SPL code easily fits in 128k. The offset must fit in the
>>> accessible range for linear mode, which is 16MB for single and 32MB for
>>> the dual chip modes.
>>>
>>
>> Also say that this limit is not checked yet.
> 
> ok
> 
> 
>>
>>> Tested on topic_miami boards.
>>>
>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>> ---
>>>
>>> Changes in v3:
>>> Make the QSPI NOR mode a menu choice as suggested by Michal Simek
>>> Obtain payload offset from device-tree config in spl_nor_get_uboot_base()
>>>
>>> Changes in v2:
>>> Reworded and amended commit text
>>> Add #define for magic QSPI linear mode address
>>> Use old method by default, use SPL_NOR_SUPPORT to switch to mmap
>>>
>>>   arch/arm/Kconfig              |  4 ----
>>>   arch/arm/mach-zynq/Kconfig    | 34 ++++++++++++++++++++++++++++++----
>>>   arch/arm/mach-zynq/spl.c      | 22 +++++++++++++++++++++-
>>>   include/configs/zynq-common.h |  3 +++
>>>   4 files changed, 54 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index 514bf2000b4..fa965125e80 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -1346,8 +1346,6 @@ config ARCH_ZYNQ
>>>       select SPL_SOC_INIT if SPL
>>>       select SPL_CLK if SPL
>>>       select SPL_DM if SPL
>>> -    select SPL_DM_SPI if SPL
>>> -    select SPL_DM_SPI_FLASH if SPL
>>>       select SPL_OF_CONTROL if SPL
>>>       select SPL_SEPARATE_BSS if SPL
>>>       select SPL_TIMER if SPL

This zynq-7000

>>> @@ -1398,8 +1396,6 @@ config ARCH_ZYNQMP
>>>       imply SPL_LIBGENERIC_SUPPORT if SPL
>>>       imply SPL_MMC if SPL && MMC_SDHCI_ZYNQ
>>>       imply SPL_SERIAL if SPL
>>> -    imply SPL_SPI if SPL && ZYNQ_QSPI
>>> -    imply SPL_SPI_FLASH_SUPPORT if SPL && ZYNQ_QSPI
>>
>> Did you test it on ZynqMP too?
> 
> No, ARCH_ZYNQ is just the 7-series? Or does ARCH_ZYNQMP imply ARCH_ZYNQ as well?

This Zynq MPSoC Ultrascale+ - ZynqMP.

zynq is a9s
zynqmp is a53s

> (unrelated side note, I'd love to get SPL working with the ZynqMP again, and 
> avoid the FSBL)

It should be working.


> 
>>
>>>       select SPL_SEPARATE_BSS if SPL
>>>       select SUPPORT_SPL
>>>       imply ZYNQMP_IPI if DM_MAILBOX
>>> diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
>>> index c3f505fa15c..6167f5e51b4 100644
>>> --- a/arch/arm/mach-zynq/Kconfig
>>> +++ b/arch/arm/mach-zynq/Kconfig
>>> @@ -18,11 +18,37 @@ config SPL_MMC
>>>   config SPL_SERIAL
>>>       default y
>>>   -config SPL_SPI_FLASH_SUPPORT
>>> -    default y if ZYNQ_QSPI
>>> +choice
>>> +    prompt "SPL QSPI boot access method"
>>> +    depends on SPL && ZYNQ_QSPI
>>
>>
>> Likely not.
> 
> Again, this is mach-zynq, so I'd expect 7-series only?
> 

ZYNQ_QSPI means Zynq-7000

> 
>>
>>> +    default ZYNQ_SPL_QSPI_DM_SPI
>>> +    help
>>> +      Select how to load u-boot.img (U-Boot proper) into memory from the SPL
>>> +      loader when QSPI is the boot device.
>>> +
>>> +config ZYNQ_SPL_QSPI_DM_SPI
>>> +    bool "DM SPI-NOR framework"
>>> +    select SPL_DM_SPI
>>> +    select SPL_DM_SPI_FLASH
>>> +    select SPL_SPI
>>> +    select SPL_SPI_FLASH_SUPPORT
>>> +    help
>>> +      Use the SPI-NOR drivers to transfer U-Boot proper into main memory
>>> +      from the QSPI flash.
>>> +
>>> +config ZYNQ_SPL_QSPI_MMAP
>>> +    bool "Memory-mapped linear (NOR) mode"
>>> +    select SPL_NOR_SUPPORT
>>> +    help
>>> +      When the Zynq boots from QSPI NOR flash, the ROM will have set up the
>>> +      QSPI NOR in linear mode. This option just uses memcpy to transfer
>>> +      U-Boot proper into main memory. This reduces the SPL size by about 12k
>>> +      and is the fastest boot method. For this to work, u-boot.img must be
>>> +      within the first 16MB at offset CONFIG_SPL_PAD_TO, or config value
>>> +      "u-boot,spl-payload-offset" in the device-tree.
>>> +
>>> +endchoice
>>>   -config SPL_SPI
>>> -    default y if ZYNQ_QSPI
>>>     config ZYNQ_DDRC_INIT
>>>       bool "Zynq DDRC initialization"
>>> diff --git a/arch/arm/mach-zynq/spl.c b/arch/arm/mach-zynq/spl.c
>>> index dc964dc2f9f..534374078cb 100644
>>> --- a/arch/arm/mach-zynq/spl.c
>>> +++ b/arch/arm/mach-zynq/spl.c
>>> @@ -15,6 +15,8 @@
>>>   #include <asm/arch/sys_proto.h>
>>>   #include <asm/arch/ps7_init_gpl.h>
>>>   +#include <dm/ofnode.h>
>>> +
>>>   #if defined(CONFIG_DEBUG_UART_BOARD_INIT)
>>>   void board_debug_uart_init(void)
>>>   {
>>> @@ -42,12 +44,30 @@ void spl_soc_init(void)
>>>   }
>>>   #endif
>>>   +#ifdef CONFIG_SPL_NOR_SUPPORT
>>> +unsigned long spl_nor_get_uboot_base(void)
>>> +{
>>> +    int payload_offs = CONFIG_SPL_PAD_TO;
>>> +
>>> +    if (CONFIG_IS_ENABLED(OF_REAL)) {
>>> +        payload_offs = ofnode_conf_read_int("u-boot,spl-payload-offset",
>>> +                            payload_offs);
>>
>> doc/device-tree-bindings/config.txt
>>
>> u-boot,spl-payload-offset (int)
>>         If present (and SPL is controlled by the device-tree), this allows
>>         to override the CONFIG_SYS_SPI_U_BOOT_OFFS setting using a value
>>         from the device-tree.
>>
>> you need to update it's description because this if for NOR not for SPI.
> 
> Yeah, things get murky here. The boot MEDIA is SPI, but the boot METHOD is NOR...
> 
> I wanted to use "CONFIG_SYS_SPI_U_BOOT_OFFS" but that gets removed when SPL_SPI 
> is not selected.

Just update that description.

> 
> 
>>
>>> +    }
>>> +
>>> +    return ZYNQ_QSPI0_LINEAR_ADDR + payload_offs;
>>> +}
>>> +#endif
>>> +
>>>   u32 spl_boot_device(void)
>>>   {
>>>       u32 mode;
>>>         switch ((zynq_slcr_get_boot_mode()) & ZYNQ_BM_MASK) {
>>> -#ifdef CONFIG_SPL_SPI
>>> +#ifdef CONFIG_SPL_NOR_SUPPORT
>>> +    case ZYNQ_BM_QSPI:
>>> +        mode = BOOT_DEVICE_NOR;
>>> +        break;
>>> +#elif CONFIG_SPL_SPI
>>
>> I think you should do
>>
>> #if CONFIG_SPL_SPI
>>
>> #elif CONFIG_SPL_NOR_SUPPORT
>>
>> It will be clear that you need to disable SPL_SPI to get to NOR support.
>> Also diff will have one line less.
> 
> Yeah, and touching SPI in any way will stop the mmap mode from working.
> 
> I'll have to add Kconfig things to make that explicit.

When you select SPL_NOR_SUPPORT you can have SPL_SPI disabled. What's the problem?


> 
>>
>>>       case ZYNQ_BM_QSPI:
>>>           mode = BOOT_DEVICE_SPI;
>>>           break;
>>> diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common.h
>>> index 94273d0deb9..4e14c74e31f 100644
>>> --- a/include/configs/zynq-common.h
>>> +++ b/include/configs/zynq-common.h
>>> @@ -35,6 +35,9 @@
>>>   /* Ethernet driver */
>>>     /* NOR */
>>> +/* Load address is mmap address of QSPI flash, plus the offset */
>>> +#define ZYNQ_QSPI0_LINEAR_ADDR    0xfc000000
>>> +#define CFG_SYS_UBOOT_BASE    (ZYNQ_QSPI0_LINEAR_ADDR + CONFIG_SPL_PAD_TO)
>>
>> did you test also XIP? If not, please add a note to commit message that XIP is 
>> not tested because this macro is used for XIP too.
> 
> I'll remove it, it's not actually being used now that I'm 
> overriding spl_nor_get_uboot_base(). And find a better spot for 
> the ZYNQ_QSPI0_LINEAR_ADDR define.

You can't remove it because weak function is rewritten but still symbol has to 
be defined.

> One cannot really use XIP here, because it will break if you touch the QSPI 
> controller. And if you're booting from QSPI, chances are that you want to use 
> the QSPI flash for more than just the bootloader.
Just describe it.

Thanks,
Michal


